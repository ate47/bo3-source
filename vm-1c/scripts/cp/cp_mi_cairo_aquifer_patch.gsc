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

#namespace cp_mi_cairo_aquifer_patch;

// Namespace cp_mi_cairo_aquifer_patch
// Params 0, eflags: 0x1 linked
// Checksum 0xff5ebd78, Offset: 0x238
// Size: 0x44
function function_7403e82b() {
    spawncollision("collision_clip_wall_512x512x10", "collider", (11119, 2965, 2620), (0, 270, 0));
}

