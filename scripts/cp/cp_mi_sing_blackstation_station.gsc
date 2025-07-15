#using scripts/codescripts/struct;
#using scripts/cp/_dialog;
#using scripts/cp/_load;
#using scripts/cp/_objectives;
#using scripts/cp/_skipto;
#using scripts/cp/_spawn_manager;
#using scripts/cp/_util;
#using scripts/cp/cp_mi_sing_blackstation;
#using scripts/cp/cp_mi_sing_blackstation_accolades;
#using scripts/cp/cp_mi_sing_blackstation_sound;
#using scripts/cp/cp_mi_sing_blackstation_utility;
#using scripts/cp/cybercom/_cybercom;
#using scripts/cp/cybercom/_cybercom_gadget_firefly;
#using scripts/cp/cybercom/_cybercom_util;
#using scripts/cp/gametypes/_save;
#using scripts/shared/ai/archetype_warlord_interface;
#using scripts/shared/ai_shared;
#using scripts/shared/animation_shared;
#using scripts/shared/array_shared;
#using scripts/shared/audio_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/colors_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/flagsys_shared;
#using scripts/shared/fx_shared;
#using scripts/shared/gameobjects_shared;
#using scripts/shared/lui_shared;
#using scripts/shared/math_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/trigger_shared;
#using scripts/shared/turret_shared;
#using scripts/shared/util_shared;
#using scripts/shared/vehicle_shared;
#using scripts/shared/vehicleriders_shared;

#namespace cp_mi_sing_blackstation_station;

// Namespace cp_mi_sing_blackstation_station
// Params 0
// Checksum 0xc6574fbe, Offset: 0x1838
// Size: 0x294
function station_main()
{
    level.var_e121f644 = 0;
    level.var_6999c9ec = 0;
    level.a_warlord_nodes = getnodearray( "black_station_warlord_preferred_node", "targetname" );
    level.var_c5719229 = 0;
    level thread ally_behaviors();
    level thread function_86861a95();
    level thread technical_2_spawning();
    level thread technical_3_spawning();
    level thread function_7c8de67c();
    level thread exterior_ai_spawning();
    level thread function_41ad2775();
    level thread lightning_strike();
    level thread function_c31f21d6();
    level thread function_60578067();
    level thread function_d9afa854();
    level thread technical_1_spawning();
    level thread function_9694617b();
    level thread spawn_warlord();
    level thread function_d83742ed();
    level thread function_5493cb1d();
    level thread function_5e698598();
    
    if ( isdefined( level.bzm_blackstationdialogue4_3callback ) )
    {
        level thread [[ level.bzm_blackstationdialogue4_3callback ]]();
    }
    
    level thread blackstation_accolades::function_328b2c47();
    array::thread_all( level.activeplayers, &blackstation_utility::function_d870e0, "trig_exterior_color01" );
    array::thread_all( level.activeplayers, &clientfield::set_to_player, "toggle_rain_sprite", 0 );
    level flag::wait_till( "exterior_ready_weapons" );
}

// Namespace cp_mi_sing_blackstation_station
// Params 0
// Checksum 0xe9b8784b, Offset: 0x1ad8
// Size: 0x102
function function_5e698598()
{
    level flag::wait_till( "warlord_dead" );
    var_a4f91ad6 = getaiteamarray( "axis" );
    
    foreach ( ai_guy in var_a4f91ad6 )
    {
        if ( ai_guy.origin[ 0 ] > -3100 )
        {
            if ( isalive( ai_guy ) )
            {
                ai_guy kill();
            }
        }
    }
}

// Namespace cp_mi_sing_blackstation_station
// Params 2
// Checksum 0xbedab5, Offset: 0x1be8
// Size: 0x254
function objective_blackstation_exterior_init( str_objective, b_starting )
{
    if ( b_starting )
    {
        load::function_73adcefc();
        blackstation_utility::init_hendricks( "objective_blackstation_exterior_hendricks" );
        blackstation_utility::init_kane( "objective_blackstation_exterior" );
        level.ai_kane ai::set_ignoreall( 1 );
        level thread scene::play( "cin_bla_13_02_looting_vign_lightningstrike_ziplinetalk_kane_idle" );
        load::function_a2995f22();
        var_23419962 = getent( "trigger_talk_kane", "targetname" );
        var_23419962 delete();
        level flag::set( "hendricks_crossed" );
        level flag::set( "goto_zipline" );
        level flag::set( "talk_kane" );
        level flag::set( "hendricks_zipline" );
        level function_5142ef8e();
        level function_b8052aae();
    }
    
    level thread blackstation_utility::player_rain_intensity( "none" );
    level scene::add_scene_func( "p7_fxanim_gp_shutters_sm_02_blue_s4_bundle", &function_d6a0893b, "play" );
    level thread scene::play( "blackstation_exterior_shutters" );
    level thread function_ac6ad822();
    streamerrequest( "set", "cp_mi_sing_blackstation_objective_end_igc" );
    station_main();
}

// Namespace cp_mi_sing_blackstation_station
// Params 4
// Checksum 0x2318558b, Offset: 0x1e48
// Size: 0x24
function objective_blackstation_exterior_done( str_objective, b_starting, b_direct, player )
{
    
}

// Namespace cp_mi_sing_blackstation_station
// Params 1
// Checksum 0x20c7fdcb, Offset: 0x1e78
// Size: 0xb2
function function_d6a0893b( a_ents )
{
    foreach ( var_e62a2544 in a_ents )
    {
        if ( var_e62a2544.origin[ 2 ] < 200 )
        {
            var_e62a2544 notsolid();
        }
    }
}

// Namespace cp_mi_sing_blackstation_station
// Params 0
// Checksum 0xf2178c5e, Offset: 0x1f38
// Size: 0xf0
function function_ac6ad822()
{
    level endon( #"zipline_player_landed" );
    
    while ( true )
    {
        if ( math::cointoss() )
        {
            exploder::exploder( "exp_lightning_blackstation_exterior_f_01" );
        }
        else
        {
            exploder::exploder( "exp_lightning_blackstation_exterior_f_02" );
        }
        
        wait randomfloatrange( 5, 8 );
        
        if ( math::cointoss() )
        {
            exploder::exploder( "exp_lightning_blackstation_exterior_f_01" );
        }
        else
        {
            exploder::exploder( "exp_lightning_blackstation_exterior_f_02" );
        }
        
        wait randomfloatrange( 5, 8 );
    }
}

// Namespace cp_mi_sing_blackstation_station
// Params 0
// Checksum 0xa23e8acf, Offset: 0x2030
// Size: 0x214
function function_5142ef8e()
{
    spawner::add_spawn_function_group( "upper_group1", "targetname", &starting_ai_behavior );
    spawner::add_spawn_function_group( "exterior_robots", "targetname", &starting_ai_behavior );
    spawner::add_spawn_function_group( "lower_exterior_group01", "targetname", &starting_ai_behavior );
    spawner::add_spawn_function_group( "exterior_robots_guards", "script_aigroup", &guard_behavior );
    spawner::add_spawn_function_group( "exterior_robots_pathers", "script_aigroup", &pather_behavior );
    spawner::add_spawn_function_group( "lightning_struck_gib", "script_noteworthy", &robot_lightning_behavior );
    spawner::add_spawn_function_group( "lightning_struck_shock", "script_noteworthy", &robot_lightning_behavior );
    spawner::add_spawn_function_group( "lightning_launch_ai", "script_noteworthy", &lightning_launch_ai );
    spawner::add_spawn_function_group( "exterior_gunner_front", "script_noteworthy", &lightning_launch_ai );
    spawner::add_spawn_function_group( "blackstation_warlord_spawner", "script_noteworthy", &warlord_behavior );
    spawner::add_spawn_function_group( "exterior_patroller", "script_noteworthy", &patroller_behavior );
}

// Namespace cp_mi_sing_blackstation_station
// Params 0
// Checksum 0xead854ae, Offset: 0x2250
// Size: 0xac
function function_86861a95()
{
    var_b61d7410 = getent( "trig_zipline01", "targetname" );
    level thread setup_zipline_down( var_b61d7410 );
    var_2824e34b = getent( "trig_zipline02", "targetname" );
    level thread setup_zipline_down( var_2824e34b );
    level thread function_b78bbba4();
}

// Namespace cp_mi_sing_blackstation_station
// Params 0
// Checksum 0x1bc9b6f2, Offset: 0x2308
// Size: 0x5c
function function_b8052aae()
{
    spawner::simple_spawn( "perimeter_patrol", &function_50eaaa70 );
    wait 0.5;
    spawner::simple_spawn( "exterior_working_robots", &starting_ai_behavior );
}

// Namespace cp_mi_sing_blackstation_station
// Params 0
// Checksum 0x9d7cbc6e, Offset: 0x2370
// Size: 0x10c
function function_d9afa854()
{
    level flag::wait_till( "talk_kane" );
    spawn_manager::enable( "sm_upper_group1" );
    level flag::wait_till( "ziplines_ready" );
    spawner::simple_spawn( "lower_exterior_group01", &starting_ai_behavior );
    wait 0.5;
    spawn_manager::enable( "sm_exterior_robots" );
    level.a_starting_ai = getaiteamarray( "axis" );
    level flag::wait_till( "blackstation_exterior_engaged" );
    spawner::simple_spawn( "sniper_exterior_group01", &function_bfa694b0 );
}

// Namespace cp_mi_sing_blackstation_station
// Params 0
// Checksum 0x9e5cf818, Offset: 0x2488
// Size: 0xdc
function function_b0c674cf()
{
    if ( level.activeplayers.size < 3 )
    {
        if ( level.str_zipline == "left" )
        {
            spawner::simple_spawn_single( "sniper_right", &function_2dafb2d1 );
        }
        else
        {
            spawner::simple_spawn_single( "sniper_left", &function_2dafb2d1 );
        }
        
        return;
    }
    
    spawner::simple_spawn_single( "sniper_right", &function_2dafb2d1 );
    spawner::simple_spawn_single( "sniper_left", &function_2dafb2d1 );
}

// Namespace cp_mi_sing_blackstation_station
// Params 0
// Checksum 0x2bb141c9, Offset: 0x2570
// Size: 0x74
function function_41ad2775()
{
    level flag::wait_till( "zipline_player_landed" );
    level thread objectives::breadcrumb( "blackstation_exterior_breadcrumb" );
    trigger::wait_till( "trig_waypoint_station01" );
    skipto::objective_completed( "objective_blackstation_exterior" );
}

// Namespace cp_mi_sing_blackstation_station
// Params 0
// Checksum 0xc6f48d03, Offset: 0x25f0
// Size: 0x24
function function_3d53956f()
{
    level thread objectives::breadcrumb( "blackstation_interior_breadcrumb" );
}

// Namespace cp_mi_sing_blackstation_station
// Params 0
// Checksum 0x804040f9, Offset: 0x2620
// Size: 0xdc
function track_location_for_low_ready()
{
    self endon( #"death" );
    self endon( #"used_zipline" );
    trigger::wait_till( "trig_waypoint_station00", "targetname", self );
    self util::set_low_ready( 1 );
    
    do
    {
        wait 1;
    }
    while ( self istouching( getent( "trig_waypoint_station00", "targetname" ) ) );
    
    self util::set_low_ready( 0 );
    
    if ( !level flag::get( "exterior_ready_weapons" ) )
    {
        self track_location_for_low_ready();
    }
}

// Namespace cp_mi_sing_blackstation_station
// Params 0
// Checksum 0x62eb4fd, Offset: 0x2708
// Size: 0xc4
function function_d83742ed()
{
    level flag::wait_till( "approach_intersection" );
    level flag::wait_till( "warlord_dead" );
    trigger::use( "triggercolor_station_advance" );
    level flag::wait_till( "goto_entrance" );
    level thread function_a05c3d53();
    trigger::use( "triggercolor_station_entrance" );
    wait 2;
    level thread function_4b241521();
}

// Namespace cp_mi_sing_blackstation_station
// Params 0
// Checksum 0xcba047cc, Offset: 0x27d8
// Size: 0x1e4
function function_4b241521()
{
    level flag::wait_till( "exterior_clear" );
    level scene::init( "cin_bla_14_02_blackstation_vign_takepoint" );
    level thread scene::play( "p7_fxanim_gp_lantern_chinese_red_04_bs_bundle" );
    level.ai_hendricks thread function_8632f992();
    level.ai_hendricks colors::disable();
    level.ai_hendricks ai::set_behavior_attribute( "vignette_mode", "slow" );
    level.ai_hendricks setgoal( getnode( "nd_door_kick", "targetname" ), 1 );
    level.ai_hendricks util::waittill_any( "goal", "kick_door" );
    wait 1;
    level thread scene::play( "cin_gen_aie_door_kick" );
    wait 1;
    level.ai_hendricks colors::enable();
    trigger::use( "triggercolor_station_interior" );
    level notify( #"hash_b5d76c65" );
    level.ai_hendricks ai::set_behavior_attribute( "vignette_mode", "off" );
    getent( "clip_station_door", "targetname" ) delete();
}

// Namespace cp_mi_sing_blackstation_station
// Params 0
// Checksum 0x4ad8a331, Offset: 0x29c8
// Size: 0x22
function function_8632f992()
{
    level endon( #"hash_b5d76c65" );
    wait 15;
    self notify( #"kick_door" );
}

// Namespace cp_mi_sing_blackstation_station
// Params 0
// Checksum 0x10ae3952, Offset: 0x29f8
// Size: 0x59c
function ally_behaviors()
{
    if ( !isdefined( level.ai_kane ) )
    {
        blackstation_utility::init_kane( "objective_blackstation_exterior" );
    }
    
    level.ai_hendricks notify( #"stop_dynamic_run_speed" );
    level.ai_hendricks ai::set_ignoreall( 1 );
    level.ai_kane ai::set_ignoreall( 1 );
    level.ai_kane ai::set_ignoreme( 1 );
    
    foreach ( player in level.players )
    {
        player thread track_location_for_low_ready();
    }
    
    level flag::wait_till( "hendricks_crossed" );
    level flag::wait_till( "hendricks_zipline" );
    level.ai_hendricks setgoal( getnode( "node_zipline", "targetname" ), 1 );
    level.ai_hendricks waittill( #"goal" );
    level flag::wait_till( "talk_kane" );
    level.ai_hendricks ai::set_behavior_attribute( "vignette_mode", "slow" );
    level thread namespace_4297372::function_973b77f9();
    level thread scene::add_scene_func( "cin_bla_13_02_looting_vign_lightningstrike_ziplinetalk_hendricks", &function_20aa53b9 );
    level thread scene::add_scene_func( "cin_bla_13_02_looting_vign_looting_zipline", &function_29ec302d, "play" );
    level thread scene::add_scene_func( "cin_bla_13_02_looting_vign_looting_zipline", &function_b8aa66aa, "done" );
    level scene::play( "cin_bla_13_02_looting_vign_lightningstrike_ziplinetalk_hendricks" );
    level.ai_hendricks ai::set_behavior_attribute( "vignette_mode", "off" );
    wait 4;
    savegame::checkpoint_save();
    level flag::set( "ziplines_ready" );
    objectives::set( "cp_level_blackstation_goto_station" );
    level.ai_hendricks thread function_2d102c76();
    level flag::wait_till( "zipline_player_landed" );
    array::thread_all( level.activeplayers, &function_5fc18bba );
    level thread hendricks_dialog();
    level flag::wait_till( "blackstation_exterior_engaged" );
    level.ai_hendricks thread blackstation_utility::function_dccf6ccc();
    level.ai_hendricks thread function_dfb9eb36();
    level.ai_hendricks ai::set_behavior_attribute( "move_mode", "rambo" );
    level.ai_hendricks ai::set_ignoreall( 0 );
    level.ai_kane ai::set_ignoreall( 0 );
    trigger::use( "trig_exterior_color01" );
    level.ai_kane thread kane_take_out_enemies();
    level flag::wait_till( "kane_move_up" );
    level zipline_allies( level.ai_kane, "trig_zipline01" );
    level.ai_kane ai::set_ignoreme( 0 );
    level.ai_kane thread function_2d102c76();
    level flag::wait_till( "kane_landed" );
    level.ai_kane ai::set_ignoreall( 0 );
    level.ai_kane ai::set_ignoreme( 0 );
    level.ai_kane colors::set_force_color( "y" );
    trigger::use( "trig_exterior_color01", "targetname" );
    wait 2;
    level.ai_kane.holdfire = 0;
}

// Namespace cp_mi_sing_blackstation_station
// Params 1
// Checksum 0x26868271, Offset: 0x2fa0
// Size: 0xbc
function function_29ec302d( a_ents )
{
    t_zip = getent( "trig_zipline01", "targetname" );
    t_zip.b_in_use = 1;
    level waittill( #"hash_808b60ca" );
    level.ai_hendricks playsound( "evt_zipline_attach" );
    level.ai_hendricks playloopsound( "evt_zipline_npc_move", 0.3 );
    wait 0.5;
    t_zip.b_in_use = 0;
}

// Namespace cp_mi_sing_blackstation_station
// Params 1
// Checksum 0x48a67ae3, Offset: 0x3068
// Size: 0x74
function function_b8aa66aa( a_ents )
{
    level.ai_hendricks stoploopsound( 0.1 );
    level.ai_hendricks setgoal( level.ai_hendricks.origin );
    wait 0.5;
    trigger::use( "triggercolor_zipline" );
}

// Namespace cp_mi_sing_blackstation_station
// Params 1
// Checksum 0xd9beca75, Offset: 0x30e8
// Size: 0x44
function function_20aa53b9( a_ents )
{
    objectives::complete( "cp_level_blackstation_rendezvous" );
    level scene::play( "cin_bla_13_02_looting_vign_lightningstrike_ziplinetalk_kane" );
}

// Namespace cp_mi_sing_blackstation_station
// Params 0
// Checksum 0x6552f4fb, Offset: 0x3138
// Size: 0xfc
function function_a561f620()
{
    level endon( #"hendricks_crossed" );
    trigger::wait_till( "trigger_at_zipline" );
    
    if ( level scene::is_playing( "cin_bla_12_01_cross_debris_vign_point" ) )
    {
        level notify( #"hash_62f8dc0c" );
        level scene::stop( "cin_bla_12_01_cross_debris_vign_point" );
        s_pos = struct::get( "hendricks_post_frogger" );
        self skipto::teleport_single_ai( s_pos );
        self colors::enable();
        level flag::set( "hendricks_crossed" );
        self ai::set_ignoreall( 1 );
    }
}

// Namespace cp_mi_sing_blackstation_station
// Params 0
// Checksum 0x432ee5a1, Offset: 0x3240
// Size: 0x84
function hendricks_dialog()
{
    level util::waittill_notify_or_timeout( "exterior_moved_forward", 30 );
    level flag::set( "exterior_ready_weapons" );
    level flag::wait_till( "lightning_strike_done" );
    level flag::set( "blackstation_exterior_engaged" );
}

// Namespace cp_mi_sing_blackstation_station
// Params 0
// Checksum 0xecaaeed6, Offset: 0x32d0
// Size: 0x398
function kane_take_out_enemies()
{
    level endon( #"kane_landed" );
    self ai::set_ignoreme( 1 );
    self thread laser_on();
    self thread laser_off();
    wait 5;
    vh_truck = getent( "exterior_technical01_vh", "targetname" );
    
    if ( isalive( vh_truck ) )
    {
        ai_gunner = vh_truck vehicle::get_rider( "gunner1" );
        
        if ( isalive( ai_gunner ) )
        {
            self thread ai::shoot_at_target( "normal", ai_gunner, "j_head", undefined, undefined, 1 );
            level fx::play( "blood_headpop", ai_gunner gettagorigin( "j_head" ) );
            ai_gunner kill();
        }
    }
    
    wait 2;
    
    while ( true )
    {
        a_ai_enemies = getaiteamarray( "axis" );
        
        for ( i = a_ai_enemies.size - 1; i >= 0 ; i-- )
        {
            if ( a_ai_enemies[ i ].archetype === "warlord" )
            {
                arrayremoveindex( a_ai_enemies, i );
            }
        }
        
        if ( level.activeplayers.size )
        {
            e_player = level.activeplayers[ randomint( level.activeplayers.size ) ];
            
            if ( isalive( e_player ) )
            {
                a_ai_targets = arraysortclosest( a_ai_enemies, e_player.origin );
                
                for ( i = 0; i < a_ai_targets.size ; i++ )
                {
                    if ( isalive( a_ai_targets[ i ] ) )
                    {
                        if ( isalive( e_player ) )
                        {
                            if ( e_player util::is_player_looking_at( a_ai_targets[ i ] gettagorigin( "j_head" ), 0.85, 1 ) && a_ai_targets[ i ].allowdeath === "true" )
                            {
                                self function_3f00de07( a_ai_targets[ i ] );
                                break;
                            }
                        }
                    }
                }
                
                wait randomfloatrange( 4, 5 );
            }
        }
        
        wait 0.1;
    }
}

// Namespace cp_mi_sing_blackstation_station
// Params 1
// Checksum 0x9a5dd807, Offset: 0x3670
// Size: 0xc4
function function_3f00de07( ai_enemy )
{
    ai_enemy endon( #"death" );
    self thread ai::shoot_at_target( "normal", ai_enemy, "j_head" );
    wait 1;
    self.holdfire = 0;
    
    if ( ai_enemy.archetype == "human" )
    {
        level fx::play( "blood_headpop", ai_enemy gettagorigin( "j_head" ) );
    }
    
    self.holdfire = 1;
    ai_enemy kill();
}

// Namespace cp_mi_sing_blackstation_station
// Params 0
// Checksum 0x9c82b812, Offset: 0x3740
// Size: 0x38
function laser_on()
{
    self endon( #"laser_off" );
    
    while ( true )
    {
        self laseron();
        wait 0.05;
    }
}

// Namespace cp_mi_sing_blackstation_station
// Params 0
// Checksum 0x2a9347e2, Offset: 0x3780
// Size: 0x54
function laser_off()
{
    trigger::wait_till( "trigger_station_approach" );
    self notify( #"laser_off" );
    util::wait_network_frame();
    self laseroff();
}

// Namespace cp_mi_sing_blackstation_station
// Params 0
// Checksum 0x48cc1f46, Offset: 0x37e0
// Size: 0x10c
function lightning_strike()
{
    level flag::wait_till( "lightning_hit" );
    level flag::set( "lightning_strike" );
    s_strike = struct::get( "station_strike01" );
    level fx::play( "lightning_strike", s_strike.origin, ( -90, 0, 0 ) );
    exploder::exploder( "fx_expl_lightning_strike_blkstn_ext" );
    playsoundatposition( "amb_2d_thunder_hits", s_strike.origin );
    wait 0.5;
    level flag::set( "lightning_strike_done" );
}

// Namespace cp_mi_sing_blackstation_station
// Params 0
// Checksum 0x92a51e16, Offset: 0x38f8
// Size: 0xfa
function function_c31f21d6()
{
    level endon( #"lightning_hit" );
    level flag::wait_till( "blackstation_exterior_engaged" );
    wait 2;
    a_ai_robots = getentarray( "exterior_working_robots_ai", "targetname" );
    
    foreach ( ai_robot in a_ai_robots )
    {
        array::thread_all( level.activeplayers, &function_5eb38a05, ai_robot );
    }
}

// Namespace cp_mi_sing_blackstation_station
// Params 1
// Checksum 0x2b8be1be, Offset: 0x3a00
// Size: 0x74
function function_5eb38a05( ai_robot )
{
    self endon( #"death" );
    level endon( #"lightning_hit" );
    self util::waittill_player_looking_at( ai_robot getcentroid(), 30, 1 );
    level flag::set( "lightning_hit" );
}

// Namespace cp_mi_sing_blackstation_station
// Params 0
// Checksum 0xdd8c16fa, Offset: 0x3a80
// Size: 0x100
function function_7c8de67c()
{
    level endon( #"zipline_player_landed" );
    level flag::wait_till( "talk_kane" );
    var_3de152e1 = struct::get_array( "ambient_strike" );
    
    while ( true )
    {
        s_strike = array::random( var_3de152e1 );
        level fx::play( "lightning_strike", s_strike.origin, ( -90, 0, 0 ) );
        playsoundatposition( "amb_2d_thunder_hits", s_strike.origin );
        wait randomfloatrange( 3.5, 5.5 );
    }
}

// Namespace cp_mi_sing_blackstation_station
// Params 0
// Checksum 0xd2d58ac8, Offset: 0x3b88
// Size: 0x184
function lightning_launch_ai()
{
    self endon( #"death" );
    level flag::wait_till( "lightning_strike" );
    wait 0.2;
    
    if ( self.script_noteworthy === "exterior_gunner_front" )
    {
        self thread animation::play( self.rider_info.ridedeathanim );
        self startragdoll();
        self launchragdoll( ( 50, 0, 90 ) );
        self flagsys::clear( "in_vehicle" );
        vehicle::unclaim_position( self.vehicle, self.rider_info.position );
        self.vehicle = undefined;
        self.rider_info = undefined;
        self animation::set_death_anim( undefined );
    }
    else
    {
        self startragdoll();
        self launchragdoll( ( -50, -20, 50 ) );
    }
    
    level flag::wait_till( "blackstation_exterior_engaged" );
    self kill();
}

// Namespace cp_mi_sing_blackstation_station
// Params 0
// Checksum 0x2b884974, Offset: 0x3d18
// Size: 0x74
function function_60578067()
{
    level flag::wait_till( "lightning_strike" );
    wait 0.5;
    e_sfx = getent( "lightning_strike_sound", "targetname" );
    e_sfx playsound( "fly_bot_head_sparks_disable" );
}

// Namespace cp_mi_sing_blackstation_station
// Params 0
// Checksum 0x7f118b33, Offset: 0x3d98
// Size: 0x64
function function_bfa694b0()
{
    var_92f29fd5 = getweapon( "launcher_guided_blackstation_ai" );
    self ai::gun_switchto( var_92f29fd5, "right" );
    self thread function_4472fea7();
}

// Namespace cp_mi_sing_blackstation_station
// Params 0
// Checksum 0xc1dba0ef, Offset: 0x3e08
// Size: 0x108
function function_4472fea7()
{
    self endon( #"death" );
    
    while ( true )
    {
        self waittill( #"missile_fire", e_proj );
        
        if ( isdefined( e_proj ) && isdefined( self.enemy ) )
        {
            n_dist = int( distance( self.origin, self.enemy.origin ) * 0.05 );
            n_range = randomintrange( n_dist * -1, n_dist );
            v_offset = ( n_range, n_range, n_range );
            e_proj missile_settarget( self.enemy, v_offset );
        }
    }
}

// Namespace cp_mi_sing_blackstation_station
// Params 0
// Checksum 0x9a91bb7, Offset: 0x3f18
// Size: 0x44
function function_2d102c76()
{
    trigger::wait_till( "trigger_station_cqb", "targetname", self );
    self ai::set_behavior_attribute( "cqb", 1 );
}

// Namespace cp_mi_sing_blackstation_station
// Params 0
// Checksum 0x49b2252f, Offset: 0x3f68
// Size: 0x1dc
function exterior_ai_spawning()
{
    level flag::wait_till( "blackstation_exterior_engaged" );
    spawner::add_spawn_function_group( "lower_exterior_group02", "targetname", &starting_ai_behavior );
    spawner::add_spawn_function_group( "exterior_group03", "targetname", &function_b690ea0e );
    
    foreach ( ai in level.a_starting_ai )
    {
        if ( isdefined( ai ) )
        {
            ai notify( #"under_attack" );
        }
    }
    
    level.a_starting_ai = [];
    wait 3;
    level flag::set( "exterior_truck_event" );
    level flag::wait_till( "warlord_go" );
    spawn_manager::enable( "sm_lower_group" );
    level thread function_31b6dec0();
    spawn_manager::enable( "exterior_group03_sm" );
    level flag::wait_till( "warlord_dead" );
    spawn_manager::kill( "exterior_group03_sm" );
}

// Namespace cp_mi_sing_blackstation_station
// Params 0
// Checksum 0xf8199157, Offset: 0x4150
// Size: 0x3c
function spawn_warlord()
{
    level flag::wait_till( "warlord_go" );
    spawn_manager::enable( "sm_warlord_station" );
}

// Namespace cp_mi_sing_blackstation_station
// Params 0
// Checksum 0xc3dfce1, Offset: 0x4198
// Size: 0x64
function function_31b6dec0()
{
    level endon( #"warlord_go" );
    
    while ( getaicount() > 12 + 2 )
    {
        wait 1;
    }
    
    level flag::set( "warlord_go" );
}

// Namespace cp_mi_sing_blackstation_station
// Params 0
// Checksum 0x69f15b6a, Offset: 0x4208
// Size: 0x1bc
function warlord_behavior()
{
    self endon( #"death" );
    level.var_e121f644++;
    self setthreatbiasgroup( "warlords" );
    setthreatbias( "heroes", "warlords", -1000 );
    self thread warlord_death_watcher();
    
    foreach ( node in level.a_warlord_nodes )
    {
        self warlordinterface::addpreferedpoint( node.origin, 3000, 5000 );
    }
    
    self setgoal( getnode( self.script_string, "targetname" ), 1 );
    self waittill( #"goal" );
    self clearforcedgoal();
    level flag::wait_till( "goto_entrance" );
    self setgoal( getent( "vol_warlord_retreat", "targetname" ) );
}

// Namespace cp_mi_sing_blackstation_station
// Params 0
// Checksum 0x125831d4, Offset: 0x43d0
// Size: 0x4c
function warlord_death_watcher()
{
    self waittill( #"death" );
    level.var_6999c9ec++;
    
    if ( level.var_e121f644 == level.var_6999c9ec )
    {
        level flag::set( "warlord_dead" );
    }
}

// Namespace cp_mi_sing_blackstation_station
// Params 0
// Checksum 0x9a3102b9, Offset: 0x4428
// Size: 0x66
function function_a05c3d53()
{
    level endon( #"exterior_clear" );
    
    while ( true )
    {
        a_ai_enemies = getaiteamarray( "axis" );
        
        if ( !a_ai_enemies.size )
        {
            level flag::set( "exterior_clear" );
        }
        
        wait 1;
    }
}

// Namespace cp_mi_sing_blackstation_station
// Params 0
// Checksum 0xa7804e78, Offset: 0x4498
// Size: 0x274
function technical_1_spawning()
{
    level flag::wait_till( "ziplines_ready" );
    vh_technical = vehicle::simple_spawn_single( "exterior_technical01" );
    vh_technical endon( #"death" );
    vh_technical vehicle::lights_off();
    vh_technical util::magic_bullet_shield();
    vh_technical thread function_d1825549();
    vh_technical thread truck_notify();
    vh_technical thread vehicle::get_on_and_go_path( getvehiclenode( vh_technical.target, "targetname" ) );
    vh_technical thread blackstation_utility::protect_riders();
    level waittill( #"pause" );
    vh_technical setspeed( 0, 15, 5 );
    ai_gunner = vh_technical vehicle::get_rider( "gunner1" );
    
    while ( isalive( ai_gunner ) )
    {
        wait 0.5;
    }
    
    wait 1;
    vh_technical resumespeed( 15 );
    vh_technical playsound( "evt_tech_driveup_3" );
    level flag::wait_till( "lightning_strike" );
    vh_technical turret::enable_auto_use( 0 );
    vh_technical waittill( #"reached_end_node" );
    vh_technical util::stop_magic_bullet_shield();
    vh_technical thread blackstation_utility::truck_unload( "driver" );
    vh_technical setseatoccupied( 0 );
    vh_technical makevehicleusable();
}

// Namespace cp_mi_sing_blackstation_station
// Params 0
// Checksum 0xc873a4cc, Offset: 0x4718
// Size: 0x4c
function function_d1825549()
{
    self endon( #"death" );
    level flag::wait_till( "blackstation_exterior_engaged" );
    self turret::enable( 1, 1 );
}

// Namespace cp_mi_sing_blackstation_station
// Params 0
// Checksum 0x2dfbb2cc, Offset: 0x4770
// Size: 0x2c
function truck_notify()
{
    level waittill( #"truck_in_position" );
    level flag::set( "truck_in_position" );
}

// Namespace cp_mi_sing_blackstation_station
// Params 0
// Checksum 0x26f09a27, Offset: 0x47a8
// Size: 0x1fc
function technical_2_spawning()
{
    vh_technical = vehicle::simple_spawn_single( "exterior_technical02" );
    vh_technical endon( #"death" );
    vh_technical vehicle::lights_off();
    vh_technical util::magic_bullet_shield();
    level flag::wait_till( "blackstation_exterior_engaged" );
    wait 2;
    vh_technical turret::enable( 1, 1 );
    vh_technical thread vehicle::get_on_and_go_path( getvehiclenode( vh_technical.target, "targetname" ) );
    vh_technical playsound( "evt_tech_driveup_4" );
    vh_technical waittill( #"reached_end_node" );
    vh_technical util::stop_magic_bullet_shield();
    wait 1;
    ai_driver = vh_technical vehicle::get_rider( "driver" );
    
    if ( isalive( ai_driver ) )
    {
        ai_driver colors::set_force_color( "r" );
        ai_driver vehicle::get_out();
    }
    
    vh_technical setseatoccupied( 0 );
    vh_technical makevehicleusable();
    vh_technical thread blackstation_utility::truck_gunner_replace( 2, 2, "cross_street" );
}

// Namespace cp_mi_sing_blackstation_station
// Params 0
// Checksum 0xf7a0e27, Offset: 0x49b0
// Size: 0x20c
function technical_3_spawning()
{
    vh_technical = vehicle::simple_spawn_single( "exterior_technical03" );
    vh_technical endon( #"death" );
    vh_technical vehicle::lights_off();
    vh_technical util::magic_bullet_shield();
    level flag::wait_till( "blackstation_exterior_engaged" );
    vh_technical thread vehicle::get_on_and_go_path( getvehiclenode( vh_technical.target, "targetname" ) );
    vh_technical playsound( "evt_tech_driveup_5" );
    vh_technical resumespeed( 35 );
    vh_technical turret::enable( 1, 1 );
    vh_technical waittill( #"reached_end_node" );
    vh_technical util::stop_magic_bullet_shield();
    wait 1;
    ai_driver = vh_technical vehicle::get_rider( "driver" );
    
    if ( isalive( ai_driver ) )
    {
        ai_driver colors::set_force_color( "r" );
        ai_driver vehicle::get_out();
    }
    
    vh_technical setseatoccupied( 0 );
    vh_technical makevehicleusable();
    vh_technical thread blackstation_utility::truck_gunner_replace( 2, 2, "cross_street" );
}

// Namespace cp_mi_sing_blackstation_station
// Params 1
// Checksum 0x770747d3, Offset: 0x4bc8
// Size: 0xa4
function technical_riders( vh_technical )
{
    self endon( #"death" );
    self vehicle::get_in( vh_technical, "gunner1" );
    
    while ( !self flagsys::get( "in_vehicle" ) )
    {
        if ( !vh_technical flagsys::get( "driveroccupied" ) )
        {
            self vehicle::get_in( vh_technical, "driver" );
            continue;
        }
        
        wait 0.05;
    }
}

// Namespace cp_mi_sing_blackstation_station
// Params 0
// Checksum 0x8d48fba8, Offset: 0x4c78
// Size: 0x8c
function function_78b9affb()
{
    self endon( #"death" );
    self ai::set_ignoreall( 1 );
    level flag::wait_till( "blackstation_exterior_engaged" );
    self notify( #"stop_patrolling" );
    self ai::set_behavior_attribute( "patrol", 0 );
    self ai::set_ignoreall( 0 );
}

// Namespace cp_mi_sing_blackstation_station
// Params 0
// Checksum 0xddb05651, Offset: 0x4d10
// Size: 0x10c
function function_8401b524()
{
    self endon( #"death" );
    level flag::wait_till( "lightning_strike" );
    self notify( #"stop_patrolling" );
    self ai::set_behavior_attribute( "patrol", 0 );
    wait randomfloatrange( 0.5, 1 );
    nd_runto = getnode( self.script_noteworthy, "script_noteworthy" );
    
    if ( isdefined( nd_runto ) )
    {
        self setgoal( getnode( self.script_noteworthy, "script_noteworthy" ), 1 );
        self waittill( #"goal" );
        self clearforcedgoal();
    }
}

// Namespace cp_mi_sing_blackstation_station
// Params 0
// Checksum 0xb7bbe377, Offset: 0x4e28
// Size: 0x164
function function_50eaaa70()
{
    self endon( #"death" );
    self colors::set_force_color( "r" );
    self thread proximity_detection();
    self thread function_78b9affb();
    self thread function_8401b524();
    self thread starting_ai_behavior();
    self ai::set_behavior_attribute( "patrol", 1 );
    self thread ai::patrol( getnode( self.script_noteworthy, "targetname" ) );
    self util::waittill_any( "damage", "bulletwhizby", "grenadedanger", "death", "projectile_impact", "under_attack" );
    level flag::set( "exterior_ready_weapons" );
    level flag::set( "blackstation_exterior_engaged" );
}

// Namespace cp_mi_sing_blackstation_station
// Params 0
// Checksum 0x3833308d, Offset: 0x4f98
// Size: 0x1b8
function starting_ai_behavior()
{
    self endon( #"death" );
    
    if ( self.archetype == "human" )
    {
        self colors::set_force_color( "r" );
    }
    
    self thread proximity_detection();
    self ai::set_ignoreall( 1 );
    self util::waittill_any( "damage", "bulletwhizby", "grenadedanger", "death", "projectile_impact", "under_attack" );
    level flag::set( "exterior_ready_weapons" );
    level flag::set( "blackstation_exterior_engaged" );
    self ai::set_ignoreall( 0 );
    self.maxsightdistsqrd = self.var_98207841;
    
    foreach ( ai in level.a_starting_ai )
    {
        if ( isdefined( ai ) )
        {
            ai notify( #"under_attack" );
        }
    }
    
    level.a_starting_ai = [];
}

// Namespace cp_mi_sing_blackstation_station
// Params 0
// Checksum 0x3f615388, Offset: 0x5158
// Size: 0x5c
function function_2dafb2d1()
{
    self endon( #"death" );
    self ai::set_ignoreall( 1 );
    level flag::wait_till( "blackstation_exterior_engaged" );
    self ai::set_ignoreall( 0 );
}

// Namespace cp_mi_sing_blackstation_station
// Params 0
// Checksum 0x4733a06d, Offset: 0x51c0
// Size: 0xf8
function proximity_detection()
{
    self endon( #"death" );
    level endon( #"blackstation_exterior_engaged" );
    self.var_98207841 = self.maxsightdistsqrd;
    self.maxsightdistsqrd = 360000;
    
    while ( true )
    {
        foreach ( player in level.activeplayers )
        {
            if ( self cansee( player ) )
            {
                level flag::set( "blackstation_exterior_engaged" );
            }
        }
        
        wait 0.3;
    }
}

// Namespace cp_mi_sing_blackstation_station
// Params 0
// Checksum 0x4bcdffbf, Offset: 0x52c0
// Size: 0x1ac
function robot_lightning_behavior()
{
    self endon( #"death" );
    
    if ( !level flag::get( "lightning_strike" ) )
    {
        if ( self.script_noteworthy == "lightning_struck_gib" )
        {
            self setgoal( self.origin, 1 );
        }
        
        level flag::wait_till( "lightning_strike" );
        self ai::set_ignoreme( 1 );
        self disableaimassist();
        wait randomfloat( 1 );
        self fx::play( "disabled_robot", self.origin, undefined, 15, 1, "j_neck" );
        
        switch ( randomint( 4 ) )
        {
            case 0:
                str_scene = "cin_bla_13_02_looting_vign_lightningstrike_robot01";
                break;
            case 1:
                str_scene = "cin_bla_13_02_looting_vign_lightningstrike_robot02";
                break;
            case 2:
                str_scene = "cin_bla_13_02_looting_vign_lightningstrike_robot03";
                break;
            case 3:
                str_scene = "cin_bla_13_02_looting_vign_lightningstrike_robot04";
                break;
        }
        
        self thread function_84aabd4b( str_scene );
    }
}

// Namespace cp_mi_sing_blackstation_station
// Params 1
// Checksum 0x84a9ca2d, Offset: 0x5478
// Size: 0x17c
function function_84aabd4b( str_scene )
{
    self endon( #"death" );
    n_min_wait = 6;
    n_max_wait = 10;
    self scene::play( str_scene + "_zapped", self );
    self thread scene::play( str_scene + "_loop", self );
    wait randomfloatrange( n_min_wait, n_max_wait );
    
    if ( self.script_noteworthy === "lightning_struck_gib" )
    {
        self ai::set_behavior_attribute( "force_crawler", "gib_legs" );
        self kill();
        return;
    }
    
    self scene::play( str_scene, self );
    self enableaimassist();
    self ai::set_ignoreall( 0 );
    self ai::set_ignoreme( 0 );
    self ai::set_behavior_attribute( "move_mode", "rusher" );
}

// Namespace cp_mi_sing_blackstation_station
// Params 0
// Checksum 0xc71959c7, Offset: 0x5600
// Size: 0xec
function guard_behavior()
{
    self endon( #"death" );
    
    if ( self.script_noteworthy === "robot_patrol" )
    {
        self ai::set_behavior_attribute( "move_mode", "normal" );
    }
    else
    {
        self setgoal( self.origin, 0, 128 );
        self ai::set_behavior_attribute( "move_mode", "guard" );
    }
    
    level flag::wait_till( "blackstation_exterior_engaged" );
    self.goalradius = 1000;
    self ai::set_behavior_attribute( "move_mode", "normal" );
}

// Namespace cp_mi_sing_blackstation_station
// Params 0
// Checksum 0x2d70ed39, Offset: 0x56f8
// Size: 0x6c
function pather_behavior()
{
    self endon( #"death" );
    level flag::wait_till( "zipline_player_landed" );
    nd_start = getnearestnode( self.origin );
    self setgoal( nd_start );
}

// Namespace cp_mi_sing_blackstation_station
// Params 0
// Checksum 0xdf84fe1f, Offset: 0x5770
// Size: 0x3c
function patroller_behavior()
{
    self endon( #"death" );
    self thread ai::patrol( getnearestnode( self.origin ) );
}

// Namespace cp_mi_sing_blackstation_station
// Params 0
// Checksum 0x9dc981d1, Offset: 0x57b8
// Size: 0x2c
function function_b690ea0e()
{
    self endon( #"death" );
    self colors::set_force_color( "r" );
}

// Namespace cp_mi_sing_blackstation_station
// Params 0
// Checksum 0x8df5ee6f, Offset: 0x57f0
// Size: 0xfc
function function_dfb9eb36()
{
    level flag::wait_till( "warlord_dead" );
    self notify( #"hash_d60979de" );
    wait 1;
    
    while ( getaiteamarray( "axis" ).size > 2 )
    {
        wait 0.5;
    }
    
    a_ai_enemies = getaiteamarray( "axis" );
    
    if ( a_ai_enemies.size )
    {
        self blackstation_utility::function_4f96504c( a_ai_enemies[ 0 ] );
        
        if ( isalive( a_ai_enemies[ 0 ] ) )
        {
            self cybercom::function_d240e350( "cybercom_fireflyswarm", a_ai_enemies[ 0 ], 0, 1 );
        }
    }
}

// Namespace cp_mi_sing_blackstation_station
// Params 0
// Checksum 0x52c309fe, Offset: 0x58f8
// Size: 0x44
function function_5fc18bba()
{
    self endon( #"death" );
    level endon( #"blackstation_exterior_engaged" );
    self waittill( #"weapon_fired" );
    level flag::set( "blackstation_exterior_engaged" );
}

// Namespace cp_mi_sing_blackstation_station
// Params 1
// Checksum 0xc3792b2e, Offset: 0x5948
// Size: 0x80
function function_2a47a71c( player_num )
{
    if ( player_num == 0 )
    {
        return ( -4768, 10399, 329 );
    }
    
    if ( player_num == 1 )
    {
        return ( -4768, 10355, 329 );
    }
    
    if ( player_num == 2 )
    {
        return ( -5618, 9366, 329 );
    }
    
    return ( -5618, 9294, 329 );
}

// Namespace cp_mi_sing_blackstation_station
// Params 0
// Checksum 0xf9c56fe3, Offset: 0x59d0
// Size: 0xcc
function function_34a9c09e()
{
    self endon( #"death" );
    self clientfield::increment_to_player( "postfx_igc", 1 );
    self freezecontrols( 1 );
    wait 0.5;
    var_be173713 = function_2a47a71c( self getentitynumber() );
    self setorigin( var_be173713 );
    self setplayerangles( ( 0, 0, 0 ) );
    self freezecontrols( 0 );
}

// Namespace cp_mi_sing_blackstation_station
// Params 3
// Checksum 0x7a4796e8, Offset: 0x5aa8
// Size: 0x54c
function zipline_player( t_zipline, s_start, s_end )
{
    self endon( #"death" );
    self thread blackstation_utility::function_ed7faf05();
    var_ad470f8c = util::spawn_model( "tag_origin", self.origin, self.angles );
    n_dist = distance( s_start.origin, s_end.origin );
    n_time = n_dist / 750;
    self disableweaponcycling();
    self disableoffhandweapons();
    self allowcrouch( 0 );
    self allowprone( 0 );
    var_ad470f8c playsoundtoplayer( "evt_zipline_attach", self );
    self.b_using_zipline = 1;
    var_ad470f8c.origin = self.origin;
    var_ad470f8c.angles = self.angles;
    self util::set_low_ready( 0 );
    self playrumbleonentity( "cp_blackstation_zipline_attach_rumble" );
    var_ad470f8c moveto( s_start.origin, 0.05 );
    var_ad470f8c rotateto( s_start.angles, 0.05 );
    var_f32c41e7 = gettime();
    var_ad470f8c scene::play( "cin_gen_traversal_zipline_player_attach", self );
    
    if ( gettime() - var_f32c41e7 < 0.5 )
    {
        var_6ec94357 = 1;
    }
    
    if ( !( isdefined( var_6ec94357 ) && var_6ec94357 ) )
    {
        self clientfield::set_to_player( "wind_blur", 1 );
        var_ad470f8c thread scene::play( "cin_gen_traversal_zipline_player_idle", self );
        self clientfield::set_to_player( "zipline_rumble_loop", 1 );
        self clientfield::set( "zipline_sound_loop", 1 );
        self playloopsound( "evt_zipline_move", 0.3 );
        var_ad470f8c moveto( s_end.origin, n_time, 0, 0 );
        var_ad470f8c waittill( #"movedone" );
        var_ad470f8c playsoundtoplayer( "evt_zipline_attach", self );
        self clientfield::set_to_player( "wind_blur", 0 );
        self playrumbleonentity( "cp_blackstation_zipline_dismount_rumble" );
        self clientfield::set_to_player( "zipline_rumble_loop", 0 );
        self clientfield::set( "zipline_sound_loop", 0 );
        self stoploopsound( 0.5 );
        var_ad470f8c scene::play( "cin_gen_traversal_zipline_player_dismount", self );
    }
    
    self playrumbleonentity( "cp_blackstation_zipline_land_rumble" );
    self.b_using_zipline = 0;
    self notify( #"dismount_zipline" );
    self enableweaponcycling();
    self enableoffhandweapons();
    self allowcrouch( 1 );
    self allowprone( 1 );
    self thread blackstation_utility::player_anchor();
    level flag::set( "zipline_player_landed" );
    wait 0.3;
    var_ad470f8c delete();
    self disableinvulnerability();
    
    if ( isdefined( var_6ec94357 ) && var_6ec94357 )
    {
        function_34a9c09e();
    }
}

// Namespace cp_mi_sing_blackstation_station
// Params 1
// Checksum 0xd56cb600, Offset: 0x6000
// Size: 0x1f8
function setup_zipline_down( t_zipline )
{
    t_zipline triggerenable( 0 );
    t_zipline.b_in_use = 0;
    level flag::wait_till( "ziplines_ready" );
    var_744d4302 = util::init_interactive_gameobject( t_zipline, &"cp_level_blackstation_zipline", &"CP_MI_SING_BLACKSTATION_ZIPLINE_TEXT", &function_a7b2f59e );
    var_744d4302.dontlinkplayertotrigger = 1;
    var_744d4302.trigger = t_zipline;
    var_744d4302 thread function_76529a7a();
    
    while ( t_zipline.b_in_use )
    {
        wait 0.1;
    }
    
    t_zipline triggerenable( 1 );
    objectives::set( "cp_level_blackstation_zipline", t_zipline.origin );
    s_start = struct::get( t_zipline.target, "targetname" );
    s_end = struct::get( s_start.target, "targetname" );
    
    while ( !level flag::get( "zipline_done" ) )
    {
        while ( t_zipline.b_in_use == 1 )
        {
            wait 0.25;
        }
        
        var_744d4302 gameobjects::enable_object();
        util::wait_network_frame();
    }
}

// Namespace cp_mi_sing_blackstation_station
// Params 1
// Checksum 0x6003c256, Offset: 0x6200
// Size: 0x230
function function_a7b2f59e( e_player )
{
    e_player enableinvulnerability();
    trigger::use( "trig_zipline_player_spawns", "targetname", e_player );
    level thread namespace_4297372::function_f152b1dc();
    level flag::set( self.trigger.targetname );
    self.trigger.b_in_use = 1;
    self gameobjects::disable_object();
    objectives::hide_for_target( "cp_level_blackstation_zipline", self.trigger.origin );
    
    if ( !level.var_c5719229 )
    {
        level.var_c5719229 = 1;
        
        if ( self.trigger.targetname == "trig_zipline01" )
        {
            level.str_zipline = "left";
        }
        else
        {
            level.str_zipline = "right";
        }
        
        level thread function_b0c674cf();
    }
    
    s_start = struct::get( self.trigger.target, "targetname" );
    s_end = struct::get( s_start.target, "targetname" );
    e_player blackstation_utility::function_ed7faf05();
    e_player notify( #"used_zipline" );
    e_player util::set_low_ready( 1 );
    e_player thread zipline_player( self.trigger, s_start, s_end );
    wait 1.5;
    self.trigger.b_in_use = 0;
}

// Namespace cp_mi_sing_blackstation_station
// Params 0
// Checksum 0xe0d61b58, Offset: 0x6438
// Size: 0x148
function function_b78bbba4()
{
    while ( !level flag::get( "zipline_done" ) )
    {
        var_d0f085 = trigger::wait_till( "trig_zipline_player_spawns", "targetname" );
        var_d0f085.who.var_af1dcf8b = 1;
        
        if ( level.activeplayers.size )
        {
            alldone = 1;
            
            foreach ( player in level.activeplayers )
            {
                if ( player.var_af1dcf8b !== 1 )
                {
                    alldone = 0;
                    break;
                }
            }
            
            if ( alldone )
            {
                level flag::set( "zipline_done" );
            }
        }
    }
}

// Namespace cp_mi_sing_blackstation_station
// Params 0
// Checksum 0x24ec92a1, Offset: 0x6588
// Size: 0x84
function function_76529a7a()
{
    level flag::wait_till( "zipline_done" );
    self gameobjects::destroy_object();
    hidemiscmodels( "collapse_frogger_water" );
    hidemiscmodels( "lt_wharf_water" );
    hidemiscmodels( "vista_water" );
}

// Namespace cp_mi_sing_blackstation_station
// Params 1
// Checksum 0x5b51d567, Offset: 0x6618
// Size: 0x1a4
function zipline_finish( e_zipline_user )
{
    self waittill( #"movedone" );
    
    if ( isplayer( e_zipline_user ) )
    {
        e_zipline_user stoploopsound( 0.5 );
    }
    
    v_on_navmesh = getclosestpointonnavmesh( self.origin, 100, 48 );
    
    if ( isdefined( v_on_navmesh ) )
    {
        self moveto( v_on_navmesh, 0.25 );
    }
    
    if ( !isplayer( e_zipline_user ) )
    {
        self scene::play( "cin_gen_traversal_zipline_enemy02_dismount", e_zipline_user );
    }
    
    self unlink();
    self delete();
    
    if ( e_zipline_user == level.ai_kane )
    {
        level flag::set( "kane_landed" );
        return;
    }
    
    if ( isplayer( e_zipline_user ) )
    {
        e_zipline_user thread blackstation_utility::player_anchor();
        level flag::set( "zipline_player_landed" );
        e_zipline_user util::set_low_ready( 0 );
    }
}

// Namespace cp_mi_sing_blackstation_station
// Params 2
// Checksum 0x82920e9, Offset: 0x67c8
// Size: 0x25c
function zipline_allies( e_ally, str_zipline_trigger )
{
    t_zip = getent( str_zipline_trigger, "targetname" );
    t_zip.b_in_use = 1;
    s_start = struct::get( t_zip.target, "targetname" );
    s_end = struct::get( s_start.target, "targetname" );
    e_ally playsound( "evt_zipline_attach" );
    mdl_aimover = util::spawn_model( "tag_origin", s_start.origin, s_start.angles );
    
    if ( e_ally == level.ai_kane )
    {
        mdl_aimover scene::play( "cin_gen_traversal_zipline_enemy02_attach", e_ally );
    }
    
    e_ally playloopsound( "evt_zipline_npc_move", 0.3 );
    mdl_aimover thread scene::play( "cin_gen_traversal_zipline_enemy02_idle", e_ally );
    n_dist = distance( s_start.origin, s_end.origin );
    n_time = n_dist / 750;
    mdl_aimover moveto( s_end.origin, n_time, n_time / 2, 0.1 );
    mdl_aimover thread zipline_finish( e_ally );
    e_ally stoploopsound( 0.5 );
    t_zip.b_in_use = 0;
}

// Namespace cp_mi_sing_blackstation_station
// Params 0
// Checksum 0xc6c5092d, Offset: 0x6a30
// Size: 0x13c
function function_9694617b()
{
    level flag::wait_till( "blackstation_exterior_engaged" );
    level dialog::remote( "kane_you_got_hostiles_inb_0", 1 );
    level flag::wait_till( "lightning_strike" );
    level.ai_hendricks dialog::say( "hend_their_grunts_will_ha_0", 1 );
    level flag::wait_till( "warlord_go" );
    level dialog::remote( "kane_enemy_warlord_0", 2 );
    level.ai_hendricks dialog::say( "hend_reinforcements_comin_1", 2 );
    level flag::wait_till( "goto_entrance" );
    level.ai_hendricks dialog::say( "hend_kane_we_got_eyes_o_0", 5 );
}

// Namespace cp_mi_sing_blackstation_station
// Params 2
// Checksum 0x307c78e, Offset: 0x6b78
// Size: 0x374
function objective_blackstation_interior_init( str_objective, b_starting )
{
    if ( b_starting )
    {
        load::function_73adcefc();
        blackstation_utility::init_hendricks( "objective_blackstation_interior" );
        blackstation_utility::init_kane( "objective_blackstation_interior" );
        level.ai_kane colors::set_force_color( "y" );
        trigger::use( "trig_blackstation_interior" );
        level thread function_5493cb1d();
        level flag::set( "blackstation_entry" );
        objectives::complete( "cp_level_blackstation_rendezvous" );
        objectives::set( "cp_level_blackstation_goto_station" );
        level scene::init( "cin_bla_14_02_blackstation_vign_takepoint" );
        
        while ( !scene::is_ready( "cin_bla_14_02_blackstation_vign_takepoint" ) )
        {
            wait 0.05;
        }
        
        load::function_a2995f22();
    }
    
    objectives::complete( "cp_level_blackstation_goto_station" );
    level scene::init( "cin_bla_14_06_blackstation_1st_approachdoor" );
    level thread function_3d53956f();
    level thread blackstation_utility::player_rain_intensity( "none" );
    spawner::add_spawn_function_group( "group_driller", "script_aigroup", &driller_behavior );
    spawner::add_spawn_function_group( "interior_looter1", "targetname", &function_fa27d153 );
    level thread function_fb2359a2();
    level thread setup_igc_door();
    level thread function_fc21e39b();
    level thread function_7bba9576();
    level thread function_bd050a2d();
    level.ai_hendricks notify( #"stop_dynamic_run_speed" );
    level.ai_kane notify( #"stop_dynamic_run_speed" );
    level.ai_hendricks ai::set_behavior_attribute( "cqb", 1 );
    level.ai_kane ai::set_behavior_attribute( "cqb", 1 );
    level.ai_hendricks ai::set_ignoreall( 1 );
    level.ai_kane ai::set_ignoreall( 1 );
    level clientfield::set( "sndBlackStationSounds", 1 );
}

// Namespace cp_mi_sing_blackstation_station
// Params 4
// Checksum 0x780507ad, Offset: 0x6ef8
// Size: 0x3c
function objective_blackstation_interior_done( str_objective, b_starting, b_direct, player )
{
    objectives::complete( "cp_level_blackstation_blackstation" );
}

// Namespace cp_mi_sing_blackstation_station
// Params 0
// Checksum 0x25f68114, Offset: 0x6f40
// Size: 0xac
function function_fb2359a2()
{
    trigger::wait_till( "trig_waypoint_station03" );
    level thread scene::play( "cin_bla_14_05_blackstation_vign_drilling_idle" );
    level thread scene::play( "cin_bla_14_04_blackstation_aie_looting_a_idle" );
    level flag::wait_till( "drill_engaged" );
    level.ai_hendricks ai::set_ignoreall( 0 );
    level.ai_kane ai::set_ignoreall( 0 );
}

// Namespace cp_mi_sing_blackstation_station
// Params 0
// Checksum 0x7c73b7be, Offset: 0x6ff8
// Size: 0x74
function function_bd050a2d()
{
    level flag::wait_till( "driller_patrol" );
    level flag::wait_till_timeout( 8, "drill_engaged" );
    level.ai_hendricks ai::set_ignoreall( 0 );
    level.ai_kane ai::set_ignoreall( 0 );
}

// Namespace cp_mi_sing_blackstation_station
// Params 0
// Checksum 0xa5015c12, Offset: 0x7078
// Size: 0x7c
function driller_behavior()
{
    self endon( #"death" );
    self thread driller_detection();
    self thread function_2a08d4df();
    level flag::wait_till( "drill_engaged" );
    level thread scene::play( self.script_noteworthy );
}

// Namespace cp_mi_sing_blackstation_station
// Params 0
// Checksum 0x96cd5ea2, Offset: 0x7100
// Size: 0xf0
function function_2a08d4df()
{
    self endon( #"death" );
    level endon( #"drill_engaged" );
    
    while ( true )
    {
        foreach ( player in level.activeplayers )
        {
            if ( self cansee( player ) && self.targetname != "interior_looter1_ai" )
            {
                level flag::set( "drill_engaged" );
            }
        }
        
        wait 0.1;
    }
}

// Namespace cp_mi_sing_blackstation_station
// Params 0
// Checksum 0x38d2b451, Offset: 0x71f8
// Size: 0x74
function driller_detection()
{
    self endon( #"death" );
    self util::waittill_any( "damage", "bulletwhizby", "grenadedanger", "death", "projectile_impact", "driller_go" );
    level flag::set( "drill_engaged" );
}

// Namespace cp_mi_sing_blackstation_station
// Params 0
// Checksum 0x6a9ea79b, Offset: 0x7278
// Size: 0x64
function function_fa27d153()
{
    self endon( #"death" );
    self thread driller_detection();
    level flag::wait_till( "drill_engaged" );
    level thread scene::play( "cin_bla_14_04_blackstation_aie_looting_a_react" );
}

// Namespace cp_mi_sing_blackstation_station
// Params 0
// Checksum 0x4a9e264f, Offset: 0x72e8
// Size: 0x154
function function_7bba9576()
{
    level flag::wait_till( "drill_engaged" );
    level thread scene::play( "cin_bla_14_05_blackstation_vign_drilling_react4" );
    level clientfield::set( "sndDrillWalla", 0 );
    var_88fd08c3 = getaiteamarray( "axis" );
    
    foreach ( var_973053c8 in var_88fd08c3 )
    {
        var_973053c8 notify( #"driller_go" );
    }
    
    level.var_54dc3c4c = spawn( "script_origin", ( -712, 9546, 368 ) );
    level.var_54dc3c4c playloopsound( "vox_black_15_02_004_salm" );
}

// Namespace cp_mi_sing_blackstation_station
// Params 0
// Checksum 0xc7222fe4, Offset: 0x7448
// Size: 0x64
function function_893b7d1f()
{
    self endon( #"death" );
    level endon( #"drill_engaged" );
    self waittill( #"weapon_fired" );
    level flag::set( "driller_patrol" );
    level flag::set( "drill_engaged" );
}

// Namespace cp_mi_sing_blackstation_station
// Params 0
// Checksum 0x559a5f6c, Offset: 0x74b8
// Size: 0x354
function setup_igc_door()
{
    t_door = getent( "trig_end_igc_door", "targetname" );
    t_door triggerenable( 0 );
    spawner::waittill_ai_group_cleared( "group_driller" );
    trigger::use( "triggercolor_station_door" );
    level thread namespace_4297372::function_973b77f9();
    wait 1;
    objectives::set( "cp_level_blackstation_door", struct::get( "outro_igc" ) );
    t_door triggerenable( 1 );
    t_door trigger::wait_till();
    t_door delete();
    level.var_54dc3c4c stoploopsound();
    
    foreach ( player in level.activeplayers )
    {
        player thread blackstation_utility::function_ed7faf05();
    }
    
    level.ai_hendricks colors::disable();
    level.ai_kane colors::disable();
    level.ai_hendricks setgoal( level.ai_hendricks.origin );
    level.ai_kane setgoal( level.ai_kane.origin );
    level clientfield::set( "gameplay_started", 0 );
    level thread namespace_4297372::function_6048af60();
    level scene::play( "cin_bla_14_06_blackstation_1st_approachdoor", t_door.who );
    mdl_clip = getent( "bs_station_clip", "targetname" );
    mdl_clip notsolid();
    mdl_clip connectpaths();
    objectives::complete( "cp_level_blackstation_door", struct::get( "outro_igc" ) );
    skipto::objective_completed( "objective_blackstation_interior" );
    wait 1;
    level.var_54dc3c4c delete();
}

// Namespace cp_mi_sing_blackstation_station
// Params 0
// Checksum 0x86f452a9, Offset: 0x7818
// Size: 0x144
function function_5493cb1d()
{
    level flag::wait_till( "blackstation_entry" );
    level thread namespace_4297372::function_674f7650();
    level.ai_hendricks dialog::say( "hend_okay_let_s_see_wh_0" );
    level flag::wait_till( "driller_sound" );
    level clientfield::set( "sndDrillWalla", 1 );
    
    foreach ( player in level.activeplayers )
    {
        player thread function_893b7d1f();
    }
    
    level.ai_hendricks dialog::say( "hend_something_up_ahead_0" );
}

// Namespace cp_mi_sing_blackstation_station
// Params 0
// Checksum 0xcb45286, Offset: 0x7968
// Size: 0x17c
function function_fc21e39b()
{
    trigger::wait_till( "trig_blackstation_interior" );
    level.ai_hendricks thread function_7c4f357d( "nd_hendricks_boiler", "hendricks_ready" );
    level.ai_kane thread function_7c4f357d( "nd_kane_boiler", "kane_ready" );
    util::waittill_multiple( "hendricks_ready", "kane_ready" );
    blackstation_utility::cleanup_ai();
    level scene::add_scene_func( "cin_bla_14_02_blackstation_vign_takepoint", &function_362c6fe1 );
    level scene::play( "cin_bla_14_02_blackstation_vign_takepoint" );
    objectives::set( "cp_level_blackstation_goto_center" );
    mdl_clip = getent( "clip_boiler_room", "targetname" );
    
    if ( isdefined( mdl_clip ) )
    {
        mdl_clip delete();
    }
    
    savegame::checkpoint_save();
    streamerrequest( "set", "cp_mi_sing_blackstation_objective_end_igc" );
}

// Namespace cp_mi_sing_blackstation_station
// Params 1
// Checksum 0x866c675a, Offset: 0x7af0
// Size: 0x54
function function_362c6fe1( a_ents )
{
    level.ai_hendricks colors::enable();
    level.ai_kane colors::enable();
    trigger::use( "triggercolor_past_boiler" );
}

// Namespace cp_mi_sing_blackstation_station
// Params 2
// Checksum 0x863f5dce, Offset: 0x7b50
// Size: 0x78
function function_7c4f357d( var_9e2ba1f1, str_notify )
{
    self colors::disable();
    self setgoal( getnode( var_9e2ba1f1, "targetname" ), 1 );
    self waittill( #"goal" );
    wait 1;
    level notify( str_notify );
}

// Namespace cp_mi_sing_blackstation_station
// Params 2
// Checksum 0x2cf64020, Offset: 0x7bd0
// Size: 0x1fc
function objective_end_igc_init( str_objective, b_starting )
{
    if ( b_starting )
    {
        load::function_73adcefc();
        blackstation_utility::init_hendricks( "objective_end_igc" );
        blackstation_utility::init_kane( "objective_end_igc" );
        level scene::init( "cin_bla_15_outro_3rd_sh010" );
        load::function_c32ba481();
    }
    
    level notify( #"end_igc" );
    level thread namespace_4297372::function_6048af60();
    level thread audio::unlockfrontendmusic( "mus_blackstation_theme_intro" );
    level scene::add_scene_func( "cin_bla_15_outro_3rd_sh010", &function_bffd5cf, "play" );
    level scene::add_scene_func( "cin_bla_15_outro_3rd_sh070", &function_f94ebed5, "play" );
    level scene::add_scene_func( "cin_bla_15_outro_3rd_sh210", &function_c10be1, "play" );
    level scene::add_scene_func( "cin_bla_15_outro_3rd_sh210", &function_92a23169, "done" );
    
    if ( isdefined( level.bzm_blackstationdialogue5callback ) )
    {
        level thread [[ level.bzm_blackstationdialogue5callback ]]();
    }
    
    array::run_all( getcorpsearray(), &delete );
    level scene::play( "cin_bla_15_outro_3rd_sh010" );
}

// Namespace cp_mi_sing_blackstation_station
// Params 4
// Checksum 0x80529951, Offset: 0x7dd8
// Size: 0x24
function objective_end_igc_done( str_objective, b_starting, b_direct, player )
{
    
}

// Namespace cp_mi_sing_blackstation_station
// Params 1
// Checksum 0x6e0e383c, Offset: 0x7e08
// Size: 0x2c
function function_f94ebed5( a_ents )
{
    level thread scene::play( "cin_bla_15_outro_3rd_sh070_bodies" );
}

// Namespace cp_mi_sing_blackstation_station
// Params 1
// Checksum 0x369fb9dc, Offset: 0x7e40
// Size: 0x7c
function function_bffd5cf( a_ents )
{
    level clientfield::set( "outro_exposure", 1 );
    level waittill( #"hash_8823b64" );
    level clientfield::set( "sndIGCsnapshot", 4 );
    level lui::screen_fade( 0.5 );
}

// Namespace cp_mi_sing_blackstation_station
// Params 1
// Checksum 0x59c2cd39, Offset: 0x7ec8
// Size: 0x9a
function function_c10be1( a_ents )
{
    foreach ( player in level.activeplayers )
    {
        player util::set_low_ready( 1 );
    }
}

// Namespace cp_mi_sing_blackstation_station
// Params 1
// Checksum 0xc540c7b0, Offset: 0x7f70
// Size: 0x24
function function_92a23169( a_ents )
{
    skipto::objective_completed( "objective_end_igc" );
}

