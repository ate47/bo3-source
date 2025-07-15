#using scripts/codescripts/struct;
#using scripts/cp/_util;
#using scripts/shared/callbacks_shared;
#using scripts/shared/system_shared;
#using scripts/shared/weapons/_satchel_charge;

#namespace satchel_charge;

// Namespace satchel_charge
// Params 0, eflags: 0x2
// Checksum 0x9d672fd6, Offset: 0x128
// Size: 0x34
function autoexec __init__sytem__()
{
    system::register( "satchel_charge", &__init__, undefined, undefined );
}

// Namespace satchel_charge
// Params 0
// Checksum 0x5da61bd0, Offset: 0x168
// Size: 0x14
function __init__()
{
    init_shared();
}

