#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_audio;
#using scripts/zm/_util;
#using scripts/shared/trigger_shared;
#using scripts/shared/system_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/callbacks_shared;
#using scripts/codescripts/struct;

#namespace zm_jump_pad;

// Namespace zm_jump_pad
// Params 0, eflags: 0x2
// Checksum 0xa55288, Offset: 0x210
// Size: 0x34
function function_2dc19561() {
    system::register("zm_jump_pad", &__init__, undefined, undefined);
}

// Namespace zm_jump_pad
// Params 0, eflags: 0x0
// Checksum 0x28cd7afd, Offset: 0x250
// Size: 0x1c
function __init__() {
    level jump_pad_init();
}

// Namespace zm_jump_pad
// Params 0, eflags: 0x0
// Checksum 0x53ab579b, Offset: 0x278
// Size: 0x194
function jump_pad_init() {
    level._jump_pad_override = [];
    jump_pad_triggers = getentarray("trig_jump_pad", "targetname");
    if (!isdefined(jump_pad_triggers)) {
        return;
    }
    for (i = 0; i < jump_pad_triggers.size; i++) {
        jump_pad_triggers[i].start = struct::get(jump_pad_triggers[i].target, "targetname");
        jump_pad_triggers[i].destination = struct::get_array(jump_pad_triggers[i].start.target, "targetname");
        if (isdefined(jump_pad_triggers[i].script_string)) {
            jump_pad_triggers[i].overrides = strtok(jump_pad_triggers[i].script_string, ",");
        }
        jump_pad_triggers[i] thread jump_pad_think();
    }
    callback::on_connect(&jump_pad_player_variables);
}

// Namespace zm_jump_pad
// Params 0, eflags: 0x0
// Checksum 0x7e8e3335, Offset: 0x418
// Size: 0x1c
function jump_pad_player_variables() {
    self._padded = 0;
    self.lander = 0;
}

// Namespace zm_jump_pad
// Params 0, eflags: 0x0
// Checksum 0x16564bea, Offset: 0x440
// Size: 0x180
function jump_pad_think() {
    self endon(#"destroyed");
    end_point = undefined;
    start_point = undefined;
    z_velocity = undefined;
    z_dist = undefined;
    fling_this_way = undefined;
    jump_time = undefined;
    world_gravity = getdvarint("bg_gravity");
    gravity_pulls = -13.3;
    top_velocity_sq = 810000;
    forward_scaling = 1;
    if (isdefined(self.script_flag_wait)) {
        if (!isdefined(level.flag[self.script_flag_wait])) {
            level flag::init(self.script_flag_wait);
        }
        level flag::wait_till(self.script_flag_wait);
    }
    while (isdefined(self)) {
        who = self waittill(#"trigger");
        if (isplayer(who)) {
            self thread delayed_jump_pad_start(who);
        }
    }
}

// Namespace zm_jump_pad
// Params 1, eflags: 0x0
// Checksum 0xf14e5c61, Offset: 0x5c8
// Size: 0x64
function delayed_jump_pad_start(who) {
    wait(0.5);
    if (who istouching(self)) {
        self thread trigger::function_thread(who, &jump_pad_start, &jump_pad_cancel);
    }
}

// Namespace zm_jump_pad
// Params 2, eflags: 0x0
// Checksum 0xf24ace13, Offset: 0x638
// Size: 0xc5c
function jump_pad_start(ent_player, endon_condition) {
    self endon(#"endon_condition");
    ent_player endon(#"left_jump_pad");
    ent_player endon(#"death");
    ent_player endon(#"disconnect");
    end_point = undefined;
    start_point = undefined;
    z_velocity = undefined;
    z_dist = undefined;
    fling_this_way = undefined;
    jump_time = undefined;
    world_gravity = getdvarint("bg_gravity");
    gravity_pulls = -13.3;
    top_velocity_sq = 810000;
    forward_scaling = 1;
    start_point = self.start;
    if (isdefined(self.name)) {
        self._action_overrides = strtok(self.name, ",");
        if (isdefined(self._action_overrides)) {
            for (i = 0; i < self._action_overrides.size; i++) {
                ent_player jump_pad_player_overrides(self._action_overrides[i]);
            }
        }
    }
    if (isdefined(self.script_wait)) {
        if (self.script_wait < 1) {
            self playsound("evt_jump_pad_charge_short");
        } else {
            self playsound("evt_jump_pad_charge");
        }
        wait(self.script_wait);
    } else {
        self playsound("evt_jump_pad_charge");
        wait(1);
    }
    if (isdefined(self.script_parameters) && isdefined(level._jump_pad_override[self.script_parameters])) {
        end_point = self [[ level._jump_pad_override[self.script_parameters] ]](ent_player);
    }
    if (!isdefined(end_point)) {
        end_point = self.destination[randomint(self.destination.size)];
    }
    /#
        if (getdvarint("<unknown string>")) {
            line(start_point.origin, end_point.origin, (1, 1, 0), 1, 1, 500);
            sphere(start_point.origin, 12, (0, 1, 0), 1, 1, 12, 500);
            sphere(end_point.origin, 12, (1, 0, 0), 1, 1, 12, 500);
        }
    #/
    if (isdefined(self.script_string) && isdefined(level._jump_pad_override[self.script_string])) {
        info_array = self [[ level._jump_pad_override[self.script_string] ]](start_point, end_point);
        fling_this_way = info_array[0];
        jump_time = info_array[1];
    } else {
        end_spot = end_point.origin;
        if (!(isdefined(self.script_airspeed) && self.script_airspeed)) {
            rand_end = (randomfloatrange(-1, 1), randomfloatrange(-1, 1), 0);
            rand_scale = randomint(100);
            rand_spot = vectorscale(rand_end, rand_scale);
            end_spot = end_point.origin + rand_spot;
        }
        pad_dist = distance(start_point.origin, end_spot);
        z_dist = end_spot[2] - start_point.origin[2];
        jump_velocity = end_spot - start_point.origin;
        if (z_dist > 40 && z_dist < -121) {
            z_dist *= 2.5;
            forward_scaling = 1.1;
            /#
                if (getdvarint("<unknown string>")) {
                    if (getdvarstring("<unknown string>") != "<unknown string>") {
                        z_dist *= getdvarfloat("<unknown string>");
                    }
                    if (getdvarstring("<unknown string>") != "<unknown string>") {
                        forward_scaling = getdvarfloat("<unknown string>");
                    }
                }
            #/
        } else if (z_dist >= -121) {
            z_dist *= 2.7;
            forward_scaling = 1.3;
            /#
                if (getdvarint("<unknown string>")) {
                    if (getdvarstring("<unknown string>") != "<unknown string>") {
                        z_dist *= getdvarfloat("<unknown string>");
                    }
                    if (getdvarstring("<unknown string>") != "<unknown string>") {
                        forward_scaling = getdvarfloat("<unknown string>");
                    }
                }
            #/
        } else if (z_dist < 0) {
            z_dist *= 2.4;
            forward_scaling = 1;
            /#
                if (getdvarint("<unknown string>")) {
                    if (getdvarstring("<unknown string>") != "<unknown string>") {
                        z_dist *= getdvarfloat("<unknown string>");
                    }
                    if (getdvarstring("<unknown string>") != "<unknown string>") {
                        forward_scaling = getdvarfloat("<unknown string>");
                    }
                }
            #/
        }
        n_reduction = 0.0015;
        /#
            if (getdvarfloat("<unknown string>") > 0) {
                n_reduction = getdvarfloat("<unknown string>");
            }
        #/
        z_velocity = n_reduction * 2 * z_dist * world_gravity;
        if (z_velocity < 0) {
            z_velocity *= -1;
        }
        if (z_dist < 0) {
            z_dist *= -1;
        }
        jump_time = sqrt(2 * pad_dist / world_gravity);
        jump_time_2 = sqrt(2 * z_dist / world_gravity);
        jump_time += jump_time_2;
        if (jump_time < 0) {
            jump_time *= -1;
        }
        x = jump_velocity[0] * forward_scaling / jump_time;
        y = jump_velocity[1] * forward_scaling / jump_time;
        z = z_velocity / jump_time;
        fling_this_way = (x, y, z);
    }
    if (isdefined(end_point.target)) {
        poi_spot = struct::get(end_point.target, "targetname");
    } else {
        poi_spot = end_point;
    }
    if (!isdefined(self.script_index)) {
        ent_player.script_index = undefined;
    } else {
        ent_player.script_index = self.script_index;
    }
    if (isdefined(self.script_start) && self.script_start == 1) {
        if (!(isdefined(ent_player._padded) && ent_player._padded) && ent_player isonground()) {
            self playsound("evt_jump_pad_launch");
            if (isdefined(level.var_e406dc3d)) {
                self [[ level.var_e406dc3d ]]();
            } else {
                playfx(level._effect["jump_pad_jump"], self.origin);
            }
            ent_player thread jump_pad_move(fling_this_way, jump_time, poi_spot, self);
            if (isdefined(self.script_label)) {
                level notify(self.script_label);
            }
            return;
        }
    } else if (ent_player isonground() && !(isdefined(ent_player._padded) && ent_player._padded)) {
        self playsound("evt_jump_pad_launch");
        if (isdefined(level.var_e406dc3d)) {
            self [[ level.var_e406dc3d ]]();
        } else {
            playfx(level._effect["jump_pad_jump"], self.origin);
        }
        ent_player thread jump_pad_move(fling_this_way, jump_time, poi_spot, self);
        if (isdefined(self.script_label)) {
            level notify(self.script_label);
        }
        return;
    }
    if (ent_player istouching(self)) {
        wait(0.5);
        if (ent_player istouching(self)) {
            self jump_pad_start(ent_player, endon_condition);
        }
    }
}

// Namespace zm_jump_pad
// Params 1, eflags: 0x0
// Checksum 0xd42cb7c5, Offset: 0x12a0
// Size: 0xe6
function jump_pad_cancel(ent_player) {
    ent_player notify(#"left_jump_pad");
    if (isdefined(ent_player.poi_spot) && !(isdefined(ent_player._padded) && ent_player._padded)) {
    }
    if (isdefined(self.name)) {
        self._action_overrides = strtok(self.name, ",");
        if (isdefined(self._action_overrides)) {
            for (i = 0; i < self._action_overrides.size; i++) {
                ent_player jump_pad_player_overrides(self._action_overrides[i]);
            }
        }
    }
}

// Namespace zm_jump_pad
// Params 4, eflags: 0x0
// Checksum 0x497a3e9c, Offset: 0x1390
// Size: 0x4dc
function jump_pad_move(vec_direction, flt_time, struct_poi, trigger) {
    self endon(#"death");
    self endon(#"disconnect");
    start_time = gettime();
    jump_time = flt_time * 500;
    attract_dist = undefined;
    num_attractors = 30;
    added_poi_value = 0;
    start_turned_on = 1;
    poi_start_func = undefined;
    while (isdefined(self._padded) && (isdefined(self.divetoprone) && self.divetoprone || self._padded)) {
        wait(0.05);
    }
    self._padded = 1;
    self.lander = 1;
    self setstance("stand");
    wait(0.1);
    if (isdefined(trigger.script_label)) {
        if (issubstr(trigger.script_label, "low")) {
            self.jump_pad_current = undefined;
            self.jump_pad_previous = undefined;
        } else if (!isdefined(self.jump_pad_current)) {
            self.jump_pad_current = trigger;
        } else {
            self.jump_pad_previous = self.jump_pad_current;
            self.jump_pad_current = trigger;
        }
    }
    if (isdefined(self.poi_spot)) {
        level jump_pad_ignore_poi_cleanup(self.poi_spot);
        self.poi_spot zm_utility::deactivate_zombie_point_of_interest();
        self.poi_spot delete();
    }
    if (isdefined(struct_poi)) {
        self.poi_spot = spawn("script_origin", struct_poi.origin);
        if (isdefined(level.var_7c70ac67)) {
            level [[ level.var_7c70ac67 ]](self.poi_spot);
        }
        self thread jump_pad_enemy_follow_or_ignore(self.poi_spot);
        if (isdefined(level._jump_pad_poi_start_override) && !(isdefined(self.script_index) && self.script_index)) {
            poi_start_func = level._jump_pad_poi_start_override;
        }
        if (isdefined(level._jump_pad_poi_end_override)) {
            poi_end_func = level._jump_pad_poi_end_override;
        }
        self.poi_spot zm_utility::create_zombie_point_of_interest(attract_dist, num_attractors, added_poi_value, start_turned_on, poi_start_func);
        self thread disconnect_failsafe_pad_poi_clean();
    }
    self setorigin(self.origin + (0, 0, 1));
    if (20 >= randomintrange(0, 101)) {
        self thread zm_audio::create_and_play_dialog("general", "jumppad");
    }
    while (gettime() - start_time < jump_time) {
        self setvelocity(vec_direction);
        wait(0.05);
    }
    while (!self isonground()) {
        wait(0.05);
    }
    self._padded = 0;
    self.lander = 0;
    jump_pad_triggers = getentarray("trig_jump_pad", "targetname");
    for (i = 0; i < jump_pad_triggers.size; i++) {
        if (self istouching(jump_pad_triggers[i])) {
            level thread failsafe_pad_poi_clean(jump_pad_triggers[i], self.poi_spot);
            return;
        }
    }
    if (isdefined(self.poi_spot)) {
        level jump_pad_ignore_poi_cleanup(self.poi_spot);
        self.poi_spot delete();
    }
}

// Namespace zm_jump_pad
// Params 0, eflags: 0x0
// Checksum 0xe6690734, Offset: 0x1878
// Size: 0x94
function disconnect_failsafe_pad_poi_clean() {
    self notify(#"kill_disconnect_failsafe_pad_poi_clean");
    self endon(#"kill_disconnect_failsafe_pad_poi_clean");
    self.poi_spot endon(#"death");
    self waittill(#"disconnect");
    if (isdefined(self.poi_spot)) {
        level jump_pad_ignore_poi_cleanup(self.poi_spot);
        self.poi_spot zm_utility::deactivate_zombie_point_of_interest();
        self.poi_spot delete();
    }
}

// Namespace zm_jump_pad
// Params 2, eflags: 0x0
// Checksum 0xd82f6cd4, Offset: 0x1918
// Size: 0x94
function failsafe_pad_poi_clean(ent_trig, ent_poi) {
    if (isdefined(ent_trig.script_wait)) {
        wait(ent_trig.script_wait);
    } else {
        wait(0.5);
    }
    if (isdefined(ent_poi)) {
        level jump_pad_ignore_poi_cleanup(ent_poi);
        ent_poi zm_utility::deactivate_zombie_point_of_interest();
        ent_poi delete();
    }
}

// Namespace zm_jump_pad
// Params 1, eflags: 0x0
// Checksum 0xff16e623, Offset: 0x19b8
// Size: 0x236
function jump_pad_enemy_follow_or_ignore(ent_poi) {
    self endon(#"death");
    self endon(#"disconnect");
    zombies = getaiteamarray(level.zombie_team);
    players = getplayers();
    valid_players = 0;
    for (p = 0; p < players.size; p++) {
        if (zm_utility::is_player_valid(players[p])) {
            valid_players++;
        }
    }
    for (i = 0; i < zombies.size; i++) {
        ignore_poi = 0;
        if (!isdefined(zombies[i])) {
            continue;
        }
        enemy = zombies[i].favoriteenemy;
        if (isdefined(enemy)) {
            if (players.size > 1 && valid_players > 1) {
                if (isdefined(enemy.jump_pad_previous) && (enemy != self || enemy.jump_pad_previous == enemy.jump_pad_current)) {
                    ignore_poi = 1;
                }
            }
        }
        if (isdefined(ignore_poi) && ignore_poi) {
            zombies[i] thread zm_utility::add_poi_to_ignore_list(ent_poi);
            continue;
        }
        zombies[i].ignore_cleanup_mgr = 1;
        zombies[i]._pad_follow = 1;
        zombies[i] thread stop_chasing_the_sky(ent_poi);
    }
}

// Namespace zm_jump_pad
// Params 1, eflags: 0x0
// Checksum 0x79aa3f73, Offset: 0x1bf8
// Size: 0x106
function jump_pad_ignore_poi_cleanup(ent_poi) {
    zombies = getaiteamarray(level.zombie_team);
    for (i = 0; i < zombies.size; i++) {
        if (isdefined(zombies[i])) {
            if (isdefined(zombies[i]._pad_follow) && zombies[i]._pad_follow) {
                zombies[i]._pad_follow = 0;
                zombies[i] notify(#"stop_chasing_the_sky");
                zombies[i].ignore_cleanup_mgr = 0;
            }
            if (isdefined(ent_poi)) {
                zombies[i] thread zm_utility::remove_poi_from_ignore_list(ent_poi);
            }
        }
    }
}

// Namespace zm_jump_pad
// Params 1, eflags: 0x0
// Checksum 0x843afd60, Offset: 0x1d08
// Size: 0x14a
function stop_chasing_the_sky(ent_poi) {
    self endon(#"death");
    self endon(#"stop_chasing_the_sky");
    while (isdefined(self._pad_follow) && self._pad_follow) {
        if (isdefined(self.favoriteenemy)) {
            players = getplayers();
            for (i = 0; i < players.size; i++) {
                if (zm_utility::is_player_valid(players[i]) && players[i] != self.favoriteenemy) {
                    if (distance2dsquared(players[i].origin, self.origin) < 10000) {
                        self zm_utility::add_poi_to_ignore_list(ent_poi);
                        return;
                    }
                }
            }
        }
        wait(0.1);
    }
    self._pad_follow = 0;
    self.ignore_cleanup_mgr = 0;
    self notify(#"stop_chasing_the_sky");
}

// Namespace zm_jump_pad
// Params 2, eflags: 0x0
// Checksum 0xb69ff45, Offset: 0x1e60
// Size: 0xaa
function jump_pad_player_overrides(st_behavior, int_clean) {
    if (!isdefined(st_behavior) || !isstring(st_behavior)) {
        return;
    }
    if (!isdefined(int_clean)) {
        int_clean = 0;
    }
    switch (st_behavior) {
    case 14:
        if (!int_clean) {
        }
        break;
    default:
        if (isdefined(level._jump_pad_level_behavior)) {
            self [[ level._jump_pad_level_behavior ]](st_behavior, int_clean);
        }
        break;
    }
}

