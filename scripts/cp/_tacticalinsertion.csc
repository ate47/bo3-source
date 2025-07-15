#using scripts/codescripts/struct;
#using scripts/cp/_util;
#using scripts/shared/clientfield_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/shared/weapons/_tacticalinsertion;

#namespace tacticalinsertion;

// Namespace tacticalinsertion
// Params 0, eflags: 0x2
// Checksum 0xf2bd7f23, Offset: 0x150
// Size: 0x34
function autoexec __init__sytem__()
{
    system::register( "tacticalinsertion", &__init__, undefined, undefined );
}

// Namespace tacticalinsertion
// Params 0
// Checksum 0x53c9c700, Offset: 0x190
// Size: 0x14
function __init__()
{
    init_shared();
}

