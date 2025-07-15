#using scripts/codescripts/struct;

#namespace weapon_utils;

// Namespace weapon_utils
// Params 1
// Checksum 0x180c1cf2, Offset: 0x108
// Size: 0x1a, Type: bool
function ispistol( weapon )
{
    return isdefined( level.side_arm_array[ weapon ] );
}

// Namespace weapon_utils
// Params 1
// Checksum 0x85df2e2f, Offset: 0x130
// Size: 0x2a, Type: bool
function isflashorstunweapon( weapon )
{
    return weapon.isflash || weapon.isstun;
}

// Namespace weapon_utils
// Params 2
// Checksum 0xfc3f9fa0, Offset: 0x168
// Size: 0x4c, Type: bool
function isflashorstundamage( weapon, meansofdeath )
{
    return meansofdeath == "MOD_GRENADE_SPLASH" || isflashorstunweapon( weapon ) && meansofdeath == "MOD_GAS";
}

// Namespace weapon_utils
// Params 1
// Checksum 0x973e275c, Offset: 0x1c0
// Size: 0x38, Type: bool
function ismeleemod( mod )
{
    return mod == "MOD_MELEE" || mod == "MOD_MELEE_WEAPON_BUTT" || mod == "MOD_MELEE_ASSASSINATE";
}

// Namespace weapon_utils
// Params 1
// Checksum 0xf47d39a2, Offset: 0x200
// Size: 0x48, Type: bool
function ispunch( weapon )
{
    return weapon.type == "melee" && weapon.rootweapon.name == "bare_hands";
}

// Namespace weapon_utils
// Params 1
// Checksum 0x2c58e787, Offset: 0x250
// Size: 0x48, Type: bool
function isknife( weapon )
{
    return weapon.type == "melee" && weapon.rootweapon.name == "knife_loadout";
}

// Namespace weapon_utils
// Params 1
// Checksum 0xf7f9b479, Offset: 0x2a0
// Size: 0x5a, Type: bool
function isnonbarehandsmelee( weapon )
{
    return weapon.type == "melee" && weapon.rootweapon.name != "bare_hands" || weapon.isballisticknife;
}

