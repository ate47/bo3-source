#using scripts/cp/cp_mi_sing_sgen_patch;
#using scripts/shared/vehicles/_quadtank;
#using scripts/cp/gametypes/_save;
#using scripts/cp/cp_mi_sing_sgen_flood;
#using scripts/cp/cp_mi_sing_sgen_water_ride;
#using scripts/cp/cp_mi_sing_sgen_uw_battle;
#using scripts/cp/cp_mi_sing_sgen_silo_swim;
#using scripts/cp/cp_mi_sing_sgen_revenge_igc;
#using scripts/cp/cp_mi_sing_sgen_pallas;
#using scripts/cp/cp_mi_sing_sgen_fallen_soldiers;
#using scripts/cp/cp_mi_sing_sgen_testing_lab_igc;
#using scripts/cp/cp_mi_sing_sgen_dark_battle;
#using scripts/cp/cp_mi_sing_sgen_enter_silo;
#using scripts/cp/cp_mi_sing_sgen_exterior;
#using scripts/cp/cp_mi_sing_sgen_accolades;
#using scripts/cp/cp_mi_sing_sgen_util;
#using scripts/cp/cp_mi_sing_sgen_sound;
#using scripts/cp/cp_mi_sing_sgen_fx;
#using scripts/cp/cybercom/_cybercom_tactical_rig;
#using scripts/cp/cybercom/_cybercom_util;
#using scripts/cp/cybercom/_cybercom;
#using scripts/cp/_collectibles;
#using scripts/cp/_util;
#using scripts/cp/_skipto;
#using scripts/cp/_oed;
#using scripts/cp/_objectives;
#using scripts/cp/_mobile_armory;
#using scripts/cp/_load;
#using scripts/cp/_ammo_cache;
#using scripts/shared/visionset_mgr_shared;
#using scripts/shared/trigger_shared;
#using scripts/shared/util_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/player_shared;
#using scripts/shared/flagsys_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/colors_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/audio_shared;
#using scripts/shared/array_shared;
#using scripts/codescripts/struct;

#namespace namespace_fa13d4ba;

// Namespace namespace_fa13d4ba
// Params 0, eflags: 0x0
// namespace_fa13d4ba<file_0>::function_243693d4
// Checksum 0x7bc19daa, Offset: 0x1a30
// Size: 0x34
function function_243693d4() {
    util::add_gametype("coop");
    util::add_gametype("cpzm");
}

// Namespace namespace_fa13d4ba
// Params 0, eflags: 0x1 linked
// namespace_fa13d4ba<file_0>::function_d290ebfa
// Checksum 0x9edcc896, Offset: 0x1a70
// Size: 0x2a4
function main() {
    if (sessionmodeiscampaignzombiesgame() && 0) {
        setclearanceceiling(34);
    } else {
        setclearanceceiling(116);
    }
    precache();
    init_clientfields();
    init_flags();
    function_673254cc();
    function_b29072ff();
    function_1f7e5210();
    util::function_b499f765();
    util::function_286a5010(6);
    callback::on_spawned(&on_player_spawned);
    savegame::function_8c0c4b3a("sgen");
    namespace_219c76cc::main();
    namespace_172c963::main();
    level.var_d829fe9f = 1;
    level.can_revive_use_depthinwater_test = 1;
    level.var_173c585e = 1;
    if (getdvarstring("skipto") === "dev_flood_combat") {
        namespace_cba4cc55::function_6d1a2a8d("flood_combat", "dev_flood_combat");
    }
    load::main();
    namespace_643bc20::function_7403e82b();
    var_19aeddfe = struct::get_array("dark_battle_align_2", "targetname");
    if (isdefined(var_19aeddfe) && var_19aeddfe.size > 1) {
        level.var_c490ab3b = var_19aeddfe[1].origin - var_19aeddfe[0].origin;
    }
    var_c3f856f0 = getent("flood_defend_out_of_boundary_trig", "targetname");
    var_c3f856f0 setinvisibletoall();
    level thread function_4b0856b();
    level thread namespace_99202726::function_66df416f();
}

// Namespace namespace_fa13d4ba
// Params 0, eflags: 0x1 linked
// namespace_fa13d4ba<file_0>::function_1f7e5210
// Checksum 0xfb27e6cc, Offset: 0x1d20
// Size: 0x5c
function function_1f7e5210() {
    var_d227736c = spawn("trigger_box", (280, -600, -3610), 0, 3000, 3000, 3000);
    var_d227736c thread function_4fef5e4();
}

// Namespace namespace_fa13d4ba
// Params 0, eflags: 0x1 linked
// namespace_fa13d4ba<file_0>::function_4fef5e4
// Checksum 0xaf1193c2, Offset: 0x1d88
// Size: 0x70
function function_4fef5e4() {
    self endon(#"death");
    level endon(#"hash_398666a0");
    while (true) {
        who = self waittill(#"trigger");
        if (isplayer(who)) {
            who kill();
        }
    }
}

// Namespace namespace_fa13d4ba
// Params 0, eflags: 0x1 linked
// namespace_fa13d4ba<file_0>::function_b29072ff
// Checksum 0xb8772033, Offset: 0x1e00
// Size: 0x66
function function_b29072ff() {
    var_76099c5f = spawnstruct();
    var_76099c5f.radius = 60;
    var_76099c5f.offset = (-5, -5, 0);
    level.var_3efe1e22["p7_nc_sin_coa_04"] = var_76099c5f;
}

// Namespace namespace_fa13d4ba
// Params 0, eflags: 0x1 linked
// namespace_fa13d4ba<file_0>::function_673254cc
// Checksum 0x9f7944a8, Offset: 0x1e70
// Size: 0x644
function function_673254cc() {
    skipto::add("intro", &namespace_5da6b440::function_62616b71, "Intro", &namespace_5da6b440::function_19a68bdb);
    skipto::add("exterior", &namespace_5da6b440::function_d43e5685, "Exterior", &namespace_5da6b440::function_91e8545f);
    skipto::function_d68e678e("enter_lobby", &namespace_5da6b440::function_2c76d8aa, "Enter Lobby", &namespace_5da6b440::function_8903df94);
    skipto::function_d68e678e("discover_data", &namespace_9c567844::function_aa390943, "Discover Data", &namespace_9c567844::function_e59a6c89);
    skipto::function_d68e678e("aquarium_shimmy", &namespace_9c567844::function_17b49f2c, "Aquarium Shimmy", &namespace_9c567844::function_e28bb832);
    skipto::function_d68e678e("gen_lab", &namespace_9c567844::function_ab2e4091, "Genetics Lab", &namespace_9c567844::function_627360fb);
    skipto::function_d68e678e("post_gen_lab", &namespace_9c567844::function_d26cae1c, "Post Gen Lab", &namespace_9c567844::function_dcc3e542);
    skipto::function_d68e678e("chem_lab", &namespace_9c567844::function_f6774f56, "Chemical Lab", &namespace_9c567844::function_79f1dc0);
    skipto::function_d68e678e("post_chem_lab", &namespace_9c567844::function_4843e971, "Post Chem Lab", &namespace_9c567844::function_ff8909db);
    skipto::function_d68e678e("silo_floor", &namespace_9c567844::function_6926cd7f, "Silo Floor Battle", &namespace_9c567844::function_e3f81a25);
    skipto::function_d68e678e("under_silo", &namespace_9c567844::function_77964ef1, "Under Silo", &namespace_9c567844::function_2edb6f5b);
    skipto::function_d68e678e("fallen_soldiers", &namespace_ed09da6e::function_73eb52a7, "Fallen Soldiers", &namespace_ed09da6e::function_51f4af5d);
    skipto::function_d68e678e("testing_lab_igc", &namespace_a5e80dc::function_74581061, "Human Testing Lab", &namespace_a5e80dc::function_bfad6ceb);
    skipto::function_d68e678e("dark_battle", &namespace_4c73eafb::function_32dc1c24, "Dark Battle", &namespace_4c73eafb::function_bbb54b1a);
    skipto::function_d68e678e("charging_station", &namespace_4c73eafb::function_5f76850f, "Charging Station", &namespace_4c73eafb::function_9724b9d5);
    skipto::function_d68e678e("descent", &namespace_646f304f::function_1a420bcd, "Descent", &namespace_646f304f::function_d15424d7);
    skipto::add("pallas_start", &namespace_646f304f::function_1f2baf43, "pallas start", &namespace_646f304f::function_5a8d1289);
    skipto::add("pallas_end", &namespace_646f304f::function_bf36708e, "Pallas Death", &namespace_646f304f::function_e3c54b48);
    skipto::function_d68e678e("twin_revenge", &namespace_19d629e::function_cc756659, "Twin Revenge", &namespace_19d629e::function_b2f95c13);
    skipto::function_d68e678e("flood_combat", &namespace_caee6f4a::function_37c559db, "Flood Combat", &namespace_caee6f4a::function_ebe27bf1);
    skipto::function_d68e678e("flood_defend", &namespace_caee6f4a::function_ba34fbda, "Flood Defend", &namespace_caee6f4a::function_e2a342e4);
    skipto::function_d68e678e("underwater_battle", &namespace_b1c45cf3::function_297ca3c6, "Underwater Battle", &namespace_b1c45cf3::function_ceb4ae50);
    skipto::function_d68e678e("underwater_rail", &namespace_bfe2abac::function_b2f17f19, "Underwater Rail", &namespace_bfe2abac::function_88fd81d3);
    skipto::function_d68e678e("silo_swim", &namespace_da397ec0::function_d64c7d65, "Silo Swim", &namespace_da397ec0::function_9670e43f);
    skipto::add_dev("dev_flood_combat", &namespace_caee6f4a::function_37c559db, "Flood Combat", &namespace_caee6f4a::function_ebe27bf1);
}

// Namespace namespace_fa13d4ba
// Params 0, eflags: 0x1 linked
// namespace_fa13d4ba<file_0>::function_f7046c76
// Checksum 0x4682d5ef, Offset: 0x24c0
// Size: 0x1de
function precache() {
    level._effect["current_effect"] = "debris/fx_debris_underwater_current_sgen_os";
    level._effect["decon_mist"] = "steam/fx_steam_decon_fill_elevator_sgen";
    level._effect["drone_breadcrumb"] = "light/fx_temp_glow_cookie_crumb_sgen";
    level._effect["drone_sparks"] = "destruct/fx_dest_drone_mapper";
    level._effect["red_flare"] = "light/fx_light_emergency_flare_red";
    level._effect["water_spout"] = "water/fx_water_leak_torrent_md";
    level._effect["coolant_fx"] = "fog/fx_fog_coolant_jet_pallas_sgen";
    level._effect["fake_depth_charge_explosion"] = "explosions/fx_exp_underwater_depth_charge";
    level._effect["tidal_wave"] = "water/fx_temp_water_tidal_wave_sgen";
    level._effect["drone_splash"] = "water/fx_water_splash_25v25";
    level._effect["rock_explosion"] = "explosions/fx_exp_generic_lg";
    level._effect["coolant_tower_unleash"] = "fog/fx_fog_coolant_release_column_sgen";
    level._effect["coolant_tower_damage_minor"] = "fog/fx_fog_coolant_leak_md";
    level._effect["coolant_tower_damage_major"] = "fog/fx_fog_coolant_leak_lg";
    level._effect["depth_charge_explosion"] = "explosions/fx_exp_underwater_depth_charge";
    level._effect["underwater_flare"] = "light/fx_light_flare_ground_sgen";
    level._effect["weakspot_impact"] = "impacts/fx_bul_impact_metal_tower_core_sgen";
}

// Namespace namespace_fa13d4ba
// Params 0, eflags: 0x1 linked
// namespace_fa13d4ba<file_0>::function_2ea898a8
// Checksum 0x262b52e8, Offset: 0x26a8
// Size: 0x8f4
function init_clientfields() {
    clientfield::register("world", "w_fxa_truck_flip", 1, 1, "int");
    clientfield::register("world", "w_robot_window_break", 1, 2, "int");
    clientfield::register("world", "silo_swim_bridge_fall", 1, 1, "int");
    clientfield::register("world", "testing_lab_wires", 1, 1, "int");
    clientfield::register("world", "w_underwater_state", 1, 1, "int");
    clientfield::register("world", "w_flood_combat_windows_b", 1, 1, "int");
    clientfield::register("world", "w_flood_combat_windows_c", 1, 1, "int");
    clientfield::register("world", "elevator_light_probe", 1, 1, "int");
    clientfield::register("world", "flood_defend_hallway_flood_siege", 1, 1, "int");
    clientfield::register("world", "tower_chunks1", 1, 1, "int");
    clientfield::register("world", "tower_chunks2", 1, 1, "int");
    clientfield::register("world", "tower_chunks3", 1, 1, "int");
    clientfield::register("world", "observation_deck_destroy", 1, 1, "counter");
    clientfield::register("world", "fallen_soldiers_client_fxanims", 1, 1, "int");
    clientfield::register("world", "w_flyover_buoys", 1, 1, "int");
    clientfield::register("world", "w_twin_igc_fxanim", 1, 2, "int");
    clientfield::register("world", "set_exposure_bank", 1, 1, "int");
    clientfield::register("world", "silo_debris", 1, 3, "int");
    clientfield::register("world", "ceiling_collapse", 1, 3, "int");
    clientfield::register("world", "debris_catwalk", 1, 1, "counter");
    clientfield::register("world", "debris_wall", 1, 1, "counter");
    clientfield::register("world", "debris_fall", 1, 1, "counter");
    clientfield::register("world", "debris_bridge", 1, 1, "counter");
    clientfield::register("scriptmover", "structural_weakness", 1, 1, "int");
    clientfield::register("scriptmover", "sm_elevator_door_state", 1, 2, "int");
    clientfield::register("scriptmover", "sm_elevator_shader", 1, 2, "int");
    clientfield::register("scriptmover", "weakpoint", 1, 1, "int");
    clientfield::register("scriptmover", "sm_depth_charge_fx", 1, 2, "int");
    clientfield::register("scriptmover", "dni_eye", 1, 1, "int");
    clientfield::register("scriptmover", "turn_fake_robot_eye", 1, 1, "int");
    clientfield::register("scriptmover", "play_cia_robot_rogue_control", 1, 1, "int");
    clientfield::register("scriptmover", "cooling_tower_damage", 1, 1, "int");
    clientfield::register("toplayer", "pallas_monitors_state", 1, getminbitcountfornum(3), "int");
    clientfield::register("toplayer", "tp_water_sheeting", 1, 1, "int");
    clientfield::register("toplayer", "oed_interference", 1, 1, "int");
    clientfield::register("toplayer", "sndSiloBG", 1, 1, "int");
    clientfield::register("toplayer", "dust_motes", 1, 1, "int");
    clientfield::register("toplayer", "water_motes", 1, 1, "int");
    clientfield::register("toplayer", "water_teleport", 1, 1, "int");
    clientfield::register("vehicle", "extra_cam_ent", 1, 2, "int");
    clientfield::register("vehicle", "sm_depth_charge_fx", 1, 2, "int");
    clientfield::register("vehicle", "quad_tank_tac_mode", 1, 1, "int");
    clientfield::register("actor", "robot_bubbles", 1, 1, "int");
    clientfield::register("actor", "disable_tmode", 1, 1, "int");
    clientfield::register("actor", "sndStepSet", 1, 1, "int");
    clientfield::register("world", "sndLabWalla", 1, 1, "int");
    visionset_mgr::register_info("overlay", "earthquake_blur", 1, 50, 1, 1, &visionset_mgr::timeout_lerp_thread_per_player, 0);
}

// Namespace namespace_fa13d4ba
// Params 0, eflags: 0x1 linked
// namespace_fa13d4ba<file_0>::function_37af8a07
// Checksum 0x9b2c5e53, Offset: 0x2fa8
// Size: 0xbac
function init_flags() {
    util::function_ab12ef82("start_level");
    load::function_73adcefc();
    level flag::init("important_vo_playing");
    level flag::init("exterior_start_patrol");
    level flag::init("hendricks_on_hill");
    level flag::init("start_vehicle_patrols");
    level flag::init("intro_igc_done");
    level flag::init("hendricks_intro_done");
    level flag::init("player_has_silenced_weap");
    level flag::init("start_technical");
    level flag::init("intro_truck_arrived");
    level flag::init("fallback_to_qt");
    level flag::init("hendricks_qt_reveal");
    level flag::init("intro_quadtank_dead");
    level flag::init("quad_tank_nag_vo_playing");
    level flag::init("quad_tank_trophy_system_destroyed");
    level flag::init("enemy_alerting_area");
    level flag::init("hendricks_at_lobby_idle");
    level flag::init("lobby_door_opening");
    level flag::init("lobby_door_opened");
    level flag::init("silo_door_opened");
    level flag::init("data_discovered");
    level flag::init("data_recovered");
    level flag::init("hendricks_move_to_under_fan");
    level flag::init("hendricks_corvus_examination");
    level flag::init("corvus_entrance_hendrick_idle_trigger");
    level flag::init("chem_door_open");
    level flag::init("player_raise_hendricks_player_ready");
    level flag::init("player_raise_hendricks_hendricks_ready");
    level flag::init("spawn_quadtank_reinforcements");
    level flag::init("start_hendricks_move_up_battle_1");
    level flag::init("start_hendricks_move_up_battle_2");
    level flag::init("gen_lab_cleared");
    level flag::init("hendricks_at_gen_lab_door");
    level flag::init("gen_lab_door_opened");
    level flag::init("bridge_collapse_safe");
    level flag::init("hendricks_door_line");
    level flag::init("spawn_quad_tank");
    level flag::init("enable_battle_volumes");
    level flag::init("pre_gen_lab_vo_done");
    level flag::init("qtank_fight_completed");
    level flag::init("mappy_path_active");
    level flag::init("hendricks_data_anim_done");
    level flag::init("hendricks_at_silo_doors");
    level flag::init("gen_lab_gone_hot");
    level flag::init("bridge_debris_player_kill");
    level flag::init("chem_lab_hendricks_movein_done");
    level flag::init("start_silo_ambush");
    level flag::init("start_floor_risers");
    level flag::init("all_players_outside_chem_lab");
    level flag::init("gen_lab_pip_off");
    level flag::init("exterior_gone_hot");
    level flag::init("hendricks_in_cqb");
    level flag::init("hendricks_in_gen_lab");
    level flag::init("drone_over_grate");
    level flag::init("drone_over_grate_real");
    level flag::init("drone_died");
    level flag::init("kane_data_callout");
    level flag::init("weapons_research_vo_start");
    level flag::init("weapons_research_vo_done");
    level flag::init("highlight_railing_glass");
    level flag::init("glass_railing_kicked");
    level flag::init("spawn_silo_robots");
    level flag::init("drone_silo_anim_done");
    level flag::init("drone_scanning");
    level flag::init("hendricks_at_silo_floor");
    level flag::init("send_drone_over_grate");
    level flag::init("silo_floor_cleared");
    level flag::init("silo_grate_open");
    level flag::init("pallas_intro_completed");
    level flag::init("pallas_start");
    level flag::init("pallas_end");
    level flag::init("core_two_destroyed");
    level flag::init("hendricks_attacked_done");
    level flag::init("tower_three_destroyed");
    level flag::init("dark_battle_hendricks_above");
    level flag::init("dark_battle_hendricks_ambush");
    level flag::init("pallas_ambush_over");
    level flag::init("fallen_soldiers_hendricks_ready");
    level flag::init("pallas_lift_front_open");
    level flag::init("pallas_lift_back_open");
    level flag::init("pallas_death");
    level flag::init("bridge_hit_1");
    level flag::init("bridge_hit_2");
    level flag::init("optics_out");
    level flag::init("defend_ready");
    level flag::init("hendricks_door_open");
    level flag::init("water_robot_spawned");
    level flag::init("pod_robot_spawned");
    level flag::init("depth_charges_cleared");
    level flag::init("player_raise_hendricks_hendricks");
    level flag::init("silo_swim_bridge_collapse");
    level flag::init("silo_swim_take_out");
    level flag::init("sgen_end_igc");
}

// Namespace namespace_fa13d4ba
// Params 0, eflags: 0x1 linked
// namespace_fa13d4ba<file_0>::function_4b0856b
// Checksum 0x412e7781, Offset: 0x3b60
// Size: 0x1a4
function function_4b0856b() {
    var_c3938a0d = getentarray("t_mover", "targetname");
    array::thread_all(var_c3938a0d, &namespace_cba4cc55::function_588a8011);
    var_66f34b09 = getentarray("enhanced_vision_on", "targetname");
    var_9e2795b5 = getentarray("enhanced_vision_off", "targetname");
    array::thread_all(var_66f34b09, &function_5dd1ccff, 1);
    array::thread_all(var_9e2795b5, &function_5dd1ccff, 0);
    var_2068ca6f = getentarray("water_movement_trigger", "targetname");
    array::thread_all(var_2068ca6f, &function_db43be1e);
    level thread function_ec9fa3fe();
    level thread function_d481b315();
    level thread function_dedf5ad3();
    level thread function_3fbd8c78();
}

// Namespace namespace_fa13d4ba
// Params 1, eflags: 0x1 linked
// namespace_fa13d4ba<file_0>::function_bff1a867
// Checksum 0x822476b7, Offset: 0x3d10
// Size: 0xcc
function function_bff1a867(str_objective) {
    if (str_objective == "intro" || str_objective == "exterior" || str_objective == "enter_lobby" || str_objective == "discover_data") {
        level.var_2fd26037 = util::function_740f8516("hendricks_backpack");
    } else {
        level.var_2fd26037 = util::function_740f8516("hendricks");
    }
    if (!issubstr(level.var_31aefea8, "dev_flood_combat")) {
        skipto::teleport_ai(str_objective);
    }
}

// Namespace namespace_fa13d4ba
// Params 0, eflags: 0x1 linked
// namespace_fa13d4ba<file_0>::function_3fbd8c78
// Checksum 0x77bca04b, Offset: 0x3de8
// Size: 0x304
function function_3fbd8c78() {
    for (x = 2; x < 4; x++) {
        scene::add_scene_func("cin_sgen_15_04_robot_ambush_aie_arise_robot0" + x, &function_ff4dec72, "init");
        scene::add_scene_func("cin_sgen_15_04_robot_ambush_aie_arise_robot0" + x, &function_e860d344, "play");
    }
    for (x = 1; x < 5; x++) {
        scene::add_scene_func("cin_sgen_13_01_robots_awaken_aie_awake_robot0" + x, &function_ff4dec72, "init");
        scene::add_scene_func("cin_sgen_13_01_robots_awaken_aie_awake_robot0" + x, &function_e860d344, "play");
    }
    for (x = 1; x < 5; x++) {
        scene::add_scene_func("cin_sgen_12_02_corvus_vign_wakeup_rail_robot_0" + x, &function_ff4dec72, "init");
        scene::add_scene_func("cin_sgen_12_02_corvus_vign_wakeup_rail_robot_0" + x, &function_e860d344, "play");
    }
    scene::add_scene_func("cin_sgen_16_01_charging_station_aie_idle_robot01", &function_ff4dec72, "init");
    scene::add_scene_func("cin_sgen_16_01_charging_station_aie_idle_robot01", &function_ff4dec72, "play");
    scene::add_scene_func("cin_sgen_16_01_charging_station_aie_fail_robot01", &function_ff4dec72, "init");
    scene::add_scene_func("cin_sgen_16_01_charging_station_aie_fail_robot01", &function_ff4dec72, "play");
    for (x = 1; x < 7; x++) {
        scene::add_scene_func("cin_sgen_16_01_charging_station_aie_awaken_robot0" + x, &function_e860d344, "play");
    }
    scene::add_scene_func("cin_sgen_16_01_charging_station_aie_awaken_robot05_jumpdown", &function_e860d344, "play");
}

// Namespace namespace_fa13d4ba
// Params 0, eflags: 0x0
// namespace_fa13d4ba<file_0>::function_aba4c411
// Checksum 0x9ab3b3, Offset: 0x40f8
// Size: 0xc2
function function_aba4c411() {
    var_1e8741a8 = getentarray("diaz_tower_1", "targetname");
    foreach (pillar in var_1e8741a8) {
        pillar movez(106, 0.05);
    }
}

// Namespace namespace_fa13d4ba
// Params 0, eflags: 0x1 linked
// namespace_fa13d4ba<file_0>::function_aebcf025
// Checksum 0x2886601a, Offset: 0x41c8
// Size: 0x44
function on_player_spawned() {
    if (level flag::get("optics_out")) {
        level thread function_5dd1ccff(0, 0, self);
    }
}

// Namespace namespace_fa13d4ba
// Params 0, eflags: 0x1 linked
// namespace_fa13d4ba<file_0>::function_ec9fa3fe
// Checksum 0x2920af6d, Offset: 0x4218
// Size: 0xdc
function function_ec9fa3fe() {
    level flag::wait_till("silo_grate_open");
    a_blockers = getentarray("silo_floor_clip", "targetname");
    array::run_all(a_blockers, &delete);
    level flag::wait_till("silo_swim");
    a_blockers = getentarray("silo_grate", "targetname");
    array::run_all(a_blockers, &delete);
}

// Namespace namespace_fa13d4ba
// Params 0, eflags: 0x0
// namespace_fa13d4ba<file_0>::function_7a4e1da3
// Checksum 0xfc5af39d, Offset: 0x4300
// Size: 0xbc
function function_7a4e1da3() {
    if (isdefined(self.lastactiveweapon) && self.lastactiveweapon != level.weaponnone && self hasweapon(self.lastactiveweapon)) {
        self switchtoweapon(self.lastactiveweapon);
        return;
    }
    primaryweapons = self getweaponslistprimaries();
    if (isdefined(primaryweapons) && primaryweapons.size > 0) {
        self switchtoweapon(primaryweapons[0]);
    }
}

// Namespace namespace_fa13d4ba
// Params 3, eflags: 0x1 linked
// namespace_fa13d4ba<file_0>::function_5dd1ccff
// Checksum 0xd2a2027, Offset: 0x43c8
// Size: 0x2aa
function function_5dd1ccff(b_enable, var_5b1ec2c2, e_player) {
    if (!isdefined(var_5b1ec2c2)) {
        var_5b1ec2c2 = 1;
    }
    level endon(#"hash_6a9c5cb5");
    while (true) {
        if (var_5b1ec2c2) {
            e_player = self waittill(#"trigger");
        }
        if (!isdefined(e_player.var_1e983b11)) {
            e_player.var_1e983b11 = level.var_1e983b11;
        }
        var_154f55d0 = e_player.var_1e983b11;
        if (!b_enable) {
            level flag::set("optics_out");
            e_player oed::function_fc1750c9(0);
            e_player oed::enable_ev(0);
            if (isdefined(e_player.cybercom.var_301030f7) && e_player.cybercom.var_301030f7) {
                e_player player::take_weapons();
                e_player player::give_back_weapons();
            }
            e_player cybercom::function_6c141a2d();
            e_player cybercom_tacrig::function_ccca7010("cybercom_playermovement");
            if (b_enable != var_154f55d0) {
                util::function_964b7eb7(e_player, %CP_MI_SING_SGEN_VISION_INTERFERENCE);
            }
        } else {
            level flag::clear("optics_out");
            e_player oed::function_fc1750c9(1);
            e_player oed::enable_ev(1);
            e_player cybercom::function_e60e89fe();
            var_11f40d11 = e_player cybercom::function_cc812e3b("cybercom_playermovement");
            e_player cybercom_tacrig::function_8ffa26e2("cybercom_playermovement", var_11f40d11);
            if (b_enable != var_154f55d0) {
                util::function_964b7eb7(e_player, %CP_MI_SING_SGEN_VISION_RESTORED);
            }
        }
        if (!var_5b1ec2c2) {
            return;
        }
    }
}

// Namespace namespace_fa13d4ba
// Params 1, eflags: 0x1 linked
// namespace_fa13d4ba<file_0>::function_ff4dec72
// Checksum 0xa3bcd7fb, Offset: 0x4680
// Size: 0x8c
function function_ff4dec72(a_ents) {
    if (isai(self)) {
        self.ignoreme = 1;
        self oed::disable_thermal();
        self disableaimassist();
    }
    if (isdefined(a_ents)) {
        array::thread_all(a_ents, &function_ff4dec72);
    }
}

// Namespace namespace_fa13d4ba
// Params 1, eflags: 0x1 linked
// namespace_fa13d4ba<file_0>::function_e860d344
// Checksum 0x480edda1, Offset: 0x4718
// Size: 0x84
function function_e860d344(a_ents) {
    if (isai(self)) {
        self.ignoreme = 0;
        self oed::enable_thermal();
        self enableaimassist();
    }
    if (isdefined(a_ents)) {
        array::thread_all(a_ents, &function_e860d344);
    }
}

// Namespace namespace_fa13d4ba
// Params 0, eflags: 0x1 linked
// namespace_fa13d4ba<file_0>::function_db43be1e
// Checksum 0x31aeba40, Offset: 0x47a8
// Size: 0x68
function function_db43be1e() {
    while (true) {
        e_player = self waittill(#"trigger");
        if (!(isdefined(e_player.is_in_water) && e_player.is_in_water)) {
            self thread function_8084e40a(e_player);
        }
    }
}

// Namespace namespace_fa13d4ba
// Params 1, eflags: 0x1 linked
// namespace_fa13d4ba<file_0>::function_8084e40a
// Checksum 0xfdee393c, Offset: 0x4818
// Size: 0xd4
function function_8084e40a(e_player) {
    e_player endon(#"death");
    self endon(#"death");
    e_player.is_in_water = 1;
    e_player setmovespeedscale(0.7);
    e_player allowprone(0);
    while (e_player istouching(self)) {
        wait(0.1);
    }
    e_player allowprone(1);
    e_player setmovespeedscale(1);
    e_player.is_in_water = 0;
}

// Namespace namespace_fa13d4ba
// Params 0, eflags: 0x1 linked
// namespace_fa13d4ba<file_0>::function_d481b315
// Checksum 0xda651ceb, Offset: 0x48f8
// Size: 0x54
function function_d481b315() {
    var_15849db9 = getentarray("silo_rock_slide", "targetname");
    array::run_all(var_15849db9, &setscale, 2);
}

// Namespace namespace_fa13d4ba
// Params 2, eflags: 0x0
// namespace_fa13d4ba<file_0>::function_1f0515fa
// Checksum 0xa4343cd0, Offset: 0x4958
// Size: 0x104
function function_1f0515fa(str_name, n_index) {
    if (!isdefined(n_index)) {
        n_index = 0;
    }
    var_19aeddfe = struct::get_array(str_name, "targetname");
    s_align = spawnstruct();
    s_align.origin = var_19aeddfe[n_index].origin;
    s_align.angles = var_19aeddfe[n_index].angles;
    s_align.targetname = str_name + "_script";
    level.struct_class_names["targetname"][str_name + "_script"] = array(s_align);
}

// Namespace namespace_fa13d4ba
// Params 0, eflags: 0x1 linked
// namespace_fa13d4ba<file_0>::function_dedf5ad3
// Checksum 0x4feccb5f, Offset: 0x4a68
// Size: 0x7c
function function_dedf5ad3() {
    e_door_clip = getent("flood_door_player_clip", "targetname");
    e_door_clip movez(-128, 0.05);
    level thread namespace_cba4cc55::set_door_state("surgical_room_entrance_door", "open");
}

