#using scripts/codescripts/struct;
#using scripts/shared/callbacks_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/shared/weapons/_bouncingbetty;
#using scripts/zm/_util;

#namespace bouncingbetty;

// Namespace bouncingbetty
// Params 0, eflags: 0x2
// Checksum 0xf3074eed, Offset: 0x148
// Size: 0x34
function autoexec __init__sytem__() {
    system::register("bouncingbetty", &__init__, undefined, undefined);
}

// Namespace bouncingbetty
// Params 1, eflags: 0x0
// Checksum 0xec6360ff, Offset: 0x188
// Size: 0x1c
function __init__(localclientnum) {
    init_shared();
}

