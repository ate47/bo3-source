#using scripts/cp/cp_mi_sing_sgen_patch_c;
#using scripts/cp/cp_mi_sing_sgen_sound;
#using scripts/cp/cp_mi_sing_sgen_fx;
#using scripts/cp/_util;
#using scripts/cp/_skipto;
#using scripts/cp/_load;
#using scripts/shared/exploder_shared;
#using scripts/shared/ai/systems/fx_character;
#using scripts/shared/vehicles/_quadtank;
#using scripts/shared/visionset_mgr_shared;
#using scripts/shared/util_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/postfx_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/filter_shared;
#using scripts/shared/duplicaterender_mgr;
#using scripts/shared/clientfield_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/audio_shared;
#using scripts/shared/array_shared;
#using scripts/codescripts/struct;

#namespace namespace_4bf13193;

// Namespace namespace_4bf13193
// Params 0, eflags: 0x1 linked
// Checksum 0xa93c6299, Offset: 0x1398
// Size: 0x164
function main() {
    util::function_57b966c8(&function_71f88fc, 6);
    init_clientfields();
    function_fe72942e();
    namespace_219c76cc::main();
    namespace_172c963::main();
    callback::on_spawned(&on_player_spawned);
    util::function_b499f765();
    function_673254cc();
    load::main();
    util::waitforclient(0);
    namespace_dc4413fe::function_7403e82b();
    level thread scene::init("p7_fxanim_gp_crane_pallet_01_bundle");
    level thread scene::init("p7_fxanim_cp_sgen_silo_twins_revenge_flood_bldg_01_bundle");
    level thread scene::init("p7_fxanim_cp_sgen_silo_twins_revenge_flood_bldg_02_bundle");
    level thread scene::init("p7_fxanim_cp_sgen_silo_twins_revenge_flood_bldg_03_bundle");
}

// Namespace namespace_4bf13193
// Params 1, eflags: 0x1 linked
// Checksum 0x46cf472b, Offset: 0x1508
// Size: 0x108
function on_player_spawned(localclientnum) {
    filter::init_filter_ev_interference(self);
    duplicate_render::set_dr_filter_offscreen("sitrep_keyline_red", 25, "keyline_active_red", "keyfill_active_red", 2, "mc/hud_outline_model_z_red", 0);
    player = getlocalplayer(localclientnum);
    if (player getentitynumber() != self getentitynumber()) {
        return;
    }
    if (isdefined(level.var_d9cf9150)) {
        self thread function_e76aa170(localclientnum, undefined, level.var_d9cf9150);
    }
    self.var_65ff120a = 0;
    self.var_580d2ee1 = 0;
    self.var_97b77690 = 0;
}

// Namespace namespace_4bf13193
// Params 0, eflags: 0x1 linked
// Checksum 0x120aa837, Offset: 0x1618
// Size: 0xd74
function init_clientfields() {
    clientfield::register("world", "w_fxa_truck_flip", 1, 1, "int", &function_39252d24, 0, 0);
    clientfield::register("world", "w_robot_window_break", 1, 2, "int", &function_2f6bc99e, 0, 0);
    clientfield::register("world", "testing_lab_wires", 1, 1, "int", &function_f8965920, 0, 0);
    clientfield::register("world", "silo_swim_bridge_fall", 1, 1, "int", &function_6a3af99, 0, 0);
    clientfield::register("world", "w_underwater_state", 1, 1, "int", &function_3fd63c17, 0, 0);
    clientfield::register("world", "w_flood_combat_windows_b", 1, 1, "int", &function_43174f13, 0, 0);
    clientfield::register("world", "w_flood_combat_windows_c", 1, 1, "int", &function_1d14d4aa, 0, 0);
    clientfield::register("world", "elevator_light_probe", 1, 1, "int", &function_5ac1b440, 0, 0);
    clientfield::register("world", "flood_defend_hallway_flood_siege", 1, 1, "int", &function_34e88b9c, 0, 0);
    clientfield::register("world", "tower_chunks1", 1, 1, "int", &function_2b219c66, 0, 0);
    clientfield::register("world", "tower_chunks2", 1, 1, "int", &function_51f21fd, 0, 0);
    clientfield::register("world", "tower_chunks3", 1, 1, "int", &function_df1ca794, 0, 0);
    clientfield::register("world", "observation_deck_destroy", 1, 1, "counter", &function_492309fc, 0, 0);
    clientfield::register("world", "fallen_soldiers_client_fxanims", 1, 1, "int", &function_f81dc3f2, 0, 0);
    clientfield::register("world", "w_flyover_buoys", 1, 1, "int", &function_95af50c, 0, 0);
    clientfield::register("world", "w_twin_igc_fxanim", 1, 2, "int", &function_ff1a4bbc, 0, 0);
    clientfield::register("world", "set_exposure_bank", 1, 1, "int", &function_1e832062, 0, 0);
    clientfield::register("world", "silo_debris", 1, 3, "int", &function_6688e3e0, 0, 0);
    clientfield::register("world", "ceiling_collapse", 1, 3, "int", &function_66617c6c, 0, 0);
    clientfield::register("world", "debris_catwalk", 1, 1, "counter", &function_19ebac1e, 0, 0);
    clientfield::register("world", "debris_wall", 1, 1, "counter", &function_e0e27617, 0, 0);
    clientfield::register("world", "debris_fall", 1, 1, "counter", &function_b309e328, 0, 0);
    clientfield::register("world", "debris_bridge", 1, 1, "counter", &function_73dfc2c8, 0, 0);
    clientfield::register("scriptmover", "structural_weakness", 1, 1, "int", &function_d69a238f, 0, 0);
    clientfield::register("scriptmover", "sm_elevator_shader", 1, 2, "int", &function_a30fa29c, 0, 0);
    clientfield::register("scriptmover", "sm_elevator_door_state", 1, 2, "int", &function_31d56bb1, 0, 0);
    clientfield::register("scriptmover", "weakpoint", 1, 1, "int", &weakpoint, 0, 0);
    duplicate_render::set_dr_filter_offscreen("weakpoint_keyline", 100, "weakpoint_keyline_show_z", "weakpoint_keyline_hide_z", 2, "mc/hud_outline_model_z_orange");
    clientfield::register("scriptmover", "sm_depth_charge_fx", 1, 2, "int", &function_21197c95, 0, 0);
    clientfield::register("scriptmover", "dni_eye", 1, 1, "int", &function_1561b96d, 1, 0);
    clientfield::register("scriptmover", "turn_fake_robot_eye", 1, 1, "int", &function_be719f1, 0, 0);
    clientfield::register("scriptmover", "play_cia_robot_rogue_control", 1, 1, "int", &function_4fdcffa3, 0, 0);
    clientfield::register("scriptmover", "cooling_tower_damage", 1, 1, "int", &function_ef39e6b6, 0, 0);
    clientfield::register("toplayer", "pallas_monitors_state", 1, getminbitcountfornum(3), "int", &function_e76aa170, 0, 0);
    clientfield::register("toplayer", "tp_water_sheeting", 1, 1, "int", &function_6be6da89, 0, 0);
    clientfield::register("toplayer", "oed_interference", 1, 1, "int", &function_ba68067e, 0, 0);
    clientfield::register("toplayer", "sndSiloBG", 1, 1, "int", &function_594a4308, 0, 0);
    clientfield::register("toplayer", "dust_motes", 1, 1, "int", &function_c9e9a72c, 0, 0);
    clientfield::register("toplayer", "water_motes", 1, 1, "int", &function_5cefaf77, 0, 0);
    clientfield::register("toplayer", "water_teleport", 1, 1, "int", &function_a93a4b6a, 0, 0);
    clientfield::register("vehicle", "extra_cam_ent", 1, 2, "int", &function_fe61b5f4, 0, 0);
    clientfield::register("vehicle", "sm_depth_charge_fx", 1, 2, "int", &function_21197c95, 0, 0);
    clientfield::register("vehicle", "quad_tank_tac_mode", 1, 1, "int", &function_8b62fa9d, 0, 0);
    clientfield::register("actor", "robot_bubbles", 1, 1, "int", &function_59c47b1, 0, 0);
    clientfield::register("actor", "sndStepSet", 1, 1, "int", &function_fb081b8c, 1, 0);
    clientfield::register("actor", "disable_tmode", 1, 1, "int", &function_47257e43, 0, 0);
    clientfield::register("world", "sndLabWalla", 1, 1, "int", &namespace_172c963::function_698dfbe4, 0, 0);
    visionset_mgr::register_overlay_info_style_blur("earthquake_blur", 1, 1, 0.1, 0.25, 4);
}

// Namespace namespace_4bf13193
// Params 0, eflags: 0x1 linked
// Checksum 0x1b349b70, Offset: 0x2398
// Size: 0xc2
function function_fe72942e() {
    if (issplitscreen()) {
        var_2bb20e65 = struct::get_array("no_splitscreen", "targetname");
        foreach (s_fxanim in var_2bb20e65) {
            s_fxanim struct::delete();
        }
    }
}

// Namespace namespace_4bf13193
// Params 0, eflags: 0x1 linked
// Checksum 0x407bb393, Offset: 0x2468
// Size: 0x4e4
function function_673254cc() {
    skipto::add("intro", &function_c1c92a60, "Intro");
    skipto::add("exterior", &function_f591a5d3, "Exterior");
    skipto::add("enter_sgen", &function_41d43f98, "Enter SGEN");
    skipto::add("enter_lobby", &function_64b835d1, "QTank Fight", &function_8903df94);
    skipto::add("discover_data", &function_b5bc2e86, "Discover Data");
    skipto::add("aquarium_shimmy", &function_d70d27cf, "Aquarium Shimmy");
    skipto::add("gen_lab", &function_b8453b40, "Genetics Lab");
    skipto::add("post_gen_lab", &function_c9a9671f, "Post Gen Lab");
    skipto::add("chem_lab", &function_69d3873d, "Chemical Lab");
    skipto::add("post_chem_lab", &function_7f2d460, "Post Chem Lab");
    skipto::add("silo_floor", &function_7ed6c252, "Silo Floor Battle", &function_e3f81a25);
    skipto::add("under_silo", &function_82a600e0, "Under Silo");
    skipto::add("fallen_soldiers", &function_6a18d1d4, "Fallen Soldiers");
    skipto::add("testing_lab_igc", &function_6a18d1d4, "Human Testing Lab");
    skipto::add("dark_battle", &function_70fafd70, "Dark Battle");
    skipto::add("charging_station", &function_6a18d1d4, "Charging Station");
    skipto::add("descent", &function_6a18d1d4, "Descent");
    skipto::add("pallas_start", &function_1eba9086, "pallas start");
    skipto::add("pallas_end", &function_6a18d1d4, "Pallas Death");
    skipto::add("twin_revenge", &function_8a68f6ae, "Twin Revenge", &function_9dd018de);
    skipto::add("flood_combat", &function_12a6900b, "Flood Combat");
    skipto::add("flood_defend", &function_12a6900b, "Flood Defend");
    skipto::add("underwater_battle", &function_12a6900b, "Underwater Battle");
    skipto::add("underwater_rail", &function_12a6900b, "Underwater Rail");
    skipto::add("silo_swim", &function_12a6900b, "Silo Swim");
}

// Namespace namespace_4bf13193
// Params 2, eflags: 0x1 linked
// Checksum 0x72f1078e, Offset: 0x2958
// Size: 0x14
function function_6a18d1d4(str_objective, var_74cd64bc) {
    
}

// Namespace namespace_4bf13193
// Params 2, eflags: 0x1 linked
// Checksum 0x76b641ea, Offset: 0x2978
// Size: 0x34
function function_70fafd70(str_objective, var_74cd64bc) {
    if (var_74cd64bc) {
        exploder::exploder("sgen_pods_on");
    }
}

// Namespace namespace_4bf13193
// Params 2, eflags: 0x1 linked
// Checksum 0xdd44438e, Offset: 0x29b8
// Size: 0x44
function function_12a6900b(str_objective, var_74cd64bc) {
    if (var_74cd64bc || str_objective == "flood_combat") {
        level thread function_4b788e97();
    }
}

// Namespace namespace_4bf13193
// Params 2, eflags: 0x1 linked
// Checksum 0x84f7fcb6, Offset: 0x2a08
// Size: 0x34
function function_1eba9086(str_objective, var_74cd64bc) {
    level scene::init("p7_fxanim_cp_sgen_observation_deck_break_01_bundle");
}

// Namespace namespace_4bf13193
// Params 2, eflags: 0x1 linked
// Checksum 0x34e8c15a, Offset: 0x2a48
// Size: 0x2c
function function_c1c92a60(str_objective, var_74cd64bc) {
    level thread function_6dddaec0();
}

// Namespace namespace_4bf13193
// Params 2, eflags: 0x1 linked
// Checksum 0x44f38788, Offset: 0x2a80
// Size: 0x34
function function_f591a5d3(str_objective, var_74cd64bc) {
    if (var_74cd64bc) {
        level thread function_6dddaec0();
    }
}

// Namespace namespace_4bf13193
// Params 2, eflags: 0x1 linked
// Checksum 0x2484b2c1, Offset: 0x2ac0
// Size: 0x34
function function_41d43f98(str_objective, var_74cd64bc) {
    if (var_74cd64bc) {
        level thread function_6dddaec0();
    }
}

// Namespace namespace_4bf13193
// Params 2, eflags: 0x1 linked
// Checksum 0x4c5be7fd, Offset: 0x2b00
// Size: 0x34
function function_64b835d1(str_objective, var_74cd64bc) {
    if (var_74cd64bc) {
        level thread function_6dddaec0();
    }
}

// Namespace namespace_4bf13193
// Params 2, eflags: 0x1 linked
// Checksum 0x7027df8b, Offset: 0x2b40
// Size: 0x14
function function_8903df94(str_objective, var_74cd64bc) {
    
}

// Namespace namespace_4bf13193
// Params 2, eflags: 0x1 linked
// Checksum 0xa164809c, Offset: 0x2b60
// Size: 0x34
function function_b5bc2e86(str_objective, var_74cd64bc) {
    if (var_74cd64bc) {
        level thread function_6dddaec0();
    }
}

// Namespace namespace_4bf13193
// Params 2, eflags: 0x1 linked
// Checksum 0xdf655d44, Offset: 0x2ba0
// Size: 0x34
function function_d70d27cf(str_objective, var_74cd64bc) {
    if (var_74cd64bc) {
        level thread function_6dddaec0();
    }
}

// Namespace namespace_4bf13193
// Params 2, eflags: 0x1 linked
// Checksum 0x13f0532a, Offset: 0x2be0
// Size: 0x34
function function_b8453b40(str_objective, var_74cd64bc) {
    if (var_74cd64bc) {
        level thread function_941e3519();
    }
}

// Namespace namespace_4bf13193
// Params 2, eflags: 0x1 linked
// Checksum 0x27b6ad21, Offset: 0x2c20
// Size: 0x34
function function_c9a9671f(str_objective, var_74cd64bc) {
    if (var_74cd64bc) {
        level thread function_941e3519();
    }
}

// Namespace namespace_4bf13193
// Params 2, eflags: 0x1 linked
// Checksum 0x12df905b, Offset: 0x2c60
// Size: 0x34
function function_69d3873d(str_objective, var_74cd64bc) {
    if (var_74cd64bc) {
        level thread function_32a8709a();
    }
}

// Namespace namespace_4bf13193
// Params 2, eflags: 0x1 linked
// Checksum 0x32556aab, Offset: 0x2ca0
// Size: 0x34
function function_7f2d460(str_objective, var_74cd64bc) {
    if (var_74cd64bc) {
        level thread function_32a8709a();
    }
}

// Namespace namespace_4bf13193
// Params 2, eflags: 0x1 linked
// Checksum 0xea77f8bd, Offset: 0x2ce0
// Size: 0x34
function function_7ed6c252(str_objective, var_74cd64bc) {
    if (var_74cd64bc) {
        level thread function_32a8709a();
    }
}

// Namespace namespace_4bf13193
// Params 2, eflags: 0x1 linked
// Checksum 0x878bab9d, Offset: 0x2d20
// Size: 0x8c
function function_e3f81a25(str_objective, var_74cd64bc) {
    if (var_74cd64bc) {
        wait(1);
    }
    if (scene::is_active("p7_fxanim_gp_raven_circle_ccw_01_bundle")) {
        level scene::stop("p7_fxanim_gp_raven_circle_ccw_01_bundle", "scriptbundlename", 1);
    }
    wait(0.1);
    struct::function_368120a1("scene", "p7_fxanim_gp_raven_circle_ccw_01_bundle");
}

// Namespace namespace_4bf13193
// Params 2, eflags: 0x1 linked
// Checksum 0xe4ec689f, Offset: 0x2db8
// Size: 0x34
function function_82a600e0(str_objective, var_74cd64bc) {
    if (var_74cd64bc) {
        level thread function_32a8709a();
    }
}

// Namespace namespace_4bf13193
// Params 2, eflags: 0x1 linked
// Checksum 0xa0c87153, Offset: 0x2df8
// Size: 0x14
function function_8a68f6ae(str_objective, var_74cd64bc) {
    
}

// Namespace namespace_4bf13193
// Params 2, eflags: 0x1 linked
// Checksum 0xe62058f0, Offset: 0x2e18
// Size: 0x14
function function_9dd018de(str_objective, var_74cd64bc) {
    
}

// Namespace namespace_4bf13193
// Params 0, eflags: 0x1 linked
// Checksum 0xb9f28222, Offset: 0x2e38
// Size: 0x44
function function_6dddaec0() {
    level scene::init("p7_fxanim_cp_sgen_rappel_rope_bundle");
    level thread scene::play("p7_fxanim_gp_crane_pallet_01_bundle");
}

// Namespace namespace_4bf13193
// Params 0, eflags: 0x1 linked
// Checksum 0x82e09b6d, Offset: 0x2e88
// Size: 0x24
function function_941e3519() {
    level scene::play("p7_fxanim_gp_crane_pallet_01_bundle");
}

// Namespace namespace_4bf13193
// Params 0, eflags: 0x1 linked
// Checksum 0x6425f6e, Offset: 0x2eb8
// Size: 0x24
function function_32a8709a() {
    level scene::play("p7_fxanim_gp_crane_pallet_01_bundle");
}

// Namespace namespace_4bf13193
// Params 7, eflags: 0x1 linked
// Checksum 0x3dfa3670, Offset: 0x2ee8
// Size: 0x9c
function function_1561b96d(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        self mapshaderconstant(localclientnum, 0, "scriptVector0", 0, 1, 0, 0);
        return;
    }
    self mapshaderconstant(localclientnum, 0, "scriptVector0", 0, 0, 0, 0);
}

// Namespace namespace_4bf13193
// Params 7, eflags: 0x1 linked
// Checksum 0x46cb469e, Offset: 0x2f90
// Size: 0xac
function function_8b62fa9d(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        self tmodesetflag(9);
        self tmodesetflag(10);
        return;
    }
    self tmodeclearflag(9);
    self tmodeclearflag(10);
}

// Namespace namespace_4bf13193
// Params 7, eflags: 0x1 linked
// Checksum 0x3f891635, Offset: 0x3048
// Size: 0x74
function function_47257e43(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        self tmodesetflag(0);
        return;
    }
    self tmodeclearflag(0);
}

// Namespace namespace_4bf13193
// Params 4, eflags: 0x1 linked
// Checksum 0xf3ac569e, Offset: 0x30c8
// Size: 0x86
function function_2370f00f(localclientnum, newval, str_value, str_key) {
    switch (newval) {
    case 2:
        level thread scene::init(str_value, str_key);
        break;
    case 1:
        level thread scene::play(str_value, str_key);
        break;
    }
}

// Namespace namespace_4bf13193
// Params 7, eflags: 0x1 linked
// Checksum 0x3e6c6f5b, Offset: 0x3158
// Size: 0x64
function function_2f6bc99e(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    function_2370f00f(localclientnum, newval, "robot_window_break_start", "targetname");
}

// Namespace namespace_4bf13193
// Params 7, eflags: 0x1 linked
// Checksum 0xe400ac43, Offset: 0x31c8
// Size: 0x5c
function function_73dfc2c8(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    function_2370f00f(localclientnum, newval, "p7_fxanim_cp_sgen_silo_debris_bridge_bundle");
}

// Namespace namespace_4bf13193
// Params 7, eflags: 0x1 linked
// Checksum 0x689bc3bd, Offset: 0x3230
// Size: 0x5c
function function_e0e27617(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    function_2370f00f(localclientnum, newval, "p7_fxanim_cp_sgen_silo_debris_wall_bundle");
}

// Namespace namespace_4bf13193
// Params 0, eflags: 0x1 linked
// Checksum 0x490f630b, Offset: 0x3298
// Size: 0x24
function function_4b788e97() {
    level thread scene::play("uw_battle_fxanims");
}

// Namespace namespace_4bf13193
// Params 7, eflags: 0x1 linked
// Checksum 0xca0f2b0c, Offset: 0x32c8
// Size: 0x64
function function_b309e328(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        level thread scene::play("p7_fxanim_cp_sgen_silo_debris_fall_bundle");
    }
}

// Namespace namespace_4bf13193
// Params 7, eflags: 0x1 linked
// Checksum 0x272d0c4e, Offset: 0x3338
// Size: 0x64
function function_19ebac1e(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        level thread scene::play("p7_fxanim_cp_sgen_silo_debris_catwalk_bundle");
    }
}

// Namespace namespace_4bf13193
// Params 7, eflags: 0x1 linked
// Checksum 0x53644441, Offset: 0x33a8
// Size: 0x6c
function function_39252d24(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        level thread scene::play("truck_flip", "targetname");
    }
}

// Namespace namespace_4bf13193
// Params 7, eflags: 0x1 linked
// Checksum 0x4cb4e56e, Offset: 0x3420
// Size: 0x5c
function function_d69a238f(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self duplicate_render::set_item_enemy_equipment(localclientnum, newval);
}

// Namespace namespace_4bf13193
// Params 7, eflags: 0x1 linked
// Checksum 0xbcef9925, Offset: 0x3488
// Size: 0x6c
function function_6a3af99(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        level thread scene::play("bridge_collapse", "targetname");
    }
}

// Namespace namespace_4bf13193
// Params 7, eflags: 0x1 linked
// Checksum 0x965e6955, Offset: 0x3500
// Size: 0x27c
function function_fe61b5f4(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval == 1) {
        v_offset = anglestoforward(self.angles) * 10;
        v_origin = self.origin + v_offset;
        self.var_628a497e = spawn(localclientnum, v_origin, "script_origin");
        self.var_628a497e.angles = self.angles + (0, 0, -90);
        self.var_628a497e linkto(self, "tag_origin");
        self.var_628a497e setextracam(0);
        playsound(0, "uin_pip_open", (0, 0, 0));
        return;
    }
    if (newval == 2) {
        v_offset = anglestoforward(self.angles) * 10;
        v_origin = self.origin + v_offset;
        self.var_628a497e = spawn(localclientnum, v_origin, "script_origin");
        self.var_628a497e.angles = self.angles;
        self.var_628a497e linkto(self, "tag_origin");
        self.var_628a497e setextracam(0);
        playsound(0, "uin_pip_open", (0, 0, 0));
        return;
    }
    if (isdefined(self.var_628a497e)) {
        playsound(0, "uin_pip_close", (0, 0, 0));
        self.var_628a497e clearextracam();
        self.var_628a497e delete();
    }
}

// Namespace namespace_4bf13193
// Params 7, eflags: 0x1 linked
// Checksum 0xb61f2e23, Offset: 0x3788
// Size: 0x9c
function function_ba68067e(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        self.var_97b77690 = 0.004;
        self.var_45d466a1 = 0;
    } else {
        self.var_97b77690 = -1 * 0.00533333;
        self.var_45d466a1 = 1;
    }
    self thread function_248868ae(localclientnum);
}

// Namespace namespace_4bf13193
// Params 1, eflags: 0x1 linked
// Checksum 0xd9c6e257, Offset: 0x3830
// Size: 0x248
function function_248868ae(localclientnum) {
    self endon(#"death");
    self notify(#"hash_5a719f24");
    self endon(#"hash_5a719f24");
    if (!isdefined(self.var_65ff120a)) {
        self.var_65ff120a = 0;
    }
    if (!isdefined(self.var_580d2ee1)) {
        self.var_580d2ee1 = 0;
    }
    if (!isdefined(self.var_97b77690)) {
        self.var_97b77690 = 0;
    }
    if (!isdefined(self.var_8b31f902)) {
        self.var_8b31f902 = 0;
    }
    while (isdefined(self)) {
        self.var_65ff120a += self.var_97b77690;
        if (self.var_65ff120a < 0) {
            self.var_65ff120a = 0;
        } else if (self.var_65ff120a > 1) {
            self.var_65ff120a = 1;
        }
        if ((!self.var_8b31f902 || self.var_65ff120a == 0) && !self.var_45d466a1) {
            if (self.var_580d2ee1) {
                self.var_580d2ee1 = 0;
                filter::disable_filter_ev_interference(self, 0);
            }
        } else if (self.var_65ff120a > 0) {
            if (!self.var_580d2ee1) {
                self.var_580d2ee1 = 1;
                filter::enable_filter_ev_interference(self, 0);
            }
            if (self.var_580d2ee1) {
                filter::set_filter_ev_interference_amount(self, 0, self.var_65ff120a);
                n_range = -106 + (1 - self.var_65ff120a) * 10350;
                var_864ac2d9 = 50 + (1 - self.var_65ff120a) * 2950;
                evsetranges(localclientnum, n_range, var_864ac2d9);
            }
        }
        wait(0.016);
    }
}

// Namespace namespace_4bf13193
// Params 7, eflags: 0x1 linked
// Checksum 0x2ae92e2a, Offset: 0x3a80
// Size: 0xd4
function function_f8965920(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (binitialsnap || newval && oldval != newval) {
        level thread scene::play("p7_fxanim_gp_wire_sparking_sml_bundle");
        level thread scene::play("p7_fxanim_gp_wire_sparking_med_thick_bundle");
        level thread scene::play("p7_fxanim_gp_wire_sparking_xlong_thick_bundle");
        level thread scene::play("p7_fxanim_gp_wire_sparking_xsml_thick_bundle");
    }
}

// Namespace namespace_4bf13193
// Params 7, eflags: 0x1 linked
// Checksum 0xbb49c0c1, Offset: 0x3b60
// Size: 0xc8
function function_ef39e6b6(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self endon(#"death");
    self endon(#"entityshutdown");
    self endon(#"hash_ecd8f5eb");
    if (!newval) {
        self notify(#"hash_ecd8f5eb");
        return;
    }
    while (true) {
        var_e63dbf6d = self waittill(#"damage");
        playfx(localclientnum, level._effect["core_impact"], var_e63dbf6d);
    }
}

// Namespace namespace_4bf13193
// Params 7, eflags: 0x1 linked
// Checksum 0x2f558f96, Offset: 0x3c30
// Size: 0x6c
function function_66617c6c(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        level scene::play("hallway_ceiling_collapse_0" + newval, "targetname");
    }
}

// Namespace namespace_4bf13193
// Params 7, eflags: 0x1 linked
// Checksum 0x8f45adba, Offset: 0x3ca8
// Size: 0x14a
function function_e76aa170(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    level notify(#"hash_2fdfc947");
    level.var_d9cf9150 = newval;
    switch (newval) {
    case 0:
        self thread function_6f15ec64(localclientnum);
        break;
    case 1:
        self thread function_cacf88e6(localclientnum);
        break;
    case 2:
        self thread function_b84a3557(localclientnum);
        break;
    case 3:
        if (isdefined(self.var_146171cd)) {
            for (i = 0; i < self.var_146171cd.size; i++) {
                self.var_146171cd[i] delete();
            }
        }
        level.var_d9cf9150 = undefined;
        break;
    }
}

// Namespace namespace_4bf13193
// Params 1, eflags: 0x1 linked
// Checksum 0x17f32832, Offset: 0x3e00
// Size: 0x17c
function function_cacf88e6(localclientnum) {
    self endon(#"death");
    level endon(#"hash_2fdfc947");
    var_ba5d91ee = getentarray(localclientnum, "pallas_xcam_model", "targetname");
    while (isdefined(self)) {
        var_ba5d91ee = array::get_all_closest(self.origin, var_ba5d91ee);
        n_count = 0;
        foreach (var_969f33c9 in var_ba5d91ee) {
            if (n_count < 12) {
                if (isdefined(var_969f33c9.str_state)) {
                    continue;
                }
                var_969f33c9 show();
                n_count++;
                continue;
            }
            var_969f33c9 hide();
            var_969f33c9.str_state = undefined;
        }
        wait(0.75);
    }
}

// Namespace namespace_4bf13193
// Params 0, eflags: 0x0
// Checksum 0xfe231596, Offset: 0x3f88
// Size: 0x5e
function function_5799c6c0() {
    level endon(#"hash_2fdfc947");
    self.str_state = "off";
    self hide();
    wait(randomfloatrange(2, 5));
    self.str_state = undefined;
}

// Namespace namespace_4bf13193
// Params 0, eflags: 0x0
// Checksum 0x140c6426, Offset: 0x3ff0
// Size: 0x10e
function function_39b5ac35() {
    level endon(#"hash_2fdfc947");
    n_time = randomfloatrange(2, 5);
    n_iterations = n_time / 0.05;
    self.str_state = "blink";
    for (i = 0; i < n_iterations; i++) {
        if (randomint(100) < 50) {
            self show();
        } else {
            self hide();
        }
        wait(0.05);
    }
    self hide();
    self.str_state = undefined;
}

// Namespace namespace_4bf13193
// Params 1, eflags: 0x1 linked
// Checksum 0x54d14f5a, Offset: 0x4108
// Size: 0x130
function function_b84a3557(localclientnum) {
    self endon(#"death");
    level endon(#"hash_2fdfc947");
    var_ba5d91ee = getentarray(localclientnum, "pallas_xcam_model", "targetname");
    while (isdefined(self)) {
        var_ba5d91ee = array::randomize(var_ba5d91ee);
        foreach (i, mdl_monitor in var_ba5d91ee) {
            if (i % 3 == 0) {
                mdl_monitor show();
                continue;
            }
            mdl_monitor hide();
        }
        wait(0.1);
    }
}

// Namespace namespace_4bf13193
// Params 1, eflags: 0x1 linked
// Checksum 0x32ee39fc, Offset: 0x4240
// Size: 0xca
function function_6f15ec64(localclientnum) {
    level endon(#"hash_2fdfc947");
    var_ba5d91ee = getentarray(localclientnum, "pallas_xcam_model", "targetname");
    foreach (mdl_monitor in var_ba5d91ee) {
        mdl_monitor show();
    }
}

// Namespace namespace_4bf13193
// Params 7, eflags: 0x1 linked
// Checksum 0xdce9f7cf, Offset: 0x4318
// Size: 0x7c
function function_6be6da89(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        startwatersheetingfx(localclientnum, 0);
        return;
    }
    stopwatersheetingfx(localclientnum, 1);
}

// Namespace namespace_4bf13193
// Params 7, eflags: 0x1 linked
// Checksum 0x7107c2af, Offset: 0x43a0
// Size: 0xf4
function function_3fd63c17(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        setdvar("phys_buoyancy", 1);
        setdvar("phys_ragdoll_buoyancy", 1);
        setdvar("player_useWaterFriction", 0);
        return;
    }
    setdvar("phys_buoyancy", 0);
    setdvar("phys_ragdoll_buoyancy", 0);
    setdvar("player_useWaterFriction", 1);
}

// Namespace namespace_4bf13193
// Params 7, eflags: 0x1 linked
// Checksum 0xe8ce9bef, Offset: 0x44a0
// Size: 0x6c
function function_43174f13(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        level thread scene::play("window_lt_01_start", "targetname");
    }
}

// Namespace namespace_4bf13193
// Params 7, eflags: 0x1 linked
// Checksum 0x119e3209, Offset: 0x4518
// Size: 0x6c
function function_1d14d4aa(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        level thread scene::play("window_rt_02_start", "targetname");
    }
}

// Namespace namespace_4bf13193
// Params 7, eflags: 0x1 linked
// Checksum 0x959d3af5, Offset: 0x4590
// Size: 0x1e2
function function_5ac1b440(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    var_99450f8a = getentarray(localclientnum, "pallas_elevator_probe", "targetname");
    var_8df90b18 = getentarray(localclientnum, "pallas_elevator_light", "targetname");
    var_be31aa9a = getent(localclientnum, "boss_fight_lift", "targetname");
    foreach (light in var_99450f8a) {
        light linkto(var_be31aa9a);
    }
    foreach (probe in var_8df90b18) {
        probe linkto(var_be31aa9a);
    }
}

// Namespace namespace_4bf13193
// Params 7, eflags: 0x1 linked
// Checksum 0xd415c06f, Offset: 0x4780
// Size: 0x64
function function_34e88b9c(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        level scene::play("p7_fxanim_cp_sgen_water_hallway_flood_bundle");
    }
}

// Namespace namespace_4bf13193
// Params 7, eflags: 0x1 linked
// Checksum 0x9506e98d, Offset: 0x47f0
// Size: 0x1fe
function function_a30fa29c(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (!isdefined(self.var_10ff82f3)) {
        self.var_10ff82f3 = getent(localclientnum, "boss_fight_lift", "targetname");
        self.var_10ff82f3 linkto(self);
    }
    switch (newval) {
    case 3:
        self.var_10ff82f3 show();
        break;
    case 2:
        self.var_10ff82f3 hide();
        break;
    case 1:
        for (i = 0; i < 2; i += 0.01) {
            self.var_10ff82f3 mapshaderconstant(0, 0, "scriptVector0", i / 2, 0, 0, 0);
            wait(0.01);
        }
        break;
    case 0:
        for (i = 3; i > 0; i -= 0.01) {
            self.var_10ff82f3 mapshaderconstant(0, 0, "scriptVector0", i / 3, 0, 0, 0);
            wait(0.01);
        }
        self.var_10ff82f3 hide();
        break;
    }
}

// Namespace namespace_4bf13193
// Params 7, eflags: 0x1 linked
// Checksum 0x124365de, Offset: 0x49f8
// Size: 0xee
function function_31d56bb1(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    switch (newval) {
    case 2:
        self.var_fd5b0874 = getent(localclientnum, "pallas_lift_back", "targetname");
        self.var_fd5b0874 linkto(self);
        break;
    case 1:
        self.var_fd5b0874 = getent(localclientnum, "pallas_lift_front", "targetname");
        self.var_fd5b0874 linkto(self);
        break;
    }
}

// Namespace namespace_4bf13193
// Params 7, eflags: 0x1 linked
// Checksum 0x16ff1d78, Offset: 0x4af0
// Size: 0x9c
function function_492309fc(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (!isdefined(level.anchor_delete_watcher)) {
        level.anchor_delete_watcher = 0;
    }
    level.anchor_delete_watcher++;
    if (level.anchor_delete_watcher > 3) {
        return;
    }
    level scene::play("p7_fxanim_cp_sgen_observation_deck_break_0" + level.anchor_delete_watcher + "_bundle");
}

// Namespace namespace_4bf13193
// Params 7, eflags: 0x1 linked
// Checksum 0x75e4fd54, Offset: 0x4b98
// Size: 0x64
function function_2b219c66(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    level scene::play("server_tower_chunks_01", "targetname");
}

// Namespace namespace_4bf13193
// Params 7, eflags: 0x1 linked
// Checksum 0xade1995c, Offset: 0x4c08
// Size: 0x64
function function_51f21fd(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    level scene::play("server_tower_chunks_02", "targetname");
}

// Namespace namespace_4bf13193
// Params 7, eflags: 0x1 linked
// Checksum 0xb34f1aab, Offset: 0x4c78
// Size: 0x64
function function_df1ca794(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    level scene::play("server_tower_chunks_03", "targetname");
}

// Namespace namespace_4bf13193
// Params 7, eflags: 0x1 linked
// Checksum 0xc218116d, Offset: 0x4ce8
// Size: 0x5c
function function_be719f1(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    fxclientutils::playfxbundle(localclientnum, self, "c_54i_robot_grunt_fx_def_4_rogue");
}

// Namespace namespace_4bf13193
// Params 7, eflags: 0x1 linked
// Checksum 0x770476c2, Offset: 0x4d50
// Size: 0x8c
function function_4fdcffa3(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        fxclientutils::playfxbundle(localclientnum, self, "c_cia_robot_grunt_fx_def_1_rogue");
        return;
    }
    fxclientutils::stopfxbundle(localclientnum, self, "c_cia_robot_grunt_fx_def_1_rogue");
}

// Namespace namespace_4bf13193
// Params 7, eflags: 0x1 linked
// Checksum 0x57fffb47, Offset: 0x4de8
// Size: 0x86
function function_594a4308(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval == 1) {
        self thread primarygroup("amb_descent_bg_top", "amb_descent_bg_mid", "amb_descent_bg_bot");
        return;
    }
    level notify(#"hash_bf6420ee");
}

// Namespace namespace_4bf13193
// Params 3, eflags: 0x1 linked
// Checksum 0x8a1a26bd, Offset: 0x4e78
// Size: 0x6f6
function primarygroup(arg1, arg2, arg3) {
    level endon(#"hash_bf6420ee");
    startorigin = (42, -30, -128);
    endorigin = (-53, 865, -2671);
    distbetween = abs(startorigin[2] - endorigin[2]);
    if (!isdefined(arg1) && !isdefined(arg2)) {
        return;
    }
    point1 = startorigin[2];
    point2 = endorigin[2];
    if (isdefined(arg3)) {
        point1 = startorigin;
        point2 = ((startorigin[0] + endorigin[0]) / 2, (startorigin[1] + endorigin[1]) / 2, (startorigin[2] + endorigin[2]) / 2);
        var_5302f134 = endorigin;
    }
    var_47f2e24a = spawn(0, startorigin, "script_origin");
    var_47f2e24a playloopsound(arg1, 0.5);
    var_47f2e24a setloopstate(arg1, 1, 1);
    var_21f067e1 = spawn(0, startorigin, "script_origin");
    var_21f067e1 playloopsound(arg2, 0.5);
    var_21f067e1 setloopstate(arg2, 0, 1);
    var_21f067e1 linkto(var_47f2e24a);
    if (isdefined(arg3)) {
        var_fbeded78 = spawn(0, startorigin, "script_origin");
        var_fbeded78 playloopsound(arg3, 0.5);
        var_fbeded78 setloopstate(arg3, 0, 1);
        var_fbeded78 linkto(var_47f2e24a);
    }
    level thread function_c87bd675(var_47f2e24a, var_21f067e1, var_fbeded78);
    wait(0.5);
    if (!isdefined(self)) {
        return;
    }
    while (isdefined(self)) {
        var_ab1780c5 = self.origin[2];
        var_5adf0e21 = abs(point1[2] - var_ab1780c5);
        var_80e1888a = abs(point2[2] - var_ab1780c5);
        if (isdefined(arg3)) {
            var_a6e402f3 = abs(var_5302f134[2] - var_ab1780c5);
        }
        volume1 = audio::scale_speed(0, abs(point1[2] - point2[2]), 0, 1, var_5adf0e21);
        volume1 = abs(1 - volume1);
        var_47f2e24a setloopstate(arg1, volume1, 1);
        volume2 = audio::scale_speed(0, abs(point1[2] - point2[2]), 0, 1, var_80e1888a);
        volume2 = abs(1 - volume2);
        var_21f067e1 setloopstate(arg2, volume2, 1);
        if (isdefined(arg3)) {
            var_e99b824a = audio::scale_speed(0, abs(point2[2] - var_5302f134[2]), 0, 1, var_a6e402f3);
            var_e99b824a = abs(1 - var_e99b824a);
            var_fbeded78 setloopstate(arg3, var_e99b824a, 1);
        }
        percentage = var_5adf0e21 / distbetween;
        var_afec9063 = (endorigin[0] - startorigin[0]) * percentage + startorigin[0];
        var_3de52128 = (endorigin[1] - startorigin[1]) * percentage + startorigin[1];
        var_63e79b91 = var_ab1780c5;
        if (var_ab1780c5 >= startorigin[2]) {
            var_afec9063 = startorigin[0];
            var_3de52128 = startorigin[1];
            var_63e79b91 = startorigin[2];
        }
        if (var_ab1780c5 <= endorigin[2]) {
            var_afec9063 = endorigin[0];
            var_3de52128 = endorigin[1];
            var_63e79b91 = endorigin[2];
        }
        var_47f2e24a moveto((var_afec9063, var_3de52128, var_63e79b91), 0.2);
        wait(0.2);
    }
    level notify(#"hash_bf6420ee");
}

// Namespace namespace_4bf13193
// Params 3, eflags: 0x1 linked
// Checksum 0x24065c5, Offset: 0x5578
// Size: 0x6c
function function_c87bd675(ent1, ent2, ent3) {
    level waittill(#"hash_bf6420ee");
    ent1 delete();
    ent2 delete();
    ent3 delete();
}

// Namespace namespace_4bf13193
// Params 7, eflags: 0x1 linked
// Checksum 0x2c739866, Offset: 0x55f0
// Size: 0xc4
function function_c9e9a72c(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    wait(0.1);
    if (newval) {
        if (isdefined(self)) {
            self.n_fx_id = playviewmodelfx(localclientnum, level._effect["dust_motes"], "tag_camera");
        }
        return;
    }
    if (isdefined(self) && isdefined(self.n_fx_id)) {
        deletefx(localclientnum, self.n_fx_id, 1);
    }
}

// Namespace namespace_4bf13193
// Params 7, eflags: 0x1 linked
// Checksum 0xbe996b2e, Offset: 0x56c0
// Size: 0xc4
function function_5cefaf77(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    wait(0.1);
    if (newval) {
        if (isdefined(self)) {
            self.var_8e8c7340 = playviewmodelfx(localclientnum, level._effect["water_motes"], "tag_camera");
        }
        return;
    }
    if (isdefined(self) && isdefined(self.n_fx_id)) {
        deletefx(localclientnum, self.var_8e8c7340, 1);
    }
}

// Namespace namespace_4bf13193
// Params 7, eflags: 0x1 linked
// Checksum 0x963804a0, Offset: 0x5790
// Size: 0x134
function function_a93a4b6a(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (!isdefined(level.var_6f7efbc2)) {
        level.var_6f7efbc2 = [];
    }
    if (newval) {
        if (isdefined(self)) {
            if (isdefined(level.var_6f7efbc2[localclientnum])) {
                return;
            }
            level.var_6f7efbc2[localclientnum] = playviewmodelfx(localclientnum, level._effect["water_teleport"], "tag_camera");
            exploder::exploder("flood_lighting");
        }
        return;
    }
    if (isdefined(self) && isdefined(level.var_6f7efbc2[localclientnum])) {
        deletefx(localclientnum, level.var_6f7efbc2[localclientnum], 0);
        exploder::stop_exploder("flood_lighting");
    }
}

// Namespace namespace_4bf13193
// Params 7, eflags: 0x1 linked
// Checksum 0x904ef5f9, Offset: 0x58d0
// Size: 0xc6
function function_6688e3e0(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval < 6) {
        level scene::play("p7_fxanim_cp_sgen_underwater_silo_debris_0" + newval + "_bundle");
        return;
    }
    for (x = 0; x < 6; x++) {
        level scene::stop("p7_fxanim_cp_sgen_underwater_silo_debris_0" + x + "_bundle");
    }
}

// Namespace namespace_4bf13193
// Params 1, eflags: 0x1 linked
// Checksum 0x40a47d58, Offset: 0x59a0
// Size: 0x2ee
function function_71f88fc(n_zone) {
    switch (n_zone) {
    case 2:
        forcestreambundle("cin_sgen_14_humanlab_3rd_sh010");
        forcestreambundle("cin_sgen_14_humanlab_3rd_sh020");
        forcestreambundle("cin_sgen_14_humanlab_3rd_sh030");
        forcestreambundle("cin_sgen_14_humanlab_3rd_sh040");
        forcestreambundle("cin_sgen_14_humanlab_3rd_sh050");
        forcestreambundle("cin_sgen_14_humanlab_3rd_sh060");
        forcestreambundle("cin_sgen_14_humanlab_3rd_sh070");
        forcestreambundle("cin_sgen_14_humanlab_3rd_sh080");
        forcestreambundle("cin_sgen_14_humanlab_3rd_sh090");
        forcestreambundle("cin_sgen_14_humanlab_3rd_sh020");
        break;
    case 3:
        forcestreambundle("p7_fxanim_cp_sgen_pallas_ai_tower_collapse_bundle");
        forcestreambundle("cin_sgen_19_ghost_3rd_sh010");
        forcestreambundle("cin_sgen_19_ghost_3rd_sh020");
        forcestreambundle("cin_sgen_19_ghost_3rd_sh030");
        forcestreambundle("cin_sgen_19_ghost_3rd_sh040");
        forcestreambundle("cin_sgen_19_ghost_3rd_sh050");
        forcestreambundle("cin_sgen_19_ghost_3rd_sh060");
        forcestreambundle("cin_sgen_19_ghost_3rd_sh070");
        forcestreambundle("cin_sgen_19_ghost_3rd_sh080");
        forcestreambundle("cin_sgen_19_ghost_3rd_sh090");
        break;
    case 4:
        forcestreamxmodel("c_54i_assault_body");
        forcestreamxmodel("c_54i_assault_lieutenant_head");
        break;
    case 5:
        forcestreambundle("cin_sgen_26_01_lobbyexit_1st_escape_grab");
        forcestreambundle("cin_sgen_26_01_lobbyexit_1st_escape_outro");
        forcestreambundle("p7_fxanim_cp_sgen_end_building_collapse_debris_bundle");
        break;
    case 6:
        forcestreamxmodel("c_hro_hendricks_sing_body");
        forcestreamxmodel("c_hro_hendricks_sing_head");
        break;
    }
}

// Namespace namespace_4bf13193
// Params 7, eflags: 0x1 linked
// Checksum 0xdf95f507, Offset: 0x5c98
// Size: 0xcc
function weakpoint(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        self duplicate_render::change_dr_flags(localclientnum, "weakpoint_keyline_show_z", "weakpoint_keyline_hide_z");
        self weakpoint_enable(2);
        return;
    }
    self duplicate_render::change_dr_flags(localclientnum, "weakpoint_keyline_hide_z", "weakpoint_keyline_show_z");
    self weakpoint_enable(0);
}

// Namespace namespace_4bf13193
// Params 7, eflags: 0x1 linked
// Checksum 0xe2443e2a, Offset: 0x5d70
// Size: 0x74
function function_f81dc3f2(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (binitialsnap || newval && oldval != newval) {
        level scene::play("p7_fxanim_gp_wire_sparking_xsml_bundle");
    }
}

// Namespace namespace_4bf13193
// Params 7, eflags: 0x1 linked
// Checksum 0x9bf2c1e9, Offset: 0x5df0
// Size: 0x84
function function_95af50c(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        level scene::play("p7_fxanim_gp_floating_buoy_02_upright_bundle");
        return;
    }
    level scene::stop("p7_fxanim_gp_floating_buoy_02_upright_bundle");
}

// Namespace namespace_4bf13193
// Params 7, eflags: 0x1 linked
// Checksum 0xf9bdff7a, Offset: 0x5e80
// Size: 0x12c
function function_fb081b8c(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        match = "fly_water_wade";
        triggers = getentarray(0, "audio_step_trigger", "targetname");
        foreach (trig in triggers) {
            if (trig.script_label == match) {
                self thread function_df9260b7(trig, match);
                return;
            }
        }
    }
}

// Namespace namespace_4bf13193
// Params 2, eflags: 0x1 linked
// Checksum 0xa789b8dc, Offset: 0x5fb8
// Size: 0xd0
function function_df9260b7(trigger, alias) {
    self endon(#"death");
    self endon(#"entityshutdown");
    self.var_111461f1 = 0;
    while (true) {
        if (self istouching(trigger)) {
            if (!self.var_111461f1) {
                self.var_111461f1 = 1;
                self setsteptriggersound(alias + "_npc");
            }
        } else if (self.var_111461f1) {
            self.var_111461f1 = 0;
            self clearsteptriggersound();
        }
        wait(0.1);
    }
}

// Namespace namespace_4bf13193
// Params 7, eflags: 0x1 linked
// Checksum 0xe4f72ac1, Offset: 0x6090
// Size: 0xac
function function_59c47b1(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (!isdefined(self.var_d1efe793)) {
        self.var_d1efe793 = playfxontag(localclientnum, level._effect["water_robot_bubbles"], self, "tag_aim");
        self waittill(#"death");
        stopfx(localclientnum, self.var_d1efe793);
    }
}

// Namespace namespace_4bf13193
// Params 7, eflags: 0x1 linked
// Checksum 0x5677f476, Offset: 0x6148
// Size: 0x13e
function function_21197c95(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (isdefined(self.light_fx)) {
        stopfx(localclientnum, self.light_fx);
        self.light_fx = undefined;
    }
    self endon(#"entityshutdown");
    self util::waittill_dobj(localclientnum);
    if (!isdefined(self)) {
        return;
    }
    switch (newval) {
    case 1:
        self.light_fx = playfxontag(localclientnum, level._effect["yellow_light"], self, "tag_origin");
        break;
    case 2:
        self.light_fx = playfxontag(localclientnum, level._effect["red_light"], self, "tag_origin");
        break;
    }
}

// Namespace namespace_4bf13193
// Params 7, eflags: 0x1 linked
// Checksum 0x857f8e65, Offset: 0x6290
// Size: 0x176
function function_ff1a4bbc(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    switch (newval) {
    case 1:
        var_5cee1345 = findstaticmodelindexarray("twin_revenge_bldg_static1");
        if (isdefined(var_5cee1345)) {
            foreach (var_bc3c6c65 in var_5cee1345) {
                hidestaticmodel(var_bc3c6c65);
            }
        }
        level thread scene::play("p7_fxanim_cp_sgen_silo_twins_revenge_flood_bldg_01_bundle");
        break;
    case 2:
        level thread scene::play("p7_fxanim_cp_sgen_silo_twins_revenge_flood_bldg_02_bundle");
        break;
    case 3:
        level thread scene::play("p7_fxanim_cp_sgen_silo_twins_revenge_flood_bldg_03_bundle");
        break;
    }
}

// Namespace namespace_4bf13193
// Params 7, eflags: 0x1 linked
// Checksum 0xf39f43c2, Offset: 0x6410
// Size: 0x7c
function function_1e832062(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        setexposureactivebank(localclientnum, 4);
        return;
    }
    setexposureactivebank(localclientnum, 1);
}

