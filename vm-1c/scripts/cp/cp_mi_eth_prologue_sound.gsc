#using scripts/codescripts/struct;
#using scripts/cp/_util;
#using scripts/shared/music_shared;
#using scripts/shared/util_shared;

#namespace cp_mi_eth_prologue_sound;

// Namespace cp_mi_eth_prologue_sound
// Params 0, eflags: 0x0
// Checksum 0x7d8f9123, Offset: 0x310
// Size: 0xac
function main() {
    level thread function_b3c510e0();
    level thread function_96d9cac5();
    level thread function_8066773b();
    level thread function_a4815b6c();
    level thread function_44ee5cb7();
    level thread function_a4312bfe();
    level thread namespace_21b2c1f2::function_7a818f3c();
}

// Namespace cp_mi_eth_prologue_sound
// Params 0, eflags: 0x0
// Checksum 0x431f3d21, Offset: 0x3c8
// Size: 0x54
function function_b3c510e0() {
    var_2936d99 = getent("amb_garbled_screen", "targetname");
    if (isdefined(var_2936d99)) {
        var_2936d99 playloopsound("amb_garbled_voice");
    }
}

// Namespace cp_mi_eth_prologue_sound
// Params 0, eflags: 0x0
// Checksum 0x7b3b22d0, Offset: 0x428
// Size: 0xbc
function function_96d9cac5() {
    sound_org = getent("amb_offices", "targetname");
    if (isdefined(sound_org)) {
        sound_org playloopsound("amb_offices");
    }
    level waittill(#"hash_400d768d");
    level thread namespace_21b2c1f2::function_973b77f9();
    if (isdefined(sound_org)) {
        sound_org stoploopsound();
        playsoundatposition("amb_power_down", sound_org.origin);
    }
}

// Namespace cp_mi_eth_prologue_sound
// Params 0, eflags: 0x0
// Checksum 0x231b564a, Offset: 0x4f0
// Size: 0x76
function function_8066773b() {
    var_30031844 = getentarray("amb_office_power_on", "targetname");
    for (i = 0; i < var_30031844.size; i++) {
        var_30031844[i] thread function_55f749fc();
    }
}

// Namespace cp_mi_eth_prologue_sound
// Params 0, eflags: 0x0
// Checksum 0x3b7facf, Offset: 0x570
// Size: 0x84
function function_55f749fc() {
    self playloopsound(self.script_sound);
    level waittill(#"hash_400d768d");
    self stoploopsound();
    wait randomfloatrange(0.2, 3.1);
    self playsound("amb_spark_generic");
}

// Namespace cp_mi_eth_prologue_sound
// Params 0, eflags: 0x0
// Checksum 0x40e4fe5a, Offset: 0x600
// Size: 0x60
function function_a4815b6c() {
    level endon(#"hash_8e1e9ee");
    level endon(#"game_ended");
    level waittill(#"siren");
    while (true) {
        wait 2;
        playsoundatposition("amb_troop_alarm", (3529, 427, -334));
    }
}

// Namespace cp_mi_eth_prologue_sound
// Params 0, eflags: 0x0
// Checksum 0xeddaf010, Offset: 0x668
// Size: 0x60
function function_44ee5cb7() {
    level endon(#"hash_8e1e9ee");
    level endon(#"game_ended");
    level waittill(#"hash_5ea48ae9");
    while (true) {
        wait 1;
        playsoundatposition("amb_troop_alarm", (5945, -2320, -119));
    }
}

// Namespace cp_mi_eth_prologue_sound
// Params 0, eflags: 0x0
// Checksum 0x24e3e374, Offset: 0x6d0
// Size: 0x5e
function function_a4312bfe() {
    level endon(#"hash_f8e975b8");
    level waittill(#"hash_fc089399");
    while (true) {
        wait 1;
        playsoundatposition("amb_phone_ring", (-1760, -1624, 384));
        wait 2;
    }
}

#namespace namespace_21b2c1f2;

// Namespace namespace_21b2c1f2
// Params 0, eflags: 0x0
// Checksum 0x7a8efcee, Offset: 0x738
// Size: 0x1c
function function_973b77f9() {
    music::setmusicstate("none");
}

// Namespace namespace_21b2c1f2
// Params 0, eflags: 0x0
// Checksum 0x5b48ba16, Offset: 0x760
// Size: 0x1c
function function_5712e4e2() {
    music::setmusicstate("intro_igc");
}

// Namespace namespace_21b2c1f2
// Params 0, eflags: 0x0
// Checksum 0x97e11de2, Offset: 0x788
// Size: 0x1c
function play_outro_igc() {
    music::setmusicstate("outro_igc");
}

// Namespace namespace_21b2c1f2
// Params 0, eflags: 0x0
// Checksum 0xcff039fa, Offset: 0x7b0
// Size: 0x1c
function function_e245d17f() {
    music::setmusicstate("nrc_knocks");
}

// Namespace namespace_21b2c1f2
// Params 0, eflags: 0x0
// Checksum 0xaf16d98b, Offset: 0x7d8
// Size: 0x1c
function function_fd00a4f2() {
    music::setmusicstate("door_breach");
}

// Namespace namespace_21b2c1f2
// Params 0, eflags: 0x0
// Checksum 0x43338b69, Offset: 0x800
// Size: 0x1c
function function_e847067() {
    music::setmusicstate("scanning_for_minister");
}

// Namespace namespace_21b2c1f2
// Params 0, eflags: 0x0
// Checksum 0xa1956eff, Offset: 0x828
// Size: 0x24
function function_fa2e45b8() {
    wait 16;
    music::setmusicstate("battle_1");
}

// Namespace namespace_21b2c1f2
// Params 0, eflags: 0x0
// Checksum 0x72b6e03e, Offset: 0x858
// Size: 0x1c
function function_baefe66d() {
    music::setmusicstate("battle_1");
}

// Namespace namespace_21b2c1f2
// Params 0, eflags: 0x0
// Checksum 0x1cebcdf, Offset: 0x880
// Size: 0x1c
function function_d4c52995() {
    music::setmusicstate("tension_loop");
}

// Namespace namespace_21b2c1f2
// Params 0, eflags: 0x0
// Checksum 0xa41f761, Offset: 0x8a8
// Size: 0x24
function function_2f85277b() {
    wait 1.5;
    music::setmusicstate("minister_rescued");
}

// Namespace namespace_21b2c1f2
// Params 0, eflags: 0x0
// Checksum 0x620f5a1d, Offset: 0x8d8
// Size: 0x1c
function function_fb4a2ce1() {
    music::setmusicstate("khalil_rescue");
}

// Namespace namespace_21b2c1f2
// Params 0, eflags: 0x0
// Checksum 0x6da5b558, Offset: 0x900
// Size: 0x1c
function function_1c0460dd() {
    music::setmusicstate("battle_2_intro_loop");
}

// Namespace namespace_21b2c1f2
// Params 0, eflags: 0x0
// Checksum 0x9c00e8fb, Offset: 0x928
// Size: 0x1c
function function_6c35b4f3() {
    music::setmusicstate("battle_2");
}

// Namespace namespace_21b2c1f2
// Params 0, eflags: 0x0
// Checksum 0xbd49e2c9, Offset: 0x950
// Size: 0x1c
function function_49fef8f4() {
    music::setmusicstate("gather_loop");
}

// Namespace namespace_21b2c1f2
// Params 0, eflags: 0x0
// Checksum 0xbb226428, Offset: 0x978
// Size: 0x24
function function_9f50ebc2() {
    wait 3;
    music::setmusicstate("none");
}

// Namespace namespace_21b2c1f2
// Params 0, eflags: 0x0
// Checksum 0xc43ecd20, Offset: 0x9a8
// Size: 0x24
function function_c4c71c7() {
    wait 3;
    music::setmusicstate("drop_your_weapons");
}

// Namespace namespace_21b2c1f2
// Params 1, eflags: 0x0
// Checksum 0x89afb627, Offset: 0x9d8
// Size: 0x2c
function function_43ead72c(a_ents) {
    wait 10;
    music::setmusicstate("taylor_entrance");
}

// Namespace namespace_21b2c1f2
// Params 0, eflags: 0x0
// Checksum 0x9ad2347, Offset: 0xa10
// Size: 0x24
function function_46333a8a() {
    wait 3;
    music::setmusicstate("battle_3");
}

// Namespace namespace_21b2c1f2
// Params 0, eflags: 0x0
// Checksum 0x4a6cab2, Offset: 0xa40
// Size: 0x1c
function function_37906040() {
    music::setmusicstate("hall_stinger");
}

// Namespace namespace_21b2c1f2
// Params 0, eflags: 0x0
// Checksum 0xb701c906, Offset: 0xa68
// Size: 0x2c
function function_7a818f3c() {
    level waittill(#"hash_64976832");
    music::setmusicstate("hall_heroic_run");
}

// Namespace namespace_21b2c1f2
// Params 0, eflags: 0x0
// Checksum 0xfb7005b0, Offset: 0xaa0
// Size: 0x24
function function_b83aa9c5() {
    wait 6;
    music::setmusicstate("battle_4");
}

// Namespace namespace_21b2c1f2
// Params 0, eflags: 0x0
// Checksum 0xe379a6ea, Offset: 0xad0
// Size: 0x1c
function function_3c37ec50() {
    music::setmusicstate("dark_pad");
}

// Namespace namespace_21b2c1f2
// Params 0, eflags: 0x0
// Checksum 0xfaea072d, Offset: 0xaf8
// Size: 0x1c
function function_a0f24f9b() {
    music::setmusicstate("office_battle");
}

// Namespace namespace_21b2c1f2
// Params 0, eflags: 0x0
// Checksum 0x4d48b479, Offset: 0xb20
// Size: 0x1c
function function_2a66b344() {
    music::setmusicstate("post_office_drone");
}

// Namespace namespace_21b2c1f2
// Params 0, eflags: 0x0
// Checksum 0xdc13404, Offset: 0xb48
// Size: 0x1c
function function_63ffe714() {
    music::setmusicstate("vtol_approach");
}

// Namespace namespace_21b2c1f2
// Params 0, eflags: 0x0
// Checksum 0x878ceb63, Offset: 0xb70
// Size: 0x34
function function_f573bcb9() {
    music::setmusicstate("taylor_is_a_hero");
    util::clientnotify("saw");
}

// Namespace namespace_21b2c1f2
// Params 0, eflags: 0x0
// Checksum 0xfa6a4b08, Offset: 0xbb0
// Size: 0x1c
function function_448421b7() {
    music::setmusicstate("robot_entrance");
}

// Namespace namespace_21b2c1f2
// Params 0, eflags: 0x0
// Checksum 0x67f28591, Offset: 0xbd8
// Size: 0x1c
function function_fb0b7bb6() {
    music::setmusicstate("post_robot_horde");
}

// Namespace namespace_21b2c1f2
// Params 0, eflags: 0x0
// Checksum 0xc05fb016, Offset: 0xc00
// Size: 0x1c
function function_37a511a() {
    music::setmusicstate("dark_loop_pre_apc");
}

// Namespace namespace_21b2c1f2
// Params 0, eflags: 0x0
// Checksum 0x831d7d3c, Offset: 0xc28
// Size: 0x1c
function function_da98f0c7() {
    music::setmusicstate("apc_rail");
}

// Namespace namespace_21b2c1f2
// Params 0, eflags: 0x0
// Checksum 0x4fa4e787, Offset: 0xc50
// Size: 0x1c
function function_27bc11a3() {
    music::setmusicstate("crash");
}

// Namespace namespace_21b2c1f2
// Params 0, eflags: 0x0
// Checksum 0xfd7df0e9, Offset: 0xc78
// Size: 0x1c
function function_8feece84() {
    music::setmusicstate("apc_rail");
}

// Namespace namespace_21b2c1f2
// Params 0, eflags: 0x0
// Checksum 0xa74da0e3, Offset: 0xca0
// Size: 0x24
function function_92382f5c() {
    wait 3;
    music::setmusicstate("battle_5");
}

// Namespace namespace_21b2c1f2
// Params 0, eflags: 0x0
// Checksum 0x1d0c5408, Offset: 0xcd0
// Size: 0x1c
function function_fcb67450() {
    music::setmusicstate("skycrane");
}

