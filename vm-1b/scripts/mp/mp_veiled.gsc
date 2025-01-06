#using scripts/codescripts/struct;
#using scripts/mp/_load;
#using scripts/mp/_util;
#using scripts/mp/mp_veiled_fx;
#using scripts/mp/mp_veiled_sound;
#using scripts/shared/compass;
#using scripts/shared/scene_shared;
#using scripts/shared/util_shared;

#namespace mp_veiled;

// Namespace mp_veiled
// Params 0, eflags: 0x0
// Checksum 0x55c5809a, Offset: 0x238
// Size: 0x8a
function main() {
    precache();
    mp_veiled_fx::main();
    mp_veiled_sound::main();
    load::main();
    compass::setupminimap("compass_map_mp_veiled");
    setdvar("compassmaxrange", "2100");
    level thread rocket_launch();
}

// Namespace mp_veiled
// Params 0, eflags: 0x0
// Checksum 0xe9c07cd6, Offset: 0x2d0
// Size: 0x2
function precache() {
    
}

// Namespace mp_veiled
// Params 0, eflags: 0x0
// Checksum 0xaae623c7, Offset: 0x2e0
// Size: 0x15a
function rocket_launch() {
    var_c6821b9b = 15;
    var_810de4c4 = 45;
    var_7b825480 = 120;
    var_da509659 = 120;
    wait var_c6821b9b + var_810de4c4;
    var_13d61abf = struct::get("tag_align_rocket_2", "targetname");
    var_13d61abf thread scene::play("p7_fxanim_mp_veiled_rocket_launch_2");
    playsoundatposition("evt_rocket_launch_01", (-4313, 623, 316));
    wait var_7b825480;
    var_a1ceab84 = struct::get("tag_align_rocket_1", "targetname");
    var_a1ceab84 thread scene::play("p7_fxanim_mp_veiled_rocket_launch_1");
    playsoundatposition("evt_rocket_launch_01", (-4313, 623, 316));
    wait var_da509659;
    var_edd3a056 = struct::get("tag_align_rocket_3", "targetname");
    var_edd3a056 thread scene::play("p7_fxanim_mp_veiled_rocket_launch_3");
    playsoundatposition("evt_rocket_launch_01", (-3696, -2879, 322));
}

