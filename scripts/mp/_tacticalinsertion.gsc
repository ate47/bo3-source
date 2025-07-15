#using scripts/codescripts/struct;
#using scripts/mp/_util;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/shared/weapons/_tacticalinsertion;

#namespace tacticalinsertion;

// Namespace tacticalinsertion
// Params 0, eflags: 0x2
// Checksum 0x783af9b6, Offset: 0x170
// Size: 0x34
function autoexec __init__sytem__()
{
    system::register( "tacticalinsertion", &__init__, undefined, undefined );
}

// Namespace tacticalinsertion
// Params 0
// Checksum 0xdb1e9492, Offset: 0x1b0
// Size: 0x14
function __init__()
{
    init_shared();
}

