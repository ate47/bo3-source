#using scripts/codescripts/struct;
#using scripts/shared/system_shared;
#using scripts/zm/_zm_powerups;

#namespace zm_powerup_shield_charge;

// Namespace zm_powerup_shield_charge
// Params 0, eflags: 0x2
// Checksum 0xe8e5ba61, Offset: 0x100
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("zm_powerup_shield_charge", &__init__, undefined, undefined);
}

// Namespace zm_powerup_shield_charge
// Params 0, eflags: 0x0
// Checksum 0x5e10ff9a, Offset: 0x140
// Size: 0x34
function __init__() {
    zm_powerups::include_zombie_powerup("shield_charge");
    zm_powerups::add_zombie_powerup("shield_charge");
}

