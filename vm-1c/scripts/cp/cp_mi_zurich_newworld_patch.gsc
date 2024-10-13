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

#namespace cp_mi_zurich_newworld_patch;

// Namespace cp_mi_zurich_newworld_patch
// Params 0, eflags: 0x1 linked
// Checksum 0x9cab742f, Offset: 0x250
// Size: 0x7c
function function_7403e82b() {
    spawncollision("collision_clip_256x256x256", "collider", (25736, -33728, -7352), (0, 0, 0));
    spawncollision("collision_clip_wall_128x128x10", "collider", (22624, -9931.75, -7287), (0, 270, 0));
}

