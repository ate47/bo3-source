#using scripts/codescripts/struct;
#using scripts/cp/voice/voice_ramses;
#using scripts/cp/voice/voice_ramses2;
#using scripts/shared/flag_shared;
#using scripts/shared/music_shared;
#using scripts/shared/util_shared;

#namespace cp_mi_cairo_ramses2_sound;

// Namespace cp_mi_cairo_ramses2_sound
// Params 0, eflags: 0x0
// Checksum 0x86d8f9f0, Offset: 0x2e0
// Size: 0x8c
function main() {
    voice_ramses::init_voice();
    voice_ramses2::init_voice();
    level thread function_6a579aa5("sndOutroFoley", "outrofoley", "sndOutro", "outroduck");
    level thread namespace_a6a248fc::function_f20b84a9();
    level thread namespace_a6a248fc::function_9f04a172();
}

// Namespace cp_mi_cairo_ramses2_sound
// Params 4, eflags: 0x0
// Checksum 0xc1b1df15, Offset: 0x378
// Size: 0x64
function function_6a579aa5(arg1, arg2, arg3, arg4) {
    level waittill(arg1);
    level util::clientnotify(arg2);
    level waittill(arg3);
    level util::clientnotify(arg4);
}

#namespace namespace_a6a248fc;

// Namespace namespace_a6a248fc
// Params 0, eflags: 0x0
// Checksum 0x8d8f267e, Offset: 0x3e8
// Size: 0x1c
function function_1e7ee1cd() {
    music::setmusicstate("jeep_drive");
}

// Namespace namespace_a6a248fc
// Params 0, eflags: 0x0
// Checksum 0x8359ff58, Offset: 0x410
// Size: 0x1c
function function_37e13caa() {
    music::setmusicstate("jeep_drive_short");
}

// Namespace namespace_a6a248fc
// Params 0, eflags: 0x0
// Checksum 0x6296fce6, Offset: 0x438
// Size: 0x1c
function function_9574e08d() {
    music::setmusicstate("spike_launch_arena");
}

// Namespace namespace_a6a248fc
// Params 0, eflags: 0x0
// Checksum 0x5e013d56, Offset: 0x460
// Size: 0x1c
function function_7b69c801() {
    music::setmusicstate("retreat");
}

// Namespace namespace_a6a248fc
// Params 0, eflags: 0x0
// Checksum 0xfeb5d7ca, Offset: 0x488
// Size: 0x2c
function function_f20b84a9() {
    level waittill(#"hash_ca50f688");
    music::setmusicstate("demo_scene");
}

// Namespace namespace_a6a248fc
// Params 0, eflags: 0x0
// Checksum 0xe692bc29, Offset: 0x4c0
// Size: 0x2c
function function_9f04a172() {
    level waittill(#"hash_e6e1d572");
    music::setmusicstate("post_demo_igc");
}

// Namespace namespace_a6a248fc
// Params 0, eflags: 0x0
// Checksum 0xf9afa6af, Offset: 0x4f8
// Size: 0x1c
function function_1912af43() {
    music::setmusicstate("dark_alley_ambient");
}

// Namespace namespace_a6a248fc
// Params 0, eflags: 0x0
// Checksum 0x74fbaa02, Offset: 0x520
// Size: 0x1c
function function_767cbb3e() {
    music::setmusicstate("dark_alley_battle");
}

// Namespace namespace_a6a248fc
// Params 0, eflags: 0x0
// Checksum 0x6ad0c6e2, Offset: 0x548
// Size: 0x24
function function_6b994041() {
    wait 5;
    music::setmusicstate("crashed_vtol_checkpoint");
}

// Namespace namespace_a6a248fc
// Params 0, eflags: 0x0
// Checksum 0xd532a55c, Offset: 0x578
// Size: 0x24
function function_bb3105cf() {
    wait 5;
    music::setmusicstate("crashed_vtol");
}

// Namespace namespace_a6a248fc
// Params 0, eflags: 0x0
// Checksum 0x4eb8c25e, Offset: 0x5a8
// Size: 0x1c
function function_63054139() {
    music::setmusicstate("quad_tank_boss");
}

// Namespace namespace_a6a248fc
// Params 0, eflags: 0x0
// Checksum 0xb2205ab4, Offset: 0x5d0
// Size: 0x1c
function function_ff483e3c() {
    music::setmusicstate("outro");
}

// Namespace namespace_a6a248fc
// Params 0, eflags: 0x0
// Checksum 0xacf5c609, Offset: 0x5f8
// Size: 0x1c
function function_973b77f9() {
    music::setmusicstate("none");
}

// Namespace namespace_a6a248fc
// Params 0, eflags: 0x0
// Checksum 0x567d47c5, Offset: 0x620
// Size: 0x1c
function function_19e0cb0e() {
    music::setmusicstate("vtol_quad_stinger");
}

// Namespace namespace_a6a248fc
// Params 0, eflags: 0x0
// Checksum 0x9a8102de, Offset: 0x648
// Size: 0xf0
function function_bd60b52a() {
    level endon(#"hash_44ba5526");
    while (true) {
        wait randomintrange(2, 4);
        playsoundatposition("vox_egym0_action_reloading", (-36, -20633, 477));
        wait 3;
        playsoundatposition("vox_egym1_action_reloading_response", (-36, -20633, 477));
        wait 5;
        playsoundatposition("vox_egym1_action_blindfire", (-36, -20633, 477));
        wait 4;
        playsoundatposition("vox_egym1_action_flanked", (-36, -20633, 477));
    }
}

// Namespace namespace_a6a248fc
// Params 0, eflags: 0x0
// Checksum 0xa3b8a27b, Offset: 0x740
// Size: 0xd4
function function_98c9ec2a() {
    if (!isdefined(level.var_4ca1964e)) {
        level.var_4ca1964e = spawn("script_origin", (9264, -14929, 888));
    }
    wait 1;
    playsoundatposition("wpn_dead_fire_start_cin", level.var_4ca1964e.origin);
    wait 0.5;
    level.var_4ca1964e playloopsound("wpn_dead_fire_loop_cin");
    wait 2;
    level.var_4ca1964e stoploopsound();
    wait 4;
    level.var_4ca1964e delete();
}

