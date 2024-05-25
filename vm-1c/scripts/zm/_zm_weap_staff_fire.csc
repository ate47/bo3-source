#using scripts/zm/_zm_weap_staff_common;
#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/clientfield_shared;

#namespace namespace_ecdcc148;

// Namespace namespace_ecdcc148
// Params 0, eflags: 0x2
// Checksum 0xee7a82f6, Offset: 0x280
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("zm_weap_staff_fire", &__init__, undefined, undefined);
}

// Namespace namespace_ecdcc148
// Params 0, eflags: 0x1 linked
// Checksum 0xbc361aec, Offset: 0x2c0
// Size: 0xfc
function __init__() {
    clientfield::register("actor", "fire_char_fx", 21000, 1, "int", &function_657b61e3, 0, 0);
    clientfield::register("toplayer", "fire_muzzle_fx", 21000, 1, "counter", &function_d6107b2c, 0, 0);
    level._effect["fire_muzzle"] = "dlc5/zmb_weapon/fx_staff_fire_muz_flash_1p";
    level._effect["fire_muzzle_ug"] = "dlc5/zmb_weapon/fx_staff_fire_muz_flash_1p_ug";
    namespace_c9806b9::function_4be5e665(getweapon("staff_fire_upgraded"), "dlc5/zmb_weapon/fx_staff_charge_fire_lv1");
}

// Namespace namespace_ecdcc148
// Params 7, eflags: 0x1 linked
// Checksum 0xf6ddd742, Offset: 0x3c8
// Size: 0xfc
function function_d6107b2c(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
    if (newval == 1) {
        if (hasweapon(localclientnum, getweapon("staff_fire_upgraded"))) {
            playviewmodelfx(localclientnum, level._effect["fire_muzzle_ug"], "tag_flash");
        } else {
            playviewmodelfx(localclientnum, level._effect["fire_muzzle"], "tag_flash");
        }
        playsound(localclientnum, "wpn_firestaff_fire_plr");
    }
}

// Namespace namespace_ecdcc148
// Params 7, eflags: 0x1 linked
// Checksum 0x685522fd, Offset: 0x4d0
// Size: 0x420
function function_657b61e3(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
    self endon(#"entityshutdown");
    rate = randomfloatrange(0.01, 0.015);
    if (isdefined(self.var_a90ff836)) {
        stopfx(localclientnum, self.var_a90ff836);
        self.var_a90ff836 = undefined;
    }
    if (isdefined(self.var_44f239e3)) {
        stopfx(localclientnum, self.var_44f239e3);
        self.var_44f239e3 = undefined;
    }
    if (isdefined(self.sndent)) {
        self.sndent notify(#"hash_d5d2a2ce");
        self.sndent delete();
        self.sndent = undefined;
    }
    if (newval == 1) {
        self.var_a90ff836 = playfxontag(localclientnum, level._effect["character_fire_death_torso"], self, "j_spinelower");
        self.var_44f239e3 = playfxontag(localclientnum, level._effect["character_fire_death_sm"], self, "j_head");
        self.sndent = spawn(0, self.origin, "script_origin");
        self.sndent linkto(self);
        self.sndent playloopsound("zmb_fire_loop", 0.5);
        self.sndent thread function_613e39fa(self);
        if (!(isdefined(self.var_ff3ddd5b) && self.var_ff3ddd5b)) {
            self.var_ff3ddd5b = 1;
        }
        var_5e5728a8 = 1;
        var_2094128c = 0.6;
        for (i = 0; i < 2; i++) {
            for (f = 0.6; f <= 0.85; f += rate) {
                util::server_wait(localclientnum, 0.05);
                self setshaderconstant(localclientnum, 0, f, 0, 0, 0);
            }
            for (f = 0.85; f >= 0.6; f -= rate) {
                util::server_wait(localclientnum, 0.05);
                self setshaderconstant(localclientnum, 0, f, 0, 0, 0);
            }
        }
        for (f = 0.6; f <= 1; f += rate) {
            util::server_wait(localclientnum, 0.05);
            self setshaderconstant(localclientnum, 0, f, 0, 0, 0);
        }
    }
}

// Namespace namespace_ecdcc148
// Params 1, eflags: 0x1 linked
// Checksum 0x277627d2, Offset: 0x8f8
// Size: 0x3c
function function_613e39fa(zomb) {
    self endon(#"hash_d5d2a2ce");
    zomb waittill(#"entityshutdown");
    self delete();
}

