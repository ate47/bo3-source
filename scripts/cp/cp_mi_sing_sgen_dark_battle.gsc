#using scripts/codescripts/struct;
#using scripts/cp/_dialog;
#using scripts/cp/_load;
#using scripts/cp/_objectives;
#using scripts/cp/_skipto;
#using scripts/cp/_util;
#using scripts/cp/cp_mi_sing_sgen;
#using scripts/cp/cp_mi_sing_sgen_fallen_soldiers;
#using scripts/cp/cp_mi_sing_sgen_pallas;
#using scripts/cp/cp_mi_sing_sgen_sound;
#using scripts/cp/cp_mi_sing_sgen_testing_lab_igc;
#using scripts/cp/cp_mi_sing_sgen_util;
#using scripts/cp/cybercom/_cybercom;
#using scripts/cp/cybercom/_cybercom_util;
#using scripts/cp/gametypes/_battlechatter;
#using scripts/cp/gametypes/_save;
#using scripts/shared/ai_shared;
#using scripts/shared/array_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/math_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/trigger_shared;
#using scripts/shared/util_shared;

#namespace cp_mi_sing_sgen_dark_battle;

// Namespace cp_mi_sing_sgen_dark_battle
// Params 2
// Checksum 0x47f0ab80, Offset: 0x1408
// Size: 0x40c
function skipto_dark_battle_init( str_objective, b_starting )
{
    if ( b_starting )
    {
        sgen::init_hendricks( str_objective );
        level thread cp_mi_sing_sgen_testing_lab_igc::function_652f4022();
        level notify( #"hash_92687102" );
        objectives::complete( "cp_level_sgen_enter_sgen_no_pointer" );
        objectives::complete( "cp_level_sgen_investigate_sgen" );
        objectives::complete( "cp_level_sgen_locate_emf" );
        objectives::complete( "cp_level_sgen_descend_into_core" );
        objectives::complete( "cp_level_sgen_goto_signal_source" );
        objectives::set( "cp_level_sgen_goto_server_room" );
        level thread scene::skipto_end( "cin_sgen_14_humanlab_3rd_sh200" );
        load::function_a2995f22();
    }
    
    var_77725d68 = getentarray( "interference_on_trig", "targetname" );
    array::thread_all( var_77725d68, &function_d791b0a9, 1 );
    var_4edbd293 = getentarray( "interference_off_trig", "targetname" );
    array::thread_all( var_4edbd293, &function_d791b0a9, 0 );
    level thread scene::play( "cin_sgen_14_01_humanlab_vign_deadbodies" );
    level clientfield::set( "w_underwater_state", 1 );
    spawner::add_spawn_function_group( "dark_battle_jumpdown_bot", "script_noteworthy", &jump_down_bot_mind_control );
    array::thread_all( getentarray( "surgical_facility_interior_door_trigger", "targetname" ), &surgical_facility_interior_door );
    level thread scene::init( "cin_sgen_15_01_darkbattle_vign_new_flare_decayedmen" );
    level thread sgen_util::set_door_state( "surgical_catwalk_top_door", "open" );
    level thread sgen_util::set_door_state( "dark_battle_end_door", "close" );
    level._effect[ "water_rise" ] = "water/fx_water_rise_splash_md";
    level thread surgical_facility();
    level thread electromagnetic_room_vo();
    nd_post_dni = getnode( "hendricks_post_dni_lab", "targetname" );
    level.ai_hendricks setgoal( nd_post_dni, 1, 16 );
    trigger::wait_till( "dark_battle_end" );
    level notify( #"hash_a254d667" );
    a_ai_robots = getentarray( "surgical_facility_spawner_ai", "targetname" );
    array::wait_till( a_ai_robots, "death" );
    level thread sgen_util::set_door_state( "dark_battle_end_door", "open" );
}

// Namespace cp_mi_sing_sgen_dark_battle
// Params 0
// Checksum 0x46bc6120, Offset: 0x1820
// Size: 0x1d4
function electromagnetic_room_vo()
{
    trigger::wait_till( "pre_electromagnetic_room_trigger", undefined, undefined, 0 );
    level dialog::remote( "kane_power_s_out_ahead_s_0" );
    level.ai_hendricks dialog::say( "hend_copy_that_1", 1 );
    trigger::wait_till( "electromagnetic_room_trigger", undefined, undefined, 0 );
    level dialog::remote( "kane_picking_up_radiation_0" );
    level flag::wait_till( "hendricks_door_open" );
    level dialog::player_say( "plrf_good_job_hendricks_0" );
    level.ai_hendricks dialog::say( "hend_uh_i_didn_t_do_th_0", 2 );
    trigger::wait_till( "plyr_shit_2", undefined, undefined, 0 );
    level dialog::player_say( "plyr_more_test_subjects_0", 0.75 );
    level flag::wait_till( "water_robot_spawned" );
    level thread namespace_d40478f6::function_34465ae6();
    level.ai_hendricks dialog::say( "hend_they_re_in_the_water_0", 4 );
    level battlechatter::function_d9f49fba( 1 );
}

// Namespace cp_mi_sing_sgen_dark_battle
// Params 1
// Checksum 0xccf7ccf8, Offset: 0x1a00
// Size: 0x60
function function_d791b0a9( b_state )
{
    level endon( #"descent" );
    
    while ( isdefined( self ) )
    {
        self waittill( #"trigger", e_player );
        e_player clientfield::set_to_player( "oed_interference", b_state );
    }
}

// Namespace cp_mi_sing_sgen_dark_battle
// Params 0
// Checksum 0x41f7bb4d, Offset: 0x1a68
// Size: 0x6c
function electromagnetic_room_vo_nag()
{
    level endon( #"player_raise_hendricks_hendricks" );
    wait 8;
    level.ai_hendricks dialog::say( "hend_need_a_hand_i_ain_t_0" );
    wait randomintrange( 10, 15 );
    level.ai_hendricks dialog::say( "hend_gimme_boost_we_need_0" );
}

// Namespace cp_mi_sing_sgen_dark_battle
// Params 0
// Checksum 0xdc0965af, Offset: 0x1ae0
// Size: 0x54
function jump_down_bot_mind_control()
{
    self ai::set_behavior_attribute( "rogue_control", "forced_level_2" );
    self ai::set_behavior_attribute( "rogue_control_speed", "sprint" );
}

// Namespace cp_mi_sing_sgen_dark_battle
// Params 4
// Checksum 0x7f77c158, Offset: 0x1b40
// Size: 0x24
function skipto_dark_battle_done( str_objective, b_starting, b_direct, player )
{
    
}

// Namespace cp_mi_sing_sgen_dark_battle
// Params 0
// Checksum 0x6f2411b4, Offset: 0x1b70
// Size: 0x19c
function handle_player_raise_animation()
{
    e_player_trigger = getent( "player_raise_hendricks_trigger", "targetname" );
    e_player_trigger triggerenable( 0 );
    level flag::wait_till( "player_raise_hendricks_hendricks_ready" );
    e_player_trigger triggerenable( 1 );
    objectives::complete( "cp_waypoint_breadcrumb" );
    objectives::set( "cp_level_sgen_lift_hendricks", level.ai_hendricks.origin );
    e_player_trigger waittill( #"trigger", triggered_player );
    objectives::complete( "cp_level_sgen_lift_hendricks" );
    level flag::set( "player_raise_hendricks_hendricks" );
    a_scene_ents = [];
    level scene::add_scene_func( "cin_sgen_15_01_darkbattle_vign_new_flare_hendricks_climb", &function_f45def6e, "done", a_scene_ents );
    level thread scene::play( "cin_sgen_15_01_darkbattle_vign_new_flare_hendricks_climb", triggered_player );
    level flag::set( "player_raise_hendricks_player_ready" );
}

// Namespace cp_mi_sing_sgen_dark_battle
// Params 1
// Checksum 0x9edb1ebe, Offset: 0x1d18
// Size: 0xb2
function function_f45def6e( a_scene_ents )
{
    foreach ( ent in a_scene_ents )
    {
        if ( isplayer( ent ) )
        {
            wait 1;
            ent cybercom::disablecybercom();
        }
    }
}

// Namespace cp_mi_sing_sgen_dark_battle
// Params 0
// Checksum 0x4adbe80e, Offset: 0x1dd8
// Size: 0x64
function surgical_facility()
{
    level thread surgical_facility_objective();
    level thread surgical_facility_robots();
    level thread surgical_facility_hendricks();
    level thread surgical_facility_door();
}

// Namespace cp_mi_sing_sgen_dark_battle
// Params 0
// Checksum 0xe4e25e8b, Offset: 0x1e48
// Size: 0x1c
function surgical_facility_objective()
{
    objectives::breadcrumb( "dark_battle_breadcrumb" );
}

// Namespace cp_mi_sing_sgen_dark_battle
// Params 0
// Checksum 0x29314443, Offset: 0x1e70
// Size: 0x1cc
function surgical_facility_door()
{
    level thread scene::init( "door_dark_battle", "targetname" );
    e_door = getent( "hendricks_dark_battle_top_door", "targetname" );
    level flag::wait_till( "dark_battle_hendricks_above" );
    wait 2;
    e_door rotateyaw( -90, 2 );
    wait 2;
    level thread scene::play( "door_dark_battle", "targetname" );
    e_door_clip = getent( "dark_room_entrance_door_clip", "targetname" );
    e_door_clip playsound( "evt_dark_door_open" );
    wait 1.5;
    e_door_clip movez( -144, 1 );
    wait 1.5;
    e_door_clip delete();
    level flag::set( "hendricks_door_open" );
    savegame::checkpoint_save();
    level thread charging_station_objective();
    level waittill( #"close_door" );
    level thread sgen_util::set_door_state( "surgical_catwalk_top_door", "close" );
}

// Namespace cp_mi_sing_sgen_dark_battle
// Params 0
// Checksum 0xd60714eb, Offset: 0x2048
// Size: 0x194
function surgical_facility_hendricks()
{
    trigger::wait_till( "dark_battle_down_stairs", "script_noteworthy", undefined, 0 );
    level.ai_hendricks ai::set_behavior_attribute( "cqb", 1 );
    level.ai_hendricks.goalradius = 8;
    level thread handle_player_raise_animation();
    level scene::play( "cin_sgen_15_01_darkbattle_vign_new_flare_hendricks_pre_arrive" );
    level scene::play( "cin_sgen_15_01_darkbattle_vign_new_flare_hendricks_arrive" );
    level flag::set( "player_raise_hendricks_hendricks_ready" );
    level thread electromagnetic_room_vo_nag();
    level flag::wait_till( "player_raise_hendricks_player_ready" );
    level scene::stop( "cin_sgen_15_01_darkbattle_vign_new_flare_hendricks_arrive" );
    level scene::add_scene_func( "cin_sgen_15_01_darkbattle_vign_new_flare_hendricks_a", &surgical_facility_hendricks_a, "play" );
    level scene::add_scene_func( "cin_sgen_15_01_darkbattle_vign_new_flare_hendricks_idlea", &surgical_facility_hendricks_b, "play" );
}

// Namespace cp_mi_sing_sgen_dark_battle
// Params 1
// Checksum 0xaf9c0ff6, Offset: 0x21e8
// Size: 0x54
function surgical_facility_hendricks_a( a_ents )
{
    level flag::set( "dark_battle_hendricks_above" );
    playsoundatposition( "evt_hend_door_beep", ( 4141, -3845, -5073 ) );
}

// Namespace cp_mi_sing_sgen_dark_battle
// Params 1
// Checksum 0x2da38bfd, Offset: 0x2248
// Size: 0xc4
function surgical_facility_hendricks_b( a_ents )
{
    trigger::wait_till( "dark_battle_hendricks_flarecarry_b_trigger", undefined, undefined, 0 );
    
    if ( level flag::get( "pallas_start" ) )
    {
        return;
    }
    
    level scene::add_scene_func( "cin_sgen_15_01_darkbattle_vign_new_flare_hendricks_idleb", &surgical_facility_hendricks_c, "play" );
    level scene::stop( "cin_sgen_15_01_darkbattle_vign_new_flare_hendricks_idlea" );
    level scene::play( "cin_sgen_15_01_darkbattle_vign_new_flare_hendricks_b" );
}

// Namespace cp_mi_sing_sgen_dark_battle
// Params 1
// Checksum 0x4741e1b, Offset: 0x2318
// Size: 0xc4
function surgical_facility_hendricks_c( a_ents )
{
    trigger::wait_till( "dark_battle_hendricks_flarecarry_c_trigger", undefined, undefined, 0 );
    
    if ( level flag::get( "pallas_start" ) )
    {
        return;
    }
    
    level scene::add_scene_func( "cin_sgen_15_01_darkbattle_vign_new_flare_hendricks_idlec", &surgical_facility_hendricks_d, "play" );
    level scene::stop( "cin_sgen_15_01_darkbattle_vign_new_flare_hendricks_idleb" );
    level scene::play( "cin_sgen_15_01_darkbattle_vign_new_flare_hendricks_c" );
}

// Namespace cp_mi_sing_sgen_dark_battle
// Params 1
// Checksum 0xf259c933, Offset: 0x23e8
// Size: 0x104
function surgical_facility_hendricks_d( a_ents )
{
    level flag::wait_till( "dark_battle_hendricks_flarecarry_end" );
    level thread function_9a64520();
    level battlechatter::function_d9f49fba( 0 );
    level flag::set( "dark_battle_hendricks_ambush" );
    level scene::stop( "cin_sgen_15_01_darkbattle_vign_new_flare_hendricks_idlec" );
    level thread scene::play( "cin_sgen_15_01_darkbattle_vign_new_flare_hendricks_d" );
    level thread namespace_d40478f6::function_973b77f9();
    level util::delay( 30, undefined, &exploder::stop_exploder, "dark_battle_flare2" );
}

// Namespace cp_mi_sing_sgen_dark_battle
// Params 0
// Checksum 0x92f43e3, Offset: 0x24f8
// Size: 0x7c
function function_9a64520()
{
    level waittill( #"hash_391cc978" );
    str_hero = "hendricks_backpack";
    
    if ( !isdefined( level.heroes[ "hendricks_backpack" ] ) )
    {
        str_hero = "hendricks";
    }
    
    level.ai_hendricks util::unmake_hero( str_hero );
    level.ai_hendricks util::self_delete();
}

// Namespace cp_mi_sing_sgen_dark_battle
// Params 0
// Checksum 0x86027323, Offset: 0x2580
// Size: 0xc4
function function_a8cfe9ae()
{
    level scene::stop( "cin_sgen_15_01_darkbattle_vign_new_flare_hendricks_idlea" );
    level scene::stop( "cin_sgen_15_01_darkbattle_vign_new_flare_hendricks_b" );
    level scene::stop( "cin_sgen_15_01_darkbattle_vign_new_flare_hendricks_idleb" );
    level scene::stop( "cin_sgen_15_01_darkbattle_vign_new_flare_hendricks_c" );
    level scene::stop( "cin_sgen_15_01_darkbattle_vign_new_flare_hendricks_idlec" );
    level scene::stop( "cin_sgen_15_01_darkbattle_vign_new_flare_hendricks_d" );
}

// Namespace cp_mi_sing_sgen_dark_battle
// Params 1
// Checksum 0x3183195c, Offset: 0x2650
// Size: 0x24
function surgical_facility_hendricks_stop( a_ents )
{
    level.ai_hendricks scene::stop();
}

// Namespace cp_mi_sing_sgen_dark_battle
// Params 0
// Checksum 0xefadf028, Offset: 0x2680
// Size: 0x9c
function surgical_facility_robots()
{
    a_t_robot_spawn = getentarray( "surgical_facility_spawn_trigger", "targetname" );
    array::thread_all( a_t_robot_spawn, &surgical_facility_spawn_trigger );
    var_62a3a7da = struct::get_array( "hendricks_riser" );
    array::thread_all( var_62a3a7da, &function_80aab711 );
}

// Namespace cp_mi_sing_sgen_dark_battle
// Params 0
// Checksum 0x18e0e2a3, Offset: 0x2728
// Size: 0x1b4
function function_80aab711()
{
    sp_robot = getent( "surgical_facility_spawner", "targetname" );
    n_scene = randomintrange( 1, 3 );
    ai_robot = sp_robot spawner::spawn( 1 );
    ai_robot endon( #"death" );
    self scene::init( "cin_sgen_15_04_robot_ambush_aie_arise_robot0" + n_scene + "_water", ai_robot );
    ai_robot cp_mi_sing_sgen_fallen_soldiers::robot_wake_spawnfunc();
    ai_robot.targetname = "hendricks_riser_ai";
    level flag::wait_till( "dark_battle_hendricks_ambush" );
    wait randomfloatrange( 0.1, 1 );
    ai_robot thread cp_mi_sing_sgen_fallen_soldiers::robot_wake_up();
    self scene::play( "cin_sgen_15_04_robot_ambush_aie_arise_robot0" + n_scene + "_water", ai_robot );
    s_goal = struct::get( self.target, "targetname" );
    wait 10;
    ai_robot kill();
}

// Namespace cp_mi_sing_sgen_dark_battle
// Params 0
// Checksum 0x91380e6b, Offset: 0x28e8
// Size: 0x45c
function surgical_facility_spawn_trigger()
{
    level endon( #"hash_a254d667" );
    e_volume = undefined;
    a_e_volumes = getentarray( "surgical_facility_dark_battle_volume", "targetname" );
    a_s_spawn_points = struct::get_array( self.target );
    v_origin = self.origin;
    n_radius = self.radius;
    e_temp = spawn( "script_origin", self.origin + ( 0, 0, 10 ) );
    
    foreach ( e_volume_lane in a_e_volumes )
    {
        if ( e_temp istouching( e_volume_lane ) )
        {
            e_volume = e_volume_lane;
        }
    }
    
    e_temp util::self_delete();
    a_s_spawn_points = array::randomize( a_s_spawn_points );
    self waittill( #"trigger" );
    n_players_in_lane = 0;
    
    foreach ( player in level.players )
    {
        if ( player istouching( e_volume ) )
        {
            n_players_in_lane++;
        }
    }
    
    switch ( n_players_in_lane )
    {
        case 1:
            n_robots_to_spawn = 2;
            break;
        case 2:
            n_robots_to_spawn = 3;
            break;
        case 3:
            n_robots_to_spawn = 5;
            break;
        case 4:
            n_robots_to_spawn = 7;
            break;
    }
    
    n_robots_in_lane = 0;
    a_ai_robots = getaispeciesarray( "all", "robot" );
    
    foreach ( ai_robot in a_ai_robots )
    {
        if ( ai_robot istouching( e_volume_lane ) )
        {
            n_robots_in_lane++;
        }
    }
    
    foreach ( n_index, s_spawn_point in a_s_spawn_points )
    {
        if ( n_index < n_robots_to_spawn && n_robots_in_lane < 24 )
        {
            level thread surgical_facility_robot( s_spawn_point, n_index );
        }
    }
    
    level flag::set( "water_robot_spawned" );
}

// Namespace cp_mi_sing_sgen_dark_battle
// Params 2
// Checksum 0x278191cb, Offset: 0x2d50
// Size: 0x174
function surgical_facility_robot( s_spawn_point, n_index )
{
    sp_robot = getent( "surgical_facility_spawner", "targetname" );
    
    if ( n_index > 0 )
    {
        wait n_index + randomfloatrange( 0.5, 1.5 );
    }
    
    playfx( level._effect[ "water_rise" ], s_spawn_point.origin );
    ai_robot = sp_robot spawner::spawn( 1 );
    ai_robot ai::set_behavior_attribute( "rogue_control", "forced_level_2" );
    s_spawn_point scene::play( "cin_sgen_15_04_robot_ambush_aie_arise_robot0" + randomintrange( 1, 3 ) + "_water", ai_robot );
    ai_robot thread sgen_util::robot_init_mind_control( 2 );
    ai_robot clientfield::set( "sndStepSet", 1 );
}

// Namespace cp_mi_sing_sgen_dark_battle
// Params 0
// Checksum 0xf2d63946, Offset: 0x2ed0
// Size: 0xcc
function surgical_facility_interior_door()
{
    str_targetname = self.target;
    level thread sgen_util::set_door_state( str_targetname, "open" );
    self waittill( #"trigger", ent );
    
    if ( !isdefined( level.n_surgical_facility_interior_door ) )
    {
        level.n_surgical_facility_interior_door = 1;
    }
    else
    {
        level.n_surgical_facility_interior_door++;
    }
    
    if ( level.n_surgical_facility_interior_door < 3 )
    {
        level scene::stop( "cin_sgen_14_01_humanlab_vign_deadbodies", 1 );
        level thread sgen_util::set_door_state( str_targetname, "close" );
    }
}

// Namespace cp_mi_sing_sgen_dark_battle
// Params 2
// Checksum 0x172ef5fb, Offset: 0x2fa8
// Size: 0x394
function skipto_charging_station_init( str_objective, b_starting )
{
    if ( b_starting )
    {
        objectives::complete( "cp_level_sgen_enter_sgen_no_pointer" );
        objectives::complete( "cp_level_sgen_investigate_sgen" );
        objectives::complete( "cp_level_sgen_locate_emf" );
        objectives::complete( "cp_level_sgen_descend_into_core" );
        objectives::complete( "cp_level_sgen_goto_signal_source" );
        level thread charging_station_objective();
        load::function_a2995f22();
    }
    
    level thread function_bed8321d();
    level.n_charging_station_spawns = 6 + level.players.size * 4;
    level clientfield::set( "w_underwater_state", 1 );
    level util::clientnotify( "sndRHStart" );
    level thread charging_station();
    level thread charging_station_power_on();
    level thread charging_station_player_vo();
    cp_mi_sing_sgen_pallas::elevator_setup();
    trigger::wait_till( "weapons_research_vo" );
    level flag::set( "weapons_research_vo_start" );
    level flag::wait_till( "weapons_research_vo_done" );
    a_ai = getaiteamarray( "team3" );
    a_ai_awaken = [];
    
    foreach ( ai in a_ai )
    {
        if ( isdefined( ai.activated ) && ai.activated )
        {
            if ( !isdefined( a_ai_awaken ) )
            {
                a_ai_awaken = [];
            }
            else if ( !isarray( a_ai_awaken ) )
            {
                a_ai_awaken = array( a_ai_awaken );
            }
            
            a_ai_awaken[ a_ai_awaken.size ] = ai;
        }
    }
    
    if ( a_ai_awaken.size )
    {
        array::run_all( a_ai_awaken, &ai::set_behavior_attribute, "rogue_control_speed", "sprint" );
        array::wait_till( a_ai_awaken, "death" );
        wait 2;
    }
    
    skipto::objective_completed( "charging_station" );
}

// Namespace cp_mi_sing_sgen_dark_battle
// Params 4
// Checksum 0x83768ff4, Offset: 0x3348
// Size: 0x24
function skipto_charging_station_done( str_objective, b_starting, b_direct, player )
{
    
}

// Namespace cp_mi_sing_sgen_dark_battle
// Params 0
// Checksum 0x80718a3b, Offset: 0x3378
// Size: 0xda
function function_bed8321d()
{
    a_ai_bots = getaiteamarray( "axis", "team3" );
    
    foreach ( ai_bot in a_ai_bots )
    {
        if ( isalive( ai_bot ) )
        {
            ai_bot kill();
            util::wait_network_frame();
        }
    }
}

// Namespace cp_mi_sing_sgen_dark_battle
// Params 0
// Checksum 0xcab63431, Offset: 0x3460
// Size: 0x844
function charging_station()
{
    array::run_all( getentarray( "charging_station_flood_trigger", "script_noteworthy" ), &setinvisibletoall );
    array::thread_all( getspawnerarray( "charging_station_corner_spawner", "script_noteworthy" ), &spawner::add_spawn_function, &charging_station_corner_robot_init );
    a_s_spawn_point = struct::get_array( "charging_station_spawn_point" );
    t_awaken = getent( "charging_station_trigger", "targetname" );
    
    foreach ( n_index, s_spawn_point in a_s_spawn_point )
    {
        s_spawn_point charging_station_spawner();
        
        if ( n_index % 2 == 0 )
        {
            util::wait_network_frame();
        }
    }
    
    mdl_test = util::spawn_model( "tag_origin" );
    t_awaken.a_s_spawn_point = [];
    t_awaken.a_s_spawn_point[ "left" ] = [];
    t_awaken.a_s_spawn_point[ "right" ] = [];
    t_awaken.var_57783f19 = [];
    t_awaken.var_426817d3 = [];
    t_awaken.var_426817d3[ "right" ] = [];
    t_awaken.var_426817d3[ "left" ] = [];
    t_awaken.a_volumes = getentarray( t_awaken.target, "targetname" );
    
    foreach ( s_spawn_point in a_s_spawn_point )
    {
        mdl_test.origin = s_spawn_point.origin;
        
        foreach ( e_volume in t_awaken.a_volumes )
        {
            if ( mdl_test istouching( e_volume ) && s_spawn_point.script_noteworthy === "real" )
            {
                if ( e_volume.script_noteworthy == "left_volume" )
                {
                    if ( !isdefined( t_awaken.a_s_spawn_point[ "left" ] ) )
                    {
                        t_awaken.a_s_spawn_point[ "left" ] = [];
                    }
                    else if ( !isarray( t_awaken.a_s_spawn_point[ "left" ] ) )
                    {
                        t_awaken.a_s_spawn_point[ "left" ] = array( t_awaken.a_s_spawn_point[ "left" ] );
                    }
                    
                    t_awaken.a_s_spawn_point[ "left" ][ t_awaken.a_s_spawn_point[ "left" ].size ] = s_spawn_point;
                }
                else
                {
                    if ( !isdefined( t_awaken.a_s_spawn_point[ "right" ] ) )
                    {
                        t_awaken.a_s_spawn_point[ "right" ] = [];
                    }
                    else if ( !isarray( t_awaken.a_s_spawn_point[ "right" ] ) )
                    {
                        t_awaken.a_s_spawn_point[ "right" ] = array( t_awaken.a_s_spawn_point[ "right" ] );
                    }
                    
                    t_awaken.a_s_spawn_point[ "right" ][ t_awaken.a_s_spawn_point[ "right" ].size ] = s_spawn_point;
                }
                
                if ( s_spawn_point.script_string === "timed_start" )
                {
                    if ( !isdefined( t_awaken.var_57783f19 ) )
                    {
                        t_awaken.var_57783f19 = [];
                    }
                    else if ( !isarray( t_awaken.var_57783f19 ) )
                    {
                        t_awaken.var_57783f19 = array( t_awaken.var_57783f19 );
                    }
                    
                    t_awaken.var_57783f19[ t_awaken.var_57783f19.size ] = s_spawn_point;
                    continue;
                }
                
                if ( s_spawn_point.script_string === "left_solo_start" )
                {
                    if ( !isdefined( t_awaken.var_426817d3[ "left" ] ) )
                    {
                        t_awaken.var_426817d3[ "left" ] = [];
                    }
                    else if ( !isarray( t_awaken.var_426817d3[ "left" ] ) )
                    {
                        t_awaken.var_426817d3[ "left" ] = array( t_awaken.var_426817d3[ "left" ] );
                    }
                    
                    t_awaken.var_426817d3[ "left" ][ t_awaken.var_426817d3[ "left" ].size ] = s_spawn_point;
                    continue;
                }
                
                if ( s_spawn_point.script_string === "right_solo_start" )
                {
                    if ( !isdefined( t_awaken.var_426817d3[ "right" ] ) )
                    {
                        t_awaken.var_426817d3[ "right" ] = [];
                    }
                    else if ( !isarray( t_awaken.var_426817d3[ "right" ] ) )
                    {
                        t_awaken.var_426817d3[ "right" ] = array( t_awaken.var_426817d3[ "right" ] );
                    }
                    
                    t_awaken.var_426817d3[ "right" ][ t_awaken.var_426817d3[ "right" ].size ] = s_spawn_point;
                }
            }
        }
    }
    
    mdl_test util::self_delete();
    t_awaken thread charging_station_trigger();
}

// Namespace cp_mi_sing_sgen_dark_battle
// Params 0
// Checksum 0xc1420eb, Offset: 0x3cb0
// Size: 0x4c
function charging_station_objective()
{
    objectives::breadcrumb( "charging_station_breadcrumb" );
    objectives::set( "cp_level_sgen_goto_server_room_indicator", struct::get( "pallas_elevator_descent_objective" ) );
}

// Namespace cp_mi_sing_sgen_dark_battle
// Params 0
// Checksum 0xfe5f8c8a, Offset: 0x3d08
// Size: 0x42a
function charging_station_power_on()
{
    s_start_point = struct::get( "charging_station_power_on" );
    s_end_point = struct::get( s_start_point.target );
    trigger::wait_till( "enter_charging_station", undefined, undefined, 0 );
    util::delay( 1.5, undefined, &function_54efd092 );
    util::delay( 0.25, undefined, &function_fe4282f );
    a_ai_robots = getentarray( "charging_station_ai", "targetname" );
    a_mdl_robots = getentarray( "charging_station_mdl", "targetname" );
    a_e_robots = arraycombine( a_ai_robots, a_mdl_robots, 0, 0 );
    a_e_robots_sorted = [];
    
    foreach ( e_robot in a_e_robots )
    {
        n_index = sgen_util::round_up_to_ten( int( e_robot.origin[ 0 ] ) );
        
        if ( !isdefined( a_e_robots_sorted[ n_index ] ) )
        {
            a_e_robots_sorted[ n_index ] = [];
        }
        
        if ( !isdefined( a_e_robots_sorted[ n_index ] ) )
        {
            a_e_robots_sorted[ n_index ] = [];
        }
        else if ( !isarray( a_e_robots_sorted[ n_index ] ) )
        {
            a_e_robots_sorted[ n_index ] = array( a_e_robots_sorted[ n_index ] );
        }
        
        a_e_robots_sorted[ n_index ][ a_e_robots_sorted[ n_index ].size ] = e_robot;
    }
    
    a_n_keys = getarraykeys( a_e_robots_sorted );
    a_n_keys_sorted = array::sort_by_value( a_n_keys );
    
    foreach ( n_index, n_key in a_n_keys_sorted )
    {
        foreach ( e_robot in a_e_robots_sorted[ n_key ] )
        {
            if ( isai( e_robot ) )
            {
                e_robot ai::set_behavior_attribute( "rogue_control", "forced_level_1" );
                continue;
            }
            
            e_robot clientfield::set( "turn_fake_robot_eye", 1 );
        }
        
        wait 0.2;
    }
}

// Namespace cp_mi_sing_sgen_dark_battle
// Params 0
// Checksum 0xd627a063, Offset: 0x4140
// Size: 0x92
function function_fe4282f()
{
    foreach ( player in level.activeplayers )
    {
        player playrumbleonentity( "damage_light" );
    }
}

// Namespace cp_mi_sing_sgen_dark_battle
// Params 0
// Checksum 0x70d462e9, Offset: 0x41e0
// Size: 0x54
function charging_station_corner_robot_init()
{
    self ai::set_behavior_attribute( "rogue_control", "forced_level_2" );
    self ai::set_behavior_attribute( "rogue_control_speed", "sprint" );
}

// Namespace cp_mi_sing_sgen_dark_battle
// Params 1
// Checksum 0xf1f8a564, Offset: 0x4240
// Size: 0x5c
function wait_till_trigger_or_flag( str_flag )
{
    self endon( #"trigger" );
    
    if ( !level flag::exists( str_flag ) )
    {
        level flag::init( str_flag );
    }
    
    level flag::wait_till( str_flag );
}

// Namespace cp_mi_sing_sgen_dark_battle
// Params 0
// Checksum 0x66dd27d7, Offset: 0x42a8
// Size: 0x516
function charging_station_trigger()
{
    level endon( #"flood_combat_terminate" );
    
    if ( !level flag::exists( "charging_chamber_spawn_gate" ) )
    {
        level flag::init( "charging_chamber_spawn_gate" );
    }
    
    self thread function_16c18dca();
    self waittill( #"trigger", e_player );
    
    if ( level.players.size == 1 && !e_player issprinting() )
    {
        trigger::wait_till( "trig_solo_walk_spawns" );
    }
    
    level thread namespace_d40478f6::function_29597dc9();
    level util::clientnotify( "sndRHStop" );
    level.var_65e3a64d = 0;
    var_72c8d114 = 0;
    var_63f2fbaf = 0;
    
    while ( level.n_charging_station_spawns > 0 )
    {
        s_spawn_point = undefined;
        a_s_spawn_point = [];
        
        if ( self.var_ba18db07 == "right" && self.a_s_spawn_point[ "right" ].size > 0 )
        {
            a_s_spawn_point = arraycopy( self.a_s_spawn_point[ "right" ] );
        }
        else if ( self.var_ba18db07 == "left" && self.a_s_spawn_point[ "left" ].size > 0 )
        {
            a_s_spawn_point = arraycopy( self.a_s_spawn_point[ "left" ] );
        }
        else
        {
            a_s_spawn_point = arraycombine( self.a_s_spawn_point[ "left" ], self.a_s_spawn_point[ "right" ], 0, 0 );
        }
        
        if ( a_s_spawn_point.size == 0 )
        {
            break;
        }
        
        if ( !var_72c8d114 && level.players.size == 1 && self.var_ba18db07 != "both" && self.var_426817d3[ self.var_ba18db07 ].size > 0 )
        {
            s_spawn_point = array::random( self.var_426817d3[ self.var_ba18db07 ] );
            arrayremovevalue( self.var_426817d3[ self.var_ba18db07 ], s_spawn_point );
            
            if ( self.var_426817d3[ self.var_ba18db07 ].size == 0 )
            {
                var_72c8d114 = 1;
            }
        }
        
        if ( var_72c8d114 && !var_63f2fbaf )
        {
            foreach ( var_3bfe0114 in self.var_57783f19 )
            {
                arrayremovevalue( self.a_s_spawn_point[ "right" ], var_3bfe0114 );
                arrayremovevalue( self.a_s_spawn_point[ "left" ], var_3bfe0114 );
            }
            
            var_63f2fbaf = 1;
        }
        
        if ( !isdefined( s_spawn_point ) )
        {
            s_spawn_point = array::random( a_s_spawn_point );
        }
        
        if ( !( isdefined( s_spawn_point.activated ) && s_spawn_point.activated ) )
        {
            s_spawn_point notify( #"awaken" );
            level.var_65e3a64d++;
            
            if ( level.var_65e3a64d < 4 )
            {
                wait 0.1 + 0.1 * level.var_65e3a64d;
            }
            else
            {
                wait 1.5 / level.players.size;
            }
        }
        
        arrayremovevalue( self.a_s_spawn_point[ "right" ], s_spawn_point );
        arrayremovevalue( self.a_s_spawn_point[ "left" ], s_spawn_point );
        wait 0.05;
    }
    
    self notify( #"hash_dd4c949f" );
}

// Namespace cp_mi_sing_sgen_dark_battle
// Params 0
// Checksum 0x52c97f92, Offset: 0x47c8
// Size: 0x1f4
function function_16c18dca()
{
    self endon( #"death" );
    self endon( #"hash_dd4c949f" );
    self.var_ba18db07 = "";
    
    while ( true )
    {
        self.var_ba18db07 = "";
        var_57da092c = 0;
        var_e738900b = 0;
        
        foreach ( e_volume in self.a_volumes )
        {
            foreach ( e_player in level.activeplayers )
            {
                if ( e_player istouching( e_volume ) )
                {
                    if ( e_volume.script_noteworthy == "left_volume" )
                    {
                        var_57da092c = 1;
                    }
                    else
                    {
                        var_e738900b = 1;
                    }
                    
                    break;
                }
            }
        }
        
        if ( var_e738900b && var_57da092c )
        {
            self.var_ba18db07 = "both";
        }
        else if ( var_e738900b )
        {
            self.var_ba18db07 = "right";
        }
        else
        {
            self.var_ba18db07 = "left";
        }
        
        wait 0.25;
    }
}

// Namespace cp_mi_sing_sgen_dark_battle
// Params 0
// Checksum 0x36751b4a, Offset: 0x49c8
// Size: 0xfc
function function_54efd092()
{
    exploder::exploder( "charging_station_001" );
    wait 0.5;
    exploder::exploder( "charging_station_002" );
    wait 0.5;
    exploder::exploder( "charging_station_005" );
    wait 0.5;
    exploder::exploder( "charging_station_006" );
    wait 0.5;
    exploder::exploder( "charging_station_003" );
    wait 0.5;
    exploder::exploder( "charging_station_007" );
    wait 0.5;
    exploder::exploder( "charging_station_004" );
    wait 0.5;
    exploder::exploder( "charging_station_008" );
}

// Namespace cp_mi_sing_sgen_dark_battle
// Params 1
// Checksum 0xbf3fcc2f, Offset: 0x4ad0
// Size: 0x174
function charging_station_spawn_robot( is_real )
{
    if ( !isdefined( is_real ) )
    {
        is_real = 1;
    }
    
    sp_robot = getent( "charging_station_spawner", "targetname" );
    
    if ( isdefined( is_real ) && is_real )
    {
        self.ai_robot = sp_robot spawner::spawn( 1 );
        self.ai_robot.targetname = "charging_station_ai";
        self.ai_robot forceteleport( self.origin, self.angles );
        self.ai_robot.script_objective = "descent";
        self thread charging_station_spawner_think();
        return;
    }
    
    self.mdl_robot = util::spawn_model( "c_cia_robot_grunt_1", self.origin, self.angles );
    self.mdl_robot.targetname = "charging_station_mdl";
    self.mdl_robot.script_objective = "descent";
    self thread charging_station_fake_spawner_think();
}

// Namespace cp_mi_sing_sgen_dark_battle
// Params 0
// Checksum 0xb44e0dd1, Offset: 0x4c50
// Size: 0x20c
function charging_station_spawner()
{
    self.angles *= -1;
    self.origin += ( 0, 0, -5.5 );
    self.is_second_floor = self.origin[ 2 ] > -5025;
    
    if ( self.script_noteworthy === "fail" )
    {
        self charging_station_spawn_robot( 0 );
        return;
    }
    
    if ( self.script_noteworthy === "real" )
    {
        self charging_station_spawn_robot();
        
        if ( !( isdefined( self.is_second_floor ) && self.is_second_floor ) )
        {
            s_chamber = struct::get( self.target );
            self.mdl_chamber = util::spawn_model( "p7_fxanim_cp_sgen_charging_station_doors_mod", s_chamber.origin, s_chamber.angles );
            self.mdl_chamber.script_objective = "flood_combat";
            self.mdl_chamber.targetname = "pod_track_model";
        }
        
        self.ai_robot thread scene::play( "cin_sgen_16_01_charging_station_aie_idle_robot01", self.ai_robot );
        self.ai_robot thread sgen_util::head_track_closest_player();
        return;
    }
    
    if ( self.script_noteworthy === "static" )
    {
        self.e_eye = util::spawn_model( "tag_origin", self.origin, self.angles );
        self.e_eye.script_objective = "charging_station";
        self.e_eye.targetname = "charging_station_mdl";
    }
}

#using_animtree( "generic" );

// Namespace cp_mi_sing_sgen_dark_battle
// Params 0
// Checksum 0xbf34770b, Offset: 0x4e68
// Size: 0x1ac
function charging_station_fake_spawner_think()
{
    n_x_offset = self.origin[ 0 ] + randomintrange( 64, 200 );
    self.mdl_robot useanimtree( #animtree );
    self.mdl_robot animscripted( "idle_robot01", self.origin, self.angles + ( 0, 180, 0 ), "ch_sgen_16_01_charging_station_aie_idle_robot01" );
    var_602f3c61 = 0;
    
    while ( !var_602f3c61 )
    {
        foreach ( player in level.activeplayers )
        {
            if ( player.origin[ 0 ] < n_x_offset )
            {
                var_602f3c61 = 1;
                break;
            }
        }
        
        wait 0.2;
    }
    
    self.mdl_robot animscripted( "fail_robot01", self.origin, self.angles + ( 0, 180, 0 ), "ch_sgen_16_01_charging_station_aie_fail_robot01" );
}

// Namespace cp_mi_sing_sgen_dark_battle
// Params 0
// Checksum 0x960e602d, Offset: 0x5020
// Size: 0x2b4
function charging_station_spawner_think()
{
    level endon( #"pallas_elevator_starting" );
    str_event = self util::waittill_any_return( "awaken", "post_pallas" );
    self.activated = 1;
    self.ai_robot.activated = 1;
    
    if ( str_event === "awaken" )
    {
        /#
            if ( isdefined( level.var_65e3a64d ) )
            {
                iprintln( "<dev string:x28>" + level.var_65e3a64d );
            }
        #/
        
        level.n_charging_station_spawns--;
        
        if ( isdefined( self.mdl_chamber ) )
        {
            self.mdl_chamber setmodel( "p7_fxanim_cp_sgen_charging_station_doors_break_mod" );
        }
        
        str_robot_anim = "cin_sgen_16_01_charging_station_aie_awaken_robot0";
        
        if ( isdefined( level.var_65e3a64d ) && level.var_65e3a64d < 3 )
        {
            str_robot_anim += self.angles[ 1 ] == -90 ? 3 : 6;
        }
        else
        {
            str_robot_anim += self.angles[ 1 ] == -90 ? randomintrange( 1, 4 ) : randomintrange( 4, 7 );
        }
        
        if ( isdefined( self.mdl_chamber ) )
        {
            str_chamber_anim = math::cointoss() ? "p7_fxanim_cp_sgen_charging_station_break_02_bundle" : "p7_fxanim_cp_sgen_charging_station_break_03_bundle";
            str_chamber_anim = isdefined( self.is_second_floor ) && self.is_second_floor ? "p7_fxanim_cp_sgen_charging_station_break_01_bundle" : str_chamber_anim;
            self thread charging_station_spawner_break_glass( str_chamber_anim );
        }
        
        str_robot_anim = isdefined( self.is_second_floor ) && self.is_second_floor ? "cin_sgen_16_01_charging_station_aie_awaken_robot05_jumpdown" : str_robot_anim;
        self.ai_robot thread scene::play( str_robot_anim, self.ai_robot );
        self.ai_robot thread sgen_util::robot_init_mind_control( 2 );
        wait 3;
        level flag::set( "pod_robot_spawned" );
    }
}

// Namespace cp_mi_sing_sgen_dark_battle
// Params 1
// Checksum 0x4e87aaf3, Offset: 0x52e0
// Size: 0x54
function charging_station_spawner_break_glass( str_chamber_anim )
{
    self.ai_robot endon( #"death" );
    self.ai_robot waittill( #"breakglass" );
    self.mdl_chamber thread scene::play( str_chamber_anim, self.mdl_chamber );
}

// Namespace cp_mi_sing_sgen_dark_battle
// Params 0
// Checksum 0x62cc186d, Offset: 0x5340
// Size: 0x1e4
function charging_station_player_vo()
{
    thread function_a022fef1();
    level dialog::player_say( "plyr_kane_optics_back_on_0", 1 );
    level dialog::remote( "kane_copy_that_i_m_pic_0", 0.7 );
    trigger::wait_till( "enter_charging_station", undefined, undefined, 0 );
    level dialog::player_say( "plyr_robot_charging_stora_0" );
    level dialog::remote( "kane_easy_take_your_ti_0" );
    level dialog::remote( "hend_kane_i_got_separate_0" );
    level flag::wait_till( "pod_robot_spawned" );
    level dialog::remote( "kane_get_outta_there_i_g_0", 2 );
    wait 5;
    level flag::wait_till_timeout( 15, "weapons_research_vo_start" );
    level thread namespace_d40478f6::robot_hallway_underscore();
    level dialog::player_say( "plyr_you_know_this_is_sta_0" );
    level dialog::remote( "kane_the_chemicals_releas_0", 1 );
    level dialog::remote( "hend_anyone_else_sense_a_0", 0.5 );
    level flag::set( "weapons_research_vo_done" );
}

// Namespace cp_mi_sing_sgen_dark_battle
// Params 0
// Checksum 0xf5225253, Offset: 0x5530
// Size: 0x2c
function function_a022fef1()
{
    wait 0.5;
    playsoundatposition( "gdt_oed_on", ( 0, 0, 0 ) );
}

