#using scripts/mp/mp_freerun_03_sound;
#using scripts/mp/mp_freerun_03_fx;
#using scripts/mp/_util;
#using scripts/mp/_load;
#using scripts/shared/util_shared;
#using scripts/codescripts/struct;

#namespace namespace_95f3766e;

// Namespace namespace_95f3766e
// Params 0, eflags: 0x1 linked
// Checksum 0x3bc9dff2, Offset: 0x130
// Size: 0x64
function main() {
    precache();
    namespace_f856db3b::main();
    namespace_ad4c1fb2::main();
    load::main();
    setdvar("compassmaxrange", "2100");
}

// Namespace namespace_95f3766e
// Params 0, eflags: 0x1 linked
// Checksum 0x99ec1590, Offset: 0x1a0
// Size: 0x4
function precache() {
    
}

