#using scripts/cp/voice/voice_zurich;
#using scripts/shared/music_shared;
#using scripts/codescripts/struct;

#namespace namespace_b301a1fd;

// Namespace namespace_b301a1fd
// Params 0, eflags: 0x1 linked
// Checksum 0x832b06b7, Offset: 0x260
// Size: 0x14
function main() {
    namespace_2fedc4ad::init_voice();
}

#namespace namespace_67110270;

// Namespace namespace_67110270
// Params 0, eflags: 0x1 linked
// Checksum 0x3fcaba0b, Offset: 0x280
// Size: 0x1c
function function_973b77f9() {
    music::setmusicstate("none");
}

// Namespace namespace_67110270
// Params 0, eflags: 0x0
// Checksum 0x302d050e, Offset: 0x2a8
// Size: 0x1c
function function_9c09862a() {
    music::setmusicstate("intro_igc_1");
}

// Namespace namespace_67110270
// Params 0, eflags: 0x1 linked
// Checksum 0xa0219327, Offset: 0x2d0
// Size: 0x1c
function function_db37681() {
    music::setmusicstate("tension_battle");
}

// Namespace namespace_67110270
// Params 0, eflags: 0x1 linked
// Checksum 0x91707659, Offset: 0x2f8
// Size: 0x1c
function function_99ab0b3b() {
    music::setmusicstate("first_pacing");
}

// Namespace namespace_67110270
// Params 0, eflags: 0x1 linked
// Checksum 0x1ac08f71, Offset: 0x320
// Size: 0x1c
function function_228c7b0f() {
    music::setmusicstate("quads_battle");
}

// Namespace namespace_67110270
// Params 0, eflags: 0x1 linked
// Checksum 0x1851a109, Offset: 0x348
// Size: 0x4c
function function_ce97ecac() {
    playsoundatposition("mus_sgen_hq_logo_glitched", (-8763, 38522, 681));
    wait(3);
    music::setmusicstate("igc_2_dark_ambience");
}

// Namespace namespace_67110270
// Params 0, eflags: 0x1 linked
// Checksum 0xcfa3b4d3, Offset: 0x3a0
// Size: 0x1c
function function_232f4de7() {
    music::setmusicstate("robot_battle");
}

// Namespace namespace_67110270
// Params 0, eflags: 0x1 linked
// Checksum 0x19204d2e, Offset: 0x3c8
// Size: 0x1c
function function_bb8ce831() {
    music::setmusicstate("tension_loop_1");
}

// Namespace namespace_67110270
// Params 0, eflags: 0x1 linked
// Checksum 0x15817bea, Offset: 0x3f0
// Size: 0x1c
function function_876e5649() {
    music::setmusicstate("pre_sacrifice_igc");
}

// Namespace namespace_67110270
// Params 0, eflags: 0x1 linked
// Checksum 0x144ed395, Offset: 0x418
// Size: 0x1c
function function_455aaf94() {
    music::setmusicstate("sacrifice_igc_2");
}

// Namespace namespace_67110270
// Params 0, eflags: 0x0
// Checksum 0x984c76c6, Offset: 0x440
// Size: 0x1c
function function_6d49ae2() {
    music::setmusicstate("post_sacrifice_anger");
}

// Namespace namespace_67110270
// Params 0, eflags: 0x1 linked
// Checksum 0xb1bb4c56, Offset: 0x468
// Size: 0x1c
function function_40b3f4d() {
    music::setmusicstate("standoff_igc_3");
}

// Namespace namespace_67110270
// Params 0, eflags: 0x1 linked
// Checksum 0xa75bcd5b, Offset: 0x490
// Size: 0x1c
function function_82e83534() {
    music::setmusicstate("frozen_forest");
}

// Namespace namespace_67110270
// Params 0, eflags: 0x1 linked
// Checksum 0x40aae517, Offset: 0x4b8
// Size: 0x1c
function function_71271388() {
    music::setmusicstate("kruger_dies_again_igc_4");
}

// Namespace namespace_67110270
// Params 0, eflags: 0x1 linked
// Checksum 0x5bf37958, Offset: 0x4e0
// Size: 0x1c
function function_ff7a72bf() {
    music::setmusicstate("zurich_root_battle");
}

// Namespace namespace_67110270
// Params 0, eflags: 0x1 linked
// Checksum 0x501c9faf, Offset: 0x508
// Size: 0x1c
function function_38a68128() {
    music::setmusicstate("testing_lab_igc_5");
}

// Namespace namespace_67110270
// Params 0, eflags: 0x1 linked
// Checksum 0x33d39b6f, Offset: 0x530
// Size: 0x24
function function_1935b4aa() {
    wait(15);
    music::setmusicstate("cairo_root_battle");
}

// Namespace namespace_67110270
// Params 0, eflags: 0x1 linked
// Checksum 0x73c6851a, Offset: 0x560
// Size: 0x1c
function function_67c7b7bc() {
    music::setmusicstate("infection_igc_6");
}

// Namespace namespace_67110270
// Params 0, eflags: 0x1 linked
// Checksum 0x7055e66b, Offset: 0x588
// Size: 0x1c
function function_65e1e4b4() {
    music::setmusicstate("singapore_root_battle");
}

// Namespace namespace_67110270
// Params 0, eflags: 0x1 linked
// Checksum 0xa566dac1, Offset: 0x5b0
// Size: 0x1c
function function_668ff14b() {
    music::setmusicstate("intero_igc");
}

// Namespace namespace_67110270
// Params 0, eflags: 0x1 linked
// Checksum 0x1ca86aef, Offset: 0x5d8
// Size: 0x4c
function function_b01ef29c() {
    if (sessionmodeiscampaignzombiesgame()) {
        music::setmusicstate("zm_outro_loop");
        return;
    }
    music::setmusicstate("i_live");
}

// Namespace namespace_67110270
// Params 0, eflags: 0x0
// Checksum 0x43f6a49b, Offset: 0x630
// Size: 0x1c
function function_5a0b3e34() {
    music::setmusicstate("white_rabbit");
}

