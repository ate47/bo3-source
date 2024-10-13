#using scripts/mp/mp_freerun_02_sound;
#using scripts/mp/mp_freerun_02_fx;
#using scripts/mp/_util;
#using scripts/mp/_load;
#using scripts/shared/util_shared;
#using scripts/codescripts/struct;

#namespace mp_freerun_02;

// Namespace mp_freerun_02
// Params 0, eflags: 0x0
// Checksum 0x14b6208c, Offset: 0x130
// Size: 0x62
function main() {
    precache();
    mp_freerun_02_fx::main();
    mp_freerun_02_sound::main();
    load::main();
    setdvar("compassmaxrange", "2100");
}

// Namespace mp_freerun_02
// Params 0, eflags: 0x0
// Checksum 0xe9c07cd6, Offset: 0x1a0
// Size: 0x2
function precache() {
    
}

