#using scripts/shared/vehicle_shared;
#using scripts/shared/system_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/animation_shared;
#using scripts/codescripts/struct;

#using_animtree("generic");

#namespace zm_siegebot_nikolai;

// Namespace zm_siegebot_nikolai
// Params 0, eflags: 0x2
// Checksum 0xb79fb928, Offset: 0x498
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("zm_siegebot_nikolai", &__init__, undefined, undefined);
}

// Namespace zm_siegebot_nikolai
// Params 0, eflags: 0x1 linked
// Checksum 0x4a7a239d, Offset: 0x4d8
// Size: 0x2fc
function __init__() {
    vehicle::add_vehicletype_callback("siegebot_nikolai", &on_spawned);
    clientfield::register("vehicle", "nikolai_destroyed_r_arm", 12000, 1, "int", &nikolai_destroyed_r_arm, 0, 0);
    clientfield::register("vehicle", "nikolai_destroyed_l_arm", 12000, 1, "int", &nikolai_destroyed_l_arm, 0, 0);
    clientfield::register("vehicle", "nikolai_destroyed_r_chest", 12000, 1, "int", &nikolai_destroyed_r_chest, 0, 0);
    clientfield::register("vehicle", "nikolai_destroyed_l_chest", 12000, 1, "int", &nikolai_destroyed_l_chest, 0, 0);
    clientfield::register("vehicle", "nikolai_weakpoint_l_fx", 12000, 1, "int", &nikolai_weakpoint_l_fx, 0, 0);
    clientfield::register("vehicle", "nikolai_weakpoint_r_fx", 12000, 1, "int", &nikolai_weakpoint_r_fx, 0, 0);
    clientfield::register("vehicle", "nikolai_gatling_tell", 12000, 1, "int", &nikolai_gatling_tell, 0, 0);
    clientfield::register("missile", "harpoon_impact", 12000, 1, "int", &harpoon_impact, 0, 0);
    clientfield::register("vehicle", "play_raps_trail_fx", 12000, 1, "int", &function_66f3947f, 0, 0);
    clientfield::register("vehicle", "raps_landing", 12000, 1, "int", &raps_landing, 0, 0);
}

// Namespace zm_siegebot_nikolai
// Params 1, eflags: 0x1 linked
// Checksum 0xd8240d81, Offset: 0x7e0
// Size: 0x5c
function on_spawned(localclientnum) {
    self useanimtree(#generic);
    self thread function_89d7e567(localclientnum);
    self thread function_48c3fc7d(localclientnum);
}

// Namespace zm_siegebot_nikolai
// Params 1, eflags: 0x1 linked
// Checksum 0xebaf355, Offset: 0x848
// Size: 0x278
function function_48c3fc7d(localclientnum) {
    self endon(#"entityshutdown");
    self notify(#"hash_48c3fc7d");
    self endon(#"hash_48c3fc7d");
    nikolai = undefined;
    while (true) {
        level waittill(#"hash_eeba0c72");
        if (!isdefined(nikolai)) {
            allents = getentarray(localclientnum);
            foreach (ent in allents) {
                if (ent.model === "c_zom_dlc_waw_nikolai_fb" && self isentitylinkedtotag(ent)) {
                    nikolai = ent;
                }
            }
        }
        var_1714a389 = undefined;
        if (isdefined(nikolai)) {
            origin = nikolai gettagorigin("j_ringbase_le");
            angles = nikolai gettagangles("j_ringbase_le");
            up = anglestoup(angles);
            angles += (0, 0, 180);
            var_1714a389 = spawn(localclientnum, origin, "script_model");
            var_1714a389 setmodel("p7_zm_sta_bottle_vodka_01");
            var_1714a389.angles = angles;
            nikolai thread function_97181777(var_1714a389);
        }
        level waittill(#"hash_13cefe1f");
        if (isdefined(var_1714a389)) {
            var_1714a389 delete();
        }
    }
}

// Namespace zm_siegebot_nikolai
// Params 1, eflags: 0x1 linked
// Checksum 0x4ecd6910, Offset: 0xac8
// Size: 0x154
function function_97181777(var_1714a389) {
    while (isdefined(self) && isdefined(var_1714a389)) {
        origin = self gettagorigin("j_ringbase_le");
        angles = self gettagangles("j_ringbase_le");
        forward = anglestoforward(angles);
        right = anglestoright(angles);
        up = anglestoup(angles);
        angles += (0, 0, 180);
        offset = forward * 1.6 + right * -1.2 + up * 11;
        var_1714a389.origin = origin + offset;
        var_1714a389.angles = angles;
        wait 0.016;
    }
}

// Namespace zm_siegebot_nikolai
// Params 1, eflags: 0x1 linked
// Checksum 0xce04de2e, Offset: 0xc28
// Size: 0x60
function function_89d7e567(localclientnum) {
    self endon(#"disconnect");
    self endon(#"entityshutdown");
    while (true) {
        self waittill(#"gunner_weapon_fired");
        self setanim("ai_zm_dlc3_russian_mech_shoot_gunbarrel", 1, 0, 1);
    }
}

// Namespace zm_siegebot_nikolai
// Params 7, eflags: 0x1 linked
// Checksum 0xfe384a06, Offset: 0xc90
// Size: 0x186
function nikolai_gatling_tell(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        self.var_16903828 = playfxontag(localclientnum, level._effect["nikolai_gatling_tell"], self, "tag_gunner_aim1");
        self playsound(localclientnum, "zmb_nikolaibot_rapidfire_start", self gettagorigin("tag_eye"));
        self.var_464db63 = self playloopsound("zmb_nikolaibot_rapidfire_barrel_lp");
        return;
    }
    if (isdefined(self.var_16903828)) {
        stopfx(localclientnum, self.var_16903828);
    }
    self playsound(localclientnum, "zmb_nikolaibot_rapidfire_end", self gettagorigin("tag_eye"));
    if (isdefined(self.var_464db63)) {
        self stoploopsound(self.var_464db63);
        self.var_464db63 = undefined;
    }
}

// Namespace zm_siegebot_nikolai
// Params 7, eflags: 0x1 linked
// Checksum 0x9ecc9c86, Offset: 0xe20
// Size: 0xb4
function nikolai_destroyed_r_arm(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        playfxontag(localclientnum, level._effect["nikolai_weakpoint_destroyed"], self, "tag_heat_vent_01_d1");
        self playsound(localclientnum, "zmb_nikolaibot_damage", self gettagorigin("tag_heat_vent_01_d1"));
    }
}

// Namespace zm_siegebot_nikolai
// Params 7, eflags: 0x1 linked
// Checksum 0x6aab2f5d, Offset: 0xee0
// Size: 0xb4
function nikolai_destroyed_l_arm(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        playfxontag(localclientnum, level._effect["nikolai_weakpoint_destroyed"], self, "tag_heat_vent_02_d1");
        self playsound(localclientnum, "zmb_nikolaibot_damage", self gettagorigin("tag_heat_vent_02_d1"));
    }
}

// Namespace zm_siegebot_nikolai
// Params 7, eflags: 0x1 linked
// Checksum 0xb5eba05e, Offset: 0xfa0
// Size: 0xb4
function nikolai_destroyed_r_chest(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        playfxontag(localclientnum, level._effect["nikolai_weakpoint_destroyed"], self, "tag_heat_vent_03_d1");
        self playsound(localclientnum, "zmb_nikolaibot_damage", self gettagorigin("tag_heat_vent_03_d1"));
    }
}

// Namespace zm_siegebot_nikolai
// Params 7, eflags: 0x1 linked
// Checksum 0x6892a3eb, Offset: 0x1060
// Size: 0xb4
function nikolai_destroyed_l_chest(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        playfxontag(localclientnum, level._effect["nikolai_weakpoint_destroyed"], self, "tag_heat_vent_04_d1");
        self playsound(localclientnum, "zmb_nikolaibot_damage", self gettagorigin("tag_heat_vent_04_d1"));
    }
}

// Namespace zm_siegebot_nikolai
// Params 7, eflags: 0x1 linked
// Checksum 0x6952148, Offset: 0x1120
// Size: 0xb6
function nikolai_weakpoint_r_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        self.var_da48848b = playfxontag(localclientnum, level._effect["nikolai_weakpoint_fx"], self, "tag_heat_vent_01_d0");
        return;
    }
    if (isdefined(self.var_da48848b)) {
        stopfx(localclientnum, self.var_da48848b);
        self.var_da48848b = undefined;
    }
}

// Namespace zm_siegebot_nikolai
// Params 7, eflags: 0x1 linked
// Checksum 0x766c39b5, Offset: 0x11e0
// Size: 0xb6
function nikolai_weakpoint_l_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        self.var_f639a615 = playfxontag(localclientnum, level._effect["nikolai_weakpoint_fx"], self, "tag_heat_vent_02_d0");
        return;
    }
    if (isdefined(self.var_f639a615)) {
        stopfx(localclientnum, self.var_f639a615);
        self.var_f639a615 = undefined;
    }
}

// Namespace zm_siegebot_nikolai
// Params 7, eflags: 0x1 linked
// Checksum 0x9b3e04a2, Offset: 0x12a0
// Size: 0xfc
function harpoon_impact(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        playfx(localclientnum, level._effect["nikolai_harpoon_impact"], self.origin, anglestoforward(self.angles) * -1);
        playsound(0, "zmb_nikolaibot_harpoon_impact", self.origin + (0, 0, 10));
        playrumbleonposition(localclientnum, "harpoon_land", self.origin + (0, 0, 10));
    }
}

// Namespace zm_siegebot_nikolai
// Params 7, eflags: 0x1 linked
// Checksum 0xdba8ff97, Offset: 0x13a8
// Size: 0xe4
function function_66f3947f(var_6575414d, var_d5fa7963, var_3a04fa7e, var_3a8c4f80, var_406ad39b, str_field, var_f9aa8824) {
    self endon(#"disconnect");
    self endon(#"entityshutdown");
    if (var_3a04fa7e) {
        self.fx_trail = playfxontag(var_6575414d, level._effect["nikolai_raps_trail"], self, "tag_body");
        self playsound(0, "wpn_nikolaibot_raps_launch");
        return;
    }
    if (isdefined(self.fx_trail)) {
        stopfx(var_6575414d, self.fx_trail);
    }
}

// Namespace zm_siegebot_nikolai
// Params 7, eflags: 0x1 linked
// Checksum 0x5043a525, Offset: 0x1498
// Size: 0x94
function raps_landing(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        playfxontag(localclientnum, level._effect["nikolai_raps_landing"], self, "tag_origin");
        self playsound(0, "zmb_nikolaibot_raps_impact");
    }
}

