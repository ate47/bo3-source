#using scripts/codescripts/struct;
#using scripts/mp/_util;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/system_shared;
#using scripts/shared/weapons/_trophy_system;

#namespace trophy_system;

// Namespace trophy_system
// Params 0, eflags: 0x2
// Checksum 0xd39507ad, Offset: 0x148
// Size: 0x34
function autoexec __init__sytem__()
{
    system::register( "trophy_system", &__init__, undefined, undefined );
}

// Namespace trophy_system
// Params 0
// Checksum 0x9805cffa, Offset: 0x188
// Size: 0x14
function __init__()
{
    init_shared();
}

