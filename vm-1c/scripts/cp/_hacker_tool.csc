#using scripts/codescripts/struct;
#using scripts/shared/callbacks_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/shared/weapons/_hacker_tool;

#namespace hacker_tool;

// Namespace hacker_tool
// Params 0, eflags: 0x2
// Checksum 0x7c8fc578, Offset: 0x128
// Size: 0x34
function autoexec __init__sytem__() {
    system::register("hacker_tool", &__init__, undefined, undefined);
}

// Namespace hacker_tool
// Params 0, eflags: 0x0
// Checksum 0xc5712494, Offset: 0x168
// Size: 0x14
function __init__() {
    init_shared();
}

