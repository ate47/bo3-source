#using scripts/mp/mp_arena_sound;
#using scripts/mp/mp_arena_fx;
#using scripts/mp/_util;
#using scripts/mp/_load;
#using scripts/shared/compass;
#using scripts/shared/util_shared;
#using scripts/codescripts/struct;

#namespace mp_arena;

// Namespace mp_arena
// Params 0, eflags: 0x1 linked
// Checksum 0x6f25ad22, Offset: 0x278
// Size: 0x87c
function main() {
    precache();
    mp_arena_fx::main();
    mp_arena_sound::main();
    load::main();
    compass::setupminimap("compass_map_mp_arena");
    setdvar("compassmaxrange", "2100");
    spawncollision("collision_bullet_wall_64x64x10", "collider", (942.5, -1440, 166.5), (339, -76, -76));
    spawncollision("collision_bullet_wall_64x64x10", "collider", (942.5, -1450.5, 166.5), (339, -76, -76));
    spawncollision("collision_bullet_wall_64x64x10", "collider", (956.5, -1432, -83), (270, 0, 0));
    spawncollision("collision_bullet_wall_64x64x10", "collider", (956, -1459, -83), (270, 0, 0));
    spawncollision("collision_bullet_wall_64x64x10", "collider", (868, -1526, 167.5), (25, 270, 90));
    spawncollision("collision_bullet_wall_64x64x10", "collider", (856.5, -1526, 167.5), (25, 271, 90));
    spawncollision("collision_bullet_wall_64x64x10", "collider", (870, -1540, -83), (270, 0.2, 0));
    spawncollision("collision_bullet_wall_64x64x10", "collider", (854.5, -1540.5, -83), (270, 0, 0));
    spawncollision("collision_nosight_wall_128x128x10", "collider", (1184, 1052, 152.5), (0, 270, 0));
    spawncollision("collision_nosight_wall_128x128x10", "collider", (1256, 1052, 152.5), (0, 270, 0));
    spawncollision("collision_nosight_wall_128x128x10", "collider", (1384, 1052, 152.5), (0, 270, 0));
    spawncollision("collision_nosight_wall_128x128x10", "collider", (1384, -1052, 152.5), (0, 270, 0));
    spawncollision("collision_nosight_wall_128x128x10", "collider", (1256, -1052, 152.5), (0, 270, 0));
    spawncollision("collision_nosight_wall_128x128x10", "collider", (1184, -1052, 152.5), (0, 270, 0));
    spawncollision("collision_nosight_64x64x128", "collider", (1120, 0, -32), (270, 270, 0));
    spawncollision("collision_nosight_64x64x256", "collider", (1184, 0, -40), (270, 270, 0));
    spawncollision("collision_nosight_64x64x256", "collider", (1056, 0, -40), (270, 270, 0));
    spawncollision("collision_nosight_ramp_256x24", "collider", (924, -62, 161.5), (333.43, 360, -90));
    spawncollision("collision_nosight_ramp_256x24", "collider", (924, 62, 161.5), (27, -76, -90));
    spawncollision("collision_nosight_ramp_64x24", "collider", (788, -62, 99.5), (0, 0, -90));
    spawncollision("collision_nosight_ramp_64x24", "collider", (788, 62, 99.5), (0, -76, -90));
    spawncollision("collision_nosight_wedge_32x128", "collider", (744.5, -10, 120), (0, 0, -90));
    spawncollision("collision_nosight_wedge_32x128", "collider", (744.5, 10, 120), (0, 0, -90));
    spawncollision("collision_bullet_wall_128x128x10", "collider", (443, -1395, 213.5), (0, 270, 0));
    spawncollision("collision_bullet_wall_128x128x10", "collider", (464.5, -1395, 213.5), (0, 270, 0));
    spawncollision("collision_bullet_wall_128x128x10", "collider", (578.5, -1324.5, 213.5), (0, 0, 0));
    var_cad64444 = spawn("script_model", (454, -1387, 227.25));
    var_cad64444.angles = (0, 0, 0);
    var_cad64444 setmodel("p7_ral_monitor_wall_01_flat");
    var_cad64444 setscale(2.06);
    var_3cddb37f = spawn("script_model", (572.5, -1328, -29));
    var_3cddb37f.angles = (0, 90, 0);
    var_3cddb37f setmodel("p7_ral_monitor_wall_01_flat");
    var_3cddb37f setscale(1.71);
    level.cleandepositpoints = array((222.743, -1.71311, 64.125), (317.682, 1532.49, 160.125), (-327.224, -1275.68, 128.125), (1289, -1210.86, 128.125));
}

// Namespace mp_arena
// Params 0, eflags: 0x1 linked
// Checksum 0x99ec1590, Offset: 0xb00
// Size: 0x4
function precache() {
    
}

