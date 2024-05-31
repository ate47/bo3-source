#using scripts/zm/_util;
#using scripts/shared/weapons/_weaponobjects;
#using scripts/shared/weapons_shared;
#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/flagsys_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/callbacks_shared;
#using scripts/codescripts/struct;

#namespace weaponobjects;

// Namespace weaponobjects
// Params 0, eflags: 0x2
// Checksum 0xf1cba62f, Offset: 0x1b8
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("weaponobjects", &__init__, undefined, undefined);
}

// Namespace weaponobjects
// Params 0, eflags: 0x1 linked
// Checksum 0x2bc17b4f, Offset: 0x1f8
// Size: 0x14
function __init__() {
    init_shared();
}

