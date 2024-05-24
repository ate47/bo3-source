#using scripts/zm/_load;
#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/callbacks_shared;
#using scripts/codescripts/struct;

#using_animtree("generic");

#namespace namespace_78528370;

// Namespace namespace_78528370
// Params 0, eflags: 0x0
// Checksum 0xf0fb6c74, Offset: 0x3b0
// Size: 0x254
function init_quest() {
    clientfield::register("vehicle", "plane_hit_by_aa_gun", 9000, 1, "int", &function_3b831537, 0, 0);
    clientfield::register("scriptmover", "zipline_lightning_fx", 9000, 1, "int", &function_bd9975bc, 0, 0);
    clientfield::register("allplayers", "lightning_shield_fx", 9000, 1, "int", &function_ac5c6f58, 1, 1);
    clientfield::register("scriptmover", "smoke_trail_fx", 9000, 1, "int", &function_65a49466, 0, 0);
    clientfield::register("scriptmover", "smoke_smolder_fx", 9000, 1, "int", &function_67a61c, 0, 0);
    clientfield::register("zbarrier", "bgb_lightning_fx", 9000, 1, "int", &function_4a5ead3a, 0, 0);
    clientfield::register("scriptmover", "perk_lightning_fx", 9000, getminbitcountfornum(6), "int", &function_46605813, 0, 0);
    clientfield::register("world", "umbra_tome_outro_igc", 9000, 1, "int", &function_b87c4724, 0, 0);
}

// Namespace namespace_78528370
// Params 7, eflags: 0x0
// Checksum 0x11ddca99, Offset: 0x610
// Size: 0x6c
function function_f0e89ab2(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    playfxontag(localclientnum, level._effect["glow_formula_piece"], self, "j_spineupper");
}

// Namespace namespace_78528370
// Params 7, eflags: 0x0
// Checksum 0xd3e5a533, Offset: 0x688
// Size: 0x6c
function function_e9572f40(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    playfxontag(localclientnum, level._effect["glow_formula_piece"], self, "j_spineupper");
}

// Namespace namespace_78528370
// Params 7, eflags: 0x0
// Checksum 0x643c761c, Offset: 0x700
// Size: 0x11c
function function_3b831537(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval == 1) {
        self.var_563d869a = playfxontag(localclientnum, level._effect["bomber_explode"], self, "tag_engine_inner_left");
        wait(1);
        self.var_303b0c31 = playfxontag(localclientnum, level._effect["bomber_fire_trail"], self, "tag_engine_inner_right");
        return;
    }
    if (isdefined(self.var_563d869a)) {
        deletefx(localclientnum, self.var_a1d64192);
    }
    if (isdefined(self.var_303b0c31)) {
        deletefx(localclientnum, self.var_a1d64192);
    }
}

// Namespace namespace_78528370
// Params 7, eflags: 0x0
// Checksum 0xf78e26ae, Offset: 0x828
// Size: 0x104
function function_bd9975bc(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval == 1) {
        self.var_1f5ac1dc[localclientnum] = playfxontag(localclientnum, level._effect["lightning_shield_control_panel"], self, "tag_origin");
        return;
    }
    if (isdefined(self.var_1f5ac1dc)) {
        a_keys = getarraykeys(self.var_1f5ac1dc);
        if (isinarray(a_keys, localclientnum)) {
            deletefx(localclientnum, self.var_1f5ac1dc[localclientnum], 0);
        }
    }
}

// Namespace namespace_78528370
// Params 7, eflags: 0x0
// Checksum 0xea003b22, Offset: 0x938
// Size: 0x278
function function_ac5c6f58(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    player = getlocalplayer(localclientnum);
    var_ae6a34c0 = player getlocalclientnumber();
    if (newval == 1) {
        self.var_257ef9e4 = [];
        self.var_42ad0d0c = [];
        if (!isspectating(localclientnum)) {
            if (player === self) {
                self.var_ac5c6f58 = playviewmodelfx(localclientnum, level._effect["lightning_shield_1p"], "tag_shield_lightning_fx");
            } else {
                self.var_42ad0d0c[var_ae6a34c0] = undefined;
                self.var_257ef9e4[var_ae6a34c0] = playfxontag(var_ae6a34c0, level._effect["lightning_shield_3p"], self, "tag_shield_lightning_fx");
            }
            self thread function_7ddd182c(localclientnum);
        }
        return;
    }
    self notify(#"hash_1a229bcb");
    if (!isspectating(localclientnum)) {
        if (player === self) {
            if (isdefined(self.var_ac5c6f58)) {
                deletefx(localclientnum, self.var_ac5c6f58);
                self.var_ac5c6f58 = undefined;
            }
            return;
        }
        if (isdefined(self.var_257ef9e4) && isdefined(self.var_257ef9e4[var_ae6a34c0])) {
            deletefx(var_ae6a34c0, self.var_257ef9e4[var_ae6a34c0]);
            self.var_257ef9e4[var_ae6a34c0] = undefined;
        }
        if (isdefined(self.var_42ad0d0c) && isdefined(self.var_42ad0d0c[var_ae6a34c0])) {
            deletefx(var_ae6a34c0, self.var_42ad0d0c[var_ae6a34c0]);
            self.var_42ad0d0c[var_ae6a34c0] = undefined;
        }
    }
}

// Namespace namespace_78528370
// Params 1, eflags: 0x0
// Checksum 0x7a53d024, Offset: 0xbb8
// Size: 0x2f6
function function_7ddd182c(localclientnum) {
    self endon(#"disconnect");
    self endon(#"hash_1a229bcb");
    player = getlocalplayer(localclientnum);
    var_ae6a34c0 = player getlocalclientnumber();
    while (true) {
        self waittill(#"weapon_change");
        currentweapon = getcurrentweapon(localclientnum);
        if (!isspectating(localclientnum)) {
            if (isdefined(currentweapon.isriotshield) && currentweapon.isriotshield) {
                if (player === self) {
                    if (!isdefined(self.var_ac5c6f58)) {
                        self.var_ac5c6f58 = playviewmodelfx(localclientnum, level._effect["lightning_shield_1p"], "tag_shield_lightning_fx");
                    }
                } else {
                    if (isdefined(self.var_42ad0d0c) && isdefined(self.var_42ad0d0c[var_ae6a34c0])) {
                        deletefx(var_ae6a34c0, self.var_42ad0d0c[var_ae6a34c0]);
                        self.var_42ad0d0c[var_ae6a34c0] = undefined;
                    }
                    var_68b2abba = self.var_257ef9e4[var_ae6a34c0];
                    if (!isdefined(var_68b2abba)) {
                        self.var_257ef9e4[var_ae6a34c0] = playfxontag(var_ae6a34c0, level._effect["lightning_shield_3p"], self, "tag_shield_lightning_fx");
                    }
                }
                continue;
            }
            if (!isspectating(localclientnum)) {
                if (player === self) {
                    if (isdefined(self.var_ac5c6f58)) {
                        deletefx(localclientnum, self.var_ac5c6f58);
                        self.var_ac5c6f58 = undefined;
                    }
                    continue;
                }
                if (isdefined(self.var_257ef9e4) && isdefined(self.var_257ef9e4[var_ae6a34c0])) {
                    deletefx(var_ae6a34c0, self.var_257ef9e4[var_ae6a34c0]);
                    self.var_257ef9e4[var_ae6a34c0] = undefined;
                }
                var_14c202b4 = self.var_42ad0d0c[var_ae6a34c0];
                if (!isdefined(var_14c202b4)) {
                    self.var_42ad0d0c[var_ae6a34c0] = playfxontag(var_ae6a34c0, level._effect["lightning_shield_3p"], self, "tag_shield_lightning_fx");
                }
            }
        }
    }
}

// Namespace namespace_78528370
// Params 7, eflags: 0x0
// Checksum 0xdd1ccf0, Offset: 0xeb8
// Size: 0xb4
function function_65a49466(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval == 1) {
        self.var_43991df3 = playfxontag(localclientnum, level._effect["gear_smoke_trail"], self, "tag_origin");
        return;
    }
    if (isdefined(self.var_43991df3)) {
        stopfx(localclientnum, self.var_43991df3);
    }
}

// Namespace namespace_78528370
// Params 7, eflags: 0x0
// Checksum 0xeae35c42, Offset: 0xf78
// Size: 0xb4
function function_67a61c(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval == 1) {
        self.var_e05c9faa = playfxontag(localclientnum, level._effect["gear_smoke_smolder"], self, "tag_origin");
        return;
    }
    if (isdefined(self.var_e05c9faa)) {
        stopfx(localclientnum, self.var_e05c9faa);
    }
}

// Namespace namespace_78528370
// Params 7, eflags: 0x0
// Checksum 0xbd7d6777, Offset: 0x1038
// Size: 0x236
function function_46605813(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    switch (newval) {
    case 0:
        if (isdefined(self.var_99de3d90)) {
            stopfx(localclientnum, self.var_99de3d90);
        }
        break;
    case 1:
        self.var_99de3d90 = playfxontag(localclientnum, level._effect["perk_lightning_fx_dbltap"], self, "tag_origin");
        break;
    case 2:
        self.var_99de3d90 = playfxontag(localclientnum, level._effect["perk_lightning_fx_jugg"], self, "tag_origin");
        break;
    case 3:
        self.var_99de3d90 = playfxontag(localclientnum, level._effect["perk_lightning_fx_revive"], self, "tag_origin");
        break;
    case 4:
        self.var_99de3d90 = playfxontag(localclientnum, level._effect["perk_lightning_fx_speed"], self, "tag_origin");
        break;
    case 5:
        self.var_99de3d90 = playfxontag(localclientnum, level._effect["perk_lightning_fx_staminup"], self, "tag_origin");
        break;
    case 6:
        self.var_99de3d90 = playfxontag(localclientnum, level._effect["perk_lightning_fx_mulekick"], self, "tag_origin");
        break;
    }
}

// Namespace namespace_78528370
// Params 7, eflags: 0x0
// Checksum 0x5f587176, Offset: 0x1278
// Size: 0xcc
function function_4a5ead3a(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval == 1) {
        self.var_543f3d1d = playfxontag(localclientnum, level._effect["bgb_lightning_fx"], self zbarriergetpiece(5), "tag_origin");
        return;
    }
    if (isdefined(self.var_543f3d1d)) {
        stopfx(localclientnum, self.var_543f3d1d);
    }
}

// Namespace namespace_78528370
// Params 7, eflags: 0x0
// Checksum 0x2216789d, Offset: 0x1350
// Size: 0x64
function function_b87c4724(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval == 1) {
        umbra_settometrigger(localclientnum, "bunker_armory_tome");
    }
}

