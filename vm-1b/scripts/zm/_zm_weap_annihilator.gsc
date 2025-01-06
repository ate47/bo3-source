#using scripts/codescripts/struct;
#using scripts/shared/ai/systems/gib;
#using scripts/shared/ai/zombie_utility;
#using scripts/shared/array_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/hud_util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/zm/_zm_audio;
#using scripts/zm/_zm_hero_weapon;
#using scripts/zm/_zm_spawner;
#using scripts/zm/_zm_utility;

#namespace zm_weap_annihilator;

// Namespace zm_weap_annihilator
// Params 0, eflags: 0x2
// Checksum 0x951eb8ec, Offset: 0x260
// Size: 0x2a
function autoexec function_2dc19561() {
    system::register("zm_weap_annihilator", &__init__, undefined, undefined);
}

// Namespace zm_weap_annihilator
// Params 0, eflags: 0x0
// Checksum 0xca69d938, Offset: 0x298
// Size: 0x3a
function __init__() {
    zm_spawner::register_zombie_death_event_callback(&function_4ac019bc);
    zm_hero_weapon::function_d29010f8("hero_annihilator");
}

// Namespace zm_weap_annihilator
// Params 1, eflags: 0x0
// Checksum 0xbec35d42, Offset: 0x2e0
// Size: 0x4a
function function_4ac019bc(attacker) {
    if (self.damageweapon === getweapon("hero_annihilator")) {
        self zombie_utility::gib_random_parts();
        gibserverutils::annihilate(self);
    }
}

