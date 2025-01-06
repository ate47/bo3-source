#using scripts/codescripts/struct;
#using scripts/cp/_dialog;
#using scripts/cp/_util;
#using scripts/cp/bonuszm/_bonuszm;
#using scripts/cp/bonuszm/_bonuszm_sound;
#using scripts/cp/voice/voice_z_provocation;
#using scripts/shared/array_shared;
#using scripts/shared/util_shared;

#namespace _bonuszm_biodomes1;

// Namespace _bonuszm_biodomes1
// Params 0, eflags: 0x2
// Checksum 0x2e0d034f, Offset: 0x768
// Size: 0x1bc
function autoexec init() {
    if (!sessionmodeiscampaignzombiesgame()) {
        return;
    }
    mapname = getdvarstring("mapname");
    if (mapname == "cp_mi_sing_biodomes" || mapname == "cp_mi_sing_biodomes2") {
        voice_z_provocation::init_voice();
        level.var_6253d0f1 = &function_30d5fd50;
        level.var_e27ad46e = &function_a2dd6c8b;
        level.var_8b9b1711 = &function_8d77af70;
        level.var_80a07074 = &function_b37a29d9;
        level.var_fd93406f = &function_71868de6;
        level.var_d9cf116b = &function_7cdaf222;
        level.var_4d395988 = &function_eee2615d;
        level.var_21d18cf5 = &function_c8dfe6f4;
        level.var_46d46f79 = &function_ed187ea8;
        level.var_4aa51716 = &function_5f1fede3;
        level.var_e32d12f3 = &function_391d737a;
        level.var_9910c090 = &function_ab24e2b5;
        level.var_167fa382 = &function_3ae7562f;
        function_f0d84c78();
    }
}

// Namespace _bonuszm_biodomes1
// Params 0, eflags: 0x0
// Checksum 0xdae52221, Offset: 0x930
// Size: 0x1b2
function function_f0d84c78() {
    var_80b8c18d = [];
    array::add(var_80b8c18d, "warehouse");
    array::add(var_80b8c18d, "cloudmountain");
    array::add(var_80b8c18d, "markets1");
    array::add(var_80b8c18d, "markets2");
    foreach (str_area in var_80b8c18d) {
        var_9108873 = getent("trig_out_of_bound_" + str_area, "targetname");
        e_clip = getent("player_clip_" + str_area, "targetname");
        if (isdefined(var_9108873)) {
            var_9108873 delete();
        }
        if (isdefined(e_clip)) {
            e_clip delete();
        }
    }
}

// Namespace _bonuszm_biodomes1
// Params 0, eflags: 0x0
// Checksum 0x71d3ea7e, Offset: 0xaf0
// Size: 0x1c4
function function_30d5fd50() {
    level endon(#"hash_4cb32f3c");
    wait 1;
    namespace_36e5bc12::function_ef0ce9fb("plyz_getting_in_was_easy_0");
    wait 1;
    namespace_36e5bc12::function_ef0ce9fb("plyz_at_the_time_the_biod_0");
    wait 1;
    namespace_36e5bc12::function_ef0ce9fb("plyz_hendricks_had_a_cont_0");
    wait 1;
    namespace_36e5bc12::function_ef0ce9fb("plyz_not_only_that_they_0");
    namespace_36e5bc12::function_cf21d35c("salm_they_had_this_inform_0");
    namespace_36e5bc12::function_ef0ce9fb("plyz_they_claimed_to_dan_0");
    wait 2;
    namespace_36e5bc12::function_ef0ce9fb("plyz_still_didn_t_mean_t_0");
    wait 2;
    namespace_36e5bc12::function_ef0ce9fb("plyz_but_that_didn_t_chan_0");
    namespace_36e5bc12::function_cf21d35c("salm_you_cannot_blame_you_0");
    namespace_36e5bc12::function_cf21d35c("salm_there_were_powers_in_0");
    namespace_36e5bc12::function_ef0ce9fb("plyz_you_mean_deimos_0");
    namespace_36e5bc12::function_cf21d35c("salm_how_do_you_mean_0");
    namespace_36e5bc12::function_ef0ce9fb("plyz_know_that_saying_to_0");
    namespace_36e5bc12::function_cf21d35c("salm_the_goh_siblings_da_0");
    namespace_36e5bc12::function_ef0ce9fb("plyz_no_no_no_this_was_0");
    wait 1;
    namespace_36e5bc12::function_ef0ce9fb("plyz_thing_about_deadkill_0");
}

// Namespace _bonuszm_biodomes1
// Params 0, eflags: 0x0
// Checksum 0xaa6c1a73, Offset: 0xcc0
// Size: 0x84
function function_a2dd6c8b() {
    level endon(#"hash_4cb32f3c");
    wait 6;
    namespace_36e5bc12::function_ef0ce9fb("plyz_we_d_worried_about_b_0");
    wait 1;
    namespace_36e5bc12::function_ef0ce9fb("plyz_it_became_quickly_ap_0");
    namespace_36e5bc12::function_ef0ce9fb("plyz_it_was_about_to_beco_0");
    wait 1;
    namespace_36e5bc12::function_ef0ce9fb("plyz_we_had_to_move_we_h_0");
}

// Namespace _bonuszm_biodomes1
// Params 0, eflags: 0x0
// Checksum 0x263abb85, Offset: 0xd50
// Size: 0x24
function function_8d77af70() {
    level endon(#"hash_4cb32f3c");
    namespace_36e5bc12::function_ef0ce9fb("plyz_i_don_t_know_how_the_0");
}

// Namespace _bonuszm_biodomes1
// Params 0, eflags: 0x0
// Checksum 0x130a7d84, Offset: 0xd80
// Size: 0x24
function function_b37a29d9() {
    level endon(#"hash_4cb32f3c");
    namespace_36e5bc12::function_ef0ce9fb("plyz_we_heard_that_famili_0");
}

// Namespace _bonuszm_biodomes1
// Params 0, eflags: 0x0
// Checksum 0xd74c61e5, Offset: 0xdb0
// Size: 0x2c
function function_71868de6() {
    level endon(#"hash_4cb32f3c");
    wait 6;
    namespace_36e5bc12::function_ef0ce9fb("plyz_with_the_shipping_ya_0");
}

// Namespace _bonuszm_biodomes1
// Params 0, eflags: 0x0
// Checksum 0xed9724ce, Offset: 0xde8
// Size: 0x16c
function function_7cdaf222() {
    level endon(#"hash_4cb32f3c");
    wait 2;
    namespace_36e5bc12::function_cf21d35c("salm_what_happened_in_the_0");
    wait 1;
    namespace_36e5bc12::function_ef0ce9fb("plyz_by_the_time_we_got_t_0");
    namespace_36e5bc12::function_cf21d35c("salm_why_did_she_lock_you_0");
    wait 1;
    namespace_36e5bc12::function_ef0ce9fb("plyz_it_sounded_crazy_bu_0");
    wait 1;
    namespace_36e5bc12::function_ef0ce9fb("plyz_hendricks_tried_to_g_0");
    wait 1;
    namespace_36e5bc12::function_ef0ce9fb("plyz_we_could_hear_the_ho_0");
    wait 1;
    namespace_36e5bc12::function_ef0ce9fb("plyz_but_she_did_have_two_0");
    namespace_36e5bc12::function_cf21d35c("salm_you_cut_off_her_hand_0");
    namespace_36e5bc12::function_ef0ce9fb("plyz_i_took_a_gamble_i_h_0");
    wait 2;
    namespace_36e5bc12::function_ef0ce9fb("plyz_and_it_did_0");
    wait 1;
    namespace_36e5bc12::function_ef0ce9fb("plyz_hendricks_interfaced_0");
    namespace_36e5bc12::function_ef0ce9fb("plyz_finding_out_what_goh_0");
}

// Namespace _bonuszm_biodomes1
// Params 0, eflags: 0x0
// Checksum 0x25e625fb, Offset: 0xf60
// Size: 0x3c
function function_eee2615d() {
    level endon(#"hash_4cb32f3c");
    namespace_36e5bc12::function_ef0ce9fb("plyz_hendricks_extracted_0");
    namespace_36e5bc12::function_ef0ce9fb("plyz_our_pick_up_was_in_p_0");
}

// Namespace _bonuszm_biodomes1
// Params 0, eflags: 0x0
// Checksum 0xf224f8a2, Offset: 0xfa8
// Size: 0x2c
function function_c8dfe6f4() {
    level endon(#"hash_4cb32f3c");
    wait 8;
    namespace_36e5bc12::function_ef0ce9fb("plyz_our_bird_wasn_t_alon_0");
}

// Namespace _bonuszm_biodomes1
// Params 0, eflags: 0x0
// Checksum 0xdd0a70be, Offset: 0xfe0
// Size: 0x6c
function function_ed187ea8() {
    level endon(#"hash_4cb32f3c");
    wait 2;
    namespace_36e5bc12::function_ef0ce9fb("plyz_with_in_those_flesh_0");
    wait 1;
    namespace_36e5bc12::function_ef0ce9fb("plyz_we_had_to_haul_ass_a_0");
    wait 1;
    namespace_36e5bc12::function_ef0ce9fb("plyz_but_they_weren_t_our_0");
}

// Namespace _bonuszm_biodomes1
// Params 0, eflags: 0x0
// Checksum 0xd5ff2968, Offset: 0x1058
// Size: 0x44
function function_5f1fede3() {
    level endon(#"hash_4cb32f3c");
    namespace_36e5bc12::function_ef0ce9fb("plyz_the_supertree_was_co_0");
    wait 1;
    namespace_36e5bc12::function_ef0ce9fb("plyz_chatter_confirmed_th_0");
}

// Namespace _bonuszm_biodomes1
// Params 0, eflags: 0x0
// Checksum 0xa6ed8c8, Offset: 0x10a8
// Size: 0x44
function function_391d737a() {
    level endon(#"hash_4cb32f3c");
    namespace_36e5bc12::function_ef0ce9fb("plyz_from_the_sound_of_it_0");
    wait 6;
    namespace_36e5bc12::function_ef0ce9fb("plyz_looked_like_we_were_0");
}

// Namespace _bonuszm_biodomes1
// Params 0, eflags: 0x0
// Checksum 0xb7503599, Offset: 0x10f8
// Size: 0xbc
function function_ab24e2b5() {
    level endon(#"hash_4cb32f3c");
    wait 1;
    namespace_36e5bc12::function_ef0ce9fb("plyz_hendricks_commandeer_0");
    wait 2;
    namespace_36e5bc12::function_cf21d35c("plyz_and_that_hunter_stil_0");
    wait 57;
    namespace_36e5bc12::function_cf21d35c("salm_but_you_escaped_0");
    wait 1;
    namespace_36e5bc12::function_ef0ce9fb("plyz_our_exfil_was_just_a_0");
    namespace_36e5bc12::function_cf21d35c("salm_what_about_taylor_w_0");
    namespace_36e5bc12::function_ef0ce9fb("plyz_nothing_it_had_been_0");
}

// Namespace _bonuszm_biodomes1
// Params 0, eflags: 0x0
// Checksum 0x6ebf487f, Offset: 0x11c0
// Size: 0xe
function function_3ae7562f() {
    level endon(#"hash_4cb32f3c");
}

