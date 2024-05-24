#using scripts/zm/_zm_weap_elemental_bow;
#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/fx_shared;
#using scripts/shared/array_shared;
#using scripts/codescripts/struct;

#namespace namespace_156ea490;

// Namespace namespace_156ea490
// Params 0, eflags: 0x2
// Checksum 0xe5bf068, Offset: 0x538
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("_zm_weap_elemental_bow_storm", &__init__, undefined, undefined);
}

// Namespace namespace_156ea490
// Params 0, eflags: 0x0
// Checksum 0xf0c12582, Offset: 0x578
// Size: 0x372
function __init__() {
    clientfield::register("toplayer", "elemental_bow_storm" + "_ambient_bow_fx", 5000, 1, "int", &function_e73829fb, 0, 0);
    clientfield::register("missile", "elemental_bow_storm" + "_arrow_impact_fx", 5000, 1, "int", &function_93740776, 0, 0);
    clientfield::register("missile", "elemental_bow_storm4" + "_arrow_impact_fx", 5000, 1, "int", &function_c50a03db, 0, 0);
    clientfield::register("scriptmover", "elem_storm_fx", 5000, 1, "int", &function_3481f83b, 0, 0);
    clientfield::register("toplayer", "elem_storm_whirlwind_rumble", 1, 1, "int", &function_d6997d17, 0, 0);
    clientfield::register("scriptmover", "elem_storm_bolt_fx", 5000, 1, "int", &function_3b5511c9, 0, 0);
    clientfield::register("scriptmover", "elem_storm_zap_ambient", 5000, 1, "int", &function_ca0ac11f, 0, 0);
    clientfield::register("actor", "elem_storm_shock_fx", 5000, 2, "int", &function_df6db522, 0, 0);
    level._effect["elem_storm_ambient_bow"] = "dlc1/zmb_weapon/fx_bow_storm_ambient_1p_zmb";
    level._effect["elem_storm_arrow_impact"] = "dlc1/zmb_weapon/fx_bow_storm_impact_zmb";
    level._effect["elem_storm_arrow_charged_impact"] = "dlc1/zmb_weapon/fx_bow_storm_impact_ug_zmb";
    level._effect["elem_storm_whirlwind_loop"] = "dlc1/zmb_weapon/fx_bow_storm_funnel_loop_zmb";
    level._effect["elem_storm_whirlwind_end"] = "dlc1/zmb_weapon/fx_bow_storm_funnel_end_zmb";
    level._effect["elem_storm_zap_ambient"] = "dlc1/zmb_weapon/fx_bow_storm_orb_zmb";
    level._effect["elem_storm_zap_bolt"] = "dlc1/zmb_weapon/fx_bow_storm_bolt_zap_zmb";
    level._effect["elem_storm_shock_eyes"] = "zombie/fx_tesla_shock_eyes_zmb";
    level._effect["elem_storm_shock"] = "zombie/fx_tesla_shock_zmb";
    level._effect["elem_storm_shock_nonfatal"] = "zombie/fx_bmode_shock_os_zod_zmb";
}

// Namespace namespace_156ea490
// Params 7, eflags: 0x0
// Checksum 0x6825c11e, Offset: 0x8f8
// Size: 0x64
function function_e73829fb(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self namespace_790026d5::function_3158b481(localclientnum, newval, "elem_storm_ambient_bow");
}

// Namespace namespace_156ea490
// Params 7, eflags: 0x0
// Checksum 0x58223664, Offset: 0x968
// Size: 0x74
function function_93740776(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        playfx(localclientnum, level._effect["elem_storm_arrow_impact"], self.origin);
    }
}

// Namespace namespace_156ea490
// Params 7, eflags: 0x0
// Checksum 0xf325da09, Offset: 0x9e8
// Size: 0x74
function function_c50a03db(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        playfx(localclientnum, level._effect["elem_storm_arrow_charged_impact"], self.origin);
    }
}

// Namespace namespace_156ea490
// Params 7, eflags: 0x0
// Checksum 0x3c0431d5, Offset: 0xa68
// Size: 0xfc
function function_3481f83b(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self endon(#"entityshutdown");
    if (newval) {
        self.var_53f7dac0 = playfxontag(localclientnum, level._effect["elem_storm_whirlwind_loop"], self, "tag_origin");
        return;
    }
    if (isdefined(self.var_53f7dac0)) {
        deletefx(localclientnum, self.var_53f7dac0, 0);
        self.var_53f7dac0 = undefined;
    }
    wait(0.4);
    playfx(localclientnum, level._effect["elem_storm_whirlwind_end"], self.origin);
}

// Namespace namespace_156ea490
// Params 7, eflags: 0x0
// Checksum 0xb5894b1, Offset: 0xb70
// Size: 0x6e
function function_d6997d17(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        self thread function_4d18057(localclientnum);
        return;
    }
    self notify(#"hash_171d986a");
}

// Namespace namespace_156ea490
// Params 1, eflags: 0x0
// Checksum 0xe46d7c5b, Offset: 0xbe8
// Size: 0x60
function function_4d18057(localclientnum) {
    level endon(#"demo_jump");
    self endon(#"hash_171d986a");
    self endon(#"death");
    while (isdefined(self)) {
        self playrumbleonentity(localclientnum, "zod_idgun_vortex_interior");
        wait(0.075);
    }
}

// Namespace namespace_156ea490
// Params 7, eflags: 0x0
// Checksum 0x542b354b, Offset: 0xc50
// Size: 0xfc
function function_3b5511c9(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        if (isdefined(self.var_ca6ae14c)) {
            deletefx(localclientnum, self.var_ca6ae14c, 0);
            self.var_ca6ae14c = undefined;
        }
        v_forward = anglestoforward(self.angles);
        v_up = anglestoup(self.angles);
        self.var_ca6ae14c = playfxontag(localclientnum, level._effect["elem_storm_zap_bolt"], self, "tag_origin");
    }
}

// Namespace namespace_156ea490
// Params 7, eflags: 0x0
// Checksum 0xf60246dd, Offset: 0xd58
// Size: 0xa6
function function_ca0ac11f(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        self.var_dab5ed7 = playfxontag(localclientnum, level._effect["elem_storm_zap_ambient"], self, "tag_origin");
        return;
    }
    deletefx(localclientnum, self.var_dab5ed7, 0);
    self.var_dab5ed7 = undefined;
}

// Namespace namespace_156ea490
// Params 7, eflags: 0x0
// Checksum 0x44f5a072, Offset: 0xe08
// Size: 0x25e
function function_df6db522(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    tag = self isai() ? "J_SpineUpper" : "tag_origin";
    switch (newval) {
    case 0:
        if (isdefined(self.var_a9b1ee1b)) {
            deletefx(localclientnum, self.var_a9b1ee1b, 1);
        }
        if (isdefined(self.var_ae1320f9)) {
            deletefx(localclientnum, self.var_ae1320f9, 1);
        }
        if (isdefined(self.var_523596b1)) {
            deletefx(localclientnum, self.var_523596b1, 1);
        }
        self.var_a9b1ee1b = undefined;
        self.var_ae1320f9 = undefined;
        self.var_bb955880 = undefined;
        break;
    case 1:
        if (!isdefined(self.var_ae1320f9)) {
            self.var_ae1320f9 = playfxontag(localclientnum, level._effect["elem_storm_shock"], self, tag);
        }
        break;
    case 2:
        if (!isdefined(self.var_a9b1ee1b)) {
            self.var_111812ed = playfxontag(localclientnum, level._effect["elem_storm_shock_eyes"], self, "J_Eyeball_LE");
        }
        if (!isdefined(self.var_ae1320f9)) {
            self.var_ae1320f9 = playfxontag(localclientnum, level._effect["elem_storm_shock"], self, tag);
        }
        if (!isdefined(self.var_523596b1)) {
            self.var_523596b1 = playfxontag(localclientnum, level._effect["elem_storm_shock_nonfatal"], self, tag);
        }
        break;
    }
}

