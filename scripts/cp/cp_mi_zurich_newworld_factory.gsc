#using scripts/codescripts/struct;
#using scripts/cp/_dialog;
#using scripts/cp/_load;
#using scripts/cp/_objectives;
#using scripts/cp/_oed;
#using scripts/cp/_skipto;
#using scripts/cp/_spawn_manager;
#using scripts/cp/_util;
#using scripts/cp/cp_mi_zurich_newworld;
#using scripts/cp/cp_mi_zurich_newworld_accolades;
#using scripts/cp/cp_mi_zurich_newworld_sound;
#using scripts/cp/cp_mi_zurich_newworld_util;
#using scripts/cp/cybercom/_cybercom_gadget;
#using scripts/cp/cybercom/_cybercom_gadget_firefly;
#using scripts/cp/cybercom/_cybercom_gadget_security_breach;
#using scripts/cp/cybercom/_cybercom_util;
#using scripts/cp/gametypes/_battlechatter;
#using scripts/cp/gametypes/_globallogic_ui;
#using scripts/cp/gametypes/_save;
#using scripts/shared/ai_shared;
#using scripts/shared/animation_shared;
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
#using scripts/shared/lui_shared;
#using scripts/shared/math_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/trigger_shared;
#using scripts/shared/turret_shared;
#using scripts/shared/util_shared;
#using scripts/shared/vehicle_ai_shared;
#using scripts/shared/vehicle_shared;

#namespace newworld_factory;

// Namespace newworld_factory
// Params 2
// Checksum 0x80e5ef9e, Offset: 0x2f58
// Size: 0xfc
function skipto_pallas_igc_init( str_objective, b_starting )
{
    level thread function_97f60350();
    
    if ( b_starting )
    {
        load::function_73adcefc();
        load::function_c32ba481( undefined, ( 1, 1, 1 ) );
        level thread newworld_util::function_30ec5bf7( 1 );
    }
    
    newworld_util::player_snow_fx();
    battlechatter::function_d9f49fba( 0 );
    level intro_area_threatgroups_setup();
    pallas_intro_igc();
    level clientfield::set( "gameplay_started", 1 );
    skipto::objective_completed( str_objective );
}

// Namespace newworld_factory
// Params 4
// Checksum 0xdee80f76, Offset: 0x3060
// Size: 0x24
function skipto_pallas_igc_done( str_objective, b_starting, b_direct, player )
{
    
}

// Namespace newworld_factory
// Params 0
// Checksum 0xa3db1167, Offset: 0x3090
// Size: 0x24c
function pallas_intro_igc()
{
    foreach ( player in level.activeplayers )
    {
        player setignorepauseworld( 1 );
    }
    
    level.ai_diaz = util::get_hero( "diaz" );
    level.ai_diaz ghost();
    level.ai_diaz setignorepauseworld( 1 );
    level.ai_taylor = util::get_hero( "taylor" );
    level.ai_taylor ghost();
    level.ai_taylor setignorepauseworld( 1 );
    level scene::init( "cin_new_02_01_pallasintro_vign_appear_player" );
    level scene::init( "cin_new_02_01_pallasintro_vign_appear" );
    util::set_streamer_hint( 2 );
    newworld_util::function_83a7d040();
    util::streamer_wait();
    level flag::clear( "infinite_white_transition" );
    array::thread_all( level.activeplayers, &newworld_util::function_737d2864, &"CP_MI_ZURICH_NEWWORLD_LOCATION_FACTORY", &"CP_MI_ZURICH_NEWWORLD_TIME_FACTORY" );
    pallas_intro_scene();
    util::clear_streamer_hint();
    exploder::exploder_stop( "fx_exterior_igc_tracer_intro" );
}

// Namespace newworld_factory
// Params 0
// Checksum 0x34943f9e, Offset: 0x32e8
// Size: 0x15c
function pallas_intro_scene()
{
    exploder::exploder( "fx_exterior_igc_tracer_intro" );
    level scene::add_player_linked_scene( "cin_new_02_01_pallasintro_vign_appear" );
    level scene::add_scene_func( "cin_new_02_01_pallasintro_vign_appear", &function_453b588c );
    level scene::add_scene_func( "cin_new_02_01_pallasintro_vign_appear", &function_b0753d7b );
    level thread scene::play( "cin_new_02_01_pallasintro_vign_appear" );
    
    if ( isdefined( level.bzm_newworlddialogue2callback ) )
    {
        level thread [[ level.bzm_newworlddialogue2callback ]]();
    }
    
    level scene::add_scene_func( "cin_new_02_01_pallasintro_vign_appear_player", &function_1b440643 );
    level scene::add_scene_func( "cin_new_02_01_pallasintro_vign_appear_player", &function_b1896f5, "players_done" );
    level scene::play( "cin_new_02_01_pallasintro_vign_appear_player" );
    level thread namespace_e38c3c58::function_973b77f9();
}

// Namespace newworld_factory
// Params 1
// Checksum 0x108dac33, Offset: 0x3450
// Size: 0x24
function function_b1896f5( a_ents )
{
    util::teleport_players_igc( "factory_factory_exterior" );
}

// Namespace newworld_factory
// Params 0
// Checksum 0x37500f89, Offset: 0x3480
// Size: 0x1c2
function function_97f60350()
{
    var_e1b54d68 = [];
    array::add( var_e1b54d68, struct::spawn( ( 22428.9, -10169.4, -7248 ), ( 0, 86.7993, 0 ) ) );
    array::add( var_e1b54d68, struct::spawn( ( 22505.6, -10169.9, -7249 ), ( 0, 86.3997, 0 ) ) );
    array::add( var_e1b54d68, struct::spawn( ( 22627, -10173.8, -7252 ), ( 0, 91.7998, 0 ) ) );
    array::add( var_e1b54d68, struct::spawn( ( 22704.9, -10172.7, -7252 ), ( 0, 91.3996, 0 ) ) );
    
    foreach ( struct in var_e1b54d68 )
    {
        struct.targetname = "factory_factory_exterior";
        struct struct::init();
    }
}

// Namespace newworld_factory
// Params 1
// Checksum 0x5464549e, Offset: 0x3650
// Size: 0x3c
function function_453b588c( a_ents )
{
    level thread function_8db0ac1a( a_ents );
    level thread function_94d27( a_ents );
}

// Namespace newworld_factory
// Params 1
// Checksum 0x2e0e23d3, Offset: 0x3698
// Size: 0x4c
function function_b0753d7b( a_ents )
{
    a_ents[ "factory_intro_truck_01" ] thread function_69cfc912();
    a_ents[ "factory_intro_truck_01" ] thread function_788efb3b();
}

// Namespace newworld_factory
// Params 0
// Checksum 0x3ee6f866, Offset: 0x36f0
// Size: 0x2c
function function_69cfc912()
{
    self waittill( #"hash_4fe13a89" );
    self setmodel( "veh_t7_civ_truck_pickup_tech_zdf_dead" );
}

// Namespace newworld_factory
// Params 0
// Checksum 0x211f797c, Offset: 0x3728
// Size: 0x24
function function_788efb3b()
{
    self waittill( #"disconnect_paths" );
    self disconnectpaths();
}

// Namespace newworld_factory
// Params 1
// Checksum 0x61f446e2, Offset: 0x3758
// Size: 0x74
function function_8db0ac1a( a_ents )
{
    level waittill( #"hash_caecba47" );
    
    if ( !scene::is_skipping_in_progress() )
    {
        setpauseworld( 1 );
        newworld_util::function_85d8906c();
        level clientfield::set( "factory_exterior_vents", 1 );
    }
}

// Namespace newworld_factory
// Params 1
// Checksum 0x81698fd6, Offset: 0x37d8
// Size: 0xa4
function function_94d27( a_ents )
{
    level.ai_diaz waittill( #"unfreeze" );
    e_clip = getent( "snow_umbrella_factory_intro_igc", "targetname" );
    e_clip delete();
    setpauseworld( 0 );
    newworld_util::player_snow_fx();
    level clientfield::set( "factory_exterior_vents", 0 );
}

// Namespace newworld_factory
// Params 1
// Checksum 0xbb684b37, Offset: 0x3888
// Size: 0x54
function function_1b440643( a_ents )
{
    level thread function_921c1035( a_ents );
    level thread function_8af70712( a_ents );
    level thread function_86604714( a_ents );
}

// Namespace newworld_factory
// Params 1
// Checksum 0xd3e0a0a9, Offset: 0x38e8
// Size: 0x4c
function function_921c1035( a_ents )
{
    a_ents[ "taylor" ] waittill( #"rez_in" );
    a_ents[ "taylor" ] thread newworld_util::function_c949a8ed( 1 );
}

// Namespace newworld_factory
// Params 1
// Checksum 0x4cb036f3, Offset: 0x3940
// Size: 0x4c
function function_8af70712( a_ents )
{
    a_ents[ "diaz" ] waittill( #"rez_in" );
    a_ents[ "diaz" ] thread newworld_util::function_c949a8ed( 1 );
}

// Namespace newworld_factory
// Params 1
// Checksum 0xc1ad7bf, Offset: 0x3998
// Size: 0x44
function function_86604714( a_ents )
{
    a_ents[ "taylor" ] waittill( #"rez_out" );
    a_ents[ "taylor" ] thread newworld_util::function_4943984c();
}

// Namespace newworld_factory
// Params 2
// Checksum 0x92803bbb, Offset: 0x39e8
// Size: 0x22c
function skipto_factory_exterior_init( str_objective, b_starting )
{
    if ( b_starting )
    {
        load::function_73adcefc();
        common_startup_tasks( str_objective );
        level intro_area_threatgroups_setup();
        level scene::skipto_end_noai( "cin_new_02_01_pallasintro_vign_appear" );
        level scene::skipto_end( "p7_fxanim_cp_newworld_truck_flip_factory_igc_bundle" );
        mdl_truck = getent( "factory_intro_truck_01", "targetname" );
        mdl_truck setmodel( "veh_t7_civ_truck_pickup_tech_zdf_dead" );
        mdl_truck disconnectpaths();
        spawn_manager::enable( "sm_intro_area_ally_skipto" );
        load::function_a2995f22();
    }
    
    util::delay( 0.6, undefined, &newworld_util::function_3e37f48b, 0 );
    level thread function_c5eadf67();
    battlechatter::function_d9f49fba( 1 );
    level thread namespace_e38c3c58::function_fa2e45b8();
    level thread intro_area();
    trigger::wait_till( "alley_start" );
    level thread namespace_e38c3c58::function_92eefdb3();
    array::thread_all( spawner::get_ai_group_ai( "intro_area_enemy" ), &newworld_util::function_95132241 );
    skipto::objective_completed( str_objective );
}

// Namespace newworld_factory
// Params 4
// Checksum 0xcbc4fadf, Offset: 0x3c20
// Size: 0x24
function skipto_factory_exterior_done( str_objective, b_starting, b_direct, player )
{
    
}

// Namespace newworld_factory
// Params 2
// Checksum 0xcd039290, Offset: 0x3c50
// Size: 0x214
function skipto_alley_init( str_objective, b_starting )
{
    if ( b_starting )
    {
        load::function_73adcefc();
        spawn_manager::enable( "sm_alley_area_ally" );
        trigger::use( "alley_color_trigger_start" );
        level thread newworld_util::function_3e37f48b( 0 );
        level thread function_c5eadf67();
        common_startup_tasks( str_objective );
        level thread objectives::breadcrumb( "factory_intro_breadcrumb" );
        objectives::set( "cp_level_newworld_factory_subobj_goto_hideout" );
        load::function_a2995f22();
        level thread namespace_e38c3c58::function_92eefdb3();
    }
    
    level flag::init( "player_completed_alley" );
    battlechatter::function_d9f49fba( 0 );
    level thread alley_area();
    level flag::wait_till( "player_completed_silo" );
    savegame::checkpoint_save();
    level objectives::breadcrumb( "alley_breadcrumb" );
    level flag::set( "player_completed_alley" );
    array::thread_all( spawner::get_ai_group_ai( "alley_enemies" ), &newworld_util::function_95132241 );
    skipto::objective_completed( str_objective );
}

// Namespace newworld_factory
// Params 4
// Checksum 0x2e0443cb, Offset: 0x3e70
// Size: 0x24
function skipto_alley_done( str_objective, b_starting, b_direct, player )
{
    
}

// Namespace newworld_factory
// Params 2
// Checksum 0x844c3280, Offset: 0x3ea0
// Size: 0x10c
function skipto_warehouse_init( str_objective, b_starting )
{
    if ( b_starting )
    {
        load::function_73adcefc();
        level thread newworld_util::function_3e37f48b( 0 );
        level thread function_c5eadf67();
        common_startup_tasks( str_objective );
        objectives::set( "cp_level_newworld_factory_subobj_goto_hideout" );
        load::function_a2995f22();
    }
    
    level thread warehouse_area();
    level thread objectives::breadcrumb( "warehouse_breadcrumb" );
    trigger::wait_till( "foundry_start", undefined, undefined, 0 );
    skipto::objective_completed( str_objective );
}

// Namespace newworld_factory
// Params 4
// Checksum 0xfa50c59f, Offset: 0x3fb8
// Size: 0x5c
function skipto_warehouse_done( str_objective, b_starting, b_direct, player )
{
    objectives::complete( "cp_level_newworld_factory_subobj_goto_hideout" );
    callback::remove_on_connect( &player_tac_mode_watcher );
}

// Namespace newworld_factory
// Params 2
// Checksum 0xf1297b15, Offset: 0x4020
// Size: 0xea
function skipto_foundry_init( str_objective, b_starting )
{
    if ( b_starting )
    {
        load::function_73adcefc();
        level thread newworld_util::function_3e37f48b( 0 );
        common_startup_tasks( str_objective );
        level thread spawn_hijack_vehicles( b_starting );
        load::function_a2995f22();
    }
    
    battlechatter::function_d9f49fba( 0 );
    level thread namespace_e38c3c58::function_d8182956();
    foundry_area();
    skipto::objective_completed( str_objective );
    level notify( #"foundry_complete" );
}

// Namespace newworld_factory
// Params 4
// Checksum 0x240bc3a7, Offset: 0x4118
// Size: 0x64
function skipto_foundry_done( str_objective, b_starting, b_direct, player )
{
    if ( b_starting === 1 )
    {
        objectives::complete( "cp_level_newworld_factory_subobj_hijack_drone" );
        objectives::complete( "cp_level_newworld_foundry_subobj_destroy_generator" );
    }
}

// Namespace newworld_factory
// Params 2
// Checksum 0x7ed4b27a, Offset: 0x4188
// Size: 0x1ac
function skipto_vat_room_init( str_objective, b_starting )
{
    if ( b_starting )
    {
        load::function_73adcefc();
        level.var_b7a27741 = 1;
        common_startup_tasks( str_objective );
        level.ai_diaz ai::set_behavior_attribute( "sprint", 0 );
        level.ai_diaz ai::set_behavior_attribute( "cqb", 1 );
        trigger::use( "vat_room_color_trigger_start" );
        load::function_a2995f22();
        level thread namespace_e38c3c58::function_ccafa212();
    }
    
    level thread newworld_accolades::function_f7dd9b2c();
    battlechatter::function_d9f49fba( 0 );
    umbragate_set( "umbra_gate_vat_room_door_01", 0 );
    
    if ( sessionmodeiscampaignzombiesgame() )
    {
        e_clip = getent( "vat_room_flank_route_monster_clip", "targetname" );
        e_clip delete();
    }
    
    vat_room();
    level thread util::set_streamer_hint( 3 );
    skipto::objective_completed( str_objective );
}

// Namespace newworld_factory
// Params 4
// Checksum 0x45314032, Offset: 0x4340
// Size: 0x84
function skipto_vat_room_done( str_objective, b_starting, b_direct, player )
{
    if ( b_starting === 1 )
    {
        objectives::complete( "cp_level_newworld_vat_room_subobj_locate_command_ctr" );
        objectives::complete( "cp_level_newworld_vat_room_subobj_hack_door" );
    }
    
    callback::remove_on_connect( &function_5e3e5d06 );
}

// Namespace newworld_factory
// Params 0
// Checksum 0xb6756fb5, Offset: 0x43d0
// Size: 0x25c
function intro_area()
{
    spawner::add_spawn_function_group( "friendly_left", "script_string", &set_threat_bias );
    spawner::add_spawn_function_group( "friendly_right", "script_string", &set_threat_bias );
    spawner::add_spawn_function_group( "left_flank", "script_string", &set_threat_bias );
    spawner::add_spawn_function_group( "right_flank", "script_string", &set_threat_bias );
    var_f91ba6e1 = getent( "diaz_factory_first_target", "script_noteworthy" );
    var_f91ba6e1 spawner::add_spawn_function( &function_e9ba1a28 );
    spawn_manager::enable( "sm_intro_area_ally" );
    spawn_manager::enable( "sm_intro_initial_enemies_left" );
    spawn_manager::enable( "sm_intro_initial_enemies_right" );
    spawn_manager::enable( "sm_center_path_enemies" );
    spawn_manager::enable( "sm_hi_lo_area_enemies" );
    spawn_manager::enable( "sm_intro_initial_enemies_center_1" );
    spawn_manager::enable( "sm_intro_initial_enemies_catwalk" );
    trigger::use( "intro_color_trigger_start" );
    level thread function_738d040b();
    level thread function_cdca03a4();
    level thread function_6cc0f04e();
    level thread objectives::breadcrumb( "factory_intro_breadcrumb" );
    level thread objectives::set( "cp_level_newworld_factory_subobj_goto_hideout" );
}

// Namespace newworld_factory
// Params 0
// Checksum 0x4fa58d89, Offset: 0x4638
// Size: 0x22a
function function_6cc0f04e()
{
    trigger::wait_till( "intro_factory_start_retreat" );
    
    foreach ( ai_friendly in spawner::get_ai_group_ai( "factory_allies" ) )
    {
        if ( ai_friendly.script_noteworthy === "expendable" )
        {
            ai_friendly thread function_900831e2();
        }
    }
    
    e_goal = getent( "intro_factory_retreat", "targetname" );
    a_ai_enemy = spawner::get_ai_group_ai( "intro_area_enemy" );
    
    foreach ( ai_enemy in a_ai_enemy )
    {
        if ( isalive( ai_enemy ) && !ai_enemy istouching( e_goal ) && ai_enemy.script_noteworthy !== "no_retreat" )
        {
            ai_enemy setgoal( e_goal );
            wait randomfloatrange( 0.5, 1.5 );
        }
    }
}

// Namespace newworld_factory
// Params 0
// Checksum 0x786c836b, Offset: 0x4870
// Size: 0x12c
function function_900831e2()
{
    self endon( #"death" );
    self util::stop_magic_bullet_shield();
    wait randomfloatrange( 10, 20 );
    b_can_delete = 0;
    
    while ( b_can_delete == 0 )
    {
        wait 1;
        
        foreach ( e_player in level.activeplayers )
        {
            if ( e_player util::is_player_looking_at( self.origin ) == 0 )
            {
                b_can_delete = 1;
                continue;
            }
            
            b_can_delete = 0;
        }
    }
    
    self kill();
}

// Namespace newworld_factory
// Params 0
// Checksum 0xa5143efb, Offset: 0x49a8
// Size: 0xf4
function function_cdca03a4()
{
    trigger::wait_till( "intro_factory_start_tac_mode" );
    
    if ( sessionmodeiscampaignzombiesgame() )
    {
        return;
    }
    
    level thread function_2fa20b5d();
    trigger::wait_till( "intro_factory_retreat" );
    spawn_manager::enable( "sm_intro_tac_mode" );
    scene::add_scene_func( "cin_new_03_01_factoryraid_aie_break_glass", &factory_exterior_break_glass_left, "play" );
    scene::add_scene_func( "cin_new_03_01_factoryraid_aie_break_glass", &factory_exterior_break_glass_right, "play" );
    level thread scene::play( "cin_new_03_01_factoryraid_aie_break_glass" );
}

// Namespace newworld_factory
// Params 1
// Checksum 0xb51312aa, Offset: 0x4aa8
// Size: 0x74
function factory_exterior_break_glass_left( a_ents )
{
    level waittill( #"factory_exterior_break_glass_left" );
    s_org = struct::get( "factory_exterior_break_glass_left", "targetname" );
    glassradiusdamage( s_org.origin, 50, 500, 500 );
}

// Namespace newworld_factory
// Params 1
// Checksum 0x27e8fe41, Offset: 0x4b28
// Size: 0x74
function factory_exterior_break_glass_right( a_ents )
{
    level waittill( #"factory_exterior_break_glass_right" );
    s_org = struct::get( "factory_exterior_break_glass_right", "targetname" );
    glassradiusdamage( s_org.origin, 50, 500, 500 );
}

// Namespace newworld_factory
// Params 0
// Checksum 0x8575d8dc, Offset: 0x4ba8
// Size: 0x102
function function_2fa20b5d()
{
    level.ai_diaz thread dialog::say( "diaz_your_dni_can_provide_0" );
    level.var_9ef26e4f = 1;
    newworld_util::function_3196eaee( 1 );
    
    foreach ( player in level.players )
    {
        if ( player newworld_util::function_c633d8fe() )
        {
            continue;
        }
        
        player thread show_tac_mode_hint();
        player thread function_a77545da();
    }
}

// Namespace newworld_factory
// Params 0
// Checksum 0x1a1b9dd6, Offset: 0x4cb8
// Size: 0xd4
function function_e9ba1a28()
{
    self.health = 10;
    level.ai_diaz ai::shoot_at_target( "shoot_until_target_dead", self );
    a_ai_balcony = getentarray( "no_retreat", "script_noteworthy", 1 );
    
    if ( isdefined( a_ai_balcony ) && isalive( a_ai_balcony[ 0 ] ) )
    {
        level.ai_diaz ai::shoot_at_target( "kill_within_time", a_ai_balcony[ 0 ], undefined, 3 );
    }
    
    trigger::use( "t_color_diaz_right_flank_quick_start" );
}

// Namespace newworld_factory
// Params 0
// Checksum 0x4374df7b, Offset: 0x4d98
// Size: 0x104
function intro_area_threatgroups_setup()
{
    createthreatbiasgroup( "factory_intro_threatbias_friendly_left" );
    createthreatbiasgroup( "factory_intro_threatbias_enemy_left" );
    createthreatbiasgroup( "factory_intro_threatbias_friendly_right" );
    createthreatbiasgroup( "factory_intro_threatbias_enemy_right" );
    setthreatbias( "factory_intro_threatbias_friendly_left", "factory_intro_threatbias_enemy_right", -5000 );
    setthreatbias( "factory_intro_threatbias_enemy_right", "factory_intro_threatbias_friendly_left", -5000 );
    setthreatbias( "factory_intro_threatbias_friendly_right", "factory_intro_threatbias_enemy_left", -5000 );
    setthreatbias( "factory_intro_threatbias_enemy_left", "factory_intro_threatbias_friendly_right", -5000 );
}

// Namespace newworld_factory
// Params 0
// Checksum 0x24fa2768, Offset: 0x4ea8
// Size: 0xd2
function set_threat_bias()
{
    str_flank = self.script_string;
    
    switch ( str_flank )
    {
        case "right_flank":
            self setthreatbiasgroup( "factory_intro_threatbias_enemy_right" );
            break;
        case "left_flank":
            self setthreatbiasgroup( "factory_intro_threatbias_enemy_left" );
            break;
        case "friendly_left":
            self setthreatbiasgroup( "factory_intro_threatbias_friendly_left" );
            break;
        case "friendly_right":
            self setthreatbiasgroup( "factory_intro_threatbias_friendly_right" );
            break;
        default:
            break;
    }
}

// Namespace newworld_factory
// Params 0
// Checksum 0xd32a2c96, Offset: 0x4f88
// Size: 0x1c4
function alley_area()
{
    level thread function_5f94cc0();
    level thread function_8774b593();
    level thread function_84b0c4c4();
    level flag::wait_till( "player_completed_silo" );
    spawn_manager::enable( "sm_alley_front_left_enemies" );
    spawn_manager::enable( "sm_alley_front_right_enemies" );
    spawner::simple_spawn_single( "diaz_wallrun_target" );
    trigger::wait_till( "alley_half_way" );
    spawn_manager::enable( "sm_alley_rear_left" );
    spawn_manager::enable( "sm_alley_rear_right" );
    trigger::wait_till( "alley_reinforcements" );
    spawn_manager::enable( "sm_alley_reinforcements" );
    level thread function_b9d42d14();
    level.ai_diaz thread dialog::say( "diaz_reinforcements_at_th_0", 2 );
    spawner::waittill_ai_group_ai_count( "alley_enemies", 2 );
    
    if ( !level flag::get( "player_completed_alley" ) )
    {
        trigger::use( "alley_end_diaz_color" );
    }
}

// Namespace newworld_factory
// Params 0
// Checksum 0x1152e31, Offset: 0x5158
// Size: 0x1e2
function function_b9d42d14()
{
    foreach ( ai_friendly in spawner::get_ai_group_ai( "factory_allies" ) )
    {
        ai_friendly thread function_900831e2();
    }
    
    e_goal = getent( "back_of_alley", "targetname" );
    a_ai_enemy = spawner::get_ai_group_ai( "alley_enemies" );
    
    foreach ( ai_enemy in a_ai_enemy )
    {
        if ( isalive( ai_enemy ) && !ai_enemy istouching( e_goal ) )
        {
            ai_enemy setgoal( e_goal );
            wait randomfloatrange( 0.5, 1.5 );
        }
    }
}

// Namespace newworld_factory
// Params 3
// Checksum 0x26c37f6d, Offset: 0x5348
// Size: 0x114
function function_9fb5e88f( str_start, n_delay, str_scene )
{
    if ( isdefined( n_delay ) )
    {
        wait n_delay;
    }
    
    var_90911853 = getweapon( "launcher_standard_magic_bullet" );
    s_start = struct::get( str_start, "targetname" );
    s_end = struct::get( s_start.target, "targetname" );
    e_missile = magicbullet( var_90911853, s_start.origin, s_end.origin );
    e_missile waittill( #"death" );
    
    if ( isdefined( str_scene ) )
    {
        level thread scene::play( str_scene );
    }
}

// Namespace newworld_factory
// Params 0
// Checksum 0x7bf53d58, Offset: 0x5468
// Size: 0x1cc
function function_8774b593()
{
    level scene::init( "p7_fxanim_cp_newworld_alley_pipes_bundle" );
    level flag::wait_till( "player_completed_silo" );
    trigger::wait_till( "t_tmode_explosive_lookat" );
    level notify( #"hash_3cb382c8" );
    
    foreach ( player in level.players )
    {
        if ( player newworld_util::function_c633d8fe() )
        {
            continue;
        }
        
        player thread show_tac_mode_hint();
    }
    
    level thread function_9fb5e88f( "alley_rocket_01" );
    level thread function_9fb5e88f( "alley_rocket_02", 1.7, "p7_fxanim_cp_newworld_alley_pipes_bundle" );
    level thread function_9fb5e88f( "alley_rocket_03", 3.6 );
    
    if ( !sessionmodeiscampaignzombiesgame() )
    {
        level.ai_diaz dialog::say( "diaz_tac_mode_will_highli_0" );
    }
    
    battlechatter::function_d9f49fba( 1 );
}

// Namespace newworld_factory
// Params 0
// Checksum 0x517ac475, Offset: 0x5640
// Size: 0xfa
function function_84b0c4c4()
{
    if ( sessionmodeiscampaignzombiesgame() )
    {
        return;
    }
    
    trigger::wait_till( "t_tmode_tutorial_hotzones" );
    level.ai_diaz thread dialog::say( "diaz_see_the_red_and_yell_0" );
    
    foreach ( player in level.players )
    {
        if ( player newworld_util::function_c633d8fe() )
        {
            continue;
        }
        
        player thread show_tac_mode_hint();
    }
}

// Namespace newworld_factory
// Params 0
// Checksum 0x40486026, Offset: 0x5748
// Size: 0x1f4
function function_5f94cc0()
{
    level flag::wait_till( "init_wallrun_tutorial" );
    
    foreach ( player in level.activeplayers )
    {
        if ( player newworld_util::function_c633d8fe() )
        {
            continue;
        }
        
        player thread function_b64491f1();
        player thread function_af28d0ba();
    }
    
    level.ai_diaz newworld_util::function_4943984c();
    level thread function_8b723eb();
    
    if ( isdefined( level.bzm_newworlddialogue2_2callback ) )
    {
        level thread [[ level.bzm_newworlddialogue2_2callback ]]();
    }
    
    level scene::add_scene_func( "cin_new_03_03_factoryraid_vign_wallrunright_diaz", &function_574f2ed1, "done" );
    level scene::add_scene_func( "cin_new_03_03_factoryraid_vign_wallrunright_diaz_pt2", &function_9e64a31f );
    level thread scene::play( "cin_new_03_03_factoryraid_vign_wallrunright_diaz" );
    level waittill( #"hash_7c8ade1b" );
    trigger::use( "set_diaz_color_post_wallrun", "targetname" );
    level thread function_ff4d4f4e();
}

// Namespace newworld_factory
// Params 1
// Checksum 0xcf2b6435, Offset: 0x5948
// Size: 0x8a
function function_574f2ed1( a_ents )
{
    foreach ( player in level.activeplayers )
    {
        player notify( #"hash_342714c9" );
    }
}

// Namespace newworld_factory
// Params 1
// Checksum 0xc684eaf7, Offset: 0x59e0
// Size: 0x84
function function_9e64a31f( a_ents )
{
    a_ents[ "diaz" ] waittill( #"start_fx" );
    level.ai_diaz clientfield::set( "wall_run_fx", 1 );
    a_ents[ "diaz" ] waittill( #"stop_fx" );
    level.ai_diaz clientfield::set( "wall_run_fx", 0 );
}

// Namespace newworld_factory
// Params 0
// Checksum 0xcbddbeb4, Offset: 0x5a70
// Size: 0x34
function function_8b723eb()
{
    trigger::wait_till( "t_wallrunright_diaz_visible_lookat" );
    level.ai_diaz newworld_util::function_c949a8ed();
}

// Namespace newworld_factory
// Params 0
// Checksum 0xc7e49f4c, Offset: 0x5ab0
// Size: 0x168
function function_b64491f1()
{
    self endon( #"death" );
    level endon( #"hash_3cb382c8" );
    self thread function_823ff83e();
    self waittill( #"hash_342714c9" );
    
    if ( isdefined( 30 ) )
    {
        __s = spawnstruct();
        __s endon( #"timeout" );
        __s util::delay_notify( 30, "timeout" );
    }
    
    self flag::init( "wallrun_tutorial_complete" );
    self thread function_f72a6585();
    
    while ( !self flag::get( "wallrun_tutorial_complete" ) )
    {
        self thread util::show_hint_text( &"CP_MI_ZURICH_NEWWORLD_WALLRUN_TUTORIAL", 0, undefined, 4 );
        self flag::wait_till_timeout( 4, "wallrun_tutorial_complete" );
        self thread util::hide_hint_text( 1 );
        self flag::wait_till_timeout( 3, "wallrun_tutorial_complete" );
    }
}

// Namespace newworld_factory
// Params 0
// Checksum 0x6eea4ee8, Offset: 0x5c20
// Size: 0x5a
function function_823ff83e()
{
    self endon( #"death" );
    self endon( #"hash_342714c9" );
    level endon( #"hash_3cb382c8" );
    trigger::wait_till( "player_at_wallrun_ledge", "targetname", self );
    self notify( #"hash_342714c9" );
}

// Namespace newworld_factory
// Params 0
// Checksum 0xd1f0a3a9, Offset: 0x5c88
// Size: 0xbc
function function_f72a6585()
{
    self endon( #"death" );
    level endon( #"hash_3cb382c8" );
    
    if ( isdefined( 30 ) )
    {
        __s = spawnstruct();
        __s endon( #"timeout" );
        __s util::delay_notify( 30, "timeout" );
    }
    
    while ( true )
    {
        if ( self iswallrunning() )
        {
            self flag::set( "wallrun_tutorial_complete" );
            break;
        }
        
        wait 0.1;
    }
}

// Namespace newworld_factory
// Params 0
// Checksum 0x8c0ca26b, Offset: 0x5d50
// Size: 0x254
function function_ff4d4f4e()
{
    var_10d6597a = getnodearray( "diaz_wallrun_attack_traversal", "script_noteworthy" );
    
    foreach ( node in var_10d6597a )
    {
        setenablenode( node, 0 );
    }
    
    e_target = getent( "diaz_wallrun_target_ai", "targetname" );
    
    if ( isdefined( e_target ) && isalive( e_target ) )
    {
        e_target ai::set_ignoreme( 1 );
    }
    
    level flag::wait_till( "player_completed_silo" );
    
    if ( isdefined( e_target ) && isalive( e_target ) )
    {
        level scene::play( "cin_new_03_01_factoryraid_vign_wallrun_attack_attack" );
    }
    else
    {
        level scene::play( "cin_new_03_01_factoryraid_vign_wallrun_attack_landing" );
    }
    
    trigger::use( "post_wall_run_diaz_color" );
    
    foreach ( node in var_10d6597a )
    {
        setenablenode( node, 1 );
    }
    
    level thread namespace_e38c3c58::function_fa2e45b8();
}

// Namespace newworld_factory
// Params 0
// Checksum 0xd4d2eea6, Offset: 0x5fb0
// Size: 0x16a
function show_tac_mode_hint()
{
    if ( sessionmodeiscampaignzombiesgame() )
    {
        return;
    }
    
    self endon( #"death" );
    level endon( #"hash_827eb14f" );
    
    if ( isdefined( 30 ) )
    {
        __s = spawnstruct();
        __s endon( #"timeout" );
        __s util::delay_notify( 30, "timeout" );
    }
    
    while ( !self flag::get( "tactical_mode_used" ) )
    {
        if ( !self laststand::player_is_in_laststand() )
        {
            self thread util::show_hint_text( &"CP_MI_ZURICH_NEWWORLD_USE_TACTICAL_VISION", 0, undefined, 4 );
            self flag::wait_till_timeout( 4, "tactical_mode_used" );
            self thread util::hide_hint_text( 1 );
            
            if ( !self flag::get( "tactical_mode_used" ) )
            {
                self flag::wait_till_timeout( 3, "tactical_mode_used" );
            }
            
            continue;
        }
        
        wait 10;
    }
}

// Namespace newworld_factory
// Params 0
// Checksum 0x99dbe4f, Offset: 0x6128
// Size: 0xdc
function function_c5eadf67()
{
    level flag::wait_till( "all_players_connected" );
    
    foreach ( player in level.players )
    {
        player thread player_tac_mode_watcher();
    }
    
    util::wait_network_frame();
    callback::on_connect( &player_tac_mode_watcher );
}

// Namespace newworld_factory
// Params 0
// Checksum 0xdc270904, Offset: 0x6210
// Size: 0x64
function player_tac_mode_watcher()
{
    self endon( #"death" );
    level endon( #"hash_827eb14f" );
    self flag::init( "tactical_mode_used" );
    self thread function_859fc69a();
    self thread function_b085bdaf();
}

// Namespace newworld_factory
// Params 0
// Checksum 0xc5b9070a, Offset: 0x6280
// Size: 0x50
function function_859fc69a()
{
    self endon( #"death" );
    level endon( #"hash_68b78be8" );
    
    while ( true )
    {
        self waittill( #"tactical_mode_activated" );
        self flag::set( "tactical_mode_used" );
    }
}

// Namespace newworld_factory
// Params 0
// Checksum 0xdfd7bc6f, Offset: 0x62d8
// Size: 0x50
function function_b085bdaf()
{
    self endon( #"death" );
    level endon( #"hash_68b78be8" );
    
    while ( true )
    {
        self waittill( #"tactical_mode_deactivated" );
        self flag::clear( "tactical_mode_used" );
    }
}

// Namespace newworld_factory
// Params 0
// Checksum 0xd3bf3237, Offset: 0x6330
// Size: 0xaa
function alley_allies_lower_health()
{
    a_allies = spawner::get_ai_group_ai( "factory_intro_allies" );
    
    foreach ( ai in a_allies )
    {
        ai thread wait_and_lower_health();
    }
}

// Namespace newworld_factory
// Params 0
// Checksum 0xe371a0ac, Offset: 0x63e8
// Size: 0x38
function wait_and_lower_health()
{
    self endon( #"death" );
    wait randomfloatrange( 1, 5 );
    self.health = 1;
}

// Namespace newworld_factory
// Params 0
// Checksum 0x9ccbbca9, Offset: 0x6428
// Size: 0x164
function warehouse_area()
{
    level flag::init( "tac_mode_LOS_start" );
    level thread function_f7e76a4c();
    level thread spawn_hijack_vehicles();
    level thread function_b11050e5();
    spawn_manager::enable( "sm_warehouse_bottom" );
    spawn_manager::enable( "sm_warehouse_top_left" );
    spawn_manager::enable( "sm_warehouse_top_right" );
    level thread namespace_e38c3c58::function_fa2e45b8();
    trigger::wait_till( "warehouse_fallback" );
    spawn_manager::enable( "sm_warehouse_last_enemies" );
    trigger::wait_till( "warehouse_last_stand" );
    level thread function_7ed63742();
    spawner::waittill_ai_group_cleared( "warehouse_enemy" );
    level flag::set( "foundry_remote_hijack_enabled" );
}

// Namespace newworld_factory
// Params 0
// Checksum 0x9048d0ba, Offset: 0x6598
// Size: 0x6a
function function_8696052d()
{
    trigger::wait_till( "t_tmode_tutorial_LOS_lookat" );
    
    if ( !level flag::get( "tac_mode_LOS_start" ) )
    {
        level flag::set( "tac_mode_LOS_start" );
        level notify( #"tac_mode_LOS_start" );
    }
}

// Namespace newworld_factory
// Params 0
// Checksum 0x2afd92c7, Offset: 0x6610
// Size: 0x6a
function t_tmode_tutorial_LOS()
{
    trigger::wait_till( "t_tmode_tutorial_LOS" );
    
    if ( !level flag::get( "tac_mode_LOS_start" ) )
    {
        level flag::set( "tac_mode_LOS_start" );
        level notify( #"tac_mode_LOS_start" );
    }
}

// Namespace newworld_factory
// Params 0
// Checksum 0xa848ef7c, Offset: 0x6688
// Size: 0x164
function function_f7e76a4c()
{
    if ( sessionmodeiscampaignzombiesgame() )
    {
        return;
    }
    
    level thread function_8696052d();
    level thread t_tmode_tutorial_LOS();
    level waittill( #"tac_mode_LOS_start" );
    level.ai_diaz thread dialog::say( "diaz_tac_mode_info_is_syn_0" );
    
    foreach ( player in level.players )
    {
        if ( player newworld_util::function_c633d8fe() )
        {
            continue;
        }
        
        player thread show_tac_mode_hint();
    }
    
    battlechatter::function_d9f49fba( 1 );
    level thread function_da86d58f();
    level thread function_14da3d31();
}

// Namespace newworld_factory
// Params 0
// Checksum 0x2d8fde23, Offset: 0x67f8
// Size: 0x34
function function_da86d58f()
{
    level endon( #"foundry_start" );
    level.ai_diaz dialog::say( "diaz_keep_moving_up_0", 15 );
}

// Namespace newworld_factory
// Params 0
// Checksum 0xaa23ac6c, Offset: 0x6838
// Size: 0x17c
function function_14da3d31()
{
    level endon( #"foundry_start" );
    
    while ( true )
    {
        var_da5600e3 = getentarray( "warehouse_ammo", "targetname" );
        
        foreach ( var_4abed703 in var_da5600e3 )
        {
            foreach ( e_player in level.activeplayers )
            {
                if ( distance2d( e_player.origin, var_4abed703.origin ) < 100 )
                {
                    level.ai_diaz dialog::say( "diaz_check_your_ammo_gra_0" );
                    return;
                }
            }
        }
        
        wait 1;
    }
}

// Namespace newworld_factory
// Params 1
// Checksum 0xc7427e2f, Offset: 0x69c0
// Size: 0x19c
function function_4fbc759( a_amws )
{
    scene::add_scene_func( "cin_new_03_03_factoryraid_vign_startup_flee", &function_6f46b3ee, "init" );
    scene::add_scene_func( "cin_new_03_03_factoryraid_vign_startup_flee", &function_54cce95e );
    level thread scene::init( "cin_new_03_03_factoryraid_vign_startup_flee", a_amws );
    scene::add_scene_func( "cin_new_03_03_factoryraid_vign_startup", &function_43764348, "init" );
    a_s_scenes = struct::get_array( "warehouse_startup_scene", "targetname" );
    
    foreach ( s_scene in a_s_scenes )
    {
        s_scene thread function_4432ae41();
    }
    
    level flag::wait_till( "trigger_warehouse_worker_vignettes" );
    level thread scene::play( "cin_new_03_03_factoryraid_vign_startup_flee", a_amws );
}

// Namespace newworld_factory
// Params 0
// Checksum 0x14bca9ff, Offset: 0x6b68
// Size: 0xa4
function function_4432ae41()
{
    wait randomfloatrange( 0.1, 1.5 );
    self scene::init();
    level flag::wait_till( "trigger_warehouse_worker_vignettes" );
    wait randomfloatrange( 0.1, 1.5 );
    self thread scene::play();
}

// Namespace newworld_factory
// Params 1
// Checksum 0x18f2de85, Offset: 0x6c18
// Size: 0x4c
function function_6f46b3ee( a_ents )
{
    a_ents[ "factoryraid_vign_startup_flee_soldier_a" ] util::magic_bullet_shield();
    a_ents[ "factoryraid_vign_startup_flee_soldier_b" ] util::magic_bullet_shield();
}

// Namespace newworld_factory
// Params 1
// Checksum 0xbe60083d, Offset: 0x6c70
// Size: 0x6c
function function_54cce95e( a_ents )
{
    level notify( #"hash_549286bb" );
    level waittill( #"hash_a54f8e97" );
    a_ents[ "factoryraid_vign_startup_flee_soldier_a" ] util::stop_magic_bullet_shield();
    a_ents[ "factoryraid_vign_startup_flee_soldier_b" ] util::stop_magic_bullet_shield();
}

// Namespace newworld_factory
// Params 1
// Checksum 0x5cf92a04, Offset: 0x6ce8
// Size: 0xcc
function function_43764348( a_ents )
{
    ai_enemy = a_ents[ "ai_warehouse_startup" ];
    ai_enemy endon( #"death" );
    level endon( #"trigger_warehouse_worker_vignettes" );
    e_goalvolume = getent( "warehouse_end_goalvolume", "targetname" );
    ai_enemy setgoal( e_goalvolume );
    ai_enemy util::waittill_any( "damage", "bulletwhizby" );
    level flag::set( "trigger_warehouse_worker_vignettes" );
}

// Namespace newworld_factory
// Params 1
// Checksum 0xc0ee12a, Offset: 0x6dc0
// Size: 0x4c
function function_b11050e5( a_ents )
{
    level thread function_8c12b9e9();
    level waittill( #"hash_549286bb" );
    wait 10;
    level thread close_heavy_doors();
}

// Namespace newworld_factory
// Params 0
// Checksum 0xd7ba8a58, Offset: 0x6e18
// Size: 0x114
function function_8c12b9e9()
{
    e_door_right = getent( "warehouse_exit_door_right", "targetname" );
    e_door_left = getent( "warehouse_exit_door_left", "targetname" );
    e_door_right rotateyaw( 75 * -1, 0.05 );
    e_door_left rotateyaw( 75, 0.05 );
    umbragate_set( "umbra_gate_factory_door_01", 1 );
    var_cecf22e2 = getent( "ug_factory_hideme", "targetname" );
    var_cecf22e2 hide();
}

// Namespace newworld_factory
// Params 0
// Checksum 0xb649e5af, Offset: 0x6f38
// Size: 0x18a
function function_7ed63742()
{
    a_ai = spawner::get_ai_group_ai( "warehouse_enemy" );
    e_goalvolume = getent( "warehouse_end_goalvolume", "targetname" );
    var_c873bdb2 = 0;
    
    foreach ( ai in a_ai )
    {
        if ( isalive( ai ) && !ai istouching( e_goalvolume ) )
        {
            var_c873bdb2++;
            
            if ( var_c873bdb2 <= 8 )
            {
                ai setgoal( e_goalvolume );
            }
            else
            {
                ai thread newworld_util::function_95132241();
            }
            
            wait randomfloatrange( 0.5, 2 );
        }
    }
}

// Namespace newworld_factory
// Params 1
// Checksum 0x87d91a05, Offset: 0x70d0
// Size: 0x17c
function close_heavy_doors( is_for_skipto )
{
    if ( !isdefined( is_for_skipto ) )
    {
        is_for_skipto = 0;
    }
    
    e_door_right = getent( "warehouse_exit_door_right", "targetname" );
    e_door_left = getent( "warehouse_exit_door_left", "targetname" );
    e_door_right rotateyaw( 75, 5, 0.25, 0.3 );
    e_door_left rotateyaw( 75 * -1, 5, 0.25, 0.3 );
    e_door_right waittill( #"rotatedone" );
    umbragate_set( "umbra_gate_factory_door_01", 0 );
    var_cecf22e2 = getent( "ug_factory_hideme", "targetname" );
    var_cecf22e2 show();
    var_cecf22e2 solid();
}

// Namespace newworld_factory
// Params 0
// Checksum 0x240f69b2, Offset: 0x7258
// Size: 0x25c
function foundry_area()
{
    level flag::init( "flag_hijack_complete" );
    level flag::init( "junkyard_door_open" );
    level flag::init( "player_returned_to_body_post_foundry" );
    level flag::init( "foundry_objective_complete" );
    setup_destroyable_vats( "foundry" );
    setup_destroyable_conveyor_belt_vats( "foundry" );
    battlechatter::function_d9f49fba( 0 );
    level thread function_29f8003e();
    level thread diaz_tutorial_and_talking();
    level thread open_door_to_junkyard_after_hijack();
    level thread function_254442e();
    level waittill( #"hash_fa1f139b" );
    battlechatter::function_d9f49fba( 1 );
    level thread function_3a211205();
    array::thread_all( getentarray( "vehicle_triggered", "script_noteworthy" ), &function_8df847d );
    spawn_manager::enable( "sm_foundry_reactor_balcony_1" );
    spawn_manager::enable( "sm_foundry_front_vat_left" );
    spawn_manager::enable( "sm_foundry_front_vat_right" );
    level thread function_4263aa02();
    level thread function_3fd07e2f();
    foundry_breadcrumbs();
    foundry_heavy_door_and_generator();
    level flag::wait_till( "player_moving_to_vat_room" );
}

// Namespace newworld_factory
// Params 0
// Checksum 0xd6dc832e, Offset: 0x74c0
// Size: 0x4c
function foundry_breadcrumbs()
{
    objectives::set( "cp_level_newworld_foundry_subobj_locate_generator" );
    objectives::breadcrumb( "foundry_breadcrumbs" );
    objectives::hide( "cp_level_newworld_foundry_subobj_locate_generator" );
}

// Namespace newworld_factory
// Params 0
// Checksum 0xcf56f6c9, Offset: 0x7518
// Size: 0x44
function function_29f8003e()
{
    var_1066b4e5 = getent( "foundry_generator_dmg", "targetname" );
    var_1066b4e5 ghost();
}

// Namespace newworld_factory
// Params 0
// Checksum 0x803f7013, Offset: 0x7568
// Size: 0x1c4
function diaz_tutorial_and_talking()
{
    level.ai_diaz sethighdetail( 1 );
    level.ai_diaz newworld_util::function_d0aa2f4f();
    
    if ( isdefined( level.bzm_newworlddialogue2_3callback ) )
    {
        level thread [[ level.bzm_newworlddialogue2_3callback ]]();
    }
    
    scene::add_scene_func( "cin_new_03_02_factoryraid_vign_explaindrones", &diaz_wasp_spawner );
    level thread scene::play( "cin_new_03_02_factoryraid_vign_explaindrones" );
    level waittill( #"hash_b14420d1" );
    objectives::set( "cp_level_newworld_factory_subobj_hijack_drone" );
    
    if ( !newworld_util::function_81acf083() )
    {
        level thread function_1fff53ca();
        level flag::wait_till( "flag_hijack_complete" );
    }
    else
    {
        level thread function_341b5959( 0 );
    }
    
    scene::add_scene_func( "cin_new_03_02_factoryraid_vign_explaindrones_open_door", &function_8aa7e247 );
    scene::add_scene_func( "cin_new_03_02_factoryraid_vign_explaindrones_open_door", &function_190c4318 );
    level thread scene::play( "cin_new_03_02_factoryraid_vign_explaindrones_open_door" );
    objectives::complete( "cp_level_newworld_factory_subobj_hijack_drone" );
    savegame::checkpoint_save();
}

// Namespace newworld_factory
// Params 1
// Checksum 0xc5b3973c, Offset: 0x7738
// Size: 0x64
function function_8aa7e247( a_ents )
{
    a_ents[ "diaz" ] waittill( #"hash_a1b55a28" );
    level.ai_diaz sethighdetail( 0 );
    a_ents[ "diaz" ] actor_camo( 1 );
}

// Namespace newworld_factory
// Params 1
// Checksum 0x67e2dcdd, Offset: 0x77a8
// Size: 0x3c
function function_190c4318( a_ents )
{
    level waittill( #"hash_140f40e1" );
    a_ents[ "diaz" ] cybercom::cybercom_armpulse( 1 );
}

// Namespace newworld_factory
// Params 0
// Checksum 0xa9cfdbc8, Offset: 0x77f0
// Size: 0x22c
function show_hijacking_hint()
{
    level.var_b7a27741 = 1;
    
    foreach ( player in level.players )
    {
        player thread player_hijack_watcher();
        
        if ( player newworld_util::function_c633d8fe() )
        {
            continue;
        }
        
        if ( !sessionmodeiscampaignzombiesgame() )
        {
            player cybercom_gadget::giveability( "cybercom_hijack", 0 );
            player cybercom_gadget::equipability( "cybercom_hijack", 1 );
        }
        
        player thread function_70704b5f();
    }
    
    callback::on_connect( &player_hijack_watcher );
    
    if ( !newworld_util::function_81acf083() )
    {
        level thread objective_hijack_drone_markers();
    }
    
    level notify( #"hash_68b78be8" );
    
    foreach ( player in level.players )
    {
        if ( player newworld_util::function_c633d8fe() )
        {
            continue;
        }
        
        player thread function_6eff1530();
    }
    
    level thread function_341b5959();
}

// Namespace newworld_factory
// Params 1
// Checksum 0xd4cd3149, Offset: 0x7a28
// Size: 0x64
function function_341b5959( b_wait )
{
    if ( !isdefined( b_wait ) )
    {
        b_wait = 1;
    }
    
    if ( b_wait )
    {
        level waittill( #"player_hijacked_vehicle" );
    }
    
    level thread namespace_e38c3c58::function_964ce03c();
    objectives::complete( "cp_level_newworld_factory_subobj_hijack_drone" );
}

// Namespace newworld_factory
// Params 0
// Checksum 0x5a04af77, Offset: 0x7a98
// Size: 0x7a
function function_1fff53ca()
{
    level endon( #"flag_hijack_complete" );
    
    while ( true )
    {
        if ( newworld_util::function_70aba08e() )
        {
            wait 0.1;
            continue;
        }
        
        level thread function_341b5959( 0 );
        level flag::set( "flag_hijack_complete" );
        return;
    }
}

// Namespace newworld_factory
// Params 0
// Checksum 0xf5a711eb, Offset: 0x7b20
// Size: 0x12c
function function_6eff1530()
{
    self endon( #"death" );
    level endon( #"foundry_generator_destroyed" );
    level endon( #"foundry_all_vehicles_hijacked" );
    self endon( #"player_entering_foundry_on_foot" );
    
    if ( sessionmodeiscampaignzombiesgame() )
    {
        return;
    }
    
    self gadgetpowerset( 0, 100 );
    self gadgetpowerset( 1, 100 );
    self thread function_c3c54cd1();
    
    while ( !self flag::get( "player_hijacked_vehicle" ) )
    {
        self thread util::show_hint_text( &"CP_MI_ZURICH_NEWWORLD_REMOTE_HIJACK_DRONE_TARGET", 0, undefined, -1 );
        self waittill( #"hash_50db7e6" );
        self thread function_40c6f0a4();
        self waittill( #"hash_8216024" );
    }
    
    self thread util::hide_hint_text( 1 );
}

// Namespace newworld_factory
// Params 0
// Checksum 0x67e0ede9, Offset: 0x7c58
// Size: 0x104
function function_40c6f0a4()
{
    self endon( #"hash_8216024" );
    level endon( #"foundry_generator_destroyed" );
    level endon( #"foundry_all_vehicles_hijacked" );
    self endon( #"player_entering_foundry_on_foot" );
    self util::hide_hint_text( 1 );
    
    while ( !self flag::get( "player_hijacked_vehicle" ) )
    {
        level waittill( #"ccom_locked_on", ent, e_player );
        
        if ( e_player == self )
        {
            self thread util::show_hint_text( &"CP_MI_ZURICH_NEWWORLD_REMOTE_HIJACK_DRONE_RELEASE", 0, undefined, -1 );
            level waittill( #"ccom_lost_lock", ent, e_player );
            
            if ( e_player == self )
            {
                self util::hide_hint_text( 1 );
                continue;
            }
        }
    }
}

// Namespace newworld_factory
// Params 0
// Checksum 0x4692faf9, Offset: 0x7d68
// Size: 0x7c
function function_c3c54cd1()
{
    self endon( #"death" );
    level endon( #"foundry_generator_destroyed" );
    level endon( #"foundry_all_vehicles_hijacked" );
    self endon( #"player_hijacked_vehicle" );
    trigger::wait_till( "player_entering_foundry_on_foot", "targetname", self );
    self notify( #"player_entering_foundry_on_foot" );
    self util::hide_hint_text( 1 );
}

// Namespace newworld_factory
// Params 0
// Checksum 0xd7fd0c3c, Offset: 0x7df0
// Size: 0x3d0
function player_hijack_watcher()
{
    self endon( #"disconnect" );
    level endon( #"foundry_complete" );
    
    if ( !self flag::exists( "player_hijacked_vehicle" ) )
    {
        self flag::init( "player_hijacked_vehicle" );
    }
    
    if ( !self flag::exists( "player_hijacked_wasp" ) )
    {
        self flag::init( "player_hijacked_wasp" );
    }
    
    if ( sessionmodeiscampaignzombiesgame() )
    {
        level flag::set( "flag_hijack_complete" );
        self flag::set( "player_hijacked_vehicle" );
        level notify( #"player_hijacked_vehicle" );
        return;
    }
    
    while ( true )
    {
        self waittill( #"clonedentity", e_clone );
        
        if ( e_clone.targetname === "foundry_hackable_vehicle_ai" )
        {
            self cybercom_gadget_security_breach::setanchorvolume( getent( "hijacked_vehicle_range", "targetname" ) );
            e_clone.overridevehicledamage = &callback_foundry_vehicle_damage;
            e_clone thread hijacked_vehicle_death_watch();
            level flag::set( "flag_hijack_complete" );
            self flag::set( "player_hijacked_vehicle" );
            level notify( #"player_hijacked_vehicle" );
            
            if ( !level flag::get( "foundry_objective_complete" ) )
            {
                objectives::hide( "cp_level_newworld_factory_hijack", self );
            }
            
            if ( e_clone.scriptvehicletype === "wasp" )
            {
                e_clone.var_66ff806d = 1;
                
                if ( !self flag::get( "player_hijacked_wasp" ) )
                {
                    self thread function_baeddf9e();
                }
            }
            
            self waittill( #"return_to_body" );
            self waittill( #"transition_done" );
            wait 0.1;
            self gadgetpowerchange( 0, 100 );
            self gadgetpowerchange( 1, 100 );
            
            if ( !level flag::get( "foundry_objective_complete" ) )
            {
                objectives::show( "cp_level_newworld_factory_hijack", self );
                
                if ( level.a_vh_hijack.size > 0 )
                {
                    if ( self newworld_util::function_c633d8fe() )
                    {
                        continue;
                    }
                    
                    self thread function_c3c54cd1();
                    var_65d6d111 = array( "foundry_generator_destroyed", "foundry_all_vehicles_hijacked" );
                    self thread newworld_util::function_6062e90( "cybercom_hijack", 0, "foundry_generator_destroyed", 1, "CP_MI_ZURICH_NEWWORLD_REMOTE_HIJACK_DRONE_TARGET", "CP_MI_ZURICH_NEWWORLD_REMOTE_HIJACK_DRONE_RELEASE", undefined, "player_entering_foundry_on_foot" );
                }
            }
        }
    }
}

// Namespace newworld_factory
// Params 0
// Checksum 0x74516109, Offset: 0x81c8
// Size: 0x74
function function_baeddf9e()
{
    self endon( #"death" );
    self flag::set( "player_hijacked_wasp" );
    
    if ( self newworld_util::function_c633d8fe() )
    {
        return;
    }
    
    wait 0.5;
    self thread util::show_hint_text( &"CP_MI_ZURICH_NEWWORLD_WASP_CONTROL_TUTORIAL", 0, undefined, 4 );
}

// Namespace newworld_factory
// Params 0
// Checksum 0xa5997dc5, Offset: 0x8248
// Size: 0x242
function objective_hijack_drone_markers()
{
    if ( sessionmodeiscampaignzombiesgame() )
    {
        return;
    }
    
    level.a_vh_hijack = array::remove_undefined( level.a_vh_hijack );
    
    foreach ( vh_drone in level.a_vh_hijack )
    {
        if ( vh_drone.archetype == "amws" )
        {
            vh_drone.var_1ab87762 = vh_drone.origin + ( 0, 0, 44 );
        }
        else if ( vh_drone.archetype == "wasp" )
        {
            if ( sessionmodeiscampaignzombiesgame() )
            {
                continue;
            }
            
            vh_drone.var_1ab87762 = vh_drone.origin + ( 0, 0, 18 );
        }
        
        vh_drone thread function_483e8906();
        objectives::set( "cp_level_newworld_factory_hijack", vh_drone.var_1ab87762 );
    }
    
    foreach ( player in level.players )
    {
        if ( player newworld_util::function_c633d8fe() )
        {
            objectives::hide( "cp_level_newworld_factory_hijack", player );
        }
    }
}

// Namespace newworld_factory
// Params 0
// Checksum 0x9f8b2313, Offset: 0x8498
// Size: 0x3c
function function_483e8906()
{
    level endon( #"foundry_generator_destroyed" );
    self waittill( #"cloneandremoveentity" );
    objectives::complete( "cp_level_newworld_factory_hijack", self.var_1ab87762 );
}

// Namespace newworld_factory
// Params 15
// Checksum 0x1b6f48be, Offset: 0x84e0
// Size: 0x88
function callback_foundry_no_vehicle_damage( einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, damagefromunderneath, modelindex, partname, vsurfacenormal )
{
    idamage = 0;
    return idamage;
}

// Namespace newworld_factory
// Params 15
// Checksum 0x1dd73805, Offset: 0x8570
// Size: 0x15e
function callback_foundry_vehicle_damage( einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, damagefromunderneath, modelindex, partname, vsurfacenormal )
{
    if ( sessionmodeiscampaignzombiesgame() )
    {
        return idamage;
    }
    
    n_enemy_count = getaiteamarray( "axis" ).size;
    
    if ( weapon.weapclass == "rocketlauncher" )
    {
        idamage *= 0.018;
        return idamage;
    }
    
    if ( n_enemy_count < 15 )
    {
        idamage *= 0.1;
    }
    else if ( n_enemy_count < 25 )
    {
        idamage *= 0.3;
    }
    
    return idamage;
}

// Namespace newworld_factory
// Params 0
// Checksum 0x8fb02289, Offset: 0x86d8
// Size: 0xbc
function hijacked_vehicle_death_watch()
{
    self waittill( #"death" );
    
    if ( isdefined( self.owner ) )
    {
        self.owner gadgetpowerchange( 0, 100 );
        self.owner gadgetpowerchange( 1, 100 );
        
        if ( self.archetype == "wasp" )
        {
            self playsound( "gdt_cybercore_wasp_shutdown" );
        }
        
        if ( self.archetype == "amws" )
        {
            self playsound( "gdt_cybercore_amws_shutdown" );
        }
    }
}

// Namespace newworld_factory
// Params 0
// Checksum 0x7fe21053, Offset: 0x87a0
// Size: 0x36c
function diaz_wasp_controller()
{
    util::magic_bullet_shield( self );
    self.nocybercom = 1;
    self ai::set_ignoreall( 1 );
    self ai::set_ignoreme( 1 );
    self vehicle_ai::set_state( "combat" );
    wait 0.05;
    self setgoal( struct::get( "diaz_wasp_start_pos", "targetname" ).origin, 1 );
    level flag::wait_till( "junkyard_door_open" );
    self setgoal( getent( "diaz_wasp_junkyard_goalvolume", "targetname" ) );
    level flag::wait_till( "foundry_junkyard_enemies_retreat" );
    self setgoal( getent( "foundry_diaz_wasp_area_1", "targetname" ) );
    self ai::set_ignoreall( 0 );
    self ai::set_ignoreme( 0 );
    self thread function_d0cde060();
    function_83d084fe( "foundry_area_1_moveup" );
    self setgoal( getent( "foundry_diaz_wasp_area_2", "targetname" ) );
    function_83d084fe( "foundry_area_2_moveup" );
    self setgoal( getent( "foundry_diaz_wasp_area_3", "targetname" ) );
    function_83d084fe( "foundry_area_3_moveup" );
    self function_9f084580();
    self setgoal( getent( "foundry_diaz_wasp_area_4", "targetname" ) );
    level flag::wait_till( "foundry_objective_complete" );
    self clientfield::set( "name_diaz_wasp", 0 );
    util::stop_magic_bullet_shield( self );
    self dodamage( self.health, self.origin );
    self clientfield::set( "emp_vehicles_fx", 1 );
    self util::delay( 8, undefined, &clientfield::set, "emp_vehicles_fx", 0 );
}

// Namespace newworld_factory
// Params 0
// Checksum 0x95290bdb, Offset: 0x8b18
// Size: 0xd6
function function_d0cde060()
{
    if ( level.activeplayers.size > 1 )
    {
        return;
    }
    
    function_83d084fe( "foundry_entered" );
    e_vat = getent( "s1_01", "script_string" );
    
    if ( e_vat.b_destroyed !== 1 )
    {
        self ai::shoot_at_target( "normal", e_vat, "fx_spill_middle_jnt", 3 );
        e_vat dodamage( 500, self.origin, self );
        wait 2;
    }
    
    level notify( #"hash_d3038698" );
}

// Namespace newworld_factory
// Params 0
// Checksum 0x505779f4, Offset: 0x8bf8
// Size: 0xac
function function_9f084580()
{
    if ( level.activeplayers.size > 1 )
    {
        return;
    }
    
    e_vat = getent( "bridge", "script_string" );
    
    if ( e_vat.b_destroyed !== 1 )
    {
        self ai::shoot_at_target( "normal", e_vat, "fx_spill_middle_jnt", 5 );
        e_vat dodamage( 500, self.origin, self );
    }
}

// Namespace newworld_factory
// Params 0
// Checksum 0x72a436d8, Offset: 0x8cb0
// Size: 0xd4
function open_door_to_junkyard_after_hijack()
{
    level waittill( #"hash_fa1f139b" );
    var_9b668c87 = getent( "fake_foundry_door", "targetname" );
    var_9b668c87 movez( 128, 3, 1, 0.5 );
    var_9b668c87 playsound( "evt_junkyard_door_open" );
    var_9b668c87 waittill( #"movedone" );
    level flag::set( "junkyard_door_open" );
}

// Namespace newworld_factory
// Params 0
// Checksum 0x67807085, Offset: 0x8d90
// Size: 0x12c
function function_254442e()
{
    level flag::init( "foundry_junkyard_enemies_retreat" );
    scene::add_scene_func( "cin_new_03_03_factoryraid_vign_junkyard", &function_dd0bd7eb, "init" );
    level scene::init( "cin_new_03_03_factoryraid_vign_junkyard" );
    var_4161ad80 = function_83d084fe( "player_enters_junkyard" );
    
    if ( var_4161ad80.archetype === "amws" )
    {
        wait 3;
    }
    
    level flag::set( "foundry_junkyard_enemies_retreat" );
    scene::add_scene_func( "cin_new_03_03_factoryraid_vign_junkyard", &function_328f9079, "done" );
    level scene::play( "cin_new_03_03_factoryraid_vign_junkyard" );
}

// Namespace newworld_factory
// Params 1
// Checksum 0x5554db6, Offset: 0x8ec8
// Size: 0xc2
function function_dd0bd7eb( a_ents )
{
    foreach ( ai in a_ents )
    {
        ai ai::set_ignoreall( 1 );
        ai ai::set_ignoreme( 1 );
        ai thread function_ae816470();
    }
}

// Namespace newworld_factory
// Params 0
// Checksum 0xf2cddda2, Offset: 0x8f98
// Size: 0x6c
function function_ae816470()
{
    self endon( #"death" );
    level endon( #"foundry_junkyard_enemies_retreat" );
    self util::waittill_any( "damage", "bulletwhizby", "pain", "proximity" );
    level flag::set( "foundry_junkyard_enemies_retreat" );
}

// Namespace newworld_factory
// Params 1
// Checksum 0xfb9f6cf4, Offset: 0x9010
// Size: 0x112
function function_328f9079( a_ents )
{
    var_46700fc3 = getnodearray( "foundry_retreat_vignette_nodes", "targetname" );
    
    foreach ( ai in a_ents )
    {
        if ( isalive( ai ) )
        {
            nd_goal = array::random( var_46700fc3 );
            arrayremovevalue( var_46700fc3, nd_goal );
            ai thread function_ff59cf8( nd_goal );
        }
    }
}

// Namespace newworld_factory
// Params 1
// Checksum 0x1bec4e27, Offset: 0x9130
// Size: 0x6c
function function_ff59cf8( nd_goal )
{
    self endon( #"death" );
    self setgoal( nd_goal, 1 );
    self waittill( #"goal" );
    self ai::set_ignoreall( 0 );
    self ai::set_ignoreme( 0 );
}

// Namespace newworld_factory
// Params 1
// Checksum 0x52bb45e1, Offset: 0x91a8
// Size: 0xd6
function function_83d084fe( str_targetname )
{
    t_to_check = getent( str_targetname, "targetname" );
    t_to_check endon( #"death" );
    
    while ( true )
    {
        t_to_check waittill( #"trigger", var_4161ad80 );
        
        if ( isplayer( var_4161ad80 ) || isdefined( var_4161ad80.owner ) )
        {
            if ( isdefined( var_4161ad80.owner ) )
            {
                t_to_check trigger::use( undefined, var_4161ad80.owner );
            }
            
            return var_4161ad80;
        }
    }
}

// Namespace newworld_factory
// Params 0
// Checksum 0x38763218, Offset: 0x9288
// Size: 0x90
function function_8df847d()
{
    self endon( #"death" );
    
    while ( true )
    {
        self waittill( #"trigger", var_4161ad80 );
        
        if ( isplayer( var_4161ad80 ) || isdefined( var_4161ad80.owner ) )
        {
            if ( isdefined( var_4161ad80.owner ) )
            {
                self useby( var_4161ad80.owner );
            }
        }
    }
}

// Namespace newworld_factory
// Params 1
// Checksum 0xa275ef3f, Offset: 0x9320
// Size: 0x144
function function_763f6f1c( s_warp_pos )
{
    self endon( #"death" );
    self thread lui::screen_fade_out( 1 );
    level util::delay( 1, undefined, &flag::set, "player_returned_to_body_post_foundry" );
    self freezecontrols( 1 );
    self waittill( #"return_to_body" );
    self waittill( #"transition_done" );
    self setorigin( s_warp_pos.origin );
    self setplayerangles( s_warp_pos.angles );
    self setstance( "stand" );
    util::wait_network_frame();
    self lui::screen_fade_in( 0.5 );
    self freezecontrols( 0 );
}

// Namespace newworld_factory
// Params 0
// Checksum 0xe70dac0c, Offset: 0x9470
// Size: 0x5bc
function foundry_heavy_door_and_generator()
{
    level thread function_9729c7a4();
    generator_damage_watch();
    level notify( #"foundry_generator_destroyed" );
    level flag::set( "foundry_objective_complete" );
    level.ai_diaz sethighdetail( 1 );
    wait 2;
    
    foreach ( e_player in level.activeplayers )
    {
        if ( isdefined( e_player.hijacked_vehicle_entity ) )
        {
            var_9f7fd4a1 = e_player.hijacked_vehicle_entity;
            var_9f7fd4a1.overridevehicledamage = undefined;
            var_9f7fd4a1 clientfield::set( "emp_vehicles_fx", 1 );
            var_9f7fd4a1 util::delay( 8, undefined, &clientfield::set, "emp_vehicles_fx", 0 );
            var_9f7fd4a1 vehicle::god_off();
            var_9f7fd4a1 dodamage( var_9f7fd4a1.health + 100, var_9f7fd4a1.origin );
            
            if ( var_9f7fd4a1.archetype == "wasp" )
            {
                var_9f7fd4a1 playsound( "gdt_cybercore_wasp_shutdown" );
            }
            
            if ( var_9f7fd4a1.archetype == "amws" )
            {
                var_9f7fd4a1 playsound( "gdt_cybercore_amws_shutdown" );
            }
            
            a_s_warp_pos = struct::get_array( "post_hijack_player_warpto" );
            s_pos = array::pop_front( a_s_warp_pos );
            e_player thread function_763f6f1c( s_pos );
        }
    }
    
    level thread function_29537dff();
    
    foreach ( veh in level.a_vh_hijack )
    {
        if ( isdefined( veh ) )
        {
            objectives::complete( "cp_level_newworld_factory_hijack", veh.var_1ab87762 );
            veh.var_d3f57f67 = 1;
            veh clientfield::set( "emp_vehicles_fx", 1 );
            veh util::delay( 8, undefined, &clientfield::set, "emp_vehicles_fx", 0 );
        }
    }
    
    a_flags = array( "player_returned_to_body_post_foundry", "player_moving_to_vat_room" );
    level flag::wait_till_any_timeout( 10, a_flags );
    battlechatter::function_d9f49fba( 0 );
    array::thread_all( getaiteamarray( "axis" ), &newworld_util::function_95132241 );
    level scene::stop( "cin_new_03_02_factoryraid_vign_explaindrones_open_door" );
    level.ai_diaz thread actor_camo( 0 );
    level.ai_diaz ai::set_behavior_attribute( "sprint", 0 );
    level.ai_diaz ai::set_behavior_attribute( "cqb", 1 );
    level thread scene::play( "cin_new_03_03_factoryraid_vign_pry_open" );
    e_clip = getent( "warehouse_door_clip", "targetname" );
    e_clip delete();
    umbragate_set( "umbra_gate_factory_door_01", 1 );
    var_cecf22e2 = getent( "ug_factory_hideme", "targetname" );
    var_cecf22e2 hide();
    level.ai_diaz sethighdetail( 0 );
    level thread function_777a44b6();
}

// Namespace newworld_factory
// Params 0
// Checksum 0x5a095022, Offset: 0x9a38
// Size: 0x3c
function function_777a44b6()
{
    wait 2;
    trigger::use( "vat_room_color_trigger_start" );
    level thread function_5dfc077c();
}

// Namespace newworld_factory
// Params 0
// Checksum 0xd4c37b66, Offset: 0x9a80
// Size: 0x414
function generator_damage_watch()
{
    level flag::init( "player_destroyed_foundry" );
    objectives::set( "cp_level_newworld_foundry_subobj_destroy_generator", struct::get( "foundry_generator_objective_struct", "targetname" ) );
    n_damage = 0;
    e_generator = getent( "foundry_generator", "targetname" );
    var_1066b4e5 = getent( "foundry_generator_dmg", "targetname" );
    e_generator clientfield::set( "weakpoint", 1 );
    e_generator globallogic_ui::createweakpointwidget( &"tag_weakpoint", 2600, 5000 );
    e_generator setcandamage( 1 );
    
    while ( n_damage < 1000 )
    {
        e_generator waittill( #"damage", idamage, sattacker, vdirection, vpoint, stype, smodelname, sattachtag, stagname );
        
        if ( isplayer( sattacker ) )
        {
            if ( stype === "MOD_PROJECTILE_SPLASH" )
            {
                idamage *= 2;
            }
            
            n_damage += idamage;
        }
    }
    
    e_generator clientfield::set( "weakpoint", 0 );
    e_generator globallogic_ui::destroyweakpointwidget( &"tag_weakpoint" );
    e_generator setcandamage( 0 );
    radiusdamage( e_generator.origin, 500, 200, 60, undefined, "MOD_EXPLOSIVE" );
    playrumbleonposition( "cp_newworld_rumble_factory_generator_destroyed", e_generator.origin );
    e_generator playsound( "evt_generator_explo" );
    e_generator clientfield::set( "emp_generator_fx", 1 );
    var_1066b4e5 show();
    e_generator ghost();
    scene::add_scene_func( "p7_fxanim_cp_newworld_generator_debris_bundle", &function_11114c92, "play" );
    level thread scene::play( "p7_fxanim_cp_newworld_generator_debris_bundle" );
    objectives::complete( "cp_level_newworld_foundry_subobj_destroy_generator", struct::get( "foundry_generator_objective_struct", "targetname" ) );
    level flag::set( "player_destroyed_foundry" );
    level thread function_9641f186();
    savegame::checkpoint_save();
}

// Namespace newworld_factory
// Params 0
// Checksum 0xf73f2132, Offset: 0x9ea0
// Size: 0x54
function function_3a211205()
{
    scene::add_scene_func( "p7_fxanim_cp_newworld_generator_debris_bundle", &function_cd6bcaad, "init" );
    level thread scene::init( "p7_fxanim_cp_newworld_generator_debris_bundle" );
}

// Namespace newworld_factory
// Params 1
// Checksum 0x686423f8, Offset: 0x9f00
// Size: 0x2c
function function_cd6bcaad( a_ents )
{
    a_ents[ "newworld_generator_debris" ] hide();
}

// Namespace newworld_factory
// Params 1
// Checksum 0xadc21e6f, Offset: 0x9f38
// Size: 0x2c
function function_11114c92( a_ents )
{
    a_ents[ "newworld_generator_debris" ] show();
}

// Namespace newworld_factory
// Params 0
// Checksum 0xb00d9ef2, Offset: 0x9f70
// Size: 0xdc
function function_29537dff()
{
    umbragate_set( "umbra_gate_foundry_door_01", 1 );
    var_cecf22e2 = getent( "ug_foundry_hideme", "targetname" );
    var_cecf22e2 hide();
    e_door_right = getent( "foundry_exit_door_right", "targetname" );
    e_door_right rotateyaw( -55, 3, 1.5, 0.5 );
}

// Namespace newworld_factory
// Params 0
// Checksum 0xfeecd259, Offset: 0xa058
// Size: 0x18c
function function_3fd07e2f()
{
    function_83d084fe( "foundry_entered" );
    spawn_manager::enable( "sm_foundry_far_side_bottom" );
    function_83d084fe( "foundry_area_1_moveup" );
    spawn_manager::enable( "sm_foundry_far_side_balcony" );
    function_83d084fe( "foundry_area_2_moveup" );
    spawn_manager::enable( "sm_foundry_fxanim_catwalk" );
    spawn_manager::enable( "sm_foundry_middle" );
    function_83d084fe( "foundry_area_3_moveup" );
    spawn_manager::enable( "sm_foundry_back_corner" );
    level thread function_ff771cc8( "foundry_spawn_01", "foundry_end_reinforcements_1" );
    function_83d084fe( "foundry_area_4_moveup" );
    spawn_manager::enable( "sm_foundry_generator" );
    level thread function_ff771cc8( "foundry_spawn_02", "foundry_end_reinforcements_2" );
    level thread function_ff771cc8( "foundry_spawn_03", "foundry_end_reinforcements_3", 1.5 );
}

// Namespace newworld_factory
// Params 3
// Checksum 0x78cd933d, Offset: 0xa1f0
// Size: 0xac
function function_ff771cc8( str_door, str_spawn_manager, n_delay )
{
    if ( isdefined( n_delay ) )
    {
        wait n_delay;
    }
    
    mdl_door = getent( str_door, "targetname" );
    mdl_door movez( 98, 1 );
    mdl_door waittill( #"movedone" );
    spawn_manager::enable( str_spawn_manager );
}

// Namespace newworld_factory
// Params 0
// Checksum 0x8c181e4, Offset: 0xa2a8
// Size: 0x1ac
function vat_room()
{
    var_e0da8e0f = getent( "vat_room_exit_door_trigger", "targetname" );
    var_e0da8e0f triggerenable( 0 );
    
    if ( isdefined( level.bzm_newworlddialogue2_4callback ) )
    {
        level thread [[ level.bzm_newworlddialogue2_4callback ]]();
    }
    
    setup_destroyable_conveyor_belt_vats( "vat_room" );
    level thread function_b56ffd69();
    level thread vat_room_hijack_tutorial();
    level thread function_1ad208();
    level thread function_b83baf6f( "take_out_turret_1", "vat_turret_1" );
    level thread function_b83baf6f( "take_out_turret_2", "vat_turret_2" );
    level thread function_fc0bd7c9();
    objectives::breadcrumb( "vat_room_breadcrumb" );
    spawner::waittill_ai_group_cleared( "vat_room_enemy" );
    
    if ( !sessionmodeiscampaignzombiesgame() )
    {
        spawner::waittill_ai_group_cleared( "vat_room_turret" );
    }
    
    level notify( #"hash_3bfba96f" );
    level thread namespace_e38c3c58::function_d942ea3b();
}

// Namespace newworld_factory
// Params 0
// Checksum 0x78238eb9, Offset: 0xa460
// Size: 0x3c
function function_fc0bd7c9()
{
    spawner::waittill_ai_group_count( "vat_room_enemy", 2 );
    trigger::use( "vat_room_clean_up_diaz" );
}

// Namespace newworld_factory
// Params 2
// Checksum 0xd71d38a9, Offset: 0xa4a8
// Size: 0xcc
function function_b83baf6f( str_trigger, str_turret )
{
    trigger::wait_till( str_trigger );
    var_c316ad54 = getent( str_turret, "script_noteworthy", 1 );
    
    if ( isalive( var_c316ad54 ) )
    {
        level.ai_diaz ai::shoot_at_target( "normal", var_c316ad54, "tag_barrel_animate", 3 );
        
        if ( isalive( var_c316ad54 ) )
        {
            var_c316ad54 kill();
        }
    }
}

// Namespace newworld_factory
// Params 0
// Checksum 0xf7f32c3f, Offset: 0xa580
// Size: 0x202
function function_1ad208()
{
    trigger::wait_till( "vat_room_start_enemies" );
    savegame::checkpoint_save();
    level thread vat_room_auto_turrets();
    spawn_manager::enable( "sm_vat_room_enemies" );
    level thread function_dda86f5a();
    trigger::wait_till( "vat_room_second_wave" );
    spawn_manager::enable( "sm_vat_room_final_suppressors" );
    trigger::wait_till( "vat_room_spawn_closet" );
    level thread function_f2c01307();
    level thread function_d9482ef9();
    var_9b15e92e = getent( "gv_vat_room_back", "targetname" );
    
    foreach ( ai in spawner::get_ai_group_ai( "vat_room_enemy" ) )
    {
        if ( isalive( ai ) )
        {
            ai setgoal( var_9b15e92e );
            wait randomfloatrange( 0.5, 2 );
        }
    }
}

// Namespace newworld_factory
// Params 0
// Checksum 0x9c45ce0f, Offset: 0xa790
// Size: 0x7c
function function_dda86f5a()
{
    wait 3;
    spawner::waittill_ai_group_ai_count( "vat_room_enemy", 3 );
    trigger::use( "vat_room_second_wave" );
    wait 3;
    spawner::waittill_ai_group_ai_count( "vat_room_enemy", 3 );
    trigger::use( "vat_room_spawn_closet" );
}

// Namespace newworld_factory
// Params 0
// Checksum 0x40836978, Offset: 0xa818
// Size: 0x54
function function_b56ffd69()
{
    trigger::wait_till( "factory_vat_room_ammo_vo" );
    level.ai_diaz dialog::say( "diaz_grab_fresh_ammo_when_0" );
    objectives::set( "cp_level_newworld_vat_room_subobj_locate_command_ctr" );
}

// Namespace newworld_factory
// Params 0
// Checksum 0x99792df2, Offset: 0xa878
// Size: 0x2ac
function function_f2c01307()
{
    e_door = getent( "vat_room_spawn_door", "targetname" );
    e_door movez( 136, 2, 0.5, 0.3 );
    e_door waittill( #"movedone" );
    spawn_manager::enable( "sm_vat_room_closet" );
    spawn_manager::wait_till_complete( "sm_vat_room_closet" );
    var_13cfcc3e = getent( "gv_vat_room_spawn_closet", "targetname" );
    var_13cfcc3e endon( #"death" );
    b_clear = 0;
    
    while ( !b_clear )
    {
        b_clear = 1;
        
        foreach ( ai in spawner::get_ai_group_ai( "vat_room_enemy" ) )
        {
            if ( ai.script_noteworthy === "vat_spawn_closet" && ai istouching( var_13cfcc3e ) )
            {
                b_clear = 0;
            }
        }
        
        foreach ( e_player in level.activeplayers )
        {
            if ( e_player istouching( var_13cfcc3e ) )
            {
                b_clear = 0;
            }
        }
        
        wait 0.05;
    }
    
    e_door movez( 136 * -1, 2, 0.5, 0.3 );
}

// Namespace newworld_factory
// Params 0
// Checksum 0x713ec8b7, Offset: 0xab30
// Size: 0x134
function vat_room_hijack_tutorial()
{
    if ( sessionmodeiscampaignzombiesgame() )
    {
        return;
    }
    
    foreach ( player in level.players )
    {
        player thread function_5e3e5d06();
    }
    
    util::wait_network_frame();
    callback::on_connect( &function_5e3e5d06 );
    trigger::wait_till( "vat_room_hijack_tutorial" );
    battlechatter::function_d9f49fba( 1 );
    level thread function_451d7f3e();
    level thread function_8b7ac3d();
}

// Namespace newworld_factory
// Params 0
// Checksum 0x2e08af6e, Offset: 0xac70
// Size: 0xc8
function function_5e3e5d06()
{
    self endon( #"death" );
    level endon( #"vat_room_turrets_all_dead" );
    self flag::init( "vat_room_turret_hijacked" );
    
    if ( sessionmodeiscampaignzombiesgame() )
    {
        self flag::set( "vat_room_turret_hijacked" );
        return;
    }
    
    while ( true )
    {
        self waittill( #"clonedentity", e_clone );
        
        if ( e_clone.targetname === "vat_room_auto_turret_ai" )
        {
            self flag::set( "vat_room_turret_hijacked" );
        }
    }
}

// Namespace newworld_factory
// Params 0
// Checksum 0x11a06ad, Offset: 0xad40
// Size: 0x30
function function_10195ade()
{
    if ( spawner::get_ai_group_ai( "vat_room_turret" ) > 0 )
    {
        return 1;
    }
    
    return 0;
}

// Namespace newworld_factory
// Params 0
// Checksum 0xf853d900, Offset: 0xad78
// Size: 0x16a
function function_13458178()
{
    self endon( #"death" );
    level endon( #"vat_room_turrets_all_dead" );
    
    if ( isdefined( 30 ) )
    {
        __s = spawnstruct();
        __s endon( #"timeout" );
        __s util::delay_notify( 30, "timeout" );
    }
    
    while ( !self flag::get( "vat_room_turret_hijacked" ) )
    {
        if ( function_10195ade() && !self laststand::player_is_in_laststand() )
        {
            self thread util::show_hint_text( &"CP_MI_ZURICH_NEWWORLD_REMOTE_HIJACK_TUTORIAL", 0, undefined, 4 );
            self flag::wait_till_timeout( 4, "vat_room_turret_hijacked" );
            self thread util::hide_hint_text( 1 );
            
            if ( !self flag::get( "vat_room_turret_hijacked" ) )
            {
                self flag::wait_till_timeout( 3, "vat_room_turret_hijacked" );
            }
            
            continue;
        }
        
        wait 10;
    }
}

// Namespace newworld_factory
// Params 0
// Checksum 0xe032a98e, Offset: 0xaef0
// Size: 0x11c
function vat_room_auto_turrets()
{
    level flag::init( "vat_room_turrets_all_dead" );
    
    if ( !sessionmodeiscampaignzombiesgame() )
    {
        spawner::simple_spawn( "vat_room_auto_turret" );
        
        foreach ( e_turret in spawner::get_ai_group_ai( "vat_room_turret" ) )
        {
            e_turret.accuracy_turret = 0.25;
        }
        
        spawner::waittill_ai_group_cleared( "vat_room_turret" );
    }
    
    level flag::set( "vat_room_turrets_all_dead" );
}

// Namespace newworld_factory
// Params 2
// Checksum 0xfb73b9e9, Offset: 0xb018
// Size: 0x224
function skipto_inside_man_igc_init( str_objective, b_starting )
{
    level thread scene::init( "cin_new_04_01_insideman_1st_hack_sh010" );
    
    if ( b_starting )
    {
        load::function_73adcefc();
        level.var_b7a27741 = 1;
        common_startup_tasks( str_objective );
        objectives::complete( "cp_level_newworld_factory_subobj_goto_hideout" );
        objectives::complete( "cp_level_newworld_factory_subobj_hijack_drone" );
        objectives::complete( "cp_level_newworld_foundry_subobj_destroy_generator" );
        level thread function_d9482ef9();
        umbragate_set( "umbra_gate_vat_room_door_01", 0 );
        load::function_a2995f22();
        level thread namespace_e38c3c58::function_d942ea3b();
    }
    
    objectives::complete( "cp_level_newworld_vat_room_subobj_locate_command_ctr" );
    trigger::use( "vat_room_hack_door_color_trigger" );
    hidemiscmodels( "charging_station_glass_doors" );
    hidemiscmodels( "charging_station_robot" );
    e_player = function_61a9d0c7();
    level notify( #"hash_ecac2aac" );
    var_cecf22e2 = getent( "ug_vat_room_hide_me", "targetname" );
    var_cecf22e2 hide();
    umbragate_set( "umbra_gate_vat_room_door_01", 1 );
    inside_man_igc( e_player );
    skipto::objective_completed( str_objective );
}

// Namespace newworld_factory
// Params 4
// Checksum 0xd09a4199, Offset: 0xb248
// Size: 0x4c
function skipto_inside_man_igc_done( str_objective, b_starting, b_direct, player )
{
    objectives::set( "cp_level_newworld_rooftop_chase" );
    function_6ca75594();
}

// Namespace newworld_factory
// Params 0
// Checksum 0xd6a56bd4, Offset: 0xb2a0
// Size: 0x54c
function function_6ca75594()
{
    newworld_util::scene_cleanup( "cin_new_02_01_pallasintro_vign_appear" );
    newworld_util::scene_cleanup( "cin_new_02_01_pallasintro_vign_appear_player" );
    newworld_util::scene_cleanup( "cin_new_03_01_factoryraid_aie_break_glass" );
    newworld_util::scene_cleanup( "p7_fxanim_cp_newworld_alley_pipes_bundle" );
    newworld_util::scene_cleanup( "cin_new_03_03_factoryraid_vign_wallrunright_diaz" );
    newworld_util::scene_cleanup( "cin_new_03_03_factoryraid_vign_wallrunright_diaz_pt2" );
    newworld_util::scene_cleanup( "cin_new_03_01_factoryraid_vign_wallrun_attack_attack" );
    newworld_util::scene_cleanup( "cin_new_03_01_factoryraid_vign_wallrun_attack_landing" );
    newworld_util::scene_cleanup( "cin_new_03_03_factoryraid_vign_startup_flee" );
    newworld_util::scene_cleanup( "cin_new_03_03_factoryraid_vign_startup" );
    newworld_util::scene_cleanup( "cin_new_03_02_factoryraid_vign_explaindrones" );
    newworld_util::scene_cleanup( "cin_new_03_02_factoryraid_vign_explaindrones_open_door" );
    newworld_util::scene_cleanup( "cin_new_03_03_factoryraid_vign_junkyard" );
    newworld_util::scene_cleanup( "cin_new_03_03_factoryraid_vign_pry_open" );
    wait 3;
    newworld_util::scene_cleanup( "cin_new_04_01_insideman_1st_hack_sh010" );
    newworld_util::scene_cleanup( "cin_new_04_01_insideman_1st_hack_sh020" );
    newworld_util::scene_cleanup( "cin_new_04_01_insideman_1st_hack_sh030" );
    newworld_util::scene_cleanup( "cin_new_04_01_insideman_1st_hack_sh040" );
    newworld_util::scene_cleanup( "cin_new_04_01_insideman_1st_hack_sh050" );
    newworld_util::scene_cleanup( "cin_new_04_01_insideman_1st_hack_sh060" );
    newworld_util::scene_cleanup( "cin_new_04_01_insideman_1st_hack_sh070" );
    newworld_util::scene_cleanup( "cin_new_04_01_insideman_1st_hack_sh080" );
    newworld_util::scene_cleanup( "cin_new_04_01_insideman_1st_hack_sh090" );
    newworld_util::scene_cleanup( "cin_new_04_01_insideman_1st_hack_sh100" );
    newworld_util::scene_cleanup( "cin_new_04_01_insideman_1st_hack_sh110" );
    newworld_util::scene_cleanup( "cin_new_04_01_insideman_1st_hack_sh120" );
    newworld_util::scene_cleanup( "cin_new_04_01_insideman_1st_hack_sh130" );
    newworld_util::scene_cleanup( "cin_new_04_01_insideman_1st_hack_sh140" );
    newworld_util::scene_cleanup( "cin_new_04_01_insideman_1st_hack_sh150" );
    newworld_util::scene_cleanup( "cin_new_04_01_insideman_1st_hack_sh160" );
    newworld_util::scene_cleanup( "cin_new_04_01_insideman_1st_hack_sh170" );
    newworld_util::scene_cleanup( "cin_new_04_01_insideman_1st_hack_sh180" );
    newworld_util::scene_cleanup( "cin_new_04_01_insideman_1st_hack_sh190" );
    newworld_util::scene_cleanup( "cin_new_04_01_insideman_1st_hack_sh200" );
    newworld_util::scene_cleanup( "cin_new_04_01_insideman_1st_hack_sh210" );
    newworld_util::scene_cleanup( "cin_new_04_01_insideman_1st_hack_sh220" );
    newworld_util::scene_cleanup( "cin_new_04_01_insideman_1st_hack_sh230" );
    newworld_util::scene_cleanup( "cin_new_04_01_insideman_1st_hack_sh240" );
    newworld_util::scene_cleanup( "cin_new_04_01_insideman_1st_hack_sh250" );
    newworld_util::scene_cleanup( "cin_new_04_01_insideman_1st_hack_sh260" );
    newworld_util::scene_cleanup( "cin_new_04_01_insideman_1st_hack_sh270" );
    newworld_util::scene_cleanup( "cin_new_04_01_insideman_1st_hack_sh280" );
    newworld_util::scene_cleanup( "cin_new_04_01_insideman_1st_hack_sh290" );
    newworld_util::scene_cleanup( "cin_new_04_01_insideman_1st_hack_sh300" );
    newworld_util::scene_cleanup( "cin_new_04_01_insideman_1st_hack_sh310" );
    newworld_util::scene_cleanup( "cin_new_04_01_insideman_1st_hack_sh320" );
    newworld_util::scene_cleanup( "p7_fxanim_cp_sgen_charging_station_break_02_bundle" );
    newworld_util::scene_cleanup( "cin_sgen_16_01_charging_station_aie_awaken_robot03" );
    newworld_util::scene_cleanup( "cin_sgen_16_01_charging_station_aie_awaken_robot04" );
    newworld_util::scene_cleanup( "p7_fxanim_cp_newworld_cauldron_fall_01_bundle" );
    newworld_util::scene_cleanup( "p7_fxanim_cp_newworld_cauldron_fall_02_bundle" );
    newworld_util::scene_cleanup( "p7_fxanim_cp_newworld_cauldron_bridge_bundle" );
    newworld_util::scene_cleanup( "p7_fxanim_gp_cauldron_hit_s3_bundle" );
    newworld_util::scene_cleanup( "p7_fxanim_cp_newworld_cauldron_fall_s1_01_bundle" );
    newworld_util::scene_cleanup( "p7_fxanim_cp_newworld_cauldron_fall_s1_02_bundle" );
    newworld_util::scene_cleanup( "p7_fxanim_cp_newworld_cauldron_bridge_s1_bundle" );
}

// Namespace newworld_factory
// Params 0
// Checksum 0x97b72205, Offset: 0xb7f8
// Size: 0xb8
function function_61a9d0c7()
{
    battlechatter::function_d9f49fba( 0 );
    level thread function_7fb08868();
    objectives::set( "cp_level_newworld_vat_room_subobj_hack_door" );
    thread newworld_util::function_16dd8c5f( "vat_room_exit_door_trigger", &"cp_level_newworld_access_door", &"CP_MI_ZURICH_NEWWORLD_HACK", "vat_room_door_panel", "vat_room_door_hacked" );
    objectives::complete( "cp_level_newworld_vat_room_subobj_hack_door" );
    level waittill( #"vat_room_door_hacked", e_player );
    return e_player;
}

// Namespace newworld_factory
// Params 1
// Checksum 0xd8347a19, Offset: 0xb8b8
// Size: 0x374
function inside_man_igc( e_player )
{
    if ( isdefined( level.bzm_newworlddialogue3callback ) )
    {
        level thread [[ level.bzm_newworlddialogue3callback ]]();
    }
    
    level thread namespace_e38c3c58::function_57c68b7b();
    scene::add_scene_func( "cin_sgen_16_01_charging_station_aie_awaken_robot03", &function_453c36ed, "play" );
    scene::add_scene_func( "cin_sgen_16_01_charging_station_aie_awaken_robot04", &function_453c36ed, "play" );
    scene::add_scene_func( "cin_new_04_01_insideman_1st_hack_sh010", &function_f25ee153 );
    scene::add_scene_func( "cin_new_04_01_insideman_1st_hack_sh010", &function_d9753c8f );
    scene::add_scene_func( "cin_new_04_01_insideman_1st_hack_sh010", &function_676dcd54 );
    scene::add_scene_func( "cin_new_04_01_insideman_1st_hack_sh010", &function_8d7047bd );
    scene::add_scene_func( "cin_new_04_01_insideman_1st_hack_sh010", &function_1736807e );
    scene::add_scene_func( "cin_new_04_01_insideman_1st_hack_sh010", &function_85526de2 );
    scene::add_scene_func( "cin_new_04_01_insideman_1st_hack_sh320", &function_2cd7e04e );
    scene::add_scene_func( "cin_new_04_01_insideman_1st_hack_sh320", &function_ed4818dc );
    scene::add_scene_func( "cin_new_04_01_insideman_1st_hack_sh300", &function_86e62a41 );
    scene::add_scene_func( "cin_new_04_01_insideman_1st_hack_sh320", &function_1f576299 );
    scene::add_scene_func( "cin_new_04_01_insideman_1st_hack_sh320", &newworld_util::function_43dfaf16, "skip_started" );
    level thread scene::play( "cin_new_04_01_insideman_1st_hack_sh010", e_player );
    wait 1;
    var_f5bb3a9b = getent( "vat_room_exit_door", "targetname" );
    var_f5bb3a9b movez( 98, 1, 0.3, 0.3 );
    var_f5bb3a9b playsound( "evt_insider_door_open" );
    level waittill( #"hash_51eebdcb" );
    util::clear_streamer_hint();
    level.ai_diaz util::unmake_hero( "diaz" );
    level.ai_diaz util::self_delete();
}

// Namespace newworld_factory
// Params 1
// Checksum 0xf5f761e, Offset: 0xbc38
// Size: 0x54
function function_f25ee153( a_ents )
{
    newworld_util::function_2eded728( 1 );
    a_ents[ "player 1" ] waittill( #"hash_c827463" );
    newworld_util::function_2eded728( 0 );
}

// Namespace newworld_factory
// Params 1
// Checksum 0x15431b2, Offset: 0xbc98
// Size: 0x3c
function function_1f576299( a_ents )
{
    wait 0.2;
    
    if ( !scene::is_skipping_in_progress() )
    {
        newworld_util::function_2eded728( 1 );
    }
}

// Namespace newworld_factory
// Params 1
// Checksum 0x547d06b6, Offset: 0xbce0
// Size: 0xe2
function function_d9753c8f( a_ents )
{
    level waittill( #"hash_7c7cfa5" );
    var_7e421bd8 = struct::get_array( "inside_man_robot", "script_noteworthy" );
    
    foreach ( s_scene in var_7e421bd8 )
    {
        if ( s_scene.script_int === 1 )
        {
            s_scene thread scene::play();
        }
    }
}

// Namespace newworld_factory
// Params 0
// Checksum 0x32c6d6f9, Offset: 0xbdd0
// Size: 0xda
function function_676dcd54()
{
    level waittill( #"hash_e6b5302a" );
    var_7e421bd8 = struct::get_array( "inside_man_robot", "script_noteworthy" );
    
    foreach ( s_scene in var_7e421bd8 )
    {
        if ( s_scene.script_int === 2 )
        {
            s_scene thread scene::play();
        }
    }
}

// Namespace newworld_factory
// Params 0
// Checksum 0xbfd7d3eb, Offset: 0xbeb8
// Size: 0xe2
function function_8d7047bd()
{
    level waittill( #"hash_cb7aa93" );
    var_7e421bd8 = struct::get_array( "inside_man_robot", "script_noteworthy" );
    
    foreach ( s_scene in var_7e421bd8 )
    {
        if ( s_scene.script_int === 3 )
        {
            s_scene thread scene::play();
            wait 0.2;
        }
    }
}

// Namespace newworld_factory
// Params 1
// Checksum 0xbfaebb28, Offset: 0xbfa8
// Size: 0x26a
function function_1736807e( a_ents )
{
    level waittill( #"hash_761cb65f" );
    showmiscmodels( "charging_station_glass_doors" );
    showmiscmodels( "charging_station_robot" );
    var_7e421bd8 = struct::get_array( "inside_man_robot", "script_noteworthy" );
    var_7da8df42 = struct::get_array( "inside_man_charging_station", "script_noteworthy" );
    
    foreach ( var_809fd273 in var_7da8df42 )
    {
        var_809fd273 scene::stop( 1 );
    }
    
    foreach ( var_f13cf991 in var_7e421bd8 )
    {
        var_f13cf991 scene::stop( 1 );
    }
    
    a_ai_robots = getentarray( "inside_man_robot_ai", "targetname" );
    
    foreach ( ai in a_ai_robots )
    {
        ai delete();
    }
}

// Namespace newworld_factory
// Params 1
// Checksum 0xd198ad6, Offset: 0xc220
// Size: 0xdc
function function_453c36ed( a_ents )
{
    foreach ( ent in a_ents )
    {
        ai_robot = ent;
        break;
    }
    
    ai_robot waittill( #"breakglass" );
    var_809fd273 = struct::get( self.target, "targetname" );
    var_809fd273 thread scene::play();
}

// Namespace newworld_factory
// Params 1
// Checksum 0xa52d9304, Offset: 0xc308
// Size: 0x8c
function function_85526de2( a_ents )
{
    if ( !scene::is_skipping_in_progress() )
    {
        level thread lui::prime_movie( "cp_newworld_fs_robothallwayflash" );
    }
    
    a_ents[ "player 1" ] waittill( #"hash_d83e5e3a" );
    
    if ( !scene::is_skipping_in_progress() )
    {
        newworld_util::movie_transition( "cp_newworld_fs_robothallwayflash", "fullscreen_additive", 1 );
    }
}

// Namespace newworld_factory
// Params 1
// Checksum 0xafd8879b, Offset: 0xc3a0
// Size: 0xf4
function function_2cd7e04e( a_ents )
{
    level thread newworld_util::function_30ec5bf7();
    a_ents[ "taylor" ] ghost();
    a_ents[ "taylor" ] waittill( #"hash_d7d448a5" );
    a_ents[ "taylor" ] thread newworld_util::function_c949a8ed( 1 );
    a_ents[ "diaz" ] waittill( #"hash_3223f495" );
    a_ents[ "diaz" ] thread newworld_util::function_4943984c();
    a_ents[ "taylor" ] waittill( #"hash_7f12e524" );
    a_ents[ "taylor" ] thread newworld_util::function_4943984c();
}

// Namespace newworld_factory
// Params 1
// Checksum 0x97cf90e2, Offset: 0xc4a0
// Size: 0x44
function function_ed4818dc( a_ents )
{
    a_ents[ "player 1" ] waittill( #"fade_out" );
    level flag::set( "infinite_white_transition" );
}

// Namespace newworld_factory
// Params 1
// Checksum 0x336fd05, Offset: 0xc4f0
// Size: 0x84
function function_86e62a41( a_ents )
{
    if ( !scene::is_skipping_in_progress() )
    {
        level thread lui::prime_movie( "cp_newworld_fs_informant" );
    }
    
    a_ents[ "player 1" ] waittill( #"start_video" );
    
    if ( !scene::is_skipping_in_progress() )
    {
        newworld_util::movie_transition( "cp_newworld_fs_informant", "fullscreen_additive" );
    }
}

// Namespace newworld_factory
// Params 0
// Checksum 0xc8861ba8, Offset: 0xc580
// Size: 0x1f2
function function_d9482ef9()
{
    var_7da8df42 = struct::get_array( "inside_man_charging_station", "script_noteworthy" );
    
    foreach ( s_scene in var_7da8df42 )
    {
        s_scene scene::init();
        util::wait_network_frame();
    }
    
    var_7e421bd8 = struct::get_array( "inside_man_robot", "script_noteworthy" );
    
    foreach ( s_scene in var_7e421bd8 )
    {
        ai_robot = spawner::simple_spawn_single( "inside_man_robot" );
        ai_robot ai::set_ignoreme( 1 );
        ai_robot ai::set_ignoreall( 1 );
        s_scene scene::init( ai_robot );
        s_scene.ai_robot = ai_robot;
        util::wait_network_frame();
    }
}

// Namespace newworld_factory
// Params 1
// Checksum 0x5fdd057e, Offset: 0xc780
// Size: 0x5c
function common_startup_tasks( str_objective )
{
    level.ai_diaz = util::get_hero( "diaz" );
    level.ai_diaz thread newworld_util::function_921d7387();
    skipto::teleport_ai( str_objective );
}

// Namespace newworld_factory
// Params 1
// Checksum 0x31f11b64, Offset: 0xc7e8
// Size: 0x8c
function function_2dbbd9b1( e_goalvolume )
{
    self endon( #"death" );
    
    if ( !isai( self ) || !isalive( self ) )
    {
        return;
    }
    
    wait randomfloatrange( 0, 5 );
    self setgoal( e_goalvolume, 1 );
}

// Namespace newworld_factory
// Params 1
// Checksum 0x6da560f4, Offset: 0xc880
// Size: 0x194
function spawn_hijack_vehicles( b_starting )
{
    if ( !isdefined( b_starting ) )
    {
        b_starting = 0;
    }
    
    level.a_vh_hijack = spawner::simple_spawn( "foundry_hackable_vehicle", &usable_vehicle_spawn_func );
    vehicle::add_hijack_function( "foundry_hackable_vehicle", &function_e0b67a17 );
    
    if ( !b_starting )
    {
        a_amws = [];
        
        foreach ( var_92218239 in level.a_vh_hijack )
        {
            if ( var_92218239.script_noteworthy === "amws_pushed" )
            {
                a_amws[ a_amws.size ] = var_92218239;
            }
        }
        
        level thread function_4fbc759( a_amws );
    }
    
    scene::add_scene_func( "cin_new_03_02_factoryraid_vign_explaindrones", &function_9ea16200, "init" );
    level scene::init( "cin_new_03_02_factoryraid_vign_explaindrones" );
}

// Namespace newworld_factory
// Params 0
// Checksum 0xb7992525, Offset: 0xca20
// Size: 0x3a
function function_e0b67a17()
{
    arrayremovevalue( level.a_vh_hijack, self );
    
    if ( level.a_vh_hijack.size == 0 )
    {
        level notify( #"foundry_all_vehicles_hijacked" );
    }
}

// Namespace newworld_factory
// Params 1
// Checksum 0x5711638d, Offset: 0xca68
// Size: 0x70
function function_9ea16200( a_ents )
{
    vh_wasp = a_ents[ "hijack_diaz_wasp_spawnpoint" ];
    vh_wasp ai::set_ignoreall( 1 );
    vh_wasp ai::set_ignoreme( 1 );
    vh_wasp.team = "allies";
}

// Namespace newworld_factory
// Params 1
// Checksum 0xa80cce12, Offset: 0xcae0
// Size: 0xda
function actor_camo( n_camo_state )
{
    self endon( #"death" );
    self clientfield::set( "diaz_camo_shader", 2 );
    wait 2;
    self clientfield::set( "diaz_camo_shader", n_camo_state );
    
    if ( n_camo_state == 1 )
    {
        self ai::set_ignoreme( 1 );
        self ai::set_ignoreall( 1 );
        return;
    }
    
    self ai::set_ignoreme( 0 );
    self ai::set_ignoreall( 0 );
    self notify( #"actor_camo_off" );
}

// Namespace newworld_factory
// Params 1
// Checksum 0x5d6eb991, Offset: 0xcbc8
// Size: 0xf4
function setup_destroyable_vats( str_location )
{
    level.var_e4124849 = getweapon( "rocket_wasp_launcher_turret_player" );
    level.var_7e8adada = getweapon( "amws_launcher_turret_player" );
    level.var_3e8a5e10 = getweapon( "pamws_launcher_turret_player" );
    a_e_vats = struct::get_array( str_location + "_destroyable_vat", "targetname" );
    array::thread_all( a_e_vats, &function_aef915b2 );
    scene::add_scene_func( "p7_fxanim_cp_newworld_cauldron_bridge_bundle", &function_2aec5af4, "play" );
}

// Namespace newworld_factory
// Params 0
// Checksum 0xdaf21027, Offset: 0xccc8
// Size: 0x43c
function function_aef915b2()
{
    self endon( #"death" );
    
    switch ( self.script_string )
    {
        case "s1_01":
            e_vat = util::spawn_model( "p7_fxanim_cp_newworld_cauldron_fall_01_mod", self.origin, self.angles );
            e_vat.var_f3e8791a = getent( "cauldron_1_hang", "targetname" );
            e_vat.var_8406755b = getent( "cauldron_1_fall", "targetname" );
            e_vat.str_exploder = "fx_interior_cauldron_right";
            e_vat.var_84d67e66 = getent( "fire_hazard_right_cauldron", "targetname" );
            break;
        default:
            e_vat = util::spawn_model( "p7_fxanim_cp_newworld_cauldron_fall_02_mod", self.origin, self.angles );
            e_vat.var_f3e8791a = getent( "cauldron_2_hang", "targetname" );
            e_vat.var_8406755b = getent( "cauldron_2_fall", "targetname" );
            e_vat.str_exploder = "fx_interior_cauldron_left";
            e_vat.var_84d67e66 = getent( "fire_hazard_left_cauldron", "targetname" );
            break;
        case "bridge":
            e_vat = util::spawn_model( "p7_fxanim_cp_newworld_cauldron_bridge_mod", self.origin, self.angles );
            e_vat.var_f3e8791a = getent( "cauldron_bridge_hang", "targetname" );
            e_vat.var_8406755b = getent( "cauldron_bridge_fall", "targetname" );
            e_vat.var_3d0b54ab = getent( "foundry_catwalk_clip", "targetname" );
            e_vat.var_cb14c98c = getent( "foundry_catwalk_ai_clip", "targetname" );
            e_vat.var_84d67e66 = getent( "fire_hazard_bridge", "targetname" );
            a_e_clips = getentarray( "cauldron_bridge_fxanim_clip", "targetname" );
            
            foreach ( e_clip in a_e_clips )
            {
                e_clip notsolid();
            }
            
            break;
    }
    
    e_vat.var_84d67e66 triggerenable( 0 );
    e_vat.target = self.target;
    e_vat.script_string = self.script_string;
    e_vat.script_noteworthy = self.script_noteworthy;
    e_vat.script_objective = self.script_objective;
    e_vat destroyable_vat();
}

// Namespace newworld_factory
// Params 1
// Checksum 0x5474e142, Offset: 0xd110
// Size: 0xca
function setup_destroyable_conveyor_belt_vats( str_location )
{
    var_8fec5fad = struct::get_array( str_location + "_destroyable_conveyor_belt_vat", "targetname" );
    
    foreach ( var_9006610d in var_8fec5fad )
    {
        var_9006610d thread conveyor_belt_vat_spawner( str_location );
    }
}

// Namespace newworld_factory
// Params 1
// Checksum 0xdde7d107, Offset: 0xd1e8
// Size: 0xd0
function conveyor_belt_vat_spawner( str_location )
{
    level endon( #"hash_ecac2aac" );
    
    while ( true )
    {
        wait randomfloatrange( 12, 20 );
        e_vat = util::spawn_model( "p7_fxanim_gp_cauldron_hit_s3_mod", self.origin, self.angles );
        e_vat thread destroyable_vat();
        e_vat thread function_5ccfae48( str_location );
        e_vat thread function_35fa6de( self.target );
    }
}

// Namespace newworld_factory
// Params 1
// Checksum 0xab538caa, Offset: 0xd2c0
// Size: 0x14c
function function_35fa6de( var_b3db89e0 )
{
    e_mover = util::spawn_model( "tag_origin", self.origin, self.angles );
    self linkto( e_mover );
    e_mover playloopsound( "evt_vat_move_loop" );
    s_move_to = struct::get( var_b3db89e0, "targetname" );
    n_move_time = distance( self.origin, s_move_to.origin ) / 80;
    e_mover moveto( s_move_to.origin, n_move_time );
    e_mover waittill( #"movedone" );
    e_mover delete();
    self delete();
}

// Namespace newworld_factory
// Params 0
// Checksum 0x20f03ddb, Offset: 0xd418
// Size: 0x690
function destroyable_vat()
{
    self endon( #"death" );
    self setcandamage( 1 );
    self.health = 10000;
    self.n_hit_count = 0;
    self.n_damage_tracker = 0;
    
    if ( self.script_noteworthy === "static_vat" )
    {
        self.var_af5fda8a = 1;
    }
    else
    {
        self.var_af5fda8a = 0;
    }
    
    self fx::play( "smk_idle_cauldron", undefined, undefined, "stop_static_fx", 1, "fx_spill_middle_jnt" );
    
    while ( true )
    {
        self waittill( #"damage", idamage, sattacker, vdirection, vpoint, type, modelname, tagname, partname, weapon, idflags );
        self.health = 10000;
        
        if ( weapon === level.var_e4124849 || weapon === level.var_7e8adada || weapon === level.var_3e8a5e10 )
        {
            idamage = 350;
        }
        
        self.n_damage_tracker += idamage;
        self.n_hit_count++;
        
        if ( !self.var_af5fda8a )
        {
            self thread reset_damage_after_pause();
        }
        
        if ( self.n_damage_tracker >= 350 )
        {
            if ( self.var_af5fda8a )
            {
                self.b_destroyed = 1;
                self scene::stop();
                self.takedamage = 0;
                
                switch ( self.script_string )
                {
                    case "s1_01":
                        self thread scene::play( "p7_fxanim_cp_newworld_cauldron_fall_01_bundle", self );
                        break;
                    default:
                        self thread scene::play( "p7_fxanim_cp_newworld_cauldron_fall_02_bundle", self );
                        break;
                    case "bridge":
                        level thread function_191c39fc();
                        self thread scene::play( "p7_fxanim_cp_newworld_cauldron_bridge_bundle", self );
                        break;
                }
                
                self notify( #"stop_static_fx" );
                
                if ( isdefined( self.str_exploder ) )
                {
                    util::delay( 1.5, undefined, &exploder::exploder, self.str_exploder );
                }
                
                wait 0.5;
                self thread function_528ae2fd( sattacker );
                self.var_84d67e66 triggerenable( 1 );
                self.var_f3e8791a delete();
                self.var_8406755b movez( 256, 0.05 );
                self.var_8406755b waittill( #"movedone" );
                
                foreach ( ai in getaiteamarray( "axis" ) )
                {
                    if ( ai istouching( self.var_8406755b ) )
                    {
                        ai kill();
                    }
                }
                
                if ( isdefined( self.var_3d0b54ab ) )
                {
                    self.var_cb14c98c movez( 256, 0.05 );
                    self.var_cb14c98c waittill( #"movedone" );
                    
                    foreach ( ai in getaiteamarray( "axis" ) )
                    {
                        if ( ai istouching( self.var_cb14c98c ) )
                        {
                            ai kill();
                        }
                    }
                    
                    self.var_3d0b54ab delete();
                }
            }
            else
            {
                self scene::stop();
                self thread scene::play( "p7_fxanim_gp_cauldron_hit_s3_bundle", self );
                wait 0.5;
                self thread function_528ae2fd( sattacker );
            }
            
            self.n_damage_tracker = 0;
            continue;
        }
        
        if ( self.var_af5fda8a )
        {
            switch ( self.script_string )
            {
                case "s1_01":
                    self thread scene::play( "p7_fxanim_cp_newworld_cauldron_fall_s1_01_bundle", self );
                    break;
                default:
                    self thread scene::play( "p7_fxanim_cp_newworld_cauldron_fall_s1_02_bundle", self );
                    break;
                case "bridge":
                    self thread scene::play( "p7_fxanim_cp_newworld_cauldron_bridge_s1_bundle", self );
                    break;
            }
            
            continue;
        }
        
        self thread scene::play( "p7_fxanim_gp_cauldron_hit_s1_bundle", self );
    }
}

// Namespace newworld_factory
// Params 0
// Checksum 0x10ae10e4, Offset: 0xdab0
// Size: 0x34
function function_191c39fc()
{
    level endon( #"hash_ecac2aac" );
    level waittill( #"hash_bd02d60e" );
    exploder::exploder( "fx_interior_fire_pipeburst" );
}

// Namespace newworld_factory
// Params 1
// Checksum 0x8c499448, Offset: 0xdaf0
// Size: 0x104
function function_528ae2fd( sattacker )
{
    v_trace_start = self gettagorigin( "cables_02_jnt" );
    v_trace_end = v_trace_start - ( 0, 0, 2000 );
    s_trace = bullettrace( v_trace_start, v_trace_end, 0, self );
    t_damage = spawn( "trigger_radius", s_trace[ "position" ], 27, 150, 150 );
    t_damage thread molten_metal_damage_trigger();
    wait 7;
    t_damage delete();
}

// Namespace newworld_factory
// Params 0
// Checksum 0x9ca2f73b, Offset: 0xdc00
// Size: 0x11a
function molten_metal_damage_trigger()
{
    self endon( #"death" );
    
    while ( true )
    {
        self waittill( #"trigger", e_victim );
        
        if ( e_victim.var_6ce47035 === 1 )
        {
            continue;
        }
        
        if ( e_victim util::is_hero() )
        {
            continue;
        }
        
        if ( isvehicle( e_victim ) )
        {
            e_victim dodamage( 10, e_victim.origin, self, self, "none" );
            continue;
        }
        
        if ( isalive( e_victim ) )
        {
            e_victim thread function_9e51be07( 4, 6 );
            e_victim.var_6ce47035 = 1;
            level notify( #"hash_9fbe018c" );
        }
    }
}

// Namespace newworld_factory
// Params 1
// Checksum 0x34eaa54f, Offset: 0xdd28
// Size: 0x160
function function_5ccfae48( str_location )
{
    self endon( #"death" );
    level endon( #"hash_ecac2aac" );
    var_b414ae3d = getentarray( str_location + "_vat_door_trigger", "targetname" );
    
    while ( true )
    {
        foreach ( var_1ecb5e9d in var_b414ae3d )
        {
            if ( self istouching( var_1ecb5e9d ) )
            {
                self clientfield::set( "open_vat_doors", 1 );
                
                while ( self istouching( var_1ecb5e9d ) )
                {
                    wait 0.05;
                }
                
                self clientfield::set( "open_vat_doors", 0 );
            }
        }
        
        wait 0.05;
    }
}

// Namespace newworld_factory
// Params 1
// Checksum 0x9274b6d8, Offset: 0xde90
// Size: 0xd2
function function_2aec5af4( a_ents )
{
    a_ents[ "newworld_cauldron_bridge" ] waittill( #"hash_bc75666f" );
    a_e_clips = getentarray( "cauldron_bridge_fxanim_clip", "targetname" );
    
    foreach ( e_clip in a_e_clips )
    {
        e_clip solid();
    }
}

// Namespace newworld_factory
// Params 2
// Checksum 0xfdb6b9bc, Offset: 0xdf70
// Size: 0x114
function function_9e51be07( min_duration, max_duration )
{
    self endon( #"death" );
    duration = randomfloatrange( min_duration, max_duration );
    wait randomfloatrange( 0.1, 0.75 );
    self clientfield::set( "arch_actor_fire_fx", 1 );
    self thread function_48516b3d();
    self thread function_8823cee2( getweapon( "gadget_firefly_swarm_upgraded" ), duration );
    self util::waittill_any_timeout( duration, "firedeath_time_to_die" );
    self kill( self.origin );
}

// Namespace newworld_factory
// Params 0, eflags: 0x4
// Checksum 0x80e040cc, Offset: 0xe090
// Size: 0x3c
function private function_48516b3d()
{
    self waittill( #"actor_corpse", corpse );
    corpse clientfield::set( "arch_actor_fire_fx", 2 );
}

// Namespace newworld_factory
// Params 2, eflags: 0x4
// Checksum 0xca3b8872, Offset: 0xe0d8
// Size: 0xc2
function private function_8823cee2( weapon, duration )
{
    self endon( #"death" );
    self notify( #"bhtn_action_notify", "scream" );
    endtime = gettime() + duration * 1000;
    
    while ( gettime() < endtime )
    {
        self dodamage( 5, self.origin, undefined, undefined, "none", "MOD_RIFLE_BULLET", 0, weapon, -1, 1 );
        self waittillmatch( #"bhtn_action_terminate", "specialpain" );
    }
    
    self notify( #"firedeath_time_to_die" );
}

// Namespace newworld_factory
// Params 0
// Checksum 0x3e9197a0, Offset: 0xe1a8
// Size: 0x50
function reset_damage_after_pause()
{
    self endon( #"death" );
    n_saved_hit_count = self.n_hit_count;
    wait 0.4;
    
    if ( n_saved_hit_count == self.n_hit_count )
    {
        self.n_damage_tracker = 0;
    }
}

// Namespace newworld_factory
// Params 0
// Checksum 0xad587d9f, Offset: 0xe200
// Size: 0x8c
function usable_vehicle_spawn_func()
{
    self.var_d3f57f67 = 1;
    self.team = "allies";
    self.goalradius = 64;
    self disableaimassist();
    self ai::set_ignoreall( 1 );
    self ai::set_ignoreme( 1 );
    self.overridevehicledamage = &callback_foundry_no_vehicle_damage;
}

// Namespace newworld_factory
// Params 1
// Checksum 0x8e0dcf2c, Offset: 0xe298
// Size: 0x194
function diaz_wasp_spawner( a_ents )
{
    level waittill( #"hash_e8e1b9b8" );
    a_ents[ "hijack_diaz_wasp_spawnpoint" ] vehicle_ai::start_scripted();
    a_ents[ "hijack_diaz_wasp_spawnpoint" ] clientfield::set( "name_diaz_wasp", 1 );
    level waittill( #"hash_b1973b1b" );
    a_ents[ "hijack_diaz_wasp_spawnpoint" ] thread diaz_wasp_controller();
    newworld_util::function_3e37f48b( 1 );
    level thread show_hijacking_hint();
    
    foreach ( vh_drone in level.a_vh_hijack )
    {
        if ( sessionmodeiscampaignzombiesgame() )
        {
            if ( isdefined( vh_drone.archetype ) && vh_drone.archetype == "wasp" )
            {
                continue;
            }
        }
        
        vh_drone.var_d3f57f67 = undefined;
    }
}

// Namespace newworld_factory
// Params 0
// Checksum 0x7f93a692, Offset: 0xe438
// Size: 0x134
function function_738d040b()
{
    level.ai_diaz dialog::say( "diaz_okay_weapons_hot_1" );
    level flag::init( "diaz_factory_exterior_follow_up_vo" );
    t_left = getent( "factory_exterior_left_path_vo", "targetname" );
    t_right = getent( "factory_exterior_right_path_vo", "targetname" );
    var_7d32135d = getent( "factory_exterior_center_path_vo", "targetname" );
    level thread function_e8db2799( t_left, "left" );
    level thread function_e8db2799( t_right, "right" );
    level thread function_e8db2799( var_7d32135d, "center" );
}

// Namespace newworld_factory
// Params 2
// Checksum 0xdbebbf17, Offset: 0xe578
// Size: 0x142
function function_e8db2799( t_vo, str_path )
{
    self endon( #"death" );
    level endon( #"hash_e8db2799" );
    
    while ( true )
    {
        t_vo waittill( #"trigger", ent );
        
        if ( isplayer( ent ) && isalive( ent ) )
        {
            switch ( str_path )
            {
                case "left":
                    ent dialog::player_say( "plyr_taking_left_flank_c_0" );
                    break;
                case "right":
                    ent dialog::player_say( "plyr_moving_right_on_me_0" );
                    break;
                case "center":
                    ent dialog::player_say( "plyr_taking_center_path_0" );
                    break;
                default:
                    break;
            }
            
            break;
        }
    }
    
    level.ai_diaz thread diaz_factory_exterior_follow_up_vo();
    level notify( #"hash_e8db2799" );
}

// Namespace newworld_factory
// Params 0
// Checksum 0x368f93cf, Offset: 0xe6c8
// Size: 0x6c
function diaz_factory_exterior_follow_up_vo()
{
    if ( !level flag::get( "diaz_factory_exterior_follow_up_vo" ) )
    {
        level flag::set( "diaz_factory_exterior_follow_up_vo" );
        self dialog::say( "diaz_there_s_never_just_o_0", 0.5 );
    }
}

// Namespace newworld_factory
// Params 0
// Checksum 0xe2e2a2aa, Offset: 0xe740
// Size: 0x34
function function_a77545da()
{
    self thread function_cd561d8f();
    self thread function_a96367c2();
}

// Namespace newworld_factory
// Params 0
// Checksum 0xf3bb474, Offset: 0xe780
// Size: 0x5c
function function_cd561d8f()
{
    level endon( #"init_wallrun_tutorial" );
    self endon( #"death" );
    self flag::wait_till( "tactical_mode_used" );
    level.ai_diaz dialog::say( "diaz_like_opening_your_ey_0", undefined, undefined, self );
}

// Namespace newworld_factory
// Params 0
// Checksum 0x9b9fa207, Offset: 0xe7e8
// Size: 0x54
function function_a96367c2()
{
    level endon( #"init_wallrun_tutorial" );
    self endon( #"tactical_mode_used" );
    self endon( #"death" );
    wait 15;
    level.ai_diaz dialog::say( "diaz_don_t_got_all_day_n_0", undefined, undefined, self );
}

// Namespace newworld_factory
// Params 0
// Checksum 0xa3e59609, Offset: 0xe848
// Size: 0x4c
function function_af28d0ba()
{
    self thread function_f83d1fd6();
    self thread function_5b31eadc();
    self thread function_d0776ef();
}

// Namespace newworld_factory
// Params 0
// Checksum 0xbfbcfc70, Offset: 0xe8a0
// Size: 0xbc
function function_f83d1fd6()
{
    self endon( #"hash_70797a3a" );
    self endon( #"hash_d67cc85b" );
    level endon( #"hash_3cb382c8" );
    self endon( #"death" );
    wait 30;
    level.ai_diaz dialog::say( "diaz_you_gotta_wall_run_t_0", undefined, undefined, self );
    wait 30;
    level.ai_diaz dialog::say( "diaz_let_s_see_that_wall_0", undefined, undefined, self );
    wait 30;
    level.ai_diaz dialog::say( "diaz_hey_i_ain_t_waiting_0", undefined, undefined, self );
}

// Namespace newworld_factory
// Params 0
// Checksum 0x48ddb1f4, Offset: 0xe968
// Size: 0x84
function function_5b31eadc()
{
    self endon( #"hash_70797a3a" );
    level endon( #"hash_3cb382c8" );
    self endon( #"death" );
    trigger::wait_till( "wallrun_tutorial_fail_VO", "targetname", self );
    self notify( #"hash_d67cc85b" );
    level.ai_diaz dialog::say( "diaz_yeah_i_messed_up_my_0", undefined, undefined, self );
}

// Namespace newworld_factory
// Params 0
// Checksum 0xe8b08c23, Offset: 0xe9f8
// Size: 0x84
function function_d0776ef()
{
    self endon( #"hash_d67cc85b" );
    level endon( #"hash_3cb382c8" );
    self endon( #"death" );
    trigger::wait_till( "wallrun_tutorial_success_vo", "targetname", self );
    self notify( #"hash_70797a3a" );
    level.ai_diaz dialog::say( "diaz_not_bad_newbie_not_0", undefined, undefined, self );
}

// Namespace newworld_factory
// Params 0
// Checksum 0xa62efb51, Offset: 0xea88
// Size: 0x34
function function_70704b5f()
{
    self thread function_a4ef4f4f();
    self thread function_76f95fc();
}

// Namespace newworld_factory
// Params 0
// Checksum 0x3139fca4, Offset: 0xeac8
// Size: 0x54
function function_a4ef4f4f()
{
    self endon( #"player_hijacked_vehicle" );
    level endon( #"foundry_complete" );
    self endon( #"death" );
    wait 15;
    level.ai_diaz dialog::say( "diaz_let_s_get_moving_hi_0", undefined, undefined, self );
}

// Namespace newworld_factory
// Params 0
// Checksum 0x56a30a30, Offset: 0xeb28
// Size: 0x7a
function function_76f95fc()
{
    level endon( #"foundry_complete" );
    level endon( #"hash_c24bd1ea" );
    self endon( #"death" );
    self flag::wait_till( "player_hijacked_vehicle" );
    wait 1;
    level.ai_diaz thread dialog::say( "diaz_fits_like_a_glove_r_0" );
    level notify( #"hash_c24bd1ea" );
}

// Namespace newworld_factory
// Params 0
// Checksum 0x5c525ded, Offset: 0xebb0
// Size: 0x74
function function_4263aa02()
{
    function_83d084fe( "foundry_entered" );
    level.ai_diaz dialog::say( "diaz_you_wanna_see_someth_0" );
    level waittill( #"hash_d3038698" );
    level waittill( #"hash_9fbe018c" );
    level.ai_diaz dialog::say( "diaz_you_re_a_maniac_jok_0" );
}

// Namespace newworld_factory
// Params 0
// Checksum 0xb60ddd60, Offset: 0xec30
// Size: 0x6c
function function_9729c7a4()
{
    if ( !level flag::exists( "player_destroyed_foundry" ) || !level flag::get( "player_destroyed_foundry" ) )
    {
        level.ai_diaz dialog::say( "diaz_there_she_is_blow_t_0" );
    }
}

// Namespace newworld_factory
// Params 0
// Checksum 0xbd68c9b6, Offset: 0xeca8
// Size: 0xcc
function function_9641f186()
{
    wait 1.5;
    
    foreach ( e_player in level.activeplayers )
    {
        if ( isdefined( e_player.hijacked_vehicle_entity ) )
        {
            level.ai_diaz dialog::say( "diaz_i_m_afraid_the_emp_b_0", 1 );
            break;
        }
    }
    
    level thread namespace_e38c3c58::function_973b77f9();
}

// Namespace newworld_factory
// Params 0
// Checksum 0xb9365d69, Offset: 0xed80
// Size: 0x44
function function_5dfc077c()
{
    level.ai_diaz dialog::say( "diaz_c_mon_let_s_go_0", 1.5 );
    level thread namespace_e38c3c58::function_ccafa212();
}

// Namespace newworld_factory
// Params 0
// Checksum 0x70ec9c24, Offset: 0xedd0
// Size: 0x204
function function_451d7f3e()
{
    level endon( #"death" );
    level endon( #"hash_7fb08868" );
    
    if ( sessionmodeiscampaignzombiesgame() )
    {
        return;
    }
    
    level endon( #"hash_3bfba96f" );
    level.ai_diaz dialog::say( "diaz_suppressors_second_0", 1 );
    
    if ( newworld_util::function_70aba08e() )
    {
        level.ai_diaz dialog::say( "diaz_if_you_want_to_get_c_0", 2 );
    }
    
    foreach ( player in level.players )
    {
        if ( player newworld_util::function_c633d8fe() || isdefined( player.hijacked_vehicle_entity ) )
        {
            continue;
        }
        
        if ( !player flag::get( "vat_room_turret_hijacked" ) && !level flag::get( "vat_room_turrets_all_dead" ) )
        {
            player thread newworld_util::function_6062e90( "cybercom_hijack", 0, "vat_room_turrets_all_dead", 1, "CP_MI_ZURICH_NEWWORLD_REMOTE_HIJACK_TURRET_TARGET", "CP_MI_ZURICH_NEWWORLD_REMOTE_HIJACK_TURRET_RELEASE" );
        }
    }
    
    if ( newworld_util::function_70aba08e() )
    {
        level thread function_6199a2b7();
    }
    
    wait 15;
    level.ai_diaz dialog::say( "diaz_use_your_environment_0" );
}

// Namespace newworld_factory
// Params 0
// Checksum 0xb59225e2, Offset: 0xefe0
// Size: 0x4c
function function_8b7ac3d()
{
    self endon( #"death" );
    self endon( #"hash_7fb08868" );
    level waittill( #"hash_76cbcc2f" );
    level.ai_diaz dialog::say( "diaz_your_cyber_abilities_0", 1 );
}

// Namespace newworld_factory
// Params 0
// Checksum 0xb884accd, Offset: 0xf038
// Size: 0x94
function function_6199a2b7()
{
    level endon( #"hash_7fb08868" );
    array::thread_all( level.activeplayers, &function_4ff24fae );
    level waittill( #"hash_16f7f7c4" );
    level.ai_diaz dialog::say( "diaz_nice_going_now_tur_0", 1 );
    level waittill( #"hash_96bdb9d9" );
    level.ai_diaz dialog::say( "diaz_dumb_asses_thought_t_0" );
}

// Namespace newworld_factory
// Params 0
// Checksum 0x93beaba0, Offset: 0xf0d8
// Size: 0x5e
function function_4ff24fae()
{
    level endon( #"hash_7fb08868" );
    self endon( #"death" );
    
    if ( !isdefined( self.hijacked_vehicle_entity ) )
    {
        self waittill( #"clonedentity" );
    }
    
    level notify( #"hash_16f7f7c4" );
    self waittill( #"return_to_body" );
    level notify( #"hash_96bdb9d9" );
}

// Namespace newworld_factory
// Params 0
// Checksum 0x1dd85de7, Offset: 0xf140
// Size: 0x4c
function function_7fb08868()
{
    level notify( #"hash_7fb08868" );
    level.ai_diaz dialog::say( "diaz_the_faction_s_hideou_0" );
    level thread namespace_e38c3c58::function_bb8ce831();
}

