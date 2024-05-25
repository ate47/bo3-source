#using scripts/mp/mp_freerun_02_sound;
#using scripts/mp/mp_freerun_02_fx;
#using scripts/mp/_util;
#using scripts/mp/_load;
#using scripts/shared/util_shared;
#using scripts/codescripts/struct;

#namespace namespace_bbf5f0d7;

// Namespace namespace_bbf5f0d7
// Params 0, eflags: 0x0
// Checksum 0x1b4fd022, Offset: 0x140
// Size: 0x72
function main() {
    namespace_97daed88::main();
    namespace_e89da2ff::main();
    setdvar("phys_buoyancy", 1);
    setdvar("phys_ragdoll_buoyancy", 1);
    load::main();
    util::waitforclient(0);
}

