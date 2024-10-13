#using scripts/cp/_objectives;
#using scripts/cp/_squad_control;
#using scripts/cp/_spawn_manager;
#using scripts/cp/_util;
#using scripts/cp/_skipto;
#using scripts/cp/_load;
#using scripts/cp/_dialog;
#using scripts/shared/ai/robot_phalanx;
#using scripts/cp/cp_mi_sing_biodomes_sound;
#using scripts/cp/cp_mi_sing_biodomes_accolades;
#using scripts/cp/cp_mi_sing_biodomes;
#using scripts/cp/cp_mi_sing_biodomes_util;
#using scripts/cp/cp_mi_sing_biodomes_markets;
#using scripts/cp/gametypes/_battlechatter;
#using scripts/cp/gametypes/_save;
#using scripts/cp/cybercom/_cybercom_gadget_security_breach;
#using scripts/cp/cybercom/_cybercom_gadget;
#using scripts/shared/vehicles/_siegebot;
#using scripts/shared/ai/archetype_warlord_interface;
#using scripts/shared/ai/warlord;
#using scripts/shared/vehicle_shared;
#using scripts/shared/vehicle_ai_shared;
#using scripts/shared/util_shared;
#using scripts/shared/trigger_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/math_shared;
#using scripts/shared/gameobjects_shared;
#using scripts/shared/fx_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/compass;
#using scripts/shared/colors_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/array_shared;
#using scripts/shared/ai_shared;
#using scripts/codescripts/struct;

#namespace cp_mi_sing_biodomes_warehouse;

// Namespace cp_mi_sing_biodomes_warehouse
// Params 0, eflags: 0x0
// Checksum 0x2f9b131b, Offset: 0x13a0
// Size: 0x342
function function_3a3ef2a() {
    foreach (player in level.players) {
        player thread function_3460d45c();
    }
    level.var_2fd26037 colors::enable();
    level.var_2fd26037.goalradius = -56;
    level scene::init("cin_bio_05_02_warehouse_aie_activate");
    level thread function_d1e71c2c();
    spawner::add_spawn_function_group("warehouse_left_waiting", "script_noteworthy", &function_e7b0cb8e);
    spawner::add_spawn_function_group("robot_warehouse_high", "script_string", &function_9bf4e185);
    spawner::add_spawn_function_group("warehouse_container_shooter", "targetname", &function_ac9359ee);
    spawner::add_spawn_function_group("wasps_warehouse", "script_noteworthy", &function_d3621fb);
    spawner::add_spawn_function_group("warehouse_enemy_warlord", "targetname", &function_4940548b);
    var_3d912af2 = getentarray("spawn_trigger", "script_parameters");
    array::thread_all(var_3d912af2, &function_26edc5d7);
    wait 0.5;
    level thread container_crash();
    level thread container_done();
    level thread function_16ff311a();
    level thread function_b1942036();
    level thread warehouse_warlord_friendly_goal();
    level thread wait_for_objective_complete();
    level thread function_ecf3cf41();
    level thread function_afee5825();
    level thread function_3c56dee4();
    level thread function_2a08e741();
    level thread function_6fb5d6ef();
    level.var_2fd26037 thread function_d02d38d();
    level.var_2fd26037 thread function_c2f6ee2c("right");
    level.var_2fd26037 thread function_c2f6ee2c("left");
    cp_mi_sing_biodomes_util::function_a22e7052(0, "warehouse_robot_exit_traversal", "targetname");
    trigger::wait_till("trig_back_door_close");
    level function_4812aaa();
}

// Namespace cp_mi_sing_biodomes_warehouse
// Params 0, eflags: 0x0
// Checksum 0xe9c07cd6, Offset: 0x16f0
// Size: 0x2
function precache() {
    
}

// Namespace cp_mi_sing_biodomes_warehouse
// Params 2, eflags: 0x0
// Checksum 0x282cd791, Offset: 0x1700
// Size: 0x262
function objective_warehouse_init(str_objective, var_74cd64bc) {
    cp_mi_sing_biodomes_util::function_ddb0eeea("objective_warehouse_init");
    objectives::set("cp_waypoint_breadcrumb", struct::get("breadcrumb_warehouse"));
    objectives::hide("cp_waypoint_breadcrumb");
    if (var_74cd64bc) {
        load::function_73adcefc();
        cp_mi_sing_biodomes_util::function_bff1a867(str_objective);
        cp_mi_sing_biodomes::function_cef897cf(str_objective);
        level thread cp_mi_sing_biodomes_util::function_753a859(str_objective);
        objectives::set("cp_level_biodomes_cloud_mountain");
        trigger::use("trig_markets2_colors_end_2");
        array::delete_all(getentarray("triggers_markets1", "script_noteworthy"));
        array::delete_all(getentarray("triggers_markets2", "script_noteworthy"));
        level thread namespace_f1b4cbbc::function_fa2e45b8();
        level thread cp_mi_sing_biodomes_util::function_cc20e187("markets2");
        level thread cp_mi_sing_biodomes_util::function_cc20e187("warehouse", 1);
        var_6ecc8f2b = getent("markets2_bridge_collision", "targetname");
        var_6ecc8f2b delete();
        load::function_a2995f22();
    }
    level thread cp_mi_sing_biodomes_util::function_cc20e187("cloudmountain", 1);
    level.var_996e05eb = "friendly_spawns_warehouse_entrance";
    hidemiscmodels("fxanim_markets1");
    hidemiscmodels("fxanim_nursery");
    showmiscmodels("fxanim_cloud_mountain");
    cp_mi_sing_biodomes_markets::function_dbb91fcf();
    level thread function_3a3ef2a();
}

// Namespace cp_mi_sing_biodomes_warehouse
// Params 4, eflags: 0x0
// Checksum 0x6ce981d3, Offset: 0x1970
// Size: 0x8b
function objective_warehouse_done(str_objective, var_74cd64bc, var_e4cd2b8b, player) {
    cp_mi_sing_biodomes_util::function_ddb0eeea("objective_warehouse_done");
    objectives::complete("cp_waypoint_breadcrumb", struct::get("breadcrumb_warehouse"));
    objectives::complete("cp_level_biodomes_cloud_mountain");
    level notify(#"hash_43a6ada4");
}

// Namespace cp_mi_sing_biodomes_warehouse
// Params 2, eflags: 0x0
// Checksum 0xa624c5de, Offset: 0x1a08
// Size: 0x2a
function function_5e699ca2(str_objective, var_74cd64bc) {
    level thread function_79241926(str_objective, 2);
}

// Namespace cp_mi_sing_biodomes_warehouse
// Params 2, eflags: 0x0
// Checksum 0x76697152, Offset: 0x1a40
// Size: 0x2a
function function_9989cb45(str_objective, var_74cd64bc) {
    level thread function_79241926(str_objective, 1);
}

// Namespace cp_mi_sing_biodomes_warehouse
// Params 2, eflags: 0x0
// Checksum 0xa1987992, Offset: 0x1a78
// Size: 0x15a
function function_79241926(str_objective, var_23d9a41a) {
    cp_mi_sing_biodomes_util::function_bff1a867(str_objective);
    level cp_mi_sing_biodomes::function_cef897cf(str_objective, var_23d9a41a);
    level flag::wait_till("first_player_spawned");
    wait 2;
    spawner::simple_spawn("warehouse_enemy_warlord", &function_dfbb625c);
    level flag::set("warehouse_warlord");
    level thread clientfield::set("warehouse_window_break", 1);
    getent("warehouse_overwatch_window", "targetname") delete();
    s_container = struct::get("warehouse_surprise");
    earthquake(0.25, 0.5, s_container.origin, 1200);
    cp_mi_sing_biodomes_util::function_a22e7052(0, "warehouse_robot_exit_traversal", "targetname");
    level function_4812aaa();
}

// Namespace cp_mi_sing_biodomes_warehouse
// Params 0, eflags: 0x0
// Checksum 0xb94ce319, Offset: 0x1be0
// Size: 0x42
function function_dfbb625c() {
    self.health = 100;
    self waittill(#"death");
    level flag::set("warehouse_warlord_dead");
    level flag::set("sm_warehouse_enemy_warlord_manager_cleared");
}

// Namespace cp_mi_sing_biodomes_warehouse
// Params 0, eflags: 0x0
// Checksum 0xf9055517, Offset: 0x1c30
// Size: 0x30
function function_d02d38d() {
    level flag::wait_till("warehouse_wasps");
    if (isdefined(level.var_80a07074)) {
        level thread [[ level.var_80a07074 ]]();
    }
}

// Namespace cp_mi_sing_biodomes_warehouse
// Params 0, eflags: 0x0
// Checksum 0x15e67b33, Offset: 0x1c68
// Size: 0x15a
function function_16ff311a() {
    level waittill(#"container_done");
    level spawn_manager::wait_till_cleared("sm_warehouse_robot_jumpdown");
    if (!level flag::get("left_path") && !level flag::get("right_path") && !level flag::get("center_path")) {
        level flag::set("warehouse_intro_vo_started");
        level thread function_1050699d();
        level.var_2fd26037 dialog::say("hend_which_way_do_we_go_0");
        level dialog::remote("kane_your_call_both_end_0");
        battlechatter::function_d9f49fba(1);
        level flag::wait_till_any(array("left_path", "right_path", "center_path"));
        level.var_2fd26037 dialog::say("hend_we_gotta_get_to_clou_0", 2);
        battlechatter::function_d9f49fba(1);
    }
    level flag::set("warehouse_intro_vo_done");
}

// Namespace cp_mi_sing_biodomes_warehouse
// Params 0, eflags: 0x0
// Checksum 0x57c94a0, Offset: 0x1dd0
// Size: 0x6a
function function_1050699d() {
    level endon(#"left_path");
    level endon(#"right_path");
    level endon(#"center_path");
    wait 14;
    var_2d3d7b7 = [];
    var_2d3d7b7[0] = "hend_what_s_the_plan_lef_0";
    var_2d3d7b7[1] = "hend_c_mon_we_gotta_move_0";
    level.var_2fd26037 dialog::say(cp_mi_sing_biodomes_util::function_7ff50323(var_2d3d7b7));
}

// Namespace cp_mi_sing_biodomes_warehouse
// Params 0, eflags: 0x0
// Checksum 0xf3079979, Offset: 0x1e48
// Size: 0x3a
function function_2a08e741() {
    level endon(#"back_door_closed");
    level flag::wait_till("xiulan_loudspeaker_go");
    spawn_manager::enable("warehouse_right_rear_runners");
}

// Namespace cp_mi_sing_biodomes_warehouse
// Params 0, eflags: 0x0
// Checksum 0x9632ebd7, Offset: 0x1e90
// Size: 0x6a
function function_9bf4e185() {
    self endon(#"death");
    nd_start = getnode(self.target, "targetname");
    if (isdefined(nd_start)) {
        self thread ai::force_goal(nd_start, 36, 1, "goal", 1, 1);
    }
    self thread function_9ec04302();
}

// Namespace cp_mi_sing_biodomes_warehouse
// Params 0, eflags: 0x0
// Checksum 0x6e9bcfad, Offset: 0x1f08
// Size: 0x10d
function function_9ec04302() {
    self endon(#"death");
    self endon(#"hash_a3a542bc");
    var_994792b4 = getentarray("trig_robot_jump_landing", "script_noteworthy");
    while (true) {
        foreach (trigger in var_994792b4) {
            if (self istouching(trigger)) {
                if (trigger.targetname === "trig_warehouse_robot_landing_left") {
                    exploder::exploder("fx_warehouse_robot_jmp_dust_l");
                } else if (trigger.targetname === "trig_warehouse_robot_landing_right") {
                    exploder::exploder("fx_warehouse_robot_jmp_dust_r");
                }
                self notify(#"hash_a3a542bc");
            }
        }
        wait 0.05;
    }
}

// Namespace cp_mi_sing_biodomes_warehouse
// Params 0, eflags: 0x0
// Checksum 0x9e9ee8d7, Offset: 0x2020
// Size: 0x146
function function_afee5825() {
    level flag::wait_till("container_drop");
    var_2122e778 = struct::get("phalanx_warehouse_left_start").origin;
    var_7d0099f5 = struct::get("phalanx_warehouse_left_end").origin;
    var_e1f76987 = struct::get("phalanx_warehouse_right_start").origin;
    var_25d2a1d8 = struct::get("phalanx_warehouse_right_end").origin;
    var_1b6ee6b2 = 1;
    if (level.players.size >= 3) {
        var_1b6ee6b2 = 2;
    }
    var_52fcc5ab = new robotphalanx();
    [[ var_52fcc5ab ]]->initialize("phanalx_wedge", var_2122e778, var_7d0099f5, 2, var_1b6ee6b2);
    var_1a84f71e = new robotphalanx();
    [[ var_1a84f71e ]]->initialize("phanalx_wedge", var_e1f76987, var_25d2a1d8, 2, var_1b6ee6b2);
}

// Namespace cp_mi_sing_biodomes_warehouse
// Params 0, eflags: 0x0
// Checksum 0xf7285775, Offset: 0x2170
// Size: 0x17a
function function_3c56dee4() {
    level endon(#"center_path");
    a_flags = [];
    a_flags[0] = "xiulan_loudspeaker_go";
    if (level flag::get("warehouse_intro_vo_started")) {
        a_flags[1] = "warehouse_intro_vo_done";
    }
    flag::wait_till_all(a_flags);
    var_f2fa33f7 = getentarray("so_xiulan_warehouse_loudspeaker", "targetname");
    foreach (n_index, var_ea519684 in var_f2fa33f7) {
        if (n_index == var_f2fa33f7.size - 1) {
            var_ea519684 dialog::say("xiul_loyal_immortals_thi_0", 0, 1);
            continue;
        }
        var_ea519684 thread dialog::say("xiul_loyal_immortals_thi_0", 0, 1);
    }
    level.var_2fd26037 dialog::say("hend_that_bitch_really_is_0");
    level dialog::function_13b3b16a("plyr_you_shot_her_brother_0");
    level.var_2fd26037 dialog::say("hend_i_should_have_shot_h_0");
    battlechatter::function_d9f49fba(1);
}

// Namespace cp_mi_sing_biodomes_warehouse
// Params 0, eflags: 0x0
// Checksum 0xadf5cc52, Offset: 0x22f8
// Size: 0x17a
function function_d3621fb() {
    self endon(#"death");
    self vehicle_ai::start_scripted();
    nd_start = getvehiclenode(self.target, "targetname");
    self thread vehicle::get_on_and_go_path(nd_start);
    self waittill(#"reached_end_node");
    v_pos = self getclosestpointonnavvolume(self.origin, 1024);
    v_pos = (v_pos[0], v_pos[1], v_pos[2] + randomintrange(0, 72));
    if (isdefined(v_pos)) {
        self setvehgoalpos(v_pos, 0);
        self waittill(#"goal");
    }
    e_volume = undefined;
    if (self.script_aigroup == "wasps_warehouse_left") {
        e_volume = getent("volume_warehouse_wasps_left", "targetname");
    } else if (self.script_aigroup == "wasps_warehouse_right") {
        e_volume = getent("volume_warehouse_wasps_right", "targetname");
    }
    self vehicle_ai::stop_scripted("combat");
    if (isdefined(e_volume)) {
        self setgoal(e_volume, 1);
    }
}

// Namespace cp_mi_sing_biodomes_warehouse
// Params 0, eflags: 0x0
// Checksum 0x4b827c93, Offset: 0x2480
// Size: 0x3a
function function_6fb5d6ef() {
    level endon(#"warehouse_warlord_friendly_goal");
    trigger::wait_for_either("trig_warehouse_friendly_spawns_left", "trig_warehouse_friendly_spawns_right");
    level.var_996e05eb = "friendly_spawns_warehouse_corner";
}

// Namespace cp_mi_sing_biodomes_warehouse
// Params 0, eflags: 0x0
// Checksum 0xe349883c, Offset: 0x24c8
// Size: 0xe5
function function_26edc5d7() {
    self endon(#"death");
    while (true) {
        ai_guy = self waittill(#"trigger");
        if (isdefined(ai_guy.owner) && isplayer(ai_guy.owner) || isplayer(ai_guy)) {
            break;
        }
    }
    var_694b7da = self.script_string;
    switch (var_694b7da) {
    case "spawner":
        str_spawner = self.script_noteworthy;
        spawner::simple_spawn(str_spawner);
        break;
    case "spawn_manager":
        spawn_manager::enable(self.script_noteworthy, 1);
        break;
    }
}

// Namespace cp_mi_sing_biodomes_warehouse
// Params 1, eflags: 0x0
// Checksum 0x2cf36f98, Offset: 0x25b8
// Size: 0x1b2
function function_c2f6ee2c(var_c11c02b4) {
    if (var_c11c02b4 == "right") {
        level endon(#"left_path");
    } else {
        level endon(#"right_path");
    }
    level trigger::wait_till("trig_hero_sprint_" + var_c11c02b4);
    if (level flag::get("warehouse_intro_vo_done")) {
        level.var_2fd26037 thread dialog::say("hend_moving_up_cover_me_1");
    }
    ai_target = spawner::simple_spawn_single("warehouse_hero_target_" + var_c11c02b4);
    ai_target ai::set_ignoreme(1);
    ai_target ai::set_behavior_attribute("can_become_rusher", 0);
    ai_target.goalradius = 8;
    ai_target endon(#"death");
    level thread scene::init("scene_warehouse_hendricks_jump_" + var_c11c02b4, "targetname", array(level.var_2fd26037, ai_target));
    level trigger::wait_till("trig_hero_moment_" + var_c11c02b4);
    if (isalive(ai_target)) {
        ai_target thread function_2b42cba3("scene_warehouse_hendricks_jump_" + var_c11c02b4);
        level scene::play("scene_warehouse_hendricks_jump_" + var_c11c02b4, "targetname", array(level.var_2fd26037, ai_target));
    }
    level.var_2fd26037 clearforcedgoal();
}

// Namespace cp_mi_sing_biodomes_warehouse
// Params 1, eflags: 0x0
// Checksum 0xfac187e8, Offset: 0x2778
// Size: 0x2a
function function_2b42cba3(str_scene) {
    self waittill(#"death");
    level scene::stop(str_scene);
}

// Namespace cp_mi_sing_biodomes_warehouse
// Params 0, eflags: 0x0
// Checksum 0x3c5f3aed, Offset: 0x27b0
// Size: 0xe2
function function_89e35d86() {
    level flag::wait_till_any(array("warehouse_warlord_dead", "warehouse_warlord_retreated"));
    if (isdefined(level.var_fd93406f)) {
        level thread [[ level.var_fd93406f ]]();
    }
    level thread namespace_f1b4cbbc::function_973b77f9();
    objectives::show("cp_waypoint_breadcrumb");
    level thread namespace_36171bd3::function_9c52a47e("pry_door");
    level dialog::remote("kane_the_robots_should_be_0", 2);
    level waittill(#"hash_24ac1796");
    level flag::set("back_door_opened");
    level function_cb52a73();
    level function_1b03da0e();
}

// Namespace cp_mi_sing_biodomes_warehouse
// Params 0, eflags: 0x0
// Checksum 0x8d2ec39e, Offset: 0x28a0
// Size: 0x9a
function function_cb52a73() {
    level.var_2fd26037 clearforcedgoal();
    level.var_2fd26037 colors::enable();
    level.var_2fd26037.goalradius = 400;
    if (flag::get("cloudmountain_siegebots_dead")) {
        trigger::use("trig_hendricks_lobby_entrance_colors", "targetname");
        return;
    }
    trigger::use("trig_siegebot_hendricks_b0", "targetname");
}

// Namespace cp_mi_sing_biodomes_warehouse
// Params 0, eflags: 0x0
// Checksum 0x6a0443aa, Offset: 0x2948
// Size: 0x153
function function_1b03da0e() {
    foreach (player in level.players) {
        player notify(#"hash_f4ef75a1");
    }
    foreach (var_f6c5842 in level.var_641fcd9c) {
        if (isalive(var_f6c5842)) {
            var_f6c5842 clearforcedgoal();
            var_f6c5842 util::stop_magic_bullet_shield();
            var_f6c5842 ai::set_behavior_attribute("move_mode", "normal");
            var_f6c5842 ai::set_behavior_attribute("sprint", 1);
            var_f6c5842 setgoal(getent("back_door_goal_volume", "targetname"));
        }
    }
}

// Namespace cp_mi_sing_biodomes_warehouse
// Params 0, eflags: 0x0
// Checksum 0x79aaf0ef, Offset: 0x2aa8
// Size: 0x252
function function_ac9359ee() {
    self endon(#"death");
    self ai::set_ignoreme(1);
    self ai::set_ignoreall(1);
    self.upaimlimit = 80;
    self setgoal(getent("volume_wasps_warehouse_crate_shooters", "targetname"), 1);
    util::magic_bullet_shield(self);
    self util::waittill_notify_or_timeout("goal", 2);
    e_target = getent("container_target", "targetname");
    self ai::set_ignoreall(0);
    self thread ai::shoot_at_target("normal", e_target, "tag_origin", 2);
    level flag::wait_till_timeout(3, "container_drop");
    level flag::set("container_drop");
    util::stop_magic_bullet_shield(self);
    level flag::wait_till_any(array("left_path", "right_path", "center_path"));
    self ai::set_ignoreme(0);
    self ai::set_ignoreall(0);
    if (level flag::get("left_path")) {
        self setgoal(getent("warehouse_goal_volume_back_left", "targetname"));
        return;
    }
    if (level flag::get("right_path")) {
        self setgoal(getent("warehouse_goal_volume_back_right", "targetname"));
        return;
    }
    if (level flag::get("center_path")) {
        self setgoal(getent("warehouse_crate_shooters_center_goal", "targetname"));
    }
}

// Namespace cp_mi_sing_biodomes_warehouse
// Params 0, eflags: 0x0
// Checksum 0xcb2fa48b, Offset: 0x2d08
// Size: 0x22
function container_done() {
    level waittill(#"container_done");
    level flag::set("container_done");
}

// Namespace cp_mi_sing_biodomes_warehouse
// Params 0, eflags: 0x0
// Checksum 0xfb16ad51, Offset: 0x2d38
// Size: 0x15a
function container_crash() {
    var_7954a18f = getent("container_drop_clip", "targetname");
    var_d76c34c9 = getent("container_pre_drop_clip", "targetname");
    var_7954a18f connectpaths();
    level flag::wait_till("container_drop");
    spawn_manager::enable("sm_warehouse_robot_jumpdown");
    level thread scene::play("p7_fxanim_cp_biodomes_container_collapse_bundle");
    level thread function_5491de58();
    level waittill(#"hash_ae902056");
    var_d76c34c9 delete();
    level thread function_1636c832();
    var_7954a18f disconnectpaths();
    wait 0.25;
    s_container = struct::get("container_crash");
    playsoundatposition("evt_warlord_door_smash", s_container.origin);
    playrumbleonposition("cp_biodomes_warehouse_container_rumble", s_container.origin);
}

// Namespace cp_mi_sing_biodomes_warehouse
// Params 0, eflags: 0x0
// Checksum 0x1cbbdfd5, Offset: 0x2ea0
// Size: 0x8a
function function_5491de58() {
    level dialog::remote("kane_woah_get_out_of_t_0");
    level dialog::remote("kane_tracking_enemy_units_0", 3);
    level dialog::function_13b3b16a("plyr_tell_me_something_i_0");
    level dialog::remote("kane_i_ve_located_a_backd_0", 1);
    battlechatter::function_d9f49fba(1);
    objectives::show("cp_waypoint_breadcrumb");
}

// Namespace cp_mi_sing_biodomes_warehouse
// Params 0, eflags: 0x0
// Checksum 0xcd4d227b, Offset: 0x2f38
// Size: 0xc5
function function_1636c832() {
    var_61a19dc6 = getaiteamarray("allies");
    var_7954a18f = getent("container_drop_clip", "targetname");
    arrayremovevalue(var_61a19dc6, level.var_2fd26037);
    for (i = 0; i < var_61a19dc6.size; i++) {
        if (var_61a19dc6[i] istouching(var_7954a18f)) {
            util::stop_magic_bullet_shield(var_61a19dc6[i]);
            var_61a19dc6[i] kill();
        }
    }
    var_61a19dc6 = [];
}

// Namespace cp_mi_sing_biodomes_warehouse
// Params 0, eflags: 0x0
// Checksum 0x7a10457d, Offset: 0x3008
// Size: 0xe2
function function_c06efd40() {
    self endon(#"death");
    self setgoal(self.origin, 1, 1);
    level flag::wait_till("container_done");
    self ai::set_behavior_attribute("move_mode", "rambo");
    nd_target = getnode(self.target, "targetname");
    self setgoal(nd_target, 1);
    self waittill(#"goal");
    self ai::set_behavior_attribute("move_mode", "normal");
    wait 10;
    self setgoal(self.origin, 0, 1200);
}

// Namespace cp_mi_sing_biodomes_warehouse
// Params 1, eflags: 0x0
// Checksum 0xa234411c, Offset: 0x30f8
// Size: 0x12a
function glass_break(str_trigger_name) {
    var_799e4c3a = getent(str_trigger_name, "targetname");
    if (isdefined(var_799e4c3a)) {
        var_799e4c3a flag::init("glass_broken");
        while (var_799e4c3a flag::get("glass_broken") == 0) {
            var_799e4c3a trigger::wait_till();
            if (isplayer(var_799e4c3a.who) && (!isplayer(var_799e4c3a.who) || var_799e4c3a.who issprinting())) {
                glassradiusdamage(var_799e4c3a.origin, 100, 500, 500);
                var_799e4c3a flag::set("glass_broken");
            }
        }
        var_799e4c3a delete();
    }
}

// Namespace cp_mi_sing_biodomes_warehouse
// Params 0, eflags: 0x0
// Checksum 0x24052b6f, Offset: 0x3230
// Size: 0x72
function function_d1e71c2c() {
    level endon(#"left_path");
    level endon(#"center_path");
    level flag::wait_till("right_path");
    level scene::init("cin_bio_05_02_warehouse_vign_forklift_move");
    trigger::wait_till("forklift_vignette_start");
    level scene::play("cin_bio_05_02_warehouse_vign_forklift_move");
}

// Namespace cp_mi_sing_biodomes_warehouse
// Params 0, eflags: 0x0
// Checksum 0x703e7a02, Offset: 0x32b0
// Size: 0x32
function wait_for_objective_complete() {
    trigger::wait_till("trig_warehouse_objective_complete");
    skipto::function_be8adfb8("objective_warehouse");
}

// Namespace cp_mi_sing_biodomes_warehouse
// Params 0, eflags: 0x0
// Checksum 0x895a0d55, Offset: 0x32f0
// Size: 0x7a
function function_ecf3cf41() {
    trigger::wait_till("trig_back_door_group");
    spawner::simple_spawn(getentarray("back_door_enemy", "script_aigroup"));
    getent("back_door_look_trigger", "script_noteworthy") triggerenable(1);
}

// Namespace cp_mi_sing_biodomes_warehouse
// Params 0, eflags: 0x0
// Checksum 0x424936d3, Offset: 0x3378
// Size: 0x29a
function function_4812aaa() {
    level.var_e6a85ae8 = getent("cloudmountain_door_upper", "targetname");
    level.var_7f103643 = getent("cloudmountain_door_lower", "targetname");
    level.var_e6a85ae8.var_ba7fc287 = level.var_e6a85ae8.origin;
    level.var_7f103643.var_ba7fc287 = level.var_7f103643.origin;
    level.var_e6a85ae8 movez(-40, 2);
    level.var_7f103643 movez(60, 2);
    level.var_e6a85ae8 playsound("evt_warehouse_door_close_start");
    level.var_e6a85ae8 playloopsound("evt_warehouse_door_close_loop", 1);
    level.var_7f103643 waittill(#"movedone");
    level.var_e6a85ae8 playsound("evt_warehouse_door_close_stop");
    level.var_e6a85ae8 stoploopsound(0.5);
    level flag::set("back_door_closed");
    var_60f8f46f = getent("back_door_full_clip", "targetname");
    var_60f8f46f movez(-128, 0.05);
    var_bee08349 = getent("back_door_no_pen_clip", "targetname");
    var_bee08349 movez(-128, 0.05);
    spawner::add_spawn_function_group("cloud_mountain_siegebot", "targetname", &function_c001cefd);
    spawn_manager::enable("cloud_mountain_siegebot_manager");
    if (isdefined(level.var_c4dba52c)) {
        [[ level.var_c4dba52c ]]();
    }
    level thread function_bd5615c2();
    level thread cloud_mountain_crows();
    level thread function_89e35d86();
    level function_db58f411();
}

// Namespace cp_mi_sing_biodomes_warehouse
// Params 0, eflags: 0x0
// Checksum 0x660348be, Offset: 0x3620
// Size: 0x222
function function_d9982dc0() {
    if (!isdefined(level.var_e6a85ae8) || !isdefined(level.var_7f103643)) {
        level.var_e6a85ae8 = getent("cloudmountain_door_upper", "targetname");
        level.var_7f103643 = getent("cloudmountain_door_lower", "targetname");
    }
    level.var_e6a85ae8 moveto(level.var_e6a85ae8.var_ba7fc287, 2);
    level.var_7f103643 moveto(level.var_7f103643.var_ba7fc287, 2);
    level.var_e6a85ae8 playsound("evt_warehouse_door_close_start");
    level.var_e6a85ae8 playloopsound("evt_warehouse_door_close_loop", 1);
    level.var_7f103643 waittill(#"movedone");
    level.var_e6a85ae8 playsound("evt_warehouse_door_close_stop");
    level.var_e6a85ae8 stoploopsound(0.5);
    wait 3;
    level flag::set("back_door_opened");
    var_ec935bdb = getent("back_door_player_clip", "targetname");
    if (isdefined(var_ec935bdb)) {
        var_ec935bdb delete();
    }
    var_3dffb84b = getent("back_door_full_clip", "targetname");
    if (isdefined(var_3dffb84b)) {
        var_3dffb84b delete();
    }
    var_6f9ff65c = getent("back_door_no_pen_clip", "targetname");
    if (isdefined(var_6f9ff65c)) {
        var_6f9ff65c delete();
    }
}

// Namespace cp_mi_sing_biodomes_warehouse
// Params 0, eflags: 0x0
// Checksum 0x8e9b10d8, Offset: 0x3850
// Size: 0xea
function function_c001cefd() {
    self ai::set_ignoreme(1);
    self ai::set_ignoreall(1);
    self thread function_4a9bba52();
    self thread function_994b4243();
    level flag::wait_till_any(array("back_door_opened", "siegebot_alerted"));
    self setcandamage(1);
    self.overridevehicledamage = &siegebot::function_3b05fc1b;
    self ai::set_ignoreme(0);
    self ai::set_ignoreall(0);
    wait 0.5;
    trigger::use("trig_warehouse_objective_complete", "targetname", level.activeplayers[0], 0);
}

// Namespace cp_mi_sing_biodomes_warehouse
// Params 0, eflags: 0x0
// Checksum 0xd87d142, Offset: 0x3948
// Size: 0x4a
function function_994b4243() {
    self endon(#"back_door_opened");
    self endon(#"siegebot_alerted");
    self endon(#"death");
    hijackingplayer = self waittill(#"ccom_lock_being_targeted");
    trigger::use("trig_siegebot_alerted", "targetname");
}

// Namespace cp_mi_sing_biodomes_warehouse
// Params 15, eflags: 0x0
// Checksum 0x69ed9eda, Offset: 0x39a0
// Size: 0xb4
function function_c60cca3f(e_inflictor, e_attacker, n_damage, n_dflags, str_means_of_death, weapon, v_point, v_dir, str_hit_loc, var_46043680, psoffsettime, var_3bc96147, var_269779a, var_829b9480, var_eca96ec1) {
    trigger::use("trig_siegebot_alerted", "targetname");
    self.overridevehicledamage = &siegebot::function_3b05fc1b;
    return n_damage;
}

// Namespace cp_mi_sing_biodomes_warehouse
// Params 0, eflags: 0x0
// Checksum 0x92d962b8, Offset: 0x3a60
// Size: 0x5a
function function_4a9bba52() {
    level endon(#"back_door_opened");
    self setcandamage(0);
    level flag::wait_till("siegebot_damage_enabled");
    self setcandamage(1);
    self.overridevehicledamage = &function_c60cca3f;
}

// Namespace cp_mi_sing_biodomes_warehouse
// Params 0, eflags: 0x0
// Checksum 0x5f003cd8, Offset: 0x3ac8
// Size: 0x1d3
function function_bd5615c2() {
    var_95ad8660 = getaiarray("back_door_enemy", "script_aigroup");
    foreach (var_68fb9693 in var_95ad8660) {
        if (isalive(var_68fb9693)) {
            var_68fb9693.ignoreme = 1;
            var_68fb9693.ignoreall = 1;
        }
    }
    level util::waittill_either("start_back_door_retreat", "siegebot_damage_enabled");
    var_ec273240 = getent("back_door_goal_volume", "targetname");
    foreach (var_68fb9693 in var_95ad8660) {
        if (isalive(var_68fb9693)) {
            var_68fb9693.ignoreme = 0;
            var_68fb9693 setgoal(var_ec273240, 1);
        }
    }
    wait 10;
    foreach (var_68fb9693 in var_95ad8660) {
        if (isalive(var_68fb9693)) {
            var_68fb9693.ignoreall = 0;
        }
    }
}

// Namespace cp_mi_sing_biodomes_warehouse
// Params 0, eflags: 0x0
// Checksum 0x7e3da7b6, Offset: 0x3ca8
// Size: 0x7a
function function_e7b0cb8e() {
    self endon(#"death");
    self waittill(#"enemy");
    wait 0.05;
    while (isdefined(self.enemy) && !self cansee(self.enemy)) {
        wait 0.5;
    }
    self setgoal(getent("entire_warehouse_setgoal_volume", "targetname"));
}

// Namespace cp_mi_sing_biodomes_warehouse
// Params 0, eflags: 0x0
// Checksum 0x91981435, Offset: 0x3d30
// Size: 0x17a
function function_b1942036() {
    level endon(#"warehouse_warlord_retreated");
    trigger::wait_till("trig_back_door_close");
    savegame::checkpoint_save();
    wait 1.5;
    spawn_manager::enable("warehouse_enemy_warlord_manager");
    level waittill(#"warehouse_window_break");
    level thread clientfield::set("warehouse_window_break", 1);
    level flag::set("warehouse_warlord");
    objectives::hide("cp_waypoint_breadcrumb");
    spawner::simple_spawn("warehouse_enemy_group3", &function_29b416ff);
    getent("warehouse_overwatch_window", "targetname") delete();
    s_landing = struct::get("warehouse_warlord_surprise_landing");
    playrumbleonposition("cp_biodomes_warehouse_warlord_rumble", s_landing.origin);
    level thread function_62523f1d();
    level spawn_manager::wait_till_cleared("warehouse_enemy_warlord_manager");
    level flag::set("warehouse_warlord_dead");
}

// Namespace cp_mi_sing_biodomes_warehouse
// Params 0, eflags: 0x0
// Checksum 0xf217948d, Offset: 0x3eb8
// Size: 0xd2
function warehouse_warlord_friendly_goal() {
    level flag::wait_till("warehouse_warlord_friendly_goal");
    level.var_996e05eb = "friendly_spawns_warehouse_door";
    var_ab891f49 = getent("warehouse_warlord_friendly_volume", "targetname");
    foreach (var_f6c5842 in level.var_641fcd9c) {
        var_f6c5842 setgoal(var_ab891f49, 1);
    }
    level.var_2fd26037 setgoal(var_ab891f49, 1);
}

// Namespace cp_mi_sing_biodomes_warehouse
// Params 0, eflags: 0x0
// Checksum 0x189c6933, Offset: 0x3f98
// Size: 0x22
function function_29b416ff() {
    self endon(#"death");
    self.ignoreall = 1;
    wait 1;
    self.ignoreall = 0;
}

// Namespace cp_mi_sing_biodomes_warehouse
// Params 0, eflags: 0x0
// Checksum 0xd983db23, Offset: 0x3fc8
// Size: 0xc2
function function_4940548b() {
    self endon(#"death");
    self.ignoreall = 1;
    level scene::play("cin_bio_05_02_warehouse_aie_jump", self);
    self.goalradius = 2048;
    self.goalheight = 320;
    self cp_mi_sing_biodomes_util::function_f61c0df8("node_warlord_warehouse_preferred", 1, 3);
    wait 0.25;
    self.ignoreall = 0;
    self trigger::wait_till("trig_siegebot_alerted");
    self namespace_69ee7109::function_94b1213d();
    self cp_mi_sing_biodomes_util::function_f61c0df8("node_warlord_mountain_entrance_preferred", 1, 2);
    self waittill(#"death");
    self namespace_69ee7109::function_94b1213d();
}

// Namespace cp_mi_sing_biodomes_warehouse
// Params 0, eflags: 0x0
// Checksum 0x851a2bd9, Offset: 0x4098
// Size: 0x62
function function_62523f1d() {
    level endon(#"warehouse_warlord_dead");
    trigger::wait_till("trig_siegebot_alerted");
    for (var_7b95742a = 1; var_7b95742a; var_7b95742a = function_5ecd2f63()) {
        wait 1;
    }
    level flag::set("warehouse_warlord_retreated");
}

// Namespace cp_mi_sing_biodomes_warehouse
// Params 0, eflags: 0x0
// Checksum 0x90ff2b85, Offset: 0x4108
// Size: 0xb2
function function_5ecd2f63() {
    var_7c2eb0ca = getent("warehouse_warlord_retreat_check_volume", "targetname");
    var_bb2f0c05 = spawn_manager::function_423eae50("warehouse_enemy_warlord_manager");
    foreach (var_429f73c4 in var_bb2f0c05) {
        if (var_429f73c4 istouching(var_7c2eb0ca)) {
            return true;
        }
    }
    return false;
}

// Namespace cp_mi_sing_biodomes_warehouse
// Params 0, eflags: 0x0
// Checksum 0x71b6c883, Offset: 0x41c8
// Size: 0x42
function function_db58f411() {
    var_526a0aed = getent("pry_door", "script_noteworthy");
    level thread namespace_36171bd3::function_bb612155(var_526a0aed);
}

// Namespace cp_mi_sing_biodomes_warehouse
// Params 0, eflags: 0x0
// Checksum 0x7a93fe66, Offset: 0x4218
// Size: 0x5d
function function_3460d45c() {
    self endon(#"disconnect");
    level endon(#"hash_43a6ada4");
    while (true) {
        var_52b4a338 = self waittill(#"clonedentity");
        self namespace_7cb6cd95::function_6c745562(getent("hijacked_vehicle_range", "targetname"));
    }
}

// Namespace cp_mi_sing_biodomes_warehouse
// Params 0, eflags: 0x0
// Checksum 0x5646e0f6, Offset: 0x4280
// Size: 0x62
function cloud_mountain_crows() {
    level thread clientfield::set("cloud_mountain_crows", 1);
    level flag::wait_till_any(array("back_door_opened", "siegebot_damage_enabled"));
    level thread clientfield::set("cloud_mountain_crows", 2);
}

// Namespace cp_mi_sing_biodomes_warehouse
// Params 0, eflags: 0x0
// Checksum 0xe9c07cd6, Offset: 0x42f0
// Size: 0x2
function on_player_spawned() {
    
}

