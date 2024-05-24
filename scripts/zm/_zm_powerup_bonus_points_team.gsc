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

#namespace zm_powerup_bonus_points_team;

// Namespace zm_powerup_bonus_points_team
// Params 0, eflags: 0x2
// Checksum 0x46080908, Offset: 0x2f0
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("zm_powerup_bonus_points_team", &__init__, undefined, undefined);
}

// Namespace zm_powerup_bonus_points_team
// Params 0, eflags: 0x0
// Checksum 0xba5c7790, Offset: 0x330
// Size: 0x9c
function __init__() {
    zm_powerups::register_powerup("bonus_points_team", &grab_bonus_points_team);
    if (tolower(getdvarstring("g_gametype")) != "zcleansed") {
        zm_powerups::add_zombie_powerup("bonus_points_team", "zombie_z_money_icon", %ZOMBIE_POWERUP_BONUS_POINTS, &zm_powerups::func_should_never_drop, 0, 0, 0);
    }
}

// Namespace zm_powerup_bonus_points_team
// Params 1, eflags: 0x0
// Checksum 0x9727a310, Offset: 0x3d8
// Size: 0x44
function grab_bonus_points_team(player) {
    level thread bonus_points_team_powerup(self);
    player thread zm_powerups::powerup_vo("bonus_points_team");
}

// Namespace zm_powerup_bonus_points_team
// Params 1, eflags: 0x0
// Checksum 0x7419c9d5, Offset: 0x428
// Size: 0x10e
function bonus_points_team_powerup(item) {
    points = randomintrange(1, 25) * 100;
    if (isdefined(level.bonus_points_powerup_override)) {
        points = [[ level.bonus_points_powerup_override ]]();
    }
    players = getplayers();
    for (i = 0; i < players.size; i++) {
        if (!players[i] laststand::player_is_in_laststand() && !(players[i].sessionstate == "spectator")) {
            players[i] zm_score::player_add_points("bonus_points_powerup", points);
        }
    }
}

