#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/clientfield_shared;

#namespace namespace_bafc277e;

// Namespace namespace_bafc277e
// Params 0, eflags: 0x2
// namespace_bafc277e<file_0>::function_2dc19561
// Checksum 0x92f4c972, Offset: 0x220
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("tomb_magicbox", &__init__, undefined, undefined);
}

// Namespace namespace_bafc277e
// Params 0, eflags: 0x1 linked
// namespace_bafc277e<file_0>::function_8c87d8eb
// Checksum 0x16db8f03, Offset: 0x260
// Size: 0x124
function __init__() {
    clientfield::register("zbarrier", "magicbox_initial_fx", 21000, 1, "int", &function_cc36f894, 0, 0);
    clientfield::register("zbarrier", "magicbox_amb_fx", 21000, 2, "int", &function_ae458229, 0, 0);
    clientfield::register("zbarrier", "magicbox_open_fx", 21000, 1, "int", &magicbox_open_fx, 0, 0);
    clientfield::register("zbarrier", "magicbox_leaving_fx", 21000, 1, "int", &function_cac7ed81, 0, 0);
}

// Namespace namespace_bafc277e
// Params 7, eflags: 0x1 linked
// namespace_bafc277e<file_0>::function_cac7ed81
// Checksum 0x8d02cd90, Offset: 0x390
// Size: 0x104
function function_cac7ed81(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
    if (!isdefined(self.fx_obj)) {
        self.fx_obj = spawn(localclientnum, self.origin, "script_model");
        self.fx_obj.angles = self.angles;
        self.fx_obj setmodel("tag_origin");
    }
    if (newval == 1) {
        self.fx_obj.var_6217501d = playfxontag(localclientnum, level._effect["box_is_leaving"], self.fx_obj, "tag_origin");
    }
}

// Namespace namespace_bafc277e
// Params 7, eflags: 0x1 linked
// namespace_bafc277e<file_0>::function_c8f2b7a1
// Checksum 0xe0cb8762, Offset: 0x4a0
// Size: 0x20c
function magicbox_open_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
    if (!isdefined(self.fx_obj)) {
        self.fx_obj = spawn(localclientnum, self.origin, "script_model");
        self.fx_obj.angles = self.angles;
        self.fx_obj setmodel("tag_origin");
    }
    if (!isdefined(self.var_9b17c542)) {
        self.var_9b17c542 = spawn(localclientnum, self.origin, "script_model");
        self.var_9b17c542.angles = self.angles;
        self.var_9b17c542 setmodel("tag_origin");
    }
    if (newval == 0) {
        stopfx(localclientnum, self.fx_obj.var_80194315);
        self.var_9b17c542 stoploopsound(1);
        self notify(#"hash_90e6e5c7");
        return;
    }
    if (newval == 1) {
        self.fx_obj.var_80194315 = playfxontag(localclientnum, level._effect["box_is_open"], self.fx_obj, "tag_origin");
        self.var_9b17c542 playloopsound("zmb_hellbox_open_effect");
        self thread function_b714c89b(localclientnum);
    }
}

// Namespace namespace_bafc277e
// Params 1, eflags: 0x1 linked
// namespace_bafc277e<file_0>::function_b714c89b
// Checksum 0x56ec1106, Offset: 0x6b8
// Size: 0x8c
function function_b714c89b(localclientnum) {
    wait(0.5);
    self.var_9b17c542.var_a5875243 = playfxontag(localclientnum, level._effect["box_portal"], self.var_9b17c542, "tag_origin");
    self waittill(#"hash_90e6e5c7");
    stopfx(localclientnum, self.var_9b17c542.var_a5875243);
}

// Namespace namespace_bafc277e
// Params 7, eflags: 0x1 linked
// namespace_bafc277e<file_0>::function_cc36f894
// Checksum 0xe6a4def0, Offset: 0x750
// Size: 0xe4
function function_cc36f894(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
    if (!isdefined(self.fx_obj)) {
        self.fx_obj = spawn(localclientnum, self.origin, "script_model");
        self.fx_obj.angles = self.angles;
        self.fx_obj setmodel("tag_origin");
    } else {
        return;
    }
    if (newval == 1) {
        self.fx_obj playloopsound("zmb_hellbox_amb_low");
    }
}

// Namespace namespace_bafc277e
// Params 7, eflags: 0x1 linked
// namespace_bafc277e<file_0>::function_ae458229
// Checksum 0x9fac0535, Offset: 0x840
// Size: 0x474
function function_ae458229(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
    if (!isdefined(self.fx_obj)) {
        self.fx_obj = spawn(localclientnum, self.origin, "script_model");
        self.fx_obj.angles = self.angles;
        self.fx_obj setmodel("tag_origin");
    }
    if (isdefined(self.fx_obj.var_992b4eed)) {
        stopfx(localclientnum, self.fx_obj.var_992b4eed);
    }
    if (isdefined(self.fx_obj.var_9eb800bb)) {
        stopfx(localclientnum, self.fx_obj.var_9eb800bb);
    }
    if (newval == 0) {
        self.fx_obj playloopsound("zmb_hellbox_amb_low");
        playsound(0, "zmb_hellbox_leave", self.fx_obj.origin);
        stopfx(localclientnum, self.fx_obj.var_992b4eed);
        return;
    }
    if (newval == 1) {
        self.fx_obj.var_9eb800bb = playfxontag(localclientnum, level._effect["box_unpowered"], self.fx_obj, "tag_origin");
        self.fx_obj.var_992b4eed = playfxontag(localclientnum, level._effect["box_here_ambient"], self.fx_obj, "tag_origin");
        self.fx_obj playloopsound("zmb_hellbox_amb_low");
        playsound(0, "zmb_hellbox_arrive", self.fx_obj.origin);
        return;
    }
    if (newval == 2) {
        self.fx_obj.var_9eb800bb = playfxontag(localclientnum, level._effect["box_powered"], self.fx_obj, "tag_origin");
        self.fx_obj.var_992b4eed = playfxontag(localclientnum, level._effect["box_here_ambient"], self.fx_obj, "tag_origin");
        self.fx_obj playloopsound("zmb_hellbox_amb_high");
        playsound(0, "zmb_hellbox_arrive", self.fx_obj.origin);
        return;
    }
    if (newval == 3) {
        self.fx_obj.var_9eb800bb = playfxontag(localclientnum, level._effect["box_unpowered"], self.fx_obj, "tag_origin");
        self.fx_obj.var_992b4eed = playfxontag(localclientnum, level._effect["box_gone_ambient"], self.fx_obj, "tag_origin");
        self.fx_obj playloopsound("zmb_hellbox_amb_high");
        playsound(0, "zmb_hellbox_leave", self.fx_obj.origin);
    }
}

