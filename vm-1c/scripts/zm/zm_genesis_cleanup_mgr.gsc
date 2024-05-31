#using scripts/zm/_zm_shadow_zombie;
#using scripts/zm/_zm_light_zombie;
#using scripts/zm/_zm_elemental_zombies;
#using scripts/zm/_zm_zonemgr;
#using scripts/zm/_zm_utility;
#using scripts/shared/ai/zombie_utility;
#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/array_shared;
#using scripts/codescripts/struct;

#namespace namespace_d5b9f994;

// Namespace namespace_d5b9f994
// Params 0, eflags: 0x2
// Checksum 0x432acfad, Offset: 0x2b0
// Size: 0x3c
function autoexec function_2dc19561() {
    system::register("genesis_cleanup", &__init__, &__main__, undefined);
}

// Namespace namespace_d5b9f994
// Params 0, eflags: 0x1 linked
// Checksum 0xbdc857c7, Offset: 0x2f8
// Size: 0x10
function __init__() {
    level.n_cleanups_processed_this_frame = 0;
}

// Namespace namespace_d5b9f994
// Params 0, eflags: 0x1 linked
// Checksum 0xee15352e, Offset: 0x310
// Size: 0x34
function __main__() {
    level thread cleanup_main();
    level.no_target_override = &no_target_override;
}

// Namespace namespace_d5b9f994
// Params 0, eflags: 0x0
// Checksum 0xc6097d, Offset: 0x350
// Size: 0x12
function force_check_now() {
    level notify(#"pump_distance_check");
}

// Namespace namespace_d5b9f994
// Params 0, eflags: 0x5 linked
// Checksum 0xa6449552, Offset: 0x370
// Size: 0x1fe
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
        n_next_eval += 3000;
        a_ai_enemies = getaiteamarray("axis");
        foreach (ai_enemy in a_ai_enemies) {
            if (level.n_cleanups_processed_this_frame >= 1) {
                level.n_cleanups_processed_this_frame = 0;
                util::wait_network_frame();
            }
            ai_enemy do_cleanup_check();
        }
    }
}

// Namespace namespace_d5b9f994
// Params 0, eflags: 0x5 linked
// Checksum 0x70b6f908, Offset: 0x578
// Size: 0x200
function private function_37a5b776() {
    var_a8951c29 = [];
    var_9e84b959 = array("start_island", "apothicon_island", "temple_island", "prototype_island", "asylum_island", "prison_island", "arena_island");
    for (i = 0; i < var_9e84b959.size; i++) {
        var_94e9acae = getent(var_9e84b959[i], "targetname");
        for (j = 0; j < level.activeplayers.size; j++) {
            if (!isalive(level.activeplayers[j])) {
                continue;
            }
            if (isdefined(level.activeplayers[j].is_flung) && level.activeplayers[j].is_flung) {
                return true;
            }
            if (level.activeplayers[j] istouching(var_94e9acae)) {
                array::add(var_a8951c29, var_94e9acae, 0);
            }
        }
    }
    if (!var_a8951c29.size) {
        return true;
    } else {
        for (k = 0; k < var_a8951c29.size; k++) {
            if (self istouching(var_a8951c29[k])) {
                return true;
            }
        }
    }
    return false;
}

// Namespace namespace_d5b9f994
// Params 0, eflags: 0x1 linked
// Checksum 0x10c53b9, Offset: 0x780
// Size: 0x2f4
function do_cleanup_check() {
    if (!isalive(self)) {
        return;
    }
    if (self.archetype === "margwa" || self.archetype === "mechz") {
        return;
    }
    if (self.b_ignore_cleanup === 1) {
        return;
    }
    if (isdefined(self.b_teleporting) && self.b_teleporting) {
        return;
    }
    if (isdefined(self.traversal)) {
        return;
    }
    if (!self function_37a5b776()) {
        self thread function_b4d588f5();
        return;
    }
    if (isdefined(self.var_6d2a9142) && self.var_6d2a9142) {
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
        if (isdefined(level.n_override_cleanup_dist_sq)) {
            n_cleanup_dist_sq = level.n_override_cleanup_dist_sq;
        } else if (isdefined(e_closest_player) && player_ahead_of_me(e_closest_player)) {
            n_cleanup_dist_sq = 176400;
        } else {
            n_cleanup_dist_sq = 230400;
        }
        if (n_dist_sq_min >= n_cleanup_dist_sq) {
            self thread delete_zombie_noone_looking();
        }
    }
}

// Namespace namespace_d5b9f994
// Params 0, eflags: 0x1 linked
// Checksum 0x3b20b840, Offset: 0xa80
// Size: 0xdc
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
    self thread function_b4d588f5();
}

// Namespace namespace_d5b9f994
// Params 0, eflags: 0x5 linked
// Checksum 0xba8c5daf, Offset: 0xb68
// Size: 0x24c
function private function_b4d588f5() {
    if (!(isdefined(self.exclude_cleanup_adding_to_total) && self.exclude_cleanup_adding_to_total)) {
        level.zombie_total++;
        level.zombie_respawns++;
        self.var_4d11bb60 = 1;
        if (isdefined(self.maxhealth) && self.health < self.maxhealth) {
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
        if (isdefined(self.var_9a02a614)) {
            if (!isdefined(level.var_22060a89[self.var_9a02a614])) {
                level.var_22060a89[self.var_9a02a614] = 0;
            }
            level.var_22060a89[self.var_9a02a614]++;
        } else {
            if (!isdefined(level.var_22060a89[self.archetype])) {
                level.var_22060a89[self.archetype] = 0;
            }
            level.var_22060a89[self.archetype]++;
        }
    }
    self zombie_utility::reset_attack_spot();
    self kill();
    wait(0.05);
    if (isdefined(self)) {
        /#
            debugstar(self.origin, 1000, (1, 1, 1));
        #/
        self delete();
    }
}

// Namespace namespace_d5b9f994
// Params 1, eflags: 0x1 linked
// Checksum 0x767ad3aa, Offset: 0xdc0
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

// Namespace namespace_d5b9f994
// Params 1, eflags: 0x5 linked
// Checksum 0xc377fd5a, Offset: 0xea0
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

// Namespace namespace_d5b9f994
// Params 1, eflags: 0x1 linked
// Checksum 0xcecce33d, Offset: 0xf60
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

// Namespace namespace_d5b9f994
// Params 1, eflags: 0x5 linked
// Checksum 0x1881bc16, Offset: 0x1088
// Size: 0xd6
function private get_farthest_wait_location(var_aabb7ed9) {
    if (!isdefined(var_aabb7ed9) || var_aabb7ed9.size == 0) {
        return undefined;
    }
    var_61c71098 = 0;
    var_1bfac935 = 0;
    for (i = 0; i < var_aabb7ed9.size; i++) {
        n_distance_sq = distancesquared(self.origin, var_aabb7ed9[i].origin);
        if (n_distance_sq > var_1bfac935) {
            var_1bfac935 = n_distance_sq;
            var_61c71098 = i;
        }
    }
    return var_aabb7ed9[var_61c71098];
}

// Namespace namespace_d5b9f994
// Params 1, eflags: 0x5 linked
// Checksum 0x6f28e452, Offset: 0x1168
// Size: 0x88
function private get_wait_locations_in_zone(zone) {
    if (isdefined(level.zones[zone].a_loc_types["wait_location"])) {
        var_aabb7ed9 = [];
        var_aabb7ed9 = arraycombine(var_aabb7ed9, level.zones[zone].a_loc_types["wait_location"], 0, 0);
        return var_aabb7ed9;
    }
    return undefined;
}

// Namespace namespace_d5b9f994
// Params 0, eflags: 0x0
// Checksum 0xf160fc8d, Offset: 0x11f8
// Size: 0x9c
function get_escape_position_in_current_zone() {
    self endon(#"death");
    str_zone = self.zone_name;
    if (!isdefined(str_zone)) {
        str_zone = self.zone_name;
    }
    if (isdefined(str_zone)) {
        var_aabb7ed9 = get_wait_locations_in_zone(str_zone);
        if (isdefined(var_aabb7ed9)) {
            s_farthest = self get_farthest_wait_location(var_aabb7ed9);
        }
    }
    return s_farthest;
}

// Namespace namespace_d5b9f994
// Params 1, eflags: 0x1 linked
// Checksum 0x5dec02f8, Offset: 0x12a0
// Size: 0x64
function no_target_override(ai_zombie) {
    if (isdefined(self.var_c74f5ce8) && self.var_c74f5ce8) {
        return;
    }
    var_b52b26b9 = ai_zombie get_escape_position();
    ai_zombie thread function_dc683d01(var_b52b26b9);
}

// Namespace namespace_d5b9f994
// Params 0, eflags: 0x5 linked
// Checksum 0xbf29485a, Offset: 0x1310
// Size: 0x146
function private get_escape_position() {
    str_zone = zm_zonemgr::get_zone_from_position(self.origin + (0, 0, 32), 1);
    if (!isdefined(str_zone)) {
        str_zone = self.zone_name;
    }
    if (isdefined(str_zone)) {
        a_str_zones = get_adjacencies_to_zone(str_zone);
        var_aabb7ed9 = get_wait_locations_in_zones(a_str_zones);
        arraysortclosest(var_aabb7ed9, self.origin);
        var_aabb7ed9 = array::reverse(var_aabb7ed9);
        for (i = 0; i < var_aabb7ed9.size; i++) {
            if (var_aabb7ed9[i] function_eadbcbdb()) {
                return var_aabb7ed9[i].origin;
            }
        }
    }
    return self.origin;
}

// Namespace namespace_d5b9f994
// Params 1, eflags: 0x5 linked
// Checksum 0x9dcf6784, Offset: 0x1460
// Size: 0xd2
function private get_wait_locations_in_zones(a_str_zones) {
    var_aabb7ed9 = [];
    foreach (str_zone in a_str_zones) {
        var_aabb7ed9 = arraycombine(var_aabb7ed9, level.zones[str_zone].a_loc_types["wait_location"], 0, 0);
    }
    return var_aabb7ed9;
}

// Namespace namespace_d5b9f994
// Params 0, eflags: 0x5 linked
// Checksum 0xc861f7a5, Offset: 0x1540
// Size: 0x5e
function private function_eadbcbdb() {
    if (!isdefined(self)) {
        return 0;
    }
    if (!ispointonnavmesh(self.origin) || !zm_utility::check_point_in_playable_area(self.origin)) {
        return 0;
    }
    return 1;
}

// Namespace namespace_d5b9f994
// Params 1, eflags: 0x5 linked
// Checksum 0x41928988, Offset: 0x15a8
// Size: 0xca
function private function_dc683d01(var_b52b26b9) {
    self endon(#"death");
    self notify(#"stop_find_flesh");
    self notify(#"zombie_acquire_enemy");
    self.ignoreall = 1;
    self.var_c74f5ce8 = 1;
    self thread function_30b905e5();
    self setgoal(var_b52b26b9);
    self util::waittill_any_timeout(30, "goal", "reaquire_player", "death");
    self.ai_state = "find_flesh";
    self.ignoreall = 0;
    self.var_c74f5ce8 = undefined;
}

// Namespace namespace_d5b9f994
// Params 0, eflags: 0x5 linked
// Checksum 0x76d5c3e4, Offset: 0x1680
// Size: 0x78
function private function_30b905e5() {
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

// Namespace namespace_d5b9f994
// Params 0, eflags: 0x5 linked
// Checksum 0x44747d87, Offset: 0x1700
// Size: 0x80
function private function_9de8a8db() {
    for (i = 0; i < level.activeplayers.size; i++) {
        if (zombie_utility::is_player_valid(level.activeplayers[i])) {
            if (self function_ca420408(level.activeplayers[i])) {
                return true;
            }
        }
        wait(0.1);
    }
    return false;
}

// Namespace namespace_d5b9f994
// Params 1, eflags: 0x1 linked
// Checksum 0x165d5985, Offset: 0x1788
// Size: 0xe6
function function_ca420408(player) {
    var_334f2464 = undefined;
    str_player_zone = undefined;
    var_334f2464 = zm_zonemgr::get_zone_from_position(self.origin + (0, 0, 32), 1);
    if (isdefined(player.zone_name)) {
        a_str_zones = get_adjacencies_to_zone(player.zone_name);
        for (i = 0; i < a_str_zones.size; i++) {
            if (var_334f2464 === a_str_zones[i]) {
                return true;
            }
        }
    }
    return false;
}

