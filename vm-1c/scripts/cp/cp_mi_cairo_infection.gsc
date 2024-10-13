#using scripts/cp/cp_mi_cairo_infection_patch;
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

#namespace cp_mi_cairo_infection;

// Namespace cp_mi_cairo_infection
// Params 0, eflags: 0x0
// Checksum 0x1bddde66, Offset: 0x650
// Size: 0x34
function function_243693d4() {
    util::add_gametype("coop");
    util::add_gametype("cpzm");
}

// Namespace cp_mi_cairo_infection
// Params 0, eflags: 0x1 linked
// Checksum 0xf7f9b70, Offset: 0x690
// Size: 0x2a4
function main() {
    init_clientfields();
    setclearanceceiling(111);
    savegame::function_8c0c4b3a("infection");
    function_a1a20c49();
    util::function_286a5010(11);
    callback::on_spawned(&on_player_spawned);
    sarah_battle::main();
    sim_reality_starts::main();
    sgen_test_chamber::main();
    namespace_f25bd8c8::function_66df416f();
    cp_mi_cairo_infection_fx::main();
    cp_mi_cairo_infection_sound::main();
    skipto::function_f3e035ef();
    load::main();
    setdvar("compassmaxrange", "2100");
    game["strings"]["war_callsign_a"] = %MPUI_CALLSIGN_MAPNAME_A;
    game["strings"]["war_callsign_b"] = %MPUI_CALLSIGN_MAPNAME_B;
    game["strings"]["war_callsign_c"] = %MPUI_CALLSIGN_MAPNAME_C;
    game["strings"]["war_callsign_d"] = %MPUI_CALLSIGN_MAPNAME_D;
    game["strings"]["war_callsign_e"] = %MPUI_CALLSIGN_MAPNAME_E;
    game["strings_menu"]["war_callsign_a"] = "@MPUI_CALLSIGN_MAPNAME_A";
    game["strings_menu"]["war_callsign_b"] = "@MPUI_CALLSIGN_MAPNAME_B";
    game["strings_menu"]["war_callsign_c"] = "@MPUI_CALLSIGN_MAPNAME_C";
    game["strings_menu"]["war_callsign_d"] = "@MPUI_CALLSIGN_MAPNAME_D";
    game["strings_menu"]["war_callsign_e"] = "@MPUI_CALLSIGN_MAPNAME_E";
    level._effect["player_dirt_loop"] = "dirt/fx_dust_sand_storm_player_loop";
    level.var_dc236bc8 = 1;
    cp_mi_cairo_infection_patch::function_7403e82b();
}

// Namespace cp_mi_cairo_infection
// Params 0, eflags: 0x1 linked
// Checksum 0x3dfdae5d, Offset: 0x940
// Size: 0x34
function init_clientfields() {
    clientfield::register("world", "set_exposure_bank", 1, 2, "int");
}

// Namespace cp_mi_cairo_infection
// Params 0, eflags: 0x1 linked
// Checksum 0xaffe0d9d, Offset: 0x980
// Size: 0x13a
function on_player_spawned() {
    var_aace7bde = skipto::function_8b19ec5d();
    if (isdefined(var_aace7bde)) {
        switch (var_aace7bde[0]) {
        case "vtol_arrival":
            self infection_util::function_9f10c537();
            break;
        case "sarah_battle":
            self util::set_lighting_state(1);
            self thread function_4fbaf6d6();
            break;
        case "sarah_battle_end":
            self util::set_lighting_state(1);
            break;
        case "sim_reality_starts":
            self thread function_376778e8();
            self infection_util::function_9f10c537();
            break;
        case "cyber_soliders_invest":
        case "sgen_test_chamber":
        case "time_lapse":
            self infection_util::function_9f10c537();
            break;
        default:
            break;
        }
    }
}

// Namespace cp_mi_cairo_infection
// Params 0, eflags: 0x1 linked
// Checksum 0xe31c5c56, Offset: 0xac8
// Size: 0xb4
function function_4fbaf6d6() {
    level waittill(#"hash_9f92e1e");
    fx_origin = util::spawn_model("tag_origin", self.origin, self.angles);
    playfxontag(level._effect["player_dirt_loop"], fx_origin, "tag_origin");
    fx_origin linkto(self);
    level waittill(#"sarah_battle_end");
    fx_origin delete();
}

// Namespace cp_mi_cairo_infection
// Params 1, eflags: 0x1 linked
// Checksum 0x4d8c7f9d, Offset: 0xb88
// Size: 0x4c
function function_376778e8(n_id) {
    self infection_util::function_822eb8e8();
    util::wait_network_frame();
    self infection_util::function_72e40406(n_id);
}

// Namespace cp_mi_cairo_infection
// Params 0, eflags: 0x1 linked
// Checksum 0x44f55dd8, Offset: 0xbe0
// Size: 0x214
function function_a1a20c49() {
    skipto::add("vtol_arrival", &sarah_battle::function_e25e4f9, "VTOL ARRIVAL", &sarah_battle::function_f72443b3);
    skipto::add("sarah_battle", &sarah_battle::function_8721a9e0, "SARAH BATTLE", &sarah_battle::function_eaebdc16);
    skipto::function_d68e678e("sarah_battle_end", &sarah_battle::function_6714d6be, "SARAH BATTLE END", &sarah_battle::function_e6eaed98);
    skipto::add("sim_reality_starts", &sim_reality_starts::function_d78d6232, "BIRTH OF THE AI", &sim_reality_starts::function_2d3d4bcc);
    skipto::function_d68e678e("sgen_test_chamber", &sgen_test_chamber::function_c568c95b, "SGEN - 2060", &sgen_test_chamber::function_7985eb71);
    skipto::add("time_lapse", &sgen_test_chamber::function_21e8c919, "SGEN - TIME LAPSE", &sgen_test_chamber::function_f7f4cbd3);
    skipto::add("cyber_soliders_invest", &sgen_test_chamber::function_621e0975, "SGEN - 2070", &sgen_test_chamber::function_790aa7af);
    skipto::add_dev("dev_skipto_infection_2", &function_1173196e);
    skipto::add_dev("dev_skipto_infection_3", &function_377593d7);
}

// Namespace cp_mi_cairo_infection
// Params 2, eflags: 0x1 linked
// Checksum 0xf89bc712, Offset: 0xe00
// Size: 0x44
function function_1173196e(str_objective, var_74cd64bc) {
    switchmap_load("cp_mi_cairo_infection2");
    wait 0.05;
    switchmap_switch();
}

// Namespace cp_mi_cairo_infection
// Params 2, eflags: 0x1 linked
// Checksum 0x4e46ef4c, Offset: 0xe50
// Size: 0x44
function function_377593d7(str_objective, var_74cd64bc) {
    switchmap_load("cp_mi_cairo_infection3");
    wait 0.05;
    switchmap_switch();
}

