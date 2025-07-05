#using scripts/codescripts/struct;
#using scripts/mp/_util;
#using scripts/shared/callbacks_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/shared/weapons/_satchel_charge;

#namespace satchel_charge;

// Namespace satchel_charge
// Params 0, eflags: 0x2
// Checksum 0x7682618, Offset: 0x148
// Size: 0x34
function autoexec __init__sytem__() {
    system::register("satchel_charge", &__init__, undefined, undefined);
}

// Namespace satchel_charge
// Params 1, eflags: 0x0
// Checksum 0xcacfc4d8, Offset: 0x188
// Size: 0x1c
function __init__(localclientnum) {
    init_shared();
}

