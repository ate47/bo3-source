#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/hud_util_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/array_shared;
#using scripts/codescripts/struct;

#namespace trigger;

// Namespace trigger
// Params 0, eflags: 0x2
// Checksum 0x382caaef, Offset: 0x3e0
// Size: 0x34
function function_2dc19561() {
    system::register("trigger", &__init__, undefined, undefined);
}

// Namespace trigger
// Params 0, eflags: 0x1 linked
// Checksum 0x1bd073ab, Offset: 0x420
// Size: 0x6a8
function __init__() {
    level.var_eb31f20 = undefined;
    level.trigger_hint_string = [];
    level.trigger_hint_func = [];
    if (!isdefined(level.trigger_flags)) {
        init_flags();
    }
    var_b4443147 = [];
    var_b4443147["trigger_unlock"] = &trigger_unlock;
    var_b4443147["flag_set"] = &flag_set_trigger;
    var_b4443147["flag_clear"] = &flag_clear_trigger;
    var_b4443147["flag_set_touching"] = &function_c6742dfe;
    var_b4443147["friendly_respawn_trigger"] = &friendly_respawn_trigger;
    var_b4443147["friendly_respawn_clear"] = &friendly_respawn_clear;
    var_b4443147["trigger_delete"] = &trigger_turns_off;
    var_b4443147["trigger_delete_on_touch"] = &trigger_delete_on_touch;
    var_b4443147["trigger_off"] = &trigger_turns_off;
    var_b4443147["delete_link_chain"] = &function_62964ea9;
    var_b4443147["no_crouch_or_prone"] = &function_5c8525c5;
    var_b4443147["no_prone"] = &function_555e49a2;
    var_b4443147["flood_spawner"] = &spawner::flood_trigger_think;
    var_b4443147["trigger_spawner"] = &trigger_spawner;
    var_b4443147["trigger_hint"] = &trigger_hint;
    var_b4443147["exploder"] = &function_c52b5655;
    foreach (trig in get_all("trigger_radius", "trigger_multiple", "trigger_once", "trigger_box")) {
        if (isdefined(trig.spawnflags) && (trig.spawnflags & 256) == 256) {
            level thread trigger_look(trig);
        }
    }
    foreach (trig in get_all()) {
        /#
            trig function_ad8ffc08();
        #/
        if (trig.classname != "trigger_damage") {
            if (trig.classname != "trigger_hurt") {
                if (isdefined(trig.spawnflags) && (trig.spawnflags & 32) == 32) {
                    level thread trigger_spawner(trig);
                }
            }
        }
        if (trig.classname != "trigger_once" && is_trigger_once(trig)) {
            level thread trigger_once(trig);
        }
        if (isdefined(trig.script_flag_true)) {
            level thread function_f1980fe1(trig);
        }
        if (isdefined(trig.script_flag_set)) {
            level thread flag_set_trigger(trig, trig.script_flag_set);
        }
        if (isdefined(trig.script_flag_set_on_touching) || isdefined(trig.var_ef42adb1)) {
            level thread script_flag_set_touching(trig);
        }
        if (isdefined(trig.script_flag_clear)) {
            level thread flag_clear_trigger(trig, trig.script_flag_clear);
        }
        if (isdefined(trig.script_flag_false)) {
            level thread function_83ff7020(trig);
        }
        if (isdefined(trig.script_trigger_group)) {
            trig thread trigger_group();
        }
        if (isdefined(trig.script_notify)) {
            level thread trigger_notify(trig, trig.script_notify);
        }
        if (isdefined(trig.var_31afeda1)) {
            level thread spawner::function_49ba1bae(trig);
        }
        if (isdefined(trig.script_killspawner)) {
            level thread kill_spawner_trigger(trig);
        }
        if (isdefined(trig.targetname)) {
            if (isdefined(var_b4443147[trig.targetname])) {
                level thread [[ var_b4443147[trig.targetname] ]](trig);
            }
        }
    }
}

// Namespace trigger
// Params 0, eflags: 0x1 linked
// Checksum 0xd35d35ab, Offset: 0xad0
// Size: 0xce
function function_ad8ffc08() {
    if (isdefined(self.spawnflags) && (isdefined(self.spawnflags) && (isdefined(self.spawnflags) && (isdefined(self.spawnflags) && (isdefined(self.spawnflags) && (self.spawnflags & 1) == 1 || (self.spawnflags & 2) == 2) || (self.spawnflags & 4) == 4) || (self.spawnflags & 8) == 8) || isdefined(self.script_trigger_allplayers) && self.script_trigger_allplayers && (self.spawnflags & 16) == 16)) {
    }
}

// Namespace trigger
// Params 1, eflags: 0x1 linked
// Checksum 0xc5736642, Offset: 0xba8
// Size: 0x130
function trigger_unlock(trigger) {
    noteworthy = "not_set";
    if (isdefined(trigger.script_noteworthy)) {
        noteworthy = trigger.script_noteworthy;
    }
    var_467768ba = getentarray(trigger.target, "targetname");
    trigger thread trigger_unlock_death(trigger.target);
    while (true) {
        array::run_all(var_467768ba, &triggerenable, 0);
        trigger waittill(#"trigger");
        array::run_all(var_467768ba, &triggerenable, 1);
        wait_for_an_unlocked_trigger(var_467768ba, noteworthy);
        array::notify_all(var_467768ba, "relock");
    }
}

// Namespace trigger
// Params 1, eflags: 0x1 linked
// Checksum 0x54bdfe14, Offset: 0xce0
// Size: 0x64
function trigger_unlock_death(target) {
    self waittill(#"death");
    var_467768ba = getentarray(target, "targetname");
    array::run_all(var_467768ba, &triggerenable, 0);
}

// Namespace trigger
// Params 2, eflags: 0x1 linked
// Checksum 0xdd915932, Offset: 0xd50
// Size: 0xb0
function wait_for_an_unlocked_trigger(triggers, noteworthy) {
    level endon("unlocked_trigger_hit" + noteworthy);
    ent = spawnstruct();
    for (i = 0; i < triggers.size; i++) {
        triggers[i] thread report_trigger(ent, noteworthy);
    }
    ent waittill(#"trigger");
    level notify("unlocked_trigger_hit" + noteworthy);
}

// Namespace trigger
// Params 2, eflags: 0x1 linked
// Checksum 0xc11723ab, Offset: 0xe08
// Size: 0x4c
function report_trigger(ent, noteworthy) {
    self endon(#"hash_323a0103");
    level endon("unlocked_trigger_hit" + noteworthy);
    self waittill(#"trigger");
    ent notify(#"trigger");
}

// Namespace trigger
// Params 0, eflags: 0x1 linked
// Checksum 0xad36b5f5, Offset: 0xe60
// Size: 0x200
function get_trigger_look_target() {
    if (isdefined(self.target)) {
        a_potential_targets = getentarray(self.target, "targetname");
        a_targets = [];
        foreach (target in a_potential_targets) {
            if (target.classname === "script_origin") {
                if (!isdefined(a_targets)) {
                    a_targets = [];
                } else if (!isarray(a_targets)) {
                    a_targets = array(a_targets);
                }
                a_targets[a_targets.size] = target;
            }
        }
        a_potential_target_structs = struct::get_array(self.target);
        a_targets = arraycombine(a_targets, a_potential_target_structs, 1, 0);
        if (a_targets.size > 0) {
            /#
                assert(a_targets.size == 1, "trigger_delete_on_touch" + self.origin + "trigger_delete_on_touch");
            #/
            e_target = a_targets[0];
        }
    }
    if (!isdefined(e_target)) {
        e_target = self;
    }
    return e_target;
}

// Namespace trigger
// Params 1, eflags: 0x1 linked
// Checksum 0xee18704e, Offset: 0x1068
// Size: 0x2c0
function trigger_look(trigger) {
    trigger endon(#"death");
    e_target = trigger get_trigger_look_target();
    if (isdefined(trigger.script_flag) && !isdefined(level.flag[trigger.script_flag])) {
        level flag::init(trigger.script_flag, undefined, 1);
    }
    a_parameters = [];
    if (isdefined(trigger.script_parameters)) {
        a_parameters = strtok(trigger.script_parameters, ",; ");
    }
    b_ads_check = isinarray(a_parameters, "check_ads");
    while (true) {
        e_other = trigger waittill(#"trigger");
        if (isplayer(e_other)) {
            while (isdefined(e_other) && e_other istouching(trigger)) {
                if (!b_ads_check || e_other util::is_looking_at(e_target, trigger.script_dot, isdefined(trigger.script_trace) && trigger.script_trace) && !e_other util::is_ads()) {
                    trigger notify(#"trigger_look", e_other);
                    if (isdefined(trigger.script_flag)) {
                        level flag::set(trigger.script_flag);
                    }
                } else if (isdefined(trigger.script_flag)) {
                    level flag::clear(trigger.script_flag);
                }
                wait(0.05);
            }
            if (isdefined(trigger.script_flag)) {
                level flag::clear(trigger.script_flag);
            }
            continue;
        }
        /#
            assertmsg("trigger_delete_on_touch");
        #/
    }
}

// Namespace trigger
// Params 1, eflags: 0x1 linked
// Checksum 0x72c17349, Offset: 0x1330
// Size: 0x12a
function trigger_spawner(trigger) {
    a_spawners = getspawnerarray(trigger.target, "targetname");
    /#
        assert(a_spawners.size > 0, "trigger_delete_on_touch" + trigger.origin + "trigger_delete_on_touch");
    #/
    trigger endon(#"death");
    trigger wait_till();
    foreach (sp in a_spawners) {
        if (isdefined(sp)) {
            sp thread trigger_spawner_spawn();
        }
    }
}

// Namespace trigger
// Params 0, eflags: 0x1 linked
// Checksum 0xb21063d5, Offset: 0x1468
// Size: 0x54
function trigger_spawner_spawn() {
    self endon(#"death");
    self flag::script_flag_wait();
    self util::script_delay();
    self spawner::spawn();
}

// Namespace trigger
// Params 2, eflags: 0x1 linked
// Checksum 0xf2a9d991, Offset: 0x14c8
// Size: 0x114
function trigger_notify(trigger, msg) {
    trigger endon(#"death");
    other = trigger wait_till();
    if (isdefined(trigger.target)) {
        a_target_ents = getentarray(trigger.target, "targetname");
        foreach (notify_ent in a_target_ents) {
            notify_ent notify(msg, other);
        }
    }
    level notify(msg, other);
}

// Namespace trigger
// Params 2, eflags: 0x1 linked
// Checksum 0x7b311f80, Offset: 0x15e8
// Size: 0xf8
function flag_set_trigger(trigger, str_flag) {
    trigger endon(#"death");
    if (!isdefined(str_flag)) {
        str_flag = trigger.script_flag;
    }
    if (!level flag::exists(str_flag)) {
        level flag::init(str_flag, undefined, 1);
    }
    while (true) {
        trigger wait_till();
        if (isdefined(trigger.targetname) && trigger.targetname == "flag_set") {
            trigger util::script_delay();
        }
        level flag::set(str_flag);
    }
}

// Namespace trigger
// Params 2, eflags: 0x1 linked
// Checksum 0x21cbd72b, Offset: 0x16e8
// Size: 0xf8
function flag_clear_trigger(trigger, str_flag) {
    trigger endon(#"death");
    if (!isdefined(str_flag)) {
        str_flag = trigger.script_flag;
    }
    if (!level flag::exists(str_flag)) {
        level flag::init(str_flag, undefined, 1);
    }
    while (true) {
        trigger wait_till();
        if (isdefined(trigger.targetname) && trigger.targetname == "flag_clear") {
            trigger util::script_delay();
        }
        level flag::clear(str_flag);
    }
}

// Namespace trigger
// Params 1, eflags: 0x1 linked
// Checksum 0x4e202bb, Offset: 0x17e8
// Size: 0x92
function add_tokens_to_trigger_flags(tokens) {
    for (i = 0; i < tokens.size; i++) {
        flag = tokens[i];
        if (!isdefined(level.trigger_flags[flag])) {
            level.trigger_flags[flag] = [];
        }
        level.trigger_flags[flag][level.trigger_flags[flag].size] = self;
    }
}

// Namespace trigger
// Params 1, eflags: 0x1 linked
// Checksum 0x8eb2322e, Offset: 0x1888
// Size: 0x6c
function function_83ff7020(trigger) {
    tokens = util::create_flags_and_return_tokens(trigger.script_flag_false);
    trigger add_tokens_to_trigger_flags(tokens);
    trigger update_based_on_flags();
}

// Namespace trigger
// Params 1, eflags: 0x1 linked
// Checksum 0x268a7e3f, Offset: 0x1900
// Size: 0x6c
function function_f1980fe1(trigger) {
    tokens = util::create_flags_and_return_tokens(trigger.script_flag_true);
    trigger add_tokens_to_trigger_flags(tokens);
    trigger update_based_on_flags();
}

// Namespace trigger
// Params 1, eflags: 0x1 linked
// Checksum 0x341eb30f, Offset: 0x1978
// Size: 0x178
function friendly_respawn_trigger(trigger) {
    trigger endon(#"death");
    spawners = getentarray(trigger.target, "targetname");
    /#
        assert(spawners.size == 1, "trigger_delete_on_touch" + trigger.target + "trigger_delete_on_touch");
    #/
    spawner = spawners[0];
    /#
        assert(!isdefined(spawner.script_forcecolor), "trigger_delete_on_touch" + spawner.origin + "trigger_delete_on_touch");
    #/
    spawners = undefined;
    spawner endon(#"death");
    while (true) {
        trigger waittill(#"trigger");
        if (isdefined(trigger.script_forcecolor)) {
            level.respawn_spawners_specific[trigger.script_forcecolor] = spawner;
        } else {
            level.respawn_spawner = spawner;
        }
        level flag::set("respawn_friendlies");
        wait(0.5);
    }
}

// Namespace trigger
// Params 1, eflags: 0x1 linked
// Checksum 0x3f0b2f06, Offset: 0x1af8
// Size: 0x58
function friendly_respawn_clear(trigger) {
    trigger endon(#"death");
    while (true) {
        trigger waittill(#"trigger");
        level flag::clear("respawn_friendlies");
        wait(0.5);
    }
}

// Namespace trigger
// Params 1, eflags: 0x1 linked
// Checksum 0x1182bf94, Offset: 0x1b58
// Size: 0xee
function trigger_turns_off(trigger) {
    trigger wait_till();
    trigger triggerenable(0);
    if (!isdefined(trigger.script_linkto)) {
        return;
    }
    tokens = strtok(trigger.script_linkto, " ");
    for (i = 0; i < tokens.size; i++) {
        array::run_all(getentarray(tokens[i], "script_linkname"), &triggerenable, 0);
    }
}

// Namespace trigger
// Params 1, eflags: 0x1 linked
// Checksum 0xf9f49d54, Offset: 0x1c50
// Size: 0x1d8
function script_flag_set_touching(trigger) {
    trigger endon(#"death");
    if (isdefined(trigger.script_flag_set_on_touching)) {
        level flag::init(trigger.script_flag_set_on_touching, undefined, 1);
    }
    if (isdefined(trigger.var_ef42adb1)) {
        level flag::init(trigger.var_ef42adb1, undefined, 1);
    }
    trigger thread _detect_touched();
    while (true) {
        trigger.script_touched = 0;
        wait(0.05);
        waittillframeend();
        if (!trigger.script_touched) {
            wait(0.05);
            waittillframeend();
        }
        if (trigger.script_touched) {
            if (isdefined(trigger.script_flag_set_on_touching)) {
                level flag::set(trigger.script_flag_set_on_touching);
            }
            if (isdefined(trigger.var_ef42adb1)) {
                level flag::clear(trigger.var_ef42adb1);
            }
            continue;
        }
        if (isdefined(trigger.script_flag_set_on_touching)) {
            level flag::clear(trigger.script_flag_set_on_touching);
        }
        if (isdefined(trigger.var_ef42adb1)) {
            level flag::set(trigger.var_ef42adb1);
        }
    }
}

// Namespace trigger
// Params 0, eflags: 0x1 linked
// Checksum 0x7c5eef1f, Offset: 0x1e30
// Size: 0x34
function _detect_touched() {
    self endon(#"death");
    while (true) {
        self waittill(#"trigger");
        self.script_touched = 1;
    }
}

// Namespace trigger
// Params 1, eflags: 0x1 linked
// Checksum 0x1bd21478, Offset: 0x1e70
// Size: 0x50
function trigger_delete_on_touch(trigger) {
    while (true) {
        other = trigger waittill(#"trigger");
        if (isdefined(other)) {
            other delete();
        }
    }
}

// Namespace trigger
// Params 1, eflags: 0x1 linked
// Checksum 0x5df9bef3, Offset: 0x1ec8
// Size: 0x100
function function_c6742dfe(trigger) {
    str_flag = trigger.script_flag;
    if (!isdefined(level.flag[str_flag])) {
        level flag::init(str_flag, undefined, 1);
    }
    while (true) {
        other = trigger waittill(#"trigger");
        level flag::set(str_flag);
        while (isalive(other) && other istouching(trigger) && isdefined(trigger)) {
            wait(0.25);
        }
        level flag::clear(str_flag);
    }
}

// Namespace trigger
// Params 1, eflags: 0x1 linked
// Checksum 0xd3332659, Offset: 0x1fd0
// Size: 0xf4
function trigger_once(trig) {
    trig endon(#"death");
    if (is_look_trigger(trig)) {
        trig waittill(#"trigger_look");
    } else {
        trig waittill(#"trigger");
    }
    waittillframeend();
    waittillframeend();
    if (isdefined(trig)) {
        /#
            println("trigger_delete_on_touch");
            println("trigger_delete_on_touch" + trig getentitynumber() + "trigger_delete_on_touch" + trig.origin);
            println("trigger_delete_on_touch");
        #/
        trig delete();
    }
}

// Namespace trigger
// Params 1, eflags: 0x1 linked
// Checksum 0xf3289391, Offset: 0x20d0
// Size: 0x174
function trigger_hint(trigger) {
    /#
        assert(isdefined(trigger.script_hint), "trigger_delete_on_touch" + trigger.origin + "trigger_delete_on_touch");
    #/
    trigger endon(#"death");
    if (!isdefined(level.displayed_hints)) {
        level.displayed_hints = [];
    }
    waittillframeend();
    /#
        assert(isdefined(level.trigger_hint_string[trigger.script_hint]), "trigger_delete_on_touch" + trigger.script_hint + "trigger_delete_on_touch");
    #/
    other = trigger waittill(#"trigger");
    /#
        assert(isplayer(other), "trigger_delete_on_touch");
    #/
    if (isdefined(level.displayed_hints[trigger.script_hint])) {
        return;
    }
    level.displayed_hints[trigger.script_hint] = 1;
    display_hint(trigger.script_hint);
}

// Namespace trigger
// Params 1, eflags: 0x1 linked
// Checksum 0xaa1fc07c, Offset: 0x2250
// Size: 0x60
function function_c52b5655(trigger) {
    trigger endon(#"death");
    while (true) {
        trigger waittill(#"trigger");
        if (isdefined(trigger.target)) {
            activateclientradiantexploder(trigger.target);
        }
    }
}

// Namespace trigger
// Params 1, eflags: 0x1 linked
// Checksum 0x8ea8bf47, Offset: 0x22b8
// Size: 0xb4
function display_hint(hint) {
    if (getdvarstring("chaplincheat") == "1") {
        return;
    }
    if (isdefined(level.trigger_hint_func[hint])) {
        if ([[ level.trigger_hint_func[hint] ]]()) {
            return;
        }
        function_bd4fb8ef(level.trigger_hint_string[hint], level.trigger_hint_func[hint]);
        return;
    }
    function_bd4fb8ef(level.trigger_hint_string[hint]);
}

// Namespace trigger
// Params 2, eflags: 0x1 linked
// Checksum 0x7022df29, Offset: 0x2378
// Size: 0x394
function function_bd4fb8ef(string, var_6647cf0c) {
    level flag::wait_till_clear("global_hint_in_use");
    level flag::set("global_hint_in_use");
    hint = hud::createfontstring("objective", 2);
    hint.alpha = 0.9;
    hint.x = 0;
    hint.y = -68;
    hint.alignx = "center";
    hint.aligny = "middle";
    hint.horzalign = "center";
    hint.vertalign = "middle";
    hint.foreground = 0;
    hint.hidewhendead = 1;
    hint settext(string);
    hint.alpha = 0;
    hint fadeovertime(1);
    hint.alpha = 0.95;
    function_5f1a1049(1);
    if (isdefined(var_6647cf0c)) {
        for (;;) {
            hint fadeovertime(0.75);
            hint.alpha = 0.4;
            function_5f1a1049(0.75, var_6647cf0c);
            if ([[ var_6647cf0c ]]()) {
                break;
            }
            hint fadeovertime(0.75);
            hint.alpha = 0.95;
            function_5f1a1049(0.75);
            if ([[ var_6647cf0c ]]()) {
                break;
            }
        }
    } else {
        for (i = 0; i < 5; i++) {
            hint fadeovertime(0.75);
            hint.alpha = 0.4;
            function_5f1a1049(0.75);
            hint fadeovertime(0.75);
            hint.alpha = 0.95;
            function_5f1a1049(0.75);
        }
    }
    hint destroy();
    level flag::clear("global_hint_in_use");
}

// Namespace trigger
// Params 2, eflags: 0x1 linked
// Checksum 0x8a4ef5c5, Offset: 0x2718
// Size: 0x82
function function_5f1a1049(length, var_6647cf0c) {
    if (!isdefined(var_6647cf0c)) {
        wait(length);
        return;
    }
    timer = length * 20;
    for (i = 0; i < timer; i++) {
        if ([[ var_6647cf0c ]]()) {
            break;
        }
        wait(0.05);
    }
}

// Namespace trigger
// Params 9, eflags: 0x1 linked
// Checksum 0xc998fa6d, Offset: 0x27a8
// Size: 0x524
function get_all(type1, var_70753f2d, var_4a72c4c4, var_24704a5b, var_fe6dcff2, var_d86b5589, var_b268db20, var_ec8e0747, var_c68b8cde) {
    if (!isdefined(type1)) {
        type1 = "trigger_damage";
        var_70753f2d = "trigger_hurt";
        var_4a72c4c4 = "trigger_lookat";
        var_24704a5b = "trigger_once";
        var_fe6dcff2 = "trigger_radius";
        var_d86b5589 = "trigger_use";
        var_b268db20 = "trigger_use_touch";
        var_ec8e0747 = "trigger_box";
        var_c68b8cde = "trigger_multiple";
        var_d4a0cdb2 = "trigger_out_of_bounds";
    }
    /#
        assert(function_73e50955(type1));
    #/
    trigs = getentarray(type1, "classname");
    if (isdefined(var_70753f2d)) {
        /#
            assert(function_73e50955(var_70753f2d));
        #/
        trigs = arraycombine(trigs, getentarray(var_70753f2d, "classname"), 1, 0);
    }
    if (isdefined(var_4a72c4c4)) {
        /#
            assert(function_73e50955(var_4a72c4c4));
        #/
        trigs = arraycombine(trigs, getentarray(var_4a72c4c4, "classname"), 1, 0);
    }
    if (isdefined(var_24704a5b)) {
        /#
            assert(function_73e50955(var_24704a5b));
        #/
        trigs = arraycombine(trigs, getentarray(var_24704a5b, "classname"), 1, 0);
    }
    if (isdefined(var_fe6dcff2)) {
        /#
            assert(function_73e50955(var_fe6dcff2));
        #/
        trigs = arraycombine(trigs, getentarray(var_fe6dcff2, "classname"), 1, 0);
    }
    if (isdefined(var_d86b5589)) {
        /#
            assert(function_73e50955(var_d86b5589));
        #/
        trigs = arraycombine(trigs, getentarray(var_d86b5589, "classname"), 1, 0);
    }
    if (isdefined(var_b268db20)) {
        /#
            assert(function_73e50955(var_b268db20));
        #/
        trigs = arraycombine(trigs, getentarray(var_b268db20, "classname"), 1, 0);
    }
    if (isdefined(var_ec8e0747)) {
        /#
            assert(function_73e50955(var_ec8e0747));
        #/
        trigs = arraycombine(trigs, getentarray(var_ec8e0747, "classname"), 1, 0);
    }
    if (isdefined(var_c68b8cde)) {
        /#
            assert(function_73e50955(var_c68b8cde));
        #/
        trigs = arraycombine(trigs, getentarray(var_c68b8cde, "classname"), 1, 0);
    }
    if (isdefined(var_d4a0cdb2)) {
        /#
            assert(function_73e50955(var_c68b8cde));
        #/
        trigs = arraycombine(trigs, getentarray(var_d4a0cdb2, "classname"), 1, 0);
    }
    return trigs;
}

// Namespace trigger
// Params 1, eflags: 0x1 linked
// Checksum 0x96a071c8, Offset: 0x2cd8
// Size: 0x82
function function_73e50955(type) {
    switch (type) {
    case 17:
    case 21:
    case 22:
    case 39:
    case 19:
    case 18:
    case 42:
    case 20:
    case 40:
    case 41:
        return 1;
    default:
        return 0;
    }
}

// Namespace trigger
// Params 4, eflags: 0x1 linked
// Checksum 0x851ab05d, Offset: 0x2d68
// Size: 0x1fc
function wait_till(str_name, str_key, e_entity, b_assert) {
    if (!isdefined(str_key)) {
        str_key = "targetname";
    }
    if (!isdefined(b_assert)) {
        b_assert = 1;
    }
    if (isdefined(str_name)) {
        triggers = getentarray(str_name, str_key);
        if (sessionmodeiscampaignzombiesgame()) {
            if (triggers.size <= 0) {
                return;
            }
        } else {
            /#
                assert(!b_assert || triggers.size > 0, "trigger_delete_on_touch" + str_name + "trigger_delete_on_touch" + str_key);
            #/
        }
        if (triggers.size > 0) {
            if (triggers.size == 1) {
                trigger_hit = triggers[0];
                trigger_hit _trigger_wait(e_entity);
            } else {
                s_tracker = spawnstruct();
                array::thread_all(triggers, &_trigger_wait_think, s_tracker, e_entity);
                e_other, trigger_hit = s_tracker waittill(#"trigger");
                trigger_hit.who = e_other;
            }
            return trigger_hit;
        }
        return;
    }
    if (sessionmodeiscampaignzombiesgame()) {
        if (!isdefined(self)) {
            return;
        }
    }
    return _trigger_wait(e_entity);
}

// Namespace trigger
// Params 1, eflags: 0x1 linked
// Checksum 0xcf084cc5, Offset: 0x2f70
// Size: 0x202
function _trigger_wait(e_entity) {
    self endon(#"death");
    if (isdefined(e_entity)) {
        e_entity endon(#"death");
    }
    /#
        if (is_look_trigger(self)) {
            /#
                assert(!isarray(e_entity), "trigger_delete_on_touch");
            #/
        } else if (self.classname === "trigger_delete_on_touch") {
            /#
                assert(!isarray(e_entity), "trigger_delete_on_touch");
            #/
        }
    #/
    while (true) {
        if (is_look_trigger(self)) {
            e_other = self waittill(#"trigger_look");
            if (isdefined(e_entity)) {
                if (e_other !== e_entity) {
                    continue;
                }
            }
        } else if (self.classname === "trigger_damage") {
            e_other = self waittill(#"trigger");
            if (isdefined(e_entity)) {
                if (e_other !== e_entity) {
                    continue;
                }
            }
        } else {
            e_other = self waittill(#"trigger");
            if (isdefined(e_entity)) {
                if (isarray(e_entity)) {
                    if (!array::is_touching(e_entity, self)) {
                        continue;
                    }
                } else if (!e_entity istouching(self) && e_entity !== e_other) {
                    continue;
                }
            }
        }
        break;
    }
    self.who = e_other;
    return self;
}

// Namespace trigger
// Params 2, eflags: 0x1 linked
// Checksum 0xd47961f6, Offset: 0x3180
// Size: 0x64
function _trigger_wait_think(s_tracker, e_entity) {
    self endon(#"death");
    s_tracker endon(#"trigger");
    e_other = _trigger_wait(e_entity);
    s_tracker notify(#"trigger", e_other, self);
}

// Namespace trigger
// Params 4, eflags: 0x1 linked
// Checksum 0xe767be6f, Offset: 0x31f0
// Size: 0x184
function use(str_name, str_key, ent, b_assert) {
    if (!isdefined(str_key)) {
        str_key = "targetname";
    }
    if (!isdefined(b_assert)) {
        b_assert = 1;
    }
    if (!isdefined(ent)) {
        ent = getplayers()[0];
    }
    if (isdefined(str_name)) {
        e_trig = getent(str_name, str_key);
        if (!isdefined(e_trig)) {
            if (b_assert) {
                /#
                    assertmsg("trigger_delete_on_touch" + str_name + "trigger_delete_on_touch" + str_key);
                #/
            }
            return;
        }
    } else {
        e_trig = self;
        str_name = self.targetname;
    }
    if (isdefined(ent)) {
        e_trig useby(ent);
    } else {
        e_trig useby(e_trig);
    }
    level notify(str_name, ent);
    if (is_look_trigger(e_trig)) {
        e_trig notify(#"trigger_look", ent);
    }
    return e_trig;
}

// Namespace trigger
// Params 1, eflags: 0x1 linked
// Checksum 0x661e9565, Offset: 0x3380
// Size: 0x94
function set_flag_permissions(msg) {
    if (!isdefined(level.trigger_flags) || !isdefined(level.trigger_flags[msg])) {
        return;
    }
    level.trigger_flags[msg] = array::remove_undefined(level.trigger_flags[msg]);
    array::thread_all(level.trigger_flags[msg], &update_based_on_flags);
}

// Namespace trigger
// Params 0, eflags: 0x1 linked
// Checksum 0x27fd0f50, Offset: 0x3420
// Size: 0x15c
function update_based_on_flags() {
    true_on = 1;
    if (isdefined(self.script_flag_true)) {
        true_on = 0;
        tokens = util::create_flags_and_return_tokens(self.script_flag_true);
        for (i = 0; i < tokens.size; i++) {
            if (level flag::get(tokens[i])) {
                true_on = 1;
                break;
            }
        }
    }
    false_on = 1;
    if (isdefined(self.script_flag_false)) {
        tokens = util::create_flags_and_return_tokens(self.script_flag_false);
        for (i = 0; i < tokens.size; i++) {
            if (level flag::get(tokens[i])) {
                false_on = 0;
                break;
            }
        }
    }
    b_enable = true_on && false_on;
    self triggerenable(b_enable);
}

// Namespace trigger
// Params 0, eflags: 0x1 linked
// Checksum 0x4925b55f, Offset: 0x3588
// Size: 0x10
function init_flags() {
    level.trigger_flags = [];
}

// Namespace trigger
// Params 1, eflags: 0x1 linked
// Checksum 0xb8e393b9, Offset: 0x35a0
// Size: 0x64
function is_look_trigger(trig) {
    return isdefined(trig) ? isdefined(trig.spawnflags) && (trig.spawnflags & 256) == 256 && !(trig.classname === "trigger_damage") : 0;
}

// Namespace trigger
// Params 1, eflags: 0x1 linked
// Checksum 0x294be86e, Offset: 0x3610
// Size: 0x5e
function is_trigger_once(trig) {
    return isdefined(trig) ? isdefined(trig.spawnflags) && (trig.spawnflags & 1024) == 1024 || self.classname === "trigger_once" : 0;
}

// Namespace trigger
// Params 2, eflags: 0x1 linked
// Checksum 0xbcee7960, Offset: 0x3678
// Size: 0x11e
function wait_for_either(str_targetname1, str_targetname2) {
    ent = spawnstruct();
    array = [];
    array = arraycombine(array, getentarray(str_targetname1, "targetname"), 1, 0);
    array = arraycombine(array, getentarray(str_targetname2, "targetname"), 1, 0);
    for (i = 0; i < array.size; i++) {
        ent thread _ent_waits_for_trigger(array[i]);
    }
    var_2df9fcc1 = ent waittill(#"done");
    return var_2df9fcc1;
}

// Namespace trigger
// Params 1, eflags: 0x1 linked
// Checksum 0x4d82ad59, Offset: 0x37a0
// Size: 0x36
function _ent_waits_for_trigger(trigger) {
    trigger wait_till();
    self notify(#"done", trigger);
}

// Namespace trigger
// Params 3, eflags: 0x1 linked
// Checksum 0xacbe479e, Offset: 0x37e0
// Size: 0x8c
function wait_or_timeout(n_time, str_name, str_key) {
    if (isdefined(n_time)) {
        __s = spawnstruct();
        __s endon(#"timeout");
        __s util::delay_notify(n_time, "timeout");
    }
    wait_till(str_name, str_key);
}

// Namespace trigger
// Params 4, eflags: 0x0
// Checksum 0x78b1e59f, Offset: 0x3878
// Size: 0xec
function trigger_on_timeout(n_time, b_cancel_on_triggered, str_name, str_key) {
    if (!isdefined(b_cancel_on_triggered)) {
        b_cancel_on_triggered = 1;
    }
    if (!isdefined(str_key)) {
        str_key = "targetname";
    }
    trig = self;
    if (isdefined(str_name)) {
        trig = getent(str_name, str_key);
    }
    if (b_cancel_on_triggered) {
        if (is_look_trigger(trig)) {
            trig endon(#"trigger_look");
        } else {
            trig endon(#"trigger");
        }
    }
    trig endon(#"death");
    wait(n_time);
    trig use();
}

// Namespace trigger
// Params 2, eflags: 0x0
// Checksum 0x9513016f, Offset: 0x3970
// Size: 0xba
function multiple_waits(str_trigger_name, str_trigger_notify) {
    foreach (trigger in getentarray(str_trigger_name, "targetname")) {
        trigger thread multiple_wait(str_trigger_notify);
    }
}

// Namespace trigger
// Params 1, eflags: 0x1 linked
// Checksum 0xd8309a95, Offset: 0x3a38
// Size: 0x2a
function multiple_wait(str_trigger_notify) {
    level endon(str_trigger_notify);
    self waittill(#"trigger");
    level notify(str_trigger_notify);
}

// Namespace trigger
// Params 9, eflags: 0x1 linked
// Checksum 0x1f41c007, Offset: 0x3a70
// Size: 0x84
function add_function(trigger, str_remove_on, func, param_1, param_2, param_3, param_4, param_5, param_6) {
    self thread _do_trigger_function(trigger, str_remove_on, func, param_1, param_2, param_3, param_4, param_5, param_6);
}

// Namespace trigger
// Params 9, eflags: 0x1 linked
// Checksum 0x541f3141, Offset: 0x3b00
// Size: 0xf8
function _do_trigger_function(trigger, str_remove_on, func, param_1, param_2, param_3, param_4, param_5, param_6) {
    self endon(#"death");
    trigger endon(#"death");
    if (isdefined(str_remove_on)) {
        trigger endon(str_remove_on);
    }
    while (true) {
        if (isstring(trigger)) {
            wait_till(trigger);
        } else {
            trigger wait_till();
        }
        util::single_thread(self, func, param_1, param_2, param_3, param_4, param_5, param_6);
    }
}

// Namespace trigger
// Params 1, eflags: 0x1 linked
// Checksum 0xed3a87ab, Offset: 0x3c00
// Size: 0x1ba
function kill_spawner_trigger(trigger) {
    trigger wait_till();
    a_spawners = getspawnerarray(trigger.script_killspawner, "script_killspawner");
    foreach (sp in a_spawners) {
        sp delete();
    }
    a_ents = getentarray(trigger.script_killspawner, "script_killspawner");
    foreach (ent in a_ents) {
        if (ent.classname === "spawn_manager" && ent != trigger) {
            ent delete();
        }
    }
}

// Namespace trigger
// Params 0, eflags: 0x1 linked
// Checksum 0x738183e4, Offset: 0x3dc8
// Size: 0xda
function get_script_linkto_targets() {
    targets = [];
    if (!isdefined(self.script_linkto)) {
        return targets;
    }
    tokens = strtok(self.script_linkto, " ");
    for (i = 0; i < tokens.size; i++) {
        token = tokens[i];
        target = getent(token, "script_linkname");
        if (isdefined(target)) {
            targets[targets.size] = target;
        }
    }
    return targets;
}

// Namespace trigger
// Params 1, eflags: 0x1 linked
// Checksum 0x670ce103, Offset: 0x3eb0
// Size: 0x64
function function_62964ea9(trigger) {
    trigger waittill(#"trigger");
    targets = trigger get_script_linkto_targets();
    array::thread_all(targets, &delete_links_then_self);
}

// Namespace trigger
// Params 0, eflags: 0x1 linked
// Checksum 0x4084765, Offset: 0x3f20
// Size: 0x5c
function delete_links_then_self() {
    targets = get_script_linkto_targets();
    array::thread_all(targets, &delete_links_then_self);
    self delete();
}

// Namespace trigger
// Params 1, eflags: 0x1 linked
// Checksum 0x24cf126d, Offset: 0x3f88
// Size: 0xd8
function function_5c8525c5(trigger) {
    while (true) {
        other = trigger waittill(#"trigger");
        if (!isplayer(other)) {
            continue;
        }
        while (other istouching(trigger)) {
            other allowprone(0);
            other allowcrouch(0);
            wait(0.05);
        }
        other allowprone(1);
        other allowcrouch(1);
    }
}

// Namespace trigger
// Params 1, eflags: 0x1 linked
// Checksum 0x2d266001, Offset: 0x4068
// Size: 0xa8
function function_555e49a2(trigger) {
    while (true) {
        other = trigger waittill(#"trigger");
        if (!isplayer(other)) {
            continue;
        }
        while (other istouching(trigger)) {
            other allowprone(0);
            wait(0.05);
        }
        other allowprone(1);
    }
}

// Namespace trigger
// Params 0, eflags: 0x1 linked
// Checksum 0x543f1e8d, Offset: 0x4118
// Size: 0x54
function trigger_group() {
    self thread trigger_group_remove();
    level endon("trigger_group_" + self.script_trigger_group);
    self waittill(#"trigger");
    level notify("trigger_group_" + self.script_trigger_group, self);
}

// Namespace trigger
// Params 0, eflags: 0x1 linked
// Checksum 0xb072aa90, Offset: 0x4178
// Size: 0x44
function trigger_group_remove() {
    trigger = level waittill("trigger_group_" + self.script_trigger_group);
    if (self != trigger) {
        self delete();
    }
}

// Namespace trigger
// Params 3, eflags: 0x0
// Checksum 0xd35fe7b1, Offset: 0x41c8
// Size: 0xfc
function function_thread(ent, on_enter_payload, on_exit_payload) {
    ent endon(#"entityshutdown");
    if (ent ent_already_in(self)) {
        return;
    }
    add_to_ent(ent, self);
    if (isdefined(on_enter_payload)) {
        [[ on_enter_payload ]](ent);
    }
    while (isdefined(ent) && ent istouching(self)) {
        wait(0.01);
    }
    if (isdefined(ent) && isdefined(on_exit_payload)) {
        [[ on_exit_payload ]](ent);
    }
    if (isdefined(ent)) {
        remove_from_ent(ent, self);
    }
}

// Namespace trigger
// Params 1, eflags: 0x1 linked
// Checksum 0x81a3626a, Offset: 0x42d0
// Size: 0x70
function ent_already_in(trig) {
    if (!isdefined(self._triggers)) {
        return false;
    }
    if (!isdefined(self._triggers[trig getentitynumber()])) {
        return false;
    }
    if (!self._triggers[trig getentitynumber()]) {
        return false;
    }
    return true;
}

// Namespace trigger
// Params 2, eflags: 0x1 linked
// Checksum 0x69912a81, Offset: 0x4348
// Size: 0x62
function add_to_ent(ent, trig) {
    if (!isdefined(ent._triggers)) {
        ent._triggers = [];
    }
    ent._triggers[trig getentitynumber()] = 1;
}

// Namespace trigger
// Params 2, eflags: 0x1 linked
// Checksum 0x2ab5f476, Offset: 0x43b8
// Size: 0x82
function remove_from_ent(ent, trig) {
    if (!isdefined(ent._triggers)) {
        return;
    }
    if (!isdefined(ent._triggers[trig getentitynumber()])) {
        return;
    }
    ent._triggers[trig getentitynumber()] = 0;
}

