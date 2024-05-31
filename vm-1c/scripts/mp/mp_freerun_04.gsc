#using scripts/mp/mp_freerun_04_sound;
#using scripts/mp/mp_freerun_04_fx;
#using scripts/mp/_util;
#using scripts/mp/_load;
#using scripts/shared/util_shared;
#using scripts/codescripts/struct;

#namespace mp_freerun_04;

// Namespace mp_freerun_04
// Params 0, eflags: 0x0
// Checksum 0x175bf9e0, Offset: 0x178
// Size: 0xa4
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
// Checksum 0x99ec1590, Offset: 0x228
// Size: 0x4
function precache() {
    
}

