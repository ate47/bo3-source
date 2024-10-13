#using scripts/cp/cp_mi_sing_vengeance_sound;
#using scripts/cp/cp_mi_sing_vengeance_temple;
#using scripts/cp/cp_mi_sing_vengeance_garage;
#using scripts/cp/cp_mi_sing_vengeance_util;
#using scripts/cp/gametypes/_battlechatter;
#using scripts/shared/stealth_status;
#using scripts/shared/stealth;
#using scripts/cp/_load;
#using scripts/cp/_debug;
#using scripts/cp/_dialog;
#using scripts/cp/_skipto;
#using scripts/cp/_objectives;
#using scripts/cp/_util;
#using scripts/cp/_spawn_manager;
#using scripts/shared/exploder_shared;
#using scripts/shared/gameobjects_shared;
#using scripts/shared/animation_shared;
#using scripts/shared/colors_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/util_shared;
#using scripts/shared/trigger_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/system_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/array_shared;
#using scripts/shared/ai_shared;
#using scripts/codescripts/struct;

#namespace namespace_1e5c6f29;

// Namespace namespace_1e5c6f29
// Params 2, eflags: 0x0
// Checksum 0x641c7a7a, Offset: 0xb08
// Size: 0x242
function function_bfca9cc4(str_objective, var_74cd64bc) {
    if (var_74cd64bc) {
        load::function_73adcefc();
        namespace_63b4601c::function_b87f9c13(str_objective, var_74cd64bc);
        level thread namespace_9fd035::function_e18f629a();
        callback::on_spawned(&namespace_63b4601c::give_hero_weapon);
        namespace_63b4601c::function_66773296("hendricks", str_objective);
        objectives::set("cp_level_vengeance_rescue_kane");
        objectives::set("cp_level_vengeance_go_to_safehouse");
        level thread namespace_63b4601c::function_cc6f3598();
        level thread namespace_63b4601c::function_936cf9d0();
        level.var_2fd26037 setgoal(level.var_2fd26037.origin, 1);
        var_70f21d83 = struct::get("tag_align_dogleg_2", "targetname");
        var_70f21d83 thread scene::play("cin_ven_05_65_deadcivilians_vign");
        level thread objectives::breadcrumb("dogleg_2_upstairs");
        load::function_a2995f22();
        level thread namespace_628b256b::function_29e96a35();
        trigger::use("temple_video");
        level flag::set("dogleg_2_begin");
    }
    namespace_63b4601c::function_4e8207e9("dogleg_2");
    level.var_2fd26037.goalradius = 12;
    level.var_2fd26037 battlechatter::function_d9f49fba(0);
    level.var_2fd26037 stealth::init();
    level.var_2fd26037 ai::set_behavior_attribute("cqb", 1);
    level.var_2fd26037 colors::disable();
    function_f20cc258(str_objective, var_74cd64bc);
}

// Namespace namespace_1e5c6f29
// Params 4, eflags: 0x0
// Checksum 0x55a8cf3d, Offset: 0xd58
// Size: 0x48a
function function_48a3cbba(str_objective, var_74cd64bc, var_e4cd2b8b, player) {
    array::run_all(getcorpsearray(), &delete);
    var_70f21d83 = struct::get("tag_align_dogleg_2", "targetname");
    var_70f21d83 thread scene::stop("cin_ven_05_65_deadcivilians_vign");
    level struct::function_368120a1("scene", "cin_ven_05_60_officedoor_1st");
    level struct::function_368120a1("scene", "cin_ven_05_60_officedoor_1st_shared");
    level struct::function_368120a1("scene", "cin_ven_05_65_deadcivilians_vign");
    level struct::function_368120a1("scene", "cin_ven_05_70_dogleg2_takedown_vign");
    level struct::function_368120a1("scene", "cin_ven_05_80_office_convo_vign");
    level struct::function_368120a1("scene", "cin_ven_05_23_slicendice_vign");
    level struct::function_368120a1("scene", "cin_ven_05_23_slicendice_civdeath_vign");
    level struct::function_368120a1("scene", "cin_ven_05_24_execution_lineup_vign");
    level struct::function_368120a1("scene", "cin_ven_05_24_execution_lineup_civdeath_vign");
    level struct::function_368120a1("scene", "cin_ven_05_26_beatdown_vign");
    level struct::function_368120a1("scene", "cin_ven_05_26_beatdown_civdeath_vign");
    level struct::function_368120a1("scene", "cin_ven_04_10_cafedoor_3rd_sh090");
    level struct::function_368120a1("scene", "cin_ven_04_10_cafedoor_1st_sh100");
    level struct::function_368120a1("scene", "cin_ven_05_21_rocksmash_vign");
    level struct::function_368120a1("scene", "cin_ven_05_21_rocksmash_enemyreact_vign");
    level struct::function_368120a1("scene", "cin_ven_05_21_rocksmash_civdeath_vign");
    level struct::function_368120a1("scene", "cin_ven_05_22_drowncivilian_vign");
    level struct::function_368120a1("scene", "cin_ven_05_22_drowncivilian_enemyreact_vign");
    level struct::function_368120a1("scene", "cin_ven_05_22_drowncivilian_civdeath_vign");
    level struct::function_368120a1("scene", "cin_ven_05_27_ammorestock_vign");
    level struct::function_368120a1("scene", "cin_ven_05_27_ammorestock_enemyreact_vign");
    level struct::function_368120a1("scene", "cin_ven_05_28_grassstomp_vign");
    level struct::function_368120a1("scene", "cin_ven_05_28_grassstomp_civdeath_vign");
    level struct::function_368120a1("scene", "cin_ven_05_29_rail_beatdown_civdeath_vign");
    level struct::function_368120a1("scene", "cin_ven_05_29_rail_beatdown_vign");
    level struct::function_368120a1("scene", "cin_ven_05_29_rail_beatdown_enemyreact_vign");
    level struct::function_368120a1("scene", "cin_ven_05_32_wall_beatdown_civdeath_vign");
    level struct::function_368120a1("scene", "cin_ven_05_32_wall_beatdown_vign");
    level struct::function_368120a1("scene", "cin_ven_05_32_wall_beatdown_enemyreact_vign");
    level struct::function_368120a1("scene", "cin_ven_05_20_pond_floaters_vign");
    level struct::function_368120a1("scene", "cin_ven_gen_grenade_throw_a");
    namespace_63b4601c::function_4e8207e9("dogleg_2", 0);
}

// Namespace namespace_1e5c6f29
// Params 2, eflags: 0x0
// Checksum 0x52d541b3, Offset: 0x11f0
// Size: 0x1ea
function function_f20cc258(str_objective, var_74cd64bc) {
    objectives::show("cp_level_vengeance_go_to_safehouse");
    level thread function_b4520466();
    level thread function_9d26d0d6();
    namespace_63b4601c::function_e00864bd("office_umbra_gate", 1, "office_gate");
    var_70f21d83 = struct::get("tag_align_dogleg_2", "targetname");
    trigger::wait_till("dogleg_2_upstairs", "targetname");
    if (!level flag::get("temple_stealth_broken") && !var_74cd64bc) {
        var_70f21d83 scene::play("cin_ven_05_70_dogleg2_takedown_vign");
    } else {
        var_70f21d83 thread scene::play("cin_ven_05_80_office_convo_vign");
    }
    level thread util::function_d8eaed3d(4);
    namespace_22334037::function_e46237c7();
    var_70f21d83 = struct::get("garage_igc_script_node", "targetname");
    var_70f21d83 thread scene::init("cin_ven_06_15_parkingstructure_deadbodies");
    var_70f21d83 scene::init("cin_ven_06_10_parkingstructure_1st_shot01");
    level.var_2fd26037 waittill(#"hash_568ee845");
    level thread function_8aac7e91();
    trigger::wait_till("dogleg_2_near_end", "targetname");
    level flag::set("dogleg_2_at_end");
    level waittill(#"hash_42cabc57");
    skipto::function_be8adfb8("dogleg_2");
}

// Namespace namespace_1e5c6f29
// Params 0, eflags: 0x0
// Checksum 0xd27b0ae2, Offset: 0x13e8
// Size: 0xca
function function_9d26d0d6() {
    level waittill(#"hash_e910cb50");
    level thread namespace_9fd035::function_e6a33cb1();
    level namespace_63b4601c::function_ee75acde("kane_the_safe_house_has_b_0");
    level waittill(#"hash_5b5c6225");
    level namespace_63b4601c::function_ee75acde("kane_i_m_falling_back_to_0");
    level waittill(#"hash_58c2cd5a");
    level namespace_63b4601c::function_ee75acde("kane_taylor_did_he_cont_0");
    level waittill(#"hash_32f1242d");
    playsoundatposition("evt_sh_breach", (0, 0, 0));
    level namespace_63b4601c::function_ee75acde("kane_static_1");
    level waittill(#"hash_e8162863");
    level dialog::function_13b3b16a("plyr_no_this_is_someth_0");
}

// Namespace namespace_1e5c6f29
// Params 0, eflags: 0x0
// Checksum 0xd40e1940, Offset: 0x14c0
// Size: 0x2a
function function_8aac7e91() {
    level endon(#"hash_42cabc57");
    wait 25;
    level.var_2fd26037 namespace_63b4601c::function_5fbec645("hend_check_that_balcony_1");
}

// Namespace namespace_1e5c6f29
// Params 0, eflags: 0x0
// Checksum 0x51005b96, Offset: 0x14f8
// Size: 0x102
function function_b4520466() {
    var_c72671 = getent("dogleg_2_door_trigger", "targetname");
    var_c72671 triggerenable(0);
    level flag::wait_till("dogleg_2_at_end");
    var_c72671 triggerenable(1);
    objectives::hide("cp_level_vengeance_go_to_safehouse");
    var_ca0e9b65 = util::function_14518e76(var_c72671, %cp_prompt_enter_ven_door, %CP_MI_SING_VENGEANCE_HINT_OPEN, &function_f476518d);
    objectives::set("cp_level_vengeance_open_dogleg_2_exit_menu");
    level waittill(#"hash_42cabc57");
    var_ca0e9b65 gameobjects::disable_object();
    objectives::hide("cp_level_vengeance_open_dogleg_2_exit_menu");
}

// Namespace namespace_1e5c6f29
// Params 1, eflags: 0x0
// Checksum 0x7339e818, Offset: 0x1608
// Size: 0x1e
function function_f476518d(e_player) {
    level notify(#"hash_42cabc57");
    level.var_e82cf2ee = e_player;
}

