#using scripts/zm/_zm_powerups;
#using scripts/shared/system_shared;
#using scripts/codescripts/struct;

#namespace zm_powerup_shield_charge;

// Namespace zm_powerup_shield_charge
// Params 0, eflags: 0x2
// namespace_2a4ec8bc<file_0>::function_2dc19561
// Checksum 0xca25f467, Offset: 0x100
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("zm_powerup_shield_charge", &__init__, undefined, undefined);
}

// Namespace zm_powerup_shield_charge
// Params 0, eflags: 0x1 linked
// namespace_2a4ec8bc<file_0>::function_8c87d8eb
// Checksum 0x162f3777, Offset: 0x140
// Size: 0x34
function __init__() {
    zm_powerups::include_zombie_powerup("shield_charge");
    zm_powerups::add_zombie_powerup("shield_charge");
}

