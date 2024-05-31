#using scripts/mp/mp_aerospace_sound;
#using scripts/mp/mp_aerospace_fx;
#using scripts/mp/_util;
#using scripts/mp/_load;
#using scripts/shared/util_shared;
#using scripts/shared/compass;
#using scripts/codescripts/struct;

#namespace namespace_228a7338;

// Namespace namespace_228a7338
// Params 0, eflags: 0x1 linked
// namespace_228a7338<file_0>::function_d290ebfa
// Checksum 0xf55a6857, Offset: 0x1e8
// Size: 0xc04
function main() {
    precache();
    level.var_bb421b36 = 0.5;
    level.rotator_x_offset = 3500;
    level.counter_uav_position_z_offset = 3700;
    level.cuav_map_x_offset = 3700;
    level.uav_z_offset = 4500;
    level.var_657b4cf2 = 10;
    level.var_e8668efc = 11;
    namespace_32af6759::main();
    namespace_8a2f364c::main();
    load::main();
    compass::setupminimap("compass_map_mp_aerospace");
    setdvar("compassmaxrange", "2100");
    spawncollision("collision_physics_wall_128x128x10", "collider", (349.474, -1792.38, -77.9609), (0, 0, 0));
    spawncollision("collision_physics_wall_128x128x10", "collider", (349.474, -1681.59, -77.9609), (0, 0, 0));
    spawncollision("collision_physics_wall_128x128x10", "collider", (322.718, -1792.38, -194.265), (26, 0, 0));
    spawncollision("collision_physics_wall_128x128x10", "collider", (322.718, -1681.59, -194.265), (26, 0, 0));
    spawncollision("collision_physics_wall_128x128x10", "collider", (302.265, -1792.38, -235.58), (26, 0, 0));
    spawncollision("collision_physics_wall_128x128x10", "collider", (302.265, -1681.59, -235.58), (26, 0, 0));
    spawncollision("collision_physics_wall_128x128x10", "collider", (254.282, -1850.71, -182.027), (360, 270, -27));
    spawncollision("collision_physics_wall_256x256x10", "collider", (138.664, -1847.55, -169.266), (0, 270, 0));
    spawncollision("collision_physics_wall_128x128x10", "collider", (90.0833, -1681.59, -292.283), (90, 0, 0));
    spawncollision("collision_physics_wall_128x128x10", "collider", (212.79, -1681.59, -291.578), (90, 0, 0));
    spawncollision("collision_physics_wall_128x128x10", "collider", (90.0833, -1792.38, -292.283), (90, 0, 0));
    spawncollision("collision_physics_wall_128x128x10", "collider", (212.79, -1792.38, -291.578), (90, 0, 0));
    spawncollision("collision_physics_wall_128x128x10", "collider", (349.474, 1680.53, -77.9609), (0, 0, 0));
    spawncollision("collision_physics_wall_128x128x10", "collider", (349.474, 1791.32, -77.9609), (0, 0, 0));
    spawncollision("collision_physics_wall_128x128x10", "collider", (322.718, 1680.53, -194.265), (26, 0, 0));
    spawncollision("collision_physics_wall_128x128x10", "collider", (322.718, 1791.32, -194.265), (26, 0, 0));
    spawncollision("collision_physics_wall_128x128x10", "collider", (302.265, 1680.53, -235.58), (26, 0, 0));
    spawncollision("collision_physics_wall_128x128x10", "collider", (302.265, 1791.32, -235.58), (26, 0, 0));
    spawncollision("collision_physics_wall_128x128x10", "collider", (254.282, 1851.54, -182.027), (360, 270, -27));
    spawncollision("collision_physics_wall_256x256x10", "collider", (138.664, 1854.7, -169.266), (0, 270, 0));
    spawncollision("collision_physics_wall_128x128x10", "collider", (90.0833, 1791.32, -292.283), (90, 0, 0));
    spawncollision("collision_physics_wall_128x128x10", "collider", (212.79, 1791.32, -291.578), (90, 0, 0));
    spawncollision("collision_physics_wall_128x128x10", "collider", (90.0833, 1680.53, -292.283), (90, 0, 0));
    spawncollision("collision_physics_wall_128x128x10", "collider", (212.79, 1680.53, -291.578), (90, 0, 0));
    spawncollision("collision_clip_wall_64x64x10", "collider", (328.5, -2846, 320.5), (353, 0, 0));
    spawncollision("collision_clip_wall_64x64x10", "collider", (328.5, -2819.5, 320.5), (353, 0, 0));
    spawncollision("collision_clip_wall_64x64x10", "collider", (329.5, 2784.5, 320.5), (353, 0, 0));
    spawncollision("collision_clip_wall_64x64x10", "collider", (329.5, 2811, 320.5), (353, 0, 0));
    spawncollision("collision_clip_wall_64x64x10", "collider", (-1744.5, -1245, -110), (352, 270, 0));
    spawncollision("collision_clip_wall_128x128x10", "collider", (-678, 1459, -113), (3, 0, 0));
    spawncollision("collision_clip_wall_128x128x10", "collider", (-678, 1331.5, -113), (3, 0, 0));
    spawncollision("collision_clip_wall_128x128x10", "collider", (-678, 1307, -113), (3, 0, 0));
    spawncollision("collision_clip_wall_128x128x10", "collider", (-118, -3600.5, -48.5), (352, 0, 0));
    spawncollision("collision_clip_wall_128x128x10", "collider", (-118, -3473, -48.5), (352, 0, 0));
    spawncollision("collision_clip_wall_128x128x10", "collider", (-118, -3346.5, -48.5), (352, 0, 0));
    spawncollision("collision_clip_wall_128x128x10", "collider", (-118, -3219, -48.5), (352, 0, 0));
    spawncollision("collision_clip_wall_128x128x10", "collider", (-118, -3093, -48.5), (352, 0, 0));
    spawncollision("collision_clip_wall_128x128x10", "collider", (-750.5, -31, 86.5), (352, 0, 0));
    spawncollision("collision_clip_wall_128x128x10", "collider", (-750.5, 44.5, 86.5), (352, 0, 0));
    spawncollision("collision_clip_wall_64x64x10", "collider", (-273, 810.5, -67), (347, 312, 0));
    level.cleandepositpoints = array((-1218.64, -2.68421, -127.875), (-212.3, 1109, 0.125), (-615.996, -1818.27, 0.125), (743.387, -2.99098, -55.875));
}

// Namespace namespace_228a7338
// Params 0, eflags: 0x1 linked
// namespace_228a7338<file_0>::function_f7046c76
// Checksum 0x99ec1590, Offset: 0xdf8
// Size: 0x4
function precache() {
    
}

