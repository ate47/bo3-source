#using scripts/codescripts/struct;
#using scripts/cp/voice/voice_ramses;
#using scripts/cp/voice/voice_ramses2;
#using scripts/shared/flag_shared;
#using scripts/shared/music_shared;
#using scripts/shared/util_shared;

#namespace cp_mi_cairo_ramses2_sound;

// Namespace cp_mi_cairo_ramses2_sound
// Params 0, eflags: 0x0
// Checksum 0x8d04c8cc, Offset: 0x2e0
// Size: 0x72
function main() {
    voice_ramses::init_voice();
    voice_ramses2::init_voice();
    level thread function_6a579aa5("sndOutroFoley", "outrofoley", "sndOutro", "outroduck");
    level thread namespace_a6a248fc::function_f20b84a9();
    level thread namespace_a6a248fc::function_9f04a172();
}

// Namespace cp_mi_cairo_ramses2_sound
// Params 4, eflags: 0x0
// Checksum 0x85f439be, Offset: 0x360
// Size: 0x52
function function_6a579aa5(arg1, arg2, arg3, arg4) {
    level waittill(arg1);
    level util::clientnotify(arg2);
    level waittill(arg3);
    level util::clientnotify(arg4);
}

#namespace namespace_a6a248fc;

// Namespace namespace_a6a248fc
// Params 0, eflags: 0x0
// Checksum 0x780b25a1, Offset: 0x3c0
// Size: 0x1a
function function_1e7ee1cd() {
    music::setmusicstate("jeep_drive");
}

// Namespace namespace_a6a248fc
// Params 0, eflags: 0x0
// Checksum 0x94ff5583, Offset: 0x3e8
// Size: 0x1a
function function_37e13caa() {
    music::setmusicstate("jeep_drive_short");
}

// Namespace namespace_a6a248fc
// Params 0, eflags: 0x0
// Checksum 0x962efbc4, Offset: 0x410
// Size: 0x1a
function function_9574e08d() {
    music::setmusicstate("spike_launch_arena");
}

// Namespace namespace_a6a248fc
// Params 0, eflags: 0x0
// Checksum 0xe57d0906, Offset: 0x438
// Size: 0x1a
function function_7b69c801() {
    music::setmusicstate("retreat");
}

// Namespace namespace_a6a248fc
// Params 0, eflags: 0x0
// Checksum 0x64b34a12, Offset: 0x460
// Size: 0x22
function function_f20b84a9() {
    level waittill(#"hash_ca50f688");
    music::setmusicstate("demo_scene");
}

// Namespace namespace_a6a248fc
// Params 0, eflags: 0x0
// Checksum 0x72ef4832, Offset: 0x490
// Size: 0x22
function function_9f04a172() {
    level waittill(#"hash_e6e1d572");
    music::setmusicstate("post_demo_igc");
}

// Namespace namespace_a6a248fc
// Params 0, eflags: 0x0
// Checksum 0x671c190b, Offset: 0x4c0
// Size: 0x1a
function function_1912af43() {
    music::setmusicstate("dark_alley_ambient");
}

// Namespace namespace_a6a248fc
// Params 0, eflags: 0x0
// Checksum 0x7681de80, Offset: 0x4e8
// Size: 0x1a
function function_767cbb3e() {
    music::setmusicstate("dark_alley_battle");
}

// Namespace namespace_a6a248fc
// Params 0, eflags: 0x0
// Checksum 0x58d25c63, Offset: 0x510
// Size: 0x1a
function function_6b994041() {
    wait 5;
    music::setmusicstate("crashed_vtol_checkpoint");
}

// Namespace namespace_a6a248fc
// Params 0, eflags: 0x0
// Checksum 0x4d66ff67, Offset: 0x538
// Size: 0x1a
function function_bb3105cf() {
    wait 5;
    music::setmusicstate("crashed_vtol");
}

// Namespace namespace_a6a248fc
// Params 0, eflags: 0x0
// Checksum 0x217ba05c, Offset: 0x560
// Size: 0x1a
function function_63054139() {
    music::setmusicstate("quad_tank_boss");
}

// Namespace namespace_a6a248fc
// Params 0, eflags: 0x0
// Checksum 0x677ce5db, Offset: 0x588
// Size: 0x1a
function function_ff483e3c() {
    music::setmusicstate("outro");
}

// Namespace namespace_a6a248fc
// Params 0, eflags: 0x0
// Checksum 0xf826e452, Offset: 0x5b0
// Size: 0x1a
function function_973b77f9() {
    music::setmusicstate("none");
}

// Namespace namespace_a6a248fc
// Params 0, eflags: 0x0
// Checksum 0xed5d6093, Offset: 0x5d8
// Size: 0x1a
function function_19e0cb0e() {
    music::setmusicstate("vtol_quad_stinger");
}

// Namespace namespace_a6a248fc
// Params 0, eflags: 0x0
// Checksum 0x9fea2fd0, Offset: 0x600
// Size: 0xa5
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
// Checksum 0xa4f165d0, Offset: 0x6b0
// Size: 0xba
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

