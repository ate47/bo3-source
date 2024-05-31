#using scripts/shared/clientfield_shared;
#using scripts/shared/trigger_shared;
#using scripts/shared/array_shared;
#using scripts/shared/audio_shared;
#using scripts/codescripts/struct;

#namespace namespace_9750c824;

// Namespace namespace_9750c824
// Params 0, eflags: 0x1 linked
// namespace_9750c824<file_0>::function_d290ebfa
// Checksum 0x6eda387, Offset: 0x228
// Size: 0xac
function main() {
    level thread function_a0c5a719();
    level thread function_7bcb0782();
    clientfield::register("world", "sndHakimPaVox", 1, 3, "int", &function_5e9a8778, 0, 0);
    level thread function_4904d6ff();
    level thread function_1a66f9f3();
}

// Namespace namespace_9750c824
// Params 0, eflags: 0x1 linked
// namespace_9750c824<file_0>::function_a0c5a719
// Checksum 0x58d882c3, Offset: 0x2e0
// Size: 0x1c
function function_a0c5a719() {
    level thread function_759e7aaa();
}

// Namespace namespace_9750c824
// Params 0, eflags: 0x1 linked
// namespace_9750c824<file_0>::function_759e7aaa
// Checksum 0x435f7f81, Offset: 0x308
// Size: 0xbc
function function_759e7aaa() {
    level waittill(#"hash_51e4b2c0");
    level thread function_60df3271();
    target_origin = (-5922, -70, 1813);
    player = getlocalplayer(0);
    level.var_69a1bedf = 1;
    level function_8b5fd6e1(player, target_origin, "mus_assassination_layer_1", 0, 1, -6, 1300, "mus_assassination_layer_2", 0, 1, 50, 700, "mus_assassination_stinger");
}

// Namespace namespace_9750c824
// Params 0, eflags: 0x1 linked
// namespace_9750c824<file_0>::function_60df3271
// Checksum 0xd9985dc2, Offset: 0x3d0
// Size: 0x2e
function function_60df3271() {
    level waittill(#"hash_8409b4c");
    wait(3);
    level.var_69a1bedf = 0;
    level notify(#"hash_1842ee53");
}

// Namespace namespace_9750c824
// Params 13, eflags: 0x1 linked
// namespace_9750c824<file_0>::function_8b5fd6e1
// Checksum 0x7085026b, Offset: 0x408
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

// Namespace namespace_9750c824
// Params 4, eflags: 0x1 linked
// namespace_9750c824<file_0>::function_860d167b
// Checksum 0x26961e9, Offset: 0x818
// Size: 0x114
function function_860d167b(ent1, ent2, id1, id2) {
    level endon(#"hash_61477803");
    level waittill(#"save_restore");
    ent1 delete();
    ent2 delete();
    id1 = undefined;
    id2 = undefined;
    target_origin = (-5922, -70, 1813);
    wait(2);
    player = getlocalplayer(0);
    if (isdefined(player)) {
        level thread function_8b5fd6e1(player, target_origin, "mus_assassination_layer_1", 0, 1, -6, 1300, "mus_assassination_layer_2", 0, 1, 50, 700, "mus_assassination_stinger");
    }
}

// Namespace namespace_9750c824
// Params 0, eflags: 0x1 linked
// namespace_9750c824<file_0>::function_4904d6ff
// Checksum 0x306ffc1b, Offset: 0x938
// Size: 0x64
function function_4904d6ff() {
    level.var_27ec4154 = array("_000_haki", "_001_haki", "_002_haki", "_003_haki");
    level.var_6d0444d4 = struct::get_array("sndHakimPaVox", "targetname");
}

// Namespace namespace_9750c824
// Params 7, eflags: 0x1 linked
// namespace_9750c824<file_0>::function_5e9a8778
// Checksum 0x24c7455a, Offset: 0x9a8
// Size: 0x10a
function function_5e9a8778(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (!isdefined(level.var_6d0444d4)) {
        return;
    }
    if (newval) {
        if (newval == 5) {
            level notify(#"hash_4e3eaac8");
            return;
        }
        foreach (location in level.var_6d0444d4) {
            level thread function_372f5bfa(location, newval);
            wait(0.016);
        }
    }
}

// Namespace namespace_9750c824
// Params 2, eflags: 0x1 linked
// namespace_9750c824<file_0>::function_372f5bfa
// Checksum 0x31c1acea, Offset: 0xac0
// Size: 0xcc
function function_372f5bfa(location, newval) {
    level endon(#"hash_1842ee53");
    if (location.script_string == "large") {
        wait(0.05);
    }
    alias = "vox_lot1_hakim_pa_" + location.script_string + level.var_27ec4154[newval - 1];
    soundid = playsound(0, alias, location.origin);
    level waittill(#"hash_4e3eaac8");
    stopsound(soundid);
}

// Namespace namespace_9750c824
// Params 0, eflags: 0x1 linked
// namespace_9750c824<file_0>::function_7bcb0782
// Checksum 0x37c1431c, Offset: 0xb98
// Size: 0x94
function function_7bcb0782() {
    if (!isdefined(level.var_b1373a38)) {
        level.var_b1373a38 = spawn(0, (-6820, -5, 1992), "script.origin");
    }
    level waittill(#"hash_b1373a38");
    level.var_b1373a38 playsound(0, "evt_crowd_swell");
    wait(5);
    level.var_b1373a38 delete();
}

// Namespace namespace_9750c824
// Params 0, eflags: 0x1 linked
// namespace_9750c824<file_0>::function_1a66f9f3
// Checksum 0x9555f13, Offset: 0xc38
// Size: 0xb4
function function_1a66f9f3() {
    level waittill(#"hash_52e37ee2");
    level thread function_e675c6f2();
    target_origin = (-8944, 1407, 4186);
    player = getlocalplayer(0);
    level.var_69a1bedf = 1;
    level thread function_a89a73f3(player, target_origin, "evt_air_scare_layer_1", 0, 1, 100, 600, "evt_air_scare_layer_2", 0, 1, -106, 300);
}

// Namespace namespace_9750c824
// Params 0, eflags: 0x1 linked
// namespace_9750c824<file_0>::function_e675c6f2
// Checksum 0xbc6199ce, Offset: 0xcf8
// Size: 0x1c
function function_e675c6f2() {
    level waittill(#"hash_a38d24cd");
    level.var_69a1bedf = 0;
}

// Namespace namespace_9750c824
// Params 13, eflags: 0x1 linked
// namespace_9750c824<file_0>::function_a89a73f3
// Checksum 0xa4a0a04a, Offset: 0xd20
// Size: 0x404
function function_a89a73f3(player, target_origin, alias1, min_vol1, max_vol1, var_937fa2ef, var_ca956561, alias2, min_vol2, max_vol2, var_217833b4, var_f097dfca, var_d8bcfff1) {
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
    level thread function_dc4a5405(var_61fae9bf, var_f6acc4c, var_496a5b77, var_59b1545e);
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

// Namespace namespace_9750c824
// Params 4, eflags: 0x1 linked
// namespace_9750c824<file_0>::function_dc4a5405
// Checksum 0x36c6cdba, Offset: 0x1130
// Size: 0x114
function function_dc4a5405(ent1, ent2, id1, id2) {
    level endon(#"hash_a38d24cd");
    level waittill(#"save_restore");
    ent1 delete();
    ent2 delete();
    id1 = undefined;
    id2 = undefined;
    target_origin = (-8944, 1407, 4186);
    wait(2);
    player = getlocalplayer(0);
    if (isdefined(player)) {
        level thread function_a89a73f3(player, target_origin, "evt_air_scare_layer_1", 0, 1, 100, 600, "evt_air_scare_layer_2", 0, 1, -106, 300);
    }
}

