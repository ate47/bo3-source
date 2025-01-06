#using scripts/codescripts/struct;
#using scripts/mp/_load;
#using scripts/mp/_util;
#using scripts/mp/mp_freerun_04_fx;
#using scripts/mp/mp_freerun_04_sound;
#using scripts/shared/util_shared;

#namespace mp_freerun_04;

// Namespace mp_freerun_04
// Params 0, eflags: 0x0
// Checksum 0xfc9bb9a5, Offset: 0x178
// Size: 0xa2
function main() {
    precache();
    mp_freerun_04_fx::main();
    mp_freerun_04_sound::main();
    load::main();
    setdvar("glassMinVelocityToBreakFromJump", "380");
    setdvar("glassMinVelocityToBreakFromWallRun", "180");
    setdvar("compassmaxrange", "2100");
}

// Namespace mp_freerun_04
// Params 0, eflags: 0x0
// Checksum 0xe9c07cd6, Offset: 0x228
// Size: 0x2
function precache() {
    
}

