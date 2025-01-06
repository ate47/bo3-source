#using scripts/codescripts/struct;
#using scripts/cp/_dialog;
#using scripts/cp/_load;
#using scripts/cp/_objectives;
#using scripts/cp/_skipto;
#using scripts/cp/_spawn_manager;
#using scripts/cp/_util;
#using scripts/cp/cp_mi_zurich_coalescence_sound;
#using scripts/cp/cp_mi_zurich_coalescence_util;
#using scripts/cp/cp_mi_zurich_coalescence_zurich_hq;
#using scripts/cp/cp_mi_zurich_coalescence_zurich_plaza_battle;
#using scripts/cp/cp_mi_zurich_coalescence_zurich_server_room;
#using scripts/cp/cybercom/_cybercom_util;
#using scripts/cp/gametypes/_battlechatter;
#using scripts/shared/ai_shared;
#using scripts/shared/array_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/colors_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/gameobjects_shared;
#using scripts/shared/lui_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/trigger_shared;
#using scripts/shared/util_shared;
#using scripts/shared/visionset_mgr_shared;

#namespace namespace_68404a06;

// Namespace namespace_68404a06
// Params 2, eflags: 0x0
// Checksum 0x75a0f212, Offset: 0xac8
// Size: 0x35c
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
// Checksum 0xf0e56c, Offset: 0xe30
// Size: 0x6a
function function_1a4dfaaa(str_objective, var_74cd64bc, var_e4cd2b8b, player) {
    zurich_util::function_4d032f25(0);
    if (var_74cd64bc) {
        objectives::complete("cp_level_zurich_use_terminal_obj");
    }
    level notify(#"hash_1851c43a");
}

// Namespace namespace_68404a06
// Params 0, eflags: 0x0
// Checksum 0x7133b3be, Offset: 0xea8
// Size: 0x64
function function_50aaa108() {
    level waittill(#"hash_5ed65de9");
    level dialog::function_13b3b16a("plyr_what_were_they_messi_0", 1);
    level waittill(#"hash_2bcc2145");
    level dialog::function_13b3b16a("plyr_i_swear_i_m_going_0", 2);
}

// Namespace namespace_68404a06
// Params 0, eflags: 0x0
// Checksum 0x24263593, Offset: 0xf18
// Size: 0xb4
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
// Checksum 0x73cbf83a, Offset: 0xfd8
// Size: 0x18
function function_52cdaa83() {
    self waittill(#"death");
    level.var_56c8a612++;
}

// Namespace namespace_68404a06
// Params 0, eflags: 0x0
// Checksum 0xf8165805, Offset: 0xff8
// Size: 0x84
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
// Checksum 0x80657f16, Offset: 0x1088
// Size: 0x18
function function_474a932e() {
    self waittill(#"death");
    level.var_286ef070--;
}

// Namespace namespace_68404a06
// Params 0, eflags: 0x0
// Checksum 0x2b4c0757, Offset: 0x10a8
// Size: 0xac
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
// Checksum 0xef88f14e, Offset: 0x1160
// Size: 0xa4
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
// Checksum 0xac842742, Offset: 0x1210
// Size: 0x4e
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
// Checksum 0xb7334064, Offset: 0x1268
// Size: 0x4e
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
// Checksum 0xb1a65f99, Offset: 0x12c0
// Size: 0x5c
function function_f5b0e3d0() {
    self endon(#"death");
    level flag::wait_till("flag_kane_sacrifice_door_closed");
    self util::stop_magic_bullet_shield();
    self delete();
}

// Namespace namespace_68404a06
// Params 1, eflags: 0x0
// Checksum 0x49b53c96, Offset: 0x1328
// Size: 0x134
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
// Checksum 0x24f40bdf, Offset: 0x1468
// Size: 0x12c
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
// Checksum 0x49ee3e01, Offset: 0x15a0
// Size: 0x1dc
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
// Checksum 0x208abf17, Offset: 0x1788
// Size: 0x1aa
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
// Checksum 0xcc7c1311, Offset: 0x1940
// Size: 0x84
function function_6bd697de(e_player) {
    level waittill(#"hash_fab94d49");
    e_player cybercom::function_f8669cbf(1);
    level thread lui::play_movie("cp_zurich_fs_novasix", "fullscreen_additive");
    level waittill(#"hash_7fbd13b6");
    e_player cybercom::function_f8669cbf(1);
}

// Namespace namespace_68404a06
// Params 1, eflags: 0x0
// Checksum 0xc115a1a6, Offset: 0x19d0
// Size: 0x9a
function function_a08db270(a_ents) {
    foreach (player in level.activeplayers) {
        player notify(#"menuresponse", "FullscreenMovie", "finished_movie_playback");
    }
}

// Namespace namespace_68404a06
// Params 1, eflags: 0x0
// Checksum 0x7b5089ce, Offset: 0x1a78
// Size: 0x54
function function_71882809(a_ents) {
    level clientfield::set("set_exposure_bank", 1);
    a_ents["kane"] util::unmake_hero("kane");
}

// Namespace namespace_68404a06
// Params 1, eflags: 0x0
// Checksum 0x1b61fb6e, Offset: 0x1ad8
// Size: 0x84
function function_ed9e0a0b(a_ents) {
    util::function_93831e79("sacrifice_teleport_spot");
    level flag::set("hq_decon_deactivated");
    level clientfield::set("set_exposure_bank", 0);
    self thread zurich_util::function_9f90bc0f(a_ents, "hq_ambient_cleanup");
}

// Namespace namespace_68404a06
// Params 1, eflags: 0x0
// Checksum 0x2761be46, Offset: 0x1b68
// Size: 0x44
function function_dc0b1e53(a_ents) {
    level waittill(#"hash_e8fb3b96");
    a_ents["kane"] clientfield::set("skin_transition_melt", 1);
}

// Namespace namespace_68404a06
// Params 1, eflags: 0x0
// Checksum 0x68f74757, Offset: 0x1bb8
// Size: 0xac
function function_f57ae209(a_ents) {
    level waittill(#"hash_2fdcd39c");
    a_doors = getentarray("sacrifice_blast_door", "targetname");
    array::run_all(a_doors, &movez, -118, 3);
    trigger::wait_till("hq_exit_zone_trig");
    array::run_all(a_doors, &delete);
}

// Namespace namespace_68404a06
// Params 1, eflags: 0x0
// Checksum 0x60074a01, Offset: 0x1c70
// Size: 0x2c
function function_aa30b938(a_ents) {
    level notify(#"hash_2bcc2145");
    util::clear_streamer_hint();
}

// Namespace namespace_68404a06
// Params 0, eflags: 0x0
// Checksum 0xbbf72200, Offset: 0x1ca8
// Size: 0xde
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
// Checksum 0xb9609431, Offset: 0x1d90
// Size: 0x94
function function_87a50dde() {
    level thread function_1d5e51b();
    level.var_7f489288 = 0;
    level.var_a8bbb2e4 = 0;
    level thread zurich_util::function_33ec653f("hq_labs_enemy_fake_spawn_manager", undefined, 0.15, &function_a50fba17);
    level thread zurich_util::function_33ec653f("hq_labs_ally_fake_spawn_manager", undefined, 0.15, &function_a19013c7);
}

// Namespace namespace_68404a06
// Params 0, eflags: 0x0
// Checksum 0x63e7c011, Offset: 0x1e30
// Size: 0xa4
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
// Checksum 0x44927635, Offset: 0x1ee0
// Size: 0x54
function function_1d5e51b() {
    level flag::wait_till("flag_start_kane_sacrifice_igc");
    array::run_all(getaiarray(), &delete);
}

// Namespace namespace_68404a06
// Params 0, eflags: 0x0
// Checksum 0xae9b9068, Offset: 0x1f40
// Size: 0x9c
function function_86f33bf() {
    t_use = getent("sacrifice_activate_chamber_trig", "targetname");
    var_376507c0 = %cp_level_zurich_hack_terminal;
    str_hint = %CP_MI_ZURICH_COALESCENCE_HACK;
    util::function_14518e76(t_use, var_376507c0, str_hint, &function_34d834a6);
    t_use triggerenable(1);
}

// Namespace namespace_68404a06
// Params 1, eflags: 0x0
// Checksum 0xe63be20, Offset: 0x1fe8
// Size: 0x9c
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
// Checksum 0xda08c28d, Offset: 0x2090
// Size: 0x44
function function_3f3aadf9() {
    mdl_door = getent("sacrifice_server_door", "targetname");
    mdl_door delete();
}

// Namespace namespace_68404a06
// Params 0, eflags: 0x0
// Checksum 0x7adcfa1d, Offset: 0x20e0
// Size: 0x108
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
// Checksum 0xc67c6721, Offset: 0x21f0
// Size: 0x124
function function_a87436d9() {
    mdl_door = getent("sacrifice_room_entrance_door", "targetname");
    e_clip = getent("sacrifice_room_entrance_door_clip", "targetname");
    trigger::wait_till("trig_enter_kane_sacrifice");
    e_clip solid();
    wait 0.5;
    mdl_door playsound("evt_sacrifice_door_close");
    mdl_door moveto(mdl_door.v_start, 0.5);
    level clientfield::set("hq_amb", 0);
    level flag::set("flag_kane_sacrifice_door_closed");
}

// Namespace namespace_68404a06
// Params 0, eflags: 0x0
// Checksum 0x8932ca8c, Offset: 0x2320
// Size: 0x8c
function function_2d235e66() {
    mdl_door = getent("sacrifice_room_entrance_door", "targetname");
    e_clip = getent("sacrifice_room_entrance_door_clip", "targetname");
    mdl_door delete();
    e_clip delete();
}

// Namespace namespace_68404a06
// Params 0, eflags: 0x0
// Checksum 0xc55e849b, Offset: 0x23b8
// Size: 0xe0
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
// Checksum 0x477a5d77, Offset: 0x24a0
// Size: 0x5c
function function_105fe4b3() {
    mdl_door = getent("sacrifice_room_exit_door", "targetname");
    mdl_door moveto(mdl_door.v_start, 2.25);
}

// Namespace namespace_68404a06
// Params 0, eflags: 0x0
// Checksum 0x290d4f07, Offset: 0x2508
// Size: 0x44
function function_1dc45e88() {
    mdl_door = getent("sacrifice_room_exit_door", "targetname");
    mdl_door delete();
}

// Namespace namespace_68404a06
// Params 0, eflags: 0x0
// Checksum 0x3a531de0, Offset: 0x2558
// Size: 0xdc
function function_a660f4ee() {
    level thread function_8c13120f();
    trigger::wait_for_either("trig_enter_kane_sacrifice", "trig_enter_kane_sacrifice_tu1");
    level thread zurich_util::function_11b424e5(1);
    array::thread_all(level.players, &zurich_util::function_7be427b1, 5);
    level waittill(#"hash_71da81fb");
    array::notify_all(level.players, "stop_radiation_monitor");
    array::thread_all(level.players, &zurich_util::function_61bb5738);
}

// Namespace namespace_68404a06
// Params 0, eflags: 0x0
// Checksum 0x1bdc8a9b, Offset: 0x2640
// Size: 0xe4
function function_8c13120f() {
    var_6c495a34 = spawn("trigger_box", (-10213, 43921, -100), 0, 1200, 600, 300);
    var_6c495a34.angles = (0, 29.5, 0);
    var_6c495a34.targetname = "trig_enter_kane_sacrifice_tu1";
    var_6c495a34.script_flag_set = "flag_hq_set_sacrifice_obj";
    var_6c495a34.script_flag_true = "flag_kane_in_sacrifice_room";
    level thread trigger::function_f1980fe1(var_6c495a34);
    level thread trigger::flag_set_trigger(var_6c495a34, var_6c495a34.script_flag_set);
}

