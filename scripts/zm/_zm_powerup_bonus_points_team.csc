#using scripts/zm/_zm_powerups;
#using scripts/shared/system_shared;
#using scripts/codescripts/struct;

#namespace zm_powerup_bonus_points_team;

// Namespace zm_powerup_bonus_points_team
// Params 0, eflags: 0x2
// Checksum 0x1afdefdc, Offset: 0x108
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("zm_powerup_bonus_points_team", &__init__, undefined, undefined);
}

// Namespace zm_powerup_bonus_points_team
// Params 0, eflags: 0x0
// Checksum 0xadf9ce64, Offset: 0x148
// Size: 0x34
function __init__() {
    zm_powerups::include_zombie_powerup("bonus_points_team");
    zm_powerups::add_zombie_powerup("bonus_points_team");
}

