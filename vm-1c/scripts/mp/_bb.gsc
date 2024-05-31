#using scripts/shared/bb_shared;
#using scripts/shared/system_shared;
#using scripts/shared/callbacks_shared;
#using scripts/codescripts/struct;

#namespace bb;

// Namespace bb
// Params 0, eflags: 0x2
// Checksum 0x5aedb949, Offset: 0xe8
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("bb", &__init__, undefined, undefined);
}

// Namespace bb
// Params 0, eflags: 0x1 linked
// Checksum 0xf08df7a4, Offset: 0x128
// Size: 0x14
function __init__() {
    init_shared();
}

