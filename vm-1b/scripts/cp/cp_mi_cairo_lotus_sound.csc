#using scripts/codescripts/struct;
#using scripts/shared/array_shared;
#using scripts/shared/audio_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/trigger_shared;

#namespace cp_mi_cairo_lotus_sound;

// Namespace cp_mi_cairo_lotus_sound
// Params 0, eflags: 0x0
// Checksum 0xfbe1ac5d, Offset: 0x228
// Size: 0x7a
function main() {
    level thread function_a0c5a719();
    level thread function_7bcb0782();
    clientfield::register("world", "sndHakimPaVox", 1, 3, "int", &sndHakimPaVox, 0, 0);
    level thread function_4904d6ff();
    level thread function_1a66f9f3();
}

// Namespace cp_mi_cairo_lotus_sound
// Params 0, eflags: 0x0
// Checksum 0xcc21b5f5, Offset: 0x2b0
// Size: 0x12
function function_a0c5a719() {
    level thread function_759e7aaa();
}

// Namespace cp_mi_cairo_lotus_sound
// Params 0, eflags: 0x0
// Checksum 0x976a9ce1, Offset: 0x2d0
// Size: 0x92
function function_759e7aaa() {
    level waittill(#"sndLRstart");
    level thread function_60df3271();
    target_origin = (-5922, -70, 1813);
    player = getlocalplayer(0);
    level.var_69a1bedf = 1;
    level function_8b5fd6e1(player, target_origin, "mus_assassination_layer_1", 0, 1, -6, 1300, "mus_assassination_layer_2", 0, 1, 50, 700, "mus_assassination_stinger");
}

// Namespace cp_mi_cairo_lotus_sound
// Params 0, eflags: 0x0
// Checksum 0xb915a850, Offset: 0x370
// Size: 0x1f
function function_60df3271() {
    level waittill(#"sndLRstop");
    wait 3;
    level.var_69a1bedf = 0;
    level notify(#"hash_1842ee53");
}

// Namespace cp_mi_cairo_lotus_sound
// Params 13, eflags: 0x0
// Checksum 0xae09696d, Offset: 0x398
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

// Namespace cp_mi_cairo_lotus_sound
// Params 4, eflags: 0x0
// Checksum 0xd800108c, Offset: 0x6a8
// Size: 0xca
function function_860d167b(ent1, ent2, id1, id2) {
    level endon(#"hash_61477803");
    level waittill(#"save_restore");
    ent1 delete();
    ent2 delete();
    id1 = undefined;
    id2 = undefined;
    target_origin = (-5922, -70, 1813);
    wait 2;
    player = getlocalplayer(0);
    if (isdefined(player)) {
        level thread function_8b5fd6e1(player, target_origin, "mus_assassination_layer_1", 0, 1, -6, 1300, "mus_assassination_layer_2", 0, 1, 50, 700, "mus_assassination_stinger");
    }
}

// Namespace cp_mi_cairo_lotus_sound
// Params 0, eflags: 0x0
// Checksum 0xfe0ce7ed, Offset: 0x780
// Size: 0x62
function function_4904d6ff() {
    level.var_27ec4154 = array("_000_haki", "_001_haki", "_002_haki", "_003_haki");
    level.var_6d0444d4 = struct::get_array("sndHakimPaVox", "targetname");
}

// Namespace cp_mi_cairo_lotus_sound
// Params 7, eflags: 0x0
// Checksum 0x90e5a6ad, Offset: 0x7f0
// Size: 0xcb
function sndHakimPaVox(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
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
            wait 0.016;
        }
    }
}

// Namespace cp_mi_cairo_lotus_sound
// Params 2, eflags: 0x0
// Checksum 0x2de57bef, Offset: 0x8c8
// Size: 0xa2
function function_372f5bfa(location, newval) {
    level endon(#"hash_1842ee53");
    if (location.script_string == "large") {
        wait 0.05;
    }
    alias = "vox_lot1_hakim_pa_" + location.script_string + level.var_27ec4154[newval - 1];
    soundid = playsound(0, alias, location.origin);
    level waittill(#"hash_4e3eaac8");
    stopsound(soundid);
}

// Namespace cp_mi_cairo_lotus_sound
// Params 0, eflags: 0x0
// Checksum 0x68180eee, Offset: 0x978
// Size: 0x7a
function function_7bcb0782() {
    if (!isdefined(level.var_b1373a38)) {
        level.var_b1373a38 = spawn(0, (-6820, -5, 1992), "script.origin");
    }
    level waittill(#"hash_b1373a38");
    level.var_b1373a38 playsound(0, "evt_crowd_swell");
    wait 5;
    level.var_b1373a38 delete();
}

// Namespace cp_mi_cairo_lotus_sound
// Params 0, eflags: 0x0
// Checksum 0xc4973764, Offset: 0xa00
// Size: 0x8a
function function_1a66f9f3() {
    level waittill(#"sndRampair");
    level thread function_e675c6f2();
    target_origin = (-8944, 1407, 4186);
    player = getlocalplayer(0);
    level.var_69a1bedf = 1;
    level thread function_a89a73f3(player, target_origin, "evt_air_scare_layer_1", 0, 1, 100, 600, "evt_air_scare_layer_2", 0, 1, -106, 300);
}

// Namespace cp_mi_cairo_lotus_sound
// Params 0, eflags: 0x0
// Checksum 0xface579a, Offset: 0xa98
// Size: 0x16
function function_e675c6f2() {
    level waittill(#"sndRampEnd");
    level.var_69a1bedf = 0;
}

// Namespace cp_mi_cairo_lotus_sound
// Params 13, eflags: 0x0
// Checksum 0x56aa321e, Offset: 0xab8
// Size: 0x302
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

// Namespace cp_mi_cairo_lotus_sound
// Params 4, eflags: 0x0
// Checksum 0xa69aea6b, Offset: 0xdc8
// Size: 0xc2
function function_dc4a5405(ent1, ent2, id1, id2) {
    level endon(#"sndRampEnd");
    level waittill(#"save_restore");
    ent1 delete();
    ent2 delete();
    id1 = undefined;
    id2 = undefined;
    target_origin = (-8944, 1407, 4186);
    wait 2;
    player = getlocalplayer(0);
    if (isdefined(player)) {
        level thread function_a89a73f3(player, target_origin, "evt_air_scare_layer_1", 0, 1, 100, 600, "evt_air_scare_layer_2", 0, 1, -106, 300);
    }
}

