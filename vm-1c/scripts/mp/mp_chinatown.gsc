#using scripts/mp/mp_chinatown_sound;
#using scripts/mp/mp_chinatown_fx;
#using scripts/mp/_util;
#using scripts/mp/_load;
#using scripts/shared/util_shared;
#using scripts/shared/compass;
#using scripts/codescripts/struct;

#namespace namespace_3411baba;

// Namespace namespace_3411baba
// Params 0, eflags: 0x1 linked
// namespace_3411baba<file_0>::function_d290ebfa
// Checksum 0xd3fe3b56, Offset: 0x368
// Size: 0x514
function main() {
    precache();
    namespace_fc074aef::main();
    namespace_92e32ef6::main();
    level.remotemissile_kill_z = -435 + 50;
    load::main();
    compass::setupminimap("compass_map_mp_chinatown");
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
    spawncollision("collision_clip_128x128x128", "collider", (-814.75, 1490.75, 354.75), (0, 0, 0));
    spawncollision("collision_clip_256x256x256", "collider", (-694.25, 1553.5, 298.25), (0, 315, 0));
    spawncollision("collision_clip_128x128x128", "collider", (-788.25, 1554.75, 354.75), (0, 315, 0));
    spawncollision("collision_clip_wedge_32x128", "collider", (-898, 1074, 388), (0, 315, 0));
    spawncollision("collision_clip_wedge_32x128", "collider", (-864, 1599.25, 381.75), (0, 315, 0));
    spawncollision("collision_player_64x64x256", "collider", (-840, 1540, 366), (0, 25, 0));
    if (util::isprophuntgametype()) {
        spawncollision("collision_player_64x64x256", "collider", (-853, 1187, -64), (0, 45, 0));
        spawncollision("collision_player_64x64x256", "collider", (-853, 1187, 415), (0, 45, 0));
        spawncollision("collision_clip_256x256x256", "collider", (-746, 1201, -75), (0, 0, 0));
        spawncollision("collision_clip_64x64x256", "collider", (-969, -1839, -124), (0, 135, 0));
        spawncollision("collision_clip_wall_256x256x10", "collider", (-376, -1491, -115), (0, 314, 0));
    }
    level.cleandepositpoints = array((-97.928, -7.61413, 0.125), (1384.68, 1934.86, 8.125), (438.717, 1, 144.125), (857.493, -1991.98, 24.125));
}

// Namespace namespace_3411baba
// Params 0, eflags: 0x1 linked
// namespace_3411baba<file_0>::function_f7046c76
// Checksum 0x99ec1590, Offset: 0x888
// Size: 0x4
function precache() {
    
}

