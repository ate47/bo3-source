#using scripts/codescripts/struct;
#using scripts/mp/_util;
#using scripts/shared/callbacks_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/shared/weapons/_decoy;

#namespace decoy;

// Namespace decoy
// Params 0, eflags: 0x2
// Checksum 0x6d2b5245, Offset: 0x128
// Size: 0x2a
function autoexec function_2dc19561() {
    system::register("decoy", &__init__, undefined, undefined);
}

// Namespace decoy
// Params 0, eflags: 0x0
// Checksum 0xba3fe019, Offset: 0x160
// Size: 0x12
function __init__() {
    init_shared();
}

