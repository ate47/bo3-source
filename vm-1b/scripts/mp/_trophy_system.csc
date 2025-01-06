#using scripts/codescripts/struct;
#using scripts/mp/_util;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/shared/weapons/_trophy_system;

#namespace trophy_system;

// Namespace trophy_system
// Params 0, eflags: 0x2
// Checksum 0xa46a9107, Offset: 0x168
// Size: 0x2a
function autoexec function_2dc19561() {
    system::register("trophy_system", &__init__, undefined, undefined);
}

// Namespace trophy_system
// Params 1, eflags: 0x0
// Checksum 0xa1cbe64e, Offset: 0x1a0
// Size: 0x1a
function __init__(localclientnum) {
    init_shared();
}

