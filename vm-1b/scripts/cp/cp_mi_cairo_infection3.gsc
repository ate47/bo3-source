#using scripts/codescripts/struct;
#using scripts/cp/_accolades;
#using scripts/cp/_ammo_cache;
#using scripts/cp/_load;
#using scripts/cp/_mobile_armory;
#using scripts/cp/_objectives;
#using scripts/cp/_skipto;
#using scripts/cp/_util;
#using scripts/cp/cp_mi_cairo_infection3_fx;
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
// Checksum 0x9c8f7a2c, Offset: 0x5c0
// Size: 0x32
function function_243693d4() {
    util::add_gametype("coop");
    util::add_gametype("cpzm");
}

// Namespace cp_mi_cairo_infection3
// Params 0, eflags: 0x0
// Checksum 0x20d5afec, Offset: 0x600
// Size: 0x131
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
    InvalidOpCode(0xc8, "strings", "war_callsign_a", %MPUI_CALLSIGN_MAPNAME_A);
    // Unknown operator (0xc8, t7_1b, PC)
}

// Namespace cp_mi_cairo_infection3
// Params 0, eflags: 0x0
// Checksum 0x47bb1cc9, Offset: 0x8e8
// Size: 0x51
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
// Checksum 0xe0708c52, Offset: 0x948
// Size: 0x1c2
function function_a1a20c49() {
    skipto::add("hideout", &namespace_6473bd03::function_206da579, "HIDEOUT", &namespace_6473bd03::function_299b5716);
    skipto::add("interrogation", &namespace_6473bd03::interrogation_main, "INTERROGATION", &namespace_6473bd03::function_3aef563f);
    skipto::add("city_barren", &namespace_6473bd03::function_607100ba, "STALINGRAD CREATION", &namespace_6473bd03::function_eebf61b);
    skipto::function_d68e678e("city", &namespace_6473bd03::function_67c4a95f, "ZOMBIES", &namespace_6473bd03::function_36ff1cdc);
    skipto::add("city_tree", &namespace_6473bd03::function_7bb61977, "ZOMBIES_END", &namespace_6473bd03::function_7e8dc9e7);
    skipto::function_d68e678e("city_nuked", &namespace_6473bd03::function_71d39006, "NUKE", &namespace_6473bd03::function_567b48bf);
    skipto::add("outro", &namespace_6473bd03::outro_main, "OUTRO", &namespace_6473bd03::outro_cleanup);
}

