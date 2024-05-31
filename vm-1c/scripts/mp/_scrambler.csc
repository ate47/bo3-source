#using scripts/mp/_util;
#using scripts/shared/weapons/_scrambler;
#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/fx_shared;
#using scripts/shared/clientfield_shared;
#using scripts/codescripts/struct;

#namespace scrambler;

// Namespace scrambler
// Params 0, eflags: 0x2
// namespace_ba0d5c0a<file_0>::function_2dc19561
// Checksum 0xde05843b, Offset: 0x158
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("scrambler", &__init__, undefined, undefined);
}

// Namespace scrambler
// Params 0, eflags: 0x0
// namespace_ba0d5c0a<file_0>::function_8c87d8eb
// Checksum 0xf57eac54, Offset: 0x198
// Size: 0x14
function __init__() {
    init_shared();
}

