#using scripts/codescripts/struct;
#using scripts/cp/_dialog;
#using scripts/cp/_hazard;
#using scripts/cp/_load;
#using scripts/cp/_skipto;
#using scripts/cp/_util;
#using scripts/cp/cp_mi_cairo_infection_util;
#using scripts/shared/ai_shared;
#using scripts/shared/array_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/hud_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/util_shared;

#namespace underwater;

// Namespace underwater
// Params 0
// Checksum 0xd1aaab9a, Offset: 0x330
// Size: 0x14
function main()
{
    init_clientfields();
}

// Namespace underwater
// Params 0
// Checksum 0x1428528c, Offset: 0x350
// Size: 0x64
function init_clientfields()
{
    clientfield::register( "world", "infection_underwater_debris", 1, 1, "int" );
    clientfield::register( "toplayer", "water_motes", 1, 1, "int" );
}

// Namespace underwater
// Params 2
// Checksum 0xd4f2fe81, Offset: 0x3c0
// Size: 0x204
function underwater_main( str_objective, b_starting )
{
    if ( b_starting )
    {
        load::function_73adcefc();
        level clientfield::set( "cathedral_water_state", 1 );
        level scene::init( "cin_inf_12_01_underwater_1st_fall_underwater02" );
        load::function_a2995f22();
    }
    
    level notify( #"update_billboard" );
    
    foreach ( player in level.activeplayers )
    {
        player thread hazard::function_e9b126ef( 20, 0.9 );
    }
    
    if ( isdefined( level.bzm_infectiondialogue13callback ) )
    {
        level thread [[ level.bzm_infectiondialogue13callback ]]();
    }
    
    level thread handle_underwater_environment();
    
    foreach ( player in level.players )
    {
        player enableinvulnerability();
    }
    
    level thread scene::play( "cin_inf_12_01_underwater_1st_fall_underwater02" );
    playsoundatposition( "evt_underwater_outro", ( 0, 0, 0 ) );
}

// Namespace underwater
// Params 0
// Checksum 0x7af602ae, Offset: 0x5d0
// Size: 0x18c
function handle_underwater_environment()
{
    level thread clientfield::set( "infection_underwater_debris", 1 );
    array::thread_all( level.players, &clientfield::set_to_player, "water_motes", 1 );
    level util::waittill_either( "underwater_scene_fade", "underwater_scene_done" );
    level clientfield::set( "sndIGCsnapshot", 4 );
    array::thread_all( level.activeplayers, &util::set_low_ready, 1 );
    
    if ( scene::is_skipping_in_progress() )
    {
        level thread util::screen_fade_out( 0, "black", "end_level_fade" );
    }
    else
    {
        level thread util::screen_fade_out( 2, "black", "end_level_fade" );
    }
    
    array::thread_all( level.players, &clientfield::set_to_player, "water_motes", 0 );
    level thread skipto::objective_completed( "underwater" );
}

// Namespace underwater
// Params 4
// Checksum 0x6d9c4e40, Offset: 0x768
// Size: 0xea
function underwater_cleanup( str_objective, b_starting, b_direct, player )
{
    level thread clientfield::set( "infection_underwater_debris", 0 );
    level clientfield::set( "cathedral_water_state", 0 );
    
    foreach ( player in level.activeplayers )
    {
        player thread hazard::function_60455f28( "o2" );
    }
}

