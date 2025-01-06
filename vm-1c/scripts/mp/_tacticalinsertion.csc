#using scripts/codescripts/struct;
#using scripts/mp/_util;
#using scripts/shared/clientfield_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/shared/weapons/_tacticalinsertion;

#namespace tacticalinsertion;

// Namespace tacticalinsertion
// Params 0, eflags: 0x2
// Checksum 0x8650c164, Offset: 0x150
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("tacticalinsertion", &__init__, undefined, undefined);
}

// Namespace tacticalinsertion
// Params 0, eflags: 0x0
// Checksum 0xdbcf0f3f, Offset: 0x190
// Size: 0x14
function __init__() {
    init_shared();
}

