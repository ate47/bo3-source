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

#namespace cp_mi_sing_biodomes2_patch;

// Namespace cp_mi_sing_biodomes2_patch
// Params 0
// Checksum 0xfd273d6, Offset: 0x288
// Size: 0x2b4
function function_7403e82b()
{
    spawncollision( "collision_clip_512x512x512", "collider", ( -5246, -2550.5, 51.5 ), ( 0, 0, 0 ) );
    spawncollision( "collision_clip_512x512x512", "collider", ( -5134, 1603, -352 ), ( 60, 90, 108 ) );
    spawncollision( "collision_clip_512x512x512", "collider", ( -4627, 1463, -436 ), ( 60, 90, 108 ) );
    spawncollision( "collision_clip_512x512x512", "collider", ( -4137, 1317, -498 ), ( 60, 90, 108 ) );
    spawncollision( "collision_clip_512x512x512", "collider", ( -3615, 1068, -497 ), ( 61, 63, 83 ) );
    spawncollision( "collision_clip_512x512x512", "collider", ( -3006, -419, -488 ), ( 68, 347, -23 ) );
    spawncollision( "collision_clip_512x512x512", "collider", ( -3042, 602, -414 ), ( 332, 17, 0 ) );
    spawncollision( "collision_clip_64x64x256", "collider", ( -5234, -226, -417 ), ( 295, 0, 0 ) );
    spawncollision( "collision_clip_256x256x256", "collider", ( -3273, 502, -318 ), ( 338, 0, 0 ) );
    spawncollision( "collision_clip_wall_512x512x10", "collider", ( 340, 12284, 1056 ), ( 0, 270, 0 ) );
    spawncollision( "collision_clip_wall_512x512x10", "collider", ( 772, 12272, 1056 ), ( 0, 270, 0 ) );
}

