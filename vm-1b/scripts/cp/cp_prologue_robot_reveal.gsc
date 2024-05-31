#using scripts/cp/gametypes/_save;
#using scripts/cp/gametypes/_battlechatter;
#using scripts/shared/ai/systems/shared;
#using scripts/shared/trigger_shared;
#using scripts/shared/vehicle_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/math_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/colors_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/array_shared;
#using scripts/shared/ai_shared;
#using scripts/cp/cp_mi_eth_prologue_accolades;
#using scripts/cp/cp_prologue_util;
#using scripts/cp/cp_prologue_apc;
#using scripts/cp/cp_prologue_hangars;
#using scripts/cp/cp_mi_eth_prologue;
#using scripts/cp/cp_mi_eth_prologue_sound;
#using scripts/cp/cp_mi_eth_prologue_fx;
#using scripts/cp/_util;
#using scripts/cp/_spawn_manager;
#using scripts/cp/_skipto;
#using scripts/cp/_objectives;
#using scripts/cp/_load;
#using scripts/cp/_dialog;
#using scripts/shared/util_shared;
#using scripts/codescripts/struct;

#namespace namespace_12501af4;

// Namespace namespace_12501af4
// Params 0, eflags: 0x0
// Checksum 0xe7bf21d5, Offset: 0xdd8
// Size: 0x92
function function_78909aa1() {
    level function_f06522c8();
    level function_7c0dd98b();
    spawner::add_spawn_function_group("sp_initial_robots", "targetname", &function_12501af4);
    spawner::add_spawn_function_group("robot_aigroup", "script_aigroup", &function_12501af4);
    level thread function_284c8a64();
}

// Namespace namespace_12501af4
// Params 0, eflags: 0x0
// Checksum 0xeed24391, Offset: 0xe78
// Size: 0x42
function function_f06522c8() {
    var_f412ff43 = getent("vtol_tackle_color", "targetname");
    var_f412ff43 triggerenable(0);
}

// Namespace namespace_12501af4
// Params 0, eflags: 0x0
// Checksum 0x1dad5ab3, Offset: 0xec8
// Size: 0x202
function function_7c0dd98b() {
    level.var_f58c9f31 ai::set_ignoreall(1);
    level.var_f58c9f31 ai::set_ignoreme(1);
    level.var_f58c9f31.goalradius = 16;
    level.var_f58c9f31.allowpain = 0;
    level.var_92d245e2 ai::set_ignoreall(1);
    level.var_92d245e2 ai::set_ignoreme(1);
    level.var_92d245e2.goalradius = 16;
    level.var_92d245e2.allowpain = 0;
    level.var_5d4087a6 ai::set_ignoreall(1);
    level.var_5d4087a6 ai::set_ignoreme(1);
    level.var_5d4087a6.goalradius = 16;
    level.var_5d4087a6.allowpain = 0;
    level.var_7f246cd7 ai::set_ignoreall(1);
    level.var_7f246cd7 ai::set_ignoreme(1);
    level.var_7f246cd7.goalradius = 16;
    level.var_7f246cd7.allowpain = 0;
    level.var_2fd26037 ai::set_ignoreall(1);
    level.var_2fd26037 ai::set_ignoreme(1);
    level.var_2fd26037.goalradius = 16;
    level.var_9db406db ai::set_ignoreall(1);
    level.var_9db406db ai::set_ignoreme(1);
    level.var_9db406db.goalradius = 16;
    level.var_4d5a4697 ai::set_ignoreall(1);
    level.var_4d5a4697 ai::set_ignoreme(1);
    level.var_4d5a4697.goalradius = 16;
}

// Namespace namespace_12501af4
// Params 0, eflags: 0x0
// Checksum 0x72586d2a, Offset: 0x10d8
// Size: 0x5ea
function function_284c8a64() {
    battlechatter::function_d9f49fba(0);
    level thread function_48cd673e();
    level thread function_874bf7f();
    level thread function_79c2bdec();
    level thread function_341ece1b();
    level thread function_38c8ec92();
    level thread function_9fb290a5();
    level thread function_94976a83();
    level thread function_4a895a11();
    level thread objectives::breadcrumb("breadcrumb_robot_horde");
    level thread function_96157f5d();
    a_ai_allies = namespace_2cb3876f::function_6ee0e1a5();
    foreach (var_e4463170 in a_ai_allies) {
        var_e4463170 ai::set_behavior_attribute("cqb", 1);
    }
    level flag::wait_till("player_in_alley");
    namespace_2cb3876f::function_b50f5d52();
    a_ai_allies = namespace_2cb3876f::function_6ee0e1a5();
    a_ai_allies[a_ai_allies.size] = level.var_f58c9f31;
    a_ai_allies[a_ai_allies.size] = level.var_2fd26037;
    a_ai_allies[a_ai_allies.size] = level.var_9db406db;
    a_ai_allies[a_ai_allies.size] = level.var_7f246cd7;
    a_ai_allies[a_ai_allies.size] = level.var_5d4087a6;
    foreach (var_e4463170 in a_ai_allies) {
        var_e4463170 ai::set_ignoreall(1);
        var_e4463170 ai::set_ignoreme(1);
    }
    level thread function_90882a34();
    level thread function_59071a25();
    level thread function_f7a7c69a();
    util::delay(0.5, undefined, &exploder::exploder, "fx_exploder_fog_light_horde");
    savegame::checkpoint_save();
    level flag::wait_till("robot_contact");
    level.var_f58c9f31 ai::set_ignoreall(0);
    level.var_7f246cd7 ai::set_ignoreall(0);
    level.var_5d4087a6 ai::set_ignoreall(0);
    foreach (var_e4463170 in a_ai_allies) {
        var_e4463170 ai::set_ignoreall(0);
        var_e4463170 thread function_54900cca();
    }
    level thread function_3d5fceb9();
    wait(8);
    level flag::set("open_fire");
    foreach (var_e4463170 in a_ai_allies) {
        var_e4463170 ai::set_behavior_attribute("cqb", 0);
    }
    level apc::function_50d6bf35("vehicle_apc_hijack_node", 0);
    level thread function_d105c430();
    callback::on_spawned(&function_51a9314a);
    level thread function_51280ee5();
    level flag::wait_till("garage_open");
    objectives::complete("cp_level_prologue_defend_theia", level.var_92d245e2);
    level.garage_door = struct::get("garage_door", "targetname");
    objectives::set("cp_waypoint_breadcrumb", level.garage_door);
    trigger::use("triggercolor_allies_garage");
    scene::add_scene_func("cin_pro_15_01_opendoor_vign_getinside_khalil_minister_hendricks", &function_21350de5, "play");
    level thread scene::play("cin_pro_15_01_opendoor_vign_getinside_khalil_minister_hendricks");
    level waittill(#"hash_e41afc83");
    level.var_2fd26037 setgoal(level.var_2fd26037.origin, 1);
    level flag::wait_till("players_in_garage");
    level flag::wait_till("allies_in_garage");
    objectives::complete("cp_level_prologue_find_vehicle");
    objectives::set("cp_level_prologue_goto_exfil");
    level flag::wait_till("garage_closed");
    level flag::wait_till("minister_apc_done");
    callback::remove_on_spawned(&function_51a9314a);
    skipto::function_be8adfb8("skipto_robot_horde");
}

// Namespace namespace_12501af4
// Params 0, eflags: 0x0
// Checksum 0x5ba93618, Offset: 0x16d0
// Size: 0x62
function function_96157f5d() {
    var_9a246ea8 = getent("t_robot_horde_oob", "targetname");
    if (isdefined(var_9a246ea8)) {
        level flag::wait_till("vo_robot");
        wait(1.9);
        var_9a246ea8 triggerenable(1);
    }
}

// Namespace namespace_12501af4
// Params 1, eflags: 0x0
// Checksum 0x2e718d9d, Offset: 0x1740
// Size: 0x42
function function_21350de5(a_ents) {
    var_94848710 = a_ents["minister"];
    var_94848710 waittill(#"death");
    level flag::set("minister_apc_done");
}

// Namespace namespace_12501af4
// Params 0, eflags: 0x0
// Checksum 0x2c10c9d3, Offset: 0x1790
// Size: 0x32
function function_4a895a11() {
    level waittill(#"hash_d1ef0d27");
    wait(1);
    playsoundatposition("evt_robot_fake_battle", (15815, -745, 497));
}

// Namespace namespace_12501af4
// Params 0, eflags: 0x0
// Checksum 0x98209fbf, Offset: 0x17d0
// Size: 0x9a
function function_94976a83() {
    trigger::use("triggercolor_allies_stairs");
    trigger::wait_till("triggercolor_alley");
    trigger::use("triggercolor_allies_alley");
    level flag::wait_till("player_in_alley");
    trigger::use("triggercolor_allies_alley");
    wait(1.5);
    trigger::use("robot_defend_color_chain1");
}

// Namespace namespace_12501af4
// Params 0, eflags: 0x0
// Checksum 0x448331a6, Offset: 0x1878
// Size: 0x72
function function_54900cca() {
    self endon(#"death");
    level flag::wait_till("garage_enter");
    self.ignoresuppression = 1;
    wait(3);
    self ai::set_ignoreall(1);
    level flag::wait_till("allies_in_garage");
    self.ignoresuppression = 0;
    self ai::set_ignoreall(0);
}

// Namespace namespace_12501af4
// Params 0, eflags: 0x0
// Checksum 0x81ab3acd, Offset: 0x18f8
// Size: 0x62
function function_59071a25() {
    trigger::wait_till("player_inside_garage");
    level flag::set("players_in_garage");
    level thread namespace_21b2c1f2::function_fb0b7bb6();
    objectives::complete("cp_waypoint_breadcrumb", level.garage_door);
}

// Namespace namespace_12501af4
// Params 0, eflags: 0x0
// Checksum 0xfde54fd1, Offset: 0x1968
// Size: 0xe2
function function_f7a7c69a() {
    t_entrance = getent("player_inside_garage", "targetname");
    a_ai_allies = namespace_2cb3876f::function_6ee0e1a5();
    foreach (var_e4463170 in a_ai_allies) {
        while (isalive(var_e4463170) && !var_e4463170 istouching(t_entrance)) {
            wait(0.1);
        }
    }
    level flag::set("allies_in_garage");
}

// Namespace namespace_12501af4
// Params 0, eflags: 0x0
// Checksum 0x1562c0cd, Offset: 0x1a58
// Size: 0x10a
function function_90882a34() {
    level flag::wait_till("spawn_robot_horde");
    if (isdefined(level.var_3afb66ba)) {
        level thread [[ level.var_3afb66ba ]]();
    }
    spawn_manager::enable("sm_initial_robots");
    wait(3);
    spawn_manager::enable("sm_robot_horde1");
    wait(1);
    spawn_manager::enable("sm_robot_horde2");
    wait(1);
    spawn_manager::enable("sm_robot_horde3");
    level flag::wait_till("players_in_garage");
    spawn_manager::kill("sm_initial_robots");
    spawn_manager::kill("sm_robot_horde1");
    spawn_manager::kill("sm_robot_horde2");
    spawn_manager::kill("sm_robot_horde3");
}

// Namespace namespace_12501af4
// Params 0, eflags: 0x0
// Checksum 0x20b4744a, Offset: 0x1b70
// Size: 0x102
function function_9fb290a5() {
    struct = struct::get("sndRobotRattle", "targetname");
    struct2 = struct::get(struct.target, "targetname");
    ent = spawn("script_model", struct.origin);
    while (!flag::get("players_in_garage")) {
        ent playsound("evt_robot_reveal_step");
        wait(0.3);
        ent clientfield::set("sndRattle", 1);
        wait(0.8);
        ent clientfield::set("sndRattle", 0);
    }
    ent playloopsound("evt_robot_fake_battle_lp", 5);
}

// Namespace namespace_12501af4
// Params 0, eflags: 0x0
// Checksum 0xa8a6911b, Offset: 0x1c80
// Size: 0x102
function function_51280ee5() {
    level flag::wait_till("garage_open");
    level thread scene::play("p7_fxanim_cp_prologue_apc_door_01_open_bundle");
    wait(0.3);
    level thread scene::play("p7_fxanim_cp_prologue_apc_door_02_open_bundle");
    trigger::use("t_motorpool_spawns_enable", "targetname");
    level flag::wait_till("players_in_garage");
    level flag::wait_till("allies_in_garage");
    level thread scene::play("p7_fxanim_cp_prologue_apc_door_01_close_bundle");
    wait(0.3);
    level flag::set("garage_closed");
    level scene::play("p7_fxanim_cp_prologue_apc_door_02_close_bundle");
    function_c2619de1();
}

// Namespace namespace_12501af4
// Params 0, eflags: 0x0
// Checksum 0xd67f8194, Offset: 0x1d90
// Size: 0x103
function function_c2619de1() {
    var_9869c63b = getent("t_kill_robots_inside_garage", "targetname");
    a_ai_enemies = getaiteamarray("axis");
    foreach (ai_enemy in a_ai_enemies) {
        if (isalive(ai_enemy)) {
            if (ai_enemy istouching(var_9869c63b)) {
                ai_enemy ai::bloody_death(randomfloat(0.25));
                continue;
            }
            ai_enemy delete();
        }
    }
}

// Namespace namespace_12501af4
// Params 0, eflags: 0x0
// Checksum 0x5b750817, Offset: 0x1ea0
// Size: 0x63
function function_d105c430() {
    foreach (player in level.players) {
        player thread function_51a9314a();
    }
}

// Namespace namespace_12501af4
// Params 0, eflags: 0x0
// Checksum 0xb84c5f65, Offset: 0x1f10
// Size: 0x5a
function function_51a9314a() {
    self endon(#"death");
    self.var_cbf4698a = self.attackeraccuracy;
    self.attackeraccuracy = 0;
    self thread function_10302408();
    level flag::wait_till("players_in_garage");
    self.attackeraccuracy = self.var_cbf4698a;
}

// Namespace namespace_12501af4
// Params 0, eflags: 0x0
// Checksum 0x53feac67, Offset: 0x1f78
// Size: 0x3d
function function_10302408() {
    level endon(#"hash_eecef59c");
    self endon(#"death");
    while (self.attackeraccuracy < 1) {
        wait(1);
        self.attackeraccuracy = self.attackeraccuracy + 0.1;
    }
}

// Namespace namespace_12501af4
// Params 0, eflags: 0x0
// Checksum 0x2178b645, Offset: 0x1fc0
// Size: 0x72
function function_12501af4() {
    level endon(#"hash_64ad6809");
    self endon(#"death");
    self.goalradius = 32;
    self thread function_e583f6c3();
    self thread robot_stop();
    self thread robot_speed();
    self waittill(#"goal");
    self.goalradius = 2048;
    wait(3);
    self.perfectaim = 1;
}

// Namespace namespace_12501af4
// Params 0, eflags: 0x0
// Checksum 0xc3c8b3ec, Offset: 0x2040
// Size: 0x4a
function robot_stop() {
    self endon(#"death");
    level flag::wait_till("garage_closed");
    self setgoal(self.origin, 1);
    self ai::set_ignoreall(1);
}

// Namespace namespace_12501af4
// Params 0, eflags: 0x0
// Checksum 0xe02ebee2, Offset: 0x2098
// Size: 0x42
function robot_speed() {
    self endon(#"death");
    level flag::wait_till("garage_open");
    wait(5);
    self ai::set_behavior_attribute("move_mode", "marching");
}

// Namespace namespace_12501af4
// Params 0, eflags: 0x0
// Checksum 0x3ed8f31, Offset: 0x20e8
// Size: 0x4a
function function_e583f6c3() {
    self endon(#"death");
    self ai::set_ignoreall(1);
    level flag::wait_till("open_fire");
    wait(3);
    self ai::set_ignoreall(0);
}

// Namespace namespace_12501af4
// Params 0, eflags: 0x0
// Checksum 0xa146090, Offset: 0x2140
// Size: 0x17b
function function_48cd673e() {
    level.var_2fd26037 colors::disable();
    level.var_9db406db colors::disable();
    level.var_4d5a4697 colors::disable();
    level.var_2fd26037 thread function_85de96a6("hendricks");
    level.var_9db406db thread function_85de96a6("khalil");
    level.var_4d5a4697 thread function_85de96a6("minister");
    util::waittill_multiple("hendricks_ready", "khalil_ready", "minister_ready");
    level flag::wait_till("goto_alley");
    level thread scene::play("cin_pro_14_01_robothorde_vign_dismantle");
    level.var_2fd26037 clearforcedgoal();
    level.var_9db406db clearforcedgoal();
    level.var_4d5a4697 clearforcedgoal();
    level thread function_20e7e38e();
    level flag::wait_till("prometheus_stop_directing");
    level notify(#"hash_8f3f5759");
}

// Namespace namespace_12501af4
// Params 1, eflags: 0x0
// Checksum 0xe1e5ea13, Offset: 0x22c8
// Size: 0x60
function function_85de96a6(str_name) {
    var_9de10fe3 = getnode(str_name + "_robot_entry", "targetname");
    self setgoal(var_9de10fe3, 1);
    self waittill(#"goal");
    level notify(str_name + "_ready");
}

// Namespace namespace_12501af4
// Params 0, eflags: 0x0
// Checksum 0xfb773563, Offset: 0x2330
// Size: 0x6a
function function_20e7e38e() {
    self endon(#"hash_8f3f5759");
    wait(5);
    level.var_2fd26037 dialog::say("hend_c_mon_exfil_s_just_0");
    wait(5);
    level.var_2fd26037 dialog::say("hend_we_gotta_get_the_min_0");
    wait(5);
    level.var_2fd26037 dialog::say("hend_we_can_t_miss_our_pi_0");
}

// Namespace namespace_12501af4
// Params 0, eflags: 0x0
// Checksum 0xf27219e6, Offset: 0x23a8
// Size: 0x1c2
function function_874bf7f() {
    level thread function_c091ae43();
    level thread function_82869bf4();
    level thread function_f4e0744a();
    level thread scene::add_scene_func("cin_pro_14_01_robothorde_vign_directing", &function_7ad76fc0, "play");
    if (!level flag::get("prom_point")) {
        level thread scene::play("cin_pro_14_01_robothorde_vign_directing");
        level flag::wait_till("taylor_direct");
    }
    level flag::wait_till("prom_point");
    level scene::play("cin_pro_14_01_robothorde_vign_directing_pointing");
    if (!level flag::get("prometheus_stop_directing")) {
        level thread scene::play("cin_pro_14_01_robothorde_vign_directing");
    }
    level flag::wait_till("spawn_robot_horde");
    wait(2);
    level thread scene::play("cin_pro_14_01_robothorde_vign_dismantle_new_prometheus");
    level waittill(#"hash_a4b8e7ad");
    objectives::set("cp_level_prologue_defend_theia", level.var_92d245e2);
    level flag::wait_till("garage_open");
    level scene::play("cin_pro_15_01_opendoor_vign_getinside_new_prometheus_move");
    level.var_92d245e2 setgoal(level.var_92d245e2.origin, 1);
}

// Namespace namespace_12501af4
// Params 1, eflags: 0x0
// Checksum 0x69008f29, Offset: 0x2578
// Size: 0x22
function function_7ad76fc0(a_ents) {
    level flag::set("taylor_direct");
}

// Namespace namespace_12501af4
// Params 0, eflags: 0x0
// Checksum 0xb4b14867, Offset: 0x25a8
// Size: 0x4a
function function_c091ae43() {
    level thread scene::play("cin_pro_14_01_robothorde_vign_dismantle_theia");
    level flag::wait_till("garage_open");
    level thread scene::play("cin_pro_14_01_robothorde_vign_dismantle_theia_shoot");
}

// Namespace namespace_12501af4
// Params 0, eflags: 0x0
// Checksum 0x4420ff6c, Offset: 0x2600
// Size: 0x4a
function function_82869bf4() {
    level thread scene::play("cin_pro_14_01_robothorde_vign_dismantle_diaz");
    level flag::wait_till("garage_open");
    level thread scene::play("cin_pro_14_01_robothorde_vign_dismantle_diaz_shoot");
}

// Namespace namespace_12501af4
// Params 0, eflags: 0x0
// Checksum 0xfee81efc, Offset: 0x2658
// Size: 0x4a
function function_f4e0744a() {
    level thread scene::play("cin_pro_14_01_robothorde_vign_dismantle_maretti");
    level flag::wait_till("garage_open");
    level thread scene::play("cin_pro_14_01_robothorde_vign_dismantle_maretti_shoot");
}

// Namespace namespace_12501af4
// Params 0, eflags: 0x0
// Checksum 0x7fb2fad9, Offset: 0x26b0
// Size: 0x322
function function_38c8ec92() {
    level endon(#"hash_e41afc83");
    var_49b32118 = getent("pa_nrc_warning", "targetname");
    var_49b32118 dialog::say("nrcp_warning_nrc_grunt_i_0", 0, 1);
    level flag::wait_till("player_in_alley");
    function_e3231637(1);
    level.var_5d4087a6 dialog::say("mare_you_guys_hear_tha_0", 0.5);
    level.var_7f246cd7 dialog::say("diaz_you_re_hearing_thing_0", 0.5);
    level flag::set("spawn_robot_horde");
    level thread namespace_21b2c1f2::function_448421b7();
    level.var_5d4087a6 dialog::say("mare_hey_fuck_you_0", 0.5);
    level.var_2fd26037 dialog::say("hend_shut_up_i_hear_it_t_0", 0.5);
    level flag::set("robot_contact");
    level.var_2fd26037 dialog::say("hend_holy_shit_0", 0.5);
    level.var_5d4087a6 dialog::say("mare_contact_contact_0", 0.5);
    wait(0.5);
    function_e3231637(0);
    level.var_7f246cd7 dialog::say("diaz_incoming_bots_a_s_0", 0.5);
    level.var_92d245e2 dialog::say("tayr_we_need_that_door_op_0", 0.5);
    level.var_92d245e2 dialog::say("tayr_give_us_some_cover_f_0");
    level flag::set("garage_open");
    level.var_92d245e2 dialog::say("tayr_get_inside_go_go_0", 0.6);
    level.var_5d4087a6 dialog::say("mare_get_to_the_extract_0", 1);
    level.var_5d4087a6 dialog::say("mare_we_ll_deal_with_robo_0", 0.35);
    level.var_f58c9f31 dialog::say("hall_get_the_minister_ins_0", 0.5);
    level thread namespace_21b2c1f2::function_37a511a();
    if (!level flag::get("players_in_garage") && !sessionmodeiscampaignzombiesgame()) {
        level thread function_f0042481();
    }
}

// Namespace namespace_12501af4
// Params 1, eflags: 0x0
// Checksum 0x272c997f, Offset: 0x29e0
// Size: 0x9b
function function_e3231637(var_8a4b0c9) {
    if (isdefined(level.var_681ad194)) {
        foreach (var_75443889 in level.var_681ad194) {
            var_75443889 ai::set_pacifist(var_8a4b0c9);
            if (var_8a4b0c9) {
                wait(randomfloatrange(0.1, 0.75));
            }
        }
    }
}

// Namespace namespace_12501af4
// Params 0, eflags: 0x0
// Checksum 0x82689ed2, Offset: 0x2a88
// Size: 0xd2
function function_f0042481() {
    level endon(#"hash_64b7ce47");
    wait(4);
    level.var_92d245e2 dialog::say("tayr_you_re_dead_out_ther_0");
    wait(5);
    level.var_92d245e2 dialog::say("tayr_we_gotta_move_come_0");
    wait(5);
    level.var_92d245e2 dialog::say("tayr_drone_s_almost_here_0");
    wait(5);
    level notify(#"failed");
    spawn_manager::kill("sm_robot_horde1");
    spawn_manager::kill("sm_robot_horde2");
    spawn_manager::kill("sm_robot_horde3");
    util::function_207f8667(%CP_MI_ETH_PROLOGUE_GARAGE_FAIL);
}

// Namespace namespace_12501af4
// Params 1, eflags: 0x0
// Checksum 0x1bc28f49, Offset: 0x2b68
// Size: 0x5a
function function_1fd1d84b(ent) {
    level.var_7f246cd7 setgoal(level.var_7f246cd7.origin, 1);
    level.var_5d4087a6 setgoal(level.var_5d4087a6.origin, 1);
}

// Namespace namespace_12501af4
// Params 0, eflags: 0x0
// Checksum 0x982bc6ac, Offset: 0x2bd0
// Size: 0xa3
function function_3d5fceb9() {
    level flag::wait_till("cyber_soldiers_kill_robots");
    clips = getentarray("robot_clip", "targetname");
    foreach (clip in clips) {
        clip delete();
    }
}

// Namespace namespace_12501af4
// Params 0, eflags: 0x0
// Checksum 0xd2e8ff6d, Offset: 0x2c80
// Size: 0xc2
function function_341ece1b() {
    var_c8af31c9 = getent("clip_player_garage", "targetname");
    var_c8af31c9 movez(-56 * -1, 0.05);
    level flag::wait_till("garage_open");
    var_c8af31c9 movez(-56, 2);
    var_c8af31c9 waittill(#"movedone");
    level flag::wait_till("players_in_garage");
    var_c8af31c9 movez(-56 * -1, 0.05);
}

// Namespace namespace_12501af4
// Params 0, eflags: 0x0
// Checksum 0x98f35ee5, Offset: 0x2d50
// Size: 0xba
function function_79c2bdec() {
    mdl_clip = getent("clip_ai_garage", "targetname");
    level flag::wait_till("garage_open");
    mdl_clip notsolid();
    mdl_clip connectpaths();
    level flag::set("garage_enter");
    level flag::wait_till("garage_closed");
    wait(1);
    mdl_clip solid();
    mdl_clip disconnectpaths();
}

