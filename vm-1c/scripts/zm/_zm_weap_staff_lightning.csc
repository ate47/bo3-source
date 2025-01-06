#using scripts/shared/clientfield_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/zm/_zm_weap_staff_common;

#namespace zm_weap_staff_lightning;

// Namespace zm_weap_staff_lightning
// Params 0, eflags: 0x2
// Checksum 0x82bd8c9c, Offset: 0x2e0
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("zm_weap_staff_lightning", &__init__, undefined, undefined);
}

// Namespace zm_weap_staff_lightning
// Params 0, eflags: 0x0
// Checksum 0xea4dcba1, Offset: 0x320
// Size: 0x184
function __init__() {
    level._effect["lightning_miss"] = "dlc5/zmb_weapon/fx_staff_elec_impact_ug_miss";
    level._effect["lightning_arc"] = "dlc5/zmb_weapon/fx_staff_elec_trail_bolt_cheap";
    level._effect["lightning_impact"] = "dlc5/zmb_weapon/fx_staff_elec_impact_ug_hit_torso";
    level._effect["tesla_shock_eyes"] = "zombie/fx_tesla_shock_eyes_zmb";
    clientfield::register("actor", "lightning_impact_fx", 21000, 1, "int", &function_41819534, 0, 0);
    clientfield::register("scriptmover", "lightning_miss_fx", 21000, 1, "int", &function_6a2c832a, 0, 0);
    clientfield::register("actor", "lightning_arc_fx", 21000, 1, "int", &function_fb3ed342, 0, 0);
    level.var_1d5f245c = [];
    zm_weap_staff::function_4be5e665(getweapon("staff_lightning_upgraded"), "dlc5/zmb_weapon/fx_staff_charge_elec_lv1");
}

// Namespace zm_weap_staff_lightning
// Params 7, eflags: 0x0
// Checksum 0x9fcee703, Offset: 0x4b0
// Size: 0x94
function function_41819534(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
    if (newval) {
        playfxontag(localclientnum, level._effect["lightning_impact"], self, "J_SpineUpper");
        self playsound(0, "wpn_imp_lightningstaff");
    }
}

// Namespace zm_weap_staff_lightning
// Params 7, eflags: 0x0
// Checksum 0xb771c5c6, Offset: 0x550
// Size: 0x102
function function_6a2c832a(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
    if (newval) {
        playfxontag(localclientnum, level._effect["lightning_miss"], self, "tag_origin");
        level.var_1d5f245c[localclientnum] = self;
        ent = spawn(0, self.origin, "script_origin");
        ent linkto(self);
        self thread function_80209369(localclientnum, ent);
        level notify(#"lightning_ball_created");
    }
}

// Namespace zm_weap_staff_lightning
// Params 2, eflags: 0x0
// Checksum 0xccfe6267, Offset: 0x660
// Size: 0x40
function function_80209369(localclientnum, ent) {
    self waittill(#"entityshutdown");
    ent delete();
    level.var_1d5f245c[localclientnum] = undefined;
}

// Namespace zm_weap_staff_lightning
// Params 1, eflags: 0x0
// Checksum 0x55347330, Offset: 0x6a8
// Size: 0x1f8
function function_749acb79(localclientnum) {
    self endon(#"entityshutdown");
    self endon(#"hash_7a8f9f49");
    if (!isdefined(level.var_1d5f245c[localclientnum])) {
        level waittill(#"lightning_ball_created");
    }
    e_ball = level.var_1d5f245c[localclientnum];
    e_ball endon(#"entityshutdown");
    util::server_wait(localclientnum, randomfloatrange(0.1, 0.5));
    self.e_fx = spawn(localclientnum, e_ball.origin, "script_model");
    self.e_fx setmodel("tag_origin");
    self.fx_arc = playfxontag(localclientnum, level._effect["lightning_arc"], self.e_fx, "tag_origin");
    while (true) {
        var_8d0b58f1 = self gettagorigin("J_SpineUpper");
        self.e_fx moveto(var_8d0b58f1, 0.1);
        util::server_wait(localclientnum, 0.5);
        self.e_fx moveto(e_ball.origin, 0.1);
        util::server_wait(localclientnum, 0.5);
    }
}

// Namespace zm_weap_staff_lightning
// Params 7, eflags: 0x0
// Checksum 0xb75706ca, Offset: 0x8a8
// Size: 0xd6
function function_fb3ed342(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
    if (newval) {
        self thread function_749acb79(localclientnum);
        return;
    }
    self notify(#"hash_7a8f9f49");
    if (isdefined(self.fx_arc)) {
        stopfx(localclientnum, self.fx_arc);
        self.fx_arc = undefined;
    }
    if (isdefined(self.e_fx)) {
        self.e_fx delete();
        self.e_fx = undefined;
    }
}

