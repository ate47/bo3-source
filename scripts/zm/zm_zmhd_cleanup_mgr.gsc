#using scripts/zm/_zm_zonemgr;
#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_spawner;
#using scripts/shared/ai/zombie_utility;
#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/array_shared;
#using scripts/codescripts/struct;

#namespace namespace_2d028ffb;

// Namespace namespace_2d028ffb
// Params 0, eflags: 0x2
// Checksum 0x11296356, Offset: 0x1d8
// Size: 0x3c
function function_2dc19561() {
    system::register("zmhd_cleanup", &__init__, &__main__, undefined);
}

// Namespace namespace_2d028ffb
// Params 0, eflags: 0x0
// Checksum 0x33f9845e, Offset: 0x220
// Size: 0x24
function __init__() {
    level.n_cleanups_processed_this_frame = 0;
    level.no_target_override = &no_target_override;
}

// Namespace namespace_2d028ffb
// Params 0, eflags: 0x0
// Checksum 0x6fb5edbd, Offset: 0x250
// Size: 0x1c
function __main__() {
    level thread cleanup_main();
}

// Namespace namespace_2d028ffb
// Params 0, eflags: 0x0
// Checksum 0x253d1fbf, Offset: 0x278
// Size: 0x12
function force_check_now() {
    level notify(#"pump_distance_check");
}

// Namespace namespace_2d028ffb
// Params 0, eflags: 0x4
// Checksum 0x92d85409, Offset: 0x298
// Size: 0x296
function cleanup_main() {
    n_next_eval = 0;
    while (true) {
        util::wait_network_frame();
        n_time = gettime();
        if (n_time < n_next_eval) {
            continue;
        }
        if (isdefined(level.n_cleanup_manager_restart_time)) {
            n_current_time = gettime() / 1000;
            n_delta_time = n_current_time - level.n_cleanup_manager_restart_time;
            if (n_delta_time < 0) {
                continue;
            }
            level.n_cleanup_manager_restart_time = undefined;
        }
        n_round_time = (n_time - level.round_start_time) / 1000;
        if (level.round_number <= 5 && n_round_time < 30) {
            continue;
        } else if (level.round_number > 5 && n_round_time < 20) {
            continue;
        }
        if (isdefined(level.var_ae0a0c99) && level.var_ae0a0c99) {
            continue;
        }
        n_override_cleanup_dist_sq = undefined;
        if (level.zombie_total == 0 && zombie_utility::get_current_zombie_count() < 3) {
            n_override_cleanup_dist_sq = 2250000;
        }
        n_next_eval += 3000;
        a_ai_enemies = getaiteamarray("axis");
        foreach (ai_enemy in a_ai_enemies) {
            if (level.n_cleanups_processed_this_frame >= 1) {
                level.n_cleanups_processed_this_frame = 0;
                util::wait_network_frame();
            }
            if (isdefined(ai_enemy) && !(isdefined(ai_enemy.ignore_cleanup_mgr) && ai_enemy.ignore_cleanup_mgr)) {
                ai_enemy do_cleanup_check(n_override_cleanup_dist_sq);
            }
        }
    }
}

// Namespace namespace_2d028ffb
// Params 1, eflags: 0x0
// Checksum 0x48e704e6, Offset: 0x538
// Size: 0x278
function do_cleanup_check(n_override_cleanup_dist) {
    if (!isalive(self)) {
        return;
    }
    if (self.b_ignore_cleanup === 1) {
        return;
    }
    n_time_alive = gettime() - self.spawn_time;
    if (n_time_alive < 5000) {
        return;
    }
    if (self.archetype === "zombie") {
        if (n_time_alive < 45000 && self.script_string !== "find_flesh" && self.completed_emerging_into_playable_area !== 1) {
            return;
        }
    }
    b_in_active_zone = self zm_zonemgr::entity_in_active_zone();
    level.n_cleanups_processed_this_frame++;
    if (!b_in_active_zone) {
        n_dist_sq_min = 10000000;
        e_closest_player = level.activeplayers[0];
        foreach (player in level.activeplayers) {
            n_dist_sq = distancesquared(self.origin, player.origin);
            if (n_dist_sq < n_dist_sq_min) {
                n_dist_sq_min = n_dist_sq;
                e_closest_player = player;
            }
        }
        if (isdefined(n_override_cleanup_dist)) {
            n_cleanup_dist_sq = n_override_cleanup_dist;
        } else if (isdefined(e_closest_player) && player_ahead_of_me(e_closest_player)) {
            n_cleanup_dist_sq = 189225;
        } else {
            n_cleanup_dist_sq = 250000;
        }
        if (n_dist_sq_min >= n_cleanup_dist_sq) {
            self thread delete_zombie_noone_looking();
        }
    }
    if (!isalive(self)) {
        return;
    }
}

// Namespace namespace_2d028ffb
// Params 0, eflags: 0x4
// Checksum 0x74173f2e, Offset: 0x7b8
// Size: 0x27c
function delete_zombie_noone_looking() {
    if (isdefined(self.in_the_ground) && self.in_the_ground) {
        return;
    }
    foreach (player in level.players) {
        if (player.sessionstate == "spectator") {
            continue;
        }
        if (self player_can_see_me(player)) {
            return;
        }
    }
    if (!(isdefined(self.exclude_cleanup_adding_to_total) && self.exclude_cleanup_adding_to_total)) {
        level.zombie_total++;
        level.zombie_respawns++;
        if (self.health < self.maxhealth) {
            if (!isdefined(level.var_5a487977[self.archetype])) {
                level.var_5a487977[self.archetype] = [];
            }
            if (!isdefined(level.var_5a487977[self.archetype])) {
                level.var_5a487977[self.archetype] = [];
            } else if (!isarray(level.var_5a487977[self.archetype])) {
                level.var_5a487977[self.archetype] = array(level.var_5a487977[self.archetype]);
            }
            level.var_5a487977[self.archetype][level.var_5a487977[self.archetype].size] = self.health;
        }
    }
    self zombie_utility::reset_attack_spot();
    if (!(isdefined(self.magic_bullet_shield) && self.magic_bullet_shield)) {
        self kill();
        wait(0.05);
        if (isdefined(self)) {
            /#
                debugstar(self.origin, 1000, (1, 1, 1));
            #/
            self delete();
        }
    }
}

// Namespace namespace_2d028ffb
// Params 1, eflags: 0x0
// Checksum 0x7e4d15a2, Offset: 0xa40
// Size: 0xd8
function player_can_see_me(player) {
    v_player_angles = player getplayerangles();
    v_player_forward = anglestoforward(v_player_angles);
    var_47fa366e = self.origin - player getorigin();
    var_47fa366e = vectornormalize(var_47fa366e);
    n_dot = vectordot(v_player_forward, var_47fa366e);
    if (n_dot < 0.766) {
        return false;
    }
    return true;
}

// Namespace namespace_2d028ffb
// Params 1, eflags: 0x4
// Checksum 0x82c85fe1, Offset: 0xb20
// Size: 0xb4
function player_ahead_of_me(player) {
    v_player_angles = player getplayerangles();
    v_player_forward = anglestoforward(v_player_angles);
    v_dir = player getorigin() - self.origin;
    n_dot = vectordot(v_player_forward, v_dir);
    if (n_dot < 0) {
        return false;
    }
    return true;
}

// Namespace namespace_2d028ffb
// Params 1, eflags: 0x0
// Checksum 0x4a1bbd06, Offset: 0xbe0
// Size: 0x11e
function get_adjacencies_to_zone(str_zone) {
    a_adjacencies = [];
    a_adjacencies[0] = str_zone;
    a_adjacent_zones = getarraykeys(level.zones[str_zone].adjacent_zones);
    for (i = 0; i < a_adjacent_zones.size; i++) {
        if (level.zones[str_zone].adjacent_zones[a_adjacent_zones[i]].is_connected) {
            if (!isdefined(a_adjacencies)) {
                a_adjacencies = [];
            } else if (!isarray(a_adjacencies)) {
                a_adjacencies = array(a_adjacencies);
            }
            a_adjacencies[a_adjacencies.size] = a_adjacent_zones[i];
        }
    }
    return a_adjacencies;
}

// Namespace namespace_2d028ffb
// Params 1, eflags: 0x0
// Checksum 0xc34c3eef, Offset: 0xd08
// Size: 0x64
function no_target_override(ai_zombie) {
    if (isdefined(self.var_c74f5ce8) && self.var_c74f5ce8) {
        return;
    }
    var_b52b26b9 = ai_zombie get_escape_position();
    ai_zombie thread function_dc683d01(var_b52b26b9);
}

// Namespace namespace_2d028ffb
// Params 0, eflags: 0x4
// Checksum 0xcf803e8f, Offset: 0xd78
// Size: 0x14e
function get_escape_position() {
    self endon(#"death");
    str_zone = zm_zonemgr::get_zone_from_position(self.origin + (0, 0, 32), 1);
    if (!isdefined(str_zone)) {
        str_zone = self.zone_name;
    }
    if (isdefined(str_zone)) {
        a_zones = get_adjacencies_to_zone(str_zone);
        a_wait_locations = get_wait_locations_in_zones(a_zones);
        arraysortclosest(a_wait_locations, self.origin);
        a_wait_locations = array::reverse(a_wait_locations);
        for (i = 0; i < a_wait_locations.size; i++) {
            if (a_wait_locations[i] function_eadbcbdb()) {
                return a_wait_locations[i].origin;
            }
        }
    }
    return self.origin;
}

// Namespace namespace_2d028ffb
// Params 1, eflags: 0x4
// Checksum 0x292ba65, Offset: 0xed0
// Size: 0xc2
function function_dc683d01(var_b52b26b9) {
    self endon(#"death");
    self notify(#"stop_find_flesh");
    self notify(#"zombie_acquire_enemy");
    self.ignoreall = 1;
    self.var_c74f5ce8 = 1;
    self thread function_30b905e5();
    self setgoal(var_b52b26b9);
    self util::waittill_any_timeout(30, "goal", "reaquire_player");
    self.ai_state = "find_flesh";
    self.ignoreall = 0;
    self.var_c74f5ce8 = undefined;
}

// Namespace namespace_2d028ffb
// Params 0, eflags: 0x4
// Checksum 0xe00f5c7b, Offset: 0xfa0
// Size: 0x78
function function_30b905e5() {
    self endon(#"death");
    while (isdefined(self.var_c74f5ce8) && self.var_c74f5ce8) {
        wait(randomfloatrange(0.2, 0.5));
        if (self function_9de8a8db()) {
            self.var_c74f5ce8 = undefined;
            self notify(#"hash_c68d373");
            return;
        }
    }
}

// Namespace namespace_2d028ffb
// Params 0, eflags: 0x4
// Checksum 0x911f0fe, Offset: 0x1020
// Size: 0xee
function function_9de8a8db() {
    a_players = getplayers();
    for (i = 0; i < a_players.size; i++) {
        if (isdefined(a_players[i].ignoreme) && (!zombie_utility::is_player_valid(a_players[i]) || a_players[i].ignoreme)) {
            continue;
        }
        if (self maymovetopoint(a_players[i].origin, 1)) {
            return 1;
        }
    }
    if (isdefined(level.var_7c29c50e)) {
        return self [[ level.var_7c29c50e ]]();
    }
    return 0;
}

// Namespace namespace_2d028ffb
// Params 1, eflags: 0x4
// Checksum 0xfd091382, Offset: 0x1118
// Size: 0x11e
function get_wait_locations_in_zones(a_zones) {
    a_wait_locations = [];
    foreach (zone in a_zones) {
        if (isdefined(level.zones[zone].a_loc_types["wait_location"])) {
            a_wait_locations = arraycombine(a_wait_locations, level.zones[zone].a_loc_types["wait_location"], 0, 0);
            continue;
        }
        /#
            iprintlnbold("<unknown string>" + zone);
        #/
    }
    return a_wait_locations;
}

// Namespace namespace_2d028ffb
// Params 0, eflags: 0x4
// Checksum 0xd90905a, Offset: 0x1240
// Size: 0x5e
function function_eadbcbdb() {
    if (!isdefined(self)) {
        return 0;
    }
    if (!ispointonnavmesh(self.origin) || !zm_utility::check_point_in_playable_area(self.origin)) {
        return 0;
    }
    return 1;
}

