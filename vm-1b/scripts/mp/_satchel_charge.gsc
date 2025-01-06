#using scripts/codescripts/struct;
#using scripts/mp/_util;
#using scripts/shared/callbacks_shared;
#using scripts/shared/system_shared;
#using scripts/shared/weapons/_satchel_charge;

#namespace satchel_charge;

// Namespace satchel_charge
// Params 0, eflags: 0x2
// Checksum 0xca8c225, Offset: 0x128
// Size: 0x2a
function autoexec function_2dc19561() {
    system::register("satchel_charge", &__init__, undefined, undefined);
}

// Namespace satchel_charge
// Params 0, eflags: 0x0
// Checksum 0x8cebc385, Offset: 0x160
// Size: 0x12
function __init__() {
    init_shared();
}

