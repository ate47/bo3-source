#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/fx_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/callbacks_shared;
#using scripts/codescripts/struct;

#namespace namespace_19e79ea1;

// Namespace namespace_19e79ea1
// Params 0, eflags: 0x2
// namespace_19e79ea1<file_0>::function_2dc19561
// Checksum 0xc244c572, Offset: 0x230
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("zm_stalingrad_dragon_strike", &__init__, undefined, undefined);
}

// Namespace namespace_19e79ea1
// Params 0, eflags: 0x1 linked
// namespace_19e79ea1<file_0>::function_8c87d8eb
// Checksum 0x58c0319b, Offset: 0x270
// Size: 0x124
function __init__() {
    clientfield::register("scriptmover", "lockbox_light_1", 12000, 2, "int", &function_5f0e6212, 0, 0);
    clientfield::register("scriptmover", "lockbox_light_2", 12000, 2, "int", &function_390be7a9, 0, 0);
    clientfield::register("scriptmover", "lockbox_light_3", 12000, 2, "int", &function_13096d40, 0, 0);
    clientfield::register("scriptmover", "lockbox_light_4", 12000, 2, "int", &function_1d1ac61f, 0, 0);
}

// Namespace namespace_19e79ea1
// Params 7, eflags: 0x1 linked
// namespace_19e79ea1<file_0>::function_5f0e6212
// Checksum 0x3ca1eda7, Offset: 0x3a0
// Size: 0xec
function function_5f0e6212(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (isdefined(self.var_fbe6c07a)) {
        stopfx(localclientnum, self.var_fbe6c07a);
    }
    if (newval == 2) {
        self.var_fbe6c07a = playfxontag(localclientnum, "dlc3/stalingrad/fx_glow_red_dragonstrike", self, "tag_nixie_red_" + "0");
        return;
    }
    self.var_fbe6c07a = playfxontag(localclientnum, "dlc3/stalingrad/fx_glow_green_dragonstrike", self, "tag_nixie_green_" + "0");
}

// Namespace namespace_19e79ea1
// Params 7, eflags: 0x1 linked
// namespace_19e79ea1<file_0>::function_390be7a9
// Checksum 0x5c8654a, Offset: 0x498
// Size: 0xec
function function_390be7a9(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (isdefined(self.var_d5e44611)) {
        stopfx(localclientnum, self.var_d5e44611);
    }
    if (newval == 2) {
        self.var_d5e44611 = playfxontag(localclientnum, "dlc3/stalingrad/fx_glow_red_dragonstrike", self, "tag_nixie_red_" + "1");
        return;
    }
    self.var_d5e44611 = playfxontag(localclientnum, "dlc3/stalingrad/fx_glow_green_dragonstrike", self, "tag_nixie_green_" + "1");
}

// Namespace namespace_19e79ea1
// Params 7, eflags: 0x1 linked
// namespace_19e79ea1<file_0>::function_13096d40
// Checksum 0x582aae33, Offset: 0x590
// Size: 0xec
function function_13096d40(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (isdefined(self.var_afe1cba8)) {
        stopfx(localclientnum, self.var_afe1cba8);
    }
    if (newval == 2) {
        self.var_afe1cba8 = playfxontag(localclientnum, "dlc3/stalingrad/fx_glow_red_dragonstrike", self, "tag_nixie_red_" + "2");
        return;
    }
    self.var_afe1cba8 = playfxontag(localclientnum, "dlc3/stalingrad/fx_glow_green_dragonstrike", self, "tag_nixie_green_" + "2");
}

// Namespace namespace_19e79ea1
// Params 7, eflags: 0x1 linked
// namespace_19e79ea1<file_0>::function_1d1ac61f
// Checksum 0x1b5c4922, Offset: 0x688
// Size: 0xec
function function_1d1ac61f(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (isdefined(self.var_b9f32487)) {
        stopfx(localclientnum, self.var_b9f32487);
    }
    if (newval == 2) {
        self.var_b9f32487 = playfxontag(localclientnum, "dlc3/stalingrad/fx_glow_red_dragonstrike", self, "tag_nixie_red_" + "3");
        return;
    }
    self.var_b9f32487 = playfxontag(localclientnum, "dlc3/stalingrad/fx_glow_green_dragonstrike", self, "tag_nixie_green_" + "3");
}

