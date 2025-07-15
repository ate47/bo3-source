#using scripts/codescripts/struct;
#using scripts/cp/_util;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/shared/weapons/_tacticalinsertion;

#namespace tacticalinsertion;

// Namespace tacticalinsertion
// Params 0, eflags: 0x2
// Checksum 0x4603914f, Offset: 0x170
// Size: 0x34
function autoexec __init__sytem__()
{
    system::register( "tacticalinsertion", &__init__, undefined, undefined );
}

// Namespace tacticalinsertion
// Params 0
// Checksum 0x4951b24e, Offset: 0x1b0
// Size: 0x14
function __init__()
{
    init_shared();
}

