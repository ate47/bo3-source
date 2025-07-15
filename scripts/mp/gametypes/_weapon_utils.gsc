#using scripts/codescripts/struct;

#namespace weapon_utils;

// Namespace weapon_utils
// Params 1
// Checksum 0x865397e5, Offset: 0x98
// Size: 0x5e
function getbaseweaponparam( weapon )
{
    return weapon.rootweapon.altweapon != level.weaponnone ? weapon.rootweapon.altweapon.rootweapon : weapon.rootweapon;
}

