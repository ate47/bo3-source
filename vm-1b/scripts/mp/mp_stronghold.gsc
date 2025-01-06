#using scripts/codescripts/struct;
#using scripts/mp/_load;
#using scripts/mp/_util;
#using scripts/mp/mp_stronghold_doors;
#using scripts/mp/mp_stronghold_fx;
#using scripts/mp/mp_stronghold_sound;
#using scripts/shared/compass;
#using scripts/shared/util_shared;

#namespace mp_stronghold;

// Namespace mp_stronghold
// Params 0, eflags: 0x0
// Checksum 0xd852562, Offset: 0x198
// Size: 0x95
function main() {
    precache();
    mp_stronghold_fx::main();
    mp_stronghold_sound::main();
    load::main();
    compass::setupminimap("compass_map_mp_stronghold");
    setdvar("compassmaxrange", "2100");
    if (getgametypesetting("allowMapScripting")) {
    }
}

// Namespace mp_stronghold
// Params 0, eflags: 0x0
// Checksum 0xe9c07cd6, Offset: 0x238
// Size: 0x2
function precache() {
    
}

