#using scripts/cp/_util;
#using scripts/cp/_spawn_manager;
#using scripts/cp/_skipto;
#using scripts/cp/_oed;
#using scripts/cp/_objectives;
#using scripts/cp/_load;
#using scripts/cp/_debug;
#using scripts/shared/ai/robot_phalanx;
#using scripts/shared/flagsys_shared;
#using scripts/shared/lui_shared;
#using scripts/shared/math_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/colors_shared;
#using scripts/shared/ai_shared;
#using scripts/shared/vehicle_shared;
#using scripts/shared/util_shared;
#using scripts/shared/trigger_shared;
#using scripts/shared/system_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/laststand_shared;
#using scripts/shared/gameobjects_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/compass;
#using scripts/shared/clientfield_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/array_shared;
#using scripts/codescripts/struct;

#namespace namespace_391e4301;

// Namespace namespace_391e4301
// Params 0, eflags: 0x2
// Checksum 0xa5325e9e, Offset: 0xb68
// Size: 0x2a
function autoexec function_2dc19561() {
    system::register("ramses_util", &__init__, undefined, undefined);
}

// Namespace namespace_391e4301
// Params 0, eflags: 0x0
// Checksum 0x43e5b89f, Offset: 0xba0
// Size: 0x9
function __init__() {
    // Can't decompile export namespace_391e4301::__init__ Unknown operator 0xe2
}

// Namespace namespace_391e4301
// Params 0, eflags: 0x0
// Checksum 0x65dc76e9, Offset: 0xc28
// Size: 0x3
function is_demo() {
    // Can't decompile export namespace_391e4301::is_demo Unknown operator 0x76
}

// Namespace namespace_391e4301
// Params 0, eflags: 0x0
// Checksum 0x759ea94e, Offset: 0xc50
// Size: 0x1b
function function_22e1a261() {
    // Can't decompile export namespace_391e4301::function_22e1a261 Unknown operator 0xd4
}

// Namespace namespace_391e4301
// Params 0, eflags: 0x0
// Checksum 0x669ad3a9, Offset: 0xcd0
// Size: 0x32
function function_8a9650aa() {
    // Can't decompile export namespace_391e4301::function_8a9650aa Unknown operator 0xfa
}

// Namespace namespace_391e4301
// Params 1, eflags: 0x0
// Checksum 0x3ef7c8cf, Offset: 0xd98
// Size: 0x32
function function_c3080ff8(b_enable) {
    // Can't decompile export namespace_391e4301::function_c3080ff8 Unknown operator 0x5d
}

// Namespace namespace_391e4301
// Params 0, eflags: 0x0
// Checksum 0x7c1be80e, Offset: 0xe50
// Size: 0xba
function function_1903e7dc() {
    hidemiscmodels("arena_billboard_static2");
    hidemiscmodels("arena_billboard_02_static2");
    hidemiscmodels("cinema_collapse_static2");
    hidemiscmodels("quadtank_statue_static2");
    hidemiscmodels("rocket_static2");
    hidemiscmodels("glass_building_static2");
    hidemiscmodels("wall_collapse_static2");
    function_2f9e262a();
}

// Namespace namespace_391e4301
// Params 0, eflags: 0x0
// Checksum 0xa6ba61ac, Offset: 0xf18
// Size: 0x312
function function_2f9e262a() {
    scene::add_scene_func("p7_fxanim_cp_ramses_arena_billboard_bundle", &function_1c347e72, "init", "arena_billboard_static1");
    scene::add_scene_func("p7_fxanim_cp_ramses_arena_billboard_bundle", &function_a72c2dda, "done", "arena_billboard_static2");
    scene::add_scene_func("p7_fxanim_cp_ramses_arena_billboard_02_bundle", &function_1c347e72, "init", "arena_billboard_02_static1");
    scene::add_scene_func("p7_fxanim_cp_ramses_arena_billboard_02_bundle", &function_a72c2dda, "done", "arena_billboard_02_static2");
    scene::add_scene_func("p7_fxanim_cp_ramses_cinema_collapse_bundle", &function_1c347e72, "init", "cinema_collapse_static1");
    scene::add_scene_func("p7_fxanim_cp_ramses_cinema_collapse_bundle", &function_a72c2dda, "done", "cinema_collapse_static2");
    scene::add_scene_func("p7_fxanim_cp_ramses_quadtank_statue_bundle", &function_1c347e72, "init", "quadtank_statue_static1");
    scene::add_scene_func("p7_fxanim_cp_ramses_quadtank_statue_bundle", &function_a72c2dda, "done", "quadtank_statue_static2");
    scene::add_scene_func("p7_fxanim_cp_ramses_quadtank_plaza_building_rocket_bundle", &function_1c347e72, "init", "rocket_static1");
    scene::add_scene_func("p7_fxanim_cp_ramses_quadtank_plaza_building_rocket_bundle", &function_a72c2dda, "done", "rocket_static2");
    scene::add_scene_func("p7_fxanim_cp_ramses_quadtank_plaza_glass_building_bundle", &function_1c347e72, "init", "glass_building_static1");
    scene::add_scene_func("p7_fxanim_cp_ramses_quadtank_plaza_glass_building_bundle", &function_a72c2dda, "done", "glass_building_static2");
    scene::add_scene_func("p7_fxanim_cp_ramses_qt_plaza_palace_wall_collapse_bundle", &function_1c347e72, "init", "wall_collapse_static1");
    scene::add_scene_func("p7_fxanim_cp_ramses_qt_plaza_palace_wall_collapse_bundle", &function_a72c2dda, "done", "wall_collapse_static2");
}

// Namespace namespace_391e4301
// Params 2, eflags: 0x0
// Checksum 0xea6202eb, Offset: 0x1238
// Size: 0x13
function function_1c347e72(a_ents, str_targetname) {
    // Can't decompile export namespace_391e4301::function_1c347e72 Unknown operator 0x5d
}

// Namespace namespace_391e4301
// Params 2, eflags: 0x0
// Checksum 0x4f019617, Offset: 0x1268
// Size: 0x33
function function_a72c2dda(a_ents, str_targetname) {
    // Can't decompile export namespace_391e4301::function_a72c2dda Unknown operator 0x5d
}

// Namespace namespace_391e4301
// Params 0, eflags: 0x0
// Checksum 0xd62d7aec, Offset: 0x1310
// Size: 0x54
function function_a0a9f927() {
    // Can't decompile export namespace_391e4301::function_a0a9f927 Unknown operator 0x5d
}

// Namespace namespace_391e4301
// Params 1, eflags: 0x0
// Checksum 0xf5a04e92, Offset: 0x13e0
// Size: 0x13
function function_a4998afa(var_5dbde88f) {
    // Can't decompile export namespace_391e4301::function_a4998afa Unknown operator 0xe2
}

// Namespace namespace_391e4301
// Params 0, eflags: 0x0
// Checksum 0x83d35c6f, Offset: 0x1428
// Size: 0x31
function function_f81a38c8() {
    // Can't decompile export namespace_391e4301::function_f81a38c8 Unknown operator 0x5d
}

// Namespace namespace_391e4301
// Params 1, eflags: 0x0
// Checksum 0x5293677, Offset: 0x14b8
// Size: 0xa
function function_e7ebe596(b_on) {
    // Can't decompile export namespace_391e4301::function_e7ebe596 Unknown operator 0x5d
}

// Namespace namespace_391e4301
// Params 2, eflags: 0x0
// Checksum 0xaecf67e7, Offset: 0x14d8
// Size: 0x12
function function_9f4f118(str_value, str_key) {
    // Can't decompile export namespace_391e4301::function_9f4f118 Unknown operator 0x5d
}

// Namespace namespace_391e4301
// Params 2, eflags: 0x0
// Checksum 0x8a259cf4, Offset: 0x1520
// Size: 0x43
function function_db4d0261(str_value, str_key) {
    // Can't decompile export namespace_391e4301::function_db4d0261 Unknown operator 0x5d
}

// Namespace namespace_391e4301
// Params 1, eflags: 0x0
// Checksum 0x51a5b069, Offset: 0x15d8
// Size: 0x7a
function function_d4a0bb54(var_5d2441df) {
    // Can't decompile export namespace_391e4301::function_d4a0bb54 Unknown operator 0x5d
}

// Namespace namespace_391e4301
// Params 0, eflags: 0x0
// Checksum 0x71d46675, Offset: 0x1888
// Size: 0x29
function function_37357151() {
    // Can't decompile export namespace_391e4301::function_37357151 Unknown operator 0xd4
}

// Namespace namespace_391e4301
// Params 1, eflags: 0x0
// Checksum 0xd8e0094f, Offset: 0x1928
// Size: 0x42
function hide_ents(var_46b6a64a) {
    // Can't decompile export namespace_391e4301::hide_ents Unknown operator 0x5d
}

// Namespace namespace_391e4301
// Params 1, eflags: 0x0
// Checksum 0xd8dab248, Offset: 0x1a08
// Size: 0x42
function show_ents(var_29cfceb6) {
    // Can't decompile export namespace_391e4301::show_ents Unknown operator 0x5d
}

// Namespace namespace_391e4301
// Params 0, eflags: 0x0
// Checksum 0xa2f4c292, Offset: 0x1b98
// Size: 0x3a
function function_c3458a6() {
    // Can't decompile export namespace_391e4301::function_c3458a6 Unknown operator 0x76
}

// Namespace namespace_391e4301
// Params 1, eflags: 0x0
// Checksum 0xfea37ad4, Offset: 0x1c90
// Size: 0x5a
function function_41f6f501(b_moving) {
    // Can't decompile export namespace_391e4301::function_41f6f501 Unknown operator 0x4a
}

// Namespace namespace_391e4301
// Params 1, eflags: 0x0
// Checksum 0x30e5e2c9, Offset: 0x1d98
// Size: 0x5a
function make_solid(b_moving) {
    // Can't decompile export namespace_391e4301::make_solid Unknown operator 0x73
}

// Namespace namespace_391e4301
// Params 2, eflags: 0x0
// Checksum 0x3900ae0e, Offset: 0x1ea0
// Size: 0x92
function set_visible(var_32c6c398, b_visible) {
    // Can't decompile export namespace_391e4301::set_visible Unknown operator 0x5d
}

// Namespace namespace_391e4301
// Params 2, eflags: 0x0
// Checksum 0x9d3cfc91, Offset: 0x2068
// Size: 0x42
function function_ad67ec60(var_e59ce4f8, var_c487ec13) {
    // Can't decompile export namespace_391e4301::function_ad67ec60 Unknown operator 0x5d
}

// Namespace namespace_391e4301
// Params 1, eflags: 0x0
// Checksum 0x311f83, Offset: 0x21d0
// Size: 0x41
function function_fc0b27df(var_1b7b3a6) {
    // Can't decompile export namespace_391e4301::function_fc0b27df Unknown operator 0xdd
}

// Namespace namespace_391e4301
// Params 1, eflags: 0x0
// Checksum 0xe81c870d, Offset: 0x2250
// Size: 0x32
function function_bd4d52fa(var_1b7b3a6) {
    // Can't decompile export namespace_391e4301::function_bd4d52fa Unknown operator 0xc0
}

// Namespace namespace_391e4301
// Params 0, eflags: 0x0
// Checksum 0x7befb5b7, Offset: 0x22d0
// Size: 0x1a
function function_c2712461() {
    // Can't decompile export namespace_391e4301::function_c2712461 jump with invalid delta: 0x53ed
}

// Namespace namespace_391e4301
// Params 0, eflags: 0x0
// Checksum 0xcf188d4c, Offset: 0x23a0
// Size: 0x19
function function_780e57a1() {
    // Can't decompile export namespace_391e4301::function_780e57a1 Unknown operator 0xd4
}

// Namespace namespace_391e4301
// Params 0, eflags: 0x0
// Checksum 0xd26a79e0, Offset: 0x2468
// Size: 0x37
function function_25439df2() {
    // Can't decompile export namespace_391e4301::function_25439df2 Unknown operator 0x5d
}

// Namespace namespace_391e4301
// Params 3, eflags: 0x0
// Checksum 0x18d3c839, Offset: 0x2548
// Size: 0x22
function function_486f25d(var_86b557eb, var_745f5923, var_637003f5) {
    // Can't decompile export namespace_391e4301::function_486f25d Unknown operator 0x5d
}

// Namespace namespace_391e4301
// Params 2, eflags: 0x0
// Checksum 0x6065e546, Offset: 0x2640
// Size: 0x3a
function function_411dc61b(n_base, var_df47d27) {
    // Can't decompile export namespace_391e4301::function_411dc61b Unknown operator 0x5d
}

// Namespace namespace_391e4301
// Params 0, eflags: 0x0
// Checksum 0x3c06818e, Offset: 0x26c8
// Size: 0xa
function function_d4b64a0d() {
    // Can't decompile export namespace_391e4301::function_d4b64a0d Unknown operator 0x76
}

// Namespace namespace_391e4301
// Params 0, eflags: 0x0
// Checksum 0xdc861ba, Offset: 0x2700
// Size: 0x12
function function_44514fc0() {
    // Can't decompile export namespace_391e4301::function_44514fc0 Unknown operator 0x1c
}

// Namespace namespace_391e4301
// Params 1, eflags: 0x0
// Checksum 0xea87100d, Offset: 0x27a0
// Size: 0x1a
function kill_players(str_notify) {
    // Can't decompile export namespace_391e4301::kill_players Unknown operator 0x5d
}

// Namespace namespace_391e4301
// Params 0, eflags: 0x0
// Checksum 0x9b55e0b9, Offset: 0x2840
// Size: 0x12
function function_16ccc3fd() {
    // Can't decompile export namespace_391e4301::function_16ccc3fd Unknown operator 0xe2
}

// Namespace namespace_391e4301
// Params 2, eflags: 0x0
// Checksum 0x4c3a51b5, Offset: 0x28b8
// Size: 0x22
function function_7129cde6(str_endon, n_radius) {
    // Can't decompile export namespace_391e4301::function_7129cde6 Unknown operator 0x5d
}

// Namespace namespace_391e4301
// Params 6, eflags: 0x0
// Checksum 0xf5f20c10, Offset: 0x2998
// Size: 0x5a
function function_a700a8ea(var_a9ea049a, str_key, var_c3e600e3, var_c4a1b346, str_endon, var_53af6159) {
    // Can't decompile export namespace_391e4301::function_a700a8ea Unknown operator 0x5d
}

// Namespace namespace_391e4301
// Params 1, eflags: 0x0
// Checksum 0xf453e829, Offset: 0x2b88
// Size: 0x12
function function_1321e32f(str_endon) {
    // Can't decompile export namespace_391e4301::function_1321e32f Unknown operator 0x5d
}

// Namespace namespace_391e4301
// Params 10, eflags: 0x0
// Checksum 0x5746ccf0, Offset: 0x2c30
// Size: 0x6a
function function_e7fdcb95(var_2c34daa1, var_6fc1c7c6, var_f67c8a8e, var_bf7b0d42, var_7b2612a, var_a20f0ddd, var_71637749, var_4cfaa23a, var_381b2f34, var_42e6f5b4) {
    // Can't decompile export namespace_391e4301::function_e7fdcb95 Unknown operator 0x5d
}

// Namespace namespace_391e4301
// Params 4, eflags: 0x0
// Checksum 0xdee93334, Offset: 0x2db0
// Size: 0x3a
function function_e0927f44(str_key, str_value, n_max, n_min) {
    // Can't decompile export namespace_391e4301::function_e0927f44 Unknown operator 0x5d
}

// Namespace namespace_391e4301
// Params 2, eflags: 0x0
// Checksum 0xc7e70c44, Offset: 0x2eb0
// Size: 0x13
function function_cf956358(str_flag, func) {
    // Can't decompile export namespace_391e4301::function_cf956358 Unknown operator 0x5d
}

// Namespace namespace_391e4301
// Params 0, eflags: 0x0
// Checksum 0x87d0598c, Offset: 0x2ee8
// Size: 0x64
function function_5ad47384() {
    // Can't decompile export namespace_391e4301::function_5ad47384 Unknown operator 0x5d
}

// Namespace namespace_391e4301
// Params 6, eflags: 0x0
// Checksum 0x1ebdf5d5, Offset: 0x3008
// Size: 0x32
function function_b0369bfa(str_flag, str_scene, n_delay, n_wait, var_e21d36a, str_endon) {
    // Can't decompile export namespace_391e4301::function_b0369bfa Unknown operator 0x5d
}

// Namespace namespace_391e4301
// Params 2, eflags: 0x0
// Checksum 0xa2c296a5, Offset: 0x30e0
// Size: 0x12
function function_d0d2f172(str_scene, str_notify) {
    // Can't decompile export namespace_391e4301::function_d0d2f172 Unknown operator 0x67
}

// Namespace namespace_391e4301
// Params 3, eflags: 0x0
// Checksum 0xb5a92567, Offset: 0x3158
// Size: 0x2b
function function_4a1e5496(anim_name, str_scene, str_notetrack) {
    // Can't decompile export namespace_391e4301::function_4a1e5496 Unknown operator 0x5d
}

// Namespace namespace_391e4301
// Params 2, eflags: 0x0
// Checksum 0xde2f507a, Offset: 0x31f0
// Size: 0x12
function function_3bc57aa8(a_ents, b_enable) {
    // Can't decompile export namespace_391e4301::function_3bc57aa8 Unknown operator 0x5d
}

// Namespace namespace_391e4301
// Params 3, eflags: 0x0
// Checksum 0x485d6c24, Offset: 0x3280
// Size: 0x42
function function_3f4f84e(str_key, str_val, b_enable) {
    // Can't decompile export namespace_391e4301::function_3f4f84e Unknown operator 0x5d
}

// Namespace namespace_391e4301
// Params 3, eflags: 0x0
// Checksum 0xd5071ec3, Offset: 0x3340
// Size: 0x5a
function function_8bf0b925(str_key, str_val, b_link) {
    // Can't decompile export namespace_391e4301::function_8bf0b925 Unknown operator 0x5d
}

// Namespace namespace_391e4301
// Params 3, eflags: 0x0
// Checksum 0x2f29e5de, Offset: 0x3448
// Size: 0x22
function function_508a129e(str_notify, n_time, var_45778f27) {
    // Can't decompile export namespace_391e4301::function_508a129e Unknown operator 0x5d
}

// Namespace namespace_391e4301
// Params 1, eflags: 0x0
// Checksum 0xe3475bf3, Offset: 0x3568
// Size: 0x44
function has_weapon(var_205ff529) {
    // Can't decompile export namespace_391e4301::has_weapon Unknown operator 0x5d
}

// Namespace namespace_391e4301
// Params 1, eflags: 0x0
// Checksum 0x437f9340, Offset: 0x35f0
// Size: 0x1a
function function_8806ea73(str_weapon) {
    // Can't decompile export namespace_391e4301::function_8806ea73 Unknown operator 0x5d
}

// Namespace namespace_391e4301
// Params 1, eflags: 0x0
// Checksum 0x19d2bd40, Offset: 0x3628
// Size: 0xa
function function_2de69092(e) {
    // Can't decompile export namespace_391e4301::function_2de69092 Unknown operator 0x67
}

// Namespace namespace_391e4301
// Params 3, eflags: 0x0
// Checksum 0xa3c146f, Offset: 0x36a8
// Size: 0x22
function function_fd1e50c8(target, n_timer, var_5b3dd4e) {
    // Can't decompile export namespace_391e4301::function_fd1e50c8 Unknown operator 0x67
}

// Namespace namespace_391e4301
// Params 1, eflags: 0x0
// Checksum 0xf4d29d8, Offset: 0x3770
// Size: 0xa
function function_8a8944d6(var_133e9095) {
    // Can't decompile export namespace_391e4301::function_8a8944d6 Unknown operator 0x67
}

// Namespace namespace_391e4301
// Params 0, eflags: 0x0
// Checksum 0x31dac676, Offset: 0x3830
// Size: 0x21
function function_a0731cf9() {
    // Can't decompile export namespace_391e4301::function_a0731cf9 Unknown operator 0xd4
}

// Namespace namespace_391e4301
// Params 0, eflags: 0x0
// Checksum 0x5055f727, Offset: 0x3888
// Size: 0x21
function function_1b048d07() {
    // Can't decompile export namespace_391e4301::function_1b048d07 Unknown operator 0xd4
}

// Namespace namespace_391e4301
// Params 1, eflags: 0x0
// Checksum 0x31caf7b4, Offset: 0x38e0
// Size: 0xa
function function_e950228a(b_on) {
    // Can't decompile export namespace_391e4301::function_e950228a Unknown operator 0x5d
}

// Namespace namespace_391e4301
// Params 0, eflags: 0x0
// Checksum 0x3949d528, Offset: 0x3938
// Size: 0x21
function function_39044e10() {
    // Can't decompile export namespace_391e4301::function_39044e10 Unknown operator 0xd4
}

// Namespace namespace_391e4301
// Params 0, eflags: 0x0
// Checksum 0xfeccb39a, Offset: 0x3998
// Size: 0x12
function function_ff06e7ac() {
    // Can't decompile export namespace_391e4301::function_ff06e7ac Unknown operator 0xfa
}

// Namespace namespace_391e4301
// Params 0, eflags: 0x0
// Checksum 0xbd8f1fbe, Offset: 0x3a20
// Size: 0x2
function function_9c087de1() {
    // Can't decompile export namespace_391e4301::function_9c087de1 Unknown operator 0xe2
}

// Namespace namespace_391e4301
// Params 0, eflags: 0x0
// Checksum 0x381d6a55, Offset: 0x3a58
// Size: 0x2
function function_c20af84a() {
    // Can't decompile export namespace_391e4301::function_c20af84a Unknown operator 0xe2
}

// Namespace namespace_391e4301
// Params 0, eflags: 0x0
// Checksum 0xf14fdacd, Offset: 0x3a90
// Size: 0x2
function function_75734d29() {
    // Can't decompile export namespace_391e4301::function_75734d29 Unknown operator 0xe2
}

// Namespace namespace_391e4301
// Params 1, eflags: 0x0
// Checksum 0x70aff7b5, Offset: 0x3ac8
// Size: 0x2b
function function_8264a5e8(n_value) {
    // Can't decompile export namespace_391e4301::function_8264a5e8 Unknown operator 0xd4
}

// Namespace namespace_391e4301
// Params 3, eflags: 0x0
// Checksum 0x45e80c12, Offset: 0x3b98
// Size: 0x2a
function function_7df1bd5b(var_b22a2ac4, var_cc890dd4, var_db395c04) {
    // Can't decompile export namespace_391e4301::function_7df1bd5b Unknown operator 0x67
}

// Namespace namespace_391e4301
// Params 0, eflags: 0x0
// Checksum 0xce990f92, Offset: 0x3ca8
// Size: 0x2b
function function_eabc6e2f() {
    // Can't decompile export namespace_391e4301::function_eabc6e2f Unknown operator 0xe2
}

// Namespace namespace_391e4301
// Params 1, eflags: 0x0
// Checksum 0x3ce89216, Offset: 0x3da0
// Size: 0x33
function function_b0ef4ae7(s_obj) {
    // Can't decompile export namespace_391e4301::function_b0ef4ae7 Unknown operator 0x3a
}

// Namespace namespace_391e4301
// Params 2, eflags: 0x0
// Checksum 0x6e43df38, Offset: 0x3f88
// Size: 0x31
function function_a68414be(var_c0cba69a, w_hero) {
    // Can't decompile export namespace_391e4301::function_a68414be Unknown operator 0x5d
}

// Namespace namespace_391e4301
// Params 0, eflags: 0x0
// Checksum 0xff8ad357, Offset: 0x40c8
// Size: 0x11
function function_60a57ce() {
    // Can't decompile export namespace_391e4301::function_60a57ce Unknown operator 0x89
}

// Namespace namespace_391e4301
// Params 0, eflags: 0x0
// Checksum 0x86a8172c, Offset: 0x40e8
// Size: 0x11
function function_4e430da2() {
    // Can't decompile export namespace_391e4301::function_4e430da2 Unknown operator 0x89
}

// Namespace namespace_391e4301
// Params 0, eflags: 0x0
// Checksum 0x32a3cc9a, Offset: 0x4108
// Size: 0x25
function function_10c41a9d() {
    // Can't decompile export namespace_391e4301::function_10c41a9d Unknown operator 0x5d
}

// Namespace namespace_391e4301
// Params 3, eflags: 0x0
// Checksum 0x12bd664a, Offset: 0x4168
// Size: 0x23
function function_258b9bad(var_fcc15a0, var_1086d941, var_ed2ece1e) {
    // Can't decompile export namespace_391e4301::function_258b9bad Unknown operator 0xe2
}

// Namespace namespace_391e4301
// Params 2, eflags: 0x0
// Checksum 0x1b627868, Offset: 0x4218
// Size: 0x2b
function function_968476a4(var_fcc15a0, var_ed2ece1e) {
    // Can't decompile export namespace_391e4301::function_968476a4 Unknown operator 0x5d
}

// Namespace namespace_391e4301
// Params 2, eflags: 0x0
// Checksum 0x1ce16a7c, Offset: 0x42a0
// Size: 0x12
function function_f08afb37(b_on, var_eebad467) {
    // Can't decompile export namespace_391e4301::function_f08afb37 Unknown operator 0x5d
}

// Namespace namespace_391e4301
// Params 12, eflags: 0x0
// Checksum 0xf6fd106f, Offset: 0x4358
// Size: 0x63
function function_74e97bfe(e_inflictor, e_attacker, n_damage, n_dflags, str_means_of_death, str_weapon, v_point, v_dir, str_hit_loc, var_269779a, psoffsettime, var_fe8d5ebb) {
    // Can't decompile export namespace_391e4301::function_74e97bfe Unknown operator 0x5d
}

// Namespace namespace_391e4301
// Params 2, eflags: 0x0
// Checksum 0x718ed1b4, Offset: 0x4438
// Size: 0x13
function function_8afb19cc(var_786e88b6, var_f10f51ff) {
    // Can't decompile export namespace_391e4301::function_8afb19cc Unknown operator 0x5d
}

// Namespace namespace_391e4301
// Params 2, eflags: 0x0
// Checksum 0xdbd87cb9, Offset: 0x4488
// Size: 0x42
function function_19e59ba2(var_786e88b6, var_f10f51ff) {
    // Can't decompile export namespace_391e4301::function_19e59ba2 Unknown operator 0x98
}

// Namespace namespace_391e4301
// Params 2, eflags: 0x0
// Checksum 0xd6f5b3b5, Offset: 0x4588
// Size: 0x42
function function_fa89cc92(var_786e88b6, var_f10f51ff) {
    // Can't decompile export namespace_391e4301::function_fa89cc92 Unknown operator 0x98
}

// Namespace namespace_391e4301
// Params 7, eflags: 0x0
// Checksum 0x7a5f713, Offset: 0x4660
// Size: 0x162
function function_24b86d60(var_74b98fad, str_endon, n_dist_min, n_dist_max, var_cf8b7bc3, var_5276bdcd, var_d04843e1) {
    // Can't decompile export namespace_391e4301::function_24b86d60 Unknown operator 0x5d
}

// Namespace namespace_391e4301
// Params 1, eflags: 0x0
// Checksum 0x6a618ec7, Offset: 0x4da8
// Size: 0x32
function function_36bdd3e9(a_ents) {
    // Can't decompile export namespace_391e4301::function_36bdd3e9 Unknown operator 0x95
}

// Namespace namespace_391e4301
// Params 1, eflags: 0x0
// Checksum 0xa4fe892d, Offset: 0x4e28
// Size: 0x1a
function function_1fc93399(str_endon) {
    // Can't decompile export namespace_391e4301::function_1fc93399 Unknown operator 0x5d
}

// Namespace namespace_391e4301
// Params 1, eflags: 0x0
// Checksum 0x12d2decc, Offset: 0x4e88
// Size: 0x32
function function_47e62fcf(a_ents) {
    // Can't decompile export namespace_391e4301::function_47e62fcf Unknown operator 0x98
}

// Namespace namespace_391e4301
// Params 1, eflags: 0x0
// Checksum 0xa462fa1, Offset: 0x4f78
// Size: 0xa
function function_a9b807cc(n_hint_time) {
    // Can't decompile export namespace_391e4301::function_a9b807cc Unknown operator 0x5d
}

// Namespace namespace_391e4301
// Params 2, eflags: 0x0
// Checksum 0x9462e72b, Offset: 0x4fb8
// Size: 0x12
function function_ac2b4535(str_scene, str_teleport_name) {
    // Can't decompile export namespace_391e4301::function_ac2b4535 Unknown operator 0x67
}

// Namespace namespace_391e4301
// Params 1, eflags: 0x0
// Checksum 0xa31feabe, Offset: 0x5058
// Size: 0xa
function function_96861272(a_ents) {
    // Can't decompile export namespace_391e4301::function_96861272 Unknown operator 0x76
}

// Namespace namespace_391e4301
// Params 2, eflags: 0x0
// Checksum 0x1928a19e, Offset: 0x50b8
// Size: 0x4a
function function_cb1e4146(str_scene, str_teleport_name) {
    // Can't decompile export namespace_391e4301::function_cb1e4146 Unknown operator 0x5d
}

// Namespace namespace_391e4301
// Params 2, eflags: 0x0
// Checksum 0x4ac6e2e6, Offset: 0x51b8
// Size: 0x3a
function function_7255e66(b_enable, var_ca894d1c) {
    // Can't decompile export namespace_391e4301::function_7255e66 Unknown operator 0x5d
}

// Namespace namespace_391e4301
// Params 0, eflags: 0x0
// Checksum 0x28f7e0c6, Offset: 0x52f8
// Size: 0x2d
function function_f2f98cfc() {
    // Can't decompile export namespace_391e4301::function_f2f98cfc Unknown operator 0x5d
}

// Namespace namespace_391e4301
// Params 0, eflags: 0x0
// Checksum 0xf52242c7, Offset: 0x5368
// Size: 0x33
function function_1aeb2873() {
    // Can't decompile export namespace_391e4301::function_1aeb2873 Unknown operator 0xe2
}

// Namespace namespace_391e4301
// Params 0, eflags: 0x0
// Checksum 0x4bb1e9e6, Offset: 0x53c0
// Size: 0x33
function function_fb967724() {
    // Can't decompile export namespace_391e4301::function_fb967724 Unknown operator 0x76
}

