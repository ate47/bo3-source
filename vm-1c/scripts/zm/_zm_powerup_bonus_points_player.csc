#using scripts/zm/_zm_powerups;
#using scripts/shared/system_shared;
#using scripts/codescripts/struct;

#namespace zm_powerup_bonus_points_player;

// Namespace zm_powerup_bonus_points_player
// Params 0, eflags: 0x2
// namespace_f633c4d9<file_0>::function_2dc19561
// Checksum 0xf22cb0ee, Offset: 0x110
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("zm_powerup_bonus_points_player", &__init__, undefined, undefined);
}

// Namespace zm_powerup_bonus_points_player
// Params 0, eflags: 0x1 linked
// namespace_f633c4d9<file_0>::function_8c87d8eb
// Checksum 0x2932e133, Offset: 0x150
// Size: 0x34
function __init__() {
    zm_powerups::include_zombie_powerup("bonus_points_player");
    zm_powerups::add_zombie_powerup("bonus_points_player");
}

