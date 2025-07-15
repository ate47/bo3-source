#using scripts/codescripts/struct;
#using scripts/shared/callbacks_shared;
#using scripts/shared/entityheadicons_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;

#namespace entityheadicons;

// Namespace entityheadicons
// Params 0, eflags: 0x2
// Checksum 0xc6887fc6, Offset: 0x130
// Size: 0x34
function autoexec __init__sytem__()
{
    system::register( "entityheadicons", &__init__, undefined, undefined );
}

// Namespace entityheadicons
// Params 0
// Checksum 0xb8629e1e, Offset: 0x170
// Size: 0x14
function __init__()
{
    init_shared();
}

