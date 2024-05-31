#using scripts/cp/_util;
#using scripts/shared/weapons/_decoy;
#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/callbacks_shared;
#using scripts/codescripts/struct;

#namespace decoy;

// Namespace decoy
// Params 0, eflags: 0x2
// namespace_b97178f7<file_0>::function_2dc19561
// Checksum 0x7e97b40f, Offset: 0x128
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("decoy", &__init__, undefined, undefined);
}

// Namespace decoy
// Params 0, eflags: 0x1 linked
// namespace_b97178f7<file_0>::function_8c87d8eb
// Checksum 0xabfbc6fd, Offset: 0x168
// Size: 0x14
function __init__() {
    init_shared();
}

