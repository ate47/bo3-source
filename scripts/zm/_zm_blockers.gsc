#using scripts/zm/_zm_zonemgr;
#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_unitrigger;
#using scripts/zm/_zm_stats;
#using scripts/zm/_zm_spawner;
#using scripts/zm/_zm_score;
#using scripts/zm/_zm_pers_upgrades_functions;
#using scripts/zm/_zm_laststand;
#using scripts/zm/_zm_daily_challenges;
#using scripts/zm/_zm_audio;
#using scripts/zm/_bb;
#using scripts/zm/_util;
#using scripts/shared/util_shared;
#using scripts/shared/trigger_shared;
#using scripts/shared/system_shared;
#using scripts/shared/scoreevents_shared;
#using scripts/shared/laststand_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/demo_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/array_shared;
#using scripts/codescripts/struct;

#namespace zm_blockers;

// Namespace zm_blockers
// Params 0, eflags: 0x2
// Checksum 0xd7fdd2d3, Offset: 0xa08
// Size: 0x3c
function function_2dc19561() {
    system::register("zm_blockers", &__init__, &__main__, undefined);
}

// Namespace zm_blockers
// Params 0, eflags: 0x1 linked
// Checksum 0xd2fcfdc7, Offset: 0xa50
// Size: 0x74
function __init__() {
    zm_utility::add_zombie_hint("default_buy_debris", %ZOMBIE_BUTTON_BUY_CLEAR_DEBRIS_COST);
    zm_utility::add_zombie_hint("default_buy_door", %ZOMBIE_BUTTON_BUY_OPEN_DOOR_COST);
    zm_utility::add_zombie_hint("default_buy_door_close", %ZOMBIE_BUTTON_BUY_CLOSE_DOOR);
    init_blockers();
}

// Namespace zm_blockers
// Params 0, eflags: 0x1 linked
// Checksum 0x1a41c6db, Offset: 0xad0
// Size: 0x48
function __main__() {
    if (isdefined(level.quantum_bomb_register_result_func)) {
        [[ level.quantum_bomb_register_result_func ]]("open_nearest_door", &quantum_bomb_open_nearest_door_result, 35, &quantum_bomb_open_nearest_door_validation);
    }
}

// Namespace zm_blockers
// Params 0, eflags: 0x1 linked
// Checksum 0xd8b74b61, Offset: 0xb20
// Size: 0x164
function init_blockers() {
    level.exterior_goals = struct::get_array("exterior_goal", "targetname");
    array::thread_all(level.exterior_goals, &blocker_init);
    zombie_doors = getentarray("zombie_door", "targetname");
    if (isdefined(zombie_doors)) {
        level flag::init("door_can_close");
        array::thread_all(zombie_doors, &door_init);
    }
    zombie_debris = getentarray("zombie_debris", "targetname");
    array::thread_all(zombie_debris, &debris_init);
    flag_blockers = getentarray("flag_blocker", "targetname");
    array::thread_all(flag_blockers, &flag_blocker);
}

// Namespace zm_blockers
// Params 0, eflags: 0x1 linked
// Checksum 0xa27cf78, Offset: 0xc90
// Size: 0x434
function door_init() {
    self.type = undefined;
    self.purchaser = undefined;
    self._door_open = 0;
    ent_targets = getentarray(self.target, "targetname");
    node_targets = getnodearray(self.target, "targetname");
    targets = arraycombine(ent_targets, node_targets, 0, 1);
    if (isdefined(self.script_flag) && !isdefined(level.flag[self.script_flag])) {
        if (isdefined(self.script_flag)) {
            tokens = strtok(self.script_flag, ",");
            for (i = 0; i < tokens.size; i++) {
                level flag::init(self.script_flag);
            }
        }
    }
    if (!isdefined(self.script_noteworthy)) {
        self.script_noteworthy = "default";
    }
    self.doors = [];
    for (i = 0; i < targets.size; i++) {
        targets[i] door_classify(self);
        if (!isdefined(targets[i].og_origin)) {
            targets[i].og_origin = targets[i].origin;
            targets[i].og_angles = targets[i].angles;
        }
    }
    cost = 1000;
    if (isdefined(self.zombie_cost)) {
        cost = self.zombie_cost;
    }
    self setcursorhint("HINT_NOICON");
    self thread blocker_update_prompt_visibility();
    self thread door_think();
    if (isdefined(self.script_noteworthy)) {
        if (self.script_noteworthy == "electric_door" || self.script_noteworthy == "electric_buyable_door") {
            if (getdvarstring("ui_gametype") == "zgrief") {
                self setinvisibletoall();
                return;
            }
            self sethintstring(%ZOMBIE_NEED_POWER);
            if (isdefined(level.door_dialog_function)) {
                self thread [[ level.door_dialog_function ]]();
            }
            return;
        } else if (self.script_noteworthy == "local_electric_door") {
            if (getdvarstring("ui_gametype") == "zgrief") {
                self setinvisibletoall();
                return;
            }
            self sethintstring(%ZOMBIE_NEED_LOCAL_POWER);
            if (isdefined(level.door_dialog_function)) {
                self thread [[ level.door_dialog_function ]]();
            }
            return;
        } else if (self.script_noteworthy == "kill_counter_door") {
            self sethintstring(%ZOMBIE_DOOR_ACTIVATE_COUNTER, cost);
            return;
        }
    }
    self zm_utility::set_hint_string(self, "default_buy_door", cost);
}

// Namespace zm_blockers
// Params 1, eflags: 0x1 linked
// Checksum 0x6ad24ce6, Offset: 0x10d0
// Size: 0x2b6
function door_classify(parent_trig) {
    if (isdefined(self.script_noteworthy) && self.script_noteworthy == "air_buy_gate") {
        unlinktraversal(self);
        parent_trig.doors[parent_trig.doors.size] = self;
        return;
    }
    if (isdefined(self.script_noteworthy) && self.script_noteworthy == "clip") {
        parent_trig.clip = self;
        parent_trig.script_string = "clip";
    } else if (!isdefined(self.script_string)) {
        if (isdefined(self.script_angles)) {
            self.script_string = "rotate";
        } else if (isdefined(self.script_vector)) {
            self.script_string = "move";
        }
    } else {
        if (!isdefined(self.script_string)) {
            self.script_string = "";
        }
        switch (self.script_string) {
        case 31:
            /#
                assert(isdefined(self.script_animname), "targetname" + self.targetname);
            #/
            /#
                assert(isdefined(level.scr_anim[self.script_animname]), "targetname" + self.script_animname);
            #/
            /#
                assert(isdefined(level.var_d519ab60), "targetname");
            #/
            break;
        case 34:
            parent_trig.counter_1s = self;
            return;
        case 33:
            parent_trig.counter_10s = self;
            return;
        case 32:
            parent_trig.counter_100s = self;
            return;
        case 35:
            if (!isdefined(parent_trig.var_b18482d)) {
                parent_trig.var_b18482d = [];
            }
            parent_trig.var_b18482d[parent_trig.var_b18482d.size] = self;
            return;
        }
    }
    if (self.classname == "script_brushmodel") {
        self disconnectpaths();
    }
    parent_trig.doors[parent_trig.doors.size] = self;
}

// Namespace zm_blockers
// Params 0, eflags: 0x1 linked
// Checksum 0xe0d2ae10, Offset: 0x1390
// Size: 0x3e8
function door_buy() {
    who, force = self waittill(#"trigger");
    if (isdefined(level.custom_door_buy_check)) {
        if (!who [[ level.custom_door_buy_check ]](self)) {
            return false;
        }
    }
    if (isdefined(force) && (getdvarint("zombie_unlock_all") > 0 || force)) {
        return true;
    }
    if (!who usebuttonpressed()) {
        return false;
    }
    if (who zm_utility::in_revive_trigger()) {
        return false;
    }
    if (who.is_drinking > 0) {
        return false;
    }
    cost = 0;
    upgraded = 0;
    if (zm_utility::is_player_valid(who)) {
        players = getplayers();
        cost = self.zombie_cost;
        if (who namespace_25f8c2ad::function_dc08b4af()) {
            cost = who namespace_25f8c2ad::function_4ef410da(cost);
            upgraded = 1;
        }
        if (self._door_open == 1) {
            self.purchaser = undefined;
        } else if (who zm_score::can_player_purchase(cost)) {
            who zm_score::minus_to_player_score(cost);
            scoreevents::processscoreevent("open_door", who);
            demo::bookmark("zm_player_door", gettime(), who);
            who zm_stats::increment_client_stat("doors_purchased");
            who zm_stats::increment_player_stat("doors_purchased");
            who zm_stats::increment_challenge_stat("SURVIVALIST_BUY_DOOR");
            self.purchaser = who;
        } else {
            zm_utility::play_sound_at_pos("no_purchase", self.doors[0].origin);
            if (isdefined(level.custom_door_deny_vo_func)) {
                who thread [[ level.custom_door_deny_vo_func ]]();
            } else if (isdefined(level.custom_generic_deny_vo_func)) {
                who thread [[ level.custom_generic_deny_vo_func ]](1);
            } else {
                who zm_audio::create_and_play_dialog("general", "outofmoney");
            }
            return false;
        }
    }
    if (isdefined(level._door_open_rumble_func)) {
        who thread [[ level._door_open_rumble_func ]]();
    }
    who recordmapevent(5, gettime(), who.origin, level.round_number, cost);
    bb::logpurchaseevent(who, self, cost, self.target, upgraded, "_door", "_purchase");
    who zm_stats::increment_challenge_stat("ZM_DAILY_PURCHASE_DOORS");
    return true;
}

// Namespace zm_blockers
// Params 0, eflags: 0x1 linked
// Checksum 0x6ba2a4c7, Offset: 0x1780
// Size: 0x134
function blocker_update_prompt_visibility() {
    self endon(#"kill_door_think");
    self endon(#"kill_debris_prompt_thread");
    self endon(#"death");
    dist = 16384;
    while (true) {
        players = level.players;
        if (isdefined(players)) {
            for (i = 0; i < players.size; i++) {
                if (distancesquared(players[i].origin, self.origin) < dist) {
                    if (players[i].is_drinking > 0) {
                        self setinvisibletoplayer(players[i], 1);
                        continue;
                    }
                    self setinvisibletoplayer(players[i], 0);
                }
            }
        }
        wait(0.25);
    }
}

// Namespace zm_blockers
// Params 0, eflags: 0x1 linked
// Checksum 0xa7930561, Offset: 0x18c0
// Size: 0x1ee
function door_delay() {
    if (isdefined(self.var_b18482d)) {
        for (i = 0; i < self.var_b18482d.size; i++) {
            self.var_b18482d[i] show();
        }
    }
    if (!isdefined(self.script_int)) {
        self.script_int = 5;
    }
    var_302c97b6 = getentarray(self.target, "target");
    for (i = 0; i < var_302c97b6.size; i++) {
        var_302c97b6[i] triggerenable(0);
    }
    wait(self.script_int);
    for (i = 0; i < self.script_int; i++) {
        /#
            iprintln(self.script_int - i);
        #/
        wait(1);
    }
    if (isdefined(self.var_b18482d)) {
        for (i = 0; i < self.var_b18482d.size; i++) {
            playfx(level._effect["def_explosion"], self.var_b18482d[i].origin, anglestoforward(self.var_b18482d[i].angles));
            self.var_b18482d[i] hide();
        }
    }
}

// Namespace zm_blockers
// Params 4, eflags: 0x1 linked
// Checksum 0x95213b43, Offset: 0x1ab8
// Size: 0x59c
function door_activate(time, open, quick, use_blocker_clip_for_pathing) {
    if (!isdefined(open)) {
        open = 1;
    }
    if (isdefined(self.script_noteworthy) && self.script_noteworthy == "air_buy_gate") {
        if (open) {
            linktraversal(self);
            return;
        }
        unlinktraversal(self);
        return;
    }
    if (!isdefined(time)) {
        time = 1;
        if (isdefined(self.script_transition_time)) {
            time = self.script_transition_time;
        }
    }
    if (isdefined(self.door_moving)) {
        if (isdefined(self.script_string) && (isdefined(self.script_noteworthy) && self.script_noteworthy == "clip" || self.script_string == "clip")) {
            if (!(isdefined(use_blocker_clip_for_pathing) && use_blocker_clip_for_pathing)) {
                if (!open) {
                    return;
                }
            }
        } else {
            return;
        }
    }
    self.door_moving = 1;
    level notify(#"snddooropening");
    if (open || !(isdefined(quick) && quick)) {
        self notsolid();
    }
    if (self.classname == "script_brushmodel" || self.classname == "script_model") {
        if (open) {
            self connectpaths();
        }
    }
    if (isdefined(self.script_string) && (isdefined(self.script_noteworthy) && self.script_noteworthy == "clip" || self.script_string == "clip")) {
        if (!open) {
            self util::delay(time, undefined, &self_disconnectpaths);
            wait(0.1);
            self solid();
        }
        return;
    }
    if (isdefined(self.script_sound)) {
        if (open) {
            playsoundatposition(self.script_sound, self.origin);
        } else {
            playsoundatposition(self.script_sound + "_close", self.origin);
        }
    } else {
        zm_utility::play_sound_at_pos("zmb_heavy_door_open", self.origin);
    }
    scale = 1;
    if (!open) {
        scale = -1;
    }
    switch (self.script_string) {
    case 28:
        if (isdefined(self.script_angles)) {
            rot_angle = self.script_angles;
            if (!open) {
                rot_angle = self.og_angles;
            }
            self rotateto(rot_angle, time, 0, 0);
            self thread door_solid_thread();
            if (!open) {
                self thread disconnect_paths_when_done();
            }
        }
        wait(randomfloat(0.15));
        break;
    case 29:
    case 54:
        if (isdefined(self.script_vector)) {
            vector = vectorscale(self.script_vector, scale);
            if (time >= 0.5) {
                self moveto(self.origin + vector, time, time * 0.25, time * 0.25);
            } else {
                self moveto(self.origin + vector, time);
            }
            self thread door_solid_thread();
            if (!open) {
                self thread disconnect_paths_when_done();
            }
        }
        wait(randomfloat(0.15));
        break;
    case 31:
        self [[ level.var_d519ab60 ]](self.script_animname);
        self thread door_solid_thread_anim();
        wait(randomfloat(0.15));
        break;
    case 53:
        self thread physics_launch_door(self);
        wait(0.1);
        break;
    case 55:
        self thread door_zbarrier_move();
        break;
    }
    if (isdefined(self.script_firefx)) {
        playfx(level._effect[self.script_firefx], self.origin);
    }
}

// Namespace zm_blockers
// Params 1, eflags: 0x1 linked
// Checksum 0x76f97894, Offset: 0x2060
// Size: 0x156
function kill_trapped_zombies(trigger) {
    zombies = getaiteamarray(level.zombie_team);
    if (!isdefined(zombies)) {
        return;
    }
    for (i = 0; i < zombies.size; i++) {
        if (!isdefined(zombies[i])) {
            continue;
        }
        if (zombies[i] istouching(trigger)) {
            zombies[i].marked_for_recycle = 1;
            zombies[i] dodamage(zombies[i].health + 666, trigger.origin, self);
            wait(randomfloat(0.15));
            continue;
        }
        if (isdefined(level.custom_trapped_zombies)) {
            zombies[i] thread [[ level.custom_trapped_zombies ]]();
            wait(randomfloat(0.15));
        }
    }
}

// Namespace zm_blockers
// Params 1, eflags: 0x0
// Checksum 0x45679d15, Offset: 0x21c0
// Size: 0xb4
function any_player_touching(trigger) {
    foreach (player in getplayers()) {
        if (player istouching(trigger)) {
            return true;
        }
        wait(0.01);
    }
    return false;
}

// Namespace zm_blockers
// Params 2, eflags: 0x1 linked
// Checksum 0x79b60412, Offset: 0x2280
// Size: 0x192
function any_player_touching_any(trigger, more_triggers) {
    foreach (player in getplayers()) {
        if (zm_utility::is_player_valid(player, 0, 1)) {
            if (isdefined(trigger) && player istouching(trigger)) {
                return true;
            }
            if (isdefined(more_triggers) && more_triggers.size > 0) {
                foreach (trig in more_triggers) {
                    if (isdefined(trig) && player istouching(trig)) {
                        return true;
                    }
                }
            }
        }
    }
    return false;
}

// Namespace zm_blockers
// Params 2, eflags: 0x1 linked
// Checksum 0xe1ef82ab, Offset: 0x2420
// Size: 0x18a
function any_zombie_touching_any(trigger, more_triggers) {
    zombies = getaiteamarray(level.zombie_team);
    foreach (zombie in zombies) {
        if (isdefined(trigger) && zombie istouching(trigger)) {
            return true;
        }
        if (isdefined(more_triggers) && more_triggers.size > 0) {
            foreach (trig in more_triggers) {
                if (isdefined(trig) && zombie istouching(trig)) {
                    return true;
                }
            }
        }
    }
    return false;
}

// Namespace zm_blockers
// Params 3, eflags: 0x1 linked
// Checksum 0xb2ba2388, Offset: 0x25b8
// Size: 0x92
function wait_trigger_clear(trigger, more_triggers, end_on) {
    self endon(end_on);
    while (any_player_touching_any(trigger, more_triggers) || any_zombie_touching_any(trigger, more_triggers)) {
        wait(1);
    }
    /#
        println("targetname");
    #/
    self notify(#"trigger_clear");
}

// Namespace zm_blockers
// Params 2, eflags: 0x1 linked
// Checksum 0xe8be0c79, Offset: 0x2658
// Size: 0x98
function waittill_door_trigger_clear_local_power_off(trigger, var_302c97b6) {
    self endon(#"trigger_clear");
    while (true) {
        if (isdefined(self.local_power_on) && self.local_power_on) {
            self waittill(#"local_power_off");
        }
        /#
            println("targetname");
        #/
        self wait_trigger_clear(trigger, var_302c97b6, "local_power_on");
    }
}

// Namespace zm_blockers
// Params 2, eflags: 0x1 linked
// Checksum 0xc89a3d75, Offset: 0x26f8
// Size: 0x98
function waittill_door_trigger_clear_global_power_off(trigger, var_302c97b6) {
    self endon(#"trigger_clear");
    while (true) {
        if (isdefined(self.power_on) && self.power_on) {
            self waittill(#"power_off");
        }
        /#
            println("targetname");
        #/
        self wait_trigger_clear(trigger, var_302c97b6, "power_on");
    }
}

// Namespace zm_blockers
// Params 0, eflags: 0x1 linked
// Checksum 0x696e1d2e, Offset: 0x2798
// Size: 0x186
function waittill_door_can_close() {
    trigger = undefined;
    if (isdefined(self.door_hold_trigger)) {
        trigger = getent(self.door_hold_trigger, "targetname");
    }
    var_302c97b6 = getentarray(self.target, "target");
    switch (self.script_noteworthy) {
    case 22:
        if (isdefined(trigger) || isdefined(var_302c97b6)) {
            self waittill_door_trigger_clear_local_power_off(trigger, var_302c97b6);
            self thread kill_trapped_zombies(trigger);
            return;
        }
        if (isdefined(self.local_power_on) && self.local_power_on) {
            self waittill(#"local_power_off");
        }
        return;
    case 17:
        if (isdefined(trigger) || isdefined(var_302c97b6)) {
            self waittill_door_trigger_clear_global_power_off(trigger, var_302c97b6);
            if (isdefined(trigger)) {
                self thread kill_trapped_zombies(trigger);
            }
            return;
        }
        if (isdefined(self.power_on) && self.power_on) {
            self waittill(#"power_off");
        }
        return;
    }
}

// Namespace zm_blockers
// Params 0, eflags: 0x1 linked
// Checksum 0x87119aa0, Offset: 0x2928
// Size: 0x4b6
function door_think() {
    self endon(#"kill_door_think");
    cost = 1000;
    if (isdefined(self.zombie_cost)) {
        cost = self.zombie_cost;
    }
    self sethintlowpriority(1);
    while (true) {
        switch (self.script_noteworthy) {
        case 22:
            if (!(isdefined(self.local_power_on) && self.local_power_on)) {
                self waittill(#"local_power_on");
            }
            if (!(isdefined(self._door_open) && self._door_open)) {
                /#
                    println("targetname");
                #/
                self door_opened(cost, 1);
                if (!isdefined(self.power_cost)) {
                    self.power_cost = 0;
                }
                self.power_cost += -56;
            }
            self sethintstring("");
            if (isdefined(level.local_doors_stay_open) && level.local_doors_stay_open) {
                return;
            }
            wait(3);
            self waittill_door_can_close();
            self door_block();
            if (isdefined(self._door_open) && self._door_open) {
                /#
                    println("targetname");
                #/
                self door_opened(cost, 1);
            }
            self sethintstring(%ZOMBIE_NEED_LOCAL_POWER);
            wait(3);
            continue;
        case 17:
            if (!(isdefined(self.power_on) && self.power_on)) {
                self waittill(#"power_on");
            }
            if (!(isdefined(self._door_open) && self._door_open)) {
                /#
                    println("targetname");
                #/
                self door_opened(cost, 1);
                if (!isdefined(self.power_cost)) {
                    self.power_cost = 0;
                }
                self.power_cost += -56;
            }
            self sethintstring("");
            if (isdefined(level.local_doors_stay_open) && level.local_doors_stay_open) {
                return;
            }
            wait(3);
            self waittill_door_can_close();
            self door_block();
            if (isdefined(self._door_open) && self._door_open) {
                /#
                    println("targetname");
                #/
                self door_opened(cost, 1);
            }
            self sethintstring(%ZOMBIE_NEED_POWER);
            wait(3);
            continue;
        case 18:
            if (!(isdefined(self.power_on) && self.power_on)) {
                self waittill(#"power_on");
            }
            self zm_utility::set_hint_string(self, "default_buy_door", cost);
            if (!self door_buy()) {
                continue;
            }
            break;
        case 58:
            if (!self door_buy()) {
                continue;
            }
            self door_delay();
            break;
        default:
            if (isdefined(level.var_f0fbe2bf)) {
                self [[ level.var_f0fbe2bf ]]();
                break;
            }
            if (!self door_buy()) {
                continue;
            }
            break;
        }
        self door_opened(cost);
        if (!level flag::get("door_can_close")) {
            break;
        }
    }
}

// Namespace zm_blockers
// Params 1, eflags: 0x0
// Checksum 0x6fdbf3fb, Offset: 0x2de8
// Size: 0x54
function self_and_flag_wait(msg) {
    self endon(msg);
    if (isdefined(self.power_door_ignore_flag_wait) && self.power_door_ignore_flag_wait) {
        level waittill(#"forever");
        return;
    }
    level flag::wait_till(msg);
}

// Namespace zm_blockers
// Params 0, eflags: 0x1 linked
// Checksum 0xf066eaf7, Offset: 0x2e48
// Size: 0xde
function door_block() {
    if (isdefined(self.doors)) {
        for (i = 0; i < self.doors.size; i++) {
            if (isdefined(self.doors[i].script_string) && (isdefined(self.doors[i].script_noteworthy) && self.doors[i].script_noteworthy == "clip" || self.doors[i].script_string == "clip")) {
                self.doors[i] solid();
            }
        }
    }
}

// Namespace zm_blockers
// Params 2, eflags: 0x1 linked
// Checksum 0x398bd78b, Offset: 0x2f30
// Size: 0x75e
function door_opened(cost, quick_close) {
    if (isdefined(self.door_is_moving) && self.door_is_moving) {
        return;
    }
    self.has_been_opened = 1;
    var_302c97b6 = getentarray(self.target, "target");
    self.door_is_moving = 1;
    foreach (trig in var_302c97b6) {
        trig.door_is_moving = 1;
        trig triggerenable(0);
        trig.has_been_opened = 1;
        if (!isdefined(trig._door_open) || trig._door_open == 0) {
            trig._door_open = 1;
            trig notify(#"door_opened");
        } else {
            trig._door_open = 0;
        }
        if (isdefined(trig.script_flag) && trig._door_open == 1) {
            tokens = strtok(trig.script_flag, ",");
            for (i = 0; i < tokens.size; i++) {
                level flag::set(tokens[i]);
            }
        } else if (isdefined(trig.script_flag) && trig._door_open == 0) {
            tokens = strtok(trig.script_flag, ",");
            for (i = 0; i < tokens.size; i++) {
                level flag::clear(tokens[i]);
            }
        }
        if (isdefined(quick_close) && quick_close) {
            trig zm_utility::set_hint_string(trig, "");
            continue;
        }
        if (trig._door_open == 1 && level flag::get("door_can_close")) {
            trig zm_utility::set_hint_string(trig, "default_buy_door_close");
            continue;
        }
        if (trig._door_open == 0) {
            trig zm_utility::set_hint_string(trig, "default_buy_door", cost);
        }
    }
    level notify(#"door_opened");
    if (isdefined(self.doors)) {
        is_script_model_door = 0;
        have_moving_clip_for_door = 0;
        use_blocker_clip_for_pathing = 0;
        foreach (door in self.doors) {
            if (isdefined(door.ignore_use_blocker_clip_for_pathing_check) && door.ignore_use_blocker_clip_for_pathing_check) {
                continue;
            }
            if (isdefined(door.script_noteworthy) && door.script_noteworthy == "air_buy_gate") {
                continue;
            }
            if (door.classname == "script_model") {
                is_script_model_door = 1;
                continue;
            }
            if (!isdefined(door.script_string) || (!isdefined(door.script_noteworthy) || door.classname == "script_brushmodel" && door.script_noteworthy != "clip") && door.script_string != "clip") {
                have_moving_clip_for_door = 1;
            }
        }
        use_blocker_clip_for_pathing = is_script_model_door && !have_moving_clip_for_door;
        for (i = 0; i < self.doors.size; i++) {
            self.doors[i] thread door_activate(self.doors[i].script_transition_time, self._door_open, quick_close, use_blocker_clip_for_pathing);
        }
        if (self.doors.size) {
            zm_utility::play_sound_at_pos("purchase", self.origin);
        }
    }
    level.active_zone_names = zm_zonemgr::get_active_zone_names();
    wait(1);
    self.door_is_moving = 0;
    foreach (trig in var_302c97b6) {
        trig.door_is_moving = 0;
    }
    if (isdefined(quick_close) && quick_close) {
        for (i = 0; i < var_302c97b6.size; i++) {
            var_302c97b6[i] triggerenable(1);
        }
        return;
    }
    if (level flag::get("door_can_close")) {
        wait(2);
        for (i = 0; i < var_302c97b6.size; i++) {
            var_302c97b6[i] triggerenable(1);
        }
    }
}

// Namespace zm_blockers
// Params 1, eflags: 0x1 linked
// Checksum 0xde11ce2, Offset: 0x3698
// Size: 0xdc
function physics_launch_door(door_trig) {
    vec = vectorscale(vectornormalize(self.script_vector), 10);
    self rotateroll(5, 0.05);
    wait(0.05);
    self moveto(self.origin + vec, 0.1);
    self waittill(#"movedone");
    self physicslaunch(self.origin, self.script_vector * 300);
    wait(60);
    self delete();
}

// Namespace zm_blockers
// Params 0, eflags: 0x1 linked
// Checksum 0x6d57aa36, Offset: 0x3780
// Size: 0xf0
function door_solid_thread() {
    self util::waittill_either("rotatedone", "movedone");
    self.door_moving = undefined;
    while (true) {
        players = getplayers();
        player_touching = 0;
        for (i = 0; i < players.size; i++) {
            if (players[i] istouching(self)) {
                player_touching = 1;
                break;
            }
        }
        if (!player_touching) {
            self solid();
            return;
        }
        wait(1);
    }
}

// Namespace zm_blockers
// Params 0, eflags: 0x1 linked
// Checksum 0x7fc7e268, Offset: 0x3878
// Size: 0xd8
function door_solid_thread_anim() {
    self waittillmatch(#"door_anim", "end");
    self.door_moving = undefined;
    while (true) {
        players = getplayers();
        player_touching = 0;
        for (i = 0; i < players.size; i++) {
            if (players[i] istouching(self)) {
                player_touching = 1;
                break;
            }
        }
        if (!player_touching) {
            self solid();
            return;
        }
        wait(1);
    }
}

// Namespace zm_blockers
// Params 0, eflags: 0x1 linked
// Checksum 0xbdaa4c72, Offset: 0x3958
// Size: 0x44
function disconnect_paths_when_done() {
    self util::waittill_either("rotatedone", "movedone");
    self disconnectpaths();
}

// Namespace zm_blockers
// Params 0, eflags: 0x1 linked
// Checksum 0xa72fba7b, Offset: 0x39a8
// Size: 0x1c
function self_disconnectpaths() {
    self disconnectpaths();
}

// Namespace zm_blockers
// Params 0, eflags: 0x1 linked
// Checksum 0x3b25e710, Offset: 0x39d0
// Size: 0x2dc
function debris_init() {
    cost = 1000;
    if (isdefined(self.zombie_cost)) {
        cost = self.zombie_cost;
    }
    self zm_utility::set_hint_string(self, "default_buy_debris", cost);
    self setcursorhint("HINT_NOICON");
    if (isdefined(self.script_flag) && !isdefined(level.flag[self.script_flag])) {
        level flag::init(self.script_flag);
    }
    if (isdefined(self.target)) {
        targets = getentarray(self.target, "targetname");
        foreach (target in targets) {
            if (target iszbarrier()) {
                for (i = 0; i < target getnumzbarrierpieces(); i++) {
                    target setzbarrierpiecestate(i, "closed");
                }
            }
        }
        a_nd_targets = getnodearray(self.target, "targetname");
        foreach (nd_target in a_nd_targets) {
            if (isdefined(nd_target.script_noteworthy) && nd_target.script_noteworthy == "air_buy_gate") {
                unlinktraversal(nd_target);
            }
        }
    }
    self thread blocker_update_prompt_visibility();
    self thread debris_think();
}

// Namespace zm_blockers
// Params 0, eflags: 0x1 linked
// Checksum 0x851e8e17, Offset: 0x3cb8
// Size: 0x80e
function debris_think() {
    if (isdefined(level.var_b4339659)) {
        self [[ level.var_b4339659 ]]();
    }
    junk = getentarray(self.target, "targetname");
    for (i = 0; i < junk.size; i++) {
        if (isdefined(junk[i].script_noteworthy)) {
            if (junk[i].script_noteworthy == "clip") {
                junk[i] disconnectpaths();
            }
        }
    }
    while (true) {
        who, force = self waittill(#"trigger");
        if (isdefined(force) && (getdvarint("zombie_unlock_all") > 0 || force)) {
        } else {
            if (!who usebuttonpressed()) {
                continue;
            }
            if (who.is_drinking > 0) {
                continue;
            }
            if (who zm_utility::in_revive_trigger()) {
                continue;
            }
        }
        if (zm_utility::is_player_valid(who)) {
            players = getplayers();
            if (getdvarint("zombie_unlock_all") > 0) {
            } else if (who zm_score::can_player_purchase(self.zombie_cost)) {
                who zm_score::minus_to_player_score(self.zombie_cost);
                scoreevents::processscoreevent("open_door", who);
                demo::bookmark("zm_player_door", gettime(), who);
                who zm_stats::increment_client_stat("doors_purchased");
                who zm_stats::increment_player_stat("doors_purchased");
                who zm_stats::increment_challenge_stat("SURVIVALIST_BUY_DOOR");
            } else {
                zm_utility::play_sound_at_pos("no_purchase", self.origin);
                who zm_audio::create_and_play_dialog("general", "outofmoney");
                continue;
            }
            self notify(#"kill_debris_prompt_thread");
            junk = getentarray(self.target, "targetname");
            if (isdefined(self.script_flag)) {
                tokens = strtok(self.script_flag, ",");
                for (i = 0; i < tokens.size; i++) {
                    level flag::set(tokens[i]);
                }
            }
            zm_utility::play_sound_at_pos("purchase", self.origin);
            level notify(#"hash_bf60bc80");
            move_ent = undefined;
            a_clip = [];
            for (i = 0; i < junk.size; i++) {
                junk[i] connectpaths();
                if (isdefined(junk[i].script_noteworthy)) {
                    if (junk[i].script_noteworthy == "clip") {
                        a_clip[a_clip.size] = junk[i];
                        continue;
                    }
                }
                struct = undefined;
                if (junk[i] iszbarrier()) {
                    move_ent = junk[i];
                    junk[i] thread debris_zbarrier_move();
                    continue;
                }
                if (isdefined(junk[i].script_linkto)) {
                    struct = struct::get(junk[i].script_linkto, "script_linkname");
                    if (isdefined(struct)) {
                        move_ent = junk[i];
                        junk[i] thread debris_move(struct);
                    } else {
                        junk[i] delete();
                    }
                    continue;
                }
                if (isdefined(junk[i].target)) {
                    struct = struct::get(junk[i].target, "targetname");
                    if (isdefined(struct)) {
                        move_ent = junk[i];
                        junk[i] thread debris_move(struct);
                    } else {
                        junk[i] delete();
                    }
                    continue;
                }
                junk[i] delete();
            }
            a_nd_targets = getnodearray(self.target, "targetname");
            foreach (nd_target in a_nd_targets) {
                if (isdefined(nd_target.script_noteworthy) && nd_target.script_noteworthy == "air_buy_gate") {
                    linktraversal(nd_target);
                }
            }
            var_302c97b6 = getentarray(self.target, "target");
            for (i = 0; i < var_302c97b6.size; i++) {
                var_302c97b6[i] delete();
            }
            for (i = 0; i < a_clip.size; i++) {
                a_clip[i] delete();
            }
            if (isdefined(move_ent)) {
                move_ent waittill(#"movedone");
            }
            break;
        }
    }
}

// Namespace zm_blockers
// Params 0, eflags: 0x1 linked
// Checksum 0xc3054619, Offset: 0x44d0
// Size: 0xa6
function debris_zbarrier_move() {
    playsoundatposition("zmb_lightning_l", self.origin);
    playfx(level._effect["poltergeist"], self.origin);
    for (i = 0; i < self getnumzbarrierpieces(); i++) {
        self thread move_chunk(i, 1);
    }
}

// Namespace zm_blockers
// Params 0, eflags: 0x1 linked
// Checksum 0x7314b695, Offset: 0x4580
// Size: 0x56
function door_zbarrier_move() {
    for (i = 0; i < self getnumzbarrierpieces(); i++) {
        self thread move_chunk(i, 0);
    }
}

// Namespace zm_blockers
// Params 2, eflags: 0x1 linked
// Checksum 0x11261679, Offset: 0x45e0
// Size: 0x94
function move_chunk(index, b_hide) {
    self setzbarrierpiecestate(index, "opening");
    while (self getzbarrierpiecestate(index) == "opening") {
        wait(0.1);
    }
    self notify(#"movedone");
    if (b_hide) {
        self hidezbarrierpiece(index);
    }
}

// Namespace zm_blockers
// Params 1, eflags: 0x1 linked
// Checksum 0x2cc9dd33, Offset: 0x4680
// Size: 0x2f4
function debris_move(struct) {
    self util::script_delay();
    self notsolid();
    self zm_utility::play_sound_on_ent("debris_move");
    playsoundatposition("zmb_lightning_l", self.origin);
    if (isdefined(self.script_firefx)) {
        playfx(level._effect[self.script_firefx], self.origin);
    }
    if (isdefined(self.script_noteworthy)) {
        if (self.script_noteworthy == "jiggle") {
            num = randomintrange(3, 5);
            og_angles = self.angles;
            for (i = 0; i < num; i++) {
                angles = og_angles + (-5 + randomfloat(10), -5 + randomfloat(10), -5 + randomfloat(10));
                time = randomfloatrange(0.1, 0.4);
                self rotateto(angles, time);
                wait(time - 0.05);
            }
        }
    }
    time = 0.5;
    if (isdefined(self.script_transition_time)) {
        time = self.script_transition_time;
    }
    self moveto(struct.origin, time, time * 0.5);
    self rotateto(struct.angles, time * 0.75);
    self waittill(#"movedone");
    if (isdefined(self.script_fxid)) {
        playfx(level._effect[self.script_fxid], self.origin);
        playsoundatposition("zmb_zombie_spawn", self.origin);
    }
    self delete();
}

// Namespace zm_blockers
// Params 3, eflags: 0x1 linked
// Checksum 0x8d9da19, Offset: 0x4980
// Size: 0x1c
function blocker_disconnect_paths(start_node, end_node, two_way) {
    
}

// Namespace zm_blockers
// Params 3, eflags: 0x1 linked
// Checksum 0x7045c17a, Offset: 0x49a8
// Size: 0x1c
function blocker_connect_paths(start_node, end_node, two_way) {
    
}

// Namespace zm_blockers
// Params 0, eflags: 0x1 linked
// Checksum 0xa1169536, Offset: 0x49d0
// Size: 0x87c
function blocker_init() {
    if (!isdefined(self.target)) {
        return;
    }
    pos = zm_utility::groundpos(self.origin) + (0, 0, 8);
    if (isdefined(pos)) {
        self.origin = pos;
    }
    targets = getentarray(self.target, "targetname");
    self.barrier_chunks = [];
    for (j = 0; j < targets.size; j++) {
        if (targets[j] iszbarrier()) {
            if (isdefined(level.zbarrier_override)) {
                self thread [[ level.zbarrier_override ]](targets[j]);
                continue;
            }
            self.zbarrier = targets[j];
            self.zbarrier.chunk_health = [];
            for (i = 0; i < self.zbarrier getnumzbarrierpieces(); i++) {
                self.zbarrier.chunk_health[i] = 0;
            }
            continue;
        }
        if (isdefined(targets[j].script_string) && targets[j].script_string == "rock") {
            targets[j].material = "rock";
        }
        if (isdefined(targets[j].script_parameters)) {
            if (targets[j].script_parameters == "grate") {
                if (isdefined(targets[j].script_noteworthy)) {
                    if (targets[j].script_noteworthy == "2" || targets[j].script_noteworthy == "3" || targets[j].script_noteworthy == "4" || targets[j].script_noteworthy == "5" || targets[j].script_noteworthy == "6") {
                        targets[j] hide();
                        /#
                            iprintlnbold("targetname");
                        #/
                    }
                }
            } else if (targets[j].script_parameters == "repair_board") {
                targets[j].unbroken_section = getent(targets[j].target, "targetname");
                if (isdefined(targets[j].unbroken_section)) {
                    targets[j].unbroken_section linkto(targets[j]);
                    targets[j] hide();
                    targets[j] notsolid();
                    targets[j].unbroken = 1;
                    if (isdefined(targets[j].unbroken_section.script_noteworthy) && targets[j].unbroken_section.script_noteworthy == "glass") {
                        targets[j].material = "glass";
                        targets[j] thread destructible_glass_barricade(targets[j].unbroken_section, self);
                    } else if (isdefined(targets[j].unbroken_section.script_noteworthy) && targets[j].unbroken_section.script_noteworthy == "metal") {
                        targets[j].material = "metal";
                    }
                }
            } else if (targets[j].script_parameters == "barricade_vents") {
                targets[j].material = "metal_vent";
            }
        }
        if (isdefined(targets[j].targetname)) {
            if (targets[j].targetname == "auto2") {
            }
        }
        targets[j] update_states("repaired");
        targets[j].destroyed = 0;
        targets[j] show();
        targets[j].claimed = 0;
        targets[j].anim_grate_index = 0;
        targets[j].og_origin = targets[j].origin;
        targets[j].og_angles = targets[j].angles;
        self.barrier_chunks[self.barrier_chunks.size] = targets[j];
    }
    target_nodes = getnodearray(self.target, "targetname");
    for (j = 0; j < target_nodes.size; j++) {
        if (target_nodes[j].type == "Begin") {
            self.neg_start = target_nodes[j];
            if (isdefined(self.neg_start.target)) {
                self.neg_end = getnode(self.neg_start.target, "targetname");
            }
            blocker_disconnect_paths(self.neg_start, self.neg_end);
        }
    }
    if (isdefined(self.zbarrier)) {
        if (isdefined(self.barrier_chunks)) {
            for (i = 0; i < self.barrier_chunks.size; i++) {
                self.barrier_chunks[i] delete();
            }
            self.barrier_chunks = [];
        }
    }
    if (isdefined(self.zbarrier) && should_delete_zbarriers()) {
        self.zbarrier delete();
        self.zbarrier = undefined;
        return;
    }
    self blocker_attack_spots();
    self.trigger_location = struct::get(self.target, "targetname");
    self thread blocker_think();
}

// Namespace zm_blockers
// Params 0, eflags: 0x1 linked
// Checksum 0xcf2aa762, Offset: 0x5258
// Size: 0x70
function should_delete_zbarriers() {
    gametype = getdvarstring("ui_gametype");
    if (!zm_utility::is_classic() && !zm_utility::is_standard() && gametype != "zgrief") {
        return true;
    }
    return false;
}

// Namespace zm_blockers
// Params 2, eflags: 0x1 linked
// Checksum 0x840a7d05, Offset: 0x52d0
// Size: 0x10c
function destructible_glass_barricade(unbroken_section, node) {
    unbroken_section setcandamage(1);
    unbroken_section.health = 99999;
    amount, who = unbroken_section waittill(#"damage");
    if (zm_utility::is_player_valid(who) || who laststand::player_is_in_laststand()) {
        self thread zm_spawner::zombie_boardtear_offset_fx_horizontle(self, node);
        level thread remove_chunk(self, node, 1);
        self update_states("destroyed");
        self notify(#"destroyed");
        self.unbroken = 0;
    }
}

// Namespace zm_blockers
// Params 0, eflags: 0x1 linked
// Checksum 0xe0ba3f46, Offset: 0x53e8
// Size: 0x28c
function blocker_attack_spots() {
    spots = [];
    numslots = self.zbarrier getzbarriernumattackslots();
    numslots = int(max(numslots, 1));
    if (numslots % 2) {
        spots[spots.size] = zm_utility::groundpos_ignore_water_new(self.zbarrier.origin + (0, 0, 60));
    }
    if (numslots > 1) {
        reps = floor(numslots / 2);
        slot = 1;
        for (i = 0; i < reps; i++) {
            offset = self.zbarrier getzbarrierattackslothorzoffset() * (i + 1);
            spots[spots.size] = zm_utility::groundpos_ignore_water_new(spots[0] + anglestoright(self.angles) * offset + (0, 0, 60));
            slot++;
            if (slot < numslots) {
                spots[spots.size] = zm_utility::groundpos_ignore_water_new(spots[0] + anglestoright(self.angles) * offset * -1 + (0, 0, 60));
                slot++;
            }
        }
    }
    taken = [];
    for (i = 0; i < spots.size; i++) {
        taken[i] = 0;
    }
    self.attack_spots_taken = taken;
    self.attack_spots = spots;
    /#
        self thread zm_utility::debug_attack_spots_taken();
    #/
}

// Namespace zm_blockers
// Params 0, eflags: 0x1 linked
// Checksum 0x8988ba94, Offset: 0x5680
// Size: 0x3c
function blocker_choke() {
    level._blocker_choke = 0;
    level endon(#"stop_blocker_think");
    while (true) {
        wait(0.05);
        level._blocker_choke = 0;
    }
}

// Namespace zm_blockers
// Params 0, eflags: 0x1 linked
// Checksum 0xc078e8d9, Offset: 0x56c8
// Size: 0x100
function blocker_think() {
    level endon(#"stop_blocker_think");
    if (!isdefined(level._blocker_choke)) {
        level thread blocker_choke();
    }
    use_choke = 0;
    if (isdefined(level._use_choke_blockers) && level._use_choke_blockers == 1) {
        use_choke = 1;
    }
    while (true) {
        wait(0.5);
        if (use_choke) {
            if (level._blocker_choke > 3) {
                wait(0.05);
            }
        }
        level._blocker_choke++;
        if (zm_utility::all_chunks_intact(self, self.barrier_chunks)) {
            continue;
        }
        if (zm_utility::no_valid_repairable_boards(self, self.barrier_chunks)) {
            continue;
        }
        self blocker_trigger_think();
    }
}

// Namespace zm_blockers
// Params 4, eflags: 0x1 linked
// Checksum 0x62993391, Offset: 0x57d0
// Size: 0x12a
function player_fails_blocker_repair_trigger_preamble(player, players, trigger, hold_required) {
    if (!isdefined(trigger)) {
        return true;
    }
    if (!zm_utility::is_player_valid(player)) {
        return true;
    }
    if (players.size == 1 && isdefined(players[0].intermission) && players[0].intermission == 1) {
        return true;
    }
    if (hold_required && !player usebuttonpressed()) {
        return true;
    }
    if (!hold_required && !player util::use_button_held()) {
        return true;
    }
    if (player zm_utility::in_revive_trigger()) {
        return true;
    }
    if (player.is_drinking > 0) {
        return true;
    }
    return false;
}

// Namespace zm_blockers
// Params 0, eflags: 0x1 linked
// Checksum 0xf0cc700e, Offset: 0x5908
// Size: 0x48
function has_blocker_affecting_perk() {
    has_perk = undefined;
    if (self hasperk("specialty_fastreload")) {
        has_perk = "specialty_fastreload";
    }
    return has_perk;
}

// Namespace zm_blockers
// Params 1, eflags: 0x1 linked
// Checksum 0x9308b040, Offset: 0x5958
// Size: 0x2c
function do_post_chunk_repair_delay(has_perk) {
    if (!self util::script_delay()) {
        wait(1);
    }
}

// Namespace zm_blockers
// Params 2, eflags: 0x1 linked
// Checksum 0xd7519d7c, Offset: 0x5990
// Size: 0x154
function handle_post_board_repair_rewards(cost, zbarrier) {
    self zm_stats::increment_client_stat("boards");
    self zm_stats::increment_player_stat("boards");
    if (isdefined(self.pers["boards"]) && self.pers["boards"] % 10 == 0) {
        self zm_audio::create_and_play_dialog("general", "rebuild_boards");
    }
    self namespace_25f8c2ad::function_66dcadff(zbarrier);
    self.rebuild_barrier_reward += cost;
    if (self.rebuild_barrier_reward < level.zombie_vars["rebuild_barrier_cap_per_round"]) {
        self zm_score::player_add_points("rebuild_board", cost);
        self zm_utility::play_sound_on_ent("purchase");
    }
    if (isdefined(self.board_repair)) {
        self.board_repair += 1;
    }
}

// Namespace zm_blockers
// Params 0, eflags: 0x1 linked
// Checksum 0xdbb0b0de, Offset: 0x5af0
// Size: 0x54
function blocker_unitrigger_think() {
    self endon(#"kill_trigger");
    while (true) {
        player = self waittill(#"trigger");
        self.stub.trigger_target notify(#"trigger", player);
    }
}

// Namespace zm_blockers
// Params 0, eflags: 0x1 linked
// Checksum 0x7a7c8da2, Offset: 0x5b50
// Size: 0xa3e
function blocker_trigger_think() {
    self endon(#"blocker_hacked");
    if (isdefined(level.no_board_repair) && level.no_board_repair) {
        return;
    }
    /#
        println("targetname");
    #/
    level endon(#"stop_blocker_think");
    cost = 10;
    if (isdefined(self.zombie_cost)) {
        cost = self.zombie_cost;
    }
    original_cost = cost;
    if (!isdefined(self.unitrigger_stub)) {
        radius = 94.21;
        height = 94.21;
        if (isdefined(self.trigger_location)) {
            trigger_location = self.trigger_location;
        } else {
            trigger_location = self;
        }
        if (isdefined(trigger_location.radius)) {
            radius = trigger_location.radius;
        }
        if (isdefined(trigger_location.height)) {
            height = trigger_location.height;
        }
        trigger_pos = zm_utility::groundpos(trigger_location.origin) + (0, 0, 4);
        self.unitrigger_stub = spawnstruct();
        self.unitrigger_stub.origin = trigger_pos;
        self.unitrigger_stub.radius = radius;
        self.unitrigger_stub.height = height;
        self.unitrigger_stub.script_unitrigger_type = "unitrigger_radius";
        self.unitrigger_stub.hint_string = zm_utility::get_hint_string(self, "default_reward_barrier_piece");
        self.unitrigger_stub.cursor_hint = "HINT_NOICON";
        self.unitrigger_stub.trigger_target = self;
        zm_unitrigger::unitrigger_force_per_player_triggers(self.unitrigger_stub, 1);
        self.unitrigger_stub.prompt_and_visibility_func = &blockertrigger_update_prompt;
        zm_unitrigger::register_static_unitrigger(self.unitrigger_stub, &blocker_unitrigger_think);
        zm_unitrigger::unregister_unitrigger(self.unitrigger_stub);
        if (!isdefined(trigger_location.angles)) {
            trigger_location.angles = (0, 0, 0);
        }
        self.unitrigger_stub.origin = zm_utility::groundpos(trigger_location.origin) + (0, 0, 4) + anglestoforward(trigger_location.angles) * -11;
    }
    self thread trigger_delete_on_repair();
    thread zm_unitrigger::register_static_unitrigger(self.unitrigger_stub, &blocker_unitrigger_think);
    /#
        if (getdvarint("targetname") > 0) {
            thread zm_utility::debug_blocker(trigger_pos, radius, height);
        }
    #/
    while (true) {
        player = self waittill(#"trigger");
        has_perk = player has_blocker_affecting_perk();
        if (zm_utility::all_chunks_intact(self, self.barrier_chunks)) {
            self notify(#"all_boards_repaired");
            return;
        }
        if (zm_utility::no_valid_repairable_boards(self, self.barrier_chunks)) {
            self notify(#"hash_46d36511");
            return;
        }
        if (isdefined(level._zm_blocker_trigger_think_return_override)) {
            if (self [[ level._zm_blocker_trigger_think_return_override ]](player)) {
                return;
            }
        }
        while (true) {
            players = getplayers();
            trigger = self.unitrigger_stub zm_unitrigger::unitrigger_trigger(player);
            if (player_fails_blocker_repair_trigger_preamble(player, players, trigger, 0)) {
                break;
            }
            player notify(#"boarding_window", self);
            if (isdefined(self.zbarrier)) {
                chunk = zm_utility::get_random_destroyed_chunk(self, self.barrier_chunks);
                self thread replace_chunk(self, chunk, has_perk, isdefined(player.var_698f7e["board"]) && player.var_698f7e["board"]);
            } else {
                chunk = zm_utility::get_random_destroyed_chunk(self, self.barrier_chunks);
                if (isdefined(chunk.script_parameter) && chunk.script_parameters == "repair_board" || chunk.script_parameters == "barricade_vents") {
                    if (isdefined(chunk.unbroken_section)) {
                        chunk show();
                        chunk solid();
                        chunk.unbroken_section zm_utility::self_delete();
                    }
                } else {
                    chunk show();
                }
                if (!isdefined(chunk.script_parameters) || chunk.script_parameters == "board" || chunk.script_parameters == "repair_board" || chunk.script_parameters == "barricade_vents") {
                    if (!(isdefined(level.use_clientside_board_fx) && level.use_clientside_board_fx)) {
                        if (isdefined(chunk.material) && (!isdefined(chunk.material) || chunk.material != "rock")) {
                            chunk zm_utility::play_sound_on_ent("rebuild_barrier_piece");
                        }
                        playsoundatposition("zmb_cha_ching", (0, 0, 0));
                    }
                }
                if (chunk.script_parameters == "bar") {
                    chunk zm_utility::play_sound_on_ent("rebuild_barrier_piece");
                    playsoundatposition("zmb_cha_ching", (0, 0, 0));
                }
                if (isdefined(chunk.script_parameters)) {
                    if (chunk.script_parameters == "bar") {
                        if (isdefined(chunk.script_noteworthy)) {
                            if (chunk.script_noteworthy == "5") {
                                chunk hide();
                            } else if (chunk.script_noteworthy == "3") {
                                chunk hide();
                            }
                        }
                    }
                }
                self thread replace_chunk(self, chunk, has_perk, isdefined(player.var_698f7e["board"]) && player.var_698f7e["board"]);
            }
            if (isdefined(self.clip)) {
                self.clip triggerenable(1);
                self.clip disconnectpaths();
            } else {
                blocker_disconnect_paths(self.neg_start, self.neg_end);
            }
            self do_post_chunk_repair_delay(has_perk);
            if (!zm_utility::is_player_valid(player)) {
                break;
            }
            player handle_post_board_repair_rewards(cost, self);
            if (zm_utility::all_chunks_intact(self, self.barrier_chunks)) {
                self notify(#"all_boards_repaired");
                player increment_window_repaired();
                return;
            }
            if (zm_utility::no_valid_repairable_boards(self, self.barrier_chunks)) {
                self notify(#"hash_46d36511");
                player increment_window_repaired(self);
                return;
            }
        }
    }
}

// Namespace zm_blockers
// Params 1, eflags: 0x1 linked
// Checksum 0xcd92605e, Offset: 0x6598
// Size: 0x64
function increment_window_repaired(s_barrier) {
    self zm_stats::increment_challenge_stat("SURVIVALIST_BOARD");
    self incrementplayerstat("windowsBoarded", 1);
    self thread zm_daily_challenges::increment_windows_repaired(s_barrier);
}

// Namespace zm_blockers
// Params 1, eflags: 0x1 linked
// Checksum 0x6fa21fce, Offset: 0x6608
// Size: 0x80
function blockertrigger_update_prompt(player) {
    can_use = self.stub blockerstub_update_prompt(player);
    self setinvisibletoplayer(player, !can_use);
    self sethintstring(self.stub.hint_string);
    return can_use;
}

// Namespace zm_blockers
// Params 1, eflags: 0x1 linked
// Checksum 0x756338f2, Offset: 0x6690
// Size: 0x66
function blockerstub_update_prompt(player) {
    if (!zm_utility::is_player_valid(player)) {
        return false;
    }
    if (player zm_utility::in_revive_trigger()) {
        return false;
    }
    if (player.is_drinking > 0) {
        return false;
    }
    return true;
}

// Namespace zm_blockers
// Params 0, eflags: 0x0
// Checksum 0x3403525f, Offset: 0x6700
// Size: 0x24
function random_destroyed_chunk_show() {
    wait(0.5);
    self show();
}

// Namespace zm_blockers
// Params 0, eflags: 0x0
// Checksum 0x717675b5, Offset: 0x6730
// Size: 0xbe
function door_repaired_rumble_n_sound() {
    players = getplayers();
    for (i = 0; i < players.size; i++) {
        if (distance(players[i].origin, self.origin) < -106) {
            if (isalive(players[i])) {
                players[i] thread board_completion();
            }
        }
    }
}

// Namespace zm_blockers
// Params 0, eflags: 0x1 linked
// Checksum 0xd6eb5ff4, Offset: 0x67f8
// Size: 0xe
function board_completion() {
    self endon(#"disconnect");
}

// Namespace zm_blockers
// Params 0, eflags: 0x1 linked
// Checksum 0x22c65212, Offset: 0x6810
// Size: 0x54
function trigger_delete_on_repair() {
    while (true) {
        self util::waittill_either("all_boards_repaired", "no valid boards");
        zm_unitrigger::unregister_unitrigger(self.unitrigger_stub);
        break;
    }
}

// Namespace zm_blockers
// Params 0, eflags: 0x1 linked
// Checksum 0x42f8c4c9, Offset: 0x6870
// Size: 0x10
function rebuild_barrier_reward_reset() {
    self.rebuild_barrier_reward = 0;
}

// Namespace zm_blockers
// Params 4, eflags: 0x1 linked
// Checksum 0x1e03388f, Offset: 0x6888
// Size: 0xe9c
function remove_chunk(chunk, node, destroy_immediately, zomb) {
    chunk update_states("mid_tear");
    if (isdefined(chunk.script_parameters)) {
        if (chunk.script_parameters == "board" || chunk.script_parameters == "repair_board" || chunk.script_parameters == "barricade_vents") {
            chunk thread zombie_boardtear_audio_offset(chunk);
        }
    }
    if (isdefined(chunk.script_parameters)) {
        if (chunk.script_parameters == "bar") {
            chunk thread zombie_bartear_audio_offset(chunk);
        }
    }
    chunk notsolid();
    fx = "wood_chunk_destory";
    if (isdefined(self.script_fxid)) {
        fx = self.script_fxid;
    }
    if (isdefined(chunk.script_moveoverride) && chunk.script_moveoverride) {
        chunk hide();
    }
    if (isdefined(chunk.script_parameters) && chunk.script_parameters == "bar") {
        if (isdefined(chunk.script_noteworthy) && chunk.script_noteworthy == "4") {
            ent = spawn("script_origin", chunk.origin);
            ent.angles = node.angles + (0, 180, 0);
            dist = 100;
            if (isdefined(chunk.script_move_dist)) {
                dist_max = chunk.script_move_dist - 100;
                dist = 100 + randomint(dist_max);
            } else {
                dist = 100 + randomint(100);
            }
            dest = ent.origin + anglestoforward(ent.angles) * dist;
            trace = bullettrace(dest + (0, 0, 16), dest + (0, 0, -200), 0, undefined);
            if (trace["fraction"] == 1) {
                dest += (0, 0, -200);
            } else {
                dest = trace["position"];
            }
            chunk linkto(ent);
            time = ent zm_utility::fake_physicslaunch(dest, 300 + randomint(100));
            if (randomint(100) > 40) {
                ent rotatepitch(-76, time * 0.5);
            } else {
                ent rotatepitch(90, time, time * 0.5);
            }
            wait(time);
            chunk hide();
            wait(0.1);
            ent delete();
        } else {
            ent = spawn("script_origin", chunk.origin);
            ent.angles = node.angles + (0, 180, 0);
            dist = 100;
            if (isdefined(chunk.script_move_dist)) {
                dist_max = chunk.script_move_dist - 100;
                dist = 100 + randomint(dist_max);
            } else {
                dist = 100 + randomint(100);
            }
            dest = ent.origin + anglestoforward(ent.angles) * dist;
            trace = bullettrace(dest + (0, 0, 16), dest + (0, 0, -200), 0, undefined);
            if (trace["fraction"] == 1) {
                dest += (0, 0, -200);
            } else {
                dest = trace["position"];
            }
            chunk linkto(ent);
            time = ent zm_utility::fake_physicslaunch(dest, 260 + randomint(100));
            if (randomint(100) > 40) {
                ent rotatepitch(-76, time * 0.5);
            } else {
                ent rotatepitch(90, time, time * 0.5);
            }
            wait(time);
            chunk hide();
            wait(0.1);
            ent delete();
        }
        chunk update_states("destroyed");
        chunk notify(#"destroyed");
    }
    if (isdefined(chunk.script_parameters) && chunk.script_parameters == "board" || chunk.script_parameters == "repair_board" || chunk.script_parameters == "barricade_vents") {
        ent = spawn("script_origin", chunk.origin);
        ent.angles = node.angles + (0, 180, 0);
        dist = 100;
        if (isdefined(chunk.script_move_dist)) {
            dist_max = chunk.script_move_dist - 100;
            dist = 100 + randomint(dist_max);
        } else {
            dist = 100 + randomint(100);
        }
        dest = ent.origin + anglestoforward(ent.angles) * dist;
        trace = bullettrace(dest + (0, 0, 16), dest + (0, 0, -200), 0, undefined);
        if (trace["fraction"] == 1) {
            dest += (0, 0, -200);
        } else {
            dest = trace["position"];
        }
        chunk linkto(ent);
        time = ent zm_utility::fake_physicslaunch(dest, -56 + randomint(100));
        if (isdefined(chunk.unbroken_section)) {
            if (!isdefined(chunk.material) || chunk.material != "metal") {
                chunk.unbroken_section zm_utility::self_delete();
            }
        }
        if (randomint(100) > 40) {
            ent rotatepitch(-76, time * 0.5);
        } else {
            ent rotatepitch(90, time, time * 0.5);
        }
        wait(time);
        if (isdefined(chunk.unbroken_section)) {
            if (isdefined(chunk.material) && chunk.material == "metal") {
                chunk.unbroken_section zm_utility::self_delete();
            }
        }
        chunk hide();
        wait(0.1);
        ent delete();
        chunk update_states("destroyed");
        chunk notify(#"destroyed");
    }
    if (isdefined(chunk.script_parameters) && chunk.script_parameters == "grate") {
        if (isdefined(chunk.script_noteworthy) && chunk.script_noteworthy == "6") {
            ent = spawn("script_origin", chunk.origin);
            ent.angles = node.angles + (0, 180, 0);
            dist = 100 + randomint(100);
            dest = ent.origin + anglestoforward(ent.angles) * dist;
            trace = bullettrace(dest + (0, 0, 16), dest + (0, 0, -200), 0, undefined);
            if (trace["fraction"] == 1) {
                dest += (0, 0, -200);
            } else {
                dest = trace["position"];
            }
            chunk linkto(ent);
            time = ent zm_utility::fake_physicslaunch(dest, -56 + randomint(100));
            if (randomint(100) > 40) {
                ent rotatepitch(-76, time * 0.5);
            } else {
                ent rotatepitch(90, time, time * 0.5);
            }
            wait(time);
            chunk hide();
            ent delete();
            chunk update_states("destroyed");
            chunk notify(#"destroyed");
            return;
        }
        chunk hide();
        chunk update_states("destroyed");
        chunk notify(#"destroyed");
    }
}

// Namespace zm_blockers
// Params 1, eflags: 0x0
// Checksum 0x7efb958d, Offset: 0x7730
// Size: 0x7e
function remove_chunk_rotate_grate(chunk) {
    if (isdefined(chunk.script_parameters) && chunk.script_parameters == "grate") {
        chunk vibrate((0, 270, 0), 0.2, 0.4, 0.4);
        return;
    }
}

// Namespace zm_blockers
// Params 1, eflags: 0x1 linked
// Checksum 0x131296ae, Offset: 0x77b8
// Size: 0x360
function zombie_boardtear_audio_offset(chunk) {
    if (isdefined(chunk.material) && !isdefined(chunk.already_broken)) {
        chunk.already_broken = 0;
    }
    if (isdefined(chunk.material) && chunk.material == "glass" && chunk.already_broken == 0) {
        chunk playsound("zmb_break_glass_barrier");
        wait(randomfloatrange(0.3, 0.6));
        chunk playsound("zmb_break_glass_barrier");
        chunk.already_broken = 1;
        return;
    }
    if (isdefined(chunk.material) && chunk.material == "metal" && chunk.already_broken == 0) {
        chunk playsound("grab_metal_bar");
        wait(randomfloatrange(0.3, 0.6));
        chunk playsound("break_metal_bar");
        chunk.already_broken = 1;
        return;
    }
    if (isdefined(chunk.material) && chunk.material == "rock") {
        if (!(isdefined(level.use_clientside_rock_tearin_fx) && level.use_clientside_rock_tearin_fx)) {
            chunk playsound("zmb_break_rock_barrier");
            wait(randomfloatrange(0.3, 0.6));
            chunk playsound("zmb_break_rock_barrier");
        }
        chunk.already_broken = 1;
        return;
    }
    if (isdefined(chunk.material) && chunk.material == "metal_vent") {
        if (!(isdefined(level.use_clientside_board_fx) && level.use_clientside_board_fx)) {
            chunk playsound("evt_vent_slat_remove");
        }
        return;
    }
    if (!(isdefined(level.use_clientside_board_fx) && level.use_clientside_board_fx)) {
        chunk zm_utility::play_sound_on_ent("break_barrier_piece");
        wait(randomfloatrange(0.3, 0.6));
        chunk zm_utility::play_sound_on_ent("break_barrier_piece");
    }
    chunk.already_broken = 1;
}

// Namespace zm_blockers
// Params 1, eflags: 0x1 linked
// Checksum 0xa816d188, Offset: 0x7b20
// Size: 0xac
function zombie_bartear_audio_offset(chunk) {
    chunk zm_utility::play_sound_on_ent("grab_metal_bar");
    wait(randomfloatrange(0.3, 0.6));
    chunk zm_utility::play_sound_on_ent("break_metal_bar");
    wait(randomfloatrange(1, 1.3));
    chunk zm_utility::play_sound_on_ent("drop_metal_bar");
}

// Namespace zm_blockers
// Params 1, eflags: 0x0
// Checksum 0x1afbe53d, Offset: 0x7bd8
// Size: 0x52
function ensure_chunk_is_back_to_origin(chunk) {
    if (chunk.origin != chunk.og_origin) {
        chunk notsolid();
        chunk waittill(#"movedone");
    }
}

// Namespace zm_blockers
// Params 5, eflags: 0x1 linked
// Checksum 0xc09a985a, Offset: 0x7c38
// Size: 0x2b6
function replace_chunk(barrier, chunk, perk, upgrade, via_powerup) {
    if (!isdefined(barrier.zbarrier)) {
        chunk update_states("mid_repair");
        /#
            assert(isdefined(chunk.og_origin));
        #/
        /#
            assert(isdefined(chunk.og_angles));
        #/
        sound = "rebuild_barrier_hover";
        if (isdefined(chunk.script_presound)) {
            sound = chunk.script_presound;
        }
    }
    has_perk = 0;
    if (isdefined(perk)) {
        has_perk = 1;
    }
    if (!isdefined(via_powerup) && isdefined(sound)) {
        zm_utility::play_sound_at_pos(sound, chunk.origin);
    }
    if (upgrade) {
        barrier.zbarrier zbarrierpieceuseupgradedmodel(chunk);
        barrier.zbarrier.chunk_health[chunk] = barrier.zbarrier getupgradedpiecenumlives(chunk);
    } else {
        barrier.zbarrier zbarrierpieceusedefaultmodel(chunk);
        barrier.zbarrier.chunk_health[chunk] = 0;
    }
    scalar = 1;
    if (has_perk) {
        if ("specialty_fastreload" == perk) {
            scalar = 0.31;
        }
    }
    barrier.zbarrier showzbarrierpiece(chunk);
    barrier.zbarrier setzbarrierpiecestate(chunk, "closing", scalar);
    waitduration = barrier.zbarrier getzbarrierpieceanimlengthforstate(chunk, "closing", scalar);
    wait(waitduration);
}

// Namespace zm_blockers
// Params 0, eflags: 0x0
// Checksum 0x3b39ffd2, Offset: 0x7ef8
// Size: 0x17a
function open_all_zbarriers() {
    foreach (barrier in level.exterior_goals) {
        if (isdefined(barrier.zbarrier)) {
            for (x = 0; x < barrier.zbarrier getnumzbarrierpieces(); x++) {
                barrier.zbarrier setzbarrierpiecestate(x, "opening");
            }
        }
        if (isdefined(barrier.clip)) {
            barrier.clip triggerenable(0);
            barrier.clip connectpaths();
            continue;
        }
        blocker_connect_paths(barrier.neg_start, barrier.neg_end);
    }
}

// Namespace zm_blockers
// Params 1, eflags: 0x0
// Checksum 0x112829a9, Offset: 0x8080
// Size: 0x1fc
function zombie_boardtear_audio_plus_fx_offset_repair_horizontal(chunk) {
    if (isdefined(chunk.material) && chunk.material == "rock") {
        if (isdefined(level.use_clientside_rock_tearin_fx) && level.use_clientside_rock_tearin_fx) {
            chunk clientfield::set("tearin_rock_fx", 0);
        } else {
            earthquake(randomfloatrange(0.3, 0.4), randomfloatrange(0.2, 0.4), chunk.origin, -106);
            wait(randomfloatrange(0.3, 0.6));
            chunk zm_utility::play_sound_on_ent("break_barrier_piece");
        }
        return;
    }
    if (isdefined(level.use_clientside_board_fx) && level.use_clientside_board_fx) {
        chunk clientfield::set("tearin_board_vertical_fx", 0);
        return;
    }
    earthquake(randomfloatrange(0.3, 0.4), randomfloatrange(0.2, 0.4), chunk.origin, -106);
    wait(randomfloatrange(0.3, 0.6));
    chunk zm_utility::play_sound_on_ent("break_barrier_piece");
}

// Namespace zm_blockers
// Params 1, eflags: 0x0
// Checksum 0xcb16809c, Offset: 0x8288
// Size: 0x1fc
function zombie_boardtear_audio_plus_fx_offset_repair_verticle(chunk) {
    if (isdefined(chunk.material) && chunk.material == "rock") {
        if (isdefined(level.use_clientside_rock_tearin_fx) && level.use_clientside_rock_tearin_fx) {
            chunk clientfield::set("tearin_rock_fx", 0);
        } else {
            earthquake(randomfloatrange(0.3, 0.4), randomfloatrange(0.2, 0.4), chunk.origin, -106);
            wait(randomfloatrange(0.3, 0.6));
            chunk zm_utility::play_sound_on_ent("break_barrier_piece");
        }
        return;
    }
    if (isdefined(level.use_clientside_board_fx) && level.use_clientside_board_fx) {
        chunk clientfield::set("tearin_board_horizontal_fx", 0);
        return;
    }
    earthquake(randomfloatrange(0.3, 0.4), randomfloatrange(0.2, 0.4), chunk.origin, -106);
    wait(randomfloatrange(0.3, 0.6));
    chunk zm_utility::play_sound_on_ent("break_barrier_piece");
}

// Namespace zm_blockers
// Params 1, eflags: 0x0
// Checksum 0xb4a7d4bb, Offset: 0x8490
// Size: 0x55e
function zombie_gratetear_audio_plus_fx_offset_repair_horizontal(chunk) {
    earthquake(randomfloatrange(0.3, 0.4), randomfloatrange(0.2, 0.4), chunk.origin, -106);
    chunk zm_utility::play_sound_on_ent("bar_rebuild_slam");
    switch (randomint(9)) {
    case 0:
        playfx(level._effect["fx_zombie_bar_break"], chunk.origin + (-30, 0, 0));
        wait(randomfloatrange(0, 0.3));
        playfx(level._effect["fx_zombie_bar_break_lite"], chunk.origin + (-30, 0, 0));
        break;
    case 1:
        playfx(level._effect["fx_zombie_bar_break"], chunk.origin + (-30, 0, 0));
        wait(randomfloatrange(0, 0.3));
        playfx(level._effect["fx_zombie_bar_break"], chunk.origin + (-30, 0, 0));
        break;
    case 2:
        playfx(level._effect["fx_zombie_bar_break_lite"], chunk.origin + (-30, 0, 0));
        wait(randomfloatrange(0, 0.3));
        playfx(level._effect["fx_zombie_bar_break"], chunk.origin + (-30, 0, 0));
        break;
    case 3:
        playfx(level._effect["fx_zombie_bar_break"], chunk.origin + (-30, 0, 0));
        wait(randomfloatrange(0, 0.3));
        playfx(level._effect["fx_zombie_bar_break_lite"], chunk.origin + (-30, 0, 0));
        break;
    case 4:
        playfx(level._effect["fx_zombie_bar_break_lite"], chunk.origin + (-30, 0, 0));
        wait(randomfloatrange(0, 0.3));
        playfx(level._effect["fx_zombie_bar_break_lite"], chunk.origin + (-30, 0, 0));
        break;
    case 5:
        playfx(level._effect["fx_zombie_bar_break_lite"], chunk.origin + (-30, 0, 0));
        break;
    case 6:
        playfx(level._effect["fx_zombie_bar_break_lite"], chunk.origin + (-30, 0, 0));
        break;
    case 7:
        playfx(level._effect["fx_zombie_bar_break"], chunk.origin + (-30, 0, 0));
        break;
    case 8:
        playfx(level._effect["fx_zombie_bar_break"], chunk.origin + (-30, 0, 0));
        break;
    }
}

// Namespace zm_blockers
// Params 1, eflags: 0x0
// Checksum 0xc2f0fb78, Offset: 0x89f8
// Size: 0x47e
function zombie_bartear_audio_plus_fx_offset_repair_horizontal(chunk) {
    earthquake(randomfloatrange(0.3, 0.4), randomfloatrange(0.2, 0.4), chunk.origin, -106);
    chunk zm_utility::play_sound_on_ent("bar_rebuild_slam");
    switch (randomint(9)) {
    case 0:
        playfxontag(level._effect["fx_zombie_bar_break_lite"], chunk, "Tag_fx_left");
        wait(randomfloatrange(0, 0.3));
        playfxontag(level._effect["fx_zombie_bar_break_lite"], chunk, "Tag_fx_right");
        break;
    case 1:
        playfxontag(level._effect["fx_zombie_bar_break"], chunk, "Tag_fx_left");
        wait(randomfloatrange(0, 0.3));
        playfxontag(level._effect["fx_zombie_bar_break"], chunk, "Tag_fx_right");
        break;
    case 2:
        playfxontag(level._effect["fx_zombie_bar_break_lite"], chunk, "Tag_fx_left");
        wait(randomfloatrange(0, 0.3));
        playfxontag(level._effect["fx_zombie_bar_break"], chunk, "Tag_fx_right");
        break;
    case 3:
        playfxontag(level._effect["fx_zombie_bar_break"], chunk, "Tag_fx_left");
        wait(randomfloatrange(0, 0.3));
        playfxontag(level._effect["fx_zombie_bar_break_lite"], chunk, "Tag_fx_right");
        break;
    case 4:
        playfxontag(level._effect["fx_zombie_bar_break_lite"], chunk, "Tag_fx_left");
        wait(randomfloatrange(0, 0.3));
        playfxontag(level._effect["fx_zombie_bar_break_lite"], chunk, "Tag_fx_right");
        break;
    case 5:
        playfxontag(level._effect["fx_zombie_bar_break_lite"], chunk, "Tag_fx_left");
        break;
    case 6:
        playfxontag(level._effect["fx_zombie_bar_break_lite"], chunk, "Tag_fx_right");
        break;
    case 7:
        playfxontag(level._effect["fx_zombie_bar_break"], chunk, "Tag_fx_left");
        break;
    case 8:
        playfxontag(level._effect["fx_zombie_bar_break"], chunk, "Tag_fx_right");
        break;
    }
}

// Namespace zm_blockers
// Params 1, eflags: 0x0
// Checksum 0x3c7fe774, Offset: 0x8e80
// Size: 0x47e
function zombie_bartear_audio_plus_fx_offset_repair_verticle(chunk) {
    earthquake(randomfloatrange(0.3, 0.4), randomfloatrange(0.2, 0.4), chunk.origin, -106);
    chunk zm_utility::play_sound_on_ent("bar_rebuild_slam");
    switch (randomint(9)) {
    case 0:
        playfxontag(level._effect["fx_zombie_bar_break_lite"], chunk, "Tag_fx_top");
        wait(randomfloatrange(0, 0.3));
        playfxontag(level._effect["fx_zombie_bar_break_lite"], chunk, "Tag_fx_bottom");
        break;
    case 1:
        playfxontag(level._effect["fx_zombie_bar_break"], chunk, "Tag_fx_top");
        wait(randomfloatrange(0, 0.3));
        playfxontag(level._effect["fx_zombie_bar_break"], chunk, "Tag_fx_bottom");
        break;
    case 2:
        playfxontag(level._effect["fx_zombie_bar_break_lite"], chunk, "Tag_fx_top");
        wait(randomfloatrange(0, 0.3));
        playfxontag(level._effect["fx_zombie_bar_break"], chunk, "Tag_fx_bottom");
        break;
    case 3:
        playfxontag(level._effect["fx_zombie_bar_break"], chunk, "Tag_fx_top");
        wait(randomfloatrange(0, 0.3));
        playfxontag(level._effect["fx_zombie_bar_break_lite"], chunk, "Tag_fx_bottom");
        break;
    case 4:
        playfxontag(level._effect["fx_zombie_bar_break_lite"], chunk, "Tag_fx_top");
        wait(randomfloatrange(0, 0.3));
        playfxontag(level._effect["fx_zombie_bar_break_lite"], chunk, "Tag_fx_bottom");
        break;
    case 5:
        playfxontag(level._effect["fx_zombie_bar_break_lite"], chunk, "Tag_fx_top");
        break;
    case 6:
        playfxontag(level._effect["fx_zombie_bar_break_lite"], chunk, "Tag_fx_bottom");
        break;
    case 7:
        playfxontag(level._effect["fx_zombie_bar_break"], chunk, "Tag_fx_top");
        break;
    case 8:
        playfxontag(level._effect["fx_zombie_bar_break"], chunk, "Tag_fx_bottom");
        break;
    }
}

// Namespace zm_blockers
// Params 0, eflags: 0x1 linked
// Checksum 0xf795bb75, Offset: 0x9308
// Size: 0x19c
function flag_blocker() {
    if (!isdefined(self.script_flag_wait)) {
        /#
            assertmsg("targetname" + self.origin + "targetname");
        #/
        return;
    }
    if (!isdefined(level.flag[self.script_flag_wait])) {
        level flag::init(self.script_flag_wait);
    }
    type = "connectpaths";
    if (isdefined(self.script_noteworthy)) {
        type = self.script_noteworthy;
    }
    level flag::wait_till(self.script_flag_wait);
    self util::script_delay();
    if (type == "connectpaths") {
        self connectpaths();
        self triggerenable(0);
        return;
    }
    if (type == "disconnectpaths") {
        self disconnectpaths();
        self triggerenable(0);
        return;
    }
    /#
        assertmsg("targetname" + self.origin + "targetname" + type + "targetname");
    #/
}

// Namespace zm_blockers
// Params 1, eflags: 0x1 linked
// Checksum 0x813a9a6a, Offset: 0x94b0
// Size: 0x38
function update_states(states) {
    /#
        assert(isdefined(states));
    #/
    self.state = states;
}

// Namespace zm_blockers
// Params 1, eflags: 0x1 linked
// Checksum 0x145bd163, Offset: 0x94f0
// Size: 0x1be
function quantum_bomb_open_nearest_door_validation(position) {
    range_squared = 32400;
    zombie_doors = getentarray("zombie_door", "targetname");
    for (i = 0; i < zombie_doors.size; i++) {
        if (distancesquared(zombie_doors[i].origin, position) < range_squared) {
            return true;
        }
    }
    zombie_airlock_doors = getentarray("zombie_airlock_buy", "targetname");
    for (i = 0; i < zombie_airlock_doors.size; i++) {
        if (distancesquared(zombie_airlock_doors[i].origin, position) < range_squared) {
            return true;
        }
    }
    zombie_debris = getentarray("zombie_debris", "targetname");
    for (i = 0; i < zombie_debris.size; i++) {
        if (distancesquared(zombie_debris[i].origin, position) < range_squared) {
            return true;
        }
    }
    return false;
}

// Namespace zm_blockers
// Params 1, eflags: 0x1 linked
// Checksum 0x582c6ea, Offset: 0x96b8
// Size: 0x2ac
function quantum_bomb_open_nearest_door_result(position) {
    range_squared = 32400;
    zombie_doors = getentarray("zombie_door", "targetname");
    for (i = 0; i < zombie_doors.size; i++) {
        if (distancesquared(zombie_doors[i].origin, position) < range_squared) {
            self thread zm_audio::create_and_play_dialog("kill", "quant_good");
            zombie_doors[i] notify(#"trigger", self, 1);
            [[ level.var_9acc1b55 ]](position);
            return;
        }
    }
    zombie_airlock_doors = getentarray("zombie_airlock_buy", "targetname");
    for (i = 0; i < zombie_airlock_doors.size; i++) {
        if (distancesquared(zombie_airlock_doors[i].origin, position) < range_squared) {
            self thread zm_audio::create_and_play_dialog("kill", "quant_good");
            zombie_airlock_doors[i] notify(#"trigger", self, 1);
            [[ level.var_9acc1b55 ]](position);
            return;
        }
    }
    zombie_debris = getentarray("zombie_debris", "targetname");
    for (i = 0; i < zombie_debris.size; i++) {
        if (distancesquared(zombie_debris[i].origin, position) < range_squared) {
            self thread zm_audio::create_and_play_dialog("kill", "quant_good");
            zombie_debris[i] notify(#"trigger", self, 1);
            [[ level.var_9acc1b55 ]](position);
            return;
        }
    }
}

