#using scripts/codescripts/struct;
#using scripts/cp/_debug;
#using scripts/cp/_dialog;
#using scripts/cp/_hacking;
#using scripts/cp/_load;
#using scripts/cp/_objectives;
#using scripts/cp/_skipto;
#using scripts/cp/_spawn_manager;
#using scripts/cp/_util;
#using scripts/cp/cp_mi_zurich_newworld;
#using scripts/cp/cp_mi_zurich_newworld_accolades;
#using scripts/cp/cp_mi_zurich_newworld_sound;
#using scripts/cp/cp_mi_zurich_newworld_util;
#using scripts/cp/cybercom/_cybercom_gadget;
#using scripts/cp/cybercom/_cybercom_util;
#using scripts/cp/gametypes/_battlechatter;
#using scripts/shared/ai_shared;
#using scripts/shared/array_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/fx_shared;
#using scripts/shared/gameobjects_shared;
#using scripts/shared/laststand_shared;
#using scripts/shared/lui_shared;
#using scripts/shared/math_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/trigger_shared;
#using scripts/shared/util_shared;
#using scripts/shared/weapons_shared;

#namespace namespace_c7062b04;

// Namespace namespace_c7062b04
// Params 2, eflags: 0x0
// Checksum 0x7b2f4748, Offset: 0x2228
// Size: 0x92
function function_7ce22dd3(str_objective, var_74cd64bc) {
    load::function_73adcefc();
    battlechatter::function_d9f49fba(0);
    function_cbf76d8c();
    function_de13d6e2();
    level thread function_6fe6a34d();
    level thread namespace_e38c3c58::function_5a7ad30();
    white_infinite_igc();
    skipto::function_be8adfb8(str_objective);
}

// Namespace namespace_c7062b04
// Params 0, eflags: 0x0
// Checksum 0x4f5a0d38, Offset: 0x22c8
// Size: 0x232
function white_infinite_igc() {
    level scene::init("cin_new_01_01_whiteinfinite_1st_intro");
    level scene::init("p7_fxanim_cp_newworld_train_intro_glass_bundle");
    level thread function_19b91013();
    load::function_a2995f22(1);
    level thread newworld_util::function_30ec5bf7();
    level util::function_46d3a558(%CP_MI_ZURICH_NEWWORLD_INTRO_LINE_1_FULL, "", %CP_MI_ZURICH_NEWWORLD_INTRO_LINE_3_FULL, %CP_MI_ZURICH_NEWWORLD_INTRO_LINE_3_SHORT, %CP_MI_ZURICH_NEWWORLD_INTRO_LINE_4_FULL, %CP_MI_ZURICH_NEWWORLD_INTRO_LINE_4_SHORT, %CP_MI_ZURICH_NEWWORLD_INTRO_LINE_5_FULL, %CP_MI_ZURICH_NEWWORLD_INTRO_LINE_5_SHORT, "", "");
    if (isdefined(level.var_f7d455df)) {
        level thread [[ level.var_f7d455df ]]();
    }
    level scene::add_scene_func("p7_fxanim_cp_newworld_train_intro_glass_bundle", &function_f910c34a);
    level scene::add_scene_func("cin_new_01_01_whiteinfinite_1st_intro", &function_7b872728);
    level scene::add_scene_func("cin_new_01_01_whiteinfinite_1st_intro", &function_f8514554);
    level scene::function_9e5b8cdb("p7_fxanim_cp_newworld_train_intro_glass_bundle");
    level thread scene::play("p7_fxanim_cp_newworld_train_intro_glass_bundle");
    level thread scene::play("cin_new_01_01_whiteinfinite_1st_intro");
    array::thread_all(level.activeplayers, &newworld_util::function_737d2864, %CP_MI_ZURICH_NEWWORLD_LOCATION_TRAIN, %CP_MI_ZURICH_NEWWORLD_TIME_TRAIN1);
    level waittill(#"hash_a4a076ed");
    setpauseworld(0);
    level flag::set("train_terrain_resume");
    exploder::exploder_stop("ex_white_inf_light");
    level notify(#"hash_6f4b6b65");
    level util::clear_streamer_hint();
}

// Namespace namespace_c7062b04
// Params 1, eflags: 0x0
// Checksum 0x4d685c52, Offset: 0x2508
// Size: 0x6b
function function_f8514554(a_ents) {
    level waittill(#"hash_3c94a047");
    level flag::set("infinite_white_transition");
    wait 0.6;
    scene::stop("cin_new_01_01_whiteinfinite_1st_intro");
    a_ents["taylor"] delete();
    level notify(#"hash_a4a076ed");
}

// Namespace namespace_c7062b04
// Params 1, eflags: 0x0
// Checksum 0x8024b072, Offset: 0x2580
// Size: 0x6a
function function_f910c34a(a_ents) {
    a_ents["newworld_train_intro_glass"] ghost();
    a_ents["newworld_train_intro_glass"] setignorepauseworld(1);
    level waittill(#"hash_e66d6ef4");
    a_ents["newworld_train_intro_glass"] show();
}

// Namespace namespace_c7062b04
// Params 1, eflags: 0x0
// Checksum 0xd120354d, Offset: 0x25f8
// Size: 0x19a
function function_7b872728(a_ents) {
    a_ents["taylor"] setignorepauseworld(1);
    a_ents["whiteinfinite_civ_02"] setignorepauseworld(1);
    a_ents["whiteinfinite_civ_03"] setignorepauseworld(1);
    a_ents["whiteinfinite_civ_04"] setignorepauseworld(1);
    a_ents["whiteinfinite_civ_05"] setignorepauseworld(1);
    a_ents["whiteinfinite_civ_06"] setignorepauseworld(1);
    a_ents["whiteinfinite_civ_07"] setignorepauseworld(1);
    a_ents["player 1"] thread function_3edfb24f();
    level thread function_b7ef38e9();
    a_ents["train_car"] thread function_63d2d91e();
    level thread function_bb60f445(a_ents);
    a_ents["player 1"] waittill(#"freeze");
    if (!scene::function_b1f75ee9()) {
        setpauseworld(1);
        level flag::set("train_terrain_pause");
        level thread function_7d334045();
    }
}

// Namespace namespace_c7062b04
// Params 0, eflags: 0x0
// Checksum 0xef923ad0, Offset: 0x27a0
// Size: 0xda
function function_63d2d91e() {
    self clientfield::set("train_fx_occlude", 1);
    var_bf143437 = getentarray("probe_inf_white_igc", "script_noteworthy");
    foreach (var_7aa19f58 in var_bf143437) {
        var_7aa19f58 linkto(self);
    }
    self waittill(#"hash_999f40e4");
    self hidepart("tag_glass");
    self clientfield::set("train_fx_occlude", 0);
}

// Namespace namespace_c7062b04
// Params 1, eflags: 0x0
// Checksum 0x43f8573a, Offset: 0x2888
// Size: 0x6a
function function_bb60f445(a_ents) {
    level waittill(#"hash_3886176e");
    var_6d4af883 = a_ents["whiteinfinite_civ_07"];
    if (isdefined(var_6d4af883)) {
        var_6d4af883 clientfield::set("derez_ai_deaths", 1);
    }
    util::wait_network_frame();
    if (isdefined(var_6d4af883)) {
        var_6d4af883 ghost();
    }
}

// Namespace namespace_c7062b04
// Params 0, eflags: 0x0
// Checksum 0xc907a5e2, Offset: 0x2900
// Size: 0x1a
function function_3edfb24f() {
    level waittill(#"hash_9a0a9e67");
    function_c4addffd();
}

// Namespace namespace_c7062b04
// Params 0, eflags: 0x0
// Checksum 0x1845b31a, Offset: 0x2928
// Size: 0x22
function function_b7ef38e9() {
    level waittill(#"hash_b8f30df1");
    exploder::exploder("ex_white_inf_light");
}

// Namespace namespace_c7062b04
// Params 4, eflags: 0x0
// Checksum 0xd0e2b94b, Offset: 0x2958
// Size: 0x6a
function function_ccad2ef9(str_objective, var_74cd64bc, var_e4cd2b8b, player) {
    function_de13d6e2(1);
    wait 3;
    newworld_util::scene_cleanup("cin_new_01_01_whiteinfinite_1st_intro");
    newworld_util::scene_cleanup("p7_fxanim_cp_newworld_train_intro_glass_bundle");
}

// Namespace namespace_c7062b04
// Params 2, eflags: 0x0
// Checksum 0xf797aca0, Offset: 0x29d0
// Size: 0x1da
function function_ab92d4b4(str_objective, var_74cd64bc) {
    if (var_74cd64bc) {
        load::function_73adcefc();
        function_e61ead06(str_objective);
        load::function_a2995f22();
        level thread newworld_util::function_30ec5bf7(1);
    } else {
        foreach (player in level.players) {
            player newworld_util::on_player_loadout();
        }
    }
    level clientfield::set("train_main_fx_occlude", 1);
    battlechatter::function_d9f49fba(0);
    level util::set_lighting_state(1);
    level clientfield::set("set_fog_bank", 1);
    level thread function_cbf76d8c();
    level thread function_57409da3();
    level thread function_86f446dd();
    level thread function_75fc9f6a();
    function_e9ea11fb();
    function_14fcc74b();
    level thread function_704b33db();
    skipto::teleport(str_objective);
    level thread namespace_e38c3c58::function_57a2519c();
    function_98cac62e();
    util::function_93831e79("inbound_igc_teleport");
    skipto::function_be8adfb8(str_objective);
}

// Namespace namespace_c7062b04
// Params 0, eflags: 0x0
// Checksum 0x4fd840e0, Offset: 0x2bb8
// Size: 0x10a
function function_98cac62e() {
    level scene::init("cin_new_14_01_inbound_1st_preptalk");
    util::function_d8eaed3d(8);
    newworld_util::function_83a7d040();
    util::streamer_wait();
    newworld_util::player_snow_fx();
    scene::add_scene_func("cin_new_14_01_inbound_1st_preptalk", &function_7ec04a94, "play");
    scene::add_scene_func("cin_new_14_01_inbound_1st_preptalk", &function_985304c3, "play");
    if (isdefined(level.var_911783b)) {
        level thread [[ level.var_911783b ]]();
    }
    level thread function_64f742f7();
    scene::play("cin_new_14_01_inbound_1st_preptalk");
    util::clear_streamer_hint();
}

// Namespace namespace_c7062b04
// Params 1, eflags: 0x0
// Checksum 0x3424c6e5, Offset: 0x2cd0
// Size: 0x5a
function function_985304c3(a_ents) {
    level flag::clear("infinite_white_transition");
    array::thread_all(level.activeplayers, &newworld_util::function_737d2864, %CP_MI_ZURICH_NEWWORLD_LOCATION_TRAIN, %CP_MI_ZURICH_NEWWORLD_TIME_TRAIN2);
}

// Namespace namespace_c7062b04
// Params 1, eflags: 0x0
// Checksum 0x11854d49, Offset: 0x2d38
// Size: 0x72
function function_7ec04a94(a_ents) {
    var_1c26230b = a_ents["taylor"];
    var_1c26230b ghost();
    level waittill(#"hash_7d592b62");
    var_1c26230b thread newworld_util::function_c949a8ed(1);
    level waittill(#"hash_c07e4907");
    var_1c26230b thread newworld_util::function_4943984c(1);
}

// Namespace namespace_c7062b04
// Params 0, eflags: 0x0
// Checksum 0x24ea9ef4, Offset: 0x2db8
// Size: 0x62
function function_64f742f7() {
    level clientfield::set("inbound_igc_glass", 1);
    level waittill(#"hash_64f742f7");
    level clientfield::set("inbound_igc_glass", 2);
    level util::set_lighting_state(0);
    level clientfield::set("set_fog_bank", 0);
}

// Namespace namespace_c7062b04
// Params 0, eflags: 0x0
// Checksum 0xe94de5af, Offset: 0x2e28
// Size: 0x1a
function function_6ce77882() {
    level clientfield::set("inbound_igc_glass", 2);
}

// Namespace namespace_c7062b04
// Params 4, eflags: 0x0
// Checksum 0x9f8c99fb, Offset: 0x2e50
// Size: 0x22
function function_5e42668a(str_objective, var_74cd64bc, var_e4cd2b8b, player) {
    
}

// Namespace namespace_c7062b04
// Params 2, eflags: 0x0
// Checksum 0x1f264356, Offset: 0x2e80
// Size: 0x28a
function function_158a9a65(str_objective, var_74cd64bc) {
    if (var_74cd64bc) {
        load::function_73adcefc();
        function_e9ea11fb();
        function_14fcc74b();
        function_6ce77882();
        function_cbf76d8c();
        function_e61ead06(str_objective);
        function_704b33db();
        level thread function_75fc9f6a();
        level thread function_57409da3();
        load::function_a2995f22();
        level clientfield::set("train_main_fx_occlude", 1);
    }
    if (sessionmodeiscampaignzombiesgame()) {
        a_e_clip = getentarray("train_stairs_carver_zm", "targetname");
        foreach (e_clip in a_e_clip) {
            e_clip delete();
        }
    }
    util::delay(0.6, undefined, &newworld_util::function_3e37f48b, 0);
    level thread namespace_e38c3c58::function_c132cd41();
    level thread function_86f446dd();
    battlechatter::function_d9f49fba(1);
    level util::set_lighting_state(0);
    level clientfield::set("set_fog_bank", 0);
    function_c63fb1d();
    level thread function_8c0c3c47();
    level thread namespace_e38c3c58::function_a99be221();
    level thread namespace_37a1dc33::function_8bb97e0();
    level thread function_8b44d21a();
    function_b9045c8a();
    function_9301e221();
    function_6cff67b8();
    function_7710c097();
    function_510e462e();
}

// Namespace namespace_c7062b04
// Params 4, eflags: 0x0
// Checksum 0x3007957f, Offset: 0x3118
// Size: 0x22
function function_d5af013f(str_objective, var_74cd64bc, var_e4cd2b8b, player) {
    
}

// Namespace namespace_c7062b04
// Params 0, eflags: 0x0
// Checksum 0x63ca160a, Offset: 0x3148
// Size: 0x1b2
function function_cbf76d8c() {
    if (!level flag::exists("train_terrain_pause")) {
        level flag::init("train_terrain_pause");
    }
    if (!level flag::exists("train_terrain_resume")) {
        level flag::init("train_terrain_resume");
    }
    if (!level flag::exists("train_terrain_transition")) {
        level flag::init("train_terrain_transition");
    }
    if (!level flag::exists("train_terrain_move_complete")) {
        level flag::init("train_terrain_move_complete");
    }
    if (!level flag::exists("switch_to_forest")) {
        level flag::init("switch_to_forest");
    }
    if (!level flag::exists("player_on_top_of_train")) {
        level flag::init("player_on_top_of_train");
    }
    if (!level flag::exists("concussive_wave_tutorial_started")) {
        level flag::init("concussive_wave_tutorial_started");
    }
    if (!level flag::exists("climb_up_spawns_complete")) {
        level flag::init("climb_up_spawns_complete");
    }
    if (!level flag::exists("climb_up_robots_cleared")) {
        level flag::init("climb_up_robots_cleared");
    }
}

// Namespace namespace_c7062b04
// Params 0, eflags: 0x0
// Checksum 0x68ec9020, Offset: 0x3308
// Size: 0xa9
function function_8b44d21a() {
    var_31f0b803 = getentarray("train_neon_glass_destructible_1", "script_noteworthy");
    var_6a5caae4 = struct::get("front_of_the_train", "targetname");
    var_31f0b803 = arraysort(var_31f0b803, var_6a5caae4.origin, 1);
    for (i = 0; i < var_31f0b803.size; i++) {
        var_31f0b803[i] thread function_f889869b(i + 1);
    }
}

// Namespace namespace_c7062b04
// Params 1, eflags: 0x0
// Checksum 0x6a255730, Offset: 0x33c0
// Size: 0x32
function function_f889869b(n_index) {
    self waittill(#"broken");
    exploder::exploder("ex_purple_glass_light_0" + n_index);
}

// Namespace namespace_c7062b04
// Params 0, eflags: 0x0
// Checksum 0x559e94f7, Offset: 0x3400
// Size: 0x12
function function_b9045c8a() {
    level thread function_3641dc88();
}

// Namespace namespace_c7062b04
// Params 0, eflags: 0x0
// Checksum 0xa64eafd1, Offset: 0x3420
// Size: 0x62
function function_9301e221() {
    level thread function_7f06890d();
    trigger::wait_till("train_car_2_robot_spawn");
    s_scene = struct::get("train_car_2_robot_charger", "targetname");
    s_scene thread scene::play();
}

// Namespace namespace_c7062b04
// Params 0, eflags: 0x0
// Checksum 0x2ba8f221, Offset: 0x3490
// Size: 0x5a
function function_6cff67b8() {
    level clientfield::set("train_robot_swing_glass_left", 1);
    level clientfield::set("train_robot_swing_glass_right", 1);
    trigger::wait_till("robots_swing_in");
    level thread function_6114e822();
}

// Namespace namespace_c7062b04
// Params 0, eflags: 0x0
// Checksum 0xd023b1b5, Offset: 0x34f8
// Size: 0x12a
function function_7710c097() {
    level clientfield::set("train_dropdown_glass", 1);
    level thread scene::init("cin_new_16_01_detachbombcar_aie_drop");
    trigger::wait_till("train_car_4_robot_spawns");
    level thread function_6a30b44c();
    trigger::wait_till("train_car_4_robots_drop_through_glass");
    if (level.activeplayers.size > 1) {
        var_f6c5842 = spawner::simple_spawn_single("train_car_4_secondstory");
        var_f6c5842 thread function_c19bd331();
    }
    scene::add_scene_func("cin_new_16_01_detachbombcar_aie_drop", &function_613f8b51, "play");
    level thread scene::play("cin_new_16_01_detachbombcar_aie_drop");
    level waittill(#"hash_60e2e11");
    level clientfield::set("train_dropdown_glass", 2);
    level thread function_ce0fcc59();
}

// Namespace namespace_c7062b04
// Params 0, eflags: 0x0
// Checksum 0x50e661e3, Offset: 0x3630
// Size: 0x62
function function_c19bd331() {
    self endon(#"death");
    self util::waittill_any("goal", "near_goal");
    self ai::set_behavior_attribute("move_mode", "rusher");
    self ai::set_behavior_attribute("sprint", 1);
}

// Namespace namespace_c7062b04
// Params 1, eflags: 0x0
// Checksum 0x129e721e, Offset: 0x36a0
// Size: 0xba
function function_613f8b51(a_ents) {
    a_ents["robot_second_floor_drop"] util::magic_bullet_shield();
    level waittill(#"hash_613f8b51");
    var_31f0b803 = getentarray("train_neon_glass_destructible_1", "script_noteworthy");
    var_31f0b803 = arraysort(var_31f0b803, a_ents["robot_second_floor_drop"].origin, 1);
    if (isdefined(var_31f0b803[0])) {
        var_31f0b803[0] dodamage(100, var_31f0b803[0].origin);
    }
    a_ents["robot_second_floor_drop"] util::stop_magic_bullet_shield();
}

// Namespace namespace_c7062b04
// Params 0, eflags: 0x0
// Checksum 0x81257607, Offset: 0x3768
// Size: 0x12
function function_510e462e() {
    level thread train_lockdown();
}

// Namespace namespace_c7062b04
// Params 0, eflags: 0x0
// Checksum 0x8ae48a5f, Offset: 0x3788
// Size: 0xc3
function function_7f06890d() {
    trigger::wait_till("train_tutorial_takedown");
    level thread function_11711684("cybercom_rapidstrike", 0);
    foreach (player in level.players) {
        if (player newworld_util::function_c633d8fe()) {
            continue;
        }
        player thread newworld_util::function_6062e90("cybercom_rapidstrike", 0, "concsusive_wave_tutorial", 1, "CP_MI_ZURICH_NEWWORLD_TAKEDOWN");
    }
}

// Namespace namespace_c7062b04
// Params 0, eflags: 0x0
// Checksum 0xff6ac196, Offset: 0x3858
// Size: 0xab
function function_6a30b44c() {
    var_7da8df42 = struct::get_array("train_car_4_charging_stations", "targetname");
    foreach (s_scene in var_7da8df42) {
        s_scene thread scene::play();
        wait randomfloatrange(0.25, 0.75);
    }
}

// Namespace namespace_c7062b04
// Params 0, eflags: 0x0
// Checksum 0x5f5f2688, Offset: 0x3910
// Size: 0xd3
function function_ce0fcc59() {
    level thread function_f3519ceb();
    level flag::wait_till("spawn_train_car4_rear_chargingstation_robots");
    var_7da8df42 = struct::get_array("train_car_4_rear_charging_stations", "targetname");
    foreach (s_scene in var_7da8df42) {
        s_scene thread scene::play();
        wait randomfloatrange(0.25, 0.75);
    }
}

// Namespace namespace_c7062b04
// Params 0, eflags: 0x0
// Checksum 0x4b663af0, Offset: 0x39f0
// Size: 0xe2
function function_f3519ceb() {
    level endon(#"spawn_train_car4_rear_chargingstation_robots");
    var_64e85e6d = [];
    a_ai = getaiteamarray("axis");
    foreach (ai in a_ai) {
        if (ai.script_string === "train_car_4_robots_front" && isalive(ai)) {
            var_64e85e6d[var_64e85e6d.size] = ai;
        }
    }
    if (var_64e85e6d.size > 0) {
        ai::waittill_dead(var_64e85e6d);
        level flag::set("spawn_train_car4_rear_chargingstation_robots");
    }
}

// Namespace namespace_c7062b04
// Params 0, eflags: 0x0
// Checksum 0xac68a7e7, Offset: 0x3ae0
// Size: 0xf2
function function_14fcc74b() {
    scene::add_scene_func("p7_fxanim_cp_newworld_charging_station_open_01_bundle", &function_1d0cebf2, "init");
    scene::add_scene_func("p7_fxanim_cp_newworld_charging_station_open_01_bundle", &function_5f93d88c, "done");
    scene::add_scene_func("cin_new_scr_temp_robot_fwd", &function_45eba545, "init");
    scene::add_scene_func("cin_new_scr_temp_robot_fwd", &function_c64ec951, "play");
    scene::add_scene_func("cin_new_scr_temp_robot_fwd", &function_cbeb52db, "done");
}

// Namespace namespace_c7062b04
// Params 1, eflags: 0x0
// Checksum 0x7682c3bc, Offset: 0x3be0
// Size: 0xba
function function_1d0cebf2(a_ents) {
    if (isdefined(self.target)) {
        if (self.script_noteworthy === "last_car_robot_chargers") {
            s_scene = struct::get(self.target, "targetname");
            var_f6c5842 = spawner::simple_spawn_single("last_train_car_robot");
            s_scene scene::init(var_f6c5842);
            return;
        }
        s_scene = struct::get(self.target, "targetname");
        s_scene scene::init();
    }
}

// Namespace namespace_c7062b04
// Params 1, eflags: 0x0
// Checksum 0x4f8e40fb, Offset: 0x3ca8
// Size: 0x4a
function function_5f93d88c(a_ents) {
    if (isdefined(self.target)) {
        s_scene = struct::get(self.target, "targetname");
        s_scene scene::play();
    }
}

// Namespace namespace_c7062b04
// Params 1, eflags: 0x0
// Checksum 0xae26a012, Offset: 0x3d00
// Size: 0x22
function function_45eba545(a_ents) {
    a_ents["train_wakeup_robot"] util::magic_bullet_shield();
}

// Namespace namespace_c7062b04
// Params 1, eflags: 0x0
// Checksum 0xa0a09c41, Offset: 0x3d30
// Size: 0xb2
function function_c64ec951(a_ents) {
    a_ents["train_wakeup_robot"] util::stop_magic_bullet_shield();
    if (self.script_noteworthy === "rusher") {
        a_ents["train_wakeup_robot"] ai::set_behavior_attribute("move_mode", "rusher");
        a_ents["train_wakeup_robot"] ai::set_behavior_attribute("sprint", 1);
    }
    if (isdefined(self.script_string)) {
        a_ents["train_wakeup_robot"].script_string = self.script_string;
    }
}

// Namespace namespace_c7062b04
// Params 1, eflags: 0x0
// Checksum 0x9b3cc08c, Offset: 0x3df0
// Size: 0xaa
function function_cbeb52db(a_ents) {
    if (isdefined(self.target)) {
        var_c9ae457a = getent(self.target, "targetname");
        if (!isdefined(var_c9ae457a)) {
            nd_target = getnode(self.target, "targetname");
            a_ents["train_wakeup_robot"] setgoal(nd_target, 1);
            return;
        }
        a_ents["train_wakeup_robot"] setgoal(var_c9ae457a, 1);
    }
}

// Namespace namespace_c7062b04
// Params 0, eflags: 0x0
// Checksum 0x1096f184, Offset: 0x3ea8
// Size: 0x8b
function function_704b33db() {
    a_s_scenes = struct::get_array("main_train_robot_chargers", "script_noteworthy");
    foreach (s_scene in a_s_scenes) {
        s_scene scene::init();
    }
}

// Namespace namespace_c7062b04
// Params 0, eflags: 0x0
// Checksum 0x98ea9fa1, Offset: 0x3f40
// Size: 0x1e2
function function_5e667e1f() {
    scene::add_scene_func("cin_gen_traversal_robot_climb_train_right", &function_b30301a7, "done");
    scene::add_scene_func("cin_gen_traversal_robot_climb_train_left", &function_b30301a7, "done");
    switch (level.activeplayers.size) {
    case 1:
    case 2:
        n_count = 2;
        break;
    case 3:
        n_count = 3;
        break;
    case 4:
        n_count = 4;
        break;
    default:
        n_count = 0;
        break;
    }
    for (i = 1; i < n_count + 1; i++) {
        var_f6c5842 = spawner::simple_spawn_single("climb_up_robot");
        s_scene = struct::get("train_roof1_climb_up_0" + i, "targetname");
        s_scene thread scene::init(var_f6c5842);
    }
    level flag::wait_till("train_rooftop_roof1_climb_up_spawns");
    level thread function_f7302a65();
    for (i = 1; i < n_count + 1; i++) {
        s_scene = struct::get("train_roof1_climb_up_0" + i, "targetname");
        s_scene thread scene::play();
        wait 0.1;
    }
    level flag::set("climb_up_spawns_complete");
}

// Namespace namespace_c7062b04
// Params 1, eflags: 0x0
// Checksum 0xd1cffbee, Offset: 0x4130
// Size: 0xaa
function function_b30301a7(a_ents) {
    wait 0.05;
    if (isalive(a_ents[0]) && a_ents[0].script_noteworthy === "train_robot_rushers") {
        a_ents[0] ai::set_behavior_attribute("move_mode", "rusher");
        a_ents[0] ai::set_behavior_attribute("sprint", 1);
        if (self.script_noteworthy === "train_rooftop_depth") {
            a_ents[0] thread function_ca6ecfb3();
        }
    }
}

// Namespace namespace_c7062b04
// Params 0, eflags: 0x0
// Checksum 0x1b6072dc, Offset: 0x41e8
// Size: 0x1ab
function function_382c53b4() {
    trigger::wait_till("train_concussive_wave_tutorial");
    spawn_manager::enable("concussive_wave_tutorial_sm");
    level flag::set("concussive_wave_tutorial_started");
    level notify(#"concsusive_wave_tutorial");
    level.var_fbc6080 = 1;
    newworld_util::function_3e37f48b(1);
    if (!sessionmodeiscampaignzombiesgame()) {
        foreach (player in level.players) {
            if (player newworld_util::function_c633d8fe()) {
                continue;
            }
            player flag::init("concussive_wave_show_use_ability_tutorial");
            player flag::init("concussive_wave_tutorial_vo_complete");
            player thread function_9f8dbaa2("cybercom_concussive", 1);
            player namespace_d00ec32::function_a724d44("cybercom_concussive", 1);
            player.cybercom.var_161c9be8 = 0;
            player thread newworld_util::function_948d4091("cybercom_concussive", 1, "begin_skipto_detach_bomb_igc_init", 1, "CP_MI_ZURICH_NEWWORLD_CONCUSSIVE_WAVE_TUTORIAL", "concussive_wave_show_use_ability_tutorial", "concussive_wave_tutorial_vo_complete");
            player thread function_54bd9482();
        }
    }
}

// Namespace namespace_c7062b04
// Params 0, eflags: 0x0
// Checksum 0x960514f3, Offset: 0x43a0
// Size: 0x42
function function_54bd9482() {
    self endon(#"death");
    trigger::wait_till("concussive_wave_use_ability_tutorial", "targetname", self);
    self flag::set("concussive_wave_show_use_ability_tutorial");
}

// Namespace namespace_c7062b04
// Params 1, eflags: 0x0
// Checksum 0xfc2e7e34, Offset: 0x43f0
// Size: 0x633
function function_e61ead06(str_objective) {
    scene::add_scene_func("cin_new_15_01_train_vign_drinks", &function_fc32f54, "play");
    scene::add_scene_func("cin_new_15_01_train_vign_drinks", &function_ffaa48a3, "play");
    scene::add_scene_func("cin_new_15_01_train_vign_passengercar_male01", &function_fc32f54, "play");
    scene::add_scene_func("cin_new_15_01_train_vign_passengercar_male01", &function_ffaa48a3, "play");
    scene::add_scene_func("cin_new_15_01_train_vign_passengercar_male01_table", &function_fc32f54, "play");
    scene::add_scene_func("cin_new_15_01_train_vign_passengercar_male01_table", &function_ffaa48a3, "play");
    scene::add_scene_func("cin_new_15_01_train_vign_passengercar_male02", &function_fc32f54, "play");
    scene::add_scene_func("cin_new_15_01_train_vign_passengercar_male02", &function_ffaa48a3, "play");
    scene::add_scene_func("cin_new_15_01_train_vign_passengercar_female01", &function_fc32f54, "play");
    scene::add_scene_func("cin_new_15_01_train_vign_passengercar_female01", &function_ffaa48a3, "play");
    scene::add_scene_func("cin_new_15_01_train_vign_passengercar_female01_table", &function_fc32f54, "play");
    scene::add_scene_func("cin_new_15_01_train_vign_passengercar_female01_table", &function_ffaa48a3, "play");
    scene::add_scene_func("cin_new_15_01_train_vign_passengercar_female02", &function_fc32f54, "play");
    scene::add_scene_func("cin_new_15_01_train_vign_passengercar_female02", &function_ffaa48a3, "play");
    scene::add_scene_func("cin_new_15_01_train_vign_passengercar_female02_table", &function_fc32f54, "play");
    scene::add_scene_func("cin_new_15_01_train_vign_passengercar_female02_table", &function_ffaa48a3, "play");
    if (str_objective === "train_inbound_igc" || str_objective === "train_train_start" || str_objective === "underground_staging_room_igc") {
        a_s_scenes = struct::get_array("train_civilians_car_1", "script_noteworthy");
        foreach (s_scene in a_s_scenes) {
            s_scene thread scene::play();
            wait randomfloatrange(0, 0.25);
        }
        a_s_scenes = struct::get_array("train_civilians_car_2", "script_noteworthy");
        foreach (s_scene in a_s_scenes) {
            s_scene thread scene::play();
            wait randomfloatrange(0, 0.25);
        }
        a_s_scenes = struct::get_array("train_civilians_car_3", "script_noteworthy");
        foreach (s_scene in a_s_scenes) {
            s_scene thread scene::play();
            wait randomfloatrange(0, 0.25);
        }
        a_s_scenes = struct::get_array("train_civilians_car_4", "script_noteworthy");
        foreach (s_scene in a_s_scenes) {
            s_scene thread scene::play();
            wait randomfloatrange(0, 0.25);
        }
    }
    a_s_scenes = struct::get_array("train_civilians_car_5", "script_noteworthy");
    foreach (s_scene in a_s_scenes) {
        s_scene thread scene::play();
        wait randomfloatrange(0, 0.25);
    }
}

// Namespace namespace_c7062b04
// Params 1, eflags: 0x0
// Checksum 0x562b0388, Offset: 0x4a30
// Size: 0x1a2
function function_fc32f54(a_ents) {
    level endon(#"hash_a72162f1");
    var_f11c18b5 = a_ents["train_civilian_model"];
    if (!isdefined(var_f11c18b5)) {
        var_f11c18b5 = a_ents["train_civ_bartender_model"];
    }
    var_f11c18b5 endon(#"hash_bf294add");
    var_f11c18b5 setcandamage(1);
    var_f11c18b5.health = 100;
    var_f11c18b5.script_objective = "train_detach_bomb_igc";
    while (true) {
        var_f11c18b5 waittill(#"damage", n_damage, attacker);
        if (n_damage > 1) {
            break;
        }
    }
    if (isplayer(attacker)) {
        attacker thread function_8e9219f();
    }
    if (!isdefined(var_f11c18b5)) {
        return;
    }
    self scene::stop();
    wait 0.05;
    var_f11c18b5 startragdoll();
    if (isdefined(a_ents["prop"])) {
        a_ents["prop"] physicslaunch();
    }
    wait 0.1875;
    var_f11c18b5 notify(#"hash_ddb95805");
    var_f11c18b5 clientfield::set("derez_model_deaths", 1);
    util::wait_network_frame();
    wait 0.1;
    var_f11c18b5 delete();
    if (isdefined(a_ents["prop"])) {
        a_ents["prop"] delete();
    }
}

// Namespace namespace_c7062b04
// Params 1, eflags: 0x0
// Checksum 0xd9a1c2aa, Offset: 0x4be0
// Size: 0x13a
function function_ffaa48a3(a_ents) {
    level endon(#"hash_a72162f1");
    var_f11c18b5 = a_ents["train_civilian_model"];
    if (!isdefined(var_f11c18b5)) {
        var_f11c18b5 = a_ents["train_civ_bartender_model"];
    }
    var_f11c18b5 endon(#"hash_ddb95805");
    while (isdefined(var_f11c18b5) && !var_f11c18b5 function_4a8e782e()) {
        wait 0.1;
    }
    if (!isdefined(var_f11c18b5)) {
        return;
    }
    self scene::stop();
    wait 0.05;
    var_f11c18b5 startragdoll();
    if (isdefined(a_ents["prop"])) {
        a_ents["prop"] physicslaunch();
    }
    wait 0.09375;
    var_f11c18b5 notify(#"hash_bf294add");
    var_f11c18b5 clientfield::set("derez_model_deaths", 1);
    util::wait_network_frame();
    wait 0.1;
    var_f11c18b5 delete();
    if (isdefined(a_ents["prop"])) {
        a_ents["prop"] delete();
    }
}

// Namespace namespace_c7062b04
// Params 0, eflags: 0x0
// Checksum 0xf47cd4a6, Offset: 0x4d28
// Size: 0x10a
function function_4a8e782e() {
    level endon(#"hash_a72162f1");
    self endon(#"hash_ddb95805");
    self endon(#"hash_bf294add");
    foreach (player in level.activeplayers) {
        if (self istouching(player)) {
            return true;
        }
    }
    a_ai = getaiteamarray("axis");
    foreach (ai in a_ai) {
        if (self istouching(ai)) {
            return true;
        }
    }
    return false;
}

// Namespace namespace_c7062b04
// Params 0, eflags: 0x0
// Checksum 0xa18e30f0, Offset: 0x4e40
// Size: 0x192
function function_6114e822() {
    level thread function_783ceb85();
    var_83b961d3 = struct::get("robot_swing_enter_left", "targetname");
    var_d2b65346 = struct::get("robot_swing_enter_right", "targetname");
    scene::add_scene_func("cin_new_15_02_train_aie_robot_swing_enter", &function_e1da9958, "play");
    scene::add_scene_func("cin_new_15_02_train_aie_robot_swing_enter", &function_5e60279a, "done");
    wait 0.5;
    var_83b961d3 thread scene::play();
    if (level.activeplayers.size > 2) {
        wait 0.25;
        var_4ed87bd0 = struct::get("robot_swing_enter_right2", "targetname");
        var_4ed87bd0 thread scene::play();
        wait 0.25;
        var_9c50e7ab = struct::get("robot_swing_enter_left2", "targetname");
        var_9c50e7ab thread scene::play();
    }
    wait 0.5;
    var_d2b65346 thread scene::play();
    level thread function_132d9bfb();
}

// Namespace namespace_c7062b04
// Params 1, eflags: 0x0
// Checksum 0xe2a92fa1, Offset: 0x4fe0
// Size: 0xba
function function_e1da9958(a_ents) {
    if (self.targetname == "robot_swing_enter_left") {
        str_clientfield = "train_robot_swing_glass_left";
    } else if (self.targetname == "robot_swing_enter_right") {
        str_clientfield = "train_robot_swing_glass_right";
    } else if (self.targetname == "robot_swing_enter_right2") {
        str_clientfield = "train_robot_swing_right_extra";
    } else if (self.targetname == "robot_swing_enter_left2") {
        str_clientfield = "train_robot_swing_left_extra";
    }
    a_ents["train_wakeup_robot"] waittill(#"hash_ea465de6");
    level clientfield::set(str_clientfield, 2);
}

// Namespace namespace_c7062b04
// Params 1, eflags: 0x0
// Checksum 0x28550e7b, Offset: 0x50a8
// Size: 0x82
function function_5e60279a(a_ents) {
    wait 0.05;
    if (isdefined(self.target) && isalive(a_ents["train_wakeup_robot"])) {
        var_9de10fe3 = getnode(self.target, "targetname");
        a_ents["train_wakeup_robot"] ai::force_goal(var_9de10fe3, 8);
    }
}

// Namespace namespace_c7062b04
// Params 0, eflags: 0x0
// Checksum 0xc3204704, Offset: 0x5138
// Size: 0xb3
function function_132d9bfb() {
    wait 0.75;
    var_7da8df42 = struct::get_array("train_car_3_charging_stations", "targetname");
    foreach (s_scene in var_7da8df42) {
        s_scene thread scene::play();
        wait randomfloatrange(0.25, 0.75);
    }
}

// Namespace namespace_c7062b04
// Params 0, eflags: 0x0
// Checksum 0x7be4b107, Offset: 0x51f8
// Size: 0x21a
function train_lockdown() {
    level thread function_e7752aae();
    clientfield::set("train_lockdown_glass_left", 1);
    clientfield::set("train_lockdown_glass_right", 1);
    trigger::wait_till("train_lockdown", undefined, undefined, 0);
    exploder::exploder("ex_breakglass");
    clientfield::set("train_lockdown_shutters_1", 1);
    array::run_all(getentarray("train_lockdown_door", "targetname"), &movey, -64, 0.5);
    level thread function_75c56cf();
    level thread train_lockdown_vo();
    wait 1.5;
    scene::add_scene_func("cin_new_15_02_train_aie_smash", &function_b8f52cb2, "play");
    scene::add_scene_func("cin_new_15_02_train_aie_smash", &function_1a199178, "play");
    scene::add_scene_func("cin_new_15_02_train_aie_smash", &function_ce450787, "play");
    scene::add_scene_func("cin_new_15_02_train_aie_smash", &function_84631064, "done");
    level thread scene::play("cin_new_15_02_train_aie_smash");
    level waittill(#"hash_ce450787");
    array::run_all(getentarray("train_lockdown_glass", "targetname"), &delete);
}

// Namespace namespace_c7062b04
// Params 0, eflags: 0x0
// Checksum 0xd7813630, Offset: 0x5420
// Size: 0x62
function function_e7752aae() {
    scene::add_scene_func("cin_new_15_02_train_aie_smash", &function_f1aa562d, "init");
    trigger::wait_till("start_lockdown_robots");
    level thread scene::init("cin_new_15_02_train_aie_smash");
}

// Namespace namespace_c7062b04
// Params 1, eflags: 0x0
// Checksum 0x9985fdaf, Offset: 0x5490
// Size: 0x73
function function_f1aa562d(a_ents) {
    util::wait_network_frame();
    foreach (var_6104a93b in a_ents) {
        var_6104a93b util::magic_bullet_shield();
    }
}

// Namespace namespace_c7062b04
// Params 1, eflags: 0x0
// Checksum 0xe1ebf790, Offset: 0x5510
// Size: 0x5a
function function_b8f52cb2(a_ents) {
    level waittill(#"hash_1a199178");
    a_ents["lockdown_roof_robot_left"] util::stop_magic_bullet_shield();
    level waittill(#"hash_ce450787");
    a_ents["lockdown_roof_robot_right"] util::stop_magic_bullet_shield();
}

// Namespace namespace_c7062b04
// Params 1, eflags: 0x0
// Checksum 0x669ef998, Offset: 0x5578
// Size: 0x2a
function function_1a199178(a_ents) {
    level waittill(#"hash_1c281e62");
    level clientfield::set("train_lockdown_glass_left", 2);
}

// Namespace namespace_c7062b04
// Params 1, eflags: 0x0
// Checksum 0x33a4b4e4, Offset: 0x55b0
// Size: 0x2a
function function_ce450787(a_ents) {
    level waittill(#"hash_632087ff");
    level clientfield::set("train_lockdown_glass_right", 2);
}

// Namespace namespace_c7062b04
// Params 1, eflags: 0x0
// Checksum 0x11ff80f6, Offset: 0x55e8
// Size: 0x22
function function_84631064(a_ents) {
    objectives::breadcrumb("train_rooftop_breadcrumb");
}

// Namespace namespace_c7062b04
// Params 0, eflags: 0x0
// Checksum 0x76d96e13, Offset: 0x5618
// Size: 0x5e2
function function_75c56cf() {
    clientfield::set("train_lockdown_shutters_5", 1);
    e_trigger = getent("train_car_lockdown_04", "targetname");
    e_trigger function_7a33acf8();
    a_s_scene = struct::get_array("train_civilians_car_1", "script_noteworthy");
    foreach (s_scene in a_s_scene) {
        if (s_scene scene::is_playing()) {
            s_scene scene::stop(1);
        }
    }
    level clientfield::set("inbound_igc_glass", 0);
    clientfield::set("train_lockdown_shutters_4", 1);
    e_trigger = getent("train_car_lockdown_03", "targetname");
    e_trigger function_7a33acf8();
    a_s_scene = struct::get_array("train_civilians_car_2", "script_noteworthy");
    foreach (s_scene in a_s_scene) {
        if (s_scene scene::is_playing()) {
            s_scene scene::stop(1);
        }
    }
    var_809fd273 = struct::get("train_car_2_robot_charger", "targetname");
    var_809fd273 scene::stop(1);
    clientfield::set("train_lockdown_shutters_3", 1);
    e_trigger = getent("train_car_lockdown_02", "targetname");
    e_trigger function_7a33acf8();
    a_s_scene = struct::get_array("train_civilians_car_3", "script_noteworthy");
    foreach (s_scene in a_s_scene) {
        if (s_scene scene::is_playing()) {
            s_scene scene::stop(1);
        }
    }
    a_s_scene = struct::get_array("train_car_3_charging_stations", "targetname");
    foreach (s_scene in a_s_scene) {
        if (s_scene scene::is_playing()) {
            s_scene scene::stop(1);
        }
    }
    level clientfield::set("train_robot_swing_glass_left", 0);
    level clientfield::set("train_robot_swing_glass_right", 0);
    clientfield::set("train_lockdown_shutters_2", 1);
    e_trigger = getent("train_car_lockdown_01", "targetname");
    e_trigger function_7a33acf8();
    trigger::use("enable_car_0_respawns");
    a_s_scene = struct::get_array("train_civilians_car_4", "script_noteworthy");
    foreach (s_scene in a_s_scene) {
        if (s_scene scene::is_playing()) {
            s_scene scene::stop(1);
        }
    }
    a_s_scene = struct::get_array("train_car_4_charging_stations", "targetname");
    foreach (s_scene in a_s_scene) {
        if (s_scene scene::is_playing()) {
            s_scene scene::stop(1);
        }
    }
    a_s_scene = struct::get_array("train_car_4_rear_charging_stations", "targetname");
    foreach (s_scene in a_s_scene) {
        if (s_scene scene::is_playing()) {
            s_scene scene::stop(1);
        }
    }
    level clientfield::set("train_dropdown_glass", 0);
}

// Namespace namespace_c7062b04
// Params 0, eflags: 0x0
// Checksum 0xfb4e16f0, Offset: 0x5c08
// Size: 0x1f5
function function_7a33acf8() {
    if (level flag::get("train_car_" + self.script_int + "_locked_down")) {
        return;
    }
    self notify(#"hash_ab87488c");
    self endon(#"hash_ab87488c");
    var_b2131754 = self.script_int + 1;
    if (level flag::exists("train_car_" + var_b2131754 + "_locked_down")) {
        level flag::wait_till("train_car_" + var_b2131754 + "_locked_down");
    }
    while (true) {
        var_e6e72236 = 1;
        foreach (player in level.players) {
            if (player istouching(self)) {
                var_e6e72236 = 0;
                break;
            }
        }
        a_ai = getaiteamarray("axis", "allies");
        foreach (ai in a_ai) {
            if (ai istouching(self)) {
                var_e6e72236 = 0;
                break;
            }
        }
        if (var_e6e72236 == 1) {
            level flag::set("train_car_" + self.script_int + "_locked_down");
            function_14d8c849(self.script_int);
            break;
        }
        wait 0.1;
    }
}

// Namespace namespace_c7062b04
// Params 1, eflags: 0x0
// Checksum 0x1aa2ae59, Offset: 0x5e08
// Size: 0x16a
function function_14d8c849(n_index) {
    trigger::use("disable_car_" + n_index + "_respawns");
    e_door_l = getent("train_lockdown_door_0" + n_index + "_l", "targetname");
    e_door_r = getent("train_lockdown_door_0" + n_index + "_r", "targetname");
    e_door_l movey(-64, 0.2);
    e_door_r movey(64, 0.2);
    e_door_r playsound("evt_train_door_close");
    e_door_l waittill(#"movedone");
    e_door_l disconnectpaths(0, 0);
    e_door_r disconnectpaths(0, 0);
    e_gate = getent("train_umbra_gate_0" + n_index, "targetname");
    e_gate show();
    e_gate solid();
    umbragate_set("train_umbra_gate_0" + n_index, 0);
}

// Namespace namespace_c7062b04
// Params 1, eflags: 0x0
// Checksum 0xdbfae0dc, Offset: 0x5f80
// Size: 0x182
function function_42e02b4(n_index) {
    e_gate = getent("train_umbra_gate_0" + n_index, "targetname");
    e_gate ghost();
    e_gate notsolid();
    e_gate connectpaths();
    umbragate_set("train_umbra_gate_0" + n_index, 1);
    e_door_l = getent("train_lockdown_door_0" + n_index + "_l", "targetname");
    e_door_r = getent("train_lockdown_door_0" + n_index + "_r", "targetname");
    e_door_l movey(64, 0.2);
    e_door_r movey(-64, 0.2);
    e_door_r playsound("evt_train_door_open");
    e_door_l waittill(#"movedone");
    e_door_l connectpaths();
    e_door_r connectpaths();
    trigger::use("enable_car_" + n_index + "_respawns");
}

// Namespace namespace_c7062b04
// Params 0, eflags: 0x0
// Checksum 0x6859f9f1, Offset: 0x6110
// Size: 0x22a
function function_57409da3() {
    level flag::init("train_car_4_locked_down");
    level flag::init("train_car_3_locked_down");
    level flag::init("train_car_2_locked_down");
    level flag::init("train_car_1_locked_down");
    e_gate = getent("train_umbra_gate_04", "targetname");
    e_gate ghost();
    e_gate notsolid();
    e_gate connectpaths();
    umbragate_set("train_umbra_gate_04", 1);
    trigger::use("disable_car_0_respawns");
    level thread function_14d8c849(3);
    level thread function_14d8c849(2);
    level thread function_14d8c849(1);
    trigger::wait_till("train_car_lockdown_03");
    function_42e02b4(3);
    e_trigger = getent("train_car_lockdown_04", "targetname");
    e_trigger thread function_7a33acf8();
    trigger::wait_till("train_car_lockdown_02");
    function_42e02b4(2);
    e_trigger = getent("train_car_lockdown_03", "targetname");
    e_trigger thread function_7a33acf8();
    trigger::wait_till("train_car_lockdown_01");
    function_42e02b4(1);
    e_trigger = getent("train_car_lockdown_02", "targetname");
    e_trigger thread function_7a33acf8();
}

// Namespace namespace_c7062b04
// Params 0, eflags: 0x0
// Checksum 0x2172891d, Offset: 0x6348
// Size: 0x189
function function_1b953f61() {
    switch (level.activeplayers.size) {
    case 1:
    case 2:
        n_count = 2;
        break;
    case 3:
        n_count = 4;
        break;
    case 4:
        n_count = 4;
        break;
    default:
        n_count = 0;
        break;
    }
    var_2d8e6fdb = [];
    for (i = 1; i < n_count + 1; i++) {
        var_f6c5842 = spawner::simple_spawn_single("train_climb_robot");
        var_2d8e6fdb[var_2d8e6fdb.size] = var_f6c5842;
        s_scene = struct::get("train_roof2_climb1_0" + i, "targetname");
        s_scene thread scene::init(var_f6c5842);
    }
    level thread function_fa538321(var_2d8e6fdb);
    level thread function_33267d4e();
    level flag::wait_till("train_climb_robot_scene");
    for (i = 1; i < n_count + 1; i++) {
        s_scene = struct::get("train_roof2_climb1_0" + i, "targetname");
        s_scene thread scene::play();
        wait 0.25;
    }
}

// Namespace namespace_c7062b04
// Params 1, eflags: 0x0
// Checksum 0x581d8f86, Offset: 0x64e0
// Size: 0x3a
function function_fa538321(var_2d8e6fdb) {
    level endon(#"spawn_wave2_climbers");
    ai::waittill_dead(var_2d8e6fdb);
    level flag::set("spawn_wave2_climbers");
}

// Namespace namespace_c7062b04
// Params 0, eflags: 0x0
// Checksum 0xcb3114a9, Offset: 0x6528
// Size: 0x159
function function_33267d4e() {
    switch (level.activeplayers.size) {
    case 1:
    case 2:
        n_count = 2;
        break;
    case 3:
        n_count = 4;
        break;
    case 4:
        n_count = 6;
        break;
    default:
        n_count = 0;
        break;
    }
    for (i = 1; i < n_count + 1; i++) {
        var_f6c5842 = spawner::simple_spawn_single("train_climb_robot");
        s_scene = struct::get("train_roof2_climb2_0" + i, "targetname");
        s_scene thread scene::init(var_f6c5842);
    }
    level flag::wait_till("spawn_wave2_climbers");
    for (i = 1; i < n_count + 1; i++) {
        s_scene = struct::get("train_roof2_climb2_0" + i, "targetname");
        s_scene thread scene::play();
        wait 0.25;
    }
}

// Namespace namespace_c7062b04
// Params 0, eflags: 0x0
// Checksum 0xfab1bbbe, Offset: 0x6690
// Size: 0xe1
function function_1cc09cbe() {
    level endon(#"hash_a72162f1");
    level thread function_72967a08();
    e_volume = getent("train_rooftop_volume", "targetname");
    while (isdefined(e_volume)) {
        foreach (player in level.players) {
            if (!(isdefined(player.var_91e69cc1) && player.var_91e69cc1) && player istouching(e_volume)) {
                e_volume thread function_e7124bea(player);
            }
        }
        wait 1;
    }
}

// Namespace namespace_c7062b04
// Params 0, eflags: 0x0
// Checksum 0xd35808b6, Offset: 0x6780
// Size: 0x8a
function function_72967a08() {
    e_trigger = getent("player_enters_train_rooftop", "targetname");
    e_trigger waittill(#"trigger");
    function_d90d60f3();
    level.player_on_top_of_train = 1;
    level flag::set("player_on_top_of_train");
    level clientfield::set("set_fog_bank", 1);
    level thread function_a4f749c7();
}

// Namespace namespace_c7062b04
// Params 0, eflags: 0x0
// Checksum 0x61868164, Offset: 0x6818
// Size: 0x2a
function function_a4f749c7() {
    trigger::wait_till("player_exits_train_rooftop");
    function_d90d60f3(0);
}

// Namespace namespace_c7062b04
// Params 1, eflags: 0x0
// Checksum 0x81603fa8, Offset: 0x6850
// Size: 0x12a
function function_e7124bea(e_player) {
    e_player endon(#"death");
    e_player.var_91e69cc1 = 1;
    e_player clientfield::set_to_player("train_rumble_loop", 1);
    e_player util::set_lighting_state(1);
    var_73bd72a3 = gettime();
    e_player thread function_b4baa478();
    while (e_player istouching(self)) {
        if (e_player.angles[1] >= -90 && e_player.angles[1] <= 90) {
            e_player setmovespeedscale(1.2);
        } else {
            e_player setmovespeedscale(0.7);
        }
        wait 0.05;
    }
    e_player clientfield::set_to_player("train_rumble_loop", 0);
    e_player setmovespeedscale(1);
    e_player.var_91e69cc1 = 0;
    e_player util::set_lighting_state(0);
}

// Namespace namespace_c7062b04
// Params 0, eflags: 0x0
// Checksum 0xcdf7c4c6, Offset: 0x6988
// Size: 0x5a
function function_b4baa478() {
    self endon(#"death");
    if (!(isdefined(self.var_ceb18b02) && self.var_ceb18b02)) {
        self.var_ceb18b02 = 1;
        n_attackeraccuracy = self.attackeraccuracy;
        self.attackeraccuracy = 0.05;
        wait 5;
        self.attackeraccuracy = n_attackeraccuracy;
    }
}

// Namespace namespace_c7062b04
// Params 0, eflags: 0x0
// Checksum 0x7a902042, Offset: 0x69f0
// Size: 0xa2
function function_86f446dd() {
    var_a8a64a67 = getnodearray("train_rooftop_cover", "script_noteworthy");
    foreach (node in var_a8a64a67) {
        setenablenode(node, 0);
    }
    clientfield::set("train_brake_flaps", 1);
}

// Namespace namespace_c7062b04
// Params 1, eflags: 0x0
// Checksum 0xb65625d6, Offset: 0x6aa0
// Size: 0xdb
function function_77a5804(b_skipto) {
    if (!isdefined(b_skipto)) {
        b_skipto = 0;
    }
    if (!b_skipto) {
        level flag::wait_till("player_on_top_of_train");
    }
    clientfield::set("train_brake_flaps", 0);
    wait 0.25;
    var_a8a64a67 = getnodearray("train_rooftop_cover", "script_noteworthy");
    foreach (node in var_a8a64a67) {
        setenablenode(node, 1);
    }
}

// Namespace namespace_c7062b04
// Params 0, eflags: 0x0
// Checksum 0xb12fac4b, Offset: 0x6b88
// Size: 0x32
function function_85eaeda4() {
    function_86f446dd();
    util::wait_network_frame();
    function_77a5804(1);
}

// Namespace namespace_c7062b04
// Params 2, eflags: 0x0
// Checksum 0xe266e0a3, Offset: 0x6bc8
// Size: 0x532
function function_dbb1e1e3(str_objective, var_74cd64bc) {
    if (var_74cd64bc) {
        load::function_73adcefc();
        function_c63fb1d();
        function_cbf76d8c();
        function_e61ead06(str_objective);
        level thread function_75fc9f6a();
        level thread function_14d8c849(1);
        level thread function_e9ea11fb();
        level thread array::run_all(getentarray("train_lockdown_door", "targetname"), &movey, -64, 0.5);
        level thread array::run_all(getentarray("train_lockdown_glass", "targetname"), &delete);
        level thread function_14fcc74b();
        load::function_a2995f22();
        level clientfield::set("train_main_fx_occlude", 1);
        clientfield::set("train_lockdown_glass_left", 2);
        clientfield::set("train_lockdown_glass_right", 2);
        exploder::exploder("ex_breakglass");
        clientfield::set("train_lockdown_shutters_1", 1);
        level thread function_86f446dd();
        level thread train_lockdown_vo();
        level thread objectives::breadcrumb("train_rooftop_breadcrumb");
        weapon = newworld_util::function_71840183("cybercom_rapidstrike", 0);
        var_12b288c7 = weapon.name + "_fired";
        foreach (player in level.players) {
            if (!player newworld_util::function_c633d8fe()) {
                player thread function_e5b6ecf2(var_12b288c7);
            }
        }
        newworld_util::function_3e37f48b(0);
    } else {
        newworld_util::function_c1c980d8("t_vol_cull_stragglers_train_start");
    }
    var_a59819c6 = getentarray("train_roof_diable_respawns", "targetname");
    foreach (var_1bad7ee6 in var_a59819c6) {
        var_1bad7ee6 trigger::use();
    }
    callback::on_ai_killed(&function_9ee5007a);
    level thread function_1cc09cbe();
    level thread function_96977933();
    level thread function_f9012fc();
    level thread function_77a5804();
    level thread function_5e667e1f();
    level thread function_382c53b4();
    level thread function_8a983837();
    level thread function_441a5f5c();
    level thread player_near_last_car_VO();
    level thread function_376cc585();
    level thread scene::play("p7_fxanim_cp_newworld_train_quadtank_tarp_bundle");
    var_3b374bac = getent("train_detach_bomb_hack", "targetname");
    var_3b374bac triggerenable(0);
    trigger::wait_till("train_1st_rooftop_enemy_spawns");
    if (level.activeplayers.size > 1) {
        spawn_manager::enable("train_first_rooftop_reinforcements_sm");
    }
    level flag::wait_till("climb_up_spawns_complete");
    level thread function_6ba3e1f3();
    function_8b13b1f8();
    function_5c66c0be();
    level thread function_cfb8d002();
    function_e84c6ac3();
    spawner::waittill_ai_group_ai_count("last_train_car_robots", 0);
    skipto::function_be8adfb8(str_objective);
}

// Namespace namespace_c7062b04
// Params 0, eflags: 0x0
// Checksum 0xdcac1e83, Offset: 0x7108
// Size: 0x3a
function function_376cc585() {
    self endon(#"death");
    level flag::wait_till("cull_penultimate_stragglers");
    newworld_util::function_c1c980d8("t_vol_cull_stragglers_train_main");
}

// Namespace namespace_c7062b04
// Params 4, eflags: 0x0
// Checksum 0x37c9c570, Offset: 0x7150
// Size: 0x22
function function_ead43429(str_objective, var_74cd64bc, var_e4cd2b8b, player) {
    
}

// Namespace namespace_c7062b04
// Params 0, eflags: 0x0
// Checksum 0xd1fa4428, Offset: 0x7180
// Size: 0x92
function function_e9ea11fb() {
    spawner::add_spawn_function_group("train_robot_rushers", "script_noteworthy", &train_robot_rushers);
    spawner::add_spawn_function_group("train_roof1_reinforcements", "targetname", &function_422fbc49);
    spawner::add_spawn_function_group("train_rooftop_depth", "script_noteworthy", &function_ca6ecfb3);
}

// Namespace namespace_c7062b04
// Params 0, eflags: 0x0
// Checksum 0xd250f7eb, Offset: 0x7220
// Size: 0x52
function train_robot_rushers() {
    self endon(#"death");
    if (self.classname === "actor_spawner_enemy_sec_robot_cqb_shotgun") {
        self ai::set_behavior_attribute("move_mode", "rusher");
        self ai::set_behavior_attribute("sprint", 1);
    }
}

// Namespace namespace_c7062b04
// Params 0, eflags: 0x0
// Checksum 0x72203355, Offset: 0x7280
// Size: 0xea
function function_422fbc49() {
    self endon(#"death");
    self.script_accuracy = 0.1;
    self ai::set_behavior_attribute("sprint", 1);
    var_c9ae457a = getent(self.target, "targetname");
    self setgoal(var_c9ae457a, 1);
    a_flags = [];
    a_flags[0] = "climb_up_robots_cleared";
    a_flags[1] = "release_train_roof1_reinforcements";
    level flag::wait_till_any(a_flags);
    self.script_accuracy = 1;
    self cleargoalvolume();
    self ai::set_behavior_attribute("move_mode", "rusher");
}

// Namespace namespace_c7062b04
// Params 0, eflags: 0x0
// Checksum 0xdf5021da, Offset: 0x7378
// Size: 0xb9
function function_ca6ecfb3() {
    self endon(#"death");
    self.script_accuracy = 0.1;
    while (true) {
        foreach (player in level.activeplayers) {
            if (distance2dsquared(self.origin, player.origin) <= 722500) {
                self.script_accuracy = 1;
                return;
            }
        }
        wait 0.1;
    }
}

// Namespace namespace_c7062b04
// Params 0, eflags: 0x0
// Checksum 0x1e41399b, Offset: 0x7440
// Size: 0x32
function function_6ba3e1f3() {
    spawner::waittill_ai_group_ai_count("climb_up_spawns", 0);
    level flag::set("climb_up_robots_cleared");
}

// Namespace namespace_c7062b04
// Params 0, eflags: 0x0
// Checksum 0x3860491f, Offset: 0x7480
// Size: 0x4a
function function_8a983837() {
    scene::add_scene_func("cin_gen_ambient_quadtank_inactive", &function_3f4179e6, "play");
    scene::play("cin_gen_ambient_quadtank_inactive");
}

// Namespace namespace_c7062b04
// Params 1, eflags: 0x0
// Checksum 0x5e6f06bb, Offset: 0x74d8
// Size: 0x63
function function_3f4179e6(a_ents) {
    foreach (ent in a_ents) {
        ent setplayercollision(0);
    }
}

// Namespace namespace_c7062b04
// Params 0, eflags: 0x0
// Checksum 0xe5390c52, Offset: 0x7548
// Size: 0x72
function function_8b13b1f8() {
    level thread dni_supercomputer_vo();
    function_1b953f61();
    spawn_manager::enable("train_second_rooftop_sm");
    level thread function_72338df1();
    util::wait_network_frame();
    spawn_manager::enable("concussive_wave_2_robots_sm");
}

// Namespace namespace_c7062b04
// Params 0, eflags: 0x0
// Checksum 0x90dfe20c, Offset: 0x75c8
// Size: 0x32
function function_72338df1() {
    level flag::wait_till("init_last_train_car_charging_stations");
    spawn_manager::kill("train_second_rooftop_sm");
}

// Namespace namespace_c7062b04
// Params 0, eflags: 0x0
// Checksum 0x276ad8a1, Offset: 0x7608
// Size: 0xcb
function function_5c66c0be() {
    level flag::wait_till("init_last_train_car_charging_stations");
    spawn_manager::enable("end_cargo_car_sm");
    util::wait_network_frame();
    a_s_scenes = struct::get_array("last_car_robot_chargers", "script_noteworthy");
    foreach (s_scene in a_s_scenes) {
        s_scene scene::init();
    }
}

// Namespace namespace_c7062b04
// Params 0, eflags: 0x0
// Checksum 0xf3710df4, Offset: 0x76e0
// Size: 0x2b3
function function_e84c6ac3() {
    level thread function_96eacbb1();
    level flag::wait_till("spawn_last_train_car_enemies");
    a_s_scenes = struct::get_array("last_car_robot_chargers_left", "targetname");
    foreach (s_scene in a_s_scenes) {
        s_scene thread scene::play();
        wait randomfloatrange(0.1, 0.25);
    }
    a_s_scenes = struct::get_array("last_car_robot_chargers_center", "targetname");
    foreach (s_scene in a_s_scenes) {
        s_scene thread scene::play();
        wait randomfloatrange(0.1, 0.25);
    }
    a_s_scenes = struct::get_array("last_car_robot_chargers_right", "targetname");
    foreach (s_scene in a_s_scenes) {
        s_scene thread scene::play();
        wait randomfloatrange(0.1, 0.25);
    }
    level flag::wait_till("start_last_train_car_end_enemies");
    a_s_scenes = struct::get_array("last_car_robot_charger_end", "targetname");
    foreach (s_scene in a_s_scenes) {
        s_scene thread scene::play();
        wait randomfloatrange(0.1, 0.25);
    }
}

// Namespace namespace_c7062b04
// Params 0, eflags: 0x0
// Checksum 0x2cb93a64, Offset: 0x79a0
// Size: 0x3a
function function_96eacbb1() {
    level endon(#"hash_70ca9767");
    spawn_manager::wait_till_cleared("end_cargo_car_sm");
    level flag::set("spawn_last_train_car_enemies");
}

// Namespace namespace_c7062b04
// Params 1, eflags: 0x0
// Checksum 0xc8de3c15, Offset: 0x79e8
// Size: 0x52
function function_d90d60f3(b_enable) {
    if (!isdefined(b_enable)) {
        b_enable = 1;
    }
    if (b_enable) {
        setdvar("phys_gravity_dir", (-1, 0, 0.9));
        return;
    }
    setdvar("phys_gravity_dir", (0, 0, 1));
}

// Namespace namespace_c7062b04
// Params 2, eflags: 0x0
// Checksum 0xe34e3a41, Offset: 0x7a48
// Size: 0x33a
function function_143fa139(str_objective, var_74cd64bc) {
    if (var_74cd64bc) {
        load::function_73adcefc();
        function_c63fb1d();
        function_cbf76d8c();
        level.var_fbc6080 = 1;
        level thread function_96977933();
        level thread function_f9012fc();
        level thread function_75fc9f6a();
        level thread function_441a5f5c();
        a_s_scenes = struct::get_array("last_car_robot_chargers", "script_noteworthy");
        foreach (s_scene in a_s_scenes) {
            s_scene scene::skipto_end();
        }
        function_cfb8d002();
        var_3b374bac = getent("train_detach_bomb_hack", "targetname");
        var_3b374bac triggerenable(0);
        load::function_a2995f22();
        level clientfield::set("train_main_fx_occlude", 1);
        level util::set_lighting_state(0);
        level clientfield::set("set_fog_bank", 0);
        level thread function_85eaeda4();
    }
    lui::prime_movie("cp_newworld_env_detachbomb");
    battlechatter::function_d9f49fba(0);
    clientfield::set("train_lockdown_glass_left", 0);
    clientfield::set("train_lockdown_glass_right", 0);
    clientfield::set("train_lockdown_shutters_1", 0);
    level notify(#"begin_skipto_detach_bomb_igc_init");
    util::function_d8eaed3d(9);
    e_player = function_84dc13df();
    newworld_util::player_snow_fx();
    objectives::complete("cp_level_newworld_underground_locate_terrorist");
    objectives::set("cp_level_newworld_train_disarm");
    level thread function_68c5ad6d();
    level thread newworld_util::function_30ec5bf7();
    function_67af13f9(e_player);
    level waittill(#"hash_132422b6");
    level util::clear_streamer_hint();
    level notify(#"hash_a72162f1");
    util::clientnotify("newworld_train_complete");
    objectives::complete("cp_level_newworld_train_disarm");
    skipto::function_be8adfb8(str_objective);
}

// Namespace namespace_c7062b04
// Params 4, eflags: 0x0
// Checksum 0xf026ef2a, Offset: 0x7d90
// Size: 0xfa
function function_ea4ba3f3(str_objective, var_74cd64bc, var_e4cd2b8b, player) {
    if (var_74cd64bc === 1) {
        objectives::complete("cp_level_newworld_underground_locate_terrorist");
        objectives::complete("cp_level_newworld_train_subobj_hack_door");
    }
    level clientfield::set("train_brake_flaps", 2);
    e_door_l = getent("train_bomb_push_door_l", "targetname");
    e_door_l delete();
    e_door_r = getent("train_bomb_push_door_r", "targetname");
    e_door_r delete();
    level notify(#"train_terrain_stop");
    level thread function_f0cad19e();
}

// Namespace namespace_c7062b04
// Params 0, eflags: 0x0
// Checksum 0x5ef055b4, Offset: 0x7e98
// Size: 0xb4
function function_84dc13df() {
    objectives::set("cp_level_newworld_train_subobj_hack_door");
    var_3b374bac = getent("train_detach_bomb_hack", "targetname");
    var_3b374bac triggerenable(1);
    e_player = newworld_util::function_16dd8c5f("train_detach_bomb_hack", %cp_level_newworld_access_door, %CP_MI_ZURICH_NEWWORLD_HACK, "train_door_panel", "train_door_hacked", 0);
    objectives::complete("cp_level_newworld_train_subobj_hack_door");
    return e_player;
}

// Namespace namespace_c7062b04
// Params 0, eflags: 0x0
// Checksum 0x92212b5, Offset: 0x7f58
// Size: 0x4a
function function_cfb8d002() {
    scene::add_scene_func("p7_fxanim_cp_newworld_train_end_bundle", &function_368767cf, "init");
    level thread scene::init("p7_fxanim_cp_newworld_train_end_bundle");
}

// Namespace namespace_c7062b04
// Params 1, eflags: 0x0
// Checksum 0x1902fbe7, Offset: 0x7fb0
// Size: 0xca
function function_368767cf(a_ents) {
    var_3ebf068e = a_ents["newworld_train_end"];
    var_3ebf068e enablelinkto();
    var_bf143437 = getentarray("snw_bomb_detach", "script_noteworthy");
    foreach (var_133e9095 in var_bf143437) {
        var_133e9095 linkto(var_3ebf068e);
    }
    var_3ebf068e ghost();
}

// Namespace namespace_c7062b04
// Params 1, eflags: 0x0
// Checksum 0x46bf73f6, Offset: 0x8088
// Size: 0x25a
function function_67af13f9(e_player) {
    level notify(#"hash_70ca9767");
    level thread namespace_e38c3c58::function_922297e3();
    if (isdefined(level.var_700e70fe)) {
        level thread [[ level.var_700e70fe ]]();
    }
    scene::add_scene_func("cin_new_16_01_detachbombcar_1st_detach", &function_956507bd, "play");
    scene::add_scene_func("cin_new_16_01_detachbombcar_1st_detach", &function_c07e4907, "play");
    scene::add_scene_func("cin_new_16_01_detachbombcar_1st_detach", &function_87eb5c2, "play");
    scene::add_scene_func("cin_new_16_01_detachbombcar_1st_detach", &function_80caa10e, "play");
    scene::add_scene_func("cin_new_16_01_detachbombcar_1st_detach", &function_7db3194d, "play");
    scene::add_scene_func("cin_new_16_01_detachbombcar_1st_detach", &function_37f058fc, "play");
    level thread scene::play("cin_new_16_01_detachbombcar_1st_detach", e_player);
    hidemiscmodels("train_bomb_exterior_hide");
    var_3ebf068e = getent("newworld_train_end", "targetname");
    var_3ebf068e show();
    level waittill(#"hash_8fa0f2c");
    e_door_r = getent("train_bomb_push_door_r", "targetname");
    e_door_r movey(-64, 0.5);
    e_door_l = getent("train_bomb_push_door_l", "targetname");
    e_door_l movey(64, 0.5);
}

// Namespace namespace_c7062b04
// Params 1, eflags: 0x0
// Checksum 0x5da2d993, Offset: 0x82f0
// Size: 0x42
function function_956507bd(a_ents) {
    level endon(#"hash_c95de0a1");
    level waittill(#"hash_8b34418f");
    newworld_util::function_2eded728(1);
    level waittill(#"hash_8fa0f2c");
    newworld_util::function_2eded728(0);
}

// Namespace namespace_c7062b04
// Params 1, eflags: 0x0
// Checksum 0x66db54a3, Offset: 0x8340
// Size: 0x72
function function_c07e4907(a_ents) {
    var_1c26230b = a_ents["taylor"];
    var_1c26230b ghost();
    var_1c26230b waittill(#"hash_24a44efc");
    var_1c26230b newworld_util::function_c949a8ed(1);
    var_1c26230b waittill(#"hash_32fc12d3");
    var_1c26230b newworld_util::function_4943984c();
}

// Namespace namespace_c7062b04
// Params 1, eflags: 0x0
// Checksum 0xa7c234d0, Offset: 0x83c0
// Size: 0x3a
function function_87eb5c2(a_ents) {
    level waittill(#"hash_b6d3fdf6");
    newworld_util::function_2eded728(1);
    level waittill(#"hash_50398047");
    newworld_util::function_2eded728(0);
}

// Namespace namespace_c7062b04
// Params 1, eflags: 0x0
// Checksum 0x6ef7b8ab, Offset: 0x8408
// Size: 0x52
function function_80caa10e(a_ents) {
    level waittill(#"hash_c15931f2");
    newworld_util::function_2eded728(1);
    videostart("cp_newworld_env_detachbomb");
    level waittill(#"hash_6bd55c0d");
    newworld_util::function_2eded728(0);
}

// Namespace namespace_c7062b04
// Params 1, eflags: 0x0
// Checksum 0x1e55cc64, Offset: 0x8468
// Size: 0xa2
function function_7db3194d(a_ents) {
    level thread function_778d22d7(a_ents);
    a_ents["player 1"] waittill(#"hash_7db3194d");
    level notify(#"hash_c053b2ca");
    hidemiscmodels("train_bomb_models_hide");
    level thread scene::play("p7_fxanim_cp_newworld_train_end_bundle");
    if (!scene::function_b1f75ee9()) {
        level util::set_lighting_state(1);
        level clientfield::set("set_fog_bank", 1);
    }
}

// Namespace namespace_c7062b04
// Params 1, eflags: 0x0
// Checksum 0x85c21c0b, Offset: 0x8518
// Size: 0x72
function function_778d22d7(a_ents) {
    a_ents["player 1"] waittill(#"train_explosion");
    exploder::exploder("ex_bomb_igc");
    var_3ebf068e = getent("newworld_train_end", "targetname");
    var_3ebf068e clientfield::set("train_explosion_fx", 1);
}

// Namespace namespace_c7062b04
// Params 1, eflags: 0x0
// Checksum 0x69e52912, Offset: 0x8598
// Size: 0x3a
function function_37f058fc(a_ents) {
    a_ents["player 1"] waittill(#"hash_7d28806");
    level notify(#"hash_c95de0a1");
    level flag::set("infinite_white_transition");
}

// Namespace namespace_c7062b04
// Params 0, eflags: 0x0
// Checksum 0x648677e3, Offset: 0x85e0
// Size: 0x1a
function function_68c5ad6d() {
    level thread scene::stop("p7_fxanim_cp_newworld_train_quadtank_tarp_bundle", 1);
}

// Namespace namespace_c7062b04
// Params 1, eflags: 0x0
// Checksum 0xe8782e7e, Offset: 0x8608
// Size: 0x50b
function function_de13d6e2(var_be1a191b) {
    if (!isdefined(var_be1a191b)) {
        var_be1a191b = 0;
    }
    level.var_55c8b6a7 = getent("train_terrain_country_01_track_01", "targetname");
    level.var_55c8b6a7 function_52874109("country_01_lighting");
    level.var_e3c1476c = getent("train_terrain_country_01_track_02", "targetname");
    level.var_e3c1476c function_52874109("country_02_lighting");
    level.var_9c3c1d5 = getent("train_terrain_country_01_track_03", "targetname");
    level.var_9c3c1d5 function_52874109("country_03_lighting");
    level.var_1bfadc08 = getent("train_terrain_country_02_track_01", "targetname");
    level.var_1bfadc08 function_52874109("country2_01_lighting");
    level.var_8e024b43 = getent("train_terrain_country_02_track_02", "targetname");
    level.var_8e024b43 function_52874109("country2_02_lighting");
    level.var_67ffd0da = getent("train_terrain_country_02_track_03", "targetname");
    level.var_67ffd0da function_52874109("country2_03_lighting");
    level.var_accc6632 = getent("train_terrain_tunnel_01_track_01", "targetname");
    level.var_accc6632 function_52874109("tunnel_01_lighting");
    level.var_86c9ebc9 = getent("train_terrain_tunnel_01_track_02", "targetname");
    level.var_86c9ebc9 function_52874109("tunnel_02_lighting");
    level.var_60c77160 = getent("train_terrain_tunnel_01_track_03", "targetname");
    level.var_60c77160 function_52874109("tunnel_03_lighting");
    level.var_689205c5 = getent("train_terrain_city_01_track_01", "targetname");
    level.var_8e94802e = getent("train_terrain_city_01_track_02", "targetname");
    level.var_b496fa97 = getent("train_terrain_city_01_track_03", "targetname");
    if (var_be1a191b == 1) {
        level.var_689205c5 delete();
        level.var_8e94802e delete();
        level.var_b496fa97 delete();
        var_84ff6356 = array(level.var_55c8b6a7, level.var_e3c1476c, level.var_9c3c1d5, level.var_1bfadc08, level.var_8e024b43, level.var_67ffd0da, level.var_accc6632, level.var_86c9ebc9, level.var_60c77160);
    } else {
        var_84ff6356 = array(level.var_55c8b6a7, level.var_e3c1476c, level.var_9c3c1d5, level.var_1bfadc08, level.var_8e024b43, level.var_67ffd0da, level.var_accc6632, level.var_86c9ebc9, level.var_60c77160, level.var_689205c5, level.var_8e94802e, level.var_b496fa97);
    }
    level.var_9cd0665b = var_84ff6356;
    foreach (var_7d2a21b6 in var_84ff6356) {
        if (isdefined(var_7d2a21b6.var_685c7a0b)) {
            foreach (var_f4933ec0 in var_7d2a21b6.var_685c7a0b) {
                var_f4933ec0 linkto(var_7d2a21b6);
            }
        }
        function_8b08d700(var_7d2a21b6);
    }
}

// Namespace namespace_c7062b04
// Params 1, eflags: 0x0
// Checksum 0x516548d3, Offset: 0x8b20
// Size: 0x3e
function function_52874109(str_script_noteworthy) {
    var_d3ec9eeb = getentarray(str_script_noteworthy, "script_noteworthy");
    if (isdefined(var_d3ec9eeb)) {
        self.var_685c7a0b = var_d3ec9eeb;
    }
}

// Namespace namespace_c7062b04
// Params 1, eflags: 0x0
// Checksum 0x5df95f84, Offset: 0x8b68
// Size: 0xaa
function function_8b08d700(var_7d2a21b6) {
    assert(isdefined(var_7d2a21b6), "<dev string:x28>");
    if (isdefined(var_7d2a21b6.var_685c7a0b)) {
        foreach (var_f4933ec0 in var_7d2a21b6.var_685c7a0b) {
            var_f4933ec0 hide();
        }
    }
    var_7d2a21b6 hide();
}

// Namespace namespace_c7062b04
// Params 1, eflags: 0x0
// Checksum 0x47ed20fd, Offset: 0x8c20
// Size: 0xaa
function function_c7d3965b(var_7d2a21b6) {
    assert(isdefined(var_7d2a21b6), "<dev string:x68>");
    if (isdefined(var_7d2a21b6.var_685c7a0b)) {
        foreach (var_f4933ec0 in var_7d2a21b6.var_685c7a0b) {
            var_f4933ec0 ghost();
        }
    }
    var_7d2a21b6 ghost();
}

// Namespace namespace_c7062b04
// Params 1, eflags: 0x0
// Checksum 0x97e5c647, Offset: 0x8cd8
// Size: 0xaa
function function_8db22683(var_7d2a21b6) {
    assert(isdefined(var_7d2a21b6), "<dev string:xa9>");
    if (isdefined(var_7d2a21b6.var_685c7a0b)) {
        foreach (var_f4933ec0 in var_7d2a21b6.var_685c7a0b) {
            var_f4933ec0 show();
        }
    }
    var_7d2a21b6 show();
}

// Namespace namespace_c7062b04
// Params 0, eflags: 0x0
// Checksum 0xffb9269f, Offset: 0x8d90
// Size: 0x63
function function_a86fd374() {
    foreach (var_7d2a21b6 in level.var_9cd0665b) {
        function_8b08d700(var_7d2a21b6);
    }
}

// Namespace namespace_c7062b04
// Params 0, eflags: 0x0
// Checksum 0x7cac83c5, Offset: 0x8e00
// Size: 0x62
function function_6fe6a34d() {
    var_927b5892 = level.var_689205c5;
    var_6c78de29 = level.var_8e94802e;
    var_467663c0 = level.var_b496fa97;
    level thread function_803e8029(var_927b5892, var_6c78de29, var_467663c0, 1);
    level clientfield::set("sndTrainContext", 2);
}

// Namespace namespace_c7062b04
// Params 0, eflags: 0x0
// Checksum 0xd7af0cd2, Offset: 0x8e70
// Size: 0x62
function function_75fc9f6a() {
    var_927b5892 = level.var_55c8b6a7;
    var_6c78de29 = level.var_e3c1476c;
    var_467663c0 = level.var_9c3c1d5;
    level thread function_803e8029(var_927b5892, var_6c78de29, var_467663c0);
    level clientfield::set("sndTrainContext", 1);
}

// Namespace namespace_c7062b04
// Params 0, eflags: 0x0
// Checksum 0x3fcb2a57, Offset: 0x8ee0
// Size: 0x162
function function_3641dc88() {
    var_718f1be5 = level.var_55c8b6a7;
    var_9791964e = level.var_e3c1476c;
    var_bd9410b7 = level.var_9c3c1d5;
    var_4cceec87 = level.var_accc6632;
    var_dac77d4c = level.var_86c9ebc9;
    var_c9f7b5 = level.var_60c77160;
    level flag::wait_till("train_switch_to_tunnel_environment");
    /#
        iprintlnbold("<dev string:xe9>");
    #/
    level clientfield::set("sndTrainContext", 0);
    level thread function_e00aaee6(var_718f1be5, var_9791964e, var_bd9410b7, var_4cceec87, var_dac77d4c, var_c9f7b5);
    newworld_util::function_85d8906c();
    level flag::wait_till("train_switch_to_forest_environment");
    /#
        iprintlnbold("<dev string:x10a>");
    #/
    level clientfield::set("sndTrainContext", 2);
    level thread function_e00aaee6(var_4cceec87, var_dac77d4c, var_c9f7b5, var_718f1be5, var_9791964e, var_bd9410b7);
    level util::delay(6, undefined, &newworld_util::player_snow_fx);
}

// Namespace namespace_c7062b04
// Params 1, eflags: 0x0
// Checksum 0x14d0a182, Offset: 0x9050
// Size: 0x10a
function function_c4addffd(n_delay) {
    if (!isdefined(n_delay)) {
        n_delay = 3;
    }
    var_4cceec87 = level.var_accc6632;
    var_dac77d4c = level.var_86c9ebc9;
    var_c9f7b5 = level.var_60c77160;
    var_f9c66158 = level.var_689205c5;
    var_6bcdd093 = level.var_8e94802e;
    var_45cb562a = level.var_b496fa97;
    newworld_util::function_85d8906c();
    level function_e00aaee6(level.var_2982cbda[0], level.var_2982cbda[1], level.var_2982cbda[2], var_4cceec87, var_dac77d4c, var_c9f7b5);
    wait n_delay;
    level util::delay(3, undefined, &newworld_util::player_snow_fx);
    level function_e00aaee6(level.var_2982cbda[0], level.var_2982cbda[1], level.var_2982cbda[2], var_f9c66158, var_6bcdd093, var_45cb562a);
}

// Namespace namespace_c7062b04
// Params 0, eflags: 0x0
// Checksum 0x807eb2f0, Offset: 0x9168
// Size: 0x15d
function function_441a5f5c() {
    level endon(#"train_terrain_stop");
    var_1f163712 = level.var_55c8b6a7;
    var_f913bca9 = level.var_e3c1476c;
    var_d3114240 = level.var_9c3c1d5;
    var_f1cc2435 = level.var_1bfadc08;
    var_17ce9e9e = level.var_8e024b43;
    var_3dd11907 = level.var_67ffd0da;
    while (true) {
        /#
            iprintlnbold("<dev string:x13a>");
        #/
        level function_e00aaee6(level.var_2982cbda[0], level.var_2982cbda[1], level.var_2982cbda[2], var_f1cc2435, var_17ce9e9e, var_3dd11907);
        level clientfield::set("sndTrainContext", 1);
        wait randomfloatrange(4, 10);
        /#
            iprintlnbold("<dev string:x15e>");
        #/
        level function_e00aaee6(level.var_2982cbda[0], level.var_2982cbda[1], level.var_2982cbda[2], var_1f163712, var_f913bca9, var_d3114240);
        wait randomfloatrange(4, 10);
    }
}

// Namespace namespace_c7062b04
// Params 4, eflags: 0x0
// Checksum 0xbf2a9c6b, Offset: 0x92d0
// Size: 0x162
function function_803e8029(var_27ebb578, var_99f324b3, var_73f0aa4a, var_6dcdeb0e) {
    if (!isdefined(var_6dcdeb0e)) {
        var_6dcdeb0e = 0;
    }
    if (var_6dcdeb0e == 1) {
        s_origin = struct::get("train_terrain_origin_intro", "targetname");
    } else {
        s_origin = struct::get("train_terrain_origin", "targetname");
    }
    level flag::clear("train_terrain_move_complete");
    level flag::clear("train_terrain_transition");
    var_27ebb578.origin = s_origin.origin - (36736, 0, 0);
    var_99f324b3.origin = s_origin.origin;
    if (isdefined(var_73f0aa4a)) {
        var_73f0aa4a.origin = s_origin.origin + (36736, 0, 0);
    }
    level.var_5feedb29 = var_27ebb578.origin;
    function_8db22683(var_27ebb578);
    function_8db22683(var_99f324b3);
    function_8db22683(var_73f0aa4a);
    level thread function_8c130c9c(var_27ebb578, var_99f324b3, var_73f0aa4a);
}

// Namespace namespace_c7062b04
// Params 3, eflags: 0x0
// Checksum 0xa75da17d, Offset: 0x9440
// Size: 0x2b2
function function_8c130c9c(var_27ebb578, var_99f324b3, var_73f0aa4a) {
    level endon(#"hash_6f4b6b65");
    level endon(#"hash_a72162f1");
    level endon(#"train_terrain_stop");
    level.var_2982cbda = array(var_27ebb578, var_99f324b3, var_73f0aa4a);
    while (!level flag::get("train_terrain_transition")) {
        function_c7d3965b(var_27ebb578);
        var_27ebb578.origin = level.var_5feedb29;
        util::delay(0.1, "train_terrain_stop", &function_8db22683, var_27ebb578);
        var_27ebb578 movex(36736, 4);
        var_99f324b3 movex(36736, 4);
        if (isdefined(var_73f0aa4a)) {
            var_73f0aa4a movex(36736, 4);
        }
        wait 4;
        if (level flag::get("train_terrain_transition")) {
            break;
        }
        if (isdefined(var_73f0aa4a)) {
            function_c7d3965b(var_73f0aa4a);
            var_73f0aa4a.origin = level.var_5feedb29;
            util::delay(0.1, "train_terrain_stop", &function_8db22683, var_73f0aa4a);
            var_27ebb578 movex(36736, 4);
            var_99f324b3 movex(36736, 4);
            var_73f0aa4a movex(36736, 4);
            wait 4;
            if (level flag::get("train_terrain_transition")) {
                break;
            }
        }
        function_c7d3965b(var_99f324b3);
        var_99f324b3.origin = level.var_5feedb29;
        util::delay(0.1, "train_terrain_stop", &function_8db22683, var_99f324b3);
        var_27ebb578 movex(36736, 4);
        var_99f324b3 movex(36736, 4);
        if (isdefined(var_73f0aa4a)) {
            var_73f0aa4a movex(36736, 4);
        }
        wait 4;
    }
    level flag::set("train_terrain_move_complete");
}

// Namespace namespace_c7062b04
// Params 6, eflags: 0x0
// Checksum 0xda979f52, Offset: 0x9700
// Size: 0x32a
function function_e00aaee6(var_408a63ba, var_1a87e951, var_f4856ee8, var_aeec5cb7, var_3ce4ed7c, var_62e767e5) {
    level endon(#"hash_6f4b6b65");
    level endon(#"hash_a72162f1");
    level endon(#"train_terrain_stop");
    level flag::set("train_terrain_transition");
    level flag::wait_till("train_terrain_move_complete");
    level flag::clear("train_terrain_move_complete");
    level flag::clear("train_terrain_transition");
    a_new = [];
    if (isdefined(var_62e767e5)) {
        a_new[0] = var_62e767e5;
    }
    a_new[a_new.size] = var_3ce4ed7c;
    a_new[a_new.size] = var_aeec5cb7;
    var_441a9c3c = a_new.size;
    var_e3d03940 = [];
    if (isdefined(var_f4856ee8)) {
        var_e3d03940[0] = var_f4856ee8;
    }
    var_e3d03940[var_e3d03940.size] = var_1a87e951;
    var_e3d03940[var_e3d03940.size] = var_408a63ba;
    s_pos = struct::get("back_of_the_train", "targetname");
    var_e3d03940 = arraysort(var_e3d03940, s_pos.origin, 0);
    while (a_new.size > 0) {
        var_691445b2 = var_e3d03940[var_e3d03940.size - 1];
        if (var_691445b2 === var_408a63ba || var_691445b2 === var_1a87e951 || var_691445b2 === var_f4856ee8) {
            function_8b08d700(var_e3d03940[var_e3d03940.size - 1]);
            array::pop(var_e3d03940, var_e3d03940.size - 1);
        }
        function_c7d3965b(a_new[0]);
        a_new[0].origin = level.var_5feedb29;
        util::delay(0.1, "train_terrain_stop", &function_8db22683, a_new[0]);
        array::push_front(var_e3d03940, a_new[0]);
        array::pop_front(a_new, 0);
        foreach (var_48b8273c in var_e3d03940) {
            var_48b8273c movex(36736, 4);
        }
        wait 4;
    }
    while (var_e3d03940.size > var_441a9c3c) {
        function_8b08d700(var_e3d03940[var_e3d03940.size - 1]);
        array::pop(var_e3d03940, var_e3d03940.size - 1);
    }
    if (isdefined(var_e3d03940[2])) {
        level thread function_8c130c9c(var_e3d03940[2], var_e3d03940[0], var_e3d03940[1]);
        return;
    }
    level thread function_8c130c9c(var_e3d03940[0], var_e3d03940[1], var_e3d03940[2]);
}

// Namespace namespace_c7062b04
// Params 0, eflags: 0x0
// Checksum 0x7e00b019, Offset: 0x9a38
// Size: 0x9a
function function_7d334045() {
    var_927b5892 = level.var_689205c5;
    var_6c78de29 = level.var_8e94802e;
    var_467663c0 = level.var_b496fa97;
    level notify(#"train_terrain_stop");
    var_927b5892 moveto(var_927b5892.origin, 0.05);
    var_6c78de29 moveto(var_6c78de29.origin, 0.05);
    var_467663c0 moveto(var_467663c0.origin, 0.05);
}

// Namespace namespace_c7062b04
// Params 0, eflags: 0x0
// Checksum 0x53c6272f, Offset: 0x9ae0
// Size: 0x12a
function function_9eb901e() {
    var_927b5892 = level.var_55c8b6a7;
    var_6c78de29 = level.var_e3c1476c;
    var_467663c0 = level.var_9c3c1d5;
    var_5087bc9f = level.var_1bfadc08;
    var_2a854236 = level.var_8e024b43;
    var_482c7cd = level.var_67ffd0da;
    level notify(#"train_terrain_stop");
    var_927b5892 moveto(var_927b5892.origin, 0.05);
    var_6c78de29 moveto(var_6c78de29.origin, 0.05);
    var_467663c0 moveto(var_467663c0.origin, 0.05);
    var_5087bc9f moveto(var_5087bc9f.origin, 0.05);
    var_2a854236 moveto(var_2a854236.origin, 0.05);
    var_482c7cd moveto(var_482c7cd.origin, 0.05);
}

// Namespace namespace_c7062b04
// Params 0, eflags: 0x0
// Checksum 0xd54d4dba, Offset: 0x9c18
// Size: 0x63
function function_f0cad19e() {
    foreach (var_bf3222f4 in level.var_9cd0665b) {
        var_bf3222f4 delete();
    }
}

// Namespace namespace_c7062b04
// Params 0, eflags: 0x0
// Checksum 0xbfdec29d, Offset: 0x9c88
// Size: 0xa3
function function_96977933() {
    level endon(#"hash_a72162f1");
    level thread function_820e1ea2();
    var_7b45393e = getentarray("train_bad_area", "targetname");
    foreach (e_trigger in var_7b45393e) {
        e_trigger thread function_8486688f();
    }
}

// Namespace namespace_c7062b04
// Params 0, eflags: 0x0
// Checksum 0xa339d857, Offset: 0x9d38
// Size: 0xa5
function function_8486688f() {
    level endon(#"hash_47ed8d40");
    var_f65c3861 = struct::get_array(self.target, "targetname");
    while (true) {
        self waittill(#"trigger", e_who);
        if (isplayer(e_who) && !(isdefined(e_who.var_511157e8) && e_who.var_511157e8)) {
            e_who playsoundtoplayer("evt_plr_derez", e_who);
            e_who thread function_c24ce0f9(var_f65c3861);
        }
    }
}

// Namespace namespace_c7062b04
// Params 1, eflags: 0x0
// Checksum 0x4b187322, Offset: 0x9de8
// Size: 0x199
function function_c24ce0f9(var_f65c3861) {
    self endon(#"death");
    while (true) {
        s_spot = array::random(var_f65c3861);
        if (!positionwouldtelefrag(s_spot.origin)) {
            self.var_511157e8 = 1;
            self.ignoreme = 1;
            self enableinvulnerability();
            self ghost();
            self util::freeze_player_controls(1);
            self setorigin(s_spot.origin);
            self setplayerangles(s_spot.angles);
            self clientfield::increment_to_player("postfx_igc");
            util::wait_network_frame();
            self show();
            self clientfield::set("player_spawn_fx", 1);
            self util::delay(2, "death", &clientfield::set, "player_spawn_fx", 0);
            self thread function_f26eff53();
            wait 2;
            self disableinvulnerability();
            self util::freeze_player_controls(0);
            self.var_511157e8 = 0;
            self.ignoreme = 0;
            break;
        }
    }
}

// Namespace namespace_c7062b04
// Params 0, eflags: 0x0
// Checksum 0x82543368, Offset: 0x9f90
// Size: 0x7d
function function_820e1ea2() {
    level endon(#"hash_a72162f1");
    e_trigger = getent("train_bad_area_robots", "targetname");
    while (true) {
        e_trigger waittill(#"trigger", e_who);
        if (!isplayer(e_who)) {
            e_who kill();
        }
    }
}

// Namespace namespace_c7062b04
// Params 0, eflags: 0x0
// Checksum 0xb701ca85, Offset: 0xa018
// Size: 0xb2
function function_f9012fc() {
    level endon(#"hash_a72162f1");
    var_32400ae0 = getent("train_grenades_make_duds", "targetname");
    foreach (player in level.players) {
        player thread grenade_toss(var_32400ae0);
    }
    callback::on_spawned(&grenade_toss, var_32400ae0);
}

// Namespace namespace_c7062b04
// Params 1, eflags: 0x0
// Checksum 0x870f865d, Offset: 0xa0d8
// Size: 0x4d
function grenade_toss(var_32400ae0) {
    level endon(#"hash_a72162f1");
    self endon(#"death");
    while (true) {
        self waittill(#"grenade_fire", e_grenade);
        e_grenade thread function_337c8c84(var_32400ae0);
    }
}

// Namespace namespace_c7062b04
// Params 1, eflags: 0x0
// Checksum 0xdd5bdc32, Offset: 0xa130
// Size: 0x99
function function_337c8c84(var_32400ae0) {
    self endon(#"death");
    if (isdefined(10)) {
        __s = spawnstruct();
        __s endon(#"timeout");
        __s util::delay_notify(10, "timeout");
    }
    while (true) {
        if (self istouching(var_32400ae0)) {
            if (isdefined(self)) {
                self makegrenadedud();
            }
            break;
        }
        wait 0.05;
    }
}

// Namespace namespace_c7062b04
// Params 1, eflags: 0x0
// Checksum 0x847f959e, Offset: 0xa1d8
// Size: 0x2a
function function_9ee5007a(params) {
    self thread function_be50cfd5();
    self thread function_50171558();
}

// Namespace namespace_c7062b04
// Params 0, eflags: 0x0
// Checksum 0x6066ec0e, Offset: 0xa210
// Size: 0x2a
function function_be50cfd5() {
    self waittill(#"start_ragdoll");
    if (isdefined(self)) {
        self clientfield::set("train_throw_robot_corpses", 1);
    }
}

// Namespace namespace_c7062b04
// Params 0, eflags: 0x0
// Checksum 0x203d91cb, Offset: 0xa248
// Size: 0x32
function function_50171558() {
    self waittill(#"actor_corpse", e_corpse);
    if (isdefined(e_corpse)) {
        e_corpse clientfield::set("train_throw_robot_corpses", 1);
    }
}

// Namespace namespace_c7062b04
// Params 0, eflags: 0x0
// Checksum 0xf9cde642, Offset: 0xa288
// Size: 0x8a
function function_19b91013() {
    s_org = struct::get("intro_igc_train_vo", "targetname");
    var_2c3a4ffd = spawn("script_origin", s_org.origin);
    level waittill(#"chyron_menu_open");
    var_2c3a4ffd dialog::say("trai_downtown_zurich_fin_0", 7, 1);
    var_2c3a4ffd delete();
}

// Namespace namespace_c7062b04
// Params 0, eflags: 0x0
// Checksum 0x91cdcf1d, Offset: 0xa320
// Size: 0x52
function function_c63fb1d() {
    var_7066a248 = struct::get("taylor_vo", "targetname");
    level.var_fc1953ce = spawn("script_origin", var_7066a248.origin);
}

// Namespace namespace_c7062b04
// Params 0, eflags: 0x0
// Checksum 0x2b92c4a6, Offset: 0xa380
// Size: 0x7a
function function_8c0c3c47() {
    level flag::init("train_intro_vo_complete");
    level.var_fc1953ce dialog::say("tayr_you_ve_been_here_bef_0", undefined, 1);
    level.var_fc1953ce dialog::say("tayr_all_robots_should_be_0", 0.5, 1);
    level flag::set("train_intro_vo_complete");
}

// Namespace namespace_c7062b04
// Params 2, eflags: 0x0
// Checksum 0xee6b52b6, Offset: 0xa408
// Size: 0x12b
function function_11711684(var_81a32895, var_2380d5c) {
    level flag::wait_till("train_intro_vo_complete");
    weapon = newworld_util::function_71840183(var_81a32895, var_2380d5c);
    var_12b288c7 = weapon.name + "_fired";
    var_a2cc98e = var_81a32895 + "_use_ability_tutorial";
    foreach (player in level.activeplayers) {
        if (player newworld_util::function_c633d8fe()) {
            continue;
        }
        level.var_fc1953ce dialog::say("tayr_takedown_is_another_0", 0.25, 1, player);
        player thread function_1563ec28(var_a2cc98e);
        player thread function_152eb171(var_12b288c7);
    }
}

// Namespace namespace_c7062b04
// Params 1, eflags: 0x0
// Checksum 0x1e38e671, Offset: 0xa540
// Size: 0x10d
function function_1563ec28(var_a2cc98e) {
    level endon(#"concussive_wave_tutorial_started");
    self endon(var_a2cc98e);
    self endon(#"death");
    if (!self flag::exists(var_a2cc98e)) {
        return;
    }
    if (self flag::get(var_a2cc98e)) {
        return;
    }
    wait 30;
    n_line = randomintrange(0, 3);
    switch (n_line) {
    case 0:
        level.var_fc1953ce dialog::say("tayr_what_are_you_waiting_0", undefined, 1, self);
        break;
    case 1:
        level.var_fc1953ce dialog::say("tayr_don_t_leave_me_hangi_0", undefined, 1, self);
        break;
    case 2:
        level.var_fc1953ce dialog::say("tayr_i_m_aging_by_the_fuc_0", undefined, 1, self);
        break;
    }
}

// Namespace namespace_c7062b04
// Params 1, eflags: 0x0
// Checksum 0x9f25285c, Offset: 0xa658
// Size: 0x107
function function_152eb171(var_12b288c7) {
    self endon(#"death");
    level endon(#"concussive_wave_tutorial_started");
    self thread function_e5b6ecf2(var_12b288c7, 1);
    self waittill(var_12b288c7);
    wait 0.25;
    n_line = randomintrange(0, 3);
    switch (n_line) {
    case 0:
        level.var_fc1953ce dialog::say("tayr_that_s_how_you_take_0", undefined, 1, self);
        break;
    case 1:
        level.var_fc1953ce dialog::say("tayr_nice_you_re_gettin_0", undefined, 1, self);
        break;
    case 2:
        level.var_fc1953ce dialog::say("tayr_nice_takedown_righ_0", undefined, 1, self);
        break;
    }
    self notify(#"takedown_tutorial_success_vo_complete");
}

// Namespace namespace_c7062b04
// Params 2, eflags: 0x0
// Checksum 0x7394d552, Offset: 0xa768
// Size: 0x18d
function function_e5b6ecf2(var_12b288c7, var_a74dbb8c) {
    self endon(#"death");
    level endon(#"hash_70ca9767");
    if (isdefined(var_a74dbb8c)) {
        self util::waittill_any_timeout(30, "takedown_tutorial_success_vo_complete");
        wait 15;
    }
    while (true) {
        self waittill(var_12b288c7);
        if (isdefined(level.var_fc1953ce.is_talking) && level.var_fc1953ce.is_talking) {
            continue;
        }
        if (isdefined(level.var_fc1953ce.var_c795bf9b) && level.var_fc1953ce.var_c795bf9b) {
            continue;
        }
        level.var_fc1953ce.var_c795bf9b = 1;
        wait 0.25;
        n_line = randomintrange(0, 3);
        switch (n_line) {
        case 0:
            level.var_fc1953ce dialog::say("tayr_that_s_how_you_take_0", undefined, 1);
            break;
        case 1:
            level.var_fc1953ce dialog::say("tayr_nice_you_re_gettin_0", undefined, 1);
            break;
        case 2:
            level.var_fc1953ce dialog::say("tayr_nice_takedown_righ_0", undefined, 1);
            break;
        }
        level thread function_11e947ae();
    }
}

// Namespace namespace_c7062b04
// Params 0, eflags: 0x0
// Checksum 0xcae786be, Offset: 0xa900
// Size: 0x16
function function_11e947ae() {
    wait 30;
    level.var_fc1953ce.var_c795bf9b = 0;
}

// Namespace namespace_c7062b04
// Params 0, eflags: 0x0
// Checksum 0xd7f8b4f8, Offset: 0xa920
// Size: 0x102
function function_8e9219f() {
    if (isdefined(self.var_470b117b) && self.var_470b117b) {
        return;
    }
    self.var_470b117b = 1;
    n_line = randomintrange(0, 3);
    switch (n_line) {
    case 0:
        level.var_fc1953ce dialog::say("tayr_watch_the_civs_you_0", 0.5, 1, self);
        break;
    case 1:
        level.var_fc1953ce dialog::say("tayr_this_may_be_sim_but_0", 0.5, 1, self);
        break;
    case 2:
        level.var_fc1953ce dialog::say("tayr_if_this_shit_was_rea_0", 0.5, 1, self);
        break;
    }
    self thread function_999e5485();
}

// Namespace namespace_c7062b04
// Params 0, eflags: 0x0
// Checksum 0x979cc3eb, Offset: 0xaa30
// Size: 0x16
function function_999e5485() {
    self endon(#"death");
    wait 30;
    self.var_470b117b = 0;
}

// Namespace namespace_c7062b04
// Params 0, eflags: 0x0
// Checksum 0x894a7332, Offset: 0xaa50
// Size: 0x22
function function_783ceb85() {
    level.var_fc1953ce dialog::say("tayr_watch_your_flank_th_0", undefined, 1);
}

// Namespace namespace_c7062b04
// Params 0, eflags: 0x0
// Checksum 0xcf4632b2, Offset: 0xaa80
// Size: 0xaa
function train_lockdown_vo() {
    s_org = struct::get("train_lockdown_vo", "targetname");
    var_2c3a4ffd = spawn("script_origin", (-20881, 15612, 4267));
    while (!level flag::get("stop_train_lockdown_vo")) {
        var_2c3a4ffd dialog::say("trai_warning_train_going_0", undefined, 1);
        wait 5;
    }
    var_2c3a4ffd delete();
}

// Namespace namespace_c7062b04
// Params 2, eflags: 0x0
// Checksum 0xec3eb8e9, Offset: 0xab38
// Size: 0xd2
function function_9f8dbaa2(var_81a32895, var_2380d5c) {
    self endon(#"hash_848a4771");
    level.var_fc1953ce dialog::say("tayr_use_concussive_wave_0", undefined, 1, self);
    self flag::set("concussive_wave_tutorial_vo_complete");
    weapon = newworld_util::function_71840183(var_81a32895, var_2380d5c);
    var_12b288c7 = weapon.name + "_fired";
    var_a2cc98e = var_81a32895 + "_use_ability_tutorial";
    var_b41e8e5c = var_81a32895 + "_WW_tutorial";
    self thread function_32b93f59(var_b41e8e5c, var_a2cc98e);
    self thread function_3fbeb972(var_12b288c7);
}

// Namespace namespace_c7062b04
// Params 2, eflags: 0x0
// Checksum 0x5e242697, Offset: 0xac18
// Size: 0x15d
function function_32b93f59(var_b41e8e5c, var_a2cc98e) {
    level endon(#"hash_70ca9767");
    self endon(var_a2cc98e);
    self endon(#"death");
    if (!self flag::exists(var_b41e8e5c)) {
        return;
    }
    self flag::wait_till(var_b41e8e5c);
    wait 10;
    if (self flag::get(var_a2cc98e)) {
        return;
    }
    n_line = randomintrange(0, 4);
    switch (n_line) {
    case 0:
        level.var_fc1953ce dialog::say("tayr_one_concussive_wave_0", undefined, 1, self);
        break;
    case 1:
        level.var_fc1953ce dialog::say("tayr_let_me_see_you_can_d_0", undefined, 1, self);
        break;
    case 2:
        level.var_fc1953ce dialog::say("tayr_quit_dicking_around_0", undefined, 1, self);
        break;
    case 3:
        level.var_fc1953ce dialog::say("tayr_concussive_wave_is_o_0", undefined, 1, self);
        break;
    }
}

// Namespace namespace_c7062b04
// Params 1, eflags: 0x0
// Checksum 0xd87e4d92, Offset: 0xad80
// Size: 0x10a
function function_3fbeb972(var_12b288c7) {
    self endon(#"death");
    level endon(#"hash_70ca9767");
    self waittill(#"hash_f045e164");
    wait 0.75;
    n_line = randomintrange(0, 3);
    switch (n_line) {
    case 0:
        level.var_fc1953ce dialog::say("tayr_fuck_yes_you_re_a_0", undefined, 1, self);
        break;
    case 1:
        level.var_fc1953ce dialog::say("tayr_see_how_that_just_to_0", undefined, 1, self);
        break;
    case 2:
        level.var_fc1953ce dialog::say("tayr_shock_and_awe_newbl_0", undefined, 1, self);
        break;
    }
    self util::delay(30, "death", &function_7bece35e);
}

// Namespace namespace_c7062b04
// Params 0, eflags: 0x0
// Checksum 0x55fd8a76, Offset: 0xae98
// Size: 0x15d
function function_7bece35e() {
    self endon(#"death");
    level endon(#"hash_70ca9767");
    while (true) {
        self waittill(#"hash_f045e164");
        wait 0.75;
        if (isdefined(level.var_fc1953ce.is_talking) && level.var_fc1953ce.is_talking) {
            continue;
        }
        if (isdefined(level.var_fc1953ce.var_c795bf9b) && level.var_fc1953ce.var_c795bf9b) {
            continue;
        }
        level.var_fc1953ce.var_c795bf9b = 1;
        n_line = randomintrange(0, 3);
        switch (n_line) {
        case 0:
            level.var_fc1953ce dialog::say("tayr_fuck_yes_you_re_a_0", undefined, 1);
            break;
        case 1:
            level.var_fc1953ce dialog::say("tayr_see_how_that_just_to_0", undefined, 1);
            break;
        case 2:
            level.var_fc1953ce dialog::say("tayr_shock_and_awe_newbl_0", undefined, 1);
            break;
        }
        level thread function_631b737f();
    }
}

// Namespace namespace_c7062b04
// Params 0, eflags: 0x0
// Checksum 0xcfac6190, Offset: 0xb000
// Size: 0x16
function function_631b737f() {
    wait 30;
    level.var_fc1953ce.var_c795bf9b = 0;
}

// Namespace namespace_c7062b04
// Params 0, eflags: 0x0
// Checksum 0x192cb1b2, Offset: 0xb020
// Size: 0xba
function dni_supercomputer_vo() {
    if (sessionmodeiscampaignzombiesgame()) {
        return;
    }
    level flag::init("dni_supercomputer_vo_complete");
    trigger::wait_till("dni_supercomputer_vo");
    level thread objectives::breadcrumb("breadcrumb_helper_find_bomb");
    level.var_fc1953ce dialog::say("tayr_the_neural_network_p_0", undefined, 1);
    level.var_fc1953ce dialog::say("tayr_you_better_pick_up_t_0", 0.5, 1);
    level flag::set("dni_supercomputer_vo_complete");
}

// Namespace namespace_c7062b04
// Params 0, eflags: 0x0
// Checksum 0x3b76068c, Offset: 0xb0e8
// Size: 0x2a
function function_f7302a65() {
    wait 0.25;
    level.var_fc1953ce dialog::say("tayr_you_got_hostiles_cli_0", undefined, 1);
}

// Namespace namespace_c7062b04
// Params 0, eflags: 0x0
// Checksum 0x876ac884, Offset: 0xb120
// Size: 0x3a
function player_near_last_car_VO() {
    trigger::wait_till("player_near_last_car_VO");
    level.var_fc1953ce dialog::say("tayr_keep_pushing_up_you_0", undefined, 1);
}

// Namespace namespace_c7062b04
// Params 0, eflags: 0x0
// Checksum 0x325968ae, Offset: 0xb168
// Size: 0xda
function function_f26eff53() {
    self endon(#"death");
    if (isdefined(self.var_cd9625d0) && self.var_cd9625d0) {
        return;
    }
    if (!isdefined(self.var_bd355621)) {
        self.var_bd355621 = array("tayr_watch_your_step_try_0", "tayr_you_fall_here_you_ge_0", "tayr_pick_yourself_up_and_0");
    }
    wait 0.5;
    str_line = array::pop(self.var_bd355621, randomintrange(0, self.var_bd355621.size), 0);
    if (self.var_bd355621.size == 0) {
        self.var_bd355621 = undefined;
    }
    level.var_fc1953ce dialog::say(str_line, undefined, 1, self);
    self thread function_d9c04d31();
}

// Namespace namespace_c7062b04
// Params 0, eflags: 0x0
// Checksum 0xbd40221, Offset: 0xb250
// Size: 0x22
function function_d9c04d31() {
    self endon(#"death");
    self.var_cd9625d0 = 1;
    wait 30;
    self.var_cd9625d0 = 0;
}

/#

    // Namespace namespace_c7062b04
    // Params 1, eflags: 0x0
    // Checksum 0xbcb1dce1, Offset: 0xb280
    // Size: 0xb5
    function function_8a8944d6(var_133e9095) {
        while (isdefined(var_133e9095) && isdefined(self)) {
            line(var_133e9095.origin, self.origin, (1, 0, 0), 0.1);
            debug::debug_sphere(var_133e9095.origin, 16, (1, 0, 0), 0.5, 1);
            debug::drawarrow(self.origin, self.angles);
            debug::drawarrow(var_133e9095.origin, var_133e9095.angles);
            wait 0.05;
        }
    }

#/
