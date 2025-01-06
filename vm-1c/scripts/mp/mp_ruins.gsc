#using scripts/codescripts/struct;
#using scripts/mp/_load;
#using scripts/mp/_util;
#using scripts/mp/mp_ruins_fx;
#using scripts/mp/mp_ruins_sound;
#using scripts/shared/compass;
#using scripts/shared/util_shared;

#namespace mp_ruins;

// Namespace mp_ruins
// Params 0, eflags: 0x0
// Checksum 0x9871c4a4, Offset: 0x150
// Size: 0x13c
function main() {
    precache();
    level.var_bb421b36 = 0.5;
    level.rotator_x_offset = 3500;
    level.counter_uav_position_z_offset = 3000;
    level.cuav_map_x_offset = 3700;
    level.uav_z_offset = 3000;
    mp_ruins_fx::main();
    mp_ruins_sound::main();
    load::main();
    compass::setupminimap("compass_map_mp_ruins");
    setdvar("compassmaxrange", "2100");
    level.cleandepositpoints = array((-1019.26, 288.645, 128.125), (903.005, -1312.42, 169.069), (655.802, 921.63, 122.651), (-1427.32, -1488.28, 112.125));
}

// Namespace mp_ruins
// Params 0, eflags: 0x0
// Checksum 0x99ec1590, Offset: 0x298
// Size: 0x4
function precache() {
    
}

