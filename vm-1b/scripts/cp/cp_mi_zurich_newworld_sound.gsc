#using scripts/codescripts/struct;
#using scripts/cp/voice/voice_newworld;
#using scripts/shared/music_shared;

#namespace cp_mi_zurich_newworld_sound;

// Namespace cp_mi_zurich_newworld_sound
// Params 0, eflags: 0x0
// Checksum 0x4284691f, Offset: 0x230
// Size: 0x42
function main() {
    voice_newworld::init_voice();
    level thread function_9c5a4eb0();
    level thread function_9c09862a();
    level thread function_3c510972();
}

// Namespace cp_mi_zurich_newworld_sound
// Params 0, eflags: 0x0
// Checksum 0xb0cbe567, Offset: 0x280
// Size: 0x22
function function_9c5a4eb0() {
    level waittill(#"hash_d195be99");
    wait 2;
    music::setmusicstate("brave");
}

// Namespace cp_mi_zurich_newworld_sound
// Params 0, eflags: 0x0
// Checksum 0x9cbd3a21, Offset: 0x2b0
// Size: 0x22
function function_9c09862a() {
    level waittill(#"hash_ddeafd5d");
    music::setmusicstate("intro");
}

// Namespace cp_mi_zurich_newworld_sound
// Params 0, eflags: 0x0
// Checksum 0xac9f3b68, Offset: 0x2e0
// Size: 0x22
function function_3c510972() {
    level waittill(#"hash_79929eec");
    wait 3;
    music::setmusicstate("hall_introduction");
}

#namespace namespace_e38c3c58;

// Namespace namespace_e38c3c58
// Params 0, eflags: 0x0
// Checksum 0x6d651599, Offset: 0x310
// Size: 0x1a
function function_973b77f9() {
    music::setmusicstate("none");
}

// Namespace namespace_e38c3c58
// Params 0, eflags: 0x0
// Checksum 0xa825451, Offset: 0x338
// Size: 0x1a
function function_d942ea3b() {
    music::setmusicstate("subway_tension_loop");
}

// Namespace namespace_e38c3c58
// Params 0, eflags: 0x0
// Checksum 0x952db304, Offset: 0x360
// Size: 0x1a
function function_71fee4f3() {
    music::setmusicstate("brave_hallway");
}

// Namespace namespace_e38c3c58
// Params 0, eflags: 0x0
// Checksum 0xbd7d8c09, Offset: 0x388
// Size: 0x1a
function function_68f4508b() {
    music::setmusicstate("brave_big_room");
}

// Namespace namespace_e38c3c58
// Params 0, eflags: 0x0
// Checksum 0x43256471, Offset: 0x3b0
// Size: 0x1a
function function_d4def1a6() {
    music::setmusicstate("brave_post_hallway");
}

// Namespace namespace_e38c3c58
// Params 0, eflags: 0x0
// Checksum 0x7c431ebc, Offset: 0x3d8
// Size: 0x1a
function function_964ce03c() {
    music::setmusicstate("hack");
}

// Namespace namespace_e38c3c58
// Params 0, eflags: 0x0
// Checksum 0x8094331, Offset: 0x400
// Size: 0x1a
function function_fa2e45b8() {
    music::setmusicstate("battle_1");
}

// Namespace namespace_e38c3c58
// Params 0, eflags: 0x0
// Checksum 0x80cfe203, Offset: 0x428
// Size: 0x1a
function function_606b7b8() {
    music::setmusicstate("chase");
}

// Namespace namespace_e38c3c58
// Params 0, eflags: 0x0
// Checksum 0x74b7d3ce, Offset: 0x450
// Size: 0x1a
function function_f4a6634b() {
    music::setmusicstate("brain_suck");
}

// Namespace namespace_e38c3c58
// Params 0, eflags: 0x0
// Checksum 0x8eba2401, Offset: 0x478
// Size: 0x1a
function function_92eefdb3() {
    music::setmusicstate("diaz_wall_training");
}

// Namespace namespace_e38c3c58
// Params 0, eflags: 0x0
// Checksum 0x5c04a5d6, Offset: 0x4a0
// Size: 0x1a
function function_d8182956() {
    music::setmusicstate("diaz_drone_training");
}

// Namespace namespace_e38c3c58
// Params 0, eflags: 0x0
// Checksum 0xaebaa702, Offset: 0x4c8
// Size: 0x1a
function function_ccafa212() {
    music::setmusicstate("foundry_battle");
}

// Namespace namespace_e38c3c58
// Params 0, eflags: 0x0
// Checksum 0xed06bf81, Offset: 0x4f0
// Size: 0x1a
function function_bb8ce831() {
    music::setmusicstate("tension_loop_1");
}

// Namespace namespace_e38c3c58
// Params 0, eflags: 0x0
// Checksum 0x3fef499f, Offset: 0x518
// Size: 0x1a
function function_57c68b7b() {
    wait 3;
    music::setmusicstate("inside_man");
}

// Namespace namespace_e38c3c58
// Params 0, eflags: 0x0
// Checksum 0x5c64971, Offset: 0x540
// Size: 0x1a
function function_a99be221() {
    music::setmusicstate("train_battle");
}

// Namespace namespace_e38c3c58
// Params 0, eflags: 0x0
// Checksum 0xe0403c20, Offset: 0x568
// Size: 0x1a
function function_922297e3() {
    music::setmusicstate("bomb_disarm");
}

// Namespace namespace_e38c3c58
// Params 0, eflags: 0x0
// Checksum 0x77205247, Offset: 0x590
// Size: 0x1a
function function_9c65cf9a() {
    music::setmusicstate("wake_up");
}

// Namespace namespace_e38c3c58
// Params 0, eflags: 0x0
// Checksum 0x9cf3f83a, Offset: 0x5b8
// Size: 0x1a
function function_a693b757() {
    music::setmusicstate("interface");
}

// Namespace namespace_e38c3c58
// Params 0, eflags: 0x0
// Checksum 0xf65bc851, Offset: 0x5e0
// Size: 0x1a
function function_57a2519c() {
    music::setmusicstate("none");
}

// Namespace namespace_e38c3c58
// Params 0, eflags: 0x0
// Checksum 0xaef9bd38, Offset: 0x608
// Size: 0xba
function function_5a7ad30() {
    if (!isdefined(level.var_485316b5)) {
        level.var_485316b5 = spawn("script_origin", (-25886, 39179, 4219));
    }
    wait 5;
    level.var_485316b5 playloopsound("vox_civ_train_walla");
    level waittill(#"panic");
    level.var_485316b5 stoploopsound();
    level.var_485316b5 playloopsound("vox_civ_panic_train");
    level waittill(#"hash_a0228009");
    level.var_485316b5 stoploopsound();
}

// Namespace namespace_e38c3c58
// Params 0, eflags: 0x0
// Checksum 0x8ef3d77d, Offset: 0x6d0
// Size: 0x92
function function_c132cd41() {
    if (!isdefined(level.var_de0151a7)) {
        level.var_de0151a7 = spawn("script_origin", (-26271, 15583, 4212));
    }
    level.var_de0151a7 playloopsound("amb_train_interior_ending");
    level waittill(#"hash_c053b2ca");
    level.var_de0151a7 stoploopsound(1);
    wait 1;
    level.var_de0151a7 delete();
}

