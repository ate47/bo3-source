#using scripts/codescripts/struct;
#using scripts/mp/_load;
#using scripts/mp/_util;
#using scripts/mp/mp_aerospace_fx;
#using scripts/mp/mp_aerospace_sound;
#using scripts/shared/compass;
#using scripts/shared/util_shared;

#namespace mp_aerospace;

// Namespace mp_aerospace
// Params 0, eflags: 0x0
// Checksum 0x5d06ec53, Offset: 0x160
// Size: 0xd4
function main() {
    precache();
    level.var_bb421b36 = 0.5;
    level.rotator_x_offset = 3500;
    level.counter_uav_position_z_offset = 3700;
    level.cuav_map_x_offset = 3700;
    level.uav_z_offset = 4500;
    level.var_657b4cf2 = 10;
    level.var_e8668efc = 11;
    mp_aerospace_fx::main();
    mp_aerospace_sound::main();
    load::main();
    compass::setupminimap("compass_map_mp_aerospace");
    setdvar("compassmaxrange", "2100");
}

// Namespace mp_aerospace
// Params 0, eflags: 0x0
// Checksum 0x99ec1590, Offset: 0x240
// Size: 0x4
function precache() {
    
}

