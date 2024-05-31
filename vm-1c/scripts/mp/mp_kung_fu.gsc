#using scripts/mp/mp_kung_fu_sound;
#using scripts/mp/mp_kung_fu_fx;
#using scripts/mp/gametypes/_spawnlogic;
#using scripts/mp/_util;
#using scripts/mp/_load;
#using scripts/shared/compass;
#using scripts/shared/util_shared;
#using scripts/shared/_oob;
#using scripts/codescripts/struct;

#namespace namespace_b4cb0c94;

// Namespace namespace_b4cb0c94
// Params 0, eflags: 0x1 linked
// Checksum 0x4238920b, Offset: 0x2a8
// Size: 0xbe4
function main() {
    precache();
    trigger = spawn("trigger_radius_out_of_bounds", (674, 2622.5, 137.5), 0, 256, 300);
    trigger thread oob::run_oob_trigger();
    namespace_9fa744bd::main();
    namespace_b19eb620::main();
    load::main();
    compass::setupminimap("compass_map_mp_kung_fu");
    setdvar("compassmaxrange", "2100");
    function_8bf0b925("under_bridge", "targetname", 1);
    var_32cbbad9 = spawn("script_model", (-1341.5, 121, 388));
    var_32cbbad9.angles = (0, 0, 0);
    var_32cbbad9 setmodel("p7_kfu_gong_wall_decor");
    var_58ce3542 = spawn("script_model", (-1325, 121, 388));
    var_58ce3542.angles = (0, 0, 0);
    var_58ce3542 setmodel("p7_kfu_gong_wall_decor");
    var_7ed0afab = spawn("script_model", (-1308.5, 121, 388));
    var_7ed0afab.angles = (0, 0, 0);
    var_7ed0afab setmodel("p7_kfu_gong_wall_decor");
    var_a4d32a14 = spawn("script_model", (-1292, 121, 388));
    var_a4d32a14.angles = (0, 0, 0);
    var_a4d32a14 setmodel("p7_kfu_gong_wall_decor");
    var_cad5a47d = spawn("script_model", (-1275.5, 121, 388));
    var_cad5a47d.angles = (0, 0, 0);
    var_cad5a47d setmodel("p7_kfu_gong_wall_decor");
    var_f0d81ee6 = spawn("script_model", (-1259, 121, 388));
    var_f0d81ee6.angles = (0, 0, 0);
    var_f0d81ee6 setmodel("p7_kfu_gong_wall_decor");
    var_16da994f = spawn("script_model", (-1242.5, 121, 388));
    var_16da994f.angles = (0, 0, 0);
    var_16da994f setmodel("p7_kfu_gong_wall_decor");
    var_3cdd13b8 = spawn("script_model", (-1350, 122.25, 391.75));
    var_3cdd13b8.angles = (270, -76, 90);
    var_3cdd13b8 setmodel("p7_kfu_gong_wall_decor");
    var_62df8e21 = spawn("script_model", (-1352, 121.75, 391.75));
    var_62df8e21.angles = (270, -76, 90);
    var_62df8e21 setmodel("p7_kfu_gong_wall_decor");
    var_6f8f7d0b = spawn("script_model", (-1234, 122.25, 391.75));
    var_6f8f7d0b.angles = (90, -76, 90);
    var_6f8f7d0b setmodel("p7_kfu_gong_wall_decor");
    var_498d02a2 = spawn("script_model", (-1232, 121.75, 391.75));
    var_498d02a2.angles = (90, -76, 90);
    var_498d02a2 setmodel("p7_kfu_gong_wall_decor");
    var_32cbbad9 = spawn("script_model", (331, -39.5, 508.5));
    var_32cbbad9.angles = (290, -76, 0);
    var_32cbbad9 setmodel("collision_clip_wall_128x128x10");
    var_58ce3542 = spawn("script_model", (331, -104.5, 508.5));
    var_58ce3542.angles = (290, -76, 0);
    var_58ce3542 setmodel("collision_clip_wall_128x128x10");
    var_7ed0afab = spawn("script_model", (331, -225.5, 508.5));
    var_7ed0afab.angles = (290, -76, 0);
    var_7ed0afab setmodel("collision_clip_wall_128x128x10");
    spawncollision("collision_clip_256x256x256", "collider", (1488, -16, 580), (0, 270, 0));
    spawncollision("collision_clip_256x256x256", "collider", (1488, -208, 580), (0, 270, 0));
    spawncollision("collision_clip_256x256x256", "collider", (1488, -208, 836), (0, 270, 0));
    spawncollision("collision_clip_256x256x256", "collider", (1488, -208, 1092), (0, 270, 0));
    spawncollision("collision_clip_256x256x256", "collider", (1488, -208, 1348), (0, 270, 0));
    spawncollision("collision_clip_wall_32x32x10", "collider", (43.5, 3073, 175.5), (0, 270, 0));
    spawncollision("collision_clip_wall_32x32x10", "collider", (43.5, 3073, -49), (0, 270, 0));
    spawncollision("collision_clip_wall_32x32x10", "collider", (43.5, 3073, 238.5), (0, 270, 0));
    spawncollision("collision_clip_wall_32x32x10", "collider", (43.5, 3073, 270), (0, 270, 0));
    spawncollision("collision_clip_wall_32x32x10", "collider", (43.5, 3073, 300), (0, 270, 0));
    spawncollision("collision_clip_wall_256x256x10", "collider", (-1021, 332.5, 583), (0, 0, 0));
    spawncollision("collision_clip_wall_256x256x10", "collider", (-1021, 332.5, 821), (0, 0, 0));
    spawncollision("collision_clip_wall_256x256x10", "collider", (-1021, 332.5, 1064), (0, 0, 0));
    spawncollision("collision_clip_32x32x32", "collider", (-712, 2387.5, -118), (0, 0, 0));
    spawncollision("collision_clip_32x32x32", "collider", (-712, 2415.5, 141.5), (0, 0, 0));
    spawncollision("collision_clip_32x32x32", "collider", (-733, 2415.5, 141.5), (0, 0, 0));
    spawncollision("collision_clip_wall_128x128x10", "collider", (-808.5, -2795, 250.5), (0, 270, 0));
    spawncollision("collision_clip_wall_128x128x10", "collider", (-808.5, -2795, 319), (0, 270, 0));
    level.cleandepositpoints = array((-776.619, -125.086, 305), (-783.119, -1153.59, 250.68), (1113.38, -123.586, 282.18), (-1258.62, 640.914, 257.18));
    level spawnkilltrigger();
}

// Namespace namespace_b4cb0c94
// Params 0, eflags: 0x1 linked
// Checksum 0x99ec1590, Offset: 0xe98
// Size: 0x4
function precache() {
    
}

// Namespace namespace_b4cb0c94
// Params 3, eflags: 0x1 linked
// Checksum 0x629f07e4, Offset: 0xea8
// Size: 0xe2
function function_8bf0b925(str_value, str_key, b_enable) {
    a_nodes = getnodearray(str_value, str_key);
    foreach (node in a_nodes) {
        if (b_enable) {
            linktraversal(node);
            continue;
        }
        unlinktraversal(node);
    }
}

// Namespace namespace_b4cb0c94
// Params 0, eflags: 0x1 linked
// Checksum 0x4d4edad0, Offset: 0xf98
// Size: 0x5c
function spawnkilltrigger() {
    trigger = spawn("trigger_radius", (3.5, 3155.5, -101), 0, 80, -56);
    trigger thread watchkilltrigger();
}

// Namespace namespace_b4cb0c94
// Params 0, eflags: 0x1 linked
// Checksum 0x7dca3478, Offset: 0x1000
// Size: 0x90
function watchkilltrigger() {
    level endon(#"game_ended");
    trigger = self;
    while (true) {
        player = trigger waittill(#"trigger");
        player dodamage(1000, trigger.origin + (0, 0, 0), trigger, trigger, "none", "MOD_SUICIDE", 0);
    }
}

