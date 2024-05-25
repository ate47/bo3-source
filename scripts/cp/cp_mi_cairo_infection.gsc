#using scripts/cp/cp_mi_cairo_infection_sgen_test_chamber;
#using scripts/cp/cp_mi_cairo_infection_sim_reality_starts;
#using scripts/cp/cp_mi_cairo_infection_theia_battle;
#using scripts/cp/cp_mi_cairo_infection_util;
#using scripts/cp/cp_mi_cairo_infection_sound;
#using scripts/cp/cp_mi_cairo_infection_fx;
#using scripts/cp/cp_mi_cairo_infection_accolades;
#using scripts/cp/_accolades;
#using scripts/cp/_objectives;
#using scripts/cp/_util;
#using scripts/cp/_skipto;
#using scripts/cp/_load;
#using scripts/cp/_ammo_cache;
#using scripts/shared/util_shared;
#using scripts/shared/hud_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/callbacks_shared;
#using scripts/cp/gametypes/_save;
#using scripts/codescripts/struct;

#namespace namespace_1477b376;

// Namespace namespace_1477b376
// Params 0, eflags: 0x0
// Checksum 0xa37183e1, Offset: 0x628
// Size: 0x32
function function_243693d4() {
    util::add_gametype("coop");
    util::add_gametype("cpzm");
}

// Namespace namespace_1477b376
// Params 0, eflags: 0x0
// Checksum 0xf721903d, Offset: 0x668
// Size: 0x13
function main() {
    // Can't decompile export namespace_1477b376::main Unknown operator 0xe2
}

// Namespace namespace_1477b376
// Params 0, eflags: 0x0
// Checksum 0xb500e7b0, Offset: 0x8c8
// Size: 0x9
function init_clientfields() {
    // Can't decompile export namespace_1477b376::init_clientfields Unknown operator 0xe2
}

// Namespace namespace_1477b376
// Params 0, eflags: 0x0
// Checksum 0x4bc659f9, Offset: 0x900
// Size: 0x1c
function on_player_spawned() {
    // Can't decompile export namespace_1477b376::on_player_spawned Unknown operator 0x5d
}

// Namespace namespace_1477b376
// Params 0, eflags: 0x0
// Checksum 0xc635750c, Offset: 0xa08
// Size: 0x11
function function_4fbaf6d6() {
    // Can't decompile export namespace_1477b376::function_4fbaf6d6 Unknown operator 0xd4
}

// Namespace namespace_1477b376
// Params 1, eflags: 0x0
// Checksum 0x2cf70658, Offset: 0xaa0
// Size: 0x2b
function function_376778e8(n_id) {
    // Can't decompile export namespace_1477b376::function_376778e8 Unknown operator 0x5d
}

// Namespace namespace_1477b376
// Params 0, eflags: 0x0
// Checksum 0x6215956f, Offset: 0xae8
// Size: 0x212
function function_a1a20c49() {
    skipto::add("vtol_arrival", &namespace_c3900363::function_e25e4f9, "VTOL ARRIVAL", &namespace_c3900363::function_f72443b3);
    skipto::add("sarah_battle", &namespace_c3900363::function_8721a9e0, "SARAH BATTLE", &namespace_c3900363::function_eaebdc16);
    skipto::function_d68e678e("sarah_battle_end", &namespace_c3900363::function_6714d6be, "SARAH BATTLE END", &namespace_c3900363::function_e6eaed98);
    skipto::add("sim_reality_starts", &namespace_b2b18209::function_d78d6232, "BIRTH OF THE AI", &namespace_b2b18209::function_2d3d4bcc);
    skipto::function_d68e678e("sgen_test_chamber", &namespace_9ac99a6e::function_c568c95b, "SGEN - 2060", &namespace_9ac99a6e::function_7985eb71);
    skipto::add("time_lapse", &namespace_9ac99a6e::function_21e8c919, "SGEN - TIME LAPSE", &namespace_9ac99a6e::function_f7f4cbd3);
    skipto::add("cyber_soliders_invest", &namespace_9ac99a6e::function_621e0975, "SGEN - 2070", &namespace_9ac99a6e::function_790aa7af);
    skipto::add_dev("dev_skipto_infection_2", &function_1173196e);
    skipto::add_dev("dev_skipto_infection_3", &function_377593d7);
}

// Namespace namespace_1477b376
// Params 2, eflags: 0x0
// Checksum 0x4f0d0ec5, Offset: 0xd08
// Size: 0x2a
function function_1173196e(str_objective, var_74cd64bc) {
    // Can't decompile export namespace_1477b376::function_1173196e Unknown operator 0x98
}

// Namespace namespace_1477b376
// Params 2, eflags: 0x0
// Checksum 0x9f0f35cd, Offset: 0xd58
// Size: 0x2a
function function_377593d7(str_objective, var_74cd64bc) {
    // Can't decompile export namespace_1477b376::function_377593d7 Unknown operator 0x98
}

