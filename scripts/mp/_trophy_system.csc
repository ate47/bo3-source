#using scripts/codescripts/struct;
#using scripts/mp/_util;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/shared/weapons/_trophy_system;

#namespace trophy_system;

// Namespace trophy_system
// Params 0, eflags: 0x2
// Checksum 0x871d602b, Offset: 0x168
// Size: 0x34
function autoexec __init__sytem__()
{
    system::register( "trophy_system", &__init__, undefined, undefined );
}

// Namespace trophy_system
// Params 1
// Checksum 0x9b05f6ab, Offset: 0x1a8
// Size: 0x1c
function __init__( localclientnum )
{
    init_shared();
}

