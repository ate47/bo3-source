#using scripts/mp/_util;
#using scripts/shared/weapons/_hive_gun;
#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/callbacks_shared;
#using scripts/codescripts/struct;

#namespace namespace_5cffdc90;

// Namespace namespace_5cffdc90
// Params 0, eflags: 0x2
// namespace_5cffdc90<file_0>::function_2dc19561
// Checksum 0xd9e3dcdd, Offset: 0x158
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("hive_gun", &__init__, undefined, undefined);
}

// Namespace namespace_5cffdc90
// Params 0, eflags: 0x1 linked
// namespace_5cffdc90<file_0>::function_8c87d8eb
// Checksum 0x21672bac, Offset: 0x198
// Size: 0x14
function __init__() {
    init_shared();
}

