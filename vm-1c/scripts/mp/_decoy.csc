#using scripts/codescripts/struct;
#using scripts/shared/callbacks_shared;
#using scripts/shared/system_shared;
#using scripts/shared/weapons/_decoy;

#namespace decoy;

// Namespace decoy
// Params 0, eflags: 0x2
// Checksum 0x39f0f22e, Offset: 0xf8
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("decoy", &__init__, undefined, undefined);
}

// Namespace decoy
// Params 0, eflags: 0x0
// Checksum 0x6ebe3191, Offset: 0x138
// Size: 0x14
function __init__() {
    init_shared();
}

