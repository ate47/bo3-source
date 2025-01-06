#using scripts/codescripts/struct;
#using scripts/shared/system_shared;
#using scripts/zm/_zm_powerups;

#namespace zm_powerup_double_points;

// Namespace zm_powerup_double_points
// Params 0, eflags: 0x2
// Checksum 0xf60699fe, Offset: 0x128
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("zm_powerup_double_points", &__init__, undefined, undefined);
}

// Namespace zm_powerup_double_points
// Params 0, eflags: 0x0
// Checksum 0xf32efdbd, Offset: 0x168
// Size: 0x74
function __init__() {
    zm_powerups::include_zombie_powerup("double_points");
    if (tolower(getdvarstring("g_gametype")) != "zcleansed") {
        zm_powerups::add_zombie_powerup("double_points", "powerup_double_points");
    }
}

