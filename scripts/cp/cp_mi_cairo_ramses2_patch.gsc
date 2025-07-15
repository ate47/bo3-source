#using scripts/codescripts/struct;
#using scripts/cp/_load;
#using scripts/cp/_objectives;
#using scripts/cp/_util;
#using scripts/shared/ai_shared;
#using scripts/shared/array_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/trigger_shared;
#using scripts/shared/util_shared;
#using scripts/shared/vehicle_shared;
#using scripts/shared/vehicles/_quadtank;

#namespace cp_mi_cairo_ramses2_patch;

// Namespace cp_mi_cairo_ramses2_patch
// Params 0
// Checksum 0x19530ab1, Offset: 0x2b8
// Size: 0x34c
function function_7403e82b()
{
    spawncollision( "collision_clip_wall_128x128x10", "collider", ( 2071.76, -20849.9, 452 ), ( 0, 317.4, 0 ) );
    spawncollision( "collision_clip_wedge_32x128", "collider", ( 2045.46, -20817.7, 370.5 ), ( 0, 141.999, 0 ) );
    spawncollision( "collision_clip_wall_128x128x10", "collider", ( 8179.5, -15748.8, 228 ), ( 0, 40.4991, 0 ) );
    spawncollision( "collision_player_512x512x512", "collider", ( 5824, -17468, 564 ), ( 0, 315, 0 ) );
    spawncollision( "collision_player_512x512x512", "collider", ( 6648, -16276, 776 ), ( 0, 315, 0 ) );
    spawncollision( "collision_player_512x512x512", "collider", ( 7016, -16632, 776 ), ( 0, 315, 0 ) );
    spawncollision( "collision_player_512x512x512", "collider", ( 6584, -16800, 776 ), ( 0, 315, 0 ) );
    spawncollision( "collision_player_256x256x256", "collider", ( 1952, -19988, 572 ), ( 0, 315, 0 ) );
    spawncollision( "collision_player_wall_256x256x10", "collider", ( 1876, -19908, 364 ), ( 0, 315, 0 ) );
    spawncollision( "collision_player_wall_256x256x10", "collider", ( 1716, -20064, 364 ), ( 0, 225, 0 ) );
    spawncollision( "collision_player_wall_256x256x10", "collider", ( 3280, -19356, 68 ), ( 0, 225, 0 ) );
    var_6b576c83 = spawn( "script_model", ( 1020, -22796, 72 ) );
    var_6b576c83 setmodel( "collision_clip_wall_128x128x10" );
    var_6b576c83.angles = ( 0, 45, 0 );
    var_6b576c83 setforcenocull();
}

