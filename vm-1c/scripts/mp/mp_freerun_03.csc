#using scripts/mp/mp_freerun_03_sound;
#using scripts/mp/mp_freerun_03_fx;
#using scripts/mp/_util;
#using scripts/mp/_load;
#using scripts/shared/util_shared;
#using scripts/codescripts/struct;

#namespace mp_freerun_03;

// Namespace mp_freerun_03
// Params 0, eflags: 0x1 linked
// Checksum 0x2d395d7a, Offset: 0x140
// Size: 0x8c
function main() {
    mp_freerun_03_fx::main();
    mp_freerun_03_sound::main();
    setdvar("phys_buoyancy", 1);
    setdvar("phys_ragdoll_buoyancy", 1);
    load::main();
    util::waitforclient(0);
}

