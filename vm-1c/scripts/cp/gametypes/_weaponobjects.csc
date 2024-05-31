#using scripts/shared/weapons/_weaponobjects;
#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/array_shared;
#using scripts/codescripts/struct;

#namespace weaponobjects;

// Namespace weaponobjects
// Params 0, eflags: 0x2
// namespace_aec973d7<file_0>::function_2dc19561
// Checksum 0x4fed97ab, Offset: 0x180
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("weaponobjects", &__init__, undefined, undefined);
}

// Namespace weaponobjects
// Params 0, eflags: 0x1 linked
// namespace_aec973d7<file_0>::function_8c87d8eb
// Checksum 0xbaa078d5, Offset: 0x1c0
// Size: 0x14
function __init__() {
    init_shared();
}

