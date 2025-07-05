#using scripts/shared/clientfield_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/zm/_zm_weap_staff_common;

#namespace zm_weap_staff_water;

// Namespace zm_weap_staff_water
// Params 0, eflags: 0x2
// Checksum 0x19af50fb, Offset: 0x2e0
// Size: 0x34
function autoexec __init__sytem__() {
    system::register("zm_weap_staff_water", &__init__, undefined, undefined);
}

// Namespace zm_weap_staff_water
// Params 0, eflags: 0x0
// Checksum 0x25546eb0, Offset: 0x320
// Size: 0x1bc
function __init__() {
    clientfield::register("scriptmover", "staff_blizzard_fx", 21000, 1, "int", &staff_blizzard_fx, 1, 0);
    clientfield::register("actor", "attach_bullet_model", 21000, 1, "int", &function_fe22f274, 0, 0);
    clientfield::register("actor", "staff_shatter_fx", 21000, 1, "int", &staff_shatter_fx, 0, 0);
    level._effect["staff_water_blizzard"] = "dlc5/zmb_weapon/fx_staff_ice_impact_ug_hit";
    level._effect["staff_water_ice_shard"] = "dlc5/zmb_weapon/fx_staff_ice_trail_bolt";
    level._effect["staff_water_shatter"] = "dlc5/zmb_weapon/fx_staff_ice_exp";
    clientfield::register("actor", "anim_rate", 21000, 2, "float", undefined, 0, 0);
    setupclientfieldanimspeedcallbacks("actor", 1, "anim_rate");
    zm_weap_staff::function_4be5e665(getweapon("staff_water_upgraded"), "dlc5/zmb_weapon/fx_staff_charge_ice_lv1");
}

// Namespace zm_weap_staff_water
// Params 7, eflags: 0x0
// Checksum 0xe02fc1bb, Offset: 0x4e8
// Size: 0x134
function function_fe22f274(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
    if (newval == 1) {
        if (isdefined(self.var_69090dac)) {
            stopfx(localclientnum, self.var_69090dac);
        }
        self.var_69090dac = playfxontag(localclientnum, level._effect["staff_water_ice_shard"], self, "j_spine4");
        self thread function_9a8e9819(localclientnum);
        self playsound(0, "wpn_waterstaff_freeze_zombie");
        return;
    }
    if (isdefined(self.var_69090dac)) {
        deletefx(localclientnum, self.var_69090dac);
        self.var_69090dac = undefined;
    }
    self thread function_56ddd8d9(localclientnum);
}

// Namespace zm_weap_staff_water
// Params 1, eflags: 0x0
// Checksum 0x68303d64, Offset: 0x628
// Size: 0xea
function function_9a8e9819(localclientnum) {
    self endon(#"entityshutdown");
    self endon(#"unfreeze");
    var_5e5728a8 = 0.9;
    rate = randomfloatrange(0.005, 0.01);
    for (f = 0.6; f <= var_5e5728a8; f += 0.01) {
        self setshaderconstant(localclientnum, 0, f, 1, 0, 0);
        util::server_wait(localclientnum, 0.05);
    }
}

// Namespace zm_weap_staff_water
// Params 1, eflags: 0x0
// Checksum 0x8199d85b, Offset: 0x720
// Size: 0xc4
function function_56ddd8d9(localclientnum) {
    self endon(#"entityshutdown");
    self notify(#"unfreeze");
    for (f = 1; f >= 0.6; f -= 0.05) {
        self setshaderconstant(localclientnum, 0, f, 1, 0, 0);
        util::server_wait(localclientnum, 0.05);
    }
    self setshaderconstant(localclientnum, 0, 0, 0, 0, 0);
}

// Namespace zm_weap_staff_water
// Params 7, eflags: 0x0
// Checksum 0x5fad75c0, Offset: 0x7f0
// Size: 0x19e
function staff_blizzard_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
    if (newval == 1) {
        self.var_80b4df3 = playfxontag(localclientnum, level._effect["staff_water_blizzard"], self, "tag_origin");
        if (!isdefined(self.sndent)) {
            self.sndent = spawn(0, self.origin, "script_origin");
            self.sndent playsound(0, "wpn_waterstaff_storm_imp");
            self.sndent.n_id = self.sndent playloopsound("wpn_waterstaff_storm");
        }
        return;
    }
    if (isdefined(self.var_80b4df3)) {
        stopfx(localclientnum, self.var_80b4df3);
    }
    if (isdefined(self.sndent)) {
        self.sndent stoploopsound(self.sndent.n_id, 1.5);
        self.sndent delete();
        self.sndent = undefined;
    }
}

// Namespace zm_weap_staff_water
// Params 7, eflags: 0x0
// Checksum 0xd8c475fd, Offset: 0x998
// Size: 0x84
function staff_shatter_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
    if (newval == 1) {
        self.var_5d11d365 = playfxontag(localclientnum, level._effect["staff_water_shatter"], self, "J_SpineLower");
    }
}

