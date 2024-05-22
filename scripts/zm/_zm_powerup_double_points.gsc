#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_spawner;
#using scripts/zm/_zm_score;
#using scripts/zm/_zm_powerups;
#using scripts/zm/_zm_pers_upgrades_functions;
#using scripts/zm/_zm_bgb;
#using scripts/shared/ai/zombie_death;
#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/clientfield_shared;
#using scripts/codescripts/struct;

#namespace zm_powerup_double_points;

// Namespace zm_powerup_double_points
// Params 0, eflags: 0x2
// Checksum 0x9fda549a, Offset: 0x2f8
// Size: 0x34
function function_2dc19561() {
    system::register("zm_powerup_double_points", &__init__, undefined, undefined);
}

// Namespace zm_powerup_double_points
// Params 0, eflags: 0x1 linked
// Checksum 0xfb088df, Offset: 0x338
// Size: 0xbc
function __init__() {
    zm_powerups::register_powerup("double_points", &grab_double_points);
    if (tolower(getdvarstring("g_gametype")) != "zcleansed") {
        zm_powerups::add_zombie_powerup("double_points", "p7_zm_power_up_double_points", %ZOMBIE_POWERUP_DOUBLE_POINTS, &zm_powerups::func_should_always_drop, 0, 0, 0, undefined, "powerup_double_points", "zombie_powerup_double_points_time", "zombie_powerup_double_points_on");
    }
}

// Namespace zm_powerup_double_points
// Params 1, eflags: 0x1 linked
// Checksum 0x38b3762, Offset: 0x400
// Size: 0x44
function grab_double_points(player) {
    level thread double_points_powerup(self, player);
    player thread zm_powerups::powerup_vo("double_points");
}

// Namespace zm_powerup_double_points
// Params 2, eflags: 0x1 linked
// Checksum 0x93606323, Offset: 0x450
// Size: 0x2a6
function double_points_powerup(drop_item, player) {
    level notify("powerup points scaled_" + player.team);
    level endon("powerup points scaled_" + player.team);
    team = player.team;
    level thread zm_powerups::show_on_hud(team, "double_points");
    if (isdefined(level.var_10626b86) && level.var_10626b86) {
        player thread namespace_25f8c2ad::function_bb9a6b2c();
    }
    if (isdefined(level.current_game_module) && level.current_game_module == 2) {
        if (isdefined(player._race_team)) {
            if (player._race_team == 1) {
                level._race_team_double_points = 1;
            } else {
                level._race_team_double_points = 2;
            }
        }
    }
    level.zombie_vars[team]["zombie_point_scalar"] = 2;
    players = getplayers();
    for (player_index = 0; player_index < players.size; player_index++) {
        if (team == players[player_index].team) {
            players[player_index] clientfield::set_player_uimodel("hudItems.doublePointsActive", 1);
        }
    }
    n_wait = 30;
    if (bgb::is_team_enabled("zm_bgb_temporal_gift")) {
        n_wait += 30;
    }
    wait(n_wait);
    level.zombie_vars[team]["zombie_point_scalar"] = 1;
    level._race_team_double_points = undefined;
    players = getplayers();
    for (player_index = 0; player_index < players.size; player_index++) {
        if (team == players[player_index].team) {
            players[player_index] clientfield::set_player_uimodel("hudItems.doublePointsActive", 0);
        }
    }
}

