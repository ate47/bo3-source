#using scripts/codescripts/struct;
#using scripts/cp/voice/voice_vengeance;
#using scripts/shared/clientfield_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/music_shared;
#using scripts/shared/stealth;
#using scripts/shared/stealth_vo;
#using scripts/shared/util_shared;

#namespace cp_mi_sing_vengeance_sound;

// Namespace cp_mi_sing_vengeance_sound
// Params 0, eflags: 0x0
// Checksum 0xbfb99819, Offset: 0xb20
// Size: 0x8a
function main() {
    voice_vengeance::init_voice();
    clientfield::register("toplayer", "slowmo_duck_active", 1, 2, "int");
    level.music_ent = spawn("script_origin", (0, 0, 0));
    thread function_36f2421a();
    level thread function_13172f06();
    level thread function_6ab7f285();
}

// Namespace cp_mi_sing_vengeance_sound
// Params 0, eflags: 0x0
// Checksum 0x23e4261e, Offset: 0xbb8
// Size: 0x52
function function_6ab7f285() {
    level waittill(#"hash_dcd7454a");
    util::clientnotify("sndCafe");
    level thread function_bf4fd572();
    level waittill(#"hash_654ba091");
    util::clientnotify("sndCafeEnd");
}

// Namespace cp_mi_sing_vengeance_sound
// Params 0, eflags: 0x0
// Checksum 0x86f51b39, Offset: 0xc18
// Size: 0x22
function function_bf4fd572() {
    level waittill(#"hash_cdfdddaf");
    util::clientnotify("sndCafeOR");
}

// Namespace cp_mi_sing_vengeance_sound
// Params 0, eflags: 0x0
// Checksum 0xe9c07cd6, Offset: 0xc48
// Size: 0x2
function function_4368969a() {
    
}

// Namespace cp_mi_sing_vengeance_sound
// Params 0, eflags: 0x0
// Checksum 0x85f9b11, Offset: 0xc58
// Size: 0x1a
function apartment_init() {
    stealth::function_76c2ffe4("unaware");
}

// Namespace cp_mi_sing_vengeance_sound
// Params 0, eflags: 0x0
// Checksum 0x95d2e0db, Offset: 0xc80
// Size: 0x1a
function function_7be69db9() {
    stealth::function_76c2ffe4("unaware");
}

// Namespace cp_mi_sing_vengeance_sound
// Params 0, eflags: 0x0
// Checksum 0xa4991add, Offset: 0xca8
// Size: 0x2a
function function_749aad88() {
    stealth::function_76c2ffe4("unaware");
    level thread namespace_9fd035::function_e18f629a();
}

// Namespace cp_mi_sing_vengeance_sound
// Params 0, eflags: 0x0
// Checksum 0xe9c07cd6, Offset: 0xce0
// Size: 0x2
function function_34d7007d() {
    
}

// Namespace cp_mi_sing_vengeance_sound
// Params 0, eflags: 0x0
// Checksum 0x50b0520d, Offset: 0xcf0
// Size: 0x22
function garage_init() {
    level thread namespace_9fd035::function_f64b08fb();
    level thread namespace_9fd035::function_46333a8a();
}

// Namespace cp_mi_sing_vengeance_sound
// Params 0, eflags: 0x0
// Checksum 0x3198330d, Offset: 0xd20
// Size: 0x1a
function function_d56e8ba6() {
    thread function_9d83fdd3("mus_combat", 1, 3);
}

// Namespace cp_mi_sing_vengeance_sound
// Params 0, eflags: 0x0
// Checksum 0x24691540, Offset: 0xd48
// Size: 0x1a
function function_1fc1836b() {
    thread function_9d83fdd3("mus_medium", 1, 3);
}

// Namespace cp_mi_sing_vengeance_sound
// Params 0, eflags: 0x0
// Checksum 0x9f5bfb09, Offset: 0xd70
// Size: 0x1a
function function_1a02fe3() {
    thread function_9d83fdd3("mus_stealth_high_temp", 1);
}

// Namespace cp_mi_sing_vengeance_sound
// Params 0, eflags: 0x0
// Checksum 0x144fb45b, Offset: 0xd98
// Size: 0x1a
function function_eb9cdcd9() {
    stealth::function_76c2ffe4("unaware");
}

// Namespace cp_mi_sing_vengeance_sound
// Params 0, eflags: 0x0
// Checksum 0x92488680, Offset: 0xdc0
// Size: 0x22
function function_6dcacaf4() {
    playsoundatposition("evt_intro_trucks_by", (18398, -4638, 324));
}

// Namespace cp_mi_sing_vengeance_sound
// Params 0, eflags: 0x0
// Checksum 0xf4e6f8d5, Offset: 0xdf0
// Size: 0x6a
function function_677a24e2() {
    playsoundatposition("evt_apt_upstairs_fight", (19517, -5375, 475));
    playsoundatposition("evt_apt_int_panic_1", (19517, -5375, 475));
    wait 2;
    playsoundatposition("evt_apt_win_gunfire_1", (19517, -5375, 475));
}

// Namespace cp_mi_sing_vengeance_sound
// Params 0, eflags: 0x0
// Checksum 0x6beefb6e, Offset: 0xe68
// Size: 0x62
function function_13172f06() {
    trigger = getent("trigger_wood_creak", "targetname");
    if (!isdefined(trigger)) {
        return;
    }
    trigger waittill(#"trigger");
    playsoundatposition("evt_apt_wood_creak", (19421, -5113, 347));
}

// Namespace cp_mi_sing_vengeance_sound
// Params 0, eflags: 0x0
// Checksum 0x7d91a91b, Offset: 0xed8
// Size: 0x42
function function_afc6fda4() {
    playsoundatposition("evt_apt_upstairs_thud", (19536, -5447, 467));
    playsoundatposition("evt_apt_int_panic_2", (19517, -5375, 475));
}

// Namespace cp_mi_sing_vengeance_sound
// Params 0, eflags: 0x0
// Checksum 0x726e2355, Offset: 0xf28
// Size: 0x22
function function_57ec1ad7() {
    playsoundatposition("evt_apt_int_panic_3", (19517, -5375, 475));
}

// Namespace cp_mi_sing_vengeance_sound
// Params 0, eflags: 0x0
// Checksum 0x4d156af8, Offset: 0xf58
// Size: 0xca
function function_4ac99079() {
    playerlist = getplayers();
    foreach (player in playerlist) {
        thread function_a66aea7e(player);
        thread function_fe8ea4c4(player);
    }
    level.var_2fd26037 waittill(#"takedown_start");
    thread function_4f84abfa();
    level.var_2fd26037 waittill(#"hash_955d6809");
    thread function_a339da70();
}

// Namespace cp_mi_sing_vengeance_sound
// Params 1, eflags: 0x0
// Checksum 0xcd0576db, Offset: 0x1030
// Size: 0xf2
function function_a66aea7e(player) {
    player endon(#"death");
    player endon(#"disconnect");
    player waittill(#"hash_b8988b75");
    if (!isdefined(player.anim_debug_name)) {
        return;
    }
    if (player.anim_debug_name == "player 1") {
        player playsoundtoplayer("evt_takedown_setup_player1", player);
        return;
    }
    if (player.anim_debug_name == "player 2") {
        player playsoundtoplayer("evt_takedown_setup_player2", player);
        return;
    }
    if (player.anim_debug_name == "player 3") {
        player playsoundtoplayer("evt_takedown_setup_player3", player);
        return;
    }
    if (player.anim_debug_name == "player 4") {
        player playsoundtoplayer("evt_takedown_setup_player4", player);
    }
}

// Namespace cp_mi_sing_vengeance_sound
// Params 1, eflags: 0x0
// Checksum 0x278f43b8, Offset: 0x1130
// Size: 0x172
function function_fe8ea4c4(player) {
    player endon(#"death");
    player endon(#"disconnect");
    level.var_2fd26037 waittill(#"takedown_start");
    if (!isdefined(player.anim_debug_name)) {
        return;
    }
    if (player.anim_debug_name == "player 1") {
        player playsoundtoplayer("evt_takedown_player1_slide", player);
        player playsoundtoplayer("evt_takedown_player1_foley", player);
        player playsoundtoplayer("evt_takedown_player1", player);
        return;
    }
    if (player.anim_debug_name == "player 2") {
        player playsoundtoplayer("evt_takedown_player2_foley", player);
        player playsoundtoplayer("evt_takedown_player2", player);
        return;
    }
    if (player.anim_debug_name == "player 3") {
        player playsoundtoplayer("evt_takedown_player3_foley", player);
        player playsoundtoplayer("evt_takedown_player3", player);
        return;
    }
    if (player.anim_debug_name == "player 4") {
        player playsoundtoplayer("evt_takedown_player4_foley", player);
        player playsoundtoplayer("evt_takedown_player4", player);
    }
}

// Namespace cp_mi_sing_vengeance_sound
// Params 0, eflags: 0x0
// Checksum 0x207c7a28, Offset: 0x12b0
// Size: 0x11a
function function_4f84abfa() {
    thread function_9430961e(1.5);
    stealth::function_862e861f(1.5);
    playerlist = getplayers();
    foreach (player in playerlist) {
        player playsoundtoplayer("evt_takedown_slowmo_01", player);
        player playsoundtoplayer("evt_takedown_hendricks_shot_low", player);
    }
    playsoundatposition("evt_takedown_hendricks_shot", (20387, -4854, 401));
    level thread namespace_9fd035::function_fedfbdb0();
    wait 0.6;
    playsoundatposition("veh_siege_bot_disable", (20692, -4683, -32));
}

// Namespace cp_mi_sing_vengeance_sound
// Params 0, eflags: 0x0
// Checksum 0x66c90981, Offset: 0x13d8
// Size: 0x93
function function_a339da70() {
    playerlist = getplayers();
    foreach (player in playerlist) {
        player playsoundtoplayer("evt_takedown_slowmo_02", player);
        player clientfield::set_to_player("slowmo_duck_active", 1);
    }
}

// Namespace cp_mi_sing_vengeance_sound
// Params 0, eflags: 0x0
// Checksum 0x6fc88808, Offset: 0x1478
// Size: 0xda
function function_69fc18eb() {
    playerlist = getplayers();
    foreach (player in playerlist) {
        player playsoundtoplayer("evt_takedown_slowmo_exit", player);
        player clientfield::set_to_player("slowmo_duck_active", 0);
    }
    thread function_9d83fdd3("mus_combat", 1);
    level waittill(#"takedown_backup_enemies_dead");
    function_9430961e(3);
    stealth::function_76c2ffe4("unaware");
}

// Namespace cp_mi_sing_vengeance_sound
// Params 1, eflags: 0x0
// Checksum 0xc767bc3c, Offset: 0x1560
// Size: 0x5a
function takedown_siegebot(var_3bae1206) {
    var_3bae1206 waittill(#"hash_76ee36bc");
    playsoundatposition("evt_siegebot_death_anim", var_3bae1206.origin);
    playsoundatposition("evt_siegebot_powerdown", var_3bae1206.origin);
}

// Namespace cp_mi_sing_vengeance_sound
// Params 0, eflags: 0x0
// Checksum 0x34a79ac5, Offset: 0x15c8
// Size: 0x4a
function function_68da61d9() {
    playsoundatposition("evt_civ_running", (20892, -2913, -52));
    wait 1.2;
    playsoundatposition("wpn_sfb_fire_npc", (20971, -2670, -69));
}

// Namespace cp_mi_sing_vengeance_sound
// Params 0, eflags: 0x0
// Checksum 0xa0327b69, Offset: 0x1620
// Size: 0x2a
function function_b3768e28() {
    wait 0.5;
    playsoundatposition("amb_alley_ambient_expl", (22979, 1285, -94));
}

// Namespace cp_mi_sing_vengeance_sound
// Params 0, eflags: 0x0
// Checksum 0x2f1cd5c8, Offset: 0x1658
// Size: 0x22
function function_2afbdce() {
    playsoundatposition("amb_alley_gate_rattle", (22103, 1982, -121));
}

// Namespace cp_mi_sing_vengeance_sound
// Params 0, eflags: 0x0
// Checksum 0x9efb536b, Offset: 0x1688
// Size: 0x2a
function function_10de79ba() {
    function_9430961e(3);
    wait 3;
    function_9d83fdd3("mus_stealth_high_temp", 1);
}

// Namespace cp_mi_sing_vengeance_sound
// Params 0, eflags: 0x0
// Checksum 0xc0f96789, Offset: 0x16c0
// Size: 0x52
function function_af95bc45() {
    thread function_a2c917e3();
    wait 2.9;
    function_9430961e(0.25);
    playsoundatposition("evt_quad_tank_approach", (-18946, -17409, -105));
}

// Namespace cp_mi_sing_vengeance_sound
// Params 0, eflags: 0x0
// Checksum 0x195a5f97, Offset: 0x1720
// Size: 0x82
function function_a2c917e3() {
    playsoundatposition("evt_quad_tank_step_approach", (-18946, -17409, -105));
    wait 1;
    playsoundatposition("evt_quad_tank_step_approach", (-18946, -17409, -105));
    wait 1;
    playsoundatposition("evt_quad_tank_step_approach", (-18946, -17409, -105));
    wait 1;
    playsoundatposition("evt_quad_tank_step_approach", (-18946, -17409, -105));
}

// Namespace cp_mi_sing_vengeance_sound
// Params 0, eflags: 0x0
// Checksum 0xad54727c, Offset: 0x17b0
// Size: 0x62
function function_5bd9fe4() {
    wait 0.5;
    playsoundatposition("evt_quad_tank_enter", (-18946, -17409, -105));
    level thread namespace_9fd035::function_8d18c8bc();
    level flag::wait_till("quad_tank_dead");
    level thread namespace_9fd035::function_fa2e45b8();
}

// Namespace cp_mi_sing_vengeance_sound
// Params 1, eflags: 0x0
// Checksum 0xbd4adb27, Offset: 0x1820
// Size: 0x22
function function_a34878f1(player) {
    player playlocalsound("dst_rock_quake");
}

// Namespace cp_mi_sing_vengeance_sound
// Params 1, eflags: 0x0
// Checksum 0xddd0276, Offset: 0x1850
// Size: 0x5a
function function_f3b31be1(org) {
    playsoundatposition("amb_fire_burst", org);
    ent = spawn("script_origin", org);
    ent playloopsound("amb_fire_medium");
}

// Namespace cp_mi_sing_vengeance_sound
// Params 0, eflags: 0x0
// Checksum 0x213c2823, Offset: 0x18b8
// Size: 0xb2
function function_c4ece2ab() {
    playsoundatposition("dst_rock_quake_big", (-19005, -12018, 119));
    wait 1;
    playsoundatposition("evt_stairwell_shake_02", (-19005, -12018, 119));
    playsoundatposition("evt_stairwell_shake_04", (-18981, -11953, 95));
    wait 0.25;
    playsoundatposition("evt_stairwell_shake_03", (-19022, -12075, 102));
    wait 0.35;
    playsoundatposition("evt_stairwell_shake_01", (-18923, -12014, 14));
}

// Namespace cp_mi_sing_vengeance_sound
// Params 0, eflags: 0x0
// Checksum 0xa83e9635, Offset: 0x1978
// Size: 0x3a2
function function_47d9d5db() {
    stealth_vo::function_5714528b("enemy_right", "hend_on_your_right_1");
    stealth_vo::function_5714528b("enemy_left", "hend_on_your_left_1");
    stealth_vo::function_5714528b("enemy_ahead", "hend_tango_directly_ahead_1");
    stealth_vo::function_5714528b("enemy_behind", "hend_tango_behind_you_1");
    stealth_vo::function_5714528b("enemy_above", "hend_enemy_above_you_1");
    stealth_vo::function_5714528b("enemy_below", "hend_below_you_1");
    stealth_vo::function_5714528b("good_kill", "hend_good_kill_1");
    stealth_vo::function_5714528b("good_kill_bullet", "hend_nice_shot_1");
    stealth_vo::function_5714528b("good_kill_impressive", "hend_impressive_0");
    stealth_vo::function_5714528b("close_call", "hend_that_was_close_1");
    stealth_vo::function_5714528b("investigating", "hend_they_re_looking_arou_1");
    stealth_vo::function_5714528b("investigating", "hend_get_outta_sight_1");
    stealth_vo::function_5714528b("investigating", "hend_you_spooked_em_hid_1");
    stealth_vo::function_5714528b("returning", "hend_you_re_clear_threat_0");
    stealth_vo::function_5714528b("returning", "hend_all_clear_they_re_m_1");
    stealth_vo::function_5714528b("spotted", "hend_kill_em_quick_0");
    stealth_vo::function_5714528b("spotted", "hend_take_em_down_quick_1");
    stealth_vo::function_5714528b("spotted_sniper", "hend_sniper_spotted_you_1");
    stealth_vo::function_5714528b("spotted_sniper", "hend_snipers_on_the_roofs_1");
    stealth_vo::function_5714528b("spotted_drone", "hend_drone_has_you_target_1");
    stealth_vo::function_5714528b("spotted_drone", "hend_drone_is_tracking_yo_1");
    stealth_vo::function_5714528b("careful", "hend_easy_wait_till_no_o_1");
    stealth_vo::function_5714528b("careful_hack", "hend_that_drone_could_be_1");
    stealth_vo::function_5714528b("careful_hunter", "hend_don_t_even_think_abo_1");
    stealth_vo::function_5714528b("careful_tricky", "hend_that_s_too_tricky_i_0");
    stealth::function_8bb61d8e("unaware", "mus_stealth_low_temp");
    stealth::function_8bb61d8e("low_alert", "mus_stealth_high_temp");
    stealth::function_8bb61d8e("high_alert", "mus_stealth_high_temp");
    stealth::function_8bb61d8e("combat", "mus_highalert_temp");
}

// Namespace cp_mi_sing_vengeance_sound
// Params 3, eflags: 0x0
// Checksum 0x38923d65, Offset: 0x1d28
// Size: 0xc3
function function_9d83fdd3(alias, is_loop, var_aa56a49b) {
    if (is_loop) {
        fade = 0;
        if (isdefined(var_aa56a49b)) {
            fade = var_aa56a49b;
        }
        level.music_ent playloopsound(alias, fade);
        return;
    }
    foreach (player in getplayers()) {
        player playsoundtoplayer(alias, player);
    }
}

// Namespace cp_mi_sing_vengeance_sound
// Params 1, eflags: 0x0
// Checksum 0xf4dcc95b, Offset: 0x1df8
// Size: 0x22
function function_9430961e(fade) {
    level.music_ent stoploopsound(fade);
}

// Namespace cp_mi_sing_vengeance_sound
// Params 0, eflags: 0x0
// Checksum 0xe9c07cd6, Offset: 0x1e28
// Size: 0x2
function function_36f2421a() {
    
}

// Namespace cp_mi_sing_vengeance_sound
// Params 0, eflags: 0x0
// Checksum 0xd800b3c3, Offset: 0x1e38
// Size: 0x22
function function_6fd5af18() {
    level waittill(#"hash_126ce70b");
    iprintlnbold("anim1 started");
}

// Namespace cp_mi_sing_vengeance_sound
// Params 0, eflags: 0x0
// Checksum 0xd17809d1, Offset: 0x1e68
// Size: 0x22
function function_e1dd1e53() {
    level waittill(#"hash_a06577d0");
    iprintlnbold("anim2 started");
}

// Namespace cp_mi_sing_vengeance_sound
// Params 0, eflags: 0x0
// Checksum 0x318a25af, Offset: 0x1e98
// Size: 0x22
function function_bbdaa3ea() {
    level waittill(#"hash_c667f239");
    iprintlnbold("anim3 started");
}

#namespace namespace_9fd035;

// Namespace namespace_9fd035
// Params 0, eflags: 0x0
// Checksum 0xb6473a98, Offset: 0x1ec8
// Size: 0x1a
function function_973b77f9() {
    music::setmusicstate("none");
}

// Namespace namespace_9fd035
// Params 0, eflags: 0x0
// Checksum 0x80e7d6db, Offset: 0x1ef0
// Size: 0x1a
function function_7dc66faa() {
    music::setmusicstate("igc_1_intro");
}

// Namespace namespace_9fd035
// Params 0, eflags: 0x0
// Checksum 0xe5e51831, Offset: 0x1f18
// Size: 0x1a
function function_d4c52995() {
    music::setmusicstate("tension_loop");
}

// Namespace namespace_9fd035
// Params 0, eflags: 0x0
// Checksum 0xfd6a0cca, Offset: 0x1f40
// Size: 0x1a
function function_fedfbdb0() {
    music::setmusicstate("igc_2_zipline");
}

// Namespace namespace_9fd035
// Params 0, eflags: 0x0
// Checksum 0x75bdfc28, Offset: 0x1f68
// Size: 0x1a
function function_9b52c0fa() {
    music::setmusicstate("skirmish");
}

// Namespace namespace_9fd035
// Params 0, eflags: 0x0
// Checksum 0xaf6a1727, Offset: 0x1f90
// Size: 0x1a
function function_e18f629a() {
    wait 3;
    music::setmusicstate("tension_loop_2");
}

// Namespace namespace_9fd035
// Params 0, eflags: 0x0
// Checksum 0x988b02b8, Offset: 0x1fb8
// Size: 0x1a
function function_862430bd() {
    music::setmusicstate("igc_3_open_door");
}

// Namespace namespace_9fd035
// Params 0, eflags: 0x0
// Checksum 0xf41461ce, Offset: 0x1fe0
// Size: 0x1a
function function_791dd03() {
    music::setmusicstate("tension_loop_3");
}

// Namespace namespace_9fd035
// Params 0, eflags: 0x0
// Checksum 0xdc606083, Offset: 0x2008
// Size: 0x1a
function function_fa2e45b8() {
    music::setmusicstate("battle_1");
}

// Namespace namespace_9fd035
// Params 0, eflags: 0x0
// Checksum 0xe46072ff, Offset: 0x2030
// Size: 0x1a
function function_c270e327() {
    wait 3;
    music::setmusicstate("igc_4_goh");
}

// Namespace namespace_9fd035
// Params 0, eflags: 0x0
// Checksum 0x84301a9b, Offset: 0x2058
// Size: 0x1a
function function_8d18c8bc() {
    music::setmusicstate("quad_battle");
}

// Namespace namespace_9fd035
// Params 0, eflags: 0x0
// Checksum 0x662d9896, Offset: 0x2080
// Size: 0x1a
function function_58779b4() {
    music::setmusicstate("sniper_battle");
}

// Namespace namespace_9fd035
// Params 0, eflags: 0x0
// Checksum 0xe09693c2, Offset: 0x20a8
// Size: 0x1a
function function_46333a8a() {
    music::setmusicstate("battle_3");
}

// Namespace namespace_9fd035
// Params 0, eflags: 0x0
// Checksum 0x8c633852, Offset: 0x20d0
// Size: 0x1a
function function_83763d08() {
    music::setmusicstate("igc_5_statue");
}

// Namespace namespace_9fd035
// Params 0, eflags: 0x0
// Checksum 0xa35e5855, Offset: 0x20f8
// Size: 0x1a
function function_b83aa9c5() {
    music::setmusicstate("battle_4");
}

// Namespace namespace_9fd035
// Params 0, eflags: 0x0
// Checksum 0x64953f, Offset: 0x2120
// Size: 0x1a
function function_c8bfdb76() {
    wait 1;
    music::setmusicstate("igc_6_outro");
}

// Namespace namespace_9fd035
// Params 0, eflags: 0x0
// Checksum 0x217f81e7, Offset: 0x2148
// Size: 0x1a
function function_14592f48() {
    music::setmusicstate("dyn_battle");
}

// Namespace namespace_9fd035
// Params 0, eflags: 0x0
// Checksum 0xa4b823be, Offset: 0x2170
// Size: 0x1a
function function_e6a33cb1() {
    music::setmusicstate("rachael_underscore");
}

// Namespace namespace_9fd035
// Params 1, eflags: 0x0
// Checksum 0x4a3316d3, Offset: 0x2198
// Size: 0x151
function function_dad71f51(state) {
    level endon(#"hash_d3bbbf2c");
    if (isdefined(state)) {
        music::setmusicstate(state);
    }
    level thread function_484281f1();
    while (true) {
        level flag::wait_till_any(array("stealth_combat", "stealth_alert", "stealth_discovered"));
        wait 0.05;
        if (level flag::get("stealth_discovered")) {
            level flag::wait_till_clear("stealth_discovered");
        } else if (level flag::get("stealth_combat")) {
            wait 0.5;
            if (level flag::get("stealth_combat")) {
                wait 5;
            }
        } else if (level flag::get("stealth_alert")) {
            wait 0.5;
            if (level flag::get("stealth_alert")) {
                music::setmusicstate("dyn_aware");
                wait 1;
            }
        }
        wait 0.05;
    }
}

// Namespace namespace_9fd035
// Params 1, eflags: 0x0
// Checksum 0x8bff3a17, Offset: 0x22f8
// Size: 0x2a
function function_f64b08fb(state) {
    level notify(#"hash_d3bbbf2c");
    if (isdefined(state)) {
        music::setmusicstate(state);
    }
}

// Namespace namespace_9fd035
// Params 0, eflags: 0x0
// Checksum 0xe5dbbe20, Offset: 0x2330
// Size: 0xb5
function function_484281f1() {
    level endon(#"hash_d3bbbf2c");
    while (true) {
        level flag::wait_till_clear_all(array("stealth_combat", "stealth_alert", "stealth_discovered"));
        wait 2;
        if (level flag::get("stealth_combat") || level flag::get("stealth_alert") || level flag::get("stealth_discovered")) {
            continue;
        }
        music::setmusicstate("tension_loop_2");
    }
}

// Namespace namespace_9fd035
// Params 0, eflags: 0x0
// Checksum 0x9b2db462, Offset: 0x23f0
// Size: 0x1a
function function_6c2fa1d0() {
    wait 1;
    playsoundatposition("mus_assassination_stinger", (0, 0, 0));
}

