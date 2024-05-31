#using scripts/zm/_zm_weapons;
#using scripts/zm/_zm_melee_weapon;
#using scripts/shared/system_shared;
#using scripts/codescripts/struct;

#namespace namespace_f492499a;

// Namespace namespace_f492499a
// Params 0, eflags: 0x2
// namespace_f492499a<file_0>::function_2dc19561
// Checksum 0xc02d18dd, Offset: 0x198
// Size: 0x3c
function autoexec function_2dc19561() {
    system::register("bowie_knife", &__init__, &__main__, undefined);
}

// Namespace namespace_f492499a
// Params 0, eflags: 0x5 linked
// namespace_f492499a<file_0>::function_8c87d8eb
// Checksum 0x99ec1590, Offset: 0x1e0
// Size: 0x4
function private __init__() {
    
}

// Namespace namespace_f492499a
// Params 0, eflags: 0x5 linked
// namespace_f492499a<file_0>::function_5b6b9132
// Checksum 0xfa717a6e, Offset: 0x1f0
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

// Namespace namespace_f492499a
// Params 0, eflags: 0x0
// namespace_f492499a<file_0>::function_c35e6aab
// Checksum 0x99ec1590, Offset: 0x300
// Size: 0x4
function init() {
    
}

