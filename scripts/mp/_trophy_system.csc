#using scripts/mp/_util;
#using scripts/shared/weapons/_trophy_system;
#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/callbacks_shared;
#using scripts/codescripts/struct;

#namespace trophy_system;

// Namespace trophy_system
// Params 0, eflags: 0x2
// Checksum 0x871d602b, Offset: 0x168
// Size: 0x34
function function_2dc19561() {
    system::register("trophy_system", &__init__, undefined, undefined);
}

// Namespace trophy_system
// Params 1, eflags: 0x1 linked
// Checksum 0x9b05f6ab, Offset: 0x1a8
// Size: 0x1c
function __init__(localclientnum) {
    init_shared();
}

