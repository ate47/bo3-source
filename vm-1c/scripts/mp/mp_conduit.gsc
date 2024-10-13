#using scripts/mp/mp_conduit_sound;
#using scripts/mp/mp_conduit_fx;
#using scripts/mp/_util;
#using scripts/mp/_load;
#using scripts/shared/compass;
#using scripts/shared/util_shared;
#using scripts/codescripts/struct;

#namespace mp_conduit;

// Namespace mp_conduit
// Params 0, eflags: 0x1 linked
// Checksum 0xa11ad5f5, Offset: 0x268
// Size: 0x4e4
function main() {
    precache();
    mp_conduit_fx::main();
    mp_conduit_sound::main();
    load::main();
    compass::setupminimap("compass_map_mp_conduit");
    setdvar("compassmaxrange", "2100");
    level thread function_d9a32821();
    level function_c4a5736e();
    var_32cbbad9 = spawn("script_model", (-2536.7, -150.932, 44));
    var_32cbbad9.angles = (0, 90, 90);
    var_32cbbad9 setmodel("p7_pallet_metal_military_01");
    var_58ce3542 = spawn("script_model", (-2537.7, -113.432, 44));
    var_58ce3542.angles = (0, 90, 90);
    var_58ce3542 setmodel("p7_pallet_metal_military_01");
    var_7ed0afab = spawn("script_model", (-2552.2, -150.432, 52));
    var_7ed0afab.angles = (0, 90, 90);
    var_7ed0afab setmodel("p7_pallet_metal_military_01");
    var_a4d32a14 = spawn("script_model", (-2553.2, -112.932, 52));
    var_a4d32a14.angles = (0, 90, 90);
    var_a4d32a14 setmodel("p7_pallet_metal_military_01");
    spawncollision("collision_bullet_wall_128x128x10", "collider", (38, -1031.5, 63), (0, 270, 0));
    spawncollision("collision_bullet_wall_128x128x10", "collider", (-57, -1031.5, 63), (0, 270, 0));
    spawncollision("collision_nosight_64x64x64", "collider", (320, 973.5, 82.5), (0, 0, 0));
    spawncollision("collision_nosight_64x64x64", "collider", (-318.5, 973.5, 82.5), (0, 0, 0));
    spawncollision("collision_nosight_32x32x32", "collider", (-576.5, 896, 77), (0, 0, 0));
    spawncollision("collision_nosight_32x32x32", "collider", (-576.5, 896, 98), (0, 0, 0));
    spawncollision("collision_nosight_32x32x32", "collider", (578.5, 899, 77), (0, 0, 0));
    spawncollision("collision_nosight_32x32x32", "collider", (578.5, 899, 98), (0, 0, 0));
    level.cleandepositpoints = array((2.38261, 270.152, 64.125), (1272.74, 958.804, 64.125), (-1235.76, 969.544, 64.125), (868.229, -915.133, -0.875));
}

// Namespace mp_conduit
// Params 0, eflags: 0x1 linked
// Checksum 0x99ec1590, Offset: 0x758
// Size: 0x4
function precache() {
    
}

// Namespace mp_conduit
// Params 0, eflags: 0x1 linked
// Checksum 0xaa5fbe7b, Offset: 0x768
// Size: 0x188
function function_d9a32821() {
    var_2f9b716b = getentarray("conduit_tower", "targetname");
    var_813a45c = var_2f9b716b[0];
    for (;;) {
        pausetime = randomfloatrange(5, 10);
        wait pausetime;
        var_55596a7c = randomfloatrange(-180, -76);
        rotatetime = randomfloatrange(25, 30);
        var_813a45c playsound("amb_tower_start");
        var_813a45c rotateyaw(var_55596a7c, rotatetime, rotatetime / 4, rotatetime / 4);
        var_813a45c playloopsound("amb_tower_loop");
        var_813a45c waittill(#"rotatedone");
        var_813a45c stoploopsound(0.5);
        var_813a45c playsound("amb_tower_stop");
    }
}

// Namespace mp_conduit
// Params 0, eflags: 0x1 linked
// Checksum 0x69e6982f, Offset: 0x8f8
// Size: 0x1be
function function_c4a5736e() {
    var_23bf0ed = getentarray("conduit_train", "targetname");
    var_283e6b56 = getentarray("conduit_train_02", "targetname");
    var_4e40e5bf = getentarray("conduit_train_03", "targetname");
    var_7846a3cc = [];
    var_7846a3cc[0] = var_23bf0ed[0];
    var_7846a3cc[1] = var_283e6b56[0];
    var_7846a3cc[2] = var_4e40e5bf[0];
    startpoints = [];
    endpoints = [];
    for (i = 0; i < 3; i++) {
        startpoints[i] = var_7846a3cc[i] getorigin() + (-15000, 0, 0);
        endpoints[i] = var_7846a3cc[i] getorigin() + (45000, 0, 0);
        thread function_730358f4(var_7846a3cc[i], startpoints[i], endpoints[i]);
    }
}

// Namespace mp_conduit
// Params 3, eflags: 0x1 linked
// Checksum 0xfb1be27c, Offset: 0xac0
// Size: 0xe8
function function_730358f4(train, startpoint, endpoint) {
    while (true) {
        train ghost();
        train.origin = startpoint;
        wait 3;
        train show();
        train moveto(endpoint, 20, 5, 5);
        train playloopsound("amb_train_engine");
        train waittill(#"movedone");
        train stoploopsound(0.05);
    }
}

