#using scripts/zm/_zm_powerups;
#using scripts/shared/system_shared;
#using scripts/codescripts/struct;

#namespace zm_powerup_double_points;

// Namespace zm_powerup_double_points
// Params 0, eflags: 0x2
// Checksum 0x22b46b31, Offset: 0x128
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("zm_powerup_double_points", &__init__, undefined, undefined);
}

// Namespace zm_powerup_double_points
// Params 0, eflags: 0x1 linked
// Checksum 0xa1f39732, Offset: 0x168
// Size: 0x74
function __init__() {
    zm_powerups::include_zombie_powerup("double_points");
    if (tolower(getdvarstring("g_gametype")) != "zcleansed") {
        zm_powerups::add_zombie_powerup("double_points", "powerup_double_points");
    }
}

