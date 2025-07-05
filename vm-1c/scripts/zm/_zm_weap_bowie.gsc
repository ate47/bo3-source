#using scripts/codescripts/struct;
#using scripts/shared/system_shared;
#using scripts/zm/_zm_melee_weapon;
#using scripts/zm/_zm_weapons;

#namespace _zm_weap_bowie;

// Namespace _zm_weap_bowie
// Params 0, eflags: 0x2
// Checksum 0x40193374, Offset: 0x198
// Size: 0x3c
function autoexec __init__sytem__() {
    system::register("bowie_knife", &__init__, &__main__, undefined);
}

// Namespace _zm_weap_bowie
// Params 0, eflags: 0x4
// Checksum 0x99ec1590, Offset: 0x1e0
// Size: 0x4
function private __init__() {
    
}

// Namespace _zm_weap_bowie
// Params 0, eflags: 0x4
// Checksum 0xd2db652e, Offset: 0x1f0
// Size: 0x104
function private __main__() {
    if (isdefined(level.bowie_cost)) {
        cost = level.bowie_cost;
    } else {
        cost = 3000;
    }
    prompt = %ZOMBIE_WEAPONCOSTONLY_CFILL;
    if (!(isdefined(level.var_dc23b46e) && level.var_dc23b46e)) {
        prompt = %ZOMBIE_WEAPON_BOWIE_BUY;
    }
    zm_melee_weapon::init("bowie_knife", "bowie_flourish", "knife_ballistic_bowie", "knife_ballistic_bowie_upgraded", cost, "bowie_upgrade", prompt, "bowie", undefined);
    zm_melee_weapon::set_fallback_weapon("bowie_knife", "zombie_fists_bowie");
    zm_weapons::function_94719ba3("knife_ballistic_bowie");
    zm_weapons::function_94719ba3("knife_ballistic_bowie_upgraded");
}

// Namespace _zm_weap_bowie
// Params 0, eflags: 0x0
// Checksum 0x99ec1590, Offset: 0x300
// Size: 0x4
function init() {
    
}

