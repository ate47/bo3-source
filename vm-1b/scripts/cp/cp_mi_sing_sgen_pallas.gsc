#using scripts/cp/cp_mi_sing_sgen_revenge_igc;
#using scripts/cp/cp_mi_sing_sgen_dark_battle;
#using scripts/cp/cp_mi_sing_sgen_sound;
#using scripts/cp/cp_mi_sing_sgen;
#using scripts/cp/cybercom/_cybercom_util;
#using scripts/cp/_oed;
#using scripts/cp/_util;
#using scripts/cp/_spawn_manager;
#using scripts/cp/_skipto;
#using scripts/cp/_objectives;
#using scripts/cp/_load;
#using scripts/cp/_dialog;
#using scripts/cp/gametypes/_save;
#using scripts/shared/damagefeedback_shared;
#using scripts/shared/vehicle_shared;
#using scripts/shared/vehicle_ai_shared;
#using scripts/shared/trigger_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/math_shared;
#using scripts/shared/laststand_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/colors_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/array_shared;
#using scripts/shared/ai_shared;
#using scripts/shared/ai/systems/ai_interface;
#using scripts/cp/gametypes/_globallogic_ui;
#using scripts/cp/cp_mi_sing_sgen_util;
#using scripts/shared/util_shared;
#using scripts/codescripts/struct;

#namespace namespace_646f304f;

// Namespace namespace_646f304f
// Params 2, eflags: 0x0
// Checksum 0x65b592aa, Offset: 0x17c8
// Size: 0x12a
function function_1a420bcd(str_objective, var_74cd64bc) {
    if (var_74cd64bc) {
        objectives::complete("cp_level_sgen_enter_sgen_no_pointer");
        objectives::complete("cp_level_sgen_investigate_sgen");
        objectives::complete("cp_level_sgen_locate_emf");
        objectives::complete("cp_level_sgen_descend_into_core");
        objectives::complete("cp_level_sgen_goto_signal_source");
        objectives::complete("cp_level_sgen_goto_server_room");
        function_4ef8cf79();
        level flag::set("weapons_research_vo_done");
        load::function_a2995f22();
    }
    level thread function_3a855484();
    level thread function_dda88b2e();
    level function_b8e4148d();
    objectives::set("cp_level_sgen_confront_pallas", level.var_7f246cd7);
}

// Namespace namespace_646f304f
// Params 4, eflags: 0x0
// Checksum 0x6b7ec5db, Offset: 0x1900
// Size: 0x3a
function function_d15424d7(str_objective, var_74cd64bc, var_e4cd2b8b, player) {
    struct::function_368120a1("cin_sgen_14_humanlab_3rd_sh005");
}

// Namespace namespace_646f304f
// Params 2, eflags: 0x0
// Checksum 0x5c6fdda2, Offset: 0x1948
// Size: 0x463
function function_1f2baf43(str_objective, var_74cd64bc) {
    objectives::complete("cp_level_sgen_goto_server_room");
    spawner::add_spawn_function_group("pallas_bot", "script_noteworthy", &function_a44a2f8d);
    spawner::add_spawn_function_group("pallas_core_guard", "script_noteworthy", &function_c92b9eaf);
    spawner::add_spawn_function_group("pallas_center_guard", "script_noteworthy", &function_a198a1);
    level flag::set("pallas_start");
    level.var_e16e585d = 0;
    level.var_e259308b = 0;
    level.var_9945a95d = 0;
    level.var_844375bd = struct::get_array("pallas_robot_dropdown");
    level thread function_7362d6c4();
    if (var_74cd64bc) {
        objectives::complete("cp_level_sgen_enter_sgen_no_pointer");
        objectives::complete("cp_level_sgen_investigate_sgen");
        objectives::complete("cp_level_sgen_locate_emf");
        objectives::complete("cp_level_sgen_descend_into_core");
        objectives::complete("cp_level_sgen_goto_signal_source");
        objectives::complete("cp_level_sgen_goto_server_room");
        objectives::set("cp_level_sgen_confront_pallas");
        function_4ef8cf79();
        function_6e72c0ab("back", "open");
        var_be31aa9a = getent("boss_fight_lift", "targetname");
        var_be31aa9a movez(-1750, 0.1);
        load::function_a2995f22();
        level thread function_3a855484();
        array::thread_all(level.players, &clientfield::set_to_player, "pallas_monitors_state", 2);
    }
    level thread function_8470b8c(var_74cd64bc);
    level thread function_4ee50667(var_74cd64bc);
    foreach (e_player in level.players) {
        e_player util::function_df6eb506(1);
    }
    level.var_2fd26037 = util::function_740f8516("hendricks");
    level.var_2fd26037 colors::set_force_color("r");
    level thread function_ab0e4cbe();
    level thread function_1497c676();
    level thread namespace_cba4cc55::function_8b31a9a3();
    level thread function_c88aca45();
    level thread function_ecf57b76();
    level flag::wait_till("core_two_destroyed");
    level thread function_4301ab5f();
    level flag::wait_till("pallas_death");
    level notify(#"hash_f42cafec");
    var_915bcd4e = getaiteamarray("team3");
    foreach (bot in var_915bcd4e) {
        bot delete();
    }
}

// Namespace namespace_646f304f
// Params 4, eflags: 0x0
// Checksum 0x320b7eeb, Offset: 0x1db8
// Size: 0x22
function function_5a8d1289(str_objective, var_74cd64bc, var_e4cd2b8b, player) {
    
}

// Namespace namespace_646f304f
// Params 2, eflags: 0x0
// Checksum 0x5b6ee163, Offset: 0x1de8
// Size: 0x3b0
function function_bf36708e(str_objective, var_74cd64bc) {
    var_be31aa9a = getent("boss_fight_lift", "targetname");
    level thread function_3452571c();
    if (var_74cd64bc) {
        namespace_fa13d4ba::function_bff1a867(str_objective);
        var_587da295 = getent("pallas", "targetname");
        var_587da295 spawner::add_spawn_function(&function_ff91efc5);
        spawner::simple_spawn(var_587da295);
        objectives::complete("cp_level_sgen_enter_sgen_no_pointer");
        objectives::complete("cp_level_sgen_investigate_sgen");
        objectives::complete("cp_level_sgen_locate_emf");
        objectives::complete("cp_level_sgen_descend_into_core");
        objectives::complete("cp_level_sgen_goto_signal_source");
        objectives::complete("cp_level_sgen_goto_server_room");
        objectives::complete("cp_level_sgen_confront_pallas");
        function_4ef8cf79();
        function_6e72c0ab("back", "open");
        var_be31aa9a movez(-1750, 0.05);
        level thread scene::init("cin_sgen_19_ghost_3rd_sh010");
        load::function_a2995f22();
    } else {
        util::screen_fade_out(0.25);
        level util::function_7d553ac6();
    }
    array::thread_all(level.players, &clientfield::set_to_player, "pallas_monitors_state", 3);
    if (isdefined(level.var_3e0291d0)) {
        [[ level.var_3e0291d0 ]]();
    }
    level thread function_d6b86f3d();
    level scene::add_scene_func("cin_sgen_19_ghost_3rd_sh010", &function_48b24f3d, "play");
    level scene::add_scene_func("cin_sgen_19_ghost_3rd_sh040", &function_ac1384da, "play");
    level scene::add_scene_func("cin_sgen_19_ghost_3rd_sh110", &function_c524f1b2, "play");
    level scene::add_scene_func("cin_sgen_19_ghost_3rd_sh050", &function_7d1791ba, "done");
    level scene::add_scene_func("cin_sgen_19_ghost_3rd_sh190", &function_90b577e6, "done");
    level thread scene::play("p7_fxanim_cp_sgen_pallas_ai_tower_collapse_bundle");
    level thread function_38ce56e0();
    level clientfield::set("set_exposure_bank", 1);
    level scene::play("cin_sgen_19_ghost_3rd_sh010");
    if (isdefined(level.var_3b075261)) {
        level thread [[ level.var_3b075261 ]]();
    }
}

// Namespace namespace_646f304f
// Params 1, eflags: 0x0
// Checksum 0xc080b849, Offset: 0x21a0
// Size: 0x3a
function function_509b3c70(a_ents) {
    level waittill(#"hash_74753696");
    level util::screen_fade_out(0.45, "black", "twin_cover");
}

// Namespace namespace_646f304f
// Params 1, eflags: 0x0
// Checksum 0xd5f63c17, Offset: 0x21e8
// Size: 0x22
function function_6610aebe(a_ents) {
    a_ents["pallas_ai_tower"] ghost();
}

// Namespace namespace_646f304f
// Params 1, eflags: 0x0
// Checksum 0x963a26fb, Offset: 0x2218
// Size: 0x22
function function_c5372adb(a_ents) {
    a_ents["pallas_ai_tower"] show();
}

// Namespace namespace_646f304f
// Params 1, eflags: 0x0
// Checksum 0x98dcc4e9, Offset: 0x2248
// Size: 0x3a
function function_48b24f3d(a_ents) {
    util::screen_fade_in(0);
    if (isdefined(level.var_7f246cd7)) {
        level.var_7f246cd7 ghost();
    }
}

// Namespace namespace_646f304f
// Params 1, eflags: 0x0
// Checksum 0xcba69755, Offset: 0x2290
// Size: 0x2a
function function_ac1384da(a_ents) {
    if (isdefined(level.var_7f246cd7)) {
        level.var_7f246cd7 show();
    }
}

// Namespace namespace_646f304f
// Params 1, eflags: 0x0
// Checksum 0x91ec9408, Offset: 0x22c8
// Size: 0x42
function function_7d1791ba(a_ents) {
    level.var_7f246cd7 setgoal(level.var_7f246cd7.origin, 1);
    level.var_7f246cd7.goalradius = 8;
}

// Namespace namespace_646f304f
// Params 1, eflags: 0x0
// Checksum 0x1bb9f0dc, Offset: 0x2318
// Size: 0x73
function function_c524f1b2(a_ents) {
    foreach (var_9544d7c1 in a_ents) {
        if (var_9544d7c1 == level.var_2fd26037) {
            var_9544d7c1 cybercom::function_f8669cbf(1);
        }
    }
}

// Namespace namespace_646f304f
// Params 0, eflags: 0x0
// Checksum 0xb3c17067, Offset: 0x2398
// Size: 0x9a
function function_38ce56e0() {
    wait(0.05);
    var_b05603a8 = getentarray("pallas_core_destruct", "targetname");
    array::run_all(var_b05603a8, &delete);
    var_8c77ffe9 = getentarray("pallas_rail_destruct", "targetname");
    array::run_all(var_8c77ffe9, &delete);
}

// Namespace namespace_646f304f
// Params 4, eflags: 0x0
// Checksum 0x109b7a3, Offset: 0x2440
// Size: 0xa3
function function_e3c54b48(str_objective, var_74cd64bc, var_e4cd2b8b, player) {
    objectives::complete("cp_level_sgen_confront_pallas");
    if (!var_74cd64bc) {
        foreach (e_player in level.players) {
            e_player util::function_df6eb506(0);
        }
    }
}

// Namespace namespace_646f304f
// Params 1, eflags: 0x0
// Checksum 0x662c934e, Offset: 0x24f0
// Size: 0x32
function function_90b577e6(a_ents) {
    util::clear_streamer_hint();
    skipto::function_be8adfb8("pallas_end");
}

// Namespace namespace_646f304f
// Params 0, eflags: 0x0
// Checksum 0xbe7355f2, Offset: 0x2530
// Size: 0x11a
function function_b8e4148d() {
    level waittill(#"hash_f913de07");
    if (isdefined(level.var_52bd434a)) {
        level thread [[ level.var_52bd434a ]]();
    }
    level dialog::remote("diaz_listen_do_you_hea_0");
    level dialog::remote("diaz_there_is_blood_on_ou_0", 0.5);
    level dialog::remote("diaz_you_know_who_i_am_i_0", 1);
    level dialog::function_13b3b16a("plyr_kane_i_ve_got_diaz_0", 0.3);
    level dialog::remote("diaz_taylor_is_right_0", 0.5);
    level dialog::remote("kane_oh_my_god_he_s_wi_0", 0.4);
    level dialog::remote("kane_he_s_directly_contro_0");
    level dialog::remote("kane_listen_to_me_we_0", 1);
    level dialog::remote("kane_right_now_he_s_uploa_0", 1);
}

// Namespace namespace_646f304f
// Params 0, eflags: 0x0
// Checksum 0xf6608167, Offset: 0x2658
// Size: 0xba
function function_5ac1b440() {
    var_8df90b18 = getentarray("pallas_elevator_probe", "targetname");
    var_99450f8a = getentarray("pallas_elevator_light", "script_noteworthy");
    var_be31aa9a = getent("boss_fight_lift", "targetname");
    array::run_all(var_99450f8a, &linkto, var_be31aa9a);
    array::run_all(var_8df90b18, &linkto, var_be31aa9a);
}

// Namespace namespace_646f304f
// Params 0, eflags: 0x0
// Checksum 0xb42c3b12, Offset: 0x2720
// Size: 0x1b2
function function_3a855484() {
    scene::add_scene_func("cin_sgen_18_01_pallasfight_vign_crucifix_pallas_loop", &function_517f8c74, "play");
    var_587da295 = getent("pallas", "targetname");
    var_764b080d = getent("pallas2", "targetname");
    var_587da295 spawner::add_spawn_function(&function_ff91efc5);
    var_764b080d spawner::add_spawn_function(&function_ff91efc5, 1);
    level thread scene::play("cin_sgen_18_01_pallasfight_vign_crucifix_pallas_loop");
    videostart("cp_sgen_env_diazserver", 1);
    level waittill(#"hash_2e9dd028");
    videostop("cp_sgen_env_diazserver");
    videostart("cp_sgen_env_diazserver", 1);
    level thread scene::play("cin_sgen_18_01_pallasfight_vign_crucifix_pallas_stage2");
    level waittill(#"hash_2e9dd028");
    videostop("cp_sgen_env_diazserver");
    videostart("cp_sgen_env_diazserver", 1);
    level thread scene::play("cin_sgen_18_01_pallasfight_vign_crucifix_pallas_stage3");
    level waittill(#"hash_eb30fd63");
    videostop("cp_sgen_env_diazserver");
}

// Namespace namespace_646f304f
// Params 1, eflags: 0x0
// Checksum 0xd1efcb23, Offset: 0x28e0
// Size: 0x1a
function function_517f8c74(a_ents) {
    level.var_7f246cd7 = a_ents["pallas_model"];
}

// Namespace namespace_646f304f
// Params 1, eflags: 0x0
// Checksum 0x5a34dbbf, Offset: 0x2908
// Size: 0x86
function function_ff91efc5(var_74bf1e88) {
    if (!isdefined(var_74bf1e88)) {
        var_74bf1e88 = 0;
    }
    self ai::set_ignoreme(1);
    self ai::set_ignoreall(1);
    self disableaimassist();
    self.allowdeath = 0;
    self.nocybercom = 1;
    if (var_74bf1e88) {
        self setforcenocull();
        level.var_e934a4b7 = self;
        return;
    }
    level.var_7f246cd7 = self;
}

// Namespace namespace_646f304f
// Params 0, eflags: 0x0
// Checksum 0xbe5f196, Offset: 0x2998
// Size: 0x8a
function function_1497c676() {
    level namespace_4c73eafb::function_a8cfe9ae();
    level.var_2fd26037.ignoreme = 1;
    var_35925132 = struct::get("hendrick_console_hack", "targetname");
    level thread scene::play("cin_sgen_18_01_pallasfight_vign_controls_hendricks_active", level.var_2fd26037);
    level waittill(#"hash_7d401fb9");
    var_35925132 thread scene::stop("cin_sgen_18_01_pallasfight_vign_controls_hendricks_active");
}

// Namespace namespace_646f304f
// Params 0, eflags: 0x0
// Checksum 0xe9c07cd6, Offset: 0x2a30
// Size: 0x2
function main() {
    
}

// Namespace namespace_646f304f
// Params 1, eflags: 0x0
// Checksum 0xf5da89b0, Offset: 0x2a40
// Size: 0x133
function function_8470b8c(var_74cd64bc) {
    level.var_51a695e5 = [];
    level.var_38f0e071 = [];
    level.var_87d58962 = [];
    var_91f66e00 = getentarray("pallas_intro_spawner", "targetname");
    foreach (var_dc854c29 in var_91f66e00) {
        var_f6c5842 = spawner::simple_spawn_single(var_dc854c29);
        if (isdefined(var_f6c5842)) {
            if (var_74cd64bc) {
                if (isdefined(var_f6c5842.target)) {
                    var_9de10fe3 = getnode(var_f6c5842.target, "targetname");
                    var_f6c5842 forceteleport(var_9de10fe3.origin, var_9de10fe3.angles);
                }
            }
            var_f6c5842 thread function_f0f76126();
            util::wait_network_frame();
        }
    }
}

// Namespace namespace_646f304f
// Params 0, eflags: 0x0
// Checksum 0x1e572b43, Offset: 0x2b80
// Size: 0xa1
function function_ecf57b76() {
    level endon(#"hash_eb30fd63");
    while (!level flag::get("pallas_death")) {
        level.var_51a695e5 = array::remove_dead(level.var_51a695e5);
        level.var_38f0e071 = array::remove_dead(level.var_38f0e071);
        level.var_87d58962 = array::remove_dead(level.var_87d58962);
        wait(5);
    }
    level.var_51a695e5 = undefined;
    level.var_38f0e071 = undefined;
    level.var_87d58962 = undefined;
}

// Namespace namespace_646f304f
// Params 0, eflags: 0x0
// Checksum 0xa808e990, Offset: 0x2c30
// Size: 0x42
function function_a7dc2319() {
    self endon(#"death");
    self ai::set_ignoreall(1);
    level flag::wait_till("pallas_ambush_over");
    self ai::set_ignoreall(0);
}

// Namespace namespace_646f304f
// Params 0, eflags: 0x0
// Checksum 0x78013d70, Offset: 0x2c80
// Size: 0x192
function function_a44a2f8d() {
    self endon(#"death");
    self.accuracy = 0.25;
    self ai::set_behavior_attribute("rogue_control_speed", "sprint");
    switch (level.var_e16e585d) {
    case 0:
        self ai::set_behavior_attribute("rogue_control", "forced_level_1");
        break;
    case 1:
        self ai::set_behavior_attribute("rogue_control", "forced_level_2");
        break;
    case 2:
        self ai::set_behavior_attribute("rogue_control", "forced_level_2");
        self.script_string = "potential_hendricks_bot";
        self thread function_39072821();
        break;
    case 3:
        self thread function_39072821();
        break;
    }
    if (!level flag::get("pallas_ambush_over")) {
        self thread function_a7dc2319();
    } else {
        self function_969fe47();
    }
    level flag::wait_till("pallas_ambush_over");
    var_b97ded2e = getent("pallas_tier_two_volume", "targetname");
    self setgoal(var_b97ded2e);
}

// Namespace namespace_646f304f
// Params 0, eflags: 0x0
// Checksum 0x3a35b39e, Offset: 0x2e20
// Size: 0x182
function function_a198a1() {
    self endon(#"death");
    self.accuracy = 0.25;
    self ai::set_behavior_attribute("rogue_control", "forced_level_1");
    self ai::set_behavior_attribute("can_become_rusher", 0);
    if (!level flag::get("pallas_ambush_over")) {
        self thread function_a7dc2319();
    } else {
        self function_969fe47();
    }
    level flag::wait_till("pallas_ambush_over");
    if (level.var_51a695e5.size < 3) {
        level.var_51a695e5[level.var_51a695e5.size] = self;
        var_b97ded2e = getent("pallas_center_volume", "targetname");
    } else if (level.var_38f0e071.size < 6) {
        level.var_38f0e071[level.var_38f0e071.size] = self;
        var_b97ded2e = getent("pallas_tier_two_volume", "targetname");
    } else {
        level.var_87d58962[level.var_87d58962.size] = self;
        var_b97ded2e = getent("pallas_bottom_tier", "targetname");
    }
    self setgoal(var_b97ded2e, 1);
    self thread function_39072821();
}

// Namespace namespace_646f304f
// Params 0, eflags: 0x0
// Checksum 0x739b3804, Offset: 0x2fb0
// Size: 0x132
function function_c92b9eaf() {
    self endon(#"death");
    self.accuracy = 0.25;
    self ai::set_behavior_attribute("rogue_control", "forced_level_1");
    self ai::set_behavior_attribute("force_cover", 1);
    self ai::set_behavior_attribute("can_become_rusher", 0);
    self function_969fe47();
    level.var_e259308b++;
    nd_guard = getnode("core_guard" + level.var_e259308b, "script_noteworthy");
    var_b97ded2e = getent("pallas_center_volume", "targetname");
    if (!isdefined(nd_guard) || isnodeoccupied(nd_guard)) {
        self setgoal(var_b97ded2e, 1, 16, 16);
    } else {
        self setgoal(nd_guard, 1, 16, 16);
    }
    self thread function_39072821();
}

// Namespace namespace_646f304f
// Params 0, eflags: 0x0
// Checksum 0xab64c662, Offset: 0x30f0
// Size: 0x6a
function function_969fe47() {
    self flag::init("in_playable_space");
    var_85919dec = array::random(level.var_844375bd);
    var_85919dec scene::play("cin_sgen_18_01_pallasfight_aie_jumpdown_robot01", self);
    self flag::set("in_playable_space");
}

// Namespace namespace_646f304f
// Params 0, eflags: 0x0
// Checksum 0x12344c6a, Offset: 0x3168
// Size: 0x8a
function function_39072821() {
    self endon(#"death");
    level flag::wait_till("tower_three_destroyed");
    self ai::set_behavior_attribute("rogue_control", "forced_level_3");
    if (gettime() < level.var_94d58561) {
        self ai::set_behavior_attribute("rogue_control_speed", "run");
        return;
    }
    self ai::set_behavior_attribute("rogue_control_speed", "sprint");
}

// Namespace namespace_646f304f
// Params 0, eflags: 0x0
// Checksum 0x75a980c5, Offset: 0x3200
// Size: 0x162
function function_4ef8cf79() {
    var_be31aa9a = getent("boss_fight_lift", "targetname");
    var_be31aa9a setmovingplatformenabled(1);
    var_be31aa9a.a_e_doors = [];
    var_be31aa9a.a_e_doors["front"] = getent("pallas_lift_front", "targetname");
    var_be31aa9a.a_e_doors["front"].str_state = "close";
    var_be31aa9a.a_e_doors["back"] = getent("pallas_lift_back", "targetname");
    var_be31aa9a.a_e_doors["back"].str_state = "close";
    array::run_all(var_be31aa9a.a_e_doors, &linkto, var_be31aa9a);
    var_be31aa9a.a_e_doors["front"] clientfield::set("sm_elevator_door_state", 1);
    var_be31aa9a.a_e_doors["back"] clientfield::set("sm_elevator_door_state", 2);
}

// Namespace namespace_646f304f
// Params 2, eflags: 0x0
// Checksum 0xa67562d8, Offset: 0x3370
// Size: 0x1c2
function function_6e72c0ab(str_side, str_state) {
    var_be31aa9a = getent("boss_fight_lift", "targetname");
    if (!(var_be31aa9a.a_e_doors[str_side].str_state === str_state)) {
        var_be31aa9a.a_e_doors[str_side].str_state = str_state;
        var_be31aa9a.a_e_doors[str_side] unlink();
        var_c49c82b9 = -106;
        if (str_state === "open") {
            var_c49c82b9 *= -1;
        }
        var_be31aa9a.a_e_doors[str_side] movez(var_c49c82b9, 3.94737, 3.94737 * 0.1, 3.94737 * 0.25);
        if (str_state == "open") {
            var_be31aa9a.a_e_doors[str_side] playsound("veh_lift_doors_open");
        } else {
            var_be31aa9a.a_e_doors[str_side] playsound("veh_lift_doors_close");
        }
        var_be31aa9a.a_e_doors[str_side] waittill(#"movedone");
        var_be31aa9a.a_e_doors[str_side] linkto(var_be31aa9a);
        if (str_state == "open") {
            level flag::set("pallas_lift_" + str_side + "_open");
            return;
        }
        level flag::clear("pallas_lift_" + str_side + "_open");
    }
}

// Namespace namespace_646f304f
// Params 1, eflags: 0x0
// Checksum 0xa2595ef, Offset: 0x3540
// Size: 0x11b
function function_fe851f75(str_state) {
    var_be31aa9a = getent("boss_fight_lift", "targetname");
    if (!(var_be31aa9a.var_631a2015["left"].str_state === str_state)) {
        foreach (var_b018a7fa in var_be31aa9a.var_631a2015) {
            var_42c0d741 = var_b018a7fa.script_vector;
            if (str_state == "close") {
                var_42c0d741 *= -1;
            }
            var_b018a7fa.str_state = str_state;
            var_b018a7fa moveto(var_b018a7fa.origin + var_42c0d741, 3.94737, 3.94737 * 0.1, 3.94737 * 0.25);
        }
    }
}

// Namespace namespace_646f304f
// Params 1, eflags: 0x0
// Checksum 0x7f302e25, Offset: 0x3668
// Size: 0x232
function function_aab7d2d8(str_direction) {
    array::run_all(level.players, &util::function_16c71b8, 1);
    var_be31aa9a = getent("boss_fight_lift", "targetname");
    var_be31aa9a.str_direction = str_direction;
    var_d838974e = getent("decon_fx_origin", "targetname");
    var_d838974e linkto(var_be31aa9a);
    playfxontag(level._effect["decon_mist"], var_d838974e, "tag_origin");
    var_d838974e playsound("veh_lift_mist");
    var_c49c82b9 = 1750;
    if (str_direction == "down") {
        var_c49c82b9 *= -1;
    }
    var_be31aa9a movez(var_c49c82b9, 48.6111, 48.6111 * 0.1, 48.6111 * 0.25);
    var_be31aa9a playsound("veh_lift_start");
    var_be2ea7e9 = spawn("script_origin", var_be31aa9a.origin);
    var_be2ea7e9 linkto(var_be31aa9a);
    var_be2ea7e9 playloopsound("veh_lift_loop", 0.5);
    var_be31aa9a waittill(#"movedone");
    var_be2ea7e9 stoploopsound(0.5);
    var_be31aa9a playsound("veh_lift_stop");
    var_be2ea7e9 delete();
    array::run_all(level.players, &util::function_16c71b8, 0);
}

// Namespace namespace_646f304f
// Params 1, eflags: 0x0
// Checksum 0xd5ba68a2, Offset: 0x38a8
// Size: 0x4a
function function_2a8da7f0(n_state) {
    var_be31aa9a = getent("boss_fight_lift", "targetname");
    var_be31aa9a clientfield::set("sm_elevator_shader", n_state);
}

// Namespace namespace_646f304f
// Params 0, eflags: 0x0
// Checksum 0xb27e18b6, Offset: 0x3900
// Size: 0x36b
function function_dda88b2e() {
    function_6e72c0ab("front", "open");
    level flag::wait_till("weapons_research_vo_done");
    var_a3f7ac49 = getent("pallas_lift_trigger", "targetname");
    var_a3f7ac49 namespace_cba4cc55::function_36a6e271();
    level thread function_5ac1b440();
    array::thread_all(getentarray("head_track_model", "targetname"), &util::delay_notify, 0.05, "stop_head_track_player");
    array::run_all(getentarray("pallas_lift_front_clip", "targetname"), &movez, 112, 0.05);
    function_6e72c0ab("front", "close");
    function_2a8da7f0(3);
    level thread namespace_d40478f6::function_874f01d();
    level notify(#"hash_f913de07");
    level notify(#"hash_38764c78");
    a_ai = getaiteamarray("team3");
    foreach (ai in a_ai) {
        if (isalive(ai)) {
            ai delete();
        }
    }
    level clientfield::set("w_underwater_state", 0);
    objectives::complete("cp_level_sgen_goto_server_room_indicator", struct::get("pallas_elevator_descent_objective"));
    util::delay(3, undefined, &skipto::function_be8adfb8, "descent");
    array::thread_all(level.players, &clientfield::set_to_player, "pallas_monitors_state", 2);
    function_aab7d2d8("down");
    function_6e72c0ab("back", "open");
    level notify(#"hash_7336a7fd");
    var_4d26ec84 = getnodearray("pallas_elevator_start", "script_noteworthy");
    foreach (node in var_4d26ec84) {
        linktraversal(node);
    }
}

// Namespace namespace_646f304f
// Params 1, eflags: 0x0
// Checksum 0x95f9c86e, Offset: 0x3c78
// Size: 0x92
function function_4aa034ed(var_74cd64bc) {
    function_6e72c0ab("back", "close");
    if (!var_74cd64bc) {
        var_be31aa9a = getent("boss_fight_lift", "targetname");
        var_be31aa9a.origin += (0, 0, 1750);
    }
    function_6e72c0ab("front", "open");
}

// Namespace namespace_646f304f
// Params 0, eflags: 0x0
// Checksum 0x56321545, Offset: 0x3d18
// Size: 0x42
function watch_for_damage() {
    level endon(#"hash_343d5e2c");
    self util::waittill_either("damage", "death");
    level flag::set("pallas_ambush_over");
}

// Namespace namespace_646f304f
// Params 0, eflags: 0x0
// Checksum 0x8bb9ad49, Offset: 0x3d68
// Size: 0x42
function function_87d6b629() {
    level endon(#"hash_343d5e2c");
    array::wait_any(level.players, "weapon_fired");
    level flag::set("pallas_ambush_over");
}

// Namespace namespace_646f304f
// Params 1, eflags: 0x0
// Checksum 0x9d1146ff, Offset: 0x3db8
// Size: 0x182
function function_4ee50667(var_74cd64bc) {
    if (!var_74cd64bc) {
        trigger::wait_till("pallas_turret_enable_trigger");
    }
    level thread namespace_d40478f6::function_973b77f9();
    savegame::checkpoint_save();
    level thread function_87d6b629();
    level dialog::function_13b3b16a("plyr_diaz_you_have_to_s_0", 1);
    array::thread_all(level.players, &clientfield::set_to_player, "pallas_monitors_state", 1);
    level.var_7f246cd7 dialog::say("diaz_i_am_willing_to_d_0");
    level thread namespace_d40478f6::function_ad14681b();
    level flag::set("pallas_ambush_over");
    level dialog::remote("kane_the_only_way_to_disc_0", 2);
    level dialog::remote("hend_kane_i_m_currently_0");
    level dialog::remote("kane_access_the_primary_s_0");
    level dialog::remote("hend_you_re_the_boss_lad_0");
    level notify(#"hash_e44856f1");
    wait(2);
    level dialog::remote("kane_got_it_focus_fire_o_0", 2);
    level flag::set("pallas_intro_completed");
}

// Namespace namespace_646f304f
// Params 0, eflags: 0x0
// Checksum 0x9d6e90d7, Offset: 0x3f48
// Size: 0x7d
function function_ab0e4cbe() {
    level endon(#"hash_680acbda");
    while (true) {
        level waittill(#"save_restore");
        for (i = 1; i <= 3; i++) {
            mdl_ball = getent("diaz_ball_" + i, "targetname");
            mdl_ball globallogic_ui::function_d66e4079(%tag_weakpoint);
        }
    }
}

// Namespace namespace_646f304f
// Params 0, eflags: 0x0
// Checksum 0xc47b3bdf, Offset: 0x3fd0
// Size: 0xbcd
function function_c88aca45() {
    level endon(#"hash_a9dda4e1");
    level waittill(#"hash_e44856f1");
    var_53769c03 = getentarray("pallas_coolant_control", "targetname");
    foreach (trigger in var_53769c03) {
        trigger sethintstring(%CP_MI_SING_SGEN_DESTROY_PILLAR);
        trigger triggerenable(0);
    }
    level flag::wait_till("pallas_intro_completed");
    var_61b0688 = getentarray("diaz_tower_1", "targetname");
    while (true) {
        level thread function_6030416();
        n_random_int = randomint(var_61b0688.size);
        var_6c5a6b2b = var_61b0688[n_random_int];
        var_61b0688 = array::remove_index(var_61b0688, n_random_int);
        var_6c5a6b2b movez(114, 4);
        playfx(level._effect["coolant_tower_unleash"], var_6c5a6b2b.origin + (0, 0, -250));
        var_6c5a6b2b playsound("evt_pillar_move");
        switch (level.var_e16e585d) {
        case 0:
            level thread dialog::remote("kane_cooling_tower_one_ex_0", 1);
            break;
        case 1:
            level thread dialog::remote("kane_cooling_tower_two_ex_0", 1);
            break;
        case 2:
            level thread dialog::remote("kane_cooling_tower_three_0", 1);
            break;
        }
        level thread function_e4f0c0ff();
        var_6c5a6b2b waittill(#"movedone");
        level thread function_fede65f(var_6c5a6b2b.script_float);
        var_2815ed68 = getentarray("pallas_coolant_control", "targetname");
        var_2815ed68 = arraysortclosest(var_2815ed68, var_6c5a6b2b.origin);
        var_589f8c88 = var_2815ed68[0];
        level thread function_e1f7b7();
        level waittill(#"hash_6aac2089");
        array::thread_all(level.players, &clientfield::set_to_player, "pallas_monitors_state", 2);
        objectives::complete("cp_level_sgen_destroy_tower");
        level.var_e16e585d++;
        var_6c5a6b2b playsound("evt_pillar_dest");
        level thread function_47bd64a2();
        wait(5);
        array::thread_all(level.players, &clientfield::set_to_player, "pallas_monitors_state", 0);
        level thread function_cc42d59b();
        var_589f8c88 triggerenable(1);
        s_temp = spawnstruct();
        s_temp.origin = var_589f8c88.origin + (0, 0, 16);
        s_temp.angles = var_589f8c88.angles;
        objectives::set("cp_level_sgen_release_coolant", s_temp.origin);
        if (level.var_e16e585d == 3) {
            level thread scene::init("cin_sgen_19_ghost_3rd_sh010");
        }
        var_fd110328 = 0;
        while (!var_fd110328) {
            e_player = var_589f8c88 waittill(#"trigger");
            if (!e_player laststand::player_is_in_laststand()) {
                var_fd110328 = 1;
                e_player enableinvulnerability();
            }
        }
        level notify(#"hash_2f3ced1f");
        switch (level.var_e16e585d) {
        case 1:
            spawn_manager::kill("sm_stage1_flood", 0);
            spawn_manager::kill("sm_stage1");
            level thread namespace_d40478f6::function_3d554ba8();
            break;
        case 2:
            spawn_manager::kill("sm_stage2_flood", 0);
            spawn_manager::kill("sm_stage2");
            level thread namespace_d40478f6::function_af5cbae3();
            break;
        case 3:
            spawn_manager::kill("sm_stage3_flood", 0);
            level thread namespace_d40478f6::function_895a407a();
            break;
        }
        objectives::complete("cp_level_sgen_release_coolant", s_temp.origin);
        fx_struct = struct::get(var_589f8c88.target, "targetname");
        var_b788969e = var_589f8c88.script_noteworthy + var_589f8c88.script_string;
        switch (level.var_e16e585d) {
        case 1:
        case 2:
            level scene::play(var_b788969e + "_a", e_player);
            level thread scene::play(var_b788969e + "_b", e_player);
            break;
        case 3:
            level scene::add_scene_func("p7_fxanim_cp_sgen_pallas_ai_tower_collapse_bundle", &function_c5372adb, "play");
            level scene::add_scene_func("p7_fxanim_cp_sgen_pallas_ai_tower_collapse_bundle", &function_6610aebe, "init");
            level thread scene::play(var_b788969e + "_a", e_player);
            level thread scene::init("p7_fxanim_cp_sgen_pallas_ai_tower_collapse_bundle");
            level waittill(var_b788969e + "_a_done");
            level flag::set("pallas_death");
            array::thread_all(level.players, &clientfield::set_to_player, "pallas_monitors_state", 3);
            e_player disableinvulnerability();
            level thread skipto::function_be8adfb8("pallas_start");
            break;
        }
        var_589f8c88 delete();
        level waittill(#"boom");
        level thread function_2532875f();
        fx_model = util::spawn_model("tag_origin", fx_struct.origin, fx_struct.angles);
        level namespace_cba4cc55::function_40077528(0.5, 1, fx_model.origin, 5000, 4, 7);
        level thread function_8c31d3c3(var_6c5a6b2b.script_float);
        wait(2);
        if (isdefined(e_player)) {
            e_player disableinvulnerability();
        }
        fx_model delete();
        switch (level.var_e16e585d) {
        case 1:
            level notify(#"hash_2e9dd028");
            level dialog::function_13b3b16a("plyr_grenade_detonated_0");
            level dialog::remote("kane_it_worked_central_0");
            if (isdefined(level.var_e9d4a03e)) {
                level thread [[ level.var_e9d4a03e ]](40, 40, 20);
            }
            if (isdefined(level.var_fd2d1f37)) {
                level thread [[ level.var_fd2d1f37 ]](-106, -106, -106);
            }
            if (isdefined(level.var_27fb20e1)) {
                level thread [[ level.var_27fb20e1 ]](10);
            }
            break;
        case 2:
            level notify(#"hash_2e9dd028");
            level dialog::function_13b3b16a("plyr_successful_detonatio_0");
            level dialog::remote("kane_central_core_down_to_0");
            exploder::exploder("light_sgen_palas_em");
            var_419151a0 = struct::get("hendrick_console_hack");
            if (isdefined(level.var_e9d4a03e)) {
                level thread [[ level.var_e9d4a03e ]](25, 50, 25);
            }
            if (isdefined(level.var_fd2d1f37)) {
                level thread [[ level.var_fd2d1f37 ]](-81, -81, -81);
            }
            if (isdefined(level.var_27fb20e1)) {
                level thread [[ level.var_27fb20e1 ]](15);
            }
            if (!sessionmodeiscampaignzombiesgame()) {
                objectives::set("cp_level_sgen_protect_hendricks", var_419151a0.origin);
            }
            break;
        }
        savegame::checkpoint_save();
        array::thread_all(level.players, &clientfield::set_to_player, "pallas_monitors_state", 1);
        wait(2);
        switch (level.var_e16e585d) {
        case 1:
            spawn_manager::enable("sm_stage2");
            break;
        case 2:
            level.var_e259308b = 0;
            spawn_manager::enable("sm_stage3");
            level flag::set("core_two_destroyed");
            break;
        }
        if (level.var_e16e585d == 1) {
            level dialog::remote("kane_working_on_opening_c_0", 2);
            level dialog::function_13b3b16a("plyr_hurry_up_kane_i_m_0", 3);
            function_75946123("sm_stage2", 4, 20);
            continue;
        }
        if (level.var_e16e585d == 2) {
            level dialog::remote("kane_working_on_tower_thr_0");
            wait(20);
            switch (level.players.size) {
            case 2:
                n_spawn_count = 25;
                break;
            case 3:
                n_spawn_count = 30;
                break;
            case 4:
                n_spawn_count = 35;
                break;
            default:
                n_spawn_count = 20;
                break;
            }
            function_864a9c57("sm_stage3", n_spawn_count, 30);
            level notify(#"hash_265b1313");
            level thread function_e8ee435e();
            util::waittill_notify_or_timeout("all_suicide_bots_killed", 15);
            level flag::set("hendricks_attacked_done");
            if (!sessionmodeiscampaignzombiesgame()) {
                objectives::complete("cp_level_sgen_protect_hendricks");
            }
        }
    }
}

// Namespace namespace_646f304f
// Params 0, eflags: 0x0
// Checksum 0xaa96b7dc, Offset: 0x4ba8
// Size: 0xed
function function_47bd64a2() {
    switch (level.var_e16e585d) {
    case 1:
        level dialog::remote("kane_cooling_tower_one_of_0");
        break;
    case 2:
        level dialog::remote("kane_cooling_tower_two_of_0");
        break;
    case 3:
        level.var_94d58561 = gettime() + 30000;
        level flag::set("tower_three_destroyed");
        level dialog::remote("kane_cooling_tower_three_1");
        level dialog::remote("hend_this_better_not_kill_0");
        level dialog::remote("kane_not_the_time_comman_0");
        exploder::exploder_stop("light_sgen_palas_em");
        break;
    }
}

// Namespace namespace_646f304f
// Params 3, eflags: 0x0
// Checksum 0x8fe9ebe1, Offset: 0x4ca0
// Size: 0x72
function function_75946123(var_7dbfe5d9, n_ai_count, n_timeout) {
    if (isdefined(n_timeout)) {
        __s = spawnstruct();
        __s endon(#"timeout");
        __s util::delay_notify(n_timeout, "timeout");
    }
    spawn_manager::function_27bf2e8(var_7dbfe5d9, n_ai_count);
}

// Namespace namespace_646f304f
// Params 3, eflags: 0x0
// Checksum 0x4a43ea7e, Offset: 0x4d20
// Size: 0x72
function function_864a9c57(var_7dbfe5d9, n_spawn_count, n_timeout) {
    if (isdefined(n_timeout)) {
        __s = spawnstruct();
        __s endon(#"timeout");
        __s util::delay_notify(n_timeout, "timeout");
    }
    spawn_manager::function_740ea7ff(var_7dbfe5d9, n_spawn_count);
}

// Namespace namespace_646f304f
// Params 0, eflags: 0x0
// Checksum 0x463a8505, Offset: 0x4da0
// Size: 0xdd
function function_e1f7b7() {
    level endon(#"hash_2f3ced1f");
    switch (level.var_e16e585d) {
    case 0:
        spawn_manager::function_27bf2e8("sm_stage1", 3);
        spawn_manager::enable("sm_stage1_flood");
        break;
    case 1:
        spawn_manager::function_27bf2e8("sm_stage2", 3);
        spawn_manager::enable("sm_stage2_flood");
        break;
    case 2:
        level waittill(#"hash_6aac2089");
        spawn_manager::kill("sm_stage3");
        spawn_manager::enable("sm_stage3_flood");
        break;
    }
}

// Namespace namespace_646f304f
// Params 1, eflags: 0x0
// Checksum 0x1b643726, Offset: 0x4e88
// Size: 0x30a
function function_fede65f(var_45891e3b) {
    var_45891e3b = int(var_45891e3b);
    var_77224c8 = getent("diaz_ball_" + var_45891e3b, "targetname");
    var_77224c8 globallogic_ui::function_8ee5a301(%tag_weakpoint);
    var_f831d587 = 300 * level.players.size;
    var_77224c8.health = var_f831d587;
    var_77224c8 thread function_f63f5d7a();
    exploder::exploder("pallas_fight_coolant_tower_" + var_45891e3b);
    while (var_77224c8.health >= var_f831d587 / 2) {
        var_77224c8 waittill(#"damage");
    }
    exploder::exploder("pallas_fight_dmg_1_tower_" + var_45891e3b);
    mdl_fx = util::spawn_model("tag_origin", var_77224c8.origin, var_77224c8.angles);
    playfxontag(level._effect["coolant_tower_damage_minor"], mdl_fx, "tag_origin");
    if (var_77224c8.health > 0) {
        var_77224c8 waittill(#"death");
    }
    var_77224c8 disableaimassist();
    var_77224c8 globallogic_ui::function_d66e4079(%tag_weakpoint);
    switch (var_45891e3b) {
    case 1:
        level thread scene::play("coolant_hose_03", "targetname");
        level clientfield::set("tower_chunks2", 1);
        break;
    case 2:
        level thread scene::play("coolant_hose_01", "targetname");
        level clientfield::set("tower_chunks1", 1);
        break;
    case 3:
        level thread scene::play("coolant_hose_05", "targetname");
        level clientfield::set("tower_chunks3", 1);
        break;
    }
    level namespace_cba4cc55::function_40077528(0.5, 1, var_77224c8.origin, 5000, 4, 7);
    exploder::exploder("pallas_fight_exp_tower_" + var_45891e3b);
    mdl_fx delete();
    level notify(#"hash_6aac2089");
    mdl_fx = util::spawn_model("tag_origin", var_77224c8.origin, var_77224c8.angles);
    playfxontag(level._effect["coolant_tower_damage_major"], mdl_fx, "tag_origin");
}

// Namespace namespace_646f304f
// Params 0, eflags: 0x0
// Checksum 0xafcdee97, Offset: 0x51a0
// Size: 0x15a
function function_f63f5d7a() {
    self setcontents(8192);
    self setcandamage(1);
    self enableaimassist();
    self.team = "axis";
    self clientfield::set("cooling_tower_damage", 1);
    objectives::set("cp_level_sgen_destroy_tower", self.origin + (0, 0, 18));
    while (self.health > 0) {
        damage, attacker, direction, point = self waittill(#"damage");
        playfx(level._effect["weakspot_impact"], point, direction * -1);
        attacker damagefeedback::update();
    }
    self clientfield::set("cooling_tower_damage", 0);
    self setcontents(256);
    self setcandamage(0);
    self disableaimassist();
    self.team = "none";
}

// Namespace namespace_646f304f
// Params 0, eflags: 0x0
// Checksum 0x6e1f47df, Offset: 0x5308
// Size: 0x135
function function_4301ab5f() {
    level endon(#"hash_eb30fd63");
    level endon(#"hash_265b1313");
    level.var_eb13b054 = [];
    level.var_2d3af18b = 0;
    level.var_e15d967a = 8 + level.players.size * 2;
    var_cf1fb9af = 0;
    while (var_cf1fb9af < level.var_e15d967a) {
        for (i = 0; i < 2; i++) {
            if (!isalive(level.var_eb13b054[i])) {
                var_d495f536 = getentarray("potential_hendricks_bot", "script_string");
                ai_bot = arraygetclosest(level.var_2fd26037.origin, var_d495f536);
                if (isalive(ai_bot)) {
                    ai_bot.script_string = undefined;
                    level.var_eb13b054[i] = ai_bot;
                    ai_bot thread explode_robot(i + 1);
                    var_cf1fb9af++;
                    util::wait_network_frame();
                }
            }
        }
        wait(0.5);
    }
}

// Namespace namespace_646f304f
// Params 0, eflags: 0x0
// Checksum 0x8168edef, Offset: 0x5448
// Size: 0x83
function function_e8ee435e() {
    foreach (ai_bot in level.var_eb13b054) {
        if (isalive(ai_bot)) {
            ai_bot waittill(#"death");
        }
    }
    wait(0.1);
    level notify(#"hash_e33ac8c");
}

// Namespace namespace_646f304f
// Params 1, eflags: 0x0
// Checksum 0xa5d1636b, Offset: 0x54d8
// Size: 0x122
function explode_robot(var_687222b4) {
    self endon(#"death");
    if (sessionmodeiscampaignzombiesgame()) {
        return;
    }
    self ai::set_behavior_attribute("rogue_control", "forced_level_3");
    self ai::set_ignoreall(1);
    self flag::wait_till("in_playable_space");
    level thread scene::play("cin_sgen_18_01_pallasfight_vign_takedown_explode0" + var_687222b4, self);
    self waittill(#"start_timer");
    level thread function_f9909efe();
    switch (level.players.size) {
    case 2:
        wait(5);
        break;
    case 3:
    case 4:
        wait(3);
        break;
    default:
        wait(7);
        break;
    }
    level thread scene::stop("cin_sgen_18_01_pallasfight_vign_takedown_explode0" + var_687222b4);
    self ai::set_behavior_attribute("rogue_force_explosion", 1);
    level thread function_5eceee36();
}

// Namespace namespace_646f304f
// Params 0, eflags: 0x0
// Checksum 0x4df514e6, Offset: 0x5608
// Size: 0xed
function function_5eceee36() {
    level.var_2d3af18b++;
    switch (level.var_2d3af18b) {
    case 1:
        level clientfield::increment("observation_deck_destroy");
        level dialog::remote("hend_shit_kane_hurry_t_0", 1);
        break;
    case 2:
        level dialog::remote("hend_gimme_a_hand_i_got_0");
        break;
    case 3:
        level clientfield::increment("observation_deck_destroy");
        level dialog::remote("hend_i_m_getting_torn_up_0", 1);
        break;
    case 4:
        level dialog::remote("hend_robots_overtaking_my_0");
        break;
    case 5:
        level thread function_c79b403e();
        break;
    }
}

// Namespace namespace_646f304f
// Params 0, eflags: 0x0
// Checksum 0x6918b2d0, Offset: 0x5700
// Size: 0xd2
function function_c79b403e() {
    level clientfield::increment("observation_deck_destroy", 1);
    var_35925132 = struct::get("hendrick_console_hack", "targetname");
    var_35925132 thread scene::stop("cin_sgen_18_01_pallasfight_vign_controls_hendricks_active");
    wait(0.05);
    level.var_2fd26037 util::stop_magic_bullet_shield();
    level.var_2fd26037 dodamage(level.var_2fd26037.health, level.var_2fd26037.origin);
    wait(3.5);
    util::function_207f8667(%CP_MI_SING_SGEN_HENDRICKS_KILLED);
}

// Namespace namespace_646f304f
// Params 0, eflags: 0x0
// Checksum 0x4dcc3617, Offset: 0x57e0
// Size: 0x32
function function_f0f76126() {
    self waittill(#"death");
    level.var_9945a95d++;
    if (level.var_9945a95d == 8) {
        spawn_manager::enable("sm_stage1");
    }
}

// Namespace namespace_646f304f
// Params 0, eflags: 0x0
// Checksum 0xd2f090fb, Offset: 0x5820
// Size: 0xc5
function function_e4f0c0ff() {
    level endon(#"hash_6aac2089");
    wait(randomfloatrange(10, 15));
    switch (level.var_e16e585d) {
    case 0:
        level dialog::remote("hend_focus_fire_take_ou_0");
        wait(randomfloatrange(15, 20));
        level dialog::remote("hend_disable_that_tower_t_0");
        break;
    case 1:
        level dialog::remote("kane_we_need_to_bring_dow_0");
        break;
    case 2:
        level dialog::remote("kane_take_the_tower_offli_0");
        break;
    }
}

// Namespace namespace_646f304f
// Params 0, eflags: 0x0
// Checksum 0xd5ea2ab9, Offset: 0x58f0
// Size: 0x18d
function function_cc42d59b() {
    level endon(#"hash_2f3ced1f");
    wait(randomfloatrange(7, 10));
    switch (level.var_e16e585d) {
    case 1:
        level dialog::remote("kane_you_ve_got_to_get_cl_0");
        wait(randomfloatrange(8, 12));
        level dialog::remote("kane_come_on_climb_the_c_0");
        wait(randomfloatrange(8, 12));
        level dialog::remote("hend_you_heard_her_get_o_0");
        wait(randomfloatrange(8, 12));
        level dialog::remote("hend_climb_the_tower_hi_0");
        break;
    case 2:
        level dialog::remote("hend_get_another_grenade_0");
        wait(randomfloatrange(12, 16));
        level dialog::remote("hend_we_re_running_out_of_2");
        break;
    case 3:
        level dialog::remote("hend_get_on_that_tower_an_0");
        wait(randomfloatrange(12, 16));
        level dialog::remote("kane_get_a_grenade_in_the_0");
        wait(randomfloatrange(12, 16));
        level dialog::remote("kane_blow_the_damn_core_0");
        break;
    }
}

// Namespace namespace_646f304f
// Params 0, eflags: 0x0
// Checksum 0xbaa26005, Offset: 0x5a88
// Size: 0x3b5
function function_6030416() {
    level endon(#"hash_2f3ced1f");
    wait(randomfloatrange(3, 5));
    switch (level.var_e16e585d) {
    case 0:
        level.var_7f246cd7 dialog::say("diaz_listen_only_to_the_s_0");
        wait(randomfloatrange(3, 5));
        level.var_7f246cd7 dialog::say("diaz_let_your_mind_relax_0");
        level.var_7f246cd7 dialog::say("diaz_let_your_thoughts_dr_0");
        wait(randomfloatrange(5, 8));
        level.var_7f246cd7 dialog::say("diaz_let_the_bad_memories_0");
        level.var_7f246cd7 dialog::say("diaz_let_peace_be_upon_yo_0");
        break;
    case 1:
        level.var_7f246cd7 dialog::say("diaz_surrender_yourself_t_0");
        level.var_7f246cd7 dialog::say("diaz_let_them_wash_over_y_0");
        wait(randomfloatrange(5, 8));
        level.var_7f246cd7 dialog::say("diaz_imagine_somewhere_ca_0");
        level.var_7f246cd7 dialog::say("diaz_imagine_somewhere_sa_0");
        wait(randomfloatrange(5, 8));
        level.var_7f246cd7 dialog::say("diaz_imagine_yourself_0");
        level.var_7f246cd7 dialog::say("diaz_you_are_standing_in_0");
        wait(randomfloatrange(5, 8));
        level.var_7f246cd7 dialog::say("diaz_the_trees_around_you_0");
        level.var_7f246cd7 dialog::say("diaz_pure_white_snowflake_0");
        break;
    case 2:
        level.var_7f246cd7 dialog::say("diaz_you_can_feel_them_me_0");
        level.var_7f246cd7 dialog::say("diaz_you_are_not_cold_0");
        wait(randomfloatrange(3, 5));
        level.var_7f246cd7 dialog::say("diaz_it_cannot_overcome_t_0");
        level.var_7f246cd7 dialog::say("diaz_can_you_hear_it_0");
        level.var_7f246cd7 dialog::say("diaz_can_you_hear_it_0");
        wait(randomfloatrange(3, 5));
        level.var_7f246cd7 dialog::say("diaz_do_you_hear_it_slowi_0");
        level.var_7f246cd7 dialog::say("diaz_you_are_slowing_it_0");
        wait(randomfloatrange(3, 5));
        level.var_7f246cd7 dialog::say("diaz_you_are_in_control_0");
        level.var_7f246cd7 dialog::say("diaz_calm_0");
        level.var_7f246cd7 dialog::say("diaz_at_peace_0");
        break;
    }
}

// Namespace namespace_646f304f
// Params 0, eflags: 0x0
// Checksum 0xc9b1bf6c, Offset: 0x5e48
// Size: 0x42
function function_f9909efe() {
    if (!isdefined(level.var_4a6cbb96)) {
        level.var_4a6cbb96 = 0;
    }
    if (!level.var_4a6cbb96) {
        level.var_4a6cbb96 = 1;
        level dialog::remote("hend_hey_i_got_grunts_c_0");
    }
}

// Namespace namespace_646f304f
// Params 1, eflags: 0x0
// Checksum 0xa74d69c8, Offset: 0x5e98
// Size: 0xd3
function function_2532875f(b_immediate) {
    if (!isdefined(b_immediate)) {
        b_immediate = 0;
    }
    a_e_enemies = getaiteamarray("team3");
    foreach (e_enemy in a_e_enemies) {
        if (isalive(e_enemy)) {
            e_enemy dodamage(1000, e_enemy.origin);
            if (!b_immediate) {
                wait(randomfloatrange(0.05, 0.2));
            }
        }
    }
}

// Namespace namespace_646f304f
// Params 0, eflags: 0x0
// Checksum 0x9db3c600, Offset: 0x5f78
// Size: 0x51
function function_7362d6c4() {
    level thread function_3452571c();
    for (x = 1; x <= 8; x++) {
        level scene::init("coolant_hose_0" + x, "targetname");
    }
}

// Namespace namespace_646f304f
// Params 0, eflags: 0x0
// Checksum 0x803210be, Offset: 0x5fd8
// Size: 0xaa
function function_d6b86f3d() {
    level waittill(#"hash_d6b86f3d");
    level thread scene::play("coolant_hose_02", "targetname");
    level thread scene::play("coolant_hose_04", "targetname");
    level thread scene::play("coolant_hose_06", "targetname");
    level thread scene::play("coolant_hose_07", "targetname");
    level thread scene::play("coolant_hose_08", "targetname");
}

// Namespace namespace_646f304f
// Params 0, eflags: 0x0
// Checksum 0xb9fb6a25, Offset: 0x6090
// Size: 0x4a
function function_3452571c() {
    var_363ca6bb = getentarray("pallas_glass_break_whole", "script_noteworthy");
    array::run_all(var_363ca6bb, &hide);
}

// Namespace namespace_646f304f
// Params 1, eflags: 0x0
// Checksum 0x999d5c3b, Offset: 0x60e8
// Size: 0xc2
function function_8c31d3c3(var_7d1d4eb6) {
    var_7d1d4eb6 = int(var_7d1d4eb6);
    switch (var_7d1d4eb6) {
    case 1:
        var_378eee5b = getent("pallas_glass_break_1", "targetname");
        break;
    case 2:
        var_378eee5b = getent("pallas_glass_break_3", "targetname");
        break;
    default:
        var_378eee5b = getent("pallas_glass_break_2", "targetname");
        break;
    }
    var_378eee5b show();
}

// Namespace namespace_646f304f
// Params 1, eflags: 0x0
// Checksum 0x8c743721, Offset: 0x61b8
// Size: 0x22
function function_efa6b6f5(robot) {
    robot waittill(#"death");
    self delete();
}

// Namespace namespace_646f304f
// Params 0, eflags: 0x0
// Checksum 0xa8d1aa47, Offset: 0x61e8
// Size: 0xa1
function function_eea8b6a8() {
    self endon(#"death");
    while (true) {
        foreach (player in level.players) {
            if (distancesquared(self.origin, player.origin) < 250000) {
                self notify(#"nearby_enemy");
            }
        }
        wait(0.1);
    }
}

// Namespace namespace_646f304f
// Params 2, eflags: 0x0
// Checksum 0x31b21b35, Offset: 0x6298
// Size: 0x115
function function_ad61b905(var_d72a94c2, var_ef342c6d) {
    level endon(#"hash_eb30fd63");
    trigger = getent(var_d72a94c2, "targetname");
    while (true) {
        n_player = 0;
        foreach (player in level.players) {
            if (player istouching(trigger)) {
                n_player += 1;
            }
        }
        if (n_player > 0) {
            spawn_manager::enable(var_ef342c6d);
        } else if (spawn_manager::is_enabled(var_ef342c6d)) {
            spawn_manager::disable(var_ef342c6d);
        }
        wait(0.5);
    }
}

