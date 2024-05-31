#using scripts/mp/_util;
#using scripts/shared/weapons/_tacticalinsertion;
#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/callbacks_shared;
#using scripts/codescripts/struct;

#namespace tacticalinsertion;

// Namespace tacticalinsertion
// Params 0, eflags: 0x2
// namespace_b313ba29<file_0>::function_2dc19561
// Checksum 0x783af9b6, Offset: 0x170
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("tacticalinsertion", &__init__, undefined, undefined);
}

// Namespace tacticalinsertion
// Params 0, eflags: 0x1 linked
// namespace_b313ba29<file_0>::function_8c87d8eb
// Checksum 0xdb1e9492, Offset: 0x1b0
// Size: 0x14
function __init__() {
    init_shared();
}

