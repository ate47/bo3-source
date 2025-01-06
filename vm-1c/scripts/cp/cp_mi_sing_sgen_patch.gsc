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

#namespace cp_mi_sing_sgen_patch;

// Namespace cp_mi_sing_sgen_patch
// Params 0, eflags: 0x0
// Checksum 0xb2bebc25, Offset: 0x268
// Size: 0x334
function function_7403e82b() {
    spawncollision("collision_clip_wall_256x256x10", "collider", (-560, 1793, -1264), (0, 304.999, 0));
    spawncollision("collision_clip_wall_256x256x10", "collider", (24832, 1744, -6808), (0, 270, 0));
    spawncollision("collision_clip_wall_256x256x10", "collider", (24704, 1424, -6808), (0, 270, 0));
    spawncollision("collision_clip_512x512x512", "collider", (-56.6863, -362.706, -2184), (0, 255.999, 0));
    spawncollision("collision_clip_512x512x512", "collider", (-507.636, -165.595, -2184), (0, 229.9, 0));
    spawncollision("collision_clip_512x512x512", "collider", (-853.325, 1393.89, -2184), (0, 65.199, 0));
    spawncollision("collision_clip_512x512x512", "collider", (-464.19, 1867.93, -2184), (0, 30.2, 0));
    spawncollision("collision_clip_512x512x512", "collider", (-35, 2064, -2184), (0, 20.2, 0));
    spawncollision("collision_clip_256x256x256", "collider", (-641.069, 170.047, -2264), (0, 36.098, 0));
    spawncollision("collision_clip_256x256x256", "collider", (-775.342, 390.502, -2264), (0, 25.298, 0));
    spawncollision("collision_clip_256x256x256", "collider", (-866.006, 660.644, -2264), (0, 11.599, 0));
    spawncollision("collision_clip_256x256x256", "collider", (-868, 962, -2264), (0, 348.6, 0));
    spawncollision("collision_clip_512x512x512", "collider", (-2016, -1104, -4888), (0, 0, 0));
}

