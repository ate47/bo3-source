#using scripts/cp/_util;
#using scripts/cp/_scoreevents;
#using scripts/cp/_challenges;
#using scripts/cp/gametypes/_weaponobjects;
#using scripts/cp/gametypes/_weapon_utils;
#using scripts/cp/gametypes/_shellshock;
#using scripts/cp/gametypes/_globallogic_utils;
#using scripts/shared/weapons/_weapons;
#using scripts/shared/weapons_shared;
#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/gameobjects_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/array_shared;
#using scripts/codescripts/struct;

#namespace weapons;

// Namespace weapons
// Params 0, eflags: 0x2
// namespace_f996a5bc<file_0>::function_2dc19561
// Checksum 0x79aa8d31, Offset: 0x278
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("weapons", &__init__, undefined, undefined);
}

// Namespace weapons
// Params 0, eflags: 0x1 linked
// namespace_f996a5bc<file_0>::function_8c87d8eb
// Checksum 0x2eff545, Offset: 0x2b8
// Size: 0x14
function __init__() {
    init_shared();
}

