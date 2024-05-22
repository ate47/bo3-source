#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_unitrigger;
#using scripts/zm/_zm_score;
#using scripts/zm/_zm_laststand;
#using scripts/zm/_zm_audio;
#using scripts/zm/_zm_ai_wasp;
#using scripts/zm/_zm_ai_raps;
#using scripts/zm/_zm_ai_margwa;
#using scripts/shared/ai/zombie_utility;
#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/array_shared;
#using scripts/codescripts/struct;

#namespace namespace_8e578893;

// Namespace namespace_8e578893
// Params 0, eflags: 0x2
// Checksum 0x5fb11104, Offset: 0x348
// Size: 0x3c
function function_2dc19561() {
    system::register("zm_zod_util", &__init__, &__main__, undefined);
}

// Namespace namespace_8e578893
// Params 0, eflags: 0x1 linked
// Checksum 0xe7160671, Offset: 0x390
// Size: 0x10
function __init__() {
    level.var_51a9eeb9 = [];
}

// Namespace namespace_8e578893
// Params 0, eflags: 0x1 linked
// Checksum 0xee9d1fcd, Offset: 0x3a8
// Size: 0x124
function __main__() {
    /#
        assert(isdefined(level.zombie_spawners));
    #/
    if (isdefined(level.var_df6256da)) {
        foreach (fn in level.var_df6256da) {
            function_6681ab86(fn);
        }
    }
    level.var_df6256da = undefined;
    function_6681ab86(&function_3fb7d590);
    callback::on_connect(&on_player_connect);
    level.var_ee31d3b1 = struct::get_array("teleport_position");
}

// Namespace namespace_8e578893
// Params 2, eflags: 0x1 linked
// Checksum 0x41cbcb1, Offset: 0x4d8
// Size: 0xe2
function function_6c995606(v_pos, v_angles) {
    if (level.var_51a9eeb9.size == 0) {
        e_model = util::spawn_model("tag_origin", v_pos, v_angles);
        return e_model;
    }
    n_index = level.var_51a9eeb9.size - 1;
    e_model = level.var_51a9eeb9[n_index];
    arrayremoveindex(level.var_51a9eeb9, n_index);
    e_model.angles = v_angles;
    e_model.origin = v_pos;
    e_model notify(#"hash_7af2343d");
    return e_model;
}

// Namespace namespace_8e578893
// Params 0, eflags: 0x1 linked
// Checksum 0x495976e7, Offset: 0x5c8
// Size: 0x84
function function_44a841() {
    if (!isdefined(level.var_51a9eeb9)) {
        level.var_51a9eeb9 = [];
    } else if (!isarray(level.var_51a9eeb9)) {
        level.var_51a9eeb9 = array(level.var_51a9eeb9);
    }
    level.var_51a9eeb9[level.var_51a9eeb9.size] = self;
    self thread function_5fec5f06();
}

// Namespace namespace_8e578893
// Params 0, eflags: 0x5 linked
// Checksum 0x695cd8a1, Offset: 0x658
// Size: 0x4c
function function_5fec5f06() {
    self endon(#"hash_7af2343d");
    wait(20);
    arrayremovevalue(level.var_51a9eeb9, self);
    self delete();
}

// Namespace namespace_8e578893
// Params 0, eflags: 0x5 linked
// Checksum 0xdafbd50c, Offset: 0x6b0
// Size: 0xd2
function function_3fb7d590() {
    e_attacker, str_means_of_death, weapon = self waittill(#"death");
    if (isdefined(self)) {
        if (isdefined(level.var_7806fb91)) {
            foreach (fn_callback in level.var_7806fb91) {
                self thread [[ fn_callback ]](e_attacker, str_means_of_death, weapon);
            }
        }
    }
}

// Namespace namespace_8e578893
// Params 1, eflags: 0x1 linked
// Checksum 0xb333c970, Offset: 0x790
// Size: 0x4c
function function_f7f2ffed(v) {
    return "<" + v[0] + ", " + v[1] + ", " + v[2] + ">";
}

// Namespace namespace_8e578893
// Params 1, eflags: 0x1 linked
// Checksum 0x522a28fa, Offset: 0x7e8
// Size: 0x170
function function_d92ce25(player) {
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
    if (isdefined(param1)) {
        self sethintstring(str_msg, param1);
    } else {
        self sethintstring(str_msg);
    }
    return b_visible;
}

// Namespace namespace_8e578893
// Params 0, eflags: 0x1 linked
// Checksum 0x15bd2504, Offset: 0x960
// Size: 0x1c
function function_c1947ff7() {
    self zm_unitrigger::run_visibility_function_for_all_triggers();
}

// Namespace namespace_8e578893
// Params 0, eflags: 0x0
// Checksum 0xe5d9a087, Offset: 0x988
// Size: 0x10
function function_4973348c() {
    self.var_8842df9d = 1;
}

// Namespace namespace_8e578893
// Params 0, eflags: 0x5 linked
// Checksum 0xfc80aa6f, Offset: 0x9a0
// Size: 0x9c
function function_c54cd556() {
    self endon(#"kill_trigger");
    self.stub thread function_c1947ff7();
    while (true) {
        player = self waittill(#"trigger");
        if (isdefined(self.var_8842df9d) && self.var_8842df9d || !(isdefined(player.beastmode) && player.beastmode)) {
            self.stub notify(#"trigger", player);
        }
    }
}

// Namespace namespace_8e578893
// Params 1, eflags: 0x0
// Checksum 0xe7346c2b, Offset: 0xa48
// Size: 0x3cc
function teleport_player(struct_targetname) {
    /#
        assert(isdefined(struct_targetname));
    #/
    a_dest = struct::get_array(struct_targetname, "targetname");
    if (a_dest.size == 0) {
        /#
            /#
                assertmsg("unitrigger_radius" + struct_targetname + "unitrigger_radius");
            #/
        #/
        return;
    }
    var_fcd1ef5d = a_dest[0].origin;
    var_f4f312e3 = a_dest[0].angles;
    var_675a91a3 = 0;
    var_accbe04 = function_6c995606(self.origin, self.angles);
    self playerlinktoabsolute(var_accbe04, "tag_origin");
    var_accbe04.origin = level.var_ee31d3b1[self.characterindex].origin;
    var_accbe04.angles = level.var_ee31d3b1[self.characterindex].angles;
    self freezecontrols(1);
    self disableweapons();
    self disableoffhandweapons();
    wait(2);
    foreach (s_dest in a_dest) {
        foreach (e_player in level.players) {
            if (distance2dsquared(e_player.origin, s_dest.origin) > 10000) {
                var_675a91a3 = 1;
                var_fcd1ef5d = s_dest.origin;
                var_f4f312e3 = s_dest.angles;
                break;
            }
        }
        if (var_675a91a3) {
            break;
        }
    }
    var_accbe04.origin = var_fcd1ef5d;
    var_accbe04.angles = var_f4f312e3;
    wait(0.5);
    self unlink();
    var_accbe04 function_44a841();
    self freezecontrols(0);
    self enableweapons();
    self enableoffhandweapons();
}

// Namespace namespace_8e578893
// Params 2, eflags: 0x1 linked
// Checksum 0x7579c6d6, Offset: 0xe20
// Size: 0x64
function function_d73e42e0(str_message, param1) {
    self.hint_string = str_message;
    self.hint_parm1 = param1;
    zm_unitrigger::unregister_unitrigger(self);
    zm_unitrigger::register_unitrigger(self, &function_c54cd556);
}

// Namespace namespace_8e578893
// Params 5, eflags: 0x5 linked
// Checksum 0xc2ef750e, Offset: 0xe90
// Size: 0x1f8
function function_a40fee2f(origin, angles, var_3b9cee11, use_trigger, var_cd7edcab) {
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
    trigger_stub.prompt_and_visibility_func = &function_d92ce25;
    zm_unitrigger::register_unitrigger(trigger_stub, &function_c54cd556);
    return trigger_stub;
}

// Namespace namespace_8e578893
// Params 4, eflags: 0x1 linked
// Checksum 0xe7b132ee, Offset: 0x1090
// Size: 0x5a
function function_d095318(origin, radius, use_trigger, var_cd7edcab) {
    if (!isdefined(use_trigger)) {
        use_trigger = 0;
    }
    return function_a40fee2f(origin, undefined, radius, use_trigger, var_cd7edcab);
}

// Namespace namespace_8e578893
// Params 5, eflags: 0x1 linked
// Checksum 0xb00194d2, Offset: 0x10f8
// Size: 0x62
function function_c17c0335(origin, angles, var_f726970c, use_trigger, var_cd7edcab) {
    if (!isdefined(use_trigger)) {
        use_trigger = 0;
    }
    return function_a40fee2f(origin, angles, var_f726970c, use_trigger, var_cd7edcab);
}

// Namespace namespace_8e578893
// Params 1, eflags: 0x1 linked
// Checksum 0xb101cac6, Offset: 0x1168
// Size: 0x11c
function function_6681ab86(var_16552c29) {
    if (!isdefined(level.zombie_spawners)) {
        if (!isdefined(level.var_df6256da)) {
            level.var_df6256da = [];
        }
        if (!isdefined(level.var_df6256da)) {
            level.var_df6256da = [];
        } else if (!isarray(level.var_df6256da)) {
            level.var_df6256da = array(level.var_df6256da);
        }
        level.var_df6256da[level.var_df6256da.size] = var_16552c29;
        return;
    }
    array::thread_all(level.zombie_spawners, &spawner::add_spawn_function, var_16552c29);
    var_9fe2a32c = getentarray("ritual_zombie_spawner", "targetname");
    array::thread_all(var_9fe2a32c, &spawner::add_spawn_function, var_16552c29);
}

// Namespace namespace_8e578893
// Params 0, eflags: 0x1 linked
// Checksum 0x7ba8abba, Offset: 0x1290
// Size: 0xb2
function on_player_connect() {
    self endon(#"disconnect");
    while (true) {
        self waittill(#"bled_out");
        if (isdefined(level.var_d4326708)) {
            foreach (fn in level.var_d4326708) {
                self thread [[ fn ]]();
            }
        }
    }
}

// Namespace namespace_8e578893
// Params 1, eflags: 0x1 linked
// Checksum 0x41550f87, Offset: 0x1350
// Size: 0x92
function function_2d5dfb29(var_57314382) {
    if (!isdefined(level.var_7806fb91)) {
        level.var_7806fb91 = [];
    }
    if (!isdefined(level.var_7806fb91)) {
        level.var_7806fb91 = [];
    } else if (!isarray(level.var_7806fb91)) {
        level.var_7806fb91 = array(level.var_7806fb91);
    }
    level.var_7806fb91[level.var_7806fb91.size] = var_57314382;
}

// Namespace namespace_8e578893
// Params 1, eflags: 0x1 linked
// Checksum 0x294a7fe6, Offset: 0x13f0
// Size: 0x92
function function_658879b1(fn_callback) {
    if (!isdefined(level.var_d4326708)) {
        level.var_d4326708 = [];
    }
    if (!isdefined(level.var_d4326708)) {
        level.var_d4326708 = [];
    } else if (!isarray(level.var_d4326708)) {
        level.var_d4326708 = array(level.var_d4326708);
    }
    level.var_d4326708[level.var_d4326708.size] = fn_callback;
}

// Namespace namespace_8e578893
// Params 2, eflags: 0x1 linked
// Checksum 0xcb377cbc, Offset: 0x1490
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

// Namespace namespace_8e578893
// Params 4, eflags: 0x1 linked
// Checksum 0xf3a5e99b, Offset: 0x1520
// Size: 0x102
function function_3a7a7013(var_5017cd53, n_radius, v_origin, var_d00db512) {
    var_699d80d5 = n_radius * n_radius;
    foreach (player in level.activeplayers) {
        if (isdefined(player) && distance2dsquared(player.origin, v_origin) <= var_699d80d5) {
            player thread function_6edf48d5(var_5017cd53, var_d00db512);
        }
    }
}

// Namespace namespace_8e578893
// Params 3, eflags: 0x1 linked
// Checksum 0x12987d36, Offset: 0x1630
// Size: 0x11c
function function_5cc835d6(v_origin, v_target, n_duration) {
    /#
        assert(isdefined(v_origin), "unitrigger_radius");
    #/
    /#
        assert(isdefined(v_target), "unitrigger_radius");
    #/
    e_fx = function_6c995606(v_origin, (0, 0, 0));
    e_fx clientfield::set("zod_egg_soul", 1);
    e_fx moveto(v_target, n_duration);
    e_fx waittill(#"movedone");
    e_fx clientfield::set("zod_egg_soul", 0);
    e_fx function_44a841();
}

// Namespace namespace_8e578893
// Params 1, eflags: 0x1 linked
// Checksum 0x67ff3d05, Offset: 0x1758
// Size: 0x28c
function function_15166300(var_c3a9e22d) {
    var_49fa7253 = 0;
    var_565450eb = 0;
    var_f747e67a = 0;
    var_e3b7af42 = 0;
    switch (var_c3a9e22d) {
    case 1:
        var_565450eb = zombie_utility::get_current_zombie_count();
        var_32218d0b = min(level.activeplayers.size * 5, 10);
        var_49fa7253 = var_32218d0b - var_565450eb;
        break;
    case 2:
        var_f747e67a = namespace_b1ca30af::function_acc1c531();
        var_32218d0b = min(level.activeplayers.size * 4, 8);
        var_49fa7253 = var_32218d0b - var_f747e67a;
        break;
    case 3:
        var_e3b7af42 = namespace_5ace0f0e::function_30f083dc();
        var_32218d0b = min(level.activeplayers.size * 4, 13);
        var_49fa7253 = var_32218d0b - var_e3b7af42;
        break;
    case 4:
        var_49fa7253 = 3 - level.var_6e63e659;
        var_73d2bce8 = level.zm_loc_types["margwa_location"].size < 1;
        if (var_73d2bce8) {
            var_49fa7253 = 0;
        }
        break;
    }
    var_4422ef10 = var_565450eb + var_f747e67a * 2 + var_e3b7af42 * 2 + level.var_6e63e659;
    var_e1bef548 = level.zombie_ai_limit - var_4422ef10;
    var_49fa7253 = min(var_49fa7253, var_e1bef548);
    if (var_c3a9e22d === 2 || var_49fa7253 > 0 && var_c3a9e22d === 3) {
        var_49fa7253 /= 2;
        var_49fa7253 = floor(var_49fa7253);
    }
    return var_49fa7253;
}

// Namespace namespace_8e578893
// Params 2, eflags: 0x1 linked
// Checksum 0x30304a59, Offset: 0x19f0
// Size: 0x54
function function_55f114f9(var_c94b52fa, n_duration) {
    self clientfield::set_player_uimodel(var_c94b52fa, 1);
    wait(n_duration);
    self clientfield::set_player_uimodel(var_c94b52fa, 0);
}

// Namespace namespace_8e578893
// Params 2, eflags: 0x1 linked
// Checksum 0xa26a96a4, Offset: 0x1a50
// Size: 0x54
function function_69e0fb83(var_55ce4248, n_duration) {
    self clientfield::set_to_player(var_55ce4248, 1);
    wait(n_duration);
    self clientfield::set_to_player(var_55ce4248, 0);
}

// Namespace namespace_8e578893
// Params 5, eflags: 0x1 linked
// Checksum 0x9eee0471, Offset: 0x1ab0
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

