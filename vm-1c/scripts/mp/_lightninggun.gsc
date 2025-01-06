#using scripts/codescripts/struct;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/system_shared;
#using scripts/shared/weapons/_lightninggun;

#namespace lightninggun;

// Namespace lightninggun
// Params 0, eflags: 0x2
// Checksum 0xf5d8df9b, Offset: 0x130
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("lightninggun", &__init__, undefined, undefined);
}

// Namespace lightninggun
// Params 0, eflags: 0x0
// Checksum 0xd4a86e0e, Offset: 0x170
// Size: 0x14
function __init__() {
    init_shared();
}

