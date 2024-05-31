#using scripts/mp/mp_ruins_sound;
#using scripts/mp/mp_ruins_fx;
#using scripts/mp/_util;
#using scripts/mp/_load;
#using scripts/shared/compass;
#using scripts/shared/util_shared;
#using scripts/codescripts/struct;

#namespace namespace_ee9254d2;

// Namespace namespace_ee9254d2
// Params 0, eflags: 0x1 linked
// namespace_ee9254d2<file_0>::function_d290ebfa
// Checksum 0xfe616a9a, Offset: 0x178
// Size: 0x1bc
function main() {
    precache();
    level.var_bb421b36 = 0.5;
    level.rotator_x_offset = 3500;
    level.counter_uav_position_z_offset = 3000;
    level.cuav_map_x_offset = 3700;
    level.uav_z_offset = 3000;
    namespace_7d071377::main();
    namespace_cf0d49e::main();
    load::main();
    compass::setupminimap("compass_map_mp_ruins");
    setdvar("compassmaxrange", "2100");
    spawncollision("collision_bullet_wall_64x64x10", "collider", (-28, -845, -38), (0, 8, 0));
    spawncollision("collision_bullet_wall_64x64x10", "collider", (218.5, -846, -33), (0, 8, 0));
    level.cleandepositpoints = array((-1019.26, 288.645, 128.125), (903.005, -1312.42, 169.069), (655.802, 921.63, 122.651), (-1427.32, -1488.28, 112.125));
}

// Namespace namespace_ee9254d2
// Params 0, eflags: 0x1 linked
// namespace_ee9254d2<file_0>::function_f7046c76
// Checksum 0x99ec1590, Offset: 0x340
// Size: 0x4
function precache() {
    
}

