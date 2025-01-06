#using scripts/codescripts/struct;
#using scripts/cp/_dialog;
#using scripts/cp/_hazard;
#using scripts/cp/_load;
#using scripts/cp/_objectives;
#using scripts/cp/_skipto;
#using scripts/cp/_spawn_manager;
#using scripts/cp/_util;
#using scripts/cp/cp_mi_sing_sgen;
#using scripts/cp/cp_mi_sing_sgen_flood;
#using scripts/cp/cp_mi_sing_sgen_util;
#using scripts/shared/ai_shared;
#using scripts/shared/array_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/colors_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/trigger_shared;
#using scripts/shared/util_shared;

#namespace cp_mi_sing_sgen_uw_battle;

// Namespace cp_mi_sing_sgen_uw_battle
// Params 2, eflags: 0x0
// Checksum 0xf95c4d8a, Offset: 0x570
// Size: 0x2c4
function function_297ca3c6(str_objective, var_74cd64bc) {
    level clientfield::set("w_underwater_state", 1);
    setdvar("player_swimTime", 5000);
    var_1787c657 = getent("water_ride_explosion_damage", "targetname");
    var_1787c657 triggerenable(0);
    level util::clientnotify("tuwc");
    level thread function_48cb67f6();
    if (var_74cd64bc) {
        sgen::function_bff1a867(str_objective);
        objectives::set("cp_level_sgen_escape_sgen");
    }
    level.var_2fd26037 ai::set_ignoreme(1);
    level scene::init("cin_sgen_23_01_underwater_battle_vign_swim_hendricks_groundidl");
    level scene::init("p7_fxanim_cp_sgen_door_hendricks_explosion_bundle");
    if (var_74cd64bc) {
        load::function_a2995f22();
    } else {
        wait 0.05;
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

// Namespace cp_mi_sing_sgen_uw_battle
// Params 4, eflags: 0x0
// Checksum 0xfb8219ce, Offset: 0x840
// Size: 0x24
function function_ceb4ae50(str_objective, var_74cd64bc, var_e4cd2b8b, player) {
    
}

// Namespace cp_mi_sing_sgen_uw_battle
// Params 0, eflags: 0x0
// Checksum 0x59b45a80, Offset: 0x870
// Size: 0x134
function function_dbfa8dae() {
    level util::clientnotify("underwater_fan");
    level util::clientnotify("tuwc");
    level thread function_77b723a3();
    level thread scene::play("cin_sgen_23_01_underwater_battle_vign_swim_hendricks_groundidl");
    while (!scene::is_ready("cin_sgen_23_01_underwater_battle_vign_swim_hendricks_groundidl")) {
        wait 0.1;
    }
    level thread cp_mi_sing_sgen_flood::function_82311a3e();
    spawn_manager::enable("uw_battle_spawnmanager");
    level thread function_b980dc78();
    level flag::wait_till("hendricks_uwb_to_window");
    level scene::play("cin_sgen_23_01_underwater_battle_vign_swim_hendricks_traverse_room", level.var_2fd26037);
}

// Namespace cp_mi_sing_sgen_uw_battle
// Params 0, eflags: 0x0
// Checksum 0x5408ce87, Offset: 0x9b0
// Size: 0xd4
function function_b980dc78() {
    level.var_2fd26037 dialog::say("hend_what_now_kane_0");
    level dialog::remote("kane_above_you_marking_y_0", 1);
    level thread objectives::breadcrumb("uw_rail_sequence_start");
    level waittill(#"hash_5d296f1e");
    level dialog::remote("kane_blow_that_door_wate_0", 0.5);
    level flag::wait_till("hendricks_uwb_to_window");
    level.var_2fd26037 dialog::say("hend_on_me_once_i_blow_t_0");
}

// Namespace cp_mi_sing_sgen_uw_battle
// Params 0, eflags: 0x0
// Checksum 0x889a9052, Offset: 0xa90
// Size: 0x18c
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

// Namespace cp_mi_sing_sgen_uw_battle
// Params 0, eflags: 0x0
// Checksum 0x3b6a0997, Offset: 0xc28
// Size: 0x9a
function function_77b723a3() {
    wait 5;
    foreach (player in level.activeplayers) {
        player util::show_hint_text(%COOP_SWIM_INSTRUCTIONS);
    }
}

