#using scripts/cp/_util;
#using scripts/shared/weapons/_trophy_system;
#using scripts/shared/system_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/callbacks_shared;
#using scripts/codescripts/struct;

#namespace trophy_system;

// Namespace trophy_system
// Params 0, eflags: 0x2
// Checksum 0x792a3c3a, Offset: 0x148
// Size: 0x34
function function_2dc19561() {
    system::register("trophy_system", &__init__, undefined, undefined);
}

// Namespace trophy_system
// Params 0, eflags: 0x1 linked
// Checksum 0xc64cbbbd, Offset: 0x188
// Size: 0x14
function __init__() {
    init_shared();
}

