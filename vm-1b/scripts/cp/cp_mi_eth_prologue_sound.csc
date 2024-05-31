#using scripts/shared/audio_shared;
#using scripts/codescripts/struct;

#namespace namespace_7685657b;

// Namespace namespace_7685657b
// Params 0, eflags: 0x0
// namespace_7685657b<file_0>::function_d290ebfa
// Checksum 0x638f2517, Offset: 0x218
// Size: 0xa2
function main() {
    level thread function_aca4761();
    level thread function_669e0ca5();
    level thread function_6ce0e63();
    level thread function_35acdae6();
    level thread function_9806d032();
    level thread function_c943c5e5();
    level thread function_4b8b96fe();
    level thread function_7ec0e1ae();
    level thread function_eb4e50fb();
    level thread function_889a9ace();
}

// Namespace namespace_7685657b
// Params 0, eflags: 0x0
// namespace_7685657b<file_0>::function_4b8b96fe
// Checksum 0x231d057e, Offset: 0x2c8
// Size: 0x82
function function_4b8b96fe() {
    level audio::playloopat("amb_jail_scene_2", (5582, -2060, -218));
    level audio::playloopat("amb_jail_scene_3", (5528, -1844, -209));
    level audio::playloopat("amb_jail_scene_4", (6289, -1689, -163));
    level audio::playloopat("amb_jail_scene_5", (5530, -1634, -265));
}

// Namespace namespace_7685657b
// Params 0, eflags: 0x0
// namespace_7685657b<file_0>::function_aca4761
// Checksum 0xf711774d, Offset: 0x358
// Size: 0xda
function function_aca4761() {
    level audio::playloopat("amb_firetruck_distant_alarm", (-1287, -1872, 535));
    level audio::playloopat("evt_firehose", (581, -857, -126));
    level waittill(#"hash_cfcc0f30");
    level audio::playloopat("amb_firetruck_close_alarm", (-169, -585, -95));
    level waittill(#"hash_da4c530f");
    level audio::stoploopat("amb_firetruck_distant_alarm", (-1287, -1872, 535));
    level audio::stoploopat("amb_firetruck_close_alarm", (-169, -585, -95));
    level audio::stoploopat("evt_firehose", (-169, -585, -95));
}

// Namespace namespace_7685657b
// Params 0, eflags: 0x0
// namespace_7685657b<file_0>::function_669e0ca5
// Checksum 0x9cf783d2, Offset: 0x440
// Size: 0x42
function function_669e0ca5() {
    level audio::playloopat("vox_garbled_radio_a", (-840, -721, -13259));
    level audio::playloopat("vox_garbled_radio_b", (-1003, -580, -13262));
}

// Namespace namespace_7685657b
// Params 0, eflags: 0x0
// namespace_7685657b<file_0>::function_6ce0e63
// Checksum 0x6b5aa60d, Offset: 0x490
// Size: 0x22
function function_6ce0e63() {
    level audio::playloopat("evt_halway_equipment", (3437, 597, -341));
}

// Namespace namespace_7685657b
// Params 0, eflags: 0x0
// namespace_7685657b<file_0>::function_eddf6028
// Checksum 0x9e10f440, Offset: 0x4c0
// Size: 0x42
function function_eddf6028() {
    level waittill(#"hash_6e2fd964");
    audio::snd_set_snapshot("cp_prologue_exit_apc");
    level waittill(#"hash_36f74bd3");
    audio::snd_set_snapshot("default");
}

// Namespace namespace_7685657b
// Params 0, eflags: 0x0
// namespace_7685657b<file_0>::function_35acdae6
// Checksum 0xe9c07cd6, Offset: 0x510
// Size: 0x2
function function_35acdae6() {
    
}

// Namespace namespace_7685657b
// Params 0, eflags: 0x0
// namespace_7685657b<file_0>::function_9806d032
// Checksum 0x8ec9f7ed, Offset: 0x520
// Size: 0xbb
function function_9806d032() {
    level waittill(#"hash_ef5b1f55");
    level endon(#"hash_73c9d58d");
    location1 = (15816, -749, 454);
    location2 = (15248, -749, 463);
    var_c291c0f3 = (15807, -1927, 478);
    for (count = 0; true; count++) {
        level thread function_ab91e7b9(location1);
        if (count > 5) {
            level thread function_ab91e7b9(location2);
        }
        if (count > 10) {
            level thread function_ab91e7b9(var_c291c0f3);
        }
        wait(1);
    }
}

// Namespace namespace_7685657b
// Params 1, eflags: 0x0
// namespace_7685657b<file_0>::function_ab91e7b9
// Checksum 0xae4de7cb, Offset: 0x5e8
// Size: 0x3a
function function_ab91e7b9(location) {
    wait(randomfloatrange(0.25, 2));
    playsound(0, "evt_garage_robot_hit", location);
}

// Namespace namespace_7685657b
// Params 0, eflags: 0x0
// namespace_7685657b<file_0>::function_c943c5e5
// Checksum 0x82b53ee0, Offset: 0x630
// Size: 0x5a
function function_c943c5e5() {
    level waittill(#"hash_cd190858");
    wait(5);
    level notify(#"hash_f8c8ddf6");
    audio::playloopat("amb_base_distant_walla", (12187, -167, 1183));
    audio::playloopat("amb_base_alert_outside", (14740, -1188, 751));
}

// Namespace namespace_7685657b
// Params 0, eflags: 0x0
// namespace_7685657b<file_0>::function_7ec0e1ae
// Checksum 0xcf3db763, Offset: 0x698
// Size: 0x6a
function function_7ec0e1ae() {
    level waittill(#"hash_dade54fb");
    audio::playloopat("amb_distant_soldier_walla", (8160, 756, 270));
    level waittill(#"hash_d1ef0d27");
    level waittill(#"hash_d1ef0d27");
    audio::stoploopat("amb_distant_soldier_walla", (8160, 756, 270));
}

// Namespace namespace_7685657b
// Params 0, eflags: 0x0
// namespace_7685657b<file_0>::function_eb4e50fb
// Checksum 0x924a7bac, Offset: 0x710
// Size: 0x62
function function_eb4e50fb() {
    level waittill(#"hash_caebb0ab");
    audio::playloopat("amb_distant_soldier_walla", (12604, 1857, 357));
    level waittill(#"hash_f8c8ddf6");
    audio::stoploopat("amb_distant_soldier_walla", (12604, 1857, 357));
}

// Namespace namespace_7685657b
// Params 0, eflags: 0x0
// namespace_7685657b<file_0>::function_889a9ace
// Checksum 0xc29f3fd8, Offset: 0x780
// Size: 0x212
function function_889a9ace() {
    level waittill(#"hash_dccb7956");
    audio::playloopat("amb_darkbattle_battery_beep", (13849, 2832, -30));
    audio::playloopat("amb_darkbattle_battery_beep", (13521, 3259, -27));
    audio::playloopat("amb_darkbattle_battery_beep", (13287, 3267, -30));
    audio::playloopat("amb_darkbattle_battery_beep", (13584, 2694, -3));
    audio::playloopat("amb_darkbattle_battery_beep", (13008, 2740, -7));
    audio::playloopat("amb_darkbattle_battery_beep", (13008, 2549, -7));
    audio::playloopat("amb_darkbattle_battery_beep", (13147, 2544, -11));
    audio::playloopat("amb_darkbattle_battery_beep", (13870, 2403, -14));
    level waittill(#"hash_e94a4dcf");
    audio::stoploopat("amb_darkbattle_battery_beep", (13849, 2832, -30));
    audio::stoploopat("amb_darkbattle_battery_beep", (13521, 3259, -27));
    audio::stoploopat("amb_darkbattle_battery_beep", (13287, 3267, -30));
    audio::stoploopat("amb_darkbattle_battery_beep", (13584, 2694, -3));
    audio::stoploopat("amb_darkbattle_battery_beep", (13008, 2740, -7));
    audio::stoploopat("amb_darkbattle_battery_beep", (13008, 2549, -7));
    audio::stoploopat("amb_darkbattle_battery_beep", (13147, 2544, -11));
    audio::stoploopat("amb_darkbattle_battery_beep", (13870, 2403, -14));
}

