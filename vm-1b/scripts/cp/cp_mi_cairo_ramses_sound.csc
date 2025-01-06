#using scripts/codescripts/struct;
#using scripts/shared/array_shared;
#using scripts/shared/audio_shared;

#namespace cp_mi_cairo_ramses_sound;

// Namespace cp_mi_cairo_ramses_sound
// Params 0, eflags: 0x0
// Checksum 0x7b29c3a, Offset: 0x190
// Size: 0x62
function main() {
    level thread function_44f2e4b1();
    level thread function_e127e5d4();
    level thread function_2d42a9f5();
    level thread function_87ff2775();
    level thread function_1a72b50d();
    level thread function_929b684a();
}

// Namespace cp_mi_cairo_ramses_sound
// Params 0, eflags: 0x0
// Checksum 0x799cd5d1, Offset: 0x200
// Size: 0x91
function function_44f2e4b1() {
    trigger = getent(0, "subway_horn", "targetname");
    if (!isdefined(trigger)) {
        return;
    }
    while (true) {
        trigger waittill(#"trigger", who);
        if (who isplayer()) {
            playsound(0, "amb_subway_horn", (7608, 1158, -415));
            break;
        }
    }
}

// Namespace cp_mi_cairo_ramses_sound
// Params 0, eflags: 0x0
// Checksum 0xf82d7b32, Offset: 0x2a0
// Size: 0x89
function function_e127e5d4() {
    trigger = getent(0, "defibrillator", "targetname");
    if (!isdefined(trigger)) {
        return;
    }
    while (true) {
        trigger waittill(#"trigger", who);
        if (who isplayer()) {
            playsound(0, "amb_defibrillator", (7443, -1682, 74));
            break;
        }
    }
}

// Namespace cp_mi_cairo_ramses_sound
// Params 0, eflags: 0x0
// Checksum 0xf836226c, Offset: 0x338
// Size: 0x45
function function_4d86d804() {
    level endon(#"hosp_amb");
    while (true) {
        playsound(0, "amb_hospital_pa", (7068, -1791, 548));
        wait randomintrange(30, 46);
    }
}

// Namespace cp_mi_cairo_ramses_sound
// Params 0, eflags: 0x0
// Checksum 0xbeb024ae, Offset: 0x388
// Size: 0x42
function function_2d42a9f5() {
    level waittill(#"inv");
    audio::snd_set_snapshot("cp_ramses_raps_intro");
    level waittill(#"dro");
    audio::snd_set_snapshot("default");
}

// Namespace cp_mi_cairo_ramses_sound
// Params 0, eflags: 0x0
// Checksum 0x6ce3acf0, Offset: 0x3d8
// Size: 0xa2
function function_87ff2775() {
    if (!isdefined(level.var_b3545b65)) {
        level.var_b3545b65 = spawn(0, (6610, -2082, 66), "script.origin");
    }
    level waittill(#"hash_748aa627");
    level.var_b3545b65 playloopsound("amb_heart_monitor_lp");
    level waittill(#"hosp_amb");
    level.var_b3545b65 stopallloopsounds(0.25);
    wait 1;
    level.var_b3545b65 delete();
}

// Namespace cp_mi_cairo_ramses_sound
// Params 0, eflags: 0x0
// Checksum 0xc892092, Offset: 0x488
// Size: 0x12d
function function_1a72b50d() {
    level endon(#"hash_464a467d");
    var_20089fb6 = (10198, -9557, 755);
    var_fa06254d = (6406, -9437, 894);
    var_d403aae4 = (4810, -8798, 833);
    var_ae01307b = (2412, -7377, 859);
    var_87feb612 = (28, -6302, 777);
    var_61fc3ba9 = (-257, -3146, 658);
    var_3bf9c140 = (334, -300, 620);
    spots = array(var_20089fb6, var_fa06254d, var_d403aae4, var_ae01307b, var_87feb612, var_61fc3ba9, var_3bf9c140);
    level waittill(#"hosp_amb");
    while (true) {
        spot = array::random(spots);
        playsound(0, "exp_dist_heavy", spot);
        wait randomintrange(3, 6);
    }
}

// Namespace cp_mi_cairo_ramses_sound
// Params 0, eflags: 0x0
// Checksum 0xf10cf24f, Offset: 0x5c0
// Size: 0x22
function function_929b684a() {
    level waittill(#"sndLevelEnd");
    audio::snd_set_snapshot("cmn_level_fadeout");
}

