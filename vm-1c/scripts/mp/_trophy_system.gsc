#using scripts/mp/_util;
#using scripts/shared/weapons/_trophy_system;
#using scripts/shared/system_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/callbacks_shared;
#using scripts/codescripts/struct;

#namespace trophy_system;

// Namespace trophy_system
// Params 0, eflags: 0x2
// namespace_f0a72d31<file_0>::function_2dc19561
// Checksum 0xd39507ad, Offset: 0x148
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("trophy_system", &__init__, undefined, undefined);
}

// Namespace trophy_system
// Params 0, eflags: 0x1 linked
// namespace_f0a72d31<file_0>::function_8c87d8eb
// Checksum 0x9805cffa, Offset: 0x188
// Size: 0x14
function __init__() {
    init_shared();
}

