#using scripts/codescripts/struct;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/flagsys_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/shared/weapons/_weaponobjects;
#using scripts/shared/weapons_shared;
#using scripts/zm/_util;

#namespace weaponobjects;

// Namespace weaponobjects
// Params 0, eflags: 0x2
// Checksum 0xf1cba62f, Offset: 0x1b8
// Size: 0x34
function autoexec __init__sytem__() {
    system::register("weaponobjects", &__init__, undefined, undefined);
}

// Namespace weaponobjects
// Params 0, eflags: 0x0
// Checksum 0x2bc17b4f, Offset: 0x1f8
// Size: 0x14
function __init__() {
    init_shared();
}

