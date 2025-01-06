#using scripts/codescripts/struct;
#using scripts/mp/_load;
#using scripts/mp/_util;
#using scripts/mp/mp_waterpark_fx;
#using scripts/mp/mp_waterpark_sound;
#using scripts/shared/compass;
#using scripts/shared/util_shared;

#namespace mp_waterpark;

// Namespace mp_waterpark
// Params 0, eflags: 0x0
// Checksum 0xab9a8261, Offset: 0x160
// Size: 0x7a
function main() {
    precache();
    mp_waterpark_fx::main();
    mp_waterpark_sound::main();
    load::main();
    compass::setupminimap("compass_map_mp_waterpark");
    setdvar("compassmaxrange", "2100");
}

// Namespace mp_waterpark
// Params 0, eflags: 0x0
// Checksum 0xe9c07cd6, Offset: 0x1e8
// Size: 0x2
function precache() {
    
}

