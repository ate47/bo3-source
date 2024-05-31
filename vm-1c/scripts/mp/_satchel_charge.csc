#using scripts/mp/_util;
#using scripts/shared/weapons/_satchel_charge;
#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/callbacks_shared;
#using scripts/codescripts/struct;

#namespace satchel_charge;

// Namespace satchel_charge
// Params 0, eflags: 0x2
// namespace_624f140<file_0>::function_2dc19561
// Checksum 0x7682618, Offset: 0x148
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("satchel_charge", &__init__, undefined, undefined);
}

// Namespace satchel_charge
// Params 1, eflags: 0x1 linked
// namespace_624f140<file_0>::function_8c87d8eb
// Checksum 0xcacfc4d8, Offset: 0x188
// Size: 0x1c
function __init__(localclientnum) {
    init_shared();
}

