#using scripts/codescripts/struct;
#using scripts/cp/_dialog;
#using scripts/cp/_load;
#using scripts/cp/_objectives;
#using scripts/cp/_oed;
#using scripts/cp/_skipto;
#using scripts/cp/_util;
#using scripts/cp/cp_mi_sing_blackstation_comm_relay;
#using scripts/cp/cp_mi_sing_blackstation_station;
#using scripts/cp/cp_mi_sing_blackstation_utility;
#using scripts/shared/ai_shared;
#using scripts/shared/array_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/colors_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/fx_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/trigger_shared;
#using scripts/shared/util_shared;
#using scripts/shared/vehicle_shared;

#namespace cp_mi_sing_blackstation_cross_debris;

// Namespace cp_mi_sing_blackstation_cross_debris
// Params 2
// Checksum 0x67738285, Offset: 0x7b0
// Size: 0x1ec
function objective_cross_debris_init( str_objective, b_starting )
{
    if ( b_starting )
    {
        load::function_73adcefc();
        blackstation_utility::init_hendricks( "objective_cross_debris" );
        blackstation_utility::init_kane( "objective_blackstation_exterior" );
        level.ai_kane ai::set_ignoreall( 1 );
        level thread function_b0ed4f4f();
        trigger::use( "triggercolor_walkway" );
        load::function_a2995f22();
    }
    
    level thread util::set_streamer_hint( 4 );
    level thread scene::play( "cin_bla_13_02_looting_vign_lightningstrike_ziplinetalk_kane_idle" );
    level thread cp_mi_sing_blackstation_station::function_5142ef8e();
    level thread blackstation_utility::player_rain_intensity( "light_ne" );
    level thread cross_debris_waypoints();
    level thread building_collapse();
    level thread atrium_destruction();
    level thread function_52065393();
    level.ai_hendricks thread cp_mi_sing_blackstation_station::function_a561f620();
    level.ai_hendricks thread blackstation_utility::dynamic_run_speed();
    level.ai_hendricks thread cross_debris_dialog();
    level.ai_hendricks thread hendricks_behavior();
}

// Namespace cp_mi_sing_blackstation_cross_debris
// Params 4
// Checksum 0x81fa9cc7, Offset: 0x9a8
// Size: 0x84
function objective_cross_debris_done( str_objective, b_starting, b_direct, player )
{
    if ( isdefined( level.ai_kane ) )
    {
        level.ai_kane skipto::teleport_single_ai( struct::get( "kane_ziplines", "script_noteworthy" ) );
    }
    
    level thread util::clear_streamer_hint();
}

// Namespace cp_mi_sing_blackstation_cross_debris
// Params 0
// Checksum 0x3502254a, Offset: 0xa38
// Size: 0x194
function function_b0ed4f4f()
{
    var_10d5eaaa = getent( "linkto_door_left", "targetname" );
    var_7bc07f9 = getent( "linkto_door_right", "targetname" );
    var_afbdfbfe = getent( "com_relay_bridge_doors_left", "targetname" );
    var_21829c35 = getent( "com_relay_bridge_doors_right", "targetname" );
    var_afbdfbfe linkto( var_10d5eaaa );
    var_21829c35 linkto( var_7bc07f9 );
    var_10d5eaaa rotateyaw( 100, 0.3 );
    var_7bc07f9 rotateyaw( -100, 0.3 );
    getent( "comrelay_door_clip_right", "targetname" ) delete();
    getent( "comrelay_door_clip_left", "targetname" ) delete();
}

// Namespace cp_mi_sing_blackstation_cross_debris
// Params 0
// Checksum 0xb6011feb, Offset: 0xbd8
// Size: 0x74
function function_52065393()
{
    trigger::wait_till( "trigger_vo_warn" );
    level thread scene::play( "p7_fxanim_cp_blackstation_collapsed_bldg_debris_01_bundle" );
    trigger::wait_till( "trigger_building_debris2" );
    level thread scene::play( "p7_fxanim_cp_blackstation_collapsed_bldg_debris_02_bundle" );
}

// Namespace cp_mi_sing_blackstation_cross_debris
// Params 0
// Checksum 0x2dfe892e, Offset: 0xc58
// Size: 0x9c
function cross_debris_waypoints()
{
    level thread objectives::breadcrumb( "cross_debris_breadcrumb" );
    trigger::wait_till( "trigger_under_zipline" );
    level thread objectives::breadcrumb( "trigger_zipline_breadcrumb", "cp_level_blackstation_climb" );
    level flag::wait_till( "goto_zipline" );
    skipto::objective_completed( "objective_cross_debris" );
}

// Namespace cp_mi_sing_blackstation_cross_debris
// Params 0
// Checksum 0x1de3d93c, Offset: 0xd00
// Size: 0xfc
function cross_debris_dialog()
{
    trigger::wait_till( "trigger_sky_bridge" );
    self dialog::say( "hend_structure_s_unstable_0" );
    level flag::wait_till( "in_atrium" );
    level dialog::player_say( "plyr_watch_out_hendricks_0", 1 );
    trigger::wait_till( "trigger_vo_warn" );
    self dialog::say( "hend_watch_your_step_b_0", 0.5 );
    level flag::wait_till( "vo_falling_apart" );
    level dialog::player_say( "plyr_this_place_is_fallin_0", 1 );
}

// Namespace cp_mi_sing_blackstation_cross_debris
// Params 0
// Checksum 0xc6919d44, Offset: 0xe08
// Size: 0xfc
function hendricks_behavior()
{
    level endon( #"hash_62f8dc0c" );
    self ai::set_ignoreall( 1 );
    level waittill( #"bridge_collapsed" );
    self colors::disable();
    level scene::add_scene_func( "cin_bla_12_01_cross_debris_vign_point", &function_8bcb3a1b );
    level scene::play( "cin_bla_12_01_cross_debris_vign_point", self );
    level flag::wait_till( "vo_falling_apart" );
    self colors::enable();
    level flag::set( "hendricks_crossed" );
    self ai::set_ignoreall( 1 );
}

// Namespace cp_mi_sing_blackstation_cross_debris
// Params 1
// Checksum 0xa1111c3f, Offset: 0xf10
// Size: 0x44
function function_8bcb3a1b( a_ents )
{
    level.ai_hendricks setgoal( getnode( "hendricks_crossdebris_landing", "targetname" ) );
}

// Namespace cp_mi_sing_blackstation_cross_debris
// Params 0
// Checksum 0x503e241, Offset: 0xf60
// Size: 0x1d6
function atrium_destruction()
{
    level flag::wait_till( "atrium_rubble_dropped" );
    
    foreach ( player in level.players )
    {
        player playrumbleonentity( "cp_blackstation_building_lean_rumble" );
    }
    
    a_s_windows = array::randomize( struct::get_array( "crossdebris_window" ) );
    
    for ( i = 0; i < 4 ; i++ )
    {
        glassradiusdamage( a_s_windows[ i ].origin, 100, 500, 500 );
        wait randomfloat( 1 );
    }
    
    level waittill( #"hash_b251293d" );
    
    for ( i = 4; i < a_s_windows.size ; i++ )
    {
        glassradiusdamage( a_s_windows[ i ].origin, 100, 500, 500 );
        wait randomfloat( 0.3 );
    }
}

// Namespace cp_mi_sing_blackstation_cross_debris
// Params 0
// Checksum 0x41d64e5f, Offset: 0x1140
// Size: 0x254
function building_collapse()
{
    level flag::wait_till( "in_atrium" );
    e_rubble = getent( "crossdebris_rubble_drop", "targetname" );
    e_rubble physicslaunch();
    level flag::set( "atrium_rubble_dropped" );
    v_origin = struct::get( "crossdebris_rubble_impact" ).origin;
    radiusdamage( v_origin, 800, 5, 5 );
    level scene::add_scene_func( "p7_fxanim_cp_blackstation_apartment_collapse_bundle", &function_beaf4ba6 );
    level scene::play( "p7_fxanim_cp_blackstation_apartment_collapse_bundle" );
    hidemiscmodels( "wooden_bridge" );
    showmiscmodels( "frogger_building_fallen" );
    array::run_all( getentarray( "wooden_bridge", "targetname" ), &hide );
    array::run_all( getentarray( "frogger_building_fallen", "targetname" ), &show );
    level flag::set( "bridge_collapsed" );
    mdl_clip = getent( "clip_building_collapse", "targetname" );
    
    if ( isdefined( mdl_clip ) )
    {
        mdl_clip delete();
    }
    
    level thread cp_mi_sing_blackstation_station::function_b8052aae();
}

// Namespace cp_mi_sing_blackstation_cross_debris
// Params 1
// Checksum 0x96ea6acd, Offset: 0x13a0
// Size: 0xba
function function_beaf4ba6( a_ents )
{
    exploder::exploder( "fx_expl_apartment_fall" );
    level waittill( #"hash_b251293d" );
    
    foreach ( player in level.players )
    {
        player playrumbleonentity( "cp_blackstation_building_collapse_rumble" );
    }
}

