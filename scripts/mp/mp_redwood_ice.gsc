#using scripts/codescripts/struct;
#using scripts/mp/_load;
#using scripts/mp/_util;
#using scripts/mp/gametypes/_ball_utils;
#using scripts/mp/mp_redwood_ice_fx;
#using scripts/mp/mp_redwood_ice_sound;
#using scripts/shared/_oob;
#using scripts/shared/compass;
#using scripts/shared/util_shared;

#namespace mp_redwood_ice;

// Namespace mp_redwood_ice
// Params 0
// Checksum 0xa4f7b3d0, Offset: 0x208
// Size: 0x37c
function main()
{
    precache();
    level.uav_z_offset = 500;
    level.uav_rotation_radius = 1000;
    level.uav_rotation_random_offset = 1000;
    level.counter_uav_position_z_offset = 0;
    level.cuav_map_x_percentage = 0.25;
    level.heli_visual_range_override = 10000;
    level.raps_hurt_trigger_immune_duration_ms = 10000;
    level.escort_drop_speed = 7000;
    level.escort_drop_accel = 5000;
    level.escort_drop_height = 3000;
    trigger = spawn( "trigger_radius_out_of_bounds", ( -1499, -293.5, -139.5 ), 0, 500, 128 );
    trigger thread oob::run_oob_trigger();
    trigger = spawn( "trigger_radius_out_of_bounds", ( 1010.5, -738, -276 ), 0, 600, 300 );
    trigger thread oob::run_oob_trigger();
    trigger = spawn( "trigger_radius_out_of_bounds", ( -1449, 234, -302 ), 0, 256, 300 );
    trigger thread oob::run_oob_trigger();
    pole1 = spawn( "script_model", ( -850.826, 725.766, 60 ) );
    pole1.angles = ( 0, 120, 0 );
    pole1 setmodel( "p7_antenna_outpost_tower" );
    var_669bc1cb = spawn( "script_model", ( -852.076, 728.516, 60 ) );
    var_669bc1cb.angles = ( 0, 120, 0 );
    var_669bc1cb setmodel( "p7_antenna_outpost_tower" );
    mp_redwood_ice_fx::main();
    mp_redwood_ice_sound::main();
    load::main();
    compass::setupminimap( "compass_map_mp_redwood_ice" );
    setdvar( "compassmaxrange", "2100" );
    level.cleandepositpoints = array( ( -448.776, -210.531, 50.5891 ), ( 1928.72, 191.469, 270.089 ), ( 570.724, -732.031, 165.589 ), ( -1356.28, 58.969, 63.0891 ), ( -955.276, -1142.53, 156.089 ) );
    level spawnkilltrigger();
}

// Namespace mp_redwood_ice
// Params 0
// Checksum 0x99ec1590, Offset: 0x590
// Size: 0x4
function precache()
{
    
}

// Namespace mp_redwood_ice
// Params 0
// Checksum 0x5b2db322, Offset: 0x5a0
// Size: 0x334
function spawnkilltrigger()
{
    trigger = spawn( "trigger_radius", ( 2772.36, -2224.02, -77.52 ), 0, 500, 300 );
    trigger thread watchkilltrigger();
    ball::add_ball_return_trigger( trigger );
    trigger = spawn( "trigger_radius", ( -1861.1, 1546.53, -106.53 ), 0, 175, 300 );
    trigger thread watchkilltrigger();
    ball::add_ball_return_trigger( trigger );
    trigger = spawn( "trigger_radius", ( -1872, 568, -440 ), 0, 128, 416 );
    trigger thread watchkilltrigger();
    trigger = spawn( "trigger_radius", ( -2080, 600, -440 ), 0, 128, 672 );
    trigger thread watchkilltrigger();
    trigger = spawn( "trigger_radius", ( -2232, 440, -440 ), 0, 128, 900 );
    trigger thread watchkilltrigger();
    trigger = spawn( "trigger_radius", ( -2352, 248, -440 ), 0, 128, 1120 );
    trigger thread watchkilltrigger();
    trigger = spawn( "trigger_radius", ( -2128, 200, -440 ), 0, 128, 800 );
    trigger thread watchkilltrigger();
    trigger = spawn( "trigger_radius", ( -1928, 200, -440 ), 0, 128, 540 );
    trigger thread watchkilltrigger();
    trigger = spawn( "trigger_radius", ( -1768, 312, -440 ), 0, 128, 192 );
    trigger thread watchkilltrigger();
    trigger = spawn( "trigger_radius", ( -1752, 1914, -168 ), 0, 150, 256 );
    trigger thread watchkilltrigger();
    ball::add_ball_return_trigger( trigger );
}

// Namespace mp_redwood_ice
// Params 0
// Checksum 0x9eb1b04d, Offset: 0x8e0
// Size: 0x90
function watchkilltrigger()
{
    level endon( #"game_ended" );
    trigger = self;
    
    while ( true )
    {
        trigger waittill( #"trigger", player );
        player dodamage( 1000, trigger.origin + ( 0, 0, 0 ), trigger, trigger, "none", "MOD_SUICIDE", 0 );
    }
}

