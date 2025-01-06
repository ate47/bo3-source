#using scripts/codescripts/struct;
#using scripts/cp/_dialog;
#using scripts/cp/_hacking;
#using scripts/cp/_load;
#using scripts/cp/_objectives;
#using scripts/cp/_skipto;
#using scripts/cp/_util;
#using scripts/cp/cp_mi_sing_sgen;
#using scripts/cp/cp_mi_sing_sgen_sound;
#using scripts/cp/cp_mi_sing_sgen_util;
#using scripts/cp/cybercom/_cybercom_util;
#using scripts/shared/clientfield_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/gameobjects_shared;
#using scripts/shared/math_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/trigger_shared;
#using scripts/shared/util_shared;

#namespace cp_mi_sing_sgen_testing_lab_igc;

// Namespace cp_mi_sing_sgen_testing_lab_igc
// Params 2, eflags: 0x0
// Checksum 0x30974d5c, Offset: 0x958
// Size: 0x3d6
function function_74581061(str_objective, var_74cd64bc) {
    level flag::init("lab_door_ready");
    level util::function_d8eaed3d(2);
    level thread function_652f4022();
    level thread scene::play("cin_sgen_14_01_humanlab_vign_deadbodies");
    level clientfield::set("testing_lab_wires", 1);
    level clientfield::set("w_underwater_state", 0);
    if (var_74cd64bc) {
        sgen::function_bff1a867(str_objective);
        objectives::complete("cp_level_sgen_enter_sgen_no_pointer");
        objectives::complete("cp_level_sgen_investigate_sgen");
        objectives::complete("cp_level_sgen_locate_emf");
        objectives::complete("cp_level_sgen_descend_into_core");
        objectives::set("cp_level_sgen_goto_signal_source");
        level thread objectives::breadcrumb("fallen_soldiers_end_breadcrumb_trig");
        level scene::init("cin_sgen_14_humanlab_3rd_sh005");
        level scene::init("cin_sgen_14_humanlab_3rd_doors");
        load::function_a2995f22();
    }
    level thread function_e763362b();
    function_d9cab9d3();
    level waittill(#"hash_89d9c0f");
    level thread namespace_d40478f6::function_4a262c0b();
    if (isdefined(level.var_a448ad77)) {
        level thread [[ level.var_a448ad77 ]]();
    }
    level.var_280d5f68 = getent("human_lab_door_l", "targetname");
    level.var_280d5f68.v_start_pos = level.var_280d5f68.origin;
    level.var_3c301126 = getent("human_lab_door_r", "targetname");
    level.var_3c301126.v_start_pos = level.var_3c301126.origin;
    level scene::add_scene_func("cin_sgen_14_humanlab_3rd_sh005", &function_b884ec52, "play");
    level scene::add_scene_func("cin_sgen_14_humanlab_3rd_sh200", &function_841ed050, "done");
    level scene::add_scene_func("cin_sgen_14_humanlab_3rd_sh200", &function_5841c784, "players_done");
    level scene::add_scene_func("cin_sgen_14_humanlab_3rd_sh040", &function_7a6f4571, "play");
    level thread scene::play("cin_sgen_14_humanlab_3rd_doors");
    level scene::play("cin_sgen_14_humanlab_3rd_sh005", level.var_2240f121);
    level.var_2240f121 = undefined;
}

// Namespace cp_mi_sing_sgen_testing_lab_igc
// Params 4, eflags: 0x0
// Checksum 0xe3e095a0, Offset: 0xd38
// Size: 0x2f4
function function_bfad6ceb(str_objective, var_74cd64bc, var_e4cd2b8b, player) {
    struct::function_368120a1("cin_sgen_14_humanlab_3rd_doors");
    struct::function_368120a1("cin_sgen_14_humanlab_3rd_sh005");
    struct::function_368120a1("cin_sgen_14_humanlab_3rd_sh010");
    struct::function_368120a1("cin_sgen_14_humanlab_3rd_sh020");
    struct::function_368120a1("cin_sgen_14_humanlab_3rd_sh020");
    struct::function_368120a1("cin_sgen_14_humanlab_3rd_sh020_female");
    struct::function_368120a1("cin_sgen_14_humanlab_3rd_sh030");
    struct::function_368120a1("cin_sgen_14_humanlab_3rd_sh040");
    struct::function_368120a1("cin_sgen_14_humanlab_3rd_sh050");
    struct::function_368120a1("cin_sgen_14_humanlab_3rd_sh060");
    struct::function_368120a1("cin_sgen_14_humanlab_3rd_sh070");
    struct::function_368120a1("cin_sgen_14_humanlab_3rd_sh080");
    struct::function_368120a1("cin_sgen_14_humanlab_3rd_sh090");
    struct::function_368120a1("cin_sgen_14_humanlab_3rd_sh100");
    struct::function_368120a1("cin_sgen_14_humanlab_3rd_sh110");
    struct::function_368120a1("cin_sgen_14_humanlab_3rd_sh120");
    struct::function_368120a1("cin_sgen_14_humanlab_3rd_sh120_female");
    struct::function_368120a1("cin_sgen_14_humanlab_3rd_sh130");
    struct::function_368120a1("cin_sgen_14_humanlab_3rd_sh130_female");
    struct::function_368120a1("cin_sgen_14_humanlab_3rd_sh140");
    struct::function_368120a1("cin_sgen_14_humanlab_3rd_sh150");
    struct::function_368120a1("cin_sgen_14_humanlab_3rd_sh150_female");
    struct::function_368120a1("cin_sgen_14_humanlab_3rd_sh160");
    struct::function_368120a1("cin_sgen_14_humanlab_3rd_sh160_female");
    struct::function_368120a1("cin_sgen_14_humanlab_3rd_sh170");
    struct::function_368120a1("cin_sgen_14_humanlab_3rd_sh170_female");
    struct::function_368120a1("cin_sgen_14_humanlab_3rd_sh180");
    struct::function_368120a1("cin_sgen_14_humanlab_3rd_sh180_female");
    struct::function_368120a1("cin_sgen_14_humanlab_3rd_sh190");
    struct::function_368120a1("cin_sgen_14_humanlab_3rd_sh200");
}

// Namespace cp_mi_sing_sgen_testing_lab_igc
// Params 0, eflags: 0x0
// Checksum 0xe032280e, Offset: 0x1038
// Size: 0x7c
function function_652f4022() {
    videoprime("cp_sgen_env_dniroom");
    level waittill(#"hash_92687102");
    videostart("cp_sgen_env_dniroom", 1);
    level flag::wait_till("dark_battle_hendricks_above");
    videostop("cp_sgen_env_dniroom");
}

// Namespace cp_mi_sing_sgen_testing_lab_igc
// Params 1, eflags: 0x0
// Checksum 0x69bd6fc5, Offset: 0x10c0
// Size: 0x142
function function_b884ec52(a_ents) {
    foreach (var_9544d7c1 in a_ents) {
        if (isplayer(var_9544d7c1)) {
            var_9544d7c1 cybercom::function_f8669cbf(1);
            var_9544d7c1 clientfield::set_to_player("sndCCHacking", 2);
            var_9544d7c1 util::delay(1, "death", &clientfield::increment_to_player, "hack_dni_fx");
            var_9544d7c1 util::delay(2, "death", &clientfield::set_to_player, "sndCCHacking", 0);
        }
    }
}

// Namespace cp_mi_sing_sgen_testing_lab_igc
// Params 1, eflags: 0x0
// Checksum 0x486d902c, Offset: 0x1210
// Size: 0x34
function function_7a6f4571(a_ents) {
    level waittill(#"hash_92687102");
    level.var_2fd26037 cybercom::function_f8669cbf(1);
}

// Namespace cp_mi_sing_sgen_testing_lab_igc
// Params 1, eflags: 0x0
// Checksum 0x2e43e404, Offset: 0x1250
// Size: 0xf4
function function_841ed050(a_ents) {
    var_acb9c8b6 = getnode("hendricks_post_dni_lab", "targetname");
    level.var_2fd26037 setgoal(var_acb9c8b6, 1, 16);
    util::clear_streamer_hint();
    objectives::set("cp_level_sgen_goto_server_room");
    skipto::function_be8adfb8("testing_lab_igc");
    util::function_93831e79("dark_battle");
    level.var_280d5f68.origin = level.var_280d5f68.v_start_pos;
    level.var_3c301126.origin = level.var_3c301126.v_start_pos;
}

// Namespace cp_mi_sing_sgen_testing_lab_igc
// Params 1, eflags: 0x0
// Checksum 0x17b99d4f, Offset: 0x1350
// Size: 0x24
function function_5841c784(a_ents) {
    util::function_93831e79("dark_battle");
}

// Namespace cp_mi_sing_sgen_testing_lab_igc
// Params 0, eflags: 0x0
// Checksum 0xc3e0131d, Offset: 0x1380
// Size: 0x124
function function_d9cab9d3() {
    var_f0e94a11 = getent("trig_testing_lab_door", "targetname");
    var_f0e94a11 triggerenable(0);
    level.var_2fd26037 setgoal(getnode("fallen_soldiers_hendricks_hack_door_node", "targetname"), 1);
    level flag::wait_till("lab_door_ready");
    objectives::complete("cp_waypoint_breadcrumb");
    var_f0e94a11 triggerenable(1);
    objectives::set("cp_level_sgen_hack_door_signal_source");
    util::function_14518e76(var_f0e94a11, %cp_prompt_dni_sgen_hack_door, %CP_MI_SING_SGEN_HACK, &function_474ab5c2);
}

// Namespace cp_mi_sing_sgen_testing_lab_igc
// Params 1, eflags: 0x0
// Checksum 0xf323a5f4, Offset: 0x14b0
// Size: 0x9c
function function_474ab5c2(e_player) {
    level.var_2240f121 = e_player;
    self gameobjects::disable_object();
    level.var_2fd26037 clearforcedgoal();
    level notify(#"hash_89d9c0f");
    objectives::complete("cp_level_sgen_goto_signal_source");
    objectives::complete("cp_level_sgen_hack_door_signal_source");
    self gameobjects::destroy_object(1);
}

// Namespace cp_mi_sing_sgen_testing_lab_igc
// Params 0, eflags: 0x0
// Checksum 0xac887b3e, Offset: 0x1558
// Size: 0x7c
function function_e763362b() {
    trigger::wait_or_timeout(5, "testing_lab_vo_looktrig", "targetname");
    level.var_2fd26037 dialog::say("hend_hack_the_panel_i_go_0");
    level flag::set("lab_door_ready");
    do_nag();
}

// Namespace cp_mi_sing_sgen_testing_lab_igc
// Params 0, eflags: 0x0
// Checksum 0x69221cdf, Offset: 0x15e0
// Size: 0x34
function do_nag() {
    level endon(#"hash_89d9c0f");
    wait 5;
    level.var_2fd26037 dialog::say("hend_wanna_hurry_up_we_n_0");
}

