#using scripts/codescripts/struct;
#using scripts/mp/_util;
#using scripts/shared/clientfield_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/shared/weapons/_scrambler;

#namespace scrambler;

// Namespace scrambler
// Params 0, eflags: 0x2
// Checksum 0x6a2d7152, Offset: 0x138
// Size: 0x2a
function autoexec function_2dc19561() {
    system::register("scrambler", &__init__, undefined, undefined);
}

// Namespace scrambler
// Params 0, eflags: 0x0
// Checksum 0xc2457c3e, Offset: 0x170
// Size: 0x12
function __init__() {
    init_shared();
}

