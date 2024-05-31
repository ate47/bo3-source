#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_behavior;
#using scripts/shared/ai/zombie_utility;
#using scripts/shared/ai/zombie;
#using scripts/shared/ai/systems/behavior_tree_utility;
#using scripts/shared/ai/systems/animation_state_machine_mocomp;
#using scripts/shared/ai/systems/animation_state_machine_notetracks;
#using scripts/shared/ai/systems/animation_state_machine_utility;
#using scripts/shared/util_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/array_shared;
#using scripts/shared/ai_shared;
#using scripts/codescripts/struct;

#namespace namespace_5b19fee7;

// Namespace namespace_5b19fee7
// Params 0, eflags: 0x2
// namespace_5b19fee7<file_0>::function_c35e6aab
// Checksum 0x5821bc50, Offset: 0x488
// Size: 0xbc
function autoexec init() {
    function_f4226854();
    setdvar("scr_zm_use_code_enemy_selection", 0);
    level.closest_player_override = &function_c3d4cc46;
    level thread function_72e6c1d6();
    level.var_1ace2307 = 2;
    zm_utility::register_custom_spawner_entry("quick_riser_location", &function_50565360);
    spawner::add_archetype_spawn_function("zombie", &function_1d7e9058);
}

// Namespace namespace_5b19fee7
// Params 0, eflags: 0x5 linked
// namespace_5b19fee7<file_0>::function_f4226854
// Checksum 0xf58059dd, Offset: 0x550
// Size: 0x2c
function private function_f4226854() {
    behaviortreenetworkutility::registerbehaviortreescriptapi("ZmIslandAttackableObjectService", &function_e5272d25);
}

// Namespace namespace_5b19fee7
// Params 0, eflags: 0x5 linked
// namespace_5b19fee7<file_0>::function_1d7e9058
// Checksum 0xdff6e1ba, Offset: 0x588
// Size: 0x3c
function private function_1d7e9058() {
    self ai::set_behavior_attribute("use_attackable", 1);
    self.cant_move_cb = &function_69768b33;
}

// Namespace namespace_5b19fee7
// Params 0, eflags: 0x5 linked
// namespace_5b19fee7<file_0>::function_69768b33
// Checksum 0xf4408998, Offset: 0x5d0
// Size: 0x1bc
function private function_69768b33() {
    if (isdefined(self.attackable)) {
        if (isdefined(self.attackable.is_active) && self.attackable.is_active) {
            self function_1762804b(0);
            self.enablepushtime = gettime() + 1000;
            return;
        }
    }
    a_ai = getaiteamarray(level.zombie_team);
    var_125a7575 = self array::filter(a_ai, 0, &function_b3de8aa4, 32);
    foreach (ai in var_125a7575) {
        if (isdefined(ai.is_at_attackable) && isdefined(ai.attackable.is_active) && isdefined(ai.attackable) && ai.attackable.is_active && ai.is_at_attackable) {
            self function_1762804b(0);
            self.enablepushtime = gettime() + 1000;
            return;
        }
    }
}

// Namespace namespace_5b19fee7
// Params 2, eflags: 0x5 linked
// namespace_5b19fee7<file_0>::function_b3de8aa4
// Checksum 0xd876c509, Offset: 0x798
// Size: 0x60
function private function_b3de8aa4(ent, radius) {
    radius_sq = radius * radius;
    return ent != self && distancesquared(self.origin, ent.origin) <= radius_sq;
}

// Namespace namespace_5b19fee7
// Params 1, eflags: 0x5 linked
// namespace_5b19fee7<file_0>::function_e5272d25
// Checksum 0x16a49482, Offset: 0x800
// Size: 0x5c
function private function_e5272d25(entity) {
    if (isdefined(entity.var_7d79a6) && entity.var_7d79a6) {
        entity.attackable = undefined;
        return 0;
    }
    zm_behavior::zombieattackableobjectservice(entity);
}

// Namespace namespace_5b19fee7
// Params 1, eflags: 0x1 linked
// namespace_5b19fee7<file_0>::function_2d4f3007
// Checksum 0x8f0ed33c, Offset: 0x868
// Size: 0x404
function function_2d4f3007(player) {
    var_6841e023 = "zone_spider_boss";
    var_930276ab = "zone_bunker_underwater_defend";
    var_1ac852d = "zone_ruins_underground";
    var_bae90b42 = "zone_flooded_bunker_tunnel";
    var_a2c1d9c5 = "zone_bunker_prison";
    var_101826e8 = "zone_bunker_prison_entrance";
    var_8ea2cdb6 = "zone_bunker_interior_elevator";
    str_player_zone = "";
    var_334f2464 = "";
    if (isdefined(player.var_90f735f8) && player.var_90f735f8) {
        return false;
    }
    if (isdefined(self.var_6eb9188d) && self.var_6eb9188d) {
        return true;
    }
    if (isdefined(self.zone_name)) {
        switch (self.zone_name) {
        case 5:
            if (!level flag::get("spider_queen_dead")) {
                var_334f2464 = var_6841e023;
            }
            break;
        case 6:
            if (level flag::get("penstock_debris_cleared") && !level flag::get("defend_over")) {
                var_334f2464 = var_930276ab;
            }
            break;
        case 8:
            var_334f2464 = var_bae90b42;
            break;
        case 9:
        case 10:
            var_334f2464 = var_a2c1d9c5;
            break;
        case 11:
            if (level flag::get("elevator_door_closed")) {
                var_334f2464 = var_8ea2cdb6;
            }
            break;
        case 7:
            if (isdefined(self.var_2f846873) && (isdefined(level.var_a5db31a9) && level.var_a5db31a9 || self.var_2f846873)) {
                var_334f2464 = var_1ac852d;
            }
            break;
        }
    }
    if (isdefined(player.zone_name)) {
        switch (player.zone_name) {
        case 5:
            if (!level flag::get("spider_queen_dead")) {
                str_player_zone = var_6841e023;
            }
            break;
        case 6:
            if (level flag::get("penstock_debris_cleared") && !level flag::get("defend_over")) {
                str_player_zone = var_930276ab;
            }
            break;
        case 8:
            str_player_zone = var_bae90b42;
            break;
        case 10:
            if (!level flag::get("prison_vines_cleared")) {
                str_player_zone = var_101826e8;
            } else {
                str_player_zone = var_a2c1d9c5;
            }
            break;
        case 9:
            str_player_zone = var_a2c1d9c5;
            break;
        case 11:
            if (level flag::get("elevator_door_closed")) {
                str_player_zone = var_8ea2cdb6;
            }
            break;
        case 7:
            if (isdefined(level.var_a5db31a9) && level.var_a5db31a9) {
                str_player_zone = var_1ac852d;
            }
            break;
        }
    }
    if (str_player_zone != var_334f2464) {
        return false;
    }
    return true;
}

// Namespace namespace_5b19fee7
// Params 1, eflags: 0x5 linked
// namespace_5b19fee7<file_0>::function_f8e95ea2
// Checksum 0x9ad3ec5c, Offset: 0xc78
// Size: 0xee
function private function_f8e95ea2(players) {
    if (isdefined(self.last_closest_player.am_i_valid) && isdefined(self.last_closest_player) && self.last_closest_player.am_i_valid) {
        return;
    }
    self.need_closest_player = 1;
    foreach (player in players) {
        if (self function_2d4f3007(player)) {
            self.last_closest_player = player;
            return;
        }
    }
    self.last_closest_player = undefined;
}

// Namespace namespace_5b19fee7
// Params 2, eflags: 0x5 linked
// namespace_5b19fee7<file_0>::function_c3d4cc46
// Checksum 0xb7c70c19, Offset: 0xd70
// Size: 0x312
function private function_c3d4cc46(origin, players) {
    if (self.ignoreall === 1) {
        return undefined;
    }
    if (players.size == 0) {
        return undefined;
    }
    if (isdefined(self.zombie_poi)) {
        return undefined;
    }
    if (players.size == 1) {
        if (self function_2d4f3007(players[0])) {
            self.last_closest_player = players[0];
            return self.last_closest_player;
        }
        return undefined;
    }
    if (!isdefined(self.last_closest_player)) {
        self.last_closest_player = players[0];
    }
    if (isdefined(self.v_zombie_custom_goal_pos) || isdefined(self.attackable_slot)) {
        return self.last_closest_player;
    }
    if (!isdefined(self.need_closest_player)) {
        self.need_closest_player = 1;
    }
    if (isdefined(level.last_closest_time) && level.last_closest_time >= level.time) {
        self function_f8e95ea2(players);
        return self.last_closest_player;
    }
    if (isdefined(self.need_closest_player) && self.need_closest_player) {
        level.last_closest_time = level.time;
        self.need_closest_player = 0;
        closest = players[0];
        closest_dist = undefined;
        if (self function_2d4f3007(players[0])) {
            closest_dist = self zm_utility::approximate_path_dist(closest);
        }
        if (!isdefined(closest_dist)) {
            closest = undefined;
        }
        for (index = 1; index < players.size; index++) {
            dist = undefined;
            if (self function_2d4f3007(players[index])) {
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
    self function_f8e95ea2(players);
    return self.last_closest_player;
}

// Namespace namespace_5b19fee7
// Params 0, eflags: 0x5 linked
// namespace_5b19fee7<file_0>::function_72e6c1d6
// Checksum 0x596c4655, Offset: 0x1090
// Size: 0x18c
function private function_72e6c1d6() {
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

// Namespace namespace_5b19fee7
// Params 1, eflags: 0x1 linked
// namespace_5b19fee7<file_0>::function_50565360
// Checksum 0xaa9dbbe6, Offset: 0x1228
// Size: 0x1d4
function function_50565360(s_spot) {
    self endon(#"death");
    self.in_the_ground = 1;
    mdl_anchor = util::spawn_model("tag_origin", self.origin, self.angles);
    self linkto(mdl_anchor);
    self thread function_cd5d6101();
    mdl_anchor moveto(s_spot.origin, 0.05);
    mdl_anchor waittill(#"movedone");
    var_ac82e424 = zombie_utility::get_desired_origin();
    if (isdefined(var_ac82e424)) {
        var_585cefca = vectortoangles(var_ac82e424 - self.origin);
        mdl_anchor rotateto((0, var_585cefca[1], 0), 0.05);
        mdl_anchor waittill(#"rotatedone");
    }
    self unlink();
    mdl_anchor thread scene::play("scene_zm_dlc2_zombie_quick_rise_v2", self);
    self notify(#"risen", s_spot.script_string);
    self.in_the_ground = 0;
    mdl_anchor waittill(#"scene_done");
    if (isdefined(mdl_anchor)) {
        mdl_anchor delete();
    }
}

// Namespace namespace_5b19fee7
// Params 0, eflags: 0x1 linked
// namespace_5b19fee7<file_0>::function_cd5d6101
// Checksum 0x7d97fee3, Offset: 0x1408
// Size: 0x70
function function_cd5d6101() {
    self endon(#"death");
    self ghost();
    wait(0.4);
    if (isdefined(self)) {
        self show();
        util::wait_network_frame();
        if (isdefined(self)) {
            self.create_eyes = 1;
        }
    }
}

