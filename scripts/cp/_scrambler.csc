#using scripts/cp/_util;
#using scripts/shared/weapons/_scrambler;
#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/fx_shared;
#using scripts/shared/clientfield_shared;
#using scripts/codescripts/struct;

#namespace scrambler;

// Namespace scrambler
// Params 0, eflags: 0x2
// Checksum 0xcaf984b1, Offset: 0x158
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("scrambler", &__init__, undefined, undefined);
}

// Namespace scrambler
// Params 0, eflags: 0x0
// Checksum 0xcefd323b, Offset: 0x198
// Size: 0x14
function __init__() {
    init_shared();
}

