#using scripts/codescripts/struct;
#using scripts/cp/_dialog;
#using scripts/cp/_load;
#using scripts/cp/_objectives;
#using scripts/cp/_skipto;
#using scripts/cp/_spawn_manager;
#using scripts/cp/_util;
#using scripts/cp/cp_mi_cairo_infection_util;
#using scripts/cp/cp_mi_cairo_infection_village_surreal;
#using scripts/cp/gametypes/_battlechatter;
#using scripts/cp/gametypes/_save;
#using scripts/shared/ai_shared;
#using scripts/shared/array_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/colors_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/hud_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/system_shared;
#using scripts/shared/trigger_shared;
#using scripts/shared/turret_shared;
#using scripts/shared/util_shared;
#using scripts/shared/vehicle_shared;
#using scripts/shared/vehicleriders_shared;

#namespace village;

// Namespace village
// Params 0, eflags: 0x2
// Checksum 0x7b7a41db, Offset: 0x1420
// Size: 0x2a
function autoexec function_2dc19561() {
    system::register("infection_village", &__init__, undefined, undefined);
}

// Namespace village
// Params 0, eflags: 0x0
// Checksum 0x899ae6a5, Offset: 0x1458
// Size: 0x12
function __init__() {
    function_49eb92b9();
}

// Namespace village
// Params 0, eflags: 0x0
// Checksum 0xaa5664f5, Offset: 0x1478
// Size: 0xca
function init_client_field_callback_funcs() {
    clientfield::register("world", "village_mortar_index", 1, 3, "int");
    clientfield::register("world", "village_intro_mortar", 1, 1, "int");
    clientfield::register("world", "init_fold", 1, 1, "int");
    clientfield::register("world", "start_fold", 1, 1, "int");
    clientfield::register("scriptmover", "fold_buildings", 1, 1, "int");
}

// Namespace village
// Params 4, eflags: 0x0
// Checksum 0x77140f56, Offset: 0x1550
// Size: 0x42
function cleanup(str_objective, var_74cd64bc, var_e4cd2b8b, player) {
    level notify(#"end_salm_foy_dialog");
    objectives::complete("cp_level_infection_gather_airlock");
}

// Namespace village
// Params 3, eflags: 0x0
// Checksum 0x75a1b81a, Offset: 0x15a0
// Size: 0x3da
function main(str_objective, var_74cd64bc, var_75294396) {
    if (!isdefined(var_75294396)) {
        var_75294396 = 0;
    }
    if (var_74cd64bc) {
        load::function_73adcefc();
        function_c4110989();
    }
    level thread infection_util::function_c8d7e76("foy_reverse_anim");
    function_a8ccd78c();
    if (var_74cd64bc) {
        level thread scene::init("p7_fxanim_cp_infection_reverse_house_01_bundle");
        level thread scene::init("cin_inf_10_01_foy_aie_reversemortar");
        level thread scene::init("cin_inf_10_02_foy_aie_reversewallexplosion_suppressor");
        level thread scene::init("cin_inf_10_01_foy_vign_intro");
        level util::function_d8eaed3d(7);
        objectives::set("cp_level_infection_follow_sarah");
    }
    level.var_d0d4a835 = 0;
    level.var_4fd72c4a = 0;
    level.var_acfc49b5 = 0;
    spawner::add_spawn_function_group("sp_foy_friendlies", "targetname", &function_6759312c);
    spawner::add_spawn_function_group("sp_foy_friendlies_respawn_1", "targetname", &function_63a38a35);
    spawner::add_spawn_function_group("sp_foy_friendlies_respawn_2", "targetname", &function_63a38a35);
    spawner::add_spawn_function_group("sp_foy_friendlies_respawn_3", "targetname", &function_63a38a35);
    if (isdefined(level.var_27ad69e1)) {
        level thread [[ level.var_27ad69e1 ]]();
    }
    if (!sessionmodeiscampaignzombiesgame()) {
        function_714c5fbc();
        function_e353cef7();
        function_bd51548e();
    }
    infection_util::function_1cdb9014();
    a_blockers = getentarray("foy_gather_point_debris_blocker", "targetname");
    level thread function_901bfe3e(a_blockers);
    level thread function_4c895b57();
    if (var_74cd64bc) {
        load::function_a2995f22();
        level thread function_55081eb6(0);
    } else {
        level thread function_55081eb6(1);
    }
    level thread function_d52b4c08();
    level thread function_9bb4e7ef();
    if (!sessionmodeiscampaignzombiesgame()) {
        level thread function_ed8c7500();
        level thread function_c217937d();
        level thread function_7d93c0c();
    }
    level thread function_5ba8c80b();
    level thread function_b7cb180c();
    level thread function_5b4650e2();
    level thread function_a3cd1770();
    level thread function_aa2056b4();
    level thread function_52900ba5();
    level thread function_631f7f5e();
    level thread function_5eb4b60c();
    level thread function_7fc734e2();
    level thread function_880a13df();
    level thread util::clear_streamer_hint();
}

// Namespace village
// Params 0, eflags: 0x0
// Checksum 0x2635fc17, Offset: 0x1988
// Size: 0x2a
function function_633271eb() {
    level thread infection_util::function_f6d49772("t_salm_having_established_a_1", "salm_having_established_a_1", "end_salm_foy_dialog");
}

// Namespace village
// Params 0, eflags: 0x0
// Checksum 0x36319854, Offset: 0x19c0
// Size: 0xbb
function function_4c895b57() {
    trigger::wait_till("t_allies_disadvantage");
    level.var_d0d4a835 = 1;
    var_7b3a5649 = getaiteamarray("allies");
    foreach (ai in var_7b3a5649) {
        if (isdefined(ai.targetname)) {
            if (ai.targetname == "sp_foy_friendlies_ai") {
                ai.takedamage = 1;
            }
        }
    }
}

// Namespace village
// Params 0, eflags: 0x0
// Checksum 0x62d21594, Offset: 0x1a88
// Size: 0x4a
function function_9bb4e7ef() {
    trigger::wait_till("t_battlechatter_reclaim_foy");
    infection_util::function_3c363cb3("company_move");
    wait 3;
    infection_util::function_3c363cb3("reclaim_foy");
}

// Namespace village
// Params 0, eflags: 0x0
// Checksum 0x17c3b5e, Offset: 0x1ae0
// Size: 0x5e
function function_714c5fbc() {
    level.var_eb740d59 = new class_ce2d510();
    var_cb7ecfda = vehicle::simple_spawn_single("sp_foy_turret_01");
    [[ level.var_eb740d59 ]]->function_66f910ed(var_cb7ecfda, "sp_foy_turret_01_gunner", "t_foy_turret_01_gunner");
}

// Namespace village
// Params 0, eflags: 0x0
// Checksum 0xf6e5a899, Offset: 0x1b48
// Size: 0x56
function function_e353cef7() {
    level.var_117687c2 = new class_ce2d510();
    var_a57c5571 = vehicle::simple_spawn_single("sp_foy_turret_02");
    [[ level.var_117687c2 ]]->function_66f910ed(var_a57c5571, "sp_foy_turret_02_gunner", undefined);
}

// Namespace village
// Params 0, eflags: 0x0
// Checksum 0x2de7e840, Offset: 0x1ba8
// Size: 0x76
function function_bd51548e() {
    level.var_3779022b = new class_ce2d510();
    var_7f79db08 = vehicle::simple_spawn_single("sp_foy_turret_03");
    var_7f79db08 setcandamage(1);
    var_7f79db08.health = 2000;
    [[ level.var_3779022b ]]->function_66f910ed(var_7f79db08, "sp_foy_turret_03_gunner", undefined);
}

// Namespace village
// Params 0, eflags: 0x0
// Checksum 0xc9e126ef, Offset: 0x1c28
// Size: 0x42
function function_ed8c7500() {
    trigger::wait_till("t_foy_turret_01_enable");
    [[ level.var_eb740d59 ]]->function_2919200c();
    wait 2;
    infection_util::function_3c363cb3("mg_middle");
}

// Namespace village
// Params 0, eflags: 0x0
// Checksum 0x7c3e5434, Offset: 0x1c78
// Size: 0xd2
function function_c217937d() {
    trigger::wait_till("t_foy_turret_02_spawn");
    level thread function_713ae2bf("turret_door");
    exploder::exploder("fx_expl_barn_window_open");
    wait 0.5;
    [[ level.var_117687c2 ]]->function_2919200c();
    wait 1;
    infection_util::function_3c363cb3("mg_brick_building");
    level thread function_77321751();
    spawn_manager::enable("sm_turret_barn_door");
    level thread function_713ae2bf("turret_barn_door");
    exploder::exploder("fx_expl_barn_door_open");
}

// Namespace village
// Params 0, eflags: 0x0
// Checksum 0x1d04abf4, Offset: 0x1d58
// Size: 0x22
function function_77321751() {
    level waittill(#"hash_ec7a5edf");
    wait 1;
    infection_util::function_3c363cb3("mg_down");
}

// Namespace village
// Params 0, eflags: 0x0
// Checksum 0x9b149676, Offset: 0x1d88
// Size: 0xa2
function function_7d93c0c() {
    trigger::wait_till("t_foy_turret_03_spawn");
    level thread function_713ae2bf("barn_door");
    wait 0.5;
    [[ level.var_3779022b ]]->function_2919200c();
    exploder::exploder("fx_expl_mg_bullet_impacts_village01");
    wait 1.5;
    exploder::exploder("fx_expl_mg_bullet_impacts_village02");
    wait 1.5;
    exploder::exploder("fx_expl_mg_bullet_impacts_village03");
}

// Namespace village
// Params 0, eflags: 0x0
// Checksum 0x1d8b092c, Offset: 0x1e38
// Size: 0x52
function function_d52b4c08() {
    trigger::wait_till("t_sm_barn_house_1");
    function_713ae2bf("barn_lower_door");
    wait 0.25;
    spawn_manager::enable("sm_barn_house_1");
}

// Namespace village
// Params 2, eflags: 0x0
// Checksum 0x5464ce99, Offset: 0x1e98
// Size: 0xaf
function function_618e1e4e(var_62ebac00, n_wait) {
    self endon(#"death");
    if (isdefined(var_62ebac00)) {
    }
    for (e_target = getnode(var_62ebac00, "targetname"); isdefined(e_target); e_target = undefined) {
        self setgoal(e_target);
        self waittill(#"goal");
        self.goalradius = 64;
        if (isdefined(e_target.target)) {
            wait n_wait;
            e_target = getnode(e_target.target, "targetname");
            continue;
        }
    }
}

// Namespace village
// Params 0, eflags: 0x0
// Checksum 0xa9dfbe18, Offset: 0x1f50
// Size: 0x62
function function_b7cb180c() {
    trigger::wait_till("t_sm_foy_town_waves");
    spawn_manager::enable("sm_foy_town_wave_1");
    spawn_manager::enable("sm_foy_town_wave_2");
    spawn_manager::enable("sm_foy_town_wave_3");
}

// Namespace village
// Params 0, eflags: 0x0
// Checksum 0xa7508081, Offset: 0x1fc0
// Size: 0x142
function function_5ba8c80b() {
    trigger::wait_till("t_retreat_sp_wall_fx_german");
    level thread infection_util::function_642da963("foy_wall_fx_german_01_ai", "foy_goal_volume_2");
    level thread infection_util::function_642da963("foy_wall_fx_german_02_ai", "foy_goal_volume_2");
    level thread infection_util::function_642da963("foy_wall_fx_german_03_ai", "foy_goal_volume_2");
    level thread infection_util::function_642da963("foy_wall_fx_german_04_ai", "foy_goal_volume_2");
    sp_retreat_01 = spawner::simple_spawn_single("sp_retreat_01");
    sp_retreat_01 thread function_618e1e4e("nd_retreat_01", 12);
    sp_retreat_02 = spawner::simple_spawn_single("sp_retreat_02");
    sp_retreat_02 thread function_618e1e4e("nd_retreat_02", 10);
    sp_retreat_03 = spawner::simple_spawn_single("sp_retreat_03");
    sp_retreat_03 thread function_618e1e4e("nd_retreat_03", 8);
}

// Namespace village
// Params 0, eflags: 0x0
// Checksum 0x6f3d434e, Offset: 0x2110
// Size: 0x3a
function function_5b4650e2() {
    trigger::wait_till("t_retreat_sp_foy_post_intro_formation_1_ai");
    level thread infection_util::function_810ccf7("t_sp_foy_post_intro_formation_1_ai", "foy_goal_volume_2");
}

// Namespace village
// Params 0, eflags: 0x0
// Checksum 0xe7f4a6e9, Offset: 0x2158
// Size: 0x5a
function function_a3cd1770() {
    trigger::wait_till("t_retreat_sp_barn_house_1_ai");
    level thread infection_util::function_810ccf7("t_sp_barn_house_1_ai", "t_sp_foy_town_wave_ai");
    level thread infection_util::function_810ccf7("foy_goal_volume_2", "t_sp_foy_town_wave_ai");
}

// Namespace village
// Params 0, eflags: 0x0
// Checksum 0xbe012c16, Offset: 0x21c0
// Size: 0x3a
function function_aa2056b4() {
    trigger::wait_till("t_retreat_sp_foy_guys_right_ai");
    level thread infection_util::function_810ccf7("t_sp_foy_guys_right_ai", "foy_goal_volume_3");
}

// Namespace village
// Params 0, eflags: 0x0
// Checksum 0x26dfbf34, Offset: 0x2208
// Size: 0x3a
function function_52900ba5() {
    trigger::wait_till("t_retreat_sp_foy_town_wave_ai");
    level thread infection_util::function_810ccf7("t_sp_foy_town_wave_ai", "foy_goal_volume_3");
}

// Namespace village
// Params 0, eflags: 0x0
// Checksum 0xe2f91980, Offset: 0x2250
// Size: 0x6a
function function_631f7f5e() {
    trigger::wait_till("t_sm_foy_post_fold");
    infection_util::function_3c363cb3("fences_move");
    flag::wait_till("final_area_cleared");
    battlechatter::function_d9f49fba(0);
    wait 1;
    function_c79f9420();
}

// Namespace village
// Params 0, eflags: 0x0
// Checksum 0x6a79afe8, Offset: 0x22c8
// Size: 0x3a
function function_c4110989() {
    infection_util::function_aa0ddbc3(1);
    spawner::add_global_spawn_function("axis", &infection_util::function_dafed344);
}

// Namespace village
// Params 0, eflags: 0x0
// Checksum 0x3e2515be, Offset: 0x2310
// Size: 0x2f2
function function_49eb92b9() {
    scene::add_scene_func("cin_inf_10_01_foy_vign_walk", &infection_util::function_c32dc5f6, "init");
    scene::add_scene_func("cin_inf_10_01_foy_vign_walk", &infection_util::function_368baff9, "play");
    scene::add_scene_func("cin_inf_10_01_foy_vign_intro", &function_7ee91ee8, "play");
    scene::add_scene_func("cin_inf_10_01_foy_vign_intro", &function_fbf84bda, "play");
    scene::add_scene_func("cin_inf_10_01_foy_vign_intro", &function_f42e77de, "done");
    scene::add_scene_func("cin_inf_10_01_foy_vign_intro", &infection_util::function_c32dc5f6, "done");
    scene::add_scene_func("cin_inf_10_01_foy_vign_intro", &infection_util::function_23e59afd, "play");
    scene::add_scene_func("cin_inf_10_01_foy_vign_intro", &infection_util::function_e2eba6da, "done");
    infection_util::function_a3f21cef("p7_fxanim_cp_infection_reverse_wall_01_bundle", "fxanim_reverse_wall_explosion_trigger");
    scene::add_scene_func("p7_fxanim_cp_infection_reverse_wall_01_bundle", &function_26e55eb5, "play");
    scene::add_scene_func("cin_inf_06_03_bastogne_aie_reverse_soldier01hipshot_suppressor", &infection_util::function_2a5e3b2a, "play");
    scene::add_scene_func("cin_inf_06_03_bastogne_aie_reverse_soldier02headshot_suppressor", &infection_util::function_2a5e3b2a, "play");
    scene::add_scene_func("cin_inf_10_01_foy_aie_reversemortar_react", &infection_util::function_2a5e3b2a, "play");
    scene::add_scene_func("cin_inf_10_02_foy_aie_reversewallexplosion_suppressor", &infection_util::function_2a5e3b2a, "play");
    scene::add_scene_func("p7_fxanim_cp_infection_fold_bundle", &function_8b16f470, "init");
    scene::add_scene_func("p7_fxanim_cp_infection_fold_bundle", &function_6ac10d8c, "play");
}

// Namespace village
// Params 0, eflags: 0x0
// Checksum 0x6520c771, Offset: 0x2610
// Size: 0x12a
function function_6759312c() {
    self endon(#"death");
    self hide();
    self.takedamage = 0;
    self ai::set_ignoreall(1);
    self.goalradius = 256;
    self.script_accuracy = 0.25;
    self.overrideactordamage = &function_cc841ab;
    self thread infection_util::function_6ff4aa0e(0);
    util::wait_network_frame();
    self show();
    var_cec80dd3 = randomint(2);
    var_e402f51e = undefined;
    switch (var_cec80dd3) {
    case 0:
        var_e402f51e = "cin_inf_10_02_foy_vign_teleport_spawn";
        break;
    case 1:
        var_e402f51e = "cin_inf_10_02_foy_vign_teleport_spawn02";
        break;
    case 2:
        var_e402f51e = "cin_inf_10_02_foy_vign_teleport_spawn03";
        break;
    }
    self scene::play(var_e402f51e, self);
    self ai::set_ignoreall(0);
}

// Namespace village
// Params 0, eflags: 0x0
// Checksum 0x5e2bd356, Offset: 0x2748
// Size: 0x3a
function function_63a38a35() {
    self endon(#"death");
    self.goalradius = 256;
    self.script_accuracy = 0.25;
    self.overrideactordamage = &function_cc841ab;
}

// Namespace village
// Params 12, eflags: 0x0
// Checksum 0xe642d12b, Offset: 0x2790
// Size: 0x83
function function_cc841ab(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, modelindex, psoffsettime, bonename) {
    if (isdefined(eattacker) && isplayer(eattacker)) {
        idamage = 0;
    }
    return idamage;
}

// Namespace village
// Params 1, eflags: 0x0
// Checksum 0x3dbcf46e, Offset: 0x2820
// Size: 0x82
function function_26e55eb5(a_ents) {
    level clientfield::set("village_mortar_index", 1);
    level thread scene::play("cin_inf_10_02_foy_aie_reversewallexplosion_suppressor");
    wait 1;
    spawn_manager::enable("sm_foy_friendlies");
    spawn_manager::wait_till_complete("sm_foy_friendlies");
    spawn_manager::kill("sm_foy_friendlies");
}

// Namespace village
// Params 1, eflags: 0x0
// Checksum 0x880b7202, Offset: 0x28b0
// Size: 0x72
function function_f42e77de(a_ents) {
    level thread infection_util::function_efa09886(a_ents);
    infection_util::function_3ea445de();
    util::wait_network_frame();
    infection_util::function_1cdb9014();
    array::thread_all(level.players, &infection_util::function_e905c73c);
}

// Namespace village
// Params 0, eflags: 0x0
// Checksum 0x5291fe4a, Offset: 0x2930
// Size: 0x41a
function function_a8ccd78c() {
    level.var_1808e6f7 = getentarray("reverse_barn_01_corner", "targetname");
    infection_util::function_9d8bcc37(level.var_1808e6f7);
    level.var_e9ce649f = getentarray("m_reverse_fence_01", "targetname");
    infection_util::function_9d8bcc37(level.var_e9ce649f);
    level.var_77c6f564 = getentarray("m_reverse_fence_02", "targetname");
    infection_util::function_9d8bcc37(level.var_77c6f564);
    level.var_a8fa691f = getentarray("m_reverse_chciken_coop_01", "targetname");
    infection_util::function_9d8bcc37(level.var_a8fa691f);
    level.var_36f2f9e4 = getentarray("m_reverse_chciken_coop_02", "targetname");
    infection_util::function_9d8bcc37(level.var_36f2f9e4);
    level.var_e1c85461 = getentarray("m_reverse_house_01", "targetname");
    infection_util::function_9d8bcc37(level.var_e1c85461);
    scene::add_scene_func("p7_fxanim_cp_infection_reverse_barn_01_bundle", &function_47317809, "done");
    scene::add_scene_func("p7_fxanim_cp_infection_reverse_fence_01_bundle", &function_1e97d97d, "done");
    scene::add_scene_func("p7_fxanim_cp_infection_reverse_fence_02_bundle", &function_449a53e6, "done");
    scene::add_scene_func("p7_fxanim_cp_infection_reverse_chciken_coop_01_bundle", &function_41ec98c5, "done");
    scene::add_scene_func("p7_fxanim_cp_infection_reverse_chciken_coop_02_bundle", &function_67ef132e, "done");
    if (!sessionmodeiscampaignzombiesgame()) {
        scene::add_scene_func("p7_fxanim_cp_infection_reverse_house_01_bundle", &function_d4580490, "play");
        scene::add_scene_func("p7_fxanim_cp_infection_reverse_house_01_bundle", &function_e541046b, "done");
    }
    infection_util::function_1926d38d("p7_fxanim_cp_infection_reverse_barn_01_bundle", "s_infection_reverse_barn_01_bundle", "t_infection_reverse_barn_01_bundle_inner", "t_infection_reverse_barn_01_bundle_outter");
    infection_util::function_1926d38d("p7_fxanim_cp_infection_reverse_fence_01_bundle", "s_infection_reverse_fence_01_bundle", "t_infection_reverse_fence_01_bundle_inner", "t_infection_reverse_fence_01_bundle_outter");
    infection_util::function_1926d38d("p7_fxanim_cp_infection_reverse_fence_02_bundle", "s_infection_reverse_fence_02_bundle", "t_infection_reverse_fence_02_bundle_inner", "t_infection_reverse_fence_02_bundle_outter");
    infection_util::function_1926d38d("p7_fxanim_cp_infection_reverse_chciken_coop_01_bundle", "s_infection_reverse_chciken_coop_01_bundle", "t_infection_reverse_chciken_coop_01_bundle_inner", "t_infection_reverse_chciken_coop_01_bundle_outter");
    infection_util::function_1926d38d("p7_fxanim_cp_infection_reverse_chciken_coop_02_bundle", "s_infection_reverse_chciken_coop_02_bundle", "t_infection_reverse_chciken_coop_02_bundle_inner", "t_infection_reverse_chciken_coop_02_bundle_outter");
    infection_util::function_1926d38d("p7_fxanim_cp_infection_reverse_telephone_pole_bundle", "s_infection_reverse_telephone_pole_bundle", "t_infection_reverse_telephone_pole_bundle_inner", "t_infection_reverse_telephone_pole_bundle_outter");
    level scene::init("p7_fxanim_cp_infection_reverse_transition_wall_bundle");
}

// Namespace village
// Params 1, eflags: 0x0
// Checksum 0xff16125c, Offset: 0x2d58
// Size: 0x22
function function_47317809(a_ents) {
    infection_util::function_bdea6c61(level.var_1808e6f7);
}

// Namespace village
// Params 1, eflags: 0x0
// Checksum 0x974527dd, Offset: 0x2d88
// Size: 0x22
function function_1e97d97d(a_ents) {
    infection_util::function_bdea6c61(level.var_e9ce649f);
}

// Namespace village
// Params 1, eflags: 0x0
// Checksum 0xcbe6efc0, Offset: 0x2db8
// Size: 0x22
function function_449a53e6(a_ents) {
    infection_util::function_bdea6c61(level.var_77c6f564);
}

// Namespace village
// Params 1, eflags: 0x0
// Checksum 0x99629437, Offset: 0x2de8
// Size: 0x22
function function_41ec98c5(a_ents) {
    infection_util::function_bdea6c61(level.var_a8fa691f);
}

// Namespace village
// Params 1, eflags: 0x0
// Checksum 0xe3be6dbd, Offset: 0x2e18
// Size: 0x22
function function_67ef132e(a_ents) {
    infection_util::function_bdea6c61(level.var_36f2f9e4);
}

// Namespace village
// Params 1, eflags: 0x0
// Checksum 0x6785c6b1, Offset: 0x2e48
// Size: 0x8a
function function_d4580490(a_ents) {
    foreach (player in level.activeplayers) {
        player thread function_c7c1f146();
    }
    level waittill(#"hash_471dbb27");
    level thread scene::play("cin_inf_10_01_foy_aie_reversemortar");
}

// Namespace village
// Params 1, eflags: 0x0
// Checksum 0xd16ef9c0, Offset: 0x2ee0
// Size: 0x2b
function function_e541046b(a_ents) {
    infection_util::function_bdea6c61(level.var_e1c85461);
    level notify(#"hash_be705059");
}

// Namespace village
// Params 0, eflags: 0x0
// Checksum 0x24bd0a5d, Offset: 0x2f18
// Size: 0x72
function function_1bf08d19() {
    function_c4110989();
    level thread scene::init("p7_fxanim_cp_infection_reverse_house_01_bundle");
    level thread scene::init("cin_inf_10_01_foy_aie_reversemortar");
    level thread scene::init("cin_inf_10_02_foy_aie_reversewallexplosion_suppressor");
    level thread scene::init("cin_inf_10_01_foy_vign_intro");
}

// Namespace village
// Params 1, eflags: 0x0
// Checksum 0x84fbc8f6, Offset: 0x2f98
// Size: 0x132
function function_55081eb6(var_ea6e4b0d) {
    if (var_ea6e4b0d) {
        level waittill(#"hash_6aa6dc33");
    } else {
        level scene::function_9e5b8cdb("p7_fxanim_cp_infection_reverse_house_01_bundle");
        level scene::play("cin_inf_10_01_foy_vign_intro");
    }
    scene::function_f69c7a83();
    level flag::wait_till("sarah_anchor_post_scene_done");
    level thread infection_util::function_3fe1f72("t_sarah_foy_objective_", 0, &function_3077f3dc);
    level.players[0] thread dialog::say("hall_this_is_the_path_i_0", 2);
    level clientfield::set("village_intro_mortar", 1);
    exploder::exploder("light_foy_introroom");
    level notify(#"hash_5b12bc4");
    level thread function_2af73f0e();
    level thread function_179f2a9c();
    level scene::init("p7_fxanim_cp_infection_fold_bundle");
}

// Namespace village
// Params 1, eflags: 0x0
// Checksum 0x3bfbc7fa, Offset: 0x30d8
// Size: 0x4a
function function_8b16f470(a_ents) {
    level clientfield::set("init_fold", 1);
    a_ents["fold_skinned"] clientfield::set("fold_buildings", 1);
}

// Namespace village
// Params 1, eflags: 0x0
// Checksum 0xe9b53b49, Offset: 0x3130
// Size: 0x22
function function_6ac10d8c(a_ents) {
    level clientfield::set("start_fold", 1);
}

// Namespace village
// Params 1, eflags: 0x0
// Checksum 0x954e66d9, Offset: 0x3160
// Size: 0xd2
function function_7ee91ee8(a_ents) {
    if (!scene::function_b1f75ee9()) {
        foreach (player in level.activeplayers) {
            player playrumbleonentity("infection2_tank_crash_rumble");
            player shellshock("default", 3.5);
        }
    }
    level waittill(#"hash_9459f59");
    level thread function_f632b4ee();
    level scene::play("p7_fxanim_cp_infection_reverse_house_01_bundle");
}

// Namespace village
// Params 0, eflags: 0x0
// Checksum 0x8a33f70a, Offset: 0x3240
// Size: 0x5a
function function_179f2a9c() {
    self endon(#"hash_c2ceb0dd");
    trigger::wait_till("t_alert_german");
    if (level.var_4fd72c4a == 0) {
        var_4fd72c4a = 1;
        level notify(#"hash_c6b9fd97");
        function_4fd72c4a();
    }
}

// Namespace village
// Params 0, eflags: 0x0
// Checksum 0xa383b301, Offset: 0x32a8
// Size: 0x52
function function_ac605917() {
    self endon(#"disconnect");
    while (!self attackbuttonpressed() && !self throwbuttonpressed() && !self fragbuttonpressed()) {
        wait 0.05;
    }
    wait 0.2;
}

// Namespace village
// Params 0, eflags: 0x0
// Checksum 0x3b9bc964, Offset: 0x3308
// Size: 0x23
function function_8eb94bbb() {
    self endon(#"disconnect");
    self function_ac605917();
    level notify(#"hash_4fd72c4a");
}

// Namespace village
// Params 0, eflags: 0x0
// Checksum 0xa8d6e962, Offset: 0x3338
// Size: 0x72
function function_2af73f0e() {
    self endon(#"hash_c6b9fd97");
    array::spread_all(level.players, &function_8eb94bbb);
    level waittill(#"hash_4fd72c4a");
    if (level.var_4fd72c4a == 0) {
        var_4fd72c4a = 1;
        level notify(#"hash_c2ceb0dd");
        function_4fd72c4a();
    }
}

// Namespace village
// Params 0, eflags: 0x0
// Checksum 0xdd4cb9ee, Offset: 0x33b8
// Size: 0xca
function function_4fd72c4a() {
    var_54ff35a3 = getent("foy_intro_german_01_ai", "targetname");
    var_e2f7c668 = getent("foy_intro_german_02_ai", "targetname");
    var_8fa40d1 = getent("foy_intro_german_03_ai", "targetname");
    var_965b80d3 = array(var_54ff35a3, var_e2f7c668, var_8fa40d1);
    level scene::stop("cin_inf_10_01_foy_aie_reversemortar");
    level thread scene::play("cin_inf_10_01_foy_aie_reversemortar_react", var_965b80d3);
}

// Namespace village
// Params 0, eflags: 0x0
// Checksum 0x252488e9, Offset: 0x3490
// Size: 0x42
function function_3077f3dc() {
    self scene::play("cin_inf_10_01_foy_vign_walk", self);
    self thread scene::init("cin_inf_11_02_fold_1st_airlock_entrance", self);
    function_8e0f756c();
}

// Namespace village
// Params 0, eflags: 0x0
// Checksum 0xc83e272f, Offset: 0x34e0
// Size: 0x82
function function_f632b4ee() {
    playsoundatposition("evt_infection_record_reverse_event", (-66734, -9538, 491));
    playbacktime = soundgetplaybacktime("evt_infection_record_reverse_event");
    playbacktime *= 0.001;
    playbacktime -= 0.25;
    wait playbacktime - 7;
    level util::clientnotify("sndREC");
}

// Namespace village
// Params 0, eflags: 0x0
// Checksum 0xe26af131, Offset: 0x3570
// Size: 0x52
function function_5eb4b60c() {
    trigger::wait_till("fold_start");
    playsoundatposition("evt_world_fold", (-67613, -4626, 755));
    fold_start();
}

// Namespace village
// Params 0, eflags: 0x0
// Checksum 0x4a8ac65f, Offset: 0x35d0
// Size: 0x3d
function function_aa5ecc7() {
    self endon(#"death");
    while (true) {
        /#
            debugstar(self.origin, 2, (1, 0, 0));
        #/
        wait 0.1;
    }
}

// Namespace village
// Params 1, eflags: 0x0
// Checksum 0xd49cd824, Offset: 0x3618
// Size: 0x8a
function function_eceb8030(var_b196132a) {
    var_1308049f = struct::get(var_b196132a, "targetname");
    v_offset = (0, 0, -500);
    t_radius = infection_util::function_5ec7eb7d(var_1308049f.origin + v_offset, -128, 1024);
    t_radius waittill(#"trigger");
    t_radius delete();
}

// Namespace village
// Params 0, eflags: 0x0
// Checksum 0xb21ec2f7, Offset: 0x36b0
// Size: 0x1c1
function function_215ac586() {
    spawner::remove_global_spawn_function("axis", &infection_util::function_dafed344);
    colors::kill_color_replacements();
    var_f7c28862 = getaiteamarray("allies");
    for (i = 0; i < var_f7c28862.size; i++) {
        if (isdefined(var_f7c28862[i].targetname)) {
            if (!issubstr(var_f7c28862[i].targetname, "sarah")) {
                var_f7c28862[i] dodamage(var_f7c28862[i].health + 100, var_f7c28862[i].origin);
                wait 0.1;
            }
            continue;
        }
        var_f7c28862[i] dodamage(var_f7c28862[i].health + 100, var_f7c28862[i].origin);
        wait 0.1;
    }
    var_dc4d1688 = getaiteamarray("axis");
    for (i = 0; i < var_dc4d1688.size; i++) {
        if (isalive(var_dc4d1688[i])) {
            if (isdefined(var_dc4d1688[i].script_objective)) {
                if (var_dc4d1688[i].script_objective == "village") {
                    var_dc4d1688[i] dodamage(var_dc4d1688[i].health + 100, var_dc4d1688[i].origin);
                }
            }
        }
        wait 0.1;
    }
}

// Namespace village
// Params 0, eflags: 0x0
// Checksum 0x2ad7e5a4, Offset: 0x3880
// Size: 0x1c2
function function_8e0f756c() {
    function_c79f9420();
    trigger::wait_till("t_foy_house_regroup", "targetname");
    level thread util::screen_fade_out(1, "white", "foy_white");
    util::wait_network_frame();
    level thread function_215ac586();
    infection_util::function_3ea445de();
    infection_util::function_aa0ddbc3(0);
    a_blockers = getentarray("foy_gather_point_debris_blocker", "targetname");
    level thread function_6d98603d(a_blockers);
    level thread scene::play("p7_fxanim_cp_infection_reverse_transition_wall_bundle");
    array::thread_all(level.players, &infection_util::function_9f10c537);
    if (isdefined(level.var_c4dba52c)) {
        [[ level.var_c4dba52c ]]();
    }
    self thread scene::play("cin_inf_11_02_fold_1st_airlock_entrance", self);
    level thread namespace_4e2074f4::function_a1dc825e();
    var_7d116593 = struct::get("s_village_inception_lighting_hint", "targetname");
    infection_util::function_7aca917c(var_7d116593.origin);
    level thread util::function_d8eaed3d(11);
    wait 1.5;
    level thread skipto::function_be8adfb8("village");
}

// Namespace village
// Params 0, eflags: 0x0
// Checksum 0x13b64cfa, Offset: 0x3a50
// Size: 0x62
function function_c79f9420() {
    if (!isdefined(level.var_acfc49b5) || !level.var_acfc49b5) {
        level.var_acfc49b5 = 1;
        var_b20e84b = struct::get("s_foy_gather_point_blocker", "targetname");
        objectives::set("cp_level_infection_gather_airlock", var_b20e84b);
    }
}

// Namespace village
// Params 1, eflags: 0x0
// Checksum 0xcc0ba799, Offset: 0x3ac0
// Size: 0x73
function function_901bfe3e(a_blockers) {
    foreach (blocker in a_blockers) {
        blocker hide();
        blocker notsolid();
    }
}

// Namespace village
// Params 1, eflags: 0x0
// Checksum 0x1661b660, Offset: 0x3b40
// Size: 0x73
function function_6d98603d(a_blockers) {
    foreach (blocker in a_blockers) {
        blocker show();
        blocker solid();
    }
}

// Namespace village
// Params 0, eflags: 0x0
// Checksum 0xa05db1d5, Offset: 0x3bc0
// Size: 0x92
function function_7fc734e2() {
    trigger::wait_till("t_village_mortar_2");
    clientfield::set("village_mortar_index", 2);
    trigger::wait_till("t_village_mortar_3");
    clientfield::set("village_mortar_index", 3);
    trigger::wait_till("t_village_mortar_4");
    clientfield::set("village_mortar_index", 0);
}

// Namespace village
// Params 2, eflags: 0x0
// Checksum 0xb07fb6af, Offset: 0x3c60
// Size: 0x4b
function function_87c01d16(var_524f5a91, n_wait) {
    self endon(#"death");
    for (i = 0; i < var_524f5a91; i++) {
        self playrumbleonentity("cp_infection_fold_start");
        wait n_wait;
    }
}

// Namespace village
// Params 0, eflags: 0x0
// Checksum 0xaa1eee7c, Offset: 0x3cb8
// Size: 0x3d
function function_c7c1f146() {
    self endon(#"death");
    level endon(#"hash_be705059");
    while (true) {
        self playrumbleonentity("cp_infection_fold_house");
        wait 0.5;
    }
}

// Namespace village
// Params 0, eflags: 0x0
// Checksum 0x223ee3a6, Offset: 0x3d00
// Size: 0x102
function fold_start() {
    level thread scene::play("p7_fxanim_cp_infection_fold_bundle");
    var_55f89057 = getent("fold_earthquake_origin", "targetname");
    assert(isdefined(var_55f89057), "<dev string:x28>");
    foreach (player in level.activeplayers) {
        player thread function_87c01d16(3, 0.5);
    }
    wait 3;
    level thread function_ab0f0ce9(57, var_55f89057.origin);
    level thread infection_util::function_7ad4dc15(var_55f89057, 3500, 57);
}

// Namespace village
// Params 2, eflags: 0x0
// Checksum 0x6fdf69d1, Offset: 0x3e10
// Size: 0x121
function function_ab0f0ce9(n_duration, e_origin) {
    earthquake(0.1, n_duration, e_origin, 10000);
    var_3a881315 = 6;
    var_ae578142 = int(n_duration / var_3a881315) - 1;
    var_1fde3d88 = 1.4;
    var_3ad36936 = 1.6;
    var_5aa5cb2c = 0.25;
    var_45872392 = 0.28;
    for (i = 0; i <= var_ae578142; i++) {
        wait randomfloatrange(var_3a881315 - 1, var_3a881315);
        var_163d97e9 = randomfloatrange(var_1fde3d88, var_3ad36936);
        var_a77dfe85 = randomfloatrange(var_5aa5cb2c, var_45872392);
        earthquake(var_a77dfe85, var_163d97e9, e_origin, 10000);
    }
}

// Namespace village
// Params 1, eflags: 0x0
// Checksum 0xad6aa6cf, Offset: 0x3f40
// Size: 0x1fe
function function_713ae2bf(str_door_name) {
    a_doors = getentarray(str_door_name, "targetname");
    assert(a_doors.size, "<dev string:x4b>");
    var_5c953c1c = [];
    foreach (m_door in a_doors) {
        assert(isdefined(m_door.script_int), "<dev string:x86>" + m_door.origin + "<dev string:xac>");
        assert(isdefined(m_door.target), "<dev string:x86>" + m_door.origin + "<dev string:xf7>");
        s_rotate = struct::get(m_door.target, "targetname");
        var_be1f149f = spawn("script_origin", s_rotate.origin);
        m_door linkto(var_be1f149f);
        var_be1f149f rotateyaw(m_door.script_int, 0.75, 0.2, 0);
        if (!isdefined(var_5c953c1c)) {
            var_5c953c1c = [];
        } else if (!isarray(var_5c953c1c)) {
            var_5c953c1c = array(var_5c953c1c);
        }
        var_5c953c1c[var_5c953c1c.size] = var_be1f149f;
    }
    wait 0.75;
}

// Namespace village
// Params 1, eflags: 0x0
// Checksum 0xdb1dcfec, Offset: 0x4148
// Size: 0x54
function function_fbf84bda(a_ents) {
    var_dc5e890e = a_ents["sarah"];
    if (isdefined(var_dc5e890e)) {
        var_dc5e890e setteam("allies");
    } else {
        var_dc5e890e = level.players[0];
    }
    level waittill(#"hash_925bfe17");
}

// Namespace village
// Params 0, eflags: 0x0
// Checksum 0xed17f7ac, Offset: 0x41a8
// Size: 0x5a
function function_880a13df() {
    level waittill(#"hash_5b12bc4");
    util::wait_network_frame();
    savegame::checkpoint_save();
    trigger::wait_till("foy_post_fold_spawn_trigger", "targetname");
    savegame::checkpoint_save();
}

