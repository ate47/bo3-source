#using scripts/cp/cp_mi_zurich_coalescence_sound;
#using scripts/cp/cp_mi_zurich_coalescence_util;
#using scripts/cp/cp_mi_zurich_coalescence_zurich_city;
#using scripts/cp/gametypes/_save;
#using scripts/cp/_util;
#using scripts/cp/_spawn_manager;
#using scripts/cp/_objectives;
#using scripts/cp/_skipto;
#using scripts/cp/_load;
#using scripts/cp/_dialog;
#using scripts/shared/vehicleriders_shared;
#using scripts/shared/vehicle_ai_shared;
#using scripts/shared/vehicle_shared;
#using scripts/shared/util_shared;
#using scripts/shared/turret_shared;
#using scripts/shared/trigger_shared;
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
#using scripts/codescripts/struct;

#namespace namespace_1beb9396;

// Namespace namespace_1beb9396
// Params 0, eflags: 0x1 linked
// namespace_1beb9396<file_0>::function_d290ebfa
// Checksum 0xeff79bf8, Offset: 0x18e8
// Size: 0x3c
function main() {
    scene::add_scene_func("p7_fxanim_cp_zurich_parking_wall_explode_bundle", &namespace_8e9083ff::function_9f90bc0f, "done", "garage_ambient_cleanup");
}

// Namespace namespace_1beb9396
// Params 2, eflags: 0x1 linked
// namespace_1beb9396<file_0>::function_9c1fc2fd
// Checksum 0x7ff3d175, Offset: 0x1930
// Size: 0x5ac
function function_9c1fc2fd(str_objective, var_74cd64bc) {
    level flag::init("garage_entrance_attack");
    level flag::init("garage_entrance_cleared");
    level flag::init("garage_entrance_open");
    level flag::init("garage_ramp_cleared");
    level flag::init("street_clear");
    level flag::init("street_phalanx_scatter");
    level flag::init("street_truck_cover_available");
    level flag::init("street_intro_intersection_cleared");
    callback::on_spawned(&on_player_spawned);
    spawner::add_spawn_function_group("street_robot_custom_entry", "script_string", &function_9ae7d78);
    spawner::add_spawn_function_group("street_vehicle_ai_splined_entry", "script_noteworthy", &function_c89b08c9);
    spawner::add_spawn_function_group("garage_intro_guys", "script_noteworthy", &function_748fa5c2);
    spawner::add_spawn_function_group("garage_2nd_floor_intro_guys", "script_noteworthy", &function_9ff08320);
    spawner::add_spawn_function_group("street_intro_guys", "script_noteworthy", &function_721c929f);
    spawner::add_spawn_function_group("robot_phalanx", "script_noteworthy", &function_721c929f);
    spawner::add_spawn_function_group("street_turret_spawn_manager_robot", "targetname", &function_dcb29c2c);
    spawner::add_spawn_function_group("garage_breach_street_enemy", "targetname", &function_2ad4a40f);
    spawner::add_spawn_function_group("garage_breach_rushers", "script_aigroup", &function_42881589);
    if (var_74cd64bc) {
        load::function_73adcefc();
        namespace_8e9083ff::function_da579a5d(str_objective, 1);
        level.var_3d556bcd.goalradius = 32;
        var_35a3121c = namespace_8e9083ff::function_b0dd51f4("zurich_street_redshirts");
        trigger::use("zurich_street_start_colortrig");
        namespace_f815059a::function_e3750802();
        level thread namespace_f815059a::function_ab4451a1();
        level.var_ebb30c1a = [];
        function_48166ad7();
        level clientfield::set("intro_ambience", 1);
        exploder::exploder("streets_tower_wasp_swarm");
        level clientfield::set("zurich_city_ambience", 1);
        level thread function_1be1a835();
        level thread namespace_67110270::function_db37681();
        level thread namespace_f815059a::function_da30164f();
        load::function_a2995f22();
    }
    var_b8f9a884 = spawner::simple_spawn_single("street_turret", &function_5268b119);
    level thread function_ce297ff6(var_74cd64bc);
    level thread function_1b074d61();
    level thread namespace_f815059a::function_9b9c35d7();
    street_main();
    level clientfield::set("intro_ambience", 0);
    var_62e3398b = getspawnerarray("robot_phalanx", "script_noteworthy");
    array::thread_all(var_62e3398b, &spawner::remove_spawn_function, &function_721c929f);
    callback::remove_on_spawned(&on_player_spawned);
    skipto::function_be8adfb8(str_objective);
}

// Namespace namespace_1beb9396
// Params 4, eflags: 0x1 linked
// namespace_1beb9396<file_0>::function_1a4dfaaa
// Checksum 0xc0d2d33d, Offset: 0x1ee8
// Size: 0x5c
function function_1a4dfaaa(str_objective, var_74cd64bc, var_e4cd2b8b, player) {
    namespace_8e9083ff::function_4d032f25(0);
    level thread namespace_8e9083ff::function_4a00a473("street");
}

// Namespace namespace_1beb9396
// Params 0, eflags: 0x1 linked
// namespace_1beb9396<file_0>::function_b0c3c450
// Checksum 0x2c6ab968, Offset: 0x1f50
// Size: 0x50c
function street_main() {
    namespace_8e9083ff::function_3f4f84e("garage_entrance_nodes", "script_noteworthy", 0);
    namespace_8e9083ff::function_3f4f84e("garage_intro_enemies", undefined, 0);
    level scene::init("p7_fxanim_cp_zurich_parking_wall_explode_bundle");
    level thread function_1b8ff897();
    level thread function_9a1931bc();
    var_edc6e0e1 = getvehiclenode("street_garage_vtol", "targetname") namespace_8e9083ff::function_a569867c(undefined, &function_b8380f70);
    level thread function_c8cc9a0d();
    level thread function_6a364612();
    level thread function_ba4b9ec5();
    level flag::wait_till("street_battle_intersection_reached");
    wait(0.05);
    namespace_8e9083ff::function_33ec653f("street_intersection_raven_soldier_spawn_manager", undefined, undefined, &namespace_8e9083ff::function_d065a580);
    level.var_3d556bcd thread function_4e8285e0();
    level flag::wait_till("street_civs_start");
    level thread namespace_8e9083ff::function_e7fdcb95("street_phalanx", "phalanx_forward", 6, 1, undefined, "street_phalanx_scatter", 2);
    wait(0.05);
    spawn_manager::enable("street_spawn_manager");
    level flag::wait_till("street_balcony_spawn_closet_available");
    var_edc6e0e1 = getvehiclenode("street_garage_vtol2", "targetname") namespace_8e9083ff::function_a569867c(undefined, &function_b8380f70);
    wait(0.05);
    spawn_manager::enable("street_balcony_reinforcement_spawn_manager");
    namespace_8e9083ff::function_33ec653f("street_garage_roof_raven_soldier_spawn_manager", undefined, undefined, &namespace_8e9083ff::function_d065a580);
    spawn_manager::function_27bf2e8("street_balcony_reinforcement_spawn_manager", 2);
    var_64e85e6d = spawn_manager::function_423eae50("street_balcony_reinforcement_spawn_manager");
    foreach (ai in var_64e85e6d) {
        if (ai.script_noteworthy === "street_balcony_robot_sniper") {
            continue;
        }
        ai ai::set_behavior_attribute("move_mode", "rusher");
    }
    var_b3b33e02 = spawn_manager::function_423eae50("street_wasp_spawn_manager");
    array::thread_all(var_b3b33e02, &function_90c5d999);
    spawn_manager::kill("street_spawn_manager", 1);
    level flag::set("street_clear");
    savegame::checkpoint_save();
    wait(3);
    var_66b24a60 = namespace_8e9083ff::function_3789d4db("street_garage_entrance_open_trig", undefined, 700, 768);
    var_66b24a60 thread function_3a6344d1(5);
    var_66b24a60 waittill(#"trigger");
    var_66b24a60 delete();
    if (isdefined(level.var_c4dba52c)) {
        [[ level.var_c4dba52c ]]();
    }
    function_4d92b2c7();
    level flag::set("garage_entrance_open");
}

// Namespace namespace_1beb9396
// Params 0, eflags: 0x1 linked
// namespace_1beb9396<file_0>::function_ba4b9ec5
// Checksum 0x58551d60, Offset: 0x2468
// Size: 0x7c
function function_ba4b9ec5() {
    level.var_3d556bcd dialog::say("kane_what_does_it_want_0", 1);
    level dialog::function_13b3b16a("plyr_right_now_i_think_i_0", 1);
    level.var_3d556bcd dialog::say("kane_it_knows_we_re_comin_0", 1);
}

// Namespace namespace_1beb9396
// Params 0, eflags: 0x1 linked
// namespace_1beb9396<file_0>::function_242cb817
// Checksum 0xe43a4532, Offset: 0x24f0
// Size: 0x11c
function function_242cb817() {
    level flag::wait_till("garage_entrance_cleared");
    level.var_3d556bcd dialog::say("kane_we_have_to_move_thro_0", 1);
    level flag::wait_till("flag_start_plyr_controlling_vo");
    level dialog::function_13b3b16a("plyr_controlling_these_ro_0", 1);
    trigger::wait_for_either("garage_kane_rooftop_colortrig", "garage_kane_exit_colortrig");
    level.var_3d556bcd dialog::say("kane_stay_with_me_3", 1);
    level.var_3d556bcd dialog::say("kane_we_ll_get_through_th_0", 2);
    level flag::set("flag_start_kane_it_won_t_vo_done");
}

// Namespace namespace_1beb9396
// Params 2, eflags: 0x1 linked
// namespace_1beb9396<file_0>::function_568e2e07
// Checksum 0x98ee4f3c, Offset: 0x2618
// Size: 0x554
function function_568e2e07(str_objective, var_74cd64bc) {
    if (var_74cd64bc) {
        load::function_73adcefc();
        level flag::init("garage_entrance_attack");
        level flag::init("garage_entrance_cleared");
        level flag::init("garage_entrance_open");
        level flag::init("garage_ramp_cleared");
        level flag::init("street_truck_cover_available", 1);
        level flag::set("street_balcony_spawn_closet_available");
        spawner::add_spawn_function_group("street_robot_custom_entry", "script_string", &function_9ae7d78);
        spawner::add_spawn_function_group("street_vehicle_ai_splined_entry", "script_noteworthy", &function_c89b08c9);
        spawner::add_spawn_function_group("garage_breach_rushers", "script_aigroup", &function_42881589);
        spawner::add_spawn_function_group("garage_intro_guys", "script_noteworthy", &function_748fa5c2);
        spawner::add_spawn_function_group("garage_2nd_floor_intro_guys", "script_noteworthy", &function_9ff08320);
        spawner::add_spawn_function_group("garage_breach_street_enemy", "targetname", &function_2ad4a40f);
        namespace_8e9083ff::function_da579a5d(str_objective, 1);
        level scene::init("p7_fxanim_cp_zurich_parking_wall_explode_bundle");
        level.var_ebb30c1a = [];
        level thread function_1b074d61();
        function_48166ad7(str_objective);
        load::function_a2995f22();
        wait(0.05);
        namespace_f815059a::function_e3750802();
        wait(0.05);
        var_b8f9a884 = spawner::simple_spawn_single("street_turret", &function_5268b119);
        wait(0.05);
        a_ai_allies = namespace_8e9083ff::function_33ec653f("garage_skipto_allies_spawn_manager");
        for (i = 0; i < 2; i++) {
            if (!isalive(a_ai_allies[i])) {
                continue;
            }
            a_ai_allies[i] util::magic_bullet_shield();
        }
        level thread function_8535a819();
        exploder::exploder("streets_tower_wasp_swarm");
        level clientfield::set("zurich_city_ambience", 1);
        level thread namespace_f815059a::function_ab4451a1();
        namespace_8e9083ff::function_3f4f84e("garage_entrance_nodes", "script_noteworthy", 0);
        namespace_8e9083ff::function_3f4f84e("garage_intro_enemies", undefined, 0);
        level thread namespace_67110270::function_db37681();
        level thread namespace_f815059a::function_da30164f();
        level thread function_a0abe6b6();
    }
    level thread function_410cfaac(var_74cd64bc);
    level thread function_242cb817();
    level thread namespace_8e9083ff::function_c83720c9();
    function_c83d3033();
    function_ec9dd4a5();
    function_b7d40ae();
    function_7a0e84a8();
    level notify(#"hash_c7263fa8");
    level thread namespace_8e9083ff::function_2361541e("garage");
    function_2480a40a();
    level thread function_d987ae9();
    skipto::function_be8adfb8(str_objective);
}

// Namespace namespace_1beb9396
// Params 4, eflags: 0x1 linked
// namespace_1beb9396<file_0>::function_5b6ddf20
// Checksum 0xc216e948, Offset: 0x2b78
// Size: 0x5c
function function_5b6ddf20(str_objective, var_74cd64bc, var_e4cd2b8b, player) {
    namespace_8e9083ff::function_4d032f25(0);
    level thread namespace_8e9083ff::function_4a00a473("garage");
}

// Namespace namespace_1beb9396
// Params 0, eflags: 0x1 linked
// namespace_1beb9396<file_0>::function_2480a40a
// Checksum 0x319ae5e8, Offset: 0x2be0
// Size: 0x7d6
function function_2480a40a() {
    level thread function_1c9e622e();
    level thread function_dc91abc9();
    level thread function_b3a34ca5();
    level thread function_34ad4dc8();
    level flag::wait_till("garage_entrance_open");
    if (isdefined(level.var_851372ea)) {
        level thread [[ level.var_851372ea ]]();
    }
    namespace_8e9083ff::function_3f4f84e("garage_entrance_nodes", "script_noteworthy");
    namespace_8e9083ff::function_3f4f84e("garage_intro_enemies");
    spawn_manager::enable("street_garage_breach_spawn_manger");
    wait(0.05);
    spawn_manager::enable("garage_allies_spawn_manager");
    wait(0.05);
    level thread namespace_8e9083ff::function_33ec653f("garage_intro_enemy_fake_spawn_manager", undefined, undefined, &function_748fa5c2);
    wait(0.05);
    spawn_manager::kill("street_allies_spawn_manager", 1);
    level thread function_b863f1b1();
    trigger::wait_till("street_exit_zone_trig");
    var_64e85e6d = spawn_manager::function_423eae50("street_turret_spawn_manager");
    array::thread_all(var_64e85e6d, &function_bb52655d);
    spawn_manager::kill("street_turret_spawn_manager", 1);
    if (level.players.size < 3) {
        var_5e764d1a = getentarray("street_balcony_robot_sniper", "script_noteworthy");
        foreach (ai in var_5e764d1a) {
            if (isalive(ai)) {
                ai kill();
            }
        }
    }
    level thread function_1418d19();
    var_9f88d117 = getent("garage_intro_glass_weapon_clip", "targetname");
    var_9f88d117 delete();
    trigger::wait_till("garage_ramp_spawn_manager_trig");
    level thread spawn_manager::function_5000af1e("garage_ramp_spawn_manager", &function_bdb3b32d);
    spawn_manager::enable("garage_ramp_spawn_manager");
    trigger::wait_till("garage_robots_spawn_manager_trig");
    spawn_manager::enable("garage_robots_spawn_manager");
    spawn_manager::enable("garage_2nd_floor_allies_spawn_manager");
    trigger::wait_till("garage_third_floor_trig");
    savegame::checkpoint_save();
    level thread function_e804203a();
    level flag::wait_till("garage_end_phalanx_scatter");
    var_b2d1f880 = getent("garage_upper_floor_left_goaltrig", "targetname");
    var_d587bca1 = getent("garage_upper_floor_right_goaltrig", "targetname");
    var_bb5c7c43 = getent("garage_exit_gate_left_trig", "targetname");
    var_678e7878 = getent("garage_exit_gate_right_trig", "targetname");
    a_ai_enemies = getaispeciesarray("axis", "robot");
    array::run_all(a_ai_enemies, &function_932e49ba, var_b2d1f880, var_d587bca1, var_bb5c7c43, var_678e7878);
    level flag::wait_till("garage_gate_open");
    var_26d693b1 = spawner::get_ai_group_ai("intro_hero_redshirts");
    array::run_all(var_26d693b1, &util::stop_magic_bullet_shield);
    savegame::checkpoint_save();
    spawn_manager::kill("garage_ramp_spawn_manager", 1);
    spawn_manager::kill("garage_robots_spawn_manager", 1);
    spawn_manager::kill("garage_2nd_floor_allies_spawn_manager", 1);
    a_ai_enemies = getaispeciesarray("axis", "robot");
    foreach (ai in a_ai_enemies) {
        if (!ai istouching(var_bb5c7c43) && !ai istouching(var_678e7878)) {
            ai kill();
        }
    }
    trigger::wait_till("garage_exit_zone_trig");
    if (level.players.size == 1) {
        a_ai_enemies = getaispeciesarray("axis", "robot");
        foreach (ai in a_ai_enemies) {
            ai.overrideactordamage = &namespace_8e9083ff::function_8ac3f026;
        }
    }
}

// Namespace namespace_1beb9396
// Params 0, eflags: 0x1 linked
// namespace_1beb9396<file_0>::function_bb52655d
// Checksum 0xd5fe1721, Offset: 0x33c0
// Size: 0x64
function function_bb52655d() {
    var_9bfba9d9 = getent("street_center_goaltrig", "targetname");
    if (self istouching(var_9bfba9d9)) {
        return;
    }
    self kill();
}

// Namespace namespace_1beb9396
// Params 0, eflags: 0x1 linked
// namespace_1beb9396<file_0>::function_bdb3b32d
// Checksum 0x1d36eefc, Offset: 0x3430
// Size: 0x11e
function function_bdb3b32d() {
    spawn_manager::wait_till_complete("garage_ramp_spawn_manager");
    spawner::waittill_ai_group_ai_count("garage_entrance_robots", 0);
    level flag::set("garage_ramp_cleared");
    var_64e85e6d = spawner::get_ai_group_ai("garage_saffold_robots");
    foreach (ai in var_64e85e6d) {
        ai ai::set_ignoreme(0);
        ai.overrideactordamage = &namespace_8e9083ff::function_8ac3f026;
    }
}

// Namespace namespace_1beb9396
// Params 0, eflags: 0x1 linked
// namespace_1beb9396<file_0>::function_e804203a
// Checksum 0x3b5e1623, Offset: 0x3558
// Size: 0x5c
function function_e804203a() {
    trigger::wait_till("garage_phalanx_spawn_trig");
    namespace_8e9083ff::function_e7fdcb95("garage_left_path_phalanx", "phanalx_wedge", 3, 1, 0.1, "garage_end_phalanx_scatter", 3);
}

// Namespace namespace_1beb9396
// Params 4, eflags: 0x1 linked
// namespace_1beb9396<file_0>::function_932e49ba
// Checksum 0x908a6a3c, Offset: 0x35c0
// Size: 0xa4
function function_932e49ba(var_b2d1f880, var_d587bca1, var_bb5c7c43, var_678e7878) {
    if (self istouching(var_b2d1f880)) {
        self setgoal(var_bb5c7c43);
        return;
    } else if (self istouching(var_d587bca1)) {
        self setgoal(var_678e7878);
        return;
    }
    self setgoal(var_bb5c7c43);
}

// Namespace namespace_1beb9396
// Params 0, eflags: 0x1 linked
// namespace_1beb9396<file_0>::function_b863f1b1
// Checksum 0xacec4120, Offset: 0x3670
// Size: 0x1b2
function function_b863f1b1() {
    spawn_manager::wait_till_complete("street_garage_breach_spawn_manger");
    spawner::waittill_ai_group_ai_count("garage_breach_rushers", 1);
    level flag::set("garage_entrance_attack");
    spawn_manager::wait_till_cleared("street_garage_breach_spawn_manger");
    exploder::stop_exploder("street_parking_wall_exp");
    level flag::set("garage_entrance_cleared");
    savegame::checkpoint_save();
    spawn_manager::wait_till_cleared("garage_allies_spawn_manager");
    if (level.players.size < 3) {
        var_b04fa3dc = struct::get("garage_intro_enemy_fake_spawn_manager");
        var_fb75ccb0 = array::remove_dead(var_b04fa3dc.a_ai);
        foreach (ai in var_fb75ccb0) {
            ai.script_accuracy = 0.2;
        }
    }
}

// Namespace namespace_1beb9396
// Params 0, eflags: 0x1 linked
// namespace_1beb9396<file_0>::function_a0abe6b6
// Checksum 0x43531066, Offset: 0x3830
// Size: 0xc4
function function_a0abe6b6() {
    var_66b24a60 = namespace_8e9083ff::function_3789d4db("street_garage_entrance_open_trig", undefined, 720, 768);
    var_66b24a60 thread function_3a6344d1(4);
    var_66b24a60 waittill(#"trigger");
    var_66b24a60 delete();
    if (isdefined(level.var_c4dba52c)) {
        [[ level.var_c4dba52c ]]();
    }
    function_4d92b2c7();
    level flag::set("garage_entrance_open");
}

// Namespace namespace_1beb9396
// Params 1, eflags: 0x1 linked
// namespace_1beb9396<file_0>::function_ce297ff6
// Checksum 0x716ecaab, Offset: 0x3900
// Size: 0x10c
function function_ce297ff6(var_74cd64bc) {
    if (var_74cd64bc) {
        objectives::set("cp_level_zurich_assault_hq_obj");
        objectives::breadcrumb("intro_breadcrumb_trig2", "cp_waypoint_breadcrumb");
    }
    trigger::wait_till("truck_burst_breadcrumb_trig", undefined, undefined, 0);
    objectives::hide("cp_level_zurich_assault_hq_obj");
    objectives::set("cp_level_zurich_assault_hq_awaiting_obj");
    level flag::wait_till("garage_entrance_cleared");
    objectives::hide("cp_level_zurich_assault_hq_awaiting_obj");
    objectives::show("cp_level_zurich_assault_hq_obj");
    objectives::breadcrumb("street_garage_entrance_breadcrumb_trig", "cp_waypoint_breadcrumb");
}

// Namespace namespace_1beb9396
// Params 1, eflags: 0x1 linked
// namespace_1beb9396<file_0>::function_410cfaac
// Checksum 0x9ad65422, Offset: 0x3a18
// Size: 0x1dc
function function_410cfaac(var_74cd64bc) {
    if (var_74cd64bc) {
        objectives::set("cp_level_zurich_assault_hq_awaiting_obj");
        level flag::wait_till("garage_entrance_cleared");
        objectives::hide("cp_level_zurich_assault_hq_awaiting_obj");
        objectives::set("cp_level_zurich_assault_hq_obj");
        objectives::breadcrumb("street_garage_entrance_breadcrumb_trig", "cp_waypoint_breadcrumb");
    }
    trigger::wait_till("street_garage_entrance_breadcrumb_trig", undefined, undefined, 0);
    objectives::hide("cp_level_zurich_assault_hq_obj");
    objectives::show("cp_level_zurich_assault_hq_awaiting_obj");
    level flag::wait_till("garage_ramp_cleared");
    trigger::wait_till("street_garage_2nd_floor_breadcrumb_spot", undefined, undefined, 0);
    var_c226e38e = getent("garage_cleanup_trig", "targetname");
    while (isdefined(var_c226e38e) && level.var_3d556bcd istouching(var_c226e38e)) {
        wait(0.2);
    }
    objectives::hide("cp_level_zurich_assault_hq_awaiting_obj");
    objectives::show("cp_level_zurich_assault_hq_obj");
    objectives::breadcrumb("garage_kane_rooftop_colortrig", "cp_waypoint_breadcrumb");
}

// Namespace namespace_1beb9396
// Params 0, eflags: 0x1 linked
// namespace_1beb9396<file_0>::function_aebcf025
// Checksum 0xca55d616, Offset: 0x3c00
// Size: 0x1c
function on_player_spawned() {
    self function_2e5e657b();
}

// Namespace namespace_1beb9396
// Params 0, eflags: 0x1 linked
// namespace_1beb9396<file_0>::function_2e5e657b
// Checksum 0xd69536d4, Offset: 0x3c28
// Size: 0x188
function function_2e5e657b() {
    level endon(#"hash_4defcad0");
    self endon(#"death");
    if (level flag::get("street_balcony_spawn_closet_available")) {
        return;
    }
    while (true) {
        self waittill(#"weapon_fired");
        foreach (var_cbc51d9b in level.var_ebb30c1a) {
            if (!isalive(var_cbc51d9b)) {
                continue;
            }
            var_b8f6e26f = self util::is_player_looking_at(var_cbc51d9b geteye(), 0.98, 1, self);
            if (isdefined(var_cbc51d9b.var_6e5e16ee) && var_b8f6e26f && var_cbc51d9b.var_6e5e16ee && self util::is_ads()) {
                trigger::use("street_vehicle_burst_scene_trig", undefined, undefined, 0);
                return;
            }
        }
    }
}

// Namespace namespace_1beb9396
// Params 0, eflags: 0x1 linked
// namespace_1beb9396<file_0>::function_dcb29c2c
// Checksum 0x47eb2c7d, Offset: 0x3db8
// Size: 0x5c
function function_dcb29c2c() {
    self endon(#"death");
    s_goal = struct::get("street_turret_enemy_goal_spot");
    self setgoal(s_goal.origin, 0, 256);
}

// Namespace namespace_1beb9396
// Params 0, eflags: 0x1 linked
// namespace_1beb9396<file_0>::function_5268b119
// Checksum 0xdcc031ee, Offset: 0x3e20
// Size: 0x88
function function_5268b119() {
    self endon(#"death");
    level endon(#"garage");
    self vehicle::god_on();
    while (true) {
        self waittill(#"enter_vehicle");
        spawn_manager::enable("street_turret_spawn_manager", 1);
        self waittill(#"exit_vehicle");
        spawn_manager::disable("street_turret_spawn_manager", 1);
    }
}

// Namespace namespace_1beb9396
// Params 1, eflags: 0x1 linked
// namespace_1beb9396<file_0>::function_c89b08c9
// Checksum 0x4af24063, Offset: 0x3eb0
// Size: 0x1ec
function function_c89b08c9(nd_start) {
    self endon(#"death");
    if (!isdefined(nd_start)) {
        nd_start = getvehiclenode(self.target, "targetname");
    }
    self disableaimassist();
    self vehicle_ai::start_scripted();
    self.team = "team3";
    self thread vehicle::get_on_and_go_path(nd_start);
    if (nd_start.script_string === "run_defend_logic") {
        self function_fd9eb46();
        return;
    }
    if (nd_start.script_string === "run_guard_logic") {
        self function_dbaa39f6();
        return;
    } else if (self.scriptvehicletype === "hunter") {
        self vehicle::god_on();
        self thread function_ba1c7fdb();
    }
    self waittill(#"reached_end_node");
    if (self.script_string === "stop_scripted") {
        self vehicle_ai::stop_scripted();
        self enableaimassist();
        self.team = "axis";
        return;
    } else if (self.script_string === "run_wasp_attack_logic") {
        self function_3feabcbe();
        return;
    }
    self delete();
}

// Namespace namespace_1beb9396
// Params 0, eflags: 0x1 linked
// namespace_1beb9396<file_0>::function_9ae7d78
// Checksum 0x7ddf042b, Offset: 0x40a8
// Size: 0xf4
function function_9ae7d78() {
    self endon(#"death");
    s_scene = struct::get(self.target);
    level scene::play(s_scene.targetname, "targetname", self);
    if (isdefined(s_scene.target)) {
        goal = getent(s_scene.target, "targetname");
        if (!isdefined(goal)) {
            goal = getnode(s_scene.target, "targetname");
        }
        if (isdefined(goal)) {
            self setgoal(goal);
        }
    }
}

// Namespace namespace_1beb9396
// Params 0, eflags: 0x1 linked
// namespace_1beb9396<file_0>::function_892106c9
// Checksum 0xb8c3ebb8, Offset: 0x41a8
// Size: 0x8c
function function_892106c9() {
    self endon(#"death");
    self ai::set_ignoreall(1);
    self ai::set_ignoreme(1);
    self function_ade7ef6b();
    level waittill(#"hash_90cef371");
    self ai::set_ignoreall(0);
    self ai::set_ignoreme(0);
}

// Namespace namespace_1beb9396
// Params 0, eflags: 0x1 linked
// namespace_1beb9396<file_0>::function_ade7ef6b
// Checksum 0x4dae3908, Offset: 0x4240
// Size: 0xac
function function_ade7ef6b() {
    var_8a3b64d6 = namespace_8e9083ff::function_411dc61b(0, 35);
    if (randomint(100) <= var_8a3b64d6) {
        wait(0.05);
        self ai::set_behavior_attribute("rogue_control", "forced_level_3");
        self ai::set_behavior_attribute("rogue_control_speed", "sprint");
        self.team = "axis";
    }
}

// Namespace namespace_1beb9396
// Params 0, eflags: 0x1 linked
// namespace_1beb9396<file_0>::function_ba1c7fdb
// Checksum 0xb5a80889, Offset: 0x42f8
// Size: 0x4e
function function_ba1c7fdb() {
    self endon(#"death");
    self waittill(#"hash_3113e74d");
    self thread vehicle_ai::fire_for_time(100);
    self waittill(#"hash_5d07b3ec");
    self notify(#"fire_stop");
}

// Namespace namespace_1beb9396
// Params 0, eflags: 0x1 linked
// namespace_1beb9396<file_0>::function_721c929f
// Checksum 0x79d90a3b, Offset: 0x4350
// Size: 0x124
function function_721c929f() {
    self endon(#"death");
    if (self.team == "allies") {
        self.script_accuracy = 0.1;
    } else {
        self.var_6e5e16ee = 1;
    }
    if (!sessionmodeiscampaignzombiesgame()) {
        self util::magic_bullet_shield();
    }
    if (self.script_string === "intro_redshirt") {
        return;
    }
    level flag::wait_till("street_phalanx_scatter");
    if (!sessionmodeiscampaignzombiesgame()) {
        self.health = self.maxhealth;
        self util::stop_magic_bullet_shield();
    }
    if (self.team == "axis") {
        return;
    }
    level flag::wait_till("garage_entrance_attack");
    self colors::set_force_color("y");
}

// Namespace namespace_1beb9396
// Params 0, eflags: 0x1 linked
// namespace_1beb9396<file_0>::function_748fa5c2
// Checksum 0xce108411, Offset: 0x4480
// Size: 0x174
function function_748fa5c2() {
    self endon(#"death");
    if (!sessionmodeiscampaignzombiesgame()) {
        self ai::set_ignoreall(1);
        self util::magic_bullet_shield();
    }
    if (self.team == "allies") {
        self.script_accuracy = 0.1;
        self ai::set_ignoreme(1);
    }
    trigger::wait_till("street_wall_approach_trig", undefined, undefined, 0);
    self ai::set_ignoreme(0);
    self ai::set_ignoreall(0);
    level flag::wait_till("street_exit_zone_reached");
    if (!sessionmodeiscampaignzombiesgame()) {
        self.health = self.maxhealth;
        self util::stop_magic_bullet_shield();
    }
    if (self.team == "axis") {
        self ai::set_behavior_attribute("move_mode", "rusher");
    }
}

// Namespace namespace_1beb9396
// Params 0, eflags: 0x1 linked
// namespace_1beb9396<file_0>::function_42881589
// Checksum 0x9012247a, Offset: 0x4600
// Size: 0x1c
function function_42881589() {
    self function_ade7ef6b();
}

// Namespace namespace_1beb9396
// Params 0, eflags: 0x1 linked
// namespace_1beb9396<file_0>::function_9ff08320
// Checksum 0x9f4c6e0f, Offset: 0x4628
// Size: 0xc4
function function_9ff08320() {
    self endon(#"death");
    if (self.team == "allies") {
        self.script_accuracy = 0.1;
    }
    if (!sessionmodeiscampaignzombiesgame()) {
        self util::magic_bullet_shield();
    }
    level flag::wait_till("garage_ramp_reached");
    if (!sessionmodeiscampaignzombiesgame()) {
        self util::stop_magic_bullet_shield();
    }
    self colors::set_force_color("y");
}

// Namespace namespace_1beb9396
// Params 0, eflags: 0x1 linked
// namespace_1beb9396<file_0>::function_b8380f70
// Checksum 0x6d9a47d6, Offset: 0x46f8
// Size: 0x11c
function function_b8380f70() {
    self endon(#"death");
    self.health = 100000;
    self.team = "axis";
    self.var_7a04481c = namespace_8e9083ff::function_411dc61b(4000, 1000);
    self.var_90937e6 = struct::get_array("street_vtol_crash_point");
    self vehicle::god_on();
    if (self.script_string !== "no_death") {
        self thread namespace_8e9083ff::function_6d571441();
    }
    self waittill(#"hash_5f96e13c");
    var_b0a9b597 = spawner::get_ai_group_ai("street_vtol_riders");
    array::run_all(var_b0a9b597, &kill);
}

// Namespace namespace_1beb9396
// Params 0, eflags: 0x1 linked
// namespace_1beb9396<file_0>::function_2ad4a40f
// Checksum 0x4a51b44e, Offset: 0x4820
// Size: 0x5c
function function_2ad4a40f() {
    self endon(#"death");
    level flag::wait_till("garage_entrance_open");
    self ai::set_ignoreall(0);
    self ai::set_ignoreme(0);
}

// Namespace namespace_1beb9396
// Params 0, eflags: 0x1 linked
// namespace_1beb9396<file_0>::function_9a1931bc
// Checksum 0xa2fe947b, Offset: 0x4888
// Size: 0x224
function function_9a1931bc() {
    level thread namespace_8e9083ff::function_33ec653f("street_intro_redshirts_fake_spawn_manager", undefined, undefined, &function_721c929f);
    level flag::wait_till("street_civs_start");
    trigger::use("street_allies_intro_battle_colortrig");
    level flag::wait_till("street_intro_intersection_cleared");
    trigger::use("street_kane_intersection_colortrig");
    trigger::use("street_allies_intro_colortrig");
    level flag::wait_till("street_truck_cover_available");
    trigger::use("street_allies_battle_colortrig");
    level flag::wait_till("street_balcony_spawn_closet_available");
    level.var_3d556bcd ai::set_ignoreme(1);
    level.var_3d556bcd thread namespace_8e9083ff::function_d0103e8d();
    level flag::wait_till("garage_entrance_attack");
    trigger::use("street_allies_attack_colortrig");
    level flag::wait_till("garage_entrance_cleared");
    trigger::use("street_allies_garage_enter_colortrig");
    trigger::wait_till("street_wall_approach_trig");
    trigger::use("street_kane_garage_colortrig");
    level flag::wait_till("street_exit_zone_reached");
    trigger::use("street_allies_garage_colortrig");
}

// Namespace namespace_1beb9396
// Params 0, eflags: 0x1 linked
// namespace_1beb9396<file_0>::function_8535a819
// Checksum 0x9f79df91, Offset: 0x4ab8
// Size: 0xf4
function function_8535a819() {
    trigger::use("street_allies_battle_colortrig");
    level.var_3d556bcd ai::set_ignoreme(1);
    level.var_3d556bcd thread namespace_8e9083ff::function_d0103e8d();
    level flag::wait_till("garage_entrance_attack");
    trigger::use("street_allies_attack_colortrig");
    level flag::wait_till("garage_entrance_cleared");
    trigger::use("street_allies_garage_enter_colortrig");
    trigger::wait_till("street_wall_approach_trig");
    trigger::use("street_kane_garage_colortrig");
}

// Namespace namespace_1beb9396
// Params 0, eflags: 0x1 linked
// namespace_1beb9396<file_0>::function_1c9e622e
// Checksum 0xa8a49a97, Offset: 0x4bb8
// Size: 0x2e4
function function_1c9e622e() {
    level.var_3d556bcd ai::set_ignoreme(0);
    level flag::wait_till("garage_entrance_cleared");
    level.var_3d556bcd namespace_8e9083ff::function_121ba443();
    level.var_3d556bcd thread function_c9dccfc4();
    namespace_8e9083ff::function_c049667c(1);
    a_ai_allies = getaiteamarray("allies");
    foreach (ai in a_ai_allies) {
        if (ai util::is_hero() || ai.script_noteworthy === "garage_intro_guys") {
            continue;
        }
        ai colors::set_force_color("y");
    }
    spawn_manager::wait_till_complete("garage_ramp_spawn_manager");
    trigger::use("garage_kane_intro_clear_colortrig");
    trigger::use("garage_redshirts_2nd_floor_colortrig");
    spawn_manager::function_27bf2e8("garage_ramp_spawn_manager", 1);
    trigger::use("garage_kane_2nd_floor_colortrig");
    level flag::wait_till("garage_ramp_reached");
    trigger::use("garage_kane_ramp_colortrig");
    trigger::wait_till("street_garage_2nd_floor_wasp_spawn_trig", undefined, undefined, 0);
    level flag::wait_till("garage_gate_open");
    a_ai_enemies = getaispeciesarray("axis", "robot");
    array::wait_till(a_ai_enemies, "death");
    trigger::use("garage_kane_exit_colortrig");
    level flag::wait_till("garage_completed");
}

// Namespace namespace_1beb9396
// Params 0, eflags: 0x1 linked
// namespace_1beb9396<file_0>::function_c9dccfc4
// Checksum 0xf176b63b, Offset: 0x4ea8
// Size: 0xa4
function function_c9dccfc4() {
    level endon(#"hash_9903fa62");
    level flag::wait_till("garage_car_2nd_floor_standard_01_done");
    trigger::wait_till("garage_kane_left_change_color_colortrig");
    self colors::set_force_color("o");
    level flag::wait_till("garage_completed");
    self colors::set_force_color("b");
}

// Namespace namespace_1beb9396
// Params 3, eflags: 0x0
// namespace_1beb9396<file_0>::function_82ecade4
// Checksum 0x4e866f0a, Offset: 0x4f58
// Size: 0x152
function function_82ecade4(goal, var_ec24660, var_39dd968a) {
    if (!isdefined(var_ec24660)) {
        var_ec24660 = 0.3;
    }
    if (!isdefined(var_39dd968a)) {
        var_39dd968a = 1.1;
    }
    a_ai = self;
    if (!isarray(self)) {
        a_ai = array(self);
    }
    foreach (ai in a_ai) {
        wait(randomfloatrange(var_ec24660, var_39dd968a));
        if (isalive(ai)) {
            ai setgoal(goal);
        }
    }
}

// Namespace namespace_1beb9396
// Params 1, eflags: 0x0
// namespace_1beb9396<file_0>::function_10b3aeea
// Checksum 0x843fc899, Offset: 0x50b8
// Size: 0x44
function function_10b3aeea(n_delay) {
    if (!isdefined(n_delay)) {
        n_delay = 0;
    }
    self endon(#"death");
    wait(n_delay);
    self kill();
}

// Namespace namespace_1beb9396
// Params 0, eflags: 0x1 linked
// namespace_1beb9396<file_0>::function_6a364612
// Checksum 0x91b214f6, Offset: 0x5108
// Size: 0x7c
function function_6a364612() {
    level flag::wait_till("street_civs_start");
    spawn_manager::enable("street_wasp_spawn_manager");
    level flag::wait_till("street_clear");
    spawn_manager::kill("street_wasp_spawn_manager", 1);
}

// Namespace namespace_1beb9396
// Params 0, eflags: 0x1 linked
// namespace_1beb9396<file_0>::function_34ad4dc8
// Checksum 0xfb0a3e7e, Offset: 0x5190
// Size: 0xf4
function function_34ad4dc8() {
    level flag::wait_till("garage_entrance_open");
    spawn_manager::enable("garage_entrance_wasp_spawn_manager");
    trigger::wait_till("street_garage_2nd_floor_wasp_spawn_trig", undefined, undefined, 0);
    spawn_manager::enable("street_garage_2nd_floor_wasp_end_spawnmanager");
    level flag::wait_till("garage_gate_open");
    var_b3b33e02 = spawn_manager::function_423eae50("street_garage_2nd_floor_wasp_end_spawnmanager");
    spawn_manager::kill("street_garage_2nd_floor_wasp_end_spawnmanager", 1);
    array::run_all(var_b3b33e02, &kill);
}

// Namespace namespace_1beb9396
// Params 0, eflags: 0x1 linked
// namespace_1beb9396<file_0>::function_3feabcbe
// Checksum 0x70b94c3e, Offset: 0x5290
// Size: 0x94
function function_3feabcbe() {
    self endon(#"death");
    self vehicle_ai::stop_scripted();
    self enableaimassist();
    self.team = "axis";
    var_284ca6ef = getent("garage_wasp_goaltrig", "targetname");
    self setgoal(var_284ca6ef);
}

// Namespace namespace_1beb9396
// Params 0, eflags: 0x1 linked
// namespace_1beb9396<file_0>::function_fd9eb46
// Checksum 0xe2db865c, Offset: 0x5330
// Size: 0xa4
function function_fd9eb46() {
    self endon(#"death");
    self waittill(#"reached_end_node");
    self vehicle_ai::stop_scripted();
    self enableaimassist();
    self.team = "axis";
    var_284ca6ef = getent("garage_wasp_defend_goaltrig", "targetname");
    self setgoal(var_284ca6ef);
}

// Namespace namespace_1beb9396
// Params 0, eflags: 0x1 linked
// namespace_1beb9396<file_0>::function_dbaa39f6
// Checksum 0xd9eb2e69, Offset: 0x53e0
// Size: 0x74
function function_dbaa39f6() {
    self endon(#"death");
    self waittill(#"reached_end_node");
    self vehicle_ai::stop_scripted();
    self enableaimassist();
    self.team = "axis";
    self function_90c5d999();
}

// Namespace namespace_1beb9396
// Params 0, eflags: 0x1 linked
// namespace_1beb9396<file_0>::function_90c5d999
// Checksum 0x2be50fb6, Offset: 0x5460
// Size: 0x4c
function function_90c5d999() {
    var_284ca6ef = getent("street_center_goaltrig", "targetname");
    self setgoal(var_284ca6ef);
}

// Namespace namespace_1beb9396
// Params 7, eflags: 0x0
// namespace_1beb9396<file_0>::function_11cc2d60
// Checksum 0xb3326b24, Offset: 0x54b8
// Size: 0x13a
function function_11cc2d60(nd_start, n_time, n_group_size, n_time_min, n_time_max, var_4339be5c, var_6dcbc9a2) {
    if (!isdefined(n_time)) {
        n_time = 0.2;
    }
    if (!isdefined(n_group_size)) {
        n_group_size = 8;
    }
    if (isdefined(n_time_min) && isdefined(n_time_max)) {
        n_time = randomfloatrange(n_time_min, n_time_max);
    }
    if (isdefined(n_time_max) && isdefined(var_6dcbc9a2)) {
        n_group_size = randomintrange(n_time_max, var_6dcbc9a2);
    }
    var_c779405 = [];
    for (i = 0; i < n_group_size; i++) {
        var_c779405[i] = spawner::simple_spawn_single(self, &function_c89b08c9, nd_start);
        wait(n_time);
    }
    return var_c779405;
}

// Namespace namespace_1beb9396
// Params 0, eflags: 0x1 linked
// namespace_1beb9396<file_0>::function_1b8ff897
// Checksum 0x45d5d656, Offset: 0x5600
// Size: 0x74
function function_1b8ff897() {
    level endon(#"hash_5539c1de");
    namespace_8e9083ff::function_1b3dfa61("p7_fxanim_cp_zurich_car_crash_06_bundle_trig", undefined, 1300, 768);
    level flag::set("street_intro_intersection_cleared");
    level scene::play("p7_fxanim_cp_zurich_car_crash_06_bundle");
}

// Namespace namespace_1beb9396
// Params 0, eflags: 0x1 linked
// namespace_1beb9396<file_0>::function_1be1a835
// Checksum 0xddfbb031, Offset: 0x5680
// Size: 0x104
function function_1be1a835() {
    scene::add_scene_func("p7_fxanim_cp_zurich_truck_crash_01_bundle", &function_93e3e895, "play");
    scene::add_scene_func("p7_fxanim_cp_zurich_truck_crash_01_bundle", &function_8c1a1bb7, "done");
    wait(0.05);
    level scene::init("p7_fxanim_cp_zurich_truck_crash_01_bundle");
    wait(0.05);
    namespace_8e9083ff::function_1b3dfa61("street_vehicle_burst_scene_trig", undefined, 1300, 512);
    level flag::set("street_phalanx_scatter");
    level scene::play("p7_fxanim_cp_zurich_truck_crash_01_bundle");
    savegame::checkpoint_save();
}

// Namespace namespace_1beb9396
// Params 1, eflags: 0x1 linked
// namespace_1beb9396<file_0>::function_93e3e895
// Checksum 0x65045040, Offset: 0x5790
// Size: 0x434
function function_93e3e895(a_ents) {
    var_a146f241 = getnodearray("street_intro_redshirts", "targetname");
    var_9b1ed538 = getnodearray("street_intro_truck_cover_nodes", "targetname");
    var_b04fa3dc = struct::get("street_intro_redshirts_fake_spawn_manager");
    var_a3f74aa3 = var_b04fa3dc.a_ai;
    var_a3f74aa3 = array::remove_dead(var_a3f74aa3);
    foreach (nd in var_9b1ed538) {
        setenablenode(nd, 0);
    }
    a_ents["truck_crash_01_veh"] thread function_d700903e();
    a_ents["truck_crash_01_veh"] waittill(#"hash_84bfd73b");
    a_ents["truck_crash_01_veh"] notify(#"stop_damage");
    var_a3f74aa3 = array::remove_dead(var_a3f74aa3);
    foreach (ai in var_a3f74aa3) {
        if (!isalive(ai)) {
            continue;
        }
        ai util::stop_magic_bullet_shield();
        if (ai.script_string === "intro_redshirt") {
            ai kill();
        }
    }
    var_a146f241 = getnodearray("street_intro_redshirts", "targetname");
    var_9b1ed538 = getnodearray("street_intro_truck_cover_nodes", "targetname");
    foreach (nd in var_a146f241) {
        setenablenode(nd, 0);
    }
    foreach (nd in var_9b1ed538) {
        setenablenode(nd, 1);
    }
    level flag::set("street_truck_cover_available");
    physicsexplosionsphere(a_ents["truck_crash_01_veh"].origin, 512, 0, 1.2);
}

// Namespace namespace_1beb9396
// Params 0, eflags: 0x1 linked
// namespace_1beb9396<file_0>::function_c8cc9a0d
// Checksum 0x9303ce47, Offset: 0x5bd0
// Size: 0xd4
function function_c8cc9a0d() {
    s_rpg = struct::get("street_intro_robot_magic_bullet_start");
    var_364fd53c = struct::get(s_rpg.target);
    var_9faa0c88 = getweapon("launcher_standard");
    magicbullet(var_9faa0c88, s_rpg.origin, var_364fd53c.origin);
    wait(1);
    radiusdamage(s_rpg.origin, 64, 700, 500);
}

// Namespace namespace_1beb9396
// Params 1, eflags: 0x1 linked
// namespace_1beb9396<file_0>::function_8c1a1bb7
// Checksum 0xde396565, Offset: 0x5cb0
// Size: 0x4c
function function_8c1a1bb7(a_ents) {
    level flag::set("street_balcony_spawn_closet_available");
    self thread namespace_8e9083ff::function_9f90bc0f(a_ents, "garage_ambient_cleanup");
}

// Namespace namespace_1beb9396
// Params 0, eflags: 0x1 linked
// namespace_1beb9396<file_0>::function_4e8285e0
// Checksum 0xed88d74a, Offset: 0x5d08
// Size: 0xfc
function function_4e8285e0() {
    level flag::wait_till("street_civs_start");
    var_295a1e1f = getentarray("zurich_intro_camera_ai", "targetname");
    var_9cb1bda3 = arraygetclosest(self.origin, var_295a1e1f);
    if (!isdefined(var_9cb1bda3)) {
        return;
    }
    self lookatpos(var_9cb1bda3.origin);
    self thread ai::shoot_at_target("normal", var_9cb1bda3);
    wait(2);
    if (!isalive(var_9cb1bda3)) {
        return;
    }
    var_9cb1bda3 kill();
}

// Namespace namespace_1beb9396
// Params 0, eflags: 0x1 linked
// namespace_1beb9396<file_0>::function_dc91abc9
// Checksum 0xa652785f, Offset: 0x5e10
// Size: 0x254
function function_dc91abc9() {
    level scene::init("p7_fxanim_cp_zurich_car_crash_03_bundle");
    trigger::wait_till("street_exit_zone_trig");
    scene::add_scene_func("p7_fxanim_cp_zurich_car_crash_01_bundle", &function_d8cdc243, "play");
    level thread scene::play("p7_fxanim_cp_zurich_car_crash_01_bundle");
    function_723d47ab();
    level scene::play("p7_fxanim_cp_zurich_car_crash_02_bundle");
    level flag::set("garage_car_2nd_floor_standard_01_done");
    trigger::wait_till("garage_third_floor_trig");
    var_9582077f = getentarray("garage_car_scene_trig", "targetname");
    array::thread_all(var_9582077f, &function_95c63963);
    wait(21);
    level flag::wait_till_timeout(15, "garage_entrance_cleared");
    namespace_8e9083ff::function_1b3dfa61("garage_exit_gate_trig", undefined, 400.5, 512);
    umbragate_set("garage_umbra_gate", 1);
    scene::add_scene_func("p7_fxanim_cp_zurich_car_crash_03_bundle", &function_646cd830, "play");
    scene::add_scene_func("p7_fxanim_cp_zurich_car_crash_03_bundle", &function_5d018732, "done");
    level scene::play("p7_fxanim_cp_zurich_car_crash_03_bundle");
    level flag::set("garage_gate_open");
}

// Namespace namespace_1beb9396
// Params 0, eflags: 0x1 linked
// namespace_1beb9396<file_0>::function_723d47ab
// Checksum 0xcd6181ae, Offset: 0x6070
// Size: 0x44
function function_723d47ab() {
    if (level.activeplayers.size < 2) {
        level endon(#"hash_c88a6904");
    }
    namespace_8e9083ff::function_3adbd846("garage_car_2nd_floor_standard_01_trig", undefined, 1);
}

// Namespace namespace_1beb9396
// Params 0, eflags: 0x1 linked
// namespace_1beb9396<file_0>::function_1418d19
// Checksum 0x4c8ee678, Offset: 0x60c0
// Size: 0x202
function function_1418d19() {
    var_f6338e1d = struct::get_array("train_crash_glass_break_spot");
    var_c7b1d4be = struct::get("train_crash_sound_spot");
    playsoundatposition("evt_train_crash_front", var_c7b1d4be.origin);
    wait(6);
    foreach (e_player in level.activeplayers) {
        e_player playrumbleonentity("damage_heavy");
    }
    earthquake(0.25, 2, var_c7b1d4be.origin, 10000);
    foreach (var_ca17143d in var_f6338e1d) {
        glassradiusdamage(var_ca17143d.origin, var_ca17143d.radius, 700, 500, "MOD_GRENADE_SPLASH");
        wait(randomfloatrange(0.2, 0.3));
    }
}

// Namespace namespace_1beb9396
// Params 0, eflags: 0x1 linked
// namespace_1beb9396<file_0>::function_4d92b2c7
// Checksum 0xc802c8e8, Offset: 0x62d0
// Size: 0x64
function function_4d92b2c7() {
    level thread scene::play("p7_fxanim_cp_zurich_parking_wall_explode_bundle");
    mdl_wall = getent("garage_entrance_wall", "targetname");
    mdl_wall delete();
}

// Namespace namespace_1beb9396
// Params 1, eflags: 0x1 linked
// namespace_1beb9396<file_0>::function_3a6344d1
// Checksum 0x87d1a811, Offset: 0x6340
// Size: 0xa4
function function_3a6344d1(n_delay) {
    if (!isdefined(n_delay)) {
        n_delay = 1;
    }
    self endon(#"death");
    var_d29ecee5 = struct::get("train_crash_sound_spot");
    wait(n_delay);
    do {
        wait(0.1);
    } while (!namespace_8e9083ff::function_f8645b6(-1, var_d29ecee5.origin, 0.92));
    self trigger::use();
}

// Namespace namespace_1beb9396
// Params 1, eflags: 0x1 linked
// namespace_1beb9396<file_0>::function_48166ad7
// Checksum 0xb773eea6, Offset: 0x63f0
// Size: 0x24c
function function_48166ad7(str_objective) {
    var_80658d78 = array("p7_fxanim_cp_zurich_car_crash_01_bundle", "p7_fxanim_cp_zurich_car_crash_02_bundle", "p7_fxanim_cp_zurich_car_crash_06_bundle");
    scene::add_scene_func("p7_fxanim_cp_zurich_car_crash_stuck_bundle", &function_96b02c44, "play");
    scene::add_scene_func("p7_fxanim_cp_zurich_car_crash_stuck_bundle", &function_e0bb6e8b, "done");
    level thread scene::play("p7_fxanim_cp_zurich_car_crash_stuck_bundle");
    wait(0.05);
    foreach (str_bundle in var_80658d78) {
        scene::add_scene_func(str_bundle, &function_c9765981, "play");
        scene::add_scene_func(str_bundle, &function_e0bb6e8b, "done");
        level scene::init(str_bundle);
        wait(0.05);
    }
    if (str_objective === "garage") {
        level thread scene::skipto_end("p7_fxanim_cp_zurich_car_crash_06_bundle");
        level thread scene::skipto_end("p7_fxanim_cp_zurich_truck_crash_01_bundle");
        exploder::exploder("street_truck_crash_fires");
        exploder::exploder("street_truck_crash_garage_linger");
        level flag::set("street_balcony_spawn_closet_available");
    }
}

// Namespace namespace_1beb9396
// Params 0, eflags: 0x1 linked
// namespace_1beb9396<file_0>::function_1b074d61
// Checksum 0x702bde27, Offset: 0x6648
// Size: 0x78
function function_1b074d61() {
    level endon(#"hash_9903fa62");
    while (true) {
        var_21c17e53 = getaiteamarray("axis", "allies");
        level.var_ebb30c1a = arraycombine(var_21c17e53, level.activeplayers, 0, 0);
        wait(0.05);
    }
}

// Namespace namespace_1beb9396
// Params 0, eflags: 0x1 linked
// namespace_1beb9396<file_0>::function_d700903e
// Checksum 0x7ddf1fee, Offset: 0x66c8
// Size: 0x1f8
function function_d700903e() {
    self endon(#"death");
    self endon(#"stop_damage");
    while (true) {
        foreach (var_cbc51d9b in level.var_ebb30c1a) {
            if (isdefined(var_cbc51d9b) && var_cbc51d9b istouching(self)) {
                var_cabb1f64 = isalive(var_cbc51d9b) && !var_cbc51d9b util::is_hero() && !isplayer(var_cbc51d9b);
                is_player = isdefined(var_cbc51d9b.owner) && (isplayer(var_cbc51d9b) || isplayer(var_cbc51d9b.owner));
                if (var_cabb1f64) {
                    var_cbc51d9b util::stop_magic_bullet_shield();
                    var_cbc51d9b kill();
                    continue;
                }
                if (is_player) {
                    var_cbc51d9b dodamage(var_cbc51d9b.health + 1000, var_cbc51d9b.origin, self, undefined, undefined, "MOD_HIT_BY_OBJECT");
                }
            }
        }
        wait(0.05);
    }
}

// Namespace namespace_1beb9396
// Params 2, eflags: 0x0
// namespace_1beb9396<file_0>::function_42ac5715
// Checksum 0x4e1ac480, Offset: 0x68c8
// Size: 0x124
function function_42ac5715(var_cec244a2, str_trig_name) {
    var_efb53e77 = getent(var_cec244a2, "targetname");
    t_trig = getent(str_trig_name, "targetname");
    var_a56fa84f = struct::get(t_trig.target);
    var_efb53e77 endon(#"death");
    t_trig endon(#"death");
    while (!var_efb53e77 istouching(t_trig)) {
        wait(0.05);
    }
    radiusdamage(var_a56fa84f.origin, var_a56fa84f.radius, 700, 500, var_efb53e77);
    t_trig delete();
}

// Namespace namespace_1beb9396
// Params 1, eflags: 0x1 linked
// namespace_1beb9396<file_0>::function_96b02c44
// Checksum 0xb5f285c6, Offset: 0x69f8
// Size: 0xaa
function function_96b02c44(a_ents) {
    foreach (e_car in a_ents) {
        /#
            recordent(e_car);
        #/
        e_car thread util::auto_delete();
    }
}

// Namespace namespace_1beb9396
// Params 1, eflags: 0x1 linked
// namespace_1beb9396<file_0>::function_c9765981
// Checksum 0x394e6f6f, Offset: 0x6ab0
// Size: 0xaa
function function_c9765981(a_ents) {
    foreach (e_car in a_ents) {
        /#
            recordent(e_car);
        #/
        e_car thread function_d700903e();
    }
}

// Namespace namespace_1beb9396
// Params 1, eflags: 0x1 linked
// namespace_1beb9396<file_0>::function_e0bb6e8b
// Checksum 0x56c4fdf6, Offset: 0x6b68
// Size: 0xac
function function_e0bb6e8b(a_ents) {
    foreach (e_car in a_ents) {
        e_car notify(#"stop_damage");
    }
    self thread namespace_8e9083ff::function_9f90bc0f(a_ents, "rails_ambient_cleanup");
}

// Namespace namespace_1beb9396
// Params 1, eflags: 0x1 linked
// namespace_1beb9396<file_0>::function_646cd830
// Checksum 0x4aa6662b, Offset: 0x6c20
// Size: 0xd4
function function_646cd830(a_ents) {
    /#
        recordent(a_ents["street_phalanx_scatter"]);
    #/
    /#
        recordent(a_ents["street_phalanx_scatter"]);
    #/
    a_ents["car_crash_03"] thread function_d700903e();
    a_ents["car_crash_03_wall"] waittill(#"hash_c0199b64");
    mdl_wall = getent("garage_exit_wall", "targetname");
    mdl_wall delete();
}

// Namespace namespace_1beb9396
// Params 1, eflags: 0x1 linked
// namespace_1beb9396<file_0>::function_5d018732
// Checksum 0xe2cedc3e, Offset: 0x6d00
// Size: 0xac
function function_5d018732(a_ents) {
    foreach (e_car in a_ents) {
        e_car notify(#"stop_damage");
    }
    self thread namespace_8e9083ff::function_9f90bc0f(a_ents, "rails_ambient_cleanup");
}

// Namespace namespace_1beb9396
// Params 0, eflags: 0x1 linked
// namespace_1beb9396<file_0>::function_95c63963
// Checksum 0x2e6bd4d9, Offset: 0x6db8
// Size: 0xac
function function_95c63963() {
    self endon(#"death");
    assert(isdefined(self.script_string), "street_phalanx_scatter");
    self waittill(#"trigger");
    scene::add_scene_func(self.script_string, &function_91c120ae, "play");
    level scene::play(self.script_string);
    self delete();
}

// Namespace namespace_1beb9396
// Params 1, eflags: 0x1 linked
// namespace_1beb9396<file_0>::function_91c120ae
// Checksum 0xbb08dde3, Offset: 0x6e70
// Size: 0x6c
function function_91c120ae(a_ents) {
    var_19f54c8f = getentarray(self.scriptbundlename + "_gates", "targetname");
    array::thread_all(var_19f54c8f, &function_9b734821, a_ents);
}

// Namespace namespace_1beb9396
// Params 1, eflags: 0x1 linked
// namespace_1beb9396<file_0>::function_3f5b8a5e
// Checksum 0x18217bbf, Offset: 0x6ee8
// Size: 0x6c
function function_3f5b8a5e(a_ents) {
    var_19f54c8f = getentarray(self.scriptbundlename + "_gates", "targetname");
    array::thread_all(var_19f54c8f, &function_74bdec69, a_ents);
}

// Namespace namespace_1beb9396
// Params 1, eflags: 0x1 linked
// namespace_1beb9396<file_0>::function_74bdec69
// Checksum 0x4d638d32, Offset: 0x6f60
// Size: 0xa4
function function_74bdec69(a_ents) {
    self endon(#"death");
    n_time = 0.5;
    n_dist = 44;
    if (self.script_noteworthy === "bottom") {
        n_dist *= -1;
    }
    self.v_start = self.origin;
    self moveto(self.origin + (0, 0, n_dist), n_time);
}

// Namespace namespace_1beb9396
// Params 1, eflags: 0x1 linked
// namespace_1beb9396<file_0>::function_9b734821
// Checksum 0x7744d3be, Offset: 0x7010
// Size: 0x8c
function function_9b734821(a_ents) {
    self endon(#"death");
    t_close = getent(self.targetname + "_trig", "targetname");
    if (isdefined(t_close)) {
        t_close waittill(#"trigger");
    }
    self moveto(self.v_start, 0.62);
}

// Namespace namespace_1beb9396
// Params 1, eflags: 0x1 linked
// namespace_1beb9396<file_0>::function_d8cdc243
// Checksum 0x80fdaaf8, Offset: 0x70a8
// Size: 0x150
function function_d8cdc243(a_ents) {
    var_aea40fc = struct::get_array("garge_ramp_car_glass_break_spot");
    level waittill(#"hash_cc6fa4a6");
    foreach (mdl_car in a_ents) {
        foreach (var_b28eb61c in var_aea40fc) {
            glassradiusdamage(var_b28eb61c.origin, var_b28eb61c.radius, 700, 500, "MOD_GRENADE_SPLASH");
        }
    }
}

// Namespace namespace_1beb9396
// Params 0, eflags: 0x1 linked
// namespace_1beb9396<file_0>::function_c83d3033
// Checksum 0xd993451, Offset: 0x7200
// Size: 0x132
function function_c83d3033() {
    var_ae75b4be = struct::get_array("garage_elevator_doors", "script_noteworthy");
    a_mdl_doors = [];
    foreach (n_index, s in var_ae75b4be) {
        a_mdl_doors[n_index] = util::spawn_model(s.model, s.origin, s.angles);
        a_mdl_doors[n_index].targetname = s.targetname;
        a_mdl_doors[n_index].script_objective = "rails";
        wait(0.05);
    }
}

// Namespace namespace_1beb9396
// Params 0, eflags: 0x1 linked
// namespace_1beb9396<file_0>::function_b3a34ca5
// Checksum 0xd529fdfe, Offset: 0x7340
// Size: 0xa4
function function_b3a34ca5() {
    level endon(#"hash_e0d14dc8");
    level thread function_19764f0e();
    level thread function_60227c5();
    wait(2.1);
    level thread function_7248d34();
    wait(1.3);
    level thread function_adb65bc4();
    trigger::wait_till("garage_end_elevators_trig");
    function_9c0b8c73();
}

// Namespace namespace_1beb9396
// Params 0, eflags: 0x1 linked
// namespace_1beb9396<file_0>::function_19764f0e
// Checksum 0x8f4eaffd, Offset: 0x73f0
// Size: 0x266
function function_19764f0e() {
    level endon(#"hash_e0d14dc8");
    var_836db305 = getent("garage_elevator_door_left_entrance2", "targetname");
    var_73d5b598 = getent("garage_elevator_door_right_entrance2", "targetname");
    /#
        recordent(var_836db305);
    #/
    /#
        recordent(var_73d5b598);
    #/
    var_73d5b598 rotatepitch(-1, 0.1);
    var_836db305 moveto(var_836db305.origin + (0, 4 * -1, 0), 0.1);
    var_73d5b598 moveto(var_73d5b598.origin + (0, 4, 0), 0.1);
    var_73d5b598 waittill(#"movedone");
    while (true) {
        var_836db305 moveto(var_836db305.origin + (0, 36 * -1, 0), 0.45);
        var_73d5b598 moveto(var_73d5b598.origin + (0, 36, 0), 0.45);
        var_73d5b598 waittill(#"movedone");
        var_836db305 moveto(var_836db305.origin + (0, 36, 0), 0.45);
        var_73d5b598 moveto(var_73d5b598.origin + (0, 36 * -1, 0), 0.45);
        var_73d5b598 waittill(#"movedone");
    }
}

// Namespace namespace_1beb9396
// Params 0, eflags: 0x1 linked
// namespace_1beb9396<file_0>::function_60227c5
// Checksum 0xaca239af, Offset: 0x7660
// Size: 0x266
function function_60227c5() {
    level endon(#"hash_e0d14dc8");
    var_836db305 = getent("garage_elevator_door_left_entrance", "targetname");
    var_73d5b598 = getent("garage_elevator_door_right_entrance", "targetname");
    /#
        recordent(var_836db305);
    #/
    /#
        recordent(var_73d5b598);
    #/
    var_836db305 rotatepitch(4, 0.1);
    var_836db305 moveto(var_836db305.origin + (0, 2 * -1, 0), 0.1);
    var_73d5b598 moveto(var_73d5b598.origin + (0, 2, 0), 0.1);
    var_73d5b598 waittill(#"movedone");
    while (true) {
        var_836db305 moveto(var_836db305.origin + (0, 8 * -1, 0), 0.15);
        var_73d5b598 moveto(var_73d5b598.origin + (0, 8, 0), 0.15);
        var_73d5b598 waittill(#"movedone");
        var_836db305 moveto(var_836db305.origin + (0, 8, 0), 0.15);
        var_73d5b598 moveto(var_73d5b598.origin + (0, 8 * -1, 0), 0.15);
        var_73d5b598 waittill(#"movedone");
    }
}

// Namespace namespace_1beb9396
// Params 0, eflags: 0x1 linked
// namespace_1beb9396<file_0>::function_7248d34
// Checksum 0xb5b6da89, Offset: 0x78d0
// Size: 0x1fe
function function_7248d34() {
    level endon(#"hash_e0d14dc8");
    var_836db305 = getent("garage_elevator_door_left_2nd_floor_entrance", "targetname");
    var_73d5b598 = getent("garage_elevator_door_right_2nd_floor_entrance", "targetname");
    /#
        recordent(var_836db305);
    #/
    /#
        recordent(var_73d5b598);
    #/
    while (true) {
        var_836db305 moveto(var_836db305.origin + (0, 60 * -1, 0), 0.75);
        var_73d5b598 moveto(var_73d5b598.origin + (0, 60, 0), 0.75);
        var_73d5b598 playsound("evt_elevator_glitch");
        var_73d5b598 waittill(#"movedone");
        var_836db305 moveto(var_836db305.origin + (0, 60, 0), 0.75);
        var_73d5b598 moveto(var_73d5b598.origin + (0, 60 * -1, 0), 0.75);
        var_73d5b598 playsound("evt_elevator_glitch");
        var_73d5b598 waittill(#"movedone");
    }
}

// Namespace namespace_1beb9396
// Params 0, eflags: 0x1 linked
// namespace_1beb9396<file_0>::function_adb65bc4
// Checksum 0x1c7d2fa, Offset: 0x7ad8
// Size: 0x1be
function function_adb65bc4() {
    level endon(#"hash_e0d14dc8");
    var_836db305 = getent("garage_elevator_door_left_2nd_floor_entrance2", "targetname");
    var_73d5b598 = getent("garage_elevator_door_right_2nd_floor_entrance2", "targetname");
    /#
        recordent(var_836db305);
    #/
    /#
        recordent(var_73d5b598);
    #/
    while (true) {
        var_836db305 moveto(var_836db305.origin + (0, 35 * -1, 0), 0.6);
        var_73d5b598 moveto(var_73d5b598.origin + (0, 35, 0), 0.6);
        var_73d5b598 waittill(#"movedone");
        var_836db305 moveto(var_836db305.origin + (0, 35, 0), 0.6);
        var_73d5b598 moveto(var_73d5b598.origin + (0, 35 * -1, 0), 0.6);
        var_73d5b598 waittill(#"movedone");
    }
}

// Namespace namespace_1beb9396
// Params 0, eflags: 0x1 linked
// namespace_1beb9396<file_0>::function_9c0b8c73
// Checksum 0xd9865af, Offset: 0x7ca0
// Size: 0x3cc
function function_9c0b8c73() {
    var_836db305 = getent("garage_elevator_door_left_exit", "targetname");
    var_73d5b598 = getent("garage_elevator_door_right_exit", "targetname");
    var_bf22cfbd = getent("garage_elevator_door_left_exit2", "targetname");
    var_5de8c6ca = getent("garage_elevator_door_right_exit2", "targetname");
    var_b76dcc17 = namespace_8e9083ff::function_33ec653f("garage_exit_elevator_robots_spawn_manager", undefined, 0.15, &function_892106c9);
    var_bdf5e96c = getent("garage_exit_elevator_zone_aitrig", "targetname");
    /#
        recordent(var_836db305);
    #/
    /#
        recordent(var_73d5b598);
    #/
    /#
        recordent(var_bf22cfbd);
    #/
    /#
        recordent(var_5de8c6ca);
    #/
    playsoundatposition("evt_elevator_ding", struct::get("garage_elevator_sound_spot").origin);
    var_836db305 moveto(var_836db305.origin + (0, 64, 0), 2);
    var_73d5b598 moveto(var_73d5b598.origin + (0, 64 * -1, 0), 2);
    wait(0.4);
    var_bf22cfbd moveto(var_bf22cfbd.origin + (0, 64, 0), 2);
    var_5de8c6ca moveto(var_5de8c6ca.origin + (0, 64 * -1, 0), 2);
    var_5de8c6ca waittill(#"movedone");
    level notify(#"hash_90cef371");
    level flag::wait_till("garage_exit_elevator_zone_clear");
    var_836db305 moveto(var_836db305.origin + (0, 64 * -1, 0), 2);
    var_73d5b598 moveto(var_73d5b598.origin + (0, 64, 0), 2);
    wait(0.4);
    var_bf22cfbd moveto(var_bf22cfbd.origin + (0, 64 * -1, 0), 2);
    var_5de8c6ca moveto(var_5de8c6ca.origin + (0, 64, 0), 2);
}

// Namespace namespace_1beb9396
// Params 0, eflags: 0x1 linked
// namespace_1beb9396<file_0>::function_7a0e84a8
// Checksum 0xb40eea72, Offset: 0x8078
// Size: 0x3ec
function function_7a0e84a8() {
    var_3b159664 = getnodearray("garage_lift_gate_nodes", "script_noteworthy");
    foreach (nd in var_3b159664) {
        setenablenode(nd, 0);
    }
    var_19f54c8f = [];
    var_71955f5e = struct::get_array("p7_fxanim_cp_zurich_car_crash_04_bundle_gates");
    var_9797d9c7 = struct::get_array("p7_fxanim_cp_zurich_car_crash_05_bundle_gates");
    var_91ad292d = arraycombine(var_71955f5e, var_9797d9c7, 0, 0);
    wait(0.05);
    foreach (i, s_gate in var_91ad292d) {
        var_19f54c8f[i] = util::spawn_model(s_gate.model, s_gate.origin, s_gate.angles);
        var_19f54c8f[i].targetname = s_gate.targetname;
        var_19f54c8f[i].script_noteworthy = s_gate.script_noteworthy;
        var_19f54c8f[i].script_string = s_gate.script_string;
        var_19f54c8f[i].script_objective = "rails";
        wait(0.05);
    }
    scene::add_scene_func("p7_fxanim_cp_zurich_car_crash_04_bundle", &function_3f5b8a5e, "init");
    scene::add_scene_func("p7_fxanim_cp_zurich_car_crash_05_bundle", &function_3f5b8a5e, "init");
    scene::add_scene_func("p7_fxanim_cp_zurich_car_crash_04_bundle", &function_c9765981, "play");
    scene::add_scene_func("p7_fxanim_cp_zurich_car_crash_05_bundle", &function_c9765981, "play");
    scene::add_scene_func("p7_fxanim_cp_zurich_car_crash_04_bundle", &function_e0bb6e8b, "done");
    scene::add_scene_func("p7_fxanim_cp_zurich_car_crash_05_bundle", &function_e0bb6e8b, "done");
    level scene::init("p7_fxanim_cp_zurich_car_crash_04_bundle");
    wait(0.05);
    level scene::init("p7_fxanim_cp_zurich_car_crash_05_bundle");
}

// Namespace namespace_1beb9396
// Params 0, eflags: 0x1 linked
// namespace_1beb9396<file_0>::function_d987ae9
// Checksum 0xfd1d3b8b, Offset: 0x8470
// Size: 0x194
function function_d987ae9() {
    var_c4a1b346 = getent("garage_cleanup_trig", "targetname");
    var_c4a1b346 endon(#"death");
    while (true) {
        var_52adae1e = getaiteamarray("axis", "allies");
        foreach (ai in var_52adae1e) {
            var_cabb1f64 = isalive(ai) && !ai util::is_hero();
            if (var_cabb1f64 && !ai namespace_8e9083ff::player_can_see_me(1024) && ai istouching(var_c4a1b346)) {
                ai util::stop_magic_bullet_shield();
                ai kill();
            }
        }
        wait(1);
    }
}

// Namespace namespace_1beb9396
// Params 0, eflags: 0x1 linked
// namespace_1beb9396<file_0>::function_b7d40ae
// Checksum 0x7daae2ee, Offset: 0x8610
// Size: 0x54
function function_b7d40ae() {
    var_11cbfab3 = getentarray("break_glass", "script_noteworthy");
    array::thread_all(var_11cbfab3, &function_b09dbdde);
}

// Namespace namespace_1beb9396
// Params 0, eflags: 0x1 linked
// namespace_1beb9396<file_0>::function_b09dbdde
// Checksum 0x63a49940, Offset: 0x8670
// Size: 0x74
function function_b09dbdde() {
    self endon(#"death");
    var_26c7381f = self waittill(#"trigger");
    glassradiusdamage(var_26c7381f.origin, 64, 700, 500, "MOD_HIT_BY_OBJECT");
    self delete();
}

// Namespace namespace_1beb9396
// Params 0, eflags: 0x1 linked
// namespace_1beb9396<file_0>::function_ec9dd4a5
// Checksum 0xd196ebfb, Offset: 0x86f0
// Size: 0x54
function function_ec9dd4a5() {
    var_3e9d5326 = getentarray("garage_car_kill_trig", "targetname");
    array::thread_all(var_3e9d5326, &function_f3cdc2c1);
}

// Namespace namespace_1beb9396
// Params 0, eflags: 0x1 linked
// namespace_1beb9396<file_0>::function_f3cdc2c1
// Checksum 0x7853329d, Offset: 0x8750
// Size: 0xac
function function_f3cdc2c1() {
    self endon(#"death");
    s_damage = struct::get(self.target);
    n_radius = s_damage.radius;
    if (!isdefined(n_radius)) {
        n_radius = 64;
    }
    self waittill(#"trigger");
    radiusdamage(s_damage.origin, n_radius, 1200, 1100);
}

/#

    // Namespace namespace_1beb9396
    // Params 0, eflags: 0x0
    // namespace_1beb9396<file_0>::function_9075d8d6
    // Checksum 0xf6744be, Offset: 0x8808
    // Size: 0x70
    function function_9075d8d6() {
        self endon(#"death");
        for (n_stage = 0; true; n_stage++) {
            self thread namespace_8e9083ff::function_ff016910("street_phalanx_scatter" + n_stage, undefined);
            self waittill(#"movedone");
            self notify(#"hash_8fba9");
        }
    }

#/
