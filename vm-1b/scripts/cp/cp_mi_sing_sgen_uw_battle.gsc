#using scripts/cp/cp_mi_sing_sgen_util;
#using scripts/cp/cp_mi_sing_sgen_flood;
#using scripts/cp/cp_mi_sing_sgen;
#using scripts/cp/_util;
#using scripts/cp/_spawn_manager;
#using scripts/cp/_skipto;
#using scripts/cp/_objectives;
#using scripts/cp/_hazard;
#using scripts/cp/_load;
#using scripts/cp/_dialog;
#using scripts/shared/util_shared;
#using scripts/shared/trigger_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/colors_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/array_shared;
#using scripts/shared/ai_shared;
#using scripts/codescripts/struct;

#namespace namespace_b1c45cf3;

// Namespace namespace_b1c45cf3
// Params 2, eflags: 0x0
// namespace_b1c45cf3<file_0>::function_297ca3c6
// Checksum 0x5c407fee, Offset: 0x570
// Size: 0x23a
function function_297ca3c6(str_objective, var_74cd64bc) {
    level clientfield::set("w_underwater_state", 1);
    setdvar("player_swimTime", 5000);
    var_1787c657 = getent("water_ride_explosion_damage", "targetname");
    var_1787c657 triggerenable(0);
    level util::clientnotify("tuwc");
    level thread function_48cb67f6();
    if (var_74cd64bc) {
        namespace_fa13d4ba::function_bff1a867(str_objective);
        objectives::set("cp_level_sgen_escape_sgen");
    }
    level.var_2fd26037 ai::set_ignoreme(1);
    level scene::init("cin_sgen_23_01_underwater_battle_vign_swim_hendricks_groundidl");
    level scene::init("p7_fxanim_cp_sgen_door_hendricks_explosion_bundle");
    if (var_74cd64bc) {
        load::function_a2995f22();
    } else {
        wait(0.05);
        skipto::teleport("underwater_battle");
    }
    foreach (player in level.players) {
        player clientfield::set_to_player("water_motes", 1);
        player clientfield::set_to_player("water_teleport", 1);
        player thread hazard::function_e9b126ef();
    }
    spawner::add_global_spawn_function("axis", &namespace_cba4cc55::function_a527e6f9);
    function_dbfa8dae();
    skipto::function_be8adfb8("underwater_battle");
}

// Namespace namespace_b1c45cf3
// Params 4, eflags: 0x0
// namespace_b1c45cf3<file_0>::function_ceb4ae50
// Checksum 0xc9a01e9, Offset: 0x7b8
// Size: 0x22
function function_ceb4ae50(str_objective, var_74cd64bc, var_e4cd2b8b, player) {
    
}

// Namespace namespace_b1c45cf3
// Params 0, eflags: 0x0
// namespace_b1c45cf3<file_0>::function_dbfa8dae
// Checksum 0x77c4d972, Offset: 0x7e8
// Size: 0xf2
function function_dbfa8dae() {
    level util::clientnotify("underwater_fan");
    level util::clientnotify("tuwc");
    level thread function_77b723a3();
    level thread scene::play("cin_sgen_23_01_underwater_battle_vign_swim_hendricks_groundidl");
    while (!scene::is_ready("cin_sgen_23_01_underwater_battle_vign_swim_hendricks_groundidl")) {
        wait(0.1);
    }
    level thread namespace_caee6f4a::function_82311a3e();
    spawn_manager::enable("uw_battle_spawnmanager");
    level thread function_b980dc78();
    level flag::wait_till("hendricks_uwb_to_window");
    level scene::play("cin_sgen_23_01_underwater_battle_vign_swim_hendricks_traverse_room", level.var_2fd26037);
}

// Namespace namespace_b1c45cf3
// Params 0, eflags: 0x0
// namespace_b1c45cf3<file_0>::function_b980dc78
// Checksum 0x64bec466, Offset: 0x8e8
// Size: 0xb2
function function_b980dc78() {
    level.var_2fd26037 dialog::say("hend_what_now_kane_0");
    level dialog::remote("kane_above_you_marking_y_0", 1);
    level thread objectives::breadcrumb("uw_rail_sequence_start");
    level waittill(#"hash_5d296f1e");
    level dialog::remote("kane_blow_that_door_wate_0", 0.5);
    level flag::wait_till("hendricks_uwb_to_window");
    level.var_2fd26037 dialog::say("hend_on_me_once_i_blow_t_0");
}

// Namespace namespace_b1c45cf3
// Params 0, eflags: 0x0
// namespace_b1c45cf3<file_0>::function_48cb67f6
// Checksum 0xe59e975d, Offset: 0x9a8
// Size: 0x13a
function function_48cb67f6() {
    a_ai = getaiteamarray("axis", "team3");
    foreach (ai in a_ai) {
        if (!(isdefined(ai.archetype) && ai.archetype == "robot")) {
            ai util::delay(randomfloatrange(0.05, 0.75), "death", &kill);
        }
    }
    s_lookat = struct::get("underwater_battle_drowning_54i_lookat");
    var_dc83f241 = struct::get_array("underwater_battle_drowning_54i");
    array::thread_all(var_dc83f241, &scene::play);
}

// Namespace namespace_b1c45cf3
// Params 0, eflags: 0x0
// namespace_b1c45cf3<file_0>::function_77b723a3
// Checksum 0x12f289c7, Offset: 0xaf0
// Size: 0x6b
function function_77b723a3() {
    wait(5);
    foreach (player in level.activeplayers) {
        player util::show_hint_text(%COOP_SWIM_INSTRUCTIONS);
    }
}

