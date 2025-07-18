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

#namespace cp_mi_cairo_lotus_patch;

// Namespace cp_mi_cairo_lotus_patch
// Params 0
// Checksum 0x1615d283, Offset: 0x258
// Size: 0x214
function function_7403e82b()
{
    spawncollision( "collision_clip_wall_512x512x10", "collider", ( -8380, 58, 1488 ), ( 0, 0, 0 ) );
    spawncollision( "collision_clip_wall_512x512x10", "collider", ( -8380, 570, 1488 ), ( 0, 0, 0 ) );
    spawncollision( "collision_clip_wall_512x512x10", "collider", ( -8380, 1082, 1488 ), ( 0, 0, 0 ) );
    spawncollision( "collision_player_wall_512x512x10", "collider", ( -5851, -287, 4024 ), ( 0, 13.9991, 0 ) );
    spawncollision( "collision_player_wall_512x512x10", "collider", ( -5927, 216, 4024 ), ( 0, 3.19854, 0 ) );
    spawncollision( "collision_player_wall_512x512x10", "collider", ( -5875, 717, 4024 ), ( 0, 344.998, 0 ) );
    spawncollision( "collision_player_wall_512x512x10", "collider", ( -5851, -287, 4536 ), ( 0, 13.9991, 0 ) );
    spawncollision( "collision_player_wall_512x512x10", "collider", ( -5927, 216, 4536 ), ( 0, 3.19854, 0 ) );
    spawncollision( "collision_player_wall_512x512x10", "collider", ( -5875, 717, 4536 ), ( 0, 344.998, 0 ) );
}

