#using scripts/codescripts/struct;
#using scripts/cp/_load;
#using scripts/cp/_skipto;
#using scripts/cp/_util;
#using scripts/shared/array_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/postfx_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/shared/visionset_mgr_shared;

#namespace zurich_util;

// Namespace zurich_util
// Params 0, eflags: 0x2
// Checksum 0xf171115a, Offset: 0x1978
// Size: 0x34
function autoexec __init__sytem__() {
    system::register("zurich_util", &__init__, undefined, undefined);
}

// Namespace zurich_util
// Params 0, eflags: 0x0
// Checksum 0x76da813c, Offset: 0x19b8
// Size: 0x4c
function __init__() {
    init_clientfields();
    util::function_b499f765();
    level.var_1cf7e9e8 = [];
    level.var_18402cb = [];
    function_ba0b35c();
}

// Namespace zurich_util
// Params 0, eflags: 0x0
// Checksum 0x1bd8b27b, Offset: 0x1a10
// Size: 0x8ec
function init_clientfields() {
    var_2d20335b = getminbitcountfornum(5);
    var_a9ef5da3 = getminbitcountfornum(6);
    visionset_mgr::register_visionset_info("cp_zurich_hallucination", 1, 1, "cp_zurich_hallucination", "cp_zurich_hallucination");
    clientfield::register("actor", "exploding_ai_deaths", 1, 1, "int", &function_b3f0d569, 0, 0);
    clientfield::register("actor", "hero_spawn_fx", 1, 1, "int", &function_78bd19c4, 0, 0);
    clientfield::register("scriptmover", "hero_spawn_fx", 1, 1, "int", &function_78bd19c4, 0, 0);
    clientfield::register("scriptmover", "vehicle_spawn_fx", 1, 1, "int", &function_f026ccfa, 0, 0);
    clientfield::register("toplayer", "set_world_fog", 1, 1, "int", &function_346468e3, 0, 0);
    clientfield::register("scriptmover", "raven_juke_effect", 1, 1, "counter", &function_69d5dc62, 0, 0);
    clientfield::register("actor", "raven_juke_limb_effect", 1, 1, "counter", &function_d559bc1d, 0, 0);
    clientfield::register("scriptmover", "raven_teleport_effect", 1, 1, "counter", &function_cb609334, 0, 0);
    clientfield::register("actor", "raven_teleport_limb_effect", 1, 1, "counter", &function_496c80db, 0, 0);
    clientfield::register("scriptmover", "raven_teleport_in_effect", 1, 1, "counter", &function_c39ee0a8, 0, 0);
    clientfield::register("toplayer", "player_weather", 1, var_2d20335b, "int", &function_6120ef33, 0, 0);
    clientfield::register("toplayer", "vortex_teleport", 1, 1, "counter", &function_560fbdb4, 0, 0);
    clientfield::register("toplayer", "postfx_futz", 1, 1, "counter", &postfx_futz, 0, 0);
    clientfield::register("toplayer", "postfx_futz_mild", 1, 1, "counter", &postfx_futz_mild, 0, 0);
    clientfield::register("toplayer", "postfx_transition", 1, 1, "counter", &postfx_transition, 0, 0);
    clientfield::register("world", "zurich_city_ambience", 1, 1, "int", &zurich_city_ambience, 0, 0);
    clientfield::register("actor", "skin_transition_melt", 1, 1, "int", &function_28572b48, 0, 1);
    clientfield::register("scriptmover", "corvus_body_fx", 1, 1, "int", &function_b5037219, 0, 0);
    clientfield::register("actor", "raven_ai_rez", 1, 1, "int", &function_91c7508e, 0, 0);
    clientfield::register("scriptmover", "raven_ai_rez", 1, 1, "int", &function_91c7508e, 0, 0);
    clientfield::register("toplayer", "zurich_server_cam", 1, 1, "int", &zurich_server_cam, 0, 0);
    clientfield::register("world", "set_exposure_bank", 1, 1, "int", &set_exposure_bank, 0, 0);
    clientfield::register("scriptmover", "corvus_tree_shader", 1, 1, "int", &function_51e77d4f, 0, 0);
    clientfield::register("actor", "hero_cold_breath", 1, 1, "int", &function_33714f9b, 0, 0);
    clientfield::register("world", "set_post_color_grade_bank", 1, 1, "int", &set_post_color_grade_bank, 0, 0);
    clientfield::register("toplayer", "postfx_hallucinations", 1, 1, "counter", &postfx_hallucinations, 0, 0);
    clientfield::register("toplayer", "player_water_transition", 1, 1, "int", &function_70a9fa32, 0, 0);
    clientfield::register("toplayer", "raven_hallucinations", 1, 1, "int", &raven_hallucinations, 0, 0);
    clientfield::register("scriptmover", "quadtank_raven_explosion", 1, 1, "int", &quadtank_raven_explosion, 0, 0);
    clientfield::register("scriptmover", "raven_fade_out", 1, 1, "int", &raven_fade_out, 0, 0);
}

// Namespace zurich_util
// Params 0, eflags: 0x0
// Checksum 0xbfbbe807, Offset: 0x2308
// Size: 0x756
function function_ba0b35c() {
    level._effect["exploding_death"] = "player/fx_ai_raven_dissolve_torso";
    level._effect["vehicle_spawn_fx"] = "player/fx_ai_dni_rez_in_hero_clean";
    level._effect["raven_juke_effect"] = "player/fx_ai_raven_juke_out";
    level._effect["raven_juke_effect_arm_le"] = "player/fx_ai_raven_juke_out_arm_le";
    level._effect["raven_juke_effect_arm_ri"] = "player/fx_ai_raven_juke_out_arm_ri";
    level._effect["raven_juke_effect_leg_le"] = "player/fx_ai_raven_juke_out_leg_le";
    level._effect["raven_juke_effect_leg_ri"] = "player/fx_ai_raven_juke_out_leg_ri";
    level._effect["raven_teleport_effect"] = "player/fx_ai_raven_teleport";
    level._effect["raven_teleport_effect_arm_le"] = "player/fx_ai_raven_teleport_out_arm_le";
    level._effect["raven_teleport_effect_arm_ri"] = "player/fx_ai_raven_teleport_out_arm_ri";
    level._effect["raven_teleport_effect_leg_le"] = "player/fx_ai_raven_teleport_out_leg_le";
    level._effect["raven_teleport_effect_leg_ri"] = "player/fx_ai_raven_teleport_out_leg_ri";
    level._effect["raven_teleport_in_effect"] = "player/fx_ai_raven_teleport_in";
    level._effect["red_rain"] = "weather/fx_rain_system_hvy_blood_runner_loop";
    level._effect["light_snow"] = "weather/fx_snow_player_lt_loop";
    level._effect["regular_snow"] = "weather/fx_snow_player_loop";
    level._effect["reverse_snow"] = "weather/fx_snow_player_loop_reverse";
    level._effect["vortex_explode"] = "player/fx_ai_dni_rez_in_hero_clean";
    level._effect["corvus_fx_arm_le"] = "player/fx_ai_corvus_arm_left_loop";
    level._effect["corvus_fx_arm_ri"] = "player/fx_ai_corvus_arm_right_loop";
    level._effect["corvus_fx_head"] = "player/fx_ai_corvus_head_loop";
    level._effect["corvus_fx_hip_le"] = "player/fx_ai_corvus_hip_left_loop";
    level._effect["corvus_fx_hip_ri"] = "player/fx_ai_corvus_hip_right_loop";
    level._effect["corvus_fx_leg_le"] = "player/fx_ai_corvus_leg_left_loop";
    level._effect["corvus_fx_leg_ri"] = "player/fx_ai_corvus_leg_right_loop";
    level._effect["corvus_fx_torso"] = "player/fx_ai_corvus_torso_loop";
    level._effect["corvus_fx_waist"] = "player/fx_ai_corvus_waist_loop";
    level._effect["hero_cold_breath"] = "player/fx_plyr_breath_steam_3p";
    level._effect["raven_in_fx_arm_le"] = "player/fx_ai_dni_rez_in_arm_left_dirty";
    level._effect["raven_in_fx_arm_ri"] = "player/fx_ai_dni_rez_in_arm_right_dirty";
    level._effect["raven_in_fx_head"] = "player/fx_ai_dni_rez_in_head_dirty";
    level._effect["raven_in_fx_hip_le"] = "player/fx_ai_dni_rez_in_hip_left_dirty";
    level._effect["raven_in_fx_hip_ri"] = "player/fx_ai_dni_rez_in_hip_right_dirty";
    level._effect["raven_in_fx_leg_le"] = "player/fx_ai_dni_rez_in_leg_left_dirty";
    level._effect["raven_in_fx_leg_ri"] = "player/fx_ai_dni_rez_in_leg_right_dirty";
    level._effect["raven_in_fx_torso"] = "player/fx_ai_dni_rez_in_torso_dirty";
    level._effect["raven_in_fx_waist"] = "player/fx_ai_dni_rez_in_waist_dirty";
    level._effect["raven_hallucination_fx"] = "animals/fx_bio_birds_raven_player_camera";
    level._effect["raven_out_fx_arm_le"] = "player/fx_ai_dni_rez_out_arm_left_dirty";
    level._effect["raven_out_fx_arm_ri"] = "player/fx_ai_dni_rez_out_arm_right_dirty";
    level._effect["raven_out_fx_head"] = "player/fx_ai_dni_rez_out_head_dirty";
    level._effect["raven_out_fx_hip_le"] = "player/fx_ai_dni_rez_out_hip_left_dirty";
    level._effect["raven_out_fx_hip_ri"] = "player/fx_ai_dni_rez_out_hip_right_dirty";
    level._effect["raven_out_fx_leg_le"] = "player/fx_ai_dni_rez_out_leg_left_dirty";
    level._effect["raven_out_fx_leg_ri"] = "player/fx_ai_dni_rez_out_leg_right_dirty";
    level._effect["raven_out_fx_torso"] = "player/fx_ai_dni_rez_out_torso_dirty";
    level._effect["raven_out_fx_waist"] = "player/fx_ai_dni_rez_out_waist_dirty";
    level._effect["hero_in_fx_arm_le"] = "player/fx_ai_dni_rez_in_arm_left_clean";
    level._effect["hero_in_fx_arm_ri"] = "player/fx_ai_dni_rez_in_arm_right_clean";
    level._effect["hero_in_fx_head"] = "player/fx_ai_dni_rez_in_head_clean";
    level._effect["hero_in_fx_hip_le"] = "player/fx_ai_dni_rez_in_hip_left_clean";
    level._effect["hero_in_fx_hip_ri"] = "player/fx_ai_dni_rez_in_hip_right_clean";
    level._effect["hero_in_fx_leg_le"] = "player/fx_ai_dni_rez_in_leg_left_clean";
    level._effect["hero_in_fx_leg_ri"] = "player/fx_ai_dni_rez_in_leg_right_clean";
    level._effect["hero_in_fx_torso"] = "player/fx_ai_dni_rez_in_torso_clean";
    level._effect["hero_in_fx_waist"] = "player/fx_ai_dni_rez_in_waist_clean";
    level._effect["hero_out_fx_arm_le"] = "player/fx_ai_dni_rez_out_arm_left_clean";
    level._effect["hero_out_fx_arm_ri"] = "player/fx_ai_dni_rez_out_arm_right_clean";
    level._effect["hero_out_fx_head"] = "player/fx_ai_dni_rez_out_head_clean";
    level._effect["hero_out_fx_hip_le"] = "player/fx_ai_dni_rez_out_hip_left_clean";
    level._effect["hero_out_fx_hip_ri"] = "player/fx_ai_dni_rez_out_hip_right_clean";
    level._effect["hero_out_fx_leg_le"] = "player/fx_ai_dni_rez_out_leg_left_clean";
    level._effect["hero_out_fx_leg_ri"] = "player/fx_ai_dni_rez_out_leg_right_clean";
    level._effect["hero_out_fx_torso"] = "player/fx_ai_dni_rez_out_torso_clean";
    level._effect["hero_out_fx_waist"] = "player/fx_ai_dni_rez_out_waist_clean";
    level._effect["quadtank_explosion_fx"] = "explosions/fx_exp_dni_raven_reveal";
    level._effect["raven_fade_out_fx"] = "animals/fx_bio_raven_dni_rez_out_dirty";
}

// Namespace zurich_util
// Params 2, eflags: 0x0
// Checksum 0x969554d4, Offset: 0x2a68
// Size: 0x14
function function_5bcd68f2(str_objective, var_74cd64bc) {
    
}

// Namespace zurich_util
// Params 2, eflags: 0x0
// Checksum 0xeddbacc4, Offset: 0x2a88
// Size: 0x538
function function_3bf27f88(str_objective, var_74cd64bc) {
    if (str_objective == "plaza_battle") {
        wait 1;
        level struct::function_368120a1("scene", "p7_fxanim_cp_zurich_wasp_swarm_bundle");
        return;
    }
    if (str_objective == "root_zurich_vortex") {
        wait 1;
        level struct::function_368120a1("scene", "p7_fxanim_cp_zurich_root_wall_01_bundle");
        level struct::function_368120a1("scene", "p7_fxanim_cp_zurich_root_wall_02_bundle");
        return;
    }
    if (str_objective == "root_cairo_vortex") {
        wait 1;
        level struct::function_368120a1("scene", "p7_fxanim_cp_zurich_cairo_b_collapse_01_bundle");
        level struct::function_368120a1("scene", "p7_fxanim_cp_zurich_cairo_b_collapse_02_bundle");
        level struct::function_368120a1("scene", "p7_fxanim_cp_zurich_cairo_b_collapse_03_bundle");
        level struct::function_368120a1("scene", "p7_fxanim_cp_zurich_cairo_lightpole_bundle");
        level struct::function_368120a1("scene", "p7_fxanim_cp_zurich_sinkhole_01_bundle");
        level struct::function_368120a1("scene", "p7_fxanim_cp_zurich_sinkhole_02_bundle");
        return;
    }
    if (str_objective == "clearing_hub_3") {
        wait 1;
        level struct::function_368120a1("scene", "p7_fxanim_cp_zurich_root_door_center_bundle");
        level struct::function_368120a1("scene", "p7_fxanim_cp_zurich_root_door_left_bundle");
        level struct::function_368120a1("scene", "p7_fxanim_cp_zurich_root_door_right_bundle");
        level struct::function_368120a1("scene", "p7_fxanim_cp_zurich_root_door_round_bundle");
        level struct::function_368120a1("scene", "cin_zur_16_02_clearing_vign_bodies01");
        level struct::function_368120a1("scene", "cin_zur_16_02_clearing_vign_bodies02");
        level struct::function_368120a1("scene", "cin_zur_16_02_clearing_vign_bodies04");
        return;
    }
    if (str_objective == "root_singapore_vortex") {
        wait 1;
        level struct::function_368120a1("scene", "cin_zur_16_02_singapore_hanging_shortrope");
        level struct::function_368120a1("scene", "cin_zur_16_02_singapore_hanging_shortrope_2");
        level struct::function_368120a1("scene", "cin_zur_16_02_singapore_vign_bodies01");
        level struct::function_368120a1("scene", "cin_zur_16_02_singapore_vign_bodies02");
        level struct::function_368120a1("scene", "cin_zur_16_02_singapore_vign_bodies03");
        level struct::function_368120a1("scene", "cin_zur_16_02_singapore_vign_pulled01");
        level struct::function_368120a1("scene", "cin_zur_16_02_singapore_vign_pulled02");
        level struct::function_368120a1("scene", "cin_zur_16_02_singapore_vign_pulled03");
        level struct::function_368120a1("scene", "p7_fxanim_cp_zurich_roots_water01_bundle");
        level struct::function_368120a1("scene", "p7_fxanim_cp_zurich_roots_water02_bundle");
        level struct::function_368120a1("scene", "p7_fxanim_gp_shutter_lt_02_red_bundle");
        level struct::function_368120a1("scene", "p7_fxanim_gp_shutter_lt_10_red_white_bundle");
        level struct::function_368120a1("scene", "p7_fxanim_gp_shutter_rt_02_red_bundle");
        level struct::function_368120a1("scene", "p7_fxanim_gp_shutter_rt_10_red_white_bundle");
    }
}

// Namespace zurich_util
// Params 2, eflags: 0x0
// Checksum 0x1970f0e6, Offset: 0x2fc8
// Size: 0xfa
function function_4dd02a03(a_ents, str_notify) {
    if (isdefined(str_notify)) {
        level waittill(str_notify);
    }
    if (isdefined(a_ents) && isarray(a_ents)) {
        a_ents = array::remove_undefined(a_ents);
        if (a_ents.size) {
            foreach (e_ent in a_ents) {
                e_ent delete();
            }
        }
    }
}

// Namespace zurich_util
// Params 7, eflags: 0x0
// Checksum 0x3dbd7747, Offset: 0x30d0
// Size: 0x13c
function function_b3f0d569(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval == 1) {
        pos = self gettagorigin("j_spine4");
        angles = self gettagangles("j_spine4");
        fxobj = util::spawn_model(localclientnum, "tag_origin", pos, angles);
        playfxontag(localclientnum, level._effect["exploding_death"], fxobj, "tag_origin");
        fxobj playsound(localclientnum, "evt_ai_explode");
        wait 6;
        fxobj delete();
    }
}

// Namespace zurich_util
// Params 7, eflags: 0x0
// Checksum 0x3c9ac8f5, Offset: 0x3218
// Size: 0x494
function function_78bd19c4(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval == 1) {
        playfxontag(localclientnum, level._effect["hero_in_fx_arm_le"], self, "j_elbow_le");
        playfxontag(localclientnum, level._effect["hero_in_fx_arm_le"], self, "j_shoulder_le");
        playfxontag(localclientnum, level._effect["hero_in_fx_arm_ri"], self, "j_elbow_ri");
        playfxontag(localclientnum, level._effect["hero_in_fx_arm_ri"], self, "j_shoulder_ri");
        playfxontag(localclientnum, level._effect["hero_in_fx_head"], self, "j_head");
        playfxontag(localclientnum, level._effect["hero_in_fx_hip_le"], self, "j_hip_le");
        playfxontag(localclientnum, level._effect["hero_in_fx_hip_ri"], self, "j_hip_ri");
        playfxontag(localclientnum, level._effect["hero_in_fx_leg_le"], self, "j_knee_le");
        playfxontag(localclientnum, level._effect["hero_in_fx_leg_ri"], self, "j_knee_ri");
        playfxontag(localclientnum, level._effect["hero_in_fx_torso"], self, "j_spine4");
        playfxontag(localclientnum, level._effect["hero_in_fx_waist"], self, "j_spinelower");
        self playsound(localclientnum, "evt_ai_raven_spawn");
        return;
    }
    playfxontag(localclientnum, level._effect["hero_out_fx_arm_le"], self, "j_elbow_le");
    playfxontag(localclientnum, level._effect["hero_out_fx_arm_le"], self, "j_shoulder_le");
    playfxontag(localclientnum, level._effect["hero_out_fx_arm_ri"], self, "j_elbow_ri");
    playfxontag(localclientnum, level._effect["hero_out_fx_arm_ri"], self, "j_shoulder_ri");
    playfxontag(localclientnum, level._effect["hero_out_fx_head"], self, "j_head");
    playfxontag(localclientnum, level._effect["hero_out_fx_hip_le"], self, "j_hip_le");
    playfxontag(localclientnum, level._effect["hero_out_fx_hip_ri"], self, "j_hip_ri");
    playfxontag(localclientnum, level._effect["hero_out_fx_leg_le"], self, "j_knee_le");
    playfxontag(localclientnum, level._effect["hero_out_fx_leg_ri"], self, "j_knee_ri");
    playfxontag(localclientnum, level._effect["hero_out_fx_torso"], self, "j_spine4");
    playfxontag(localclientnum, level._effect["hero_out_fx_waist"], self, "j_spinelower");
}

// Namespace zurich_util
// Params 7, eflags: 0x0
// Checksum 0xfb023139, Offset: 0x36b8
// Size: 0x8c
function function_f026ccfa(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    playfxontag(localclientnum, level._effect["vehicle_spawn_fx"], self, "tag_origin");
    self playsound(localclientnum, "evt_ai_raven_spawn");
}

// Namespace zurich_util
// Params 7, eflags: 0x0
// Checksum 0xef036dba, Offset: 0x3750
// Size: 0xc4
function function_346468e3(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval == 1) {
        setlitfogbank(localclientnum, -1, 1, -1);
        setworldfogactivebank(localclientnum, 2);
        return;
    }
    setlitfogbank(localclientnum, -1, 0, -1);
    setworldfogactivebank(localclientnum, 1);
}

// Namespace zurich_util
// Params 7, eflags: 0x0
// Checksum 0x575cdb17, Offset: 0x3820
// Size: 0x7c
function set_exposure_bank(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        setexposureactivebank(localclientnum, 4);
        return;
    }
    setexposureactivebank(localclientnum, 1);
}

// Namespace zurich_util
// Params 7, eflags: 0x0
// Checksum 0x170e32f4, Offset: 0x38a8
// Size: 0x7c
function set_post_color_grade_bank(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        setpbgactivebank(localclientnum, 2);
        return;
    }
    setpbgactivebank(localclientnum, 1);
}

// Namespace zurich_util
// Params 7, eflags: 0x0
// Checksum 0x1133bdfc, Offset: 0x3930
// Size: 0x8c
function function_69d5dc62(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    playfxontag(localclientnum, level._effect["raven_juke_effect"], self, "tag_origin");
    self playsound(localclientnum, "evt_ai_juke");
}

// Namespace zurich_util
// Params 7, eflags: 0x0
// Checksum 0x123f4407, Offset: 0x39c8
// Size: 0x1bc
function function_d559bc1d(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    playfxontag(localclientnum, level._effect["raven_juke_effect_arm_le"], self, "j_elbow_le");
    playfxontag(localclientnum, level._effect["raven_juke_effect_arm_le"], self, "j_shoulder_le");
    playfxontag(localclientnum, level._effect["raven_juke_effect_arm_ri"], self, "j_elbow_ri");
    playfxontag(localclientnum, level._effect["raven_juke_effect_arm_ri"], self, "j_shoulder_ri");
    playfxontag(localclientnum, level._effect["raven_juke_effect_leg_le"], self, "j_knee_le");
    playfxontag(localclientnum, level._effect["raven_juke_effect_leg_le"], self, "j_hip_le");
    playfxontag(localclientnum, level._effect["raven_juke_effect_leg_ri"], self, "j_knee_ri");
    playfxontag(localclientnum, level._effect["raven_juke_effect_leg_ri"], self, "j_hip_ri");
}

// Namespace zurich_util
// Params 7, eflags: 0x0
// Checksum 0x887de8f2, Offset: 0x3b90
// Size: 0x8c
function function_cb609334(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    playfxontag(localclientnum, level._effect["raven_teleport_effect"], self, "tag_origin");
    self playsound(localclientnum, "evt_ai_teleoprt");
}

// Namespace zurich_util
// Params 7, eflags: 0x0
// Checksum 0x305e7544, Offset: 0x3c28
// Size: 0x1bc
function function_496c80db(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    playfxontag(localclientnum, level._effect["raven_teleport_effect_arm_le"], self, "j_elbow_le");
    playfxontag(localclientnum, level._effect["raven_teleport_effect_arm_le"], self, "j_shoulder_le");
    playfxontag(localclientnum, level._effect["raven_teleport_effect_arm_ri"], self, "j_elbow_ri");
    playfxontag(localclientnum, level._effect["raven_teleport_effect_arm_ri"], self, "j_shoulder_ri");
    playfxontag(localclientnum, level._effect["raven_teleport_effect_leg_le"], self, "j_knee_le");
    playfxontag(localclientnum, level._effect["raven_teleport_effect_leg_le"], self, "j_hip_le");
    playfxontag(localclientnum, level._effect["raven_teleport_effect_leg_ri"], self, "j_knee_ri");
    playfxontag(localclientnum, level._effect["raven_teleport_effect_leg_ri"], self, "j_hip_ri");
}

// Namespace zurich_util
// Params 7, eflags: 0x0
// Checksum 0x17103743, Offset: 0x3df0
// Size: 0x8c
function function_c39ee0a8(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    playfxontag(localclientnum, level._effect["raven_teleport_in_effect"], self, "tag_origin");
    self playsound(localclientnum, "evt_ai_teleport_in");
}

// Namespace zurich_util
// Params 7, eflags: 0x0
// Checksum 0xa225f7d4, Offset: 0x3e88
// Size: 0xb4
function function_560fbdb4(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    wait 0.1;
    var_c3a24c78 = self.origin + (0, 0, 32) + anglestoforward(self.angles) * 12;
    playfx(localclientnum, level._effect["vortex_explode"], var_c3a24c78);
}

// Namespace zurich_util
// Params 7, eflags: 0x0
// Checksum 0x9366a702, Offset: 0x3f48
// Size: 0x494
function function_91c7508e(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval == 1) {
        playfxontag(localclientnum, level._effect["raven_in_fx_arm_le"], self, "j_elbow_le");
        playfxontag(localclientnum, level._effect["raven_in_fx_arm_le"], self, "j_shoulder_le");
        playfxontag(localclientnum, level._effect["raven_in_fx_arm_ri"], self, "j_elbow_ri");
        playfxontag(localclientnum, level._effect["raven_in_fx_arm_ri"], self, "j_shoulder_ri");
        playfxontag(localclientnum, level._effect["raven_in_fx_head"], self, "j_head");
        playfxontag(localclientnum, level._effect["raven_in_fx_hip_le"], self, "j_hip_le");
        playfxontag(localclientnum, level._effect["raven_in_fx_hip_ri"], self, "j_hip_ri");
        playfxontag(localclientnum, level._effect["raven_in_fx_leg_le"], self, "j_knee_le");
        playfxontag(localclientnum, level._effect["raven_in_fx_leg_ri"], self, "j_knee_ri");
        playfxontag(localclientnum, level._effect["raven_in_fx_torso"], self, "j_spine4");
        playfxontag(localclientnum, level._effect["raven_in_fx_waist"], self, "j_spinelower");
        self playsound(localclientnum, "evt_ai_raven_spawn");
        return;
    }
    playfxontag(localclientnum, level._effect["raven_out_fx_arm_le"], self, "j_elbow_le");
    playfxontag(localclientnum, level._effect["raven_out_fx_arm_le"], self, "j_shoulder_le");
    playfxontag(localclientnum, level._effect["raven_out_fx_arm_ri"], self, "j_elbow_ri");
    playfxontag(localclientnum, level._effect["raven_out_fx_arm_ri"], self, "j_shoulder_ri");
    playfxontag(localclientnum, level._effect["raven_out_fx_head"], self, "j_head");
    playfxontag(localclientnum, level._effect["raven_out_fx_hip_le"], self, "j_hip_le");
    playfxontag(localclientnum, level._effect["raven_out_fx_hip_ri"], self, "j_hip_ri");
    playfxontag(localclientnum, level._effect["raven_out_fx_leg_le"], self, "j_knee_le");
    playfxontag(localclientnum, level._effect["raven_out_fx_leg_ri"], self, "j_knee_ri");
    playfxontag(localclientnum, level._effect["raven_out_fx_torso"], self, "j_spine4");
    playfxontag(localclientnum, level._effect["raven_out_fx_waist"], self, "j_spinelower");
}

// Namespace zurich_util
// Params 7, eflags: 0x0
// Checksum 0xa8d5dff9, Offset: 0x43e8
// Size: 0x3be
function function_b5037219(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval == 1) {
        self.var_e709b4fd = [];
        var_120b6bed = playfxontag(localclientnum, level._effect["corvus_fx_arm_le"], self, "j_elbow_le");
        var_380de656 = playfxontag(localclientnum, level._effect["corvus_fx_arm_le"], self, "j_shoulder_le");
        var_5e1060bf = playfxontag(localclientnum, level._effect["corvus_fx_arm_ri"], self, "j_elbow_ri");
        var_53ff07e0 = playfxontag(localclientnum, level._effect["corvus_fx_arm_ri"], self, "j_shoulder_ri");
        var_5f28bb04 = playfxontag(localclientnum, level._effect["corvus_fx_head"], self, "j_head");
        var_7c88767e = playfxontag(localclientnum, level._effect["corvus_fx_hip_le"], self, "j_hip_le");
        var_5685fc15 = playfxontag(localclientnum, level._effect["corvus_fx_hip_ri"], self, "j_hip_ri");
        var_af98a017 = playfxontag(localclientnum, level._effect["corvus_fx_leg_le"], self, "j_knee_le");
        var_3d9130dc = playfxontag(localclientnum, level._effect["corvus_fx_leg_ri"], self, "j_knee_ri");
        var_a4653f43 = playfxontag(localclientnum, level._effect["corvus_fx_torso"], self, "j_spine4");
        var_a656ad3a = playfxontag(localclientnum, level._effect["corvus_fx_waist"], self, "j_spinelower");
        self.var_e709b4fd = array(var_120b6bed, var_380de656, var_5e1060bf, var_53ff07e0, var_5f28bb04, var_7c88767e, var_5685fc15, var_af98a017, var_3d9130dc, var_a4653f43, var_a656ad3a);
        return;
    }
    if (isdefined(self.var_e709b4fd)) {
        for (i = 0; i < self.var_e709b4fd.size; i++) {
            deletefx(localclientnum, self.var_e709b4fd[i], 0);
        }
        self.var_e709b4fd = undefined;
    }
}

// Namespace zurich_util
// Params 7, eflags: 0x0
// Checksum 0x2d935d1f, Offset: 0x47b0
// Size: 0x1fc
function function_6120ef33(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval >= 1) {
        if (level.var_1cf7e9e8[localclientnum] === newval) {
            return;
        }
        level.var_1cf7e9e8[localclientnum] = newval;
        switch (newval) {
        case 1:
            str_fx = "regular_snow";
            n_delay = 0.5;
            self thread function_965fdae0(localclientnum, str_fx, n_delay);
            break;
        case 2:
            str_fx = "red_rain";
            n_delay = 0.3;
            self thread function_965fdae0(localclientnum, str_fx, n_delay);
            break;
        case 3:
            str_fx = "reverse_snow";
            n_delay = 0.03;
            self thread function_965fdae0(localclientnum, str_fx, n_delay);
            break;
        case 4:
            str_fx = "light_snow";
            n_delay = 0.03;
            self thread function_965fdae0(localclientnum, str_fx, n_delay);
            break;
        default:
            self function_a0b8d731(localclientnum);
            break;
        }
        return;
    }
    self function_a0b8d731(localclientnum);
}

// Namespace zurich_util
// Params 3, eflags: 0x0
// Checksum 0xd3b9e95f, Offset: 0x49b8
// Size: 0xa2
function function_965fdae0(localclientnum, str_fx, n_delay) {
    if (isdefined(level.var_18402cb[localclientnum])) {
        deletefx(localclientnum, level.var_18402cb[localclientnum], 1);
        level.var_18402cb[localclientnum] = undefined;
    }
    level.var_18402cb[localclientnum] = playfxoncamera(localclientnum, level._effect[str_fx], (0, 0, 0), (1, 0, 0), (0, 0, 1));
}

// Namespace zurich_util
// Params 1, eflags: 0x0
// Checksum 0x104e69d2, Offset: 0x4a68
// Size: 0x60
function function_a0b8d731(localclientnum) {
    level.var_1cf7e9e8[localclientnum] = undefined;
    if (isdefined(level.var_18402cb[localclientnum])) {
        deletefx(localclientnum, level.var_18402cb[localclientnum], 1);
        level.var_18402cb[localclientnum] = undefined;
    }
}

// Namespace zurich_util
// Params 7, eflags: 0x0
// Checksum 0x77eb88a, Offset: 0x4ad0
// Size: 0xa4
function postfx_futz(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    player = getlocalplayer(localclientnum);
    playsound(localclientnum, "evt_dni_interrupt", (0, 0, 0));
    player postfx::playpostfxbundle("pstfx_dni_screen_futz");
}

// Namespace zurich_util
// Params 7, eflags: 0x0
// Checksum 0xa5d61993, Offset: 0x4b80
// Size: 0x7c
function postfx_transition(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    player = getlocalplayer(localclientnum);
    player thread postfx::playpostfxbundle("pstfx_cp_transition_sprite_zur");
}

// Namespace zurich_util
// Params 7, eflags: 0x0
// Checksum 0xb760fd57, Offset: 0x4c08
// Size: 0xa4
function postfx_futz_mild(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    player = getlocalplayer(localclientnum);
    playsound(localclientnum, "evt_dni_interrupt", (0, 0, 0));
    player postfx::playpostfxbundle("pstfx_dni_interrupt_mild");
}

// Namespace zurich_util
// Params 7, eflags: 0x0
// Checksum 0xc3c79a4e, Offset: 0x4cb8
// Size: 0x8c
function zurich_city_ambience(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        level thread scene::play("p7_fxanim_cp_zurich_wasp_swarm_bundle");
        return;
    }
    level scene::stop("p7_fxanim_cp_zurich_wasp_swarm_bundle", 1);
}

// Namespace zurich_util
// Params 7, eflags: 0x0
// Checksum 0x87169302, Offset: 0x4d50
// Size: 0x120
function function_28572b48(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        n_start_time = gettime();
        while (isdefined(self)) {
            n_time = gettime();
            var_348e23ad = (n_time - n_start_time) / 1000;
            if (var_348e23ad >= 4) {
                var_348e23ad = 4;
                b_is_updating = 0;
            }
            var_daad71ff = 1 * var_348e23ad / 4;
            self mapshaderconstant(localclientnum, 0, "scriptVector0", var_daad71ff, var_daad71ff, 0);
            wait 0.01;
        }
    }
}

// Namespace zurich_util
// Params 7, eflags: 0x0
// Checksum 0x595ed69, Offset: 0x4e78
// Size: 0x9e
function function_51e77d4f(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval == 1) {
        if (isdefined(self.var_540c25e7) && self.var_540c25e7) {
            return;
        }
        self.var_540c25e7 = 1;
        self thread corvus_tree_shader();
        return;
    }
    self.var_540c25e7 = undefined;
    self notify(#"stop_shader");
}

// Namespace zurich_util
// Params 0, eflags: 0x0
// Checksum 0xd4b5e7aa, Offset: 0x4f20
// Size: 0x1ba
function corvus_tree_shader() {
    self endon(#"stop_shader");
    n_increment = 0.1;
    var_94af3e50 = 1;
    var_2271cae = 0.4;
    n_pulse = var_2271cae;
    while (isdefined(self)) {
        n_cycle_time = randomfloatrange(2, 8);
        n_pulse_increment = (var_94af3e50 - var_2271cae) / n_cycle_time / n_increment;
        while (n_pulse < var_94af3e50 && isdefined(self)) {
            self mapshaderconstant(0, 0, "scriptVector0", 1, n_pulse, 0, 0);
            n_pulse += n_pulse_increment;
            wait n_increment;
        }
        n_cycle_time = randomfloatrange(2, 8);
        n_pulse_increment = (var_94af3e50 - var_2271cae) / n_cycle_time / n_increment;
        while (var_2271cae < n_pulse && isdefined(self)) {
            self mapshaderconstant(0, 0, "scriptVector0", 1, n_pulse, 0, 0);
            n_pulse -= n_pulse_increment;
            wait n_increment;
        }
    }
}

// Namespace zurich_util
// Params 7, eflags: 0x0
// Checksum 0xac9bcd1f, Offset: 0x50e8
// Size: 0xc4
function zurich_server_cam(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        s_align = struct::get("tag_align_coalescence_return_server");
        playmaincamxcam(localclientnum, "c_zur_20_01_plaza_1st_fight_it_shooting_cam", 0, "", "", s_align.origin, s_align.angles);
        return;
    }
    stopmaincamxcam(localclientnum);
}

// Namespace zurich_util
// Params 7, eflags: 0x0
// Checksum 0x6f45a5d9, Offset: 0x51b8
// Size: 0x84
function function_70a9fa32(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        self thread postfx::playpostfxbundle("pstfx_blood_transition");
        return;
    }
    self thread postfx::playpostfxbundle("pstfx_blood_t_out");
}

// Namespace zurich_util
// Params 7, eflags: 0x0
// Checksum 0xce218a76, Offset: 0x5248
// Size: 0x6e
function function_33714f9b(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        self thread function_1cb0f58c(localclientnum);
        return;
    }
    self notify(#"disable_breath_fx");
}

// Namespace zurich_util
// Params 1, eflags: 0x0
// Checksum 0x6a7deac6, Offset: 0x52c0
// Size: 0x78
function function_1cb0f58c(localclientnum) {
    self endon(#"disable_breath_fx");
    self endon(#"entityshutdown");
    while (true) {
        playfxontag(localclientnum, level._effect["hero_cold_breath"], self, "j_head");
        wait randomintrange(6, 8);
    }
}

// Namespace zurich_util
// Params 7, eflags: 0x0
// Checksum 0xee9b3bcb, Offset: 0x5340
// Size: 0x134
function postfx_hallucinations(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self endon(#"entityshutdown");
    if (newval == 1) {
        self playsound(0, "evt_dni_interrupt");
        self thread postfx::playpostfxbundle("pstfx_dni_screen_futz_short");
        wait 0.5;
        self thread postfx::exitpostfxbundle();
        wait 0.3;
        self thread postfx::playpostfxbundle("pstfx_raven_loop");
        wait 0.5;
        self playsound(0, "evt_dni_interrupt");
        self thread postfx::exitpostfxbundle();
    }
}

// Namespace zurich_util
// Params 7, eflags: 0x0
// Checksum 0xe725e3f2, Offset: 0x5480
// Size: 0x114
function raven_hallucinations(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self endon(#"entityshutdown");
    if (newval) {
        self thread function_b5adc0ad(localclientnum);
        self thread postfx::playpostfxbundle("pstfx_dni_screen_futz_short");
        wait 0.5;
        self thread postfx::exitpostfxbundle();
        return;
    }
    self notify(#"hash_5ca6609a");
    wait 1.5;
    self thread postfx::playpostfxbundle("pstfx_dni_screen_futz_short");
    wait 0.15;
    self thread postfx::exitpostfxbundle();
}

// Namespace zurich_util
// Params 1, eflags: 0x0
// Checksum 0x4061ad7c, Offset: 0x55a0
// Size: 0x68
function function_b5adc0ad(localclientnum) {
    self endon(#"entityshutdown");
    self endon(#"hash_5ca6609a");
    while (true) {
        playfxoncamera(localclientnum, level._effect["raven_hallucination_fx"], (0, 0, 0), (1, 0, 0), (0, 0, 1));
        wait 0.05;
    }
}

// Namespace zurich_util
// Params 7, eflags: 0x0
// Checksum 0x61affa11, Offset: 0x5610
// Size: 0x7c
function raven_fade_out(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self endon(#"entityshutdown");
    if (newval) {
        playfxontag(localclientnum, level._effect["raven_fade_out_fx"], self, "j_spine_2");
    }
}

// Namespace zurich_util
// Params 7, eflags: 0x0
// Checksum 0x3d7fa06a, Offset: 0x5698
// Size: 0x94
function quadtank_raven_explosion(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        playfxontag(localclientnum, level._effect["quadtank_explosion_fx"], self, "tag_origin");
        self playsound(0, "veh_quadtank_crowsplosion");
    }
}

