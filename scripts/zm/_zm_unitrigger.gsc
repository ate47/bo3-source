#using scripts/zm/_zm_zonemgr;
#using scripts/zm/_zm_utility;
#using scripts/shared/system_shared;
#using scripts/codescripts/struct;

#namespace zm_unitrigger;

// Namespace zm_unitrigger
// Params 0, eflags: 0x2
// Checksum 0x6140a4a0, Offset: 0x1d0
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("zm_unitrigger", &__init__, undefined, undefined);
}

// Namespace zm_unitrigger
// Params 0, eflags: 0x1 linked
// Checksum 0x65117478, Offset: 0x210
// Size: 0x186
function __init__() {
    level._unitriggers = spawnstruct();
    level._unitriggers._deferredinitlist = [];
    level._unitriggers.trigger_pool = [];
    level._unitriggers.trigger_stubs = [];
    level._unitriggers.dynamic_stubs = [];
    level._unitriggers.var_e1e4cb2b = [];
    level._unitriggers.largest_radius = 64;
    stubs_keys = array("unitrigger_radius", "unitrigger_radius_use", "unitrigger_box", "unitrigger_box_use");
    stubs = [];
    for (i = 0; i < stubs_keys.size; i++) {
        stubs = arraycombine(stubs, struct::get_array(stubs_keys[i], "script_unitrigger_type"), 1, 0);
    }
    for (i = 0; i < stubs.size; i++) {
        register_unitrigger(stubs[i]);
    }
}

// Namespace zm_unitrigger
// Params 2, eflags: 0x0
// Checksum 0x53e903a9, Offset: 0x3a0
// Size: 0x2e
function function_b36886ca(system, trigger_func) {
    level._unitriggers.var_e1e4cb2b[system] = trigger_func;
}

// Namespace zm_unitrigger
// Params 2, eflags: 0x1 linked
// Checksum 0xe95d81de, Offset: 0x3d8
// Size: 0x3c
function unitrigger_force_per_player_triggers(unitrigger_stub, opt_on_off) {
    if (!isdefined(opt_on_off)) {
        opt_on_off = 1;
    }
    unitrigger_stub.trigger_per_player = opt_on_off;
}

// Namespace zm_unitrigger
// Params 1, eflags: 0x1 linked
// Checksum 0xcf3a0dea, Offset: 0x420
// Size: 0x44
function unitrigger_trigger(player) {
    if (self.trigger_per_player) {
        return self.playertrigger[player getentitynumber()];
    }
    return self.trigger;
}

// Namespace zm_unitrigger
// Params 0, eflags: 0x1 linked
// Checksum 0x86403248, Offset: 0x470
// Size: 0x40
function unitrigger_origin() {
    if (isdefined(self.originfunc)) {
        origin = self [[ self.originfunc ]]();
    } else {
        origin = self.origin;
    }
    return origin;
}

// Namespace zm_unitrigger
// Params 2, eflags: 0x1 linked
// Checksum 0xe6f19965, Offset: 0x4b8
// Size: 0x454
function register_unitrigger_internal(unitrigger_stub, trigger_func) {
    if (!isdefined(unitrigger_stub.script_unitrigger_type)) {
        /#
            println("trigger_radius");
        #/
        return;
    }
    if (isdefined(trigger_func)) {
        unitrigger_stub.trigger_func = trigger_func;
    } else if (isdefined(unitrigger_stub.var_509dbcad) && isdefined(level._unitriggers.var_e1e4cb2b[unitrigger_stub.var_509dbcad])) {
        unitrigger_stub.trigger_func = level._unitriggers.var_e1e4cb2b[unitrigger_stub.var_509dbcad];
    }
    switch (unitrigger_stub.script_unitrigger_type) {
    case 4:
    case 3:
        if (!isdefined(unitrigger_stub.radius)) {
            unitrigger_stub.radius = 32;
        }
        if (!isdefined(unitrigger_stub.script_height)) {
            unitrigger_stub.script_height = 64;
        }
        unitrigger_stub.test_radius_sq = (unitrigger_stub.radius + 15) * (unitrigger_stub.radius + 15);
        break;
    case 2:
    case 1:
        if (!isdefined(unitrigger_stub.script_width)) {
            unitrigger_stub.script_width = 64;
        }
        if (!isdefined(unitrigger_stub.script_height)) {
            unitrigger_stub.script_height = 64;
        }
        if (!isdefined(unitrigger_stub.script_length)) {
            unitrigger_stub.script_length = 64;
        }
        box_radius = length((unitrigger_stub.script_width / 2, unitrigger_stub.script_length / 2, unitrigger_stub.script_height / 2));
        if (!isdefined(unitrigger_stub.radius) || unitrigger_stub.radius < box_radius) {
            unitrigger_stub.radius = box_radius;
        }
        unitrigger_stub.test_radius_sq = (box_radius + 15) * (box_radius + 15);
        break;
    default:
        /#
            println("trigger_radius" + unitrigger_stub.targetname + "trigger_radius");
        #/
        return;
    }
    if (unitrigger_stub.radius > level._unitriggers.largest_radius) {
        level._unitriggers.largest_radius = min(113, unitrigger_stub.radius);
        if (isdefined(level.fixed_max_player_use_radius)) {
            if (level.fixed_max_player_use_radius > getdvarfloat("player_useRadius_zm")) {
                setdvar("player_useRadius_zm", level.fixed_max_player_use_radius);
            }
        } else if (level._unitriggers.largest_radius > getdvarfloat("player_useRadius_zm")) {
            setdvar("player_useRadius_zm", level._unitriggers.largest_radius);
        }
    }
    level._unitriggers.trigger_stubs[level._unitriggers.trigger_stubs.size] = unitrigger_stub;
    unitrigger_stub.registered = 1;
}

// Namespace zm_unitrigger
// Params 2, eflags: 0x1 linked
// Checksum 0x135963cc, Offset: 0x918
// Size: 0x52
function register_unitrigger(unitrigger_stub, trigger_func) {
    register_unitrigger_internal(unitrigger_stub, trigger_func);
    level._unitriggers.dynamic_stubs[level._unitriggers.dynamic_stubs.size] = unitrigger_stub;
}

// Namespace zm_unitrigger
// Params 1, eflags: 0x1 linked
// Checksum 0xeea88a3d, Offset: 0x978
// Size: 0x24
function unregister_unitrigger(unitrigger_stub) {
    thread unregister_unitrigger_internal(unitrigger_stub);
}

// Namespace zm_unitrigger
// Params 1, eflags: 0x1 linked
// Checksum 0xd5f889d8, Offset: 0x9a8
// Size: 0x27c
function unregister_unitrigger_internal(unitrigger_stub) {
    if (!isdefined(unitrigger_stub)) {
        return;
    }
    unitrigger_stub.registered = 0;
    if (isdefined(unitrigger_stub.trigger_per_player) && unitrigger_stub.trigger_per_player) {
        if (isdefined(unitrigger_stub.playertrigger) && unitrigger_stub.playertrigger.size > 0) {
            keys = getarraykeys(unitrigger_stub.playertrigger);
            foreach (key in keys) {
                trigger = unitrigger_stub.playertrigger[key];
                trigger notify(#"kill_trigger");
                if (isdefined(trigger)) {
                    trigger delete();
                }
            }
            unitrigger_stub.playertrigger = [];
        }
    } else if (isdefined(unitrigger_stub.trigger)) {
        trigger = unitrigger_stub.trigger;
        trigger notify(#"kill_trigger");
        trigger.stub.trigger = undefined;
        trigger delete();
    }
    if (isdefined(unitrigger_stub.in_zone)) {
        arrayremovevalue(level.zones[unitrigger_stub.in_zone].unitrigger_stubs, unitrigger_stub);
        unitrigger_stub.in_zone = undefined;
    }
    arrayremovevalue(level._unitriggers.trigger_stubs, unitrigger_stub);
    arrayremovevalue(level._unitriggers.dynamic_stubs, unitrigger_stub);
}

// Namespace zm_unitrigger
// Params 0, eflags: 0x1 linked
// Checksum 0x90d1f616, Offset: 0xc30
// Size: 0x58
function function_ab72f23() {
    self.last_used_time = 0;
    while (true) {
        wait(1);
        if (gettime() - self.last_used_time > 1000) {
            self delete();
            level._unitriggers.var_ffa8a87d = undefined;
            return;
        }
    }
}

// Namespace zm_unitrigger
// Params 3, eflags: 0x1 linked
// Checksum 0xd510e196, Offset: 0xc90
// Size: 0x2fc
function register_static_unitrigger(unitrigger_stub, trigger_func, recalculate_zone) {
    if (level.zones.size == 0) {
        unitrigger_stub.trigger_func = trigger_func;
        level._unitriggers._deferredinitlist[level._unitriggers._deferredinitlist.size] = unitrigger_stub;
        return;
    }
    if (!isdefined(level._unitriggers.var_ffa8a87d)) {
        level._unitriggers.var_ffa8a87d = spawn("script_origin", (0, 0, 0));
        level._unitriggers.var_ffa8a87d thread function_ab72f23();
    }
    register_unitrigger_internal(unitrigger_stub, trigger_func);
    if (!isdefined(level.var_4b56b872)) {
        level._unitriggers.var_ffa8a87d.last_used_time = gettime();
        level._unitriggers.var_ffa8a87d.origin = unitrigger_stub.origin;
        if (isdefined(unitrigger_stub.in_zone) && !isdefined(recalculate_zone)) {
            level.zones[unitrigger_stub.in_zone].unitrigger_stubs[level.zones[unitrigger_stub.in_zone].unitrigger_stubs.size] = unitrigger_stub;
            return;
        }
        keys = getarraykeys(level.zones);
        for (i = 0; i < keys.size; i++) {
            if (level._unitriggers.var_ffa8a87d zm_zonemgr::entity_in_zone(keys[i], 1)) {
                if (!isdefined(level.zones[keys[i]].unitrigger_stubs)) {
                    level.zones[keys[i]].unitrigger_stubs = [];
                }
                level.zones[keys[i]].unitrigger_stubs[level.zones[keys[i]].unitrigger_stubs.size] = unitrigger_stub;
                unitrigger_stub.in_zone = keys[i];
                return;
            }
        }
    }
    level._unitriggers.dynamic_stubs[level._unitriggers.dynamic_stubs.size] = unitrigger_stub;
    unitrigger_stub.registered = 1;
}

// Namespace zm_unitrigger
// Params 3, eflags: 0x1 linked
// Checksum 0x5b53c926, Offset: 0xf98
// Size: 0x11c
function register_dyn_unitrigger(unitrigger_stub, trigger_func, recalculate_zone) {
    if (level.zones.size == 0) {
        unitrigger_stub.trigger_func = trigger_func;
        level._unitriggers._deferredinitlist[level._unitriggers._deferredinitlist.size] = unitrigger_stub;
        return;
    }
    if (!isdefined(level._unitriggers.var_ffa8a87d)) {
        level._unitriggers.var_ffa8a87d = spawn("script_origin", (0, 0, 0));
        level._unitriggers.var_ffa8a87d thread function_ab72f23();
    }
    register_unitrigger_internal(unitrigger_stub, trigger_func);
    level._unitriggers.dynamic_stubs[level._unitriggers.dynamic_stubs.size] = unitrigger_stub;
    unitrigger_stub.registered = 1;
}

// Namespace zm_unitrigger
// Params 1, eflags: 0x1 linked
// Checksum 0xeaae30a3, Offset: 0x10c0
// Size: 0x44
function reregister_unitrigger_as_dynamic(unitrigger_stub) {
    unregister_unitrigger_internal(unitrigger_stub);
    register_unitrigger(unitrigger_stub, unitrigger_stub.trigger_func);
}

// Namespace zm_unitrigger
// Params 0, eflags: 0x1 linked
// Checksum 0xb652e09d, Offset: 0x1110
// Size: 0x33c
function debug_unitriggers() {
    /#
        while (true) {
            if (getdvarint("trigger_radius") > 0) {
                for (i = 0; i < level._unitriggers.trigger_stubs.size; i++) {
                    triggerstub = level._unitriggers.trigger_stubs[i];
                    color = (0.75, 0, 0);
                    if (!isdefined(triggerstub.in_zone)) {
                        color = (0.65, 0.65, 0);
                    } else if (level.zones[triggerstub.in_zone].is_active) {
                        color = (1, 1, 0);
                    }
                    if (isdefined(triggerstub.playertrigger) && (isdefined(triggerstub.trigger) || triggerstub.playertrigger.size > 0)) {
                        color = (0, 1, 0);
                        if (isdefined(triggerstub.playertrigger) && triggerstub.playertrigger.size > 0) {
                            print3d(triggerstub.origin, triggerstub.playertrigger.size, color, 1, 1, 1);
                        }
                    }
                    origin = triggerstub unitrigger_origin();
                    switch (triggerstub.script_unitrigger_type) {
                    case 8:
                    case 8:
                        if (triggerstub.radius) {
                            circle(origin, triggerstub.radius, color, 0, 0, 1);
                        }
                        if (triggerstub.script_height) {
                            line(origin, origin + (0, 0, triggerstub.script_height), color, 0, 1);
                        }
                        break;
                    case 8:
                    case 8:
                        vec = (triggerstub.script_width / 2, triggerstub.script_length / 2, triggerstub.script_height / 2);
                        box(origin, vec * -1, vec, triggerstub.angles[1], color, 1, 0, 1);
                        break;
                    }
                }
            }
            wait(0.05);
        }
    #/
}

// Namespace zm_unitrigger
// Params 2, eflags: 0x1 linked
// Checksum 0xd7ab0599, Offset: 0x1458
// Size: 0xe4
function cleanup_trigger(trigger, player) {
    trigger notify(#"kill_trigger");
    if (isdefined(trigger.stub.trigger_per_player) && trigger.stub.trigger_per_player) {
        trigger.stub.playertrigger[player getentitynumber()] = undefined;
    } else {
        trigger.stub.trigger = undefined;
    }
    trigger delete();
    level._unitriggers.trigger_pool[player getentitynumber()] = undefined;
}

// Namespace zm_unitrigger
// Params 4, eflags: 0x1 linked
// Checksum 0x1b7be5e9, Offset: 0x1548
// Size: 0x1c4
function assess_and_apply_visibility(trigger, stub, player, default_keep) {
    if (!isdefined(trigger) || !isdefined(stub)) {
        return 0;
    }
    keep_thread = default_keep;
    if (!isdefined(stub.prompt_and_visibility_func) || trigger [[ stub.prompt_and_visibility_func ]](player)) {
        keep_thread = 1;
        if (!(isdefined(trigger.thread_running) && trigger.thread_running)) {
            trigger thread trigger_thread(trigger.stub.trigger_func);
        }
        trigger.thread_running = 1;
        if (isdefined(trigger.reassess_time) && trigger.reassess_time <= 0) {
            trigger.reassess_time = undefined;
        }
    } else {
        if (isdefined(trigger.thread_running) && trigger.thread_running) {
            keep_thread = 0;
        }
        trigger.thread_running = 0;
        if (isdefined(stub.inactive_reassess_time)) {
            trigger.reassess_time = stub.inactive_reassess_time;
        } else {
            trigger.reassess_time = 1;
        }
    }
    return keep_thread;
}

// Namespace zm_unitrigger
// Params 0, eflags: 0x1 linked
// Checksum 0x7723f0f5, Offset: 0x1718
// Size: 0x9b4
function main() {
    level thread debug_unitriggers();
    if (level._unitriggers._deferredinitlist.size) {
        for (i = 0; i < level._unitriggers._deferredinitlist.size; i++) {
            register_static_unitrigger(level._unitriggers._deferredinitlist[i], level._unitriggers._deferredinitlist[i].trigger_func);
        }
        for (i = 0; i < level._unitriggers._deferredinitlist.size; i++) {
            level._unitriggers._deferredinitlist[i] = undefined;
        }
        level._unitriggers._deferredinitlist = undefined;
    }
    valid_range = level._unitriggers.largest_radius + 15;
    valid_range_sq = valid_range * valid_range;
    while (!isdefined(level.active_zone_names)) {
        wait(0.1);
    }
    while (true) {
        waited = 0;
        active_zone_names = level.active_zone_names;
        candidate_list = [];
        for (j = 0; j < active_zone_names.size; j++) {
            if (isdefined(level.zones[active_zone_names[j]].unitrigger_stubs)) {
                candidate_list = arraycombine(candidate_list, level.zones[active_zone_names[j]].unitrigger_stubs, 1, 0);
            }
        }
        candidate_list = arraycombine(candidate_list, level._unitriggers.dynamic_stubs, 1, 0);
        players = getplayers();
        for (i = 0; i < players.size; i++) {
            player = players[i];
            if (!isdefined(player)) {
                continue;
            }
            player_origin = player.origin + (0, 0, 35);
            trigger = level._unitriggers.trigger_pool[player getentitynumber()];
            old_trigger = undefined;
            closest = [];
            if (isdefined(trigger)) {
                dst = valid_range_sq;
                origin = trigger unitrigger_origin();
                dst = trigger.stub.test_radius_sq;
                time_to_ressess = 0;
                trigger_still_valid = 0;
                if (distance2dsquared(player_origin, origin) < dst) {
                    if (isdefined(trigger.reassess_time)) {
                        trigger.reassess_time -= 0.05;
                        if (trigger.reassess_time > 0) {
                            continue;
                        }
                        time_to_ressess = 1;
                    }
                    trigger_still_valid = 1;
                }
                closest = get_closest_unitriggers(player_origin, candidate_list, valid_range);
                if (isdefined(trigger.thread_running) && (closest.size < 2 || isdefined(trigger) && time_to_ressess && trigger.thread_running)) {
                    if (assess_and_apply_visibility(trigger, trigger.stub, player, 1)) {
                        continue;
                    }
                }
                if (trigger_still_valid && closest.size < 2) {
                    if (assess_and_apply_visibility(trigger, trigger.stub, player, 1)) {
                        continue;
                    }
                }
                if (trigger_still_valid) {
                    old_trigger = trigger;
                    trigger = undefined;
                    level._unitriggers.trigger_pool[player getentitynumber()] = undefined;
                } else if (isdefined(trigger)) {
                    cleanup_trigger(trigger, player);
                }
            } else {
                closest = get_closest_unitriggers(player_origin, candidate_list, valid_range);
            }
            index = 0;
            first_usable = undefined;
            first_visible = undefined;
            trigger_found = 0;
            while (index < closest.size) {
                if (!zm_utility::is_player_valid(player) && !(isdefined(closest[index].ignore_player_valid) && closest[index].ignore_player_valid)) {
                    index++;
                    continue;
                }
                if (!(isdefined(closest[index].registered) && closest[index].registered)) {
                    index++;
                    continue;
                }
                trigger = check_and_build_trigger_from_unitrigger_stub(closest[index], player);
                if (isdefined(trigger)) {
                    trigger.parent_player = player;
                    if (assess_and_apply_visibility(trigger, closest[index], player, 0)) {
                        if (player zm_utility::is_player_looking_at(closest[index].origin, 0.9, 0)) {
                            if (!is_same_trigger(old_trigger, trigger) && isdefined(old_trigger)) {
                                cleanup_trigger(old_trigger, player);
                            }
                            level._unitriggers.trigger_pool[player getentitynumber()] = trigger;
                            trigger_found = 1;
                            break;
                        }
                        if (!isdefined(first_usable)) {
                            first_usable = index;
                        }
                    }
                    if (!isdefined(first_visible)) {
                        first_visible = index;
                    }
                    if (isdefined(trigger)) {
                        if (is_same_trigger(old_trigger, trigger)) {
                            level._unitriggers.trigger_pool[player getentitynumber()] = undefined;
                        } else {
                            cleanup_trigger(trigger, player);
                        }
                    }
                    last_trigger = trigger;
                }
                index++;
                waited = 1;
                wait(0.05);
            }
            if (!isdefined(player)) {
                continue;
            }
            if (trigger_found) {
                continue;
            }
            if (isdefined(first_usable)) {
                index = first_usable;
            } else if (isdefined(first_visible)) {
                index = first_visible;
            }
            trigger = check_and_build_trigger_from_unitrigger_stub(closest[index], player);
            if (isdefined(trigger)) {
                trigger.parent_player = player;
                level._unitriggers.trigger_pool[player getentitynumber()] = trigger;
                if (is_same_trigger(old_trigger, trigger)) {
                    continue;
                }
                if (isdefined(old_trigger)) {
                    cleanup_trigger(old_trigger, player);
                }
                if (isdefined(trigger)) {
                    assess_and_apply_visibility(trigger, trigger.stub, player, 0);
                }
            }
        }
        if (!waited) {
            wait(0.05);
        }
    }
}

// Namespace zm_unitrigger
// Params 0, eflags: 0x1 linked
// Checksum 0x4ba63b8, Offset: 0x20d8
// Size: 0x128
function run_visibility_function_for_all_triggers() {
    if (!isdefined(self.prompt_and_visibility_func)) {
        return;
    }
    if (isdefined(self.trigger_per_player) && self.trigger_per_player) {
        if (!isdefined(self.playertrigger)) {
            return;
        }
        players = getplayers();
        for (i = 0; i < players.size; i++) {
            if (isdefined(self.playertrigger[players[i] getentitynumber()])) {
                self.playertrigger[players[i] getentitynumber()] [[ self.prompt_and_visibility_func ]](players[i]);
            }
        }
        return;
    }
    if (isdefined(self.trigger)) {
        self.trigger [[ self.prompt_and_visibility_func ]](getplayers()[0]);
    }
}

// Namespace zm_unitrigger
// Params 2, eflags: 0x1 linked
// Checksum 0x8a578fbd, Offset: 0x2208
// Size: 0x48
function is_same_trigger(old_trigger, trigger) {
    return isdefined(old_trigger) && old_trigger == trigger && trigger.parent_player == old_trigger.parent_player;
}

// Namespace zm_unitrigger
// Params 2, eflags: 0x1 linked
// Checksum 0x7ceac4a9, Offset: 0x2258
// Size: 0x190
function check_and_build_trigger_from_unitrigger_stub(stub, player) {
    if (!isdefined(stub)) {
        return undefined;
    }
    if (isdefined(stub.trigger_per_player) && stub.trigger_per_player) {
        if (!isdefined(stub.playertrigger)) {
            stub.playertrigger = [];
        }
        if (!isdefined(stub.playertrigger[player getentitynumber()])) {
            trigger = build_trigger_from_unitrigger_stub(stub, player);
            level._unitriggers.trigger_pool[player getentitynumber()] = trigger;
        } else {
            trigger = stub.playertrigger[player getentitynumber()];
        }
    } else if (!isdefined(stub.trigger)) {
        trigger = build_trigger_from_unitrigger_stub(stub, player);
        level._unitriggers.trigger_pool[player getentitynumber()] = trigger;
    } else {
        trigger = stub.trigger;
    }
    return trigger;
}

// Namespace zm_unitrigger
// Params 2, eflags: 0x1 linked
// Checksum 0x39b46354, Offset: 0x23f0
// Size: 0x5fc
function build_trigger_from_unitrigger_stub(stub, player) {
    if (isdefined(level.var_29d862d9)) {
        if (stub [[ level.var_29d862d9 ]](player)) {
            return;
        }
    }
    radius = stub.radius;
    if (!isdefined(radius)) {
        radius = 64;
    }
    script_height = stub.script_height;
    if (!isdefined(script_height)) {
        script_height = 64;
    }
    script_width = stub.script_width;
    if (!isdefined(script_width)) {
        script_width = 64;
    }
    script_length = stub.script_length;
    if (!isdefined(script_length)) {
        script_length = 64;
    }
    trigger = undefined;
    origin = stub unitrigger_origin();
    switch (stub.script_unitrigger_type) {
    case 4:
        trigger = spawn("trigger_radius", origin, 0, radius, script_height);
        break;
    case 3:
        trigger = spawn("trigger_radius_use", origin, 0, radius, script_height);
        break;
    case 2:
        trigger = spawn("trigger_box", origin, 0, script_width, script_length, script_height);
        break;
    case 1:
        trigger = spawn("trigger_box_use", origin, 0, script_width, script_length, script_height);
        break;
    }
    if (isdefined(trigger)) {
        if (isdefined(stub.angles)) {
            trigger.angles = stub.angles;
        }
        if (isdefined(stub.onspawnfunc)) {
            stub [[ stub.onspawnfunc ]](trigger);
        }
        if (isdefined(stub.cursor_hint)) {
            if (stub.cursor_hint == "HINT_WEAPON" && isdefined(stub.cursor_hint_weapon)) {
                trigger setcursorhint(stub.cursor_hint, stub.cursor_hint_weapon);
            } else {
                trigger setcursorhint(stub.cursor_hint);
            }
        }
        trigger triggerignoreteam();
        if (isdefined(stub.require_look_at) && stub.require_look_at) {
            trigger usetriggerrequirelookat();
        }
        if (isdefined(stub.require_look_toward) && stub.require_look_toward) {
            trigger usetriggerrequirelooktoward(1);
        }
        if (isdefined(stub.hint_string)) {
            if (isdefined(stub.hint_parm2)) {
                trigger sethintstring(stub.hint_string, stub.hint_parm1, stub.hint_parm2);
            } else if (isdefined(stub.hint_parm1)) {
                trigger sethintstring(stub.hint_string, stub.hint_parm1);
            } else if (isdefined(stub.cost) && !(isdefined(level.var_dc23b46e) && level.var_dc23b46e)) {
                trigger sethintstring(stub.hint_string, stub.cost);
            } else {
                trigger sethintstring(stub.hint_string);
            }
        }
        trigger.stub = stub;
    }
    copy_zombie_keys_onto_trigger(trigger, stub);
    if (isdefined(stub.trigger_per_player) && stub.trigger_per_player) {
        if (isdefined(trigger)) {
            trigger setinvisibletoall();
            trigger setvisibletoplayer(player);
        }
        if (!isdefined(stub.playertrigger)) {
            stub.playertrigger = [];
        }
        stub.playertrigger[player getentitynumber()] = trigger;
    } else {
        stub.trigger = trigger;
    }
    trigger.thread_running = 0;
    return trigger;
}

// Namespace zm_unitrigger
// Params 2, eflags: 0x1 linked
// Checksum 0x531403d8, Offset: 0x29f8
// Size: 0xbc
function copy_zombie_keys_onto_trigger(trig, stub) {
    trig.script_noteworthy = stub.script_noteworthy;
    trig.targetname = stub.targetname;
    trig.target = stub.target;
    trig.weapon = stub.weapon;
    trig.clientfieldname = stub.clientfieldname;
    trig.usetime = stub.usetime;
}

// Namespace zm_unitrigger
// Params 1, eflags: 0x1 linked
// Checksum 0xa5a9a85, Offset: 0x2ac0
// Size: 0x2e
function trigger_thread(trigger_func) {
    self endon(#"kill_trigger");
    if (isdefined(trigger_func)) {
        self [[ trigger_func ]]();
    }
}

// Namespace zm_unitrigger
// Params 3, eflags: 0x1 linked
// Checksum 0xf11f5a46, Offset: 0x2af8
// Size: 0x1f2
function get_closest_unitriggers(org, array, dist) {
    if (!isdefined(dist)) {
        dist = 9999999;
    }
    triggers = [];
    if (array.size < 1) {
        return triggers;
    }
    distsq = dist * dist;
    for (i = 0; i < array.size; i++) {
        if (!isdefined(array[i])) {
            continue;
        }
        origin = array[i] unitrigger_origin();
        radius_sq = array[i].test_radius_sq;
        newdistsq = distance2dsquared(origin, org);
        if (newdistsq >= radius_sq) {
            continue;
        }
        if (abs(origin[2] - org[2]) > 42) {
            continue;
        }
        array[i].dsquared = newdistsq;
        for (j = 0; j < triggers.size && newdistsq > triggers[j].dsquared; j++) {
        }
        arrayinsert(triggers, array[i], j);
    }
    return triggers;
}

// Namespace zm_unitrigger
// Params 5, eflags: 0x1 linked
// Checksum 0x6cd670b, Offset: 0x2cf8
// Size: 0x180
function create_unitrigger(str_hint, n_radius, var_616077d9, func_unitrigger_logic, s_trigger_type) {
    if (!isdefined(n_radius)) {
        n_radius = 64;
    }
    if (!isdefined(var_616077d9)) {
        var_616077d9 = &function_fcc6aab1;
    }
    if (!isdefined(func_unitrigger_logic)) {
        func_unitrigger_logic = &function_77c4e424;
    }
    if (!isdefined(s_trigger_type)) {
        s_trigger_type = "unitrigger_radius_use";
    }
    s_unitrigger = spawnstruct();
    s_unitrigger.origin = self.origin;
    s_unitrigger.angles = self.angles;
    s_unitrigger.script_unitrigger_type = s_trigger_type;
    s_unitrigger.cursor_hint = "HINT_NOICON";
    s_unitrigger.hint_string = str_hint;
    s_unitrigger.prompt_and_visibility_func = var_616077d9;
    s_unitrigger.related_parent = self;
    s_unitrigger.radius = n_radius;
    self.s_unitrigger = s_unitrigger;
    register_static_unitrigger(s_unitrigger, func_unitrigger_logic);
    return s_unitrigger;
}

// Namespace zm_unitrigger
// Params 5, eflags: 0x1 linked
// Checksum 0x9532399f, Offset: 0x2e80
// Size: 0x180
function function_828cd696(str_hint, n_radius, var_616077d9, func_unitrigger_logic, s_trigger_type) {
    if (!isdefined(n_radius)) {
        n_radius = 64;
    }
    if (!isdefined(var_616077d9)) {
        var_616077d9 = &function_fcc6aab1;
    }
    if (!isdefined(func_unitrigger_logic)) {
        func_unitrigger_logic = &function_77c4e424;
    }
    if (!isdefined(s_trigger_type)) {
        s_trigger_type = "unitrigger_radius_use";
    }
    s_unitrigger = spawnstruct();
    s_unitrigger.origin = self.origin;
    s_unitrigger.angles = self.angles;
    s_unitrigger.script_unitrigger_type = s_trigger_type;
    s_unitrigger.cursor_hint = "HINT_NOICON";
    s_unitrigger.hint_string = str_hint;
    s_unitrigger.prompt_and_visibility_func = var_616077d9;
    s_unitrigger.related_parent = self;
    s_unitrigger.radius = n_radius;
    self.s_unitrigger = s_unitrigger;
    register_dyn_unitrigger(s_unitrigger, func_unitrigger_logic);
    return s_unitrigger;
}

// Namespace zm_unitrigger
// Params 1, eflags: 0x1 linked
// Checksum 0xa74ecf5, Offset: 0x3008
// Size: 0x22
function function_fcc6aab1(player) {
    b_visible = 1;
    return b_visible;
}

// Namespace zm_unitrigger
// Params 0, eflags: 0x1 linked
// Checksum 0x27310e56, Offset: 0x3038
// Size: 0xa4
function function_77c4e424() {
    self endon(#"death");
    while (true) {
        player = self waittill(#"trigger");
        if (player zm_utility::in_revive_trigger()) {
            continue;
        }
        if (player.is_drinking > 0) {
            continue;
        }
        if (!zm_utility::is_player_valid(player)) {
            continue;
        }
        self.stub.related_parent notify(#"trigger_activated", player);
    }
}

