#using scripts/codescripts/struct;
#using scripts/mp/_util;
#using scripts/shared/callbacks_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/shared/weapons/_bouncingbetty;

#namespace bouncingbetty;

// Namespace bouncingbetty
// Params 0, eflags: 0x2
// Checksum 0x610619a7, Offset: 0x140
// Size: 0x34
function autoexec __init__sytem__() {
    system::register("bouncingbetty", &__init__, undefined, undefined);
}

// Namespace bouncingbetty
// Params 0, eflags: 0x0
// Checksum 0xcf2f7c02, Offset: 0x180
// Size: 0x20
function __init__() {
    init_shared();
    level.trackbouncingbettiesonowner = 1;
}

