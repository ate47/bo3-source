#using scripts/cp/_util;
#using scripts/cp/_objectives;
#using scripts/cp/_load;
#using scripts/shared/vehicles/_quadtank;
#using scripts/shared/vehicle_shared;
#using scripts/shared/util_shared;
#using scripts/shared/trigger_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/array_shared;
#using scripts/shared/ai_shared;
#using scripts/codescripts/struct;

#namespace namespace_8cf14dc8;

// Namespace namespace_8cf14dc8
// Params 0, eflags: 0x1 linked
// Checksum 0xcfea1cd7, Offset: 0x250
// Size: 0x134
function function_7403e82b() {
    spawncollision("collision_clip_wall_128x128x10", "collider", (16141, -864, 416), (0, 0, 0));
    spawncollision("collision_clip_wall_512x512x10", "collider", (8004.5, 4701, 384), (0, 315, 0));
    spawncollision("collision_clip_wall_512x512x10", "collider", (8260.5, 4957, 384), (0, 315, 0));
    spawncollision("collision_clip_wall_512x512x10", "collider", (9652.5, 6349, 384), (0, 315, 0));
    spawncollision("collision_clip_wall_512x512x10", "collider", (9908.5, 6605, 384), (0, 315, 0));
}

