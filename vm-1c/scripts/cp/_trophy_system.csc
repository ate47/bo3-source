#using scripts/codescripts/struct;
#using scripts/cp/_util;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/shared/weapons/_trophy_system;

#namespace trophy_system;

// Namespace trophy_system
// Params 0, eflags: 0x2
// Checksum 0xaf87be4a, Offset: 0x168
// Size: 0x34
function autoexec __init__sytem__() {
    system::register("trophy_system", &__init__, undefined, undefined);
}

// Namespace trophy_system
// Params 1, eflags: 0x0
// Checksum 0x2d12983d, Offset: 0x1a8
// Size: 0x1c
function __init__(localclientnum) {
    init_shared();
}

