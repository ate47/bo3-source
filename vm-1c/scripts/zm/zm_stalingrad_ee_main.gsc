#using scripts/zm/zm_stalingrad_vo;
#using scripts/zm/zm_stalingrad_util;
#using scripts/zm/zm_stalingrad_timer;
#using scripts/zm/zm_stalingrad_pap_quest;
#using scripts/zm/zm_stalingrad_drop_pods;
#using scripts/zm/zm_stalingrad_dragon;
#using scripts/zm/_zm_zonemgr;
#using scripts/zm/_zm_weapons;
#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_unitrigger;
#using scripts/zm/_zm_stats;
#using scripts/zm/_zm_spawner;
#using scripts/zm/_zm_perks;
#using scripts/zm/_zm_magicbox;
#using scripts/zm/_zm_ai_sentinel_drone;
#using scripts/zm/_zm_ai_raz;
#using scripts/shared/vehicles/_sentinel_drone;
#using scripts/shared/ai/zombie_utility;
#using scripts/shared/vehicle_ai_shared;
#using scripts/shared/vehicle_shared;
#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/scoreevents_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/math_shared;
#using scripts/shared/lui_shared;
#using scripts/shared/hud_util_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/array_shared;
#using scripts/shared/ai_shared;
#using scripts/codescripts/struct;

#namespace namespace_c5d72679;

// Namespace namespace_c5d72679
// Params 0, eflags: 0x2
// namespace_c5d72679<file_0>::function_2dc19561
// Checksum 0xfde696e1, Offset: 0x27e0
// Size: 0x3c
function autoexec function_2dc19561() {
    system::register("zm_stalingrad_ee_main", &__init__, &__main__, undefined);
}

// Namespace namespace_c5d72679
// Params 0, eflags: 0x1 linked
// namespace_c5d72679<file_0>::function_8c87d8eb
// Checksum 0x5adfba35, Offset: 0x2828
// Size: 0x554
function __init__() {
    clientfield::register("scriptmover", "ee_anomaly_hit", 12000, 1, "counter");
    clientfield::register("scriptmover", "ee_anomaly_loop", 12000, 1, "int");
    clientfield::register("scriptmover", "ee_cargo_explosion", 12000, 1, "int");
    clientfield::register("vehicle", "ee_drone_cam_override", 12000, 1, "int");
    clientfield::register("scriptmover", "ee_generator_kill", 12000, 1, "int");
    clientfield::register("scriptmover", "ee_generator_target", 12000, 1, "int");
    clientfield::register("scriptmover", "ee_koth_light_1", 12000, 2, "int");
    clientfield::register("scriptmover", "ee_koth_light_2", 12000, 2, "int");
    clientfield::register("scriptmover", "ee_koth_light_3", 12000, 2, "int");
    clientfield::register("scriptmover", "ee_koth_light_4", 12000, 2, "int");
    clientfield::register("toplayer", "ee_lockdown_fog", 12000, 1, "int");
    clientfield::register("actor", "ee_raz_eye_override", 12000, 1, "int");
    clientfield::register("scriptmover", "ee_sewer_switch", 12000, 1, "int");
    clientfield::register("world", "ee_eye_beam_rumble", 12000, 1, "int");
    clientfield::register("toplayer", "ee_hatch_strain_rumble", 12000, 1, "int");
    clientfield::register("scriptmover", "ee_hatch_break_rumble", 12000, 1, "int");
    clientfield::register("scriptmover", "ee_safe_smash_rumble", 12000, 1, "int");
    clientfield::register("scriptmover", "ee_timed_explosion_rumble", 12000, 1, "counter");
    clientfield::register("scriptmover", "post_outro_smoke", 12000, 1, "int");
    level flag::init("generator_charged");
    level flag::init("generator_on");
    level flag::init("tube_puzzle_complete");
    level flag::init("ee_cylinder_acquired");
    level flag::init("key_placement");
    level flag::init("keys_placed");
    level flag::init("scenario_active");
    level flag::init("ee_cargo_available");
    level flag::init("ee_lockdown_complete");
    level flag::init("scenarios_complete");
    level flag::init("weapon_cores_delivered");
    level flag::init("sophia_escaped");
    level flag::init("players_in_arena");
    level flag::init("ee_round");
}

// Namespace namespace_c5d72679
// Params 0, eflags: 0x1 linked
// namespace_c5d72679<file_0>::function_5b6b9132
// Checksum 0x762fe39c, Offset: 0x2d88
// Size: 0x19c
function __main__() {
    /#
        if (getdvarint("vehicle") > 0) {
            level thread function_d6026710();
        }
        level scene::add_scene_func("vehicle", &function_7e02b332, "vehicle", 0);
        level scene::add_scene_func("vehicle", &function_7e02b332, "vehicle", 1);
    #/
    array::add(level.wait_for_streamer_hint_scenes, "cin_sta_outro_3rd_sh020", 0);
    level thread function_c5f1b67();
    level thread function_7cde9a31();
    level thread function_999a19a7();
    level thread function_9bab94c2();
    level thread function_8d296a92();
    level thread function_72dd3113();
    level thread function_914bd2ef();
    level thread function_e0c4c3a8();
    level thread function_d47c68fb();
}

// Namespace namespace_c5d72679
// Params 0, eflags: 0x1 linked
// namespace_c5d72679<file_0>::function_c5f1b67
// Checksum 0x60bff14f, Offset: 0x2f30
// Size: 0x40c
function function_c5f1b67() {
    var_1a085458 = getentarray("hatch_slick_clip", "targetname");
    array::run_all(var_1a085458, &notsolid);
    mdl_map = getent("ee_map", "targetname");
    mdl_map hidepart("tag_map_screen_on");
    mdl_map hidepart("tag_map_screen_glow_text");
    mdl_map hidepart("tag_map_screen_glow_command");
    mdl_map hidepart("tag_map_screen_glow_barracks");
    mdl_map hidepart("tag_map_screen_glow_tank");
    mdl_map hidepart("tag_map_screen_glow_armory");
    mdl_map hidepart("tag_map_screen_glow_store");
    mdl_map hidepart("tag_map_screen_glow_supply");
    mdl_map hidepart("tag_map_screen_glow_square");
    var_78d02c88 = getent("ee_map_shelf", "targetname");
    var_78d02c88 hidepart("wall_map_shelf_button_green");
    var_78d02c88 hidepart("wall_map_shelf_figure_01");
    var_78d02c88 hidepart("wall_map_shelf_figure_02");
    var_78d02c88 hidepart("wall_map_shelf_figure_03");
    var_78d02c88 hidepart("wall_map_shelf_figure_04");
    var_78d02c88 hidepart("wall_map_shelf_figure_05");
    var_78d02c88 hidepart("wall_map_shelf_figure_06");
    var_dc6bf246 = getent("ee_koth_terminal", "targetname");
    var_dc6bf246 function_9906da8b(0);
    var_dc6bf246 hidepart("tag_dragon_network_console_terminal_light_green_01");
    var_dc6bf246 hidepart("tag_dragon_network_console_terminal_light_green_02");
    var_dc6bf246 hidepart("tag_dragon_network_console_terminal_light_green_03");
    var_dc6bf246 hidepart("tag_dragon_network_console_terminal_light_green_04");
    while (!isdefined(level.var_a090a655)) {
        wait(2);
        level.var_a090a655 = getent("computer_sophia", "targetname");
    }
    level.var_a090a655 hidepart("slot_decoder_jnt");
    level.var_a090a655 hidepart("button_green_jnt");
    level.var_a090a655 scene::init("p7_fxanim_zm_stal_computer_sophia_code_door_open_bundle");
}

// Namespace namespace_c5d72679
// Params 0, eflags: 0x1 linked
// namespace_c5d72679<file_0>::function_7cde9a31
// Checksum 0x89b698e0, Offset: 0x3348
// Size: 0xbc
function function_7cde9a31() {
    level flag::wait_till("power_on");
    exploder::exploder("fxexp_604");
    mdl_map = getent("ee_map", "targetname");
    mdl_map showpart("tag_map_screen_on");
    level waittill(#"hash_423907c1");
    level thread function_b81d4eec();
    level thread function_3bd05213();
}

// Namespace namespace_c5d72679
// Params 0, eflags: 0x1 linked
// namespace_c5d72679<file_0>::function_b81d4eec
// Checksum 0xef18bdcc, Offset: 0x3410
// Size: 0xd4
function function_b81d4eec() {
    /#
        level endon(#"hash_72a2fa02");
        level endon(#"hash_7f7ecb53");
        level endon(#"hash_dae10c73");
    #/
    level endon(#"hash_cf9f9beb");
    level function_fa7fbd4c(1);
    var_2200eb08 = struct::get("ee_sophia_struct", "targetname");
    e_player = var_2200eb08 function_6e3a6092(100, "", 0);
    e_player thread namespace_dcf9c464::function_1f1e411c();
    level function_fa7fbd4c(0);
}

// Namespace namespace_c5d72679
// Params 0, eflags: 0x1 linked
// namespace_c5d72679<file_0>::function_3bd05213
// Checksum 0x44c9da32, Offset: 0x34f0
// Size: 0x66
function function_3bd05213() {
    /#
        level endon(#"hash_72a2fa02");
        level endon(#"hash_7f7ecb53");
        level endon(#"hash_dae10c73");
    #/
    level.var_2de93bbe = 1;
    level waittill(#"hash_59601179");
    wait(10);
    level namespace_dcf9c464::function_19d97b43();
    level.var_2de93bbe = undefined;
}

// Namespace namespace_c5d72679
// Params 3, eflags: 0x1 linked
// namespace_c5d72679<file_0>::function_cbc0e672
// Checksum 0x9cc784b0, Offset: 0x3560
// Size: 0x46
function function_cbc0e672(str_vo_line, n_delay, str_notify) {
    self namespace_dcf9c464::function_e4acaa37(str_vo_line, n_delay);
    level notify(str_notify);
}

// Namespace namespace_c5d72679
// Params 0, eflags: 0x1 linked
// namespace_c5d72679<file_0>::function_dbdd2358
// Checksum 0xee9f02f7, Offset: 0x35b0
// Size: 0x120
function function_dbdd2358() {
    /#
        level endon(#"hash_72a2fa02");
        level endon(#"hash_7f7ecb53");
        level endon(#"hash_dae10c73");
    #/
    level endon(#"hash_43e9e96f");
    var_1f76714 = [];
    for (i = 0; i < 5; i++) {
        var_1f76714[i] = "vox_soph_general_misc_" + i;
    }
    for (var_907901e8 = 0; var_907901e8 < 5; var_907901e8++) {
        wait(50);
        level function_9c8afe2b();
        str_notify = "sophia_general_complete";
        level.var_a090a655 thread function_cbc0e672(var_1f76714[var_907901e8], 1, str_notify);
        level waittill(str_notify);
    }
}

// Namespace namespace_c5d72679
// Params 0, eflags: 0x1 linked
// namespace_c5d72679<file_0>::function_851880c
// Checksum 0xd7699082, Offset: 0x36d8
// Size: 0x170
function function_851880c() {
    /#
        level endon(#"hash_7f7ecb53");
        level endon(#"hash_dae10c73");
    #/
    level endon(#"hash_8df52d90");
    var_f5badf05 = [];
    for (i = 0; i < 9; i++) {
        var_f5badf05[i] = "vox_soph_sophia_observes_" + i;
    }
    for (var_5dac1aa3 = 0; var_5dac1aa3 < 9; var_5dac1aa3++) {
        wait(50);
        while (level flag::get("scenario_active")) {
            level flag::wait_till_clear("scenario_active");
            wait(20);
        }
        level function_9c8afe2b();
        if (var_5dac1aa3 < 9) {
            str_notify = "sophia_observation_complete";
            level.var_a090a655 thread function_cbc0e672(var_f5badf05[var_5dac1aa3], 1, str_notify);
            level waittill(str_notify);
        }
    }
}

// Namespace namespace_c5d72679
// Params 0, eflags: 0x1 linked
// namespace_c5d72679<file_0>::function_811523a8
// Checksum 0xaccc8c0e, Offset: 0x3850
// Size: 0x1a8
function function_811523a8() {
    /#
        level endon(#"hash_7f7ecb53");
        level endon(#"hash_dae10c73");
    #/
    level endon(#"hash_e2166494");
    level waittill(#"hash_8df52d90");
    var_68a6b7a1 = [];
    for (i = 0; i < 6; i++) {
        var_68a6b7a1[i] = "vox_soph_richtofen_trust_" + i;
    }
    for (var_983c388b = 0; var_983c388b < 6; var_983c388b++) {
        wait(50);
        while (level flag::get("scenario_active")) {
            level flag::wait_till_clear("scenario_active");
            wait(20);
        }
        level function_eaf82313();
        if (var_983c388b < 6 && function_8d6e71cf() && math::cointoss()) {
            str_notify = "sophia_trust_complete";
            level.var_a090a655 thread function_cbc0e672(var_68a6b7a1[var_983c388b], 1, str_notify);
            level waittill(str_notify);
        }
    }
}

// Namespace namespace_c5d72679
// Params 0, eflags: 0x1 linked
// namespace_c5d72679<file_0>::function_8d6e71cf
// Checksum 0x476b0577, Offset: 0x3a00
// Size: 0xe6
function function_8d6e71cf() {
    if (!(isdefined(level.var_fe571972) && level.var_fe571972)) {
        return true;
    }
    foreach (e_player in level.activeplayers) {
        if (e_player.characterindex == 2 && zm_utility::is_player_valid(e_player) && !namespace_48c05c81::function_86b1188c(1000, e_player, level.var_a090a655)) {
            return true;
        }
    }
    return false;
}

// Namespace namespace_c5d72679
// Params 0, eflags: 0x1 linked
// namespace_c5d72679<file_0>::function_4b5f4145
// Checksum 0xab3f6b9d, Offset: 0x3af0
// Size: 0x120
function function_4b5f4145() {
    /#
        level endon(#"hash_dae10c73");
    #/
    level endon(#"hash_3516a741");
    var_1f76714 = array::randomize(array("vox_soph_sophia_chatter_0", "vox_soph_sophia_chatter_1", "vox_soph_sophia_chatter_2", "vox_soph_sophia_chatter_3", "vox_soph_sophia_chatter_4", "vox_soph_sophia_chatter_5"));
    for (var_907901e8 = 0; var_907901e8 < 6; var_907901e8++) {
        wait(50);
        level function_9c8afe2b();
        str_notify = "sophia_preparations_complete";
        level.var_a090a655 thread function_cbc0e672(var_1f76714[var_907901e8], 1, str_notify);
        level waittill(str_notify);
    }
}

// Namespace namespace_c5d72679
// Params 0, eflags: 0x1 linked
// namespace_c5d72679<file_0>::function_957ac17d
// Checksum 0xa4560c79, Offset: 0x3c18
// Size: 0x178
function function_957ac17d() {
    /#
        level endon(#"hash_dae10c73");
    #/
    level endon(#"hash_3516a741");
    var_1f76714 = array("vox_soph_help_nikolai_sophia_attempt_1_0", "vox_soph_help_nikolai_sophia_attempt_2_0", "vox_soph_help_nikolai_sophia_attempt_3_0", "vox_soph_help_nikolai_sophia_attempt_4_0", "vox_soph_help_nikolai_sophia_attempt_5_0", "vox_soph_help_nikolai_sophia_attempt_6_0");
    var_907901e8 = 0;
    var_af8a18df = struct::get("ee_sophia_struct", "targetname");
    while (var_907901e8 < 6) {
        level function_fa7fbd4c(1);
        e_who = var_af8a18df waittill(#"trigger_activated");
        level function_fa7fbd4c(0);
        e_who clientfield::increment_to_player("interact_rumble");
        str_notify = "sophia_leave_alone_complete";
        level.var_a090a655 thread function_cbc0e672(var_1f76714[var_907901e8], 1, str_notify);
        level waittill(str_notify);
        var_907901e8++;
    }
}

// Namespace namespace_c5d72679
// Params 0, eflags: 0x1 linked
// namespace_c5d72679<file_0>::function_999a19a7
// Checksum 0x565b6958, Offset: 0x3d98
// Size: 0xfc
function function_999a19a7() {
    level function_af4b355b();
    level function_8be3a840();
    level thread function_c78227f6();
    array::thread_all(level.var_57f8b6c5, &function_60619737);
    level flag::wait_till("tube_puzzle_complete");
    level thread function_830b8c18();
    level function_6a9560b6();
    level flag::set("ee_cylinder_acquired");
    level thread function_72d1d0bb();
}

// Namespace namespace_c5d72679
// Params 0, eflags: 0x1 linked
// namespace_c5d72679<file_0>::function_af4b355b
// Checksum 0x2dd1df1a, Offset: 0x3ea0
// Size: 0x3c4
function function_af4b355b() {
    level.var_57f8b6c5 = getentarray("ee_tube_terminal", "targetname");
    foreach (var_beb54dbd in level.var_57f8b6c5) {
        switch (var_beb54dbd.script_label) {
        case 102:
            var_beb54dbd.var_cd705a9 = array("library", "factory", "store");
            break;
        case 101:
            var_beb54dbd.var_cd705a9 = array("store", "factory", "command");
            break;
        case 100:
            var_beb54dbd.var_cd705a9 = array("library", "store", "barracks");
            break;
        case 98:
            var_beb54dbd.var_cd705a9 = array("barracks", "library", "armory");
            break;
        case 99:
            var_beb54dbd.var_cd705a9 = array("command", "armory", "factory");
            break;
        case 97:
            var_beb54dbd.var_cd705a9 = array("armory", "barracks", "command");
            break;
        }
    }
    level.var_57f8b6c5 = array::randomize(level.var_57f8b6c5);
    level.var_57f8b6c5[5] scene::init("p7_fxanim_zm_stal_pneumatic_tube_stuck_bundle");
    level.var_57f8b6c5[5] hidepart("tag_vacume_door");
    do {
        foreach (var_beb54dbd in level.var_57f8b6c5) {
            var_beb54dbd.var_1f3c0ca7 = randomint(3);
            var_beb54dbd.var_59c68a0b = 0;
            var_beb54dbd hidepart("tag_buttons_on");
            var_beb54dbd showpart("tag_buttons_off");
        }
    } while (function_797708de());
    array::run_all(level.var_57f8b6c5, &function_450d606e);
}

// Namespace namespace_c5d72679
// Params 0, eflags: 0x1 linked
// namespace_c5d72679<file_0>::function_450d606e
// Checksum 0xe2e74a9b, Offset: 0x4270
// Size: 0x150
function function_450d606e() {
    mdl_lever = getent(self.target, "targetname");
    v_origin = self gettagorigin("tag_lever");
    v_angles = self gettagangles("tag_lever");
    mdl_lever.origin = v_origin;
    mdl_lever.angles = v_angles;
    if (self.var_1f3c0ca7 == 0) {
        mdl_lever rotatepitch(-16, 0.1);
    } else if (self.var_1f3c0ca7 == 2) {
        mdl_lever rotatepitch(120, 0.1);
    }
    var_6403853b = function_d6953423(self.var_cd705a9[self.var_1f3c0ca7]);
    var_6403853b.var_59c68a0b++;
}

// Namespace namespace_c5d72679
// Params 0, eflags: 0x1 linked
// namespace_c5d72679<file_0>::function_8be3a840
// Checksum 0x35b5ee35, Offset: 0x43c8
// Size: 0x1a6
function function_8be3a840() {
    s_generator = struct::get("ee_generator", "targetname");
    s_generator.var_537b503a = util::spawn_model("tag_origin", s_generator.origin);
    s_generator.var_537b503a clientfield::set("ee_generator_target", 1);
    exploder::exploder("fxexp_702");
    zm_spawner::register_zombie_death_event_callback(&function_8b2dbe00);
    level flag::wait_till("generator_charged");
    zm_spawner::deregister_zombie_death_event_callback(&function_8b2dbe00);
    e_volume = getent("ee_generator_volume", "targetname");
    e_volume delete();
    s_generator.var_537b503a clientfield::set("ee_generator_target", 0);
    util::wait_network_frame();
    s_generator.var_537b503a delete();
    level.var_6d9026c9 = undefined;
}

// Namespace namespace_c5d72679
// Params 1, eflags: 0x1 linked
// namespace_c5d72679<file_0>::function_8b2dbe00
// Checksum 0xad191c20, Offset: 0x4578
// Size: 0xb4
function function_8b2dbe00(e_attacker) {
    e_volume = getent("ee_generator_volume", "targetname");
    if (isdefined(self) && self.archetype === "sentinel_drone" && self istouching(e_volume)) {
        level thread function_1761de01(self gettagorigin("tag_origin_animate"), self gettagangles("tag_origin_animate"));
    }
}

// Namespace namespace_c5d72679
// Params 2, eflags: 0x1 linked
// namespace_c5d72679<file_0>::function_1761de01
// Checksum 0x2cd21617, Offset: 0x4638
// Size: 0xa4
function function_1761de01(var_ebb69637, var_2a65eda2) {
    var_7e52585c = util::spawn_model("tag_origin", var_ebb69637, var_2a65eda2);
    var_7e52585c clientfield::set("ee_generator_kill", 1);
    wait(2);
    var_7e52585c delete();
    level flag::set("generator_charged");
}

// Namespace namespace_c5d72679
// Params 0, eflags: 0x1 linked
// namespace_c5d72679<file_0>::function_c78227f6
// Checksum 0xb4f15dc7, Offset: 0x46e8
// Size: 0x230
function function_c78227f6() {
    level endon(#"hash_59d55c4");
    s_generator = struct::get("ee_generator", "targetname");
    s_generator.var_efb73168 = 0;
    s_generator zm_unitrigger::create_unitrigger("", 100, &function_a5764a2e);
    var_c1a6445a = getent("generator_tarp", "targetname");
    while (true) {
        level flag::set("generator_on");
        level thread scene::play("p7_fxanim_zm_stal_generator_start_tarp_bundle");
        exploder::stop_exploder("fxexp_702");
        level function_ef39c304(1);
        wait(360);
        level flag::clear("generator_on");
        exploder::exploder("fxexp_701");
        var_c1a6445a thread scene::play("p7_fxanim_zm_stal_generator_stop_tarp_bundle");
        level function_ef39c304(0);
        level waittill(#"between_round_over");
        s_generator.var_efb73168 = 1;
        exploder::exploder("fxexp_702");
        exploder::stop_exploder("fxexp_701");
        e_who = s_generator waittill(#"trigger_activated");
        e_who clientfield::increment_to_player("interact_rumble");
        s_generator.var_efb73168 = 0;
    }
}

// Namespace namespace_c5d72679
// Params 1, eflags: 0x1 linked
// namespace_c5d72679<file_0>::function_a5764a2e
// Checksum 0x46d93ce1, Offset: 0x4920
// Size: 0x70
function function_a5764a2e(e_player) {
    if (self.stub.related_parent.var_efb73168) {
        self sethintstring(%ZM_STALINGRAD_GENERATOR);
        return 1;
    }
    self sethintstring("");
    return 0;
}

// Namespace namespace_c5d72679
// Params 1, eflags: 0x1 linked
// namespace_c5d72679<file_0>::function_ef39c304
// Checksum 0xe914228e, Offset: 0x4998
// Size: 0x3b6
function function_ef39c304(b_on) {
    if (b_on) {
        level.var_57f8b6c5[5] thread scene::play("p7_fxanim_zm_stal_pneumatic_tube_stuck_bundle");
        exploder::exploder("ex_tube_" + level.var_57f8b6c5[0].script_label + "_green");
        level.var_57f8b6c5[0] playloopsound("zmb_tubesville_airflow", 0.5);
        level.var_57f8b6c5[0] showpart("tag_buttons_on");
        level.var_57f8b6c5[0] hidepart("tag_buttons_off");
        for (i = 1; i < level.var_57f8b6c5.size; i++) {
            if (level.var_57f8b6c5[i].var_59c68a0b > 0) {
                exploder::exploder("ex_tube_" + level.var_57f8b6c5[i].script_label + "_blue");
                level.var_57f8b6c5[i] playloopsound("zmb_tubesville_airflow", 0.5);
            }
            level.var_57f8b6c5[i] showpart("tag_buttons_on");
            level.var_57f8b6c5[i] hidepart("tag_buttons_off");
        }
        return;
    }
    level.var_57f8b6c5[5] scene::stop("p7_fxanim_zm_stal_pneumatic_tube_stuck_bundle");
    exploder::stop_exploder("ex_tube_" + level.var_57f8b6c5[0].script_label + "_green");
    level.var_57f8b6c5[0] stoploopsound(0.5);
    level.var_57f8b6c5[0] hidepart("tag_buttons_on");
    level.var_57f8b6c5[0] showpart("tag_buttons_off");
    for (i = 1; i < level.var_57f8b6c5.size; i++) {
        exploder::stop_exploder("ex_tube_" + level.var_57f8b6c5[i].script_label + "_blue");
        level.var_57f8b6c5[i] stoploopsound(0.5);
        level.var_57f8b6c5[i] hidepart("tag_buttons_on");
        level.var_57f8b6c5[i] showpart("tag_buttons_off");
    }
}

// Namespace namespace_c5d72679
// Params 0, eflags: 0x1 linked
// namespace_c5d72679<file_0>::function_60619737
// Checksum 0x703fc0ef, Offset: 0x4d58
// Size: 0x232
function function_60619737() {
    level endon(#"hash_59d55c4");
    var_4ae0fc9f = struct::get("ee_tube_use_" + self.script_label, "targetname");
    var_4ae0fc9f zm_unitrigger::create_unitrigger("");
    mdl_lever = getent(self.target, "targetname");
    while (true) {
        e_who = var_4ae0fc9f waittill(#"trigger_activated");
        if (!level flag::get("generator_on")) {
            continue;
        }
        e_who clientfield::increment_to_player("interact_rumble");
        var_a4e14a29 = function_d6953423(self.var_cd705a9[self.var_1f3c0ca7]);
        var_a4e14a29 function_5c0811bc(0);
        if (self.var_1f3c0ca7 == 2) {
            self.var_1f3c0ca7 = 0;
        } else {
            self.var_1f3c0ca7++;
        }
        mdl_lever rotatepitch(120, 0.5);
        mdl_lever playsound("zmb_tubesville_lever");
        mdl_lever waittill(#"rotatedone");
        var_5d1d7014 = function_d6953423(self.var_cd705a9[self.var_1f3c0ca7]);
        var_5d1d7014 function_5c0811bc(1);
        if (function_797708de()) {
            level flag::set("tube_puzzle_complete");
            return;
        }
    }
}

// Namespace namespace_c5d72679
// Params 1, eflags: 0x1 linked
// namespace_c5d72679<file_0>::function_5c0811bc
// Checksum 0x8a6c7493, Offset: 0x4f98
// Size: 0x10c
function function_5c0811bc(var_dcb8ac46) {
    if (var_dcb8ac46) {
        self.var_59c68a0b++;
        if (self.var_59c68a0b == 1 && self != level.var_57f8b6c5[0]) {
            exploder::exploder("ex_tube_" + self.script_label + "_blue");
            self playloopsound("zmb_tubesville_airflow", 0.5);
        }
        return;
    }
    self.var_59c68a0b--;
    if (self.var_59c68a0b == 0 && self != level.var_57f8b6c5[0]) {
        exploder::stop_exploder("ex_tube_" + self.script_label + "_blue");
        self stoploopsound(0.5);
    }
}

// Namespace namespace_c5d72679
// Params 0, eflags: 0x1 linked
// namespace_c5d72679<file_0>::function_797708de
// Checksum 0xf81c68b9, Offset: 0x50b0
// Size: 0xe2
function function_797708de() {
    var_a95dc9d9 = level.var_57f8b6c5[0];
    a_mdl_tubes = [];
    for (i = 0; i < 6; i++) {
        array::add(a_mdl_tubes, var_a95dc9d9, 0);
        var_a95dc9d9 = function_d6953423(var_a95dc9d9.var_cd705a9[var_a95dc9d9.var_1f3c0ca7]);
    }
    if (a_mdl_tubes.size != 6) {
        return false;
    }
    if (a_mdl_tubes[5] != level.var_57f8b6c5[5]) {
        return false;
    }
    return true;
}

// Namespace namespace_c5d72679
// Params 0, eflags: 0x1 linked
// namespace_c5d72679<file_0>::function_6a9560b6
// Checksum 0x447831e4, Offset: 0x51a0
// Size: 0x14c
function function_6a9560b6() {
    var_a477d63b = level.var_57f8b6c5[5];
    var_a477d63b scene::play("p7_fxanim_zm_stal_pneumatic_tube_drop_bundle");
    var_4ae0fc9f = struct::get("ee_tube_use_" + var_a477d63b.script_label, "targetname");
    var_4ae0fc9f.s_unitrigger.prompt_and_visibility_func = &function_7247a337;
    e_who = var_4ae0fc9f waittill(#"trigger_activated");
    e_who clientfield::increment_to_player("interact_rumble");
    e_who playsound("zmb_tubesville_pickup_cylinder");
    zm_unitrigger::unregister_unitrigger(var_4ae0fc9f.s_unitrigger);
    var_7e5dba8f = getent("pneumatic_tube", "targetname");
    var_7e5dba8f delete();
}

// Namespace namespace_c5d72679
// Params 0, eflags: 0x1 linked
// namespace_c5d72679<file_0>::function_830b8c18
// Checksum 0xd42dbe3b, Offset: 0x52f8
// Size: 0x92
function function_830b8c18() {
    foreach (var_beb54dbd in level.var_57f8b6c5) {
        var_beb54dbd stoploopsound(0.5);
    }
}

// Namespace namespace_c5d72679
// Params 1, eflags: 0x1 linked
// namespace_c5d72679<file_0>::function_7247a337
// Checksum 0x5a17c308, Offset: 0x5398
// Size: 0x30
function function_7247a337(e_player) {
    self sethintstring(%ZM_STALINGRAD_MASTER_CYLINDER);
    return true;
}

// Namespace namespace_c5d72679
// Params 1, eflags: 0x1 linked
// namespace_c5d72679<file_0>::function_d6953423
// Checksum 0xb0cd2cce, Offset: 0x53d0
// Size: 0x98
function function_d6953423(str_location) {
    foreach (var_beb54dbd in level.var_57f8b6c5) {
        if (var_beb54dbd.script_label == str_location) {
            return var_beb54dbd;
        }
    }
}

// Namespace namespace_c5d72679
// Params 0, eflags: 0x1 linked
// namespace_c5d72679<file_0>::function_72d1d0bb
// Checksum 0x3904865f, Offset: 0x5470
// Size: 0x294
function function_72d1d0bb() {
    wait(1.5);
    level function_ef39c304(0);
    exploder::stop_exploder("fxexp_701");
    exploder::stop_exploder("fxexp_702");
    if (level flag::get("generator_on")) {
        var_c1a6445a = getent("generator_tarp", "targetname");
        var_c1a6445a scene::play("p7_fxanim_zm_stal_generator_stop_tarp_bundle");
    }
    struct::function_368120a1("scene", "p7_fxanim_zm_stal_generator_start_tarp_bundle");
    struct::function_368120a1("scene", "p7_fxanim_zm_stal_generator_stop_tarp_bundle");
    struct::function_368120a1("scene", "p7_fxanim_zm_stal_pneumatic_tube_stuck_bundle");
    struct::function_368120a1("scene", "p7_fxanim_zm_stal_pneumatic_tube_drop_bundle");
    level.var_57f8b6c5 = undefined;
    var_4ace0f6b = struct::get_array("ee_tube_use", "script_label");
    foreach (var_a6de34cb in var_4ace0f6b) {
        zm_unitrigger::unregister_unitrigger(var_a6de34cb.s_unitrigger);
        var_a6de34cb.s_unitrigger = undefined;
        var_a6de34cb struct::delete();
    }
    s_generator = struct::get("ee_generator", "targetname");
    zm_unitrigger::unregister_unitrigger(s_generator.s_unitrigger);
    s_generator.s_unitrigger = undefined;
    s_generator struct::delete();
}

// Namespace namespace_c5d72679
// Params 0, eflags: 0x1 linked
// namespace_c5d72679<file_0>::function_9bab94c2
// Checksum 0x629484d5, Offset: 0x5710
// Size: 0xdc
function function_9bab94c2() {
    level flag::wait_till("ee_cylinder_acquired");
    level function_fa7fbd4c(0);
    level function_96953619();
    level function_f352dd1b();
    level function_c6d84fe1();
    level function_2868b6f4();
    level namespace_dcf9c464::function_85b7d5f1();
    wait(0.5);
    level flag::set("key_placement");
}

// Namespace namespace_c5d72679
// Params 0, eflags: 0x1 linked
// namespace_c5d72679<file_0>::function_96953619
// Checksum 0x68f9db89, Offset: 0x57f8
// Size: 0x26e
function function_96953619() {
    level.var_4c56821d = [];
    for (i = 1; i <= 6; i++) {
        n_index = i - 1;
        var_51a2f105 = level.var_a090a655 gettagorigin("code_wheel_0" + i + "_jnt");
        level.var_4c56821d[n_index] = util::spawn_model("p7_fxanim_zm_stal_computer_sophia_code_ring_0" + i + "_mod", var_51a2f105);
        level.var_4c56821d[n_index].takedamage = 1;
        util::wait_network_frame();
    }
    level.var_4c56821d[0].var_92f9e88c = 0;
    level.var_4c56821d[1].var_92f9e88c = 6;
    level.var_4c56821d[2].var_92f9e88c = 0;
    level.var_4c56821d[3].var_92f9e88c = 7;
    level.var_4c56821d[4].var_92f9e88c = 6;
    level.var_4c56821d[5].var_92f9e88c = 4;
    do {
        foreach (var_82fe6472 in level.var_4c56821d) {
            var_82fe6472.var_c957db9f = randomint(8);
            var_82fe6472.angles = (0, var_82fe6472.var_c957db9f * 45, 0);
        }
    } while (function_432361e1());
}

// Namespace namespace_c5d72679
// Params 0, eflags: 0x1 linked
// namespace_c5d72679<file_0>::function_432361e1
// Checksum 0x12cc5f87, Offset: 0x5a70
// Size: 0x9a
function function_432361e1() {
    foreach (var_82fe6472 in level.var_4c56821d) {
        if (var_82fe6472.var_c957db9f != var_82fe6472.var_92f9e88c) {
            return false;
        }
    }
    return true;
}

// Namespace namespace_c5d72679
// Params 0, eflags: 0x1 linked
// namespace_c5d72679<file_0>::function_f352dd1b
// Checksum 0x302380e8, Offset: 0x5b18
// Size: 0xdc
function function_f352dd1b() {
    var_af8a18df = struct::get("ee_sophia_struct", "targetname");
    var_af8a18df function_6e3a6092(100, "", 0);
    level.var_a090a655 showpart("slot_decoder_jnt");
    level.var_a090a655 thread namespace_dcf9c464::function_e4acaa37("vox_soph_amsel_need_auth_0", 0, 1, 0, 1);
    level.var_a090a655 scene::play("p7_fxanim_zm_stal_computer_sophia_code_door_open_bundle");
    level function_fa7fbd4c(1);
}

// Namespace namespace_c5d72679
// Params 0, eflags: 0x1 linked
// namespace_c5d72679<file_0>::function_c6d84fe1
// Checksum 0x53bf34d7, Offset: 0x5c00
// Size: 0x282
function function_c6d84fe1() {
    var_2200eb08 = struct::get("ee_sophia_struct", "targetname");
    foreach (var_82fe6472 in level.var_4c56821d) {
        var_82fe6472 thread function_604cfbfb();
    }
    while (true) {
        var_2200eb08.s_unitrigger function_527f47cc(%ZM_STALINGRAD_MASTER_PASSWORD);
        e_who = var_2200eb08 waittill(#"trigger_activated");
        level function_fa7fbd4c(0);
        var_2200eb08.s_unitrigger function_527f47cc("");
        e_who clientfield::increment_to_player("interact_rumble");
        if (function_432361e1()) {
            break;
        }
        level.var_a090a655 thread namespace_dcf9c464::function_e4acaa37("vox_soph_amsel_incorrect_0", 0, 1, 0, 1);
        level waittill(#"between_round_over");
        level function_fa7fbd4c(1);
    }
    level.var_a090a655 scene::play("p7_fxanim_zm_stal_computer_sophia_code_door_close_bundle");
    foreach (var_82fe6472 in level.var_4c56821d) {
        var_82fe6472 delete();
        util::wait_network_frame();
    }
    level.var_4c56821d = undefined;
}

// Namespace namespace_c5d72679
// Params 0, eflags: 0x1 linked
// namespace_c5d72679<file_0>::function_604cfbfb
// Checksum 0xe2fff8b9, Offset: 0x5e90
// Size: 0x12c
function function_604cfbfb() {
    level endon(#"hash_e84299b0");
    while (true) {
        amount, attacker, direction, point, mod, tagname, modelname, partname, weapon = self waittill(#"damage");
        if (isplayer(attacker) && mod != "MOD_EXPLOSIVE") {
            self.var_c957db9f++;
            if (self.var_c957db9f == 8) {
                self.var_c957db9f = 0;
            }
            self rotateyaw(45, 0.5);
            self playsound("zmb_sophia_code_door_wheel");
            self waittill(#"rotatedone");
        }
    }
}

// Namespace namespace_c5d72679
// Params 0, eflags: 0x1 linked
// namespace_c5d72679<file_0>::function_8d296a92
// Checksum 0xfd6cc0fa, Offset: 0x5fc8
// Size: 0x156
function function_8d296a92() {
    level.var_ab1ca2f9 = [];
    level.var_4e272444 = 0;
    level.var_4e47b032 = 0;
    level function_928d903a();
    level flag::wait_till("key_placement");
    mdl_map = getent("ee_map", "targetname");
    mdl_map showpart("tag_map_screen_glow_text");
    level function_67cef48(1);
    level thread function_469f74c5();
    level namespace_dcf9c464::function_38bc572f();
    level thread function_dbdd2358();
    level function_2868b6f4(0);
    level flag::wait_till("keys_placed");
    level.var_ab1ca2f9 = undefined;
    level.var_4e272444 = undefined;
    level.var_4e47b032 = undefined;
}

// Namespace namespace_c5d72679
// Params 0, eflags: 0x1 linked
// namespace_c5d72679<file_0>::function_928d903a
// Checksum 0xea1de2e1, Offset: 0x6128
// Size: 0x94
function function_928d903a() {
    level thread function_316026e4();
    level thread function_a1e863ea();
    level thread function_b96348ee();
    level thread function_ca8026e2();
    level thread function_71e9014a();
    level thread function_87bac664();
}

// Namespace namespace_c5d72679
// Params 0, eflags: 0x1 linked
// namespace_c5d72679<file_0>::function_316026e4
// Checksum 0xcc166f78, Offset: 0x61c8
// Size: 0x172
function function_316026e4() {
    t_damage = getent("ee_keys_anomaly_damage_trig", "targetname");
    while (true) {
        amount, attacker, direction, point, mod, tagname, modelname, partname, weapon = t_damage waittill(#"damage");
        if (isplayer(attacker)) {
            level scene::play("p7_fxanim_zm_stal_pickups_figure_blob_bundle");
            e_key = getent("pickup_blob", "targetname");
            e_key thread function_b68b6797("p7_zm_sta_wall_map_figure_01_blob");
            struct::function_368120a1("scene", "p7_fxanim_zm_stal_pickups_figure_blob_bundle");
            t_damage delete();
            return;
        }
    }
}

// Namespace namespace_c5d72679
// Params 0, eflags: 0x1 linked
// namespace_c5d72679<file_0>::function_a1e863ea
// Checksum 0x8be31777, Offset: 0x6348
// Size: 0x19a
function function_a1e863ea() {
    t_damage = getent("ee_keys_puddle_damage_trig", "targetname");
    while (true) {
        amount, attacker, direction, point, mod, tagname, modelname, partname, weapon = t_damage waittill(#"damage");
        if (weapon === getweapon("launcher_dragon_fire") || weapon === getweapon("launcher_dragon_fire_upgraded")) {
            wait(3);
            level scene::play("p7_fxanim_zm_stal_pickups_figure_nuke_bundle");
            e_key = getent("pickup_nuke", "targetname");
            e_key thread function_b68b6797("p7_zm_sta_wall_map_figure_02_nuke");
            struct::function_368120a1("scene", "p7_fxanim_zm_stal_pickups_figure_nuke_bundle");
            t_damage delete();
            return;
        }
    }
}

// Namespace namespace_c5d72679
// Params 0, eflags: 0x1 linked
// namespace_c5d72679<file_0>::function_b96348ee
// Checksum 0x42d1f5b3, Offset: 0x64f0
// Size: 0x242
function function_b96348ee() {
    t_damage = getent("ee_keys_safe_damage_trig", "targetname");
    while (true) {
        amount, attacker, direction, point, mod, tagname, modelname, partname, weapon = t_damage waittill(#"damage");
        if (isdefined(attacker) && weapon === attacker.var_ae0fff53 && mod == "MOD_MELEE") {
            s_key = struct::get("ee_keys_pod_struct", "targetname");
            mdl_piece = util::spawn_model("p7_zm_sta_wall_map_figure_06_pod", s_key.origin + (0, 20, 0), s_key.angles);
            mdl_piece thread function_b68b6797();
            mdl_piece clientfield::set("ee_safe_smash_rumble", 1);
            mdl_piece playsound("zmb_keyskeyskeys_safe_punch");
            exploder::exploder("fxexp_705");
            var_8cf273a9 = getent("ee_safe_door", "targetname");
            var_8cf273a9 delete();
            s_key struct::delete();
            t_damage delete();
            return;
        }
    }
}

// Namespace namespace_c5d72679
// Params 0, eflags: 0x1 linked
// namespace_c5d72679<file_0>::function_ca8026e2
// Checksum 0x6d00d4f, Offset: 0x6740
// Size: 0x16c
function function_ca8026e2() {
    array::thread_all(level.players, &function_35eed524);
    callback::on_connect(&function_35eed524);
    w_shield = level waittill(#"hash_a8bfa21a");
    callback::remove_on_connect(&function_35eed524);
    if (w_shield == getweapon("dragonshield")) {
        exploder::exploder("fxexp_703");
    } else {
        exploder::exploder("fxexp_704");
    }
    level scene::play("p7_fxanim_zm_stal_pickups_figure_drone_bundle");
    e_key = getent("pickup_drone", "targetname");
    e_key thread function_b68b6797("p7_zm_sta_wall_map_figure_04_drone");
    struct::function_368120a1("scene", "p7_fxanim_zm_stal_pickups_figure_drone_bundle");
}

// Namespace namespace_c5d72679
// Params 0, eflags: 0x1 linked
// namespace_c5d72679<file_0>::function_35eed524
// Checksum 0x375ecfb4, Offset: 0x68b8
// Size: 0x1b4
function function_35eed524() {
    level endon(#"hash_a8bfa21a");
    self endon(#"death");
    s_pipe = struct::get("ee_keys_pipe", "targetname");
    while (true) {
        w_shield = self waittill(#"hash_10fa975d");
        var_7dda366c = self getweaponmuzzlepoint();
        var_9c5bd97c = self getweaponforwarddir();
        var_ae93125 = level.zombie_vars["dragonshield_knockdown_range"] * level.zombie_vars["dragonshield_knockdown_range"];
        var_cb78916d = s_pipe.origin;
        var_8112eb05 = distancesquared(var_7dda366c, var_cb78916d);
        if (var_8112eb05 > var_ae93125) {
            continue;
        }
        v_normal = vectornormalize(var_cb78916d - var_7dda366c);
        n_dot = vectordot(var_9c5bd97c, v_normal);
        if (0 > n_dot) {
            continue;
        }
        s_pipe struct::delete();
        level notify(#"hash_a8bfa21a", w_shield);
        return;
    }
}

// Namespace namespace_c5d72679
// Params 0, eflags: 0x1 linked
// namespace_c5d72679<file_0>::function_71e9014a
// Checksum 0xdf453cba, Offset: 0x6a78
// Size: 0x14c
function function_71e9014a() {
    t_damage = getent("ee_sewer_damage_trig", "targetname");
    t_damage waittill(#"damage");
    t_damage delete();
    level scene::play("p7_fxanim_zm_stal_sewer_switch_bundle");
    exploder::exploder("sewer_switch");
    level thread function_2433fbc0();
    s_key = struct::get("ee_keys_935_struct", "targetname");
    mdl_piece = util::spawn_model("p7_zm_sta_wall_map_figure_05_symbol", s_key.origin, s_key.angles);
    mdl_piece thread function_b68b6797(undefined, "stop_swirly");
    s_key struct::delete();
}

// Namespace namespace_c5d72679
// Params 0, eflags: 0x1 linked
// namespace_c5d72679<file_0>::function_2433fbc0
// Checksum 0xd3c95719, Offset: 0x6bd0
// Size: 0x38
function function_2433fbc0() {
    level endon(#"hash_e8c00db6");
    while (true) {
        exploder::exploder("fxexp_707");
        wait(6.5);
    }
}

// Namespace namespace_c5d72679
// Params 0, eflags: 0x1 linked
// namespace_c5d72679<file_0>::function_87bac664
// Checksum 0x358ee521, Offset: 0x6c10
// Size: 0x1d2
function function_87bac664() {
    while (true) {
        str_exploder = level waittill(#"hash_278aa663");
        if (str_exploder == "fxexp_200") {
            mdl_debris = getent("ee_library_safe_debris", "targetname");
            exploder::exploder("fxexp_706");
            mdl_debris delete();
            s_key = struct::get("ee_keys_raz_struct", "targetname");
            mdl_piece = util::spawn_model("p7_zm_sta_wall_map_figure_03_soldier", s_key.origin + (0, 0, -32), s_key.angles);
            mdl_piece clientfield::set("ee_safe_smash_rumble", 1);
            mdl_piece playsound("zmb_keyskeyskeys_safe_explode");
            e_player = s_key function_6e3a6092();
            mdl_piece function_604c6e27(mdl_piece.model, e_player);
            mdl_piece delete();
            s_key struct::delete();
            return;
        }
    }
}

// Namespace namespace_c5d72679
// Params 2, eflags: 0x1 linked
// namespace_c5d72679<file_0>::function_b68b6797
// Checksum 0x198207f9, Offset: 0x6df0
// Size: 0xbc
function function_b68b6797(str_model, str_notify) {
    if (!isdefined(str_model)) {
        str_model = undefined;
    }
    if (!isdefined(str_notify)) {
        str_notify = undefined;
    }
    e_player = self function_6e3a6092();
    if (isdefined(str_notify)) {
        level notify(str_notify);
    }
    if (!isdefined(str_model)) {
        str_model = self.model;
    }
    self function_604c6e27(str_model, e_player);
    self delete();
}

// Namespace namespace_c5d72679
// Params 2, eflags: 0x1 linked
// namespace_c5d72679<file_0>::function_604c6e27
// Checksum 0x7ee5418d, Offset: 0x6eb8
// Size: 0x124
function function_604c6e27(str_model, e_player) {
    self playsound("zmb_keyskeyskeys_pickup");
    if (!isdefined(level.var_ab1ca2f9)) {
        level.var_ab1ca2f9 = [];
    } else if (!isarray(level.var_ab1ca2f9)) {
        level.var_ab1ca2f9 = array(level.var_ab1ca2f9);
    }
    level.var_ab1ca2f9[level.var_ab1ca2f9.size] = str_model;
    level.var_4e272444++;
    if (level.var_4e272444 == 6 && level flag::get("key_placement") && !function_92de7ae0()) {
        level thread namespace_dcf9c464::function_931a3024();
        return;
    }
    e_player namespace_dcf9c464::function_5adc22c7();
}

// Namespace namespace_c5d72679
// Params 0, eflags: 0x1 linked
// namespace_c5d72679<file_0>::function_469f74c5
// Checksum 0x327a2d2c, Offset: 0x6fe8
// Size: 0x256
function function_469f74c5() {
    var_66919a0f = getent("ee_map_shelf", "targetname");
    var_385ae3a2 = struct::get("ee_map_button_struct", "targetname");
    var_385ae3a2 zm_unitrigger::create_unitrigger("");
    while (true) {
        e_who = var_385ae3a2 waittill(#"trigger_activated");
        if (level.var_ab1ca2f9.size) {
            e_who clientfield::increment_to_player("interact_rumble");
            var_6d30388 = level.var_ab1ca2f9;
            level.var_ab1ca2f9 = [];
            foreach (var_66fe5441 in var_6d30388) {
                str_index = function_3c4d7664(var_66fe5441);
                str_tag_name = "wall_map_shelf_figure_" + str_index;
                var_66919a0f showpart(str_tag_name);
                var_cb153270 = var_66919a0f gettagorigin(str_tag_name);
                level.var_4e47b032++;
                if (level.var_4e47b032 == 6) {
                    level flag::set("keys_placed");
                    playsoundatposition("zmb_keyskeyskeys_place_final", var_cb153270);
                    return;
                }
                playsoundatposition("zmb_keyskeyskeys_place", var_cb153270);
            }
        }
    }
}

// Namespace namespace_c5d72679
// Params 1, eflags: 0x1 linked
// namespace_c5d72679<file_0>::function_3c4d7664
// Checksum 0x9b78935c, Offset: 0x7248
// Size: 0x42
function function_3c4d7664(str_key) {
    a_str_tokens = strtok(str_key, "_");
    return a_str_tokens[6];
}

// Namespace namespace_c5d72679
// Params 0, eflags: 0x1 linked
// namespace_c5d72679<file_0>::function_72dd3113
// Checksum 0x48ad7d89, Offset: 0x7298
// Size: 0x684
function function_72dd3113() {
    level flag::wait_till("keys_placed");
    level function_67cef48(0);
    level function_2868b6f4();
    level namespace_dcf9c464::function_3a7b7b7b();
    level thread function_851880c();
    level thread function_811523a8();
    var_a25cea6f = 0;
    level function_2868b6f4(0);
    var_fa839427 = level function_3d77d2aa();
    level.var_adcde28f = 0;
    level.var_bd16d335 = 0;
    level.var_83edfb9 = 0;
    level.var_68a92652 = 0;
    level.var_8acfb18e = 0;
    level.var_9777b703 = 0;
    var_f4570d42 = 0;
    var_385ae3a2 = struct::get("ee_map_button_struct", "targetname");
    level.var_f0d11538 = spawn("script_origin", var_385ae3a2.origin);
    /#
        if (!isdefined(var_385ae3a2.s_unitrigger)) {
            var_385ae3a2 zm_unitrigger::create_unitrigger("vehicle");
        }
    #/
    var_78d02c88 = getent("ee_map_shelf", "targetname");
    var_78d02c88 thread function_478d8886();
    var_2e214fe3 = 1;
    while (isdefined(var_fa839427[var_f4570d42])) {
        if (!level flag::get("special_round") && !level flag::get("lockdown_active")) {
            level function_67cef48(1);
        }
        var_4c390f6e = var_fa839427[var_f4570d42];
        e_who = var_385ae3a2 waittill(#"trigger_activated");
        if (level flag::get("special_round") || level flag::get("lockdown_active")) {
            level.var_f0d11538 playsound("zmb_scenarios_button_deny");
            continue;
        }
        level.var_f0d11538 playsound("zmb_scenarios_button_activate");
        level flag::set("scenario_active");
        level function_2868b6f4();
        e_who clientfield::increment_to_player("interact_rumble");
        if (var_f4570d42 == 0 && level.var_adcde28f == 0) {
            level thread namespace_dcf9c464::function_e4acaa37("vox_soph_phase2_intro_resp_2_0", 0, 1, 0, 1);
        }
        if (var_2e214fe3) {
            level function_5fa7e851();
        }
        var_7a5cc90a = level function_26d69198(var_4c390f6e);
        level flag::set("ee_round");
        level function_67cef48(0);
        var_2e214fe3 = level [[ var_4c390f6e ]]();
        level flag::clear("ee_round");
        level flag::clear("scenario_active");
        exploder::stop_exploder(var_7a5cc90a);
        if (var_2e214fe3) {
            var_f4570d42++;
            if (!(isdefined(var_a25cea6f) && var_a25cea6f) && var_f4570d42 >= var_fa839427.size / 2) {
                level notify(#"hash_8df52d90");
                var_a25cea6f = 1;
            }
            if (isdefined(var_fa839427[var_f4570d42])) {
                level.var_f0d11538 playsound("zmb_scenarios_map_scenario_success");
            } else {
                level.var_f0d11538 playsound("zmb_scenarios_map_scenario_success_all");
            }
            level function_2868b6f4(0);
            continue;
        }
        level thread function_60be32a4(var_4c390f6e);
        level.var_f0d11538 playsound("zmb_scenarios_map_scenario_fail");
        level.var_adcde28f++;
        level waittill(#"between_round_over");
    }
    zm_unitrigger::unregister_unitrigger(var_385ae3a2.s_unitrigger);
    var_385ae3a2.s_unitrigger = undefined;
    var_385ae3a2 struct::delete();
    level.var_adcde28f = undefined;
    level.var_40917b16 = undefined;
    level.var_bd16d335 = undefined;
    level.var_83edfb9 = undefined;
    level.var_68a92652 = undefined;
    level.var_8acfb18e = undefined;
    level.var_9777b703 = undefined;
    level.var_e5f51155 = undefined;
    level flag::set("scenarios_complete");
}

// Namespace namespace_c5d72679
// Params 1, eflags: 0x1 linked
// namespace_c5d72679<file_0>::function_60be32a4
// Checksum 0x1ed74778, Offset: 0x7928
// Size: 0x4c
function function_60be32a4(var_4c390f6e) {
    var_5411b44e = var_4c390f6e == &function_6a1cc377;
    level namespace_dcf9c464::function_dd5e5b43(level.var_adcde28f, var_5411b44e);
}

// Namespace namespace_c5d72679
// Params 0, eflags: 0x1 linked
// namespace_c5d72679<file_0>::function_3d77d2aa
// Checksum 0x89bb5ae0, Offset: 0x7980
// Size: 0x1ec
function function_3d77d2aa() {
    var_fa839427 = array(&function_4769ea02, &function_f5139aae, &function_62f0a233, &function_6a1cc377, &function_21284834);
    do {
        var_fa839427 = array::randomize(var_fa839427);
        foreach (n_index, var_ad364454 in var_fa839427) {
            if (var_ad364454 == &function_f5139aae) {
                var_e0c8798d = n_index;
                continue;
            }
            if (var_ad364454 == &function_62f0a233) {
                var_c1f2176c = n_index;
            }
        }
        var_9a5eed4d = abs(var_e0c8798d - var_c1f2176c);
    } while (var_9a5eed4d == 1);
    if (!isdefined(var_fa839427)) {
        var_fa839427 = [];
    } else if (!isarray(var_fa839427)) {
        var_fa839427 = array(var_fa839427);
    }
    var_fa839427[var_fa839427.size] = &function_101e5b38;
    return var_fa839427;
}

// Namespace namespace_c5d72679
// Params 0, eflags: 0x1 linked
// namespace_c5d72679<file_0>::function_478d8886
// Checksum 0xf60efff0, Offset: 0x7b78
// Size: 0xa8
function function_478d8886() {
    level endon(#"hash_e2166494");
    a_str_flags = array("special_round", "lockdown_active");
    while (true) {
        level flag::wait_till_any(a_str_flags);
        level function_67cef48(0);
        level flag::wait_till_clear_all(a_str_flags);
        level function_67cef48(1);
    }
}

// Namespace namespace_c5d72679
// Params 0, eflags: 0x1 linked
// namespace_c5d72679<file_0>::function_5fa7e851
// Checksum 0x2150b4a5, Offset: 0x7c28
// Size: 0x2b2
function function_5fa7e851() {
    for (i = 1; i <= 6; i++) {
        wait(0.05);
        exploder::exploder("map_display_" + i);
        level.var_f0d11538 playsound("zmb_scenarios_map_beep");
        wait(0.05);
        exploder::stop_exploder("map_display_" + i);
    }
    for (i = 6 - 1; i > 0; i--) {
        wait(0.05);
        exploder::exploder("map_display_" + i);
        level.var_f0d11538 playsound("zmb_scenarios_map_beep");
        wait(0.05);
        exploder::stop_exploder("map_display_" + i);
    }
    var_1f19614 = array::randomize(array(1, 2, 3, 4, 5, 6));
    for (i = 0; i < 2; i++) {
        foreach (var_5bc265e5 in var_1f19614) {
            str_exploder = "map_display_" + var_5bc265e5;
            wait(0.05);
            exploder::exploder(str_exploder);
            level.var_f0d11538 playsound("zmb_scenarios_map_beep");
            wait(0.05);
            exploder::stop_exploder(str_exploder);
        }
        var_1f19614 = array::randomize(var_1f19614);
    }
}

// Namespace namespace_c5d72679
// Params 1, eflags: 0x1 linked
// namespace_c5d72679<file_0>::function_26d69198
// Checksum 0x9295e340, Offset: 0x7ee8
// Size: 0x120
function function_26d69198(var_ad364454) {
    if (var_ad364454 == &function_21284834) {
        str_exploder = "map_display_1";
    } else if (var_ad364454 == &function_6a1cc377) {
        str_exploder = "map_display_2";
    } else if (var_ad364454 == &function_62f0a233) {
        str_exploder = "map_display_3";
    } else if (var_ad364454 == &function_f5139aae) {
        str_exploder = "map_display_4";
    } else if (var_ad364454 == &function_101e5b38) {
        str_exploder = "map_display_5";
    } else {
        str_exploder = "map_display_6";
    }
    exploder::exploder(str_exploder);
    level.var_f0d11538 playsound("zmb_scenarios_map_scenario_select");
    return str_exploder;
}

// Namespace namespace_c5d72679
// Params 0, eflags: 0x1 linked
// namespace_c5d72679<file_0>::function_4769ea02
// Checksum 0x6d7d51, Offset: 0x8010
// Size: 0x2a0
function function_4769ea02() {
    /#
        level.var_8b2f7f24 = "vehicle";
        if (!isdefined(level.var_bd16d335)) {
            level.var_bd16d335 = 0;
        }
    #/
    if (level flag::get("drop_pod_spawned") || level flag::get("drop_pod_active")) {
        return 0;
    }
    level function_b09a54a3();
    level.var_8cc024f2 = function_c324c7f6();
    /#
        if (isdefined(level.var_c47b244)) {
            level.var_8cc024f2 = level.var_c47b244;
        }
    #/
    level namespace_e81d2518::function_1b58252d();
    level function_db8a649e();
    level.var_bd16d335++;
    if (level.var_bd16d335 == 1) {
        level thread namespace_dcf9c464::function_e4acaa37("vox_soph_cargo_orders_0", 0, 1, 0, 1);
    } else if (level.var_bd16d335 == 2) {
        level thread namespace_dcf9c464::function_e4acaa37("vox_soph_cargo_orders_repeat_0", 0, 1, 0, 1);
    }
    level thread namespace_2e6e7fce::function_d1a91c4f(level.var_8cc024f2);
    level thread function_f858a27e();
    var_eb4d7ff3 = level util::waittill_any_return("ee_defend_complete", "ee_defend_failed");
    level namespace_e81d2518::function_d21f20fe();
    level.var_2b4b9c1f = undefined;
    level.var_79fa326a = undefined;
    if (var_eb4d7ff3 == "ee_defend_complete") {
        level function_2868b6f4();
        level namespace_dcf9c464::function_e4acaa37("vox_soph_cargo_success_0", 0, 1, 0, 1);
        /#
            if (isdefined(level.var_c91c0e41) && level.var_c91c0e41) {
                level.var_c91c0e41 = undefined;
                return;
            }
        #/
        level thread function_4da4c438();
        return 1;
    }
    level.var_4b419d38 = 1;
    return 0;
}

// Namespace namespace_c5d72679
// Params 0, eflags: 0x1 linked
// namespace_c5d72679<file_0>::function_b09a54a3
// Checksum 0x2a92d6fd, Offset: 0x82b8
// Size: 0x3e2
function function_b09a54a3() {
    level.var_583e4a97.var_4dfc9f38 = [];
    var_8f0097a0 = struct::get_array("ee_pod", "targetname");
    foreach (s_location in var_8f0097a0) {
        s_location.var_c5718719 = 1;
        str_location = s_location.script_string + s_location.script_int;
        level.var_583e4a97.var_4dfc9f38[str_location] = s_location;
    }
    var_2e36b699 = getentarray("ee_pod_score_volume", "targetname");
    foreach (e_volume in var_2e36b699) {
        str_location = e_volume.script_string;
        foreach (s_location in var_8f0097a0) {
            if (s_location.script_string == e_volume.script_string) {
                level.var_583e4a97.var_4dfc9f38[str_location + s_location.script_int].var_ab891f49 = e_volume;
            }
        }
    }
    var_c746b61a = struct::get_array("ee_pod_attackable", "targetname");
    foreach (var_6829d61c in var_c746b61a) {
        str_location = var_6829d61c.script_string;
        level.var_583e4a97.var_4dfc9f38[str_location].var_b454101b = var_6829d61c;
    }
    foreach (var_3d8a9064 in level.var_583e4a97.var_4dfc9f38) {
        var_3d8a9064 namespace_2e6e7fce::function_d4c6ea10();
    }
}

// Namespace namespace_c5d72679
// Params 0, eflags: 0x1 linked
// namespace_c5d72679<file_0>::function_c324c7f6
// Checksum 0xd20fe290, Offset: 0x86a8
// Size: 0x10c
function function_c324c7f6() {
    while (true) {
        s_pod = array::random(level.var_583e4a97.var_4dfc9f38);
        var_181d95e = namespace_e81d2518::function_9a5142a();
        if (!isdefined(var_181d95e)) {
            return s_pod;
        }
        switch (var_181d95e) {
        case 99:
            if (s_pod.script_string != "ee_library") {
                return s_pod;
            }
            break;
        case 98:
            if (s_pod.script_string != "ee_factory") {
                return s_pod;
            }
            break;
        case 217:
            if (s_pod.script_string != "ee_command") {
                return s_pod;
            }
            break;
        }
        wait(0.5);
    }
}

// Namespace namespace_c5d72679
// Params 0, eflags: 0x1 linked
// namespace_c5d72679<file_0>::function_db8a649e
// Checksum 0xd7fe2208, Offset: 0x87c0
// Size: 0x8c
function function_db8a649e() {
    switch (level.var_8cc024f2.script_string) {
    case 216:
        str_location = "command";
        break;
    case 215:
        str_location = "tank";
        break;
    case 214:
        str_location = "supply";
        break;
    }
    level thread function_15d9679d(str_location, 3);
}

// Namespace namespace_c5d72679
// Params 0, eflags: 0x1 linked
// namespace_c5d72679<file_0>::function_f858a27e
// Checksum 0x18b73898, Offset: 0x8858
// Size: 0x84
function function_f858a27e() {
    array::thread_all(level.players, &function_6485af5f);
    callback::on_connect(&function_6485af5f);
    level function_5b047f3f();
    callback::remove_on_connect(&function_6485af5f);
}

// Namespace namespace_c5d72679
// Params 0, eflags: 0x1 linked
// namespace_c5d72679<file_0>::function_5b047f3f
// Checksum 0xe9bf564a, Offset: 0x88e8
// Size: 0x48
function function_5b047f3f() {
    level endon(#"hash_94bb84a1");
    while (true) {
        level waittill(#"nuke_complete");
        level flag::set("spawn_ee_harassers");
    }
}

// Namespace namespace_c5d72679
// Params 0, eflags: 0x1 linked
// namespace_c5d72679<file_0>::function_6485af5f
// Checksum 0xed1a5723, Offset: 0x8938
// Size: 0x44
function function_6485af5f() {
    level endon(#"hash_94bb84a1");
    self endon(#"death");
    self waittill(#"nuke_triggered");
    level flag::clear("spawn_ee_harassers");
}

// Namespace namespace_c5d72679
// Params 1, eflags: 0x1 linked
// namespace_c5d72679<file_0>::function_7e6865e3
// Checksum 0x22a5a61e, Offset: 0x8988
// Size: 0x124
function function_7e6865e3(var_9f36fb00) {
    level function_2868b6f4(0);
    level flag::clear("ee_round");
    level.var_79fa326a = util::spawn_model("p7_conduit_metal_1_outlet_box", var_9f36fb00, (0, 0, 90));
    level.var_79fa326a.str_location = level.var_8cc024f2.script_string;
    level flag::set("ee_cargo_available");
    level.var_79fa326a thread function_61210287();
    if (!(isdefined(level.var_2b4b9c1f) && level.var_2b4b9c1f)) {
        level.var_2b4b9c1f = 1;
        level thread namespace_48c05c81::function_f8043960(&function_3f7226c0, undefined, 0, &function_bcea76ab);
    }
}

// Namespace namespace_c5d72679
// Params 0, eflags: 0x1 linked
// namespace_c5d72679<file_0>::function_61210287
// Checksum 0xa3197aa1, Offset: 0x8ab8
// Size: 0x7c
function function_61210287() {
    level endon(#"hash_718387c3");
    wait(30);
    level flag::clear("ee_cargo_available");
    self delete();
    level notify(#"hash_e2bd4a52");
    /#
        iprintlnbold("vehicle");
    #/
}

// Namespace namespace_c5d72679
// Params 0, eflags: 0x1 linked
// namespace_c5d72679<file_0>::function_3f7226c0
// Checksum 0xe776d6e3, Offset: 0x8b40
// Size: 0x230
function function_3f7226c0() {
    level endon(#"hash_e2bd4a52");
    var_852a7c46 = self.var_4bd1ce6b getclosestpointonnavvolume(level.var_79fa326a.origin, 30);
    self.var_4bd1ce6b setvehgoalpos(var_852a7c46, 1, 1);
    if (self.var_4bd1ce6b vehicle_ai::waittill_pathresult()) {
        self.var_4bd1ce6b vehicle_ai::waittill_pathing_done();
    }
    level.var_79fa326a.origin = self.var_4bd1ce6b gettagorigin("j_ankle_2_ri_anim");
    level.var_79fa326a linkto(self.var_4bd1ce6b, "j_ankle_2_ri_anim");
    level notify(#"hash_718387c3");
    self.var_4bd1ce6b thread function_948b1459();
    var_14b6e49e = struct::get("cargo_drop_" + level.var_79fa326a.str_location);
    var_1c1045d9 = self.var_4bd1ce6b getclosestpointonnavvolume(var_14b6e49e.origin, 30);
    self.var_4bd1ce6b setvehgoalpos(var_1c1045d9, 1, 1);
    if (self.var_4bd1ce6b vehicle_ai::waittill_pathresult()) {
        self.var_4bd1ce6b vehicle_ai::waittill_pathing_done();
    }
    self.var_4bd1ce6b notify(#"hash_ffd45408");
    level.var_79fa326a unlink();
    level thread function_e085d31();
    return true;
}

// Namespace namespace_c5d72679
// Params 0, eflags: 0x1 linked
// namespace_c5d72679<file_0>::function_948b1459
// Checksum 0x8dd749f8, Offset: 0x8d78
// Size: 0xc4
function function_948b1459() {
    level.var_79fa326a endon(#"death");
    self endon(#"hash_ffd45408");
    self waittill(#"death");
    level.var_79fa326a clientfield::set("ee_cargo_explosion", 1);
    util::wait_network_frame();
    level flag::clear("ee_cargo_available");
    level.var_79fa326a delete();
    level notify(#"hash_e2bd4a52");
    /#
        iprintlnbold("vehicle");
    #/
}

// Namespace namespace_c5d72679
// Params 1, eflags: 0x1 linked
// namespace_c5d72679<file_0>::function_bcea76ab
// Checksum 0x8b5a0ce5, Offset: 0x8e48
// Size: 0xd6
function function_bcea76ab(e_player) {
    if (!level flag::get("ee_cargo_available")) {
        return false;
    }
    if (isdefined(level.var_8cc024f2.var_c5718719) && isdefined(level.var_8cc024f2) && level.var_8cc024f2.var_c5718719) {
        var_e782bc88 = getent("fetch_volume_" + level.var_8cc024f2.script_string, "targetname");
        if (!e_player istouching(var_e782bc88)) {
            return false;
        }
    } else {
        return false;
    }
    return true;
}

// Namespace namespace_c5d72679
// Params 0, eflags: 0x1 linked
// namespace_c5d72679<file_0>::function_e085d31
// Checksum 0x484374e3, Offset: 0x8f28
// Size: 0xe2
function function_e085d31() {
    playfxontag(level._effect["drop_pod_reward_glow"], level.var_79fa326a, "tag_origin");
    level.var_79fa326a thread function_6cacaae5();
    level.var_79fa326a function_6e3a6092(100, %ZM_STALINGRAD_DEFEND_CARGO);
    level.var_79fa326a delete();
    level function_d9d36a17("p7_conduit_metal_1_outlet_box", %ZM_STALINGRAD_CARGO_DEPOSIT, (0, 0, 90), (0, 0, 1.5));
    level notify(#"hash_a937ccc8");
}

// Namespace namespace_c5d72679
// Params 0, eflags: 0x1 linked
// namespace_c5d72679<file_0>::function_6cacaae5
// Checksum 0x6428406d, Offset: 0x9018
// Size: 0x150
function function_6cacaae5() {
    self endon(#"death");
    while (true) {
        n_wait_time = randomfloatrange(2.5, 5);
        n_yaw = randomint(360);
        if (n_yaw > 300) {
            n_yaw = 300;
        } else if (n_yaw < 60) {
            n_yaw = 60;
        }
        n_yaw = self.angles[1] + n_yaw;
        var_d9f4bdfd = (-60 + randomint(120), n_yaw, -45 + randomint(90));
        self rotateto(var_d9f4bdfd, n_wait_time, n_wait_time * 0.5, n_wait_time * 0.5);
        wait(randomfloat(n_wait_time - 0.1));
    }
}

// Namespace namespace_c5d72679
// Params 0, eflags: 0x1 linked
// namespace_c5d72679<file_0>::function_4da4c438
// Checksum 0xaf2eb085, Offset: 0x9170
// Size: 0x192
function function_4da4c438() {
    array::run_all(level.var_583e4a97.var_4dfc9f38, &struct::delete);
    var_17788efc = struct::get_array("ee_harasser", "script_label");
    array::run_all(var_17788efc, &struct::delete);
    var_efb0cf3a = struct::get_array("ee_defend_cargo_drop", "script_label");
    array::run_all(var_efb0cf3a, &struct::delete);
    var_f54e06c3 = getentarray("ee_defend_fetch", "script_label");
    foreach (var_e782bc88 in var_f54e06c3) {
        var_e782bc88 delete();
        util::wait_network_frame();
    }
}

// Namespace namespace_c5d72679
// Params 0, eflags: 0x1 linked
// namespace_c5d72679<file_0>::function_f5139aae
// Checksum 0x7788e3f, Offset: 0x9310
// Size: 0x18c
function function_f5139aae() {
    /#
        level.var_8b2f7f24 = "vehicle";
        if (!isdefined(level.var_83edfb9)) {
            level.var_83edfb9 = 0;
        }
    #/
    s_spawn_location = struct::get("ee_escort_spawn", "targetname");
    if (level namespace_8bc21961::function_19d0b055(1, &function_de888a13, 1, s_spawn_location)) {
        level thread function_591777cf();
        level thread function_15d9679d("square", 3);
        var_9f2ad2a7 = level util::waittill_any_return("ee_escort_complete", "ee_escort_failed");
        if (var_9f2ad2a7 == "ee_escort_complete") {
            level function_2868b6f4();
            level namespace_dcf9c464::function_e4acaa37("vox_soph_sentinel_success_0", 0, 1, 0, 1);
            /#
                if (isdefined(level.var_c91c0e41) && level.var_c91c0e41) {
                    level.var_c91c0e41 = undefined;
                    return;
                }
            #/
            s_spawn_location struct::delete();
            return 1;
        }
    }
    return 0;
}

// Namespace namespace_c5d72679
// Params 0, eflags: 0x1 linked
// namespace_c5d72679<file_0>::function_591777cf
// Checksum 0xd9711abb, Offset: 0x94a8
// Size: 0x9c
function function_591777cf() {
    level.var_83edfb9++;
    if (level.var_83edfb9 == 1) {
        level namespace_dcf9c464::function_e4acaa37("vox_soph_sentinel_orders_0", 0, 1, 0, 1);
    } else if (level.var_83edfb9 == 2) {
        level namespace_dcf9c464::function_e4acaa37("vox_soph_sentinel_orders_repeat_1", 0, 1, 0, 1);
    }
    level function_2868b6f4(0);
}

// Namespace namespace_c5d72679
// Params 0, eflags: 0x1 linked
// namespace_c5d72679<file_0>::function_de888a13
// Checksum 0x682941f0, Offset: 0x9550
// Size: 0xfc
function function_de888a13() {
    self endon(#"death");
    self thread function_8981cfc();
    self vehicle_ai::set_state("scripted");
    self.b_ignore_cleanup = 1;
    self.ignore_nuke = 1;
    self.var_833cfbae = 1;
    self.var_81e263d5 = 1;
    self.var_8f05bccc = 1;
    self.ignore_enemy_count = 1;
    self waittill(#"hash_f07646c0");
    self disableaimassist();
    self namespace_58ca6a3a::function_a2874766(1);
    self clientfield::set("ee_drone_cam_override", 1);
    self thread function_a6093653();
}

// Namespace namespace_c5d72679
// Params 0, eflags: 0x1 linked
// namespace_c5d72679<file_0>::function_a6093653
// Checksum 0xa3dea4fc, Offset: 0x9658
// Size: 0x28a
function function_a6093653() {
    /#
        level endon(#"hash_9546144d");
    #/
    level endon(#"hash_eb6ab37e");
    var_fe8b6de3 = getvehiclenode("ee_escort_entrance", "targetname");
    while (!zm_zonemgr::any_player_in_zone("start_A_zone") && !zm_zonemgr::any_player_in_zone("start_B_zone") && !zm_zonemgr::any_player_in_zone("start_C_zone")) {
        wait(1);
    }
    self vehicle::get_on_and_go_path(var_fe8b6de3);
    self thread function_8c3c41dc();
    self function_cd8abf88("store");
    if (!level flag::get("dept_to_yellow") && !level flag::get("department_floor3_to_red_brick_open")) {
        level flag::wait_till_any(array("dept_to_yellow", "department_floor3_to_red_brick_open"));
    }
    if (!level flag::get("dept_to_yellow")) {
        var_294b0130 = "barracks";
    } else if (!level flag::get("department_floor3_to_red_brick_open")) {
        var_294b0130 = "armory";
    } else if (math::cointoss()) {
        var_294b0130 = "barracks";
    } else {
        var_294b0130 = "armory";
    }
    self function_cd8abf88(var_294b0130);
    self function_cd8abf88("command");
    level notify(#"hash_611549c5");
    level function_694a61ea(self);
    level notify(#"hash_146c8304");
}

// Namespace namespace_c5d72679
// Params 1, eflags: 0x1 linked
// namespace_c5d72679<file_0>::function_cd8abf88
// Checksum 0x880e875d, Offset: 0x98f0
// Size: 0x8c
function function_cd8abf88(var_817b9791) {
    var_cc0916c4 = getvehiclenode("ee_escort_" + var_817b9791, "targetname");
    self thread vehicle::get_on_and_go_path(var_cc0916c4);
    self vehicle::pause_path();
    self function_a9a92838();
}

// Namespace namespace_c5d72679
// Params 0, eflags: 0x1 linked
// namespace_c5d72679<file_0>::function_a9a92838
// Checksum 0x70d11943, Offset: 0x9988
// Size: 0xf6
function function_a9a92838() {
    self endon(#"death");
    self endon(#"reached_end_node");
    b_moving = 0;
    while (true) {
        var_6de069e0 = self namespace_48c05c81::function_1af75b1b(-56);
        if (var_6de069e0 && !b_moving) {
            b_moving = 1;
            self vehicle::resume_path();
            self notify(#"hash_3751c122");
        } else if (!var_6de069e0 && b_moving) {
            b_moving = 0;
            self vehicle::pause_path();
            self thread function_8c3c41dc();
        }
        wait(1);
    }
}

// Namespace namespace_c5d72679
// Params 0, eflags: 0x1 linked
// namespace_c5d72679<file_0>::function_8981cfc
// Checksum 0x12d60824, Offset: 0x9a88
// Size: 0x2a
function function_8981cfc() {
    level endon(#"hash_611549c5");
    self waittill(#"death");
    level notify(#"hash_eb6ab37e");
}

// Namespace namespace_c5d72679
// Params 0, eflags: 0x1 linked
// namespace_c5d72679<file_0>::function_8c3c41dc
// Checksum 0x3feba3c, Offset: 0x9ac0
// Size: 0x4c
function function_8c3c41dc() {
    level endon(#"hash_611549c5");
    self endon(#"hash_3751c122");
    self endon(#"death");
    wait(60);
    self kill();
}

// Namespace namespace_c5d72679
// Params 0, eflags: 0x1 linked
// namespace_c5d72679<file_0>::function_62f0a233
// Checksum 0x64878c5c, Offset: 0x9b18
// Size: 0x2bc
function function_62f0a233() {
    /#
        level.var_8b2f7f24 = "vehicle";
        if (!isdefined(level.var_68a92652)) {
            level.var_68a92652 = 0;
        }
    #/
    var_23424f41 = [];
    var_8338c325 = struct::get_array("raz_location", "script_noteworthy");
    foreach (var_1fc5be4a in var_8338c325) {
        switch (var_1fc5be4a.targetname) {
        case 248:
        case 249:
        case 250:
        case 251:
        case 252:
            if (!isdefined(var_23424f41)) {
                var_23424f41 = [];
            } else if (!isarray(var_23424f41)) {
                var_23424f41 = array(var_23424f41);
            }
            var_23424f41[var_23424f41.size] = var_1fc5be4a;
            break;
        }
    }
    s_spawn = array::random(var_23424f41);
    if (namespace_1c31c03d::function_7ed6c714(1, &function_4d790672, 1, s_spawn)) {
        level thread function_33803fac();
        var_71fb112c = level util::waittill_any_return("ee_kite_complete", "ee_kite_failed");
        /#
            level.var_9f752812 = undefined;
        #/
        if (var_71fb112c == "ee_kite_complete") {
            level function_2868b6f4();
            level namespace_dcf9c464::function_e4acaa37("vox_soph_capture_raz_success_1", 0, 1, 0, 1);
            /#
                if (isdefined(level.var_c91c0e41) && level.var_c91c0e41) {
                    level.var_c91c0e41 = undefined;
                    return;
                }
            #/
            level function_2f418bbf();
            return 1;
        }
    }
    return 0;
}

// Namespace namespace_c5d72679
// Params 0, eflags: 0x1 linked
// namespace_c5d72679<file_0>::function_33803fac
// Checksum 0xc008a104, Offset: 0x9de0
// Size: 0x5c
function function_33803fac() {
    level.var_68a92652++;
    if (level.var_68a92652 == 1) {
        level namespace_dcf9c464::function_e4acaa37("vox_soph_capture_raz_orders_0", 0, 1, 0, 1);
    }
    level function_2868b6f4(0);
}

// Namespace namespace_c5d72679
// Params 0, eflags: 0x1 linked
// namespace_c5d72679<file_0>::function_4d790672
// Checksum 0xb9a758c7, Offset: 0x9e48
// Size: 0xec
function function_4d790672() {
    /#
        level endon(#"hash_9546144d");
    #/
    level endon(#"hash_8d0e9543");
    level endon(#"hash_20992fb1");
    /#
        level.var_9f752812 = self;
    #/
    self.b_ignore_cleanup = 1;
    self.ignore_nuke = 1;
    self.var_833cfbae = 1;
    self.var_81e263d5 = 1;
    self.var_8f05bccc = 1;
    self.ignore_enemy_count = 1;
    util::wait_network_frame();
    self clientfield::set("ee_raz_eye_override", 1);
    self thread function_4f067ff7();
    self waittill(#"completed_emerging_into_playable_area");
    self function_c54a2f4c();
}

// Namespace namespace_c5d72679
// Params 0, eflags: 0x1 linked
// namespace_c5d72679<file_0>::function_4f067ff7
// Checksum 0x49a9a774, Offset: 0x9f40
// Size: 0x42
function function_4f067ff7() {
    level endon(#"hash_8d0e9543");
    level endon(#"hash_20992fb1");
    level endon(#"hash_e4034552");
    self waittill(#"death");
    level notify(#"hash_20992fb1");
}

// Namespace namespace_c5d72679
// Params 1, eflags: 0x1 linked
// namespace_c5d72679<file_0>::function_c54a2f4c
// Checksum 0x4f144d33, Offset: 0x9f90
// Size: 0x140
function function_c54a2f4c(var_6f4b86fb) {
    /#
        level endon(#"hash_9546144d");
    #/
    level endon(#"hash_8d0e9543");
    level endon(#"hash_20992fb1");
    self thread function_ceeaf112();
    for (var_4cdb4f77 = undefined; true; var_4cdb4f77 = 0) {
        wait(1);
        var_6de069e0 = self namespace_48c05c81::function_1af75b1b(450);
        if (var_6de069e0 && (!isdefined(var_4cdb4f77) || !var_4cdb4f77)) {
            self notify(#"hash_f1860bb1");
            self clearforcedgoal();
            self ai::set_ignoreall(0);
            var_4cdb4f77 = 1;
            continue;
        }
        if (!var_6de069e0 && var_4cdb4f77) {
            self thread function_96970289();
            self ai::set_ignoreall(1);
        }
    }
}

// Namespace namespace_c5d72679
// Params 0, eflags: 0x1 linked
// namespace_c5d72679<file_0>::function_96970289
// Checksum 0x8198bc10, Offset: 0xa0d8
// Size: 0x124
function function_96970289() {
    /#
        level endon(#"hash_9546144d");
    #/
    self endon(#"death");
    self endon(#"hash_f1860bb1");
    level endon(#"hash_8d0e9543");
    var_713bb408 = struct::get("ee_raz_escape", "targetname");
    self setgoal(var_713bb408.origin);
    self waittill(#"goal");
    level notify(#"hash_20992fb1");
    self ai::set_ignoreall(1);
    var_aa6f12ec = struct::get("ee_raz_delete", "targetname");
    self setgoal(var_aa6f12ec.origin);
    self waittill(#"goal");
    self kill();
}

// Namespace namespace_c5d72679
// Params 0, eflags: 0x1 linked
// namespace_c5d72679<file_0>::function_ceeaf112
// Checksum 0xc126e839, Offset: 0xa208
// Size: 0x1f0
function function_ceeaf112() {
    /#
        level endon(#"hash_9546144d");
    #/
    level endon(#"hash_20992fb1");
    var_f80d6608 = getent("ee_raz_capture", "targetname");
    while (true) {
        e_who = var_f80d6608 waittill(#"trigger");
        if (e_who == self) {
            self clearforcedgoal();
            self ai::set_ignoreall(1);
            var_f80d6608 delete();
            s_capture_point = struct::get("ee_capture_point", "targetname");
            self setgoal(s_capture_point.origin);
            var_c1fbdc10 = util::spawn_model("tag_origin", s_capture_point.origin);
            self notsolid();
            self waittill(#"goal");
            wait(0.5);
            self linkto(var_c1fbdc10);
            self solid();
            level notify(#"hash_e4034552");
            level function_694a61ea(self);
            var_c1fbdc10 delete();
            level notify(#"hash_8d0e9543");
            return;
        }
    }
}

// Namespace namespace_c5d72679
// Params 0, eflags: 0x1 linked
// namespace_c5d72679<file_0>::function_2f418bbf
// Checksum 0x7e87dcef, Offset: 0xa400
// Size: 0xc4
function function_2f418bbf() {
    var_a7e5eb7a = struct::get("ee_raz_entrance", "targetname");
    var_a7e5eb7a struct::delete();
    var_fc67abd = struct::get("ee_raz_escape", "targetname");
    var_fc67abd struct::delete();
    var_fffdb019 = struct::get("ee_raz_delete", "targetname");
    var_fffdb019 struct::delete();
}

// Namespace namespace_c5d72679
// Params 0, eflags: 0x1 linked
// namespace_c5d72679<file_0>::function_6a1cc377
// Checksum 0xce9140af, Offset: 0xa4d0
// Size: 0x3be
function function_6a1cc377() {
    /#
        level.var_8b2f7f24 = "vehicle";
        if (!isdefined(level.var_8acfb18e)) {
            level.var_8acfb18e = 0;
        }
    #/
    level.var_8acfb18e++;
    if (level.var_8acfb18e == 1) {
        level thread namespace_dcf9c464::function_e4acaa37("vox_soph_security_system_orders_0", 0, 1, 0, 1);
    }
    a_str_locations = array("armory", "barracks", "command", "store", "supply", "tank");
    a_str_locations = array::randomize(a_str_locations);
    level function_18375f27(a_str_locations);
    level function_2868b6f4(0);
    level.var_178c3c6b = 0;
    level thread function_df3d4b2f();
    var_7953b28 = getentarray("ee_timed", "script_label");
    array::thread_all(var_7953b28, &function_82d88307, a_str_locations);
    var_2635052a = level util::waittill_any_return("ee_timed_complete", "ee_timed_failed");
    foreach (var_c2d73a21 in var_7953b28) {
        zm_unitrigger::unregister_unitrigger(var_c2d73a21.s_unitrigger);
        var_c2d73a21.s_unitrigger = undefined;
    }
    level.var_178c3c6b = undefined;
    if (var_2635052a == "ee_timed_complete") {
        level.var_49799ac6 = undefined;
        level function_2868b6f4();
        level namespace_dcf9c464::function_e4acaa37("vox_soph_security_system_success_0", 0, 1, 0, 1);
        /#
            if (isdefined(level.var_c91c0e41) && level.var_c91c0e41) {
                level.var_c91c0e41 = undefined;
                return;
            }
        #/
        level function_aeaa21eb();
        return 1;
    }
    level function_f715c0b9(var_7953b28);
    wait(1);
    foreach (var_c2d73a21 in var_7953b28) {
        var_c2d73a21 thread scene::play("p7_fxanim_zm_stal_rigged_button_retract_bundle", array(var_c2d73a21));
        var_c2d73a21 stoploopsound(2);
    }
    return 0;
}

// Namespace namespace_c5d72679
// Params 1, eflags: 0x1 linked
// namespace_c5d72679<file_0>::function_18375f27
// Checksum 0x434e1671, Offset: 0xa898
// Size: 0x5f4
function function_18375f27(a_str_locations) {
    mdl_map = getent("ee_map", "targetname");
    /#
        if (!isdefined(level.var_f0d11538)) {
            var_385ae3a2 = struct::get("vehicle", "vehicle");
            level.var_f0d11538 = spawn("vehicle", var_385ae3a2.origin);
        }
    #/
    level.var_f0d11538 playsound("zmb_scenarios_map_scenario_select");
    for (i = 0; i < 4; i++) {
        wait(0.4);
        foreach (str_location in a_str_locations) {
            str_tag = "tag_map_screen_glow_" + str_location;
            mdl_map showpart(str_tag);
        }
        level.var_f0d11538 playsound("zmb_scenarios_map_beep_higher");
        wait(0.4);
        foreach (str_location in a_str_locations) {
            str_tag = "tag_map_screen_glow_" + str_location;
            mdl_map hidepart(str_tag);
        }
    }
    var_bf616d4d = array::randomize(a_str_locations);
    foreach (var_796743e2 in var_bf616d4d) {
        str_tag = "tag_map_screen_glow_" + var_796743e2;
        wait(0.1);
        mdl_map showpart(str_tag);
        mdl_map playsound("zmb_scenarios_map_beep_higher");
        wait(0.1);
        mdl_map hidepart(str_tag);
    }
    foreach (str_location in a_str_locations) {
        str_tag = "tag_map_screen_glow_" + str_location;
        wait(0.3);
        mdl_map showpart(str_tag);
        mdl_map playsound("zmb_scenarios_map_beep_higher");
        wait(0.4);
        mdl_map hidepart(str_tag);
    }
    wait(0.1);
    for (i = 0; i < 4 - 1; i++) {
        foreach (str_location in a_str_locations) {
            str_tag = "tag_map_screen_glow_" + str_location;
            mdl_map showpart(str_tag);
        }
        level.var_f0d11538 playsound("zmb_scenarios_map_beep_higher");
        wait(0.4);
        foreach (str_location in a_str_locations) {
            str_tag = "tag_map_screen_glow_" + str_location;
            mdl_map hidepart(str_tag);
        }
        wait(0.4);
    }
    level.var_f0d11538 playsound("zmb_scenarios_map_scenario_select");
}

// Namespace namespace_c5d72679
// Params 0, eflags: 0x1 linked
// namespace_c5d72679<file_0>::function_df3d4b2f
// Checksum 0x74e7fd38, Offset: 0xae98
// Size: 0x24a
function function_df3d4b2f() {
    /#
        level endon(#"hash_9546144d");
    #/
    level endon(#"hash_a8cc6617");
    level endon(#"hash_8b96d575");
    level.var_f0d11538 playloopsound("zmb_finalcountdown_timer_tick", 0.1);
    if (level.players.size == 1) {
        level thread namespace_dcf9c464::function_e4acaa37("vox_soph_security_system_counter_3min_0");
        wait(60);
    }
    if (level.players.size < 3) {
        level thread namespace_dcf9c464::function_e4acaa37("vox_soph_security_system_counter_2min_0");
        playsoundatposition("zmb_finalcountdown_timer_marker", (0, 0, 0));
        wait(60);
    }
    if (level.players.size == 3) {
        playsoundatposition("zmb_finalcountdown_timer_marker", (0, 0, 0));
        wait(30);
    }
    playsoundatposition("zmb_finalcountdown_timer_marker", (0, 0, 0));
    level thread namespace_dcf9c464::function_e4acaa37("vox_soph_security_system_counter_1min_0");
    wait(30);
    playsoundatposition("zmb_finalcountdown_timer_marker", (0, 0, 0));
    level.var_f0d11538 playloopsound("zmb_finalcountdown_timer_tick_serious", 0.1);
    level thread namespace_dcf9c464::function_e4acaa37("vox_soph_security_system_counter_30sec_0");
    wait(20);
    playsoundatposition("zmb_finalcountdown_timer_marker", (0, 0, 0));
    level thread function_845d9fe9();
    level waittill(#"hash_78a07bbf");
    level.var_f0d11538 stoploopsound(0.1);
    level notify(#"hash_8b96d575");
}

// Namespace namespace_c5d72679
// Params 0, eflags: 0x1 linked
// namespace_c5d72679<file_0>::function_845d9fe9
// Checksum 0x94fbefd, Offset: 0xb0f0
// Size: 0xb2
function function_845d9fe9() {
    for (i = 10; i > 0; i--) {
        level namespace_dcf9c464::function_e4acaa37("vox_soph_security_system_counter_" + i + "sec_0", 0, 0, 0, 1);
        if (i == 3) {
            playsoundatposition("zmb_finalcountdown_timer_3secs", (0, 0, 0));
        }
        if (isdefined(level.var_e5f51155) && level.var_e5f51155) {
            level.var_e5f51155 = undefined;
            return;
        }
    }
    level notify(#"hash_78a07bbf");
}

// Namespace namespace_c5d72679
// Params 1, eflags: 0x1 linked
// namespace_c5d72679<file_0>::function_82d88307
// Checksum 0xaf9aca5f, Offset: 0xb1b0
// Size: 0x1f0
function function_82d88307(a_str_locations) {
    /#
        level endon(#"hash_9546144d");
    #/
    level endon(#"hash_8b96d575");
    self scene::play("p7_fxanim_zm_stal_rigged_button_extend_bundle", array(self));
    self playloopsound("zmb_rigged_button_alarm_lp", 3);
    self function_6e3a6092();
    var_d1033754 = "ee_timed_" + a_str_locations[level.var_178c3c6b];
    if (self.targetname != var_d1033754) {
        level.var_e5f51155 = 1;
        self playsound("zmb_rigged_button_press_bad");
        self stoploopsound(2);
        level.var_f0d11538 stoploopsound(0.1);
        level notify(#"hash_8b96d575");
        return;
    }
    self playsound("zmb_rigged_button_press_good");
    self stoploopsound(2);
    self scene::play("p7_fxanim_zm_stal_rigged_button_retract_bundle", array(self));
    if (level.var_178c3c6b == 5) {
        level.var_e5f51155 = 1;
        level notify(#"hash_a8cc6617");
        level.var_f0d11538 stoploopsound(0.1);
        return;
    }
    level.var_178c3c6b++;
}

// Namespace namespace_c5d72679
// Params 1, eflags: 0x1 linked
// namespace_c5d72679<file_0>::function_f715c0b9
// Checksum 0x3344d91f, Offset: 0xb3a8
// Size: 0x248
function function_f715c0b9(var_7953b28) {
    exploder::exploder("fxexp_708");
    foreach (var_c2d73a21 in var_7953b28) {
        var_c2d73a21 clientfield::increment("ee_timed_explosion_rumble");
        foreach (e_player in level.activeplayers) {
            if (isalive(e_player) && !(isdefined(e_player.var_4a416e6a) && e_player.var_4a416e6a)) {
                if (namespace_48c05c81::function_86b1188c(500, var_c2d73a21, e_player)) {
                    e_player dodamage(e_player.health + 666, e_player.origin);
                    e_player.var_4a416e6a = 1;
                }
            }
        }
    }
    foreach (e_player in level.players) {
        e_player.var_4a416e6a = undefined;
    }
}

// Namespace namespace_c5d72679
// Params 0, eflags: 0x1 linked
// namespace_c5d72679<file_0>::function_aeaa21eb
// Checksum 0x1446a9a, Offset: 0xb5f8
// Size: 0x44
function function_aeaa21eb() {
    struct::function_368120a1("scene", "p7_fxanim_zm_stal_rigged_button_extend_bundle");
    struct::function_368120a1("scene", "p7_fxanim_zm_stal_rigged_button_retract_bundle");
}

// Namespace namespace_c5d72679
// Params 0, eflags: 0x1 linked
// namespace_c5d72679<file_0>::function_21284834
// Checksum 0x53e75e42, Offset: 0xb648
// Size: 0x2e2
function function_21284834() {
    /#
        level.var_8b2f7f24 = "vehicle";
        if (!isdefined(level.var_9777b703)) {
            level.var_9777b703 = 0;
        }
    #/
    level.var_7f02c954 = struct::get_array("ee_pursue_position", "targetname");
    level.var_7f02c954 = array::randomize(level.var_7f02c954);
    var_4d7d0bda = array::pop_front(level.var_7f02c954, 0);
    level.var_a5fb1d00 = util::spawn_model("p7_fxanim_zm_stal_ray_gun_ball_mod", var_4d7d0bda.origin);
    level.var_a5fb1d00.takedamage = 1;
    level.var_a5fb1d00.var_92198510 = var_4d7d0bda;
    level.var_a5fb1d00.var_2b3fc782 = var_4d7d0bda;
    level.var_a5fb1d00.var_98b48961 = var_4d7d0bda;
    level.var_bce5f17f = 0;
    level.var_a5fb1d00.var_5149ab6f = 0;
    level.var_a5fb1d00 clientfield::set("ee_anomaly_loop", 1);
    var_be2ea7e9 = spawn("script_origin", var_4d7d0bda.origin);
    var_be2ea7e9 playloopsound("zmb_anomoly_loop", 0.5);
    var_be2ea7e9 linkto(level.var_a5fb1d00);
    var_be2ea7e9 thread function_2808099a();
    level.var_a5fb1d00 thread function_cfa09312();
    level.var_a5fb1d00 thread function_27541a6d();
    level thread function_6a47a4e9();
    var_e25d11fd = level util::waittill_any_return("ee_pursue_complete", "ee_pursue_failed");
    if (var_e25d11fd == "ee_pursue_complete") {
        level.var_7f02c954 = undefined;
        level.var_bce5f17f = undefined;
        level.var_a5fb1d00 = undefined;
        /#
            if (isdefined(level.var_c91c0e41) && level.var_c91c0e41) {
                level.var_c91c0e41 = undefined;
                return;
            }
        #/
        level function_9aede4e6();
        return 1;
    }
    return 0;
}

// Namespace namespace_c5d72679
// Params 0, eflags: 0x1 linked
// namespace_c5d72679<file_0>::function_6a47a4e9
// Checksum 0x4fa25d94, Offset: 0xb938
// Size: 0x5c
function function_6a47a4e9() {
    level.var_9777b703++;
    if (level.var_9777b703 == 1) {
        level namespace_dcf9c464::function_e4acaa37("vox_soph_anomaly_orders_0", 0, 1, 0, 1);
    }
    level function_2868b6f4(0);
}

// Namespace namespace_c5d72679
// Params 0, eflags: 0x1 linked
// namespace_c5d72679<file_0>::function_2808099a
// Checksum 0x4322416a, Offset: 0xb9a0
// Size: 0x44
function function_2808099a() {
    level waittill(#"hash_2850c4f2");
    self stoploopsound(0.5);
    self delete();
}

// Namespace namespace_c5d72679
// Params 1, eflags: 0x1 linked
// namespace_c5d72679<file_0>::function_cfa09312
// Checksum 0x1ebe4cc5, Offset: 0xb9f0
// Size: 0x294
function function_cfa09312(var_cffe61ab) {
    if (!isdefined(var_cffe61ab)) {
        var_cffe61ab = 0;
    }
    /#
        level endon(#"hash_9546144d");
    #/
    self endon(#"hash_43b373a7");
    level endon(#"hash_40282cc8");
    b_damaged = 0;
    self thread function_77e01bd0();
    while (true) {
        var_6db1518a = function_4981184b();
        self.var_98b48961 = self.var_2b3fc782;
        self.var_2b3fc782 = self.var_92198510;
        self.var_92198510 = var_6db1518a;
        if (var_cffe61ab) {
            var_cffe61ab = 0;
            var_46b0f218 = self function_5e9a73bf(300);
        } else if (b_damaged) {
            var_46b0f218 = self function_5e9a73bf(-68);
        } else {
            var_1f1d4ae6 = distance(self.var_92198510.origin, self.var_2b3fc782.origin);
            var_46b0f218 = var_1f1d4ae6 / -108;
        }
        if (var_46b0f218 < 2) {
            n_accel = var_46b0f218 * 0.5;
        } else {
            n_accel = 1;
        }
        self moveto(self.var_92198510.origin, var_46b0f218, n_accel, n_accel);
        self waittill(#"movedone");
        self thread function_54457756();
        str_notify = self util::waittill_any_return("pap_damage", "keep_wandering", "death", "step_complete", "ee_pursue_failed");
        if (str_notify === "pap_damage" || str_notify === "death") {
            b_damaged = 1;
            wait(0.75);
            continue;
        }
        b_damaged = 0;
    }
}

// Namespace namespace_c5d72679
// Params 0, eflags: 0x1 linked
// namespace_c5d72679<file_0>::function_4981184b
// Checksum 0xada8a9a4, Offset: 0xbc90
// Size: 0xf4
function function_4981184b() {
    if (function_4b3ee36b()) {
        level.var_7f02c954 = struct::get_array("ee_pursue_position", "targetname");
        level.var_7f02c954 = array::randomize(level.var_7f02c954);
    }
    while (true) {
        if (level.var_bce5f17f >= level.var_7f02c954.size) {
            level.var_bce5f17f = 0;
        }
        var_6db1518a = level.var_7f02c954[level.var_bce5f17f];
        if (function_44084295(var_6db1518a)) {
            arrayremovevalue(level.var_7f02c954, var_6db1518a);
            return var_6db1518a;
        }
        level.var_bce5f17f++;
    }
}

// Namespace namespace_c5d72679
// Params 0, eflags: 0x1 linked
// namespace_c5d72679<file_0>::function_4b3ee36b
// Checksum 0x8cdfcffa, Offset: 0xbd90
// Size: 0x94
function function_4b3ee36b() {
    foreach (s_position in level.var_7f02c954) {
        if (function_44084295(s_position)) {
            return false;
        }
    }
    return true;
}

// Namespace namespace_c5d72679
// Params 1, eflags: 0x1 linked
// namespace_c5d72679<file_0>::function_44084295
// Checksum 0xd7041ddb, Offset: 0xbe30
// Size: 0xbe
function function_44084295(s_destination) {
    if (level.var_a5fb1d00.var_2b3fc782.script_string == s_destination.script_string || level.var_a5fb1d00.var_98b48961.script_string == s_destination.script_string || level.var_a5fb1d00.var_92198510.script_string == s_destination.script_string) {
        return false;
    }
    if (namespace_48c05c81::function_86b1188c(1750, level.var_a5fb1d00, s_destination)) {
        return false;
    }
    return true;
}

// Namespace namespace_c5d72679
// Params 1, eflags: 0x1 linked
// namespace_c5d72679<file_0>::function_5e9a73bf
// Checksum 0x4ffd8c29, Offset: 0xbef8
// Size: 0x2bc
function function_5e9a73bf(var_43a6be37) {
    level endon(#"hash_40282cc8");
    self endon(#"hash_43b373a7");
    var_430ccf88 = struct::get("ee_pursue_arrival_" + self.var_92198510.script_string, "targetname");
    self playsound("zmb_anomoly_takeoff");
    for (i = 0; i <= 8; i++) {
        var_979a6a0c = var_430ccf88.origin[0] + randomfloatrange(-200, -56);
        var_bd9ce475 = var_430ccf88.origin[1] + randomfloatrange(-200, -56);
        var_e39f5ede = var_430ccf88.origin[2] + randomfloatrange(-200, -56);
        if (i == 0) {
            var_a29e3923 = distance(self.origin, (var_979a6a0c, var_bd9ce475, var_e39f5ede));
            var_add151b1 = var_a29e3923 / var_43a6be37;
            self moveto((var_979a6a0c, var_bd9ce475, var_e39f5ede), var_add151b1, 0.2);
        } else if (i == 8) {
            self moveto((var_979a6a0c, var_bd9ce475, var_e39f5ede), 0.3, 0, 0.3);
        } else {
            self moveto((var_979a6a0c, var_bd9ce475, var_e39f5ede), 0.3);
        }
        self waittill(#"movedone");
    }
    wait(1);
    var_8acc78ca = distance(self.origin, self.var_92198510.origin);
    var_46b0f218 = var_8acc78ca / -108;
    return var_46b0f218;
}

// Namespace namespace_c5d72679
// Params 0, eflags: 0x1 linked
// namespace_c5d72679<file_0>::function_54457756
// Checksum 0x207d77b2, Offset: 0xc1c0
// Size: 0x62
function function_54457756() {
    /#
        level endon(#"hash_9546144d");
    #/
    level endon(#"hash_40282cc8");
    self endon(#"hash_10ec321c");
    var_9add3f18 = randomfloatrange(20, 30);
    wait(var_9add3f18);
    self notify(#"hash_ef42146");
}

// Namespace namespace_c5d72679
// Params 0, eflags: 0x1 linked
// namespace_c5d72679<file_0>::function_77e01bd0
// Checksum 0x71bea39a, Offset: 0xc230
// Size: 0xcc
function function_77e01bd0() {
    level endon(#"hash_40282cc8");
    self endon(#"hash_43b373a7");
    if (self namespace_48c05c81::function_1af75b1b(750)) {
        wait(randomintrange(5, 10));
    }
    while (true) {
        if (self.var_5149ab6f >= 7) {
            return;
        }
        if (self namespace_48c05c81::function_1af75b1b(750)) {
            self thread namespace_dcf9c464::function_e4acaa37("vox_gers_gersch_chatter_" + self.var_5149ab6f);
            self.var_5149ab6f++;
            wait(30);
        }
        wait(3);
    }
}

// Namespace namespace_c5d72679
// Params 0, eflags: 0x1 linked
// namespace_c5d72679<file_0>::function_27541a6d
// Checksum 0x6c10207e, Offset: 0xc308
// Size: 0x300
function function_27541a6d() {
    /#
        level endon(#"hash_9546144d");
    #/
    level endon(#"hash_40282cc8");
    var_b0a541cb = 6500 + 1000 * zm_utility::get_number_of_valid_players();
    /#
        if (isdefined(level.var_f9c3fe97) && level.var_f9c3fe97) {
            var_b0a541cb = 5;
        }
    #/
    n_current_health = var_b0a541cb;
    n_step = 0;
    while (true) {
        self.var_44b9cab5 = 0;
        self thread function_182fe200();
        amount, attacker, direction, point, mod, tagname, modelname, partname, weapon = self waittill(#"damage");
        if (isplayer(attacker) && zm_weapons::is_weapon_upgraded(weapon)) {
            self notify(#"hash_10ec321c");
            self.var_44b9cab5 = 1;
            n_current_health -= amount;
            if (n_current_health <= 0) {
                self notify(#"hash_43b373a7");
                self moveto(self.origin, 0.1);
                self clientfield::set("ee_anomaly_loop", 0);
                self playsound("zmb_anomoly_dmg_hit");
                level thread function_4b5b4aeb(n_step);
                level waittill(#"hash_f9b2d970");
                level.var_a5fb1d00 clientfield::set("ee_anomaly_loop", 1);
                n_step++;
                n_current_health = var_b0a541cb;
                if (n_step == 3) {
                    self function_48dcad89();
                    level notify(#"hash_3f897f2");
                    return;
                }
                self thread function_cfa09312(1);
                continue;
            }
            self clientfield::increment("ee_anomaly_hit");
            self playsound("zmb_anomoly_reg_hit");
        }
    }
}

// Namespace namespace_c5d72679
// Params 1, eflags: 0x1 linked
// namespace_c5d72679<file_0>::function_4b5b4aeb
// Checksum 0xb0acc0f9, Offset: 0xc610
// Size: 0xb2
function function_4b5b4aeb(n_step) {
    switch (n_step) {
    case 0:
        level namespace_dcf9c464::function_e4acaa37("vox_gers_anomaly_shoot_first_0", 0, 1, 0, 1);
        break;
    case 1:
        level namespace_dcf9c464::function_e4acaa37("vox_gers_anomaly_shoot_second_0", 0, 1, 0, 1);
        break;
    case 2:
        level namespace_dcf9c464::function_460341f9();
        break;
    }
    level notify(#"hash_f9b2d970");
}

// Namespace namespace_c5d72679
// Params 0, eflags: 0x1 linked
// namespace_c5d72679<file_0>::function_182fe200
// Checksum 0xe1889f5, Offset: 0xc6d0
// Size: 0xa4
function function_182fe200() {
    self endon(#"hash_43b373a7");
    self endon(#"hash_10ec321c");
    wait(120);
    if (isdefined(self.var_44b9cab5) && self.var_44b9cab5) {
        return;
    }
    level notify(#"hash_40282cc8");
    self notify(#"hash_40282cc8");
    self clientfield::set("ee_anomaly_loop", 0);
    util::wait_network_frame();
    self delete();
}

// Namespace namespace_c5d72679
// Params 0, eflags: 0x1 linked
// namespace_c5d72679<file_0>::function_48dcad89
// Checksum 0x5a699582, Offset: 0xc780
// Size: 0x1a4
function function_48dcad89() {
    var_ded11e7d = struct::get("ee_pursue_pre_capture", "targetname");
    self moveto(var_ded11e7d.origin, 12, 1, 1);
    level thread namespace_dcf9c464::function_e4acaa37("vox_soph_anomaly_success_0", 2.5, 1, 0, 1);
    self waittill(#"movedone");
    self clientfield::set("ee_anomaly_loop", 0);
    var_ded11e7d struct::delete();
    level function_9c8afe2b();
    level function_2868b6f4();
    s_capture_point = struct::get("ee_capture_point", "targetname");
    self moveto(s_capture_point.origin + (0, 0, 48), 4, 0.5);
    self waittill(#"movedone");
    level thread function_694a61ea(self, 0);
    level namespace_dcf9c464::function_7c3ff8b2();
}

// Namespace namespace_c5d72679
// Params 0, eflags: 0x1 linked
// namespace_c5d72679<file_0>::function_9aede4e6
// Checksum 0x559499ee, Offset: 0xc930
// Size: 0xa4
function function_9aede4e6() {
    var_5fe3b92d = struct::get_array("ee_pursue_position", "targetname");
    array::run_all(var_5fe3b92d, &struct::delete);
    var_952f535d = struct::get_array("ee_pursue_arrival", "script_label");
    array::run_all(var_952f535d, &struct::delete);
}

// Namespace namespace_c5d72679
// Params 0, eflags: 0x1 linked
// namespace_c5d72679<file_0>::function_101e5b38
// Checksum 0xdd386e58, Offset: 0xc9e0
// Size: 0x150
function function_101e5b38() {
    /#
        level.var_8b2f7f24 = "vehicle";
    #/
    callback::on_connect(&function_4e70c56d);
    array::run_all(level.players, &function_4e70c56d);
    level thread function_c6ed1025();
    level function_94d0ca21();
    callback::remove_on_connect(&function_4e70c56d);
    level function_858f4a7e();
    level function_600265ae();
    /#
        if (isdefined(level.var_c91c0e41) && level.var_c91c0e41) {
            level.var_c91c0e41 = undefined;
            return;
        }
    #/
    var_46273a16 = struct::get("ee_koth_terminal_use", "targetname");
    var_46273a16 struct::delete();
    return 1;
}

// Namespace namespace_c5d72679
// Params 0, eflags: 0x1 linked
// namespace_c5d72679<file_0>::function_c6ed1025
// Checksum 0x54c02fbb, Offset: 0xcb38
// Size: 0x44
function function_c6ed1025() {
    level namespace_dcf9c464::function_e4acaa37("vox_soph_data_orders_0", 0, 1, 0, 1);
    level function_2868b6f4(0);
}

// Namespace namespace_c5d72679
// Params 0, eflags: 0x1 linked
// namespace_c5d72679<file_0>::function_94d0ca21
// Checksum 0xab0a9071, Offset: 0xcb88
// Size: 0x28c
function function_94d0ca21() {
    var_385ae3a2 = struct::get("ee_map_button_struct", "targetname");
    var_78d02c88 = getent("ee_map_shelf", "targetname");
    var_b465a89c = var_78d02c88 gettagorigin("wall_map_shelf_door");
    mdl_key = util::spawn_model("p7_zm_ctl_keycard_ee", var_b465a89c + (-5, 0, -2), (90, 0, 0));
    mdl_key linkto(var_78d02c88, "wall_map_shelf_door");
    var_78d02c88 scene::play("p7_fxanim_zm_stal_wall_map_drawer_open_bundle", var_78d02c88);
    level thread function_978eeda3();
    mdl_key function_6e3a6092(100, %ZM_STALINGRAD_KEY_CARD);
    level notify(#"hash_b9c7ec1b");
    mdl_key playsound("zmb_scenario_torrent_key_grab");
    mdl_key delete();
    var_78d02c88 thread scene::play("p7_fxanim_zm_stal_wall_map_drawer_close_bundle", var_78d02c88);
    var_46273a16 = struct::get("ee_koth_terminal_use", "targetname");
    var_dc6bf246 = getent("ee_koth_terminal", "targetname");
    var_46273a16 thread function_7eac301b();
    var_dc6bf246 function_1a5b6f26();
    var_dc6bf246 function_9906da8b(1);
    zm_unitrigger::unregister_unitrigger(var_46273a16.s_unitrigger);
    var_46273a16.s_unitrigger = undefined;
    level thread function_b7beb50b();
}

// Namespace namespace_c5d72679
// Params 0, eflags: 0x1 linked
// namespace_c5d72679<file_0>::function_978eeda3
// Checksum 0x24b3b32c, Offset: 0xce20
// Size: 0x76
function function_978eeda3() {
    level endon(#"hash_b9c7ec1b");
    for (var_80d8d5fa = 0; var_80d8d5fa < 2; var_80d8d5fa++) {
        wait(30);
        level thread namespace_dcf9c464::function_e4acaa37("vox_soph_data_take_disk_" + var_80d8d5fa + "_0");
    }
}

// Namespace namespace_c5d72679
// Params 1, eflags: 0x1 linked
// namespace_c5d72679<file_0>::function_9906da8b
// Checksum 0xe7c6939f, Offset: 0xcea0
// Size: 0xcc
function function_9906da8b(var_9217ed20) {
    if (var_9217ed20) {
        exploder::exploder("dataterminal_on");
        self showpart("tag_dragon_network_console_terminal_screen_green");
        self hidepart("tag_dragon_network_console_terminal_screen_red");
        return;
    }
    exploder::stop_exploder("dataterminal_on");
    self hidepart("tag_dragon_network_console_terminal_screen_green");
    self showpart("tag_dragon_network_console_terminal_screen_red");
}

// Namespace namespace_c5d72679
// Params 0, eflags: 0x1 linked
// namespace_c5d72679<file_0>::function_7eac301b
// Checksum 0xd407e234, Offset: 0xcf78
// Size: 0x78
function function_7eac301b() {
    level endon(#"hash_8cc49f44");
    self zm_unitrigger::create_unitrigger("", 100, &function_20cd9521, &function_8e92625b);
    zm_unitrigger::unitrigger_force_per_player_triggers(self.s_unitrigger, 1);
    self.var_ef53764e = 1;
}

// Namespace namespace_c5d72679
// Params 1, eflags: 0x1 linked
// namespace_c5d72679<file_0>::function_20cd9521
// Checksum 0x4b592f, Offset: 0xcff8
// Size: 0x3c
function function_20cd9521(e_player) {
    if (e_player flag::get("ee_koth_terminal_used")) {
        return 0;
    }
    return 1;
}

// Namespace namespace_c5d72679
// Params 0, eflags: 0x1 linked
// namespace_c5d72679<file_0>::function_8e92625b
// Checksum 0x15680a25, Offset: 0xd040
// Size: 0x198
function function_8e92625b() {
    self endon(#"death");
    var_46273a16 = self.stub.related_parent;
    while (true) {
        e_who = self waittill(#"trigger");
        if (isdefined(var_46273a16.var_ef53764e) && var_46273a16.var_ef53764e) {
            var_46273a16.var_ef53764e = undefined;
            var_46273a16.mdl_key = util::spawn_model("p7_zm_ctl_keycard_ee", var_46273a16.origin + (0.25, 13, -14.75), var_46273a16.angles + (90, -90, 0));
            var_46273a16.mdl_key playsound("zmb_scenario_torrent_key_insert");
            var_46273a16.mdl_key movey(4, 1);
        }
        var_46273a16.mdl_key playsound("zmb_scenarios_button_activate");
        e_who thread function_3f204480();
        e_who flag::set("ee_koth_terminal_used");
    }
}

// Namespace namespace_c5d72679
// Params 1, eflags: 0x1 linked
// namespace_c5d72679<file_0>::function_3f204480
// Checksum 0x60edde8e, Offset: 0xd1e0
// Size: 0xa4
function function_3f204480(s_unitrigger) {
    self endon(#"death");
    self endon(#"hash_8cc49f44");
    var_a0411846 = getent("ee_koth_terminal_volume", "targetname");
    while (true) {
        if (!self istouching(var_a0411846)) {
            self flag::clear("ee_koth_terminal_used");
            break;
        }
        wait(0.1);
    }
}

// Namespace namespace_c5d72679
// Params 0, eflags: 0x1 linked
// namespace_c5d72679<file_0>::function_1a5b6f26
// Checksum 0x7889d381, Offset: 0xd290
// Size: 0x28a
function function_1a5b6f26() {
    level endon(#"end_game");
    for (i = 1; i <= 4; i++) {
        self clientfield::set("ee_koth_light_" + i, 1);
    }
    util::wait_network_frame();
    while (true) {
        var_693be8d4 = 4 - level.players.size;
        var_cb91e1e5 = 0;
        foreach (e_player in level.players) {
            if (e_player flag::get("ee_koth_terminal_used")) {
                var_693be8d4++;
            }
        }
        for (i = 1; i <= var_693be8d4; i++) {
            self clientfield::set("ee_koth_light_" + i, 2);
            self showpart("tag_dragon_network_console_terminal_light_green_0" + i);
            self hidepart("tag_dragon_network_console_terminal_light_red_0" + i);
            var_cb91e1e5++;
        }
        if (var_693be8d4 == 4) {
            break;
        }
        for (i = var_cb91e1e5 + 1; i <= 4; i++) {
            self clientfield::set("ee_koth_light_" + i, 1);
            self showpart("tag_dragon_network_console_terminal_light_red_0" + i);
            self hidepart("tag_dragon_network_console_terminal_light_green_0" + i);
        }
        wait(0.05);
    }
    level notify(#"hash_8cc49f44");
}

// Namespace namespace_c5d72679
// Params 0, eflags: 0x1 linked
// namespace_c5d72679<file_0>::function_b7beb50b
// Checksum 0x3e221f49, Offset: 0xd528
// Size: 0x1a4
function function_b7beb50b() {
    /#
        level endon(#"hash_9546144d");
    #/
    level.var_2cd0f4a0 = -76;
    level.var_cd867f7a = 0;
    /#
        if (isdefined(level.var_f9c3fe97) && level.var_f9c3fe97) {
            level.var_2cd0f4a0 = 5;
        }
    #/
    array::thread_all(level.players, &function_7ef0d0cc);
    level thread namespace_dcf9c464::function_e4acaa37("vox_soph_data_lockdown_0", 0, 1, 0, 1);
    var_700aab72 = 0;
    var_17c47d04 = getent("ee_koth_terminal", "targetname");
    var_17c47d04 playsound("zmb_scenario_torrent_start");
    var_17c47d04 playloopsound("zmb_scenario_torrent_lp", 3);
    while (level.var_cd867f7a < level.var_2cd0f4a0) {
        wait(1);
        level.var_cd867f7a++;
    }
    var_17c47d04 playsound("zmb_scenario_torrent_end");
    var_17c47d04 stoploopsound(0.5);
    level flag::set("ee_lockdown_complete");
}

// Namespace namespace_c5d72679
// Params 0, eflags: 0x1 linked
// namespace_c5d72679<file_0>::function_858f4a7e
// Checksum 0x34230bb9, Offset: 0xd6d8
// Size: 0x1bc
function function_858f4a7e() {
    /#
        level endon(#"hash_9546144d");
    #/
    if (zm_utility::get_number_of_valid_players() == 1) {
        var_5fa4ff40 = 3.75;
        var_2bb91d99 = zm_utility::get_number_of_valid_players() + 2;
        var_77e8a424 = var_2bb91d99 * 2;
    } else if (zm_utility::get_number_of_valid_players() == 2) {
        var_5fa4ff40 = 2.5;
        var_2bb91d99 = zm_utility::get_number_of_valid_players() + 3;
        var_77e8a424 = var_2bb91d99 + zm_utility::get_number_of_valid_players() * 2;
    } else {
        var_5fa4ff40 = 1.5;
        var_2bb91d99 = zm_utility::get_number_of_valid_players() + 4;
        var_77e8a424 = var_2bb91d99 * 2;
    }
    level.var_141e2500 = 1;
    level function_e394c743(1);
    level namespace_b57650e4::function_2c6fd7(var_77e8a424, var_2bb91d99, var_5fa4ff40, "ee_lockdown_complete");
    level.var_141e2500 = undefined;
    level function_e394c743(0);
    level thread namespace_dcf9c464::function_e4acaa37("vox_soph_data_success_0", 0, 1, 0, 1);
}

// Namespace namespace_c5d72679
// Params 0, eflags: 0x1 linked
// namespace_c5d72679<file_0>::function_600265ae
// Checksum 0x2c5b4959, Offset: 0xd8a0
// Size: 0x1b4
function function_600265ae() {
    var_dc6bf246 = getent("ee_koth_terminal", "targetname");
    var_dc6bf246 function_9906da8b(0);
    for (i = 1; i <= 4; i++) {
        var_dc6bf246 clientfield::set("ee_koth_light_" + i, 0);
        var_dc6bf246 showpart("tag_dragon_network_console_terminal_light_red_0" + i);
        var_dc6bf246 hidepart("tag_dragon_network_console_terminal_light_green_0" + i);
    }
    var_46273a16 = struct::get("ee_koth_terminal_use", "targetname");
    var_46273a16 function_6e3a6092(100, %ZM_STALINGRAD_KEY_CARD);
    var_46273a16.mdl_key playsound("zmb_scenario_torrent_key_grab");
    var_46273a16.mdl_key delete();
    level function_d9d36a17("p7_zm_ctl_keycard_ee", %ZM_STALINGRAD_KEY_CARD_DEPOSIT, (-90, -76, 0));
}

// Namespace namespace_c5d72679
// Params 1, eflags: 0x1 linked
// namespace_c5d72679<file_0>::function_e394c743
// Checksum 0x367951be, Offset: 0xda60
// Size: 0x9a
function function_e394c743(var_f2469810) {
    foreach (e_player in level.players) {
        e_player clientfield::set_to_player("ee_lockdown_fog", var_f2469810);
    }
}

// Namespace namespace_c5d72679
// Params 2, eflags: 0x1 linked
// namespace_c5d72679<file_0>::function_7ef0d0cc
// Checksum 0xca687986, Offset: 0xdb08
// Size: 0xf6
function function_7ef0d0cc(n_start_time, var_2cd0f4a0) {
    self endon(#"death");
    self.usebar = self function_64a35779();
    self.var_6adb8298 = self function_73e24bb9();
    self.var_6adb8298 settext(%ZM_STALINGRAD_DOWNLOAD_PROGRESS);
    self function_6199ca7e();
    if (isdefined(self.var_6adb8298)) {
        self.var_6adb8298 hud::destroyelem();
        self.var_6adb8298 = undefined;
    }
    if (isdefined(self.usebar)) {
        self.usebar hud::destroyelem();
        self.usebar = undefined;
    }
}

// Namespace namespace_c5d72679
// Params 0, eflags: 0x1 linked
// namespace_c5d72679<file_0>::function_6199ca7e
// Checksum 0x98b15289, Offset: 0xdc08
// Size: 0xa0
function function_6199ca7e() {
    self endon(#"death");
    level endon(#"hash_6512cf4f");
    level endon(#"end_game");
    while (true) {
        n_progress = level.var_cd867f7a / level.var_2cd0f4a0;
        if (n_progress < 0) {
            n_progress = 0;
        }
        if (n_progress > 1) {
            n_progress = 1;
        }
        self.usebar hud::updatebar(n_progress);
        wait(0.05);
    }
}

// Namespace namespace_c5d72679
// Params 0, eflags: 0x1 linked
// namespace_c5d72679<file_0>::function_64a35779
// Checksum 0xac6e49c, Offset: 0xdcb0
// Size: 0x108
function function_64a35779() {
    if (self issplitscreen()) {
        var_2cf8c6d2 = -75;
        var_52fb413b = -51;
        var_cf35e8e9 = "TOP";
        var_16d3e5b2 = 80;
        var_cb7f5b1b = 5;
    } else {
        var_2cf8c6d2 = 0;
        var_52fb413b = -81;
        var_cf35e8e9 = "CENTER";
        var_16d3e5b2 = level.primaryprogressbarwidth;
        var_cb7f5b1b = level.primaryprogressbarheight;
    }
    bar = hud::createbar((1, 1, 1), var_16d3e5b2, var_cb7f5b1b);
    bar hud::setpoint(var_cf35e8e9, undefined, var_2cf8c6d2, var_52fb413b);
    return bar;
}

// Namespace namespace_c5d72679
// Params 0, eflags: 0x1 linked
// namespace_c5d72679<file_0>::function_73e24bb9
// Checksum 0x9c8e5380, Offset: 0xddc0
// Size: 0x104
function function_73e24bb9() {
    if (self issplitscreen()) {
        var_a84ec5dc = -75;
        var_ce514045 = -65;
        var_cf35e8e9 = "TOP";
        var_2efa8e9 = 1;
    } else {
        var_a84ec5dc = 0;
        var_ce514045 = -95;
        var_cf35e8e9 = "CENTER";
        var_2efa8e9 = level.primaryprogressbarfontsize;
    }
    text = hud::createfontstring("objective", var_2efa8e9);
    text hud::setpoint(var_cf35e8e9, undefined, var_a84ec5dc, var_ce514045);
    text.sort = -1;
    return text;
}

// Namespace namespace_c5d72679
// Params 0, eflags: 0x1 linked
// namespace_c5d72679<file_0>::function_4e70c56d
// Checksum 0x63168b20, Offset: 0xded0
// Size: 0x24
function function_4e70c56d() {
    self flag::init("ee_koth_terminal_used");
}

// Namespace namespace_c5d72679
// Params 0, eflags: 0x1 linked
// namespace_c5d72679<file_0>::function_914bd2ef
// Checksum 0x70d9e65, Offset: 0xdf00
// Size: 0x274
function function_914bd2ef() {
    level flag::wait_till("scenarios_complete");
    level function_2868b6f4();
    level namespace_dcf9c464::function_ececbc4b();
    var_c6ca3fd9 = util::spawn_model("veh_t7_dlc3_mech_nikolai_weapon_core", level.var_a090a655 gettagorigin("tag_weapon_cores") + (0, 3, 2));
    var_c6ca3fd9 setscale(0.75);
    level thread function_777295a0();
    level.var_a090a655 scene::play("p7_fxanim_zm_stal_computer_sophia_core_door_open_bundle");
    var_c6ca3fd9 function_6e3a6092(100, %ZM_STALINGRAD_WEAPON_CORES);
    var_c6ca3fd9 delete();
    level notify(#"hash_deeb3634");
    level clientfield::set("sophia_intro_outro", 0);
    level thread function_4b5f4145();
    level thread function_957ac17d();
    var_e782bc88 = getent("ee_weapon_cores_volume", "targetname");
    level namespace_48c05c81::function_f8043960(&function_2a7e8fc9, var_e782bc88);
    level namespace_dcf9c464::function_732b874f();
    level flag::set("weapon_cores_delivered");
    var_af8a18df = struct::get("ee_sophia_struct", "targetname");
    zm_unitrigger::unregister_unitrigger(var_af8a18df.s_unitrigger);
    var_af8a18df struct::delete();
}

// Namespace namespace_c5d72679
// Params 0, eflags: 0x1 linked
// namespace_c5d72679<file_0>::function_777295a0
// Checksum 0x7fc06d4b, Offset: 0xe180
// Size: 0x44
function function_777295a0() {
    level namespace_dcf9c464::function_e4acaa37("vox_soph_ascension_complete_resp_1_0", 0, 1, 0, 1);
    level function_2868b6f4(0);
}

// Namespace namespace_c5d72679
// Params 0, eflags: 0x1 linked
// namespace_c5d72679<file_0>::function_2a7e8fc9
// Checksum 0xe08c32da, Offset: 0xe1d0
// Size: 0x1b0
function function_2a7e8fc9() {
    self clientfield::increment_to_player("interact_rumble");
    var_7694d290 = util::spawn_model("veh_t7_dlc3_mech_nikolai_weapon_core", self.var_4bd1ce6b gettagorigin("j_ankle_2_ri_anim") - (0, 0, 2));
    var_7694d290 setscale(0.75);
    var_7694d290 linkto(self.var_4bd1ce6b, "j_ankle_2_ri_anim");
    self.var_4bd1ce6b thread function_69e4f202(var_7694d290);
    var_1f3ae034 = struct::get("ee_core_end_struct", "targetname");
    var_57ae0247 = self.var_4bd1ce6b getclosestpointonnavvolume(var_1f3ae034.origin, 100);
    self.var_4bd1ce6b setvehgoalpos(var_57ae0247, 1, 1);
    if (self.var_4bd1ce6b vehicle_ai::waittill_pathresult()) {
        self.var_4bd1ce6b vehicle_ai::waittill_pathing_done();
    }
    var_7694d290 delete();
    return true;
}

// Namespace namespace_c5d72679
// Params 1, eflags: 0x1 linked
// namespace_c5d72679<file_0>::function_69e4f202
// Checksum 0x6966b2b1, Offset: 0xe388
// Size: 0x3c
function function_69e4f202(var_7694d290) {
    var_7694d290 endon(#"death");
    self waittill(#"death");
    var_7694d290 delete();
}

// Namespace namespace_c5d72679
// Params 0, eflags: 0x1 linked
// namespace_c5d72679<file_0>::function_e0c4c3a8
// Checksum 0x2c3bfb39, Offset: 0xe3d0
// Size: 0x1fc
function function_e0c4c3a8() {
    level flag::wait_till("weapon_cores_delivered");
    level function_fa7fbd4c(0);
    while (!level.var_a090a655 namespace_48c05c81::function_1af75b1b(500)) {
        wait(1);
    }
    level function_2868b6f4();
    exploder::stop_exploder("fxexp_604");
    level namespace_dcf9c464::function_6f2aecbd();
    level thread scene::play("p7_fxanim_zm_stal_computer_sophia_bundle");
    level thread namespace_dcf9c464::function_ea234d37();
    level waittill(#"hash_34e4b03f");
    level.var_a090a655 thread scene::play("p7_fxanim_zm_stal_computer_sophia_leave_bundle");
    level.var_a090a655 waittill(#"hash_6c477355");
    exploder::exploder("ex_sophia_end");
    var_4c895b30 = getent("ee_sophia_clip", "targetname");
    var_4c895b30 connectpaths();
    var_4c895b30 movex(114, 1);
    level function_2868b6f4(0);
    level flag::set("sophia_escaped");
    var_4c895b30 waittill(#"movedone");
    var_4c895b30 disconnectpaths();
}

// Namespace namespace_c5d72679
// Params 0, eflags: 0x1 linked
// namespace_c5d72679<file_0>::function_d47c68fb
// Checksum 0x7e27a8e8, Offset: 0xe5d8
// Size: 0x322
function function_d47c68fb() {
    level flag::wait_till("sophia_escaped");
    var_5f255c08 = getent("ee_hatch_collision", "targetname");
    var_5f255c08 thread function_a9e72613();
    var_465422bb = struct::get("ee_boss_start", "targetname");
    var_465422bb thread function_e957e3bc();
    var_47ee7db6 = getent("ee_veh_sewer_cam", "targetname");
    nd_path_start = getvehiclenode("ee_sewer_rail_start", "targetname");
    var_a9352214 = getent("ee_sewer_to_arena_trig", "targetname");
    var_a9352214.var_9469fd43 = 0;
    while (var_a9352214.var_9469fd43 < level.players.size) {
        e_who = var_a9352214 waittill(#"trigger");
        if (!(isdefined(e_who.var_a0a9409e) && e_who.var_a0a9409e)) {
            var_a9352214.var_9469fd43++;
            namespace_e81d2518::function_e4dfcf7c();
            e_who.var_a0a9409e = 1;
            e_who thread namespace_48c05c81::function_5eeabbe0(var_47ee7db6, nd_path_start, undefined, "player_enter_boss_arena");
        }
    }
    var_a9352214 delete();
    level thread function_deda2d7a();
    level scene::init("p7_fxanim_zm_stal_computer_sophia_base_bundle");
    var_5f255c08 solid();
    var_1a085458 = getentarray("hatch_slick_clip", "targetname");
    foreach (var_1a11e11 in var_1a085458) {
        var_1a11e11 delete();
        util::wait_network_frame();
    }
}

// Namespace namespace_c5d72679
// Params 0, eflags: 0x1 linked
// namespace_c5d72679<file_0>::function_a9e72613
// Checksum 0xfbba6a22, Offset: 0xe908
// Size: 0x220
function function_a9e72613() {
    var_af81398 = getent("ee_sewer_hatch_trig", "targetname");
    while (true) {
        if (var_af81398 function_2b042a95()) {
            n_end_time = gettime() + 1 * 1000;
            wait(0.25);
            while (var_af81398 function_2b042a95()) {
                if (gettime() >= n_end_time) {
                    level thread function_2868b6f4(1, undefined, 0);
                    self clientfield::set("ee_hatch_break_rumble", 1);
                    level thread scene::play("p7_fxanim_zm_stal_computer_sophia_base_bundle");
                    var_1a085458 = getentarray("hatch_slick_clip", "targetname");
                    array::run_all(var_1a085458, &solid);
                    foreach (e_player in level.players) {
                        e_player.var_fa6d2a24 = 1;
                    }
                    wait(0.25);
                    self notsolid();
                    var_af81398 delete();
                    return;
                }
                wait(0.25);
            }
        }
        wait(0.25);
    }
}

// Namespace namespace_c5d72679
// Params 0, eflags: 0x1 linked
// namespace_c5d72679<file_0>::function_2b042a95
// Checksum 0xbed68238, Offset: 0xeb30
// Size: 0xf6
function function_2b042a95() {
    foreach (e_player in level.players) {
        if (!isalive(e_player) || !e_player istouching(self)) {
            return false;
        }
        if (!(isdefined(e_player.var_35ea5b31) && e_player.var_35ea5b31)) {
            e_player thread function_61f148a5(self);
        }
    }
    return true;
}

// Namespace namespace_c5d72679
// Params 1, eflags: 0x1 linked
// namespace_c5d72679<file_0>::function_61f148a5
// Checksum 0xcb0d7944, Offset: 0xec30
// Size: 0x9e
function function_61f148a5(var_af81398) {
    self endon(#"death");
    self.var_35ea5b31 = 1;
    self clientfield::set_to_player("ee_hatch_strain_rumble", 1);
    while (isdefined(var_af81398) && self istouching(var_af81398)) {
        wait(0.4);
    }
    self clientfield::set_to_player("ee_hatch_strain_rumble", 0);
    self.var_35ea5b31 = undefined;
}

// Namespace namespace_c5d72679
// Params 0, eflags: 0x1 linked
// namespace_c5d72679<file_0>::function_deda2d7a
// Checksum 0x1988ab3a, Offset: 0xecd8
// Size: 0x64
function function_deda2d7a() {
    if (!level flag::get("dragon_hazard_armory_once")) {
        level flag::set("dragon_hazard_armory_once");
        level scene::play("p7_fxanim_zm_stal_letters_a_r_bundle");
    }
}

// Namespace namespace_c5d72679
// Params 0, eflags: 0x1 linked
// namespace_c5d72679<file_0>::function_e957e3bc
// Checksum 0x89876976, Offset: 0xed48
// Size: 0x11c
function function_e957e3bc() {
    level waittill(#"hash_2aa42acf");
    level flag::set("players_in_arena");
    level thread function_2868b6f4(0);
    level thread namespace_dcf9c464::function_e4acaa37("vox_nik1_help_nikolai_cores_1", 2);
    level zm_zonemgr::enable_zone("boss_arena_zone");
    self function_6e3a6092();
    playsoundatposition("zmb_scenarios_button_activate", self.origin);
    self struct::delete();
    level function_d6702e87();
    level thread namespace_dcf9c464::function_e8e9cba8();
    level namespace_e81d2518::function_63326db4(0);
}

// Namespace namespace_c5d72679
// Params 0, eflags: 0x1 linked
// namespace_c5d72679<file_0>::function_d6702e87
// Checksum 0xae96485, Offset: 0xee70
// Size: 0x1d2
function function_d6702e87() {
    mdl_head = getent("robot_head_clocktower", "targetname");
    var_2e8d47d3 = mdl_head.angles;
    var_86cbea2c = var_2e8d47d3 + (0, -28, -50);
    mdl_head rotateto(var_86cbea2c, 3, 0.5, 0.1);
    mdl_head playsound("zmb_robo_eye_head_move");
    mdl_head waittill(#"rotatedone");
    mdl_head playsound("zmb_robo_eye_head_start");
    mdl_head playloopsound("zmb_robo_eye_head_lp", 1.5);
    exploder::exploder("fxexp_700");
    wait(5);
    exploder::stop_exploder("fxexp_700");
    mdl_head playsound("zmb_robo_eye_head_stop");
    mdl_head stoploopsound(1);
    wait(1);
    mdl_head rotateto(var_2e8d47d3, 3, 0.5, 0.1);
    mdl_head playsound("zmb_robo_eye_head_move");
    wait(1);
}

// Namespace namespace_c5d72679
// Params 2, eflags: 0x1 linked
// namespace_c5d72679<file_0>::function_f200c253
// Checksum 0xcf5ec7ff, Offset: 0xf050
// Size: 0x2ec
function function_f200c253(n_wait, var_d15ef3dd) {
    if (!isdefined(n_wait)) {
        n_wait = 0;
    }
    if (!isdefined(var_d15ef3dd)) {
        var_d15ef3dd = 0;
    }
    level function_2868b6f4(1, undefined, 0);
    level.var_2801f599 = int((level.time - level.n_gameplay_start_time + 500) / 1000);
    level clientfield::set("quest_complete_time", level.var_2801f599);
    if (var_d15ef3dd) {
        level scene::init("cin_sta_outro_3rd_sh020");
        level util::streamer_wait(undefined, 0.2, 15);
    }
    wait(n_wait);
    level notify(#"hash_6460283a");
    level namespace_dcf9c464::function_6f2aecbd();
    level function_184114b9(undefined);
    if (!var_d15ef3dd) {
        level.var_cf6e9729.var_fa4643fb delete();
        level.var_cf6e9729 delete();
    }
    level function_6adaea27(0);
    zombie_utility::clear_all_corpses();
    level scene::add_scene_func("cin_sta_outro_3rd_sh020", &function_f3e1bda1);
    level scene::add_scene_func("cin_sta_outro_3rd_sh080", &function_f3e1bda1);
    level scene::add_scene_func("cin_sta_outro_3rd_sh132", &function_9c290325);
    level notify(#"hash_9b1cee4c");
    level scene::play("cin_sta_outro_3rd_sh020");
    level waittill(#"hash_196dc11");
    wait(7.5);
    level function_f885ecc6();
    level function_6adaea27(1);
    var_206fd092 = getent("mech", "targetname");
    var_206fd092 clientfield::set("post_outro_smoke", 1);
    level thread function_146501();
}

// Namespace namespace_c5d72679
// Params 1, eflags: 0x1 linked
// namespace_c5d72679<file_0>::function_184114b9
// Checksum 0xc1650c76, Offset: 0xf348
// Size: 0x7c
function function_184114b9(var_fdc919d5) {
    level lui::screen_fade_out(0.2, "white", "pause_regular_zombies");
    level util::delay(0.7, undefined, &lui::screen_fade_in, 1, "white", "pause_regular_zombies");
}

// Namespace namespace_c5d72679
// Params 1, eflags: 0x1 linked
// namespace_c5d72679<file_0>::function_6adaea27
// Checksum 0x3f39937c, Offset: 0xf3d0
// Size: 0xfc
function function_6adaea27(b_show) {
    if (b_show && isdefined(level.var_4d36bcd5)) {
        level.var_4d36bcd5 zm_magicbox::show_chest();
        level.var_4d36bcd5 = undefined;
        return;
    }
    if (!b_show) {
        foreach (s_chest in level.chests) {
            if (s_chest.hidden === 0) {
                level.var_4d36bcd5 = s_chest;
                s_chest zm_magicbox::hide_chest();
                return;
            }
        }
    }
}

// Namespace namespace_c5d72679
// Params 1, eflags: 0x1 linked
// namespace_c5d72679<file_0>::function_f3e1bda1
// Checksum 0x2d1090d7, Offset: 0xf4d8
// Size: 0xe4
function function_f3e1bda1(a_ents) {
    var_206fd092 = a_ents["mech"];
    var_206fd092 hidepart("tag_heat_vent_01_d0");
    var_206fd092 hidepart("tag_heat_vent_02_d0");
    var_206fd092 hidepart("tag_heat_vent_03_d0");
    var_206fd092 hidepart("tag_heat_vent_04_d0");
    var_206fd092 hidepart("tag_heat_vent_05_d0");
    var_206fd092 hidepart("tag_heat_vent_05_d1");
}

// Namespace namespace_c5d72679
// Params 1, eflags: 0x1 linked
// namespace_c5d72679<file_0>::function_9c290325
// Checksum 0x9c6e9453, Offset: 0xf5c8
// Size: 0x64
function function_9c290325(a_ents) {
    level waittill(#"hash_83582d4d");
    level lui::screen_fade_out(0, "black");
    level waittill(#"hash_b512f707");
    level lui::screen_fade_in(2, "black");
}

// Namespace namespace_c5d72679
// Params 0, eflags: 0x1 linked
// namespace_c5d72679<file_0>::function_146501
// Checksum 0xdd09b5b4, Offset: 0xf638
// Size: 0x11c
function function_146501() {
    level thread namespace_48c05c81::function_e7c75cf0();
    wait(1);
    foreach (e_player in level.activeplayers) {
        e_player thread zm_utility::function_82a5cc4();
        e_player thread function_aa34f039();
        e_player.bgb_disabled = 0;
    }
    level thread namespace_fd6bdadc::function_3d5b5002();
    level notify(#"hash_c1471acf");
    level namespace_dcf9c464::function_568549ce();
    level function_2868b6f4(0);
}

// Namespace namespace_c5d72679
// Params 0, eflags: 0x1 linked
// namespace_c5d72679<file_0>::function_aa34f039
// Checksum 0x54dce28c, Offset: 0xf760
// Size: 0x64
function function_aa34f039() {
    level scoreevents::processscoreevent("main_EE_quest_stalingrad", self);
    self zm_stats::increment_global_stat("DARKOPS_STALINGRAD_EE");
    self zm_stats::increment_global_stat("DARKOPS_STALINGRAD_SUPER_EE");
}

// Namespace namespace_c5d72679
// Params 0, eflags: 0x1 linked
// namespace_c5d72679<file_0>::function_f885ecc6
// Checksum 0x72e02f54, Offset: 0xf7d0
// Size: 0xfc
function function_f885ecc6() {
    lui::prime_movie("zm_stalingrad", 0, "VIvR+pb5utWUBysldVJJQSj+DhzuxPYKm2r8qvF0IaIAAAAAAAAAAA==");
    function_1c04ad71(1);
    level lui::screen_fade_out(0.25);
    playsoundatposition("zmb_outro_tbc_start", (0, 0, 0));
    level notify(#"hash_19aa582d");
    level waittill(#"hash_cefef17d");
    level lui::play_movie("zm_stalingrad", "fullscreen", 0, 0, "VIvR+pb5utWUBysldVJJQSj+DhzuxPYKm2r8qvF0IaIAAAAAAAAAAA==");
    level lui::screen_fade_in(1);
    function_1c04ad71(0);
}

// Namespace namespace_c5d72679
// Params 1, eflags: 0x1 linked
// namespace_c5d72679<file_0>::function_1c04ad71
// Checksum 0x1b311167, Offset: 0xf8d8
// Size: 0xe2
function function_1c04ad71(var_a5efd39d) {
    if (!isdefined(var_a5efd39d)) {
        var_a5efd39d = 1;
    }
    foreach (e_player in level.activeplayers) {
        if (var_a5efd39d) {
            e_player enableinvulnerability();
        } else {
            e_player disableinvulnerability();
        }
        e_player util::freeze_player_controls(var_a5efd39d);
    }
}

/#

    // Namespace namespace_c5d72679
    // Params 2, eflags: 0x1 linked
    // namespace_c5d72679<file_0>::function_7e02b332
    // Checksum 0xa103f37b, Offset: 0xf9c8
    // Size: 0x2c
    function function_7e02b332(a_ents, b_open) {
        namespace_48c05c81::function_4da6e8(b_open);
    }

#/

// Namespace namespace_c5d72679
// Params 3, eflags: 0x1 linked
// namespace_c5d72679<file_0>::function_6e3a6092
// Checksum 0x97237fdd, Offset: 0xfa00
// Size: 0x140
function function_6e3a6092(n_trigger_radius, str_hint, var_6902ec85) {
    if (!isdefined(n_trigger_radius)) {
        n_trigger_radius = 100;
    }
    if (!isdefined(str_hint)) {
        str_hint = "";
    }
    if (!isdefined(var_6902ec85)) {
        var_6902ec85 = 1;
    }
    if (!isdefined(self.s_unitrigger)) {
        self zm_unitrigger::create_unitrigger(str_hint, n_trigger_radius, &function_44423ea2);
    } else {
        self.s_unitrigger function_527f47cc(str_hint);
    }
    e_who = self waittill(#"trigger_activated");
    e_who clientfield::increment_to_player("interact_rumble");
    if (var_6902ec85) {
        zm_unitrigger::unregister_unitrigger(self.s_unitrigger);
        self.s_unitrigger = undefined;
    } else {
        self.s_unitrigger function_527f47cc("");
    }
    return e_who;
}

// Namespace namespace_c5d72679
// Params 1, eflags: 0x1 linked
// namespace_c5d72679<file_0>::function_527f47cc
// Checksum 0x319e872c, Offset: 0xfb48
// Size: 0x2c
function function_527f47cc(str_hint) {
    self.hint_string = str_hint;
    self zm_unitrigger::run_visibility_function_for_all_triggers();
}

// Namespace namespace_c5d72679
// Params 1, eflags: 0x1 linked
// namespace_c5d72679<file_0>::function_44423ea2
// Checksum 0x2841faad, Offset: 0xfb80
// Size: 0x38
function function_44423ea2(e_player) {
    self sethintstring(self.stub.hint_string);
    return true;
}

// Namespace namespace_c5d72679
// Params 1, eflags: 0x0
// namespace_c5d72679<file_0>::function_a73ce57c
// Checksum 0x2c828521, Offset: 0xfbc0
// Size: 0x46
function function_a73ce57c(e_player) {
    if (e_player function_85d05129(self.stub.related_parent.origin)) {
        return true;
    }
    return false;
}

// Namespace namespace_c5d72679
// Params 4, eflags: 0x1 linked
// namespace_c5d72679<file_0>::function_85d05129
// Checksum 0x55164874, Offset: 0xfc10
// Size: 0xcc
function function_85d05129(origin, arc_angle_degrees, do_trace, e_ignore) {
    if (!isdefined(arc_angle_degrees)) {
        arc_angle_degrees = 10;
    }
    if (!isdefined(do_trace)) {
        do_trace = 0;
    }
    arc_angle_degrees = absangleclamp360(arc_angle_degrees);
    dot = cos(arc_angle_degrees * 0.5);
    if (self util::is_player_looking_at(origin, dot, do_trace, e_ignore)) {
        return 1;
    }
    return 0;
}

// Namespace namespace_c5d72679
// Params 0, eflags: 0x1 linked
// namespace_c5d72679<file_0>::function_92de7ae0
// Checksum 0x1a97a136, Offset: 0xfce8
// Size: 0x3e
function function_92de7ae0() {
    if (zm_zonemgr::any_player_in_zone("judicial_A_zone") || zm_zonemgr::any_player_in_zone("judicial_B_zone")) {
        return true;
    }
    return false;
}

// Namespace namespace_c5d72679
// Params 0, eflags: 0x1 linked
// namespace_c5d72679<file_0>::function_9c8afe2b
// Checksum 0x63933946, Offset: 0xfd30
// Size: 0x20
function function_9c8afe2b() {
    while (!function_92de7ae0()) {
        wait(2);
    }
}

// Namespace namespace_c5d72679
// Params 0, eflags: 0x1 linked
// namespace_c5d72679<file_0>::function_eaf82313
// Checksum 0xa703650b, Offset: 0xfd58
// Size: 0xe2
function function_eaf82313() {
    while (true) {
        if (function_92de7ae0()) {
            e_richtofen = namespace_dcf9c464::function_fcea1c5c();
            if (isdefined(e_richtofen) && zm_utility::is_player_valid(e_richtofen)) {
                var_2040fa70 = e_richtofen zm_utility::get_current_zone();
                if (!isdefined(var_2040fa70)) {
                    return;
                }
                if (var_2040fa70 != "judicial_A_zone" && var_2040fa70 != "judicial_B_zone" && var_2040fa70 != "judicial_street_zone" && var_2040fa70 != "judicial_street_b_zone") {
                    return;
                }
            }
            return;
        }
        wait(2);
    }
}

// Namespace namespace_c5d72679
// Params 2, eflags: 0x1 linked
// namespace_c5d72679<file_0>::function_694a61ea
// Checksum 0x7005c142, Offset: 0xfe48
// Size: 0x1cc
function function_694a61ea(conehalfheight, var_c57c38fc) {
    if (!isdefined(var_c57c38fc)) {
        var_c57c38fc = 1;
    }
    if (var_c57c38fc) {
        util::magic_bullet_shield(conehalfheight);
    }
    exploder::exploder("fxexp_900");
    conehalfheight playsound("zmb_scenario_magneto_fx_start");
    conehalfheight playloopsound("zmb_scenario_magneto_fx_lp", 0.5);
    wait(2);
    level thread scene::play("p7_fxanim_zm_stal_raz_cage_sentinel_grab_bundle");
    level waittill(#"hash_d0ec645d");
    conehalfheight unlink();
    conehalfheight stoploopsound(0.5);
    conehalfheight playsound("zmb_scenario_magneto_fx_stop");
    exploder::stop_exploder("fxexp_900");
    mdl_cage = getent("raz_cage", "targetname");
    conehalfheight linkto(mdl_cage, "link_jnt");
    level waittill(#"hash_2850c4f2");
    if (var_c57c38fc) {
        util::stop_magic_bullet_shield(conehalfheight);
    }
    conehalfheight delete();
}

// Namespace namespace_c5d72679
// Params 3, eflags: 0x1 linked
// namespace_c5d72679<file_0>::function_2868b6f4
// Checksum 0xe465eb91, Offset: 0x10020
// Size: 0xe4
function function_2868b6f4(b_pause, var_c7f6657d, var_455239a2) {
    if (!isdefined(b_pause)) {
        b_pause = 1;
    }
    if (!isdefined(var_c7f6657d)) {
        var_c7f6657d = &function_3d1cdcf3;
    }
    if (!isdefined(var_455239a2)) {
        var_455239a2 = 1;
    }
    if (b_pause) {
        level thread function_bbbebba6();
        if (isdefined(var_455239a2) && isdefined(var_c7f6657d) && var_455239a2) {
            [[ var_c7f6657d ]]();
        }
        return;
    }
    level notify(#"hash_e8e96c72");
    level.disable_nuke_delay_spawning = 0;
    level flag::set("spawn_zombies");
}

// Namespace namespace_c5d72679
// Params 0, eflags: 0x1 linked
// namespace_c5d72679<file_0>::function_bbbebba6
// Checksum 0x144dab85, Offset: 0x10110
// Size: 0xac
function function_bbbebba6() {
    level endon(#"hash_e8e96c72");
    if (!level flag::get("spawn_zombies") && !level flag::get("lockdown_active")) {
        level flag::wait_till("spawn_zombies");
    }
    level.disable_nuke_delay_spawning = 1;
    level flag::clear("spawn_zombies");
    level namespace_48c05c81::function_adf4d1d0();
}

// Namespace namespace_c5d72679
// Params 0, eflags: 0x1 linked
// namespace_c5d72679<file_0>::function_3d1cdcf3
// Checksum 0xdf433cfc, Offset: 0x101c8
// Size: 0x6c
function function_3d1cdcf3() {
    level thread lui::screen_flash(0.2, 0.5, 1, 0.8, "white");
    playsoundatposition("zmb_scenarios_whiteflash", (0, 0, 0));
    wait(0.5);
}

// Namespace namespace_c5d72679
// Params 2, eflags: 0x1 linked
// namespace_c5d72679<file_0>::function_15d9679d
// Checksum 0xcaff7e96, Offset: 0x10240
// Size: 0xe6
function function_15d9679d(str_location, var_f48714a) {
    mdl_map = getent("ee_map", "targetname");
    for (i = 0; i < var_f48714a; i++) {
        str_tag = "tag_map_screen_glow_" + str_location;
        wait(0.5);
        mdl_map showpart(str_tag);
        mdl_map playsound("zmb_scenarios_map_beep_higher");
        wait(0.75);
        mdl_map hidepart(str_tag);
    }
}

// Namespace namespace_c5d72679
// Params 4, eflags: 0x1 linked
// namespace_c5d72679<file_0>::function_d9d36a17
// Checksum 0xc6448e8e, Offset: 0x10330
// Size: 0x1cc
function function_d9d36a17(str_model, str_hint, v_angles, var_c991b769) {
    if (!isdefined(v_angles)) {
        v_angles = (0, 0, 0);
    }
    if (!isdefined(var_c991b769)) {
        var_c991b769 = (0, 0, 0);
    }
    while (!level.var_a090a655 namespace_48c05c81::function_1af75b1b(-6)) {
        wait(0.5);
    }
    level.var_a090a655 scene::play("p7_fxanim_zm_stal_computer_sophia_drawer_open_bundle");
    var_af8a18df = struct::get("ee_sophia_struct", "targetname");
    var_af8a18df function_6e3a6092(100, str_hint, 0);
    var_51a2f105 = level.var_a090a655 gettagorigin("drawer_link_jnt");
    var_b71f6be1 = util::spawn_model(str_model, var_51a2f105 + var_c991b769, v_angles);
    var_b71f6be1 linkto(level.var_a090a655, "drawer_link_jnt");
    var_b71f6be1 playsound("zmb_scenarios_sophia_drawer_return");
    wait(1);
    level.var_a090a655 scene::play("p7_fxanim_zm_stal_computer_sophia_drawer_close_bundle");
    var_b71f6be1 delete();
}

// Namespace namespace_c5d72679
// Params 1, eflags: 0x1 linked
// namespace_c5d72679<file_0>::function_67cef48
// Checksum 0xd7f34523, Offset: 0x10508
// Size: 0xdc
function function_67cef48(b_show) {
    var_78d02c88 = getent("ee_map_shelf", "targetname");
    if (b_show) {
        var_78d02c88 showpart("wall_map_shelf_button_green");
        var_78d02c88 hidepart("wall_map_shelf_button_red");
        var_78d02c88 playsound("zmb_scenarios_button_activate");
        return;
    }
    var_78d02c88 hidepart("wall_map_shelf_button_green");
    var_78d02c88 showpart("wall_map_shelf_button_red");
}

// Namespace namespace_c5d72679
// Params 1, eflags: 0x1 linked
// namespace_c5d72679<file_0>::function_fa7fbd4c
// Checksum 0x9187d9cf, Offset: 0x105f0
// Size: 0xbc
function function_fa7fbd4c(b_show) {
    if (b_show) {
        level.var_a090a655 showpart("button_green_jnt");
        level.var_a090a655 hidepart("button_red_jnt");
        level.var_a090a655 playsound("zmb_scenarios_button_activate");
        return;
    }
    level.var_a090a655 hidepart("button_green_jnt");
    level.var_a090a655 showpart("button_red_jnt");
}

/#

    // Namespace namespace_c5d72679
    // Params 0, eflags: 0x1 linked
    // namespace_c5d72679<file_0>::function_d6026710
    // Checksum 0xbebc5935, Offset: 0x106b8
    // Size: 0x7ec
    function function_d6026710() {
        level thread function_a1f6ef06("vehicle", "vehicle", 1, &function_4fdd3e35);
        level thread function_a1f6ef06("vehicle", "vehicle", 1, &function_2ce0ea3d);
        level thread function_a1f6ef06("vehicle", "vehicle", 1, &function_96a879de);
        level thread function_a1f6ef06("vehicle", "vehicle", 1, &function_453d1020);
        level thread function_a1f6ef06("vehicle", "vehicle", 1, &function_43beec5a);
        level thread function_a1f6ef06("vehicle", "vehicle", 1, &function_5879102a);
        level thread function_a1f6ef06("vehicle", "vehicle", 1, &function_2be548b9);
        level thread function_a1f6ef06("vehicle", "vehicle", 1, &function_8265c377);
        level thread function_a1f6ef06("vehicle", "vehicle", 1, &function_da01ea0);
        level thread function_a1f6ef06("vehicle", "vehicle", 1, &function_d95ba8e4);
        level thread function_a1f6ef06("vehicle", "vehicle", 1, &function_81799b1b);
        level thread function_a1f6ef06("vehicle", "vehicle", 1, &function_15b02c6d);
        level thread function_a1f6ef06("vehicle", "vehicle", 1, &function_f8be6f86);
        level thread function_a1f6ef06("vehicle", "vehicle", 1, &function_126d3a92);
        level thread function_a1f6ef06("vehicle", "vehicle", 1, &function_1b02c173);
        level thread function_a1f6ef06("vehicle", "vehicle", 1, &function_98be294);
        level thread function_a1f6ef06("vehicle", "vehicle", 1, &function_90a2468c);
        level thread function_a1f6ef06("vehicle", "vehicle", 1, &function_63ef4ccd);
        level thread function_a1f6ef06("vehicle", "vehicle", 1, &function_474a5f0);
        level thread function_a1f6ef06("vehicle", "vehicle", 1, &function_d810756e);
        level thread function_a1f6ef06("vehicle", "vehicle", 1, &function_400ba4a5);
        level thread function_a1f6ef06("vehicle", "vehicle", 1, &function_c25033fa);
        level thread function_a1f6ef06("vehicle", "vehicle", 1, &function_e6dcb4c9);
        level thread function_a1f6ef06("vehicle", "vehicle", 1, &function_e7aa9b86);
        level thread function_a1f6ef06("vehicle", "vehicle", 1, &function_9d07a3ef);
        level thread function_a1f6ef06("vehicle", "vehicle", 1, &function_67c46c97);
        level thread function_a1f6ef06("vehicle", "vehicle", 1, &function_bbf6c2d0);
        level thread function_a1f6ef06("vehicle", "vehicle", 1, &function_22557cc3);
        level thread function_a1f6ef06("vehicle", "vehicle", 1, &function_3de60ba3);
        level thread function_a1f6ef06("vehicle", "vehicle", 1, &function_4f92d875);
        level thread function_a1f6ef06("vehicle", "vehicle", 1, &function_9b3c25cd);
        level thread function_a1f6ef06("vehicle", "vehicle", 1, &function_ff112fdc);
        level thread function_a1f6ef06("vehicle", "vehicle", 1, &function_5446a1da);
        level thread function_a1f6ef06("vehicle", "vehicle", 1, &function_10f1fb15);
        level thread function_a1f6ef06("vehicle", "vehicle", 1, &function_9cde71dd);
        level thread function_a1f6ef06("vehicle", "vehicle", 1, &function_bd5b4406);
    }

    // Namespace namespace_c5d72679
    // Params 1, eflags: 0x1 linked
    // namespace_c5d72679<file_0>::function_4fdd3e35
    // Checksum 0xb55f671d, Offset: 0x10eb0
    // Size: 0x42
    function function_4fdd3e35(n_value) {
        if (!(isdefined(level.var_f9c3fe97) && level.var_f9c3fe97)) {
            level.var_f9c3fe97 = 1;
            return;
        }
        level.var_f9c3fe97 = undefined;
    }

    // Namespace namespace_c5d72679
    // Params 1, eflags: 0x1 linked
    // namespace_c5d72679<file_0>::function_2ce0ea3d
    // Checksum 0xf42b41a9, Offset: 0x10f00
    // Size: 0x2c
    function function_2ce0ea3d(n_value) {
        level flag::set("vehicle");
    }

    // Namespace namespace_c5d72679
    // Params 1, eflags: 0x1 linked
    // namespace_c5d72679<file_0>::function_96a879de
    // Checksum 0x73f4b8e7, Offset: 0x10f38
    // Size: 0x44
    function function_96a879de(n_value) {
        level flag::set("vehicle");
        level function_ef39c304(1);
    }

    // Namespace namespace_c5d72679
    // Params 1, eflags: 0x1 linked
    // namespace_c5d72679<file_0>::function_453d1020
    // Checksum 0xda12d6cd, Offset: 0x10f88
    // Size: 0x54
    function function_453d1020(n_value) {
        level flag::set("vehicle");
        wait(0.5);
        level flag::set("vehicle");
    }

    // Namespace namespace_c5d72679
    // Params 1, eflags: 0x1 linked
    // namespace_c5d72679<file_0>::function_43beec5a
    // Checksum 0x7b2ea9d4, Offset: 0x10fe8
    // Size: 0x2c
    function function_43beec5a(n_value) {
        level flag::set("vehicle");
    }

    // Namespace namespace_c5d72679
    // Params 1, eflags: 0x1 linked
    // namespace_c5d72679<file_0>::function_5879102a
    // Checksum 0x3abd89bd, Offset: 0x11020
    // Size: 0x3c
    function function_5879102a(n_value) {
        level notify(#"hash_72a2fa02");
        level flag::set("vehicle");
    }

    // Namespace namespace_c5d72679
    // Params 1, eflags: 0x1 linked
    // namespace_c5d72679<file_0>::function_2be548b9
    // Checksum 0x2ef0e6a4, Offset: 0x11068
    // Size: 0x3c
    function function_2be548b9(n_value) {
        level notify(#"hash_72a2fa02");
        level flag::set("vehicle");
    }

    // Namespace namespace_c5d72679
    // Params 1, eflags: 0x1 linked
    // namespace_c5d72679<file_0>::function_da01ea0
    // Checksum 0xb5ddbb79, Offset: 0x110b0
    // Size: 0x34
    function function_da01ea0(n_value) {
        level function_3cce99fb(&function_4769ea02);
    }

    // Namespace namespace_c5d72679
    // Params 1, eflags: 0x1 linked
    // namespace_c5d72679<file_0>::function_d95ba8e4
    // Checksum 0x6725001f, Offset: 0x110f0
    // Size: 0x34
    function function_d95ba8e4(n_value) {
        level function_3cce99fb(&function_f5139aae);
    }

    // Namespace namespace_c5d72679
    // Params 1, eflags: 0x1 linked
    // namespace_c5d72679<file_0>::function_81799b1b
    // Checksum 0x552187f4, Offset: 0x11130
    // Size: 0x34
    function function_81799b1b(n_value) {
        level function_3cce99fb(&function_62f0a233);
    }

    // Namespace namespace_c5d72679
    // Params 1, eflags: 0x1 linked
    // namespace_c5d72679<file_0>::function_15b02c6d
    // Checksum 0x8c2d32f8, Offset: 0x11170
    // Size: 0x34
    function function_15b02c6d(n_value) {
        level function_3cce99fb(&function_6a1cc377);
    }

    // Namespace namespace_c5d72679
    // Params 1, eflags: 0x1 linked
    // namespace_c5d72679<file_0>::function_f8be6f86
    // Checksum 0xde07706b, Offset: 0x111b0
    // Size: 0x34
    function function_f8be6f86(n_value) {
        level function_3cce99fb(&function_21284834);
    }

    // Namespace namespace_c5d72679
    // Params 1, eflags: 0x1 linked
    // namespace_c5d72679<file_0>::function_126d3a92
    // Checksum 0x626f0643, Offset: 0x111f0
    // Size: 0x34
    function function_126d3a92(n_value) {
        level function_3cce99fb(&function_101e5b38);
    }

    // Namespace namespace_c5d72679
    // Params 1, eflags: 0x1 linked
    // namespace_c5d72679<file_0>::function_3cce99fb
    // Checksum 0xcb6d6fe8, Offset: 0x11230
    // Size: 0x54
    function function_3cce99fb(var_ad364454) {
        level.var_c91c0e41 = 1;
        level function_2868b6f4();
        [[ var_ad364454 ]]();
        level function_2868b6f4(0);
    }

    // Namespace namespace_c5d72679
    // Params 1, eflags: 0x1 linked
    // namespace_c5d72679<file_0>::function_98be294
    // Checksum 0x3208cd29, Offset: 0x11290
    // Size: 0x54
    function function_98be294(n_value) {
        if (isdefined(level.var_9f752812)) {
            level.var_9f752812 thread zm_utility::print3d_ent("vehicle", (0, 1, 0), 3, (0, 0, 24));
        }
    }

    // Namespace namespace_c5d72679
    // Params 1, eflags: 0x1 linked
    // namespace_c5d72679<file_0>::function_1b02c173
    // Checksum 0x9ff44dd2, Offset: 0x112f0
    // Size: 0x6c
    function function_1b02c173(n_value) {
        if (isdefined(level.var_a5fb1d00)) {
            level.var_a5fb1d00.health = 99999;
            level.var_a5fb1d00 thread zm_utility::print3d_ent("vehicle", (0, 1, 0), 3, (0, 0, 24));
        }
    }

    // Namespace namespace_c5d72679
    // Params 1, eflags: 0x1 linked
    // namespace_c5d72679<file_0>::function_90a2468c
    // Checksum 0x7295e196, Offset: 0x11368
    // Size: 0x94
    function function_90a2468c(n_value) {
        a_str_locations = array("vehicle", "vehicle", "vehicle", "vehicle", "vehicle", "vehicle");
        a_str_locations = array::randomize(a_str_locations);
        level function_18375f27(a_str_locations);
    }

    // Namespace namespace_c5d72679
    // Params 1, eflags: 0x1 linked
    // namespace_c5d72679<file_0>::function_63ef4ccd
    // Checksum 0x78209b1, Offset: 0x11408
    // Size: 0x34
    function function_63ef4ccd(n_value) {
        level.var_c47b244 = function_c5c5f391("vehicle", 1);
    }

    // Namespace namespace_c5d72679
    // Params 1, eflags: 0x1 linked
    // namespace_c5d72679<file_0>::function_474a5f0
    // Checksum 0x31783e83, Offset: 0x11448
    // Size: 0x34
    function function_474a5f0(n_value) {
        level.var_c47b244 = function_c5c5f391("vehicle", 2);
    }

    // Namespace namespace_c5d72679
    // Params 1, eflags: 0x1 linked
    // namespace_c5d72679<file_0>::function_d810756e
    // Checksum 0x25a826c6, Offset: 0x11488
    // Size: 0x34
    function function_d810756e(n_value) {
        level.var_c47b244 = function_c5c5f391("vehicle", 1);
    }

    // Namespace namespace_c5d72679
    // Params 1, eflags: 0x1 linked
    // namespace_c5d72679<file_0>::function_400ba4a5
    // Checksum 0x24b71c0, Offset: 0x114c8
    // Size: 0x34
    function function_400ba4a5(n_value) {
        level.var_c47b244 = function_c5c5f391("vehicle", 2);
    }

    // Namespace namespace_c5d72679
    // Params 1, eflags: 0x1 linked
    // namespace_c5d72679<file_0>::function_c25033fa
    // Checksum 0xfccccf13, Offset: 0x11508
    // Size: 0x34
    function function_c25033fa(n_value) {
        level.var_c47b244 = function_c5c5f391("vehicle", 1);
    }

    // Namespace namespace_c5d72679
    // Params 1, eflags: 0x1 linked
    // namespace_c5d72679<file_0>::function_e6dcb4c9
    // Checksum 0x804e1b56, Offset: 0x11548
    // Size: 0x34
    function function_e6dcb4c9(n_value) {
        level.var_c47b244 = function_c5c5f391("vehicle", 2);
    }

    // Namespace namespace_c5d72679
    // Params 2, eflags: 0x1 linked
    // namespace_c5d72679<file_0>::function_c5c5f391
    // Checksum 0xdda9c8ce, Offset: 0x11588
    // Size: 0xec
    function function_c5c5f391(str_location, n_position) {
        var_afe8026c = struct::get_array("vehicle", "vehicle");
        foreach (s_pod in var_afe8026c) {
            if (s_pod.script_string == str_location && s_pod.script_int == n_position) {
                return s_pod;
            }
        }
    }

    // Namespace namespace_c5d72679
    // Params 1, eflags: 0x1 linked
    // namespace_c5d72679<file_0>::function_8265c377
    // Checksum 0x4ed5e075, Offset: 0x11680
    // Size: 0x4e
    function function_8265c377(n_value) {
        var_fc275254 = "vehicle" + level.var_8b2f7f24 + "vehicle";
        level notify(var_fc275254);
        level notify(#"hash_9546144d");
    }

    // Namespace namespace_c5d72679
    // Params 1, eflags: 0x1 linked
    // namespace_c5d72679<file_0>::function_e7aa9b86
    // Checksum 0x15f7689e, Offset: 0x116d8
    // Size: 0x3c
    function function_e7aa9b86(n_value) {
        level notify(#"hash_7f7ecb53");
        level flag::set("vehicle");
    }

    // Namespace namespace_c5d72679
    // Params 1, eflags: 0x1 linked
    // namespace_c5d72679<file_0>::function_9d07a3ef
    // Checksum 0xcb218142, Offset: 0x11720
    // Size: 0x6c
    function function_9d07a3ef(n_value) {
        level notify(#"hash_dae10c73");
        level notify(#"hash_deeb3634");
        level clientfield::set("vehicle", 0);
        level flag::set("vehicle");
    }

    // Namespace namespace_c5d72679
    // Params 1, eflags: 0x1 linked
    // namespace_c5d72679<file_0>::function_67c46c97
    // Checksum 0x844f44f8, Offset: 0x11798
    // Size: 0x2c
    function function_67c46c97(n_value) {
        level flag::set("vehicle");
    }

    // Namespace namespace_c5d72679
    // Params 1, eflags: 0x1 linked
    // namespace_c5d72679<file_0>::function_bbf6c2d0
    // Checksum 0x6a290808, Offset: 0x117d0
    // Size: 0x84
    function function_bbf6c2d0(n_value) {
        level notify(#"hash_dfaade1d");
        if (isdefined(level.var_357a65b)) {
            level.var_357a65b scene::stop();
            level.var_357a65b delete();
            level.var_357a65b = undefined;
        }
        level function_f200c253(0, 1);
    }

    // Namespace namespace_c5d72679
    // Params 1, eflags: 0x1 linked
    // namespace_c5d72679<file_0>::function_22557cc3
    // Checksum 0x36a395bb, Offset: 0x11860
    // Size: 0xbc
    function function_22557cc3(n_value) {
        level notify(#"hash_deeb3634");
        level clientfield::set("vehicle", 0);
        exploder::stop_exploder("vehicle");
        level thread scene::play("vehicle");
        level thread namespace_dcf9c464::function_ea234d37();
        level waittill(#"hash_34e4b03f");
        level.var_a090a655 scene::play("vehicle");
    }

    // Namespace namespace_c5d72679
    // Params 1, eflags: 0x1 linked
    // namespace_c5d72679<file_0>::function_ff112fdc
    // Checksum 0x83509c8b, Offset: 0x11928
    // Size: 0x24
    function function_ff112fdc(n_value) {
        level function_d6702e87();
    }

    // Namespace namespace_c5d72679
    // Params 1, eflags: 0x1 linked
    // namespace_c5d72679<file_0>::function_3de60ba3
    // Checksum 0xe1b3a5af, Offset: 0x11958
    // Size: 0xc2
    function function_3de60ba3(n_value) {
        var_7953b28 = getentarray("vehicle", "vehicle");
        foreach (var_c2d73a21 in var_7953b28) {
            var_c2d73a21 thread function_2ffdc89();
        }
    }

    // Namespace namespace_c5d72679
    // Params 0, eflags: 0x1 linked
    // namespace_c5d72679<file_0>::function_2ffdc89
    // Checksum 0xfbf9e728, Offset: 0x11a28
    // Size: 0x6c
    function function_2ffdc89() {
        self scene::play("vehicle", array(self));
        wait(5);
        self scene::play("vehicle", array(self));
    }

    // Namespace namespace_c5d72679
    // Params 1, eflags: 0x1 linked
    // namespace_c5d72679<file_0>::function_4f92d875
    // Checksum 0xb0854f98, Offset: 0x11aa0
    // Size: 0xf4
    function function_4f92d875(n_value) {
        s_capture_point = struct::get("vehicle", "vehicle");
        var_663b2442 = zombie_utility::spawn_zombie(level.var_fda4b3f3[0], "vehicle", s_capture_point);
        var_663b2442 vehicle_ai::set_state("vehicle");
        var_663b2442 namespace_58ca6a3a::function_a2874766(1);
        var_663b2442.origin = s_capture_point.origin + (0, 0, 30);
        wait(1);
        function_694a61ea(var_663b2442);
    }

    // Namespace namespace_c5d72679
    // Params 1, eflags: 0x1 linked
    // namespace_c5d72679<file_0>::function_9b3c25cd
    // Checksum 0x3fa60669, Offset: 0x11ba0
    // Size: 0xb4
    function function_9b3c25cd(n_value) {
        s_capture_point = struct::get("vehicle", "vehicle");
        ai_raz = zombie_utility::spawn_zombie(level.var_6bca5baa[0], "vehicle", s_capture_point);
        ai_raz ai::set_ignoreall(1);
        wait(1);
        function_694a61ea(ai_raz);
    }

    // Namespace namespace_c5d72679
    // Params 1, eflags: 0x1 linked
    // namespace_c5d72679<file_0>::function_5446a1da
    // Checksum 0xd63bccac, Offset: 0x11c60
    // Size: 0x2c
    function function_5446a1da(n_value) {
        exploder::exploder("vehicle");
    }

    // Namespace namespace_c5d72679
    // Params 1, eflags: 0x1 linked
    // namespace_c5d72679<file_0>::function_10f1fb15
    // Checksum 0x76ed46ed, Offset: 0x11c98
    // Size: 0x2c
    function function_10f1fb15(n_value) {
        exploder::exploder("vehicle");
    }

    // Namespace namespace_c5d72679
    // Params 1, eflags: 0x1 linked
    // namespace_c5d72679<file_0>::function_9cde71dd
    // Checksum 0x81053bc8, Offset: 0x11cd0
    // Size: 0x2c
    function function_9cde71dd(n_value) {
        exploder::exploder("vehicle");
    }

    // Namespace namespace_c5d72679
    // Params 1, eflags: 0x1 linked
    // namespace_c5d72679<file_0>::function_bd5b4406
    // Checksum 0xe22dfde6, Offset: 0x11d08
    // Size: 0x2c
    function function_bd5b4406(n_value) {
        exploder::exploder("vehicle");
    }

    // Namespace namespace_c5d72679
    // Params 5, eflags: 0x1 linked
    // namespace_c5d72679<file_0>::function_a1f6ef06
    // Checksum 0xb72cf780, Offset: 0x11d40
    // Size: 0x130
    function function_a1f6ef06(var_2fa24527, str_dvar, n_value, func, var_f0ee45c9) {
        if (!isdefined(var_f0ee45c9)) {
            var_f0ee45c9 = -1;
        }
        setdvar(str_dvar, var_f0ee45c9);
        var_2fa24527 = "vehicle" + var_2fa24527;
        adddebugcommand("vehicle" + var_2fa24527 + "vehicle" + str_dvar + "vehicle" + n_value + "vehicle");
        while (true) {
            var_608d58e3 = getdvarint(str_dvar);
            if (var_608d58e3 > var_f0ee45c9) {
                [[ func ]](var_608d58e3);
                setdvar(str_dvar, var_f0ee45c9);
            }
            util::wait_network_frame();
        }
    }

#/
