#using scripts/codescripts/struct;
#using scripts/mp/_load;
#using scripts/mp/gametypes/_spawning;
#using scripts/mp/mp_rise_amb;
#using scripts/mp/mp_rise_fx;
#using scripts/shared/compass;

#namespace mp_rise;

// Namespace mp_rise
// Params 0
// Checksum 0x9cd17334, Offset: 0x2b8
// Size: 0x2a4
function main()
{
    mp_rise_fx::main();
    load::main();
    compass::setupminimap( "compass_map_mp_rise" );
    mp_rise_amb::main();
    setdvar( "compassmaxrange", "2100" );
    spawncollision( "collision_clip_wall_128x128x10", "collider", ( -626, -1033, 421.5 ), ( 0, 270, 0 ) );
    spawncollision( "collision_clip_wall_128x128x10", "collider", ( -692.5, -1033, 421.5 ), ( 0, 270, 0 ) );
    game[ "strings" ][ "war_callsign_a" ] = &"MPUI_CALLSIGN_MAPNAME_A";
    game[ "strings" ][ "war_callsign_b" ] = &"MPUI_CALLSIGN_MAPNAME_B";
    game[ "strings" ][ "war_callsign_c" ] = &"MPUI_CALLSIGN_MAPNAME_C";
    game[ "strings" ][ "war_callsign_d" ] = &"MPUI_CALLSIGN_MAPNAME_D";
    game[ "strings" ][ "war_callsign_e" ] = &"MPUI_CALLSIGN_MAPNAME_E";
    game[ "strings_menu" ][ "war_callsign_a" ] = "@MPUI_CALLSIGN_MAPNAME_A";
    game[ "strings_menu" ][ "war_callsign_b" ] = "@MPUI_CALLSIGN_MAPNAME_B";
    game[ "strings_menu" ][ "war_callsign_c" ] = "@MPUI_CALLSIGN_MAPNAME_C";
    game[ "strings_menu" ][ "war_callsign_d" ] = "@MPUI_CALLSIGN_MAPNAME_D";
    game[ "strings_menu" ][ "war_callsign_e" ] = "@MPUI_CALLSIGN_MAPNAME_E";
    level.cleandepositpoints = array( ( 1474.24, -192.491, 223.118 ), ( -1052.99, 198.376, 221.118 ), ( 433.258, -203.319, 255.118 ), ( 789.562, 1376.41, 247.118 ) );
}

