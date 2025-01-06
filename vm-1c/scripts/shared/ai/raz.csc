#using scripts/shared/ai_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/postfx_shared;

#using_animtree("generic");

#namespace raz;

// Namespace raz
// Params 0, eflags: 0x2
// Checksum 0xec9cc4c9, Offset: 0x828
// Size: 0x2fc
function autoexec main() {
    clientfield::register("scriptmover", "raz_detonate_ground_torpedo", 12000, 1, "int", &namespace_18051440::function_c863523a, 0, 0);
    clientfield::register("scriptmover", "raz_torpedo_play_fx_on_self", 12000, 1, "int", &namespace_18051440::function_630145e6, 0, 0);
    clientfield::register("scriptmover", "raz_torpedo_play_trail", 12000, 1, "counter", &namespace_18051440::function_758ead37, 0, 0);
    clientfield::register("actor", "raz_detach_gun", 12000, 1, "int", &namespace_18051440::function_5e763aa7, 0, 0);
    clientfield::register("actor", "raz_gun_weakpoint_hit", 12000, 1, "counter", &namespace_18051440::function_77178dcd, 0, 0);
    clientfield::register("actor", "raz_detach_helmet", 12000, 1, "int", &namespace_18051440::function_e4d9298e, 0, 0);
    clientfield::register("actor", "raz_detach_chest_armor", 12000, 1, "int", &namespace_18051440::function_72baa781, 0, 0);
    clientfield::register("actor", "raz_detach_l_shoulder_armor", 12000, 1, "int", &namespace_18051440::function_d9d44375, 0, 0);
    clientfield::register("actor", "raz_detach_r_thigh_armor", 12000, 1, "int", &namespace_18051440::function_7528da2a, 0, 0);
    clientfield::register("actor", "raz_detach_l_thigh_armor", 12000, 1, "int", &namespace_18051440::function_714df297, 0, 0);
    ai::add_archetype_spawn_function("raz", &namespace_18051440::function_7d543cc5);
}

// Namespace raz
// Params 0, eflags: 0x2
// Checksum 0xf7860abd, Offset: 0xb30
// Size: 0x70e
function autoexec precache() {
    level._effect["fx_mech_foot_step"] = "dlc1/castle/fx_mech_foot_step";
    level._effect["fx_raz_mc_shockwave_projectile_impact"] = "dlc3/stalingrad/fx_raz_mc_shockwave_projectile_impact";
    level._effect["fx_bul_impact_concrete_xtreme"] = "impacts/fx_bul_impact_concrete_xtreme";
    level._effect["fx_raz_mc_shockwave_projectile"] = "dlc3/stalingrad/fx_raz_mc_shockwave_projectile";
    level._effect["fx_raz_dest_weak_point_exp"] = "dlc3/stalingrad/fx_raz_dest_weak_point_exp";
    level._effect["fx_raz_dest_weak_point_sparking_loop"] = "dlc3/stalingrad/fx_raz_dest_weak_point_sparking_loop";
    level._effect["fx_raz_dmg_weak_point"] = "dlc3/stalingrad/fx_raz_dmg_weak_point";
    level._effect["fx_raz_dest_weak_point_exp_generic"] = "dlc3/stalingrad/fx_raz_dest_weak_point_exp_generic";
    level.var_14a72821 = [];
    if (!isdefined(level.var_14a72821)) {
        level.var_14a72821 = [];
    } else if (!isarray(level.var_14a72821)) {
        level.var_14a72821 = array(level.var_14a72821);
    }
    level.var_14a72821[level.var_14a72821.size] = "vox_mang_mangler_taunt_0";
    if (!isdefined(level.var_14a72821)) {
        level.var_14a72821 = [];
    } else if (!isarray(level.var_14a72821)) {
        level.var_14a72821 = array(level.var_14a72821);
    }
    level.var_14a72821[level.var_14a72821.size] = "vox_mang_mangler_taunt_1";
    if (!isdefined(level.var_14a72821)) {
        level.var_14a72821 = [];
    } else if (!isarray(level.var_14a72821)) {
        level.var_14a72821 = array(level.var_14a72821);
    }
    level.var_14a72821[level.var_14a72821.size] = "vox_mang_mangler_taunt_2";
    if (!isdefined(level.var_14a72821)) {
        level.var_14a72821 = [];
    } else if (!isarray(level.var_14a72821)) {
        level.var_14a72821 = array(level.var_14a72821);
    }
    level.var_14a72821[level.var_14a72821.size] = "vox_mang_mangler_taunt_3";
    if (!isdefined(level.var_14a72821)) {
        level.var_14a72821 = [];
    } else if (!isarray(level.var_14a72821)) {
        level.var_14a72821 = array(level.var_14a72821);
    }
    level.var_14a72821[level.var_14a72821.size] = "vox_mang_mangler_taunt_4";
    if (!isdefined(level.var_14a72821)) {
        level.var_14a72821 = [];
    } else if (!isarray(level.var_14a72821)) {
        level.var_14a72821 = array(level.var_14a72821);
    }
    level.var_14a72821[level.var_14a72821.size] = "vox_mang_mangler_taunt_5";
    if (!isdefined(level.var_14a72821)) {
        level.var_14a72821 = [];
    } else if (!isarray(level.var_14a72821)) {
        level.var_14a72821 = array(level.var_14a72821);
    }
    level.var_14a72821[level.var_14a72821.size] = "vox_mang_mangler_taunt_6";
    if (!isdefined(level.var_14a72821)) {
        level.var_14a72821 = [];
    } else if (!isarray(level.var_14a72821)) {
        level.var_14a72821 = array(level.var_14a72821);
    }
    level.var_14a72821[level.var_14a72821.size] = "vox_mang_mangler_taunt_7";
    if (!isdefined(level.var_14a72821)) {
        level.var_14a72821 = [];
    } else if (!isarray(level.var_14a72821)) {
        level.var_14a72821 = array(level.var_14a72821);
    }
    level.var_14a72821[level.var_14a72821.size] = "vox_mang_mangler_taunt_8";
    if (!isdefined(level.var_14a72821)) {
        level.var_14a72821 = [];
    } else if (!isarray(level.var_14a72821)) {
        level.var_14a72821 = array(level.var_14a72821);
    }
    level.var_14a72821[level.var_14a72821.size] = "vox_mang_mangler_taunt_9";
    if (!isdefined(level.var_14a72821)) {
        level.var_14a72821 = [];
    } else if (!isarray(level.var_14a72821)) {
        level.var_14a72821 = array(level.var_14a72821);
    }
    level.var_14a72821[level.var_14a72821.size] = "vox_mang_mangler_taunt_10";
    if (!isdefined(level.var_14a72821)) {
        level.var_14a72821 = [];
    } else if (!isarray(level.var_14a72821)) {
        level.var_14a72821 = array(level.var_14a72821);
    }
    level.var_14a72821[level.var_14a72821.size] = "vox_mang_mangler_taunt_11";
    if (!isdefined(level.var_14a72821)) {
        level.var_14a72821 = [];
    } else if (!isarray(level.var_14a72821)) {
        level.var_14a72821 = array(level.var_14a72821);
    }
    level.var_14a72821[level.var_14a72821.size] = "vox_mang_mangler_taunt_12";
    if (!isdefined(level.var_14a72821)) {
        level.var_14a72821 = [];
    } else if (!isarray(level.var_14a72821)) {
        level.var_14a72821 = array(level.var_14a72821);
    }
    level.var_14a72821[level.var_14a72821.size] = "vox_mang_mangler_taunt_13";
}

#namespace namespace_18051440;

// Namespace namespace_18051440
// Params 1, eflags: 0x4
// Checksum 0xcb1b6099, Offset: 0x1248
// Size: 0x74
function private function_7d543cc5(localclientnum) {
    level._footstepcbfuncs[self.archetype] = &function_50a63da9;
    self thread function_568564ac(localclientnum);
    self thread function_24f717d3(localclientnum);
    self thread function_641f53cd(localclientnum);
}

// Namespace namespace_18051440
// Params 1, eflags: 0x4
// Checksum 0xfcac9bef, Offset: 0x12c8
// Size: 0x88
function private function_568564ac(localclientnum) {
    self endon(#"death");
    while (isdefined(self)) {
        self waittill(#"lights_on");
        self mapshaderconstant(localclientnum, 0, "scriptVector3", 0, 1, 1);
        self waittill(#"lights_off");
        self mapshaderconstant(localclientnum, 0, "scriptVector3", 0, 0, 0);
    }
}

// Namespace namespace_18051440
// Params 1, eflags: 0x4
// Checksum 0x47b95dfe, Offset: 0x1358
// Size: 0x70
function private function_24f717d3(localclientnum) {
    self endon(#"death");
    while (isdefined(self)) {
        self waittill(#"roar");
        self playsound(localclientnum, "vox_raz_exert_enrage", self gettagorigin("tag_eye"));
    }
}

// Namespace namespace_18051440
// Params 1, eflags: 0x4
// Checksum 0x9a291190, Offset: 0x13d0
// Size: 0x100
function private function_641f53cd(localclientnum) {
    self endon(#"hash_72520958");
    self thread function_da40a496(localclientnum);
    while (isdefined(self)) {
        var_77a21079 = randomintrange(5, 12);
        wait var_77a21079;
        if (isdefined(level.var_6f29d418) && level.var_6f29d418) {
            continue;
        }
        if (isdefined(self)) {
            var_1a1bb32e = level.var_14a72821[randomint(level.var_14a72821.size)];
            self.var_7ffceb49 = self playsound(localclientnum, var_1a1bb32e, self gettagorigin("tag_eye"));
        }
    }
}

// Namespace namespace_18051440
// Params 1, eflags: 0x4
// Checksum 0x913d0257, Offset: 0x14d8
// Size: 0x3c
function private function_da40a496(localclientnum) {
    self waittill(#"hash_72520958");
    if (isdefined(self.var_7ffceb49)) {
        stopsound(self.var_7ffceb49);
    }
}

// Namespace namespace_18051440
// Params 5, eflags: 0x0
// Checksum 0xac242e75, Offset: 0x1520
// Size: 0x238
function function_50a63da9(localclientnum, pos, surface, notetrack, bone) {
    e_player = getlocalplayer(localclientnum);
    n_dist = distancesquared(pos, e_player.origin);
    var_1ca36de2 = 160000;
    if (var_1ca36de2 > 0) {
        n_scale = (var_1ca36de2 - n_dist) / var_1ca36de2;
    } else {
        return;
    }
    if (n_scale > 1 || n_scale < 0) {
        return;
    }
    if (n_scale <= 0.01) {
        return;
    }
    var_b8c8da0d = n_scale * 0.1;
    if (var_b8c8da0d > 0.01) {
        e_player earthquake(var_b8c8da0d, 0.1, pos, n_dist);
    }
    if (n_scale <= 1 && n_scale > 0.8) {
        e_player playrumbleonentity(localclientnum, "damage_heavy");
    } else if (n_scale <= 0.8 && n_scale > 0.4) {
        e_player playrumbleonentity(localclientnum, "damage_light");
    } else {
        e_player playrumbleonentity(localclientnum, "reload_small");
    }
    fx = playfxontag(localclientnum, level._effect["fx_mech_foot_step"], self, bone);
}

// Namespace namespace_18051440
// Params 7, eflags: 0x4
// Checksum 0x6e2c6bb9, Offset: 0x1760
// Size: 0x78
function private function_c863523a(localclientnum, oldvalue, newvalue, bnewent, binitialsnap, fieldname, wasdemojump) {
    fx = playfx(localclientnum, level._effect["fx_raz_mc_shockwave_projectile_impact"], self.origin);
}

// Namespace namespace_18051440
// Params 7, eflags: 0x4
// Checksum 0xd277068f, Offset: 0x17e0
// Size: 0x78
function private function_758ead37(localclientnum, oldvalue, newvalue, bnewent, binitialsnap, fieldname, wasdemojump) {
    fx = playfx(localclientnum, level._effect["fx_bul_impact_concrete_xtreme"], self.origin);
}

// Namespace namespace_18051440
// Params 7, eflags: 0x4
// Checksum 0x8b518e65, Offset: 0x1860
// Size: 0xd4
function private function_630145e6(localclientnum, oldvalue, newvalue, bnewent, binitialsnap, fieldname, wasdemojump) {
    if (newvalue == 0 && isdefined(self.var_3b99e5c2)) {
        stopfx(localclientnum, self.var_3b99e5c2);
        self.var_3b99e5c2 = undefined;
    }
    if (newvalue == 1 && !isdefined(self.var_3b99e5c2)) {
        self.var_3b99e5c2 = playfxontag(localclientnum, level._effect["fx_raz_mc_shockwave_projectile"], self, "tag_origin");
    }
}

// Namespace namespace_18051440
// Params 7, eflags: 0x4
// Checksum 0xb79bafba, Offset: 0x1940
// Size: 0x1bc
function private function_776cfd62(localclientnum, model, pos, angles, hitpos, var_9474878, direction) {
    if (!isdefined(var_9474878)) {
        var_9474878 = 1;
    }
    if (!isdefined(pos) || !isdefined(angles)) {
        return;
    }
    velocity = self getvelocity();
    var_829e8366 = vectornormalize(velocity);
    var_b02fd9f = length(velocity);
    if (isdefined(direction) && direction == "back") {
        launch_dir = anglestoforward(self.angles) * -1;
    } else {
        launch_dir = anglestoforward(self.angles);
    }
    var_b02fd9f *= 0.1;
    if (var_b02fd9f < 10) {
        var_b02fd9f = 10;
    }
    launch_dir = launch_dir * 0.5 + var_829e8366 * 0.5;
    launch_dir *= var_b02fd9f;
    createdynentandlaunch(localclientnum, model, pos, angles, self.origin, launch_dir * var_9474878);
}

// Namespace namespace_18051440
// Params 7, eflags: 0x4
// Checksum 0x5a69a0a4, Offset: 0x1b08
// Size: 0x1dc
function private function_5e763aa7(localclientnum, oldvalue, newvalue, bnewent, binitialsnap, fieldname, wasdemojump) {
    fx = playfxontag(localclientnum, level._effect["fx_raz_dest_weak_point_exp"], self, "TAG_FX_Shoulder_RI_GIB");
    var_fea1fc22 = self gettagorigin("j_elbow_ri");
    var_3bc109c = self gettagangles("j_elbow_ri");
    var_593e57b2 = self gettagorigin("j_shouldertwist_ri_attach");
    var_dddc6e2c = self gettagangles("j_shouldertwist_ri_attach");
    dynent = function_776cfd62(localclientnum, "c_zom_dlc3_raz_s_armcannon", var_fea1fc22, var_3bc109c, self.origin, 1.3, "back");
    dynent = function_776cfd62(localclientnum, "c_zom_dlc3_raz_s_cannonpowercore", var_593e57b2, var_dddc6e2c, self.origin, 1, "back");
    self playsound(localclientnum, "zmb_raz_gun_explo", self gettagorigin("tag_eye"));
}

// Namespace namespace_18051440
// Params 7, eflags: 0x4
// Checksum 0xfa8d97a2, Offset: 0x1cf0
// Size: 0x78
function private function_77178dcd(localclientnum, oldvalue, newvalue, bnewent, binitialsnap, fieldname, wasdemojump) {
    fx = playfxontag(localclientnum, level._effect["fx_raz_dmg_weak_point"], self, "j_shoulder_ri");
}

// Namespace namespace_18051440
// Params 7, eflags: 0x0
// Checksum 0x118c2a4f, Offset: 0x1d70
// Size: 0x174
function function_e4d9298e(localclientnum, oldvalue, newvalue, bnewent, binitialsnap, fieldname, wasdemojump) {
    pos = self gettagorigin("j_elbow_ri");
    ang = self gettagangles("j_elbow_ri");
    fx = playfxontag(localclientnum, level._effect["fx_raz_dest_weak_point_exp_generic"], self, "TAG_FX_Helmet");
    dynent = function_776cfd62(localclientnum, "c_zom_dlc3_raz_s_helmet", pos, ang, self.origin, 1, "back");
    thread applynewfaceanim(localclientnum, "ai_zm_dlc3_face_armored_zombie_generic_idle_1");
    self playsound(localclientnum, "zmb_raz_armor_explo", self gettagorigin("tag_eye"));
}

// Namespace namespace_18051440
// Params 7, eflags: 0x0
// Checksum 0xa08c6597, Offset: 0x1ef0
// Size: 0x144
function function_72baa781(localclientnum, oldvalue, newvalue, bnewent, binitialsnap, fieldname, wasdemojump) {
    pos = self gettagorigin("j_spine4_attach");
    ang = self gettagangles("j_spine4_attach");
    fx = playfxontag(localclientnum, level._effect["fx_raz_dest_weak_point_exp_generic"], self, "TAG_FX_ChestPlate");
    dynent = function_776cfd62(localclientnum, "c_zom_dlc3_raz_s_chestplate", pos, ang, self.origin);
    self playsound(localclientnum, "zmb_raz_armor_explo", self gettagorigin("tag_eye"));
}

// Namespace namespace_18051440
// Params 7, eflags: 0x0
// Checksum 0x83b541f4, Offset: 0x2040
// Size: 0x144
function function_d9d44375(localclientnum, oldvalue, newvalue, bnewent, binitialsnap, fieldname, wasdemojump) {
    pos = self gettagorigin("j_shouldertwist_le_attach");
    ang = self gettagangles("j_shouldertwist_le_attach");
    fx = playfxontag(localclientnum, level._effect["fx_raz_dest_weak_point_exp_generic"], self, "TAG_FX_Shoulder_LE");
    dynent = function_776cfd62(localclientnum, "c_zom_dlc3_raz_s_leftshoulderpad", pos, ang, self.origin);
    self playsound(localclientnum, "zmb_raz_armor_explo", self gettagorigin("tag_eye"));
}

// Namespace namespace_18051440
// Params 7, eflags: 0x0
// Checksum 0xc40d7c52, Offset: 0x2190
// Size: 0x144
function function_714df297(localclientnum, oldvalue, newvalue, bnewent, binitialsnap, fieldname, wasdemojump) {
    pos = self gettagorigin("j_hiptwist_le_attach");
    ang = self gettagangles("j_hiptwist_le_attach");
    fx = playfxontag(localclientnum, level._effect["fx_raz_dest_weak_point_exp_generic"], self, "TAG_FX_Thigh_LE");
    dynent = function_776cfd62(localclientnum, "c_zom_dlc3_raz_s_leftthighpad", pos, ang, self.origin);
    self playsound(localclientnum, "zmb_raz_armor_explo", self gettagorigin("tag_eye"));
}

// Namespace namespace_18051440
// Params 7, eflags: 0x0
// Checksum 0x4e4b077d, Offset: 0x22e0
// Size: 0x144
function function_7528da2a(localclientnum, oldvalue, newvalue, bnewent, binitialsnap, fieldname, wasdemojump) {
    pos = self gettagorigin("j_hiptwist_ri_attach");
    ang = self gettagangles("j_hiptwist_ri_attach");
    fx = playfxontag(localclientnum, level._effect["fx_raz_dest_weak_point_exp_generic"], self, "TAG_FX_Thigh_RI");
    dynent = function_776cfd62(localclientnum, "c_zom_dlc3_raz_s_rightthighpad", pos, ang, self.origin);
    self playsound(localclientnum, "zmb_raz_armor_explo", self gettagorigin("tag_eye"));
}

// Namespace namespace_18051440
// Params 2, eflags: 0x4
// Checksum 0x76a7bab8, Offset: 0x2430
// Size: 0xd4
function private applynewfaceanim(localclientnum, animation) {
    self endon(#"disconnect");
    clearcurrentfacialanim(localclientnum);
    if (isdefined(animation)) {
        self._currentfaceanim = animation;
        if (self hasdobj(localclientnum) && self hasanimtree()) {
            self setflaggedanimknob("ai_secondary_facial_anim", animation, 1, 0.1, 1);
            self waittill(#"hash_72520958");
            clearcurrentfacialanim(localclientnum);
        }
    }
}

// Namespace namespace_18051440
// Params 1, eflags: 0x4
// Checksum 0xdaa067e6, Offset: 0x2510
// Size: 0x7e
function private clearcurrentfacialanim(localclientnum) {
    if (isdefined(self._currentfaceanim) && self hasdobj(localclientnum) && self hasanimtree()) {
        self clearanim(self._currentfaceanim, 0.2);
    }
    self._currentfaceanim = undefined;
}

