#using scripts/mp/mp_skyjacked_sound;
#using scripts/mp/mp_skyjacked_fx;
#using scripts/mp/_util;
#using scripts/mp/_load;
#using scripts/shared/compass;
#using scripts/shared/util_shared;
#using scripts/codescripts/struct;

#namespace mp_skyjacked;

// Namespace mp_skyjacked
// Params 0, eflags: 0x1 linked
// Checksum 0xd9caa322, Offset: 0x220
// Size: 0x1694
function main() {
    level.levelkothdisable = [];
    level.levelkothdisable[level.levelkothdisable.size] = spawn("trigger_radius", (561.279, -418.987, -32.5), 0, 50, -128);
    level.levelkothdisable[level.levelkothdisable.size] = spawn("trigger_radius", (619.679, -421.624, -32.5), 0, 50, -128);
    level.levelescortdisable = [];
    level.levelescortdisable[level.levelescortdisable.size] = spawn("trigger_radius", (-1538.24, -10.9259, 89.5049), 0, -6, 80);
    level.levelescortdisable[level.levelescortdisable.size] = spawn("trigger_radius", (-1288.24, -28.1134, 162.375), 0, 500, 80);
    level.levelescortdisable[level.levelescortdisable.size] = spawn("trigger_radius", (-1404.6, -262.257, 89.5049), 0, 125, 80);
    level.levelescortdisable[level.levelescortdisable.size] = spawn("trigger_radius", (900.411, -51.9474, 162.076), 0, 600, 80);
    level.levelescortdisable[level.levelescortdisable.size] = spawn("trigger_radius", (733.431, -378.099, 38.587), 0, 100, 100);
    level.levelescortdisable[level.levelescortdisable.size] = spawn("trigger_radius", (881.857, -341.619, 120.587), 0, 100, 100);
    precache();
    level.bomb_zone_fixup = &bomb_zone_fixup;
    mp_skyjacked_fx::main();
    mp_skyjacked_sound::main();
    load::main();
    compass::setupminimap("compass_map_mp_skyjacked");
    setdvar("compassmaxrange", "2100");
    spawncollision("collision_clip_wall_128x128x10", "collider", (-77.3255, -34.2904, 4.7251), (90, 270, 0));
    spawncollision("collision_clip_wall_128x128x10", "collider", (516.069, 138.325, 225.855), (10, 89, -76));
    spawncollision("collision_clip_wall_128x128x10", "collider", (1312.2, 332.753, 77.8061), (0, 270, 0));
    spawncollision("collision_clip_wall_64x64x10", "collider", (-409.046, 27.0095, 194.299), (12, 0, 0));
    spawncollision("collision_clip_wall_64x64x10", "collider", (-409.046, -11.7873, 194.299), (12, 0, 0));
    spawncollision("collision_clip_wall_32x32x10", "collider", (-141.961, -63.9699, 194.299), (22, 54, 4));
    spawncollision("collision_bullet_wall_64x64x10", "collider", (504.45, -435.732, 115.858), (0, 270, 0));
    spawncollision("collision_bullet_wall_64x64x10", "collider", (504.45, -435.732, 52.284), (0, 270, 0));
    spawncollision("collision_bullet_wall_64x64x10", "collider", (534.791, -404.426, 115.858), (0, 180, 0));
    spawncollision("collision_bullet_wall_64x64x10", "collider", (534.791, -404.426, 52.284), (0, 180, 0));
    spawncollision("collision_bullet_wall_64x64x10", "collider", (584.515, -435.732, 168.412), (0, 270, 0));
    spawncollision("collision_bullet_wall_64x64x10", "collider", (647.829, -435.732, 168.412), (0, 270, 0));
    spawncollision("collision_bullet_wall_64x64x10", "collider", (710.942, -435.732, 168.412), (0, 270, 0));
    spawncollision("collision_bullet_wall_64x64x10", "collider", (774.256, -435.732, 168.412), (0, 270, 0));
    spawncollision("collision_bullet_wall_64x64x10", "collider", (836.72, -435.732, 168.412), (0, 270, 0));
    spawncollision("collision_bullet_wall_64x64x10", "collider", (900.034, -435.732, 168.412), (0, 270, 0));
    spawncollision("collision_bullet_wall_64x64x10", "collider", (963.222, -435.732, 168.412), (0, 270, 0));
    spawncollision("collision_bullet_wall_64x64x10", "collider", (1026.54, -435.732, 168.412), (0, 270, 0));
    spawncollision("collision_bullet_wall_64x64x10", "collider", (1089.47, -435.732, 168.412), (0, 270, 0));
    spawncollision("collision_bullet_wall_64x64x10", "collider", (1152.79, -435.732, 168.412), (0, 270, 0));
    spawncollision("collision_bullet_wall_64x64x10", "collider", (1215.14, -435.732, 168.412), (0, 270, 0));
    spawncollision("collision_bullet_wall_64x64x10", "collider", (1278.46, -435.732, 168.412), (0, 270, 0));
    spawncollision("collision_bullet_wall_64x64x10", "collider", (1327.98, -435.732, 145.949), (3, 270, 27));
    spawncollision("collision_bullet_wall_64x64x10", "collider", (1337.04, -435.732, 128.526), (3, 270, 27));
    spawncollision("collision_bullet_wall_64x64x10", "collider", (1350.94, -435.732, 126.824), (360, 270, 33));
    spawncollision("collision_bullet_wall_64x64x10", "collider", (1366.08, -435.732, 72.6485), (3, 270, 27));
    spawncollision("collision_bullet_wall_64x64x10", "collider", (1385.76, -435.732, 74.3508), (360, 270, 33));
    spawncollision("collision_bullet_wall_64x64x10", "collider", (1400.81, -406.036, 103.928), (33, -76, -1));
    spawncollision("collision_bullet_wall_64x64x10", "collider", (1435.83, -406.036, 51.2122), (33, -76, -1));
    spawncollision("collision_bullet_wall_64x64x10", "collider", (1305.21, -406.036, 126.569), (55, -76, 3));
    spawncollision("collision_bullet_wall_64x64x10", "collider", (1316.25, -406.036, 105.578), (27, -76, 2));
    spawncollision("collision_bullet_wall_64x64x10", "collider", (1345.7, -406.036, 49.5623), (27, -76, 2));
    spawncollision("collision_bullet_wall_64x64x10", "collider", (647.829, -410.966, 141.609), (270, 0, -90));
    spawncollision("collision_bullet_wall_64x64x10", "collider", (710.942, -410.966, 141.609), (270, 0, -90));
    spawncollision("collision_bullet_wall_64x64x10", "collider", (774.256, -410.966, 141.609), (270, 0, -90));
    spawncollision("collision_bullet_wall_64x64x10", "collider", (836.72, -410.966, 141.609), (270, 0, -90));
    spawncollision("collision_bullet_wall_64x64x10", "collider", (900.034, -410.966, 141.609), (270, 0, -90));
    spawncollision("collision_bullet_wall_64x64x10", "collider", (963.222, -410.966, 141.609), (270, 0, -90));
    spawncollision("collision_bullet_wall_64x64x10", "collider", (1026.54, -410.966, 141.609), (270, 0, -90));
    spawncollision("collision_bullet_wall_64x64x10", "collider", (1089.47, -410.966, 141.609), (270, 0, -90));
    spawncollision("collision_bullet_wall_64x64x10", "collider", (1152.79, -410.966, 141.609), (270, 0, -90));
    spawncollision("collision_bullet_wall_64x64x10", "collider", (1215.14, -410.966, 141.609), (270, 0, -90));
    spawncollision("collision_bullet_wall_64x64x10", "collider", (1278.58, -410.966, 141.609), (270, 0, -90));
    spawncollision("collision_clip_wall_64x64x10", "collider", (1142.89, 340.367, 409.595), (329, 90, 0));
    spawncollision("collision_clip_wall_64x64x10", "collider", (1079.87, 340.367, 409.595), (329, 90, 0));
    spawncollision("collision_clip_wall_64x64x10", "collider", (1017.46, 340.367, 409.595), (329, 90, 0));
    spawncollision("collision_clip_wall_64x64x10", "collider", (954.435, 340.367, 409.595), (329, 90, 0));
    spawncollision("collision_clip_wall_64x64x10", "collider", (891.928, 340.367, 409.595), (329, 90, 0));
    spawncollision("collision_clip_wall_64x64x10", "collider", (828.908, 340.367, 409.595), (329, 90, 0));
    spawncollision("collision_clip_wall_64x64x10", "collider", (765.366, 340.367, 409.595), (329, 90, 0));
    spawncollision("collision_clip_wall_64x64x10", "collider", (702.346, 340.367, 409.595), (329, 90, 0));
    spawncollision("collision_clip_wall_64x64x10", "collider", (643.756, 340.367, 409.595), (329, 90, 0));
    spawncollision("collision_clip_wall_64x64x10", "collider", (643.757, -338.596, 409.595), (329, 270, 0));
    spawncollision("collision_clip_wall_64x64x10", "collider", (706.777, -338.596, 409.595), (329, 270, 0));
    spawncollision("collision_clip_wall_64x64x10", "collider", (769.191, -338.596, 409.595), (329, 270, 0));
    spawncollision("collision_clip_wall_64x64x10", "collider", (832.211, -338.596, 409.595), (329, 270, 0));
    spawncollision("collision_clip_wall_64x64x10", "collider", (894.718, -338.596, 409.595), (329, 270, 0));
    spawncollision("collision_clip_wall_64x64x10", "collider", (957.738, -338.596, 409.595), (329, 270, 0));
    spawncollision("collision_clip_wall_64x64x10", "collider", (1021.28, -338.596, 409.595), (329, 270, 0));
    spawncollision("collision_clip_wall_64x64x10", "collider", (1084.3, -338.596, 409.595), (329, 270, 0));
    spawncollision("collision_clip_wall_64x64x10", "collider", (1142.89, -338.596, 409.595), (329, 270, 0));
    spawncollision("collision_clip_wall_64x64x10", "collider", (1310.96, 267.262, 199.897), (0, 0, 0));
    spawncollision("collision_clip_wall_64x64x10", "collider", (1310.96, 298.088, 199.897), (0, 0, 0));
    spawncollision("collision_clip_wall_64x64x10", "collider", (-88.1753, 537.193, 397.585), (339, 270, 0));
    spawncollision("collision_clip_64x64x64", "collider", (-1348.73, -190.386, 119.873), (0, 0, 0));
    spawncollision("collision_clip_64x64x64", "collider", (-1348.73, -233.009, 119.873), (0, 0, 0));
    spawncollision("collision_clip_64x64x64", "collider", (-1348.73, -190.386, 183.073), (0, 0, 0));
    spawncollision("collision_clip_64x64x64", "collider", (-1348.73, -233.009, 183.073), (0, 0, 0));
    level.cleandepositpoints = array((-3, -196.025, 20.625), (-283.422, 233.852, -171.875), (-1567.78, -65.9542, -43.875), (663.755, -188.581, 20.125));
}

// Namespace mp_skyjacked
// Params 0, eflags: 0x1 linked
// Checksum 0x99ec1590, Offset: 0x18c0
// Size: 0x4
function precache() {
    
}

// Namespace mp_skyjacked
// Params 1, eflags: 0x1 linked
// Checksum 0xfba99ee2, Offset: 0x18d0
// Size: 0xa4
function bomb_zone_fixup(bombzone) {
    if (!isdefined(bombzone)) {
        return;
    }
    if (isdefined(bombzone.worldicons) && bombzone.worldicons["enemy"] === "waypoint_target_b") {
        bombzone.visuals[0].killcament.origin = bombzone.visuals[0].killcament.origin + (0, 0, -12);
    }
}

