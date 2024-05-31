#using scripts/mp/mp_freerun_01_sound;
#using scripts/mp/mp_freerun_01_fx;
#using scripts/mp/_util;
#using scripts/mp/_load;
#using scripts/shared/util_shared;
#using scripts/codescripts/struct;

#namespace namespace_49ee819c;

// Namespace namespace_49ee819c
// Params 0, eflags: 0x0
// namespace_49ee819c<file_0>::function_d290ebfa
// Checksum 0xf21b9a, Offset: 0x140
// Size: 0x8c
function main() {
    namespace_b046f355::main();
    namespace_db5bc658::main();
    setdvar("phys_buoyancy", 1);
    setdvar("phys_ragdoll_buoyancy", 1);
    load::main();
    util::waitforclient(0);
}

