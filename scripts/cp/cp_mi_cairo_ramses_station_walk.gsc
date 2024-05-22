#using scripts/cp/cp_mi_cairo_ramses_nasser_interview;
#using scripts/cp/cp_mi_cairo_ramses_utility;
#using scripts/cp/cp_mi_cairo_ramses_sound;
#using scripts/cp/cp_mi_cairo_ramses_fx;
#using scripts/cp/cp_mi_cairo_ramses_level_start;
#using scripts/cp/_util;
#using scripts/cp/_skipto;
#using scripts/cp/_load;
#using scripts/cp/_objectives;
#using scripts/cp/_dialog;
#using scripts/shared/vehicle_shared;
#using scripts/shared/util_shared;
#using scripts/shared/trigger_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/array_shared;
#using scripts/shared/compass;
#using scripts/shared/ai_shared;
#using scripts/codescripts/struct;

#namespace namespace_7434c6b7;

// Namespace namespace_7434c6b7
// Params 0, eflags: 0x0
// Checksum 0xe358714b, Offset: 0x1aa0
// Size: 0x11c
function main() {
    level flag::init("end_tunneltalk_pt1");
    level flag::init("khalil_walk_done");
    level thread function_6b91ca4();
    level thread function_3a8a502();
    level thread function_e9be9fb3();
    level thread function_bbd12ed2();
    level thread function_78528b3d();
    level thread function_a99e5acb();
    level thread function_dd2cc06c();
    function_eef5b755();
    level skipto::function_be8adfb8("rs_walk_through");
}

// Namespace namespace_7434c6b7
// Params 0, eflags: 0x0
// Checksum 0x61dc2edc, Offset: 0x1bc8
// Size: 0x288
function function_dd2cc06c() {
    str_objective = "cp_waypoint_follow";
    objectives::set(str_objective, level.var_9db406db);
    var_660ee73d = getent("trig_close_main_station_door", "targetname");
    while (!level flag::get("khalil_walk_done")) {
        foreach (player in level.activeplayers) {
            if (!isdefined(player.var_2e3d01f0)) {
                player.var_2e3d01f0 = 0;
            }
            if (distance(player.origin, level.var_9db406db.origin) < 500 || player istouching(var_660ee73d)) {
                if (player.var_2e3d01f0 == 0) {
                    objectives::hide(str_objective, player);
                    player.var_2e3d01f0 = 1;
                }
                continue;
            }
            if (player.var_2e3d01f0 == 1) {
                objectives::show(str_objective, player);
                player.var_2e3d01f0 = 0;
            }
        }
        wait(1);
    }
    objectives::complete(str_objective, level.var_9db406db);
    foreach (player in level.players) {
        player.var_2e3d01f0 = undefined;
    }
}

// Namespace namespace_7434c6b7
// Params 1, eflags: 0x0
// Checksum 0x8e77a065, Offset: 0x1e58
// Size: 0x84
function function_e29f0dd6(str_objective) {
    level.var_2fd26037 = util::function_740f8516("hendricks");
    level.var_7a9855f3 = util::function_740f8516("rachel");
    level.var_9db406db = util::function_740f8516("khalil");
    skipto::teleport_ai(str_objective);
}

// Namespace namespace_7434c6b7
// Params 0, eflags: 0x0
// Checksum 0x99ec1590, Offset: 0x1ee8
// Size: 0x4
function function_93d2e417() {
    
}

// Namespace namespace_7434c6b7
// Params 0, eflags: 0x0
// Checksum 0xe15e9a55, Offset: 0x1ef8
// Size: 0x3ac
function function_eef5b755() {
    level endon(#"hash_6f437b92");
    level thread namespace_391e4301::function_e950228a();
    level thread function_317364f4();
    scene::init("cin_ram_02_04_walk_1st_introduce_01");
    scene::init("cin_ram_02_04_walk_1st_thousandyardstare");
    scene::add_scene_func("cin_ram_02_04_walk_1st_introduce_04", &function_19a13445, "play");
    scene::add_scene_func("cin_ram_02_04_walk_1st_introduce_01", &function_4c91219b, "done");
    scene::add_scene_func("cin_ram_02_04_walk_1st_introduce_01", &function_1ec9cc48, "play");
    scene::add_scene_func("cin_ram_02_04_walk_1st_introduce_01", &function_fa1c2163, "play");
    scene::add_scene_func("cin_ram_02_04_walk_1st_introduce_01", &namespace_391e4301::function_3bc57aa8, "done");
    scene::add_scene_func("cin_ram_02_04_walk_1st_introduce_02", &namespace_391e4301::function_3bc57aa8, "done");
    scene::add_scene_func("cin_ram_02_04_walk_1st_introduce_03", &namespace_391e4301::function_3bc57aa8, "done");
    scene::add_scene_func("cin_ram_02_04_walk_1st_introduce_04", &namespace_391e4301::function_3bc57aa8, "done");
    scene::play("cin_ram_02_04_walk_1st_introduce_01");
    scene::play("cin_ram_02_04_walk_1st_introduce_02");
    scene::play("cin_ram_02_04_walk_1st_introduce_03");
    level thread function_bc43c2f8();
    level thread namespace_e55eaf53::function_2ed0dd8e();
    namespace_391e4301::function_e7ebe596();
    level thread scene::play("cin_ram_02_04_walk_1st_introduce_04");
    var_80f9be56 = getent("armory_door_collision", "targetname");
    var_80f9be56 notsolid();
    level waittill(#"hash_db50bccb");
    foreach (player in level.activeplayers) {
        player thread namespace_e55eaf53::function_1bcd464b();
    }
    level flag::set("khalil_walk_done");
    namespace_e55eaf53::function_b760b954();
    trigger::wait_till("trig_close_main_station_door");
}

// Namespace namespace_7434c6b7
// Params 1, eflags: 0x0
// Checksum 0x5d817720, Offset: 0x22b0
// Size: 0x2c
function function_4c91219b(a_ents) {
    level flag::set("station_walk_past_stairs");
}

// Namespace namespace_7434c6b7
// Params 1, eflags: 0x0
// Checksum 0xdae63ae3, Offset: 0x22e8
// Size: 0x4c
function function_1ec9cc48(a_ents) {
    objectives::complete("cp_level_ramses_meet_with_khalil");
    level waittill(#"hash_17035476");
    objectives::set("cp_level_ramses_go_to_holding_room");
}

// Namespace namespace_7434c6b7
// Params 1, eflags: 0x0
// Checksum 0xe768de80, Offset: 0x2340
// Size: 0x34
function function_fa1c2163(a_ents) {
    level waittill(#"hash_fa1c2163");
    level dialog::function_13b3b16a("plyr_winslow_accord_resou_0");
}

// Namespace namespace_7434c6b7
// Params 1, eflags: 0x0
// Checksum 0x996893c1, Offset: 0x2380
// Size: 0x174
function function_bc43c2f8(var_c4db808e) {
    if (!isdefined(var_c4db808e)) {
        var_c4db808e = 1;
    }
    level.var_9db406db ai::set_behavior_attribute("patrol", 1);
    level.var_9db406db ai::set_behavior_attribute("disablearrivals", 1);
    level.var_9db406db ai::set_behavior_attribute("vignette_mode", "slow");
    if (var_c4db808e) {
        level.var_9db406db waittill(#"hash_55d71436");
    }
    level.var_9db406db setgoal(getnode("khalil_post_station_walk_node", "targetname"), 1);
    level flag::wait_till("dr_nasser_interview_started");
    level.var_9db406db ai::set_behavior_attribute("patrol", 0);
    level.var_9db406db ai::set_behavior_attribute("disablearrivals", 0);
    level.var_9db406db ai::set_behavior_attribute("vignette_mode", "off");
}

// Namespace namespace_7434c6b7
// Params 1, eflags: 0x0
// Checksum 0xbfb8fa97, Offset: 0x2500
// Size: 0x34
function function_19a13445(a_ents) {
    level waittill(#"hash_5292a904");
    level flag::set("station_walk_complete");
}

// Namespace namespace_7434c6b7
// Params 0, eflags: 0x0
// Checksum 0xdfb60c2b, Offset: 0x2540
// Size: 0x602
function function_317364f4() {
    level util::waittill_notify_or_timeout("unaligned_walk_anims_init_done", 2);
    scene::init("cin_ram_02_03_station_vign_triage_helmettable_02");
    util::wait_network_frame();
    scene::init("cin_ram_02_04_walk_vign_movemove_02");
    util::wait_network_frame();
    scene::init("cin_ram_02_03_station_vign_walk_to_escalator_sit");
    util::wait_network_frame();
    scene::init("cin_ram_02_03_station_vign_run_to_crates");
    util::wait_network_frame();
    scene::init("cin_ram_02_03_station_walk_run_to_guy_at_cleanup");
    util::wait_network_frame();
    scene::init("cin_ram_02_03_station_vign_run_to_surgery_cleanup");
    util::wait_network_frame();
    scene::init("cin_ram_02_03_station_vign_guys_impede_vips_guy02");
    scene::init("cin_ram_02_03_station_vign_guys_impede_vips_guy01");
    util::wait_network_frame();
    scene::init("cin_ram_02_03_station_vign_jump_off_crates");
    scene::init("cin_ram_02_03_station_vign_triage_enter_02");
    util::wait_network_frame();
    scene::init("cin_ram_02_03_station_vign_mop_blood_move");
    util::wait_network_frame();
    scene::init("cin_ram_02_03_station_vign_intosurgery");
    util::wait_network_frame();
    scene::init("cin_ram_02_03_recovery_vign_walk_inspect");
    util::wait_network_frame();
    scene::init("cin_ram_02_03_station_vign_stressed");
    util::wait_network_frame();
    scene::init("cin_ram_02_03_station_vign_interview_guards");
    util::wait_network_frame();
    scene::init("cin_ram_02_03_station_vign_recovery_room_guys");
    level thread util::delay("play_impede_vips", "station_walk_cleanup", &scene::play, "cin_ram_02_03_station_vign_guys_impede_vips_guy01");
    level thread util::delay("play_impede_vips", "station_walk_cleanup", &scene::play, "cin_ram_02_03_station_vign_guys_impede_vips_guy02");
    level thread util::delay("play_walk_to_escalator_sit", "station_walk_cleanup", &scene::play, "cin_ram_02_03_station_vign_walk_to_escalator_sit");
    level thread util::delay("play_run_to_crates", "station_walk_cleanup", &scene::play, "cin_ram_02_03_station_vign_run_to_crates");
    level thread util::delay("play_run_to_surgery_cleanup", "station_walk_cleanup", &scene::play, "cin_ram_02_03_station_vign_run_to_surgery_cleanup");
    level thread util::delay("play_recovery_room_guys", "station_walk_cleanup", &scene::play, "cin_ram_02_03_station_vign_recovery_room_guys");
    level thread util::delay("play_interview_guards", "station_walk_cleanup", &scene::play, "cin_ram_02_03_station_vign_interview_guards");
    level thread util::delay("play_run_to_guy_at_cleanup", "station_walk_cleanup", &scene::play, "cin_ram_02_03_station_walk_run_to_guy_at_cleanup");
    level thread util::delay("play_triage_enter", "station_walk_cleanup", &scene::play, "cin_ram_02_03_station_vign_triage_enter_02");
    level thread util::delay("play_into_surgery", "station_walk_cleanup", &scene::play, "cin_ram_02_03_station_vign_intosurgery");
    level thread util::delay("play_mop_blood_move", "station_walk_cleanup", &scene::play, "cin_ram_02_03_station_vign_mop_blood_move");
    level thread util::delay("play_move_move", "station_walk_cleanup", &scene::play, "cin_ram_02_04_walk_vign_movemove_02");
    level thread util::delay("play_jump_off_crates", "station_walk_cleanup", &scene::play, "cin_ram_02_03_station_vign_jump_off_crates");
    level thread util::delay("play_helmet_table", "station_walk_cleanup", &scene::play, "cin_ram_02_03_station_vign_triage_helmettable_02");
    level thread util::delay("play_move_move", "station_walk_cleanup", &scene::play, "cin_ram_02_03_station_vign_stressed");
    level thread util::delay("play_inspect_servers", "station_walk_cleanup", &scene::play, "cin_ram_02_03_recovery_vign_walk_inspect");
    level notify(#"hash_bfb2bcf2");
}

// Namespace namespace_7434c6b7
// Params 0, eflags: 0x0
// Checksum 0xba8363cc, Offset: 0x2b50
// Size: 0x3da
function function_3a8a502() {
    level thread scene::play("cin_ram_02_03_station_vign_cornerguard_derive");
    util::wait_network_frame();
    level thread scene::init("cin_ram_02_03_station_vign_inspect_patients_02_medic");
    util::wait_network_frame();
    level thread scene::init("cin_ram_02_03_station_vign_inspect_patients_02_guy01");
    util::wait_network_frame();
    level thread scene::init("cin_ram_02_03_station_vign_inspect_patients_02_guy02");
    util::wait_network_frame();
    level thread scene::init("cin_ram_02_03_station_vign_inspect_patients_01_medic");
    util::wait_network_frame();
    level thread scene::init("cin_ram_02_03_station_vign_inspect_patients_01_guy01");
    util::wait_network_frame();
    level thread scene::init("cin_ram_02_03_station_vign_inspect_patients_01_guy02");
    util::wait_network_frame();
    util::wait_network_frame();
    level thread scene::play("cin_ram_02_03_station_vign_on_crates_inspecting");
    util::wait_network_frame();
    level thread scene::play("cin_ram_02_03_station_vign_inspecting_two_crates");
    util::wait_network_frame();
    level thread scene::play("cin_ram_02_03_station_vign_reflecting_guy01");
    util::wait_network_frame();
    level thread scene::play("cin_ram_02_03_station_vign_reflecting_guy02");
    util::wait_network_frame();
    level thread scene::play("cin_ram_02_03_station_vign_readingipad_guy01_raised");
    util::wait_network_frame();
    level thread scene::play("cin_ram_02_03_station_vign_readingipad_guy02");
    util::wait_network_frame();
    level thread scene::play("cin_ram_02_03_station_vign_supply_opencrate");
    util::wait_network_frame();
    level thread scene::play("cin_ram_02_03_station_vign_supply_inventory");
    util::wait_network_frame();
    level thread scene::play("cin_ram_02_03_recovery_vign_patient01");
    level thread scene::play("cin_ram_02_03_recovery_vign_patient02");
    level thread util::delay("play_recovery_medics", "station_walk_cleanup", &scene::play, "cin_ram_02_03_station_vign_inspect_patients_02_medic");
    level thread util::delay("play_recovery_medics", "station_walk_cleanup", &scene::play, "cin_ram_02_03_station_vign_inspect_patients_01_medic");
    level thread util::delay("play_medic_01_patient_02", "station_walk_cleanup", &scene::play, "cin_ram_02_03_station_vign_inspect_patients_01_guy02");
    level notify(#"hash_1980f74e");
}

// Namespace namespace_7434c6b7
// Params 0, eflags: 0x0
// Checksum 0x90da3486, Offset: 0x2f38
// Size: 0x162
function function_e9be9fb3() {
    level waittill(#"hash_1980f74e");
    level thread scene::play("cin_ram_02_03_station_vign_scaffold_inspecting");
    util::wait_network_frame();
    level thread scene::play("cin_ram_02_03_station_vign_amputee_arm_a");
    util::wait_network_frame();
    level thread scene::play("cin_ram_02_03_station_vign_amputee_arm_b");
    util::wait_network_frame();
    level thread scene::play("cin_ram_02_03_station_vign_shrapnel_comfort_1");
    level thread scene::play("cin_ram_02_03_station_vign_consoling_chair");
    level thread scene::play("cin_ram_02_03_station_vign_consoling");
    level thread scene::init("cin_ram_02_03_station_vign_triage_gurney_elevated_main");
    level thread util::delay("play_triage_enter", "station_walk_cleanup", &scene::play, "cin_ram_02_03_station_vign_triage_gurney_elevated_main");
    level notify(#"hash_5f07aa77");
}

// Namespace namespace_7434c6b7
// Params 1, eflags: 0x0
// Checksum 0xf550aa15, Offset: 0x30a8
// Size: 0x2c
function function_d86d27dc(a_ents) {
    level flag::set("end_tunneltalk_pt1");
}

// Namespace namespace_7434c6b7
// Params 0, eflags: 0x0
// Checksum 0xbbce7132, Offset: 0x30e0
// Size: 0x24
function function_2badd8cd() {
    level scene::play("cin_ram_02_03_interview_vign_forklift_passes");
}

// Namespace namespace_7434c6b7
// Params 0, eflags: 0x0
// Checksum 0x5ca6c806, Offset: 0x3110
// Size: 0x234
function function_a99e5acb() {
    level flag::wait_till("subway_cleared");
    var_65d86eb9 = getent("trig_subway_area_top", "targetname");
    var_889ac756 = getent("trig_subway_area_mid", "targetname");
    var_13d98121 = getent("trig_subway_area_bottom", "targetname");
    var_7bb6a6b6 = struct::get("subway_sight_target");
    do {
        var_d806b4f5 = 1;
        while (util::any_player_is_touching(var_65d86eb9, "allies") || util::any_player_is_touching(var_889ac756, "allies") || util::any_player_is_touching(var_13d98121, "allies")) {
            wait(0.25);
        }
        foreach (player in level.players) {
            if (player util::is_looking_at(var_7bb6a6b6, 0.5)) {
                var_d806b4f5 = 0;
            }
        }
        wait(0.25);
    } while (var_d806b4f5 == 0);
    function_51f408f1();
    level scene::play("cin_ram_02_03_station_vign_gate_guard_derive");
}

// Namespace namespace_7434c6b7
// Params 0, eflags: 0x0
// Checksum 0xa76528ed, Offset: 0x3350
// Size: 0x144
function function_51f408f1() {
    e_collision = getent("subway_collision", "script_string");
    e_collision show();
    a_blockers = getentarray("subway_blocker", "script_string");
    foreach (blocker in a_blockers) {
        blocker show();
    }
    exploder::kill_exploder("fx_exploder_sparks_off");
    level flag::set("hot_join_station_walk_warp");
    level thread function_7768c0ae();
}

// Namespace namespace_7434c6b7
// Params 0, eflags: 0x0
// Checksum 0x31c933a4, Offset: 0x34a0
// Size: 0x100
function function_7768c0ae() {
    level endon(#"hash_d1bd1424");
    var_716f4f40 = getent("trig_hot_join_station_walk_warp", "targetname");
    while (true) {
        var_716f4f40 trigger::wait_till();
        player = var_716f4f40.who;
        s_dest = struct::get("s_station_walk_hot_join_warp_" + player getentitynumber(), "targetname");
        player setorigin(s_dest.origin);
        player setplayerangles(s_dest.angles);
    }
}

// Namespace namespace_7434c6b7
// Params 1, eflags: 0x0
// Checksum 0x1a1b8115, Offset: 0x35a8
// Size: 0x23c6
function function_bbd12ed2(var_6dc777dc) {
    if (!isdefined(var_6dc777dc)) {
        var_6dc777dc = 1;
    }
    if (var_6dc777dc) {
        level flag::wait_till("station_walk_cleanup");
    } else {
        wait(0.05);
    }
    level notify(#"hash_39d63594");
    a_str_scenes = [];
    if (!isdefined(a_str_scenes)) {
        a_str_scenes = [];
    } else if (!isarray(a_str_scenes)) {
        a_str_scenes = array(a_str_scenes);
    }
    a_str_scenes[a_str_scenes.size] = "cin_ram_02_03_interview_vign_clipboard_a";
    if (!isdefined(a_str_scenes)) {
        a_str_scenes = [];
    } else if (!isarray(a_str_scenes)) {
        a_str_scenes = array(a_str_scenes);
    }
    a_str_scenes[a_str_scenes.size] = "cin_ram_02_03_interview_vign_clipboard_b";
    if (!isdefined(a_str_scenes)) {
        a_str_scenes = [];
    } else if (!isarray(a_str_scenes)) {
        a_str_scenes = array(a_str_scenes);
    }
    a_str_scenes[a_str_scenes.size] = "cin_ram_02_03_interview_vign_clipboard_c";
    if (!isdefined(a_str_scenes)) {
        a_str_scenes = [];
    } else if (!isarray(a_str_scenes)) {
        a_str_scenes = array(a_str_scenes);
    }
    a_str_scenes[a_str_scenes.size] = "cin_ram_02_03_interview_vign_argument_a";
    if (!isdefined(a_str_scenes)) {
        a_str_scenes = [];
    } else if (!isarray(a_str_scenes)) {
        a_str_scenes = array(a_str_scenes);
    }
    a_str_scenes[a_str_scenes.size] = "cin_ram_02_03_interview_vign_argument_b";
    if (!isdefined(a_str_scenes)) {
        a_str_scenes = [];
    } else if (!isarray(a_str_scenes)) {
        a_str_scenes = array(a_str_scenes);
    }
    a_str_scenes[a_str_scenes.size] = "cin_ram_02_03_walk_vign_forklift_loop";
    if (!isdefined(a_str_scenes)) {
        a_str_scenes = [];
    } else if (!isarray(a_str_scenes)) {
        a_str_scenes = array(a_str_scenes);
    }
    a_str_scenes[a_str_scenes.size] = "cin_ram_02_03_interview_vign_medsuppliesdelivery";
    if (!isdefined(a_str_scenes)) {
        a_str_scenes = [];
    } else if (!isarray(a_str_scenes)) {
        a_str_scenes = array(a_str_scenes);
    }
    a_str_scenes[a_str_scenes.size] = "cin_ram_02_03_interview_vign_patient_in_shock";
    if (!isdefined(a_str_scenes)) {
        a_str_scenes = [];
    } else if (!isarray(a_str_scenes)) {
        a_str_scenes = array(a_str_scenes);
    }
    a_str_scenes[a_str_scenes.size] = "cin_ram_02_03_interview_vign_forklift_passes";
    if (!isdefined(a_str_scenes)) {
        a_str_scenes = [];
    } else if (!isarray(a_str_scenes)) {
        a_str_scenes = array(a_str_scenes);
    }
    a_str_scenes[a_str_scenes.size] = "cin_ram_02_03_station_vign_bloodyhead_seated_guy01";
    if (!isdefined(a_str_scenes)) {
        a_str_scenes = [];
    } else if (!isarray(a_str_scenes)) {
        a_str_scenes = array(a_str_scenes);
    }
    a_str_scenes[a_str_scenes.size] = "cin_ram_02_03_station_vign_bloodyhead_seated_guy02";
    if (!isdefined(a_str_scenes)) {
        a_str_scenes = [];
    } else if (!isarray(a_str_scenes)) {
        a_str_scenes = array(a_str_scenes);
    }
    a_str_scenes[a_str_scenes.size] = "cin_ram_02_03_station_vign_bloodyhead_seated_guy03";
    if (!isdefined(a_str_scenes)) {
        a_str_scenes = [];
    } else if (!isarray(a_str_scenes)) {
        a_str_scenes = array(a_str_scenes);
    }
    a_str_scenes[a_str_scenes.size] = "cin_ram_02_03_station_vign_conversation";
    if (!isdefined(a_str_scenes)) {
        a_str_scenes = [];
    } else if (!isarray(a_str_scenes)) {
        a_str_scenes = array(a_str_scenes);
    }
    a_str_scenes[a_str_scenes.size] = "cin_ram_02_03_station_vign_sharpening";
    if (!isdefined(a_str_scenes)) {
        a_str_scenes = [];
    } else if (!isarray(a_str_scenes)) {
        a_str_scenes = array(a_str_scenes);
    }
    a_str_scenes[a_str_scenes.size] = "cin_ram_02_03_station_vign_sleeping_seated";
    if (!isdefined(a_str_scenes)) {
        a_str_scenes = [];
    } else if (!isarray(a_str_scenes)) {
        a_str_scenes = array(a_str_scenes);
    }
    a_str_scenes[a_str_scenes.size] = "cin_ram_02_03_station_vign_sleeping_seated_guy02";
    if (!isdefined(a_str_scenes)) {
        a_str_scenes = [];
    } else if (!isarray(a_str_scenes)) {
        a_str_scenes = array(a_str_scenes);
    }
    a_str_scenes[a_str_scenes.size] = "cin_ram_02_03_station_vign_sleeping_seated_guy03";
    if (!isdefined(a_str_scenes)) {
        a_str_scenes = [];
    } else if (!isarray(a_str_scenes)) {
        a_str_scenes = array(a_str_scenes);
    }
    a_str_scenes[a_str_scenes.size] = "cin_ram_02_03_station_vign_sleeping_seated_guy04";
    if (!isdefined(a_str_scenes)) {
        a_str_scenes = [];
    } else if (!isarray(a_str_scenes)) {
        a_str_scenes = array(a_str_scenes);
    }
    a_str_scenes[a_str_scenes.size] = "cin_ram_02_03_station_vign_using_ipad_guy01";
    if (!isdefined(a_str_scenes)) {
        a_str_scenes = [];
    } else if (!isarray(a_str_scenes)) {
        a_str_scenes = array(a_str_scenes);
    }
    a_str_scenes[a_str_scenes.size] = "cin_ram_02_03_station_vign_using_ipad_guy02";
    if (!isdefined(a_str_scenes)) {
        a_str_scenes = [];
    } else if (!isarray(a_str_scenes)) {
        a_str_scenes = array(a_str_scenes);
    }
    a_str_scenes[a_str_scenes.size] = "cin_ram_02_03_station_vign_using_ipad_guy03";
    if (!isdefined(a_str_scenes)) {
        a_str_scenes = [];
    } else if (!isarray(a_str_scenes)) {
        a_str_scenes = array(a_str_scenes);
    }
    a_str_scenes[a_str_scenes.size] = "cin_ram_02_03_station_vign_amputee_arm_a";
    if (!isdefined(a_str_scenes)) {
        a_str_scenes = [];
    } else if (!isarray(a_str_scenes)) {
        a_str_scenes = array(a_str_scenes);
    }
    a_str_scenes[a_str_scenes.size] = "cin_ram_02_03_station_vign_amputee_arm_b";
    if (!isdefined(a_str_scenes)) {
        a_str_scenes = [];
    } else if (!isarray(a_str_scenes)) {
        a_str_scenes = array(a_str_scenes);
    }
    a_str_scenes[a_str_scenes.size] = "cin_ram_02_03_station_vign_amputee_arm_c";
    if (!isdefined(a_str_scenes)) {
        a_str_scenes = [];
    } else if (!isarray(a_str_scenes)) {
        a_str_scenes = array(a_str_scenes);
    }
    a_str_scenes[a_str_scenes.size] = "cin_ram_02_03_station_vign_amputee_preist";
    if (!isdefined(a_str_scenes)) {
        a_str_scenes = [];
    } else if (!isarray(a_str_scenes)) {
        a_str_scenes = array(a_str_scenes);
    }
    a_str_scenes[a_str_scenes.size] = "cin_ram_02_03_station_vign_balcony_surveying_guy01";
    if (!isdefined(a_str_scenes)) {
        a_str_scenes = [];
    } else if (!isarray(a_str_scenes)) {
        a_str_scenes = array(a_str_scenes);
    }
    a_str_scenes[a_str_scenes.size] = "cin_ram_02_03_station_vign_balcony_surveying_guy02";
    if (!isdefined(a_str_scenes)) {
        a_str_scenes = [];
    } else if (!isarray(a_str_scenes)) {
        a_str_scenes = array(a_str_scenes);
    }
    a_str_scenes[a_str_scenes.size] = "cin_ram_02_03_station_vign_balcony_surveying_guy03";
    if (!isdefined(a_str_scenes)) {
        a_str_scenes = [];
    } else if (!isarray(a_str_scenes)) {
        a_str_scenes = array(a_str_scenes);
    }
    a_str_scenes[a_str_scenes.size] = "cin_ram_02_03_station_vign_triage_bleedout";
    if (!isdefined(a_str_scenes)) {
        a_str_scenes = [];
    } else if (!isarray(a_str_scenes)) {
        a_str_scenes = array(a_str_scenes);
    }
    a_str_scenes[a_str_scenes.size] = "cin_ram_02_03_station_vign_seizure_soldier";
    if (!isdefined(a_str_scenes)) {
        a_str_scenes = [];
    } else if (!isarray(a_str_scenes)) {
        a_str_scenes = array(a_str_scenes);
    }
    a_str_scenes[a_str_scenes.size] = "cin_ram_02_03_station_vign_scaffold_inspecting";
    if (!isdefined(a_str_scenes)) {
        a_str_scenes = [];
    } else if (!isarray(a_str_scenes)) {
        a_str_scenes = array(a_str_scenes);
    }
    a_str_scenes[a_str_scenes.size] = "cin_ram_02_03_station_vign_staring_guy01";
    if (!isdefined(a_str_scenes)) {
        a_str_scenes = [];
    } else if (!isarray(a_str_scenes)) {
        a_str_scenes = array(a_str_scenes);
    }
    a_str_scenes[a_str_scenes.size] = "cin_ram_02_03_station_vign_giving_blood_guy1";
    if (!isdefined(a_str_scenes)) {
        a_str_scenes = [];
    } else if (!isarray(a_str_scenes)) {
        a_str_scenes = array(a_str_scenes);
    }
    a_str_scenes[a_str_scenes.size] = "cin_ram_02_03_station_vign_giving_blood_guy2";
    if (!isdefined(a_str_scenes)) {
        a_str_scenes = [];
    } else if (!isarray(a_str_scenes)) {
        a_str_scenes = array(a_str_scenes);
    }
    a_str_scenes[a_str_scenes.size] = "cin_ram_02_03_station_vign_giving_blood_guy3";
    if (!isdefined(a_str_scenes)) {
        a_str_scenes = [];
    } else if (!isarray(a_str_scenes)) {
        a_str_scenes = array(a_str_scenes);
    }
    a_str_scenes[a_str_scenes.size] = "cin_ram_02_03_station_vign_thousandstare_a_guy02";
    if (!isdefined(a_str_scenes)) {
        a_str_scenes = [];
    } else if (!isarray(a_str_scenes)) {
        a_str_scenes = array(a_str_scenes);
    }
    a_str_scenes[a_str_scenes.size] = "cin_ram_02_03_station_vign_thousandstare_a_guy03";
    if (!isdefined(a_str_scenes)) {
        a_str_scenes = [];
    } else if (!isarray(a_str_scenes)) {
        a_str_scenes = array(a_str_scenes);
    }
    a_str_scenes[a_str_scenes.size] = "cin_ram_02_03_station_vign_thousandstare_b_guy02";
    if (!isdefined(a_str_scenes)) {
        a_str_scenes = [];
    } else if (!isarray(a_str_scenes)) {
        a_str_scenes = array(a_str_scenes);
    }
    a_str_scenes[a_str_scenes.size] = "cin_ram_02_03_station_vign_thousandstare_b_guy01";
    if (!isdefined(a_str_scenes)) {
        a_str_scenes = [];
    } else if (!isarray(a_str_scenes)) {
        a_str_scenes = array(a_str_scenes);
    }
    a_str_scenes[a_str_scenes.size] = "cin_ram_02_03_station_vign_treated_soldier_guy05";
    if (!isdefined(a_str_scenes)) {
        a_str_scenes = [];
    } else if (!isarray(a_str_scenes)) {
        a_str_scenes = array(a_str_scenes);
    }
    a_str_scenes[a_str_scenes.size] = "cin_ram_02_03_station_vign_treated_soldier_guy06";
    if (!isdefined(a_str_scenes)) {
        a_str_scenes = [];
    } else if (!isarray(a_str_scenes)) {
        a_str_scenes = array(a_str_scenes);
    }
    a_str_scenes[a_str_scenes.size] = "cin_ram_02_03_station_vign_treated_soldier_guy08";
    if (!isdefined(a_str_scenes)) {
        a_str_scenes = [];
    } else if (!isarray(a_str_scenes)) {
        a_str_scenes = array(a_str_scenes);
    }
    a_str_scenes[a_str_scenes.size] = "cin_ram_02_03_station_vign_nervous_guy03";
    if (!isdefined(a_str_scenes)) {
        a_str_scenes = [];
    } else if (!isarray(a_str_scenes)) {
        a_str_scenes = array(a_str_scenes);
    }
    a_str_scenes[a_str_scenes.size] = "cin_ram_02_03_station_vign_smoking_guy03";
    if (!isdefined(a_str_scenes)) {
        a_str_scenes = [];
    } else if (!isarray(a_str_scenes)) {
        a_str_scenes = array(a_str_scenes);
    }
    a_str_scenes[a_str_scenes.size] = "cin_ram_02_03_station_vign_smoking_guy04";
    if (!isdefined(a_str_scenes)) {
        a_str_scenes = [];
    } else if (!isarray(a_str_scenes)) {
        a_str_scenes = array(a_str_scenes);
    }
    a_str_scenes[a_str_scenes.size] = "cin_ram_02_03_station_vign_on_crates_inspecting";
    if (!isdefined(a_str_scenes)) {
        a_str_scenes = [];
    } else if (!isarray(a_str_scenes)) {
        a_str_scenes = array(a_str_scenes);
    }
    a_str_scenes[a_str_scenes.size] = "cin_ram_02_03_station_vign_inspecting_two_crates";
    if (!isdefined(a_str_scenes)) {
        a_str_scenes = [];
    } else if (!isarray(a_str_scenes)) {
        a_str_scenes = array(a_str_scenes);
    }
    a_str_scenes[a_str_scenes.size] = "cin_ram_02_03_station_vign_reflecting_guy01";
    if (!isdefined(a_str_scenes)) {
        a_str_scenes = [];
    } else if (!isarray(a_str_scenes)) {
        a_str_scenes = array(a_str_scenes);
    }
    a_str_scenes[a_str_scenes.size] = "cin_ram_02_03_station_vign_reflecting_guy02";
    if (!isdefined(a_str_scenes)) {
        a_str_scenes = [];
    } else if (!isarray(a_str_scenes)) {
        a_str_scenes = array(a_str_scenes);
    }
    a_str_scenes[a_str_scenes.size] = "cin_ram_02_03_station_vign_readingipad_guy01_raised";
    if (!isdefined(a_str_scenes)) {
        a_str_scenes = [];
    } else if (!isarray(a_str_scenes)) {
        a_str_scenes = array(a_str_scenes);
    }
    a_str_scenes[a_str_scenes.size] = "cin_ram_02_03_station_vign_readingipad_guy02";
    if (!isdefined(a_str_scenes)) {
        a_str_scenes = [];
    } else if (!isarray(a_str_scenes)) {
        a_str_scenes = array(a_str_scenes);
    }
    a_str_scenes[a_str_scenes.size] = "cin_ram_02_03_station_vign_supply_opencrate";
    if (!isdefined(a_str_scenes)) {
        a_str_scenes = [];
    } else if (!isarray(a_str_scenes)) {
        a_str_scenes = array(a_str_scenes);
    }
    a_str_scenes[a_str_scenes.size] = "cin_ram_02_03_station_vign_supply_inventory";
    if (!isdefined(a_str_scenes)) {
        a_str_scenes = [];
    } else if (!isarray(a_str_scenes)) {
        a_str_scenes = array(a_str_scenes);
    }
    a_str_scenes[a_str_scenes.size] = "cin_ram_02_03_station_vign_inspect_patients_01_medic";
    if (!isdefined(a_str_scenes)) {
        a_str_scenes = [];
    } else if (!isarray(a_str_scenes)) {
        a_str_scenes = array(a_str_scenes);
    }
    a_str_scenes[a_str_scenes.size] = "cin_ram_02_03_station_vign_inspect_patients_01_guy01";
    if (!isdefined(a_str_scenes)) {
        a_str_scenes = [];
    } else if (!isarray(a_str_scenes)) {
        a_str_scenes = array(a_str_scenes);
    }
    a_str_scenes[a_str_scenes.size] = "cin_ram_02_03_station_vign_inspect_patients_01_guy02";
    if (!isdefined(a_str_scenes)) {
        a_str_scenes = [];
    } else if (!isarray(a_str_scenes)) {
        a_str_scenes = array(a_str_scenes);
    }
    a_str_scenes[a_str_scenes.size] = "cin_ram_02_03_station_vign_inspect_patients_02_medic";
    if (!isdefined(a_str_scenes)) {
        a_str_scenes = [];
    } else if (!isarray(a_str_scenes)) {
        a_str_scenes = array(a_str_scenes);
    }
    a_str_scenes[a_str_scenes.size] = "cin_ram_02_03_station_vign_inspect_patients_02_medic_endloop";
    if (!isdefined(a_str_scenes)) {
        a_str_scenes = [];
    } else if (!isarray(a_str_scenes)) {
        a_str_scenes = array(a_str_scenes);
    }
    a_str_scenes[a_str_scenes.size] = "cin_ram_02_03_station_vign_inspect_patients_02_guy01";
    if (!isdefined(a_str_scenes)) {
        a_str_scenes = [];
    } else if (!isarray(a_str_scenes)) {
        a_str_scenes = array(a_str_scenes);
    }
    a_str_scenes[a_str_scenes.size] = "cin_ram_02_03_station_vign_inspect_patients_02_guy02";
    if (!isdefined(a_str_scenes)) {
        a_str_scenes = [];
    } else if (!isarray(a_str_scenes)) {
        a_str_scenes = array(a_str_scenes);
    }
    a_str_scenes[a_str_scenes.size] = "cin_ram_02_03_station_vign_triage_helmettable_02";
    if (!isdefined(a_str_scenes)) {
        a_str_scenes = [];
    } else if (!isarray(a_str_scenes)) {
        a_str_scenes = array(a_str_scenes);
    }
    a_str_scenes[a_str_scenes.size] = "cin_ram_02_03_station_vign_bloodmopping";
    if (!isdefined(a_str_scenes)) {
        a_str_scenes = [];
    } else if (!isarray(a_str_scenes)) {
        a_str_scenes = array(a_str_scenes);
    }
    a_str_scenes[a_str_scenes.size] = "cin_ram_02_03_station_vign_triage_nursegauze_distributing";
    if (!isdefined(a_str_scenes)) {
        a_str_scenes = [];
    } else if (!isarray(a_str_scenes)) {
        a_str_scenes = array(a_str_scenes);
    }
    a_str_scenes[a_str_scenes.size] = "cin_ram_02_03_station_vign_triage_cot_exitdoors";
    if (!isdefined(a_str_scenes)) {
        a_str_scenes = [];
    } else if (!isarray(a_str_scenes)) {
        a_str_scenes = array(a_str_scenes);
    }
    a_str_scenes[a_str_scenes.size] = "cin_ram_02_03_station_walk_run_to_guy_at_cleanup";
    if (!isdefined(a_str_scenes)) {
        a_str_scenes = [];
    } else if (!isarray(a_str_scenes)) {
        a_str_scenes = array(a_str_scenes);
    }
    a_str_scenes[a_str_scenes.size] = "cin_ram_02_03_station_vign_interview_guards";
    if (!isdefined(a_str_scenes)) {
        a_str_scenes = [];
    } else if (!isarray(a_str_scenes)) {
        a_str_scenes = array(a_str_scenes);
    }
    a_str_scenes[a_str_scenes.size] = "cin_ram_02_03_station_vign_recovery_room_guys";
    if (!isdefined(a_str_scenes)) {
        a_str_scenes = [];
    } else if (!isarray(a_str_scenes)) {
        a_str_scenes = array(a_str_scenes);
    }
    a_str_scenes[a_str_scenes.size] = "cin_ram_02_03_station_vign_walk_to_escalator_sit";
    if (!isdefined(a_str_scenes)) {
        a_str_scenes = [];
    } else if (!isarray(a_str_scenes)) {
        a_str_scenes = array(a_str_scenes);
    }
    a_str_scenes[a_str_scenes.size] = "cin_ram_02_03_station_vign_run_to_crates";
    if (!isdefined(a_str_scenes)) {
        a_str_scenes = [];
    } else if (!isarray(a_str_scenes)) {
        a_str_scenes = array(a_str_scenes);
    }
    a_str_scenes[a_str_scenes.size] = "cin_ram_02_03_station_vign_run_to_surgery_cleanup";
    if (!isdefined(a_str_scenes)) {
        a_str_scenes = [];
    } else if (!isarray(a_str_scenes)) {
        a_str_scenes = array(a_str_scenes);
    }
    a_str_scenes[a_str_scenes.size] = "cin_ram_02_03_station_vign_guys_impede_vips_guy01";
    if (!isdefined(a_str_scenes)) {
        a_str_scenes = [];
    } else if (!isarray(a_str_scenes)) {
        a_str_scenes = array(a_str_scenes);
    }
    a_str_scenes[a_str_scenes.size] = "cin_ram_02_03_station_vign_guys_impede_vips_guy02";
    if (!isdefined(a_str_scenes)) {
        a_str_scenes = [];
    } else if (!isarray(a_str_scenes)) {
        a_str_scenes = array(a_str_scenes);
    }
    a_str_scenes[a_str_scenes.size] = "cin_ram_02_03_station_vign_run_to_guy_at_cleanup";
    if (!isdefined(a_str_scenes)) {
        a_str_scenes = [];
    } else if (!isarray(a_str_scenes)) {
        a_str_scenes = array(a_str_scenes);
    }
    a_str_scenes[a_str_scenes.size] = "cin_ram_02_03_station_vign_jump_off_crates";
    if (!isdefined(a_str_scenes)) {
        a_str_scenes = [];
    } else if (!isarray(a_str_scenes)) {
        a_str_scenes = array(a_str_scenes);
    }
    a_str_scenes[a_str_scenes.size] = "cin_ram_02_03_station_vign_triage_enter_02";
    if (!isdefined(a_str_scenes)) {
        a_str_scenes = [];
    } else if (!isarray(a_str_scenes)) {
        a_str_scenes = array(a_str_scenes);
    }
    a_str_scenes[a_str_scenes.size] = "cin_ram_02_03_station_vign_mop_blood_move";
    if (!isdefined(a_str_scenes)) {
        a_str_scenes = [];
    } else if (!isarray(a_str_scenes)) {
        a_str_scenes = array(a_str_scenes);
    }
    a_str_scenes[a_str_scenes.size] = "cin_ram_02_04_walk_vign_movemove_02";
    if (!isdefined(a_str_scenes)) {
        a_str_scenes = [];
    } else if (!isarray(a_str_scenes)) {
        a_str_scenes = array(a_str_scenes);
    }
    a_str_scenes[a_str_scenes.size] = "cin_ram_02_03_station_vign_intosurgery";
    if (!isdefined(a_str_scenes)) {
        a_str_scenes = [];
    } else if (!isarray(a_str_scenes)) {
        a_str_scenes = array(a_str_scenes);
    }
    a_str_scenes[a_str_scenes.size] = "cin_ram_02_04_walk_1st_thousandyardstare";
    if (!isdefined(a_str_scenes)) {
        a_str_scenes = [];
    } else if (!isarray(a_str_scenes)) {
        a_str_scenes = array(a_str_scenes);
    }
    a_str_scenes[a_str_scenes.size] = "cin_ram_02_03_station_vign_stressed";
    if (!isdefined(a_str_scenes)) {
        a_str_scenes = [];
    } else if (!isarray(a_str_scenes)) {
        a_str_scenes = array(a_str_scenes);
    }
    a_str_scenes[a_str_scenes.size] = "cin_ram_02_03_recovery_vign_walk_inspect";
    if (!isdefined(a_str_scenes)) {
        a_str_scenes = [];
    } else if (!isarray(a_str_scenes)) {
        a_str_scenes = array(a_str_scenes);
    }
    a_str_scenes[a_str_scenes.size] = "cin_ram_02_03_recovery_vign_patient01";
    if (!isdefined(a_str_scenes)) {
        a_str_scenes = [];
    } else if (!isarray(a_str_scenes)) {
        a_str_scenes = array(a_str_scenes);
    }
    a_str_scenes[a_str_scenes.size] = "cin_ram_02_03_recovery_vign_patient02";
    if (!isdefined(a_str_scenes)) {
        a_str_scenes = [];
    } else if (!isarray(a_str_scenes)) {
        a_str_scenes = array(a_str_scenes);
    }
    a_str_scenes[a_str_scenes.size] = "cin_ram_02_03_station_vign_cornerguard_derive";
    if (!isdefined(a_str_scenes)) {
        a_str_scenes = [];
    } else if (!isarray(a_str_scenes)) {
        a_str_scenes = array(a_str_scenes);
    }
    a_str_scenes[a_str_scenes.size] = "cin_ram_02_03_station_vign_gate_guard_derive";
    if (!isdefined(a_str_scenes)) {
        a_str_scenes = [];
    } else if (!isarray(a_str_scenes)) {
        a_str_scenes = array(a_str_scenes);
    }
    a_str_scenes[a_str_scenes.size] = "cin_ram_02_03_station_vign_amputee_arm_a";
    if (!isdefined(a_str_scenes)) {
        a_str_scenes = [];
    } else if (!isarray(a_str_scenes)) {
        a_str_scenes = array(a_str_scenes);
    }
    a_str_scenes[a_str_scenes.size] = "cin_ram_02_03_station_vign_amputee_arm_b";
    if (!isdefined(a_str_scenes)) {
        a_str_scenes = [];
    } else if (!isarray(a_str_scenes)) {
        a_str_scenes = array(a_str_scenes);
    }
    a_str_scenes[a_str_scenes.size] = "cin_ram_02_03_station_vign_shrapnel_comfort_1";
    if (!isdefined(a_str_scenes)) {
        a_str_scenes = [];
    } else if (!isarray(a_str_scenes)) {
        a_str_scenes = array(a_str_scenes);
    }
    a_str_scenes[a_str_scenes.size] = "cin_ram_02_03_station_vign_triage_gurney_elevated_main";
    if (!isdefined(a_str_scenes)) {
        a_str_scenes = [];
    } else if (!isarray(a_str_scenes)) {
        a_str_scenes = array(a_str_scenes);
    }
    a_str_scenes[a_str_scenes.size] = "cin_ram_02_03_station_vign_consoling_chair";
    if (!isdefined(a_str_scenes)) {
        a_str_scenes = [];
    } else if (!isarray(a_str_scenes)) {
        a_str_scenes = array(a_str_scenes);
    }
    a_str_scenes[a_str_scenes.size] = "cin_ram_02_03_station_vign_consoling";
    if (!isdefined(a_str_scenes)) {
        a_str_scenes = [];
    } else if (!isarray(a_str_scenes)) {
        a_str_scenes = array(a_str_scenes);
    }
    a_str_scenes[a_str_scenes.size] = "cin_ram_01_01_enterstation_vign_loading";
    n_cycles = 0;
    foreach (str_scene in a_str_scenes) {
        if (level scene::is_active(str_scene)) {
            level thread scene::stop(str_scene, 1);
            n_cycles++;
            if (n_cycles > 4) {
                wait(0.05);
                n_cycles = 0;
            }
        }
    }
}

// Namespace namespace_7434c6b7
// Params 0, eflags: 0x0
// Checksum 0x25567b60, Offset: 0x5978
// Size: 0x198
function function_6b91ca4() {
    level endon(#"hash_39d63594");
    var_dc1935e1 = struct::get_array("walk_flyover_vtol", "targetname");
    var_795e65b4 = struct::get_array("struct_station_fly_end", "targetname");
    while (true) {
        v_start = array::random(var_dc1935e1).origin;
        var_2ef9d306 = spawn("script_model", v_start);
        var_2ef9d306 setmodel("p7_mil_vtol_egypt_alphatest");
        util::wait_network_frame();
        v_end_pos = array::random(var_795e65b4).origin;
        var_84574b1 = v_end_pos - v_start;
        angles = vectortoangles(var_84574b1);
        var_2ef9d306.angles = angles;
        var_2ef9d306 thread function_4fec5052(v_end_pos);
        wait(randomfloatrange(12, 15));
    }
}

// Namespace namespace_7434c6b7
// Params 1, eflags: 0x0
// Checksum 0x7dca82b2, Offset: 0x5b18
// Size: 0x4c
function function_4fec5052(v_end_pos) {
    self moveto(v_end_pos, 5);
    self waittill(#"movedone");
    self delete();
}

// Namespace namespace_7434c6b7
// Params 0, eflags: 0x0
// Checksum 0x24d04157, Offset: 0x5b70
// Size: 0x1b4
function function_78528b3d() {
    level thread function_54d1b8f8("sndScene1", (6346, -1864, 94), "vox_rams_vign_generic_002_med3", "vox_rams_vign_generic_003_med4", "vox_rams_vign_generic_006_med3");
    level thread function_54d1b8f8("sndScene2", (6830, -1580, 90), "vox_rams_vign_generic_000_med1", "vox_rams_vign_generic_001_med2");
    level thread function_54d1b8f8("sndScene3", (7079, -2344, 84), "vox_rams_vign_inventory_001_esl2", "vox_rams_vign_inventory_002_esl3");
    level thread function_54d1b8f8("sndScene4", (7442, -1686, 86), "vox_rams_vign_generic_010_srg1", "vox_rams_vign_generic_011_srg4", "vox_rams_vign_generic_016_srg1");
    level thread function_54d1b8f8("sndScene5", (7907, -1126, 96), "vox_rams_vign_inventory_003_esl4", "vox_rams_vign_inventory_004_esl1");
    level thread function_54d1b8f8("sndScene6", (7251, -398, 36), "vox_rams_vign_civ2_000_esl1", "vox_rams_vign_civ2_001_esl2");
    level thread function_54d1b8f8("sndScene7", (7442, -1686, 86), "vox_rams_vign_generic_008_med1", "vox_rams_vign_generic_009_med2");
    level thread function_671a7a61();
}

// Namespace namespace_7434c6b7
// Params 6, eflags: 0x0
// Checksum 0xc3befe76, Offset: 0x5d30
// Size: 0x134
function function_54d1b8f8(var_562e5771, sndorigin, alias1, alias2, alias3, alias4) {
    level waittill(var_562e5771);
    playsoundatposition(alias1, sndorigin);
    level function_e43e1d61(alias1);
    if (isdefined(alias2)) {
        playsoundatposition(alias2, sndorigin);
        level function_e43e1d61(alias1);
    }
    if (isdefined(alias3)) {
        playsoundatposition(alias3, sndorigin);
        level function_e43e1d61(alias1);
    }
    if (isdefined(alias4)) {
        playsoundatposition(alias4, sndorigin);
        level function_e43e1d61(alias1);
    }
}

// Namespace namespace_7434c6b7
// Params 1, eflags: 0x0
// Checksum 0x4432ede8, Offset: 0x5e70
// Size: 0x68
function function_e43e1d61(soundalias) {
    playbacktime = soundgetplaybacktime(soundalias);
    if (playbacktime >= 0) {
        waittime = playbacktime * 0.001;
        wait(waittime);
        return;
    }
    wait(1);
}

// Namespace namespace_7434c6b7
// Params 0, eflags: 0x0
// Checksum 0xa56110c0, Offset: 0x5ee0
// Size: 0x70
function function_671a7a61() {
    sndent = spawn("script_origin", (7068, -1791, 548));
    while (true) {
        level waittill(#"hash_166d2243");
        sndent playsound("amb_hospital_pa");
    }
}

