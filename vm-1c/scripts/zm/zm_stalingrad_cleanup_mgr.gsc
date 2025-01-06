#using scripts/codescripts/struct;
#using scripts/shared/ai/zombie_utility;
#using scripts/shared/array_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_zonemgr;

#namespace stalingrad_cleanup;

// Namespace stalingrad_cleanup
// Params 0, eflags: 0x2
// Checksum 0x69e8433, Offset: 0x1e8
// Size: 0x3c
function autoexec function_2dc19561() {
    system::register("stalingrad_cleanup", &__init__, &__main__, undefined);
}

// Namespace stalingrad_cleanup
// Params 0, eflags: 0x0
// Checksum 0xcb54c765, Offset: 0x230
// Size: 0x10
function __init__() {
    level.n_cleanups_processed_this_frame = 0;
}

// Namespace stalingrad_cleanup
// Params 0, eflags: 0x0
// Checksum 0xf3b1b5cc, Offset: 0x248
// Size: 0x1c
function __main__() {
    level thread cleanup_main();
}

// Namespace stalingrad_cleanup
// Params 0, eflags: 0x0
// Checksum 0x2ad5eb8f, Offset: 0x270
// Size: 0x12
function force_check_now() {
    level notify(#"pump_distance_check");
}

// Namespace stalingrad_cleanup
// Params 0, eflags: 0x4
// Checksum 0x520c75e1, Offset: 0x290
// Size: 0x20e
function private cleanup_main() {
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
        n_override_cleanup_dist_sq = undefined;
        n_next_eval += 3000;
        a_ai_enemies = getaiteamarray("axis");
        foreach (ai_enemy in a_ai_enemies) {
            if (level.n_cleanups_processed_this_frame >= 1) {
                level.n_cleanups_processed_this_frame = 0;
                util::wait_network_frame();
            }
            ai_enemy do_cleanup_check(n_override_cleanup_dist_sq);
        }
    }
}

// Namespace stalingrad_cleanup
// Params 1, eflags: 0x0
// Checksum 0x83c9465a, Offset: 0x4a8
// Size: 0x274
function do_cleanup_check(n_override_cleanup_dist) {
    if (!isalive(self)) {
        return;
    }
    if (isdefined(self.var_c3cb9d57)) {
        return [[ self.var_c3cb9d57 ]]();
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
            self thread cleanup_zombie();
        }
    }
}

// Namespace stalingrad_cleanup
// Params 1, eflags: 0x0
// Checksum 0x216e4666, Offset: 0x728
// Size: 0x3cc
function cleanup_zombie(var_1503b3f8) {
    if (!isdefined(var_1503b3f8)) {
        var_1503b3f8 = 1;
    }
    if (isdefined(self.var_f3f07a33) && (isdefined(self.in_the_ground) && self.in_the_ground || self.var_f3f07a33)) {
        return;
    }
    if (var_1503b3f8) {
        foreach (player in level.players) {
            var_c3cc60d3 = 0;
            var_4d53d2ae = 0;
            if (isdefined(player.zone_name)) {
                if (player.zone_name == "pavlovs_A_zone" || player.zone_name == "pavlovs_B_zone" || player.zone_name == "pavlovs_C_zone") {
                    var_c3cc60d3 = 1;
                }
            }
            if (isdefined(self.zone_name)) {
                if (self.zone_name == "pavlovs_A_zone" || self.zone_name == "pavlovs_B_zone" || self.zone_name == "pavlovs_C_zone") {
                    var_4d53d2ae = 1;
                }
            }
            if (isdefined(self.var_edfdda83) && self.var_edfdda83) {
                var_4d53d2ae = 1;
            }
            if (var_c3cc60d3 != var_4d53d2ae) {
                continue;
            }
            if (player.sessionstate == "spectator") {
                continue;
            }
            if (self player_can_see_me(player)) {
                return;
            }
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
    self.var_4d11bb60 = 1;
    self kill();
    wait 0.05;
    if (isdefined(self)) {
        /#
            debugstar(self.origin, 1000, (1, 1, 1));
        #/
        self delete();
    }
}

// Namespace stalingrad_cleanup
// Params 1, eflags: 0x4
// Checksum 0x28b3c664, Offset: 0xb00
// Size: 0xd8
function private player_can_see_me(player) {
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

// Namespace stalingrad_cleanup
// Params 1, eflags: 0x4
// Checksum 0x9047645f, Offset: 0xbe0
// Size: 0xb4
function private player_ahead_of_me(player) {
    v_player_angles = player getplayerangles();
    v_player_forward = anglestoforward(v_player_angles);
    v_dir = player getorigin() - self.origin;
    n_dot = vectordot(v_player_forward, v_dir);
    if (n_dot < 0) {
        return false;
    }
    return true;
}

// Namespace stalingrad_cleanup
// Params 0, eflags: 0x0
// Checksum 0x94df6de3, Offset: 0xca0
// Size: 0xb4
function get_escape_position() {
    self endon(#"death");
    str_zone = self.zone_name;
    if (!isdefined(str_zone)) {
        str_zone = self.zone_name;
    }
    if (isdefined(str_zone)) {
        a_zones = get_adjacencies_to_zone(str_zone);
        a_wait_locations = get_wait_locations_in_zones(a_zones);
        s_farthest = self get_farthest_wait_location(a_wait_locations);
    }
    return s_farthest;
}

// Namespace stalingrad_cleanup
// Params 1, eflags: 0x0
// Checksum 0x59d63f4a, Offset: 0xd60
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

// Namespace stalingrad_cleanup
// Params 1, eflags: 0x4
// Checksum 0x6af466ae, Offset: 0xe88
// Size: 0xd2
function private get_wait_locations_in_zones(a_zones) {
    a_wait_locations = [];
    foreach (zone in a_zones) {
        a_wait_locations = arraycombine(a_wait_locations, level.zones[zone].a_loc_types["wait_location"], 0, 0);
    }
    return a_wait_locations;
}

// Namespace stalingrad_cleanup
// Params 1, eflags: 0x4
// Checksum 0xae1ea513, Offset: 0xf68
// Size: 0xd6
function private get_farthest_wait_location(a_wait_locations) {
    if (!isdefined(a_wait_locations) || a_wait_locations.size == 0) {
        return undefined;
    }
    var_61c71098 = 0;
    var_1bfac935 = 0;
    for (i = 0; i < a_wait_locations.size; i++) {
        n_distance_sq = distancesquared(self.origin, a_wait_locations[i].origin);
        if (n_distance_sq > var_1bfac935) {
            var_1bfac935 = n_distance_sq;
            var_61c71098 = i;
        }
    }
    return a_wait_locations[var_61c71098];
}

// Namespace stalingrad_cleanup
// Params 1, eflags: 0x4
// Checksum 0xdf5eeba0, Offset: 0x1048
// Size: 0x88
function private get_wait_locations_in_zone(zone) {
    if (isdefined(level.zones[zone].a_loc_types["wait_location"])) {
        a_wait_locations = [];
        a_wait_locations = arraycombine(a_wait_locations, level.zones[zone].a_loc_types["wait_location"], 0, 0);
        return a_wait_locations;
    }
    return undefined;
}

// Namespace stalingrad_cleanup
// Params 0, eflags: 0x0
// Checksum 0x612642b6, Offset: 0x10d8
// Size: 0x9c
function get_escape_position_in_current_zone() {
    self endon(#"death");
    str_zone = self.zone_name;
    if (!isdefined(str_zone)) {
        str_zone = self.zone_name;
    }
    if (isdefined(str_zone)) {
        a_wait_locations = get_wait_locations_in_zone(str_zone);
        if (isdefined(a_wait_locations)) {
            s_farthest = self get_farthest_wait_location(a_wait_locations);
        }
    }
    return s_farthest;
}

