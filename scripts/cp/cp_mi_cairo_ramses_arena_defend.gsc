#using scripts/codescripts/struct;
#using scripts/cp/_collectibles;
#using scripts/cp/_debug;
#using scripts/cp/_dialog;
#using scripts/cp/_hacking;
#using scripts/cp/_laststand;
#using scripts/cp/_load;
#using scripts/cp/_objectives;
#using scripts/cp/_oed;
#using scripts/cp/_skipto;
#using scripts/cp/_spawn_manager;
#using scripts/cp/_util;
#using scripts/cp/cp_mi_cairo_ramses2_fx;
#using scripts/cp/cp_mi_cairo_ramses2_sound;
#using scripts/cp/cp_mi_cairo_ramses_accolades;
#using scripts/cp/cp_mi_cairo_ramses_alley;
#using scripts/cp/cp_mi_cairo_ramses_utility;
#using scripts/cp/cp_mi_cairo_ramses_vtol_igc;
#using scripts/cp/cybercom/_cybercom_util;
#using scripts/cp/gametypes/_battlechatter;
#using scripts/cp/gametypes/_save;
#using scripts/shared/_oob;
#using scripts/shared/ai/robot_phalanx;
#using scripts/shared/ai/systems/gib;
#using scripts/shared/ai_shared;
#using scripts/shared/array_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/colors_shared;
#using scripts/shared/compass;
#using scripts/shared/exploder_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/gameobjects_shared;
#using scripts/shared/laststand_shared;
#using scripts/shared/lui_shared;
#using scripts/shared/math_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/system_shared;
#using scripts/shared/trigger_shared;
#using scripts/shared/turret_shared;
#using scripts/shared/util_shared;
#using scripts/shared/vehicle_ai_shared;
#using scripts/shared/vehicle_shared;
#using scripts/shared/vehicleriders_shared;
#using scripts/shared/vehicles/_quadtank;
#using scripts/shared/weapons/_weaponobjects;

#namespace arena_defend;

// Namespace arena_defend
// Params 0, eflags: 0x2
// Checksum 0xc3ce1555, Offset: 0x3098
// Size: 0x34
function autoexec __init__sytem__()
{
    system::register( "arena_defend", &__init__, undefined, undefined );
}

// Namespace arena_defend
// Params 0
// Checksum 0xfcf4e4a9, Offset: 0x30d8
// Size: 0x374
function __init__()
{
    clientfield::register( "scriptmover", "arena_defend_weak_point_keyline", 1, 1, "int" );
    clientfield::register( "world", "clear_all_dyn_ents", 1, 1, "counter" );
    clientfield::register( "toplayer", "set_dedicated_shadow", 1, 1, "int" );
    level thread scene::play( "cin_ram_05_01_quadtank_flatbed_pose" );
    ramses_util::enable_nodes( "arena_defend_car4cover_node", "targetname", 0 );
    ramses_util::enable_nodes( "hendricks_mobile_wall_start_node", "targetname", 0 );
    ramses_util::enable_nodes( "arena_defend_demostreet_intro_khalil", "targetname", 0 );
    ramses_util::enable_nodes( "mobile_wall_door_traversals", "targetname", 0 );
    ramses_util::enable_nodes( "wp_03_dynamic_covernode", "script_noteworthy", 0 );
    m_collision = getent( "mobile_wall_doors_clip", "targetname" );
    m_collision disconnectpaths( 0, 0 );
    var_70d87be7 = getent( "trig_wp_01_kill_stuck_players", "targetname" );
    
    if ( isdefined( var_70d87be7 ) )
    {
        var_70d87be7 triggerenable( 0 );
    }
    
    t_damage_fire = getent( "trig_wp_04_damage", "targetname" );
    t_damage_fire triggerenable( 0 );
    a_shadow_blockers = getentarray( "lgt_shadow_block", "targetname" );
    
    foreach ( blocker in a_shadow_blockers )
    {
        blocker hide();
    }
    
    for ( i = 1; i < 6 ; i++ )
    {
        ramses_util::enable_nodes( "wp_0" + i + "_traversal_jump", "script_noteworthy", 0 );
    }
    
    init_flags();
    setdvar( "ui_newHud", 1 );
}

// Namespace arena_defend
// Params 2
// Checksum 0x2b6bd499, Offset: 0x3458
// Size: 0x264
function intro( str_objective, b_starting )
{
    load::function_73adcefc();
    level scene::init( "cin_ram_05_01_block_1st_rip" );
    level scene::init( "p7_fxanim_cp_ramses_wall_drop_bundle" );
    getent( "mobile_wall_turret_blocker", "targetname" ) hide();
    init_common_scripted_elements( str_objective, b_starting );
    battlechatter::function_d9f49fba( 0 );
    level thread vignette_intro_technical();
    load::function_a2995f22( 2 );
    level thread enable_initial_wave_spawn_managers();
    level thread namespace_a6a248fc::function_1e7ee1cd();
    ramses_util::enable_nodes( "nd_raps_launch_point_1", "targetname", 0 );
    ramses_util::enable_nodes( "nd_raps_launch_point_2", "targetname", 0 );
    ramses_util::enable_nodes( "nd_raps_launch_point_3", "targetname", 0 );
    ramses_util::enable_nodes( "nd_raps_launch_point_4", "targetname", 0 );
    level flag::set( "arena_defend_spawn" );
    level thread open_door_for_intro();
    
    if ( isdefined( level.bzm_ramsesdialogue5callback ) )
    {
        level thread [[ level.bzm_ramsesdialogue5callback ]]();
    }
    
    level thread ramses_util::play_scene_on_notify( "cin_ram_05_01_defend_vign_rescueinjured_r_group", "arena_defend_intro_player_exits_technical" );
    level wall_fxanim_scene( 1 );
    level thread khalil_talks_to_area_commander();
    skipto::objective_completed( str_objective );
}

// Namespace arena_defend
// Params 0
// Checksum 0x90f3c302, Offset: 0x36c8
// Size: 0x54
function open_door_for_intro()
{
    level util::waittill_notify_or_timeout( "arena_defend_intro_open_door", 30 );
    battlechatter::function_d9f49fba( 1 );
    mobile_wall_deploy_skipto( 1 );
}

// Namespace arena_defend
// Params 4
// Checksum 0x56321c89, Offset: 0x3728
// Size: 0xc4
function intro_done( str_objective, b_starting, b_direct, player )
{
    ramses_util::function_7255e66( 0, "alley_mobile_armory" );
    
    if ( b_direct )
    {
        level scene::skipto_end( "cin_ram_05_01_block_1st_rip_skipto" );
    }
    
    if ( b_starting )
    {
        level thread util::set_streamer_hint( 5 );
    }
    
    collectibles::function_93523442( "p7_nc_cai_ram_01", 60, ( 0, -5, 0 ) );
    collectibles::function_37aecd21();
}

// Namespace arena_defend
// Params 2
// Checksum 0x58b944eb, Offset: 0x37f8
// Size: 0x25c
function main( str_objective, b_starting )
{
    if ( b_starting )
    {
        load::function_73adcefc();
        level thread function_b7b36dff();
    }
    
    level thread function_e45af9f2();
    level thread function_f9842c89();
    level flag::set( "arena_defend_spawn" );
    init_common_scripted_elements( str_objective, b_starting );
    getent( "mobile_wall_turret_blocker", "targetname" ) show();
    ramses_accolades::function_bb0dee49();
    ramses_accolades::function_69c025f8();
    ramses_accolades::function_5553172f();
    ramses_accolades::function_cef37178();
    setup_sinkhole_weak_points();
    ramses_util::enable_nodes( "arena_defend_dynamic_covernodes", "script_noteworthy", 0 );
    level thread objectives();
    level thread vo_spike_launched_enemy_tracker();
    level thread hunter_crash_fx_anims();
    
    if ( b_starting )
    {
        level thread setup_intro_scenes_for_skipto();
        level thread show_mobile_wall_building_impact( 1 );
        level thread show_mobile_wall_sidewalk_impact( 1 );
        level flag::wait_till( "arena_defend_mobile_wall_deployed" );
    }
    
    friendlies_take_cover_behind_mobile_wall();
    function_bbf0087d();
    players_destroy_weak_points_in_arena();
    enemies_overrun_checkpoint_area();
    skipto::objective_completed( "arena_defend" );
}

// Namespace arena_defend
// Params 2
// Checksum 0x2d67cf8e, Offset: 0x3a60
// Size: 0x374
function function_4451e1bd( str_objective, b_starting )
{
    if ( b_starting )
    {
        load::function_73adcefc();
        init_common_scripted_elements( str_objective, b_starting );
        level scene::init( "cin_ram_05_demostreet_3rd_sh010" );
        load::function_a2995f22();
        util::screen_fade_out( 0, "black", "skipto_fade" );
        mobile_wall_deploy_skipto();
        level thread function_ce07d8df();
        level function_bccb9996();
        level thread vo_weak_points_all_destroyed();
        level thread sinkhole_objectives();
        level thread show_mobile_wall_building_impact( 1 );
        level thread show_mobile_wall_sidewalk_impact( 1 );
        level thread namespace_a6a248fc::function_7b69c801();
        init_sinkhole();
        level thread wall_fxanim_scene( 0, 1 );
        vh_technical = vehicle::simple_spawn_single( "arena_defend_intro_technical" );
        vh_technical flag::init( "warp_to_spline_end_done" );
        vh_technical util::delay( 0.25, undefined, &kill );
        level thread monitor_vehicle_targets();
        level thread scene::skipto_end( "p7_fxanim_cp_ramses_checkpoint_wall_01_bundle" );
        level thread scene::skipto_end( "p7_fxanim_cp_ramses_checkpoint_wall_02_bundle" );
        util::delay( 0.5, undefined, &util::screen_fade_in, 1.5, "black", "skipto_fade" );
        level notify( #"player_plants_spike" );
        util::delay( 2, undefined, &enemies_overrun_checkpoint_area );
        ramses_accolades::function_bb0dee49();
        ramses_accolades::function_69c025f8();
        ramses_accolades::function_5553172f();
        ramses_accolades::function_cef37178();
    }
    
    friendlies_fall_back_behind_mobile_wall( 0 );
    function_2e8bcd54();
    scene_friendly_detonation_guy_killed();
    players_detonate_charges_from_mobile_wall();
    kill_spawn_manager_group( "arena_defend_spawn_manager_friendly" );
    level.a_e_veh_targets = undefined;
    skipto::objective_completed( "sinkhole_collapse" );
}

// Namespace arena_defend
// Params 0
// Checksum 0x86b6ead0, Offset: 0x3de0
// Size: 0x194
function function_bccb9996()
{
    a_fxanims = array( "wp_01", "wp_02", "wp_03", "wp_04", "wp_05" );
    
    foreach ( str_scene_name in a_fxanims )
    {
        level scene::init( str_scene_name );
        util::wait_network_frame();
    }
    
    showmiscmodels( "sinkhole_misc_model" );
    function_ee6b663( "wp_01" );
    function_ee6b663( "wp_02" );
    function_ee6b663( "wp_03" );
    function_ee6b663( "wp_04" );
    function_ee6b663( "wp_05" );
    level flag::set( "all_weak_points_destroyed" );
}

// Namespace arena_defend
// Params 1
// Checksum 0xe5c37631, Offset: 0x3f80
// Size: 0x3ee
function function_ee6b663( var_ca3f11aa )
{
    level flag::init( var_ca3f11aa );
    level flag::init( var_ca3f11aa + "_identified" );
    level flag::init( var_ca3f11aa + "_destroyed" );
    ramses_util::enable_nodes( var_ca3f11aa + "_covernode", "script_noteworthy", 1 );
    ramses_util::link_traversals( var_ca3f11aa + "_traversal", "script_noteworthy", 1 );
    level flag::set( var_ca3f11aa );
    level flag::set( var_ca3f11aa + "_destroyed" );
    level thread scene::skipto_end( var_ca3f11aa, "targetname" );
    a_collision = getentarray( "collision_" + var_ca3f11aa, "targetname" );
    
    foreach ( mdl_collision in a_collision )
    {
        if ( mdl_collision.targetname != "collision_wp_05" )
        {
            mdl_collision delete();
        }
    }
    
    ramses_util::enable_nodes( var_ca3f11aa + "_traversal_jump", "script_noteworthy", 1 );
    ramses_util::link_traversals( var_ca3f11aa + "_traversal", "script_noteworthy", 0 );
    spawn_manager::kill( "sm_" + var_ca3f11aa + "_defenders", 1 );
    
    switch ( var_ca3f11aa )
    {
        case "wp_01":
            var_70d87be7 = getent( "trig_wp_01_kill_stuck_players", "targetname" );
            
            if ( isdefined( var_70d87be7 ) )
            {
                var_70d87be7 triggerenable( 1 );
            }
            
            break;
        case "wp_02":
            trigger::use( "wp_03_goal_trig" );
            ramses_util::enable_nodes( var_ca3f11aa + "_covernode", "script_noteworthy", 0 );
            break;
        case "wp_04":
            t_damage_fire = getent( "trig_wp_04_damage", "targetname" );
            t_damage_fire triggerenable( 1 );
            spawn_manager::enable( "sm_wp_04_robot_rushers" );
            ramses_util::enable_nodes( "wp_04_raps_walk", "targetname", 0 );
            break;
        case "wp_05":
            spawn_manager::kill( "arena_defend_far_left_enemies" );
        default:
            break;
    }
}

// Namespace arena_defend
// Params 4
// Checksum 0xe0904f35, Offset: 0x4378
// Size: 0x364
function function_82a50f67( str_objective, b_starting, b_direct, player )
{
    if ( b_starting )
    {
        level flag::set( "sinkhole_charges_detonated" );
        objectives::complete( "cp_level_ramses_demolish_arena_defend" );
        cleanup_wall();
    }
    
    objectives::set( "cp_level_ramses_reinforce_safiya" );
    remove_out_of_bounds_trigger_in_alley_building();
    
    if ( level flag::get( "arena_defend_common_elements_initialized" ) )
    {
        spawner::remove_global_spawn_function( "allies", &hero_redshirt_think );
        callback::remove_on_spawned( &remove_redshirt_hero_on_player_count_change );
    }
    
    w_spike_launcher = getweapon( "spike_launcher" );
    
    foreach ( player in level.players )
    {
        if ( player hasweapon( w_spike_launcher ) )
        {
            player takeweapon( w_spike_launcher );
        }
    }
    
    battlechatter::function_d9f49fba( 1 );
    ramses_accolades::function_4df6d923();
    ramses_accolades::function_eb593e7e();
    ramses_accolades::function_a64e00f5();
    ramses_accolades::function_508c89fe();
    t_oob = spawn( "trigger_box", ( 8401, 20022, -60 ), 0, 50000, 50000, 50000 );
    t_oob.angles = ( 0, 134, 0 );
    t_oob thread oob::run_oob_trigger();
    t_oob = spawn( "trigger_box", ( -13310, 1310, 17516 ), 0, 50000, 50000, 50000 );
    t_oob.angles = ( 0, 134, 0 );
    t_oob thread oob::run_oob_trigger();
    spawncollision( "collision_physics_512x512x512", "collider", ( 6672, -16394, 520 ), ( 90, 185.051, 95.0511 ) );
}

// Namespace arena_defend
// Params 0
// Checksum 0x1b18e315, Offset: 0x46e8
// Size: 0x1ec
function function_b7b36dff()
{
    battlechatter::function_d9f49fba( 0 );
    level flag::wait_till( "arena_defend_common_elements_initialized" );
    mobile_wall_deploy_skipto();
    load::function_a2995f22();
    util::screen_fade_out( 0, "black", "skipto_fade" );
    util::delay( 2.5, undefined, &util::screen_fade_in, 1, "black", "skipto_fade" );
    level thread namespace_a6a248fc::function_37e13caa();
    level scene::skipto_end( "cin_ram_05_01_block_1st_rip", undefined, undefined, 0.75, 1 );
    level thread khalil_talks_to_area_commander();
    level thread enable_initial_wave_spawn_managers();
    battlechatter::function_d9f49fba( 1 );
    level flag::set( "intro_igc_done" );
    nd_hendricks = getnode( "hendricks_mobile_wall_top_node", "targetname" );
    level.ai_hendricks.goalradius = 64;
    level.ai_hendricks colors::disable();
    level.ai_hendricks setgoal( nd_hendricks, 1 );
}

// Namespace arena_defend
// Params 2
// Checksum 0x1851efa3, Offset: 0x48e0
// Size: 0x1cc
function init_common_scripted_elements( str_objectives, b_starting )
{
    if ( !level flag::get( "arena_defend_common_elements_initialized" ) )
    {
        add_spawn_functions();
        setup_ambient_elements();
        ramses_util::function_f2f98cfc();
        vtol_igc::hide_skipto_items();
        function_c50ca91();
        
        if ( str_objectives !== "sinkhole_collapse" )
        {
            init_scenes();
        }
        
        setup_heroes( str_objectives, b_starting );
        level flag::set( "arena_defend_common_elements_initialized" );
        spawner::add_global_spawn_function( "allies", &hero_redshirt_think );
        callback::on_spawned( &remove_redshirt_hero_on_player_count_change );
        array::run_all( getentarray( "weak_point_trigger", "script_noteworthy" ), &hide );
        ramses_util::enable_nodes( "arena_defend_mobile_wall_top_nodes", "script_noteworthy", 0 );
        getent( "wp_crouch_cover", "targetname" ) movez( -200, 0.05 );
    }
}

// Namespace arena_defend
// Params 4
// Checksum 0x726bdd5d, Offset: 0x4ab8
// Size: 0x24
function done( str_objective, b_starting, b_direct, player )
{
    
}

// Namespace arena_defend
// Params 2
// Checksum 0xac157767, Offset: 0x4ae8
// Size: 0x84
function setup_heroes( str_objective, b_starting )
{
    init_heroes( str_objective, b_starting );
    level.ai_khalil colors::set_force_color( "y" );
    level.ai_khalil.goalradius = 1024;
    level.ai_hendricks colors::set_force_color( "b" );
}

// Namespace arena_defend
// Params 0
// Checksum 0x851daae1, Offset: 0x4b78
// Size: 0x284
function init_flags()
{
    level flag::init( "arena_defend_initial_spawns_done" );
    level flag::init( "all_spike_launchers_picked_up" );
    level flag::init( "billboard1_crashed" );
    level flag::init( "billboard2_crashed" );
    level flag::init( "sinkhole_explosion_started" );
    level flag::init( "sinkhole_collapse_complete" );
    level flag::init( "intro_technical_dropped_from_vtol" );
    level flag::init( "arena_defend_mobile_wall_deployed" );
    level flag::init( "arena_defend_mobile_wall_doors_open" );
    level flag::init( "arena_defend_intro_technical_disabled" );
    level flag::init( "arena_defend_initial_weak_point_search_finished" );
    level flag::init( "arena_defend_second_wave_weak_points_discovered" );
    level flag::init( "arena_defend_third_wave_weak_points_discovered" );
    level flag::init( "arena_defend_last_wave_weak_points_discovered" );
    level flag::init( "arena_defend_common_elements_initialized" );
    level flag::init( "arena_defend_sinkhole_igc_started" );
    level flag::init( "arena_defend_detonator_dropped" );
    level flag::init( "arena_defend_sinkhole_collapse_done" );
    level flag::init( "arena_defend_rocket_hits_vtol" );
    level flag::init( "arena_defend_detonator_pickup" );
}

// Namespace arena_defend
// Params 2
// Checksum 0xcb4f9bdf, Offset: 0x4e08
// Size: 0xcc
function init_heroes( str_objective, b_starting )
{
    if ( b_starting )
    {
        level.ai_hendricks = util::get_hero( "hendricks" );
        level.ai_khalil = util::get_hero( "khalil" );
    }
    
    skipto::teleport_ai( str_objective, level.heroes );
    
    if ( isdefined( level.ai_hendricks ) )
    {
        level.ai_hendricks colors::enable();
    }
    
    if ( isdefined( level.ai_khalil ) )
    {
        level.ai_khalil colors::disable();
    }
}

// Namespace arena_defend
// Params 0
// Checksum 0xf1ee96fd, Offset: 0x4ee0
// Size: 0x6c
function setup_ambient_elements()
{
    level flag::set( "flak_vtol_ride_stop" );
    level thread ramses_util::arena_defend_flak_exploders();
    level thread ramses_util::delete_all_dead_turrets();
    level thread ramses_util::arena_defend_sinkhole_exploders();
}

// Namespace arena_defend
// Params 0
// Checksum 0xc304a8fb, Offset: 0x4f58
// Size: 0x5e2
function add_spawn_functions()
{
    spawner::add_spawn_function_group( "arena_defend_initial_enemies", "targetname", &enemies_move_up_after_mobile_wall_opens );
    spawner::add_spawn_function_group( "arena_defend_wall_jumper", "script_noteworthy", &arena_defend_wall_jumper_spawnfunc );
    spawner::add_spawn_function_group( "arena_defend_cafe_defender_guys", "targetname", &arena_defend_wall_allies_spawnfunc );
    spawner::add_spawn_function_group( "arena_defend_intro_wall_ally", "script_noteworthy", &arena_defend_wall_allies_spawnfunc );
    spawner::add_spawn_function_group( "arena_defend_reset_anchor", "script_noteworthy", &arena_defend_wall_allies_spawnfunc );
    spawner::add_spawn_function_group( "sp_wp_04_robot_defenders", "targetname", &function_cfffb0c2, "normal" );
    spawner::add_spawn_function_group( "sp_wp_04_robot_rushers", "targetname", &function_cfffb0c2, "rusher" );
    level.w_spike_launcher = getweapon( "spike_launcher" );
    
    for ( i = 1; i < 6 ; i++ )
    {
        spawner::add_spawn_function_group( "wp_0" + i + "_defenders", "targetname", &spawn_func_weak_point_defenders, "wp_0" + i + "_destroyed" );
    }
    
    vehicle::add_spawn_function( "checkpoint_right_fill_raps", &function_69b7b359 );
    vehicle::add_spawn_function( "checkpoint_right_breach_raps", &function_69b7b359 );
    vehicle::add_spawn_function( "arena_defend_quadtank", &quadtank_think );
    vehicle::add_spawn_function( "arena_defend_wall_vtol", &wall_vtol_think );
    vehicle::add_spawn_function( "arena_defend_mobile_wall_turret", &wall_turret_think );
    vehicle::add_spawn_function( "arena_defend_intro_technical", &spawn_func_intro_technical, "arena_defend_intro_technical_disabled" );
    vehicle::add_spawn_function( "arena_defend_intro_technical", &cinematic_crew_unload_on_level_notify, "cin_ram_05_01_defend_aie_nrc_exittruck_variation1", "arena_defend_mobile_wall_doors_open" );
    vehicle::add_spawn_function( "arena_defend_intro_technical", &warp_to_spline_end );
    vehicle::add_spawn_function( "arena_defend_intro_technical", &set_invulnerable_until_spline_end );
    vehicle::add_spawn_function( "arena_defend_technical_01", &set_invulnerable_until_spline_end );
    vehicle::add_spawn_function( "arena_defend_technical_01", &cinematic_crew_unload_on_level_notify, "cin_ram_05_01_defend_aie_nrc_exittruck_variation2", "reached_end_node" );
    vehicle::add_spawn_function( "arena_defend_technical_02", &cinematic_crew_unload_on_level_notify, "cin_ram_05_01_defend_aie_nrc_exittruck_variation1", "reached_end_node" );
    
    foreach ( sp_technical in getentarray( "arena_defend_technical", "script_noteworthy" ) )
    {
        vehicle::add_spawn_function( sp_technical.targetname, &technical_think );
        ramses_util::enable_nodes( sp_technical.targetname + "_vh_end", "targetname", 0 );
    }
    
    e_wasp_goal_volume = getent( "arena_defend_wasp_goal_volume", "targetname" );
    
    foreach ( sp_wasp in getentarray( "arena_defend_wasp", "script_noteworthy" ) )
    {
        vehicle::add_spawn_function( sp_wasp.targetname, &wasp_think, e_wasp_goal_volume );
    }
}

// Namespace arena_defend
// Params 0
// Checksum 0x99ec1590, Offset: 0x5548
// Size: 0x4
function arena_defend_spawnfunc()
{
    
}

// Namespace arena_defend
// Params 0
// Checksum 0xa0e91053, Offset: 0x5558
// Size: 0x12c
function arena_defend_wall_allies_spawnfunc()
{
    self endon( #"death" );
    
    if ( !level flag::get( "arena_defend_mobile_wall_doors_open" ) )
    {
        self setgoal( getent( "sinkhole_friendly_fallback_volume", "targetname" ), 1 );
    }
    
    level flag::wait_till( "arena_defend_mobile_wall_doors_open" );
    self clearforcedgoal();
    
    if ( isdefined( self.target ) )
    {
        e_goal = getent( self.target, "targetname" );
        self setgoal( e_goal );
        return;
    }
    
    self setgoal( getent( "arena_defend_main_goal_volume", "targetname" ) );
}

// Namespace arena_defend
// Params 1
// Checksum 0xa81bcfc5, Offset: 0x5690
// Size: 0x64
function spawn_func_weak_point_defenders( str_flag )
{
    self endon( #"death" );
    level flag::wait_till( str_flag );
    wait randomfloatrange( 2, 8 );
    self.goalradius = 1024;
    self cleargoalvolume();
}

// Namespace arena_defend
// Params 1
// Checksum 0xc19756bb, Offset: 0x5700
// Size: 0xec
function function_cfffb0c2( var_6927be30 )
{
    self endon( #"death" );
    nd_dest = getnode( self.target, "targetname" );
    
    if ( isdefined( nd_dest ) )
    {
        self ai::set_behavior_attribute( "sprint", 1 );
        self setgoal( nd_dest, 1 );
        self waittill( #"goal" );
        self clearforcedgoal();
        self ai::set_behavior_attribute( "move_mode", var_6927be30 );
        self ai::set_behavior_attribute( "sprint", 0 );
    }
}

// Namespace arena_defend
// Params 0
// Checksum 0x58d51f14, Offset: 0x57f8
// Size: 0x44
function enemies_move_up_after_mobile_wall_opens()
{
    self endon( #"death" );
    level flag::wait_till( "arena_defend_mobile_wall_doors_open" );
    wait randomfloatrange( 2, 3 );
}

// Namespace arena_defend
// Params 0
// Checksum 0x321ced99, Offset: 0x5848
// Size: 0x21c
function quadtank_think()
{
    self endon( #"death" );
    self cybercom::cybercom_aioptout( "cybercom_hijack" );
    level thread monitor_vehicle_targets();
    waittillframeend();
    self ai::set_ignoreall( 1 );
    self ai::set_ignoreme( 1 );
    self.trophy_down = 1;
    self.trophy_disables = 999;
    self.weakpointobjective = 1;
    self quadtank::quadtank_weakpoint_display( 0 );
    wait 1;
    
    while ( !level flag::get( "mobile_wall_doors_closing" ) )
    {
        e_player = util::get_closest_player( self.origin, "allies" );
        a_targets = array::get_all_closest( e_player.origin, level.a_e_veh_targets, undefined, 8 );
        a_targets = array::randomize( a_targets );
        
        for ( i = 0; i < 8 ; i++ )
        {
            self _tank_fire_javelin( a_targets[ i ] );
        }
        
        wait randomfloatrange( 6, 8 );
    }
    
    level flag::wait_till( "arena_defend_sinkhole_collapse_done" );
    self.delete_on_death = 1;
    self notify( #"death" );
    
    if ( !isalive( self ) )
    {
        self delete();
    }
}

// Namespace arena_defend
// Params 1
// Checksum 0x9dfaf0a, Offset: 0x5a70
// Size: 0xcc
function _tank_fire_javelin( e_target )
{
    self endon( #"death" );
    level endon( #"delete_javelins" );
    weapon = getweapon( "quadtank_main_turret_rocketpods_javelin" );
    v_offset = ( 0, 0, 300 );
    var_4d75b06 = magicbullet( weapon, self.origin + v_offset, e_target.origin, self, e_target );
    var_4d75b06 thread function_f1b4eb94( "delete_javelins" );
    wait 0.65;
}

// Namespace arena_defend
// Params 1
// Checksum 0x2f0b90f0, Offset: 0x5b48
// Size: 0x34
function function_f1b4eb94( str_notify )
{
    self endon( #"death" );
    level waittill( str_notify );
    self delete();
}

// Namespace arena_defend
// Params 2
// Checksum 0xb96176c4, Offset: 0x5b88
// Size: 0x30a
function cinematic_crew_unload_on_level_notify( str_scene, str_notify )
{
    self endon( #"death" );
    self.a_ents = spawner::simple_spawn( "cinematic_technical_riders" );
    self thread function_8efb2b2( self.a_ents );
    array::thread_all( self.a_ents, &ignore_me_until_notify, "stop_ignoring_me" );
    
    if ( !isdefined( self.a_ents ) )
    {
        self.a_ents = [];
    }
    else if ( !isarray( self.a_ents ) )
    {
        self.a_ents = array( self.a_ents );
    }
    
    self.a_ents[ self.a_ents.size ] = self;
    
    if ( self.targetname == "arena_defend_technical_01_vh" )
    {
        self thread function_11d73ca7( 1 );
        self thread function_3a136a27( 1 );
        level notify( #"first_turret_guy_vulnerable" );
    }
    
    if ( self.targetname == "arena_defend_technical_02_vh" )
    {
        self thread function_11d73ca7( 2 );
        self thread function_3a136a27( 2 );
        level notify( #"first_turret_guy_vulnerable" );
    }
    
    self.a_ents = array::remove_dead( self.a_ents );
    self thread scene::init( str_scene, self.a_ents );
    
    if ( self.targetname == "arena_defend_intro_technical_vh" )
    {
        level flag::wait_till( str_notify );
        wait 3;
    }
    else
    {
        self waittill( str_notify );
    }
    
    self.a_ents = array::remove_dead( self.a_ents );
    self thread scene::play( str_scene, self.a_ents );
    
    foreach ( ent in self.a_ents )
    {
        if ( isalive( ent ) )
        {
            ent notify( #"stop_ignoring_me" );
        }
    }
}

// Namespace arena_defend
// Params 1
// Checksum 0x34b24528, Offset: 0x5ea0
// Size: 0x34
function function_11d73ca7( number )
{
    self endon( #"death" );
    self playsound( "evt_tech_driveup_" + number );
}

// Namespace arena_defend
// Params 1
// Checksum 0x7808a592, Offset: 0x5ee0
// Size: 0x3c
function function_3a136a27( number )
{
    self waittill( #"death" );
    self stopsound( "evt_tech_driveup_" + number );
}

// Namespace arena_defend
// Params 1
// Checksum 0xf33d8e56, Offset: 0x5f28
// Size: 0xaa
function function_8efb2b2( riders )
{
    self endon( #"hash_60ddc943" );
    self waittill( #"death" );
    
    foreach ( rider in riders )
    {
        vehicle::kill_rider( rider );
    }
}

// Namespace arena_defend
// Params 1
// Checksum 0x610d9a38, Offset: 0x5fe0
// Size: 0x4c
function ignore_me_until_notify( str_notify )
{
    self endon( #"death" );
    self ai::set_ignoreme( 1 );
    self waittill( str_notify );
    self ai::set_ignoreme( 0 );
}

// Namespace arena_defend
// Params 1
// Checksum 0xbc2705dc, Offset: 0x6038
// Size: 0x84
function vehicle_go_path_on_level_notify( str_notify )
{
    self endon( #"death" );
    self endon( #"warp_to_spline_end" );
    assert( isdefined( self.target ), "<dev string:x28>" + self.origin + "<dev string:x34>" );
    level waittill( str_notify );
    self thread vehicle::get_on_and_go_path( self.target );
}

// Namespace arena_defend
// Params 0
// Checksum 0xe1e944f2, Offset: 0x60c8
// Size: 0x44
function set_invulnerable_until_spline_end()
{
    self endon( #"death" );
    self util::magic_bullet_shield();
    self waittill( #"reached_end_node" );
    self util::stop_magic_bullet_shield();
}

// Namespace arena_defend
// Params 0
// Checksum 0x18317681, Offset: 0x6118
// Size: 0x10c
function warp_to_spline_end()
{
    self endon( #"death" );
    wait 0.1;
    self notify( #"warp_to_spline_end" );
    
    for ( nd_target = getvehiclenode( self.target, "targetname" ); isdefined( nd_target.target ) ; nd_target = getvehiclenode( nd_target.target, "targetname" ) )
    {
    }
    
    self.origin = nd_target.origin;
    self.angles = nd_target.angles;
    self notify( #"reached_end_node" );
    
    if ( self flag::exists( "warp_to_spline_end_done" ) )
    {
        self flag::set( "warp_to_spline_end_done" );
    }
}

// Namespace arena_defend
// Params 0
// Checksum 0x8e08efa3, Offset: 0x6230
// Size: 0x16c
function hero_redshirt_think()
{
    self endon( #"death" );
    self endon( #"demote_hero" );
    
    if ( !isdefined( level.arena_defend_redshirt_hero ) )
    {
        level.arena_defend_redshirt_hero = [];
    }
    
    n_hero_count_max = get_hero_redshirt_count();
    b_should_be_hero = n_hero_count_max > level.arena_defend_redshirt_hero.size && self is_redshirt_correct_color_group() && !self util::is_hero();
    
    if ( b_should_be_hero )
    {
        if ( !isdefined( level.arena_defend_redshirt_hero ) )
        {
            level.arena_defend_redshirt_hero = [];
        }
        else if ( !isarray( level.arena_defend_redshirt_hero ) )
        {
            level.arena_defend_redshirt_hero = array( level.arena_defend_redshirt_hero );
        }
        
        level.arena_defend_redshirt_hero[ level.arena_defend_redshirt_hero.size ] = self;
        self util::magic_bullet_shield( self );
        level waittill( #"sinkhole_charges_detonated" );
        arrayremovevalue( level.arena_defend_redshirt_hero, self, 0 );
        self util::stop_magic_bullet_shield( self );
    }
}

// Namespace arena_defend
// Params 0
// Checksum 0xca843737, Offset: 0x63a8
// Size: 0x24
function get_hero_redshirt_count()
{
    n_hero_count_max = 5 - level.players.size;
    return n_hero_count_max;
}

// Namespace arena_defend
// Params 0
// Checksum 0x4fa870e2, Offset: 0x63d8
// Size: 0x2a, Type: bool
function is_redshirt_hero()
{
    return isdefined( level.arena_defend_redshirt_hero ) && isinarray( level.arena_defend_redshirt_hero, self );
}

// Namespace arena_defend
// Params 0
// Checksum 0xabf6a367, Offset: 0x6410
// Size: 0x1ee
function is_redshirt_correct_color_group()
{
    if ( !self colors::has_color() )
    {
        b_correct_group = 0;
    }
    else
    {
        str_my_color = self.script_forcecolor;
        n_guys_max = get_hero_redshirt_count();
        n_blue_max = ceil( n_guys_max / 2 );
        n_yellow_max = n_guys_max - n_blue_max;
        n_blue = 0;
        n_yellow = 0;
        
        foreach ( ai_guy in level.arena_defend_redshirt_hero )
        {
            if ( isdefined( ai_guy ) )
            {
                if ( ai_guy.script_forcecolor == "b" )
                {
                    n_blue++;
                    continue;
                }
                
                if ( ai_guy.script_forcecolor == "y" )
                {
                    n_yellow++;
                }
            }
        }
        
        if ( n_blue < n_blue_max && str_my_color == "b" )
        {
            b_correct_group = 1;
        }
        else if ( n_yellow < n_yellow_max && str_my_color == "y" )
        {
            b_correct_group = 1;
        }
        else
        {
            b_correct_group = 0;
        }
    }
    
    return b_correct_group;
}

// Namespace arena_defend
// Params 0
// Checksum 0x3b341b56, Offset: 0x6608
// Size: 0xbc
function remove_redshirt_hero_on_player_count_change()
{
    if ( !isdefined( level.arena_defend_redshirt_hero ) )
    {
        level.arena_defend_redshirt_hero = [];
    }
    
    n_hero_count_max = get_hero_redshirt_count();
    
    if ( level.arena_defend_redshirt_hero.size > n_hero_count_max )
    {
        ai_guy = array::random( level.arena_defend_redshirt_hero );
        arrayremovevalue( level.arena_defend_redshirt_hero, ai_guy, 0 );
        
        if ( isalive( ai_guy ) )
        {
            ai_guy util::stop_magic_bullet_shield();
        }
    }
}

// Namespace arena_defend
// Params 1
// Checksum 0xd2ecfd22, Offset: 0x66d0
// Size: 0x154
function spawn_func_intro_technical( str_flag )
{
    self endon( #"death" );
    self thread set_level_flag_on_death( str_flag );
    
    while ( !self flag::exists( "spawned_gunner" ) )
    {
        wait 1;
    }
    
    self flag::wait_till( "spawned_gunner" );
    ai_rider = self vehicle::get_rider( "gunner1" );
    
    if ( isalive( ai_rider ) )
    {
        ai_rider ai::set_ignoreme( 1 );
    }
    
    level flag::wait_till( "arena_defend_mobile_wall_doors_open" );
    
    if ( isalive( ai_rider ) )
    {
        ai_rider ai::set_ignoreme( 0 );
        ai_rider waittill( #"death" );
    }
    
    wait 8;
    level flag::set( str_flag );
}

// Namespace arena_defend
// Params 1
// Checksum 0x30776159, Offset: 0x6830
// Size: 0x34
function set_level_flag_on_death( str_flag )
{
    self waittill( #"death" );
    level flag::set( str_flag );
}

// Namespace arena_defend
// Params 1
// Checksum 0x8c335498, Offset: 0x6870
// Size: 0x3c
function wasp_think( e_goal_volume )
{
    self endon( #"death" );
    
    if ( isdefined( e_goal_volume ) )
    {
        self setgoal( e_goal_volume );
    }
}

// Namespace arena_defend
// Params 0
// Checksum 0x3a6b5103, Offset: 0x68b8
// Size: 0x228
function technical_think()
{
    self endon( #"death" );
    self thread allow_vehicle_to_fall_after_sinkhole_collapse();
    self flag::init( "spawned_gunner" );
    self flag::init( "gunner_position_occupied" );
    ai_gunner = self spawn_turret_gunner();
    ai_driver = self spawn_technical_driver();
    ai_gunner thread turret_disable_on_vehicle_death( self );
    self thread kill_vehicle_on_scene_play();
    self thread gunner_position_think();
    self makevehicleusable();
    self setseatoccupied( 0, 1 );
    
    if ( self flag::exists( "warp_to_spline_end_done" ) )
    {
        self flag::wait_till( "warp_to_spline_end_done" );
    }
    else
    {
        self waittill( #"reached_end_node" );
    }
    
    v_end_pos = self.origin;
    v_end_angles = self.angles;
    level notify( self.targetname + "_reached_end_node" );
    self vehicle::get_off_path();
    wait 0.05;
    
    if ( isalive( ai_driver ) )
    {
        ai_driver vehicle::get_out();
    }
    
    self waittill( #"death" );
    self.origin = v_end_pos;
    self.angles = v_end_angles;
}

// Namespace arena_defend
// Params 0
// Checksum 0x44e76225, Offset: 0x6ae8
// Size: 0x64
function allow_vehicle_to_fall_after_sinkhole_collapse()
{
    self.no_free_on_death = 1;
    level waittill( #"sinkhole_vehicle_fall" );
    
    if ( isdefined( self ) )
    {
        self launchvehicle( ( 0, 0, 100 ) );
    }
    
    level clientfield::increment( "clear_all_dyn_ents", 1 );
}

// Namespace arena_defend
// Params 1
// Checksum 0xd53263f, Offset: 0x6b58
// Size: 0x238
function gunner_position_think( b_find_new_gunner )
{
    if ( !isdefined( b_find_new_gunner ) )
    {
        b_find_new_gunner = 0;
    }
    
    self endon( #"death" );
    self turret::set_burst_parameters( 1, 2, 0.25, 0.75, 1 );
    
    while ( true )
    {
        ai_gunner = self vehicle::get_rider( "gunner1" );
        
        if ( isdefined( ai_gunner ) )
        {
            self turret::enable( 1, 1 );
            self flag::set( "gunner_position_occupied" );
            ai_gunner waittill( #"death" );
        }
        
        self turret::disable( 1 );
        self flag::clear( "gunner_position_occupied" );
        
        if ( b_find_new_gunner )
        {
            wait randomfloatrange( 5, 8 );
            
            if ( self gunner_position_is_safe() )
            {
                ai_gunner_next = self find_new_gunner();
                
                if ( isalive( ai_gunner_next ) )
                {
                    /#
                        ai_gunner_next thread debug_run_to_gunner_position( self );
                    #/
                    
                    ai_gunner_next thread vehicle::get_in( self, "gunner1", 0 );
                    ai_gunner_next util::waittill_any( "death", "in_vehicle" );
                }
            }
            
            continue;
        }
        
        break;
    }
}

// Namespace arena_defend
// Params 0
// Checksum 0x611a50f9, Offset: 0x6d98
// Size: 0x176
function find_new_gunner()
{
    a_ai = getaiteamarray( self.team );
    a_valid = [];
    
    foreach ( ai_guy in a_ai )
    {
        if ( !isdefined( ai_guy.vehicle ) && ai_guy.archetype === "human" )
        {
            if ( !isdefined( a_valid ) )
            {
                a_valid = [];
            }
            else if ( !isarray( a_valid ) )
            {
                a_valid = array( a_valid );
            }
            
            a_valid[ a_valid.size ] = ai_guy;
        }
    }
    
    ai_gunner = arraysort( a_valid, self.origin, 1, a_ai.size, 800 )[ 0 ];
    return ai_gunner;
}

// Namespace arena_defend
// Params 0
// Checksum 0xc3c9e52f, Offset: 0x6f18
// Size: 0xa8
function gunner_position_is_safe()
{
    a_enemies = getaiteamarray( get_enemy_team( self.team ) );
    a_enemies_nearby = arraysort( a_enemies, self.origin, 1, a_enemies.size, 300 );
    b_enemies_in_range = a_enemies_nearby.size > 0;
    b_is_safe = !b_enemies_in_range;
    return b_is_safe;
}

// Namespace arena_defend
// Params 1
// Checksum 0x1af1997f, Offset: 0x6fc8
// Size: 0x94
function get_enemy_team( str_team )
{
    if ( str_team == "axis" )
    {
        str_enemy_team = "allies";
    }
    else if ( str_team == "allies" )
    {
        str_enemy_team = "axis";
    }
    else
    {
        assertmsg( "<dev string:x7e>" + str_team + "<dev string:xa2>" );
        str_enemy_team = "none";
    }
    
    return str_enemy_team;
}

// Namespace arena_defend
// Params 1
// Checksum 0xe5962a28, Offset: 0x7068
// Size: 0x80
function debug_run_to_gunner_position( vehicle )
{
    self endon( #"death" );
    self endon( #"in_vehicle" );
    vehicle endon( #"death" );
    
    while ( true )
    {
        /#
            line( self.origin, vehicle.origin, ( 1, 0, 0 ), 1, 0, 1 );
        #/
        
        wait 0.05;
    }
}

// Namespace arena_defend
// Params 0
// Checksum 0x9e4d21ee, Offset: 0x70f0
// Size: 0x34
function kill_vehicle_on_scene_play()
{
    self endon( #"death" );
    self waittill( #"kill_passengers" );
    self kill();
}

// Namespace arena_defend
// Params 1
// Checksum 0x7a14719c, Offset: 0x7130
// Size: 0x74
function turret_disable_on_vehicle_death( vh_technical )
{
    self waittill( #"death" );
    
    if ( isdefined( self ) )
    {
        self unlink();
    }
    
    if ( isdefined( vh_technical ) )
    {
        if ( !vehicle::is_corpse( vh_technical ) )
        {
            vh_technical turret::disable( 1 );
        }
    }
}

// Namespace arena_defend
// Params 1
// Checksum 0xf672c0bf, Offset: 0x71b0
// Size: 0x84
function _kill_on_vehicle_death( vh_technical )
{
    self endon( #"death" );
    vh_technical util::waittill_either( "death", "kill_passengers" );
    self util::stop_magic_bullet_shield();
    self unlink();
    self kill();
}

// Namespace arena_defend
// Params 0
// Checksum 0xc23f55c6, Offset: 0x7240
// Size: 0x70
function spawn_turret_gunner()
{
    ai_gunner = spawner::simple_spawn_single( "arena_defend_technical_gunner_generic" );
    ai_gunner vehicle::get_in( self, "gunner1", 1 );
    self flag::set( "spawned_gunner" );
    return ai_gunner;
}

// Namespace arena_defend
// Params 0
// Checksum 0xff097d88, Offset: 0x72b8
// Size: 0x50
function spawn_technical_driver()
{
    ai_driver = spawner::simple_spawn_single( "arena_defend_technical_driver_generic" );
    ai_driver vehicle::get_in( self, "driver", 1 );
    return ai_driver;
}

// Namespace arena_defend
// Params 0
// Checksum 0x94b0610, Offset: 0x7310
// Size: 0x44
function wall_vtol_think()
{
    vnd_start = getvehiclenode( self.target, "targetname" );
    vehicle::get_on_and_go_path( vnd_start );
}

// Namespace arena_defend
// Params 0
// Checksum 0xedc80fac, Offset: 0x7360
// Size: 0x14
function wall_turret_think()
{
    self.team = "allies";
}

// Namespace arena_defend
// Params 0
// Checksum 0x4e06d774, Offset: 0x7380
// Size: 0x1c
function friendlies_take_cover_behind_mobile_wall()
{
    trigger::use( "arena_defend_colors_allies_behind_mobile_wall" );
}

// Namespace arena_defend
// Params 1
// Checksum 0xf62289d3, Offset: 0x73a8
// Size: 0x2c
function friendlies_move_to_position( str_trigger_suffix )
{
    trigger::use( "arena_defend_color_allies_" + str_trigger_suffix );
}

// Namespace arena_defend
// Params 0
// Checksum 0x3b6e43df, Offset: 0x73e0
// Size: 0x1c
function friendlies_move_to_wp_02_03()
{
    friendlies_move_to_position( "wp_02_03" );
}

// Namespace arena_defend
// Params 0
// Checksum 0x93344838, Offset: 0x7408
// Size: 0x34
function friendlies_move_to_final_street_position()
{
    friendlies_move_to_position( "wp_04" );
    level thread hendricks_robot_melee();
}

// Namespace arena_defend
// Params 0
// Checksum 0x3e0ad48f, Offset: 0x7448
// Size: 0x144
function function_ce07d8df()
{
    level waittill( #"player_plants_spike" );
    spawner::add_spawn_function_group( "detonation_guy", "targetname", &function_eb0491d7 );
    level scene::init( "cin_ram_05_demostreet_vign_intro_detonation_guy" );
    level.ai_hendricks.goalradius = 32;
    nd_fallback_hendricks = getnode( "hendricks_mobile_wall_start_node", "targetname" );
    level.ai_hendricks thread ai::force_goal( nd_fallback_hendricks, 32, 1, undefined, 1 );
    level.ai_khalil.goalradius = 32;
    nd_fallback_khalil = getnode( "arena_defend_demostreet_intro_khalil", "targetname" );
    level.ai_khalil thread ai::force_goal( nd_fallback_khalil, 32, 1, undefined, 1 );
}

// Namespace arena_defend
// Params 0
// Checksum 0x898054fa, Offset: 0x7598
// Size: 0x24
function hendricks_robot_melee()
{
    level scene::init( "cin_gen_melee_hendricksmoment_closecombat_robot" );
}

// Namespace arena_defend
// Params 0
// Checksum 0x9721bf53, Offset: 0x75c8
// Size: 0x516
function vignette_egyptian_soldiers_killed_by_wasps()
{
    a_nodes_on_scaffold = getnodearray( "arena_defend_wasp_vignette_nodes", "script_noteworthy" );
    assert( a_nodes_on_scaffold.size, "<dev string:xa5>" );
    n_guys_required = a_nodes_on_scaffold.size;
    a_scaffold_guys = [];
    
    for ( i = 0; i < a_nodes_on_scaffold.size ; i++ )
    {
        ai_guy = spawner::simple_spawn_single( "arena_defend_wasp_vignette_friendly" );
        
        if ( !isdefined( a_scaffold_guys ) )
        {
            a_scaffold_guys = [];
        }
        else if ( !isarray( a_scaffold_guys ) )
        {
            a_scaffold_guys = array( a_scaffold_guys );
        }
        
        a_scaffold_guys[ a_scaffold_guys.size ] = ai_guy;
        ai_guy ai::set_ignoreme( 1 );
        wait 2.5;
    }
    
    while ( a_scaffold_guys.size != a_nodes_on_scaffold.size )
    {
        wait 1;
        a_friendlies = getaispeciesarray( "allies", "human" );
        a_friendlies = arraysortclosest( a_friendlies, a_nodes_on_scaffold[ 0 ].origin, a_friendlies.size );
        a_scaffold_guys = [];
        
        foreach ( ai_guy in a_friendlies )
        {
            b_guy_is_valid = !ai_guy util::is_hero() && !ai_guy is_redshirt_hero() && !ai_guy isinscriptedstate();
            
            if ( b_guy_is_valid )
            {
                if ( !isdefined( a_scaffold_guys ) )
                {
                    a_scaffold_guys = [];
                }
                else if ( !isarray( a_scaffold_guys ) )
                {
                    a_scaffold_guys = array( a_scaffold_guys );
                }
                
                a_scaffold_guys[ a_scaffold_guys.size ] = ai_guy;
                ai_guy ai::set_ignoreme( 1 );
            }
            
            if ( a_scaffold_guys.size == n_guys_required )
            {
                break;
            }
        }
    }
    
    for ( i = 0; i < a_scaffold_guys.size ; i++ )
    {
        if ( isalive( a_scaffold_guys[ i ] ) )
        {
            a_scaffold_guys[ i ].goalradius = 64;
            a_scaffold_guys[ i ] thread ai::force_goal( a_nodes_on_scaffold[ i ], 64, 0, "goal", 0, 1 );
            self thread notify_self_on_goal( a_scaffold_guys[ i ] );
        }
    }
    
    n_guys_at_goal = 0;
    
    do
    {
        self waittill( #"arena_defend_wasp_vignette_guy_at_goal" );
        n_guys_at_goal++;
    }
    while ( n_guys_at_goal < a_scaffold_guys.size );
    
    wait_for_player_to_look_at_scaffold();
    
    foreach ( ai_guy in a_scaffold_guys )
    {
        if ( isalive( ai_guy ) )
        {
            ai_guy ai::set_ignoreme( 0 );
        }
    }
    
    for ( j = 0; j < 2 ; j++ )
    {
        vh_wasp = spawner::simple_spawn_single( "arena_defend_vignette_wasp" );
        vh_wasp thread vignette_wasp_think( a_scaffold_guys, j );
        wait 0.5;
    }
}

// Namespace arena_defend
// Params 0
// Checksum 0x66bd5e8a, Offset: 0x7ae8
// Size: 0x24
function wait_for_player_to_look_at_scaffold()
{
    level endon( #"all_weak_points_destroyed" );
    trigger::wait_till( "arena_defend_wasp_vignette_trigger" );
}

// Namespace arena_defend
// Params 2
// Checksum 0x15dafd02, Offset: 0x7b18
// Size: 0x32c
function vignette_wasp_think( a_targets, n_path )
{
    self endon( #"death" );
    self ai::set_ignoreall( 1 );
    self ai::set_ignoreme( 1 );
    self setneargoalnotifydist( 300 );
    e_wasp_path = getvehiclenode( "arena_defend_wasp_vignette_path" + n_path, "targetname" );
    assert( isdefined( e_wasp_path ), "<dev string:xfc>" + n_path + "<dev string:x11c>" );
    self vehicle_ai::start_scripted();
    self vehicle::get_on_and_go_path( e_wasp_path );
    self util::waittill_any_timeout( 6, "reached_end_node" );
    self vehicle_ai::stop_scripted( "combat" );
    
    foreach ( ai_guy in a_targets )
    {
        if ( isdefined( ai_guy ) && isalive( ai_guy ) )
        {
            self setgoal( ai_guy );
            ai_guy util::stop_magic_bullet_shield();
            
            if ( isdefined( ai_guy ) && isalive( ai_guy ) )
            {
                ai_guy.health = 1;
                self thread ai::shoot_at_target( "shoot_until_target_dead", ai_guy );
                ai_guy util::waittill_any( "death", "pain" );
                
                if ( isalive( ai_guy ) )
                {
                    ai_guy kill();
                }
                
                wait 2;
            }
        }
    }
    
    self ai::set_ignoreall( 0 );
    self ai::set_ignoreme( 0 );
    arena_defend_wasp_goal_volume = getent( "arena_defend_wasp_goal_volume", "targetname" );
    self setgoal( arena_defend_wasp_goal_volume, 1 );
}

// Namespace arena_defend
// Params 1
// Checksum 0xf8b8175e, Offset: 0x7e50
// Size: 0x56
function notify_self_on_goal( ai_guy )
{
    str_message = ai_guy util::waittill_any_timeout( 15, "goal", "near_goal", "death" );
    self notify( #"arena_defend_wasp_vignette_guy_at_goal" );
}

// Namespace arena_defend
// Params 6
// Checksum 0x9ad6d3ab, Offset: 0x7eb0
// Size: 0x2a8
function send_ai_type_within_radius_to_node( str_type, str_faction, str_node_targetname, n_radius_outer, n_radius_inner, var_ff46257e )
{
    if ( !isdefined( n_radius_inner ) )
    {
        n_radius_inner = 0;
    }
    
    if ( !isdefined( var_ff46257e ) )
    {
        var_ff46257e = 1;
    }
    
    nd_goal = getnode( str_node_targetname, "targetname" );
    
    do
    {
        a_ai = getaispeciesarray( str_faction, str_type );
        a_sorted = arraysortclosest( a_ai, nd_goal.origin, a_ai.size, n_radius_inner, n_radius_outer );
        
        foreach ( ai in a_ai )
        {
            if ( ai util::is_hero() || ai is_redshirt_hero() )
            {
                arrayremovevalue( a_sorted, ai, 0 );
            }
        }
        
        if ( a_sorted.size > 0 )
        {
            ai_guy = a_sorted[ 0 ];
            continue;
        }
        
        wait 1;
    }
    while ( !isdefined( ai_guy ) );
    
    ai_guy.goalradius = 32;
    b_shoot = 0;
    str_endon = undefined;
    b_keep_colors = 0;
    b_should_sprint = 1;
    
    if ( !var_ff46257e )
    {
        ai_guy.cybercomtargetstatusoverride = 0;
    }
    
    ai_guy thread ai::force_goal( nd_goal, 32, b_shoot, str_endon, b_keep_colors, b_should_sprint );
    ai_guy util::waittill_any_timeout( 15, "goal", "death" );
    return ai_guy;
}

// Namespace arena_defend
// Params 0
// Checksum 0xaf9dc6df, Offset: 0x8160
// Size: 0xcc
function vignette_intro_technical()
{
    vh_technical = vehicle::simple_spawn_single( "arena_defend_intro_technical" );
    vh_technical flag::init( "warp_to_spline_end_done" );
    
    while ( !vh_technical turret::is_turret_enabled( 1 ) )
    {
        wait 0.25;
    }
    
    vh_technical turret::disable( 1 );
    level waittill( #"arena_defend_intro_player_exits_technical" );
    level scene::play( "cin_ram_05_02_block_vign_mowed" );
    vh_technical turret::enable( 1, 1 );
}

// Namespace arena_defend
// Params 1
// Checksum 0xd4e3e932, Offset: 0x8238
// Size: 0x154
function scene_callback_intro_technical_murder( a_ents )
{
    vh_technical = getent( "arena_defend_intro_technical_vh", "targetname" );
    e_turret_target = getent( "so_arena_defend_intro_turret_target", "targetname" );
    
    foreach ( ent in a_ents )
    {
        if ( isai( ent ) && isalive( ent ) )
        {
            ent util::stop_magic_bullet_shield();
        }
    }
    
    if ( isdefined( vh_technical ) && isdefined( e_turret_target ) )
    {
        vh_technical thread turret::shoot_at_target( e_turret_target, 10, ( 0, 0, 0 ), 1, 0 );
    }
}

// Namespace arena_defend
// Params 0
// Checksum 0x513e523a, Offset: 0x8398
// Size: 0xd0
function vignette_spike_launched_guy()
{
    self endon( #"death" );
    self thread spike_launched_guy_death();
    self ai::set_ignoreme( 1 );
    nd_spike_launcher_guy = getnode( "node_spike_launch_start", "targetname" );
    self ai::force_goal( nd_spike_launcher_guy, 8, 1, "goal" );
    self.goalradius = 8;
    wait 5;
    self ai::set_ignoreme( 0 );
    wait 5;
    self.goalradius = 512;
}

// Namespace arena_defend
// Params 0
// Checksum 0x3f8955cc, Offset: 0x8470
// Size: 0x10
function spike_launched_guy_death()
{
    self waittill( #"death" );
}

// Namespace arena_defend
// Params 0
// Checksum 0xa771bdaa, Offset: 0x8488
// Size: 0x1e8
function monitor_vehicle_targets()
{
    level endon( #"mobile_wall_doors_closing" );
    level.a_e_veh_targets = getentarray( "arena_defend_tank_target_e3", "targetname" );
    a_e_model_targets = [];
    
    foreach ( target in level.a_e_veh_targets )
    {
        mdl_target = spawn( "script_model", target.origin );
        mdl_target.angles = target.angles;
        mdl_target.script_objective = "sinkhole_collapse";
        mdl_target setmodel( "tag_origin" );
        util::wait_network_frame();
        
        if ( !isdefined( a_e_model_targets ) )
        {
            a_e_model_targets = [];
        }
        else if ( !isarray( a_e_model_targets ) )
        {
            a_e_model_targets = array( a_e_model_targets );
        }
        
        a_e_model_targets[ a_e_model_targets.size ] = mdl_target;
    }
    
    while ( true )
    {
        level waittill( #"player_spawned" );
        level.a_e_veh_targets = arraycombine( level.activeplayers, level.a_e_veh_targets, 0, 0 );
    }
}

// Namespace arena_defend
// Params 0
// Checksum 0xd7a42470, Offset: 0x8678
// Size: 0x174
function enable_initial_wave_spawn_managers()
{
    level endon( #"arena_defend_initial_spawns_done" );
    level flag::wait_till( "all_players_connected" );
    spawn_manager::enable( "sm_arena_defend_initial_enemies" );
    spawn_manager::enable( "sm_arena_defend_initial_rear" );
    spawner::simple_spawn( "arena_defend_initial_right_building" );
    util::wait_network_frame();
    spawn_manager::enable( "arena_defend_wall_allies" );
    spawn_manager::enable( "arena_defend_wall_allies2" );
    spawn_manager::enable( "arena_defend_bldg_allies" );
    spawn_manager::enable( "arena_defend_cafe_defenders" );
    level thread util::delay( 7, undefined, &friendlies_take_cover_behind_mobile_wall );
    level thread util::delay( 7, undefined, &flag::set, "arena_defend_initial_spawns_done" );
    spawn_manager::wait_till_complete( "sm_arena_defend_initial_enemies" );
    level flag::set( "arena_defend_initial_spawns_done" );
}

// Namespace arena_defend
// Params 0
// Checksum 0xefbd62a5, Offset: 0x87f8
// Size: 0x174
function function_f4554829()
{
    nd_hendricks = getnode( "hendricks_mobile_wall_top_node", "targetname" );
    level.ai_hendricks.goalradius = 64;
    level.ai_hendricks colors::disable();
    ramses_util::enable_nodes( "arena_defend_mobile_wall_top_nodes", "script_noteworthy", 1 );
    level.ai_hendricks setgoal( nd_hendricks, 1 );
    level.ai_hendricks util::waittill_notify_or_timeout( "goal", 15 );
    level flag::wait_till( "arena_defend_intro_technical_disabled" );
    spawn_manager::enable( "sm_wp_01_defenders" );
    wait 4;
    vignette_hendricks_leap();
    wait 2;
    level thread friendlies_move_to_position( "wp_01" );
    trigger::use( "arena_defend_tech_1_trig", "targetname", undefined, 0 );
    vo_weak_point_first_intro();
}

// Namespace arena_defend
// Params 0
// Checksum 0x28ec3a8b, Offset: 0x8978
// Size: 0x1b4
function enemy_wave_right_wall_push()
{
    spawn_manager::kill( "sm_wp_01_defenders" );
    spawn_manager::enable( "sm_wp_02_defenders" );
    util::wait_network_frame();
    spawn_manager::enable( "arena_defend_push_wasps" );
    util::wait_network_frame();
    a_dialogue_lines = [];
    a_dialogue_lines[ 0 ] = "esl4_hostile_grunts_movin_0";
    a_dialogue_lines[ 1 ] = "esl3_enemy_grunts_breakin_0";
    a_dialogue_lines[ 2 ] = "esl4_hostile_grunts_at_so_0";
    ai_guy = vo_find_closest_redshirt_for_dialog();
    ai_guy thread dialog::say( vo_pick_random_line( a_dialogue_lines ) );
    
    if ( !level flag::get( "billboard1_crashed" ) )
    {
        spawn_manager::enable( "sm_arena_defend_snipers_center_building" );
        
        if ( level.players.size > 1 )
        {
            a_dialogue_lines = [];
            a_dialogue_lines[ 0 ] = "esl1_sniper_on_the_roof_0";
            a_dialogue_lines[ 1 ] = "egy2_i_have_an_enemy_snip_0";
            ai_guy = vo_find_closest_redshirt_for_dialog();
            ai_guy thread dialog::say( vo_pick_random_line( a_dialogue_lines ), 2 );
        }
    }
}

// Namespace arena_defend
// Params 0
// Checksum 0x2626f149, Offset: 0x8b38
// Size: 0x6c
function function_44a7ad7b()
{
    trigger::wait_or_timeout( 15, "wp_03_goal_trig", "targetname" );
    spawn_manager::enable( "sm_wp_03_defenders_jumpers" );
    spawn_manager::enable( "arena_defend_robot_fill" );
    function_60f90684();
}

// Namespace arena_defend
// Params 0
// Checksum 0x82ca460d, Offset: 0x8bb0
// Size: 0x13c
function arena_defend_wall_jumper_spawnfunc()
{
    self endon( #"death" );
    self.ignoreall = 1;
    n_jump_location = randomintrange( 1, 5 );
    str_jump_location_up = "scene_wall_left_jumpover_up_0" + n_jump_location;
    str_jump_location_down = "scene_wall_left_jumpover_down_0" + n_jump_location;
    level scene::skipto_end( str_jump_location_up, "targetname", self, 0.5 );
    level scene::play( str_jump_location_down, self );
    self.ignoreall = 0;
    self ai::set_behavior_attribute( "move_mode", "rusher" );
    
    if ( isdefined( self.target ) )
    {
        e_goal = getent( self.target, "targetname" );
        self setgoal( e_goal, 1 );
    }
}

// Namespace arena_defend
// Params 0
// Checksum 0x92ea986f, Offset: 0x8cf8
// Size: 0xbc
function discover_weak_points_wave_2()
{
    spawn_manager::enable( "sm_arena_defend_fill_middle" );
    spawn_manager::enable( "sm_arena_defend_fill_middle_wasps" );
    level util::delay( 15, undefined, &flag::set, "arena_defend_second_wave_weak_points_discovered" );
    spawner::waittill_ai_group_amount_killed( "arena_defend_fill_middle", 3 );
    level flag::set( "arena_defend_second_wave_weak_points_discovered" );
    spawn_manager::enable( "sm_wp_03_defenders" );
}

// Namespace arena_defend
// Params 0
// Checksum 0x220d9f3f, Offset: 0x8dc0
// Size: 0x74
function discover_weak_points_wave_3()
{
    level util::delay( 20, undefined, &flag::set, "arena_defend_third_wave_weak_points_discovered" );
    spawner::waittill_ai_group_amount_killed( "arena_defend_checkpoint_breach_enemies", 30 );
    level flag::set( "arena_defend_third_wave_weak_points_discovered" );
}

// Namespace arena_defend
// Params 0
// Checksum 0x517a2c72, Offset: 0x8e40
// Size: 0xb4
function discover_weak_points_wave_final()
{
    level flag::wait_till_all( array( "wp_01_destroyed", "wp_02_destroyed", "wp_03_destroyed", "wp_05_destroyed" ) );
    level thread dialog::remote( "kane_one_more_0", 1 );
    wait 3;
    playsoundatposition( "veh_quadtank_alarm_cinematic", ( 4847, -25831, 566 ) );
    level flag::set( "arena_defend_last_wave_weak_points_discovered" );
}

// Namespace arena_defend
// Params 0
// Checksum 0xe51a6b2a, Offset: 0x8f00
// Size: 0x264
function enemy_wave_checkpoint_wall_breach()
{
    level thread play_checkpoint_wall_breach_left();
    level thread vo_checkpoint_wall_breached();
    level thread ramses_util::spawn_phalanx( "checkpoint_wall_phalanx", "phalanx_column", 4, 1, 10, undefined, 1, "arena_defend_wave_02b_phalanx", "script_noteworthy", 2 );
    spawn_manager::enable( "sm_arena_defend_center_fill_right" );
    level util::waittill_notify_or_timeout( "checkpoint_wall_breach_complete", 20 );
    spawn_manager::kill( "sm_wp_03_defenders_jumpers" );
    spawn_manager::kill( "sm_arena_defend_fill_middle" );
    spawn_manager::kill( "sm_arena_defend_fill_middle_wasps" );
    trigger::use( "arena_defend_tech_2_trig", "targetname" );
    wait 5;
    spawn_manager::enable( "arena_defend_far_left_enemies" );
    spawn_manager::enable( "sm_arena_defend_center_fill_left" );
    spawn_manager::enable( "sm_wp_05_defenders" );
    wait 5;
    friendlies_move_to_position( "wp_05" );
    level util::waittill_notify_or_timeout( "arena_defend_technical_02_vh_reached_end_node", 10 );
    wait 5;
    
    if ( !level flag::get( "billboard1_crashed" ) )
    {
        spawn_manager::enable( "arena_defend_snipers_02" );
        a_dialogue_lines = [];
        a_dialogue_lines[ 0 ] = "esl1_sniper_on_the_roof_0";
        a_dialogue_lines[ 1 ] = "egy2_i_have_an_enemy_snip_0";
        ai_guy = vo_find_closest_redshirt_for_dialog();
        ai_guy thread dialog::say( vo_pick_random_line( a_dialogue_lines ), 2 );
    }
}

// Namespace arena_defend
// Params 0
// Checksum 0xfe882c77, Offset: 0x9170
// Size: 0xe4
function enemies_overrun_checkpoint_area()
{
    spawn_manager::set_global_active_count( 25 );
    level thread function_2c83fc3f();
    spawn_manager::enable( "arena_defend_push_enemies" );
    util::wait_network_frame();
    spawn_manager::enable( "arena_defend_push_wasps" );
    util::wait_network_frame();
    
    if ( !level flag::get( "billboard1_crashed" ) )
    {
        spawn_manager::enable( "arena_defend_snipers_03" );
        util::wait_network_frame();
    }
    
    spawn_manager::enable( "arena_defend_heavy_units" );
}

// Namespace arena_defend
// Params 0
// Checksum 0x36da8aaa, Offset: 0x9260
// Size: 0x4a
function function_2c83fc3f()
{
    level thread overwhelming_phalanx_spawning( "checkpoint_wall_phalanx_right" );
    wait 2;
    level thread overwhelming_phalanx_spawning( "checkpoint_wall_phalanx" );
    wait 2;
}

// Namespace arena_defend
// Params 1
// Checksum 0xc9da4ddd, Offset: 0x92b8
// Size: 0x124
function overwhelming_phalanx_spawning( str_phalanx )
{
    level endon( #"arena_defend_detonator_pickup" );
    v_start = struct::get( str_phalanx + "_start" ).origin;
    v_end = struct::get( str_phalanx + "_end" ).origin;
    var_4720665e = 0;
    
    while ( true )
    {
        var_4720665e++;
        n_robot_count = 2;
        o_phalanx = new robotphalanx();
        [[ o_phalanx ]]->initialize( "phalanx_column", v_start, v_end, n_robot_count, n_robot_count );
        
        do
        {
            wait 0.25;
        }
        while ( isdefined( o_phalanx ) && o_phalanx.scattered_ == 0 );
        
        wait 5;
    }
}

// Namespace arena_defend
// Params 1
// Checksum 0x8e7e1b9b, Offset: 0x93e8
// Size: 0x102
function kill_spawn_manager_group( str_script_noteworthy )
{
    a_spawn_managers = getentarray( str_script_noteworthy, "script_noteworthy" );
    
    foreach ( e_spawn_manager in a_spawn_managers )
    {
        if ( isdefined( e_spawn_manager.name ) )
        {
            str_name = e_spawn_manager.name;
        }
        else
        {
            str_name = e_spawn_manager.targetname;
        }
        
        spawn_manager::kill( str_name );
    }
}

// Namespace arena_defend
// Params 0
// Checksum 0x7235d154, Offset: 0x94f8
// Size: 0x364
function players_destroy_weak_points_in_arena()
{
    level flag::wait_till( "weak_points_objective_active" );
    a_waves = get_weak_point_discovery_data();
    
    foreach ( wave in a_waves )
    {
        foreach ( s_weak_point in wave )
        {
            if ( isdefined( s_weak_point.a_flags_wait_for_discovery ) )
            {
                level flag::wait_till_all( s_weak_point.a_flags_wait_for_discovery );
            }
            
            level flag::set( s_weak_point.str_weak_point_identifier + "_identified" );
            
            if ( isdefined( s_weak_point.a_func_on_discovery ) )
            {
                foreach ( a_func_on_discovery in s_weak_point.a_func_on_discovery )
                {
                    level thread [[ a_func_on_discovery ]]();
                }
            }
            
            if ( isdefined( s_weak_point.a_func_on_destroyed ) )
            {
                foreach ( a_func_on_destroyed in s_weak_point.a_func_on_destroyed )
                {
                    level thread ramses_util::flag_then_func( s_weak_point.str_weak_point_identifier + "_destroyed", a_func_on_destroyed );
                }
            }
        }
    }
    
    streamerrequest( "set", "cp_mi_cairo_ramses2_sinkhole_collapse" );
    wait_till_all_weak_points_destroyed();
    level thread namespace_a6a248fc::function_7b69c801();
    level flag::set( "all_weak_points_destroyed" );
    
    if ( isdefined( level.bzm_ramsesdialogue5_1callback ) )
    {
        level thread [[ level.bzm_ramsesdialogue5_1callback ]]();
    }
    
    level thread vo_weak_points_all_destroyed();
}

// Namespace arena_defend
// Params 0
// Checksum 0xc6481aab, Offset: 0x9868
// Size: 0x15c
function setup_sinkhole_weak_points()
{
    a_fxanims = array( "wp_01", "wp_02", "wp_03", "wp_04", "wp_05" );
    
    foreach ( str_scene_name in a_fxanims )
    {
        level scene::init( str_scene_name );
        util::wait_network_frame();
    }
    
    showmiscmodels( "sinkhole_misc_model" );
    a_t = getentarray( "ad_weak_point_trig", "targetname" );
    array::thread_all( a_t, &weak_point_think );
    init_weak_points_by_player_count();
}

// Namespace arena_defend
// Params 0
// Checksum 0xa0ab0be2, Offset: 0x99d0
// Size: 0xd0
function setup_intro_scenes_for_skipto()
{
    vh_technical = vehicle::simple_spawn_single( "arena_defend_intro_technical" );
    vh_technical flag::init( "warp_to_spline_end_done" );
    
    while ( !vh_technical turret::is_turret_enabled( 1 ) )
    {
        wait 0.25;
    }
    
    vh_technical turret::disable( 1 );
    level waittill( #"arena_defend_intro_player_exits_technical" );
    level scene::play( "cin_ram_05_02_block_vign_mowed" );
    vh_technical turret::enable( 1, 1 );
    return vh_technical;
}

// Namespace arena_defend
// Params 0
// Checksum 0xda0cd71f, Offset: 0x9aa8
// Size: 0x84
function function_bbf0087d()
{
    level thread friendlies_push_into_street_after_intro_enemies_killed();
    level flag::wait_till( "arena_defend_spawn" );
    level thread function_f4554829();
    spawn_manager::enable( "arena_defend_wall_allies" );
    spawn_manager::enable( "arena_defend_wall_top_allies" );
}

// Namespace arena_defend
// Params 0
// Checksum 0x96ef5106, Offset: 0x9b38
// Size: 0x3c
function khalil_talks_to_area_commander()
{
    level scene::play( "cin_ram_05_01_block_vign_rip_khalilorder" );
    level thread vo_weak_point_initial_search();
}

// Namespace arena_defend
// Params 0
// Checksum 0xe89d347c, Offset: 0x9b80
// Size: 0xc4
function friendlies_push_into_street_after_intro_enemies_killed()
{
    level endon( #"arena_defend_color_allies_street_middle" );
    level flag::wait_till( "arena_defend_intro_technical_disabled" );
    spawn_manager::wait_till_ai_remaining( "sm_arena_defend_initial_enemies", 4 );
    a_enemies = spawn_manager::get_ai( "sm_arena_defend_initial_enemies" );
    var_61fd03c7 = getent( "initial_enemies_fallback_goal", "targetname" );
    array::run_all( a_enemies, &setgoal, var_61fd03c7 );
}

// Namespace arena_defend
// Params 0
// Checksum 0xf1d2f18d, Offset: 0x9c50
// Size: 0x244
function init_weak_points_by_player_count()
{
    a_funcs_on_first_wave_start = array( &enemy_wave_right_wall_push, &vo_weak_point_first_found );
    a_funcs_on_first_wave_complete = array( &discover_weak_points_wave_2, &vo_weak_point_first_destroyed, &friendlies_move_to_wp_02_03, &vignette_egyptian_soldiers_killed_by_wasps, &function_44a7ad7b );
    a_funcs_on_checkpoint_breach_start = array( &enemy_wave_checkpoint_wall_breach, &vo_weak_point_second_wave_destroyed, &discover_weak_points_wave_3 );
    a_funcs_on_final_wave_start = array( &friendlies_move_to_final_street_position, &vo_weak_point_last_group, &play_checkpoint_wall_breach_right, &function_ce07d8df );
    register_weak_point_for_wave( 1, "wp_01", undefined, a_funcs_on_first_wave_start, a_funcs_on_first_wave_complete );
    register_weak_point_for_wave( 2, "wp_02", "arena_defend_second_wave_weak_points_discovered", &vo_weak_point_second_found );
    register_weak_point_for_wave( 2, "wp_03", undefined, undefined, a_funcs_on_checkpoint_breach_start );
    register_weak_point_for_wave( 3, "wp_05", "arena_defend_third_wave_weak_points_discovered", &vo_weak_point_third_found, &discover_weak_points_wave_final );
    register_weak_point_for_wave( 4, "wp_04", "arena_defend_last_wave_weak_points_discovered", a_funcs_on_final_wave_start );
}

// Namespace arena_defend
// Params 0
// Checksum 0xa5f5aeac, Offset: 0x9ea0
// Size: 0x32
function get_weak_point_discovery_data()
{
    assert( isdefined( level.a_weak_point_discovery_waves ), "<dev string:x13a>" );
    return level.a_weak_point_discovery_waves;
}

// Namespace arena_defend
// Params 5
// Checksum 0x9c68fac4, Offset: 0x9ee0
// Size: 0x300
function register_weak_point_for_wave( n_wave, str_weak_point_identifier, a_flags_wait_for_discovery, a_func_on_discovery, a_func_on_destroyed )
{
    if ( !isdefined( level.a_weak_point_discovery_waves ) )
    {
        level.a_weak_point_discovery_waves = [];
    }
    
    if ( !isdefined( level.a_weak_point_discovery_waves[ n_wave ] ) )
    {
        level.a_weak_point_discovery_waves[ n_wave ] = [];
    }
    
    if ( !isdefined( a_flags_wait_for_discovery ) )
    {
        a_flags_wait_for_discovery = [];
    }
    else if ( !isarray( a_flags_wait_for_discovery ) )
    {
        a_flags_wait_for_discovery = array( a_flags_wait_for_discovery );
    }
    
    if ( !isdefined( a_func_on_discovery ) )
    {
        a_func_on_discovery = [];
    }
    else if ( !isarray( a_func_on_discovery ) )
    {
        a_func_on_discovery = array( a_func_on_discovery );
    }
    
    if ( !isdefined( a_func_on_destroyed ) )
    {
        a_func_on_destroyed = [];
    }
    else if ( !isarray( a_func_on_destroyed ) )
    {
        a_func_on_destroyed = array( a_func_on_destroyed );
    }
    
    if ( isdefined( a_flags_wait_for_discovery ) )
    {
        foreach ( str_flag in a_flags_wait_for_discovery )
        {
            assert( level flag::exists( str_flag ), "<dev string:x191>" + str_flag + "<dev string:x1c8>" );
        }
    }
    
    s_temp = spawnstruct();
    s_temp.str_weak_point_identifier = str_weak_point_identifier;
    s_temp.a_flags_wait_for_discovery = a_flags_wait_for_discovery;
    s_temp.a_func_on_discovery = a_func_on_discovery;
    s_temp.a_func_on_destroyed = a_func_on_destroyed;
    
    if ( !isdefined( level.a_weak_point_discovery_waves[ n_wave ] ) )
    {
        level.a_weak_point_discovery_waves[ n_wave ] = [];
    }
    else if ( !isarray( level.a_weak_point_discovery_waves[ n_wave ] ) )
    {
        level.a_weak_point_discovery_waves[ n_wave ] = array( level.a_weak_point_discovery_waves[ n_wave ] );
    }
    
    level.a_weak_point_discovery_waves[ n_wave ][ level.a_weak_point_discovery_waves[ n_wave ].size ] = s_temp;
}

// Namespace arena_defend
// Params 0
// Checksum 0x98c2a396, Offset: 0xa1e8
// Size: 0x194
function wait_till_all_weak_points_destroyed()
{
    a_data = get_weak_point_discovery_data();
    a_flags = [];
    
    foreach ( wave in a_data )
    {
        foreach ( s_weak_point in wave )
        {
            if ( !isdefined( a_flags ) )
            {
                a_flags = [];
            }
            else if ( !isarray( a_flags ) )
            {
                a_flags = array( a_flags );
            }
            
            a_flags[ a_flags.size ] = s_weak_point.str_weak_point_identifier + "_destroyed";
        }
    }
    
    level flag::wait_till_all( a_flags );
}

// Namespace arena_defend
// Params 0
// Checksum 0x5a5a3cfb, Offset: 0xa388
// Size: 0x8fc
function weak_point_think()
{
    level flag::init( self.script_string );
    level flag::init( self.script_string + "_identified" );
    level flag::init( self.script_string + "_destroyed" );
    m_objective_marker = getent( self.target, "targetname" );
    assert( isdefined( m_objective_marker ), "<dev string:x1ee>" );
    assert( isdefined( m_objective_marker.target ), "<dev string:x224>" );
    s_weak_point_model = struct::get( m_objective_marker.target, "targetname" );
    assert( isdefined( s_weak_point_model ), "<dev string:x296>" + self.origin + "<dev string:x2ce>" );
    ramses_util::enable_nodes( self.script_string + "_covernode", "script_noteworthy", 1 );
    ramses_util::link_traversals( self.script_string + "_traversal", "script_noteworthy", 1 );
    level waittill( self.script_string + "_identified" );
    s_weak_point_trigger = getent( s_weak_point_model.target, "targetname" );
    assert( isdefined( s_weak_point_trigger ), "<dev string:x2da>" );
    s_weak_point_trigger show();
    s_weak_point_gameobject = util::init_interactive_gameobject( s_weak_point_trigger, &"cp_level_ramses_spike_plant", &"CP_MI_CAIRO_RAMSES_PLANT_SPIKE", &callback_gameobject_weak_point_on_use );
    s_weak_point_gameobject.keepweapon = 1;
    s_weak_point_gameobject.script_string = self.script_string;
    s_weak_point_gameobject.t_damage = self;
    s_weak_point_gameobject setup_badplace_for_spike_plant();
    m_weak_point_model = util::spawn_model( s_weak_point_model.model, s_weak_point_model.origin, s_weak_point_model.angles );
    m_weak_point_model clientfield::set( "arena_defend_weak_point_keyline", 1 );
    m_weak_point_model setforcenocull();
    level.players[ 0 ] playlocalsound( "uin_hud_weakpoints" );
    self wait_for_weak_point_destruction();
    objectives::complete( "cp_level_ramses_spike_detonate" );
    m_weak_point_model clientfield::set( "arena_defend_weak_point_keyline", 0 );
    util::wait_network_frame();
    spawn_manager::kill( "sm_" + self.script_string + "_defenders" );
    level flag::set( self.script_string );
    m_objective_marker ghost();
    level flag::set( self.script_string + "_destroyed" );
    level thread scene::play( self.script_string, "targetname" );
    a_collision = getentarray( "collision_" + self.script_string, "targetname" );
    
    foreach ( mdl_collision in a_collision )
    {
        if ( mdl_collision.targetname != "collision_wp_05" )
        {
            mdl_collision delete();
        }
    }
    
    if ( level flag::get( "wp_02_destroyed" ) && level flag::get( "wp_03_destroyed" ) && !level flag::get( "wp_05_destroyed" ) && ( !level flag::get( "wp_02_destroyed" ) && ( level flag::get( "wp_02_destroyed" ) && !level flag::get( "wp_03_destroyed" ) || level flag::get( "wp_03_destroyed" ) ) || level flag::get( "wp_05_identified" ) ) )
    {
        m_weak_point_model clientfield::set( "arena_defend_weak_point_keyline", 1 );
        util::wait_network_frame();
    }
    
    m_weak_point_model delete();
    ramses_util::enable_nodes( self.script_string + "_traversal_jump", "script_noteworthy", 1 );
    ramses_util::link_traversals( self.script_string + "_traversal", "script_noteworthy", 0 );
    spawn_manager::kill( "sm_" + self.script_string + "_defenders", 1 );
    
    switch ( self.script_string )
    {
        case "wp_01":
            var_70d87be7 = getent( "trig_wp_01_kill_stuck_players", "targetname" );
            
            if ( isdefined( var_70d87be7 ) )
            {
                var_70d87be7 triggerenable( 1 );
            }
            
            break;
        case "wp_02":
            trigger::use( "wp_03_goal_trig" );
            ramses_util::enable_nodes( self.script_string + "_covernode", "script_noteworthy", 0 );
            break;
        case "wp_04":
            t_damage_fire = getent( "trig_wp_04_damage", "targetname" );
            t_damage_fire triggerenable( 1 );
            spawn_manager::enable( "sm_wp_04_robot_rushers" );
            ramses_util::enable_nodes( "wp_04_raps_walk", "targetname", 0 );
            break;
        default:
            break;
    }
    
    objective_clearentity( s_weak_point_gameobject.objectiveid );
    s_weak_point_gameobject gameobjects::destroy_object( 1 );
    self delete();
    savegame::checkpoint_save();
}

// Namespace arena_defend
// Params 0
// Checksum 0xaaa4bc25, Offset: 0xac90
// Size: 0x10
function wait_for_weak_point_destruction()
{
    self waittill( #"planted_spike_detonation" );
}

// Namespace arena_defend
// Params 1
// Checksum 0x4de4810, Offset: 0xaca8
// Size: 0x16c
function callback_gameobject_weak_point_on_use( e_player )
{
    if ( e_player player_has_spike_launcher_ammo() )
    {
        self gameobjects::disable_object( 1 );
        e_player player_plants_spike_in_ground( self );
        self thread function_64f3ca1d( e_player );
    }
    else
    {
        e_player notify( #"spike_ammo_missing" );
        e_player thread util::show_hint_text( &"CP_MI_CAIRO_RAMSES_SPIKE_AMMO_MISSING", 1, "spike_ammo_missing", 3 );
    }
    
    if ( self.script_string === "wp_01" )
    {
        foreach ( player in level.activeplayers )
        {
            player notify( #"clear_spike_hints" );
        }
        
        e_player thread ramses_util::function_508a129e( self.script_string + "_destroyed", 9999, 0 );
    }
}

// Namespace arena_defend
// Params 1
// Checksum 0x3dfd6b68, Offset: 0xae20
// Size: 0x64
function function_64f3ca1d( e_player )
{
    self endon( #"death" );
    self.trigger endon( #"death" );
    self.t_damage endon( #"death" );
    e_player waittill( #"death" );
    self gameobjects::allow_use( "any" );
}

// Namespace arena_defend
// Params 0
// Checksum 0x7b268d55, Offset: 0xae90
// Size: 0x6a
function player_has_spike_launcher_ammo()
{
    w_spike_launcher = getweapon( "spike_launcher" );
    n_ammo_clip = self getweaponammoclip( w_spike_launcher );
    b_has_ammo = n_ammo_clip > 0;
    return b_has_ammo;
}

// Namespace arena_defend
// Params 1
// Checksum 0xc3374198, Offset: 0xaf08
// Size: 0x234
function player_plants_spike_in_ground( s_gameobject )
{
    self endon( #"death" );
    
    if ( !isdefined( self.is_planting_spike ) )
    {
        self.is_planting_spike = 0;
    }
    
    if ( !self.is_planting_spike )
    {
        self.is_planting_spike = 1;
        self disableweaponcycling();
        self enableinvulnerability();
        self move_player_if_in_spike_plant_badplace( s_gameobject );
        
        if ( !self ramses_util::is_using_weapon( "spike_launcher" ) )
        {
            self allowprone( 0 );
            util::wait_network_frame();
            self switchtoweapon( getweapon( "spike_launcher" ) );
            self util::waittill_notify_or_timeout( "weapon_change", 1 );
        }
        
        self thread reduce_accuracy_against_solo_player_for_spike_plant();
        self thread scene::play( "cin_ram_05_02_spike_launcher_plant", self );
        self allowprone( 1 );
        self disableinvulnerability();
        self enableweaponcycling();
        self util::waittill_notify_or_timeout( "fire_spike", 5 );
        level notify( #"player_plants_spike" );
        objectives::complete( "cp_level_ramses_spike_plant" );
        objectives::set( "cp_level_ramses_spike_detonate" );
        self thread fire_spike_into_ground();
        self thread watch_for_spike_detonation( s_gameobject.t_damage );
    }
}

// Namespace arena_defend
// Params 1
// Checksum 0xf085a091, Offset: 0xb148
// Size: 0xac
function move_player_if_in_spike_plant_badplace( s_gameobject )
{
    t_badplace = s_gameobject.t_plant_badplace;
    s_safe_location = s_gameobject.s_plant_badplace_move;
    
    if ( isdefined( t_badplace ) && isdefined( s_safe_location ) )
    {
        if ( self istouching( t_badplace ) )
        {
            self setorigin( s_safe_location.origin );
            util::wait_network_frame();
        }
    }
}

// Namespace arena_defend
// Params 0
// Checksum 0x7b199270, Offset: 0xb200
// Size: 0xc4
function setup_badplace_for_spike_plant()
{
    str_identifier = self.script_string;
    self.t_plant_badplace = getent( str_identifier + "_bad_place_trigger", "targetname" );
    
    if ( isdefined( self.t_plant_badplace ) )
    {
        self.s_plant_badplace_move = struct::get( self.t_plant_badplace.target, "targetname" );
        assert( isdefined( self.s_plant_badplace_move ), "<dev string:x31e>" + str_identifier + "<dev string:x33f>" );
    }
}

// Namespace arena_defend
// Params 1
// Checksum 0x8b4acdb6, Offset: 0xb2d0
// Size: 0x22
function scene_callback_spike_plant_done( a_ents )
{
    a_ents[ "player 1" ].is_planting_spike = undefined;
}

// Namespace arena_defend
// Params 0
// Checksum 0xb87823ed, Offset: 0xb300
// Size: 0x114
function fire_spike_into_ground()
{
    self endon( #"death" );
    waittillframeend();
    w_spike_launcher_plant = getweapon( "spike_launcher_plant" );
    v_spawn = self gettagorigin( "tag_flash" );
    self clientfield::increment_to_player( "player_spike_plant_postfx" );
    
    if ( isdefined( v_spawn ) )
    {
        e_spike = magicbullet( w_spike_launcher_plant, v_spawn + ( 0, 0, 40 ), v_spawn, self );
    }
    else
    {
        e_spike = magicbullet( w_spike_launcher_plant, self.origin + ( 0, 0, 40 ), self.origin, self );
    }
    
    self spike_count_decrement();
}

// Namespace arena_defend
// Params 1
// Checksum 0xb1806275, Offset: 0xb420
// Size: 0x134
function watch_for_detonation_press( e_spike )
{
    level endon( #"all_weak_points_destroyed" );
    e_spike endon( #"death" );
    mdl_spike = util::spawn_model( e_spike.model, e_spike.origin, e_spike.angles );
    mdl_spike clientfield::set( "arena_defend_weak_point_keyline", 1 );
    mdl_spike thread spike_keyline_disable_on_timeout( e_spike );
    e_spike ghost();
    self thread function_edfdd3b1( e_spike );
    self util::waittill_any( "detonate", "last_stand_detonate" );
    mdl_spike clientfield::set( "arena_defend_weak_point_keyline", 0 );
    e_spike detonate();
}

// Namespace arena_defend
// Params 1
// Checksum 0x3fad9e87, Offset: 0xb560
// Size: 0xa4
function watch_for_spike_detonation( trigger )
{
    self endon( #"death" );
    trigger endon( #"death" );
    self waittill( #"grenade_fire", e_spike );
    self thread watch_for_detonation_press( e_spike );
    v_spike_position = e_spike.origin;
    e_spike waittill( #"death" );
    trigger notify( #"planted_spike_detonation" );
    level cleanup_nearby_explosives( v_spike_position );
}

// Namespace arena_defend
// Params 1
// Checksum 0x677f8e0e, Offset: 0xb610
// Size: 0x154
function function_edfdd3b1( e_spike )
{
    level endon( #"all_weak_points_destroyed" );
    self endon( #"detonate" );
    self endon( #"last_stand_detonate" );
    self endon( #"death" );
    e_spike endon( #"death" );
    wait 5;
    self flag::clear( "spike_launcher_tutorial_complete" );
    w_current = self getcurrentweapon();
    w_spike_launcher = getweapon( "spike_launcher" );
    
    while ( !self flag::get( "spike_launcher_tutorial_complete" ) )
    {
        if ( w_current == w_spike_launcher )
        {
            self thread ramses_util::wait_till_detonate_button_pressed();
            self thread ramses_util::function_780e57a1();
            self util::waittill_any( "detonate", "last_stand_detonate" );
            continue;
        }
        
        self waittill( #"weapon_change_complete", w_current );
    }
}

// Namespace arena_defend
// Params 1
// Checksum 0xd6d6724f, Offset: 0xb770
// Size: 0x20a
function cleanup_nearby_explosives( arg1 )
{
    a_grenades = getentarray( "grenade", "classname" );
    
    if ( isvec( arg1 ) )
    {
        foreach ( i, e_grenade in a_grenades )
        {
            if ( isdefined( e_grenade ) && distance2dsquared( arg1, e_grenade.origin ) <= 40000 )
            {
                e_grenade detonate();
            }
            
            if ( i % 2 == 0 )
            {
                util::wait_network_frame();
            }
        }
        
        return;
    }
    
    if ( isentity( arg1 ) )
    {
        foreach ( i, e_grenade in a_grenades )
        {
            if ( isdefined( e_grenade ) && e_grenade istouching( arg1 ) )
            {
                e_grenade detonate();
            }
            
            if ( i % 2 == 0 )
            {
                util::wait_network_frame();
            }
        }
    }
}

// Namespace arena_defend
// Params 1
// Checksum 0x38555707, Offset: 0xb988
// Size: 0x6c
function spike_keyline_disable_on_timeout( e_spike )
{
    self endon( #"death" );
    e_spike waittill( #"death" );
    self clientfield::set( "arena_defend_weak_point_keyline", 0 );
    util::wait_network_frame();
    self delete();
}

// Namespace arena_defend
// Params 0
// Checksum 0xcf958b91, Offset: 0xba00
// Size: 0x94
function spike_count_decrement()
{
    w_spike_launcher = getweapon( "spike_launcher" );
    n_ammo_clip = self getweaponammoclip( w_spike_launcher );
    n_ammo_clip = math::clamp( n_ammo_clip - 1, 0, n_ammo_clip );
    self setweaponammoclip( w_spike_launcher, n_ammo_clip );
}

// Namespace arena_defend
// Params 0
// Checksum 0x823aa70c, Offset: 0xbaa0
// Size: 0x74
function reduce_accuracy_against_solo_player_for_spike_plant()
{
    self endon( #"death" );
    
    if ( level.players.size == 1 )
    {
        self.attackeraccuracy = 0.1;
        
        while ( isdefined( self.is_planting_spike ) && self.is_planting_spike )
        {
            wait 0.1;
        }
        
        wait 3;
        self.attackeraccuracy = 1;
    }
}

// Namespace arena_defend
// Params 1
// Checksum 0x7ae684a7, Offset: 0xbb20
// Size: 0x224
function friendlies_fall_back_behind_mobile_wall( b_wait_for_fallback )
{
    if ( !isdefined( b_wait_for_fallback ) )
    {
        b_wait_for_fallback = 1;
    }
    
    kill_spawn_manager_group( "arena_defend_spawn_manager_friendly" );
    friendlies_clear_goals_and_colors();
    ramses_util::enable_nodes( "arena_defend_mobile_wall_top_nodes", "script_noteworthy", 0 );
    t_fallback_behind_mobile_wall = getent( "sinkhole_friendly_fallback_volume", "targetname" );
    
    foreach ( ai_friendly in getactorteamarray( "allies" ) )
    {
        ai_friendly thread function_b16456e1( t_fallback_behind_mobile_wall );
        wait 0.05;
    }
    
    level.ai_hendricks.goalradius = 32;
    nd_fallback_hendricks = getnode( "hendricks_mobile_wall_start_node", "targetname" );
    level.ai_hendricks thread ai::force_goal( nd_fallback_hendricks, 32, 1, undefined, 1 );
    level.ai_khalil.goalradius = 32;
    nd_fallback_khalil = getnode( "arena_defend_demostreet_intro_khalil", "targetname" );
    level.ai_khalil thread ai::force_goal( nd_fallback_khalil, 32, 1, undefined, 1 );
}

// Namespace arena_defend
// Params 1
// Checksum 0x47298366, Offset: 0xbd50
// Size: 0x9c
function function_b16456e1( t_goal )
{
    self endon( #"death" );
    self setgoal( t_goal, 1 );
    
    if ( !self util::is_hero() )
    {
        self ai::set_behavior_attribute( "sprint", 1 );
        self waittill( #"goal" );
        self ai::set_behavior_attribute( "coverIdleOnly", 1 );
    }
}

// Namespace arena_defend
// Params 0
// Checksum 0x3f1dfe88, Offset: 0xbdf8
// Size: 0x10a
function friendlies_clear_goals_and_colors()
{
    if ( isdefined( level.ai_hendricks ) && isdefined( level.ai_hendricks.goalradius_old ) )
    {
        level.ai_hendricks.goalradius = level.ai_hendricks.goalradius_old;
    }
    
    a_ai_allies = getaispeciesarray( "allies", "human" );
    
    foreach ( ai in a_ai_allies )
    {
        ai colors::disable();
        ai cleargoalvolume();
    }
}

// Namespace arena_defend
// Params 0
// Checksum 0x61545083, Offset: 0xbf10
// Size: 0xac
function scene_friendly_detonation_guy_killed()
{
    function_4fdddf97();
    
    if ( isdefined( level.bzm_ramsesdialogue6callback ) )
    {
        level thread [[ level.bzm_ramsesdialogue6callback ]]();
    }
    
    level thread scene::play( "cin_ram_05_demostreet_vign_intro_detonation_guy" );
    level thread scene::play( "cin_ram_05_demostreet_vign_intro_khalil_only" );
    level thread scene::play( "cin_ram_05_demostreet_vign_intro_hendricks_only" );
    level flag::wait_till_timeout( 5, "arena_defend_detonator_dropped" );
}

// Namespace arena_defend
// Params 0
// Checksum 0x6f398430, Offset: 0xbfc8
// Size: 0x114
function function_2e8bcd54()
{
    trigger::wait_till( "arena_defend_player_fallback_trigger" );
    level.ai_hendricks ai::set_behavior_attribute( "sprint", 1 );
    level.ai_khalil ai::set_behavior_attribute( "sprint", 1 );
    level thread scene::init( "cin_ram_05_demostreet_vign_intro_khalil_only" );
    util::wait_network_frame();
    level thread scene::init( "cin_ram_05_demostreet_vign_intro_hendricks_only" );
    array::wait_till( array( level.ai_hendricks, level.ai_khalil ), "vign_intro_runback_done", 15 );
    level thread function_d72bac37();
}

// Namespace arena_defend
// Params 0
// Checksum 0x6b4a5741, Offset: 0xc0e8
// Size: 0x8c
function function_d72bac37()
{
    trigger::wait_till( "arena_defend_wall_gather_trig" );
    callback::on_spawned( &function_f554e28a );
    mobile_wall_doors_close();
    array::thread_all( getaiteamarray( "axis", "allies" ), &function_4c119f69 );
}

// Namespace arena_defend
// Params 0
// Checksum 0xe9917bea, Offset: 0xc180
// Size: 0x9c
function function_f554e28a()
{
    if ( level.skipto_point == "sinkhole_collapse" )
    {
        s_safe_location = struct::get( "s_mobile_wall_closed_hot_join_" + self getentitynumber(), "targetname" );
        self setorigin( s_safe_location.origin );
        self setplayerangles( s_safe_location.angles );
    }
}

// Namespace arena_defend
// Params 0
// Checksum 0xc5a2e23c, Offset: 0xc228
// Size: 0xfc
function function_4fdddf97()
{
    var_d156a4cd = getent( "arena_defend_wall_gather_trig", "targetname" );
    
    while ( true )
    {
        var_859ac0d1 = 0;
        
        foreach ( player in level.activeplayers )
        {
            if ( player istouching( var_d156a4cd ) )
            {
                var_859ac0d1 = 1;
                break;
            }
        }
        
        if ( var_859ac0d1 )
        {
            break;
        }
        
        wait 0.05;
    }
}

// Namespace arena_defend
// Params 0
// Checksum 0xd66f02a9, Offset: 0xc330
// Size: 0x4c
function function_4c119f69()
{
    if ( isalive( self ) && isactor( self ) )
    {
        self clearenemy();
    }
}

// Namespace arena_defend
// Params 0
// Checksum 0x3d684843, Offset: 0xc388
// Size: 0x3fa
function players_detonate_charges_from_mobile_wall()
{
    level flag::wait_till( "arena_defend_detonator_pickup" );
    
    if ( level scene::is_active( "cin_ram_05_demostreet_vign_intro_hendricks_only" ) )
    {
        level scene::stop( "cin_ram_05_demostreet_vign_intro_hendricks_only" );
    }
    
    if ( level scene::is_active( "cin_ram_05_demostreet_vign_intro_khalil_only" ) )
    {
        level scene::stop( "cin_ram_05_demostreet_vign_intro_khalil_only" );
    }
    
    foreach ( player in level.players )
    {
        player.ignoreme = 1;
        player enableinvulnerability();
        player notify( #"hash_5a334c0f" );
    }
    
    kill_spawn_manager_group( "arena_defend_spawn_manager" );
    kill_spawn_manager_group( "arena_defend_spawn_manager_friendly" );
    battlechatter::function_d9f49fba( 0 );
    
    foreach ( player in level.players )
    {
        if ( isdefined( player.tmode_state ) && player.tmode_state )
        {
            player.var_1695a536 = 1;
        }
        else
        {
            player.var_1695a536 = 0;
        }
        
        player oed::tmode_activate_on_player( 0 );
    }
    
    callback::remove_on_spawned( &function_f554e28a );
    scene::add_player_linked_scene( "p7_fxanim_cp_ramses_street_collapse_big_hole_bundle" );
    ramses_util::co_op_teleport_on_igc_end( "cin_ram_05_demostreet_3rd_sh140", "alley" );
    level scene::play( "cin_ram_05_demostreet_3rd_sh010", level.var_8e659b82 );
    kill_all_ai_in_street();
    level flag::wait_till( "arena_defend_sinkhole_collapse_done" );
    
    foreach ( player in level.players )
    {
        player.ignoreme = 0;
        player disableinvulnerability();
        player enableweapons();
        
        if ( isdefined( player.var_1695a536 ) && player.var_1695a536 )
        {
            player oed::enable_tac_mode( 1 );
        }
    }
}

// Namespace arena_defend
// Params 0
// Checksum 0xbba7b11d, Offset: 0xc790
// Size: 0xfa
function delete_friendly_ai_for_final_scene()
{
    a_friendly = getactorteamarray( "allies" );
    
    foreach ( ai in a_friendly )
    {
        if ( !isactor( ai ) || !isinarray( level.heroes, ai ) && !ai isinscriptedstate() )
        {
            ai delete();
        }
    }
}

// Namespace arena_defend
// Params 0
// Checksum 0xf2f240dc, Offset: 0xc898
// Size: 0x106
function destroy_all_vehicles_in_street()
{
    a_vehicles = getentarray( "arena_defend_technical", "script_noteworthy" );
    n_living_vehicles = 0;
    
    foreach ( vehicle in a_vehicles )
    {
        if ( isalive( vehicle ) )
        {
            vehicle dodamage( vehicle.health, vehicle.origin );
            n_living_vehicles++;
        }
    }
    
    if ( n_living_vehicles > 0 )
    {
        waittillframeend();
    }
}

// Namespace arena_defend
// Params 0
// Checksum 0xd1a79580, Offset: 0xc9a8
// Size: 0x24
function kill_all_ai_in_street()
{
    level flag::set( "sinkhole_explosion_started" );
}

// Namespace arena_defend
// Params 1
// Checksum 0x23759800, Offset: 0xc9d8
// Size: 0xf4
function outro( b_starting )
{
    if ( b_starting )
    {
        add_spawn_functions();
        level flag::set( "sinkhole_charges_detonated" );
        trigger::use( "arena_defend_colors_allies_behind_mobile_wall" );
        spawn_manager::enable( "arena_defend_wall_allies" );
        spawn_manager::enable( "arena_defend_wall_allies2" );
        spawn_manager::enable( "arena_defend_wall_top_allies" );
        spawn_manager::enable( "arena_defend_push_enemies" );
        spawn_manager::enable( "arena_defend_heavy_units" );
        level flag::wait_till( "all_players_spawned" );
    }
}

// Namespace arena_defend
// Params 0
// Checksum 0x5f7166f2, Offset: 0xcad8
// Size: 0x24
function remove_out_of_bounds_trigger_in_alley_building()
{
    ramses_util::delete_ent_array( "arena_defend_out_of_bounds_trigger", "targetname" );
}

// Namespace arena_defend
// Params 0
// Checksum 0x4542b5a7, Offset: 0xcb08
// Size: 0x874
function function_c50ca91()
{
    scene::add_scene_func( "p7_fxanim_cp_ramses_street_collapse_small_hole_02_bundle", &scene_callback_fxanim_wp_01_play, "play" );
    scene::add_scene_func( "p7_fxanim_cp_ramses_street_collapse_small_hole_02_bundle", &scene_callback_fxanim_wp_01_done, "done" );
    scene::add_scene_func( "p7_fxanim_cp_ramses_street_collapse_small_hole_01_bundle", &scene_callback_fxanim_wp_03_play, "play" );
    scene::add_scene_func( "p7_fxanim_cp_ramses_street_collapse_small_hole_03_bundle", &scene_callback_fxanim_wp_04_play, "play" );
    scene::add_scene_func( "p7_fxanim_cp_ramses_street_collapse_small_hole_04_bundle", &scene_callback_fxanim_wp_05_play, "play" );
    scene::add_scene_func( "p7_fxanim_cp_ramses_street_collapse_small_hole_04_bundle", &function_3b5bd8c4, "init" );
    scene::add_scene_func( "p7_fxanim_cp_ramses_wall_drop_bundle", &scene_callback_fxanim_mobile_wall_drop_init, "init" );
    scene::add_scene_func( "p7_fxanim_cp_ramses_wall_drop_bundle", &scene_callback_fxanim_mobile_wall_drop_play, "play" );
    scene::add_scene_func( "p7_fxanim_cp_ramses_wall_drop_bundle", &scene_callback_fxanim_mobile_wall_drop_done, "done" );
    scene::add_scene_func( "p7_fxanim_cp_ramses_checkpoint_wall_01_bundle", &scene_callback_checkpoint_left_breach_init, "init" );
    scene::add_scene_func( "p7_fxanim_cp_ramses_checkpoint_wall_01_bundle", &scene_callback_checkpoint_left_breach_play, "play" );
    scene::add_scene_func( "p7_fxanim_cp_ramses_checkpoint_wall_01_bundle", &scene_callback_checkpoint_left_breach_done, "done" );
    scene::add_scene_func( "p7_fxanim_cp_ramses_checkpoint_wall_02_bundle", &scene_callback_checkpoint_right_breach_play, "play" );
    scene::add_scene_func( "p7_fxanim_cp_ramses_wall_drop_doors_up_bundle", &scene_callback_mobile_wall_doors_up, "play" );
    scene::add_scene_func( "p7_fxanim_cp_ramses_wall_drop_doors_down_bundle", &scene_callback_mobile_wall_doors_down, "play" );
    scene::add_scene_func( "p7_fxanim_cp_ramses_street_collapse_big_hole_bundle", &function_be12945c, "init" );
    scene::add_scene_func( "p7_fxanim_cp_ramses_street_collapse_big_hole_bundle", &scene_callback_sinkhole_handle_collision, "play" );
    scene::add_scene_func( "p7_fxanim_cp_ramses_street_collapse_big_hole_bundle", &scene_callback_sinkhole_play_all_bundles, "play" );
    scene::add_scene_func( "p7_fxanim_cp_ramses_street_collapse_big_hole_bundle", &scene_callback_fxanim_sinkhole_done, "done" );
    scene::add_scene_func( "p7_fxanim_cp_ramses_arena_billboard_bundle", &scene_callback_billboard_play, "play" );
    scene::add_scene_func( "p7_fxanim_cp_ramses_arena_billboard_02_bundle", &function_1a46d844, "play" );
    scene::add_scene_func( "cin_ram_05_01_block_1st_rip", &scene_callback_intro_done, "done" );
    scene::add_scene_func( "cin_ram_05_01_block_1st_rip", &scene_callback_intro_technical, "done" );
    scene::add_scene_func( "cin_ram_05_01_block_1st_rip_skipto", &scene_callback_intro_technical, "done" );
    scene::add_scene_func( "cin_ram_05_02_block_vign_mowed", &scene_callback_intro_technical_murder, "play" );
    scene::add_scene_func( "cin_ram_05_01_defend_vign_leapattack", &scene_callback_hendricks_leap_init, "init" );
    scene::add_scene_func( "cin_ram_05_01_defend_vign_leapattack", &scene_callback_hendricks_leap_done, "done" );
    scene::add_scene_func( "cin_ram_05_01_defend_vign_rescueinjured_l_group", &scene_callback_intro_guys, "play" );
    scene::add_scene_func( "cin_ram_05_01_defend_vign_rescueinjured_r_group", &scene_callback_intro_guys, "play" );
    scene::add_scene_func( "cin_ram_05_01_defend_vign_rescueinjured_r_group", &scene_callback_intro_guys_r_done, "done" );
    scene::add_scene_func( "cin_ram_05_01_defend_vign_rescueinjured_c_group", &scene_callback_intro_guys, "play" );
    scene::add_scene_func( "cin_gen_melee_hendricksmoment_closecombat_robot", &scene_callback_hendricks_vs_robot_init, "init" );
    scene::add_scene_func( "cin_gen_melee_hendricksmoment_closecombat_robot", &scene_callback_hendricks_vs_robot_play, "play" );
    scene::add_scene_func( "cin_ram_05_02_spike_launcher_plant", &scene_callback_spike_plant_done, "done" );
    scene::add_scene_func( "cin_ram_05_demostreet_vign_intro_detonation_guy", &scene_callback_demostreet_intro_init, "init" );
    scene::add_scene_func( "cin_ram_05_demostreet_vign_intro_detonation_guy", &scene_callback_demostreet_intro_play, "play" );
    scene::add_scene_func( "cin_ram_05_demostreet_3rd_sh010", &scene_callback_demostreet_detonation_setup, "play" );
    scene::add_scene_func( "cin_ram_05_demostreet_3rd_sh020", &scene_callback_demostreet_light_blocker, "play" );
    scene::add_scene_func( "cin_ram_05_demostreet_3rd_sh020", &function_f2434205, "play" );
    scene::add_scene_func( "cin_ram_05_demostreet_3rd_sh040", &scene_callback_demostreet_robot_hide, "play" );
    scene::add_scene_func( "cin_ram_05_demostreet_3rd_sh080", &scene_callback_demostreet_detonation_play, "play" );
    scene::add_scene_func( "cin_ram_05_demostreet_3rd_sh080", &scene_callback_demostreet_detonation_done, "done" );
    scene::add_scene_func( "cin_ram_05_demostreet_3rd_sh130", &function_e4fcbd75, "play" );
    scene::add_scene_func( "cin_ram_05_demostreet_3rd_sh140", &scene_callback_demostreet_done, "done" );
    scene::add_scene_func( "cin_ram_05_demostreet_3rd_sh140", &function_2ec70f8b, "play" );
}

// Namespace arena_defend
// Params 0
// Checksum 0x4c9e9b72, Offset: 0xd388
// Size: 0x144
function init_scenes()
{
    a_scriptbundles = struct::get_array( "arena_defend_friendly_fallback_intro", "targetname" );
    
    foreach ( struct in a_scriptbundles )
    {
        scene::add_scene_func( struct.scriptbundlename, &function_32c9babe, "init" );
        struct scene::init();
        util::wait_network_frame();
    }
    
    scene::add_scene_func( "cin_ram_05_01_defend_vign_rescueinjured_r_group", &function_7d420577, "init" );
    scene::init( "cin_ram_05_01_defend_vign_rescueinjured_r_group" );
}

// Namespace arena_defend
// Params 1
// Checksum 0xd577daa2, Offset: 0xd4d8
// Size: 0x74
function function_7d420577( a_ents )
{
    t_lookat = getent( self.target, "targetname" );
    t_lookat waittill( #"trigger" );
    self scene::play();
    t_lookat delete();
}

// Namespace arena_defend
// Params 1
// Checksum 0x684de7bc, Offset: 0xd558
// Size: 0x1b0
function function_32c9babe( a_ents )
{
    level endon( #"sinkhole_charges_detonated" );
    t_lookat = getent( self.target, "targetname" );
    level flag::wait_till( "intro_igc_done" );
    
    if ( !level flag::exists( self.scriptbundlename ) )
    {
        level flag::init( self.scriptbundlename );
    }
    
    self thread function_2f4e01f7( t_lookat );
    
    while ( true )
    {
        foreach ( player in level.activeplayers )
        {
            if ( isdefined( player ) )
            {
                if ( level flag::get( self.scriptbundlename ) || player util::is_player_looking_at( t_lookat.origin ) )
                {
                    self scene::play();
                    level notify( self.scriptbundlename );
                    return;
                }
            }
        }
        
        wait 0.1;
    }
}

// Namespace arena_defend
// Params 1
// Checksum 0xe30741f4, Offset: 0xd710
// Size: 0x44
function function_2f4e01f7( t_lookat )
{
    level endon( self.scriptbundlename );
    t_lookat waittill( #"trigger" );
    level flag::set( self.scriptbundlename );
}

// Namespace arena_defend
// Params 1
// Checksum 0x8d95aa38, Offset: 0xd760
// Size: 0x24
function scene_callback_mobile_wall_doors_up( a_ents )
{
    mobile_wall_door_collision_open( 1 );
}

// Namespace arena_defend
// Params 1
// Checksum 0xd7bf5b9d, Offset: 0xd790
// Size: 0x24
function scene_callback_mobile_wall_doors_down( a_ents )
{
    mobile_wall_door_collision_open( 0 );
}

// Namespace arena_defend
// Params 1
// Checksum 0xb22d8940, Offset: 0xd7c0
// Size: 0x21c
function mobile_wall_door_collision_open( b_open )
{
    level flag::wait_till( "arena_defend_mobile_wall_deployed" );
    m_collision = getent( "mobile_wall_doors_clip", "targetname" );
    b_should_open = !level flag::get( "arena_defend_mobile_wall_doors_open" ) && b_open;
    b_should_close = level flag::get( "arena_defend_mobile_wall_doors_open" ) && !b_open;
    
    if ( b_should_open )
    {
        m_collision movez( 90, 0.1 );
        m_collision waittill( #"movedone" );
        m_collision notsolid();
        m_collision connectpaths();
        ramses_util::enable_nodes( "mobile_wall_door_traversals", "targetname", 1 );
        level flag::set( "arena_defend_mobile_wall_doors_open" );
        return;
    }
    
    if ( b_should_close )
    {
        m_collision movez( 90 * -1, 0.1 );
        m_collision waittill( #"movedone" );
        m_collision solid();
        ramses_util::enable_nodes( "mobile_wall_door_traversals", "targetname", 0 );
        level flag::clear( "arena_defend_mobile_wall_doors_open" );
    }
}

// Namespace arena_defend
// Params 1
// Checksum 0xc367cab9, Offset: 0xd9e8
// Size: 0x11c
function scene_callback_fxanim_wp_01_play( a_ents )
{
    vh_tech_1 = getent( "arena_defend_technical_01_vh", "targetname" );
    
    if ( isdefined( vh_tech_1 ) )
    {
        vh_tech_1 notify( #"kill_passengers" );
        waittillframeend();
        vh_tech_1 delete();
    }
    
    ramses_util::enable_nodes( "arena_defend_technical_01_vh_covernode", "targetname", 0 );
    level waittill( #"hash_fa53fbdf" );
    vh_technical = a_ents[ "wp_01_technical" ];
    vh_technical disconnectpaths( 0, 0 );
    var_70d87be7 = getent( "trig_wp_01_kill_stuck_players", "targetname" );
    
    if ( isdefined( var_70d87be7 ) )
    {
        var_70d87be7 delete();
    }
}

// Namespace arena_defend
// Params 1
// Checksum 0x1822a653, Offset: 0xdb10
// Size: 0x94
function scene_callback_fxanim_wp_01_done( a_ents )
{
    vh_technical = a_ents[ "wp_01_technical" ];
    vh_technical disconnectpaths( 0, 0 );
    var_70d87be7 = getent( "trig_wp_01_kill_stuck_players", "targetname" );
    
    if ( isdefined( var_70d87be7 ) )
    {
        var_70d87be7 delete();
    }
}

// Namespace arena_defend
// Params 1
// Checksum 0x407323af, Offset: 0xdbb0
// Size: 0x74
function scene_callback_fxanim_wp_03_play( a_ents )
{
    getent( "wp_crouch_cover", "targetname" ) movez( 200, 0.05 );
    ramses_util::enable_nodes( "wp_03_dynamic_covernode", "script_noteworthy", 1 );
}

// Namespace arena_defend
// Params 1
// Checksum 0xf0ddb5fc, Offset: 0xdc30
// Size: 0xc
function scene_callback_fxanim_wp_04_play( a_ents )
{
    
}

// Namespace arena_defend
// Params 1
// Checksum 0x37376c23, Offset: 0xdc48
// Size: 0x74
function function_3b5bd8c4( a_ents )
{
    var_d578296 = a_ents[ "street_collapse_trailer_cargo" ];
    e_light = getent( "lgt_trailer", "targetname" );
    e_light linkto( var_d578296, "trailer_cargo_jnt" );
}

// Namespace arena_defend
// Params 1
// Checksum 0x3f816dd3, Offset: 0xdcc8
// Size: 0x124
function scene_callback_fxanim_wp_05_play( a_ents )
{
    t_clip = getent( "arena_defend_trailer_door_clip", "targetname" );
    s_hinge = struct::get( "arena_defend_trailer_door_hinge", "targetname" );
    e_hinge = util::spawn_model( "tag_origin", s_hinge.origin, s_hinge.angles );
    t_clip linkto( e_hinge );
    e_hinge rotateyaw( 180, 1 );
    e_hinge waittill( #"rotatedone" );
    e_hinge delete();
    t_clip disconnectpaths();
}

// Namespace arena_defend
// Params 0
// Checksum 0x18d20ff, Offset: 0xddf8
// Size: 0x14c
function function_e45af9f2()
{
    trigger = getent( "arena_defend_billboard_trigger", "targetname" );
    mdl_clip = getent( "arena_defend_billboard_fxanim_clip", "targetname" );
    mdl_clip notsolid();
    mdl_clip connectpaths();
    ramses_util::enable_nodes( "arena_defend_center_building_sniper_nodes_billboard_collapse", "script_noteworthy", 1 );
    w_spike_charge = getweapon( "spike_charge" );
    
    do
    {
        trigger waittill( #"damage", _, _, _, _, _, _, _, _, w_attacker );
        b_should_play_fxanim = isdefined( w_attacker ) && w_attacker == w_spike_charge;
    }
    while ( !b_should_play_fxanim );
    
    level scene::play( "p7_fxanim_cp_ramses_arena_billboard_bundle" );
}

// Namespace arena_defend
// Params 1
// Checksum 0x5da4a04c, Offset: 0xdf50
// Size: 0x1dc
function scene_callback_billboard_play( a_ents )
{
    ramses_util::enable_nodes( "arena_defend_center_building_sniper_nodes_billboard_collapse", "script_noteworthy", 0 );
    spawn_manager::kill( "sm_arena_defend_snipers_center_building" );
    level waittill( #"billboard_crash_notetrack" );
    level flag::set( "billboard1_crashed" );
    t_kill_billboard_ai = getent( "arena_defend_billboard_trigger", "targetname" );
    var_fee634f2 = a_ents[ "arena_billboard" ];
    a_ai = getaiteamarray( "axis" );
    
    if ( isdefined( a_ai ) && isdefined( var_fee634f2 ) )
    {
        for ( i = 0; i < a_ai.size ; i++ )
        {
            if ( a_ai[ i ] istouching( t_kill_billboard_ai ) && isalive( a_ai[ i ] ) )
            {
                a_ai[ i ] kill( var_fee634f2.origin, undefined, var_fee634f2 );
            }
        }
    }
    
    mdl_clip = getent( "arena_defend_billboard_fxanim_clip", "targetname" );
    mdl_clip solid();
    mdl_clip disconnectpaths();
}

// Namespace arena_defend
// Params 0
// Checksum 0x26722771, Offset: 0xe138
// Size: 0xcc
function function_f9842c89()
{
    trigger = getent( "arena_defend_billboard2_trigger", "targetname" );
    w_spike_charge = getweapon( "spike_charge" );
    
    do
    {
        trigger waittill( #"damage", _, _, _, _, _, _, _, _, w_attacker );
        b_should_play_fxanim = isdefined( w_attacker ) && w_attacker == w_spike_charge;
    }
    while ( !b_should_play_fxanim );
    
    level scene::play( "p7_fxanim_cp_ramses_arena_billboard_02_bundle" );
}

// Namespace arena_defend
// Params 1
// Checksum 0x2dc95a33, Offset: 0xe210
// Size: 0x14e
function function_1a46d844( a_ents )
{
    level waittill( #"billboard_crash_notetrack" );
    level flag::set( "billboard2_crashed" );
    t_kill_billboard_ai = getent( "arena_defend_billboard2_trigger", "targetname" );
    var_fee634f2 = a_ents[ "arena_billboard_02" ];
    a_ai = getaiteamarray( "axis" );
    
    if ( isdefined( a_ai ) && isdefined( var_fee634f2 ) )
    {
        for ( i = 0; i < a_ai.size ; i++ )
        {
            if ( a_ai[ i ] istouching( t_kill_billboard_ai ) && isalive( a_ai[ i ] ) )
            {
                a_ai[ i ] kill( var_fee634f2.origin, undefined, var_fee634f2 );
            }
        }
    }
}

// Namespace arena_defend
// Params 1
// Checksum 0x8b2844c9, Offset: 0xe368
// Size: 0xac
function scene_callback_fxanim_mobile_wall_drop_init( a_ents )
{
    level thread show_mobile_wall_building_impact( 0 );
    level thread show_mobile_wall_sidewalk_impact( 0 );
    level util::waittill_notify_or_timeout( "mobile_wall_hit_sidewalk", 15 );
    level thread show_mobile_wall_sidewalk_impact( 1 );
    level util::waittill_notify_or_timeout( "mobile_wall_hit_building", 5 );
    level thread show_mobile_wall_building_impact( 1 );
}

// Namespace arena_defend
// Params 1
// Checksum 0x6961733d, Offset: 0xe420
// Size: 0x242
function show_mobile_wall_building_impact( b_enable )
{
    a_models_before = getentarray( "mobile_wall_smash_before", "targetname" );
    a_models_after = getentarray( "mobile_wall_smash_after", "targetname" );
    
    if ( b_enable )
    {
        foreach ( i, model in a_models_before )
        {
            model hide();
        }
        
        foreach ( i, model in a_models_after )
        {
            model show();
        }
        
        return;
    }
    
    foreach ( i, model in a_models_before )
    {
        model show();
    }
    
    foreach ( model in a_models_after )
    {
        model hide();
    }
}

// Namespace arena_defend
// Params 1
// Checksum 0x4b5e1fbc, Offset: 0xe670
// Size: 0x174
function show_mobile_wall_sidewalk_impact( b_enable )
{
    a_models_before = getentarray( "mobile_wall_sidewalk_smash_before", "targetname" );
    
    if ( b_enable )
    {
        foreach ( i, model in a_models_before )
        {
            model hide();
        }
        
        level clientfield::set( "arena_defend_mobile_wall_damage", 0 );
        return;
    }
    
    foreach ( model in a_models_before )
    {
        model show();
    }
    
    level clientfield::set( "arena_defend_mobile_wall_damage", 1 );
}

// Namespace arena_defend
// Params 1
// Checksum 0xe7e3d9a1, Offset: 0xe7f0
// Size: 0x1f2
function scene_callback_fxanim_mobile_wall_drop_play( a_ents )
{
    e_vtol = getent( "wall_drop_vtol", "targetname" );
    level waittill( #"fire_rocket_at_vtol" );
    level thread rocket_notify();
    weapon = getweapon( "smaw" );
    s_vtol_rocket_start = struct::get( "s_vtol_rocket_start", "targetname" );
    
    for ( i = 0; i < 3 ; i++ )
    {
        if ( isdefined( e_vtol ) )
        {
            a_rockets[ i ] = magicbullet( weapon, s_vtol_rocket_start.origin, e_vtol.origin, undefined, e_vtol, ( -300, 0, 400 ) );
            wait 0.25;
        }
    }
    
    level flag::wait_till( "arena_defend_rocket_hits_vtol" );
    
    foreach ( e_rocket in a_rockets )
    {
        if ( isdefined( e_rocket ) )
        {
            e_rocket detonate();
            wait 0.1;
        }
    }
}

// Namespace arena_defend
// Params 0
// Checksum 0x9310c18f, Offset: 0xe9f0
// Size: 0x2c
function rocket_notify()
{
    level waittill( #"rocket_hits_vtol" );
    level flag::set( "arena_defend_rocket_hits_vtol" );
}

// Namespace arena_defend
// Params 1
// Checksum 0x99375709, Offset: 0xea28
// Size: 0x64
function scene_callback_fxanim_mobile_wall_drop_done( a_ents )
{
    scene::remove_player_linked_scene( "p7_fxanim_cp_ramses_wall_drop_bundle" );
    level flag::set( "arena_defend_mobile_wall_deployed" );
    vehicle::simple_spawn( "arena_defend_mobile_wall_turret", 1 );
}

// Namespace arena_defend
// Params 1
// Checksum 0xb3fa2709, Offset: 0xea98
// Size: 0x5c
function scene_callback_checkpoint_left_breach_init( a_ents )
{
    mdl_checkpoint_wall = getent( "arena_defend_checkpoint_wall_b", "targetname" );
    
    if ( isdefined( mdl_checkpoint_wall ) )
    {
        mdl_checkpoint_wall disconnectpaths();
    }
}

// Namespace arena_defend
// Params 1
// Checksum 0xd4b341e, Offset: 0xeb00
// Size: 0x142
function scene_callback_checkpoint_left_breach_play( a_ents )
{
    mdl_checkpoint_wall = getent( "arena_defend_checkpoint_wall_b", "targetname" );
    level cleanup_nearby_explosives( mdl_checkpoint_wall );
    
    if ( isdefined( mdl_checkpoint_wall ) )
    {
        mdl_checkpoint_wall connectpaths();
        mdl_checkpoint_wall delete();
    }
    
    wait 0.1;
    a_models = getentarray( "arena_defend_checkpoint_wall_left_models", "script_noteworthy" );
    
    foreach ( mdl_wall in a_models )
    {
        mdl_wall delete();
    }
}

// Namespace arena_defend
// Params 1
// Checksum 0xf61e51a7, Offset: 0xec50
// Size: 0x1a
function scene_callback_checkpoint_left_breach_done( a_ents )
{
    level notify( #"checkpoint_wall_breach_complete" );
}

// Namespace arena_defend
// Params 1
// Checksum 0x75e3ac65, Offset: 0xec78
// Size: 0x1c4
function scene_callback_checkpoint_right_breach_play( a_ents )
{
    mdl_clip = getent( "arena_defend_checkpoint_wall_right_clip", "targetname" );
    level cleanup_nearby_explosives( mdl_clip );
    
    if ( isdefined( mdl_clip ) )
    {
        mdl_clip delete();
    }
    
    wait 0.1;
    a_models = getentarray( "arena_defend_checkpoint_wall_right_models", "script_noteworthy" );
    
    foreach ( mdl_wall in a_models )
    {
        mdl_wall delete();
    }
    
    spawner::simple_spawn( "checkpoint_right_breach_raps" );
    spawner::simple_spawn( "sp_wp_04_robot_defenders" );
    spawn_manager::enable( "sm_wp_04_defenders" );
    spawn_manager::enable( "sm_wp_04_wasps" );
    spawner::waittill_ai_group_count( "checkpoint_right_breach_raps", 3 );
    spawn_manager::enable( "sm_checkpoint_right_fill_raps" );
}

// Namespace arena_defend
// Params 0
// Checksum 0x145bbe1b, Offset: 0xee48
// Size: 0xfc
function function_69b7b359()
{
    player = array::random( level.activeplayers );
    
    if ( isplayer( player ) )
    {
        self setgoal( player, 1 );
    }
    
    ramses_util::enable_nodes( "nd_raps_launch_point_1", "targetname", 1 );
    ramses_util::enable_nodes( "nd_raps_launch_point_2", "targetname", 1 );
    ramses_util::enable_nodes( "nd_raps_launch_point_3", "targetname", 1 );
    ramses_util::enable_nodes( "nd_raps_launch_point_4", "targetname", 1 );
}

// Namespace arena_defend
// Params 1
// Checksum 0x65ef9fba, Offset: 0xef50
// Size: 0x44
function play_checkpoint_wall_breach_right( a_ents )
{
    trigger::wait_till( "arena_defend_checkpoint_wall_right_trigger" );
    level scene::play( "p7_fxanim_cp_ramses_checkpoint_wall_02_bundle" );
}

// Namespace arena_defend
// Params 1
// Checksum 0x8deaecc2, Offset: 0xefa0
// Size: 0x34
function play_checkpoint_wall_breach_left( a_ents )
{
    wait 3;
    level scene::play( "p7_fxanim_cp_ramses_checkpoint_wall_01_bundle" );
}

// Namespace arena_defend
// Params 2
// Checksum 0x76cf53d4, Offset: 0xefe0
// Size: 0x6c
function wall_fxanim_scene( b_active_deploy, b_open_doors )
{
    if ( !isdefined( b_active_deploy ) )
    {
        b_active_deploy = 1;
    }
    
    if ( !isdefined( b_open_doors ) )
    {
        b_open_doors = 1;
    }
    
    if ( b_active_deploy )
    {
        mobile_wall_deploy();
        return;
    }
    
    mobile_wall_deploy_skipto( b_open_doors );
}

// Namespace arena_defend
// Params 1
// Checksum 0x8c9787a9, Offset: 0xf058
// Size: 0x74
function mobile_wall_deploy_skipto( b_open_doors )
{
    if ( !isdefined( b_open_doors ) )
    {
        b_open_doors = 1;
    }
    
    level thread scene::skipto_end( "p7_fxanim_cp_ramses_wall_drop_bundle" );
    level flag::set( "arena_defend_mobile_wall_deployed" );
    
    if ( b_open_doors )
    {
        mobile_wall_doors_open();
    }
}

// Namespace arena_defend
// Params 0
// Checksum 0x6982eb37, Offset: 0xf0d8
// Size: 0x9c
function mobile_wall_deploy()
{
    scene::add_player_linked_scene( "p7_fxanim_cp_ramses_wall_drop_bundle" );
    level thread scene::play( "p7_fxanim_cp_ramses_wall_drop_bundle" );
    ramses_util::co_op_teleport_on_igc_end( "cin_ram_05_01_block_1st_rip", "arena_defend" );
    level scene::play( "cin_ram_05_01_block_1st_rip" );
    level flag::set( "intro_igc_done" );
}

// Namespace arena_defend
// Params 0
// Checksum 0xe47947ad, Offset: 0xf180
// Size: 0xb4
function mobile_wall_doors_open()
{
    e_doors = getent( "wall_drop_doors", "targetname" );
    
    if ( !isdefined( e_doors ) )
    {
        e_doors = util::spawn_model( "p7_fxanim_cp_ramses_mobile_wall_doors_mod" );
        e_doors.targetname = "wall_drop_doors";
    }
    
    assert( isdefined( e_doors ), "<dev string:x385>" );
    level scene::play( "p7_fxanim_cp_ramses_wall_drop_doors_up_bundle", e_doors );
}

// Namespace arena_defend
// Params 0
// Checksum 0xaa74d8c7, Offset: 0xf240
// Size: 0xb4
function mobile_wall_doors_close()
{
    e_doors = getent( "wall_drop_doors", "targetname" );
    
    if ( !isdefined( e_doors ) )
    {
        e_doors = util::spawn_model( "p7_fxanim_cp_ramses_mobile_wall_doors_mod" );
        e_doors.targetname = "wall_drop_doors";
    }
    
    assert( isdefined( e_doors ), "<dev string:x385>" );
    level scene::play( "p7_fxanim_cp_ramses_wall_drop_doors_down_bundle", e_doors );
}

// Namespace arena_defend
// Params 0
// Checksum 0x7e4ef01d, Offset: 0xf300
// Size: 0xcc
function weak_points_fxanim_scenes_complete()
{
    level thread scene::skipto_end( "wp_01", "targetname" );
    level thread scene::skipto_end( "wp_02", "targetname" );
    level thread scene::skipto_end( "wp_03", "targetname" );
    level thread scene::skipto_end( "wp_04", "targetname" );
    level thread scene::skipto_end( "wp_05", "targetname" );
}

// Namespace arena_defend
// Params 0
// Checksum 0x7d0788a, Offset: 0xf3d8
// Size: 0xcc
function weak_points_fxanim_scenes_cleanup()
{
    level scene::stop( "wp_01", "targetname", 1 );
    level scene::stop( "wp_02", "targetname", 1 );
    level scene::stop( "wp_03", "targetname", 1 );
    level scene::stop( "wp_04", "targetname", 1 );
    level scene::stop( "wp_05", "targetname", 1 );
}

// Namespace arena_defend
// Params 1
// Checksum 0x31891e03, Offset: 0xf4b0
// Size: 0x122
function chain_explosion_fxanim_scenes( a_ents )
{
    t_detonate = getent( "ad_detonator_trig", "targetname" );
    e_grenade = getent( "sinkhole_grenade_ent", "targetname" );
    a_s = struct::get_array( t_detonate.target, "targetname" );
    
    foreach ( s in a_s )
    {
        s thread _chain_explosion_fxanim_think( e_grenade );
    }
}

// Namespace arena_defend
// Params 1
// Checksum 0x618a7d1c, Offset: 0xf5e0
// Size: 0xbc
function _chain_explosion_fxanim_think( e )
{
    s_start = self;
    
    while ( isdefined( s_start.target ) )
    {
        s = struct::get( s_start.target, "targetname" );
        e magicgrenadetype( getweapon( "frag_grenade" ), s.origin, ( 0, 0, 1 ), 0.1 );
        s_start = s;
        wait 0.25;
    }
}

// Namespace arena_defend
// Params 0
// Checksum 0xeafeb88f, Offset: 0xf6a8
// Size: 0x16c
function init_sinkhole()
{
    level.a_m_sinkhole_hide_props = [];
    a_m_props = getentarray( "arena_defend_models", "targetname" );
    a_m_sinkhole = getentarray( "arena_defend_sinkhole", "targetname" );
    s_street_spot = struct::get( "sinkhole_street_spot", "targetname" );
    
    foreach ( m in a_m_props )
    {
        if ( !isdefined( m.script_noteworthy ) || m.script_noteworthy != "ignore_paths" )
        {
            m disconnectpaths();
        }
    }
    
    a_m_sinkhole ramses_util::hide_ents();
}

// Namespace arena_defend
// Params 1
// Checksum 0xaa6c3135, Offset: 0xf820
// Size: 0xe2
function scene_callback_sinkhole_handle_collision( a_ents )
{
    mdl_street = a_ents[ "street_collapse_big_hole" ];
    a_mdl_street_collision = getentarray( "arena_defend_street_col", "targetname" );
    
    foreach ( model in a_mdl_street_collision )
    {
        model linkto( mdl_street, "bck_ground_sec_07_jnt" );
    }
}

// Namespace arena_defend
// Params 1
// Checksum 0x797437f9, Offset: 0xf910
// Size: 0x1a4
function function_be12945c( a_ents )
{
    util::wait_network_frame();
    fxanim = getent( "small_hole_01", "targetname" );
    fxanim thread scene::init( "p7_fxanim_cp_ramses_street_collapse_small_hole_01_drop_bundle" );
    util::wait_network_frame();
    fxanim = getent( "small_hole_02", "targetname" );
    fxanim thread scene::init( "p7_fxanim_cp_ramses_street_collapse_small_hole_02_drop_bundle" );
    util::wait_network_frame();
    fxanim = getent( "small_hole_03", "targetname" );
    fxanim thread scene::init( "p7_fxanim_cp_ramses_street_collapse_small_hole_03_drop_bundle" );
    util::wait_network_frame();
    fxanim = getent( "small_hole_04", "targetname" );
    fxanim thread scene::init( "p7_fxanim_cp_ramses_street_collapse_small_hole_04_drop_bundle" );
    util::wait_network_frame();
    fxanim = getent( "small_hole_05", "targetname" );
    fxanim thread scene::init( "p7_fxanim_cp_ramses_street_collapse_small_hole_05_drop_bundle" );
}

// Namespace arena_defend
// Params 1
// Checksum 0xc9dc6487, Offset: 0xfac0
// Size: 0x1bc
function scene_callback_sinkhole_play_all_bundles( a_ents )
{
    level thread function_f93fee8e();
    fxanim = getent( "small_hole_01", "targetname" );
    fxanim thread scene::play( "p7_fxanim_cp_ramses_street_collapse_small_hole_01_drop_bundle" );
    fxanim = getent( "small_hole_02", "targetname" );
    fxanim thread scene::play( "p7_fxanim_cp_ramses_street_collapse_small_hole_02_drop_bundle" );
    fxanim = getent( "small_hole_03", "targetname" );
    fxanim thread scene::play( "p7_fxanim_cp_ramses_street_collapse_small_hole_03_drop_bundle" );
    fxanim = getent( "small_hole_04", "targetname" );
    fxanim thread scene::play( "p7_fxanim_cp_ramses_street_collapse_small_hole_04_drop_bundle" );
    fxanim = getent( "small_hole_05", "targetname" );
    fxanim thread scene::play( "p7_fxanim_cp_ramses_street_collapse_small_hole_05_drop_bundle" );
    e_truck_cargo = getent( "street_collapse_trailer_cargo", "targetname" );
    
    if ( isdefined( e_truck_cargo ) )
    {
        e_truck_cargo delete();
    }
}

// Namespace arena_defend
// Params 0
// Checksum 0x18e8cd12, Offset: 0xfc88
// Size: 0xca
function function_f93fee8e()
{
    a_vh_technicals = getentarray( "arena_defend_technical", "script_noteworthy" );
    
    foreach ( vh_technical in a_vh_technicals )
    {
        vh_technical disconnectpaths( 0, 0 );
        util::wait_network_frame();
    }
}

// Namespace arena_defend
// Params 1
// Checksum 0x35c2fd0d, Offset: 0xfd60
// Size: 0x2c
function scene_callback_fxanim_sinkhole_done( a_ents )
{
    level flag::set( "sinkhole_collapse_complete" );
}

// Namespace arena_defend
// Params 1
// Checksum 0x38ed663c, Offset: 0xfd98
// Size: 0xfa
function scene_callback_demostreet_detonation_setup( a_ents )
{
    level flag::set( "arena_defend_sinkhole_igc_started" );
    
    foreach ( player in level.players )
    {
        player clientfield::set_to_player( "set_dedicated_shadow", 1 );
        player clientfield::set_to_player( "dni_eye", 1 );
    }
    
    level thread swap_sinkhole();
    level notify( #"delete_javelins" );
}

// Namespace arena_defend
// Params 0
// Checksum 0xb8fda3ae, Offset: 0xfea0
// Size: 0x54
function swap_sinkhole()
{
    wait 0.5;
    level thread sinkhole_fxanim_hide_everything_in_street( 0 );
    util::wait_network_frame();
    level scene::init( "p7_fxanim_cp_ramses_street_collapse_big_hole_bundle" );
}

// Namespace arena_defend
// Params 1
// Checksum 0x903586d8, Offset: 0xff00
// Size: 0xba
function scene_callback_demostreet_light_blocker( a_ents )
{
    a_shadow_blockers = getentarray( "lgt_shadow_block", "targetname" );
    
    foreach ( blocker in a_shadow_blockers )
    {
        blocker show();
    }
}

// Namespace arena_defend
// Params 1
// Checksum 0xb9674c04, Offset: 0xffc8
// Size: 0x84
function function_f2434205( a_ents )
{
    delete_friendly_ai_for_final_scene();
    array::run_all( getaiteamarray( "axis" ), &delete );
    array::run_all( getcorpsearray(), &delete );
}

// Namespace arena_defend
// Params 1
// Checksum 0xcdb6a8dd, Offset: 0x10058
// Size: 0x24
function scene_callback_demostreet_robot_hide( a_ents )
{
    level thread function_c687aeb9( a_ents );
}

// Namespace arena_defend
// Params 1
// Checksum 0x3d941af3, Offset: 0x10088
// Size: 0x17c
function function_c687aeb9( a_ents )
{
    if ( isdefined( a_ents[ "robot_arm" ] ) )
    {
        a_ents[ "robot_arm" ] hide();
        a_ents[ "robot_head" ] hide();
        a_ents[ "robot_missing_arm" ] hide();
        a_ents[ "robot_missing_arm_head" ] hide();
        a_ents[ "robot_intact" ] waittill( #"hide_rarm" );
        a_ents[ "robot_intact" ] setmodel( "c_nrc_robot_grunt_dam_dps_rarmoff" );
        a_ents[ "robot_arm" ] show();
        a_ents[ "robot_intact" ] waittill( #"hide_head" );
        a_ents[ "robot_intact" ] detachall();
        a_ents[ "robot_intact" ] setmodel( "c_nrc_robot_grunt_dam_dps_rarmoff_headoff" );
        a_ents[ "robot_head" ] show();
    }
}

// Namespace arena_defend
// Params 1
// Checksum 0x3ae4acf, Offset: 0x10210
// Size: 0x17c
function function_ec8a2922( a_ents )
{
    a_ents[ "robot_arm" ] hide();
    a_ents[ "robot_head" ] hide();
    a_ents[ "robot_missing_arm" ] hide();
    a_ents[ "robot_missing_arm_head" ] hide();
    a_ents[ "robot_intact" ] waittill( #"hide_rarm" );
    a_ents[ "robot_missing_arm" ] show();
    a_ents[ "robot_intact" ] hide();
    a_ents[ "robot_arm" ] show();
    a_ents[ "robot_intact" ] waittill( #"hide_head" );
    a_ents[ "robot_missing_arm_head" ] show();
    a_ents[ "robot_missing_arm" ] hide();
    a_ents[ "robot_head" ] show();
}

// Namespace arena_defend
// Params 1
// Checksum 0xb5aaf1a6, Offset: 0x10398
// Size: 0x17c
function function_128ca38b( a_ents )
{
    a_ents[ "robot_arm" ] ghost();
    a_ents[ "robot_head" ] ghost();
    a_ents[ "robot_missing_arm" ] ghost();
    a_ents[ "robot_missing_arm_head" ] ghost();
    a_ents[ "robot_intact" ] waittill( #"hide_rarm" );
    a_ents[ "robot_missing_arm" ] show();
    a_ents[ "robot_intact" ] ghost();
    a_ents[ "robot_arm" ] show();
    a_ents[ "robot_intact" ] waittill( #"hide_head" );
    a_ents[ "robot_missing_arm_head" ] show();
    a_ents[ "robot_missing_arm" ] ghost();
    a_ents[ "robot_head" ] show();
}

// Namespace arena_defend
// Params 1
// Checksum 0xcda42c18, Offset: 0x10520
// Size: 0x9c
function scene_callback_demostreet_detonation_play( a_ents )
{
    ramses_util::function_1aeb2873();
    level waittill( #"start_sinkhole_collapse" );
    level flag::set( "sinkhole_charges_detonated" );
    fxanim_sinkhole_play();
    level thread util::set_streamer_hint( 2 );
    hidemiscmodels( "alley_doors" );
    showmiscmodels( "alley_doors_open" );
}

// Namespace arena_defend
// Params 1
// Checksum 0xa521b9a8, Offset: 0x105c8
// Size: 0x9c
function scene_callback_demostreet_detonation_done( a_ents )
{
    a_ents[ "player 1" ] clientfield::set_to_player( "dni_eye", 0 );
    array::run_all( getaiteamarray( "axis" ), &delete );
    level scene::init( "cin_ram_05_demostreet_3rd_sh100" );
    util::clear_streamer_hint();
}

// Namespace arena_defend
// Params 1
// Checksum 0x436d73fd, Offset: 0x10670
// Size: 0x1c
function function_2ec70f8b( a_ents )
{
    ramses_util::function_22e1a261();
}

// Namespace arena_defend
// Params 1
// Checksum 0x7773e15e, Offset: 0x10698
// Size: 0x124
function scene_callback_demostreet_done( a_ents )
{
    level flag::set( "arena_defend_sinkhole_collapse_done" );
    level.ai_khalil delete();
    a_shadow_blockers = getentarray( "lgt_shadow_block", "targetname" );
    
    foreach ( blocker in a_shadow_blockers )
    {
        blocker hide();
    }
    
    showmiscmodels( "alley_doors" );
    hidemiscmodels( "alley_doors_open" );
}

// Namespace arena_defend
// Params 1
// Checksum 0x7c56e34a, Offset: 0x107c8
// Size: 0x84
function function_e4fcbd75( a_ents )
{
    var_32d013aa = getdvarint( "ui_execdemo_cp", 0 );
    
    if ( var_32d013aa )
    {
        level waittill( #"hash_4b89bb4a" );
        skipto::use_default_skipto();
        level lui::screen_fade_out( 2 );
        exitlevel( 0 );
    }
}

// Namespace arena_defend
// Params 0
// Checksum 0xfd3f1168, Offset: 0x10858
// Size: 0x44
function function_eb0491d7()
{
    self endon( #"death" );
    self ai::set_ignoreall( 1 );
    self ai::set_behavior_attribute( "sprint", 1 );
}

// Namespace arena_defend
// Params 1
// Checksum 0x3bd8af29, Offset: 0x108a8
// Size: 0x3c
function scene_callback_demostreet_intro_init( a_ents )
{
    ai_guy = a_ents[ "detonation_guy" ];
    ai_guy ai::gun_remove();
}

// Namespace arena_defend
// Params 1
// Checksum 0xd70b27b3, Offset: 0x108f0
// Size: 0x1d4
function scene_callback_demostreet_intro_play( a_ents )
{
    ai_guy = a_ents[ "detonation_guy" ];
    ai_guy waittill( #"detonator_dropped" );
    mdl_detonator = a_ents[ "detonator" ];
    mdl_detonator.script_noteworthy = "arena_defend_detonator_pickup_model";
    mdl_detonator oed::enable_keyline( 1 );
    trigger = spawn( "trigger_radius_use", mdl_detonator.origin + ( 0, 0, 10 ), 0, 85, 128 );
    trigger triggerignoreteam();
    trigger setvisibletoall();
    trigger setteamfortrigger( "none" );
    a_keyline = getentarray( "temp_detonator_button", "targetname" );
    var_49ddde9 = util::init_interactive_gameobject( trigger, &"cp_level_ramses_detonator", &"CP_MI_CAIRO_RAMSES_DETONATOR_TRIG", &function_dcc9f49f, a_keyline );
    var_49ddde9.script_objective = "sinkhole_collapse";
    level flag::set( "arena_defend_detonator_dropped" );
}

// Namespace arena_defend
// Params 1
// Checksum 0x1d41831, Offset: 0x10ad0
// Size: 0x4c
function function_dcc9f49f( player )
{
    level.var_8e659b82 = player;
    level flag::set( "arena_defend_detonator_pickup" );
    self gameobjects::destroy_object( 1 );
}

// Namespace arena_defend
// Params 0
// Checksum 0xf3b0b9a7, Offset: 0x10b28
// Size: 0xd4
function vignette_hendricks_leap()
{
    level.ai_hendricks ai::set_behavior_attribute( "cqb", 0 );
    level.ai_hendricks ai::set_behavior_attribute( "disablesprint", 1 );
    level.ai_hendricks ai::set_ignoreall( 1 );
    level thread scene::init( "cin_ram_05_01_defend_vign_leapattack" );
    level util::waittill_notify_or_timeout( "hendricks_leap_started", 8 );
    ramses_util::enable_nodes( "arena_defend_mobile_wall_top_nodes", "script_noteworthy", 1 );
}

// Namespace arena_defend
// Params 1
// Checksum 0x78063573, Offset: 0x10c08
// Size: 0xf4
function scene_callback_hendricks_leap_init( a_ents )
{
    self util::delay_notify( 30, self.scriptbundlename + "_cancelled" );
    vignette_get_redshirt( "axis", "human", "arena_defend_vignette_hendricks_leap_guy_front", "guy_shot" );
    vignette_get_redshirt( "axis", "human", "arena_defend_vignette_hendricks_leap_guy_rear", "guy_grenade" );
    self flag::wait_till_all( self.a_scene_flags );
    self notify( self.scriptbundlename + "_starting" );
    level notify( #"hendricks_leap_started" );
    self scene::play( self.a_actors );
}

// Namespace arena_defend
// Params 1
// Checksum 0x1225d10, Offset: 0x10d08
// Size: 0xfc
function scene_callback_hendricks_leap_done( a_ents )
{
    nd_end_goal = getnode( "hendricks_leap_end_node", "targetname" );
    assert( isdefined( nd_end_goal ), "<dev string:x3ec>" );
    level.ai_hendricks ai::set_behavior_attribute( "disablesprint", 0 );
    level.ai_hendricks ai::set_ignoreall( 0 );
    level.ai_hendricks colors::disable();
    level.ai_hendricks setgoal( nd_end_goal );
    wait randomfloatrange( 5, 8 );
    level.ai_hendricks colors::enable();
}

// Namespace arena_defend
// Params 6
// Checksum 0x8e149182, Offset: 0x10e10
// Size: 0x144
function vignette_get_redshirt( str_faction, str_type, str_node, str_flag, str_endon, n_distance_override )
{
    if ( isdefined( str_endon ) )
    {
        self endon( str_endon );
    }
    
    if ( !self flag::exists( str_flag ) )
    {
        if ( !isdefined( self.a_scene_flags ) )
        {
            self.a_scene_flags = [];
        }
        
        if ( !isdefined( self.a_scene_flags ) )
        {
            self.a_scene_flags = [];
        }
        else if ( !isarray( self.a_scene_flags ) )
        {
            self.a_scene_flags = array( self.a_scene_flags );
        }
        
        self.a_scene_flags[ self.a_scene_flags.size ] = str_flag;
        self flag::init( str_flag );
    }
    
    self flag::clear( str_flag );
    self thread _vignette_get_redshirt( str_faction, str_type, str_node, str_flag, str_endon, n_distance_override );
}

// Namespace arena_defend
// Params 6
// Checksum 0xfcec2565, Offset: 0x10f60
// Size: 0x17c
function _vignette_get_redshirt( str_faction, str_type, str_node, str_flag, str_endon, n_distance )
{
    if ( !isdefined( n_distance ) )
    {
        n_distance = 400;
    }
    
    self endon( self.scriptbundlename + "_starting" );
    self endon( self.scriptbundlename + "_cancelled" );
    
    if ( !isdefined( self.a_actors ) )
    {
        self.a_actors = [];
    }
    
    do
    {
        ai_guy = send_ai_type_within_radius_to_node( str_type, str_faction, str_node, n_distance, 0 );
    }
    while ( !isdefined( ai_guy ) || !isalive( ai_guy ) );
    
    self flag::set( str_flag );
    self.a_actors[ str_flag ] = ai_guy;
    ai_guy util::waittill_any( "death", "start_ragdoll" );
    arrayremovevalue( self.a_actors, ai_guy, 0 );
    self vignette_get_redshirt( str_faction, str_type, str_node, str_flag, str_endon );
}

// Namespace arena_defend
// Params 3
// Checksum 0x89173181, Offset: 0x110e8
// Size: 0x134
function vignette_get_hero( str_hero, str_node, str_flag )
{
    if ( !isdefined( self.a_actors ) )
    {
        self.a_actors = [];
    }
    
    self.a_actors[ str_flag ] = util::get_hero( str_hero );
    
    if ( !self flag::exists( str_flag ) )
    {
        if ( !isdefined( self.a_scene_flags ) )
        {
            self.a_scene_flags = [];
        }
        
        if ( !isdefined( self.a_scene_flags ) )
        {
            self.a_scene_flags = [];
        }
        else if ( !isarray( self.a_scene_flags ) )
        {
            self.a_scene_flags = array( self.a_scene_flags );
        }
        
        self.a_scene_flags[ self.a_scene_flags.size ] = str_flag;
        self flag::init( str_flag );
    }
    
    self thread _vignette_get_hero( str_hero, str_node, str_flag );
}

// Namespace arena_defend
// Params 3
// Checksum 0x8d201adb, Offset: 0x11228
// Size: 0x1dc
function _vignette_get_hero( str_hero, str_node, str_flag )
{
    ai_hero = util::get_hero( str_hero );
    nd_goal = getnode( str_node, "targetname" );
    assert( isdefined( nd_goal ), "<dev string:x434>" + str_hero + "<dev string:x45b>" + self.scriptbundlename );
    n_goalradius = ai_hero.goalradius;
    ai_hero.goalradius = 32;
    
    if ( ai_hero colors::has_color() )
    {
        ai_hero colors::disable();
    }
    
    ai_hero setgoal( nd_goal, 1 );
    ai_hero util::waittill_any_timeout( 15, "goal" );
    self flag::set( str_flag );
    self util::waittill_any( self.scriptbundlename + "_starting", self.scriptbundlename + "_cancelled" );
    ai_hero.goalradius = n_goalradius;
    
    if ( ai_hero colors::has_color() )
    {
        ai_hero colors::enable();
    }
}

// Namespace arena_defend
// Params 1
// Checksum 0xc902e0e8, Offset: 0x11410
// Size: 0x64
function scene_callback_hendricks_vs_robot_play( a_ents )
{
    if ( isdefined( level.ai_hendricks.goalradius_old ) )
    {
        level.ai_hendricks.goalradius = level.ai_hendricks.goalradius_old;
        level.ai_hendricks.goalradius_old = undefined;
    }
    
    level.ai_hendricks colors::enable();
}

// Namespace arena_defend
// Params 1
// Checksum 0xf41b3f8b, Offset: 0x11480
// Size: 0xfc
function scene_callback_hendricks_vs_robot_init( a_ents )
{
    level endon( #"all_weak_points_destroyed" );
    level endon( #"player_plants_spike" );
    self flag::init( "hendricks_ready" );
    self thread hendricks_robot_melee_setup_hendricks();
    ai_robot = self hendricks_robot_melee_setup_robot();
    ai_robot endon( #"death" );
    self flag::wait_till( "hendricks_ready" );
    a_actors = [];
    a_actors[ "hendricks" ] = level.ai_hendricks;
    a_actors[ "robot" ] = ai_robot;
    level scene::play( "cin_gen_melee_hendricksmoment_closecombat_robot", a_actors );
}

// Namespace arena_defend
// Params 0
// Checksum 0x28d405b, Offset: 0x11588
// Size: 0xcc
function hendricks_robot_melee_setup_hendricks()
{
    nd_hendricks = getnode( "melee_robot_vignette_goal_hendricks", "targetname" );
    level.ai_hendricks colors::disable();
    level.ai_hendricks.goalradius_old = level.ai_hendricks.goalradius;
    level.ai_hendricks.goalradius = 32;
    level.ai_hendricks ai::force_goal( nd_hendricks );
    level.ai_hendricks waittill( #"goal" );
    self flag::set( "hendricks_ready" );
}

// Namespace arena_defend
// Params 0
// Checksum 0xae868973, Offset: 0x11660
// Size: 0x6c
function hendricks_robot_melee_setup_robot()
{
    do
    {
        ai_robot = send_ai_type_within_radius_to_node( "robot", "axis", "melee_robot_vignette_goal_robot", 1000, 0, 0 );
    }
    while ( !isdefined( ai_robot ) || !isalive( ai_robot ) );
    
    return ai_robot;
}

// Namespace arena_defend
// Params 1
// Checksum 0xefc9f0d2, Offset: 0x116d8
// Size: 0xea
function scene_callback_intro_guys( a_ents )
{
    foreach ( ent in a_ents )
    {
        if ( isai( ent ) )
        {
            ent thread guarantee_life_for_time( 10 );
            ent thread stay_at_goal_for_time( 15 );
            ent setgoal( ent.origin );
        }
    }
}

// Namespace arena_defend
// Params 1
// Checksum 0x34469d39, Offset: 0x117d0
// Size: 0x1a
function scene_callback_intro_guys_r_done( a_ents )
{
    level notify( #"first_turret_guy_vulnerable" );
}

// Namespace arena_defend
// Params 1
// Checksum 0x970705ba, Offset: 0x117f8
// Size: 0x68
function stay_at_goal_for_time( n_time )
{
    self endon( #"death" );
    n_goalradius_old = self.goalradius;
    self.goalradius = 64;
    self setgoal( self.origin );
    wait n_time;
    self.goalradius = n_goalradius_old;
}

// Namespace arena_defend
// Params 1
// Checksum 0xaf503705, Offset: 0x11868
// Size: 0x64
function guarantee_life_for_time( n_time )
{
    self endon( #"death" );
    self ai::set_ignoreme( 1 );
    level util::waittill_notify_or_timeout( "all_weak_points_destroyed", n_time );
    self ai::set_ignoreme( 0 );
}

// Namespace arena_defend
// Params 1
// Checksum 0x7271d16f, Offset: 0x118d8
// Size: 0x14a
function scene_callback_intro_done( a_ents )
{
    foreach ( player in level.players )
    {
        player switchtoweaponimmediate( getweapon( "spike_launcher" ) );
    }
    
    util::clear_streamer_hint();
    wait 2;
    
    foreach ( player in level.players )
    {
        player thread ramses_util::function_508a129e( "clear_spike_hints" );
    }
}

// Namespace arena_defend
// Params 1
// Checksum 0x8614f4c3, Offset: 0x11a30
// Size: 0x6c
function scene_callback_intro_technical( a_ents )
{
    vh_truck = a_ents[ "technical" ];
    vh_truck disconnectpaths( 0, 0 );
    
    if ( isdefined( a_ents[ "hendricks" ] ) )
    {
        skipto::teleport_ai( "arena_defend" );
    }
}

// Namespace arena_defend
// Params 1
// Checksum 0x6bcd9184, Offset: 0x11aa8
// Size: 0x2d4
function sinkhole_fxanim_hide_everything_in_street( b_delete_collision )
{
    if ( !isdefined( b_delete_collision ) )
    {
        b_delete_collision = 0;
    }
    
    init_sinkhole();
    level.a_m_sinkhole_hide_props = getentarray( "arena_defend_models", "targetname" );
    a_m_sinkhole = getentarray( "arena_defend_sinkhole", "targetname" );
    s_street_spot = struct::get( "sinkhole_street_spot", "targetname" );
    util::wait_network_frame();
    array::delete_all( level.a_m_sinkhole_hide_props );
    util::wait_network_frame();
    util::wait_network_frame();
    a_m_sinkhole ramses_util::show_ents();
    util::wait_network_frame();
    hidemiscmodels( "sinkhole_misc_model" );
    level clientfield::increment( "clear_all_dyn_ents", 1 );
    
    if ( b_delete_collision )
    {
        a_mdl_street_collision = getentarray( "arena_defend_street_col", "targetname" );
        
        foreach ( model in a_mdl_street_collision )
        {
            model delete();
        }
    }
    
    if ( level scene::is_active( "cin_ram_05_01_quadtank_flatbed_pose" ) )
    {
        level scene::stop( "cin_ram_05_01_quadtank_flatbed_pose", 1 );
    }
    
    if ( level scene::is_active( "cin_ram_05_01_defend_vign_rescueinjured_l_group" ) )
    {
        level scene::stop( "cin_ram_05_01_defend_vign_rescueinjured_l_group", 1 );
    }
    
    if ( level scene::is_active( "cin_ram_05_01_defend_vign_rescueinjured_r_group" ) )
    {
        level scene::stop( "cin_ram_05_01_defend_vign_rescueinjured_r_group", 1 );
    }
}

// Namespace arena_defend
// Params 1
// Checksum 0x4fec2192, Offset: 0x11d88
// Size: 0x64
function fxanim_sinkhole_play( b_play_full_anim )
{
    if ( !isdefined( b_play_full_anim ) )
    {
        b_play_full_anim = 1;
    }
    
    if ( b_play_full_anim )
    {
        level thread scene::play( "p7_fxanim_cp_ramses_street_collapse_big_hole_bundle" );
        return;
    }
    
    level thread scene::skipto_end( "p7_fxanim_cp_ramses_street_collapse_big_hole_bundle" );
}

// Namespace arena_defend
// Params 0
// Checksum 0x5784e291, Offset: 0x11df8
// Size: 0x134
function cleanup_wall()
{
    a_m_wall = getentarray( "checkpoint_wall", "targetname" );
    m_wall = getent( "mobile_wall_model", "targetname" );
    a_m_wall_clip = getentarray( "mobile_wall_clip", "targetname" );
    m_wall_doors = getent( "mobile_wall_doors_model", "targetname" );
    
    if ( isdefined( m_wall ) )
    {
        m_wall delete();
    }
    
    array::delete_all( a_m_wall );
    array::delete_all( a_m_wall_clip );
    
    if ( isdefined( m_wall_doors ) )
    {
        m_wall_doors delete();
    }
}

// Namespace arena_defend
// Params 0
// Checksum 0x99ec1590, Offset: 0x11f38
// Size: 0x4
function hunter_crash_fx_anims()
{
    
}

// Namespace arena_defend
// Params 0
// Checksum 0x1713e7d6, Offset: 0x11f48
// Size: 0x24
function stop_hunter_crash_fx_anims()
{
    level clientfield::set( "arena_defend_fxanim_hunters", 0 );
}

// Namespace arena_defend
// Params 0
// Checksum 0x80637937, Offset: 0x11f78
// Size: 0x104
function objectives()
{
    level waittill( #"vo_weak_points_identify_said" );
    level flag::set( "weak_points_objective_active" );
    level flag::wait_till( "all_weak_points_destroyed" );
    level flag::clear( "weak_points_objective_active" );
    level flag::wait_till_any( array( "mobile_wall_doors_closing", "arena_defend_detonator_dropped" ) );
    objectives::complete( "cp_level_ramses_fall_back" );
    level flag::wait_till( "sinkhole_charges_detonated" );
    objectives::complete( "cp_level_ramses_detonator" );
    objectives::complete( "cp_level_ramses_demolish_arena_defend" );
}

// Namespace arena_defend
// Params 0
// Checksum 0xc9b87ef2, Offset: 0x12088
// Size: 0xf0
function vo_find_closest_redshirt_for_dialog()
{
    a_friendly = getactorteamarray( "allies" );
    
    while ( true )
    {
        a_friendly_closest = arraysortclosest( a_friendly, level.players[ 0 ].origin );
        
        for ( i = 0; i < a_friendly_closest.size ; i++ )
        {
            if ( !isinarray( level.heroes, a_friendly_closest[ i ] ) && isalive( a_friendly_closest[ i ] ) )
            {
                return a_friendly_closest[ i ];
            }
        }
        
        wait 0.25;
    }
}

// Namespace arena_defend
// Params 1
// Checksum 0x4d13023b, Offset: 0x12180
// Size: 0x3a
function vo_pick_random_line( a_dialogue_lines )
{
    n_line = randomintrange( 0, a_dialogue_lines.size );
    return a_dialogue_lines[ n_line ];
}

// Namespace arena_defend
// Params 0
// Checksum 0x50175077, Offset: 0x121c8
// Size: 0xe8
function vo_spike_launched_enemy_tracker()
{
    level endon( #"all_weak_points_destroyed" );
    a_dialogue_lines = [];
    a_dialogue_lines[ 0 ] = "esl1_enemy_down_0";
    a_dialogue_lines[ 1 ] = "egy2_that_s_a_bad_way_to_0";
    a_dialogue_lines[ 2 ] = "esl3_it_went_right_throug_0";
    a_dialogue_lines[ 3 ] = "esl4_he_got_torn_up_0";
    
    while ( true )
    {
        level waittill( #"enemy_hit_by_spike" );
        ai_guy = vo_find_closest_redshirt_for_dialog();
        ai_guy thread dialog::say( vo_pick_random_line( a_dialogue_lines ) );
        wait randomintrange( 90, 120 );
    }
}

// Namespace arena_defend
// Params 0
// Checksum 0xfb298f2f, Offset: 0x122b8
// Size: 0x94
function vo_weak_point_initial_search()
{
    level dialog::player_say( "plyr_kane_search_the_cit_0" );
    level dialog::remote( "kane_got_to_give_me_time_0" );
    level dialog::player_say( "plyr_we_don_t_have_time_0" );
    vo_first_technical_drive_up();
    level flag::set( "arena_defend_initial_weak_point_search_finished" );
}

// Namespace arena_defend
// Params 0
// Checksum 0xdfa43fbd, Offset: 0x12358
// Size: 0xb4
function vo_weak_point_first_intro()
{
    level endon( #"wp_01_destroyed" );
    level flag::wait_till( "arena_defend_initial_weak_point_search_finished" );
    level thread dialog::remote( "kane_okay_i_ve_located_t_0" );
    level thread namespace_a6a248fc::function_9574e08d();
    wait 1;
    level thread lui::play_movie( "cp_ramses2_pip_unstableground", "pip" );
    wait 3;
    level notify( #"vo_weak_points_identify_said" );
    level thread function_7b768906();
}

// Namespace arena_defend
// Params 0
// Checksum 0x6b3d0e7b, Offset: 0x12418
// Size: 0xfc
function vo_first_technical_drive_up()
{
    vh_technical = getent( "arena_defend_technical_01_vh", "targetname" );
    
    if ( isalive( vh_technical ) )
    {
        a_dialogue_lines = [];
        a_dialogue_lines[ 0 ] = "esl3_eyes_on_enemy_techni_0";
        a_dialogue_lines[ 1 ] = "esl4_hostile_technical_mo_0";
        ai_guy = vo_find_closest_redshirt_for_dialog();
        ai_guy dialog::say( vo_pick_random_line( a_dialogue_lines ) );
    }
    
    if ( isalive( vh_technical ) )
    {
        level.ai_hendricks dialog::say( "hend_someone_move_on_that_0" );
    }
}

// Namespace arena_defend
// Params 0
// Checksum 0x5f2c39fe, Offset: 0x12520
// Size: 0x15c
function function_7b768906()
{
    level endon( #"player_plants_spike" );
    
    foreach ( player in level.activeplayers )
    {
        player thread function_54380572();
    }
    
    level waittill( #"hash_b7604d6c" );
    level.ai_hendricks dialog::say( "hend_not_good_enough_go_0" );
    level waittill( #"hash_b7604d6c" );
    level.ai_hendricks dialog::say( "hend_you_gotta_hammer_the_0" );
    level waittill( #"hash_b7604d6c" );
    level.ai_hendricks dialog::say( "hend_we_need_the_spikes_o_0" );
    level waittill( #"hash_b7604d6c" );
    level.ai_hendricks dialog::say( "hend_can_t_do_it_at_range_0" );
}

// Namespace arena_defend
// Params 0
// Checksum 0xa33ac662, Offset: 0x12688
// Size: 0x8a
function function_54380572()
{
    level endon( #"player_plants_spike" );
    self endon( #"death" );
    
    for ( var_39ba7753 = 0; true ; var_39ba7753 = 0 )
    {
        self waittill( #"weapon_fired", w_current );
        
        if ( w_current === level.w_spike_launcher )
        {
            var_39ba7753++;
            
            if ( var_39ba7753 >= 3 )
            {
                level notify( #"hash_b7604d6c" );
            }
        }
    }
}

// Namespace arena_defend
// Params 0
// Checksum 0x9761e698, Offset: 0x12720
// Size: 0xc4
function vo_weak_point_first_found()
{
    foreach ( player in level.activeplayers )
    {
        player thread function_e5f94949();
    }
    
    level.ai_hendricks thread dialog::say( "hend_target_confirmed_0", 1 );
    level thread function_8b9ed044();
}

// Namespace arena_defend
// Params 0
// Checksum 0x2c75cf5b, Offset: 0x127f0
// Size: 0xd4
function function_8b9ed044()
{
    level endon( #"all_weak_points_destroyed" );
    level waittill( #"player_plants_spike" );
    level.ai_hendricks dialog::say( "hend_blow_that_fucker_0", 1 );
    level waittill( #"player_plants_spike" );
    level.ai_hendricks thread dialog::say( "hend_spike_set_blow_it_0", 1 );
    level waittill( #"player_plants_spike" );
    level.ai_hendricks thread dialog::say( "hend_blow_that_spike_0", 1 );
    level waittill( #"player_plants_spike" );
    level.ai_hendricks thread dialog::say( "hend_spike_on_target_de_0", 1 );
}

// Namespace arena_defend
// Params 0
// Checksum 0xa8691567, Offset: 0x128d0
// Size: 0x94
function function_e5f94949()
{
    level endon( #"all_weak_points_destroyed" );
    self endon( #"death" );
    self waittill( #"spike_ammo_missing" );
    self thread dialog::player_say( "plyr_dammit_i_m_out_of_s_0" );
    self waittill( #"spike_ammo_missing" );
    self thread dialog::player_say( "plyr_need_a_reload_0" );
    self waittill( #"spike_ammo_missing" );
    self thread dialog::player_say( "plyr_i_m_all_out_need_m_0" );
}

// Namespace arena_defend
// Params 0
// Checksum 0x987cb34f, Offset: 0x12970
// Size: 0x24
function vo_weak_point_first_destroyed()
{
    level dialog::player_say( "plyr_detonation_confirmed_0", 1 );
}

// Namespace arena_defend
// Params 0
// Checksum 0x9dc2725a, Offset: 0x129a0
// Size: 0x94
function function_60f90684()
{
    a_dialogue_lines = [];
    a_dialogue_lines[ 0 ] = "esl1_i_got_grunts_scaling_0";
    a_dialogue_lines[ 1 ] = "egy2_heads_up_hostile_0";
    a_dialogue_lines[ 2 ] = "esl3_look_out_enemy_grun_0";
    ai_guy = vo_find_closest_redshirt_for_dialog();
    ai_guy thread dialog::say( vo_pick_random_line( a_dialogue_lines ) );
}

// Namespace arena_defend
// Params 0
// Checksum 0xd2c7b1a6, Offset: 0x12a40
// Size: 0x74
function vo_weak_point_second_found()
{
    level thread dialog::remote( "kane_two_more_in_the_nort_0" );
    wait 0.5;
    wait 2;
    level dialog::player_say( "plyr_copy_that_hendricks_0" );
    level.ai_hendricks dialog::say( "hend_you_re_good_go_0", 1 );
}

// Namespace arena_defend
// Params 0
// Checksum 0x99ec1590, Offset: 0x12ac0
// Size: 0x4
function vo_checkpoint_wall_breached()
{
    
}

// Namespace arena_defend
// Params 0
// Checksum 0xd66136e2, Offset: 0x12ad0
// Size: 0x24
function vo_weak_point_second_wave_destroyed()
{
    level dialog::remote( "ecmd_nrc_reinforcements_f_0" );
}

// Namespace arena_defend
// Params 0
// Checksum 0x5ceb457b, Offset: 0x12b00
// Size: 0x24
function vo_weak_point_third_found()
{
    level thread dialog::remote( "kane_last_two_0", 1 );
}

// Namespace arena_defend
// Params 0
// Checksum 0x9b803aaf, Offset: 0x12b30
// Size: 0x84
function vo_weak_point_last_group()
{
    level endon( #"all_weak_points_destroyed" );
    wait 0.75;
    level dialog::remote( "kane_this_is_it_last_on_0" );
    level thread dialog::remote( "ecmd_nrc_reinforcements_i_0" );
    level waittill( #"player_plants_spike" );
    level.ai_hendricks thread dialog::say( "hend_blow_it_0", 2 );
}

// Namespace arena_defend
// Params 0
// Checksum 0x988f77a0, Offset: 0x12bc0
// Size: 0x234
function vo_weak_points_all_destroyed()
{
    util::wait_network_frame();
    
    if ( !level flag::get( "mobile_wall_doors_closing" ) )
    {
        level.ai_hendricks dialog::say( "hend_that_s_it_we_got_0" );
    }
    
    objectives::set( "cp_level_ramses_fall_back" );
    level thread objectives::breadcrumb( "arena_defend_wall_gather_trig" );
    
    if ( !level flag::get( "mobile_wall_doors_closing" ) )
    {
        if ( isdefined( level.ai_khalil ) )
        {
            a_dialogue_lines = [];
            a_dialogue_lines[ 0 ] = "khal_we_have_to_blow_the_0";
            a_dialogue_lines[ 1 ] = "khal_hurry_we_have_to_bl_0";
            a_dialogue_lines[ 2 ] = "hend_fall_back_to_mobile_0";
            a_dialogue_lines[ 3 ] = "hend_get_the_fuck_back_g_0";
            a_dialogue_lines[ 4 ] = "hend_fall_back_behind_the_0";
            level.ai_khalil dialog::say( vo_pick_random_line( a_dialogue_lines ) );
        }
    }
    
    if ( !level flag::get( "mobile_wall_doors_closing" ) )
    {
        a_dialogue_lines = [];
        a_dialogue_lines[ 0 ] = "esl1_get_behind_the_wall_0";
        a_dialogue_lines[ 1 ] = "egy2_move_behind_the_mobi_0";
        a_dialogue_lines[ 2 ] = "esl1_get_behind_the_wall_1";
        
        if ( level.skipto_point != "dev_sinkhole_test" )
        {
            ai_guy = vo_find_closest_redshirt_for_dialog();
            ai_guy thread dialog::say( vo_pick_random_line( a_dialogue_lines ), 5 );
        }
    }
    
    level thread function_d3adcddf();
}

// Namespace arena_defend
// Params 0
// Checksum 0xd39e8aeb, Offset: 0x12e00
// Size: 0x44
function function_d3adcddf()
{
    level dialog::remote( "kane_we_got_javelin_missi_0" );
    level.ai_hendricks dialog::say( "hend_incoming_1" );
}

// Namespace arena_defend
// Params 0
// Checksum 0xb44ed0c9, Offset: 0x12e50
// Size: 0x34
function vo_clear_to_detonate()
{
    if ( isdefined( level.ai_khalil ) )
    {
        level.ai_khalil dialog::say( "khal_get_on_top_of_wall_0" );
    }
}

// Namespace arena_defend
// Params 1
// Checksum 0xfb19ddc0, Offset: 0x12e90
// Size: 0xde
function vo_friendly_sinkhole_celebration( a_friendlies )
{
    level endon( #"arena_defend_fade_out" );
    a_dialogue_lines = [];
    a_dialogue_lines[ 0 ] = "esl4_let_s_see_them_climb_0";
    a_dialogue_lines[ 1 ] = "esl3_they_won_t_be_coming_0";
    a_dialogue_lines[ 2 ] = "egy2_they_think_we_ll_bre_0";
    a_dialogue_lines[ 3 ] = "esl1_our_will_won_t_be_br_0";
    
    if ( a_friendlies > a_dialogue_lines.size )
    {
        for ( i = 0; i < a_dialogue_lines.size ; i++ )
        {
            a_friendlies[ i ] dialog::say( a_dialogue_lines[ i ] );
            wait 0.5;
        }
    }
}

/#

    // Namespace arena_defend
    // Params 2
    // Checksum 0x3e940ba6, Offset: 0x12f78
    // Size: 0xb8, Type: dev
    function draw_line_to_target( e, n_timer )
    {
        self endon( #"death" );
        n_timer = gettime() + n_timer * 1000;
        
        while ( gettime() < n_timer )
        {
            line( self.origin + ( 0, 0, 300 ), e.origin, ( 1, 0, 0 ), 0.1 );
            debug::drawarrow( e.origin, e.angles );
            wait 0.05;
        }
    }

#/

// Namespace arena_defend
// Params 2
// Checksum 0x994a3ecb, Offset: 0x13038
// Size: 0x14c
function dev_weak_point_test( str_objective, b_starting )
{
    init_common_scripted_elements( str_objective, b_starting );
    setup_sinkhole_weak_points();
    level thread wall_fxanim_scene( 0, 1 );
    level flag::set( "weak_points_objective_active" );
    vehicle::add_spawn_function( "arena_defend_technical_01", &warp_to_spline_end );
    vehicle::simple_spawn_single( "arena_defend_technical_01" );
    expose_all_weak_points();
    scene::add_scene_func( "p7_fxanim_cp_ramses_street_collapse_small_hole_01_bundle", &play_checkpoint_wall_breach_left, "play" );
    scene::add_scene_func( "p7_fxanim_cp_ramses_street_collapse_small_hole_04_bundle", &play_checkpoint_wall_breach_right, "play" );
    wait_till_all_weak_points_destroyed();
    dev_sinkhole_test( "dev_sinkhole_test", 0 );
}

// Namespace arena_defend
// Params 2
// Checksum 0x3c393414, Offset: 0x13190
// Size: 0x14
function dev_weak_point_test_done( str_objective, b_starting )
{
    
}

// Namespace arena_defend
// Params 1
// Checksum 0x60e6b227, Offset: 0x131b0
// Size: 0xc2
function delete_dev_waypoint_collision( str_waypoint )
{
    a_collision = getentarray( "collision_" + str_waypoint, "targetname" );
    
    foreach ( mdl_collision in a_collision )
    {
        mdl_collision delete();
    }
}

// Namespace arena_defend
// Params 2
// Checksum 0x641d0122, Offset: 0x13280
// Size: 0x304
function dev_sinkhole_test( str_objective, b_starting )
{
    if ( b_starting )
    {
        add_spawn_functions();
        level flag::wait_till( "all_players_spawned" );
    }
    
    ramses_util::function_f2f98cfc();
    vtol_igc::hide_skipto_items();
    setup_ambient_elements();
    function_c50ca91();
    init_heroes( str_objective, b_starting );
    friendlies_fall_back_behind_mobile_wall( 0 );
    init_sinkhole();
    level thread wall_fxanim_scene( 0, 1 );
    dev_test_setup_vehicles_for_sinkhole();
    level thread monitor_vehicle_targets();
    enemies_overrun_checkpoint_area();
    level flag::set( "all_weak_points_destroyed" );
    weak_points_fxanim_scenes_complete();
    delete_dev_waypoint_collision( "wp_01" );
    delete_dev_waypoint_collision( "wp_02" );
    delete_dev_waypoint_collision( "wp_03" );
    delete_dev_waypoint_collision( "wp_04" );
    wait 1;
    level thread sinkhole_objectives();
    level thread util::screen_message_create( "PRESS RIGHT ON D-PAD TO PLAY FINAL SCENE", undefined, undefined, undefined, 10 );
    
    while ( true )
    {
        if ( level.players[ 0 ] actionslotfourbuttonpressed() )
        {
            break;
        }
        
        wait 0.05;
    }
    
    util::screen_message_delete();
    function_2e8bcd54();
    scene_friendly_detonation_guy_killed();
    level notify( #"spawn_technical_backup_1" );
    level thread players_detonate_charges_from_mobile_wall();
    spawn_manager::enable( "arena_defend_wall_allies" );
    level flag::wait_till( "arena_defend_sinkhole_collapse_done" );
    kill_spawn_manager_group( "arena_defend_spawn_manager" );
    kill_all_ai_in_street();
    ramses_util::delete_all_non_hero_ai();
    skipto::objective_completed( str_objective );
}

// Namespace arena_defend
// Params 0
// Checksum 0x722ef726, Offset: 0x13590
// Size: 0x2e
function sinkhole_objectives()
{
    level thread objectives();
    wait 1;
    level notify( #"vo_weak_points_identify_said" );
}

// Namespace arena_defend
// Params 0
// Checksum 0xd308203e, Offset: 0x135c8
// Size: 0x54
function dev_test_setup_vehicles_for_sinkhole()
{
    vh_technical_initial = vehicle::simple_spawn_single( "arena_defend_intro_technical" );
    vh_technical_initial dodamage( vh_technical_initial.health, vh_technical_initial.origin );
}

// Namespace arena_defend
// Params 4
// Checksum 0xcbbf188a, Offset: 0x13628
// Size: 0x34
function dev_sinkhole_test_done( str_objective, b_starting, b_direct, player )
{
    remove_out_of_bounds_trigger_in_alley_building();
}

// Namespace arena_defend
// Params 0
// Checksum 0xc1121781, Offset: 0x13668
// Size: 0x22a
function expose_all_weak_points()
{
    a_data = get_weak_point_discovery_data();
    a_flags = [];
    
    foreach ( wave in a_data )
    {
        foreach ( s_weak_point in wave )
        {
            arraycombine( a_flags, s_weak_point.a_flags_wait_for_discovery, 0, 0 );
            
            if ( !isdefined( a_flags ) )
            {
                a_flags = [];
            }
            else if ( !isarray( a_flags ) )
            {
                a_flags = array( a_flags );
            }
            
            a_flags[ a_flags.size ] = s_weak_point.str_weak_point_identifier + "_identified";
        }
    }
    
    foreach ( str_flag in a_flags )
    {
        level flag::set( str_flag );
    }
}

