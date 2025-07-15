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
// Params 0
// Checksum 0xe6cf1795, Offset: 0x5f0
// Size: 0x34
function setup_rex_starts()
{
    util::add_gametype( "coop" );
    util::add_gametype( "cpzm" );
}

// Namespace cp_mi_cairo_infection3
// Params 0
// Checksum 0xd796edb1, Offset: 0x630
// Size: 0x324
function main()
{
    if ( sessionmodeiscampaignzombiesgame() && -1 )
    {
        setclearanceceiling( 34 );
    }
    else
    {
        setclearanceceiling( 17 );
    }
    
    savegame::set_mission_name( "infection" );
    util::init_streamer_hints( 11 );
    skipto_setup();
    callback::on_spawned( &on_player_spawned );
    infection_zombies::main();
    hideout_outro::main();
    infection_accolades::function_66df416f();
    cp_mi_cairo_infection3_fx::main();
    cp_mi_cairo_infection3_sound::main();
    load::main();
    setdvar( "compassmaxrange", "2100" );
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
    objectives::complete( "cp_level_infection_find_dr" );
    objectives::complete( "cp_level_infection_defeat_sarah" );
    objectives::complete( "cp_level_infection_interface_sarah" );
    objectives::complete( "cp_level_infection_cross_chasm" );
    objectives::complete( "cp_level_infection_follow_sarah" );
    objectives::complete( "cp_level_infection_destroy_quadtank" );
    objectives::complete( "cp_level_infection_confront_sarah" );
    cp_mi_cairo_infection3_patch::function_7403e82b();
}

// Namespace cp_mi_cairo_infection3
// Params 0
// Checksum 0xb29b281f, Offset: 0x960
// Size: 0x66
function on_player_spawned()
{
    self thread infection_util::zombie_behind_vox();
    a_skiptos = skipto::get_current_skiptos();
    
    if ( isdefined( a_skiptos ) )
    {
        switch ( a_skiptos[ 0 ] )
        {
            default:
                break;
        }
    }
}

// Namespace cp_mi_cairo_infection3
// Params 0
// Checksum 0x193ac70f, Offset: 0x9d0
// Size: 0x1c4
function skipto_setup()
{
    skipto::add( "hideout", &hideout_outro::hideout_main, "HIDEOUT", &hideout_outro::hideout_cleanup );
    skipto::add( "interrogation", &hideout_outro::interrogation_main, "INTERROGATION", &hideout_outro::interrogation_cleanup );
    skipto::add( "city_barren", &hideout_outro::stalingrad_creation_main, "STALINGRAD CREATION", &hideout_outro::stalingrad_creation_cleanup );
    skipto::function_d68e678e( "city", &hideout_outro::pavlovs_house_main, "ZOMBIES", &hideout_outro::pavlovs_house_cleanup );
    skipto::add( "city_tree", &hideout_outro::pavlovs_house_end, "ZOMBIES_END", &hideout_outro::pavlovs_end_cleanup );
    skipto::function_d68e678e( "city_nuked", &hideout_outro::stalingrad_nuke_main, "NUKE", &hideout_outro::stalingrad_nuke_cleanup );
    skipto::add( "outro", &hideout_outro::outro_main, "OUTRO", &hideout_outro::outro_cleanup );
}

