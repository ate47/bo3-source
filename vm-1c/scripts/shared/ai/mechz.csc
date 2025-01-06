#using scripts/shared/ai_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/postfx_shared;
#using scripts/shared/visionset_mgr_shared;

#namespace mechz;

// Namespace mechz
// Params 0, eflags: 0x2
// Checksum 0x5147f28b, Offset: 0x748
// Size: 0x3ae
function autoexec main() {
    clientfield::register("actor", "mechz_ft", 5000, 1, "int", &namespace_46498900::function_2fb5243, 0, 0);
    clientfield::register("actor", "mechz_faceplate_detached", 5000, 1, "int", &namespace_46498900::function_b6d242c2, 0, 0);
    clientfield::register("actor", "mechz_powercap_detached", 5000, 1, "int", &namespace_46498900::function_dcbbeee0, 0, 0);
    clientfield::register("actor", "mechz_claw_detached", 5000, 1, "int", &namespace_46498900::function_e3453e34, 0, 0);
    clientfield::register("actor", "mechz_115_gun_firing", 5000, 1, "int", &namespace_46498900::function_b942c9ec, 0, 0);
    clientfield::register("actor", "mechz_rknee_armor_detached", 5000, 1, "int", &namespace_46498900::function_dc89a738, 0, 0);
    clientfield::register("actor", "mechz_lknee_armor_detached", 5000, 1, "int", &namespace_46498900::function_c74d1856, 0, 0);
    clientfield::register("actor", "mechz_rshoulder_armor_detached", 5000, 1, "int", &namespace_46498900::function_7ba558f1, 0, 0);
    clientfield::register("actor", "mechz_lshoulder_armor_detached", 5000, 1, "int", &namespace_46498900::function_8bc31cd3, 0, 0);
    clientfield::register("actor", "mechz_headlamp_off", 5000, 2, "int", &namespace_46498900::mechz_headlamp_off, 0, 0);
    clientfield::register("actor", "mechz_face", 1, 3, "int", &namespace_46498900::function_62673bde, 0, 0);
    ai::add_archetype_spawn_function("mechz", &namespace_46498900::function_cda3f485);
    level.var_add93f1d = [];
    level.var_add93f1d[1] = "ai_face_zombie_generic_attack_1";
    level.var_add93f1d[2] = "ai_face_zombie_generic_death_1";
    level.var_add93f1d[3] = "ai_face_zombie_generic_idle_1";
    level.var_add93f1d[4] = "ai_face_zombie_generic_pain_1";
}

// Namespace mechz
// Params 0, eflags: 0x2
// Checksum 0xed11ccbe, Offset: 0xb00
// Size: 0x1de
function autoexec precache() {
    level._effect["fx_mech_wpn_flamethrower"] = "dlc1/castle/fx_mech_wpn_flamethrower";
    level._effect["fx_mech_dmg_armor_face"] = "dlc1/castle/fx_mech_dmg_armor_face";
    level._effect["fx_mech_dmg_armor"] = "dlc1/castle/fx_mech_dmg_armor";
    level._effect["fx_mech_dmg_armor"] = "dlc1/castle/fx_mech_dmg_armor";
    level._effect["fx_wpn_115_muz"] = "dlc1/castle/fx_wpn_115_muz";
    level._effect["fx_mech_dmg_armor"] = "dlc1/castle/fx_mech_dmg_armor";
    level._effect["fx_mech_dmg_armor"] = "dlc1/castle/fx_mech_dmg_armor";
    level._effect["fx_mech_dmg_armor"] = "dlc1/castle/fx_mech_dmg_armor";
    level._effect["fx_mech_dmg_armor"] = "dlc1/castle/fx_mech_dmg_armor";
    level._effect["fx_mech_head_light"] = "dlc1/castle/fx_mech_head_light";
    level._effect["fx_mech_dmg_sparks"] = "dlc1/castle/fx_mech_dmg_sparks";
    level._effect["fx_mech_dmg_knee_sparks"] = "dlc1/castle/fx_mech_dmg_knee_sparks";
    level._effect["fx_mech_dmg_sparks"] = "dlc1/castle/fx_mech_dmg_sparks";
    level._effect["fx_mech_foot_step"] = "dlc1/castle/fx_mech_foot_step";
    level._effect["fx_mech_light_dmg"] = "dlc1/castle/fx_mech_light_dmg";
    level._effect["fx_mech_foot_step_steam"] = "dlc1/castle/fx_mech_foot_step_steam";
    level._effect["fx_mech_dmg_body_light"] = "dlc1/castle/fx_mech_dmg_body_light";
}

#namespace namespace_46498900;

// Namespace namespace_46498900
// Params 1, eflags: 0x4
// Checksum 0xeb0eadeb, Offset: 0xce8
// Size: 0x88
function private function_cda3f485(localclientnum) {
    level._footstepcbfuncs[self.archetype] = &function_e2126c69;
    level thread function_f4421436(self);
    self.var_bf4b6a5a = playfxontag(localclientnum, level._effect["fx_mech_head_light"], self, "tag_headlamp_FX");
    self.var_70a8f1bf = 1;
}

// Namespace namespace_46498900
// Params 1, eflags: 0x0
// Checksum 0x47788208, Offset: 0xd78
// Size: 0x44
function function_f4421436(mechz) {
    wait 1;
    if (isdefined(mechz)) {
        mechz setsoundentcontext("movement", "normal");
    }
}

// Namespace namespace_46498900
// Params 5, eflags: 0x0
// Checksum 0xac5780da, Offset: 0xdc8
// Size: 0x2a8
function function_e2126c69(localclientnum, pos, surface, notetrack, bone) {
    e_player = getlocalplayer(localclientnum);
    n_dist = distancesquared(pos, e_player.origin);
    var_15d24742 = 1000000;
    if (var_15d24742 > 0) {
        n_scale = (var_15d24742 - n_dist) / var_15d24742;
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
        e_player playrumbleonentity(localclientnum, "shotgun_fire");
    } else if (n_scale <= 0.8 && n_scale > 0.4) {
        e_player playrumbleonentity(localclientnum, "damage_heavy");
    } else {
        e_player playrumbleonentity(localclientnum, "reload_small");
    }
    fx = playfxontag(localclientnum, level._effect["fx_mech_foot_step"], self, bone);
    if (bone == "j_ball_le") {
        var_d0075cb8 = "tag_foot_steam_le";
    } else {
        var_d0075cb8 = "tag_foot_steam_ri";
    }
    var_ada11270 = playfxontag(localclientnum, level._effect["fx_mech_foot_step_steam"], self, var_d0075cb8);
}

// Namespace namespace_46498900
// Params 7, eflags: 0x4
// Checksum 0x2c0ca02, Offset: 0x1078
// Size: 0x15e
function private function_2fb5243(localclientnum, oldvalue, newvalue, bnewent, binitialsnap, fieldname, wasdemojump) {
    switch (newvalue) {
    case 1:
        self.var_1dc1e3d3 = beamlaunch(localclientnum, self, "tag_flamethrower_fx", undefined, "none", "flamethrower_beam_3p_zm_mechz");
        self playsound(0, "wpn_flame_thrower_start_mechz");
        self.var_5c166b = self playloopsound("wpn_flame_thrower_loop_mechz");
        break;
    case 0:
        self notify(#"hash_174e63d7");
        if (isdefined(self.var_1dc1e3d3)) {
            beamkill(localclientnum, self.var_1dc1e3d3);
            self playsound(0, "wpn_flame_thrower_stop_mechz");
            self stoploopsound(self.var_5c166b);
        }
        break;
    }
}

// Namespace namespace_46498900
// Params 7, eflags: 0x0
// Checksum 0x98322f0d, Offset: 0x11e0
// Size: 0x16c
function function_b6d242c2(localclientnum, oldvalue, newvalue, bnewent, binitialsnap, fieldname, wasdemojump) {
    pos = self gettagorigin("j_faceplate");
    ang = self gettagangles("j_faceplate");
    velocity = self getvelocity();
    dynent = createdynentandlaunch(localclientnum, "c_zom_mech_faceplate", pos, ang, self.origin, velocity);
    playfxontag(localclientnum, level._effect["fx_mech_dmg_armor_face"], self, "j_faceplate");
    self setsoundentcontext("movement", "loud");
    self playsound(0, "zmb_ai_mechz_faceplate");
}

// Namespace namespace_46498900
// Params 7, eflags: 0x0
// Checksum 0xedc1d086, Offset: 0x1358
// Size: 0x17c
function function_dcbbeee0(localclientnum, oldvalue, newvalue, bnewent, binitialsnap, fieldname, wasdemojump) {
    pos = self gettagorigin("tag_powersupply");
    ang = self gettagangles("tag_powersupply");
    velocity = self getvelocity();
    dynent = createdynentandlaunch(localclientnum, "c_zom_mech_powersupply_cap", pos, ang, self.origin, velocity);
    playfxontag(localclientnum, level._effect["fx_mech_dmg_armor"], self, "tag_powersupply");
    self playsound(0, "zmb_ai_mechz_destruction");
    self.var_2b7dda84 = playfxontag(localclientnum, level._effect["fx_mech_dmg_body_light"], self, "tag_powersupply");
}

// Namespace namespace_46498900
// Params 7, eflags: 0x0
// Checksum 0x1f772a23, Offset: 0x14e0
// Size: 0x1ac
function function_e3453e34(localclientnum, oldvalue, newvalue, bnewent, binitialsnap, fieldname, wasdemojump) {
    if (isdefined(level.var_ed6989ab)) {
        self [[ level.var_ed6989ab ]](localclientnum, oldvalue, newvalue, bnewent, binitialsnap, fieldname, wasdemojump);
        return;
    }
    pos = self gettagorigin("tag_gun_spin");
    ang = self gettagangles("tag_gun_spin");
    velocity = self getvelocity();
    dynent = createdynentandlaunch(localclientnum, "c_zom_mech_gun_barrel", pos, ang, self.origin, velocity);
    playfxontag(localclientnum, level._effect["fx_mech_dmg_armor"], self, "tag_gun_spin");
    self playsound(0, "zmb_ai_mechz_destruction");
    playfxontag(localclientnum, level._effect["fx_mech_dmg_sparks"], self, "tag_gun_spin");
}

// Namespace namespace_46498900
// Params 7, eflags: 0x0
// Checksum 0x82862da8, Offset: 0x1698
// Size: 0x6c
function function_b942c9ec(localclientnum, oldvalue, newvalue, bnewent, binitialsnap, fieldname, wasdemojump) {
    playfxontag(localclientnum, level._effect["fx_wpn_115_muz"], self, "tag_gun_barrel2");
}

// Namespace namespace_46498900
// Params 7, eflags: 0x0
// Checksum 0xe01cedf1, Offset: 0x1710
// Size: 0x16c
function function_dc89a738(localclientnum, oldvalue, newvalue, bnewent, binitialsnap, fieldname, wasdemojump) {
    pos = self gettagorigin("j_knee_attach_ri");
    ang = self gettagangles("j_knee_attach_ri");
    velocity = self getvelocity();
    dynent = createdynentandlaunch(localclientnum, "c_zom_mech_armor_knee_right", pos, ang, pos, velocity);
    playfxontag(localclientnum, level._effect["fx_mech_dmg_armor"], self, "j_knee_attach_ri");
    self playsound(0, "zmb_ai_mechz_destruction");
    playfxontag(localclientnum, level._effect["fx_mech_dmg_knee_sparks"], self, "j_knee_attach_ri");
}

// Namespace namespace_46498900
// Params 7, eflags: 0x0
// Checksum 0x4e303387, Offset: 0x1888
// Size: 0x16c
function function_c74d1856(localclientnum, oldvalue, newvalue, bnewent, binitialsnap, fieldname, wasdemojump) {
    pos = self gettagorigin("j_knee_attach_le");
    ang = self gettagangles("j_knee_attach_le");
    velocity = self getvelocity();
    dynent = createdynentandlaunch(localclientnum, "c_zom_mech_armor_knee_left", pos, ang, pos, velocity);
    playfxontag(localclientnum, level._effect["fx_mech_dmg_armor"], self, "j_knee_attach_le");
    self playsound(0, "zmb_ai_mechz_destruction");
    playfxontag(localclientnum, level._effect["fx_mech_dmg_knee_sparks"], self, "j_knee_attach_le");
}

// Namespace namespace_46498900
// Params 7, eflags: 0x0
// Checksum 0x5ebc6239, Offset: 0x1a00
// Size: 0x16c
function function_7ba558f1(localclientnum, oldvalue, newvalue, bnewent, binitialsnap, fieldname, wasdemojump) {
    pos = self gettagorigin("j_shoulderarmor_ri");
    ang = self gettagangles("j_shoulderarmor_ri");
    velocity = self getvelocity();
    dynent = createdynentandlaunch(localclientnum, "c_zom_mech_armor_shoulder_right", pos, ang, pos, velocity);
    playfxontag(localclientnum, level._effect["fx_mech_dmg_armor"], self, "j_shoulderarmor_ri");
    self playsound(0, "zmb_ai_mechz_destruction");
    playfxontag(localclientnum, level._effect["fx_mech_dmg_sparks"], self, "j_shoulderarmor_ri");
}

// Namespace namespace_46498900
// Params 7, eflags: 0x0
// Checksum 0xabb2df30, Offset: 0x1b78
// Size: 0x16c
function function_8bc31cd3(localclientnum, oldvalue, newvalue, bnewent, binitialsnap, fieldname, wasdemojump) {
    pos = self gettagorigin("j_shoulderarmor_le");
    ang = self gettagangles("j_shoulderarmor_le");
    velocity = self getvelocity();
    dynent = createdynentandlaunch(localclientnum, "c_zom_mech_armor_shoulder_left", pos, ang, pos, velocity);
    playfxontag(localclientnum, level._effect["fx_mech_dmg_armor"], self, "j_shoulderarmor_le");
    self playsound(0, "zmb_ai_mechz_destruction");
    playfxontag(localclientnum, level._effect["fx_mech_dmg_sparks"], self, "j_shoulderarmor_le");
}

// Namespace namespace_46498900
// Params 7, eflags: 0x0
// Checksum 0x2dddd751, Offset: 0x1cf0
// Size: 0xcc
function mechz_headlamp_off(localclientnum, oldvalue, newvalue, bnewent, binitialsnap, fieldname, wasdemojump) {
    if (self.var_70a8f1bf === 1 && newvalue != 0 && isdefined(self.var_bf4b6a5a)) {
        stopfx(localclientnum, self.var_bf4b6a5a);
        self.var_70a8f1bf = 0;
        if (newvalue == 2) {
            playfxontag(localclientnum, level._effect["fx_mech_foot_step"], self, "tag_headlamp_fx");
        }
    }
}

// Namespace namespace_46498900
// Params 7, eflags: 0x4
// Checksum 0x17342b62, Offset: 0x1dc8
// Size: 0xc8
function private function_62673bde(localclientnum, oldvalue, newvalue, bnewent, binitialsnap, fieldname, wasdemojump) {
    if (newvalue) {
        if (isdefined(self.var_314feade)) {
            self clearanim(self.var_314feade, 0.2);
        }
        faceanim = level.var_add93f1d[newvalue];
        self setanim(faceanim, 1, 0.2, 1);
        self.var_314feade = faceanim;
    }
}

