#using scripts/codescripts/struct;
#using scripts/mp/_util;
#using scripts/shared/callbacks_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/shared/weapons/_bouncingbetty;

#namespace bouncingbetty;

// Namespace bouncingbetty
// Params 0, eflags: 0x2
// Checksum 0x7d9f3e04, Offset: 0x140
// Size: 0x2a
function autoexec function_2dc19561() {
    system::register("bouncingbetty", &__init__, undefined, undefined);
}

// Namespace bouncingbetty
// Params 0, eflags: 0x0
// Checksum 0xba3fe019, Offset: 0x178
// Size: 0x12
function __init__() {
    init_shared();
}

