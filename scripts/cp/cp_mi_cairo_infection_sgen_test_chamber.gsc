#using scripts/codescripts/struct;
#using scripts/cp/_load;
#using scripts/cp/_skipto;
#using scripts/cp/_spawn_manager;
#using scripts/cp/_util;
#using scripts/cp/cp_mi_cairo_infection_sound;
#using scripts/cp/cp_mi_cairo_infection_util;
#using scripts/shared/array_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/player_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/trigger_shared;
#using scripts/shared/util_shared;
#using scripts/shared/vehicle_ai_shared;
#using scripts/shared/vehicle_shared;

#namespace sgen_test_chamber;

// Namespace sgen_test_chamber
// Params 0
// Checksum 0xc6f15873, Offset: 0x730
// Size: 0x44
function main()
{
    /#
        iprintlnbold( "<dev string:x28>" );
    #/
    
    init_client_field_callback_funcs();
    setup_scenes();
}

// Namespace sgen_test_chamber
// Params 0
// Checksum 0x8efa7230, Offset: 0x780
// Size: 0xf4
function init_client_field_callback_funcs()
{
    clientfield::register( "world", "sgen_test_chamber_pod_graphics", 1, 1, "int" );
    clientfield::register( "world", "sgen_test_chamber_time_lapse", 1, 1, "int" );
    clientfield::register( "scriptmover", "sgen_test_guys_decay", 1, 1, "int" );
    clientfield::register( "world", "fxanim_hive_cluster_break", 1, 1, "int" );
    clientfield::register( "world", "fxanim_time_lapse_objects", 1, 1, "int" );
}

// Namespace sgen_test_chamber
// Params 0
// Checksum 0x88401077, Offset: 0x880
// Size: 0x154
function setup_scenes()
{
    scene::add_scene_func( "cin_inf_04_humanlabdeath_3rd_sh090", &scene_flash_light, "play" );
    scene::add_scene_func( "cin_inf_04_humanlabdeath_3rd_sh140", &scene_humanlabdeath_end, "done" );
    scene::add_scene_func( "cin_inf_05_taylorinfected_3rd_sh010", &scene_taylorinfected_3rd_fade_nt, "play" );
    scene::add_scene_func( "cin_inf_05_taylorinfected_3rd_sh080", &function_6089d98, "done" );
    scene::add_scene_func( "cin_inf_04_02_sarah_vign_01", &scene_sarah_vign_01_fade_nt, "play" );
    scene::add_scene_func( "cin_inf_04_humanlabdeath_3rd_sh140", &function_eabb935c, "play" );
    scene::add_scene_func( "cin_inf_04_humanlabdeath_3rd_sh150", &function_c43d862, "play" );
}

// Namespace sgen_test_chamber
// Params 0
// Checksum 0x80a263a, Offset: 0x9e0
// Size: 0x92
function gas_release_watcher()
{
    foreach ( player in level.players )
    {
        player playrumbleonentity( "damage_heavy" );
    }
}

// Namespace sgen_test_chamber
// Params 1
// Checksum 0xc2defd5d, Offset: 0xa80
// Size: 0x1a
function scene_humanlabdeath_end( a_ent )
{
    level notify( #"humanlabdeath_scene_end" );
}

// Namespace sgen_test_chamber
// Params 1
// Checksum 0x6e8ea94c, Offset: 0xaa8
// Size: 0x24
function function_eabb935c( a_ent )
{
    level util::set_streamer_hint( 6 );
}

// Namespace sgen_test_chamber
// Params 1
// Checksum 0xbd654854, Offset: 0xad8
// Size: 0x64
function function_c43d862( a_ent )
{
    level waittill( #"hash_ee361e18" );
    
    if ( isdefined( a_ent[ "wire" ] ) )
    {
        e_wire = a_ent[ "wire" ];
        e_wire setmodel( "p7_sgen_dni_testing_pod_wires_01_off" );
    }
}

// Namespace sgen_test_chamber
// Params 1
// Checksum 0x62ac1071, Offset: 0xb48
// Size: 0x152
function scene_flash_light( a_ent )
{
    fx_flash_lights = getentarray( "inf_test_chamber_flashlight", "script_noteworthy" );
    
    if ( isdefined( a_ent[ "flashlight" ] ) )
    {
        e_origin = a_ent[ "flashlight" ] gettagorigin( "tag_origin" );
        
        foreach ( fx_flash_light in fx_flash_lights )
        {
            fx_flash_light.origin = a_ent[ "flashlight" ] gettagorigin( "tag_light_position" );
            fx_flash_light linkto( a_ent[ "flashlight" ], "tag_origin" );
        }
    }
}

// Namespace sgen_test_chamber
// Params 0
// Checksum 0x467bd71, Offset: 0xca8
// Size: 0x3c
function function_a29f7cbd()
{
    level scene::init( "cin_inf_04_humanlabdeath_3rd_sh010" );
    level util::set_streamer_hint( 9 );
}

// Namespace sgen_test_chamber
// Params 2
// Checksum 0x6c06b18f, Offset: 0xcf0
// Size: 0x30c
function sgen_test_chamber_init( str_objective, b_starting )
{
    /#
        iprintlnbold( "<dev string:x40>" );
    #/
    
    level clientfield::set( "sgen_test_chamber_pod_graphics", 1 );
    
    if ( b_starting )
    {
        load::function_73adcefc();
        array::thread_all( level.players, &infection_util::player_enter_cinematic );
        function_a29f7cbd();
        level util::streamer_wait();
        load::function_a2995f22();
    }
    
    level thread namespace_eccdd5d1::function_6ef2bfc6();
    level thread util::delay( "start_fade", undefined, &util::screen_fade_in, 2, "white" );
    level thread util::delay( "fx_explosion", undefined, &gas_release_watcher );
    level thread util::delay( "fx_explosion", undefined, &clientfield::set, "fxanim_hive_cluster_break", 0 );
    level clientfield::set( "fxanim_hive_cluster_break", 1 );
    array::thread_all( level.players, &clientfield::increment_to_player, "stop_post_fx", 1 );
    level thread function_7711faaf();
    
    if ( isdefined( level.bzm_infectiondialogue4callback ) )
    {
        level thread [[ level.bzm_infectiondialogue4callback ]]();
    }
    
    level scene::add_scene_func( "cin_inf_04_humanlabdeath_3rd_sh010", &function_e3124fd9, "skip_completed" );
    level scene::add_scene_func( "cin_inf_04_humanlabdeath_3rd_sh020", &function_e3124fd9, "skip_completed" );
    level scene::add_scene_func( "cin_inf_04_humanlabdeath_3rd_sh030", &function_e3124fd9, "skip_completed" );
    level scene::add_scene_func( "cin_inf_04_humanlabdeath_3rd_sh040", &function_e3124fd9, "skip_completed" );
    level thread scene::play( "cin_inf_04_humanlabdeath_3rd_sh010" );
    level waittill( #"humanlabdeath_scene_end" );
    skipto::objective_completed( "sgen_test_chamber" );
}

// Namespace sgen_test_chamber
// Params 1
// Checksum 0x33735771, Offset: 0x1008
// Size: 0x84
function function_e3124fd9( a_ents )
{
    util::screen_fade_out( 0 );
    level util::player_lock_control();
    level util::streamer_wait();
    util::screen_fade_in( 0 );
    level util::player_unlock_control();
}

// Namespace sgen_test_chamber
// Params 0
// Checksum 0x648bac69, Offset: 0x1098
// Size: 0x6c
function function_7711faaf()
{
    videostart( "cp_infection_env_dnimainmonitor", 1 );
    level waittill( #"fx_explosion" );
    videostop( "cp_infection_env_dnimainmonitor" );
    videostart( "cp_infection_env_timelapse_fail", 1 );
}

/#

    // Namespace sgen_test_chamber
    // Params 4
    // Checksum 0xcedeec44, Offset: 0x1110
    // Size: 0x44, Type: dev
    function sgen_test_chamber_done( str_objective, b_starting, b_direct, player )
    {
        iprintlnbold( "<dev string:x57>" );
    }

#/

// Namespace sgen_test_chamber
// Params 2
// Checksum 0x40969d9f, Offset: 0x1160
// Size: 0x144
function time_lapse_init( str_objective, b_starting )
{
    /#
        iprintlnbold( "<dev string:x6e>" );
    #/
    
    if ( !b_starting )
    {
        videostop( "cp_infection_env_timelapse_fail" );
    }
    
    if ( b_starting )
    {
        load::function_73adcefc();
        level util::set_streamer_hint( 9 );
        array::thread_all( level.players, &infection_util::player_enter_cinematic );
        load::function_a2995f22();
    }
    
    videostart( "cp_infection_env_raventimelapse_ravens", 1 );
    level thread time_lapse_anim_test();
    level thread fx_anim_time_lapse();
    level waittill( #"scene_time_lapse_end" );
    level thread util::clear_streamer_hint();
    skipto::objective_completed( "time_lapse" );
}

// Namespace sgen_test_chamber
// Params 0
// Checksum 0xc5d161f, Offset: 0x12b0
// Size: 0xb4
function time_lapse_anim_test()
{
    scene::add_scene_func( "cin_inf_04_humanlabdeath_3rd_sh150", &scene_decayedman_skin_shader, "play" );
    scene::add_scene_func( "cin_inf_04_humanlabdeath_3rd_sh150", &scene_time_lapse_end, "done" );
    level thread scene::play( "cin_inf_04_humanlabdeath_3rd_sh150" );
    level waittill( #"hash_c6e56c65" );
    wait 1;
    clientfield::set( "sgen_test_chamber_time_lapse", 1 );
}

// Namespace sgen_test_chamber
// Params 1
// Checksum 0x7f6003f4, Offset: 0x1370
// Size: 0x9c
function scene_decayedman_skin_shader( a_ents )
{
    /#
        iprintlnbold( "<dev string:x7e>" );
    #/
    
    level thread function_a2b1036();
    cin_guy = a_ents[ "decayedman" ];
    cin_guy thread start_decayman_decay();
    level waittill( #"time_lapse_cut_to_white" );
    util::screen_fade_out( 0, "white" );
}

// Namespace sgen_test_chamber
// Params 0
// Checksum 0x60d6e322, Offset: 0x1418
// Size: 0x164
function start_decayman_decay()
{
    level endon( #"scene_time_lapse_end" );
    self waittill( #"startdecay" );
    level notify( #"hash_c6e56c65" );
    wait 1;
    self setmodel( "c_spc_decayman_stage1_tout_fb" );
    self clientfield::set( "sgen_test_guys_decay", 1 );
    wait 1;
    self setmodel( "c_spc_decayman_stage2_tin_fb" );
    wait 1;
    self setmodel( "c_spc_decayman_stage2_fb" );
    wait 1;
    self setmodel( "c_spc_decayman_stage2_tout_fb" );
    wait 1;
    self setmodel( "c_spc_decayman_stage3_tin_fb" );
    wait 1;
    self setmodel( "c_spc_decayman_stage3_fb" );
    wait 1.5;
    self setmodel( "c_spc_decayman_stage4_fb" );
}

// Namespace sgen_test_chamber
// Params 1
// Checksum 0x524a45b8, Offset: 0x1588
// Size: 0x2c
function scene_time_lapse_end( a_ents )
{
    level notify( #"scene_time_lapse_end" );
    level thread util::clear_streamer_hint();
}

// Namespace sgen_test_chamber
// Params 0
// Checksum 0x566af97b, Offset: 0x15c0
// Size: 0x24
function fx_anim_time_lapse()
{
    level thread clientfield::set( "fxanim_time_lapse_objects", 1 );
}

// Namespace sgen_test_chamber
// Params 4
// Checksum 0xac2137d9, Offset: 0x15f0
// Size: 0x5c
function time_lapse_done( str_objective, b_starting, b_direct, player )
{
    /#
        iprintlnbold( "<dev string:x8b>" );
    #/
    
    videostop( "cp_infection_env_raventimelapse_ravens" );
}

// Namespace sgen_test_chamber
// Params 0
// Checksum 0xf82f6bb1, Offset: 0x1658
// Size: 0x24
function function_a2b1036()
{
    level scene::init( "cin_inf_04_02_sarah_vign_01" );
}

// Namespace sgen_test_chamber
// Params 2
// Checksum 0x6672dc28, Offset: 0x1688
// Size: 0x22c
function cyber_soliders_invest_init( str_objective, b_starting )
{
    /#
        iprintlnbold( "<dev string:x9b>" );
    #/
    
    level util::set_streamer_hint( 3 );
    videostart( "cp_infection_env_timelapse_fail", 1 );
    
    if ( b_starting )
    {
        util::screen_fade_out( 0, "white" );
        array::thread_all( level.players, &infection_util::player_enter_cinematic );
    }
    
    level thread util::screen_fade_in( 1.5, "white" );
    
    if ( isdefined( level.bzm_infectiondialogue21callback ) )
    {
        level thread [[ level.bzm_infectiondialogue21callback ]]();
    }
    
    level scene::play( "cin_inf_04_02_sarah_vign_01" );
    
    if ( isdefined( level.bzm_infectiondialogue5callback ) )
    {
        level thread [[ level.bzm_infectiondialogue5callback ]]();
    }
    
    level thread namespace_eccdd5d1::function_e0a3aca4();
    level thread scene::play( "cin_inf_05_taylorinfected_3rd_sh010" );
    level waittill( #"taylorinfected_sh80_end" );
    
    if ( scene::is_skipping_in_progress() )
    {
        util::screen_fade_out( 0, "black", "end_level_fade" );
    }
    else
    {
        util::screen_fade_out( 1, "black", "end_level_fade" );
        level clientfield::set( "sndIGCsnapshot", 4 );
    }
    
    level thread util::clear_streamer_hint();
    skipto::objective_completed( "cyber_soliders_invest" );
}

// Namespace sgen_test_chamber
// Params 4
// Checksum 0x129b07d4, Offset: 0x18c0
// Size: 0x5c
function cyber_soliders_invest_done( str_objective, b_starting, b_direct, player )
{
    /#
        iprintlnbold( "<dev string:xb6>" );
    #/
    
    videostop( "cp_infection_env_timelapse_fail" );
}

// Namespace sgen_test_chamber
// Params 1
// Checksum 0x334b82c8, Offset: 0x1928
// Size: 0x6c
function scene_sarah_vign_01_fade_nt( a_ent )
{
    level scene::init( "cin_inf_05_taylorinfected_3rd_sh010" );
    level waittill( #"sarah_vign_start_fade" );
    
    if ( !scene::is_skipping_in_progress() )
    {
        util::screen_fade_out( 1, "white" );
    }
}

// Namespace sgen_test_chamber
// Params 1
// Checksum 0x30243166, Offset: 0x19a0
// Size: 0x6c
function scene_taylorinfected_3rd_fade_nt( a_ent )
{
    if ( !scene::is_skipping_in_progress() )
    {
        level clientfield::set( "set_exposure_bank", 3 );
        level waittill( #"taylorinfected_start_fade" );
        level thread util::screen_fade_in( 1.5, "white" );
    }
}

// Namespace sgen_test_chamber
// Params 1
// Checksum 0xc5d7b982, Offset: 0x1a18
// Size: 0x3c
function function_6089d98( a_ent )
{
    if ( !scene::is_skipping_in_progress() )
    {
        level clientfield::set( "set_exposure_bank", 1 );
    }
}

