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

#namespace cp_mi_cairo_lotus2_patch;

// Namespace cp_mi_cairo_lotus2_patch
// Params 0, eflags: 0x0
// Checksum 0x92c2d0b3, Offset: 0x2c8
// Size: 0x594
function function_7403e82b() {
    spawncollision("collision_clip_wall_512x512x10", "collider", (-7680, 3451, 3720), (0, 270, 0));
    spawncollision("collision_clip_wall_512x512x10", "collider", (-7168, 3451, 3720), (0, 270, 0));
    spawncollision("collision_clip_wall_512x512x10", "collider", (-6656, 3451, 3720), (0, 270, 0));
    spawncollision("collision_clip_wall_512x512x10", "collider", (-6144, 3451, 3720), (0, 270, 0));
    spawncollision("collision_clip_wall_512x512x10", "collider", (-5632, 3451, 3720), (0, 270, 0));
    spawncollision("collision_clip_wall_512x512x10", "collider", (-5381, 3200, 3720), (0, 0, 0));
    spawncollision("collision_clip_wall_512x512x10", "collider", (-5381, 2688, 3720), (0, 0, 0));
    spawncollision("collision_clip_wall_512x512x10", "collider", (-4972, 2683, 3720), (0, 90, 0));
    spawncollision("collision_clip_wall_512x512x10", "collider", (-4460, 2683, 3720), (0, 90, 0));
    spawncollision("collision_clip_wall_512x512x10", "collider", (-4227, 2688, 3720), (0, 0, 0));
    spawncollision("collision_clip_wall_512x512x10", "collider", (-4227, 3200, 3720), (0, 0, 0));
    spawncollision("collision_player_wall_256x256x10", "collider", (-8743, -229, 14977), (0, 270, 0));
    spawncollision("collision_player_wall_256x256x10", "collider", (-8512, -229, 14977), (0, 270, 0));
    spawncollision("collision_player_wall_256x256x10", "collider", (-8512, -352, 14844), (270, 36.8699, -126.87));
    spawncollision("collision_player_wall_256x256x10", "collider", (-8743, -352, 14844), (270, 36.8699, -126.87));
    spawncollision("collision_player_wall_512x512x10", "collider", (-8324, -744, 14448), (0, 0, 0));
    spawncollision("collision_player_wall_512x512x10", "collider", (-451, -1524, 16072), (0, 0, 0));
    spawncollision("collision_player_wall_512x512x10", "collider", (-451, -1524, 15560), (0, 0, 0));
    spawncollision("collision_monster_128x128x128", "dougs_magic_clip", (-6401.5, -504, 14446), (0, 0, 0));
    var_8137c516 = getent("dougs_magic_clip", "targetname");
    var_8137c516 disconnectpaths(0, 0);
    spawncollision("collision_clip_256x256x256", "collider", (-3004, 2592, 15612), (0, 0, 0));
    spawncollision("collision_clip_256x256x256", "collider", (-2980, 2336, 15612), (0, 0, 0));
    spawncollision("collision_clip_256x256x256", "collider", (-2980, 2080, 15612), (0, 0, 0));
    spawncollision("collision_clip_256x256x256", "collider", (-2980, 1824, 15612), (0, 0, 0));
    spawncollision("collision_clip_256x256x256", "collider", (-2980, 1568, 15612), (0, 0, 0));
}

