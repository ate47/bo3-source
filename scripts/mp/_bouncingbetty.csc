#using scripts/mp/_util;
#using scripts/shared/weapons/_bouncingbetty;
#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/callbacks_shared;
#using scripts/codescripts/struct;

#namespace bouncingbetty;

// Namespace bouncingbetty
// Params 0, eflags: 0x2
// Checksum 0x5fb80612, Offset: 0x140
// Size: 0x34
function function_2dc19561() {
    system::register("bouncingbetty", &__init__, undefined, undefined);
}

// Namespace bouncingbetty
// Params 1, eflags: 0x1 linked
// Checksum 0x2aeb6635, Offset: 0x180
// Size: 0x1c
function __init__(localclientnum) {
    init_shared();
}

