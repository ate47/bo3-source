#using scripts/codescripts/struct;
#using scripts/shared/bb_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/system_shared;

#namespace bb;

// Namespace bb
// Params 0, eflags: 0x2
// Checksum 0x5740ce76, Offset: 0xe8
// Size: 0x2a
function autoexec function_2dc19561() {
    system::register("bb", &__init__, undefined, undefined);
}

// Namespace bb
// Params 0, eflags: 0x0
// Checksum 0xffcb801f, Offset: 0x120
// Size: 0x12
function __init__() {
    init_shared();
}

