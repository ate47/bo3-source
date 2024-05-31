#using scripts/cp/cybercom/_cybercom_util;
#using scripts/cp/cybercom/_cybercom;
#using scripts/shared/system_shared;
#using scripts/shared/flagsys_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/ai/systems/behavior_tree_utility;
#using scripts/shared/ai/systems/animation_state_machine_utility;
#using scripts/shared/ai/systems/animation_state_machine_notetracks;
#using scripts/cp/cp_mi_sing_blackstation_sound;
#using scripts/cp/cp_mi_sing_blackstation_utility;
#using scripts/cp/cp_mi_sing_blackstation_accolades;
#using scripts/cp/cp_mi_sing_blackstation_subway;
#using scripts/shared/weapons_shared;
#using scripts/shared/vehicleriders_shared;
#using scripts/shared/vehicle_shared;
#using scripts/shared/util_shared;
#using scripts/shared/turret_shared;
#using scripts/shared/trigger_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/player_shared;
#using scripts/shared/math_shared;
#using scripts/shared/laststand_shared;
#using scripts/shared/gameobjects_shared;
#using scripts/shared/fx_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/colors_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/array_shared;
#using scripts/shared/ai_shared;
#using scripts/cp/cybercom/_cybercom_gadget_concussive_wave;
#using scripts/cp/gametypes/_spawnlogic;
#using scripts/cp/gametypes/_save;
#using scripts/cp/gametypes/coop;
#using scripts/cp/_util;
#using scripts/cp/_spawn_manager;
#using scripts/cp/_skipto;
#using scripts/cp/_oed;
#using scripts/cp/_objectives;
#using scripts/cp/_load;
#using scripts/cp/_hacking;
#using scripts/cp/_dialog;
#using scripts/codescripts/struct;

#namespace namespace_8b9f718f;

// Namespace namespace_8b9f718f
// Params 0, eflags: 0x1 linked
// Checksum 0x81c3071b, Offset: 0x2000
// Size: 0x34
function main() {
    level thread namespace_79e1cd97::function_9ad97cf7();
    level thread function_8c158bf0();
}

// Namespace namespace_8b9f718f
// Params 2, eflags: 0x1 linked
// Checksum 0xb8fd1d20, Offset: 0x2040
// Size: 0x354
function function_bd209495(str_objective, var_74cd64bc) {
    if (var_74cd64bc) {
        load::function_73adcefc();
        namespace_79e1cd97::function_bff1a867("objective_anchor_intro");
        level thread namespace_79e1cd97::function_5d4fc658();
        level thread function_21f63154();
        level thread objectives::breadcrumb("anchor_intro_breadcrumb", "cp_level_blackstation_climb");
        level thread function_109329ae();
        level thread namespace_79e1cd97::function_46dd77b0();
        load::function_a2995f22();
        wait(0.2);
        level thread namespace_79e1cd97::function_d1dc735f();
    }
    level scene::init("p7_fxanim_cp_blackstation_boatroom_bundle");
    if (isdefined(level.var_ceae7aca)) {
        level thread [[ level.var_ceae7aca ]]();
    }
    level thread function_b7f1a1f6();
    level thread namespace_79e1cd97::function_6778ea09("med_se");
    level thread function_ab78d20a();
    level thread namespace_79e1cd97::function_e7bf1516();
    level thread namespace_79e1cd97::function_3a563d3();
    level thread namespace_79e1cd97::function_cb28102c();
    level thread function_9ea179d0();
    level thread function_d9713ae3();
    level thread function_af475f02(1);
    level thread function_94ff5bc0();
    level thread namespace_79e1cd97::function_70aaf37b(0);
    var_3be169e6 = getent("anchor_intro_wind", "targetname");
    var_3be169e6 trigger::wait_till();
    var_3be169e6 thread namespace_79e1cd97::function_3c6fc4cb();
    foreach (player in level.activeplayers) {
        player thread namespace_79e1cd97::function_f2e7ba4b();
    }
    level flag::wait_till("anchor_intro_done");
    skipto::function_be8adfb8("objective_anchor_intro");
}

// Namespace namespace_8b9f718f
// Params 4, eflags: 0x1 linked
// Checksum 0xf265aed9, Offset: 0x23a0
// Size: 0x44
function function_88ddfb38(str_objective, var_74cd64bc, var_e4cd2b8b, player) {
    level thread scene::play("p7_fxanim_gp_umbrella_outdoor_worn_01_bundle");
}

// Namespace namespace_8b9f718f
// Params 2, eflags: 0x1 linked
// Checksum 0xba465469, Offset: 0x23f0
// Size: 0x54c
function function_7a0b2bc4(str_objective, var_74cd64bc) {
    spawner::add_global_spawn_function("axis", &function_13e164f4);
    spawner::add_spawn_function_group("port_enemy", "script_noteworthy", &function_f3d4c95b);
    spawner::add_spawn_function_group("wind_rpg", "script_string", &function_6a0ccfd);
    vehicle::add_spawn_function("port_assault_tech", &function_17894e22);
    level thread function_17c457d7();
    level thread objectives::breadcrumb("port_assault_breadcrumb");
    level thread namespace_79e1cd97::function_6778ea09("med_se");
    if (var_74cd64bc) {
        load::function_73adcefc();
        exploder::exploder("fx_expl_hotel_rain_windows");
        namespace_79e1cd97::function_bff1a867("objective_port_assault");
        level thread namespace_79e1cd97::function_70aaf37b(1);
        level thread function_9ea179d0();
        level thread namespace_79e1cd97::function_5d4fc658();
        level scene::skipto_end("p7_fxanim_cp_blackstation_boatroom_bundle");
        trigger::use("trigger_hendricks_anchor_done");
        load::function_a2995f22();
        level flag::set("anchor_intro_done");
        level thread function_af475f02(0);
    } else {
        level thread function_925a5c0b();
    }
    level thread function_8ff7652d();
    level thread function_e00d64fc();
    level thread function_d66d3847();
    level thread function_6cf315c1();
    level thread function_b8500bb1();
    level thread function_5b85480f();
    level.var_2fd26037.var_f005c227 = 0;
    level thread function_b73344f6();
    var_12377408 = getent("port_assault_low_surge", "targetname");
    level thread namespace_79e1cd97::function_d3e22b53(var_12377408);
    array::thread_all(level.activeplayers, &namespace_79e1cd97::function_55221935);
    array::thread_all(level.activeplayers, &clientfield::set_to_player, "toggle_rain_sprite", 0);
    if (isdefined(level.var_eec0b3fd)) {
        level thread [[ level.var_eec0b3fd ]]();
    }
    trigger::use("port_assault_start", "targetname", undefined, 0);
    trigger::wait_till("surge_tutorial");
    level flag::set("end_surge_start");
    level.var_2fd26037 dialog::say("hend_these_waves_are_gonn_0");
    foreach (player in level.activeplayers) {
        player namespace_79e1cd97::function_3ceb3ad7();
    }
    level thread function_3e1b1aaa();
    flag::wait_till("start_barge");
    level thread function_3916ca15();
    level thread function_b28ad6d2();
    trigger::wait_till("end_port_assault");
    level skipto::function_be8adfb8("objective_port_assault");
}

// Namespace namespace_8b9f718f
// Params 4, eflags: 0x1 linked
// Checksum 0x9c507b34, Offset: 0x2948
// Size: 0x3c
function function_93433fef(str_objective, var_74cd64bc, var_e4cd2b8b, player) {
    objectives::complete("cp_level_blackstation_goto_docks");
}

// Namespace namespace_8b9f718f
// Params 2, eflags: 0x1 linked
// Checksum 0x92423b05, Offset: 0x2990
// Size: 0x3ac
function function_43296c4c(str_objective, var_74cd64bc) {
    setdvar("phys_gravity_dir", (0, -0.5, 0.9));
    level thread function_281ee5c2(var_74cd64bc);
    if (var_74cd64bc) {
        load::function_73adcefc();
        level thread function_9ea179d0();
        level thread function_b8500bb1();
        level thread function_3916ca15();
        level thread function_5fc4b0f9(var_74cd64bc);
        namespace_79e1cd97::function_bff1a867("objective_barge_assault");
        level thread namespace_79e1cd97::function_70aaf37b(1);
        level.var_2fd26037.var_f005c227 = 0;
        var_12377408 = getent("port_assault_low_surge", "targetname");
        level thread namespace_79e1cd97::function_d3e22b53(var_12377408);
        array::thread_all(level.activeplayers, &namespace_79e1cd97::function_55221935);
        spawner::add_global_spawn_function("axis", &function_13e164f4);
        level flag::wait_till_all(array("all_players_spawned", "start_objective_barge_assault"));
        trigger::use("move_to_pier");
    }
    array::thread_all(level.activeplayers, &clientfield::set_to_player, "toggle_rain_sprite", 1);
    level thread objectives::breadcrumb("barge_assault_breadcrumb");
    level thread namespace_79e1cd97::function_6778ea09("drench_se");
    level thread function_6bb14aef();
    level thread function_fd4da71();
    level thread function_2124978a();
    level thread function_ec409848();
    level thread function_22a0015b();
    level thread function_30f43af6();
    level thread function_7a7390dd();
    array::thread_all(getentarray("barge_current", "targetname"), &namespace_79e1cd97::function_76b75dc7, "objective_storm_surge_terminate", -60, 300);
    level flag::wait_till("breached");
    level skipto::function_be8adfb8("objective_barge_assault");
}

// Namespace namespace_8b9f718f
// Params 4, eflags: 0x1 linked
// Checksum 0xcfc0284f, Offset: 0x2d48
// Size: 0x3c
function function_c57c7177(str_objective, var_74cd64bc, var_e4cd2b8b, player) {
    objectives::complete("cp_level_blackstation_board_ship");
}

// Namespace namespace_8b9f718f
// Params 2, eflags: 0x1 linked
// Checksum 0x5282ca39, Offset: 0x2d90
// Size: 0x20c
function function_f93ea5f3(str_objective, var_74cd64bc) {
    if (var_74cd64bc) {
        load::function_73adcefc();
        namespace_79e1cd97::function_bff1a867("objective_storm_surge");
        level thread namespace_79e1cd97::function_70aaf37b(1);
        level thread function_b8500bb1();
        level thread function_9ea179d0();
        level function_3916ca15();
        level thread function_3483fad0(var_74cd64bc);
        level thread function_5fc4b0f9(var_74cd64bc);
        level thread function_22a0015b();
        while (!level scene::is_ready("p7_fxanim_cp_blackstation_barge_roof_break_bundle")) {
            util::wait_network_frame();
        }
        load::function_a2995f22();
        trigger::use("hendricks_breach");
        array::thread_all(getentarray("barge_current", "targetname"), &namespace_79e1cd97::function_76b75dc7, "objective_storm_surge_terminate", -60, 300);
    }
    spawner::remove_global_spawn_function("axis", &function_13e164f4);
    level flag::wait_till("tanker_ride_done");
    level skipto::function_be8adfb8("objective_storm_surge");
}

// Namespace namespace_8b9f718f
// Params 4, eflags: 0x1 linked
// Checksum 0x9e58fb7a, Offset: 0x2fa8
// Size: 0x1da
function function_7cde31a6(str_objective, var_74cd64bc, var_e4cd2b8b, player) {
    var_30f598ff = getentarray("barge_ents", "script_noteworthy");
    array::thread_all(var_30f598ff, &util::self_delete);
    var_4da28b01 = getentarray("barge_roof", "targetname");
    array::thread_all(var_4da28b01, &util::self_delete);
    var_ef0ea28e = getentarray("wharf_debris", "script_noteworthy");
    array::thread_all(var_ef0ea28e, &util::self_delete);
    objectives::complete("cp_level_blackstation_wheelhouse");
    objectives::complete("cp_level_blackstation_intercept");
    foreach (player in level.players) {
        if (isdefined(player.var_c4ed51d5)) {
            player.var_c4ed51d5 delete();
        }
    }
}

// Namespace namespace_8b9f718f
// Params 0, eflags: 0x1 linked
// Checksum 0x564e754e, Offset: 0x3190
// Size: 0x134
function function_d9713ae3() {
    level endon(#"hash_34a87292");
    a_str_vo = array("hend_brace_yourself_0", "hend_wind_s_picking_up_0", "hend_anchor_now_0", "hend_use_your_anchor_0");
    while (true) {
        level waittill(#"hash_5dd3aa3a");
        if (!flag::get("warning_vo_played")) {
            level.var_2fd26037 dialog::say("hend_wind_s_picking_up_0");
            flag::set("warning_vo_played");
        } else if (a_str_vo.size) {
            str_vo = array::random(a_str_vo);
            level.var_2fd26037 dialog::say(str_vo);
            arrayremovevalue(a_str_vo, str_vo);
        } else {
            level notify(#"hash_34a87292");
        }
        wait(0.1);
    }
}

// Namespace namespace_8b9f718f
// Params 0, eflags: 0x0
// Checksum 0x9ed0b9bc, Offset: 0x32d0
// Size: 0xb6
function function_b8735762() {
    switch (randomintrange(0, 2)) {
    case 0:
        level.var_2fd26037 dialog::say("hend_wind_s_picking_up_0");
        break;
    case 1:
        level.var_2fd26037 dialog::say("hend_anchor_now_0");
        break;
    default:
        level.var_2fd26037 dialog::say("hend_use_your_anchor_0");
        break;
    }
}

// Namespace namespace_8b9f718f
// Params 0, eflags: 0x1 linked
// Checksum 0xbad15db2, Offset: 0x3390
// Size: 0x1f4
function function_b7f1a1f6() {
    level thread function_e774fcfd();
    level flag::wait_till("hendricks_debris_traversal_ready");
    level flag::wait_till("debris_path_one_ready");
    level thread scene::play("cin_bla_05_01_debristraversal_vign_useanchor_first_climb");
    level waittill(#"hash_6087df83");
    level function_e60704dd("debris_path_two_ready");
    level thread scene::play("cin_bla_05_01_debristraversal_vign_useanchor_second_climb");
    level waittill(#"hash_c52658cf");
    level function_e60704dd("debris_path_three_ready");
    str_scene = "cin_bla_05_01_debristraversal_vign_useanchor_splitpath_path_a_first";
    level thread scene::play(str_scene);
    level waittill(#"hash_6ec92f04");
    level function_e60704dd("debris_path_four_ready");
    str_scene = "cin_bla_05_01_debristraversal_vign_useanchor_splitpath_path_a_second";
    level thread scene::play(str_scene);
    level waittill(#"hash_9871d9f3");
    level function_e60704dd("debris_path_five_ready");
    level thread scene::play("cin_bla_05_01_debristraversal_vign_useanchor_end_climb");
    level waittill(#"hash_9871d9f3");
    level flag::set("allow_wind_gust");
    level.var_2fd26037 colors::enable();
}

// Namespace namespace_8b9f718f
// Params 1, eflags: 0x1 linked
// Checksum 0x749f2a0a, Offset: 0x3590
// Size: 0x8c
function function_e60704dd(var_530a613c) {
    level flag::set("end_gust_warning");
    level flag::wait_till(var_530a613c);
    wait(0.05);
    level flag::clear("allow_wind_gust");
    level flag::wait_till("kill_weather");
}

// Namespace namespace_8b9f718f
// Params 0, eflags: 0x1 linked
// Checksum 0xb8873eb0, Offset: 0x3628
// Size: 0xa4
function function_e774fcfd() {
    level flag::wait_till("debris_path_one_ready");
    if (!level flag::get("hendricks_anchor_close")) {
        level flag::set("allow_wind_gust");
        level flag::wait_till("hendricks_anchor_close");
        level flag::clear("allow_wind_gust");
    }
}

// Namespace namespace_8b9f718f
// Params 0, eflags: 0x1 linked
// Checksum 0x91e0047c, Offset: 0x36d8
// Size: 0x144
function function_21f63154() {
    scene::init("p7_fxanim_cp_blackstation_anchor_beginning_event_back_bundle");
    util::wait_network_frame();
    scene::init("p7_fxanim_cp_blackstation_anchor_beginning_event_left_bundle");
    util::wait_network_frame();
    level thread function_e3f6a644("left");
    scene::init("p7_fxanim_cp_blackstation_anchor_beginning_event_right_bundle");
    util::wait_network_frame();
    level thread function_e3f6a644("right");
    scene::init("p7_fxanim_cp_blackstation_anchor_beginning_car_debris_bundle");
    trigger::wait_till("trigger_hendricks_hotel_approach");
    level thread scene::play("p7_fxanim_cp_blackstation_anchor_beginning_event_back_bundle");
    trigger::wait_till("anchor_arch");
    level thread scene::play("p7_fxanim_cp_blackstation_anchor_beginning_car_debris_bundle");
}

// Namespace namespace_8b9f718f
// Params 1, eflags: 0x1 linked
// Checksum 0xc7d74ad2, Offset: 0x3828
// Size: 0xa4
function function_e3f6a644(str_side) {
    str_trigger_name = "anchor_fxanim_" + str_side;
    var_2818e4cc = getent(str_trigger_name, "targetname");
    var_2818e4cc endon(#"death");
    var_2818e4cc waittill(#"trigger");
    str_bundle = "p7_fxanim_cp_blackstation_anchor_beginning_event_" + str_side + "_bundle";
    scene::play(str_bundle);
}

// Namespace namespace_8b9f718f
// Params 0, eflags: 0x1 linked
// Checksum 0x69df8f81, Offset: 0x38d8
// Size: 0x3c
function function_925a5c0b() {
    level flag::wait_till("setup_hotel_blocker");
    level thread namespace_79e1cd97::function_70aaf37b(1);
}

// Namespace namespace_8b9f718f
// Params 1, eflags: 0x1 linked
// Checksum 0xf34764de, Offset: 0x3920
// Size: 0x2bc
function function_af475f02(var_f47b4e2b) {
    spawner::add_spawn_function_group("substation_enemy", "script_noteworthy", &function_ee4f2519);
    if (var_f47b4e2b) {
        level scene::init("p7_fxanim_cp_blackstation_missile_building_bundle");
        trigger::wait_till("trigger_hendricks_anchor_done");
        level scene::init("cin_bla_06_02_portassault_vign_roof_workers");
        level dialog::remote("kane_we_are_a_go_on_dro_0");
        level thread dialog::remote("dops_we_re_live_strike_i_0");
        trigger::wait_till("port_assault_start");
    } else {
        level scene::init("cin_bla_06_02_portassault_vign_roof_workers");
        level thread function_b0f369dc();
    }
    level thread scene::play("p7_fxanim_cp_blackstation_missile_building_bundle");
    trigger::use("hotel_wait");
    level waittill(#"hash_97e1a565");
    level thread function_eabab8e4();
    level dialog::remote("dops_negative_effect_inc_0");
    level.var_2fd26037 ai::set_ignoreall(1);
    if (!level flag::get("hotel_exit")) {
        level scene::add_scene_func("cin_bla_06_02_portassault_vign_drone_react", &function_84be5124);
        level scene::play("cin_bla_06_02_portassault_vign_drone_react");
    } else if (level scene::is_active("cin_bla_06_02_portassault_vign_drone_react")) {
        level scene::stop("cin_bla_06_02_portassault_vign_drone_react");
    }
    level thread namespace_4297372::function_91146001();
    level.var_2fd26037 ai::set_ignoreall(0);
    level flag::set("drone_strike");
}

// Namespace namespace_8b9f718f
// Params 0, eflags: 0x1 linked
// Checksum 0x717708d5, Offset: 0x3be8
// Size: 0xea
function function_eabab8e4() {
    var_c6dce143 = struct::get("objective_port_assault_ai");
    foreach (player in level.activeplayers) {
        if (distance2dsquared(player.origin, var_c6dce143.origin) <= 490000) {
            player playrumbleonentity("cp_blackstation_tanker_building_rumble");
        }
    }
}

// Namespace namespace_8b9f718f
// Params 1, eflags: 0x1 linked
// Checksum 0x4c94d2e3, Offset: 0x3ce0
// Size: 0x44
function function_84be5124(a_ents) {
    wait(1);
    level.var_2fd26037 colors::enable();
    trigger::use("triggercolor_drone_strike");
}

// Namespace namespace_8b9f718f
// Params 0, eflags: 0x1 linked
// Checksum 0x380f830, Offset: 0x3d30
// Size: 0x84
function function_b0f369dc() {
    var_fd585438 = getnode("anchor_end_wait", "targetname");
    level.var_2fd26037 setgoal(var_fd585438, 1);
    level.var_2fd26037 waittill(#"goal");
    level scene::init("cin_bla_06_02_portassault_vign_drone_react");
}

// Namespace namespace_8b9f718f
// Params 0, eflags: 0x0
// Checksum 0xf229ac55, Offset: 0x3dc0
// Size: 0x34
function function_9ba20f95() {
    level endon(#"hash_99060364");
    level thread namespace_79e1cd97::function_c2d8b452("lightning_port", "surge_done");
}

// Namespace namespace_8b9f718f
// Params 0, eflags: 0x1 linked
// Checksum 0xc2386656, Offset: 0x3e00
// Size: 0x6c
function function_17c457d7() {
    level scene::init("p7_fxanim_cp_blackstation_roof_vent_bundle");
    level waittill(#"hash_1718ca4b");
    level thread scene::play("cin_bla_06_02_portassault_vign_roof_workers");
    level scene::play("p7_fxanim_cp_blackstation_roof_vent_bundle");
}

// Namespace namespace_8b9f718f
// Params 1, eflags: 0x1 linked
// Checksum 0xc8ceb17, Offset: 0x3e78
// Size: 0xcc
function function_ee4f2519(str_dir) {
    self endon(#"death");
    self.var_284432c3 = 0;
    self thread namespace_23567e72::function_af8faf92();
    self ai::set_behavior_attribute("sprint", 1);
    self ai::set_ignoreme(1);
    self ai::set_ignoreall(1);
    self.goalradius = 1;
    self setgoal(self.origin);
    level waittill(#"hash_1718ca4b");
    self thread function_eb6b6084();
}

// Namespace namespace_8b9f718f
// Params 0, eflags: 0x1 linked
// Checksum 0x67ca62af, Offset: 0x3f50
// Size: 0x26c
function function_eb6b6084() {
    self endon(#"death");
    wait(randomfloatrange(0.3, 1));
    self ai::set_ignoreme(0);
    self ai::set_ignoreall(0);
    s_start = struct::get("retreat_pt1");
    var_9c34d7b = struct::get("retreat_pt2");
    s_end = struct::get("retreat_pt3");
    var_c3b4c42a = getent("vol_port_building", "targetname");
    self.goalradius = 2048;
    self setgoal(s_start.origin + (randomint(80), randomint(80), 0), 1);
    self waittill(#"goal");
    self setgoal(var_9c34d7b.origin + (randomint(80), randomint(80), 0), 1);
    self waittill(#"goal");
    self setgoal(s_end.origin + (randomint(120), randomint(120), 0), 1);
    self waittill(#"goal");
    self clearforcedgoal();
    self setgoal(var_c3b4c42a);
}

// Namespace namespace_8b9f718f
// Params 0, eflags: 0x1 linked
// Checksum 0x13074ddb, Offset: 0x41c8
// Size: 0x9c
function function_d66d3847() {
    trigger::wait_till("trigger_surge_debris1");
    var_8b856a66 = getent("surge_port_start", "script_noteworthy");
    var_64dd962c = getentarray("debris_surge_0", "targetname");
    level thread namespace_79e1cd97::function_3c57957(var_8b856a66, var_64dd962c, "start_barge");
}

// Namespace namespace_8b9f718f
// Params 0, eflags: 0x1 linked
// Checksum 0x1551fce2, Offset: 0x4270
// Size: 0x9c
function function_6cf315c1() {
    level flag::wait_till("start_barge");
    var_8b856a66 = getent("surge_port_restaurant", "script_noteworthy");
    while (level flag::get("surge_active")) {
        wait(0.05);
    }
    level thread namespace_79e1cd97::function_3c57957(var_8b856a66, undefined, "end_surge_rest");
}

// Namespace namespace_8b9f718f
// Params 1, eflags: 0x1 linked
// Checksum 0xf752d68b, Offset: 0x4318
// Size: 0x13c
function function_5fc4b0f9(var_74cd64bc) {
    if (!isdefined(var_74cd64bc)) {
        var_74cd64bc = 0;
    }
    var_8b856a66 = getent("surge_port_authority", "script_noteworthy");
    var_ef0ea28e = getentarray("wharf_debris", "script_noteworthy");
    foreach (e_cover in var_ef0ea28e) {
        e_cover thread namespace_79e1cd97::function_98c7a42();
    }
    level thread namespace_79e1cd97::function_3c57957(var_8b856a66, var_ef0ea28e, "barge_breach_cleared");
    if (!var_74cd64bc) {
        level thread function_d37a023d();
    }
}

// Namespace namespace_8b9f718f
// Params 0, eflags: 0x1 linked
// Checksum 0xfa0e5036, Offset: 0x4460
// Size: 0x2cc
function function_d37a023d() {
    level endon(#"hash_f2113aa5");
    var_4beb42a4 = [];
    var_c891e2e5 = getnode("covernode_surge_1", "script_noteworthy");
    var_ee945d4e = getnode("covernode_surge_2", "script_noteworthy");
    if (!isdefined(var_4beb42a4)) {
        var_4beb42a4 = [];
    } else if (!isarray(var_4beb42a4)) {
        var_4beb42a4 = array(var_4beb42a4);
    }
    var_4beb42a4[var_4beb42a4.size] = var_ee945d4e;
    var_1496d7b7 = getnode("covernode_surge_3", "script_noteworthy");
    if (!isdefined(var_4beb42a4)) {
        var_4beb42a4 = [];
    } else if (!isarray(var_4beb42a4)) {
        var_4beb42a4 = array(var_4beb42a4);
    }
    var_4beb42a4[var_4beb42a4.size] = var_1496d7b7;
    var_a857ed8 = getnode("covernode_surge_4", "script_noteworthy");
    if (!isdefined(var_4beb42a4)) {
        var_4beb42a4 = [];
    } else if (!isarray(var_4beb42a4)) {
        var_4beb42a4 = array(var_4beb42a4);
    }
    var_4beb42a4[var_4beb42a4.size] = var_a857ed8;
    foreach (var_974cc07 in var_4beb42a4) {
        setenablenode(var_974cc07, 0);
    }
    function_41eafef6(var_ee945d4e, var_c891e2e5, "triggercolor_port_cover2");
    function_41eafef6(var_1496d7b7, var_ee945d4e, "triggercolor_port_cover3");
    function_41eafef6(var_a857ed8, var_1496d7b7, "triggercolor_port_cover4");
}

// Namespace namespace_8b9f718f
// Params 3, eflags: 0x1 linked
// Checksum 0x519fa99b, Offset: 0x4738
// Size: 0xac
function function_41eafef6(var_4b32b0bd, var_64fcc6c4, var_72001283) {
    level flag::wait_till("cover_switch");
    setenablenode(var_4b32b0bd, 1);
    wait(0.1);
    trigger::use(var_72001283);
    setenablenode(var_64fcc6c4, 0);
    level flag::clear("cover_switch");
}

// Namespace namespace_8b9f718f
// Params 0, eflags: 0x1 linked
// Checksum 0xd987d920, Offset: 0x47f0
// Size: 0x1ec
function function_8ff7652d() {
    trigger::wait_till("trigger_port_sniper");
    level flag::set("end_surge_rest");
    level thread function_83fc27b8();
    spawn_manager::enable("sm_pa_sniper");
    trigger::wait_till("trigger_port_building", "script_noteworthy");
    level thread function_5fc4b0f9();
    level thread function_a5f89f57();
    level thread function_7ef21283();
    level thread function_9e33130c();
    spawn_manager::enable("sm_port_authority");
    wait(3);
    spawn_manager::enable("sm_rooftop_suppressor");
    if (level.players.size > 1) {
        spawn_manager::wait_till_cleared("sm_pa_sniper");
    }
    level flag::set("swept_away");
    spawn_manager::wait_till_cleared("sm_rooftop_suppressor");
    spawn_manager::function_27bf2e8("sm_port_authority", 3);
    trigger::use("trigger_truck_port", "targetname", undefined, 0);
    wait(4);
    level flag::set("enter_port");
}

// Namespace namespace_8b9f718f
// Params 0, eflags: 0x1 linked
// Checksum 0xf73a8777, Offset: 0x49e8
// Size: 0x3c
function function_9e33130c() {
    level flag::wait_till("swept_away");
    spawner::simple_spawn("port_authority_swept");
}

// Namespace namespace_8b9f718f
// Params 0, eflags: 0x1 linked
// Checksum 0x86efdc37, Offset: 0x4a30
// Size: 0xda
function function_83fc27b8() {
    var_746111be = util::spawn_model("tag_origin");
    var_746111be.targetname = "wind_target";
    var_746111be.script_objective = "objective_barge_assault";
    var_746111be endon(#"death");
    a_s_targets = struct::get_array("wind_target");
    while (true) {
        s_target = a_s_targets[randomint(a_s_targets.size)];
        var_746111be.origin = s_target.origin;
        wait(2);
    }
}

// Namespace namespace_8b9f718f
// Params 0, eflags: 0x1 linked
// Checksum 0x1ccd35b3, Offset: 0x4b18
// Size: 0x24
function function_f3d4c95b() {
    self endon(#"death");
    self.grenadeammo = 0;
    self.var_284432c3 = 0;
}

// Namespace namespace_8b9f718f
// Params 0, eflags: 0x1 linked
// Checksum 0xbe17680e, Offset: 0x4b48
// Size: 0x64
function function_6a0ccfd() {
    var_92f29fd5 = getweapon("launcher_guided_blackstation_ai");
    self ai::gun_switchto(var_92f29fd5, "right");
    self thread namespace_79e1cd97::function_ef275fb3();
}

// Namespace namespace_8b9f718f
// Params 0, eflags: 0x1 linked
// Checksum 0x6432843f, Offset: 0x4bb8
// Size: 0x3c
function function_a5f89f57() {
    level flag::wait_till("enter_port");
    trigger::use("triggercolor_port_building");
}

// Namespace namespace_8b9f718f
// Params 0, eflags: 0x1 linked
// Checksum 0x6f74cd12, Offset: 0x4c00
// Size: 0x8c
function function_e00d64fc() {
    trigger::wait_till("trigger_truck_port");
    var_45900c37 = vehicle::simple_spawn_single("port_assault_tech");
    nd_start = getvehiclenode(var_45900c37.target, "targetname");
    var_45900c37 thread vehicle::get_on_and_go_path(nd_start);
}

// Namespace namespace_8b9f718f
// Params 0, eflags: 0x1 linked
// Checksum 0x8b64cc48, Offset: 0x4c98
// Size: 0x64
function function_7ef21283() {
    trigger::wait_till("trigger_port_interior");
    spawner::add_spawn_function_group("port_interior", "targetname", &function_da7b81a5);
    spawn_manager::enable("sm_port_interior");
}

// Namespace namespace_8b9f718f
// Params 0, eflags: 0x1 linked
// Checksum 0x60aaf0dd, Offset: 0x4d08
// Size: 0x116
function function_da7b81a5() {
    self endon(#"death");
    trigger::wait_till("trigger_port_advance");
    while (true) {
        e_target = util::get_closest_player(self.origin, "allies");
        v_player_pos = getclosestpointonnavmesh(e_target.origin, 82, 32);
        if (isdefined(v_player_pos)) {
            a_v_points = util::positionquery_pointarray(v_player_pos, self.engagemindist, self.engagemaxdist, 70, 40, self);
            if (a_v_points.size > 0) {
                self setgoal(array::random(a_v_points), 1);
            }
        }
        wait(3);
    }
}

// Namespace namespace_8b9f718f
// Params 0, eflags: 0x1 linked
// Checksum 0x80c5590, Offset: 0x4e28
// Size: 0x3c
function function_3e1b1aaa() {
    level endon(#"hash_9bfd16b7");
    level waittill(#"hash_81a3b4e0");
    level.var_2fd26037 dialog::say("hend_waves_hitting_now_0");
}

// Namespace namespace_8b9f718f
// Params 0, eflags: 0x1 linked
// Checksum 0x31ba2012, Offset: 0x4e70
// Size: 0x9c
function function_3916ca15() {
    level endon(#"hash_b36ffbd");
    var_83067764 = getent("bs_dock_tugboat", "targetname");
    var_83067764 function_c5ca9512();
    level thread function_f8ff4031();
    level thread scene::play("p7_fxanim_cp_blackstation_barge_idle_storm_bundle");
    var_83067764 thread function_a56a2ed2();
}

// Namespace namespace_8b9f718f
// Params 0, eflags: 0x1 linked
// Checksum 0x81212ba5, Offset: 0x4f18
// Size: 0x7e4
function function_c5ca9512() {
    var_b9264a5 = getnode("deck_traversal", "targetname");
    linktraversal(var_b9264a5);
    s_align = struct::get("tag_align_hendricks_barge");
    var_197f1988 = util::spawn_model("tag_origin", s_align.origin, s_align.angles);
    var_197f1988.targetname = "barge_align";
    var_197f1988.script_objective = "objective_storm_surge";
    var_197f1988 linkto(self);
    var_13335379 = getentarray("barge_trigger", "script_noteworthy");
    foreach (trigger in var_13335379) {
        trigger enablelinkto();
        trigger linkto(self);
    }
    e_fx = getent("barge_wave_fx", "targetname");
    e_fx linkto(self);
    var_d5005d3f = getent("barge_container_door_left", "targetname");
    var_d5005d3f rotateto((0, -5, 0), 0.05);
    var_d5005d3f waittill(#"rotatedone");
    var_d5005d3f linkto(self);
    var_d9350cda = getent("barge_container_door_right", "targetname");
    var_d9350cda rotateto((0, 5, 0), 0.05);
    var_d9350cda waittill(#"rotatedone");
    var_d9350cda linkto(self);
    var_30f598ff = getentarray("barge_ents", "script_noteworthy");
    foreach (var_541ddd5c in var_30f598ff) {
        var_541ddd5c linkto(self);
    }
    var_cf82ed09 = getentarray("player_breach_trigger", "script_noteworthy");
    level.var_5b610bbd = [];
    foreach (trigger in var_cf82ed09) {
        n_index = int(trigger.script_float) - 1;
        var_7345ca74 = getent(trigger.target, "targetname");
        e_player_link = getent(var_7345ca74.target, "targetname");
        trigger enablelinkto();
        trigger linkto(self);
        level.var_5b610bbd[n_index] = util::function_14518e76(trigger, %cp_level_blackstation_interact_breach, %CP_MI_SING_BLACKSTATION_BREACH, &function_f686643b);
        level.var_5b610bbd[n_index] function_173b4bfe();
        level.var_5b610bbd[n_index] thread function_307c2864();
        level.var_5b610bbd[n_index].target = trigger.targetname;
        level.var_5b610bbd[n_index] linkto(self);
        var_7345ca74 linkto(self);
        e_player_link linkto(self);
    }
    var_52a2c714 = getentarray("barge_lights", "targetname");
    foreach (light in var_52a2c714) {
        light linkto(self);
    }
    var_70eb06cf = getnodearray("wheelhouse_node", "script_noteworthy");
    foreach (var_16758b6f in var_70eb06cf) {
        setenablenode(var_16758b6f, 0);
    }
    playfxontag(level._effect["barge_sheeting"], self, "tag_wheelhouse_fxanim_jnt");
    level thread function_8dc0d020();
    array::thread_all(level.activeplayers, &function_b3d8d3f5);
}

// Namespace namespace_8b9f718f
// Params 0, eflags: 0x1 linked
// Checksum 0x4de34abd, Offset: 0x5708
// Size: 0x15c
function function_b3d8d3f5() {
    self notify(#"hash_ec691523");
    self endon(#"hash_ec691523");
    level endon(#"hash_9bfd16b7");
    self endon(#"death");
    var_83067764 = getent("bs_dock_tugboat", "targetname");
    var_83067764 endon(#"death");
    var_7a15f6e6 = getent("barge_ground_ref", "targetname");
    var_7a15f6e6 endon(#"death");
    while (true) {
        if (self istouching(var_7a15f6e6) && !self.var_20aea9e5) {
            self.var_20aea9e5 = 1;
            self playersetgroundreferenceent(var_83067764);
        } else if (!self istouching(var_7a15f6e6) && self.var_20aea9e5) {
            self playersetgroundreferenceent(undefined);
            self.var_20aea9e5 = 0;
        }
        wait(0.05);
    }
}

// Namespace namespace_8b9f718f
// Params 0, eflags: 0x1 linked
// Checksum 0x21c62b8, Offset: 0x5870
// Size: 0x54
function function_f8ff4031() {
    level scene::init("p7_fxanim_cp_blackstation_pier_event_01_bundle");
    util::wait_network_frame();
    level scene::init("p7_fxanim_cp_blackstation_pier_event_03_bundle");
}

// Namespace namespace_8b9f718f
// Params 0, eflags: 0x1 linked
// Checksum 0x958218f2, Offset: 0x58d0
// Size: 0x7c
function function_a56a2ed2() {
    v_ang = self.angles;
    v_org = self.origin;
    level flag::wait_till("tanker_smash");
    level notify(#"hash_b36ffbd");
    wait(1);
    level flag::set("tanker_face");
}

// Namespace namespace_8b9f718f
// Params 0, eflags: 0x1 linked
// Checksum 0xb9c5ab8a, Offset: 0x5958
// Size: 0x1c
function function_6bb14aef() {
    level thread function_36dfb0a2();
}

// Namespace namespace_8b9f718f
// Params 1, eflags: 0x1 linked
// Checksum 0x7e704b0f, Offset: 0x5980
// Size: 0x2cc
function function_ec409848(var_6e2f783e) {
    if (!isdefined(var_6e2f783e)) {
        var_6e2f783e = 0;
    }
    var_f4520dcf = getnode("container_node", "targetname");
    level thread function_42df2efb();
    level thread function_d091f076();
    wait(1);
    spawn_manager::wait_till_cleared("sm_barge");
    spawn_manager::wait_till_cleared("sm_barge_cqb");
    level thread function_2a6c042b();
    objectives::complete("cp_level_blackstation_board_ship");
    level dialog::function_13b3b16a("plyr_all_clear_0");
    level flag::wait_till("hendricks_on_barge");
    level.var_2fd26037 setgoal(var_f4520dcf);
    wait(2);
    level dialog::function_13b3b16a("plyr_kane_we_ve_reached_0");
    level dialog::remote("kane_interface_with_the_p_0");
    level.var_2fd26037 dialog::say("hend_you_can_do_that_0");
    level dialog::remote("kane_your_dni_is_connecte_0");
    level function_d1996775();
    level dialog::remote("kane_files_secured_and_re_0");
    level notify(#"hash_4561e3f");
    trigger::use("hendricks_breach");
    level dialog::remote("kane_storm_s_getting_wors_0", 0.1);
    level dialog::function_13b3b16a("plyr_got_it_thanks_kane_0");
    level thread namespace_4297372::function_973b77f9();
    level.var_2fd26037 dialog::say("hend_i_ll_take_the_upper_0");
    level thread function_77531405();
    level thread function_3483fad0();
}

// Namespace namespace_8b9f718f
// Params 0, eflags: 0x1 linked
// Checksum 0x545e27a3, Offset: 0x5c58
// Size: 0xd2
function function_2a6c042b() {
    a_ai_enemies = getaiteamarray("axis");
    foreach (ai_enemy in a_ai_enemies) {
        if (isalive(ai_enemy)) {
            ai_enemy kill();
        }
        util::wait_network_frame();
    }
}

// Namespace namespace_8b9f718f
// Params 0, eflags: 0x1 linked
// Checksum 0xf8171a59, Offset: 0x5d38
// Size: 0x1a2
function function_d091f076() {
    spawn_manager::function_27bf2e8("sm_barge", 2);
    spawn_manager::function_27bf2e8("sm_barge_cqb", 2);
    var_a6abef8a = arraycombine(spawn_manager::function_423eae50("sm_barge"), spawn_manager::function_423eae50("sm_barge_cqb"), 0, 0);
    foreach (var_8d4ec191 in var_a6abef8a) {
        var_8d4ec191 setgoal(getent("vol_center", "targetname"), 1, 16);
        var_8d4ec191 util::delay(randomintrange(15, 18), undefined, &ai::bloody_death, randomintrange(5, 15), "neck");
    }
}

// Namespace namespace_8b9f718f
// Params 0, eflags: 0x1 linked
// Checksum 0xa0b6e11a, Offset: 0x5ee8
// Size: 0x190
function function_d1996775() {
    level thread function_5edd0266();
    level flag::set("container_console_active");
    var_83067764 = getent("bs_dock_tugboat", "targetname");
    t_use = getent("container_hack", "targetname");
    var_376507c0 = %cp_hacking_console;
    str_hint = %CP_MI_SING_BLACKSTATION_CONSOLE_HACK;
    mdl_gameobject = t_use hacking::function_68df65d8(6, var_376507c0, str_hint, undefined, undefined, var_83067764);
    mdl_gameobject.dontlinkplayertotrigger = 1;
    mdl_gameobject.target = t_use.targetname;
    mdl_gameobject linkto(var_83067764);
    t_use hacking::trigger_wait();
    t_use triggerenable(0);
    if (isdefined(level.var_2acebcf0)) {
        level thread [[ level.var_2acebcf0 ]]();
    }
}

// Namespace namespace_8b9f718f
// Params 0, eflags: 0x1 linked
// Checksum 0x32b38acb, Offset: 0x6080
// Size: 0x154
function function_5edd0266() {
    level.hacking flag::wait_till("in_progress");
    getent("barge_monitor_on", "targetname") delete();
    getent("barge_monitor_glitch_1", "targetname") show();
    wait(1.5);
    getent("barge_monitor_glitch_1", "targetname") delete();
    getent("barge_monitor_glitch_2", "targetname") show();
    wait(1.5);
    getent("barge_monitor_glitch_2", "targetname") delete();
    getent("barge_monitor_off", "targetname") show();
}

// Namespace namespace_8b9f718f
// Params 0, eflags: 0x1 linked
// Checksum 0xfa5c2f06, Offset: 0x61e0
// Size: 0x4c
function function_42df2efb() {
    trigger::wait_till("barge_ground_ref");
    spawn_manager::kill("sm_barge");
    spawn_manager::kill("sm_barge_cqb");
}

// Namespace namespace_8b9f718f
// Params 1, eflags: 0x1 linked
// Checksum 0xc3d13c3e, Offset: 0x6238
// Size: 0x20c
function function_3483fad0(var_74cd64bc) {
    if (!isdefined(var_74cd64bc)) {
        var_74cd64bc = 0;
    }
    objectives::set("cp_level_blackstation_wheelhouse");
    var_70eb06cf = getnodearray("wheelhouse_node", "script_noteworthy");
    foreach (var_16758b6f in var_70eb06cf) {
        setenablenode(var_16758b6f, 1);
    }
    if (!var_74cd64bc) {
        savegame::checkpoint_save();
    }
    level flag::wait_till("all_players_spawned");
    foreach (player in level.activeplayers) {
        function_ad89287b();
    }
    callback::on_spawned(&function_ad89287b);
    callback::on_disconnect(&function_b5455e18);
    level flag::set("breach_active");
}

// Namespace namespace_8b9f718f
// Params 1, eflags: 0x1 linked
// Checksum 0x3600a4ae, Offset: 0x6450
// Size: 0x118
function function_f686643b(e_player) {
    self.trigger endon(#"death");
    level endon(#"hash_e1526d21");
    e_player namespace_79e1cd97::function_ed7faf05();
    e_player.var_d6f82ae7 = self.trigger.script_float;
    str_bundle = "cin_bla_06_06_portassault_position0" + e_player.var_d6f82ae7 + "_breach";
    e_player thread scene::init(str_bundle, e_player);
    self gameobjects::disable_object(1);
    self.b_disabled = 1;
    if (level.var_467c7a9c + 1 == level.activeplayers.size) {
        wait(0.5);
    }
    level.var_467c7a9c++;
    e_player waittill(#"disconnect");
    level.var_467c7a9c--;
    self.var_ff712655 = 0;
}

// Namespace namespace_8b9f718f
// Params 0, eflags: 0x1 linked
// Checksum 0x182a88c7, Offset: 0x6570
// Size: 0x70
function function_ad89287b() {
    for (x = 0; x < level.var_5b610bbd.size; x++) {
        if (!level.var_5b610bbd[x].var_ff712655) {
            level.var_5b610bbd[x] function_13dde3bd();
            return;
        }
    }
}

// Namespace namespace_8b9f718f
// Params 0, eflags: 0x1 linked
// Checksum 0xacbbc79b, Offset: 0x65e8
// Size: 0x80
function function_b5455e18() {
    if (!isdefined(self.var_d6f82ae7)) {
        for (x = level.var_5b610bbd.size - 1; x >= 0; x--) {
            if (!level.var_5b610bbd[x].b_disabled) {
                level.var_5b610bbd[x] function_173b4bfe();
                return;
            }
        }
    }
}

// Namespace namespace_8b9f718f
// Params 0, eflags: 0x1 linked
// Checksum 0xf3448743, Offset: 0x6670
// Size: 0x34
function function_13dde3bd() {
    self gameobjects::enable_object(1);
    self.var_ff712655 = 1;
    self.b_disabled = 0;
}

// Namespace namespace_8b9f718f
// Params 0, eflags: 0x1 linked
// Checksum 0x45d3494a, Offset: 0x66b0
// Size: 0x34
function function_173b4bfe() {
    self gameobjects::disable_object(1);
    self.var_ff712655 = 0;
    self.b_disabled = 1;
}

// Namespace namespace_8b9f718f
// Params 0, eflags: 0x1 linked
// Checksum 0x33cb5544, Offset: 0x66f0
// Size: 0x2c
function function_307c2864() {
    level waittill(#"hash_e1526d21");
    self gameobjects::destroy_object(1, 1);
}

// Namespace namespace_8b9f718f
// Params 0, eflags: 0x0
// Checksum 0x73849d6c, Offset: 0x6728
// Size: 0x126
function function_7c39aa7b() {
    level endon(#"hash_e1526d21");
    self waittill(#"death");
    n_base = level.players.size + 1;
    for (x = n_base; x <= 4; x++) {
        var_e48342b = getent("breach_player_" + x, "targetname");
        if (isdefined(var_e48342b)) {
            level flag::set(var_e48342b.script_flag_set);
            var_7345ca74 = getent(var_e48342b.target, "targetname");
            var_7345ca74 delete();
            var_e48342b delete();
        }
    }
}

// Namespace namespace_8b9f718f
// Params 0, eflags: 0x1 linked
// Checksum 0xbdea3898, Offset: 0x6858
// Size: 0x34
function function_77531405() {
    level endon(#"hash_e1526d21");
    wait(15);
    level.var_2fd26037 dialog::say("hend_get_ready_stack_up_0");
}

// Namespace namespace_8b9f718f
// Params 0, eflags: 0x1 linked
// Checksum 0x1a67f1df, Offset: 0x6898
// Size: 0x54c
function function_8dc0d020() {
    e_align = getent("barge_align", "targetname");
    var_fbbc4fa6 = getent("barge_wheelhouse", "targetname");
    var_3d8da684 = getent("dock_assault_tanker", "targetname");
    level thread scene::init("p7_fxanim_cp_blackstation_barge_roof_break_bundle");
    function_a3eced7();
    setdvar("phys_gravity_dir", (0, 0, 1));
    var_fbbc4fa6 delete();
    level notify(#"hash_e1526d21");
    level flag::set("breached");
    level thread function_9a8b2deb();
    var_3d8da684 delete();
    spawner::add_spawn_function_group("wheelhouse_target1", "targetname", &function_69d65c98, 0);
    spawner::add_spawn_function_group("wheelhouse_target2", "targetname", &function_69d65c98, 0);
    spawner::add_spawn_function_group("wheelhouse_target3", "targetname", &function_69d65c98, 0);
    spawner::add_spawn_function_group("wheelhouse_enemy", "targetname", &function_69d65c98, 1);
    spawn_manager::enable("sm_wheelhouse");
    wait(0.1);
    var_1dda34f0 = getent("barge_door_rt", "targetname");
    var_1dda34f0 thread function_dd6beda2("right");
    var_55174cd2 = getent("barge_door_lt", "targetname");
    var_55174cd2 thread function_dd6beda2("left");
    var_1dda34f0 playsound("fxa_door_breach_r");
    var_55174cd2 playsound("fxa_door_breach_l");
    wait(0.2);
    exploder::exploder_stop("barge_destroy_lgt");
    exploder::exploder("barge_destroy_interior_lgt");
    level thread breach_slow_time();
    level.var_2fd26037 thread function_e7b216fb();
    foreach (player in level.activeplayers) {
        player thread function_f3ea3cc7();
        player thread player::fill_current_clip();
    }
    if (isdefined(level.var_cb28e353)) {
        level thread [[ level.var_cb28e353 ]]();
    }
    level scene::play("cin_bla_06_06_portassault_1st_breach_pound_react");
    var_d53fdaad = getentarray("barge_hurt_trigger", "targetname");
    array::run_all(var_d53fdaad, &delete);
    spawner::waittill_ai_group_ai_count("group_wheelhouse", 0);
    spawner::waittill_ai_group_ai_count("group_wheelhouse_backup", 0);
    if (isdefined(level.var_c4dba52c)) {
        [[ level.var_c4dba52c ]]();
    }
    level flag::set("barge_breach_cleared");
    objectives::complete("cp_level_blackstation_wheelhouse");
    objectives::complete("cp_level_blackstation_intercept");
    level flag::set("tanker_smash");
}

// Namespace namespace_8b9f718f
// Params 0, eflags: 0x1 linked
// Checksum 0x9a10bd41, Offset: 0x6df0
// Size: 0xa4
function function_a3eced7() {
    level.var_467c7a9c = 0;
    level flag::wait_till("all_players_spawned");
    while (level.var_467c7a9c < level.activeplayers.size || level.activeplayers.size == 0) {
        wait(0.05);
    }
    callback::remove_on_spawned(&function_ad89287b);
    callback::remove_on_disconnect(&function_b5455e18);
}

// Namespace namespace_8b9f718f
// Params 0, eflags: 0x1 linked
// Checksum 0x82d3ace3, Offset: 0x6ea0
// Size: 0xbc
function function_e7b216fb() {
    self ai::set_ignoreall(1);
    level waittill(#"hash_f7949f45");
    level thread scene::play("cin_bla_06_06_portassault_1st_breach_hendricks_concussive");
    level waittill(#"hash_3a30e06");
    trigger::use("hendricks_wheelhouse");
    playsoundatposition("evt_breachassault_concussive_walla", self.origin);
    self function_9ba0286c();
    self ai::set_ignoreall(0);
}

// Namespace namespace_8b9f718f
// Params 0, eflags: 0x1 linked
// Checksum 0x5c9e78a9, Offset: 0x6f68
// Size: 0x1b2
function function_9ba0286c() {
    a_ai_enemies = arraycombine(getaispeciesarray("axis", "all"), getaispeciesarray("team3", "all"), 0, 0);
    self.cybercom = spawnstruct();
    self.cybercom.var_e6fa6e38 = -106;
    self.cybercom.var_4e92078e = 5;
    level thread namespace_687c8387::function_ffd5ab29(100, level.var_2fd26037);
    if (isdefined(a_ai_enemies) && a_ai_enemies.size) {
        foreach (enemy in a_ai_enemies) {
            if (!isdefined(enemy) || !isdefined(enemy.origin)) {
                continue;
            }
            if (!(isdefined(enemy.var_915fc074) && enemy.var_915fc074)) {
                enemy thread function_b53bbcfb();
            }
        }
    }
}

// Namespace namespace_8b9f718f
// Params 2, eflags: 0x1 linked
// Checksum 0xc8143275, Offset: 0x7128
// Size: 0x12c
function function_797ee2de(v_direction, str_tag) {
    self endon(#"hash_50daddc6");
    while (!isdefined(v_direction)) {
        n_damage, e_attacker, v_direction, v_point, str_type, str_tag, str_model, str_part, str_weapon = self waittill(#"damage");
    }
    if (!level flag::get("slow_mo_finished")) {
        self startragdoll();
        self launchragdoll(100 * vectornormalize(self.origin - e_attacker.origin), str_tag);
        wait(0.05);
        self kill();
    }
}

// Namespace namespace_8b9f718f
// Params 0, eflags: 0x1 linked
// Checksum 0x1cac254f, Offset: 0x7260
// Size: 0x84
function function_b53bbcfb() {
    self endon(#"death");
    self notify(#"hash_50daddc6");
    self playsound("gdt_concussivewave_imp_human");
    self scene::play("cin_gen_xplode_death_" + randomintrange(1, 4), self);
    self kill();
}

// Namespace namespace_8b9f718f
// Params 0, eflags: 0x1 linked
// Checksum 0x55f15e0a, Offset: 0x72f0
// Size: 0x234
function function_f3ea3cc7() {
    self endon(#"death");
    var_1c175d5c = getent("bs_dock_tugboat", "targetname");
    if (isdefined(self.var_d6f82ae7)) {
        switch (int(self.var_d6f82ae7)) {
        case 1:
            var_8f33cbc7 = 15;
            var_ecd1354e = 65;
            break;
        case 2:
            var_8f33cbc7 = 65;
            var_ecd1354e = 15;
            break;
        case 3:
            var_8f33cbc7 = 35;
            var_ecd1354e = 35;
            break;
        case 4:
            var_8f33cbc7 = 30;
            var_ecd1354e = 45;
            break;
        default:
            var_8f33cbc7 = 45;
            var_ecd1354e = 45;
            break;
        }
    }
    self.w_current = self getcurrentweapon();
    if (!weapons::is_primary_weapon(self.w_current) && self.w_current != getweapon("micromissile_launcher")) {
        self player::switch_to_primary_weapon(1);
    }
    if (isdefined(self.var_d6f82ae7)) {
        str_bundle = "cin_bla_06_06_portassault_position0" + self.var_d6f82ae7 + "_breach";
    }
    if (isdefined(str_bundle)) {
        self scene::play(str_bundle, self);
    }
    level notify(#"hash_4f70b2fc");
    self allowsprint(0);
    self allowjump(0);
}

// Namespace namespace_8b9f718f
// Params 1, eflags: 0x1 linked
// Checksum 0xbe0a63e7, Offset: 0x7530
// Size: 0x154
function function_dd6beda2(str_side) {
    var_dfd3f00d = util::spawn_model(self.model, self.origin, self.angles);
    self hide();
    if (str_side == "left") {
        var_dfd3f00d movey(96 * -1, 0.3);
        var_dfd3f00d waittill(#"movedone");
        var_dfd3f00d delete();
        level waittill(#"hash_ac9ddf0");
        self show();
        return;
    }
    var_dfd3f00d movey(96, 0.3);
    var_dfd3f00d waittill(#"movedone");
    var_dfd3f00d delete();
    level waittill(#"hash_ac9ddf0");
    self show();
}

// Namespace namespace_8b9f718f
// Params 1, eflags: 0x1 linked
// Checksum 0x5d7be801, Offset: 0x7690
// Size: 0xdc
function function_69d65c98(var_98c3e352) {
    self endon(#"death");
    self thread ai::set_behavior_attribute("useGrenades", 0);
    self.var_915fc074 = var_98c3e352;
    self.allowpain = 0;
    self.dontdropweapon = 1;
    self thread function_797ee2de();
    self ai::set_ignoreall(1);
    self.goalradius = 1;
    self.groundrelativepose = 1;
    self.overrideactordamage = &function_4a2ffb52;
    level waittill(#"hash_4f70b2fc");
    wait(0.05);
    self ai::set_ignoreall(0);
}

// Namespace namespace_8b9f718f
// Params 12, eflags: 0x1 linked
// Checksum 0xc2fb6228, Offset: 0x7778
// Size: 0xbc
function function_4a2ffb52(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex, modelindex) {
    if (isdefined(weapon) && isdefined(weapon.rootweapon) && weapon.rootweapon == getweapon("ar_accurate")) {
        idamage *= 2;
    }
    return idamage;
}

// Namespace namespace_8b9f718f
// Params 0, eflags: 0x1 linked
// Checksum 0xcc95f4d, Offset: 0x7840
// Size: 0x12c
function breach_slow_time() {
    level endon(#"hash_ba8f6561");
    level waittill(#"hash_4f70b2fc");
    level thread namespace_4297372::function_a339da70();
    setslowmotion(1, 0.3, 0.3);
    foreach (player in level.players) {
        player setmovespeedscale(0.3);
    }
    level thread function_c1dce6c0(0.3, 1, 0.3);
}

// Namespace namespace_8b9f718f
// Params 3, eflags: 0x1 linked
// Checksum 0x890ba33e, Offset: 0x7978
// Size: 0x122
function function_c1dce6c0(var_bce6643, var_f1be99bb, n_time) {
    util::waittill_any_timeout(4, "barge_breach_cleared");
    level flag::set("slow_mo_finished");
    level thread namespace_4297372::function_69fc18eb();
    setslowmotion(var_bce6643, var_f1be99bb, n_time);
    foreach (player in level.players) {
        player setmovespeedscale(var_f1be99bb);
    }
}

// Namespace namespace_8b9f718f
// Params 0, eflags: 0x1 linked
// Checksum 0x91aa132f, Offset: 0x7aa8
// Size: 0x10c
function function_b28ad6d2() {
    trigger::wait_till("trigger_port_sniper");
    wait(2);
    if (level.players.size > 1) {
        level.var_2fd26037 dialog::say("hend_snipers_3_o_clock_0");
    }
    level.var_2fd26037 dialog::say("hend_if_you_ve_got_any_ro_0", 0.5);
    level dialog::function_13b3b16a("plyr_copy_that_hendricks_1", 0.7);
    array::thread_all(level.activeplayers, &coop::function_e9f7384d);
    level flag::wait_till("exit_wharf");
    level.var_2fd26037 dialog::say("hend_storm_s_getting_wors_0");
}

// Namespace namespace_8b9f718f
// Params 0, eflags: 0x1 linked
// Checksum 0x8ace696b, Offset: 0x7bc0
// Size: 0xf4
function function_2124978a() {
    level thread function_c5a827ee();
    trigger::wait_till("hendricks_hurry");
    objectives::set("cp_level_blackstation_board_ship");
    level thread scene::play("p7_fxanim_cp_blackstation_pier_event_01_bundle");
    wait(0.1);
    if (scene::is_active("cin_bla_06_04_portassault_vign_react")) {
        level scene::play("cin_bla_06_04_portassault_vign_react");
        level.var_2fd26037 dialog::say("hend_visibility_s_getting_0");
        return;
    }
    level.var_2fd26037 dialog::say("hend_visibility_s_getting_0");
}

// Namespace namespace_8b9f718f
// Params 0, eflags: 0x1 linked
// Checksum 0xbc5cc436, Offset: 0x7cc0
// Size: 0x7c
function function_c5a827ee() {
    level endon(#"hash_90702351");
    if (!level flag::get("hendricks_hurry")) {
        level flag::wait_till("surge_done");
        level.var_2fd26037 waittill(#"goal");
        level scene::init("cin_bla_06_04_portassault_vign_react");
    }
}

// Namespace namespace_8b9f718f
// Params 0, eflags: 0x1 linked
// Checksum 0x6d1361d6, Offset: 0x7d48
// Size: 0x1dc
function function_36dfb0a2() {
    s_wave = struct::get("wave_technical", "script_noteworthy");
    var_32cdba86 = getent("temp_pier_wave", "targetname");
    var_59ed1f41 = getent(var_32cdba86.target, "targetname");
    var_32cdba86 ghost();
    level waittill(#"hash_293c72b4");
    var_59ed1f41 thread namespace_79e1cd97::function_e5633001();
    var_32cdba86.origin = s_wave.origin;
    var_32cdba86.angles = s_wave.angles;
    var_32cdba86 moveto(var_32cdba86.origin + (0, 0, 150), 0.1);
    var_32cdba86 waittill(#"movedone");
    var_32cdba86 moveto(var_32cdba86.origin + (-450, 0, 0), 2);
    var_32cdba86 thread namespace_79e1cd97::function_4083c129();
    var_32cdba86 waittill(#"movedone");
    var_32cdba86 moveto(var_32cdba86.origin + (0, 0, -150), 0.1);
}

// Namespace namespace_8b9f718f
// Params 0, eflags: 0x1 linked
// Checksum 0x6dbb58dd, Offset: 0x7f30
// Size: 0x104
function function_17894e22() {
    self endon(#"death");
    self turret::enable(1, 1);
    self waittill(#"reached_end_node");
    self thread namespace_79e1cd97::function_fae23684("passenger1");
    self thread namespace_79e1cd97::function_fae23684("driver");
    while (isdefined(self getseatoccupant(0))) {
        wait(0.1);
    }
    self makevehicleusable();
    self setseatoccupied(0);
    self thread namespace_79e1cd97::function_d01267bd(level.players.size - 1, level.players.size, "activate_barge_ai");
}

// Namespace namespace_8b9f718f
// Params 0, eflags: 0x1 linked
// Checksum 0xea5f85ca, Offset: 0x8040
// Size: 0x24
function function_b8500bb1() {
    level thread scene::play("p7_fxanim_gp_debris_float_01_s4_bundle");
}

// Namespace namespace_8b9f718f
// Params 0, eflags: 0x1 linked
// Checksum 0xe2b591ac, Offset: 0x8070
// Size: 0x152
function function_8c158bf0() {
    var_da579d3c = getnodearray("barge_roof", "script_linkname");
    foreach (var_5898c5c in var_da579d3c) {
        setenablenode(var_5898c5c, 0);
    }
    level flag::wait_till("breach_active");
    foreach (var_5898c5c in var_da579d3c) {
        setenablenode(var_5898c5c, 1);
    }
}

// Namespace namespace_8b9f718f
// Params 0, eflags: 0x0
// Checksum 0x253c7644, Offset: 0x81d0
// Size: 0x118
function function_425c4977() {
    level endon(#"hash_eb78e4c5");
    level flag::wait_till("activate_barge_ai");
    wait(randomfloatrange(0.5, 1.5));
    while (true) {
        level exploder::exploder_duration("lightning_barge", 1);
        level fx::play("lightning_strike", struct::get("lightning_boat").origin, (-90, 0, 0));
        playsoundatposition("amb_thunder_strike", struct::get("lightning_boat").origin);
        wait(randomfloatrange(6, 7.5));
    }
}

// Namespace namespace_8b9f718f
// Params 0, eflags: 0x0
// Checksum 0x58a99e77, Offset: 0x82f0
// Size: 0x4c
function function_ecebfb25() {
    level flag::wait_till("breach_active");
    level thread namespace_79e1cd97::function_c2d8b452("lightning_pier", "wheelhouse_breached");
}

// Namespace namespace_8b9f718f
// Params 1, eflags: 0x1 linked
// Checksum 0x12ccbdc6, Offset: 0x8348
// Size: 0x2bc
function function_281ee5c2(var_74cd64bc) {
    spawner::add_spawn_function_group("barge_ai", "targetname", &function_d4e6feff);
    if (!var_74cd64bc) {
        level flag::wait_till("move_to_pier");
    }
    spawner::simple_spawn("pier_guard", &function_16bb7db4);
    if (var_74cd64bc) {
        level flag::set("start_objective_barge_assault");
        load::function_a2995f22();
    }
    trigger::wait_till("trigger_pier_retreat");
    level thread function_6dffaa41();
    trigger::wait_till("trigger_dock");
    spawner::simple_spawn("dock_guard", &function_a27055f8);
    trigger::wait_till("trigger_barge");
    spawn_manager::enable("sm_barge");
    trigger::wait_till("trigger_barge_cqb");
    spawner::add_spawn_function_group("barge_cqb", "targetname", &function_840ba109);
    spawn_manager::enable("sm_barge_cqb");
    level flag::wait_till("surge_done");
    level.var_2fd26037 colors::disable();
    level scene::init("cin_bla_06_05_portassault_vign_traversal");
    level waittill(#"hash_232dc1e1");
    level waittill(#"hash_498028de");
    level scene::play("cin_bla_06_05_portassault_vign_traversal");
    level.var_2fd26037 colors::enable();
    level flag::set("hendricks_on_barge");
    level.var_2fd26037.groundrelativepose = 1;
    trigger::use("triggercolor_barge");
}

// Namespace namespace_8b9f718f
// Params 0, eflags: 0x1 linked
// Checksum 0x4aa0bf89, Offset: 0x8610
// Size: 0x3c
function function_30f43af6() {
    trigger::wait_till("trigger_dock");
    level thread scene::play("p7_fxanim_cp_blackstation_pier_event_03_bundle");
}

// Namespace namespace_8b9f718f
// Params 0, eflags: 0x1 linked
// Checksum 0xb1d188be, Offset: 0x8658
// Size: 0x90
function function_7a7390dd() {
    var_107bf0f7 = getent("barge_assault_kill", "targetname");
    var_107bf0f7 endon(#"death");
    while (true) {
        e_triggerer = var_107bf0f7 waittill(#"trigger");
        if (isai(e_triggerer)) {
            e_triggerer kill();
        }
    }
}

// Namespace namespace_8b9f718f
// Params 0, eflags: 0x1 linked
// Checksum 0xd19f3490, Offset: 0x86f0
// Size: 0x34
function function_d4e6feff() {
    self endon(#"death");
    self.groundrelativepose = 1;
    self thread function_a27055f8();
}

// Namespace namespace_8b9f718f
// Params 0, eflags: 0x1 linked
// Checksum 0x9ed2ef06, Offset: 0x8730
// Size: 0x74
function function_840ba109() {
    self endon(#"death");
    self.groundrelativepose = 1;
    self thread function_a27055f8();
    self ai::set_behavior_attribute("cqb", 1);
    self ai::set_behavior_attribute("can_initiateaivsaimelee", 0);
}

// Namespace namespace_8b9f718f
// Params 0, eflags: 0x1 linked
// Checksum 0xd22bb767, Offset: 0x87b0
// Size: 0x11c
function function_16bb7db4() {
    self endon(#"death");
    self.goalradius = 4;
    self ai::set_ignoreme(1);
    self thread function_a27055f8();
    trigger::wait_till("hendricks_hurry");
    self ai::set_ignoreme(0);
    trigger::wait_till("trigger_pier_retreat");
    self ai::set_ignoreme(1);
    self setgoal(getent("vol_dock", "targetname"), 1, 1024);
    self waittill(#"goal");
    self ai::set_ignoreme(0);
    self clearforcedgoal();
}

// Namespace namespace_8b9f718f
// Params 0, eflags: 0x0
// Checksum 0x3aec5927, Offset: 0x88d8
// Size: 0x44
function function_dc7a0285() {
    self endon(#"death");
    self ai::set_behavior_attribute("can_initiateaivsaimelee", 0);
    self thread function_a27055f8();
}

// Namespace namespace_8b9f718f
// Params 0, eflags: 0x1 linked
// Checksum 0x489cc222, Offset: 0x8928
// Size: 0xf8
function function_a27055f8() {
    self endon(#"death");
    while (true) {
        e_player = util::get_closest_player(self.origin, "allies");
        if (isdefined(e_player)) {
            n_distance = distancesquared(self.origin, e_player.origin);
            if (n_distance < 360000) {
                self.script_accuracy = 1;
                return;
            } else {
                self.script_accuracy = math::clamp(360000 / n_distance, 0.7, 1);
            }
        }
        wait(0.2);
    }
}

// Namespace namespace_8b9f718f
// Params 0, eflags: 0x1 linked
// Checksum 0x46acf24d, Offset: 0x8a28
// Size: 0x152
function function_fd4da71() {
    var_45900c37 = vehicle::simple_spawn_single("truck_pier");
    var_45900c37 util::magic_bullet_shield();
    var_45900c37 thread function_e0fdd63d();
    var_45900c37 endon(#"death");
    level flag::wait_till("dock_fxanim_truck");
    level thread scene::init("p7_fxanim_cp_blackstation_pier_event_02_bundle");
    var_45900c37 turret::enable(1, 1);
    var_dfb53de7 = var_45900c37 vehicle::function_ad4ec07a("gunner1");
    if (isalive(var_dfb53de7)) {
        var_dfb53de7 thread function_41ef060b();
    }
    level waittill(#"hash_6b81763");
    wait(2);
    level thread scene::play("p7_fxanim_cp_blackstation_pier_event_02_bundle");
    level notify(#"hash_51074fa2");
}

// Namespace namespace_8b9f718f
// Params 0, eflags: 0x1 linked
// Checksum 0x1a4acbc7, Offset: 0x8b88
// Size: 0x2c
function function_41ef060b() {
    self endon(#"death");
    wait(4.5);
    self kill();
}

// Namespace namespace_8b9f718f
// Params 0, eflags: 0x0
// Checksum 0x967161fd, Offset: 0x8bc0
// Size: 0x94
function function_7913f320() {
    nd_start = getvehiclenode("node_cargo_truck", "targetname");
    self thread vehicle::get_on_path(nd_start);
    self util::magic_bullet_shield();
    trigger::wait_till("trigger_dock_truck");
    self thread vehicle::go_path();
}

// Namespace namespace_8b9f718f
// Params 0, eflags: 0x0
// Checksum 0xc6a20cf9, Offset: 0x8c60
// Size: 0x82
function function_cc32bd24() {
    self endon(#"death");
    level endon(#"hash_eb78e4c5");
    var_59ed1f41 = getent("truck_wave", "targetname");
    while (!self istouching(var_59ed1f41)) {
        wait(0.05);
    }
    self notify(#"wave");
}

// Namespace namespace_8b9f718f
// Params 0, eflags: 0x1 linked
// Checksum 0xd3c87407, Offset: 0x8cf0
// Size: 0x152
function function_e0fdd63d() {
    self endon(#"death");
    while (self.riders.size < 2) {
        wait(0.05);
    }
    foreach (ai_rider in self.riders) {
        ai_rider ai::set_ignoreme(1);
    }
    trigger::wait_till("hendricks_hurry");
    foreach (ai_rider in self.riders) {
        ai_rider ai::set_ignoreme(0);
    }
}

// Namespace namespace_8b9f718f
// Params 0, eflags: 0x1 linked
// Checksum 0xe5ba5169, Offset: 0x8e50
// Size: 0x134
function function_6dffaa41() {
    level flag::wait_till("trigger_wave_dock");
    a_ai_enemies = getaiteamarray("axis");
    var_dfb53de7 = getent("pier_truck_guy_ai", "targetname");
    if (isalive(var_dfb53de7)) {
        arrayremovevalue(a_ai_enemies, var_dfb53de7);
    }
    s_wave = struct::get("wave_dockleft", "script_noteworthy");
    var_32cdba86 = getent("pier_wave_dockleft", "targetname");
    level thread function_2723af5e(s_wave, var_32cdba86, "left", a_ai_enemies);
}

// Namespace namespace_8b9f718f
// Params 4, eflags: 0x1 linked
// Checksum 0xf5e127c, Offset: 0x8f90
// Size: 0x1c4
function function_2723af5e(s_wave, var_32cdba86, str_side, a_ai) {
    var_59ed1f41 = getent(var_32cdba86.target, "targetname");
    var_32cdba86 ghost();
    var_32cdba86.origin = s_wave.origin;
    var_32cdba86.angles = s_wave.angles;
    var_59ed1f41 thread namespace_79e1cd97::function_e5633001();
    if (str_side == "right") {
        n_dist = 450;
    } else {
        n_dist = -450;
    }
    var_32cdba86 moveto(var_32cdba86.origin + (0, 0, 150), 0.1);
    var_32cdba86 waittill(#"movedone");
    var_32cdba86 moveto(var_32cdba86.origin + (n_dist, 0, 0), 2);
    var_32cdba86 thread namespace_79e1cd97::function_4083c129();
    var_32cdba86 waittill(#"movedone");
    var_32cdba86 moveto(var_32cdba86.origin + (0, 0, -150), 0.1);
}

// Namespace namespace_8b9f718f
// Params 0, eflags: 0x1 linked
// Checksum 0x719ea6f9, Offset: 0x9160
// Size: 0x34
function function_b73344f6() {
    level endon(#"hash_72fc0350");
    trigger::wait_till("hero_catchup");
    savegame::checkpoint_save();
}

// Namespace namespace_8b9f718f
// Params 0, eflags: 0x1 linked
// Checksum 0x14c74295, Offset: 0x91a0
// Size: 0x1c
function function_9ea179d0() {
    level thread function_7a88d2cd();
}

// Namespace namespace_8b9f718f
// Params 0, eflags: 0x1 linked
// Checksum 0xd324f502, Offset: 0x91c8
// Size: 0x144
function function_7a88d2cd() {
    util::waittill_any_ents(level, "slow_mo_finished", level, "barge_breach_cleared");
    if (level flag::get("barge_breach_cleared")) {
        wait(0.5);
    }
    var_95a38450 = getentarray("ocean_boundary", "targetname");
    array::run_all(var_95a38450, &delete);
    level thread function_96f48ea4();
    level flag::set("tanker_go");
    level.var_2fd26037 thread function_c713e5a9();
    level thread function_948e3399();
    level thread namespace_4297372::function_11139d81();
    level thread namespace_4297372::function_fcea1d9();
}

// Namespace namespace_8b9f718f
// Params 0, eflags: 0x1 linked
// Checksum 0x2aae7d8d, Offset: 0x9318
// Size: 0x50
function function_c713e5a9() {
    level flag::wait_till("tanker_ride");
    level.var_2fd26037 colors::disable();
    level.var_2fd26037.groundrelativepose = 0;
}

// Namespace namespace_8b9f718f
// Params 0, eflags: 0x1 linked
// Checksum 0x78226d96, Offset: 0x9370
// Size: 0xc4
function function_4b773508() {
    self endon(#"death");
    self allowsprint(1);
    self allowjump(1);
    self enableinvulnerability();
    self playersetgroundreferenceent(undefined);
    level flag::wait_till("tanker_ride_done");
    self.var_eb7c5a24 = 0;
    self thread namespace_79e1cd97::function_2c33b48e();
    wait(2);
    self disableinvulnerability();
}

// Namespace namespace_8b9f718f
// Params 0, eflags: 0x1 linked
// Checksum 0xe56b8f0c, Offset: 0x9440
// Size: 0x3c4
function function_948e3399() {
    level scene::add_scene_func("cin_bla_07_02_stormsurge_1st_leap_ride", &function_423548cd);
    level scene::add_scene_func("cin_bla_07_02_stormsurge_1st_leap_ride_latched", &function_f60d2cfb, "play");
    level scene::add_scene_func("cin_bla_07_02_stormsurge_1st_leap_ride_latched", &function_407abab8, "done");
    level scene::add_scene_func("cin_bla_07_02_stormsurge_1st_leap_landing", &function_236c19c3, "done");
    level scene::add_scene_func("cin_bla_07_02_stormsurge_1st_leap_landing_hendricks", &function_18898abd, "done");
    e_fx = getent("barge_wave_fx", "targetname");
    e_fx thread fx::play("wave_pier", e_fx.origin, undefined, 2, 1);
    e_fx playrumbleonentity("bs_ride_start");
    array::run_all(getcorpsearray(), &delete);
    var_da1764fd = getaiarray("wheelhouse_enemy_ai", "targetname");
    foreach (var_eb410c1d in var_da1764fd) {
        var_eb410c1d delete();
    }
    if (level scene::is_playing("p7_fxanim_cp_blackstation_barge_idle_storm_bundle")) {
        level scene::stop("p7_fxanim_cp_blackstation_barge_idle_storm_bundle");
    }
    array::thread_all(level.activeplayers, &clientfield::set_to_player, "toggle_water_fx", 1);
    level scene::play("cin_bla_07_02_stormsurge_1st_leap_ride");
    level scene::play("cin_bla_07_02_stormsurge_1st_leap_ride_latched");
    level thread scene::play("cin_bla_07_02_stormsurge_1st_leap_landing");
    level thread scene::play("cin_bla_07_02_stormsurge_1st_leap_landing_hendricks");
    array::thread_all(level.activeplayers, &function_4b773508);
    array::thread_all(level.activeplayers, &clientfield::set_to_player, "rumble_loop", 0);
    array::thread_all(level.activeplayers, &clientfield::set_to_player, "toggle_water_fx", 0);
}

// Namespace namespace_8b9f718f
// Params 1, eflags: 0x1 linked
// Checksum 0x4184db25, Offset: 0x9810
// Size: 0xe4
function function_f60d2cfb(a_ents) {
    level thread scene::init("p7_fxanim_cp_blackstation_barge_sink_bundle");
    array::thread_all(level.activeplayers, &clientfield::set_to_player, "wind_blur", 1);
    array::thread_all(level.activeplayers, &function_622eb918);
    level thread function_fcb18964();
    level thread scene::play("p7_fxanim_cp_blackstation_tanker_building_smash_debris_bundle");
    wait(5);
    level thread scene::play("p7_fxanim_cp_blackstation_barge_sink_bundle");
}

// Namespace namespace_8b9f718f
// Params 1, eflags: 0x1 linked
// Checksum 0x9ae3a417, Offset: 0x9900
// Size: 0x3c
function function_407abab8(a_ents) {
    array::thread_all(level.activeplayers, &clientfield::set_to_player, "wind_blur", 0);
}

// Namespace namespace_8b9f718f
// Params 1, eflags: 0x1 linked
// Checksum 0x3a32d598, Offset: 0x9948
// Size: 0x7c
function function_423548cd(a_ents) {
    level waittill(#"hash_fe33f1ed");
    array::run_all(level.activeplayers, &playrumbleonentity, "damage_heavy");
    array::thread_all(level.activeplayers, &clientfield::set_to_player, "rumble_loop", 0);
}

// Namespace namespace_8b9f718f
// Params 0, eflags: 0x1 linked
// Checksum 0xfe19cd5, Offset: 0x99d0
// Size: 0x58
function function_fcb18964() {
    level endon(#"hash_407abab8");
    while (true) {
        level waittill(#"hash_b465620d");
        array::run_all(level.activeplayers, &playrumbleonentity, "cp_blackstation_tanker_building_rumble");
    }
}

// Namespace namespace_8b9f718f
// Params 0, eflags: 0x1 linked
// Checksum 0x42f336cd, Offset: 0x9a30
// Size: 0x6c
function function_622eb918() {
    array::run_all(level.activeplayers, &playrumbleonentity, "cp_blackstation_tanker_anchor_rumble");
    array::thread_all(level.activeplayers, &clientfield::set_to_player, "rumble_loop", 1);
}

// Namespace namespace_8b9f718f
// Params 1, eflags: 0x1 linked
// Checksum 0xfbc78a06, Offset: 0x9aa8
// Size: 0x24
function function_18898abd(a_ents) {
    level.var_2fd26037 colors::enable();
}

// Namespace namespace_8b9f718f
// Params 1, eflags: 0x1 linked
// Checksum 0x6953d3ff, Offset: 0x9ad8
// Size: 0x64
function function_236c19c3(a_ents) {
    level flag::set("tanker_ride_done");
    level notify(#"hash_b36ffbd");
    array::thread_all(level.activeplayers, &namespace_3dc5b645::function_99f304f0);
}

// Namespace namespace_8b9f718f
// Params 0, eflags: 0x1 linked
// Checksum 0xa595f2f6, Offset: 0x9b48
// Size: 0x1ca
function function_96f48ea4() {
    level waittill(#"hash_383b9104");
    level thread scene::play("p7_fxanim_cp_blackstation_barge_roof_break_bundle");
    exploder::exploder_stop("barge_destroy_interior_lgt");
    var_486aa363 = getent("barge_wheelhouse_interior", "targetname");
    var_486aa363 playrumbleonentity("bs_ride_start");
    playsoundatposition("evt_barge_shake", var_486aa363.origin);
    array::thread_all(level.activeplayers, &clientfield::set_to_player, "rumble_loop", 1);
    earthquake(0.3, 21, var_486aa363.origin, 999999);
    var_8e44646a = getentarray("barge_wheelhouse_roof", "targetname");
    foreach (var_6baa4cfd in var_8e44646a) {
        var_6baa4cfd delete();
    }
}

// Namespace namespace_8b9f718f
// Params 0, eflags: 0x1 linked
// Checksum 0x5c2a6d58, Offset: 0x9d20
// Size: 0xd4
function function_ab78d20a() {
    trigger::wait_till("trigger_toilet");
    var_a7307e7e = getent("debris_toilet", "targetname");
    var_a7307e7e thread namespace_79e1cd97::function_f5cdc056();
    var_a7307e7e thread namespace_79e1cd97::function_2d329cdb();
    var_a7307e7e moveto(var_a7307e7e.origin + (0, 6000, -56), 8);
    var_a7307e7e waittill(#"movedone");
    var_a7307e7e delete();
}

// Namespace namespace_8b9f718f
// Params 0, eflags: 0x1 linked
// Checksum 0x33e47e9c, Offset: 0x9e00
// Size: 0x34
function function_13e164f4() {
    self.var_1b3b1022 = 1;
    self ai::set_behavior_attribute("useAnimationOverride", 1);
}

// Namespace namespace_8b9f718f
// Params 0, eflags: 0x1 linked
// Checksum 0x5ec313a6, Offset: 0x9e40
// Size: 0xfe
function function_22a0015b() {
    while (!level flag::get("breach_active")) {
        level notify(#"hash_2b462d33");
        wait(0.5);
        if (math::cointoss()) {
            level thread namespace_79e1cd97::function_bd1bfce2("exp_lightning_pier_l_01", "exp_lightning_pier_l_02", "exp_lightning_pier_l_03", 2, "end_lightning");
        } else {
            level thread namespace_79e1cd97::function_bd1bfce2("exp_lightning_pier_r_01", "exp_lightning_pier_r_02", "exp_lightning_pier_r_03", 1, "end_lightning");
        }
        wait(randomfloatrange(2.5, 5));
    }
    wait(0.5);
    level notify(#"hash_2b462d33");
}

// Namespace namespace_8b9f718f
// Params 0, eflags: 0x1 linked
// Checksum 0xf9f4eb2e, Offset: 0x9f48
// Size: 0x3c
function function_109329ae() {
    trigger::wait_till("anchor_intro_breadcrumb");
    level thread objectives::breadcrumb("debris_mound_breadcrumb");
}

// Namespace namespace_8b9f718f
// Params 0, eflags: 0x1 linked
// Checksum 0x3ab3b64b, Offset: 0x9f90
// Size: 0xd4
function function_94ff5bc0() {
    trigger::wait_till("debris_mound_breadcrumb");
    level thread function_3b4b0a17();
    level flag::wait_till("debris_path_four_ready");
    level thread function_3b4b0a17();
    level flag::wait_till("debris_path_five_ready");
    level thread function_3b4b0a17();
    trigger::wait_till("trigger_toilet");
    level thread function_3b4b0a17();
}

// Namespace namespace_8b9f718f
// Params 0, eflags: 0x1 linked
// Checksum 0x3a30d223, Offset: 0xa070
// Size: 0x86
function function_3b4b0a17() {
    var_92471baa = randomintrange(1, 5);
    for (i = 0; i < var_92471baa; i++) {
        exploder::exploder("exp_lightning_anchor_l_01");
        wait(randomfloatrange(0.1, 0.5));
    }
}

// Namespace namespace_8b9f718f
// Params 0, eflags: 0x1 linked
// Checksum 0xaa27db23, Offset: 0xa100
// Size: 0x172
function function_9a8b2deb() {
    var_4a27984b = spawnlogic::function_93d52c4f(1);
    foreach (s_spawnpt in var_4a27984b) {
        if (s_spawnpt.var_ff844e3f === "10") {
            s_spawnpt spawnlogic::function_82c857e9(0);
        }
    }
    wait(0.05);
    foreach (s_spawnpt in var_4a27984b) {
        if (s_spawnpt.var_ff3739ca === "23") {
            s_spawnpt spawnlogic::function_82c857e9(1);
        }
    }
}

// Namespace namespace_8b9f718f
// Params 0, eflags: 0x1 linked
// Checksum 0x75dd5a94, Offset: 0xa280
// Size: 0xb4
function function_5b85480f() {
    var_b9528c52 = trigger::wait_till("hendricks_hurry");
    e_player = var_b9528c52.who;
    if (distance2dsquared(e_player.origin, level.var_2fd26037.origin) > 2250000) {
        level.var_2fd26037 forceteleport((2282, -3646, 64), (0, 180, 0), 0);
    }
}

