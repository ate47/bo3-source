#using scripts/codescripts/struct;
#using scripts/mp/_load;
#using scripts/mp/_util;
#using scripts/mp/mp_crucible_fx;
#using scripts/mp/mp_crucible_sound;
#using scripts/shared/compass;
#using scripts/shared/util_shared;

#namespace mp_crucible;

// Namespace mp_crucible
// Params 0
// Checksum 0x9760110c, Offset: 0x240
// Size: 0xcac
function main()
{
    precache();
    mp_crucible_fx::main();
    mp_crucible_sound::main();
    load::main();
    compass::setupminimap( "compass_map_mp_crucible" );
    setdvar( "compassmaxrange", "2100" );
    spawncollision( "collision_clip_wall_256x256x10", "collider", ( -1084.06, 231.702, 176.581 ), ( 90, 270, 0 ) );
    spawncollision( "collision_clip_wall_256x256x10", "collider", ( -1275.31, 231.702, 176.581 ), ( 90, 270, 0 ) );
    spawncollision( "collision_clip_wall_256x256x10", "collider", ( -1275.31, 342.952, 176.581 ), ( 90, 270, 0 ) );
    spawncollision( "collision_bullet_wall_128x128x10", "collider", ( -1363.79, -1599.62, 104.208 ), ( 0, 0, 0 ) );
    spawncollision( "collision_bullet_wall_128x128x10", "collider", ( -1257.45, 395.807, 104.208 ), ( 0, 0, 0 ) );
    spawncollision( "collision_physics_wall_64x64x10", "collider", ( -940.687, -1467.01, 113.258 ), ( 0, 270, 0 ) );
    spawncollision( "collision_physics_wall_64x64x10", "collider", ( -1012.37, -1467.01, 113.258 ), ( 0, 270, 0 ) );
    spawncollision( "collision_physics_wall_64x64x10", "collider", ( -1168.68, -1467.01, 113.258 ), ( 0, 270, 0 ) );
    spawncollision( "collision_physics_wall_64x64x10", "collider", ( -1084.4, -1467.01, 113.258 ), ( 0, 270, 0 ) );
    spawncollision( "collision_physics_wall_64x64x10", "collider", ( -1084.4, -1467.01, 69.3392 ), ( 0, 270, 0 ) );
    spawncollision( "collision_clip_wall_64x64x64", "collider", ( -984.838, 121.991, 71.4512 ), ( 0, 0, 0 ) );
    spawncollision( "collision_clip_wall_64x64x64", "collider", ( -984.838, 121.991, 134.393 ), ( 0, 0, 0 ) );
    spawncollision( "collision_clip_wall_64x64x64", "collider", ( -1359.26, 113.53, 134.393 ), ( 0, 0, 0 ) );
    spawncollision( "collision_clip_wall_64x64x64", "collider", ( -1359.26, 113.53, 71.4512 ), ( 0, 0, 0 ) );
    spawncollision( "collision_clip_wall_64x64x64", "collider", ( -1384.53, 113.53, 134.393 ), ( 0, 0, 0 ) );
    spawncollision( "collision_clip_wall_64x64x64", "collider", ( -1384.53, 113.53, 71.4512 ), ( 0, 0, 0 ) );
    spawncollision( "collision_clip_256x256x256", "collider", ( 2041.65, 568.795, 741.57 ), ( 0, 0, 0 ) );
    spawncollision( "collision_clip_256x256x256", "collider", ( 2041.65, 314.558, 741.569 ), ( 0, 0, 0 ) );
    spawncollision( "collision_clip_256x256x256", "collider", ( 2041.65, 60.9527, 741.569 ), ( 0, 0, 0 ) );
    spawncollision( "collision_clip_256x256x256", "collider", ( 2041.65, -193.284, 741.569 ), ( 0, 0, 0 ) );
    spawncollision( "collision_clip_256x256x256", "collider", ( 2041.65, -443.371, 741.569 ), ( 0, 0, 0 ) );
    spawncollision( "collision_clip_256x256x256", "collider", ( 2041.65, 568.795, 506.233 ), ( 0, 0, 0 ) );
    spawncollision( "collision_clip_256x256x256", "collider", ( 2041.65, 314.558, 506.232 ), ( 0, 0, 0 ) );
    spawncollision( "collision_clip_256x256x256", "collider", ( 2041.65, 314.558, 506.232 ), ( 0, 0, 0 ) );
    spawncollision( "collision_clip_256x256x256", "collider", ( 2041.65, -193.284, 506.232 ), ( 0, 0, 0 ) );
    spawncollision( "collision_clip_256x256x256", "collider", ( 2041.65, -443.371, 506.232 ), ( 0, 0, 0 ) );
    model1 = spawn( "script_model", ( -1359.51, 122.529, 94.9997 ) );
    model1 setmodel( "p7_crate_plastic_tech_01" );
    model1.angles = ( 0, 101, 0 );
    model2 = spawn( "script_model", ( -1363.91, 121.69, 69.2893 ) );
    model2 setmodel( "p7_crate_plastic_tech_01" );
    model2.angles = ( 0, 101, 0 );
    model3 = spawn( "script_model", ( -1363.48, 118.246, 44.9548 ) );
    model3 setmodel( "p7_crate_plastic_tech_01" );
    model3.angles = ( 0, 270, 0 );
    spawncollision( "collision_clip_wall_256x256x10", "collider", ( -684.024, 1118.78, 521.546 ), ( 5, 0, 0 ) );
    spawncollision( "collision_clip_wall_256x256x10", "collider", ( -684.024, 1370.74, 521.546 ), ( 5, 0, 0 ) );
    spawncollision( "collision_clip_wall_256x256x10", "collider", ( -684.024, 1460.49, 521.546 ), ( 5, 0, 0 ) );
    spawncollision( "collision_clip_wall_256x256x10", "collider", ( -616.843, -1442.68, 514.867 ), ( 5, 0, 0 ) );
    spawncollision( "collision_clip_wall_256x256x10", "collider", ( -616.843, -1692.97, 514.867 ), ( 5, 0, 0 ) );
    spawncollision( "collision_clip_wall_256x256x10", "collider", ( -616.843, -1943.11, 514.867 ), ( 5, 0, 0 ) );
    spawncollision( "collision_clip_64x64x64", "collider", ( -1343.21, -1090.05, 215.312 ), ( 344, 0, 0 ) );
    spawncollision( "collision_clip_64x64x64", "collider", ( -1343.21, -806.046, 215.312 ), ( 344, 0, 0 ) );
    spawncollision( "collision_clip_64x64x64", "collider", ( -1343.21, -522.046, 215.312 ), ( 344, 0, 0 ) );
    spawncollision( "collision_clip_64x64x64", "collider", ( -1343.21, -232.046, 215.312 ), ( 344, 0, 0 ) );
    spawncollision( "collision_clip_256x256x256", "collider", ( -1323.56, 89.3979, 261.726 ), ( 0, 0, 0 ) );
    spawncollision( "collision_clip_256x256x256", "collider", ( -1323.56, 89.3979, 382.494 ), ( 0, 0, 0 ) );
    spawncollision( "collision_clip_256x256x256", "collider", ( -1323.56, 89.3979, 503.236 ), ( 0, 0, 0 ) );
    level.cleandepositpoints = array( ( 45.3433, -262.815, 148.125 ), ( -998.58, -772.263, 40.125 ), ( -857.997, 719.979, 33.625 ), ( 1402.7, -1330.99, 32.125 ) );
}

// Namespace mp_crucible
// Params 0
// Checksum 0x99ec1590, Offset: 0xef8
// Size: 0x4
function precache()
{
    
}

