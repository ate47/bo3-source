#using scripts/shared/array_shared;
#using scripts/shared/audio_shared;
#using scripts/codescripts/struct;

#namespace namespace_39972b4;

// Namespace namespace_39972b4
// Params 0, eflags: 0x0
// Checksum 0xb91f742b, Offset: 0x190
// Size: 0x94
function main() {
    level thread function_44f2e4b1();
    level thread function_e127e5d4();
    level thread function_2d42a9f5();
    level thread function_87ff2775();
    level thread function_1a72b50d();
    level thread function_929b684a();
}

// Namespace namespace_39972b4
// Params 0, eflags: 0x0
// Checksum 0x6bd6aad4, Offset: 0x230
// Size: 0xb4
function function_44f2e4b1() {
    trigger = getent(0, "subway_horn", "targetname");
    if (!isdefined(trigger)) {
        return;
    }
    while (true) {
        who = trigger waittill(#"trigger");
        if (who isplayer()) {
            playsound(0, "amb_subway_horn", (7608, 1158, -415));
            break;
        }
    }
}

// Namespace namespace_39972b4
// Params 0, eflags: 0x0
// Checksum 0x41f4937d, Offset: 0x2f0
// Size: 0xb4
function function_e127e5d4() {
    trigger = getent(0, "defibrillator", "targetname");
    if (!isdefined(trigger)) {
        return;
    }
    while (true) {
        who = trigger waittill(#"trigger");
        if (who isplayer()) {
            playsound(0, "amb_defibrillator", (7443, -1682, 74));
            break;
        }
    }
}

// Namespace namespace_39972b4
// Params 0, eflags: 0x0
// Checksum 0x33fdc3d4, Offset: 0x3b0
// Size: 0x60
function function_4d86d804() {
    level endon(#"hash_be144962");
    while (true) {
        playsound(0, "amb_hospital_pa", (7068, -1791, 548));
        wait(randomintrange(30, 46));
    }
}

// Namespace namespace_39972b4
// Params 0, eflags: 0x0
// Checksum 0x35118413, Offset: 0x418
// Size: 0x54
function function_2d42a9f5() {
    level waittill(#"hash_57706e72");
    audio::snd_set_snapshot("cp_ramses_raps_intro");
    level waittill(#"hash_f67ed9a6");
    audio::snd_set_snapshot("default");
}

// Namespace namespace_39972b4
// Params 0, eflags: 0x0
// Checksum 0xc6106376, Offset: 0x478
// Size: 0xc4
function function_87ff2775() {
    if (!isdefined(level.var_b3545b65)) {
        level.var_b3545b65 = spawn(0, (6610, -2082, 66), "script.origin");
    }
    level waittill(#"hash_748aa627");
    level.var_b3545b65 playloopsound("amb_heart_monitor_lp");
    level waittill(#"hash_be144962");
    level.var_b3545b65 stopallloopsounds(0.25);
    wait(1);
    level.var_b3545b65 delete();
}

// Namespace namespace_39972b4
// Params 0, eflags: 0x0
// Checksum 0x2cb02fab, Offset: 0x548
// Size: 0x188
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
    level waittill(#"hash_be144962");
    while (true) {
        spot = array::random(spots);
        playsound(0, "exp_dist_heavy", spot);
        wait(randomintrange(3, 6));
    }
}

// Namespace namespace_39972b4
// Params 0, eflags: 0x0
// Checksum 0xf04aabce, Offset: 0x6d8
// Size: 0x2c
function function_929b684a() {
    level waittill(#"hash_6c9d5d83");
    audio::snd_set_snapshot("cmn_level_fadeout");
}

