#using scripts/zm/_zm;
#using scripts/shared/ai/zombie_utility;
#using scripts/shared/util_shared;
#using scripts/shared/math_shared;
#using scripts/shared/flagsys_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/array_shared;
#using scripts/codescripts/struct;

#namespace namespace_50c3fea6;

// Namespace namespace_50c3fea6
// Params 0, eflags: 0x1 linked
// namespace_50c3fea6<file_0>::function_8a5375f3
// Checksum 0x4f665b91, Offset: 0x288
// Size: 0x1c
function main_start() {
    level thread function_b620b1d6();
}

// Namespace namespace_50c3fea6
// Params 0, eflags: 0x1 linked
// namespace_50c3fea6<file_0>::function_ead4e420
// Checksum 0x9de33bef, Offset: 0x2b0
// Size: 0x464
function main_end() {
    spawncollision("collision_player_wall_128x128x10", "collider", (9885, 370, -464), (0, 0, 0));
    spawncollision("collision_player_wall_256x256x10", "collider", (10803, 1348, -403), (0, 0, 0));
    spawncollision("collision_player_slick_cylinder_32x256", "collider", (11466, 2531.5, -497.5), (0, 0, 0));
    spawncollision("collision_player_slick_cylinder_32x256", "collider", (11188.5, 2048.5, -493.5), (0, 0, 0));
    spawncollision("collision_player_slick_cylinder_32x256", "collider", (11669, -1209, -472.5), (0, 0, 0));
    spawncollision("collision_player_slick_cylinder_32x256", "collider", (9042.5, 2352, -493.5), (0, 0, 0));
    spawncollision("collision_player_slick_wedge_32x128", "collider", (11275.9, 3016.23, -561), (270, 359.7, 162.397));
    spawncollision("collision_player_slick_wall_512x512x10", "collider", (8507.29, 2104.91, -286), (0, 45.3977, 0));
    spawncollision("collision_player_slick_wall_512x512x10", "collider", (8501.29, 2099.41, -286), (0, 45.3977, 0));
    spawncollision("collision_player_slick_wall_256x256x10", "collider", (8642.89, 1961.76, -405), (0, 45.3978, 0));
    spawncollision("collision_player_slick_wall_256x256x10", "collider", (8852.88, 1832.77, -405), (0, 70.7946, 0));
    spawncollision("collision_player_slick_wall_256x256x10", "collider", (8864.88, 1826.76, -405), (0, 64.3971, 0));
    spawncollision("collision_player_slick_wall_256x256x10", "collider", (9056.33, 1795.77, -405), (0, 106.998, 0));
    spawncollision("collision_player_slick_wall_256x256x10", "collider", (9150.77, 1909.83, -405), (0, 168.697, 0));
    spawncollision("collision_player_slick_wall_256x256x10", "collider", (9103.76, 2038.19, -405), (0, 230.897, 0));
    spawncollision("collision_player_slick_wall_256x256x10", "collider", (8989.21, 2082.68, -405), (0, 276.596, 0));
    spawncollision("collision_player_slick_wall_256x256x10", "collider", (8859.2, 2042.16, -405), (0, 298.195, 0));
    spawncollision("collision_player_slick_wall_256x256x10", "collider", (8786.69, 1996.15, -404), (0, 314.194, 0));
}

// Namespace namespace_50c3fea6
// Params 0, eflags: 0x1 linked
// namespace_50c3fea6<file_0>::function_b620b1d6
// Checksum 0x5ff83a99, Offset: 0x720
// Size: 0x3a
function function_b620b1d6() {
    level flagsys::wait_till("start_zombie_round_logic");
    if (isdefined(level.var_d960a2b6) && level.var_d960a2b6) {
    }
}

