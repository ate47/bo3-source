#using scripts/codescripts/struct;
#using scripts/shared/array_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/scoreevents_shared;
#using scripts/shared/system_shared;
#using scripts/shared/trigger_shared;
#using scripts/shared/util_shared;
#using scripts/zm/_zm_bgb;
#using scripts/zm/_zm_devgui;
#using scripts/zm/_zm_equipment;
#using scripts/zm/_zm_perks;
#using scripts/zm/_zm_powerups;
#using scripts/zm/_zm_spawner;
#using scripts/zm/_zm_unitrigger;
#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_weap_cymbal_monkey;
#using scripts/zm/_zm_weap_dragon_gauntlet;
#using scripts/zm/_zm_weapons;
#using scripts/zm/zm_stalingrad_vo;

#namespace zm_stalingrad_challenges;

// Namespace zm_stalingrad_challenges
// Params 0, eflags: 0x2
// Checksum 0x452f4c65, Offset: 0xef8
// Size: 0x3c
function autoexec __init__sytem__() {
    system::register("zm_stalingrad_challenges", &__init__, &__main__, undefined);
}

// Namespace zm_stalingrad_challenges
// Params 0, eflags: 0x0
// Checksum 0x36445926, Offset: 0xf40
// Size: 0x224
function __init__() {
    clientfield::register("toplayer", "challenge_grave_fire", 12000, 2, "int");
    clientfield::register("scriptmover", "challenge_arm_reveal", 12000, 1, "counter");
    clientfield::register("toplayer", "pr_b", 12000, 3, "int");
    clientfield::register("toplayer", "pr_c", 12000, 3, "int");
    clientfield::register("toplayer", "pr_l_c", 12000, 1, "int");
    clientfield::register("missile", "pr_gm_e_fx", 12000, 1, "int");
    clientfield::register("scriptmover", "pr_g_c_fx", 12000, 1, "int");
    clientfield::register("toplayer", "challenge1state", 14000, 2, "int");
    clientfield::register("toplayer", "challenge2state", 14000, 2, "int");
    clientfield::register("toplayer", "challenge3state", 14000, 2, "int");
    level flag::init("pr_m");
    level flag::init("dragon_gauntlet_acquired");
}

// Namespace zm_stalingrad_challenges
// Params 0, eflags: 0x0
// Checksum 0xd9f85152, Offset: 0x1170
// Size: 0x72c
function __main__() {
    level._challenges = spawnstruct();
    level._challenges.var_4687355c = [];
    level._challenges.var_b88ea497 = [];
    level._challenges.var_928c2a2e = [];
    level thread function_b2413e04();
    array::add(level._challenges.var_4687355c, function_970609e0(1, %ZM_STALINGRAD_CHALLENGE_1_1, 10, "update_challenge_1_1", &function_960bfb56));
    array::add(level._challenges.var_4687355c, function_970609e0(1, %ZM_STALINGRAD_CHALLENGE_1_2, 3, "update_challenge_1_2", &function_f1c59ae));
    array::add(level._challenges.var_4687355c, function_970609e0(1, %ZM_STALINGRAD_CHALLENGE_1_3, 5, "update_challenge_1_3", &function_76bcffc2));
    array::add(level._challenges.var_4687355c, function_970609e0(1, %ZM_STALINGRAD_CHALLENGE_1_4, 3, "update_challenge_1_4", &function_dec401c2));
    array::add(level._challenges.var_4687355c, function_970609e0(1, %ZM_STALINGRAD_CHALLENGE_1_5, 5, "update_challenge_1_5", &function_c169b7dd));
    array::add(level._challenges.var_4687355c, function_970609e0(1, %ZM_STALINGRAD_CHALLENGE_1_6, 1, "update_challenge_1_6", &function_5efd7abf));
    array::add(level._challenges.var_b88ea497, function_970609e0(2, %ZM_STALINGRAD_CHALLENGE_2_1, 10, "update_challenge_2_1", &function_4322fb5f));
    array::add(level._challenges.var_b88ea497, function_970609e0(2, %ZM_STALINGRAD_CHALLENGE_2_2, 30, "update_challenge_2_2", &function_f427e9ad));
    array::add(level._challenges.var_b88ea497, function_970609e0(2, %ZM_STALINGRAD_CHALLENGE_2_3, 40, "update_challenge_2_3", &function_4e107409));
    array::add(level._challenges.var_b88ea497, function_970609e0(2, %ZM_STALINGRAD_CHALLENGE_2_4, 45, "update_challenge_2_4", &function_81adc498));
    array::add(level._challenges.var_b88ea497, function_970609e0(2, %ZM_STALINGRAD_CHALLENGE_2_5, 10, "update_challenge_2_5", &function_64e8cc03));
    array::add(level._challenges.var_b88ea497, function_970609e0(2, %ZM_STALINGRAD_CHALLENGE_2_6, 1, "update_challenge_2_6", &function_31d5f655));
    array::add(level._challenges.var_928c2a2e, function_970609e0(3, %ZM_STALINGRAD_CHALLENGE_3_1, 1, "update_challenge_3_1", &function_75fdfc25));
    array::add(level._challenges.var_928c2a2e, function_970609e0(3, %ZM_STALINGRAD_CHALLENGE_3_2, 3, "update_challenge_3_2", &function_2bf9f9d4));
    array::add(level._challenges.var_928c2a2e, function_970609e0(3, %ZM_STALINGRAD_CHALLENGE_3_3, 100, "update_challenge_3_3", &function_dcbd7aec));
    array::add(level._challenges.var_928c2a2e, function_970609e0(3, %ZM_STALINGRAD_CHALLENGE_3_4, 60, "update_challenge_3_4", &function_3d0619b6));
    array::add(level._challenges.var_928c2a2e, function_970609e0(3, %ZM_STALINGRAD_CHALLENGE_3_5, 6, "update_challenge_3_5", &function_cdeaa5f));
    array::add(level._challenges.var_928c2a2e, function_970609e0(3, %ZM_STALINGRAD_CHALLENGE_3_6, 6, "update_challenge_3_6", &function_e480fc42));
    callback::on_connect(&on_player_connect);
    callback::on_disconnect(&on_player_disconnect);
    callback::on_spawned(&on_player_spawned);
    level.get_player_perk_purchase_limit = &function_1adeaa1c;
    /#
        function_b9b4ce34();
    #/
}

// Namespace zm_stalingrad_challenges
// Params 5, eflags: 0x0
// Checksum 0x78e6c79f, Offset: 0x18a8
// Size: 0xc8
function function_970609e0(n_challenge_index, var_3e1001b, var_80792f67, var_52b8c4f8, var_d675d6d8) {
    if (!isdefined(var_d675d6d8)) {
        var_d675d6d8 = undefined;
    }
    s_challenge = spawnstruct();
    s_challenge.n_index = n_challenge_index;
    s_challenge.str_info = var_3e1001b;
    s_challenge.n_count = var_80792f67;
    s_challenge.str_notify = var_52b8c4f8;
    s_challenge.func_think = var_d675d6d8;
    return s_challenge;
}

// Namespace zm_stalingrad_challenges
// Params 0, eflags: 0x0
// Checksum 0xba9e2a6a, Offset: 0x1978
// Size: 0x34
function on_player_connect() {
    self thread function_b7156b15();
    self thread function_4ca86c86();
}

// Namespace zm_stalingrad_challenges
// Params 0, eflags: 0x0
// Checksum 0x4385bbaf, Offset: 0x19b8
// Size: 0x4c
function on_player_spawned() {
    self thread function_914c6e38();
    self thread function_99985d03();
    self thread function_be89247c();
}

// Namespace zm_stalingrad_challenges
// Params 0, eflags: 0x0
// Checksum 0xdd170003, Offset: 0x1a10
// Size: 0x24c
function on_player_disconnect() {
    if (!isdefined(level._challenges.var_4687355c)) {
        level._challenges.var_4687355c = [];
    } else if (!isarray(level._challenges.var_4687355c)) {
        level._challenges.var_4687355c = array(level._challenges.var_4687355c);
    }
    level._challenges.var_4687355c[level._challenges.var_4687355c.size] = self._challenges.var_4687355c;
    if (!isdefined(level._challenges.var_b88ea497)) {
        level._challenges.var_b88ea497 = [];
    } else if (!isarray(level._challenges.var_b88ea497)) {
        level._challenges.var_b88ea497 = array(level._challenges.var_b88ea497);
    }
    level._challenges.var_b88ea497[level._challenges.var_b88ea497.size] = self._challenges.var_b88ea497;
    if (!isdefined(level._challenges.var_928c2a2e)) {
        level._challenges.var_928c2a2e = [];
    } else if (!isarray(level._challenges.var_928c2a2e)) {
        level._challenges.var_928c2a2e = array(level._challenges.var_928c2a2e);
    }
    level._challenges.var_928c2a2e[level._challenges.var_928c2a2e.size] = self._challenges.var_928c2a2e;
    var_8c78610d = self getentitynumber();
    level notify("player_disconnected_" + var_8c78610d);
}

// Namespace zm_stalingrad_challenges
// Params 0, eflags: 0x0
// Checksum 0x1b8bdcb0, Offset: 0x1c68
// Size: 0x596
function function_b7156b15() {
    self endon(#"disconnect");
    self flag::init("flag_player_collected_reward_1");
    self flag::init("flag_player_collected_reward_2");
    self flag::init("flag_player_collected_reward_3");
    self flag::init("flag_player_collected_reward_4");
    self flag::init("flag_player_collected_reward_5");
    self flag::init("flag_player_completed_challenge_1");
    self flag::init("flag_player_completed_challenge_2");
    self flag::init("flag_player_completed_challenge_3");
    self flag::init("flag_player_completed_challenge_4");
    if (level flag::get("gauntlet_quest_complete")) {
        self flag::set("flag_player_completed_challenge_4");
    }
    self flag::init("flag_player_initialized_reward");
    level flag::wait_till("initial_players_connected");
    self._challenges = spawnstruct();
    self._challenges.var_4687355c = array::random(level._challenges.var_4687355c);
    self._challenges.var_b88ea497 = array::random(level._challenges.var_b88ea497);
    do {
        self._challenges.var_928c2a2e = array::random(level._challenges.var_928c2a2e);
    } while (level flag::get("solo_game") && level.players.size == 1 && self._challenges.var_928c2a2e.str_notify == "update_challenge_3_4");
    arrayremovevalue(level._challenges.var_4687355c, self._challenges.var_4687355c);
    arrayremovevalue(level._challenges.var_b88ea497, self._challenges.var_b88ea497);
    arrayremovevalue(level._challenges.var_928c2a2e, self._challenges.var_928c2a2e);
    self thread function_2ce855f3(self._challenges.var_4687355c);
    self thread function_2ce855f3(self._challenges.var_b88ea497);
    self thread function_2ce855f3(self._challenges.var_928c2a2e);
    self thread function_fbbc8608(self._challenges.var_4687355c.n_index, "flag_player_completed_challenge_1");
    self thread function_fbbc8608(self._challenges.var_b88ea497.n_index, "flag_player_completed_challenge_2");
    self thread function_fbbc8608(self._challenges.var_928c2a2e.n_index, "flag_player_completed_challenge_3");
    self thread function_974d5f1d();
    var_8c78610d = self getentitynumber();
    for (i = 1; i <= 4; i++) {
        self thread function_a2d25f82(i);
    }
    foreach (s_challenge in struct::get_array("s_challenge_trigger")) {
        if (s_challenge.script_int == var_8c78610d) {
            s_challenge function_4e61a018();
            break;
        }
    }
}

// Namespace zm_stalingrad_challenges
// Params 0, eflags: 0x0
// Checksum 0x59de798c, Offset: 0x2208
// Size: 0x34
function function_914c6e38() {
    self clientfield::set_to_player("challenge_grave_fire", self getentitynumber());
}

// Namespace zm_stalingrad_challenges
// Params 0, eflags: 0x0
// Checksum 0x8362826b, Offset: 0x2248
// Size: 0x24
function function_99985d03() {
    self flag::clear("flag_player_collected_reward_" + 4);
}

// Namespace zm_stalingrad_challenges
// Params 0, eflags: 0x0
// Checksum 0xf0648905, Offset: 0x2278
// Size: 0x32c
function function_4e61a018() {
    self zm_unitrigger::create_unitrigger("", -128, &function_3ae0d6d5);
    self.s_unitrigger.require_look_at = 0;
    self.s_unitrigger.inactive_reassess_time = 0.1;
    zm_unitrigger::unitrigger_force_per_player_triggers(self.s_unitrigger, 1);
    self.var_b2a5207f = getent("challenge_gravestone_" + self.script_int, "targetname");
    self.var_407ba908 = [];
    if (!isdefined(self.var_407ba908)) {
        self.var_407ba908 = [];
    } else if (!isarray(self.var_407ba908)) {
        self.var_407ba908 = array(self.var_407ba908);
    }
    self.var_407ba908[self.var_407ba908.size] = "ar_famas_upgraded";
    if (!isdefined(self.var_407ba908)) {
        self.var_407ba908 = [];
    } else if (!isarray(self.var_407ba908)) {
        self.var_407ba908 = array(self.var_407ba908);
    }
    self.var_407ba908[self.var_407ba908.size] = "ar_garand_upgraded";
    if (!isdefined(self.var_407ba908)) {
        self.var_407ba908 = [];
    } else if (!isarray(self.var_407ba908)) {
        self.var_407ba908 = array(self.var_407ba908);
    }
    self.var_407ba908[self.var_407ba908.size] = "smg_mp40_upgraded";
    if (!isdefined(self.var_407ba908)) {
        self.var_407ba908 = [];
    } else if (!isarray(self.var_407ba908)) {
        self.var_407ba908 = array(self.var_407ba908);
    }
    self.var_407ba908[self.var_407ba908.size] = "special_crossbow_dw_upgraded";
    if (!isdefined(self.var_407ba908)) {
        self.var_407ba908 = [];
    } else if (!isarray(self.var_407ba908)) {
        self.var_407ba908 = array(self.var_407ba908);
    }
    self.var_407ba908[self.var_407ba908.size] = "launcher_multi_upgraded";
    self.var_407ba908 = array::randomize(self.var_407ba908);
    self.var_d86e8be = 0;
    self thread function_424b6fe8();
}

// Namespace zm_stalingrad_challenges
// Params 2, eflags: 0x0
// Checksum 0xa64dd254, Offset: 0x25b0
// Size: 0x11c
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
    self luinotifyevent(%trial_complete, 3, %ZM_STALINGRAD_CHALLENGE_COMPLETE, var_d6b47fd3, n_challenge_index - 1);
    level scoreevents::processscoreevent("solo_challenge_stalingrad", self);
}

// Namespace zm_stalingrad_challenges
// Params 1, eflags: 0x0
// Checksum 0x4385644c, Offset: 0x26d8
// Size: 0x54
function function_e8547a5b(var_cc0f18cc) {
    if (self.challenge_text !== var_cc0f18cc) {
        self.challenge_text = var_cc0f18cc;
        self luinotifyevent(%trial_set_description, 1, self.challenge_text);
    }
}

// Namespace zm_stalingrad_challenges
// Params 2, eflags: 0x0
// Checksum 0x3658e796, Offset: 0x2738
// Size: 0x11a
function function_27f6c3cd(player, n_challenge_index) {
    switch (n_challenge_index) {
    case 1:
        player function_e8547a5b(player._challenges.var_4687355c.str_info);
        break;
    case 2:
        player function_e8547a5b(player._challenges.var_b88ea497.str_info);
        break;
    case 3:
        player function_e8547a5b(player._challenges.var_928c2a2e.str_info);
        break;
    case 4:
        player function_e8547a5b(player function_a107e8a5());
        break;
    }
}

// Namespace zm_stalingrad_challenges
// Params 2, eflags: 0x0
// Checksum 0x65812c9a, Offset: 0x2860
// Size: 0x44
function function_33e91747(n_challenge_index, var_fe2fb4b9) {
    self clientfield::set_to_player("challenge" + n_challenge_index + "state", var_fe2fb4b9);
}

// Namespace zm_stalingrad_challenges
// Params 1, eflags: 0x0
// Checksum 0xc8f45806, Offset: 0x28b0
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

// Namespace zm_stalingrad_challenges
// Params 1, eflags: 0x0
// Checksum 0xbfdad4ba, Offset: 0x2978
// Size: 0x5e0
function function_3ae0d6d5(e_player) {
    if (self.stub.related_parent.script_int == e_player getentitynumber()) {
        if (e_player flag::get("flag_player_initialized_reward")) {
            self sethintstringforplayer(e_player, %ZM_STALINGRAD_CHALLENGE_REWARD_TAKE);
            if (self.stub.related_parent.mdl_reward.n_challenge == 2) {
                w_current = e_player getcurrentweapon();
                if (isdefined(w_current.isgadget) && (isdefined(w_current.isheroweapon) && (zm_utility::is_placeable_mine(w_current) || zm_equipment::is_equipment(w_current) || w_current == level.weaponnone || w_current.isheroweapon) || w_current.isgadget)) {
                    self sethintstringforplayer(e_player, "");
                    return 0;
                }
            } else if (self.stub.related_parent.mdl_reward.n_challenge == 3) {
                a_perks = e_player getperks();
                if (a_perks.size == level._custom_perks.size) {
                    self sethintstringforplayer(e_player, "");
                    return 0;
                }
            }
            return 1;
        }
        for (i = 1; i <= 4; i++) {
            var_18c0ce2f = self.stub.related_parent.var_b2a5207f gettagorigin("tag_0" + i);
            if (e_player function_3f67a723(var_18c0ce2f, 15, 0) && distance(e_player.origin, self.stub.origin) < 500) {
                self function_27f6c3cd(e_player, i);
                e_player clientfield::set_player_uimodel("trialWidget.icon", i - 1);
                e_player clientfield::set_player_uimodel("trialWidget.visible", 1);
                if (i == 4) {
                    e_player clientfield::set_player_uimodel("trialWidget.progress", e_player clientfield::get_player_uimodel("zmInventory.progress_egg"));
                } else {
                    e_player clientfield::set_player_uimodel("trialWidget.progress", e_player.var_873a3e27[i]);
                }
                if (!e_player flag::get("flag_player_completed_challenge_" + i)) {
                    self sethintstringforplayer(e_player, "");
                    e_player thread function_23c9ffd3(self);
                    var_a51a0ba6 = 1;
                    return 1;
                }
                if (!e_player flag::get("flag_player_collected_reward_" + i) && !(isdefined(e_player.var_c981566c) && e_player.var_c981566c)) {
                    self sethintstringforplayer(e_player, %ZM_STALINGRAD_CHALLENGE_REWARD);
                    e_player thread function_23c9ffd3(self);
                    var_a51a0ba6 = 1;
                    return 1;
                }
                self sethintstringforplayer(e_player, "");
                e_player thread function_23c9ffd3(self);
                var_a51a0ba6 = 1;
                return 1;
            }
        }
        if (e_player function_9ffe5c12()) {
            self sethintstringforplayer(e_player, %ZM_STALINGRAD_GRAVE_FIRE);
            e_player clientfield::set_player_uimodel("trialWidget.visible", 0);
            return 1;
        }
        self sethintstringforplayer(e_player, "");
        e_player clientfield::set_player_uimodel("trialWidget.visible", 0);
        return 0;
    }
    self sethintstringforplayer(e_player, "");
    return 0;
}

// Namespace zm_stalingrad_challenges
// Params 4, eflags: 0x0
// Checksum 0x333855ab, Offset: 0x2f60
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

// Namespace zm_stalingrad_challenges
// Params 0, eflags: 0x0
// Checksum 0x81cb2a98, Offset: 0x3020
// Size: 0x490
function function_424b6fe8() {
    while (true) {
        self waittill(#"trigger_activated", e_who);
        if (self.script_int == e_who getentitynumber()) {
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
                e_who clientfield::increment_to_player("interact_rumble");
                self.s_unitrigger.playertrigger[e_who.entity_num] sethintstringforplayer(e_who, "");
                e_who player_give_reward(self.mdl_reward);
                if (isdefined(self.mdl_reward)) {
                    self.mdl_reward delete();
                }
                continue;
            }
            for (i = 1; i <= 4; i++) {
                var_18c0ce2f = self.var_b2a5207f gettagorigin("tag_0" + i);
                if (e_who function_3f67a723(var_18c0ce2f, 15, 0) && distance(e_who.origin, self.origin) < 500) {
                    if (isdefined(e_who.var_c981566c) && e_who.var_c981566c) {
                        break;
                    }
                    if (e_who flag::get("flag_player_completed_challenge_" + i) && !e_who flag::get("flag_player_collected_reward_" + i)) {
                        e_who clientfield::increment_to_player("interact_rumble");
                        self.s_unitrigger.playertrigger[e_who.entity_num] sethintstringforplayer(e_who, "");
                        self function_1d22626(e_who, i);
                        break;
                    }
                }
            }
            if (e_who function_9ffe5c12()) {
                self.s_unitrigger.playertrigger[e_who.entity_num] sethintstringforplayer(e_who, "");
                self function_1d22626(e_who, 5);
                e_who thread function_a231bc42();
            }
        }
    }
}

// Namespace zm_stalingrad_challenges
// Params 1, eflags: 0x0
// Checksum 0x363eeb63, Offset: 0x34b8
// Size: 0x5c
function function_a2d25f82(n_challenge) {
    self endon(#"disconnect");
    /#
        self endon(#"hash_f9ff0ae7");
    #/
    self flag::wait_till("flag_player_completed_challenge_" + n_challenge);
    self thread zm_stalingrad_vo::function_73928e79();
}

// Namespace zm_stalingrad_challenges
// Params 2, eflags: 0x0
// Checksum 0x5147850e, Offset: 0x3520
// Size: 0x40c
function function_1d22626(e_player, n_challenge) {
    e_player endon(#"disconnect");
    var_7bb343ef = (0, 90, 0);
    a_s_rewards = struct::get_array("s_challenge_reward", "targetname");
    foreach (s_reward in a_s_rewards) {
        if (s_reward.script_int == e_player getentitynumber()) {
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
        var_17b3dc96 = self.var_407ba908[self.var_d86e8be];
        if (self.var_d86e8be == self.var_407ba908.size - 1) {
            self.var_d86e8be = 0;
        } else {
            self.var_d86e8be++;
        }
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
    case 4:
        var_17b3dc96 = "wpn_t7_zmb_dlc3_gauntlet_dragon_world";
        s_reward.var_e1513629 = (2, 0, 0);
        s_reward.var_b90d551 = (-100, 0, 0);
        break;
    case 5:
        var_17b3dc96 = "wpn_t7_zmb_monkey_bomb_world";
        s_reward.var_e1513629 = (0, 0, 1);
        s_reward.var_b90d551 = var_7bb343ef;
        break;
    }
    e_player.var_c981566c = 1;
    self function_b1f54cb4(e_player, s_reward, var_17b3dc96, 30);
    self.mdl_reward clientfield::set("powerup_fx", 1);
    self.mdl_reward.n_challenge = n_challenge;
    e_player flag::set("flag_player_initialized_reward");
    self thread function_1ad9d1a0(e_player, 30 * -1);
}

// Namespace zm_stalingrad_challenges
// Params 2, eflags: 0x0
// Checksum 0x80bcb26c, Offset: 0x3938
// Size: 0x19c
function function_1ad9d1a0(e_player, n_dist) {
    self endon(#"hash_422dba45");
    self.mdl_hand movez(n_dist, 12, 6);
    self.var_2a9b65c7 movez(n_dist, 12, 6);
    self.var_79dc7980 movez(n_dist, 12, 6);
    self.mdl_reward movez(n_dist, 12, 6);
    self.mdl_hand playloopsound("zmb_challenge_skel_arm_lp", 1);
    self.mdl_hand waittill(#"movedone");
    if (isdefined(e_player)) {
        e_player flag::clear("flag_player_initialized_reward");
        e_player.var_c981566c = undefined;
    }
    if (isdefined(self.mdl_reward)) {
        self.mdl_reward delete();
    }
    self.mdl_hand delete();
    self.var_2a9b65c7 delete();
    self.var_79dc7980 delete();
}

// Namespace zm_stalingrad_challenges
// Params 4, eflags: 0x0
// Checksum 0xa49ce649, Offset: 0x3ae0
// Size: 0x534
function function_b1f54cb4(e_player, s_reward, var_17b3dc96, var_21d0cf95) {
    var_f6c28cea = (2, 0, -6.5);
    var_e97ebb83 = (3.5, 0, -18.5);
    var_f39a667b = (1, 0, -1);
    var_48cc013c = (90, 0, 0);
    if (!isdefined(self.mdl_hand)) {
        self.mdl_hand = util::spawn_model("c_zom_dlc1_skeleton_zombie_body_s_rarm", s_reward.origin, s_reward.angles);
        self.var_2a9b65c7 = util::spawn_model("p7_skulls_bones_arm_lower", s_reward.origin + var_f6c28cea, (180, 0, 0));
        self.var_79dc7980 = util::spawn_model("p7_skulls_bones_arm_lower", s_reward.origin + var_e97ebb83, (180, 0, 0));
    } else {
        self notify(#"hash_422dba45");
        self.mdl_hand stoploopsound(0.25);
        self.mdl_hand moveto(s_reward.origin, 1);
        self.var_2a9b65c7 moveto(s_reward.origin + var_f6c28cea, 1);
        self.var_79dc7980 moveto(s_reward.origin + var_e97ebb83, 1);
        self.mdl_hand waittill(#"movedone");
        if (isdefined(self.mdl_hand.var_9cab68e0) && self.mdl_hand.var_9cab68e0) {
            self.mdl_hand.origin -= var_f39a667b;
            self.mdl_hand.angles -= var_48cc013c;
            self.mdl_hand.var_9cab68e0 = undefined;
        }
    }
    var_51a2f105 = s_reward.origin + s_reward.var_e1513629;
    v_spawn_angles = s_reward.angles + s_reward.var_b90d551;
    switch (var_17b3dc96) {
    case "ar_famas_upgraded":
    case "ar_garand_upgraded":
    case "launcher_multi_upgraded":
    case "smg_mp40_upgraded":
    case "special_crossbow_dw_upgraded":
        self.mdl_reward = zm_utility::spawn_buildkit_weapon_model(e_player, getweapon(var_17b3dc96), undefined, var_51a2f105, v_spawn_angles);
        self.mdl_reward.str_weapon_name = var_17b3dc96;
        break;
    case "wpn_t7_zmb_dlc3_gauntlet_dragon_world":
        self.mdl_reward = util::spawn_model(var_17b3dc96, var_51a2f105, v_spawn_angles);
        self.mdl_hand.origin += var_f39a667b;
        self.mdl_hand.angles += var_48cc013c;
        self.mdl_hand.var_9cab68e0 = 1;
        break;
    default:
        self.mdl_reward = util::spawn_model(var_17b3dc96, var_51a2f105, v_spawn_angles);
        break;
    }
    self.mdl_hand movez(var_21d0cf95, 1);
    self.var_2a9b65c7 movez(var_21d0cf95, 1);
    self.var_79dc7980 movez(var_21d0cf95, 1);
    self.mdl_reward movez(var_21d0cf95, 1);
    self.mdl_hand playsound("zmb_challenge_skel_arm_up");
    wait 0.05;
    self.mdl_hand clientfield::increment("challenge_arm_reveal");
    self.mdl_hand waittill(#"movedone");
    self.mdl_hand clientfield::increment("challenge_arm_reveal");
}

// Namespace zm_stalingrad_challenges
// Params 1, eflags: 0x0
// Checksum 0x3ff0c747, Offset: 0x4020
// Size: 0x1e6
function player_give_reward(mdl_reward) {
    switch (mdl_reward.n_challenge) {
    case 1:
        level thread zm_powerups::specific_powerup_drop("full_ammo", self.origin);
        break;
    case 2:
        if (isdefined(mdl_reward.str_weapon_name)) {
            w_reward = getweapon(mdl_reward.str_weapon_name);
        }
        self thread swap_weapon(w_reward);
        break;
    case 3:
        self thread function_6131520e();
        break;
    case 4:
        self zm_weap_dragon_gauntlet::function_99a68dd();
        self notify(#"hash_4e21f047");
        level flag::set("dragon_gauntlet_acquired");
        break;
    case 5:
        self function_c46e4bfe();
        break;
    }
    self flag::set("flag_player_collected_reward_" + mdl_reward.n_challenge);
    if (mdl_reward.n_challenge > 0 && mdl_reward.n_challenge < 4) {
        self function_33e91747(mdl_reward.n_challenge, 2);
    }
    self flag::clear("flag_player_initialized_reward");
    self.var_c981566c = undefined;
}

// Namespace zm_stalingrad_challenges
// Params 1, eflags: 0x0
// Checksum 0x72a6b64b, Offset: 0x4210
// Size: 0x104
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
        self function_dcfc8bde(w_current, w_new);
        return;
    }
    self givemaxammo(w_new);
}

// Namespace zm_stalingrad_challenges
// Params 2, eflags: 0x0
// Checksum 0x119ed20c, Offset: 0x4320
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

// Namespace zm_stalingrad_challenges
// Params 1, eflags: 0x0
// Checksum 0x4f007cce, Offset: 0x4400
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

// Namespace zm_stalingrad_challenges
// Params 0, eflags: 0x0
// Checksum 0x74032b5d, Offset: 0x4520
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

// Namespace zm_stalingrad_challenges
// Params 0, eflags: 0x0
// Checksum 0xbc8e04bc, Offset: 0x4620
// Size: 0x40
function function_1adeaa1c() {
    var_4562cc04 = level.perk_purchase_limit;
    if (self flag::get("flag_player_collected_reward_3")) {
        var_4562cc04++;
    }
    return var_4562cc04;
}

// Namespace zm_stalingrad_challenges
// Params 0, eflags: 0x0
// Checksum 0x9f6413c6, Offset: 0x4668
// Size: 0xfc
function function_a107e8a5() {
    if (level flag::get("gauntlet_step_4_complete")) {
        return %ZM_STALINGRAD_CHALLENGE_4_6;
    }
    if (level flag::get("gauntlet_step_3_complete")) {
        return %ZM_STALINGRAD_CHALLENGE_4_5;
    }
    if (level flag::get("gauntlet_step_2_complete")) {
        return %ZM_STALINGRAD_CHALLENGE_4_4;
    }
    if (level flag::get("egg_awakened")) {
        return %ZM_STALINGRAD_CHALLENGE_4_3;
    }
    if (level flag::get("dragon_egg_acquired")) {
        return %ZM_STALINGRAD_CHALLENGE_4_2;
    }
    return %ZM_STALINGRAD_CHALLENGE_4_1;
}

// Namespace zm_stalingrad_challenges
// Params 0, eflags: 0x0
// Checksum 0xf645fc5d, Offset: 0x4770
// Size: 0x9e
function function_960bfb56() {
    self endon(#"disconnect");
    level.var_940aa0f3 = self;
    zm_spawner::register_zombie_death_event_callback(&function_f08cb3ce);
    self thread function_e425ba86();
    self flag::wait_till("flag_player_completed_challenge_1");
    zm_spawner::deregister_zombie_death_event_callback(&function_f08cb3ce);
    level.var_940aa0f3 = undefined;
}

// Namespace zm_stalingrad_challenges
// Params 1, eflags: 0x0
// Checksum 0x200bfe8d, Offset: 0x4818
// Size: 0x74
function function_f08cb3ce(e_attacker) {
    if (isdefined(self) && self.var_9a02a614 === "napalm" && e_attacker === level.var_940aa0f3) {
        if (zm_utility::is_headshot(self.damageweapon, self.damagelocation, self.damagemod)) {
            e_attacker notify(#"update_challenge_1_1");
        }
    }
}

// Namespace zm_stalingrad_challenges
// Params 0, eflags: 0x0
// Checksum 0x8f7e3d21, Offset: 0x4898
// Size: 0x46
function function_e425ba86() {
    self endon(#"flag_player_completed_challenge_1");
    self waittill(#"disconnect");
    zm_spawner::deregister_zombie_death_event_callback(&function_f08cb3ce);
    level.var_940aa0f3 = undefined;
}

// Namespace zm_stalingrad_challenges
// Params 0, eflags: 0x0
// Checksum 0x120b95b1, Offset: 0x48e8
// Size: 0x96
function function_f1c59ae() {
    self endon(#"disconnect");
    self.var_c678bf7b = [];
    while (self.var_c678bf7b.size < 3) {
        self waittill(#"hash_2e47bc4a");
        if (!array::contains(self.var_c678bf7b, level.var_9d19c7e)) {
            array::add(self.var_c678bf7b, level.var_9d19c7e);
            self notify(#"update_challenge_1_2");
        }
    }
    self.var_c678bf7b = undefined;
}

// Namespace zm_stalingrad_challenges
// Params 0, eflags: 0x0
// Checksum 0x5e9966bd, Offset: 0x4988
// Size: 0x5a
function function_76bcffc2() {
    self endon(#"flag_player_completed_challenge_1");
    self endon(#"disconnect");
    while (true) {
        level waittill(#"hash_826c20b", e_attacker);
        if (e_attacker === self) {
            self notify(#"update_challenge_1_3");
        }
    }
}

// Namespace zm_stalingrad_challenges
// Params 0, eflags: 0x0
// Checksum 0xeb58f5bd, Offset: 0x49f0
// Size: 0x4e
function function_dec401c2() {
    self endon(#"disconnect");
    while (!self flag::get("flag_player_completed_challenge_1")) {
        self waittill(#"hash_2d087eca");
        self notify(#"update_challenge_1_4");
    }
}

// Namespace zm_stalingrad_challenges
// Params 0, eflags: 0x0
// Checksum 0xebb3e984, Offset: 0x4a48
// Size: 0x5a
function function_c169b7dd() {
    self endon(#"flag_player_completed_challenge_1");
    self endon(#"disconnect");
    while (true) {
        level waittill(#"hash_4de460e7", e_attacker);
        if (e_attacker === self) {
            self notify(#"update_challenge_1_5");
        }
    }
}

// Namespace zm_stalingrad_challenges
// Params 0, eflags: 0x0
// Checksum 0xf5875c33, Offset: 0x4ab0
// Size: 0x48
function function_5efd7abf() {
    self endon(#"disconnect");
    self endon(#"flag_player_completed_challenge_1");
    while (true) {
        self waittill(#"hash_690aad79");
        self thread function_8494f9a2();
    }
}

// Namespace zm_stalingrad_challenges
// Params 0, eflags: 0x0
// Checksum 0x969cbb69, Offset: 0x4b00
// Size: 0x46
function function_8494f9a2() {
    self endon(#"player_downed");
    self endon(#"disconnect");
    self notify(#"hash_2dcfeeb9");
    self endon(#"hash_2dcfeeb9");
    wait 5;
    self notify(#"update_challenge_1_6");
}

// Namespace zm_stalingrad_challenges
// Params 0, eflags: 0x0
// Checksum 0xf4d37753, Offset: 0x4b50
// Size: 0x11e
function function_4322fb5f() {
    self endon(#"disconnect");
    var_d0e8cd34 = getent("finger_trap_slide_trigger", "targetname");
    level.var_7ee8825e = self;
    while (!self flag::get("flag_player_completed_challenge_2")) {
        self waittill(#"hash_ad9aba38");
        while (level flag::get("finger_trap_on") && !self flag::get("flag_player_completed_challenge_2")) {
            var_d0e8cd34 waittill(#"trigger", e_who);
            if (e_who === self && self issliding()) {
                self function_2e7f6910();
            }
        }
    }
    level.var_7ee8825e = undefined;
}

// Namespace zm_stalingrad_challenges
// Params 0, eflags: 0x0
// Checksum 0xb7ce5d66, Offset: 0x4c78
// Size: 0x8e
function function_2e7f6910() {
    self endon(#"disconnect");
    self endon(#"stop_slide_kill_watcher");
    var_ac9fe035 = 3;
    self util::delay_notify(var_ac9fe035, "stop_slide_kill_watcher");
    while (!self flag::get("flag_player_completed_challenge_2")) {
        self waittill(#"hash_2637f64f");
        self notify(#"update_challenge_2_1");
    }
}

// Namespace zm_stalingrad_challenges
// Params 0, eflags: 0x0
// Checksum 0x129355b, Offset: 0x4d10
// Size: 0x9e
function function_f427e9ad() {
    self endon(#"disconnect");
    level.var_7d70299a = self;
    zm_spawner::register_zombie_death_event_callback(&function_9903d501);
    self thread function_b44b0c5d();
    self flag::wait_till("flag_player_completed_challenge_2");
    zm_spawner::deregister_zombie_death_event_callback(&function_9903d501);
    level.var_7d70299a = undefined;
}

// Namespace zm_stalingrad_challenges
// Params 1, eflags: 0x0
// Checksum 0x9fc308ed, Offset: 0x4db8
// Size: 0x58
function function_9903d501(e_attacker) {
    if (isdefined(self) && self.damageweapon === getweapon("dragonshield") && e_attacker === level.var_7d70299a) {
        e_attacker notify(#"update_challenge_2_2");
    }
}

// Namespace zm_stalingrad_challenges
// Params 0, eflags: 0x0
// Checksum 0x21f56ca1, Offset: 0x4e18
// Size: 0x46
function function_b44b0c5d() {
    self endon(#"flag_player_completed_challenge_2");
    self waittill(#"disconnect");
    zm_spawner::deregister_zombie_death_event_callback(&function_9903d501);
    level.var_7d70299a = undefined;
}

// Namespace zm_stalingrad_challenges
// Params 0, eflags: 0x0
// Checksum 0xd35ee8c0, Offset: 0x4e68
// Size: 0x42
function function_4e107409() {
    self endon(#"flag_player_completed_challenge_2");
    self endon(#"disconnect");
    while (true) {
        self waittill(#"hash_696f953");
        self notify(#"update_challenge_2_3");
    }
}

// Namespace zm_stalingrad_challenges
// Params 0, eflags: 0x0
// Checksum 0x27c345a4, Offset: 0x4eb8
// Size: 0x5e
function function_81adc498() {
    self endon(#"disconnect");
    self.var_e34aa037 = 0;
    while (!self flag::get("flag_player_completed_challenge_2")) {
        self waittill(#"hash_3d742bf8");
        self notify(#"update_challenge_2_4");
    }
    self.var_e34aa037 = undefined;
}

// Namespace zm_stalingrad_challenges
// Params 0, eflags: 0x0
// Checksum 0xccae5b97, Offset: 0x4f20
// Size: 0x9e
function function_64e8cc03() {
    self endon(#"disconnect");
    level.var_33f7b0fc = self;
    zm_spawner::register_zombie_death_event_callback(&function_f99f9ce7);
    self thread function_f65cfb93();
    self flag::wait_till("flag_player_completed_challenge_2");
    zm_spawner::deregister_zombie_death_event_callback(&function_f99f9ce7);
    level.var_33f7b0fc = undefined;
}

// Namespace zm_stalingrad_challenges
// Params 1, eflags: 0x0
// Checksum 0x469379bf, Offset: 0x4fc8
// Size: 0x74
function function_f99f9ce7(e_attacker) {
    if (isdefined(self) && self.var_9a02a614 === "sparky" && e_attacker === level.var_33f7b0fc) {
        if (zm_utility::is_headshot(self.damageweapon, self.damagelocation, self.damagemod)) {
            e_attacker notify(#"update_challenge_2_5");
        }
    }
}

// Namespace zm_stalingrad_challenges
// Params 0, eflags: 0x0
// Checksum 0x6eb08877, Offset: 0x5048
// Size: 0x46
function function_f65cfb93() {
    self endon(#"flag_player_completed_challenge_2");
    self waittill(#"disconnect");
    zm_spawner::deregister_zombie_death_event_callback(&function_f99f9ce7);
    level.var_33f7b0fc = undefined;
}

// Namespace zm_stalingrad_challenges
// Params 0, eflags: 0x0
// Checksum 0xea39d80b, Offset: 0x5098
// Size: 0x5a
function function_31d5f655() {
    self endon(#"flag_player_completed_challenge_2");
    self endon(#"disconnect");
    while (true) {
        self waittill(#"hash_f7608efe", n_kill_count);
        if (n_kill_count >= 8) {
            self notify(#"update_challenge_2_6");
        }
    }
}

// Namespace zm_stalingrad_challenges
// Params 0, eflags: 0x0
// Checksum 0x7ef227ef, Offset: 0x5100
// Size: 0x48
function function_75fdfc25() {
    self endon(#"flag_player_completed_challenge_3");
    self endon(#"disconnect");
    while (true) {
        self waittill(#"hash_2e47bc4a");
        self thread function_638f34fd();
    }
}

// Namespace zm_stalingrad_challenges
// Params 0, eflags: 0x0
// Checksum 0x1111bd2e, Offset: 0x5150
// Size: 0x7e
function function_638f34fd() {
    self endon(#"hash_4cea57aa");
    self endon(#"bled_out");
    self endon(#"disconnect");
    var_3275089e = 0;
    level waittill(#"between_round_over");
    while (var_3275089e < 4) {
        level waittill(#"end_of_round");
        var_3275089e++;
    }
    self notify(#"update_challenge_3_1");
}

// Namespace zm_stalingrad_challenges
// Params 0, eflags: 0x0
// Checksum 0xee9c95d, Offset: 0x51d8
// Size: 0xb6
function function_2bf9f9d4() {
    self endon(#"disconnect");
    self.var_f12fd515 = [];
    while (self.var_f12fd515.size < 3) {
        self waittill(#"hash_e442448", n_kill_count, str_location);
        if (n_kill_count >= 3) {
            if (!array::contains(self.var_f12fd515, str_location)) {
                array::add(self.var_f12fd515, str_location);
                self notify(#"update_challenge_3_2");
            }
        }
    }
    self.var_f12fd515 = undefined;
}

// Namespace zm_stalingrad_challenges
// Params 0, eflags: 0x0
// Checksum 0xc41d13c7, Offset: 0x5298
// Size: 0x9e
function function_dcbd7aec() {
    self endon(#"disconnect");
    level.var_c6d8defd = self;
    zm_spawner::register_zombie_death_event_callback(&function_22664e38);
    self thread function_cf22215c();
    self flag::wait_till("flag_player_completed_challenge_3");
    zm_spawner::deregister_zombie_death_event_callback(&function_22664e38);
    level.var_c6d8defd = undefined;
}

// Namespace zm_stalingrad_challenges
// Params 1, eflags: 0x0
// Checksum 0x7ec3a9c, Offset: 0x5340
// Size: 0x94
function function_22664e38(e_attacker) {
    if (self.damageweapon === getweapon("launcher_dragon_fire") || isdefined(self) && self.damageweapon === getweapon("launcher_dragon_fire_upgraded")) {
        if (isdefined(e_attacker) && e_attacker.player === level.var_c6d8defd) {
            e_attacker.player notify(#"update_challenge_3_3");
        }
    }
}

// Namespace zm_stalingrad_challenges
// Params 0, eflags: 0x0
// Checksum 0x36a49f4e, Offset: 0x53e0
// Size: 0x46
function function_cf22215c() {
    self endon(#"flag_player_completed_challenge_3");
    self waittill(#"disconnect");
    zm_spawner::deregister_zombie_death_event_callback(&function_22664e38);
    level.var_c6d8defd = undefined;
}

// Namespace zm_stalingrad_challenges
// Params 0, eflags: 0x0
// Checksum 0xb5e20530, Offset: 0x5430
// Size: 0x9e
function function_3d0619b6() {
    self endon(#"disconnect");
    level.var_471bf3e9 = self;
    zm_spawner::register_zombie_death_event_callback(&function_b3fffcec);
    self thread function_c54980a6();
    self flag::wait_till("flag_player_completed_challenge_3");
    zm_spawner::deregister_zombie_death_event_callback(&function_b3fffcec);
    level.var_471bf3e9 = undefined;
}

// Namespace zm_stalingrad_challenges
// Params 1, eflags: 0x0
// Checksum 0xd1313b18, Offset: 0x54d8
// Size: 0x68
function function_b3fffcec(e_attacker) {
    if (isdefined(self) && self.damageweapon === getweapon("turret_bo3_germans_zm_stalingrad")) {
        if (level.var_ffcc580a.var_3a61625b === level.var_471bf3e9) {
            level.var_471bf3e9 notify(#"update_challenge_3_4");
        }
    }
}

// Namespace zm_stalingrad_challenges
// Params 0, eflags: 0x0
// Checksum 0xb28919fc, Offset: 0x5548
// Size: 0x46
function function_c54980a6() {
    self endon(#"flag_player_completed_challenge_3");
    self waittill(#"disconnect");
    zm_spawner::deregister_zombie_death_event_callback(&function_b3fffcec);
    level.var_471bf3e9 = undefined;
}

// Namespace zm_stalingrad_challenges
// Params 0, eflags: 0x0
// Checksum 0xff8d1df7, Offset: 0x5598
// Size: 0x76
function function_cdeaa5f() {
    self endon(#"flag_player_completed_challenge_3");
    self endon(#"disconnect");
    while (true) {
        level waittill(#"hash_9d4cd769", var_4722a1aa, e_attacker);
        if (isdefined(var_4722a1aa) && var_4722a1aa && e_attacker === self) {
            self notify(#"update_challenge_3_5");
        }
    }
}

// Namespace zm_stalingrad_challenges
// Params 0, eflags: 0x0
// Checksum 0xcc1f2c92, Offset: 0x5618
// Size: 0x5a
function function_e480fc42() {
    self endon(#"flag_player_completed_challenge_3");
    self endon(#"disconnect");
    while (true) {
        level waittill(#"hash_73c2bce5", e_attacker);
        if (e_attacker === self) {
            self notify(#"update_challenge_3_6");
        }
    }
}

// Namespace zm_stalingrad_challenges
// Params 1, eflags: 0x0
// Checksum 0x553a701c, Offset: 0x5680
// Size: 0x1bc
function function_2ce855f3(s_challenge) {
    self endon(#"disconnect");
    /#
        self endon(#"hash_f9ff0ae7");
        self endon("<dev string:x28>" + s_challenge.n_index);
    #/
    if (isdefined(s_challenge.func_think)) {
        self thread [[ s_challenge.func_think ]]();
    }
    if (!isdefined(self.var_873a3e27)) {
        self.var_873a3e27 = [];
    }
    self.var_873a3e27[s_challenge.n_index] = 0;
    var_80792f67 = s_challenge.n_count;
    var_ea184c3d = s_challenge.n_count;
    while (var_80792f67 > 0) {
        self waittill(s_challenge.str_notify);
        var_80792f67--;
        self.var_873a3e27[s_challenge.n_index] = 1 - var_80792f67 / var_ea184c3d;
    }
    self flag::set("flag_player_completed_challenge_" + s_challenge.n_index);
    self thread function_c79e93d1();
    if (s_challenge.n_index > 0 && s_challenge.n_index < 4) {
        self function_33e91747(s_challenge.n_index, 1);
    }
}

// Namespace zm_stalingrad_challenges
// Params 0, eflags: 0x0
// Checksum 0x709a35c2, Offset: 0x5848
// Size: 0x104
function function_c79e93d1() {
    a_flags = array("flag_player_completed_challenge_1", "flag_player_completed_challenge_2", "flag_player_completed_challenge_3");
    foreach (flag in a_flags) {
        if (!self flag::get(flag)) {
            self playsoundtoplayer("zmb_challenge_complete", self);
            return;
        }
    }
    self playsoundtoplayer("zmb_challenge_complete_all", self);
}

// Namespace zm_stalingrad_challenges
// Params 0, eflags: 0x0
// Checksum 0x22909a3, Offset: 0x5958
// Size: 0x6a
function function_974d5f1d() {
    self endon(#"disconnect");
    a_flags = array("flag_player_completed_challenge_1", "flag_player_completed_challenge_2", "flag_player_completed_challenge_3");
    self flag::wait_till_all(a_flags);
    self notify(#"hash_41370469");
}

// Namespace zm_stalingrad_challenges
// Params 0, eflags: 0x0
// Checksum 0xc526fe8e, Offset: 0x59d0
// Size: 0x84
function function_b2413e04() {
    var_fbc34b78 = getentarray("pr_g", "script_label");
    array::run_all(var_fbc34b78, &hide);
    level.var_b766c4a8 = 0;
    zm_spawner::register_zombie_death_event_callback(&function_60e1ca5f);
}

// Namespace zm_stalingrad_challenges
// Params 1, eflags: 0x0
// Checksum 0xe33ee197, Offset: 0x5a60
// Size: 0xe6
function function_60e1ca5f(e_attacker) {
    if ((self.damageweapon === level.weaponzmcymbalmonkey || isdefined(self) && self.damageweapon === level.var_4f1451fe) && isplayer(e_attacker)) {
        level.var_b766c4a8++;
        /#
            if (isdefined(level.var_f9c3fe97) && level.var_f9c3fe97) {
                level.var_b766c4a8 = 50;
            }
        #/
        if (level.var_b766c4a8 >= 50) {
            level thread function_d632a808(self.origin);
            zm_spawner::deregister_zombie_death_event_callback(&function_60e1ca5f);
            level.var_b766c4a8 = undefined;
        }
    }
}

// Namespace zm_stalingrad_challenges
// Params 1, eflags: 0x0
// Checksum 0x53d41643, Offset: 0x5b50
// Size: 0x12c
function function_d632a808(var_51a2f105) {
    var_dbd219ed = util::spawn_model("p7_zm_ctl_canteen", var_51a2f105 + (0, 0, 48));
    playfxontag(level._effect["drop_pod_reward_glow"], var_dbd219ed, "tag_origin");
    var_dbd219ed zm_unitrigger::create_unitrigger("");
    var_dbd219ed waittill(#"trigger_activated", e_who);
    e_who clientfield::increment_to_player("interact_rumble");
    var_dbd219ed zm_unitrigger::unregister_unitrigger(var_dbd219ed.s_unitrigger);
    var_dbd219ed delete();
    level flag::set("pr_m");
}

// Namespace zm_stalingrad_challenges
// Params 0, eflags: 0x0
// Checksum 0xd49590ac, Offset: 0x5c88
// Size: 0x1d4
function function_4ca86c86() {
    var_77797571 = struct::get_array("pr_b_spawn", "targetname");
    foreach (var_4af818ae in var_77797571) {
        if (var_4af818ae.script_int == self getentitynumber()) {
            var_4af818ae thread function_d5da2be8(self);
        }
    }
    var_977659a7 = struct::get_array("pr_c_spawn", "targetname");
    foreach (var_238c2594 in var_977659a7) {
        if (var_238c2594.script_int == self getentitynumber()) {
            var_238c2594 thread function_38091734(self);
        }
    }
    self thread function_1fa81bf0();
}

// Namespace zm_stalingrad_challenges
// Params 0, eflags: 0x0
// Checksum 0xfeada3e3, Offset: 0x5e68
// Size: 0xe4
function function_be89247c() {
    if (!(isdefined(self.var_62708302) && self.var_62708302)) {
        self clientfield::set_to_player("pr_b", self getentitynumber());
    } else {
        self clientfield::set_to_player("pr_b", 4);
    }
    if (!(isdefined(self.var_4aaffb90) && self.var_4aaffb90)) {
        self clientfield::set_to_player("pr_c", self getentitynumber());
        return;
    }
    self clientfield::set_to_player("pr_c", 4);
}

// Namespace zm_stalingrad_challenges
// Params 1, eflags: 0x0
// Checksum 0x530d0d5, Offset: 0x5f58
// Size: 0xcc
function function_d5da2be8(e_player_owner) {
    self zm_unitrigger::create_unitrigger("");
    while (true) {
        self waittill(#"trigger_activated", e_who);
        if (e_who == e_player_owner) {
            e_who.var_62708302 = 1;
            e_who clientfield::set_to_player("pr_b", 4);
            e_who playsound("zmb_bouquet_pickup");
            break;
        }
    }
    zm_unitrigger::unregister_unitrigger(self.s_unitrigger);
}

// Namespace zm_stalingrad_challenges
// Params 1, eflags: 0x0
// Checksum 0xbf4e7cb9, Offset: 0x6030
// Size: 0x11c
function function_38091734(e_player_owner) {
    level endon("player_disconnected_" + self.script_int);
    e_player_owner function_34a8c625(self);
    e_player_owner clientfield::set_to_player("pr_l_c", 1);
    self zm_unitrigger::create_unitrigger("");
    while (true) {
        self waittill(#"trigger_activated", e_who);
        if (e_who == e_player_owner) {
            e_who.var_4aaffb90 = 1;
            e_who clientfield::set_to_player("pr_c", 4);
            e_who playsound("zmb_candle_pickup");
            break;
        }
    }
    zm_unitrigger::unregister_unitrigger(self.s_unitrigger);
}

// Namespace zm_stalingrad_challenges
// Params 1, eflags: 0x0
// Checksum 0x51068890, Offset: 0x6158
// Size: 0x156
function function_34a8c625(s_candle) {
    self endon(#"death");
    while (true) {
        self waittill(#"hash_10fa975d");
        var_7dda366c = self getweaponmuzzlepoint();
        var_9c5bd97c = self getweaponforwarddir();
        var_ae93125 = level.zombie_vars["dragonshield_knockdown_range"] * level.zombie_vars["dragonshield_knockdown_range"];
        var_cb78916d = s_candle.origin;
        var_8112eb05 = distancesquared(var_7dda366c, var_cb78916d);
        if (var_8112eb05 > var_ae93125) {
            continue;
        }
        v_normal = vectornormalize(var_cb78916d - var_7dda366c);
        n_dot = vectordot(var_9c5bd97c, v_normal);
        if (0 > n_dot) {
            continue;
        }
        return;
    }
}

// Namespace zm_stalingrad_challenges
// Params 0, eflags: 0x0
// Checksum 0xe675e656, Offset: 0x62b8
// Size: 0x1f2
function function_1fa81bf0() {
    self endon(#"death");
    self endon(#"hash_8b3a62f7");
    a_s_rewards = struct::get_array("s_challenge_reward", "targetname");
    foreach (s_reward in a_s_rewards) {
        if (s_reward.script_int == self getentitynumber()) {
            break;
        }
    }
    level flag::wait_till("pr_m");
    while (true) {
        self waittill(#"grenade_fire", grenade, weapon);
        if (weapon === level.weaponzmcymbalmonkey || weapon === level.var_4f1451fe) {
            grenade waittill(#"stationary");
            var_31dc18aa = 40 * 40;
            var_2931dc75 = distancesquared(grenade.origin, s_reward.origin);
            if (var_2931dc75 <= var_31dc18aa) {
                self.var_621ab6ef = 1;
                self function_14e16a1c(grenade);
                self.var_621ab6ef = undefined;
            }
        }
    }
}

// Namespace zm_stalingrad_challenges
// Params 1, eflags: 0x0
// Checksum 0xec067b4, Offset: 0x64b8
// Size: 0x7c
function function_14e16a1c(e_grenade) {
    self endon(#"death");
    e_grenade endon(#"death");
    self waittill(#"hash_4c1b1a28");
    e_grenade clientfield::set("pr_gm_e_fx", 1);
    util::wait_network_frame();
    e_grenade delete();
}

// Namespace zm_stalingrad_challenges
// Params 0, eflags: 0x0
// Checksum 0x52a02443, Offset: 0x6540
// Size: 0x1ba
function function_9ffe5c12() {
    if (isdefined(self.var_621ab6ef) && isdefined(self.var_4aaffb90) && isdefined(self.var_62708302) && level flag::get("pr_m") && self.var_62708302 && self.var_4aaffb90 && self.var_621ab6ef && !self flag::get("flag_player_collected_reward_5")) {
        var_36d214f8 = struct::get_array("challenge_fire_struct", "targetname");
        foreach (var_47398c71 in var_36d214f8) {
            if (var_47398c71.script_int == self getentitynumber()) {
                if (self function_3f67a723(var_47398c71.origin, 15, 0) && distance(self.origin, var_47398c71.origin) < 500) {
                    return true;
                }
            }
        }
    }
    return false;
}

// Namespace zm_stalingrad_challenges
// Params 0, eflags: 0x0
// Checksum 0x91e95a58, Offset: 0x6708
// Size: 0x19c
function function_a231bc42() {
    self notify(#"hash_4c1b1a28");
    n_ent_num = self getentitynumber();
    var_32f0d800 = getent("pr_g_b_" + n_ent_num, "targetname");
    var_32f0d800 show();
    mdl_candle = getent("pr_g_c_" + n_ent_num, "targetname");
    mdl_candle show();
    mdl_candle clientfield::set("pr_g_c_fx", 1);
    var_eaad475 = getent("pr_g_cn_" + n_ent_num, "targetname");
    var_eaad475 show();
    self waittill(#"disconnect");
    mdl_candle clientfield::set("pr_g_c_fx", 0);
    var_32f0d800 hide();
    mdl_candle hide();
    var_eaad475 hide();
}

// Namespace zm_stalingrad_challenges
// Params 0, eflags: 0x0
// Checksum 0xd0e04e7, Offset: 0x68b0
// Size: 0x64
function function_c46e4bfe() {
    self notify(#"hash_8b3a62f7");
    level.zombie_weapons[level.weaponzmcymbalmonkey].is_in_box = 0;
    level.zombie_weapons[level.var_4f1451fe].is_in_box = 1;
    self _zm_weap_cymbal_monkey::function_6e1d44a0();
}

/#

    // Namespace zm_stalingrad_challenges
    // Params 0, eflags: 0x0
    // Checksum 0x2a9bbff5, Offset: 0x6920
    // Size: 0x10c
    function function_b9b4ce34() {
        zm_devgui::add_custom_devgui_callback(&function_16ba3a1e);
        adddebugcommand("<dev string:x41>");
        adddebugcommand("<dev string:xa4>");
        adddebugcommand("<dev string:x107>");
        adddebugcommand("<dev string:x16a>");
        adddebugcommand("<dev string:x1da>");
        adddebugcommand("<dev string:x23c>");
        adddebugcommand("<dev string:x23c>");
        if (getdvarint("<dev string:x296>") > 0) {
            adddebugcommand("<dev string:x2a3>");
        }
    }

    // Namespace zm_stalingrad_challenges
    // Params 1, eflags: 0x0
    // Checksum 0x39c89873, Offset: 0x6a38
    // Size: 0x50a
    function function_16ba3a1e(cmd) {
        switch (cmd) {
        case "<dev string:x2fb>":
            foreach (e_player in level.players) {
                e_player flag::set("<dev string:x311>");
                e_player notify(#"hash_fb393ffe");
                e_player.var_873a3e27[1] = 1;
                e_player function_33e91747(1, 1);
            }
            return 1;
        case "<dev string:x333>":
            foreach (e_player in level.players) {
                e_player flag::set("<dev string:x349>");
                e_player notify(#"hash_d536c595");
                e_player.var_873a3e27[2] = 1;
                e_player function_33e91747(2, 1);
            }
            return 1;
        case "<dev string:x36b>":
            foreach (e_player in level.players) {
                e_player flag::set("<dev string:x381>");
                e_player notify(#"hash_af344b2c");
                e_player.var_873a3e27[3] = 1;
                e_player function_33e91747(3, 1);
            }
            return 1;
        case "<dev string:x3a3>":
            foreach (e_player in level.players) {
                e_player flag::set("<dev string:x3bf>");
            }
            return 1;
        case "<dev string:x3e1>":
            level function_dcfe1b91();
            foreach (e_player in level.players) {
                e_player function_224232f4();
            }
            return 1;
        case "<dev string:x3f6>":
            foreach (e_player in level.players) {
                e_player function_224232f4();
            }
            return 1;
        case "<dev string:x407>":
            foreach (e_player in level.players) {
                e_player function_f506b074();
            }
            return 1;
        }
        return 0;
    }

    // Namespace zm_stalingrad_challenges
    // Params 0, eflags: 0x0
    // Checksum 0xeb068391, Offset: 0x6f50
    // Size: 0x18e
    function function_224232f4() {
        self notify(#"hash_f9ff0ae7");
        self flag::clear("<dev string:x413>");
        self flag::clear("<dev string:x432>");
        self flag::clear("<dev string:x451>");
        self flag::clear("<dev string:x311>");
        self flag::clear("<dev string:x349>");
        self flag::clear("<dev string:x381>");
        self thread function_2ce855f3(self._challenges.var_4687355c);
        self thread function_2ce855f3(self._challenges.var_b88ea497);
        self thread function_2ce855f3(self._challenges.var_928c2a2e);
        for (i = 1; i <= 3; i++) {
            self thread function_a2d25f82(i);
        }
    }

    // Namespace zm_stalingrad_challenges
    // Params 0, eflags: 0x0
    // Checksum 0xe9b778eb, Offset: 0x70e8
    // Size: 0x452
    function function_dcfe1b91() {
        foreach (e_player in level.players) {
            if (!isdefined(level._challenges.var_4687355c)) {
                level._challenges.var_4687355c = [];
            } else if (!isarray(level._challenges.var_4687355c)) {
                level._challenges.var_4687355c = array(level._challenges.var_4687355c);
            }
            level._challenges.var_4687355c[level._challenges.var_4687355c.size] = e_player._challenges.var_4687355c;
            if (!isdefined(level._challenges.var_b88ea497)) {
                level._challenges.var_b88ea497 = [];
            } else if (!isarray(level._challenges.var_b88ea497)) {
                level._challenges.var_b88ea497 = array(level._challenges.var_b88ea497);
            }
            level._challenges.var_b88ea497[level._challenges.var_b88ea497.size] = e_player._challenges.var_b88ea497;
            if (!isdefined(level._challenges.var_928c2a2e)) {
                level._challenges.var_928c2a2e = [];
            } else if (!isarray(level._challenges.var_928c2a2e)) {
                level._challenges.var_928c2a2e = array(level._challenges.var_928c2a2e);
            }
            level._challenges.var_928c2a2e[level._challenges.var_928c2a2e.size] = e_player._challenges.var_928c2a2e;
        }
        foreach (e_player in level.players) {
            e_player._challenges.var_4687355c = array::random(level._challenges.var_4687355c);
            e_player._challenges.var_b88ea497 = array::random(level._challenges.var_b88ea497);
            e_player._challenges.var_928c2a2e = array::random(level._challenges.var_928c2a2e);
            arrayremovevalue(level._challenges.var_4687355c, e_player._challenges.var_4687355c);
            arrayremovevalue(level._challenges.var_b88ea497, e_player._challenges.var_b88ea497);
            arrayremovevalue(level._challenges.var_928c2a2e, e_player._challenges.var_928c2a2e);
        }
    }

    // Namespace zm_stalingrad_challenges
    // Params 0, eflags: 0x0
    // Checksum 0xc1f3bbea, Offset: 0x7548
    // Size: 0x3c
    function function_f506b074() {
        level flag::set("<dev string:x470>");
        self.var_62708302 = 1;
        self.var_4aaffb90 = 1;
    }

#/
