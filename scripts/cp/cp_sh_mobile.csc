#using scripts/codescripts/struct;
#using scripts/cp/_load;
#using scripts/cp/_safehouse;
#using scripts/cp/_util;
#using scripts/cp/cp_sh_mobile_fx;
#using scripts/cp/cp_sh_mobile_sound;
#using scripts/shared/util_shared;

#namespace cp_sh_mobile;

// Namespace cp_sh_mobile
// Params 0
// Checksum 0xcdc3052b, Offset: 0x130
// Size: 0x4c
function main()
{
    cp_sh_mobile_fx::main();
    cp_sh_mobile_sound::main();
    load::main();
    util::waitforclient( 0 );
}

