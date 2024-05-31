#using scripts/cp/cp_mi_sing_sgen_sound;
#using scripts/cp/cp_mi_sing_sgen_util;
#using scripts/cp/cp_mi_sing_sgen_testing_lab_igc;
#using scripts/cp/cp_mi_sing_sgen_pallas;
#using scripts/cp/cp_mi_sing_sgen_fallen_soldiers;
#using scripts/cp/cp_mi_sing_sgen;
#using scripts/cp/_util;
#using scripts/cp/_skipto;
#using scripts/cp/_objectives;
#using scripts/cp/_load;
#using scripts/cp/_dialog;
#using scripts/cp/cybercom/_cybercom_util;
#using scripts/cp/cybercom/_cybercom;
#using scripts/cp/gametypes/_save;
#using scripts/cp/gametypes/_battlechatter;
#using scripts/shared/exploder_shared;
#using scripts/shared/util_shared;
#using scripts/shared/trigger_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/math_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/array_shared;
#using scripts/shared/ai_shared;
#using scripts/codescripts/struct;

#using_animtree("generic");

#namespace namespace_4c73eafb;

// Namespace namespace_4c73eafb
// Params 2, eflags: 0x0
// Checksum 0xc0a3eab, Offset: 0x1408
// Size: 0x382
function function_32dc1c24(str_objective, var_74cd64bc) {
    if (var_74cd64bc) {
        namespace_fa13d4ba::function_bff1a867(str_objective);
        level thread namespace_a5e80dc::function_652f4022();
        level notify(#"hash_92687102");
        objectives::complete("cp_level_sgen_enter_sgen_no_pointer");
        objectives::complete("cp_level_sgen_investigate_sgen");
        objectives::complete("cp_level_sgen_locate_emf");
        objectives::complete("cp_level_sgen_descend_into_core");
        objectives::complete("cp_level_sgen_goto_signal_source");
        objectives::set("cp_level_sgen_goto_server_room");
        level thread scene::skipto_end("cin_sgen_14_humanlab_3rd_sh200");
        load::function_a2995f22();
    }
    var_77725d68 = getentarray("interference_on_trig", "targetname");
    array::thread_all(var_77725d68, &function_d791b0a9, 1);
    var_4edbd293 = getentarray("interference_off_trig", "targetname");
    array::thread_all(var_4edbd293, &function_d791b0a9, 0);
    level thread scene::play("cin_sgen_14_01_humanlab_vign_deadbodies");
    level clientfield::set("w_underwater_state", 1);
    spawner::add_spawn_function_group("dark_battle_jumpdown_bot", "script_noteworthy", &function_5e6c249b);
    array::thread_all(getentarray("surgical_facility_interior_door_trigger", "targetname"), &function_69df7be3);
    level thread scene::init("cin_sgen_15_01_darkbattle_vign_new_flare_decayedmen");
    level thread namespace_cba4cc55::set_door_state("surgical_catwalk_top_door", "open");
    level thread namespace_cba4cc55::set_door_state("dark_battle_end_door", "close");
    level._effect["water_rise"] = "water/fx_water_rise_splash_md";
    level thread function_e5d88bbd();
    level thread function_3cc9e129();
    var_acb9c8b6 = getnode("hendricks_post_dni_lab", "targetname");
    level.var_2fd26037 setgoal(var_acb9c8b6, 1, 16);
    trigger::wait_till("dark_battle_end");
    level notify(#"hash_a254d667");
    var_64e85e6d = getentarray("surgical_facility_spawner_ai", "targetname");
    array::wait_till(var_64e85e6d, "death");
    level thread namespace_cba4cc55::set_door_state("dark_battle_end_door", "open");
}

// Namespace namespace_4c73eafb
// Params 0, eflags: 0x0
// Checksum 0x42aa106, Offset: 0x1798
// Size: 0x162
function function_3cc9e129() {
    trigger::wait_till("pre_electromagnetic_room_trigger", undefined, undefined, 0);
    level dialog::remote("kane_power_s_out_ahead_s_0");
    level.var_2fd26037 dialog::say("hend_copy_that_1", 1);
    trigger::wait_till("electromagnetic_room_trigger", undefined, undefined, 0);
    level dialog::remote("kane_picking_up_radiation_0");
    level flag::wait_till("hendricks_door_open");
    level dialog::function_13b3b16a("plrf_good_job_hendricks_0");
    level.var_2fd26037 dialog::say("hend_uh_i_didn_t_do_th_0", 2);
    trigger::wait_till("plyr_shit_2", undefined, undefined, 0);
    level dialog::function_13b3b16a("plyr_more_test_subjects_0", 0.75);
    level flag::wait_till("water_robot_spawned");
    level thread namespace_d40478f6::function_34465ae6();
    level.var_2fd26037 dialog::say("hend_they_re_in_the_water_0", 4);
    level battlechatter::function_d9f49fba(1);
}

// Namespace namespace_4c73eafb
// Params 1, eflags: 0x0
// Checksum 0x1bd3faed, Offset: 0x1908
// Size: 0x4d
function function_d791b0a9(b_state) {
    level endon(#"hash_6a9c5cb5");
    while (isdefined(self)) {
        e_player = self waittill(#"trigger");
        e_player clientfield::set_to_player("oed_interference", b_state);
    }
}

// Namespace namespace_4c73eafb
// Params 0, eflags: 0x0
// Checksum 0xd00fb859, Offset: 0x1960
// Size: 0x5a
function function_5d8d8c7a() {
    level endon(#"hash_fe2135f");
    wait(8);
    level.var_2fd26037 dialog::say("hend_need_a_hand_i_ain_t_0");
    wait(randomintrange(10, 15));
    level.var_2fd26037 dialog::say("hend_gimme_boost_we_need_0");
}

// Namespace namespace_4c73eafb
// Params 0, eflags: 0x0
// Checksum 0x90abc420, Offset: 0x19c8
// Size: 0x42
function function_5e6c249b() {
    self ai::set_behavior_attribute("rogue_control", "forced_level_2");
    self ai::set_behavior_attribute("rogue_control_speed", "sprint");
}

// Namespace namespace_4c73eafb
// Params 4, eflags: 0x0
// Checksum 0x320b7eeb, Offset: 0x1a18
// Size: 0x22
function function_bbb54b1a(str_objective, var_74cd64bc, var_e4cd2b8b, player) {
    
}

// Namespace namespace_4c73eafb
// Params 0, eflags: 0x0
// Checksum 0x47a193c5, Offset: 0x1a48
// Size: 0x15a
function function_6b91309b() {
    var_7667766b = getent("player_raise_hendricks_trigger", "targetname");
    var_7667766b triggerenable(0);
    level flag::wait_till("player_raise_hendricks_hendricks_ready");
    var_7667766b triggerenable(1);
    objectives::complete("cp_waypoint_breadcrumb");
    objectives::set("cp_level_sgen_lift_hendricks", level.var_2fd26037.origin);
    var_5243a970 = var_7667766b waittill(#"trigger");
    objectives::complete("cp_level_sgen_lift_hendricks");
    level flag::set("player_raise_hendricks_hendricks");
    a_scene_ents = [];
    level scene::add_scene_func("cin_sgen_15_01_darkbattle_vign_new_flare_hendricks_climb", &function_f45def6e, "done", a_scene_ents);
    level thread scene::play("cin_sgen_15_01_darkbattle_vign_new_flare_hendricks_climb", var_5243a970);
    level flag::set("player_raise_hendricks_player_ready");
}

// Namespace namespace_4c73eafb
// Params 1, eflags: 0x0
// Checksum 0xb269b895, Offset: 0x1bb0
// Size: 0x7b
function function_f45def6e(a_scene_ents) {
    foreach (ent in a_scene_ents) {
        if (isplayer(ent)) {
            wait(1);
            ent cybercom::function_6c141a2d();
        }
    }
}

// Namespace namespace_4c73eafb
// Params 0, eflags: 0x0
// Checksum 0xa89c746f, Offset: 0x1c38
// Size: 0x42
function function_e5d88bbd() {
    level thread function_731772d9();
    level thread function_c760c273();
    level thread function_3e856999();
    level thread function_26c8bae0();
}

// Namespace namespace_4c73eafb
// Params 0, eflags: 0x0
// Checksum 0x8eb49b5e, Offset: 0x1c88
// Size: 0x1a
function function_731772d9() {
    objectives::breadcrumb("dark_battle_breadcrumb");
}

// Namespace namespace_4c73eafb
// Params 0, eflags: 0x0
// Checksum 0xac9a7992, Offset: 0x1cb0
// Size: 0x172
function function_26c8bae0() {
    level thread scene::init("door_dark_battle", "targetname");
    e_door = getent("hendricks_dark_battle_top_door", "targetname");
    level flag::wait_till("dark_battle_hendricks_above");
    wait(2);
    e_door rotateyaw(-90, 2);
    wait(2);
    level thread scene::play("door_dark_battle", "targetname");
    e_door_clip = getent("dark_room_entrance_door_clip", "targetname");
    e_door_clip playsound("evt_dark_door_open");
    wait(1.5);
    e_door_clip movez(-144, 1);
    wait(1.5);
    e_door_clip delete();
    level flag::set("hendricks_door_open");
    savegame::checkpoint_save();
    level thread function_f229e2b5();
    level waittill(#"close_door");
    level thread namespace_cba4cc55::set_door_state("surgical_catwalk_top_door", "close");
}

// Namespace namespace_4c73eafb
// Params 0, eflags: 0x0
// Checksum 0x3054353e, Offset: 0x1e30
// Size: 0x14a
function function_3e856999() {
    trigger::wait_till("dark_battle_down_stairs", "script_noteworthy", undefined, 0);
    level.var_2fd26037 ai::set_behavior_attribute("cqb", 1);
    level.var_2fd26037.goalradius = 8;
    level thread function_6b91309b();
    level scene::play("cin_sgen_15_01_darkbattle_vign_new_flare_hendricks_pre_arrive");
    level scene::play("cin_sgen_15_01_darkbattle_vign_new_flare_hendricks_arrive");
    level flag::set("player_raise_hendricks_hendricks_ready");
    level thread function_5d8d8c7a();
    level flag::wait_till("player_raise_hendricks_player_ready");
    level scene::stop("cin_sgen_15_01_darkbattle_vign_new_flare_hendricks_arrive");
    level scene::add_scene_func("cin_sgen_15_01_darkbattle_vign_new_flare_hendricks_a", &function_86c3565d, "play");
    level scene::add_scene_func("cin_sgen_15_01_darkbattle_vign_new_flare_hendricks_idlea", &function_acc5d0c6, "play");
}

// Namespace namespace_4c73eafb
// Params 1, eflags: 0x0
// Checksum 0x535ae97d, Offset: 0x1f88
// Size: 0x42
function function_86c3565d(a_ents) {
    level flag::set("dark_battle_hendricks_above");
    playsoundatposition("evt_hend_door_beep", (4141, -3845, -5073));
}

// Namespace namespace_4c73eafb
// Params 1, eflags: 0x0
// Checksum 0xb23ced35, Offset: 0x1fd8
// Size: 0xa2
function function_acc5d0c6(a_ents) {
    trigger::wait_till("dark_battle_hendricks_flarecarry_b_trigger", undefined, undefined, 0);
    if (level flag::get("pallas_start")) {
        return;
    }
    level scene::add_scene_func("cin_sgen_15_01_darkbattle_vign_new_flare_hendricks_idleb", &function_d2c84b2f, "play");
    level scene::stop("cin_sgen_15_01_darkbattle_vign_new_flare_hendricks_idlea");
    level scene::play("cin_sgen_15_01_darkbattle_vign_new_flare_hendricks_b");
}

// Namespace namespace_4c73eafb
// Params 1, eflags: 0x0
// Checksum 0xba7112eb, Offset: 0x2088
// Size: 0xa2
function function_d2c84b2f(a_ents) {
    trigger::wait_till("dark_battle_hendricks_flarecarry_c_trigger", undefined, undefined, 0);
    if (level flag::get("pallas_start")) {
        return;
    }
    level scene::add_scene_func("cin_sgen_15_01_darkbattle_vign_new_flare_hendricks_idlec", &function_c8b6f250, "play");
    level scene::stop("cin_sgen_15_01_darkbattle_vign_new_flare_hendricks_idleb");
    level scene::play("cin_sgen_15_01_darkbattle_vign_new_flare_hendricks_c");
}

// Namespace namespace_4c73eafb
// Params 1, eflags: 0x0
// Checksum 0xc9aa2704, Offset: 0x2138
// Size: 0xc2
function function_c8b6f250(a_ents) {
    level flag::wait_till("dark_battle_hendricks_flarecarry_end");
    level thread function_9a64520();
    level battlechatter::function_d9f49fba(0);
    level flag::set("dark_battle_hendricks_ambush");
    level scene::stop("cin_sgen_15_01_darkbattle_vign_new_flare_hendricks_idlec");
    level thread scene::play("cin_sgen_15_01_darkbattle_vign_new_flare_hendricks_d");
    level thread namespace_d40478f6::function_973b77f9();
    level util::delay(30, undefined, &exploder::stop_exploder, "dark_battle_flare2");
}

// Namespace namespace_4c73eafb
// Params 0, eflags: 0x0
// Checksum 0x999fbd8, Offset: 0x2208
// Size: 0x6a
function function_9a64520() {
    level waittill(#"hash_391cc978");
    str_hero = "hendricks_backpack";
    if (!isdefined(level.heroes["hendricks_backpack"])) {
        str_hero = "hendricks";
    }
    level.var_2fd26037 util::unmake_hero(str_hero);
    level.var_2fd26037 util::self_delete();
}

// Namespace namespace_4c73eafb
// Params 0, eflags: 0x0
// Checksum 0x7de72138, Offset: 0x2280
// Size: 0x92
function function_a8cfe9ae() {
    level scene::stop("cin_sgen_15_01_darkbattle_vign_new_flare_hendricks_idlea");
    level scene::stop("cin_sgen_15_01_darkbattle_vign_new_flare_hendricks_b");
    level scene::stop("cin_sgen_15_01_darkbattle_vign_new_flare_hendricks_idleb");
    level scene::stop("cin_sgen_15_01_darkbattle_vign_new_flare_hendricks_c");
    level scene::stop("cin_sgen_15_01_darkbattle_vign_new_flare_hendricks_idlec");
    level scene::stop("cin_sgen_15_01_darkbattle_vign_new_flare_hendricks_d");
}

// Namespace namespace_4c73eafb
// Params 1, eflags: 0x0
// Checksum 0x3712d1bf, Offset: 0x2320
// Size: 0x22
function function_40fa24f4(a_ents) {
    level.var_2fd26037 scene::stop();
}

// Namespace namespace_4c73eafb
// Params 0, eflags: 0x0
// Checksum 0x8c029d97, Offset: 0x2350
// Size: 0x8a
function function_c760c273() {
    var_bcabda32 = getentarray("surgical_facility_spawn_trigger", "targetname");
    array::thread_all(var_bcabda32, &function_fed6294);
    var_62a3a7da = struct::get_array("hendricks_riser");
    array::thread_all(var_62a3a7da, &function_80aab711);
}

// Namespace namespace_4c73eafb
// Params 0, eflags: 0x0
// Checksum 0xf00a57e3, Offset: 0x23e8
// Size: 0x15a
function function_80aab711() {
    var_dc854c29 = getent("surgical_facility_spawner", "targetname");
    var_687222b4 = randomintrange(1, 3);
    var_f6c5842 = var_dc854c29 spawner::spawn(1);
    var_f6c5842 endon(#"death");
    self scene::init("cin_sgen_15_04_robot_ambush_aie_arise_robot0" + var_687222b4 + "_water", var_f6c5842);
    var_f6c5842 namespace_ed09da6e::function_fbd51610();
    var_f6c5842.targetname = "hendricks_riser_ai";
    level flag::wait_till("dark_battle_hendricks_ambush");
    wait(randomfloatrange(0.1, 1));
    var_f6c5842 thread namespace_ed09da6e::function_89ba9422();
    self scene::play("cin_sgen_15_04_robot_ambush_aie_arise_robot0" + var_687222b4 + "_water", var_f6c5842);
    s_goal = struct::get(self.target, "targetname");
    wait(10);
    var_f6c5842 kill();
}

// Namespace namespace_4c73eafb
// Params 0, eflags: 0x0
// Checksum 0x72605467, Offset: 0x2550
// Size: 0x33a
function function_fed6294() {
    level endon(#"hash_a254d667");
    e_volume = undefined;
    var_b11bb32e = getentarray("surgical_facility_dark_battle_volume", "targetname");
    a_s_spawn_points = struct::get_array(self.target);
    v_origin = self.origin;
    n_radius = self.radius;
    var_be1f149f = spawn("script_origin", self.origin + (0, 0, 10));
    foreach (var_95b9818c in var_b11bb32e) {
        if (var_be1f149f istouching(var_95b9818c)) {
            e_volume = var_95b9818c;
        }
    }
    var_be1f149f util::self_delete();
    a_s_spawn_points = array::randomize(a_s_spawn_points);
    self waittill(#"trigger");
    var_fa08d055 = 0;
    foreach (player in level.players) {
        if (player istouching(e_volume)) {
            var_fa08d055++;
        }
    }
    switch (var_fa08d055) {
    case 1:
        var_3548bc79 = 2;
        break;
    case 2:
        var_3548bc79 = 3;
        break;
    case 3:
        var_3548bc79 = 5;
        break;
    case 4:
        var_3548bc79 = 7;
        break;
    }
    var_f66bfce8 = 0;
    var_64e85e6d = getaispeciesarray("all", "robot");
    foreach (var_f6c5842 in var_64e85e6d) {
        if (var_f6c5842 istouching(var_95b9818c)) {
            var_f66bfce8++;
        }
    }
    foreach (n_index, s_spawn_point in a_s_spawn_points) {
        if (n_index < var_3548bc79 && var_f66bfce8 < 24) {
            level thread function_454f9298(s_spawn_point, n_index);
        }
    }
    level flag::set("water_robot_spawned");
}

// Namespace namespace_4c73eafb
// Params 2, eflags: 0x0
// Checksum 0x5d14b1a0, Offset: 0x2898
// Size: 0x122
function function_454f9298(s_spawn_point, n_index) {
    var_dc854c29 = getent("surgical_facility_spawner", "targetname");
    if (n_index > 0) {
        wait(n_index + randomfloatrange(0.5, 1.5));
    }
    playfx(level._effect["water_rise"], s_spawn_point.origin);
    var_f6c5842 = var_dc854c29 spawner::spawn(1);
    var_f6c5842 ai::set_behavior_attribute("rogue_control", "forced_level_2");
    s_spawn_point scene::play("cin_sgen_15_04_robot_ambush_aie_arise_robot0" + randomintrange(1, 3) + "_water", var_f6c5842);
    var_f6c5842 thread namespace_cba4cc55::function_c22db411(2);
    var_f6c5842 clientfield::set("sndStepSet", 1);
}

// Namespace namespace_4c73eafb
// Params 0, eflags: 0x0
// Checksum 0x1b9e9f9a, Offset: 0x29c8
// Size: 0xa2
function function_69df7be3() {
    str_targetname = self.target;
    level thread namespace_cba4cc55::set_door_state(str_targetname, "open");
    ent = self waittill(#"trigger");
    if (!isdefined(level.var_b5a36ce0)) {
        level.var_b5a36ce0 = 1;
    } else {
        level.var_b5a36ce0++;
    }
    if (level.var_b5a36ce0 < 3) {
        level scene::stop("cin_sgen_14_01_humanlab_vign_deadbodies", 1);
        level thread namespace_cba4cc55::set_door_state(str_targetname, "close");
    }
}

// Namespace namespace_4c73eafb
// Params 2, eflags: 0x0
// Checksum 0x98c91c48, Offset: 0x2a78
// Size: 0x2d2
function function_5f76850f(str_objective, var_74cd64bc) {
    if (var_74cd64bc) {
        objectives::complete("cp_level_sgen_enter_sgen_no_pointer");
        objectives::complete("cp_level_sgen_investigate_sgen");
        objectives::complete("cp_level_sgen_locate_emf");
        objectives::complete("cp_level_sgen_descend_into_core");
        objectives::complete("cp_level_sgen_goto_signal_source");
        level thread function_f229e2b5();
        load::function_a2995f22();
    }
    level thread function_bed8321d();
    level.var_b0d148eb = 6 + level.players.size * 4;
    level clientfield::set("w_underwater_state", 1);
    level util::clientnotify("sndRHStart");
    level thread function_683fbc9();
    level thread function_cc91d61d();
    level thread function_6027d85b();
    namespace_646f304f::function_4ef8cf79();
    trigger::wait_till("weapons_research_vo");
    level flag::set("weapons_research_vo_start");
    level flag::wait_till("weapons_research_vo_done");
    a_ai = getaiteamarray("team3");
    var_d11bed07 = [];
    foreach (ai in a_ai) {
        if (isdefined(ai.activated) && ai.activated) {
            if (!isdefined(var_d11bed07)) {
                var_d11bed07 = [];
            } else if (!isarray(var_d11bed07)) {
                var_d11bed07 = array(var_d11bed07);
            }
            var_d11bed07[var_d11bed07.size] = ai;
        }
    }
    if (var_d11bed07.size) {
        array::run_all(var_d11bed07, &ai::set_behavior_attribute, "rogue_control_speed", "sprint");
        array::wait_till(var_d11bed07, "death");
        wait(2);
    }
    skipto::function_be8adfb8("charging_station");
}

// Namespace namespace_4c73eafb
// Params 4, eflags: 0x0
// Checksum 0x5695dc30, Offset: 0x2d58
// Size: 0x22
function function_9724b9d5(str_objective, var_74cd64bc, var_e4cd2b8b, player) {
    
}

// Namespace namespace_4c73eafb
// Params 0, eflags: 0x0
// Checksum 0x158c49e8, Offset: 0x2d88
// Size: 0xb3
function function_bed8321d() {
    a_ai_bots = getaiteamarray("axis", "team3");
    foreach (ai_bot in a_ai_bots) {
        if (isalive(ai_bot)) {
            ai_bot kill();
            util::wait_network_frame();
        }
    }
}

// Namespace namespace_4c73eafb
// Params 0, eflags: 0x0
// Checksum 0xd8b79c8, Offset: 0x2e48
// Size: 0x632
function function_683fbc9() {
    array::run_all(getentarray("charging_station_flood_trigger", "script_noteworthy"), &setinvisibletoall);
    array::thread_all(getspawnerarray("charging_station_corner_spawner", "script_noteworthy"), &spawner::add_spawn_function, &function_e55310df);
    var_7082999f = struct::get_array("charging_station_spawn_point");
    var_e95eb09f = getent("charging_station_trigger", "targetname");
    foreach (n_index, s_spawn_point in var_7082999f) {
        s_spawn_point function_471a9c28();
        if (n_index % 2 == 0) {
            util::wait_network_frame();
        }
    }
    var_8b8ed7a5 = util::spawn_model("tag_origin");
    var_e95eb09f.var_7082999f = [];
    var_e95eb09f.var_7082999f["left"] = [];
    var_e95eb09f.var_7082999f["right"] = [];
    var_e95eb09f.var_57783f19 = [];
    var_e95eb09f.var_426817d3 = [];
    var_e95eb09f.var_426817d3["right"] = [];
    var_e95eb09f.var_426817d3["left"] = [];
    var_e95eb09f.a_volumes = getentarray(var_e95eb09f.target, "targetname");
    foreach (s_spawn_point in var_7082999f) {
        var_8b8ed7a5.origin = s_spawn_point.origin;
        foreach (e_volume in var_e95eb09f.a_volumes) {
            if (var_8b8ed7a5 istouching(e_volume) && s_spawn_point.script_noteworthy === "real") {
                if (e_volume.script_noteworthy == "left_volume") {
                    if (!isdefined(var_e95eb09f.var_7082999f["left"])) {
                        var_e95eb09f.var_7082999f["left"] = [];
                    } else if (!isarray(var_e95eb09f.var_7082999f["left"])) {
                        var_e95eb09f.var_7082999f["left"] = array(var_e95eb09f.var_7082999f["left"]);
                    }
                    var_e95eb09f.var_7082999f["left"][var_e95eb09f.var_7082999f["left"].size] = s_spawn_point;
                } else {
                    if (!isdefined(var_e95eb09f.var_7082999f["right"])) {
                        var_e95eb09f.var_7082999f["right"] = [];
                    } else if (!isarray(var_e95eb09f.var_7082999f["right"])) {
                        var_e95eb09f.var_7082999f["right"] = array(var_e95eb09f.var_7082999f["right"]);
                    }
                    var_e95eb09f.var_7082999f["right"][var_e95eb09f.var_7082999f["right"].size] = s_spawn_point;
                }
                if (s_spawn_point.script_string === "timed_start") {
                    if (!isdefined(var_e95eb09f.var_57783f19)) {
                        var_e95eb09f.var_57783f19 = [];
                    } else if (!isarray(var_e95eb09f.var_57783f19)) {
                        var_e95eb09f.var_57783f19 = array(var_e95eb09f.var_57783f19);
                    }
                    var_e95eb09f.var_57783f19[var_e95eb09f.var_57783f19.size] = s_spawn_point;
                    continue;
                }
                if (s_spawn_point.script_string === "left_solo_start") {
                    if (!isdefined(var_e95eb09f.var_426817d3["left"])) {
                        var_e95eb09f.var_426817d3["left"] = [];
                    } else if (!isarray(var_e95eb09f.var_426817d3["left"])) {
                        var_e95eb09f.var_426817d3["left"] = array(var_e95eb09f.var_426817d3["left"]);
                    }
                    var_e95eb09f.var_426817d3["left"][var_e95eb09f.var_426817d3["left"].size] = s_spawn_point;
                    continue;
                }
                if (s_spawn_point.script_string === "right_solo_start") {
                    if (!isdefined(var_e95eb09f.var_426817d3["right"])) {
                        var_e95eb09f.var_426817d3["right"] = [];
                    } else if (!isarray(var_e95eb09f.var_426817d3["right"])) {
                        var_e95eb09f.var_426817d3["right"] = array(var_e95eb09f.var_426817d3["right"]);
                    }
                    var_e95eb09f.var_426817d3["right"][var_e95eb09f.var_426817d3["right"].size] = s_spawn_point;
                }
            }
        }
    }
    var_8b8ed7a5 util::self_delete();
    var_e95eb09f thread function_14ae62b8();
}

// Namespace namespace_4c73eafb
// Params 0, eflags: 0x0
// Checksum 0xcee94985, Offset: 0x3488
// Size: 0x4a
function function_f229e2b5() {
    objectives::breadcrumb("charging_station_breadcrumb");
    objectives::set("cp_level_sgen_goto_server_room_indicator", struct::get("pallas_elevator_descent_objective"));
}

// Namespace namespace_4c73eafb
// Params 0, eflags: 0x0
// Checksum 0xcbf635ee, Offset: 0x34e0
// Size: 0x313
function function_cc91d61d() {
    s_start_point = struct::get("charging_station_power_on");
    var_197d929 = struct::get(s_start_point.target);
    trigger::wait_till("enter_charging_station", undefined, undefined, 0);
    util::delay(1.5, undefined, &function_54efd092);
    util::delay(0.25, undefined, &function_fe4282f);
    var_64e85e6d = getentarray("charging_station_ai", "targetname");
    var_fbbef3a = getentarray("charging_station_mdl", "targetname");
    var_35590ba = arraycombine(var_64e85e6d, var_fbbef3a, 0, 0);
    var_bd95641e = [];
    foreach (var_6104a93b in var_35590ba) {
        n_index = namespace_cba4cc55::round_up_to_ten(int(var_6104a93b.origin[0]));
        if (!isdefined(var_bd95641e[n_index])) {
            var_bd95641e[n_index] = [];
        }
        if (!isdefined(var_bd95641e[n_index])) {
            var_bd95641e[n_index] = [];
        } else if (!isarray(var_bd95641e[n_index])) {
            var_bd95641e[n_index] = array(var_bd95641e[n_index]);
        }
        var_bd95641e[n_index][var_bd95641e[n_index].size] = var_6104a93b;
    }
    var_6572010 = getarraykeys(var_bd95641e);
    var_d6c4ab70 = array::sort_by_value(var_6572010);
    foreach (n_index, n_key in var_d6c4ab70) {
        foreach (var_6104a93b in var_bd95641e[n_key]) {
            if (isai(var_6104a93b)) {
                var_6104a93b ai::set_behavior_attribute("rogue_control", "forced_level_1");
                continue;
            }
            var_6104a93b clientfield::set("turn_fake_robot_eye", 1);
        }
        wait(0.2);
    }
}

// Namespace namespace_4c73eafb
// Params 0, eflags: 0x0
// Checksum 0x6daa361b, Offset: 0x3800
// Size: 0x6b
function function_fe4282f() {
    foreach (player in level.activeplayers) {
        player playrumbleonentity("damage_light");
    }
}

// Namespace namespace_4c73eafb
// Params 0, eflags: 0x0
// Checksum 0x88637ad4, Offset: 0x3878
// Size: 0x42
function function_e55310df() {
    self ai::set_behavior_attribute("rogue_control", "forced_level_2");
    self ai::set_behavior_attribute("rogue_control_speed", "sprint");
}

// Namespace namespace_4c73eafb
// Params 1, eflags: 0x0
// Checksum 0x6140d15b, Offset: 0x38c8
// Size: 0x4a
function function_5e9ba6b0(str_flag) {
    self endon(#"trigger");
    if (!level flag::exists(str_flag)) {
        level flag::init(str_flag);
    }
    level flag::wait_till(str_flag);
}

// Namespace namespace_4c73eafb
// Params 0, eflags: 0x0
// Checksum 0x7ea70645, Offset: 0x3920
// Size: 0x407
function function_14ae62b8() {
    level endon(#"hash_8b1af0b6");
    if (!level flag::exists("charging_chamber_spawn_gate")) {
        level flag::init("charging_chamber_spawn_gate");
    }
    self thread function_16c18dca();
    e_player = self waittill(#"trigger");
    if (level.players.size == 1 && !e_player issprinting()) {
        trigger::wait_till("trig_solo_walk_spawns");
    }
    level thread namespace_d40478f6::function_29597dc9();
    level util::clientnotify("sndRHStop");
    level.var_65e3a64d = 0;
    var_72c8d114 = 0;
    var_63f2fbaf = 0;
    while (level.var_b0d148eb > 0) {
        s_spawn_point = undefined;
        var_7082999f = [];
        if (self.var_ba18db07 == "right" && self.var_7082999f["right"].size > 0) {
            var_7082999f = arraycopy(self.var_7082999f["right"]);
        } else if (self.var_ba18db07 == "left" && self.var_7082999f["left"].size > 0) {
            var_7082999f = arraycopy(self.var_7082999f["left"]);
        } else {
            var_7082999f = arraycombine(self.var_7082999f["left"], self.var_7082999f["right"], 0, 0);
        }
        if (var_7082999f.size == 0) {
            break;
        }
        if (!var_72c8d114 && level.players.size == 1 && self.var_ba18db07 != "both" && self.var_426817d3[self.var_ba18db07].size > 0) {
            s_spawn_point = array::random(self.var_426817d3[self.var_ba18db07]);
            arrayremovevalue(self.var_426817d3[self.var_ba18db07], s_spawn_point);
            if (self.var_426817d3[self.var_ba18db07].size == 0) {
                var_72c8d114 = 1;
            }
        }
        if (var_72c8d114 && !var_63f2fbaf) {
            foreach (var_3bfe0114 in self.var_57783f19) {
                arrayremovevalue(self.var_7082999f["right"], var_3bfe0114);
                arrayremovevalue(self.var_7082999f["left"], var_3bfe0114);
            }
            var_63f2fbaf = 1;
        }
        if (!isdefined(s_spawn_point)) {
            s_spawn_point = array::random(var_7082999f);
        }
        if (!(isdefined(s_spawn_point.activated) && s_spawn_point.activated)) {
            s_spawn_point notify(#"awaken");
            level.var_65e3a64d++;
            if (level.var_65e3a64d < 4) {
                wait(0.1 + 0.1 * level.var_65e3a64d);
            } else {
                wait(1.5 / level.players.size);
            }
        }
        arrayremovevalue(self.var_7082999f["right"], s_spawn_point);
        arrayremovevalue(self.var_7082999f["left"], s_spawn_point);
        wait(0.05);
    }
    self notify(#"hash_dd4c949f");
}

// Namespace namespace_4c73eafb
// Params 0, eflags: 0x0
// Checksum 0xd1ee92ac, Offset: 0x3d30
// Size: 0x17d
function function_16c18dca() {
    self endon(#"death");
    self endon(#"hash_dd4c949f");
    self.var_ba18db07 = "";
    while (true) {
        self.var_ba18db07 = "";
        var_57da092c = 0;
        var_e738900b = 0;
        foreach (e_volume in self.a_volumes) {
            foreach (e_player in level.activeplayers) {
                if (e_player istouching(e_volume)) {
                    if (e_volume.script_noteworthy == "left_volume") {
                        var_57da092c = 1;
                    } else {
                        var_e738900b = 1;
                    }
                    break;
                }
            }
        }
        if (var_e738900b && var_57da092c) {
            self.var_ba18db07 = "both";
        } else if (var_e738900b) {
            self.var_ba18db07 = "right";
        } else {
            self.var_ba18db07 = "left";
        }
        wait(0.25);
    }
}

// Namespace namespace_4c73eafb
// Params 0, eflags: 0x0
// Checksum 0xfb16907d, Offset: 0x3eb8
// Size: 0xfa
function function_54efd092() {
    exploder::exploder("charging_station_001");
    wait(0.5);
    exploder::exploder("charging_station_002");
    wait(0.5);
    exploder::exploder("charging_station_005");
    wait(0.5);
    exploder::exploder("charging_station_006");
    wait(0.5);
    exploder::exploder("charging_station_003");
    wait(0.5);
    exploder::exploder("charging_station_007");
    wait(0.5);
    exploder::exploder("charging_station_004");
    wait(0.5);
    exploder::exploder("charging_station_008");
}

// Namespace namespace_4c73eafb
// Params 1, eflags: 0x0
// Checksum 0xb45fbed3, Offset: 0x3fc0
// Size: 0x13a
function function_e95882dc(var_c910f140) {
    if (!isdefined(var_c910f140)) {
        var_c910f140 = 1;
    }
    var_dc854c29 = getent("charging_station_spawner", "targetname");
    if (isdefined(var_c910f140) && var_c910f140) {
        self.var_f6c5842 = var_dc854c29 spawner::spawn(1);
        self.var_f6c5842.targetname = "charging_station_ai";
        self.var_f6c5842 forceteleport(self.origin, self.angles);
        self.var_f6c5842.script_objective = "descent";
        self thread function_ccf8a1e1();
        return;
    }
    self.var_1479fabb = util::spawn_model("c_cia_robot_grunt_1", self.origin, self.angles);
    self.var_1479fabb.targetname = "charging_station_mdl";
    self.var_1479fabb.script_objective = "descent";
    self thread function_ef879c87();
}

// Namespace namespace_4c73eafb
// Params 0, eflags: 0x0
// Checksum 0xbdae52d7, Offset: 0x4108
// Size: 0x1e2
function function_471a9c28() {
    self.angles = self.angles * -1;
    self.origin = self.origin + (0, 0, -5.5);
    self.var_95fa96af = self.origin[2] > -5025;
    if (self.script_noteworthy === "fail") {
        self function_e95882dc(0);
        return;
    }
    if (self.script_noteworthy === "real") {
        self function_e95882dc();
        if (!(isdefined(self.var_95fa96af) && self.var_95fa96af)) {
            var_bfd88f7f = struct::get(self.target);
            self.var_1a2b55a5 = util::spawn_model("p7_fxanim_cp_sgen_charging_station_doors_mod", var_bfd88f7f.origin, var_bfd88f7f.angles);
            self.var_1a2b55a5.script_objective = "flood_combat";
            self.var_1a2b55a5.targetname = "pod_track_model";
        }
        self.var_f6c5842 thread scene::play("cin_sgen_16_01_charging_station_aie_idle_robot01", self.var_f6c5842);
        self.var_f6c5842 thread namespace_cba4cc55::function_359855();
        return;
    }
    if (self.script_noteworthy === "static") {
        self.var_256c1ec4 = util::spawn_model("tag_origin", self.origin, self.angles);
        self.var_256c1ec4.script_objective = "charging_station";
        self.var_256c1ec4.targetname = "charging_station_mdl";
    }
}

// Namespace namespace_4c73eafb
// Params 0, eflags: 0x0
// Checksum 0xf4cb343f, Offset: 0x42f8
// Size: 0x14a
function function_ef879c87() {
    n_x_offset = self.origin[0] + randomintrange(64, -56);
    self.var_1479fabb useanimtree(#generic);
    self.var_1479fabb animscripted("idle_robot01", self.origin, self.angles + (0, 180, 0), "ch_sgen_16_01_charging_station_aie_idle_robot01");
    var_602f3c61 = 0;
    while (!var_602f3c61) {
        foreach (player in level.activeplayers) {
            if (player.origin[0] < n_x_offset) {
                var_602f3c61 = 1;
                break;
            }
        }
        wait(0.2);
    }
    self.var_1479fabb animscripted("fail_robot01", self.origin, self.angles + (0, 180, 0), "ch_sgen_16_01_charging_station_aie_fail_robot01");
}

// Namespace namespace_4c73eafb
// Params 0, eflags: 0x0
// Checksum 0x1b0aeec, Offset: 0x4450
// Size: 0x232
function function_ccf8a1e1() {
    level endon(#"hash_38764c78");
    str_event = self util::waittill_any_return("awaken", "post_pallas");
    self.activated = 1;
    self.var_f6c5842.activated = 1;
    if (str_event === "awaken") {
        /#
            if (isdefined(level.var_65e3a64d)) {
                iprintln("hend_gimme_boost_we_need_0" + level.var_65e3a64d);
            }
        #/
        level.var_b0d148eb--;
        if (isdefined(self.var_1a2b55a5)) {
            self.var_1a2b55a5 setmodel("p7_fxanim_cp_sgen_charging_station_doors_break_mod");
        }
        var_e2f27339 = "cin_sgen_16_01_charging_station_aie_awaken_robot0";
        if (isdefined(level.var_65e3a64d) && level.var_65e3a64d < 3) {
            var_e2f27339 += self.angles[1] == -90 ? 3 : 6;
        } else {
            var_e2f27339 += self.angles[1] == -90 ? randomintrange(1, 4) : randomintrange(4, 7);
        }
        if (isdefined(self.var_1a2b55a5)) {
            var_e0dc8ecf = math::cointoss() ? "p7_fxanim_cp_sgen_charging_station_break_02_bundle" : "p7_fxanim_cp_sgen_charging_station_break_03_bundle";
            var_e0dc8ecf = isdefined(self.var_95fa96af) && self.var_95fa96af ? "p7_fxanim_cp_sgen_charging_station_break_01_bundle" : var_e0dc8ecf;
            self thread function_b9349771(var_e0dc8ecf);
        }
        var_e2f27339 = isdefined(self.var_95fa96af) && self.var_95fa96af ? "cin_sgen_16_01_charging_station_aie_awaken_robot05_jumpdown" : var_e2f27339;
        self.var_f6c5842 thread scene::play(var_e2f27339, self.var_f6c5842);
        self.var_f6c5842 thread namespace_cba4cc55::function_c22db411(2);
        wait(3);
        level flag::set("pod_robot_spawned");
    }
}

// Namespace namespace_4c73eafb
// Params 1, eflags: 0x0
// Checksum 0xa0e2a7f, Offset: 0x4690
// Size: 0x4a
function function_b9349771(var_e0dc8ecf) {
    self.var_f6c5842 endon(#"death");
    self.var_f6c5842 waittill(#"breakglass");
    self.var_1a2b55a5 thread scene::play(var_e0dc8ecf, self.var_1a2b55a5);
}

// Namespace namespace_4c73eafb
// Params 0, eflags: 0x0
// Checksum 0x728cd751, Offset: 0x46e8
// Size: 0x172
function function_6027d85b() {
    thread function_a022fef1();
    level dialog::function_13b3b16a("plyr_kane_optics_back_on_0", 1);
    level dialog::remote("kane_copy_that_i_m_pic_0", 0.7);
    trigger::wait_till("enter_charging_station", undefined, undefined, 0);
    level dialog::function_13b3b16a("plyr_robot_charging_stora_0");
    level dialog::remote("kane_easy_take_your_ti_0");
    level dialog::remote("hend_kane_i_got_separate_0");
    level flag::wait_till("pod_robot_spawned");
    level dialog::remote("kane_get_outta_there_i_g_0", 2);
    wait(5);
    level flag::wait_till_timeout(15, "weapons_research_vo_start");
    level thread namespace_d40478f6::function_89871797();
    level dialog::function_13b3b16a("plyr_you_know_this_is_sta_0");
    level dialog::remote("kane_the_chemicals_releas_0", 1);
    level dialog::remote("hend_anyone_else_sense_a_0", 0.5);
    level flag::set("weapons_research_vo_done");
}

// Namespace namespace_4c73eafb
// Params 0, eflags: 0x0
// Checksum 0x487a64c6, Offset: 0x4868
// Size: 0x22
function function_a022fef1() {
    wait(0.5);
    playsoundatposition("gdt_oed_on", (0, 0, 0));
}

