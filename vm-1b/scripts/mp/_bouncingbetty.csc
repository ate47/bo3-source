#using scripts/codescripts/struct;
#using scripts/mp/_util;
#using scripts/shared/callbacks_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/shared/weapons/_bouncingbetty;

#namespace bouncingbetty;

// Namespace bouncingbetty
// Params 0, eflags: 0x2
// Checksum 0x7d9f3e04, Offset: 0x140
// Size: 0x2a
function autoexec __init__sytem__() {
    system::register("bouncingbetty", &__init__, undefined, undefined);
}

// Namespace bouncingbetty
// Params 1, eflags: 0x0
// Checksum 0x347debe5, Offset: 0x178
// Size: 0x1a
function __init__(localclientnum) {
    init_shared();
}

