#using scripts/codescripts/struct;
#using scripts/mp/_load;
#using scripts/mp/_util;
#using scripts/mp/mp_havoc_fx;
#using scripts/mp/mp_havoc_sound;
#using scripts/shared/compass;
#using scripts/shared/util_shared;

#namespace mp_havoc;

// Namespace mp_havoc
// Params 0, eflags: 0x0
// Checksum 0x5a324e87, Offset: 0x150
// Size: 0x7a
function main() {
    precache();
    mp_havoc_fx::main();
    mp_havoc_sound::main();
    load::main();
    compass::setupminimap("compass_map_mp_havoc");
    setdvar("compassmaxrange", "2100");
}

// Namespace mp_havoc
// Params 0, eflags: 0x0
// Checksum 0xe9c07cd6, Offset: 0x1d8
// Size: 0x2
function precache() {
    
}

