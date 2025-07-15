#using scripts/codescripts/struct;
#using scripts/mp/_load;
#using scripts/mp/_util;
#using scripts/mp/gametypes/_spawnlogic;
#using scripts/mp/mp_cryogen_fx;
#using scripts/mp/mp_cryogen_sound;
#using scripts/shared/array_shared;
#using scripts/shared/compass;
#using scripts/shared/scene_shared;
#using scripts/shared/util_shared;

#namespace mp_cryogen;

// Namespace mp_cryogen
// Params 0
// Checksum 0x75dc3c73, Offset: 0x328
// Size: 0x594
function main()
{
    precache();
    spawnlogic::move_spawn_point( "mp_dm_spawn_start", ( 1197.14, -979.058, 37.625 ), ( 834.823, -803.36, 37.625 ), ( 0, 191, 0 ) );
    mp_cryogen_fx::main();
    mp_cryogen_sound::main();
    load::main();
    compass::setupminimap( "compass_map_mp_cryogen" );
    setdvar( "compassmaxrange", "2100" );
    spawncollision( "collision_clip_wall_512x512x10", "collider", ( -1031.5, -451.5, -89 ), ( 0, 270, 0 ) );
    spawncollision( "collision_clip_32x32x32", "collider", ( 537, -453, 56 ), ( 0, 0, 0 ) );
    spawncollision( "collision_clip_32x32x32", "collider", ( 569, -453, 56 ), ( 0, 0, 0 ) );
    spawncollision( "collision_clip_ramp_64x24", "collider", ( -1763, -1093.5, 93.5 ), ( 0, 0, 0 ) );
    spawncollision( "collision_clip_ramp_64x24", "collider", ( -1763, -1148, 93.5 ), ( 0, 180, 0 ) );
    var_32cbbad9 = spawn( "script_model", ( 551, -453, 40 ) );
    var_32cbbad9.angles = ( 0, 0, 0 );
    var_32cbbad9 setmodel( "p7_crate_lab_plastic_locking_open" );
    grate1 = spawn( "script_model", ( -1751.33, -1096.74, 102 ) );
    grate1.angles = ( 270, 358.909, 25 );
    grate1 setmodel( "p7_tank_nitrogen_metal" );
    grate1 setscale( 0.7 );
    grate2 = spawn( "script_model", ( -1723.16, -1105.32, 102 ) );
    grate2.angles = ( 270, 0, 26 );
    grate2 setmodel( "p7_tank_nitrogen_metal" );
    grate2 setscale( 0.7 );
    grate3 = spawn( "script_model", ( -1787.44, -1135.93, 100.3 ) );
    grate3.angles = ( 270, 355.638, 162 );
    grate3 setmodel( "p7_tank_nitrogen_metal" );
    grate3 setscale( 0.7 );
    spawncollision( "collision_clip_wall_64x64x10", "collider", ( 1770.5, -336.5, 64 ), ( 0, 0, 0 ) );
    spawncollision( "collision_clip_wall_64x64x10", "collider", ( -2560.5, 452.5, 81.5 ), ( 0, 270, 0 ) );
    spawncollision( "collision_clip_wall_64x64x10", "collider", ( 2334.5, -187.5, 35 ), ( 0, 270, 0 ) );
    level.cleandepositpoints = array( ( -115.486, -454.185, 0.125 ), ( 956.442, -1586.68, 0.125 ), ( 1214.72, -76.1687, 40.125 ), ( 167.401, -1543.29, -127.875 ) );
    level thread scene_sequence( "p7_fxanim_mp_cry_vista_tower_01_bundle" );
    level spawnkilltrigger();
}

// Namespace mp_cryogen
// Params 0
// Checksum 0x99ec1590, Offset: 0x8c8
// Size: 0x4
function precache()
{
    
}

// Namespace mp_cryogen
// Params 1
// Checksum 0xc1b55ae4, Offset: 0x8d8
// Size: 0x128
function scene_sequence( str_scene )
{
    var_aae314ac = 25;
    var_9a15ce42 = 35;
    var_3aeeca62 = 0.5;
    var_df291458 = 3;
    
    while ( true )
    {
        wait randomfloatrange( var_aae314ac, var_9a15ce42 );
        level thread function_cfe901b9( str_scene, "ring_01_towers", var_3aeeca62, var_df291458 );
        wait randomfloatrange( var_aae314ac, var_9a15ce42 );
        level thread function_cfe901b9( str_scene, "ring_02_towers", var_3aeeca62, var_df291458 );
        wait randomfloatrange( var_aae314ac, var_9a15ce42 );
        level thread function_cfe901b9( str_scene, "ring_03_towers", var_3aeeca62, var_df291458 );
    }
}

// Namespace mp_cryogen
// Params 4
// Checksum 0x5c644110, Offset: 0xa08
// Size: 0x74
function function_cfe901b9( str_scene, str_ring, min_time, max_time )
{
    level thread init_scene( str_scene, str_ring, min_time, max_time );
    wait 10;
    level thread run_scene( str_scene, str_ring, min_time, max_time );
}

// Namespace mp_cryogen
// Params 4
// Checksum 0x2d56f685, Offset: 0xa88
// Size: 0x252
function run_scene( str_scene, str_targetname, min_time, max_time )
{
    b_found = 0;
    str_mode = tolower( getdvarstring( "scene_menu_mode", "default" ) );
    a_scenes = function_76d36418( struct::get_array( str_scene, "scriptbundlename" ), 0, str_targetname );
    
    foreach ( s_instance in a_scenes )
    {
        if ( isdefined( s_instance ) )
        {
            if ( !isinarray( a_scenes, s_instance ) )
            {
                b_found = 1;
                s_instance thread function_f3529f1a( undefined, str_mode, min_time, max_time );
            }
        }
    }
    
    if ( isdefined( level.active_scenes[ str_scene ] ) )
    {
        a_scenes = function_76d36418( level.active_scenes[ str_scene ], 0, str_targetname );
        
        if ( isdefined( a_scenes ) )
        {
            foreach ( s_instance in a_scenes )
            {
                b_found = 1;
                s_instance thread function_f3529f1a( str_scene, str_mode, min_time, max_time );
            }
        }
    }
}

// Namespace mp_cryogen
// Params 4
// Checksum 0xf69ce83b, Offset: 0xce8
// Size: 0x17c
function init_scene( str_scene, str_targetname, min_time, max_time )
{
    str_mode = tolower( getdvarstring( "scene_menu_mode", "default" ) );
    b_found = 0;
    a_scenes = function_76d36418( struct::get_array( str_scene, "scriptbundlename" ), 0, str_targetname );
    
    foreach ( s_instance in a_scenes )
    {
        if ( isdefined( s_instance ) )
        {
            b_found = 1;
            s_instance thread function_cf748f4e( undefined, min_time, max_time );
        }
    }
    
    if ( !b_found )
    {
        level.scene_test_struct thread function_cf748f4e( str_scene, min_time, max_time );
    }
}

// Namespace mp_cryogen
// Params 3
// Checksum 0x90be8bd2, Offset: 0xe70
// Size: 0x4a
function function_76d36418( &array, b_keep_keys, str_targetname )
{
    return array::filter( array, b_keep_keys, &function_e35699e3, str_targetname );
}

// Namespace mp_cryogen
// Params 2
// Checksum 0xcffa67c2, Offset: 0xec8
// Size: 0x28, Type: bool
function function_e35699e3( val, arg )
{
    return val.targetname === arg;
}

// Namespace mp_cryogen
// Params 4
// Checksum 0xc3cdb89f, Offset: 0xef8
// Size: 0x84
function function_f3529f1a( str_scene, str_mode, min_time, max_time )
{
    if ( min_time >= 0 && max_time > 0 )
    {
        wait randomfloatrange( min_time, max_time );
    }
    
    self thread scene::play( str_scene, undefined, undefined, 1, undefined, str_mode );
}

// Namespace mp_cryogen
// Params 3
// Checksum 0xd3cefbbf, Offset: 0xf88
// Size: 0x74
function function_cf748f4e( str_scene, min_time, max_time )
{
    if ( min_time >= 0 && max_time > 0 )
    {
        wait randomfloatrange( min_time, max_time );
    }
    
    self thread scene::init( str_scene, undefined, undefined, 1 );
}

// Namespace mp_cryogen
// Params 0
// Checksum 0x9812a804, Offset: 0x1008
// Size: 0xec
function spawnkilltrigger()
{
    trigger = spawn( "trigger_radius", ( 1695, -344, -2 ), 0, 80, 40 );
    trigger thread watchkilltrigger();
    trigger = spawn( "trigger_radius", ( -2571.5, 527.5, 53 ), 0, 80, 100 );
    trigger thread watchkilltrigger();
    trigger = spawn( "trigger_radius", ( 2286.5, -108, -2 ), 0, 80, 100 );
    trigger thread watchkilltrigger();
}

// Namespace mp_cryogen
// Params 0
// Checksum 0x59afdfa0, Offset: 0x1100
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

