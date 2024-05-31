#using scripts/codescripts/struct;

#namespace weapon_utils;

// Namespace weapon_utils
// Params 1, eflags: 0x1 linked
// namespace_30fc7b57<file_0>::function_23be4e6b
// Checksum 0x865397e5, Offset: 0x98
// Size: 0x5e
function function_23be4e6b(weapon) {
    return weapon.rootweapon.altweapon != level.weaponnone ? weapon.rootweapon.altweapon.rootweapon : weapon.rootweapon;
}

