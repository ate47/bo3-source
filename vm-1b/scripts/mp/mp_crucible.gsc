#using scripts/codescripts/struct;
#using scripts/mp/_load;
#using scripts/mp/_util;
#using scripts/mp/mp_crucible_fx;
#using scripts/mp/mp_crucible_sound;
#using scripts/shared/compass;
#using scripts/shared/util_shared;

#namespace mp_crucible;

// Namespace mp_crucible
// Params 0, eflags: 0x0
// Checksum 0x628608b3, Offset: 0x160
// Size: 0x7a
function main() {
    precache();
    mp_crucible_fx::main();
    mp_crucible_sound::main();
    load::main();
    compass::setupminimap("compass_map_mp_crucible");
    setdvar("compassmaxrange", "2100");
}

// Namespace mp_crucible
// Params 0, eflags: 0x0
// Checksum 0xe9c07cd6, Offset: 0x1e8
// Size: 0x2
function precache() {
    
}

