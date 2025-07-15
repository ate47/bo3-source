#using scripts/codescripts/struct;
#using scripts/mp/_load;
#using scripts/mp/_util;
#using scripts/mp/mp_freerun_01_fx;
#using scripts/mp/mp_freerun_01_sound;
#using scripts/shared/util_shared;

#namespace mp_freerun_01;

// Namespace mp_freerun_01
// Params 0
// Checksum 0xf21b9a, Offset: 0x140
// Size: 0x8c
function main()
{
    mp_freerun_01_fx::main();
    mp_freerun_01_sound::main();
    setdvar( "phys_buoyancy", 1 );
    setdvar( "phys_ragdoll_buoyancy", 1 );
    load::main();
    util::waitforclient( 0 );
}

