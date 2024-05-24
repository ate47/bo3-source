#using scripts/mp/_util;
#using scripts/shared/weapons/_acousticsensor;
#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/callbacks_shared;
#using scripts/codescripts/struct;

#namespace namespace_efc40536;

// Namespace namespace_efc40536
// Params 0, eflags: 0x2
// Checksum 0xef6562a8, Offset: 0x148
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("acousticsensor", &__init__, undefined, undefined);
}

// Namespace namespace_efc40536
// Params 0, eflags: 0x0
// Checksum 0x94f786d1, Offset: 0x188
// Size: 0x14
function __init__() {
    init_shared();
}

