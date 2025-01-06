#using scripts/codescripts/struct;
#using scripts/cp/_decorations;
#using scripts/cp/_dialog;
#using scripts/cp/_objectives;
#using scripts/cp/_oed;
#using scripts/cp/_skipto;
#using scripts/cp/_training_sim;
#using scripts/cp/_util;
#using scripts/cp/gametypes/_globallogic_player;
#using scripts/cp/gametypes/_loadout;
#using scripts/cp/gametypes/_save;
#using scripts/cp/voice/voice_safehouse;
#using scripts/shared/array_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/gameobjects_shared;
#using scripts/shared/lui_shared;
#using scripts/shared/math_shared;
#using scripts/shared/music_shared;
#using scripts/shared/player_shared;
#using scripts/shared/rank_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/system_shared;
#using scripts/shared/trigger_shared;
#using scripts/shared/util_shared;
#using scripts/shared/weapons_shared;

#namespace safehouse;

// Namespace safehouse
// Params 0, eflags: 0x2
// Checksum 0xd160c325, Offset: 0x2328
// Size: 0x3a
function autoexec function_2dc19561() {
    system::register("safehouse", &__init__, &__main__, undefined);
}

// Namespace safehouse
// Params 0, eflags: 0x4
// Checksum 0xb21440e3, Offset: 0x2370
// Size: 0x44
function private __init__() {
    level.is_safehouse = 1;
    var_ab91e00d = getdvarstring("cp_queued_level", "");
    InvalidOpCode(0xc9);
    // Unknown operator (0xc9, t7_1b, PC)
}

// Namespace safehouse
// Params 0, eflags: 0x0
// Checksum 0xfa01130d, Offset: 0x2b50
// Size: 0x1225
function function_3d4973d1() {
    level.ambient_vo_ent = getent("ambient_vo_ent", "targetname");
    switch (level.next_map) {
    case "cp_mi_eth_prologue":
        pre = "pre" + (math::cointoss() ? "m" : "f");
        var_b3950cbc = "new" + (math::cointoss() ? "m" : "f");
        function_77cfa54b(pre + "_this_morning_member_0", undefined, "ambient");
        function_77cfa54b(pre + "_this_administration_0", 2, "ambient");
        function_77cfa54b(pre + "_we_will_continue_to_0", 2, "ambient");
        function_77cfa54b(var_b3950cbc + "_in_just_a_few_short_0", undefined, "ambient");
        function_77cfa54b(var_b3950cbc + "_with_the_capture_of_0", 2, "ambient");
        function_77cfa54b(var_b3950cbc + "_the_wa_have_denied_s_0", 2, "ambient");
        break;
    case "cp_mi_zurich_newworld":
        var_b3950cbc = "new" + (math::cointoss() ? "m" : "f");
        sci = "sci" + (math::cointoss() ? "m" : "f");
        function_77cfa54b(var_b3950cbc + "_though_a_spokesperso_0", undefined, "ambient");
        function_77cfa54b(var_b3950cbc + "_with_the_minister_no_0", 2, "ambient");
        function_77cfa54b(var_b3950cbc + "_certainly_many_are_0", 2, "ambient");
        function_77cfa54b(sci + "_there_s_no_doubt_tha_0", undefined, "ambient");
        function_77cfa54b(sci + "_the_increasing_preva_0", 2, "ambient");
        function_77cfa54b(sci + "_the_development_of_d_0", 2, "ambient");
        function_77cfa54b(sci + "_ironically_however_0", 2, "ambient");
        break;
    case "cp_mi_sing_blackstation":
        function_77cfa54b("plyr_hey_hendricks_beat_0", 1, "player");
        function_77cfa54b("hend_singapore_one_of_my_0", 1, "remote");
        function_77cfa54b("plyr_oh_yeah_this_is_a_0", 1, "player");
        function_77cfa54b("hend_glad_you_remember_0", 1, "remote");
        function_77cfa54b("plyr_ah_they_re_always_w_0", 1, "player");
        pre = "pre" + (math::cointoss() ? "m" : "f");
        sci = "sci" + (math::cointoss() ? "m" : "f");
        var_b3950cbc = "new" + (math::cointoss() ? "m" : "f");
        function_77cfa54b(pre + "_while_it_is_true_tha_0", undefined, "ambient");
        function_77cfa54b(pre + "_though_the_cause_of_0", 2, "ambient");
        function_77cfa54b(sci + "_one_of_the_key_probl_0", undefined, "ambient");
        function_77cfa54b(sci + "_in_the_chaos_of_the_0", 2, "ambient");
        function_77cfa54b(sci + "_what_we_do_know_for_0", 2, "ambient");
        function_77cfa54b(var_b3950cbc + "_on_the_anniversary_o_0", undefined, "ambient");
        function_77cfa54b(var_b3950cbc + "_despite_the_many_eff_0", 2, "ambient");
        function_77cfa54b(var_b3950cbc + "_the_emergence_of_cri_0", 2, "ambient");
        break;
    case "cp_mi_sing_biodomes":
    case "cp_mi_sing_biodomes2":
        function_77cfa54b("hend_so_i_wanted_to_ask_0", 1, "remote");
        function_77cfa54b("plyr_kane_said_they_re_of_0", 1, "player");
        function_77cfa54b("hend_i_m_not_so_sure_i_t_0", 1, "remote");
        function_77cfa54b("plyr_i_think_you_re_being_0", 1, "player");
        function_77cfa54b("hend_i_guess_we_ll_see_0", 1, "remote");
        pre = "pre" + (math::cointoss() ? "m" : "f");
        var_b3950cbc = "new" + (math::cointoss() ? "m" : "f");
        function_77cfa54b(pre + "_in_light_of_today_s_0", undefined, "ambient");
        function_77cfa54b(pre + "_we_are_coordinating_0", 2, "ambient");
        function_77cfa54b(var_b3950cbc + "_the_scale_of_these_i_0", undefined, "ambient");
        function_77cfa54b(var_b3950cbc + "_hundreds_of_thousand_0", 2, "ambient");
        function_77cfa54b(var_b3950cbc + "_it_s_going_to_take_a_0", 2, "ambient");
        break;
    case "cp_mi_sing_sgen":
        function_77cfa54b("hend_so_according_to_kan_0", 1, "remote");
        function_77cfa54b("plyr_about_what_i_did_to_0", 1, "player");
        function_77cfa54b("hend_i_know_beat_i_a_0", 1, "remote");
        function_77cfa54b("plyr_kane_said_that_whate_0", 1, "player");
        pre = "pre" + (math::cointoss() ? "m" : "f");
        var_b3950cbc = "new" + (math::cointoss() ? "m" : "f");
        function_77cfa54b(pre + "_in_recent_days_we_ha_0", undefined, "ambient");
        function_77cfa54b(pre + "_however_the_allega_0", 2, "ambient");
        function_77cfa54b(pre + "_the_inflammatory_acc_0", 2, "ambient");
        function_77cfa54b(pre + "_i_ask_that_members_o_0", 2, "ambient");
        function_77cfa54b(var_b3950cbc + "_while_we_do_not_know_0", 3, "ambient");
        break;
    case "cp_mi_sing_vengeance":
        function_77cfa54b("hend_i_m_telling_you_now_0", 1, "remote");
        function_77cfa54b("plyr_this_isn_t_up_for_di_0", 1, "player");
        function_77cfa54b("hend_you_know_they_want_u_0", 1, "remote");
        function_77cfa54b("plyr_it_s_not_our_actions_0", 1, "player");
        pre = "pre" + (math::cointoss() ? "m" : "f");
        sci = "sci" + (math::cointoss() ? "m" : "f");
        var_b3950cbc = "new" + (math::cointoss() ? "m" : "f");
        function_77cfa54b(pre + "_as_i_said_before_w_0", undefined, "ambient");
        function_77cfa54b(var_b3950cbc + "_it_s_hard_to_imagine_0", 2, "ambient");
        function_77cfa54b(sci + "_the_suggestion_that_0", undefined, "ambient");
        function_77cfa54b(sci + "_certainly_various_r_0", 2, "ambient");
        break;
    case "cp_mi_cairo_ramses":
    case "cp_mi_cairo_ramses2":
        function_77cfa54b("hend_how_is_she_1", 1, "remote");
        function_77cfa54b("plyr_she_s_strong_meds_0", 1, "player");
        function_77cfa54b("hend_so_you_re_okay_wit_0", 1, "remote");
        function_77cfa54b("plyr_okay_with_what_hend_0", 1, "player");
        function_77cfa54b("hend_okay_with_the_fact_t_0", 1, "remote");
        function_77cfa54b("plyr_they_leaked_classifi_0", 1, "player");
        pre = "pre" + (math::cointoss() ? "m" : "f");
        var_b3950cbc = "new" + (math::cointoss() ? "m" : "f");
        function_77cfa54b(pre + "_the_actions_perpetra_0", undefined, "ambient");
        function_77cfa54b(pre + "_at_this_time_we_are_0", 2, "ambient");
        function_77cfa54b(pre + "_as_this_time_those_0", 2, "ambient");
        function_77cfa54b(var_b3950cbc + "_ground_forces_contin_0", undefined, "ambient");
        function_77cfa54b(var_b3950cbc + "_already_suffering_un_0", 2, "ambient");
        break;
    case "cp_mi_cairo_infection":
    case "cp_mi_cairo_infection2":
    case "cp_mi_cairo_infection3":
        function_77cfa54b("kane_wake_up_beat_ther_0", 1, "remote");
        function_77cfa54b("plyr_where_s_hendricks_0", 1, "player");
        function_77cfa54b("kane_he_s_asleep_i_m_run_0", 1, "remote");
        function_77cfa54b("plyr_can_i_trust_you_0", 1, "player");
        function_77cfa54b("kane_how_about_i_tell_you_0", 1, "remote");
        function_77cfa54b("plyr_taylor_s_still_speak_0", 1, "player");
        function_77cfa54b("kane_i_think_his_dni_ha_0", 1, "remote");
        function_77cfa54b("plyr_but_we_can_track_the_0", 1, "player");
        var_b3950cbc = "new" + (math::cointoss() ? "m" : "f");
        sci = "sci" + (math::cointoss() ? "m" : "f");
        function_77cfa54b(var_b3950cbc + "_yesterday_saw_some_o_0", undefined, "ambient");
        function_77cfa54b(var_b3950cbc + "_ramses_station_one_0", 2, "ambient");
        function_77cfa54b(var_b3950cbc + "_while_allied_forces_0", 2, "ambient");
        function_77cfa54b(var_b3950cbc + "_the_outcome_was_perh_0", 2, "ambient");
        function_77cfa54b(sci + "_there_s_a_long_histo_0", undefined, "ambient");
        function_77cfa54b(sci + "_there_is_every_reaso_0", 2, "ambient");
        break;
    case "cp_mi_cairo_aquifer":
        function_77cfa54b("kane_prep_to_move_out_0", 1, "remote");
        function_77cfa54b("kane_once_again_we_ve_go_0", 1, "remote");
        function_77cfa54b("plyr_how_do_they_do_it_k_0", 1, "player");
        function_77cfa54b("kane_maybe_one_day_the_wa_0", 1, "remote");
        pre = "pre" + (math::cointoss() ? "m" : "f");
        sci = "sci" + (math::cointoss() ? "m" : "f");
        function_77cfa54b(pre + "_in_coordination_with_0", undefined, "ambient");
        function_77cfa54b(pre + "_at_this_moment_we_a_0", 2, "ambient");
        function_77cfa54b(sci + "_having_personally_re_0", undefined, "ambient");
        function_77cfa54b(sci + "_the_use_of_human_exp_0", 2, "ambient");
        function_77cfa54b(sci + "_doctor_salim_s_resea_0", 2, "ambient");
        function_77cfa54b(sci + "_in_terms_of_ethics_0", 2, "ambient");
        break;
    case "cp_mi_cairo_lotus":
    case "cp_mi_cairo_lotus2":
    case "cp_mi_cairo_lotus3":
        function_77cfa54b("plyr_kane_about_what_ha_0", 1, "player");
        function_77cfa54b("kane_we_can_t_focus_on_th_0", 1, "remote");
        function_77cfa54b("plyr_the_infection_the_0", 1, "player");
        function_77cfa54b("kane_all_we_can_do_is_hop_0", 1, "remote");
        function_77cfa54b("plyr_it_may_not_be_offici_0", 1, "player");
        function_77cfa54b("kane_his_heart_s_in_the_r_0", 1, "remote");
        pre = "pre" + (math::cointoss() ? "m" : "f");
        var_b3950cbc = "new" + (math::cointoss() ? "m" : "f");
        function_77cfa54b(var_b3950cbc + "_today_we_received_a_0", undefined, "ambient");
        function_77cfa54b(var_b3950cbc + "_it_quickly_became_ev_0", 2, "ambient");
        function_77cfa54b(pre + "_today_we_pledge_our_0", undefined, "ambient");
        function_77cfa54b(pre + "_their_bravery_in_the_0", 2, "ambient");
        break;
    case "cp_mi_zurich_coalescence":
        function_77cfa54b("corv_listen_only_to_the_s_3", 1, "player");
        function_77cfa54b("corv_let_your_mind_relax_3", 1, "player");
        function_77cfa54b("corv_let_your_thoughts_dr_1", 1, "player");
        function_77cfa54b("corv_let_the_bad_memories_0", 1, "player");
        function_77cfa54b("corv_let_peace_be_upon_yo_0", 1, "player");
        function_77cfa54b("corv_you_are_in_control_0", 1, "player");
        function_77cfa54b("corv_imagine_yourself_1", 1, "player");
        break;
    }
}

// Namespace safehouse
// Params 0, eflags: 0x0
// Checksum 0x8c82bed5, Offset: 0x3d80
// Size: 0x13b
function function_9423672b() {
    self endon(#"disconnect");
    trigger::wait_till("main_room_trigger", "targetname", self);
    if (isarray(level.var_836d6d34)) {
        foreach (var_39b18b57 in level.var_836d6d34) {
            str_line = var_39b18b57[0];
            n_wait = var_39b18b57[1];
            str_type = var_39b18b57[2];
            function_3913c855(n_wait);
            if (str_type == "remote") {
                level dialog::remote(str_line, 0, undefined, self);
                continue;
            }
            if (str_type == "ambient") {
                level.ambient_vo_ent dialog::say(str_line, 0, 1, self);
                continue;
            }
            if (str_type == "player") {
                self dialog::function_13b3b16a(str_line);
            }
        }
    }
}

// Namespace safehouse
// Params 1, eflags: 0x0
// Checksum 0x6d9aaf6e, Offset: 0x3ec8
// Size: 0x9d
function function_3913c855(n_wait) {
    var_3784d0f4 = array("in_ready_room", "in_aar", "in_training_sim", "interacting", "safehouse_menu_open");
    do {
        if (!isdefined(n_wait)) {
            n_wait = randomfloatrange(5, 10);
        }
        wait n_wait;
    } while (!isalive(self) || flag::get_any(var_3784d0f4));
}

// Namespace safehouse
// Params 3, eflags: 0x0
// Checksum 0xa8b21e64, Offset: 0x3f70
// Size: 0x93
function function_77cfa54b(str_line, n_wait, str_type) {
    if (!isdefined(level.var_836d6d34)) {
        level.var_836d6d34 = [];
    } else if (!isarray(level.var_836d6d34)) {
        level.var_836d6d34 = array(level.var_836d6d34);
    }
    level.var_836d6d34[level.var_836d6d34.size] = array(str_line, n_wait, str_type);
}

// Namespace safehouse
// Params 1, eflags: 0x0
// Checksum 0xd0124458, Offset: 0x4010
// Size: 0x1fa
function function_51970da0(a_ents) {
    e_player = a_ents["player 1"];
    /#
        if (issubstr(e_player.current_scene, "<dev string:x68>")) {
            n_index = 1;
        } else if (issubstr(e_player.current_scene, "<dev string:x71>")) {
            n_index = 2;
        } else if (issubstr(e_player.current_scene, "<dev string:x7a>")) {
            n_index = 3;
        } else if (issubstr(e_player.current_scene, "<dev string:x83>")) {
            n_index = 4;
        }
    #/
    if (!isdefined(n_index)) {
        n_index = e_player.var_8d3631f4 + 1;
    }
    if (isdefined(e_player.primaryloadoutweapon)) {
        mdl_weapon = a_ents["player" + n_index + "_ready_room_weapon"];
        mdl_weapon setmodel(e_player.primaryloadoutweapon.worldmodel);
    }
    var_12aba86 = getent("player_" + n_index + "_sidearm", "targetname");
    if (weapons::is_side_arm(e_player.secondaryloadoutweapon.rootweapon)) {
        var_12aba86 setmodel(e_player.secondaryloadoutweapon.worldmodel);
        var_12aba86 show();
    } else {
        var_12aba86 hide();
    }
    e_player util::waittill_either("left_ready_room", "disconnect");
    var_12aba86 hide();
}

// Namespace safehouse
// Params 0, eflags: 0x4
// Checksum 0xeb139a9d, Offset: 0x4218
// Size: 0x82
function private __main__() {
    level thread function_4dff3e80();
    function_43e79c92();
    function_ed174df5();
    callback::on_connect(&function_c891fb17);
    callback::on_disconnect(&function_554b2d7e);
    level thread function_124e0cdc();
}

// Namespace safehouse
// Params 0, eflags: 0x0
// Checksum 0x78077ce, Offset: 0x42a8
// Size: 0x3a
function function_124e0cdc() {
    wait 0.05;
    level clientfield::set("nextMap", getmaporder(level.next_map));
}

// Namespace safehouse
// Params 0, eflags: 0x4
// Checksum 0x6915664b, Offset: 0x42f0
// Size: 0xaa
function private on_player_connect() {
    self.disableclassselection = 1;
    self flag::init("in_ready_room");
    self flag::init("in_aar");
    self flag::init("in_training_sim");
    self flag::init("loadout_dirty");
    self flag::init("interacting");
    self flag::init("safehouse_menu_open");
    self thread function_390094e6();
}

// Namespace safehouse
// Params 0, eflags: 0x4
// Checksum 0xcb9344e3, Offset: 0x43a8
// Size: 0x4a
function private on_player_disconnect() {
    if (flag::get("in_ready_room")) {
        level.n_players_ready--;
        function_f4851bfc();
    }
    level notify(#"hash_a35e1275");
    function_680cf465();
}

// Namespace safehouse
// Params 0, eflags: 0x4
// Checksum 0xba39c447, Offset: 0x4400
// Size: 0x1ca
function private on_player_spawned() {
    self.disableclassselection = 0;
    self.var_32218fc7 = 1;
    function_b11df48f();
    self thread function_9423672b();
    if (isdefined(self.training_dummy)) {
        self thread function_1a70861a();
    } else {
        var_4fb0aa1e = self getluimenu("MissionRecordVaultScreens");
        if (!isdefined(var_4fb0aa1e)) {
            self openluimenu("MissionRecordVaultScreens");
        }
        self globallogic_player::function_7bdf5497();
        if (isdefined(level.show_aar) && level.show_aar) {
            InvalidOpCode(0xc9);
            // Unknown operator (0xc9, t7_1b, PC)
        }
        self thread function_a24e854d();
        var_162c6190 = getentarray("m_terminal_asleep", "targetname");
        if (var_162c6190.size > 0) {
            var_69c1a63b = arraygetclosest(self.origin, var_162c6190);
            var_69c1a63b show();
        }
        var_162c6190 = getentarray("m_terminal_awake", "targetname");
        if (var_162c6190.size > 0) {
            var_cdc7765d = arraygetclosest(self.origin, var_162c6190);
            var_cdc7765d hide();
        }
    }
    oed::function_1c59df50(0);
    oed::function_12a9df06(0);
}

// Namespace safehouse
// Params 0, eflags: 0x4
// Checksum 0xdbe2cf61, Offset: 0x45d8
// Size: 0x12
function private on_player_killed() {
    self undolaststand();
}

// Namespace safehouse
// Params 1, eflags: 0x0
// Checksum 0x7d2e444b, Offset: 0x45f8
// Size: 0x10b
function function_a85e8026(n_num) {
    var_fb7bdf69 = array("pdv_screens_1", "pdv_screens_2", "pdv_screens_3");
    foreach (var_3c359681 in var_fb7bdf69) {
        if (strendswith(var_3c359681, n_num)) {
            array::run_all(getentarray(var_3c359681, "targetname"), &show);
            continue;
        }
        array::run_all(getentarray(var_3c359681, "targetname"), &hide);
    }
}

// Namespace safehouse
// Params 0, eflags: 0x0
// Checksum 0x8ff2876d, Offset: 0x4710
// Size: 0x172
function function_f380969b() {
    var_67bda5a5 = self getdstat("currentRankXP");
    currentRankXP = self rank::getrankxpstat();
    hasSeenMaxLevelNotification = self getdstat("hasSeenMaxLevelNotification");
    if (hasSeenMaxLevelNotification != 1 && currentRankXP >= rank::getrankinfominxp(level.ranktable.size - 1)) {
        var_c2dc2b72 = self openluimenu("CPMaxLevelNotification");
        self setdstat("hasSeenMaxLevelNotification", 1);
        uploadstats(self);
    } else {
        var_c2dc2b72 = self openluimenu("RewardsOverlayCP");
    }
    level.var_ac964c36 = 0;
    self waittill(#"menuresponse", menu, response);
    while (response != "closed") {
        self waittill(#"menuresponse", menu, response);
    }
    self closeluimenu(var_c2dc2b72);
    self globallogic_player::function_4cef9872(getrootmapname());
    self globallogic_player::function_a5ac6877();
    level.var_ac964c36 = 1;
}

// Namespace safehouse
// Params 0, eflags: 0x0
// Checksum 0x95ba0bf8, Offset: 0x4890
// Size: 0xfa
function function_c2ba6d68() {
    self flag::set("in_aar");
    s_scene = struct::get("aar_camera", "targetname");
    s_scenedef = struct::get_script_bundle("scene", s_scene.scriptbundlename);
    align = scene::get_existing_ent(s_scenedef.aligntarget, 0, 1);
    camanimscripted(self, s_scenedef.cameraswitcher, gettime(), align.origin, align.angles);
    self function_f380969b();
    endcamanimscripted(self);
    self flag::clear("in_aar");
}

// Namespace safehouse
// Params 0, eflags: 0x0
// Checksum 0x5cc31e16, Offset: 0x4998
// Size: 0x12
function function_b11df48f() {
    self util::function_16c71b8(1);
}

// Namespace safehouse
// Params 0, eflags: 0x0
// Checksum 0xc9da8aa9, Offset: 0x49b8
// Size: 0x93
function function_bcfa7205() {
    a_weaponlist = self getweaponslist();
    foreach (weapon in a_weaponlist) {
        if (isdefined(weapon.isheroweapon) && weapon.isheroweapon) {
            self takeweapon(weapon);
        }
    }
}

// Namespace safehouse
// Params 0, eflags: 0x0
// Checksum 0xcf83d45, Offset: 0x4a58
// Size: 0x103
function function_cf4c3bd8() {
    var_162c6190 = getentarray("m_terminal_asleep", "targetname");
    foreach (screen in var_162c6190) {
        screen show();
    }
    var_162c6190 = getentarray("m_terminal_awake", "targetname");
    foreach (screen in var_162c6190) {
        screen hide();
    }
}

// Namespace safehouse
// Params 5, eflags: 0x0
// Checksum 0xa7c77df, Offset: 0x4b68
// Size: 0x170
function function_a8960cf7(trigger, objectiveid, var_5567500d, var_e6ffaa89, var_72fcb946) {
    if (!isdefined(var_72fcb946)) {
        var_72fcb946 = 1;
    }
    trigger sethintstring(var_5567500d);
    trigger setcursorhint("HINT_INTERACTIVE_PROMPT");
    game_object = gameobjects::create_use_object("any", trigger, array(trigger), (0, 0, 0), objectiveid);
    game_object gameobjects::allow_use("any");
    game_object gameobjects::set_use_time(0.35);
    game_object gameobjects::set_owner_team("allies");
    game_object gameobjects::set_visible_team("any");
    game_object.single_use = 0;
    game_object.trigger usetriggerrequirelookat();
    game_object.origin = game_object.origin;
    game_object.angles = game_object.angles;
    if (isdefined(var_e6ffaa89)) {
        if (var_72fcb946) {
            game_object.onuse_thread = 1;
        }
        game_object.onuse = var_e6ffaa89;
    }
    return game_object;
}

// Namespace safehouse
// Params 1, eflags: 0x0
// Checksum 0x6e96707d, Offset: 0x4ce0
// Size: 0x52
function function_e04cba0f(e_player) {
    self gameobjects::hide_waypoint(e_player);
    if (isdefined(e_player)) {
        self.trigger setinvisibletoplayer(e_player);
        return;
    }
    self.trigger setinvisibletoall();
}

// Namespace safehouse
// Params 1, eflags: 0x0
// Checksum 0xd309f0be, Offset: 0x4d40
// Size: 0x52
function function_a8271940(e_player) {
    self gameobjects::show_waypoint(e_player);
    if (isdefined(e_player)) {
        self.trigger setvisibletoplayer(e_player);
        return;
    }
    self.trigger setvisibletoall();
}

// Namespace safehouse
// Params 0, eflags: 0x4
// Checksum 0x5ac93ac1, Offset: 0x4da0
// Size: 0x9a
function private function_4dff3e80() {
    level thread function_ed69417e();
    function_ca93dc45();
    level flag::wait_till("first_player_spawned");
    wait 5;
    var_8b856a66 = getent("trig_start_level", "targetname");
    level.var_f0ba161d = function_a8960cf7(var_8b856a66, %cp_safehouse_ready_room, %CP_SH_CAIRO_READY_ROOM2, &function_431ca329);
}

// Namespace safehouse
// Params 0, eflags: 0x0
// Checksum 0xf910d970, Offset: 0x4e48
// Size: 0x40a
function function_ed69417e() {
    level.n_players_ready = 0;
    level flag::init("all_players_ready");
    level flag::wait_till("all_players_ready");
    enablelobbyjoins(0);
    foreach (player in level.players) {
        player savegame::set_player_data(function_6d71dab7(level.next_map) + "_class", player.curclass);
    }
    util::wait_network_frame(3);
    foreach (player in level.players) {
        player scene::stop();
    }
    a_players = [];
    foreach (player in level.players) {
        a_players["player " + player.var_8d3631f4 + 1] = player;
    }
    level thread scene::play("cin_saf_ram_readyroom_3rd_pre200", a_players);
    if (isdefined(level.var_f3db725a)) {
        array::run_all(level.players, level.var_f3db725a);
    }
    util::wait_network_frame(3);
    level thread lui::screen_fade_in(0.2);
    level waittill(#"hash_44c344f7");
    foreach (player in level.players) {
        player clientfield::set_to_player("sh_exit_duck_active", 1);
    }
    level lui::screen_fade_out(0);
    skipto::function_677539fe("");
    /#
        printtoprightln("<dev string:x8c>" + level.next_map, (1, 1, 1));
    #/
    if (level.next_map == savegame_getsavedqueuedmap()) {
        setdvar("ui_blocksaves", "0");
    } else {
        setdvar("ui_blocksaves", "1");
    }
    str_movie = getmapintromovie(level.next_map);
    if (isdefined(str_movie)) {
        switchmap_setloadingmovie(str_movie);
    }
    switchmap_load(level.next_map);
    wait 1;
    foreach (e_player in level.players) {
        e_player globallogic_player::function_4cef9872(getrootmapname(level.next_map));
    }
    setdvar("cp_queued_level", "");
    switchmap_switch();
}

// Namespace safehouse
// Params 2, eflags: 0x4
// Checksum 0xdbee90ea, Offset: 0x5260
// Size: 0x2a
function private function_2c4da22(delay, var_c2dc2b72) {
    wait delay;
    self closeluimenu(var_c2dc2b72);
}

// Namespace safehouse
// Params 1, eflags: 0x0
// Checksum 0x754c642b, Offset: 0x5298
// Size: 0x8b
function function_6d71dab7(levelname) {
    switch (levelname) {
    case "cp_mi_cairo_infection":
    case "cp_mi_cairo_infection2":
    case "cp_mi_cairo_infection3":
        return "infection";
    case "cp_mi_cairo_lotus":
    case "cp_mi_cairo_lotus2":
    case "cp_mi_cairo_lotus3":
        return "lotus";
    case "cp_mi_cairo_ramses":
    case "cp_mi_cairo_ramses2":
        return "ramses";
    case "cp_mi_sing_biodomes":
    case "cp_mi_sing_biodomes2":
        return "biodomes";
    }
    return levelname;
}

// Namespace safehouse
// Params 1, eflags: 0x0
// Checksum 0xcfa1b6f8, Offset: 0x5330
// Size: 0x204
function function_109cf997(menuname) {
    if (!isdefined(menuname)) {
        InvalidOpCode(0x54, "menu_changeclass");
        // Unknown operator (0x54, t7_1b, PC)
    }
    self.var_3ae8773c = 1;
    self.var_8201758a = undefined;
    self clientfield::set_player_uimodel("hudItems.cybercoreSelectMenuDisabled", 0);
    if (level.next_map == "cp_mi_zurich_newworld" || menuname != "chooseClass_TrainingSim" && level.next_map == "cp_mi_eth_prologue") {
        var_6a7a1c33 = self getdstat("PlayerStatsByMap", level.next_map, "hasBeenCompleted");
        if (!var_6a7a1c33) {
            self clientfield::set_player_uimodel("hudItems.cybercoreSelectMenuDisabled", 1);
        }
    }
    if (menuname === "chooseClass_TrainingSim") {
        lui_menu = self openluimenu(menuname);
    } else {
        lui_menu = self openmenu(menuname);
    }
    var_17b2131d = 1;
    while (true) {
        self waittill(#"menuresponse", menu, response);
        if (menu == menuname) {
            if (response == "cancel") {
                var_17b2131d = 0;
            } else {
                var_de6a4e4f = self loadout::getclasschoice(response);
                if (menuname == "chooseClass_TrainingSim") {
                    self.var_8201758a = 1;
                    self util::waittill_any_timeout(7, "loadout_changed");
                }
                self flag::wait_till_clear("loadout_dirty");
                function_5b426a60(var_de6a4e4f);
                if (menuname == "chooseClass_TrainingSim") {
                    self closemenu(menuname);
                }
            }
            break;
        }
    }
    self thread function_a20a5ae3();
    return var_17b2131d;
}

// Namespace safehouse
// Params 1, eflags: 0x0
// Checksum 0x2f2af8fd, Offset: 0x5540
// Size: 0x62
function function_5b426a60(var_de6a4e4f) {
    self savegame::set_player_data("playerClass", var_de6a4e4f);
    self loadout::setclass(var_de6a4e4f);
    self.tag_stowed_back = undefined;
    self.tag_stowed_hip = undefined;
    self loadout::giveloadout(self.pers["team"], var_de6a4e4f);
}

// Namespace safehouse
// Params 0, eflags: 0x0
// Checksum 0x7d61881c, Offset: 0x55b0
// Size: 0x1a
function function_a20a5ae3() {
    self endon(#"death");
    wait 0.05;
    self.var_3ae8773c = 0;
}

// Namespace safehouse
// Params 1, eflags: 0x4
// Checksum 0x40bf8b7f, Offset: 0x55d8
// Size: 0x1a
function private function_431ca329(player) {
    player function_3361cf6a();
}

// Namespace safehouse
// Params 0, eflags: 0x4
// Checksum 0x46094812, Offset: 0x5600
// Size: 0x5c2
function private function_3361cf6a() {
    level endon(#"all_players_ready");
    self endon(#"disconnect");
    if (self ishost() && level.next_map == savegame_getsavedmap()) {
        lui_menu = self openluimenu("OverwriteProgressWarning");
        player::allow_stance_change(0);
        self freezecontrols(1);
        var_4a0f7886 = 1;
        while (true) {
            self waittill(#"menuresponse", menu, response);
            if (menu == "OverwriteProgressWarning") {
                if (response == "cancel") {
                    var_4a0f7886 = 0;
                }
                break;
            }
        }
        self closeluimenu(lui_menu);
        self freezecontrols(0);
        self util::delay(0.5, "disconnect", &player::allow_stance_change, 1);
        if (!var_4a0f7886) {
            return;
        }
    }
    if (true) {
        level.var_f0ba161d function_e04cba0f();
        self util::delay(2, undefined, &lui::screen_fade_out, 0.2);
        s_bundle = struct::get("scene_enter_readyroom", "targetname");
        camanimscripted(self, s_bundle.script_string, gettime(), s_bundle.origin, s_bundle.angles);
        s_bundle scene::play(self);
        level.var_f0ba161d function_a8271940();
    } else {
        self.var_16b21c9 = self.origin;
        self.var_1b4f3317 = self getplayerangles();
        self hide();
        level.var_f0ba161d function_e04cba0f(self);
        fade_out();
    }
    self thread function_7a07bdbf();
    if (self.musicplaying === 1) {
        function_f97da4(self);
    }
    if (function_109cf997()) {
        function_a0cce87c();
        self util::show_hud(0);
        var_3a62bf5d = self openluimenu("MissionOverviewScreen");
        self setluimenudata(var_3a62bf5d, "showMissionOverview", 1);
        self setluimenudata(var_3a62bf5d, "showMissionSelect", 0);
        while (true) {
            self waittill(#"menuresponse", menu, response);
            if (menu == "MissionRecordVaultMenu" && response == "closed") {
                break;
            }
        }
        fade_out();
        while (level flag::get("player_exiting_ready_room")) {
            wait 0.05;
        }
        level flag::set("player_exiting_ready_room");
        self thread function_390094e6();
        self scene::stop();
        self closeluimenu(var_3a62bf5d);
        self util::show_hud(1);
        self notify(#"left_ready_room");
        self flag::clear("in_ready_room");
        level.n_players_ready--;
        level notify(#"hash_a35e1275");
        self function_f4851bfc();
        endcamanimscripted(self);
    }
    if (isdefined(level.var_58373e3b)) {
        [[ level.var_f3db725a ]]();
    }
    if (true) {
        level.var_f0ba161d function_e04cba0f();
        self thread function_390094e6();
        s_bundle = struct::get("scene_exit_readyroom", "targetname");
        s_bundle scene::init(self);
        wait 0.3;
        fade_in(0.3);
        camanimscripted(self, s_bundle.script_string, gettime(), s_bundle.origin, s_bundle.angles);
        s_bundle scene::play(self);
        endcamanimscripted(self);
        level.var_f0ba161d function_a8271940();
    } else {
        if (isdefined(self.var_16b21c9)) {
            fade_out();
            self setorigin(self.var_16b21c9);
            self setplayerangles(self.var_1b4f3317);
        } else {
            function_c2bd8252();
        }
        fade_in(0.3);
        level.var_f0ba161d function_a8271940(self);
    }
    level flag::clear("player_exiting_ready_room");
}

// Namespace safehouse
// Params 1, eflags: 0x0
// Checksum 0x68dd4cb4, Offset: 0x5bd0
// Size: 0x272
function function_a0cce87c(b_first_time) {
    if (!isdefined(b_first_time)) {
        b_first_time = 0;
    }
    self endon(#"disconnect");
    self endon(#"left_ready_room");
    level endon(#"all_players_ready");
    self flag::set("in_ready_room");
    level.n_players_ready++;
    fade_out(0);
    if (isdefined(level.var_8ea79b65)) {
        [[ level.var_8ea79b65 ]]();
    }
    self function_9152f342();
    if (!b_first_time) {
        if (!getdvarint("scr_safehouse_test", 0)) {
            level notify(#"hash_a35e1275");
            waittillframeend();
        }
    }
    while (level flag::get("player_entering_ready_room")) {
        wait 0.05;
    }
    level flag::set("player_entering_ready_room");
    self function_54a3b25a();
    self show();
    fade_in();
    var_4ebceea0 = level.var_45f1e4ac[self.var_8d3631f4].var_b156618f;
    s_scene = struct::get_script_bundle("scene", var_4ebceea0);
    align = scene::get_existing_ent(s_scene.aligntarget, 0, 1);
    foreach (player in level.activeplayers) {
        if (player flag::get("in_ready_room")) {
            camanimscripted(player, s_scene.cameraswitcher, gettime(), align.origin, align.angles);
        }
    }
    self scene::play(level.var_45f1e4ac[self.var_8d3631f4].var_1fffaf0, self);
    level flag::clear("player_entering_ready_room");
    self thread function_3495bf85();
}

// Namespace safehouse
// Params 0, eflags: 0x0
// Checksum 0x2b57efd8, Offset: 0x5e50
// Size: 0x5f
function function_6eee8df0() {
    while (true) {
        level waittill(#"hash_a35e1275");
        if (level.n_players_ready == getlobbyclientcount()) {
            level thread function_56c8845e();
            level thread lui::screen_fade_out(0);
            level flag::set("all_players_ready");
            return;
        }
    }
}

// Namespace safehouse
// Params 0, eflags: 0x0
// Checksum 0x301c2df5, Offset: 0x5eb8
// Size: 0x1ab
function function_3495bf85() {
    self endon(#"disconnect");
    self endon(#"left_ready_room");
    level endon(#"all_players_ready");
    self thread scene::play(level.var_45f1e4ac[self.var_8d3631f4].str_player_scene, self);
    for (var_6347c9e0 = 0; true; var_6347c9e0 = 0) {
        level flag::wait_till_clear("player_entering_ready_room");
        var_4ebceea0 = level.var_45f1e4ac[self.var_8d3631f4].var_18762b00[var_6347c9e0];
        s_scene = struct::get_script_bundle("scene", var_4ebceea0);
        align = scene::get_existing_ent(s_scene.aligntarget, 0, 1);
        camanimscripted(self, s_scene.cameraswitcher, gettime(), align.origin, align.angles);
        n_time = getcamanimtime(var_4ebceea0);
        if (n_time < 0.05) {
            n_time = 5;
        } else {
            n_time /= 0.05;
            n_time += 0.0001;
            n_time = floor(n_time);
            n_time *= 0.05;
        }
        level flag::wait_till_timeout(n_time, "player_entering_ready_room");
        var_6347c9e0++;
        if (var_6347c9e0 == level.var_45f1e4ac[self.var_8d3631f4].var_18762b00.size) {
        }
    }
}

// Namespace safehouse
// Params 0, eflags: 0x0
// Checksum 0xa11a6a4, Offset: 0x6070
// Size: 0x61
function function_769e64f9() {
    for (i = 1; i <= 4; i++) {
        var_12aba86 = getent("player_" + i + "_sidearm", "targetname");
        if (isdefined(var_12aba86)) {
            var_12aba86 hide();
        }
    }
}

// Namespace safehouse
// Params 0, eflags: 0x0
// Checksum 0x2b93855f, Offset: 0x60e0
// Size: 0x8b
function function_54a3b25a() {
    foreach (player in level.activeplayers) {
        if (player != self) {
            var_c10220c5 = self.clientid;
            player luinotifyevent(%comms_event_message, 2, %CP_SH_CAIRO_PLAYER_READY, var_c10220c5);
        }
    }
}

// Namespace safehouse
// Params 0, eflags: 0x0
// Checksum 0x7a6a3501, Offset: 0x6178
// Size: 0x317
function function_ca93dc45() {
    level.var_45f1e4ac[0] = spawnstruct();
    level.var_45f1e4ac[0].b_occupied = 0;
    level.var_45f1e4ac[0].str_player_scene = "cin_saf_ram_readyroom_3rd_pre100_player01";
    level.var_45f1e4ac[0].var_1fffaf0 = "cin_saf_ram_readyroom_3rd_pre100_player01_enter";
    level.var_45f1e4ac[0].var_b156618f = "cin_saf_ram_readyroom_3rd_pre100_p1_entrance_cam";
    level.var_45f1e4ac[0].var_18762b00[0] = "cin_saf_ram_readyroom_3rd_pre100_p1_cam01";
    level.var_45f1e4ac[0].var_18762b00[1] = "cin_saf_ram_readyroom_3rd_pre100_p1_cam02";
    level.var_45f1e4ac[0].var_18762b00[2] = "cin_saf_ram_readyroom_3rd_pre100_p1_cam03";
    level.var_45f1e4ac[1] = spawnstruct();
    level.var_45f1e4ac[1].b_occupied = 0;
    level.var_45f1e4ac[1].str_player_scene = "cin_saf_ram_readyroom_3rd_pre100_player02";
    level.var_45f1e4ac[1].var_1fffaf0 = "cin_saf_ram_readyroom_3rd_pre100_player02_enter";
    level.var_45f1e4ac[1].var_b156618f = "cin_saf_ram_readyroom_3rd_pre100_p2_entrance_cam";
    level.var_45f1e4ac[1].var_18762b00[0] = "cin_saf_ram_readyroom_3rd_pre100_p2_cam01";
    level.var_45f1e4ac[1].var_18762b00[1] = "cin_saf_ram_readyroom_3rd_pre100_p2_cam02";
    level.var_45f1e4ac[1].var_18762b00[2] = "cin_saf_ram_readyroom_3rd_pre100_p2_cam03";
    level.var_45f1e4ac[2] = spawnstruct();
    level.var_45f1e4ac[2].b_occupied = 0;
    level.var_45f1e4ac[2].str_player_scene = "cin_saf_ram_readyroom_3rd_pre100_player03";
    level.var_45f1e4ac[2].var_1fffaf0 = "cin_saf_ram_readyroom_3rd_pre100_player03_enter";
    level.var_45f1e4ac[2].var_b156618f = "cin_saf_ram_readyroom_3rd_pre100_p3_entrance_cam";
    level.var_45f1e4ac[2].var_18762b00[0] = "cin_saf_ram_readyroom_3rd_pre100_p3_cam01";
    level.var_45f1e4ac[2].var_18762b00[1] = "cin_saf_ram_readyroom_3rd_pre100_p3_cam02";
    level.var_45f1e4ac[2].var_18762b00[2] = "cin_saf_ram_readyroom_3rd_pre100_p3_cam03";
    level.var_45f1e4ac[3] = spawnstruct();
    level.var_45f1e4ac[3].b_occupied = 0;
    level.var_45f1e4ac[3].str_player_scene = "cin_saf_ram_readyroom_3rd_pre100_player04";
    level.var_45f1e4ac[3].var_1fffaf0 = "cin_saf_ram_readyroom_3rd_pre100_player04_enter";
    level.var_45f1e4ac[3].var_b156618f = "cin_saf_ram_readyroom_3rd_pre100_p4_entrance_cam";
    level.var_45f1e4ac[3].var_18762b00[0] = "cin_saf_ram_readyroom_3rd_pre100_p4_cam01";
    level.var_45f1e4ac[3].var_18762b00[1] = "cin_saf_ram_readyroom_3rd_pre100_p4_cam02";
    level.var_45f1e4ac[3].var_18762b00[2] = "cin_saf_ram_readyroom_3rd_pre100_p4_cam03";
}

// Namespace safehouse
// Params 0, eflags: 0x0
// Checksum 0x707cf2f, Offset: 0x6498
// Size: 0xcb
function function_9152f342() {
    if (getdvarint("scr_safehouse_test", 0)) {
        if (!isdefined(level.var_f2db68b2)) {
            level.var_f2db68b2 = 0;
        } else {
            level.var_f2db68b2++;
            if (level.var_f2db68b2 == level.var_45f1e4ac.size) {
                level.var_f2db68b2 = 0;
            }
        }
        self.var_8d3631f4 = level.var_f2db68b2;
        return level.var_f2db68b2;
    }
    for (n_index = 0; n_index < level.var_45f1e4ac.size; n_index++) {
        if (level.var_45f1e4ac[n_index].b_occupied == 0) {
            level.var_45f1e4ac[n_index].b_occupied = 1;
            self.var_8d3631f4 = n_index;
            return n_index;
        }
    }
}

// Namespace safehouse
// Params 0, eflags: 0x0
// Checksum 0x7d06b6e, Offset: 0x6570
// Size: 0x21
function function_f4851bfc() {
    level.var_45f1e4ac[self.var_8d3631f4].b_occupied = 0;
    self.var_8d3631f4 = undefined;
}

// Namespace safehouse
// Params 0, eflags: 0x0
// Checksum 0x5240b670, Offset: 0x65a0
// Size: 0x402
function function_43e79c92() {
    level.rooms = [];
    for (n_player_index = 0; n_player_index < 4; n_player_index++) {
        level.rooms[n_player_index] = spawnstruct();
        level.rooms[n_player_index].b_claimed = 0;
        var_14f1f567 = getentarray("player_bunk_" + n_player_index, "targetname");
        foreach (var_6e887f87 in var_14f1f567) {
            switch (var_6e887f87.script_noteworthy) {
            case "data_vault":
                level.rooms[n_player_index].var_9860be12 = var_6e887f87;
                level.rooms[n_player_index].var_71dcdd3e = function_a8960cf7(var_6e887f87, %cp_safehouse_data_vault, %CP_SH_CAIRO_DATA_VAULT2, &function_18e7bb4a, 0);
                level.rooms[n_player_index].var_71dcdd3e.n_player_index = n_player_index;
                level.rooms[n_player_index].var_71dcdd3e function_e04cba0f();
                break;
            case "wardrobe":
                level.rooms[n_player_index].var_4090852 = var_6e887f87;
                level.rooms[n_player_index].var_a0711246 = function_a8960cf7(var_6e887f87, %cp_safehouse_wardrobe, %CP_SH_CAIRO_WARDROBE2, &function_e2d08944, 0);
                level.rooms[n_player_index].var_a0711246.n_player_index = n_player_index;
                level.rooms[n_player_index].var_a0711246 function_e04cba0f();
                break;
            case "foot_locker":
                level.rooms[n_player_index].var_28e7a252 = var_6e887f87;
                level.rooms[n_player_index].var_6caeba6e = function_a8960cf7(var_6e887f87, %cp_safehouse_collectibles, %CP_SH_CAIRO_COLLECTIBLES2, &function_1f7af538, 1);
                level.rooms[n_player_index].var_6caeba6e.n_player_index = n_player_index;
                level.rooms[n_player_index].var_6caeba6e function_e04cba0f();
                break;
            case "medal_case":
                level.rooms[n_player_index].var_b8276d03 = var_6e887f87;
                level.rooms[n_player_index].var_46f52946 = function_a8960cf7(var_6e887f87, %cp_safehouse_medal_case, %CP_SH_CAIRO_MEDAL_CASE2, &function_7e1ee6bb, 1);
                level.rooms[n_player_index].var_46f52946.n_player_index = n_player_index;
                level.rooms[n_player_index].var_46f52946 function_e04cba0f();
                break;
            case "bunk_volume":
                level.rooms[n_player_index].e_volume = var_6e887f87;
                break;
            case "bunk_door_clip":
                level.rooms[n_player_index].var_ac769486 = var_6e887f87;
                break;
            }
        }
    }
    level.t_mission_vault = getent("t_mission_vault", "targetname");
    function_a8960cf7(level.t_mission_vault, %cp_safehouse_mission_data, %CP_SH_CAIRO_MISSION_DATA2, &function_495a58b6, 1);
}

// Namespace safehouse
// Params 0, eflags: 0x0
// Checksum 0x40547622, Offset: 0x69b0
// Size: 0x42
function function_ed174df5() {
    level thread function_5454cdd2();
    level thread function_d38001d0();
    level thread function_9c8f7a4d();
    level thread function_2b0247d1();
}

// Namespace safehouse
// Params 0, eflags: 0x0
// Checksum 0x4e3a8fd9, Offset: 0x6a00
// Size: 0xb5
function function_5454cdd2() {
    thread function_980a453e();
    a_str_scenes[0] = "p7_fxanim_gp_3d_printer_object01_01_bundle";
    a_str_scenes[1] = "p7_fxanim_gp_3d_printer_object01_02_bundle";
    a_str_scenes[2] = "p7_fxanim_gp_3d_printer_object01_03_bundle";
    var_8aa9ef07 = getent("printer", "targetname");
    while (true) {
        a_str_scenes = array::randomize(a_str_scenes);
        for (i = 0; i < a_str_scenes.size; i++) {
            var_8aa9ef07 scene::play(a_str_scenes[i]);
        }
    }
}

// Namespace safehouse
// Params 0, eflags: 0x0
// Checksum 0x32a1c4e6, Offset: 0x6ac0
// Size: 0x8a
function function_980a453e() {
    t_printer = getent("t_printer", "targetname");
    if (isdefined(t_printer)) {
        if (sessionmodeisonlinegame()) {
            function_a8960cf7(t_printer, %cp_safehouse_printer, %CP_SH_CAIRO_PRINTER2, &function_d116f488, 1);
            return;
        }
        t_printer delete();
    }
}

// Namespace safehouse
// Params 0, eflags: 0x0
// Checksum 0x9c980fb0, Offset: 0x6b58
// Size: 0x52
function function_2fad03f() {
    var_f531e9c8 = self decorations::function_7006b9ad();
    var_5b1e85ea = self decorations::function_45ddfa6();
    if (var_f531e9c8 && var_5b1e85ea) {
        self givedecoration("cp_medal_all_tokens");
    }
}

// Namespace safehouse
// Params 1, eflags: 0x0
// Checksum 0x79f58f53, Offset: 0x6bb8
// Size: 0x22
function function_d116f488(player) {
    player function_711d3c1("WeaponDesigner");
}

// Namespace safehouse
// Params 0, eflags: 0x0
// Checksum 0x530654bd, Offset: 0x6be8
// Size: 0xb5
function function_2b0247d1() {
    thread function_36069a7();
    a_str_scenes[0] = "p7_fxanim_gp_robot_arm_doctor_01_bundle";
    a_str_scenes[1] = "p7_fxanim_gp_robot_arm_doctor_02_bundle";
    a_str_scenes[2] = "p7_fxanim_gp_robot_arm_doctor_03_bundle";
    var_ecf502d = getent("arm_doctor", "targetname");
    while (true) {
        a_str_scenes = array::randomize(a_str_scenes);
        for (i = 0; i < a_str_scenes.size; i++) {
            var_ecf502d scene::play(a_str_scenes[i]);
        }
    }
}

// Namespace safehouse
// Params 0, eflags: 0x0
// Checksum 0xbfc76c2b, Offset: 0x6ca8
// Size: 0x62
function function_36069a7() {
    t_cybercore = getent("t_cybercore", "targetname");
    if (isdefined(t_cybercore)) {
        function_a8960cf7(t_cybercore, %cp_safehouse_cybercore, %CP_SH_CAIRO_CYBERCORE2, &function_b34dec6f, 1);
    }
}

// Namespace safehouse
// Params 0, eflags: 0x0
// Checksum 0xea5545bc, Offset: 0x6d18
// Size: 0xda
function function_e17b7386() {
    self endon(#"disconnect");
    if (!self flag::exists("cybercom_upgrade_check")) {
        self flag::init("cybercom_upgrade_check");
    }
    if (self flag::get("cybercom_upgrade_check")) {
        return;
    }
    self flag::set("cybercom_upgrade_check");
    self util::waittill_notify_or_timeout("stats_changed", 5);
    if (self decorations::function_45ddfa6()) {
        self givedecoration("cp_medal_all_cybercores");
        self function_2fad03f();
    }
    self flag::clear("cybercom_upgrade_check");
}

// Namespace safehouse
// Params 1, eflags: 0x0
// Checksum 0x64153d74, Offset: 0x6e00
// Size: 0x32
function function_b34dec6f(player) {
    player function_711d3c1("CybercoreUpgrade");
    player thread function_e17b7386();
}

// Namespace safehouse
// Params 0, eflags: 0x0
// Checksum 0x9a814448, Offset: 0x6e40
// Size: 0xb2
function function_d38001d0() {
    wait 0.05;
    var_d880a1f1 = getent("gunrack", "targetname");
    var_d880a1f1 clientfield::set("gun_rack_init", 1);
    t_gun_rack = getent("t_gun_rack", "targetname");
    function_a8960cf7(t_gun_rack, %cp_safehouse_gun_rack, %CP_SH_CAIRO_GUN_RACK2, &function_b0863559);
    t_gun_rack thread function_84b269ce();
}

// Namespace safehouse
// Params 1, eflags: 0x0
// Checksum 0x2a8dad8b, Offset: 0x6f00
// Size: 0x82
function function_b0863559(e_player) {
    e_player flag::set_val("loadout_dirty", 1);
    e_player function_711d3c1("chooseClass");
    e_player util::waittill_any_timeout(7, "loadout_changed");
    e_player flag::clear("loadout_dirty");
    e_player function_2fad03f();
}

// Namespace safehouse
// Params 1, eflags: 0x0
// Checksum 0xef1c9f18, Offset: 0x6f90
// Size: 0xd2
function function_711d3c1(menuref) {
    self endon(#"death");
    self flag::set("safehouse_menu_open");
    self hideviewmodel();
    luimenu = self openluimenu(menuref);
    level.var_ac964c36 = 0;
    do {
        self waittill(#"menuresponse", menu, response);
    } while (response != "closed");
    self showviewmodel();
    self flag::clear("safehouse_menu_open");
    self thread function_2c4da22(0.5, luimenu);
    level.var_ac964c36 = 1;
}

// Namespace safehouse
// Params 0, eflags: 0x0
// Checksum 0x63c661fd, Offset: 0x7070
// Size: 0xf5
function function_84b269ce() {
    var_2abb5b57 = 0;
    var_30399f19 = getent("gunrack", "targetname");
    while (true) {
        if (level flag::get("player_near_gun_rack") && !var_2abb5b57) {
            level clientfield::set("near_gun_rack", 1);
            var_30399f19 thread scene::play("p7_fxanim_cp_safehouse_cairo_gunrack_open_bundle");
            var_2abb5b57 = 1;
            wait 6;
        } else if (!level flag::get("player_near_gun_rack") && var_2abb5b57) {
            level clientfield::set("near_gun_rack", 0);
            var_30399f19 thread scene::play("p7_fxanim_cp_safehouse_cairo_gunrack_close_bundle");
            var_2abb5b57 = 0;
            wait 4;
        }
        wait 0.05;
    }
}

// Namespace safehouse
// Params 0, eflags: 0x0
// Checksum 0xe2a1fc2c, Offset: 0x7170
// Size: 0x42
function function_9c8f7a4d() {
    array::thread_all(getentarray("chair", "script_noteworthy"), &function_df2a7519);
}

// Namespace safehouse
// Params 0, eflags: 0x0
// Checksum 0xf9a78dbc, Offset: 0x71c0
// Size: 0x26d
function function_df2a7519() {
    self flag::init("player_in_chair");
    t_use = getent("training_trig" + self.script_int, "targetname");
    t_use usetriggerrequirelookat();
    t_proximity = spawn("trigger_radius", self.origin, 0, -106, -128);
    prompt = function_a8960cf7(t_use, %cp_safehouse_training, %CP_SH_CAIRO_TRAINING2, &function_fda1c8b5);
    prompt.var_524f5f14 = self;
    self.var_10c03d0c = 0;
    while (true) {
        self flag::wait_till_clear("player_in_chair");
        prompt function_a8271940();
        var_df983850 = 0;
        foreach (e_player in level.players) {
            if (e_player istouching(t_proximity) && e_player util::is_player_looking_at(self.origin, 0.5, 0)) {
                var_df983850 = 1;
            }
        }
        if (var_df983850 && !self.var_10c03d0c) {
            self scene::play("p7_fxanim_cp_safehouse_chair_console_" + self.script_int + "_open_bundle");
            self.var_10c03d0c = 1;
            t_use setvisibletoall();
        } else if (!var_df983850 && self.var_10c03d0c) {
            t_use setinvisibletoall();
            self scene::play("p7_fxanim_cp_safehouse_chair_console_" + self.script_int + "_close_bundle");
            self.var_10c03d0c = 0;
        }
        wait 0.05;
    }
}

// Namespace safehouse
// Params 1, eflags: 0x0
// Checksum 0x937da523, Offset: 0x7438
// Size: 0x1b2
function function_fda1c8b5(e_player) {
    str_dir = "left";
    if (self.var_524f5f14.script_int < 3) {
        str_dir = "right";
    }
    level.var_f0ba161d function_e04cba0f(e_player);
    objectives::hide("cp_safehouse_ready_room", e_player);
    e_player.var_597c2939 = self.var_524f5f14;
    e_player.var_8ea3df31 = str_dir;
    self.var_524f5f14.prompt = self;
    self.var_524f5f14 flag::set("player_in_chair");
    self function_e04cba0f();
    self.var_524f5f14 scene::play("cin_saf_ram_training_1st_getin_" + str_dir, e_player);
    level clientfield::set("toggle_console_" + self.var_524f5f14.script_int, 1);
    self.var_524f5f14 scene::play("p7_fxanim_cp_safehouse_chair_console_" + self.var_524f5f14.script_int + "_close_bundle");
    self.var_524f5f14.var_10c03d0c = 0;
    e_player lui::screen_fade_out(0.6, "black");
    e_player.var_67b6f3d0 = e_player.curclass;
    e_player lui::screen_fade_in(0, "black");
    e_player thread function_ecca1245();
}

// Namespace safehouse
// Params 0, eflags: 0x0
// Checksum 0x6f9c0a48, Offset: 0x75f8
// Size: 0x192
function function_ecca1245() {
    self endon(#"disconnect");
    w_player = self getcurrentweapon();
    self flag::set("in_training_sim");
    self thread lui::screen_fade_in(0, "black");
    if (self function_109cf997("chooseClass_TrainingSim")) {
        self thread lui::screen_fade_out(0, "white");
        self globallogic_player::function_4cef9872(getrootmapname());
        self.var_597c2939 function_29532574(self, self.var_8ea3df31, w_player);
        self clientfield::set_player_uimodel("safehouse.inTrainingSim", 1);
        self function_c550ee23(self.var_597c2939.script_int);
        return;
    }
    self closemenu("chooseClass_TrainingSim");
    self closemenu("FullBlack");
    self thread lui::screen_fade_in(1, "black");
    self function_6ebf2134();
    if (isalive(self)) {
        self flag::clear("in_training_sim");
    }
}

// Namespace safehouse
// Params 0, eflags: 0x0
// Checksum 0x4c11b448, Offset: 0x7798
// Size: 0xa2
function function_1a70861a() {
    self endon(#"disconnect");
    self.var_597c2939 thread scene::play("cin_saf_ram_training_1st_sit_" + self.var_8ea3df31, self);
    wait 0.05;
    self.training_dummy delete();
    self.var_f5434f17 delete();
    namespace_c550ee23::function_3206b93a();
    self closemenu("FullBlack");
    self thread function_ecca1245();
}

// Namespace safehouse
// Params 0, eflags: 0x0
// Checksum 0x760e2cf5, Offset: 0x7848
// Size: 0xba
function function_680cf465() {
    if (isdefined(self.var_597c2939)) {
        self.var_597c2939.prompt function_a8271940();
        self.var_597c2939.var_10c03d0c = 1;
        self.var_597c2939 flag::clear("player_in_chair");
        level clientfield::set("toggle_console_" + self.var_597c2939.script_int, 0);
    }
    if (isdefined(self.training_dummy)) {
        self.training_dummy delete();
        self.var_f5434f17 delete();
    }
}

// Namespace safehouse
// Params 0, eflags: 0x0
// Checksum 0x14d5ff59, Offset: 0x7910
// Size: 0x112
function function_6ebf2134() {
    function_5b426a60(self.var_67b6f3d0);
    self.var_597c2939 scene::play("p7_fxanim_cp_safehouse_chair_console_" + self.var_597c2939.script_int + "_open_bundle");
    self.var_597c2939 scene::play("cin_saf_ram_training_1st_getout_" + self.var_8ea3df31, self);
    self clientfield::set_player_uimodel("safehouse.inTrainingSim", 0);
    self function_680cf465();
    wait 1;
    var_4fb0aa1e = self getluimenu("MissionRecordVaultScreens");
    if (!isdefined(var_4fb0aa1e)) {
        self openluimenu("MissionRecordVaultScreens");
    }
    level.var_f0ba161d function_a8271940(self);
    objectives::show("cp_safehouse_ready_room", self);
}

// Namespace safehouse
// Params 3, eflags: 0x0
// Checksum 0xb05c4358, Offset: 0x7a30
// Size: 0x13a
function function_29532574(e_player, str_dir, w_player) {
    e_player.training_dummy = util::spawn_player_clone(e_player);
    e_player.training_dummy clientfield::set("player_clone", 1);
    e_player.var_f5434f17 = util::spawn_model("tag_origin", e_player.training_dummy gettagorigin("tag_weapon_right"), e_player.training_dummy gettagangles("tag_weapon_right"));
    e_player.var_f5434f17 useweaponmodel(w_player, w_player.worldmodel, e_player getweaponoptions(w_player));
    e_player.var_f5434f17 linkto(e_player.training_dummy, "tag_weapon_right");
    self thread scene::play("cin_saf_ram_training_1st_sit_fake_" + str_dir, e_player.training_dummy);
}

// Namespace safehouse
// Params 1, eflags: 0x0
// Checksum 0xe72be575, Offset: 0x7b78
// Size: 0x152
function function_c550ee23(n_num) {
    self endon(#"disconnect");
    var_4fb0aa1e = self getluimenu("MissionRecordVaultScreens");
    if (isdefined(var_4fb0aa1e)) {
        self closeluimenu(var_4fb0aa1e);
    }
    util::wait_network_frame();
    self thread function_d850faa0(n_num);
    self closemenu("FullBlack");
    namespace_c550ee23::run("training_sim_" + n_num);
    var_bc7395fb = 1;
    if (!isalive(self)) {
        var_bc7395fb = 0;
        self util::waittill_either("cp_deathcam_ended", "spawned");
    }
    self openmenu("FullBlack");
    /#
        while (self isinmovemode("<dev string:x9c>", "<dev string:xa0>")) {
            wait 0.05;
        }
    #/
    if (var_bc7395fb) {
        function_b11df48f();
        self thread function_1a70861a();
    }
}

// Namespace safehouse
// Params 1, eflags: 0x0
// Checksum 0xa7ed9c7c, Offset: 0x7cd8
// Size: 0x212
function function_d850faa0(n_num) {
    self waittill(#"hash_ce89933d");
    v_org = self localtoworldcoords((-45, -15, 60));
    var_9012dd1e = util::spawn_model("tag_origin", v_org, combineangles(self.angles, (-10, 5, 0)));
    var_9012dd1e linkto(self);
    hidemiscmodels("training_sim_extracam_screen_off" + n_num);
    showmiscmodels("training_sim_extracam_screen_on" + n_num);
    function_f7f318a5(n_num, 1);
    while (isdefined(self.var_24c69c09) && isdefined(self) && self.var_24c69c09) {
        var_4f93c6de = 0;
        foreach (player in level.activeplayers) {
            if (player != self && !(isdefined(player.var_24c69c09) && player.var_24c69c09)) {
                var_4f93c6de = 1;
                break;
            }
        }
        var_9012dd1e clientfield::set("training_sim_extracam", var_4f93c6de ? n_num : 0);
        util::wait_network_frame();
    }
    var_9012dd1e clientfield::set("training_sim_extracam", 0);
    function_f7f318a5(n_num, 0);
    util::wait_network_frame();
    var_9012dd1e delete();
    hidemiscmodels("training_sim_extracam_screen_on" + n_num);
    showmiscmodels("training_sim_extracam_screen_off" + n_num);
}

// Namespace safehouse
// Params 2, eflags: 0x0
// Checksum 0x79126343, Offset: 0x7ef8
// Size: 0xf7
function function_f7f318a5(n_num, b_on) {
    level.var_b57a1b14[n_num] = b_on;
    var_fa621f28 = [];
    var_fa621f28[1] = 0;
    var_fa621f28[2] = 0;
    var_fa621f28[3] = 0;
    var_fa621f28[4] = 0;
    for (monitor = 1; monitor <= 4; monitor++) {
        for (cam = 1; cam <= 4; cam++) {
            if (isdefined(level.var_b57a1b14[cam]) && level.var_b57a1b14[cam] && !(isdefined(var_fa621f28[monitor]) && var_fa621f28[monitor])) {
                showmiscmodels("wall_extracam" + monitor + cam);
                var_fa621f28[monitor] = 1;
                continue;
            }
            hidemiscmodels("wall_extracam" + monitor + cam);
        }
    }
}

// Namespace safehouse
// Params 1, eflags: 0x0
// Checksum 0x827671f1, Offset: 0x7ff8
// Size: 0x226
function function_1f7af538(player) {
    player endon(#"death");
    player clientfield::set_player_uimodel("safehouse.inClientBunk", self.trigger.e_owner getentitynumber());
    player function_2cc92070();
    s_chest = function_342806c6("scriptbundle_collectibles", "script_noteworthy", self.n_player_index);
    if (isdefined(s_chest)) {
        if (!isdefined(s_chest.b_open)) {
            s_chest.b_open = 0;
        }
        if (!isdefined(s_chest.var_78c06f4d)) {
            s_chest.var_78c06f4d = 0;
        }
        s_chest.b_open++;
        s_chest thread close_locker(player);
        if (s_chest.b_open == 1) {
            while (s_chest.var_78c06f4d) {
                s_chest waittill(#"closed");
            }
            s_chest scene::play();
        }
    }
    self.trigger setinvisibletoplayer(player);
    menu_name = undefined;
    if (player === self.trigger.e_owner) {
        menu_name = "BrowseCollectibles";
    } else {
        menu_name = "InspectingCollectibles";
    }
    player openluimenu(menu_name);
    player util::show_hud(0);
    level.var_ac964c36 = 0;
    do {
        player waittill(#"menuresponse", menu, response);
    } while (menu != menu_name && response != "closed");
    player util::show_hud(1);
    self.trigger setvisibletoplayer(player);
    player function_24f12dbc();
    player notify(#"close_locker");
    level.var_ac964c36 = 1;
}

// Namespace safehouse
// Params 1, eflags: 0x0
// Checksum 0x4f38d46a, Offset: 0x8228
// Size: 0x4a
function function_a35cc107(a_ents) {
    while (self.b_open) {
        self waittill(#"close");
    }
    self.var_78c06f4d = 1;
    self scene::play("p7_fxanim_cp_safehouse_crates_plastic_tech_close_bundle", a_ents);
}

// Namespace safehouse
// Params 1, eflags: 0x0
// Checksum 0x2ba2bea6, Offset: 0x8280
// Size: 0x32
function function_6ca97001(a_ents) {
    self.var_78c06f4d = 0;
    self notify(#"closed");
    self scene::init("p7_fxanim_cp_safehouse_crates_plastic_tech_bundle");
}

// Namespace safehouse
// Params 1, eflags: 0x0
// Checksum 0x1749da68, Offset: 0x82c0
// Size: 0x47
function close_locker(player) {
    player util::waittill_either("death", "close_locker");
    self.b_open--;
    if (self.b_open == 0) {
        self notify(#"close");
    }
}

// Namespace safehouse
// Params 1, eflags: 0x0
// Checksum 0xb4d00a66, Offset: 0x8310
// Size: 0x10a
function function_7e1ee6bb(player) {
    self.trigger endon(#"death");
    self.trigger triggerenable(0);
    self function_e04cba0f();
    player openluimenu("InspectMedalCase");
    player util::show_hud(0);
    level.var_ac964c36 = 0;
    player function_2cc92070();
    do {
        player waittill(#"menuresponse", menu, response);
    } while (menu != "InspectMedalCase" && response != "closed");
    player function_24f12dbc();
    self.trigger triggerenable(1);
    player util::show_hud(1);
    self function_a8271940();
    level.var_ac964c36 = 1;
}

// Namespace safehouse
// Params 1, eflags: 0x0
// Checksum 0x87316231, Offset: 0x8428
// Size: 0x8a
function function_495a58b6(player) {
    self.trigger setinvisibletoplayer(player);
    player hideviewmodel();
    player function_2cc92070();
    player function_c26d52c3();
    self.trigger setvisibletoplayer(player);
    player showviewmodel();
    player function_24f12dbc();
}

// Namespace safehouse
// Params 0, eflags: 0x0
// Checksum 0x463d7062, Offset: 0x84c0
// Size: 0x4b
function function_c26d52c3() {
    var_c2dc2b72 = self openluimenu("MissionRecordVaultMenu");
    self util::show_hud(0);
    level.var_ac964c36 = 0;
    InvalidOpCode(0xc9);
    // Unknown operator (0xc9, t7_1b, PC)
}

// Namespace safehouse
// Params 0, eflags: 0x0
// Checksum 0x5c26f4c5, Offset: 0x85f0
// Size: 0x1a
function function_3374f9fe() {
    level waittill(#"switchmap_preload_finished");
    switchmap_switch();
}

// Namespace safehouse
// Params 1, eflags: 0x0
// Checksum 0x94f09a7, Offset: 0x8618
// Size: 0x9a
function function_f97da4(player) {
    if (!isdefined(player)) {
        return;
    }
    player setcontrolleruimodelvalue("MusicPlayer.state", "stop");
    player notify(#"hash_fb4d907d");
    player.musicplaying = 0;
    if (isdefined(player.var_c6ff6155)) {
        alias = tablelookupcolumnforrow("gamedata/tables/common/music_player.csv", player.var_c6ff6155, 0);
        player stopsound(alias);
    }
}

// Namespace safehouse
// Params 2, eflags: 0x0
// Checksum 0xfbb62f6a, Offset: 0x86c0
// Size: 0x20a
function function_648c6218(player, var_d60677e0) {
    if (!isdefined(var_d60677e0)) {
        var_d60677e0 = 0;
    }
    if (!isdefined(player.var_c6ff6155)) {
        player.var_c6ff6155 = 0;
    }
    var_ccb4b066 = tablelookuprowcount("gamedata/tables/common/music_player.csv");
    while (player.var_c6ff6155 < 0) {
        player.var_c6ff6155 += var_ccb4b066;
    }
    player.var_c6ff6155 %= var_ccb4b066;
    for (alias = tablelookupcolumnforrow("gamedata/tables/common/music_player.csv", player.var_c6ff6155, 0); !player checkifsongunlocked(alias); alias = tablelookupcolumnforrow("gamedata/tables/common/music_player.csv", player.var_c6ff6155, 0)) {
        player.var_c6ff6155 += var_d60677e0 ? -1 : 1;
        player.var_c6ff6155 %= var_ccb4b066;
    }
    title = tablelookupcolumnforrow("gamedata/tables/common/music_player.csv", player.var_c6ff6155, 1);
    artist = tablelookupcolumnforrow("gamedata/tables/common/music_player.csv", player.var_c6ff6155, 2);
    twitter = tablelookupcolumnforrow("gamedata/tables/common/music_player.csv", player.var_c6ff6155, 3);
    player setcontrolleruimodelvalue("MusicPlayer.title", title);
    player setcontrolleruimodelvalue("MusicPlayer.artist", artist);
    player setcontrolleruimodelvalue("MusicPlayer.twitter", twitter);
}

// Namespace safehouse
// Params 0, eflags: 0x0
// Checksum 0x400c4f6d, Offset: 0x88d8
// Size: 0xed
function function_2ce69251() {
    self endon(#"hash_fb4d907d");
    self endon(#"disconnect");
    while (true) {
        function_648c6218(self);
        alias = tablelookupcolumnforrow("gamedata/tables/common/music_player.csv", self.var_c6ff6155, 0);
        self setcontrolleruimodelvalue("MusicPlayer.state", "play");
        self playsoundtoplayer(alias, self);
        len = float(soundgetplaybacktime(alias)) / 1000;
        util::waittill_notify_or_timeout("music_change", len + 3);
        self stopsound(alias);
        self.var_c6ff6155 = self.var_c6ff6155 + 1;
    }
}

// Namespace safehouse
// Params 1, eflags: 0x0
// Checksum 0x1c1715f1, Offset: 0x89d0
// Size: 0x5aa
function function_18e7bb4a(player) {
    player endon(#"death");
    player hideviewmodel();
    var_162c6190 = getentarray("m_terminal_asleep", "targetname");
    var_2f902017 = getentarray("m_terminal_awake", "targetname");
    var_69c1a63b = arraygetclosest(player.origin, var_162c6190);
    var_cdc7765d = arraygetclosest(player.origin, var_2f902017);
    var_cdc7765d show();
    var_69c1a63b hide();
    var_c2dc2b72 = player openluimenu("PersonalDataVaultMenu");
    player util::show_hud(0);
    level.var_ac964c36 = 0;
    player function_2cc92070();
    function_648c6218(player);
    s_cam = struct::get("tag_align_desk_0" + self.n_player_index + 1, "targetname");
    camanimscripted(player, "c_saf_collectible_computer_in", gettime(), s_cam.origin, s_cam.angles);
    var_4f81b21 = "";
    do {
        player waittill(#"menuresponse", menu, response);
        switch (response) {
        case "doa2":
            foreach (player in getplayers()) {
                function_f97da4(player);
            }
            level thread function_973b77f9();
            switchmap_setloadingmovie("cp_doa_bo3_load_loadingmovie");
            switchmap_load("cp_doa_bo3", "doa");
            wait 8;
            switchmap_switch();
            foreach (player in getplayers()) {
                playerentnum = player getentitynumber();
                player setcharacterbodytype(0, 0);
                player setcharacterbodystyle(0);
                player setcharacterhelmetstyle(0);
            }
            break;
        case "musicTrackBack":
            if (player.musicplaying === 1) {
                player.var_c6ff6155 -= 1;
                function_648c6218(player, 1);
                player.var_c6ff6155 -= 1;
                player notify(#"music_change");
            } else {
                player.var_c6ff6155 -= 1;
                function_648c6218(player, 1);
            }
            break;
        case "musicTrackPlay":
            if (!isdefined(player.var_c6ff6155)) {
                player.var_c6ff6155 = 0;
                player.musicplaying = 0;
            }
            if (player.musicplaying === 1) {
                alias = tablelookupcolumnforrow("gamedata/tables/common/music_player.csv", player.var_c6ff6155, 0);
                player setcontrolleruimodelvalue("MusicPlayer.state", "stop");
                player stopsound(alias);
                player notify(#"hash_fb4d907d");
                player.musicplaying = 0;
                player thread function_390094e6();
            } else {
                player notify(#"hash_fb4d907d");
                player thread function_2ce69251();
                player.musicplaying = 1;
                level thread function_973b77f9(player);
            }
            break;
        case "musicTrackNext":
            if (player.musicplaying === 1) {
                player notify(#"music_change");
            } else {
                player.var_c6ff6155 += 1;
                function_648c6218(player);
            }
            break;
        }
    } while (response != "closed");
    player util::show_hud(1);
    player closeluimenu(var_c2dc2b72);
    endcamanimscripted(player);
    var_69c1a63b show();
    var_cdc7765d hide();
    player showviewmodel();
    player function_24f12dbc();
    level.var_ac964c36 = 1;
}

// Namespace safehouse
// Params 1, eflags: 0x0
// Checksum 0x4858586e, Offset: 0x8f88
// Size: 0x1be
function function_e2d08944(player) {
    player endon(#"death");
    self.trigger triggerenable(0);
    player function_2cc92070();
    level.var_f0ba161d function_e04cba0f(player);
    var_394acf93 = function_342806c6("scriptbundle_wardrobe", "script_noteworthy", self.n_player_index);
    var_394acf93 thread close_wardrobe(player);
    var_394acf93 scene::play();
    player lui::screen_fade_out(0);
    player util::delay(0.5, "disconnect", &lui::screen_fade_in, 0.5);
    player openluimenu("PersonalizeCharacter");
    player util::show_hud(0);
    level.var_ac964c36 = 0;
    do {
        player waittill(#"menuresponse", menu, response);
    } while (menu != "PersonalizeCharacter" || response != "closed");
    player resetcharactercustomization();
    player function_24f12dbc();
    self.trigger triggerenable(1);
    level.var_f0ba161d function_a8271940(player);
    player notify(#"close_wardrobe");
    level.var_ac964c36 = 1;
}

// Namespace safehouse
// Params 1, eflags: 0x0
// Checksum 0x51361ea9, Offset: 0x9150
// Size: 0x2a
function function_2cafba2(a_ents) {
    self waittill(#"close");
    self scene::play("p7_fxanim_cp_safehouse_locker_metal_barrack_close_bundle", a_ents);
}

// Namespace safehouse
// Params 1, eflags: 0x0
// Checksum 0x8677bc6d, Offset: 0x9188
// Size: 0x22
function function_ffeaa7c4(a_ents) {
    self scene::init("p7_fxanim_cp_safehouse_locker_metal_barrack_bundle");
}

// Namespace safehouse
// Params 1, eflags: 0x0
// Checksum 0xc2e98d4e, Offset: 0x91b8
// Size: 0x33
function close_wardrobe(player) {
    player util::waittill_either("death", "close_wardrobe");
    self notify(#"close");
}

// Namespace safehouse
// Params 0, eflags: 0x0
// Checksum 0x39b48ccf, Offset: 0x91f8
// Size: 0x15a
function function_c891fb17() {
    n_player = self getentitynumber();
    level.rooms[n_player].b_claimed = 1;
    level.rooms[n_player].var_28e7a252.e_owner = self;
    level.rooms[n_player].var_71dcdd3e function_a8271940(self);
    level.rooms[n_player].var_a0711246 function_a8271940(self);
    level.rooms[n_player].var_6caeba6e function_a8271940();
    level.rooms[n_player].var_46f52946 function_a8271940();
    level.rooms[n_player].var_9860be12 triggerenable(1);
    level.rooms[n_player].var_4090852 triggerenable(1);
    level.rooms[n_player].var_28e7a252 triggerenable(1);
    level.rooms[n_player].var_b8276d03 triggerenable(1);
    self thread function_e1f7d265(n_player);
}

// Namespace safehouse
// Params 1, eflags: 0x0
// Checksum 0xc98246ab, Offset: 0x9360
// Size: 0x10f
function function_e1f7d265(n_player) {
    while (true) {
        var_29c18c11 = getentarray("medals", "script_noteworthy");
        var_29c18c11 = getentarrayfromarray(var_29c18c11, "player_bunk_" + n_player, "targetname");
        a_decorations = self getdecorations(1);
        for (i = 0; i < var_29c18c11.size; i++) {
            var_889a5942 = var_29c18c11[i];
            var_292c51bd = a_decorations[i];
            if (isdefined(var_292c51bd)) {
                var_889a5942 setmodel(var_292c51bd.model);
                var_889a5942 show();
                continue;
            }
            var_889a5942 hide();
        }
        level waittill(#"decoration_awarded");
    }
}

// Namespace safehouse
// Params 0, eflags: 0x0
// Checksum 0x428973c6, Offset: 0x9478
// Size: 0x44
function function_a24e854d() {
    self endon(#"death");
    if (level.var_2e24ecad === 1) {
        return;
    }
    n_player = self getentitynumber();
    InvalidOpCode(0xc9);
    // Unknown operator (0xc9, t7_1b, PC)
}

// Namespace safehouse
// Params 0, eflags: 0x0
// Checksum 0x80f8bec7, Offset: 0x96d0
// Size: 0x1da
function function_554b2d7e() {
    n_player = self getentitynumber();
    level.rooms[n_player].var_ac769486 solid();
    foreach (e_player in level.players) {
        if (e_player != self && e_player istouching(level.rooms[n_player].e_volume)) {
            e_player thread function_c2bd8252();
        }
    }
    level.rooms[n_player].b_claimed = 0;
    level.rooms[n_player].var_28e7a252.e_owner = undefined;
    level.rooms[n_player].var_71dcdd3e function_e04cba0f();
    level.rooms[n_player].var_a0711246 function_e04cba0f();
    level.rooms[n_player].var_6caeba6e function_e04cba0f();
    level.rooms[n_player].var_46f52946 function_e04cba0f();
    var_ace72246 = getent("bunk_" + n_player + 1 + "_door", "targetname");
    if (isdefined(var_ace72246)) {
        var_ace72246 thread scene::play("p7_fxanim_cp_safehouse_door_bunk_" + n_player + 1 + "_close_bundle");
        wait 2.5;
    }
}

// Namespace safehouse
// Params 0, eflags: 0x0
// Checksum 0x7157e58b, Offset: 0x98b8
// Size: 0x3a
function function_c2bd8252() {
    self endon(#"disconnect");
    fade_out();
    player::simple_respawn();
    fade_in();
}

// Namespace safehouse
// Params 1, eflags: 0x0
// Checksum 0xb78d3433, Offset: 0x9900
// Size: 0x2a
function fade_out(n_time) {
    if (!isdefined(n_time)) {
        n_time = 0.5;
    }
    lui::screen_fade_out(n_time);
}

// Namespace safehouse
// Params 1, eflags: 0x0
// Checksum 0x5210f2ba, Offset: 0x9938
// Size: 0x32
function fade_in(n_time) {
    if (!isdefined(n_time)) {
        n_time = 0.5;
    }
    self thread lui::screen_fade_in(n_time);
}

// Namespace safehouse
// Params 0, eflags: 0x0
// Checksum 0x63dd8a59, Offset: 0x9978
// Size: 0x2a
function function_2cc92070() {
    self flag::set("interacting");
    self thread function_dd07584d();
}

// Namespace safehouse
// Params 0, eflags: 0x0
// Checksum 0xc9672b7d, Offset: 0x99b0
// Size: 0x7a
function function_dd07584d() {
    foreach (player in level.players) {
        player setinvisibletoplayer(self);
    }
    scene::init("player_inspection", self);
}

// Namespace safehouse
// Params 0, eflags: 0x0
// Checksum 0xe4e2b0b3, Offset: 0x9a38
// Size: 0x92
function function_24f12dbc() {
    foreach (player in level.players) {
        player setvisibletoplayer(self);
    }
    self thread scene::play("player_inspection", self);
    self flag::clear("interacting");
}

// Namespace safehouse
// Params 3, eflags: 0x0
// Checksum 0x5aa7f561, Offset: 0x9ad8
// Size: 0xe7
function function_6dacc745(str_value, str_key, var_27cdf02a) {
    a_return = [];
    var_9cc495a4 = struct::get_array(str_value, str_key);
    foreach (s_bundle in var_9cc495a4) {
        if (s_bundle.targetname === "player_bunk_" + var_27cdf02a) {
            if (!isdefined(a_return)) {
                a_return = [];
            } else if (!isarray(a_return)) {
                a_return = array(a_return);
            }
            a_return[a_return.size] = s_bundle;
        }
    }
    return a_return;
}

// Namespace safehouse
// Params 3, eflags: 0x0
// Checksum 0xbee1c40, Offset: 0x9bc8
// Size: 0x68
function function_342806c6(str_value, str_key, var_27cdf02a) {
    a_return = function_6dacc745(str_value, str_key, var_27cdf02a);
    assert(a_return.size < 2, "<dev string:xa7>");
    if (a_return.size == 1) {
        return a_return[0];
    }
}

// Namespace safehouse
// Params 0, eflags: 0x0
// Checksum 0x4ad0bebf, Offset: 0x9c38
// Size: 0x32
function function_390094e6() {
    self endon(#"death");
    self endon(#"disconnect");
    self endon(#"hash_3a6467f0");
    wait 2;
    music::setmusicstate("underscore", self);
}

// Namespace safehouse
// Params 1, eflags: 0x0
// Checksum 0x47704107, Offset: 0x9c78
// Size: 0xab
function function_973b77f9(dude) {
    if (isdefined(dude)) {
        dude notify(#"hash_3a6467f0");
        music::setmusicstate("none", dude);
        return;
    }
    foreach (player in level.players) {
        player notify(#"hash_3a6467f0");
        music::setmusicstate("none", player);
    }
}

// Namespace safehouse
// Params 0, eflags: 0x0
// Checksum 0x477aef06, Offset: 0x9d30
// Size: 0x1a
function function_7a07bdbf() {
    music::setmusicstate("ready_room", self);
}

// Namespace safehouse
// Params 0, eflags: 0x0
// Checksum 0x8cbf7789, Offset: 0x9d58
// Size: 0x7a
function function_56c8845e() {
    foreach (player in level.players) {
        player notify(#"hash_3a6467f0");
    }
    wait 1;
    music::setmusicstate("next_mission");
}

