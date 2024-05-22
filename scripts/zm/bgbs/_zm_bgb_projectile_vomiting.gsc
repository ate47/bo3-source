#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_powerups;
#using scripts/zm/_zm_bgb;
#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/clientfield_shared;
#using scripts/codescripts/struct;

#namespace namespace_a5a0319c;

// Namespace namespace_a5a0319c
// Params 0, eflags: 0x2
// Checksum 0xf631c93, Offset: 0x210
// Size: 0x34
function function_2dc19561() {
    system::register("zm_bgb_projectile_vomiting", &__init__, undefined, "bgb");
}

// Namespace namespace_a5a0319c
// Params 0, eflags: 0x1 linked
// Checksum 0x34d7b1e0, Offset: 0x250
// Size: 0xb4
function __init__() {
    if (!(isdefined(level.bgb_in_use) && level.bgb_in_use)) {
        return;
    }
    clientfield::register("actor", "projectile_vomit", 12000, 1, "counter");
    bgb::register("zm_bgb_projectile_vomiting", "rounds", 5, &enable, &disable, undefined);
    bgb::register_actor_death_override("zm_bgb_projectile_vomiting", &actor_death_override);
}

// Namespace namespace_a5a0319c
// Params 0, eflags: 0x1 linked
// Checksum 0x99ec1590, Offset: 0x310
// Size: 0x4
function enable() {
    
}

// Namespace namespace_a5a0319c
// Params 0, eflags: 0x1 linked
// Checksum 0x99ec1590, Offset: 0x320
// Size: 0x4
function disable() {
    
}

// Namespace namespace_a5a0319c
// Params 1, eflags: 0x1 linked
// Checksum 0xad3199e8, Offset: 0x330
// Size: 0x76
function actor_death_override(attacker) {
    if (isdefined(self.damagemod)) {
        switch (self.damagemod) {
        case 6:
        case 7:
        case 8:
        case 9:
        case 10:
            clientfield::increment("projectile_vomit", 1);
            break;
        }
    }
}

