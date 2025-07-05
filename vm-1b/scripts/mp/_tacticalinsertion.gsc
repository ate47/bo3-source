#using scripts/codescripts/struct;
#using scripts/mp/_util;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/shared/weapons/_tacticalinsertion;

#namespace tacticalinsertion;

// Namespace tacticalinsertion
// Params 0, eflags: 0x2
// Checksum 0x49524660, Offset: 0x170
// Size: 0x2a
function autoexec __init__sytem__() {
    system::register("tacticalinsertion", &__init__, undefined, undefined);
}

// Namespace tacticalinsertion
// Params 0, eflags: 0x0
// Checksum 0xdee306d2, Offset: 0x1a8
// Size: 0x12
function __init__() {
    init_shared();
}

