#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/clientfield_shared;
#using scripts/codescripts/struct;

#namespace namespace_cfbe948b;

// Namespace namespace_cfbe948b
// Params 0, eflags: 0x0
// Checksum 0x72867dd5, Offset: 0x1f0
// Size: 0xfc
function init() {
    level._effect["box_open"] = "zombie/fx_weapon_box_open_zod_zmb";
    level._effect["box_closed"] = "zombie/fx_weapon_box_closed_zod_zmb";
    registerclientfield("zbarrier", "magicbox_initial_fx", 1, 1, "int", &function_cc36f894);
    registerclientfield("zbarrier", "magicbox_amb_sound", 1, 1, "int", &function_1c9eb55c);
    registerclientfield("zbarrier", "magicbox_open_fx", 1, 2, "int", &magicbox_open_fx);
}

// Namespace namespace_cfbe948b
// Params 7, eflags: 0x0
// Checksum 0xa0b9e134, Offset: 0x2f8
// Size: 0x286
function magicbox_open_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (!isdefined(self.fx_obj)) {
        self.fx_obj = util::spawn_model(localclientnum, "tag_origin", self.origin, self.angles);
    }
    if (!isdefined(self.var_9b17c542)) {
        self.var_9b17c542 = util::spawn_model(localclientnum, "tag_origin", self.origin, self.angles);
    }
    switch (newval) {
    case 0:
    case 3:
        if (isdefined(self.fx_obj.var_80194315)) {
            stopfx(localclientnum, self.fx_obj.var_80194315);
        }
        self.fx_obj.var_992b4eed = playfxontag(localclientnum, level._effect["box_closed"], self.fx_obj, "tag_origin");
        self.var_9b17c542 stopallloopsounds(1);
        self notify(#"hash_90e6e5c7");
        break;
    case 1:
        if (isdefined(self.fx_obj.var_992b4eed)) {
            stopfx(localclientnum, self.fx_obj.var_992b4eed);
        }
        self.fx_obj.var_80194315 = playfxontag(localclientnum, level._effect["box_open"], self.fx_obj, "tag_origin");
        self.var_9b17c542 playloopsound("zmb_hellbox_open_effect");
        break;
    case 2:
        self.fx_obj delete();
        self.var_9b17c542 delete();
        break;
    }
}

// Namespace namespace_cfbe948b
// Params 7, eflags: 0x0
// Checksum 0x3cfe9f14, Offset: 0x588
// Size: 0xb4
function function_cc36f894(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (!isdefined(self.fx_obj)) {
        self.fx_obj = util::spawn_model(localclientnum, "tag_origin", self.origin, self.angles);
    } else {
        return;
    }
    if (newval == 1) {
        self.fx_obj playloopsound("zmb_hellbox_amb_low");
    }
}

// Namespace namespace_cfbe948b
// Params 7, eflags: 0x0
// Checksum 0x2013f6e0, Offset: 0x648
// Size: 0x174
function function_1c9eb55c(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (!isdefined(self.fx_obj)) {
        self.fx_obj = util::spawn_model(localclientnum, "tag_origin", self.origin, self.angles);
    }
    if (isdefined(self.fx_obj.var_992b4eed)) {
        stopfx(localclientnum, self.fx_obj.var_992b4eed);
    }
    if (newval == 0) {
        self.fx_obj playloopsound("zmb_hellbox_amb_low");
        playsound(0, "zmb_hellbox_leave", self.fx_obj.origin);
        return;
    }
    if (newval == 1) {
        self.fx_obj playloopsound("zmb_hellbox_amb_low");
        playsound(0, "zmb_hellbox_arrive", self.fx_obj.origin);
    }
}

