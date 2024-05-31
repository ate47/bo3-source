#using scripts/cp/_util;
#using scripts/shared/weapons/_flashgrenades;
#using scripts/shared/system_shared;
#using scripts/shared/callbacks_shared;
#using scripts/codescripts/struct;

#namespace namespace_f5f10e8c;

// Namespace namespace_f5f10e8c
// Params 0, eflags: 0x2
// namespace_f5f10e8c<file_0>::function_2dc19561
// Checksum 0xb8bc3ebe, Offset: 0x120
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("flashgrenades", &__init__, undefined, undefined);
}

// Namespace namespace_f5f10e8c
// Params 0, eflags: 0x1 linked
// namespace_f5f10e8c<file_0>::function_8c87d8eb
// Checksum 0x109f6123, Offset: 0x160
// Size: 0x14
function __init__() {
    init_shared();
}

