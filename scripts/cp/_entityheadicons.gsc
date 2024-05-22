#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/entityheadicons_shared;
#using scripts/shared/callbacks_shared;
#using scripts/codescripts/struct;

#namespace entityheadicons;

// Namespace entityheadicons
// Params 0, eflags: 0x2
// Checksum 0x2608d2ea, Offset: 0x130
// Size: 0x34
function function_2dc19561() {
    system::register("entityheadicons", &__init__, undefined, undefined);
}

// Namespace entityheadicons
// Params 0, eflags: 0x0
// Checksum 0x488c90d2, Offset: 0x170
// Size: 0x14
function __init__() {
    init_shared();
}

