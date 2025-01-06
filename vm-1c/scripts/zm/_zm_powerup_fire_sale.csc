#using scripts/codescripts/struct;
#using scripts/shared/system_shared;
#using scripts/zm/_zm_powerups;

#namespace zm_powerup_fire_sale;

// Namespace zm_powerup_fire_sale
// Params 0, eflags: 0x2
// Checksum 0x67a2dff7, Offset: 0x118
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("zm_powerup_fire_sale", &__init__, undefined, undefined);
}

// Namespace zm_powerup_fire_sale
// Params 0, eflags: 0x0
// Checksum 0x5476d437, Offset: 0x158
// Size: 0x74
function __init__() {
    zm_powerups::include_zombie_powerup("fire_sale");
    if (tolower(getdvarstring("g_gametype")) != "zcleansed") {
        zm_powerups::add_zombie_powerup("fire_sale", "powerup_fire_sale");
    }
}

