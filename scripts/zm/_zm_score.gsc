#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_stats;
#using scripts/zm/_zm_pers_upgrades_functions;
#using scripts/zm/_zm_bgb_token;
#using scripts/zm/_zm_bgb;
#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/scoreevents_shared;
#using scripts/shared/flagsys_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/callbacks_shared;
#using scripts/codescripts/struct;

#namespace zm_score;

// Namespace zm_score
// Params 0, eflags: 0x2
// Checksum 0x3e892f09, Offset: 0x6d8
// Size: 0x34
function function_2dc19561() {
    system::register("zm_score", &__init__, undefined, undefined);
}

// Namespace zm_score
// Params 0, eflags: 0x1 linked
// Checksum 0x783f4106, Offset: 0x718
// Size: 0x1ec
function __init__() {
    score_cf_register_info("damage", 1, 7);
    score_cf_register_info("death_normal", 1, 3);
    score_cf_register_info("death_torso", 1, 3);
    score_cf_register_info("death_neck", 1, 3);
    score_cf_register_info("death_head", 1, 3);
    score_cf_register_info("death_melee", 1, 3);
    clientfield::register("clientuimodel", "hudItems.doublePointsActive", 1, 1, "int");
    clientfield::register("clientuimodel", "hudItems.showDpadUp", 1, 1, "int");
    clientfield::register("clientuimodel", "hudItems.showDpadDown", 1, 1, "int");
    clientfield::register("clientuimodel", "hudItems.showDpadLeft", 1, 1, "int");
    clientfield::register("clientuimodel", "hudItems.showDpadRight", 1, 1, "int");
    callback::on_spawned(&player_on_spawned);
    level.score_total = 0;
    level.a_func_score_events = [];
}

// Namespace zm_score
// Params 2, eflags: 0x0
// Checksum 0x91648eb7, Offset: 0x910
// Size: 0x26
function register_score_event(str_event, func_callback) {
    level.a_func_score_events[str_event] = func_callback;
}

// Namespace zm_score
// Params 0, eflags: 0x1 linked
// Checksum 0xd3a8e937, Offset: 0x940
// Size: 0x24
function reset_doublexp_timer() {
    self notify(#"reset_doublexp_timer");
    self thread doublexp_timer();
}

// Namespace zm_score
// Params 0, eflags: 0x1 linked
// Checksum 0x485763c5, Offset: 0x970
// Size: 0xac
function doublexp_timer() {
    self notify(#"doublexp_timer");
    self endon(#"doublexp_timer");
    self endon(#"reset_doublexp_timer");
    self endon(#"end_game");
    level flagsys::wait_till("start_zombie_round_logic");
    if (!level.onlinegame) {
        return;
    }
    wait(60);
    if (level.onlinegame) {
        if (!isdefined(self)) {
            return;
        }
        self doublexptimerfired();
    }
    self thread reset_doublexp_timer();
}

// Namespace zm_score
// Params 0, eflags: 0x1 linked
// Checksum 0xf1800b87, Offset: 0xa28
// Size: 0x40
function player_on_spawned() {
    util::wait_network_frame();
    self thread doublexp_timer();
    if (isdefined(self)) {
        self.ready_for_score_events = 1;
    }
}

// Namespace zm_score
// Params 3, eflags: 0x1 linked
// Checksum 0x4f9dcff8, Offset: 0xa70
// Size: 0x9e
function score_cf_register_info(name, version, max_count) {
    for (i = 0; i < 4; i++) {
        clientfield::register("clientuimodel", "PlayerList.client" + i + ".score_cf_" + name, version, getminbitcountfornum(max_count), "counter");
    }
}

// Namespace zm_score
// Params 1, eflags: 0x1 linked
// Checksum 0xda6fb307, Offset: 0xb18
// Size: 0xb2
function score_cf_increment_info(name) {
    foreach (player in level.players) {
        thread function_4ef6f494(player, "PlayerList.client" + self.entity_num + ".score_cf_" + name);
    }
}

// Namespace zm_score
// Params 2, eflags: 0x1 linked
// Checksum 0xb5f8f17c, Offset: 0xbd8
// Size: 0x5c
function function_4ef6f494(player, cf) {
    if (isdefined(player.ready_for_score_events) && isdefined(player) && player.ready_for_score_events) {
        player clientfield::increment_uimodel(cf);
    }
}

// Namespace zm_score
// Params 6, eflags: 0x1 linked
// Checksum 0xa56108ca, Offset: 0xc40
// Size: 0x890
function player_add_points(event, mod, hit_location, var_ebd2ffea, zombie_team, damage_weapon) {
    if (level.intermission) {
        return;
    }
    if (!zm_utility::is_player_valid(self)) {
        return;
    }
    player_points = 0;
    team_points = 0;
    multiplier = get_points_multiplier(self);
    if (isdefined(level.a_func_score_events[event])) {
        player_points = [[ level.a_func_score_events[event] ]](event, mod, hit_location, zombie_team, damage_weapon);
    } else {
        switch (event) {
        case 38:
        case 41:
            player_points = mod;
            scoreevents::processscoreevent("kill", self, undefined, damage_weapon);
            break;
        case 39:
            player_points = function_b2baf1b5();
            team_points = function_2400b2c5();
            scoreevents::processscoreevent("kill_spider", self, undefined, damage_weapon);
            break;
        case 40:
            player_points = function_b2baf1b5();
            team_points = function_2400b2c5();
            points = self player_add_points_kill_bonus(mod, hit_location, damage_weapon);
            if (level.zombie_vars[self.team]["zombie_powerup_insta_kill_on"] == 1 && mod == "MOD_UNKNOWN") {
                points *= 2;
            }
            player_points += points;
            player_points *= 2;
            if (team_points > 0) {
                team_points += points;
            }
            if (mod == "MOD_GRENADE" || mod == "MOD_GRENADE_SPLASH") {
                self zm_stats::increment_client_stat("grenade_kills");
                self zm_stats::increment_player_stat("grenade_kills");
            }
            scoreevents::processscoreevent("kill_thrasher", self, undefined, damage_weapon);
            break;
        case 36:
            player_points = function_b2baf1b5();
            team_points = function_2400b2c5();
            points = self player_add_points_kill_bonus(mod, hit_location, damage_weapon, player_points);
            if (level.zombie_vars[self.team]["zombie_powerup_insta_kill_on"] == 1 && mod == "MOD_UNKNOWN") {
                points *= 2;
            }
            player_points += points;
            if (team_points > 0) {
                team_points += points;
            }
            if (mod == "MOD_GRENADE" || mod == "MOD_GRENADE_SPLASH") {
                self zm_stats::increment_client_stat("grenade_kills");
                self zm_stats::increment_player_stat("grenade_kills");
            }
            break;
        case 37:
            player_points = mod;
            scoreevents::processscoreevent("kill_mechz", self, undefined, damage_weapon);
            break;
        case 30:
            player_points = function_b2baf1b5() + level.zombie_vars["zombie_score_bonus_melee"];
            self score_cf_increment_info("death_melee");
            break;
        case 35:
            player_points = level.zombie_vars["zombie_score_damage_light"];
            self score_cf_increment_info("damage");
            break;
        case 1:
            player_points = level.zombie_vars["zombie_score_damage_normal"];
            self score_cf_increment_info("damage");
            break;
        case 34:
            player_points = int(level.zombie_vars["zombie_score_damage_normal"] * 1.25);
            self score_cf_increment_info("damage");
            break;
        case 33:
        case 45:
            player_points = mod;
            break;
        case 31:
            player_points = mod;
            break;
        case 44:
            player_points = mod;
            team_points = mod;
            break;
        case 43:
        case 47:
        case 48:
            player_points = mod;
            scoreevents::processscoreevent("kill", self, undefined, damage_weapon);
            break;
        case 42:
            player_points = mod;
            break;
        case 46:
            player_points = mod;
            break;
        case 49:
            player_points = mod;
            break;
        case 32:
            player_points = mod;
            break;
        case 50:
            player_points = mod;
            break;
        default:
            /#
                assert(0, "hudItems.doublePointsActive");
            #/
            break;
        }
    }
    if (isdefined(level.player_score_override)) {
        player_points = self [[ level.player_score_override ]](damage_weapon, player_points);
    }
    if (isdefined(level.var_b1bb57f0)) {
        team_points = self [[ level.var_b1bb57f0 ]](damage_weapon, team_points);
    }
    player_points = multiplier * zm_utility::round_up_score(player_points, 10);
    team_points = multiplier * zm_utility::round_up_score(team_points, 10);
    if (event == "death" || isdefined(self.point_split_receiver) && event == "ballistic_knife_death") {
        split_player_points = player_points - zm_utility::round_up_score(player_points * self.point_split_keep_percent, 10);
        self.point_split_receiver add_to_player_score(split_player_points);
        player_points -= split_player_points;
    }
    if (isdefined(level.var_cfce124) && level.var_cfce124) {
        player_points = self namespace_25f8c2ad::function_e4398b36(player_points, event, mod, damage_weapon);
    }
    self add_to_player_score(player_points, 1, event);
    self.pers["score"] = self.score;
    if (isdefined(level._game_module_point_adjustment)) {
        level [[ level._game_module_point_adjustment ]](self, zombie_team, player_points);
    }
}

// Namespace zm_score
// Params 1, eflags: 0x1 linked
// Checksum 0x7e9fece7, Offset: 0x14d8
// Size: 0x8c
function get_points_multiplier(player) {
    multiplier = level.zombie_vars[player.team]["zombie_point_scalar"];
    if (isdefined(level.current_game_module) && level.current_game_module == 2) {
        if (isdefined(level._race_team_double_points) && level._race_team_double_points == player._race_team) {
            return multiplier;
        } else {
            return 1;
        }
    }
    return multiplier;
}

// Namespace zm_score
// Params 0, eflags: 0x1 linked
// Checksum 0x61ee3752, Offset: 0x1570
// Size: 0xc6
function function_b2baf1b5() {
    players = getplayers();
    if (players.size == 1) {
        points = level.zombie_vars["zombie_score_kill_1player"];
    } else if (players.size == 2) {
        points = level.zombie_vars["zombie_score_kill_2player"];
    } else if (players.size == 3) {
        points = level.zombie_vars["zombie_score_kill_3player"];
    } else {
        points = level.zombie_vars["zombie_score_kill_4player"];
    }
    return points;
}

// Namespace zm_score
// Params 0, eflags: 0x1 linked
// Checksum 0x1c06fda4, Offset: 0x1640
// Size: 0x6
function function_2400b2c5() {
    return false;
}

// Namespace zm_score
// Params 4, eflags: 0x1 linked
// Checksum 0xa7c39cda, Offset: 0x1650
// Size: 0x2ca
function player_add_points_kill_bonus(mod, hit_location, weapon, player_points) {
    if (!isdefined(player_points)) {
        player_points = undefined;
    }
    if (mod != "MOD_MELEE") {
        if ("head" == hit_location || "helmet" == hit_location) {
            scoreevents::processscoreevent("headshot", self, undefined, weapon);
        } else {
            scoreevents::processscoreevent("kill", self, undefined, weapon);
        }
    }
    if (isdefined(level.player_score_override)) {
        new_points = self [[ level.player_score_override ]](weapon, player_points);
        if (new_points > 0 && new_points != player_points) {
            return 0;
        }
    }
    if (mod == "MOD_MELEE") {
        self score_cf_increment_info("death_melee");
        scoreevents::processscoreevent("melee_kill", self, undefined, weapon);
        return level.zombie_vars["zombie_score_bonus_melee"];
    }
    if (mod == "MOD_BURNED") {
        self score_cf_increment_info("death_torso");
        return level.zombie_vars["zombie_score_bonus_burn"];
    }
    score = 0;
    if (isdefined(hit_location)) {
        switch (hit_location) {
        case 58:
        case 59:
            self score_cf_increment_info("death_head");
            score = level.zombie_vars["zombie_score_bonus_head"];
            break;
        case 67:
            self score_cf_increment_info("death_neck");
            score = level.zombie_vars["zombie_score_bonus_neck"];
            break;
        case 68:
        case 69:
            self score_cf_increment_info("death_torso");
            score = level.zombie_vars["zombie_score_bonus_torso"];
            break;
        default:
            self score_cf_increment_info("death_normal");
            break;
        }
    }
    return score;
}

// Namespace zm_score
// Params 2, eflags: 0x1 linked
// Checksum 0x99c33277, Offset: 0x1928
// Size: 0x214
function player_reduce_points(event, n_amount) {
    if (level.intermission) {
        return;
    }
    points = 0;
    switch (event) {
    case 76:
        points = self.score;
        break;
    case 77:
        points = int(self.score / 2);
        break;
    case 78:
        points = n_amount;
        break;
    case 75:
        percent = level.zombie_vars["penalty_no_revive"];
        points = self.score * percent;
        break;
    case 73:
        percent = level.zombie_vars["penalty_died"];
        points = self.score * percent;
        break;
    case 74:
        percent = level.zombie_vars["penalty_downed"];
        self notify(#"i_am_down");
        points = self.score * percent;
        self.score_lost_when_downed = zm_utility::round_up_to_ten(int(points));
        break;
    default:
        /#
            assert(0, "hudItems.doublePointsActive");
        #/
        break;
    }
    points = self.score - zm_utility::round_up_to_ten(int(points));
    if (points < 0) {
        points = 0;
    }
    self.score = points;
}

// Namespace zm_score
// Params 3, eflags: 0x1 linked
// Checksum 0x6ac0d6a6, Offset: 0x1b48
// Size: 0x138
function add_to_player_score(points, b_add_to_total, str_awarded_by) {
    if (!isdefined(b_add_to_total)) {
        b_add_to_total = 1;
    }
    if (!isdefined(str_awarded_by)) {
        str_awarded_by = "";
    }
    if (!isdefined(points) || level.intermission) {
        return;
    }
    points = zm_utility::round_up_score(points, 10);
    n_points_to_add_to_currency = bgb::add_to_player_score_override(points, str_awarded_by);
    self.score += n_points_to_add_to_currency;
    self.pers["score"] = self.score;
    self incrementplayerstat("scoreEarned", n_points_to_add_to_currency);
    level notify(#"earned_points", self, points);
    if (b_add_to_total) {
        self.score_total += points;
        level.score_total += points;
    }
}

// Namespace zm_score
// Params 1, eflags: 0x1 linked
// Checksum 0x9b24402b, Offset: 0x1c88
// Size: 0x11c
function minus_to_player_score(points) {
    if (!isdefined(points) || level.intermission) {
        return;
    }
    if (self bgb::is_enabled("zm_bgb_shopping_free")) {
        self bgb::do_one_shot_use();
        self playsoundtoplayer("zmb_bgb_shoppingfree_coinreturn", self);
        return;
    }
    self.score -= points;
    self.pers["score"] = self.score;
    self incrementplayerstat("scoreSpent", points);
    level notify(#"spent_points", self, points);
    if (isdefined(level.bgb_in_use) && level.bgb_in_use && level.onlinegame) {
        self namespace_ade8e118::function_51cf4361(points);
    }
}

// Namespace zm_score
// Params 1, eflags: 0x0
// Checksum 0x78584a02, Offset: 0x1db0
// Size: 0xc
function add_to_team_score(points) {
    
}

// Namespace zm_score
// Params 1, eflags: 0x0
// Checksum 0x1b93df85, Offset: 0x1dc8
// Size: 0xc
function minus_to_team_score(points) {
    
}

// Namespace zm_score
// Params 0, eflags: 0x1 linked
// Checksum 0xe69d43f9, Offset: 0x1de0
// Size: 0xa6
function player_died_penalty() {
    players = getplayers(self.team);
    for (i = 0; i < players.size; i++) {
        if (players[i] != self && !players[i].is_zombie) {
            players[i] player_reduce_points("no_revive_penalty");
        }
    }
}

// Namespace zm_score
// Params 0, eflags: 0x1 linked
// Checksum 0x2586a463, Offset: 0x1e90
// Size: 0x44
function player_downed_penalty() {
    /#
        println("hudItems.doublePointsActive");
    #/
    self player_reduce_points("downed");
}

// Namespace zm_score
// Params 1, eflags: 0x1 linked
// Checksum 0x77a3bee6, Offset: 0x1ee0
// Size: 0x46
function can_player_purchase(n_cost) {
    if (self.score >= n_cost) {
        return true;
    }
    if (self bgb::is_enabled("zm_bgb_shopping_free")) {
        return true;
    }
    return false;
}

