#using scripts/codescripts/struct;
#using scripts/cp/_dialog;
#using scripts/cp/_hacking;
#using scripts/cp/_load;
#using scripts/cp/_objectives;
#using scripts/cp/_oed;
#using scripts/cp/_skipto;
#using scripts/cp/_spawn_manager;
#using scripts/cp/_util;
#using scripts/cp/cp_mi_sing_blackstation_accolades;
#using scripts/cp/cp_mi_sing_blackstation_sound;
#using scripts/cp/cp_mi_sing_blackstation_subway;
#using scripts/cp/cp_mi_sing_blackstation_utility;
#using scripts/cp/cybercom/_cybercom;
#using scripts/cp/cybercom/_cybercom_gadget_concussive_wave;
#using scripts/cp/cybercom/_cybercom_util;
#using scripts/cp/gametypes/_save;
#using scripts/cp/gametypes/_spawnlogic;
#using scripts/cp/gametypes/coop;
#using scripts/shared/ai/systems/animation_state_machine_notetracks;
#using scripts/shared/ai/systems/animation_state_machine_utility;
#using scripts/shared/ai/systems/behavior_tree_utility;
#using scripts/shared/ai_shared;
#using scripts/shared/array_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/colors_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/flagsys_shared;
#using scripts/shared/fx_shared;
#using scripts/shared/gameobjects_shared;
#using scripts/shared/laststand_shared;
#using scripts/shared/math_shared;
#using scripts/shared/player_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/system_shared;
#using scripts/shared/trigger_shared;
#using scripts/shared/turret_shared;
#using scripts/shared/util_shared;
#using scripts/shared/vehicle_shared;
#using scripts/shared/vehicleriders_shared;
#using scripts/shared/weapons_shared;

#namespace cp_mi_sing_blackstation_port;

// Namespace cp_mi_sing_blackstation_port
// Params 0
// Checksum 0x81c3071b, Offset: 0x2000
// Size: 0x34
function main()
{
    level thread blackstation_utility::pier_safe_zones();
    level thread wheelhouse_node_handler();
}

// Namespace cp_mi_sing_blackstation_port
// Params 2
// Checksum 0xb8fd1d20, Offset: 0x2040
// Size: 0x354
function anchor_intro( str_objective, b_starting )
{
    if ( b_starting )
    {
        load::function_73adcefc();
        blackstation_utility::init_hendricks( "objective_anchor_intro" );
        level thread blackstation_utility::dead_civilians();
        level thread function_21f63154();
        level thread objectives::breadcrumb( "anchor_intro_breadcrumb", "cp_level_blackstation_climb" );
        level thread debris_mound_breadcrumb();
        level thread blackstation_utility::function_46dd77b0();
        load::function_a2995f22();
        wait 0.2;
        level thread blackstation_utility::hendricks_debris_traversal_ready();
    }
    
    level scene::init( "p7_fxanim_cp_blackstation_boatroom_bundle" );
    
    if ( isdefined( level.bzm_blackstationdialogue3_1callback ) )
    {
        level thread [[ level.bzm_blackstationdialogue3_1callback ]]();
    }
    
    level thread function_b7f1a1f6();
    level thread blackstation_utility::player_rain_intensity( "med_se" );
    level thread debris_toilet_launch();
    level thread blackstation_utility::random_debris();
    level thread blackstation_utility::debris_at_players();
    level thread blackstation_utility::debris_embedded_trigger();
    level thread tanker_movement();
    level thread hendricks_anchor_warning();
    level thread kane_missiles( 1 );
    level thread function_94ff5bc0();
    level thread blackstation_utility::function_70aaf37b( 0 );
    t_intro_storm = getent( "anchor_intro_wind", "targetname" );
    t_intro_storm trigger::wait_till();
    t_intro_storm thread blackstation_utility::wind_manager();
    
    foreach ( player in level.activeplayers )
    {
        player thread blackstation_utility::setup_wind_storm();
    }
    
    level flag::wait_till( "anchor_intro_done" );
    skipto::objective_completed( "objective_anchor_intro" );
}

// Namespace cp_mi_sing_blackstation_port
// Params 4
// Checksum 0xf265aed9, Offset: 0x23a0
// Size: 0x44
function anchor_intro_done( str_objective, b_starting, b_direct, player )
{
    level thread scene::play( "p7_fxanim_gp_umbrella_outdoor_worn_01_bundle" );
}

// Namespace cp_mi_sing_blackstation_port
// Params 2
// Checksum 0xba465469, Offset: 0x23f0
// Size: 0x54c
function port_assault( str_objective, b_starting )
{
    spawner::add_global_spawn_function( "axis", &function_13e164f4 );
    spawner::add_spawn_function_group( "port_enemy", "script_noteworthy", &port_enemy_spawnfunc );
    spawner::add_spawn_function_group( "wind_rpg", "script_string", &function_6a0ccfd );
    vehicle::add_spawn_function( "port_assault_tech", &setup_port_technical );
    level thread function_17c457d7();
    level thread objectives::breadcrumb( "port_assault_breadcrumb" );
    level thread blackstation_utility::player_rain_intensity( "med_se" );
    
    if ( b_starting )
    {
        load::function_73adcefc();
        exploder::exploder( "fx_expl_hotel_rain_windows" );
        blackstation_utility::init_hendricks( "objective_port_assault" );
        level thread blackstation_utility::function_70aaf37b( 1 );
        level thread tanker_movement();
        level thread blackstation_utility::dead_civilians();
        level scene::skipto_end( "p7_fxanim_cp_blackstation_boatroom_bundle" );
        trigger::use( "trigger_hendricks_anchor_done" );
        load::function_a2995f22();
        level flag::set( "anchor_intro_done" );
        level thread kane_missiles( 0 );
    }
    else
    {
        level thread function_925a5c0b();
    }
    
    level thread port_assault_enemies();
    level thread port_assault_truck();
    level thread surge_debris_portstart();
    level thread surge_debris_restaurant();
    level thread function_b8500bb1();
    level thread function_5b85480f();
    level.ai_hendricks.is_in_safety_zone = 0;
    level thread function_b73344f6();
    t_surge = getent( "port_assault_low_surge", "targetname" );
    level thread blackstation_utility::setup_surge( t_surge );
    array::thread_all( level.activeplayers, &blackstation_utility::player_surge_trigger_tracker );
    array::thread_all( level.activeplayers, &clientfield::set_to_player, "toggle_rain_sprite", 0 );
    
    if ( isdefined( level.bzm_blackstationdialogue3_2callback ) )
    {
        level thread [[ level.bzm_blackstationdialogue3_2callback ]]();
    }
    
    trigger::use( "port_assault_start", "targetname", undefined, 0 );
    trigger::wait_till( "surge_tutorial" );
    level flag::set( "end_surge_start" );
    level.ai_hendricks dialog::say( "hend_these_waves_are_gonn_0" );
    
    foreach ( player in level.activeplayers )
    {
        player blackstation_utility::anchor_tutorial();
    }
    
    level thread function_3e1b1aaa();
    flag::wait_till( "start_barge" );
    level thread cargo_ship_rocker();
    level thread port_assault_vo();
    trigger::wait_till( "end_port_assault" );
    level skipto::objective_completed( "objective_port_assault" );
}

// Namespace cp_mi_sing_blackstation_port
// Params 4
// Checksum 0x9c507b34, Offset: 0x2948
// Size: 0x3c
function port_assault_done( str_objective, b_starting, b_direct, player )
{
    objectives::complete( "cp_level_blackstation_goto_docks" );
}

// Namespace cp_mi_sing_blackstation_port
// Params 2
// Checksum 0x92423b05, Offset: 0x2990
// Size: 0x3ac
function barge_assault( str_objective, b_starting )
{
    setdvar( "phys_gravity_dir", ( 0, -0.5, 0.9 ) );
    level thread spawn_pier_guards( b_starting );
    
    if ( b_starting )
    {
        load::function_73adcefc();
        level thread tanker_movement();
        level thread function_b8500bb1();
        level thread cargo_ship_rocker();
        level thread surge_debris_portbuilding( b_starting );
        blackstation_utility::init_hendricks( "objective_barge_assault" );
        level thread blackstation_utility::function_70aaf37b( 1 );
        level.ai_hendricks.is_in_safety_zone = 0;
        t_surge = getent( "port_assault_low_surge", "targetname" );
        level thread blackstation_utility::setup_surge( t_surge );
        array::thread_all( level.activeplayers, &blackstation_utility::player_surge_trigger_tracker );
        spawner::add_global_spawn_function( "axis", &function_13e164f4 );
        level flag::wait_till_all( array( "all_players_spawned", "start_objective_barge_assault" ) );
        trigger::use( "move_to_pier" );
    }
    
    array::thread_all( level.activeplayers, &clientfield::set_to_player, "toggle_rain_sprite", 1 );
    level thread objectives::breadcrumb( "barge_assault_breadcrumb" );
    level thread blackstation_utility::player_rain_intensity( "drench_se" );
    level thread pier_events();
    level thread truck_pier();
    level thread barge_assault_vo();
    level thread pre_breach();
    level thread function_22a0015b();
    level thread pier_guard_smash();
    level thread function_7a7390dd();
    array::thread_all( getentarray( "barge_current", "targetname" ), &blackstation_utility::function_76b75dc7, "objective_storm_surge_terminate", -60, 300 );
    level flag::wait_till( "breached" );
    level skipto::objective_completed( "objective_barge_assault" );
}

// Namespace cp_mi_sing_blackstation_port
// Params 4
// Checksum 0xcfc0284f, Offset: 0x2d48
// Size: 0x3c
function barge_assault_done( str_objective, b_starting, b_direct, player )
{
    objectives::complete( "cp_level_blackstation_board_ship" );
}

// Namespace cp_mi_sing_blackstation_port
// Params 2
// Checksum 0x5282ca39, Offset: 0x2d90
// Size: 0x20c
function storm_surge( str_objective, b_starting )
{
    if ( b_starting )
    {
        load::function_73adcefc();
        blackstation_utility::init_hendricks( "objective_storm_surge" );
        level thread blackstation_utility::function_70aaf37b( 1 );
        level thread function_b8500bb1();
        level thread tanker_movement();
        level cargo_ship_rocker();
        level thread enable_breach_triggers( b_starting );
        level thread surge_debris_portbuilding( b_starting );
        level thread function_22a0015b();
        
        while ( !level scene::is_ready( "p7_fxanim_cp_blackstation_barge_roof_break_bundle" ) )
        {
            util::wait_network_frame();
        }
        
        load::function_a2995f22();
        trigger::use( "hendricks_breach" );
        array::thread_all( getentarray( "barge_current", "targetname" ), &blackstation_utility::function_76b75dc7, "objective_storm_surge_terminate", -60, 300 );
    }
    
    spawner::remove_global_spawn_function( "axis", &function_13e164f4 );
    level flag::wait_till( "tanker_ride_done" );
    level skipto::objective_completed( "objective_storm_surge" );
}

// Namespace cp_mi_sing_blackstation_port
// Params 4
// Checksum 0x9e58fb7a, Offset: 0x2fa8
// Size: 0x1da
function storm_surge_done( str_objective, b_starting, b_direct, player )
{
    a_deck_ents = getentarray( "barge_ents", "script_noteworthy" );
    array::thread_all( a_deck_ents, &util::self_delete );
    a_e_barge_roof = getentarray( "barge_roof", "targetname" );
    array::thread_all( a_e_barge_roof, &util::self_delete );
    a_e_cover = getentarray( "wharf_debris", "script_noteworthy" );
    array::thread_all( a_e_cover, &util::self_delete );
    objectives::complete( "cp_level_blackstation_wheelhouse" );
    objectives::complete( "cp_level_blackstation_intercept" );
    
    foreach ( player in level.players )
    {
        if ( isdefined( player.mdl_link ) )
        {
            player.mdl_link delete();
        }
    }
}

// Namespace cp_mi_sing_blackstation_port
// Params 0
// Checksum 0x564e754e, Offset: 0x3190
// Size: 0x134
function hendricks_anchor_warning()
{
    level endon( #"kill_warning_vo" );
    a_str_vo = array( "hend_brace_yourself_0", "hend_wind_s_picking_up_0", "hend_anchor_now_0", "hend_use_your_anchor_0" );
    
    while ( true )
    {
        level waittill( #"wind_warning" );
        
        if ( !flag::get( "warning_vo_played" ) )
        {
            level.ai_hendricks dialog::say( "hend_wind_s_picking_up_0" );
            flag::set( "warning_vo_played" );
        }
        else if ( a_str_vo.size )
        {
            str_vo = array::random( a_str_vo );
            level.ai_hendricks dialog::say( str_vo );
            arrayremovevalue( a_str_vo, str_vo );
        }
        else
        {
            level notify( #"kill_warning_vo" );
        }
        
        wait 0.1;
    }
}

// Namespace cp_mi_sing_blackstation_port
// Params 0
// Checksum 0x9ed0b9bc, Offset: 0x32d0
// Size: 0xb6
function say_wind_warning()
{
    switch ( randomintrange( 0, 2 ) )
    {
        case 0:
            level.ai_hendricks dialog::say( "hend_wind_s_picking_up_0" );
            break;
        case 1:
            level.ai_hendricks dialog::say( "hend_anchor_now_0" );
            break;
        default:
            level.ai_hendricks dialog::say( "hend_use_your_anchor_0" );
            break;
    }
}

// Namespace cp_mi_sing_blackstation_port
// Params 0
// Checksum 0xbad15db2, Offset: 0x3390
// Size: 0x1f4
function function_b7f1a1f6()
{
    level thread function_e774fcfd();
    level flag::wait_till( "hendricks_debris_traversal_ready" );
    level flag::wait_till( "debris_path_one_ready" );
    level thread scene::play( "cin_bla_05_01_debristraversal_vign_useanchor_first_climb" );
    level waittill( #"hash_6087df83" );
    level function_e60704dd( "debris_path_two_ready" );
    level thread scene::play( "cin_bla_05_01_debristraversal_vign_useanchor_second_climb" );
    level waittill( #"hash_c52658cf" );
    level function_e60704dd( "debris_path_three_ready" );
    str_scene = "cin_bla_05_01_debristraversal_vign_useanchor_splitpath_path_a_first";
    level thread scene::play( str_scene );
    level waittill( #"hash_6ec92f04" );
    level function_e60704dd( "debris_path_four_ready" );
    str_scene = "cin_bla_05_01_debristraversal_vign_useanchor_splitpath_path_a_second";
    level thread scene::play( str_scene );
    level waittill( #"hash_9871d9f3" );
    level function_e60704dd( "debris_path_five_ready" );
    level thread scene::play( "cin_bla_05_01_debristraversal_vign_useanchor_end_climb" );
    level waittill( #"hash_9871d9f3" );
    level flag::set( "allow_wind_gust" );
    level.ai_hendricks colors::enable();
}

// Namespace cp_mi_sing_blackstation_port
// Params 1
// Checksum 0x749f2a0a, Offset: 0x3590
// Size: 0x8c
function function_e60704dd( var_530a613c )
{
    level flag::set( "end_gust_warning" );
    level flag::wait_till( var_530a613c );
    wait 0.05;
    level flag::clear( "allow_wind_gust" );
    level flag::wait_till( "kill_weather" );
}

// Namespace cp_mi_sing_blackstation_port
// Params 0
// Checksum 0xb8873eb0, Offset: 0x3628
// Size: 0xa4
function function_e774fcfd()
{
    level flag::wait_till( "debris_path_one_ready" );
    
    if ( !level flag::get( "hendricks_anchor_close" ) )
    {
        level flag::set( "allow_wind_gust" );
        level flag::wait_till( "hendricks_anchor_close" );
        level flag::clear( "allow_wind_gust" );
    }
}

// Namespace cp_mi_sing_blackstation_port
// Params 0
// Checksum 0x91e0047c, Offset: 0x36d8
// Size: 0x144
function function_21f63154()
{
    scene::init( "p7_fxanim_cp_blackstation_anchor_beginning_event_back_bundle" );
    util::wait_network_frame();
    scene::init( "p7_fxanim_cp_blackstation_anchor_beginning_event_left_bundle" );
    util::wait_network_frame();
    level thread function_e3f6a644( "left" );
    scene::init( "p7_fxanim_cp_blackstation_anchor_beginning_event_right_bundle" );
    util::wait_network_frame();
    level thread function_e3f6a644( "right" );
    scene::init( "p7_fxanim_cp_blackstation_anchor_beginning_car_debris_bundle" );
    trigger::wait_till( "trigger_hendricks_hotel_approach" );
    level thread scene::play( "p7_fxanim_cp_blackstation_anchor_beginning_event_back_bundle" );
    trigger::wait_till( "anchor_arch" );
    level thread scene::play( "p7_fxanim_cp_blackstation_anchor_beginning_car_debris_bundle" );
}

// Namespace cp_mi_sing_blackstation_port
// Params 1
// Checksum 0xc7d74ad2, Offset: 0x3828
// Size: 0xa4
function function_e3f6a644( str_side )
{
    str_trigger_name = "anchor_fxanim_" + str_side;
    var_2818e4cc = getent( str_trigger_name, "targetname" );
    var_2818e4cc endon( #"death" );
    var_2818e4cc waittill( #"trigger" );
    str_bundle = "p7_fxanim_cp_blackstation_anchor_beginning_event_" + str_side + "_bundle";
    scene::play( str_bundle );
}

// Namespace cp_mi_sing_blackstation_port
// Params 0
// Checksum 0x69df8f81, Offset: 0x38d8
// Size: 0x3c
function function_925a5c0b()
{
    level flag::wait_till( "setup_hotel_blocker" );
    level thread blackstation_utility::function_70aaf37b( 1 );
}

// Namespace cp_mi_sing_blackstation_port
// Params 1
// Checksum 0xf34764de, Offset: 0x3920
// Size: 0x2bc
function kane_missiles( var_f47b4e2b )
{
    spawner::add_spawn_function_group( "substation_enemy", "script_noteworthy", &function_ee4f2519 );
    
    if ( var_f47b4e2b )
    {
        level scene::init( "p7_fxanim_cp_blackstation_missile_building_bundle" );
        trigger::wait_till( "trigger_hendricks_anchor_done" );
        level scene::init( "cin_bla_06_02_portassault_vign_roof_workers" );
        level dialog::remote( "kane_we_are_a_go_on_dro_0" );
        level thread dialog::remote( "dops_we_re_live_strike_i_0" );
        trigger::wait_till( "port_assault_start" );
    }
    else
    {
        level scene::init( "cin_bla_06_02_portassault_vign_roof_workers" );
        level thread function_b0f369dc();
    }
    
    level thread scene::play( "p7_fxanim_cp_blackstation_missile_building_bundle" );
    trigger::use( "hotel_wait" );
    level waittill( #"blast" );
    level thread function_eabab8e4();
    level dialog::remote( "dops_negative_effect_inc_0" );
    level.ai_hendricks ai::set_ignoreall( 1 );
    
    if ( !level flag::get( "hotel_exit" ) )
    {
        level scene::add_scene_func( "cin_bla_06_02_portassault_vign_drone_react", &function_84be5124 );
        level scene::play( "cin_bla_06_02_portassault_vign_drone_react" );
    }
    else if ( level scene::is_active( "cin_bla_06_02_portassault_vign_drone_react" ) )
    {
        level scene::stop( "cin_bla_06_02_portassault_vign_drone_react" );
    }
    
    level thread namespace_4297372::function_91146001();
    level.ai_hendricks ai::set_ignoreall( 0 );
    level flag::set( "drone_strike" );
}

// Namespace cp_mi_sing_blackstation_port
// Params 0
// Checksum 0x717708d5, Offset: 0x3be8
// Size: 0xea
function function_eabab8e4()
{
    var_c6dce143 = struct::get( "objective_port_assault_ai" );
    
    foreach ( player in level.activeplayers )
    {
        if ( distance2dsquared( player.origin, var_c6dce143.origin ) <= 490000 )
        {
            player playrumbleonentity( "cp_blackstation_tanker_building_rumble" );
        }
    }
}

// Namespace cp_mi_sing_blackstation_port
// Params 1
// Checksum 0x4c94d2e3, Offset: 0x3ce0
// Size: 0x44
function function_84be5124( a_ents )
{
    wait 1;
    level.ai_hendricks colors::enable();
    trigger::use( "triggercolor_drone_strike" );
}

// Namespace cp_mi_sing_blackstation_port
// Params 0
// Checksum 0x380f830, Offset: 0x3d30
// Size: 0x84
function function_b0f369dc()
{
    var_fd585438 = getnode( "anchor_end_wait", "targetname" );
    level.ai_hendricks setgoal( var_fd585438, 1 );
    level.ai_hendricks waittill( #"goal" );
    level scene::init( "cin_bla_06_02_portassault_vign_drone_react" );
}

// Namespace cp_mi_sing_blackstation_port
// Params 0
// Checksum 0xf229ac55, Offset: 0x3dc0
// Size: 0x34
function lightning_port_assault()
{
    level endon( #"surge_done" );
    level thread blackstation_utility::lightning_flashes( "lightning_port", "surge_done" );
}

// Namespace cp_mi_sing_blackstation_port
// Params 0
// Checksum 0xc2386656, Offset: 0x3e00
// Size: 0x6c
function function_17c457d7()
{
    level scene::init( "p7_fxanim_cp_blackstation_roof_vent_bundle" );
    level waittill( #"wind_gust" );
    level thread scene::play( "cin_bla_06_02_portassault_vign_roof_workers" );
    level scene::play( "p7_fxanim_cp_blackstation_roof_vent_bundle" );
}

// Namespace cp_mi_sing_blackstation_port
// Params 1
// Checksum 0xc8ceb17, Offset: 0x3e78
// Size: 0xcc
function function_ee4f2519( str_dir )
{
    self endon( #"death" );
    self.b_swept = 0;
    self thread blackstation_accolades::function_af8faf92();
    self ai::set_behavior_attribute( "sprint", 1 );
    self ai::set_ignoreme( 1 );
    self ai::set_ignoreall( 1 );
    self.goalradius = 1;
    self setgoal( self.origin );
    level waittill( #"wind_gust" );
    self thread port_assault_retreat();
}

// Namespace cp_mi_sing_blackstation_port
// Params 0
// Checksum 0x67ca62af, Offset: 0x3f50
// Size: 0x26c
function port_assault_retreat()
{
    self endon( #"death" );
    wait randomfloatrange( 0.3, 1 );
    self ai::set_ignoreme( 0 );
    self ai::set_ignoreall( 0 );
    s_start = struct::get( "retreat_pt1" );
    s_mid = struct::get( "retreat_pt2" );
    s_end = struct::get( "retreat_pt3" );
    vol_port = getent( "vol_port_building", "targetname" );
    self.goalradius = 2048;
    self setgoal( s_start.origin + ( randomint( 80 ), randomint( 80 ), 0 ), 1 );
    self waittill( #"goal" );
    self setgoal( s_mid.origin + ( randomint( 80 ), randomint( 80 ), 0 ), 1 );
    self waittill( #"goal" );
    self setgoal( s_end.origin + ( randomint( 120 ), randomint( 120 ), 0 ), 1 );
    self waittill( #"goal" );
    self clearforcedgoal();
    self setgoal( vol_port );
}

// Namespace cp_mi_sing_blackstation_port
// Params 0
// Checksum 0x13074ddb, Offset: 0x41c8
// Size: 0x9c
function surge_debris_portstart()
{
    trigger::wait_till( "trigger_surge_debris1" );
    t_start = getent( "surge_port_start", "script_noteworthy" );
    a_e_debris = getentarray( "debris_surge_0", "targetname" );
    level thread blackstation_utility::function_3c57957( t_start, a_e_debris, "start_barge" );
}

// Namespace cp_mi_sing_blackstation_port
// Params 0
// Checksum 0x1551fce2, Offset: 0x4270
// Size: 0x9c
function surge_debris_restaurant()
{
    level flag::wait_till( "start_barge" );
    t_start = getent( "surge_port_restaurant", "script_noteworthy" );
    
    while ( level flag::get( "surge_active" ) )
    {
        wait 0.05;
    }
    
    level thread blackstation_utility::function_3c57957( t_start, undefined, "end_surge_rest" );
}

// Namespace cp_mi_sing_blackstation_port
// Params 1
// Checksum 0xf752d68b, Offset: 0x4318
// Size: 0x13c
function surge_debris_portbuilding( b_starting )
{
    if ( !isdefined( b_starting ) )
    {
        b_starting = 0;
    }
    
    t_start = getent( "surge_port_authority", "script_noteworthy" );
    a_e_cover = getentarray( "wharf_debris", "script_noteworthy" );
    
    foreach ( e_cover in a_e_cover )
    {
        e_cover thread blackstation_utility::set_model_scale();
    }
    
    level thread blackstation_utility::function_3c57957( t_start, a_e_cover, "barge_breach_cleared" );
    
    if ( !b_starting )
    {
        level thread port_covernode_handler();
    }
}

// Namespace cp_mi_sing_blackstation_port
// Params 0
// Checksum 0xfa0e5036, Offset: 0x4460
// Size: 0x2cc
function port_covernode_handler()
{
    level endon( #"enter_port" );
    a_nd_surge = [];
    var_c891e2e5 = getnode( "covernode_surge_1", "script_noteworthy" );
    var_ee945d4e = getnode( "covernode_surge_2", "script_noteworthy" );
    
    if ( !isdefined( a_nd_surge ) )
    {
        a_nd_surge = [];
    }
    else if ( !isarray( a_nd_surge ) )
    {
        a_nd_surge = array( a_nd_surge );
    }
    
    a_nd_surge[ a_nd_surge.size ] = var_ee945d4e;
    var_1496d7b7 = getnode( "covernode_surge_3", "script_noteworthy" );
    
    if ( !isdefined( a_nd_surge ) )
    {
        a_nd_surge = [];
    }
    else if ( !isarray( a_nd_surge ) )
    {
        a_nd_surge = array( a_nd_surge );
    }
    
    a_nd_surge[ a_nd_surge.size ] = var_1496d7b7;
    var_a857ed8 = getnode( "covernode_surge_4", "script_noteworthy" );
    
    if ( !isdefined( a_nd_surge ) )
    {
        a_nd_surge = [];
    }
    else if ( !isarray( a_nd_surge ) )
    {
        a_nd_surge = array( a_nd_surge );
    }
    
    a_nd_surge[ a_nd_surge.size ] = var_a857ed8;
    
    foreach ( nd_cover in a_nd_surge )
    {
        setenablenode( nd_cover, 0 );
    }
    
    function_41eafef6( var_ee945d4e, var_c891e2e5, "triggercolor_port_cover2" );
    function_41eafef6( var_1496d7b7, var_ee945d4e, "triggercolor_port_cover3" );
    function_41eafef6( var_a857ed8, var_1496d7b7, "triggercolor_port_cover4" );
}

// Namespace cp_mi_sing_blackstation_port
// Params 3
// Checksum 0x519fa99b, Offset: 0x4738
// Size: 0xac
function function_41eafef6( var_4b32b0bd, var_64fcc6c4, var_72001283 )
{
    level flag::wait_till( "cover_switch" );
    setenablenode( var_4b32b0bd, 1 );
    wait 0.1;
    trigger::use( var_72001283 );
    setenablenode( var_64fcc6c4, 0 );
    level flag::clear( "cover_switch" );
}

// Namespace cp_mi_sing_blackstation_port
// Params 0
// Checksum 0xd987d920, Offset: 0x47f0
// Size: 0x1ec
function port_assault_enemies()
{
    trigger::wait_till( "trigger_port_sniper" );
    level flag::set( "end_surge_rest" );
    level thread function_83fc27b8();
    spawn_manager::enable( "sm_pa_sniper" );
    trigger::wait_till( "trigger_port_building", "script_noteworthy" );
    level thread surge_debris_portbuilding();
    level thread port_enter();
    level thread port_assault_interior();
    level thread swept_away_guys();
    spawn_manager::enable( "sm_port_authority" );
    wait 3;
    spawn_manager::enable( "sm_rooftop_suppressor" );
    
    if ( level.players.size > 1 )
    {
        spawn_manager::wait_till_cleared( "sm_pa_sniper" );
    }
    
    level flag::set( "swept_away" );
    spawn_manager::wait_till_cleared( "sm_rooftop_suppressor" );
    spawn_manager::wait_till_ai_remaining( "sm_port_authority", 3 );
    trigger::use( "trigger_truck_port", "targetname", undefined, 0 );
    wait 4;
    level flag::set( "enter_port" );
}

// Namespace cp_mi_sing_blackstation_port
// Params 0
// Checksum 0xf73a8777, Offset: 0x49e8
// Size: 0x3c
function swept_away_guys()
{
    level flag::wait_till( "swept_away" );
    spawner::simple_spawn( "port_authority_swept" );
}

// Namespace cp_mi_sing_blackstation_port
// Params 0
// Checksum 0x86efdc37, Offset: 0x4a30
// Size: 0xda
function function_83fc27b8()
{
    var_746111be = util::spawn_model( "tag_origin" );
    var_746111be.targetname = "wind_target";
    var_746111be.script_objective = "objective_barge_assault";
    var_746111be endon( #"death" );
    a_s_targets = struct::get_array( "wind_target" );
    
    while ( true )
    {
        s_target = a_s_targets[ randomint( a_s_targets.size ) ];
        var_746111be.origin = s_target.origin;
        wait 2;
    }
}

// Namespace cp_mi_sing_blackstation_port
// Params 0
// Checksum 0x1ccd35b3, Offset: 0x4b18
// Size: 0x24
function port_enemy_spawnfunc()
{
    self endon( #"death" );
    self.grenadeammo = 0;
    self.b_swept = 0;
}

// Namespace cp_mi_sing_blackstation_port
// Params 0
// Checksum 0xbe17680e, Offset: 0x4b48
// Size: 0x64
function function_6a0ccfd()
{
    var_92f29fd5 = getweapon( "launcher_guided_blackstation_ai" );
    self ai::gun_switchto( var_92f29fd5, "right" );
    self thread blackstation_utility::function_ef275fb3();
}

// Namespace cp_mi_sing_blackstation_port
// Params 0
// Checksum 0x6432843f, Offset: 0x4bb8
// Size: 0x3c
function port_enter()
{
    level flag::wait_till( "enter_port" );
    trigger::use( "triggercolor_port_building" );
}

// Namespace cp_mi_sing_blackstation_port
// Params 0
// Checksum 0x6f74cd12, Offset: 0x4c00
// Size: 0x8c
function port_assault_truck()
{
    trigger::wait_till( "trigger_truck_port" );
    vh_truck = vehicle::simple_spawn_single( "port_assault_tech" );
    nd_start = getvehiclenode( vh_truck.target, "targetname" );
    vh_truck thread vehicle::get_on_and_go_path( nd_start );
}

// Namespace cp_mi_sing_blackstation_port
// Params 0
// Checksum 0x8b64cc48, Offset: 0x4c98
// Size: 0x64
function port_assault_interior()
{
    trigger::wait_till( "trigger_port_interior" );
    spawner::add_spawn_function_group( "port_interior", "targetname", &port_interior_spawnfunc );
    spawn_manager::enable( "sm_port_interior" );
}

// Namespace cp_mi_sing_blackstation_port
// Params 0
// Checksum 0x60aaf0dd, Offset: 0x4d08
// Size: 0x116
function port_interior_spawnfunc()
{
    self endon( #"death" );
    trigger::wait_till( "trigger_port_advance" );
    
    while ( true )
    {
        e_target = util::get_closest_player( self.origin, "allies" );
        v_player_pos = getclosestpointonnavmesh( e_target.origin, 82, 32 );
        
        if ( isdefined( v_player_pos ) )
        {
            a_v_points = util::positionquery_pointarray( v_player_pos, self.engagemindist, self.engagemaxdist, 70, 40, self );
            
            if ( a_v_points.size > 0 )
            {
                self setgoal( array::random( a_v_points ), 1 );
            }
        }
        
        wait 3;
    }
}

// Namespace cp_mi_sing_blackstation_port
// Params 0
// Checksum 0x80c5590, Offset: 0x4e28
// Size: 0x3c
function function_3e1b1aaa()
{
    level endon( #"objective_storm_surge_terminate" );
    level waittill( #"surge_warning" );
    level.ai_hendricks dialog::say( "hend_waves_hitting_now_0" );
}

// Namespace cp_mi_sing_blackstation_port
// Params 0
// Checksum 0x31ba2012, Offset: 0x4e70
// Size: 0x9c
function cargo_ship_rocker()
{
    level endon( #"stop_cargo_rocker" );
    e_barge = getent( "bs_dock_tugboat", "targetname" );
    e_barge prep_barge();
    level thread function_f8ff4031();
    level thread scene::play( "p7_fxanim_cp_blackstation_barge_idle_storm_bundle" );
    e_barge thread barge_face_tanker();
}

// Namespace cp_mi_sing_blackstation_port
// Params 0
// Checksum 0x81212ba5, Offset: 0x4f18
// Size: 0x7e4
function prep_barge()
{
    var_b9264a5 = getnode( "deck_traversal", "targetname" );
    linktraversal( var_b9264a5 );
    s_align = struct::get( "tag_align_hendricks_barge" );
    var_197f1988 = util::spawn_model( "tag_origin", s_align.origin, s_align.angles );
    var_197f1988.targetname = "barge_align";
    var_197f1988.script_objective = "objective_storm_surge";
    var_197f1988 linkto( self );
    a_t_barge = getentarray( "barge_trigger", "script_noteworthy" );
    
    foreach ( trigger in a_t_barge )
    {
        trigger enablelinkto();
        trigger linkto( self );
    }
    
    e_fx = getent( "barge_wave_fx", "targetname" );
    e_fx linkto( self );
    e_container_door_left = getent( "barge_container_door_left", "targetname" );
    e_container_door_left rotateto( ( 0, -5, 0 ), 0.05 );
    e_container_door_left waittill( #"rotatedone" );
    e_container_door_left linkto( self );
    e_container_door_right = getent( "barge_container_door_right", "targetname" );
    e_container_door_right rotateto( ( 0, 5, 0 ), 0.05 );
    e_container_door_right waittill( #"rotatedone" );
    e_container_door_right linkto( self );
    a_deck_ents = getentarray( "barge_ents", "script_noteworthy" );
    
    foreach ( deck_ent in a_deck_ents )
    {
        deck_ent linkto( self );
    }
    
    a_t_breach = getentarray( "player_breach_trigger", "script_noteworthy" );
    level.var_5b610bbd = [];
    
    foreach ( trigger in a_t_breach )
    {
        n_index = int( trigger.script_float ) - 1;
        e_waypoint = getent( trigger.target, "targetname" );
        e_player_link = getent( e_waypoint.target, "targetname" );
        trigger enablelinkto();
        trigger linkto( self );
        level.var_5b610bbd[ n_index ] = util::init_interactive_gameobject( trigger, &"cp_level_blackstation_interact_breach", &"CP_MI_SING_BLACKSTATION_BREACH", &watch_for_player_stack );
        level.var_5b610bbd[ n_index ] function_173b4bfe();
        level.var_5b610bbd[ n_index ] thread function_307c2864();
        level.var_5b610bbd[ n_index ].target = trigger.targetname;
        level.var_5b610bbd[ n_index ] linkto( self );
        e_waypoint linkto( self );
        e_player_link linkto( self );
    }
    
    var_52a2c714 = getentarray( "barge_lights", "targetname" );
    
    foreach ( light in var_52a2c714 )
    {
        light linkto( self );
    }
    
    var_70eb06cf = getnodearray( "wheelhouse_node", "script_noteworthy" );
    
    foreach ( var_16758b6f in var_70eb06cf )
    {
        setenablenode( var_16758b6f, 0 );
    }
    
    playfxontag( level._effect[ "barge_sheeting" ], self, "tag_wheelhouse_fxanim_jnt" );
    level thread barge_breach();
    array::thread_all( level.activeplayers, &function_b3d8d3f5 );
}

// Namespace cp_mi_sing_blackstation_port
// Params 0
// Checksum 0x4de34abd, Offset: 0x5708
// Size: 0x15c
function function_b3d8d3f5()
{
    self notify( #"hash_ec691523" );
    self endon( #"hash_ec691523" );
    level endon( #"objective_storm_surge_terminate" );
    self endon( #"death" );
    e_barge = getent( "bs_dock_tugboat", "targetname" );
    e_barge endon( #"death" );
    var_7a15f6e6 = getent( "barge_ground_ref", "targetname" );
    var_7a15f6e6 endon( #"death" );
    
    while ( true )
    {
        if ( self istouching( var_7a15f6e6 ) && !self.var_20aea9e5 )
        {
            self.var_20aea9e5 = 1;
            self playersetgroundreferenceent( e_barge );
        }
        else if ( !self istouching( var_7a15f6e6 ) && self.var_20aea9e5 )
        {
            self playersetgroundreferenceent( undefined );
            self.var_20aea9e5 = 0;
        }
        
        wait 0.05;
    }
}

// Namespace cp_mi_sing_blackstation_port
// Params 0
// Checksum 0x21c62b8, Offset: 0x5870
// Size: 0x54
function function_f8ff4031()
{
    level scene::init( "p7_fxanim_cp_blackstation_pier_event_01_bundle" );
    util::wait_network_frame();
    level scene::init( "p7_fxanim_cp_blackstation_pier_event_03_bundle" );
}

// Namespace cp_mi_sing_blackstation_port
// Params 0
// Checksum 0x958218f2, Offset: 0x58d0
// Size: 0x7c
function barge_face_tanker()
{
    v_ang = self.angles;
    v_org = self.origin;
    level flag::wait_till( "tanker_smash" );
    level notify( #"stop_cargo_rocker" );
    wait 1;
    level flag::set( "tanker_face" );
}

// Namespace cp_mi_sing_blackstation_port
// Params 0
// Checksum 0xb9c5ab8a, Offset: 0x5958
// Size: 0x1c
function pier_events()
{
    level thread truck_wave();
}

// Namespace cp_mi_sing_blackstation_port
// Params 1
// Checksum 0x7e704b0f, Offset: 0x5980
// Size: 0x2cc
function pre_breach( b_skipto )
{
    if ( !isdefined( b_skipto ) )
    {
        b_skipto = 0;
    }
    
    var_f4520dcf = getnode( "container_node", "targetname" );
    level thread function_42df2efb();
    level thread function_d091f076();
    wait 1;
    spawn_manager::wait_till_cleared( "sm_barge" );
    spawn_manager::wait_till_cleared( "sm_barge_cqb" );
    level thread function_2a6c042b();
    objectives::complete( "cp_level_blackstation_board_ship" );
    level dialog::player_say( "plyr_all_clear_0" );
    level flag::wait_till( "hendricks_on_barge" );
    level.ai_hendricks setgoal( var_f4520dcf );
    wait 2;
    level dialog::player_say( "plyr_kane_we_ve_reached_0" );
    level dialog::remote( "kane_interface_with_the_p_0" );
    level.ai_hendricks dialog::say( "hend_you_can_do_that_0" );
    level dialog::remote( "kane_your_dni_is_connecte_0" );
    level function_d1996775();
    level dialog::remote( "kane_files_secured_and_re_0" );
    level notify( #"kill_hendricks_anchor" );
    trigger::use( "hendricks_breach" );
    level dialog::remote( "kane_storm_s_getting_wors_0", 0.1 );
    level dialog::player_say( "plyr_got_it_thanks_kane_0" );
    level thread namespace_4297372::function_973b77f9();
    level.ai_hendricks dialog::say( "hend_i_ll_take_the_upper_0" );
    level thread breach_nag();
    level thread enable_breach_triggers();
}

// Namespace cp_mi_sing_blackstation_port
// Params 0
// Checksum 0x545e27a3, Offset: 0x5c58
// Size: 0xd2
function function_2a6c042b()
{
    a_ai_enemies = getaiteamarray( "axis" );
    
    foreach ( ai_enemy in a_ai_enemies )
    {
        if ( isalive( ai_enemy ) )
        {
            ai_enemy kill();
        }
        
        util::wait_network_frame();
    }
}

// Namespace cp_mi_sing_blackstation_port
// Params 0
// Checksum 0xf8171a59, Offset: 0x5d38
// Size: 0x1a2
function function_d091f076()
{
    spawn_manager::wait_till_ai_remaining( "sm_barge", 2 );
    spawn_manager::wait_till_ai_remaining( "sm_barge_cqb", 2 );
    var_a6abef8a = arraycombine( spawn_manager::get_ai( "sm_barge" ), spawn_manager::get_ai( "sm_barge_cqb" ), 0, 0 );
    
    foreach ( var_8d4ec191 in var_a6abef8a )
    {
        var_8d4ec191 setgoal( getent( "vol_center", "targetname" ), 1, 16 );
        var_8d4ec191 util::delay( randomintrange( 15, 18 ), undefined, &ai::bloody_death, randomintrange( 5, 15 ), "neck" );
    }
}

// Namespace cp_mi_sing_blackstation_port
// Params 0
// Checksum 0xa0b6e11a, Offset: 0x5ee8
// Size: 0x190
function function_d1996775()
{
    level thread container_hack();
    level flag::set( "container_console_active" );
    e_barge = getent( "bs_dock_tugboat", "targetname" );
    t_use = getent( "container_hack", "targetname" );
    str_obj = &"cp_hacking_console";
    str_hint = &"CP_MI_SING_BLACKSTATION_CONSOLE_HACK";
    mdl_gameobject = t_use hacking::init_hack_trigger( 6, str_obj, str_hint, undefined, undefined, e_barge );
    mdl_gameobject.dontlinkplayertotrigger = 1;
    mdl_gameobject.target = t_use.targetname;
    mdl_gameobject linkto( e_barge );
    t_use hacking::trigger_wait();
    t_use triggerenable( 0 );
    
    if ( isdefined( level.bzm_blackstationdialogue3_3callback ) )
    {
        level thread [[ level.bzm_blackstationdialogue3_3callback ]]();
    }
}

// Namespace cp_mi_sing_blackstation_port
// Params 0
// Checksum 0x32b38acb, Offset: 0x6080
// Size: 0x154
function container_hack()
{
    level.hacking flag::wait_till( "in_progress" );
    getent( "barge_monitor_on", "targetname" ) delete();
    getent( "barge_monitor_glitch_1", "targetname" ) show();
    wait 1.5;
    getent( "barge_monitor_glitch_1", "targetname" ) delete();
    getent( "barge_monitor_glitch_2", "targetname" ) show();
    wait 1.5;
    getent( "barge_monitor_glitch_2", "targetname" ) delete();
    getent( "barge_monitor_off", "targetname" ) show();
}

// Namespace cp_mi_sing_blackstation_port
// Params 0
// Checksum 0xfa5c2f06, Offset: 0x61e0
// Size: 0x4c
function function_42df2efb()
{
    trigger::wait_till( "barge_ground_ref" );
    spawn_manager::kill( "sm_barge" );
    spawn_manager::kill( "sm_barge_cqb" );
}

// Namespace cp_mi_sing_blackstation_port
// Params 1
// Checksum 0xc3d13c3e, Offset: 0x6238
// Size: 0x20c
function enable_breach_triggers( b_starting )
{
    if ( !isdefined( b_starting ) )
    {
        b_starting = 0;
    }
    
    objectives::set( "cp_level_blackstation_wheelhouse" );
    var_70eb06cf = getnodearray( "wheelhouse_node", "script_noteworthy" );
    
    foreach ( var_16758b6f in var_70eb06cf )
    {
        setenablenode( var_16758b6f, 1 );
    }
    
    if ( !b_starting )
    {
        savegame::checkpoint_save();
    }
    
    level flag::wait_till( "all_players_spawned" );
    
    foreach ( player in level.activeplayers )
    {
        function_ad89287b();
    }
    
    callback::on_spawned( &function_ad89287b );
    callback::on_disconnect( &function_b5455e18 );
    level flag::set( "breach_active" );
}

// Namespace cp_mi_sing_blackstation_port
// Params 1
// Checksum 0x3600a4ae, Offset: 0x6450
// Size: 0x118
function watch_for_player_stack( e_player )
{
    self.trigger endon( #"death" );
    level endon( #"wheelhouse_breached" );
    e_player blackstation_utility::function_ed7faf05();
    e_player.var_d6f82ae7 = self.trigger.script_float;
    str_bundle = "cin_bla_06_06_portassault_position0" + e_player.var_d6f82ae7 + "_breach";
    e_player thread scene::init( str_bundle, e_player );
    self gameobjects::disable_object( 1 );
    self.b_disabled = 1;
    
    if ( level.var_467c7a9c + 1 == level.activeplayers.size )
    {
        wait 0.5;
    }
    
    level.var_467c7a9c++;
    e_player waittill( #"disconnect" );
    level.var_467c7a9c--;
    self.var_ff712655 = 0;
}

// Namespace cp_mi_sing_blackstation_port
// Params 0
// Checksum 0x182a88c7, Offset: 0x6570
// Size: 0x70
function function_ad89287b()
{
    for ( x = 0; x < level.var_5b610bbd.size ; x++ )
    {
        if ( !level.var_5b610bbd[ x ].var_ff712655 )
        {
            level.var_5b610bbd[ x ] function_13dde3bd();
            return;
        }
    }
}

// Namespace cp_mi_sing_blackstation_port
// Params 0
// Checksum 0xacbbc79b, Offset: 0x65e8
// Size: 0x80
function function_b5455e18()
{
    if ( !isdefined( self.var_d6f82ae7 ) )
    {
        for ( x = level.var_5b610bbd.size - 1; x >= 0 ; x-- )
        {
            if ( !level.var_5b610bbd[ x ].b_disabled )
            {
                level.var_5b610bbd[ x ] function_173b4bfe();
                return;
            }
        }
    }
}

// Namespace cp_mi_sing_blackstation_port
// Params 0
// Checksum 0xf3448743, Offset: 0x6670
// Size: 0x34
function function_13dde3bd()
{
    self gameobjects::enable_object( 1 );
    self.var_ff712655 = 1;
    self.b_disabled = 0;
}

// Namespace cp_mi_sing_blackstation_port
// Params 0
// Checksum 0x45d3494a, Offset: 0x66b0
// Size: 0x34
function function_173b4bfe()
{
    self gameobjects::disable_object( 1 );
    self.var_ff712655 = 0;
    self.b_disabled = 1;
}

// Namespace cp_mi_sing_blackstation_port
// Params 0
// Checksum 0x33cb5544, Offset: 0x66f0
// Size: 0x2c
function function_307c2864()
{
    level waittill( #"wheelhouse_breached" );
    self gameobjects::destroy_object( 1, 1 );
}

// Namespace cp_mi_sing_blackstation_port
// Params 0
// Checksum 0x73849d6c, Offset: 0x6728
// Size: 0x126
function player_breach_watcher()
{
    level endon( #"wheelhouse_breached" );
    self waittill( #"death" );
    n_base = level.players.size + 1;
    
    for ( x = n_base; x <= 4 ; x++ )
    {
        t_player_breach = getent( "breach_player_" + x, "targetname" );
        
        if ( isdefined( t_player_breach ) )
        {
            level flag::set( t_player_breach.script_flag_set );
            e_waypoint = getent( t_player_breach.target, "targetname" );
            e_waypoint delete();
            t_player_breach delete();
        }
    }
}

// Namespace cp_mi_sing_blackstation_port
// Params 0
// Checksum 0xbdea3898, Offset: 0x6858
// Size: 0x34
function breach_nag()
{
    level endon( #"wheelhouse_breached" );
    wait 15;
    level.ai_hendricks dialog::say( "hend_get_ready_stack_up_0" );
}

// Namespace cp_mi_sing_blackstation_port
// Params 0
// Checksum 0x1a67f1df, Offset: 0x6898
// Size: 0x54c
function barge_breach()
{
    e_align = getent( "barge_align", "targetname" );
    var_fbbc4fa6 = getent( "barge_wheelhouse", "targetname" );
    e_tanker = getent( "dock_assault_tanker", "targetname" );
    level thread scene::init( "p7_fxanim_cp_blackstation_barge_roof_break_bundle" );
    function_a3eced7();
    setdvar( "phys_gravity_dir", ( 0, 0, 1 ) );
    var_fbbc4fa6 delete();
    level notify( #"wheelhouse_breached" );
    level flag::set( "breached" );
    level thread function_9a8b2deb();
    e_tanker delete();
    spawner::add_spawn_function_group( "wheelhouse_target1", "targetname", &wheelhouse_spawnfunc, 0 );
    spawner::add_spawn_function_group( "wheelhouse_target2", "targetname", &wheelhouse_spawnfunc, 0 );
    spawner::add_spawn_function_group( "wheelhouse_target3", "targetname", &wheelhouse_spawnfunc, 0 );
    spawner::add_spawn_function_group( "wheelhouse_enemy", "targetname", &wheelhouse_spawnfunc, 1 );
    spawn_manager::enable( "sm_wheelhouse" );
    wait 0.1;
    var_1dda34f0 = getent( "barge_door_rt", "targetname" );
    var_1dda34f0 thread barge_doors( "right" );
    var_55174cd2 = getent( "barge_door_lt", "targetname" );
    var_55174cd2 thread barge_doors( "left" );
    var_1dda34f0 playsound( "fxa_door_breach_r" );
    var_55174cd2 playsound( "fxa_door_breach_l" );
    wait 0.2;
    exploder::exploder_stop( "barge_destroy_lgt" );
    exploder::exploder( "barge_destroy_interior_lgt" );
    level thread breach_slow_time();
    level.ai_hendricks thread hendricks_enter_wheelhouse();
    
    foreach ( player in level.activeplayers )
    {
        player thread enter_wheelhouse();
        player thread player::fill_current_clip();
    }
    
    if ( isdefined( level.bzm_blackstationdialogue3_4callback ) )
    {
        level thread [[ level.bzm_blackstationdialogue3_4callback ]]();
    }
    
    level scene::play( "cin_bla_06_06_portassault_1st_breach_pound_react" );
    var_d53fdaad = getentarray( "barge_hurt_trigger", "targetname" );
    array::run_all( var_d53fdaad, &delete );
    spawner::waittill_ai_group_ai_count( "group_wheelhouse", 0 );
    spawner::waittill_ai_group_ai_count( "group_wheelhouse_backup", 0 );
    
    if ( isdefined( level.bzmutil_waitforallzombiestodie ) )
    {
        [[ level.bzmutil_waitforallzombiestodie ]]();
    }
    
    level flag::set( "barge_breach_cleared" );
    objectives::complete( "cp_level_blackstation_wheelhouse" );
    objectives::complete( "cp_level_blackstation_intercept" );
    level flag::set( "tanker_smash" );
}

// Namespace cp_mi_sing_blackstation_port
// Params 0
// Checksum 0x9a10bd41, Offset: 0x6df0
// Size: 0xa4
function function_a3eced7()
{
    level.var_467c7a9c = 0;
    level flag::wait_till( "all_players_spawned" );
    
    while ( level.var_467c7a9c < level.activeplayers.size || level.activeplayers.size == 0 )
    {
        wait 0.05;
    }
    
    callback::remove_on_spawned( &function_ad89287b );
    callback::remove_on_disconnect( &function_b5455e18 );
}

// Namespace cp_mi_sing_blackstation_port
// Params 0
// Checksum 0x82d3ace3, Offset: 0x6ea0
// Size: 0xbc
function hendricks_enter_wheelhouse()
{
    self ai::set_ignoreall( 1 );
    level waittill( #"hash_f7949f45" );
    level thread scene::play( "cin_bla_06_06_portassault_1st_breach_hendricks_concussive" );
    level waittill( #"hash_3a30e06" );
    trigger::use( "hendricks_wheelhouse" );
    playsoundatposition( "evt_breachassault_concussive_walla", self.origin );
    self create_concussion_wave();
    self ai::set_ignoreall( 0 );
}

// Namespace cp_mi_sing_blackstation_port
// Params 0
// Checksum 0x5c9e78a9, Offset: 0x6f68
// Size: 0x1b2
function create_concussion_wave()
{
    a_ai_enemies = arraycombine( getaispeciesarray( "axis", "all" ), getaispeciesarray( "team3", "all" ), 0, 0 );
    self.cybercom = spawnstruct();
    self.cybercom.concussive_wave_radius = 150;
    self.cybercom.concussive_wave_knockdown_damage = 5;
    level thread cybercom_gadget_concussive_wave::create_damage_wave( 100, level.ai_hendricks );
    
    if ( isdefined( a_ai_enemies ) && a_ai_enemies.size )
    {
        foreach ( enemy in a_ai_enemies )
        {
            if ( !isdefined( enemy ) || !isdefined( enemy.origin ) )
            {
                continue;
            }
            
            if ( !( isdefined( enemy.b_concussive ) && enemy.b_concussive ) )
            {
                enemy thread function_b53bbcfb();
            }
        }
    }
}

// Namespace cp_mi_sing_blackstation_port
// Params 2
// Checksum 0xc8143275, Offset: 0x7128
// Size: 0x12c
function function_797ee2de( v_direction, str_tag )
{
    self endon( #"hash_50daddc6" );
    
    while ( !isdefined( v_direction ) )
    {
        self waittill( #"damage", n_damage, e_attacker, v_direction, v_point, str_type, str_tag, str_model, str_part, str_weapon );
    }
    
    if ( !level flag::get( "slow_mo_finished" ) )
    {
        self startragdoll();
        self launchragdoll( 100 * vectornormalize( self.origin - e_attacker.origin ), str_tag );
        wait 0.05;
        self kill();
    }
}

// Namespace cp_mi_sing_blackstation_port
// Params 0
// Checksum 0x1cac254f, Offset: 0x7260
// Size: 0x84
function function_b53bbcfb()
{
    self endon( #"death" );
    self notify( #"hash_50daddc6" );
    self playsound( "gdt_concussivewave_imp_human" );
    self scene::play( "cin_gen_xplode_death_" + randomintrange( 1, 4 ), self );
    self kill();
}

// Namespace cp_mi_sing_blackstation_port
// Params 0
// Checksum 0x55f15e0a, Offset: 0x72f0
// Size: 0x234
function enter_wheelhouse()
{
    self endon( #"death" );
    veh_barge = getent( "bs_dock_tugboat", "targetname" );
    
    if ( isdefined( self.var_d6f82ae7 ) )
    {
        switch ( int( self.var_d6f82ae7 ) )
        {
            case 1:
                n_right_arc = 15;
                n_left_arc = 65;
                break;
            case 2:
                n_right_arc = 65;
                n_left_arc = 15;
                break;
            case 3:
                n_right_arc = 35;
                n_left_arc = 35;
                break;
            case 4:
                n_right_arc = 30;
                n_left_arc = 45;
                break;
            default:
                n_right_arc = 45;
                n_left_arc = 45;
                break;
        }
    }
    
    self.w_current = self getcurrentweapon();
    
    if ( !weapons::is_primary_weapon( self.w_current ) && self.w_current != getweapon( "micromissile_launcher" ) )
    {
        self player::switch_to_primary_weapon( 1 );
    }
    
    if ( isdefined( self.var_d6f82ae7 ) )
    {
        str_bundle = "cin_bla_06_06_portassault_position0" + self.var_d6f82ae7 + "_breach";
    }
    
    if ( isdefined( str_bundle ) )
    {
        self scene::play( str_bundle, self );
    }
    
    level notify( #"hash_4f70b2fc" );
    self allowsprint( 0 );
    self allowjump( 0 );
}

// Namespace cp_mi_sing_blackstation_port
// Params 1
// Checksum 0xbe0a63e7, Offset: 0x7530
// Size: 0x154
function barge_doors( str_side )
{
    var_dfd3f00d = util::spawn_model( self.model, self.origin, self.angles );
    self hide();
    
    if ( str_side == "left" )
    {
        var_dfd3f00d movey( 96 * -1, 0.3 );
        var_dfd3f00d waittill( #"movedone" );
        var_dfd3f00d delete();
        level waittill( #"hash_ac9ddf0" );
        self show();
        return;
    }
    
    var_dfd3f00d movey( 96, 0.3 );
    var_dfd3f00d waittill( #"movedone" );
    var_dfd3f00d delete();
    level waittill( #"hash_ac9ddf0" );
    self show();
}

// Namespace cp_mi_sing_blackstation_port
// Params 1
// Checksum 0x5d7be801, Offset: 0x7690
// Size: 0xdc
function wheelhouse_spawnfunc( b_concuss )
{
    self endon( #"death" );
    self thread ai::set_behavior_attribute( "useGrenades", 0 );
    self.b_concussive = b_concuss;
    self.allowpain = 0;
    self.dontdropweapon = 1;
    self thread function_797ee2de();
    self ai::set_ignoreall( 1 );
    self.goalradius = 1;
    self.groundrelativepose = 1;
    self.overrideactordamage = &function_4a2ffb52;
    level waittill( #"hash_4f70b2fc" );
    wait 0.05;
    self ai::set_ignoreall( 0 );
}

// Namespace cp_mi_sing_blackstation_port
// Params 12
// Checksum 0xc2fb6228, Offset: 0x7778
// Size: 0xbc
function function_4a2ffb52( einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex, modelindex )
{
    if ( isdefined( weapon ) && isdefined( weapon.rootweapon ) && weapon.rootweapon == getweapon( "ar_accurate" ) )
    {
        idamage *= 2;
    }
    
    return idamage;
}

// Namespace cp_mi_sing_blackstation_port
// Params 0
// Checksum 0xcc95f4d, Offset: 0x7840
// Size: 0x12c
function breach_slow_time()
{
    level endon( #"barge_breach_cleared" );
    level waittill( #"hash_4f70b2fc" );
    level thread namespace_4297372::function_a339da70();
    setslowmotion( 1, 0.3, 0.3 );
    
    foreach ( player in level.players )
    {
        player setmovespeedscale( 0.3 );
    }
    
    level thread reset_timescale( 0.3, 1, 0.3 );
}

// Namespace cp_mi_sing_blackstation_port
// Params 3
// Checksum 0x890ba33e, Offset: 0x7978
// Size: 0x122
function reset_timescale( n_timescale, n_default, n_time )
{
    util::waittill_any_timeout( 4, "barge_breach_cleared" );
    level flag::set( "slow_mo_finished" );
    level thread namespace_4297372::function_69fc18eb();
    setslowmotion( n_timescale, n_default, n_time );
    
    foreach ( player in level.players )
    {
        player setmovespeedscale( n_default );
    }
}

// Namespace cp_mi_sing_blackstation_port
// Params 0
// Checksum 0x91aa132f, Offset: 0x7aa8
// Size: 0x10c
function port_assault_vo()
{
    trigger::wait_till( "trigger_port_sniper" );
    wait 2;
    
    if ( level.players.size > 1 )
    {
        level.ai_hendricks dialog::say( "hend_snipers_3_o_clock_0" );
    }
    
    level.ai_hendricks dialog::say( "hend_if_you_ve_got_any_ro_0", 0.5 );
    level dialog::player_say( "plyr_copy_that_hendricks_1", 0.7 );
    array::thread_all( level.activeplayers, &coop::function_e9f7384d );
    level flag::wait_till( "exit_wharf" );
    level.ai_hendricks dialog::say( "hend_storm_s_getting_wors_0" );
}

// Namespace cp_mi_sing_blackstation_port
// Params 0
// Checksum 0x8ace696b, Offset: 0x7bc0
// Size: 0xf4
function barge_assault_vo()
{
    level thread function_c5a827ee();
    trigger::wait_till( "hendricks_hurry" );
    objectives::set( "cp_level_blackstation_board_ship" );
    level thread scene::play( "p7_fxanim_cp_blackstation_pier_event_01_bundle" );
    wait 0.1;
    
    if ( scene::is_active( "cin_bla_06_04_portassault_vign_react" ) )
    {
        level scene::play( "cin_bla_06_04_portassault_vign_react" );
        level.ai_hendricks dialog::say( "hend_visibility_s_getting_0" );
        return;
    }
    
    level.ai_hendricks dialog::say( "hend_visibility_s_getting_0" );
}

// Namespace cp_mi_sing_blackstation_port
// Params 0
// Checksum 0xbc5cc436, Offset: 0x7cc0
// Size: 0x7c
function function_c5a827ee()
{
    level endon( #"hendricks_hurry" );
    
    if ( !level flag::get( "hendricks_hurry" ) )
    {
        level flag::wait_till( "surge_done" );
        level.ai_hendricks waittill( #"goal" );
        level scene::init( "cin_bla_06_04_portassault_vign_react" );
    }
}

// Namespace cp_mi_sing_blackstation_port
// Params 0
// Checksum 0x6d1361d6, Offset: 0x7d48
// Size: 0x1dc
function truck_wave()
{
    s_wave = struct::get( "wave_technical", "script_noteworthy" );
    e_wave = getent( "temp_pier_wave", "targetname" );
    t_wave = getent( e_wave.target, "targetname" );
    e_wave ghost();
    level waittill( #"wave_hit" );
    t_wave thread blackstation_utility::ai_wave_trigger_tracker();
    e_wave.origin = s_wave.origin;
    e_wave.angles = s_wave.angles;
    e_wave moveto( e_wave.origin + ( 0, 0, 150 ), 0.1 );
    e_wave waittill( #"movedone" );
    e_wave moveto( e_wave.origin + ( -450, 0, 0 ), 2 );
    e_wave thread blackstation_utility::play_temp_wave_fx();
    e_wave waittill( #"movedone" );
    e_wave moveto( e_wave.origin + ( 0, 0, -150 ), 0.1 );
}

// Namespace cp_mi_sing_blackstation_port
// Params 0
// Checksum 0x6dbb58dd, Offset: 0x7f30
// Size: 0x104
function setup_port_technical()
{
    self endon( #"death" );
    self turret::enable( 1, 1 );
    self waittill( #"reached_end_node" );
    self thread blackstation_utility::truck_unload( "passenger1" );
    self thread blackstation_utility::truck_unload( "driver" );
    
    while ( isdefined( self getseatoccupant( 0 ) ) )
    {
        wait 0.1;
    }
    
    self makevehicleusable();
    self setseatoccupied( 0 );
    self thread blackstation_utility::truck_gunner_replace( level.players.size - 1, level.players.size, "activate_barge_ai" );
}

// Namespace cp_mi_sing_blackstation_port
// Params 0
// Checksum 0xea5f85ca, Offset: 0x8040
// Size: 0x24
function function_b8500bb1()
{
    level thread scene::play( "p7_fxanim_gp_debris_float_01_s4_bundle" );
}

// Namespace cp_mi_sing_blackstation_port
// Params 0
// Checksum 0xe2b591ac, Offset: 0x8070
// Size: 0x152
function wheelhouse_node_handler()
{
    a_nd_roof = getnodearray( "barge_roof", "script_linkname" );
    
    foreach ( nd_roof in a_nd_roof )
    {
        setenablenode( nd_roof, 0 );
    }
    
    level flag::wait_till( "breach_active" );
    
    foreach ( nd_roof in a_nd_roof )
    {
        setenablenode( nd_roof, 1 );
    }
}

// Namespace cp_mi_sing_blackstation_port
// Params 0
// Checksum 0x253c7644, Offset: 0x81d0
// Size: 0x118
function lightning_barge()
{
    level endon( #"wave_done" );
    level flag::wait_till( "activate_barge_ai" );
    wait randomfloatrange( 0.5, 1.5 );
    
    while ( true )
    {
        level exploder::exploder_duration( "lightning_barge", 1 );
        level fx::play( "lightning_strike", struct::get( "lightning_boat" ).origin, ( -90, 0, 0 ) );
        playsoundatposition( "amb_thunder_strike", struct::get( "lightning_boat" ).origin );
        wait randomfloatrange( 6, 7.5 );
    }
}

// Namespace cp_mi_sing_blackstation_port
// Params 0
// Checksum 0x58a99e77, Offset: 0x82f0
// Size: 0x4c
function lightning_barge_clear()
{
    level flag::wait_till( "breach_active" );
    level thread blackstation_utility::lightning_flashes( "lightning_pier", "wheelhouse_breached" );
}

// Namespace cp_mi_sing_blackstation_port
// Params 1
// Checksum 0x12ccbdc6, Offset: 0x8348
// Size: 0x2bc
function spawn_pier_guards( b_starting )
{
    spawner::add_spawn_function_group( "barge_ai", "targetname", &function_d4e6feff );
    
    if ( !b_starting )
    {
        level flag::wait_till( "move_to_pier" );
    }
    
    spawner::simple_spawn( "pier_guard", &pier_guard_behavior );
    
    if ( b_starting )
    {
        level flag::set( "start_objective_barge_assault" );
        load::function_a2995f22();
    }
    
    trigger::wait_till( "trigger_pier_retreat" );
    level thread pier_guard_wave();
    trigger::wait_till( "trigger_dock" );
    spawner::simple_spawn( "dock_guard", &function_a27055f8 );
    trigger::wait_till( "trigger_barge" );
    spawn_manager::enable( "sm_barge" );
    trigger::wait_till( "trigger_barge_cqb" );
    spawner::add_spawn_function_group( "barge_cqb", "targetname", &barge_cqb_spawnfunc );
    spawn_manager::enable( "sm_barge_cqb" );
    level flag::wait_till( "surge_done" );
    level.ai_hendricks colors::disable();
    level scene::init( "cin_bla_06_05_portassault_vign_traversal" );
    level waittill( #"hash_232dc1e1" );
    level waittill( #"hash_498028de" );
    level scene::play( "cin_bla_06_05_portassault_vign_traversal" );
    level.ai_hendricks colors::enable();
    level flag::set( "hendricks_on_barge" );
    level.ai_hendricks.groundrelativepose = 1;
    trigger::use( "triggercolor_barge" );
}

// Namespace cp_mi_sing_blackstation_port
// Params 0
// Checksum 0x4aa0bf89, Offset: 0x8610
// Size: 0x3c
function pier_guard_smash()
{
    trigger::wait_till( "trigger_dock" );
    level thread scene::play( "p7_fxanim_cp_blackstation_pier_event_03_bundle" );
}

// Namespace cp_mi_sing_blackstation_port
// Params 0
// Checksum 0xb1d188be, Offset: 0x8658
// Size: 0x90
function function_7a7390dd()
{
    t_kill_trigger = getent( "barge_assault_kill", "targetname" );
    t_kill_trigger endon( #"death" );
    
    while ( true )
    {
        t_kill_trigger waittill( #"trigger", e_triggerer );
        
        if ( isai( e_triggerer ) )
        {
            e_triggerer kill();
        }
    }
}

// Namespace cp_mi_sing_blackstation_port
// Params 0
// Checksum 0xd19f3490, Offset: 0x86f0
// Size: 0x34
function function_d4e6feff()
{
    self endon( #"death" );
    self.groundrelativepose = 1;
    self thread function_a27055f8();
}

// Namespace cp_mi_sing_blackstation_port
// Params 0
// Checksum 0x9ed2ef06, Offset: 0x8730
// Size: 0x74
function barge_cqb_spawnfunc()
{
    self endon( #"death" );
    self.groundrelativepose = 1;
    self thread function_a27055f8();
    self ai::set_behavior_attribute( "cqb", 1 );
    self ai::set_behavior_attribute( "can_initiateaivsaimelee", 0 );
}

// Namespace cp_mi_sing_blackstation_port
// Params 0
// Checksum 0xd22bb767, Offset: 0x87b0
// Size: 0x11c
function pier_guard_behavior()
{
    self endon( #"death" );
    self.goalradius = 4;
    self ai::set_ignoreme( 1 );
    self thread function_a27055f8();
    trigger::wait_till( "hendricks_hurry" );
    self ai::set_ignoreme( 0 );
    trigger::wait_till( "trigger_pier_retreat" );
    self ai::set_ignoreme( 1 );
    self setgoal( getent( "vol_dock", "targetname" ), 1, 1024 );
    self waittill( #"goal" );
    self ai::set_ignoreme( 0 );
    self clearforcedgoal();
}

// Namespace cp_mi_sing_blackstation_port
// Params 0
// Checksum 0x3aec5927, Offset: 0x88d8
// Size: 0x44
function barge_ai()
{
    self endon( #"death" );
    self ai::set_behavior_attribute( "can_initiateaivsaimelee", 0 );
    self thread function_a27055f8();
}

// Namespace cp_mi_sing_blackstation_port
// Params 0
// Checksum 0x489cc222, Offset: 0x8928
// Size: 0xf8
function function_a27055f8()
{
    self endon( #"death" );
    
    while ( true )
    {
        e_player = util::get_closest_player( self.origin, "allies" );
        
        if ( isdefined( e_player ) )
        {
            n_distance = distancesquared( self.origin, e_player.origin );
            
            if ( n_distance < 360000 )
            {
                self.script_accuracy = 1;
                return;
            }
            else
            {
                self.script_accuracy = math::clamp( 360000 / n_distance, 0.7, 1 );
            }
        }
        
        wait 0.2;
    }
}

// Namespace cp_mi_sing_blackstation_port
// Params 0
// Checksum 0x46acf24d, Offset: 0x8a28
// Size: 0x152
function truck_pier()
{
    vh_truck = vehicle::simple_spawn_single( "truck_pier" );
    vh_truck util::magic_bullet_shield();
    vh_truck thread ignore_truck_riders();
    vh_truck endon( #"death" );
    level flag::wait_till( "dock_fxanim_truck" );
    level thread scene::init( "p7_fxanim_cp_blackstation_pier_event_02_bundle" );
    vh_truck turret::enable( 1, 1 );
    ai_gunner = vh_truck vehicle::get_rider( "gunner1" );
    
    if ( isalive( ai_gunner ) )
    {
        ai_gunner thread truck_gunner_death();
    }
    
    level waittill( #"hash_6b81763" );
    wait 2;
    level thread scene::play( "p7_fxanim_cp_blackstation_pier_event_02_bundle" );
    level notify( #"pier_end_node" );
}

// Namespace cp_mi_sing_blackstation_port
// Params 0
// Checksum 0x1a4acbc7, Offset: 0x8b88
// Size: 0x2c
function truck_gunner_death()
{
    self endon( #"death" );
    wait 4.5;
    self kill();
}

// Namespace cp_mi_sing_blackstation_port
// Params 0
// Checksum 0x967161fd, Offset: 0x8bc0
// Size: 0x94
function truck_cargo_blocker()
{
    nd_start = getvehiclenode( "node_cargo_truck", "targetname" );
    self thread vehicle::get_on_path( nd_start );
    self util::magic_bullet_shield();
    trigger::wait_till( "trigger_dock_truck" );
    self thread vehicle::go_path();
}

// Namespace cp_mi_sing_blackstation_port
// Params 0
// Checksum 0xc6a20cf9, Offset: 0x8c60
// Size: 0x82
function truck_wave_hit()
{
    self endon( #"death" );
    level endon( #"wave_done" );
    t_wave = getent( "truck_wave", "targetname" );
    
    while ( !self istouching( t_wave ) )
    {
        wait 0.05;
    }
    
    self notify( #"wave" );
}

// Namespace cp_mi_sing_blackstation_port
// Params 0
// Checksum 0xd3c87407, Offset: 0x8cf0
// Size: 0x152
function ignore_truck_riders()
{
    self endon( #"death" );
    
    while ( self.riders.size < 2 )
    {
        wait 0.05;
    }
    
    foreach ( ai_rider in self.riders )
    {
        ai_rider ai::set_ignoreme( 1 );
    }
    
    trigger::wait_till( "hendricks_hurry" );
    
    foreach ( ai_rider in self.riders )
    {
        ai_rider ai::set_ignoreme( 0 );
    }
}

// Namespace cp_mi_sing_blackstation_port
// Params 0
// Checksum 0xe5ba5169, Offset: 0x8e50
// Size: 0x134
function pier_guard_wave()
{
    level flag::wait_till( "trigger_wave_dock" );
    a_ai_enemies = getaiteamarray( "axis" );
    ai_gunner = getent( "pier_truck_guy_ai", "targetname" );
    
    if ( isalive( ai_gunner ) )
    {
        arrayremovevalue( a_ai_enemies, ai_gunner );
    }
    
    s_wave = struct::get( "wave_dockleft", "script_noteworthy" );
    e_wave = getent( "pier_wave_dockleft", "targetname" );
    level thread pier_wave_create( s_wave, e_wave, "left", a_ai_enemies );
}

// Namespace cp_mi_sing_blackstation_port
// Params 4
// Checksum 0xf5e127c, Offset: 0x8f90
// Size: 0x1c4
function pier_wave_create( s_wave, e_wave, str_side, a_ai )
{
    t_wave = getent( e_wave.target, "targetname" );
    e_wave ghost();
    e_wave.origin = s_wave.origin;
    e_wave.angles = s_wave.angles;
    t_wave thread blackstation_utility::ai_wave_trigger_tracker();
    
    if ( str_side == "right" )
    {
        n_dist = 450;
    }
    else
    {
        n_dist = -450;
    }
    
    e_wave moveto( e_wave.origin + ( 0, 0, 150 ), 0.1 );
    e_wave waittill( #"movedone" );
    e_wave moveto( e_wave.origin + ( n_dist, 0, 0 ), 2 );
    e_wave thread blackstation_utility::play_temp_wave_fx();
    e_wave waittill( #"movedone" );
    e_wave moveto( e_wave.origin + ( 0, 0, -150 ), 0.1 );
}

// Namespace cp_mi_sing_blackstation_port
// Params 0
// Checksum 0x719ea6f9, Offset: 0x9160
// Size: 0x34
function function_b73344f6()
{
    level endon( #"hash_72fc0350" );
    trigger::wait_till( "hero_catchup" );
    savegame::checkpoint_save();
}

// Namespace cp_mi_sing_blackstation_port
// Params 0
// Checksum 0x14c74295, Offset: 0x91a0
// Size: 0x1c
function tanker_movement()
{
    level thread tanker_smash();
}

// Namespace cp_mi_sing_blackstation_port
// Params 0
// Checksum 0xd324f502, Offset: 0x91c8
// Size: 0x144
function tanker_smash()
{
    util::waittill_any_ents( level, "slow_mo_finished", level, "barge_breach_cleared" );
    
    if ( level flag::get( "barge_breach_cleared" ) )
    {
        wait 0.5;
    }
    
    a_t_boundary = getentarray( "ocean_boundary", "targetname" );
    array::run_all( a_t_boundary, &delete );
    level thread barge_wave();
    level flag::set( "tanker_go" );
    level.ai_hendricks thread hendricks_boatride();
    level thread function_948e3399();
    level thread namespace_4297372::function_11139d81();
    level thread namespace_4297372::function_fcea1d9();
}

// Namespace cp_mi_sing_blackstation_port
// Params 0
// Checksum 0x2aae7d8d, Offset: 0x9318
// Size: 0x50
function hendricks_boatride()
{
    level flag::wait_till( "tanker_ride" );
    level.ai_hendricks colors::disable();
    level.ai_hendricks.groundrelativepose = 0;
}

// Namespace cp_mi_sing_blackstation_port
// Params 0
// Checksum 0x78226d96, Offset: 0x9370
// Size: 0xc4
function player_tanker_anchor()
{
    self endon( #"death" );
    self allowsprint( 1 );
    self allowjump( 1 );
    self enableinvulnerability();
    self playersetgroundreferenceent( undefined );
    level flag::wait_till( "tanker_ride_done" );
    self.is_anchored = 0;
    self thread blackstation_utility::player_anchor();
    wait 2;
    self disableinvulnerability();
}

// Namespace cp_mi_sing_blackstation_port
// Params 0
// Checksum 0xe56b8f0c, Offset: 0x9440
// Size: 0x3c4
function function_948e3399()
{
    level scene::add_scene_func( "cin_bla_07_02_stormsurge_1st_leap_ride", &function_423548cd );
    level scene::add_scene_func( "cin_bla_07_02_stormsurge_1st_leap_ride_latched", &function_f60d2cfb, "play" );
    level scene::add_scene_func( "cin_bla_07_02_stormsurge_1st_leap_ride_latched", &tanker_ride_done, "done" );
    level scene::add_scene_func( "cin_bla_07_02_stormsurge_1st_leap_landing", &function_236c19c3, "done" );
    level scene::add_scene_func( "cin_bla_07_02_stormsurge_1st_leap_landing_hendricks", &function_18898abd, "done" );
    e_fx = getent( "barge_wave_fx", "targetname" );
    e_fx thread fx::play( "wave_pier", e_fx.origin, undefined, 2, 1 );
    e_fx playrumbleonentity( "bs_ride_start" );
    array::run_all( getcorpsearray(), &delete );
    var_da1764fd = getaiarray( "wheelhouse_enemy_ai", "targetname" );
    
    foreach ( var_eb410c1d in var_da1764fd )
    {
        var_eb410c1d delete();
    }
    
    if ( level scene::is_playing( "p7_fxanim_cp_blackstation_barge_idle_storm_bundle" ) )
    {
        level scene::stop( "p7_fxanim_cp_blackstation_barge_idle_storm_bundle" );
    }
    
    array::thread_all( level.activeplayers, &clientfield::set_to_player, "toggle_water_fx", 1 );
    level scene::play( "cin_bla_07_02_stormsurge_1st_leap_ride" );
    level scene::play( "cin_bla_07_02_stormsurge_1st_leap_ride_latched" );
    level thread scene::play( "cin_bla_07_02_stormsurge_1st_leap_landing" );
    level thread scene::play( "cin_bla_07_02_stormsurge_1st_leap_landing_hendricks" );
    array::thread_all( level.activeplayers, &player_tanker_anchor );
    array::thread_all( level.activeplayers, &clientfield::set_to_player, "rumble_loop", 0 );
    array::thread_all( level.activeplayers, &clientfield::set_to_player, "toggle_water_fx", 0 );
}

// Namespace cp_mi_sing_blackstation_port
// Params 1
// Checksum 0x4184db25, Offset: 0x9810
// Size: 0xe4
function function_f60d2cfb( a_ents )
{
    level thread scene::init( "p7_fxanim_cp_blackstation_barge_sink_bundle" );
    array::thread_all( level.activeplayers, &clientfield::set_to_player, "wind_blur", 1 );
    array::thread_all( level.activeplayers, &function_622eb918 );
    level thread function_fcb18964();
    level thread scene::play( "p7_fxanim_cp_blackstation_tanker_building_smash_debris_bundle" );
    wait 5;
    level thread scene::play( "p7_fxanim_cp_blackstation_barge_sink_bundle" );
}

// Namespace cp_mi_sing_blackstation_port
// Params 1
// Checksum 0x9ae3a417, Offset: 0x9900
// Size: 0x3c
function tanker_ride_done( a_ents )
{
    array::thread_all( level.activeplayers, &clientfield::set_to_player, "wind_blur", 0 );
}

// Namespace cp_mi_sing_blackstation_port
// Params 1
// Checksum 0x3a32d598, Offset: 0x9948
// Size: 0x7c
function function_423548cd( a_ents )
{
    level waittill( #"hash_fe33f1ed" );
    array::run_all( level.activeplayers, &playrumbleonentity, "damage_heavy" );
    array::thread_all( level.activeplayers, &clientfield::set_to_player, "rumble_loop", 0 );
}

// Namespace cp_mi_sing_blackstation_port
// Params 0
// Checksum 0xfe19cd5, Offset: 0x99d0
// Size: 0x58
function function_fcb18964()
{
    level endon( #"tanker_ride_done" );
    
    while ( true )
    {
        level waittill( #"hash_b465620d" );
        array::run_all( level.activeplayers, &playrumbleonentity, "cp_blackstation_tanker_building_rumble" );
    }
}

// Namespace cp_mi_sing_blackstation_port
// Params 0
// Checksum 0x42f336cd, Offset: 0x9a30
// Size: 0x6c
function function_622eb918()
{
    array::run_all( level.activeplayers, &playrumbleonentity, "cp_blackstation_tanker_anchor_rumble" );
    array::thread_all( level.activeplayers, &clientfield::set_to_player, "rumble_loop", 1 );
}

// Namespace cp_mi_sing_blackstation_port
// Params 1
// Checksum 0xfbc78a06, Offset: 0x9aa8
// Size: 0x24
function function_18898abd( a_ents )
{
    level.ai_hendricks colors::enable();
}

// Namespace cp_mi_sing_blackstation_port
// Params 1
// Checksum 0x6953d3ff, Offset: 0x9ad8
// Size: 0x64
function function_236c19c3( a_ents )
{
    level flag::set( "tanker_ride_done" );
    level notify( #"stop_cargo_rocker" );
    array::thread_all( level.activeplayers, &cp_mi_sing_blackstation_subway::function_99f304f0 );
}

// Namespace cp_mi_sing_blackstation_port
// Params 0
// Checksum 0xa595f2f6, Offset: 0x9b48
// Size: 0x1ca
function barge_wave()
{
    level waittill( #"hash_383b9104" );
    level thread scene::play( "p7_fxanim_cp_blackstation_barge_roof_break_bundle" );
    exploder::exploder_stop( "barge_destroy_interior_lgt" );
    var_486aa363 = getent( "barge_wheelhouse_interior", "targetname" );
    var_486aa363 playrumbleonentity( "bs_ride_start" );
    playsoundatposition( "evt_barge_shake", var_486aa363.origin );
    array::thread_all( level.activeplayers, &clientfield::set_to_player, "rumble_loop", 1 );
    earthquake( 0.3, 21, var_486aa363.origin, 999999 );
    var_8e44646a = getentarray( "barge_wheelhouse_roof", "targetname" );
    
    foreach ( var_6baa4cfd in var_8e44646a )
    {
        var_6baa4cfd delete();
    }
}

// Namespace cp_mi_sing_blackstation_port
// Params 0
// Checksum 0x5c2a6d58, Offset: 0x9d20
// Size: 0xd4
function debris_toilet_launch()
{
    trigger::wait_till( "trigger_toilet" );
    e_toilet = getent( "debris_toilet", "targetname" );
    e_toilet thread blackstation_utility::debris_rotate();
    e_toilet thread blackstation_utility::check_player_hit();
    e_toilet moveto( e_toilet.origin + ( 0, 6000, 200 ), 8 );
    e_toilet waittill( #"movedone" );
    e_toilet delete();
}

// Namespace cp_mi_sing_blackstation_port
// Params 0
// Checksum 0x33e47e9c, Offset: 0x9e00
// Size: 0x34
function function_13e164f4()
{
    self.b_rain_on = 1;
    self ai::set_behavior_attribute( "useAnimationOverride", 1 );
}

// Namespace cp_mi_sing_blackstation_port
// Params 0
// Checksum 0x5ec313a6, Offset: 0x9e40
// Size: 0xfe
function function_22a0015b()
{
    while ( !level flag::get( "breach_active" ) )
    {
        level notify( #"end_lightning" );
        wait 0.5;
        
        if ( math::cointoss() )
        {
            level thread blackstation_utility::function_bd1bfce2( "exp_lightning_pier_l_01", "exp_lightning_pier_l_02", "exp_lightning_pier_l_03", 2, "end_lightning" );
        }
        else
        {
            level thread blackstation_utility::function_bd1bfce2( "exp_lightning_pier_r_01", "exp_lightning_pier_r_02", "exp_lightning_pier_r_03", 1, "end_lightning" );
        }
        
        wait randomfloatrange( 2.5, 5 );
    }
    
    wait 0.5;
    level notify( #"end_lightning" );
}

// Namespace cp_mi_sing_blackstation_port
// Params 0
// Checksum 0xf9f4eb2e, Offset: 0x9f48
// Size: 0x3c
function debris_mound_breadcrumb()
{
    trigger::wait_till( "anchor_intro_breadcrumb" );
    level thread objectives::breadcrumb( "debris_mound_breadcrumb" );
}

// Namespace cp_mi_sing_blackstation_port
// Params 0
// Checksum 0x3ab3b64b, Offset: 0x9f90
// Size: 0xd4
function function_94ff5bc0()
{
    trigger::wait_till( "debris_mound_breadcrumb" );
    level thread function_3b4b0a17();
    level flag::wait_till( "debris_path_four_ready" );
    level thread function_3b4b0a17();
    level flag::wait_till( "debris_path_five_ready" );
    level thread function_3b4b0a17();
    trigger::wait_till( "trigger_toilet" );
    level thread function_3b4b0a17();
}

// Namespace cp_mi_sing_blackstation_port
// Params 0
// Checksum 0x3a30d223, Offset: 0xa070
// Size: 0x86
function function_3b4b0a17()
{
    var_92471baa = randomintrange( 1, 5 );
    
    for ( i = 0; i < var_92471baa ; i++ )
    {
        exploder::exploder( "exp_lightning_anchor_l_01" );
        wait randomfloatrange( 0.1, 0.5 );
    }
}

// Namespace cp_mi_sing_blackstation_port
// Params 0
// Checksum 0xaa27db23, Offset: 0xa100
// Size: 0x172
function function_9a8b2deb()
{
    a_s_spawnpts = spawnlogic::get_all_spawn_points( 1 );
    
    foreach ( s_spawnpt in a_s_spawnpts )
    {
        if ( s_spawnpt.scriptgroup_playerspawns_enable === "10" )
        {
            s_spawnpt spawnlogic::function_82c857e9( 0 );
        }
    }
    
    wait 0.05;
    
    foreach ( s_spawnpt in a_s_spawnpts )
    {
        if ( s_spawnpt.scriptgroup_playerspawns_disable === "23" )
        {
            s_spawnpt spawnlogic::function_82c857e9( 1 );
        }
    }
}

// Namespace cp_mi_sing_blackstation_port
// Params 0
// Checksum 0x75dd5a94, Offset: 0xa280
// Size: 0xb4
function function_5b85480f()
{
    var_b9528c52 = trigger::wait_till( "hendricks_hurry" );
    e_player = var_b9528c52.who;
    
    if ( distance2dsquared( e_player.origin, level.ai_hendricks.origin ) > 2250000 )
    {
        level.ai_hendricks forceteleport( ( 2282, -3646, 64 ), ( 0, 180, 0 ), 0 );
    }
}

