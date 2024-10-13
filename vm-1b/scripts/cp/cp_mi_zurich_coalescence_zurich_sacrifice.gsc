#using scripts/cp/cp_mi_zurich_coalescence_sound;
#using scripts/cp/cp_mi_zurich_coalescence_util;
#using scripts/cp/cp_mi_zurich_coalescence_zurich_server_room;
#using scripts/cp/cp_mi_zurich_coalescence_zurich_hq;
#using scripts/cp/cp_mi_zurich_coalescence_zurich_plaza_battle;
#using scripts/cp/_dialog;
#using scripts/cp/cybercom/_cybercom_util;
#using scripts/cp/_util;
#using scripts/cp/_spawn_manager;
#using scripts/cp/_skipto;
#using scripts/cp/_objectives;
#using scripts/cp/_load;
#using scripts/shared/exploder_shared;
#using scripts/shared/visionset_mgr_shared;
#using scripts/shared/gameobjects_shared;
#using scripts/cp/gametypes/_battlechatter;
#using scripts/shared/lui_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/util_shared;
#using scripts/shared/trigger_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/colors_shared;
#using scripts/shared/array_shared;
#using scripts/shared/ai_shared;
#using scripts/codescripts/struct;

#namespace namespace_68404a06;

// Namespace namespace_68404a06
// Params 2, eflags: 0x0
// Checksum 0x3658858a, Offset: 0xa68
// Size: 0x2a2
function function_9c1fc2fd(str_objective, var_74cd64bc) {
    if (var_74cd64bc) {
        load::function_73adcefc();
        level flag::init("hq_decon_deactivated");
        zurich_util::function_da579a5d(str_objective, 0);
        level.var_3d556bcd.goalradius = 16;
        level thread namespace_b73b0f52::function_2950b33d();
        level thread zurich_util::function_2361541e("hq");
        level scene::add_scene_func("cin_gen_ambient_raven_idle_eating_raven", &zurich_util::function_e547724d, "init");
        level scene::add_scene_func("cin_gen_ambient_raven_idle", &zurich_util::function_e547724d, "init");
        level thread namespace_b73b0f52::function_6e7da34e();
    }
    util::function_d8eaed3d(2);
    if (var_74cd64bc) {
        load::function_a2995f22();
    }
    level thread function_50aaa108();
    level thread function_51e389ee(var_74cd64bc);
    level.var_3d556bcd thread function_3769aa25(var_74cd64bc);
    level thread function_87a50dde();
    level thread function_f6f2b542();
    level thread function_a87436d9();
    level thread function_a660f4ee();
    trigger::wait_till("sacrifice_enter_control_room_trig", undefined, undefined, 0);
    if (isdefined(level.var_3a0a2835)) {
        level thread [[ level.var_3a0a2835 ]]();
    }
    level flag::set("flag_move_kane_into_sacrifice_start");
    level thread namespace_67110270::function_876e5649();
    flag::wait_till("sacrifice_kane_activation_ready");
    level thread function_86f33bf();
    level waittill(#"hash_f0ca35d0");
    a_ai_enemies = getaiteamarray();
    array::thread_all(a_ai_enemies, &zurich_util::function_48463818);
    level waittill(#"hash_2bcc2145");
    level thread function_bef4fc91();
    level namespace_e0fbc9fc::function_f62d8d36();
    level thread namespace_e0fbc9fc::function_ef7b97bd();
    skipto::function_be8adfb8(str_objective);
}

// Namespace namespace_68404a06
// Params 4, eflags: 0x0
// Checksum 0x22c29899, Offset: 0xd18
// Size: 0x53
function function_1a4dfaaa(str_objective, var_74cd64bc, var_e4cd2b8b, player) {
    zurich_util::function_4d032f25(0);
    if (var_74cd64bc) {
        objectives::complete("cp_level_zurich_use_terminal_obj");
    }
    level notify(#"hash_1851c43a");
}

// Namespace namespace_68404a06
// Params 0, eflags: 0x0
// Checksum 0x525a9e9e, Offset: 0xd78
// Size: 0x52
function function_50aaa108() {
    level waittill(#"hash_5ed65de9");
    level dialog::function_13b3b16a("plyr_what_were_they_messi_0", 1);
    level waittill(#"hash_2bcc2145");
    level dialog::function_13b3b16a("plyr_i_swear_i_m_going_0", 2);
}

// Namespace namespace_68404a06
// Params 0, eflags: 0x0
// Checksum 0xf857da61, Offset: 0xdd8
// Size: 0x8a
function function_22dc4b59() {
    self endon(#"death");
    self.health = -106;
    self util::magic_bullet_shield();
    trigger::wait_till("trig_look_sacrifice_lab_int");
    self thread function_52cdaa83();
    wait 3;
    self util::stop_magic_bullet_shield();
    level flag::wait_till("flag_kane_sacrifice_door_closed");
    self delete();
}

// Namespace namespace_68404a06
// Params 0, eflags: 0x0
// Checksum 0xbd374edc, Offset: 0xe70
// Size: 0x12
function function_52cdaa83() {
    self waittill(#"death");
    level.var_56c8a612++;
}

// Namespace namespace_68404a06
// Params 0, eflags: 0x0
// Checksum 0x1c736220, Offset: 0xe90
// Size: 0x6a
function function_bebe324d() {
    self endon(#"death");
    level.var_286ef070++;
    self thread function_474a932e();
    self setgoalnode(getnode("hallway_robot_goal", "targetname"), 1);
    self waittill(#"goal");
    self delete();
}

// Namespace namespace_68404a06
// Params 0, eflags: 0x0
// Checksum 0x6b544ae7, Offset: 0xf08
// Size: 0x12
function function_474a932e() {
    self waittill(#"death");
    level.var_286ef070--;
}

// Namespace namespace_68404a06
// Params 0, eflags: 0x0
// Checksum 0xbecf1e8b, Offset: 0xf28
// Size: 0x82
function function_a50fba17() {
    self endon(#"death");
    self thread function_d8b70cd();
    self thread function_f5b0e3d0();
    self.health = -106;
    self util::magic_bullet_shield();
    trigger::wait_till("trig_look_sacrifice_lab_int");
    wait 3;
    self util::stop_magic_bullet_shield();
    level waittill(#"hash_ae3bd4e0");
    self thread function_71b157ad();
}

// Namespace namespace_68404a06
// Params 0, eflags: 0x0
// Checksum 0xc2bd1a4c, Offset: 0xfb8
// Size: 0x7a
function function_a19013c7() {
    self endon(#"death");
    self thread function_5412a5bb();
    self thread function_f5b0e3d0();
    self util::magic_bullet_shield();
    trigger::wait_till("trig_look_sacrifice_lab_int");
    wait 3;
    self util::stop_magic_bullet_shield();
    level waittill(#"hash_350e4134");
    self thread function_71b157ad();
}

// Namespace namespace_68404a06
// Params 0, eflags: 0x0
// Checksum 0xf4114355, Offset: 0x1040
// Size: 0x3b
function function_5412a5bb() {
    self waittill(#"death");
    if (!isdefined(level.var_a8bbb2e4)) {
        level.var_a8bbb2e4 = 0;
    }
    level.var_a8bbb2e4++;
    if (level.var_a8bbb2e4 == 4) {
        level notify(#"hash_ae3bd4e0");
    }
}

// Namespace namespace_68404a06
// Params 0, eflags: 0x0
// Checksum 0xbbb25065, Offset: 0x1088
// Size: 0x3b
function function_d8b70cd() {
    self waittill(#"death");
    if (!isdefined(level.var_7f489288)) {
        level.var_7f489288 = 0;
    }
    level.var_7f489288++;
    if (level.var_7f489288 == 4) {
        level notify(#"hash_350e4134");
    }
}

// Namespace namespace_68404a06
// Params 0, eflags: 0x0
// Checksum 0xbdb4b98e, Offset: 0x10d0
// Size: 0x42
function function_f5b0e3d0() {
    self endon(#"death");
    level flag::wait_till("flag_kane_sacrifice_door_closed");
    self util::stop_magic_bullet_shield();
    self delete();
}

// Namespace namespace_68404a06
// Params 1, eflags: 0x0
// Checksum 0x4a27494b, Offset: 0x1120
// Size: 0x11a
function function_51e389ee(var_74cd64bc) {
    if (var_74cd64bc) {
        objectives::set("cp_level_zurich_apprehend_obj");
        level flag::wait_till_all(array("flag_hq_set_sacrifice_obj", "sacrifice_kane_activation_ready"));
        objectives::hide("cp_level_zurich_apprehend_obj");
        objectives::set("cp_level_zurich_use_terminal_obj");
    }
    level waittill(#"hash_e8fb3b96");
    objectives::hide("cp_level_zurich_use_terminal_obj");
    objectives::set("cp_level_zurich_use_terminal_awaiting_obj");
    level flag::wait_till("hq_decon_deactivated");
    objectives::complete("cp_level_zurich_use_terminal_awaiting_obj");
    objectives::hide("cp_level_zurich_apprehend_obj");
    objectives::set("cp_level_zurich_apprehend_hack_obj");
}

// Namespace namespace_68404a06
// Params 1, eflags: 0x0
// Checksum 0x14089977, Offset: 0x1248
// Size: 0xfa
function function_3769aa25(var_74cd64bc) {
    if (var_74cd64bc) {
        self battlechatter::function_d9f49fba(0);
        self colors::set_force_color("r");
        trigger::use("trig_color_kane_hq_in_decon");
        level flag::wait_till("flag_decon_door_open");
        trigger::use("trig_color_kane_lab_interior");
    } else {
        level thread zurich_util::function_c049667c(0);
    }
    trigger::wait_till("trig_move_kane_into_sacrifice_igc");
    self ai::set_ignoreall(1);
    level scene::play("cin_zur_06_02_decontamination_vign_schematic", level.var_3d556bcd);
    level flag::set("sacrifice_kane_activation_ready");
}

// Namespace namespace_68404a06
// Params 1, eflags: 0x0
// Checksum 0xe86f616b, Offset: 0x1350
// Size: 0x1b2
function function_a174da35(e_player) {
    scene::add_scene_func("cin_zur_06_sacrifice_3rd_sh010", &function_71882809, "play");
    scene::add_scene_func("cin_zur_06_sacrifice_3rd_sh010", &function_a08db270, "skip_started");
    scene::add_scene_func("cin_zur_06_sacrifice_3rd_sh150", &function_ed9e0a0b, "done");
    scene::add_scene_func("cin_zur_06_sacrifice_3rd_sh110", &function_dc0b1e53, "play");
    scene::add_scene_func("cin_zur_06_sacrifice_3rd_sh110", &function_f57ae209, "play");
    scene::add_scene_func("cin_zur_06_sacrifice_3rd_sh150", &function_aa30b938, "done");
    level scene::init("cin_zur_06_sacrifice_3rd_sh010", e_player);
    wait 0.5;
    level flag::set("flag_start_kane_sacrifice_igc");
    level thread function_6bd697de(e_player);
    level thread function_c22d22c5();
    level scene::play("cin_zur_06_sacrifice_3rd_sh010", e_player);
    exploder::exploder("cin_zur_06_sacrifice_3rd_lgt_off");
}

// Namespace namespace_68404a06
// Params 0, eflags: 0x0
// Checksum 0xdd2895a, Offset: 0x1510
// Size: 0x133
function function_c22d22c5() {
    level waittill(#"hash_d25d8e9");
    foreach (player in level.players) {
        player clientfield::increment_to_player("postfx_hallucinations", 1);
        visionset_mgr::activate("visionset", "cp_zurich_hallucination", player);
        player playsoundtoplayer("vox_dying_infected_after", player);
    }
    level waittill(#"hash_e2567632");
    foreach (player in level.players) {
        player clientfield::increment_to_player("postfx_hallucinations", 1);
        visionset_mgr::deactivate("visionset", "cp_zurich_hallucination", player);
    }
}

// Namespace namespace_68404a06
// Params 1, eflags: 0x0
// Checksum 0x8553b872, Offset: 0x1650
// Size: 0x6a
function function_6bd697de(e_player) {
    level waittill(#"hash_fab94d49");
    e_player cybercom::function_f8669cbf(1);
    level thread lui::play_movie("cp_zurich_fs_novasix", "fullscreen_additive");
    level waittill(#"hash_7fbd13b6");
    e_player cybercom::function_f8669cbf(1);
}

// Namespace namespace_68404a06
// Params 1, eflags: 0x0
// Checksum 0x31538762, Offset: 0x16c8
// Size: 0x75
function function_a08db270(a_ents) {
    foreach (player in level.activeplayers) {
        player notify(#"menuresponse", "FullscreenMovie", "finished_movie_playback");
    }
}

// Namespace namespace_68404a06
// Params 1, eflags: 0x0
// Checksum 0xc7524b8f, Offset: 0x1748
// Size: 0x42
function function_71882809(a_ents) {
    level clientfield::set("set_exposure_bank", 1);
    a_ents["kane"] util::unmake_hero("kane");
}

// Namespace namespace_68404a06
// Params 1, eflags: 0x0
// Checksum 0x840159f0, Offset: 0x1798
// Size: 0x6a
function function_ed9e0a0b(a_ents) {
    util::function_93831e79("sacrifice_teleport_spot");
    level flag::set("hq_decon_deactivated");
    level clientfield::set("set_exposure_bank", 0);
    self thread zurich_util::function_9f90bc0f(a_ents, "hq_ambient_cleanup");
}

// Namespace namespace_68404a06
// Params 1, eflags: 0x0
// Checksum 0x4452b7c8, Offset: 0x1810
// Size: 0x3a
function function_dc0b1e53(a_ents) {
    level waittill(#"hash_e8fb3b96");
    a_ents["kane"] clientfield::set("skin_transition_melt", 1);
}

// Namespace namespace_68404a06
// Params 1, eflags: 0x0
// Checksum 0x66fbfc0a, Offset: 0x1858
// Size: 0x9a
function function_f57ae209(a_ents) {
    level waittill(#"hash_2fdcd39c");
    a_doors = getentarray("sacrifice_blast_door", "targetname");
    array::run_all(a_doors, &movez, -118, 3);
    trigger::wait_till("hq_exit_zone_trig");
    array::run_all(a_doors, &delete);
}

// Namespace namespace_68404a06
// Params 1, eflags: 0x0
// Checksum 0x3f50326c, Offset: 0x1900
// Size: 0x22
function function_aa30b938(a_ents) {
    level notify(#"hash_2bcc2145");
    util::clear_streamer_hint();
}

// Namespace namespace_68404a06
// Params 0, eflags: 0x0
// Checksum 0xe22a822d, Offset: 0x1930
// Size: 0xb9
function function_f6f2b542() {
    level endon(#"flag_kane_sacrifice_door_closed");
    wait 2;
    if (!isdefined(level.var_56c8a612)) {
        level.var_56c8a612 = 0;
    }
    level thread zurich_util::function_33ec653f("hq_hallway_ally_fake_spawn_manager", undefined, 0.25, &function_22dc4b59);
    if (!isdefined(level.var_286ef070)) {
        level.var_286ef070 = 0;
    }
    while (level.var_56c8a612 < 4) {
        if (level.var_286ef070 > 3) {
            wait 1.5;
            continue;
        }
        level thread zurich_util::function_33ec653f("hq_hallway_enemy_fake_spawn_manager", undefined, 2, &function_bebe324d);
        wait 14;
    }
}

// Namespace namespace_68404a06
// Params 0, eflags: 0x0
// Checksum 0x5754385e, Offset: 0x19f8
// Size: 0x82
function function_87a50dde() {
    level thread function_1d5e51b();
    level.var_7f489288 = 0;
    level.var_a8bbb2e4 = 0;
    level thread zurich_util::function_33ec653f("hq_labs_enemy_fake_spawn_manager", undefined, 0.15, &function_a50fba17);
    level thread zurich_util::function_33ec653f("hq_labs_ally_fake_spawn_manager", undefined, 0.15, &function_a19013c7);
}

// Namespace namespace_68404a06
// Params 0, eflags: 0x0
// Checksum 0xf582d5b4, Offset: 0x1a88
// Size: 0x82
function function_71b157ad() {
    self endon(#"death");
    wait randomfloatrange(1.5, 3.5);
    self ai::set_ignoreall(1);
    self clearforcedgoal();
    self ai::set_goal("lab_fight_end_node", "targetname", 1);
    self waittill(#"goal");
    self delete();
}

// Namespace namespace_68404a06
// Params 0, eflags: 0x0
// Checksum 0x870b31ac, Offset: 0x1b18
// Size: 0x4a
function function_1d5e51b() {
    level flag::wait_till("flag_start_kane_sacrifice_igc");
    array::run_all(getaiarray(), &delete);
}

// Namespace namespace_68404a06
// Params 0, eflags: 0x0
// Checksum 0x6f132e5e, Offset: 0x1b70
// Size: 0x7a
function function_86f33bf() {
    t_use = getent("sacrifice_activate_chamber_trig", "targetname");
    var_376507c0 = %cp_level_zurich_hack_terminal;
    str_hint = %CP_MI_ZURICH_COALESCENCE_HACK;
    util::function_14518e76(t_use, var_376507c0, str_hint, &function_34d834a6);
    t_use triggerenable(1);
}

// Namespace namespace_68404a06
// Params 1, eflags: 0x0
// Checksum 0xf17b2c42, Offset: 0x1bf8
// Size: 0x72
function function_34d834a6(e_player) {
    self gameobjects::disable_object();
    e_player cybercom::function_f8669cbf(1);
    util::wait_network_frame();
    level notify(#"hash_71da81fb");
    level notify(#"hash_f0ca35d0");
    level thread namespace_67110270::function_455aaf94();
    level.var_3d556bcd thread function_a174da35(e_player);
}

// Namespace namespace_68404a06
// Params 0, eflags: 0x0
// Checksum 0x36afed9c, Offset: 0x1c78
// Size: 0x3a
function function_3f3aadf9() {
    mdl_door = getent("sacrifice_server_door", "targetname");
    mdl_door delete();
}

// Namespace namespace_68404a06
// Params 0, eflags: 0x0
// Checksum 0x7f7bad2b, Offset: 0x1cc0
// Size: 0xc0
function function_d3eae9b7() {
    mdl_door = getent("sacrifice_room_entrance_door", "targetname");
    e_clip = getent("sacrifice_room_entrance_door_clip", "targetname");
    mdl_door.v_start = mdl_door.origin;
    mdl_door.v_end = mdl_door.origin + (0, 0, 128);
    n_open_time = 3;
    e_clip notsolid();
    mdl_door moveto(mdl_door.v_end, n_open_time);
    wait n_open_time / 2;
}

// Namespace namespace_68404a06
// Params 0, eflags: 0x0
// Checksum 0x5d71192e, Offset: 0x1d88
// Size: 0xd2
function function_a87436d9() {
    mdl_door = getent("sacrifice_room_entrance_door", "targetname");
    e_clip = getent("sacrifice_room_entrance_door_clip", "targetname");
    trigger::wait_till("trig_enter_kane_sacrifice");
    e_clip solid();
    wait 0.5;
    mdl_door moveto(mdl_door.v_start, 0.5);
    level clientfield::set("hq_amb", 0);
    level flag::set("flag_kane_sacrifice_door_closed");
}

// Namespace namespace_68404a06
// Params 0, eflags: 0x0
// Checksum 0x83f08324, Offset: 0x1e68
// Size: 0x72
function function_2d235e66() {
    mdl_door = getent("sacrifice_room_entrance_door", "targetname");
    e_clip = getent("sacrifice_room_entrance_door_clip", "targetname");
    mdl_door delete();
    e_clip delete();
}

// Namespace namespace_68404a06
// Params 0, eflags: 0x0
// Checksum 0xedf0b99a, Offset: 0x1ee8
// Size: 0xa8
function function_bef4fc91() {
    mdl_door = getent("sacrifice_room_exit_door", "targetname");
    mdl_door.v_start = mdl_door.origin;
    mdl_door.v_end = mdl_door.origin + (0, 0, 128);
    n_open_time = 3;
    mdl_door moveto(mdl_door.v_end, n_open_time);
    mdl_door playsound("evt_zur_sac_sh150_door");
    wait n_open_time / 2;
}

// Namespace namespace_68404a06
// Params 0, eflags: 0x0
// Checksum 0x8dac9260, Offset: 0x1f98
// Size: 0x4a
function function_105fe4b3() {
    mdl_door = getent("sacrifice_room_exit_door", "targetname");
    mdl_door moveto(mdl_door.v_start, 2.25);
}

// Namespace namespace_68404a06
// Params 0, eflags: 0x0
// Checksum 0x7594cf5d, Offset: 0x1ff0
// Size: 0x3a
function function_1dc45e88() {
    mdl_door = getent("sacrifice_room_exit_door", "targetname");
    mdl_door delete();
}

// Namespace namespace_68404a06
// Params 0, eflags: 0x0
// Checksum 0xeadd8b37, Offset: 0x2038
// Size: 0xa2
function function_a660f4ee() {
    trigger::wait_till("trig_enter_kane_sacrifice");
    level thread zurich_util::function_11b424e5(1);
    array::thread_all(level.players, &zurich_util::function_7be427b1, 5);
    level waittill(#"hash_71da81fb");
    array::notify_all(level.players, "stop_radiation_monitor");
    array::thread_all(level.players, &zurich_util::function_61bb5738);
}

