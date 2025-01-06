#using scripts/codescripts/struct;
#using scripts/shared/audio_shared;
#using scripts/shared/clientfield_shared;

#namespace cp_mi_sing_vengeance_sound;

// Namespace cp_mi_sing_vengeance_sound
// Params 0, eflags: 0x0
// Checksum 0x4dfb3166, Offset: 0x238
// Size: 0x7a
function main() {
    clientfield::register("toplayer", "slowmo_duck_active", 1, 2, "int", &function_41d671f5, 0, 0);
    level thread function_dcd7454a();
    level thread function_38ba2136();
    level thread function_4035bef1();
    level thread function_a0c5a719();
}

// Namespace cp_mi_sing_vengeance_sound
// Params 7, eflags: 0x0
// Checksum 0x9bbc2583, Offset: 0x2c0
// Size: 0x72
function function_41d671f5(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval > 0) {
        audio::snd_set_snapshot("cp_mi_sing_vengeance_slowmo");
        return;
    }
    audio::snd_set_snapshot("default");
}

// Namespace cp_mi_sing_vengeance_sound
// Params 0, eflags: 0x0
// Checksum 0xbf351ea6, Offset: 0x340
// Size: 0x5a
function function_dcd7454a() {
    level waittill(#"sndCafe");
    level endon(#"sndCafeOR");
    level thread function_cc438941();
    audio::snd_set_snapshot("cp_vengeance_cafe");
    level waittill(#"sndCafeEnd");
    audio::snd_set_snapshot("default");
}

// Namespace cp_mi_sing_vengeance_sound
// Params 0, eflags: 0x0
// Checksum 0x2517248f, Offset: 0x3a8
// Size: 0x22
function function_cc438941() {
    level waittill(#"sndCafeOR");
    audio::snd_set_snapshot("default");
}

// Namespace cp_mi_sing_vengeance_sound
// Params 0, eflags: 0x0
// Checksum 0x1fdeb4e5, Offset: 0x3d8
// Size: 0x1a2
function function_38ba2136() {
    audio::playloopat("mus_stereo_apartment", (19235, -5438, 328));
    audio::playloopat("amb_tv_static", (19770, -5345, 476));
    audio::playloopat("amb_toilet_loop", (19517, -5609, 483));
    audio::playloopat("amb_light_buzzer", (20871, 1399, -38));
    audio::playloopat("amb_light_buzzer", (21833, -1005, -49));
    audio::playloopat("amb_light_buzzer", (22547, -1539, 351));
    audio::playloopat("amb_light_buzzer", (20765, -3112, 294));
    audio::playloopat("amb_light_buzzer_quiet", (21250, -1740, -9));
    audio::playloopat("amb_subway_light", (20871, 1399, -38));
    audio::playloopat("amb_light_buzzer", (-18962, -19697, -40));
    audio::playloopat("mus_diagetic_ethnic", (21756, 2890, 266));
    audio::playloopat("amb_tv_static", (22486, 8265, -46));
    audio::playloopat("amb_tv_static", (21856, 8521, -47));
}

// Namespace cp_mi_sing_vengeance_sound
// Params 0, eflags: 0x0
// Checksum 0xefc935e5, Offset: 0x588
// Size: 0x91
function function_4035bef1() {
    trigger = getent(0, "siren", "targetname");
    if (!isdefined(trigger)) {
        return;
    }
    while (true) {
        trigger waittill(#"trigger", who);
        if (who isplayer()) {
            playsound(0, "amb_police_siren", (23974, 2768, 631));
            break;
        }
    }
}

// Namespace cp_mi_sing_vengeance_sound
// Params 0, eflags: 0x0
// Checksum 0x5a0ce321, Offset: 0x628
// Size: 0x12
function function_a0c5a719() {
    level thread function_759e7aaa();
}

// Namespace cp_mi_sing_vengeance_sound
// Params 0, eflags: 0x0
// Checksum 0x6635cde2, Offset: 0x648
// Size: 0x92
function function_759e7aaa() {
    level waittill(#"sndLRstart");
    level thread function_60df3271();
    target_origin = (21636, -1368, -28);
    player = getlocalplayer(0);
    level.var_69a1bedf = 1;
    level function_8b5fd6e1(player, target_origin, "mus_assassination_layer_1", 0, 1, -6, 600, "mus_assassination_layer_2", 0, 1, 50, 400, "mus_assassination_stinger");
}

// Namespace cp_mi_sing_vengeance_sound
// Params 0, eflags: 0x0
// Checksum 0xaafac6a7, Offset: 0x6e8
// Size: 0x1f
function function_60df3271() {
    level waittill(#"sndLRstop");
    wait 3;
    level.var_69a1bedf = 0;
    level notify(#"hash_1842ee53");
}

// Namespace cp_mi_sing_vengeance_sound
// Params 13, eflags: 0x0
// Checksum 0x553b12f9, Offset: 0x710
// Size: 0x2ea
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
    }
    if (isdefined(var_61fae9bf)) {
        var_61fae9bf delete();
    }
    if (isdefined(var_f6acc4c)) {
        var_f6acc4c delete();
    }
}

// Namespace cp_mi_sing_vengeance_sound
// Params 4, eflags: 0x0
// Checksum 0xd2eff320, Offset: 0xa08
// Size: 0xca
function function_860d167b(ent1, ent2, id1, id2) {
    level endon(#"hash_61477803");
    level waittill(#"save_restore");
    ent1 delete();
    ent2 delete();
    id1 = undefined;
    id2 = undefined;
    target_origin = (21636, -1368, -28);
    wait 2;
    player = getlocalplayer(0);
    if (isdefined(player)) {
        level thread function_8b5fd6e1(player, target_origin, "mus_assassination_layer_1", 0, 1, -6, 1300, "mus_assassination_layer_2", 0, 1, 50, 700, "mus_assassination_stinger");
    }
}

