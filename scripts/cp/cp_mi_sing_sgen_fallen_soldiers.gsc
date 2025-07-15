#using scripts/codescripts/struct;
#using scripts/cp/_dialog;
#using scripts/cp/_load;
#using scripts/cp/_mapping_drone;
#using scripts/cp/_objectives;
#using scripts/cp/_skipto;
#using scripts/cp/_spawn_manager;
#using scripts/cp/_util;
#using scripts/cp/cp_mi_sing_sgen;
#using scripts/cp/cp_mi_sing_sgen_accolades;
#using scripts/cp/cp_mi_sing_sgen_enter_silo;
#using scripts/cp/cp_mi_sing_sgen_sound;
#using scripts/cp/cp_mi_sing_sgen_testing_lab_igc;
#using scripts/cp/cp_mi_sing_sgen_util;
#using scripts/cp/gametypes/_battlechatter;
#using scripts/shared/ai_shared;
#using scripts/shared/array_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/colors_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/fx_shared;
#using scripts/shared/gameobjects_shared;
#using scripts/shared/math_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/trigger_shared;
#using scripts/shared/util_shared;
#using scripts/shared/vehicle_shared;

#namespace cp_mi_sing_sgen_fallen_soldiers;

// Namespace cp_mi_sing_sgen_fallen_soldiers
// Params 2
// Checksum 0xfaf602d4, Offset: 0x1028
// Size: 0x324
function skipto_fallen_soldiers_init( str_objective, b_starting )
{
    level flag::init( "kane_robots_convo_done" );
    level flag::init( "fallen_soldiers_hendricks_ready_to_enter_dayroom" );
    level thread function_68f0b726();
    spawner::add_spawn_function_group( "fallen_soldiers_spawner", "script_noteworthy", &robot_wake_spawnfunc );
    spawner::add_spawn_function_group( "fallen_soldiers_start_awake", "script_noteworthy", &robot_spawnfunc );
    
    if ( b_starting )
    {
        load::function_73adcefc();
        sgen::init_hendricks( str_objective );
        nd_post_jump_downs = getnode( "nd_post_jump_downs", "targetname" );
        level.ai_hendricks thread ai::force_goal( nd_post_jump_downs, 32 );
        level battlechatter::function_d9f49fba( 0 );
        level clientfield::set( "w_underwater_state", 1 );
        level clientfield::set( "fallen_soldiers_client_fxanims", 1 );
        objectives::complete( "cp_level_sgen_enter_sgen_no_pointer" );
        objectives::complete( "cp_level_sgen_investigate_sgen" );
        objectives::complete( "cp_level_sgen_locate_emf" );
        objectives::set( "cp_level_sgen_find_recon_drone", level.vh_mapper );
        level thread namespace_d40478f6::function_71f06599();
        mapping_drone::spawn_drone( undefined, 0 );
        playfxontag( level._effect[ "drone_sparks" ], level.vh_mapper, "tag_origin" );
        load::function_a2995f22();
    }
    
    for ( x = 0; x < 6 ; x++ )
    {
        array::run_all( getentarray( "robot0" + x, "targetname" ), &delete );
    }
    
    main();
    skipto::objective_completed( "fallen_soldiers" );
}

// Namespace cp_mi_sing_sgen_fallen_soldiers
// Params 4
// Checksum 0x118256a7, Offset: 0x1358
// Size: 0x12c
function skipto_fallen_soldiers_done( str_objective, b_s_starting, b_direct, player )
{
    for ( x = 0; x < 6 ; x++ )
    {
        array::thread_all( getentarray( "robot0" + x, "targetname" ), &util::self_delete );
    }
    
    exploder::delete_exploder_on_clients( "fallen_soldiers_decon_spray" );
    struct::delete_script_bundle( "scene", "cin_sgen_12_01_corvus_vign_secret_entrance_hendricks" );
    struct::delete_script_bundle( "scene", "cin_sgen_12_01_corvus_vign_dayroom" );
    struct::delete_script_bundle( "scene", "cin_sgen_13_01_fallensoldiers_vign_grab_start" );
    struct::delete_script_bundle( "scene", "cin_sgen_13_01_fallensoldiers_vign_grab_end" );
}

// Namespace cp_mi_sing_sgen_fallen_soldiers
// Params 0
// Checksum 0xeabc67b3, Offset: 0x1490
// Size: 0x21c
function main()
{
    level.ai_hendricks.goalradius = 16;
    level.ai_hendricks colors::disable();
    level thread scene::init( "cin_sgen_14_humanlab_3rd_sh005" );
    level thread vo();
    level thread handle_breadcrumbs();
    level thread fallen_soldiers_objective();
    level thread namespace_d40478f6::function_973b77f9();
    fallen_soldiers_room();
    level flag::wait_till_timeout( 40, "fallen_soldiers_hendricks_ready_to_enter_dayroom" );
    trigger::wait_or_timeout( 5, "fallen_soldiers_encounter_clear_trig" );
    level notify( #"fallen_soldiers_terminate" );
    level thread encounter_kill_spawnmanagers();
    wait_till_all_dead_or_timeout( 20, "fallen_soldiers_robots_cleared" );
    level.ai_hendricks setgoal( getnode( "fallen_soldiers_hendricks_dayroom_enter_node", "targetname" ), 1 );
    level flag::wait_till( "fallen_soldiers_dayroom_started" );
    spawner::waittill_ai_group_cleared( "fallen_soldiers_extra_robots" );
    level.ai_hendricks waittill( #"goal" );
    wait 0.5;
    play_hendricks_dayroom_scene();
    trigger::wait_till( "fallen_soldiers_exit_zone_trig" );
}

// Namespace cp_mi_sing_sgen_fallen_soldiers
// Params 0
// Checksum 0x70a88d21, Offset: 0x16b8
// Size: 0xf4
function hendricks_battle_movement()
{
    level endon( #"fallen_soldiers_robots_cleared" );
    level.ai_hendricks setgoal( getnode( "fallen_soldiers_hendricks_decon_door_exit_node", "targetname" ), 1 );
    level.ai_hendricks waittill( #"goal" );
    level.ai_hendricks wait_till_zone_safe_then_move( "fallen_soldiers_hendricks_decon_exit_zone_aitrig" );
    level.ai_hendricks ai::set_ignoreme( 0 );
    level flag::wait_till( "fallen_soldiers_lockerroom_second_spawn" );
    level.ai_hendricks wait_till_zone_safe_then_move( "fallen_soldiers_hendricks_dayroom_approach_aitrig" );
    level flag::set( "fallen_soldiers_hendricks_ready_to_enter_dayroom" );
}

// Namespace cp_mi_sing_sgen_fallen_soldiers
// Params 0
// Checksum 0xb10041ab, Offset: 0x17b8
// Size: 0x7a
function wait_till_an_initial_zone_spawned()
{
    t_spawn_left = getent( "fallen_soldiers_left_first_spawn_trig", "targetname" );
    t_spawn_right = getent( "fallen_soldiers_right_first_spawn_trig", "targetname" );
    t_spawn_left endon( #"death" );
    t_spawn_right waittill( #"death" );
}

// Namespace cp_mi_sing_sgen_fallen_soldiers
// Params 2
// Checksum 0x787e19de, Offset: 0x1840
// Size: 0x1cc
function wait_till_zone_safe_then_move( str_key, str_val )
{
    if ( !isdefined( str_val ) )
    {
        str_val = "targetname";
    }
    
    self endon( #"death" );
    level endon( #"fallen_soldiers_robots_cleared" );
    t_safe = getent( str_key, str_val );
    nd_safe = getnode( t_safe.target, "targetname" );
    t_safe endon( #"death" );
    
    do
    {
        t_safe waittill( #"trigger" );
        n_touchers = 0;
        a_ai_robots = getaispeciesarray( "team3", "robot" );
        
        foreach ( ai_robot in a_ai_robots )
        {
            if ( isalive( ai_robot ) && ai_robot istouching( self ) )
            {
                n_touchers++;
            }
        }
        
        wait 1.5;
    }
    while ( n_touchers > 0 );
    
    self setgoal( nd_safe );
}

// Namespace cp_mi_sing_sgen_fallen_soldiers
// Params 0
// Checksum 0x35bac656, Offset: 0x1a18
// Size: 0x364
function fallen_soldiers_objective()
{
    t_hack = getent( "trig_testing_lab_door", "targetname" );
    t_hack triggerenable( 0 );
    level thread sgen_util::set_door_state( "fallen_soldiers_decon_hallway_door", "close" );
    level scene::add_scene_func( "cin_sgen_12_01_corvus_vign_secret_entrance_hendricks", &drone_breadcrumb, "init" );
    level scene::init( "cin_sgen_12_01_corvus_vign_secret_entrance_hendricks" );
    level flag::wait_till( "player_entered_corvus" );
    level flag::wait_till( "hendricks_corvus_examination" );
    
    if ( isdefined( level.bzm_sgendialogue5callback ) )
    {
        level thread [[ level.bzm_sgendialogue5callback ]]();
    }
    
    level scene::add_scene_func( "cin_sgen_12_01_corvus_vign_secret_entrance_hendricks", &open_entrance_hall_doors, "play" );
    level scene::play( "cin_sgen_12_01_corvus_vign_secret_entrance_hendricks" );
    level thread namespace_d40478f6::function_22982c6e();
    level.ai_hendricks waittill( #"goal" );
    wait 0.5;
    level scene::init( "cin_sgen_13_01_fallensoldiers_vign_grab_start" );
    trigger::wait_till( "fallen_soldiers_enter_decon_trig" );
    level thread sgen_util::set_door_state( "fallen_soldiers_enter_door", "open" );
    level notify( #"hash_3b302c78" );
    trigger::wait_till( "fallen_soldiers_hendricks_grab_start", undefined, undefined, 0 );
    level scene::play( "cin_sgen_13_01_fallensoldiers_vign_grab_start" );
    t_room = getent( "decontamination_room_trigger", "targetname" );
    t_room sgen_util::gather_point_wait( 1, array( level.ai_hendricks ) );
    level notify( #"decon_gather_done" );
    level thread sgen_util::set_door_state( "fallen_soldiers_enter_door", "close" );
    level notify( #"decon_room_door_close" );
    wait 1.3;
    scene::add_scene_func( "cin_sgen_13_01_fallensoldiers_vign_grab_end", &function_2f485a41 );
    level scene::play( "cin_sgen_13_01_fallensoldiers_vign_grab_end" );
    level flag::set( "fallen_soldiers_hendricks_ready" );
}

// Namespace cp_mi_sing_sgen_fallen_soldiers
// Params 1
// Checksum 0x3ad078fa, Offset: 0x1d88
// Size: 0xaa
function function_2f485a41( a_ents )
{
    foreach ( e_robot in a_ents )
    {
        if ( e_robot.targetname == "fallen_soldiers_grab_robot" )
        {
            e_robot thread function_d43d6872();
        }
    }
}

// Namespace cp_mi_sing_sgen_fallen_soldiers
// Params 0
// Checksum 0x77ffd898, Offset: 0x1e40
// Size: 0x5c
function function_d43d6872()
{
    self waittill( #"lights_on" );
    self clientfield::set( "play_cia_robot_rogue_control", 1 );
    self waittill( #"lights_out" );
    self clientfield::set( "play_cia_robot_rogue_control", 0 );
}

// Namespace cp_mi_sing_sgen_fallen_soldiers
// Params 1
// Checksum 0x3039620e, Offset: 0x1ea8
// Size: 0xaa
function open_entrance_hall_doors( a_ents )
{
    level waittill( #"hendricks_approaching_exit" );
    level flag::set( "fallen_soldiers_hendricks_approaching_exit" );
    level.ai_hendricks setgoal( getnode( "fallen_soldiers_hendricks_decon_ready_node", "targetname" ), 1 );
    level thread sgen_util::set_door_state( "fallen_soldiers_decon_hallway_door", "open" );
    level notify( #"corvus_entrance_opened" );
}

// Namespace cp_mi_sing_sgen_fallen_soldiers
// Params 0
// Checksum 0x87dc8442, Offset: 0x1f60
// Size: 0x34c
function fallen_soldiers_room()
{
    a_t_robot = getentarray( "fallen_soldiers_robot_trigger", "script_noteworthy" );
    sp_robot = getent( "fallen_soldiers_spawner", "targetname" );
    a_t_wakeup = getentarray( "fallen_soldiers_walkeup_looktrig", "targetname" );
    array::thread_all( a_t_wakeup, &wakeup_think );
    
    foreach ( t_robot in a_t_robot )
    {
        t_robot thread fallen_soldiers_robot_trigger_init( sp_robot );
    }
    
    level thread sgen_util::set_door_state( "fallen_soldiers_enter_door", "close" );
    level flag::wait_till( "fallen_soldiers_hendricks_ready" );
    level flag::set( "fallen_soldiers_robots_wakeup_started" );
    playsoundatposition( "evt_decon_light_breaker", ( 828, -1411, -4552 ) );
    exploder::exploder( "fallen_soldiers_decon_spray" );
    exploder::exploder( "lgt_light_deconroom" );
    level.ai_hendricks.goalradius = 16;
    level.ai_hendricks ai::set_ignoreme( 1 );
    level.ai_hendricks setgoal( getnode( "fallen_soldiers_hendricks_decon_battle_node", "targetname" ), 1 );
    t_decon_room = getent( "fallen_soldiers_decon_room_wake_trig", "targetname" );
    t_decon_room waittill( #"death" );
    wait_till_all_dead_or_timeout( 7, "fallen_soldiers_robots_decon_room_cleared" );
    spawn_manager::enable( "fallen_soldiers_decon_room_door_rushers_spawnmanager" );
    level notify( #"decon_room_door_open" );
    level thread sgen_util::set_door_state( "fallen_soldiers_exit_door", "open" );
    spawn_manager::wait_till_complete( "fallen_soldiers_decon_room_door_rushers_spawnmanager" );
    level thread hendricks_battle_movement();
    trigger::wait_till( "fallen_soldiers_decon_room_exit_trig" );
}

// Namespace cp_mi_sing_sgen_fallen_soldiers
// Params 0
// Checksum 0xba69de56, Offset: 0x22b8
// Size: 0x62
function play_hendricks_dayroom_scene()
{
    level scene::add_scene_func( "cin_sgen_12_01_corvus_vign_dayroom", &set_hendricks_end_goal, "play" );
    level scene::play( "cin_sgen_12_01_corvus_vign_dayroom" );
    level notify( #"hendricks_dayroom_done" );
}

// Namespace cp_mi_sing_sgen_fallen_soldiers
// Params 1
// Checksum 0x302cfc14, Offset: 0x2328
// Size: 0x9c
function set_hendricks_end_goal( a_ents )
{
    level.ai_hendricks colors::disable();
    level.ai_hendricks.goalradius = 16;
    level.ai_hendricks setgoal( getnode( "fallen_soldiers_hendricks_hack_door_node", "targetname" ), 1 );
    level.ai_hendricks waittill( #"goal" );
    level.ai_hendricks clearforcedgoal();
}

// Namespace cp_mi_sing_sgen_fallen_soldiers
// Params 0
// Checksum 0x294a0bb0, Offset: 0x23d0
// Size: 0x29c
function vo()
{
    util::waittill_any( "player_saw_drone", "hendricks_approaching_drone" );
    level thread namespace_d40478f6::function_55f6ee71();
    level dialog::player_say( "plyr_what_the_hell_happen_0" );
    level notify( #"hash_d840edf1" );
    level thread namespace_d40478f6::function_973b77f9();
    objectives::complete( "cp_level_sgen_find_recon_drone" );
    level waittill( #"hash_3b302c78" );
    level dialog::player_say( "plyr_what_s_going_on_here_0", 1.5 );
    level waittill( #"decon_room_door_close" );
    playsoundatposition( "evt_decon_alarm", ( 796, -1406, -4604 ) );
    level thread namespace_d40478f6::function_3eb3d06();
    level waittill( #"hash_2b998700" );
    level.ai_hendricks dialog::say( "hend_what_the_hell_0" );
    level battlechatter::function_d9f49fba( 1 );
    level waittill( #"decon_room_door_open" );
    objectives::set( "cp_level_sgen_goto_signal_source" );
    level waittill( #"robot_woke_up" );
    level flag::wait_till( "fallen_soldiers_robots_cleared" );
    level battlechatter::function_d9f49fba( 0 );
    level thread namespace_d40478f6::function_973b77f9();
    level thread function_c1c96249();
    level.ai_hendricks dialog::say( "hend_area_clear_stay_ale_0", 1.5 );
    level dialog::player_say( "plyr_kane_you_ever_see_a_0", 0.2 );
    level dialog::remote( "kane_i_ve_never_seen_any_0", 0.2 );
    level thread say_dayroom_gps_vo();
    level flag::set( "kane_robots_convo_done" );
}

// Namespace cp_mi_sing_sgen_fallen_soldiers
// Params 0
// Checksum 0xd66c1529, Offset: 0x2678
// Size: 0x74
function say_dayroom_gps_vo()
{
    trigger::wait_till( "fallen_soldiers_enter_reception_looktrig" );
    level thread namespace_d40478f6::function_973b77f9();
    level flag::wait_till( "kane_robots_convo_done" );
    level dialog::remote( "kane_according_to_the_gps_0" );
}

// Namespace cp_mi_sing_sgen_fallen_soldiers
// Params 0
// Checksum 0x9eca454e, Offset: 0x26f8
// Size: 0xda
function function_c1c96249()
{
    if ( sessionmodeiscampaignzombiesgame() )
    {
        return;
    }
    
    level endon( #"hash_89d9c0f" );
    level endon( #"hash_c1907e5d" );
    var_337b3942 = getent( "dayroom_salim_speaker", "targetname" );
    
    for ( i = 1; i < 6 ; i++ )
    {
        var_2050b70 = "vox_sgen_visual_extracts_00" + i + "_salm";
        var_337b3942 playsoundwithnotify( var_2050b70, "sounddone" );
        var_337b3942 waittill( #"sounddone" );
        wait 5;
    }
}

// Namespace cp_mi_sing_sgen_fallen_soldiers
// Params 0
// Checksum 0x5252143e, Offset: 0x27e0
// Size: 0x118
function function_68f0b726()
{
    if ( sessionmodeiscampaignzombiesgame() )
    {
        return;
    }
    
    var_277885f5 = getentarray( "trig_salim_journal_use", "targetname" );
    level.var_38cfe33a = [];
    level.var_d0b26d28 = 0;
    
    foreach ( trigger in var_277885f5 )
    {
        level.var_38cfe33a[ trigger.script_int ] = util::init_interactive_gameobject( trigger, &"cp_prompt_dni_sgen_access_journal", &"CP_MI_SING_SGEN_ACCESS_JOURNAL", &function_a43abada );
    }
}

// Namespace cp_mi_sing_sgen_fallen_soldiers
// Params 0
// Checksum 0xf97266f9, Offset: 0x2900
// Size: 0x44
function function_88a16751()
{
    self stopsounds();
    wait 0.1;
    self playsound( "evt_salim_speaker_destroy" );
}

// Namespace cp_mi_sing_sgen_fallen_soldiers
// Params 0
// Checksum 0xca95eb43, Offset: 0x2950
// Size: 0x214
function function_a43abada()
{
    var_6a8436fc = self getlinkedent();
    var_c50aa484 = spawn( "script_origin", self.origin );
    level.var_d0b26d28++;
    level notify( #"hash_c1907e5d" );
    var_337b3942 = getent( "dayroom_salim_speaker", "targetname" );
    var_337b3942 thread function_88a16751();
    
    switch ( level.var_d0b26d28 )
    {
        case 1:
            var_55df1164 = "vox_sgen_medical_logs_001_salm";
            break;
        case 2:
            var_55df1164 = "vox_sgen_medical_logs_002_salm";
            break;
        case 3:
            var_55df1164 = "vox_sgen_medical_logs_003_salm";
            break;
        case 4:
            var_55df1164 = "vox_sgen_medical_logs_004_salm";
            break;
        case 5:
            var_55df1164 = "vox_sgen_medical_logs_005_salm";
            break;
        case 6:
            var_55df1164 = "vox_sgen_medical_logs_006_salm";
            break;
        case 7:
            var_55df1164 = "vox_sgen_medical_logs_007_salm";
            break;
    }
    
    if ( isdefined( level.var_79b63714 ) )
    {
        level.var_79b63714 stopsounds();
    }
    
    var_c50aa484 playsound( var_55df1164 );
    level.var_79b63714 = var_c50aa484;
    
    if ( level.var_d0b26d28 == 7 )
    {
        sgen_accolades::function_c75f9c25();
    }
    
    self gameobjects::destroy_object( 1 );
    self delete();
}

// Namespace cp_mi_sing_sgen_fallen_soldiers
// Params 2
// Checksum 0x28d5a57d, Offset: 0x2b70
// Size: 0x64
function wait_till_all_dead_or_timeout( n_timeout, str_flag )
{
    level thread monitor_encounter( str_flag );
    level flag::wait_till_timeout( n_timeout, str_flag );
    level flag::set( str_flag );
}

// Namespace cp_mi_sing_sgen_fallen_soldiers
// Params 0
// Checksum 0xc18628b4, Offset: 0x2be0
// Size: 0xd8
function wakeup_think()
{
    self endon( #"death" );
    level endon( #"fallen_soldiers_terminate" );
    s_lookpoint = struct::get( self.target, "targetname" );
    t_activate = getent( s_lookpoint.target, "targetname" );
    t_activate endon( #"death" );
    
    while ( true )
    {
        self waittill( #"trigger" );
        
        if ( isdefined( t_activate ) )
        {
            t_activate trigger::use();
            continue;
        }
        
        self delete();
    }
}

// Namespace cp_mi_sing_sgen_fallen_soldiers
// Params 1
// Checksum 0xecd6999c, Offset: 0x2cc0
// Size: 0x1fc
function fallen_soldiers_robot_trigger_init( sp_robot )
{
    self endon( #"death" );
    level endon( #"fallen_soldiers_terminate" );
    assert( isdefined( self.target ), "<dev string:x28>" + self.origin );
    a_ai_robots = [];
    a_s_scriptbundles = struct::get_array( self.target );
    
    foreach ( n_count, s_scriptbundle in a_s_scriptbundles )
    {
        a_ai_robots[ n_count ] = spawner::simple_spawn_single( sp_robot );
        s_scriptbundle thread scene::init( a_ai_robots[ n_count ] );
    }
    
    level flag::wait_till( "fallen_soldiers_robots_wakeup_started" );
    
    foreach ( n_count, s_scriptbundle in a_s_scriptbundles )
    {
        if ( isalive( a_ai_robots[ n_count ] ) )
        {
            self fallen_soldiers_robot_wakeup( a_ai_robots[ n_count ], s_scriptbundle );
        }
    }
    
    self delete();
}

// Namespace cp_mi_sing_sgen_fallen_soldiers
// Params 2
// Checksum 0xd672ca75, Offset: 0x2ec8
// Size: 0xba
function fallen_soldiers_robot_wakeup( ai_robot, s_scriptbundle )
{
    level endon( #"fallen_soldiers_terminate" );
    ai_robot endon( #"death" );
    self endon( #"death" );
    self util::waittill_any_ents( ai_robot, "damage", self, "trigger" );
    wait randomfloatrange( 0.1, 0.25 );
    ai_robot robot_wake_up();
    s_scriptbundle scene::play( ai_robot );
    level notify( #"robot_woke_up" );
}

// Namespace cp_mi_sing_sgen_fallen_soldiers
// Params 0
// Checksum 0x4765cff8, Offset: 0x2f90
// Size: 0xc4
function wait_till_wakeup_cooldown_expired()
{
    n_min_wait = sgen_util::get_num_scaled_by_player_count( 1.3, -0.25 );
    n_max_wait = sgen_util::get_num_scaled_by_player_count( 2.4, -0.51 );
    
    if ( n_min_wait < 0 )
    {
        n_min_wait = 0;
    }
    
    if ( n_max_wait <= 0 )
    {
        n_max_wait = 0.2;
    }
    
    wait randomfloatrange( n_min_wait, n_max_wait );
}

// Namespace cp_mi_sing_sgen_fallen_soldiers
// Params 0
// Checksum 0xf194bc8, Offset: 0x3060
// Size: 0x64
function robot_wake_spawnfunc()
{
    self.team = "team3";
    self ai::set_ignoreme( 1 );
    self ai::set_ignoreall( 1 );
    self ai::set_behavior_attribute( "robot_lights", 2 );
}

// Namespace cp_mi_sing_sgen_fallen_soldiers
// Params 0
// Checksum 0xda385cbe, Offset: 0x30d0
// Size: 0x11c
function robot_spawnfunc()
{
    self endon( #"death" );
    self.team = "team3";
    self.is_awoken = 1;
    n_level = 2;
    
    if ( isdefined( self.script_int ) )
    {
        n_level = self.script_int;
    }
    
    if ( isdefined( self.script_string ) )
    {
        if ( self.script_string == "crawler" )
        {
            self.crawlerlifetime = gettime() + randomintrange( 20000, 30000 );
            self ai::set_behavior_attribute( "force_crawler", "remove_legs" );
            self ai::set_behavior_attribute( "rogue_control", "forced_level_1" );
        }
        
        return;
    }
    
    self ai::set_behavior_attribute( "rogue_control", "forced_level_" + n_level );
}

// Namespace cp_mi_sing_sgen_fallen_soldiers
// Params 0
// Checksum 0x83efbbfe, Offset: 0x31f8
// Size: 0xa4
function robot_wake_up()
{
    self.is_awoken = 1;
    self playsound( "evt_robot_ambush_arise" );
    self ai::set_ignoreme( 0 );
    self ai::set_ignoreall( 0 );
    self ai::set_behavior_attribute( "robot_lights", 0 );
    self ai::set_behavior_attribute( "rogue_control", "forced_level_2" );
}

// Namespace cp_mi_sing_sgen_fallen_soldiers
// Params 1
// Checksum 0x18f61498, Offset: 0x32a8
// Size: 0x74
function monitor_encounter( str_flag )
{
    level endon( str_flag );
    a_ai_robots = getaispeciesarray( "team3", "robot" );
    a_ai_robots wait_till_all_death( str_flag );
    level flag::set( str_flag );
}

// Namespace cp_mi_sing_sgen_fallen_soldiers
// Params 1
// Checksum 0xb09c994b, Offset: 0x3328
// Size: 0xd0
function wait_till_all_death( str_ender )
{
    level endon( str_ender );
    
    foreach ( ai_robot in self )
    {
        if ( isdefined( ai_robot.is_awoken ) && isalive( ai_robot ) && ai_robot.is_awoken )
        {
            ai_robot waittill( #"death" );
        }
    }
}

// Namespace cp_mi_sing_sgen_fallen_soldiers
// Params 0
// Checksum 0x164fa10a, Offset: 0x3400
// Size: 0x3c
function encounter_kill_spawnmanagers()
{
    trigger::wait_till( "fallen_soldiers_encounter_clear_trig", undefined, undefined, 0 );
    spawn_manager::kill( "fallen_soldiers_mid_encounter_group" );
}

// Namespace cp_mi_sing_sgen_fallen_soldiers
// Params 0
// Checksum 0x9ea5e662, Offset: 0x3448
// Size: 0xc4
function handle_breadcrumbs()
{
    level waittill( #"corvus_entrance_opened" );
    objectives::set( "cp_level_sgen_goto_signal_source" );
    level thread objectives::breadcrumb( "fallen_soldiers_decon_breadcrumb" );
    level waittill( #"decon_gather_done" );
    objectives::complete( "cp_waypoint_breadcrumb" );
    level waittill( #"decon_room_door_open" );
    level thread objectives::breadcrumb( "fallen_soldiers_decon_room_breadcrumb_start" );
    level waittill( #"hendricks_dayroom_done" );
    level thread objectives::breadcrumb( "fallen_soldiers_end_breadcrumb_trig" );
}

// Namespace cp_mi_sing_sgen_fallen_soldiers
// Params 1
// Checksum 0x19253b3e, Offset: 0x3518
// Size: 0x74
function drone_breadcrumb( a_ents )
{
    objectives::set( "cp_waypoint_breadcrumb", a_ents[ "mapping_drone" ] );
    trigger::wait_till( "fallen_soldiers_drone_intro_looktrig" );
    objectives::complete( "cp_waypoint_breadcrumb", a_ents[ "mapping_drone" ] );
}

