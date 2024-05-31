#using scripts/zm/_zm_weapons;
#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_spawner;
#using scripts/zm/_zm_score;
#using scripts/zm/_zm_powerups;
#using scripts/zm/_zm_pers_upgrades_functions;
#using scripts/zm/_zm_pers_upgrades;
#using scripts/zm/_zm_melee_weapon;
#using scripts/zm/_zm_blockers;
#using scripts/shared/ai/zombie_death;
#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/laststand_shared;
#using scripts/shared/clientfield_shared;
#using scripts/codescripts/struct;

#namespace zm_powerup_bonus_points_player;

// Namespace zm_powerup_bonus_points_player
// Params 0, eflags: 0x2
// namespace_f633c4d9<file_0>::function_2dc19561
// Checksum 0xd56f9a47, Offset: 0x308
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("zm_powerup_bonus_points_player", &__init__, undefined, undefined);
}

// Namespace zm_powerup_bonus_points_player
// Params 0, eflags: 0x1 linked
// namespace_f633c4d9<file_0>::function_8c87d8eb
// Checksum 0xa617132c, Offset: 0x348
// Size: 0xa4
function __init__() {
    zm_powerups::register_powerup("bonus_points_player", &grab_bonus_points_player);
    if (tolower(getdvarstring("g_gametype")) != "zcleansed") {
        zm_powerups::add_zombie_powerup("bonus_points_player", "zombie_z_money_icon", %ZOMBIE_POWERUP_BONUS_POINTS, &zm_powerups::func_should_never_drop, 1, 0, 0);
    }
}

// Namespace zm_powerup_bonus_points_player
// Params 1, eflags: 0x1 linked
// namespace_f633c4d9<file_0>::function_17a48195
// Checksum 0xae29b89, Offset: 0x3f8
// Size: 0x44
function grab_bonus_points_player(player) {
    level thread bonus_points_player_powerup(self, player);
    player thread zm_powerups::powerup_vo("bonus_points_solo");
}

// Namespace zm_powerup_bonus_points_player
// Params 2, eflags: 0x1 linked
// namespace_f633c4d9<file_0>::function_8edf7fe5
// Checksum 0xc869e739, Offset: 0x448
// Size: 0xe4
function bonus_points_player_powerup(item, player) {
    points = randomintrange(1, 25) * 100;
    if (isdefined(level.bonus_points_powerup_override)) {
        points = [[ level.bonus_points_powerup_override ]]();
    }
    if (isdefined(item.bonus_points_powerup_override)) {
        points = [[ item.bonus_points_powerup_override ]]();
    }
    if (!player laststand::player_is_in_laststand() && !(player.sessionstate == "spectator")) {
        player zm_score::player_add_points("bonus_points_powerup", points);
    }
}

