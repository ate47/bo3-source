#using scripts/cp/voice/voice_zurich;
#using scripts/shared/music_shared;
#using scripts/codescripts/struct;

#namespace namespace_b301a1fd;

// Namespace namespace_b301a1fd
// Params 0, eflags: 0x0
// Checksum 0x1e9219f9, Offset: 0x260
// Size: 0x12
function main() {
    namespace_2fedc4ad::init_voice();
}

#namespace namespace_67110270;

// Namespace namespace_67110270
// Params 0, eflags: 0x0
// Checksum 0xfbe890d8, Offset: 0x280
// Size: 0x1a
function function_973b77f9() {
    music::setmusicstate("none");
}

// Namespace namespace_67110270
// Params 0, eflags: 0x0
// Checksum 0x428d9832, Offset: 0x2a8
// Size: 0x1a
function function_9c09862a() {
    music::setmusicstate("intro_igc_1");
}

// Namespace namespace_67110270
// Params 0, eflags: 0x0
// Checksum 0xc03ada9a, Offset: 0x2d0
// Size: 0x1a
function function_db37681() {
    music::setmusicstate("tension_battle");
}

// Namespace namespace_67110270
// Params 0, eflags: 0x0
// Checksum 0x3f4aa8d, Offset: 0x2f8
// Size: 0x1a
function function_99ab0b3b() {
    music::setmusicstate("first_pacing");
}

// Namespace namespace_67110270
// Params 0, eflags: 0x0
// Checksum 0x9773cd2, Offset: 0x320
// Size: 0x1a
function function_228c7b0f() {
    music::setmusicstate("quads_battle");
}

// Namespace namespace_67110270
// Params 0, eflags: 0x0
// Checksum 0x43d90ec8, Offset: 0x348
// Size: 0x42
function function_ce97ecac() {
    playsoundatposition("mus_sgen_hq_logo_glitched", (-8763, 38522, 681));
    wait(3);
    music::setmusicstate("igc_2_dark_ambience");
}

// Namespace namespace_67110270
// Params 0, eflags: 0x0
// Checksum 0x4510e401, Offset: 0x398
// Size: 0x1a
function function_232f4de7() {
    music::setmusicstate("robot_battle");
}

// Namespace namespace_67110270
// Params 0, eflags: 0x0
// Checksum 0xfe43c21b, Offset: 0x3c0
// Size: 0x1a
function function_bb8ce831() {
    music::setmusicstate("tension_loop_1");
}

// Namespace namespace_67110270
// Params 0, eflags: 0x0
// Checksum 0xe01debd2, Offset: 0x3e8
// Size: 0x1a
function function_876e5649() {
    music::setmusicstate("pre_sacrifice_igc");
}

// Namespace namespace_67110270
// Params 0, eflags: 0x0
// Checksum 0x6341851b, Offset: 0x410
// Size: 0x1a
function function_455aaf94() {
    music::setmusicstate("sacrifice_igc_2");
}

// Namespace namespace_67110270
// Params 0, eflags: 0x0
// Checksum 0x988de5d5, Offset: 0x438
// Size: 0x1a
function function_6d49ae2() {
    music::setmusicstate("post_sacrifice_anger");
}

// Namespace namespace_67110270
// Params 0, eflags: 0x0
// Checksum 0xd87451ab, Offset: 0x460
// Size: 0x1a
function function_40b3f4d() {
    music::setmusicstate("standoff_igc_3");
}

// Namespace namespace_67110270
// Params 0, eflags: 0x0
// Checksum 0xc8cc875a, Offset: 0x488
// Size: 0x1a
function function_82e83534() {
    music::setmusicstate("frozen_forest");
}

// Namespace namespace_67110270
// Params 0, eflags: 0x0
// Checksum 0x7b6356, Offset: 0x4b0
// Size: 0x1a
function function_71271388() {
    music::setmusicstate("kruger_dies_again_igc_4");
}

// Namespace namespace_67110270
// Params 0, eflags: 0x0
// Checksum 0xe935d94b, Offset: 0x4d8
// Size: 0x1a
function function_ff7a72bf() {
    music::setmusicstate("zurich_root_battle");
}

// Namespace namespace_67110270
// Params 0, eflags: 0x0
// Checksum 0x8fd9db19, Offset: 0x500
// Size: 0x1a
function function_38a68128() {
    music::setmusicstate("testing_lab_igc_5");
}

// Namespace namespace_67110270
// Params 0, eflags: 0x0
// Checksum 0xf5d5832f, Offset: 0x528
// Size: 0x1a
function function_1935b4aa() {
    wait(15);
    music::setmusicstate("cairo_root_battle");
}

// Namespace namespace_67110270
// Params 0, eflags: 0x0
// Checksum 0x6d4b58d1, Offset: 0x550
// Size: 0x1a
function function_67c7b7bc() {
    music::setmusicstate("infection_igc_6");
}

// Namespace namespace_67110270
// Params 0, eflags: 0x0
// Checksum 0x9b53358d, Offset: 0x578
// Size: 0x1a
function function_65e1e4b4() {
    music::setmusicstate("singapore_root_battle");
}

// Namespace namespace_67110270
// Params 0, eflags: 0x0
// Checksum 0x2272736, Offset: 0x5a0
// Size: 0x1a
function function_668ff14b() {
    music::setmusicstate("intero_igc");
}

// Namespace namespace_67110270
// Params 0, eflags: 0x0
// Checksum 0xe7b9c7cc, Offset: 0x5c8
// Size: 0x42
function function_b01ef29c() {
    if (sessionmodeiscampaignzombiesgame()) {
        music::setmusicstate("zm_outro_loop");
        return;
    }
    music::setmusicstate("i_live");
}

// Namespace namespace_67110270
// Params 0, eflags: 0x0
// Checksum 0xbcebf414, Offset: 0x618
// Size: 0x1a
function function_5a0b3e34() {
    music::setmusicstate("white_rabbit");
}

