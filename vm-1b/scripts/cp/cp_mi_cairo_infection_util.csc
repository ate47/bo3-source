#using scripts/codescripts/struct;
#using scripts/cp/_load;
#using scripts/shared/clientfield_shared;
#using scripts/shared/duplicaterender_mgr;
#using scripts/shared/postfx_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;

#namespace infection_util;

// Namespace infection_util
// Params 0, eflags: 0x2
// Checksum 0x925456a1, Offset: 0xab0
// Size: 0x2a
function autoexec __init__sytem__() {
    system::register("infection_util", &__init__, undefined, undefined);
}

// Namespace infection_util
// Params 0, eflags: 0x0
// Checksum 0x5befa148, Offset: 0xae8
// Size: 0x22
function __init__() {
    init_fx();
    init_clientfields();
}

// Namespace infection_util
// Params 0, eflags: 0x0
// Checksum 0x928c531c, Offset: 0xb18
// Size: 0x1cb
function init_fx() {
    level._effect["ai_dni_rez_in_arm_left"] = "player/fx_ai_dni_rez_in_arm_left_dirty";
    level._effect["ai_dni_rez_in_arm_right"] = "player/fx_ai_dni_rez_in_arm_right_dirty";
    level._effect["ai_dni_rez_in_head"] = "player/fx_ai_dni_rez_in_head_dirty";
    level._effect["ai_dni_rez_in_hip_left"] = "player/fx_ai_dni_rez_in_hip_left_dirty";
    level._effect["ai_dni_rez_in_hip_right"] = "player/fx_ai_dni_rez_in_hip_right_dirty";
    level._effect["ai_dni_rez_in_leg_left"] = "player/fx_ai_dni_rez_in_leg_left_dirty";
    level._effect["ai_dni_rez_in_leg_right"] = "player/fx_ai_dni_rez_in_leg_right_dirty";
    level._effect["ai_dni_rez_in_torso"] = "player/fx_ai_dni_rez_in_torso_dirty";
    level._effect["ai_dni_rez_in_waist"] = "player/fx_ai_dni_rez_in_waist_dirty";
    level._effect["ai_dni_rez_out_arm_left"] = "player/fx_ai_dni_rez_out_arm_left_dirty";
    level._effect["ai_dni_rez_out_arm_right"] = "player/fx_ai_dni_rez_out_arm_right_dirty";
    level._effect["ai_dni_rez_out_head"] = "player/fx_ai_dni_rez_out_head_dirty";
    level._effect["ai_dni_rez_out_hip_left"] = "player/fx_ai_dni_rez_out_hip_left_dirty";
    level._effect["ai_dni_rez_out_hip_right"] = "player/fx_ai_dni_rez_out_hip_right_dirty";
    level._effect["ai_dni_rez_out_leg_left"] = "player/fx_ai_dni_rez_out_leg_left_dirty";
    level._effect["ai_dni_rez_out_leg_right"] = "player/fx_ai_dni_rez_out_leg_right_dirty";
    level._effect["ai_dni_rez_out_torso"] = "player/fx_ai_dni_rez_out_torso_dirty";
    level._effect["ai_dni_rez_out_waist"] = "player/fx_ai_dni_rez_out_waist_dirty";
    level._effect["ai_dni_rez_out_wolf_dirty"] = "player/fx_ai_dni_rez_out_wolf_dirty";
}

// Namespace infection_util
// Params 0, eflags: 0x0
// Checksum 0x730b1f86, Offset: 0xcf0
// Size: 0x372
function init_clientfields() {
    clientfield::register("toplayer", "snow_fx", 1, 2, "int", &function_baff6dde, 0, 0);
    clientfield::register("actor", "sarah_objective_light", 1, 1, "int", &function_39ba15ad, 0, 0);
    clientfield::register("actor", "sarah_body_light", 1, 1, "int", &function_206d5db6, 0, 0);
    clientfield::register("actor", "reverse_arrival_snow_fx", 1, 1, "int", &function_e5419867, 0, 0);
    clientfield::register("actor", "reverse_arrival_dmg_fx", 1, 1, "int", &function_f5a73f1e, 0, 0);
    clientfield::register("actor", "exploding_ai_deaths", 1, 1, "int", &function_b3f0d569, 0, 0);
    clientfield::register("actor", "reverse_arrival_explosion_fx", 1, 1, "int", &function_a3b6a74a, 0, 0);
    clientfield::register("allplayers", "player_spawn_fx", 1, 1, "int", &function_aebc5072, 0, 0);
    clientfield::register("toplayer", "stop_post_fx", 1, 1, "counter", &function_7bd51e31, 0, 0);
    clientfield::register("actor", "ai_dni_rez_in", 1, 1, "int", &function_207ed741, 0, 0);
    clientfield::register("actor", "ai_dni_rez_out", 1, 1, "counter", &function_5ae9b898, 0, 0);
    clientfield::register("toplayer", "postfx_dni_interrupt", 1, 1, "counter", &postfx_dni_interrupt, 0, 0);
    clientfield::register("toplayer", "postfx_futz", 1, 1, "counter", &postfx_futz, 0, 0);
    clientfield::register("actor", "sarah_camo_shader", 1, 3, "int", &function_f532bd65, 0, 1);
    duplicate_render::set_dr_filter_framebuffer("active_camo", 90, "actor_camo_on", "", 0, "mc/hud_outline_predator_camo_active_inf", 1);
    duplicate_render::set_dr_filter_framebuffer("active_camo_flicker", 80, "actor_camo_flicker", "", 0, "mc/hud_outline_predator_camo_disruption_inf", 1);
}

// Namespace infection_util
// Params 7, eflags: 0x0
// Checksum 0xe58a220c, Offset: 0x1070
// Size: 0x62
function function_e5419867(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval == 1) {
        self function_88a10e85(localclientnum, "reverse_snow_fx", "weather/fx_snow_impact_body_reverse_infection");
    }
}

// Namespace infection_util
// Params 7, eflags: 0x0
// Checksum 0xcacbb5df, Offset: 0x10e0
// Size: 0x9a
function function_f5a73f1e(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval == 1) {
        self function_88a10e85(localclientnum, "reverse_blood_fx", "impacts/fx_bul_impact_blood_body_fatal_reverse", "tag_eye");
        return;
    }
    self function_88a10e85(localclientnum, "reverse_blood_fx", "impacts/fx_bul_impact_blood_body_fatal_reverse", "j_spine4");
}

// Namespace infection_util
// Params 7, eflags: 0x0
// Checksum 0xa49965f, Offset: 0x1188
// Size: 0x92
function function_a3b6a74a(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        self function_ea0e7704(localclientnum, "reverse_explosion_arrival", "explosions/fx_exp_mortar_snow_reverse", 1, self.origin);
        return;
    }
    self function_be968491(localclientnum, "reverse_explosion_arrival", "explosions/fx_exp_mortar_snow_reverse");
}

// Namespace infection_util
// Params 7, eflags: 0x0
// Checksum 0x81db8d03, Offset: 0x1228
// Size: 0x10a
function function_b3f0d569(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval == 1) {
        pos = self gettagorigin("j_spine4");
        angles = self gettagangles("j_spine4");
        fxobj = util::spawn_model(localclientnum, "tag_origin", pos, angles);
        fxobj function_88a10e85(localclientnum, "exploding_death_fx", "explosions/fx_exp_torso_blood_infection", "tag_origin");
        fxobj playsound(0, "evt_ai_explode");
        wait 6;
        fxobj delete();
    }
}

// Namespace infection_util
// Params 7, eflags: 0x0
// Checksum 0x28f0988f, Offset: 0x1340
// Size: 0x14b
function function_39ba15ad(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (!isdefined(level.var_c1d1c557)) {
        level.var_c1d1c557 = util::spawn_model(localclientnum, "tag_origin", self.origin, self.angles);
    }
    if (newval) {
        if (self.team != "allies") {
            return;
        }
        level thread function_cdbbde70(self, level.var_c1d1c557);
        level.var_c1d1c557 function_88a10e85(localclientnum, "objective_light", "light/fx_beam_sarah_marker_bright", "tag_origin");
        self function_88a10e85(localclientnum, "objective_light", "player/fx_ai_sarah_marker_body", "J_MainRoot");
        return;
    }
    level.var_c1d1c557 function_be968491(localclientnum, "objective_light", "light/fx_beam_sarah_marker_bright");
    self function_be968491(localclientnum, "objective_light", "player/fx_ai_sarah_marker_body");
    level notify(#"hash_f9e936e2");
}

// Namespace infection_util
// Params 2, eflags: 0x0
// Checksum 0x3cf2279f, Offset: 0x1498
// Size: 0x99
function function_cdbbde70(var_42189297, ground_ent) {
    level notify(#"hash_f9e936e2");
    ground_ent endon(#"death");
    level endon(#"hash_f9e936e2");
    while (true) {
        ground_ent.origin = bullettrace(var_42189297.origin, var_42189297.origin + (0, 0, -100000), 0, var_42189297)["position"];
        ground_ent.angles = (0, var_42189297.angles[1], 0);
        wait 0.016;
    }
}

// Namespace infection_util
// Params 7, eflags: 0x0
// Checksum 0xc187a251, Offset: 0x1540
// Size: 0xa2
function function_206d5db6(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        if (self.team != "allies") {
            return;
        }
        self function_88a10e85(localclientnum, "objective_light", "player/fx_ai_sarah_marker_body", "J_MainRoot");
        return;
    }
    self function_be968491(localclientnum, "objective_light", "player/fx_ai_sarah_marker_body");
}

// Namespace infection_util
// Params 7, eflags: 0x0
// Checksum 0x5dc5f871, Offset: 0x15f0
// Size: 0xfa
function function_baff6dde(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval == 1) {
        self function_88a10e85(localclientnum, "snow_fx", "weather/fx_snow_player_loop", "none");
        return;
    }
    if (newval == 2) {
        self function_88a10e85(localclientnum, "snow_fx", "weather/fx_snow_player_loop_reverse", "none");
        return;
    }
    if (newval == 3) {
        self function_88a10e85(localclientnum, "snow_fx", "weather/fx_snow_player_loop_reverse_sideways", "none");
        return;
    }
    self function_400e6e82(localclientnum, "snow_fx", 0);
}

// Namespace infection_util
// Params 3, eflags: 0x0
// Checksum 0xf09ec68f, Offset: 0x16f8
// Size: 0xc0
function function_be968491(localclientnum, str_type, str_fx) {
    if (!isdefined(self.var_62bb476b)) {
        self.var_62bb476b = [];
    }
    if (!isdefined(self.var_62bb476b[localclientnum])) {
        self.var_62bb476b[localclientnum] = [];
    }
    if (!isdefined(self.var_62bb476b[localclientnum][str_type])) {
        self.var_62bb476b[localclientnum][str_type] = [];
    }
    if (isdefined(str_fx) && isdefined(self.var_62bb476b[localclientnum][str_type][str_fx])) {
        n_fx_id = self.var_62bb476b[localclientnum][str_type][str_fx];
        deletefx(localclientnum, n_fx_id, 0);
        self.var_62bb476b[localclientnum][str_type][str_fx] = undefined;
    }
}

// Namespace infection_util
// Params 3, eflags: 0x0
// Checksum 0x9d7608bf, Offset: 0x17c0
// Size: 0xcb
function function_400e6e82(localclientnum, str_type, var_91599cfb) {
    if (!isdefined(var_91599cfb)) {
        var_91599cfb = 1;
    }
    if (isdefined(self.var_62bb476b) && isdefined(self.var_62bb476b[localclientnum]) && isdefined(self.var_62bb476b[localclientnum][str_type])) {
        a_keys = getarraykeys(self.var_62bb476b[localclientnum][str_type]);
        for (i = 0; i < a_keys.size; i++) {
            deletefx(localclientnum, self.var_62bb476b[localclientnum][str_type][a_keys[i]], var_91599cfb);
            self.var_62bb476b[localclientnum][str_type][a_keys[i]] = undefined;
        }
    }
}

// Namespace infection_util
// Params 5, eflags: 0x0
// Checksum 0x73ed7b45, Offset: 0x1898
// Size: 0xad
function function_88a10e85(localclientnum, str_type, str_fx, str_tag, var_cffd17f8) {
    if (!isdefined(str_tag)) {
        str_tag = "tag_origin";
    }
    if (!isdefined(var_cffd17f8)) {
        var_cffd17f8 = 1;
    }
    self function_be968491(localclientnum, str_type, str_fx);
    if (var_cffd17f8) {
        self function_400e6e82(localclientnum, str_type, 0);
    }
    n_fx_id = playfxontag(localclientnum, str_fx, self, str_tag);
    self.var_62bb476b[localclientnum][str_type][str_fx] = n_fx_id;
}

// Namespace infection_util
// Params 7, eflags: 0x0
// Checksum 0x163c43ee, Offset: 0x1950
// Size: 0xed
function function_ea0e7704(localclientnum, str_type, str_fx, var_cffd17f8, v_pos, v_forward, v_up) {
    if (!isdefined(var_cffd17f8)) {
        var_cffd17f8 = 1;
    }
    self function_be968491(localclientnum, str_type, str_fx);
    if (var_cffd17f8) {
        self function_400e6e82(localclientnum, str_type, 0);
    }
    if (isdefined(v_forward) && isdefined(v_up)) {
        n_fx_id = playfx(localclientnum, str_fx, v_pos, v_forward, v_up);
    } else if (isdefined(v_forward)) {
        n_fx_id = playfx(localclientnum, str_fx, v_pos, v_forward);
    } else {
        n_fx_id = playfx(localclientnum, str_fx, v_pos);
    }
    self.var_62bb476b[localclientnum][str_type][str_fx] = n_fx_id;
}

// Namespace infection_util
// Params 7, eflags: 0x0
// Checksum 0x5320064c, Offset: 0x1a48
// Size: 0xa2
function function_aebc5072(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        self function_88a10e85(localclientnum, "objective_light", "light/fx_beam_friendly_flash_in_infection");
        self playsound(0, "evt_ai_teleport");
        return;
    }
    self function_be968491(localclientnum, "objective_light", "light/fx_beam_friendly_flash_in_infection");
}

// Namespace infection_util
// Params 7, eflags: 0x0
// Checksum 0xc6d7c446, Offset: 0x1af8
// Size: 0x62
function function_7bd51e31(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    player = getlocalplayer(localclientnum);
    player postfx::stoppostfxbundle();
}

// Namespace infection_util
// Params 7, eflags: 0x0
// Checksum 0x5b900fe2, Offset: 0x1b68
// Size: 0x5a
function postfx_dni_interrupt(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval == 1) {
        self postfx::playpostfxbundle("pstfx_dni_interrupt");
    }
}

// Namespace infection_util
// Params 7, eflags: 0x0
// Checksum 0x973e353e, Offset: 0x1bd0
// Size: 0x5a
function postfx_futz(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval == 1) {
        self postfx::playpostfxbundle("pstfx_dni_screen_futz");
    }
}

// Namespace infection_util
// Params 7, eflags: 0x0
// Checksum 0x47b8712e, Offset: 0x1c38
// Size: 0x7a
function function_f532bd65(local_client_num, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self duplicate_render::set_dr_flag("actor_camo_flicker", newval == 2);
    self duplicate_render::set_dr_flag("actor_camo_on", newval != 0);
    self duplicate_render::change_dr_flags(local_client_num);
}

// Namespace infection_util
// Params 7, eflags: 0x0
// Checksum 0xaa89ed9b, Offset: 0x1cc0
// Size: 0x212
function function_207ed741(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self playsound(0, "evt_ai_teleport");
    if (newval) {
        playfxontag(localclientnum, level._effect["ai_dni_rez_in_arm_left"], self, "j_elbow_le");
        playfxontag(localclientnum, level._effect["ai_dni_rez_in_arm_left"], self, "j_shoulder_le");
        playfxontag(localclientnum, level._effect["ai_dni_rez_in_arm_right"], self, "j_elbow_ri");
        playfxontag(localclientnum, level._effect["ai_dni_rez_in_arm_right"], self, "j_shoulder_ri");
        playfxontag(localclientnum, level._effect["ai_dni_rez_in_head"], self, "j_head");
        playfxontag(localclientnum, level._effect["ai_dni_rez_in_hip_left"], self, "j_hip_le");
        playfxontag(localclientnum, level._effect["ai_dni_rez_in_hip_right"], self, "j_hip_ri");
        playfxontag(localclientnum, level._effect["ai_dni_rez_in_leg_left"], self, "j_knee_le");
        playfxontag(localclientnum, level._effect["ai_dni_rez_in_leg_right"], self, "j_knee_ri");
        playfxontag(localclientnum, level._effect["ai_dni_rez_in_torso"], self, "j_spine4");
        playfxontag(localclientnum, level._effect["ai_dni_rez_in_waist"], self, "j_spinelower");
    }
}

// Namespace infection_util
// Params 7, eflags: 0x0
// Checksum 0x5e756993, Offset: 0x1ee0
// Size: 0x2ca
function function_5ae9b898(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self playsound(0, "evt_ai_explode");
    if (self.species === "zombie_dog") {
        playfxontag(localclientnum, level._effect["ai_dni_rez_out_wolf_dirty"], self, "j_head");
        playfxontag(localclientnum, level._effect["ai_dni_rez_out_wolf_dirty"], self, "j_mainroot");
        playfxontag(localclientnum, level._effect["ai_dni_rez_out_wolf_dirty"], self, "spine3_jnt");
        playfxontag(localclientnum, level._effect["ai_dni_rez_out_wolf_dirty"], self, "neck1_jnt");
        return;
    }
    playfxontag(localclientnum, level._effect["ai_dni_rez_out_arm_left"], self, "j_elbow_le");
    playfxontag(localclientnum, level._effect["ai_dni_rez_out_arm_left"], self, "j_shoulder_le");
    playfxontag(localclientnum, level._effect["ai_dni_rez_out_arm_right"], self, "j_elbow_ri");
    playfxontag(localclientnum, level._effect["ai_dni_rez_out_arm_right"], self, "j_shoulder_ri");
    playfxontag(localclientnum, level._effect["ai_dni_rez_out_head"], self, "j_head");
    playfxontag(localclientnum, level._effect["ai_dni_rez_out_hip_left"], self, "j_hip_le");
    playfxontag(localclientnum, level._effect["ai_dni_rez_out_hip_right"], self, "j_hip_ri");
    playfxontag(localclientnum, level._effect["ai_dni_rez_out_leg_left"], self, "j_knee_le");
    playfxontag(localclientnum, level._effect["ai_dni_rez_out_leg_right"], self, "j_knee_ri");
    playfxontag(localclientnum, level._effect["ai_dni_rez_out_torso"], self, "j_spine4");
    playfxontag(localclientnum, level._effect["ai_dni_rez_out_waist"], self, "j_spinelower");
}

