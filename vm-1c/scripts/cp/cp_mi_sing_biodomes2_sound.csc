#using scripts/codescripts/struct;
#using scripts/shared/audio_shared;

#namespace cp_mi_sing_biodomes2_sound;

// Namespace cp_mi_sing_biodomes2_sound
// Params 0, eflags: 0x0
// Checksum 0x7c39d44d, Offset: 0x110
// Size: 0x2c
function main() {
    thread function_cfda56c6();
    level thread function_625f0409();
}

// Namespace cp_mi_sing_biodomes2_sound
// Params 0, eflags: 0x0
// Checksum 0x776b7969, Offset: 0x148
// Size: 0x12
function function_cfda56c6() {
    level notify(#"no_party");
}

// Namespace cp_mi_sing_biodomes2_sound
// Params 0, eflags: 0x0
// Checksum 0x28ab373f, Offset: 0x168
// Size: 0xbc
function function_625f0409() {
    level waittill(#"sndRamp");
    level thread function_69ca5e40();
    target_origin = (-3972, 759, 4462);
    player = getlocalplayer(0);
    level.var_69a1bedf = 1;
    level thread function_8b5fd6e1(player, target_origin, "mus_diveramper_layer_1", 0, 1, 450, 1200, "mus_diveramper_layer_2", 0, 1, -6, 700, "mus_diveramper_stinger");
}

// Namespace cp_mi_sing_biodomes2_sound
// Params 0, eflags: 0x0
// Checksum 0xabbe80f9, Offset: 0x230
// Size: 0x1c
function function_69ca5e40() {
    level waittill(#"sndRampEnd");
    level.var_69a1bedf = 0;
}

// Namespace cp_mi_sing_biodomes2_sound
// Params 13, eflags: 0x0
// Checksum 0x8e00a520, Offset: 0x258
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

// Namespace cp_mi_sing_biodomes2_sound
// Params 4, eflags: 0x0
// Checksum 0x893e9a89, Offset: 0x668
// Size: 0x114
function function_860d167b(ent1, ent2, id1, id2) {
    level endon(#"sndRampEnd");
    level waittill(#"save_restore");
    ent1 delete();
    ent2 delete();
    id1 = undefined;
    id2 = undefined;
    target_origin = (-3972, 759, 4462);
    wait 2;
    player = getlocalplayer(0);
    if (isdefined(player)) {
        level thread function_8b5fd6e1(player, target_origin, "mus_diveramper_layer_1", 0, 1, -6, 700, "mus_diveramper_layer_2", 0, 1, 50, 300, "mus_diveramper_stinger");
    }
}

