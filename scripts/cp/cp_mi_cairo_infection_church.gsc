#using scripts/codescripts/struct;
#using scripts/cp/_dialog;
#using scripts/cp/_load;
#using scripts/cp/_mobile_armory;
#using scripts/cp/_objectives;
#using scripts/cp/_quadtank_util;
#using scripts/cp/_skipto;
#using scripts/cp/_spawn_manager;
#using scripts/cp/_util;
#using scripts/cp/cp_mi_cairo_infection2_sound;
#using scripts/cp/cp_mi_cairo_infection_accolades;
#using scripts/cp/cp_mi_cairo_infection_util;
#using scripts/cp/cp_mi_cairo_infection_village_surreal;
#using scripts/cp/gametypes/coop;
#using scripts/shared/ai_shared;
#using scripts/shared/array_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/hud_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/trigger_shared;
#using scripts/shared/util_shared;
#using scripts/shared/vehicle_shared;
#using scripts/shared/vehicles/_quadtank;

#namespace church;

// Namespace church
// Params 0
// Checksum 0xbc0802de, Offset: 0xaa0
// Size: 0x64
function init_client_field_callback_funcs()
{
    clientfield::register( "world", "light_church_int_cath_all", 1, 1, "int" );
    clientfield::register( "world", "toggle_cathedral_fog_banks", 1, 1, "int" );
}

// Namespace church
// Params 4
// Checksum 0x1a022df5, Offset: 0xb10
// Size: 0x4c
function cleanup_church( str_objective, b_starting, b_direct, player )
{
    array::thread_all( level.players, &infection_util::player_leave_cinematic );
}

// Namespace church
// Params 4
// Checksum 0x1bda99a2, Offset: 0xb68
// Size: 0x7c
function cleanup_cathedral( str_objective, b_starting, b_direct, player )
{
    infection_util::enable_exploding_deaths( 0 );
    array::thread_all( level.players, &infection_util::player_leave_cinematic );
    level thread all_remaining_enemies_die_off();
}

// Namespace church
// Params 2
// Checksum 0x166bc975, Offset: 0xbf0
// Size: 0x2ec
function main_church( str_objective, b_starting )
{
    if ( b_starting )
    {
        load::function_73adcefc();
    }
    
    level thread church_doors_close();
    scene::add_scene_func( "p7_fxanim_cp_infection_church_explode_01_bundle", &function_9ad74a02, "play" );
    scene::add_scene_func( "p7_fxanim_cp_infection_church_explode_02_bundle", &scene_callback_tank_start_2, "play" );
    scene::add_scene_func( "p7_fxanim_cp_infection_church_tank_02_bundle", &scene_callback_tank_end_2, "done" );
    scene::add_scene_func( "cin_inf_11_04_fold_vign_walk_end_unreveal", &function_8c83aff9, "play" );
    ai_objective_sarah = util::get_hero( "sarah" );
    
    if ( b_starting )
    {
        init_church();
        load::function_a2995f22();
    }
    
    array::thread_all( level.players, &infection_util::player_enter_cinematic );
    
    if ( b_starting )
    {
        ai_objective_sarah thread scene::play( "cin_inf_11_04_fold_vign_walk_end", ai_objective_sarah );
    }
    
    if ( isdefined( level.bzm_infectiondialogue22callback ) )
    {
        level thread [[ level.bzm_infectiondialogue22callback ]]();
    }
    
    level clientfield::set( "kill_light_church_ext_window", 1 );
    wait 2;
    ai_objective_sarah thread scene::play( "cin_inf_11_04_fold_vign_walk_end_unreveal", ai_objective_sarah );
    wait 3;
    level thread scene::play( "p7_fxanim_cp_infection_church_tank_01_bundle" );
    level thread scene::play( "p7_fxanim_cp_infection_church_explode_01_bundle" );
    level waittill( #"hash_29e5a19f" );
    level thread scene::play( "p7_fxanim_cp_infection_church_tank_02_bundle" );
    level thread scene::play( "p7_fxanim_cp_infection_church_explode_02_bundle" );
    warp_players_inside_cathedral();
    level waittill( #"light_church_int_cath_all_off" );
    level clientfield::set( "light_church_int_all", 0 );
    level clientfield::set( "light_church_int_cath_all", 0 );
}

// Namespace church
// Params 1
// Checksum 0xbd3e7d26, Offset: 0xee8
// Size: 0x5c
function function_8c83aff9( a_ents )
{
    a_ents[ "sarah" ] clientfield::set( "sarah_body_light", 0 );
    a_ents[ "sarah" ] thread infection_util::actor_camo( 1 );
}

// Namespace church
// Params 2
// Checksum 0x88c5e286, Offset: 0xf50
// Size: 0x1dc
function main_cathedral( str_objective, b_starting )
{
    if ( b_starting )
    {
        load::function_73adcefc();
    }
    
    setup_spawners();
    cathedral_scene_setup();
    trig = getent( "cathedral_sarah_at_altar", "targetname" );
    trig triggerenable( 0 );
    exploder::exploder( "fx_light_cathedral_lightning" );
    exploder::exploder( "cathedral_alter_candle_lights" );
    
    if ( b_starting )
    {
        load::function_a2995f22();
        spawn_quad_tank();
    }
    
    infection_accolades::function_211b07c5();
    
    if ( level.players.size > 0 )
    {
        battle_in_cathedral();
    }
    
    level flag::wait_till( "cathedral_quad_tank_destroyed" );
    objectives::complete( "cp_level_infection_destroy_quadtank" );
    util::delay( 2, undefined, &infection_accolades::function_2c8ffdaf );
    wait_enemy_cleared();
    
    if ( isdefined( level.bzmutil_waitforallzombiestodie ) )
    {
        [[ level.bzmutil_waitforallzombiestodie ]]();
    }
    
    sarah_appears();
    wait_for_players_to_approach_sarah();
    sarah_vignette_in_cathedral();
}

// Namespace church
// Params 0
// Checksum 0xb0d61209, Offset: 0x1138
// Size: 0x5c
function vo_intro_quad_tank()
{
    level dialog::player_say( "plyr_what_the_fuck_0", 1 );
    level thread dialog::remote( "hall_brute_force_somet_0", 0, "NO_DNI" );
}

// Namespace church
// Params 2
// Checksum 0x10b5ceb6, Offset: 0x11a0
// Size: 0x9c
function dev_cathedral_outro( str_objective, b_starting )
{
    level flag::init( "sarah_distance_objective" );
    level thread cathedral_scene_setup();
    sarah_appears();
    wait_for_players_to_approach_sarah();
    sarah_vignette_in_cathedral();
    level thread skipto::objective_completed( "dev_cathedral_outro" );
}

// Namespace church
// Params 4
// Checksum 0xad6bd776, Offset: 0x1248
// Size: 0x24
function dev_cathedral_outro_cleanup( str_objective, b_starting, b_direct, player )
{
    
}

// Namespace church
// Params 0
// Checksum 0x6c2cca6, Offset: 0x1278
// Size: 0xbc
function setup_spawners()
{
    spawner::add_spawn_function_group( "sm_cathedral_guys", "script_noteworthy", &infection_util::set_goal_on_spawn );
    spawner::add_spawn_function_group( "sm_cathedral_guys", "script_noteworthy", &ai_accuracy );
    infection_util::enable_exploding_deaths( 1 );
    level flag::init( "cathedral_quad_tank_destroyed" );
    level flag::init( "sarah_distance_objective" );
}

// Namespace church
// Params 0
// Checksum 0x97cd6035, Offset: 0x1340
// Size: 0x6c
function init_church()
{
    scene::add_scene_func( "p7_fxanim_cp_infection_church_explode_01_bundle", &scene_func_fxanim_church_setup, "init" );
    scene::init( "p7_fxanim_cp_infection_church_explode_01_bundle" );
    level clientfield::set( "light_church_int_cath_all", 1 );
}

// Namespace church
// Params 1
// Checksum 0xf9fe026f, Offset: 0x13b8
// Size: 0x24
function scene_func_fxanim_church_setup( a_ents )
{
    a_ents[ 0 ] setforcenocull();
}

// Namespace church
// Params 1
// Checksum 0x7235b36c, Offset: 0x13e8
// Size: 0x1a4
function spawn_quad_tank( e_reference )
{
    array::thread_all( level.activeplayers, &coop::function_e9f7384d );
    sp_quad_tank = getent( "quad_tank_cathedral", "script_noteworthy" );
    vh_quad_tank = spawner::simple_spawn_single( sp_quad_tank, &function_526e9212 );
    
    if ( isdefined( e_reference ) )
    {
        vh_quad_tank.origin = e_reference.origin;
        vh_quad_tank.angles = e_reference.angles;
    }
    
    scene::add_scene_func( "cin_inf_11_05_fold_vign_qtbirth", &scene_qtbirth_end, "done" );
    level thread scene::play( "cin_inf_11_05_fold_vign_qtbirth", vh_quad_tank );
    level thread scene::play( "cin_inf_11_05_fold_vign_tigertank" );
    level thread vo_intro_quad_tank();
    e_goal_volume = getent( "quadtank_goal_volume", "targetname" );
    vh_quad_tank setgoal( e_goal_volume );
}

// Namespace church
// Params 1
// Checksum 0xc0cf87b2, Offset: 0x1598
// Size: 0x1a
function scene_qtbirth_end( a_ent )
{
    level notify( #"scene_qtbirth_end" );
}

// Namespace church
// Params 0
// Checksum 0x249acbe3, Offset: 0x15c0
// Size: 0x104
function function_526e9212()
{
    self util::set_rogue_controlled();
    self quadtank::quadtank_weakpoint_display( 0 );
    self waittill( #"turn_on" );
    self quadtank::quadtank_on();
    level waittill( #"scene_qtbirth_end" );
    self quadtank::quadtank_weakpoint_display( 1 );
    self thread quadtank_trophy_system_watcher();
    self thread church_pillars_explode_fxanim();
    self thread destroy_quadtank_objective();
    self thread quadtank_util::function_35209d64();
    self waittill( #"death" );
    level flag::set( "cathedral_quad_tank_destroyed" );
}

// Namespace church
// Params 0
// Checksum 0xdc81c567, Offset: 0x16d0
// Size: 0x15a
function quadtank_trophy_system_watcher()
{
    self endon( #"death" );
    
    while ( true )
    {
        self util::waittill_either( "trophy_system_disabled", "trophy_system_destroyed" );
        ai_enemy = spawn_manager::get_ai( "sm_cathedral_lower" );
        
        for ( i = 0; i < ai_enemy.size ; i++ )
        {
            if ( i < 5 && distance2dsquared( self.origin, ai_enemy[ i ].origin ) > 40000 )
            {
                self thread follow_quad_tank( ai_enemy[ i ] );
            }
        }
        
        self waittill( #"trophy_system_enabled" );
        ai_enemy = spawn_manager::get_ai( "sm_cathedral_lower" );
        
        for ( i = 0; i < ai_enemy.size ; i++ )
        {
            ai_enemy[ i ] clearforcedgoal();
        }
    }
}

// Namespace church
// Params 0
// Checksum 0xd16841f4, Offset: 0x1838
// Size: 0xac
function church_pillars_explode_fxanim()
{
    self endon( #"death" );
    self thread qt_shoot_at_pillar( "church_pillars_explode_01", "p7_fxanim_cp_infection_church_pillars_explode_01_bundle" );
    self thread qt_shoot_at_pillar( "church_pillars_explode_02", "p7_fxanim_cp_infection_church_pillars_explode_02_bundle" );
    self thread qt_shoot_at_pillar( "church_pillars_explode_03", "p7_fxanim_cp_infection_church_pillars_explode_03_bundle" );
    self thread qt_shoot_at_pillar( "church_pillars_explode_04", "p7_fxanim_cp_infection_church_pillars_explode_04_bundle" );
}

// Namespace church
// Params 2
// Checksum 0xd1408385, Offset: 0x18f0
// Size: 0xf4
function qt_shoot_at_pillar( e_trig, fxanim_name )
{
    self endon( #"death" );
    trigger::wait_till( e_trig );
    trig = getent( e_trig, "targetname" );
    e_target = spawn( "script_origin", trig.origin );
    self setturrettargetent( e_target );
    self waittill( #"turret_on_target" );
    self fireweapon( 0, e_target );
    level scene::play( fxanim_name, "scriptbundlename" );
}

// Namespace church
// Params 1
// Checksum 0x12091cc6, Offset: 0x19f0
// Size: 0x108
function follow_quad_tank( ai )
{
    self endon( #"trophy_system_enabled" );
    self endon( #"death" );
    ai endon( #"death" );
    n_min_dist = 150;
    n_max_dist = 350;
    n_max_height = 48;
    
    while ( true )
    {
        a_v_points = [];
        a_v_points = util::positionquery_pointarray( self.origin, n_min_dist, n_max_dist, n_max_height, 70, ai );
        
        if ( a_v_points.size )
        {
            ai setgoal( array::random( a_v_points ), 1 );
        }
        
        wait randomfloatrange( 0.5, 1 );
    }
}

// Namespace church
// Params 0
// Checksum 0x26115f2f, Offset: 0x1b00
// Size: 0x34
function destroy_quadtank_objective()
{
    objectives::complete( "cp_level_infection_follow_sarah" );
    objectives::set( "cp_level_infection_destroy_quadtank", self );
}

// Namespace church
// Params 0
// Checksum 0x7a5ad1f3, Offset: 0x1b40
// Size: 0x164
function cathedral_scene_setup()
{
    level scene::init( "p7_fxanim_cp_infection_church_pillars_explode_01_bundle", "scriptbundlename" );
    level scene::init( "p7_fxanim_cp_infection_church_pillars_explode_02_bundle", "scriptbundlename" );
    level scene::init( "p7_fxanim_cp_infection_church_pillars_explode_03_bundle", "scriptbundlename" );
    level scene::init( "p7_fxanim_cp_infection_church_pillars_explode_04_bundle", "scriptbundlename" );
    scene::add_scene_func( "cin_inf_11_06_fold_vign_hell", &scene_sarah_appears_in_cathedral, "init" );
    scene::add_scene_func( "cin_inf_11_06_fold_vign_hell", &scene_sarah_disappears_in_cathedral, "play" );
    scene::add_scene_func( "p7_fxanim_cp_infection_cathedral_floor_bundle", &function_d0dfc621, "play" );
    scene::add_scene_func( "cin_inf_12_01_underwater_1st_fall_01", &function_5661e491, "play" );
}

// Namespace church
// Params 0
// Checksum 0x352b149e, Offset: 0x1cb0
// Size: 0xd4
function wait_enemy_cleared()
{
    var_357e383d = 0;
    a_ai = getaiteamarray( "axis" );
    
    for ( a_ai = array::remove_dead( a_ai, 0 ); a_ai.size > 0 && var_357e383d < 3 ; a_ai = array::remove_dead( a_ai, 0 ) )
    {
        wait 0.1;
        var_357e383d += 0.1;
        a_ai = getaiteamarray( "axis" );
    }
}

// Namespace church
// Params 0
// Checksum 0xc1e03cb3, Offset: 0x1d90
// Size: 0xa4
function cathedral_spawn_ai()
{
    spawn_manager::enable( "sm_cathedral_upper" );
    spawn_manager::enable( "sm_cathedral_lower" );
    trigger::wait_or_timeout( 20, "cathedral_intro_reverse" );
    
    if ( level.players.size <= 2 )
    {
        spawn_manager::set_global_active_count( 21 );
    }
    
    if ( level.players.size >= 3 )
    {
        spawn_manager::set_global_active_count( 31 );
    }
}

// Namespace church
// Params 0
// Checksum 0x8ed0d0e1, Offset: 0x1e40
// Size: 0xc4
function battle_in_cathedral()
{
    infection_util::setup_reverse_time_arrivals( "cathedral_reverse_anim" );
    level thread cathedral_spawn_ai();
    level thread namespace_bed101ee::function_b716312();
    level flag::wait_till( "cathedral_quad_tank_destroyed" );
    spawn_manager::kill( "sm_cathedral_upper" );
    spawn_manager::kill( "sm_cathedral_lower" );
    util::wait_network_frame();
    level thread all_remaining_enemies_die_off();
}

// Namespace church
// Params 0
// Checksum 0x62d9c5da, Offset: 0x1f10
// Size: 0x96
function all_remaining_enemies_die_off()
{
    a_ai = getaiteamarray( "axis" );
    
    for ( i = 0; i < a_ai.size ; i++ )
    {
        if ( isalive( a_ai[ i ] ) )
        {
            a_ai[ i ] kill();
            wait 0.1;
        }
    }
}

// Namespace church
// Params 0
// Checksum 0x74a104c8, Offset: 0x1fb0
// Size: 0x24
function sarah_appears()
{
    level scene::init( "cin_inf_11_06_fold_vign_hell" );
}

// Namespace church
// Params 0
// Checksum 0x89f2ae71, Offset: 0x1fe0
// Size: 0xec
function wait_for_players_to_approach_sarah()
{
    trig = getent( "cathedral_sarah_at_altar", "targetname" );
    trig triggerenable( 1 );
    trig waittill( #"trigger", who );
    level.var_26e8728a = who;
    level flag::set( "sarah_distance_objective" );
    objectives::complete( "cp_level_infection_confront_sarah" );
    level thread namespace_bed101ee::function_af130cfc();
    array::thread_all( level.players, &infection_util::player_enter_cinematic );
}

// Namespace church
// Params 0
// Checksum 0xf28808ee, Offset: 0x20d8
// Size: 0x54
function sarah_vignette_in_cathedral()
{
    level scene::play( "cin_inf_11_06_fold_vign_hell", level.var_26e8728a );
    level waittill( #"hash_319c8cf7" );
    level thread skipto::objective_completed( "cathedral" );
}

// Namespace church
// Params 1
// Checksum 0x4d72eb81, Offset: 0x2138
// Size: 0x24
function function_5661e491( a_ents )
{
    level thread namespace_bed101ee::function_973b77f9();
}

// Namespace church
// Params 1
// Checksum 0xe008de10, Offset: 0x2168
// Size: 0xea
function function_d0dfc621( a_ents )
{
    level clientfield::set( "cathedral_water_state", 1 );
    
    foreach ( player in level.players )
    {
        player thread play_floor_breaks_rumble( 6, 1 );
        earthquake( 0.22, 7, player.origin, 150 );
    }
}

// Namespace church
// Params 1
// Checksum 0xeab39875, Offset: 0x2260
// Size: 0x74
function scene_sarah_appears_in_cathedral( a_ents )
{
    if ( !level flag::get( "sarah_distance_objective" ) )
    {
        objectives::set( "cp_level_infection_confront_sarah", a_ents[ "sarah" ] );
    }
    
    a_ents[ "sarah" ] thread infection_util::actor_camo( 0 );
}

// Namespace church
// Params 1
// Checksum 0x89afefd, Offset: 0x22e0
// Size: 0xdc
function scene_sarah_disappears_in_cathedral( a_ents )
{
    level clientfield::set( "toggle_cathedral_fog_banks", 1 );
    level thread scene::init( "cin_inf_12_01_underwater_1st_fall_underwater02" );
    level waittill( #"hash_bd8dec38" );
    a_ents[ "sarah" ] thread infection_util::actor_camo( 1 );
    level thread scene::init( "p7_fxanim_cp_infection_cathedral_floor_bundle" );
    level thread function_ee14f7e6();
    level waittill( #"hash_88307bc9" );
    level thread scene::play( "p7_fxanim_cp_infection_cathedral_floor_bundle" );
}

// Namespace church
// Params 0
// Checksum 0x12aa72d4, Offset: 0x23c8
// Size: 0x44
function function_ee14f7e6()
{
    while ( !scene::is_ready( "p7_fxanim_cp_infection_cathedral_floor_bundle" ) )
    {
        wait 0.05;
    }
    
    hidemiscmodels( "inf_cathedral_floor_fxanim" );
}

// Namespace church
// Params 2
// Checksum 0x663bf823, Offset: 0x2418
// Size: 0x6c
function play_floor_breaks_rumble( n_loops, n_wait )
{
    self endon( #"death" );
    
    for ( i = 0; i < n_loops ; i++ )
    {
        self playrumbleonentity( "cp_infection_floor_break" );
        wait n_wait;
    }
}

// Namespace church
// Params 0
// Checksum 0x59320106, Offset: 0x2490
// Size: 0x3da
function church_doors_close()
{
    level thread namespace_bed101ee::function_973b77f9();
    a_doors = getentarray( "church_door", "targetname" );
    assert( a_doors.size, "<dev string:x28>" );
    a_temp_ents = [];
    
    foreach ( m_door in a_doors )
    {
        assert( isdefined( m_door.script_int ), "<dev string:x60>" + m_door.origin + "<dev string:x83>" );
        assert( isdefined( m_door.target ), "<dev string:x60>" + m_door.origin + "<dev string:xce>" );
        s_rotate = struct::get( m_door.target, "targetname" );
        e_temp = spawn( "script_origin", s_rotate.origin );
        m_door linkto( e_temp );
        e_temp rotateyaw( m_door.script_int, 1.5, 0.25, 0.25 );
        e_temp playsound( "evt_church_doors_close" );
        
        if ( !isdefined( a_temp_ents ) )
        {
            a_temp_ents = [];
        }
        else if ( !isarray( a_temp_ents ) )
        {
            a_temp_ents = array( a_temp_ents );
        }
        
        a_temp_ents[ a_temp_ents.size ] = e_temp;
    }
    
    wait 1.5;
    
    foreach ( player in level.players )
    {
        player playrumbleonentity( "damage_heavy" );
    }
    
    foreach ( e_temp in a_temp_ents )
    {
        e_temp delete();
    }
}

// Namespace church
// Params 0
// Checksum 0x5895e89a, Offset: 0x2878
// Size: 0x2b4
function warp_players_inside_cathedral()
{
    s_start = struct::get( "church_in_foy", "targetname" );
    assert( isdefined( s_start ), "<dev string:xe6>" );
    s_end = struct::get( "church_inside_cathedral", "targetname" );
    assert( isdefined( s_end ), "<dev string:x119>" );
    m_start = util::spawn_model( "tag_origin", s_start.origin, s_start.angles );
    m_end = util::spawn_model( "tag_origin", s_end.origin, s_end.angles );
    
    foreach ( player in level.players )
    {
        v_local = m_start worldtolocalcoords( player.origin );
        v_warp = m_end localtoworldcoords( v_local );
        v_angles = combineangles( m_end.angles - m_start.angles, player getplayerangles() );
        player setorigin( v_warp );
        player setplayerangles( v_angles );
    }
    
    m_start delete();
    m_end delete();
    skipto::objective_completed( "church" );
}

// Namespace church
// Params 1
// Checksum 0xcec979f5, Offset: 0x2b38
// Size: 0x6c
function function_9ad74a02( a_ents )
{
    level waittill( #"tank_push" );
    level clientfield::set( "light_church_int_all", 1 );
    array::spread_all( level.players, &tank_push, a_ents[ 0 ] );
}

// Namespace church
// Params 1
// Checksum 0x977d5d03, Offset: 0x2bb0
// Size: 0x12c
function tank_push( mdl_tank )
{
    v_dir_tank = mdl_tank.origin - self.origin;
    v_dir_tank = vectornormalize( v_dir_tank );
    v_forward = anglestoforward( self.angles );
    n_dp = vectordot( v_dir_tank, v_forward );
    
    if ( n_dp >= 0 )
    {
        n_tank_force_dir = -1;
    }
    else
    {
        n_tank_force_dir = 1;
    }
    
    v_dir = anglestoforward( self.angles );
    n_strength = n_tank_force_dir * 1200;
    self setvelocity( v_dir * n_strength );
}

// Namespace church
// Params 1
// Checksum 0xc39d247b, Offset: 0x2ce8
// Size: 0x4c
function scene_callback_tank_start_2( a_ents )
{
    a_ents[ 0 ] setforcenocull();
    level waittill( #"fxanim_church_explosion_starts" );
    a_ents[ 0 ] notsolid();
}

// Namespace church
// Params 1
// Checksum 0xfff6d7de, Offset: 0x2d40
// Size: 0x3c
function scene_callback_tank_end_2( a_ents )
{
    vh_tank = a_ents[ "tiger_tank_cinematic" ];
    spawn_quad_tank( vh_tank );
}

// Namespace church
// Params 0
// Checksum 0x5dbcc4ab, Offset: 0x2d88
// Size: 0x14
function ai_accuracy()
{
    self.script_accuracy = 0.7;
}

