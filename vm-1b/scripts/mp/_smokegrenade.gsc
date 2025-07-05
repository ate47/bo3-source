#using scripts/codescripts/struct;
#using scripts/mp/_util;
#using scripts/shared/callbacks_shared;
#using scripts/shared/math_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/shared/weapons/_smokegrenade;

#namespace smokegrenade;

// Namespace smokegrenade
// Params 0, eflags: 0x2
// Checksum 0xe387faf2, Offset: 0x160
// Size: 0x2a
function autoexec __init__sytem__() {
    system::register("smokegrenade", &__init__, undefined, undefined);
}

// Namespace smokegrenade
// Params 0, eflags: 0x0
// Checksum 0x8cebc385, Offset: 0x198
// Size: 0x12
function __init__() {
    init_shared();
}

