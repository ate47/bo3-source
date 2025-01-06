#using scripts/codescripts/struct;
#using scripts/mp/_load;
#using scripts/mp/_util;
#using scripts/mp/mp_infection_fx;
#using scripts/mp/mp_infection_sound;
#using scripts/shared/compass;
#using scripts/shared/util_shared;

#namespace mp_infection;

// Namespace mp_infection
// Params 0, eflags: 0x1 linked
// Checksum 0xc13691c0, Offset: 0x220
// Size: 0xc14
function main() {
    precache();
    level.var_bb421b36 = 0.5;
    level.rotator_x_offset = 3500;
    level.counter_uav_position_z_offset = 3700;
    level.cuav_map_x_offset = 3700;
    level.uav_z_offset = 4500;
    level.var_657b4cf2 = 10;
    level.var_e8668efc = 11;
    level.var_c9aa825e = &function_c9aa825e;
    level.var_7bb6ebae = &function_7bb6ebae;
    level.remotemissile_kill_z = -800;
    mp_infection_fx::main();
    mp_infection_sound::main();
    load::main();
    compass::setupminimap("compass_map_mp_infection");
    setdvar("compassmaxrange", "2100");
    level.levelescortdisable = [];
    level.levelescortdisable[level.levelescortdisable.size] = spawn("trigger_radius", (-245.331, -1770.34, 0), 0, 256, -128);
    level.levelescortdisable[level.levelescortdisable.size] = spawn("trigger_radius", (-252.651, -1588.34, 0), 0, 256, 300);
    spawncollision("collision_clip_wall_128x128x10", "collider", (-625.308, -790.359, 354.424), (349, 270, 0));
    spawncollision("collision_bullet_wall_512x512x10", "collider", (-1242.65, 109.098, 761.723), (356, 0, 0));
    spawncollision("collision_bullet_wall_512x512x10", "collider", (-1242.65, 609.142, 761.723), (356, 0, 0));
    spawncollision("collision_bullet_wall_512x512x10", "collider", (-1238, 109.098, 272.099), (356, 0, 0));
    spawncollision("collision_bullet_wall_512x512x10", "collider", (-1238, 609.142, 272.099), (356, 0, 0));
    spawncollision("collision_bullet_wall_512x512x10", "collider", (-1245.61, -2067.75, 318.535), (0, 0, 0));
    spawncollision("collision_clip_wall_128x128x10", "collider", (-571.326, -415.472, 367.515), (345, 0, 0));
    spawncollision("collision_clip_wall_128x128x10", "collider", (-571.326, -303.315, 367.515), (345, 0, 0));
    spawncollision("collision_clip_wall_128x128x10", "collider", (-571.326, -184.21, 367.515), (345, 0, 0));
    spawncollision("collision_clip_wall_128x128x10", "collider", (-642.488, -123.974, 367.515), (345, 90, 0));
    spawncollision("collision_clip_wall_128x128x10", "collider", (-769.848, -123.974, 367.515), (345, 90, 0));
    spawncollision("collision_clip_wall_128x128x10", "collider", (-894.232, -123.974, 367.515), (345, 90, 0));
    spawncollision("collision_clip_64x64x64", "collider", (-598.008, -146.947, 318.623), (334, 354, 20));
    spawncollision("collision_clip_wall_64x64x10", "collider", (-945.816, -112.197, 583.912), (23, 270, 0));
    spawncollision("collision_clip_wall_64x64x10", "collider", (-1227.86, -95.2294, 280.48), (343, 0, 0));
    spawncollision("collision_clip_wall_64x64x10", "collider", (-256.59, 887.807, 251.596), (343, 122, 0));
    spawncollision("collision_clip_wall_64x64x10", "collider", (-354.033, 825.138, 250.086), (343, 122, 0));
    spawncollision("collision_clip_wall_128x128x10", "collider", (-654.575, 2124.26, 339.559), (355, 270, 0));
    spawncollision("collision_clip_wall_128x128x10", "collider", (-529.115, 2124.26, 339.559), (355, 270, 0));
    spawncollision("collision_clip_wall_128x128x10", "collider", (-409.251, 2124.26, 339.559), (355, 270, 0));
    spawncollision("collision_clip_wall_128x128x10", "collider", (-286.924, 2124.26, 339.559), (355, 270, 0));
    spawncollision("collision_clip_wall_128x128x10", "collider", (-224.629, 2187.71, 339.639), (342, 0, 0));
    spawncollision("collision_clip_wall_128x128x10", "collider", (-230.815, 2242.7, 383.569), (342, 0, 0));
    spawncollision("collision_clip_wall_128x128x10", "collider", (-230.216, 2272.01, 409.437), (342, 0, 0));
    spawncollision("collision_clip_wall_128x128x10", "collider", (-229.071, 2309.13, 429.67), (342, 0, 0));
    spawncollision("collision_clip_wall_64x64x10", "collider", (41.7616, 1105.1, 461.663), (355, 270, 0));
    spawncollision("collision_clip_wall_64x64x10", "collider", (105.742, 1105.1, 461.663), (355, 270, 0));
    spawncollision("collision_clip_wall_64x64x10", "collider", (168.71, 1105.1, 461.663), (355, 270, 0));
    spawncollision("collision_clip_wall_64x64x10", "collider", (206.395, 1105.1, 461.663), (355, 270, 0));
    spawncollision("collision_clip_wall_128x128x10", "collider", (715.131, -670.427, 328.242), (345, 0, 0));
    spawncollision("collision_clip_wall_64x64x10", "collider", (821.711, -1403.91, 174.29), (352, 0, 0));
    spawncollision("collision_clip_wall_64x64x10", "collider", (942.562, -2830.5, -98.2362), (328, -72, -5));
    spawncollision("collision_clip_wall_64x64x10", "collider", (957.495, -2877.33, -93.3206), (328, -56, 1));
    spawncollision("collision_clip_wall_64x64x10", "collider", (978.797, -2917.56, -92.7345), (322, -33, 4));
    var_62bd5a1c = spawn("script_model", (-1098.37, 807.149, 77.9892));
    var_62bd5a1c.angles = (0, 232, 0);
    var_62bd5a1c setmodel("p7_can_milk_vintage_metal_painted_white");
    level.cleandepositpoints = array((-353.721, -175.155, 9), (563.775, -119.256, 84.125), (-654.231, -1578.36, -5.74457), (-1059.83, 1145.25, 80));
}

// Namespace mp_infection
// Params 0, eflags: 0x1 linked
// Checksum 0x99ec1590, Offset: 0xe40
// Size: 0x4
function precache() {
    
}

// Namespace mp_infection
// Params 1, eflags: 0x1 linked
// Checksum 0x15fe86b8, Offset: 0xe50
// Size: 0x1ac
function function_c9aa825e(&var_6480c733) {
    if (!isdefined(var_6480c733)) {
        var_6480c733 = [];
    } else if (!isarray(var_6480c733)) {
        var_6480c733 = array(var_6480c733);
    }
    var_6480c733[var_6480c733.size] = (-990, 80, 72);
    if (!isdefined(var_6480c733)) {
        var_6480c733 = [];
    } else if (!isarray(var_6480c733)) {
        var_6480c733 = array(var_6480c733);
    }
    var_6480c733[var_6480c733.size] = (-640, 1020, 93);
    if (!isdefined(var_6480c733)) {
        var_6480c733 = [];
    } else if (!isarray(var_6480c733)) {
        var_6480c733 = array(var_6480c733);
    }
    var_6480c733[var_6480c733.size] = (1810, -517, -13);
    if (!isdefined(var_6480c733)) {
        var_6480c733 = [];
    } else if (!isarray(var_6480c733)) {
        var_6480c733 = array(var_6480c733);
    }
    var_6480c733[var_6480c733.size] = (1139, -2779, -20);
}

// Namespace mp_infection
// Params 1, eflags: 0x1 linked
// Checksum 0x626fd65d, Offset: 0x1008
// Size: 0xdc
function function_7bb6ebae(&var_ef2e1e06) {
    if (!isdefined(var_ef2e1e06)) {
        var_ef2e1e06 = [];
    } else if (!isarray(var_ef2e1e06)) {
        var_ef2e1e06 = array(var_ef2e1e06);
    }
    var_ef2e1e06[var_ef2e1e06.size] = (-350, 1050, 60);
    if (!isdefined(var_ef2e1e06)) {
        var_ef2e1e06 = [];
    } else if (!isarray(var_ef2e1e06)) {
        var_ef2e1e06 = array(var_ef2e1e06);
    }
    var_ef2e1e06[var_ef2e1e06.size] = (-230, 1910, -126);
}

