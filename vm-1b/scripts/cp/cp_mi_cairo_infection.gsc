#using scripts/codescripts/struct;
#using scripts/cp/_accolades;
#using scripts/cp/_ammo_cache;
#using scripts/cp/_load;
#using scripts/cp/_objectives;
#using scripts/cp/_skipto;
#using scripts/cp/_util;
#using scripts/cp/cp_mi_cairo_infection_accolades;
#using scripts/cp/cp_mi_cairo_infection_fx;
#using scripts/cp/cp_mi_cairo_infection_sgen_test_chamber;
#using scripts/cp/cp_mi_cairo_infection_sim_reality_starts;
#using scripts/cp/cp_mi_cairo_infection_sound;
#using scripts/cp/cp_mi_cairo_infection_theia_battle;
#using scripts/cp/cp_mi_cairo_infection_util;
#using scripts/cp/gametypes/_save;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/hud_shared;
#using scripts/shared/util_shared;

#namespace cp_mi_cairo_infection;

// Namespace cp_mi_cairo_infection
// Params 0, eflags: 0x0
// Checksum 0xa37183e1, Offset: 0x628
// Size: 0x32
function function_243693d4() {
    util::add_gametype("coop");
    util::add_gametype("cpzm");
}

// Namespace cp_mi_cairo_infection
// Params 0, eflags: 0x0
// Checksum 0xf721903d, Offset: 0x668
// Size: 0x131
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
    InvalidOpCode(0xc8, "strings", "war_callsign_a", %MPUI_CALLSIGN_MAPNAME_A);
    // Unknown operator (0xc8, t7_1b, PC)
}

// Namespace cp_mi_cairo_infection
// Params 0, eflags: 0x0
// Checksum 0xb500e7b0, Offset: 0x8c8
// Size: 0x2a
function init_clientfields() {
    clientfield::register("world", "set_exposure_bank", 1, 2, "int");
}

// Namespace cp_mi_cairo_infection
// Params 0, eflags: 0x0
// Checksum 0x4bc659f9, Offset: 0x900
// Size: 0xf9
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
// Params 0, eflags: 0x0
// Checksum 0xc635750c, Offset: 0xa08
// Size: 0x8a
function function_4fbaf6d6() {
    level waittill(#"hash_9f92e1e");
    fx_origin = util::spawn_model("tag_origin", self.origin, self.angles);
    playfxontag(level._effect["player_dirt_loop"], fx_origin, "tag_origin");
    fx_origin linkto(self);
    level waittill(#"sarah_battle_end");
    fx_origin delete();
}

// Namespace cp_mi_cairo_infection
// Params 1, eflags: 0x0
// Checksum 0x2cf70658, Offset: 0xaa0
// Size: 0x3a
function function_376778e8(n_id) {
    self infection_util::function_822eb8e8();
    util::wait_network_frame();
    self infection_util::function_72e40406(n_id);
}

// Namespace cp_mi_cairo_infection
// Params 0, eflags: 0x0
// Checksum 0x6215956f, Offset: 0xae8
// Size: 0x212
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
// Params 2, eflags: 0x0
// Checksum 0x4f0d0ec5, Offset: 0xd08
// Size: 0x42
function function_1173196e(str_objective, var_74cd64bc) {
    switchmap_load("cp_mi_cairo_infection2");
    wait 0.05;
    switchmap_switch();
}

// Namespace cp_mi_cairo_infection
// Params 2, eflags: 0x0
// Checksum 0x9f0f35cd, Offset: 0xd58
// Size: 0x42
function function_377593d7(str_objective, var_74cd64bc) {
    switchmap_load("cp_mi_cairo_infection3");
    wait 0.05;
    switchmap_switch();
}

