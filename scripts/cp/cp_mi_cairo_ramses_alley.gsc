#using scripts/codescripts/struct;
#using scripts/cp/_dialog;
#using scripts/cp/_load;
#using scripts/cp/_objectives;
#using scripts/cp/_oed;
#using scripts/cp/_skipto;
#using scripts/cp/_spawn_manager;
#using scripts/cp/_util;
#using scripts/cp/cp_mi_cairo_ramses2_fx;
#using scripts/cp/cp_mi_cairo_ramses2_sound;
#using scripts/cp/cp_mi_cairo_ramses_accolades;
#using scripts/cp/cp_mi_cairo_ramses_arena_defend;
#using scripts/cp/cp_mi_cairo_ramses_utility;
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
#using scripts/shared/fx_shared;
#using scripts/shared/gameobjects_shared;
#using scripts/shared/hud_util_shared;
#using scripts/shared/math_shared;
#using scripts/shared/objpoints_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/trigger_shared;
#using scripts/shared/turret_shared;
#using scripts/shared/util_shared;
#using scripts/shared/vehicle_ai_shared;
#using scripts/shared/vehicle_shared;
#using scripts/shared/vehicles/_raps;

#namespace alley;

// Namespace alley
// Params 0
// Checksum 0xdbfb7e2d, Offset: 0xdc0
// Size: 0x5c
function alley_main()
{
    precache();
    level flag::wait_till( "first_player_spawned" );
    alley_battle_main();
    skipto::objective_completed( "alley" );
}

// Namespace alley
// Params 0
// Checksum 0xc096af60, Offset: 0xe28
// Size: 0x5e
function precache()
{
    level flag::init( "alley_event_started" );
    level flag::init( "alley_midpoint_reached" );
    level._effect[ "large_explosion" ] = "explosions/fx_exp_generic_lg";
}

// Namespace alley
// Params 0
// Checksum 0x1c60fe47, Offset: 0xe90
// Size: 0x214
function function_85ed7760()
{
    trigger::wait_till( "trig_player_alley_entrance" );
    level thread namespace_a6a248fc::function_1912af43();
    level thread namespace_a6a248fc::function_bd60b52a();
    battlechatter::function_d9f49fba( 0 );
    trigger::use( "trig_color_post_entrance", "targetname", undefined, 0 );
    level dialog::player_say( "plrf_kane_it_feels_a_lo_0", 2 );
    level dialog::remote( "kane_wait_i_think_0", 1 );
    level dialog::remote( "ecmd_ambush_we_have_a_b_0" );
    level dialog::player_say( "plrf_kane_sit_rep_are_0" );
    level dialog::remote( "kane_it_was_taylor_the_0", 3 );
    level.ai_hendricks dialog::say( "hend_kane_how_did_taylo_0", 0.5 );
    level dialog::remote( "tayr_she_s_telling_the_tr_0", 1 );
    level.ai_hendricks dialog::say( "hend_taylor_is_that_you_0" );
    level dialog::remote( "tayr_you_know_you_know_0" );
    level dialog::player_say( "plrf_kane_can_you_run_a_0", 1 );
    level dialog::remote( "kane_not_from_here_i_m_0", 1.5 );
    battlechatter::function_d9f49fba( 1 );
}

// Namespace alley
// Params 0
// Checksum 0xae615cf2, Offset: 0x10b0
// Size: 0x2f4
function alley_battle_main()
{
    spawner::add_spawn_function_group( "alley_wasps", "script_noteworthy", &init_alley_enemy_vehicle );
    spawner::add_spawn_function_group( "amws_enemy", "script_noteworthy", &init_alley_enemy_vehicle );
    spawner::add_spawn_function_group( "alley_egypt_intro_guy", "targetname", &function_1a98b08b, "alley_gone_hot" );
    spawner::add_spawn_function_group( "alley_nrc_intro_guy", "targetname", &function_1a98b08b, "alley_gone_hot" );
    spawner::add_spawn_function_group( "alley_nrc_front_guy", "targetname", &function_1a98b08b, "alley_gone_hot" );
    spawner::add_spawn_function_group( "alley_egypt_mid_guy", "targetname", &function_1a98b08b, "player_front_alley_end" );
    spawner::add_spawn_function_group( "alley_nrc_mid_guy", "targetname", &function_1a98b08b, "player_front_alley_end" );
    spawner::add_spawn_function_group( "alley_egypt_mid_guy", "targetname", &function_3631db68, "player_end_battle", "switching_alley_colors" );
    spawner::add_spawn_function_group( "alley_egypt_mid_retreat_guy", "targetname", &function_3631db68, "player_end_battle", "switching_alley_colors" );
    ramses_accolades::function_17a34ad1();
    level flag::set( "alley_event_started" );
    level thread arena_defend::stop_hunter_crash_fx_anims();
    level thread alley_objectives();
    level thread function_85ed7760();
    level thread function_ce0ce11f();
    level thread function_e9214214();
    alley_intro_battle();
    savegame::checkpoint_save();
    alley_end_battle();
    level notify( #"hash_6f120ac6" );
    ramses_accolades::function_cee86b3b();
}

// Namespace alley
// Params 1
// Checksum 0x8aa37956, Offset: 0x13b0
// Size: 0x94
function function_1a98b08b( str_flag )
{
    self endon( #"death" );
    self endon( #"hash_cb188399" );
    self thread function_d8dddf8e();
    self ramses_util::function_f08afb37();
    level flag::wait_till( str_flag );
    wait randomintrange( 1, 3 );
    self ramses_util::function_f08afb37( 0, 1 );
}

// Namespace alley
// Params 0
// Checksum 0xf96fc2e6, Offset: 0x1450
// Size: 0x54
function function_d8dddf8e()
{
    self endon( #"death" );
    self ai::set_behavior_attribute( "sprint", 1 );
    self waittill( #"goal" );
    self ai::set_behavior_attribute( "sprint", 0 );
}

// Namespace alley
// Params 2
// Checksum 0xb4e80b2c, Offset: 0x14b0
// Size: 0x74
function function_3631db68( str_flag, str_endon )
{
    if ( !isdefined( str_endon ) )
    {
        str_endon = "";
    }
    
    self endon( #"death" );
    self endon( str_endon );
    level flag::wait_till( str_flag );
    self colors::set_force_color( "b" );
}

// Namespace alley
// Params 0
// Checksum 0x7f7a71ac, Offset: 0x1530
// Size: 0x5c
function init_alley_enemy_vehicle()
{
    self endon( #"death" );
    e_fight_vol = getent( self.target, "targetname" );
    self setgoalpos( e_fight_vol.origin );
}

// Namespace alley
// Params 0
// Checksum 0x4c7edf9c, Offset: 0x1598
// Size: 0x364
function alley_intro_battle()
{
    level thread flak_exploders();
    trigger::wait_till( "trig_start_alley_intro" );
    level clientfield::set( "alley_fxanim_curtains", 1 );
    spawn_manager::enable( "sm_alley_egypt_intro" );
    spawn_manager::enable( "sm_alley_nrc_front" );
    spawner::simple_spawn( "alley_nrc_intro_guy" );
    
    foreach ( e_hero in level.heroes )
    {
        e_hero thread monitor_ai_alley_gone_hot();
    }
    
    foreach ( e_player in level.players )
    {
        e_player thread monitor_player_alley_gone_hot( "player_alley_start" );
    }
    
    level thread color_alley_movement_behavior_think();
    level thread function_88dbcef();
    level util::waittill_any_timeout( 30, "start_wasps", "intro_cleared" );
    level notify( #"hash_44ba5526" );
    spawn_manager::enable( "sm_alley_nrc_intro_wasp" );
    level flag::wait_till( "player_mid_alley" );
    level thread namespace_a6a248fc::function_767cbb3e();
    level thread hendricks_alley_movement();
    level thread function_f4c9aec9();
    level scene::init( "cin_ram_06_05_safiya_1st_friendlydown_init" );
    spawn_manager::kill( "sm_alley_egypt_intro" );
    spawn_manager::enable( "sm_alley_egypt_mid" );
    spawn_manager::enable( "sm_alley_nrc_mid" );
    spawn_manager::enable( "sm_alley_nrc_mid_wasp" );
    level flag::wait_till( "start_retreat_scenes" );
    level thread wounded_crawl_scene_01();
    level thread function_8dad6b29();
}

// Namespace alley
// Params 0
// Checksum 0x411195d4, Offset: 0x1908
// Size: 0x44
function function_f4c9aec9()
{
    level endon( #"start_retreat_scenes" );
    trigger::wait_till( "trig_start_retreat_scenes" );
    level flag::set( "start_retreat_scenes" );
}

// Namespace alley
// Params 0
// Checksum 0x81b89e61, Offset: 0x1958
// Size: 0x64
function function_8dad6b29()
{
    spawner::simple_spawn( "alley_egypt_mid_retreat_guy" );
    level util::waittill_notify_or_timeout( "force_flanker_spawns", 3 );
    spawner::simple_spawn( "alley_nrc_mid_flanker" );
    wounded_help_scene_01();
}

// Namespace alley
// Params 0
// Checksum 0xd76e6968, Offset: 0x19c8
// Size: 0x32
function function_88dbcef()
{
    spawner::waittill_ai_group_amount_killed( "alley_nrc_intro", 4 );
    level notify( #"start_wasps" );
}

// Namespace alley
// Params 0
// Checksum 0x79a7e559, Offset: 0x1a08
// Size: 0x13c
function color_alley_movement_behavior_think()
{
    level flag::wait_till( "alley_gone_hot" );
    trigger::use( "trig_color_alley_intro", "targetname", undefined, 0 );
    spawner::waittill_ai_group_amount_killed( "alley_nrc_intro", 4 );
    trigger::use( "trig_color_alley_front", "targetname", undefined, 0 );
    n_intro_nrc_count = spawner::get_ai_group_sentient_count( "alley_nrc_intro" );
    
    while ( n_intro_nrc_count >= 2 && !level flag::get( "player_mid_alley" ) )
    {
        n_intro_nrc_count = spawner::get_ai_group_sentient_count( "alley_nrc_intro" );
        wait 0.25;
    }
    
    trigger::use( "trig_color_alley_mid", "targetname", undefined, 0 );
}

// Namespace alley
// Params 1
// Checksum 0xb9dfa4cd, Offset: 0x1b50
// Size: 0xb8
function monitor_player_alley_gone_hot( str_flag_wait )
{
    self endon( #"disconnect" );
    self.ignoreme = 1;
    level flag::clear( "alley_gone_hot" );
    level flag::wait_till( str_flag_wait );
    self thread monitor_alley_flank_player_gunfire();
    level thread monitor_alley_flank_timeout();
    level flag::wait_till( "alley_gone_hot" );
    self.ignoreme = 0;
}

// Namespace alley
// Params 0
// Checksum 0xfb9f0c6b, Offset: 0x1c10
// Size: 0x34
function monitor_alley_flank_timeout()
{
    level endon( #"alley_gone_hot" );
    wait 15;
    level flag::set( "alley_gone_hot" );
}

// Namespace alley
// Params 0
// Checksum 0x826a62bd, Offset: 0x1c50
// Size: 0x3c
function monitor_alley_flank_player_gunfire()
{
    level endon( #"alley_gone_hot" );
    self waittill( #"weapon_fired" );
    level flag::set( "alley_gone_hot" );
}

// Namespace alley
// Params 0
// Checksum 0x35ddc5fc, Offset: 0x1c98
// Size: 0x64
function monitor_ai_alley_gone_hot()
{
    self endon( #"death" );
    
    if ( !isdefined( self ) )
    {
        return;
    }
    
    self.ignoreme = 1;
    self.ignoreall = 1;
    level flag::wait_till( "alley_gone_hot" );
    self.ignoreme = 0;
    self.ignoreall = 0;
}

// Namespace alley
// Params 0
// Checksum 0x5e08327b, Offset: 0x1d08
// Size: 0x94
function rooftop_guy_run_and_delete()
{
    self endon( #"death" );
    wait randomintrange( 1, 3 );
    nd_delete = getnode( "rooftop_delete_node", "targetname" );
    self thread ai::force_goal( nd_delete, 32 );
    self waittill( #"goal" );
    self delete();
}

// Namespace alley
// Params 0
// Checksum 0x4fd669bd, Offset: 0x1da8
// Size: 0x4dc
function hendricks_alley_movement()
{
    a_rooftop_guys = spawner::get_ai_group_ai( "alley_egypt_intro_roofop" );
    
    foreach ( e_guy in a_rooftop_guys )
    {
        e_guy thread rooftop_guy_run_and_delete();
    }
    
    var_d6395e7f = getnodearray( "hendricks_jump_traversal", "script_noteworthy" );
    
    foreach ( node in var_d6395e7f )
    {
        setenablenode( node, 0 );
    }
    
    function_25db07ad();
    level.ai_hendricks colors::disable();
    level.ai_hendricks ai::set_behavior_attribute( "sprint", 1 );
    nd_hendricks_alley_far = getnode( "hendricks_alley_far", "targetname" );
    level.ai_hendricks thread ai::force_goal( nd_hendricks_alley_far, 64 );
    level.ai_hendricks waittill( #"goal" );
    
    foreach ( node in var_d6395e7f )
    {
        setenablenode( node, 1 );
    }
    
    var_3715568c = getnode( "hendricks_alley_jump", "targetname" );
    level.ai_hendricks thread ai::force_goal( var_3715568c, 64 );
    level.ai_hendricks waittill( #"goal" );
    level.ai_hendricks ai::set_behavior_attribute( "sprint", 0 );
    function_42725e9e();
    level.ai_hendricks colors::enable();
    spawn_manager::wait_till_ai_remaining( "sm_alley_nrc_end", 4 );
    level thread function_71d278f4( 6 );
    spawn_manager::wait_till_ai_remaining( "sm_alley_nrc_end", 1 );
    a_ai_allies = getaiteamarray( "allies" );
    arrayremovevalue( a_ai_allies, level.ai_hendricks );
    
    foreach ( ai in a_ai_allies )
    {
        ai notify( #"switching_alley_colors" );
        
        if ( isdefined( ai colors::get_force_color() ) )
        {
            ai colors::set_force_color( "c" );
        }
    }
    
    level thread function_71d278f4( 5 );
    trigger::use( "trig_color_alley_end", undefined, undefined, 0 );
    a_ai_allies = undefined;
}

// Namespace alley
// Params 0
// Checksum 0xfb747827, Offset: 0x2290
// Size: 0x4c
function function_25db07ad()
{
    level endon( #"hash_7721f10" );
    spawn_manager::wait_till_ai_remaining( "sm_alley_nrc_mid", 1 );
    level flag::set( "start_retreat_scenes" );
}

// Namespace alley
// Params 0
// Checksum 0x3c0904aa, Offset: 0x22e8
// Size: 0xbc
function function_42725e9e()
{
    if ( !level flag::get( "dead_alley_complete" ) && !level flag::get( "player_at_sinkhole" ) )
    {
        level endon( #"player_at_sinkhole" );
        level endon( #"dead_alley_complete" );
        spawner::waittill_ai_group_amount_killed( "back_alley_nrc_flankers", 1 );
        spawner::waittill_ai_group_ai_count( "back_alley_nrc_flankers", 1 );
        trigger::use( "trig_start_back_alley", "targetname" );
    }
}

// Namespace alley
// Params 0
// Checksum 0x7ad9d82a, Offset: 0x23b0
// Size: 0x194
function alley_end_battle()
{
    level thread function_71d278f4( 9 );
    level flag::wait_till( "player_end_battle" );
    spawner::simple_spawn( "alley_nrc_end_frontline" );
    spawn_manager::enable( "sm_alley_nrc_end" );
    spawn_manager::enable( "sm_alley_nrc_end_wasp" );
    spawner::simple_spawn( "alley_nrc_end_amws" );
    level flag::wait_till( "dead_alley_complete" );
    level thread dialog::remote( "kane_systems_are_still_pr_0" );
    spawn_manager::kill( "sm_alley_egypt_mid", 1 );
    level thread namespace_a6a248fc::function_973b77f9();
    level.ai_hendricks colors::disable();
    nd_hendricks_pre_vtol = getnode( "hendricks_pre_vtol", "targetname" );
    level.ai_hendricks thread ai::force_goal( nd_hendricks_pre_vtol, 32 );
    level thread alley_cleanup();
}

// Namespace alley
// Params 0
// Checksum 0x83029d7c, Offset: 0x2550
// Size: 0x234
function function_e9214214()
{
    level waittill( #"hash_c00a7aee" );
    var_f377c056 = getnode( "table_flip_node", "targetname" );
    setenablenode( var_f377c056, 0 );
    ai_actor = spawner::simple_spawn_single( "alley_table_flipper" );
    ai_actor endon( #"death" );
    ai_actor setgoal( ai_actor.origin, 1, 32 );
    ai_actor ai::set_ignoreall( 1 );
    ai_actor ai::set_ignoreme( 1 );
    level scene::init( "cin_gen_aie_table_flip", ai_actor );
    level flag::wait_till( "player_front_alley_end" );
    util::magic_bullet_shield( ai_actor );
    level flag::wait_till( "start_retreat_scenes" );
    level scene::play( "cin_gen_aie_table_flip", ai_actor );
    setenablenode( var_f377c056, 1 );
    ai_actor ai::set_behavior_attribute( "disablearrivals", 1 );
    ai_actor clearforcedgoal();
    ai_actor setgoal( var_f377c056, 0, 64 );
    ai_actor ai::set_ignoreall( 0 );
    ai_actor ai::set_ignoreme( 0 );
    util::stop_magic_bullet_shield( ai_actor );
}

// Namespace alley
// Params 0
// Checksum 0xabc5f337, Offset: 0x2790
// Size: 0x6c
function wounded_crawl_scene_01()
{
    trigger::wait_till( "trig_wounded_crawl_scene_01" );
    ai_actor = spawner::simple_spawn_single( "wounded_crawl_01_actor" );
    level scene::play( "wounded_crawl_scene_01", "targetname", ai_actor );
}

// Namespace alley
// Params 0
// Checksum 0xd77f2330, Offset: 0x2808
// Size: 0x1dc
function wounded_help_scene_01()
{
    a_actors = spawner::simple_spawn( "wounded_help_01_actor", &ai::set_ignoreall, 1 );
    
    foreach ( ai in a_actors )
    {
        ai util::magic_bullet_shield();
        ai ai::set_behavior_attribute( "cqb", 1 );
        ai setgoal( struct::get( "wounded_help_scene_01" ).origin, 1, 64 );
    }
    
    array::wait_till( a_actors, "goal" );
    
    foreach ( ai in a_actors )
    {
        ai util::stop_magic_bullet_shield();
    }
    
    level scene::play( "wounded_help_scene_01", "targetname", a_actors );
}

// Namespace alley
// Params 0
// Checksum 0x77eca6c6, Offset: 0x29f0
// Size: 0x3ec
function function_ce0ce11f()
{
    var_3fad69d2 = getnodearray( "alley_post_rocket_attack_node", "targetname" );
    
    foreach ( node in var_3fad69d2 )
    {
        setenablenode( node, 0 );
    }
    
    scene::init( "cin_ram_06_01_safiya_vign_killed" );
    trigger::wait_till( "trigger_rocket_attack" );
    weapon = getweapon( "quadtank_main_turret_rocketpods_straight" );
    var_5513d70a = struct::get_array( "alley_rocket_extra_launch_points", "script_noteworthy" );
    
    for ( i = 1; i <= var_5513d70a.size ; i++ )
    {
        var_1cb0b6fb = getent( "alley_extra_target_" + i, "targetname" );
        var_1cb0b6fb.health = 100;
        var_90c119b0 = struct::get( "alley_extra_launch_point_" + i ).origin;
        magicbullet( weapon, var_90c119b0, var_1cb0b6fb.origin, undefined, var_1cb0b6fb );
        wait 0.35;
    }
    
    e_target = getent( "alley_rocket_target", "targetname" );
    e_target.health = 100;
    v_rocket_launch = struct::get( "alley_rocket_launch_point" ).origin;
    e_rocket = magicbullet( weapon, v_rocket_launch, e_target.origin, undefined, e_target );
    
    while ( distancesquared( e_rocket.origin, e_target.origin ) > 62500 )
    {
        wait 0.05;
    }
    
    scene::play( "cin_ram_06_01_safiya_vign_killed" );
    
    foreach ( node in var_3fad69d2 )
    {
        setenablenode( node, 1 );
    }
    
    e_target delete();
    var_1cb0b6fb delete();
    level notify( #"hash_c00a7aee" );
    hunter_crash_fx_anims();
}

// Namespace alley
// Params 0
// Checksum 0xadaf45ac, Offset: 0x2de8
// Size: 0x54
function flak_exploders()
{
    trigger::wait_till( "trig_start_alley_intro" );
    level flag::set( "flak_arena_defend_stop" );
    level thread ramses_util::alley_flak_exploder();
}

// Namespace alley
// Params 0
// Checksum 0xd4fd262c, Offset: 0x2e48
// Size: 0x24
function hunter_crash_fx_anims()
{
    level clientfield::set( "alley_fxanim_hunters", 1 );
}

// Namespace alley
// Params 0
// Checksum 0x90fe1041, Offset: 0x2e78
// Size: 0x24
function stop_hunter_crash_fx_anims()
{
    level clientfield::set( "alley_fxanim_hunters", 0 );
}

// Namespace alley
// Params 0
// Checksum 0xff0ac85e, Offset: 0x2ea8
// Size: 0x194
function alley_objectives()
{
    var_b32b0647 = struct::get( "alley_intro_objective" );
    var_8d669714 = struct::get( "alley_middle_objective" );
    s_end = struct::get( "alley_end_objective" );
    objectives::set( "cp_waypoint_breadcrumb", var_b32b0647 );
    level flag::wait_till( "player_alley_start" );
    objectives::complete( "cp_waypoint_breadcrumb", var_b32b0647 );
    objectives::set( "cp_waypoint_breadcrumb", var_8d669714 );
    level flag::wait_till( "player_front_alley_end" );
    objectives::complete( "cp_waypoint_breadcrumb", var_8d669714 );
    objectives::set( "cp_waypoint_breadcrumb", s_end );
    level flag::wait_till( "dead_alley_complete" );
    objectives::complete( "cp_waypoint_breadcrumb", s_end );
}

// Namespace alley
// Params 0
// Checksum 0xe0c1b1a1, Offset: 0x3048
// Size: 0x17a
function alley_cleanup()
{
    level thread function_71d278f4( 4 );
    
    if ( isdefined( level.ai_khalil ) )
    {
        level.ai_khalil delete();
    }
    
    cleanup_arena_defend_vehicles();
    spawn_manager::kill( "sm_alley_nrc_intro", 1 );
    spawn_manager::kill( "sm_alley_nrc_mid", 1 );
    a_ai = getaiteamarray( "axis", "allies" );
    level flag::wait_till( "vtol_igc_trigger_used" );
    
    foreach ( e_ai in a_ai )
    {
        if ( isdefined( e_ai ) && e_ai != level.ai_hendricks )
        {
            e_ai delete();
        }
    }
}

// Namespace alley
// Params 0
// Checksum 0xc43c1da8, Offset: 0x31d0
// Size: 0xf2
function cleanup_arena_defend_vehicles()
{
    a_vh = getentarray( "veh_vtol_ride_player_truck_vh", "targetname" );
    
    foreach ( vh in a_vh )
    {
        vh.delete_on_death = 1;
        vh notify( #"death" );
        
        if ( !isalive( vh ) )
        {
            vh delete();
        }
    }
}

// Namespace alley
// Params 1
// Checksum 0x6bbfd96c, Offset: 0x32d0
// Size: 0x1ea
function function_71d278f4( var_71905650 )
{
    level notify( #"hash_c423ca59" );
    level endon( #"vtol_igc_trigger_used" );
    level endon( #"hash_c423ca59" );
    var_30e37099 = struct::get( "alley_end_objective" ).origin;
    
    while ( true )
    {
        var_f72a8f03 = arraycombine( spawner::get_ai_group_ai( "alley_egypt_intro" ), spawner::get_ai_group_ai( "alley_egypt_mid" ), 0, 0 );
        var_51e5da07 = var_f72a8f03.size - var_71905650;
        
        if ( var_51e5da07 > 0 )
        {
            a_ai_to_delete = arraysort( var_f72a8f03, var_30e37099, 0, var_51e5da07 );
            
            while ( a_ai_to_delete.size > 0 )
            {
                for ( i = 0; i < a_ai_to_delete.size ; i++ )
                {
                    if ( isdefined( a_ai_to_delete[ i ] ) )
                    {
                        a_ai_to_delete[ i ] colors::disable();
                        a_ai_to_delete[ i ] thread wait_to_delete( 200 );
                        continue;
                    }
                    
                    arrayremoveindex( a_ai_to_delete, i );
                }
                
                array::wait_till( a_ai_to_delete, "delete_success", 10 );
                wait 0.05;
                break;
            }
            
            continue;
        }
        
        wait 1;
    }
}

// Namespace alley
// Params 1
// Checksum 0x7ac8746d, Offset: 0x34c8
// Size: 0x15c
function wait_to_delete( n_dist )
{
    self notify( #"hash_a348be44" );
    self endon( #"death" );
    self endon( #"hash_a348be44" );
    b_can_delete = 0;
    
    while ( b_can_delete == 0 )
    {
        foreach ( player in level.players )
        {
            if ( distance( self.origin, player.origin ) > n_dist && player util::is_player_looking_at( self.origin, undefined, 0 ) == 0 )
            {
                b_can_delete = 1;
            }
        }
        
        if ( b_can_delete == 0 )
        {
            wait 1;
        }
    }
    
    self notify( #"delete_success" );
    self delete();
}

