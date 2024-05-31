#using scripts/zm/zm_moon_gravity;
#using scripts/zm/_zm_weapons;
#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_spawner;
#using scripts/zm/_zm_powerups;
#using scripts/zm/_zm_jump_pad;
#using scripts/zm/_zm_audio;
#using scripts/zm/_zm;
#using scripts/shared/ai/zombie_utility;
#using scripts/shared/util_shared;
#using scripts/shared/laststand_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/audio_shared;
#using scripts/shared/array_shared;
#using scripts/codescripts/struct;

#namespace namespace_93e4d62b;

// Namespace namespace_93e4d62b
// Params 0, eflags: 0x1 linked
// namespace_93e4d62b<file_0>::function_c35e6aab
// Checksum 0x9cce7033, Offset: 0x5a0
// Size: 0x84
function init() {
    level.var_476e815c = 1;
    level function_fdc20e4d();
    level thread function_c9eb60d7();
    level thread function_ca918b3a();
    level thread function_9fd107a8();
    level thread function_fab72764();
}

// Namespace namespace_93e4d62b
// Params 0, eflags: 0x1 linked
// namespace_93e4d62b<file_0>::function_fdc20e4d
// Checksum 0xf09cab5f, Offset: 0x630
// Size: 0xe4
function function_fdc20e4d() {
    level._jump_pad_override["biodome_logic"] = &function_10c9b4ed;
    level._jump_pad_override["low_grav"] = &function_af409ac8;
    level._jump_pad_override["moon_vertical_jump"] = &function_fdf7bb6a;
    level._jump_pad_poi_start_override = &function_17a5d12c;
    zm::register_player_damage_callback(&function_4b3d145d);
    level flag::init("pad_allow_anim_change");
    level.var_cb7e8b11 = [];
    level flag::set("pad_allow_anim_change");
}

// Namespace namespace_93e4d62b
// Params 11, eflags: 0x1 linked
// namespace_93e4d62b<file_0>::function_4b3d145d
// Checksum 0x7d212656, Offset: 0x720
// Size: 0x178
function function_4b3d145d(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex) {
    if (smeansofdeath === "MOD_FALLING") {
        if (isdefined(self._padded) && self._padded) {
            var_6f51be76 = arraygetclosest(self.origin, level.var_9b5df18a);
            if (self istouching(var_6f51be76)) {
                return 0;
            }
            var_f5f4e9cc = arraygetclosest(self.origin, getentarray("trig_jump_pad", "targetname"));
            if (self istouching(var_f5f4e9cc)) {
                return 0;
            }
        }
        var_7493f254 = 100 / self.maxhealth;
        return int(idamage * var_7493f254);
    }
    return idamage;
}

// Namespace namespace_93e4d62b
// Params 1, eflags: 0x1 linked
// namespace_93e4d62b<file_0>::function_10c9b4ed
// Checksum 0x4d49378c, Offset: 0x8a0
// Size: 0x174
function function_10c9b4ed(ent_player) {
    if (isdefined(self.start.script_string)) {
        ent_player.script_string = self.start.script_string;
    }
    if (isdefined(ent_player.script_string)) {
        var_3df05bf1 = self.destination;
        var_3df05bf1 = array::randomize(var_3df05bf1);
        for (i = 0; i < var_3df05bf1.size; i++) {
            if (isdefined(var_3df05bf1[i].script_string) && var_3df05bf1[i].script_string == ent_player.script_string) {
                end_point = var_3df05bf1[i];
                if (randomint(100) < 5 && !level.var_db96ea8e && isdefined(end_point.script_parameters)) {
                    var_3a0ae806 = level.var_1f0f2cbd[end_point.script_parameters];
                    if (isdefined(var_3a0ae806)) {
                    }
                }
                return end_point;
            }
        }
    }
}

// Namespace namespace_93e4d62b
// Params 2, eflags: 0x1 linked
// namespace_93e4d62b<file_0>::function_af409ac8
// Checksum 0xca153267, Offset: 0xa20
// Size: 0x5c8
function function_af409ac8(var_d83d7416, var_16e86d0b) {
    end_point = var_16e86d0b;
    start_point = var_d83d7416;
    z_velocity = undefined;
    z_dist = undefined;
    fling_this_way = undefined;
    world_gravity = getdvarint("bg_gravity");
    gravity_pulls = -13.3;
    top_velocity_sq = 810000;
    forward_scaling = 1;
    end_spot = var_16e86d0b.origin;
    if (!(isdefined(self.script_airspeed) && self.script_airspeed)) {
        rand_end = (randomfloatrange(0.1, 1.2), randomfloatrange(0.1, 1.2), 0);
        rand_scale = randomint(100);
        rand_spot = vectorscale(rand_end, rand_scale);
        end_spot = var_16e86d0b.origin + rand_spot;
    }
    pad_dist = distance(start_point.origin, end_spot);
    z_dist = end_spot[2] - start_point.origin[2];
    jump_velocity = end_spot - start_point.origin;
    if (z_dist > 40 && z_dist < -121) {
        z_dist *= 0.2;
        forward_scaling = 0.8;
        /#
            if (getdvarint("struct_tempt_left_medium_start")) {
                z_dist *= getdvarfloat("struct_tempt_left_medium_start");
                forward_scaling = getdvarfloat("struct_tempt_left_medium_start");
            }
        #/
    } else if (z_dist >= -121) {
        z_dist *= 0.2;
        forward_scaling = 0.7;
        /#
            if (getdvarint("struct_tempt_left_medium_start")) {
                z_dist *= getdvarfloat("struct_tempt_left_medium_start");
                forward_scaling = getdvarfloat("struct_tempt_left_medium_start");
            }
        #/
    } else if (z_dist < 0) {
        z_dist *= 0.1;
        forward_scaling = 0.95;
        /#
            if (getdvarint("struct_tempt_left_medium_start")) {
                z_dist *= getdvarfloat("struct_tempt_left_medium_start");
                forward_scaling = getdvarfloat("struct_tempt_left_medium_start");
            }
        #/
    }
    n_reduction = 0.035;
    /#
        if (getdvarfloat("struct_tempt_left_medium_start") > 0) {
            n_reduction = getdvarfloat("struct_tempt_left_medium_start");
        }
    #/
    z_velocity = n_reduction * 0.75 * z_dist * world_gravity;
    if (z_velocity < 0) {
        z_velocity *= -1;
    }
    if (z_dist < 0) {
        z_dist *= -1;
    }
    jump_time = sqrt(2 * pad_dist / world_gravity);
    jump_time_2 = sqrt(z_dist / world_gravity);
    jump_time += jump_time_2;
    if (jump_time < 0) {
        jump_time *= -1;
    }
    x = jump_velocity[0] * forward_scaling / jump_time;
    y = jump_velocity[1] * forward_scaling / jump_time;
    z = z_velocity / jump_time;
    fling_this_way = (x, y, z);
    var_9ae26370 = [];
    var_9ae26370[0] = fling_this_way;
    var_9ae26370[1] = jump_time;
    return var_9ae26370;
}

// Namespace namespace_93e4d62b
// Params 2, eflags: 0x1 linked
// namespace_93e4d62b<file_0>::function_fdf7bb6a
// Checksum 0x7e095b7b, Offset: 0xff0
// Size: 0x3a2
function function_fdf7bb6a(var_d83d7416, var_16e86d0b) {
    end_point = var_16e86d0b;
    start_point = var_d83d7416;
    z_velocity = undefined;
    z_dist = undefined;
    fling_this_way = undefined;
    world_gravity = getdvarint("bg_gravity");
    gravity_pulls = -13.3;
    top_velocity_sq = 810000;
    forward_scaling = 0.9;
    var_de4a2229 = (randomfloatrange(-1, 1), randomfloatrange(-1, 1), 0);
    var_7c366ad8 = (randomintrange(2, 6), randomintrange(2, 6), 0);
    pad_dist = distance(start_point.origin, end_point.origin);
    jump_velocity = end_point.origin - start_point.origin;
    z_dist = end_point.origin[2] - start_point.origin[2];
    z_dist *= 1.5;
    z_velocity = 0.0012 * 2 * z_dist * world_gravity;
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
    var_85ff1405 = (x, y, z) + var_7c366ad8;
    fling_this_way = (x, y, z);
    var_9ae26370 = [];
    var_9ae26370[0] = fling_this_way;
    var_9ae26370[1] = jump_time;
    return var_9ae26370;
}

// Namespace namespace_93e4d62b
// Params 0, eflags: 0x1 linked
// namespace_93e4d62b<file_0>::function_c9eb60d7
// Checksum 0x97e3c6c1, Offset: 0x13a0
// Size: 0x1a4
function function_c9eb60d7() {
    level.var_1f0f2cbd = [];
    level.var_1f0f2cbd["struct_tempt_left_medium_start"] = struct::get_array("struct_tempt_left_medium_start", "targetname");
    level.var_1f0f2cbd["struct_tempt_right_medium_start"] = struct::get_array("struct_tempt_right_medium_start", "targetname");
    level.var_1f0f2cbd["struct_tempt_left_tall"] = struct::get_array("struct_tempt_left_tall", "targetname");
    level.var_1f0f2cbd["struct_tempt_middle_tall"] = struct::get_array("struct_tempt_middle_tall", "targetname");
    level.var_1f0f2cbd["struct_tempt_right_tall"] = struct::get_array("struct_tempt_right_tall", "targetname");
    level.var_1f0f2cbd["struct_tempt_left_medium_end"] = struct::get_array("struct_tempt_left_medium_end", "targetname");
    level.var_1f0f2cbd["struct_tempt_right_medium_end"] = struct::get_array("struct_tempt_right_medium_end", "targetname");
    level.var_db96ea8e = 0;
    level flag::wait_till("start_zombie_round_logic");
    level thread function_299aa71a();
}

// Namespace namespace_93e4d62b
// Params 0, eflags: 0x1 linked
// namespace_93e4d62b<file_0>::function_299aa71a
// Checksum 0x698b7bc4, Offset: 0x1550
// Size: 0x168
function function_299aa71a() {
    level endon(#"end_game");
    structs = struct::get_array("struct_biodome_temptation", "script_noteworthy");
    while (true) {
        rand = randomint(structs.size);
        if (isdefined(level.var_1f0f2cbd[structs[rand].targetname])) {
            var_b404fb8f = level.var_1f0f2cbd[structs[rand].targetname];
            var_b404fb8f = array::randomize(var_b404fb8f);
            if (isdefined(level.zones["forest_zone"].is_enabled) && isdefined(level.zones["forest_zone"]) && level.zones["forest_zone"].is_enabled && !level.var_db96ea8e) {
                level thread function_e9cb7a5d(var_b404fb8f);
            }
        }
        wait(randomintrange(60, -76));
    }
}

// Namespace namespace_93e4d62b
// Params 1, eflags: 0x1 linked
// namespace_93e4d62b<file_0>::function_e9cb7a5d
// Checksum 0xc74ef0d8, Offset: 0x16c0
// Size: 0x302
function function_e9cb7a5d(struct_array) {
    powerup = spawn("script_model", struct_array[0].origin);
    level thread function_2c80b547(powerup);
    powerup endon(#"powerup_grabbed");
    powerup endon(#"powerup_timedout");
    var_3a0ae806 = array("fire_sale", "insta_kill", "nuke", "double_points", "carpenter");
    var_4ebcac1d = 0;
    spot_index = 0;
    first_time = 1;
    struct = undefined;
    rotation = 0;
    var_3a0ae806 = array::randomize(var_3a0ae806);
    while (isdefined(powerup)) {
        if (level.zombie_vars["zombie_powerup_fire_sale_on"] == 1 || var_3a0ae806[var_4ebcac1d] == "fire_sale" && level.chest_moves == 0) {
            var_4ebcac1d++;
            if (var_4ebcac1d >= var_3a0ae806.size) {
                var_4ebcac1d = 0;
            }
            powerup zm_powerups::powerup_setup(var_3a0ae806[var_4ebcac1d]);
        } else {
            powerup zm_powerups::powerup_setup(var_3a0ae806[var_4ebcac1d]);
        }
        if (first_time) {
            powerup thread zm_powerups::powerup_timeout();
            powerup thread zm_powerups::powerup_wobble();
            powerup thread zm_powerups::powerup_grab();
            first_time = 0;
        }
        powerup.origin = struct_array[spot_index].origin;
        if (rotation == 0) {
            wait(15);
            rotation++;
        } else if (rotation == 1) {
            wait(7.5);
            rotation++;
        } else if (rotation == 2) {
            wait(2.5);
            rotation++;
        } else {
            wait(1.5);
            rotation++;
        }
        var_4ebcac1d++;
        if (var_4ebcac1d >= var_3a0ae806.size) {
            var_4ebcac1d = 0;
        }
        spot_index++;
        if (spot_index >= struct_array.size) {
            spot_index = 0;
        }
    }
}

// Namespace namespace_93e4d62b
// Params 1, eflags: 0x1 linked
// namespace_93e4d62b<file_0>::function_2c80b547
// Checksum 0xff4f5023, Offset: 0x19d0
// Size: 0x3c
function function_2c80b547(ent_powerup) {
    level.var_db96ea8e = 1;
    while (isdefined(ent_powerup)) {
        wait(0.1);
    }
    level.var_db96ea8e = 0;
}

// Namespace namespace_93e4d62b
// Params 0, eflags: 0x1 linked
// namespace_93e4d62b<file_0>::function_ca918b3a
// Checksum 0x501039bd, Offset: 0x1a18
// Size: 0x10a
function function_ca918b3a() {
    level endon(#"end_game");
    var_f1ccdce9 = getentarray("biodome_pads", "script_noteworthy");
    for (var_90737d4b = 0; !var_90737d4b; var_90737d4b = 1) {
        var_19127c3b, zone = level waittill(#"hash_1137a109");
        if (var_19127c3b == "biodome" && isarray(zone) && zone[0] == "forest_zone") {
        }
    }
    for (i = 0; i < var_f1ccdce9.size; i++) {
        var_f1ccdce9[i].script_string = "low_grav";
    }
}

// Namespace namespace_93e4d62b
// Params 0, eflags: 0x1 linked
// namespace_93e4d62b<file_0>::function_9fd107a8
// Checksum 0x4721c971, Offset: 0x1b30
// Size: 0x206
function function_9fd107a8() {
    level endon(#"end_game");
    jump_pad_triggers = getentarray("trig_jump_pad", "targetname");
    level flag::wait_till("start_zombie_round_logic");
    wait(2);
    level.var_2f081323 = [];
    for (i = 0; i < jump_pad_triggers.size; i++) {
        pad = jump_pad_triggers[i];
        if (isdefined(pad.script_label)) {
            if (pad.script_label == "pad_labs_low") {
                array::add(level.var_2f081323, pad, 0);
                continue;
            }
            if (pad.script_label == "pad_magic_box_low") {
                array::add(level.var_2f081323, pad, 0);
                continue;
            }
            if (pad.script_label == "pad_teleporter_low") {
                array::add(level.var_2f081323, pad, 0);
            }
        }
    }
    /#
        if (level.var_2f081323.size == 0) {
            println("struct_tempt_left_medium_start");
            return;
        }
    #/
    level flag::wait_till("power_on");
    for (i = 0; i < level.var_2f081323.size; i++) {
        level.var_2f081323[i] thread function_6bc191d6();
    }
}

// Namespace namespace_93e4d62b
// Params 0, eflags: 0x1 linked
// namespace_93e4d62b<file_0>::function_6bc191d6
// Checksum 0x67d71083, Offset: 0x1d40
// Size: 0x1a0
function function_6bc191d6() {
    level endon(#"end_game");
    var_d11ba2f6 = spawn("script_model", self.origin);
    var_d11ba2f6 setmodel("tag_origin");
    while (isdefined(self)) {
        wait(randomintrange(30, 60));
        println("struct_tempt_left_medium_start");
        var_d11ba2f6 playsound("zmb_turret_down");
        var_d11ba2f6 clientfield::set("dome_malfunction_pad", 1);
        util::wait_network_frame();
        self triggerenable(0);
        wait(randomintrange(10, 30));
        var_d11ba2f6 playsound("zmb_turret_startup");
        var_d11ba2f6 clientfield::set("dome_malfunction_pad", 0);
        util::wait_network_frame();
        self triggerenable(1);
        println("struct_tempt_left_medium_start");
    }
}

// Namespace namespace_93e4d62b
// Params 1, eflags: 0x1 linked
// namespace_93e4d62b<file_0>::function_17a5d12c
// Checksum 0xf59b1a10, Offset: 0x1ee8
// Size: 0x254
function function_17a5d12c(ent_poi) {
    self endon(#"death");
    if (isdefined(self.var_2d6a4d20) && self.var_2d6a4d20) {
        return;
    }
    if (isdefined(self.animname) && self.animname == "astro_zombie") {
        return;
    }
    if (isdefined(self.script_string) && self.script_string == "riser") {
        while (isdefined(self.in_the_ground) && self.in_the_ground) {
            wait(0.05);
        }
    }
    if (!(isdefined(self.completed_emerging_into_playable_area) && self.completed_emerging_into_playable_area)) {
        return;
    }
    self.var_2d6a4d20 = 1;
    var_36f7e82a = 0;
    var_8d8ed22b = undefined;
    var_acb1e176 = self zm_utility::get_current_zone();
    if (!isdefined(var_acb1e176) && isdefined(self.zone_name)) {
        var_acb1e176 = self.zone_name;
    }
    if (isdefined(var_acb1e176) && isdefined(level.zones[var_acb1e176].volumes[0].script_string) && level.zones[var_acb1e176].volumes[0].script_string == "lowgravity") {
        var_36f7e82a = 1;
    }
    self thread namespace_a9e990ad::function_c508229a(var_36f7e82a);
    if (self.animname == "zombie" || self.animname == "quad_zombie") {
        self.var_41a233b3 = self.zombie_move_speed;
        if (var_36f7e82a && self.zombie_move_speed != "jump_pad_super_sprint") {
            self zombie_utility::set_zombie_run_cycle("jump_pad_super_sprint");
        } else {
            self zombie_utility::set_zombie_run_cycle("super_sprint");
        }
    }
    self thread function_9894aefb();
}

// Namespace namespace_93e4d62b
// Params 0, eflags: 0x0
// namespace_93e4d62b<file_0>::function_eb21d469
// Checksum 0xe8a17298, Offset: 0x2148
// Size: 0xd4
function function_eb21d469() {
    self endon(#"death");
    var_15fcfc38 = self.var_12d0f044;
    anim_keys = getarraykeys(level.scr_anim[self.animname]);
    for (j = 0; j < anim_keys.size; j++) {
        if (level.scr_anim[self.animname][anim_keys[j]] == var_15fcfc38) {
            return anim_keys[j];
        }
    }
    assertmsg("struct_tempt_left_medium_start");
}

// Namespace namespace_93e4d62b
// Params 0, eflags: 0x1 linked
// namespace_93e4d62b<file_0>::function_9894aefb
// Checksum 0x80f0f46e, Offset: 0x2228
// Size: 0x150
function function_9894aefb() {
    self endon(#"death");
    if (!(isdefined(self.var_2d6a4d20) && self.var_2d6a4d20)) {
        return;
    }
    if (isdefined(self.animname) && self.animname == "astro_zombie") {
        return;
    }
    while (isdefined(self._pad_follow) && self._pad_follow) {
        wait(0.05);
    }
    var_36f7e82a = 0;
    var_acb1e176 = self zm_utility::get_current_zone();
    if (isdefined(var_acb1e176) && isdefined(level.zones[var_acb1e176].volumes[0].script_string) && level.zones[var_acb1e176].volumes[0].script_string == "lowgravity") {
        var_36f7e82a = 1;
    }
    var_4fc2c0bb = undefined;
    self zombie_utility::set_zombie_run_cycle(self.var_41a233b3);
    self.var_41a233b3 = undefined;
    self.var_2d6a4d20 = 0;
}

// Namespace namespace_93e4d62b
// Params 0, eflags: 0x1 linked
// namespace_93e4d62b<file_0>::function_fab72764
// Checksum 0xec311afa, Offset: 0x2380
// Size: 0x84
function function_fab72764() {
    level flag::wait_till("start_zombie_round_logic");
    level.var_9b5df18a = getentarray("trig_cushion_sound", "targetname");
    if (level.var_9b5df18a.size) {
        array::thread_all(level.var_9b5df18a, &function_8c6bcc04);
    }
}

// Namespace namespace_93e4d62b
// Params 0, eflags: 0x1 linked
// namespace_93e4d62b<file_0>::function_8c6bcc04
// Checksum 0x5f0149a, Offset: 0x2410
// Size: 0x80
function function_8c6bcc04() {
    while (isdefined(self)) {
        who = self waittill(#"trigger");
        if (isdefined(who._padded) && isplayer(who) && who._padded) {
            self playsound("evt_jump_pad_land");
        }
    }
}

// Namespace namespace_93e4d62b
// Params 0, eflags: 0x1 linked
// namespace_93e4d62b<file_0>::function_d4f0f4fe
// Checksum 0x27e8526c, Offset: 0x2498
// Size: 0x64
function function_d4f0f4fe() {
    if (isdefined(self.script_int)) {
        level clientfield::increment("jump_pad_pulse", self.script_int);
        return;
    }
    playfx(level._effect["jump_pad_jump"], self.origin);
}

