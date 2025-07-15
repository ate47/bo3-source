#using scripts/codescripts/struct;
#using scripts/cp/_dialog;
#using scripts/cp/_hazard;
#using scripts/cp/_load;
#using scripts/cp/_objectives;
#using scripts/cp/_skipto;
#using scripts/cp/_spawn_manager;
#using scripts/cp/_util;
#using scripts/cp/cp_mi_sing_sgen;
#using scripts/cp/cp_mi_sing_sgen_flood;
#using scripts/cp/cp_mi_sing_sgen_util;
#using scripts/shared/ai_shared;
#using scripts/shared/array_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/colors_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/trigger_shared;
#using scripts/shared/util_shared;

#namespace cp_mi_sing_sgen_uw_battle;

// Namespace cp_mi_sing_sgen_uw_battle
// Params 2
// Checksum 0xf95c4d8a, Offset: 0x570
// Size: 0x2c4
function skipto_underwater_init( str_objective, b_starting )
{
    level clientfield::set( "w_underwater_state", 1 );
    setdvar( "player_swimTime", 5000 );
    t_explosion = getent( "water_ride_explosion_damage", "targetname" );
    t_explosion triggerenable( 0 );
    level util::clientnotify( "tuwc" );
    level thread drowning_54i();
    
    if ( b_starting )
    {
        sgen::init_hendricks( str_objective );
        objectives::set( "cp_level_sgen_escape_sgen" );
    }
    
    level.ai_hendricks ai::set_ignoreme( 1 );
    level scene::init( "cin_sgen_23_01_underwater_battle_vign_swim_hendricks_groundidl" );
    level scene::init( "p7_fxanim_cp_sgen_door_hendricks_explosion_bundle" );
    
    if ( b_starting )
    {
        load::function_a2995f22();
    }
    else
    {
        wait 0.05;
        skipto::teleport( "underwater_battle" );
    }
    
    foreach ( player in level.players )
    {
        player clientfield::set_to_player( "water_motes", 1 );
        player clientfield::set_to_player( "water_teleport", 1 );
        player thread hazard::function_e9b126ef();
    }
    
    spawner::add_global_spawn_function( "axis", &sgen_util::robot_underwater_callback );
    function_dbfa8dae();
    skipto::objective_completed( "underwater_battle" );
}

// Namespace cp_mi_sing_sgen_uw_battle
// Params 4
// Checksum 0xfb8219ce, Offset: 0x840
// Size: 0x24
function skipto_underwater_done( str_objective, b_starting, b_direct, player )
{
    
}

// Namespace cp_mi_sing_sgen_uw_battle
// Params 0
// Checksum 0x59b45a80, Offset: 0x870
// Size: 0x134
function function_dbfa8dae()
{
    level util::clientnotify( "underwater_fan" );
    level util::clientnotify( "tuwc" );
    level thread function_77b723a3();
    level thread scene::play( "cin_sgen_23_01_underwater_battle_vign_swim_hendricks_groundidl" );
    
    while ( !scene::is_ready( "cin_sgen_23_01_underwater_battle_vign_swim_hendricks_groundidl" ) )
    {
        wait 0.1;
    }
    
    level thread cp_mi_sing_sgen_flood::stop_water_teleport_fx();
    spawn_manager::enable( "uw_battle_spawnmanager" );
    level thread function_b980dc78();
    level flag::wait_till( "hendricks_uwb_to_window" );
    level scene::play( "cin_sgen_23_01_underwater_battle_vign_swim_hendricks_traverse_room", level.ai_hendricks );
}

// Namespace cp_mi_sing_sgen_uw_battle
// Params 0
// Checksum 0x5408ce87, Offset: 0x9b0
// Size: 0xd4
function function_b980dc78()
{
    level.ai_hendricks dialog::say( "hend_what_now_kane_0" );
    level dialog::remote( "kane_above_you_marking_y_0", 1 );
    level thread objectives::breadcrumb( "uw_rail_sequence_start" );
    level waittill( #"hendricks_in_position" );
    level dialog::remote( "kane_blow_that_door_wate_0", 0.5 );
    level flag::wait_till( "hendricks_uwb_to_window" );
    level.ai_hendricks dialog::say( "hend_on_me_once_i_blow_t_0" );
}

// Namespace cp_mi_sing_sgen_uw_battle
// Params 0
// Checksum 0x889a9052, Offset: 0xa90
// Size: 0x18c
function drowning_54i()
{
    a_ai = getaiteamarray( "axis", "team3" );
    
    foreach ( ai in a_ai )
    {
        if ( !( isdefined( ai.archetype ) && ai.archetype == "robot" ) )
        {
            ai util::delay( randomfloatrange( 0.05, 0.75 ), "death", &kill );
        }
    }
    
    s_lookat = struct::get( "underwater_battle_drowning_54i_lookat" );
    s_a_scriptbundles = struct::get_array( "underwater_battle_drowning_54i" );
    array::thread_all( s_a_scriptbundles, &scene::play );
}

// Namespace cp_mi_sing_sgen_uw_battle
// Params 0
// Checksum 0x3b6a0997, Offset: 0xc28
// Size: 0x9a
function function_77b723a3()
{
    wait 5;
    
    foreach ( player in level.activeplayers )
    {
        player util::show_hint_text( &"COOP_SWIM_INSTRUCTIONS" );
    }
}

