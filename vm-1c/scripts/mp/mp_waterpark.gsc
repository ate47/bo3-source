#using scripts/mp/mp_waterpark_sound;
#using scripts/mp/mp_waterpark_fx;
#using scripts/mp/_util;
#using scripts/mp/_load;
#using scripts/shared/compass;
#using scripts/shared/util_shared;
#using scripts/codescripts/struct;

#namespace namespace_89648a;

// Namespace namespace_89648a
// Params 0, eflags: 0x1 linked
// namespace_89648a<file_0>::function_d290ebfa
// Checksum 0xe7dc5d45, Offset: 0x238
// Size: 0xe04
function main() {
    precache();
    namespace_3844b55f::main();
    namespace_2a685566::main();
    load::main();
    compass::setupminimap("compass_map_mp_waterpark");
    setdvar("compassmaxrange", "2100");
    spawncollision("collision_clip_wall_128x128x10", "collider", (682.63, -472.62, 24.3753), (31, 315, 3));
    spawncollision("collision_clip_wall_128x128x10", "collider", (697.67, -487.401, 47.605), (29, 315, 3));
    spawncollision("collision_clip_wall_256x256x10", "collider", (1340.96, -1073.66, 162.059), (270, 0, 0));
    spawncollision("collision_clip_wall_256x256x10", "collider", (1185.96, -1073.66, 162.059), (270, 0, 0));
    spawncollision("collision_clip_ramp_128x24", "collider", (-38.1338, 361.263, 197.18), (0, 341, 90));
    spawncollision("collision_clip_ramp_128x24", "collider", (39.6908, 343.342, 197.18), (0, 0, 90));
    spawncollision("collision_clip_ramp_128x24", "collider", (124.1, 363.034, 197.18), (0, 23, 90));
    spawncollision("collision_clip_wall_128x128x10", "collider", (297.336, -372.119, 35.6119), (0, 315, 0));
    spawncollision("collision_clip_wall_128x128x10", "collider", (271.736, -390.039, 35.6119), (0, 311, 0));
    spawncollision("collision_clip_wall_128x128x10", "collider", (217.336, -425.879, 35.6119), (0, 301, 0));
    spawncollision("collision_clip_wall_128x128x10", "collider", (168.056, -447.639, 35.6119), (0, 290, 0));
    spawncollision("collision_clip_wall_128x128x10", "collider", (111.096, -464.919, 35.6119), (0, 284, 0));
    spawncollision("collision_clip_wall_128x128x10", "collider", (30.4565, -468.119, 35.6119), (0, 270, 0));
    spawncollision("collision_clip_wall_128x128x10", "collider", (-60.4235, -450.199, 35.6119), (0, 254, 0));
    spawncollision("collision_clip_wall_128x128x10", "collider", (-132.743, -418.199, 35.6119), (0, 241, 0));
    spawncollision("collision_clip_wall_128x128x10", "collider", (-189.063, -379.159, 35.6119), (0, 232, 0));
    spawncollision("collision_clip_64x64x64", "collider", (-95.0828, -271.614, 32.3794), (0, 319, 0));
    spawncollision("collision_clip_64x64x64", "collider", (156.222, -291.337, 32.3794), (0, 28, 0));
    spawncollision("collision_clip_64x64x64", "collider", (-47.4087, -303.681, 32.3794), (0, 332, 0));
    spawncollision("collision_clip_64x64x64", "collider", (-8.46264, -318.407, 32.3794), (0, 346, 0));
    spawncollision("collision_clip_64x64x64", "collider", (47.9912, -327.152, 32.3794), (0, 0, 0));
    spawncollision("collision_clip_64x64x64", "collider", (99.3207, -319.979, 32.3794), (0, 13, 0));
    spawncollision("collision_clip_64x64x64", "collider", (149.669, -297.072, 32.3794), (0, 28, 0));
    spawncollision("collision_clip_64x64x64", "collider", (198.636, -261.734, 32.3794), (0, 319, 0));
    spawncollision("collision_clip_wall_256x256x10", "collider", (811.8, -601.469, 156.614), (0, 247, 0));
    spawncollision("collision_clip_wall_256x256x10", "collider", (899, -635.869, 156.614), (0, 253, 0));
    spawncollision("collision_clip_wall_256x256x10", "collider", (1031.8, -662.269, 156.614), (0, 269, 0));
    spawncollision("collision_clip_wall_128x128x10", "collider", (1215.99, -642.639, 174.161), (0, 289, 0));
    spawncollision("collision_clip_wall_128x128x10", "collider", (1309.17, -599.571, 212.246), (0, 302, 0));
    spawncollision("collision_clip_wall_128x128x10", "collider", (1401.97, -529.171, 212.246), (0, 310, 0));
    spawncollision("collision_clip_wall_128x128x10", "collider", (1485.97, -450.771, 212.246), (0, 314, 0));
    spawncollision("collision_clip_wall_128x128x10", "collider", (1575.57, -359.571, 212.246), (0, 315, 0));
    spawncollision("collision_clip_wall_128x128x10", "collider", (910.718, -403.754, 184.322), (0, 240, 0));
    spawncollision("collision_clip_wall_128x128x10", "collider", (995.385, -433.395, 199.459), (0, 261, 0));
    spawncollision("collision_clip_wall_128x128x10", "collider", (1092.89, -437.237, 201.486), (0, 278, 0));
    spawncollision("collision_clip_wall_128x128x10", "collider", (1199.26, -390.207, 212.246), (0, 305, 0));
    spawncollision("collision_clip_wall_128x128x10", "collider", (1265.13, -328.8, 212.246), (0, 313, 0));
    spawncollision("collision_clip_wall_128x128x10", "collider", (1341.72, -252.764, 212.246), (0, 315, 0));
    spawncollision("collision_clip_wall_128x128x10", "collider", (-656.104, -395.497, 314.493), (14, -19, -8));
    spawncollision("collision_clip_wall_32x32x10", "collider", (2125.05, -230.13, 210.207), (354, 0, 0));
    spawncollision("collision_clip_wall_64x64x10", "collider", (818.665, -356.055, 63.9413), (40, 315, -7));
    spawncollision("collision_clip_wall_64x64x10", "collider", (795.318, -384.727, 63.9413), (40, 315, -7));
    spawncollision("collision_clip_wall_128x128x10", "collider", (1848.33, 205.403, 114.85), (0, 0, 0));
    spawncollision("collision_clip_wall_128x128x10", "collider", (1848.33, 205.403, 212.236), (0, 0, 0));
    spawncollision("collision_clip_wall_64x64x10", "collider", (560.5, 1691, 251.5), (4, 0, 0));
    spawncollision("collision_clip_wall_128x128x10", "collider", (-2787.5, -344, 32), (0, 0, 0));
    spawncollision("collision_clip_wall_128x128x10", "collider", (-2787.5, -424, 32), (0, 0, 0));
    level.cleandepositpoints = array((41.6461, 236.388, -11.875), (1268.4, -1049.63, 12.125), (-174.571, 1433.6, 36.8932), (-1134.93, -430.598, 125.125));
    level spawnkilltrigger();
}

// Namespace namespace_89648a
// Params 0, eflags: 0x1 linked
// namespace_89648a<file_0>::function_f7046c76
// Checksum 0x99ec1590, Offset: 0x1048
// Size: 0x4
function precache() {
    
}

// Namespace namespace_89648a
// Params 0, eflags: 0x1 linked
// namespace_89648a<file_0>::function_ad0d8732
// Checksum 0x25588a5a, Offset: 0x1058
// Size: 0x37c
function spawnkilltrigger() {
    trigger = spawn("trigger_radius", (-78.2163, -252.27, -33.2348), 0, 50, -128);
    trigger thread watchkilltrigger();
    trigger = spawn("trigger_radius", (28.5259, -220.813, -19.6283), 0, 125, -128);
    trigger thread watchkilltrigger();
    trigger = spawn("trigger_radius", (164.922, -247.027, -29.9134), 0, 50, -128);
    trigger thread watchkilltrigger();
    trigger = spawn("trigger_radius", (56.051, -221.468, -29.9134), 0, 125, -128);
    trigger thread watchkilltrigger();
    trigger = spawn("trigger_radius", (-201.964, -534.052, -25.5276), 0, 125, -56);
    trigger thread watchkilltrigger();
    trigger = spawn("trigger_radius", (-60.8686, -583.028, -25.5276), 0, 125, -56);
    trigger thread watchkilltrigger();
    trigger = spawn("trigger_radius", (81.691, -595.348, -25.5276), 0, 125, -56);
    trigger thread watchkilltrigger();
    trigger = spawn("trigger_radius", (232.691, -556.348, -25.5276), 0, 125, -56);
    trigger thread watchkilltrigger();
    trigger = spawn("trigger_radius", (321.691, -524.348, -25.5276), 0, 125, -56);
    trigger thread watchkilltrigger();
    trigger = spawn("trigger_radius", (1003.01, -552.034, 267.349), 0, -56, -128);
    trigger thread watchkilltrigger();
    trigger = spawn("trigger_radius", (1313.41, -491.234, 267.349), 0, -56, -128);
    trigger thread watchkilltrigger();
}

// Namespace namespace_89648a
// Params 0, eflags: 0x1 linked
// namespace_89648a<file_0>::function_3a85dbfe
// Checksum 0x8162920f, Offset: 0x13e0
// Size: 0x90
function watchkilltrigger() {
    level endon(#"game_ended");
    trigger = self;
    while (true) {
        player = trigger waittill(#"trigger");
        player dodamage(1000, trigger.origin + (0, 0, 0), trigger, trigger, "none", "MOD_SUICIDE", 0);
    }
}

