#using scripts/codescripts/struct;
#using scripts/cp/_collectibles;
#using scripts/cp/_debug;
#using scripts/cp/_dialog;
#using scripts/cp/_hacking;
#using scripts/cp/_laststand;
#using scripts/cp/_load;
#using scripts/cp/_objectives;
#using scripts/cp/_oed;
#using scripts/cp/_skipto;
#using scripts/cp/_spawn_manager;
#using scripts/cp/_util;
#using scripts/cp/cp_mi_cairo_ramses2_fx;
#using scripts/cp/cp_mi_cairo_ramses2_sound;
#using scripts/cp/cp_mi_cairo_ramses_accolades;
#using scripts/cp/cp_mi_cairo_ramses_alley;
#using scripts/cp/cp_mi_cairo_ramses_utility;
#using scripts/cp/cp_mi_cairo_ramses_vtol_igc;
#using scripts/cp/cybercom/_cybercom_util;
#using scripts/cp/gametypes/_battlechatter;
#using scripts/cp/gametypes/_save;
#using scripts/shared/ai/robot_phalanx;
#using scripts/shared/ai/systems/gib;
#using scripts/shared/ai_shared;
#using scripts/shared/array_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/colors_shared;
#using scripts/shared/compass;
#using scripts/shared/exploder_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/gameobjects_shared;
#using scripts/shared/laststand_shared;
#using scripts/shared/lui_shared;
#using scripts/shared/math_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/system_shared;
#using scripts/shared/trigger_shared;
#using scripts/shared/turret_shared;
#using scripts/shared/util_shared;
#using scripts/shared/vehicle_ai_shared;
#using scripts/shared/vehicle_shared;
#using scripts/shared/vehicleriders_shared;
#using scripts/shared/vehicles/_quadtank;
#using scripts/shared/weapons/_weaponobjects;

#namespace arena_defend;

// Namespace arena_defend
// Params 0, eflags: 0x2
// Checksum 0xebe36145, Offset: 0x3050
// Size: 0x2a
function autoexec function_2dc19561() {
    system::register("arena_defend", &__init__, undefined, undefined);
}

// Namespace arena_defend
// Params 0, eflags: 0x0
// Checksum 0x6f5a8f95, Offset: 0x3088
// Size: 0x2ea
function __init__() {
    clientfield::register("scriptmover", "arena_defend_weak_point_keyline", 1, 1, "int");
    clientfield::register("world", "clear_all_dyn_ents", 1, 1, "counter");
    clientfield::register("toplayer", "set_dedicated_shadow", 1, 1, "int");
    level thread scene::play("cin_ram_05_01_quadtank_flatbed_pose");
    ramses_util::function_3f4f84e("arena_defend_car4cover_node", "targetname", 0);
    ramses_util::function_3f4f84e("hendricks_mobile_wall_start_node", "targetname", 0);
    ramses_util::function_3f4f84e("arena_defend_demostreet_intro_khalil", "targetname", 0);
    ramses_util::function_3f4f84e("mobile_wall_door_traversals", "targetname", 0);
    ramses_util::function_3f4f84e("wp_03_dynamic_covernode", "script_noteworthy", 0);
    var_cfdb3b07 = getent("mobile_wall_doors_clip", "targetname");
    var_cfdb3b07 disconnectpaths(0, 0);
    var_70d87be7 = getent("trig_wp_01_kill_stuck_players", "targetname");
    if (isdefined(var_70d87be7)) {
        var_70d87be7 triggerenable(0);
    }
    var_a9060824 = getent("trig_wp_04_damage", "targetname");
    var_a9060824 triggerenable(0);
    var_5fd4d3b9 = getentarray("lgt_shadow_block", "targetname");
    foreach (blocker in var_5fd4d3b9) {
        blocker hide();
    }
    for (i = 1; i < 6; i++) {
        ramses_util::function_3f4f84e("wp_0" + i + "_traversal_jump", "script_noteworthy", 0);
    }
    init_flags();
    setdvar("ui_newHud", 1);
}

// Namespace arena_defend
// Params 2, eflags: 0x0
// Checksum 0x80bc29b0, Offset: 0x3380
// Size: 0x1f2
function intro(str_objective, var_74cd64bc) {
    load::function_73adcefc();
    level scene::init("cin_ram_05_01_block_1st_rip");
    level scene::init("p7_fxanim_cp_ramses_wall_drop_bundle");
    getent("mobile_wall_turret_blocker", "targetname") hide();
    function_c4fc0ade(str_objective, var_74cd64bc);
    battlechatter::function_d9f49fba(0);
    level thread function_3c00dec();
    load::function_a2995f22(2);
    level thread function_d8bb5a8e();
    level thread namespace_a6a248fc::function_1e7ee1cd();
    ramses_util::function_3f4f84e("nd_raps_launch_point_1", "targetname", 0);
    ramses_util::function_3f4f84e("nd_raps_launch_point_2", "targetname", 0);
    ramses_util::function_3f4f84e("nd_raps_launch_point_3", "targetname", 0);
    ramses_util::function_3f4f84e("nd_raps_launch_point_4", "targetname", 0);
    level flag::set("arena_defend_spawn");
    level thread function_aed0e82f();
    if (isdefined(level.var_12f2db0c)) {
        level thread [[ level.var_12f2db0c ]]();
    }
    level thread ramses_util::function_d0d2f172("cin_ram_05_01_defend_vign_rescueinjured_r_group", "arena_defend_intro_player_exits_technical");
    level function_43ae7eec(1);
    level thread function_27342097();
    skipto::function_be8adfb8(str_objective);
}

// Namespace arena_defend
// Params 0, eflags: 0x0
// Checksum 0xeaf53f04, Offset: 0x3580
// Size: 0x3a
function function_aed0e82f() {
    level util::waittill_notify_or_timeout("arena_defend_intro_open_door", 30);
    battlechatter::function_d9f49fba(1);
    function_96944c1(1);
}

// Namespace arena_defend
// Params 4, eflags: 0x0
// Checksum 0x4504bebd, Offset: 0x35c8
// Size: 0x9a
function intro_done(str_objective, var_74cd64bc, var_e4cd2b8b, player) {
    ramses_util::function_7255e66(0, "alley_mobile_armory");
    if (var_e4cd2b8b) {
        level scene::skipto_end("cin_ram_05_01_block_1st_rip_skipto");
    }
    if (var_74cd64bc) {
        level thread util::function_d8eaed3d(5);
    }
    collectibles::function_93523442("p7_nc_cai_ram_01", 60, (0, -5, 0));
    collectibles::function_37aecd21();
}

// Namespace arena_defend
// Params 2, eflags: 0x0
// Checksum 0xb2d4b07, Offset: 0x3670
// Size: 0x1fa
function main(str_objective, var_74cd64bc) {
    if (var_74cd64bc) {
        load::function_73adcefc();
        level thread function_b7b36dff();
    }
    level thread function_e45af9f2();
    level thread function_f9842c89();
    level flag::set("arena_defend_spawn");
    function_c4fc0ade(str_objective, var_74cd64bc);
    getent("mobile_wall_turret_blocker", "targetname") show();
    namespace_38256252::function_bb0dee49();
    namespace_38256252::function_69c025f8();
    namespace_38256252::function_5553172f();
    namespace_38256252::function_cef37178();
    function_e8a47a87();
    ramses_util::function_3f4f84e("arena_defend_dynamic_covernodes", "script_noteworthy", 0);
    level thread objectives();
    level thread function_181343bc();
    level thread function_38d8eaf7();
    if (var_74cd64bc) {
        level thread function_786c5bca();
        level thread function_82802a7a(1);
        level thread function_a5b142fc(1);
        level flag::wait_till("arena_defend_mobile_wall_deployed");
    }
    function_345b912d();
    function_bbf0087d();
    function_cac20541();
    function_30f53fbc();
    skipto::function_be8adfb8("arena_defend");
}

// Namespace arena_defend
// Params 2, eflags: 0x0
// Checksum 0xb4cfc8ba, Offset: 0x3878
// Size: 0x2e2
function function_4451e1bd(str_objective, var_74cd64bc) {
    if (var_74cd64bc) {
        load::function_73adcefc();
        function_c4fc0ade(str_objective, var_74cd64bc);
        level scene::init("cin_ram_05_demostreet_3rd_sh010");
        load::function_a2995f22();
        util::screen_fade_out(0, "black", "skipto_fade");
        function_96944c1();
        level thread function_ce07d8df();
        level function_bccb9996();
        level thread function_66f027df();
        level thread function_c779fef1();
        level thread function_82802a7a(1);
        level thread function_a5b142fc(1);
        level thread namespace_a6a248fc::function_7b69c801();
        function_52eeccd();
        level thread function_43ae7eec(0, 1);
        var_35a302af = vehicle::simple_spawn_single("arena_defend_intro_technical");
        var_35a302af flag::init("warp_to_spline_end_done");
        var_35a302af util::delay(0.25, undefined, &kill);
        level thread function_9b890ccb();
        level thread scene::skipto_end("p7_fxanim_cp_ramses_checkpoint_wall_01_bundle");
        level thread scene::skipto_end("p7_fxanim_cp_ramses_checkpoint_wall_02_bundle");
        util::delay(0.5, undefined, &util::screen_fade_in, 1.5, "black", "skipto_fade");
        level notify(#"hash_18cf70dc");
        util::delay(2, undefined, &function_30f53fbc);
        namespace_38256252::function_bb0dee49();
        namespace_38256252::function_69c025f8();
        namespace_38256252::function_5553172f();
        namespace_38256252::function_cef37178();
    }
    function_8f461d35(0);
    function_2e8bcd54();
    function_4dcf9e47();
    function_3d3f7691();
    function_2fcc9369("arena_defend_spawn_manager_friendly");
    level.var_bbe9f011 = undefined;
    skipto::function_be8adfb8("sinkhole_collapse");
}

// Namespace arena_defend
// Params 0, eflags: 0x0
// Checksum 0xfff87f52, Offset: 0x3b68
// Size: 0x15a
function function_bccb9996() {
    a_fxanims = array("wp_01", "wp_02", "wp_03", "wp_04", "wp_05");
    foreach (str_scene_name in a_fxanims) {
        level scene::init(str_scene_name);
        util::wait_network_frame();
    }
    showmiscmodels("sinkhole_misc_model");
    function_ee6b663("wp_01");
    function_ee6b663("wp_02");
    function_ee6b663("wp_03");
    function_ee6b663("wp_04");
    function_ee6b663("wp_05");
    level flag::set("all_weak_points_destroyed");
}

// Namespace arena_defend
// Params 1, eflags: 0x0
// Checksum 0x43614a90, Offset: 0x3cd0
// Size: 0x30d
function function_ee6b663(var_ca3f11aa) {
    level flag::init(var_ca3f11aa);
    level flag::init(var_ca3f11aa + "_identified");
    level flag::init(var_ca3f11aa + "_destroyed");
    ramses_util::function_3f4f84e(var_ca3f11aa + "_covernode", "script_noteworthy", 1);
    ramses_util::function_8bf0b925(var_ca3f11aa + "_traversal", "script_noteworthy", 1);
    level flag::set(var_ca3f11aa);
    level flag::set(var_ca3f11aa + "_destroyed");
    level thread scene::skipto_end(var_ca3f11aa, "targetname");
    var_9bb18713 = getentarray("collision_" + var_ca3f11aa, "targetname");
    foreach (var_44febfef in var_9bb18713) {
        if (var_44febfef.targetname != "collision_wp_05") {
            var_44febfef delete();
        }
    }
    ramses_util::function_3f4f84e(var_ca3f11aa + "_traversal_jump", "script_noteworthy", 1);
    ramses_util::function_8bf0b925(var_ca3f11aa + "_traversal", "script_noteworthy", 0);
    spawn_manager::kill("sm_" + var_ca3f11aa + "_defenders", 1);
    switch (var_ca3f11aa) {
    case "wp_01":
        var_70d87be7 = getent("trig_wp_01_kill_stuck_players", "targetname");
        if (isdefined(var_70d87be7)) {
            var_70d87be7 triggerenable(1);
        }
        break;
    case "wp_02":
        trigger::use("wp_03_goal_trig");
        ramses_util::function_3f4f84e(var_ca3f11aa + "_covernode", "script_noteworthy", 0);
        break;
    case "wp_04":
        var_a9060824 = getent("trig_wp_04_damage", "targetname");
        var_a9060824 triggerenable(1);
        spawn_manager::enable("sm_wp_04_robot_rushers");
        ramses_util::function_3f4f84e("wp_04_raps_walk", "targetname", 0);
        break;
    case "wp_05":
        spawn_manager::kill("arena_defend_far_left_enemies");
    default:
        break;
    }
}

// Namespace arena_defend
// Params 4, eflags: 0x0
// Checksum 0xf1ab5b7d, Offset: 0x3fe8
// Size: 0x1ca
function function_82a50f67(str_objective, var_74cd64bc, var_e4cd2b8b, player) {
    if (var_74cd64bc) {
        level flag::set("sinkhole_charges_detonated");
        objectives::complete("cp_level_ramses_demolish_arena_defend");
        function_3eb1d89e();
    }
    objectives::set("cp_level_ramses_reinforce_safiya");
    function_26aaae96();
    if (level flag::get("arena_defend_common_elements_initialized")) {
        spawner::remove_global_spawn_function("allies", &function_c23243fe);
        callback::remove_on_spawned(&function_e377e915);
    }
    var_1b7b3a6 = getweapon("spike_launcher");
    foreach (player in level.players) {
        if (player hasweapon(var_1b7b3a6)) {
            player takeweapon(var_1b7b3a6);
        }
    }
    battlechatter::function_d9f49fba(1);
    namespace_38256252::function_4df6d923();
    namespace_38256252::function_eb593e7e();
    namespace_38256252::function_a64e00f5();
    namespace_38256252::function_508c89fe();
}

// Namespace arena_defend
// Params 0, eflags: 0x0
// Checksum 0x23a87e6d, Offset: 0x41c0
// Size: 0x182
function function_b7b36dff() {
    battlechatter::function_d9f49fba(0);
    level flag::wait_till("arena_defend_common_elements_initialized");
    function_96944c1();
    load::function_a2995f22();
    util::screen_fade_out(0, "black", "skipto_fade");
    util::delay(2.5, undefined, &util::screen_fade_in, 1, "black", "skipto_fade");
    level thread namespace_a6a248fc::function_37e13caa();
    level scene::skipto_end("cin_ram_05_01_block_1st_rip", undefined, undefined, 0.75, 1);
    level thread function_27342097();
    level thread function_d8bb5a8e();
    battlechatter::function_d9f49fba(1);
    level flag::set("intro_igc_done");
    var_dfcbd82b = getnode("hendricks_mobile_wall_top_node", "targetname");
    level.var_2fd26037.goalradius = 64;
    level.var_2fd26037 colors::disable();
    level.var_2fd26037 setgoal(var_dfcbd82b, 1);
}

// Namespace arena_defend
// Params 2, eflags: 0x0
// Checksum 0xbfbea778, Offset: 0x4350
// Size: 0x19a
function function_c4fc0ade(var_d3c2655d, var_74cd64bc) {
    if (!level flag::get("arena_defend_common_elements_initialized")) {
        function_b6da2f7c();
        function_1a5a4627();
        ramses_util::function_f2f98cfc();
        vtol_igc::function_fc9630cb();
        function_c50ca91();
        if (var_d3c2655d !== "sinkhole_collapse") {
            function_f87b2c29();
        }
        function_f3aef8c7(var_d3c2655d, var_74cd64bc);
        level flag::set("arena_defend_common_elements_initialized");
        spawner::add_global_spawn_function("allies", &function_c23243fe);
        callback::on_spawned(&function_e377e915);
        array::run_all(getentarray("weak_point_trigger", "script_noteworthy"), &hide);
        ramses_util::function_3f4f84e("arena_defend_mobile_wall_top_nodes", "script_noteworthy", 0);
        getent("wp_crouch_cover", "targetname") movez(-200, 0.05);
    }
}

// Namespace arena_defend
// Params 4, eflags: 0x0
// Checksum 0xe6d045b6, Offset: 0x44f8
// Size: 0x22
function done(str_objective, var_74cd64bc, var_e4cd2b8b, player) {
    
}

// Namespace arena_defend
// Params 2, eflags: 0x0
// Checksum 0x213e5b7b, Offset: 0x4528
// Size: 0x72
function function_f3aef8c7(str_objective, var_74cd64bc) {
    function_e29f0dd6(str_objective, var_74cd64bc);
    level.var_9db406db colors::set_force_color("y");
    level.var_9db406db.goalradius = 1024;
    level.var_2fd26037 colors::set_force_color("b");
}

// Namespace arena_defend
// Params 0, eflags: 0x0
// Checksum 0xea30bbfd, Offset: 0x45a8
// Size: 0x1e2
function init_flags() {
    level flag::init("arena_defend_initial_spawns_done");
    level flag::init("all_spike_launchers_picked_up");
    level flag::init("billboard1_crashed");
    level flag::init("billboard2_crashed");
    level flag::init("sinkhole_explosion_started");
    level flag::init("sinkhole_collapse_complete");
    level flag::init("intro_technical_dropped_from_vtol");
    level flag::init("arena_defend_mobile_wall_deployed");
    level flag::init("arena_defend_mobile_wall_doors_open");
    level flag::init("arena_defend_intro_technical_disabled");
    level flag::init("arena_defend_initial_weak_point_search_finished");
    level flag::init("arena_defend_second_wave_weak_points_discovered");
    level flag::init("arena_defend_third_wave_weak_points_discovered");
    level flag::init("arena_defend_last_wave_weak_points_discovered");
    level flag::init("arena_defend_common_elements_initialized");
    level flag::init("arena_defend_sinkhole_igc_started");
    level flag::init("arena_defend_detonator_dropped");
    level flag::init("arena_defend_sinkhole_collapse_done");
    level flag::init("arena_defend_rocket_hits_vtol");
    level flag::init("arena_defend_detonator_pickup");
}

// Namespace arena_defend
// Params 2, eflags: 0x0
// Checksum 0x54ded5b6, Offset: 0x4798
// Size: 0xaa
function function_e29f0dd6(str_objective, var_74cd64bc) {
    if (var_74cd64bc) {
        level.var_2fd26037 = util::function_740f8516("hendricks");
        level.var_9db406db = util::function_740f8516("khalil");
    }
    skipto::teleport_ai(str_objective, level.heroes);
    if (isdefined(level.var_2fd26037)) {
        level.var_2fd26037 colors::enable();
    }
    if (isdefined(level.var_9db406db)) {
        level.var_9db406db colors::disable();
    }
}

// Namespace arena_defend
// Params 0, eflags: 0x0
// Checksum 0xd6aa6878, Offset: 0x4850
// Size: 0x4a
function function_1a5a4627() {
    level flag::set("flak_vtol_ride_stop");
    level thread ramses_util::function_a0731cf9();
    level thread ramses_util::function_37357151();
    level thread ramses_util::function_39044e10();
}

// Namespace arena_defend
// Params 0, eflags: 0x0
// Checksum 0x3ba81e8, Offset: 0x48a8
// Size: 0x56b
function function_b6da2f7c() {
    spawner::add_spawn_function_group("arena_defend_initial_enemies", "targetname", &function_fa6cb6a2);
    spawner::add_spawn_function_group("arena_defend_wall_jumper", "script_noteworthy", &function_58b8beac);
    spawner::add_spawn_function_group("arena_defend_cafe_defender_guys", "targetname", &function_e90b6d13);
    spawner::add_spawn_function_group("arena_defend_intro_wall_ally", "script_noteworthy", &function_e90b6d13);
    spawner::add_spawn_function_group("arena_defend_reset_anchor", "script_noteworthy", &function_e90b6d13);
    spawner::add_spawn_function_group("sp_wp_04_robot_defenders", "targetname", &function_cfffb0c2, "normal");
    spawner::add_spawn_function_group("sp_wp_04_robot_rushers", "targetname", &function_cfffb0c2, "rusher");
    level.var_1b7b3a6 = getweapon("spike_launcher");
    for (i = 1; i < 6; i++) {
        spawner::add_spawn_function_group("wp_0" + i + "_defenders", "targetname", &function_a275144c, "wp_0" + i + "_destroyed");
    }
    vehicle::add_spawn_function("checkpoint_right_fill_raps", &function_69b7b359);
    vehicle::add_spawn_function("checkpoint_right_breach_raps", &function_69b7b359);
    vehicle::add_spawn_function("arena_defend_quadtank", &function_9ec9caf9);
    vehicle::add_spawn_function("arena_defend_wall_vtol", &function_193cfd7e);
    vehicle::add_spawn_function("arena_defend_mobile_wall_turret", &function_ca365357);
    vehicle::add_spawn_function("arena_defend_intro_technical", &function_94c406b0, "arena_defend_intro_technical_disabled");
    vehicle::add_spawn_function("arena_defend_intro_technical", &function_90d92a9b, "cin_ram_05_01_defend_aie_nrc_exittruck_variation1", "arena_defend_mobile_wall_doors_open");
    vehicle::add_spawn_function("arena_defend_intro_technical", &function_c3bff305);
    vehicle::add_spawn_function("arena_defend_intro_technical", &function_165738b0);
    vehicle::add_spawn_function("arena_defend_technical_01", &function_165738b0);
    vehicle::add_spawn_function("arena_defend_technical_01", &function_90d92a9b, "cin_ram_05_01_defend_aie_nrc_exittruck_variation2", "reached_end_node");
    vehicle::add_spawn_function("arena_defend_technical_02", &function_90d92a9b, "cin_ram_05_01_defend_aie_nrc_exittruck_variation1", "reached_end_node");
    foreach (var_7b7d10ac in getentarray("arena_defend_technical", "script_noteworthy")) {
        vehicle::add_spawn_function(var_7b7d10ac.targetname, &function_7760068b);
        ramses_util::function_3f4f84e(var_7b7d10ac.targetname + "_vh_end", "targetname", 0);
    }
    var_b60b5e6b = getent("arena_defend_wasp_goal_volume", "targetname");
    foreach (sp_wasp in getentarray("arena_defend_wasp", "script_noteworthy")) {
        vehicle::add_spawn_function(sp_wasp.targetname, &function_68e4ea91, var_b60b5e6b);
    }
}

// Namespace arena_defend
// Params 0, eflags: 0x0
// Checksum 0xe9c07cd6, Offset: 0x4e20
// Size: 0x2
function function_c489f077() {
    
}

// Namespace arena_defend
// Params 0, eflags: 0x0
// Checksum 0xf50a8fcf, Offset: 0x4e30
// Size: 0xfa
function function_e90b6d13() {
    self endon(#"death");
    if (!level flag::get("arena_defend_mobile_wall_doors_open")) {
        self setgoal(getent("sinkhole_friendly_fallback_volume", "targetname"), 1);
    }
    level flag::wait_till("arena_defend_mobile_wall_doors_open");
    self clearforcedgoal();
    if (isdefined(self.target)) {
        e_goal = getent(self.target, "targetname");
        self setgoal(e_goal);
        return;
    }
    self setgoal(getent("arena_defend_main_goal_volume", "targetname"));
}

// Namespace arena_defend
// Params 1, eflags: 0x0
// Checksum 0x4fac2ba7, Offset: 0x4f38
// Size: 0x52
function function_a275144c(str_flag) {
    self endon(#"death");
    level flag::wait_till(str_flag);
    wait randomfloatrange(2, 8);
    self.goalradius = 1024;
    self cleargoalvolume();
}

// Namespace arena_defend
// Params 1, eflags: 0x0
// Checksum 0xd300c501, Offset: 0x4f98
// Size: 0xba
function function_cfffb0c2(var_6927be30) {
    self endon(#"death");
    var_5bd22e42 = getnode(self.target, "targetname");
    if (isdefined(var_5bd22e42)) {
        self ai::set_behavior_attribute("sprint", 1);
        self setgoal(var_5bd22e42, 1);
        self waittill(#"goal");
        self clearforcedgoal();
        self ai::set_behavior_attribute("move_mode", var_6927be30);
        self ai::set_behavior_attribute("sprint", 0);
    }
}

// Namespace arena_defend
// Params 0, eflags: 0x0
// Checksum 0x1672aeb2, Offset: 0x5060
// Size: 0x32
function function_fa6cb6a2() {
    self endon(#"death");
    level flag::wait_till("arena_defend_mobile_wall_doors_open");
    wait randomfloatrange(2, 3);
}

// Namespace arena_defend
// Params 0, eflags: 0x0
// Checksum 0xa3dea980, Offset: 0x50a0
// Size: 0x192
function function_9ec9caf9() {
    self endon(#"death");
    self cybercom::function_59965309("cybercom_hijack");
    level thread function_9b890ccb();
    waittillframeend();
    self ai::set_ignoreall(1);
    self ai::set_ignoreme(1);
    self.trophy_down = 1;
    self.var_de9eba31 = 999;
    self.var_a670ac2a = 1;
    self quadtank::function_4c6ee4cc(0);
    wait 1;
    while (!level flag::get("mobile_wall_doors_closing")) {
        e_player = util::get_closest_player(self.origin, "allies");
        a_targets = array::get_all_closest(e_player.origin, level.var_bbe9f011, undefined, 8);
        a_targets = array::randomize(a_targets);
        for (i = 0; i < 8; i++) {
            self function_4e77cd1b(a_targets[i]);
        }
        wait randomfloatrange(6, 8);
    }
    level flag::wait_till("arena_defend_sinkhole_collapse_done");
    self.delete_on_death = 1;
    self notify(#"death");
    if (!isalive(self)) {
        self delete();
    }
}

// Namespace arena_defend
// Params 1, eflags: 0x0
// Checksum 0xd83bf500, Offset: 0x5240
// Size: 0xa2
function function_4e77cd1b(e_target) {
    self endon(#"death");
    level endon(#"delete_javelins");
    weapon = getweapon("quadtank_main_turret_rocketpods_javelin");
    v_offset = (0, 0, 300);
    var_4d75b06 = magicbullet(weapon, self.origin + v_offset, e_target.origin, self, e_target);
    var_4d75b06 thread function_f1b4eb94("delete_javelins");
    wait 0.65;
}

// Namespace arena_defend
// Params 1, eflags: 0x0
// Checksum 0xa0cbe2, Offset: 0x52f0
// Size: 0x2a
function function_f1b4eb94(str_notify) {
    self endon(#"death");
    level waittill(str_notify);
    self delete();
}

// Namespace arena_defend
// Params 2, eflags: 0x0
// Checksum 0x66dace25, Offset: 0x5328
// Size: 0x271
function function_90d92a9b(str_scene, str_notify) {
    self endon(#"death");
    self.a_ents = spawner::simple_spawn("cinematic_technical_riders");
    self thread function_8efb2b2(self.a_ents);
    array::thread_all(self.a_ents, &function_faf9e017, "stop_ignoring_me");
    if (!isdefined(self.a_ents)) {
        self.a_ents = [];
    } else if (!isarray(self.a_ents)) {
        self.a_ents = array(self.a_ents);
    }
    self.a_ents[self.a_ents.size] = self;
    if (self.targetname == "arena_defend_technical_01_vh") {
        self thread function_11d73ca7(1);
        self thread function_3a136a27(1);
        level notify(#"hash_e75ae3d1");
    }
    if (self.targetname == "arena_defend_technical_02_vh") {
        self thread function_11d73ca7(2);
        self thread function_3a136a27(2);
        level notify(#"hash_e75ae3d1");
    }
    self.a_ents = array::remove_dead(self.a_ents);
    self thread scene::init(str_scene, self.a_ents);
    if (self.targetname == "arena_defend_intro_technical_vh") {
        level flag::wait_till(str_notify);
        wait 3;
    } else {
        self waittill(str_notify);
    }
    self.a_ents = array::remove_dead(self.a_ents);
    self thread scene::play(str_scene, self.a_ents);
    foreach (ent in self.a_ents) {
        if (isalive(ent)) {
            ent notify(#"stop_ignoring_me");
        }
    }
}

// Namespace arena_defend
// Params 1, eflags: 0x0
// Checksum 0xd3548c16, Offset: 0x55a8
// Size: 0x2a
function function_11d73ca7(number) {
    self endon(#"death");
    self playsound("evt_tech_driveup_" + number);
}

// Namespace arena_defend
// Params 1, eflags: 0x0
// Checksum 0xb4440885, Offset: 0x55e0
// Size: 0x32
function function_3a136a27(number) {
    self waittill(#"death");
    self stopsound("evt_tech_driveup_" + number);
}

// Namespace arena_defend
// Params 1, eflags: 0x0
// Checksum 0x2f53f9d8, Offset: 0x5620
// Size: 0x7b
function function_8efb2b2(riders) {
    self endon(#"hash_60ddc943");
    self waittill(#"death");
    foreach (rider in riders) {
        vehicle::kill_rider(rider);
    }
}

// Namespace arena_defend
// Params 1, eflags: 0x0
// Checksum 0x32017956, Offset: 0x56a8
// Size: 0x3a
function function_faf9e017(str_notify) {
    self endon(#"death");
    self ai::set_ignoreme(1);
    self waittill(str_notify);
    self ai::set_ignoreme(0);
}

// Namespace arena_defend
// Params 1, eflags: 0x0
// Checksum 0x9706b17d, Offset: 0x56f0
// Size: 0x62
function function_76dae413(str_notify) {
    self endon(#"death");
    self endon(#"hash_c3bff305");
    assert(isdefined(self.target), "<dev string:x28>" + self.origin + "<dev string:x34>");
    level waittill(str_notify);
    self thread vehicle::get_on_and_go_path(self.target);
}

// Namespace arena_defend
// Params 0, eflags: 0x0
// Checksum 0x2cfaaff8, Offset: 0x5760
// Size: 0x32
function function_165738b0() {
    self endon(#"death");
    self util::magic_bullet_shield();
    self waittill(#"reached_end_node");
    self util::stop_magic_bullet_shield();
}

// Namespace arena_defend
// Params 0, eflags: 0x0
// Checksum 0x5f7585f7, Offset: 0x57a0
// Size: 0xd2
function function_c3bff305() {
    self endon(#"death");
    wait 0.1;
    self notify(#"hash_c3bff305");
    for (nd_target = getvehiclenode(self.target, "targetname"); isdefined(nd_target.target); nd_target = getvehiclenode(nd_target.target, "targetname")) {
    }
    self.origin = nd_target.origin;
    self.angles = nd_target.angles;
    self notify(#"reached_end_node");
    if (self flag::exists("warp_to_spline_end_done")) {
        self flag::set("warp_to_spline_end_done");
    }
}

// Namespace arena_defend
// Params 0, eflags: 0x0
// Checksum 0xb3ca97a7, Offset: 0x5880
// Size: 0x11a
function function_c23243fe() {
    self endon(#"death");
    self endon(#"hash_4eb74b10");
    if (!isdefined(level.var_d1931a26)) {
        level.var_d1931a26 = [];
    }
    var_ce9b528b = function_39f34f22();
    var_8c01780a = var_ce9b528b > level.var_d1931a26.size && self function_e238fc60() && !self util::is_hero();
    if (var_8c01780a) {
        if (!isdefined(level.var_d1931a26)) {
            level.var_d1931a26 = [];
        } else if (!isarray(level.var_d1931a26)) {
            level.var_d1931a26 = array(level.var_d1931a26);
        }
        level.var_d1931a26[level.var_d1931a26.size] = self;
        self util::magic_bullet_shield(self);
        level waittill(#"sinkhole_charges_detonated");
        arrayremovevalue(level.var_d1931a26, self, 0);
        self util::stop_magic_bullet_shield(self);
    }
}

// Namespace arena_defend
// Params 0, eflags: 0x0
// Checksum 0x7b2ecb61, Offset: 0x59a8
// Size: 0x18
function function_39f34f22() {
    var_ce9b528b = 5 - level.players.size;
    return var_ce9b528b;
}

// Namespace arena_defend
// Params 0, eflags: 0x0
// Checksum 0xbd2af5ac, Offset: 0x59c8
// Size: 0x21
function function_f11b462a() {
    return isdefined(level.var_d1931a26) && isinarray(level.var_d1931a26, self);
}

// Namespace arena_defend
// Params 0, eflags: 0x0
// Checksum 0xedd31823, Offset: 0x59f8
// Size: 0x163
function function_e238fc60() {
    if (!self colors::has_color()) {
        var_9b5d33d6 = 0;
    } else {
        var_88c66c67 = self.script_forcecolor;
        var_9f50f457 = function_39f34f22();
        var_9b05e0cb = ceil(var_9f50f457 / 2);
        var_9b96ccff = var_9f50f457 - var_9b05e0cb;
        var_e144c878 = 0;
        var_2cc8e8ec = 0;
        foreach (ai_guy in level.var_d1931a26) {
            if (isdefined(ai_guy)) {
                if (ai_guy.script_forcecolor == "b") {
                    var_e144c878++;
                    continue;
                }
                if (ai_guy.script_forcecolor == "y") {
                    var_2cc8e8ec++;
                }
            }
        }
        if (var_e144c878 < var_9b05e0cb && var_88c66c67 == "b") {
            var_9b5d33d6 = 1;
        } else if (var_2cc8e8ec < var_9b96ccff && var_88c66c67 == "y") {
            var_9b5d33d6 = 1;
        } else {
            var_9b5d33d6 = 0;
        }
    }
    return var_9b5d33d6;
}

// Namespace arena_defend
// Params 0, eflags: 0x0
// Checksum 0x5a99a026, Offset: 0x5b68
// Size: 0x9a
function function_e377e915() {
    if (!isdefined(level.var_d1931a26)) {
        level.var_d1931a26 = [];
    }
    var_ce9b528b = function_39f34f22();
    if (level.var_d1931a26.size > var_ce9b528b) {
        ai_guy = array::random(level.var_d1931a26);
        arrayremovevalue(level.var_d1931a26, ai_guy, 0);
        if (isalive(ai_guy)) {
            ai_guy util::stop_magic_bullet_shield();
        }
    }
}

// Namespace arena_defend
// Params 1, eflags: 0x0
// Checksum 0xea1deb17, Offset: 0x5c10
// Size: 0x102
function function_94c406b0(str_flag) {
    self endon(#"death");
    self thread function_275dd5bc(str_flag);
    while (!self flag::exists("spawned_gunner")) {
        wait 1;
    }
    self flag::wait_till("spawned_gunner");
    ai_rider = self vehicle::function_ad4ec07a("gunner1");
    if (isalive(ai_rider)) {
        ai_rider ai::set_ignoreme(1);
    }
    level flag::wait_till("arena_defend_mobile_wall_doors_open");
    if (isalive(ai_rider)) {
        ai_rider ai::set_ignoreme(0);
        ai_rider waittill(#"death");
    }
    wait 8;
    level flag::set(str_flag);
}

// Namespace arena_defend
// Params 1, eflags: 0x0
// Checksum 0x33f8172, Offset: 0x5d20
// Size: 0x2a
function function_275dd5bc(str_flag) {
    self waittill(#"death");
    level flag::set(str_flag);
}

// Namespace arena_defend
// Params 1, eflags: 0x0
// Checksum 0xe27265b9, Offset: 0x5d58
// Size: 0x2a
function function_68e4ea91(var_ab891f49) {
    self endon(#"death");
    if (isdefined(var_ab891f49)) {
        self setgoal(var_ab891f49);
    }
}

// Namespace arena_defend
// Params 0, eflags: 0x0
// Checksum 0x26948e90, Offset: 0x5d90
// Size: 0x19e
function function_7760068b() {
    self endon(#"death");
    self thread function_53da0c94();
    self flag::init("spawned_gunner");
    self flag::init("gunner_position_occupied");
    var_dfb53de7 = self function_1a304c27();
    var_44762fa4 = self function_9f43307f();
    var_dfb53de7 thread function_ac6832c4(self);
    self thread function_9590665a();
    self thread function_3a5cbbb7();
    self makevehicleusable();
    self setseatoccupied(0, 1);
    if (self flag::exists("warp_to_spline_end_done")) {
        self flag::wait_till("warp_to_spline_end_done");
    } else {
        self waittill(#"reached_end_node");
    }
    v_end_pos = self.origin;
    v_end_angles = self.angles;
    level notify(self.targetname + "_reached_end_node");
    self vehicle::get_off_path();
    wait 0.05;
    if (isalive(var_44762fa4)) {
        var_44762fa4 vehicle::get_out();
    }
    self waittill(#"death");
    self.origin = v_end_pos;
    self.angles = v_end_angles;
}

// Namespace arena_defend
// Params 0, eflags: 0x0
// Checksum 0x7de82c22, Offset: 0x5f38
// Size: 0x4a
function function_53da0c94() {
    self.no_free_on_death = 1;
    level waittill(#"hash_9919d3c1");
    if (isdefined(self)) {
        self launchvehicle((0, 0, 100));
    }
    level clientfield::increment("clear_all_dyn_ents", 1);
}

// Namespace arena_defend
// Params 1, eflags: 0x0
// Checksum 0x27a7cf4d, Offset: 0x5f90
// Size: 0x1bd
function function_3a5cbbb7(var_72ffe0f4) {
    if (!isdefined(var_72ffe0f4)) {
        var_72ffe0f4 = 0;
    }
    self endon(#"death");
    self turret::set_burst_parameters(1, 2, 0.25, 0.75, 1);
    while (true) {
        var_dfb53de7 = self vehicle::function_ad4ec07a("gunner1");
        if (isdefined(var_dfb53de7)) {
            self turret::enable(1, 1);
            self flag::set("gunner_position_occupied");
            var_dfb53de7 waittill(#"death");
        }
        self turret::disable(1);
        self flag::clear("gunner_position_occupied");
        if (var_72ffe0f4) {
            wait randomfloatrange(5, 8);
            if (self function_a13e19b7()) {
                var_753bd441 = self function_ceda4e5b();
                if (isalive(var_753bd441)) {
                    /#
                        var_753bd441 thread function_569cfe0c(self);
                    #/
                    var_753bd441 thread vehicle::get_in(self, "gunner1", 0);
                    var_753bd441 util::waittill_any("death", "in_vehicle");
                }
            }
            continue;
        }
        break;
    }
}

// Namespace arena_defend
// Params 0, eflags: 0x0
// Checksum 0xd12d26aa, Offset: 0x6158
// Size: 0x10f
function function_ceda4e5b() {
    a_ai = getaiteamarray(self.team);
    a_valid = [];
    foreach (ai_guy in a_ai) {
        if (!isdefined(ai_guy.vehicle) && ai_guy.archetype === "human") {
            if (!isdefined(a_valid)) {
                a_valid = [];
            } else if (!isarray(a_valid)) {
                a_valid = array(a_valid);
            }
            a_valid[a_valid.size] = ai_guy;
        }
    }
    var_dfb53de7 = arraysort(a_valid, self.origin, 1, a_ai.size, 800)[0];
    return var_dfb53de7;
}

// Namespace arena_defend
// Params 0, eflags: 0x0
// Checksum 0x555753ac, Offset: 0x6270
// Size: 0x84
function function_a13e19b7() {
    a_enemies = getaiteamarray(get_enemy_team(self.team));
    var_eb61c3d3 = arraysort(a_enemies, self.origin, 1, a_enemies.size, 300);
    var_eeec5f70 = var_eb61c3d3.size > 0;
    var_93b5fb30 = !var_eeec5f70;
    return var_93b5fb30;
}

// Namespace arena_defend
// Params 1, eflags: 0x0
// Checksum 0x29ce926d, Offset: 0x6300
// Size: 0x76
function get_enemy_team(str_team) {
    if (str_team == "axis") {
        var_d08b8571 = "allies";
    } else if (str_team == "allies") {
        var_d08b8571 = "axis";
    } else {
        assertmsg("<dev string:x7e>" + str_team + "<dev string:xa2>");
        var_d08b8571 = "none";
    }
    return var_d08b8571;
}

// Namespace arena_defend
// Params 1, eflags: 0x0
// Checksum 0xc5d9e263, Offset: 0x6380
// Size: 0x5d
function function_569cfe0c(vehicle) {
    self endon(#"death");
    self endon(#"in_vehicle");
    vehicle endon(#"death");
    while (true) {
        /#
            line(self.origin, vehicle.origin, (1, 0, 0), 1, 0, 1);
        #/
        wait 0.05;
    }
}

// Namespace arena_defend
// Params 0, eflags: 0x0
// Checksum 0x735289e4, Offset: 0x63e8
// Size: 0x22
function function_9590665a() {
    self endon(#"death");
    self waittill(#"kill_passengers");
    self kill();
}

// Namespace arena_defend
// Params 1, eflags: 0x0
// Checksum 0xde9ddb51, Offset: 0x6418
// Size: 0x5a
function function_ac6832c4(var_35a302af) {
    self waittill(#"death");
    if (isdefined(self)) {
        self unlink();
    }
    if (isdefined(var_35a302af)) {
        if (!vehicle::is_corpse(var_35a302af)) {
            var_35a302af turret::disable(1);
        }
    }
}

// Namespace arena_defend
// Params 1, eflags: 0x0
// Checksum 0xc3ac77d6, Offset: 0x6480
// Size: 0x62
function function_837889c6(var_35a302af) {
    self endon(#"death");
    var_35a302af util::waittill_either("death", "kill_passengers");
    self util::stop_magic_bullet_shield();
    self unlink();
    self kill();
}

// Namespace arena_defend
// Params 0, eflags: 0x0
// Checksum 0x366c37cd, Offset: 0x64f0
// Size: 0x5c
function function_1a304c27() {
    var_dfb53de7 = spawner::simple_spawn_single("arena_defend_technical_gunner_generic");
    var_dfb53de7 vehicle::get_in(self, "gunner1", 1);
    self flag::set("spawned_gunner");
    return var_dfb53de7;
}

// Namespace arena_defend
// Params 0, eflags: 0x0
// Checksum 0xd6f1c7cb, Offset: 0x6558
// Size: 0x44
function function_9f43307f() {
    var_44762fa4 = spawner::simple_spawn_single("arena_defend_technical_driver_generic");
    var_44762fa4 vehicle::get_in(self, "driver", 1);
    return var_44762fa4;
}

// Namespace arena_defend
// Params 0, eflags: 0x0
// Checksum 0x384f7d41, Offset: 0x65a8
// Size: 0x3a
function function_193cfd7e() {
    vnd_start = getvehiclenode(self.target, "targetname");
    vehicle::get_on_and_go_path(vnd_start);
}

// Namespace arena_defend
// Params 0, eflags: 0x0
// Checksum 0x4fce0fe5, Offset: 0x65f0
// Size: 0x12
function function_ca365357() {
    self.team = "allies";
}

// Namespace arena_defend
// Params 0, eflags: 0x0
// Checksum 0x3de478de, Offset: 0x6610
// Size: 0x1a
function function_345b912d() {
    trigger::use("arena_defend_colors_allies_behind_mobile_wall");
}

// Namespace arena_defend
// Params 1, eflags: 0x0
// Checksum 0x76b1760c, Offset: 0x6638
// Size: 0x22
function function_f74d43a6(var_a9441d81) {
    trigger::use("arena_defend_color_allies_" + var_a9441d81);
}

// Namespace arena_defend
// Params 0, eflags: 0x0
// Checksum 0x65861dbc, Offset: 0x6668
// Size: 0x1a
function function_8bcd7f99() {
    function_f74d43a6("wp_02_03");
}

// Namespace arena_defend
// Params 0, eflags: 0x0
// Checksum 0x8f5493b7, Offset: 0x6690
// Size: 0x2a
function function_5f3c9cc9() {
    function_f74d43a6("wp_04");
    level thread function_7b619b56();
}

// Namespace arena_defend
// Params 0, eflags: 0x0
// Checksum 0x73ac6b07, Offset: 0x66c8
// Size: 0x102
function function_ce07d8df() {
    level waittill(#"hash_18cf70dc");
    spawner::add_spawn_function_group("detonation_guy", "targetname", &function_eb0491d7);
    level scene::init("cin_ram_05_demostreet_vign_intro_detonation_guy");
    level.var_2fd26037.goalradius = 32;
    var_76be17b8 = getnode("hendricks_mobile_wall_start_node", "targetname");
    level.var_2fd26037 thread ai::force_goal(var_76be17b8, 32, 1, undefined, 1);
    level.var_9db406db.goalradius = 32;
    var_f47e732e = getnode("arena_defend_demostreet_intro_khalil", "targetname");
    level.var_9db406db thread ai::force_goal(var_f47e732e, 32, 1, undefined, 1);
}

// Namespace arena_defend
// Params 0, eflags: 0x0
// Checksum 0x97c1ad4b, Offset: 0x67d8
// Size: 0x1a
function function_7b619b56() {
    level scene::init("cin_gen_melee_hendricksmoment_closecombat_robot");
}

// Namespace arena_defend
// Params 0, eflags: 0x0
// Checksum 0xea40edaa, Offset: 0x6800
// Size: 0x3c1
function function_5c0d1d04() {
    var_dada6931 = getnodearray("arena_defend_wasp_vignette_nodes", "script_noteworthy");
    assert(var_dada6931.size, "<dev string:xa5>");
    var_1146278c = var_dada6931.size;
    var_cb121782 = [];
    for (i = 0; i < var_dada6931.size; i++) {
        ai_guy = spawner::simple_spawn_single("arena_defend_wasp_vignette_friendly");
        if (!isdefined(var_cb121782)) {
            var_cb121782 = [];
        } else if (!isarray(var_cb121782)) {
            var_cb121782 = array(var_cb121782);
        }
        var_cb121782[var_cb121782.size] = ai_guy;
        ai_guy ai::set_ignoreme(1);
        wait 2.5;
    }
    while (var_cb121782.size != var_dada6931.size) {
        wait 1;
        var_ac8ea4f8 = getaispeciesarray("allies", "human");
        var_ac8ea4f8 = arraysortclosest(var_ac8ea4f8, var_dada6931[0].origin, var_ac8ea4f8.size);
        var_cb121782 = [];
        foreach (ai_guy in var_ac8ea4f8) {
            var_1fc6c9ef = !ai_guy util::is_hero() && !ai_guy function_f11b462a() && !ai_guy isinscriptedstate();
            if (var_1fc6c9ef) {
                if (!isdefined(var_cb121782)) {
                    var_cb121782 = [];
                } else if (!isarray(var_cb121782)) {
                    var_cb121782 = array(var_cb121782);
                }
                var_cb121782[var_cb121782.size] = ai_guy;
                ai_guy ai::set_ignoreme(1);
            }
            if (var_cb121782.size == var_1146278c) {
                break;
            }
        }
    }
    for (i = 0; i < var_cb121782.size; i++) {
        if (isalive(var_cb121782[i])) {
            var_cb121782[i].goalradius = 64;
            var_cb121782[i] thread ai::force_goal(var_dada6931[i], 64, 0, "goal", 0, 1);
            self thread function_5b77431d(var_cb121782[i]);
        }
    }
    var_1a1ffb1e = 0;
    do {
        self waittill(#"hash_65974e40");
        var_1a1ffb1e++;
    } while (var_1a1ffb1e < var_cb121782.size);
    function_87d41f89();
    foreach (ai_guy in var_cb121782) {
        if (isalive(ai_guy)) {
            ai_guy ai::set_ignoreme(0);
        }
    }
    for (j = 0; j < 2; j++) {
        vh_wasp = spawner::simple_spawn_single("arena_defend_vignette_wasp");
        vh_wasp thread function_2047b562(var_cb121782, j);
        wait 0.5;
    }
}

// Namespace arena_defend
// Params 0, eflags: 0x0
// Checksum 0x96d0d9b4, Offset: 0x6bd0
// Size: 0x22
function function_87d41f89() {
    level endon(#"all_weak_points_destroyed");
    trigger::wait_till("arena_defend_wasp_vignette_trigger");
}

// Namespace arena_defend
// Params 2, eflags: 0x0
// Checksum 0xae0ef747, Offset: 0x6c00
// Size: 0x272
function function_2047b562(a_targets, n_path) {
    self endon(#"death");
    self ai::set_ignoreall(1);
    self ai::set_ignoreme(1);
    self setneargoalnotifydist(300);
    var_1382d11e = getvehiclenode("arena_defend_wasp_vignette_path" + n_path, "targetname");
    assert(isdefined(var_1382d11e), "<dev string:xfc>" + n_path + "<dev string:x11c>");
    self vehicle_ai::start_scripted();
    self vehicle::get_on_and_go_path(var_1382d11e);
    self util::waittill_any_timeout(6, "reached_end_node");
    self vehicle_ai::stop_scripted("combat");
    foreach (ai_guy in a_targets) {
        if (isdefined(ai_guy) && isalive(ai_guy)) {
            self setgoal(ai_guy);
            ai_guy util::stop_magic_bullet_shield();
            if (isdefined(ai_guy) && isalive(ai_guy)) {
                ai_guy.health = 1;
                self thread ai::shoot_at_target("shoot_until_target_dead", ai_guy);
                ai_guy util::waittill_any("death", "pain");
                if (isalive(ai_guy)) {
                    ai_guy kill();
                }
                wait 2;
            }
        }
    }
    self ai::set_ignoreall(0);
    self ai::set_ignoreme(0);
    arena_defend_wasp_goal_volume = getent("arena_defend_wasp_goal_volume", "targetname");
    self setgoal(arena_defend_wasp_goal_volume, 1);
}

// Namespace arena_defend
// Params 1, eflags: 0x0
// Checksum 0x24fa601e, Offset: 0x6e80
// Size: 0x47
function function_5b77431d(ai_guy) {
    str_message = ai_guy util::waittill_any_timeout(15, "goal", "near_goal", "death");
    self notify(#"hash_65974e40");
}

// Namespace arena_defend
// Params 6, eflags: 0x0
// Checksum 0xc65f6e01, Offset: 0x6ed0
// Size: 0x1f4
function function_448954e7(str_type, str_faction, var_6a4360e2, var_fa152ffe, var_8f89056b, var_ff46257e) {
    if (!isdefined(var_8f89056b)) {
        var_8f89056b = 0;
    }
    if (!isdefined(var_ff46257e)) {
        var_ff46257e = 1;
    }
    var_9de10fe3 = getnode(var_6a4360e2, "targetname");
    do {
        a_ai = getaispeciesarray(str_faction, str_type);
        var_bb54a372 = arraysortclosest(a_ai, var_9de10fe3.origin, a_ai.size, var_8f89056b, var_fa152ffe);
        foreach (ai in a_ai) {
            if (ai util::is_hero() || ai function_f11b462a()) {
                arrayremovevalue(var_bb54a372, ai, 0);
            }
        }
        if (var_bb54a372.size > 0) {
            ai_guy = var_bb54a372[0];
            continue;
        }
        wait 1;
    } while (!isdefined(ai_guy));
    ai_guy.goalradius = 32;
    b_shoot = 0;
    str_endon = undefined;
    b_keep_colors = 0;
    b_should_sprint = 1;
    if (!var_ff46257e) {
        ai_guy.var_69dd5d62 = 0;
    }
    ai_guy thread ai::force_goal(var_9de10fe3, 32, b_shoot, str_endon, b_keep_colors, b_should_sprint);
    ai_guy util::waittill_any_timeout(15, "goal", "death");
    return ai_guy;
}

// Namespace arena_defend
// Params 0, eflags: 0x0
// Checksum 0x39cdccab, Offset: 0x70d0
// Size: 0xa2
function function_3c00dec() {
    var_35a302af = vehicle::simple_spawn_single("arena_defend_intro_technical");
    var_35a302af flag::init("warp_to_spline_end_done");
    while (!var_35a302af turret::is_turret_enabled(1)) {
        wait 0.25;
    }
    var_35a302af turret::disable(1);
    level waittill(#"arena_defend_intro_player_exits_technical");
    level scene::play("cin_ram_05_02_block_vign_mowed");
    var_35a302af turret::enable(1, 1);
}

// Namespace arena_defend
// Params 1, eflags: 0x0
// Checksum 0xa6d6ef4f, Offset: 0x7180
// Size: 0x112
function function_18767202(a_ents) {
    var_35a302af = getent("arena_defend_intro_technical_vh", "targetname");
    var_44dee395 = getent("so_arena_defend_intro_turret_target", "targetname");
    foreach (ent in a_ents) {
        if (isai(ent) && isalive(ent)) {
            ent util::stop_magic_bullet_shield();
        }
    }
    if (isdefined(var_35a302af) && isdefined(var_44dee395)) {
        var_35a302af thread turret::shoot_at_target(var_44dee395, 10, (0, 0, 0), 1, 0);
    }
}

// Namespace arena_defend
// Params 0, eflags: 0x0
// Checksum 0xc9a1f8eb, Offset: 0x72a0
// Size: 0xa2
function function_f5350035() {
    self endon(#"death");
    self thread function_cb9acce5();
    self ai::set_ignoreme(1);
    var_9cead347 = getnode("node_spike_launch_start", "targetname");
    self ai::force_goal(var_9cead347, 8, 1, "goal");
    self.goalradius = 8;
    wait 5;
    self ai::set_ignoreme(0);
    wait 5;
    self.goalradius = 512;
}

// Namespace arena_defend
// Params 0, eflags: 0x0
// Checksum 0x720756e8, Offset: 0x7350
// Size: 0xc
function function_cb9acce5() {
    self waittill(#"death");
}

// Namespace arena_defend
// Params 0, eflags: 0x0
// Checksum 0xd9ead712, Offset: 0x7368
// Size: 0x17d
function function_9b890ccb() {
    level endon(#"mobile_wall_doors_closing");
    level.var_bbe9f011 = getentarray("arena_defend_tank_target_e3", "targetname");
    var_140621eb = [];
    foreach (target in level.var_bbe9f011) {
        mdl_target = spawn("script_model", target.origin);
        mdl_target.angles = target.angles;
        mdl_target.script_objective = "sinkhole_collapse";
        mdl_target setmodel("tag_origin");
        util::wait_network_frame();
        if (!isdefined(var_140621eb)) {
            var_140621eb = [];
        } else if (!isarray(var_140621eb)) {
            var_140621eb = array(var_140621eb);
        }
        var_140621eb[var_140621eb.size] = mdl_target;
    }
    while (true) {
        level waittill(#"player_spawned");
        level.var_bbe9f011 = arraycombine(level.activeplayers, level.var_bbe9f011, 0, 0);
    }
}

// Namespace arena_defend
// Params 0, eflags: 0x0
// Checksum 0x327a3938, Offset: 0x74f0
// Size: 0x152
function function_d8bb5a8e() {
    level endon(#"arena_defend_initial_spawns_done");
    level flag::wait_till("all_players_connected");
    spawn_manager::enable("sm_arena_defend_initial_enemies");
    spawn_manager::enable("sm_arena_defend_initial_rear");
    spawner::simple_spawn("arena_defend_initial_right_building");
    util::wait_network_frame();
    spawn_manager::enable("arena_defend_wall_allies");
    spawn_manager::enable("arena_defend_wall_allies2");
    spawn_manager::enable("arena_defend_bldg_allies");
    spawn_manager::enable("arena_defend_cafe_defenders");
    level thread util::delay(7, undefined, &function_345b912d);
    level thread util::delay(7, undefined, &flag::set, "arena_defend_initial_spawns_done");
    spawn_manager::wait_till_complete("sm_arena_defend_initial_enemies");
    level flag::set("arena_defend_initial_spawns_done");
}

// Namespace arena_defend
// Params 0, eflags: 0x0
// Checksum 0x9817f06d, Offset: 0x7650
// Size: 0x132
function function_f4554829() {
    var_dfcbd82b = getnode("hendricks_mobile_wall_top_node", "targetname");
    level.var_2fd26037.goalradius = 64;
    level.var_2fd26037 colors::disable();
    ramses_util::function_3f4f84e("arena_defend_mobile_wall_top_nodes", "script_noteworthy", 1);
    level.var_2fd26037 setgoal(var_dfcbd82b, 1);
    level.var_2fd26037 util::waittill_notify_or_timeout("goal", 15);
    level flag::wait_till("arena_defend_intro_technical_disabled");
    spawn_manager::enable("sm_wp_01_defenders");
    wait 4;
    function_c693a390();
    wait 2;
    level thread function_f74d43a6("wp_01");
    trigger::use("arena_defend_tech_1_trig", "targetname", undefined, 0);
    function_c661367c();
}

// Namespace arena_defend
// Params 0, eflags: 0x0
// Checksum 0x7ceb0165, Offset: 0x7790
// Size: 0x172
function function_da99ce30() {
    spawn_manager::kill("sm_wp_01_defenders");
    spawn_manager::enable("sm_wp_02_defenders");
    util::wait_network_frame();
    spawn_manager::enable("arena_defend_push_wasps");
    util::wait_network_frame();
    var_2d3d7b7 = [];
    var_2d3d7b7[0] = "esl4_hostile_grunts_movin_0";
    var_2d3d7b7[1] = "esl3_enemy_grunts_breakin_0";
    var_2d3d7b7[2] = "esl4_hostile_grunts_at_so_0";
    ai_guy = function_6f24118d();
    ai_guy thread dialog::say(function_7ff50323(var_2d3d7b7));
    if (!level flag::get("billboard1_crashed")) {
        spawn_manager::enable("sm_arena_defend_snipers_center_building");
        if (level.players.size > 1) {
            var_2d3d7b7 = [];
            var_2d3d7b7[0] = "esl1_sniper_on_the_roof_0";
            var_2d3d7b7[1] = "egy2_i_have_an_enemy_snip_0";
            ai_guy = function_6f24118d();
            ai_guy thread dialog::say(function_7ff50323(var_2d3d7b7), 2);
        }
    }
}

// Namespace arena_defend
// Params 0, eflags: 0x0
// Checksum 0x5f64708, Offset: 0x7910
// Size: 0x62
function function_44a7ad7b() {
    trigger::wait_or_timeout(15, "wp_03_goal_trig", "targetname");
    spawn_manager::enable("sm_wp_03_defenders_jumpers");
    spawn_manager::enable("arena_defend_robot_fill");
    function_60f90684();
}

// Namespace arena_defend
// Params 0, eflags: 0x0
// Checksum 0x498e9316, Offset: 0x7980
// Size: 0xfa
function function_58b8beac() {
    self endon(#"death");
    self.ignoreall = 1;
    var_d403d38a = randomintrange(1, 5);
    var_a688f237 = "scene_wall_left_jumpover_up_0" + var_d403d38a;
    var_432b4304 = "scene_wall_left_jumpover_down_0" + var_d403d38a;
    level scene::skipto_end(var_a688f237, "targetname", self, 0.5);
    level scene::play(var_432b4304, self);
    self.ignoreall = 0;
    self ai::set_behavior_attribute("move_mode", "rusher");
    if (isdefined(self.target)) {
        e_goal = getent(self.target, "targetname");
        self setgoal(e_goal, 1);
    }
}

// Namespace arena_defend
// Params 0, eflags: 0x0
// Checksum 0xb98a5ec6, Offset: 0x7a88
// Size: 0xa2
function function_8790f24e() {
    spawn_manager::enable("sm_arena_defend_fill_middle");
    spawn_manager::enable("sm_arena_defend_fill_middle_wasps");
    level util::delay(15, undefined, &flag::set, "arena_defend_second_wave_weak_points_discovered");
    spawner::waittill_ai_group_amount_killed("arena_defend_fill_middle", 3);
    level flag::set("arena_defend_second_wave_weak_points_discovered");
    spawn_manager::enable("sm_wp_03_defenders");
}

// Namespace arena_defend
// Params 0, eflags: 0x0
// Checksum 0x5d2ce7e, Offset: 0x7b38
// Size: 0x5a
function function_ad936cb7() {
    level util::delay(20, undefined, &flag::set, "arena_defend_third_wave_weak_points_discovered");
    spawner::waittill_ai_group_amount_killed("arena_defend_checkpoint_breach_enemies", 30);
    level flag::set("arena_defend_third_wave_weak_points_discovered");
}

// Namespace arena_defend
// Params 0, eflags: 0x0
// Checksum 0x1d71e6b1, Offset: 0x7ba0
// Size: 0x9a
function function_f5261dec() {
    level flag::wait_till_all(array("wp_01_destroyed", "wp_02_destroyed", "wp_03_destroyed", "wp_05_destroyed"));
    level thread dialog::remote("kane_one_more_0", 1);
    wait 3;
    playsoundatposition("veh_quadtank_alarm_cinematic", (4847, -25831, 566));
    level flag::set("arena_defend_last_wave_weak_points_discovered");
}

// Namespace arena_defend
// Params 0, eflags: 0x0
// Checksum 0x23714736, Offset: 0x7c48
// Size: 0x202
function function_7cc654ff() {
    level thread function_d8e5f873();
    level thread function_19751093();
    level thread ramses_util::function_e7fdcb95("checkpoint_wall_phalanx", "phalanx_column", 4, 1, 10, undefined, 1, "arena_defend_wave_02b_phalanx", "script_noteworthy", 2);
    spawn_manager::enable("sm_arena_defend_center_fill_right");
    level util::waittill_notify_or_timeout("checkpoint_wall_breach_complete", 20);
    spawn_manager::kill("sm_wp_03_defenders_jumpers");
    spawn_manager::kill("sm_arena_defend_fill_middle");
    spawn_manager::kill("sm_arena_defend_fill_middle_wasps");
    trigger::use("arena_defend_tech_2_trig", "targetname");
    wait 5;
    spawn_manager::enable("arena_defend_far_left_enemies");
    spawn_manager::enable("sm_arena_defend_center_fill_left");
    spawn_manager::enable("sm_wp_05_defenders");
    wait 5;
    function_f74d43a6("wp_05");
    level util::waittill_notify_or_timeout("arena_defend_technical_02_vh_reached_end_node", 10);
    wait 5;
    if (!level flag::get("billboard1_crashed")) {
        spawn_manager::enable("arena_defend_snipers_02");
        var_2d3d7b7 = [];
        var_2d3d7b7[0] = "esl1_sniper_on_the_roof_0";
        var_2d3d7b7[1] = "egy2_i_have_an_enemy_snip_0";
        ai_guy = function_6f24118d();
        ai_guy thread dialog::say(function_7ff50323(var_2d3d7b7), 2);
    }
}

// Namespace arena_defend
// Params 0, eflags: 0x0
// Checksum 0x1370783e, Offset: 0x7e58
// Size: 0xca
function function_30f53fbc() {
    spawn_manager::function_41cd3a68(25);
    level thread function_2c83fc3f();
    spawn_manager::enable("arena_defend_push_enemies");
    util::wait_network_frame();
    spawn_manager::enable("arena_defend_push_wasps");
    util::wait_network_frame();
    if (!level flag::get("billboard1_crashed")) {
        spawn_manager::enable("arena_defend_snipers_03");
        util::wait_network_frame();
    }
    spawn_manager::enable("arena_defend_heavy_units");
}

// Namespace arena_defend
// Params 0, eflags: 0x0
// Checksum 0x9bc208b6, Offset: 0x7f30
// Size: 0x35
function function_2c83fc3f() {
    level thread function_e21c0d4f("checkpoint_wall_phalanx_right");
    wait 2;
    level thread function_e21c0d4f("checkpoint_wall_phalanx");
    wait 2;
}

// Namespace arena_defend
// Params 1, eflags: 0x0
// Checksum 0x6e34960a, Offset: 0x7f70
// Size: 0xdd
function function_e21c0d4f(var_2c34daa1) {
    level endon(#"arena_defend_detonator_pickup");
    v_start = struct::get(var_2c34daa1 + "_start").origin;
    v_end = struct::get(var_2c34daa1 + "_end").origin;
    var_4720665e = 0;
    while (true) {
        var_4720665e++;
        var_27aba1a0 = 2;
        var_a3decff = new robotphalanx();
        [[ var_a3decff ]]->initialize("phalanx_column", v_start, v_end, var_27aba1a0, var_27aba1a0);
        do {
            wait 0.25;
        } while (isdefined(var_a3decff) && var_a3decff.scattered_ == 0);
        wait 5;
    }
}

// Namespace arena_defend
// Params 1, eflags: 0x0
// Checksum 0xe1a96ffb, Offset: 0x8058
// Size: 0xb3
function function_2fcc9369(str_script_noteworthy) {
    var_2b309d3d = getentarray(str_script_noteworthy, "script_noteworthy");
    foreach (var_df3a43de in var_2b309d3d) {
        if (isdefined(var_df3a43de.name)) {
            str_name = var_df3a43de.name;
        } else {
            str_name = var_df3a43de.targetname;
        }
        spawn_manager::kill(str_name);
    }
}

// Namespace arena_defend
// Params 0, eflags: 0x0
// Checksum 0x83769e5c, Offset: 0x8118
// Size: 0x27a
function function_cac20541() {
    level flag::wait_till("weak_points_objective_active");
    var_f6a86bdd = function_785a0ed();
    foreach (wave in var_f6a86bdd) {
        foreach (var_20488710 in wave) {
            if (isdefined(var_20488710.var_2f201aa5)) {
                level flag::wait_till_all(var_20488710.var_2f201aa5);
            }
            level flag::set(var_20488710.var_672c6068 + "_identified");
            if (isdefined(var_20488710.var_13c6e56)) {
                foreach (var_13c6e56 in var_20488710.var_13c6e56) {
                    level thread [[ var_13c6e56 ]]();
                }
            }
            if (isdefined(var_20488710.var_26323261)) {
                foreach (var_26323261 in var_20488710.var_26323261) {
                    level thread ramses_util::function_cf956358(var_20488710.var_672c6068 + "_destroyed", var_26323261);
                }
            }
        }
    }
    streamerrequest("set", "cp_mi_cairo_ramses2_sinkhole_collapse");
    function_3e55e3();
    level thread namespace_a6a248fc::function_7b69c801();
    level flag::set("all_weak_points_destroyed");
    if (isdefined(level.var_4f474e60)) {
        level thread [[ level.var_4f474e60 ]]();
    }
    level thread function_66f027df();
}

// Namespace arena_defend
// Params 0, eflags: 0x0
// Checksum 0xbc801b15, Offset: 0x83a0
// Size: 0x122
function function_e8a47a87() {
    a_fxanims = array("wp_01", "wp_02", "wp_03", "wp_04", "wp_05");
    foreach (str_scene_name in a_fxanims) {
        level scene::init(str_scene_name);
        util::wait_network_frame();
    }
    showmiscmodels("sinkhole_misc_model");
    a_t = getentarray("ad_weak_point_trig", "targetname");
    array::thread_all(a_t, &function_182b2e13);
    function_cd83971c();
}

// Namespace arena_defend
// Params 0, eflags: 0x0
// Checksum 0xe529bd16, Offset: 0x84d0
// Size: 0xa4
function function_786c5bca() {
    var_35a302af = vehicle::simple_spawn_single("arena_defend_intro_technical");
    var_35a302af flag::init("warp_to_spline_end_done");
    while (!var_35a302af turret::is_turret_enabled(1)) {
        wait 0.25;
    }
    var_35a302af turret::disable(1);
    level waittill(#"arena_defend_intro_player_exits_technical");
    level scene::play("cin_ram_05_02_block_vign_mowed");
    var_35a302af turret::enable(1, 1);
    return var_35a302af;
}

// Namespace arena_defend
// Params 0, eflags: 0x0
// Checksum 0xb9d5a7d5, Offset: 0x8580
// Size: 0x6a
function function_bbf0087d() {
    level thread function_2db42799();
    level flag::wait_till("arena_defend_spawn");
    level thread function_f4554829();
    spawn_manager::enable("arena_defend_wall_allies");
    spawn_manager::enable("arena_defend_wall_top_allies");
}

// Namespace arena_defend
// Params 0, eflags: 0x0
// Checksum 0x6a176e70, Offset: 0x85f8
// Size: 0x2a
function function_27342097() {
    level scene::play("cin_ram_05_01_block_vign_rip_khalilorder");
    level thread function_7ad9ea68();
}

// Namespace arena_defend
// Params 0, eflags: 0x0
// Checksum 0x441b6eb5, Offset: 0x8630
// Size: 0xa2
function function_2db42799() {
    level endon(#"hash_46ed824");
    level flag::wait_till("arena_defend_intro_technical_disabled");
    spawn_manager::function_27bf2e8("sm_arena_defend_initial_enemies", 4);
    a_enemies = spawn_manager::function_423eae50("sm_arena_defend_initial_enemies");
    var_61fd03c7 = getent("initial_enemies_fallback_goal", "targetname");
    array::run_all(a_enemies, &setgoal, var_61fd03c7);
}

// Namespace arena_defend
// Params 0, eflags: 0x0
// Checksum 0x8b84412, Offset: 0x86e0
// Size: 0x20a
function function_cd83971c() {
    var_75aa23da = array(&function_da99ce30, &function_1d79812);
    var_a433ed0f = array(&function_8790f24e, &function_2fa2a80f, &function_8bcd7f99, &function_5c0d1d04, &function_44a7ad7b);
    var_6596c11c = array(&function_7cc654ff, &function_102382b1, &function_ad936cb7);
    var_38d11fac = array(&function_5f3c9cc9, &function_8394a26f, &function_34c51c66, &function_ce07d8df);
    function_d9d5f32(1, "wp_01", undefined, var_75aa23da, var_a433ed0f);
    function_d9d5f32(2, "wp_02", "arena_defend_second_wave_weak_points_discovered", &function_d5457906);
    function_d9d5f32(2, "wp_03", undefined, undefined, var_6596c11c);
    function_d9d5f32(3, "wp_05", "arena_defend_third_wave_weak_points_discovered", &function_a47d54df, &function_f5261dec);
    function_d9d5f32(4, "wp_04", "arena_defend_last_wave_weak_points_discovered", var_38d11fac);
}

// Namespace arena_defend
// Params 0, eflags: 0x0
// Checksum 0x9b2d91b6, Offset: 0x88f8
// Size: 0x29
function function_785a0ed() {
    assert(isdefined(level.var_9cdb6bca), "<dev string:x13a>");
    return level.var_9cdb6bca;
}

// Namespace arena_defend
// Params 5, eflags: 0x0
// Checksum 0xf4a59406, Offset: 0x8930
// Size: 0x244
function function_d9d5f32(n_wave, var_672c6068, var_2f201aa5, var_13c6e56, var_26323261) {
    if (!isdefined(level.var_9cdb6bca)) {
        level.var_9cdb6bca = [];
    }
    if (!isdefined(level.var_9cdb6bca[n_wave])) {
        level.var_9cdb6bca[n_wave] = [];
    }
    if (!isdefined(var_2f201aa5)) {
        var_2f201aa5 = [];
    } else if (!isarray(var_2f201aa5)) {
        var_2f201aa5 = array(var_2f201aa5);
    }
    if (!isdefined(var_13c6e56)) {
        var_13c6e56 = [];
    } else if (!isarray(var_13c6e56)) {
        var_13c6e56 = array(var_13c6e56);
    }
    if (!isdefined(var_26323261)) {
        var_26323261 = [];
    } else if (!isarray(var_26323261)) {
        var_26323261 = array(var_26323261);
    }
    if (isdefined(var_2f201aa5)) {
        foreach (str_flag in var_2f201aa5) {
            assert(level flag::exists(str_flag), "<dev string:x191>" + str_flag + "<dev string:x1c8>");
        }
    }
    s_temp = spawnstruct();
    s_temp.var_672c6068 = var_672c6068;
    s_temp.var_2f201aa5 = var_2f201aa5;
    s_temp.var_13c6e56 = var_13c6e56;
    s_temp.var_26323261 = var_26323261;
    if (!isdefined(level.var_9cdb6bca[n_wave])) {
        level.var_9cdb6bca[n_wave] = [];
    } else if (!isarray(level.var_9cdb6bca[n_wave])) {
        level.var_9cdb6bca[n_wave] = array(level.var_9cdb6bca[n_wave]);
    }
    level.var_9cdb6bca[n_wave][level.var_9cdb6bca[n_wave].size] = s_temp;
}

// Namespace arena_defend
// Params 0, eflags: 0x0
// Checksum 0x92bd0f96, Offset: 0x8b80
// Size: 0x122
function function_3e55e3() {
    a_data = function_785a0ed();
    a_flags = [];
    foreach (wave in a_data) {
        foreach (var_20488710 in wave) {
            if (!isdefined(a_flags)) {
                a_flags = [];
            } else if (!isarray(a_flags)) {
                a_flags = array(a_flags);
            }
            a_flags[a_flags.size] = var_20488710.var_672c6068 + "_destroyed";
        }
    }
    level flag::wait_till_all(a_flags);
}

// Namespace arena_defend
// Params 0, eflags: 0x0
// Checksum 0xa65214fb, Offset: 0x8cb0
// Size: 0x73a
function function_182b2e13() {
    level flag::init(self.script_string);
    level flag::init(self.script_string + "_identified");
    level flag::init(self.script_string + "_destroyed");
    var_3f69c18b = getent(self.target, "targetname");
    assert(isdefined(var_3f69c18b), "<dev string:x1ee>");
    assert(isdefined(var_3f69c18b.target), "<dev string:x224>");
    var_6ee53e36 = struct::get(var_3f69c18b.target, "targetname");
    assert(isdefined(var_6ee53e36), "<dev string:x296>" + self.origin + "<dev string:x2ce>");
    ramses_util::function_3f4f84e(self.script_string + "_covernode", "script_noteworthy", 1);
    ramses_util::function_8bf0b925(self.script_string + "_traversal", "script_noteworthy", 1);
    level waittill(self.script_string + "_identified");
    var_ca86eb01 = getent(var_6ee53e36.target, "targetname");
    assert(isdefined(var_ca86eb01), "<dev string:x2da>");
    var_ca86eb01 show();
    var_f0bbbaa4 = util::function_14518e76(var_ca86eb01, %cp_level_ramses_spike_plant, %CP_MI_CAIRO_RAMSES_PLANT_SPIKE, &function_f2c2b59c);
    var_f0bbbaa4.keepweapon = 1;
    var_f0bbbaa4.script_string = self.script_string;
    var_f0bbbaa4.t_damage = self;
    var_f0bbbaa4 function_33ce9734();
    var_5a150410 = util::spawn_model(var_6ee53e36.model, var_6ee53e36.origin, var_6ee53e36.angles);
    var_5a150410 clientfield::set("arena_defend_weak_point_keyline", 1);
    var_5a150410 setforcenocull();
    level.players[0] playlocalsound("uin_hud_weakpoints");
    self function_c2406993();
    objectives::complete("cp_level_ramses_spike_detonate");
    var_5a150410 clientfield::set("arena_defend_weak_point_keyline", 0);
    util::wait_network_frame();
    spawn_manager::kill("sm_" + self.script_string + "_defenders");
    level flag::set(self.script_string);
    var_3f69c18b ghost();
    level flag::set(self.script_string + "_destroyed");
    level thread scene::play(self.script_string, "targetname");
    var_9bb18713 = getentarray("collision_" + self.script_string, "targetname");
    foreach (var_44febfef in var_9bb18713) {
        if (var_44febfef.targetname != "collision_wp_05") {
            var_44febfef delete();
        }
    }
    if (level flag::get("wp_02_destroyed") && level flag::get("wp_03_destroyed") && !level flag::get("wp_05_destroyed") && (!level flag::get("wp_02_destroyed") && (level flag::get("wp_02_destroyed") && !level flag::get("wp_03_destroyed") || level flag::get("wp_03_destroyed")) || level flag::get("wp_05_identified"))) {
        var_5a150410 clientfield::set("arena_defend_weak_point_keyline", 1);
        util::wait_network_frame();
    }
    var_5a150410 delete();
    ramses_util::function_3f4f84e(self.script_string + "_traversal_jump", "script_noteworthy", 1);
    ramses_util::function_8bf0b925(self.script_string + "_traversal", "script_noteworthy", 0);
    spawn_manager::kill("sm_" + self.script_string + "_defenders", 1);
    switch (self.script_string) {
    case "wp_01":
        var_70d87be7 = getent("trig_wp_01_kill_stuck_players", "targetname");
        if (isdefined(var_70d87be7)) {
            var_70d87be7 triggerenable(1);
        }
        break;
    case "wp_02":
        trigger::use("wp_03_goal_trig");
        ramses_util::function_3f4f84e(self.script_string + "_covernode", "script_noteworthy", 0);
        break;
    case "wp_04":
        var_a9060824 = getent("trig_wp_04_damage", "targetname");
        var_a9060824 triggerenable(1);
        spawn_manager::enable("sm_wp_04_robot_rushers");
        ramses_util::function_3f4f84e("wp_04_raps_walk", "targetname", 0);
        break;
    default:
        break;
    }
    objective_clearentity(var_f0bbbaa4.objectiveid);
    var_f0bbbaa4 gameobjects::destroy_object(1);
    self delete();
    savegame::checkpoint_save();
}

// Namespace arena_defend
// Params 0, eflags: 0x0
// Checksum 0x33f04de8, Offset: 0x93f8
// Size: 0xc
function function_c2406993() {
    self waittill(#"hash_453ba490");
}

// Namespace arena_defend
// Params 1, eflags: 0x0
// Checksum 0x39ec71ba, Offset: 0x9410
// Size: 0x11a
function function_f2c2b59c(e_player) {
    if (e_player function_518bce38()) {
        self gameobjects::disable_object(1);
        e_player function_a7905bd8(self);
        self thread function_64f3ca1d(e_player);
    } else {
        e_player notify(#"spike_ammo_missing");
        e_player thread util::show_hint_text(%CP_MI_CAIRO_RAMSES_SPIKE_AMMO_MISSING, 1, "spike_ammo_missing", 3);
    }
    if (self.script_string === "wp_01") {
        foreach (player in level.activeplayers) {
            player notify(#"clear_spike_hints");
        }
        e_player thread ramses_util::function_508a129e(self.script_string + "_destroyed", 9999, 0);
    }
}

// Namespace arena_defend
// Params 1, eflags: 0x0
// Checksum 0x5b59ea5c, Offset: 0x9538
// Size: 0x52
function function_64f3ca1d(e_player) {
    self endon(#"death");
    self.trigger endon(#"death");
    self.t_damage endon(#"death");
    e_player waittill(#"death");
    self gameobjects::allow_use("any");
}

// Namespace arena_defend
// Params 0, eflags: 0x0
// Checksum 0xc5fb56df, Offset: 0x9598
// Size: 0x55
function function_518bce38() {
    var_1b7b3a6 = getweapon("spike_launcher");
    n_ammo_clip = self getweaponammoclip(var_1b7b3a6);
    var_107240b5 = n_ammo_clip > 0;
    return var_107240b5;
}

// Namespace arena_defend
// Params 1, eflags: 0x0
// Checksum 0xca69c02, Offset: 0x95f8
// Size: 0x1ba
function function_a7905bd8(var_dcf4cbb0) {
    self endon(#"death");
    if (!isdefined(self.var_c4ae3e9a)) {
        self.var_c4ae3e9a = 0;
    }
    if (!self.var_c4ae3e9a) {
        self.var_c4ae3e9a = 1;
        self disableweaponcycling();
        self enableinvulnerability();
        self function_e54da87c(var_dcf4cbb0);
        if (!self ramses_util::function_8806ea73("spike_launcher")) {
            self allowprone(0);
            util::wait_network_frame();
            self switchtoweapon(getweapon("spike_launcher"));
            self util::waittill_notify_or_timeout("weapon_change", 1);
        }
        self thread function_aa6f0c42();
        self thread scene::play("cin_ram_05_02_spike_launcher_plant", self);
        self allowprone(1);
        self disableinvulnerability();
        self enableweaponcycling();
        self util::waittill_notify_or_timeout("fire_spike", 5);
        level notify(#"hash_18cf70dc");
        objectives::complete("cp_level_ramses_spike_plant");
        objectives::set("cp_level_ramses_spike_detonate");
        self thread function_9d5fff53();
        self thread function_8750c3af(var_dcf4cbb0.t_damage);
    }
}

// Namespace arena_defend
// Params 1, eflags: 0x0
// Checksum 0x77c31ebb, Offset: 0x97c0
// Size: 0x82
function function_e54da87c(var_dcf4cbb0) {
    var_13171cfc = var_dcf4cbb0.var_8176968e;
    var_9be8e3be = var_dcf4cbb0.var_609f75ed;
    if (isdefined(var_13171cfc) && isdefined(var_9be8e3be)) {
        if (self istouching(var_13171cfc)) {
            self setorigin(var_9be8e3be.origin);
            util::wait_network_frame();
        }
    }
}

// Namespace arena_defend
// Params 0, eflags: 0x0
// Checksum 0xf239df44, Offset: 0x9850
// Size: 0x9a
function function_33ce9734() {
    str_identifier = self.script_string;
    self.var_8176968e = getent(str_identifier + "_bad_place_trigger", "targetname");
    if (isdefined(self.var_8176968e)) {
        self.var_609f75ed = struct::get(self.var_8176968e.target, "targetname");
        assert(isdefined(self.var_609f75ed), "<dev string:x31e>" + str_identifier + "<dev string:x33f>");
    }
}

// Namespace arena_defend
// Params 1, eflags: 0x0
// Checksum 0x356e79fb, Offset: 0x98f8
// Size: 0x1d
function function_889f79d5(a_ents) {
    a_ents["player 1"].var_c4ae3e9a = undefined;
}

// Namespace arena_defend
// Params 0, eflags: 0x0
// Checksum 0xb32985f5, Offset: 0x9920
// Size: 0xd2
function function_9d5fff53() {
    self endon(#"death");
    waittillframeend();
    var_45f33ff4 = getweapon("spike_launcher_plant");
    v_spawn = self gettagorigin("tag_flash");
    self clientfield::increment_to_player("player_spike_plant_postfx");
    if (isdefined(v_spawn)) {
        var_3b2bce1d = magicbullet(var_45f33ff4, v_spawn + (0, 0, 40), v_spawn, self);
    } else {
        var_3b2bce1d = magicbullet(var_45f33ff4, self.origin + (0, 0, 40), self.origin, self);
    }
    self function_11a53707();
}

// Namespace arena_defend
// Params 1, eflags: 0x0
// Checksum 0x5379b508, Offset: 0x9a00
// Size: 0xda
function function_d7c41d5e(var_3b2bce1d) {
    level endon(#"all_weak_points_destroyed");
    var_3b2bce1d endon(#"death");
    mdl_spike = util::spawn_model(var_3b2bce1d.model, var_3b2bce1d.origin, var_3b2bce1d.angles);
    mdl_spike clientfield::set("arena_defend_weak_point_keyline", 1);
    mdl_spike thread function_9673263e(var_3b2bce1d);
    var_3b2bce1d ghost();
    self thread function_edfdd3b1(var_3b2bce1d);
    self util::waittill_any("detonate", "last_stand_detonate");
    mdl_spike clientfield::set("arena_defend_weak_point_keyline", 0);
    var_3b2bce1d detonate();
}

// Namespace arena_defend
// Params 1, eflags: 0x0
// Checksum 0xb63fe4e0, Offset: 0x9ae8
// Size: 0x82
function function_8750c3af(trigger) {
    self endon(#"death");
    trigger endon(#"death");
    self waittill(#"grenade_fire", var_3b2bce1d);
    self thread function_d7c41d5e(var_3b2bce1d);
    var_8d3a3d3c = var_3b2bce1d.origin;
    var_3b2bce1d waittill(#"death");
    trigger notify(#"hash_453ba490");
    level function_1caab1d2(var_8d3a3d3c);
}

// Namespace arena_defend
// Params 1, eflags: 0x0
// Checksum 0x244d663e, Offset: 0x9b78
// Size: 0xf5
function function_edfdd3b1(var_3b2bce1d) {
    level endon(#"all_weak_points_destroyed");
    self endon(#"detonate");
    self endon(#"last_stand_detonate");
    self endon(#"death");
    var_3b2bce1d endon(#"death");
    wait 5;
    self flag::clear("spike_launcher_tutorial_complete");
    w_current = self getcurrentweapon();
    var_1b7b3a6 = getweapon("spike_launcher");
    while (!self flag::get("spike_launcher_tutorial_complete")) {
        if (w_current == var_1b7b3a6) {
            self thread ramses_util::function_c2712461();
            self thread ramses_util::function_780e57a1();
            self util::waittill_any("detonate", "last_stand_detonate");
            continue;
        }
        self waittill(#"weapon_change_complete", w_current);
    }
}

// Namespace arena_defend
// Params 1, eflags: 0x0
// Checksum 0x5e271098, Offset: 0x9c78
// Size: 0x183
function function_1caab1d2(arg1) {
    a_grenades = getentarray("grenade", "classname");
    if (isvec(arg1)) {
        foreach (i, e_grenade in a_grenades) {
            if (isdefined(e_grenade) && distance2dsquared(arg1, e_grenade.origin) <= 40000) {
                e_grenade detonate();
            }
            if (i % 2 == 0) {
                util::wait_network_frame();
            }
        }
        return;
    }
    if (isentity(arg1)) {
        foreach (i, e_grenade in a_grenades) {
            if (isdefined(e_grenade) && e_grenade istouching(arg1)) {
                e_grenade detonate();
            }
            if (i % 2 == 0) {
                util::wait_network_frame();
            }
        }
    }
}

// Namespace arena_defend
// Params 1, eflags: 0x0
// Checksum 0xe697140d, Offset: 0x9e08
// Size: 0x52
function function_9673263e(var_3b2bce1d) {
    self endon(#"death");
    var_3b2bce1d waittill(#"death");
    self clientfield::set("arena_defend_weak_point_keyline", 0);
    util::wait_network_frame();
    self delete();
}

// Namespace arena_defend
// Params 0, eflags: 0x0
// Checksum 0x96fb6c34, Offset: 0x9e68
// Size: 0x72
function function_11a53707() {
    var_1b7b3a6 = getweapon("spike_launcher");
    n_ammo_clip = self getweaponammoclip(var_1b7b3a6);
    n_ammo_clip = math::clamp(n_ammo_clip - 1, 0, n_ammo_clip);
    self setweaponammoclip(var_1b7b3a6, n_ammo_clip);
}

// Namespace arena_defend
// Params 0, eflags: 0x0
// Checksum 0xeb4951c1, Offset: 0x9ee8
// Size: 0x62
function function_aa6f0c42() {
    self endon(#"death");
    if (level.players.size == 1) {
        self.attackeraccuracy = 0.1;
        while (isdefined(self.var_c4ae3e9a) && self.var_c4ae3e9a) {
            wait 0.1;
        }
        wait 3;
        self.attackeraccuracy = 1;
    }
}

// Namespace arena_defend
// Params 1, eflags: 0x0
// Checksum 0xd168b7aa, Offset: 0x9f58
// Size: 0x1aa
function function_8f461d35(var_d42cd848) {
    if (!isdefined(var_d42cd848)) {
        var_d42cd848 = 1;
    }
    function_2fcc9369("arena_defend_spawn_manager_friendly");
    function_a410970();
    ramses_util::function_3f4f84e("arena_defend_mobile_wall_top_nodes", "script_noteworthy", 0);
    var_65ef1e5b = getent("sinkhole_friendly_fallback_volume", "targetname");
    foreach (var_412a98c7 in getactorteamarray("allies")) {
        var_412a98c7 thread function_b16456e1(var_65ef1e5b);
        wait 0.05;
    }
    level.var_2fd26037.goalradius = 32;
    var_76be17b8 = getnode("hendricks_mobile_wall_start_node", "targetname");
    level.var_2fd26037 thread ai::force_goal(var_76be17b8, 32, 1, undefined, 1);
    level.var_9db406db.goalradius = 32;
    var_f47e732e = getnode("arena_defend_demostreet_intro_khalil", "targetname");
    level.var_9db406db thread ai::force_goal(var_f47e732e, 32, 1, undefined, 1);
}

// Namespace arena_defend
// Params 1, eflags: 0x0
// Checksum 0xce1d8d52, Offset: 0xa110
// Size: 0x72
function function_b16456e1(var_284ca6ef) {
    self endon(#"death");
    self setgoal(var_284ca6ef, 1);
    if (!self util::is_hero()) {
        self ai::set_behavior_attribute("sprint", 1);
        self waittill(#"goal");
        self ai::set_behavior_attribute("coverIdleOnly", 1);
    }
}

// Namespace arena_defend
// Params 0, eflags: 0x0
// Checksum 0x98af0a9a, Offset: 0xa190
// Size: 0xdb
function function_a410970() {
    if (isdefined(level.var_2fd26037) && isdefined(level.var_2fd26037.var_e6e961e4)) {
        level.var_2fd26037.goalradius = level.var_2fd26037.var_e6e961e4;
    }
    a_ai_allies = getaispeciesarray("allies", "human");
    foreach (ai in a_ai_allies) {
        ai colors::disable();
        ai cleargoalvolume();
    }
}

// Namespace arena_defend
// Params 0, eflags: 0x0
// Checksum 0x1b7fcbd9, Offset: 0xa278
// Size: 0x8a
function function_4dcf9e47() {
    function_4fdddf97();
    if (isdefined(level.var_1a96323)) {
        level thread [[ level.var_1a96323 ]]();
    }
    level thread scene::play("cin_ram_05_demostreet_vign_intro_detonation_guy");
    level thread scene::play("cin_ram_05_demostreet_vign_intro_khalil_only");
    level thread scene::play("cin_ram_05_demostreet_vign_intro_hendricks_only");
    level flag::wait_till_timeout(5, "arena_defend_detonator_dropped");
}

// Namespace arena_defend
// Params 0, eflags: 0x0
// Checksum 0xd3d44470, Offset: 0xa310
// Size: 0xe2
function function_2e8bcd54() {
    trigger::wait_till("arena_defend_player_fallback_trigger");
    level.var_2fd26037 ai::set_behavior_attribute("sprint", 1);
    level.var_9db406db ai::set_behavior_attribute("sprint", 1);
    level thread scene::init("cin_ram_05_demostreet_vign_intro_khalil_only");
    util::wait_network_frame();
    level thread scene::init("cin_ram_05_demostreet_vign_intro_hendricks_only");
    array::wait_till(array(level.var_2fd26037, level.var_9db406db), "vign_intro_runback_done", 15);
    level thread function_d72bac37();
}

// Namespace arena_defend
// Params 0, eflags: 0x0
// Checksum 0x95575729, Offset: 0xa400
// Size: 0x8a
function function_d72bac37() {
    trigger::wait_till("arena_defend_wall_gather_trig");
    callback::on_spawned(&function_f554e28a);
    function_cce749ad();
    array::thread_all(getaiteamarray("axis", "allies"), &function_4c119f69);
}

// Namespace arena_defend
// Params 0, eflags: 0x0
// Checksum 0xca32b0f1, Offset: 0xa498
// Size: 0x7a
function function_f554e28a() {
    if (level.var_31aefea8 == "sinkhole_collapse") {
        var_9be8e3be = struct::get("s_mobile_wall_closed_hot_join_" + self getentitynumber(), "targetname");
        self setorigin(var_9be8e3be.origin);
        self setplayerangles(var_9be8e3be.angles);
    }
}

// Namespace arena_defend
// Params 0, eflags: 0x0
// Checksum 0x7f012ed9, Offset: 0xa520
// Size: 0xc1
function function_4fdddf97() {
    var_d156a4cd = getent("arena_defend_wall_gather_trig", "targetname");
    while (true) {
        var_859ac0d1 = 0;
        foreach (player in level.activeplayers) {
            if (player istouching(var_d156a4cd)) {
                var_859ac0d1 = 1;
                break;
            }
        }
        if (var_859ac0d1) {
            break;
        }
        wait 0.05;
    }
}

// Namespace arena_defend
// Params 0, eflags: 0x0
// Checksum 0x7c104b0c, Offset: 0xa5f0
// Size: 0x32
function function_4c119f69() {
    if (isalive(self) && isactor(self)) {
        self clearenemy();
    }
}

// Namespace arena_defend
// Params 0, eflags: 0x0
// Checksum 0xdc27a421, Offset: 0xa630
// Size: 0x2a3
function function_3d3f7691() {
    level flag::wait_till("arena_defend_detonator_pickup");
    if (level scene::is_active("cin_ram_05_demostreet_vign_intro_hendricks_only")) {
        level scene::stop("cin_ram_05_demostreet_vign_intro_hendricks_only");
    }
    if (level scene::is_active("cin_ram_05_demostreet_vign_intro_khalil_only")) {
        level scene::stop("cin_ram_05_demostreet_vign_intro_khalil_only");
    }
    foreach (player in level.players) {
        player.ignoreme = 1;
        player enableinvulnerability();
        player notify(#"hash_5a334c0f");
    }
    function_2fcc9369("arena_defend_spawn_manager");
    function_2fcc9369("arena_defend_spawn_manager_friendly");
    battlechatter::function_d9f49fba(0);
    foreach (player in level.players) {
        player oed::function_ffc82115(0);
    }
    callback::remove_on_spawned(&function_f554e28a);
    scene::function_9e5b8cdb("p7_fxanim_cp_ramses_street_collapse_big_hole_bundle");
    ramses_util::function_ac2b4535("cin_ram_05_demostreet_3rd_sh140", "alley");
    level scene::play("cin_ram_05_demostreet_3rd_sh010", level.var_8e659b82);
    function_53314bf6();
    level flag::wait_till("arena_defend_sinkhole_collapse_done");
    foreach (player in level.players) {
        player.ignoreme = 0;
        player disableinvulnerability();
        player enableweapons();
    }
}

// Namespace arena_defend
// Params 0, eflags: 0x0
// Checksum 0x292f910e, Offset: 0xa8e0
// Size: 0xcb
function function_f56aea9b() {
    var_ea644274 = getactorteamarray("allies");
    foreach (ai in var_ea644274) {
        if (!isactor(ai) || !isinarray(level.heroes, ai) && !ai isinscriptedstate()) {
            ai delete();
        }
    }
}

// Namespace arena_defend
// Params 0, eflags: 0x0
// Checksum 0x3453950b, Offset: 0xa9b8
// Size: 0xc6
function function_fa763553() {
    a_vehicles = getentarray("arena_defend_technical", "script_noteworthy");
    var_16780955 = 0;
    foreach (vehicle in a_vehicles) {
        if (isalive(vehicle)) {
            vehicle dodamage(vehicle.health, vehicle.origin);
            var_16780955++;
        }
    }
    if (var_16780955 > 0) {
        waittillframeend();
    }
}

// Namespace arena_defend
// Params 0, eflags: 0x0
// Checksum 0xae43c929, Offset: 0xaa88
// Size: 0x1a
function function_53314bf6() {
    level flag::set("sinkhole_explosion_started");
}

// Namespace arena_defend
// Params 1, eflags: 0x0
// Checksum 0x3406b157, Offset: 0xaab0
// Size: 0xe2
function outro(var_74cd64bc) {
    if (var_74cd64bc) {
        function_b6da2f7c();
        level flag::set("sinkhole_charges_detonated");
        trigger::use("arena_defend_colors_allies_behind_mobile_wall");
        spawn_manager::enable("arena_defend_wall_allies");
        spawn_manager::enable("arena_defend_wall_allies2");
        spawn_manager::enable("arena_defend_wall_top_allies");
        spawn_manager::enable("arena_defend_push_enemies");
        spawn_manager::enable("arena_defend_heavy_units");
        level flag::wait_till("all_players_spawned");
    }
}

// Namespace arena_defend
// Params 0, eflags: 0x0
// Checksum 0x5efbfd69, Offset: 0xaba0
// Size: 0x22
function function_26aaae96() {
    ramses_util::function_9f4f118("arena_defend_out_of_bounds_trigger", "targetname");
}

// Namespace arena_defend
// Params 0, eflags: 0x0
// Checksum 0x730cad0d, Offset: 0xabd0
// Size: 0x872
function function_c50ca91() {
    scene::add_scene_func("p7_fxanim_cp_ramses_street_collapse_small_hole_02_bundle", &function_a9ffcec, "play");
    scene::add_scene_func("p7_fxanim_cp_ramses_street_collapse_small_hole_02_bundle", &function_e802b666, "done");
    scene::add_scene_func("p7_fxanim_cp_ramses_street_collapse_small_hole_01_bundle", &function_69dcb622, "play");
    scene::add_scene_func("p7_fxanim_cp_ramses_street_collapse_small_hole_03_bundle", &function_5db3ae57, "play");
    scene::add_scene_func("p7_fxanim_cp_ramses_street_collapse_small_hole_04_bundle", &function_1b706878, "play");
    scene::add_scene_func("p7_fxanim_cp_ramses_street_collapse_small_hole_04_bundle", &function_3b5bd8c4, "init");
    scene::add_scene_func("p7_fxanim_cp_ramses_wall_drop_bundle", &function_63407bd6, "init");
    scene::add_scene_func("p7_fxanim_cp_ramses_wall_drop_bundle", &function_35c6856, "play");
    scene::add_scene_func("p7_fxanim_cp_ramses_wall_drop_bundle", &function_74684a40, "done");
    scene::add_scene_func("p7_fxanim_cp_ramses_checkpoint_wall_01_bundle", &function_cc9e6c1d, "init");
    scene::add_scene_func("p7_fxanim_cp_ramses_checkpoint_wall_01_bundle", &function_7b7e8565, "play");
    scene::add_scene_func("p7_fxanim_cp_ramses_checkpoint_wall_01_bundle", &function_3730aac7, "done");
    scene::add_scene_func("p7_fxanim_cp_ramses_checkpoint_wall_02_bundle", &function_1ab1b112, "play");
    scene::add_scene_func("p7_fxanim_cp_ramses_wall_drop_doors_up_bundle", &function_c6f8879f, "play");
    scene::add_scene_func("p7_fxanim_cp_ramses_wall_drop_doors_down_bundle", &function_d1580f2c, "play");
    scene::add_scene_func("p7_fxanim_cp_ramses_street_collapse_big_hole_bundle", &function_be12945c, "init");
    scene::add_scene_func("p7_fxanim_cp_ramses_street_collapse_big_hole_bundle", &function_9cc779c7, "play");
    scene::add_scene_func("p7_fxanim_cp_ramses_street_collapse_big_hole_bundle", &function_397df6bc, "play");
    scene::add_scene_func("p7_fxanim_cp_ramses_street_collapse_big_hole_bundle", &function_c15cf2c8, "done");
    scene::add_scene_func("p7_fxanim_cp_ramses_arena_billboard_bundle", &function_f2cede6c, "play");
    scene::add_scene_func("p7_fxanim_cp_ramses_arena_billboard_02_bundle", &function_1a46d844, "play");
    scene::add_scene_func("cin_ram_05_01_block_1st_rip", &function_3838410f, "done");
    scene::add_scene_func("cin_ram_05_01_block_1st_rip", &function_25e4bdcc, "done");
    scene::add_scene_func("cin_ram_05_01_block_1st_rip_skipto", &function_25e4bdcc, "done");
    scene::add_scene_func("cin_ram_05_02_block_vign_mowed", &function_18767202, "play");
    scene::add_scene_func("cin_ram_05_01_defend_vign_leapattack", &function_a7405e61, "init");
    scene::add_scene_func("cin_ram_05_01_defend_vign_leapattack", &function_f295baeb, "done");
    scene::add_scene_func("cin_ram_05_01_defend_vign_rescueinjured_l_group", &function_33280827, "play");
    scene::add_scene_func("cin_ram_05_01_defend_vign_rescueinjured_r_group", &function_33280827, "play");
    scene::add_scene_func("cin_ram_05_01_defend_vign_rescueinjured_r_group", &function_7c00379f, "done");
    scene::add_scene_func("cin_ram_05_01_defend_vign_rescueinjured_c_group", &function_33280827, "play");
    scene::add_scene_func("cin_gen_melee_hendricksmoment_closecombat_robot", &function_a6ca068f, "init");
    scene::add_scene_func("cin_gen_melee_hendricksmoment_closecombat_robot", &function_e419e693, "play");
    scene::add_scene_func("cin_ram_05_02_spike_launcher_plant", &function_889f79d5, "done");
    scene::add_scene_func("cin_ram_05_demostreet_vign_intro_detonation_guy", &function_982fed86, "init");
    scene::add_scene_func("cin_ram_05_demostreet_vign_intro_detonation_guy", &function_bf4445e6, "play");
    scene::add_scene_func("cin_ram_05_demostreet_3rd_sh010", &function_5cee729c, "play");
    scene::add_scene_func("cin_ram_05_demostreet_3rd_sh020", &function_19f02780, "play");
    scene::add_scene_func("cin_ram_05_demostreet_3rd_sh020", &function_f2434205, "play");
    scene::add_scene_func("cin_ram_05_demostreet_3rd_sh040", &function_76cedf66, "play");
    scene::add_scene_func("cin_ram_05_demostreet_3rd_sh080", &function_963f32b, "play");
    scene::add_scene_func("cin_ram_05_demostreet_3rd_sh080", &function_ce13c58d, "done");
    scene::add_scene_func("cin_ram_05_demostreet_3rd_sh130", &function_e4fcbd75, "play");
    scene::add_scene_func("cin_ram_05_demostreet_3rd_sh140", &function_f3dffed, "done");
    scene::add_scene_func("cin_ram_05_demostreet_3rd_sh140", &function_2ec70f8b, "play");
}

// Namespace arena_defend
// Params 0, eflags: 0x0
// Checksum 0x1084ff5d, Offset: 0xb450
// Size: 0x10a
function function_f87b2c29() {
    var_70f028db = struct::get_array("arena_defend_friendly_fallback_intro", "targetname");
    foreach (struct in var_70f028db) {
        scene::add_scene_func(struct.scriptbundlename, &function_32c9babe, "init");
        struct scene::init();
        util::wait_network_frame();
    }
    scene::add_scene_func("cin_ram_05_01_defend_vign_rescueinjured_r_group", &function_7d420577, "init");
    scene::init("cin_ram_05_01_defend_vign_rescueinjured_r_group");
}

// Namespace arena_defend
// Params 1, eflags: 0x0
// Checksum 0xf16511ac, Offset: 0xb568
// Size: 0x5a
function function_7d420577(a_ents) {
    var_1030677c = getent(self.target, "targetname");
    var_1030677c waittill(#"trigger");
    self scene::play();
    var_1030677c delete();
}

// Namespace arena_defend
// Params 1, eflags: 0x0
// Checksum 0xac605881, Offset: 0xb5d0
// Size: 0x149
function function_32c9babe(a_ents) {
    level endon(#"sinkhole_charges_detonated");
    var_1030677c = getent(self.target, "targetname");
    level flag::wait_till("intro_igc_done");
    if (!level flag::exists(self.scriptbundlename)) {
        level flag::init(self.scriptbundlename);
    }
    self thread function_2f4e01f7(var_1030677c);
    while (true) {
        foreach (player in level.activeplayers) {
            if (isdefined(player)) {
                if (level flag::get(self.scriptbundlename) || player util::is_player_looking_at(var_1030677c.origin)) {
                    self scene::play();
                    level notify(self.scriptbundlename);
                    return;
                }
            }
        }
        wait 0.1;
    }
}

// Namespace arena_defend
// Params 1, eflags: 0x0
// Checksum 0x8bac416d, Offset: 0xb728
// Size: 0x32
function function_2f4e01f7(var_1030677c) {
    level endon(self.scriptbundlename);
    var_1030677c waittill(#"trigger");
    level flag::set(self.scriptbundlename);
}

// Namespace arena_defend
// Params 1, eflags: 0x0
// Checksum 0x727d095d, Offset: 0xb768
// Size: 0x1a
function function_c6f8879f(a_ents) {
    function_ce0f393b(1);
}

// Namespace arena_defend
// Params 1, eflags: 0x0
// Checksum 0xf682ebce, Offset: 0xb790
// Size: 0x1a
function function_d1580f2c(a_ents) {
    function_ce0f393b(0);
}

// Namespace arena_defend
// Params 1, eflags: 0x0
// Checksum 0xcf6d208d, Offset: 0xb7b8
// Size: 0x1b2
function function_ce0f393b(b_open) {
    level flag::wait_till("arena_defend_mobile_wall_deployed");
    var_cfdb3b07 = getent("mobile_wall_doors_clip", "targetname");
    var_da89874c = !level flag::get("arena_defend_mobile_wall_doors_open") && b_open;
    var_b30d2648 = level flag::get("arena_defend_mobile_wall_doors_open") && !b_open;
    if (var_da89874c) {
        var_cfdb3b07 movez(90, 0.1);
        var_cfdb3b07 waittill(#"movedone");
        var_cfdb3b07 notsolid();
        var_cfdb3b07 connectpaths();
        ramses_util::function_3f4f84e("mobile_wall_door_traversals", "targetname", 1);
        level flag::set("arena_defend_mobile_wall_doors_open");
        return;
    }
    if (var_b30d2648) {
        var_cfdb3b07 movez(90 * -1, 0.1);
        var_cfdb3b07 waittill(#"movedone");
        var_cfdb3b07 solid();
        ramses_util::function_3f4f84e("mobile_wall_door_traversals", "targetname", 0);
        level flag::clear("arena_defend_mobile_wall_doors_open");
    }
}

// Namespace arena_defend
// Params 1, eflags: 0x0
// Checksum 0x51d65a76, Offset: 0xb978
// Size: 0xea
function function_a9ffcec(a_ents) {
    var_2562cec2 = getent("arena_defend_technical_01_vh", "targetname");
    if (isdefined(var_2562cec2)) {
        var_2562cec2 notify(#"kill_passengers");
        waittillframeend();
        var_2562cec2 delete();
    }
    ramses_util::function_3f4f84e("arena_defend_technical_01_vh_covernode", "targetname", 0);
    level waittill(#"hash_fa53fbdf");
    var_35a302af = a_ents["wp_01_technical"];
    var_35a302af disconnectpaths(0, 0);
    var_70d87be7 = getent("trig_wp_01_kill_stuck_players", "targetname");
    if (isdefined(var_70d87be7)) {
        var_70d87be7 delete();
    }
}

// Namespace arena_defend
// Params 1, eflags: 0x0
// Checksum 0x8dd89de3, Offset: 0xba70
// Size: 0x72
function function_e802b666(a_ents) {
    var_35a302af = a_ents["wp_01_technical"];
    var_35a302af disconnectpaths(0, 0);
    var_70d87be7 = getent("trig_wp_01_kill_stuck_players", "targetname");
    if (isdefined(var_70d87be7)) {
        var_70d87be7 delete();
    }
}

// Namespace arena_defend
// Params 1, eflags: 0x0
// Checksum 0x895647fe, Offset: 0xbaf0
// Size: 0x62
function function_69dcb622(a_ents) {
    getent("wp_crouch_cover", "targetname") movez(-56, 0.05);
    ramses_util::function_3f4f84e("wp_03_dynamic_covernode", "script_noteworthy", 1);
}

// Namespace arena_defend
// Params 1, eflags: 0x0
// Checksum 0xb8f726b6, Offset: 0xbb60
// Size: 0xa
function function_5db3ae57(a_ents) {
    
}

// Namespace arena_defend
// Params 1, eflags: 0x0
// Checksum 0x9d65ee66, Offset: 0xbb78
// Size: 0x62
function function_3b5bd8c4(a_ents) {
    var_d578296 = a_ents["street_collapse_trailer_cargo"];
    e_light = getent("lgt_trailer", "targetname");
    e_light linkto(var_d578296, "trailer_cargo_jnt");
}

// Namespace arena_defend
// Params 1, eflags: 0x0
// Checksum 0x9cb24461, Offset: 0xbbe8
// Size: 0xea
function function_1b706878(a_ents) {
    var_dbf26aa4 = getent("arena_defend_trailer_door_clip", "targetname");
    var_e8a2c038 = struct::get("arena_defend_trailer_door_hinge", "targetname");
    var_f74e78ca = util::spawn_model("tag_origin", var_e8a2c038.origin, var_e8a2c038.angles);
    var_dbf26aa4 linkto(var_f74e78ca);
    var_f74e78ca rotateyaw(-76, 1);
    var_f74e78ca waittill(#"rotatedone");
    var_f74e78ca delete();
    var_dbf26aa4 disconnectpaths();
}

// Namespace arena_defend
// Params 0, eflags: 0x0
// Checksum 0x71176369, Offset: 0xbce0
// Size: 0x102
function function_e45af9f2() {
    trigger = getent("arena_defend_billboard_trigger", "targetname");
    mdl_clip = getent("arena_defend_billboard_fxanim_clip", "targetname");
    mdl_clip notsolid();
    mdl_clip connectpaths();
    ramses_util::function_3f4f84e("arena_defend_center_building_sniper_nodes_billboard_collapse", "script_noteworthy", 1);
    var_bdabc38a = getweapon("spike_charge");
    do {
        trigger waittill(#"damage", _, _, _, _, _, _, _, _, var_e285ce7a);
        var_bc23510 = isdefined(var_e285ce7a) && var_e285ce7a == var_bdabc38a;
    } while (!var_bc23510);
    level scene::play("p7_fxanim_cp_ramses_arena_billboard_bundle");
}

// Namespace arena_defend
// Params 1, eflags: 0x0
// Checksum 0x7d9b8409, Offset: 0xbdf0
// Size: 0x17a
function function_f2cede6c(a_ents) {
    ramses_util::function_3f4f84e("arena_defend_center_building_sniper_nodes_billboard_collapse", "script_noteworthy", 0);
    spawn_manager::kill("sm_arena_defend_snipers_center_building");
    level waittill(#"hash_a22c2052");
    level flag::set("billboard1_crashed");
    var_93dfe24f = getent("arena_defend_billboard_trigger", "targetname");
    var_fee634f2 = a_ents["arena_billboard"];
    a_ai = getaiteamarray("axis");
    if (isdefined(a_ai) && isdefined(var_fee634f2)) {
        for (i = 0; i < a_ai.size; i++) {
            if (a_ai[i] istouching(var_93dfe24f) && isalive(a_ai[i])) {
                a_ai[i] kill(var_fee634f2.origin, undefined, var_fee634f2);
            }
        }
    }
    mdl_clip = getent("arena_defend_billboard_fxanim_clip", "targetname");
    mdl_clip solid();
    mdl_clip disconnectpaths();
}

// Namespace arena_defend
// Params 0, eflags: 0x0
// Checksum 0xafcf94fc, Offset: 0xbf78
// Size: 0x9a
function function_f9842c89() {
    trigger = getent("arena_defend_billboard2_trigger", "targetname");
    var_bdabc38a = getweapon("spike_charge");
    do {
        trigger waittill(#"damage", _, _, _, _, _, _, _, _, var_e285ce7a);
        var_bc23510 = isdefined(var_e285ce7a) && var_e285ce7a == var_bdabc38a;
    } while (!var_bc23510);
    level scene::play("p7_fxanim_cp_ramses_arena_billboard_02_bundle");
}

// Namespace arena_defend
// Params 1, eflags: 0x0
// Checksum 0x6214b149, Offset: 0xc020
// Size: 0xf9
function function_1a46d844(a_ents) {
    level waittill(#"hash_a22c2052");
    level flag::set("billboard2_crashed");
    var_93dfe24f = getent("arena_defend_billboard2_trigger", "targetname");
    var_fee634f2 = a_ents["arena_billboard_02"];
    a_ai = getaiteamarray("axis");
    if (isdefined(a_ai) && isdefined(var_fee634f2)) {
        for (i = 0; i < a_ai.size; i++) {
            if (a_ai[i] istouching(var_93dfe24f) && isalive(a_ai[i])) {
                a_ai[i] kill(var_fee634f2.origin, undefined, var_fee634f2);
            }
        }
    }
}

// Namespace arena_defend
// Params 1, eflags: 0x0
// Checksum 0xcd8b4b7e, Offset: 0xc128
// Size: 0x7a
function function_63407bd6(a_ents) {
    level thread function_82802a7a(0);
    level thread function_a5b142fc(0);
    level util::waittill_notify_or_timeout("mobile_wall_hit_sidewalk", 15);
    level thread function_a5b142fc(1);
    level util::waittill_notify_or_timeout("mobile_wall_hit_building", 5);
    level thread function_82802a7a(1);
}

// Namespace arena_defend
// Params 1, eflags: 0x0
// Checksum 0x8fdef059, Offset: 0xc1b0
// Size: 0x193
function function_82802a7a(b_enable) {
    var_e09430b3 = getentarray("mobile_wall_smash_before", "targetname");
    var_dbc08694 = getentarray("mobile_wall_smash_after", "targetname");
    if (b_enable) {
        foreach (i, model in var_e09430b3) {
            model hide();
        }
        foreach (i, model in var_dbc08694) {
            model show();
        }
        return;
    }
    foreach (i, model in var_e09430b3) {
        model show();
    }
    foreach (model in var_dbc08694) {
        model hide();
    }
}

// Namespace arena_defend
// Params 1, eflags: 0x0
// Checksum 0x20220d5a, Offset: 0xc350
// Size: 0x10a
function function_a5b142fc(b_enable) {
    var_e09430b3 = getentarray("mobile_wall_sidewalk_smash_before", "targetname");
    if (b_enable) {
        foreach (i, model in var_e09430b3) {
            model hide();
        }
        level clientfield::set("arena_defend_mobile_wall_damage", 0);
        return;
    }
    foreach (model in var_e09430b3) {
        model show();
    }
    level clientfield::set("arena_defend_mobile_wall_damage", 1);
}

// Namespace arena_defend
// Params 1, eflags: 0x0
// Checksum 0x474cff17, Offset: 0xc468
// Size: 0x173
function function_35c6856(a_ents) {
    var_2ef9d306 = getent("wall_drop_vtol", "targetname");
    level waittill(#"hash_dde42d30");
    level thread function_d2d508fb();
    weapon = getweapon("smaw");
    s_vtol_rocket_start = struct::get("s_vtol_rocket_start", "targetname");
    for (i = 0; i < 3; i++) {
        if (isdefined(var_2ef9d306)) {
            var_b76e95dc[i] = magicbullet(weapon, s_vtol_rocket_start.origin, var_2ef9d306.origin, undefined, var_2ef9d306, (-300, 0, 400));
            wait 0.25;
        }
    }
    level flag::wait_till("arena_defend_rocket_hits_vtol");
    foreach (var_3c91fda1 in var_b76e95dc) {
        if (isdefined(var_3c91fda1)) {
            var_3c91fda1 detonate();
            wait 0.1;
        }
    }
}

// Namespace arena_defend
// Params 0, eflags: 0x0
// Checksum 0x7995e34d, Offset: 0xc5e8
// Size: 0x22
function function_d2d508fb() {
    level waittill(#"hash_883eae52");
    level flag::set("arena_defend_rocket_hits_vtol");
}

// Namespace arena_defend
// Params 1, eflags: 0x0
// Checksum 0xd1cb25f6, Offset: 0xc618
// Size: 0x52
function function_74684a40(a_ents) {
    scene::function_bac0d34c("p7_fxanim_cp_ramses_wall_drop_bundle");
    level flag::set("arena_defend_mobile_wall_deployed");
    vehicle::simple_spawn("arena_defend_mobile_wall_turret", 1);
}

// Namespace arena_defend
// Params 1, eflags: 0x0
// Checksum 0xb10ce25c, Offset: 0xc678
// Size: 0x4a
function function_cc9e6c1d(a_ents) {
    var_86b91b96 = getent("arena_defend_checkpoint_wall_b", "targetname");
    if (isdefined(var_86b91b96)) {
        var_86b91b96 disconnectpaths();
    }
}

// Namespace arena_defend
// Params 1, eflags: 0x0
// Checksum 0x6faf5216, Offset: 0xc6d0
// Size: 0x103
function function_7b7e8565(a_ents) {
    var_86b91b96 = getent("arena_defend_checkpoint_wall_b", "targetname");
    level function_1caab1d2(var_86b91b96);
    if (isdefined(var_86b91b96)) {
        var_86b91b96 connectpaths();
        var_86b91b96 delete();
    }
    wait 0.1;
    a_models = getentarray("arena_defend_checkpoint_wall_left_models", "script_noteworthy");
    foreach (mdl_wall in a_models) {
        mdl_wall delete();
    }
}

// Namespace arena_defend
// Params 1, eflags: 0x0
// Checksum 0xb7bc1342, Offset: 0xc7e0
// Size: 0x13
function function_3730aac7(a_ents) {
    level notify(#"checkpoint_wall_breach_complete");
}

// Namespace arena_defend
// Params 1, eflags: 0x0
// Checksum 0x4ed10e96, Offset: 0xc800
// Size: 0x182
function function_1ab1b112(a_ents) {
    mdl_clip = getent("arena_defend_checkpoint_wall_right_clip", "targetname");
    level function_1caab1d2(mdl_clip);
    if (isdefined(mdl_clip)) {
        mdl_clip delete();
    }
    wait 0.1;
    a_models = getentarray("arena_defend_checkpoint_wall_right_models", "script_noteworthy");
    foreach (mdl_wall in a_models) {
        mdl_wall delete();
    }
    spawner::simple_spawn("checkpoint_right_breach_raps");
    spawner::simple_spawn("sp_wp_04_robot_defenders");
    spawn_manager::enable("sm_wp_04_defenders");
    spawn_manager::enable("sm_wp_04_wasps");
    spawner::waittill_ai_group_count("checkpoint_right_breach_raps", 3);
    spawn_manager::enable("sm_checkpoint_right_fill_raps");
}

// Namespace arena_defend
// Params 0, eflags: 0x0
// Checksum 0x455497e0, Offset: 0xc990
// Size: 0xca
function function_69b7b359() {
    player = array::random(level.activeplayers);
    if (isplayer(player)) {
        self setgoal(player, 1);
    }
    ramses_util::function_3f4f84e("nd_raps_launch_point_1", "targetname", 1);
    ramses_util::function_3f4f84e("nd_raps_launch_point_2", "targetname", 1);
    ramses_util::function_3f4f84e("nd_raps_launch_point_3", "targetname", 1);
    ramses_util::function_3f4f84e("nd_raps_launch_point_4", "targetname", 1);
}

// Namespace arena_defend
// Params 1, eflags: 0x0
// Checksum 0x44ea5079, Offset: 0xca68
// Size: 0x3a
function function_34c51c66(a_ents) {
    trigger::wait_till("arena_defend_checkpoint_wall_right_trigger");
    level scene::play("p7_fxanim_cp_ramses_checkpoint_wall_02_bundle");
}

// Namespace arena_defend
// Params 1, eflags: 0x0
// Checksum 0x5c66181, Offset: 0xcab0
// Size: 0x2a
function function_d8e5f873(a_ents) {
    wait 3;
    level scene::play("p7_fxanim_cp_ramses_checkpoint_wall_01_bundle");
}

// Namespace arena_defend
// Params 2, eflags: 0x0
// Checksum 0x60fc38c9, Offset: 0xcae8
// Size: 0x5a
function function_43ae7eec(var_4629f7f4, var_4b7057d2) {
    if (!isdefined(var_4629f7f4)) {
        var_4629f7f4 = 1;
    }
    if (!isdefined(var_4b7057d2)) {
        var_4b7057d2 = 1;
    }
    if (var_4629f7f4) {
        function_bb278f94();
        return;
    }
    function_96944c1(var_4b7057d2);
}

// Namespace arena_defend
// Params 1, eflags: 0x0
// Checksum 0xf2a3f70f, Offset: 0xcb50
// Size: 0x5a
function function_96944c1(var_4b7057d2) {
    if (!isdefined(var_4b7057d2)) {
        var_4b7057d2 = 1;
    }
    level thread scene::skipto_end("p7_fxanim_cp_ramses_wall_drop_bundle");
    level flag::set("arena_defend_mobile_wall_deployed");
    if (var_4b7057d2) {
        function_5d4438c7();
    }
}

// Namespace arena_defend
// Params 0, eflags: 0x0
// Checksum 0x450f92c6, Offset: 0xcbb8
// Size: 0x82
function function_bb278f94() {
    scene::function_9e5b8cdb("p7_fxanim_cp_ramses_wall_drop_bundle");
    level thread scene::play("p7_fxanim_cp_ramses_wall_drop_bundle");
    ramses_util::function_ac2b4535("cin_ram_05_01_block_1st_rip", "arena_defend");
    level scene::play("cin_ram_05_01_block_1st_rip");
    level flag::set("intro_igc_done");
}

// Namespace arena_defend
// Params 0, eflags: 0x0
// Checksum 0xbbcd6d78, Offset: 0xcc48
// Size: 0x92
function function_5d4438c7() {
    var_58ee3480 = getent("wall_drop_doors", "targetname");
    if (!isdefined(var_58ee3480)) {
        var_58ee3480 = util::spawn_model("p7_fxanim_cp_ramses_mobile_wall_doors_mod");
        var_58ee3480.targetname = "wall_drop_doors";
    }
    assert(isdefined(var_58ee3480), "<dev string:x385>");
    level scene::play("p7_fxanim_cp_ramses_wall_drop_doors_up_bundle", var_58ee3480);
}

// Namespace arena_defend
// Params 0, eflags: 0x0
// Checksum 0xb6300390, Offset: 0xcce8
// Size: 0x92
function function_cce749ad() {
    var_58ee3480 = getent("wall_drop_doors", "targetname");
    if (!isdefined(var_58ee3480)) {
        var_58ee3480 = util::spawn_model("p7_fxanim_cp_ramses_mobile_wall_doors_mod");
        var_58ee3480.targetname = "wall_drop_doors";
    }
    assert(isdefined(var_58ee3480), "<dev string:x385>");
    level scene::play("p7_fxanim_cp_ramses_wall_drop_doors_down_bundle", var_58ee3480);
}

// Namespace arena_defend
// Params 0, eflags: 0x0
// Checksum 0x67cdd9ab, Offset: 0xcd88
// Size: 0xa2
function function_844b68d7() {
    level thread scene::skipto_end("wp_01", "targetname");
    level thread scene::skipto_end("wp_02", "targetname");
    level thread scene::skipto_end("wp_03", "targetname");
    level thread scene::skipto_end("wp_04", "targetname");
    level thread scene::skipto_end("wp_05", "targetname");
}

// Namespace arena_defend
// Params 0, eflags: 0x0
// Checksum 0xe926425f, Offset: 0xce38
// Size: 0xa2
function function_d92a2132() {
    level scene::stop("wp_01", "targetname", 1);
    level scene::stop("wp_02", "targetname", 1);
    level scene::stop("wp_03", "targetname", 1);
    level scene::stop("wp_04", "targetname", 1);
    level scene::stop("wp_05", "targetname", 1);
}

// Namespace arena_defend
// Params 1, eflags: 0x0
// Checksum 0x68d35e2e, Offset: 0xcee8
// Size: 0xe3
function function_6b5863a(a_ents) {
    var_aa65e706 = getent("ad_detonator_trig", "targetname");
    e_grenade = getent("sinkhole_grenade_ent", "targetname");
    a_s = struct::get_array(var_aa65e706.target, "targetname");
    foreach (s in a_s) {
        s thread function_94df6716(e_grenade);
    }
}

// Namespace arena_defend
// Params 1, eflags: 0x0
// Checksum 0xb2cdcd83, Offset: 0xcfd8
// Size: 0x99
function function_94df6716(e) {
    s_start = self;
    while (isdefined(s_start.target)) {
        s = struct::get(s_start.target, "targetname");
        e magicgrenadetype(getweapon("frag_grenade"), s.origin, (0, 0, 1), 0.1);
        s_start = s;
        wait 0.25;
    }
}

// Namespace arena_defend
// Params 0, eflags: 0x0
// Checksum 0x4f1e6f7c, Offset: 0xd080
// Size: 0x112
function function_52eeccd() {
    level.var_9bc0ad76 = [];
    var_522666ed = getentarray("arena_defend_models", "targetname");
    var_105a4022 = getentarray("arena_defend_sinkhole", "targetname");
    var_4e480925 = struct::get("sinkhole_street_spot", "targetname");
    foreach (m in var_522666ed) {
        if (!isdefined(m.script_noteworthy) || m.script_noteworthy != "ignore_paths") {
            m disconnectpaths();
        }
    }
    var_105a4022 ramses_util::hide_ents();
}

// Namespace arena_defend
// Params 1, eflags: 0x0
// Checksum 0xc8a33ec4, Offset: 0xd1a0
// Size: 0xab
function function_9cc779c7(a_ents) {
    var_3087b33c = a_ents["street_collapse_big_hole"];
    var_4d6bc9a1 = getentarray("arena_defend_street_col", "targetname");
    foreach (model in var_4d6bc9a1) {
        model linkto(var_3087b33c, "bck_ground_sec_07_jnt");
    }
}

// Namespace arena_defend
// Params 1, eflags: 0x0
// Checksum 0x448240f3, Offset: 0xd258
// Size: 0x17a
function function_be12945c(a_ents) {
    util::wait_network_frame();
    fxanim = getent("small_hole_01", "targetname");
    fxanim thread scene::init("p7_fxanim_cp_ramses_street_collapse_small_hole_01_drop_bundle");
    util::wait_network_frame();
    fxanim = getent("small_hole_02", "targetname");
    fxanim thread scene::init("p7_fxanim_cp_ramses_street_collapse_small_hole_02_drop_bundle");
    util::wait_network_frame();
    fxanim = getent("small_hole_03", "targetname");
    fxanim thread scene::init("p7_fxanim_cp_ramses_street_collapse_small_hole_03_drop_bundle");
    util::wait_network_frame();
    fxanim = getent("small_hole_04", "targetname");
    fxanim thread scene::init("p7_fxanim_cp_ramses_street_collapse_small_hole_04_drop_bundle");
    util::wait_network_frame();
    fxanim = getent("small_hole_05", "targetname");
    fxanim thread scene::init("p7_fxanim_cp_ramses_street_collapse_small_hole_05_drop_bundle");
}

// Namespace arena_defend
// Params 1, eflags: 0x0
// Checksum 0xb8770b8f, Offset: 0xd3e0
// Size: 0x17a
function function_397df6bc(a_ents) {
    level thread function_f93fee8e();
    fxanim = getent("small_hole_01", "targetname");
    fxanim thread scene::play("p7_fxanim_cp_ramses_street_collapse_small_hole_01_drop_bundle");
    fxanim = getent("small_hole_02", "targetname");
    fxanim thread scene::play("p7_fxanim_cp_ramses_street_collapse_small_hole_02_drop_bundle");
    fxanim = getent("small_hole_03", "targetname");
    fxanim thread scene::play("p7_fxanim_cp_ramses_street_collapse_small_hole_03_drop_bundle");
    fxanim = getent("small_hole_04", "targetname");
    fxanim thread scene::play("p7_fxanim_cp_ramses_street_collapse_small_hole_04_drop_bundle");
    fxanim = getent("small_hole_05", "targetname");
    fxanim thread scene::play("p7_fxanim_cp_ramses_street_collapse_small_hole_05_drop_bundle");
    var_50b2c343 = getent("street_collapse_trailer_cargo", "targetname");
    if (isdefined(var_50b2c343)) {
        var_50b2c343 delete();
    }
}

// Namespace arena_defend
// Params 0, eflags: 0x0
// Checksum 0xd64deaac, Offset: 0xd568
// Size: 0x9b
function function_f93fee8e() {
    var_2eb506d6 = getentarray("arena_defend_technical", "script_noteworthy");
    foreach (var_35a302af in var_2eb506d6) {
        var_35a302af disconnectpaths(0, 0);
        util::wait_network_frame();
    }
}

// Namespace arena_defend
// Params 1, eflags: 0x0
// Checksum 0x161b8742, Offset: 0xd610
// Size: 0x22
function function_c15cf2c8(a_ents) {
    level flag::set("sinkhole_collapse_complete");
}

// Namespace arena_defend
// Params 1, eflags: 0x0
// Checksum 0xe96b5f16, Offset: 0xd640
// Size: 0xbb
function function_5cee729c(a_ents) {
    level flag::set("arena_defend_sinkhole_igc_started");
    foreach (player in level.players) {
        player clientfield::set_to_player("set_dedicated_shadow", 1);
        player clientfield::set_to_player("dni_eye", 1);
    }
    level thread function_6e3e4c58();
    level notify(#"delete_javelins");
}

// Namespace arena_defend
// Params 0, eflags: 0x0
// Checksum 0x44f7ef29, Offset: 0xd708
// Size: 0x42
function function_6e3e4c58() {
    wait 0.5;
    level thread function_57df3b99(0);
    util::wait_network_frame();
    level scene::init("p7_fxanim_cp_ramses_street_collapse_big_hole_bundle");
}

// Namespace arena_defend
// Params 1, eflags: 0x0
// Checksum 0xfca52daa, Offset: 0xd758
// Size: 0x93
function function_19f02780(a_ents) {
    var_5fd4d3b9 = getentarray("lgt_shadow_block", "targetname");
    foreach (blocker in var_5fd4d3b9) {
        blocker show();
    }
}

// Namespace arena_defend
// Params 1, eflags: 0x0
// Checksum 0x39cc6e2, Offset: 0xd7f8
// Size: 0x82
function function_f2434205(a_ents) {
    function_f56aea9b();
    array::run_all(getaiteamarray("axis"), &delete);
    array::run_all(getcorpsearray(), &delete);
}

// Namespace arena_defend
// Params 1, eflags: 0x0
// Checksum 0xd9dee60b, Offset: 0xd888
// Size: 0x1a
function function_76cedf66(a_ents) {
    level thread function_c687aeb9(a_ents);
}

// Namespace arena_defend
// Params 1, eflags: 0x0
// Checksum 0x185a9697, Offset: 0xd8b0
// Size: 0x132
function function_c687aeb9(a_ents) {
    if (isdefined(a_ents["robot_arm"])) {
        a_ents["robot_arm"] hide();
        a_ents["robot_head"] hide();
        a_ents["robot_missing_arm"] hide();
        a_ents["robot_missing_arm_head"] hide();
        a_ents["robot_intact"] waittill(#"hash_be5a15e8");
        a_ents["robot_intact"] setmodel("c_nrc_robot_grunt_dam_dps_rarmoff");
        a_ents["robot_arm"] show();
        a_ents["robot_intact"] waittill(#"hide_head");
        a_ents["robot_intact"] detachall();
        a_ents["robot_intact"] setmodel("c_nrc_robot_grunt_dam_dps_rarmoff_headoff");
        a_ents["robot_head"] show();
    }
}

// Namespace arena_defend
// Params 1, eflags: 0x0
// Checksum 0xfaee6f1b, Offset: 0xd9f0
// Size: 0x12a
function function_ec8a2922(a_ents) {
    a_ents["robot_arm"] hide();
    a_ents["robot_head"] hide();
    a_ents["robot_missing_arm"] hide();
    a_ents["robot_missing_arm_head"] hide();
    a_ents["robot_intact"] waittill(#"hash_be5a15e8");
    a_ents["robot_missing_arm"] show();
    a_ents["robot_intact"] hide();
    a_ents["robot_arm"] show();
    a_ents["robot_intact"] waittill(#"hide_head");
    a_ents["robot_missing_arm_head"] show();
    a_ents["robot_missing_arm"] hide();
    a_ents["robot_head"] show();
}

// Namespace arena_defend
// Params 1, eflags: 0x0
// Checksum 0xeaf42560, Offset: 0xdb28
// Size: 0x12a
function function_128ca38b(a_ents) {
    a_ents["robot_arm"] ghost();
    a_ents["robot_head"] ghost();
    a_ents["robot_missing_arm"] ghost();
    a_ents["robot_missing_arm_head"] ghost();
    a_ents["robot_intact"] waittill(#"hash_be5a15e8");
    a_ents["robot_missing_arm"] show();
    a_ents["robot_intact"] ghost();
    a_ents["robot_arm"] show();
    a_ents["robot_intact"] waittill(#"hide_head");
    a_ents["robot_missing_arm_head"] show();
    a_ents["robot_missing_arm"] ghost();
    a_ents["robot_head"] show();
}

// Namespace arena_defend
// Params 1, eflags: 0x0
// Checksum 0x89a4aec7, Offset: 0xdc60
// Size: 0x8a
function function_963f32b(a_ents) {
    ramses_util::function_1aeb2873();
    level waittill(#"hash_66e11689");
    level flag::set("sinkhole_charges_detonated");
    function_a99364b5();
    level thread util::function_d8eaed3d(2);
    hidemiscmodels("alley_doors");
    showmiscmodels("alley_doors_open");
}

// Namespace arena_defend
// Params 1, eflags: 0x0
// Checksum 0x43eefc41, Offset: 0xdcf8
// Size: 0x8a
function function_ce13c58d(a_ents) {
    a_ents["player 1"] clientfield::set_to_player("dni_eye", 0);
    array::run_all(getaiteamarray("axis"), &delete);
    level scene::init("cin_ram_05_demostreet_3rd_sh100");
    util::clear_streamer_hint();
}

// Namespace arena_defend
// Params 1, eflags: 0x0
// Checksum 0x1b7a1738, Offset: 0xdd90
// Size: 0x1a
function function_2ec70f8b(a_ents) {
    ramses_util::function_22e1a261();
}

// Namespace arena_defend
// Params 1, eflags: 0x0
// Checksum 0xfdd4038c, Offset: 0xddb8
// Size: 0xf2
function function_f3dffed(a_ents) {
    level flag::set("arena_defend_sinkhole_collapse_done");
    level.var_9db406db delete();
    var_5fd4d3b9 = getentarray("lgt_shadow_block", "targetname");
    foreach (blocker in var_5fd4d3b9) {
        blocker hide();
    }
    showmiscmodels("alley_doors");
    hidemiscmodels("alley_doors_open");
}

// Namespace arena_defend
// Params 1, eflags: 0x0
// Checksum 0xfbcfb4d7, Offset: 0xdeb8
// Size: 0x6a
function function_e4fcbd75(a_ents) {
    var_32d013aa = getdvarint("ui_execdemo_cp", 0);
    if (var_32d013aa) {
        level waittill(#"hash_4b89bb4a");
        skipto::function_1b5a2a11();
        level lui::screen_fade_out(2);
        exitlevel(0);
    }
}

// Namespace arena_defend
// Params 0, eflags: 0x0
// Checksum 0xe13de28, Offset: 0xdf30
// Size: 0x32
function function_eb0491d7() {
    self endon(#"death");
    self ai::set_ignoreall(1);
    self ai::set_behavior_attribute("sprint", 1);
}

// Namespace arena_defend
// Params 1, eflags: 0x0
// Checksum 0xe28fbda, Offset: 0xdf70
// Size: 0x32
function function_982fed86(a_ents) {
    ai_guy = a_ents["detonation_guy"];
    ai_guy ai::gun_remove();
}

// Namespace arena_defend
// Params 1, eflags: 0x0
// Checksum 0x99ddd9b0, Offset: 0xdfb0
// Size: 0x172
function function_bf4445e6(a_ents) {
    ai_guy = a_ents["detonation_guy"];
    ai_guy waittill(#"hash_ee94e3ac");
    var_3d57e9f = a_ents["detonator"];
    var_3d57e9f.script_noteworthy = "arena_defend_detonator_pickup_model";
    var_3d57e9f oed::function_e228c18a(1);
    trigger = spawn("trigger_radius_use", var_3d57e9f.origin + (0, 0, 10), 0, 85, -128);
    trigger triggerignoreteam();
    trigger setvisibletoall();
    trigger setteamfortrigger("none");
    var_c960aa14 = getentarray("temp_detonator_button", "targetname");
    var_49ddde9 = util::function_14518e76(trigger, %cp_level_ramses_detonator, %CP_MI_CAIRO_RAMSES_DETONATOR_TRIG, &function_dcc9f49f, var_c960aa14);
    var_49ddde9.script_objective = "sinkhole_collapse";
    level flag::set("arena_defend_detonator_dropped");
}

// Namespace arena_defend
// Params 1, eflags: 0x0
// Checksum 0x9a648bc8, Offset: 0xe130
// Size: 0x3a
function function_dcc9f49f(player) {
    level.var_8e659b82 = player;
    level flag::set("arena_defend_detonator_pickup");
    self gameobjects::destroy_object(1);
}

// Namespace arena_defend
// Params 0, eflags: 0x0
// Checksum 0x251861f8, Offset: 0xe178
// Size: 0xaa
function function_c693a390() {
    level.var_2fd26037 ai::set_behavior_attribute("cqb", 0);
    level.var_2fd26037 ai::set_behavior_attribute("disablesprint", 1);
    level.var_2fd26037 ai::set_ignoreall(1);
    level thread scene::init("cin_ram_05_01_defend_vign_leapattack");
    level util::waittill_notify_or_timeout("hendricks_leap_started", 8);
    ramses_util::function_3f4f84e("arena_defend_mobile_wall_top_nodes", "script_noteworthy", 1);
}

// Namespace arena_defend
// Params 1, eflags: 0x0
// Checksum 0x721d3bee, Offset: 0xe230
// Size: 0xd2
function function_a7405e61(a_ents) {
    self util::delay_notify(30, self.scriptbundlename + "_cancelled");
    function_670e94a("axis", "human", "arena_defend_vignette_hendricks_leap_guy_front", "guy_shot");
    function_670e94a("axis", "human", "arena_defend_vignette_hendricks_leap_guy_rear", "guy_grenade");
    self flag::wait_till_all(self.var_a42c7b03);
    self notify(self.scriptbundlename + "_starting");
    level notify(#"hendricks_leap_started");
    self scene::play(self.var_8060ff07);
}

// Namespace arena_defend
// Params 1, eflags: 0x0
// Checksum 0x4cdbdf6, Offset: 0xe310
// Size: 0xe2
function function_f295baeb(a_ents) {
    var_6b3fcdf5 = getnode("hendricks_leap_end_node", "targetname");
    assert(isdefined(var_6b3fcdf5), "<dev string:x3ec>");
    level.var_2fd26037 ai::set_behavior_attribute("disablesprint", 0);
    level.var_2fd26037 ai::set_ignoreall(0);
    level.var_2fd26037 colors::disable();
    level.var_2fd26037 setgoal(var_6b3fcdf5);
    wait randomfloatrange(5, 8);
    level.var_2fd26037 colors::enable();
}

// Namespace arena_defend
// Params 6, eflags: 0x0
// Checksum 0x64522a09, Offset: 0xe400
// Size: 0x10a
function function_670e94a(str_faction, str_type, str_node, str_flag, str_endon, var_d985d5a0) {
    if (isdefined(str_endon)) {
        self endon(str_endon);
    }
    if (!self flag::exists(str_flag)) {
        if (!isdefined(self.var_a42c7b03)) {
            self.var_a42c7b03 = [];
        }
        if (!isdefined(self.var_a42c7b03)) {
            self.var_a42c7b03 = [];
        } else if (!isarray(self.var_a42c7b03)) {
            self.var_a42c7b03 = array(self.var_a42c7b03);
        }
        self.var_a42c7b03[self.var_a42c7b03.size] = str_flag;
        self flag::init(str_flag);
    }
    self flag::clear(str_flag);
    self thread function_19286245(str_faction, str_type, str_node, str_flag, str_endon, var_d985d5a0);
}

// Namespace arena_defend
// Params 6, eflags: 0x0
// Checksum 0xb0da7301, Offset: 0xe518
// Size: 0x11a
function function_19286245(str_faction, str_type, str_node, str_flag, str_endon, n_distance) {
    if (!isdefined(n_distance)) {
        n_distance = 400;
    }
    self endon(self.scriptbundlename + "_starting");
    self endon(self.scriptbundlename + "_cancelled");
    if (!isdefined(self.var_8060ff07)) {
        self.var_8060ff07 = [];
    }
    do {
        ai_guy = function_448954e7(str_type, str_faction, str_node, n_distance, 0);
    } while (!isdefined(ai_guy) || !isalive(ai_guy));
    self flag::set(str_flag);
    self.var_8060ff07[str_flag] = ai_guy;
    ai_guy util::waittill_any("death", "start_ragdoll");
    arrayremovevalue(self.var_8060ff07, ai_guy, 0);
    self function_670e94a(str_faction, str_type, str_node, str_flag, str_endon);
}

// Namespace arena_defend
// Params 3, eflags: 0x0
// Checksum 0x303686d7, Offset: 0xe640
// Size: 0xfa
function function_f589aed(str_hero, str_node, str_flag) {
    if (!isdefined(self.var_8060ff07)) {
        self.var_8060ff07 = [];
    }
    self.var_8060ff07[str_flag] = util::function_740f8516(str_hero);
    if (!self flag::exists(str_flag)) {
        if (!isdefined(self.var_a42c7b03)) {
            self.var_a42c7b03 = [];
        }
        if (!isdefined(self.var_a42c7b03)) {
            self.var_a42c7b03 = [];
        } else if (!isarray(self.var_a42c7b03)) {
            self.var_a42c7b03 = array(self.var_a42c7b03);
        }
        self.var_a42c7b03[self.var_a42c7b03.size] = str_flag;
        self flag::init(str_flag);
    }
    self thread function_4fa4774e(str_hero, str_node, str_flag);
}

// Namespace arena_defend
// Params 3, eflags: 0x0
// Checksum 0x5c762e06, Offset: 0xe748
// Size: 0x182
function function_4fa4774e(str_hero, str_node, str_flag) {
    ai_hero = util::function_740f8516(str_hero);
    var_9de10fe3 = getnode(str_node, "targetname");
    assert(isdefined(var_9de10fe3), "<dev string:x434>" + str_hero + "<dev string:x45b>" + self.scriptbundlename);
    var_4345e897 = ai_hero.goalradius;
    ai_hero.goalradius = 32;
    if (ai_hero colors::has_color()) {
        ai_hero colors::disable();
    }
    ai_hero setgoal(var_9de10fe3, 1);
    ai_hero util::waittill_any_timeout(15, "goal");
    self flag::set(str_flag);
    self util::waittill_any(self.scriptbundlename + "_starting", self.scriptbundlename + "_cancelled");
    ai_hero.goalradius = var_4345e897;
    if (ai_hero colors::has_color()) {
        ai_hero colors::enable();
    }
}

// Namespace arena_defend
// Params 1, eflags: 0x0
// Checksum 0x2f0a3013, Offset: 0xe8d8
// Size: 0x62
function function_e419e693(a_ents) {
    if (isdefined(level.var_2fd26037.var_e6e961e4)) {
        level.var_2fd26037.goalradius = level.var_2fd26037.var_e6e961e4;
        level.var_2fd26037.var_e6e961e4 = undefined;
    }
    level.var_2fd26037 colors::enable();
}

// Namespace arena_defend
// Params 1, eflags: 0x0
// Checksum 0xafc6c86d, Offset: 0xe948
// Size: 0xba
function function_a6ca068f(a_ents) {
    level endon(#"all_weak_points_destroyed");
    level endon(#"hash_18cf70dc");
    self flag::init("hendricks_ready");
    self thread function_ec1da064();
    var_f6c5842 = self function_c0e05dd();
    var_f6c5842 endon(#"death");
    self flag::wait_till("hendricks_ready");
    var_8060ff07 = [];
    var_8060ff07["hendricks"] = level.var_2fd26037;
    var_8060ff07["robot"] = var_f6c5842;
    level scene::play("cin_gen_melee_hendricksmoment_closecombat_robot", var_8060ff07);
}

// Namespace arena_defend
// Params 0, eflags: 0x0
// Checksum 0xa2a775bd, Offset: 0xea10
// Size: 0xb2
function function_ec1da064() {
    var_dfcbd82b = getnode("melee_robot_vignette_goal_hendricks", "targetname");
    level.var_2fd26037 colors::disable();
    level.var_2fd26037.var_e6e961e4 = level.var_2fd26037.goalradius;
    level.var_2fd26037.goalradius = 32;
    level.var_2fd26037 ai::force_goal(var_dfcbd82b);
    level.var_2fd26037 waittill(#"goal");
    self flag::set("hendricks_ready");
}

// Namespace arena_defend
// Params 0, eflags: 0x0
// Checksum 0x3fb000ca, Offset: 0xead0
// Size: 0x57
function function_c0e05dd() {
    do {
        var_f6c5842 = function_448954e7("robot", "axis", "melee_robot_vignette_goal_robot", 1000, 0, 0);
    } while (!isdefined(var_f6c5842) || !isalive(var_f6c5842));
    return var_f6c5842;
}

// Namespace arena_defend
// Params 1, eflags: 0x0
// Checksum 0x58c98246, Offset: 0xeb30
// Size: 0xa3
function function_33280827(a_ents) {
    foreach (ent in a_ents) {
        if (isai(ent)) {
            ent thread function_13518c6(10);
            ent thread function_310c8dc8(15);
            ent setgoal(ent.origin);
        }
    }
}

// Namespace arena_defend
// Params 1, eflags: 0x0
// Checksum 0x946ccae3, Offset: 0xebe0
// Size: 0x13
function function_7c00379f(a_ents) {
    level notify(#"hash_e75ae3d1");
}

// Namespace arena_defend
// Params 1, eflags: 0x0
// Checksum 0x66eca381, Offset: 0xec00
// Size: 0x4e
function function_310c8dc8(n_time) {
    self endon(#"death");
    var_c5e3e899 = self.goalradius;
    self.goalradius = 64;
    self setgoal(self.origin);
    wait n_time;
    self.goalradius = var_c5e3e899;
}

// Namespace arena_defend
// Params 1, eflags: 0x0
// Checksum 0x14547cb3, Offset: 0xec58
// Size: 0x4a
function function_13518c6(n_time) {
    self endon(#"death");
    self ai::set_ignoreme(1);
    level util::waittill_notify_or_timeout("all_weak_points_destroyed", n_time);
    self ai::set_ignoreme(0);
}

// Namespace arena_defend
// Params 1, eflags: 0x0
// Checksum 0x3ff8f028, Offset: 0xecb0
// Size: 0xf3
function function_3838410f(a_ents) {
    foreach (player in level.players) {
        player switchtoweaponimmediate(getweapon("spike_launcher"));
    }
    util::clear_streamer_hint();
    wait 2;
    foreach (player in level.players) {
        player thread ramses_util::function_508a129e("clear_spike_hints");
    }
}

// Namespace arena_defend
// Params 1, eflags: 0x0
// Checksum 0xd6562874, Offset: 0xedb0
// Size: 0x5a
function function_25e4bdcc(a_ents) {
    var_45900c37 = a_ents["technical"];
    var_45900c37 disconnectpaths(0, 0);
    if (isdefined(a_ents["hendricks"])) {
        skipto::teleport_ai("arena_defend");
    }
}

// Namespace arena_defend
// Params 1, eflags: 0x0
// Checksum 0x53ee5f91, Offset: 0xee18
// Size: 0x24a
function function_57df3b99(var_f9118324) {
    if (!isdefined(var_f9118324)) {
        var_f9118324 = 0;
    }
    function_52eeccd();
    level.var_9bc0ad76 = getentarray("arena_defend_models", "targetname");
    var_105a4022 = getentarray("arena_defend_sinkhole", "targetname");
    var_4e480925 = struct::get("sinkhole_street_spot", "targetname");
    util::wait_network_frame();
    array::delete_all(level.var_9bc0ad76);
    util::wait_network_frame();
    util::wait_network_frame();
    var_105a4022 ramses_util::show_ents();
    util::wait_network_frame();
    hidemiscmodels("sinkhole_misc_model");
    level clientfield::increment("clear_all_dyn_ents", 1);
    if (var_f9118324) {
        var_4d6bc9a1 = getentarray("arena_defend_street_col", "targetname");
        foreach (model in var_4d6bc9a1) {
            model delete();
        }
    }
    if (level scene::is_active("cin_ram_05_01_quadtank_flatbed_pose")) {
        level scene::stop("cin_ram_05_01_quadtank_flatbed_pose", 1);
    }
    if (level scene::is_active("cin_ram_05_01_defend_vign_rescueinjured_l_group")) {
        level scene::stop("cin_ram_05_01_defend_vign_rescueinjured_l_group", 1);
    }
    if (level scene::is_active("cin_ram_05_01_defend_vign_rescueinjured_r_group")) {
        level scene::stop("cin_ram_05_01_defend_vign_rescueinjured_r_group", 1);
    }
}

// Namespace arena_defend
// Params 1, eflags: 0x0
// Checksum 0x94133f72, Offset: 0xf070
// Size: 0x4a
function function_a99364b5(var_32db0b52) {
    if (!isdefined(var_32db0b52)) {
        var_32db0b52 = 1;
    }
    if (var_32db0b52) {
        level thread scene::play("p7_fxanim_cp_ramses_street_collapse_big_hole_bundle");
        return;
    }
    level thread scene::skipto_end("p7_fxanim_cp_ramses_street_collapse_big_hole_bundle");
}

// Namespace arena_defend
// Params 0, eflags: 0x0
// Checksum 0xe605f65a, Offset: 0xf0c8
// Size: 0xf2
function function_3eb1d89e() {
    var_9e3dc64d = getentarray("checkpoint_wall", "targetname");
    var_9f1c136d = getent("mobile_wall_model", "targetname");
    var_7232aa12 = getentarray("mobile_wall_clip", "targetname");
    var_3388f11b = getent("mobile_wall_doors_model", "targetname");
    if (isdefined(var_9f1c136d)) {
        var_9f1c136d delete();
    }
    array::delete_all(var_9e3dc64d);
    array::delete_all(var_7232aa12);
    if (isdefined(var_3388f11b)) {
        var_3388f11b delete();
    }
}

// Namespace arena_defend
// Params 0, eflags: 0x0
// Checksum 0xe9c07cd6, Offset: 0xf1c8
// Size: 0x2
function function_38d8eaf7() {
    
}

// Namespace arena_defend
// Params 0, eflags: 0x0
// Checksum 0xaa900025, Offset: 0xf1d8
// Size: 0x1a
function function_9f94867c() {
    level clientfield::set("arena_defend_fxanim_hunters", 0);
}

// Namespace arena_defend
// Params 0, eflags: 0x0
// Checksum 0x1e35f758, Offset: 0xf200
// Size: 0xe2
function objectives() {
    level waittill(#"hash_cf46ef3a");
    level flag::set("weak_points_objective_active");
    level flag::wait_till("all_weak_points_destroyed");
    level flag::clear("weak_points_objective_active");
    level flag::wait_till_any(array("mobile_wall_doors_closing", "arena_defend_detonator_dropped"));
    objectives::complete("cp_level_ramses_fall_back");
    level flag::wait_till("sinkhole_charges_detonated");
    objectives::complete("cp_level_ramses_detonator");
    objectives::complete("cp_level_ramses_demolish_arena_defend");
}

// Namespace arena_defend
// Params 0, eflags: 0x0
// Checksum 0x7d421de6, Offset: 0xf2f0
// Size: 0xb5
function function_6f24118d() {
    var_ea644274 = getactorteamarray("allies");
    while (true) {
        var_aa24f038 = arraysortclosest(var_ea644274, level.players[0].origin);
        for (i = 0; i < var_aa24f038.size; i++) {
            if (!isinarray(level.heroes, var_aa24f038[i]) && isalive(var_aa24f038[i])) {
                return var_aa24f038[i];
            }
        }
        wait 0.25;
    }
}

// Namespace arena_defend
// Params 1, eflags: 0x0
// Checksum 0xa26e16d8, Offset: 0xf3b0
// Size: 0x29
function function_7ff50323(var_2d3d7b7) {
    n_line = randomintrange(0, var_2d3d7b7.size);
    return var_2d3d7b7[n_line];
}

// Namespace arena_defend
// Params 0, eflags: 0x0
// Checksum 0x12bd460b, Offset: 0xf3e8
// Size: 0xad
function function_181343bc() {
    level endon(#"all_weak_points_destroyed");
    var_2d3d7b7 = [];
    var_2d3d7b7[0] = "esl1_enemy_down_0";
    var_2d3d7b7[1] = "egy2_that_s_a_bad_way_to_0";
    var_2d3d7b7[2] = "esl3_it_went_right_throug_0";
    var_2d3d7b7[3] = "esl4_he_got_torn_up_0";
    while (true) {
        level waittill(#"hash_2de65b48");
        ai_guy = function_6f24118d();
        ai_guy thread dialog::say(function_7ff50323(var_2d3d7b7));
        wait randomintrange(90, 120);
    }
}

// Namespace arena_defend
// Params 0, eflags: 0x0
// Checksum 0x3d52fb58, Offset: 0xf4a0
// Size: 0x72
function function_7ad9ea68() {
    level dialog::function_13b3b16a("plyr_kane_search_the_cit_0");
    level dialog::remote("kane_got_to_give_me_time_0");
    level dialog::function_13b3b16a("plyr_we_don_t_have_time_0");
    function_942c6e92();
    level flag::set("arena_defend_initial_weak_point_search_finished");
}

// Namespace arena_defend
// Params 0, eflags: 0x0
// Checksum 0x7ebc2291, Offset: 0xf520
// Size: 0x8a
function function_c661367c() {
    level endon(#"wp_01_destroyed");
    level flag::wait_till("arena_defend_initial_weak_point_search_finished");
    level thread dialog::remote("kane_okay_i_ve_located_t_0");
    level thread namespace_a6a248fc::function_9574e08d();
    wait 1;
    level thread lui::play_movie("cp_ramses2_pip_unstableground", "pip");
    wait 3;
    level notify(#"hash_cf46ef3a");
    level thread function_7b768906();
}

// Namespace arena_defend
// Params 0, eflags: 0x0
// Checksum 0xff97c003, Offset: 0xf5b8
// Size: 0xd2
function function_942c6e92() {
    var_35a302af = getent("arena_defend_technical_01_vh", "targetname");
    if (isalive(var_35a302af)) {
        var_2d3d7b7 = [];
        var_2d3d7b7[0] = "esl3_eyes_on_enemy_techni_0";
        var_2d3d7b7[1] = "esl4_hostile_technical_mo_0";
        ai_guy = function_6f24118d();
        ai_guy dialog::say(function_7ff50323(var_2d3d7b7));
    }
    if (isalive(var_35a302af)) {
        level.var_2fd26037 dialog::say("hend_someone_move_on_that_0");
    }
}

// Namespace arena_defend
// Params 0, eflags: 0x0
// Checksum 0x964dfe18, Offset: 0xf698
// Size: 0x10a
function function_7b768906() {
    level endon(#"hash_18cf70dc");
    foreach (player in level.activeplayers) {
        player thread function_54380572();
    }
    level waittill(#"hash_b7604d6c");
    level.var_2fd26037 dialog::say("hend_not_good_enough_go_0");
    level waittill(#"hash_b7604d6c");
    level.var_2fd26037 dialog::say("hend_you_gotta_hammer_the_0");
    level waittill(#"hash_b7604d6c");
    level.var_2fd26037 dialog::say("hend_we_need_the_spikes_o_0");
    level waittill(#"hash_b7604d6c");
    level.var_2fd26037 dialog::say("hend_can_t_do_it_at_range_0");
}

// Namespace arena_defend
// Params 0, eflags: 0x0
// Checksum 0xe6fec3ea, Offset: 0xf7b0
// Size: 0x63
function function_54380572() {
    level endon(#"hash_18cf70dc");
    self endon(#"death");
    for (var_39ba7753 = 0; true; var_39ba7753 = 0) {
        self waittill(#"weapon_fired", w_current);
        if (w_current === level.var_1b7b3a6) {
            var_39ba7753++;
            if (var_39ba7753 >= 3) {
                level notify(#"hash_b7604d6c");
            }
        }
    }
}

// Namespace arena_defend
// Params 0, eflags: 0x0
// Checksum 0xa940753a, Offset: 0xf820
// Size: 0x92
function function_1d79812() {
    foreach (player in level.activeplayers) {
        player thread function_e5f94949();
    }
    level.var_2fd26037 thread dialog::say("hend_target_confirmed_0", 1);
    level thread function_8b9ed044();
}

// Namespace arena_defend
// Params 0, eflags: 0x0
// Checksum 0x7752a169, Offset: 0xf8c0
// Size: 0xaa
function function_8b9ed044() {
    level endon(#"all_weak_points_destroyed");
    level waittill(#"hash_18cf70dc");
    level.var_2fd26037 dialog::say("hend_blow_that_fucker_0", 1);
    level waittill(#"hash_18cf70dc");
    level.var_2fd26037 thread dialog::say("hend_spike_set_blow_it_0", 1);
    level waittill(#"hash_18cf70dc");
    level.var_2fd26037 thread dialog::say("hend_blow_that_spike_0", 1);
    level waittill(#"hash_18cf70dc");
    level.var_2fd26037 thread dialog::say("hend_spike_on_target_de_0", 1);
}

// Namespace arena_defend
// Params 0, eflags: 0x0
// Checksum 0x5bfed3f6, Offset: 0xf978
// Size: 0x72
function function_e5f94949() {
    level endon(#"all_weak_points_destroyed");
    self endon(#"death");
    self waittill(#"spike_ammo_missing");
    self thread dialog::function_13b3b16a("plyr_dammit_i_m_out_of_s_0");
    self waittill(#"spike_ammo_missing");
    self thread dialog::function_13b3b16a("plyr_need_a_reload_0");
    self waittill(#"spike_ammo_missing");
    self thread dialog::function_13b3b16a("plyr_i_m_all_out_need_m_0");
}

// Namespace arena_defend
// Params 0, eflags: 0x0
// Checksum 0x8b46b622, Offset: 0xf9f8
// Size: 0x1a
function function_2fa2a80f() {
    level dialog::function_13b3b16a("plyr_detonation_confirmed_0", 1);
}

// Namespace arena_defend
// Params 0, eflags: 0x0
// Checksum 0x362a1d73, Offset: 0xfa20
// Size: 0x72
function function_60f90684() {
    var_2d3d7b7 = [];
    var_2d3d7b7[0] = "esl1_i_got_grunts_scaling_0";
    var_2d3d7b7[1] = "egy2_heads_up_hostile_0";
    var_2d3d7b7[2] = "esl3_look_out_enemy_grun_0";
    ai_guy = function_6f24118d();
    ai_guy thread dialog::say(function_7ff50323(var_2d3d7b7));
}

// Namespace arena_defend
// Params 0, eflags: 0x0
// Checksum 0x561c4fc0, Offset: 0xfaa0
// Size: 0x5a
function function_d5457906() {
    level thread dialog::remote("kane_two_more_in_the_nort_0");
    wait 0.5;
    wait 2;
    level dialog::function_13b3b16a("plyr_copy_that_hendricks_0");
    level.var_2fd26037 dialog::say("hend_you_re_good_go_0", 1);
}

// Namespace arena_defend
// Params 0, eflags: 0x0
// Checksum 0xe9c07cd6, Offset: 0xfb08
// Size: 0x2
function function_19751093() {
    
}

// Namespace arena_defend
// Params 0, eflags: 0x0
// Checksum 0xdeb24889, Offset: 0xfb18
// Size: 0x1a
function function_102382b1() {
    level dialog::remote("ecmd_nrc_reinforcements_f_0");
}

// Namespace arena_defend
// Params 0, eflags: 0x0
// Checksum 0x2876c5a2, Offset: 0xfb40
// Size: 0x1a
function function_a47d54df() {
    level thread dialog::remote("kane_last_two_0", 1);
}

// Namespace arena_defend
// Params 0, eflags: 0x0
// Checksum 0xfe6af85, Offset: 0xfb68
// Size: 0x6a
function function_8394a26f() {
    level endon(#"all_weak_points_destroyed");
    wait 0.75;
    level dialog::remote("kane_this_is_it_last_on_0");
    level thread dialog::remote("ecmd_nrc_reinforcements_i_0");
    level waittill(#"hash_18cf70dc");
    level.var_2fd26037 thread dialog::say("hend_blow_it_0", 2);
}

// Namespace arena_defend
// Params 0, eflags: 0x0
// Checksum 0x29370004, Offset: 0xfbe0
// Size: 0x1ba
function function_66f027df() {
    util::wait_network_frame();
    if (!level flag::get("mobile_wall_doors_closing")) {
        level.var_2fd26037 dialog::say("hend_that_s_it_we_got_0");
    }
    objectives::set("cp_level_ramses_fall_back");
    level thread objectives::breadcrumb("arena_defend_wall_gather_trig");
    if (!level flag::get("mobile_wall_doors_closing")) {
        if (isdefined(level.var_9db406db)) {
            var_2d3d7b7 = [];
            var_2d3d7b7[0] = "khal_we_have_to_blow_the_0";
            var_2d3d7b7[1] = "khal_hurry_we_have_to_bl_0";
            var_2d3d7b7[2] = "hend_fall_back_to_mobile_0";
            var_2d3d7b7[3] = "hend_get_the_fuck_back_g_0";
            var_2d3d7b7[4] = "hend_fall_back_behind_the_0";
            level.var_9db406db dialog::say(function_7ff50323(var_2d3d7b7));
        }
    }
    if (!level flag::get("mobile_wall_doors_closing")) {
        var_2d3d7b7 = [];
        var_2d3d7b7[0] = "esl1_get_behind_the_wall_0";
        var_2d3d7b7[1] = "egy2_move_behind_the_mobi_0";
        var_2d3d7b7[2] = "esl1_get_behind_the_wall_1";
        if (level.var_31aefea8 != "dev_sinkhole_test") {
            ai_guy = function_6f24118d();
            ai_guy thread dialog::say(function_7ff50323(var_2d3d7b7), 5);
        }
    }
    level thread function_d3adcddf();
}

// Namespace arena_defend
// Params 0, eflags: 0x0
// Checksum 0xa8630819, Offset: 0xfda8
// Size: 0x3a
function function_d3adcddf() {
    level dialog::remote("kane_we_got_javelin_missi_0");
    level.var_2fd26037 dialog::say("hend_incoming_1");
}

// Namespace arena_defend
// Params 0, eflags: 0x0
// Checksum 0x6fc93a87, Offset: 0xfdf0
// Size: 0x2a
function function_a8e2a95() {
    if (isdefined(level.var_9db406db)) {
        level.var_9db406db dialog::say("khal_get_on_top_of_wall_0");
    }
}

// Namespace arena_defend
// Params 1, eflags: 0x0
// Checksum 0xb0c6ef47, Offset: 0xfe28
// Size: 0x99
function function_350af383(var_ac8ea4f8) {
    level endon(#"hash_fc0ed87");
    var_2d3d7b7 = [];
    var_2d3d7b7[0] = "esl4_let_s_see_them_climb_0";
    var_2d3d7b7[1] = "esl3_they_won_t_be_coming_0";
    var_2d3d7b7[2] = "egy2_they_think_we_ll_bre_0";
    var_2d3d7b7[3] = "esl1_our_will_won_t_be_br_0";
    if (var_ac8ea4f8 > var_2d3d7b7.size) {
        for (i = 0; i < var_2d3d7b7.size; i++) {
            var_ac8ea4f8[i] dialog::say(var_2d3d7b7[i]);
            wait 0.5;
        }
    }
}

/#

    // Namespace arena_defend
    // Params 2, eflags: 0x0
    // Checksum 0x72a92ade, Offset: 0xfed0
    // Size: 0x95
    function function_fd1e50c8(e, n_timer) {
        self endon(#"death");
        n_timer = gettime() + n_timer * 1000;
        while (gettime() < n_timer) {
            line(self.origin + (0, 0, 300), e.origin, (1, 0, 0), 0.1);
            debug::drawarrow(e.origin, e.angles);
            wait 0.05;
        }
    }

#/

// Namespace arena_defend
// Params 2, eflags: 0x0
// Checksum 0x16eaeedd, Offset: 0xff70
// Size: 0x132
function dev_weak_point_test(str_objective, var_74cd64bc) {
    function_c4fc0ade(str_objective, var_74cd64bc);
    function_e8a47a87();
    level thread function_43ae7eec(0, 1);
    level flag::set("weak_points_objective_active");
    vehicle::add_spawn_function("arena_defend_technical_01", &function_c3bff305);
    vehicle::simple_spawn_single("arena_defend_technical_01");
    function_7da8c2ae();
    scene::add_scene_func("p7_fxanim_cp_ramses_street_collapse_small_hole_01_bundle", &function_d8e5f873, "play");
    scene::add_scene_func("p7_fxanim_cp_ramses_street_collapse_small_hole_04_bundle", &function_34c51c66, "play");
    function_3e55e3();
    dev_sinkhole_test("dev_sinkhole_test", 0);
}

// Namespace arena_defend
// Params 2, eflags: 0x0
// Checksum 0x3f7676c0, Offset: 0x100b0
// Size: 0x12
function function_d1d0f160(str_objective, var_74cd64bc) {
    
}

// Namespace arena_defend
// Params 1, eflags: 0x0
// Checksum 0x819e4c50, Offset: 0x100d0
// Size: 0x93
function function_8494dbb(str_waypoint) {
    var_9bb18713 = getentarray("collision_" + str_waypoint, "targetname");
    foreach (var_44febfef in var_9bb18713) {
        var_44febfef delete();
    }
}

// Namespace arena_defend
// Params 2, eflags: 0x0
// Checksum 0x8c25d50e, Offset: 0x10170
// Size: 0x292
function dev_sinkhole_test(str_objective, var_74cd64bc) {
    if (var_74cd64bc) {
        function_b6da2f7c();
        level flag::wait_till("all_players_spawned");
    }
    ramses_util::function_f2f98cfc();
    vtol_igc::function_fc9630cb();
    function_1a5a4627();
    function_c50ca91();
    function_e29f0dd6(str_objective, var_74cd64bc);
    function_8f461d35(0);
    function_52eeccd();
    level thread function_43ae7eec(0, 1);
    function_a760a823();
    level thread function_9b890ccb();
    function_30f53fbc();
    level flag::set("all_weak_points_destroyed");
    function_844b68d7();
    function_8494dbb("wp_01");
    function_8494dbb("wp_02");
    function_8494dbb("wp_03");
    function_8494dbb("wp_04");
    wait 1;
    level thread function_c779fef1();
    level thread util::function_1ec499f0("PRESS RIGHT ON D-PAD TO PLAY FINAL SCENE", undefined, undefined, undefined, 10);
    while (true) {
        if (level.players[0] actionslotfourbuttonpressed()) {
            break;
        }
        wait 0.05;
    }
    util::function_77f8007d();
    function_2e8bcd54();
    function_4dcf9e47();
    level notify(#"hash_87039547");
    level thread function_3d3f7691();
    spawn_manager::enable("arena_defend_wall_allies");
    level flag::wait_till("arena_defend_sinkhole_collapse_done");
    function_2fcc9369("arena_defend_spawn_manager");
    function_53314bf6();
    ramses_util::function_5ad47384();
    skipto::function_be8adfb8(str_objective);
}

// Namespace arena_defend
// Params 0, eflags: 0x0
// Checksum 0x8565202c, Offset: 0x10410
// Size: 0x1f
function function_c779fef1() {
    level thread objectives();
    wait 1;
    level notify(#"hash_cf46ef3a");
}

// Namespace arena_defend
// Params 0, eflags: 0x0
// Checksum 0x43229a1c, Offset: 0x10438
// Size: 0x42
function function_a760a823() {
    var_1bc0905e = vehicle::simple_spawn_single("arena_defend_intro_technical");
    var_1bc0905e dodamage(var_1bc0905e.health, var_1bc0905e.origin);
}

// Namespace arena_defend
// Params 4, eflags: 0x0
// Checksum 0x34569273, Offset: 0x10488
// Size: 0x32
function function_893047b8(str_objective, var_74cd64bc, var_e4cd2b8b, player) {
    function_26aaae96();
}

// Namespace arena_defend
// Params 0, eflags: 0x0
// Checksum 0x22d9ac97, Offset: 0x104c8
// Size: 0x18b
function function_7da8c2ae() {
    a_data = function_785a0ed();
    a_flags = [];
    foreach (wave in a_data) {
        foreach (var_20488710 in wave) {
            arraycombine(a_flags, var_20488710.var_2f201aa5, 0, 0);
            if (!isdefined(a_flags)) {
                a_flags = [];
            } else if (!isarray(a_flags)) {
                a_flags = array(a_flags);
            }
            a_flags[a_flags.size] = var_20488710.var_672c6068 + "_identified";
        }
    }
    foreach (str_flag in a_flags) {
        level flag::set(str_flag);
    }
}

