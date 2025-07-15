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

#namespace cp_mi_cairo_lotus3_patch;

// Namespace cp_mi_cairo_lotus3_patch
// Params 0
// Checksum 0x578126bc, Offset: 0x270
// Size: 0x194
function function_7403e82b()
{
    spawncollision( "collision_player_wall_512x512x10", "collider", ( 6064, 485, 17456 ), ( 0, 270, 0 ) );
    spawncollision( "collision_player_32x32x128", "collider", ( 6336, 496, 17264 ), ( 0, 0, 0 ) );
    spawncollision( "collision_player_32x32x128", "collider", ( 6336, 496, 17392 ), ( 0, 0, 0 ) );
    spawncollision( "collision_player_32x32x128", "collider", ( 6336, 496, 17520 ), ( 0, 0, 0 ) );
    spawncollision( "collision_player_32x32x128", "collider", ( 6336, 496, 17648 ), ( 0, 0, 0 ) );
    spawncollision( "collision_clip_256x256x256", "collider", ( 6428, 496, 17078 ), ( 350, 89.9998, 4.9999 ) );
    spawncollision( "collision_clip_256x256x256", "collider", ( 6620, 496, 17062 ), ( 350, 89.9998, 4.9999 ) );
}

