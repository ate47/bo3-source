#using scripts/cp/cp_mi_sing_sgen_exterior;
#using scripts/cp/cp_mi_sing_sgen_sound;
#using scripts/cp/cp_mi_sing_sgen_util;
#using scripts/cp/cp_mi_sing_sgen;
#using scripts/cp/_load;
#using scripts/cp/cybercom/_cybercom_util;
#using scripts/cp/_mapping_drone;
#using scripts/cp/_hacking;
#using scripts/cp/_oed;
#using scripts/cp/_util;
#using scripts/cp/_skipto;
#using scripts/cp/_spawn_manager;
#using scripts/cp/_objectives;
#using scripts/cp/_dialog;
#using scripts/shared/ai/archetype_warlord_interface;
#using scripts/shared/ai/warlord;
#using scripts/cp/gametypes/_save;
#using scripts/cp/gametypes/_battlechatter;
#using scripts/shared/lui_shared;
#using scripts/shared/vehicle_shared;
#using scripts/shared/util_shared;
#using scripts/shared/trigger_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/math_shared;
#using scripts/shared/gameobjects_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/colors_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/array_shared;
#using scripts/shared/ai_shared;
#using scripts/codescripts/struct;

#namespace cp_mi_sing_sgen_enter_silo;

// Namespace cp_mi_sing_sgen_enter_silo
// Params 2, eflags: 0x1 linked
// Checksum 0x9a69b4a5, Offset: 0x21a8
// Size: 0x424
function function_aa390943(str_objective, var_74cd64bc) {
    if (var_74cd64bc) {
        videostart("cp_sgen_env_LobbyMovie", 1);
        sgen::function_bff1a867(str_objective);
        level.var_2fd26037 ai::set_behavior_attribute("cqb", 1);
        level.var_2fd26037 ai::set_behavior_attribute("sprint", 0);
        objectives::complete("cp_level_sgen_investigate_sgen");
        level flag::set("hendricks_at_silo_doors");
        level scene::init("p7_fxanim_cp_sgen_overhang_building_glass_bundle");
        level scene::init("cin_sgen_05_01_discoverdata_vign_lookaround_hendricks");
        level scene::init("pb_sgen_data_discovery_hack");
        trig_post_discover_data = getent("trig_post_discover_data", "targetname");
        trig_post_discover_data triggerenable(0);
        exploder::exploder("sgen_flying_IGC");
        load::function_a2995f22();
        foreach (player in level.activeplayers) {
            player clientfield::set_to_player("sndSiloBG", 1);
        }
        cp_mi_sing_sgen_exterior::function_547e0499();
    }
    level thread function_ab1ca63f();
    level flag::wait_till("silo_door_opened");
    if (isdefined(level.var_4f37abd3)) {
        level thread [[ level.var_4f37abd3 ]]();
    }
    level thread function_ab489996();
    level thread function_370bcbcc();
    level thread namespace_d40478f6::function_26fc5a92();
    level thread scene::play("cin_sgen_05_01_discoverdata_vign_lookaround_hendricks");
    level waittill(#"hash_dd334053");
    level thread util::function_d8eaed3d(6);
    level util::delay(2, undefined, &function_2f312deb);
    level flag::wait_till("data_recovered");
    mapping_drone::function_10dad989();
    level scene::add_scene_func("cin_sgen_06_01_followleader_vign_activate_eac_hendricks", &function_8e9806c5);
    level scene::add_scene_func("cin_sgen_06_01_followleader_vign_activate_eac_drone", &function_8cf3dc94);
    level thread scene::play("cin_sgen_06_01_followleader_vign_activate_eac_drone");
    level thread scene::play("cin_sgen_06_01_followleader_vign_activate_eac_hendricks");
    skipto::function_be8adfb8(str_objective);
}

// Namespace cp_mi_sing_sgen_enter_silo
// Params 0, eflags: 0x1 linked
// Checksum 0xb162f5a8, Offset: 0x25d8
// Size: 0x244
function function_370bcbcc() {
    var_f3ad9584 = getent("emf_device", "targetname");
    level waittill(#"hash_dd334053");
    var_d202c753 = spawn("script_origin", var_f3ad9584.origin);
    var_d202c753 playloopsound("evt_emf_signal");
    level flag::wait_till("kane_data_callout");
    t_use = spawn("trigger_radius_use", var_f3ad9584.origin, 0, 32, 32);
    t_use triggerignoreteam();
    t_use setvisibletoall();
    t_use setteamfortrigger("none");
    t_use usetriggerrequirelookat();
    var_d67faff5 = util::function_14518e76(t_use, %cp_prompt_dni_sgen_hack_emf_source, %CP_MI_SING_SGEN_HACK, &function_41ebcee5, array(var_f3ad9584));
    level flag::wait_till("data_discovered");
    var_d202c753 stoploopsound();
    objectives::complete("cp_level_sgen_locate_emf");
    var_d67faff5 gameobjects::disable_object();
    level flag::wait_till("data_recovered");
    var_d67faff5 gameobjects::destroy_object(1, 0);
}

// Namespace cp_mi_sing_sgen_enter_silo
// Params 1, eflags: 0x1 linked
// Checksum 0x5ac2dcfc, Offset: 0x2828
// Size: 0x94
function function_41ebcee5(e_player) {
    level flag::set("data_discovered");
    level scene::add_scene_func("pb_sgen_data_discovery_hack", &function_692aa639);
    level scene::play("pb_sgen_data_discovery_hack", e_player);
    level flag::set("data_recovered");
}

// Namespace cp_mi_sing_sgen_enter_silo
// Params 1, eflags: 0x1 linked
// Checksum 0x4c2c1251, Offset: 0x28c8
// Size: 0x64
function function_8cf3dc94(a_ents) {
    level.var_ea764859 vehicle::lights_off();
    level.var_ea764859.script_objective = "fallen_soldiers";
    level waittill(#"hash_3ac74ca");
    level.var_ea764859 vehicle::lights_on();
}

// Namespace cp_mi_sing_sgen_enter_silo
// Params 1, eflags: 0x1 linked
// Checksum 0xecd8d60e, Offset: 0x2938
// Size: 0x14a
function function_692aa639(a_ents) {
    wait 2.5;
    foreach (var_9544d7c1 in a_ents) {
        if (isplayer(var_9544d7c1)) {
            var_9544d7c1 cybercom::function_f8669cbf(1);
            var_9544d7c1 clientfield::set_to_player("sndCCHacking", 2);
            var_9544d7c1 util::delay(1, "death", &clientfield::increment_to_player, "hack_dni_fx");
            var_9544d7c1 util::delay(2, "death", &clientfield::set_to_player, "sndCCHacking", 0);
        }
    }
}

// Namespace cp_mi_sing_sgen_enter_silo
// Params 0, eflags: 0x1 linked
// Checksum 0x40be74ac, Offset: 0x2a90
// Size: 0x74
function function_ab489996() {
    level thread function_cc8a136f();
    level thread function_782fe79e();
    level flag::wait_till("play_building_glass_debris");
    level thread scene::play("p7_fxanim_cp_sgen_overhang_building_glass_bundle");
}

// Namespace cp_mi_sing_sgen_enter_silo
// Params 0, eflags: 0x1 linked
// Checksum 0xd9e2483d, Offset: 0x2b10
// Size: 0x8c
function function_782fe79e() {
    level endon(#"play_building_glass_debris");
    trig_lookat_glass_debris = getent("trig_lookat_glass_debris", "targetname");
    level.players[0] util::waittill_player_looking_at(trig_lookat_glass_debris.origin, 0.8, 0);
    level flag::set("play_building_glass_debris");
}

// Namespace cp_mi_sing_sgen_enter_silo
// Params 0, eflags: 0x1 linked
// Checksum 0xf2948e11, Offset: 0x2ba8
// Size: 0x34
function function_cc8a136f() {
    level endon(#"play_building_glass_debris");
    wait 10;
    level flag::set("play_building_glass_debris");
}

// Namespace cp_mi_sing_sgen_enter_silo
// Params 0, eflags: 0x1 linked
// Checksum 0x128b7329, Offset: 0x2be8
// Size: 0x12c
function function_2f312deb() {
    level flag::set("kane_data_callout");
    level dialog::remote("kane_i_m_picking_up_an_em_0");
    level flag::wait_till("data_discovered");
    level dialog::function_13b3b16a("plyr_got_it_uploading_0");
    level dialog::remote("kane_the_looters_didn_t_j_0");
    level.var_2fd26037 waittill(#"hash_efcaa5e4");
    level dialog::remote("kane_message_received_and_0");
    level flag::wait_till("post_discover_data");
    level thread namespace_d40478f6::function_fb17452c();
    level.var_2fd26037 dialog::say("hend_stick_to_the_ledge_0");
}

// Namespace cp_mi_sing_sgen_enter_silo
// Params 4, eflags: 0x1 linked
// Checksum 0x55ecc9d, Offset: 0x2d20
// Size: 0x44
function function_e59a6c89(str_objective, var_74cd64bc, var_e4cd2b8b, player) {
    struct::function_368120a1("scene", "cin_sgen_05_01_discoverdata_1st_handgesture_player_dataacquired");
}

// Namespace cp_mi_sing_sgen_enter_silo
// Params 0, eflags: 0x1 linked
// Checksum 0x4d5eb9d3, Offset: 0x2d70
// Size: 0x74
function function_ab1ca63f() {
    level flag::wait_till("discover_data_tele");
    util::wait_network_frame();
    videostop("cp_sgen_env_lobbymovie");
    util::wait_network_frame();
    videostop("cp_sgen_env_LobbyMovie");
}

// Namespace cp_mi_sing_sgen_enter_silo
// Params 2, eflags: 0x1 linked
// Checksum 0xd17cfa4, Offset: 0x2df0
// Size: 0x384
function function_17b49f2c(str_objective, var_74cd64bc) {
    if (var_74cd64bc) {
        sgen::function_bff1a867(str_objective);
        mapping_drone::function_10dad989("nd_post_discover_data");
        level.var_2fd26037 ai::set_behavior_attribute("cqb", 1);
        level.var_2fd26037 ai::set_behavior_attribute("sprint", 0);
        bm_discover_data_player_clip = getent("bm_discover_data_player_clip", "targetname");
        bm_discover_data_player_clip delete();
        trig_discover_data_kill = getent("trig_discover_data_kill", "targetname");
        trig_discover_data_kill delete();
        objectives::complete("cp_level_sgen_enter_sgen_no_pointer");
        objectives::complete("cp_level_sgen_investigate_sgen");
        objectives::complete("cp_level_sgen_locate_emf");
        objectives::set("cp_level_sgen_descend_into_core");
        level scene::skipto_end("p7_fxanim_cp_sgen_hendricks_railing_kick_bundle");
        level flag::set("hendricks_data_anim_done");
        level flag::set("glass_railing_kicked");
        load::function_a2995f22();
        foreach (player in level.activeplayers) {
            player clientfield::set_to_player("sndSiloBG", 1);
        }
    }
    level thread function_2e4ed53c(var_74cd64bc);
    level thread function_8e0d5dae();
    level thread function_552e0e0a();
    level thread gen_lab_hendricks_safety();
    level.var_2fd26037 colors::disable();
    level.var_2fd26037 thread function_183c2b6();
    level.var_ea764859 thread function_f142d622();
    level thread function_d3711d76();
    level thread function_e7bc299d();
    level flag::wait_till("player_past_shimmy_wall");
    skipto::function_be8adfb8(str_objective);
}

// Namespace cp_mi_sing_sgen_enter_silo
// Params 4, eflags: 0x1 linked
// Checksum 0x9a4ae22f, Offset: 0x3180
// Size: 0x104
function function_e28bb832(str_objective, var_74cd64bc, var_e4cd2b8b, player) {
    struct::function_368120a1("scene", "p7_fxanim_cp_sgen_overhang_building_glass_bundle");
    struct::function_368120a1("scene", "cin_sgen_01_intro_3rd_pre200_overlook_sh010");
    struct::function_368120a1("scene", "cin_sgen_03_03_undeadqt_vign_limitedpower_corpses");
    struct::function_368120a1("scene", "cin_sgen_05_01_discoverdata_vign_lookaround_hendricks");
    struct::function_368120a1("scene", "cin_sgen_05_01_discoverdata_1st_handgestrure_player_dataacquired");
    struct::function_368120a1("scene", "cin_sgen_06_01_followleader_vign_activate_eac_drone");
    struct::function_368120a1("scene", "cin_sgen_06_01_followleader_vign_activate_eac_hendricks");
}

// Namespace cp_mi_sing_sgen_enter_silo
// Params 0, eflags: 0x1 linked
// Checksum 0x3f21deb3, Offset: 0x3290
// Size: 0x84
function function_e7bc299d() {
    level flag::wait_till("hendricks_follow1_wait2");
    level clientfield::increment("debris_catwalk", 1);
    level flag::wait_till("play_shimmy_wall_debris");
    level clientfield::increment("debris_wall", 1);
}

// Namespace cp_mi_sing_sgen_enter_silo
// Params 0, eflags: 0x1 linked
// Checksum 0x663af13e, Offset: 0x3320
// Size: 0xec
function function_552e0e0a() {
    level flag::wait_till("glass_railing_kicked");
    objectives::breadcrumb("post_data_breadcrumb");
    level flag::wait_till("post_discover_data");
    trig_discover_data_kill = getent("trig_discover_data_kill", "targetname");
    if (isdefined(trig_discover_data_kill)) {
        trig_discover_data_kill delete();
    }
    objectives::set("cp_level_sgen_descend_into_core");
    objectives::breadcrumb("obj_first_jump_down");
    function_d693b44a();
}

// Namespace cp_mi_sing_sgen_enter_silo
// Params 1, eflags: 0x1 linked
// Checksum 0x19c2b48f, Offset: 0x3418
// Size: 0x1ac
function function_8e9806c5(a_ents) {
    level waittill(#"hash_922f2f3");
    level.var_2fd26037 setmodel("spawner_ally_hero_hendricks_sgen");
    level.var_2fd26037.animname = "hendricks";
    util::clear_streamer_hint();
    level flag::wait_till("highlight_railing_glass");
    var_eb043fdb = getent("railing_kick", "animname");
    var_eb043fdb thread oed::function_e228c18a(0, "glass_railing_kicked");
    level flag::wait_till("glass_railing_kicked");
    level thread scene::play("p7_fxanim_cp_sgen_hendricks_railing_kick_bundle");
    level waittill(#"hash_359ae459");
    bm_discover_data_player_clip = getent("bm_discover_data_player_clip", "targetname");
    bm_discover_data_player_clip delete();
    trig_post_discover_data = getent("trig_post_discover_data", "targetname");
    trig_post_discover_data triggerenable(1);
}

// Namespace cp_mi_sing_sgen_enter_silo
// Params 0, eflags: 0x1 linked
// Checksum 0xd1f010af, Offset: 0x35d0
// Size: 0x16c
function function_183c2b6() {
    level flag::wait_till("hendricks_data_anim_done");
    level flag::wait_till("post_discover_data");
    level scene::play("cin_sgen_06_02_followtheleader_vign_hendricks_traversal_start");
    level flag::wait_till("hendricks_follow1_jump1");
    level scene::play("cin_sgen_06_02_followtheleader_vign_hendricks_traversal_finish");
    self colors::enable();
    trigger::use("trig_color_post_first_jump", undefined, undefined, 0);
    level flag::wait_till("hendricks_follow1_wait3");
    trigger::use("pre_gen_lab_after_slide");
    level scene::play("cin_sgen_06_02_followleader_vign_slide_hendricks");
    level flag::wait_till("player_near_shimmy");
    level.var_2fd26037 thread function_45dfc585();
}

// Namespace cp_mi_sing_sgen_enter_silo
// Params 1, eflags: 0x1 linked
// Checksum 0x804420e9, Offset: 0x3748
// Size: 0x1e4
function function_2e4ed53c(var_74cd64bc) {
    level flag::wait_till("post_discover_data");
    if (var_74cd64bc) {
        level.var_2fd26037 dialog::say("hend_hey_let_s_go_0");
        level.var_2fd26037 dialog::say("hend_stick_to_the_ledge_0", 1);
    }
    wait 3;
    level flag::wait_till("enter_silo_killings_vo");
    wait 2;
    level.var_2fd26037 ai::set_behavior_attribute("cqb", 1);
    level.var_2fd26037 ai::set_behavior_attribute("sprint", 0);
    level dialog::function_13b3b16a("plyr_the_footage_we_saw_o_0");
    level.var_2fd26037 dialog::say("hend_i_ve_known_taylor_a_0", 1.5);
    level dialog::function_13b3b16a("plyr_maybe_he_wasn_t_the_0", 0.75);
    level.var_2fd26037 dialog::say("hend_even_so_doesn_t_ex_0", 1.33);
    level dialog::function_13b3b16a("plyr_we_ll_get_to_the_bot_0", 1);
    level.var_2fd26037 ai::set_behavior_attribute("cqb", 0);
    level.var_2fd26037 ai::set_behavior_attribute("sprint", 1);
}

// Namespace cp_mi_sing_sgen_enter_silo
// Params 0, eflags: 0x1 linked
// Checksum 0x63340086, Offset: 0x3938
// Size: 0xb8
function function_8e0d5dae() {
    var_4fee738e = getent("dust_fx", "targetname");
    var_4fee738e endon(#"death");
    while (true) {
        who = var_4fee738e waittill(#"trigger");
        if (isplayer(who)) {
            var_4fee738e setinvisibletoplayer(who);
            who clientfield::set_to_player("dust_motes", 1);
        }
    }
}

// Namespace cp_mi_sing_sgen_enter_silo
// Params 0, eflags: 0x1 linked
// Checksum 0x194e5e4f, Offset: 0x39f8
// Size: 0x13e
function function_d3711d76() {
    var_4121a753 = getent("oarfish", "targetname");
    level flag::wait_till("hendricks_follow1_wait2");
    var_4121a753.angles += (-15, 0, 0);
    n_time = 10;
    s_target = var_4121a753;
    while (isdefined(s_target.target)) {
        s_target = struct::get(s_target.target, "targetname");
        var_4121a753 moveto(s_target.origin, n_time);
        var_4121a753 rotateto(s_target.angles, n_time, n_time / 2, n_time / 2);
        wait n_time;
    }
}

// Namespace cp_mi_sing_sgen_enter_silo
// Params 2, eflags: 0x1 linked
// Checksum 0x73f1e0c7, Offset: 0x3b40
// Size: 0x2e4
function function_ab2e4091(str_objective, var_74cd64bc) {
    if (var_74cd64bc) {
        sgen::function_bff1a867(str_objective);
        mapping_drone::function_10dad989("nd_start_gen_lab");
        objectives::complete("cp_level_sgen_enter_sgen_no_pointer");
        objectives::complete("cp_level_sgen_investigate_sgen");
        objectives::complete("cp_level_sgen_locate_emf");
        objectives::set("cp_level_sgen_descend_into_core");
        level.var_2fd26037 thread function_45dfc585();
        level thread function_d693b44a();
        level thread namespace_d40478f6::function_fb17452c();
        load::function_a2995f22();
        foreach (player in level.activeplayers) {
            player clientfield::set_to_player("sndSiloBG", 1);
            player clientfield::set_to_player("dust_motes", 1);
        }
    }
    level thread function_bed09c90();
    level clientfield::set("sndLabWalla", 1);
    level.var_ea764859 thread function_a6381cd();
    trig_gen_lab_door_player_check = getent("trig_gen_lab_door_player_check", "targetname");
    trig_gen_lab_door_player_check triggerenable(0);
    level thread function_7e668807();
    level thread scene::init("p7_fxanim_cp_sgen_lab_ceiling_light_01_bundle");
    level thread scene::init("p7_fxanim_cp_sgen_lab_ceiling_light_02_bundle");
    level flag::wait_till_all(array("hendricks_at_gen_lab_door", "player_at_gen_lab_door"));
    skipto::function_be8adfb8(str_objective);
}

// Namespace cp_mi_sing_sgen_enter_silo
// Params 0, eflags: 0x1 linked
// Checksum 0x3d4459, Offset: 0x3e30
// Size: 0x54
function function_d693b44a() {
    objectives::breadcrumb("sgen_lab_breadcrumb_1");
    level flag::wait_till("gen_lab_cleared");
    objectives::breadcrumb("sgen_labs_exit_breadcrumb");
}

// Namespace cp_mi_sing_sgen_enter_silo
// Params 0, eflags: 0x1 linked
// Checksum 0xdc0c4178, Offset: 0x3e90
// Size: 0x17c
function function_bed09c90() {
    level flag::wait_till("trig_spawn_gen_lab");
    var_f40abca8 = getentarray("lobby_entrance_doors", "script_noteworthy");
    var_280d5f68 = getent("silo_door_left", "targetname");
    var_3c301126 = getent("silo_door_right", "targetname");
    var_280d5f68 rotateyaw(91, 1, 0.25, 0.4);
    playsoundatposition("evt_silo_door_open", var_280d5f68.origin);
    var_3c301126 rotateyaw(-91, 1, 0.25, 0.4);
    playsoundatposition("evt_silo_door_open", var_3c301126.origin);
}

// Namespace cp_mi_sing_sgen_enter_silo
// Params 0, eflags: 0x1 linked
// Checksum 0xb876e, Offset: 0x4018
// Size: 0x164
function function_7e668807() {
    level flag::wait_till("trig_spawn_gen_lab");
    level thread function_eee46d16();
    level thread function_a05adac1();
    level.var_2fd26037 thread function_c7a9d766();
    foreach (e_player in level.activeplayers) {
        e_player thread function_7d0e1b80();
    }
    level thread function_65b50bfd();
    level flag::wait_till("player_mid_gen_lab");
    spawner::simple_spawn("gen_lab_enemy_wave_2", &function_3121a98c);
    level thread function_f092b9c1();
}

// Namespace cp_mi_sing_sgen_enter_silo
// Params 0, eflags: 0x1 linked
// Checksum 0x7cd258c1, Offset: 0x4188
// Size: 0x7c
function function_3121a98c() {
    self.goalradius = 1024;
    self ai::set_behavior_attribute("cqb", 1);
    var_e2f91888 = getent("vol_gen_lab_fallback", "targetname");
    self setgoal(var_e2f91888);
}

// Namespace cp_mi_sing_sgen_enter_silo
// Params 0, eflags: 0x1 linked
// Checksum 0xb8d10aff, Offset: 0x4210
// Size: 0x54
function function_a05adac1() {
    level flag::wait_till("gen_lab_gone_hot");
    level battlechatter::function_d9f49fba(1);
    spawner::simple_spawn("gen_lab_reinforcements");
}

// Namespace cp_mi_sing_sgen_enter_silo
// Params 0, eflags: 0x1 linked
// Checksum 0xf98eab23, Offset: 0x4270
// Size: 0x5c
function function_65b50bfd() {
    level flag::wait_till("player_front_gen_lab");
    level flag::set("gen_lab_gone_hot");
    level thread namespace_d40478f6::function_b345d175();
}

// Namespace cp_mi_sing_sgen_enter_silo
// Params 0, eflags: 0x1 linked
// Checksum 0xb601f72c, Offset: 0x42d8
// Size: 0x84
function function_c7a9d766() {
    self ai::set_ignoreme(1);
    self ai::set_ignoreall(1);
    level flag::wait_till("gen_lab_gone_hot");
    self ai::set_ignoreme(0);
    self ai::set_ignoreall(0);
}

// Namespace cp_mi_sing_sgen_enter_silo
// Params 0, eflags: 0x1 linked
// Checksum 0x99648a7b, Offset: 0x4368
// Size: 0x74
function function_7d0e1b80() {
    self endon(#"death");
    self ai::set_ignoreme(1);
    level flag::wait_till("gen_lab_gone_hot");
    if (self.active_camo === 1) {
        self waittill(#"hash_1d75a6cc");
    }
    self ai::set_ignoreme(0);
}

// Namespace cp_mi_sing_sgen_enter_silo
// Params 0, eflags: 0x1 linked
// Checksum 0xc00e23b3, Offset: 0x43e8
// Size: 0x9c
function function_eee46d16() {
    spawner::waittill_ai_group_amount_killed("gen_lab_enemies", 3);
    trigger::use("gen_lab_color_chain_front", undefined, undefined, 0);
    spawner::waittill_ai_group_amount_killed("gen_lab_enemies", 6);
    spawner::waittill_ai_group_cleared("gen_lab_warlords");
    trigger::use("gen_lab_color_chain_mid", undefined, undefined, 0);
}

// Namespace cp_mi_sing_sgen_enter_silo
// Params 1, eflags: 0x1 linked
// Checksum 0x2cbf91fd, Offset: 0x4490
// Size: 0xaa
function function_426de534(a_ents) {
    foreach (ent in a_ents) {
        if (isai(ent)) {
            ent thread function_3764d5e();
        }
    }
}

// Namespace cp_mi_sing_sgen_enter_silo
// Params 0, eflags: 0x1 linked
// Checksum 0xf796c529, Offset: 0x4548
// Size: 0x6c
function function_3764d5e() {
    level endon(#"gen_lab_gone_hot");
    self waittill(#"damage");
    namespace_cba4cc55::function_9cb9697d(self.current_scene);
    level flag::set("gen_lab_gone_hot");
    level thread namespace_d40478f6::function_b345d175();
}

// Namespace cp_mi_sing_sgen_enter_silo
// Params 0, eflags: 0x1 linked
// Checksum 0xf7746f3, Offset: 0x45c0
// Size: 0x264
function function_1cc12213() {
    self endon(#"death");
    self.var_a09dbf8c = self.maxsightdistsqrd;
    self.maxsightdistsqrd = 360000;
    self.fovcosine = 0.95;
    self thread function_9ce64b5a();
    self thread function_d7c7eef1();
    self oed::function_6e4b8a4f();
    self ai::set_ignoreme(1);
    self ai::set_ignoreall(1);
    if (self.script_string === "gen_lab_force_hot_guy") {
        self thread function_552c9cce();
    }
    level flag::wait_till("gen_lab_gone_hot");
    self.maxsightdistsqrd = self.var_a09dbf8c;
    self.fovcosine = 0;
    self ai::set_behavior_attribute("cqb", 1);
    self ai::set_ignoreme(0);
    self ai::set_ignoreall(0);
    self.goalradius = 1024;
    if (self.script_string === "cover_office") {
        var_36b24c48 = getent("gen_lab_office_goalvolume", "targetname");
    } else {
        var_36b24c48 = getent("gen_lab_soldier_goal", "targetname");
    }
    self setgoal(var_36b24c48);
    level flag::wait_till("player_mid_gen_lab");
    var_e2f91888 = getent("vol_gen_lab_fallback", "targetname");
    self setgoal(var_e2f91888);
}

// Namespace cp_mi_sing_sgen_enter_silo
// Params 0, eflags: 0x1 linked
// Checksum 0xded5163, Offset: 0x4830
// Size: 0xf0
function function_9ce64b5a() {
    level endon(#"gen_lab_gone_hot");
    self endon(#"death");
    while (true) {
        foreach (player in level.activeplayers) {
            if (self cansee(player)) {
                level flag::set("gen_lab_gone_hot");
                level thread namespace_d40478f6::function_b345d175();
            }
        }
        wait 0.5;
    }
}

// Namespace cp_mi_sing_sgen_enter_silo
// Params 0, eflags: 0x1 linked
// Checksum 0xd1fc1799, Offset: 0x4928
// Size: 0x4c
function function_d7c7eef1() {
    self util::waittill_any("bulletwhizby", "grenade_fire");
    level flag::set("gen_lab_gone_hot");
}

// Namespace cp_mi_sing_sgen_enter_silo
// Params 0, eflags: 0x1 linked
// Checksum 0xb47596b1, Offset: 0x4980
// Size: 0x7c
function function_552c9cce() {
    level endon(#"gen_lab_gone_hot");
    self endon(#"death");
    level flag::wait_till("hendricks_in_gen_lab");
    nd_gen_lab_patrol_force_hot = getnode("nd_gen_lab_patrol_force_hot", "targetname");
    self thread ai::patrol(nd_gen_lab_patrol_force_hot);
}

// Namespace cp_mi_sing_sgen_enter_silo
// Params 0, eflags: 0x1 linked
// Checksum 0xd55ffa52, Offset: 0x4a08
// Size: 0x10c
function function_aafbf321() {
    self endon(#"death");
    self oed::function_6e4b8a4f();
    self ai::set_ignoreme(1);
    self ai::set_ignoreall(1);
    level flag::wait_till("gen_lab_gone_hot");
    self setgoal(self.origin);
    self.goalradius = 1024;
    self ai::set_ignoreme(0);
    self ai::set_ignoreall(0);
    self namespace_69ee7109::function_13ed0a8b(1);
    self function_f61c0df8("node_gen_lab_warlord_preferred", 3, 5);
}

// Namespace cp_mi_sing_sgen_enter_silo
// Params 4, eflags: 0x1 linked
// Checksum 0x20ccf83f, Offset: 0x4b20
// Size: 0xe4
function function_627360fb(str_objective, var_74cd64bc, var_e4cd2b8b, player) {
    level flag::set("gen_lab_door_opened");
    struct::function_368120a1("scene", "cin_sgen_06_02_followtheleader_vign_hendricks_traversal_start");
    struct::function_368120a1("scene", "cin_sgen_06_02_followtheleader_vign_hendricks_traversal_finish");
    struct::function_368120a1("scene", "cin_sgen_06_02_followleader_vign_slide_hendricks");
    struct::function_368120a1("scene", "cin_sgen_06_02_follow_leader_vign_wallrun");
    struct::function_368120a1("scene", "cin_sgen_07_01_genlab_vign_patrol");
}

// Namespace cp_mi_sing_sgen_enter_silo
// Params 0, eflags: 0x1 linked
// Checksum 0x5b51e2d, Offset: 0x4c10
// Size: 0xb4
function function_f092b9c1() {
    spawner::waittill_ai_group_cleared("gen_lab_enemies");
    spawner::waittill_ai_group_cleared("gen_lab_warlords");
    if (isdefined(level.var_c4dba52c)) {
        [[ level.var_c4dba52c ]]();
    }
    level flag::set("gen_lab_cleared");
    level thread namespace_d40478f6::function_973b77f9();
    level thread namespace_d40478f6::function_d930fe43();
    level battlechatter::function_d9f49fba(0);
}

// Namespace cp_mi_sing_sgen_enter_silo
// Params 3, eflags: 0x1 linked
// Checksum 0x491a2aa, Offset: 0x4cd0
// Size: 0xea
function function_f61c0df8(var_e39815ad, n_time_min, n_time_max) {
    var_91efa0da = getnodearray(var_e39815ad, "targetname");
    foreach (node in var_91efa0da) {
        self namespace_69ee7109::function_da308a83(node.origin, n_time_min * 1000, n_time_max * 1000);
    }
}

// Namespace cp_mi_sing_sgen_enter_silo
// Params 0, eflags: 0x1 linked
// Checksum 0x136e376a, Offset: 0x4dc8
// Size: 0x31c
function function_45dfc585() {
    self colors::disable();
    nd_hendricks_post_shimmy_wall = getnode("nd_hendricks_post_shimmy_wall", "targetname");
    self thread ai::force_goal(nd_hendricks_post_shimmy_wall, 32);
    level flag::wait_till("player_past_shimmy_wall");
    level scene::play("cin_sgen_06_02_follow_leader_vign_wallrun");
    self ai::set_behavior_attribute("cqb", 1);
    self ai::set_behavior_attribute("sprint", 0);
    nd_hendricks_outside_gen_lab = getnode("nd_hendricks_outside_gen_lab", "targetname");
    self thread ai::force_goal(nd_hendricks_outside_gen_lab, 32);
    level flag::wait_till("hendricks_gen_lab_intro_color");
    nd_hendricks_front_gen_lab = getnode("nd_hendricks_front_gen_lab", "targetname");
    self ai::force_goal(nd_hendricks_front_gen_lab, 32);
    level flag::set("hendricks_in_gen_lab");
    self colors::enable();
    level thread function_532aa385();
    level flag::wait_till("gen_lab_gone_hot");
    level.var_2fd26037 ai::set_ignoreall(0);
    level thread namespace_d40478f6::function_b345d175();
    self.goalradius = 1024;
    level flag::wait_till("gen_lab_cleared");
    self colors::disable();
    nd_gen_lab_door = getnode("nd_gen_lab_door", "targetname");
    self setgoal(nd_gen_lab_door, 1);
    self waittill(#"goal");
    level flag::set("hendricks_at_gen_lab_door");
    level flag::wait_till("gen_lab_door_opened");
    self colors::enable();
}

// Namespace cp_mi_sing_sgen_enter_silo
// Params 0, eflags: 0x1 linked
// Checksum 0x7e1bc53f, Offset: 0x50f0
// Size: 0x9c
function function_532aa385() {
    level endon(#"gen_lab_gone_hot");
    var_c085d91c = [];
    var_c085d91c[0] = "hendricks_in_gen_lab";
    var_c085d91c[1] = "pre_gen_lab_vo_done";
    level flag::wait_till_any(var_c085d91c);
    if (!level flag::get("gen_lab_gone_hot")) {
        level.var_2fd26037 dialog::say("hend_take_the_first_shot_0");
    }
}

// Namespace cp_mi_sing_sgen_enter_silo
// Params 2, eflags: 0x1 linked
// Checksum 0x80b3264d, Offset: 0x5198
// Size: 0x324
function function_d26cae1c(str_objective, var_74cd64bc) {
    if (var_74cd64bc) {
        sgen::function_bff1a867(str_objective);
        mapping_drone::function_10dad989("nd_post_gen_lab_start");
        objectives::complete("cp_level_sgen_enter_sgen_no_pointer");
        objectives::complete("cp_level_sgen_investigate_sgen");
        objectives::complete("cp_level_sgen_locate_emf");
        objectives::set("cp_level_sgen_descend_into_core");
        level thread objectives::breadcrumb("sgen_labs_exit_breadcrumb");
        var_6d927f8e = getent("gen_lab_end_door", "targetname");
        var_6d927f8e delete();
        level flag::set("gen_lab_door_opened");
        load::function_a2995f22();
        foreach (player in level.activeplayers) {
            player clientfield::set_to_player("sndSiloBG", 1);
            player clientfield::set_to_player("dust_motes", 1);
        }
        level thread namespace_d40478f6::function_d930fe43();
    }
    level notify(#"hash_996f8b77");
    level thread function_8a4d2dee();
    level thread function_a6226aba();
    level.var_2fd26037 thread function_201e2a08();
    level.var_ea764859 thread function_2c83d390();
    var_58d37bcd = getent("trig_bridge_kill_trigger", "targetname");
    var_58d37bcd triggerenable(0);
    var_dee3d10a = getent("1", "scriptgroup_playerspawns_regroup");
    var_dee3d10a.script_regroup_distance = 500;
    level flag::wait_till("follow_chem_lab");
    skipto::function_be8adfb8(str_objective);
}

// Namespace cp_mi_sing_sgen_enter_silo
// Params 4, eflags: 0x1 linked
// Checksum 0x234a98dc, Offset: 0x54c8
// Size: 0x24
function function_dcc3e542(str_objective, var_74cd64bc, var_e4cd2b8b, player) {
    
}

// Namespace cp_mi_sing_sgen_enter_silo
// Params 0, eflags: 0x1 linked
// Checksum 0x2ddf89fb, Offset: 0x54f8
// Size: 0xac
function gen_lab_hendricks_safety() {
    level endon(#"hash_8210273d");
    level flag::wait_till("gen_lab_hendricks_safety");
    level flag::set("hendricks_follow1_jump1");
    level flag::set("hendricks_follow1_wait2");
    level flag::set("hendricks_follow1_wait3");
    level flag::set("hendricks_follow1_wait4");
}

// Namespace cp_mi_sing_sgen_enter_silo
// Params 0, eflags: 0x1 linked
// Checksum 0x1b3562b1, Offset: 0x55b0
// Size: 0xf4
function function_8a4d2dee() {
    hidemiscmodels("silo_bridge_edge_break_static");
    level clientfield::increment("debris_fall", 1);
    level flag::wait_till("main_bridge_collapse");
    level thread scene::play("p7_fxanim_cp_sgen_bridge_silo_debris_bundle");
    level scene::play("p7_fxanim_cp_sgen_bridge_silo_edge_break_bundle");
    showmiscmodels("silo_bridge_edge_break_static");
    level flag::wait_till("post_bridge_collapse_rocks");
    level clientfield::increment("debris_bridge", 1);
}

// Namespace cp_mi_sing_sgen_enter_silo
// Params 0, eflags: 0x1 linked
// Checksum 0xa8cabe74, Offset: 0x56b0
// Size: 0x224
function function_201e2a08() {
    level scene::play("cin_sgen_08_01_followleader_2_vign_pathfinding_aie_jumpdown_hendricks");
    level flag::wait_till("hendricks_follow2_wallrun_trick");
    scene::add_scene_func("cin_sgen_09_01_chemlab_vign_windowknock_robots_start", &function_67a6b650);
    level thread scene::play("cin_sgen_09_01_chemlab_vign_windowknock_robots_start");
    level scene::play("cin_sgen_08_01_followleader2_vign_wallrun");
    level flag::wait_till("hendricks_wallrun_done");
    self setgoal(getnode("nd_before_bridge_collapse", "targetname"), 1);
    self ai::set_behavior_attribute("cqb", 1);
    self ai::set_behavior_attribute("sprint", 0);
    level flag::wait_till("post_bridge_collapse_rocks");
    self thread dialog::say("hend_watch_your_step_t_1", 1);
    level scene::stop("cin_sgen_08_01_followleader2_vign_wallrun");
    self setgoal(getnode("nd_after_bridge_collapse", "targetname"), 1);
    self waittill(#"goal");
    self ai::set_behavior_attribute("cqb", 0);
    self ai::set_behavior_attribute("sprint", 1);
}

// Namespace cp_mi_sing_sgen_enter_silo
// Params 0, eflags: 0x1 linked
// Checksum 0x68e58474, Offset: 0x58e0
// Size: 0x6c
function function_a6226aba() {
    level flag::wait_till("hendricks_follow2_jumpdown");
    level.var_2fd26037 dialog::say("hend_you_trying_to_send_u_0");
    level dialog::remote("kane_i_just_want_the_same_0", 0.75);
}

// Namespace cp_mi_sing_sgen_enter_silo
// Params 2, eflags: 0x1 linked
// Checksum 0x610b0d61, Offset: 0x5958
// Size: 0x364
function function_f6774f56(str_objective, var_74cd64bc) {
    if (var_74cd64bc) {
        sgen::function_bff1a867(str_objective);
        mapping_drone::function_10dad989("nd_follow_chem_lab");
        objectives::complete("cp_level_sgen_enter_sgen_no_pointer");
        objectives::complete("cp_level_sgen_investigate_sgen");
        objectives::complete("cp_level_sgen_locate_emf");
        objectives::set("cp_level_sgen_descend_into_core");
        level scene::skipto_end("p7_fxanim_cp_sgen_bridge_silo_edge_break_bundle");
        level flag::set("hendricks_wallrun_done");
        scene::add_scene_func("cin_sgen_09_01_chemlab_vign_windowknock_robots_start", &function_67a6b650);
        level thread scene::play("cin_sgen_09_01_chemlab_vign_windowknock_robots_start");
        level thread namespace_d40478f6::function_d930fe43();
        load::function_a2995f22();
        foreach (player in level.activeplayers) {
            player clientfield::set_to_player("sndSiloBG", 1);
            player clientfield::set_to_player("dust_motes", 1);
        }
    }
    if (isdefined(level.var_685af7f6)) {
        level thread [[ level.var_685af7f6 ]]();
    }
    level.var_2fd26037 thread function_53d46eee();
    level.var_ea764859 thread function_1acc965e();
    level scene::init("cin_sgen_09_02_chem_lab_vign_opendoor_hendricks");
    level scene::init("cin_sgen_11_02_silofloor_vign_notice_hendricks");
    level thread function_631aad();
    level thread function_5a74dfe6();
    level thread function_144d5a8a();
    trig_player_at_silo_floor = getent("trig_player_at_silo_floor", "targetname");
    trig_player_at_silo_floor triggerenable(0);
    level flag::wait_till("follow3_1");
    skipto::function_be8adfb8(str_objective);
}

// Namespace cp_mi_sing_sgen_enter_silo
// Params 4, eflags: 0x1 linked
// Checksum 0xe5bb9d77, Offset: 0x5cc8
// Size: 0x8c
function function_79f1dc0(str_objective, var_74cd64bc, var_e4cd2b8b, player) {
    level flag::set("chem_door_open");
    struct::function_368120a1("cin_sgen_09_01_chemlab_vign_windowknock_robots_stop");
    struct::function_368120a1("cin_sgen_09_01_chemlab_vign_windowknock_hendricks_start_idle");
    struct::function_368120a1("cin_sgen_09_01_chemlab_vign_windowknock_hendricks_moveinroom");
}

// Namespace cp_mi_sing_sgen_enter_silo
// Params 0, eflags: 0x1 linked
// Checksum 0xd33c153e, Offset: 0x5d60
// Size: 0x6c
function function_631aad() {
    level thread objectives::breadcrumb("obj_chem_lab_mid_breadcrumb");
    level flag::wait_till("player_in_chem_lab");
    level waittill(#"hash_7afd09b6");
    objectives::breadcrumb("obj_chem_lab_door_breadcrumb");
}

// Namespace cp_mi_sing_sgen_enter_silo
// Params 0, eflags: 0x1 linked
// Checksum 0x3399e2be, Offset: 0x5dd8
// Size: 0x32c
function function_53d46eee() {
    level flag::wait_till("hendricks_wallrun_done");
    self ai::set_ignoreme(1);
    self ai::set_ignoreall(1);
    self ai::set_behavior_attribute("cqb", 1);
    self ai::set_behavior_attribute("sprint", 0);
    level thread scene::play("cin_sgen_09_01_chemlab_vign_windowknock_hendricks_start_idle");
    level waittill(#"hash_797660ac");
    level flag::wait_till("chem_lab_start");
    level scene::play("cin_sgen_09_01_chemlab_vign_windowknock_hendricks_moveinroom");
    level flag::wait_till("player_in_chem_lab");
    level thread scene::play("cin_sgen_09_01_chemlab_vign_windowknock_robots_stop");
    level thread scene::play("cin_sgen_09_02_chem_lab_vign_workerbot_robot01_breakfree");
    level flag::wait_till("chem_lab_hendricks_movein_done");
    level thread scene::play("cin_sgen_09_02_chem_lab_vign_opendoor_hendricks");
    level waittill(#"hash_99a916d7");
    var_91729078 = getent("chem_lab_door_player_clip", "targetname");
    var_91729078 notsolid();
    level waittill(#"hash_7afd09b6");
    level thread function_c411551e();
    level flag::set("chem_door_open");
    trigger::wait_till("trig_silo_floor_player_check");
    level flag::set("all_players_outside_chem_lab");
    var_91729078 solid();
    level scene::play("cin_sgen_09_02_chem_lab_vign_exitdoor_hendricks");
    level.var_2fd26037 ai::set_ignoreme(0);
    level.var_2fd26037 ai::set_ignoreall(0);
    level.var_2fd26037 ai::set_behavior_attribute("cqb", 0);
    level.var_2fd26037 ai::set_behavior_attribute("sprint", 1);
    self thread function_abf124c5();
}

// Namespace cp_mi_sing_sgen_enter_silo
// Params 0, eflags: 0x1 linked
// Checksum 0x27353f98, Offset: 0x6110
// Size: 0x6c
function function_c411551e() {
    level endon(#"all_players_outside_chem_lab");
    level endon(#"start_chem_lab_robot_scare");
    wait 8;
    level.var_2fd26037 dialog::say("hend_i_m_not_gonna_hold_i_0");
    wait 10;
    level.var_2fd26037 dialog::say("hend_wanna_pick_up_the_pa_0");
}

// Namespace cp_mi_sing_sgen_enter_silo
// Params 0, eflags: 0x1 linked
// Checksum 0xe1b20752, Offset: 0x6188
// Size: 0x9c
function function_144d5a8a() {
    scene::add_scene_func("cin_sgen_09_02_chem_lab_vign_workerbot_robot01_breakfree", &function_67a6b650);
    scene::init("cin_sgen_09_02_chem_lab_vign_workerbot_robot01_breakfree");
    level thread function_ed4bb74b();
    level flag::wait_till("start_chem_lab_robot_scare");
    level thread scene::play("cin_sgen_09_02_chem_lab_vign_workerbot_robot01_breakfree_stop");
}

// Namespace cp_mi_sing_sgen_enter_silo
// Params 0, eflags: 0x1 linked
// Checksum 0x36bcedc7, Offset: 0x6230
// Size: 0x9c
function function_ed4bb74b() {
    level clientfield::set("w_robot_window_break", 2);
    level waittill(#"hash_d4320be3");
    level thread namespace_d40478f6::function_98762d53();
    level notify(#"hash_aa7c8a11");
    level.players[0] thread dialog::function_13b3b16a("plyr_shit_1", 1);
    level clientfield::set("w_robot_window_break", 1);
}

// Namespace cp_mi_sing_sgen_enter_silo
// Params 1, eflags: 0x1 linked
// Checksum 0xf1d5b476, Offset: 0x62d8
// Size: 0x2c
function function_67a6b650(a_ents) {
    array::thread_all_ents(a_ents, &function_7bff1955);
}

// Namespace cp_mi_sing_sgen_enter_silo
// Params 1, eflags: 0x1 linked
// Checksum 0xcd17296f, Offset: 0x6310
// Size: 0x7c
function function_7bff1955(var_6104a93b) {
    var_6104a93b attach("c_cia_robot_dam_1_lights_1");
    var_6104a93b clientfield::set("play_cia_robot_rogue_control", 1);
    var_6104a93b waittill(#"hash_4289520f");
    var_6104a93b clientfield::set("play_cia_robot_rogue_control", 0);
}

// Namespace cp_mi_sing_sgen_enter_silo
// Params 2, eflags: 0x1 linked
// Checksum 0x22a075e3, Offset: 0x6398
// Size: 0x3ac
function function_4843e971(str_objective, var_74cd64bc) {
    if (var_74cd64bc) {
        sgen::function_bff1a867(str_objective);
        level.var_2fd26037 ai::set_behavior_attribute("cqb", 1);
        level.var_2fd26037 ai::set_behavior_attribute("sprint", 0);
        level flag::set("player_in_chem_lab");
        mapping_drone::function_10dad989("nd_pre_ambush");
        level.var_ea764859 thread function_3054092d();
        level.var_2fd26037 thread function_abf124c5();
        objectives::complete("cp_level_sgen_enter_sgen_no_pointer");
        objectives::complete("cp_level_sgen_investigate_sgen");
        objectives::complete("cp_level_sgen_locate_emf");
        objectives::set("cp_level_sgen_descend_into_core");
        level scene::skipto_end("p7_fxanim_cp_sgen_bridge_silo_edge_break_bundle");
        level scene::skipto_end("cin_sgen_09_02_chem_lab_vign_exitdoor_hendricks");
        scene::add_scene_func("cin_sgen_11_02_silofloor_vign_notice_hendricks", &function_2e68b5db, "init");
        level scene::init("cin_sgen_11_02_silofloor_vign_notice_hendricks");
        level thread function_5a74dfe6();
        level thread namespace_d40478f6::function_98762d53();
        level flag::set("follow3_1");
        trig_player_at_silo_floor = getent("trig_player_at_silo_floor", "targetname");
        trig_player_at_silo_floor triggerenable(0);
        level flag::set("chem_door_open");
        load::function_a2995f22();
        foreach (player in level.activeplayers) {
            player clientfield::set_to_player("sndSiloBG", 1);
            player clientfield::set_to_player("dust_motes", 1);
        }
    }
    level thread function_9ed55736();
    level flag::wait_till("player_at_silo_floor");
    if (isdefined(level.var_72cf7c7d)) {
        level thread [[ level.var_72cf7c7d ]]();
    }
    skipto::function_be8adfb8(str_objective);
}

// Namespace cp_mi_sing_sgen_enter_silo
// Params 4, eflags: 0x1 linked
// Checksum 0x96f7f73, Offset: 0x6750
// Size: 0x84
function function_ff8909db(str_objective, var_74cd64bc, var_e4cd2b8b, player) {
    struct::function_368120a1("cin_sgen_09_02_chem_lab_vign_workerbot_robot01_breakfree");
    struct::function_368120a1("cin_sgen_09_02_chem_lab_vign_workerbot_robot01_breakfree_stop");
    struct::function_368120a1("cin_sgen_09_02_chem_lab_vign_opendoor_hendricks");
    struct::function_368120a1("cin_sgen_09_02_chem_lab_vign_exitdoor_hendricks");
}

// Namespace cp_mi_sing_sgen_enter_silo
// Params 0, eflags: 0x1 linked
// Checksum 0xc93fb03b, Offset: 0x67e0
// Size: 0x1c
function function_9ed55736() {
    objectives::breadcrumb("obj_chem_lab_slide_breadcrumb");
}

// Namespace cp_mi_sing_sgen_enter_silo
// Params 0, eflags: 0x1 linked
// Checksum 0x7a4c4912, Offset: 0x6808
// Size: 0x11c
function function_abf124c5() {
    level thread function_dce4e081();
    self.goalradius = 32;
    nd_hendricks_post_chem_lab = getnode("nd_hendricks_post_chem_lab", "targetname");
    self setgoal(nd_hendricks_post_chem_lab.origin, 1);
    level flag::wait_till("hendricks_follow3_wait1");
    level scene::play("cin_sgen_10_01_followleader3_vign_slide");
    var_f98517de = getnode("hendricks_silo_floor", "targetname");
    self ai::force_goal(var_f98517de, 32);
    self thread function_fe2615a5();
}

// Namespace cp_mi_sing_sgen_enter_silo
// Params 0, eflags: 0x1 linked
// Checksum 0x7f4d13dd, Offset: 0x6930
// Size: 0x44
function function_dce4e081() {
    level dialog::remote("plyr_kane_could_someone_0");
    level dialog::remote("kane_it_s_unlikely_that_a_0");
}

// Namespace cp_mi_sing_sgen_enter_silo
// Params 0, eflags: 0x1 linked
// Checksum 0xccca64c2, Offset: 0x6980
// Size: 0xea
function function_c15000a5() {
    level flag::wait_till("player_ev_tutorial");
    foreach (player in level.activeplayers) {
        if (isdefined(player.var_aa3f3ac2) && player.var_aa3f3ac2) {
            return;
        }
        player thread util::show_hint_text(%CP_MI_SING_SGEN_EV_TUTORIAL, 0, "enhanced_vision_activated", 5);
    }
}

// Namespace cp_mi_sing_sgen_enter_silo
// Params 2, eflags: 0x1 linked
// Checksum 0xbf257acc, Offset: 0x6a78
// Size: 0x2e4
function function_6926cd7f(str_objective, var_74cd64bc) {
    if (var_74cd64bc) {
        sgen::function_bff1a867(str_objective);
        level.var_2fd26037 ai::set_behavior_attribute("cqb", 1);
        level.var_2fd26037 ai::set_behavior_attribute("sprint", 0);
        level.var_2fd26037 thread function_fe2615a5();
        mapping_drone::function_10dad989("nd_highlight_grate");
        level.var_ea764859 thread function_fdbec74b();
        objectives::complete("cp_level_sgen_enter_sgen_no_pointer");
        objectives::complete("cp_level_sgen_investigate_sgen");
        objectives::complete("cp_level_sgen_locate_emf");
        objectives::set("cp_level_sgen_descend_into_core");
        level scene::skipto_end("p7_fxanim_cp_sgen_bridge_silo_edge_break_bundle");
        scene::add_scene_func("cin_sgen_11_02_silofloor_vign_notice_hendricks", &function_2e68b5db, "init");
        level scene::init("cin_sgen_11_02_silofloor_vign_notice_hendricks");
        level flag::set("follow3_1");
        level thread function_5a74dfe6();
        load::function_a2995f22();
        foreach (player in level.activeplayers) {
            player clientfield::set_to_player("sndSiloBG", 1);
            player clientfield::set_to_player("dust_motes", 1);
        }
        level flag::set("start_silo_floor_battle");
    }
    level thread function_6720a440();
    function_ee660c8a();
    skipto::function_be8adfb8(str_objective);
}

// Namespace cp_mi_sing_sgen_enter_silo
// Params 0, eflags: 0x1 linked
// Checksum 0x852db5ac, Offset: 0x6d68
// Size: 0x1ec
function function_6720a440() {
    level flag::wait_till("hendricks_at_silo_floor");
    level flag::wait_till("player_at_silo_floor");
    level flag::set("send_drone_over_grate");
    level.var_2fd26037 dialog::say("hend_recon_drone_says_the_0");
    level.var_2fd26037 dialog::say("hend_anyone_wanna_bet_a_h_0", 0.5);
    playsoundatposition(" evt_metal_bang", (-624, 995, -2569));
    wait 1;
    playsoundatposition("mus_coalescence_theme_silo", (-624, 995, -2569));
    wait 1;
    level notify(#"ambush");
    level thread namespace_d40478f6::function_e596bdfd();
    level flag::set("start_floor_risers");
    level.var_2fd26037 dialog::say("hend_whoa_what_the_hel_0");
    level.var_2fd26037 dialog::say("hend_whoa_whoa_0", 1);
    level dialog::remote("kane_hendricks_they_re_t_0");
    level flag::wait_till("start_silo_ambush");
    level battlechatter::function_d9f49fba(1);
}

// Namespace cp_mi_sing_sgen_enter_silo
// Params 0, eflags: 0x1 linked
// Checksum 0xcb8b5fca, Offset: 0x6f60
// Size: 0x184
function function_fe2615a5() {
    level flag::set("hendricks_at_silo_floor");
    trig_player_at_silo_floor = getent("trig_player_at_silo_floor", "targetname");
    trig_player_at_silo_floor triggerenable(1);
    level flag::wait_till("player_at_silo_floor");
    nd_hendricks_silo_front = getnode("nd_hendricks_silo_front", "targetname");
    self ai::force_goal(nd_hendricks_silo_front, 32);
    level flag::wait_till("start_silo_ambush");
    self ai::set_ignoreme(0);
    self ai::set_ignoreall(0);
    objectives::set("cp_level_sgen_silo_kill");
    nd_hendricks_silo_fallback = getnode("nd_hendricks_silo_fallback", "targetname");
    self ai::force_goal(nd_hendricks_silo_fallback, 32);
}

// Namespace cp_mi_sing_sgen_enter_silo
// Params 0, eflags: 0x1 linked
// Checksum 0xe1179db7, Offset: 0x70f0
// Size: 0x32c
function function_ee660c8a() {
    array::thread_all(getspawnerarray("silo_robot_rusher", "script_noteworthy"), &spawner::add_spawn_function, &function_e45f3fb4);
    array::thread_all(getspawnerarray("middle_room_robots", "targetname"), &spawner::add_spawn_function, &function_13ad6b1f);
    array::thread_all(getspawnerarray("silo_ambush_robots", "targetname"), &spawner::add_spawn_function, &function_13ad6b1f);
    savegame::checkpoint_save();
    level flag::wait_till("start_silo_ambush");
    level.var_ea764859 mapping_drone::function_74191a2(1);
    level thread function_b8692659();
    if (level.players.size > 1) {
        n_delay = 20;
    } else {
        n_delay = 30;
    }
    level thread flag::delay_set(n_delay, "spawn_silo_robots");
    level flag::wait_till("spawn_silo_robots");
    level util::delay(2, undefined, &function_847fb8ed, "break_higher_balcony_right");
    level util::delay(4.5, undefined, &function_847fb8ed, "break_higher_balcony_left");
    spawner::simple_spawn("silo_ambush_robots");
    spawner::waittill_ai_group_cleared("silo_floor_robots");
    level thread namespace_d40478f6::function_973b77f9();
    level battlechatter::function_d9f49fba(0);
    level.var_ea764859 mapping_drone::function_74191a2(0);
    level flag::set("silo_floor_cleared");
    level.var_2fd26037 dialog::say("hend_all_clear_who_the_h_0", 1);
    level dialog::remote("kane_i_don_t_know_i_m_0", 0.5);
    objectives::complete("cp_level_sgen_silo_kill");
}

// Namespace cp_mi_sing_sgen_enter_silo
// Params 0, eflags: 0x1 linked
// Checksum 0x2184882e, Offset: 0x7428
// Size: 0x94
function function_b8692659() {
    wait 5;
    spawner::simple_spawn("middle_room_robots");
    if (level.players.size > 1) {
        var_2cba70ff = 4;
    } else {
        var_2cba70ff = 6;
    }
    spawner::waittill_ai_group_amount_killed("silo_floor_robots", var_2cba70ff);
    level flag::set("spawn_silo_robots");
}

// Namespace cp_mi_sing_sgen_enter_silo
// Params 0, eflags: 0x1 linked
// Checksum 0xc87ebfeb, Offset: 0x74c8
// Size: 0x15c
function function_5a74dfe6() {
    level thread function_cc37bee6("front_robot_riser_01", 1);
    level thread function_cc37bee6("front_robot_riser_02", 3.5);
    level thread function_cc37bee6("front_robot_riser_03", 2.5);
    level thread function_cc37bee6("middle_room_riser_01", 1);
    level thread function_cc37bee6("middle_room_riser_02", 3);
    level thread function_cc37bee6("middle_room_riser_03", 1.5);
    level thread function_cc37bee6("middle_room_riser_04", 4);
    level flag::wait_till("start_floor_risers");
    wait 2;
    level thread function_847fb8ed("break_lower_balcony");
    level flag::set("start_silo_ambush");
}

// Namespace cp_mi_sing_sgen_enter_silo
// Params 1, eflags: 0x1 linked
// Checksum 0x84595d8, Offset: 0x7630
// Size: 0x16c
function function_847fb8ed(var_5b3b7ceb) {
    var_80fc8ac2 = struct::get(var_5b3b7ceb);
    var_895e60d2 = struct::get_array(var_80fc8ac2.target);
    for (i = 0; i < 5; i++) {
        var_895e60d2 = array::randomize(var_895e60d2);
        foreach (s_window in var_895e60d2) {
            magicbullet(level.var_2fd26037.weapon, var_80fc8ac2.origin, s_window.origin);
            wait randomfloatrange(0.05, 0.2);
        }
    }
}

// Namespace cp_mi_sing_sgen_enter_silo
// Params 2, eflags: 0x1 linked
// Checksum 0x86a05701, Offset: 0x77a8
// Size: 0x2b4
function function_cc37bee6(var_30545f10, n_delay) {
    var_a269823c = spawner::simple_spawn_single("robot_riser_spawner");
    var_a269823c endon(#"death");
    var_a269823c oed::disable_thermal();
    var_a269823c clientfield::set("disable_tmode", 1);
    var_a269823c disableaimassist();
    var_a269823c function_73a47766(0);
    var_a269823c ai::set_behavior_attribute("robot_lights", 2);
    s_align = struct::get(var_30545f10);
    s_align thread scene::init(var_a269823c);
    level flag::wait_till("start_floor_risers");
    if (isdefined(n_delay)) {
        wait n_delay;
    }
    var_a269823c ai::set_behavior_attribute("rogue_control", "forced_level_1");
    var_a269823c ai::set_behavior_attribute("robot_lights", 0);
    s_align thread scene::play(var_a269823c);
    var_a269823c oed::enable_thermal();
    var_a269823c clientfield::set("disable_tmode", 0);
    var_a269823c enableaimassist();
    var_a269823c function_73a47766(1);
    if (isdefined(s_align.target)) {
        var_9de10fe3 = getnode(s_align.target, "targetname");
        var_a269823c setgoal(var_9de10fe3, 1);
        return;
    }
    var_5a6f1df6 = getent("silo_floor_volume", "targetname");
    var_a269823c setgoal(var_5a6f1df6);
}

// Namespace cp_mi_sing_sgen_enter_silo
// Params 0, eflags: 0x1 linked
// Checksum 0x607e9952, Offset: 0x7a68
// Size: 0xdc
function function_13ad6b1f() {
    self endon(#"death");
    self ai::set_behavior_attribute("rogue_control", "forced_level_1");
    if (isdefined(self.target)) {
        var_9de10fe3 = getnode(self.target, "targetname");
        self ai::force_goal(var_9de10fe3, 32);
        return;
    }
    var_5a6f1df6 = getent("silo_floor_volume", "targetname");
    self setgoal(var_5a6f1df6, 1);
}

// Namespace cp_mi_sing_sgen_enter_silo
// Params 0, eflags: 0x1 linked
// Checksum 0xf0c71cdd, Offset: 0x7b50
// Size: 0xac
function function_e45f3fb4() {
    self endon(#"death");
    self ai::set_behavior_attribute("rogue_control", "forced_level_1");
    if (level.players.size == 1) {
        wait randomfloatrange(0.5, 2.5);
    }
    self ai::set_behavior_attribute("move_mode", "rusher");
    self ai::set_behavior_attribute("sprint", 1);
}

// Namespace cp_mi_sing_sgen_enter_silo
// Params 4, eflags: 0x1 linked
// Checksum 0xa430cd31, Offset: 0x7c08
// Size: 0xc4
function function_e3f81a25(str_objective, var_74cd64bc, var_e4cd2b8b, player) {
    struct::function_368120a1("scene", "cin_sgen_08_01_followleader_2_vign_pathfinding_aie_jumpdown_hendricks");
    struct::function_368120a1("scene", "cin_sgen_08_01_followleader2_vign_wallrun");
    struct::function_368120a1("scene", "cin_sgen_09_01_chemlab_vign_windowknock_robots_start");
    struct::function_368120a1("scene", "cin_sgen_10_01_followleader3_vign_slide");
    struct::function_368120a1("scene", "p7_fxanim_cp_sgen_hendricks_railing_kick_bundle");
}

// Namespace cp_mi_sing_sgen_enter_silo
// Params 1, eflags: 0x1 linked
// Checksum 0xae026f32, Offset: 0x7cd8
// Size: 0x194
function function_73a47766(b_state) {
    if (b_state) {
        self cybercom::function_a1f70a02("cybercom_servoshortout");
        self cybercom::function_a1f70a02("cybercom_systemoverload");
        self cybercom::function_a1f70a02("cybercom_immolation");
        self cybercom::function_a1f70a02("cybercom_fireflyswarm");
        self cybercom::function_a1f70a02("cybercom_iffoverride");
        self cybercom::function_a1f70a02("cybercom_surge");
        return;
    }
    self cybercom::function_59965309("cybercom_servoshortout");
    self cybercom::function_59965309("cybercom_systemoverload");
    self cybercom::function_59965309("cybercom_immolation");
    self cybercom::function_59965309("cybercom_fireflyswarm");
    self cybercom::function_59965309("cybercom_iffoverride");
    self cybercom::function_59965309("cybercom_surge");
}

// Namespace cp_mi_sing_sgen_enter_silo
// Params 2, eflags: 0x1 linked
// Checksum 0x5639c810, Offset: 0x7e78
// Size: 0x3d4
function function_77964ef1(str_objective, var_74cd64bc) {
    if (var_74cd64bc) {
        sgen::function_bff1a867(str_objective);
        mapping_drone::function_10dad989("nd_silo_grate");
        level.var_ea764859 thread function_e6e2c015();
        level scene::skipto_end("p7_fxanim_cp_sgen_bridge_silo_edge_break_bundle");
        scene::add_scene_func("cin_sgen_11_02_silofloor_vign_notice_hendricks", &function_2e68b5db, "init");
        level scene::init("cin_sgen_11_02_silofloor_vign_notice_hendricks");
        objectives::complete("cp_level_sgen_enter_sgen_no_pointer");
        objectives::complete("cp_level_sgen_investigate_sgen");
        objectives::complete("cp_level_sgen_locate_emf");
        objectives::set("cp_level_sgen_descend_into_core");
        level flag::set("silo_floor_cleared");
        level flag::set("drone_over_grate");
        level flag::set("start_silo_ambush");
        level flag::wait_till("all_players_spawned");
        level thread namespace_d40478f6::function_71f06599();
        foreach (player in level.activeplayers) {
            player clientfield::set_to_player("sndSiloBG", 1);
        }
        load::function_a2995f22();
    }
    level clientfield::set("w_underwater_state", 1);
    level clientfield::set("fallen_soldiers_client_fxanims", 1);
    level.var_2fd26037 function_28906173();
    level flag::wait_till("enter_corvus");
    foreach (player in level.activeplayers) {
        player clientfield::set_to_player("sndSiloBG", 0);
        player clientfield::set_to_player("dust_motes", 0);
    }
    objectives::complete("cp_level_sgen_descend_into_core");
    skipto::function_be8adfb8(str_objective);
    level thread corpse_cleanup();
}

// Namespace cp_mi_sing_sgen_enter_silo
// Params 0, eflags: 0x1 linked
// Checksum 0xfa713318, Offset: 0x8258
// Size: 0x1c
function function_1ebdd30c() {
    objectives::breadcrumb("under_silo_breadcrumb");
}

// Namespace cp_mi_sing_sgen_enter_silo
// Params 4, eflags: 0x1 linked
// Checksum 0x8de191a9, Offset: 0x8280
// Size: 0x14c
function function_2edb6f5b(str_objective, var_74cd64bc, var_e4cd2b8b, player) {
    level flag::set("silo_grate_open");
    struct::function_368120a1("p7_fxanim_cp_sgen_lab_ceiling_light_01_bundle");
    struct::function_368120a1("p7_fxanim_cp_sgen_lab_ceiling_light_02_bundle");
    struct::function_368120a1("p7_fxanim_cp_sgen_monkey_jar_bundle");
    struct::function_368120a1("p7_fxanim_cp_sgen_bridge_silo_edge_break_bundle");
    struct::function_368120a1("cin_sgen_11_02_silofloor_vign_notice_hendricks");
    struct::function_368120a1("cin_sgen_11_02_silofloor_vign_notice_drone");
    struct::function_368120a1("cin_sgen_11_02_silofloor_traverse_vign_hendricks_firstjump");
    struct::function_368120a1("cin_sgen_11_02_silofloor_traverse_vign_hendricks_secondjump");
    struct::function_368120a1("cin_sgen_11_02_silofloor_traverse_vign_hendricks_thirdjump");
    struct::function_368120a1("cin_sgen_11_02_silofloor_traverse_vign_hendricks_fourthjump");
    struct::function_368120a1("cin_sgen_11_02_silofloor_traverse_vign_hendricks_fifthjump");
}

// Namespace cp_mi_sing_sgen_enter_silo
// Params 0, eflags: 0x1 linked
// Checksum 0x3fea6c2b, Offset: 0x83d8
// Size: 0xba
function corpse_cleanup() {
    var_b6b9582d = getcorpsearray();
    foreach (corpse in var_b6b9582d) {
        if (isdefined(corpse)) {
            corpse delete();
            wait 0.05;
        }
    }
}

// Namespace cp_mi_sing_sgen_enter_silo
// Params 1, eflags: 0x1 linked
// Checksum 0x15dd925d, Offset: 0x84a0
// Size: 0x13c
function function_2e68b5db(a_scene_ents) {
    level flag::wait_till("drone_over_grate");
    a_scene_ents["silo_floor_grate"] clientfield::set("structural_weakness", 1);
    level flag::wait_till("start_silo_ambush");
    a_scene_ents["silo_floor_grate"] clientfield::set("structural_weakness", 0);
    level flag::wait_till("drone_over_grate_real");
    a_scene_ents["silo_floor_grate"] clientfield::set("structural_weakness", 1);
    level flag::wait_till("silo_grate_open");
    a_scene_ents["silo_floor_grate"] clientfield::set("structural_weakness", 0);
}

// Namespace cp_mi_sing_sgen_enter_silo
// Params 0, eflags: 0x1 linked
// Checksum 0x13aebfec, Offset: 0x85e8
// Size: 0x2d4
function function_28906173() {
    self ai::set_behavior_attribute("cqb", 1);
    self ai::set_behavior_attribute("sprint", 0);
    level flag::wait_till("silo_floor_regroup");
    level thread function_c15000a5();
    level flag::wait_till("drone_over_grate_real");
    if (isdefined(level.var_e6d6fe31)) {
        level thread [[ level.var_e6d6fe31 ]]();
    }
    scene::play("cin_sgen_11_02_silofloor_vign_notice_hendricks");
    level thread function_953a1437();
    level thread function_1ebdd30c();
    level thread util::clientnotify("sound_kill_thunder");
    level scene::play("cin_sgen_11_02_silofloor_traverse_vign_hendricks_firstjump");
    level.var_2fd26037 waittill(#"hash_568ee845");
    wait 1;
    level flag::wait_till("hendricks_under_silo_second_jump");
    level thread scene::play("cin_sgen_11_02_silofloor_traverse_vign_hendricks_secondjump");
    level.var_2fd26037 waittill(#"hash_568ee845");
    level flag::wait_till("hendricks_under_silo_third_jump");
    level thread scene::play("cin_sgen_11_02_silofloor_traverse_vign_hendricks_thirdjump");
    level.var_2fd26037 waittill(#"hash_568ee845");
    level flag::wait_till("hendricks_under_silo_fourth_jump");
    level thread scene::play("cin_sgen_11_02_silofloor_traverse_vign_hendricks_fourthjump");
    level.var_2fd26037 waittill(#"hash_568ee845");
    level flag::wait_till("hendricks_under_silo_fifth_jump");
    level scene::play("cin_sgen_11_02_silofloor_traverse_vign_hendricks_fifthjump");
    nd_post_jump_downs = getnode("nd_post_jump_downs", "targetname");
    self setgoal(nd_post_jump_downs, 1);
}

// Namespace cp_mi_sing_sgen_enter_silo
// Params 0, eflags: 0x1 linked
// Checksum 0x733cb123, Offset: 0x88c8
// Size: 0x16c
function function_953a1437() {
    level dialog::remote("kane_limited_light_ahead_0", 1);
    level.var_2fd26037 dialog::say("hend_copy_that_kane_0", 0.8);
    level flag::wait_till("hendricks_under_silo_second_jump");
    level.var_2fd26037 dialog::say("hend_hustle_recon_drone_0");
    level flag::wait_till("drone_died");
    level.var_2fd26037 dialog::say("hend_kane_we_lost_the_f_0");
    level dialog::remote("kane_negative_beat_blu_0", 1);
    level.var_2fd26037 dialog::say("hend_fucking_tech_0", 0.5);
    level dialog::remote("kane_keep_moving_gps_co_0", 1);
    objectives::complete("cp_level_sgen_descend_into_core");
    objectives::set("cp_level_sgen_find_recon_drone", level.var_ea764859);
}

// Namespace cp_mi_sing_sgen_enter_silo
// Params 0, eflags: 0x1 linked
// Checksum 0x28ce592c, Offset: 0x8a40
// Size: 0xc4
function function_f142d622() {
    self thread function_80ea03f0();
    level flag::wait_till("post_discover_data");
    if (level scene::is_active("cin_sgen_06_01_followleader_vign_activate_eac_drone")) {
        level scene::stop("cin_sgen_06_01_followleader_vign_activate_eac_drone");
    }
    self mapping_drone::follow_path("nd_post_discover_data", "post_discover_data");
    level flag::wait_till("player_past_shimmy_wall");
}

// Namespace cp_mi_sing_sgen_enter_silo
// Params 0, eflags: 0x1 linked
// Checksum 0x21d4d078, Offset: 0x8b10
// Size: 0x84
function function_80ea03f0() {
    level flag::wait_till("player_past_shimmy_wall");
    self notify(#"hash_c4902f95");
    if (level flag::get("drone_scanning")) {
        level flag::clear("drone_scanning");
    }
    self mapping_drone::function_6a8adcf6(35);
}

// Namespace cp_mi_sing_sgen_enter_silo
// Params 0, eflags: 0x1 linked
// Checksum 0x3c2be89f, Offset: 0x8ba0
// Size: 0x6c
function function_51e1520f() {
    wait 3.4;
    level.var_2fd26037 dialog::say("hend_shit_damn_54i_are_0");
    level dialog::function_13b3b16a("plyr_i_think_it_s_time_we_0");
    level flag::set("pre_gen_lab_vo_done");
}

// Namespace cp_mi_sing_sgen_enter_silo
// Params 0, eflags: 0x1 linked
// Checksum 0xd6e182c1, Offset: 0x8c18
// Size: 0x434
function function_a6381cd() {
    level scene::init("cin_sgen_07_01_genlab_vign_patrol");
    self mapping_drone::function_6a8adcf6(25);
    self mapping_drone::follow_path("nd_start_gen_lab");
    self mapping_drone::function_74191a2(1);
    scene::add_scene_func("cin_sgen_07_01_genlab_vign_patrol", &function_426de534, "play");
    spawner::simple_spawn_single("gen_lab_warlord", &function_aafbf321);
    spawner::simple_spawn_single("gen_lab_warlord2", &function_aafbf321);
    spawner::simple_spawn_single("gen_lab_enemy_1", &function_1cc12213);
    spawner::simple_spawn_single("gen_lab_enemy_2", &function_1cc12213);
    spawner::simple_spawn_single("gen_lab_enemy_3", &function_1cc12213);
    spawner::simple_spawn_single("gen_lab_enemy_4", &function_1cc12213);
    spawner::simple_spawn_single("gen_lab_enemy_5", &function_1cc12213);
    if (isdefined(level.var_9de79ddb)) {
        level thread [[ level.var_9de79ddb ]]();
    }
    level thread scene::play("cin_sgen_07_01_genlab_vign_patrol");
    level thread function_51e1520f();
    level lui::play_movie("cp_sgen_pip_mappingdrone01", "pip");
    level notify(#"hash_12cb211a");
    self mapping_drone::function_6a8adcf6(5);
    self mapping_drone::follow_path("gen_lab_wait_goal");
    level flag::wait_till("gen_lab_cleared");
    self mapping_drone::function_74191a2(0);
    self mapping_drone::function_6a8adcf6(10);
    self thread mapping_drone::follow_path("nd_follow_gen_lab_mid");
    self waittill(#"hash_f6e9e60f");
    self mapping_drone::function_6a8adcf6(5);
    level flag::wait_till("hendricks_at_gen_lab_door");
    trig_gen_lab_door_player_check = getent("trig_gen_lab_door_player_check", "targetname");
    trig_gen_lab_door_player_check triggerenable(1);
    level flag::wait_till("player_at_gen_lab_door");
    var_6d927f8e = getent("gen_lab_end_door", "targetname");
    var_6d927f8e movez(100, 2, 1);
    var_6d927f8e playsound("evt_genlab_door_open");
    var_6d927f8e waittill(#"movedone");
    level flag::set("gen_lab_door_opened");
}

// Namespace cp_mi_sing_sgen_enter_silo
// Params 0, eflags: 0x1 linked
// Checksum 0xb911f2e7, Offset: 0x9058
// Size: 0xac
function function_2c83d390() {
    self mapping_drone::function_6a8adcf6(15);
    self mapping_drone::follow_path("nd_post_gen_lab_start");
    self thread mapping_drone::follow_path("nd_drone_bridge_path", "hendricks_follow2_wallrun_trick");
    self waittill(#"hash_f6e9e60f");
    self mapping_drone::function_6a8adcf6(5);
    level flag::wait_till("follow_chem_lab");
}

// Namespace cp_mi_sing_sgen_enter_silo
// Params 0, eflags: 0x1 linked
// Checksum 0xc47a93d3, Offset: 0x9110
// Size: 0x9c
function function_1acc965e() {
    self mapping_drone::function_2dde6e87();
    self mapping_drone::function_6a8adcf6(5);
    self mapping_drone::follow_path("nd_follow_chem_lab", "chem_lab_start");
    self mapping_drone::follow_path("nd_post_chem_lab", "chem_door_open");
    self thread function_3054092d();
}

// Namespace cp_mi_sing_sgen_enter_silo
// Params 0, eflags: 0x1 linked
// Checksum 0xfbee0db8, Offset: 0x91b8
// Size: 0x5c
function function_3054092d() {
    self mapping_drone::function_6a8adcf6(10);
    self mapping_drone::follow_path("nd_pre_ambush", "follow3_1");
    self thread function_fdbec74b();
}

// Namespace cp_mi_sing_sgen_enter_silo
// Params 0, eflags: 0x1 linked
// Checksum 0x69d7d302, Offset: 0x9220
// Size: 0xbc
function function_fdbec74b() {
    self mapping_drone::function_6a8adcf6(15);
    self mapping_drone::follow_path("nd_highlight_grate", "send_drone_over_grate");
    level flag::set("drone_over_grate");
    self mapping_drone::function_6a8adcf6(15);
    self mapping_drone::follow_path("nd_ambush_react", "start_floor_risers");
    self thread function_e6e2c015();
}

// Namespace cp_mi_sing_sgen_enter_silo
// Params 0, eflags: 0x1 linked
// Checksum 0xcc7a2dde, Offset: 0x92e8
// Size: 0x134
function function_e6e2c015() {
    self mapping_drone::function_6a8adcf6(15);
    self mapping_drone::follow_path("nd_silo_grate", "silo_floor_cleared");
    level thread scene::init("cin_sgen_11_02_silofloor_vign_notice_drone");
    level flag::set("drone_over_grate_real");
    level flag::wait_till("silo_grate_open");
    level thread namespace_d40478f6::function_71f06599();
    level scene::play("cin_sgen_11_02_silofloor_vign_notice_drone");
    self.drivepath = 0;
    self mapping_drone::function_6a8adcf6(25);
    self mapping_drone::follow_path("nd_silo_floor_platform_1", "hendricks_under_silo_second_jump", &function_fa0e227a);
}

// Namespace cp_mi_sing_sgen_enter_silo
// Params 0, eflags: 0x1 linked
// Checksum 0xa33ec3c2, Offset: 0x9428
// Size: 0xd4
function function_fa0e227a() {
    level lui::prime_movie("cp_sgen_pip_mappingdrone02");
    self waittill(#"hash_5e3e50f0");
    level lui::play_movie("cp_sgen_pip_mappingdrone02", "pip");
    level flag::set("drone_died");
    playfxontag(level._effect["drone_sparks"], self, "tag_origin");
    self vehicle::lights_off();
    self vehicle::toggle_sounds(0);
}

