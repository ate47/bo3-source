#using scripts/cp/cp_mi_sing_biodomes_util;
#using scripts/cp/cp_mi_sing_biodomes_fighttothedome;
#using scripts/cp/cp_mi_sing_biodomes_cloudmountain;
#using scripts/cp/cp_mi_sing_biodomes_warehouse;
#using scripts/cp/cp_mi_sing_biodomes_markets;
#using scripts/cp/cp_mi_sing_biodomes_sound;
#using scripts/cp/cp_mi_sing_biodomes_init_spawn;
#using scripts/cp/cp_mi_sing_biodomes_fx;
#using scripts/cp/cp_mi_sing_biodomes_accolades;
#using scripts/cp/cybercom/_cybercom;
#using scripts/cp/_objectives;
#using scripts/cp/_ammo_cache;
#using scripts/cp/_util;
#using scripts/cp/_squad_control;
#using scripts/cp/_spawn_manager;
#using scripts/cp/_skipto;
#using scripts/cp/_load;
#using scripts/cp/_dialog;
#using scripts/cp/_mobile_armory;
#using scripts/cp/_collectibles;
#using scripts/shared/ai/archetype_warlord_interface;
#using scripts/shared/visionset_mgr_shared;
#using scripts/shared/vehicle_shared;
#using scripts/shared/vehicle_ai_shared;
#using scripts/shared/util_shared;
#using scripts/shared/trigger_shared;
#using scripts/shared/teamgather_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/math_shared;
#using scripts/shared/lui_shared;
#using scripts/shared/laststand_shared;
#using scripts/shared/hud_message_shared;
#using scripts/shared/gameobjects_shared;
#using scripts/shared/fx_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/colors_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/array_shared;
#using scripts/shared/animation_shared;
#using scripts/shared/ai_shared;
#using scripts/cp/gametypes/_save;
#using scripts/codescripts/struct;

#namespace namespace_55d2f1be;

// Namespace namespace_55d2f1be
// Params 0, eflags: 0x0
// Checksum 0xd1faa027, Offset: 0x1258
// Size: 0x32
function function_243693d4() {
    util::add_gametype("coop");
    util::add_gametype("cpzm");
}

// Namespace namespace_55d2f1be
// Params 0, eflags: 0x0
// Checksum 0x66eb4467, Offset: 0x1298
// Size: 0x11
function main() {
    // Can't decompile export namespace_55d2f1be::main Unknown operator 0x9d
}

// Namespace namespace_55d2f1be
// Params 0, eflags: 0x0
// Checksum 0x63b60011, Offset: 0x1448
// Size: 0x26a
function function_673254cc() {
    // Can't decompile export namespace_55d2f1be::function_673254cc Unknown operator 0x67
}

// Namespace namespace_55d2f1be
// Params 0, eflags: 0x0
// Checksum 0x2a65aa07, Offset: 0x1738
// Size: 0x33
function precache() {
    level._effect["ceiling_collapse"] = "destruct/fx_dest_ceiling_collapse_biodomes";
    level._effect["smoke_grenade"] = "explosions/fx_exp_grenade_smoke";
}

// Namespace namespace_55d2f1be
// Params 0, eflags: 0x0
// Checksum 0xc22135fd, Offset: 0x1778
// Size: 0x9
function function_b37230e4() {
    // Can't decompile export namespace_55d2f1be::function_b37230e4 Unknown operator 0xe2
}

// Namespace namespace_55d2f1be
// Params 0, eflags: 0x0
// Checksum 0xc24b203d, Offset: 0x1a08
// Size: 0x9
function flag_init() {
    // Can't decompile export namespace_55d2f1be::flag_init Unknown operator 0xd4
}

// Namespace namespace_55d2f1be
// Params 0, eflags: 0x0
// Checksum 0xaa1a3711, Offset: 0x1eb0
// Size: 0x8a
function level_init() {
    // Can't decompile export namespace_55d2f1be::level_init Unknown operator 0xe2
}

// Namespace namespace_55d2f1be
// Params 0, eflags: 0x0
// Checksum 0x16510ed1, Offset: 0x20a8
// Size: 0x2
function function_8b005d7f() {
    // Can't decompile export namespace_55d2f1be::function_8b005d7f Unknown operator 0x76
}

// Namespace namespace_55d2f1be
// Params 0, eflags: 0x0
// Checksum 0x3332b0b8, Offset: 0x20c8
// Size: 0x2
function on_player_connect() {
    // Can't decompile export namespace_55d2f1be::on_player_connect Unknown operator 0x76
}

// Namespace namespace_55d2f1be
// Params 0, eflags: 0x0
// Checksum 0x40c2ef48, Offset: 0x2108
// Size: 0x3
function on_player_spawned() {
    // Can't decompile export namespace_55d2f1be::on_player_spawned Unknown operator 0x76
}

// Namespace namespace_55d2f1be
// Params 0, eflags: 0x0
// Checksum 0xb21a07ba, Offset: 0x2220
// Size: 0x12
function function_f1059e87() {
    // Can't decompile export namespace_55d2f1be::function_f1059e87 Unknown operator 0xc0
}

// Namespace namespace_55d2f1be
// Params 2, eflags: 0x0
// Checksum 0xca37930d, Offset: 0x2248
// Size: 0x22
function function_cef897cf(str_objective, var_23d9a41a) {
    // Can't decompile export namespace_55d2f1be::function_cef897cf Unknown operator 0x5d
}

// Namespace namespace_55d2f1be
// Params 0, eflags: 0x0
// Checksum 0x192fdba5, Offset: 0x2328
// Size: 0xb
function function_2ec137d9() {
    // Can't decompile export namespace_55d2f1be::function_2ec137d9 Unknown operator 0xe2
}

// Namespace namespace_55d2f1be
// Params 1, eflags: 0x0
// Checksum 0x94ebda48, Offset: 0x2370
// Size: 0x1d
function function_f952ddcc(var_b35e56d0) {
    // Can't decompile export namespace_55d2f1be::function_f952ddcc Unknown operator 0x5d
}

// Namespace namespace_55d2f1be
// Params 1, eflags: 0x0
// Checksum 0x450db3a5, Offset: 0x2418
// Size: 0x7a
function function_69468f09(var_f45807af) {
    // Can't decompile export namespace_55d2f1be::function_69468f09 Unknown operator 0x5d
}

// Namespace namespace_55d2f1be
// Params 0, eflags: 0x0
// Checksum 0x593e722c, Offset: 0x2960
// Size: 0x9
function function_8013ff12() {
    // Can't decompile export namespace_55d2f1be::function_8013ff12 Unknown operator 0xd4
}

// Namespace namespace_55d2f1be
// Params 1, eflags: 0x0
// Checksum 0xe628c535, Offset: 0x29a0
// Size: 0x11
function function_b361ad8b(a_ents) {
    // Can't decompile export namespace_55d2f1be::function_b361ad8b Unknown operator 0xd4
}

// Namespace namespace_55d2f1be
// Params 0, eflags: 0x0
// Checksum 0xfda2a56d, Offset: 0x2b60
// Size: 0x9
function function_9cebd80e() {
    // Can't decompile export namespace_55d2f1be::function_9cebd80e Unknown operator 0xd4
}

// Namespace namespace_55d2f1be
// Params 3, eflags: 0x0
// Checksum 0x1e9fd9c8, Offset: 0x2bc8
// Size: 0x3a
function function_5cb44f79(var_d83ebd04, var_42c1bd32, var_ae7d184a) {
    // Can't decompile export namespace_55d2f1be::function_5cb44f79 Unknown operator 0x1c
}

// Namespace namespace_55d2f1be
// Params 0, eflags: 0x0
// Checksum 0x6182542, Offset: 0x2d30
// Size: 0x9
function function_e4f0cf99() {
    // Can't decompile export namespace_55d2f1be::function_e4f0cf99 Unknown operator 0xd4
}

// Namespace namespace_55d2f1be
// Params 1, eflags: 0x0
// Checksum 0x6347ff9f, Offset: 0x2d70
// Size: 0x2a
function function_484bc3aa(b_enable) {
    // Can't decompile export namespace_55d2f1be::function_484bc3aa Unknown operator 0xfa
}

// Namespace namespace_55d2f1be
// Params 1, eflags: 0x0
// Checksum 0xae10bfc5, Offset: 0x2df0
// Size: 0x19
function function_df65aec6(a_ents) {
    // Can't decompile export namespace_55d2f1be::function_df65aec6 Unknown operator 0xd4
}

// Namespace namespace_55d2f1be
// Params 1, eflags: 0x0
// Checksum 0xdac9715a, Offset: 0x2e70
// Size: 0x43
function function_7b5ce9a8(scene) {
    // Can't decompile export namespace_55d2f1be::function_7b5ce9a8 Unknown operator 0x76
}

// Namespace namespace_55d2f1be
// Params 2, eflags: 0x0
// Checksum 0xc3ba7dd7, Offset: 0x2f38
// Size: 0x5a
function function_c506a743(str_objective, var_23d9a41a) {
    // Can't decompile export namespace_55d2f1be::function_c506a743 Unknown operator 0x5d
}

// Namespace namespace_55d2f1be
// Params 0, eflags: 0x0
// Checksum 0x7ee1fcbd, Offset: 0x30d0
// Size: 0x9
function function_a673776d() {
    // Can't decompile export namespace_55d2f1be::function_a673776d Unknown operator 0xd4
}

// Namespace namespace_55d2f1be
// Params 0, eflags: 0x0
// Checksum 0x946b3bc3, Offset: 0x3140
// Size: 0xa
function function_2a7e0c30() {
    // Can't decompile export namespace_55d2f1be::function_2a7e0c30 Unknown operator 0xc0
}

// Namespace namespace_55d2f1be
// Params 2, eflags: 0x0
// Checksum 0xe8cb4946, Offset: 0x3190
// Size: 0x2b
function function_b0343c6c(str_objective, var_74cd64bc) {
    // Can't decompile export namespace_55d2f1be::function_b0343c6c Unknown operator 0x5d
}

// Namespace namespace_55d2f1be
// Params 4, eflags: 0x0
// Checksum 0xc3d349a7, Offset: 0x3218
// Size: 0x3a
function function_25dc0657(str_objective, var_74cd64bc, var_e4cd2b8b, player) {
    // Can't decompile export namespace_55d2f1be::function_25dc0657 Unknown operator 0x5d
}

// Namespace namespace_55d2f1be
// Params 0, eflags: 0x0
// Checksum 0xfba046bf, Offset: 0x3260
// Size: 0x44
function function_1fbdb441() {
    // Can't decompile export namespace_55d2f1be::function_1fbdb441 Unknown operator 0xe2
}

// Namespace namespace_55d2f1be
// Params 2, eflags: 0x0
// Checksum 0x35e8339a, Offset: 0x3330
// Size: 0x74
function function_ca12a0a4(var_b324ff00, v_source) {
    // Can't decompile export namespace_55d2f1be::function_ca12a0a4 Unknown operator 0x5d
}

// Namespace namespace_55d2f1be
// Params 2, eflags: 0x0
// Checksum 0xfa9e8342, Offset: 0x3458
// Size: 0x13
function function_1a9d89e5(str_objective, var_74cd64bc) {
    // Can't decompile export namespace_55d2f1be::function_1a9d89e5 Unknown operator 0xe2
}

