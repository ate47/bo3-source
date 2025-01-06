#using scripts/codescripts/struct;
#using scripts/cp/_ammo_cache;
#using scripts/cp/_dialog;
#using scripts/cp/_load;
#using scripts/cp/_objectives;
#using scripts/cp/_skipto;
#using scripts/cp/_spawn_manager;
#using scripts/cp/_util;
#using scripts/cp/cp_mi_cairo_ramses2_fx;
#using scripts/cp/cp_mi_cairo_ramses2_sound;
#using scripts/cp/cp_mi_cairo_ramses_accolades;
#using scripts/cp/cp_mi_cairo_ramses_utility;
#using scripts/cp/gametypes/_battlechatter;
#using scripts/cp/gametypes/_save;
#using scripts/shared/ai/robot_phalanx;
#using scripts/shared/ai_shared;
#using scripts/shared/array_shared;
#using scripts/shared/audio_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/colors_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/fx_shared;
#using scripts/shared/hud_util_shared;
#using scripts/shared/math_shared;
#using scripts/shared/objpoints_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/trigger_shared;
#using scripts/shared/turret_shared;
#using scripts/shared/util_shared;
#using scripts/shared/vehicle_ai_shared;
#using scripts/shared/vehicle_shared;
#using scripts/shared/vehicleriders_shared;
#using scripts/shared/vehicles/_quadtank;
#using scripts/shared/vehicles/_raps;

#namespace quad_tank_plaza;

// Namespace quad_tank_plaza
// Params 0, eflags: 0x0
// Checksum 0x4f6b038d, Offset: 0x27e8
// Size: 0x22
function function_b39397dc() {
    precache();
    function_3a837c17();
}

// Namespace quad_tank_plaza
// Params 0, eflags: 0x0
// Checksum 0xe9c07cd6, Offset: 0x2818
// Size: 0x2
function precache() {
    
}

// Namespace quad_tank_plaza
// Params 0, eflags: 0x0
// Checksum 0x18d5bba3, Offset: 0x2828
// Size: 0x323
function function_ffea6b5() {
    level.var_6c4e8561 = getweapon("quadtank_main_turret");
    level.var_b27f706d = getweapon("quadtank_main_turret_player");
    level.var_51d112fe = getweapon("quadtank_main_turret_rocketpods_straight");
    level.var_9e92e4b8 = getweapon("quadtank_main_turret_rocketpods_javelin");
    level flag::init("quad_tank_1_destroyed");
    level flag::init("quad_tank_2_spawned");
    level flag::init("quad_tank_2_destroyed");
    level flag::init("spawn_quad_tank_3");
    level flag::init("quad_tank_3_spawned");
    level flag::init("demo_player_controlled_quadtank");
    level flag::init("qt1_left_side");
    level flag::init("qt1_right_side");
    level flag::init("qt1_died_in_a_bad_place");
    level flag::init("qt_targets_statue");
    level flag::init("qt_plaza_statue_destroyed");
    level flag::init("qt_plaza_rocket_building_destroyed");
    level flag::init("qt_plaza_theater_destroyed");
    level flag::init("qt_plaza_theater_enemies_cleared");
    level flag::init("qt_plaza_mobile_wall_destroyed");
    level flag::init("obj_plaza_cleared");
    level flag::init("obj_player_at_plaza_igc");
    level flag::init("obj_follow_khalil");
    level flag::init("spawn_second_quadtank");
    level flag::init("third_quadtank_killed");
    level flag::init("qt_plaza_outro_igc_started");
    level thread function_380293ce();
    level thread function_5f09970f();
    var_d0aa3ba1 = getnodearray("mobile_wall_exposed_nodes", "targetname");
    foreach (node in var_d0aa3ba1) {
        setenablenode(node, 0);
    }
}

// Namespace quad_tank_plaza
// Params 0, eflags: 0x0
// Checksum 0x2c2b45cd, Offset: 0x2b58
// Size: 0x3a
function function_315508b4() {
    var_cc018542 = getweapon("launcher_standard");
    self giveweapon(var_cc018542);
}

// Namespace quad_tank_plaza
// Params 0, eflags: 0x0
// Checksum 0x473a9a5a, Offset: 0x2ba0
// Size: 0x45a
function function_380293ce() {
    namespace_38256252::function_f77ccfb1();
    namespace_38256252::function_359e6bb1();
    function_61d293c6();
    function_29d63628();
    function_3535efe1();
    function_8ad4d7c();
    function_5cb0384();
    level thread function_31b1f0d3();
    level thread function_f794a879();
    var_a78d745a = getentarray("qt_plaza_start_amws_goalvolume", "targetname");
    var_5f595bb3 = getentarray("qt_plaza_start_amws", "targetname");
    level.var_73b96584 = [];
    foreach (var_aa888c9b in var_5f595bb3) {
        var_31e90922 = spawner::simple_spawn_single(var_aa888c9b);
        if (isdefined(var_31e90922)) {
            var_31e90922 setgoal(var_a78d745a[0], 1);
            var_a78d745a = array::remove_index(var_a78d745a, 0);
            level.var_73b96584[level.var_73b96584.size] = var_31e90922;
        }
        util::wait_network_frame();
    }
    util::wait_network_frame();
    vehicle::simple_spawn("qt_plaza_turret");
    util::wait_network_frame();
    spawn_manager::enable("sm_egypt_plaza_wall");
    util::wait_network_frame();
    spawn_manager::enable("sm_egypt_palace_window");
    util::wait_network_frame();
    spawn_manager::enable("sm_egypt_quadtank");
    util::wait_network_frame();
    spawn_manager::enable("sm_egypt_siegebot");
    util::wait_network_frame();
    var_408caf2f = getent("sm_nrc_siegebot", "targetname");
    level thread spawn_manager::function_617b3ed2("sm_nrc_siegebot", &wave_spawner, var_408caf2f, 20, 25, 2);
    spawn_manager::enable("sm_nrc_siegebot");
    util::wait_network_frame();
    var_408caf2f = getent("sm_nrc_quadtank", "targetname");
    level thread spawn_manager::function_617b3ed2("sm_nrc_quadtank", &wave_spawner, var_408caf2f, 20, 25, 4);
    spawn_manager::enable("sm_nrc_quadtank");
    util::wait_network_frame();
    spawn_manager::enable("qt1_nrc_wasp_sm");
    util::wait_network_frame();
    spawn_manager::enable("sm_nrc_govt_building_rpg");
    util::wait_network_frame();
    trigger::use("trig_color_vtol_igc_allies", "targetname");
    trigger::use("trig_color_post_vtol_igc_axis", "targetname");
    setthreatbias("NRC_Quadtank", "Egyptian_RPG_guys", 100000);
    while (!isdefined(level.var_6e86c9d5)) {
        wait 0.05;
    }
    level thread function_ba1db1();
}

// Namespace quad_tank_plaza
// Params 0, eflags: 0x0
// Checksum 0x2dcbf8a3, Offset: 0x3008
// Size: 0x52
function function_ba1db1() {
    level flag::wait_till("vtol_igc_done");
    var_9104e155 = getent("egyptian_retreat_guy_left_ai", "targetname");
    var_9104e155 thread function_4605fadc();
}

// Namespace quad_tank_plaza
// Params 0, eflags: 0x0
// Checksum 0xa394a3a4, Offset: 0x3068
// Size: 0x1d2
function function_4605fadc() {
    self endon(#"death");
    self ai::set_behavior_attribute("disablearrivals", 1);
    for (nd_pos = getnode("retreat_guy_left_path", "targetname"); isdefined(nd_pos); nd_pos = undefined) {
        self ai::force_goal(nd_pos, -128, 0, "near_goal", 1, 1);
        self util::waittill_any("near_goal", "goal");
        if (isdefined(nd_pos.target)) {
            nd_pos = getnode(nd_pos.target, "targetname");
            continue;
        }
    }
    s_scene = struct::get("s_qt_plaza_egypt_debriscover", "targetname");
    s_scene scene::play(self);
    for (nd_pos = getnode("retreat_guy_left_path_02", "targetname"); isdefined(nd_pos); nd_pos = undefined) {
        self ai::force_goal(nd_pos, -128, 0, "near_goal", 1, 1);
        self util::waittill_any("near_goal", "goal");
        if (isdefined(nd_pos.target)) {
            nd_pos = getnode(nd_pos.target, "targetname");
            continue;
        }
    }
    self ai::set_ignoreall(0);
    self util::stop_magic_bullet_shield();
}

// Namespace quad_tank_plaza
// Params 0, eflags: 0x0
// Checksum 0x3b2347e8, Offset: 0x3248
// Size: 0xf2
function function_69be7033() {
    self endon(#"death");
    nd_pos = getnode("retreat_guy_right_path", "targetname");
    self ai::set_ignoreall(1);
    while (isdefined(nd_pos)) {
        self ai::force_goal(nd_pos, -128, 0, "near_goal", 1, 1);
        self util::waittill_any("near_goal", "goal");
        if (isdefined(nd_pos.target)) {
            nd_pos = getnode(nd_pos.target, "targetname");
            continue;
        }
        nd_pos = undefined;
    }
    self ai::set_ignoreall(0);
    self util::stop_magic_bullet_shield();
}

// Namespace quad_tank_plaza
// Params 0, eflags: 0x0
// Checksum 0x81495def, Offset: 0x3348
// Size: 0x942
function function_61d293c6() {
    createthreatbiasgroup("Egyptian_RPG_guys");
    createthreatbiasgroup("NRC_Quadtank");
    createthreatbiasgroup("NRC_center_guys");
    createthreatbiasgroup("NRC_QT1_Shotgunners");
    createthreatbiasgroup("Players");
    createthreatbiasgroup("PlayerVehicles");
    createthreatbiasgroup("Egyptian_AI_near_players");
    createthreatbiasgroup("NRC_RPG_guys");
    createthreatbiasgroup("NRC_QT2_Robot_Rushers");
    createthreatbiasgroup("Egyptian_Theater_guys");
    createthreatbiasgroup("QT2_NRC_Raps");
    createthreatbiasgroup("QT2_Egyptian_Guys_on_Blocks");
    createthreatbiasgroup("NRC_Wasps");
    createthreatbiasgroup("NRC_AMWS");
    createthreatbiasgroup("NRC_theater_guys");
    setthreatbias("Players", "QT2_NRC_Raps", 1000);
    setthreatbias("PlayerVehicles", "QT2_NRC_Raps", 10000);
    setthreatbias("PlayerVehicles", "NRC_AMWS", 10000);
    setthreatbias("Players", "NRC_Quadtank", 0);
    setthreatbias("Players", "NRC_QT1_Shotgunners", -1000);
    setthreatbias("Players", "NRC_center_guys", -1000);
    setthreatbias("Players", "NRC_theater_guys", -1000);
    setthreatbias("Players", "NRC_Wasps", -1000);
    setthreatbias("Players", "NRC_AMWS", -1000);
    vehicle::add_spawn_function("demo_intro_mlrs_quadtank", &function_2bca1f0e);
    vehicle::add_hijack_function("demo_intro_mlrs_quadtank", &quadtank_hijacked);
    vehicle::add_spawn_function("artillery_quadtank", &function_92eb91a6);
    vehicle::add_hijack_function("artillery_quadtank", &quadtank_hijacked);
    vehicle::add_spawn_function("third_quadtank", &function_8f133c4d);
    vehicle::add_hijack_function("third_quadtank", &quadtank_hijacked);
    vehicle::add_spawn_function("qt_plaza_controllable_qt_raps", &function_861838cc);
    vehicle::add_spawn_function("qt_plaza_start_amws", &function_6626abd1);
    vehicle::add_spawn_function("qt1_nrc_amws", &function_d7eebeaa);
    vehicle::add_spawn_function("qt1_raps", &function_66735742);
    vehicle::add_spawn_function("qt_plaza_turret", &function_125f2ec4);
    vehicle::add_spawn_function("qt2_nrc_wasps", &function_af815dad);
    vehicle::add_spawn_function("qt2_nrc_wasps_berm", &function_fa8862c4);
    vehicle::add_spawn_function("qt2_nrc_wasps_palace", &function_eea6d34c);
    vehicle::add_spawn_function("qt2_raps", &function_505566c3);
    spawner::add_spawn_function_group("egypt_palace_window_guys", "targetname", &function_10a7788);
    spawner::add_spawn_function_group("egyptian_retreat_guy_left", "targetname", &function_3dd4db8a);
    spawner::add_spawn_function_group("egyptian_retreat_guy_right", "targetname", &function_3dd4db8a);
    spawner::add_spawn_function_group("statue_fall_guys", "targetname", &function_f3b08607);
    spawner::add_spawn_function_group("nrc_govt_building_rpg_guys", "targetname", &function_cfe4e726);
    spawner::add_spawn_function_group("nrc_rpg_berm_guys", "targetname", &function_5030bfcf);
    spawner::add_spawn_function_group("nrc_quadtank_guys", "targetname", &function_7f6c7e92);
    spawner::add_spawn_function_group("qt2_robot_rushers", "targetname", &function_17b4845b);
    spawner::add_spawn_function_group("qt2_ally_theater", "targetname", &function_663d1007);
    spawner::add_spawn_function_group("nrc_mobile_wall", "targetname", &function_7ea3ae59);
    spawner::add_spawn_function_group("nrc_theater", "targetname", &function_26fe7ac7);
    var_a72e524 = getentarray("plaza_wasps", "script_noteworthy");
    foreach (sp_wasp in var_a72e524) {
        sp_wasp spawner::add_spawn_function(&function_f12c1985);
    }
    var_5528d9d7 = getentarray("egypt_palace_window_guys", "targetname");
    var_c6e36417 = getentarray("egypt_plaza_wall_guy", "targetname");
    var_d9be40d5 = arraycombine(var_5528d9d7, var_c6e36417, 1, 0);
    foreach (var_25a9e204 in var_d9be40d5) {
        var_25a9e204 spawner::add_spawn_function(&function_18b305fb);
    }
    var_8cc24621 = getentarray("nrc_govt_building_rpg_guys", "targetname");
    var_2a6141a6 = getentarray("nrc_rpg_berm_guys", "targetname");
    var_de51d953 = arraycombine(var_8cc24621, var_2a6141a6, 1, 0);
    foreach (var_25a9e204 in var_de51d953) {
        var_25a9e204 spawner::add_spawn_function(&function_3a1fb3d);
    }
    spawner::simple_spawn("egyptian_retreat_guy_left");
}

// Namespace quad_tank_plaza
// Params 0, eflags: 0x0
// Checksum 0x94d1a30, Offset: 0x3c98
// Size: 0x5a
function function_18b305fb() {
    self setthreatbiasgroup("Egyptian_RPG_guys");
    var_c9ae457a = getent(self.target, "targetname");
    self setgoal(var_c9ae457a, 1);
}

// Namespace quad_tank_plaza
// Params 0, eflags: 0x0
// Checksum 0xaf396ba4, Offset: 0x3d00
// Size: 0x1a
function function_3a1fb3d() {
    self setthreatbiasgroup("NRC_RPG_guys");
}

// Namespace quad_tank_plaza
// Params 0, eflags: 0x0
// Checksum 0x13540eb1, Offset: 0x3d28
// Size: 0xa2
function function_2bca1f0e() {
    self endon(#"death");
    self thread function_4f1744c6();
    self util::magic_bullet_shield();
    self quadtank::function_4c6ee4cc(0);
    level flag::wait_till("vtol_igc_done");
    self util::stop_magic_bullet_shield();
    self quadtank::function_4c6ee4cc(1);
    self thread function_58013167();
    self thread function_8c0917d4();
    self thread function_80a9f826();
}

// Namespace quad_tank_plaza
// Params 0, eflags: 0x0
// Checksum 0xc26a1a08, Offset: 0x3dd8
// Size: 0x87
function function_4f1744c6() {
    self endon(#"death");
    level endon(#"vtol_igc_done");
    a_s_spots = struct::get_array("demo_qt1_vtol_igc_movement", "targetname");
    while (true) {
        s_spot = array::random(a_s_spots);
        self setgoal(s_spot.origin, 1);
        self waittill(#"at_anchor");
    }
}

// Namespace quad_tank_plaza
// Params 0, eflags: 0x0
// Checksum 0x565620f5, Offset: 0x3e68
// Size: 0x1d7
function function_58013167() {
    self endon(#"death");
    self flag::init("intro_qt_damage_threshold_reached");
    self thread function_5aabda9f();
    if (math::cointoss()) {
        a_s_spots = struct::get_array("demo_qt1_movement_left_side", "targetname");
        str_side = "left";
    } else {
        a_s_spots = struct::get_array("demo_qt1_movement_right_side", "targetname");
        str_side = "right";
    }
    while (true) {
        self function_6e99d691(a_s_spots, str_side);
        s_spot = struct::get("demo_qt1_movement_travel", "targetname");
        self setgoal(s_spot.origin, 1);
        self waittill(#"at_anchor");
        if (str_side == "left" || self flag::get("intro_qt_damage_threshold_reached")) {
            str_side = "right";
        } else if (str_side == "right" && !self flag::get("intro_qt_damage_threshold_reached")) {
            str_side = "left";
        }
        level flag::set("qt1_" + str_side + "_side");
        level thread function_36783b5e(str_side);
        a_s_spots = struct::get_array("demo_qt1_movement_" + str_side + "_side", "targetname");
    }
}

// Namespace quad_tank_plaza
// Params 0, eflags: 0x0
// Checksum 0x4a2fab4a, Offset: 0x4048
// Size: 0x61
function function_5aabda9f() {
    self endon(#"death");
    n_health_threshold = self.health / 2;
    while (true) {
        self waittill(#"damage");
        if (self.health <= n_health_threshold) {
            self notify(#"hash_6e17cb8c");
            self flag::set("intro_qt_damage_threshold_reached");
            break;
        }
    }
}

// Namespace quad_tank_plaza
// Params 2, eflags: 0x0
// Checksum 0x46992977, Offset: 0x40b8
// Size: 0xfd
function function_6e99d691(a_s_spots, str_side) {
    self endon(#"hash_f015cdf7");
    if (isdefined(60)) {
        __s = spawnstruct();
        __s endon(#"timeout");
        __s util::delay_notify(60, "timeout");
    }
    if (str_side == "left") {
        self endon(#"hash_6e17cb8c");
    }
    for (var_e5fcbdaa = undefined; true; var_e5fcbdaa = s_spot) {
        while (true) {
            s_spot = array::random(a_s_spots);
            if (isdefined(var_e5fcbdaa) && var_e5fcbdaa == s_spot) {
                continue;
            }
            break;
        }
        self setgoal(s_spot.origin, 1);
        self waittill(#"at_anchor");
    }
}

// Namespace quad_tank_plaza
// Params 0, eflags: 0x0
// Checksum 0x97c59581, Offset: 0x41c0
// Size: 0x82
function function_8c0917d4() {
    self waittill(#"death");
    e_trigger = getent("qt1_death_trigger", "targetname");
    if (!isdefined(self)) {
        return;
    }
    if (self istouching(e_trigger)) {
        wait 5;
        self disconnectpaths();
        level flag::set("qt1_died_in_a_bad_place");
    }
}

// Namespace quad_tank_plaza
// Params 0, eflags: 0x0
// Checksum 0x2ed01484, Offset: 0x4250
// Size: 0x4a
function function_6626abd1() {
    self endon(#"death");
    self endon(#"hash_f0738128");
    self util::magic_bullet_shield();
    level flag::wait_till("vtol_igc_done");
    self util::stop_magic_bullet_shield();
}

// Namespace quad_tank_plaza
// Params 0, eflags: 0x0
// Checksum 0x4177339b, Offset: 0x42a8
// Size: 0xda
function function_d7eebeaa() {
    self endon(#"death");
    self setthreatbiasgroup("NRC_AMWS");
    if (level flag::get("qt1_left_side")) {
        var_c9ae457a = getent("qt1_amws_right_goalvolume", "targetname");
        self setgoal(var_c9ae457a, 1);
    } else if (level flag::get("qt1_right_side")) {
        var_c9ae457a = getent("qt1_amws_left_goalvolume", "targetname");
        self setgoal(var_c9ae457a, 1);
    }
    self thread function_eafc7e80();
}

// Namespace quad_tank_plaza
// Params 0, eflags: 0x0
// Checksum 0x1897691d, Offset: 0x4390
// Size: 0x33
function function_eafc7e80() {
    self endon(#"death");
    trigger::wait_till("qt_plaza_alley_spawn_trigger", "targetname", self);
    level notify(#"hash_f922378a");
}

// Namespace quad_tank_plaza
// Params 1, eflags: 0x0
// Checksum 0xb08bac9f, Offset: 0x43d0
// Size: 0x17b
function function_36783b5e(str_side) {
    level notify(#"hash_36783b5e");
    level endon(#"hash_36783b5e");
    level flag::wait_till("vtol_igc_done");
    if (str_side == "left") {
        var_c9ae457a = getent("qt1_amws_right_goalvolume", "targetname");
    } else if (str_side == "right") {
        var_c9ae457a = getent("qt1_amws_left_goalvolume", "targetname");
    }
    var_c4ee2066 = getentarray("qt_plaza_start_amws_ai", "targetname", 1);
    var_c3aabf4a = getentarray("qt1_nrc_amws_ai", "targetname", 1);
    var_b9229bcd = arraycombine(var_c4ee2066, var_c3aabf4a, 1, 0);
    foreach (amws in var_b9229bcd) {
        if (isalive(amws)) {
            amws setgoal(var_c9ae457a, 1);
        }
    }
}

// Namespace quad_tank_plaza
// Params 0, eflags: 0x0
// Checksum 0xe50e7b4c, Offset: 0x4558
// Size: 0x9a
function function_8f133c4d() {
    self endon(#"death");
    var_b680c0d7 = struct::get("qt3_goalpos", "targetname");
    self setgoal(var_b680c0d7.origin);
    self waittill(#"at_anchor");
    level notify(#"hash_ef81aaa7");
    var_c9ae457a = getent("third_quadtank_goalvolume", "targetname");
    self setgoal(var_c9ae457a, 1);
}

// Namespace quad_tank_plaza
// Params 1, eflags: 0x0
// Checksum 0xad9cc9a6, Offset: 0x4600
// Size: 0xcf
function function_ca22c738(e_target) {
    self endon(#"death");
    self endon(#"hash_28b25b09");
    var_26080a40 = getweapon("quadtank_main_turret_rocketpods_straight");
    self.perfectaim = 1;
    while (true) {
        self vehicle_ai::setturrettarget(e_target, 0);
        self util::waittill_any_timeout(10, "turret_on_target");
        for (i = 0; i < 4 && isdefined(e_target); i++) {
            self setvehweapon(var_26080a40);
            self fireweapon(0, e_target);
            wait 0.8;
        }
        wait 10;
    }
}

// Namespace quad_tank_plaza
// Params 0, eflags: 0x0
// Checksum 0x2b5830bf, Offset: 0x46d8
// Size: 0x3e2
function function_f536966() {
    s_target = struct::get("qt3_cannon_shot_pos", "targetname");
    e_target = spawn("script_model", s_target.origin);
    e_target setmodel("tag_origin");
    e_target.health = 100;
    self thread function_ca22c738(e_target);
    n_count = 0;
    t_damage = getent("trigger_palace_collapse", "targetname");
    while (true) {
        t_damage waittill(#"damage", n_damage, attacker, direction_vec, point, type, modelname, tagname, partname, weapon, idflags);
        if (attacker === self || attacker === level.var_efe14c34) {
            if (type === "MOD_PROJECTILE" || type === "MOD_PROJECTILE_SPLASH") {
                n_count++;
                if (n_count > 1) {
                    e_target notify(#"death");
                    self notify(#"hash_28b25b09");
                    self.perfectaim = 0;
                    self clearturrettarget(0);
                    self setvehweapon(getweapon("quadtank_main_turret_rocketpods_javelin"));
                    break;
                }
            }
        }
    }
    level thread scene::play("p7_fxanim_cp_ramses_quadtank_plaza_building_rocket_bundle");
    level flag::set("qt_plaza_rocket_building_destroyed");
    t_damage delete();
    e_target delete();
    level thread function_447e47c0();
    function_b78937aa("qt2_intro_org");
    var_1e5c6939 = getent("palace_corner_breach_carver", "targetname");
    var_1e5c6939 delete();
    var_bce21891 = getentarray("palace_corner_breach", "targetname");
    foreach (var_8fa50159 in var_bce21891) {
        if (isdefined(var_8fa50159)) {
            var_8fa50159 delete();
        }
    }
    var_64dd962c = getentarray("palace_corner_blocker", "targetname");
    foreach (e_debris in var_64dd962c) {
        e_debris solid();
        e_debris disconnectpaths();
        e_debris show();
    }
    var_cac8b10c = getent("palace_corner_breach_collision", "targetname");
    var_cac8b10c solid();
}

// Namespace quad_tank_plaza
// Params 0, eflags: 0x0
// Checksum 0x196edbf2, Offset: 0x4ac8
// Size: 0x12a
function function_447e47c0() {
    level endon(#"qt_plaza_outro_igc_started");
    spawn_manager::disable("sm_egypt_palace_window");
    a_ai = spawn_manager::function_423eae50("sm_egypt_palace_window");
    foreach (ai in a_ai) {
        if (isalive(ai)) {
            ai kill();
        }
    }
    s_pos = struct::get("qt3_cannon_shot_pos", "targetname");
    physicsexplosionsphere(s_pos.origin, 768, 768, 1);
    wait 20;
    spawn_manager::enable("sm_egypt_palace_window");
}

// Namespace quad_tank_plaza
// Params 0, eflags: 0x0
// Checksum 0xf4e531f2, Offset: 0x4c00
// Size: 0x1a7
function function_5a4025b4() {
    foreach (player in level.players) {
        player.ignoreme = 1;
        player enableinvulnerability();
    }
    foreach (hero in level.heroes) {
        hero.ignoreme = 1;
    }
    level flag::wait_till("vtol_igc_done");
    wait 5;
    foreach (player in level.players) {
        player.ignoreme = 0;
        player disableinvulnerability();
    }
    foreach (hero in level.heroes) {
        hero.ignoreme = 0;
    }
}

// Namespace quad_tank_plaza
// Params 0, eflags: 0x0
// Checksum 0xd5e3966f, Offset: 0x4db0
// Size: 0x52
function function_10a7788() {
    self endon(#"death");
    self.ignoresuppression = 1;
    var_c9ae457a = getent(self.target, "targetname");
    self setgoal(var_c9ae457a, 1);
}

// Namespace quad_tank_plaza
// Params 0, eflags: 0x0
// Checksum 0x7c38cc5a, Offset: 0x4e10
// Size: 0x5a
function function_3dd4db8a() {
    self endon(#"death");
    self util::magic_bullet_shield();
    var_9de10fe3 = getnode(self.target, "targetname");
    self setgoal(var_9de10fe3, 1);
}

// Namespace quad_tank_plaza
// Params 0, eflags: 0x0
// Checksum 0xcff0af56, Offset: 0x4e78
// Size: 0x72
function function_125f2ec4() {
    if (!isdefined(level.var_34a51b7b)) {
        level.var_34a51b7b = [];
    }
    level.var_34a51b7b[level.var_34a51b7b.size] = self;
    self util::magic_bullet_shield();
    self vehicle::toggle_sounds(0);
    level flag::wait_till("vtol_igc_done");
    self vehicle::toggle_sounds(1);
}

// Namespace quad_tank_plaza
// Params 0, eflags: 0x0
// Checksum 0xfacab1e5, Offset: 0x4ef8
// Size: 0x72
function function_af815dad() {
    self endon(#"death");
    self setthreatbiasgroup("NRC_Wasps");
    var_c9ae457a = getent("pre_qt2_nrc_wasp_goalvolume", "targetname");
    self setgoal(var_c9ae457a, 1);
    self thread function_dd6f7fa6();
}

// Namespace quad_tank_plaza
// Params 0, eflags: 0x0
// Checksum 0x6ab6a6cc, Offset: 0x4f78
// Size: 0x82
function function_fa8862c4() {
    self endon(#"death");
    self setthreatbiasgroup("NRC_Wasps");
    var_c9ae457a = getent("qt2_nrc_wasp_berm_goalvolume", "targetname");
    self setgoal(var_c9ae457a, 1);
    self.attackeraccuracy = 0.25;
    self thread function_dd6f7fa6();
}

// Namespace quad_tank_plaza
// Params 0, eflags: 0x0
// Checksum 0x85c5dd71, Offset: 0x5008
// Size: 0x82
function function_eea6d34c() {
    self endon(#"death");
    self setthreatbiasgroup("NRC_Wasps");
    var_c9ae457a = getent("qt2_nrc_wasp_palace_goalvolume", "targetname");
    self setgoal(var_c9ae457a, 1);
    self.attackeraccuracy = 0.25;
    self thread function_dd6f7fa6();
}

// Namespace quad_tank_plaza
// Params 0, eflags: 0x0
// Checksum 0xe7666e98, Offset: 0x5098
// Size: 0x4b
function function_505566c3() {
    self endon(#"death");
    self setthreatbiasgroup("QT2_NRC_Raps");
    trigger::wait_till("qt_plaza_alley_spawn_trigger", "targetname", self);
    level notify(#"hash_c09bd13a");
}

// Namespace quad_tank_plaza
// Params 0, eflags: 0x0
// Checksum 0xed03fce, Offset: 0x50f0
// Size: 0x14d
function function_a5a3b915() {
    level endon(#"qt_plaza_outro_igc_started");
    a_s_start_points = struct::get_array("qt_plaza_magic_bullet_rpg", "targetname");
    weapon = getweapon("launcher_standard");
    while (true) {
        var_109bf731 = randomintrange(1, 4);
        for (i = 0; i < var_109bf731; i++) {
            s_start_point = array::random(a_s_start_points);
            var_8ae3db40 = struct::get_array(s_start_point.target, "targetname");
            var_197d929 = array::random(var_8ae3db40);
            magicbullet(weapon, s_start_point.origin, var_197d929.origin);
            wait randomfloatrange(2, 4);
        }
        wait randomfloatrange(20, 30);
    }
}

// Namespace quad_tank_plaza
// Params 0, eflags: 0x0
// Checksum 0x85215a90, Offset: 0x5248
// Size: 0x1da
function function_3a837c17() {
    level flag::wait_till("vtol_igc_done");
    level clientfield::set("alley_fxanim_curtains", 0);
    level.var_2fd26037 util::delay(10, undefined, &colors::set_force_color, "o");
    trigger::use("trig_color_post_vtol_igc_allies", "targetname");
    level thread function_767a3b7e();
    level thread function_77029c68();
    foreach (player in level.players) {
        player thread function_3460d45c();
    }
    callback::on_spawned(&function_3460d45c);
    level thread function_a9213e0b();
    level thread function_9866bb6();
    level thread function_8b6b15aa();
    level thread function_ffaf7dc4();
    if (isdefined(level.var_a9b12b6)) {
        level thread [[ level.var_a9b12b6 ]]();
    }
    level thread function_faf0f13b();
    level flag::wait_till("quad_tank_1_destroyed");
    level thread artillery_quadtank();
    level flag::wait_till("spawn_quad_tank_3");
    level thread third_quadtank();
}

// Namespace quad_tank_plaza
// Params 0, eflags: 0x0
// Checksum 0x5b8c7020, Offset: 0x5430
// Size: 0x7a
function function_ffaf7dc4() {
    level endon(#"qt_plaza_outro_igc_started");
    var_8c4a6a64 = getentarray("qtp_palace_rubble", "targetname");
    array::run_all(var_8c4a6a64, &notsolid);
    level waittill(#"hash_7352ee5f");
    array::run_all(var_8c4a6a64, &solid);
}

// Namespace quad_tank_plaza
// Params 0, eflags: 0x0
// Checksum 0x9062edf, Offset: 0x54b8
// Size: 0x5f
function function_767a3b7e() {
    while (true) {
        if (level.players.size > 1) {
            setignoremegroup("NRC_center_guys", "Egyptian_RPG_guys");
        }
        if (flag::get("quad_tank_1_destroyed")) {
            break;
        }
        level waittill(#"player_spawned");
    }
}

// Namespace quad_tank_plaza
// Params 0, eflags: 0x0
// Checksum 0x105a88dc, Offset: 0x5520
// Size: 0x52
function function_77029c68() {
    setignoremegroup("Players", "NRC_RPG_guys");
    setignoremegroup("Egyptian_AI_near_players", "NRC_RPG_guys");
    level thread function_ccebe14c();
}

// Namespace quad_tank_plaza
// Params 0, eflags: 0x0
// Checksum 0x8c7c2fca, Offset: 0x5580
// Size: 0xe7
function function_31b1f0d3() {
    level endon(#"third_quadtank_killed");
    foreach (player in level.players) {
        player setthreatbiasgroup("Players");
    }
    while (true) {
        level waittill(#"player_spawned");
        foreach (player in level.players) {
            player setthreatbiasgroup("Players");
        }
    }
}

// Namespace quad_tank_plaza
// Params 0, eflags: 0x0
// Checksum 0x6154a26d, Offset: 0x5670
// Size: 0x1d1
function function_ccebe14c() {
    level endon(#"third_quadtank_killed");
    while (true) {
        foreach (player in level.activeplayers) {
            a_ai = getaiteamarray("allies");
            foreach (ai in a_ai) {
                if (isdefined(ai.script_noteworthy) && ai.script_noteworthy == "qt_plaza_egyptian_rpg") {
                    continue;
                }
                var_7c6b6ceb = ai getthreatbiasgroup();
                if (isdefined(var_7c6b6ceb) && var_7c6b6ceb != "Egyptian_AI_near_players") {
                    continue;
                }
                n_distance = distance2dsquared(ai.origin, player.origin);
                if (n_distance <= 65536) {
                    ai setthreatbiasgroup("Egyptian_AI_near_players");
                    ai.Egyptian_AI_near_players = 1;
                    continue;
                }
                if (isdefined(ai.Egyptian_AI_near_players) && ai.Egyptian_AI_near_players) {
                    ai setthreatbiasgroup();
                    ai.Egyptian_AI_near_players = 0;
                }
            }
            wait 0.1;
        }
        wait 1;
    }
}

// Namespace quad_tank_plaza
// Params 0, eflags: 0x0
// Checksum 0xb23f0e1d, Offset: 0x5850
// Size: 0x3a
function function_5f09970f() {
    level thread function_9b403dd();
    level waittill(#"hash_53ee6132");
    level thread function_bc2f26d7();
    level thread function_83ec649e();
}

// Namespace quad_tank_plaza
// Params 0, eflags: 0x0
// Checksum 0xc89fa37a, Offset: 0x5898
// Size: 0x1ca
function function_bc2f26d7() {
    a_ai = spawner::simple_spawn("qt_plaza_egyptian_wounded");
    var_a917350c = getent("egyptian_wounded_carver", "targetname");
    var_a917350c disconnectpaths();
    var_b9229bcd = getentarray("qt_plaza_start_amws_ai", "targetname", 1);
    var_31e90922 = array::random(var_b9229bcd);
    var_31e90922 notify(#"hash_f0738128");
    var_31e90922 util::magic_bullet_shield();
    s_target = struct::get("egyptian_wounded_target", "targetname");
    e_target = spawn("script_model", s_target.origin);
    e_target setmodel("tag_origin");
    e_target.health = 100;
    var_31e90922 thread ai::shoot_at_target("shoot_until_target_dead", e_target);
    s_scene = struct::get("scene_qt_plaza_egyptian_wounded", "targetname");
    s_scene scene::skipto_end(a_ai, undefined, undefined, 0.375);
    var_31e90922 util::stop_magic_bullet_shield();
    var_a917350c delete();
    e_target notify(#"death");
    e_target delete();
}

// Namespace quad_tank_plaza
// Params 0, eflags: 0x0
// Checksum 0x8c65b3e6, Offset: 0x5a70
// Size: 0x2a
function function_3a7f574e() {
    self endon(#"death");
    self ai::set_ignoreme(1);
    self util::magic_bullet_shield();
}

// Namespace quad_tank_plaza
// Params 0, eflags: 0x0
// Checksum 0x5395ecd2, Offset: 0x5aa8
// Size: 0x20a
function function_83ec649e() {
    a_ai = spawner::simple_spawn("qt_plaza_egyptian_rescueinjured_guy", &function_3a7f574e);
    var_5524a904 = getent("qt_plaza_left_vignette_carver1", "targetname");
    var_5524a904 disconnectpaths();
    var_c72c183f = getent("qt_plaza_left_vignette_carver2", "targetname");
    var_c72c183f disconnectpaths();
    s_scene = struct::get("scene_qt_plaza_rescueinjured_r", "targetname");
    s_scene thread scene::skipto_end(a_ai, undefined, undefined, 0.25);
    level waittill(#"hash_59bf9070");
    var_5524a904 delete();
    foreach (ai in a_ai) {
        if (isalive(ai)) {
            ai ai::set_ignoreme(0);
            ai util::stop_magic_bullet_shield();
            ai colors::set_force_color("p");
            if (ai.animname === "arena_defend_intro_r_injured") {
                var_5ef22e15 = ai;
                var_5ef22e15 util::delay(60, "death", &kill);
            }
        }
    }
    if (isdefined(var_5ef22e15)) {
        var_5ef22e15 waittill(#"death");
    }
    var_c72c183f delete();
}

// Namespace quad_tank_plaza
// Params 0, eflags: 0x0
// Checksum 0x8f8c1b15, Offset: 0x5cc0
// Size: 0xbb
function function_9b403dd() {
    level waittill(#"hash_a59e04f0");
    a_s_scenes = struct::get_array("qt_plaza_last_stand_guys", "targetname");
    foreach (s_scene in a_s_scenes) {
        n_time = randomfloatrange(0.05, 0.15);
        s_scene thread scene::skipto_end(undefined, undefined, undefined, n_time);
    }
}

// Namespace quad_tank_plaza
// Params 0, eflags: 0x0
// Checksum 0xfbedfce7, Offset: 0x5d88
// Size: 0xda
function function_1fe24d50() {
    level.var_2fd26037 dialog::say("hend_we_need_to_clear_the_0");
    wait 1.5;
    level.var_2fd26037 dialog::say("hend_quad_tank_on_the_de_0");
    wait 1;
    level.var_2fd26037 dialog::say("hend_grab_that_launcher_a_0");
    level flag::wait_till("quad_tank_1_destroyed");
    level.var_2fd26037 dialog::say("hend_yeah_tank_down_kee_0");
    level flag::wait_till("obj_plaza_cleared");
    level.var_9db406db dialog::say("khal_regroup_on_me_0");
}

// Namespace quad_tank_plaza
// Params 0, eflags: 0x0
// Checksum 0xee4a65d9, Offset: 0x5e70
// Size: 0x202
function function_f794a879() {
    var_6b1c7f11 = spawner::simple_spawn_single("demo_intro_mlrs_quadtank");
    level.var_6e86c9d5 = var_6b1c7f11;
    var_6b1c7f11 setthreatbiasgroup("NRC_Quadtank");
    setthreatbias("Players", "NRC_Quadtank", -9999);
    var_6b1c7f11 quadtank::function_dd8d3882();
    var_6b1c7f11 util::magic_bullet_shield();
    level flag::wait_till("vtol_igc_done");
    var_6b1c7f11 quadtank::function_a093b43b();
    var_6b1c7f11 thread function_27b2ebf2();
    callback::on_vehicle_damage(&function_15abacf7);
    objectives::set("cp_level_ramses_destroy_quadtank", var_6b1c7f11);
    var_6b1c7f11 util::stop_magic_bullet_shield();
    level thread function_19351c55();
    level thread function_5a7e506e();
    spawn_manager::disable("qt1_nrc_wasp_sm");
    setthreatbias("Players", "NRC_Quadtank", 0);
    var_6b1c7f11 util::delay(3, undefined, &function_f536966);
    var_6b1c7f11 util::waittill_any("enter_vehicle", "death", "CloneAndRemoveEntity");
    level flag::set("quad_tank_1_destroyed");
    callback::remove_on_vehicle_damage(&function_15abacf7);
    savegame::checkpoint_save();
    objectives::complete("cp_level_ramses_destroy_quadtank");
}

// Namespace quad_tank_plaza
// Params 0, eflags: 0x0
// Checksum 0xc96052dc, Offset: 0x6080
// Size: 0xf9
function function_27b2ebf2() {
    self endon(#"death");
    var_fae93870 = 0;
    var_c1df3693 = 2;
    var_9a15ea97 = getweapon("launcher_standard");
    while (true) {
        self waittill(#"projectile_applyattractor", missile);
        if (missile.weapon === var_9a15ea97) {
            var_fae93870++;
            if (var_fae93870 >= var_c1df3693) {
                foreach (player in level.activeplayers) {
                    player util::show_hint_text(%CP_MI_CAIRO_RAMSES_QUADTANK_REPULSOR_HINT);
                }
                var_fae93870 = 0;
                var_c1df3693 *= 2;
            }
            wait 0.25;
        }
    }
}

// Namespace quad_tank_plaza
// Params 1, eflags: 0x0
// Checksum 0xb3ba3734, Offset: 0x6188
// Size: 0xf6
function function_15abacf7(params) {
    if (level.var_6e86c9d5 === self && self quadtank::function_fcd2c4ce()) {
        if (isplayer(params.eattacker) && issubstr(params.smeansofdeath, "BULLET")) {
            player = params.eattacker;
            if (isdefined(player.n_total_damage)) {
                player.n_total_damage += params.idamage;
            } else {
                player.n_total_damage = params.idamage;
            }
            if (player.n_total_damage > 999) {
                player util::show_hint_text(%CP_MI_CAIRO_RAMSES_QUADTANK_ROCKETS_HINT);
                player.n_total_damage = 0;
            }
        }
    }
}

// Namespace quad_tank_plaza
// Params 0, eflags: 0x0
// Checksum 0xa624b97e, Offset: 0x6288
// Size: 0x27b
function function_19351c55() {
    array::wait_till(level.var_73b96584, "death");
    var_d0aa3ba1 = getnodearray("qt1_nrc_truck_nodes", "script_noteworthy");
    foreach (node in var_d0aa3ba1) {
        setenablenode(node, 0);
    }
    wait 5;
    var_9f3935f2 = spawner::simple_spawn_single("nrc_qt1_truck");
    if (!isdefined(var_9f3935f2)) {
        return;
    }
    var_9f3935f2 thread function_5cbc0fea();
    var_9f3935f2 thread function_c2a9c2e3();
    var_dfb53de7 = spawner::simple_spawn_single("nrc_technical_gunner");
    var_dfb53de7 vehicle::get_in(var_9f3935f2, "gunner1", 1);
    var_44762fa4 = spawner::simple_spawn_single("nrc_technical_gunner");
    var_44762fa4 vehicle::get_in(var_9f3935f2, "driver", 1);
    var_51a35d76 = getvehiclenode(var_9f3935f2.target, "targetname");
    var_9f3935f2 thread vehicle::get_on_and_go_path(var_51a35d76);
    var_9f3935f2 thread function_e4aa3ab2(var_44762fa4);
    var_9f3935f2 turret::enable(1, 1);
    var_9f3935f2 makevehicleusable();
    var_9f3935f2 setseatoccupied(0);
    var_9f3935f2 util::waittill_any("death", "reached_end_node");
    foreach (node in var_d0aa3ba1) {
        setenablenode(node, 1);
    }
}

// Namespace quad_tank_plaza
// Params 0, eflags: 0x0
// Checksum 0x1d9c1781, Offset: 0x6510
// Size: 0x2a
function function_c2a9c2e3() {
    self endon(#"death");
    self waittill(#"hash_89126c82");
    wait 1;
    self playsound("evt_tech_driveup_qt");
}

// Namespace quad_tank_plaza
// Params 0, eflags: 0x0
// Checksum 0xcb5ed414, Offset: 0x6548
// Size: 0xaa
function function_5a7e506e() {
    level endon(#"quad_tank_1_destroyed");
    array::wait_till(level.var_73b96584, "death");
    level thread function_f922378a();
    var_408caf2f = getent("qt1_nrc_amws_sm", "targetname");
    level thread spawn_manager::function_617b3ed2("qt1_nrc_amws_sm", &wave_spawner, var_408caf2f, 10, 15, 2);
    spawn_manager::enable("qt1_nrc_amws_sm");
}

// Namespace quad_tank_plaza
// Params 0, eflags: 0x0
// Checksum 0x125e2041, Offset: 0x6600
// Size: 0x5b2
function artillery_quadtank() {
    var_edbda753 = getentarray("egyptian_retreat_guy_left_ai", "targetname");
    foreach (ai_guy in var_edbda753) {
        if (isalive(ai_guy)) {
            ai_guy dodamage(ai_guy.health, ai_guy.origin);
        }
    }
    trigger::use("trig_color_quadtank2_allies");
    trigger::use("trig_color_quadtank2_axis");
    level thread function_df4c5d7e();
    level notify(#"hash_b3aeb693");
    spawn_manager::disable("qt1_nrc_amws_sm");
    var_c9ae457a = getent("post_qt1_amws_goalvolume", "targetname");
    var_b9229bcd = spawn_manager::function_423eae50("qt1_nrc_amws_sm");
    foreach (amws in var_b9229bcd) {
        amws setgoal(var_c9ae457a, 1);
    }
    spawn_manager::enable("qt2_nrc_wasp_sm");
    spawn_manager::enable("sm_egypt_statue_fall");
    if (!level flag::get("qt_plaza_theater_destroyed")) {
        spawn_manager::enable("sm_egypt_theater");
    }
    level.var_9db406db = util::function_740f8516("khalil");
    level.var_9db406db colors::set_force_color("o");
    var_6836c6ff = struct::get("khalil_start", "targetname");
    level.var_9db406db skipto::function_d9b1ee00(var_6836c6ff);
    wait 5;
    level notify(#"hash_4232e97");
    spawn_manager::disable("qt2_nrc_wasp_sm");
    level thread function_db836bc0();
    scene::add_scene_func("p7_fxanim_cp_ramses_qt_plaza_palace_wall_collapse_bundle", &function_e0ba07f1, "play");
    level scene::play("p7_fxanim_cp_ramses_qt_plaza_palace_wall_collapse_bundle");
    level.var_76601d99 thread function_aa16fea2();
    level flag::set("quad_tank_2_spawned");
    objectives::set("cp_level_ramses_destroy_quadtank", level.var_76601d99);
    var_408caf2f = getent("qt2_nrc_wasp2_palace_sm", "targetname");
    level thread spawn_manager::function_617b3ed2("qt2_nrc_wasp2_palace_sm", &wave_spawner, var_408caf2f, 15, 20, 3);
    spawn_manager::enable("qt2_nrc_wasp2_palace_sm");
    var_408caf2f = getent("qt2_nrc_robot_rushers_sm", "targetname");
    level thread spawn_manager::function_617b3ed2("qt2_nrc_robot_rushers_sm", &wave_spawner, var_408caf2f, 10, 15, 3);
    spawn_manager::enable("qt2_nrc_robot_rushers_sm");
    setignoremegroup("Egyptian_RPG_guys", "NRC_QT2_Robot_Rushers");
    level thread function_3b542458();
    level thread function_2bfb7457();
    spawn_manager::enable("qt2_nrc_raps_sm");
    level thread function_c09bd13a();
    setignoremegroup("Egyptian_Theater_guys", "NRC_QT2_Robot_Rushers");
    setignoremegroup("NRC_QT2_Robot_Rushers", "Egyptian_Theater_guys");
    level flag::wait_till_any(array("qt_plaza_statue_destroyed", "quad_tank_2_destroyed", "demo_player_controlled_quadtank"));
    if (isalive(level.var_76601d99)) {
        level.var_76601d99 thread function_a65108b6();
        level.var_76601d99 thread function_6fd11e63();
    }
    level flag::wait_till_any(array("quad_tank_2_destroyed", "demo_player_controlled_quadtank"));
    objectives::complete("cp_level_ramses_destroy_quadtank");
}

// Namespace quad_tank_plaza
// Params 0, eflags: 0x0
// Checksum 0x990d438d, Offset: 0x6bc0
// Size: 0x72
function function_39ae1bbe() {
    level notify(#"hash_93673435");
    spawn_manager::disable("sm_nrc_depth");
    while (true) {
        var_f3e62b98 = spawn_manager::function_423eae50("sm_nrc_depth");
        if (var_f3e62b98.size <= 2) {
            break;
        }
        wait 1;
    }
    spawn_manager::enable("sm_nrc_qt2_depth");
}

// Namespace quad_tank_plaza
// Params 0, eflags: 0x0
// Checksum 0xa16f4ab1, Offset: 0x6c40
// Size: 0xc5
function function_2bfb7457() {
    level endon(#"qt_plaza_outro_igc_started");
    setignoremegroup("QT2_NRC_Raps", "QT2_Egyptian_Guys_on_Blocks");
    e_trigger = getent("qt2_egyptian_guys_on_blocks", "targetname");
    while (true) {
        e_trigger waittill(#"trigger", ent);
        var_7fa343c9 = ent getthreatbiasgroup();
        if (var_7fa343c9 == "QT2_Egyptian_Guys_on_Blocks") {
            wait 0.1;
            continue;
        }
        ent setthreatbiasgroup("QT2_Egyptian_Guys_on_Blocks");
    }
}

// Namespace quad_tank_plaza
// Params 1, eflags: 0x0
// Checksum 0x5168c79c, Offset: 0x6d10
// Size: 0x52
function function_e0ba07f1(a_ents) {
    var_ec523dd5 = getent("qt_plaza_palace_wall_collapse", "targetname");
    var_ec523dd5 thread function_1af8bdd3();
    var_ec523dd5 thread function_3cde9b26();
}

// Namespace quad_tank_plaza
// Params 0, eflags: 0x0
// Checksum 0xc50999c7, Offset: 0x6d70
// Size: 0x42
function function_1af8bdd3() {
    self waittill(#"hash_1af8bdd3");
    level notify(#"hash_78a974fe");
    spawn_manager::disable("sm_nrc_siegebot");
    function_b78937aa("qt2_intro_org");
}

// Namespace quad_tank_plaza
// Params 0, eflags: 0x0
// Checksum 0x2696674e, Offset: 0x6dc0
// Size: 0x39a
function function_3cde9b26() {
    self waittill(#"hash_3cde9b26");
    level.var_76601d99.var_ef5ed6ae = 0;
    level.var_76601d99.var_de9eba31 = 999;
    level.var_76601d99.var_da1f4811 = 0;
    level.var_76601d99 quadtank::function_fefa9078();
    level.var_76601d99 quadtank::function_dd8d3882();
    level.var_76601d99 quadtank::function_4c6ee4cc(0);
    level.var_76601d99 vehicle_ai::set_state("scripted");
    n_damage = level.var_76601d99.healthdefault * 0.25;
    var_7e1ceefd = int(n_damage);
    level.var_76601d99.health -= var_7e1ceefd;
    level.var_76601d99 vehicle::set_damage_fx_level(1);
    level.var_76601d99 hidepart("tag_lidar_null", "", 1);
    level.var_76601d99 hidepart("tag_defense_active");
    level.var_76601d99 notify(#"trophy_system_destroyed");
    level notify(#"trophy_system_destroyed", level.var_76601d99);
    level.var_76601d99 util::delay(3, undefined, &vehicle::toggle_lights_group, 1, 0);
    var_ea3d7abf = getentarray("qt_fall_event", "targetname");
    foreach (var_8fa50159 in var_ea3d7abf) {
        if (isdefined(var_8fa50159)) {
            var_8fa50159 delete();
        }
    }
    var_66ee586a = getent("qt2_intro_kill_trigger", "targetname");
    a_ai = getaiarray();
    var_b857e377 = arraycombine(a_ai, level.players, 1, 0);
    foreach (e_actor in var_b857e377) {
        if (e_actor util::is_hero()) {
            continue;
        }
        if (e_actor.targetname === "artillery_quadtank_ai") {
            continue;
        }
        if (e_actor istouching(var_66ee586a)) {
            if (isplayer(e_actor)) {
                e_actor dodamage(e_actor.health, e_actor.origin);
                break;
            }
            e_actor kill();
            break;
        }
    }
    function_b78937aa("qt2_intro_org");
}

// Namespace quad_tank_plaza
// Params 0, eflags: 0x0
// Checksum 0xc9d78e86, Offset: 0x7168
// Size: 0x3a
function function_92eb91a6() {
    level.var_76601d99 = self;
    self quadtank::function_a389866();
    self thread function_aa763092();
    self thread function_b4789248();
}

// Namespace quad_tank_plaza
// Params 1, eflags: 0x0
// Checksum 0xcc42fea7, Offset: 0x71b0
// Size: 0x8c
function function_703b62d1(var_fd827376) {
    if (!isdefined(var_fd827376)) {
        var_fd827376 = 0;
    }
    var_55141f56 = spawner::simple_spawn_single("artillery_quadtank");
    var_55141f56 ai::set_ignoreme(1);
    var_55141f56 ai::set_ignoreall(1);
    var_55141f56 quadtank::function_4c6ee4cc(0);
    if (!var_fd827376) {
        var_55141f56 setthreatbiasgroup("NRC_Quadtank");
    }
    level.var_76601d99 = var_55141f56;
    return var_55141f56;
}

// Namespace quad_tank_plaza
// Params 0, eflags: 0x0
// Checksum 0x6d9c503d, Offset: 0x7248
// Size: 0xd7
function function_a65108b6() {
    self endon(#"death");
    if (!level flag::get("qt1_died_in_a_bad_place")) {
        s_pos = struct::get("qt2_movement_path_A", "targetname");
    } else {
    }
    for (s_pos = struct::get("qt2_movement_path_B", "targetname"); isdefined(s_pos); s_pos = undefined) {
        self setgoal(s_pos.origin, 1);
        self waittill(#"at_anchor");
        if (isdefined(s_pos.target)) {
            s_pos = struct::get(s_pos.target, "targetname");
            continue;
        }
    }
}

// Namespace quad_tank_plaza
// Params 0, eflags: 0x0
// Checksum 0x4ffbeedc, Offset: 0x7328
// Size: 0xa2
function function_aa763092() {
    level endon(#"demo_player_controlled_quadtank");
    self waittill(#"death");
    wait 2;
    level flag::set("quad_tank_2_destroyed");
    savegame::checkpoint_save();
    trigger::use("trig_color_quadtank3_allies");
    trigger::use("trig_color_quadtank3_axis");
    wait 10;
    level flag::set("spawn_quad_tank_3");
    level thread function_32450fc();
}

// Namespace quad_tank_plaza
// Params 0, eflags: 0x0
// Checksum 0xaaf104ea, Offset: 0x73d8
// Size: 0x62
function function_b4789248() {
    level endon(#"quad_tank_2_destroyed");
    self waittill(#"cloneandremoveentity");
    level flag::set("demo_player_controlled_quadtank");
    level thread function_c6a0a6e5(self);
    level thread function_32450fc();
    wait 10;
    level flag::set("spawn_quad_tank_3");
}

// Namespace quad_tank_plaza
// Params 0, eflags: 0x0
// Checksum 0xcebf2574, Offset: 0x7448
// Size: 0x9a
function function_6fde5d65() {
    battlechatter::function_d9f49fba(0);
    level dialog::remote("tayr_we_need_to_expose_0");
    level dialog::remote("tayr_you_know_me_hendric_0", 2);
    level dialog::remote("tayr_you_were_supposed_to_0", 2);
    level dialog::remote("tayr_all_you_had_to_do_wa_0", 2);
    level dialog::remote("tayr_we_need_to_speak_to_0", 2);
    battlechatter::function_d9f49fba(1);
}

// Namespace quad_tank_plaza
// Params 0, eflags: 0x0
// Checksum 0x972fd90, Offset: 0x74f0
// Size: 0x12b
function function_32450fc() {
    level notify(#"hash_d1397f00");
    spawn_manager::disable("qt2_nrc_wasp2_palace_sm");
    level notify(#"hash_d1eb1d04");
    spawn_manager::disable("qt2_nrc_wasp2_berm_sm");
    var_c9ae457a = getent("post_qt2_wasp_goalvolume", "targetname");
    var_daa1cfc3 = spawn_manager::function_423eae50("qt2_nrc_wasp2_palace_sm");
    var_1edff0a3 = spawn_manager::function_423eae50("qt2_nrc_wasp2_berm_sm");
    a_wasps = arraycombine(var_daa1cfc3, var_1edff0a3, 1, 0);
    foreach (var_aaefedf3 in a_wasps) {
        var_aaefedf3 setgoal(var_c9ae457a, 1);
    }
}

// Namespace quad_tank_plaza
// Params 1, eflags: 0x0
// Checksum 0xf5561a53, Offset: 0x7628
// Size: 0x132
function function_c6a0a6e5(var_55141f56) {
    level notify(#"hash_a5b3808b");
    spawn_manager::disable("qt2_nrc_robot_rushers_sm");
    trigger::use("trig_color_player_controlled_QT_allies", "targetname");
    trigger::use("trig_color_player_controlled_QT_axis", "targetname");
    level thread function_f659f8de();
    while (!isdefined(level.var_dbed449f)) {
        wait 0.1;
    }
    level thread function_437a78f9();
    level thread function_4b083f55();
    level thread function_ff5161bd();
    level flag::wait_till_any(array("qt_plaza_theater_destroyed", "qt_plaza_theater_enemies_cleared", "spawn_quad_tank_3"));
    wait 3;
    spawn_manager::enable("qt_plaza_controllable_qt_raps_sm");
    level flag::set("spawn_quad_tank_3");
}

// Namespace quad_tank_plaza
// Params 0, eflags: 0x0
// Checksum 0xaa36127d, Offset: 0x7768
// Size: 0xc2
function function_437a78f9() {
    wait 3;
    var_d0aa3ba1 = getnodearray("mobile_wall_exposed_nodes", "targetname");
    foreach (node in var_d0aa3ba1) {
        setenablenode(node, 1);
    }
    spawn_manager::enable("nrc_mobile_wall_sm");
    spawn_manager::enable("demo_qt2_wasp_sm");
}

// Namespace quad_tank_plaza
// Params 0, eflags: 0x0
// Checksum 0x1d559b13, Offset: 0x7838
// Size: 0x5d
function function_faf0f13b() {
    level endon(#"qt_plaza_outro_igc_started");
    while (true) {
        level waittill(#"clonedentity", clone);
        if (clone.scriptvehicletype === "quadtank") {
            level.var_dbed449f = clone;
            level.var_dbed449f thread function_1491a9ea();
        }
    }
}

// Namespace quad_tank_plaza
// Params 0, eflags: 0x0
// Checksum 0x38c18f18, Offset: 0x78a0
// Size: 0x22
function function_1491a9ea() {
    self endon(#"death");
    wait 5;
    self vehicle::lights_off();
}

// Namespace quad_tank_plaza
// Params 0, eflags: 0x0
// Checksum 0xf8883ae9, Offset: 0x78d0
// Size: 0x3a
function function_ff5161bd() {
    level endon(#"third_quadtank_killed");
    spawn_manager::function_740ea7ff("nrc_theater_sm", 6);
    level flag::set("qt_plaza_theater_enemies_cleared");
}

// Namespace quad_tank_plaza
// Params 0, eflags: 0x0
// Checksum 0x4f23dfef, Offset: 0x7918
// Size: 0x14a
function function_f659f8de() {
    spawn_manager::disable("sm_egypt_theater");
    var_5b1067a4 = spawn_manager::function_423eae50("sm_egypt_theater");
    foreach (var_a30bd475 in var_5b1067a4) {
        var_a30bd475.health = 1;
    }
    wait 5;
    spawn_manager::enable("nrc_theater_sm");
    var_4f0f0c4c = getentarray("breach_doors", "targetname");
    foreach (var_97ed0dad in var_4f0f0c4c) {
        var_97ed0dad delete();
    }
    level thread function_d98bac2();
}

// Namespace quad_tank_plaza
// Params 0, eflags: 0x0
// Checksum 0xb35f72ee, Offset: 0x7a70
// Size: 0x383
function function_4b083f55() {
    var_d0aa3ba1 = getnodearray("qt3_nrc_truck_nodes", "script_noteworthy");
    foreach (node in var_d0aa3ba1) {
        setenablenode(node, 0);
    }
    var_d0aa3ba1 = getnodearray("qt1_nrc_truck_nodes", "script_noteworthy");
    foreach (node in var_d0aa3ba1) {
        setenablenode(node, 0);
    }
    var_f29ad39f = getentarray("nrc_qt3_truck", "targetname");
    var_9a38d227 = 1;
    foreach (var_2e36c27c in var_f29ad39f) {
        var_9f3935f2 = spawner::simple_spawn_single(var_2e36c27c);
        if (isdefined(var_9f3935f2)) {
            var_9f3935f2 thread function_5cbc0fea();
            var_dfb53de7 = spawner::simple_spawn_single("nrc_technical_gunner");
            var_dfb53de7 vehicle::get_in(var_9f3935f2, "gunner1", 1);
            var_44762fa4 = spawner::simple_spawn_single("nrc_technical_gunner");
            var_44762fa4 vehicle::get_in(var_9f3935f2, "driver", 1);
            var_51a35d76 = getvehiclenode(var_9f3935f2.target, "targetname");
            var_9f3935f2 thread vehicle::get_on_and_go_path(var_51a35d76);
            var_9f3935f2 thread function_e4aa3ab2(var_44762fa4);
            var_9f3935f2 thread function_56b0a5d2(var_9a38d227);
            var_9a38d227 += 1;
            var_9f3935f2 makevehicleusable();
            var_9f3935f2 setseatoccupied(0);
            var_9f3935f2 turret::enable(1, 1);
        }
        wait randomfloatrange(2, 5);
    }
    level thread function_4c7236e3();
    wait 5;
    var_d0aa3ba1 = getnodearray("qt1_nrc_truck_nodes", "script_noteworthy");
    foreach (node in var_d0aa3ba1) {
        setenablenode(node, 1);
    }
}

// Namespace quad_tank_plaza
// Params 1, eflags: 0x0
// Checksum 0x1bd3d042, Offset: 0x7e00
// Size: 0x3a
function function_56b0a5d2(counter) {
    self endon(#"death");
    self waittill(#"hash_89126c82");
    self playsound("evt_tech_driveup_qt_pair_" + counter);
}

// Namespace quad_tank_plaza
// Params 1, eflags: 0x0
// Checksum 0x48358fae, Offset: 0x7e48
// Size: 0x42
function function_e4aa3ab2(var_44762fa4) {
    self endon(#"death");
    self waittill(#"reached_end_node");
    if (isalive(var_44762fa4)) {
        var_44762fa4 vehicle::get_out();
    }
}

// Namespace quad_tank_plaza
// Params 0, eflags: 0x0
// Checksum 0x13a47d64, Offset: 0x7e98
// Size: 0x1cb
function function_5cbc0fea() {
    level endon(#"qt_plaza_outro_igc_started");
    while (true) {
        self waittill(#"damage", n_damage, attacker, direction_vec, point, type, modelname, tagname, partname, weapon, idflags);
        if (weapon == level.var_b27f706d || weapon == level.var_51d112fe || weapon == level.var_9e92e4b8) {
            self dodamage(self.health, self.origin);
            break;
        }
    }
    v_launch = anglestoforward(self.angles) * -350 + (0, 0, 200);
    v_org = self.origin + anglestoforward(self.angles) * 10;
    self launchvehicle(v_launch, v_org, 0);
    self thread function_1b1a9f3a();
    var_39352a5 = self.riders;
    foreach (ai in var_39352a5) {
        ai dodamage(ai.health, ai.origin);
    }
}

// Namespace quad_tank_plaza
// Params 0, eflags: 0x0
// Checksum 0x5715b3b4, Offset: 0x8070
// Size: 0x7a
function function_1b1a9f3a() {
    self endon(#"death");
    if (isdefined(60)) {
        __s = spawnstruct();
        __s endon(#"timeout");
        __s util::delay_notify(60, "timeout");
    }
    self waittill(#"veh_landed");
    if (isdefined(self)) {
        self playsound("evt_truck_impact");
    }
}

// Namespace quad_tank_plaza
// Params 0, eflags: 0x0
// Checksum 0xe03e5613, Offset: 0x80f8
// Size: 0x22
function function_861838cc() {
    self endon(#"death");
    self setthreatbiasgroup("QT2_NRC_Raps");
}

// Namespace quad_tank_plaza
// Params 0, eflags: 0x0
// Checksum 0x27b0c132, Offset: 0x8128
// Size: 0x52
function function_66735742() {
    self endon(#"death");
    self setthreatbiasgroup("QT2_NRC_Raps");
    self ai::set_ignoreme(1);
    self thread function_29ad7024();
    self thread function_6be08268();
}

// Namespace quad_tank_plaza
// Params 0, eflags: 0x0
// Checksum 0xda60e3c7, Offset: 0x8188
// Size: 0x37
function function_29ad7024() {
    level endon(#"hash_b4989133");
    level endon(#"quad_tank_1_destroyed");
    self endon(#"hash_f4ce781d");
    self waittill(#"cloneandremoveentity");
    self notify(#"hash_21d7c009");
    level notify(#"hash_b4989133");
}

// Namespace quad_tank_plaza
// Params 0, eflags: 0x0
// Checksum 0x222cf395, Offset: 0x81c8
// Size: 0x37
function function_6be08268() {
    level endon(#"hash_b4989133");
    level endon(#"quad_tank_1_destroyed");
    self endon(#"hash_21d7c009");
    self waittill(#"death");
    wait 2;
    if (isdefined(self)) {
        self notify(#"hash_f4ce781d");
    }
}

// Namespace quad_tank_plaza
// Params 0, eflags: 0x0
// Checksum 0x83f8d39, Offset: 0x8208
// Size: 0x252
function function_aa16fea2() {
    self endon(#"death");
    var_6587b577 = (10731, -15846, -56);
    self vehicle_ai::setturrettarget(var_6587b577, 0);
    self util::waittill_any_timeout(3, "turret_on_target");
    s_target = struct::get("qt_target_statue", "targetname");
    e_target = spawn("script_model", s_target.origin);
    e_target setmodel("tag_origin");
    e_target.health = 100;
    e_trigger = getent("statue_fall_damage_trigger", "targetname");
    self.perfectaim = 1;
    self.aim_set_by_shoot_at_target = 1;
    self vehicle_ai::set_state("combat");
    self thread ai::shoot_at_target("shoot_until_target_dead", e_target);
    self thread function_b4cabdde();
    level flag::set("qt_targets_statue");
    while (true) {
        e_trigger waittill(#"damage", n_damage, attacker, direction_vec, point, type, modelname, tagname, partname, weapon, idflags);
        if (attacker == self && isdefined(weapon) && weapon == level.var_6c4e8561) {
            e_target notify(#"death");
            level flag::set("qt_plaza_statue_destroyed");
            self.perfectaim = 0;
            self.aim_set_by_shoot_at_target = 0;
            break;
        }
    }
    level thread function_3ec052d8();
    e_target delete();
    level thread function_7432965b();
    wait 2;
    self thread function_24cd2cab();
}

// Namespace quad_tank_plaza
// Params 0, eflags: 0x0
// Checksum 0xff6faacd, Offset: 0x8468
// Size: 0x202
function function_24cd2cab() {
    self endon(#"death");
    s_target = struct::get("mobile_wall_fxanim", "targetname");
    self vehicle_ai::setturrettarget(s_target.origin, 0);
    self util::waittill_any_timeout(3, "turret_on_target");
    e_target = spawn("script_model", s_target.origin);
    e_target setmodel("tag_origin");
    e_target.health = 100;
    e_trigger = getent("mobile_wall_damage_trigger", "targetname");
    self.perfectaim = 1;
    self.aim_set_by_shoot_at_target = 1;
    self vehicle_ai::set_state("combat");
    self thread ai::shoot_at_target("shoot_until_target_dead", e_target);
    while (true) {
        e_trigger waittill(#"damage", n_damage, attacker, direction_vec, point, type, modelname, tagname, partname, weapon, idflags);
        if (attacker == self && isdefined(weapon) && weapon == level.var_6c4e8561) {
            e_target notify(#"death");
            level flag::set("qt_plaza_mobile_wall_destroyed");
            self.perfectaim = 0;
            self.aim_set_by_shoot_at_target = 0;
            break;
        }
    }
    level thread mobile_wall_fxanim();
    e_target delete();
}

// Namespace quad_tank_plaza
// Params 0, eflags: 0x0
// Checksum 0x4f4dbadc, Offset: 0x8678
// Size: 0x52
function function_f3b08607() {
    self endon(#"death");
    self util::magic_bullet_shield();
    self ai::set_ignoreme(1);
    self waittill(#"qt_plaza_statue_retreat");
    self util::stop_magic_bullet_shield();
    self ai::set_ignoreme(0);
}

// Namespace quad_tank_plaza
// Params 0, eflags: 0x0
// Checksum 0xbe9d3028, Offset: 0x86d8
// Size: 0x2bf
function function_b4cabdde() {
    a_ai = getentarray("statue_fall_guys_ai", "targetname", 1);
    spawn_manager::kill("sm_egypt_statue_fall");
    a_s_scenes = struct::get_array("qt_plaza_statue_retreat", "targetname");
    var_8f99a358 = arraycopy(a_s_scenes);
    while (isalive(self) && self.var_872042b7 === 0) {
        wait 0.05;
    }
    foreach (ai in a_ai) {
        s_scene = arraygetclosest(ai.origin, var_8f99a358);
        arrayremovevalue(var_8f99a358, s_scene, 0);
        s_scene thread scene::init(ai);
        wait randomfloatrange(0.1, 0.25);
    }
    level flag::wait_till_any(array("qt_plaza_statue_destroyed", "quad_tank_2_destroyed", "demo_player_controlled_quadtank"));
    if (level flag::get("qt_plaza_statue_destroyed")) {
        level thread function_e388dd6b(a_ai);
        foreach (s_scene in a_s_scenes) {
            s_scene thread scene::play();
            wait randomfloatrange(0.1, 0.25);
        }
    } else {
        level scene::stop("cin_gen_react_retreat");
    }
    foreach (ai in a_ai) {
        if (isalive(ai)) {
            ai notify(#"qt_plaza_statue_retreat");
            ai.goalradius = 512;
        }
    }
}

// Namespace quad_tank_plaza
// Params 0, eflags: 0x0
// Checksum 0x70b77f0d, Offset: 0x89a0
// Size: 0x7b
function function_cfe4e726() {
    self endon(#"death");
    var_c9ae457a = getent(self.target, "targetname");
    self setgoal(var_c9ae457a, 1);
    self.ignoresuppression = 1;
    trigger::wait_till(self.target, "targetname", self);
    level notify(#"hash_9866bb6");
}

// Namespace quad_tank_plaza
// Params 0, eflags: 0x0
// Checksum 0x4514da18, Offset: 0x8a28
// Size: 0x1a
function function_26fe7ac7() {
    self setthreatbiasgroup("NRC_theater_guys");
}

// Namespace quad_tank_plaza
// Params 0, eflags: 0x0
// Checksum 0x7149651f, Offset: 0x8a50
// Size: 0x73
function function_5030bfcf() {
    self endon(#"death");
    var_c9ae457a = getent(self.target, "targetname");
    self setgoal(var_c9ae457a, 1);
    trigger::wait_till(self.target, "targetname", self);
    level notify(#"hash_8b6b15aa");
}

// Namespace quad_tank_plaza
// Params 0, eflags: 0x0
// Checksum 0xafbf74b3, Offset: 0x8ad0
// Size: 0x162
function function_7f6c7e92() {
    self endon(#"death");
    self setthreatbiasgroup("NRC_center_guys");
    if (level.players.size > 1) {
        a_ai = spawn_manager::function_423eae50("sm_nrc_quadtank");
        if (a_ai.size > 0 && isdefined(level.var_34a51b7b) && level.var_34a51b7b.size > 0) {
            foreach (e_turret in level.var_34a51b7b) {
                e_turret turret::function_37450ddc(a_ai, 0);
            }
        }
    }
    if (!level flag::get("quad_tank_1_destroyed")) {
        if (issubstr(self.classname, "shotgun")) {
            n_count = spawner::get_ai_group_ai("qt1_nrc_shotgunner").size;
            if (n_count < 4) {
                self thread function_831f9a1b();
            }
            return;
        }
        self thread function_6639b8f8();
    }
}

// Namespace quad_tank_plaza
// Params 0, eflags: 0x0
// Checksum 0x5f28cfa0, Offset: 0x8c40
// Size: 0x132
function function_831f9a1b() {
    self endon(#"death");
    self flag::init("nrc_qt1_shotgunner_rush");
    self setthreatbiasgroup("NRC_QT1_Shotgunners");
    setignoremegroup("NRC_QT1_Shotgunners", "Egyptian_RPG_guys");
    setignoremegroup("Egyptian_RPG_guys", "NRC_QT1_Shotgunners");
    self thread function_10c25a20();
    self waittill(#"goal");
    wait randomfloatrange(5, 20);
    self flag::set("nrc_qt1_shotgunner_rush");
    var_d0aa3ba1 = getnodearray("nrc_shotgun_rusher_node", "targetname");
    var_9de10fe3 = array::random(var_d0aa3ba1);
    self setgoal(var_9de10fe3, 1);
    self thread function_6d46c512();
}

// Namespace quad_tank_plaza
// Params 0, eflags: 0x0
// Checksum 0xe61dc3e7, Offset: 0x8d80
// Size: 0x52
function function_10c25a20() {
    self endon(#"death");
    self endon(#"hash_cb188399");
    self ramses_util::function_f08afb37();
    util::waittill_any_ents(level, "quad_tank_1_destroyed", self, "nrc_qt1_shotgunner_rush");
    self ramses_util::function_f08afb37(0);
}

// Namespace quad_tank_plaza
// Params 0, eflags: 0x0
// Checksum 0x86553b0a, Offset: 0x8de0
// Size: 0x72
function function_6d46c512() {
    self endon(#"death");
    var_c9ae457a = getent("qt1_nrc_rusher_goalvolume", "targetname");
    while (true) {
        var_c9ae457a waittill(#"trigger", ent);
        if (ent == self) {
            break;
        }
    }
    self setgoal(var_c9ae457a, 1);
}

// Namespace quad_tank_plaza
// Params 0, eflags: 0x0
// Checksum 0x8ec72a7b, Offset: 0x8e60
// Size: 0x4a
function function_6639b8f8() {
    self endon(#"death");
    self endon(#"hash_cb188399");
    self ramses_util::function_f08afb37();
    level flag::wait_till("quad_tank_1_destroyed");
    self ramses_util::function_f08afb37(0);
}

// Namespace quad_tank_plaza
// Params 0, eflags: 0x0
// Checksum 0x9fe306b5, Offset: 0x8eb8
// Size: 0xa3
function function_17b4845b() {
    self endon(#"death");
    self setthreatbiasgroup("NRC_QT2_Robot_Rushers");
    setignoremegroup("Egyptian_RPG_guys", "NRC_QT2_Robot_Rushers");
    self ai::set_behavior_attribute("move_mode", "rusher");
    self ai::set_behavior_attribute("sprint", 1);
    trigger::wait_till("robot_callout_vo_trigger", "targetname", self);
    level notify(#"hash_3b542458");
}

// Namespace quad_tank_plaza
// Params 0, eflags: 0x0
// Checksum 0x89b16a3c, Offset: 0x8f68
// Size: 0x22
function function_663d1007() {
    self endon(#"death");
    self setthreatbiasgroup("Egyptian_Theater_guys");
}

// Namespace quad_tank_plaza
// Params 0, eflags: 0x0
// Checksum 0x54161819, Offset: 0x8f98
// Size: 0xc5
function function_7ea3ae59() {
    self endon(#"death");
    a_s_scenes = struct::get_array("qt_plaza_traverse_mobile_wall", "targetname");
    a_s_scenes = array::randomize(a_s_scenes);
    while (true) {
        foreach (s_scene in a_s_scenes) {
            if (!s_scene scene::is_playing()) {
                s_scene scene::play(self);
                return;
            }
        }
        wait 0.1;
    }
}

// Namespace quad_tank_plaza
// Params 0, eflags: 0x0
// Checksum 0x8b5e6bd2, Offset: 0x9068
// Size: 0x243
function function_29d63628() {
    var_4a38f1ec = getentarray("wing_carver_slanty", "targetname");
    foreach (var_a917350c in var_4a38f1ec) {
        var_a917350c notsolid();
        var_a917350c connectpaths();
    }
    var_4a38f1ec = getentarray("wing_carver_upright", "targetname");
    foreach (var_a917350c in var_4a38f1ec) {
        var_a917350c notsolid();
        var_a917350c connectpaths();
    }
    var_4562cbcf = getentarray("wing_slanty_collision", "targetname");
    foreach (e_clip in var_4562cbcf) {
        e_clip notsolid();
        e_clip connectpaths();
    }
    var_4562cbcf = getentarray("wing_collision_upright", "targetname");
    foreach (e_clip in var_4562cbcf) {
        e_clip notsolid();
        e_clip connectpaths();
    }
}

// Namespace quad_tank_plaza
// Params 0, eflags: 0x0
// Checksum 0xc168e2bb, Offset: 0x92b8
// Size: 0xaa
function function_3535efe1() {
    var_60571323 = getentarray("post_collapse_collision", "targetname");
    foreach (e_clip in var_60571323) {
        e_clip notsolid();
        e_clip connectpaths();
    }
    function_4bc5cb50();
}

// Namespace quad_tank_plaza
// Params 0, eflags: 0x0
// Checksum 0x5266e432, Offset: 0x9370
// Size: 0x193
function function_8ad4d7c() {
    var_64dd962c = getentarray("palace_corner_blocker", "targetname");
    foreach (e_debris in var_64dd962c) {
        e_debris notsolid();
        e_debris connectpaths();
        e_debris hide();
    }
    var_d0aa3ba1 = getnodearray("qt_plaza_palace_corner_cover", "script_noteworthy");
    foreach (node in var_d0aa3ba1) {
        setenablenode(node, 0);
    }
    wait 0.1;
    foreach (node in var_d0aa3ba1) {
        setenablenode(node, 1);
    }
}

// Namespace quad_tank_plaza
// Params 0, eflags: 0x0
// Checksum 0xb521baf9, Offset: 0x9510
// Size: 0x9a
function function_5cb0384() {
    var_ff82325f = getent("outro_shot_010_shadow", "targetname");
    var_ff82325f hide();
    var_ff82325f = getent("outro_shot_020_shadow", "targetname");
    var_ff82325f hide();
    var_ff82325f = getent("outro_shot_040_shadow", "targetname");
    var_ff82325f hide();
}

// Namespace quad_tank_plaza
// Params 0, eflags: 0x0
// Checksum 0x7234d56, Offset: 0x95b8
// Size: 0x4a
function function_3ec052d8() {
    scene::add_scene_func("p7_fxanim_cp_ramses_quadtank_statue_bundle", &function_5fea384c, "play");
    level scene::play("p7_fxanim_cp_ramses_quadtank_statue_bundle");
}

// Namespace quad_tank_plaza
// Params 0, eflags: 0x0
// Checksum 0x1ce28a59, Offset: 0x9610
// Size: 0x62
function function_5fea384c() {
    function_b78937aa("s_statue_pos");
    var_172dde81 = getent("quadtank_statue", "targetname");
    var_172dde81 thread bird_wing_impact();
    var_172dde81 thread bird_body_impact();
}

// Namespace quad_tank_plaza
// Params 0, eflags: 0x0
// Checksum 0x4463c09c, Offset: 0x9680
// Size: 0x305
function bird_wing_impact() {
    self waittill(#"bird_wing_impact");
    function_b78937aa("bird_wing_impact");
    var_4a38f1ec = getentarray("wing_carver_upright", "targetname");
    foreach (var_a917350c in var_4a38f1ec) {
        var_a917350c solid();
        var_a917350c disconnectpaths();
    }
    var_4562cbcf = getentarray("wing_collision_upright", "targetname");
    foreach (e_clip in var_4562cbcf) {
        e_clip solid();
        e_clip disconnectpaths();
    }
    var_a7f11dbf = getentarray("trig_kill_bird_wing", "targetname");
    a_ai = getaiarray();
    var_b857e377 = arraycombine(a_ai, level.players, 1, 0);
    foreach (e_actor in var_b857e377) {
        if (e_actor util::is_hero()) {
            continue;
        }
        if (e_actor === level.var_dbed449f) {
            e_actor dodamage(e_actor.health, e_actor.origin);
        }
        foreach (var_66ee586a in var_a7f11dbf) {
            if (e_actor istouching(var_66ee586a)) {
                if (isplayer(e_actor)) {
                    e_actor dodamage(e_actor.health, e_actor.origin);
                    break;
                }
                e_actor kill();
                break;
            }
        }
    }
}

// Namespace quad_tank_plaza
// Params 0, eflags: 0x0
// Checksum 0x3b15b9b7, Offset: 0x9990
// Size: 0x38d
function bird_body_impact() {
    self waittill(#"bird_body_impact");
    function_b78937aa("bird_body_impact");
    var_4a38f1ec = getentarray("wing_carver_slanty", "targetname");
    foreach (var_a917350c in var_4a38f1ec) {
        var_a917350c solid();
        var_a917350c disconnectpaths();
    }
    var_4562cbcf = getentarray("wing_slanty_collision", "targetname");
    foreach (e_clip in var_4562cbcf) {
        e_clip solid();
        e_clip disconnectpaths();
    }
    var_21868e86 = getnodearray("statue_fall_cover_nodes", "targetname");
    foreach (var_7d824fa6 in var_21868e86) {
        setenablenode(var_7d824fa6, 0);
    }
    var_a7f11dbf = getentarray("trig_kill_bird_body", "targetname");
    a_ai = getaiarray();
    var_b857e377 = arraycombine(a_ai, level.players, 1, 0);
    foreach (e_actor in var_b857e377) {
        if (e_actor util::is_hero()) {
            continue;
        }
        if (e_actor === level.var_dbed449f) {
            e_actor dodamage(e_actor.health, e_actor.origin);
        }
        foreach (var_66ee586a in var_a7f11dbf) {
            if (e_actor istouching(var_66ee586a)) {
                if (isplayer(e_actor)) {
                    e_actor dodamage(e_actor.health, e_actor.origin);
                    break;
                }
                e_actor kill();
                break;
            }
        }
    }
}

// Namespace quad_tank_plaza
// Params 0, eflags: 0x0
// Checksum 0x1dcee811, Offset: 0x9d28
// Size: 0x22a
function third_quadtank() {
    level thread function_6fde5d65();
    var_b0b3743d = spawner::simple_spawn_single("third_quadtank");
    level.third_quadtank = var_b0b3743d;
    var_b0b3743d setthreatbiasgroup("NRC_Quadtank");
    var_b0b3743d thread function_180ef4c7();
    level flag::set("quad_tank_3_spawned");
    objectives::set("cp_level_ramses_destroy_quadtank", var_b0b3743d);
    level thread namespace_a6a248fc::function_63054139();
    level thread function_7ced451a();
    var_2d14a2a4 = getentarray("oh_yeah_explosion", "targetname");
    foreach (e_piece in var_2d14a2a4) {
        e_piece delete();
    }
    scene::add_scene_func("p7_fxanim_cp_ramses_quadtank_plaza_glass_building_bundle", &function_b8afae40, "done");
    level thread scene::play("p7_fxanim_cp_ramses_quadtank_plaza_glass_building_bundle");
    function_b78937aa("glass_building_pos");
    var_b0b3743d thread function_6fd11e63();
    level flag::wait_till("third_quadtank_killed");
    objectives::complete("cp_level_ramses_destroy_quadtank");
    level notify(#"hash_a5b3808b");
    spawn_manager::disable("qt2_nrc_robot_rushers_sm");
    level notify(#"hash_941e824f");
    spawn_manager::disable("sm_nrc_quadtank");
    function_f9e42df5();
}

// Namespace quad_tank_plaza
// Params 1, eflags: 0x0
// Checksum 0x62582a31, Offset: 0x9f60
// Size: 0x5ea
function function_f9e42df5(var_fd827376) {
    if (!isdefined(var_fd827376)) {
        var_fd827376 = 0;
    }
    namespace_38256252::function_84fd481b();
    namespace_38256252::function_c31ee41b();
    level thread util::function_d8eaed3d(4, 1);
    if (isdefined(level.var_dbed449f) && level.var_dbed449f.targetname === "third_quadtank_ai") {
        wait 15;
    }
    wait 3;
    level clientfield::set("sndIGCsnapshot", 4);
    util::screen_fade_out(3);
    array::run_all(level.activeplayers, &enableinvulnerability);
    function_e2d7342();
    function_f43eaed9();
    level thread function_e1f59e09();
    battlechatter::function_d9f49fba(0);
    level.var_2fd26037 dialog::say("hend_that_s_the_last_of_1", 0.5);
    wait 1;
    level util::clientnotify("pre_outro_fade_in");
    level flag::set("qt_plaza_outro_igc_started");
    level thread namespace_a6a248fc::function_ff483e3c();
    level thread audio::unlockfrontendmusic("mus_ramses_battle_intro");
    level thread scene::init("p7_fxanim_cp_ramses_flyover_plaza_cinematic_bundle");
    vehicle::add_spawn_function("qt_plaza_outro_vtol_flyovers", &function_cda7e0dc);
    scene::add_scene_func("cin_ram_08_gettofreeway_3rd_sh010", &trigger_play_corpse_scenes_initial, "play");
    scene::add_scene_func("cin_ram_08_gettofreeway_3rd_sh020", &trigger_play_corpse_scenes_sh030, "play");
    scene::add_scene_func("cin_ram_08_gettofreeway_3rd_sh010", &function_edfa8509, "play");
    scene::add_scene_func("cin_ram_08_gettofreeway_3rd_sh010", &function_7f81dc0a, "done");
    scene::add_scene_func("cin_ram_08_gettofreeway_3rd_sh020", &function_b54fb58e, "play");
    scene::add_scene_func("cin_ram_08_gettofreeway_3rd_sh030", &function_a5697ed9, "play");
    scene::add_scene_func("cin_ram_08_gettofreeway_3rd_sh020", &function_91033548, "play");
    scene::add_scene_func("cin_ram_08_gettofreeway_3rd_sh030", &function_39b3e8bb, "play");
    scene::add_scene_func("cin_ram_08_gettofreeway_3rd_sh020", &function_5e9771a6, "play");
    scene::add_scene_func("cin_ram_08_gettofreeway_3rd_sh020", &function_68ec61cd, "done");
    scene::add_scene_func("cin_ram_08_gettofreeway_3rd_sh040", &function_e31876ac, "play");
    scene::add_scene_func("cin_ram_08_gettofreeway_3rd_sh040", &function_40ffea00, "play");
    scene::add_scene_func("cin_ram_08_gettofreeway_3rd_sh050", &function_892c9e40, "play");
    scene::add_scene_func("cin_ram_08_gettofreeway_3rd_sh030", &function_b8670a1c, "play");
    scene::add_scene_func("cin_ram_08_gettofreeway_3rd_sh030", &function_ed468ba2, "done");
    scene::add_scene_func("cin_ram_08_gettofreeway_3rd_sh320", &function_fdd71532, "play");
    level clientfield::set("qt_plaza_outro_exposure", 1);
    if (isdefined(level.var_d6cbae75)) {
        level thread [[ level.var_d6cbae75 ]]();
    }
    util::delay(1, undefined, &util::screen_fade_in, 1);
    array::run_all(level.activeplayers, &disableinvulnerability);
    level thread scene::play("cin_ram_08_gettofreeway_3rd_sh010");
    if (!level flag::get("qt_plaza_statue_destroyed")) {
        level scene::skipto_end("p7_fxanim_cp_ramses_quadtank_statue_bundle");
    }
    if (!level flag::get("qt_plaza_rocket_building_destroyed")) {
        level scene::skipto_end("p7_fxanim_cp_ramses_quadtank_plaza_building_rocket_bundle");
    }
    if (!level flag::get("qt_plaza_mobile_wall_destroyed")) {
        level scene::skipto_end("p7_fxanim_cp_ramses_mobile_wall_explode_bundle");
    }
}

// Namespace quad_tank_plaza
// Params 0, eflags: 0x0
// Checksum 0xf04c874c, Offset: 0xa558
// Size: 0x9a
function function_e2d7342() {
    var_aafd7555 = 0;
    foreach (player in level.activeplayers) {
        if (isdefined(player.hijacked_vehicle_entity)) {
            var_aafd7555 = 1;
            player.hijacked_vehicle_entity usevehicle(player, 0);
        }
    }
    if (var_aafd7555) {
        wait 5;
        return;
    }
    wait 2;
}

// Namespace quad_tank_plaza
// Params 1, eflags: 0x0
// Checksum 0xca1784e7, Offset: 0xa600
// Size: 0x22
function trigger_play_corpse_scenes_initial(a_ents) {
    trigger::use("trigger_play_corpse_scenes_initial");
}

// Namespace quad_tank_plaza
// Params 1, eflags: 0x0
// Checksum 0xe468a062, Offset: 0xa630
// Size: 0x22
function trigger_play_corpse_scenes_sh030(a_ents) {
    trigger::use("trigger_play_corpse_scenes_sh030");
}

// Namespace quad_tank_plaza
// Params 1, eflags: 0x0
// Checksum 0x9c73ee32, Offset: 0xa660
// Size: 0x3a
function function_b54fb58e(a_ents) {
    hidemiscmodels("quadtank_statue_static2");
    level clientfield::set("hide_statue_rubble", 1);
}

// Namespace quad_tank_plaza
// Params 1, eflags: 0x0
// Checksum 0xecc4940e, Offset: 0xa6a8
// Size: 0x42
function function_a5697ed9(a_ents) {
    wait 0.05;
    showmiscmodels("quadtank_statue_static2");
    level clientfield::set("hide_statue_rubble", 0);
}

// Namespace quad_tank_plaza
// Params 1, eflags: 0x0
// Checksum 0x2cf5d071, Offset: 0xa6f8
// Size: 0xaa
function function_fdd71532(a_ents) {
    level waittill(#"hash_faad7d97");
    level clientfield::set("sndIGCsnapshot", 4);
    level.var_6e1075a2 = 0;
    if (!scene::function_b1f75ee9()) {
        util::screen_fade_out(0.9, "black", "end_level_fade");
    }
    if (level.var_31aefea8 !== "dev_qt_plaza_outro") {
        skipto::function_be8adfb8("quad_tank_plaza");
        return;
    }
    skipto::function_be8adfb8("dev_qt_plaza_outro");
}

// Namespace quad_tank_plaza
// Params 1, eflags: 0x0
// Checksum 0xb56a92f2, Offset: 0xa7b0
// Size: 0x7a
function function_91033548(a_ents) {
    trigger::use("vtol_flyover_spawn_sh020");
    level thread scene::play("p7_fxanim_cp_ramses_flyover_plaza_cinematic_bundle");
    level waittill(#"hash_67d3927a");
    trigger::use("vtol_flyover_spawn_sh020_part_2");
    level waittill(#"hash_8dd60ce3");
    trigger::use("vtol_flyover_spawn_sh020_part_3");
}

// Namespace quad_tank_plaza
// Params 1, eflags: 0x0
// Checksum 0xcd88546f, Offset: 0xa838
// Size: 0x42
function function_39b3e8bb(a_ents) {
    trigger::use("vtol_flyover_spawn_sh030");
    level waittill(#"hash_816e1e05");
    trigger::use("vtol_flyover_spawn_sh030_part_2");
}

// Namespace quad_tank_plaza
// Params 0, eflags: 0x0
// Checksum 0xcc0e2945, Offset: 0xa888
// Size: 0x132
function function_cda7e0dc() {
    self endon(#"death");
    var_f6ae891b = [];
    a_s_structs = struct::get_array(self.target, "targetname");
    foreach (struct in a_s_structs) {
        e_model = spawn("script_model", struct.origin);
        e_model.angles = struct.angles;
        e_model setmodel(struct.model);
        e_model linkto(self);
        var_f6ae891b[var_f6ae891b.size] = e_model;
    }
    self waittill(#"reached_end_node");
    array::run_all(var_f6ae891b, &delete);
    self delete();
}

// Namespace quad_tank_plaza
// Params 1, eflags: 0x0
// Checksum 0x85e54a2b, Offset: 0xa9c8
// Size: 0x3a
function function_b8670a1c(a_ents) {
    level.sun_shadow_split_distance = 0;
    level.var_ac69c49c = level.sun_shadow_split_distance;
    level util::set_sun_shadow_split_distance(5000);
}

// Namespace quad_tank_plaza
// Params 1, eflags: 0x0
// Checksum 0x4b9ab3f8, Offset: 0xaa10
// Size: 0x2a
function function_ed468ba2(a_ents) {
    if (isdefined(level.var_ac69c49c)) {
        level util::set_sun_shadow_split_distance(level.var_ac69c49c);
    }
}

// Namespace quad_tank_plaza
// Params 1, eflags: 0x0
// Checksum 0xb3bc550f, Offset: 0xaa48
// Size: 0x42
function function_edfa8509(a_ents) {
    var_ff82325f = getent("outro_shot_010_shadow", "targetname");
    var_ff82325f show();
}

// Namespace quad_tank_plaza
// Params 1, eflags: 0x0
// Checksum 0xccbbc0fc, Offset: 0xaa98
// Size: 0x42
function function_7f81dc0a(a_ents) {
    var_ff82325f = getent("outro_shot_010_shadow", "targetname");
    var_ff82325f hide();
}

// Namespace quad_tank_plaza
// Params 1, eflags: 0x0
// Checksum 0xb23f8f01, Offset: 0xaae8
// Size: 0x42
function function_5e9771a6(a_ents) {
    var_ff82325f = getent("outro_shot_020_shadow", "targetname");
    var_ff82325f show();
}

// Namespace quad_tank_plaza
// Params 1, eflags: 0x0
// Checksum 0x3eecfc5e, Offset: 0xab38
// Size: 0x42
function function_68ec61cd(a_ents) {
    var_ff82325f = getent("outro_shot_020_shadow", "targetname");
    var_ff82325f hide();
}

// Namespace quad_tank_plaza
// Params 1, eflags: 0x0
// Checksum 0xd74d0099, Offset: 0xab88
// Size: 0x42
function function_e31876ac(a_ents) {
    var_ff82325f = getent("outro_shot_040_shadow", "targetname");
    var_ff82325f show();
}

// Namespace quad_tank_plaza
// Params 1, eflags: 0x0
// Checksum 0x9a20627, Offset: 0xabd8
// Size: 0xab
function function_40ffea00(a_ents) {
    hidemiscmodels("quadtank_statue_static2");
    var_64dd962c = getentarray("palace_corner_blocker", "targetname");
    foreach (e_debris in var_64dd962c) {
        e_debris delete();
    }
}

// Namespace quad_tank_plaza
// Params 1, eflags: 0x0
// Checksum 0x6444759c, Offset: 0xac90
// Size: 0x22
function function_892c9e40(a_ents) {
    showmiscmodels("quadtank_statue_static2");
}

// Namespace quad_tank_plaza
// Params 0, eflags: 0x0
// Checksum 0xc97a24f3, Offset: 0xacc0
// Size: 0x22
function function_180ef4c7() {
    self waittill(#"death");
    level flag::set("third_quadtank_killed");
}

// Namespace quad_tank_plaza
// Params 0, eflags: 0x0
// Checksum 0xca357596, Offset: 0xacf0
// Size: 0x181
function function_7ced451a() {
    startposition = struct::get("qt_plaza_new_bldg_phalanx_start", "targetname");
    endposition = struct::get("qt_plaza_new_bldg_phalanx_end", "targetname");
    var_88fc10b2 = getent("nrc_phalanx_spawner_cqb", "targetname", 0);
    var_62f99649 = getent("nrc_phalanx_spawner_assault", "targetname", 0);
    phalanx = new robotphalanx();
    [[ phalanx ]]->initialize("phalanx_column", startposition.origin, endposition.origin, 2, 4, var_88fc10b2, var_62f99649);
    level.phalanx = phalanx;
    level thread function_cc1c9255();
    robots = arraycombine(arraycombine(phalanx.tier1robots_, phalanx.tier2robots_, 0, 0), phalanx.tier3robots_, 0, 0);
    ai::waittill_dead(robots, 6);
    spawn_manager::enable("sm_nrc_quadtank3_robots");
    level.phalanx = undefined;
}

// Namespace quad_tank_plaza
// Params 0, eflags: 0x0
// Checksum 0xbd89a695, Offset: 0xae80
// Size: 0x2a
function function_cc1c9255() {
    wait 15;
    if (isdefined(level.phalanx)) {
        level.phalanx robotphalanx::scatterphalanx();
    }
}

// Namespace quad_tank_plaza
// Params 0, eflags: 0x0
// Checksum 0xf5d51dba, Offset: 0xaeb8
// Size: 0x5a
function function_f12c1985() {
    self endon(#"death");
    var_56a9d451 = getent(self.target, "targetname");
    self setgoal(var_56a9d451, 1);
    self thread function_dd6f7fa6();
}

// Namespace quad_tank_plaza
// Params 0, eflags: 0x0
// Checksum 0x33f3a9bb, Offset: 0xaf20
// Size: 0x33
function function_dd6f7fa6() {
    self endon(#"death");
    trigger::wait_till("qt_plaza_wasp_vo_trigger", "targetname", self);
    level notify(#"hash_b2673901");
}

// Namespace quad_tank_plaza
// Params 3, eflags: 0x0
// Checksum 0xcb5b1eb5, Offset: 0xaf60
// Size: 0x171
function wave_spawner(var_ec24660, var_39dd968a, var_eadffde8) {
    level endon(self.targetname + "_wave_spawner_stop");
    assert(var_ec24660 <= var_39dd968a, "<dev string:x28>");
    assert(var_eadffde8 <= self.var_e290d32d, "<dev string:x5a>");
    level flag::wait_till("all_players_spawned");
    while (isdefined(self) && level.players.size == 1) {
        while (isdefined(self)) {
            var_f3e62b98 = spawn_manager::function_423eae50(self.targetname);
            if (isdefined(var_f3e62b98.size) && var_f3e62b98.size < self.var_e290d32d) {
                wait 0.1;
                continue;
            }
            spawn_manager::disable(self.targetname);
            break;
        }
        while (isdefined(self)) {
            var_f3e62b98 = spawn_manager::function_423eae50(self.targetname);
            if (isdefined(var_f3e62b98.size) && var_f3e62b98.size <= var_eadffde8) {
                wait randomfloatrange(var_ec24660, var_39dd968a);
                spawn_manager::enable(self.targetname);
                break;
            }
            wait 0.1;
        }
    }
}

// Namespace quad_tank_plaza
// Params 0, eflags: 0x0
// Checksum 0xe81ece53, Offset: 0xb0e0
// Size: 0x7a
function quadtank_hijacked() {
    level.var_dbed449f = self;
    spawn_manager::enable("sm_nrc_berm_rpg", 1);
    self thread function_e07edd0e();
    self.threatbias = 3000;
    level thread function_e9bc4a8a();
    if (self.targetname !== "third_quadtank_ai") {
        objectives::complete("cp_level_ramses_destroy_quadtank");
    }
}

// Namespace quad_tank_plaza
// Params 0, eflags: 0x0
// Checksum 0xf62d739, Offset: 0xb168
// Size: 0x1d
function function_e07edd0e() {
    self waittill(#"death");
    level.var_dbed449f = undefined;
    level.var_efe14c34 = undefined;
}

// Namespace quad_tank_plaza
// Params 0, eflags: 0x0
// Checksum 0x26904589, Offset: 0xb190
// Size: 0x69
function function_3460d45c() {
    self endon(#"disconnect");
    while (true) {
        self waittill(#"clonedentity", var_52b4a338);
        var_52b4a338 setthreatbiasgroup("PlayerVehicles");
        if (isdefined(var_52b4a338.archetype) && var_52b4a338.archetype == "quadtank") {
            level.var_efe14c34 = self;
        }
    }
}

// Namespace quad_tank_plaza
// Params 0, eflags: 0x0
// Checksum 0xe90ac8ec, Offset: 0xb208
// Size: 0x34a
function function_e9bc4a8a() {
    level endon(#"qt_plaza_outro_igc_started");
    level.var_dbed449f endon(#"death");
    if (flag::get("qt_plaza_theater_destroyed")) {
        return;
    }
    level thread function_d283a64d();
    level thread function_5aeb8678();
    level flag::wait_till("qt_plaza_theater_destroyed");
    scene::add_scene_func("p7_fxanim_cp_ramses_cinema_collapse_bundle", &function_c56ab13c, "play");
    level thread scene::play("p7_fxanim_cp_ramses_cinema_collapse_bundle");
    function_4911582b();
    exploder::exploder_stop("LGT_theater");
    spawn_manager::disable("nrc_theater_sm");
    spawn_manager::disable("sm_egypt_theater");
    e_trigger = getent("trigger_cinema_collapse", "targetname");
    level thread function_21deb0d2(e_trigger);
    var_a8a64a67 = getnodearray("qt_plaza_theater_cover_node", "script_noteworthy");
    foreach (node in var_a8a64a67) {
        setenablenode(node, 0);
    }
    var_60571323 = getentarray("post_collapse_collision", "targetname");
    foreach (e_clip in var_60571323) {
        e_clip solid();
        e_clip disconnectpaths();
    }
    var_2ac13e86 = getentarray("pre_collapse_collision", "targetname");
    foreach (e_clip in var_2ac13e86) {
        e_clip notsolid();
    }
    function_b78937aa("theater_fxanim_org");
    array::run_all(getentarray("qt_plaza_theater_ammo", "targetname"), &delete);
}

// Namespace quad_tank_plaza
// Params 1, eflags: 0x0
// Checksum 0xc1b7864c, Offset: 0xb560
// Size: 0x52
function function_c56ab13c(a_ents) {
    var_aed142c5 = a_ents["cinema_collapse"];
    var_aed142c5 thread function_a77bfc56();
    var_aed142c5 thread function_4b75170f();
    var_aed142c5 thread function_fd1a064a();
}

// Namespace quad_tank_plaza
// Params 2, eflags: 0x0
// Checksum 0xcee562b9, Offset: 0xb5c0
// Size: 0x2cb
function function_21deb0d2(e_trigger, var_914edfb2) {
    if (!isdefined(var_914edfb2)) {
        var_914edfb2 = 0;
    }
    a_ai = getaiarray();
    foreach (ai in a_ai) {
        if (isdefined(level.var_dbed449f) && ai == level.var_dbed449f) {
            if (var_914edfb2 && ai istouching(e_trigger)) {
                ai dodamage(ai.health, ai.origin);
                continue;
            } else {
                continue;
            }
        }
        if (isdefined(ai.archetype) && ai.archetype == "quadtank") {
            if (var_914edfb2 && ai istouching(e_trigger)) {
                ai dodamage(ai.health, ai.origin);
                continue;
            } else {
                continue;
            }
        }
        if (ai istouching(e_trigger) && !ai util::is_hero()) {
            ai kill();
        }
    }
    a_spots = skipto::function_3529c409("cinema_teleport_outside");
    foreach (player in level.players) {
        if (player istouching(e_trigger)) {
            if (isdefined(player.hijacked_vehicle_entity) && a_spots.size > 0) {
                player thread function_2ea9c430(a_spots[0]);
                arrayremoveindex(a_spots, 0);
            } else {
                player dodamage(player.health, player.origin);
            }
        }
        if (isdefined(player.hijacked_vehicle_entity) && player.hijacked_vehicle_entity istouching(e_trigger)) {
            player.hijacked_vehicle_entity usevehicle(player, 0);
        }
    }
}

// Namespace quad_tank_plaza
// Params 1, eflags: 0x0
// Checksum 0x7d8985db, Offset: 0xb898
// Size: 0x5a
function function_2ea9c430(var_b5c1cc55) {
    self endon(#"death");
    self waittill(#"return_to_body");
    wait 0.05;
    wait 0.05;
    self setorigin(var_b5c1cc55.origin);
    self setplayerangles(var_b5c1cc55.angles);
}

// Namespace quad_tank_plaza
// Params 0, eflags: 0x0
// Checksum 0xb772b077, Offset: 0xb900
// Size: 0x109
function function_d283a64d() {
    level endon(#"qt_plaza_theater_destroyed");
    level.var_dbed449f endon(#"death");
    e_trigger = getent("trigger_cinema_collapse", "targetname");
    while (true) {
        e_trigger waittill(#"damage", n_damage, attacker, direction_vec, point, type, modelname, tagname, partname, weapon, idflags);
        if (attacker === level.var_efe14c34) {
            if (type === "MOD_PROJECTILE" || type === "MOD_PROJECTILE_SPLASH") {
                level flag::set("qt_plaza_theater_destroyed");
                e_trigger delete();
                break;
            }
        }
    }
}

// Namespace quad_tank_plaza
// Params 0, eflags: 0x0
// Checksum 0x3282de4d, Offset: 0xba18
// Size: 0x4d
function function_5aeb8678() {
    level endon(#"qt_plaza_theater_destroyed");
    level.var_dbed449f endon(#"death");
    while (true) {
        level.var_dbed449f waittill(#"weapon_fired", projectile);
        projectile thread function_edf54d14();
    }
}

// Namespace quad_tank_plaza
// Params 0, eflags: 0x0
// Checksum 0xc687f5e2, Offset: 0xba70
// Size: 0x61
function function_edf54d14() {
    self endon(#"death");
    e_trigger = getent("trigger_cinema_collapse", "targetname");
    while (true) {
        if (self istouching(e_trigger)) {
            self notify(#"death");
        }
        wait 0.05;
    }
}

// Namespace quad_tank_plaza
// Params 0, eflags: 0x0
// Checksum 0x8cc29180, Offset: 0xbae0
// Size: 0x62
function function_a77bfc56() {
    self waittill(#"hash_9290cf69");
    e_trigger = getent("theater_fxanim_kill_trigger_left", "targetname");
    level thread function_21deb0d2(e_trigger, 1);
    function_b78937aa("theater_fxanim_left_debris");
}

// Namespace quad_tank_plaza
// Params 0, eflags: 0x0
// Checksum 0x3f5ae2f6, Offset: 0xbb50
// Size: 0x62
function function_4b75170f() {
    self waittill(#"hash_ddd8ce9c");
    e_trigger = getent("theater_fxanim_kill_trigger_right", "targetname");
    level thread function_21deb0d2(e_trigger, 1);
    function_b78937aa("theater_fxanim_right_debris");
}

// Namespace quad_tank_plaza
// Params 0, eflags: 0x0
// Checksum 0x43545c17, Offset: 0xbbc0
// Size: 0x62
function function_fd1a064a() {
    self waittill(#"hash_2399452d");
    e_trigger = getent("theater_fxanim_kill_trigger_center", "targetname");
    level thread function_21deb0d2(e_trigger, 1);
    function_b78937aa("theater_fxanim_center_debris");
}

// Namespace quad_tank_plaza
// Params 0, eflags: 0x0
// Checksum 0x60ec888c, Offset: 0xbc30
// Size: 0xff
function function_45140126() {
    level endon(#"qt_plaza_outro_igc_started");
    while (true) {
        e_trigger = getent("test_quadtank_damage", "targetname");
        e_trigger waittill(#"trigger", ent);
        if (isdefined(level.var_efe14c34) && ent == level.var_efe14c34) {
            var_62c010e3 = getentarray("physics_test_objects", "targetname");
            foreach (e_obj in var_62c010e3) {
                e_obj physicslaunch(e_obj.origin, (0, 0, 20));
            }
        }
    }
}

// Namespace quad_tank_plaza
// Params 0, eflags: 0x0
// Checksum 0xdce1457e, Offset: 0xbd38
// Size: 0xbb
function mobile_wall_fxanim() {
    level thread scene::play("p7_fxanim_cp_ramses_mobile_wall_explode_bundle");
    function_b78937aa("mobile_wall_fxanim");
    var_366ecd15 = getentarray("mobile_wall_explosion_hidden", "targetname");
    foreach (e_prop in var_366ecd15) {
        e_prop hide();
    }
}

// Namespace quad_tank_plaza
// Params 0, eflags: 0x0
// Checksum 0x97233cef, Offset: 0xbe00
// Size: 0x1a
function function_899f8822() {
    level clientfield::set("vtol_igc_fxanim_hunter", 1);
}

// Namespace quad_tank_plaza
// Params 0, eflags: 0x0
// Checksum 0xdd18fb39, Offset: 0xbe28
// Size: 0x1a
function function_4492caaa() {
    level clientfield::set("qt_plaza_fxanim_hunters", 1);
}

// Namespace quad_tank_plaza
// Params 0, eflags: 0x0
// Checksum 0xd5cc0d8, Offset: 0xbe50
// Size: 0x1a
function function_e1f59e09() {
    level clientfield::set("qt_plaza_fxanim_hunters", 0);
}

// Namespace quad_tank_plaza
// Params 0, eflags: 0x0
// Checksum 0x871176c5, Offset: 0xbe78
// Size: 0x5a
function function_4bc5cb50() {
    level clientfield::set("theater_fxanim_swap", 1);
    array::run_all(getentarray("destroyed_interior", "targetname"), &hide);
}

// Namespace quad_tank_plaza
// Params 0, eflags: 0x0
// Checksum 0x597fd08b, Offset: 0xbee0
// Size: 0xe2
function function_4911582b() {
    level clientfield::set("theater_fxanim_swap", 0);
    var_f6ae891b = getentarray("pristine_interior", "targetname");
    foreach (e_model in var_f6ae891b) {
        e_model hide();
    }
    array::run_all(getentarray("destroyed_interior", "targetname"), &show);
}

// Namespace quad_tank_plaza
// Params 1, eflags: 0x0
// Checksum 0x101440da, Offset: 0xbfd0
// Size: 0x123
function function_b78937aa(str_targetname) {
    s_pos = struct::get(str_targetname, "targetname");
    foreach (e_player in level.players) {
        n_distance_squared = distance2dsquared(s_pos.origin, e_player.origin);
        if (n_distance_squared < 1000000) {
            e_player playrumbleonentity("tank_damage_heavy_mp");
            earthquake(0.65, 0.7, e_player.origin, 128);
            if (n_distance_squared < 62500) {
                e_player shellshock("default", 1.5);
            }
        }
    }
}

// Namespace quad_tank_plaza
// Params 0, eflags: 0x0
// Checksum 0xae264402, Offset: 0xc100
// Size: 0x5a
function function_a9213e0b() {
    a_str_lines = [];
    a_str_lines[0] = "hend_grab_some_cover_go_0";
    a_str_lines[1] = "hend_get_outta_there_fin_0";
    str_line = array::random(a_str_lines);
    level.var_2fd26037 thread dialog::say(str_line);
}

// Namespace quad_tank_plaza
// Params 0, eflags: 0x0
// Checksum 0x86935fcf, Offset: 0xc168
// Size: 0x125
function function_80a9f826() {
    level endon(#"quad_tank_1_destroyed");
    var_83e15cc6 = [];
    var_83e15cc6[0] = "hend_bring_down_that_son_0";
    var_83e15cc6[1] = "hend_that_quad_s_armed_wi_0";
    var_83e15cc6[2] = "hend_quad_s_rockets_are_g_0";
    var_864f1072 = [];
    var_864f1072[0] = "kane_take_out_that_quad_b_0";
    var_864f1072[1] = "kane_that_quad_s_rockets_0";
    var_e6e0d46e = undefined;
    var_36a7c200 = undefined;
    while (true) {
        self waittill(#"trophy_system_disabled");
        if (math::cointoss()) {
            str_line = function_46197f76(var_83e15cc6, var_e6e0d46e);
            level.var_2fd26037 dialog::say(str_line);
            var_e6e0d46e = str_line;
        } else {
            str_line = function_46197f76(var_864f1072, var_36a7c200);
            level dialog::remote(str_line);
            var_36a7c200 = str_line;
        }
        wait randomfloatrange(45, 60);
    }
}

// Namespace quad_tank_plaza
// Params 0, eflags: 0x0
// Checksum 0xcb71459c, Offset: 0xc298
// Size: 0x1f9
function function_f922378a() {
    level endon(#"quad_tank_1_destroyed");
    level waittill(#"hash_f922378a");
    a_str_lines = [];
    a_str_lines[0] = "esl3_amws_incoming_0";
    a_str_lines[1] = "esl4_amws_inbound_grab_s_0";
    a_str_lines[2] = "esl1_evasives_amws_inbou_0";
    a_str_lines[3] = "egy2_spotted_enemy_amw_mo_0";
    a_str_lines[4] = "esl3_eyes_on_hostile_amw_0";
    var_45e7b1aa = undefined;
    while (true) {
        do {
            wait 0.15;
            var_df8a7392 = spawn_manager::function_423eae50("qt1_nrc_amws_sm");
        } while (var_df8a7392.size < 1);
        var_ac9c19b = spawn_manager::function_423eae50("sm_egypt_siegebot");
        var_98c25260 = spawn_manager::function_423eae50("sm_egypt_quadtank");
        a_ai = arraycombine(var_ac9c19b, var_98c25260, 1, 0);
        if (a_ai.size > 0) {
            ai_speaker = undefined;
            a_ai = array::randomize(a_ai);
            foreach (ai in a_ai) {
                if (isalive(ai) && ai.is_talking !== 1) {
                    ai_speaker = ai;
                    break;
                }
            }
            if (isdefined(ai_speaker)) {
                str_line = function_46197f76(a_str_lines, var_45e7b1aa);
                ai_speaker dialog::say(str_line);
                var_45e7b1aa = str_line;
                wait randomfloatrange(30, 45);
            } else {
                wait 1;
            }
            continue;
        }
        wait 1;
    }
}

// Namespace quad_tank_plaza
// Params 0, eflags: 0x0
// Checksum 0x8c40f3ef, Offset: 0xc4a0
// Size: 0x321
function function_c09bd13a() {
    level endon(#"third_quadtank_killed");
    a_str_lines = [];
    a_str_lines[0] = "esl1_hostile_raps_moving_0";
    a_str_lines[1] = "egy2_look_out_raps_inco_0";
    a_str_lines[2] = "esl3_take_cover_raps_inb_0";
    a_str_lines[3] = "esl4_hostile_raps_inbound_0";
    a_str_lines[4] = "esl1_enemy_raps_coming_in_0";
    a_str_lines[5] = "egy2_hostile_raps_inbound_0";
    a_str_lines[6] = "esl3_enemy_raps_moving_on_0";
    a_str_lines[7] = "esl4_hostile_raps_inbound_1";
    a_str_lines[8] = "esl1_raps_coming_in_find_0";
    a_str_lines[9] = "egy2_hostile_raps_look_o_0";
    var_3b620724 = [];
    var_3b620724[0] = "khal_raps_incoming_0";
    var_3b620724[1] = "khal_raps_move_0";
    var_3b620724[2] = "khal_find_cover_raps_in_0";
    var_3b620724[3] = "khal_look_out_raps_0";
    var_3b620724[4] = "khal_enemy_raps_inbound_0";
    var_3b620724[5] = "khal_heads_up_enemy_rap_0";
    var_3b620724[6] = "khal_hostile_raps_inbound_0";
    var_3b620724[7] = "khal_enemy_raps_0";
    var_3b620724[8] = "khal_raps_moving_in_0";
    var_3b620724[9] = "khal_incoming_raps_0";
    var_45e7b1aa = undefined;
    var_9ef5f81e = undefined;
    level waittill(#"hash_c09bd13a");
    while (true) {
        if (math::cointoss()) {
            str_line = function_46197f76(var_3b620724, var_9ef5f81e);
            level.var_9db406db dialog::say(str_line);
            var_9ef5f81e = str_line;
            wait randomfloatrange(30, 45);
            continue;
        }
        do {
            wait 0.15;
            var_6ee22718 = spawner::get_ai_group_sentient_count("nrc_raps");
        } while (var_6ee22718 < 1);
        var_ac9c19b = spawn_manager::function_423eae50("sm_egypt_siegebot");
        var_98c25260 = spawn_manager::function_423eae50("sm_egypt_quadtank");
        a_ai = arraycombine(var_ac9c19b, var_98c25260, 1, 0);
        if (a_ai.size > 0) {
            ai_speaker = undefined;
            a_ai = array::randomize(a_ai);
            foreach (ai in a_ai) {
                if (isalive(ai) && ai.is_talking !== 1) {
                    ai_speaker = ai;
                    break;
                }
            }
            if (isdefined(ai_speaker)) {
                str_line = function_46197f76(a_str_lines, var_45e7b1aa);
                ai_speaker dialog::say(str_line);
                var_45e7b1aa = str_line;
                wait randomfloatrange(30, 45);
            } else {
                wait 1;
            }
            continue;
        }
        wait 1;
    }
}

// Namespace quad_tank_plaza
// Params 0, eflags: 0x0
// Checksum 0x8ab1b8a0, Offset: 0xc7d0
// Size: 0x17b
function function_6fd11e63() {
    level endon(#"quad_tank_2_destroyed");
    level endon(#"demo_player_controlled_quadtank");
    level endon(#"third_quadtank_killed");
    var_83e15cc6 = [];
    var_83e15cc6[0] = "hend_focus_fire_on_that_a_0";
    var_83e15cc6[1] = "hend_finally_a_fair_fight_0";
    var_83e15cc6[2] = "hend_we_gotta_bring_down_0";
    var_83e15cc6[3] = "hend_bring_down_that_son_0";
    var_83e15cc6[4] = "hend_that_quad_s_armed_wi_0";
    var_83e15cc6[5] = "hend_quad_s_rockets_are_g_0";
    var_864f1072 = [];
    var_864f1072[0] = "kane_focus_fire_on_that_a_0";
    var_864f1072[1] = "kane_take_down_that_artil_0";
    var_864f1072[2] = "kane_you_gotta_bring_down_0";
    var_864f1072[3] = "kane_focus_weapon_fire_on_0";
    var_864f1072[4] = "kane_take_out_that_quad_b_0";
    var_864f1072[5] = "kane_that_quad_s_rockets_0";
    var_e6e0d46e = undefined;
    for (var_36a7c200 = undefined; true; var_36a7c200 = str_line) {
        wait randomfloatrange(60, 90);
        if (math::cointoss()) {
            str_line = function_46197f76(var_83e15cc6, var_e6e0d46e);
            level.var_2fd26037 dialog::say(str_line);
            var_e6e0d46e = str_line;
            continue;
        }
        str_line = function_46197f76(var_864f1072, var_36a7c200);
        level dialog::remote(str_line);
    }
}

// Namespace quad_tank_plaza
// Params 0, eflags: 0x0
// Checksum 0xe150cbb2, Offset: 0xc958
// Size: 0x1e1
function function_df4c5d7e() {
    a_str_lines = [];
    a_str_lines[0] = "esl1_go_push_them_back_0";
    a_str_lines[1] = "egy2_move_up_move_up_0";
    a_str_lines[2] = "esl3_move_up_take_new_po_0";
    a_str_lines[3] = "esl4_come_on_push_forwar_0";
    a_str_lines[4] = "esl1_let_s_move_let_s_mo_0";
    var_45e7b1aa = undefined;
    var_522ce6c6 = 0;
    wait 6;
    while (var_522ce6c6 < 2) {
        var_ac9c19b = spawn_manager::function_423eae50("sm_egypt_siegebot");
        var_98c25260 = spawn_manager::function_423eae50("sm_egypt_quadtank");
        a_ai = arraycombine(var_ac9c19b, var_98c25260, 1, 0);
        if (a_ai.size > 0) {
            ai_speaker = undefined;
            a_ai = array::randomize(a_ai);
            foreach (ai in a_ai) {
                if (isalive(ai) && ai.is_talking !== 1) {
                    ai_speaker = ai;
                    break;
                }
            }
            if (isdefined(ai_speaker)) {
                str_line = function_46197f76(a_str_lines, var_45e7b1aa);
                ai_speaker dialog::say(str_line);
                var_522ce6c6++;
                var_45e7b1aa = str_line;
                wait randomfloatrange(1.5, 2.5);
            } else {
                wait 1;
            }
            continue;
        }
        wait 1;
    }
}

// Namespace quad_tank_plaza
// Params 0, eflags: 0x0
// Checksum 0xc38ab4c2, Offset: 0xcb48
// Size: 0x1b9
function function_9866bb6() {
    level endon(#"third_quadtank_killed");
    a_str_lines = [];
    a_str_lines[0] = "esl3_rpg_top_of_the_pala_0";
    a_str_lines[1] = "esl4_rpg_spotted_top_flo_0";
    var_45e7b1aa = undefined;
    var_522ce6c6 = 0;
    level waittill(#"hash_9866bb6");
    while (var_522ce6c6 < 2) {
        var_ac9c19b = spawn_manager::function_423eae50("sm_egypt_siegebot");
        var_98c25260 = spawn_manager::function_423eae50("sm_egypt_quadtank");
        a_ai = arraycombine(var_ac9c19b, var_98c25260, 1, 0);
        if (a_ai.size > 0) {
            ai_speaker = undefined;
            a_ai = array::randomize(a_ai);
            foreach (ai in a_ai) {
                if (isalive(ai) && ai.is_talking !== 1) {
                    ai_speaker = ai;
                    break;
                }
            }
            if (isdefined(ai_speaker)) {
                str_line = function_46197f76(a_str_lines, var_45e7b1aa);
                ai_speaker dialog::say(str_line);
                var_522ce6c6++;
                var_45e7b1aa = str_line;
                wait randomfloatrange(60, 120);
            } else {
                wait 1;
            }
            continue;
        }
        wait 1;
    }
}

// Namespace quad_tank_plaza
// Params 0, eflags: 0x0
// Checksum 0xd7838e61, Offset: 0xcd10
// Size: 0x1b9
function function_8b6b15aa() {
    level endon(#"third_quadtank_killed");
    a_str_lines = [];
    a_str_lines[0] = "esl1_rpg_top_of_the_berm_0";
    a_str_lines[1] = "egy2_look_out_rpg_on_the_0";
    var_45e7b1aa = undefined;
    var_522ce6c6 = 0;
    while (var_522ce6c6 < 2) {
        level waittill(#"hash_8b6b15aa");
        var_ac9c19b = spawn_manager::function_423eae50("sm_egypt_siegebot");
        var_98c25260 = spawn_manager::function_423eae50("sm_egypt_quadtank");
        a_ai = arraycombine(var_ac9c19b, var_98c25260, 1, 0);
        if (a_ai.size > 0) {
            ai_speaker = undefined;
            a_ai = array::randomize(a_ai);
            foreach (ai in a_ai) {
                if (isalive(ai) && ai.is_talking !== 1) {
                    ai_speaker = ai;
                    break;
                }
            }
            if (isdefined(ai_speaker)) {
                str_line = function_46197f76(a_str_lines, var_45e7b1aa);
                ai_speaker dialog::say(str_line);
                var_522ce6c6++;
                var_45e7b1aa = str_line;
                wait randomfloatrange(60, 120);
            } else {
                wait 1;
            }
            continue;
        }
        wait 1;
    }
}

// Namespace quad_tank_plaza
// Params 0, eflags: 0x0
// Checksum 0x90092753, Offset: 0xced8
// Size: 0x9a
function function_db836bc0() {
    level waittill(#"hash_eb237993");
    level thread namespace_a6a248fc::function_19e0cb0e();
    level thread namespace_a6a248fc::function_98c9ec2a();
    level.var_2fd26037 thread dialog::say("hend_look_out_we_got_inc_0");
    level waittill(#"hash_c520ff2a");
    level.var_2fd26037 thread dialog::say("hend_vtol_down_don_t_ha_0");
    level waittill(#"hash_9f1e84c1");
    level.var_2fd26037 dialog::say("hend_shit_quad_is_functi_0");
}

// Namespace quad_tank_plaza
// Params 1, eflags: 0x0
// Checksum 0xfda7a802, Offset: 0xcf80
// Size: 0x181
function function_e388dd6b(a_ai) {
    a_str_lines = [];
    a_str_lines[0] = "esl1_get_outta_there_0";
    a_str_lines[1] = "egy2_move_move_move_1";
    a_str_lines[2] = "esl3_scatter_get_outta_t_0";
    a_str_lines[3] = "esl4_incoming_move_0";
    a_str_lines[4] = "esl3_scatter_scatter_in_0";
    var_522ce6c6 = 0;
    var_45e7b1aa = undefined;
    while (var_522ce6c6 < 2) {
        if (a_ai.size > 0) {
            ai_speaker = undefined;
            a_ai = array::randomize(a_ai);
            foreach (ai in a_ai) {
                if (isalive(ai) && ai.is_talking !== 1) {
                    ai_speaker = ai;
                    break;
                }
            }
            if (isdefined(ai_speaker)) {
                str_line = function_46197f76(a_str_lines, var_45e7b1aa);
                ai_speaker dialog::say(str_line);
                var_522ce6c6++;
                var_45e7b1aa = str_line;
                wait randomfloatrange(0.5, 1.5);
            } else {
                wait 1;
            }
            continue;
        }
        wait 1;
    }
}

// Namespace quad_tank_plaza
// Params 0, eflags: 0x0
// Checksum 0xf16c0a20, Offset: 0xd110
// Size: 0x2a
function function_7432965b() {
    level.var_2fd26037 thread dialog::say("hend_statue_s_coming_down_0", 1);
}

// Namespace quad_tank_plaza
// Params 0, eflags: 0x0
// Checksum 0xa0ab52b8, Offset: 0xd148
// Size: 0x1c9
function function_3b542458() {
    level endon(#"third_quadtank_killed");
    a_str_lines = [];
    a_str_lines[0] = "esl4_eyes_on_hostile_gis_0";
    a_str_lines[1] = "esl3_enemy_grunts_spotted_0";
    a_str_lines[2] = "egy2_hostile_grunts_movin_0";
    a_str_lines[3] = "esl1_grunts_spotted_0";
    a_str_lines[4] = "esl4_i_got_sights_on_host_0";
    var_45e7b1aa = undefined;
    level waittill(#"hash_3b542458");
    while (true) {
        var_ac9c19b = spawn_manager::function_423eae50("sm_egypt_siegebot");
        var_98c25260 = spawn_manager::function_423eae50("sm_egypt_quadtank");
        a_ai = arraycombine(var_ac9c19b, var_98c25260, 1, 0);
        if (a_ai.size > 0) {
            ai_speaker = undefined;
            a_ai = array::randomize(a_ai);
            foreach (ai in a_ai) {
                if (isalive(ai) && ai.is_talking !== 1) {
                    ai_speaker = ai;
                    break;
                }
            }
            if (isdefined(ai_speaker)) {
                str_line = function_46197f76(a_str_lines, var_45e7b1aa);
                ai_speaker dialog::say(str_line);
                var_45e7b1aa = str_line;
                wait randomfloatrange(60, 120);
            } else {
                wait 1;
            }
            continue;
        }
        wait 1;
    }
}

// Namespace quad_tank_plaza
// Params 0, eflags: 0x0
// Checksum 0x974fa168, Offset: 0xd320
// Size: 0x2a
function function_4c7236e3() {
    level.var_2fd26037 thread dialog::say("esl1_technical_spotted_t_0", 1);
}

// Namespace quad_tank_plaza
// Params 0, eflags: 0x0
// Checksum 0x9f1630f4, Offset: 0xd358
// Size: 0x18b
function function_d98bac2() {
    wait 2;
    a_str_lines = [];
    a_str_lines[0] = "esl3_spotted_hostiles_in_0";
    a_str_lines[1] = "esl4_hostile_forces_insid_0";
    a_str_lines[2] = "esl1_they_re_coming_throu_0";
    while (true) {
        var_ac9c19b = spawn_manager::function_423eae50("sm_egypt_siegebot");
        var_98c25260 = spawn_manager::function_423eae50("sm_egypt_quadtank");
        a_ai = arraycombine(var_ac9c19b, var_98c25260, 1, 0);
        if (a_ai.size > 0) {
            ai_speaker = undefined;
            a_ai = array::randomize(a_ai);
            foreach (ai in a_ai) {
                if (isalive(ai) && ai.is_talking !== 1) {
                    ai_speaker = ai;
                    break;
                }
            }
            if (isdefined(ai_speaker)) {
                str_line = array::random(a_str_lines);
                ai_speaker dialog::say(str_line);
                return;
            } else {
                wait 1;
            }
            continue;
        }
        wait 1;
    }
}

// Namespace quad_tank_plaza
// Params 1, eflags: 0x0
// Checksum 0xe41bd8f, Offset: 0xd4f0
// Size: 0x241
function function_b8afae40(a_ents) {
    level endon(#"third_quadtank_killed");
    var_ce5b55e5 = level.third_quadtank.origin;
    a_ai = getaiteamarray("allies");
    a_ai = arraysortclosest(a_ai, var_ce5b55e5);
    ai_speaker = undefined;
    foreach (ai in a_ai) {
        if (!ai util::is_hero() && isalive(ai) && ai.is_talking !== 1) {
            ai_speaker = ai;
            break;
        }
    }
    wait 5;
    a_str_lines = [];
    a_str_lines[0] = "esl1_grunt_company_comin_0";
    a_str_lines[1] = "egy2_eyes_on_hostile_grun_0";
    a_str_lines[2] = "esl3_spotted_hostile_grun_0";
    a_str_lines[3] = "esl4_grab_some_cover_hos_0";
    a_str_lines[4] = "esl3_gi_company_spotted_a_0";
    while (true) {
        a_ai = getaiteamarray("allies");
        a_ai = arraysortclosest(a_ai, var_ce5b55e5);
        ai = undefined;
        for (i = 0; i < a_ai.size; i++) {
            ai = a_ai[i];
            if (!ai util::is_hero() && isalive(ai) && !(isdefined(ai.is_talking) && ai.is_talking)) {
                break;
            }
        }
        if (isdefined(ai)) {
            str_line = array::random(a_str_lines);
            ai dialog::say(str_line);
            return;
        }
        wait 0.25;
    }
}

// Namespace quad_tank_plaza
// Params 2, eflags: 0x0
// Checksum 0x1dda9a98, Offset: 0xd740
// Size: 0x5d
function function_46197f76(a_str_lines, var_45e7b1aa) {
    a_str_lines = array::randomize(a_str_lines);
    for (i = 0; i < a_str_lines.size; i++) {
        var_675395aa = a_str_lines[i];
        if (var_675395aa !== var_45e7b1aa) {
            return var_675395aa;
        }
    }
    return var_45e7b1aa;
}

// Namespace quad_tank_plaza
// Params 0, eflags: 0x0
// Checksum 0xeb5548ef, Offset: 0xd7a8
// Size: 0x37b
function function_f43eaed9() {
    spawn_manager::kill("sm_egypt_plaza_wall");
    spawn_manager::kill("sm_egypt_palace_window");
    spawn_manager::kill("sm_egypt_quadtank");
    spawn_manager::kill("sm_egypt_siegebot");
    spawn_manager::kill("sm_nrc_siegebot");
    spawn_manager::kill("sm_nrc_quadtank");
    spawn_manager::kill("sm_nrc_depth");
    spawn_manager::kill("sm_nrc_berm_rpg");
    spawn_manager::kill("qt1_nrc_wasp_sm");
    spawn_manager::kill("sm_nrc_govt_building_rpg");
    spawn_manager::kill("qt1_nrc_amws_sm");
    spawn_manager::kill("qt1_nrc_raps_sm");
    spawn_manager::kill("qt2_nrc_wasp_sm");
    spawn_manager::kill("sm_egypt_theater");
    spawn_manager::kill("qt2_nrc_wasp2_berm_sm");
    spawn_manager::kill("qt2_nrc_wasp2_palace_sm");
    spawn_manager::kill("qt2_nrc_robot_rushers_sm");
    spawn_manager::kill("qt2_nrc_raps_sm");
    spawn_manager::kill("sm_nrc_qt2_depth");
    spawn_manager::kill("nrc_mobile_wall_sm");
    spawn_manager::kill("demo_qt2_wasp_sm");
    spawn_manager::kill("qt_plaza_controllable_qt_raps_sm");
    spawn_manager::kill("nrc_theater_sm");
    spawn_manager::kill("sm_nrc_quadtank3_robots");
    a_ai = getaiarray();
    foreach (ai in a_ai) {
        if (!ai util::is_hero()) {
            if (ai !== level.var_dbed449f && ai.vehicletype !== "veh_bo3_civ_truck_pickup_tech_nrc_nolights") {
                ai delete();
            }
        }
    }
    a_corpses = getcorpsearray();
    foreach (corpse in a_corpses) {
        if (corpse.vehicletype !== "veh_bo3_civ_truck_pickup_tech_nrc_nolights") {
            corpse delete();
        }
    }
}

// Namespace quad_tank_plaza
// Params 0, eflags: 0x0
// Checksum 0xf785e9e7, Offset: 0xdb30
// Size: 0xea
function function_7d4abfb6() {
    level thread scene::init("p7_fxanim_cp_ramses_quadtank_statue_bundle");
    level thread scene::init("p7_fxanim_cp_ramses_mobile_wall_explode_bundle");
    level flag::wait_till("first_player_spawned");
    wait 3;
    iprintlnbold("Statue about to fall");
    var_6b1c7f11 = spawner::simple_spawn_single("demo_intro_mlrs_quadtank");
    var_6b1c7f11 util::magic_bullet_shield();
    var_6b1c7f11 vehicle_ai::start_scripted(1);
    wait 1;
    level thread scene::play("cin_ram_07_04_plaza_vign_quaddefeated");
    level thread scene::play("p7_fxanim_cp_ramses_quadtank_statue_bundle");
    wait 8;
    level thread scene::play("p7_fxanim_cp_ramses_mobile_wall_explode_bundle");
}

// Namespace quad_tank_plaza
// Params 0, eflags: 0x0
// Checksum 0xc8da323e, Offset: 0xdc28
// Size: 0x2a
function function_fb5c1d72() {
    var_55141f56 = function_703b62d1(1);
    function_c6a0a6e5(var_55141f56);
}

