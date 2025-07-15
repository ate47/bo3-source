#using scripts/codescripts/struct;
#using scripts/cp/_collectibles;
#using scripts/cp/_load;
#using scripts/cp/_objectives;
#using scripts/cp/_oed;
#using scripts/cp/_skipto;
#using scripts/cp/_util;
#using scripts/cp/cp_mi_cairo_ramses_accolades;
#using scripts/cp/cp_mi_cairo_ramses_fx;
#using scripts/cp/cp_mi_cairo_ramses_level_start;
#using scripts/cp/cp_mi_cairo_ramses_nasser_interview;
#using scripts/cp/cp_mi_cairo_ramses_patch;
#using scripts/cp/cp_mi_cairo_ramses_sound;
#using scripts/cp/cp_mi_cairo_ramses_station_fight;
#using scripts/cp/cp_mi_cairo_ramses_station_walk;
#using scripts/cp/cp_mi_cairo_ramses_utility;
#using scripts/cp/cp_mi_cairo_ramses_vtol_ride;
#using scripts/cp/gametypes/_battlechatter;
#using scripts/cp/gametypes/_save;
#using scripts/shared/ai_shared;
#using scripts/shared/array_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/colors_shared;
#using scripts/shared/compass;
#using scripts/shared/flag_shared;
#using scripts/shared/flagsys_shared;
#using scripts/shared/lui_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/trigger_shared;
#using scripts/shared/util_shared;
#using scripts/shared/vehicle_shared;
#using scripts/shared/vehicles/_quadtank;

#namespace cp_mi_cairo_ramses;

// Namespace cp_mi_cairo_ramses
// Params 0
// Checksum 0xe4511bd8, Offset: 0x980
// Size: 0x34
function setup_rex_starts()
{
    util::add_gametype( "coop" );
    util::add_gametype( "cpzm" );
}

// Namespace cp_mi_cairo_ramses
// Params 0
// Checksum 0x5a57b5b8, Offset: 0x9c0
// Size: 0x23c
function main()
{
    if ( sessionmodeiscampaignzombiesgame() && -1 )
    {
        setclearanceceiling( 34 );
    }
    else
    {
        setclearanceceiling( 23 );
    }
    
    savegame::set_mission_name( "ramses" );
    ramses_accolades::function_4d39a2af();
    ramses_accolades::function_43898266();
    ramses_accolades::function_e1862c87();
    ramses_accolades::function_3484502e();
    precache();
    init_clientfields();
    init_flags();
    init_level();
    setup_skiptos();
    util::init_streamer_hints( 3 );
    callback::on_connect( &on_player_connect );
    callback::on_spawned( &on_player_spawned );
    vehicle::add_spawn_function( "station_fight_turret", &station_turret_spawnfunc );
    cp_mi_cairo_ramses_fx::main();
    cp_mi_cairo_ramses_sound::main();
    load::main();
    setdvar( "compassmaxrange", "12000" );
    level clientfield::set( "ramses_station_lamps", 1 );
    
    /#
        execdevgui( "<dev string:x28>" );
    #/
    
    level thread set_sound_igc();
    level.var_dc236bc8 = 1;
    cp_mi_cairo_ramses_patch::function_7403e82b();
}

// Namespace cp_mi_cairo_ramses
// Params 0
// Checksum 0x99ec1590, Offset: 0xc08
// Size: 0x4
function precache()
{
    
}

// Namespace cp_mi_cairo_ramses
// Params 0
// Checksum 0x368b3596, Offset: 0xc18
// Size: 0x1b4
function init_clientfields()
{
    clientfield::register( "world", "hide_station_miscmodels", 1, 1, "int" );
    clientfield::register( "world", "turn_on_rotating_fxanim_fans", 1, 1, "int" );
    clientfield::register( "world", "turn_on_rotating_fxanim_lights", 1, 1, "int" );
    clientfield::register( "world", "delete_fxanim_fans", 1, 1, "int" );
    clientfield::register( "toplayer", "nasser_interview_extra_cam", 1, 1, "int" );
    clientfield::register( "toplayer", "rap_blood_on_player", 1, 1, "counter" );
    clientfield::register( "world", "ramses_station_lamps", 1, 1, "int" );
    clientfield::register( "world", "staging_area_intro", 1, 1, "int" );
    clientfield::register( "toplayer", "filter_ev_interference_toggle", 1, 1, "int" );
}

// Namespace cp_mi_cairo_ramses
// Params 0
// Checksum 0xcfbc5f8e, Offset: 0xdd8
// Size: 0x204
function init_flags()
{
    level flag::init( "dead_turrets_initialized" );
    level flag::init( "dead_turret_stop_station_ambients" );
    level flag::init( "station_walk_past_stairs" );
    level flag::init( "station_walk_complete" );
    level flag::init( "station_walk_cleanup" );
    level flag::init( "raps_intro_done" );
    level flag::init( "pod_hits_floor" );
    level flag::init( "ceiling_collapse_complete" );
    level flag::init( "drop_pod_opened_and_spawned" );
    level flag::init( "station_fight_completed" );
    level flag::init( "mobile_wall_fxanim_start" );
    level flag::init( "vtol_ride_started" );
    level flag::init( "vtol_ride_done" );
    level flag::init( "hendricks_jumpdirect_looping" );
    level flag::init( "khalil_jumpdirect_looping" );
    level flag::init( "flak_vtol_ride_stop" );
}

// Namespace cp_mi_cairo_ramses
// Params 0
// Checksum 0xd8cf3ca, Offset: 0xfe8
// Size: 0xcc
function init_level()
{
    skipto::set_skip_safehouse();
    level.b_tactical_mode_enabled = 0;
    level.b_enhanced_vision_enabled = 0;
    battlechatter::function_d9f49fba( 0, "bc" );
    var_69e9c588 = getentarray( "mobile_armory", "script_noteworthy" );
    a_ammo_cache = getentarray( "ammo_cache", "script_noteworthy" );
    level.var_2b205f01 = arraycombine( var_69e9c588, a_ammo_cache, 0, 0 );
}

// Namespace cp_mi_cairo_ramses
// Params 0
// Checksum 0xa8a6a400, Offset: 0x10c0
// Size: 0x14
function station_turret_spawnfunc()
{
    self.team = "allies";
}

// Namespace cp_mi_cairo_ramses
// Params 0
// Checksum 0x1f861082, Offset: 0x10e0
// Size: 0x194
function setup_skiptos()
{
    skipto::add( "level_start", &skipto_level_start_init, "level_start", &skipto_level_start_done );
    skipto::add( "rs_walk_through", &skipto_rs_walk_through_init, "rs_walk_through", &skipto_rs_walk_through_done );
    skipto::function_d68e678e( "interview_dr_nasser", &skipto_interview_dr_nasser_init, "interview_dr_nasser", &skipto_interview_dr_nasser_done );
    skipto::function_d68e678e( "defend_ramses_station", &station_fight::init, "defend_ramses_station", &station_fight::done );
    skipto::function_d68e678e( "vtol_ride", &vtol_ride::init, "vtol_ride", &vtol_ride::done );
    skipto::add_dev( "dev_defend_station_test", &station_fight::defend_station_test, "Defend Station Test", &station_fight::defend_station_done, "", "" );
}

// Namespace cp_mi_cairo_ramses
// Params 0
// Checksum 0xe367e22c, Offset: 0x1280
// Size: 0x24
function on_player_connect()
{
    self flag::init( "linked_to_truck" );
}

// Namespace cp_mi_cairo_ramses
// Params 0
// Checksum 0xd200b48a, Offset: 0x12b0
// Size: 0x1c
function on_player_spawned()
{
    self ramses_util::set_lighting_state_on_spawn();
}

// Namespace cp_mi_cairo_ramses
// Params 2
// Checksum 0xa6c1e55c, Offset: 0x12d8
// Size: 0x164
function skipto_level_start_init( str_objective, b_starting )
{
    callback::on_spawned( &level_start::setup_players_for_station_walk );
    
    if ( b_starting )
    {
        load::function_73adcefc();
        level_start::init_heroes( str_objective );
        ramses_util::set_lighting_state_start();
    }
    
    objectives::set( "cp_level_ramses_determine_what_salim_knows" );
    objectives::set( "cp_level_ramses_meet_with_khalil" );
    array::thread_all( level.var_2b205f01, &oed::disable_keyline );
    level.ai_hendricks setdedicatedshadow( 1 );
    level.ai_hendricks sethighdetail( 1 );
    level.ai_rachel sethighdetail( 1 );
    station_fight::intermediate_prop_state_hide();
    station_fight::hide_props( "_combat" );
    level_start::main();
}

// Namespace cp_mi_cairo_ramses
// Params 4
// Checksum 0x10485df1, Offset: 0x1448
// Size: 0xcc
function skipto_level_start_done( str_objective, b_starting, b_direct, player )
{
    if ( b_starting )
    {
        objectives::set( "cp_level_ramses_determine_what_salim_knows" );
        objectives::set( "cp_level_ramses_meet_with_khalil" );
    }
    
    station_fight::intermediate_prop_state_hide();
    station_fight::hide_props( "_combat" );
    ramses_util::set_lighting_state_start();
    level scene::init( "cin_ram_04_02_easterncheck_vign_jumpdirect" );
    level thread ramses_util::function_a0a9f927();
}

// Namespace cp_mi_cairo_ramses
// Params 2
// Checksum 0xec8335c9, Offset: 0x1520
// Size: 0x184
function skipto_rs_walk_through_init( str_objective, b_starting )
{
    level.ai_khalil = util::get_hero( "khalil" );
    level.ai_khalil sethighdetail( 1 );
    
    if ( b_starting )
    {
        load::function_73adcefc();
        callback::on_spawned( &level_start::setup_players_for_station_walk );
        cp_mi_cairo_ramses_station_walk::init_heroes( str_objective );
        array::thread_all( level.var_2b205f01, &oed::disable_keyline );
        load::function_a2995f22();
        util::screen_fade_out( 0, "black", "skipto_fade" );
        util::delay( 1, undefined, &util::screen_fade_in, 1, "black", "skipto_fade" );
    }
    
    cp_mi_cairo_ramses_nasser_interview::function_c99967dc( 0 );
    ramses_util::function_7255e66( 0 );
    cp_mi_cairo_ramses_station_walk::main();
}

// Namespace cp_mi_cairo_ramses
// Params 4
// Checksum 0xefb488d2, Offset: 0x16b0
// Size: 0x54
function skipto_rs_walk_through_done( str_objective, b_starting, b_direct, player )
{
    objectives::complete( "cp_level_ramses_go_to_holding_room" );
    objectives::complete( "cp_level_ramses_meet_with_khalil" );
}

// Namespace cp_mi_cairo_ramses
// Params 2
// Checksum 0x8786490d, Offset: 0x1710
// Size: 0x12c
function skipto_interview_dr_nasser_init( str_objective, b_starting )
{
    if ( b_starting )
    {
        load::function_73adcefc();
        cp_mi_cairo_ramses_nasser_interview::init_heroes();
        callback::on_spawned( &cp_mi_cairo_ramses_nasser_interview::function_1bcd464b );
        array::thread_all( level.var_2b205f01, &oed::disable_keyline );
        level.ai_khalil sethighdetail( 1 );
        level.ai_rachel sethighdetail( 1 );
        level.ai_hendricks sethighdetail( 1 );
    }
    
    objectives::set( "cp_level_ramses_interrogate_salim" );
    ramses_util::function_7255e66( 1 );
    cp_mi_cairo_ramses_nasser_interview::main( b_starting );
}

// Namespace cp_mi_cairo_ramses
// Params 4
// Checksum 0xb918aee8, Offset: 0x1848
// Size: 0x144
function skipto_interview_dr_nasser_done( str_objective, b_starting, b_direct, player )
{
    if ( b_starting )
    {
        array::thread_all( getentarray( "mobile_armory", "script_noteworthy" ), &oed::enable_keyline, 1 );
        objectives::complete( "cp_level_ramses_interrogate_salim" );
        objectives::complete( "cp_level_ramses_determine_what_salim_knows" );
        objectives::set( "cp_level_ramses_protect_salim" );
    }
    
    cp_mi_cairo_ramses_station_walk::function_51f408f1();
    level util::clientnotify( "walla_off" );
    oed::toggle_tac_mode_for_players();
    oed::toggle_thermal_mode_for_players();
    ramses_util::function_eabc6e2f();
    ramses_util::init_dead_turrets();
    ramses_util::function_e7ebe596( 0 );
}

// Namespace cp_mi_cairo_ramses
// Params 0
// Checksum 0x6e5e2da, Offset: 0x1998
// Size: 0x2c
function set_sound_igc()
{
    level waittill( #"cin_ram_01_01_enterstation_1st_ride_complete" );
    level util::clientnotify( "sndIGC" );
}

