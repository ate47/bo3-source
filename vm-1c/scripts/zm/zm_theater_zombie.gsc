#using scripts/zm/_zm_zonemgr;
#using scripts/zm/_zm_laststand;
#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_devgui;
#using scripts/zm/zm_remaster_zombie;
#using scripts/shared/ai/zombie_utility;
#using scripts/shared/ai/zombie;
#using scripts/shared/laststand_shared;
#using scripts/shared/ai/systems/blackboard;
#using scripts/shared/ai/systems/behavior_tree_utility;
#using scripts/shared/ai/systems/animation_state_machine_utility;
#using scripts/shared/ai/systems/animation_state_machine_notetracks;
#using scripts/shared/ai/systems/animation_state_machine_mocomp;
#using scripts/shared/util_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/flagsys_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/array_shared;
#using scripts/shared/ai_shared;
#using scripts/codescripts/struct;

#namespace namespace_38087cad;

// Namespace namespace_38087cad
// Params 0, eflags: 0x2
// Checksum 0xe1ab5da7, Offset: 0x3a8
// Size: 0x64
function autoexec init() {
    setdvar("scr_zm_use_code_enemy_selection", 0);
    level.closest_player_override = &function_4fbc4348;
    level thread function_72e6c1d6();
    level.var_11c66679 = 1;
    level.var_1ace2307 = 2;
}

// Namespace namespace_38087cad
// Params 1, eflags: 0x5 linked
// Checksum 0x6c37284f, Offset: 0x418
// Size: 0x58
function private function_ce2310c1(player) {
    return !(isdefined(player.var_947f1a5b) && player.var_947f1a5b) && !(isdefined(player.var_a7ffe97c) && player.var_a7ffe97c);
}

// Namespace namespace_38087cad
// Params 1, eflags: 0x5 linked
// Checksum 0x32b1b233, Offset: 0x478
// Size: 0x12a
function private function_9b4b4134(players) {
    if (isdefined(self.last_closest_player.am_i_valid) && isdefined(self.last_closest_player) && self.last_closest_player.am_i_valid && function_ce2310c1(self.last_closest_player)) {
        return;
    }
    self.need_closest_player = 1;
    foreach (player in players) {
        if (isdefined(player.am_i_valid) && function_ce2310c1(player) && player.am_i_valid) {
            self.last_closest_player = player;
            return;
        }
    }
    self.last_closest_player = undefined;
}

// Namespace namespace_38087cad
// Params 2, eflags: 0x1 linked
// Checksum 0x933f06aa, Offset: 0x5b0
// Size: 0x2da
function function_4fbc4348(origin, players) {
    if (players.size == 0) {
        return undefined;
    }
    if (isdefined(self.zombie_poi)) {
        return undefined;
    }
    if (players.size == 1) {
        if (function_ce2310c1(players[0])) {
            self.last_closest_player = players[0];
            return self.last_closest_player;
        }
        return undefined;
    }
    if (!isdefined(self.last_closest_player)) {
        self.last_closest_player = players[0];
    }
    if (isdefined(self.v_zombie_custom_goal_pos)) {
        return self.last_closest_player;
    }
    if (!isdefined(self.need_closest_player)) {
        self.need_closest_player = 1;
    }
    if (isdefined(level.last_closest_time) && level.last_closest_time >= level.time) {
        self function_9b4b4134(players);
        return self.last_closest_player;
    }
    if (isdefined(self.need_closest_player) && self.need_closest_player) {
        level.last_closest_time = level.time;
        self.need_closest_player = 0;
        closest = players[0];
        if (function_ce2310c1(players[0])) {
            closest_dist = self zm_utility::approximate_path_dist(closest);
        }
        if (!isdefined(closest_dist)) {
            closest = undefined;
        }
        for (index = 1; index < players.size; index++) {
            if (function_ce2310c1(players[index])) {
                dist = self zm_utility::approximate_path_dist(players[index]);
            }
            if (isdefined(dist)) {
                if (isdefined(closest_dist)) {
                    if (dist < closest_dist) {
                        closest = players[index];
                        closest_dist = dist;
                    }
                    continue;
                }
                closest = players[index];
                closest_dist = dist;
            }
        }
        self.last_closest_player = closest;
    }
    if (players.size > 1 && isdefined(closest)) {
        self zm_utility::approximate_path_dist(closest);
    }
    self function_9b4b4134(players);
    return self.last_closest_player;
}

// Namespace namespace_38087cad
// Params 0, eflags: 0x1 linked
// Checksum 0xbc90c6a8, Offset: 0x898
// Size: 0x18c
function function_72e6c1d6() {
    level waittill(#"start_of_round");
    while (true) {
        reset_closest_player = 1;
        zombies = zombie_utility::get_round_enemy_array();
        foreach (zombie in zombies) {
            if (isdefined(zombie.need_closest_player) && zombie.need_closest_player) {
                reset_closest_player = 0;
                break;
            }
        }
        if (reset_closest_player) {
            foreach (zombie in zombies) {
                if (isdefined(zombie.need_closest_player)) {
                    zombie.need_closest_player = 1;
                }
            }
        }
        wait(0.05);
    }
}

