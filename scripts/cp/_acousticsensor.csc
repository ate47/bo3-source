#using scripts/codescripts/struct;
#using scripts/cp/_util;
#using scripts/shared/callbacks_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/shared/weapons/_acousticsensor;

#namespace acousticsensor;

// Namespace acousticsensor
// Params 0, eflags: 0x2
// Checksum 0x41db868, Offset: 0x148
// Size: 0x34
function autoexec __init__sytem__()
{
    system::register( "acousticsensor", &__init__, undefined, undefined );
}

// Namespace acousticsensor
// Params 0
// Checksum 0xc062847f, Offset: 0x188
// Size: 0x14
function __init__()
{
    init_shared();
}

