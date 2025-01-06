#using scripts/codescripts/struct;
#using scripts/mp/_load;
#using scripts/mp/_util;
#using scripts/mp/mp_conduit_fx;
#using scripts/mp/mp_conduit_sound;
#using scripts/shared/compass;
#using scripts/shared/util_shared;

#namespace mp_conduit;

// Namespace mp_conduit
// Params 0, eflags: 0x0
// Checksum 0x5b1e7c1c, Offset: 0x1e0
// Size: 0xac
function main() {
    precache();
    mp_conduit_fx::main();
    mp_conduit_sound::main();
    load::main();
    compass::setupminimap("compass_map_mp_conduit");
    setdvar("compassmaxrange", "2100");
    level thread function_d9a32821();
    level function_c4a5736e();
}

// Namespace mp_conduit
// Params 0, eflags: 0x0
// Checksum 0x99ec1590, Offset: 0x298
// Size: 0x4
function precache() {
    
}

// Namespace mp_conduit
// Params 0, eflags: 0x0
// Checksum 0x6a09524d, Offset: 0x2a8
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
// Params 0, eflags: 0x0
// Checksum 0x1023f224, Offset: 0x438
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
// Params 3, eflags: 0x0
// Checksum 0xb59d6cfb, Offset: 0x600
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

