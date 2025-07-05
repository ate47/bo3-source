#using scripts/codescripts/struct;
#using scripts/shared/callbacks_shared;
#using scripts/shared/entityheadicons_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;

#namespace entityheadicons;

// Namespace entityheadicons
// Params 0, eflags: 0x2
// Checksum 0x63ac509f, Offset: 0x130
// Size: 0x2a
function autoexec __init__sytem__() {
    system::register("entityheadicons", &__init__, undefined, undefined);
}

// Namespace entityheadicons
// Params 0, eflags: 0x0
// Checksum 0xe8cadab3, Offset: 0x168
// Size: 0x12
function __init__() {
    init_shared();
}

