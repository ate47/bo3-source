#using scripts/mp/mp_freerun_03_sound;
#using scripts/mp/mp_freerun_03_fx;
#using scripts/mp/_util;
#using scripts/mp/_load;
#using scripts/shared/util_shared;
#using scripts/codescripts/struct;

#namespace namespace_95f3766e;

// Namespace namespace_95f3766e
// Params 0, eflags: 0x0
// Checksum 0x1b4fd022, Offset: 0x140
// Size: 0x72
function main() {
    namespace_f856db3b::main();
    namespace_ad4c1fb2::main();
    setdvar("phys_buoyancy", 1);
    setdvar("phys_ragdoll_buoyancy", 1);
    load::main();
    util::waitforclient(0);
}

