#using scripts/mp/_util;
#using scripts/shared/weapons/_smokegrenade;
#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/math_shared;
#using scripts/shared/callbacks_shared;
#using scripts/codescripts/struct;

#namespace smokegrenade;

// Namespace smokegrenade
// Params 0, eflags: 0x2
// Checksum 0xea66c948, Offset: 0x160
// Size: 0x34
function function_2dc19561() {
    system::register("smokegrenade", &__init__, undefined, undefined);
}

// Namespace smokegrenade
// Params 0, eflags: 0x1 linked
// Checksum 0x5b844712, Offset: 0x1a0
// Size: 0x14
function __init__() {
    init_shared();
}

