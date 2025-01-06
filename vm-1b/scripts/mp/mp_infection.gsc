#using scripts/codescripts/struct;
#using scripts/mp/_load;
#using scripts/mp/_util;
#using scripts/mp/mp_infection_fx;
#using scripts/mp/mp_infection_sound;
#using scripts/shared/compass;
#using scripts/shared/util_shared;

#namespace mp_infection;

// Namespace mp_infection
// Params 0, eflags: 0x0
// Checksum 0x22550b75, Offset: 0x160
// Size: 0xba
function main() {
    precache();
    level.var_bb421b36 = 0.5;
    level.rotator_x_offset = 3500;
    level.counter_uav_position_z_offset = 3700;
    level.cuav_map_x_offset = 3700;
    level.uav_z_offset = 4500;
    mp_infection_fx::main();
    mp_infection_sound::main();
    load::main();
    compass::setupminimap("compass_map_mp_infection");
    setdvar("compassmaxrange", "2100");
}

// Namespace mp_infection
// Params 0, eflags: 0x0
// Checksum 0xe9c07cd6, Offset: 0x228
// Size: 0x2
function precache() {
    
}

