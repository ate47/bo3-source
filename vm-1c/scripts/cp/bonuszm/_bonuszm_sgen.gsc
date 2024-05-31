#using scripts/cp/voice/voice_z_hypocenter;
#using scripts/cp/_util;
#using scripts/cp/_dialog;
#using scripts/cp/bonuszm/_bonuszm_sound;
#using scripts/cp/bonuszm/_bonuszm;
#using scripts/shared/util_shared;
#using scripts/shared/flag_shared;
#using scripts/codescripts/struct;

#namespace namespace_fc7d2b5e;

// Namespace namespace_fc7d2b5e
// Params 0, eflags: 0x2
// namespace_fc7d2b5e<file_0>::function_c35e6aab
// Checksum 0x935eb484, Offset: 0x770
// Size: 0x21c
function autoexec init() {
    if (!sessionmodeiscampaignzombiesgame()) {
        return;
    }
    mapname = getdvarstring("mapname");
    if (mapname == "cp_mi_sing_sgen") {
        namespace_e15266b8::init_voice();
        level.var_fbcb62fc = &function_1304b9f1;
        level.var_18387790 = &function_4a08b9b5;
        level.var_6f535f97 = &function_700b341e;
        level.var_d83c2f6a = &function_960dae87;
        level flag::init("BZM_SGENDialogue1_3");
        level.var_9c89f6ae = &function_1dfa8915;
        level.var_4f37abd3 = &function_3907345a;
        level.var_9de79ddb = &function_7752cc92;
        level.var_685af7f6 = &function_5f09aec3;
        level.var_72cf7c7d = &function_850c292c;
        level.var_e6d6fe31 = &function_1230a890;
        level.var_aedd8570 = &function_ab0ea395;
        level.var_a448ad77 = &function_d1111dfe;
        level.var_52bd434a = &function_f7139867;
        level.var_3b075261 = &function_bcee6c40;
        level.var_847128ad = &function_549842dc;
        level.var_723afba = &function_c69fb217;
        level.var_649f9c84 = &function_e2f0e6a9;
    }
}

// Namespace namespace_fc7d2b5e
// Params 0, eflags: 0x1 linked
// namespace_fc7d2b5e<file_0>::function_1304b9f1
// Checksum 0x14faf505, Offset: 0x998
// Size: 0x2c
function function_1304b9f1() {
    level endon(#"hash_4cb32f3c");
    wait(6);
    namespace_36e5bc12::function_ef0ce9fb("plyz_it_started_at_coales_0");
}

// Namespace namespace_fc7d2b5e
// Params 0, eflags: 0x1 linked
// namespace_fc7d2b5e<file_0>::function_4a08b9b5
// Checksum 0x7e8d92b8, Offset: 0x9d0
// Size: 0x94
function function_4a08b9b5() {
    wait(2);
    level endon(#"hash_4cb32f3c");
    wait(3);
    namespace_36e5bc12::function_ef0ce9fb("plyz_we_d_lost_comms_with_0");
    wait(11);
    namespace_36e5bc12::function_ef0ce9fb("plyz_hendricks_was_on_edg_0");
    wait(1);
    namespace_36e5bc12::function_ef0ce9fb("plyz_the_undead_weren_t_o_0");
    wait(2);
    namespace_36e5bc12::function_ef0ce9fb("plyz_either_way_our_trou_0");
}

// Namespace namespace_fc7d2b5e
// Params 0, eflags: 0x1 linked
// namespace_fc7d2b5e<file_0>::function_700b341e
// Checksum 0xe9780942, Offset: 0xa70
// Size: 0x4c
function function_700b341e() {
    level endon(#"hash_4cb32f3c");
    wait(8);
    namespace_36e5bc12::function_ef0ce9fb("plyz_we_should_ve_known_t_0");
    wait(2);
    namespace_36e5bc12::function_ef0ce9fb("plyz_hendricks_had_a_bad_0");
}

// Namespace namespace_fc7d2b5e
// Params 0, eflags: 0x1 linked
// namespace_fc7d2b5e<file_0>::function_960dae87
// Checksum 0x71353b29, Offset: 0xac8
// Size: 0x84
function function_960dae87() {
    level endon(#"hash_4cb32f3c");
    wait(5);
    namespace_36e5bc12::function_ef0ce9fb("plyz_coalescence_enhanc_0");
    wait(2);
    namespace_36e5bc12::function_cf21d35c("salm_what_happened_what_0");
    namespace_36e5bc12::function_ef0ce9fb("plyz_the_coalescence_disa_0");
    level flag::set("BZM_SGENDialogue1_3");
}

// Namespace namespace_fc7d2b5e
// Params 0, eflags: 0x1 linked
// namespace_fc7d2b5e<file_0>::function_1dfa8915
// Checksum 0x21f8fa93, Offset: 0xb58
// Size: 0x24
function function_1dfa8915() {
    level flag::wait_till("BZM_SGENDialogue1_3");
}

// Namespace namespace_fc7d2b5e
// Params 0, eflags: 0x1 linked
// namespace_fc7d2b5e<file_0>::function_3907345a
// Checksum 0x9115de93, Offset: 0xb88
// Size: 0x7c
function function_3907345a() {
    level endon(#"hash_4cb32f3c");
    namespace_36e5bc12::function_cf21d35c("salm_what_was_so_special_0");
    wait(1);
    namespace_36e5bc12::function_ef0ce9fb("plyz_nothing_it_was_supp_0");
    level flag::wait_till("data_recovered");
    namespace_36e5bc12::function_ef0ce9fb("plyz_we_located_an_emf_so_0");
}

// Namespace namespace_fc7d2b5e
// Params 0, eflags: 0x1 linked
// namespace_fc7d2b5e<file_0>::function_7752cc92
// Checksum 0x93f90a7, Offset: 0xc10
// Size: 0x2c
function function_7752cc92() {
    level endon(#"hash_4cb32f3c");
    wait(6);
    namespace_36e5bc12::function_ef0ce9fb("plyz_our_drone_picked_up_0");
}

// Namespace namespace_fc7d2b5e
// Params 0, eflags: 0x1 linked
// namespace_fc7d2b5e<file_0>::function_5f09aec3
// Checksum 0xfdb19684, Offset: 0xc48
// Size: 0x2c
function function_5f09aec3() {
    level endon(#"hash_4cb32f3c");
    wait(6);
    namespace_36e5bc12::function_ef0ce9fb("plyz_when_man_fled_the_vi_0");
}

// Namespace namespace_fc7d2b5e
// Params 0, eflags: 0x1 linked
// namespace_fc7d2b5e<file_0>::function_850c292c
// Checksum 0x357ef152, Offset: 0xc80
// Size: 0x24
function function_850c292c() {
    level endon(#"hash_4cb32f3c");
    namespace_36e5bc12::function_ef0ce9fb("plyz_we_d_reached_the_sil_0");
}

// Namespace namespace_fc7d2b5e
// Params 0, eflags: 0x1 linked
// namespace_fc7d2b5e<file_0>::function_1230a890
// Checksum 0x98285cea, Offset: 0xcb0
// Size: 0x44
function function_1230a890() {
    level endon(#"hash_4cb32f3c");
    wait(5);
    namespace_36e5bc12::function_cf21d35c("salm_did_you_have_any_ink_0");
    namespace_36e5bc12::function_ef0ce9fb("plyz_no_in_hindsight_i_0");
}

// Namespace namespace_fc7d2b5e
// Params 0, eflags: 0x1 linked
// namespace_fc7d2b5e<file_0>::function_ab0ea395
// Checksum 0xfd779eeb, Offset: 0xd00
// Size: 0xc4
function function_ab0ea395() {
    level endon(#"hash_4cb32f3c");
    namespace_36e5bc12::function_cf21d35c("salm_what_did_you_find_be_0");
    wait(0.5);
    namespace_36e5bc12::function_ef0ce9fb("plyz_a_cia_black_project_0");
    namespace_36e5bc12::function_cf21d35c("salm_why_0");
    namespace_36e5bc12::function_ef0ce9fb("plyz_it_would_have_bee_0");
    namespace_36e5bc12::function_cf21d35c("salm_is_it_such_a_bad_thi_0");
    namespace_36e5bc12::function_ef0ce9fb("plyz_we_didn_t_have_a_cho_0");
    wait(1);
    namespace_36e5bc12::function_cf21d35c("salm_those_who_find_fate_0");
}

// Namespace namespace_fc7d2b5e
// Params 0, eflags: 0x1 linked
// namespace_fc7d2b5e<file_0>::function_d1111dfe
// Checksum 0xd6a17071, Offset: 0xdd0
// Size: 0x15c
function function_d1111dfe() {
    level endon(#"hash_4cb32f3c");
    wait(4);
    namespace_36e5bc12::function_cf21d35c("salm_the_human_testing_la_0");
    wait(1);
    namespace_36e5bc12::function_ef0ce9fb("plyz_we_found_the_trut_0");
    namespace_36e5bc12::function_cf21d35c("salm_you_re_certain_of_th_0");
    wait(1);
    namespace_36e5bc12::function_ef0ce9fb("plyz_we_didn_t_have_the_f_0");
    wait(1);
    namespace_36e5bc12::function_ef0ce9fb("plyz_when_the_explosion_h_0");
    wait(1);
    namespace_36e5bc12::function_cf21d35c("salm_what_do_you_mean_ch_0");
    wait(1);
    namespace_36e5bc12::function_ef0ce9fb("plyz_the_winslow_accord_a_0");
    wait(1);
    namespace_36e5bc12::function_ef0ce9fb("plyz_61_15_changed_that_0");
    wait(0.5);
    namespace_36e5bc12::function_ef0ce9fb("plyz_you_re_both_human_a_0");
    wait(0.5);
    namespace_36e5bc12::function_cf21d35c("salm_did_you_find_taylor_0");
    namespace_36e5bc12::function_ef0ce9fb("plyz_no_but_they_d_come_0");
}

// Namespace namespace_fc7d2b5e
// Params 0, eflags: 0x1 linked
// namespace_fc7d2b5e<file_0>::function_f7139867
// Checksum 0xc8cbe6fa, Offset: 0xf38
// Size: 0x4c
function function_f7139867() {
    level endon(#"hash_4cb32f3c");
    wait(2.5);
    namespace_36e5bc12::function_cf21d35c("salm_did_you_know_what_yo_0");
    namespace_36e5bc12::function_ef0ce9fb("plyz_we_couldn_t_have_kno_0");
}

// Namespace namespace_fc7d2b5e
// Params 0, eflags: 0x1 linked
// namespace_fc7d2b5e<file_0>::function_bcee6c40
// Checksum 0x3385116b, Offset: 0xf90
// Size: 0x124
function function_bcee6c40() {
    level endon(#"hash_4cb32f3c");
    wait(17);
    namespace_36e5bc12::function_cf21d35c("salm_you_killed_him_0");
    wait(0.5);
    namespace_36e5bc12::function_ef0ce9fb("plyz_he_left_us_no_choice_0");
    wait(2);
    namespace_36e5bc12::function_cf21d35c("salm_you_needed_to_find_o_0");
    wait(3);
    namespace_36e5bc12::function_ef0ce9fb("plyz_accessing_diaz_s_tho_0");
    wait(4);
    namespace_36e5bc12::function_cf21d35c("salm_knowing_what_you_kno_0");
    wait(1);
    namespace_36e5bc12::function_ef0ce9fb("plyz_that_didn_t_matter_0");
    wait(1);
    namespace_36e5bc12::function_ef0ce9fb("plyz_from_the_interface_0");
    wait(1);
    namespace_36e5bc12::function_cf21d35c("salm_tell_me_about_the_na_0");
    namespace_36e5bc12::function_ef0ce9fb("plyz_the_name_deimos_th_0");
}

// Namespace namespace_fc7d2b5e
// Params 0, eflags: 0x1 linked
// namespace_fc7d2b5e<file_0>::function_549842dc
// Checksum 0xc3ef78e3, Offset: 0x10c0
// Size: 0x6c
function function_549842dc() {
    level endon(#"hash_4cb32f3c");
    wait(16);
    namespace_36e5bc12::function_ef0ce9fb("plyz_goh_xiulan_leader_o_0");
    wait(1);
    namespace_36e5bc12::function_ef0ce9fb("plyz_the_immortals_had_wo_0");
    wait(1);
    namespace_36e5bc12::function_ef0ce9fb("plyz_they_blew_the_suppor_0");
}

// Namespace namespace_fc7d2b5e
// Params 0, eflags: 0x1 linked
// namespace_fc7d2b5e<file_0>::function_c69fb217
// Checksum 0xf4822d26, Offset: 0x1138
// Size: 0x2c
function function_c69fb217() {
    level endon(#"hash_4cb32f3c");
    wait(10);
    namespace_36e5bc12::function_ef0ce9fb("plyz_we_needed_to_get_out_0");
}

// Namespace namespace_fc7d2b5e
// Params 0, eflags: 0x1 linked
// namespace_fc7d2b5e<file_0>::function_e2f0e6a9
// Checksum 0x89a450a7, Offset: 0x1170
// Size: 0x74
function function_e2f0e6a9() {
    wait(13);
    namespace_36e5bc12::function_cf21d35c("salm_and_and_what_hap_0");
    wait(0.5);
    namespace_36e5bc12::function_ef0ce9fb("plyz_we_got_through_it_w_0");
    namespace_36e5bc12::function_ef0ce9fb("plyz_hendricks_learned_ta_0");
    namespace_36e5bc12::function_ef0ce9fb("plyz_but_that_was_the_beg_0");
}

