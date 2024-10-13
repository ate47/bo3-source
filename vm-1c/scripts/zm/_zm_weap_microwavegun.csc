#using scripts/zm/_zm_weapons;
#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/clientfield_shared;
#using scripts/codescripts/struct;

#namespace zm_weap_microwavegun;

// Namespace zm_weap_microwavegun
// Params 0, eflags: 0x2
// Checksum 0xe4dc6790, Offset: 0x2e8
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("zm_weap_microwavegun", &__init__, undefined, undefined);
}

// Namespace zm_weap_microwavegun
// Params 0, eflags: 0x1 linked
// Checksum 0xb583057f, Offset: 0x328
// Size: 0x16c
function __init__() {
    clientfield::register("actor", "toggle_microwavegun_hit_response", 21000, 1, "int", &function_40068206, 0, 0);
    clientfield::register("actor", "toggle_microwavegun_expand_response", 21000, 1, "int", &function_c1551b70, 0, 0);
    clientfield::register("clientuimodel", "hudItems.showDpadLeft_WaveGun", 21000, 1, "int", undefined, 0, 0);
    clientfield::register("clientuimodel", "hudItems.dpadLeftAmmo", 21000, 5, "int", undefined, 0, 0);
    level._effect["microwavegun_sizzle_blood_eyes"] = "dlc5/zmb_weapon/fx_sizzle_blood_eyes";
    level._effect["microwavegun_sizzle_death_mist"] = "dlc5/zmb_weapon/fx_sizzle_mist";
    level._effect["microwavegun_sizzle_death_mist_low_g"] = "dlc5/zmb_weapon/fx_sizzle_mist_low_g";
    level thread player_init();
}

// Namespace zm_weap_microwavegun
// Params 0, eflags: 0x1 linked
// Checksum 0x852ba97, Offset: 0x4a0
// Size: 0x7a
function player_init() {
    util::waitforclient(0);
    players = getlocalplayers();
    for (i = 0; i < players.size; i++) {
        player = players[i];
    }
}

// Namespace zm_weap_microwavegun
// Params 3, eflags: 0x1 linked
// Checksum 0xdcaf4ba2, Offset: 0x528
// Size: 0x68
function function_d2c42bf0(localclientnum, tag, effect) {
    if (!isdefined(self.var_7dc68ffa[localclientnum][tag])) {
        self.var_7dc68ffa[localclientnum][tag] = playfxontag(localclientnum, effect, self, tag);
    }
}

// Namespace zm_weap_microwavegun
// Params 2, eflags: 0x1 linked
// Checksum 0x30d3c6f4, Offset: 0x598
// Size: 0x66
function function_3a02ff65(localclientnum, tag) {
    if (isdefined(self.var_7dc68ffa[localclientnum][tag])) {
        deletefx(localclientnum, self.var_7dc68ffa[localclientnum][tag], 0);
        self.var_7dc68ffa[localclientnum][tag] = undefined;
    }
}

// Namespace zm_weap_microwavegun
// Params 1, eflags: 0x1 linked
// Checksum 0xbf90a093, Offset: 0x608
// Size: 0x17c
function function_a5b034e9(localclientnum) {
    self endon(#"entityshutdown");
    var_a7c0e889 = 2500;
    tag_pos = self gettagorigin("J_SpineLower");
    var_f3b96237 = 1;
    if (!isdefined(tag_pos)) {
        var_a7c0e889 = 1000;
    }
    self mapshaderconstant(localclientnum, 0, "scriptVector6", 0, 0, 0, 0);
    var_15f206d4 = getrealtime();
    while (true) {
        var_54f6e482 = getrealtime() - var_15f206d4;
        var_66eab20e = var_54f6e482 / var_a7c0e889;
        if (var_66eab20e > var_f3b96237) {
            var_66eab20e = var_f3b96237;
        }
        if (!isdefined(self)) {
            return;
        }
        self mapshaderconstant(localclientnum, 0, "scriptVector6", 4 * var_66eab20e, 0, 0, 0);
        if (var_66eab20e >= var_f3b96237) {
            break;
        }
        wait 0.05;
    }
}

// Namespace zm_weap_microwavegun
// Params 7, eflags: 0x1 linked
// Checksum 0x1efa0c2, Offset: 0x790
// Size: 0x166
function function_40068206(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
    if (isdefined(self.var_ce6b9071)) {
        self [[ self.var_ce6b9071 ]](localclientnum, newval, bnewent);
        return;
    }
    if (localclientnum != 0) {
        return;
    }
    if (!isdefined(self.var_7dc68ffa)) {
        self.var_7dc68ffa = [];
    }
    self.var_73a5b7b1 = 1;
    players = getlocalplayers();
    for (i = 0; i < players.size; i++) {
        if (!isdefined(self.var_7dc68ffa[i])) {
            self.var_7dc68ffa[i] = [];
        }
        if (newval) {
            self function_d2c42bf0(i, "J_Eyeball_LE", level._effect["microwavegun_sizzle_blood_eyes"]);
            playsound(0, "wpn_mgun_impact_zombie", self.origin);
        }
    }
}

// Namespace zm_weap_microwavegun
// Params 7, eflags: 0x1 linked
// Checksum 0xfc4397fe, Offset: 0x900
// Size: 0x30e
function function_c1551b70(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
    if (isdefined(self.var_ce6b9071)) {
        self [[ self.var_ce6b9071 ]](localclientnum, newval, bnewent);
        return;
    }
    if (localclientnum != 0) {
        return;
    }
    if (!isdefined(self.var_7dc68ffa)) {
        self.var_7dc68ffa = [];
    }
    var_f0c44a25 = isdefined(self.var_73a5b7b1) && self.var_73a5b7b1;
    players = getlocalplayers();
    for (i = 0; i < players.size; i++) {
        if (!isdefined(self.var_7dc68ffa[i])) {
            self.var_7dc68ffa[i] = [];
        }
        if (newval && var_f0c44a25) {
            playsound(0, "wpn_mgun_impact_zombie", self.origin);
            self thread function_a5b034e9(i);
            continue;
        }
        self thread function_a5b034e9(i);
        if (var_f0c44a25) {
            self function_3a02ff65(i, "J_Eyeball_LE");
        }
        tag_pos = self gettagorigin("J_SpineLower");
        tag_angles = self gettagangles("J_SpineLower");
        if (!isdefined(tag_pos)) {
            tag_pos = self gettagorigin("J_Spine1");
            tag_angles = self gettagangles("J_Spine1");
        }
        fx = level._effect["microwavegun_sizzle_death_mist"];
        if (isdefined(self.var_36de0da9) && self.var_36de0da9) {
            fx = level._effect["microwavegun_sizzle_death_mist_low_g"];
        }
        if (isdefined(tag_pos)) {
            playfx(i, fx, tag_pos, anglestoforward(tag_angles), anglestoup(tag_angles));
        }
        playsound(0, "wpn_mgun_explode_zombie", self.origin);
    }
}

