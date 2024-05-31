#using scripts/shared/util_shared;
#using scripts/cp/_util;
#using scripts/shared/music_shared;
#using scripts/codescripts/struct;

#namespace namespace_7685657b;

// Namespace namespace_7685657b
// Params 0, eflags: 0x0
// Checksum 0x8c0dc8e1, Offset: 0x310
// Size: 0x72
function main() {
    level thread function_b3c510e0();
    level thread function_96d9cac5();
    level thread function_8066773b();
    level thread function_a4815b6c();
    level thread function_44ee5cb7();
    level thread function_a4312bfe();
    level thread namespace_21b2c1f2::function_7a818f3c();
}

// Namespace namespace_7685657b
// Params 0, eflags: 0x0
// Checksum 0x87ab9e94, Offset: 0x390
// Size: 0x4a
function function_b3c510e0() {
    var_2936d99 = getent("amb_garbled_screen", "targetname");
    if (isdefined(var_2936d99)) {
        var_2936d99 playloopsound("amb_garbled_voice");
    }
}

// Namespace namespace_7685657b
// Params 0, eflags: 0x0
// Checksum 0x4fd9fde, Offset: 0x3e8
// Size: 0x9a
function function_96d9cac5() {
    var_a66f2065 = getent("amb_offices", "targetname");
    if (isdefined(var_a66f2065)) {
        var_a66f2065 playloopsound("amb_offices");
    }
    level waittill(#"hash_400d768d");
    level thread namespace_21b2c1f2::function_973b77f9();
    if (isdefined(var_a66f2065)) {
        var_a66f2065 stoploopsound();
        playsoundatposition("amb_power_down", var_a66f2065.origin);
    }
}

// Namespace namespace_7685657b
// Params 0, eflags: 0x0
// Checksum 0x733742a0, Offset: 0x490
// Size: 0x59
function function_8066773b() {
    var_30031844 = getentarray("amb_office_power_on", "targetname");
    for (i = 0; i < var_30031844.size; i++) {
        var_30031844[i] thread function_55f749fc();
    }
}

// Namespace namespace_7685657b
// Params 0, eflags: 0x0
// Checksum 0xd514a721, Offset: 0x4f8
// Size: 0x6a
function function_55f749fc() {
    self playloopsound(self.script_sound);
    level waittill(#"hash_400d768d");
    self stoploopsound();
    wait(randomfloatrange(0.2, 3.1));
    self playsound("amb_spark_generic");
}

// Namespace namespace_7685657b
// Params 0, eflags: 0x0
// Checksum 0x3f0af6b9, Offset: 0x570
// Size: 0x4d
function function_a4815b6c() {
    level endon(#"hash_8e1e9ee");
    level endon(#"game_ended");
    level waittill(#"hash_62797210");
    while (true) {
        wait(2);
        playsoundatposition("amb_troop_alarm", (3529, 427, -334));
    }
}

// Namespace namespace_7685657b
// Params 0, eflags: 0x0
// Checksum 0x564058e9, Offset: 0x5c8
// Size: 0x45
function function_44ee5cb7() {
    level endon(#"hash_8e1e9ee");
    level endon(#"game_ended");
    level waittill(#"hash_5ea48ae9");
    while (true) {
        wait(1);
        playsoundatposition("amb_troop_alarm", (5945, -2320, -119));
    }
}

// Namespace namespace_7685657b
// Params 0, eflags: 0x0
// Checksum 0xd4bccb8b, Offset: 0x618
// Size: 0x49
function function_a4312bfe() {
    level endon(#"hash_f8e975b8");
    level waittill(#"hash_fc089399");
    while (true) {
        wait(1);
        playsoundatposition("amb_phone_ring", (-1760, -1624, 384));
        wait(2);
    }
}

#namespace namespace_21b2c1f2;

// Namespace namespace_21b2c1f2
// Params 0, eflags: 0x0
// Checksum 0x4434a41f, Offset: 0x670
// Size: 0x1a
function function_973b77f9() {
    music::setmusicstate("none");
}

// Namespace namespace_21b2c1f2
// Params 0, eflags: 0x0
// Checksum 0x90fd1bb4, Offset: 0x698
// Size: 0x1a
function function_5712e4e2() {
    music::setmusicstate("intro_igc");
}

// Namespace namespace_21b2c1f2
// Params 0, eflags: 0x0
// Checksum 0xa078c422, Offset: 0x6c0
// Size: 0x1a
function play_outro_igc() {
    music::setmusicstate("outro_igc");
}

// Namespace namespace_21b2c1f2
// Params 0, eflags: 0x0
// Checksum 0x9a71bf72, Offset: 0x6e8
// Size: 0x1a
function function_e245d17f() {
    music::setmusicstate("nrc_knocks");
}

// Namespace namespace_21b2c1f2
// Params 0, eflags: 0x0
// Checksum 0x3edec5a9, Offset: 0x710
// Size: 0x1a
function function_fd00a4f2() {
    music::setmusicstate("door_breach");
}

// Namespace namespace_21b2c1f2
// Params 0, eflags: 0x0
// Checksum 0x3195554c, Offset: 0x738
// Size: 0x1a
function function_e847067() {
    music::setmusicstate("scanning_for_minister");
}

// Namespace namespace_21b2c1f2
// Params 0, eflags: 0x0
// Checksum 0x5cf5da50, Offset: 0x760
// Size: 0x1a
function function_fa2e45b8() {
    wait(8);
    music::setmusicstate("battle_1");
}

// Namespace namespace_21b2c1f2
// Params 0, eflags: 0x0
// Checksum 0x5435634d, Offset: 0x788
// Size: 0x1a
function function_baefe66d() {
    music::setmusicstate("battle_1");
}

// Namespace namespace_21b2c1f2
// Params 0, eflags: 0x0
// Checksum 0x7c64608b, Offset: 0x7b0
// Size: 0x1a
function function_d4c52995() {
    music::setmusicstate("tension_loop");
}

// Namespace namespace_21b2c1f2
// Params 0, eflags: 0x0
// Checksum 0x136d8978, Offset: 0x7d8
// Size: 0x22
function function_2f85277b() {
    wait(1.5);
    music::setmusicstate("minister_rescued");
}

// Namespace namespace_21b2c1f2
// Params 0, eflags: 0x0
// Checksum 0x526b13de, Offset: 0x808
// Size: 0x1a
function function_fb4a2ce1() {
    music::setmusicstate("khalil_rescue");
}

// Namespace namespace_21b2c1f2
// Params 0, eflags: 0x0
// Checksum 0x63c9833c, Offset: 0x830
// Size: 0x1a
function function_1c0460dd() {
    music::setmusicstate("battle_2_intro_loop");
}

// Namespace namespace_21b2c1f2
// Params 0, eflags: 0x0
// Checksum 0x80483519, Offset: 0x858
// Size: 0x1a
function function_6c35b4f3() {
    music::setmusicstate("battle_2");
}

// Namespace namespace_21b2c1f2
// Params 0, eflags: 0x0
// Checksum 0x6a77183c, Offset: 0x880
// Size: 0x1a
function function_49fef8f4() {
    music::setmusicstate("gather_loop");
}

// Namespace namespace_21b2c1f2
// Params 0, eflags: 0x0
// Checksum 0x6bad9800, Offset: 0x8a8
// Size: 0x1a
function function_9f50ebc2() {
    wait(3);
    music::setmusicstate("none");
}

// Namespace namespace_21b2c1f2
// Params 0, eflags: 0x0
// Checksum 0x2dcd7946, Offset: 0x8d0
// Size: 0x1a
function function_c4c71c7() {
    wait(3);
    music::setmusicstate("drop_your_weapons");
}

// Namespace namespace_21b2c1f2
// Params 1, eflags: 0x0
// Checksum 0x62cf5b91, Offset: 0x8f8
// Size: 0x22
function function_43ead72c(a_ents) {
    wait(10);
    music::setmusicstate("taylor_entrance");
}

// Namespace namespace_21b2c1f2
// Params 0, eflags: 0x0
// Checksum 0x7e21667d, Offset: 0x928
// Size: 0x1a
function function_46333a8a() {
    wait(3);
    music::setmusicstate("battle_3");
}

// Namespace namespace_21b2c1f2
// Params 0, eflags: 0x0
// Checksum 0xf84d5c13, Offset: 0x950
// Size: 0x1a
function function_37906040() {
    music::setmusicstate("hall_stinger");
}

// Namespace namespace_21b2c1f2
// Params 0, eflags: 0x0
// Checksum 0x63a4fa7, Offset: 0x978
// Size: 0x22
function function_7a818f3c() {
    level waittill(#"hash_64976832");
    music::setmusicstate("hall_heroic_run");
}

// Namespace namespace_21b2c1f2
// Params 0, eflags: 0x0
// Checksum 0xb6a74bb7, Offset: 0x9a8
// Size: 0x1a
function function_b83aa9c5() {
    wait(6);
    music::setmusicstate("battle_4");
}

// Namespace namespace_21b2c1f2
// Params 0, eflags: 0x0
// Checksum 0xbe5f3f29, Offset: 0x9d0
// Size: 0x1a
function function_3c37ec50() {
    music::setmusicstate("dark_pad");
}

// Namespace namespace_21b2c1f2
// Params 0, eflags: 0x0
// Checksum 0x28b1e538, Offset: 0x9f8
// Size: 0x1a
function function_a0f24f9b() {
    music::setmusicstate("office_battle");
}

// Namespace namespace_21b2c1f2
// Params 0, eflags: 0x0
// Checksum 0xbabdebf2, Offset: 0xa20
// Size: 0x1a
function function_2a66b344() {
    music::setmusicstate("post_office_drone");
}

// Namespace namespace_21b2c1f2
// Params 0, eflags: 0x0
// Checksum 0x8863627f, Offset: 0xa48
// Size: 0x1a
function function_63ffe714() {
    music::setmusicstate("vtol_approach");
}

// Namespace namespace_21b2c1f2
// Params 0, eflags: 0x0
// Checksum 0x3cbe8c9, Offset: 0xa70
// Size: 0x32
function function_f573bcb9() {
    music::setmusicstate("taylor_is_a_hero");
    util::clientnotify("saw");
}

// Namespace namespace_21b2c1f2
// Params 0, eflags: 0x0
// Checksum 0x4bce35ab, Offset: 0xab0
// Size: 0x1a
function function_448421b7() {
    music::setmusicstate("robot_entrance");
}

// Namespace namespace_21b2c1f2
// Params 0, eflags: 0x0
// Checksum 0xb9e1479e, Offset: 0xad8
// Size: 0x1a
function function_fb0b7bb6() {
    music::setmusicstate("post_robot_horde");
}

// Namespace namespace_21b2c1f2
// Params 0, eflags: 0x0
// Checksum 0x79ae208d, Offset: 0xb00
// Size: 0x1a
function function_37a511a() {
    music::setmusicstate("dark_loop_pre_apc");
}

// Namespace namespace_21b2c1f2
// Params 0, eflags: 0x0
// Checksum 0xe85c3da5, Offset: 0xb28
// Size: 0x1a
function function_da98f0c7() {
    music::setmusicstate("apc_rail");
}

// Namespace namespace_21b2c1f2
// Params 0, eflags: 0x0
// Checksum 0x86083edf, Offset: 0xb50
// Size: 0x1a
function function_27bc11a3() {
    music::setmusicstate("crash");
}

// Namespace namespace_21b2c1f2
// Params 0, eflags: 0x0
// Checksum 0x43b3ff1a, Offset: 0xb78
// Size: 0x1a
function function_8feece84() {
    music::setmusicstate("apc_rail");
}

// Namespace namespace_21b2c1f2
// Params 0, eflags: 0x0
// Checksum 0x410d9882, Offset: 0xba0
// Size: 0x1a
function function_92382f5c() {
    wait(3);
    music::setmusicstate("battle_5");
}

// Namespace namespace_21b2c1f2
// Params 0, eflags: 0x0
// Checksum 0x8463e4c, Offset: 0xbc8
// Size: 0x1a
function function_fcb67450() {
    music::setmusicstate("skycrane");
}

