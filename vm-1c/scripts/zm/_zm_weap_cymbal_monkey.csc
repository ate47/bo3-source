#using scripts/zm/_zm_weapons;
#using scripts/zm/_zm_utility;
#using scripts/codescripts/struct;

#namespace _zm_weap_cymbal_monkey;

// Namespace _zm_weap_cymbal_monkey
// Params 0, eflags: 0x1 linked
// Checksum 0x1164836, Offset: 0x110
// Size: 0x70
function init() {
    if (isdefined(level.legacy_cymbal_monkey) && level.legacy_cymbal_monkey) {
        level.cymbal_monkey_model = "weapon_zombie_monkey_bomb";
    } else {
        level.cymbal_monkey_model = "wpn_t7_zmb_monkey_bomb_world";
    }
    if (!zm_weapons::is_weapon_included(getweapon("cymbal_monkey"))) {
        return;
    }
}

