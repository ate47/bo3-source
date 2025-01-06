#using scripts/codescripts/struct;
#using scripts/shared/callbacks_shared;
#using scripts/shared/system_shared;
#using scripts/shared/weapons/_decoy;

#namespace decoy;

// Namespace decoy
// Params 0, eflags: 0x2
// Checksum 0x3c8829a1, Offset: 0xf8
// Size: 0x2a
function autoexec function_2dc19561() {
    system::register("decoy", &__init__, undefined, undefined);
}

// Namespace decoy
// Params 0, eflags: 0x0
// Checksum 0x8cebc385, Offset: 0x130
// Size: 0x12
function __init__() {
    init_shared();
}

