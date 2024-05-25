#using scripts/cp/_util;
#using scripts/shared/weapons/_satchel_charge;
#using scripts/shared/system_shared;
#using scripts/shared/callbacks_shared;
#using scripts/codescripts/struct;

#namespace satchel_charge;

// Namespace satchel_charge
// Params 0, eflags: 0x2
// Checksum 0x9d672fd6, Offset: 0x128
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("satchel_charge", &__init__, undefined, undefined);
}

// Namespace satchel_charge
// Params 0, eflags: 0x1 linked
// Checksum 0x5da61bd0, Offset: 0x168
// Size: 0x14
function __init__() {
    init_shared();
}

