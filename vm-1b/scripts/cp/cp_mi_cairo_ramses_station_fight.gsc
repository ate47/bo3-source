#using scripts/shared/ai/robot_phalanx;
#using scripts/cp/gametypes/_battlechatter;
#using scripts/cp/gametypes/_save;
#using scripts/cp/cp_mi_cairo_ramses_nasser_interview;
#using scripts/cp/cp_mi_cairo_ramses_station_walk;
#using scripts/cp/cp_mi_cairo_ramses_utility;
#using scripts/cp/cp_mi_cairo_ramses_vtol_ride;
#using scripts/cp/cp_mi_cairo_ramses_level_start;
#using scripts/cp/cp_mi_cairo_ramses_sound;
#using scripts/cp/cp_mi_cairo_ramses_fx;
#using scripts/cp/cp_mi_cairo_ramses_accolades;
#using scripts/cp/_oed;
#using scripts/cp/_spawn_manager;
#using scripts/cp/_util;
#using scripts/cp/_skipto;
#using scripts/cp/_objectives;
#using scripts/cp/_load;
#using scripts/shared/math_shared;
#using scripts/cp/_dialog;
#using scripts/shared/clientfield_shared;
#using scripts/shared/vehicles/_raps;
#using scripts/shared/vehicle_ai_shared;
#using scripts/shared/vehicle_shared;
#using scripts/shared/util_shared;
#using scripts/shared/turret_shared;
#using scripts/shared/trigger_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/laststand_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/compass;
#using scripts/shared/colors_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/array_shared;
#using scripts/shared/animation_shared;
#using scripts/shared/ai_shared;
#using scripts/codescripts/struct;

#namespace namespace_bedc6a60;

// Namespace namespace_bedc6a60
// Params 2, eflags: 0x0
// Checksum 0x79acf226, Offset: 0x1760
// Size: 0x4ca
function init(str_objective, var_74cd64bc) {
    callback::remove_on_spawned(&namespace_50196384::function_e9d1564a);
    spawner::add_spawn_function_group("station_fight_scene_robot", "script_noteworthy", &function_3aea851b);
    spawner::add_spawn_function_group("station_fight_balcony_turret_steal_robot", "targetname", &function_28238a2a);
    spawner::add_spawn_function_group("balcony_station_fight_ai", "script_noteworthy", &namespace_391e4301::function_258b9bad, "end_balcony_shields", 1);
    spawner::add_spawn_function_group("balcony_robot_ai", "script_string", &function_23c641de);
    spawner::add_spawn_function_group("right_side_station_fight_ai", "script_noteworthy", &namespace_391e4301::function_258b9bad, "player_is_close", 1);
    spawner::add_spawn_function_group("right_side_station_fight_ai", "script_noteworthy", &function_157bd88d);
    spawner::add_spawn_function_group("rap_drive_to_point_explode", "script_noteworthy", &function_8d670bce);
    spawner::add_spawn_function_group("station_fight_raps_jump_raps", "targetname", &function_3e73806);
    spawner::add_spawn_function_group("actor_spawner_enemy_dps_robot_assault_ar", "classname", &function_46eb86a4);
    spawner::add_spawn_function_group("actor_spawner_enemy_dps_robot_cqb_shotgun", "classname", &function_46eb86a4);
    spawner::add_spawn_function_group("actor_spawner_enemy_dps_robot_suppressor_ar", "classname", &function_46eb86a4);
    spawner::add_spawn_function_group("actor_spawner_enemy_dps_robot_suppressor_mg", "classname", &function_46eb86a4);
    if (var_74cd64bc) {
        load::function_73adcefc();
        level cp_mi_cairo_ramses_station_walk::function_bbd12ed2(0);
        level thread function_e5ed2910();
        level thread namespace_391e4301::function_e950228a();
        level scene::init("cin_ram_03_01_defend_1st_rapsintro");
        level thread function_91e74b85();
        level util::function_d8eaed3d(2, 1);
    } else {
        level thread util::function_d8eaed3d(2, 1);
    }
    level.var_85b298df = getnode("khalil_station_fight_start_node", "targetname");
    setenablenode(level.var_85b298df, 0);
    function_dfedb0b8(str_objective, var_74cd64bc);
    if (scene::is_playing("cin_ram_02_04_interview_part04")) {
        scene::stop("cin_ram_02_04_interview_part04");
    }
    if (isdefined(level.var_d2285e9a)) {
        level thread [[ level.var_d2285e9a ]]();
    }
    level thread scene::play("cin_ram_02_04_interview_part04_end_loops");
    foreach (e_player in level.players) {
        e_player thread namespace_50196384::function_8ae96a69();
    }
    level thread scene::play("p7_fxanim_cp_ramses_lotus_towers_hunters_swarm_bundle");
    namespace_38256252::function_6f52c808();
    namespace_38256252::function_7f657f7a();
    namespace_38256252::function_fec73937();
    namespace_38256252::function_a17fa88e();
    battlechatter::function_d9f49fba(1, "bc");
    main(var_74cd64bc);
    skipto::function_be8adfb8("defend_ramses_station");
}

// Namespace namespace_bedc6a60
// Params 4, eflags: 0x0
// Checksum 0x2531ca69, Offset: 0x1c38
// Size: 0x52
function done(str_objective, var_74cd64bc, var_e4cd2b8b, player) {
    namespace_38256252::function_b13b2dae();
    namespace_38256252::tank_handleairburst();
    namespace_38256252::function_6d6e6d0d();
}

// Namespace namespace_bedc6a60
// Params 1, eflags: 0x0
// Checksum 0x6e32e77b, Offset: 0x1c98
// Size: 0xe2
function main(var_74cd64bc) {
    if (var_74cd64bc) {
        load::function_a2995f22(1);
        array::thread_all(getentarray("ammo_cache", "script_noteworthy"), &oed::function_14ec2d71);
    }
    util::wait_network_frame();
    level thread function_77e31f62();
    level thread function_588f1876();
    level thread function_8c26918a();
    clientfield::set("hide_station_miscmodels", 0);
    clientfield::set("delete_fxanim_fans", 1);
    function_bedc6a60();
}

// Namespace namespace_bedc6a60
// Params 0, eflags: 0x0
// Checksum 0xaa09aa40, Offset: 0x1d88
// Size: 0x3a
function function_77e31f62() {
    wait 0.05;
    level util::clientnotify("hosp_amb");
    level util::clientnotify("inv");
}

// Namespace namespace_bedc6a60
// Params 0, eflags: 0x0
// Checksum 0xe1c2f960, Offset: 0x1dd0
// Size: 0x4a
function function_3aea851b() {
    assert(isdefined(self.script_string), "<dev string:x28>" + self.origin + "<dev string:x2f>");
    self scene::play(self.script_string, self);
}

// Namespace namespace_bedc6a60
// Params 0, eflags: 0x0
// Checksum 0x91f5dba7, Offset: 0x1e28
// Size: 0x8a
function function_bb2cfd0f() {
    self endon(#"death");
    s_start = struct::get(self.target, "targetname");
    var_305876e1 = spawn("script_model", s_start.origin);
    var_305876e1 setmodel("veh_t7_drone_raps");
    self function_9e35fc47(s_start, var_305876e1);
}

// Namespace namespace_bedc6a60
// Params 2, eflags: 0x0
// Checksum 0xaf88b9b4, Offset: 0x1ec0
// Size: 0xf2
function function_9e35fc47(s_start, var_305876e1) {
    self endon(#"death");
    var_a0e1464d = struct::get_array(s_start.target, "targetname");
    s_end = var_a0e1464d[randomint(var_a0e1464d.size)];
    var_305876e1.origin = s_start.origin;
    var_305876e1.angles = s_start.angles;
    var_305876e1 moveto(s_end.origin, 1.1);
    var_305876e1 waittill(#"movedone");
    self.origin = var_305876e1.origin;
    self.angles = var_305876e1.angles;
    var_305876e1 delete();
}

// Namespace namespace_bedc6a60
// Params 0, eflags: 0x0
// Checksum 0x6455c973, Offset: 0x1fc0
// Size: 0x132
function function_8d670bce() {
    self endon(#"death");
    if (isdefined(self.target)) {
        v_goal = struct::get(self.target, "targetname").origin;
    } else {
        self setgoal(level.activeplayers[0]);
        return;
    }
    self ai::set_ignoreall(1);
    self ai::set_ignoreme(1);
    self vehicle_ai::start_scripted();
    self setneargoalnotifydist(-128);
    self setvehgoalpos(v_goal, 0, 1);
    self util::waittill_any_timeout(5, "goal", "near_goal", "force_goal", "change_state");
    self ai::set_ignoreall(0);
    self ai::set_ignoreme(0);
    self clearvehgoalpos();
    self vehicle_ai::stop_scripted("combat");
}

// Namespace namespace_bedc6a60
// Params 0, eflags: 0x0
// Checksum 0x9daf4d9d, Offset: 0x2100
// Size: 0xda
function function_3e73806() {
    self endon(#"death");
    self ai::set_ignoreme(1);
    self.settings.detonation_distance = 32;
    self.settings.jump_chance = 1;
    if (isdefined(self.target)) {
        vnd_start = getvehiclenode(self.target, "targetname");
        self vehicle::get_on_and_go_path(vnd_start);
    } else if (isdefined(self.script_int)) {
        self function_be0dddf9(80);
    }
    self vehicle_ai::stop_scripted("combat");
    self ai::set_ignoreme(0);
}

// Namespace namespace_bedc6a60
// Params 1, eflags: 0x0
// Checksum 0x9d696fde, Offset: 0x21e8
// Size: 0xb2
function function_be0dddf9(n_scale) {
    self endon(#"death");
    v_direction = anglestoforward(self.angles);
    v_force = v_direction * n_scale;
    self.is_jumping = 1;
    self launchvehicle(v_force, self.origin + (0, 0, -4));
    assert(isdefined(self.script_int), "<dev string:x76>" + self.origin + "<dev string:x87>");
    wait self.script_int;
    self.is_jumping = 0;
}

// Namespace namespace_bedc6a60
// Params 0, eflags: 0x0
// Checksum 0x9368a703, Offset: 0x22a8
// Size: 0x92
function function_28238a2a() {
    self.goalradius = 96;
    var_b8f9a884 = getvehiclearray("station_capture_turret", "script_noteworthy");
    var_b8f9a884 = var_b8f9a884[0];
    self endon(#"death");
    self setgoal(var_b8f9a884.origin, 1);
    self waittill(#"goal");
    var_b8f9a884 thread function_dc5930d5(self);
    self function_421b19bb(var_b8f9a884);
}

// Namespace namespace_bedc6a60
// Params 1, eflags: 0x0
// Checksum 0x4626d84b, Offset: 0x2348
// Size: 0x52
function function_dc5930d5(var_dfb53de7) {
    self endon(#"death");
    self.team = "axis";
    var_dfb53de7 waittill(#"death");
    var_dfb53de7 unlink();
    self.team = "allies";
}

// Namespace namespace_bedc6a60
// Params 1, eflags: 0x0
// Checksum 0x77066e2e, Offset: 0x23a8
// Size: 0xfa
function function_421b19bb(var_b8f9a884) {
    self endon(#"death");
    var_2dc8ad57 = getent("station_fight_enemy_balcony_goaltrig", "targetname");
    self ai::set_ignoreme(1);
    self ai::set_ignoreall(1);
    self forceteleport(var_b8f9a884.origin, var_b8f9a884.angles, 1);
    self linkto(var_b8f9a884);
    var_b8f9a884 waittill(#"death");
    self clearforcedgoal();
    self ai::set_ignoreme(0);
    self ai::set_ignoreall(0);
    self unlink();
    self.goalradius = 1024;
    self setgoal(var_2dc8ad57);
}

// Namespace namespace_bedc6a60
// Params 0, eflags: 0x0
// Checksum 0xe9c07cd6, Offset: 0x24b0
// Size: 0x2
function function_ffd0e6b9() {
    
}

// Namespace namespace_bedc6a60
// Params 2, eflags: 0x0
// Checksum 0x7b44a075, Offset: 0x24c0
// Size: 0x12a
function function_dfedb0b8(str_objective, var_74cd64bc) {
    level.var_2fd26037 = util::function_740f8516("hendricks");
    level.var_9db406db = util::function_740f8516("khalil");
    level.var_7a9855f3 = util::function_740f8516("rachel");
    level.var_2fd26037 ai::set_ignoreall(1);
    level.var_7a9855f3 ai::set_ignoreall(1);
    level.var_7a9855f3 ai::set_ignoreme(1);
    level.var_2fd26037.goalradius = 32;
    level.var_9db406db.goalradius = 32;
    level.var_7a9855f3.goalradius = 32;
    level.var_2fd26037 setgoal(level.var_2fd26037.origin);
    if (var_74cd64bc) {
        function_c052d16e();
    }
}

// Namespace namespace_bedc6a60
// Params 0, eflags: 0x0
// Checksum 0xccbb4a6a, Offset: 0x25f8
// Size: 0xaa
function function_c052d16e() {
    var_f18b8368 = struct::get("defend_ramses_station_hendricks_start_spot", "targetname");
    var_5c2809be = struct::get("defend_ramses_station_khalil_start_spot", "targetname");
    level.var_2fd26037 forceteleport(var_f18b8368.origin, var_f18b8368.angles, 1);
    level.var_9db406db forceteleport(var_5c2809be.origin, var_5c2809be.angles, 1);
}

// Namespace namespace_bedc6a60
// Params 0, eflags: 0x0
// Checksum 0xb919b189, Offset: 0x26b0
// Size: 0x4a
function init_turrets() {
    var_53acb497 = getentarray("station_fight_turret", "targetname");
    array::thread_all(var_53acb497, &function_785ac501);
}

// Namespace namespace_bedc6a60
// Params 0, eflags: 0x0
// Checksum 0x42034881, Offset: 0x2708
// Size: 0xb2
function function_785ac501() {
    s_obj = struct::get(self.script_string, "targetname");
    var_93cb1c05 = spawn("trigger_radius", self.origin, 0, s_obj.radius, -128);
    var_93cb1c05.script_objective = "vtol_ride";
    e_turret = self;
    self thread namespace_391e4301::function_b0ef4ae7(s_obj);
    level waittill(#"hash_eae489c0");
    e_turret function_6727bc7f(s_obj, var_93cb1c05);
}

// Namespace namespace_bedc6a60
// Params 2, eflags: 0x0
// Checksum 0x324e3dad, Offset: 0x27c8
// Size: 0xcc
function function_b87ae655(s_obj, var_93cb1c05) {
    var_b8f9a884 = getent("station_fight_turret_respawn", "targetname");
    var_b8f9a884.team = "allies";
    var_70345f7f = util::spawn_model(self.model, self.origin, self.angles);
    self.delete_on_death = 1;
    self notify(#"death");
    if (!isalive(self)) {
        self delete();
    }
    var_b8f9a884 thread function_2217e3ee(var_70345f7f, s_obj, var_93cb1c05);
    return var_70345f7f;
}

// Namespace namespace_bedc6a60
// Params 3, eflags: 0x0
// Checksum 0xdbdce7ce, Offset: 0x28a0
// Size: 0xb2
function function_2217e3ee(var_70345f7f, s_obj, var_93cb1c05) {
    level endon(#"mobile_wall_fxanim_start");
    level flag::wait_till("station_fight_body_pull_scene_completed");
    self.origin = var_70345f7f.origin;
    self.angles = var_70345f7f.angles;
    var_70345f7f delete();
    self thread namespace_391e4301::function_b0ef4ae7(s_obj);
    if (!level flag::get("station_fight_completed")) {
        self thread function_6727bc7f(s_obj, var_93cb1c05);
    }
}

// Namespace namespace_bedc6a60
// Params 0, eflags: 0x0
// Checksum 0xc51f592a, Offset: 0x2960
// Size: 0x4a2
function function_bedc6a60() {
    var_1bd4d1f2 = getent("station_fight_raps_jump", "targetname");
    var_1bd4d1f2 namespace_391e4301::function_486f25d(2, 1);
    spawn_manager::enable("sm_initial_balcony_spawn");
    spawn_manager::enable("sm_balcony_robots");
    level thread namespace_391e4301::function_8afb19cc("sm_balcony_robots", "sm_initial_balcony_spawn");
    level waittill(#"hash_3e9d30d3");
    spawn_manager::enable("sm_initial_recovery_right_spawn");
    level thread spawner::simple_spawn("custom_raps");
    level waittill(#"raps_intro_done");
    util::clear_streamer_hint();
    trigger::wait_or_timeout(20, "trigger_ceiling_collapse");
    level notify(#"hash_1ca7165");
    level thread function_aa370a40();
    spawn_manager::enable("station_fight_raps_jump");
    wait 3;
    spawn_manager::enable("sm_ceiling_fight_server_robots");
    spawn_manager::enable("sm_server_fights_ceiling_ally");
    level thread namespace_391e4301::function_8afb19cc("sm_ceiling_fight_server_robots", "sm_server_fights_ceiling_ally");
    wait 3;
    level thread function_d44417a0();
    util::wait_network_frame();
    level thread function_cbcb2bb();
    util::wait_network_frame();
    level thread function_e59f097a();
    util::wait_network_frame();
    spawn_manager::enable("sm_right_across_gap_human");
    level thread function_21130bd8("sm_right_across_gap_human");
    level thread function_934468e4("sm_right_across_gap_human");
    wait 10;
    spawn_manager::enable("sm_rap_trickle");
    function_917e4a1b();
    spawn_manager::wait_till_cleared("station_fight_wave1_robots_left");
    spawn_manager::wait_till_cleared("station_fight_wave1_robots_right");
    spawn_manager::wait_till_cleared("sm_ceiling_fight_server_robots");
    spawn_manager::wait_till_cleared("station_fight_raps_jump");
    spawn_manager::wait_till_cleared("sm_balcony_robots");
    level flag::wait_till("station_phalanx_dead");
    level flag::wait_till("station_right_phalanx_dead");
    level flag::wait_till("station_center_phalanx_dead");
    if (!level flag::get("drop_pod_opened_and_spawned")) {
        trigger::use("trig_open_pod", "targetname");
        wait 1;
    }
    level spawner::waittill_ai_group_cleared("droppod_ai");
    var_262d783a = spawn_manager::function_423eae50("sm_rap_trickle");
    spawn_manager::kill("sm_rap_trickle");
    foreach (var_388753bb in var_262d783a) {
        var_388753bb raps::detonate();
    }
    if (isdefined(level.var_c4dba52c)) {
        [[ level.var_c4dba52c ]]();
    }
    level flag::set("station_fight_completed");
    if (isdefined(level.var_a6e609d2)) {
        level thread [[ level.var_a6e609d2 ]]();
    }
    battlechatter::function_d9f49fba(0, "bc");
    objectives::complete("cp_level_ramses_defend_station");
    level thread util::function_d8eaed3d(3);
    level thread function_52111922();
    function_c01d9b2();
    level thread function_1d0e7c11();
}

// Namespace namespace_bedc6a60
// Params 0, eflags: 0x0
// Checksum 0xebe836f0, Offset: 0x2e10
// Size: 0x1a2
function function_91e74b85() {
    level flag::wait_till("all_players_connected");
    level flag::init("station_fight_started");
    spawner::add_spawn_function_group("initial_station_fight_ai", "script_noteworthy", &function_d0f8bc28, "station_fight_started");
    spawner::add_spawn_function_group("initial_station_fight_ai", "script_noteworthy", &namespace_391e4301::function_258b9bad, "ceiling_collapse_complete", 1);
    spawn_manager::enable("station_fight_wave1_robots_left");
    spawn_manager::enable("sm_initial_arch_spawn_left");
    spawn_manager::enable("station_fight_wave1_robots_right");
    spawn_manager::enable("sm_initial_arch_spawn_right");
    spawn_manager::enable("sm_initial_recovery_left_spawn");
    level thread function_97cdc17e();
    level flag::wait_till("station_fight_started");
    level thread namespace_391e4301::function_8afb19cc("station_fight_wave1_robots_left", "sm_initial_arch_spawn_left");
    level thread namespace_391e4301::function_8afb19cc("station_fight_wave1_robots_right", "sm_initial_arch_spawn_right");
    level thread function_845b69ec("sm_initial_arch_spawn_right", "sm_initial_arch_spawn_left");
}

// Namespace namespace_bedc6a60
// Params 1, eflags: 0x0
// Checksum 0xca51b2a, Offset: 0x2fc0
// Size: 0x122
function function_d0f8bc28(str_flag) {
    self endon(#"death");
    if (isdefined(self.target)) {
        e_goal = getent(self.target, "targetname");
        if (!isdefined(e_goal)) {
            var_9de10fe3 = getnode(self.target, "targetname");
        }
    }
    self setgoal(self.origin, 0, 32);
    self ai::set_ignoreall(1);
    self ai::set_ignoreme(1);
    level flag::wait_till(str_flag);
    if (isdefined(e_goal)) {
        self setgoal(e_goal);
    } else if (isdefined(var_9de10fe3)) {
        self setgoal(var_9de10fe3);
    } else {
        self.goalradius = 512;
    }
    self ai::set_ignoreall(0);
    self ai::set_ignoreme(0);
}

// Namespace namespace_bedc6a60
// Params 0, eflags: 0x0
// Checksum 0xfd798f6c, Offset: 0x30f0
// Size: 0x139
function function_52111922() {
    var_3ced446f = getaiteamarray("allies");
    var_3f8fb967 = array::exclude(var_3ced446f, level.heroes);
    var_3f8fb967 = array::remove_dead(var_3f8fb967);
    var_1d1c81b8 = getnodearray("station_fight_end_patrol", "targetname");
    if (var_1d1c81b8.size > var_3f8fb967.size) {
        for (i = 0; i < var_3f8fb967.size; i++) {
            var_3f8fb967[i].goalradius = 32;
            var_3f8fb967[i] ai::set_ignoreall(1);
            var_3f8fb967[i] ai::set_behavior_attribute("patrol", 1);
            var_3f8fb967[i] ai::set_behavior_attribute("disablearrivals", 1);
            var_3f8fb967[i] setgoal(var_1d1c81b8[i], 1);
            wait randomfloatrange(0.25, 1);
        }
    }
}

// Namespace namespace_bedc6a60
// Params 0, eflags: 0x0
// Checksum 0x84bf8ac5, Offset: 0x3238
// Size: 0x93
function function_917e4a1b() {
    do {
        wait 0.5;
        a_enemies = getaiteamarray("axis");
    } while (a_enemies.size > 3);
    foreach (ai in a_enemies) {
        ai thread function_d02622d1();
    }
}

// Namespace namespace_bedc6a60
// Params 0, eflags: 0x0
// Checksum 0xad9f245d, Offset: 0x32d8
// Size: 0xf2
function function_d02622d1() {
    self endon(#"death");
    do {
        foreach (player in level.activeplayers) {
            if (!player util::is_player_looking_at(self.origin) && distance(self.origin, util::get_closest_player(self.origin, "allies").origin) > -56) {
                var_d8c90b1a = 1;
            }
            wait 0.05;
        }
    } while (!isdefined(var_d8c90b1a));
    self util::stop_magic_bullet_shield();
    self kill();
}

// Namespace namespace_bedc6a60
// Params 0, eflags: 0x0
// Checksum 0x1a282926, Offset: 0x33d8
// Size: 0x53
function function_157bd88d() {
    self endon(#"death");
    if (self.targetname == "right_across_gap_human") {
        level flag::wait_till("player_right_side_gap");
    } else {
        level flag::wait_till("player_right_side");
    }
    self notify(#"player_is_close");
}

// Namespace namespace_bedc6a60
// Params 0, eflags: 0x0
// Checksum 0xe5a35920, Offset: 0x3438
// Size: 0x53
function function_23c641de() {
    self endon(#"death");
    while (isdefined(level.var_9db406db) && distance(self.origin, level.var_9db406db.origin) > -128) {
        wait 0.25;
    }
    self notify(#"end_balcony_shields");
}

// Namespace namespace_bedc6a60
// Params 0, eflags: 0x0
// Checksum 0x3bc7cc57, Offset: 0x3498
// Size: 0x9b
function function_46eb86a4() {
    self endon(#"death");
    level flag::wait_till("ceiling_collapse_complete");
    while (true) {
        e_target = self waittill(#"failed_melee_mbs");
        if (e_target == level.var_9db406db || e_target == level.var_2fd26037) {
            self notify(#"hash_9b484394");
            continue;
        }
        if (e_target != level.var_9db406db && e_target != level.var_2fd26037 && !isplayer(e_target)) {
            e_target notify(#"hash_9b484394");
        }
    }
}

// Namespace namespace_bedc6a60
// Params 0, eflags: 0x0
// Checksum 0x567d2bcb, Offset: 0x3540
// Size: 0x172
function function_4ebb88f6() {
    spawner::add_spawn_function_group("robot_intro_robot", "targetname", &ai::set_ignoreme, 1);
    spawner::add_spawn_function_group("robot_intro_robot", "targetname", &util::magic_bullet_shield);
    level scene::init("cin_ram_03_02_defend_vign_robotintro");
    trigger::wait_till("trig_robot_intro_vignette");
    var_6104a93b = getent("robot_intro_robot_ai", "targetname");
    var_75443889 = getent("robot_intro_guy_ai", "targetname");
    var_6104a93b util::stop_magic_bullet_shield();
    level thread scene::play("cin_ram_03_02_defend_vign_robotintro");
    var_6104a93b thread function_ad9d7c7a(var_75443889);
    level util::waittill_notify_or_timeout("cin_ram_03_02_defend_vign_robotintro_done", 7);
    if (isalive(var_6104a93b)) {
        var_6104a93b ai::set_behavior_attribute("move_mode", "rusher");
        var_6104a93b ai::set_ignoreme(0);
    }
}

// Namespace namespace_bedc6a60
// Params 1, eflags: 0x0
// Checksum 0xf6b12fc7, Offset: 0x36c0
// Size: 0x7a
function function_ad9d7c7a(var_75443889) {
    level endon(#"cin_ram_03_02_defend_vign_robotintro_done");
    self waittill(#"death");
    scene::stop("cin_ram_03_02_defend_vign_robotintro");
    if (isalive(var_75443889)) {
        var_75443889 startragdoll();
        var_75443889 util::stop_magic_bullet_shield();
        var_75443889 kill();
    }
}

// Namespace namespace_bedc6a60
// Params 0, eflags: 0x0
// Checksum 0x5f999d3f, Offset: 0x3748
// Size: 0xf2
function function_aa370a40() {
    trigger::wait_till("trig_open_pod", "targetname");
    savegame::checkpoint_save();
    level thread scene::play("p7_fxanim_cp_ramses_station_ceiling_vtol_bundle");
    level flag::set("drop_pod_opened_and_spawned");
    level thread function_697c5b58();
    var_2ef9d306 = getent("station_ceiling_troopcarrier", "targetname");
    var_2ef9d306 connectpaths();
    wait 0.2;
    var_f10bb7b8 = getent("vtol_navmesh_cutter", "targetname");
    var_f10bb7b8 disconnectpaths();
    wait 0.5;
}

// Namespace namespace_bedc6a60
// Params 0, eflags: 0x0
// Checksum 0xb0a90e6e, Offset: 0x3848
// Size: 0x152
function function_d44417a0() {
    level flag::init("station_phalanx_dead");
    v_start_position = struct::get("station_phalanx_start", "targetname").origin;
    var_e2ea1b3f = struct::get("station_phalanx_end", "targetname").origin;
    if (level.players.size == 1) {
        n_ai_count = 3;
    } else {
        n_ai_count = level.players.size + 2;
    }
    var_a3decff = new robotphalanx();
    [[ var_a3decff ]]->initialize("phalanx_column_right", v_start_position, var_e2ea1b3f, 1, n_ai_count);
    robots = arraycombine(arraycombine(var_a3decff.tier1robots_, var_a3decff.tier2robots_, 0, 0), var_a3decff.tier3robots_, 0, 0);
    array::wait_till(robots, "death");
    level flag::set("station_phalanx_dead");
}

// Namespace namespace_bedc6a60
// Params 0, eflags: 0x0
// Checksum 0xbd628792, Offset: 0x39a8
// Size: 0x1d2
function function_cbcb2bb() {
    level flag::init("station_right_phalanx_dead");
    v_start_position = struct::get("station_right_phalanx_start", "targetname").origin;
    var_e2ea1b3f = struct::get("station_right_phalanx_end", "targetname").origin;
    var_a3decff = new robotphalanx();
    [[ var_a3decff ]]->initialize("phanalx_wedge", v_start_position, var_e2ea1b3f, 2, 3);
    var_61a19dc6 = arraycombine(arraycombine(var_a3decff.tier1robots_, var_a3decff.tier2robots_, 0, 0), var_a3decff.tier3robots_, 0, 0);
    foreach (var_6104a93b in var_61a19dc6) {
        var_6104a93b thread namespace_391e4301::function_258b9bad("gap_soldiers_dead", 1, "station_right_phalanx_scatter");
        var_6104a93b thread namespace_391e4301::function_258b9bad("player_is_close", 1, "station_right_phalanx_scatter");
    }
    level thread function_3da9f438(var_e2ea1b3f);
    var_a3decff thread function_32800c59("station_right_phalanx_scatter");
    array::wait_till(var_61a19dc6, "death");
    level flag::set("station_right_phalanx_dead");
}

// Namespace namespace_bedc6a60
// Params 0, eflags: 0x0
// Checksum 0x419408af, Offset: 0x3b88
// Size: 0x162
function function_e59f097a() {
    level flag::init("station_center_phalanx_dead");
    v_start_position = struct::get("station_center_phalanx_start", "targetname").origin;
    var_e2ea1b3f = struct::get("station_center_phalanx_end", "targetname").origin;
    if (level.players.size < 3) {
        n_ai_count = 4;
    } else {
        n_ai_count = level.players.size + 2;
    }
    var_a3decff = new robotphalanx();
    [[ var_a3decff ]]->initialize("phalanx_column_right", v_start_position, var_e2ea1b3f, 1, n_ai_count);
    var_a3decff thread function_a6f57c70(20);
    var_61a19dc6 = arraycombine(arraycombine(var_a3decff.tier1robots_, var_a3decff.tier2robots_, 0, 0), var_a3decff.tier3robots_, 0, 0);
    array::wait_till(var_61a19dc6, "death");
    level flag::set("station_center_phalanx_dead");
}

// Namespace namespace_bedc6a60
// Params 1, eflags: 0x0
// Checksum 0x1e5c591b, Offset: 0x3cf8
// Size: 0x22
function function_32800c59(var_ed2ece1e) {
    level waittill(var_ed2ece1e);
    self robotphalanx::scatterphalanx();
}

// Namespace namespace_bedc6a60
// Params 1, eflags: 0x0
// Checksum 0xed9ecc80, Offset: 0x3d28
// Size: 0x2a
function function_a6f57c70(n_delay) {
    level endon(#"station_center_phalanx_dead");
    wait n_delay;
    if (isdefined(self)) {
        self robotphalanx::scatterphalanx();
    }
}

// Namespace namespace_bedc6a60
// Params 1, eflags: 0x0
// Checksum 0xad99523b, Offset: 0x3d60
// Size: 0xc7
function function_3da9f438(var_3c23ee9a) {
    level endon(#"station_right_phalanx_dead");
    do {
        foreach (player in level.activeplayers) {
            if (isdefined(player) && player util::is_player_looking_at(var_3c23ee9a)) {
                if (distance(player.origin, var_3c23ee9a) < 800) {
                    level notify(#"player_is_close");
                    level notify(#"station_right_phalanx_scatter");
                    return;
                }
            }
            wait 0.05;
        }
        wait 0.1;
    } while (true);
}

// Namespace namespace_bedc6a60
// Params 1, eflags: 0x0
// Checksum 0xf1a85221, Offset: 0x3e30
// Size: 0x5f
function function_21130bd8(var_5159fb67) {
    level endon(#"station_right_phalanx_dead");
    do {
        wait 0.5;
        var_46c58ac8 = spawn_manager::function_423eae50(var_5159fb67);
    } while (var_46c58ac8.size > 0 || spawn_manager::is_enabled(var_5159fb67));
    level notify(#"gap_soldiers_dead");
}

// Namespace namespace_bedc6a60
// Params 1, eflags: 0x0
// Checksum 0x367d091e, Offset: 0x3e98
// Size: 0xa3
function function_934468e4(var_5159fb67) {
    level endon(#"gap_soldiers_dead");
    level util::waittill_any("station_right_phalanx_dead", "station_right_phalanx_scatter");
    var_46c58ac8 = spawn_manager::function_423eae50(var_5159fb67);
    foreach (var_fbc8888 in var_46c58ac8) {
        var_fbc8888.goalradius = 1024;
    }
}

// Namespace namespace_bedc6a60
// Params 1, eflags: 0x0
// Checksum 0x7c9dd04d, Offset: 0x3f48
// Size: 0x4a
function function_f117c7bd(var_f3a8e7d6) {
    var_1957a2a5 = spawn_manager::function_423eae50("station_fight_wave1_robots_left");
    array::thread_all(var_1957a2a5, &function_44fa8311);
}

// Namespace namespace_bedc6a60
// Params 0, eflags: 0x0
// Checksum 0x13316687, Offset: 0x3fa0
// Size: 0x4a
function function_44fa8311() {
    self endon(#"death");
    wait randomfloatrange(0.15, 0.5);
    util::stop_magic_bullet_shield(self);
    self kill();
}

// Namespace namespace_bedc6a60
// Params 0, eflags: 0x0
// Checksum 0x6b0a5aec, Offset: 0x3ff8
// Size: 0x172
function function_697c5b58() {
    var_c4152dcd = spawner::simple_spawn("droppod_robot", &function_658e0c1a);
    wait 0.5;
    arraysortclosest(var_c4152dcd, struct::get("drop_pod_fire_loc").origin);
    foreach (var_6104a93b in var_c4152dcd) {
        if (isalive(var_6104a93b)) {
            var_6104a93b ai::set_ignoreall(0);
            var_6104a93b ai::set_ignoreme(0);
            var_6104a93b ai::set_behavior_attribute("move_mode", "rusher");
            var_6104a93b notify(#"out_of_pod");
            var_6104a93b.var_69dd5d62 = undefined;
            wait 1;
        }
    }
    array::wait_till(var_c4152dcd, "death");
    getent("drop_pod_fire_clip", "targetname") movez(100, 0.05);
}

// Namespace namespace_bedc6a60
// Params 0, eflags: 0x0
// Checksum 0x548e3c49, Offset: 0x4178
// Size: 0x42
function function_658e0c1a() {
    self ai::set_ignoreall(1);
    self ai::set_ignoreme(1);
    self.var_69dd5d62 = 1;
    self namespace_391e4301::function_258b9bad("out_of_pod", 1);
}

// Namespace namespace_bedc6a60
// Params 0, eflags: 0x0
// Checksum 0xb1a0cefc, Offset: 0x41c8
// Size: 0x2ea
function function_588f1876() {
    level waittill(#"raps_intro_done");
    level.var_2fd26037 ai::set_ignoreall(0);
    level thread function_7ba3e35a();
    spawner::waittill_ai_group_ai_count("custom_raps", 0);
    var_2eae89db = struct::get("cin_gen_melee_hendricks_stomp_gibbedrobot", "scriptbundlename");
    level.var_2fd26037 setgoal(var_2eae89db.origin, 0, -128);
    level flag::wait_till("pod_hits_floor");
    level.var_2fd26037 sethighdetail(0);
    while (distance(level.var_2fd26037.origin, var_2eae89db.origin) > 600 && !level flag::get("drop_pod_opened_and_spawned")) {
        wait 0.25;
    }
    if (!level flag::get("drop_pod_opened_and_spawned")) {
        scene::play("cin_gen_melee_hendricks_stomp_gibbedrobot");
    } else if (scene::is_active("cin_gen_melee_hendricks_stomp_gibbedrobot")) {
        scene::stop("cin_gen_melee_hendricks_stomp_gibbedrobot");
    }
    var_b200e7a3 = getent("station_fight_allies_near_goal", "targetname");
    level.var_2fd26037 setgoal(var_b200e7a3);
    var_3ced446f = getactorarray("recovery_room_allies", "script_aigroup");
    foreach (ai in var_3ced446f) {
        ai setgoal(var_b200e7a3, 1);
    }
    level flag::wait_till("drop_pod_opened_and_spawned");
    level.var_2fd26037 setgoal(getent("station_fight_drop_pod_goal", "targetname"));
    level flag::wait_till("station_fight_completed");
    level.var_2fd26037 ai::set_behavior_attribute("disablesprint", 1);
    level scene::play("cin_ram_04_02_easterncheck_vign_jumpdirect_hendricks");
}

// Namespace namespace_bedc6a60
// Params 2, eflags: 0x0
// Checksum 0x139c792f, Offset: 0x44c0
// Size: 0xef
function function_845b69ec(var_b5a8817e, var_8fa60715) {
    level endon(#"hash_1ca7165");
    trigger::wait_till("trig_start_rap_intro", "targetname");
    wait 15;
    var_f91ffbc4 = spawn_manager::function_423eae50(var_b5a8817e);
    var_f91ffbc4 = arraycombine(var_f91ffbc4, spawn_manager::function_423eae50(var_8fa60715), 0, 0);
    var_f91ffbc4 = array::randomize(var_f91ffbc4);
    foreach (var_5abbae22 in var_f91ffbc4) {
        if (isdefined(var_5abbae22)) {
            var_5abbae22 notify(#"hash_9b484394");
        }
        wait 2;
    }
}

// Namespace namespace_bedc6a60
// Params 0, eflags: 0x0
// Checksum 0x57febcfe, Offset: 0x45b8
// Size: 0x1f2
function function_7ba3e35a() {
    setenablenode(level.var_85b298df, 1);
    level.var_9db406db setgoal(level.var_85b298df, 0, 64);
    level.var_85b298df = undefined;
    level flag::wait_till("ceiling_collapse_complete");
    level thread scene::play("cin_ram_03_03_defend_vign_balconybash_khalil_init");
    level waittill(#"hash_40171b94");
    if (scene::is_playing("cin_ram_03_03_defend_vign_balconybash_khalil_init")) {
        level scene::stop("cin_ram_03_03_defend_vign_balconybash_khalil_init");
    }
    level scene::play("cin_ram_03_03_defend_vign_balconybash");
    var_c9ae457a = getent("initial_balcony_friendly_volume", "targetname");
    level.var_9db406db setgoal(var_c9ae457a);
    spawn_manager::wait_till_cleared("sm_balcony_robots");
    var_c9ae457a = getent("second_balcony_friendly_volume", "targetname");
    level.var_9db406db setgoal(var_c9ae457a);
    level flag::wait_till("drop_pod_opened_and_spawned");
    level.var_9db406db setgoal(getnode("khalil_balcony_platform_node", "targetname"), 1);
    level flag::wait_till("station_fight_completed");
    level.var_9db406db ai::set_behavior_attribute("disablesprint", 1);
    scene::play("cin_ram_04_02_easterncheck_vign_jumpdirect_khalil");
}

// Namespace namespace_bedc6a60
// Params 1, eflags: 0x0
// Checksum 0x1878dda4, Offset: 0x47b8
// Size: 0x15a
function function_1a2278be(a_ents) {
    var_6104a93b = a_ents["balcony_bash_robot"];
    var_75443889 = a_ents["balcony_bash_soldier"];
    var_75443889 ai::set_ignoreme(1);
    var_75443889 thread function_3ee9fc92();
    var_6104a93b.goalradius = 32;
    var_6104a93b ai::set_ignoreall(1);
    var_6104a93b ai::set_ignoreme(1);
    util::magic_bullet_shield(var_6104a93b);
    var_6104a93b setgoal(var_6104a93b.origin, 1);
    level waittill(#"hash_6daeefef");
    var_75443889 ai::set_ignoreme(0);
    util::stop_magic_bullet_shield(var_6104a93b);
    var_6104a93b waittill(#"death");
    scene::stop("cin_ram_03_03_defend_vign_balconybash");
    if (isdefined(var_75443889) && isalive(var_75443889) && var_75443889 flag::get("past_ragdoll_frame")) {
        var_75443889 startragdoll();
        var_75443889 kill();
    }
}

// Namespace namespace_bedc6a60
// Params 0, eflags: 0x0
// Checksum 0x30fba91e, Offset: 0x4920
// Size: 0x42
function function_3ee9fc92() {
    self flag::init("past_ragdoll_frame");
    self endon(#"death");
    self waittill(#"hash_8368b9dc");
    self flag::set("past_ragdoll_frame");
}

// Namespace namespace_bedc6a60
// Params 1, eflags: 0x0
// Checksum 0x33b7c295, Offset: 0x4970
// Size: 0x5a
function function_c0443db4(a_ents) {
    var_6104a93b = a_ents["stomped_robot"];
    if (isalive(var_6104a93b)) {
        var_6104a93b ai::set_ignoreme(1);
        var_6104a93b disableaimassist();
    }
}

// Namespace namespace_bedc6a60
// Params 0, eflags: 0x0
// Checksum 0xaf4d45f6, Offset: 0x49d8
// Size: 0xba
function function_8c26918a() {
    scene::add_scene_func("cin_gen_melee_hendricks_stomp_gibbedrobot", &function_c0443db4, "init");
    scene::init("cin_gen_melee_hendricks_stomp_gibbedrobot");
    level thread raps_intro();
    level thread function_cb0ba609();
    function_2674a7fb();
    level notify(#"hash_e14845f6");
    level thread namespace_e4c0c552::function_f444bf8e();
    level flag::wait_till("station_fight_completed");
    level thread namespace_e4c0c552::function_9bda9447();
}

// Namespace namespace_bedc6a60
// Params 0, eflags: 0x0
// Checksum 0x607e7afc, Offset: 0x4aa0
// Size: 0x24a
function raps_intro() {
    level thread function_98b76328();
    level thread function_bf01a134();
    level thread function_370bd9a9();
    scene::add_scene_func("cin_ram_03_01_defend_1st_rapsintro", &function_d10a6306, "play");
    scene::add_scene_func("cin_ram_03_01_defend_1st_rapsintro", &function_3b3f857a, "done");
    namespace_391e4301::function_ac2b4535("cin_ram_03_01_defend_1st_rapsintro", "defend_ramses_station");
    foreach (player in level.players) {
        player.ignoreme = 1;
    }
    getent("raps_intro_door_clip", "targetname") delete();
    level.var_7a9855f3 sethighdetail(0);
    level.var_9db406db sethighdetail(0);
    level flag::set("station_fight_started");
    level scene::play("cin_ram_03_01_defend_1st_rapsintro", level.var_be0fc6c8);
    level flag::set("raps_intro_done");
    objectives::set("cp_level_ramses_defend_station");
    wait 1.5;
    foreach (player in level.players) {
        player.ignoreme = 0;
    }
    savegame::checkpoint_save();
}

// Namespace namespace_bedc6a60
// Params 0, eflags: 0x0
// Checksum 0xf8dcf60d, Offset: 0x4cf8
// Size: 0x102
function function_97cdc17e() {
    var_5d7a0794 = spawner::simple_spawn_single("station_fight_wounded_guy");
    scene::init("cin_gen_wounded_last_stand_guy01", var_5d7a0794);
    var_5d7a0794 = spawner::simple_spawn_single("station_fight_wounded_guy");
    scene::init("cin_gen_wounded_last_stand_guy02", var_5d7a0794);
    var_5d7a0794 = spawner::simple_spawn_single("station_fight_wounded_guy");
    scene::init("cin_gen_wounded_last_stand_guy03", var_5d7a0794);
    level flag::wait_till("station_fight_started");
    level thread scene::play("cin_gen_wounded_last_stand_guy02");
    level waittill(#"raps_intro_done");
    level thread scene::play("cin_gen_wounded_last_stand_guy01");
    level thread scene::play("cin_gen_wounded_last_stand_guy03");
}

// Namespace namespace_bedc6a60
// Params 1, eflags: 0x0
// Checksum 0x5375148e, Offset: 0x4e08
// Size: 0x3a
function function_d10a6306(a_ents) {
    level waittill(#"hash_581ac182");
    var_75443889 = a_ents["rap_intro_guy"];
    var_75443889 setmodel("c_ega_soldier_3_pincushion_armoff_fb");
}

// Namespace namespace_bedc6a60
// Params 1, eflags: 0x0
// Checksum 0x663272ab, Offset: 0x4e50
// Size: 0x122
function function_3b3f857a(a_ents) {
    a_ents["rap_intro_guy"] clientfield::increment("hide_graphic_content", 1);
    a_ents["arm"] clientfield::increment("hide_graphic_content", 1);
    a_ents["shrapnel02"] clientfield::increment("hide_graphic_content", 1);
    a_ents["shrapnel03"] clientfield::increment("hide_graphic_content", 1);
    a_ents["shrapnel04"] clientfield::increment("hide_graphic_content", 1);
    a_ents["shrapnel06"] clientfield::increment("hide_graphic_content", 1);
    a_ents["shrapnel07"] clientfield::increment("hide_graphic_content", 1);
}

// Namespace namespace_bedc6a60
// Params 1, eflags: 0x0
// Checksum 0xd2de0d54, Offset: 0x4f80
// Size: 0x7b
function function_896cfa4c(a_ents) {
    util::wait_network_frame();
    foreach (ent in a_ents) {
        ent clientfield::increment("hide_graphic_content", 1);
    }
}

// Namespace namespace_bedc6a60
// Params 0, eflags: 0x0
// Checksum 0x28feb3f2, Offset: 0x5008
// Size: 0x32
function function_370bd9a9() {
    level waittill(#"hash_646da0a");
    level thread function_31000a81();
    level waittill(#"hash_646da0a");
    level thread function_31000a81();
}

// Namespace namespace_bedc6a60
// Params 0, eflags: 0x0
// Checksum 0xbe12136f, Offset: 0x5048
// Size: 0x7b
function function_31000a81() {
    foreach (e_player in level.players) {
        if (e_player.current_scene === "cin_ram_03_01_defend_1st_rapsintro") {
            e_player clientfield::increment_to_player("rap_blood_on_player");
        }
    }
}

// Namespace namespace_bedc6a60
// Params 0, eflags: 0x0
// Checksum 0x6dd62a7c, Offset: 0x50d0
// Size: 0x22
function function_98b76328() {
    level waittill(#"hash_f532337c");
    level util::clientnotify("dro");
}

// Namespace namespace_bedc6a60
// Params 0, eflags: 0x0
// Checksum 0xb4963a8c, Offset: 0x5100
// Size: 0x22
function function_bf01a134() {
    level waittill(#"hash_ecd64ab9");
    level scene::play("p7_fxanim_cp_ramses_raps_explosion_bundle");
}

// Namespace namespace_bedc6a60
// Params 0, eflags: 0x0
// Checksum 0xd64154f4, Offset: 0x5130
// Size: 0x163
function function_2674a7fb() {
    scene::add_scene_func("p7_fxanim_cp_ramses_station_ceiling_vtol_bundle", &function_e4e450c1, "init");
    scene::add_scene_func("p7_fxanim_cp_ramses_station_ceiling_bundle", &function_9c5046ad, "play");
    scene::add_scene_func("p7_fxanim_cp_ramses_station_ceiling_bundle", &function_316c9fe0, "play");
    scene::add_scene_func("p7_fxanim_cp_ramses_station_ceiling_bundle", &function_f117c7bd, "done");
    level scene::init("p7_fxanim_cp_ramses_station_ceiling_bundle");
    level waittill(#"hash_1ca7165");
    level thread function_fea402e8();
    level thread function_a97a010f();
    level thread function_16c6b95d();
    level function_bded1c1e();
    level flag::set("ceiling_collapse_complete");
    level scene::init("p_ramses_lift_wing_blockage");
    level notify(#"hash_eae489c0");
    level notify(#"hash_d758e82");
}

// Namespace namespace_bedc6a60
// Params 0, eflags: 0x0
// Checksum 0xafaf2385, Offset: 0x52a0
// Size: 0x22
function function_16c6b95d() {
    level waittill(#"hash_16c6b95d");
    exploder::exploder("ceiling_colapse");
}

// Namespace namespace_bedc6a60
// Params 1, eflags: 0x0
// Checksum 0x588f6e3d, Offset: 0x52d0
// Size: 0xb3
function function_14b2c542(a_ents) {
    a_structs = struct::get_array("station_phys_pulse", "targetname");
    foreach (struct in a_structs) {
        physicsjolt(struct.origin, -1, 1, math::random_vector(20));
        wait 0.05;
    }
}

// Namespace namespace_bedc6a60
// Params 0, eflags: 0x0
// Checksum 0x64069ab0, Offset: 0x5390
// Size: 0x32
function function_bded1c1e() {
    level thread scene::play("p7_fxanim_cp_ramses_station_ceiling_bundle");
    level scene::init("p7_fxanim_cp_ramses_station_ceiling_vtol_bundle");
}

// Namespace namespace_bedc6a60
// Params 0, eflags: 0x0
// Checksum 0x9db978ee, Offset: 0x53d0
// Size: 0x92
function function_a97a010f() {
    level waittill(#"pod_hits_floor");
    level flag::set("pod_hits_floor");
    if (spawn_manager::function_423eae50("station_fight_wave1_robots_left").size > 0) {
        var_8f75db49 = struct::get("pod_radius_damage", "targetname");
        radiusdamage(var_8f75db49.origin, 300, 1000, 500, undefined, "MOD_EXPLOSIVE");
    }
}

// Namespace namespace_bedc6a60
// Params 0, eflags: 0x0
// Checksum 0xcebf18d1, Offset: 0x5470
// Size: 0x133
function function_e4e450c1() {
    level waittill(#"hash_1bc0fb5c");
    level clientfield::set("defend_fog_banks", 1);
    var_c0be4d28 = getentarray("station_roof_hole", "targetname");
    foreach (piece in var_c0be4d28) {
        piece delete();
    }
    var_2f5160f4 = getentarray("roof_hole_blocker", "targetname");
    foreach (e_blocker in var_2f5160f4) {
        e_blocker hide();
    }
}

// Namespace namespace_bedc6a60
// Params 0, eflags: 0x0
// Checksum 0x6ddb4f61, Offset: 0x55b0
// Size: 0xd2
function function_316c9fe0() {
    wait 1;
    var_673a4bf = getentarray("station_ceiling_pristine", "targetname");
    foreach (piece in var_673a4bf) {
        piece delete();
    }
    level waittill(#"hash_77815dc");
    level thread function_c5b9bd41("_combat");
    function_eede49df();
    function_14b2c542();
}

// Namespace namespace_bedc6a60
// Params 0, eflags: 0x0
// Checksum 0x7e3b74ac, Offset: 0x5690
// Size: 0x1a
function function_fea402e8() {
    level waittill(#"hash_a2d108ca");
    level namespace_391e4301::function_e950228a(0);
}

// Namespace namespace_bedc6a60
// Params 1, eflags: 0x0
// Checksum 0x2906ad47, Offset: 0x56b8
// Size: 0xcb
function function_9c5046ad(a_ents) {
    var_10ec3c1e = struct::get_array("station_fight_glass_pulse", "targetname");
    wait 1.4;
    foreach (s in var_10ec3c1e) {
        glassradiusdamage(s.origin, s.radius, 500, 400);
        wait randomfloatrange(0.5, 0.75);
    }
}

// Namespace namespace_bedc6a60
// Params 0, eflags: 0x0
// Checksum 0x9781ac5a, Offset: 0x5790
// Size: 0x1ea
function function_cb0ba609() {
    spawner::add_spawn_function_group("balcony_bash_robot", "targetname", &ai::set_ignoreme, 1);
    scene::add_scene_func("cin_ram_03_03_defend_vign_balconybash", &function_1a2278be, "init");
    scene::add_scene_func("cin_ram_03_01_defend_vign_shrapnelpinned_01", &function_896cfa4c, "init");
    scene::add_scene_func("cin_ram_03_01_defend_vign_shrapnelpinned_03", &function_896cfa4c, "init");
    level scene::init("cin_ram_03_03_defend_vign_balconybash");
    util::wait_network_frame();
    level scene::init("cin_ram_03_03_defend_vign_debriscover_aligned");
    level thread function_4ebb88f6();
    level scene::init("cin_ram_03_01_defend_vign_shrapnelpinned_01");
    util::wait_network_frame();
    level scene::init("cin_ram_03_01_defend_vign_shrapnelpinned_03");
    level thread scene::play("cin_gen_deathpose_m_floor_shrapnel01");
    util::wait_network_frame();
    level thread scene::play("cin_gen_deathpose_m_floor_shrapnel02");
    util::wait_network_frame();
    level thread scene::play("cin_gen_deathpose_m_floor_shrapnel03");
    level thread function_8eaad758();
    level waittill(#"hash_d758e82");
    level thread scene::play("cin_ram_03_03_defend_vign_debriscover_aligned");
}

// Namespace namespace_bedc6a60
// Params 0, eflags: 0x0
// Checksum 0x3f3cb466, Offset: 0x5988
// Size: 0xb2
function function_8eaad758() {
    level endon(#"station_fight_completed");
    var_bfdab3ed = spawner::simple_spawn_single("shrapnel_guy");
    util::magic_bullet_shield(var_bfdab3ed);
    var_bfdab3ed ai::set_ignoreme(1);
    trigger::wait_till("trig_shrapnel_death_scene");
    spawner::simple_spawn_single("shrapnel_raps", &function_77c1726a);
    util::stop_magic_bullet_shield(var_bfdab3ed);
    scene::play("cin_ram_03_01_defend_vign_shrapnelpinned_04", var_bfdab3ed);
}

// Namespace namespace_bedc6a60
// Params 0, eflags: 0x0
// Checksum 0xec7779e3, Offset: 0x5a48
// Size: 0xaa
function function_77c1726a() {
    assert(isdefined(self.target), "<dev string:xb5>");
    v_goal = struct::get(self.target, "targetname").origin;
    self ai::set_ignoreall(1);
    self ai::set_ignoreme(1);
    self setvehgoalpos(v_goal, 1, 1);
    level waittill(#"hash_56447163");
    self raps::detonate();
}

// Namespace namespace_bedc6a60
// Params 2, eflags: 0x0
// Checksum 0xc93b0c11, Offset: 0x5b00
// Size: 0x42
function function_6727bc7f(s_obj, var_93cb1c05) {
    self function_1bac4fcc(s_obj, var_93cb1c05);
    if (isdefined(self)) {
        self oed::function_14ec2d71();
    }
}

// Namespace namespace_bedc6a60
// Params 2, eflags: 0x0
// Checksum 0x552656fa, Offset: 0x5b50
// Size: 0x85
function function_1bac4fcc(s_obj, var_93cb1c05) {
    level endon(#"station_fight_completed");
    self endon(#"death");
    while (isdefined(self)) {
        e_player = var_93cb1c05 waittill(#"trigger");
        while (isdefined(var_93cb1c05) && isalive(e_player) && e_player istouching(var_93cb1c05)) {
            wait 0.1;
        }
    }
}

// Namespace namespace_bedc6a60
// Params 0, eflags: 0x0
// Checksum 0x4d114c89, Offset: 0x5be0
// Size: 0x283
function function_a353c3d9() {
    a_str_scenes = [];
    if (!isdefined(a_str_scenes)) {
        a_str_scenes = [];
    } else if (!isarray(a_str_scenes)) {
        a_str_scenes = array(a_str_scenes);
    }
    a_str_scenes[a_str_scenes.size] = "cin_ram_03_02_defend_1st_pullbody";
    if (!isdefined(a_str_scenes)) {
        a_str_scenes = [];
    } else if (!isarray(a_str_scenes)) {
        a_str_scenes = array(a_str_scenes);
    }
    a_str_scenes[a_str_scenes.size] = "cin_ram_02_05_interview_vign_nassersitting";
    if (!isdefined(a_str_scenes)) {
        a_str_scenes = [];
    } else if (!isarray(a_str_scenes)) {
        a_str_scenes = array(a_str_scenes);
    }
    a_str_scenes[a_str_scenes.size] = "cin_ram_03_03_defend_vign_balconybash";
    if (!isdefined(a_str_scenes)) {
        a_str_scenes = [];
    } else if (!isarray(a_str_scenes)) {
        a_str_scenes = array(a_str_scenes);
    }
    a_str_scenes[a_str_scenes.size] = "cin_ram_03_03_defend_vign_debriscover_aligned";
    if (!isdefined(a_str_scenes)) {
        a_str_scenes = [];
    } else if (!isarray(a_str_scenes)) {
        a_str_scenes = array(a_str_scenes);
    }
    a_str_scenes[a_str_scenes.size] = "cin_ram_03_02_defend_vign_last_stand_death_guy01";
    if (!isdefined(a_str_scenes)) {
        a_str_scenes = [];
    } else if (!isarray(a_str_scenes)) {
        a_str_scenes = array(a_str_scenes);
    }
    a_str_scenes[a_str_scenes.size] = "cin_ram_03_02_defend_vign_last_stand_death_guy02";
    if (!isdefined(a_str_scenes)) {
        a_str_scenes = [];
    } else if (!isarray(a_str_scenes)) {
        a_str_scenes = array(a_str_scenes);
    }
    a_str_scenes[a_str_scenes.size] = "cin_ram_03_02_defend_vign_last_stand_death_guy03";
    foreach (str_scene in a_str_scenes) {
        if (level scene::is_active(str_scene)) {
            level thread scene::stop(str_scene, 1);
            wait 0.1;
        }
    }
}

// Namespace namespace_bedc6a60
// Params 0, eflags: 0x0
// Checksum 0x836189b2, Offset: 0x5e70
// Size: 0x72
function function_6327cae3() {
    var_b8f9a884 = getent("station_fight_turret_respawn", "targetname");
    if (isdefined(var_b8f9a884)) {
        var_b8f9a884.delete_on_death = 1;
        var_b8f9a884 notify(#"death");
        if (!isalive(var_b8f9a884)) {
            var_b8f9a884 delete();
        }
    }
}

// Namespace namespace_bedc6a60
// Params 0, eflags: 0x0
// Checksum 0x407d61cc, Offset: 0x5ef0
// Size: 0xa3
function function_2cae968() {
    var_64e85e6d = getaiteamarray("axis");
    foreach (ai in var_64e85e6d) {
        if (!isvehicle(ai)) {
            ai ai::set_behavior_attribute("move_mode", "rusher");
        }
    }
}

// Namespace namespace_bedc6a60
// Params 1, eflags: 0x0
// Checksum 0xd807071f, Offset: 0x5fa0
// Size: 0x14a
function function_f21c9162(str_state) {
    if (!isdefined(str_state)) {
        str_state = "";
    }
    hidemiscmodels("station_clutter" + str_state);
    var_522666ed = getentarray("station_clutter" + str_state, "targetname");
    var_d4a391c5 = getentarray("station_clutter" + str_state, "script_noteworthy");
    var_c160029e = getentarray("station_clutter_collision" + str_state, "targetname");
    var_9adf475b = getentarray("station_stairs" + str_state, "targetname");
    var_522666ed namespace_391e4301::hide_ents(1);
    var_522666ed namespace_391e4301::function_41f6f501();
    var_d4a391c5 namespace_391e4301::hide_ents(1);
    var_c160029e namespace_391e4301::function_41f6f501();
    var_9adf475b namespace_391e4301::hide_ents();
}

// Namespace namespace_bedc6a60
// Params 1, eflags: 0x0
// Checksum 0x9576f83c, Offset: 0x60f8
// Size: 0x17a
function function_c5b9bd41(str_state) {
    if (!isdefined(str_state)) {
        str_state = "";
    }
    showmiscmodels("station_clutter" + str_state);
    var_522666ed = getentarray("station_clutter" + str_state, "targetname");
    var_d4a391c5 = getentarray("station_clutter" + str_state, "script_noteworthy");
    var_c160029e = getentarray("station_clutter_collision" + str_state, "targetname");
    var_9adf475b = getentarray("station_stairs" + str_state, "targetname");
    var_522666ed namespace_391e4301::make_solid();
    var_c160029e namespace_391e4301::make_solid();
    var_522666ed namespace_391e4301::show_ents(1);
    var_d4a391c5 namespace_391e4301::show_ents(1);
    var_9adf475b namespace_391e4301::show_ents();
    var_27da165 = struct::get_array("station_clutter" + str_state, "targetname");
    var_27da165 namespace_391e4301::function_c3458a6();
}

// Namespace namespace_bedc6a60
// Params 2, eflags: 0x0
// Checksum 0x7a857658, Offset: 0x6280
// Size: 0x1d2
function function_eede49df(str_state, var_f5b4e706) {
    if (!isdefined(str_state)) {
        str_state = "";
    }
    if (!isdefined(var_f5b4e706)) {
        var_f5b4e706 = 0;
    }
    var_522666ed = getentarray("station_clutter" + str_state, "targetname");
    var_c160029e = getentarray("station_clutter_collision" + str_state, "targetname");
    var_4095c0be = getentarray("station_clutter_nocol" + str_state, "targetname");
    var_9adf475b = getentarray("station_stairs" + str_state, "targetname");
    hidemiscmodels("station_clutter" + str_state);
    if (var_f5b4e706) {
        n_count = 0;
        foreach (e_prop in var_522666ed) {
            e_prop connectpaths();
            n_count++;
            if (n_count > 1) {
                wait 0.05;
                n_count = 0;
            }
        }
    }
    array::delete_all(var_522666ed);
    array::delete_all(var_c160029e);
    array::delete_all(var_4095c0be);
    array::delete_all(var_9adf475b);
}

// Namespace namespace_bedc6a60
// Params 0, eflags: 0x0
// Checksum 0xaafc35a5, Offset: 0x6460
// Size: 0x3a
function function_f7abd273() {
    var_6a205876 = getentarray("station_defend_after", "script_noteworthy");
    var_6a205876 namespace_391e4301::hide_ents();
}

// Namespace namespace_bedc6a60
// Params 0, eflags: 0x0
// Checksum 0x762789b9, Offset: 0x64a8
// Size: 0x123
function function_e5ed2910() {
    var_dbe7a735 = getentarray("station_defend_after", "script_noteworthy");
    var_dbe7a735 namespace_391e4301::show_ents(1);
    util::wait_network_frame();
    var_c1633987 = getentarray("station_defend_before", "script_noteworthy");
    array::delete_all(var_c1633987);
    util::wait_network_frame();
    var_5cd1a106 = getentarray("droppod_hole", "targetname");
    foreach (var_bb2701f in var_5cd1a106) {
        var_bb2701f delete();
    }
}

// Namespace namespace_bedc6a60
// Params 0, eflags: 0x0
// Checksum 0x4bb05efd, Offset: 0x65d8
// Size: 0xa2
function function_c01d9b2() {
    wait 2;
    level.var_2fd26037 dialog::say("hend_all_clear_that_s_t_0");
    level dialog::function_13b3b16a("plyr_kane_patch_us_into_0", 1);
    level dialog::remote("ecmd_ramses_1_1_priority_0");
    level dialog::remote("ecmd_request_all_emergenc_0");
    level.var_9db406db dialog::say("khal_copy_that_but_we_l_0");
    level dialog::remote("ecmd_confirmed_vtol_sup_0");
}

// Namespace namespace_bedc6a60
// Params 0, eflags: 0x0
// Checksum 0xda72a3c8, Offset: 0x6688
// Size: 0xd2
function function_1d0e7c11() {
    wait 5;
    a_ai = getaiteamarray("allies");
    arrayremovevalue(a_ai, level.var_2fd26037, 0);
    arrayremovevalue(a_ai, level.var_9db406db, 0);
    a_ai = arraysortclosest(a_ai, level.players[0].origin);
    if (isdefined(a_ai[0])) {
        if (math::cointoss()) {
            a_ai[0] thread dialog::say("esl3_how_did_they_beat_ou_0");
            return;
        }
        a_ai[0] thread dialog::say("esl4_impossible_how_did_0");
    }
}

// Namespace namespace_bedc6a60
// Params 2, eflags: 0x0
// Checksum 0xe2d4efc9, Offset: 0x6768
// Size: 0x52
function function_f27ea617(str_objective, var_74cd64bc) {
    function_eede49df();
    function_c5b9bd41("_combat");
    init("defend_ramses_station", var_74cd64bc);
}

// Namespace namespace_bedc6a60
// Params 0, eflags: 0x0
// Checksum 0xe9c07cd6, Offset: 0x67c8
// Size: 0x2
function function_93364e1b() {
    
}

