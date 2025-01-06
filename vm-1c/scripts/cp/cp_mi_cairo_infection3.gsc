#using scripts/codescripts/struct;
#using scripts/cp/_accolades;
#using scripts/cp/_ammo_cache;
#using scripts/cp/_load;
#using scripts/cp/_mobile_armory;
#using scripts/cp/_objectives;
#using scripts/cp/_skipto;
#using scripts/cp/_util;
#using scripts/cp/cp_mi_cairo_infection3_fx;
#using scripts/cp/cp_mi_cairo_infection3_patch;
#using scripts/cp/cp_mi_cairo_infection3_sound;
#using scripts/cp/cp_mi_cairo_infection_accolades;
#using scripts/cp/cp_mi_cairo_infection_hideout_outro;
#using scripts/cp/cp_mi_cairo_infection_util;
#using scripts/cp/cp_mi_cairo_infection_zombies;
#using scripts/cp/gametypes/_save;
#using scripts/shared/callbacks_shared;
#using scripts/shared/hud_shared;
#using scripts/shared/util_shared;

#namespace cp_mi_cairo_infection3;

// Namespace cp_mi_cairo_infection3
// Params 0, eflags: 0x0
// Checksum 0xe6cf1795, Offset: 0x5f0
// Size: 0x34
function function_243693d4() {
    util::add_gametype("coop");
    util::add_gametype("cpzm");
}

// Namespace cp_mi_cairo_infection3
// Params 0, eflags: 0x0
// Checksum 0xd796edb1, Offset: 0x630
// Size: 0x324
function main() {
    if (sessionmodeiscampaignzombiesgame() && -1) {
        setclearanceceiling(34);
    } else {
        setclearanceceiling(17);
    }
    savegame::function_8c0c4b3a("infection");
    util::function_286a5010(11);
    function_a1a20c49();
    callback::on_spawned(&on_player_spawned);
    namespace_b0a87e94::main();
    namespace_6473bd03::main();
    namespace_f25bd8c8::function_66df416f();
    cp_mi_cairo_infection3_fx::main();
    cp_mi_cairo_infection3_sound::main();
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
    objectives::complete("cp_level_infection_cross_chasm");
    objectives::complete("cp_level_infection_follow_sarah");
    objectives::complete("cp_level_infection_destroy_quadtank");
    objectives::complete("cp_level_infection_confront_sarah");
    cp_mi_cairo_infection3_patch::function_7403e82b();
}

// Namespace cp_mi_cairo_infection3
// Params 0, eflags: 0x0
// Checksum 0xb29b281f, Offset: 0x960
// Size: 0x66
function on_player_spawned() {
    self thread infection_util::zombie_behind_vox();
    var_aace7bde = skipto::function_8b19ec5d();
    if (isdefined(var_aace7bde)) {
        switch (var_aace7bde[0]) {
        default:
            break;
        }
    }
}

// Namespace cp_mi_cairo_infection3
// Params 0, eflags: 0x0
// Checksum 0x193ac70f, Offset: 0x9d0
// Size: 0x1c4
function function_a1a20c49() {
    skipto::add("hideout", &namespace_6473bd03::function_206da579, "HIDEOUT", &namespace_6473bd03::function_299b5716);
    skipto::add("interrogation", &namespace_6473bd03::interrogation_main, "INTERROGATION", &namespace_6473bd03::function_3aef563f);
    skipto::add("city_barren", &namespace_6473bd03::function_607100ba, "STALINGRAD CREATION", &namespace_6473bd03::function_eebf61b);
    skipto::function_d68e678e("city", &namespace_6473bd03::function_67c4a95f, "ZOMBIES", &namespace_6473bd03::function_36ff1cdc);
    skipto::add("city_tree", &namespace_6473bd03::function_7bb61977, "ZOMBIES_END", &namespace_6473bd03::function_7e8dc9e7);
    skipto::function_d68e678e("city_nuked", &namespace_6473bd03::function_71d39006, "NUKE", &namespace_6473bd03::function_567b48bf);
    skipto::add("outro", &namespace_6473bd03::outro_main, "OUTRO", &namespace_6473bd03::outro_cleanup);
}

