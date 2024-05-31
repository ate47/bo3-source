#using scripts/shared/trigger_shared;
#using scripts/shared/array_shared;
#using scripts/shared/audio_shared;
#using scripts/codescripts/struct;

#namespace namespace_b301a1fd;

// Namespace namespace_b301a1fd
// Params 0, eflags: 0x0
// namespace_b301a1fd<file_0>::function_d290ebfa
// Checksum 0x6ae3134, Offset: 0x210
// Size: 0x52
function main() {
    level thread function_61bfc68f();
    level thread function_2a3f78bf();
    level thread function_7d065157();
    level thread function_c24abe63();
    level thread function_6f4cea1d();
}

// Namespace namespace_b301a1fd
// Params 0, eflags: 0x0
// namespace_b301a1fd<file_0>::function_c24abe63
// Checksum 0x4b9c100f, Offset: 0x270
// Size: 0x36a
function function_c24abe63() {
    level audio::playloopat("amb_emergency_alarm_buzz", (-9406, 40799, 349));
    level audio::playloopat("amb_containment_room", (-11125, 43509, 0));
    level audio::playloopat("evt_vortex", (-31633, 3164, 1373));
    level audio::playloopat("evt_vortex", (749, -20385, 1205));
    level audio::playloopat("evt_vortex", (-22216, -26825, 1650));
    level audio::playloopat("pfx_water_runoff", (-19515, -1656, 1370));
    level audio::playloopat("pfx_water_runoff", (-19459, -16488, 1366));
    level audio::playloopat("pfx_water_runoff", (-19383, -16637, 1351));
    level audio::playloopat("pfx_water_runoff", (-19258, -16779, 1340));
    level audio::playloopat("pfx_water_runoff", (-19424, -16994, 1324));
    level audio::playloopat("pfx_water_runoff", (-18964, -17213, 1324));
    level audio::playloopat("pfx_water_runoff", (-18888, -17421, 1316));
    level audio::playloopat("pfx_water_runoff", (16645, 7162, 58));
    level audio::playloopat("pfx_water_runoff", (16538, 6892, 33));
    level audio::playloopat("pfx_water_runoff", (16316, 6699, 26));
    level audio::playloopat("pfx_water_runoff", (16136, 6514, 18));
    level audio::playloopat("pfx_water_runoff", (15830, 6403, 16));
    level audio::playloopat("pfx_water_runoff", (14665, 6386, 33));
    level audio::playloopat("pfx_water_runoff", (14817, 6217, 13));
    level audio::playloopat("pfx_water_runoff", (14999, 6261, 9));
    level audio::playloopat("pfx_water_runoff", (15149, 6366, 10));
    level audio::playloopat("pfx_water_runoff", (15308, 6212, 15));
    level audio::playloopat("pfx_water_runoff", (15546, 6230, 14));
    level audio::playloopat("pfx_water_runoff", (15843, 6416, 27));
    level audio::playloopat("pfx_water_runoff", (16142, 6516, 23));
    level audio::playloopat("pfx_water_runoff", (16353, 6750, 30));
    level audio::playloopat("amb_blood_waterfall", (-20099, 5149, 271));
}

// Namespace namespace_b301a1fd
// Params 0, eflags: 0x0
// namespace_b301a1fd<file_0>::function_61bfc68f
// Checksum 0xe1c1274c, Offset: 0x5e8
// Size: 0x18a
function function_61bfc68f() {
    level audio::playloopat("amb_broadcast_00", (-9976, 23986, 52));
    level audio::playloopat("amb_broadcast_01", (-9976, 24146, 52));
    level audio::playloopat("amb_emergency_tone", (-9963, 24568, 52));
    level audio::playloopat("amb_broadcast_03", (-9974, 24766, 52));
    level audio::playloopat("amb_broadcast_04", (-9145, 24734, 52));
    level audio::playloopat("amb_broadcast_00", (-8486, 25318, 52));
    level waittill(#"hash_a1eebd3d");
    level audio::stoploopat("amb_broadcast_00", (-9976, 23986, 52));
    level audio::stoploopat("amb_broadcast_01", (-9976, 24146, 52));
    level audio::stoploopat("amb_emergency_tone", (-9963, 24568, 52));
    level audio::stoploopat("amb_broadcast_03", (-9974, 24766, 52));
    level audio::stoploopat("amb_broadcast_04", (-9145, 24734, 52));
    level audio::stoploopat("amb_broadcast_00", (-8486, 3163, 52));
}

// Namespace namespace_b301a1fd
// Params 0, eflags: 0x0
// namespace_b301a1fd<file_0>::function_7d065157
// Checksum 0xd34be4bd, Offset: 0x780
// Size: 0x22
function function_7d065157() {
    level audio::playloopat("evt_waterrise", (-31478, 3175, 1286));
}

// Namespace namespace_b301a1fd
// Params 0, eflags: 0x0
// namespace_b301a1fd<file_0>::function_2a3f78bf
// Checksum 0x42c82578, Offset: 0x7b0
// Size: 0x32
function function_2a3f78bf() {
    level thread function_79e0ed83();
    level thread function_15dcdc5a();
    level thread function_bf9775f1();
}

// Namespace namespace_b301a1fd
// Params 0, eflags: 0x0
// namespace_b301a1fd<file_0>::function_79e0ed83
// Checksum 0xd35ca080, Offset: 0x7f0
// Size: 0x92
function function_79e0ed83() {
    level waittill(#"hash_2aa4d79b");
    audio::playloopat("amb_data_tunnel", (0, 0, 0));
    level thread function_357ee4f7();
    target_origin = (-2152, 3613, 1506);
    player = getlocalplayer(0);
    level.var_69a1bedf = 1;
    level function_8b5fd6e1(player, target_origin, "mus_i_live_data_tunnel", 0, 1, -56, 3600);
}

// Namespace namespace_b301a1fd
// Params 0, eflags: 0x0
// namespace_b301a1fd<file_0>::function_15dcdc5a
// Checksum 0xc4eaef24, Offset: 0x890
// Size: 0x9a
function function_15dcdc5a() {
    level waittill(#"hash_ac8697e8");
    audio::playloopat("amb_data_tunnel", (0, 0, 0));
    level thread function_357ee4f7();
    target_origin = (-74, 3271, 1383);
    player = getlocalplayer(0);
    level.var_69a1bedf = 1;
    level function_8b5fd6e1(player, target_origin, "mus_i_live_data_tunnel", 0.4, 1, -56, 3600);
}

// Namespace namespace_b301a1fd
// Params 0, eflags: 0x0
// namespace_b301a1fd<file_0>::function_bf9775f1
// Checksum 0x897d04ee, Offset: 0x938
// Size: 0x92
function function_bf9775f1() {
    level waittill(#"hash_3b4ac71a");
    audio::playloopat("amb_data_tunnel", (0, 0, 0));
    level thread function_357ee4f7();
    target_origin = (2256, 2635, 1676);
    player = getlocalplayer(0);
    level.var_69a1bedf = 1;
    level function_8b5fd6e1(player, target_origin, "mus_i_live_data_tunnel", 0, 1, -56, 3600);
}

// Namespace namespace_b301a1fd
// Params 0, eflags: 0x0
// namespace_b301a1fd<file_0>::function_357ee4f7
// Checksum 0x1f2cf303, Offset: 0x9d8
// Size: 0x32
function function_357ee4f7() {
    level waittill(#"hash_cbb8610c");
    wait(5);
    audio::stoploopat("amb_data_tunnel", (0, 0, 0));
    level.var_69a1bedf = 0;
}

// Namespace namespace_b301a1fd
// Params 13, eflags: 0x0
// namespace_b301a1fd<file_0>::function_8b5fd6e1
// Checksum 0x277add3d, Offset: 0xa18
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

// Namespace namespace_b301a1fd
// Params 4, eflags: 0x0
// namespace_b301a1fd<file_0>::function_860d167b
// Checksum 0xb15b8c05, Offset: 0xd28
// Size: 0xa2
function function_860d167b(ent1, ent2, id1, id2) {
    level endon(#"hash_61477803");
    level waittill(#"save_restore");
    ent1 delete();
    id1 = undefined;
    target_origin = (2256, 2635, 1676);
    wait(2);
    player = getlocalplayer(0);
    if (isdefined(player)) {
        level thread function_8b5fd6e1(player, target_origin, "mus_i_live_data_tunnel", 0, 1, -56, 3600);
    }
}

// Namespace namespace_b301a1fd
// Params 0, eflags: 0x0
// namespace_b301a1fd<file_0>::function_6f4cea1d
// Checksum 0x35997562, Offset: 0xdd8
// Size: 0x102
function function_6f4cea1d() {
    level waittill(#"hash_166d2243");
    level audio::playloopat("mus_whiterabbit_diagetic", (-10397, 39703, 601));
    level audio::playloopat("mus_whiterabbit_diagetic", (-9550, 39146, 426));
    level audio::playloopat("mus_whiterabbit_diagetic", (-8409, 37890, 585));
    level waittill(#"hash_166d2243");
    wait(5);
    level audio::stoploopat("mus_whiterabbit_diagetic", (-10397, 39703, 601));
    level audio::stoploopat("mus_whiterabbit_diagetic", (-9550, 39146, 426));
    level audio::stoploopat("mus_whiterabbit_diagetic", (-8409, 37890, 585));
}

