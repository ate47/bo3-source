#using scripts/codescripts/struct;
#using scripts/shared/array_shared;
#using scripts/shared/audio_shared;
#using scripts/shared/trigger_shared;

#namespace cp_mi_sing_sgen_sound;

// Namespace cp_mi_sing_sgen_sound
// Params 0, eflags: 0x0
// Checksum 0xede6bdec, Offset: 0x288
// Size: 0xf4
function main() {
    thread function_2c912bd();
    thread function_153b7792();
    thread function_efd49790();
    level thread function_a0c5a719();
    level thread sndScares();
    level thread sndJumpLand();
    level thread function_4e5472a7();
    level thread function_45100b4d();
    level thread function_2b64c5fe();
    level thread function_6c080ebb();
    level thread function_66507a64();
}

// Namespace cp_mi_sing_sgen_sound
// Params 0, eflags: 0x0
// Checksum 0x5a02317c, Offset: 0x388
// Size: 0x12
function function_2c912bd() {
    level notify(#"hash_17d831e1");
}

// Namespace cp_mi_sing_sgen_sound
// Params 0, eflags: 0x0
// Checksum 0x6d2c596c, Offset: 0x3a8
// Size: 0x10
function function_153b7792() {
    level waittill(#"tuwc");
}

// Namespace cp_mi_sing_sgen_sound
// Params 0, eflags: 0x0
// Checksum 0x9036ba8a, Offset: 0x3c0
// Size: 0x10
function function_efd49790() {
    level waittill(#"tuwco");
}

// Namespace cp_mi_sing_sgen_sound
// Params 0, eflags: 0x0
// Checksum 0x2bd07de5, Offset: 0x3d8
// Size: 0x1c
function function_a0c5a719() {
    level thread function_c05308a7();
}

// Namespace cp_mi_sing_sgen_sound
// Params 0, eflags: 0x0
// Checksum 0x947e6694, Offset: 0x400
// Size: 0xbc
function function_c05308a7() {
    level waittill(#"sndRHStart");
    level thread function_61f01886();
    target_origin = (-163, -2934, -5050);
    player = getlocalplayer(0);
    level.var_69a1bedf = 1;
    level function_8b5fd6e1(player, target_origin, "mus_robothall_layer_1", 0, 1, 400, 1600, "mus_robothall_layer_2", 0, 1, -6, 1000, "mus_robothall_end");
}

// Namespace cp_mi_sing_sgen_sound
// Params 0, eflags: 0x0
// Checksum 0x9a798ddc, Offset: 0x4c8
// Size: 0x1c
function function_61f01886() {
    level waittill(#"sndRHStop");
    level.var_69a1bedf = 0;
}

// Namespace cp_mi_sing_sgen_sound
// Params 13, eflags: 0x0
// Checksum 0xb4b7e0ea, Offset: 0x4f0
// Size: 0x404
function function_8b5fd6e1(player, target_origin, alias1, min_vol1, max_vol1, var_937fa2ef, var_ca956561, alias2, min_vol2, max_vol2, var_217833b4, var_f097dfca, var_d8bcfff1) {
    level endon(#"save_restore");
    level endon(#"disconnect");
    player endon(#"death");
    player endon(#"disconnect");
    if (!isdefined(player)) {
        return;
    }
    volume1 = undefined;
    volume2 = undefined;
    if (isdefined(alias1)) {
        var_61fae9bf = spawn(0, (0, 0, 0), "script_origin");
        var_496a5b77 = var_61fae9bf playloopsound(alias1, 3);
        var_14a9459 = min_vol1;
        var_7a3099f7 = max_vol1;
        var_33f29632 = var_937fa2ef;
        var_1e0bf224 = var_ca956561;
        volume1 = 0;
    }
    if (isdefined(alias2)) {
        var_f6acc4c = spawn(0, (0, 0, 0), "script_origin");
        var_59b1545e = var_f6acc4c playloopsound(alias2, 3);
        var_40d74244 = min_vol2;
        var_f63e9846 = max_vol2;
        var_3ab0f833 = var_217833b4;
        var_ddcfce71 = var_f097dfca;
        volume2 = 0;
    }
    level thread function_860d167b(var_61fae9bf, var_f6acc4c, var_496a5b77, var_59b1545e);
    while (isdefined(level.var_69a1bedf) && level.var_69a1bedf) {
        if (!isdefined(player)) {
            return;
        }
        distance = distance(target_origin, player.origin);
        if (isdefined(volume1)) {
            volume1 = audio::scale_speed(var_33f29632, var_1e0bf224, var_14a9459, var_7a3099f7, distance);
            volume1 = abs(1 - volume1);
            setsoundvolume(var_496a5b77, volume1);
        }
        if (isdefined(volume2)) {
            volume2 = audio::scale_speed(var_3ab0f833, var_ddcfce71, var_40d74244, var_f63e9846, distance);
            volume2 = abs(1 - volume2);
            setsoundvolume(var_59b1545e, volume2);
        }
        wait 0.1;
    }
    level notify(#"hash_61477803");
    if (isdefined(var_d8bcfff1)) {
        playsound(0, var_d8bcfff1, (0, 0, 0));
    }
    if (isdefined(var_61fae9bf)) {
        var_61fae9bf delete();
    }
    if (isdefined(var_f6acc4c)) {
        var_f6acc4c delete();
    }
}

// Namespace cp_mi_sing_sgen_sound
// Params 4, eflags: 0x0
// Checksum 0x39178e6b, Offset: 0x900
// Size: 0x114
function function_860d167b(ent1, ent2, id1, id2) {
    level endon(#"hash_61477803");
    level waittill(#"save_restore");
    ent1 delete();
    ent2 delete();
    id1 = undefined;
    id2 = undefined;
    target_origin = (-163, -2934, -5050);
    wait 2;
    player = getlocalplayer(0);
    if (isdefined(player)) {
        level thread function_8b5fd6e1(player, target_origin, "mus_robothall_layer_1", 0, 1, 400, 1600, "mus_robothall_layer_2", 0, 1, -6, 1000, "mus_robothall_end");
    }
}

// Namespace cp_mi_sing_sgen_sound
// Params 0, eflags: 0x0
// Checksum 0x1f8a8fcf, Offset: 0xa20
// Size: 0x74
function sndScares() {
    var_5f6e94d0 = getentarray(0, "sndScares", "targetname");
    if (!isdefined(var_5f6e94d0) || var_5f6e94d0.size <= 0) {
        return;
    }
    array::thread_all(var_5f6e94d0, &function_bccbeb90);
}

// Namespace cp_mi_sing_sgen_sound
// Params 0, eflags: 0x0
// Checksum 0x685fcf8d, Offset: 0xaa0
// Size: 0x9c
function function_bccbeb90() {
    target = struct::get(self.target, "targetname");
    while (true) {
        self waittill(#"trigger", who);
        if (who isplayer()) {
            playsound(0, self.script_sound, target.origin);
            break;
        }
    }
}

// Namespace cp_mi_sing_sgen_sound
// Params 0, eflags: 0x0
// Checksum 0xa66e42b7, Offset: 0xb48
// Size: 0x74
function sndJumpLand() {
    var_b9230b42 = getentarray(0, "sndJumpLand", "targetname");
    if (!isdefined(var_b9230b42) || var_b9230b42.size <= 0) {
        return;
    }
    array::thread_all(var_b9230b42, &function_c2d4afb7);
}

// Namespace cp_mi_sing_sgen_sound
// Params 0, eflags: 0x0
// Checksum 0xdd3b3e19, Offset: 0xbc8
// Size: 0x50
function function_c2d4afb7() {
    while (true) {
        self waittill(#"trigger", who);
        self thread trigger::function_thread(who, &function_c2f42d4e);
    }
}

// Namespace cp_mi_sing_sgen_sound
// Params 1, eflags: 0x0
// Checksum 0xe964f39a, Offset: 0xc20
// Size: 0x34
function function_c2f42d4e(ent) {
    playsound(0, self.script_sound, ent.origin);
}

// Namespace cp_mi_sing_sgen_sound
// Params 0, eflags: 0x0
// Checksum 0xa45db3b0, Offset: 0xc60
// Size: 0x6c
function function_4e5472a7() {
    level waittill(#"escp");
    wait 3;
    audio::playloopat("evt_escape_walla", (20225, 2651, -6631));
    level waittill(#"escps");
    audio::stoploopat("evt_escape_walla", (20225, 2651, -6631));
}

// Namespace cp_mi_sing_sgen_sound
// Params 0, eflags: 0x0
// Checksum 0x9d5eceaa, Offset: 0xcd8
// Size: 0x98
function function_45100b4d() {
    level endon(#"kw");
    level waittill(#"sw");
    while (true) {
        playsound(0, "vox_walla_call", (-1045, -4195, 564));
        wait 4;
        playsound(0, "vox_walla_call_response", (621, -5090, 376));
        wait randomintrange(2, 7);
    }
}

// Namespace cp_mi_sing_sgen_sound
// Params 0, eflags: 0x0
// Checksum 0x1f8d82b4, Offset: 0xd78
// Size: 0x3c
function function_2b64c5fe() {
    level waittill(#"kw");
    playsound(0, "vox_walla_battlecry", (-138, -4871, 311));
}

// Namespace cp_mi_sing_sgen_sound
// Params 0, eflags: 0x0
// Checksum 0x265ded44, Offset: 0xdc0
// Size: 0x1d4
function function_6c080ebb() {
    level waittill(#"escp");
    level thread function_9d912a9d(20210, 4156, -6727);
    level thread function_9d912a9d(20369, 3460, -6700);
    level thread function_9d912a9d(20369, 3460, -6700);
    level thread function_9d912a9d(20176, 2461, -6547);
    level thread function_9d912a9d(21068, 2494, -6526);
    level thread function_9d912a9d(22036, 2473, -6543);
    level thread function_9d912a9d(23219, 2550, -6545);
    level thread function_9d912a9d(23132, 1542, -6547);
    level thread function_9d912a9d(23132, 1542, -6547);
    level thread function_9d912a9d(24602, 1593, -6243);
    level thread function_9d912a9d(25098, 1888, -6524);
    level thread function_9d912a9d(25120, 1258, -6557);
    level thread function_9d912a9d(25522, 1821, -6447);
    level thread function_9d912a9d(25516, 1302, -6511);
}

// Namespace cp_mi_sing_sgen_sound
// Params 3, eflags: 0x0
// Checksum 0x12c8fdab, Offset: 0xfa0
// Size: 0x44
function function_9d912a9d(pos1, pos2, pos3) {
    audio::playloopat("evt_escape_alarm", (pos1, pos2, pos3));
}

// Namespace cp_mi_sing_sgen_sound
// Params 7, eflags: 0x0
// Checksum 0xb3c2c607, Offset: 0xff0
// Size: 0xd0
function sndLabWalla(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval == 1) {
        soundloopemitter("amb_lab_walla", (1240, 285, -1203));
        return;
    }
    soundstoploopemitter("amb_lab_walla", (1240, 285, -1203));
    playsound(0, "amb_lab_walla_stop", (1240, 285, -1203));
}

// Namespace cp_mi_sing_sgen_sound
// Params 0, eflags: 0x0
// Checksum 0x7059daef, Offset: 0x10c8
// Size: 0x3c4
function function_66507a64() {
    audio::playloopat("amb_glitchy_screens", (3275, -2730, -4743));
    audio::playloopat("amb_glitchy_screens", (-24, -939, -4529));
    audio::playloopat("amb_glitchy_screens", (3952, -1962, -4781));
    audio::playloopat("amb_flourescent_light_quiet", (1649, -999, -4547));
    audio::playloopat("amb_flourescent_light_quiet", (-47, 53, -4409));
    audio::playloopat("amb_billboard_glitch_loop", (1100, -954, 325));
    audio::playloopat("amb_billboard_glitch_loop", (-505, 1787, 4005));
    audio::playloopat("amb_billboard_glitch_loop", (-25, -1367, 424));
    audio::playloopat("amb_billboard_glitch_loop", (398, -2739, 399));
    audio::playloopat("amb_computer", (4476, -2321, -4913));
    audio::playloopat("amb_computer", (4492, -2606, -4914));
    audio::playloopat("amb_air_vent", (4214, -2387, -4753));
    audio::playloopat("amb_air_vent", (3623, -2391, -4781));
    audio::playloopat("amb_quiet_monkey_machine", (4200, -2553, -4755));
    audio::playloopat("amb_quiet_monkey_machine", (3691, -2553, -4757));
    audio::playloopat("amb_quiet_monkey_machine", (3663, -2205, -4758));
    audio::playloopat("amb_quiet_monkey_machine", (4121, -2205, -4759));
    audio::playloopat("pfx_steam_hollow", (1487, 1043, -2042));
    audio::playloopat("pfx_steam_hollow", (1903, 1280, -1871));
    audio::playloopat("amb_flourescent_light_quiet", (1678, 416, -1813));
    audio::playloopat("amb_flourescent_light_quiet", (2326, -2166, -4608));
    audio::playloopat("amb_air_vent", (2265, -1672, -4526));
    audio::playloopat("amb_air_vent_rattle", (2265, -1672, -4526));
    audio::playloopat("amb_flourescent_light_quiet", (2652, -2736, -4656));
}

