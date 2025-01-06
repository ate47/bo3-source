#using scripts/codescripts/struct;
#using scripts/shared/system_shared;
#using scripts/zm/_zm_melee_weapon;
#using scripts/zm/_zm_weapons;

#namespace _zm_weap_sickle;

// Namespace _zm_weap_sickle
// Params 0, eflags: 0x2
// Checksum 0xc6d2e5f9, Offset: 0x1a0
// Size: 0x3c
function autoexec function_2dc19561() {
    system::register("sickle", &__init__, &__main__, undefined);
}

// Namespace _zm_weap_sickle
// Params 0, eflags: 0x4
// Checksum 0x99ec1590, Offset: 0x1e8
// Size: 0x4
function private __init__() {
    
}

// Namespace _zm_weap_sickle
// Params 0, eflags: 0x4
// Checksum 0xaa07ea7f, Offset: 0x1f8
// Size: 0x104
function private __main__() {
    if (isdefined(level.var_c81f7742)) {
        cost = level.var_c81f7742;
    } else {
        cost = 3000;
    }
    prompt = %ZOMBIE_WEAPONCOSTONLY_CFILL;
    if (!(isdefined(level.var_dc23b46e) && level.var_dc23b46e)) {
        prompt = %DLC5_WEAPON_SICKLE_BUY;
    }
    zm_melee_weapon::init("sickle_knife", "sickle_flourish", "knife_ballistic_sickle", "knife_ballistic_sickle_upgraded", cost, "sickle_upgrade", prompt, "sickle", undefined);
    zm_melee_weapon::set_fallback_weapon("sickle_knife", "zombie_fists_sickle");
    zm_weapons::function_94719ba3("knife_ballistic_sickle");
    zm_weapons::function_94719ba3("knife_ballistic_sickle_upgraded");
}

// Namespace _zm_weap_sickle
// Params 0, eflags: 0x0
// Checksum 0x99ec1590, Offset: 0x308
// Size: 0x4
function init() {
    
}

