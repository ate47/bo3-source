#using scripts/cp/_util;
#using scripts/shared/weapons/_tacticalinsertion;
#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/callbacks_shared;
#using scripts/codescripts/struct;

#namespace tacticalinsertion;

// Namespace tacticalinsertion
// Params 0, eflags: 0x2
// Checksum 0x4603914f, Offset: 0x170
// Size: 0x34
function function_2dc19561() {
    system::register("tacticalinsertion", &__init__, undefined, undefined);
}

// Namespace tacticalinsertion
// Params 0, eflags: 0x1 linked
// Checksum 0x4951b24e, Offset: 0x1b0
// Size: 0x14
function __init__() {
    init_shared();
}

