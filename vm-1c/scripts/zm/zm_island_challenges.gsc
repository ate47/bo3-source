#using scripts/zm/_zm_bgb;
#using scripts/zm/_zm_audio;
#using scripts/zm/_zm_equipment;
#using scripts/zm/_zm_perks;
#using scripts/zm/_zm_devgui;
#using scripts/zm/_zm_powerups;
#using scripts/zm/_zm_weapons;
#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_spawner;
#using scripts/zm/_zm_unitrigger;
#using scripts/zm/_zm_power;
#using scripts/zm/_zm_laststand;
#using scripts/zm/zm_island_util;
#using scripts/shared/ai/zombie_utility;
#using scripts/shared/scene_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/trigger_shared;
#using scripts/shared/vehicle_shared;
#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/laststand_shared;
#using scripts/shared/hud_util_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/array_shared;
#using scripts/shared/ai_shared;
#using scripts/codescripts/struct;

#namespace zm_island_challenges;

// Namespace zm_island_challenges
// Params 0, eflags: 0x1 linked
// Checksum 0xde5faae8, Offset: 0xc60
// Size: 0x7c4
function main() {
    level flag::init("flag_init_challenge_pillars");
    level thread function_ebb99c53();
    if (getdvarint("splitscreen_playerCount") > 2) {
        array::run_all(getentarray("t_lookat_challenge_1", "targetname"), &delete);
        array::run_all(getentarray("t_lookat_challenge_2", "targetname"), &delete);
        array::run_all(getentarray("t_lookat_challenge_3", "targetname"), &delete);
        array::thread_all(struct::get_array("s_challenge_trigger"), &struct::delete);
        struct::get("s_challenge_altar") struct::delete();
        return;
    }
    level._challenges = spawnstruct();
    level._challenges.var_4687355c = [];
    level._challenges.var_b88ea497 = [];
    level._challenges.var_928c2a2e = [];
    array::add(level._challenges.var_4687355c, function_970609e0(1, %ZM_ISLAND_CHALLENGE_1_1, 1, "update_challenge_1_1", undefined));
    array::add(level._challenges.var_4687355c, function_970609e0(1, %ZM_ISLAND_CHALLENGE_1_2, 1, "update_challenge_1_2", undefined));
    array::add(level._challenges.var_4687355c, function_970609e0(1, %ZM_ISLAND_CHALLENGE_1_3, 5, "update_challenge_1_3", undefined));
    array::add(level._challenges.var_4687355c, function_970609e0(1, %ZM_ISLAND_CHALLENGE_1_4, 5, "update_challenge_1_4", undefined));
    array::add(level._challenges.var_4687355c, function_970609e0(1, %ZM_ISLAND_CHALLENGE_1_5, 5, "update_challenge_1_5", &function_2dbc7cd3));
    array::add(level._challenges.var_b88ea497, function_970609e0(2, %ZM_ISLAND_CHALLENGE_2_1, 1, "update_challenge_2_1", undefined));
    array::add(level._challenges.var_b88ea497, function_970609e0(2, %ZM_ISLAND_CHALLENGE_2_2, 1, "update_challenge_2_2", &function_25c1bab7));
    array::add(level._challenges.var_b88ea497, function_970609e0(2, %ZM_ISLAND_CHALLENGE_2_3, 15, "update_challenge_2_3", undefined));
    array::add(level._challenges.var_b88ea497, function_970609e0(2, %ZM_ISLAND_CHALLENGE_2_4, 10, "update_challenge_2_4", undefined));
    array::add(level._challenges.var_b88ea497, function_970609e0(2, %ZM_ISLAND_CHALLENGE_2_5, 20, "update_challenge_2_5", undefined));
    array::add(level._challenges.var_b88ea497, function_970609e0(2, %ZM_ISLAND_CHALLENGE_2_6, 20, "update_challenge_2_6", undefined));
    array::add(level._challenges.var_928c2a2e, function_970609e0(3, %ZM_ISLAND_CHALLENGE_3_1, 8, "update_challenge_3_1", undefined));
    array::add(level._challenges.var_928c2a2e, function_970609e0(3, %ZM_ISLAND_CHALLENGE_3_2, 3, "update_challenge_3_2", undefined));
    array::add(level._challenges.var_928c2a2e, function_970609e0(3, %ZM_ISLAND_CHALLENGE_3_3, 1, "update_challenge_3_3", &function_5a96677a));
    array::add(level._challenges.var_928c2a2e, function_970609e0(3, %ZM_ISLAND_CHALLENGE_3_4, 30, "update_challenge_3_4", undefined));
    array::add(level._challenges.var_928c2a2e, function_970609e0(3, %ZM_ISLAND_CHALLENGE_3_5, 5, "update_challenge_3_5", &function_26c58398));
    zm_spawner::register_zombie_death_event_callback(&function_905d9544);
    zm_spawner::register_zombie_death_event_callback(&function_682e6fc4);
    zm_spawner::register_zombie_death_event_callback(&function_5a2a9ef9);
    zm_spawner::register_zombie_death_event_callback(&function_fe94c179);
    level thread all_challenges_completed();
    level flag::set("flag_init_player_challenges");
    /#
        function_b9b4ce34();
    #/
}

// Namespace zm_island_challenges
// Params 5, eflags: 0x1 linked
// Checksum 0x7143945b, Offset: 0x1430
// Size: 0xb0
function function_970609e0(n_challenge_index, var_3e1001b, var_80792f67, var_52b8c4f8, var_d675d6d8) {
    s_challenge = spawnstruct();
    s_challenge.n_index = n_challenge_index;
    s_challenge.str_info = var_3e1001b;
    s_challenge.n_count = var_80792f67;
    s_challenge.str_notify = var_52b8c4f8;
    s_challenge.func_think = var_d675d6d8;
    return s_challenge;
}

// Namespace zm_island_challenges
// Params 0, eflags: 0x1 linked
// Checksum 0x517793a4, Offset: 0x14e8
// Size: 0x1fc
function on_player_connect() {
    level flag::wait_till("flag_init_player_challenges");
    var_a879fa43 = self getentitynumber();
    self.var_8575e180 = 0;
    self.var_26f3bd30 = 0;
    self.var_301c71e9 = 0;
    self._challenges = spawnstruct();
    self._challenges.var_4687355c = [];
    self._challenges.var_b88ea497 = [];
    self._challenges.var_928c2a2e = [];
    self._challenges.var_4687355c = array::random(level._challenges.var_4687355c);
    self._challenges.var_b88ea497 = array::random(level._challenges.var_b88ea497);
    self._challenges.var_928c2a2e = array::random(level._challenges.var_928c2a2e);
    arrayremovevalue(level._challenges.var_4687355c, self._challenges.var_4687355c);
    arrayremovevalue(level._challenges.var_b88ea497, self._challenges.var_b88ea497);
    arrayremovevalue(level._challenges.var_928c2a2e, self._challenges.var_928c2a2e);
    self thread function_b7156b15(var_a879fa43);
}

// Namespace zm_island_challenges
// Params 0, eflags: 0x1 linked
// Checksum 0x9392b838, Offset: 0x16f0
// Size: 0x114
function function_ebb99c53() {
    level flag::wait_till("start_zombie_round_logic");
    for (i = 1; i < 4; i++) {
        level clientfield::set("pillar_challenge_0_" + i, 1);
        level clientfield::set("pillar_challenge_1_" + i, 1);
        level clientfield::set("pillar_challenge_2_" + i, 1);
        level clientfield::set("pillar_challenge_3_" + i, 1);
        wait 0.5;
    }
    level flag::set("flag_init_challenge_pillars");
}

// Namespace zm_island_challenges
// Params 0, eflags: 0x1 linked
// Checksum 0x351f311f, Offset: 0x1810
// Size: 0x134
function on_player_disconnect() {
    level flag::wait_till("flag_init_player_challenges");
    var_a879fa43 = self getentitynumber();
    for (i = 1; i < 4; i++) {
        level clientfield::set("pillar_challenge_" + var_a879fa43 + "_" + i, 1);
    }
    array::add(level._challenges.var_4687355c, self._challenges.var_4687355c);
    array::add(level._challenges.var_b88ea497, self._challenges.var_b88ea497);
    array::add(level._challenges.var_928c2a2e, self._challenges.var_928c2a2e);
}

// Namespace zm_island_challenges
// Params 1, eflags: 0x1 linked
// Checksum 0x95212e28, Offset: 0x1950
// Size: 0x502
function function_b7156b15(var_a879fa43) {
    self endon(#"disconnect");
    self flag::init("flag_player_collected_reward_1");
    self flag::init("flag_player_collected_reward_2");
    self flag::init("flag_player_collected_reward_3");
    self flag::init("flag_player_completed_challenge_1");
    self flag::init("flag_player_completed_challenge_2");
    self flag::init("flag_player_completed_challenge_3");
    self thread function_2ce855f3(self._challenges.var_4687355c.n_index, self._challenges.var_4687355c.func_think, self._challenges.var_4687355c.n_count, self._challenges.var_4687355c.str_notify);
    self thread function_2ce855f3(self._challenges.var_b88ea497.n_index, self._challenges.var_b88ea497.func_think, self._challenges.var_b88ea497.n_count, self._challenges.var_b88ea497.str_notify);
    self thread function_2ce855f3(self._challenges.var_928c2a2e.n_index, self._challenges.var_928c2a2e.func_think, self._challenges.var_928c2a2e.n_count, self._challenges.var_928c2a2e.str_notify);
    self thread function_fbbc8608(self._challenges.var_4687355c.n_index, "flag_player_completed_challenge_1");
    self thread function_fbbc8608(self._challenges.var_b88ea497.n_index, "flag_player_completed_challenge_2");
    self thread function_fbbc8608(self._challenges.var_928c2a2e.n_index, "flag_player_completed_challenge_3");
    self thread function_974d5f1d();
    var_8e2d9e6f = [];
    var_e01fcddc = [];
    for (i = 1; i < 4; i++) {
        foreach (var_1030677c in getentarray("t_lookat_challenge_" + i, "targetname")) {
            if (var_1030677c.var_7cc697d0 == var_a879fa43) {
                var_e01fcddc[i] = var_1030677c;
            }
        }
        var_8e2d9e6f[i] = i;
        self thread function_7fc84e9c(var_a879fa43, var_8e2d9e6f[i]);
        self thread function_e43d4636(var_a879fa43, var_8e2d9e6f[i]);
    }
    foreach (s_challenge in struct::get_array("s_challenge_trigger")) {
        if (s_challenge.var_7cc697d0 == var_a879fa43) {
            s_challenge function_72a5d5e5(var_a879fa43, var_8e2d9e6f, var_e01fcddc);
        }
    }
}

// Namespace zm_island_challenges
// Params 3, eflags: 0x1 linked
// Checksum 0xc7bc69ea, Offset: 0x1e60
// Size: 0x154
function function_72a5d5e5(var_a879fa43, var_8e2d9e6f, var_e01fcddc) {
    unitrigger_stub = spawnstruct();
    unitrigger_stub.origin = self.origin;
    unitrigger_stub.angles = self.angles;
    unitrigger_stub.script_unitrigger_type = "unitrigger_radius_use";
    unitrigger_stub.cursor_hint = "HINT_NOICON";
    unitrigger_stub.radius = -128;
    unitrigger_stub.require_look_at = 0;
    unitrigger_stub.inactive_reassess_time = 0.5;
    unitrigger_stub.var_a879fa43 = var_a879fa43;
    unitrigger_stub.var_8e2d9e6f = var_8e2d9e6f;
    unitrigger_stub.var_e01fcddc = var_e01fcddc;
    zm_unitrigger::unitrigger_force_per_player_triggers(unitrigger_stub, 1);
    unitrigger_stub.prompt_and_visibility_func = &function_3ae0d6d5;
    zm_unitrigger::register_static_unitrigger(unitrigger_stub, &function_a00e23d0);
}

// Namespace zm_island_challenges
// Params 2, eflags: 0x1 linked
// Checksum 0x29c71da6, Offset: 0x1fc0
// Size: 0xf4
function function_fbbc8608(n_challenge_index, var_d4adfa57) {
    self endon(#"disconnect");
    self flag::wait_till(var_d4adfa57);
    var_d6b47fd3 = "";
    if (n_challenge_index == 1) {
        var_d6b47fd3 = self._challenges.var_4687355c.str_info;
    } else if (n_challenge_index == 2) {
        var_d6b47fd3 = self._challenges.var_b88ea497.str_info;
    } else {
        var_d6b47fd3 = self._challenges.var_928c2a2e.str_info;
    }
    self luinotifyevent(%trial_complete, 2, %ZM_ISLAND_TRIAL_COMPLETE, var_d6b47fd3);
}

// Namespace zm_island_challenges
// Params 1, eflags: 0x1 linked
// Checksum 0xa93d5e88, Offset: 0x20c0
// Size: 0x54
function function_e8547a5b(var_cc0f18cc) {
    if (self.challenge_text !== var_cc0f18cc) {
        self.challenge_text = var_cc0f18cc;
        self luinotifyevent(%trial_set_description, 1, self.challenge_text);
    }
}

// Namespace zm_island_challenges
// Params 2, eflags: 0x1 linked
// Checksum 0x45c0e2a3, Offset: 0x2120
// Size: 0xf4
function function_27f6c3cd(player, n_challenge_index) {
    if (self.stub.var_8e2d9e6f[n_challenge_index] == 1) {
        player function_e8547a5b(player._challenges.var_4687355c.str_info);
        return;
    }
    if (self.stub.var_8e2d9e6f[n_challenge_index] == 2) {
        player function_e8547a5b(player._challenges.var_b88ea497.str_info);
        return;
    }
    player function_e8547a5b(player._challenges.var_928c2a2e.str_info);
}

// Namespace zm_island_challenges
// Params 1, eflags: 0x1 linked
// Checksum 0x7ca5a195, Offset: 0x2220
// Size: 0xac
function function_23c9ffd3(player) {
    self notify(#"hash_23c9ffd3");
    self endon(#"hash_23c9ffd3");
    while (true) {
        wait 0.5;
        if (!isdefined(player)) {
            break;
        }
        if (!isdefined(self) || distance(player.origin, self.stub.origin) > 500) {
            player clientfield::set_player_uimodel("trialWidget.visible", 0);
            break;
        }
    }
}

// Namespace zm_island_challenges
// Params 1, eflags: 0x1 linked
// Checksum 0x9d06fe05, Offset: 0x22d8
// Size: 0x408
function function_3ae0d6d5(player) {
    if (player getentitynumber() == self.stub.var_a879fa43) {
        var_a51a0ba6 = 0;
        for (i = 1; i < 4; i++) {
            if (player function_3f67a723(self.stub.var_e01fcddc[i].origin, 20, 0) && distance(player.origin, self.stub.origin) < 500) {
                self function_27f6c3cd(player, i);
                player clientfield::set_player_uimodel("trialWidget.visible", 1);
                player clientfield::set_player_uimodel("trialWidget.progress", player.var_873a3e27[self.stub.var_8e2d9e6f[i]]);
                if (!player flag::get("flag_player_completed_challenge_" + self.stub.var_8e2d9e6f[i])) {
                    self sethintstringforplayer(player, "");
                    var_a51a0ba6 = 1;
                    self thread function_23c9ffd3(player);
                    return 1;
                }
                if (!player flag::get("flag_player_collected_reward_" + self.stub.var_8e2d9e6f[i]) && !level flag::get("flag_player_initialized_reward")) {
                    self sethintstringforplayer(player, %ZM_ISLAND_CHALLENGE_REWARD);
                    var_a51a0ba6 = 1;
                    self thread function_23c9ffd3(player);
                    return 1;
                }
                if (!player flag::get("flag_player_collected_reward_" + self.stub.var_8e2d9e6f[i]) && level flag::get("flag_player_initialized_reward")) {
                    self sethintstringforplayer(player, %ZM_ISLAND_CHALLENGE_ALTAR_IN_USE);
                    var_a51a0ba6 = 1;
                    self thread function_23c9ffd3(player);
                    return 1;
                }
                self sethintstringforplayer(player, "");
                var_a51a0ba6 = 1;
                self thread function_23c9ffd3(player);
                return 1;
            }
        }
        if (!var_a51a0ba6) {
            self sethintstringforplayer(player, "");
            player clientfield::set_player_uimodel("trialWidget.visible", 0);
            return 0;
        }
        return;
    }
    self sethintstringforplayer(player, "");
    player clientfield::set_player_uimodel("trialWidget.visible", 0);
    return 0;
}

// Namespace zm_island_challenges
// Params 4, eflags: 0x1 linked
// Checksum 0x308be38b, Offset: 0x26e8
// Size: 0xb4
function function_3f67a723(origin, arc_angle_degrees, do_trace, e_ignore) {
    if (!isdefined(arc_angle_degrees)) {
        arc_angle_degrees = 90;
    }
    arc_angle_degrees = absangleclamp360(arc_angle_degrees);
    dot = cos(arc_angle_degrees * 0.5);
    if (self util::is_player_looking_at(origin, dot, do_trace, e_ignore)) {
        return 1;
    }
    return 0;
}

// Namespace zm_island_challenges
// Params 0, eflags: 0x1 linked
// Checksum 0x7c77aeea, Offset: 0x27a8
// Size: 0x1d8
function function_a00e23d0() {
    self endon(#"kill_trigger");
    while (true) {
        e_who = self waittill(#"trigger");
        if (e_who getentitynumber() == self.stub.var_a879fa43) {
            for (i = 1; i < 4; i++) {
                if (e_who function_3f67a723(self.stub.var_e01fcddc[i].origin, 20, 0) && distance(e_who.origin, self.stub.origin) < 500) {
                    if (e_who flag::get("flag_player_completed_challenge_" + self.stub.var_8e2d9e6f[i]) && !e_who flag::get("flag_player_collected_reward_" + self.stub.var_8e2d9e6f[i]) && !level flag::get("flag_player_initialized_reward")) {
                        e_who thread function_8675d6ed(self.stub.var_8e2d9e6f[i]);
                    }
                }
            }
            self sethintstringforplayer(e_who, "");
        }
    }
}

// Namespace zm_island_challenges
// Params 2, eflags: 0x1 linked
// Checksum 0x6040925c, Offset: 0x2988
// Size: 0xec
function function_7fc84e9c(var_a879fa43, n_challenge) {
    self endon(#"disconnect");
    self flag::wait_till("flag_player_completed_challenge_" + n_challenge);
    switch (var_a879fa43) {
    case 0:
        str_exploder = "fxexp_820";
        break;
    case 1:
        str_exploder = "fxexp_821";
        break;
    case 2:
        str_exploder = "fxexp_822";
        break;
    case 3:
        str_exploder = "fxexp_823";
        break;
    }
    exploder::exploder(str_exploder);
    wait 1;
    exploder::stop_exploder(str_exploder);
}

// Namespace zm_island_challenges
// Params 2, eflags: 0x1 linked
// Checksum 0x52cd298a, Offset: 0x2a80
// Size: 0x124
function function_e43d4636(var_a879fa43, n_challenge) {
    self endon(#"disconnect");
    level flag::wait_till("flag_init_challenge_pillars");
    level clientfield::set("pillar_challenge_" + var_a879fa43 + "_" + n_challenge, 2);
    self flag::wait_till("flag_player_completed_challenge_" + n_challenge);
    level clientfield::set("pillar_challenge_" + var_a879fa43 + "_" + n_challenge, 3);
    self flag::wait_till("flag_player_collected_reward_" + n_challenge);
    level clientfield::set("pillar_challenge_" + var_a879fa43 + "_" + n_challenge, 4);
}

// Namespace zm_island_challenges
// Params 1, eflags: 0x1 linked
// Checksum 0x3fb05f9a, Offset: 0x2bb0
// Size: 0x434
function function_8675d6ed(n_challenge) {
    self endon(#"disconnect");
    var_a879fa43 = self getentitynumber();
    var_81d71db = [];
    s_altar = struct::get("s_challenge_altar");
    if (n_challenge == 1) {
        var_c9d33fc4 = "p7_zm_power_up_max_ammo";
    } else if (n_challenge == 2) {
        array::add(var_81d71db, "wpn_t7_lmg_dingo_world");
        array::add(var_81d71db, "wpn_t7_shotty_gator_world");
        array::add(var_81d71db, "wpn_t7_sniper_svg100_world");
        var_c9d33fc4 = array::random(var_81d71db);
    } else {
        var_c9d33fc4 = "zombie_pickup_perk_bottle";
    }
    level flag::set("flag_player_initialized_reward");
    var_a6a1ecf9 = getent("altar_lid", "targetname");
    self function_d655a4ce(var_a6a1ecf9);
    self thread function_26abcbe0();
    self thread function_994b4784(var_a6a1ecf9);
    if (n_challenge == 2) {
        v_spawnpt = s_altar.origin + (0, 8, 30);
    } else {
        v_spawnpt = s_altar.origin + (0, 0, 30);
    }
    mdl_reward = function_5e39bbbe(var_c9d33fc4, v_spawnpt, s_altar.angles);
    self thread function_6168d051(mdl_reward);
    if (n_challenge == 1) {
        mdl_reward clientfield::set("challenge_glow_fx", 1);
    } else if (n_challenge == 3) {
        mdl_reward clientfield::set("challenge_glow_fx", 2);
    }
    mdl_reward thread timer_til_despawn(self, n_challenge, v_spawnpt, 30 * -1);
    self thread function_5c44a258(mdl_reward);
    mdl_reward endon(#"hash_59e0fa55");
    mdl_reward.trigger = s_altar function_be89930d(var_a879fa43, n_challenge);
    e_who = mdl_reward.trigger waittill(#"trigger");
    if (e_who == self) {
        self playsoundtoplayer("zmb_trial_unlock_reward", self);
        mdl_reward.trigger notify(#"reward_grabbed");
        self player_give_reward(n_challenge, s_altar, var_c9d33fc4);
        if (isdefined(mdl_reward.trigger)) {
            zm_unitrigger::unregister_unitrigger(mdl_reward.trigger);
            mdl_reward.trigger = undefined;
        }
        if (isdefined(mdl_reward)) {
            mdl_reward delete();
        }
    }
}

// Namespace zm_island_challenges
// Params 3, eflags: 0x1 linked
// Checksum 0xb05b46da, Offset: 0x2ff0
// Size: 0x5c
function function_5e39bbbe(var_c9d33fc4, v_origin, v_angles) {
    mdl_reward = util::spawn_model(var_c9d33fc4, v_origin, v_angles + (0, 90, 0));
    return mdl_reward;
}

// Namespace zm_island_challenges
// Params 4, eflags: 0x1 linked
// Checksum 0xf7574d9f, Offset: 0x3058
// Size: 0xe4
function timer_til_despawn(player, n_challenge, v_float, n_dist) {
    player endon(#"disconnect");
    self endon(#"reward_grabbed");
    self movez(n_dist, 12, 6);
    self waittill(#"movedone");
    self notify(#"hash_59e0fa55");
    level flag::clear("flag_player_initialized_reward");
    if (isdefined(self.trigger)) {
        zm_unitrigger::unregister_unitrigger(self.trigger);
        self.trigger = undefined;
    }
    if (isdefined(self)) {
        self delete();
    }
}

// Namespace zm_island_challenges
// Params 1, eflags: 0x1 linked
// Checksum 0xca07de39, Offset: 0x3148
// Size: 0x5c
function function_5c44a258(mdl_reward) {
    self endon(#"hash_994b4784");
    self waittill(#"disconnect");
    level flag::clear("flag_player_initialized_reward");
    mdl_reward delete();
}

// Namespace zm_island_challenges
// Params 3, eflags: 0x1 linked
// Checksum 0x327beb88, Offset: 0x31b0
// Size: 0x17a
function player_give_reward(n_challenge, s_altar, var_c9d33fc4) {
    if (n_challenge == 1) {
        level thread zm_powerups::specific_powerup_drop("full_ammo", self.origin);
    } else if (n_challenge == 2) {
        if (var_c9d33fc4 == "wpn_t7_lmg_dingo_world") {
            e_weapon = getweapon("lmg_cqb");
        } else if (var_c9d33fc4 == "wpn_t7_shotty_gator_world") {
            e_weapon = getweapon("shotgun_semiauto");
        } else {
            e_weapon = getweapon("sniper_powerbolt");
        }
        self thread zm_island_util::swap_weapon(e_weapon);
    } else {
        level thread zm_powerups::specific_powerup_drop("empty_perk", self.origin);
    }
    self flag::set("flag_player_collected_reward_" + n_challenge);
    level flag::clear("flag_player_initialized_reward");
    self notify(#"reward_grabbed");
}

// Namespace zm_island_challenges
// Params 2, eflags: 0x1 linked
// Checksum 0x288312ab, Offset: 0x3338
// Size: 0x128
function function_be89930d(var_a879fa43, n_challenge) {
    unitrigger_stub = spawnstruct();
    unitrigger_stub.origin = self.origin;
    unitrigger_stub.angles = self.angles;
    unitrigger_stub.script_unitrigger_type = "unitrigger_radius_use";
    unitrigger_stub.cursor_hint = "HINT_NOICON";
    unitrigger_stub.radius = -128;
    unitrigger_stub.require_look_at = 0;
    unitrigger_stub.var_a879fa43 = var_a879fa43;
    unitrigger_stub.n_challenge = n_challenge;
    zm_unitrigger::unitrigger_force_per_player_triggers(unitrigger_stub, 1);
    unitrigger_stub.prompt_and_visibility_func = &function_6d42affc;
    zm_unitrigger::register_static_unitrigger(unitrigger_stub, &function_1e314338);
    return unitrigger_stub;
}

// Namespace zm_island_challenges
// Params 1, eflags: 0x1 linked
// Checksum 0x95c70a78, Offset: 0x3468
// Size: 0x148
function function_6d42affc(player) {
    w_current = player getcurrentweapon();
    if ((zm_utility::is_placeable_mine(w_current) || zm_equipment::is_equipment(w_current) || w_current == level.weaponnone || w_current.isheroweapon == 1) && self.stub.n_challenge == 2) {
        self sethintstringforplayer(player, "");
        return 0;
    }
    if (player getentitynumber() == self.stub.var_a879fa43) {
        self sethintstringforplayer(player, %ZM_ISLAND_CHALLENGE_REWARD);
        return 1;
    }
    self sethintstringforplayer(player, "");
    return 0;
}

// Namespace zm_island_challenges
// Params 0, eflags: 0x1 linked
// Checksum 0x831df3c9, Offset: 0x35b8
// Size: 0x104
function function_1e314338() {
    self endon(#"kill_trigger");
    while (true) {
        player = self waittill(#"trigger");
        w_current = player getcurrentweapon();
        if ((zm_utility::is_placeable_mine(w_current) || zm_equipment::is_equipment(w_current) || w_current == level.weaponnone || w_current.isheroweapon == 1) && self.stub.n_challenge == 2) {
            continue;
        }
        if (player bgb::is_enabled("zm_bgb_disorderly_combat")) {
            continue;
        }
        self.stub notify(#"trigger", player);
    }
}

// Namespace zm_island_challenges
// Params 1, eflags: 0x1 linked
// Checksum 0x3952f4ea, Offset: 0x36c8
// Size: 0x9c
function function_d655a4ce(var_a6a1ecf9) {
    self endon(#"hash_994b4784");
    level.var_2371bbc = self;
    var_a6a1ecf9 setignorepauseworld(1);
    var_a6a1ecf9 playsound("zmb_challenge_altar_open");
    var_a6a1ecf9 scene::play("p7_fxanim_zm_island_altar_skull_lid_rise_bundle", var_a6a1ecf9);
    var_a6a1ecf9 thread scene::play("p7_fxanim_zm_island_altar_skull_lid_idle_bundle", var_a6a1ecf9);
}

// Namespace zm_island_challenges
// Params 1, eflags: 0x1 linked
// Checksum 0xa5108a9b, Offset: 0x3770
// Size: 0x5e
function function_994b4784(var_a6a1ecf9) {
    self waittill(#"hash_994b4784");
    var_a6a1ecf9 playsound("zmb_challenge_altar_close");
    var_a6a1ecf9 scene::play("p7_fxanim_zm_island_altar_skull_lid_fall_bundle", var_a6a1ecf9);
    level.var_2371bbc = undefined;
}

// Namespace zm_island_challenges
// Params 0, eflags: 0x1 linked
// Checksum 0xa88daaf3, Offset: 0x37d8
// Size: 0x4a
function function_26abcbe0() {
    self endon(#"hash_994b4784");
    self util::waittill_any("disconnect", "death", "reward_grabbed");
    self notify(#"hash_994b4784");
}

// Namespace zm_island_challenges
// Params 1, eflags: 0x1 linked
// Checksum 0x3773cde1, Offset: 0x3830
// Size: 0x32
function function_6168d051(mdl_reward) {
    self endon(#"hash_994b4784");
    mdl_reward waittill(#"hash_59e0fa55");
    self notify(#"hash_994b4784");
}

// Namespace zm_island_challenges
// Params 0, eflags: 0x1 linked
// Checksum 0xed969996, Offset: 0x3870
// Size: 0x4e
function function_2dbc7cd3() {
    self endon(#"disconnect");
    while (!self flag::get("flag_player_completed_challenge_1")) {
        self waittill(#"hash_7ae66b0a");
        self notify(#"update_challenge_1_5");
    }
}

// Namespace zm_island_challenges
// Params 1, eflags: 0x1 linked
// Checksum 0xa5c45d7e, Offset: 0x38c8
// Size: 0x68
function function_fe94c179(e_attacker) {
    if (isdefined(self.var_61f7b3a0) && isplayer(e_attacker) && self.var_61f7b3a0 && !(isdefined(self.var_5b105946) && self.var_5b105946)) {
        e_attacker notify(#"update_challenge_2_1");
    }
}

// Namespace zm_island_challenges
// Params 0, eflags: 0x1 linked
// Checksum 0xdcfef272, Offset: 0x3938
// Size: 0x4e
function function_25c1bab7() {
    self endon(#"disconnect");
    while (!self flag::get("flag_player_completed_challenge_2")) {
        self waittill(#"hash_61bbe625");
        self notify(#"update_challenge_2_2");
    }
}

// Namespace zm_island_challenges
// Params 1, eflags: 0x1 linked
// Checksum 0x51934eda, Offset: 0x3990
// Size: 0x90
function function_5a2a9ef9(e_attacker) {
    if (isplayer(e_attacker) && self.archetype === "zombie" && isdefined(self.attackable)) {
        if (self.attackable.scriptbundlename == "zm_island_trap_plant_attackable" || self.attackable.scriptbundlename == "zm_island_trap_plant_upgraded_attackable") {
            e_attacker notify(#"update_challenge_2_3");
        }
    }
}

// Namespace zm_island_challenges
// Params 1, eflags: 0x1 linked
// Checksum 0xbcd966c3, Offset: 0x3a28
// Size: 0x60
function function_682e6fc4(e_attacker) {
    if (isdefined(self.var_34d00e7) && isplayer(e_attacker) && self.archetype === "zombie" && self.var_34d00e7) {
        e_attacker notify(#"update_challenge_3_2");
    }
}

// Namespace zm_island_challenges
// Params 0, eflags: 0x1 linked
// Checksum 0x5249729a, Offset: 0x3a90
// Size: 0x4e
function function_5a96677a() {
    self endon(#"disconnect");
    while (!self flag::get("flag_player_completed_challenge_3")) {
        self waittill(#"hash_3e1e1a8");
        self notify(#"update_challenge_3_3");
    }
}

// Namespace zm_island_challenges
// Params 1, eflags: 0x1 linked
// Checksum 0xf23f8c6c, Offset: 0x3ae8
// Size: 0x114
function function_905d9544(e_attacker) {
    if (isplayer(e_attacker)) {
        if (isdefined(self.var_d07c64b6) && !e_attacker flag::get("flag_player_completed_challenge_2") && self.archetype === "zombie" && self.var_d07c64b6) {
            if (isdefined(self.damagelocation) && self.damagelocation == "head" || self.damagelocation == "helmet") {
                e_attacker notify(#"update_challenge_2_4");
            }
        }
        if (!e_attacker flag::get("flag_player_completed_challenge_2") && self.archetype === "zombie" && e_attacker isplayerunderwater()) {
            e_attacker notify(#"update_challenge_2_5");
        }
    }
}

// Namespace zm_island_challenges
// Params 0, eflags: 0x1 linked
// Checksum 0x7a180273, Offset: 0x3c08
// Size: 0x36
function function_26c58398() {
    self endon(#"death");
    while (true) {
        self waittill(#"hash_1526f0d7");
        self notify(#"update_challenge_3_5");
    }
}

// Namespace zm_island_challenges
// Params 4, eflags: 0x1 linked
// Checksum 0xd08c76c7, Offset: 0x3c48
// Size: 0xf4
function function_2ce855f3(n_challenge_index, var_d675d6d8, var_80792f67, var_52b8c4f8) {
    self endon(#"disconnect");
    /#
        self endon(#"hash_1e547c60");
    #/
    if (isdefined(var_d675d6d8)) {
        self thread [[ var_d675d6d8 ]]();
    }
    if (!isdefined(self.var_873a3e27)) {
        self.var_873a3e27 = [];
    }
    self.var_873a3e27[n_challenge_index] = 0;
    var_ea184c3d = var_80792f67;
    while (var_80792f67 > 0) {
        self waittill(var_52b8c4f8);
        var_80792f67--;
        self.var_873a3e27[n_challenge_index] = 1 - var_80792f67 / var_ea184c3d;
    }
    self flag::set("flag_player_completed_challenge_" + n_challenge_index);
}

// Namespace zm_island_challenges
// Params 0, eflags: 0x1 linked
// Checksum 0xaaf14ce6, Offset: 0x3d48
// Size: 0x6a
function function_974d5f1d() {
    self endon(#"disconnect");
    a_flags = array("flag_player_completed_challenge_1", "flag_player_completed_challenge_2", "flag_player_completed_challenge_3");
    self flag::wait_till_all(a_flags);
    level notify(#"hash_41370469");
}

// Namespace zm_island_challenges
// Params 0, eflags: 0x1 linked
// Checksum 0xa05db97b, Offset: 0x3dc0
// Size: 0xa4
function all_challenges_completed() {
    level.var_c28313cd = 0;
    callback::on_disconnect(&function_b1cd865a);
    while (true) {
        level waittill(#"hash_41370469");
        level.var_c28313cd++;
        if (level.var_c28313cd >= level.players.size) {
            level flag::set("all_challenges_completed");
            level thread function_397b26ee();
            break;
        }
    }
}

// Namespace zm_island_challenges
// Params 0, eflags: 0x1 linked
// Checksum 0x4b9e50d3, Offset: 0x3e70
// Size: 0x34
function function_b1cd865a() {
    if (level.var_c28313cd >= level.players.size) {
        level flag::set("all_challenges_completed");
    }
}

// Namespace zm_island_challenges
// Params 0, eflags: 0x1 linked
// Checksum 0xc341f37f, Offset: 0x3eb0
// Size: 0x18c
function function_397b26ee() {
    var_45a970ad = [];
    array::add(var_45a970ad, "fxexp_820");
    array::add(var_45a970ad, "fxexp_821");
    array::add(var_45a970ad, "fxexp_822");
    array::add(var_45a970ad, "fxexp_823");
    wait 1.5;
    while (var_45a970ad.size > 0) {
        var_c490d0cd = array::random(var_45a970ad);
        exploder::exploder(var_c490d0cd);
        arrayremovevalue(var_45a970ad, var_c490d0cd);
        wait randomfloatrange(0.5, 1.5);
    }
    wait 5;
    exploder::stop_exploder("fxexp_820");
    exploder::stop_exploder("fxexp_821");
    exploder::stop_exploder("fxexp_822");
    exploder::stop_exploder("fxexp_823");
    var_45a970ad = undefined;
}

/#

    // Namespace zm_island_challenges
    // Params 0, eflags: 0x1 linked
    // Checksum 0xeee47fd2, Offset: 0x4048
    // Size: 0xa4
    function function_b9b4ce34() {
        zm_devgui::add_custom_devgui_callback(&function_16ba3a1e);
        adddebugcommand("<dev string:x28>");
        adddebugcommand("<dev string:x8f>");
        adddebugcommand("<dev string:xeb>");
        adddebugcommand("<dev string:x147>");
        adddebugcommand("<dev string:x1a3>");
    }

    // Namespace zm_island_challenges
    // Params 1, eflags: 0x1 linked
    // Checksum 0x49e60582, Offset: 0x40f8
    // Size: 0x6ea
    function function_16ba3a1e(cmd) {
        switch (cmd) {
        case "<dev string:x1f7>":
            level flag::set("<dev string:x1f7>");
            return 1;
        case "<dev string:x210>":
            foreach (player in level.players) {
                player flag::set("<dev string:x226>");
                player.var_873a3e27[1] = 1;
            }
            return 1;
        case "<dev string:x248>":
            foreach (player in level.players) {
                player flag::set("<dev string:x25e>");
                player.var_873a3e27[2] = 1;
            }
            return 1;
        case "<dev string:x280>":
            foreach (player in level.players) {
                player flag::set("<dev string:x296>");
                player.var_873a3e27[3] = 1;
            }
            return 1;
        case "<dev string:x2b8>":
            foreach (player in level.players) {
                array::add(level._challenges.var_4687355c, player._challenges.var_4687355c);
                array::add(level._challenges.var_b88ea497, player._challenges.var_b88ea497);
                array::add(level._challenges.var_928c2a2e, player._challenges.var_928c2a2e);
            }
            foreach (player in level.players) {
                player notify(#"hash_1e547c60");
                player.var_873a3e27 = undefined;
                player._challenges.var_4687355c = array::random(level._challenges.var_4687355c);
                player._challenges.var_b88ea497 = array::random(level._challenges.var_b88ea497);
                player._challenges.var_928c2a2e = array::random(level._challenges.var_928c2a2e);
                arrayremovevalue(level._challenges.var_4687355c, player._challenges.var_4687355c);
                arrayremovevalue(level._challenges.var_b88ea497, player._challenges.var_b88ea497);
                arrayremovevalue(level._challenges.var_928c2a2e, player._challenges.var_928c2a2e);
                player thread function_2ce855f3(player._challenges.var_4687355c.n_index, player._challenges.var_4687355c.func_think, player._challenges.var_4687355c.n_count, player._challenges.var_4687355c.str_notify);
                player thread function_2ce855f3(player._challenges.var_b88ea497.n_index, player._challenges.var_b88ea497.func_think, player._challenges.var_b88ea497.n_count, player._challenges.var_b88ea497.str_notify);
                player thread function_2ce855f3(player._challenges.var_928c2a2e.n_index, player._challenges.var_928c2a2e.func_think, player._challenges.var_928c2a2e.n_count, player._challenges.var_928c2a2e.str_notify);
            }
            return 1;
        }
        return 0;
    }

#/
