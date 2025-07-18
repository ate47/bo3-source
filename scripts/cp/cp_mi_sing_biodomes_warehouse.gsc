#using scripts/codescripts/struct;
#using scripts/cp/_dialog;
#using scripts/cp/_load;
#using scripts/cp/_objectives;
#using scripts/cp/_skipto;
#using scripts/cp/_spawn_manager;
#using scripts/cp/_squad_control;
#using scripts/cp/_util;
#using scripts/cp/cp_mi_sing_biodomes;
#using scripts/cp/cp_mi_sing_biodomes_accolades;
#using scripts/cp/cp_mi_sing_biodomes_markets;
#using scripts/cp/cp_mi_sing_biodomes_sound;
#using scripts/cp/cp_mi_sing_biodomes_util;
#using scripts/cp/cybercom/_cybercom_gadget;
#using scripts/cp/cybercom/_cybercom_gadget_security_breach;
#using scripts/cp/gametypes/_battlechatter;
#using scripts/cp/gametypes/_save;
#using scripts/shared/ai/archetype_warlord_interface;
#using scripts/shared/ai/robot_phalanx;
#using scripts/shared/ai/warlord;
#using scripts/shared/ai_shared;
#using scripts/shared/array_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/colors_shared;
#using scripts/shared/compass;
#using scripts/shared/exploder_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/fx_shared;
#using scripts/shared/gameobjects_shared;
#using scripts/shared/math_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/trigger_shared;
#using scripts/shared/util_shared;
#using scripts/shared/vehicle_ai_shared;
#using scripts/shared/vehicle_shared;
#using scripts/shared/vehicles/_siegebot;

#namespace cp_mi_sing_biodomes_warehouse;

// Namespace cp_mi_sing_biodomes_warehouse
// Params 0
// Checksum 0xd47420c9, Offset: 0x13d0
// Size: 0x3fc
function warehouse_main()
{
    foreach ( player in level.players )
    {
        player thread player_hijack_watcher();
    }
    
    level function_2d153737();
    level.ai_hendricks colors::enable();
    level.ai_hendricks.goalradius = 200;
    level scene::init( "cin_bio_05_02_warehouse_aie_activate" );
    level thread function_d1e71c2c();
    spawner::add_spawn_function_group( "warehouse_left_waiting", "script_noteworthy", &wait_for_sight_to_engage );
    spawner::add_spawn_function_group( "robot_warehouse_high", "script_string", &robots_crates_spawn );
    spawner::add_spawn_function_group( "warehouse_container_shooter", "targetname", &shoot_container );
    spawner::add_spawn_function_group( "wasps_warehouse", "script_noteworthy", &wasps_warehouse_spawn );
    spawner::add_spawn_function_group( "warehouse_enemy_warlord", "targetname", &function_4940548b );
    a_spawn_triggers = getentarray( "spawn_trigger", "script_parameters" );
    array::thread_all( a_spawn_triggers, &function_26edc5d7 );
    wait 0.5;
    level thread container_crash();
    level thread container_done();
    level thread function_16ff311a();
    level thread warehouse_warlord_surprise();
    level thread warehouse_warlord_friendly_goal();
    level thread wait_for_objective_complete();
    level thread back_door_shooters();
    level thread warehouse_phalanx();
    level thread function_3c56dee4();
    level thread function_2a08e741();
    level thread function_6fb5d6ef();
    level.ai_hendricks thread vo_warehouse_wasps();
    level.ai_hendricks thread hendricks_hero_moment( "right" );
    level.ai_hendricks thread hendricks_hero_moment( "left" );
    cp_mi_sing_biodomes_util::enable_traversals( 0, "warehouse_robot_exit_traversal", "targetname" );
    trigger::wait_till( "trig_back_door_close" );
    level back_door_close();
}

// Namespace cp_mi_sing_biodomes_warehouse
// Params 0
// Checksum 0x99ec1590, Offset: 0x17d8
// Size: 0x4
function precache()
{
    
}

// Namespace cp_mi_sing_biodomes_warehouse
// Params 2
// Checksum 0x5fc9b82, Offset: 0x17e8
// Size: 0x2ac
function objective_warehouse_init( str_objective, b_starting )
{
    cp_mi_sing_biodomes_util::objective_message( "objective_warehouse_init" );
    objectives::set( "cp_waypoint_breadcrumb", struct::get( "breadcrumb_warehouse" ) );
    objectives::hide( "cp_waypoint_breadcrumb" );
    
    if ( b_starting )
    {
        load::function_73adcefc();
        cp_mi_sing_biodomes_util::init_hendricks( str_objective );
        cp_mi_sing_biodomes::function_cef897cf( str_objective );
        level thread cp_mi_sing_biodomes_util::function_753a859( str_objective );
        objectives::set( "cp_level_biodomes_cloud_mountain" );
        trigger::use( "trig_markets2_colors_end_2" );
        array::delete_all( getentarray( "triggers_markets1", "script_noteworthy" ) );
        array::delete_all( getentarray( "triggers_markets2", "script_noteworthy" ) );
        level thread namespace_f1b4cbbc::function_fa2e45b8();
        level thread cp_mi_sing_biodomes_util::function_cc20e187( "markets2" );
        level thread cp_mi_sing_biodomes_util::function_cc20e187( "warehouse", 1 );
        var_6ecc8f2b = getent( "markets2_bridge_collision", "targetname" );
        var_6ecc8f2b delete();
        load::function_a2995f22();
    }
    
    level thread cp_mi_sing_biodomes_util::function_cc20e187( "cloudmountain", 1 );
    level.var_996e05eb = "friendly_spawns_warehouse_entrance";
    hidemiscmodels( "fxanim_markets1" );
    hidemiscmodels( "fxanim_nursery" );
    showmiscmodels( "fxanim_cloud_mountain" );
    cp_mi_sing_biodomes_markets::function_dbb91fcf();
    level thread warehouse_main();
}

// Namespace cp_mi_sing_biodomes_warehouse
// Params 4
// Checksum 0x4f77dd0e, Offset: 0x1aa0
// Size: 0x92
function objective_warehouse_done( str_objective, b_starting, b_direct, player )
{
    cp_mi_sing_biodomes_util::objective_message( "objective_warehouse_done" );
    objectives::complete( "cp_waypoint_breadcrumb", struct::get( "breadcrumb_warehouse" ) );
    objectives::complete( "cp_level_biodomes_cloud_mountain" );
    level notify( #"hash_43a6ada4" );
}

// Namespace cp_mi_sing_biodomes_warehouse
// Params 2
// Checksum 0x3121969f, Offset: 0x1b40
// Size: 0x34
function dev_warehouse_door_init( str_objective, b_starting )
{
    level thread dev_warehouse_door_func( str_objective, 2 );
}

// Namespace cp_mi_sing_biodomes_warehouse
// Params 2
// Checksum 0xfe59c37, Offset: 0x1b80
// Size: 0x34
function dev_warehouse_door_without_robots_init( str_objective, b_starting )
{
    level thread dev_warehouse_door_func( str_objective, 1 );
}

// Namespace cp_mi_sing_biodomes_warehouse
// Params 2
// Checksum 0x1a840c83, Offset: 0x1bc0
// Size: 0x1a4
function dev_warehouse_door_func( str_objective, n_squad )
{
    cp_mi_sing_biodomes_util::init_hendricks( str_objective );
    level cp_mi_sing_biodomes::function_cef897cf( str_objective, n_squad );
    level flag::wait_till( "first_player_spawned" );
    wait 2;
    spawner::simple_spawn( "warehouse_enemy_warlord", &warehouse_warlord_dev );
    level flag::set( "warehouse_warlord" );
    level thread clientfield::set( "warehouse_window_break", 1 );
    getent( "warehouse_overwatch_window", "targetname" ) delete();
    s_container = struct::get( "warehouse_surprise" );
    earthquake( 0.25, 0.5, s_container.origin, 1200 );
    cp_mi_sing_biodomes_util::enable_traversals( 0, "warehouse_robot_exit_traversal", "targetname" );
    level back_door_close();
}

// Namespace cp_mi_sing_biodomes_warehouse
// Params 0
// Checksum 0xca5d91e9, Offset: 0x1d70
// Size: 0x5c
function warehouse_warlord_dev()
{
    self.health = 100;
    self waittill( #"death" );
    level flag::set( "warehouse_warlord_dead" );
    level flag::set( "sm_warehouse_enemy_warlord_manager_cleared" );
}

// Namespace cp_mi_sing_biodomes_warehouse
// Params 0
// Checksum 0xbb673989, Offset: 0x1dd8
// Size: 0x40
function vo_warehouse_wasps()
{
    level flag::wait_till( "warehouse_wasps" );
    
    if ( isdefined( level.bzm_biodialogue2_3callback ) )
    {
        level thread [[ level.bzm_biodialogue2_3callback ]]();
    }
}

// Namespace cp_mi_sing_biodomes_warehouse
// Params 0
// Checksum 0x1ebbd9, Offset: 0x1e20
// Size: 0x1b4
function function_16ff311a()
{
    level waittill( #"container_done" );
    level spawn_manager::wait_till_cleared( "sm_warehouse_robot_jumpdown" );
    
    if ( !level flag::get( "left_path" ) && !level flag::get( "right_path" ) && !level flag::get( "center_path" ) )
    {
        level flag::set( "warehouse_intro_vo_started" );
        level thread function_1050699d();
        level.ai_hendricks dialog::say( "hend_which_way_do_we_go_0" );
        level dialog::remote( "kane_your_call_both_end_0" );
        battlechatter::function_d9f49fba( 1 );
        level flag::wait_till_any( array( "left_path", "right_path", "center_path" ) );
        level.ai_hendricks dialog::say( "hend_we_gotta_get_to_clou_0", 2 );
        battlechatter::function_d9f49fba( 1 );
    }
    
    level flag::set( "warehouse_intro_vo_done" );
}

// Namespace cp_mi_sing_biodomes_warehouse
// Params 0
// Checksum 0xa21382f9, Offset: 0x1fe0
// Size: 0x8c
function function_1050699d()
{
    level endon( #"left_path" );
    level endon( #"right_path" );
    level endon( #"center_path" );
    wait 14;
    a_dialogue_lines = [];
    a_dialogue_lines[ 0 ] = "hend_what_s_the_plan_lef_0";
    a_dialogue_lines[ 1 ] = "hend_c_mon_we_gotta_move_0";
    level.ai_hendricks dialog::say( cp_mi_sing_biodomes_util::vo_pick_random_line( a_dialogue_lines ) );
}

// Namespace cp_mi_sing_biodomes_warehouse
// Params 0
// Checksum 0xfc1fd080, Offset: 0x2078
// Size: 0x44
function function_2a08e741()
{
    level endon( #"back_door_closed" );
    level flag::wait_till( "xiulan_loudspeaker_go" );
    spawn_manager::enable( "warehouse_right_rear_runners" );
}

// Namespace cp_mi_sing_biodomes_warehouse
// Params 0
// Checksum 0x62aab753, Offset: 0x20c8
// Size: 0x8c
function robots_crates_spawn()
{
    self endon( #"death" );
    nd_start = getnode( self.target, "targetname" );
    
    if ( isdefined( nd_start ) )
    {
        self thread ai::force_goal( nd_start, 36, 1, "goal", 1, 1 );
    }
    
    self thread robot_jump_landing_exploder();
}

// Namespace cp_mi_sing_biodomes_warehouse
// Params 0
// Checksum 0x520752bf, Offset: 0x2160
// Size: 0x164
function robot_jump_landing_exploder()
{
    self endon( #"death" );
    self endon( #"crate_jump_landed" );
    t_exploders = getentarray( "trig_robot_jump_landing", "script_noteworthy" );
    
    while ( true )
    {
        foreach ( trigger in t_exploders )
        {
            if ( self istouching( trigger ) )
            {
                if ( trigger.targetname === "trig_warehouse_robot_landing_left" )
                {
                    exploder::exploder( "fx_warehouse_robot_jmp_dust_l" );
                }
                else if ( trigger.targetname === "trig_warehouse_robot_landing_right" )
                {
                    exploder::exploder( "fx_warehouse_robot_jmp_dust_r" );
                }
                
                self notify( #"crate_jump_landed" );
            }
        }
        
        wait 0.05;
    }
}

// Namespace cp_mi_sing_biodomes_warehouse
// Params 0
// Checksum 0x588abfe7, Offset: 0x22d0
// Size: 0x198
function warehouse_phalanx()
{
    level flag::wait_till( "container_drop" );
    v_start_left = struct::get( "phalanx_warehouse_left_start" ).origin;
    v_end_left = struct::get( "phalanx_warehouse_left_end" ).origin;
    v_start_right = struct::get( "phalanx_warehouse_right_start" ).origin;
    v_end_right = struct::get( "phalanx_warehouse_right_end" ).origin;
    n_phalanx = 1;
    
    if ( level.players.size >= 3 )
    {
        n_phalanx = 2;
    }
    
    phalanx_left = new robotphalanx();
    [[ phalanx_left ]]->initialize( "phanalx_wedge", v_start_left, v_end_left, 2, n_phalanx );
    phalanx_right = new robotphalanx();
    [[ phalanx_right ]]->initialize( "phanalx_wedge", v_start_right, v_end_right, 2, n_phalanx );
}

// Namespace cp_mi_sing_biodomes_warehouse
// Params 0
// Checksum 0xdd4ae11b, Offset: 0x2470
// Size: 0x1f4
function function_3c56dee4()
{
    level endon( #"center_path" );
    a_flags = [];
    a_flags[ 0 ] = "xiulan_loudspeaker_go";
    
    if ( level flag::get( "warehouse_intro_vo_started" ) )
    {
        a_flags[ 1 ] = "warehouse_intro_vo_done";
    }
    
    flag::wait_till_all( a_flags );
    var_f2fa33f7 = getentarray( "so_xiulan_warehouse_loudspeaker", "targetname" );
    
    foreach ( n_index, var_ea519684 in var_f2fa33f7 )
    {
        if ( n_index == var_f2fa33f7.size - 1 )
        {
            var_ea519684 dialog::say( "xiul_loyal_immortals_thi_0", 0, 1 );
            continue;
        }
        
        var_ea519684 thread dialog::say( "xiul_loyal_immortals_thi_0", 0, 1 );
    }
    
    level.ai_hendricks dialog::say( "hend_that_bitch_really_is_0" );
    level dialog::player_say( "plyr_you_shot_her_brother_0" );
    level.ai_hendricks dialog::say( "hend_i_should_have_shot_h_0" );
    battlechatter::function_d9f49fba( 1 );
}

// Namespace cp_mi_sing_biodomes_warehouse
// Params 0
// Checksum 0x3df8ae8e, Offset: 0x2670
// Size: 0x1e4
function wasps_warehouse_spawn()
{
    self endon( #"death" );
    self vehicle_ai::start_scripted();
    nd_start = getvehiclenode( self.target, "targetname" );
    self thread vehicle::get_on_and_go_path( nd_start );
    self waittill( #"reached_end_node" );
    v_pos = self getclosestpointonnavvolume( self.origin, 1024 );
    v_pos = ( v_pos[ 0 ], v_pos[ 1 ], v_pos[ 2 ] + randomintrange( 0, 72 ) );
    
    if ( isdefined( v_pos ) )
    {
        self setvehgoalpos( v_pos, 0 );
        self waittill( #"goal" );
    }
    
    e_volume = undefined;
    
    if ( self.script_aigroup == "wasps_warehouse_left" )
    {
        e_volume = getent( "volume_warehouse_wasps_left", "targetname" );
    }
    else if ( self.script_aigroup == "wasps_warehouse_right" )
    {
        e_volume = getent( "volume_warehouse_wasps_right", "targetname" );
    }
    
    self vehicle_ai::stop_scripted( "combat" );
    
    if ( isdefined( e_volume ) )
    {
        self setgoal( e_volume, 1 );
    }
}

// Namespace cp_mi_sing_biodomes_warehouse
// Params 0
// Checksum 0x9cc97847, Offset: 0x2860
// Size: 0x3c
function function_6fb5d6ef()
{
    level endon( #"warehouse_warlord_friendly_goal" );
    trigger::wait_for_either( "trig_warehouse_friendly_spawns_left", "trig_warehouse_friendly_spawns_right" );
    level.var_996e05eb = "friendly_spawns_warehouse_corner";
}

// Namespace cp_mi_sing_biodomes_warehouse
// Params 0
// Checksum 0x1db571ad, Offset: 0x28a8
// Size: 0x10e
function function_26edc5d7()
{
    self endon( #"death" );
    
    while ( true )
    {
        self waittill( #"trigger", ai_guy );
        
        if ( isdefined( ai_guy.owner ) && isplayer( ai_guy.owner ) || isplayer( ai_guy ) )
        {
            break;
        }
    }
    
    str_trigger_type = self.script_string;
    
    switch ( str_trigger_type )
    {
        default:
            str_spawner = self.script_noteworthy;
            spawner::simple_spawn( str_spawner );
            break;
        case "spawn_manager":
            spawn_manager::enable( self.script_noteworthy, 1 );
            break;
    }
}

// Namespace cp_mi_sing_biodomes_warehouse
// Params 1
// Checksum 0xdac9ba4, Offset: 0x29c0
// Size: 0x224
function hendricks_hero_moment( str_path )
{
    if ( str_path == "right" )
    {
        level endon( #"left_path" );
    }
    else
    {
        level endon( #"right_path" );
    }
    
    level trigger::wait_till( "trig_hero_sprint_" + str_path );
    
    if ( level flag::get( "warehouse_intro_vo_done" ) )
    {
        level.ai_hendricks thread dialog::say( "hend_moving_up_cover_me_1" );
    }
    
    ai_target = spawner::simple_spawn_single( "warehouse_hero_target_" + str_path );
    ai_target ai::set_ignoreme( 1 );
    ai_target ai::set_behavior_attribute( "can_become_rusher", 0 );
    ai_target.goalradius = 8;
    ai_target endon( #"death" );
    level thread scene::init( "scene_warehouse_hendricks_jump_" + str_path, "targetname", array( level.ai_hendricks, ai_target ) );
    level trigger::wait_till( "trig_hero_moment_" + str_path );
    
    if ( isalive( ai_target ) )
    {
        ai_target thread function_2b42cba3( "scene_warehouse_hendricks_jump_" + str_path );
        level scene::play( "scene_warehouse_hendricks_jump_" + str_path, "targetname", array( level.ai_hendricks, ai_target ) );
    }
    
    level.ai_hendricks clearforcedgoal();
}

// Namespace cp_mi_sing_biodomes_warehouse
// Params 1
// Checksum 0xb06a2040, Offset: 0x2bf0
// Size: 0x34
function function_2b42cba3( str_scene )
{
    self waittill( #"death" );
    level scene::stop( str_scene );
}

// Namespace cp_mi_sing_biodomes_warehouse
// Params 0
// Checksum 0x2523a330, Offset: 0x2c30
// Size: 0x114
function make_an_exit()
{
    level flag::wait_till_any( array( "warehouse_warlord_dead", "warehouse_warlord_retreated" ) );
    
    if ( isdefined( level.bzm_biodialogue2_4callback ) )
    {
        level thread [[ level.bzm_biodialogue2_4callback ]]();
    }
    
    level thread namespace_f1b4cbbc::function_973b77f9();
    objectives::show( "cp_waypoint_breadcrumb" );
    level thread squad_control::squad_assign_task_independent( "pry_door" );
    level dialog::remote( "kane_the_robots_should_be_0", 2 );
    level waittill( #"notetrack_warehouse_scene_done" );
    level flag::set( "back_door_opened" );
    level function_cb52a73();
    level squad_control_final_orders();
}

// Namespace cp_mi_sing_biodomes_warehouse
// Params 0
// Checksum 0xf2eab5cb, Offset: 0x2d50
// Size: 0xac
function function_cb52a73()
{
    level.ai_hendricks clearforcedgoal();
    level.ai_hendricks colors::enable();
    level.ai_hendricks.goalradius = 400;
    
    if ( flag::get( "cloudmountain_siegebots_dead" ) )
    {
        trigger::use( "trig_hendricks_lobby_entrance_colors", "targetname" );
        return;
    }
    
    trigger::use( "trig_siegebot_hendricks_b0", "targetname" );
}

// Namespace cp_mi_sing_biodomes_warehouse
// Params 0
// Checksum 0xac363859, Offset: 0x2e08
// Size: 0x1b2
function squad_control_final_orders()
{
    foreach ( player in level.players )
    {
        player notify( #"end_squad_control" );
    }
    
    foreach ( ai_robot in level.a_ai_squad )
    {
        if ( isalive( ai_robot ) )
        {
            ai_robot clearforcedgoal();
            ai_robot util::stop_magic_bullet_shield();
            ai_robot ai::set_behavior_attribute( "move_mode", "normal" );
            ai_robot ai::set_behavior_attribute( "sprint", 1 );
            ai_robot setgoal( getent( "back_door_goal_volume", "targetname" ) );
        }
    }
}

// Namespace cp_mi_sing_biodomes_warehouse
// Params 0
// Checksum 0xd0ed502d, Offset: 0x2fc8
// Size: 0x2ec
function shoot_container()
{
    self endon( #"death" );
    self ai::set_ignoreme( 1 );
    self ai::set_ignoreall( 1 );
    self.upaimlimit = 80;
    self setgoal( getent( "volume_wasps_warehouse_crate_shooters", "targetname" ), 1 );
    util::magic_bullet_shield( self );
    self util::waittill_notify_or_timeout( "goal", 2 );
    e_target = getent( "container_target", "targetname" );
    self ai::set_ignoreall( 0 );
    self thread ai::shoot_at_target( "normal", e_target, "tag_origin", 2 );
    level flag::wait_till_timeout( 3, "container_drop" );
    level flag::set( "container_drop" );
    util::stop_magic_bullet_shield( self );
    level flag::wait_till_any( array( "left_path", "right_path", "center_path" ) );
    self ai::set_ignoreme( 0 );
    self ai::set_ignoreall( 0 );
    
    if ( level flag::get( "left_path" ) )
    {
        self setgoal( getent( "warehouse_goal_volume_back_left", "targetname" ) );
        return;
    }
    
    if ( level flag::get( "right_path" ) )
    {
        self setgoal( getent( "warehouse_goal_volume_back_right", "targetname" ) );
        return;
    }
    
    if ( level flag::get( "center_path" ) )
    {
        self setgoal( getent( "warehouse_crate_shooters_center_goal", "targetname" ) );
    }
}

// Namespace cp_mi_sing_biodomes_warehouse
// Params 0
// Checksum 0xf490b69a, Offset: 0x32c0
// Size: 0x2c
function container_done()
{
    level waittill( #"container_done" );
    level flag::set( "container_done" );
}

// Namespace cp_mi_sing_biodomes_warehouse
// Params 0
// Checksum 0xacdd6b28, Offset: 0x32f8
// Size: 0x1ac
function container_crash()
{
    e_container_clip = getent( "container_drop_clip", "targetname" );
    var_d76c34c9 = getent( "container_pre_drop_clip", "targetname" );
    e_container_clip connectpaths();
    level flag::wait_till( "container_drop" );
    spawn_manager::enable( "sm_warehouse_robot_jumpdown" );
    level thread scene::play( "p7_fxanim_cp_biodomes_container_collapse_bundle" );
    level thread vo_warehouse_container();
    level waittill( #"container_hit_01" );
    var_d76c34c9 delete();
    level thread container_crushes_robots();
    e_container_clip disconnectpaths();
    wait 0.25;
    s_container = struct::get( "container_crash" );
    playsoundatposition( "evt_warlord_door_smash", s_container.origin );
    playrumbleonposition( "cp_biodomes_warehouse_container_rumble", s_container.origin );
}

// Namespace cp_mi_sing_biodomes_warehouse
// Params 0
// Checksum 0x26777c1b, Offset: 0x34b0
// Size: 0xb4
function vo_warehouse_container()
{
    level dialog::remote( "kane_woah_get_out_of_t_0" );
    level dialog::remote( "kane_tracking_enemy_units_0", 3 );
    level dialog::player_say( "plyr_tell_me_something_i_0" );
    level dialog::remote( "kane_i_ve_located_a_backd_0", 1 );
    battlechatter::function_d9f49fba( 1 );
    objectives::show( "cp_waypoint_breadcrumb" );
}

// Namespace cp_mi_sing_biodomes_warehouse
// Params 0
// Checksum 0x4368109, Offset: 0x3570
// Size: 0x106
function container_crushes_robots()
{
    a_robots = getaiteamarray( "allies" );
    e_container_clip = getent( "container_drop_clip", "targetname" );
    arrayremovevalue( a_robots, level.ai_hendricks );
    
    for ( i = 0; i < a_robots.size ; i++ )
    {
        if ( a_robots[ i ] istouching( e_container_clip ) )
        {
            util::stop_magic_bullet_shield( a_robots[ i ] );
            a_robots[ i ] kill();
        }
    }
    
    a_robots = [];
}

// Namespace cp_mi_sing_biodomes_warehouse
// Params 0
// Checksum 0x481ec7f7, Offset: 0x3680
// Size: 0x11c
function container_ambusher()
{
    self endon( #"death" );
    self setgoal( self.origin, 1, 1 );
    level flag::wait_till( "container_done" );
    self ai::set_behavior_attribute( "move_mode", "rambo" );
    nd_target = getnode( self.target, "targetname" );
    self setgoal( nd_target, 1 );
    self waittill( #"goal" );
    self ai::set_behavior_attribute( "move_mode", "normal" );
    wait 10;
    self setgoal( self.origin, 0, 1200 );
}

// Namespace cp_mi_sing_biodomes_warehouse
// Params 1
// Checksum 0x8b6c4287, Offset: 0x37a8
// Size: 0x184
function glass_break( str_trigger_name )
{
    t_glass = getent( str_trigger_name, "targetname" );
    
    if ( isdefined( t_glass ) )
    {
        t_glass flag::init( "glass_broken" );
        
        while ( isdefined( t_glass ) && t_glass flag::get( "glass_broken" ) == 0 )
        {
            t_glass trigger::wait_till();
            
            if ( isplayer( t_glass.who ) && ( !isplayer( t_glass.who ) || t_glass.who issprinting() ) )
            {
                glassradiusdamage( t_glass.origin, 100, 500, 500 );
                t_glass flag::set( "glass_broken" );
            }
            
            wait 0.05;
        }
        
        if ( isdefined( t_glass ) )
        {
            t_glass delete();
        }
    }
}

// Namespace cp_mi_sing_biodomes_warehouse
// Params 0
// Checksum 0x4cd3a1cf, Offset: 0x3938
// Size: 0x8c
function function_d1e71c2c()
{
    level endon( #"left_path" );
    level endon( #"center_path" );
    level flag::wait_till( "right_path" );
    level scene::init( "cin_bio_05_02_warehouse_vign_forklift_move" );
    trigger::wait_till( "forklift_vignette_start" );
    level scene::play( "cin_bio_05_02_warehouse_vign_forklift_move" );
}

// Namespace cp_mi_sing_biodomes_warehouse
// Params 0
// Checksum 0x64b77ced, Offset: 0x39d0
// Size: 0x34
function wait_for_objective_complete()
{
    trigger::wait_till( "trig_warehouse_objective_complete" );
    skipto::objective_completed( "objective_warehouse" );
}

// Namespace cp_mi_sing_biodomes_warehouse
// Params 0
// Checksum 0xa813710f, Offset: 0x3a10
// Size: 0x84
function back_door_shooters()
{
    trigger::wait_till( "trig_back_door_group" );
    spawner::simple_spawn( getentarray( "back_door_enemy", "script_aigroup" ) );
    getent( "back_door_look_trigger", "script_noteworthy" ) triggerenable( 1 );
}

// Namespace cp_mi_sing_biodomes_warehouse
// Params 0
// Checksum 0xbf85284b, Offset: 0x3aa0
// Size: 0x2ec
function back_door_close()
{
    level.mdl_door_upper = getent( "cloudmountain_door_upper", "targetname" );
    level.mdl_door_lower = getent( "cloudmountain_door_lower", "targetname" );
    level.mdl_door_upper.v_open_pos = level.mdl_door_upper.origin;
    level.mdl_door_lower.v_open_pos = level.mdl_door_lower.origin;
    level.mdl_door_upper movez( -40, 2 );
    level.mdl_door_lower movez( 60, 2 );
    level.mdl_door_upper playsound( "evt_warehouse_door_close_start" );
    level.mdl_door_upper playloopsound( "evt_warehouse_door_close_loop", 1 );
    level.mdl_door_lower waittill( #"movedone" );
    level.mdl_door_upper playsound( "evt_warehouse_door_close_stop" );
    level.mdl_door_upper stoploopsound( 0.5 );
    level flag::set( "back_door_closed" );
    var_60f8f46f = getent( "back_door_full_clip", "targetname" );
    var_60f8f46f movez( 128, 0.05 );
    var_bee08349 = getent( "back_door_no_pen_clip", "targetname" );
    var_bee08349 movez( 128, 0.05 );
    spawner::add_spawn_function_group( "cloud_mountain_siegebot", "targetname", &function_c001cefd );
    spawn_manager::enable( "cloud_mountain_siegebot_manager" );
    
    if ( isdefined( level.bzmutil_waitforallzombiestodie ) )
    {
        [[ level.bzmutil_waitforallzombiestodie ]]();
    }
    
    level thread back_door_ai_side();
    level thread cloud_mountain_crows();
    level thread make_an_exit();
    level add_open_door_action();
}

// Namespace cp_mi_sing_biodomes_warehouse
// Params 0
// Checksum 0xb7f5d94, Offset: 0x3d98
// Size: 0x27c
function warehouse_door_open()
{
    if ( !isdefined( level.mdl_door_upper ) || !isdefined( level.mdl_door_lower ) )
    {
        level.mdl_door_upper = getent( "cloudmountain_door_upper", "targetname" );
        level.mdl_door_lower = getent( "cloudmountain_door_lower", "targetname" );
    }
    
    level.mdl_door_upper moveto( level.mdl_door_upper.v_open_pos, 2 );
    level.mdl_door_lower moveto( level.mdl_door_lower.v_open_pos, 2 );
    level.mdl_door_upper playsound( "evt_warehouse_door_close_start" );
    level.mdl_door_upper playloopsound( "evt_warehouse_door_close_loop", 1 );
    level.mdl_door_lower waittill( #"movedone" );
    level.mdl_door_upper playsound( "evt_warehouse_door_close_stop" );
    level.mdl_door_upper stoploopsound( 0.5 );
    wait 3;
    level flag::set( "back_door_opened" );
    var_ec935bdb = getent( "back_door_player_clip", "targetname" );
    
    if ( isdefined( var_ec935bdb ) )
    {
        var_ec935bdb delete();
    }
    
    var_3dffb84b = getent( "back_door_full_clip", "targetname" );
    
    if ( isdefined( var_3dffb84b ) )
    {
        var_3dffb84b delete();
    }
    
    var_6f9ff65c = getent( "back_door_no_pen_clip", "targetname" );
    
    if ( isdefined( var_6f9ff65c ) )
    {
        var_6f9ff65c delete();
    }
}

// Namespace cp_mi_sing_biodomes_warehouse
// Params 0
// Checksum 0x5d782b5c, Offset: 0x4020
// Size: 0x12c
function function_c001cefd()
{
    self ai::set_ignoreme( 1 );
    self ai::set_ignoreall( 1 );
    self thread function_4a9bba52();
    self thread function_994b4243();
    level flag::wait_till_any( array( "back_door_opened", "siegebot_alerted" ) );
    self setcandamage( 1 );
    self.overridevehicledamage = &siegebot::siegebot_callback_damage;
    self ai::set_ignoreme( 0 );
    self ai::set_ignoreall( 0 );
    wait 0.5;
    trigger::use( "trig_warehouse_objective_complete", "targetname", level.activeplayers[ 0 ], 0 );
}

// Namespace cp_mi_sing_biodomes_warehouse
// Params 0
// Checksum 0x20542880, Offset: 0x4158
// Size: 0x64
function function_994b4243()
{
    self endon( #"back_door_opened" );
    self endon( #"siegebot_alerted" );
    self endon( #"death" );
    self waittill( #"ccom_lock_being_targeted", hijackingplayer );
    trigger::use( "trig_siegebot_alerted", "targetname" );
}

// Namespace cp_mi_sing_biodomes_warehouse
// Params 15
// Checksum 0x5a0af96b, Offset: 0x41c8
// Size: 0xb8
function function_c60cca3f( e_inflictor, e_attacker, n_damage, n_dflags, str_means_of_death, weapon, v_point, v_dir, str_hit_loc, v_damage_origin, psoffsettime, b_damage_from_underneath, n_model_index, str_part_name, v_surface_normal )
{
    trigger::use( "trig_siegebot_alerted", "targetname" );
    self.overridevehicledamage = &siegebot::siegebot_callback_damage;
    return n_damage;
}

// Namespace cp_mi_sing_biodomes_warehouse
// Params 0
// Checksum 0x8efa4d20, Offset: 0x4288
// Size: 0x74
function function_4a9bba52()
{
    level endon( #"back_door_opened" );
    self setcandamage( 0 );
    level flag::wait_till( "siegebot_damage_enabled" );
    self setcandamage( 1 );
    self.overridevehicledamage = &function_c60cca3f;
}

// Namespace cp_mi_sing_biodomes_warehouse
// Params 0
// Checksum 0x38b51ea2, Offset: 0x4308
// Size: 0x266
function back_door_ai_side()
{
    a_back_door_ai = getaiarray( "back_door_enemy", "script_aigroup" );
    
    foreach ( ai_back_door_enemy in a_back_door_ai )
    {
        if ( isalive( ai_back_door_enemy ) )
        {
            ai_back_door_enemy.ignoreme = 1;
            ai_back_door_enemy.ignoreall = 1;
        }
    }
    
    level util::waittill_either( "start_back_door_retreat", "siegebot_damage_enabled" );
    e_retreat_goal = getent( "back_door_goal_volume", "targetname" );
    
    foreach ( ai_back_door_enemy in a_back_door_ai )
    {
        if ( isalive( ai_back_door_enemy ) )
        {
            ai_back_door_enemy.ignoreme = 0;
            ai_back_door_enemy setgoal( e_retreat_goal, 1 );
        }
    }
    
    wait 10;
    
    foreach ( ai_back_door_enemy in a_back_door_ai )
    {
        if ( isalive( ai_back_door_enemy ) )
        {
            ai_back_door_enemy.ignoreall = 0;
        }
    }
}

// Namespace cp_mi_sing_biodomes_warehouse
// Params 0
// Checksum 0xb07d95c5, Offset: 0x4578
// Size: 0x8c
function wait_for_sight_to_engage()
{
    self endon( #"death" );
    self waittill( #"enemy" );
    wait 0.05;
    
    while ( isdefined( self.enemy ) && !self cansee( self.enemy ) )
    {
        wait 0.5;
    }
    
    self setgoal( getent( "entire_warehouse_setgoal_volume", "targetname" ) );
}

// Namespace cp_mi_sing_biodomes_warehouse
// Params 0
// Checksum 0x88044cdd, Offset: 0x4610
// Size: 0x1b4
function warehouse_warlord_surprise()
{
    level endon( #"warehouse_warlord_retreated" );
    trigger::wait_till( "trig_back_door_close" );
    savegame::checkpoint_save();
    wait 1.5;
    spawn_manager::enable( "warehouse_enemy_warlord_manager" );
    level waittill( #"warehouse_window_break" );
    level thread clientfield::set( "warehouse_window_break", 1 );
    level flag::set( "warehouse_warlord" );
    objectives::hide( "cp_waypoint_breadcrumb" );
    spawner::simple_spawn( "warehouse_enemy_group3", &warehouse_surprise_spawns );
    getent( "warehouse_overwatch_window", "targetname" ) delete();
    s_landing = struct::get( "warehouse_warlord_surprise_landing" );
    playrumbleonposition( "cp_biodomes_warehouse_warlord_rumble", s_landing.origin );
    level thread function_62523f1d();
    level spawn_manager::wait_till_cleared( "warehouse_enemy_warlord_manager" );
    level flag::set( "warehouse_warlord_dead" );
}

// Namespace cp_mi_sing_biodomes_warehouse
// Params 0
// Checksum 0xd16398f4, Offset: 0x47d0
// Size: 0x114
function warehouse_warlord_friendly_goal()
{
    level flag::wait_till( "warehouse_warlord_friendly_goal" );
    level.var_996e05eb = "friendly_spawns_warehouse_door";
    e_goal_volume = getent( "warehouse_warlord_friendly_volume", "targetname" );
    
    foreach ( ai_robot in level.a_ai_squad )
    {
        ai_robot setgoal( e_goal_volume, 1 );
    }
    
    level.ai_hendricks setgoal( e_goal_volume, 1 );
}

// Namespace cp_mi_sing_biodomes_warehouse
// Params 0
// Checksum 0xd06db8c8, Offset: 0x48f0
// Size: 0x2c
function warehouse_surprise_spawns()
{
    self endon( #"death" );
    self.ignoreall = 1;
    wait 1;
    self.ignoreall = 0;
}

// Namespace cp_mi_sing_biodomes_warehouse
// Params 0
// Checksum 0xd9e620a7, Offset: 0x4928
// Size: 0x10c
function function_4940548b()
{
    self endon( #"death" );
    self.ignoreall = 1;
    level scene::play( "cin_bio_05_02_warehouse_aie_jump", self );
    self.goalradius = 2048;
    self.goalheight = 320;
    self cp_mi_sing_biodomes_util::function_f61c0df8( "node_warlord_warehouse_preferred", 1, 3 );
    wait 0.25;
    self.ignoreall = 0;
    self trigger::wait_till( "trig_siegebot_alerted" );
    self warlordinterface::clearallpreferedpoints();
    self cp_mi_sing_biodomes_util::function_f61c0df8( "node_warlord_mountain_entrance_preferred", 1, 2 );
    self waittill( #"death" );
    self warlordinterface::clearallpreferedpoints();
}

// Namespace cp_mi_sing_biodomes_warehouse
// Params 0
// Checksum 0x82630e4f, Offset: 0x4a40
// Size: 0x84
function function_62523f1d()
{
    level endon( #"warehouse_warlord_dead" );
    trigger::wait_till( "trig_siegebot_alerted" );
    
    for ( var_7b95742a = 1; var_7b95742a ; var_7b95742a = function_5ecd2f63() )
    {
        wait 1;
    }
    
    level flag::set( "warehouse_warlord_retreated" );
}

// Namespace cp_mi_sing_biodomes_warehouse
// Params 0
// Checksum 0x828e666f, Offset: 0x4ad0
// Size: 0xec, Type: bool
function function_5ecd2f63()
{
    var_7c2eb0ca = getent( "warehouse_warlord_retreat_check_volume", "targetname" );
    var_bb2f0c05 = spawn_manager::get_ai( "warehouse_enemy_warlord_manager" );
    
    foreach ( e_warlord in var_bb2f0c05 )
    {
        if ( e_warlord istouching( var_7c2eb0ca ) )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace cp_mi_sing_biodomes_warehouse
// Params 0
// Checksum 0xd9949f03, Offset: 0x4bc8
// Size: 0x4c
function add_open_door_action()
{
    e_robot_task = getent( "pry_door", "script_noteworthy" );
    level thread squad_control::squad_control_task( e_robot_task );
}

// Namespace cp_mi_sing_biodomes_warehouse
// Params 0
// Checksum 0xc915523b, Offset: 0x4c20
// Size: 0x70
function player_hijack_watcher()
{
    self endon( #"disconnect" );
    level endon( #"hash_43a6ada4" );
    
    while ( true )
    {
        self waittill( #"clonedentity", e_clone );
        self cybercom_gadget_security_breach::setanchorvolume( getent( "hijacked_vehicle_range", "targetname" ) );
    }
}

// Namespace cp_mi_sing_biodomes_warehouse
// Params 0
// Checksum 0xd84c3a97, Offset: 0x4c98
// Size: 0x74
function cloud_mountain_crows()
{
    level thread clientfield::set( "cloud_mountain_crows", 1 );
    level flag::wait_till_any( array( "back_door_opened", "siegebot_damage_enabled" ) );
    level thread clientfield::set( "cloud_mountain_crows", 2 );
}

// Namespace cp_mi_sing_biodomes_warehouse
// Params 0
// Checksum 0x29a50914, Offset: 0x4d18
// Size: 0xea
function function_2d153737()
{
    if ( getdvarint( "tu1_biodomesWarehouseDisableTraversals", 1 ) )
    {
        nodes = getnodesinradius( ( 4805, 13582, 90 ), 12, 0, 12, "End" );
        
        foreach ( node in nodes )
        {
            setenablenode( node, 0 );
        }
    }
}

// Namespace cp_mi_sing_biodomes_warehouse
// Params 0
// Checksum 0x99ec1590, Offset: 0x4e10
// Size: 0x4
function on_player_spawned()
{
    
}

