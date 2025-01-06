#using scripts/codescripts/struct;
#using scripts/mp/_load;
#using scripts/mp/_util;
#using scripts/mp/mp_shrine_fx;
#using scripts/mp/mp_shrine_sound;
#using scripts/shared/compass;
#using scripts/shared/scene_shared;
#using scripts/shared/util_shared;

#namespace mp_shrine;

// Namespace mp_shrine
// Params 0, eflags: 0x0
// Checksum 0x8b8bb2ce, Offset: 0x188
// Size: 0x134
function main() {
    precache();
    mp_shrine_fx::main();
    mp_shrine_sound::main();
    compass::setupminimap("compass_map_mp_shrine");
    load::main();
    setdvar("compassmaxrange", "2100");
    level.cleandepositpoints = array((-34.8423, 496.19, -160.136), (-436.008, -1438.99, 99), (-1446.79, 331.569, -21.875), (1268.65, -1219.36, 82.2472));
    function_19a0648();
    /#
        level thread updatedvars();
    #/
    level thread function_83e6bfad();
}

// Namespace mp_shrine
// Params 0, eflags: 0x0
// Checksum 0x99ec1590, Offset: 0x2c8
// Size: 0x4
function precache() {
    
}

// Namespace mp_shrine
// Params 0, eflags: 0x0
// Checksum 0xa19c66a5, Offset: 0x2d8
// Size: 0x84
function function_19a0648() {
    level.var_c86c4a33 = [];
    level.var_5664daf8 = [];
    for (i = 1; i <= 7; i++) {
        level.var_c86c4a33[level.var_c86c4a33.size] = "dragon_a_" + i;
        level.var_5664daf8[level.var_5664daf8.size] = "dragon_b_" + i;
    }
}

/#

    // Namespace mp_shrine
    // Params 0, eflags: 0x0
    // Checksum 0xfb9fa332, Offset: 0x368
    // Size: 0x98
    function updatedvars() {
        level.var_9d27b884 = 0;
        level.var_bab0430d = 0;
        while (true) {
            level.var_bab0430d = getdvarint("<dev string:x28>", level.var_bab0430d);
            if (level.var_bab0430d && !level.var_9d27b884) {
                function_aa8f2924();
            }
            wait 1;
            level.var_9d27b884 = level.var_bab0430d;
        }
    }

#/

// Namespace mp_shrine
// Params 0, eflags: 0x0
// Checksum 0xd7c06b02, Offset: 0x408
// Size: 0x12a
function function_aa8f2924() {
    if (isdefined(level.var_c86c4a33)) {
        foreach (dragon in level.var_c86c4a33) {
            thread scene::play(dragon);
        }
    }
    if (isdefined(level.var_5664daf8)) {
        foreach (dragon in level.var_5664daf8) {
            thread scene::play(dragon);
        }
    }
}

// Namespace mp_shrine
// Params 0, eflags: 0x0
// Checksum 0x17788568, Offset: 0x540
// Size: 0x10c
function function_83e6bfad() {
    var_54a18c50 = randomfloat(1);
    if (0.4 > var_54a18c50) {
        if (isdefined(level.var_c86c4a33) && level.var_c86c4a33.size > 0) {
            var_5a3eff2d = randomint(level.var_c86c4a33.size);
            thread scene::play(level.var_c86c4a33[var_5a3eff2d]);
        }
        if (isdefined(level.var_5664daf8) && level.var_5664daf8.size > 0) {
            var_80417996 = randomint(level.var_5664daf8.size);
            thread scene::play(level.var_5664daf8[var_80417996]);
        }
    }
}

