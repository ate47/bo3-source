#using scripts/codescripts/struct;
#using scripts/cp/_dialog;
#using scripts/cp/_util;
#using scripts/cp/bonuszm/_bonuszm;
#using scripts/cp/bonuszm/_bonuszm_sound;
#using scripts/cp/voice/voice_z_ramses;
#using scripts/shared/callbacks_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/util_shared;

#namespace _bonuszm_ramses;

// Namespace _bonuszm_ramses
// Params 0, eflags: 0x2
// Checksum 0xebb031b3, Offset: 0xba8
// Size: 0x18c
function autoexec init() {
    if (!sessionmodeiscampaignzombiesgame()) {
        return;
    }
    mapname = getdvarstring("mapname");
    if (!issubstr(mapname, "ramses")) {
        return;
    }
    voice_z_ramses::init_voice();
    level.var_af94f480 = &function_dfa3a625;
    level.var_d34cc407 = &function_5a6208e;
    level.var_d2285e9a = &function_2ba89af7;
    level.var_a6e609d2 = &function_9c47b97f;
    level.var_71d5e545 = &function_2a404a44;
    level.var_12f2db0c = &function_4799bc81;
    level.var_4f474e60 = &function_9a51f005;
    level.var_1a96323 = &function_6d9c36ea;
    level.var_3211f2c6 = &function_939eb153;
    level.var_a9b12b6 = &function_4d3f4c83;
    level.var_d6cbae75 = &function_898d5874;
    function_77e3cb91();
}

// Namespace _bonuszm_ramses
// Params 0, eflags: 0x4
// Checksum 0x93710a5, Offset: 0xd40
// Size: 0x24
function private function_77e3cb91() {
    callback::on_spawned(&function_3e52c274);
}

// Namespace _bonuszm_ramses
// Params 0, eflags: 0x0
// Checksum 0x99ec1590, Offset: 0xd70
// Size: 0x4
function function_3e52c274() {
    
}

// Namespace _bonuszm_ramses
// Params 0, eflags: 0x0
// Checksum 0x9089121a, Offset: 0xd80
// Size: 0x2f4
function function_dfa3a625() {
    level endon(#"hash_4cb32f3c");
    wait 6;
    namespace_36e5bc12::function_ef0ce9fb("plyz_the_pieces_were_comi_0");
    wait 2;
    namespace_36e5bc12::function_ef0ce9fb("plyz_hendricks_was_unhing_0");
    wait 1;
    namespace_36e5bc12::function_ef0ce9fb("plyz_kane_came_with_she_0");
    wait 1;
    namespace_36e5bc12::function_ef0ce9fb("plyz_we_weren_t_ready_for_0");
    wait 1;
    namespace_36e5bc12::function_ef0ce9fb("plyz_this_place_if_the_0");
    namespace_36e5bc12::function_ef0ce9fb("plyz_it_wasn_t_just_the_c_0");
    namespace_36e5bc12::function_ef0ce9fb("plyz_between_the_flesh_ea_0");
    namespace_36e5bc12::function_cf21d35c("salm_for_that_very_reason_0");
    namespace_36e5bc12::function_ef0ce9fb("plyz_why_what_were_you_r_0");
    namespace_36e5bc12::function_cf21d35c("salm_from_the_creature_yo_0");
    wait 3;
    namespace_36e5bc12::function_ef0ce9fb("plyz_khalil_was_waiting_0");
    namespace_36e5bc12::function_cf21d35c("salm_how_was_khalil_happ_0");
    namespace_36e5bc12::function_ef0ce9fb("plyz_it_wasn_t_a_warm_wel_0");
    namespace_36e5bc12::function_cf21d35c("salm_he_was_angry_0");
    namespace_36e5bc12::function_ef0ce9fb("plyz_he_was_tired_tired_0");
    namespace_36e5bc12::function_cf21d35c("salm_what_was_coming_0");
    namespace_36e5bc12::function_ef0ce9fb("plyz_extinction_beat_0");
    wait 2;
    namespace_36e5bc12::function_ef0ce9fb("plyz_khalil_s_rage_wasn_t_0");
    wait 2;
    namespace_36e5bc12::function_cf21d35c("salm_what_did_you_hope_to_0");
    wait 1;
    namespace_36e5bc12::function_ef0ce9fb("plyz_how_to_stop_deimos_0");
    wait 3;
    namespace_36e5bc12::function_ef0ce9fb("plyz_kane_asked_what_was_0");
    wait 1;
    namespace_36e5bc12::function_ef0ce9fb("plyz_the_dead_were_moving_0");
    namespace_36e5bc12::function_ef0ce9fb("plyz_that_set_hendricks_o_0");
    namespace_36e5bc12::function_cf21d35c("salm_how_did_khalil_respo_0");
    namespace_36e5bc12::function_ef0ce9fb("plyz_wa_command_was_down_0");
    wait 1;
    namespace_36e5bc12::function_ef0ce9fb("plyz_khalil_led_us_to_int_0");
    namespace_36e5bc12::function_ef0ce9fb("plyz_but_if_we_could_get_0");
}

// Namespace _bonuszm_ramses
// Params 0, eflags: 0x0
// Checksum 0xc99cab19, Offset: 0x1080
// Size: 0x20c
function function_5a6208e() {
    level endon(#"hash_4cb32f3c");
    wait 1;
    namespace_36e5bc12::function_ef0ce9fb("plyz_you_certainly_weren_0");
    namespace_36e5bc12::function_cf21d35c("salm_you_say_it_like_i_ha_0");
    namespace_36e5bc12::function_ef0ce9fb("plyz_with_no_time_we_nee_0");
    namespace_36e5bc12::function_ef0ce9fb("plyz_the_truth_serum_w_0");
    wait 4;
    namespace_36e5bc12::function_ef0ce9fb("plyz_hendricks_told_us_to_1");
    wait 1;
    namespace_36e5bc12::function_ef0ce9fb("plyz_he_asked_about_taylo_0");
    namespace_36e5bc12::function_cf21d35c("salm_and_i_told_him_as_i_0");
    namespace_36e5bc12::function_ef0ce9fb("plyz_like_puppets_on_stri_0");
    namespace_36e5bc12::function_cf21d35c("salm_the_undead_are_mindl_0");
    namespace_36e5bc12::function_ef0ce9fb("plyz_hendricks_wanted_to_0");
    namespace_36e5bc12::function_cf21d35c("salm_for_many_years_i_had_0");
    namespace_36e5bc12::function_cf21d35c("salm_but_he_had_been_pull_0");
    namespace_36e5bc12::function_ef0ce9fb("plyz_the_demigoddess_his_0");
    namespace_36e5bc12::function_cf21d35c("salm_a_pawn_in_a_much_lar_0");
    wait 1;
    namespace_36e5bc12::function_ef0ce9fb("plyz_you_you_told_him_0");
    namespace_36e5bc12::function_cf21d35c("salm_how_does_one_kill_a_0");
    namespace_36e5bc12::function_ef0ce9fb("plyz_was_to_send_him_back_0");
    namespace_36e5bc12::function_cf21d35c("salm_exactly_and_the_onl_0");
    namespace_36e5bc12::function_ef0ce9fb("plyz_is_to_open_the_ga_0");
    namespace_36e5bc12::function_cf21d35c("salm_as_we_are_doing_now_0");
}

// Namespace _bonuszm_ramses
// Params 0, eflags: 0x0
// Checksum 0xcd77bf64, Offset: 0x1298
// Size: 0x4c
function function_2ba89af7() {
    level endon(#"hash_4cb32f3c");
    wait 13;
    namespace_36e5bc12::function_ef0ce9fb("plyz_the_assault_on_ramse_0");
    wait 1;
    namespace_36e5bc12::function_ef0ce9fb("plyz_we_didn_t_have_time_0");
}

// Namespace _bonuszm_ramses
// Params 0, eflags: 0x0
// Checksum 0x2840e34c, Offset: 0x12f0
// Size: 0x2c
function function_9c47b97f() {
    level endon(#"hash_4cb32f3c");
    wait 4;
    namespace_36e5bc12::function_ef0ce9fb("plyz_we_weren_t_ready_for_1");
}

// Namespace _bonuszm_ramses
// Params 0, eflags: 0x0
// Checksum 0x371d89c4, Offset: 0x1328
// Size: 0x4c
function function_2a404a44() {
    level endon(#"hash_4cb32f3c");
    wait 5;
    namespace_36e5bc12::function_ef0ce9fb("plyz_cairo_she_was_a_cit_0");
    wait 4;
    namespace_36e5bc12::function_ef0ce9fb("plyz_he_didn_t_say_it_bu_0");
}

// Namespace _bonuszm_ramses
// Params 0, eflags: 0x0
// Checksum 0x1ab403da, Offset: 0x1380
// Size: 0xbc
function function_4799bc81() {
    level endon(#"hash_4cb32f3c");
    wait 1;
    namespace_36e5bc12::function_ef0ce9fb("plyz_it_was_a_simple_str_0");
    wait 4;
    namespace_36e5bc12::function_ef0ce9fb("plyz_something_knocked_ou_0");
    wait 1;
    namespace_36e5bc12::function_ef0ce9fb("plyz_turns_out_it_wasn_t_0");
    namespace_36e5bc12::function_ef0ce9fb("plyz_cairo_was_no_man_s_l_0");
    wait 1;
    namespace_36e5bc12::function_ef0ce9fb("plyz_i_put_him_in_his_pla_0");
    namespace_36e5bc12::function_ef0ce9fb("plyz_i_grabbed_the_spike_0");
}

// Namespace _bonuszm_ramses
// Params 0, eflags: 0x0
// Checksum 0x48313b65, Offset: 0x1448
// Size: 0x2c
function function_9a51f005() {
    level endon(#"hash_4cb32f3c");
    wait 2;
    namespace_36e5bc12::function_ef0ce9fb("plyz_we_detonated_the_las_0");
}

// Namespace _bonuszm_ramses
// Params 0, eflags: 0x0
// Checksum 0x4bef2823, Offset: 0x1480
// Size: 0xcc
function function_6d9c36ea() {
    level endon(#"hash_4cb32f3c");
    wait 4;
    namespace_36e5bc12::function_ef0ce9fb("plyz_our_triggerman_got_h_0");
    level flag::wait_till("arena_defend_detonator_pickup");
    wait 5;
    namespace_36e5bc12::function_ef0ce9fb("plyz_i_told_hendricks_i_n_0");
    wait 9;
    namespace_36e5bc12::function_ef0ce9fb("plyz_good_thing_hendricks_0");
    wait 26;
    namespace_36e5bc12::function_ef0ce9fb("plyz_khalil_thanked_us_0");
    wait 6;
    namespace_36e5bc12::function_ef0ce9fb("plyz_egyptian_army_comman_0");
}

// Namespace _bonuszm_ramses
// Params 0, eflags: 0x0
// Checksum 0x31ffaad2, Offset: 0x1558
// Size: 0x13c
function function_939eb153() {
    level endon(#"hash_4cb32f3c");
    wait 1;
    namespace_36e5bc12::function_ef0ce9fb("plyz_i_gave_hendricks_a_h_0");
    wait 1;
    namespace_36e5bc12::function_cf21d35c("salm_you_went_in_to_save_0");
    namespace_36e5bc12::function_ef0ce9fb("plyz_does_that_matter_0");
    namespace_36e5bc12::function_ef0ce9fb("plyz_there_were_so_few_of_0");
    wait 0.5;
    namespace_36e5bc12::function_ef0ce9fb("plyz_i_d_take_it_0");
    wait 1;
    wait 12;
    namespace_36e5bc12::function_cf21d35c("salm_strange_even_with_0");
    namespace_36e5bc12::function_cf21d35c("salm_he_clung_to_life_wit_0");
    wait 4;
    namespace_36e5bc12::function_ef0ce9fb("plyz_turns_out_it_didn_t_0");
    wait 11;
    namespace_36e5bc12::function_ef0ce9fb("plyz_he_didn_t_survive_th_0");
    wait 1;
    namespace_36e5bc12::function_ef0ce9fb("plyz_safiya_square_was_a_0");
}

// Namespace _bonuszm_ramses
// Params 0, eflags: 0x0
// Checksum 0x6d27bde7, Offset: 0x16a0
// Size: 0x8c
function function_4d3f4c83() {
    level endon(#"hash_4cb32f3c");
    level flag::wait_till("quad_tank_2_spawned");
    wait 1;
    namespace_36e5bc12::function_ef0ce9fb("plyz_it_didn_t_take_long_0");
    level flag::wait_till("spawn_quad_tank_3");
    wait 4;
    namespace_36e5bc12::function_ef0ce9fb("plyz_it_was_only_a_matter_0");
}

// Namespace _bonuszm_ramses
// Params 0, eflags: 0x0
// Checksum 0x8af22037, Offset: 0x1738
// Size: 0x1f4
function function_898d5874() {
    level endon(#"hash_4cb32f3c");
    wait 1;
    namespace_36e5bc12::function_ef0ce9fb("plyz_we_d_cleared_the_pla_0");
    wait 2;
    namespace_36e5bc12::function_cf21d35c("salm_what_did_you_hear_1");
    namespace_36e5bc12::function_ef0ce9fb("plyz_nothing_and_that_wa_0");
    wait 1;
    namespace_36e5bc12::function_ef0ce9fb("plyz_something_had_taken_0");
    wait 1;
    namespace_36e5bc12::function_ef0ce9fb("plyz_we_saw_reinforcement_0");
    wait 4;
    namespace_36e5bc12::function_ef0ce9fb("plyz_we_got_out_of_the_op_0");
    namespace_36e5bc12::function_ef0ce9fb("plyz_and_there_it_was_th_0");
    namespace_36e5bc12::function_ef0ce9fb("plyz_kane_came_over_comms_0");
    wait 1.5;
    namespace_36e5bc12::function_cf21d35c("salm_and_hendricks_0");
    namespace_36e5bc12::function_ef0ce9fb("plyz_his_mind_was_melting_0");
    namespace_36e5bc12::function_ef0ce9fb("plyz_he_didn_t_like_that_0");
    namespace_36e5bc12::function_cf21d35c("salm_he_attacked_you_0");
    namespace_36e5bc12::function_ef0ce9fb("plyz_i_told_you_it_wasn_0");
    namespace_36e5bc12::function_ef0ce9fb("plyz_he_wasn_t_buying_thi_0");
    namespace_36e5bc12::function_cf21d35c("salm_what_did_he_say_0");
    namespace_36e5bc12::function_b4a3e925("dolo_salim_lies_0");
    namespace_36e5bc12::function_ef0ce9fb("plyz_he_didn_t_think_open_0");
    wait 1;
    namespace_36e5bc12::function_ef0ce9fb("plyz_are_you_0");
}

