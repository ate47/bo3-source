#using scripts/zm/_zm_weapons;
#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/callbacks_shared;
#using scripts/codescripts/struct;

#namespace namespace_f777c489;

// Namespace namespace_f777c489
// Params 0, eflags: 0x1 linked
// Checksum 0xbd4be237, Offset: 0x2d8
// Size: 0x1ac
function init() {
    var_b20c97f = getminbitcountfornum(7);
    var_1b7d5552 = getminbitcountfornum(3);
    clientfield::register("scriptmover", "side_ee_gt_spore_glow_fx", 9000, 1, "int", &function_f72d6a5e, 0, 0);
    clientfield::register("scriptmover", "side_ee_gt_spore_cloud_fx", 9000, var_b20c97f, "int", &function_7583072e, 0, 0);
    clientfield::register("actor", "side_ee_gt_spore_trail_enemy_fx", 9000, 1, "int", &function_f68bb4e3, 0, 0);
    clientfield::register("allplayers", "side_ee_gt_spore_trail_player_fx", 9000, var_1b7d5552, "int", &function_f68bb4e3, 0, 0);
    clientfield::register("actor", "good_thrasher_fx", 9000, 1, "int", &function_9993f1d3, 0, 0);
}

// Namespace namespace_f777c489
// Params 7, eflags: 0x1 linked
// Checksum 0x87eea4de, Offset: 0x490
// Size: 0x116
function function_f72d6a5e(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval == 1) {
        if (isdefined(self.var_a1aff3d8)) {
            stopfx(localclientnum, self.var_a1aff3d8);
        }
        self.var_a1aff3d8 = playfx(localclientnum, level._effect["SPORE_GLOW"], self.origin, anglestoforward(self.angles), anglestoup(self.angles));
        return;
    }
    if (isdefined(self.var_a1aff3d8)) {
        stopfx(localclientnum, self.var_a1aff3d8);
        self.var_a1aff3d8 = undefined;
    }
}

// Namespace namespace_f777c489
// Params 7, eflags: 0x1 linked
// Checksum 0x5ecc3137, Offset: 0x5b0
// Size: 0x19e
function function_7583072e(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval >= 1) {
        var_74df34f7 = arraygetclosest(self.origin, struct::get_array("s_side_ee_gt_spore_pos"));
        var_38c08794 = var_74df34f7;
        var_828d501f = var_74df34f7;
        var_a506772a = var_74df34f7;
        playfx(localclientnum, level._effect["SPORE_CLOUD_EXP_GOOD_LG"], var_74df34f7.origin, anglestoforward(var_74df34f7.angles));
        self.var_b76ed967 = playfx(localclientnum, level._effect["SPORE_CLOUD_GOOD_LG"], var_a506772a.origin, anglestoforward(var_a506772a.angles));
        return;
    }
    if (isdefined(self.var_b76ed967)) {
        stopfx(localclientnum, self.var_b76ed967);
        self.var_b76ed967 = undefined;
    }
}

// Namespace namespace_f777c489
// Params 7, eflags: 0x1 linked
// Checksum 0xb0becb6b, Offset: 0x758
// Size: 0xee
function function_f68bb4e3(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval > 0) {
        if (isdefined(self.var_3ecc4b30)) {
            stopfx(localclientnum, self.var_3ecc4b30);
            self.var_3ecc4b30 = undefined;
        }
        self.var_3ecc4b30 = playfxontag(localclientnum, level._effect["SPORE_TRAIL_GOOD"], self, "j_spine4");
        return;
    }
    if (isdefined(self.var_3ecc4b30)) {
        stopfx(localclientnum, self.var_3ecc4b30);
        self.var_3ecc4b30 = undefined;
    }
}

// Namespace namespace_f777c489
// Params 7, eflags: 0x1 linked
// Checksum 0x960bc75, Offset: 0x850
// Size: 0x28a
function function_9993f1d3(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval == 1) {
        if (isdefined(self.fx_ids)) {
            foreach (fx_id in self.fx_ids) {
                stopfx(localclientnum, fx_id);
            }
        }
        self.fx_ids = [];
        self.fx_ids["eyes"] = playfxontag(localclientnum, level._effect["SIDE_EE_GT_EYES"], self, "j_eyeball_le");
        self.fx_ids["spine"] = playfxontag(localclientnum, level._effect["SIDE_EE_GT_SPINE"], self, "j_spinelower");
        self.fx_ids["leg_l"] = playfxontag(localclientnum, level._effect["SIDE_EE_GT_LEG_L"], self, "j_hip_le");
        self.fx_ids["leg_r"] = playfxontag(localclientnum, level._effect["SIDE_EE_GT_LEG_R"], self, "j_hip_rt");
        return;
    }
    if (isdefined(self.fx_ids)) {
        foreach (fx_id in self.fx_ids) {
            stopfx(localclientnum, fx_id);
        }
        self.fx_ids = undefined;
    }
}

