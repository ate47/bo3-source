#using scripts/codescripts/struct;
#using scripts/mp/_util;
#using scripts/shared/clientfield_shared;
#using scripts/shared/fx_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/shared/weapons/_scrambler;

#namespace scrambler;

// Namespace scrambler
// Params 0, eflags: 0x2
// Checksum 0x1721d265, Offset: 0x158
// Size: 0x2a
function autoexec function_2dc19561() {
    system::register("scrambler", &__init__, undefined, undefined);
}

// Namespace scrambler
// Params 0, eflags: 0x0
// Checksum 0x6bd72c24, Offset: 0x190
// Size: 0x12
function __init__() {
    init_shared();
}

