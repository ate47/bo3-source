#using scripts/zm/_zm_weapons;
#using scripts/shared/beam_shared;
#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/array_shared;
#using scripts/codescripts/struct;

#namespace namespace_f2d05c13;

// Namespace namespace_f2d05c13
// Params 0, eflags: 0x1 linked
// Checksum 0xe332f20f, Offset: 0x3d8
// Size: 0x264
function main() {
    level._effect["console_green_light"] = "dlc1/castle/fx_glow_panel_green_castle";
    level._effect["console_red_light"] = "dlc1/castle/fx_glow_panel_red_castle";
    level._effect["tesla_zombie_shock"] = "dlc1/castle/fx_tesla_trap_body_shock";
    level._effect["tesla_zombie_explode"] = "dlc1/castle/fx_tesla_trap_body_exp";
    clientfield::register("actor", "death_ray_shock_fx", 5000, 1, "int", &function_3852b0a4, 0, 0);
    clientfield::register("actor", "death_ray_shock_eye_fx", 5000, 1, "int", &function_4513798e, 0, 0);
    clientfield::register("actor", "death_ray_explode_fx", 5000, 1, "counter", &function_499e2d1f, 0, 0);
    clientfield::register("scriptmover", "death_ray_status_light", 5000, 2, "int", &function_7939244, 0, 0);
    clientfield::register("actor", "tesla_beam_fx", 5000, 1, "counter", &function_200eea36, 0, 0);
    clientfield::register("toplayer", "tesla_beam_fx", 5000, 1, "counter", &function_200eea36, 0, 0);
    clientfield::register("actor", "tesla_beam_mechz", 5000, 1, "int", &function_1dc0fcb2, 0, 0);
}

// Namespace namespace_f2d05c13
// Params 7, eflags: 0x1 linked
// Checksum 0x7e36bedb, Offset: 0x648
// Size: 0x124
function function_3852b0a4(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self function_51adc559(localclientnum);
    if (newval) {
        if (!isdefined(self.var_8f44671e)) {
            tag = "J_SpineUpper";
            if (!self isai()) {
                tag = "tag_origin";
            }
            self.var_8f44671e = playfxontag(localclientnum, level._effect["tesla_zombie_shock"], self, tag);
            self playsound(0, "zmb_electrocute_zombie");
        }
        if (isdemoplaying()) {
            self thread function_7772592b(localclientnum);
        }
    }
}

// Namespace namespace_f2d05c13
// Params 1, eflags: 0x1 linked
// Checksum 0xdc26ab0d, Offset: 0x778
// Size: 0x4c
function function_7772592b(localclientnum) {
    self notify(#"hash_51adc559");
    self endon(#"hash_51adc559");
    level waittill(#"demo_jump");
    self function_51adc559(localclientnum);
}

// Namespace namespace_f2d05c13
// Params 1, eflags: 0x1 linked
// Checksum 0xb62d7854, Offset: 0x7d0
// Size: 0x52
function function_51adc559(localclientnum) {
    if (isdefined(self.var_8f44671e)) {
        deletefx(localclientnum, self.var_8f44671e, 1);
        self.var_8f44671e = undefined;
    }
    self notify(#"hash_51adc559");
}

// Namespace namespace_f2d05c13
// Params 7, eflags: 0x1 linked
// Checksum 0x68d17467, Offset: 0x830
// Size: 0xc6
function function_4513798e(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval == 1) {
        if (!isdefined(self.var_5f35d5e4)) {
            self.var_5f35d5e4 = playfxontag(localclientnum, level._effect["death_ray_shock_eyes"], self, "J_Eyeball_LE");
        }
        return;
    }
    deletefx(localclientnum, self.var_5f35d5e4, 1);
    self.var_5f35d5e4 = undefined;
}

// Namespace namespace_f2d05c13
// Params 7, eflags: 0x1 linked
// Checksum 0xc097a2b8, Offset: 0x900
// Size: 0x6c
function function_499e2d1f(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    playfxontag(localclientnum, level._effect["tesla_zombie_explode"], self, "j_spine4");
}

// Namespace namespace_f2d05c13
// Params 7, eflags: 0x1 linked
// Checksum 0x2cc74244, Offset: 0x978
// Size: 0x17c
function function_7939244(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    v_forward = anglestoright(self.angles);
    v_forward *= -1;
    v_up = anglestoup(self.angles);
    if (isdefined(self.var_b99efa04)) {
        deletefx(localclientnum, self.var_b99efa04, 1);
        self.var_b99efa04 = undefined;
    }
    switch (newval) {
    case 0:
        break;
    case 1:
        str_fx_name = "console_green_light";
        tag = "tag_fx_light_green";
        break;
    case 2:
        str_fx_name = "console_red_light";
        tag = "tag_fx_light_red";
        break;
    }
    self.var_b99efa04 = playfxontag(localclientnum, level._effect[str_fx_name], self, tag);
}

// Namespace namespace_f2d05c13
// Params 7, eflags: 0x1 linked
// Checksum 0x1abb6518, Offset: 0xb00
// Size: 0x13c
function function_200eea36(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    var_fda0d24 = [];
    array::add(var_fda0d24, struct::get("bolt_source_1"), 0);
    array::add(var_fda0d24, struct::get("bolt_source_2"), 0);
    s_source = arraygetclosest(self.origin, var_fda0d24);
    if (s_source.targetname === "bolt_source_1") {
        str_beam = "electric_arc_beam_tesla_trap_1_primary";
    } else {
        str_beam = "electric_arc_beam_tesla_trap_2_primary";
    }
    self thread function_ec4ecaed(localclientnum, s_source, str_beam);
}

// Namespace namespace_f2d05c13
// Params 3, eflags: 0x1 linked
// Checksum 0x4e3ee856, Offset: 0xc48
// Size: 0xfc
function function_ec4ecaed(localclientnum, s_source, str_beam) {
    var_e43465f2 = util::spawn_model(localclientnum, "tag_origin", s_source.origin, s_source.angles);
    level beam::launch(var_e43465f2, "tag_origin", self, "j_spinelower", str_beam);
    level util::waittill_any_timeout(1.5, "demo_jump");
    level beam::kill(var_e43465f2, "tag_origin", self, "j_spinelower", str_beam);
    var_e43465f2 delete();
}

// Namespace namespace_f2d05c13
// Params 7, eflags: 0x1 linked
// Checksum 0x8e946630, Offset: 0xd50
// Size: 0x1d4
function function_1dc0fcb2(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval == 1) {
        var_fda0d24 = [];
        array::add(var_fda0d24, struct::get("bolt_source_1"), 0);
        array::add(var_fda0d24, struct::get("bolt_source_2"), 0);
        s_source = arraygetclosest(self.origin, var_fda0d24);
        if (s_source.targetname === "bolt_source_1") {
            self.str_beam = "electric_arc_beam_tesla_trap_1_primary";
        } else {
            self.str_beam = "electric_arc_beam_tesla_trap_2_primary";
        }
        self.var_e43465f2 = util::spawn_model(localclientnum, "tag_origin", s_source.origin, s_source.angles);
        level beam::launch(self.var_e43465f2, "tag_origin", self, "j_spinelower", self.str_beam);
        if (isdemoplaying()) {
            self thread function_3c5fc735(localclientnum);
        }
        return;
    }
    function_1139a457(localclientnum);
}

// Namespace namespace_f2d05c13
// Params 1, eflags: 0x1 linked
// Checksum 0xa92b0a90, Offset: 0xf30
// Size: 0x4c
function function_3c5fc735(localclientnum) {
    self notify(#"hash_1139a457");
    self endon(#"hash_1139a457");
    level waittill(#"demo_jump");
    function_1139a457(localclientnum);
}

// Namespace namespace_f2d05c13
// Params 1, eflags: 0x1 linked
// Checksum 0x6ec0dc46, Offset: 0xf88
// Size: 0x8a
function function_1139a457(localclientnum) {
    if (isdefined(self.var_e43465f2) && isdefined(self.str_beam)) {
        level beam::kill(self.var_e43465f2, "tag_origin", self, "j_spinelower", self.str_beam);
        self.var_e43465f2 delete();
        self.str_beam = undefined;
        self notify(#"hash_1139a457");
    }
}

