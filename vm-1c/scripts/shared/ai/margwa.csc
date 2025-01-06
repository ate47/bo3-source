#using scripts/shared/ai_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/postfx_shared;
#using scripts/shared/util_shared;

#using_animtree("generic");

#namespace margwa;

// Namespace margwa
// Params 0, eflags: 0x2
// Checksum 0xcf7b9303, Offset: 0x760
// Size: 0x69e
function autoexec main() {
    clientfield::register("actor", "margwa_head_left", 1, 2, "int", &namespace_8e0e686a::function_c0e0c646, 0, 0);
    clientfield::register("actor", "margwa_head_mid", 1, 2, "int", &namespace_8e0e686a::function_7e5d3087, 0, 0);
    clientfield::register("actor", "margwa_head_right", 1, 2, "int", &namespace_8e0e686a::function_d87d3ccf, 0, 0);
    clientfield::register("actor", "margwa_fx_in", 1, 1, "counter", &namespace_8e0e686a::function_f6e2bd30, 0, 0);
    clientfield::register("actor", "margwa_fx_out", 1, 1, "counter", &namespace_8e0e686a::function_2da4e7b5, 0, 0);
    clientfield::register("actor", "margwa_fx_spawn", 1, 1, "counter", &namespace_8e0e686a::function_540e4b20, 0, 0);
    clientfield::register("actor", "margwa_smash", 1, 1, "counter", &namespace_8e0e686a::function_be725723, 0, 0);
    clientfield::register("actor", "margwa_head_left_hit", 1, 1, "counter", &namespace_8e0e686a::function_e9b7fd, 0, 0);
    clientfield::register("actor", "margwa_head_mid_hit", 1, 1, "counter", &namespace_8e0e686a::function_f83117ae, 0, 0);
    clientfield::register("actor", "margwa_head_right_hit", 1, 1, "counter", &namespace_8e0e686a::function_5a1f5466, 0, 0);
    clientfield::register("actor", "margwa_head_killed", 1, 2, "int", &namespace_8e0e686a::function_42dfc6e6, 0, 0);
    clientfield::register("actor", "margwa_jaw", 1, 6, "int", &namespace_8e0e686a::function_5d887ba9, 0, 0);
    clientfield::register("toplayer", "margwa_head_explosion", 1, 1, "counter", &namespace_8e0e686a::function_e758beb5, 0, 0);
    clientfield::register("scriptmover", "margwa_fx_travel", 1, 1, "int", &namespace_8e0e686a::function_7dbd5705, 0, 0);
    clientfield::register("scriptmover", "margwa_fx_travel_tell", 1, 1, "int", &namespace_8e0e686a::function_584a8fb0, 0, 0);
    clientfield::register("actor", "supermargwa", 1, 1, "int", undefined, 0, 0);
    ai::add_archetype_spawn_function("margwa", &namespace_8e0e686a::function_6a6776cf);
    level.var_3c62309a = [];
    level.var_3c62309a[1] = "idle_1";
    level.var_3c62309a[3] = "idle_pain_head_l_explode";
    level.var_3c62309a[4] = "idle_pain_head_m_explode";
    level.var_3c62309a[5] = "idle_pain_head_r_explode";
    level.var_3c62309a[6] = "react_stun";
    level.var_3c62309a[8] = "react_idgun";
    level.var_3c62309a[9] = "react_idgun_pack";
    level.var_3c62309a[7] = "run_charge_f";
    level.var_3c62309a[13] = "run_f";
    level.var_3c62309a[14] = "smash_attack_1";
    level.var_3c62309a[15] = "swipe";
    level.var_3c62309a[16] = "swipe_player";
    level.var_3c62309a[17] = "teleport_in";
    level.var_3c62309a[18] = "teleport_out";
    level.var_3c62309a[19] = "trv_jump_across_256";
    level.var_3c62309a[20] = "trv_jump_down_128";
    level.var_3c62309a[21] = "trv_jump_down_36";
    level.var_3c62309a[22] = "trv_jump_down_96";
    level.var_3c62309a[23] = "trv_jump_up_128";
    level.var_3c62309a[24] = "trv_jump_up_36";
    level.var_3c62309a[25] = "trv_jump_up_96";
}

// Namespace margwa
// Params 0, eflags: 0x2
// Checksum 0x5b5921e6, Offset: 0xe08
// Size: 0xc6
function autoexec precache() {
    level._effect["fx_margwa_teleport_zod_zmb"] = "zombie/fx_margwa_teleport_zod_zmb";
    level._effect["fx_margwa_teleport_travel_zod_zmb"] = "zombie/fx_margwa_teleport_travel_zod_zmb";
    level._effect["fx_margwa_teleport_tell_zod_zmb"] = "zombie/fx_margwa_teleport_tell_zod_zmb";
    level._effect["fx_margwa_teleport_intro_zod_zmb"] = "zombie/fx_margwa_teleport_intro_zod_zmb";
    level._effect["fx_margwa_head_shot_zod_zmb"] = "zombie/fx_margwa_head_shot_zod_zmb";
    level._effect["fx_margwa_roar_zod_zmb"] = "zombie/fx_margwa_roar_zod_zmb";
    level._effect["fx_margwa_roar_purple_zod_zmb"] = "zombie/fx_margwa_roar_purple_zod_zmb";
}

#namespace namespace_8e0e686a;

// Namespace namespace_8e0e686a
// Params 1, eflags: 0x4
// Checksum 0x879a66c0, Offset: 0xed8
// Size: 0x340
function private function_6a6776cf(localclientnum) {
    self util::waittill_dobj(localclientnum);
    if (!isdefined(self)) {
        return;
    }
    self setanim("ai_margwa_head_l_closed_add", 1, 0.2, 1);
    self setanim("ai_margwa_head_m_closed_add", 1, 0.2, 1);
    self setanim("ai_margwa_head_r_closed_add", 1, 0.2, 1);
    for (i = 1; i <= 7; i++) {
        var_c012a92c = "ai_margwa_tentacle_l_0" + i;
        var_853f37cb = "ai_margwa_tentacle_r_0" + i;
        self setanim(var_c012a92c, 1, 0.2, 1);
        self setanim(var_853f37cb, 1, 0.2, 1);
    }
    level._footstepcbfuncs[self.archetype] = &function_4b9de733;
    self.heads = [];
    self.heads[1] = spawnstruct();
    self.heads[1].index = 1;
    self.heads[1].var_743ac02b = "ai_margwa_head_l_closed_add";
    self.heads[1].var_2f5bf44e = "ai_margwa_jaw_l_";
    self.heads[2] = spawnstruct();
    self.heads[2].index = 2;
    self.heads[2].var_743ac02b = "ai_margwa_head_m_closed_add";
    self.heads[2].var_2f5bf44e = "ai_margwa_jaw_m_";
    self.heads[3] = spawnstruct();
    self.heads[3].index = 3;
    self.heads[3].var_743ac02b = "ai_margwa_head_r_closed_add";
    self.heads[3].var_2f5bf44e = "ai_margwa_jaw_r_";
}

// Namespace namespace_8e0e686a
// Params 7, eflags: 0x4
// Checksum 0x39899429, Offset: 0x1220
// Size: 0x40e
function private function_c0e0c646(localclientnum, oldvalue, newvalue, bnewent, binitialsnap, fieldname, wasdemojump) {
    if (isdefined(self.var_c848921f)) {
        stopfx(localclientnum, self.var_c848921f);
    }
    self util::waittill_dobj(localclientnum);
    if (!isdefined(self)) {
        return;
    }
    switch (newvalue) {
    case 1:
        self.heads[1].var_743ac02b = "ai_margwa_head_l_open_add";
        self setanim("ai_margwa_head_l_open_add", 1, 0.1, 1);
        self clearanim("ai_margwa_head_l_closed_add", 0.1);
        var_3623df1f = level._effect["fx_margwa_roar_zod_zmb"];
        if (isdefined(self.var_6eaba533)) {
            var_3623df1f = self.var_6eaba533;
        }
        if (self clientfield::get("supermargwa")) {
            self.var_c848921f = playfxontag(localclientnum, level._effect["fx_margwa_roar_purple_zod_zmb"], self, "tag_head_left");
        } else {
            self.var_c848921f = playfxontag(localclientnum, var_3623df1f, self, "tag_head_left");
        }
        break;
    case 2:
        self.heads[1].var_743ac02b = "ai_margwa_head_l_closed_add";
        self setanim("ai_margwa_head_l_closed_add", 1, 0.1, 1);
        self clearanim("ai_margwa_head_l_open_add", 0.1);
        self clearanim("ai_margwa_head_l_smash_attack_1", 0.1);
        break;
    case 3:
        self.heads[1].var_743ac02b = "ai_margwa_head_l_smash_attack_1";
        self clearanim("ai_margwa_head_l_open_add", 0.1);
        self clearanim("ai_margwa_head_l_closed_add", 0.1);
        self setanimrestart("ai_margwa_head_l_smash_attack_1", 1, 0.1, 1);
        var_3623df1f = level._effect["fx_margwa_roar_zod_zmb"];
        if (isdefined(self.var_6eaba533)) {
            var_3623df1f = self.var_6eaba533;
        }
        if (self clientfield::get("supermargwa")) {
            self.var_c848921f = playfxontag(localclientnum, level._effect["fx_margwa_roar_purple_zod_zmb"], self, "tag_head_left");
        } else {
            self.var_c848921f = playfxontag(localclientnum, var_3623df1f, self, "tag_head_left");
        }
        self thread function_6ced7db8(localclientnum);
        break;
    }
}

// Namespace namespace_8e0e686a
// Params 7, eflags: 0x4
// Checksum 0xe539dfdd, Offset: 0x1638
// Size: 0x3a6
function private function_7e5d3087(localclientnum, oldvalue, newvalue, bnewent, binitialsnap, fieldname, wasdemojump) {
    if (isdefined(self.var_12ac0a08)) {
        stopfx(localclientnum, self.var_12ac0a08);
    }
    self util::waittill_dobj(localclientnum);
    if (!isdefined(self)) {
        return;
    }
    switch (newvalue) {
    case 1:
        self setanim("ai_margwa_head_m_open_add", 1, 0.1, 1);
        self clearanim("ai_margwa_head_m_closed_add", 0.1);
        var_3623df1f = level._effect["fx_margwa_roar_zod_zmb"];
        if (isdefined(self.var_6eaba533)) {
            var_3623df1f = self.var_6eaba533;
        }
        if (self clientfield::get("supermargwa")) {
            self.var_12ac0a08 = playfxontag(localclientnum, level._effect["fx_margwa_roar_purple_zod_zmb"], self, "tag_head_mid");
        } else {
            self.var_12ac0a08 = playfxontag(localclientnum, var_3623df1f, self, "tag_head_mid");
        }
        break;
    case 2:
        self setanim("ai_margwa_head_m_closed_add", 1, 0.1, 1);
        self clearanim("ai_margwa_head_m_open_add", 0.1);
        self clearanim("ai_margwa_head_m_smash_attack_1", 0.1);
        break;
    case 3:
        self clearanim("ai_margwa_head_m_open_add", 0.1);
        self clearanim("ai_margwa_head_m_closed_add", 0.1);
        self setanimrestart("ai_margwa_head_m_smash_attack_1", 1, 0.1, 1);
        var_3623df1f = level._effect["fx_margwa_roar_zod_zmb"];
        if (isdefined(self.var_6eaba533)) {
            var_3623df1f = self.var_6eaba533;
        }
        if (self clientfield::get("supermargwa")) {
            self.var_12ac0a08 = playfxontag(localclientnum, level._effect["fx_margwa_roar_purple_zod_zmb"], self, "tag_head_mid");
        } else {
            self.var_12ac0a08 = playfxontag(localclientnum, var_3623df1f, self, "tag_head_mid");
        }
        self thread function_6ced7db8(localclientnum);
        break;
    }
}

// Namespace namespace_8e0e686a
// Params 7, eflags: 0x4
// Checksum 0xc6c44191, Offset: 0x19e8
// Size: 0x3a6
function private function_d87d3ccf(localclientnum, oldvalue, newvalue, bnewent, binitialsnap, fieldname, wasdemojump) {
    if (isdefined(self.var_3ad36aa8)) {
        stopfx(localclientnum, self.var_3ad36aa8);
    }
    self util::waittill_dobj(localclientnum);
    if (!isdefined(self)) {
        return;
    }
    switch (newvalue) {
    case 1:
        self setanim("ai_margwa_head_r_open_add", 1, 0.1, 1);
        self clearanim("ai_margwa_head_r_closed_add", 0.1);
        var_3623df1f = level._effect["fx_margwa_roar_zod_zmb"];
        if (isdefined(self.var_6eaba533)) {
            var_3623df1f = self.var_6eaba533;
        }
        if (self clientfield::get("supermargwa")) {
            self.var_3ad36aa8 = playfxontag(localclientnum, level._effect["fx_margwa_roar_purple_zod_zmb"], self, "tag_head_right");
        } else {
            self.var_3ad36aa8 = playfxontag(localclientnum, var_3623df1f, self, "tag_head_right");
        }
        break;
    case 2:
        self setanim("ai_margwa_head_r_closed_add", 1, 0.1, 1);
        self clearanim("ai_margwa_head_r_open_add", 0.1);
        self clearanim("ai_margwa_head_r_smash_attack_1", 0.1);
        break;
    case 3:
        self clearanim("ai_margwa_head_r_open_add", 0.1);
        self clearanim("ai_margwa_head_r_closed_add", 0.1);
        self setanimrestart("ai_margwa_head_r_smash_attack_1", 1, 0.1, 1);
        var_3623df1f = level._effect["fx_margwa_roar_zod_zmb"];
        if (isdefined(self.var_6eaba533)) {
            var_3623df1f = self.var_6eaba533;
        }
        if (self clientfield::get("supermargwa")) {
            self.var_3ad36aa8 = playfxontag(localclientnum, level._effect["fx_margwa_roar_purple_zod_zmb"], self, "tag_head_right");
        } else {
            self.var_3ad36aa8 = playfxontag(localclientnum, var_3623df1f, self, "tag_head_right");
        }
        self thread function_6ced7db8(localclientnum);
        break;
    }
}

// Namespace namespace_8e0e686a
// Params 1, eflags: 0x4
// Checksum 0xedfe9ecd, Offset: 0x1d98
// Size: 0x9c
function private function_6ced7db8(localclientnum) {
    self endon(#"entityshutdown");
    wait 0.6;
    if (isdefined(self.var_c848921f)) {
        stopfx(localclientnum, self.var_c848921f);
    }
    if (isdefined(self.var_12ac0a08)) {
        stopfx(localclientnum, self.var_12ac0a08);
    }
    if (isdefined(self.var_3ad36aa8)) {
        stopfx(localclientnum, self.var_3ad36aa8);
    }
}

// Namespace namespace_8e0e686a
// Params 7, eflags: 0x4
// Checksum 0x915558a6, Offset: 0x1e40
// Size: 0x94
function private function_f6e2bd30(localclientnum, oldvalue, newvalue, bnewent, binitialsnap, fieldname, wasdemojump) {
    if (newvalue) {
        self.var_7fe940db = playfx(localclientnum, level._effect["fx_margwa_teleport_zod_zmb"], self gettagorigin("j_spine_1"));
    }
}

// Namespace namespace_8e0e686a
// Params 7, eflags: 0x4
// Checksum 0xd40f1b8b, Offset: 0x1ee0
// Size: 0xa4
function private function_2da4e7b5(localclientnum, oldvalue, newvalue, bnewent, binitialsnap, fieldname, wasdemojump) {
    if (newvalue) {
        tagpos = self gettagorigin("j_spine_1");
        self.var_50b72d4e = playfx(localclientnum, level._effect["fx_margwa_teleport_zod_zmb"], tagpos);
    }
}

// Namespace namespace_8e0e686a
// Params 7, eflags: 0x4
// Checksum 0x90b68d05, Offset: 0x1f90
// Size: 0xbe
function private function_7dbd5705(localclientnum, oldvalue, newvalue, bnewent, binitialsnap, fieldname, wasdemojump) {
    switch (newvalue) {
    case 0:
        deletefx(localclientnum, self.var_1427f05a);
        break;
    case 1:
        self.var_1427f05a = playfxontag(localclientnum, level._effect["fx_margwa_teleport_travel_zod_zmb"], self, "tag_origin");
        break;
    }
}

// Namespace namespace_8e0e686a
// Params 7, eflags: 0x4
// Checksum 0x819f763b, Offset: 0x2058
// Size: 0xde
function private function_584a8fb0(localclientnum, oldvalue, newvalue, bnewent, binitialsnap, fieldname, wasdemojump) {
    switch (newvalue) {
    case 0:
        deletefx(localclientnum, self.var_add65037);
        self notify(#"hash_a222dc9a");
        break;
    case 1:
        self.var_add65037 = playfxontag(localclientnum, level._effect["fx_margwa_teleport_tell_zod_zmb"], self, "tag_origin");
        self thread function_201bc8e4(localclientnum);
        break;
    }
}

// Namespace namespace_8e0e686a
// Params 1, eflags: 0x4
// Checksum 0xab59ebac, Offset: 0x2140
// Size: 0xd8
function private function_201bc8e4(localclientnum) {
    self notify(#"hash_a222dc9a");
    self endon(#"hash_a222dc9a");
    self endon(#"entityshutdown");
    player = getlocalplayer(localclientnum);
    while (true) {
        if (isdefined(player)) {
            dist_sq = distancesquared(player.origin, self.origin);
            if (dist_sq < 1000000) {
                player playrumbleonentity(localclientnum, "tank_rumble");
            }
        }
        wait 0.05;
    }
}

// Namespace namespace_8e0e686a
// Params 7, eflags: 0x4
// Checksum 0x477c632a, Offset: 0x2220
// Size: 0x114
function private function_540e4b20(localclientnum, oldvalue, newvalue, bnewent, binitialsnap, fieldname, wasdemojump) {
    if (newvalue) {
        spawnfx = level._effect["fx_margwa_teleport_intro_zod_zmb"];
        if (isdefined(self.var_12c4e9d2)) {
            spawnfx = self.var_12c4e9d2;
        }
        if (isdefined(self.var_d903a525)) {
            self thread [[ self.var_d903a525 ]](localclientnum);
        } else {
            self.spawnfx = playfx(localclientnum, spawnfx, self gettagorigin("j_spine_1"));
        }
        playsound(0, "zmb_margwa_spawn", self gettagorigin("j_spine_1"));
    }
}

// Namespace namespace_8e0e686a
// Params 7, eflags: 0x4
// Checksum 0x54ecfd4e, Offset: 0x2340
// Size: 0x64
function private function_e758beb5(localclientnum, oldvalue, newvalue, bnewent, binitialsnap, fieldname, wasdemojump) {
    if (newvalue) {
        self postfx::playpostfxbundle("pstfx_parasite_dmg");
    }
}

// Namespace namespace_8e0e686a
// Params 5, eflags: 0x0
// Checksum 0xc39dcbf6, Offset: 0x23b0
// Size: 0x20c
function function_4b9de733(localclientnum, pos, surface, notetrack, bone) {
    e_player = getlocalplayer(localclientnum);
    n_dist = distancesquared(pos, e_player.origin);
    var_803bd5ba = getdvarint("scr_margwa_footstep_eq_radius", 1000) * getdvarint("scr_margwa_footstep_eq_radius", 1000);
    if (var_803bd5ba > 0) {
        n_scale = (var_803bd5ba - n_dist) / var_803bd5ba;
    } else {
        return;
    }
    if (n_scale > 1 || n_scale < 0) {
        return;
    }
    n_scale *= 0.25;
    if (n_scale <= 0.01) {
        return;
    }
    e_player earthquake(n_scale, 0.1, pos, n_dist);
    if (n_scale <= 0.25 && n_scale > 0.2) {
        e_player playrumbleonentity(localclientnum, "shotgun_fire");
        return;
    }
    if (n_scale <= 0.2 && n_scale > 0.1) {
        e_player playrumbleonentity(localclientnum, "damage_heavy");
        return;
    }
    e_player playrumbleonentity(localclientnum, "reload_small");
}

// Namespace namespace_8e0e686a
// Params 7, eflags: 0x4
// Checksum 0x61e8731c, Offset: 0x25c8
// Size: 0x194
function private function_be725723(localclientnum, oldvalue, newvalue, bnewent, binitialsnap, fieldname, wasdemojump) {
    if (newvalue) {
        e_player = getlocalplayer(localclientnum);
        var_c06eca13 = self.origin + vectorscale(anglestoforward(self.angles), 60);
        distsq = distancesquared(var_c06eca13, e_player.origin);
        if (distsq < 20736) {
            e_player earthquake(0.7, 0.25, e_player.origin, 3000);
            e_player playrumbleonentity(localclientnum, "shotgun_fire");
            return;
        }
        if (distsq < 36864) {
            e_player earthquake(0.7, 0.25, e_player.origin, 1500);
            e_player playrumbleonentity(localclientnum, "damage_heavy");
        }
    }
}

// Namespace namespace_8e0e686a
// Params 7, eflags: 0x4
// Checksum 0xf2b2d95, Offset: 0x2768
// Size: 0xac
function private function_e9b7fd(localclientnum, oldvalue, newvalue, bnewent, binitialsnap, fieldname, wasdemojump) {
    if (newvalue) {
        effect = level._effect["fx_margwa_head_shot_zod_zmb"];
        if (isdefined(self.var_5373c806)) {
            effect = self.var_5373c806;
        }
        self.var_8c7ec93 = playfxontag(localclientnum, effect, self, "tag_head_left");
    }
}

// Namespace namespace_8e0e686a
// Params 7, eflags: 0x4
// Checksum 0x42a9f94f, Offset: 0x2820
// Size: 0xac
function private function_f83117ae(localclientnum, oldvalue, newvalue, bnewent, binitialsnap, fieldname, wasdemojump) {
    if (newvalue) {
        effect = level._effect["fx_margwa_head_shot_zod_zmb"];
        if (isdefined(self.var_5373c806)) {
            effect = self.var_5373c806;
        }
        self.var_d6045666 = playfxontag(localclientnum, effect, self, "tag_head_mid");
    }
}

// Namespace namespace_8e0e686a
// Params 7, eflags: 0x4
// Checksum 0xe19fcfaf, Offset: 0x28d8
// Size: 0xac
function private function_5a1f5466(localclientnum, oldvalue, newvalue, bnewent, binitialsnap, fieldname, wasdemojump) {
    if (newvalue) {
        effect = level._effect["fx_margwa_head_shot_zod_zmb"];
        if (isdefined(self.var_5373c806)) {
            effect = self.var_5373c806;
        }
        self.var_d5943b86 = playfxontag(localclientnum, effect, self, "tag_head_right");
    }
}

// Namespace namespace_8e0e686a
// Params 7, eflags: 0x4
// Checksum 0x3c4188, Offset: 0x2990
// Size: 0x60
function private function_42dfc6e6(localclientnum, oldvalue, newvalue, bnewent, binitialsnap, fieldname, wasdemojump) {
    if (newvalue) {
        self.heads[newvalue].killed = 1;
    }
}

// Namespace namespace_8e0e686a
// Params 7, eflags: 0x4
// Checksum 0x94ddd068, Offset: 0x29f8
// Size: 0x1c2
function private function_5d887ba9(localclientnum, oldvalue, newvalue, bnewent, binitialsnap, fieldname, wasdemojump) {
    if (newvalue) {
        foreach (head in self.heads) {
            if (isdefined(head.killed) && head.killed) {
                if (isdefined(head.var_50920bf3)) {
                    self clearanim(head.var_50920bf3, 0.2);
                }
                if (isdefined(head.var_743ac02b)) {
                    self clearanim(head.var_743ac02b, 0.1);
                }
                var_118cd98a = head.var_2f5bf44e + level.var_3c62309a[newvalue];
                head.var_50920bf3 = var_118cd98a;
                self setanim(var_118cd98a, 1, 0.2, 1);
            }
        }
    }
}

