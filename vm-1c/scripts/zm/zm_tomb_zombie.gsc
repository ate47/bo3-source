#using scripts/zm/zm_tomb_tank;
#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_spawner;
#using scripts/zm/_zm_behavior;
#using scripts/zm/_zm;
#using scripts/shared/ai/zombie_utility;
#using scripts/shared/ai/zombie;
#using scripts/shared/ai/systems/behavior_tree_utility;
#using scripts/shared/ai/systems/animation_state_machine_mocomp;
#using scripts/shared/ai/systems/animation_state_machine_notetracks;
#using scripts/shared/ai/systems/animation_state_machine_utility;
#using scripts/shared/math_shared;
#using scripts/shared/util_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/array_shared;
#using scripts/codescripts/struct;

#namespace namespace_ba5e3d70;

// Namespace namespace_ba5e3d70
// Params 0, eflags: 0x2
// namespace_ba5e3d70<file_0>::function_c35e6aab
// Checksum 0xf519961f, Offset: 0x4c0
// Size: 0x5c
function autoexec init() {
    function_b5da43f3();
    setdvar("scr_zm_use_code_enemy_selection", 0);
    level thread function_72e6c1d6();
    level.validate_on_navmesh = 1;
    level.var_1ace2307 = 2;
}

// Namespace namespace_ba5e3d70
// Params 0, eflags: 0x5 linked
// namespace_ba5e3d70<file_0>::function_b5da43f3
// Checksum 0xa4fe2cfe, Offset: 0x528
// Size: 0x234
function private function_b5da43f3() {
    behaviortreenetworkutility::registerbehaviortreescriptapi("wasKilledByWaterStaff", &function_901a96ec);
    behaviortreenetworkutility::registerbehaviortreescriptapi("wasKilledByFireStaff", &function_7ae408dd);
    behaviortreenetworkutility::registerbehaviortreescriptapi("wasKilledByLightningStaff", &function_a8b7161f);
    behaviortreenetworkutility::registerbehaviortreescriptapi("wasKilledOnTank", &function_9449d80c);
    behaviortreenetworkutility::registerbehaviortreescriptapi("wasStunnedByFireStaff", &function_1beccbaf);
    behaviortreenetworkutility::registerbehaviortreescriptapi("wasStunnedByLightningStaff", &function_4638613d);
    behaviortreenetworkutility::registerbehaviortreescriptapi("zombieShouldWhirlwind", &function_dc92ad10);
    behaviortreenetworkutility::registerbehaviortreescriptapi("zombieStunFireActionEnd", &function_bcaa2d94);
    behaviortreenetworkutility::registerbehaviortreescriptapi("zombieStunLightningActionEnd", &function_5fe08728);
    behaviortreenetworkutility::registerbehaviortreescriptapi("tombSetFindFleshState", &function_92b303d1);
    behaviortreenetworkutility::registerbehaviortreescriptapi("tombClearFindFleshState", &function_7ccc282a);
    behaviortreenetworkutility::registerbehaviortreescriptapi("tombOnTankDeathActionStart", &function_4bf50754);
    spawner::add_archetype_spawn_function("zombie", &function_59f740e7);
    animationstatenetwork::registernotetrackhandlerfunction("shatter", &function_e24c6a3f);
}

// Namespace namespace_ba5e3d70
// Params 0, eflags: 0x1 linked
// namespace_ba5e3d70<file_0>::function_59f740e7
// Checksum 0xb56819e3, Offset: 0x768
// Size: 0x1c
function function_59f740e7() {
    self.var_e06dd77b = &function_92b303d1;
}

// Namespace namespace_ba5e3d70
// Params 1, eflags: 0x1 linked
// namespace_ba5e3d70<file_0>::function_e24c6a3f
// Checksum 0xb84ed822, Offset: 0x790
// Size: 0x64
function function_e24c6a3f(entity) {
    entity clientfield::set("staff_shatter_fx", 1);
    entity clientfield::set("attach_bullet_model", 0);
    entity ghost();
}

// Namespace namespace_ba5e3d70
// Params 1, eflags: 0x1 linked
// namespace_ba5e3d70<file_0>::function_901a96ec
// Checksum 0xd827ecde, Offset: 0x800
// Size: 0x3a
function function_901a96ec(behaviortreeentity) {
    if (isdefined(behaviortreeentity.var_93022f09) && behaviortreeentity.var_93022f09) {
        return true;
    }
    return false;
}

// Namespace namespace_ba5e3d70
// Params 1, eflags: 0x1 linked
// namespace_ba5e3d70<file_0>::function_7ae408dd
// Checksum 0x7eaf6d4c, Offset: 0x848
// Size: 0x3a
function function_7ae408dd(behaviortreeentity) {
    if (isdefined(behaviortreeentity.var_1339189a) && behaviortreeentity.var_1339189a) {
        return true;
    }
    return false;
}

// Namespace namespace_ba5e3d70
// Params 1, eflags: 0x1 linked
// namespace_ba5e3d70<file_0>::function_a8b7161f
// Checksum 0x8bb749c9, Offset: 0x890
// Size: 0x3a
function function_a8b7161f(behaviortreeentity) {
    if (isdefined(behaviortreeentity.var_26747e92) && behaviortreeentity.var_26747e92) {
        return true;
    }
    return false;
}

// Namespace namespace_ba5e3d70
// Params 1, eflags: 0x1 linked
// namespace_ba5e3d70<file_0>::function_9449d80c
// Checksum 0xda16385, Offset: 0x8d8
// Size: 0x3a
function function_9449d80c(behaviortreeentity) {
    return isdefined(self.var_27ea7da4) && (self namespace_e6d36abe::function_45560bd3() || self.var_27ea7da4);
}

// Namespace namespace_ba5e3d70
// Params 1, eflags: 0x1 linked
// namespace_ba5e3d70<file_0>::function_1beccbaf
// Checksum 0x77e38544, Offset: 0x920
// Size: 0x3a
function function_1beccbaf(behaviortreeentity) {
    if (isdefined(behaviortreeentity.var_262d5062) && behaviortreeentity.var_262d5062) {
        return true;
    }
    return false;
}

// Namespace namespace_ba5e3d70
// Params 1, eflags: 0x1 linked
// namespace_ba5e3d70<file_0>::function_4638613d
// Checksum 0x80ebbcc8, Offset: 0x968
// Size: 0x3a
function function_4638613d(behaviortreeentity) {
    if (isdefined(behaviortreeentity.var_b52ab77a) && behaviortreeentity.var_b52ab77a) {
        return true;
    }
    return false;
}

// Namespace namespace_ba5e3d70
// Params 1, eflags: 0x1 linked
// namespace_ba5e3d70<file_0>::function_dc92ad10
// Checksum 0x5cff1286, Offset: 0x9b0
// Size: 0x3a
function function_dc92ad10(behaviortreeentity) {
    if (isdefined(behaviortreeentity.var_8acb86fc) && behaviortreeentity.var_8acb86fc) {
        return true;
    }
    return false;
}

// Namespace namespace_ba5e3d70
// Params 1, eflags: 0x1 linked
// namespace_ba5e3d70<file_0>::function_5fe08728
// Checksum 0x9ffe38d3, Offset: 0x9f8
// Size: 0x1c
function function_5fe08728(behaviortreeentity) {
    behaviortreeentity.var_b52ab77a = 0;
}

// Namespace namespace_ba5e3d70
// Params 1, eflags: 0x1 linked
// namespace_ba5e3d70<file_0>::function_bcaa2d94
// Checksum 0x50c2bc42, Offset: 0xa20
// Size: 0x1c
function function_bcaa2d94(behaviortreeentity) {
    behaviortreeentity.var_262d5062 = 0;
}

// Namespace namespace_ba5e3d70
// Params 1, eflags: 0x1 linked
// namespace_ba5e3d70<file_0>::function_4bf50754
// Checksum 0x7d2b2d4e, Offset: 0xa48
// Size: 0x6c
function function_4bf50754(behaviortreeentity) {
    behaviortreeentity thread function_fe0480d9();
    var_25c21be0 = spawnstruct();
    var_25c21be0 thread function_57039dd1();
    behaviortreeentity thread function_66e3edec(var_25c21be0);
}

// Namespace namespace_ba5e3d70
// Params 0, eflags: 0x1 linked
// namespace_ba5e3d70<file_0>::function_fe0480d9
// Checksum 0x4f2a062a, Offset: 0xac0
// Size: 0x74
function function_fe0480d9() {
    wait(0.7);
    if (!isdefined(self)) {
        return;
    }
    self zombie_utility::zombie_eye_glow_stop();
    self clientfield::set("zombie_instant_explode", 1);
    wait(0.05);
    if (!isdefined(self)) {
        return;
    }
    self hide();
}

// Namespace namespace_ba5e3d70
// Params 0, eflags: 0x1 linked
// namespace_ba5e3d70<file_0>::function_57039dd1
// Checksum 0x80781915, Offset: 0xb40
// Size: 0x16
function function_57039dd1() {
    wait(10);
    self notify(#"hash_57039dd1");
}

// Namespace namespace_ba5e3d70
// Params 1, eflags: 0x1 linked
// namespace_ba5e3d70<file_0>::function_66e3edec
// Checksum 0xc7b6e9e, Offset: 0xb60
// Size: 0x44
function function_66e3edec(var_25c21be0) {
    var_25c21be0 endon(#"hash_57039dd1");
    e_corpse = self waittill(#"actor_corpse");
    e_corpse hide();
}

// Namespace namespace_ba5e3d70
// Params 1, eflags: 0x5 linked
// namespace_ba5e3d70<file_0>::function_ce3464b9
// Checksum 0x7be2b94b, Offset: 0xbb0
// Size: 0xfa
function private function_ce3464b9(players) {
    if (isdefined(self.last_closest_player.am_i_valid) && isdefined(self.last_closest_player) && self.last_closest_player.am_i_valid) {
        return;
    }
    self.need_closest_player = 1;
    foreach (player in players) {
        if (isdefined(player.am_i_valid) && player.am_i_valid) {
            self.last_closest_player = player;
            return;
        }
    }
    self.last_closest_player = undefined;
}

// Namespace namespace_ba5e3d70
// Params 2, eflags: 0x4
// namespace_ba5e3d70<file_0>::function_3394e22d
// Checksum 0xf424bba4, Offset: 0xcb8
// Size: 0x262
function private function_3394e22d(origin, players) {
    if (players.size == 0) {
        return undefined;
    }
    if (isdefined(self.zombie_poi)) {
        return undefined;
    }
    if (players.size == 1) {
        self.last_closest_player = players[0];
        return self.last_closest_player;
    }
    if (!isdefined(self.last_closest_player)) {
        self.last_closest_player = players[0];
    }
    if (!isdefined(self.need_closest_player)) {
        self.need_closest_player = 1;
    }
    if (isdefined(level.last_closest_time) && level.last_closest_time >= level.time) {
        self function_ce3464b9(players);
        return self.last_closest_player;
    }
    if (isdefined(self.need_closest_player) && self.need_closest_player) {
        level.last_closest_time = level.time;
        self.need_closest_player = 0;
        closest = players[0];
        closest_dist = self zm_utility::approximate_path_dist(closest);
        if (!isdefined(closest_dist)) {
            closest = undefined;
        }
        for (index = 1; index < players.size; index++) {
            dist = self zm_utility::approximate_path_dist(players[index]);
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
    self function_ce3464b9(players);
    return self.last_closest_player;
}

// Namespace namespace_ba5e3d70
// Params 0, eflags: 0x5 linked
// namespace_ba5e3d70<file_0>::function_72e6c1d6
// Checksum 0xc67e7ae9, Offset: 0xf28
// Size: 0x1f8
function private function_72e6c1d6() {
    level waittill(#"start_of_round");
    while (true) {
        reset_closest_player = 1;
        zombies = zombie_utility::get_zombie_array();
        var_6aad1b23 = getaiarchetypearray("mechz", level.zombie_team);
        if (var_6aad1b23.size) {
            zombies = arraycombine(zombies, var_6aad1b23, 0, 0);
        }
        foreach (zombie in zombies) {
            if (isdefined(zombie.completed_emerging_into_playable_area) && zombie.completed_emerging_into_playable_area && !isdefined(zombie.var_13ed8adf)) {
                reset_closest_player = 0;
                break;
            }
        }
        if (reset_closest_player) {
            foreach (zombie in zombies) {
                if (isdefined(zombie.var_13ed8adf)) {
                    zombie.var_13ed8adf = undefined;
                }
            }
        }
        wait(0.05);
    }
}

// Namespace namespace_ba5e3d70
// Params 1, eflags: 0x1 linked
// namespace_ba5e3d70<file_0>::function_92b303d1
// Checksum 0xcbe841e9, Offset: 0x1128
// Size: 0x3c
function function_92b303d1(behaviortreeentity) {
    behaviortreeentity.var_68ff8357 = behaviortreeentity.ai_state;
    behaviortreeentity.ai_state = "find_flesh";
}

// Namespace namespace_ba5e3d70
// Params 1, eflags: 0x1 linked
// namespace_ba5e3d70<file_0>::function_7ccc282a
// Checksum 0x66f5bb4f, Offset: 0x1170
// Size: 0x36
function function_7ccc282a(behaviortreeentity) {
    behaviortreeentity.ai_state = behaviortreeentity.var_68ff8357;
    behaviortreeentity.var_68ff8357 = undefined;
}

