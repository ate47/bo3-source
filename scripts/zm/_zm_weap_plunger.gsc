#using scripts/zm/_zm_weapons;
#using scripts/zm/_zm_melee_weapon;
#using scripts/shared/system_shared;
#using scripts/codescripts/struct;

#namespace namespace_6cf1d5bd;

// Namespace namespace_6cf1d5bd
// Params 0, eflags: 0x2
// Checksum 0x48175b48, Offset: 0x158
// Size: 0x3c
function autoexec function_2dc19561() {
    system::register("plunger_knife", &__init__, &__main__, undefined);
}

// Namespace namespace_6cf1d5bd
// Params 0, eflags: 0x4
// Checksum 0x99ec1590, Offset: 0x1a0
// Size: 0x4
function private __init__() {
    
}

// Namespace namespace_6cf1d5bd
// Params 0, eflags: 0x4
// Checksum 0x2b654610, Offset: 0x1b0
// Size: 0x7c
function private __main__() {
    cost = 3000;
    zm_melee_weapon::init("knife_plunger", "zombie_plunger_flourish", undefined, undefined, cost, "bowie_upgrade", %ZMWEAPON_NONE, "plunger", undefined);
    zm_melee_weapon::set_fallback_weapon("knife_plunger", "zombie_fists_plunger");
}

// Namespace namespace_6cf1d5bd
// Params 0, eflags: 0x0
// Checksum 0x99ec1590, Offset: 0x238
// Size: 0x4
function init() {
    
}

