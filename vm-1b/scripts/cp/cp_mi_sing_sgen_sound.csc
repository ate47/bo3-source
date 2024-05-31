#using scripts/shared/trigger_shared;
#using scripts/shared/array_shared;
#using scripts/shared/audio_shared;
#using scripts/codescripts/struct;

#namespace namespace_172c963;

// Namespace namespace_172c963
// Params 0, eflags: 0x0
// namespace_172c963<file_0>::function_d290ebfa
// Checksum 0xdeac2539, Offset: 0x288
// Size: 0xb2
function main() {
    thread function_2c912bd();
    thread function_153b7792();
    thread function_efd49790();
    level thread function_a0c5a719();
    level thread function_a768b615();
    level thread function_75bb865();
    level thread function_4e5472a7();
    level thread function_45100b4d();
    level thread function_2b64c5fe();
    level thread function_6c080ebb();
    level thread function_66507a64();
}

// Namespace namespace_172c963
// Params 0, eflags: 0x0
// namespace_172c963<file_0>::function_2c912bd
// Checksum 0x806d6078, Offset: 0x348
// Size: 0xb
function function_2c912bd() {
    level notify(#"hash_17d831e1");
}

// Namespace namespace_172c963
// Params 0, eflags: 0x0
// namespace_172c963<file_0>::function_153b7792
// Checksum 0x2be97c66, Offset: 0x360
// Size: 0xc
function function_153b7792() {
    level waittill(#"hash_cf6daea2");
}

// Namespace namespace_172c963
// Params 0, eflags: 0x0
// namespace_172c963<file_0>::function_efd49790
// Checksum 0xbb54dc26, Offset: 0x378
// Size: 0xc
function function_efd49790() {
    level waittill(#"hash_de9f3fa1");
}

// Namespace namespace_172c963
// Params 0, eflags: 0x0
// namespace_172c963<file_0>::function_a0c5a719
// Checksum 0xa36dfdf1, Offset: 0x390
// Size: 0x12
function function_a0c5a719() {
    level thread function_c05308a7();
}

// Namespace namespace_172c963
// Params 0, eflags: 0x0
// namespace_172c963<file_0>::function_c05308a7
// Checksum 0x1747a8f1, Offset: 0x3b0
// Size: 0x92
function function_c05308a7() {
    level waittill(#"hash_ad7eaa98");
    level thread function_61f01886();
    target_origin = (-163, -2934, -5050);
    player = getlocalplayer(0);
    level.var_69a1bedf = 1;
    level function_8b5fd6e1(player, target_origin, "mus_robothall_layer_1", 0, 1, 400, 1600, "mus_robothall_layer_2", 0, 1, -6, 1000, "mus_robothall_end");
}

// Namespace namespace_172c963
// Params 0, eflags: 0x0
// namespace_172c963<file_0>::function_61f01886
// Checksum 0xf051a564, Offset: 0x450
// Size: 0x16
function function_61f01886() {
    level waittill(#"hash_b3e68f04");
    level.var_69a1bedf = 0;
}

// Namespace namespace_172c963
// Params 13, eflags: 0x0
// namespace_172c963<file_0>::function_8b5fd6e1
// Checksum 0x72b6088e, Offset: 0x470
// Size: 0x302
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
        wait(0.1);
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

// Namespace namespace_172c963
// Params 4, eflags: 0x0
// namespace_172c963<file_0>::function_860d167b
// Checksum 0x81e3f4d1, Offset: 0x780
// Size: 0xca
function function_860d167b(ent1, ent2, id1, id2) {
    level endon(#"hash_61477803");
    level waittill(#"save_restore");
    ent1 delete();
    ent2 delete();
    id1 = undefined;
    id2 = undefined;
    target_origin = (-163, -2934, -5050);
    wait(2);
    player = getlocalplayer(0);
    if (isdefined(player)) {
        level thread function_8b5fd6e1(player, target_origin, "mus_robothall_layer_1", 0, 1, 400, 1600, "mus_robothall_layer_2", 0, 1, -6, 1000, "mus_robothall_end");
    }
}

// Namespace namespace_172c963
// Params 0, eflags: 0x0
// namespace_172c963<file_0>::function_a768b615
// Checksum 0xb94d0f01, Offset: 0x858
// Size: 0x5a
function function_a768b615() {
    var_5f6e94d0 = getentarray(0, "sndScares", "targetname");
    if (!isdefined(var_5f6e94d0) || var_5f6e94d0.size <= 0) {
        return;
    }
    array::thread_all(var_5f6e94d0, &function_bccbeb90);
}

// Namespace namespace_172c963
// Params 0, eflags: 0x0
// namespace_172c963<file_0>::function_bccbeb90
// Checksum 0x55e5dc51, Offset: 0x8c0
// Size: 0x89
function function_bccbeb90() {
    target = struct::get(self.target, "targetname");
    while (true) {
        who = self waittill(#"trigger");
        if (who isplayer()) {
            playsound(0, self.script_sound, target.origin);
            break;
        }
    }
}

// Namespace namespace_172c963
// Params 0, eflags: 0x0
// namespace_172c963<file_0>::function_75bb865
// Checksum 0xba095936, Offset: 0x958
// Size: 0x5a
function function_75bb865() {
    var_b9230b42 = getentarray(0, "sndJumpLand", "targetname");
    if (!isdefined(var_b9230b42) || var_b9230b42.size <= 0) {
        return;
    }
    array::thread_all(var_b9230b42, &function_c2d4afb7);
}

// Namespace namespace_172c963
// Params 0, eflags: 0x0
// namespace_172c963<file_0>::function_c2d4afb7
// Checksum 0xdb9874d, Offset: 0x9c0
// Size: 0x3d
function function_c2d4afb7() {
    while (true) {
        who = self waittill(#"trigger");
        self thread trigger::function_thread(who, &function_c2f42d4e);
    }
}

// Namespace namespace_172c963
// Params 1, eflags: 0x0
// namespace_172c963<file_0>::function_c2f42d4e
// Checksum 0x40b37bc3, Offset: 0xa08
// Size: 0x2a
function function_c2f42d4e(ent) {
    playsound(0, self.script_sound, ent.origin);
}

// Namespace namespace_172c963
// Params 0, eflags: 0x0
// namespace_172c963<file_0>::function_4e5472a7
// Checksum 0xaaeb3418, Offset: 0xa40
// Size: 0x62
function function_4e5472a7() {
    level waittill(#"hash_fc92edec");
    wait(3);
    audio::playloopat("evt_escape_walla", (20225, 2651, -6631));
    level waittill(#"hash_188db8ef");
    audio::stoploopat("evt_escape_walla", (20225, 2651, -6631));
}

// Namespace namespace_172c963
// Params 0, eflags: 0x0
// namespace_172c963<file_0>::function_45100b4d
// Checksum 0xd0345458, Offset: 0xab0
// Size: 0x75
function function_45100b4d() {
    level endon(#"hash_a8bf0d73");
    level waittill(#"sw");
    while (true) {
        playsound(0, "vox_walla_call", (-1045, -4195, 564));
        wait(4);
        playsound(0, "vox_walla_call_response", (621, -5090, 376));
        wait(randomintrange(2, 7));
    }
}

// Namespace namespace_172c963
// Params 0, eflags: 0x0
// namespace_172c963<file_0>::function_2b64c5fe
// Checksum 0xe79bbdf9, Offset: 0xb30
// Size: 0x2a
function function_2b64c5fe() {
    level waittill(#"hash_a8bf0d73");
    playsound(0, "vox_walla_battlecry", (-138, -4871, 311));
}

// Namespace namespace_172c963
// Params 0, eflags: 0x0
// namespace_172c963<file_0>::function_6c080ebb
// Checksum 0x358baf09, Offset: 0xb68
// Size: 0x1ca
function function_6c080ebb() {
    level waittill(#"hash_fc92edec");
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

// Namespace namespace_172c963
// Params 3, eflags: 0x0
// namespace_172c963<file_0>::function_9d912a9d
// Checksum 0xb223f8fd, Offset: 0xd40
// Size: 0x3a
function function_9d912a9d(pos1, pos2, pos3) {
    audio::playloopat("evt_escape_alarm", (pos1, pos2, pos3));
}

// Namespace namespace_172c963
// Params 7, eflags: 0x0
// namespace_172c963<file_0>::function_698dfbe4
// Checksum 0x19c947f0, Offset: 0xd88
// Size: 0xad
function function_698dfbe4(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval == 1) {
        soundloopemitter("amb_lab_walla", (1240, 285, -1203));
        return;
    }
    soundstoploopemitter("amb_lab_walla", (1240, 285, -1203));
    playsound(0, "amb_lab_walla_stop", (1240, 285, -1203));
}

// Namespace namespace_172c963
// Params 0, eflags: 0x0
// namespace_172c963<file_0>::function_66507a64
// Checksum 0xae496c0e, Offset: 0xe40
// Size: 0x302
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

