#using scripts/cp/voice/voice_z_infection;
#using scripts/cp/_util;
#using scripts/cp/_dialog;
#using scripts/cp/bonuszm/_bonuszm_sound;
#using scripts/cp/bonuszm/_bonuszm;
#using scripts/shared/util_shared;
#using scripts/shared/flagsys_shared;
#using scripts/shared/flag_shared;
#using scripts/codescripts/struct;

#namespace namespace_2f2192b4;

// Namespace namespace_2f2192b4
// Params 0, eflags: 0x2
// Checksum 0xdedebaa1, Offset: 0xb40
// Size: 0x2c4
function autoexec init() {
    if (!sessionmodeiscampaignzombiesgame()) {
        return;
    }
    mapname = getdvarstring("mapname");
    if (!issubstr(mapname, "infection")) {
        return;
    }
    level.riser_type = "snow";
    namespace_6ff07a70::init_voice();
    level.var_9e37b96 = &function_c7784263;
    level.var_612d3f9 = &function_5570d328;
    level.var_46584a9c = &function_7b734d91;
    level.var_af6a0d17 = &function_397fb19e;
    level.var_1852dcea = &function_5f822c07;
    level.var_c388df1d = &function_ed7abccc;
    level.var_584f2510 = &function_137d3735;
    level.var_90ce01fb = &function_7161f4b2;
    level.var_c30ca873 = &function_b0c5d8fa;
    level.var_3df977be = &function_97646f1b;
    level.var_5145b404 = &function_44d98e29;
    level.var_27ad69e1 = &function_1ed713c0;
    level.var_d68aea9e = &function_90de82fb;
    level.var_abdc59db = &function_6adc0892;
    level.var_b82f6a38 = &function_dce377cd;
    level.var_7635d765 = &function_b6e0fd64;
    level.var_adc064f2 = &function_28e86c9f;
    level.var_b15c12bf = &function_2e5f236;
    level.var_e8717a7c = &function_74ed6171;
    level.var_4d547cd9 = &function_4eeae708;
    level.var_354a0919 = &function_88257448;
    level.var_f31e5abc = &function_ae27eeb1;
    level.var_44ab3893 = &function_d42a691a;
    level.var_b74489b6 = &function_fa2ce383;
}

// Namespace namespace_2f2192b4
// Params 0, eflags: 0x1 linked
// Checksum 0xdfe85fa4, Offset: 0xe10
// Size: 0xcc
function function_c7784263() {
    level endon(#"hash_4cb32f3c");
    wait(2);
    namespace_36e5bc12::function_ef0ce9fb("plyz_deimos_was_going_to_0");
    namespace_36e5bc12::function_cf21d35c("salm_it_wasn_t_odd_that_h_0");
    namespace_36e5bc12::function_ef0ce9fb("plyz_there_wasn_t_time_to_0");
    wait(5);
    namespace_36e5bc12::function_ef0ce9fb("plyz_she_was_waiting_she_0");
    level flag::wait_till("player_exiting_downed_vtol");
    namespace_36e5bc12::function_ef0ce9fb("plyz_deimos_was_using_tay_0");
    namespace_36e5bc12::function_ef0ce9fb("plyz_if_we_were_gonna_fin_0");
}

// Namespace namespace_2f2192b4
// Params 0, eflags: 0x1 linked
// Checksum 0xf70ae381, Offset: 0xee8
// Size: 0x4c
function function_5570d328() {
    level endon(#"hash_4cb32f3c");
    wait(6);
    namespace_36e5bc12::function_ef0ce9fb("plyz_i_d_interfaced_with_0");
    wait(2);
    namespace_36e5bc12::function_ef0ce9fb("plyz_but_this_was_differe_0");
}

// Namespace namespace_2f2192b4
// Params 0, eflags: 0x1 linked
// Checksum 0x19672da3, Offset: 0xf40
// Size: 0x12c
function function_7b734d91() {
    level endon(#"hash_4cb32f3c");
    wait(1);
    namespace_36e5bc12::function_ef0ce9fb("plyz_interfacing_with_som_0");
    namespace_36e5bc12::function_cf21d35c("salm_because_the_deep_sub_0");
    namespace_36e5bc12::function_cf21d35c("salm_the_human_subconscio_0");
    namespace_36e5bc12::function_ef0ce9fb("plyz_but_but_you_said_0");
    namespace_36e5bc12::function_cf21d35c("salm_no_i_told_you_to_ta_0");
    while (!level flag::exists("baby_picked_up")) {
        wait(1);
    }
    level flag::wait_till("baby_picked_up");
    wait(1);
    namespace_36e5bc12::function_ef0ce9fb("plyz_please_why_are_you_0");
    namespace_36e5bc12::function_ef0ce9fb("plyz_why_are_you_lying_to_0");
    wait(1);
    namespace_36e5bc12::function_cf21d35c("salm_i_m_afraid_you_don_t_0");
}

// Namespace namespace_2f2192b4
// Params 0, eflags: 0x1 linked
// Checksum 0xf2c93b82, Offset: 0x1078
// Size: 0x184
function function_397fb19e() {
    level endon(#"hash_4cb32f3c");
    wait(1);
    namespace_36e5bc12::function_cf21d35c("salm_lead_me_to_the_depth_0");
    wait(2);
    namespace_36e5bc12::function_ef0ce9fb("plyz_project_corvus_2060_0");
    wait(2);
    namespace_36e5bc12::function_ef0ce9fb("plyz_sarah_she_told_me_0");
    namespace_36e5bc12::function_ef0ce9fb("plyz_he_knew_everything_a_0");
    wait(1);
    namespace_36e5bc12::function_ef0ce9fb("plyz_she_learned_the_coal_0");
    namespace_36e5bc12::function_cf21d35c("salm_well_i_did_what_had_0");
    wait(1);
    namespace_36e5bc12::function_cf21d35c("salm_but_in_the_lab_i_saw_0");
    namespace_36e5bc12::function_cf21d35c("salm_i_saw_deimos_0");
    wait(2);
    namespace_36e5bc12::function_ef0ce9fb("plyz_you_you_did_this_y_0");
    wait(1);
    namespace_36e5bc12::function_cf21d35c("salm_i_brought_mankind_s_0");
    wait(3);
    namespace_36e5bc12::function_cf21d35c("salm_after_many_years_i_0");
    namespace_36e5bc12::function_ef0ce9fb("plyz_you_you_created_the_0");
    namespace_36e5bc12::function_cf21d35c("salm_well_his_undead_ser_0");
}

// Namespace namespace_2f2192b4
// Params 0, eflags: 0x1 linked
// Checksum 0x50bc5ba2, Offset: 0x1208
// Size: 0xe
function function_5f822c07() {
    level endon(#"hash_4cb32f3c");
}

// Namespace namespace_2f2192b4
// Params 0, eflags: 0x1 linked
// Checksum 0x7b4f27c2, Offset: 0x1220
// Size: 0xa4
function function_ed7abccc() {
    level endon(#"hash_4cb32f3c");
    wait(3);
    namespace_36e5bc12::function_ef0ce9fb("plyz_we_we_were_built_0");
    wait(3);
    namespace_36e5bc12::function_ef0ce9fb("plyz_we_created_the_very_0");
    wait(1);
    namespace_36e5bc12::function_cf21d35c("salm_he_was_a_prisoner_c_0");
    wait(1);
    namespace_36e5bc12::function_ef0ce9fb("plyz_we_were_vehicles_for_0");
    namespace_36e5bc12::function_cf21d35c("salm_that_makes_it_sound_0");
}

// Namespace namespace_2f2192b4
// Params 0, eflags: 0x1 linked
// Checksum 0x3c16fbdb, Offset: 0x12d0
// Size: 0x64
function function_137d3735() {
    level endon(#"hash_4cb32f3c");
    wait(3);
    namespace_36e5bc12::function_cf21d35c("salm_tell_me_what_did_0");
    namespace_36e5bc12::function_ef0ce9fb("plyz_failure_when_she_wa_0");
    wait(1);
    namespace_36e5bc12::function_ef0ce9fb("plyz_we_didn_t_know_how_0");
}

// Namespace namespace_2f2192b4
// Params 0, eflags: 0x1 linked
// Checksum 0xcf9dbf1, Offset: 0x1340
// Size: 0x6c
function function_7161f4b2() {
    level endon(#"hash_4cb32f3c");
    wait(1);
    namespace_36e5bc12::function_ef0ce9fb("plyz_the_world_began_to_f_0");
    wait(2);
    namespace_36e5bc12::function_45809471("deim_sarah_listen_to_t_0");
    wait(1);
    namespace_36e5bc12::function_ef0ce9fb("plyz_he_he_was_trying_0");
}

// Namespace namespace_2f2192b4
// Params 0, eflags: 0x1 linked
// Checksum 0xa395a652, Offset: 0x13b8
// Size: 0x64
function function_b0c5d8fa() {
    level endon(#"hash_4cb32f3c");
    wait(1);
    namespace_36e5bc12::function_ef0ce9fb("plyz_her_mind_was_fractur_0");
    wait(1);
    namespace_36e5bc12::function_cf21d35c("salm_you_were_deep_within_0");
    namespace_36e5bc12::function_ef0ce9fb("plyz_you_think_i_wasn_t_s_0");
}

// Namespace namespace_2f2192b4
// Params 0, eflags: 0x1 linked
// Checksum 0x8640d503, Offset: 0x1428
// Size: 0x2c
function function_97646f1b() {
    level endon(#"hash_4cb32f3c");
    wait(2);
    namespace_36e5bc12::function_ef0ce9fb("plyz_from_the_moment_she_0");
}

// Namespace namespace_2f2192b4
// Params 0, eflags: 0x1 linked
// Checksum 0xa814ba5c, Offset: 0x1460
// Size: 0xcc
function function_44d98e29() {
    level endon(#"hash_4cb32f3c");
    wait(8);
    namespace_36e5bc12::function_ef0ce9fb("plyz_he_slaughtered_the_s_0");
    wait(1);
    namespace_36e5bc12::function_ef0ce9fb("plyz_why_did_he_kill_them_0");
    wait(1);
    namespace_36e5bc12::function_cf21d35c("salm_the_documentation_of_0");
    wait(1);
    namespace_36e5bc12::function_cf21d35c("salm_he_was_angry_the_da_0");
    wait(1);
    namespace_36e5bc12::function_ef0ce9fb("plyz_the_piece_hendricks_0");
    wait(2);
    namespace_36e5bc12::function_ef0ce9fb("plyz_deimos_didn_t_want_s_0");
}

// Namespace namespace_2f2192b4
// Params 0, eflags: 0x1 linked
// Checksum 0x24f51c09, Offset: 0x1538
// Size: 0x4c
function function_1ed713c0() {
    level endon(#"hash_4cb32f3c");
    wait(7);
    namespace_36e5bc12::function_ef0ce9fb("plyz_we_were_in_foy_i_sa_0");
    wait(1);
    namespace_36e5bc12::function_ef0ce9fb("plyz_she_told_me_to_follo_0");
}

// Namespace namespace_2f2192b4
// Params 0, eflags: 0x1 linked
// Checksum 0x4c9b68d3, Offset: 0x1590
// Size: 0x2c
function function_90de82fb() {
    level endon(#"hash_4cb32f3c");
    wait(12);
    namespace_36e5bc12::function_ef0ce9fb("plyz_there_was_a_chapel_a_0");
}

// Namespace namespace_2f2192b4
// Params 0, eflags: 0x1 linked
// Checksum 0x2daae2a4, Offset: 0x15c8
// Size: 0x64
function function_6adc0892() {
    level endon(#"hash_4cb32f3c");
    wait(1);
    namespace_36e5bc12::function_ef0ce9fb("plyz_you_re_insane_0");
    namespace_36e5bc12::function_cf21d35c("salm_no_i_told_you_befor_0");
    wait(1);
    namespace_36e5bc12::function_ef0ce9fb("plyz_he_needed_taylor_to_0");
}

// Namespace namespace_2f2192b4
// Params 0, eflags: 0x1 linked
// Checksum 0xfb9b6ec2, Offset: 0x1638
// Size: 0x4c
function function_dce377cd() {
    level endon(#"hash_4cb32f3c");
    wait(3);
    namespace_36e5bc12::function_ef0ce9fb("plyz_the_aquifers_their_0");
    wait(4);
    namespace_36e5bc12::function_ef0ce9fb("plyz_deimos_couldn_t_acce_0");
}

// Namespace namespace_2f2192b4
// Params 0, eflags: 0x1 linked
// Checksum 0x21b508b, Offset: 0x1690
// Size: 0x84
function function_b6e0fd64() {
    level endon(#"hash_4cb32f3c");
    wait(2);
    namespace_36e5bc12::function_ef0ce9fb("plyz_there_s_something_i_0");
    wait(4);
    namespace_36e5bc12::function_ef0ce9fb("plyz_but_deimos_wasn_t_0");
    wait(1);
    namespace_36e5bc12::function_cf21d35c("salm_no_my_child_dr_sa_0");
    namespace_36e5bc12::function_ef0ce9fb("plyz_was_wait_what_d_0");
}

// Namespace namespace_2f2192b4
// Params 0, eflags: 0x1 linked
// Checksum 0xde276e09, Offset: 0x1720
// Size: 0xd4
function function_28e86c9f() {
    level endon(#"hash_4cb32f3c");
    wait(2);
    namespace_36e5bc12::function_cf21d35c("salm_i_must_say_i_m_impr_0");
    namespace_36e5bc12::function_ef0ce9fb("plyz_they_found_you_they_0");
    namespace_36e5bc12::function_cf21d35c("deim_dr_salim_was_no_all_0");
    namespace_36e5bc12::function_45809471("salm_you_humans_even_whe_0");
    namespace_36e5bc12::function_ef0ce9fb("plyz_no_1");
    namespace_36e5bc12::function_45809471("deim_even_now_you_still_h_0");
    namespace_36e5bc12::function_45809471("deim_look_at_how_she_stru_0");
    namespace_36e5bc12::function_45809471("deim_i_am_humanity_s_salv_0");
}

// Namespace namespace_2f2192b4
// Params 0, eflags: 0x1 linked
// Checksum 0xa2b70a58, Offset: 0x1800
// Size: 0xe
function function_2e5f236() {
    level endon(#"hash_4cb32f3c");
}

// Namespace namespace_2f2192b4
// Params 0, eflags: 0x1 linked
// Checksum 0xbf76cf58, Offset: 0x1818
// Size: 0x64
function function_74ed6171() {
    level endon(#"hash_4cb32f3c");
    wait(10);
    namespace_36e5bc12::function_ef0ce9fb("plyz_the_tree_i_ve_seen_0");
    namespace_36e5bc12::function_45809471("deim_tell_me_what_do_you_0");
    wait(2);
    namespace_36e5bc12::function_ef0ce9fb("plyz_you_awaited_her_sacr_0");
}

// Namespace namespace_2f2192b4
// Params 0, eflags: 0x1 linked
// Checksum 0x35e44b83, Offset: 0x1888
// Size: 0x44
function function_fa2ce383() {
    level endon(#"hash_4cb32f3c");
    wait(1);
    namespace_36e5bc12::function_45809471("deim_you_you_wouldn_t_0");
    namespace_36e5bc12::function_ef0ce9fb("plyz_if_she_offered_herse_0");
}

// Namespace namespace_2f2192b4
// Params 0, eflags: 0x1 linked
// Checksum 0xba482fc5, Offset: 0x18d8
// Size: 0x2c
function function_4eeae708() {
    level endon(#"hash_4cb32f3c");
    wait(2);
    namespace_36e5bc12::function_45809471("deim_you_denied_me_my_pri_0");
}

// Namespace namespace_2f2192b4
// Params 0, eflags: 0x1 linked
// Checksum 0xc47f9571, Offset: 0x1910
// Size: 0x74
function function_88257448() {
    level endon(#"hash_4cb32f3c");
    wait(1);
    namespace_36e5bc12::function_45809471("deim_but_now_i_had_you_i_0");
    namespace_36e5bc12::function_45809471("deim_sarah_may_have_told_0");
    namespace_36e5bc12::function_ef0ce9fb("plyz_they_located_taylor_0");
    namespace_36e5bc12::function_ef0ce9fb("plyz_she_said_there_was_m_0");
}

// Namespace namespace_2f2192b4
// Params 0, eflags: 0x1 linked
// Checksum 0xaf82ac4f, Offset: 0x1990
// Size: 0x44
function function_ae27eeb1() {
    level endon(#"hash_4cb32f3c");
    wait(1);
    namespace_36e5bc12::function_ef0ce9fb("plyz_i_had_to_find_taylor_0");
    namespace_36e5bc12::function_ef0ce9fb("plyz_she_said_if_i_wanted_0");
}

// Namespace namespace_2f2192b4
// Params 0, eflags: 0x1 linked
// Checksum 0x9064b1e5, Offset: 0x19e0
// Size: 0x12c
function function_d42a691a() {
    level endon(#"hash_4cb32f3c");
    wait(2);
    namespace_36e5bc12::function_ef0ce9fb("plyz_i_tried_to_approach_0");
    wait(2);
    namespace_36e5bc12::function_ef0ce9fb("plyz_deimos_had_other_ide_0");
    wait(2);
    namespace_36e5bc12::function_ef0ce9fb("plyz_to_get_to_her_i_had_0");
    while (!flag::exists("cathedral_quad_tank_destroyed")) {
        wait(1);
    }
    level flag::wait_till("cathedral_quad_tank_destroyed");
    wait(10);
    namespace_36e5bc12::function_ef0ce9fb("plyz_she_told_me_to_appro_0");
    wait(2);
    namespace_36e5bc12::function_cf21d35c("salm_sarah_couldn_t_under_0");
    wait(1);
    namespace_36e5bc12::function_ef0ce9fb("plyz_the_ultimate_gift_d_0");
    wait(1);
    namespace_36e5bc12::function_cf21d35c("salm_relinquishing_contro_0");
}

