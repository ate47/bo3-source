#using scripts/codescripts/struct;
#using scripts/shared/system_shared;
#using scripts/zm/_zm_powerups;

#namespace zm_powerup_weapon_minigun;

// Namespace zm_powerup_weapon_minigun
// Params 0, eflags: 0x2
// Checksum 0x4dd92169, Offset: 0x120
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("zm_powerup_weapon_minigun", &__init__, undefined, undefined);
}

// Namespace zm_powerup_weapon_minigun
// Params 0, eflags: 0x0
// Checksum 0xbf5535d3, Offset: 0x160
// Size: 0x74
function __init__() {
    zm_powerups::include_zombie_powerup("minigun");
    if (tolower(getdvarstring("g_gametype")) != "zcleansed") {
        zm_powerups::add_zombie_powerup("minigun", "powerup_mini_gun");
    }
}

