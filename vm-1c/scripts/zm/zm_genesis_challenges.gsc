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
#using scripts/zm/zm_genesis_util;
#using scripts/shared/ai/zombie_utility;
#using scripts/shared/scene_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/trigger_shared;
#using scripts/shared/vehicle_shared;
#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/laststand_shared;
#using scripts/shared/flagsys_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/array_shared;
#using scripts/shared/ai_shared;
#using scripts/codescripts/struct;

#namespace zm_genesis_challenges;

// Namespace zm_genesis_challenges
// Params 0, eflags: 0x1 linked
// Checksum 0xb72c1495, Offset: 0xe00
// Size: 0x1b4
function init_clientfields() {
    clientfield::register("clientuimodel", "trialWidget.visible", 15000, 1, "int");
    clientfield::register("clientuimodel", "trialWidget.progress", 15000, 7, "float");
    clientfield::register("clientuimodel", "trialWidget.icon", 15000, 2, "int");
    clientfield::register("toplayer", "challenge1state", 15000, 2, "int");
    clientfield::register("toplayer", "challenge2state", 15000, 2, "int");
    clientfield::register("toplayer", "challenge3state", 15000, 2, "int");
    clientfield::register("toplayer", "challenge_board_eyes", 15000, 1, "int");
    clientfield::register("scriptmover", "challenge_board_base", 15000, 1, "int");
    clientfield::register("scriptmover", "challenge_board_reward", 15000, 1, "int");
}

// Namespace zm_genesis_challenges
// Params 0, eflags: 0x2
// Checksum 0x96adb70d, Offset: 0xfc0
// Size: 0x24
function autoexec init() {
    callback::on_spawned(&on_player_spawned);
}

// Namespace zm_genesis_challenges
// Params 0, eflags: 0x1 linked
// Checksum 0x98a1c8d2, Offset: 0xff0
// Size: 0x8b4
function main() {
    level flag::init("all_challenges_completed");
    level flag::init("flag_init_player_challenges");
    if (getdvarint("splitscreen_playerCount") > 2) {
        array::run_all(getentarray("t_lookat_challenge_1", "targetname"), &delete);
        array::run_all(getentarray("t_lookat_challenge_2", "targetname"), &delete);
        array::run_all(getentarray("t_lookat_challenge_3", "targetname"), &delete);
        array::thread_all(struct::get_array("s_challenge_trigger"), &struct::delete);
        return;
    }
    level.var_ff453c39 = spawnstruct();
    level.var_ff453c39.var_c17bb43c = [];
    level.var_ff453c39.var_33832377 = [];
    level.var_ff453c39.var_d80a90e = [];
    array::add(level.var_ff453c39.var_c17bb43c, function_970609e0(1, %ZM_GENESIS_CHALLENGE_1_1, 10, "update_challenge_1_1", &function_1ce88534));
    array::add(level.var_ff453c39.var_c17bb43c, function_970609e0(1, %ZM_GENESIS_CHALLENGE_1_2, 15, "update_challenge_1_2", &function_8eeff46f));
    array::add(level.var_ff453c39.var_c17bb43c, function_970609e0(1, %ZM_GENESIS_CHALLENGE_1_5, 10, "update_challenge_1_5", &function_84de9b90));
    array::add(level.var_ff453c39.var_c17bb43c, function_970609e0(1, %ZM_GENESIS_CHALLENGE_1_8, 1, "update_challenge_1_8", &function_72fed2e5));
    array::add(level.var_ff453c39.var_c17bb43c, function_970609e0(1, %ZM_GENESIS_CHALLENGE_1_10, 1, "update_challenge_1_10", &function_9592bd2c));
    array::add(level.var_ff453c39.var_c17bb43c, function_970609e0(1, %ZM_GENESIS_CHALLENGE_3_6, 1, "update_challenge_3_6", &function_896db2ad));
    array::add(level.var_ff453c39.var_33832377, function_970609e0(2, %ZM_GENESIS_CHALLENGE_2_2, 10, "update_challenge_2_2", &function_e4aef098));
    array::add(level.var_ff453c39.var_33832377, function_970609e0(2, %ZM_GENESIS_CHALLENGE_2_7, 1, "update_challenge_2_7", &function_a2bb54a5));
    array::add(level.var_ff453c39.var_33832377, function_970609e0(2, %ZM_GENESIS_CHALLENGE_2_8, 15, "update_challenge_2_8", &function_a01222));
    array::add(level.var_ff453c39.var_33832377, function_970609e0(2, %ZM_GENESIS_CHALLENGE_1_9, 10, "update_challenge_1_9", &function_4cfc587c));
    array::add(level.var_ff453c39.var_33832377, function_970609e0(2, %ZM_GENESIS_CHALLENGE_2_10, 10, "update_challenge_2_10", &function_748fccd9));
    array::add(level.var_ff453c39.var_33832377, function_970609e0(2, %ZM_GENESIS_CHALLENGE_2_11, 1, "update_challenge_2_11", &function_4e8d5270));
    array::add(level.var_ff453c39.var_d80a90e, function_970609e0(3, %ZM_GENESIS_CHALLENGE_3_1, 5, "update_challenge_3_1", &function_17664372));
    array::add(level.var_ff453c39.var_d80a90e, function_970609e0(3, %ZM_GENESIS_CHALLENGE_3_2, 1, "update_challenge_3_2", &function_f163c909));
    array::add(level.var_ff453c39.var_d80a90e, function_970609e0(3, %ZM_GENESIS_CHALLENGE_3_3, 1, "update_challenge_3_3", &function_cb614ea0));
    array::add(level.var_ff453c39.var_d80a90e, function_970609e0(3, %ZM_GENESIS_CHALLENGE_3_4, 1, "update_challenge_3_4", &function_d572a77f));
    array::add(level.var_ff453c39.var_d80a90e, function_970609e0(3, %ZM_GENESIS_CHALLENGE_3_9, 3, "update_challenge_3_9", &function_477a16ba));
    array::add(level.var_ff453c39.var_d80a90e, function_970609e0(3, %ZM_GENESIS_CHALLENGE_2_9, 1, "update_challenge_2_9", &function_26a28c8b));
    zm_spawner::register_zombie_death_event_callback(&function_905d9544);
    zm_spawner::register_zombie_damage_callback(&function_6267dc);
    level.var_9b5d7667 = &function_ca31caac;
    level thread all_challenges_completed();
    level flag::set("flag_init_player_challenges");
    /#
        if (getdvarint("<dev string:x28>") > 0) {
            function_b9b4ce34();
        }
    #/
}

// Namespace zm_genesis_challenges
// Params 5, eflags: 0x1 linked
// Checksum 0x43d2948d, Offset: 0x18b0
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

// Namespace zm_genesis_challenges
// Params 0, eflags: 0x1 linked
// Checksum 0x4d1d4cd1, Offset: 0x1968
// Size: 0x294
function on_player_connect() {
    level flag::wait_till("flag_init_player_challenges");
    self flag::init("flag_player_collected_reward_1");
    self flag::init("flag_player_collected_reward_2");
    self flag::init("flag_player_collected_reward_3");
    self flag::init("flag_player_completed_challenge_1");
    self flag::init("flag_player_completed_challenge_2");
    self flag::init("flag_player_completed_challenge_3");
    self flag::init("flag_player_initialized_reward");
    self.var_ff453c39 = spawnstruct();
    self.var_ff453c39.var_c17bb43c = [];
    self.var_ff453c39.var_33832377 = [];
    self.var_ff453c39.var_d80a90e = [];
    self.var_ff453c39.var_c17bb43c = array::random(level.var_ff453c39.var_c17bb43c);
    self.var_ff453c39.var_33832377 = array::random(level.var_ff453c39.var_33832377);
    self.var_ff453c39.var_d80a90e = array::random(level.var_ff453c39.var_d80a90e);
    arrayremovevalue(level.var_ff453c39.var_c17bb43c, self.var_ff453c39.var_c17bb43c);
    arrayremovevalue(level.var_ff453c39.var_33832377, self.var_ff453c39.var_33832377);
    arrayremovevalue(level.var_ff453c39.var_d80a90e, self.var_ff453c39.var_d80a90e);
    self thread function_b7156b15();
}

// Namespace zm_genesis_challenges
// Params 0, eflags: 0x1 linked
// Checksum 0x57994019, Offset: 0x1c08
// Size: 0xdc
function on_player_disconnect() {
    level flag::wait_till("flag_init_player_challenges");
    var_a879fa43 = self getentitynumber();
    array::add(level.var_ff453c39.var_c17bb43c, self.var_ff453c39.var_c17bb43c);
    array::add(level.var_ff453c39.var_33832377, self.var_ff453c39.var_33832377);
    array::add(level.var_ff453c39.var_d80a90e, self.var_ff453c39.var_d80a90e);
}

// Namespace zm_genesis_challenges
// Params 0, eflags: 0x1 linked
// Checksum 0xb9317b9, Offset: 0x1cf0
// Size: 0x3c
function on_player_spawned() {
    self.var_b5c08e44 = [];
    self thread function_a235a040();
    self thread function_188466cb();
}

// Namespace zm_genesis_challenges
// Params 0, eflags: 0x1 linked
// Checksum 0xcc5ef462, Offset: 0x1d38
// Size: 0x8c
function function_188466cb() {
    self endon(#"death");
    level flag::wait_till_all(array("start_zombie_round_logic", "challenge_boards_ready"));
    var_a879fa43 = self getentitynumber();
    self clientfield::set_to_player("challenge_board_eyes", 1);
}

// Namespace zm_genesis_challenges
// Params 0, eflags: 0x1 linked
// Checksum 0xcdf5298b, Offset: 0x1dd0
// Size: 0x3c
function function_a235a040() {
    self endon(#"disconnect");
    while (true) {
        self function_2983de0c();
        level waittill(#"end_of_round");
    }
}

// Namespace zm_genesis_challenges
// Params 0, eflags: 0x1 linked
// Checksum 0x2fa2ee79, Offset: 0x1e18
// Size: 0x6a
function function_2983de0c() {
    self.var_b5c08e44["prison_island"] = 0;
    self.var_b5c08e44["asylum_island"] = 0;
    self.var_b5c08e44["temple_island"] = 0;
    self.var_b5c08e44["prototype_island"] = 0;
    self.var_b5c08e44["start_island"] = 0;
}

// Namespace zm_genesis_challenges
// Params 1, eflags: 0x1 linked
// Checksum 0x355636c0, Offset: 0x1e90
// Size: 0x54
function function_e8547a5b(var_cc0f18cc) {
    if (self.challenge_text !== var_cc0f18cc) {
        self.challenge_text = var_cc0f18cc;
        self luinotifyevent(%trial_set_description, 1, self.challenge_text);
    }
}

// Namespace zm_genesis_challenges
// Params 2, eflags: 0x1 linked
// Checksum 0x8166c1ce, Offset: 0x1ef0
// Size: 0xe6
function function_27f6c3cd(player, n_challenge_index) {
    switch (n_challenge_index) {
    case 1:
        player function_e8547a5b(player.var_ff453c39.var_c17bb43c.str_info);
        break;
    case 2:
        player function_e8547a5b(player.var_ff453c39.var_33832377.str_info);
        break;
    case 3:
        player function_e8547a5b(player.var_ff453c39.var_d80a90e.str_info);
        break;
    }
}

// Namespace zm_genesis_challenges
// Params 2, eflags: 0x1 linked
// Checksum 0x8d8b233a, Offset: 0x1fe0
// Size: 0x44
function function_33e91747(n_challenge_index, var_fe2fb4b9) {
    self clientfield::set_to_player("challenge" + n_challenge_index + "state", var_fe2fb4b9);
}

// Namespace zm_genesis_challenges
// Params 1, eflags: 0x1 linked
// Checksum 0x17bb14d8, Offset: 0x2030
// Size: 0xbc
function function_23c9ffd3(trigger) {
    self notify(#"hash_23c9ffd3");
    self endon(#"hash_23c9ffd3");
    while (true) {
        wait 0.5;
        if (!isdefined(self)) {
            break;
        }
        if (!isdefined(trigger) || distance(self.origin, trigger.stub.origin) > trigger.stub.radius) {
            self clientfield::set_player_uimodel("trialWidget.visible", 0);
            break;
        }
    }
}

// Namespace zm_genesis_challenges
// Params 0, eflags: 0x1 linked
// Checksum 0x907438e4, Offset: 0x20f8
// Size: 0x28c
function function_343b3db7() {
    level flag::init("challenge_boards_ready");
    level.var_92fc3c34 = [];
    for (x = 0; x < 4; x++) {
        str_name = "challenge_board_" + x;
        var_df95c68b = getent(str_name, "targetname");
        if (!isdefined(level.var_92fc3c34)) {
            level.var_92fc3c34 = [];
        } else if (!isarray(level.var_92fc3c34)) {
            level.var_92fc3c34 = array(level.var_92fc3c34);
        }
        level.var_92fc3c34[level.var_92fc3c34.size] = var_df95c68b;
        v_origin = var_df95c68b gettagorigin("tag_fx_skull_top");
        v_angles = var_df95c68b gettagangles("tag_fx_skull_top");
        var_df95c68b thread scene::play("p7_fxanim_zm_gen_challenge_prizestone_close_bundle", var_df95c68b);
        wait 0.2;
        var_df95c68b clientfield::set("challenge_board_base", 1);
    }
    level flag::set("challenge_boards_ready");
    for (i = 1; i <= 3; i++) {
        foreach (var_1030677c in getentarray("t_lookat_challenge_" + i, "targetname")) {
            var_1030677c setinvisibletoall();
        }
    }
}

// Namespace zm_genesis_challenges
// Params 0, eflags: 0x1 linked
// Checksum 0x177309d1, Offset: 0x2390
// Size: 0x37e
function function_b7156b15() {
    self endon(#"disconnect");
    self thread function_2ce855f3(self.var_ff453c39.var_c17bb43c);
    self thread function_2ce855f3(self.var_ff453c39.var_33832377);
    self thread function_2ce855f3(self.var_ff453c39.var_d80a90e);
    self thread function_fbbc8608(self.var_ff453c39.var_c17bb43c.n_index, "flag_player_completed_challenge_1");
    self thread function_fbbc8608(self.var_ff453c39.var_33832377.n_index, "flag_player_completed_challenge_2");
    self thread function_fbbc8608(self.var_ff453c39.var_d80a90e.n_index, "flag_player_completed_challenge_3");
    self thread function_974d5f1d();
    var_8e2d9e6f = [];
    var_e01fcddc = [];
    var_a879fa43 = self getentitynumber();
    for (i = 1; i <= 3; i++) {
        var_f2dc9f0b = [];
        foreach (var_1030677c in getentarray("t_lookat_challenge_" + i, "targetname")) {
            if (var_1030677c.script_int == var_a879fa43) {
                var_1030677c setvisibletoplayer(self);
                var_e01fcddc[i] = var_1030677c;
                break;
            }
            var_8e2d9e6f[i] = i;
        }
        self thread function_a2d25f82(i, var_a879fa43);
    }
    foreach (s_challenge in struct::get_array("s_challenge_trigger")) {
        if (s_challenge.script_int == var_a879fa43) {
            s_challenge function_4e61a018(var_e01fcddc, var_8e2d9e6f);
            break;
        }
    }
}

// Namespace zm_genesis_challenges
// Params 2, eflags: 0x1 linked
// Checksum 0xf0dc946d, Offset: 0x2718
// Size: 0xc4
function function_4e61a018(var_e01fcddc, var_8e2d9e6f) {
    self zm_unitrigger::create_unitrigger("", -128, &function_3ae0d6d5);
    self.s_unitrigger.require_look_at = 0;
    self.s_unitrigger.inactive_reassess_time = 0.1;
    zm_unitrigger::unitrigger_force_per_player_triggers(self.s_unitrigger, 1);
    self.s_unitrigger.var_8e2d9e6f = var_8e2d9e6f;
    self.var_e01fcddc = var_e01fcddc;
    self thread function_424b6fe8();
}

// Namespace zm_genesis_challenges
// Params 0, eflags: 0x1 linked
// Checksum 0x9a4480eb, Offset: 0x27e8
// Size: 0x3ee
function function_424b6fe8() {
    while (true) {
        e_who = self waittill(#"trigger_activated");
        var_e6b3078d = e_who getentitynumber();
        if (self.script_int == var_e6b3078d) {
            if (e_who flag::get("flag_player_initialized_reward")) {
                if (self.mdl_reward.n_challenge == 2) {
                    w_current = e_who getcurrentweapon();
                    if (isdefined(w_current.isgadget) && (isdefined(w_current.isheroweapon) && (zm_utility::is_placeable_mine(w_current) || zm_equipment::is_equipment(w_current) || w_current == level.weaponnone || w_current.isheroweapon) || w_current.isgadget)) {
                        continue;
                    }
                    if (e_who bgb::is_enabled("zm_bgb_disorderly_combat")) {
                        continue;
                    }
                } else if (self.mdl_reward.n_challenge == 3) {
                    a_perks = e_who getperks();
                    if (a_perks.size == level._custom_perks.size) {
                        continue;
                    }
                }
                e_who playrumbleonentity("zm_stalingrad_interact_rumble");
                self.s_unitrigger.playertrigger[e_who.entity_num] sethintstringforplayer(e_who, "");
                e_who player_give_reward(self.mdl_reward, var_e6b3078d);
                if (isdefined(self.mdl_reward)) {
                    self.mdl_reward delete();
                }
                continue;
            }
            for (i = 1; i <= 3; i++) {
                if (e_who function_3f67a723(self.var_e01fcddc[i].origin, 15, 0) && distance(e_who.origin, self.origin) < 500) {
                    if (isdefined(e_who.var_c981566c) && e_who.var_c981566c) {
                        break;
                    }
                    if (e_who flag::get("flag_player_completed_challenge_" + i) && !e_who flag::get("flag_player_collected_reward_" + i)) {
                        e_who playrumbleonentity("zm_stalingrad_interact_rumble");
                        self.s_unitrigger.playertrigger[e_who.entity_num] sethintstringforplayer(e_who, "");
                        self function_1d22626(e_who, i);
                        break;
                    }
                }
            }
        }
    }
}

// Namespace zm_genesis_challenges
// Params 2, eflags: 0x1 linked
// Checksum 0xd44240ee, Offset: 0x2be0
// Size: 0x4ec
function function_1d22626(e_player, n_challenge) {
    e_player endon(#"disconnect");
    var_7bb343ef = (0, 90, 0);
    a_s_rewards = struct::get_array("s_challenge_reward", "targetname");
    var_e6b3078d = e_player getentitynumber();
    foreach (s_reward in a_s_rewards) {
        if (s_reward.script_int == var_e6b3078d) {
            break;
        }
    }
    switch (n_challenge) {
    case 1:
        var_17b3dc96 = "p7_zm_power_up_max_ammo";
        s_reward.var_e1513629 = (0, 0, 6);
        s_reward.var_b90d551 = var_7bb343ef;
        break;
    case 2:
        var_3728fce1 = [];
        if (!isdefined(var_3728fce1)) {
            var_3728fce1 = [];
        } else if (!isarray(var_3728fce1)) {
            var_3728fce1 = array(var_3728fce1);
        }
        var_3728fce1[var_3728fce1.size] = "lmg_cqb_upgraded";
        if (!isdefined(var_3728fce1)) {
            var_3728fce1 = [];
        } else if (!isarray(var_3728fce1)) {
            var_3728fce1 = array(var_3728fce1);
        }
        var_3728fce1[var_3728fce1.size] = "ar_damage_upgraded";
        if (!isdefined(var_3728fce1)) {
            var_3728fce1 = [];
        } else if (!isarray(var_3728fce1)) {
            var_3728fce1 = array(var_3728fce1);
        }
        var_3728fce1[var_3728fce1.size] = "smg_versatile_upgraded";
        var_17b3dc96 = array::random(var_3728fce1);
        var_6b215f76 = anglestoright(s_reward.angles) * 5 + anglestoforward(s_reward.angles) * -2;
        s_reward.var_e1513629 = var_6b215f76 + (0, 0, 1);
        s_reward.var_b90d551 = var_7bb343ef;
        break;
    case 3:
        var_17b3dc96 = "zombie_pickup_perk_bottle";
        var_1bfa1f7e = anglestoforward(s_reward.angles) * -2;
        s_reward.var_e1513629 = var_1bfa1f7e + (0, 0, 7);
        s_reward.var_b90d551 = var_7bb343ef;
        break;
    }
    e_player.var_c981566c = 1;
    var_df95c68b = level.var_92fc3c34[var_e6b3078d];
    var_df95c68b scene::play("p7_fxanim_zm_gen_challenge_prizestone_open_bundle", var_df95c68b);
    var_df95c68b clientfield::set("challenge_board_reward", 1);
    self function_b1f54cb4(e_player, s_reward, var_17b3dc96, 30);
    self.mdl_reward clientfield::set("powerup_fx", 1);
    self.mdl_reward.n_challenge = n_challenge;
    e_player flag::set("flag_player_initialized_reward");
    self thread function_1ad9d1a0(e_player, 30 * -1, var_e6b3078d);
}

// Namespace zm_genesis_challenges
// Params 3, eflags: 0x1 linked
// Checksum 0x8c79455d, Offset: 0x30d8
// Size: 0xd4
function function_1ad9d1a0(e_player, n_dist, var_e6b3078d) {
    self endon(#"hash_422dba45");
    self.mdl_reward movez(n_dist, 12, 6);
    self.mdl_reward waittill(#"movedone");
    if (isdefined(e_player)) {
        e_player flag::clear("flag_player_initialized_reward");
        e_player.var_c981566c = undefined;
    }
    if (isdefined(self.mdl_reward)) {
        self.mdl_reward delete();
    }
    function_d57066e8(var_e6b3078d);
}

// Namespace zm_genesis_challenges
// Params 4, eflags: 0x1 linked
// Checksum 0x6f4ba3a6, Offset: 0x31b8
// Size: 0x18e
function function_b1f54cb4(e_player, s_reward, var_17b3dc96, var_21d0cf95) {
    if (isdefined(self.mdl_reward)) {
        self notify(#"hash_422dba45");
    }
    var_51a2f105 = s_reward.origin + s_reward.var_e1513629;
    v_spawn_angles = s_reward.angles + s_reward.var_b90d551;
    switch (var_17b3dc96) {
    case "ar_damage_upgraded":
    case "lmg_cqb_upgraded":
    case "smg_versatile_upgraded":
        self.mdl_reward = zm_utility::spawn_buildkit_weapon_model(e_player, getweapon(var_17b3dc96), undefined, var_51a2f105, v_spawn_angles);
        self.mdl_reward.str_weapon_name = var_17b3dc96;
        break;
    default:
        self.mdl_reward = util::spawn_model(var_17b3dc96, var_51a2f105, v_spawn_angles);
        break;
    }
    self.mdl_reward movez(var_21d0cf95, 1);
    playsoundatposition("evt_prize_rise", self.origin);
    self.mdl_reward waittill(#"movedone");
}

// Namespace zm_genesis_challenges
// Params 1, eflags: 0x1 linked
// Checksum 0xd14c29dc, Offset: 0x3350
// Size: 0x64
function function_d57066e8(var_e6b3078d) {
    var_df95c68b = level.var_92fc3c34[var_e6b3078d];
    var_df95c68b scene::play("p7_fxanim_zm_gen_challenge_prizestone_close_bundle", var_df95c68b);
    var_df95c68b clientfield::set("challenge_board_reward", 0);
}

// Namespace zm_genesis_challenges
// Params 2, eflags: 0x1 linked
// Checksum 0x2af5d9f3, Offset: 0x33c0
// Size: 0xb4
function function_a2d25f82(n_challenge, var_a879fa43) {
    self endon(#"disconnect");
    /#
        self endon(#"hash_f9ff0ae7");
    #/
    self flag::wait_till("flag_player_completed_challenge_" + n_challenge);
    str_model = "p7_zm_gen_challenge_medal_0" + n_challenge;
    var_df95c68b = level.var_92fc3c34[var_a879fa43];
    var_df95c68b attach(str_model, function_94a89297(n_challenge));
}

// Namespace zm_genesis_challenges
// Params 1, eflags: 0x1 linked
// Checksum 0x2bd57d0b, Offset: 0x3480
// Size: 0x5a
function function_94a89297(n_challenge) {
    switch (n_challenge) {
    case 1:
        return "tag_medal_easy";
    case 2:
        return "tag_medal_med";
    default:
        return "tag_medal_hard";
    }
}

// Namespace zm_genesis_challenges
// Params 2, eflags: 0x1 linked
// Checksum 0xbf97fc5a, Offset: 0x34e8
// Size: 0xfc
function function_fbbc8608(n_challenge_index, var_d4adfa57) {
    self endon(#"disconnect");
    self flag::wait_till(var_d4adfa57);
    var_ea22a0bf = "";
    if (n_challenge_index == 1) {
        var_ea22a0bf = self.var_ff453c39.var_c17bb43c.str_info;
    } else if (n_challenge_index == 2) {
        var_ea22a0bf = self.var_ff453c39.var_33832377.str_info;
    } else {
        var_ea22a0bf = self.var_ff453c39.var_d80a90e.str_info;
    }
    self luinotifyevent(%trial_complete, 3, %ZM_GENESIS_CHALLENGE_COMPLETE, var_ea22a0bf, n_challenge_index - 1);
}

// Namespace zm_genesis_challenges
// Params 1, eflags: 0x1 linked
// Checksum 0x5abf124b, Offset: 0x35f0
// Size: 0x3f8
function function_3ae0d6d5(e_player) {
    if (self.stub.related_parent.script_int == e_player getentitynumber()) {
        var_a51a0ba6 = 0;
        if (e_player flag::get("flag_player_initialized_reward")) {
            self sethintstringforplayer(e_player, %ZM_GENESIS_CHALLENGE_REWARD_TAKE);
            if (self.stub.related_parent.mdl_reward.n_challenge == 3) {
                a_perks = e_player getperks();
                if (a_perks.size == level._custom_perks.size) {
                    self sethintstringforplayer(e_player, "");
                }
            }
            var_a51a0ba6 = 1;
            return 1;
        }
        for (i = 1; i <= 3; i++) {
            if (e_player function_3f67a723(self.stub.related_parent.var_e01fcddc[i].origin, 15, 0) && distance(e_player.origin, self.stub.origin) < 500) {
                self function_27f6c3cd(e_player, i);
                e_player clientfield::set_player_uimodel("trialWidget.icon", i - 1);
                e_player clientfield::set_player_uimodel("trialWidget.visible", 1);
                e_player clientfield::set_player_uimodel("trialWidget.progress", e_player.var_5315d90d[i]);
                e_player thread function_23c9ffd3(self);
                if (!e_player flag::get("flag_player_completed_challenge_" + i)) {
                    self sethintstringforplayer(e_player, "");
                    var_a51a0ba6 = 1;
                    return 1;
                }
                if (!e_player flag::get("flag_player_collected_reward_" + i) && !(isdefined(e_player.var_c981566c) && e_player.var_c981566c)) {
                    self sethintstringforplayer(e_player, %ZM_GENESIS_CHALLENGE_REWARD);
                    var_a51a0ba6 = 1;
                    return 1;
                }
                self sethintstringforplayer(e_player, "");
                var_a51a0ba6 = 1;
                return 1;
            }
        }
        if (!var_a51a0ba6) {
            self sethintstringforplayer(e_player, "");
            e_player clientfield::set_player_uimodel("trialWidget.visible", 0);
            return 0;
        }
        return;
    }
    self sethintstringforplayer(e_player, "");
    return 0;
}

// Namespace zm_genesis_challenges
// Params 4, eflags: 0x1 linked
// Checksum 0x9387a989, Offset: 0x39f0
// Size: 0xb4
function function_3f67a723(origin, var_a0fa82de, do_trace, e_ignore) {
    if (!isdefined(var_a0fa82de)) {
        var_a0fa82de = 90;
    }
    var_a0fa82de = absangleclamp360(var_a0fa82de);
    var_303bd275 = cos(var_a0fa82de * 0.5);
    if (self util::is_player_looking_at(origin, var_303bd275, do_trace, e_ignore)) {
        return 1;
    }
    return 0;
}

// Namespace zm_genesis_challenges
// Params 2, eflags: 0x1 linked
// Checksum 0x1b5b16fa, Offset: 0x3ab0
// Size: 0x1d6
function player_give_reward(mdl_reward, var_e6b3078d) {
    switch (mdl_reward.n_challenge) {
    case 1:
        level thread zm_powerups::specific_powerup_drop("full_ammo", self.origin);
        playsoundatposition("evt_grab_powerup", self.origin);
        break;
    case 2:
        if (isdefined(mdl_reward.str_weapon_name)) {
            w_reward = getweapon(mdl_reward.str_weapon_name);
        }
        self thread swap_weapon(w_reward);
        playsoundatposition("evt_grab_weapon", self.origin);
        break;
    case 3:
        self thread function_6131520e();
        playsoundatposition("evt_grab_perk", self.origin);
        break;
    }
    self flag::set("flag_player_collected_reward_" + mdl_reward.n_challenge);
    self flag::clear("flag_player_initialized_reward");
    self function_33e91747(mdl_reward.n_challenge, 2);
    level thread function_d57066e8(var_e6b3078d);
    self.var_c981566c = undefined;
}

// Namespace zm_genesis_challenges
// Params 1, eflags: 0x1 linked
// Checksum 0xab89d36f, Offset: 0x3c90
// Size: 0x13c
function swap_weapon(w_new) {
    w_current = self getcurrentweapon();
    if (!zm_utility::is_player_valid(self)) {
        return;
    }
    if (self.is_drinking > 0) {
        return;
    }
    if (zm_utility::is_placeable_mine(w_current) || zm_equipment::is_equipment(w_current) || w_current == level.weaponnone) {
        return;
    }
    if (!self hasweapon(w_new.rootweapon, 1)) {
        if (w_current.type === "melee") {
            self function_3420bc2f(w_new);
        } else {
            self function_dcfc8bde(w_current, w_new);
        }
        return;
    }
    self givemaxammo(w_new);
}

// Namespace zm_genesis_challenges
// Params 2, eflags: 0x1 linked
// Checksum 0x5116d481, Offset: 0x3dd8
// Size: 0xd4
function function_dcfc8bde(w_current, w_new) {
    var_d2f4cbdf = self getweaponslistprimaries();
    if (isdefined(var_d2f4cbdf) && var_d2f4cbdf.size >= zm_utility::get_player_weapon_limit(self)) {
        self takeweapon(w_current);
    }
    var_6fc96b00 = self zm_weapons::give_build_kit_weapon(w_new);
    self giveweapon(var_6fc96b00);
    self switchtoweapon(var_6fc96b00);
}

// Namespace zm_genesis_challenges
// Params 1, eflags: 0x1 linked
// Checksum 0xdd662cad, Offset: 0x3eb8
// Size: 0x114
function function_3420bc2f(w_new) {
    var_6f845c3d = self getweaponslist(1);
    foreach (var_cdee635d in var_6f845c3d) {
        if (var_cdee635d.type === "melee") {
            self takeweapon(var_cdee635d);
            break;
        }
    }
    var_6fc96b00 = self zm_weapons::give_build_kit_weapon(w_new);
    self giveweapon(var_6fc96b00);
}

// Namespace zm_genesis_challenges
// Params 0, eflags: 0x1 linked
// Checksum 0x5949b03c, Offset: 0x3fd8
// Size: 0xf6
function function_6131520e() {
    self endon(#"disconnect");
    a_str_perks = getarraykeys(level._custom_perks);
    a_str_perks = array::randomize(a_str_perks);
    foreach (str_perk in a_str_perks) {
        if (!self hasperk(str_perk)) {
            self zm_perks::give_perk(str_perk, 0);
            break;
        }
    }
}

// Namespace zm_genesis_challenges
// Params 0, eflags: 0x0
// Checksum 0x3e30cb05, Offset: 0x40d8
// Size: 0x40
function function_1adeaa1c() {
    var_4562cc04 = level.perk_purchase_limit;
    if (self flag::get("flag_player_collected_reward_3")) {
        var_4562cc04++;
    }
    return var_4562cc04;
}

// Namespace zm_genesis_challenges
// Params 0, eflags: 0x1 linked
// Checksum 0x86060531, Offset: 0x4120
// Size: 0x7c
function function_1ce88534() {
    self endon(#"flag_player_completed_challenge_1");
    self endon(#"disconnect");
    if (!isdefined(self.var_11e81afa)) {
        self.var_11e81afa = 0;
    }
    if (!isdefined(self.n_electric_trap_kills)) {
        self.n_electric_trap_kills = 0;
    }
    self thread function_9b1e43e5();
    self thread function_c120be4e();
}

// Namespace zm_genesis_challenges
// Params 0, eflags: 0x1 linked
// Checksum 0x1502a38f, Offset: 0x41a8
// Size: 0x82
function function_9b1e43e5() {
    self endon(#"flag_player_completed_challenge_1");
    self endon(#"disconnect");
    while (true) {
        ai_zombie, e_attacker = level waittill(#"hash_ac4cc18c");
        if (e_attacker === self && self.var_11e81afa < 5) {
            self.var_11e81afa++;
            self notify(#"update_challenge_1_1");
        }
    }
}

// Namespace zm_genesis_challenges
// Params 0, eflags: 0x1 linked
// Checksum 0xec7b088b, Offset: 0x4238
// Size: 0x5e
function function_c120be4e() {
    self endon(#"flag_player_completed_challenge_1");
    self endon(#"disconnect");
    while (true) {
        self waittill(#"zombie_zapped");
        if (self.n_electric_trap_kills < 5) {
            self.n_electric_trap_kills++;
            self notify(#"update_challenge_1_1");
        }
    }
}

// Namespace zm_genesis_challenges
// Params 0, eflags: 0x1 linked
// Checksum 0x570b0ac1, Offset: 0x42a0
// Size: 0x5a
function function_8eeff46f() {
    self endon(#"flag_player_completed_challenge_1");
    self endon(#"disconnect");
    while (true) {
        e_attacker = level waittill(#"hash_98ea05");
        if (e_attacker === self) {
            self notify(#"update_challenge_1_2");
        }
    }
}

// Namespace zm_genesis_challenges
// Params 0, eflags: 0x0
// Checksum 0x99a53513, Offset: 0x4308
// Size: 0x72
function function_68ed7a06() {
    self endon(#"flag_player_completed_challenge_1");
    self endon(#"disconnect");
    while (true) {
        str_result = level util::waittill_any("all_rifts_destroyed", "chaos_round_timeout");
        if (str_result === "all_rifts_destroyed") {
            self notify(#"hash_d7d3166");
        }
    }
}

// Namespace zm_genesis_challenges
// Params 0, eflags: 0x0
// Checksum 0xfdc4638d, Offset: 0x4388
// Size: 0x5a
function function_aae115f9() {
    self endon(#"flag_player_completed_challenge_1");
    self endon(#"disconnect");
    while (true) {
        e_attacker = level waittill(#"hash_10ed65db");
        if (e_attacker === self) {
            self notify(#"hash_4f70cd59");
        }
    }
}

// Namespace zm_genesis_challenges
// Params 0, eflags: 0x1 linked
// Checksum 0xf3a57c08, Offset: 0x43f0
// Size: 0x5a
function function_84de9b90() {
    self endon(#"flag_player_completed_challenge_1");
    self endon(#"disconnect");
    while (true) {
        e_attacker = level waittill(#"hash_646a26b1");
        if (e_attacker === self) {
            self notify(#"update_challenge_1_5");
        }
    }
}

// Namespace zm_genesis_challenges
// Params 0, eflags: 0x0
// Checksum 0xcb7e89f0, Offset: 0x4458
// Size: 0x5a
function function_f6e60acb() {
    self endon(#"flag_player_completed_challenge_1");
    self endon(#"disconnect");
    while (true) {
        e_attacker = level waittill(#"hash_944787dd");
        if (e_attacker === self) {
            self notify(#"hash_9b75c22b");
        }
    }
}

// Namespace zm_genesis_challenges
// Params 0, eflags: 0x0
// Checksum 0xcc327dd7, Offset: 0x44c0
// Size: 0x5a
function function_d0e39062() {
    self endon(#"flag_player_completed_challenge_1");
    self endon(#"disconnect");
    while (true) {
        e_attacker = level waittill(#"hash_b1d69866");
        if (e_attacker === self) {
            self notify(#"hash_757347c2");
        }
    }
}

// Namespace zm_genesis_challenges
// Params 0, eflags: 0x1 linked
// Checksum 0x923f3d1a, Offset: 0x4528
// Size: 0x5e
function function_72fed2e5() {
    self endon(#"flag_player_completed_challenge_1");
    self endon(#"disconnect");
    while (true) {
        weapon = self waittill(#"new_equipment");
        if (weapon === level.weaponriotshield) {
            self notify(#"update_challenge_1_8");
        }
    }
}

// Namespace zm_genesis_challenges
// Params 0, eflags: 0x1 linked
// Checksum 0xb05b0d43, Offset: 0x4590
// Size: 0x5a
function function_4cfc587c() {
    self endon(#"flag_player_completed_challenge_2");
    self endon(#"disconnect");
    while (true) {
        e_attacker = level waittill(#"hash_92ad8590");
        if (e_attacker === self) {
            self notify(#"update_challenge_1_9");
        }
    }
}

// Namespace zm_genesis_challenges
// Params 0, eflags: 0x1 linked
// Checksum 0x7ac1bb46, Offset: 0x45f8
// Size: 0x42
function function_9592bd2c() {
    self endon(#"flag_player_completed_challenge_1");
    self endon(#"disconnect");
    while (true) {
        level waittill(#"hash_7e8efe7c");
        self notify(#"update_challenge_1_10");
    }
}

// Namespace zm_genesis_challenges
// Params 0, eflags: 0x0
// Checksum 0x44ac8328, Offset: 0x4648
// Size: 0x5a
function function_56b65fd3() {
    self endon(#"flag_player_completed_challenge_2");
    self endon(#"disconnect");
    while (true) {
        e_attacker = level waittill(#"hash_11ab530d");
        if (e_attacker === self) {
            self notify(#"hash_fb461733");
        }
    }
}

// Namespace zm_genesis_challenges
// Params 0, eflags: 0x1 linked
// Checksum 0x8e70664a, Offset: 0x46b0
// Size: 0x5a
function function_e4aef098() {
    self endon(#"flag_player_completed_challenge_2");
    self endon(#"disconnect");
    while (true) {
        e_attacker = level waittill(#"hash_b1a8571a");
        if (e_attacker === self) {
            self notify(#"update_challenge_2_2");
        }
    }
}

// Namespace zm_genesis_challenges
// Params 0, eflags: 0x0
// Checksum 0x8b49cbd3, Offset: 0x4718
// Size: 0x13e
function function_ab16b01() {
    level flagsys::wait_till("start_zombie_round_logic");
    self endon(#"flag_player_completed_challenge_2");
    self endon(#"disconnect");
    var_259ad2d8 = getent("apothicon_island", "targetname");
    level flag::wait_till_all(array("power_on1", "power_on2", "power_on3", "power_on4"));
    while (true) {
        self waittill(#"hash_a8c34632");
        start_round = level.round_number;
        while (self istouching(var_259ad2d8) && level.round_number - start_round < 3) {
            wait 1;
        }
        if (level.round_number - start_round >= 3) {
            self notify(#"hash_af412261");
        }
    }
}

// Namespace zm_genesis_challenges
// Params 0, eflags: 0x0
// Checksum 0x57585b83, Offset: 0x4860
// Size: 0x82
function function_c8bdcf0e() {
    self endon(#"flag_player_completed_challenge_2");
    self endon(#"disconnect");
    while (true) {
        level waittill(#"hash_c2b1dec7");
        n_start_time = gettime();
        function_ac2bad00(n_start_time, 120);
        if (n_start_time < 120) {
            self notify(#"hash_6d4d866e");
        }
    }
}

// Namespace zm_genesis_challenges
// Params 2, eflags: 0x1 linked
// Checksum 0xe5efa13e, Offset: 0x48f0
// Size: 0x90
function function_ac2bad00(n_start_time, var_8d05fd02) {
    level endon(#"chaos_round_complete");
    level endon(#"kill_round");
    level endon(#"chaos_round_timeout");
    n_total_time = 0;
    while (n_total_time < var_8d05fd02) {
        n_current_time = gettime();
        n_total_time = (n_current_time - n_start_time) / 1000;
        util::wait_network_frame();
    }
}

// Namespace zm_genesis_challenges
// Params 0, eflags: 0x0
// Checksum 0xd10a03e0, Offset: 0x4988
// Size: 0x8a
function function_eec04977() {
    self endon(#"flag_player_completed_challenge_2");
    self endon(#"disconnect");
    while (true) {
        level waittill(#"hash_661aa774");
        str_result = level util::waittill_any("power_ritual_aborted", "power_ritual_completed", "non_melee_damage");
        if (str_result === "power_ritual_completed") {
            self notify(#"hash_935000d7");
        }
    }
}

// Namespace zm_genesis_challenges
// Params 0, eflags: 0x0
// Checksum 0x78a445c, Offset: 0x4a20
// Size: 0x5a
function function_7cb8da3c() {
    self endon(#"flag_player_completed_challenge_2");
    self endon(#"disconnect");
    while (true) {
        e_attacker = level waittill(#"hash_1c04ac7f");
        if (e_attacker === self) {
            self notify(#"hash_2148919c");
        }
    }
}

// Namespace zm_genesis_challenges
// Params 0, eflags: 0x1 linked
// Checksum 0x770da73a, Offset: 0x4a88
// Size: 0x5a
function function_a2bb54a5() {
    self endon(#"flag_player_completed_challenge_2");
    self endon(#"disconnect");
    while (true) {
        e_attacker = level waittill(#"hash_e15c8839");
        if (e_attacker === self) {
            self notify(#"update_challenge_2_7");
        }
    }
}

// Namespace zm_genesis_challenges
// Params 0, eflags: 0x1 linked
// Checksum 0x78c365c5, Offset: 0x4af0
// Size: 0x42
function function_a01222() {
    self endon(#"flag_player_completed_challenge_2");
    self endon(#"disconnect");
    while (true) {
        self waittill(#"hash_d46a1dc6");
        self notify(#"update_challenge_2_8");
    }
}

// Namespace zm_genesis_challenges
// Params 0, eflags: 0x1 linked
// Checksum 0xe76ed530, Offset: 0x4b40
// Size: 0x5a
function function_26a28c8b() {
    self endon(#"flag_player_completed_challenge_3");
    self endon(#"disconnect");
    while (true) {
        e_attacker = level waittill(#"hash_8dbe1895");
        if (e_attacker === self) {
            self notify(#"update_challenge_2_9");
        }
    }
}

// Namespace zm_genesis_challenges
// Params 0, eflags: 0x1 linked
// Checksum 0x1562382a, Offset: 0x4ba8
// Size: 0x42
function function_748fccd9() {
    self endon(#"flag_player_completed_challenge_2");
    self endon(#"disconnect");
    while (true) {
        self waittill(#"hash_21c74868");
        self notify(#"update_challenge_2_10");
    }
}

// Namespace zm_genesis_challenges
// Params 0, eflags: 0x1 linked
// Checksum 0x48a4275f, Offset: 0x4bf8
// Size: 0x42
function function_4e8d5270() {
    self endon(#"flag_player_completed_challenge_2");
    self endon(#"disconnect");
    while (true) {
        self waittill(#"hash_36abd341");
        self notify(#"update_challenge_2_11");
    }
}

// Namespace zm_genesis_challenges
// Params 0, eflags: 0x1 linked
// Checksum 0xc6b0234, Offset: 0x4c48
// Size: 0x5a
function function_17664372() {
    self endon(#"flag_player_completed_challenge_3");
    self endon(#"disconnect");
    while (true) {
        e_attacker = level waittill(#"hash_f312481d");
        if (e_attacker === self) {
            self notify(#"update_challenge_3_1");
        }
    }
}

// Namespace zm_genesis_challenges
// Params 0, eflags: 0x1 linked
// Checksum 0x262aa49e, Offset: 0x4cb0
// Size: 0x44
function function_f163c909() {
    spawner::add_archetype_spawn_function("mechz", &function_8c4a46cf, self);
    self thread function_78a15a9();
}

// Namespace zm_genesis_challenges
// Params 1, eflags: 0x1 linked
// Checksum 0xb6eddd49, Offset: 0x4d00
// Size: 0x94
function function_8c4a46cf(e_player) {
    e_player endon(#"flag_player_completed_challenge_3");
    e_player endon(#"disconnect");
    self endon(#"hash_da235077");
    e_attacker, n_damage, w_weapon, v_point, v_dir = self waittill(#"death");
    if (e_attacker === e_player) {
        e_attacker notify(#"update_challenge_3_2");
    }
}

// Namespace zm_genesis_challenges
// Params 0, eflags: 0x1 linked
// Checksum 0x651a709e, Offset: 0x4da0
// Size: 0xa0
function function_78a15a9() {
    self endon(#"flag_player_completed_challenge_3");
    self endon(#"disconnect");
    self endon(#"update_challenge_3_2");
    while (true) {
        n_damage, e_attacker = self waittill(#"damage");
        if (e_attacker.archetype === "mechz" || e_attacker.archetype === "margwa") {
            e_attacker notify(#"hash_da235077");
        }
    }
}

// Namespace zm_genesis_challenges
// Params 0, eflags: 0x1 linked
// Checksum 0xb2736c3c, Offset: 0x4e48
// Size: 0x42
function function_cb614ea0() {
    self endon(#"flag_player_completed_challenge_3");
    self endon(#"disconnect");
    while (true) {
        self waittill(#"hash_bf458b1e");
        self notify(#"update_challenge_3_3");
    }
}

// Namespace zm_genesis_challenges
// Params 0, eflags: 0x1 linked
// Checksum 0x15e8b718, Offset: 0x4e98
// Size: 0xda
function function_d572a77f() {
    self endon(#"flag_player_completed_challenge_3");
    self endon(#"disconnect");
    var_f434985b = 0;
    var_2576a2b = 0;
    while (true) {
        str_result = self util::waittill_any_return("flag_player_completed_challenge_3", "disconnect", "fire_margwa_death", "shadow_margwa_death");
        if (str_result == "fire_margwa_death") {
            var_f434985b = 1;
        } else if (str_result == "shadow_margwa_death") {
            var_2576a2b = 1;
        }
        if (var_f434985b && var_2576a2b) {
            self notify(#"update_challenge_3_4");
        }
    }
}

// Namespace zm_genesis_challenges
// Params 0, eflags: 0x0
// Checksum 0x38e997fd, Offset: 0x4f80
// Size: 0xa2
function function_af702d16() {
    level flagsys::wait_till("start_zombie_round_logic");
    self endon(#"flag_player_completed_challenge_3");
    self endon(#"disconnect");
    level flag::wait_till_all(array("power_on1", "power_on2", "power_on3", "power_on4"));
    if (level.round_number <= 5) {
        self notify(#"hash_c61c5576");
    }
}

// Namespace zm_genesis_challenges
// Params 0, eflags: 0x1 linked
// Checksum 0x241d47e2, Offset: 0x5030
// Size: 0x5a
function function_896db2ad() {
    self endon(#"flag_player_completed_challenge_1");
    self endon(#"disconnect");
    while (true) {
        e_attacker = level waittill(#"hash_9a954bfc");
        if (e_attacker === self) {
            self notify(#"update_challenge_3_6");
        }
    }
}

// Namespace zm_genesis_challenges
// Params 0, eflags: 0x0
// Checksum 0x9b34ebfe, Offset: 0x5098
// Size: 0x5a
function function_636b3844() {
    self endon(#"flag_player_completed_challenge_3");
    self endon(#"disconnect");
    while (true) {
        e_attacker = level waittill(#"hash_22e3a570");
        if (e_attacker === self) {
            self notify(#"hash_7a1760a4");
        }
    }
}

// Namespace zm_genesis_challenges
// Params 0, eflags: 0x0
// Checksum 0xc36568c, Offset: 0x5100
// Size: 0x5a
function function_6d7c9123() {
    self endon(#"flag_player_completed_challenge_3");
    self endon(#"disconnect");
    while (true) {
        e_attacker = level waittill(#"hash_d290d94f");
        if (e_attacker === self) {
            self notify(#"hash_8428b983");
        }
    }
}

// Namespace zm_genesis_challenges
// Params 0, eflags: 0x1 linked
// Checksum 0xd8b01e35, Offset: 0x5168
// Size: 0x42
function function_477a16ba() {
    self endon(#"flag_player_completed_challenge_3");
    self endon(#"disconnect");
    while (true) {
        self waittill(#"hash_7b1b2d");
        self notify(#"update_challenge_3_9");
    }
}

// Namespace zm_genesis_challenges
// Params 1, eflags: 0x1 linked
// Checksum 0x7621865d, Offset: 0x51b8
// Size: 0x284
function function_905d9544(e_attacker) {
    if (isplayer(e_attacker)) {
        if (self.archetype === "apothicon_fury") {
            if (zm_utility::is_headshot(self.damageweapon, self.damagelocation, self.damagemod)) {
                level notify(#"hash_646a26b1", e_attacker);
            }
        }
        if (isdefined(self.traversal)) {
            if (isdefined(self.traversal.startnode)) {
                if (self.traversal.startnode.script_noteworthy === "flinger_traversal") {
                    e_attacker notify(#"hash_21c74868");
                }
            }
        }
        if (self.archetype === "zombie") {
            self thread function_4d042c7d(e_attacker);
        }
        if (isdefined(e_attacker.var_a3d40b8) && isdefined(self.var_a3d40b8)) {
            if (e_attacker.var_a3d40b8 !== self.var_a3d40b8) {
                level notify(#"hash_f312481d", e_attacker);
            }
        }
        if (self.archetype === "margwa") {
            if (self.var_b6802ed1[e_attacker.playernum] <= 3) {
                e_attacker notify(#"hash_bf458b1e");
            }
            if (self.var_f9ebd43e === "fire") {
                e_attacker notify(#"fire_margwa_death");
            } else if (self.var_f9ebd43e === "shadow") {
                e_attacker notify(#"shadow_margwa_death");
            }
            if (self.zone_name === "apothicon_interior_zone") {
                e_attacker notify(#"hash_7b1b2d");
            }
        }
        return;
    }
    if (isdefined(e_attacker) && e_attacker.archetype === "turret") {
        if (isdefined(e_attacker.activated_by_player)) {
            e_attacker.activated_by_player notify(#"hash_93091f5f");
            level notify(#"hash_93091f5f");
            self thread function_4d042c7d(e_attacker.activated_by_player);
        }
    }
}

// Namespace zm_genesis_challenges
// Params 1, eflags: 0x1 linked
// Checksum 0xb67f8557, Offset: 0x5448
// Size: 0x15e
function function_4d042c7d(player) {
    if (isdefined(self.var_a3d40b8)) {
        var_bc09c7dd = 1;
        switch (self.var_a3d40b8) {
        case "asylum_island":
        case "prison_island":
        case "prototype_island":
        case "start_island":
        case "temple_island":
            player.var_b5c08e44[self.var_a3d40b8]++;
            a_str_keys = getarraykeys(player.var_b5c08e44);
            foreach (str_key in a_str_keys) {
                if (player.var_b5c08e44[str_key] < 5) {
                    var_bc09c7dd = 0;
                }
            }
            if (var_bc09c7dd) {
                player notify(#"hash_36abd341");
            }
            break;
        }
    }
}

// Namespace zm_genesis_challenges
// Params 13, eflags: 0x1 linked
// Checksum 0xb1831b3, Offset: 0x55b0
// Size: 0xc4
function function_6267dc(str_mod, var_5afff096, var_7c5a4ee4, e_player, n_amount, w_weapon, v_direction, str_tag, str_model, str_part, n_flags, e_inflictor, var_9780eb62) {
    if (isplayer(e_inflictor)) {
        if (!(isdefined(zm_utility::is_melee_weapon(w_weapon)) && zm_utility::is_melee_weapon(w_weapon))) {
            level notify(#"non_melee_damage");
        }
    }
    return false;
}

// Namespace zm_genesis_challenges
// Params 1, eflags: 0x1 linked
// Checksum 0xca2fe9c1, Offset: 0x5680
// Size: 0x154
function function_2ce855f3(s_challenge) {
    self endon(#"disconnect");
    /#
        self endon(#"hash_f9ff0ae7");
    #/
    if (isdefined(s_challenge.func_think)) {
        self thread [[ s_challenge.func_think ]]();
    }
    var_80792f67 = s_challenge.n_count;
    if (!isdefined(self.var_5315d90d)) {
        self.var_5315d90d = [];
    }
    self.var_5315d90d[s_challenge.n_index] = 0;
    var_ea184c3d = var_80792f67;
    while (var_80792f67 > 0) {
        self waittill(s_challenge.str_notify);
        var_80792f67--;
        self.var_5315d90d[s_challenge.n_index] = 1 - var_80792f67 / var_ea184c3d;
    }
    self function_33e91747(s_challenge.n_index, 1);
    self flag::set("flag_player_completed_challenge_" + s_challenge.n_index);
}

// Namespace zm_genesis_challenges
// Params 0, eflags: 0x1 linked
// Checksum 0xee0974ce, Offset: 0x57e0
// Size: 0x6a
function function_974d5f1d() {
    self endon(#"disconnect");
    a_flags = array("flag_player_completed_challenge_1", "flag_player_completed_challenge_2", "flag_player_completed_challenge_3");
    self flag::wait_till_all(a_flags);
    level notify(#"hash_41370469");
}

// Namespace zm_genesis_challenges
// Params 0, eflags: 0x1 linked
// Checksum 0x7593fb71, Offset: 0x5858
// Size: 0x8c
function all_challenges_completed() {
    level.var_c28313cd = 0;
    callback::on_disconnect(&function_b1cd865a);
    while (true) {
        level waittill(#"hash_41370469");
        level.var_c28313cd++;
        if (level.var_c28313cd >= level.players.size) {
            level flag::set("all_challenges_completed");
            break;
        }
    }
}

// Namespace zm_genesis_challenges
// Params 0, eflags: 0x1 linked
// Checksum 0xd48001cf, Offset: 0x58f0
// Size: 0x34
function function_b1cd865a() {
    if (level.var_c28313cd >= level.players.size) {
        level flag::set("all_challenges_completed");
    }
}

// Namespace zm_genesis_challenges
// Params 12, eflags: 0x1 linked
// Checksum 0x207a9e0f, Offset: 0x5930
// Size: 0xea
function function_ca31caac(inflictor, attacker, damage, dflags, mod, weapon, point, dir, hitloc, offsettime, boneindex, modelindex) {
    if (isplayer(attacker)) {
        if (!isdefined(self.var_b6802ed1)) {
            self.var_b6802ed1 = [];
        }
        if (!isdefined(self.var_b6802ed1[attacker.playernum])) {
            self.var_b6802ed1[attacker.playernum] = 0;
        }
        self.var_b6802ed1[attacker.playernum]++;
    }
}

/#

    // Namespace zm_genesis_challenges
    // Params 0, eflags: 0x1 linked
    // Checksum 0xa9d71721, Offset: 0x5a28
    // Size: 0xbc
    function function_b9b4ce34() {
        zm_devgui::add_custom_devgui_callback(&function_16ba3a1e);
        adddebugcommand("<dev string:x35>");
        adddebugcommand("<dev string:xa0>");
        adddebugcommand("<dev string:x100>");
        adddebugcommand("<dev string:x160>");
        adddebugcommand("<dev string:x1c0>");
        adddebugcommand("<dev string:x21f>");
    }

    // Namespace zm_genesis_challenges
    // Params 1, eflags: 0x1 linked
    // Checksum 0xce5a43d9, Offset: 0x5af0
    // Size: 0x412
    function function_16ba3a1e(cmd) {
        switch (cmd) {
        case "<dev string:x276>":
            level flag::set("<dev string:x276>");
            return 1;
        case "<dev string:x28f>":
            foreach (e_player in level.players) {
                e_player flag::set("<dev string:x2a5>");
                e_player notify(#"hash_fb393ffe");
                e_player.var_5315d90d[1] = 1;
                e_player function_33e91747(1, 1);
            }
            return 1;
        case "<dev string:x2c7>":
            foreach (e_player in level.players) {
                e_player flag::set("<dev string:x2dd>");
                e_player notify(#"hash_d536c595");
                e_player.var_5315d90d[2] = 1;
                e_player function_33e91747(2, 1);
            }
            return 1;
        case "<dev string:x2ff>":
            foreach (e_player in level.players) {
                e_player flag::set("<dev string:x315>");
                e_player notify(#"hash_af344b2c");
                e_player.var_5315d90d[3] = 1;
                e_player function_33e91747(3, 1);
            }
            return 1;
        case "<dev string:x337>":
            level function_dcfe1b91();
            foreach (e_player in level.players) {
                e_player function_224232f4();
            }
            return 1;
        case "<dev string:x34c>":
            foreach (e_player in level.players) {
                e_player function_224232f4();
            }
            return 1;
        }
        return 0;
    }

    // Namespace zm_genesis_challenges
    // Params 0, eflags: 0x1 linked
    // Checksum 0xa4f1eee6, Offset: 0x5f10
    // Size: 0x270
    function function_224232f4() {
        self notify(#"hash_f9ff0ae7");
        self flag::clear("<dev string:x35d>");
        self flag::clear("<dev string:x37c>");
        self flag::clear("<dev string:x39b>");
        self flag::clear("<dev string:x2a5>");
        self flag::clear("<dev string:x2dd>");
        self flag::clear("<dev string:x315>");
        self thread function_2ce855f3(self.var_ff453c39.var_c17bb43c);
        self thread function_2ce855f3(self.var_ff453c39.var_33832377);
        self thread function_2ce855f3(self.var_ff453c39.var_d80a90e);
        var_a879fa43 = self getentitynumber();
        for (i = 1; i <= 3; i++) {
            self.var_5315d90d[i] = 0;
            self function_33e91747(i, 0);
            foreach (s_glyph in struct::get_array("<dev string:x3ba>" + i, "<dev string:x3cd>")) {
                if (s_glyph.script_int == var_a879fa43) {
                    break;
                }
            }
        }
    }

    // Namespace zm_genesis_challenges
    // Params 0, eflags: 0x1 linked
    // Checksum 0x9340083a, Offset: 0x6188
    // Size: 0x452
    function function_dcfe1b91() {
        foreach (e_player in level.players) {
            if (!isdefined(level.var_ff453c39.var_c17bb43c)) {
                level.var_ff453c39.var_c17bb43c = [];
            } else if (!isarray(level.var_ff453c39.var_c17bb43c)) {
                level.var_ff453c39.var_c17bb43c = array(level.var_ff453c39.var_c17bb43c);
            }
            level.var_ff453c39.var_c17bb43c[level.var_ff453c39.var_c17bb43c.size] = e_player.var_ff453c39.var_c17bb43c;
            if (!isdefined(level.var_ff453c39.var_33832377)) {
                level.var_ff453c39.var_33832377 = [];
            } else if (!isarray(level.var_ff453c39.var_33832377)) {
                level.var_ff453c39.var_33832377 = array(level.var_ff453c39.var_33832377);
            }
            level.var_ff453c39.var_33832377[level.var_ff453c39.var_33832377.size] = e_player.var_ff453c39.var_33832377;
            if (!isdefined(level.var_ff453c39.var_d80a90e)) {
                level.var_ff453c39.var_d80a90e = [];
            } else if (!isarray(level.var_ff453c39.var_d80a90e)) {
                level.var_ff453c39.var_d80a90e = array(level.var_ff453c39.var_d80a90e);
            }
            level.var_ff453c39.var_d80a90e[level.var_ff453c39.var_d80a90e.size] = e_player.var_ff453c39.var_d80a90e;
        }
        foreach (e_player in level.players) {
            e_player.var_ff453c39.var_c17bb43c = array::random(level.var_ff453c39.var_c17bb43c);
            e_player.var_ff453c39.var_33832377 = array::random(level.var_ff453c39.var_33832377);
            e_player.var_ff453c39.var_d80a90e = array::random(level.var_ff453c39.var_d80a90e);
            arrayremovevalue(level.var_ff453c39.var_c17bb43c, e_player.var_ff453c39.var_c17bb43c);
            arrayremovevalue(level.var_ff453c39.var_33832377, e_player.var_ff453c39.var_33832377);
            arrayremovevalue(level.var_ff453c39.var_d80a90e, e_player.var_ff453c39.var_d80a90e);
        }
    }

#/
