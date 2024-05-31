#using scripts/zm/zm_genesis_minor_ee;
#using scripts/zm/zm_genesis_apothican;
#using scripts/zm/_zm_weap_octobomb;
#using scripts/zm/_zm_weap_ball;
#using scripts/zm/_zm_weapons;
#using scripts/zm/_zm_zonemgr;
#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_unitrigger;
#using scripts/zm/_zm_score;
#using scripts/zm/_zm_laststand;
#using scripts/zm/_zm_power;
#using scripts/zm/_zm_elemental_zombies;
#using scripts/zm/_zm_devgui;
#using scripts/zm/_zm_audio;
#using scripts/shared/ai/zombie_utility;
#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/animation_shared;
#using scripts/shared/array_shared;
#using scripts/codescripts/struct;

#namespace namespace_cb655c88;

// Namespace namespace_cb655c88
// Params 0, eflags: 0x2
// Checksum 0x80a1a79, Offset: 0xb68
// Size: 0x3c
function autoexec function_2dc19561() {
    system::register("zm_genesis_util", &__init__, &__main__, undefined);
}

// Namespace namespace_cb655c88
// Params 0, eflags: 0x1 linked
// Checksum 0xfae56691, Offset: 0xbb0
// Size: 0x32c
function __init__() {
    n_bits = getminbitcountfornum(8);
    clientfield::register("toplayer", "player_rumble_and_shake", 15000, n_bits, "int");
    n_bits = getminbitcountfornum(4);
    clientfield::register("scriptmover", "emit_smoke", 15000, n_bits, "int");
    n_bits = getminbitcountfornum(4);
    clientfield::register("scriptmover", "fire_trap", 15000, n_bits, "int");
    clientfield::register("actor", "fire_trap_ignite_enemy", 15000, 1, "int");
    clientfield::register("scriptmover", "rq_gateworm_magic", 15000, 1, "int");
    clientfield::register("scriptmover", "rq_gateworm_dissolve_finish", 15000, 1, "int");
    clientfield::register("scriptmover", "rq_rune_glow", 15000, 1, "int");
    registerclientfield("world", "gen_rune_electricity", 15000, 1, "int");
    registerclientfield("world", "gen_rune_fire", 15000, 1, "int");
    registerclientfield("world", "gen_rune_light", 15000, 1, "int");
    registerclientfield("world", "gen_rune_shadow", 15000, 1, "int");
    clientfield::register("clientuimodel", "zmInventory.widget_rune_parts", 15000, 1, "int");
    clientfield::register("clientuimodel", "zmInventory.player_rune_quest", 15000, 1, "int");
    level.custom_spawner_entry["crawl"] = &function_48cfc7df;
    level.var_3ce1c79c = &function_555e8704;
    level thread function_828240c9();
}

// Namespace namespace_cb655c88
// Params 0, eflags: 0x1 linked
// Checksum 0x98bcf796, Offset: 0xee8
// Size: 0x6c
function __main__() {
    function_b6faf5c0();
    function_8fb96327();
    /#
        level thread function_30672281();
    #/
    /#
        level thread function_e7e606b6();
    #/
    level thread function_5bad746b();
}

// Namespace namespace_cb655c88
// Params 0, eflags: 0x1 linked
// Checksum 0x82bd762e, Offset: 0xf60
// Size: 0xc6
function function_1bd652e9() {
    a_ai_zombies = getaiteamarray("axis");
    n_alive = 0;
    foreach (ai_zombie in a_ai_zombies) {
        if (isalive(ai_zombie)) {
            n_alive++;
        }
    }
    return n_alive;
}

// Namespace namespace_cb655c88
// Params 1, eflags: 0x0
// Checksum 0xd9293a49, Offset: 0x1030
// Size: 0x4c
function function_f7f2ffed(v) {
    return "<" + v[0] + ", " + v[1] + ", " + v[2] + ">";
}

// Namespace namespace_cb655c88
// Params 0, eflags: 0x1 linked
// Checksum 0x300c7828, Offset: 0x1088
// Size: 0x4c
function function_828240c9() {
    level waittill(#"start_zombie_round_logic");
    if (isdefined(level._custom_powerups["shield_charge"])) {
        arrayremoveindex(level._custom_powerups, "shield_charge", 1);
    }
}

// Namespace namespace_cb655c88
// Params 1, eflags: 0x1 linked
// Checksum 0x97b6c6de, Offset: 0x10e0
// Size: 0x180
function function_5ea427bf(player) {
    b_visible = 1;
    if (isdefined(player.beastmode) && player.beastmode && !(isdefined(self.var_8842df9d) && self.var_8842df9d)) {
        b_visible = 0;
    } else if (isdefined(self.stub.var_98775f3)) {
        b_visible = self [[ self.stub.var_98775f3 ]](player);
    }
    str_msg = %;
    param1 = undefined;
    if (b_visible) {
        if (isdefined(self.stub.var_af0b9c6c)) {
            str_msg = self [[ self.stub.var_af0b9c6c ]](player);
        } else {
            str_msg = self.stub.hint_string;
            param1 = self.stub.hint_parm1;
        }
    }
    if (isdefined(str_msg)) {
        if (isdefined(param1)) {
            self sethintstring(str_msg, param1);
        } else {
            self sethintstring(str_msg);
        }
    }
    return b_visible;
}

// Namespace namespace_cb655c88
// Params 0, eflags: 0x1 linked
// Checksum 0x26e65965, Offset: 0x1268
// Size: 0x1c
function function_c1947ff7() {
    self zm_unitrigger::run_visibility_function_for_all_triggers();
}

// Namespace namespace_cb655c88
// Params 0, eflags: 0x0
// Checksum 0xeb5e91d5, Offset: 0x1290
// Size: 0x10
function function_4973348c() {
    self.var_8842df9d = 1;
}

// Namespace namespace_cb655c88
// Params 0, eflags: 0x5 linked
// Checksum 0x85f437a3, Offset: 0x12a8
// Size: 0x9c
function private function_c54cd556() {
    self endon(#"kill_trigger");
    self.stub thread function_c1947ff7();
    while (true) {
        player = self waittill(#"trigger");
        if (isdefined(self.var_8842df9d) && self.var_8842df9d || !(isdefined(player.beastmode) && player.beastmode)) {
            self.stub notify(#"trigger", player);
        }
    }
}

// Namespace namespace_cb655c88
// Params 2, eflags: 0x0
// Checksum 0x530c1173, Offset: 0x1350
// Size: 0x64
function function_d73e42e0(str_message, param1) {
    self.hint_string = str_message;
    self.hint_parm1 = param1;
    zm_unitrigger::unregister_unitrigger(self);
    zm_unitrigger::register_unitrigger(self, &function_c54cd556);
}

// Namespace namespace_cb655c88
// Params 5, eflags: 0x5 linked
// Checksum 0xf93d87c8, Offset: 0x13c0
// Size: 0x1f8
function private function_a40fee2f(origin, angles, var_3b9cee11, use_trigger, var_cd7edcab) {
    if (!isdefined(use_trigger)) {
        use_trigger = 0;
    }
    trigger_stub = spawnstruct();
    trigger_stub.origin = origin;
    str_type = "unitrigger_radius";
    if (isvec(var_3b9cee11)) {
        trigger_stub.script_length = var_3b9cee11[0];
        trigger_stub.script_width = var_3b9cee11[1];
        trigger_stub.script_height = var_3b9cee11[2];
        str_type = "unitrigger_box";
        if (!isdefined(angles)) {
            angles = (0, 0, 0);
        }
        trigger_stub.angles = angles;
    } else {
        trigger_stub.radius = var_3b9cee11;
    }
    if (use_trigger) {
        trigger_stub.cursor_hint = "HINT_NOICON";
        trigger_stub.script_unitrigger_type = str_type + "_use";
    } else {
        trigger_stub.script_unitrigger_type = str_type;
    }
    if (isdefined(var_cd7edcab)) {
        trigger_stub.var_af0b9c6c = var_cd7edcab;
        zm_unitrigger::unitrigger_force_per_player_triggers(trigger_stub, 1);
    }
    trigger_stub.prompt_and_visibility_func = &function_5ea427bf;
    zm_unitrigger::register_unitrigger(trigger_stub, &function_c54cd556);
    return trigger_stub;
}

// Namespace namespace_cb655c88
// Params 4, eflags: 0x1 linked
// Checksum 0xc5beb279, Offset: 0x15c0
// Size: 0x5a
function function_d095318(origin, radius, use_trigger, var_cd7edcab) {
    if (!isdefined(use_trigger)) {
        use_trigger = 0;
    }
    return function_a40fee2f(origin, undefined, radius, use_trigger, var_cd7edcab);
}

// Namespace namespace_cb655c88
// Params 5, eflags: 0x0
// Checksum 0xff6c91c4, Offset: 0x1628
// Size: 0x62
function function_c17c0335(origin, angles, var_f726970c, use_trigger, var_cd7edcab) {
    if (!isdefined(use_trigger)) {
        use_trigger = 0;
    }
    return function_a40fee2f(origin, angles, var_f726970c, use_trigger, var_cd7edcab);
}

// Namespace namespace_cb655c88
// Params 0, eflags: 0x1 linked
// Checksum 0xffad8a24, Offset: 0x1698
// Size: 0x3c
function function_b6faf5c0() {
    level.var_e17963aa = [];
    level.var_7c6cbc08 = struct::get_array("smoke_emitter", "script_noteworthy");
}

// Namespace namespace_cb655c88
// Params 3, eflags: 0x1 linked
// Checksum 0x4577ed4, Offset: 0x16e0
// Size: 0x30a
function function_c3266652(str_targetname, n_duration, n_offset) {
    var_bd7e807d = array::filter(level.var_7c6cbc08, 0, &function_f889e065, str_targetname);
    assert(isdefined(var_bd7e807d), "actor" + str_targetname + "actor");
    if (!isdefined(level.var_e17963aa[str_targetname])) {
        foreach (var_dddfc725 in var_bd7e807d) {
            var_a535abab = util::spawn_model("tag_origin", var_dddfc725.origin, var_dddfc725.angles);
            var_a535abab.script_int = var_dddfc725.script_int;
            if (!isdefined(level.var_e17963aa[str_targetname])) {
                level.var_e17963aa[str_targetname] = array(var_a535abab);
                continue;
            }
            if (!isdefined(level.var_e17963aa[str_targetname])) {
                level.var_e17963aa[str_targetname] = [];
            } else if (!isarray(level.var_e17963aa[str_targetname])) {
                level.var_e17963aa[str_targetname] = array(level.var_e17963aa[str_targetname]);
            }
            level.var_e17963aa[str_targetname][level.var_e17963aa[str_targetname].size] = var_a535abab;
        }
    }
    assert(isdefined(level.var_e17963aa[str_targetname]), "actor" + str_targetname + "actor");
    foreach (var_a535abab in level.var_e17963aa[str_targetname]) {
        var_a535abab thread function_92fbd45f(n_duration);
        if (isdefined(n_offset)) {
            wait(n_offset);
        }
    }
}

// Namespace namespace_cb655c88
// Params 1, eflags: 0x1 linked
// Checksum 0x471f67fd, Offset: 0x19f8
// Size: 0xd8
function function_7c229e48(str_targetname) {
    if (isdefined(level.var_e17963aa[str_targetname])) {
        foreach (var_a535abab in level.var_e17963aa[str_targetname]) {
            var_a535abab thread function_d8dd128a();
        }
        level.var_e17963aa = array::remove_index(level.var_e17963aa, str_targetname, 1);
    }
}

// Namespace namespace_cb655c88
// Params 0, eflags: 0x1 linked
// Checksum 0xa5b76b83, Offset: 0x1ad8
// Size: 0x3c
function function_d8dd128a() {
    self clientfield::set("emit_smoke", 0);
    wait(1);
    self delete();
}

// Namespace namespace_cb655c88
// Params 1, eflags: 0x1 linked
// Checksum 0x278a8ce5, Offset: 0x1b20
// Size: 0x94
function function_92fbd45f(n_duration) {
    level endon(#"hash_306a8062");
    var_34e5a242 = self.script_int;
    if (!isdefined(var_34e5a242)) {
        var_34e5a242 = 1;
    }
    self clientfield::set("emit_smoke", var_34e5a242);
    if (isdefined(n_duration)) {
        wait(n_duration);
        self clientfield::set("emit_smoke", 0);
    }
}

// Namespace namespace_cb655c88
// Params 2, eflags: 0x1 linked
// Checksum 0xe7b995d3, Offset: 0x1bc0
// Size: 0x28
function function_f889e065(var_dddfc725, str_targetname) {
    return var_dddfc725.targetname === str_targetname;
}

// Namespace namespace_cb655c88
// Params 4, eflags: 0x0
// Checksum 0xf146eabd, Offset: 0x1bf0
// Size: 0x70
function function_70f7f8aa(v_pos, v_angles, var_216e90fd, var_8a2d164) {
    var_2804cb89 = util::spawn_model("tag_origin", v_pos, v_angles);
    var_2804cb89 thread function_721925b6(var_216e90fd, var_8a2d164);
    return var_2804cb89;
}

// Namespace namespace_cb655c88
// Params 2, eflags: 0x1 linked
// Checksum 0x40ecf264, Offset: 0x1c68
// Size: 0x144
function function_721925b6(var_216e90fd, var_8a2d164) {
    self endon(#"death");
    switch (var_216e90fd) {
    case 0:
    case 2:
        self clientfield::set("fire_trap", 1);
        self.var_bbfa873e = 1;
        break;
    case 1:
    case 3:
        self clientfield::set("fire_trap", 3);
        self.var_bbfa873e = 2;
        break;
    }
    self flag::init("deactivate_fire_trap");
    self thread function_1f629fb(var_216e90fd);
    self function_9354534f(var_216e90fd, var_8a2d164);
    self clientfield::set("fire_trap", 0);
    self notify(#"hash_c1f4c598");
    self delete();
}

// Namespace namespace_cb655c88
// Params 2, eflags: 0x1 linked
// Checksum 0xcf931e7e, Offset: 0x1db8
// Size: 0xd4
function function_9354534f(var_216e90fd, var_8a2d164) {
    if (!self flag::get("deactivate_fire_trap")) {
        if (var_8a2d164 > 1) {
            self thread function_5d940bdb(var_216e90fd, var_8a2d164);
            if (isdefined(var_8a2d164)) {
                __s = spawnstruct();
                __s endon(#"timeout");
                __s util::delay_notify(var_8a2d164, "timeout");
            }
        }
        self waittill(#"hash_c1f4c598");
        return;
    }
    wait(0.1);
}

// Namespace namespace_cb655c88
// Params 2, eflags: 0x1 linked
// Checksum 0xcfda497d, Offset: 0x1e98
// Size: 0xc2
function function_5d940bdb(var_216e90fd, var_8a2d164) {
    self endon(#"death");
    self endon(#"hash_c1f4c598");
    var_16039327 = var_8a2d164 - 2;
    if (var_16039327 < 1) {
        var_16039327 = var_8a2d164 * 0.5;
    }
    wait(var_16039327);
    switch (var_216e90fd) {
    case 0:
    case 2:
        self clientfield::set("fire_trap", 2);
        break;
    case 1:
    case 3:
        break;
    }
}

// Namespace namespace_cb655c88
// Params 1, eflags: 0x1 linked
// Checksum 0xc93c5191, Offset: 0x1f68
// Size: 0x320
function function_1f629fb(var_216e90fd) {
    self endon(#"hash_c1f4c598");
    while (true) {
        a_ai_enemies = getaiteamarray(level.zombie_team);
        var_f7c98a7 = arraysortclosest(a_ai_enemies, self.origin, a_ai_enemies.size, 0, 96);
        var_f7c98a7 = array::filter(var_f7c98a7, 0, &function_2179430a);
        var_f7c98a7 = array::filter(var_f7c98a7, 0, &function_bb218fa3, self, 2304);
        if (var_f7c98a7.size) {
            foreach (var_7cb53454 in var_f7c98a7) {
                b_result = var_7cb53454 function_c8040935(var_216e90fd);
                if (isdefined(b_result) && b_result) {
                    self notify(#"hash_b2a721cd");
                    self.var_bbfa873e--;
                    if (self.var_bbfa873e <= 0) {
                        self flag::set("deactivate_fire_trap");
                    }
                }
            }
        }
        a_e_players = arraysortclosest(level.activeplayers, self.origin, level.activeplayers.size, 0, 64);
        a_e_players = array::filter(a_e_players, 0, &function_bb218fa3, self, 1024);
        a_e_players = array::filter(a_e_players, 0, &function_6f7936c1);
        if (a_e_players.size) {
            foreach (e_player in a_e_players) {
                if (zm_utility::is_player_valid(e_player)) {
                    e_player thread function_28297a11();
                }
            }
        }
        wait(0.1);
    }
}

// Namespace namespace_cb655c88
// Params 1, eflags: 0x1 linked
// Checksum 0xc4fb1753, Offset: 0x2290
// Size: 0x1ac
function function_c8040935(var_216e90fd) {
    ai_zombie = self;
    var_1ca69a28 = namespace_57695b4d::function_4aeed0a5("napalm");
    if (!isdefined(level.var_bd64e31e) || var_1ca69a28 < level.var_bd64e31e) {
        if (!(isdefined(ai_zombie.var_6c653628) && ai_zombie.var_6c653628)) {
            ai_zombie.var_6c653628 = 1;
            ai_zombie.var_9a02a614 = "napalm";
            ai_zombie clientfield::set("fire_trap_ignite_enemy", 1);
            ai_zombie clientfield::set("arch_actor_fire_fx", 1);
            ai_zombie thread namespace_57695b4d::function_e94aef80();
            ai_zombie thread namespace_57695b4d::function_d070bfba();
            if (var_216e90fd == 2 || var_216e90fd == 3) {
                ai_zombie.var_6d2a9142 = 1;
            } else {
                ai_zombie.health = int(ai_zombie.health * 0.75);
                ai_zombie zombie_utility::set_zombie_run_cycle("sprint");
            }
            return true;
        }
    }
    return false;
}

// Namespace namespace_cb655c88
// Params 0, eflags: 0x1 linked
// Checksum 0x20d52cb8, Offset: 0x2448
// Size: 0x4c
function function_28297a11() {
    self endon(#"death");
    self.var_c0ad0afe = 1;
    self dodamage(20, self.origin);
    wait(2);
    self.var_c0ad0afe = 0;
}

// Namespace namespace_cb655c88
// Params 3, eflags: 0x1 linked
// Checksum 0x60a8d580, Offset: 0x24a0
// Size: 0x48
function function_bb218fa3(var_7cb53454, var_2804cb89, n_dist_2d_sq) {
    return distance2dsquared(var_7cb53454.origin, var_2804cb89.origin) < n_dist_2d_sq;
}

// Namespace namespace_cb655c88
// Params 1, eflags: 0x1 linked
// Checksum 0xd62efe62, Offset: 0x24f0
// Size: 0x4c
function function_2179430a(var_7cb53454) {
    return !(isdefined(var_7cb53454.var_6c653628) && var_7cb53454.var_6c653628) && var_7cb53454.classname != "script_vehicle";
}

// Namespace namespace_cb655c88
// Params 1, eflags: 0x1 linked
// Checksum 0x4a1508b6, Offset: 0x2548
// Size: 0x30
function function_6f7936c1(var_7cb53454) {
    return !(isdefined(var_7cb53454.var_c0ad0afe) && var_7cb53454.var_c0ad0afe);
}

// Namespace namespace_cb655c88
// Params 2, eflags: 0x1 linked
// Checksum 0x9ba03673, Offset: 0x2580
// Size: 0x84
function function_6edf48d5(var_5017cd53, var_d00db512) {
    self notify(#"hash_6edf48d5");
    self endon(#"disconnect");
    self endon(#"hash_6edf48d5");
    self thread clientfield::set_to_player("player_rumble_and_shake", var_5017cd53);
    if (isdefined(var_d00db512)) {
        wait(var_d00db512);
        self thread function_6edf48d5(0);
    }
}

// Namespace namespace_cb655c88
// Params 4, eflags: 0x0
// Checksum 0x4e59f8b9, Offset: 0x2610
// Size: 0x102
function function_3a7a7013(var_5017cd53, n_radius, v_origin, var_d00db512) {
    var_699d80d5 = n_radius * n_radius;
    foreach (player in level.activeplayers) {
        if (isdefined(player) && distance2dsquared(player.origin, v_origin) <= var_699d80d5) {
            player thread function_6edf48d5(var_5017cd53, var_d00db512);
        }
    }
}

// Namespace namespace_cb655c88
// Params 5, eflags: 0x1 linked
// Checksum 0x8b3f3b68, Offset: 0x2720
// Size: 0x120
function function_72260d3a(var_2fa24527, str_dvar, n_value, func, var_f0ee45c9) {
    if (!isdefined(var_f0ee45c9)) {
        var_f0ee45c9 = -1;
    }
    setdvar(str_dvar, var_f0ee45c9);
    adddebugcommand("devgui_cmd \"" + var_2fa24527 + "\" \"" + str_dvar + " " + n_value + "\"\n");
    while (true) {
        var_608d58e3 = getdvarint(str_dvar);
        if (var_608d58e3 > var_f0ee45c9) {
            [[ func ]](var_608d58e3);
            setdvar(str_dvar, var_f0ee45c9);
        }
        util::wait_network_frame();
    }
}

// Namespace namespace_cb655c88
// Params 1, eflags: 0x0
// Checksum 0x6e9eb754, Offset: 0x2848
// Size: 0x2e4
function function_61b96f56(player) {
    var_cfd1da70 = self.zone_name;
    player_zone = player.zone_name;
    if (var_cfd1da70 === player_zone) {
        return 1;
    }
    if (!isdefined(var_cfd1da70) || !isdefined(player_zone)) {
        return 0;
    }
    var_9165799c = level.zones[self.zone_name].district;
    var_e8c4df7b = level.zones[player.zone_name].district;
    var_bb534481 = level.zones[self.zone_name].area;
    var_147beb1e = level.zones[player.zone_name].area;
    if (var_bb534481 == 0 && var_147beb1e == 0) {
        return 1;
    }
    if (var_9165799c === var_e8c4df7b && var_bb534481 === var_147beb1e) {
        return 1;
    }
    if (var_9165799c === var_e8c4df7b) {
        if (var_bb534481 > var_147beb1e) {
            temp = var_bb534481;
            var_bb534481 = var_147beb1e;
            var_147beb1e = temp;
        }
        var_54f2276d = function_17c00a4f(var_9165799c, var_bb534481, var_e8c4df7b, var_147beb1e);
        return var_54f2276d;
    }
    if (var_bb534481 == 0 && var_147beb1e != 0) {
        var_54f2276d = function_17c00a4f("junction", 0, var_e8c4df7b, var_147beb1e);
        return var_54f2276d;
    }
    if (var_147beb1e == 0 && var_bb534481 != 0) {
        var_54f2276d = function_17c00a4f("junction", 0, var_9165799c, var_bb534481);
        return var_54f2276d;
    }
    var_92280803 = 1;
    var_58b7daa8 = 1;
    var_92280803 = function_17c00a4f("junction", 0, var_9165799c, var_bb534481);
    var_58b7daa8 = function_17c00a4f("junction", 0, var_e8c4df7b, var_147beb1e);
    return var_58b7daa8 && var_92280803;
}

// Namespace namespace_cb655c88
// Params 0, eflags: 0x1 linked
// Checksum 0x99b4baf8, Offset: 0x2b38
// Size: 0x134
function function_555e8704() {
    if (!isdefined(self.unitrigger_stub.in_zone)) {
        /#
            iprintlnbold("actor");
        #/
        return;
    }
    switch (self.unitrigger_stub.in_zone) {
    case 52:
        str_exploder = "fxexp_261";
        break;
    case 51:
        str_exploder = "fxexp_262";
        break;
    case 49:
        str_exploder = "fxexp_263";
        break;
    case 50:
        str_exploder = " fxexp_264";
        break;
    }
    if (!isdefined(str_exploder)) {
        /#
            iprintlnbold("actor");
        #/
        return;
    }
    exploder::exploder(str_exploder);
    while (self.state == "idle") {
        wait(0.05);
    }
    exploder::exploder_stop(str_exploder);
}

// Namespace namespace_cb655c88
// Params 4, eflags: 0x1 linked
// Checksum 0x9c3b2f99, Offset: 0x2c78
// Size: 0x28
function function_17c00a4f(var_9165799c, var_25cf04a1, var_e8c4df7b, var_202b5b6a) {
    return true;
}

// Namespace namespace_cb655c88
// Params 1, eflags: 0x1 linked
// Checksum 0x80c9e93, Offset: 0x2ca8
// Size: 0x21e
function function_48cfc7df(s_spot) {
    self endon(#"death");
    self.var_2be9fa75 = 1;
    self ghost();
    var_37b7ca78 = "cin_zm_dlc1_zombie_undercroft_spawn_" + randomintrange(1, 3);
    if (!isdefined(s_spot.angles)) {
        s_spot.angles = (0, 0, 0);
    }
    mdl_anchor = util::spawn_model("tag_origin", self.origin, self.angles);
    self linkto(mdl_anchor);
    self thread anchor_delete_watcher(mdl_anchor);
    mdl_anchor endon(#"death");
    mdl_anchor.origin = s_spot.origin;
    mdl_anchor.angles = s_spot.angles;
    util::wait_network_frame();
    if (!isdefined(self) || !isalive(self)) {
        return;
    }
    self.create_eyes = 1;
    self show();
    if (isalive(self) && self.health > 0) {
        mdl_anchor scene::play(var_37b7ca78, self);
    }
    self.var_2be9fa75 = 0;
    self unlink();
    self notify(#"risen", s_spot.script_string);
}

// Namespace namespace_cb655c88
// Params 1, eflags: 0x1 linked
// Checksum 0x5de97d0e, Offset: 0x2ed0
// Size: 0x64
function anchor_delete_watcher(mdl_anchor) {
    self util::waittill_any("death", "risen");
    util::wait_network_frame();
    if (isdefined(mdl_anchor)) {
        mdl_anchor delete();
    }
}

// Namespace namespace_cb655c88
// Params 2, eflags: 0x1 linked
// Checksum 0xcb5afc38, Offset: 0x2f40
// Size: 0x94
function function_42108922(str_zone, str_flag) {
    assert(isdefined(level.zones[str_zone]), "actor" + str_zone + "actor");
    level flag::wait_till(str_flag);
    if (zm_zonemgr::zone_is_enabled(str_zone)) {
        return;
    }
    zm_zonemgr::enable_zone(str_zone);
}

// Namespace namespace_cb655c88
// Params 2, eflags: 0x1 linked
// Checksum 0x290cb1b9, Offset: 0x2fe0
// Size: 0xc0
function function_342295d8(str_zone, b_enable) {
    if (!isdefined(b_enable)) {
        b_enable = 1;
    }
    assert(isdefined(level.zones[str_zone]), "actor" + str_zone + "actor");
    if (b_enable && zm_zonemgr::zone_is_enabled(str_zone)) {
        return;
    }
    level.zones[str_zone].is_enabled = b_enable;
    level.zones[str_zone].is_spawning_allowed = b_enable;
}

// Namespace namespace_cb655c88
// Params 0, eflags: 0x1 linked
// Checksum 0xfcc1360, Offset: 0x30a8
// Size: 0x1d8
function function_37a5b776() {
    var_a8951c29 = [];
    var_9e84b959 = array("start_island", "apothicon_island", "temple_island", "prototype_island", "asylum_island", "prison_island", "arena_island");
    for (i = 0; i < var_9e84b959.size; i++) {
        var_94e9acae = getent(var_9e84b959[i], "targetname");
        for (j = 0; j < level.activeplayers.size; j++) {
            if (isdefined(level.activeplayers[j].is_flung) && level.activeplayers[j].is_flung) {
                return true;
            }
            if (level.activeplayers[j] istouching(var_94e9acae)) {
                array::add(var_a8951c29, var_94e9acae, 0);
            }
        }
    }
    if (!var_a8951c29.size) {
        return true;
    } else {
        for (k = 0; k < var_a8951c29.size; k++) {
            if (self istouching(var_a8951c29[k])) {
                return true;
            }
        }
    }
    return false;
}

// Namespace namespace_cb655c88
// Params 2, eflags: 0x1 linked
// Checksum 0x6bed65ed, Offset: 0x3288
// Size: 0xe0
function function_748dfcde(str_trigger, str_flag) {
    t_trigger = getent(str_trigger, "targetname");
    level flag::init(str_flag);
    while (true) {
        e_triggerer = t_trigger waittill(#"trigger");
        if (!(isdefined(e_triggerer.var_54343c90) && e_triggerer.var_54343c90) && level flag::get(str_flag)) {
            e_triggerer thread function_bf457d6e(t_trigger, str_flag);
        }
    }
}

// Namespace namespace_cb655c88
// Params 2, eflags: 0x1 linked
// Checksum 0x3d5a6905, Offset: 0x3370
// Size: 0x110
function function_88777efd(str_trigger, str_flag) {
    t_trigger = getent(str_trigger, "targetname");
    level flag::init(str_flag);
    while (true) {
        e_triggerer = t_trigger waittill(#"trigger");
        if (!isplayer(e_triggerer)) {
            wait(0.1);
            continue;
        }
        if (!(isdefined(e_triggerer.var_7dd18a0) && e_triggerer.var_7dd18a0) && level flag::get(str_flag)) {
            e_triggerer thread function_36bd06cd(t_trigger, str_flag);
        }
        wait(0.1);
    }
}

// Namespace namespace_cb655c88
// Params 2, eflags: 0x1 linked
// Checksum 0x8b8692b2, Offset: 0x3488
// Size: 0xa4
function function_bf457d6e(t_trigger, str_flag) {
    self endon(#"death");
    self.var_54343c90 = 1;
    self allowwallrun(1);
    while (self istouching(t_trigger) && level flag::get(str_flag)) {
        wait(0.05);
    }
    self.var_54343c90 = 0;
    self allowwallrun(0);
}

// Namespace namespace_cb655c88
// Params 2, eflags: 0x1 linked
// Checksum 0x7fcd784e, Offset: 0x3538
// Size: 0xe8
function function_36bd06cd(t_trigger, str_flag) {
    self endon(#"death");
    self allowdoublejump(1);
    self setperk("specialty_lowgravity");
    self.var_7dd18a0 = 1;
    while (self istouching(t_trigger) && level flag::get(str_flag)) {
        wait(0.05);
    }
    self allowdoublejump(0);
    self unsetperk("specialty_lowgravity");
    self.var_7dd18a0 = 0;
}

// Namespace namespace_cb655c88
// Params 4, eflags: 0x1 linked
// Checksum 0x85ccabf2, Offset: 0x3628
// Size: 0x168
function function_89067abe(e_player, str_text, xpos, ypos) {
    hudelem = newclienthudelem(e_player);
    if (isdefined(xpos)) {
        hudelem.alignx = "left";
        hudelem.x = xpos;
    } else {
        hudelem.alignx = "center";
        hudelem.horzalign = "center";
        hudelem.aligny = "middle";
        hudelem.vertalign = "middle";
    }
    hudelem.y = ypos;
    hudelem.foreground = 1;
    hudelem.font = "default";
    hudelem.fontscale = 1.2;
    hudelem.alpha = 1;
    hudelem.color = (1, 1, 1);
    hudelem settext(str_text);
    return hudelem;
}

// Namespace namespace_cb655c88
// Params 4, eflags: 0x1 linked
// Checksum 0x76b08c3d, Offset: 0x3798
// Size: 0x160
function function_a1bfa962(e_player, str_text, xpos, ypos) {
    hudelem = newhudelem();
    if (isdefined(xpos)) {
        hudelem.alignx = "left";
        hudelem.x = xpos;
    } else {
        hudelem.alignx = "center";
        hudelem.horzalign = "center";
        hudelem.aligny = "middle";
        hudelem.vertalign = "middle";
    }
    hudelem.y = ypos;
    hudelem.foreground = 1;
    hudelem.font = "default";
    hudelem.fontscale = 1.2;
    hudelem.alpha = 1;
    hudelem.color = (1, 1, 1);
    hudelem settext(str_text);
    return hudelem;
}

// Namespace namespace_cb655c88
// Params 2, eflags: 0x1 linked
// Checksum 0xfe298400, Offset: 0x3900
// Size: 0x11c
function array_remove(array, object) {
    if (!isdefined(array) && !isdefined(object)) {
        return;
    }
    new_array = [];
    foreach (item in array) {
        if (item != object) {
            if (!isdefined(new_array)) {
                new_array = [];
            } else if (!isarray(new_array)) {
                new_array = array(new_array);
            }
            new_array[new_array.size] = item;
        }
    }
    return new_array;
}

// Namespace namespace_cb655c88
// Params 0, eflags: 0x1 linked
// Checksum 0xe0c7ea04, Offset: 0x3a28
// Size: 0x9a
function function_adcc0e33() {
    var_91bcd8f1 = 0;
    a_zombies = getaiteamarray("axis");
    for (i = 0; i < a_zombies.size; i++) {
        if (isdefined(a_zombies[i].var_8a1ad3bb) && a_zombies[i].var_8a1ad3bb) {
            var_91bcd8f1++;
        }
    }
    return var_91bcd8f1;
}

// Namespace namespace_cb655c88
// Params 0, eflags: 0x0
// Checksum 0x164147de, Offset: 0x3ad0
// Size: 0x9a
function function_c6462c91() {
    var_2a3db9af = 0;
    a_zombies = getaiteamarray("axis");
    for (i = 0; i < a_zombies.size; i++) {
        if (isdefined(a_zombies[i].var_3940f450) && a_zombies[i].var_3940f450) {
            var_2a3db9af++;
        }
    }
    return var_2a3db9af;
}

// Namespace namespace_cb655c88
// Params 0, eflags: 0x1 linked
// Checksum 0xcde33470, Offset: 0x3b78
// Size: 0x9a
function function_e3e6bdba() {
    var_9911df60 = 0;
    a_zombies = getaiteamarray("axis");
    for (i = 0; i < a_zombies.size; i++) {
        if (isdefined(a_zombies[i].var_b8385ee5) && a_zombies[i].var_b8385ee5) {
            var_9911df60++;
        }
    }
    return var_9911df60;
}

// Namespace namespace_cb655c88
// Params 0, eflags: 0x0
// Checksum 0x5947020f, Offset: 0x3c20
// Size: 0x9a
function function_23ee29c0() {
    var_87f7eede = 0;
    a_zombies = getaiteamarray("axis");
    for (i = 0; i < a_zombies.size; i++) {
        if (isdefined(a_zombies[i].var_1cba9ac3) && a_zombies[i].var_1cba9ac3) {
            var_87f7eede++;
        }
    }
    return var_87f7eede;
}

// Namespace namespace_cb655c88
// Params 7, eflags: 0x1 linked
// Checksum 0x5b1b8336, Offset: 0x3cc8
// Size: 0x152
function function_2a0bc326(v_pos, var_48f82942, var_51fbdea, var_644bf6a7, var_8f4ca4be, var_11fed455, var_183c13ad) {
    if (!isdefined(var_11fed455)) {
        var_11fed455 = "damage_heavy";
    }
    if (var_48f82942) {
        earthquake(var_48f82942, var_51fbdea, v_pos, var_644bf6a7);
    }
    var_5ca58060 = var_644bf6a7 * var_644bf6a7;
    foreach (player in level.activeplayers) {
        if (isdefined(var_183c13ad)) {
            player shellshock(var_183c13ad, var_51fbdea);
        }
        player thread function_e42cebb6(v_pos, var_5ca58060, var_8f4ca4be, var_11fed455);
    }
}

// Namespace namespace_cb655c88
// Params 4, eflags: 0x1 linked
// Checksum 0x3b0f978, Offset: 0x3e28
// Size: 0x9e
function function_e42cebb6(v_pos, var_5ca58060, var_8f4ca4be, var_11fed455) {
    self endon(#"death");
    for (i = 0; i < var_8f4ca4be; i++) {
        if (distancesquared(v_pos, self.origin) <= var_5ca58060) {
            self playrumbleonentity(var_11fed455);
        }
        wait(0.1);
    }
}

// Namespace namespace_cb655c88
// Params 0, eflags: 0x1 linked
// Checksum 0x7cfa3fee, Offset: 0x3ed0
// Size: 0x184
function function_8fb96327() {
    level.var_d2484e02 = [];
    level.var_94994361 = [];
    level.var_3787c9a = [];
    level flag::init("electricity_rq_started");
    level flag::init("fire_rq_started");
    level flag::init("light_rq_started");
    level flag::init("shadow_rq_started");
    level flag::init("electricity_rq_done");
    level flag::init("fire_rq_done");
    level flag::init("light_rq_done");
    level flag::init("shadow_rq_done");
    level thread function_dc1220f5();
    level thread function_fc87564e();
    level thread function_e973877c();
    level thread function_283b6d72();
}

// Namespace namespace_cb655c88
// Params 0, eflags: 0x1 linked
// Checksum 0x7ec66c92, Offset: 0x4060
// Size: 0x8c
function function_dc1220f5() {
    a_s_start_pos = struct::get_array("electricity_rune_quest_start", "targetname");
    var_2b8f773a = array::random(a_s_start_pos);
    var_2b8f773a thread function_15e7a0c8("electricity_rq_started", &function_2f157912, &function_e889d17c);
}

// Namespace namespace_cb655c88
// Params 1, eflags: 0x1 linked
// Checksum 0x892ff661, Offset: 0x40f8
// Size: 0x22
function function_2f157912(e_who) {
    return function_af60288e(e_who, 0);
}

// Namespace namespace_cb655c88
// Params 1, eflags: 0x1 linked
// Checksum 0xd751073d, Offset: 0x4128
// Size: 0x24
function function_e889d17c(e_who) {
    self function_87cb72e4(e_who, 0);
}

// Namespace namespace_cb655c88
// Params 0, eflags: 0x1 linked
// Checksum 0x64d47aa1, Offset: 0x4158
// Size: 0x8c
function function_fc87564e() {
    a_s_start_pos = struct::get_array("fire_rune_quest_start", "targetname");
    var_2b8f773a = array::random(a_s_start_pos);
    var_2b8f773a thread function_15e7a0c8("fire_rq_started", &function_8164c629, &function_9b7022b5);
}

// Namespace namespace_cb655c88
// Params 1, eflags: 0x1 linked
// Checksum 0x1462dcf0, Offset: 0x41f0
// Size: 0x22
function function_8164c629(e_who) {
    return function_af60288e(e_who, 1);
}

// Namespace namespace_cb655c88
// Params 1, eflags: 0x1 linked
// Checksum 0xb73884db, Offset: 0x4220
// Size: 0x2c
function function_9b7022b5(e_who) {
    self function_87cb72e4(e_who, 1);
}

// Namespace namespace_cb655c88
// Params 0, eflags: 0x1 linked
// Checksum 0x45879c8e, Offset: 0x4258
// Size: 0x8c
function function_e973877c() {
    a_s_start_pos = struct::get_array("light_rune_quest_start", "targetname");
    var_2b8f773a = array::random(a_s_start_pos);
    var_2b8f773a thread function_15e7a0c8("light_rq_started", &function_45c80653, &function_aef2e0a3);
}

// Namespace namespace_cb655c88
// Params 1, eflags: 0x1 linked
// Checksum 0xc1babaa3, Offset: 0x42f0
// Size: 0x22
function function_45c80653(e_who) {
    return function_af60288e(e_who, 2);
}

// Namespace namespace_cb655c88
// Params 1, eflags: 0x1 linked
// Checksum 0x11627370, Offset: 0x4320
// Size: 0x2c
function function_aef2e0a3(e_who) {
    self function_87cb72e4(e_who, 2);
}

// Namespace namespace_cb655c88
// Params 0, eflags: 0x1 linked
// Checksum 0xef708087, Offset: 0x4358
// Size: 0x8c
function function_283b6d72() {
    a_s_start_pos = struct::get_array("shadow_rune_quest_start", "targetname");
    var_2b8f773a = array::random(a_s_start_pos);
    var_2b8f773a thread function_15e7a0c8("shadow_rq_started", &function_9944ee4d, &function_6d12ad69);
}

// Namespace namespace_cb655c88
// Params 1, eflags: 0x1 linked
// Checksum 0x1f6bd998, Offset: 0x43f0
// Size: 0x22
function function_9944ee4d(e_who) {
    return function_af60288e(e_who, 3);
}

// Namespace namespace_cb655c88
// Params 1, eflags: 0x1 linked
// Checksum 0xadd6d0be, Offset: 0x4420
// Size: 0x2c
function function_6d12ad69(e_who) {
    self function_87cb72e4(e_who, 3);
}

// Namespace namespace_cb655c88
// Params 2, eflags: 0x1 linked
// Checksum 0x68bc12f4, Offset: 0x4458
// Size: 0x3c
function function_87cb72e4(e_who, var_e4342d5d) {
    level.var_94994361[var_e4342d5d] = e_who;
    function_f3a1c8c5(var_e4342d5d, self);
}

// Namespace namespace_cb655c88
// Params 2, eflags: 0x1 linked
// Checksum 0xf2db0318, Offset: 0x44a0
// Size: 0x8e
function function_af60288e(e_who, var_e4342d5d) {
    if (zm_utility::is_player_valid(e_who) && !isdefined(level.var_94994361[var_e4342d5d]) && !array::contains(level.var_94994361, e_who) && e_who flag::get("holding_gateworm")) {
        return true;
    }
    return false;
}

// Namespace namespace_cb655c88
// Params 0, eflags: 0x1 linked
// Checksum 0x13c98f20, Offset: 0x4538
// Size: 0x4c
function function_5bad746b() {
    level flag::wait_till("connect_start_to_left");
    level thread scene::play("debris_sheffield_prison", "targetname");
}

// Namespace namespace_cb655c88
// Params 3, eflags: 0x1 linked
// Checksum 0x416c9981, Offset: 0x4590
// Size: 0x204
function function_15e7a0c8(var_7b429b7d, var_6908e64b, var_4162ae69) {
    if (!level flag::exists(var_7b429b7d)) {
        level flag::init(var_7b429b7d);
    }
    v_pos = self.origin;
    v_angles = self.angles;
    level thread function_83fe94ad(v_pos, var_7b429b7d);
    s_unitrigger_stub = function_d095318(v_pos, 72, 1, &function_e0596480);
    while (!level flag::get(var_7b429b7d)) {
        e_who = s_unitrigger_stub waittill(#"trigger");
        var_a97dcbff = e_who flag::get("holding_gateworm");
        if (isdefined(var_6908e64b)) {
            var_a97dcbff = [[ var_6908e64b ]](e_who);
        }
        if (var_a97dcbff) {
            level flag::set(var_7b429b7d);
            e_who notify(#"hash_82746d33");
            zm_unitrigger::unregister_unitrigger(s_unitrigger_stub);
            if (e_who flag::get("holding_gateworm")) {
                e_who namespace_a9c2433b::function_4aa2c78f();
            }
            e_who function_442d17f2(v_pos, v_angles);
            if (isdefined(var_4162ae69)) {
                self [[ var_4162ae69 ]](e_who);
            }
        }
    }
}

// Namespace namespace_cb655c88
// Params 1, eflags: 0x1 linked
// Checksum 0xec88a992, Offset: 0x47a0
// Size: 0x12
function function_e0596480(e_who) {
    return %;
}

// Namespace namespace_cb655c88
// Params 2, eflags: 0x1 linked
// Checksum 0xe4f9d7ee, Offset: 0x47c0
// Size: 0x218
function function_83fe94ad(v_start_pos, var_7b429b7d) {
    while (!level flag::get(var_7b429b7d)) {
        var_c1dd1728 = array::get_all_closest(v_start_pos, level.activeplayers, undefined, level.activeplayers.size, 384);
        foreach (var_268f35e1 in var_c1dd1728) {
            if (zm_utility::is_player_valid(var_268f35e1)) {
                if (!isdefined(var_268f35e1.var_46c533bd)) {
                    var_268f35e1.var_46c533bd = [];
                }
                if (var_268f35e1 function_ba3dff48(var_7b429b7d)) {
                    if (!isdefined(var_268f35e1.var_46c533bd)) {
                        var_268f35e1.var_46c533bd = [];
                    } else if (!isarray(var_268f35e1.var_46c533bd)) {
                        var_268f35e1.var_46c533bd = array(var_268f35e1.var_46c533bd);
                    }
                    var_268f35e1.var_46c533bd[var_268f35e1.var_46c533bd.size] = var_7b429b7d;
                    var_268f35e1 thread function_e495c2b6(var_7b429b7d);
                    var_268f35e1 thread function_ae4d938c(v_start_pos, 384, 72, "gateworm_used");
                }
            }
        }
        wait(0.2);
    }
}

// Namespace namespace_cb655c88
// Params 1, eflags: 0x1 linked
// Checksum 0xb7ace5bf, Offset: 0x49e0
// Size: 0x58
function function_ba3dff48(var_7b429b7d) {
    if (self flag::get("holding_gateworm") && !array::contains(self.var_46c533bd, var_7b429b7d)) {
        return true;
    }
    return false;
}

// Namespace namespace_cb655c88
// Params 1, eflags: 0x1 linked
// Checksum 0x20272390, Offset: 0x4a40
// Size: 0x54
function function_e495c2b6(var_7b429b7d) {
    self endon(#"disconnect");
    self function_d3845622(var_7b429b7d);
    self.var_46c533bd = array::exclude(self.var_46c533bd, var_7b429b7d);
}

// Namespace namespace_cb655c88
// Params 1, eflags: 0x1 linked
// Checksum 0xa9f97ade, Offset: 0x4aa0
// Size: 0x34
function function_d3845622(var_7b429b7d) {
    level endon(var_7b429b7d);
    self flag::wait_till_clear("holding_gateworm");
}

// Namespace namespace_cb655c88
// Params 2, eflags: 0x1 linked
// Checksum 0xed98cb32, Offset: 0x4ae0
// Size: 0x21c
function function_442d17f2(v_start_pos, v_angles) {
    v_spawn_pos = self geteye() + anglestoforward(self getplayerangles()) * 64;
    var_7add4736 = util::spawn_model("tag_origin", v_spawn_pos, v_angles);
    var_5ff9a2f5 = util::spawn_model("p7_zm_dlc4_gateworm", v_spawn_pos, v_angles);
    var_5ff9a2f5 linkto(var_7add4736);
    var_5ff9a2f5 thread scene::play("zm_dlc4_gateworm_idle_basin", var_5ff9a2f5);
    self thread util::delete_on_death(var_7add4736);
    self thread util::delete_on_death(var_5ff9a2f5);
    var_5ff9a2f5 thread function_9646de9a();
    v_ground_pos = bullettrace(v_start_pos, v_start_pos + (0, 0, -100000), 0, var_5ff9a2f5)["position"];
    var_7add4736 moveto(v_ground_pos, 4);
    var_7add4736 playsound("zmb_main_searchparty_worm_appear");
    var_7add4736 playloopsound("zmb_main_omelettes_worm_lp", 1);
    var_7add4736 waittill(#"movedone");
    var_5ff9a2f5 thread function_364b1972(var_7add4736);
}

// Namespace namespace_cb655c88
// Params 0, eflags: 0x1 linked
// Checksum 0x9a8d3182, Offset: 0x4d08
// Size: 0xac
function function_9646de9a() {
    self clientfield::set("rq_gateworm_magic", 1);
    wait(2);
    self playsound("zmb_main_searchparty_worm_disapparate");
    self stoploopsound(3);
    self setmodel("p7_zm_dlc4_gateworm_dissolve");
    self clientfield::set("rq_gateworm_dissolve_finish", 1);
    wait(2);
}

// Namespace namespace_cb655c88
// Params 1, eflags: 0x1 linked
// Checksum 0x42e0ff12, Offset: 0x4dc0
// Size: 0x7c
function function_364b1972(var_7add4736) {
    self ghost();
    wait(0.8);
    self clientfield::set("rq_gateworm_magic", 0);
    self delete();
    var_7add4736 delete();
}

// Namespace namespace_cb655c88
// Params 2, eflags: 0x1 linked
// Checksum 0x9d3bdc00, Offset: 0x4e48
// Size: 0x398
function function_f3a1c8c5(var_e4342d5d, s_pos) {
    switch (var_e4342d5d) {
    case 0:
        var_25b51f6b = "p7_fxanim_zm_gen_rune_discovery_electricity_mod";
        var_b96024 = "p7_fxanim_zm_gen_rune_discovery_electricity_bundle";
        break;
    case 1:
        var_25b51f6b = "p7_fxanim_zm_gen_rune_discovery_fire_mod";
        var_b96024 = "p7_fxanim_zm_gen_rune_discovery_fire_bundle";
        break;
    case 2:
        var_25b51f6b = "p7_fxanim_zm_gen_rune_discovery_light_mod";
        var_b96024 = "p7_fxanim_zm_gen_rune_discovery_light_bundle";
        break;
    case 3:
        var_25b51f6b = "p7_fxanim_zm_gen_rune_discovery_shadow_mod";
        var_b96024 = "p7_fxanim_zm_gen_rune_discovery_shadow_bundle";
        break;
    }
    level.var_7bddd74e[var_e4342d5d] = util::spawn_model(var_25b51f6b, s_pos.origin, s_pos.angles - (0, 90, 0));
    var_7b98b639 = level.var_7bddd74e[var_e4342d5d];
    var_7b98b639 thread scene::play(var_b96024, var_7b98b639);
    var_7b98b639 clientfield::set("rq_rune_glow", 1);
    v_pos = bullettrace(self.origin, self.origin + (0, 0, -100000), 0, s_pos)["position"];
    v_pos += (0, 0, 32);
    s_unitrigger_stub = function_d095318(v_pos, -128, 1);
    s_unitrigger_stub.var_e4342d5d = var_e4342d5d;
    s_unitrigger_stub.hint_string = "";
    if (distancesquared(var_7b98b639.origin, v_pos) > 102400) {
        var_7b98b639.origin = v_pos;
    }
    if (distancesquared(var_7b98b639.origin, v_pos) > 102400) {
        var_7b98b639.origin = v_pos;
    }
    while (true) {
        e_who = s_unitrigger_stub waittill(#"trigger");
        if (e_who == level.var_94994361[var_e4342d5d] || zm_utility::is_player_valid(e_who) && !isdefined(level.var_94994361[var_e4342d5d])) {
            zm_unitrigger::unregister_unitrigger(s_unitrigger_stub);
            var_7b98b639 delete();
            e_who playsound("zmb_main_searchparty_rune_pickup");
            e_who function_bb26d959(var_e4342d5d);
            if (isdefined(self)) {
                self notify(#"hash_22e3a570");
            }
            return;
        }
    }
}

// Namespace namespace_cb655c88
// Params 1, eflags: 0x1 linked
// Checksum 0x3df88ebd, Offset: 0x51e8
// Size: 0x254
function function_bb26d959(var_e4342d5d) {
    level.var_94994361[var_e4342d5d] = undefined;
    level.var_3787c9a[var_e4342d5d] = undefined;
    switch (var_e4342d5d) {
    case 0:
        level flag::set("electricity_rq_done");
        str_text = "ELECTRICITY RUNE";
        str_tag_name = "electricity";
        n_x_pos = 10;
        n_y_pos = -56;
        break;
    case 1:
        level flag::set("fire_rq_done");
        str_text = "FIRE RUNE";
        str_tag_name = "fire";
        n_x_pos = 10;
        n_y_pos = -36;
        break;
    case 2:
        level flag::set("light_rq_done");
        str_text = "LIGHT RUNE";
        str_tag_name = "light";
        n_x_pos = 10;
        n_y_pos = -16;
        break;
    case 3:
        level flag::set("shadow_rq_done");
        str_text = "SHADOW RUNE";
        str_tag_name = "shadow";
        n_x_pos = 10;
        n_y_pos = 260;
        break;
    }
    if (!isdefined(level.var_b1b99f8d)) {
        level.var_b1b99f8d = [];
    } else if (!isarray(level.var_b1b99f8d)) {
        level.var_b1b99f8d = array(level.var_b1b99f8d);
    }
    level.var_b1b99f8d[level.var_b1b99f8d.size] = var_e4342d5d;
    function_1e620a08(str_tag_name);
    self thread function_e7fa3600(var_e4342d5d);
}

// Namespace namespace_cb655c88
// Params 1, eflags: 0x1 linked
// Checksum 0x8366c829, Offset: 0x5448
// Size: 0x94
function function_1e620a08(str_tag_name) {
    var_c0132a00 = getent("rift_entrance_rune_portal", "targetname");
    var_c0132a00 hidepart("tag_" + str_tag_name + "_off");
    var_c0132a00 showpart("tag_" + str_tag_name + "_on");
}

// Namespace namespace_cb655c88
// Params 1, eflags: 0x1 linked
// Checksum 0x2500a41e, Offset: 0x54e8
// Size: 0x14a
function function_e7fa3600(var_e4342d5d) {
    switch (var_e4342d5d) {
    case 0:
        str_text = "gen_rune_electricity";
        break;
    case 1:
        str_text = "gen_rune_fire";
        break;
    case 2:
        str_text = "gen_rune_light";
        break;
    case 3:
        str_text = "gen_rune_shadow";
        break;
    }
    level clientfield::set(str_text, 1);
    level notify(#"hash_28a4818d");
    foreach (e_player in level.players) {
        e_player thread function_22510e73("zmInventory.widget_rune_parts", "zmInventory.player_rune_quest", 0);
    }
}

// Namespace namespace_cb655c88
// Params 3, eflags: 0x5 linked
// Checksum 0x6fb06c4a, Offset: 0x5640
// Size: 0xd4
function private function_22510e73(var_8ea57eb1, var_86a3391a, var_3fad0660) {
    self endon(#"disconnect");
    if (var_3fad0660) {
        if (isdefined(var_8ea57eb1)) {
            self thread clientfield::set_player_uimodel(var_8ea57eb1, 1);
        }
        var_83c971ff = 3.5;
    } else {
        var_83c971ff = 3.5;
    }
    self thread clientfield::set_player_uimodel(var_86a3391a, 1);
    level util::function_183e3618(var_83c971ff, "widget_ui_override", self, "disconnect");
    self thread clientfield::set_player_uimodel(var_86a3391a, 0);
}

// Namespace namespace_cb655c88
// Params 4, eflags: 0x1 linked
// Checksum 0xe58beb45, Offset: 0x5720
// Size: 0x27a
function function_ae4d938c(v_target_pos, var_e57941b7, var_ca841609, str_endon_notify) {
    self endon(#"bleed_out");
    self endon(#"death");
    self endon(#"disconnect");
    self endon(str_endon_notify);
    var_4a166ae5 = 2.4;
    var_38a8139 = var_e57941b7 * var_e57941b7;
    var_2b515bba = var_e57941b7 - var_ca841609;
    var_f6b0cbe4 = undefined;
    var_ac3d0ec3 = undefined;
    n_scale = undefined;
    var_887c2fcb = undefined;
    for (var_55ae5d19 = 1000; true; var_55ae5d19 += 0.05) {
        n_z_diff = abs(v_target_pos[2] - self.origin[2]);
        n_dist_sq = distance2dsquared(self.origin, v_target_pos);
        if (n_dist_sq <= var_38a8139 && n_z_diff < 84) {
            n_dist = distance2d(self.origin, v_target_pos) - var_ca841609;
            n_dist = n_dist < 0 ? 0 : n_dist;
            n_scale = n_dist / var_2b515bba;
            var_f6b0cbe4 = n_scale * var_4a166ae5;
            var_ac3d0ec3 = 0.2 + var_f6b0cbe4;
            var_887c2fcb = n_dist < var_2b515bba * 0.25 ? 2 : 1;
        } else {
            var_ac3d0ec3 = undefined;
        }
        if (isdefined(var_ac3d0ec3) && var_55ae5d19 > var_ac3d0ec3) {
            var_55ae5d19 = 0;
            self thread function_8d431c98(var_887c2fcb);
        }
        wait(0.05);
    }
}

// Namespace namespace_cb655c88
// Params 1, eflags: 0x1 linked
// Checksum 0xfb7bd4c8, Offset: 0x59a8
// Size: 0x6c
function function_8d431c98(var_887c2fcb) {
    self playsoundtoplayer("zmb_main_searchparty_ping", self);
    self function_6edf48d5(var_887c2fcb);
    util::wait_network_frame();
    self function_6edf48d5(0);
}

// Namespace namespace_cb655c88
// Params 1, eflags: 0x0
// Checksum 0x2f172e6b, Offset: 0x5a20
// Size: 0xbe
function function_32c765c5(v_origin) {
    n_closest_dist = 1e+07;
    a_players = getplayers();
    for (i = 0; i < a_players.size; i++) {
        n_dist = distance(a_players[i].origin, v_origin);
        if (n_dist < n_closest_dist) {
            n_closest_dist = n_dist;
        }
    }
    return n_closest_dist;
}

// Namespace namespace_cb655c88
// Params 3, eflags: 0x0
// Checksum 0xbeda4ca6, Offset: 0x5ae8
// Size: 0x5c
function function_a3c6e02f(e_to_delete, str_notify, n_delay) {
    e_to_delete endon(#"death");
    self waittill(str_notify);
    wait(n_delay);
    if (isdefined(e_to_delete)) {
        e_to_delete delete();
    }
}

// Namespace namespace_cb655c88
// Params 2, eflags: 0x1 linked
// Checksum 0xeb8e6eac, Offset: 0x5b50
// Size: 0x6c
function get_lookat_angles(v_start, v_end) {
    v_dir = v_end - v_start;
    v_dir = vectornormalize(v_dir);
    v_angles = vectortoangles(v_dir);
    return v_angles;
}

/#

    // Namespace namespace_cb655c88
    // Params 0, eflags: 0x1 linked
    // Checksum 0x1b60da99, Offset: 0x5bc8
    // Size: 0x114
    function function_e7e606b6() {
        level waittill(#"open_sesame");
        var_2bbbcbec = getentarray("actor", "actor");
        foreach (e_power in var_2bbbcbec) {
            e_power.var_98e1d15 = 1;
            var_7e0a45c8 = e_power.script_int;
            level thread zm_power::turn_power_on_and_open_doors(var_7e0a45c8);
        }
        zm_zonemgr::enable_zone("actor");
    }

    // Namespace namespace_cb655c88
    // Params 4, eflags: 0x0
    // Checksum 0x70f4a824, Offset: 0x5ce8
    // Size: 0x108
    function function_8faf1d24(v_color, var_8882142e, n_scale, str_endon) {
        if (!isdefined(v_color)) {
            v_color = (0, 0, 255);
        }
        if (!isdefined(var_8882142e)) {
            var_8882142e = "actor";
        }
        if (!isdefined(n_scale)) {
            n_scale = 0.25;
        }
        if (!isdefined(str_endon)) {
            str_endon = "actor";
        }
        if (getdvarint("actor") == 0) {
            return;
        }
        if (isdefined(str_endon)) {
            self endon(str_endon);
        }
        origin = self.origin;
        while (true) {
            print3d(origin, var_8882142e, v_color, n_scale);
            wait(0.1);
        }
    }

    // Namespace namespace_cb655c88
    // Params 5, eflags: 0x0
    // Checksum 0x42cc1e75, Offset: 0x5df8
    // Size: 0xc0
    function function_c7d0d818(v_start, v_end, str_endon, v_color, var_a12eb64b) {
        if (!isdefined(str_endon)) {
            str_endon = "actor";
        }
        if (!isdefined(v_color)) {
            v_color = (0, 1, 0);
        }
        if (!isdefined(var_a12eb64b)) {
            var_a12eb64b = "actor";
        }
        self endon(str_endon);
        self endon(var_a12eb64b);
        while (true) {
            recordline(v_start, v_end, v_color, "actor", self);
            wait(0.05);
        }
    }

    // Namespace namespace_cb655c88
    // Params 4, eflags: 0x0
    // Checksum 0x1747f9b8, Offset: 0x5ec0
    // Size: 0xa8
    function function_9ff5370d(v_origin, n_radius, v_color, e_owner) {
        if (!isdefined(n_radius)) {
            n_radius = 64;
        }
        if (!isdefined(v_color)) {
            v_color = (0, 1, 0);
        }
        if (!isdefined(e_owner)) {
            e_owner = self;
        }
        self endon(#"hash_dc898c8");
        while (isdefined(self)) {
            recordcircle(v_origin, n_radius, v_color, "actor", e_owner);
            wait(0.05);
        }
    }

    // Namespace namespace_cb655c88
    // Params 3, eflags: 0x0
    // Checksum 0xc23c43c9, Offset: 0x5f70
    // Size: 0xa8
    function function_68a764f6(n_radius, v_color, e_owner) {
        if (!isdefined(n_radius)) {
            n_radius = 64;
        }
        if (!isdefined(v_color)) {
            v_color = (0, 1, 0);
        }
        if (!isdefined(e_owner)) {
            e_owner = self;
        }
        self endon(#"hash_5322c93b");
        while (isdefined(self)) {
            recordsphere(self.origin, n_radius, v_color, "actor", e_owner);
            wait(0.05);
        }
    }

    // Namespace namespace_cb655c88
    // Params 3, eflags: 0x0
    // Checksum 0xfee0c0f1, Offset: 0x6020
    // Size: 0x90
    function function_ff016910(str_text, v_color, e_owner) {
        if (!isdefined(v_color)) {
            v_color = (0, 1, 0);
        }
        if (!isdefined(e_owner)) {
            e_owner = self;
        }
        self endon(#"hash_8fba9");
        while (isdefined(self)) {
            record3dtext(str_text, self.origin, v_color, "actor", e_owner);
            wait(0.05);
        }
    }

    // Namespace namespace_cb655c88
    // Params 2, eflags: 0x1 linked
    // Checksum 0xc3e74598, Offset: 0x60b8
    // Size: 0x1b8
    function function_ea73a995(v_color, str_ender) {
        if (!isdefined(v_color)) {
            v_color = (0, 1, 0);
        }
        if (!isdefined(str_ender)) {
            str_ender = "actor";
        }
        self endon(#"death");
        level endon(str_ender);
        for (;;) {
            forward = anglestoforward(self.angles);
            forwardfar = vectorscale(forward, 30);
            forwardclose = vectorscale(forward, 20);
            right = anglestoright(self.angles);
            left = vectorscale(right, -10);
            right = vectorscale(right, 10);
            line(self.origin, self.origin + forwardfar, v_color, 0.9);
            line(self.origin + forwardfar, self.origin + forwardclose + right, v_color, 0.9);
            line(self.origin + forwardfar, self.origin + forwardclose + left, v_color, 0.9);
            wait(0.05);
        }
    }

    // Namespace namespace_cb655c88
    // Params 3, eflags: 0x1 linked
    // Checksum 0x4528b9be, Offset: 0x6278
    // Size: 0x144
    function function_d8db939b(str_flag, var_6e86b6bc, str_ender) {
        if (!isdefined(var_6e86b6bc)) {
            var_6e86b6bc = 0;
        }
        if (!isdefined(str_ender)) {
            str_ender = "actor";
        }
        level endon(str_ender);
        if (level flag::get(str_flag)) {
            print("actor" + str_flag + "actor" + "actor");
            if (var_6e86b6bc) {
                iprintlnbold("actor" + str_flag + "actor");
            }
            return;
        }
        level flag::wait_till(str_flag);
        print("actor" + str_flag + "actor" + "actor");
        if (var_6e86b6bc) {
            iprintlnbold("actor" + str_flag + "actor");
        }
    }

    // Namespace namespace_cb655c88
    // Params 0, eflags: 0x1 linked
    // Checksum 0xd670cbe4, Offset: 0x63c8
    // Size: 0x64
    function function_1f006e62() {
        level thread function_5787bc10();
        level thread function_1953a761();
        level thread function_c0411192();
        level thread function_90c620d8();
    }

    // Namespace namespace_cb655c88
    // Params 0, eflags: 0x1 linked
    // Checksum 0xb066b9d1, Offset: 0x6438
    // Size: 0x124
    function function_c0411192() {
        level notify(#"hash_7fb84095");
        var_3e38f0ae = struct::get_array("actor");
        a_s_parts = struct::get_array("actor");
        var_3e38f0ae = arraycombine(var_3e38f0ae, a_s_parts, 0, 0);
        a_s_parts = struct::get_array("actor");
        var_3e38f0ae = arraycombine(var_3e38f0ae, a_s_parts, 0, 0);
        a_s_parts = struct::get_array("actor");
        var_3e38f0ae = arraycombine(var_3e38f0ae, a_s_parts, 0, 0);
        array::thread_all(var_3e38f0ae, &function_b411d2a8);
    }

    // Namespace namespace_cb655c88
    // Params 0, eflags: 0x1 linked
    // Checksum 0xa4c1c8a, Offset: 0x6568
    // Size: 0x124
    function function_6c518807() {
        level notify(#"hash_6fd18b70");
        var_3e38f0ae = struct::get_array("actor");
        a_s_parts = struct::get_array("actor");
        var_3e38f0ae = arraycombine(var_3e38f0ae, a_s_parts, 0, 0);
        a_s_parts = struct::get_array("actor");
        var_3e38f0ae = arraycombine(var_3e38f0ae, a_s_parts, 0, 0);
        a_s_parts = struct::get_array("actor");
        var_3e38f0ae = arraycombine(var_3e38f0ae, a_s_parts, 0, 0);
        array::thread_all(var_3e38f0ae, &function_ba547024);
    }

    // Namespace namespace_cb655c88
    // Params 0, eflags: 0x1 linked
    // Checksum 0x2ff79d55, Offset: 0x6698
    // Size: 0xb8
    function function_ba547024() {
        level endon(#"hash_6fd18b70");
        v_color = (0, 1, 0);
        n_radius = 32;
        if (self.targetname == "actor") {
            v_color = (1, 1, 0);
            n_radius = 16;
        }
        self thread function_ea73a995(v_color, "actor");
        while (true) {
            circle(self.origin, n_radius, v_color);
            wait(0.05);
        }
    }

    // Namespace namespace_cb655c88
    // Params 0, eflags: 0x1 linked
    // Checksum 0x454163c8, Offset: 0x6758
    // Size: 0x100
    function function_b411d2a8() {
        level endon(#"hash_7fb84095");
        if (!ispointonnavmesh(self.origin)) {
            print("actor" + self.origin + "actor");
            while (!ispointonnavmesh(self.origin) && function_4086bd17(self.origin)) {
                sphere(self.origin, 16, (1, 0, 0));
                print3d(self.origin + (0, 0, 16), self.origin + "actor", (1, 0, 0));
                wait(0.05);
            }
        }
    }

    // Namespace namespace_cb655c88
    // Params 0, eflags: 0x1 linked
    // Checksum 0x25d1c64c, Offset: 0x6860
    // Size: 0x21c
    function function_5787bc10() {
        level notify(#"hash_79ca2895");
        a_s_points = struct::get_array("actor");
        a_s_respawn_points = [];
        foreach (s_respawn in a_s_points) {
            var_c901c998 = struct::get_array(s_respawn.target);
            foreach (j, s_point in var_c901c998) {
                a_s_respawn_points[j] = s_point;
            }
        }
        a_s_spawn_points = arraycombine(a_s_points, a_s_respawn_points, 0, 0);
        var_c16df719 = struct::get_array("actor");
        array::thread_all(var_c16df719, &function_2e9f38b0);
        array::thread_all(a_s_spawn_points, &function_7129ea51);
        array::thread_all(level.zones, &function_3d73091f);
    }

    // Namespace namespace_cb655c88
    // Params 0, eflags: 0x1 linked
    // Checksum 0xa81e760c, Offset: 0x6a88
    // Size: 0x9c
    function function_f448730a() {
        level notify(#"hash_3e617e39");
        for (i = 1; i < 4; i++) {
            level scene::add_scene_func("actor" + i, &function_871166cb, "actor");
        }
        array::thread_all(level.zones, &function_a41558a6);
    }

    // Namespace namespace_cb655c88
    // Params 0, eflags: 0x1 linked
    // Checksum 0x353f64ea, Offset: 0x6b30
    // Size: 0x9c
    function function_81eb9b35() {
        level notify(#"hash_3e617e39");
        for (i = 1; i < 4; i++) {
            level scene::remove_scene_func("actor" + i, &function_871166cb, "actor");
        }
        array::thread_all(level.zones, &function_141ddc35);
    }

    // Namespace namespace_cb655c88
    // Params 1, eflags: 0x1 linked
    // Checksum 0x7340e962, Offset: 0x6bd8
    // Size: 0x154
    function function_871166cb(a_ents) {
        a_ents[0] thread function_ea73a995((1, 1, 0), "actor");
        recordent(a_ents[0]);
        if (!ispointonnavmesh(a_ents[0].origin)) {
            for (i = 0; i < 20; i++) {
                sphere(a_ents[0].origin, 16, (1, 0, 0));
                print3d(a_ents[0].origin + (0, 0, 16), a_ents[0].origin + "actor", (1, 0, 0));
                wait(0.05);
            }
        }
        wait(3);
        if (isai(a_ents[0])) {
            return;
        }
        a_ents[0] delete();
    }

    // Namespace namespace_cb655c88
    // Params 0, eflags: 0x1 linked
    // Checksum 0x12092520, Offset: 0x6d38
    // Size: 0x9a
    function function_a41558a6() {
        foreach (a_locs in self.a_loc_types) {
            array::thread_all(a_locs, &function_835d6248);
        }
    }

    // Namespace namespace_cb655c88
    // Params 0, eflags: 0x1 linked
    // Checksum 0x4698411c, Offset: 0x6de0
    // Size: 0x9a
    function function_141ddc35() {
        foreach (a_locs in self.a_loc_types) {
            array::thread_all(a_locs, &function_3e617e39);
        }
    }

    // Namespace namespace_cb655c88
    // Params 0, eflags: 0x1 linked
    // Checksum 0x3d2b192c, Offset: 0x6e88
    // Size: 0xea
    function function_3d73091f() {
        assert(self.a_loc_types["actor"].size > 0, "actor" + self.volumes[0].targetname + "actor");
        foreach (a_locs in self.a_loc_types) {
            array::thread_all(a_locs, &function_2e9f38b0);
        }
    }

    // Namespace namespace_cb655c88
    // Params 0, eflags: 0x1 linked
    // Checksum 0x5eb31350, Offset: 0x6f80
    // Size: 0x128
    function function_2e9f38b0() {
        level endon(#"hash_79ca2895");
        if (self.script_noteworthy == "actor") {
            return;
        }
        if (!ispointonnavmesh(self.origin) && self.script_noteworthy != "actor") {
            print("actor" + self.origin + "actor");
            while (!ispointonnavmesh(self.origin)) {
                sphere(self.origin, 32, (1, 0, 0));
                print3d(self.origin + (0, 0, 16), self.origin + "actor" + self.script_noteworthy + "actor" + self.zone_name, (1, 0, 0));
                wait(0.05);
            }
        }
    }

    // Namespace namespace_cb655c88
    // Params 0, eflags: 0x0
    // Checksum 0xbf34817e, Offset: 0x70b0
    // Size: 0xc4
    function function_e0a812f0() {
        if (self.script_noteworthy == "actor") {
            if (!isdefined(self.var_640b69b2)) {
                self.var_640b69b2 = util::spawn_model("actor", self.origin, self.angles);
            }
            self.var_640b69b2 scene::play("actor" + randomintrange(1, 3));
            if (isdefined(self.var_969d82a4)) {
                self.var_969d82a4 delete();
            }
        }
    }

    // Namespace namespace_cb655c88
    // Params 0, eflags: 0x1 linked
    // Checksum 0x540e72a0, Offset: 0x7180
    // Size: 0xd8
    function function_835d6248() {
        level endon(#"hash_3e617e39");
        if (self.script_noteworthy == "actor") {
            while (true) {
                if (!isdefined(self.var_640b69b2)) {
                    self.var_640b69b2 = util::spawn_model("actor", self.origin, self.angles);
                    self.var_640b69b2 thread function_ea73a995(undefined, "actor");
                }
                self.var_640b69b2 scene::play("actor" + randomintrange(1, 3));
                wait(0.05);
            }
        }
    }

    // Namespace namespace_cb655c88
    // Params 0, eflags: 0x1 linked
    // Checksum 0xb2495475, Offset: 0x7260
    // Size: 0x8c
    function function_3e617e39() {
        if (self.script_noteworthy == "actor") {
            if (isdefined(self.var_640b69b2)) {
                for (i = 1; i < 4; i++) {
                    self.var_640b69b2 scene::stop("actor" + i);
                }
                self.var_640b69b2 delete();
            }
        }
    }

    // Namespace namespace_cb655c88
    // Params 0, eflags: 0x1 linked
    // Checksum 0x359fa1da, Offset: 0x72f8
    // Size: 0xe8
    function function_7129ea51() {
        level endon(#"hash_79ca2895");
        if (!ispointonnavmesh(self.origin)) {
            print("actor" + self.origin + "actor");
            while (!ispointonnavmesh(self.origin)) {
                sphere(self.origin, 16, (1, 0, 0));
                print3d(self.origin + (0, 0, 16), self.origin + "actor" + self.script_noteworthy, (1, 0, 0));
                wait(0.05);
            }
        }
    }

    // Namespace namespace_cb655c88
    // Params 0, eflags: 0x1 linked
    // Checksum 0xbacc07e6, Offset: 0x73e8
    // Size: 0x5c
    function function_1953a761() {
        level notify(#"hash_4a4c33ec");
        a_s_points = struct::get_array("actor");
        array::thread_all(a_s_points, &function_ed69d7f4);
    }

    // Namespace namespace_cb655c88
    // Params 0, eflags: 0x1 linked
    // Checksum 0x689770ed, Offset: 0x7450
    // Size: 0x108
    function function_ed69d7f4() {
        level endon(#"hash_4a4c33ec");
        if (!ispointonnavmesh(self.origin, 61.88) || function_4086bd17(self.origin)) {
            print("actor" + self.origin + "actor");
            while (true) {
                sphere(self.origin, 61.88, (1, 1, 0));
                print3d(self.origin + (0, 0, 16), self.origin + "actor", (1, 1, 0));
                wait(0.05);
            }
        }
    }

    // Namespace namespace_cb655c88
    // Params 1, eflags: 0x1 linked
    // Checksum 0x6994d320, Offset: 0x7560
    // Size: 0x7e
    function function_4086bd17(v_point) {
        a_trace = bullettrace(v_point, v_point + (0, 0, -2000), 0, undefined, 0);
        if (distance2dsquared(a_trace["actor"], v_point) > 36) {
            return 1;
        }
        return 0;
    }

    // Namespace namespace_cb655c88
    // Params 0, eflags: 0x1 linked
    // Checksum 0x71323a63, Offset: 0x75e8
    // Size: 0x64
    function function_90c620d8() {
        level notify(#"hash_6aa36145");
        var_9f26317f = getentarray("actor", "actor");
        array::thread_all(var_9f26317f, &function_7b7eeb90);
    }

    // Namespace namespace_cb655c88
    // Params 0, eflags: 0x1 linked
    // Checksum 0xd5eeddcd, Offset: 0x7658
    // Size: 0xc2
    function function_5e8cafb9() {
        level notify(#"hash_27118146");
        foreach (t_door in self) {
            if (isdefined(t_door.script_flag)) {
                level thread function_d8db939b(t_door.script_flag, 1, "actor");
            }
        }
    }

    // Namespace namespace_cb655c88
    // Params 0, eflags: 0x1 linked
    // Checksum 0x9fee3dd9, Offset: 0x7728
    // Size: 0x28
    function function_7b7eeb90() {
        var_3ccf13b = self function_78e15936();
    }

    // Namespace namespace_cb655c88
    // Params 0, eflags: 0x1 linked
    // Checksum 0x12c54cb3, Offset: 0x7758
    // Size: 0x14e
    function function_78e15936() {
        var_3ccf13b = [];
        a_e_targets = getentarray(self.target, "actor");
        foreach (e_target in a_e_targets) {
            if (e_target.classname == "actor" || e_target.script_string === "actor") {
                if (!isdefined(var_3ccf13b)) {
                    var_3ccf13b = [];
                } else if (!isarray(var_3ccf13b)) {
                    var_3ccf13b = array(var_3ccf13b);
                }
                var_3ccf13b[var_3ccf13b.size] = e_target;
            }
        }
        return var_3ccf13b;
    }

    // Namespace namespace_cb655c88
    // Params 0, eflags: 0x1 linked
    // Checksum 0x384c1e32, Offset: 0x78b0
    // Size: 0x328
    function function_bc81bb3b() {
        level endon(#"hash_27118146");
        if (!isdefined(self.script_flag)) {
            if (isdefined(self.script_noteworthy)) {
                while (true) {
                    print3d(self.origin + (0, 0, 64), "actor" + self.script_noteworthy, (0, 0, 1), 1, 0.5);
                    wait(0.05);
                }
            }
            return;
        }
        while (true) {
            n_offset = 0;
            var_3b72f06c = [];
            v_color = (1, 1, 0);
            if (level flag::exists(self.script_flag) && level flag::get(self.script_flag)) {
                v_color = (0, 1, 0);
            }
            print3d(self.origin + (0, 0, 64), "actor" + self.script_flag, v_color, 1, 0.5);
            if (isdefined(level.zone_flags[self.script_flag])) {
                foreach (i, str_flag in level.zone_flags[self.script_flag]) {
                    n_offset -= 16;
                    var_3b72f06c[i] = n_offset;
                }
                foreach (j, str_flag in level.zone_flags[self.script_flag]) {
                    var_1adee14a = (1, 1, 0);
                    if (level flag::exists(str_flag) && level flag::get(str_flag)) {
                        var_1adee14a = (0, 1, 0);
                    }
                    print3d(self.origin + (0, 0, 64 + var_3b72f06c[j]), "actor" + str_flag, var_1adee14a, 1, 0.5);
                }
            }
            wait(0.05);
        }
    }

    // Namespace namespace_cb655c88
    // Params 0, eflags: 0x0
    // Checksum 0x92bdefca, Offset: 0x7be0
    // Size: 0xe8
    function function_b3db2cea() {
        level endon(#"hash_4a4c33ec");
        if (!ispointonnavmesh(self.origin, 96)) {
            print("actor" + self.origin + "actor");
            while (!ispointonnavmesh(self.origin)) {
                sphere(self.origin, 96, (1, 1, 0), 0.5);
                print3d(self.origin + (0, 0, 16), "actor", (1, 1, 0));
                wait(0.05);
            }
        }
    }

    // Namespace namespace_cb655c88
    // Params 0, eflags: 0x1 linked
    // Checksum 0x76fb0aea, Offset: 0x7cd0
    // Size: 0x22c
    function devgui() {
        adddebugcommand("actor");
        adddebugcommand("actor");
        adddebugcommand("actor");
        adddebugcommand("actor");
        adddebugcommand("actor");
        adddebugcommand("actor");
        adddebugcommand("actor");
        adddebugcommand("actor");
        adddebugcommand("actor");
        adddebugcommand("actor");
        adddebugcommand("actor");
        adddebugcommand("actor");
        adddebugcommand("actor");
        adddebugcommand("actor");
        adddebugcommand("actor");
        adddebugcommand("actor");
        adddebugcommand("actor");
        adddebugcommand("actor");
        adddebugcommand("actor");
        level thread function_72260d3a("actor", "actor", 1, &namespace_df27fee4::function_e1963311);
        zm_devgui::add_custom_devgui_callback(&function_dbc092aa);
    }

    // Namespace namespace_cb655c88
    // Params 1, eflags: 0x1 linked
    // Checksum 0x54fa2c87, Offset: 0x7f08
    // Size: 0x53e
    function function_dbc092aa(cmd) {
        var_98be8724 = strtok(cmd, "actor");
        switch (var_98be8724[0]) {
        case 8:
            var_9f26317f = getentarray("actor", "actor");
            var_9f26317f thread function_5e8cafb9();
            foreach (t_door in var_9f26317f) {
                var_3ccf13b = t_door function_78e15936();
                array::thread_all(var_3ccf13b, &function_bc81bb3b);
            }
            break;
        case 8:
            level notify(#"hash_27118146");
            break;
        case 8:
            function_712a86f4(1);
            break;
        case 8:
            function_712a86f4(2);
            break;
        case 8:
            function_712a86f4(3);
            break;
        case 8:
            function_712a86f4(4);
            break;
        case 8:
            function_f448730a();
            break;
        case 8:
            function_81eb9b35();
            break;
        case 8:
            function_6c518807();
            break;
        case 8:
            level notify(#"hash_6fd18b70");
            break;
        case 8:
            level.activeplayers[0] function_4667bb64();
            break;
        case 8:
            level.activeplayers[0] function_4530c3b2();
            break;
        case 8:
            level.activeplayers[0] function_c78305e0();
            break;
        case 8:
            level.activeplayers[0] function_d5c8a6c2();
            break;
        case 8:
            foreach (e_player in level.activeplayers) {
                e_player namespace_a9c2433b::function_4d6562d8();
            }
            break;
        case 8:
            foreach (e_player in level.activeplayers) {
                e_player namespace_a9c2433b::function_42781615();
            }
            break;
        case 8:
            level flag::set("actor");
            break;
        case 8:
            if (isdefined(level.ball)) {
                level.ball ball::function_98827162(0);
            }
            break;
        case 8:
            level thread function_76c3e6c4();
            break;
        case 8:
            foreach (e_player in level.activeplayers) {
                level thread namespace_ccb5d78d::function_e53a7954(e_player);
            }
            break;
        default:
            break;
        }
    }

    // Namespace namespace_cb655c88
    // Params 0, eflags: 0x1 linked
    // Checksum 0x6ba2ea73, Offset: 0x8450
    // Size: 0x24
    function function_4667bb64() {
        self endon(#"death");
        ball::function_b4352e6c(self);
    }

    // Namespace namespace_cb655c88
    // Params 0, eflags: 0x1 linked
    // Checksum 0x6f029834, Offset: 0x8480
    // Size: 0x24
    function function_4530c3b2() {
        self endon(#"death");
        ball::function_7eb07bb0(self);
    }

    // Namespace namespace_cb655c88
    // Params 0, eflags: 0x1 linked
    // Checksum 0x806758af, Offset: 0x84b0
    // Size: 0x24
    function function_c78305e0() {
        self endon(#"death");
        ball::function_5faeea5e(self);
    }

    // Namespace namespace_cb655c88
    // Params 0, eflags: 0x1 linked
    // Checksum 0x546737a9, Offset: 0x84e0
    // Size: 0x2c
    function function_d5c8a6c2() {
        self endon(#"death");
        ball::function_257ed160(self, 1);
    }

    // Namespace namespace_cb655c88
    // Params 1, eflags: 0x1 linked
    // Checksum 0x10308350, Offset: 0x8518
    // Size: 0x10a
    function function_712a86f4(var_7e0a45c8) {
        var_2bbbcbec = getentarray("actor", "actor");
        foreach (e_power in var_2bbbcbec) {
            if (e_power.script_int == var_7e0a45c8) {
                e_power.var_98e1d15 = 1;
                var_7e0a45c8 = e_power.script_int;
                level thread zm_power::turn_power_on_and_open_doors(var_7e0a45c8);
            }
        }
    }

    // Namespace namespace_cb655c88
    // Params 0, eflags: 0x1 linked
    // Checksum 0x5b82cfd5, Offset: 0x8630
    // Size: 0x1e6
    function function_30672281() {
        var_2f06ca53 = 0;
        var_f1ef8e43 = [];
        while (true) {
            for (i = 0; i < level.activeplayers.size; i++) {
                n_ypos = var_2f06ca53 * 10 + 11;
                if (isdefined(level.activeplayers[i])) {
                    if (isgodmode(level.activeplayers[i]) && !isdefined(var_f1ef8e43[level.activeplayers[i].name])) {
                        var_f1ef8e43[level.activeplayers[i].name] = function_a1bfa962(level.activeplayers[i], level.activeplayers[i].name + "actor", 2, n_ypos);
                        var_2f06ca53++;
                    }
                    if (!isgodmode(level.activeplayers[i]) && isdefined(var_f1ef8e43[level.activeplayers[i].name])) {
                        var_f1ef8e43[level.activeplayers[i].name] destroy();
                        var_2f06ca53--;
                    }
                }
            }
            wait(1);
        }
    }

    // Namespace namespace_cb655c88
    // Params 0, eflags: 0x1 linked
    // Checksum 0xa5dadd54, Offset: 0x8820
    // Size: 0xee
    function function_76c3e6c4() {
        foreach (e_player in level.activeplayers) {
            e_player.var_54343c90 = 1;
            e_player allowwallrun(1);
            e_player allowdoublejump(1);
            e_player setperk("actor");
            e_player.var_7dd18a0 = 1;
        }
    }

#/
