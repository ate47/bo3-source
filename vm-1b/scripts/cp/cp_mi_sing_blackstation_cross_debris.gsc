#using scripts/codescripts/struct;
#using scripts/cp/_dialog;
#using scripts/cp/_load;
#using scripts/cp/_objectives;
#using scripts/cp/_oed;
#using scripts/cp/_skipto;
#using scripts/cp/_util;
#using scripts/cp/cp_mi_sing_blackstation_comm_relay;
#using scripts/cp/cp_mi_sing_blackstation_station;
#using scripts/cp/cp_mi_sing_blackstation_utility;
#using scripts/shared/ai_shared;
#using scripts/shared/array_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/colors_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/fx_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/trigger_shared;
#using scripts/shared/util_shared;
#using scripts/shared/vehicle_shared;

#namespace cp_mi_sing_blackstation_cross_debris;

// Namespace cp_mi_sing_blackstation_cross_debris
// Params 2, eflags: 0x0
// Checksum 0x7e91b2cd, Offset: 0x7b0
// Size: 0x19a
function function_e9acb08(str_objective, var_74cd64bc) {
    if (var_74cd64bc) {
        load::function_73adcefc();
        namespace_79e1cd97::function_bff1a867("objective_cross_debris");
        namespace_79e1cd97::function_da579a5d("objective_blackstation_exterior");
        level.var_3d556bcd ai::set_ignoreall(1);
        level thread function_b0ed4f4f();
        trigger::use("triggercolor_walkway");
        load::function_a2995f22();
    }
    level thread util::function_d8eaed3d(4);
    level thread scene::play("cin_bla_13_02_looting_vign_lightningstrike_ziplinetalk_kane_idle");
    level thread cp_mi_sing_blackstation_station::function_5142ef8e();
    level thread namespace_79e1cd97::function_6778ea09("light_ne");
    level thread function_5fae6516();
    level thread function_6ffde259();
    level thread function_7e62fe5e();
    level thread function_52065393();
    level.var_2fd26037 thread cp_mi_sing_blackstation_station::function_a561f620();
    level.var_2fd26037 thread namespace_79e1cd97::function_ba29155a();
    level.var_2fd26037 thread function_289b95f6();
    level.var_2fd26037 thread function_9ead7187();
}

// Namespace cp_mi_sing_blackstation_cross_debris
// Params 4, eflags: 0x0
// Checksum 0x390951d1, Offset: 0x958
// Size: 0x72
function function_508330ae(str_objective, var_74cd64bc, var_e4cd2b8b, player) {
    if (isdefined(level.var_3d556bcd)) {
        level.var_3d556bcd skipto::function_d9b1ee00(struct::get("kane_ziplines", "script_noteworthy"));
    }
    level thread util::clear_streamer_hint();
}

// Namespace cp_mi_sing_blackstation_cross_debris
// Params 0, eflags: 0x0
// Checksum 0x43861541, Offset: 0x9d8
// Size: 0x15a
function function_b0ed4f4f() {
    var_10d5eaaa = getent("linkto_door_left", "targetname");
    var_7bc07f9 = getent("linkto_door_right", "targetname");
    var_afbdfbfe = getent("com_relay_bridge_doors_left", "targetname");
    var_21829c35 = getent("com_relay_bridge_doors_right", "targetname");
    var_afbdfbfe linkto(var_10d5eaaa);
    var_21829c35 linkto(var_7bc07f9);
    var_10d5eaaa rotateyaw(100, 0.3);
    var_7bc07f9 rotateyaw(-100, 0.3);
    getent("comrelay_door_clip_right", "targetname") delete();
    getent("comrelay_door_clip_left", "targetname") delete();
}

// Namespace cp_mi_sing_blackstation_cross_debris
// Params 0, eflags: 0x0
// Checksum 0x21c0289b, Offset: 0xb40
// Size: 0x62
function function_52065393() {
    trigger::wait_till("trigger_vo_warn");
    level thread scene::play("p7_fxanim_cp_blackstation_collapsed_bldg_debris_01_bundle");
    trigger::wait_till("trigger_building_debris2");
    level thread scene::play("p7_fxanim_cp_blackstation_collapsed_bldg_debris_02_bundle");
}

// Namespace cp_mi_sing_blackstation_cross_debris
// Params 0, eflags: 0x0
// Checksum 0xe798e89c, Offset: 0xbb0
// Size: 0x82
function function_5fae6516() {
    level thread objectives::breadcrumb("cross_debris_breadcrumb");
    trigger::wait_till("trigger_under_zipline");
    level thread objectives::breadcrumb("trigger_zipline_breadcrumb", "cp_level_blackstation_climb");
    level flag::wait_till("goto_zipline");
    skipto::function_be8adfb8("objective_cross_debris");
}

// Namespace cp_mi_sing_blackstation_cross_debris
// Params 0, eflags: 0x0
// Checksum 0xa1dfc089, Offset: 0xc40
// Size: 0xca
function function_289b95f6() {
    trigger::wait_till("trigger_sky_bridge");
    self dialog::say("hend_structure_s_unstable_0");
    level flag::wait_till("in_atrium");
    level dialog::function_13b3b16a("plyr_watch_out_hendricks_0", 1);
    trigger::wait_till("trigger_vo_warn");
    self dialog::say("hend_watch_your_step_b_0", 0.5);
    level flag::wait_till("vo_falling_apart");
    level dialog::function_13b3b16a("plyr_this_place_is_fallin_0", 1);
}

// Namespace cp_mi_sing_blackstation_cross_debris
// Params 0, eflags: 0x0
// Checksum 0xafdb4b5f, Offset: 0xd18
// Size: 0xc2
function function_9ead7187() {
    level endon(#"hash_62f8dc0c");
    self ai::set_ignoreall(1);
    level waittill(#"bridge_collapsed");
    self colors::disable();
    level scene::add_scene_func("cin_bla_12_01_cross_debris_vign_point", &function_8bcb3a1b);
    level scene::play("cin_bla_12_01_cross_debris_vign_point", self);
    level flag::wait_till("vo_falling_apart");
    self colors::enable();
    level flag::set("hendricks_crossed");
    self ai::set_ignoreall(1);
}

// Namespace cp_mi_sing_blackstation_cross_debris
// Params 1, eflags: 0x0
// Checksum 0x41d25620, Offset: 0xde8
// Size: 0x42
function function_8bcb3a1b(a_ents) {
    level.var_2fd26037 setgoal(getnode("hendricks_crossdebris_landing", "targetname"));
}

// Namespace cp_mi_sing_blackstation_cross_debris
// Params 0, eflags: 0x0
// Checksum 0xee7e731d, Offset: 0xe38
// Size: 0x171
function function_7e62fe5e() {
    level flag::wait_till("atrium_rubble_dropped");
    foreach (player in level.players) {
        player playrumbleonentity("cp_blackstation_building_lean_rumble");
    }
    var_895e60d2 = array::randomize(struct::get_array("crossdebris_window"));
    for (i = 0; i < 4; i++) {
        glassradiusdamage(var_895e60d2[i].origin, 100, 500, 500);
        wait randomfloat(1);
    }
    level waittill(#"hash_b251293d");
    for (i = 4; i < var_895e60d2.size; i++) {
        glassradiusdamage(var_895e60d2[i].origin, 100, 500, 500);
        wait randomfloat(0.3);
    }
}

// Namespace cp_mi_sing_blackstation_cross_debris
// Params 0, eflags: 0x0
// Checksum 0xfec00143, Offset: 0xfb8
// Size: 0x202
function function_6ffde259() {
    level flag::wait_till("in_atrium");
    var_b5ebc943 = getent("crossdebris_rubble_drop", "targetname");
    var_b5ebc943 physicslaunch();
    level flag::set("atrium_rubble_dropped");
    v_origin = struct::get("crossdebris_rubble_impact").origin;
    radiusdamage(v_origin, 800, 5, 5);
    level scene::add_scene_func("p7_fxanim_cp_blackstation_apartment_collapse_bundle", &function_beaf4ba6);
    level scene::play("p7_fxanim_cp_blackstation_apartment_collapse_bundle");
    hidemiscmodels("wooden_bridge");
    showmiscmodels("frogger_building_fallen");
    array::run_all(getentarray("wooden_bridge", "targetname"), &hide);
    array::run_all(getentarray("frogger_building_fallen", "targetname"), &show);
    level flag::set("bridge_collapsed");
    mdl_clip = getent("clip_building_collapse", "targetname");
    if (isdefined(mdl_clip)) {
        mdl_clip delete();
    }
    level thread cp_mi_sing_blackstation_station::function_b8052aae();
}

// Namespace cp_mi_sing_blackstation_cross_debris
// Params 1, eflags: 0x0
// Checksum 0x81d53625, Offset: 0x11c8
// Size: 0x93
function function_beaf4ba6(a_ents) {
    exploder::exploder("fx_expl_apartment_fall");
    level waittill(#"hash_b251293d");
    foreach (player in level.players) {
        player playrumbleonentity("cp_blackstation_building_collapse_rumble");
    }
}

