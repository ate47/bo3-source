#using scripts/cp/_util;
#using scripts/shared/weapons/_satchel_charge;
#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/callbacks_shared;
#using scripts/codescripts/struct;

#namespace satchel_charge;

// Namespace satchel_charge
// Params 0, eflags: 0x2
// Checksum 0x3a9f1375, Offset: 0x148
// Size: 0x34
function function_2dc19561() {
    system::register("satchel_charge", &__init__, undefined, undefined);
}

// Namespace satchel_charge
// Params 1, eflags: 0x1 linked
// Checksum 0x836eb284, Offset: 0x188
// Size: 0x1c
function __init__(localclientnum) {
    init_shared();
}

