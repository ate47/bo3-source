#using scripts/codescripts/struct;
#using scripts/cp/_accolades;
#using scripts/cp/_ammo_cache;
#using scripts/cp/_collectibles;
#using scripts/cp/_load;
#using scripts/cp/_objectives;
#using scripts/cp/_skipto;
#using scripts/cp/_util;
#using scripts/cp/cp_mi_cairo_infection2_fx;
#using scripts/cp/cp_mi_cairo_infection2_sound;
#using scripts/cp/cp_mi_cairo_infection_accolades;
#using scripts/cp/cp_mi_cairo_infection_church;
#using scripts/cp/cp_mi_cairo_infection_forest;
#using scripts/cp/cp_mi_cairo_infection_forest_surreal;
#using scripts/cp/cp_mi_cairo_infection_foy_turret;
#using scripts/cp/cp_mi_cairo_infection_murders;
#using scripts/cp/cp_mi_cairo_infection_sgen_server_room;
#using scripts/cp/cp_mi_cairo_infection_tiger_tank;
#using scripts/cp/cp_mi_cairo_infection_underwater;
#using scripts/cp/cp_mi_cairo_infection_util;
#using scripts/cp/cp_mi_cairo_infection_village;
#using scripts/cp/cp_mi_cairo_infection_village_surreal;
#using scripts/cp/gametypes/_save;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/hud_shared;
#using scripts/shared/util_shared;
#using scripts/shared/vehicles/_quadtank;

#namespace cp_mi_cairo_infection2;

// Namespace cp_mi_cairo_infection2
// Params 0, eflags: 0x0
// Checksum 0xd8e65d6c, Offset: 0x888
// Size: 0x32
function function_243693d4() {
    util::add_gametype("coop");
    util::add_gametype("cpzm");
}

// Namespace cp_mi_cairo_infection2
// Params 0, eflags: 0x0
// Checksum 0xca5a20fd, Offset: 0x8c8
// Size: 0x1a1
function main() {
    if (sessionmodeiscampaignzombiesgame() && 0) {
        setclearanceceiling(34);
    } else {
        setclearanceceiling(116);
    }
    savegame::function_8c0c4b3a("infection");
    util::function_286a5010(11);
    function_a1a20c49();
    callback::on_spawned(&on_player_spawned);
    init_clientfields();
    sgen_server_room::main();
    namespace_47ecfa2f::main();
    underwater::main();
    church::init_client_field_callback_funcs();
    forest::init_client_field_callback_funcs();
    village::init_client_field_callback_funcs();
    namespace_4e2074f4::init_client_field_callback_funcs();
    infection_util::function_1d387f5d();
    namespace_f25bd8c8::function_66df416f();
    cp_mi_cairo_infection2_sound::main();
    skipto::function_f3e035ef();
    load::main();
    setdvar("compassmaxrange", "2100");
    InvalidOpCode(0xc8, "strings", "war_callsign_a", %MPUI_CALLSIGN_MAPNAME_A);
    // Unknown operator (0xc8, t7_1b, PC)
}

// Namespace cp_mi_cairo_infection2
// Params 0, eflags: 0x0
// Checksum 0x9161fa6f, Offset: 0xbd8
// Size: 0x52
function init_clientfields() {
    clientfield::register("world", "cathedral_water_state", 1, 1, "int");
    clientfield::register("world", "set_exposure_bank", 1, 2, "int");
}

// Namespace cp_mi_cairo_infection2
// Params 0, eflags: 0x0
// Checksum 0x591d074f, Offset: 0xc38
// Size: 0x201
function on_player_spawned() {
    var_aace7bde = skipto::function_8b19ec5d();
    if (isdefined(var_aace7bde)) {
        switch (var_aace7bde[0]) {
        case "sgen_server_room":
            infection_util::function_4f66eed6();
            self infection_util::function_9f10c537();
            break;
        case "forest_intro":
            infection_util::function_4f66eed6();
            self thread function_376778e8();
            break;
        case "forest":
            infection_util::function_4f66eed6();
            self thread function_376778e8();
            break;
        case "forest_surreal":
            infection_util::function_4f66eed6();
            break;
        case "forest_wolves":
            infection_util::function_4f66eed6();
            break;
        case "forest_sky_bridge":
            infection_util::function_4f66eed6();
            break;
        case "forest_tunnel":
            infection_util::function_4f66eed6();
            break;
        case "black_station":
            infection_util::function_4f66eed6();
            break;
        case "village":
            infection_util::function_4f66eed6();
            self thread function_376778e8();
            break;
        case "village_inception":
            self thread function_376778e8(3);
            break;
        case "church":
            infection_util::function_4f66eed6();
            self infection_util::function_9f10c537();
            break;
        case "cathedral":
            infection_util::function_4f66eed6();
            break;
        case "underwater":
            infection_util::function_4f66eed6();
            break;
        case "dev_cathedral_outro":
            infection_util::function_4f66eed6();
            break;
        case "dev_black_station_intro":
            infection_util::function_4f66eed6();
            break;
        default:
            break;
        }
    }
}

// Namespace cp_mi_cairo_infection2
// Params 1, eflags: 0x0
// Checksum 0x74142bc5, Offset: 0xe48
// Size: 0x3a
function function_376778e8(n_id) {
    self infection_util::function_822eb8e8();
    util::wait_network_frame();
    self infection_util::function_72e40406(n_id);
}

// Namespace cp_mi_cairo_infection2
// Params 0, eflags: 0x0
// Checksum 0xd5f40f00, Offset: 0xe90
// Size: 0x3ea
function function_a1a20c49() {
    skipto::add("sgen_server_room", &sgen_server_room::function_2fcfe223, "SGEN - SERVER ROOM", &sgen_server_room::function_3ef23469);
    skipto::function_d68e678e("forest_intro", &forest::intro_main, "BASTOGNE INTRO", &forest::function_dcdf9aa0);
    skipto::add("forest", &forest::function_a683b99a, "BASTOGNE", &forest::cleanup);
    skipto::function_d68e678e("forest_surreal", &forest_surreal::main, "WORLD FALLS AWAY", &forest_surreal::cleanup);
    skipto::function_d68e678e("forest_wolves", &forest_surreal::forest_wolves, "FOREST WOLVES", &forest_surreal::function_71196f64);
    skipto::add("forest_sky_bridge", &forest_surreal::forest_sky_bridge, "FOREST SKY BRIDGE", &forest_surreal::function_dd270bfd);
    skipto::add("forest_tunnel", &forest_surreal::forest_tunnel, "FOREST TUNNEL", &forest_surreal::function_de606506);
    skipto::add_dev("dev_black_station_intro", &forest_surreal::dev_black_station_intro, "DEV: BLACK STATION INTRO", &forest_surreal::function_503c0a2);
    skipto::function_d68e678e("black_station", &namespace_47ecfa2f::function_fbe0ab05, "BLACK STATION", &namespace_47ecfa2f::cleanup);
    skipto::function_d68e678e("village", &village::main, "FOY", &village::cleanup);
    skipto::function_d68e678e("village_inception", &namespace_4e2074f4::main, "FOLD", &namespace_4e2074f4::cleanup);
    skipto::function_d68e678e("church", &church::function_56c1b3cc, "CHURCH", &church::function_7c4081cb);
    skipto::add("cathedral", &church::function_cbb5d383, "CATHEDRAL", &church::function_9fdc48d2);
    skipto::add_dev("dev_cathedral_outro", &church::dev_cathedral_outro, "CATHEDRAL", &church::function_956d2096);
    skipto::function_d68e678e("underwater", &underwater::function_9157ab7a, "UNDERWATER", &underwater::function_1c0537db);
    skipto::add_dev("dev_skipto_infection_3", &function_377593d7);
}

// Namespace cp_mi_cairo_infection2
// Params 2, eflags: 0x0
// Checksum 0x92d889d0, Offset: 0x1288
// Size: 0x42
function function_377593d7(str_objective, var_74cd64bc) {
    switchmap_load("cp_mi_cairo_infection3");
    wait 0.05;
    switchmap_switch();
}

