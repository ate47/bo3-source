#using scripts/zm/_zm_powerups;
#using scripts/shared/system_shared;
#using scripts/codescripts/struct;

#namespace zm_powerup_ww_grenade;

// Namespace zm_powerup_ww_grenade
// Params 0, eflags: 0x2
// Checksum 0xab281d26, Offset: 0xf8
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("zm_powerup_ww_grenade", &__init__, undefined, undefined);
}

// Namespace zm_powerup_ww_grenade
// Params 0, eflags: 0x1 linked
// Checksum 0x78fe77de, Offset: 0x138
// Size: 0x34
function __init__() {
    zm_powerups::include_zombie_powerup("ww_grenade");
    zm_powerups::add_zombie_powerup("ww_grenade");
}

