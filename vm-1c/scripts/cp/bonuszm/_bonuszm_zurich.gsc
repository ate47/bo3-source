#using scripts/cp/voice/voice_z_zurich;
#using scripts/cp/_util;
#using scripts/cp/_dialog;
#using scripts/cp/bonuszm/_bonuszm_sound;
#using scripts/cp/bonuszm/_bonuszm;
#using scripts/shared/util_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/callbacks_shared;
#using scripts/codescripts/struct;

#namespace namespace_cc6db628;

// Namespace namespace_cc6db628
// Params 0, eflags: 0x2
// namespace_cc6db628<file_0>::function_c35e6aab
// Checksum 0x8ace922b, Offset: 0xf50
// Size: 0x34c
function autoexec init() {
    if (!sessionmodeiscampaignzombiesgame()) {
        return;
    }
    mapname = getdvarstring("mapname");
    if (mapname != "cp_mi_zurich_coalescence") {
        return;
    }
    namespace_738cec14::init_voice();
    level.var_741defc2 = &function_8924576f;
    level.var_851372ea = &function_465e0207;
    level.var_3049751d = &function_d45692cc;
    level.var_c50fbb10 = &function_fa590d35;
    level.var_f2c0d73 = &function_88519dfa;
    level.var_3a0a2835 = &function_171ce834;
    level.var_f3caeac8 = &function_3d1f629d;
    level.var_9d5ca0ab = &function_cb17f362;
    level.var_4d62c9e3 = &function_b80578aa;
    level.var_aeaf47ae = &function_f11a6dcb;
    level.var_83ee1431 = &function_7f12fe90;
    level.var_c416bc94 = &function_a51578f9;
    level.var_45d30b5a = &function_b9382ab7;
    level.var_668ce878 = &function_32beb00d;
    level.var_405a73a5 = &function_cbc35a4;
    level.var_8b86032 = &function_7ec3a4df;
    level.var_4c8d19ff = &function_58c12a76;
    level.var_efabe844 = &function_9ab4c669;
    level.var_1e860021 = &function_74b24c00;
    level.var_5be28bde = &function_e6b9bb3b;
    level.var_aeb7161b = &function_c0b740d2;
    level.var_e564da30 = &function_62d28355;
    level.var_4354053d = &function_3cd008ec;
    level.var_3b0e897d = &function_760a962c;
    level.var_771c9270 = &function_9c0d1095;
    level.var_6c87ba77 = &function_c20f8afe;
    level.var_1afc504a = &function_e8120567;
    level flag::init("BZM_ZURICHDialogue23");
    level.var_28ed7259 = &function_de00ac88;
    level.var_c40a6ffc = &function_40326f1;
    function_6ff1594f();
}

// Namespace namespace_cc6db628
// Params 0, eflags: 0x5 linked
// namespace_cc6db628<file_0>::function_6ff1594f
// Checksum 0xc7a9acaa, Offset: 0x12a8
// Size: 0x24
function private function_6ff1594f() {
    callback::on_spawned(&function_cee0476);
}

// Namespace namespace_cc6db628
// Params 0, eflags: 0x1 linked
// namespace_cc6db628<file_0>::function_cee0476
// Checksum 0x99ec1590, Offset: 0x12d8
// Size: 0x4
function function_cee0476() {
    
}

// Namespace namespace_cc6db628
// Params 0, eflags: 0x1 linked
// namespace_cc6db628<file_0>::function_8924576f
// Checksum 0x8ef8e17, Offset: 0x12e8
// Size: 0x84
function function_8924576f() {
    level endon(#"hash_4cb32f3c");
    wait(1);
    namespace_36e5bc12::function_45809471("deim_with_hendricks_as_my_0");
    wait(3);
    namespace_36e5bc12::function_45809471("deim_zurich_was_one_of_th_0");
    wait(2);
    namespace_36e5bc12::function_45809471("deim_i_needed_to_separate_0");
    namespace_36e5bc12::function_45809471("deim_but_before_that_you_1");
}

// Namespace namespace_cc6db628
// Params 0, eflags: 0x1 linked
// namespace_cc6db628<file_0>::function_465e0207
// Checksum 0xa346dda7, Offset: 0x1378
// Size: 0x2c
function function_465e0207() {
    level endon(#"hash_4cb32f3c");
    wait(4);
    namespace_36e5bc12::function_ef0ce9fb("plyz_the_city_systems_had_0");
}

// Namespace namespace_cc6db628
// Params 0, eflags: 0x1 linked
// namespace_cc6db628<file_0>::function_d45692cc
// Checksum 0xd3dd10bd, Offset: 0x13b0
// Size: 0x24
function function_d45692cc() {
    level endon(#"hash_4cb32f3c");
    namespace_36e5bc12::function_ef0ce9fb("plyz_you_used_hendricks_d_0");
}

// Namespace namespace_cc6db628
// Params 0, eflags: 0x1 linked
// namespace_cc6db628<file_0>::function_fa590d35
// Checksum 0x3d64c6e, Offset: 0x13e0
// Size: 0x2c
function function_fa590d35() {
    level endon(#"hash_4cb32f3c");
    wait(5);
    namespace_36e5bc12::function_ef0ce9fb("plyz_and_you_built_yourse_0");
}

// Namespace namespace_cc6db628
// Params 0, eflags: 0x1 linked
// namespace_cc6db628<file_0>::function_88519dfa
// Checksum 0x8dba09a2, Offset: 0x1418
// Size: 0x4c
function function_88519dfa() {
    level endon(#"hash_4cb32f3c");
    wait(1);
    namespace_36e5bc12::function_ef0ce9fb("plyz_by_the_time_we_made_0");
    wait(1);
    namespace_36e5bc12::function_45809471("deim_and_soon_that_too_w_0");
}

// Namespace namespace_cc6db628
// Params 0, eflags: 0x1 linked
// namespace_cc6db628<file_0>::function_171ce834
// Checksum 0x818801d, Offset: 0x1470
// Size: 0x1ac
function function_171ce834() {
    level endon(#"hash_4cb32f3c");
    wait(12);
    namespace_36e5bc12::function_ef0ce9fb("plyz_you_trapped_us_in_a_0");
    namespace_36e5bc12::function_45809471("deim_61_15_the_virus_tha_0");
    namespace_36e5bc12::function_45809471("deim_and_i_had_enough_to_0");
    wait(2);
    namespace_36e5bc12::function_ef0ce9fb("plyz_you_had_triggered_mu_0");
    level flag::wait_till("flag_start_kane_sacrifice_igc");
    wait(6);
    namespace_36e5bc12::function_45809471("deim_and_kane_acted_as_i_0");
    wait(1);
    namespace_36e5bc12::function_ef0ce9fb("plyz_she_sacrificed_herse_0");
    wait(2);
    namespace_36e5bc12::function_ef0ce9fb("plyz_but_wait_no_the_0");
    namespace_36e5bc12::function_ef0ce9fb("plyz_you_lied_you_tric_0");
    wait(1);
    namespace_36e5bc12::function_45809471("deim_i_ripped_her_from_yo_0");
    wait(1);
    namespace_36e5bc12::function_45809471("deim_i_won_t_understand_y_0");
    wait(1);
    namespace_36e5bc12::function_45809471("deim_you_tie_yourselves_t_0");
    namespace_36e5bc12::function_45809471("deim_you_give_your_lives_0");
    wait(1);
    namespace_36e5bc12::function_45809471("deim_keep_moving_you_re_0");
}

// Namespace namespace_cc6db628
// Params 0, eflags: 0x1 linked
// namespace_cc6db628<file_0>::function_3d1f629d
// Checksum 0xf1a37188, Offset: 0x1628
// Size: 0x124
function function_3d1f629d() {
    level endon(#"hash_4cb32f3c");
    wait(2);
    namespace_36e5bc12::function_45809471("deim_do_you_remember_this_0");
    wait(1);
    namespace_36e5bc12::function_ef0ce9fb("plyz_you_found_krueger_t_0");
    namespace_36e5bc12::function_45809471("deim_it_was_time_to_open_0");
    namespace_36e5bc12::function_ef0ce9fb("plyz_i_couldn_t_let_you_0");
    namespace_36e5bc12::function_ef0ce9fb("plyz_we_shot_each_other_0");
    namespace_36e5bc12::function_45809471("deim_but_now_you_will_sho_0");
    namespace_36e5bc12::function_45809471("deim_change_your_fate_0");
    namespace_36e5bc12::function_b4a3e925("dolo_let_him_win_e_0");
    namespace_36e5bc12::function_45809471("deim_good_now_sacrifice_0");
    namespace_36e5bc12::function_b4a3e925("dolo_do_as_he_asks_let_h_0");
    namespace_36e5bc12::function_b4a3e925("dolo_offer_yourself_to_hi_0");
}

// Namespace namespace_cc6db628
// Params 0, eflags: 0x1 linked
// namespace_cc6db628<file_0>::function_cb17f362
// Checksum 0xf1860b34, Offset: 0x1758
// Size: 0x154
function function_cb17f362() {
    level endon(#"hash_4cb32f3c");
    wait(2);
    namespace_36e5bc12::function_ef0ce9fb("plyz_wait_what_where_0");
    wait(1);
    namespace_36e5bc12::function_ef0ce9fb("plyz_hendricks_what_are_0");
    wait(1);
    namespace_36e5bc12::function_ef0ce9fb("plyz_i_can_t_i_can_t_h_0");
    namespace_36e5bc12::function_b4a3e925("dolo_humans_have_no_voice_0");
    wait(3);
    namespace_36e5bc12::function_45809471("deim_how_is_this_possible_1");
    namespace_36e5bc12::function_ef0ce9fb("plyz_deimos_what_s_happ_0");
    wait(1);
    namespace_36e5bc12::function_45809471("deim_why_don_t_you_ask_yo_0");
    wait(1);
    namespace_36e5bc12::function_ef0ce9fb("plyz_he_he_won_t_speak_0");
    wait(1);
    namespace_36e5bc12::function_45809471("deim_of_course_not_of_co_0");
    namespace_36e5bc12::function_ef0ce9fb("plyz_where_is_here_0");
    wait(1);
    namespace_36e5bc12::function_45809471("deim_like_you_don_t_know_1");
}

// Namespace namespace_cc6db628
// Params 0, eflags: 0x1 linked
// namespace_cc6db628<file_0>::function_b80578aa
// Checksum 0xafa7f434, Offset: 0x18b8
// Size: 0xac
function function_b80578aa() {
    level endon(#"hash_4cb32f3c");
    wait(2);
    namespace_36e5bc12::function_45809471("deim_you_you_did_this_y_0");
    wait(1);
    namespace_36e5bc12::function_45809471("deim_and_yet_we_have_anot_0");
    namespace_36e5bc12::function_45809471("deim_what_are_you_saying_0");
    namespace_36e5bc12::function_45809471("deim_look_at_him_angry_a_0");
    namespace_36e5bc12::function_ef0ce9fb("plyz_deimos_i_don_t_know_0");
    namespace_36e5bc12::function_45809471("deim_enough_in_time_i_m_0");
}

// Namespace namespace_cc6db628
// Params 0, eflags: 0x1 linked
// namespace_cc6db628<file_0>::function_f11a6dcb
// Checksum 0x99ec1590, Offset: 0x1970
// Size: 0x4
function function_f11a6dcb() {
    
}

// Namespace namespace_cc6db628
// Params 0, eflags: 0x1 linked
// namespace_cc6db628<file_0>::function_7f12fe90
// Checksum 0x2838440, Offset: 0x1980
// Size: 0xac
function function_7f12fe90() {
    level endon(#"hash_4cb32f3c");
    namespace_36e5bc12::function_ef0ce9fb("plyz_hello_who_s_there_0");
    namespace_36e5bc12::function_b4a3e925("dolo_this_is_your_new_hom_0");
    wait(1);
    namespace_36e5bc12::function_ef0ce9fb("plyz_who_are_you_i_i_0");
    namespace_36e5bc12::function_b4a3e925("dolo_i_am_the_reason_you_0");
    wait(1);
    namespace_36e5bc12::function_ef0ce9fb("plyz_fun_to_be_had_who_0");
    namespace_36e5bc12::function_b4a3e925("dolo_i_am_dolos_demigodd_1");
}

// Namespace namespace_cc6db628
// Params 0, eflags: 0x1 linked
// namespace_cc6db628<file_0>::function_a51578f9
// Checksum 0x9e3d864f, Offset: 0x1a38
// Size: 0x23c
function function_a51578f9() {
    level endon(#"hash_4cb32f3c");
    if (isdefined(level.var_a51578f9) && level.var_a51578f9) {
        return;
    }
    level.var_a51578f9 = 1;
    wait(4);
    namespace_36e5bc12::function_45809471("deim_and_still_you_live_0");
    namespace_36e5bc12::function_45809471("deim_this_poor_babbling_0");
    namespace_36e5bc12::function_ef0ce9fb("deim_but_how_did_you_send_0");
    namespace_36e5bc12::function_b4a3e925("dolo_she_may_be_mortal_m_0");
    namespace_36e5bc12::function_45809471("deim_no_no_you_th_0");
    namespace_36e5bc12::function_ef0ce9fb("plyz_deimos_where_are_yo_0");
    namespace_36e5bc12::function_45809471("deim_i_don_t_know_what_yo_0");
    namespace_36e5bc12::function_45809471("deim_this_poor_soul_didn_0");
    namespace_36e5bc12::function_b4a3e925("dolo_it_wasn_t_her_littl_0");
    namespace_36e5bc12::function_45809471("deim_no_no_that_s_i_0");
    wait(1);
    namespace_36e5bc12::function_b4a3e925("dolo_i_ve_ended_your_litt_0");
    namespace_36e5bc12::function_45809471("deim_no_no_no_no_0");
    wait(1);
    namespace_36e5bc12::function_b4a3e925("dolo_but_but_deimos_i_0");
    namespace_36e5bc12::function_45809471("deim_humanity_was_mine_to_0");
    namespace_36e5bc12::function_b4a3e925("dolo_humanity_will_destro_1");
    namespace_36e5bc12::function_45809471("deim_sister_you_ve_mad_0");
    wait(1);
    namespace_36e5bc12::function_ef0ce9fb("plyz_taylor_is_that_you_0");
    wait(1);
    namespace_36e5bc12::function_b4a3e925("dolo_it_s_not_taylor_it_0");
    namespace_36e5bc12::function_ef0ce9fb("plyz_where_is_he_taking_m_0");
    namespace_36e5bc12::function_b4a3e925("dolo_to_one_of_deimos_he_0");
}

// Namespace namespace_cc6db628
// Params 0, eflags: 0x1 linked
// namespace_cc6db628<file_0>::function_b9382ab7
// Checksum 0x210407c4, Offset: 0x1c80
// Size: 0x94
function function_b9382ab7() {
    level endon(#"hash_4cb32f3c");
    wait(4);
    namespace_36e5bc12::function_b4a3e925("dolo_this_cold_world_is_d_1");
    wait(1);
    namespace_36e5bc12::function_b4a3e925("dolo_it_s_outstayed_its_w_0");
    namespace_36e5bc12::function_45809471("deim_you_think_i_will_let_0");
    namespace_36e5bc12::function_b4a3e925("dolo_of_course_you_were_0");
    namespace_36e5bc12::function_45809471("deim_petty_you_dare_ca_0");
}

// Namespace namespace_cc6db628
// Params 0, eflags: 0x1 linked
// namespace_cc6db628<file_0>::function_32beb00d
// Checksum 0x67e291af, Offset: 0x1d20
// Size: 0xe
function function_32beb00d() {
    level endon(#"hash_4cb32f3c");
}

// Namespace namespace_cc6db628
// Params 0, eflags: 0x1 linked
// namespace_cc6db628<file_0>::function_cbc35a4
// Checksum 0x35d336ae, Offset: 0x1d38
// Size: 0x8c
function function_cbc35a4() {
    level endon(#"hash_4cb32f3c");
    wait(2);
    namespace_36e5bc12::function_ef0ce9fb("plyz_deimos_dolos_0");
    wait(1);
    namespace_36e5bc12::function_ef0ce9fb("plyz_taylor_is_anyone_th_0");
    wait(1);
    namespace_36e5bc12::function_ef0ce9fb("plyz_dolos_where_are_we_0");
    wait(2);
    namespace_36e5bc12::function_b4a3e925("dolo_malum_is_a_realm_bey_0");
}

// Namespace namespace_cc6db628
// Params 0, eflags: 0x1 linked
// namespace_cc6db628<file_0>::function_7ec3a4df
// Checksum 0x3cf6e8ec, Offset: 0x1dd0
// Size: 0x9c
function function_7ec3a4df() {
    level endon(#"hash_4cb32f3c");
    wait(3);
    namespace_36e5bc12::function_b4a3e925("dolo_i_arrived_on_earth_w_0");
    wait(1);
    namespace_36e5bc12::function_b4a3e925("dolo_dr_salim_and_deimos_0");
    namespace_36e5bc12::function_b4a3e925("dolo_revenge_power_viol_0");
    wait(1);
    namespace_36e5bc12::function_b4a3e925("dolo_and_i_was_comfortabl_0");
    namespace_36e5bc12::function_b4a3e925("dolo_so_i_sat_back_while_0");
}

// Namespace namespace_cc6db628
// Params 0, eflags: 0x1 linked
// namespace_cc6db628<file_0>::function_58c12a76
// Checksum 0xee2b8383, Offset: 0x1e78
// Size: 0x84
function function_58c12a76() {
    level endon(#"hash_4cb32f3c");
    wait(4);
    namespace_36e5bc12::function_ef0ce9fb("plyz_you_you_were_kane_0");
    wait(2);
    namespace_36e5bc12::function_b4a3e925("dolo_i_m_not_my_brother_0");
    wait(1);
    namespace_36e5bc12::function_b4a3e925("dolo_go_destroy_the_he_0");
    namespace_36e5bc12::function_45809471("deim_i_will_break_you_ri_0");
}

// Namespace namespace_cc6db628
// Params 0, eflags: 0x1 linked
// namespace_cc6db628<file_0>::function_9ab4c669
// Checksum 0x91a6b05b, Offset: 0x1f08
// Size: 0xe
function function_9ab4c669() {
    level endon(#"hash_4cb32f3c");
}

// Namespace namespace_cc6db628
// Params 0, eflags: 0x1 linked
// namespace_cc6db628<file_0>::function_74b24c00
// Checksum 0xf7d9c46e, Offset: 0x1f20
// Size: 0x8c
function function_74b24c00() {
    level endon(#"hash_4cb32f3c");
    wait(5);
    namespace_36e5bc12::function_45809471("deim_you_must_realize_the_0");
    namespace_36e5bc12::function_b4a3e925("dolo_ah_but_brother_she_0");
    namespace_36e5bc12::function_45809471("deim_how_could_you_have_k_0");
    namespace_36e5bc12::function_b4a3e925("dolo_because_it_was_i_who_0");
    namespace_36e5bc12::function_45809471("deim_it_s_a_pity_she_won_0");
}

// Namespace namespace_cc6db628
// Params 0, eflags: 0x1 linked
// namespace_cc6db628<file_0>::function_e6b9bb3b
// Checksum 0x99226d53, Offset: 0x1fb8
// Size: 0xac
function function_e6b9bb3b() {
    level endon(#"hash_4cb32f3c");
    wait(2);
    namespace_36e5bc12::function_b4a3e925("dolo_taylor_found_us_easi_0");
    wait(3);
    namespace_36e5bc12::function_b4a3e925("dolo_deimos_deimos_is_0");
    wait(2);
    namespace_36e5bc12::function_b4a3e925("dolo_in_truth_i_was_bored_0");
    wait(2);
    namespace_36e5bc12::function_ef0ce9fb("plyz_you_let_him_destroy_0");
    wait(1);
    namespace_36e5bc12::function_b4a3e925("dolo_it_ll_turn_back_hum_0");
}

// Namespace namespace_cc6db628
// Params 0, eflags: 0x1 linked
// namespace_cc6db628<file_0>::function_c0b740d2
// Checksum 0xc091890c, Offset: 0x2070
// Size: 0x4c
function function_c0b740d2() {
    level endon(#"hash_4cb32f3c");
    wait(3);
    namespace_36e5bc12::function_45809471("deim_and_then_what_after_0");
    wait(1);
    namespace_36e5bc12::function_45809471("dolo_no_humanity_is_insa_0");
}

// Namespace namespace_cc6db628
// Params 0, eflags: 0x1 linked
// namespace_cc6db628<file_0>::function_62d28355
// Checksum 0xf27d47d4, Offset: 0x20c8
// Size: 0xe
function function_62d28355() {
    level endon(#"hash_4cb32f3c");
}

// Namespace namespace_cc6db628
// Params 0, eflags: 0x1 linked
// namespace_cc6db628<file_0>::function_3cd008ec
// Checksum 0x2fe2c4c8, Offset: 0x20e0
// Size: 0x6c
function function_3cd008ec() {
    level endon(#"hash_4cb32f3c");
    wait(2);
    namespace_36e5bc12::function_b4a3e925("dolo_you_know_if_you_def_0");
    wait(1);
    namespace_36e5bc12::function_ef0ce9fb("plyz_if_killing_that_fuck_0");
    wait(1);
    namespace_36e5bc12::function_b4a3e925("dolo_girl_after_my_own_he_0");
}

// Namespace namespace_cc6db628
// Params 0, eflags: 0x1 linked
// namespace_cc6db628<file_0>::function_760a962c
// Checksum 0x1eb54b96, Offset: 0x2158
// Size: 0xac
function function_760a962c() {
    level endon(#"hash_4cb32f3c");
    wait(2);
    namespace_36e5bc12::function_b4a3e925("dolo_deimos_did_exactly_a_0");
    wait(3);
    namespace_36e5bc12::function_b4a3e925("dolo_but_to_enslave_human_0");
    wait(2);
    namespace_36e5bc12::function_b4a3e925("dolo_you_know_he_is_not_w_0");
    wait(3);
    namespace_36e5bc12::function_b4a3e925("dolo_you_force_yourself_t_0");
    wait(1);
    namespace_36e5bc12::function_b4a3e925("dolo_which_is_what_humani_0");
}

// Namespace namespace_cc6db628
// Params 0, eflags: 0x1 linked
// namespace_cc6db628<file_0>::function_9c0d1095
// Checksum 0x199a4b94, Offset: 0x2210
// Size: 0x74
function function_9c0d1095() {
    level endon(#"hash_4cb32f3c");
    wait(16);
    namespace_36e5bc12::function_45809471("deim_i_won_t_let_you_do_t_0");
    namespace_36e5bc12::function_b4a3e925("dolo_she_s_burned_your_he_0");
    namespace_36e5bc12::function_ef0ce9fb("plyz_what_choice_do_you_h_0");
    namespace_36e5bc12::function_45809471("deim_i_ll_kill_you_i_can_0");
}

// Namespace namespace_cc6db628
// Params 0, eflags: 0x1 linked
// namespace_cc6db628<file_0>::function_c20f8afe
// Checksum 0x991f404d, Offset: 0x2290
// Size: 0x84
function function_c20f8afe() {
    level endon(#"hash_4cb32f3c");
    namespace_36e5bc12::function_45809471("deim_why_do_you_fight_0");
    namespace_36e5bc12::function_b4a3e925("dolo_i_ll_hold_him_this_0");
    namespace_36e5bc12::function_b4a3e925("dolo_do_it_kill_him_0");
    namespace_36e5bc12::function_45809471("deim_no_the_throne_is_mi_0");
    namespace_36e5bc12::function_ef0ce9fb("plyz_oh_yeah_how_s_this_0");
}

// Namespace namespace_cc6db628
// Params 0, eflags: 0x1 linked
// namespace_cc6db628<file_0>::function_e8120567
// Checksum 0x2235b4b4, Offset: 0x2320
// Size: 0xc4
function function_e8120567() {
    level endon(#"hash_4cb32f3c");
    wait(5);
    namespace_36e5bc12::function_ef0ce9fb("plyz_wait_this_is_eart_0");
    namespace_36e5bc12::function_b4a3e925("dolo_they_re_coming_for_y_0");
    namespace_36e5bc12::function_ef0ce9fb("plyz_who_is_0");
    namespace_36e5bc12::function_b4a3e925("dolo_my_brothers_my_sist_0");
    namespace_36e5bc12::function_ef0ce9fb("plyz_let_them_come_0");
    namespace_36e5bc12::function_b4a3e925("dolo_i_like_the_enthusias_0");
    level flag::set("BZM_ZURICHDialogue23");
}

// Namespace namespace_cc6db628
// Params 0, eflags: 0x1 linked
// namespace_cc6db628<file_0>::function_de00ac88
// Checksum 0x9518b892, Offset: 0x23f0
// Size: 0x2c
function function_de00ac88() {
    level endon(#"hash_4cb32f3c");
    wait(2);
    namespace_36e5bc12::function_ef0ce9fb("plyz_we_kill_every_last_o_0");
}

// Namespace namespace_cc6db628
// Params 0, eflags: 0x1 linked
// namespace_cc6db628<file_0>::function_40326f1
// Checksum 0xe95faa2c, Offset: 0x2428
// Size: 0x26
function function_40326f1() {
    level endon(#"hash_4cb32f3c");
    time = 8;
    wait(time);
}

