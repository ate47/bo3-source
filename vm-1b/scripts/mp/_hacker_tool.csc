#using scripts/codescripts/struct;
#using scripts/shared/callbacks_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/shared/weapons/_hacker_tool;

#namespace hacker_tool;

// Namespace hacker_tool
// Params 0, eflags: 0x2
// Checksum 0x36a1daec, Offset: 0x128
// Size: 0x2a
function autoexec function_2dc19561() {
    system::register("hacker_tool", &__init__, undefined, undefined);
}

// Namespace hacker_tool
// Params 0, eflags: 0x0
// Checksum 0xa6bfe883, Offset: 0x160
// Size: 0x12
function __init__() {
    init_shared();
}

