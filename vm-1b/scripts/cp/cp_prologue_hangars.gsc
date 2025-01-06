#using scripts/codescripts/struct;
#using scripts/cp/_dialog;
#using scripts/cp/_load;
#using scripts/cp/_objectives;
#using scripts/cp/_oed;
#using scripts/cp/_skipto;
#using scripts/cp/_spawn_manager;
#using scripts/cp/_util;
#using scripts/cp/cp_mi_eth_prologue_accolades;
#using scripts/cp/cp_mi_eth_prologue_fx;
#using scripts/cp/cp_mi_eth_prologue_sound;
#using scripts/cp/cp_prologue_apc;
#using scripts/cp/cp_prologue_bridge;
#using scripts/cp/cp_prologue_cyber_soldiers;
#using scripts/cp/cp_prologue_util;
#using scripts/cp/cybercom/_cybercom;
#using scripts/cp/cybercom/_cybercom_util;
#using scripts/cp/gametypes/_battlechatter;
#using scripts/cp/gametypes/_save;
#using scripts/shared/ai_shared;
#using scripts/shared/array_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/colors_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/trigger_shared;
#using scripts/shared/turret_shared;
#using scripts/shared/util_shared;
#using scripts/shared/vehicle_ai_shared;
#using scripts/shared/vehicle_shared;
#using scripts/shared/vehicleriders_shared;

#namespace Hangar;

// Namespace Hangar
// Params 0, eflags: 0x0
// Checksum 0x7cd3d674, Offset: 0x1af0
// Size: 0x92
function function_83921c71() {
    function_ce233fb8();
    function_5a60627b();
    spawner::add_spawn_function_group("hangar01_balcony_ai", "script_noteworthy", &function_33ec51ea);
    spawner::add_spawn_function_group("catwalk_stair_enemy", "targetname", &function_78f61bf2);
    level thread function_10d2e714();
}

// Namespace Hangar
// Params 0, eflags: 0x0
// Checksum 0x79154e62, Offset: 0x1b90
// Size: 0x7a
function function_ce233fb8() {
    flag::init("alert_plane_hangar_enemies");
    level flag::init("plane_hangar_hendricks_ready_flag");
    level flag::init("plane_hangar_khalil_ready_flag");
    level flag::init("plane_hangar_minister_ready_flag");
    level flag::init("fireflies_used");
}

// Namespace Hangar
// Params 0, eflags: 0x0
// Checksum 0xebe75a6, Offset: 0x1c18
// Size: 0x262
function function_5a60627b() {
    level.var_92d245e2 ai::set_ignoreall(1);
    level.var_92d245e2 ai::set_ignoreme(1);
    level.var_92d245e2.goalradius = 16;
    level.var_f58c9f31 ai::set_ignoreall(1);
    level.var_f58c9f31 ai::set_ignoreme(1);
    level.var_f58c9f31.goalradius = 16;
    level.var_f58c9f31.allowpain = 0;
    level.var_f58c9f31 colors::set_force_color("c");
    level.var_7f246cd7 ai::set_ignoreall(1);
    level.var_7f246cd7 ai::set_ignoreme(1);
    level.var_7f246cd7.goalradius = 16;
    level.var_7f246cd7.allowpain = 0;
    level.var_7f246cd7 colors::set_force_color("o");
    level.var_5d4087a6 ai::set_ignoreall(1);
    level.var_5d4087a6 ai::set_ignoreme(1);
    level.var_5d4087a6.goalradius = 16;
    level.var_5d4087a6.allowpain = 0;
    level.var_5d4087a6 colors::set_force_color("p");
    level.var_2fd26037 ai::set_ignoreall(1);
    level.var_2fd26037 ai::set_ignoreme(1);
    level.var_2fd26037.goalradius = 16;
    level.var_2fd26037.allowpain = 0;
    level.var_9db406db ai::set_ignoreall(1);
    level.var_9db406db ai::set_ignoreme(1);
    level.var_9db406db.goalradius = 16;
    level.var_4d5a4697 ai::set_ignoreall(1);
    level.var_4d5a4697 ai::set_ignoreme(1);
    level.var_4d5a4697.goalradius = 16;
}

// Namespace Hangar
// Params 0, eflags: 0x0
// Checksum 0x12a89585, Offset: 0x1e88
// Size: 0x1aa
function function_10d2e714() {
    level thread function_df5e6d8a();
    level thread hangar_vtol_flyby();
    level thread scene::init("p7_fxanim_cp_prologue_hangar_window_rip_bundle");
    level thread namespace_21b2c1f2::function_46333a8a();
    level util::clientnotify("sndStartFakeBattle");
    level thread function_6ad5d018();
    level thread function_e92ad8ae();
    level thread function_4cf04b95();
    level thread function_30b7d0f9();
    level thread function_b439650f();
    level thread function_644150a();
    vehicle::add_spawn_function("vtol_collapse_apc_initial", &function_75381a71);
    level.var_fac57550 = vehicle::simple_spawn_single("vtol_collapse_apc_initial");
    wait 0.15;
    level.var_2fd26037 thread function_d418516(level.var_fac57550);
    level.var_9db406db thread function_d418516(level.var_fac57550);
    level.var_7f246cd7 thread function_e3521c43();
    function_e966c1c0(0);
    level flag::wait_till("plane_hangar_complete");
    skipto::function_be8adfb8("skipto_hangar");
}

// Namespace Hangar
// Params 0, eflags: 0x0
// Checksum 0xd9fb3f17, Offset: 0x2040
// Size: 0x52
function function_b439650f() {
    level endon(#"hash_71456dc2");
    wait 60;
    level flag::set("move_plane_hangar_vehicles");
    level flag::set("move_plane_hangar_enemies");
    wait 60;
    level flag::set("move_catwalk_enemies");
}

// Namespace Hangar
// Params 0, eflags: 0x0
// Checksum 0xac2e0d96, Offset: 0x20a0
// Size: 0xcb
function function_75381a71() {
    wait 1;
    foreach (ai_rider in self.riders) {
        ai_rider thread util::magic_bullet_shield();
    }
    level waittill(#"hash_7452e7a8");
    foreach (ai_rider in self.riders) {
        ai_rider thread util::stop_magic_bullet_shield();
    }
}

// Namespace Hangar
// Params 0, eflags: 0x0
// Checksum 0xbd924ec0, Offset: 0x2178
// Size: 0x3a
function hangar_vtol_flyby() {
    self endon(#"hash_d11bfa2f");
    level flag::wait_till("hangar_vtol_flyby");
    level thread cp_prologue_util::function_42da021e("vh_vtol_flyby", 119, 100);
}

// Namespace Hangar
// Params 0, eflags: 0x0
// Checksum 0x9b23e141, Offset: 0x21c0
// Size: 0x152
function function_df5e6d8a() {
    var_9de10fe3 = getnode("node_cyber_diaz", "targetname");
    level.var_7f246cd7 setgoalnode(var_9de10fe3);
    var_9de10fe3 = getnode("node_cyber_hendricks", "targetname");
    level.var_2fd26037 setgoalnode(var_9de10fe3);
    var_9de10fe3 = getnode("node_cyber_khalil", "targetname");
    level.var_9db406db setgoalnode(var_9de10fe3);
    wait 1;
    var_9de10fe3 = getnode("node_cyber_minister", "targetname");
    level.var_4d5a4697 setgoalnode(var_9de10fe3);
    level.var_4d5a4697 waittill(#"goal");
    level.var_9db406db ai::set_behavior_attribute("vignette_mode", "off");
    level.var_4d5a4697 ai::set_behavior_attribute("vignette_mode", "off");
}

// Namespace Hangar
// Params 0, eflags: 0x0
// Checksum 0xf3075300, Offset: 0x2320
// Size: 0x302
function function_4cf04b95() {
    spawner::add_spawn_function_group("aig_plane_hangar_enemies_main", "script_aigroup", &cp_prologue_util::remove_grenades);
    level flag::wait_till("spawn_plane_hangar_enemies");
    spawner::simple_spawn("catwalk_window_enemies", &function_55a0215c);
    spawner::simple_spawn("shooter_enemy", &function_c9e0c14b);
    var_a2da570f = spawner::simple_spawn("sp_plane_hangar_initial_right", &function_4514b4cf);
    var_c5fb606f = getent("plane_hangar_goal_vol_right_1", "targetname");
    var_53f3f134 = getent("plane_hangar_goal_vol_right_2", "targetname");
    var_79f66b9d = getent("plane_hangar_goal_vol_rear_2", "targetname");
    array::thread_all(var_a2da570f, &function_fb6ce428, var_c5fb606f, var_53f3f134, var_79f66b9d);
    if (level.players.size > 2) {
        var_e39e4320 = spawner::simple_spawn("sp_plane_hangar_initial_left", &function_4514b4cf);
        var_48c65824 = getent("plane_hangar_goal_vol_left_1", "targetname");
        var_bacdc75f = getent("plane_hangar_goal_vol_left_2", "targetname");
        var_94cb4cf6 = getent("plane_hangar_goal_vol_rear_2", "targetname");
        array::thread_all(var_e39e4320, &function_fb6ce428, var_48c65824, var_bacdc75f, var_94cb4cf6);
    }
    level thread function_8f45c05e();
    array::thread_all(level.players, &function_2af9c6c4);
    spawner::add_spawn_function_group("catwalk_battle_enemy_wave2", "targetname", &function_147616e2);
    level flag::wait_till("alert_plane_hangar_enemies");
    savegame::checkpoint_save();
    spawn_manager::enable("catwalk_enemy_wave2");
    level thread function_2810938e();
}

// Namespace Hangar
// Params 0, eflags: 0x0
// Checksum 0x84bf64b5, Offset: 0x2630
// Size: 0xaa
function function_4514b4cf() {
    self endon(#"death");
    self.goalradius = 16;
    self setgoal(self.origin, 1);
    self setignoreent(level.var_7f246cd7, 1);
    level.var_7f246cd7 setignoreent(self, 1);
    level flag::wait_till("plane_hangar_enemies_fallback1");
    wait 5;
    self setignoreent(level.var_7f246cd7, 0);
    level.var_7f246cd7 setignoreent(self, 0);
}

// Namespace Hangar
// Params 0, eflags: 0x0
// Checksum 0x88343657, Offset: 0x26e8
// Size: 0x22
function function_8f45c05e() {
    level waittill(#"window_broken");
    level flag::set("alert_plane_hangar_enemies");
}

// Namespace Hangar
// Params 0, eflags: 0x0
// Checksum 0x1f55f9d7, Offset: 0x2718
// Size: 0x22
function function_2af9c6c4() {
    self waittill(#"weapon_fired");
    level flag::set("alert_plane_hangar_enemies");
}

// Namespace Hangar
// Params 3, eflags: 0x0
// Checksum 0xafaaec6e, Offset: 0x2748
// Size: 0x122
function function_fb6ce428(var_3cee21ba, var_16eba751, var_f0e92ce8) {
    self endon(#"death");
    self ai::set_ignoreall(1);
    self setgoal(self.origin);
    level flag::wait_till("alert_plane_hangar_enemies");
    self ai::set_ignoreall(0);
    self setgoal(var_3cee21ba);
    level flag::wait_till("plane_hangar_enemies_fallback1");
    self ai::set_ignoreall(1);
    self setgoal(var_16eba751);
    self waittill(#"goal");
    self ai::set_ignoreall(0);
    level flag::wait_till("plane_hangar_enemies_fallback2");
    self ai::set_ignoreall(1);
    self setgoal(var_f0e92ce8);
    self waittill(#"goal");
    self ai::set_ignoreall(0);
}

// Namespace Hangar
// Params 0, eflags: 0x0
// Checksum 0xbd271afc, Offset: 0x2878
// Size: 0x9a
function function_147616e2() {
    self endon(#"death");
    var_5136eb95 = getent("plane_hangar_goal_vol_rear_1", "targetname");
    var_773965fe = getent("plane_hangar_goal_vol_rear_2", "targetname");
    self setgoal(var_5136eb95);
    level flag::wait_till("plane_hangar_enemies_fallback2");
    self setgoal(var_773965fe);
}

// Namespace Hangar
// Params 0, eflags: 0x0
// Checksum 0xe16e204, Offset: 0x2920
// Size: 0x162
function function_c9e0c14b() {
    self endon(#"death");
    self ai::set_ignoreall(1);
    self setgoal(self.origin);
    self.goalradius = 16;
    level flag::wait_till("alert_plane_hangar_enemies");
    self ai::set_ignoreall(0);
    var_bd827604 = struct::get("plane_hangar_window", "targetname");
    var_6c9f55e = util::get_closest_player(var_bd827604.origin, "allies");
    self ai::shoot_at_target("normal", var_6c9f55e, undefined, 5);
    var_c5fb606f = getent("plane_hangar_goal_vol_right_1", "targetname");
    var_53f3f134 = getent("plane_hangar_goal_vol_right_2", "targetname");
    var_79f66b9d = getent("plane_hangar_goal_vol_right_3", "targetname");
    self function_fb6ce428(var_c5fb606f, var_53f3f134, var_79f66b9d);
}

// Namespace Hangar
// Params 0, eflags: 0x0
// Checksum 0x32e3f7ff, Offset: 0x2a90
// Size: 0xa2
function function_55a0215c() {
    self endon(#"death");
    self ai::set_ignoreall(1);
    self setgoal(self.origin, 1);
    level flag::wait_till("move_catwalk_enemies");
    n_goal = getnode(self.script_noteworthy, "targetname");
    self setgoal(n_goal, 1);
    self waittill(#"goal");
    self ai::set_ignoreall(0);
}

// Namespace Hangar
// Params 3, eflags: 0x0
// Checksum 0x4b6cdfd6, Offset: 0x2b40
// Size: 0x82
function function_4ee77dbb(vehiclename, name, targets) {
    ai_rider = vehiclename vehicle::function_ad4ec07a(name);
    if (isdefined(ai_rider)) {
        ai_rider thread vehicle::get_out();
        ai_rider thread function_4514b4cf();
        if (targets.size == 3) {
            ai_rider thread function_fb6ce428(targets[0], targets[1], targets[2]);
        }
    }
}

// Namespace Hangar
// Params 0, eflags: 0x0
// Checksum 0x1543c225, Offset: 0x2bd0
// Size: 0x29a
function function_30b7d0f9() {
    var_c2777dd9 = "p7_fxanim_cp_prologue_hangar_doors_03_bundle";
    level thread scene::init(var_c2777dd9);
    level flag::wait_till("spawn_plane_hangar_enemies");
    var_edd777e6 = vehicle::simple_spawn_single("plane_hangar_jeep");
    var_a9993ca4 = vehicle::simple_spawn_single("plane_hangar_flatbed");
    var_edd777e6 vehicle::get_on_path(var_edd777e6.target);
    var_a9993ca4 vehicle::get_on_path(var_a9993ca4.target);
    level flag::wait_till("move_plane_hangar_vehicles");
    var_edd777e6 thread vehicle::go_path();
    var_edd777e6 thread function_28d41b1d();
    var_edd777e6 playsound("evt_hangar_jeep_driveaway");
    wait 1;
    var_280d5f68 = getent("plane_hangar_gate_l", "targetname");
    var_3c301126 = getent("plane_hangar_gate_r", "targetname");
    var_9c7511b4 = struct::get("plane_hangar_gate_move_pos_l", "targetname");
    var_205c499a = struct::get("plane_hangar_gate_move_pos_r", "targetname");
    level thread function_a8cd091b(0, var_280d5f68, var_3c301126, var_9c7511b4, var_205c499a, var_c2777dd9, "umbra_gate_hangar_03");
    var_a9993ca4 thread vehicle::go_path();
    var_a9993ca4 playsound("evt_hangar_truck_drivestop");
    var_a9993ca4 waittill(#"reached_end_node");
    var_9b59c867[0] = getent("plane_hangar_goal_vol_right_1", "targetname");
    var_9b59c867[1] = getent("plane_hangar_goal_vol_right_2", "targetname");
    var_9b59c867[2] = getent("plane_hangar_goal_vol_right_3", "targetname");
    function_4ee77dbb(var_a9993ca4, "driver", var_9b59c867);
    function_4ee77dbb(var_a9993ca4, "passenger1", var_9b59c867);
}

// Namespace Hangar
// Params 0, eflags: 0x0
// Checksum 0xcacf2a42, Offset: 0x2e78
// Size: 0xa2
function function_28d41b1d() {
    self endon(#"death");
    self waittill(#"reached_end_node");
    var_44762fa4 = self vehicle::function_ad4ec07a("driver");
    ai_rider = self vehicle::function_ad4ec07a("passenger1");
    var_44762fa4 delete();
    ai_rider delete();
    self.delete_on_death = 1;
    self notify(#"death");
    if (!isalive(self)) {
        self delete();
    }
}

// Namespace Hangar
// Params 0, eflags: 0x0
// Checksum 0xac9974e9, Offset: 0x2f28
// Size: 0x182
function function_2810938e() {
    self endon(#"hash_d11bfa2f");
    level flag::wait_till("alert_plane_hangar_enemies");
    level thread function_ed437e33();
    level flag::wait_till("plane_hangar_enemies_fallback3");
    spawn_manager::kill("catwalk_enemy_wave2");
    var_bfff0f24 = getentarray("plane_hangar_enemies", "script_noteworthy", 1);
    var_1d61ec5e = struct::get("plane_to_vtol_fallback_origin", "targetname");
    var_f6f0207c = array::get_all_closest(var_1d61ec5e.origin, var_bfff0f24, undefined, 10);
    level thread function_19352a82(var_f6f0207c);
    var_46b9d820 = getent("trig_vtol_goal_vol_rear", "targetname");
    for (i = 0; i < var_f6f0207c.size; i++) {
        var_f6f0207c[i] setgoal(var_46b9d820);
    }
    function_e966c1c0(1);
    wait 5;
    trigger::use("plane_hangar_empty_color_allies", "targetname");
}

// Namespace Hangar
// Params 0, eflags: 0x0
// Checksum 0xa5a8af85, Offset: 0x30b8
// Size: 0x3a
function function_ed437e33() {
    spawner::waittill_ai_group_ai_count("aig_plane_hangar_enemies_main", 5);
    level flag::set("plane_hangar_enemies_fallback3");
}

// Namespace Hangar
// Params 0, eflags: 0x0
// Checksum 0xd07ae41f, Offset: 0x3100
// Size: 0x2aa
function function_e92ad8ae() {
    level.var_2fd26037 colors::enable();
    trigger::use("hangar_move_friendlies_1", "targetname");
    level.var_2fd26037 colors::disable();
    level.var_9db406db colors::disable();
    level.var_4d5a4697 colors::disable();
    level flag::wait_till("trig_hangar01_enemies");
    wait 4.5;
    level.var_2fd26037 thread function_3683e3dd("cin_pro_10_01_hangar_vign_traverse_hendricks_start_idle");
    wait 1;
    level.var_9db406db thread function_7ae90dbb("cin_pro_10_01_hangar_vign_traverse_khalil_start_idle");
    wait 2.5;
    level.var_4d5a4697 thread function_7a87693b("cin_pro_10_01_hangar_vign_traverse_minister_start_idle");
    level thread function_bae363ed();
    level flag::wait_till("pallas_jump_inside_catwalk");
    if (level.players.size == 1) {
        level thread function_e6515192();
    }
    function_cf13969b();
    level waittill(#"hash_fdcdf647");
    level.var_2fd26037 colors::enable();
    trigger::use("t_hangar02_move_allies", undefined, undefined, 0);
    level.var_2fd26037 ai::set_ignoreall(0);
    level.var_2fd26037 ai::set_ignoreme(0);
    level thread scene::play("cin_pro_10_01_hangar_vign_traverse_khalil_end_idle");
    level thread scene::play("cin_pro_10_01_hangar_vign_traverse_minister_end_idle");
    wait 3;
    level thread scene::stop("cin_pro_10_01_hangar_vign_traverse_khalil_end_idle");
    level thread scene::stop("cin_pro_10_01_hangar_vign_traverse_minister_end_idle");
    level.var_9db406db colors::enable();
    level.var_4d5a4697 util::delay(2, undefined, &colors::enable);
    level.var_9db406db ai::set_ignoreall(0);
    level.var_9db406db ai::set_ignoreme(0);
}

// Namespace Hangar
// Params 1, eflags: 0x0
// Checksum 0xbbdd6aa7, Offset: 0x33b8
// Size: 0xb2
function function_3683e3dd(var_c2777dd9) {
    self ai::set_behavior_attribute("disablearrivals", 1);
    var_9d01e85c = getnode("hendricks_traversal_goal_1", "targetname");
    self setgoal(var_9d01e85c, 1);
    self waittill(#"goal");
    self ai::set_behavior_attribute("disablearrivals", 0);
    level thread scene::play(var_c2777dd9);
    level waittill(#"hash_9aebec3d");
    level flag::set("plane_hangar_hendricks_ready_flag");
}

// Namespace Hangar
// Params 1, eflags: 0x0
// Checksum 0x812051d6, Offset: 0x3478
// Size: 0x142
function function_7ae90dbb(var_c2777dd9) {
    self ai::set_behavior_attribute("disablearrivals", 1);
    var_9d01e85c = getnode("khalil_traversal_goal_1", "targetname");
    self setgoal(var_9d01e85c, 1);
    self waittill(#"goal");
    var_f095797 = getnode("khalil_traversal_goal_2", "targetname");
    self setgoal(var_f095797, 1);
    self waittill(#"goal");
    var_e906dd2e = getnode("khalil_traversal_goal_3", "targetname");
    self setgoal(var_e906dd2e, 1);
    self waittill(#"goal");
    self ai::set_behavior_attribute("disablearrivals", 0);
    level thread scene::play(var_c2777dd9);
    level waittill(#"hash_bdaa4f6d");
    level flag::set("plane_hangar_khalil_ready_flag");
}

// Namespace Hangar
// Params 1, eflags: 0x0
// Checksum 0xa3e0292c, Offset: 0x35c8
// Size: 0x142
function function_7a87693b(var_c2777dd9) {
    self ai::set_behavior_attribute("disablearrivals", 1);
    var_9d01e85c = getnode("minister_traversal_goal_1", "targetname");
    self setgoal(var_9d01e85c, 1);
    self waittill(#"goal");
    var_f095797 = getnode("minister_traversal_goal_2", "targetname");
    self setgoal(var_f095797, 1);
    self waittill(#"goal");
    var_e906dd2e = getnode("minister_traversal_goal_3", "targetname");
    self setgoal(var_e906dd2e, 1);
    self waittill(#"goal");
    self ai::set_behavior_attribute("disablearrivals", 0);
    level thread scene::play(var_c2777dd9);
    level waittill(#"hash_b0db1711");
    level flag::set("plane_hangar_minister_ready_flag");
}

// Namespace Hangar
// Params 0, eflags: 0x0
// Checksum 0xbba2babe, Offset: 0x3718
// Size: 0x63
function function_cf13969b() {
    level endon(#"hash_e4850787");
    level flag::wait_till_all(array("plane_hangar_hendricks_ready_flag", "plane_hangar_khalil_ready_flag", "plane_hangar_minister_ready_flag"));
    level scene::play("cin_pro_10_01_hangar_vign_traverse_hendricks_khalil_minister_move_01");
    level notify(#"hash_f38af553");
}

// Namespace Hangar
// Params 0, eflags: 0x0
// Checksum 0xaf4c4e91, Offset: 0x3788
// Size: 0x112
function function_e6515192() {
    level endon(#"hash_f38af553");
    level flag::wait_till_all(array("plane_hangar_hendricks_ready_flag", "plane_hangar_khalil_ready_flag", "plane_hangar_minister_ready_flag"));
    level flag::wait_till("expedite_hangar_entrance");
    s_door_loc = struct::get("s_hangar_door", "targetname");
    array::thread_all(level.players, &util::waittill_player_not_looking_at, s_door_loc.origin);
    level notify(#"hash_e4850787");
    if (!scene::is_playing("cin_pro_10_01_hangar_vign_traverse_hendricks_khalil_minister_move_01")) {
        level thread scene::skipto_end("cin_pro_10_01_hangar_vign_traverse_hendricks_khalil_minister_move_01", undefined, undefined, 0.65);
    }
    wait 0.1;
    level.var_2fd26037 stopanimscripted();
}

// Namespace Hangar
// Params 0, eflags: 0x0
// Checksum 0xa2ff3eac, Offset: 0x38a8
// Size: 0xea
function function_bae363ed() {
    level waittill(#"hash_e4850787");
    var_280d5f68 = getent("hangar02_door_left", "targetname");
    var_3c301126 = getent("hangar02_door_right", "targetname");
    var_1f6ed387 = getent("plane_hangar_side_door_left", "targetname");
    var_fcd5dfa1 = getent("plane_hangar_side_door_right", "targetname");
    var_280d5f68 moveto(var_1f6ed387.origin, 0.5);
    var_3c301126 moveto(var_fcd5dfa1.origin, 0.5);
}

// Namespace Hangar
// Params 0, eflags: 0x0
// Checksum 0x7e583ad7, Offset: 0x39a0
// Size: 0xea
function function_590acc37() {
    level flag::wait_till("trig_hangar01_enemies");
    var_8786c160 = getspawnerarray("hangar01_enemy", "script_aigroup");
    var_7b3a5649 = spawner::simple_spawn(var_8786c160);
    array::thread_all(var_7b3a5649, &function_211f2948);
    array::thread_all(var_7b3a5649, &function_b5a28004);
    level thread function_c218ce54();
    level scene::play("cin_pro_10_01_hanger_vign_sensory_overload_start");
    level thread objectives::breadcrumb("hangar_breadcrumb_2");
    level thread function_25e65862();
}

// Namespace Hangar
// Params 0, eflags: 0x0
// Checksum 0xf1e95704, Offset: 0x3a98
// Size: 0x42
function function_c218ce54() {
    level waittill(#"hash_736529ea");
    mdl_blocker = getent("stun_cin_blocker", "targetname");
    mdl_blocker delete();
}

// Namespace Hangar
// Params 0, eflags: 0x0
// Checksum 0xbb4f46b4, Offset: 0x3ae8
// Size: 0x22
function function_25e65862() {
    wait 3;
    level.var_7f246cd7 thread dialog::say("diaz_move_into_the_next_h_0");
}

// Namespace Hangar
// Params 0, eflags: 0x0
// Checksum 0x99cbb9e3, Offset: 0x3b18
// Size: 0x22
function function_b5a28004() {
    self endon(#"death");
    wait 30;
    self kill();
}

// Namespace Hangar
// Params 0, eflags: 0x0
// Checksum 0xb2f55794, Offset: 0x3b48
// Size: 0x9a
function function_211f2948() {
    self setcontents(8192);
    self.dontdropweapon = 1;
    self setmaxhealth(15);
    self ai::set_ignoreme(1);
    self ai::set_ignoreall(1);
    self thread function_fd0a6295();
    self cybercom::function_59965309("cybercom_fireflyswarm");
    self waittill(#"death");
    self startragdoll(1);
}

// Namespace Hangar
// Params 0, eflags: 0x0
// Checksum 0xce136083, Offset: 0x3bf0
// Size: 0x52
function function_fd0a6295() {
    self endon(#"death");
    self waittill(#"hash_b19658ba");
    self notify(#"bhtn_action_notify", "reactSensory");
    self playsound("gdt_sensory_feedback_start");
    self playloopsound("gdt_sensory_feedback_lp_upg");
}

// Namespace Hangar
// Params 0, eflags: 0x0
// Checksum 0x6019a2f4, Offset: 0x3c50
// Size: 0x52
function function_aaf033f6() {
    self endon(#"death");
    self waittill(#"reach_done");
    var_be53b69c = getnode("pallas_hangar_anim_start", "targetname");
    self setgoal(var_be53b69c, 1);
}

// Namespace Hangar
// Params 0, eflags: 0x0
// Checksum 0xd586a945, Offset: 0x3cb0
// Size: 0x72
function function_644150a() {
    sndent = spawn("script_origin", (7553, 1157, -49));
    sndent playloopsound("evt_sensory_dudes_walla", 2);
    level flag::wait_till("trig_hangar01_enemies");
    wait 3;
    sndent delete();
}

// Namespace Hangar
// Params 0, eflags: 0x0
// Checksum 0xceca7bd, Offset: 0x3d30
// Size: 0x2a2
function function_e3521c43() {
    self colors::disable();
    self thread function_aaf033f6();
    level.var_7f246cd7 function_590acc37();
    self ai::set_ignoreall(1);
    self ai::set_ignoreme(1);
    self ai::set_behavior_attribute("sprint", 1);
    level thread function_e0540704();
    level flag::wait_till("pallas_jump_inside_catwalk");
    level flag::set("spawn_plane_hangar_enemies");
    level notify(#"hash_28b81543");
    level thread function_507f685c();
    self colors::set_force_color("o");
    level thread function_d11463aa();
    level scene::play("cin_pro_10_01_hangar_vign_breakwindow");
    self ai::set_behavior_attribute("sprint", 0);
    level thread scene::play("cin_pro_10_04_hangar_vign_leap_new_run_across");
    n_node = getnode("pallas_temp_catwalk_end", "targetname");
    self setgoal(n_node, 1);
    self waittill(#"goal");
    self thread function_ee8e1349();
    wait 0.5;
    self ai::set_ignoreall(0);
    self ai::set_ignoreme(0);
    self setgoal(n_node, 1);
    level thread function_c8af325f();
    level flag::wait_till("pallas_jump_to_window");
    self ai::set_ignoreall(1);
    self ai::set_ignoreme(1);
    level thread scene::add_scene_func("cin_pro_10_04_hangar_vign_leap_new_wing2window", &function_84a7642b, "done");
    level notify(#"hash_35d2241b");
    level flag::wait_till("fireflies_used");
    self thread scene::play("cin_pro_10_04_hangar_vign_leap_new_wing2window");
    level waittill(#"hash_d4a94cc6");
    level clientfield::set("diaz_break_1", 2);
}

// Namespace Hangar
// Params 0, eflags: 0x0
// Checksum 0xd9c94a56, Offset: 0x3fe0
// Size: 0x62
function function_d11463aa() {
    level waittill(#"window_broken");
    level thread scene::play("p7_fxanim_cp_prologue_hangar_window_rip_bundle");
    level waittill(#"hash_cab72ab7");
    var_61ee9c31 = getent("hangar_glass_window", "targetname");
    var_61ee9c31 delete();
}

// Namespace Hangar
// Params 0, eflags: 0x0
// Checksum 0xd78bbac6, Offset: 0x4050
// Size: 0x142
function function_ee8e1349() {
    array::thread_all(level.players, &function_b81dfc22);
    level thread function_2d8450d7();
    level waittill(#"hash_35d2241b");
    level thread function_cc32afb9();
    a_targets = getentarray("catwalk_window_enemies_ai", "targetname");
    if (a_targets.size > 0) {
        self cybercom::function_d240e350("cybercom_fireflyswarm", a_targets);
    } else {
        var_78e3eaf1 = getentarray("plane_hangar_enemies", "script_noteworthy", 1);
        var_262dcd37 = struct::get("plane_to_vtol_fallback_origin", "targetname");
        var_e2ceaf11 = array::get_all_closest(var_262dcd37.origin, var_78e3eaf1, undefined, 3);
        self cybercom::function_d240e350("cybercom_fireflyswarm", var_e2ceaf11);
    }
    level flag::set("fireflies_used");
}

// Namespace Hangar
// Params 0, eflags: 0x0
// Checksum 0x910d0fca, Offset: 0x41a0
// Size: 0x59
function function_cc32afb9() {
    level endon(#"plane_hangar_complete");
    level.var_95790224 = [];
    while (true) {
        level waittill(#"hash_61df3d1c", swarm);
        level.var_95790224[level.var_95790224.size] = swarm;
        if (swarm.owner == self) {
            swarm.ignoreme = 1;
        }
    }
}

// Namespace Hangar
// Params 0, eflags: 0x0
// Checksum 0x3f7b34d1, Offset: 0x4208
// Size: 0x4b
function function_b81dfc22() {
    self endon(#"death");
    wait 0.5;
    self util::waittill_player_looking_at(level.var_7f246cd7.origin + (0, 0, 50), 30);
    level notify(#"hash_35d2241b");
}

// Namespace Hangar
// Params 0, eflags: 0x0
// Checksum 0xa98d67a9, Offset: 0x4260
// Size: 0xf
function function_2d8450d7() {
    wait 15;
    level notify(#"hash_35d2241b");
}

// Namespace Hangar
// Params 1, eflags: 0x0
// Checksum 0x67289a87, Offset: 0x4278
// Size: 0x22
function function_84a7642b(a_ents) {
    level flag::set("pallas_at_window");
}

// Namespace Hangar
// Params 0, eflags: 0x0
// Checksum 0x35af5fd1, Offset: 0x42a8
// Size: 0x72
function function_e0540704() {
    level endon(#"hash_28b81543");
    self waittill(#"goal");
    wait 4;
    level.var_7f246cd7 dialog::say("diaz_pick_up_the_damn_pac_0");
    wait 4;
    level.var_7f246cd7 dialog::say("diaz_you_wanna_get_the_mi_0");
    wait 5;
    level.var_7f246cd7 dialog::say("diaz_we_gotta_move_to_exf_0");
}

// Namespace Hangar
// Params 0, eflags: 0x0
// Checksum 0xde7f6d28, Offset: 0x4328
// Size: 0x82
function function_507f685c() {
    level waittill(#"hash_bf327f23");
    level.var_7f246cd7 dialog::say("diaz_on_my_position_let_0");
    level flag::wait_till("move_plane_hangar_enemies");
    var_49b32118 = getent("pa_hangar_dialog", "targetname");
    var_49b32118 dialog::say("nrcp_infiltrators_moving_0", 0, 1);
}

// Namespace Hangar
// Params 0, eflags: 0x0
// Checksum 0x5d67f0e4, Offset: 0x43b8
// Size: 0x32
function function_c8af325f() {
    level flag::wait_till("plane_hangar_enemies_fallback3");
    level flag::set("pallas_jump_to_window");
}

// Namespace Hangar
// Params 0, eflags: 0x0
// Checksum 0x274931e2, Offset: 0x43f8
// Size: 0x4a
function function_3dc00a0b() {
    e_target = getent("cyber_soldiers_hangar_target", "targetname");
    self thread ai::shoot_at_target("normal", e_target, undefined, 100, 10000);
}

// Namespace Hangar
// Params 1, eflags: 0x0
// Checksum 0x98254d37, Offset: 0x4450
// Size: 0x52
function function_f1dda14f(var_bf0873ca) {
    node = getnode(var_bf0873ca, "targetname");
    self forceteleport(node.origin, node.angles, 1);
}

// Namespace Hangar
// Params 0, eflags: 0x0
// Checksum 0xc914befb, Offset: 0x44b0
// Size: 0xce
function function_78f61bf2() {
    self endon(#"death");
    self ai::set_ignoreall(1);
    self ai::set_ignoreme(1);
    if (isdefined(self.target)) {
        var_4345e897 = self.goalradius;
        nd = getnode(self.target, "targetname");
        if (isdefined(nd)) {
            self ai::force_goal(nd, 64, 1, undefined, 1);
            self ai::set_ignoreall(0);
            self ai::set_ignoreme(0);
        }
        if (isdefined(self.radius)) {
            self.goalradius = self.radius;
        }
    }
}

// Namespace Hangar
// Params 0, eflags: 0x0
// Checksum 0xe5ab40d8, Offset: 0x4588
// Size: 0x62
function function_33ec51ea() {
    self endon(#"death");
    self.goalradius = 16;
    if (isdefined(self.target)) {
        node = getnode(self.target, "targetname");
        self setgoal(node, 1);
    }
}

// Namespace Hangar
// Params 0, eflags: 0x0
// Checksum 0x1864cbed, Offset: 0x45f8
// Size: 0xeb
function function_6ad5d018() {
    level.var_92d245e2 thread function_47f306da("prometheus_hangar_goal");
    level.var_f58c9f31 thread function_47f306da("theia_hangar_goal");
    level.var_5d4087a6 thread function_47f306da("hyperion_hangar_goal");
    level thread function_90b59893();
    spawner::add_spawn_function_group("hangar_ambient_ai", "script_noteworthy", &function_5f6c69c0);
    spawn_manager::enable("sm_hangar_ambient_combat");
    level thread function_1053dd4e();
    spawn_manager::wait_till_cleared("sm_hangar_ambient_combat");
    level notify(#"hash_bf48d580");
}

// Namespace Hangar
// Params 0, eflags: 0x0
// Checksum 0xbf7c1b15, Offset: 0x46f0
// Size: 0xfa
function function_1053dd4e() {
    self endon(#"hash_bf48d580");
    level flag::wait_till("side_cyberbattle_go");
    array::thread_all(level.players, &function_1232fdd1);
    level waittill(#"hash_8f285b1d");
    wait 1;
    a_enemies = spawner::get_ai_group_ai("hangar_ambient_ai");
    if (a_enemies.size > 0) {
        level.var_92d245e2 cybercom::function_d240e350("cybercom_immolation", a_enemies);
    }
    wait 3;
    level.var_f58c9f31 cybercom::function_d240e350("cybercom_smokescreen");
    wait 4;
    a_enemies = spawner::get_ai_group_ai("hangar_ambient_ai");
    if (a_enemies.size > 0) {
        level.var_5d4087a6 cybercom::function_d240e350("cybercom_immolation", a_enemies);
    }
}

// Namespace Hangar
// Params 0, eflags: 0x0
// Checksum 0x3ebb2054, Offset: 0x47f8
// Size: 0x4b
function function_1232fdd1() {
    self endon(#"hash_8f285b1d");
    wait 0.5;
    self util::waittill_player_looking_at(level.var_f58c9f31.origin + (0, 0, 64), 90, 1);
    level notify(#"hash_8f285b1d");
}

// Namespace Hangar
// Params 0, eflags: 0x0
// Checksum 0x53cbbe8e, Offset: 0x4850
// Size: 0xbd
function function_90b59893() {
    level endon(#"hash_bf48d580");
    var_8164b942 = getentarray("origin_ambient_grenade", "targetname");
    while (true) {
        n_rand = randomintrange(4, 8);
        wait n_rand;
        var_b311d2b0 = randomintrange(0, var_8164b942.size);
        level.var_2fd26037 magicgrenadetype(getweapon("frag_grenade"), var_8164b942[var_b311d2b0].origin, (0, 0, 0), 0.05);
    }
}

// Namespace Hangar
// Params 2, eflags: 0x0
// Checksum 0xd85d17eb, Offset: 0x4918
// Size: 0x1ba
function function_47f306da(var_5b01a37b, var_74cd64bc) {
    n_node = getnode(var_5b01a37b, "targetname");
    self forceteleport(n_node.origin, n_node.angles, 1);
    self setgoal(n_node);
    wait 0.5;
    self show();
    self namespace_dccf27b3::function_9110a277(0);
    self ai::set_ignoreall(0);
    self ai::set_ignoreme(0);
    a_ais = getaiteamarray("axis", "axis");
    foreach (ai in a_ais) {
        if (ai.script_noteworthy !== "hangar_ambient_ai") {
            self setignoreent(ai, 1);
        }
    }
    self.attackeraccuracy = 0.5;
    level waittill(#"hash_bf48d580");
    n_goal = getnode(n_node.target, "targetname");
    self setgoal(n_goal);
    self waittill(#"goal");
    self delete();
}

// Namespace Hangar
// Params 0, eflags: 0x0
// Checksum 0x3383eaf0, Offset: 0x4ae0
// Size: 0x18a
function function_5f6c69c0() {
    self.attackeraccuracy = 1;
    self.goalradius = 16;
    self.disable_score_events = 1;
    a_ais = getaiteamarray("allies", "allies");
    foreach (ai in a_ais) {
        if (isdefined(ai.targetname) && ai.targetname != "theia_ai" && ai.targetname != "hyperion_ai" && ai.targetname != "prometheus_ai") {
            self setignoreent(ai, 1);
        }
    }
    foreach (player in level.players) {
        self setignoreent(player, 1);
    }
    var_257bbc01 = getent("t_ambiant_hangar_goal_volume", "targetname");
    self setgoal(var_257bbc01);
}

// Namespace Hangar
// Params 0, eflags: 0x0
// Checksum 0xfafab6b4, Offset: 0x4c78
// Size: 0x6d
function function_de617dc2() {
    trig = getent("wing_r", "targetname");
    while (true) {
        trig waittill(#"trigger");
        exploder::exploder("fx_exploder_wing_bullet01");
        exploder::exploder("fx_exploder_wing_bullet02");
    }
}

// Namespace Hangar
// Params 0, eflags: 0x0
// Checksum 0xa6fd70e2, Offset: 0x4cf0
// Size: 0x42
function function_31427ccd() {
    level thread namespace_21b2c1f2::function_46333a8a();
    function_99cdcfac();
    function_71e6db7();
    level thread function_8b7b1958();
}

// Namespace Hangar
// Params 0, eflags: 0x0
// Checksum 0xed13f1a0, Offset: 0x4d40
// Size: 0x4a
function function_99cdcfac() {
    level flag::init("door_close");
    level flag::init("hend_grenade_timeout");
    level flag::init("vtol_hit");
}

// Namespace Hangar
// Params 0, eflags: 0x0
// Checksum 0xf396f62a, Offset: 0x4d98
// Size: 0xf2
function function_71e6db7() {
    level.var_92d245e2 ai::set_ignoreall(1);
    level.var_92d245e2 ai::set_ignoreme(1);
    level.var_92d245e2.goalradius = 16;
    level.var_7f246cd7.goalradius = 16;
    level.var_7f246cd7.allowpain = 0;
    level.var_7f246cd7 colors::set_force_color("o");
    level.var_2fd26037.goalradius = 16;
    level.var_2fd26037.allowpain = 0;
    level.var_9db406db.goalradius = 16;
    level.var_4d5a4697 ai::set_ignoreall(1);
    level.var_4d5a4697 ai::set_ignoreme(1);
    level.var_4d5a4697.goalradius = 16;
}

// Namespace Hangar
// Params 0, eflags: 0x0
// Checksum 0x46468513, Offset: 0x4e98
// Size: 0x1da
function function_8b7b1958() {
    level thread cp_prologue_util::function_42da021e("vh_vtol_flyby_b", 50, 100);
    level thread function_4422735b();
    level thread function_8efb9b5c();
    level.var_7f246cd7 thread function_f9196d1d();
    level flag::wait_till("hanger3_battle_event");
    level.var_2fd26037 thread function_414c1d0();
    level.var_2fd26037 thread function_11855253();
    level thread function_9ada4a46();
    level thread function_9ea7f8ae();
    level.var_9db406db ai::set_ignoreall(1);
    level.var_9db406db ai::set_ignoreme(1);
    level thread function_55039e89();
    level thread function_e37c0060();
    level waittill(#"hash_8413e49c");
    level flag::wait_till("hangar_5_bc");
    level thread objectives::breadcrumb("hangar_breadcrumb_5");
    function_d81a4ec();
    level.var_7f246cd7 colors::enable();
    trigger::use("vtol_hangar_empty_color_allies", "targetname");
    level thread namespace_21b2c1f2::function_973b77f9();
    level flag::wait_till("hangar3_backdoor");
    function_e966c1c0(0);
    skipto::function_be8adfb8("skipto_vtol_collapse");
}

// Namespace Hangar
// Params 0, eflags: 0x0
// Checksum 0x59bff982, Offset: 0x5080
// Size: 0x1eb
function function_4422735b() {
    t_door = getent("vtol_collapse_door_open", "targetname");
    var_634d0729 = array(level.var_4d5a4697, level.var_2fd26037, level.var_9db406db);
    level thread cp_prologue_util::function_21f52196("vtol_collapse_doors", t_door);
    level thread cp_prologue_util::function_2e61b3e8("vtol_collapse_doors", t_door, var_634d0729);
    while (!cp_prologue_util::function_cdd726fb("vtol_collapse_doors")) {
        wait 0.1;
    }
    var_ac769486 = getent("clip_player_vtol_collapse_backtrack_doorway", "targetname");
    var_ac769486 movez(100 * -1, 0.05);
    mdl_door_left = getent("vtol_hangar_in_l", "targetname");
    mdl_door_right = getent("vtol_hangar_in_r", "targetname");
    vec_right = anglestoright(mdl_door_left.angles);
    mdl_door_left moveto(mdl_door_left.origin - vec_right * 50, 0.5);
    mdl_door_right moveto(mdl_door_right.origin + vec_right * 44, 0.5);
    level notify(#"hash_3e92d474");
    level notify(#"hash_e3977daa");
}

// Namespace Hangar
// Params 0, eflags: 0x0
// Checksum 0x614b8079, Offset: 0x5278
// Size: 0x2a
function function_d43c2e1a() {
    level endon(#"death");
    level waittill(#"hash_cb897bce");
    level thread clientfield::set("vtol_missile_explode_trash_fx", 1);
}

// Namespace Hangar
// Params 0, eflags: 0x0
// Checksum 0xd8b8b7c2, Offset: 0x52b0
// Size: 0xfa
function function_9ea7f8ae() {
    var_fa1b3fb2 = getent("trig_dam_vtol_collapse", "targetname");
    var_fa1b3fb2 setcandamage(0);
    level flag::wait_till("2nd_hangar_apc_in_pos");
    level flag::wait_till("vtol_destroy_obj");
    var_fa1b3fb2 setcandamage(1);
    e_objective = getent("vtol_hangar_missile_objective", "targetname");
    objectives::set("cp_level_prologue_destroy", e_objective.origin);
    var_fa1b3fb2 trigger::wait_till();
    level notify(#"hash_36ad3c2e");
    level flag::set("vtol_hit");
}

// Namespace Hangar
// Params 0, eflags: 0x0
// Checksum 0x6963b36e, Offset: 0x53b8
// Size: 0xaa
function function_414c1d0() {
    level endon(#"hash_36ad3c2e");
    n_goal = getnode("n_hendricks_grenade", "targetname");
    self setgoal(n_goal);
    self waittill(#"goal");
    self thread function_23e5e896();
    level flag::wait_till("hend_grenade_timeout");
    /#
        iprintln("<dev string:x28>");
    #/
    wait 2;
    level flag::set("vtol_hit");
}

// Namespace Hangar
// Params 0, eflags: 0x0
// Checksum 0x6c977bac, Offset: 0x5470
// Size: 0x92
function function_23e5e896() {
    level endon(#"hash_36ad3c2e");
    self dialog::say("hend_our_weapons_are_no_g_0");
    level waittill(#"hash_723b53fc");
    self thread dialog::say("hend_we_gotta_bring_down_1", 0.25);
    wait 1;
    level flag::set("vtol_destroy_obj");
    wait 7;
    self dialog::say("hend_we_ain_t_doing_shit_0");
    wait 5;
    level flag::set("hend_grenade_timeout");
}

// Namespace Hangar
// Params 0, eflags: 0x0
// Checksum 0xb10cb70e, Offset: 0x5510
// Size: 0x5a
function function_10ed8bd7() {
    var_c3adecbb = 0;
    n_starttime = gettime();
    while (true) {
        wait 0.5;
        var_c3adecbb = (gettime() - n_starttime) / 1000;
        if (var_c3adecbb >= 20) {
            break;
        }
    }
    level flag::set("hend_grenade_timeout");
}

// Namespace Hangar
// Params 0, eflags: 0x0
// Checksum 0x6157cf54, Offset: 0x5578
// Size: 0xa2
function function_11855253() {
    self colors::disable();
    level waittill(#"hash_8413e49c");
    level thread function_15ce0cb4();
    self colors::enable();
    self ai::set_ignoreall(0);
    self ai::set_ignoreme(0);
    level.var_7f246cd7 ai::set_ignoreall(0);
    level.var_7f246cd7 ai::set_ignoreme(0);
    trigger::use("vtol_hendricks_move_up_initial");
}

// Namespace Hangar
// Params 0, eflags: 0x0
// Checksum 0xa8695a16, Offset: 0x5628
// Size: 0x22
function function_15ce0cb4() {
    level.var_2fd26037 dialog::say("hend_apc_s_out_of_commiss_0");
}

// Namespace Hangar
// Params 1, eflags: 0x0
// Checksum 0x7d9dba11, Offset: 0x5658
// Size: 0x73
function function_d418516(var_c83dc06e) {
    foreach (ai_rider in var_c83dc06e.riders) {
        self setignoreent(ai_rider, 1);
    }
}

// Namespace Hangar
// Params 0, eflags: 0x0
// Checksum 0xa8b5d92c, Offset: 0x56d8
// Size: 0x202
function function_55039e89() {
    spawner::add_spawn_function_group("sp_vtol_initial", "targetname", &function_d7dad356);
    spawner::add_spawn_function_group("sp_vtol_initial", "targetname", &cp_prologue_util::remove_grenades);
    spawner::simple_spawn("sp_vtol_initial");
    spawner::add_spawn_function_group("sp_vtol_hangar_sideroom", "targetname", &function_d7dad356);
    spawner::add_spawn_function_group("sp_vtol_hangar_sideroom", "targetname", &cp_prologue_util::remove_grenades);
    spawner::simple_spawn("sp_vtol_hangar_sideroom");
    spawner::add_spawn_function_group("aig_vtol_hangar_lower", "script_aigroup", &function_b7846718);
    spawner::add_spawn_function_group("aig_vtol_hangar_lower", "script_aigroup", &cp_prologue_util::remove_grenades);
    spawn_manager::enable("sm_vtol_hangar_rear");
    spawner::add_spawn_function_group("aig_vtol_hangar_upper", "script_aigroup", &function_5d48dce7);
    spawner::add_spawn_function_group("aig_vtol_hangar_upper", "script_aigroup", &cp_prologue_util::remove_grenades);
    spawn_manager::enable("sm_vtol_hangar_upper");
    level waittill(#"hash_ccdbd3be");
    spawner::simple_spawn("sp_vtol_hangar_top_front");
}

// Namespace Hangar
// Params 0, eflags: 0x0
// Checksum 0x7afa36c8, Offset: 0x58e8
// Size: 0xca
function function_d7dad356() {
    self endon(#"death");
    self thread function_f547728f();
    self thread function_f647689b();
    self thread return_fire();
    self thread function_1e82f4b7();
    level waittill(#"hash_d2de9e1f");
    self ai::set_ignoreall(1);
    var_3f0f1f46 = getent("trig_vtol_goal_vol_rear", "targetname");
    self setgoal(var_3f0f1f46);
    self waittill(#"goal");
    self ai::set_ignoreall(1);
}

// Namespace Hangar
// Params 0, eflags: 0x0
// Checksum 0xc5828cc3, Offset: 0x59c0
// Size: 0xc3
function function_1e82f4b7() {
    self endon(#"death");
    level flag::wait_till("door_close");
    var_c9aed927 = getentarray("outside_hangar_check", "targetname");
    foreach (var_26778947 in var_c9aed927) {
        if (self istouching(var_26778947) && isdefined(self)) {
            self delete();
            return;
        }
    }
}

// Namespace Hangar
// Params 0, eflags: 0x0
// Checksum 0xe2c9f14c, Offset: 0x5a90
// Size: 0x72
function function_b7846718() {
    self thread function_f547728f();
    self thread function_f647689b();
    self thread return_fire();
    var_3f0f1f46 = getent("trig_vtol_goal_vol_rear", "targetname");
    self setgoal(var_3f0f1f46);
}

// Namespace Hangar
// Params 0, eflags: 0x0
// Checksum 0x563d4bad, Offset: 0x5b10
// Size: 0x5a
function function_5d48dce7() {
    self thread function_f547728f();
    self thread function_f647689b();
    self thread return_fire();
    self.goalradius = 16;
    trigger::use("vtol_hangar_upper_color", "targetname");
}

// Namespace Hangar
// Params 0, eflags: 0x0
// Checksum 0xa4853507, Offset: 0x5b78
// Size: 0x42
function return_fire() {
    self util::waittill_any("damage", "bulletwhizby", "pain", "proximity");
    self ai::set_ignoreall(0);
}

// Namespace Hangar
// Params 0, eflags: 0x0
// Checksum 0x7bf063f5, Offset: 0x5bc8
// Size: 0x6a
function function_f647689b() {
    self endon(#"death");
    self ai::set_ignoreall(1);
    self ai::set_ignoreme(1);
    level util::waittill_any("vtol_hit", "vtol_hangar_player_leaves_cover");
    self ai::set_ignoreall(0);
    self ai::set_ignoreme(0);
}

// Namespace Hangar
// Params 0, eflags: 0x0
// Checksum 0x1b4d7e7, Offset: 0x5c40
// Size: 0x2e
function function_f547728f() {
    self endon(#"death");
    self.script_accuracy = 0.5;
    level waittill(#"hash_8413e49c");
    self.script_accuracy = 1;
}

// Namespace Hangar
// Params 0, eflags: 0x0
// Checksum 0x7d57e07a, Offset: 0x5c78
// Size: 0x235
function function_d81a4ec() {
    level thread function_114b96c0();
    level flag::wait_till("vtol_final_fallback");
    spawn_manager::kill("sm_vtol_hangar_upper");
    spawn_manager::kill("sm_vtol_hangar_rear");
    var_2373d08e = getent("trig_vtol_goal_vol_fallback_final", "targetname");
    var_f694cded = spawner::get_ai_group_ai("aig_vtol_hangar_lower");
    var_687c18ba = spawner::get_ai_group_ai("aig_vtol_hangar_initial");
    var_7fc45f7c = spawner::get_ai_group_ai("aig_plane_hangar_enemies_main");
    array::run_all(var_f694cded, &cleargoalvolume);
    array::run_all(var_687c18ba, &cleargoalvolume);
    array::run_all(var_7fc45f7c, &cleargoalvolume);
    array::run_all(var_f694cded, &setgoal, var_2373d08e);
    array::run_all(var_687c18ba, &setgoal, var_2373d08e);
    array::run_all(var_7fc45f7c, &setgoal, var_2373d08e);
    trigger::use("vtol_hangar_upper_retreat", "targetname");
    level thread function_c1bac28();
    spawner::waittill_ai_group_ai_count("aig_vtol_hangar_lower", 0);
    spawner::waittill_ai_group_ai_count("aig_vtol_hangar_upper", 0);
    spawner::waittill_ai_group_ai_count("aig_vtol_hangar_initial", 0);
    spawner::waittill_ai_group_ai_count("aig_plane_hangar_enemies_main", 0);
    wait 2;
}

// Namespace Hangar
// Params 0, eflags: 0x0
// Checksum 0x429c5800, Offset: 0x5eb8
// Size: 0x1a3
function function_c1bac28() {
    level thread function_f6c934d0();
    wait 15;
    var_d2315634 = getent("trig_vtol_goal_vol_fallback_final_defend_exit", "targetname");
    var_4b64857a = spawner::get_ai_group_ai("aig_vtol_hangar_upper");
    var_f694cded = spawner::get_ai_group_ai("aig_vtol_hangar_lower");
    var_687c18ba = spawner::get_ai_group_ai("aig_vtol_hangar_initial");
    var_7fc45f7c = spawner::get_ai_group_ai("aig_plane_hangar_enemies_main");
    var_20cedf03 = arraycombine(var_4b64857a, var_f694cded, 0, 0);
    var_20cedf03 = arraycombine(var_20cedf03, var_687c18ba, 0, 0);
    var_20cedf03 = arraycombine(var_20cedf03, var_7fc45f7c, 0, 0);
    foreach (enemy in var_20cedf03) {
        if (isalive(enemy)) {
            enemy cleargoalvolume();
            wait 0.1;
            enemy setgoalvolume(var_d2315634);
        }
    }
}

// Namespace Hangar
// Params 0, eflags: 0x0
// Checksum 0x4c78a4ed, Offset: 0x6068
// Size: 0x2a
function function_f6c934d0() {
    level thread util::function_d8eaed3d(6);
    level waittill(#"hash_fc98480b");
    util::clear_streamer_hint();
}

// Namespace Hangar
// Params 0, eflags: 0x0
// Checksum 0x1df0f147, Offset: 0x60a0
// Size: 0x6a
function function_896f0868() {
    e_closest_player = arraygetclosest(self.origin, level.activeplayers);
    self.goalradius = -128;
    self setgoalentity(e_closest_player);
    self ai::set_behavior_attribute("move_mode", "rambo");
}

// Namespace Hangar
// Params 0, eflags: 0x0
// Checksum 0xed6bc645, Offset: 0x6118
// Size: 0x82
function function_114b96c0() {
    var_25002d73 = 6;
    while (var_25002d73 > 5) {
        var_25002d73 = spawner::get_ai_group_sentient_count("aig_vtol_hangar_lower") + spawner::get_ai_group_sentient_count("aig_vtol_hangar_initial") + spawner::get_ai_group_sentient_count("aig_plane_hangar_enemies_main");
        wait 0.5;
    }
    level flag::set("vtol_final_fallback");
}

// Namespace Hangar
// Params 1, eflags: 0x0
// Checksum 0xdd2c58ea, Offset: 0x61a8
// Size: 0x7d
function function_19352a82(var_1f6e1fda) {
    foreach (ai_speaker in var_1f6e1fda) {
        if (isalive(ai_speaker)) {
            ai_speaker dialog::say("nrcg_fall_back_fall_back_0");
            break;
        }
    }
}

// Namespace Hangar
// Params 0, eflags: 0x0
// Checksum 0x76a72c99, Offset: 0x6230
// Size: 0x31a
function function_8efb9b5c() {
    level thread function_8bd46c9();
    foreach (player in level.players) {
        player.overrideplayerdamage = &function_e8443509;
    }
    a_e_targets = getentarray("first_apc_target", "targetname");
    var_2df9fcc1 = getent("t_dam_apc_squibs", "targetname");
    foreach (e_target in a_e_targets) {
        if (isalive(level.var_fac57550)) {
            level.var_fac57550 thread turret::shoot_at_target(e_target, 2.25, (0, 0, 0), 1, 0);
            level.var_fac57550 thread turret::shoot_at_target(e_target, 2.25, (0, 0, 0), 2, 0);
            level thread function_5792f76d(var_2df9fcc1, e_target.origin);
            wait 2.25;
            level notify(#"hash_1a6f8b52");
        }
    }
    wait 2.25;
    foreach (player in level.players) {
        player.overrideplayerdamage = undefined;
    }
    level.var_41d1cac6 = 1;
    level.var_26dc9f18 = 2;
    level.var_3534f286 = 0.25;
    level.var_1a3fc6d8 = 0.5;
    if (isalive(level.var_fac57550)) {
        level.var_fac57550 turret::set_burst_parameters(level.var_41d1cac6, level.var_26dc9f18, level.var_3534f286, level.var_1a3fc6d8, 1);
        level.var_fac57550 turret::set_burst_parameters(level.var_41d1cac6, level.var_26dc9f18, level.var_3534f286, level.var_1a3fc6d8, 2);
        level.var_fac57550 turret::enable(1, 1);
        level.var_fac57550 turret::enable(2, 1);
        level.var_fac57550 turret::disable_ai_getoff(1, 1);
        level.var_fac57550 turret::disable_ai_getoff(2, 1);
    }
}

// Namespace Hangar
// Params 2, eflags: 0x0
// Checksum 0xc9154679, Offset: 0x6558
// Size: 0x72
function function_5792f76d(var_2df9fcc1, v_loc) {
    self endon(#"death");
    level endon(#"vtol_collapse_done");
    level endon(#"hash_1a6f8b52");
    var_2df9fcc1 waittill(#"trigger", e_who);
    if (e_who.team === "axis") {
        physicsexplosionsphere(v_loc, -6, -6, 0.7);
    }
}

// Namespace Hangar
// Params 0, eflags: 0x0
// Checksum 0xaaa3ccd1, Offset: 0x65d8
// Size: 0x3d2
function function_8bd46c9() {
    level flag::wait_till("activate_initial_apc");
    level thread function_b5a6b879();
    vehicle::add_spawn_function("vtol_collapse_apc", &function_75381a71);
    var_199de689 = vehicle::simple_spawn_single_and_drive("vtol_collapse_apc");
    e_target = getent("second_apc_target", "targetname");
    var_199de689 thread turret::shoot_at_target(e_target, 2, (0, 0, 0), 1, 0);
    var_199de689 thread turret::shoot_at_target(e_target, 2, (0, 0, 0), 2, 0);
    wait 2;
    var_199de689 turret::set_burst_parameters(level.var_41d1cac6, level.var_26dc9f18, level.var_3534f286, level.var_1a3fc6d8, 1);
    var_199de689 turret::set_burst_parameters(level.var_41d1cac6, level.var_26dc9f18, level.var_3534f286, level.var_1a3fc6d8, 2);
    var_199de689 turret::enable(1, 1);
    var_199de689 turret::enable(2, 1);
    var_199de689 turret::disable_ai_getoff(1, 1);
    var_199de689 turret::disable_ai_getoff(2, 1);
    var_199de689 waittill(#"reached_end_node");
    var_199de689 thread function_a2041661();
    level flag::set("2nd_hangar_apc_in_pos");
    level thread function_d43c2e1a();
    level flag::wait_till("vtol_hit");
    level notify(#"hash_7452e7a8");
    objectives::complete("cp_level_prologue_destroy");
    level thread function_2226d83();
    level thread scene::play("p7_fxanim_cp_prologue_vtol_hangar_bundle");
    var_2ef9d306 = getent("vtol_hangar_drop", "targetname");
    var_2ef9d306 thread cp_prologue_util::function_d723979e("swap_vtol_to_destroyed", "veh_t7_mil_vtol_nrc_no_interior_d", "vtol_collapse_done");
    level notify(#"hash_5a11bfd7");
    var_199de689 delete();
    wait 0.05;
    level.var_fac57550 delete();
    level waittill(#"hash_ccdbd3be");
    var_fa3fe683 = getent("vtol_hangar_explosion_origin", "targetname");
    radiusdamage(var_fa3fe683.origin, 400, 2000, 800);
    physicsexplosioncylinder(var_fa3fe683.origin, 1200, 800, 0.5);
    level function_ce858cd3(1);
    var_1b63031d = getent("vtol_ai_blockers", "targetname");
    var_1b63031d movez(700, 0.05);
    util::delay(3, undefined, &function_62732b9d, var_fa3fe683.origin);
}

// Namespace Hangar
// Params 2, eflags: 0x0
// Checksum 0x27c597ab, Offset: 0x69b8
// Size: 0xd9
function function_62732b9d(s_origin, n_radius) {
    if (!isdefined(n_radius)) {
        n_radius = 400;
    }
    var_d96f8b8b = [];
    foreach (corpse in getcorpsearray()) {
        if (distance2d(corpse.origin, s_origin) < n_radius) {
            var_d96f8b8b[var_d96f8b8b.size] = corpse;
        }
    }
    for (index = 0; index < var_d96f8b8b.size; index++) {
        var_d96f8b8b[index] delete();
    }
}

// Namespace Hangar
// Params 0, eflags: 0x0
// Checksum 0x1696722f, Offset: 0x6aa0
// Size: 0xa2
function function_2226d83() {
    var_c9510c8e = getent("vtol_hangar_explosion_origin", "targetname");
    level waittill(#"missile_explosion");
    playrumbleonposition("cp_prologue_rumble_hangar_vtol_collapse_rocket_fall", var_c9510c8e.origin);
    level waittill(#"hash_ccdbd3be");
    playrumbleonposition("cp_prologue_rumble_hangar_vtol_collapse_explosion", var_c9510c8e.origin);
    level waittill(#"hash_98f09713");
    playrumbleonposition("cp_prologue_rumble_hangar_vtol_collapse_hit_ground", var_c9510c8e.origin);
}

// Namespace Hangar
// Params 0, eflags: 0x0
// Checksum 0x3cbf6a09, Offset: 0x6b50
// Size: 0xf2
function function_b5a6b879() {
    var_280d5f68 = getent("hangar_gate_l", "targetname");
    var_3c301126 = getent("hangar_gate_r", "targetname");
    var_9c7511b4 = struct::get("hangar_gate_move_pos_l", "targetname");
    var_205c499a = struct::get("hangar_gate_move_pos_r", "targetname");
    var_c2777dd9 = "p7_fxanim_cp_prologue_hangar_door_bundle";
    level function_a8cd091b(0, var_280d5f68, var_3c301126, var_9c7511b4, var_205c499a, var_c2777dd9, "umbra_gate_hangar_04");
    level flag::set("door_close");
}

// Namespace Hangar
// Params 0, eflags: 0x0
// Checksum 0x5816ae95, Offset: 0x6c50
// Size: 0x26a
function function_f9196d1d() {
    level flag::wait_till("friendlies_jump_out_window");
    level thread function_f87b8938();
    level flag::wait_till("pallas_at_window");
    level thread scene::play("cin_pro_10_04_hangar_vign_leap_new_jump_across");
    level waittill(#"hash_aea6d25d");
    level clientfield::set("diaz_break_2", 2);
    var_9e34fc53 = getnode("n_pallas_vtol_tp", "targetname");
    level.var_7f246cd7 setgoal(var_9e34fc53);
    level waittill(#"hash_8413e49c");
    trigger::use("pallas_move_up_initial");
    level flag::wait_till("diaz_ready_to_concuss");
    self colors::disable();
    var_5cbb67a5 = getnode("diaz_concuss_node", "targetname");
    self setgoal(var_5cbb67a5, 1);
    self waittill(#"goal");
    array::thread_all(level.players, &function_5b79ea07);
    level thread function_570a8f9e();
    level waittill(#"hash_4939dbfa");
    level thread scene::play("cin_pro_10_03_hangar_vign_concussive");
    level waittill(#"hash_bd8e9605");
    self cybercom::function_d240e350("cybercom_concussive", undefined, 0);
    self clearforcedgoal();
    self ai::set_ignoreall(1);
    self ai::set_ignoreme(1);
    var_c3c81269 = getnode("diaz_concuss_cover_node", "targetname");
    self setgoal(var_c3c81269, 1);
    self waittill(#"goal");
    self ai::set_ignoreall(0);
    self ai::set_ignoreme(0);
    function_e966c1c0(1);
}

// Namespace Hangar
// Params 0, eflags: 0x0
// Checksum 0x39c92f8, Offset: 0x6ec8
// Size: 0x43
function function_5b79ea07() {
    wait 0.5;
    self util::waittill_player_looking_at(level.var_7f246cd7.origin + (0, 0, 64), 90);
    level notify(#"hash_4939dbfa");
}

// Namespace Hangar
// Params 0, eflags: 0x0
// Checksum 0xcf3d7d7a, Offset: 0x6f18
// Size: 0xf
function function_570a8f9e() {
    wait 5;
    level notify(#"hash_4939dbfa");
}

// Namespace Hangar
// Params 0, eflags: 0x0
// Checksum 0x3ad4e58f, Offset: 0x6f30
// Size: 0x193
function function_f87b8938() {
    spawner::add_spawn_function_ai_group("taylor_fodder_ai", &function_e3e4f0b8);
    level flag::wait_till("friendlies_jump_out_window");
    level.var_92d245e2 thread scene::play("cin_pro_10_04_hangar_vign_coverfire_prometheus");
    level thread function_5f5d84df();
    wait 1.5;
    spawn_manager::enable("hangars_taylor_vign_fodder_manager");
    level.var_92d245e2 dialog::say("tayr_get_to_exfil_i_got_0");
    level.var_92d245e2 thread function_e547f97a();
    level waittill(#"hash_e3977daa");
    spawn_manager::disable("hangars_taylor_vign_fodder_manager");
    level notify(#"hash_71f2cae");
    level.var_92d245e2 delete();
    var_886e8d99 = getentarray("hangars_taylor_vign_fodder_spawner_ai", "targetname");
    foreach (var_7c27e379 in var_886e8d99) {
        var_7c27e379 delete();
    }
}

// Namespace Hangar
// Params 0, eflags: 0x0
// Checksum 0x87374e5c, Offset: 0x70d0
// Size: 0x105
function function_e547f97a() {
    self endon(#"death");
    level endon(#"hash_e3977daa");
    level endon(#"hash_5565b88d");
    while (true) {
        a_enemies = spawner::get_ai_group_ai("taylor_fodder_ai");
        if (a_enemies.size === 0) {
            wait 2;
            continue;
        }
        foreach (enemy in a_enemies) {
            if (isalive(enemy)) {
                self ai::shoot_at_target("normal", enemy, undefined, randomfloatrange(1, 3));
            }
        }
        wait 1.5;
    }
}

// Namespace Hangar
// Params 0, eflags: 0x0
// Checksum 0x220aaaa8, Offset: 0x71e0
// Size: 0xff
function function_5f5d84df() {
    level endon(#"hash_73facd66");
    level endon(#"hash_5565b88d");
    while (true) {
        level flag::wait_till("player_in_taylor_coverfire");
        spawn_manager::enable("hangars_taylor_vign_fodder_manager");
        level flag::wait_till_clear("player_in_taylor_coverfire");
        spawn_manager::disable("hangars_taylor_vign_fodder_manager");
        a_enemies = spawner::get_ai_group_ai("taylor_fodder_ai");
        foreach (enemy in a_enemies) {
            enemy delete();
        }
    }
}

// Namespace Hangar
// Params 0, eflags: 0x0
// Checksum 0x17614627, Offset: 0x72e8
// Size: 0xbb
function function_e3e4f0b8() {
    self endon(#"death");
    level endon(#"hash_71f2cae");
    self.attackeraccuracy = 1;
    self.goalradius = 32;
    self.disable_score_events = 1;
    if (isdefined(level.var_92d245e2)) {
        self ai::shoot_at_target("normal", level.var_92d245e2, undefined, 1000);
    }
    foreach (player in level.players) {
        self setignoreent(player, 1);
    }
}

// Namespace Hangar
// Params 0, eflags: 0x0
// Checksum 0xfde79046, Offset: 0x73b0
// Size: 0x62
function function_e37c0060() {
    level waittill(#"hash_8413e49c");
    wait 6;
    level dialog::remote("hall_diaz_i_m_in_positio_0", undefined, "normal");
    level.var_7f246cd7 dialog::say("diaz_copy_that_to_us_h_0");
    level flag::set("hangar_5_bc");
}

// Namespace Hangar
// Params 13, eflags: 0x0
// Checksum 0x38950875, Offset: 0x7420
// Size: 0x77
function function_e8443509(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, modelindex, psoffsettime, vsurfacenormal) {
    if (einflictor === level.var_fac57550) {
        return 0;
    }
}

// Namespace Hangar
// Params 0, eflags: 0x0
// Checksum 0xcc11c0dc, Offset: 0x74a0
// Size: 0xa2
function function_a2041661() {
    var_44762fa4 = self vehicle::function_ad4ec07a("driver");
    if (isalive(var_44762fa4)) {
        var_44762fa4 endon(#"death");
        var_44762fa4 vehicle::get_out();
        n_node = getnode("vtol_driver_node", "targetname");
        var_44762fa4 setgoal(n_node, 1);
        var_44762fa4 util::stop_magic_bullet_shield();
    }
}

// Namespace Hangar
// Params 7, eflags: 0x0
// Checksum 0x6899670, Offset: 0x7550
// Size: 0x21a
function function_a8cd091b(var_a334437f, var_280d5f68, var_3c301126, var_9c7511b4, var_205c499a, var_c2777dd9, var_902e27b5) {
    if (var_a334437f) {
        var_280d5f68 moveto(var_9c7511b4.origin, 0.05);
        var_3c301126 moveto(var_205c499a.origin, 0.05);
        level thread scene::skipto_end(var_c2777dd9);
        var_3c301126 disconnectpaths();
        var_280d5f68 disconnectpaths();
        return;
    }
    level thread scene::play(var_c2777dd9);
    var_280d5f68 moveto(var_9c7511b4.origin, 6);
    var_3c301126 moveto(var_205c499a.origin, 6);
    var_56d74922 = randomint(2);
    var_280d5f68 playsound("evt_hangar_door_start_l_" + var_56d74922);
    var_3c301126 playsound("evt_hangar_door_start_r_" + var_56d74922);
    var_280d5f68 playloopsound("evt_hangar_door_loop_l", 2);
    var_3c301126 playloopsound("evt_hangar_door_loop_r", 2);
    var_3c301126 waittill(#"movedone");
    var_3c301126 disconnectpaths();
    var_280d5f68 disconnectpaths();
    var_280d5f68 stoploopsound(0.25);
    var_3c301126 stoploopsound(0.25);
    var_280d5f68 playsound("evt_hangar_door_stop_l");
    var_3c301126 playsound("evt_hangar_door_stop_r");
    if (isdefined(var_902e27b5)) {
        umbragate_set(var_902e27b5, 0);
    }
}

// Namespace Hangar
// Params 0, eflags: 0x0
// Checksum 0xfe463a7d, Offset: 0x7778
// Size: 0xba
function function_10ab649() {
    var_280d5f68 = getent("plane_hangar_out_l", "targetname");
    var_3c301126 = getent("plane_hangar_out_r", "targetname");
    s_door_loc = struct::get("plane_hangar_exit_close", "targetname");
    var_280d5f68 moveto(s_door_loc.origin, 0.5);
    var_3c301126 moveto(s_door_loc.origin, 0.5);
}

// Namespace Hangar
// Params 0, eflags: 0x0
// Checksum 0x17d099eb, Offset: 0x7840
// Size: 0xc2
function function_9ada4a46() {
    level endon(#"hash_cb897bce");
    var_32400ae0 = getent("trig_dam_vtol_grenade_accolade", "targetname");
    var_32400ae0 setcandamage(0);
    level flag::wait_till("2nd_hangar_apc_in_pos");
    wait 0.5;
    var_32400ae0 setcandamage(1);
    var_32400ae0 trigger::wait_till();
    if (isplayer(var_32400ae0.who)) {
        namespace_61c634f2::function_470fe5d8(var_32400ae0.who);
    }
}

// Namespace Hangar
// Params 1, eflags: 0x0
// Checksum 0x3ce2dbc7, Offset: 0x7910
// Size: 0x3a
function function_e966c1c0(var_eb6e3c93) {
    level.var_2fd26037.perfectaim = var_eb6e3c93;
    level.var_9db406db.perfectaim = var_eb6e3c93;
    level.var_7f246cd7.perfectaim = var_eb6e3c93;
}

// Namespace Hangar
// Params 2, eflags: 0x0
// Checksum 0x8b4e1cf4, Offset: 0x7958
// Size: 0x1f1
function function_ba29155a(var_c047ec73, var_3b15866b) {
    if (!isdefined(var_c047ec73)) {
        var_c047ec73 = -6;
    }
    if (!isdefined(var_3b15866b)) {
        var_3b15866b = var_c047ec73 * 0.5;
    }
    self notify(#"hash_2f5b059f");
    self endon(#"death");
    self endon(#"hash_2f5b059f");
    self endon(#"hash_a2ba32d");
    self thread function_a2ba32d();
    while (true) {
        wait 0.05;
        if (!isdefined(self.goalpos)) {
            continue;
        }
        v_goal = self.goalpos;
        e_player = arraygetclosest(v_goal, level.players);
        e_closest = arraygetclosest(v_goal, array(e_player, self));
        n_dist = distance2dsquared(self.origin, e_player.origin);
        var_c4197ac8 = isplayer(e_closest);
        if (n_dist < var_3b15866b * var_3b15866b || var_c4197ac8) {
            self ai::set_behavior_attribute("cqb", 0);
            self ai::set_behavior_attribute("sprint", 1);
            continue;
        }
        if (n_dist < var_c047ec73 * var_c047ec73) {
            self ai::set_behavior_attribute("cqb", 0);
            self ai::set_behavior_attribute("sprint", 0);
            continue;
        }
        if (n_dist > var_c047ec73 * var_c047ec73 * 1.25) {
            self ai::set_behavior_attribute("cqb", 1);
            self ai::set_behavior_attribute("sprint", 0);
            continue;
        }
    }
}

// Namespace Hangar
// Params 0, eflags: 0x0
// Checksum 0x8544de89, Offset: 0x7b58
// Size: 0x4a
function function_a2ba32d() {
    self endon(#"hash_2f5b059f");
    self endon(#"death");
    self waittill(#"hash_a2ba32d");
    self ai::set_behavior_attribute("cqb", 0);
    self ai::set_behavior_attribute("sprint", 0);
}

// Namespace Hangar
// Params 1, eflags: 0x0
// Checksum 0x7c169460, Offset: 0x7bb0
// Size: 0xaa
function function_ce858cd3(b_up) {
    if (!isdefined(b_up)) {
        b_up = 0;
    }
    e_collision = getent("hangar_vtol_crash_clip", "targetname");
    e_collision connectpaths();
    if (b_up) {
        e_collision movez(1000, 0.05);
    } else {
        e_collision movez(-1000, 0.05);
    }
    wait 0.05;
    if (isdefined(e_collision)) {
        e_collision disconnectpaths(0, 0);
    }
}

// Namespace Hangar
// Params 1, eflags: 0x0
// Checksum 0x541a7b85, Offset: 0x7c68
// Size: 0xaa
function function_d3c9b1d1(params) {
    if (!isdefined(level.var_7f246cd7)) {
        return;
    }
    if (!isdefined(level.var_fa73812c)) {
        level.var_fa73812c = 1;
        level.var_446343dd = 0;
    }
    var_efeac590 = gettime();
    if (level.var_fa73812c || isplayer(params.eattacker) && 10000 < var_efeac590 - level.var_446343dd) {
        level.var_7f246cd7 notify(#"hash_2605e152", "generic_encourage");
        level.var_446343dd = var_efeac590;
        level.var_fa73812c = 0;
    }
}

