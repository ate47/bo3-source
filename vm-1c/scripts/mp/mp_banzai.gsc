#using scripts/mp/mp_banzai_sound;
#using scripts/mp/mp_banzai_fx;
#using scripts/mp/gametypes/_ball_utils;
#using scripts/mp/_util;
#using scripts/mp/_load;
#using scripts/shared/_oob;
#using scripts/shared/util_shared;
#using scripts/shared/compass;
#using scripts/codescripts/struct;

#namespace mp_banzai;

// Namespace mp_banzai
// Params 0, eflags: 0x1 linked
// Checksum 0x516adaf8, Offset: 0x278
// Size: 0xa34
function main() {
    precache();
    level.update_escort_robot_path = &update_escort_robot_path;
    level.levelkothdisable = [];
    level.levelkothdisable[level.levelkothdisable.size] = spawn("trigger_radius", (1363, -1045.5, -389), 0, 100, 350);
    level.levelkothdisable[level.levelkothdisable.size] = spawn("trigger_radius", (1363, -910, -389), 0, 100, 350);
    level.levelkothdisable[level.levelkothdisable.size] = spawn("trigger_radius", (1363, -780.5, -389), 0, 100, 350);
    level.levelkothdisable[level.levelkothdisable.size] = spawn("trigger_radius", (1363, -453, -389), 0, 100, 350);
    level.levelkothdisable[level.levelkothdisable.size] = spawn("trigger_radius", (1363, -317.5, -389), 0, 100, 350);
    level.levelkothdisable[level.levelkothdisable.size] = spawn("trigger_radius", (1363, -188, -389), 0, 100, 350);
    trigger = spawn("trigger_radius_out_of_bounds", (-45, -4924, -210.5), 0, 1000, 400);
    trigger thread oob::run_oob_trigger();
    trigger = spawn("trigger_radius_out_of_bounds", (1308, -4924, -210.5), 0, 1000, 400);
    trigger thread oob::run_oob_trigger();
    mp_banzai_fx::main();
    mp_banzai_sound::main();
    load::main();
    compass::setupminimap("compass_map_mp_banzai");
    setdvar("compassmaxrange", "2100");
    spawncollision("collision_physics_wall_512x512x10", "collider", (-593, -641, -538), (270, 0, 0));
    spawncollision("collision_physics_wall_512x512x10", "collider", (-904, -1065, -538), (270, 0, 0));
    spawncollision("collision_physics_wall_512x512x10", "collider", (-1097, -553, -538), (270, 0, 0));
    spawncollision("collision_physics_wall_512x512x10", "collider", (-1601.5, -485, -538), (270, 0, 0));
    spawncollision("collision_physics_wall_512x512x10", "collider", (-1610.5, -972, -538), (270, 0, 0));
    spawncollision("collision_physics_wall_512x512x10", "collider", (-1414, -1065, -538), (270, 0, 0));
    spawncollision("collision_physics_wall_512x512x10", "collider", (-2062.5, -1315, -538), (270, 0, 0));
    spawncollision("collision_physics_wall_512x512x10", "collider", (-2062.5, -811, -538), (270, 0, 0));
    spawncollision("collision_physics_wall_512x512x10", "collider", (-2060.5, -313, -538), (270, 0, 0));
    spawncollision("collision_clip_wall_128x128x10", "collider", (903, -563.5, -89.5), (18, 360, 0));
    spawncollision("collision_clip_wall_128x128x10", "collider", (902.5, -685, -89.5), (18, 360, 0));
    spawncollision("collision_clip_wall_128x128x10", "collider", (1301.5, -688, -68.5152), (21, -76, 0));
    spawncollision("collision_clip_wall_128x128x10", "collider", (1302, -561.5, -68.4848), (21, -76, 0));
    spawncollision("collision_clip_wall_128x128x10", "collider", (1270, -530, -10.0151), (17, 359, 0));
    spawncollision("collision_physics_128x128x128", "collider", (2279.5, -493, -102.5), (341, 21, -1));
    spawncollision("collision_physics_128x128x128", "collider", (2389, -450.5, -73), (341.999, 21, -1));
    spawncollision("collision_physics_128x128x128", "collider", (2492, -410.5, -50), (353.899, 21, -4));
    spawncollision("collision_physics_128x128x128", "collider", (2605.5, -366, -38.5), (357, 21, 6));
    spawncollision("collision_physics_128x128x128", "collider", (2723, -320, -32.5), (357, 21, 6));
    spawncollision("collision_physics_128x128x128", "collider", (2292.5, -357, -98), (0, 10, 0));
    spawncollision("collision_physics_128x128x128", "collider", (2407.5, -368, -98), (0, 360, 0));
    spawncollision("collision_physics_128x128x128", "collider", (2516.5, -368, -98), (0, 360, 0));
    spawncollision("collision_clip_wall_64x64x10", "collider", (1260.5, 1724, -252), (0, 270, 0));
    spawncollision("collision_clip_wall_64x64x10", "collider", (1260.5, 1724, -189.5), (0, 270, 0));
    spawncollision("collision_clip_wall_64x64x10", "collider", (1260.5, 1724, -171.5), (0, 270, 0));
    var_3867fdde = spawn("script_model", (2309.41, -550.189, -592.779));
    var_3867fdde.angles = (83, 358, 1);
    var_3867fdde setmodel("p7_ban_rock_cluster_01");
    level.var_c9aa825e = &function_c9aa825e;
    level spawnkilltrigger();
    level.cleandepositpoints = array((1345.41, -628, -319.875), (2762.61, -2015.93, -251.875), (2722.25, -247.549, -511.875), (705.101, 951.137, -295.875));
}

// Namespace mp_banzai
// Params 0, eflags: 0x1 linked
// Checksum 0x99ec1590, Offset: 0xcb8
// Size: 0x4
function precache() {
    
}

// Namespace mp_banzai
// Params 1, eflags: 0x1 linked
// Checksum 0xc128b815, Offset: 0xcc8
// Size: 0xdc
function function_c9aa825e(&var_6480c733) {
    if (!isdefined(var_6480c733)) {
        var_6480c733 = [];
    } else if (!isarray(var_6480c733)) {
        var_6480c733 = array(var_6480c733);
    }
    var_6480c733[var_6480c733.size] = (829, -1115, -517);
    if (!isdefined(var_6480c733)) {
        var_6480c733 = [];
    } else if (!isarray(var_6480c733)) {
        var_6480c733 = array(var_6480c733);
    }
    var_6480c733[var_6480c733.size] = (687, -1457, -459);
}

// Namespace mp_banzai
// Params 0, eflags: 0x1 linked
// Checksum 0x8dfd0abd, Offset: 0xdb0
// Size: 0x74
function spawnkilltrigger() {
    trigger = spawn("trigger_radius", (1274.5, 1676.5, -277.5), 0, 30, -128);
    trigger thread watchkilltrigger();
    ball::function_10ecf402(trigger);
}

// Namespace mp_banzai
// Params 0, eflags: 0x1 linked
// Checksum 0x633cdbc7, Offset: 0xe30
// Size: 0x90
function watchkilltrigger() {
    level endon(#"game_ended");
    trigger = self;
    while (true) {
        player = trigger waittill(#"trigger");
        player dodamage(1000, trigger.origin + (0, 0, 0), trigger, trigger, "none", "MOD_SUICIDE", 0);
    }
}

// Namespace mp_banzai
// Params 1, eflags: 0x1 linked
// Checksum 0x30a098e8, Offset: 0xec8
// Size: 0x44
function update_escort_robot_path(&patharray) {
    arrayinsert(patharray, (2430.69, -363.477, -664.185), 13);
}

