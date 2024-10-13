#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/beam_shared;
#using scripts/shared/audio_shared;
#using scripts/shared/array_shared;
#using scripts/codescripts/struct;

#namespace zm_genesis_skull_turret;

// Namespace zm_genesis_skull_turret
// Params 0, eflags: 0x2
// Checksum 0x83b9515a, Offset: 0x4b8
// Size: 0x3c
function autoexec function_2dc19561() {
    system::register("zm_genesis_skull_turret", &__init__, &__main__, undefined);
}

// Namespace zm_genesis_skull_turret
// Params 0, eflags: 0x1 linked
// Checksum 0x8bf4825, Offset: 0x500
// Size: 0x206
function __init__() {
    clientfield::register("vehicle", "skull_turret", 15000, 2, "int", &function_aeaa2ee6, 0, 0);
    clientfield::register("vehicle", "skull_turret_beam_fire", 15000, 1, "int", &skull_turret_beam_fire, 0, 0);
    clientfield::register("vehicle", "turret_beam_fire_crystal", 15000, 1, "int", &function_a70748cf, 0, 0);
    clientfield::register("actor", "skull_turret_shock_fx", 15000, 1, "int", &skull_turret_shock_fx, 0, 0);
    clientfield::register("actor", "skull_turret_shock_eye_fx", 15000, 1, "int", &skull_turret_shock_eye_fx, 0, 0);
    clientfield::register("actor", "skull_turret_explode_fx", 15000, 1, "counter", &skull_turret_explode_fx, 0, 0);
    level._effect["turret_zombie_shock"] = "dlc4/genesis/fx_tesla_trap_body_shock_red";
    level._effect["turret_zombie_explode"] = "dlc4/genesis/fx_tesla_trap_body_exp_red";
    level._effect["skull_turret_shock_eyes"] = "dlc4/genesis/fx_tesla_shock_eyes_zmb_red";
}

// Namespace zm_genesis_skull_turret
// Params 0, eflags: 0x1 linked
// Checksum 0x99ec1590, Offset: 0x710
// Size: 0x4
function __main__() {
    
}

// Namespace zm_genesis_skull_turret
// Params 7, eflags: 0x1 linked
// Checksum 0x273334ec, Offset: 0x720
// Size: 0xd4
function function_aeaa2ee6(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    function_6818044b(localclientnum, newval);
    if (newval) {
        var_fcb37269 = 1;
        tint = 0;
        if (newval > 1) {
            tint = 1;
        }
        self thread function_6e443da4(localclientnum, var_fcb37269, tint);
        return;
    }
    self thread function_6e443da4(localclientnum, 0, 0);
}

// Namespace zm_genesis_skull_turret
// Params 3, eflags: 0x1 linked
// Checksum 0xc8c460e5, Offset: 0x800
// Size: 0x144
function function_6e443da4(localclientnum, var_fcb37269, tint) {
    self notify(#"hash_6e443da4");
    self endon(#"hash_6e443da4");
    if (!isdefined(self.var_392865b9)) {
        self.var_392865b9 = 0;
    }
    while (self.var_392865b9 != var_fcb37269) {
        if (self.var_392865b9 < var_fcb37269) {
            self.var_392865b9 += 0.033;
            if (self.var_392865b9 > var_fcb37269) {
                self.var_392865b9 = var_fcb37269;
            }
        } else {
            self.var_392865b9 -= 0.033;
            if (self.var_392865b9 < var_fcb37269) {
                self.var_392865b9 = var_fcb37269;
            }
        }
        self mapshaderconstant(localclientnum, 0, "scriptVector2", 0, self.var_392865b9, tint, 0);
        wait 0.016;
    }
    self mapshaderconstant(localclientnum, 0, "scriptVector2", 0, self.var_392865b9, tint, 0);
}

// Namespace zm_genesis_skull_turret
// Params 7, eflags: 0x1 linked
// Checksum 0x9735cd0f, Offset: 0x950
// Size: 0xa4
function skull_turret_beam_fire(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    function_46870125(localclientnum, newval);
    function_1046b72f(localclientnum);
    if (newval) {
        self thread function_463d46bd(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump);
    }
}

// Namespace zm_genesis_skull_turret
// Params 1, eflags: 0x1 linked
// Checksum 0x73b72c68, Offset: 0xa00
// Size: 0x96
function function_1046b72f(localclientnum) {
    self notify(#"hash_f8e6601f");
    if (isdefined(self.var_f929ecf4)) {
        function_6c8292ba(localclientnum);
        level beam::kill(self, "tag_flash", self.var_f929ecf4, "tag_origin", "dlc4_skull_turret_beam");
        self.var_f929ecf4 delete();
        self.var_f929ecf4 = undefined;
    }
}

// Namespace zm_genesis_skull_turret
// Params 1, eflags: 0x1 linked
// Checksum 0x9b123824, Offset: 0xaa0
// Size: 0x7e
function function_6c8292ba(localclientnum) {
    if (isdefined(self.var_805863e3)) {
        level beam::kill(self.var_f929ecf4, "tag_origin", self.var_805863e3, "tag_origin", self.var_4a0d7655);
        self.var_805863e3 delete();
        self.var_805863e3 = undefined;
        self.var_4a0d7655 = undefined;
    }
}

// Namespace zm_genesis_skull_turret
// Params 3, eflags: 0x1 linked
// Checksum 0x4b1a5672, Offset: 0xb28
// Size: 0x160
function function_1b1753c0(localclientnum, origin, var_263c10ef) {
    if (!isdefined(self.var_805863e3)) {
        self.var_805863e3 = util::spawn_model(localclientnum, "tag_origin", origin);
        level beam::launch(self.var_f929ecf4, "tag_origin", self.var_805863e3, "tag_origin", var_263c10ef);
        self.var_4a0d7655 = var_263c10ef;
        return;
    }
    if (self.var_4a0d7655 !== var_263c10ef) {
        level beam::kill(self.var_f929ecf4, "tag_origin", self.var_805863e3, "tag_origin", self.var_4a0d7655);
        self.var_805863e3.origin = origin;
        level beam::launch(self.var_f929ecf4, "tag_origin", self.var_805863e3, "tag_origin", var_263c10ef);
        self.var_4a0d7655 = var_263c10ef;
        return;
    }
    self.var_805863e3.origin = origin;
}

// Namespace zm_genesis_skull_turret
// Params 7, eflags: 0x1 linked
// Checksum 0xb8e72368, Offset: 0xc90
// Size: 0x100
function function_463d46bd(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self notify(#"hash_f8e6601f");
    self endon(#"hash_f8e6601f");
    self.var_f929ecf4 = util::spawn_model(localclientnum, "tag_origin", self.origin);
    level beam::launch(self, "tag_flash", self.var_f929ecf4, "tag_origin", "dlc4_skull_turret_beam");
    while (isdefined(self)) {
        function_b578a840(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump);
        wait 0.016;
    }
}

// Namespace zm_genesis_skull_turret
// Params 7, eflags: 0x1 linked
// Checksum 0x1b9f9d31, Offset: 0xd98
// Size: 0x42c
function function_b578a840(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    v_position = self gettagorigin("tag_aim");
    v_forward = anglestoforward(self gettagangles("tag_aim"));
    a_trace = beamtrace(v_position, v_position + v_forward * 20000, 1, self);
    self.var_f929ecf4.origin = a_trace["position"];
    self.var_f929ecf4.angles = vectortoangles(v_forward);
    function_cd048702(v_position, self.var_f929ecf4.origin, (1, 1, 0));
    render_debug_sphere(v_position, (1, 1, 0));
    render_debug_sphere(self.var_f929ecf4.origin, (1, 0, 0));
    var_c18b4417 = 0;
    if (isdefined(a_trace["entity"])) {
        e_last_target = a_trace["entity"];
        var_c18b4417 = 1;
        if (e_last_target.model === "p7_zm_ctl_crystal") {
            var_c18b4417 = 1;
        }
    }
    if (a_trace["surfacetype"] === "metal" || a_trace["surfacetype"] === "metalcar" || a_trace["surfacetype"] === "glass" || a_trace["surfacetype"] === "glasscar") {
        var_c18b4417 = 1;
    }
    if (var_c18b4417) {
        if (e_last_target.archetype !== "zombie" && (!isdefined(e_last_target) || e_last_target.archetype !== "parasite")) {
            v_forward = reflect_shot(v_forward, a_trace["normal"]);
        }
        self.var_f929ecf4.angles = vectortoangles(v_forward);
        v_position = self.var_f929ecf4.origin;
        a_trace = beamtrace(v_position, v_position + v_forward * 20000, 1, self);
        var_263c10ef = "dlc4_skull_turret_beam_reflect";
        if (e_last_target.archetype === "zombie" || isdefined(e_last_target) && e_last_target.archetype === "parasite") {
            var_263c10ef = "dlc4_skull_turret_beam";
        }
        function_1b1753c0(localclientnum, a_trace["position"], var_263c10ef);
        function_cd048702(v_position, self.var_805863e3.origin, (1, 1, 0));
        render_debug_sphere(self.var_805863e3.origin, (1, 0, 0));
        return;
    }
    function_6c8292ba(localclientnum);
}

// Namespace zm_genesis_skull_turret
// Params 2, eflags: 0x1 linked
// Checksum 0x7b2f3661, Offset: 0x11d0
// Size: 0x64
function reflect_shot(d, n) {
    perp = 2 * vectordot(d, n);
    var_e47d2859 = d - perp * n;
    return var_e47d2859;
}

// Namespace zm_genesis_skull_turret
// Params 2, eflags: 0x1 linked
// Checksum 0x4b285fb, Offset: 0x1240
// Size: 0x64
function render_debug_sphere(origin, color) {
    if (getdvarint("turret_debug")) {
        /#
            sphere(origin, 2, color, 0.75, 1, 10, 100);
        #/
    }
}

// Namespace zm_genesis_skull_turret
// Params 3, eflags: 0x1 linked
// Checksum 0x82520e08, Offset: 0x12b0
// Size: 0x64
function function_cd048702(origin1, origin2, color) {
    if (getdvarint("turret_debug")) {
        /#
            line(origin1, origin2, color, 0.75, 1, 100);
        #/
    }
}

// Namespace zm_genesis_skull_turret
// Params 7, eflags: 0x1 linked
// Checksum 0xa90b8f75, Offset: 0x1320
// Size: 0x76
function function_a70748cf(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval == 1) {
        self thread function_9f90a4b0(localclientnum);
        return;
    }
    level notify(#"hash_bd0e918");
}

// Namespace zm_genesis_skull_turret
// Params 1, eflags: 0x1 linked
// Checksum 0xa26d3b1b, Offset: 0x13a0
// Size: 0x284
function function_9f90a4b0(localclientnum) {
    var_9d322e2e = struct::get_array("115_crystals", "script_noteworthy");
    s_target = arraygetclosest(self.origin, var_9d322e2e);
    var_f929ecf4 = util::spawn_model(localclientnum, "tag_origin", s_target.origin);
    var_1d74a070 = struct::get("ee_beam_sophia", "targetname");
    var_b4e42dd3 = util::spawn_model(localclientnum, "tag_origin", var_1d74a070.origin, var_1d74a070.angles);
    level beam::launch(self, "tag_flash", var_f929ecf4, "tag_origin", "dlc4_skull_turret_beam");
    level beam::launch(var_f929ecf4, "tag_origin", var_b4e42dd3, "tag_origin", "dlc4_skull_turret_beam_reflect");
    audio::playloopat("wpn_skull_turret_loop", self.origin);
    level waittill(#"hash_bd0e918");
    audio::stoploopat("wpn_skull_turret_loop", self.origin);
    playsound(0, "wpn_skull_turret_stop", self.origin);
    level beam::kill(self, "tag_flash", var_f929ecf4, "tag_origin", "dlc4_skull_turret_beam");
    level beam::kill(var_f929ecf4, "tag_origin", var_b4e42dd3, "tag_origin", "dlc4_skull_turret_beam_reflect");
    var_f929ecf4 delete();
    var_b4e42dd3 delete();
}

// Namespace zm_genesis_skull_turret
// Params 7, eflags: 0x1 linked
// Checksum 0x2f085b7f, Offset: 0x1630
// Size: 0xfe
function skull_turret_shock_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        if (!isdefined(self.var_2fdeee05)) {
            str_tag = "J_SpineUpper";
            if (!self isai()) {
                str_tag = "tag_origin";
            }
            self.var_2fdeee05 = playfxontag(localclientnum, level._effect["turret_zombie_shock"], self, str_tag);
        }
        return;
    }
    if (isdefined(self.var_2fdeee05)) {
        deletefx(localclientnum, self.var_2fdeee05, 1);
        self.var_2fdeee05 = undefined;
    }
}

// Namespace zm_genesis_skull_turret
// Params 7, eflags: 0x1 linked
// Checksum 0x6d1ba75, Offset: 0x1738
// Size: 0x116
function skull_turret_shock_eye_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval == 1) {
        if (!isdefined(self.var_9724eab9)) {
            self.var_9724eab9 = playfxontag(localclientnum, level._effect["skull_turret_shock_eyes"], self, "J_Eyeball_LE");
            sndorigin = self gettagorigin("J_Eyeball_LE");
            playsound(0, "zmb_vocals_zombie_skull_scream", sndorigin);
        }
        return;
    }
    deletefx(localclientnum, self.var_9724eab9, 1);
    self.var_9724eab9 = undefined;
}

// Namespace zm_genesis_skull_turret
// Params 7, eflags: 0x1 linked
// Checksum 0x61c0d840, Offset: 0x1858
// Size: 0x94
function skull_turret_explode_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    playfxontag(localclientnum, level._effect["turret_zombie_explode"], self, "j_spine4");
    playsound(0, "zmb_zombie_skull_explode", self.origin);
}

// Namespace zm_genesis_skull_turret
// Params 2, eflags: 0x1 linked
// Checksum 0x15c4f34c, Offset: 0x18f8
// Size: 0x7c
function function_6818044b(localclientnum, var_365c612) {
    if (isdefined(self.var_341294b1)) {
        deletefx(localclientnum, self.var_341294b1);
        self.var_341294b1 = undefined;
    }
    if (var_365c612) {
        self.var_341294b1 = playfxontag(localclientnum, "dlc4/genesis/fx_skullturret_active", self, "tag_turret");
    }
}

// Namespace zm_genesis_skull_turret
// Params 2, eflags: 0x1 linked
// Checksum 0x17ea1b06, Offset: 0x1980
// Size: 0x7c
function function_46870125(localclientnum, var_365c612) {
    if (isdefined(self.var_dada95a7)) {
        deletefx(localclientnum, self.var_dada95a7);
        self.var_dada95a7 = undefined;
    }
    if (var_365c612) {
        self.var_dada95a7 = playfxontag(localclientnum, "dlc4/genesis/fx_skullturret_eyes", self, "tag_fx");
    }
}

