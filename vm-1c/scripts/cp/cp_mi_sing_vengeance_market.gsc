#using scripts/codescripts/struct;
#using scripts/cp/_debug;
#using scripts/cp/_dialog;
#using scripts/cp/_load;
#using scripts/cp/_objectives;
#using scripts/cp/_quadtank_util;
#using scripts/cp/_skipto;
#using scripts/cp/_spawn_manager;
#using scripts/cp/_util;
#using scripts/cp/cp_mi_sing_vengeance_accolades;
#using scripts/cp/cp_mi_sing_vengeance_garage;
#using scripts/cp/cp_mi_sing_vengeance_sound;
#using scripts/cp/cp_mi_sing_vengeance_util;
#using scripts/cp/gametypes/_battlechatter;
#using scripts/cp/gametypes/_save;
#using scripts/shared/ai/archetype_warlord_interface;
#using scripts/shared/ai_shared;
#using scripts/shared/array_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/colors_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/hud_message_shared;
#using scripts/shared/math_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/stealth;
#using scripts/shared/system_shared;
#using scripts/shared/trigger_shared;
#using scripts/shared/turret_shared;
#using scripts/shared/util_shared;
#using scripts/shared/vehicle_ai_shared;
#using scripts/shared/vehicle_shared;
#using scripts/shared/vehicleriders_shared;
#using scripts/shared/vehicles/_quadtank;
#using scripts/shared/vehicles/_wasp;

#namespace namespace_e6a038a0;

// Namespace namespace_e6a038a0
// Params 2, eflags: 0x0
// Checksum 0x451045a0, Offset: 0x1550
// Size: 0x56c
function function_7b65c5ac(str_objective, var_74cd64bc) {
    if (var_74cd64bc) {
        load::function_73adcefc();
        callback::on_spawned(&namespace_63b4601c::give_hero_weapon);
        callback::on_spawned(&namespace_63b4601c::function_b9785164);
        namespace_63b4601c::function_66773296("hendricks", str_objective);
        level.var_2fd26037 colors::enable();
        level.var_2fd26037 ai::set_ignoreall(1);
        level.var_2fd26037 ai::set_ignoreme(1);
        level.var_2fd26037.goalradius = 32;
        objectives::set("cp_level_vengeance_rescue_kane");
        objectives::set("cp_level_vengeance_go_to_safehouse");
        objectives::hide("cp_level_vengeance_go_to_safehouse");
        level.var_29061a49 = vehicle::simple_spawn_single("garage_technical_01");
        level.var_29061a49 vehicle::lights_off();
        level.var_4f0894b2 = vehicle::simple_spawn_single("garage_technical_02");
        level.var_4f0894b2 vehicle::lights_off();
        e_car = getent("cop_car_2", "targetname");
        e_car kill();
        var_70f21d83 = struct::get("garage_igc_script_node", "targetname");
        var_70f21d83 thread scene::play("cin_ven_06_15_parkingstructure_deadbodies");
        var_5b01a37b = struct::get("quad_battle_script_node", "targetname");
        var_5b01a37b thread scene::init("cin_ven_07_11_openpath_wall_vign");
        level thread namespace_22334037::function_f0f8ed9f(var_74cd64bc);
        namespace_63b4601c::function_e00864bd("rear_garage_umbra_gate", 1, "rear_garage_gate");
        thread namespace_63b4601c::function_ffaf4723("quad_tank_wall_umbra_vol", "bathroom_umbra_gate", "bathroom_gate", "noflag");
        thread namespace_63b4601c::function_ffaf4723("quad_tank_wall_umbra_vol", "bathroom_ceiling_umbra_gate", "bathroom_ceiling_gate", "noflag");
        level thread function_31629d62();
        var_ecf5f255 = getentarray("quad_tank_color_triggers", "script_noteworthy");
        foreach (e_trig in var_ecf5f255) {
            e_trig triggerenable(0);
            e_trig.script_color_stay_on = 1;
        }
        load::function_a2995f22();
        wait 0.05;
        var_77d44b28 = getent("garage_player_gather_trigger", "targetname");
        var_77d44b28 triggerenable(0);
        level thread function_3ae8447c();
        level thread namespace_63b4601c::function_5dbf4126();
    }
    createthreatbiasgroup("quad_tank");
    var_43605624 = getent("exit_to_plaza", "targetname");
    var_43605624 triggerenable(0);
    level thread namespace_63b4601c::function_ef909043();
    level thread function_745ca395();
    level.var_2fd26037 thread function_dfffe1a9();
    level thread function_7d7a1bdd();
    function_590d6717();
}

// Namespace namespace_e6a038a0
// Params 4, eflags: 0x0
// Checksum 0x7ee105af, Offset: 0x1ac8
// Size: 0x3c
function function_463cdeb2(str_objective, var_74cd64bc, var_e4cd2b8b, player) {
    namespace_63b4601c::function_4e8207e9("garage_igc", 0);
}

// Namespace namespace_e6a038a0
// Params 0, eflags: 0x0
// Checksum 0x913866b4, Offset: 0x1b10
// Size: 0x104
function function_bd50a158() {
    var_2d4309d9 = getent("quad_battle_qt_ramp", "targetname");
    e_trigger = getent("quad_battle_qt_cleared_wall", "targetname");
    e_trigger triggerenable(0);
    level flag::wait_till("quad_battle_starts");
    e_trigger triggerenable(1);
    trigger::wait_till("quad_battle_qt_cleared_wall");
    var_2d4309d9 connectpaths();
    wait 0.05;
    var_2d4309d9 delete();
}

// Namespace namespace_e6a038a0
// Params 0, eflags: 0x0
// Checksum 0xed0f2ccd, Offset: 0x1c20
// Size: 0x4ac
function function_590d6717() {
    thread cp_mi_sing_vengeance_sound::function_10de79ba();
    level.var_2fd26037 namespace_63b4601c::function_5fbec645("hend_rally_on_me_and_let_0");
    level thread namespace_9fd035::function_973b77f9();
    objectives::set("cp_level_vengeance_go_to_safehouse");
    trigger::use("hendricks_qt_color_start", "targetname");
    var_77d44b28 = getent("garage_player_gather_trigger", "targetname");
    var_77d44b28 triggerenable(1);
    level thread objectives::breadcrumb("garage_player_gather_trigger", "cp_waypoint_breadcrumb", 0);
    level flag::wait_till("players_at_market");
    objectives::hide("cp_level_vengeance_go_to_safehouse");
    streamermodelhint("veh_t7_drone_quadtank_54i", 10);
    scene::add_scene_func("cin_ven_06_51_quadbattleintro_wall_vign", &namespace_63b4601c::function_ba7c52d5, "done", "quad_wall_static3");
    var_70f21d83 = struct::get("quad_battle_script_node", "targetname");
    var_70f21d83 scene::init("cin_ven_06_51_quadbattleintro_wall_vign");
    level flag::wait_till("quad_tank_start_anim");
    level thread function_27bbd465();
    if (isdefined(level.var_c8e36315)) {
        level thread [[ level.var_c8e36315 ]]();
    }
    var_70f21d83 thread scene::play("cin_ven_06_51_quadbattleintro_wall_vign");
    level thread cp_mi_sing_vengeance_sound::function_5bd9fe4();
    util::wait_network_frame();
    wait 0.4;
    level thread namespace_63b4601c::function_1c347e72("quad_wall_static1", "quad_wall_non_static1");
    wait 0.35;
    level.quadtank = spawner::simple_spawn_single("plaza_quadtank", &function_74c7f0db);
    level.quadtank thread namespace_855113f3::function_35209d64();
    callback::on_vehicle_damage(&function_4fc8c2e, level.quadtank);
    var_ecf5f255 = getentarray("quad_tank_color_triggers", "script_noteworthy");
    foreach (e_trig in var_ecf5f255) {
        e_trig triggerenable(1);
        e_trig.script_color_stay_on = 1;
    }
    level flag::set("quad_battle_starts");
    level thread quad_battle_enemies();
    level flag::wait_till("quad_enemies_done");
    level flag::set("quad_battle_ends");
    level.var_2fd26037 battlechatter::function_d9f49fba(0);
    savegame::checkpoint_save();
    level flag::wait_till("exiting_market");
    skipto::function_be8adfb8("quad_battle");
}

// Namespace namespace_e6a038a0
// Params 0, eflags: 0x0
// Checksum 0x704f4436, Offset: 0x20d8
// Size: 0x2ac
function quad_battle_enemies() {
    if (level.activeplayers.size > 1) {
        wait 8;
        level notify(#"hash_349fb948");
        spawn_manager::enable("quad_battle_reinforcements");
        level flag::wait_till_any(array("quadtank_hijacked", "quad_tank_dead"));
        a_enemies = spawner::get_ai_group_ai("quad_battle_enemies");
        if (a_enemies.size > 0) {
            wait 10;
            spawn_manager::disable("quad_battle_reinforcements");
        }
        var_2eebaf3b = getent("quad_battle_retreat_volume", "targetname");
        a_enemies = spawner::get_ai_group_ai("quad_battle_enemies");
        foreach (e_enemy in a_enemies) {
            if (isalive(e_enemy)) {
                e_enemy thread function_ee2d9cb4(var_2eebaf3b);
            }
        }
        if (a_enemies.size > 0) {
            wait 6;
        }
        if (flag::get("quadtank_hijacked")) {
            level flag::wait_till("qt_hijack_enemies_dead");
        }
        level flag::set("quad_enemies_done");
        return;
    }
    level flag::wait_till_any(array("quadtank_hijacked", "quad_tank_dead"));
    if (flag::get("quadtank_hijacked")) {
        level flag::wait_till("qt_hijack_enemies_dead");
    }
    level flag::set("quad_enemies_done");
}

// Namespace namespace_e6a038a0
// Params 1, eflags: 0x0
// Checksum 0x7ae33b03, Offset: 0x2390
// Size: 0xa4
function function_ee2d9cb4(volume) {
    self endon(#"death");
    self clearforcedgoal();
    self cleargoalvolume();
    self.fixednode = 0;
    self.forcegoal = 0;
    wait 0.1;
    self setgoal(volume, 1);
    self waittill(#"goal");
    self delete();
}

// Namespace namespace_e6a038a0
// Params 0, eflags: 0x0
// Checksum 0x1ae04d23, Offset: 0x2440
// Size: 0x184
function function_74c7f0db() {
    self thread function_7c605010();
    self thread function_c5cf1c5();
    self getperfectinfo(level.activeplayers[0]);
    self setthreatbiasgroup("quad_tank");
    physicsexplosioncylinder(self.origin, -64, -72, 5);
    setthreatbias("garage_hendricks", "quad_tank", 100);
    setthreatbias("quad_tank", "garage_hendricks", 10000);
    setthreatbias("garage_players", "quad_tank", 1000);
    util::delay(2.5, undefined, &objectives::set, "cp_level_vengeance_destroy_quad", self);
    self waittill(#"death");
    level flag::set("quad_tank_dead");
    objectives::hide("cp_level_vengeance_destroy_quad");
}

// Namespace namespace_e6a038a0
// Params 0, eflags: 0x0
// Checksum 0x419b1057, Offset: 0x25d0
// Size: 0x98
function function_c5cf1c5() {
    level endon(#"quad_tank_dead");
    while (true) {
        level waittill(#"clonedentity", var_52b4a338);
        if (isdefined(var_52b4a338.scriptvehicletype) && var_52b4a338.scriptvehicletype == "quadtank") {
            level flag::set("quadtank_hijacked");
            var_52b4a338 thread function_ca8f95ab();
        }
    }
}

// Namespace namespace_e6a038a0
// Params 0, eflags: 0x0
// Checksum 0x6526b2ed, Offset: 0x2670
// Size: 0xa4
function function_ca8f95ab() {
    self waittill(#"death");
    var_7f6ee28b = spawn("trigger_box", (-18575, -17133.5, -32), 0, 504, 375, 448);
    wait 10;
    if (isdefined(self) && self istouching(var_7f6ee28b)) {
        self delete();
    }
    var_7f6ee28b delete();
}

// Namespace namespace_e6a038a0
// Params 0, eflags: 0x0
// Checksum 0x6ae7030a, Offset: 0x2720
// Size: 0x14c
function function_7c605010() {
    self endon(#"death");
    var_c9ae457a = getent("qt_right_goalvolume", "targetname");
    self setneargoalnotifydist(384);
    self.goalradius = 384;
    self setgoal(var_c9ae457a, 1);
    self waittill(#"at_anchor");
    level flag::set("quad_tank_downstairs");
    str_side = "right";
    while (true) {
        if (str_side == "left") {
            str_side = "right";
        } else if (str_side == "right") {
            str_side = "left";
        }
        level flag::set("qt_" + str_side + "_side");
        self thread function_b331b9b2(str_side);
        self waittill(#"at_anchor");
    }
}

// Namespace namespace_e6a038a0
// Params 1, eflags: 0x0
// Checksum 0x78810b18, Offset: 0x2878
// Size: 0xec
function function_b331b9b2(str_side) {
    level notify(#"hash_b331b9b2");
    level endon(#"hash_b331b9b2");
    self endon(#"death");
    if (str_side == "left") {
        var_c9ae457a = getent("qt_left_goalvolume", "targetname");
    } else if (str_side == "right") {
        var_c9ae457a = getent("qt_right_goalvolume", "targetname");
    }
    if (isalive(self)) {
        self.goalradius = 384;
        self setgoal(var_c9ae457a, 1);
    }
}

// Namespace namespace_e6a038a0
// Params 0, eflags: 0x0
// Checksum 0x4b9e2490, Offset: 0x2970
// Size: 0xe4
function function_a5928078() {
    level.quadtank = spawner::simple_spawn_single("plaza_quadtank");
    var_136e4f5c = struct::get("quad_tank_checkpoint_death", "script_noteworthy");
    wait 0.05;
    level flag::wait_till("all_players_spawned");
    level.quadtank.origin = var_136e4f5c.origin;
    level.quadtank setcandamage(1);
    level.quadtank util::stop_magic_bullet_shield();
    level.quadtank kill();
}

// Namespace namespace_e6a038a0
// Params 0, eflags: 0x0
// Checksum 0x9ff68fa4, Offset: 0x2a60
// Size: 0x2cc
function function_7d7a1bdd() {
    level endon(#"quad_battle_ends");
    var_a3076518 = getent("sm_qt_hijack", "targetname");
    var_ab891f49 = getent("garage_enemy_n_goalvolume", "targetname");
    foreach (var_56b381f2 in getentarray(var_a3076518.target, "targetname")) {
        var_56b381f2 spawner::add_spawn_function(&function_a59909a9, var_ab891f49);
    }
    var_443c7feb = getent("sm_qt_hijack_normal", "targetname");
    foreach (var_1e913765 in getentarray(var_443c7feb.target, "targetname")) {
        var_1e913765 spawner::add_spawn_function(&function_a59909a9, var_ab891f49);
    }
    level flag::wait_till("quadtank_hijacked");
    spawn_manager::enable("sm_qt_hijack");
    spawn_manager::enable("sm_qt_hijack_normal");
    wait 0.5;
    level thread function_18ed3322();
    level thread function_547cd992();
    level flag::wait_till_all(array("qt_hijack_warlords_dead", "qt_hijack_grunts_dead"));
    level flag::set("qt_hijack_enemies_dead");
}

// Namespace namespace_e6a038a0
// Params 1, eflags: 0x0
// Checksum 0x68ccf2cb, Offset: 0x2d38
// Size: 0x2c
function function_a59909a9(e_vol) {
    self setgoal(e_vol, 1);
}

// Namespace namespace_e6a038a0
// Params 0, eflags: 0x0
// Checksum 0x27891201, Offset: 0x2d70
// Size: 0x3c
function function_18ed3322() {
    spawner::waittill_ai_group_ai_count("qt_hijack_enemies", 0);
    level flag::set("qt_hijack_warlords_dead");
}

// Namespace namespace_e6a038a0
// Params 0, eflags: 0x0
// Checksum 0xffb245a6, Offset: 0x2db8
// Size: 0x3c
function function_547cd992() {
    spawner::waittill_ai_group_ai_count("garage_enemies", 0);
    level flag::set("qt_hijack_grunts_dead");
}

// Namespace namespace_e6a038a0
// Params 0, eflags: 0x0
// Checksum 0x4cebe7b, Offset: 0x2e00
// Size: 0x484
function function_dfffe1a9() {
    self battlechatter::function_d9f49fba(0);
    level flag::wait_till("quad_tank_wall_broken");
    self colors::disable();
    self ai::set_ignoreall(0);
    self ai::set_ignoreme(0);
    self ai::set_behavior_attribute("cqb", 0);
    self ai::set_behavior_attribute("sprint", 1);
    self.ignoresuppression = 1;
    self.var_df53bc6 = self.script_accuracy;
    self.script_accuracy = 0.2;
    var_a392d7f9 = getnode("quad_battle_hendricks_node", "targetname");
    self setgoalnode(var_a392d7f9, 1);
    self waittill(#"goal");
    self thread function_fd7b3b3b();
    self thread function_1314293f();
    level flag::wait_till("quad_battle_ends");
    self ai::set_ignoreall(1);
    self ai::set_ignoreme(1);
    self colors::disable();
    self clearenemy();
    self.ignoresuppression = 0;
    self.script_accuracy = self.var_df53bc6;
    var_a392d7f9 = getnode("hendricks_exit_market_node", "targetname");
    self setgoalnode(var_a392d7f9, 1);
    level thread objectives::breadcrumb("goto_plaza_breadcrumb");
    level flag::wait_till("hendricks_exiting_market");
    self ai::set_behavior_attribute("sprint", 0);
    level thread plaza_enemies();
    self waittill(#"goal");
    var_43605624 = getent("exit_to_plaza", "targetname");
    var_43605624 triggerenable(1);
    var_5b01a37b = struct::get("quad_battle_script_node", "targetname");
    var_5b01a37b scene::play("cin_ven_07_10_enterplaza_vign");
    self setgoal(self.origin, 1);
    if (!level flag::get("exit_qt_battle")) {
        var_5b01a37b scene::init("cin_ven_07_11_openpath_vign");
        level flag::wait_till("exit_qt_battle");
    }
    level thread function_8ccac57d();
    var_5b01a37b thread scene::play("cin_ven_07_11_openpath_wall_vign");
    var_5b01a37b scene::play("cin_ven_07_11_openpath_vign");
    self setgoal(self.origin, 1);
    level flag::set("exiting_market");
}

// Namespace namespace_e6a038a0
// Params 0, eflags: 0x0
// Checksum 0x9b4246d4, Offset: 0x3290
// Size: 0x84
function function_8ccac57d() {
    level waittill(#"hash_8ccac57d");
    level flag::set("start_plaza_wave_2");
    var_ac036920 = getent("plaza_wall", "targetname");
    var_ac036920 connectpaths();
    var_ac036920 delete();
}

// Namespace namespace_e6a038a0
// Params 0, eflags: 0x0
// Checksum 0x1b3be1d, Offset: 0x3320
// Size: 0x6c
function function_fd7b3b3b() {
    level.quadtank endon(#"death");
    level flag::wait_till("quad_tank_downstairs");
    self colors::enable();
    wait 0.05;
    trigger::use("hendricks_qt_move_back");
}

// Namespace namespace_e6a038a0
// Params 0, eflags: 0x0
// Checksum 0xf438ee65, Offset: 0x3398
// Size: 0x90
function function_1314293f() {
    level.quadtank endon(#"death");
    while (true) {
        if (isdefined(self) && self isatcovernode()) {
            self ai::shoot_at_target("normal", level.quadtank, undefined, 5);
            wait 5;
        }
        wait randomintrange(10, 20);
    }
}

// Namespace namespace_e6a038a0
// Params 0, eflags: 0x0
// Checksum 0x83a41d08, Offset: 0x3430
// Size: 0x43c
function function_745ca395() {
    level.var_2fd26037 notify(#"hash_6f33cd57");
    level.var_2fd26037 battlechatter::function_d9f49fba(1);
    level.var_2fd26037.var_5d9fbd2d = 0;
    level flag::wait_till("players_at_market");
    thread cp_mi_sing_vengeance_sound::function_af95bc45();
    level thread function_6f79b65d();
    wait 1;
    level.var_2fd26037 thread namespace_63b4601c::function_5fbec645("hend_stop_do_you_hear_t_1");
    wait 2;
    level flag::set("quad_tank_start_anim");
    level flag::wait_till("quad_tank_wall_broken");
    wait 0.5;
    foreach (e_player in level.activeplayers) {
        e_player thread function_f14d81a9();
    }
    level.var_2fd26037 namespace_63b4601c::function_5fbec645("hend_quad_tank_take_cove_1", 0);
    level flag::wait_till("quad_battle_starts");
    level dialog::function_13b3b16a("plyr_draw_it_s_fire_i_ll_2");
    level.quadtank thread function_43458bf2();
    level.quadtank thread function_bc3db33d();
    level.quadtank thread function_55c599e4();
    level.quadtank thread function_e955ac45();
    level.quadtank thread function_82671202();
    level.quadtank thread function_23dea593();
    if (level.activeplayers.size > 1) {
        level thread function_f8295b7();
    }
    level flag::wait_till_any(array("quadtank_hijacked", "quad_tank_dead"));
    wait 0.5;
    a_enemies = spawner::get_ai_group_ai("quad_battle_enemies");
    var_3d8a616b = spawner::get_ai_group_ai("qt_hijack_enemies");
    if (a_enemies.size > 0) {
        namespace_22334037::function_73a79ca0("hend_i_think_it_s_down_fo_0");
    } else {
        namespace_22334037::function_73a79ca0("hend_i_think_we_got_it_l_0");
        if (var_3d8a616b.size > 0) {
            namespace_22334037::function_73a79ca0("hend_enemy_reinforcements_2");
        }
    }
    objectives::show("cp_level_vengeance_go_to_safehouse");
    level flag::wait_till("hendricks_exiting_market");
    level.var_2fd26037 namespace_63b4601c::function_5fbec645("hend_taylor_fucked_up_h_0");
    wait 0.75;
    level.var_2fd26037 namespace_63b4601c::function_5fbec645("hend_now_we_don_t_know_wh_0");
    level waittill(#"hash_15c8f178");
    level.var_2fd26037 namespace_63b4601c::function_5fbec645("hend_even_if_they_ve_hack_0");
}

// Namespace namespace_e6a038a0
// Params 0, eflags: 0x0
// Checksum 0x94b5d044, Offset: 0x3878
// Size: 0x44
function function_f14d81a9() {
    level.quadtank endon(#"death");
    self endon(#"hash_b8804640");
    wait 20;
    level.var_2fd26037 namespace_63b4601c::function_5fbec645("hend_we_need_something_bi_0");
}

// Namespace namespace_e6a038a0
// Params 0, eflags: 0x0
// Checksum 0x514c0a9a, Offset: 0x38c8
// Size: 0x122
function function_bc3db33d() {
    level.quadtank waittill(#"trophy_system_disabled");
    var_90911853 = getweapon("launcher_standard");
    foreach (e_player in level.activeplayers) {
        w_current_weapon = e_player getcurrentweapon();
        if (e_player hasweapon(var_90911853) && w_current_weapon != var_90911853) {
            e_player thread util::show_hint_text(%COOP_EQUIP_XM53, undefined, undefined, 6);
        }
    }
}

// Namespace namespace_e6a038a0
// Params 0, eflags: 0x0
// Checksum 0x3be712b6, Offset: 0x39f8
// Size: 0x178
function function_43458bf2() {
    level.quadtank endon(#"death");
    self endon(#"trophy_system_disabled");
    wait 20;
    var_c823b7c6 = [];
    var_c823b7c6[0] = "hend_shoot_out_its_weak_p_1";
    var_c823b7c6[1] = "hend_we_can_t_touch_this_0";
    var_c823b7c6[2] = "hend_target_it_s_weak_poi_0";
    var_c823b7c6[3] = "hend_nothing_s_getting_th_0";
    var_c823b7c6[4] = "hend_i_can_t_get_a_clear_0";
    var_c2667465 = undefined;
    while (true) {
        var_616d3e3e = array::random(var_c823b7c6);
        if (isdefined(var_c2667465) && var_c2667465 == var_616d3e3e) {
            while (var_c2667465 == var_616d3e3e) {
                var_616d3e3e = array::random(var_c823b7c6);
                wait 0.05;
            }
        }
        if (!isdefined(var_c2667465) || var_c2667465 != var_616d3e3e) {
            var_c2667465 = var_616d3e3e;
        }
        level.var_2fd26037 namespace_22334037::function_73a79ca0(var_616d3e3e);
        wait randomfloatrange(10, 15);
    }
}

// Namespace namespace_e6a038a0
// Params 0, eflags: 0x0
// Checksum 0x1f3bf369, Offset: 0x3b78
// Size: 0x88
function function_55c599e4() {
    self endon(#"death");
    while (true) {
        self waittill(#"trophy_system_disabled");
        namespace_22334037::function_73a79ca0("hend_hit_it_with_a_rocket_1");
        self waittill(#"hash_f015cdf7");
        self thread function_455f3062();
        self waittill(#"trophy_system_disabled");
        namespace_22334037::function_73a79ca0("hend_defenses_down_hit_0");
    }
}

// Namespace namespace_e6a038a0
// Params 0, eflags: 0x0
// Checksum 0xbe64571a, Offset: 0x3c08
// Size: 0x3c
function function_455f3062() {
    self endon(#"death");
    self endon(#"trophy_system_disabled");
    wait 20;
    namespace_22334037::function_73a79ca0("hend_it_s_defense_system_0");
}

// Namespace namespace_e6a038a0
// Params 0, eflags: 0x0
// Checksum 0xe587a35d, Offset: 0x3c50
// Size: 0x6c
function function_e955ac45() {
    self endon(#"death");
    self waittill(#"hash_f015cdf7");
    level dialog::function_13b3b16a("plyr_how_the_hell_is_this_0");
    self waittill(#"trophy_system_disabled");
    self waittill(#"hash_f015cdf7");
    namespace_22334037::function_73a79ca0("hend_it_s_back_online_wa_0");
}

// Namespace namespace_e6a038a0
// Params 2, eflags: 0x0
// Checksum 0xf8922fe1, Offset: 0x3cc8
// Size: 0x13e
function function_4fc8c2e(obj, params) {
    if (isplayer(params.eattacker)) {
        if (params.smeansofdeath === "MOD_RIFLE_BULLET" || params.smeansofdeath === "MOD_PISTOL_BULLET") {
            if (params.partname != "tag_target_lower" && params.partname != "tag_target_upper" && params.partname != "tag_defense_active" && params.partname != "tag_body_animate") {
                level notify(#"vo_bullet_damage");
            }
        }
        if (params.weapon.name === "launcher_standard" || params.weapon.name === "turret_bo3_civ_truck_pickup_tech_54i_grenade") {
            level notify(#"vo_direct_hit");
        }
    }
}

// Namespace namespace_e6a038a0
// Params 0, eflags: 0x0
// Checksum 0x9556ba8d, Offset: 0x3e10
// Size: 0x34
function function_82671202() {
    self endon(#"death");
    level waittill(#"vo_direct_hit");
    namespace_22334037::function_73a79ca0("hend_that_outta_slow_it_d_0");
}

// Namespace namespace_e6a038a0
// Params 0, eflags: 0x0
// Checksum 0x7a592131, Offset: 0x3e50
// Size: 0x2c
function function_f8295b7() {
    level waittill(#"hash_349fb948");
    namespace_22334037::function_73a79ca0("hend_54i_coming_in_from_t_0");
}

// Namespace namespace_e6a038a0
// Params 0, eflags: 0x0
// Checksum 0x1e383a71, Offset: 0x3e88
// Size: 0xa8
function function_23dea593() {
    self endon(#"death");
    var_361ba23a = [];
    var_361ba23a[0] = "hend_keep_moving_don_t_l_2";
    while (true) {
        wait 45;
        var_616d3e3e = array::random(var_361ba23a);
        namespace_22334037::function_73a79ca0(var_616d3e3e);
        var_361ba23a = array::exclude(var_361ba23a, var_616d3e3e);
        if (var_361ba23a.size < 1) {
            break;
        }
    }
}

// Namespace namespace_e6a038a0
// Params 0, eflags: 0x0
// Checksum 0x5000401d, Offset: 0x3f38
// Size: 0xb4
function function_3ae8447c() {
    hidemiscmodels("quad_wall_static3");
    level flag::wait_till("quad_battle_starts");
    wait 1;
    level flag::set("quad_tank_wall_broken");
    hidemiscmodels("quad_wall_static2");
    var_1e8fa774 = getent("quad_battle_intro_wall_clip", "targetname");
    var_1e8fa774 delete();
}

// Namespace namespace_e6a038a0
// Params 0, eflags: 0x0
// Checksum 0x5f8ae3bb, Offset: 0x3ff8
// Size: 0x4dc
function function_6f79b65d() {
    level util::clientnotify("start_qt_stomp");
    foreach (e_player in level.activeplayers) {
        screenshake(e_player.origin, 1, 0.5, 0.5, 0.5, 0, -1, 100, 7, 1, 1, 1, e_player);
        e_player playrumbleonentity("quadtank_footstep");
    }
    exploder::exploder("garage_wall_light_pulse");
    exploder::exploder("garage_wall_light_pulse_02");
    exploder::exploder("garage_dust_rattle");
    wait 1;
    foreach (e_player in level.activeplayers) {
        screenshake(e_player.origin, 2, 1, 1, 0.5, 0, -1, 100, 7, 1, 1, 1, e_player);
        e_player playrumbleonentity("quadtank_footstep");
    }
    exploder::exploder("garage_wall_light_pulse_03");
    exploder::exploder("garage_dust_rattle");
    wait 1;
    foreach (e_player in level.activeplayers) {
        screenshake(e_player.origin, 3, 2, 2, 0.5, 0, -1, 100, 7, 1, 1, 1, e_player);
        e_player playrumbleonentity("quadtank_footstep");
    }
    exploder::exploder("garage_wall_light_pulse_03");
    exploder::exploder("garage_dust_rattle");
    level flag::wait_till("quad_tank_wall_broken");
    level util::clientnotify("quad_tank_wall_broken");
    foreach (e_player in level.activeplayers) {
        screenshake(e_player.origin, 5, 2, 2, 0.5, 0, -1, 100, 7, 1, 1, 1, e_player);
        e_player playrumbleonentity("quadtank_footstep");
    }
    exploder::exploder("garage_wall_light_pulse_02");
    exploder::exploder("garage_dust_rattle");
    wait 1;
    exploder::stop_exploder("garage_wall_light_pulse");
}

// Namespace namespace_e6a038a0
// Params 0, eflags: 0x0
// Checksum 0x95124d7d, Offset: 0x44e0
// Size: 0x1c
function function_27bbd465() {
    exploder::exploder("garage_wall_light_flicker");
}

// Namespace namespace_e6a038a0
// Params 0, eflags: 0x0
// Checksum 0x75a52ce7, Offset: 0x4508
// Size: 0x102
function function_31629d62() {
    a_triggers = getentarray("garage_damage_trigger", "targetname");
    foreach (e_trigger in a_triggers) {
        var_ec523dd5 = getent(e_trigger.target, "targetname");
        var_ec523dd5 delete();
        wait 0.1;
        e_trigger delete();
    }
}

// Namespace namespace_e6a038a0
// Params 2, eflags: 0x0
// Checksum 0x1bbcc257, Offset: 0x4618
// Size: 0x644
function function_6e671181(str_objective, var_74cd64bc) {
    if (var_74cd64bc) {
        load::function_73adcefc();
        callback::on_spawned(&namespace_63b4601c::give_hero_weapon);
        callback::on_spawned(&namespace_63b4601c::function_b9785164);
        level thread function_a5928078();
        e_car = getent("cop_car_2", "targetname");
        e_car kill();
        level thread namespace_63b4601c::function_ef909043();
        namespace_63b4601c::function_66773296("hendricks", str_objective);
        wait 0.05;
        level.var_2fd26037 colors::disable();
        level.var_2fd26037 ai::set_ignoreall(1);
        level.var_2fd26037 ai::set_ignoreme(1);
        level.var_2fd26037.goalradius = 32;
        level.var_2fd26037 ai::set_behavior_attribute("cqb", 1);
        level.var_2fd26037 battlechatter::function_d9f49fba(0);
        level.var_2fd26037 setgoal(level.var_2fd26037.origin, 1);
        level flag::set("start_plaza_wave_2");
        objectives::set("cp_level_vengeance_rescue_kane");
        objectives::set("cp_level_vengeance_go_to_safehouse");
        level thread namespace_63b4601c::function_5dbf4126();
        var_70f21d83 = struct::get("garage_igc_script_node", "targetname");
        var_70f21d83 thread scene::play("cin_ven_06_15_parkingstructure_deadbodies");
        var_5b01a37b = struct::get("quad_battle_script_node", "targetname");
        var_5b01a37b thread scene::skipto_end("cin_ven_07_11_openpath_wall_vign");
        var_ac036920 = getent("plaza_wall", "targetname");
        var_ac036920 connectpaths();
        var_ac036920 delete();
        scene::add_scene_func("cin_ven_06_51_quadbattleintro_wall_vign", &namespace_63b4601c::function_ba7c52d5, "done", "quad_wall_static3");
        level thread namespace_63b4601c::function_1c347e72("quad_wall_static1", "quad_wall_non_static1");
        var_70f21d83 = struct::get("quad_battle_script_node", "targetname");
        var_70f21d83 thread scene::skipto_end("cin_ven_06_51_quadbattleintro_wall_vign");
        hidemiscmodels("quad_wall_static2");
        util::function_d8eaed3d(7);
        var_1e8fa774 = getent("quad_battle_intro_wall_clip", "targetname");
        var_1e8fa774 delete();
        thread namespace_63b4601c::function_ffaf4723("quad_tank_wall_umbra_vol", "bathroom_umbra_gate", "bathroom_gate", "noflag");
        thread namespace_63b4601c::function_ffaf4723("quad_tank_wall_umbra_vol", "bathroom_ceiling_umbra_gate", "bathroom_ceiling_gate", "noflag");
        level thread objectives::breadcrumb("trig_safehouse_plaza_breadcrumb");
        level thread plaza_enemies(var_74cd64bc);
        foreach (player in level.players) {
            player.ignoreme = 1;
        }
        load::function_a2995f22();
        level flag::set("initial_plaza_spawns");
        level thread function_88f591dc();
    }
    if (isdefined(level.stealth)) {
        level stealth::stop();
    }
    exploder::exploder("sh_tracer_all");
    namespace_523da15d::function_f03a38c7();
    level.var_2fd26037 thread function_fc4e0a9();
    level thread function_aecb2215();
    level thread cp_mi_sing_vengeance_sound::function_d56e8ba6();
    function_3a837c17();
}

// Namespace namespace_e6a038a0
// Params 4, eflags: 0x0
// Checksum 0x929fdb0f, Offset: 0x4c68
// Size: 0x13c
function function_e5fb7f0b(str_objective, var_74cd64bc, var_e4cd2b8b, player) {
    level struct::function_368120a1("scene", "cin_ven_06_10_parkingstructure_1st_shot08");
    level struct::function_368120a1("scene", "cin_ven_06_15_parkingstructure_deadbodies");
    level struct::function_368120a1("scene", "cin_ven_06_51_quadbattleintro_wall_vign");
    level struct::function_368120a1("scene", "cin_ven_07_10_enterplaza_vign");
    level struct::function_368120a1("scene", "cin_ven_07_11_openpath_vign");
    level struct::function_368120a1("scene", "cin_ven_07_11_openpath_wall_vign");
    level struct::function_368120a1("scene", "cin_ven_07_20_jumpdownplaza_vign");
}

// Namespace namespace_e6a038a0
// Params 0, eflags: 0x0
// Checksum 0x40e4c4e7, Offset: 0x4db0
// Size: 0x8e
function function_88f591dc() {
    wait 0.5;
    foreach (player in level.players) {
        player.ignoreme = 0;
    }
}

// Namespace namespace_e6a038a0
// Params 0, eflags: 0x0
// Checksum 0x655f223, Offset: 0x4e48
// Size: 0x2f4
function function_3a837c17() {
    level thread function_214b5ddf();
    level flag::wait_till_all(array("hendricks_at_plaza", "players_at_plaza"));
    thread namespace_63b4601c::function_ffaf4723("rear_garage_umbra_vol", "rear_garage_umbra_gate", "rear_garage_gate", "noflag");
    wait 0.5;
    if (isdefined(level.var_ec448797)) {
        level thread [[ level.var_ec448797 ]]();
    }
    objectives::hide("cp_level_vengeance_go_to_safehouse");
    level flag::set("plaza_hendricks_jump");
    wait 1;
    objectives::set("cp_level_vengeance_clear_plaza");
    foreach (e_player in level.activeplayers) {
        e_player thread function_29587c78();
    }
    level flag::wait_till("plaza_cleared");
    objectives::hide("cp_level_vengeance_clear_plaza");
    level.var_2fd26037 battlechatter::function_d9f49fba(0);
    var_5e72d25 = getent("obj_enter_sh", "targetname");
    obj_struct = struct::get(var_5e72d25.target, "targetname");
    level thread objectives::breadcrumb("players_near_safehouse");
    objectives::show("cp_level_vengeance_go_to_safehouse");
    level thread util::function_d8eaed3d(5);
    level scene::init("cin_ven_11_safehouse_3rd_sh010");
    wait 2;
    level.var_4c62d05f = function_f7d00e6a();
    objectives::hide("cp_level_vengeance_go_to_safehouse");
    skipto::function_be8adfb8("safehouse_plaza");
    namespace_523da15d::function_b4f6e07d();
}

// Namespace namespace_e6a038a0
// Params 0, eflags: 0x0
// Checksum 0xefd46ee3, Offset: 0x5148
// Size: 0x62
function function_f7d00e6a() {
    var_a3a9af43 = getent("players_near_safehouse", "targetname");
    var_a3a9af43 endon(#"death");
    var_a3a9af43 trigger::wait_till();
    return var_a3a9af43.who;
}

// Namespace namespace_e6a038a0
// Params 0, eflags: 0x0
// Checksum 0x2c62fe57, Offset: 0x51b8
// Size: 0x34
function function_214b5ddf() {
    trigger::wait_till("plaza_combat_failsafe");
    exploder::stop_exploder("fire_light_balcony");
}

// Namespace namespace_e6a038a0
// Params 0, eflags: 0x0
// Checksum 0xae8c1fd9, Offset: 0x51f8
// Size: 0x324
function function_fc4e0a9() {
    var_a392d7f9 = getnode("hendricks_plaza_node", "targetname");
    self setgoalnode(var_a392d7f9, 1);
    self waittill(#"goal");
    level flag::set("hendricks_at_plaza");
    level flag::wait_till("plaza_hendricks_jump");
    self ai::set_behavior_attribute("cqb", 0);
    self.goalradius = 16;
    s_struct = struct::get("safehouse_plaza_script_node", "targetname");
    s_struct scene::play("cin_ven_07_20_jumpdownplaza_vign");
    self colors::enable();
    trigger::use("start_plaza_color", "targetname");
    foreach (e_player in level.activeplayers) {
        e_player thread function_9af0090();
    }
    level flag::wait_till("plaza_combat_live");
    self battlechatter::function_d9f49fba(1);
    self ai::set_ignoreall(0);
    self ai::set_ignoreme(0);
    self thread namespace_63b4601c::function_5a886ae0();
    wait 10;
    e_trigger = getent("plaza_hendricks_color_sniper", "targetname");
    if (isdefined(e_trigger)) {
        trigger::use("plaza_hendricks_color_sniper", "targetname");
    }
    level flag::wait_till("plaza_cleared");
    self notify(#"hash_90a20e6d");
    self colors::disable();
    var_a392d7f9 = getnode("hendricks_approach_sh_node", "targetname");
    self setgoalnode(var_a392d7f9, 1);
}

// Namespace namespace_e6a038a0
// Params 1, eflags: 0x0
// Checksum 0xc51ff3d0, Offset: 0x5528
// Size: 0xbb4
function plaza_enemies(var_74cd64bc) {
    if (!isdefined(var_74cd64bc)) {
        var_74cd64bc = 0;
    }
    function_61d293c6();
    level flag::init("initial_plaza_spawns");
    level.remote_snipers = spawner::simple_spawn("remote_snipers");
    var_493d4f49 = vehicle::simple_spawn_single("plaza_enemies_technical_01");
    var_6f3fc9b2 = vehicle::simple_spawn_single("plaza_enemies_technical_02");
    wait 0.05;
    spawner::simple_spawn("plaza_enemies_wave_01");
    spawner::simple_spawn("plaza_amws_0");
    wait 0.05;
    spawn_manager::enable("plaza_allies_spawn_manager");
    setignoremegroup("54i_siegebots", "sh_allies");
    setignoremegroup("sh_wasps", "sh_allies");
    level.var_bcb63fa = spawner::simple_spawn("plaza_warlords");
    spawn_manager::enable("sh_wasp");
    if (var_74cd64bc) {
        level flag::wait_till("initial_plaza_spawns");
    }
    level flag::wait_till("start_plaza_wave_2");
    spawner::simple_spawn("plaza_enemies_wave_02");
    level flag::wait_till("plaza_combat_live");
    var_8304f83c = getent("plaza_volume_01", "targetname");
    var_f50c6777 = getent("plaza_volume_02", "targetname");
    var_cf09ed0e = getent("plaza_volume_03", "targetname");
    var_10fd8901 = getent("plaza_volume_04", "targetname");
    var_df5035df = getent("sh_steps_volume", "targetname");
    level.var_4982c438 = var_8304f83c;
    spawn_manager::enable("plaza_enemies_reinforcements");
    setthreatbias("players", "54i_warlords", 100000);
    trigger::wait_till("plaza_fallback_vol2", "targetname");
    level thread namespace_63b4601c::function_a084a58f();
    spawner::simple_spawn("plaza_warlords_3");
    spawner::simple_spawn("plaza_amws");
    level.var_4982c438 = var_f50c6777;
    level thread function_ea5edc3b(level.var_4982c438, var_8304f83c);
    level.var_bcb63fa = array::remove_dead(level.var_bcb63fa);
    level.var_bcb63fa = array::remove_undefined(level.var_bcb63fa);
    if (level.var_bcb63fa.size < 1) {
        spawner::simple_spawn("plaza_warlords_2");
    }
    trigger::wait_till("plaza_fallback_vol3", "targetname");
    level thread namespace_63b4601c::function_a084a58f();
    level.var_4982c438 = var_cf09ed0e;
    level thread function_ea5edc3b(level.var_4982c438, var_8304f83c, var_f50c6777);
    spawn_manager::disable("plaza_allies_spawn_manager", 1);
    a_allies = spawn_manager::function_423eae50("plaza_allies_spawn_manager");
    foreach (var_3b8db917 in a_allies) {
        if (isalive(var_3b8db917)) {
            var_3b8db917 thread function_47370bbe();
        }
    }
    level thread function_892fb7e0();
    spawner::simple_spawn("plaza_siegebots");
    setthreatbias("hendricks", "54i_siegebots", 1);
    setthreatbias("sh_allies", "54i_siegebots", 10);
    setthreatbias("players", "54i_siegebots", 100000);
    trigger::wait_till("plaza_fallback_vol4");
    level thread namespace_63b4601c::function_a084a58f();
    level.var_4982c438 = var_10fd8901;
    level thread function_ea5edc3b(level.var_4982c438, var_8304f83c, var_f50c6777, var_cf09ed0e);
    spawner::waittill_ai_group_ai_count("plaza_enemies", 9);
    level thread namespace_63b4601c::function_a084a58f();
    exploder::kill_exploder("sh_tracer_all");
    var_28d235b6 = getentarray("plaza_small_spawn_triggers", "targetname");
    array::delete_all(var_28d235b6);
    level.var_4982c438 = var_df5035df;
    guys = spawner::get_ai_group_ai("plaza_enemies");
    foreach (guy in guys) {
        if (isdefined(guy) && isalive(guy) && issubstr(guy.classname, "human") && !issubstr(guy.classname, "warlord")) {
            guy ai::set_behavior_attribute("move_mode", "rambo");
        }
    }
    level thread function_ea5edc3b(level.var_4982c438, var_8304f83c, var_f50c6777, var_cf09ed0e, var_10fd8901);
    spawner::waittill_ai_group_ai_count("plaza_enemies", 4);
    level thread namespace_63b4601c::function_a084a58f();
    spawner::kill_spawnernum(700);
    var_e5206be0 = getent("sh_steps_final_volume", "targetname");
    var_87cdd1a3 = getent("sh_allies_volume", "targetname");
    guys = spawner::get_ai_group_ai("plaza_enemies");
    foreach (guy in guys) {
        if (isdefined(guy.script_noteworthy) && guy.script_noteworthy == "siegebot") {
            guy setgoal(var_87cdd1a3, 1);
            continue;
        }
        guy setgoal(var_e5206be0, 1);
    }
    spawner::waittill_ai_group_ai_count("plaza_enemies", 1);
    guys = spawner::get_ai_group_ai("plaza_enemies");
    foreach (guy in guys) {
        if (isdefined(guy.script_noteworthy) && (!isdefined(guy.script_noteworthy) || isdefined(guy) && isalive(guy) && !issubstr(guy.classname, "warlord") && guy.script_noteworthy != "siegebot")) {
            guy kill();
        }
    }
    spawner::waittill_ai_group_ai_count("plaza_enemies", 0);
    level flag::set("plaza_cleared");
}

// Namespace namespace_e6a038a0
// Params 0, eflags: 0x0
// Checksum 0xb798490b, Offset: 0x60e8
// Size: 0x71a
function function_61d293c6() {
    createthreatbiasgroup("players");
    createthreatbiasgroup("hendricks");
    createthreatbiasgroup("sh_allies");
    createthreatbiasgroup("sh_wasps");
    createthreatbiasgroup("54i_grunts");
    createthreatbiasgroup("54i_reinforcements");
    createthreatbiasgroup("54i_warlords");
    createthreatbiasgroup("54i_siegebots");
    a_players = getplayers();
    foreach (e_player in a_players) {
        e_player setthreatbiasgroup("players");
    }
    level.var_2fd26037 setthreatbiasgroup("hendricks");
    spawner::add_spawn_function_group("remote_snipers", "targetname", &namespace_63b4601c::function_bce5a9e);
    spawner::add_global_spawn_function("axis", &function_eef8125c);
    spawner::add_spawn_function_group("plaza_enemies_wave_01", "targetname", &function_d824ba94, "54i_grunts");
    spawner::add_spawn_function_group("plaza_enemies_wave_01", "targetname", &function_db772ecc, 1024);
    spawner::add_spawn_function_group("plaza_enemies_wave_02", "targetname", &function_d824ba94, "54i_grunts");
    spawner::add_spawn_function_group("plaza_enemies_wave_02", "targetname", &function_db772ecc, 1024);
    var_443c7feb = getent("plaza_enemies_reinforcements", "targetname");
    spawner::add_spawn_function_group(var_443c7feb.target, "targetname", &function_d824ba94, "54i_reinforcements");
    spawner::add_spawn_function_group(var_443c7feb.target, "targetname", &function_db772ecc, 1750);
    spawner::add_spawn_function_group(var_443c7feb.target, "targetname", &function_688b4ed7);
    spawner::add_spawn_function_group("plaza_warlords", "targetname", &function_d824ba94, "54i_warlords");
    spawner::add_spawn_function_group("plaza_warlords", "targetname", &plaza_warlords);
    spawner::add_spawn_function_group("plaza_warlords_2", "targetname", &function_d824ba94, "54i_warlords");
    spawner::add_spawn_function_group("plaza_warlords_2", "targetname", &plaza_warlords);
    spawner::add_spawn_function_group("plaza_warlords_3", "targetname", &function_d824ba94, "54i_warlords");
    spawner::add_spawn_function_group("plaza_warlords_3", "targetname", &plaza_warlords);
    spawner::add_spawn_function_group("plaza_siegebots", "targetname", &function_d824ba94, "54i_siegebots");
    spawner::add_spawn_function_group("plaza_siegebots", "targetname", &function_3dc47c4e);
    var_4b4c408f = getent("plaza_allies_spawn_manager", "targetname");
    spawner::add_spawn_function_group(var_4b4c408f.target, "targetname", &function_d824ba94, "sh_allies");
    spawner::add_spawn_function_group(var_4b4c408f.target, "targetname", &function_db772ecc, 768);
    var_3e8c1c00 = getent("sh_wasp", "targetname");
    var_b60b5e6b = getent("plaza_volume_center", "targetname");
    foreach (var_aaefedf3 in getentarray(var_3e8c1c00.target, "targetname")) {
        vehicle::add_spawn_function(var_aaefedf3.targetname, &function_d824ba94, "sh_wasps");
        vehicle::add_spawn_function(var_aaefedf3.targetname, &function_68e4ea91, var_b60b5e6b);
    }
}

// Namespace namespace_e6a038a0
// Params 1, eflags: 0x0
// Checksum 0xde5d5ba8, Offset: 0x6810
// Size: 0x18
function function_db772ecc(goalradius) {
    self.goalradius = goalradius;
}

// Namespace namespace_e6a038a0
// Params 1, eflags: 0x0
// Checksum 0xf70ce297, Offset: 0x6830
// Size: 0x1da
function function_d824ba94(group) {
    self endon(#"death");
    self setthreatbiasgroup(group);
    if (level flag::get("plaza_combat_live")) {
        return;
    }
    if (group == "54i_grunts" || group == "54i_reinforcements" || group == "sh_wasps") {
        a_players = getplayers();
        foreach (e_player in a_players) {
            self setignoreent(e_player, 1);
        }
        level flag::wait_till("plaza_combat_live");
        a_players = getplayers();
        foreach (e_player in a_players) {
            self setignoreent(e_player, 0);
        }
    }
}

// Namespace namespace_e6a038a0
// Params 0, eflags: 0x0
// Checksum 0x296e0c1f, Offset: 0x6a18
// Size: 0x1f4
function function_688b4ed7() {
    var_391b0dcb = [];
    var_391b0dcb[0] = getent("plaza_volume_01", "targetname");
    var_391b0dcb[1] = getent("plaza_volume_02", "targetname");
    var_391b0dcb[2] = getent("plaza_volume_03", "targetname");
    var_391b0dcb[3] = getent("plaza_volume_04", "targetname");
    var_391b0dcb[4] = getent("sh_steps_volume", "targetname");
    index = 0;
    for (i = 0; i < var_391b0dcb.size; i++) {
        if (var_391b0dcb[i] == level.var_4982c438) {
            index = i;
        }
    }
    for (i = index; i >= 0; i--) {
        var_391b0dcb = array::remove_index(var_391b0dcb, i, 1);
    }
    if (var_391b0dcb.size == 0) {
        var_71484221 = getent("sh_steps_volume", "targetname");
    } else {
        var_71484221 = array::random(var_391b0dcb);
    }
    self setgoal(var_71484221, 1);
}

// Namespace namespace_e6a038a0
// Params 5, eflags: 0x0
// Checksum 0x80e2c66e, Offset: 0x6c18
// Size: 0x202
function function_ea5edc3b(fallback_vol, var_242401fb, var_b21c92c0, var_d81f0d29, var_962b7136) {
    a_enemies = spawner::get_ai_group_ai("plaza_enemies");
    foreach (e_enemy in a_enemies) {
        b_touching = 0;
        if (!isalive(e_enemy)) {
            break;
        }
        if (isdefined(e_enemy.script_noteworthy) && e_enemy.script_noteworthy == "siegebot") {
            break;
        }
        if (isdefined(var_242401fb) && e_enemy istouching(var_242401fb)) {
            b_touching = 1;
        }
        if (isdefined(var_b21c92c0) && e_enemy istouching(var_b21c92c0)) {
            b_touching = 1;
        }
        if (isdefined(var_d81f0d29) && e_enemy istouching(var_d81f0d29)) {
            b_touching = 1;
        }
        if (isdefined(var_962b7136) && e_enemy istouching(var_962b7136)) {
            b_touching = 1;
        }
        if (b_touching) {
            e_enemy setgoal(fallback_vol, 1);
        }
    }
}

// Namespace namespace_e6a038a0
// Params 0, eflags: 0x0
// Checksum 0x3e4ac244, Offset: 0x6e28
// Size: 0xda
function plaza_warlords() {
    self.goalheight = 512;
    var_eaf20b66 = getnodearray(self.script_noteworthy, "targetname");
    foreach (node in var_eaf20b66) {
        self namespace_69ee7109::function_da308a83(node.origin, 4000, 8000);
    }
}

// Namespace namespace_e6a038a0
// Params 0, eflags: 0x0
// Checksum 0x12cda8d2, Offset: 0x6f10
// Size: 0x4c
function function_3dc47c4e() {
    e_vol = getent("gv_plaza_siegebot", "targetname");
    self setgoal(e_vol, 1);
}

// Namespace namespace_e6a038a0
// Params 0, eflags: 0x0
// Checksum 0xb01dacb0, Offset: 0x6f68
// Size: 0x4c
function function_eef8125c() {
    self endon(#"death");
    if (!isdefined(self) || !isalive(self)) {
        return;
    }
    self.overrideactordamage = &function_7273d688;
}

// Namespace namespace_e6a038a0
// Params 12, eflags: 0x0
// Checksum 0x64abcbc4, Offset: 0x6fc0
// Size: 0xe8
function function_7273d688(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, modelindex, psoffsettime, bonename) {
    if (isdefined(eattacker) && !isplayer(eattacker) && eattacker != level.var_2fd26037) {
        idamage = 0;
    } else if (!level flag::get("plaza_combat_live")) {
        level flag::set("plaza_combat_live");
    }
    return idamage;
}

// Namespace namespace_e6a038a0
// Params 0, eflags: 0x0
// Checksum 0x90d19214, Offset: 0x70b0
// Size: 0x8a
function function_aecb2215() {
    foreach (e_player in level.activeplayers) {
        e_player thread function_dcf7f342();
    }
}

// Namespace namespace_e6a038a0
// Params 0, eflags: 0x0
// Checksum 0xfcd16acc, Offset: 0x7148
// Size: 0x90
function function_dcf7f342() {
    level endon(#"plaza_combat_live");
    while (true) {
        self waittill(#"weapon_fired", curweapon);
        if (!weaponhasattachment(curweapon, "suppressed") || curweapon.name != "ar_marksman_veng_hero_weap") {
            level flag::set("plaza_combat_live");
        }
    }
}

// Namespace namespace_e6a038a0
// Params 1, eflags: 0x0
// Checksum 0xd623fe90, Offset: 0x71e0
// Size: 0x3c
function function_68e4ea91(var_ab891f49) {
    self endon(#"death");
    if (isdefined(var_ab891f49)) {
        self setgoal(var_ab891f49, 1);
    }
}

// Namespace namespace_e6a038a0
// Params 0, eflags: 0x0
// Checksum 0x896eb2d9, Offset: 0x7228
// Size: 0x44
function function_47370bbe() {
    self endon(#"death");
    wait randomfloatrange(1.5, 5);
    self kill();
}

// Namespace namespace_e6a038a0
// Params 0, eflags: 0x0
// Checksum 0xa2645e14, Offset: 0x7278
// Size: 0x9c
function function_892fb7e0() {
    level endon(#"plaza_cleared");
    level thread function_5f5b64cf();
    exploder::exploder("sh_lhs_fire");
    wait 2.5;
    exploder::exploder("sh_rhs_fire");
    wait 10;
    exploder::exploder("sh_cent_fire");
    wait 6;
    exploder::exploder("sh_upper_fire");
}

// Namespace namespace_e6a038a0
// Params 0, eflags: 0x0
// Checksum 0xcb8f437, Offset: 0x7320
// Size: 0x74
function function_5f5b64cf() {
    level waittill(#"hash_ffdc982b");
    exploder::stop_exploder("sh_lhs_fire");
    exploder::stop_exploder("sh_rhs_fire");
    exploder::stop_exploder("sh_cent_fire");
    exploder::stop_exploder("sh_upper_fire");
}

// Namespace namespace_e6a038a0
// Params 0, eflags: 0x0
// Checksum 0x2cd01782, Offset: 0x73a0
// Size: 0x358
function function_29587c78() {
    self endon(#"disconnect");
    level endon(#"plaza_cleared");
    while (true) {
        eye = self geteye();
        eye_dir = anglestoforward(self getplayerangles());
        targets = getaiteamarray("axis");
        foreach (var_daf22616 in targets) {
            if (!isdefined(var_daf22616)) {
                continue;
            }
            if (distance2dsquared(self.origin, var_daf22616.origin) > 1048576) {
                continue;
            }
            var_bbf94a49 = var_daf22616.origin;
            if (issentient(var_daf22616)) {
                var_bbf94a49 = var_daf22616 geteye();
            }
            dir = vectornormalize(var_bbf94a49 - eye);
            if (vectordot(eye_dir, dir) > 0.99) {
                if (sighttracepassed(var_bbf94a49, eye, 0, undefined)) {
                    if (isalive(var_daf22616)) {
                        if (issubstr(var_daf22616.classname, "warlord")) {
                            wait 7;
                            continue;
                        }
                        if (issubstr(var_daf22616.classname, "rpg")) {
                            if (math::cointoss()) {
                                wait 7;
                                continue;
                            } else {
                                wait 7;
                                continue;
                            }
                        }
                        if (isdefined(var_daf22616.script_vehicleride) && var_daf22616.script_startingposition == "gunner1") {
                            wait 7;
                            continue;
                        }
                        if (isvehicle(var_daf22616)) {
                            if (issubstr(var_daf22616.vehicletype, "wasp")) {
                                level.var_2fd26037 namespace_63b4601c::function_5fbec645("hend_watch_the_skies_for_0", 0, 0, self);
                                wait 7;
                            }
                        }
                    }
                }
            }
        }
        wait 0.05;
    }
}

// Namespace namespace_e6a038a0
// Params 0, eflags: 0x0
// Checksum 0x6572ec89, Offset: 0x7700
// Size: 0x110
function function_9af0090() {
    self endon(#"disconnect");
    self endon(#"hash_c23c76ef");
    nag_vo = [];
    nag_vo[0] = "hend_get_down_here_we_go_0";
    nag_vo[1] = "hend_i_m_being_flanked_g_0";
    nag_vo[2] = "hend_get_your_ass_down_he_0";
    self thread function_2b657656();
    while (true) {
        wait randomintrange(10, 15);
        var_616d3e3e = array::random(nag_vo);
        level.var_2fd26037 namespace_63b4601c::function_5fbec645(var_616d3e3e, 0, 0, self);
        nag_vo = array::exclude(nag_vo, var_616d3e3e);
        if (nag_vo.size < 1) {
            break;
        }
    }
}

// Namespace namespace_e6a038a0
// Params 0, eflags: 0x0
// Checksum 0x41ae87e2, Offset: 0x7818
// Size: 0x42
function function_2b657656() {
    self endon(#"disconnect");
    trigger::wait_till("plaza_combat_failsafe", "targetname", self);
    self notify(#"hash_c23c76ef");
}

