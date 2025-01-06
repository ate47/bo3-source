#using scripts/codescripts/struct;
#using scripts/mp/_util;
#using scripts/shared/clientfield_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/shared/weapons/_scrambler;

#namespace scrambler;

// Namespace scrambler
// Params 0, eflags: 0x2
// Checksum 0xc2defcc9, Offset: 0x138
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("scrambler", &__init__, undefined, undefined);
}

// Namespace scrambler
// Params 0, eflags: 0x0
// Checksum 0xa65efa96, Offset: 0x178
// Size: 0x14
function __init__() {
    init_shared();
}

