#using scripts/codescripts/struct;
#using scripts/cp/_util;
#using scripts/shared/callbacks_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/shared/weapons/_hacker_tool;

#namespace hacker_tool;

// Namespace hacker_tool
// Params 0, eflags: 0x2
// Checksum 0xf562d56, Offset: 0x138
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("hacker_tool", &__init__, undefined, undefined);
}

// Namespace hacker_tool
// Params 0, eflags: 0x0
// Checksum 0xe8c5eaf7, Offset: 0x178
// Size: 0x14
function __init__() {
    init_shared();
}

