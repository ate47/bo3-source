#using scripts/codescripts/struct;
#using scripts/mp/_util;
#using scripts/shared/callbacks_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/shared/weapons/_acousticsensor;

#namespace acousticsensor;

// Namespace acousticsensor
// Params 0, eflags: 0x2
// Checksum 0xbb2304f1, Offset: 0x148
// Size: 0x2a
function autoexec function_2dc19561() {
    system::register("acousticsensor", &__init__, undefined, undefined);
}

// Namespace acousticsensor
// Params 0, eflags: 0x0
// Checksum 0x6bd72c24, Offset: 0x180
// Size: 0x12
function __init__() {
    init_shared();
}

