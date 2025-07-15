#using scripts/codescripts/struct;
#using scripts/cp/_accolades;
#using scripts/cp/_ammo_cache;
#using scripts/cp/_load;
#using scripts/cp/_objectives;
#using scripts/cp/_skipto;
#using scripts/cp/_util;
#using scripts/cp/cp_mi_cairo_infection_accolades;
#using scripts/cp/cp_mi_cairo_infection_fx;
#using scripts/cp/cp_mi_cairo_infection_patch;
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
// Params 0
// Checksum 0x1bddde66, Offset: 0x650
// Size: 0x34
function setup_rex_starts()
{
    util::add_gametype( "coop" );
    util::add_gametype( "cpzm" );
}

// Namespace cp_mi_cairo_infection
// Params 0
// Checksum 0xf7f9b70, Offset: 0x690
// Size: 0x2a4
function main()
{
    init_clientfields();
    setclearanceceiling( 111 );
    savegame::set_mission_name( "infection" );
    skipto_setup();
    util::init_streamer_hints( 11 );
    callback::on_spawned( &on_player_spawned );
    sarah_battle::main();
    sim_reality_starts::main();
    sgen_test_chamber::main();
    infection_accolades::function_66df416f();
    cp_mi_cairo_infection_fx::main();
    cp_mi_cairo_infection_sound::main();
    skipto::set_skip_safehouse();
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
    level._effect[ "player_dirt_loop" ] = "dirt/fx_dust_sand_storm_player_loop";
    level.var_dc236bc8 = 1;
    cp_mi_cairo_infection_patch::function_7403e82b();
}

// Namespace cp_mi_cairo_infection
// Params 0
// Checksum 0x3dfdae5d, Offset: 0x940
// Size: 0x34
function init_clientfields()
{
    clientfield::register( "world", "set_exposure_bank", 1, 2, "int" );
}

// Namespace cp_mi_cairo_infection
// Params 0
// Checksum 0xaffe0d9d, Offset: 0x980
// Size: 0x13a
function on_player_spawned()
{
    a_skiptos = skipto::get_current_skiptos();
    
    if ( isdefined( a_skiptos ) )
    {
        switch ( a_skiptos[ 0 ] )
        {
            case "vtol_arrival":
                self infection_util::player_enter_cinematic();
                break;
            case "sarah_battle":
                self util::set_lighting_state( 1 );
                self thread function_4fbaf6d6();
                break;
            case "sarah_battle_end":
                self util::set_lighting_state( 1 );
                break;
            case "sim_reality_starts":
                self thread reset_snow_fx_respawn();
                self infection_util::player_enter_cinematic();
                break;
            case "cyber_soliders_invest":
            case "sgen_test_chamber":
            case "time_lapse":
                self infection_util::player_enter_cinematic();
                break;
            default:
                break;
        }
    }
}

// Namespace cp_mi_cairo_infection
// Params 0
// Checksum 0xe31c5c56, Offset: 0xac8
// Size: 0xb4
function function_4fbaf6d6()
{
    level waittill( #"intial_battle_vo_done" );
    fx_origin = util::spawn_model( "tag_origin", self.origin, self.angles );
    playfxontag( level._effect[ "player_dirt_loop" ], fx_origin, "tag_origin" );
    fx_origin linkto( self );
    level waittill( #"sarah_battle_end" );
    fx_origin delete();
}

// Namespace cp_mi_cairo_infection
// Params 1
// Checksum 0x4d8c7f9d, Offset: 0xb88
// Size: 0x4c
function reset_snow_fx_respawn( n_id )
{
    self infection_util::snow_fx_stop();
    util::wait_network_frame();
    self infection_util::snow_fx_play( n_id );
}

// Namespace cp_mi_cairo_infection
// Params 0
// Checksum 0x44f55dd8, Offset: 0xbe0
// Size: 0x214
function skipto_setup()
{
    skipto::add( "vtol_arrival", &sarah_battle::vtol_arrival_init, "VTOL ARRIVAL", &sarah_battle::vtol_arrival_done );
    skipto::add( "sarah_battle", &sarah_battle::sarah_battle_init, "SARAH BATTLE", &sarah_battle::sarah_battle_done );
    skipto::function_d68e678e( "sarah_battle_end", &sarah_battle::sarah_battle_end_init, "SARAH BATTLE END", &sarah_battle::sarah_battle_end_done );
    skipto::add( "sim_reality_starts", &sim_reality_starts::sim_reality_starts_init, "BIRTH OF THE AI", &sim_reality_starts::sim_reality_starts_done );
    skipto::function_d68e678e( "sgen_test_chamber", &sgen_test_chamber::sgen_test_chamber_init, "SGEN - 2060", &sgen_test_chamber::sgen_test_chamber_done );
    skipto::add( "time_lapse", &sgen_test_chamber::time_lapse_init, "SGEN - TIME LAPSE", &sgen_test_chamber::time_lapse_done );
    skipto::add( "cyber_soliders_invest", &sgen_test_chamber::cyber_soliders_invest_init, "SGEN - 2070", &sgen_test_chamber::cyber_soliders_invest_done );
    skipto::add_dev( "dev_skipto_infection_2", &skipto_infection_2 );
    skipto::add_dev( "dev_skipto_infection_3", &skipto_infection_3 );
}

// Namespace cp_mi_cairo_infection
// Params 2
// Checksum 0xf89bc712, Offset: 0xe00
// Size: 0x44
function skipto_infection_2( str_objective, b_starting )
{
    switchmap_load( "cp_mi_cairo_infection2" );
    wait 0.05;
    switchmap_switch();
}

// Namespace cp_mi_cairo_infection
// Params 2
// Checksum 0x4e46ef4c, Offset: 0xe50
// Size: 0x44
function skipto_infection_3( str_objective, b_starting )
{
    switchmap_load( "cp_mi_cairo_infection3" );
    wait 0.05;
    switchmap_switch();
}

