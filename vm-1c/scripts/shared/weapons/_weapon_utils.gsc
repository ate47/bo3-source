#using scripts/codescripts/struct;

#namespace weapon_utils;

// Namespace weapon_utils
// Params 1, eflags: 0x1 linked
// namespace_30fc7b57<file_0>::function_31cfe8a4
// Checksum 0x180c1cf2, Offset: 0x108
// Size: 0x1a
function ispistol(weapon) {
    return isdefined(level.side_arm_array[weapon]);
}

// Namespace weapon_utils
// Params 1, eflags: 0x1 linked
// namespace_30fc7b57<file_0>::function_8bc6d976
// Checksum 0x85df2e2f, Offset: 0x130
// Size: 0x2a
function isflashorstunweapon(weapon) {
    return weapon.isflash || weapon.isstun;
}

// Namespace weapon_utils
// Params 2, eflags: 0x1 linked
// namespace_30fc7b57<file_0>::function_4cf0410d
// Checksum 0xfc3f9fa0, Offset: 0x168
// Size: 0x4c
function isflashorstundamage(weapon, meansofdeath) {
    return meansofdeath == "MOD_GRENADE_SPLASH" || isflashorstunweapon(weapon) && meansofdeath == "MOD_GAS";
}

// Namespace weapon_utils
// Params 1, eflags: 0x1 linked
// namespace_30fc7b57<file_0>::function_29e60f99
// Checksum 0x973e275c, Offset: 0x1c0
// Size: 0x38
function ismeleemod(mod) {
    return mod == "MOD_MELEE" || mod == "MOD_MELEE_WEAPON_BUTT" || mod == "MOD_MELEE_ASSASSINATE";
}

// Namespace weapon_utils
// Params 1, eflags: 0x1 linked
// namespace_30fc7b57<file_0>::function_b80a8807
// Checksum 0xf47d39a2, Offset: 0x200
// Size: 0x48
function ispunch(weapon) {
    return weapon.type == "melee" && weapon.rootweapon.name == "bare_hands";
}

// Namespace weapon_utils
// Params 1, eflags: 0x0
// namespace_30fc7b57<file_0>::function_f83dde00
// Checksum 0x2c58e787, Offset: 0x250
// Size: 0x48
function isknife(weapon) {
    return weapon.type == "melee" && weapon.rootweapon.name == "knife_loadout";
}

// Namespace weapon_utils
// Params 1, eflags: 0x1 linked
// namespace_30fc7b57<file_0>::function_9996f388
// Checksum 0xf7f9b479, Offset: 0x2a0
// Size: 0x5a
function isnonbarehandsmelee(weapon) {
    return weapon.type == "melee" && weapon.rootweapon.name != "bare_hands" || weapon.isballisticknife;
}

