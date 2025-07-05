#using scripts/codescripts/struct;
#using scripts/cp/_util;
#using scripts/shared/callbacks_shared;
#using scripts/shared/math_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/shared/weapons/_smokegrenade;

#namespace smokegrenade;

// Namespace smokegrenade
// Params 0, eflags: 0x2
// Checksum 0x44cdaaad, Offset: 0x160
// Size: 0x34
function autoexec __init__sytem__() {
    system::register("smokegrenade", &__init__, undefined, undefined);
}

// Namespace smokegrenade
// Params 0, eflags: 0x0
// Checksum 0x9504b6f3, Offset: 0x1a0
// Size: 0x14
function __init__() {
    init_shared();
}

