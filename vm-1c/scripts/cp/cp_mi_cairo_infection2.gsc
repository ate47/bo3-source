#using scripts/codescripts/struct;
#using scripts/cp/_accolades;
#using scripts/cp/_ammo_cache;
#using scripts/cp/_collectibles;
#using scripts/cp/_load;
#using scripts/cp/_objectives;
#using scripts/cp/_skipto;
#using scripts/cp/_util;
#using scripts/cp/cp_mi_cairo_infection2_fx;
#using scripts/cp/cp_mi_cairo_infection2_patch;
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
#using scripts/shared/flag_shared;
#using scripts/shared/hud_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/util_shared;
#using scripts/shared/vehicles/_quadtank;

#namespace cp_mi_cairo_infection2;

// Namespace cp_mi_cairo_infection2
// Params 0, eflags: 0x0
// Checksum 0xde9b0970, Offset: 0x948
// Size: 0x34
function function_243693d4() {
    util::add_gametype("coop");
    util::add_gametype("cpzm");
}

// Namespace cp_mi_cairo_infection2
// Params 0, eflags: 0x0
// Checksum 0x920f66a1, Offset: 0x988
// Size: 0x39c
function main() {
    if (sessionmodeiscampaignzombiesgame() && 0) {
        setclearanceceiling(34);
    } else {
        setclearanceceiling(116);
    }
    savegame::function_8c0c4b3a("infection");
    util::function_286a5010(11);
    scene::add_wait_for_streamer_hint_scene("cin_inf_07_04_sarah_vign_03");
    scene::add_wait_for_streamer_hint_scene("cin_inf_08_blackstation_3rd_sh010");
    level flag::init("flag_player_enters_cave");
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
    objectives::complete("cp_level_infection_find_dr");
    objectives::complete("cp_level_infection_defeat_sarah");
    objectives::complete("cp_level_infection_interface_sarah");
    objectives::complete("cp_level_infection_extract_intel");
    cp_mi_cairo_infection2_patch::function_7403e82b();
}

// Namespace cp_mi_cairo_infection2
// Params 0, eflags: 0x0
// Checksum 0x4ed579b6, Offset: 0xd30
// Size: 0x64
function init_clientfields() {
    clientfield::register("world", "cathedral_water_state", 1, 1, "int");
    clientfield::register("world", "set_exposure_bank", 1, 2, "int");
}

// Namespace cp_mi_cairo_infection2
// Params 0, eflags: 0x0
// Checksum 0xaebcc9c3, Offset: 0xda0
// Size: 0x2aa
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
// Checksum 0x6a8239b0, Offset: 0x1058
// Size: 0x4c
function function_376778e8(n_id) {
    self infection_util::function_822eb8e8();
    util::wait_network_frame();
    self infection_util::function_72e40406(n_id);
}

// Namespace cp_mi_cairo_infection2
// Params 0, eflags: 0x0
// Checksum 0x29306560, Offset: 0x10b0
// Size: 0x3ec
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
// Checksum 0x1373196c, Offset: 0x14a8
// Size: 0x44
function function_377593d7(str_objective, var_74cd64bc) {
    switchmap_load("cp_mi_cairo_infection3");
    wait 0.05;
    switchmap_switch();
}

