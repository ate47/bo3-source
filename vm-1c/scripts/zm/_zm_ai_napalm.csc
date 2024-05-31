#using scripts/shared/array_shared;
#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/postfx_shared;
#using scripts/shared/math_shared;
#using scripts/shared/clientfield_shared;

#namespace namespace_88f87109;

// Namespace namespace_88f87109
// Params 0, eflags: 0x2
// namespace_88f87109<file_0>::function_2dc19561
// Checksum 0x24b0f94b, Offset: 0x410
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("zm_ai_napalm", &__init__, undefined, undefined);
}

// Namespace namespace_88f87109
// Params 0, eflags: 0x1 linked
// namespace_88f87109<file_0>::function_8c87d8eb
// Checksum 0x86bf967c, Offset: 0x450
// Size: 0x24
function __init__() {
    init_clientfields();
    function_dd1b0e06();
}

// Namespace namespace_88f87109
// Params 0, eflags: 0x1 linked
// namespace_88f87109<file_0>::function_2ea898a8
// Checksum 0x10590ffc, Offset: 0x480
// Size: 0x124
function init_clientfields() {
    clientfield::register("actor", "napalmwet", 21000, 1, "int", &function_c8019df4, 0, 0);
    clientfield::register("actor", "napalmexplode", 21000, 1, "int", &function_85152189, 0, 0);
    clientfield::register("actor", "isnapalm", 21000, 1, "int", &function_d4f3a23b, 0, 0);
    clientfield::register("toplayer", "napalm_pstfx_burn", 21000, 1, "int", &function_8b5f66c2, 0, 0);
}

// Namespace namespace_88f87109
// Params 0, eflags: 0x1 linked
// namespace_88f87109<file_0>::function_dd1b0e06
// Checksum 0x7a32b6f3, Offset: 0x5b0
// Size: 0x3c
function function_dd1b0e06() {
    level.var_89d10b4d = 400;
    level.var_89d10b4d *= level.var_89d10b4d;
    function_4b68d007();
}

// Namespace namespace_88f87109
// Params 0, eflags: 0x1 linked
// namespace_88f87109<file_0>::function_4b68d007
// Checksum 0xb10b526c, Offset: 0x5f8
// Size: 0xc6
function function_4b68d007() {
    level._effect["napalm_fire_forearm"] = "dlc5/temple/fx_ztem_napalm_zombie_forearm";
    level._effect["napalm_fire_torso"] = "dlc5/temple/fx_ztem_napalm_zombie_torso";
    level._effect["napalm_distortion"] = "dlc5/temple/fx_ztem_napalm_zombie_heat";
    level._effect["napalm_fire_forearm_end"] = "dlc5/temple/fx_ztem_napalm_zombie_forearm_end";
    level._effect["napalm_fire_torso_end"] = "dlc5/temple/fx_ztem_napalm_zombie_torso_end";
    level._effect["napalm_steam"] = "dlc5/temple/fx_ztem_zombie_torso_steam_runner";
    level._effect["napalm_feet_steam"] = "dlc5/temple/fx_ztem_zombie_torso_steam_runner";
}

// Namespace namespace_88f87109
// Params 7, eflags: 0x1 linked
// namespace_88f87109<file_0>::function_d4f3a23b
// Checksum 0x3fc63f46, Offset: 0x6c8
// Size: 0x126
function function_d4f3a23b(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
    if (newval) {
        level.var_da4daffb = self;
        self.var_d88a44cf = 1;
        self thread function_dfaf1b3e(1);
        self thread function_b29c4d0c(localclientnum);
        self thread function_e1af61cc(localclientnum);
        self thread function_1fdd4254(localclientnum);
        self thread function_dfc155a2(localclientnum);
        return;
    }
    self notify(#"stop_fx");
    self notify(#"hash_b127973e");
    if (isdefined(self.var_ada11270)) {
        self.var_ada11270 delete();
    }
    level.var_da4daffb = undefined;
}

// Namespace namespace_88f87109
// Params 1, eflags: 0x1 linked
// namespace_88f87109<file_0>::function_dfc155a2
// Checksum 0xf98aeeed, Offset: 0x7f8
// Size: 0x50
function function_dfc155a2(localclientnum) {
    self endon(#"hash_b127973e");
    while (isdefined(self)) {
        self mapshaderconstant(localclientnum, 0, "scriptVector2", 1, 0, 0);
        wait(0.05);
    }
}

// Namespace namespace_88f87109
// Params 1, eflags: 0x1 linked
// namespace_88f87109<file_0>::function_1fdd4254
// Checksum 0x25553926, Offset: 0x850
// Size: 0x194
function function_1fdd4254(client_num) {
    self endon(#"hash_b127973e");
    self endon(#"death");
    self endon(#"entityshutdown");
    while (true) {
        waterheight = -15000;
        underwater = waterheight > self.origin[2];
        if (underwater) {
            if (!isdefined(self.var_ada11270)) {
                var_8d78a1c5 = spawn(client_num, self.origin, "script_model");
                var_8d78a1c5 setmodel("tag_origin");
                playfxontag(client_num, level._effect["napalm_feet_steam"], var_8d78a1c5, "tag_origin");
                self.var_ada11270 = var_8d78a1c5;
            }
            origin = (self.origin[0], self.origin[1], waterheight);
            self.var_ada11270.origin = origin;
        } else if (isdefined(self.var_ada11270)) {
            self.var_ada11270 delete();
            self.var_ada11270 = undefined;
        }
        wait(0.1);
    }
}

// Namespace namespace_88f87109
// Params 1, eflags: 0x1 linked
// namespace_88f87109<file_0>::function_e1af61cc
// Checksum 0x4dac8ccc, Offset: 0x9f0
// Size: 0x2a6
function function_e1af61cc(localclientnum) {
    self.var_61c885f9 = [];
    wait(1);
    var_b73afa37 = playfxontag(localclientnum, level._effect["napalm_fire_forearm"], self, "J_Wrist_RI");
    array::add(self.var_61c885f9, var_b73afa37, 0);
    var_2848fc16 = playfxontag(localclientnum, level._effect["napalm_fire_forearm"], self, "J_Wrist_LE");
    array::add(self.var_61c885f9, var_2848fc16, 0);
    var_f86ab686 = playfxontag(localclientnum, level._effect["napalm_fire_torso"], self, "J_SpineLower");
    array::add(self.var_61c885f9, var_f86ab686, 0);
    var_19cf783f = playfxontag(localclientnum, level._effect["napalm_fire_forearm"], self, "J_Head");
    array::add(self.var_61c885f9, var_19cf783f, 0);
    var_bc3301ad = playfxontag(localclientnum, level._effect["napalm_distortion"], self, "tag_origin");
    array::add(self.var_61c885f9, var_bc3301ad, 0);
    self playloopsound("evt_napalm_zombie_loop", 2);
    self util::waittill_any("stop_fx", "entityshutdown");
    if (isdefined(self)) {
        self stopallloopsounds(0.25);
        for (i = 0; i < self.var_61c885f9.size; i++) {
            stopfx(localclientnum, self.var_61c885f9[i]);
        }
        self.var_61c885f9 = undefined;
    }
}

// Namespace namespace_88f87109
// Params 7, eflags: 0x1 linked
// namespace_88f87109<file_0>::function_85152189
// Checksum 0x2bf20574, Offset: 0xca0
// Size: 0x6c
function function_85152189(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
    self thread function_e6743744(localclientnum);
    self thread function_d7b6f45e(localclientnum);
}

// Namespace namespace_88f87109
// Params 7, eflags: 0x1 linked
// namespace_88f87109<file_0>::function_8b5f66c2
// Checksum 0x24a9141a, Offset: 0xd18
// Size: 0x7c
function function_8b5f66c2(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
    if (newval) {
        self thread postfx::playpostfxbundle("pstfx_burn_loop");
        return;
    }
    self thread postfx::exitpostfxbundle();
}

// Namespace namespace_88f87109
// Params 1, eflags: 0x1 linked
// namespace_88f87109<file_0>::function_d7b6f45e
// Checksum 0x89808b0f, Offset: 0xda0
// Size: 0x25e
function function_d7b6f45e(localclientnum) {
    self.var_a8353e57 = [];
    var_ba4bf47b = playfxontag(localclientnum, level._effect["napalm_fire_forearm_end"], self, "J_Elbow_LE");
    array::add(self.var_a8353e57, var_ba4bf47b, 0);
    var_968c6325 = playfxontag(localclientnum, level._effect["napalm_fire_forearm_end"], self, "J_Elbow_RI");
    array::add(self.var_a8353e57, var_968c6325, 0);
    var_955eea4 = playfxontag(localclientnum, level._effect["napalm_fire_forearm_end"], self, "J_Clavicle_LE");
    array::add(self.var_a8353e57, var_955eea4, 0);
    var_4d8c73aa = playfxontag(localclientnum, level._effect["napalm_fire_forearm_end"], self, "J_Clavicle_RI");
    array::add(self.var_a8353e57, var_4d8c73aa, 0);
    var_f86ab686 = playfxontag(localclientnum, level._effect["napalm_fire_torso_end"], self, "J_SpineLower");
    array::add(self.var_a8353e57, var_f86ab686, 0);
    self util::waittill_any("stop_fx", "entityshutdown");
    if (isdefined(self)) {
        for (i = 0; i < self.var_a8353e57.size; i++) {
            stopfx(localclientnum, self.var_a8353e57[i]);
        }
        self.var_a8353e57 = undefined;
    }
}

// Namespace namespace_88f87109
// Params 1, eflags: 0x1 linked
// namespace_88f87109<file_0>::function_7165b8f0
// Checksum 0xa5c631d9, Offset: 0x1008
// Size: 0x8c
function function_7165b8f0(localclientnum) {
    var_f86ab686 = playfxontag(localclientnum, level._effect["napalm_steam"], self, "J_SpineLower");
    self util::waittill_any("stop_fx", "entityshutdown");
    if (isdefined(self)) {
        stopfx(localclientnum, var_f86ab686);
    }
}

// Namespace namespace_88f87109
// Params 1, eflags: 0x1 linked
// namespace_88f87109<file_0>::function_dfaf1b3e
// Checksum 0x8f47dc1c, Offset: 0x10a0
// Size: 0x6c
function function_dfaf1b3e(set) {
    if (set) {
        level._footstepcbfuncs[self.archetype] = &function_3753bc33;
        self.step_sound = "zmb_napalm_step";
        return;
    }
    level._footstepcbfuncs[self.archetype] = undefined;
    self.step_sound = "zmb_napalm_step";
}

// Namespace namespace_88f87109
// Params 5, eflags: 0x1 linked
// namespace_88f87109<file_0>::function_3753bc33
// Checksum 0x78e6bdaf, Offset: 0x1118
// Size: 0x74
function function_3753bc33(localclientnum, pos, surface, notetrack, bone) {
    if (isdefined(self.var_d88a44cf) && self.var_d88a44cf) {
        playfxontag(localclientnum, level._effect["napalm_zombie_footstep"], self, bone);
    }
}

// Namespace namespace_88f87109
// Params 0, eflags: 0x0
// namespace_88f87109<file_0>::function_3e44525f
// Checksum 0xfe622337, Offset: 0x1198
// Size: 0x1c8
function function_3e44525f() {
    self endon(#"death");
    self endon(#"disconnect");
    self endon(#"entityshutdown");
    prevfrac = 0;
    while (true) {
        frac = 0;
        if (isdefined(level.var_da4daffb.var_2ef06f9b) && (!isdefined(level.var_da4daffb) || level.var_da4daffb.var_2ef06f9b) || function_64eb29a7(level.var_da4daffb)) {
            frac = 0;
        } else {
            var_17350f7d = distancesquared(self.origin, level.var_da4daffb.origin);
            if (var_17350f7d < level.var_89d10b4d) {
                frac = (level.var_89d10b4d - var_17350f7d) / level.var_89d10b4d;
                frac *= 1.1;
                if (frac > 1) {
                    frac = 1;
                }
            }
        }
        delta = math::clamp(frac - prevfrac, -0.1, 0.1);
        frac = prevfrac + delta;
        prevfrac = frac;
        setsaveddvar("r_flameScaler", frac);
        wait(0.1);
    }
}

// Namespace namespace_88f87109
// Params 1, eflags: 0x1 linked
// namespace_88f87109<file_0>::function_64eb29a7
// Checksum 0x18bf01b9, Offset: 0x1368
// Size: 0x94
function function_64eb29a7(var_9eb510f4) {
    trace = undefined;
    if (isdefined(level.var_da4daffb)) {
        trace = bullettrace(self geteye(), level.var_da4daffb.origin, 0, self);
        if (isdefined(trace) && trace["fraction"] < 0.85) {
            return true;
        }
    }
    return false;
}

// Namespace namespace_88f87109
// Params 7, eflags: 0x1 linked
// namespace_88f87109<file_0>::function_c8019df4
// Checksum 0xa063c9b6, Offset: 0x1408
// Size: 0x7c
function function_c8019df4(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
    if (newval) {
        self function_c0554f0f(localclientnum);
        return;
    }
    self function_41d418e2(localclientnum);
}

// Namespace namespace_88f87109
// Params 1, eflags: 0x1 linked
// namespace_88f87109<file_0>::function_c0554f0f
// Checksum 0x5be679b4, Offset: 0x1490
// Size: 0x74
function function_c0554f0f(client_num) {
    self notify(#"stop_fx");
    self thread function_7165b8f0(client_num);
    self.var_2ef06f9b = 1;
    self thread function_f5a16a3f(client_num);
    self thread function_dfaf1b3e(0);
}

// Namespace namespace_88f87109
// Params 1, eflags: 0x1 linked
// namespace_88f87109<file_0>::function_41d418e2
// Checksum 0xca6756c3, Offset: 0x1510
// Size: 0x74
function function_41d418e2(client_num) {
    self notify(#"stop_fx");
    self thread function_e1af61cc(client_num);
    self.var_2ef06f9b = 0;
    self thread function_b29c4d0c(client_num);
    self thread function_dfaf1b3e(1);
}

// Namespace namespace_88f87109
// Params 2, eflags: 0x1 linked
// namespace_88f87109<file_0>::function_ce20ddd
// Checksum 0x9c36257a, Offset: 0x1590
// Size: 0x44
function function_ce20ddd(client_num, var_2e5dee4b) {
    self.var_37cf3842 = var_2e5dee4b;
    self setshaderconstant(client_num, 0, 0, 0, 0, var_2e5dee4b);
}

// Namespace namespace_88f87109
// Params 1, eflags: 0x1 linked
// namespace_88f87109<file_0>::function_b29c4d0c
// Checksum 0xc5be5b7d, Offset: 0x15e0
// Size: 0x2c
function function_b29c4d0c(client_num) {
    self thread function_e0b475c6(client_num, 2.5);
}

// Namespace namespace_88f87109
// Params 1, eflags: 0x1 linked
// namespace_88f87109<file_0>::function_e6743744
// Checksum 0x5ef8973e, Offset: 0x1618
// Size: 0x2c
function function_e6743744(client_num) {
    self thread function_e0b475c6(client_num, 10);
}

// Namespace namespace_88f87109
// Params 1, eflags: 0x1 linked
// namespace_88f87109<file_0>::function_f5a16a3f
// Checksum 0x75ec393a, Offset: 0x1650
// Size: 0x2c
function function_f5a16a3f(client_num) {
    self thread function_e0b475c6(client_num, 0.5);
}

// Namespace namespace_88f87109
// Params 2, eflags: 0x1 linked
// namespace_88f87109<file_0>::function_e0b475c6
// Checksum 0x62e5c152, Offset: 0x1688
// Size: 0x174
function function_e0b475c6(client_num, var_2e5dee4b) {
    self notify(#"hash_35703e82");
    self endon(#"hash_35703e82");
    self endon(#"death");
    self endon(#"entityshutdown");
    startval = self.var_37cf3842;
    endval = var_2e5dee4b;
    if (isdefined(startval)) {
        delta = var_2e5dee4b - self.var_37cf3842;
        lerptime = 1000;
        starttime = getrealtime();
        while (starttime + lerptime > getrealtime()) {
            s = (getrealtime() - starttime) / lerptime;
            newval = startval + (endval - startval) * s;
            self function_ce20ddd(client_num, newval);
            wait(0.05);
        }
    }
    self function_ce20ddd(client_num, endval);
}

