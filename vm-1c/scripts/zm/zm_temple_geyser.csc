#using scripts/shared/clientfield_shared;
#using scripts/shared/util_shared;

#using_animtree("generic");

#namespace zm_temple_geyser;

// Namespace zm_temple_geyser
// Params 0, eflags: 0x0
// Checksum 0xdbf776bc, Offset: 0x190
// Size: 0x94
function main() {
    clientfield::register("allplayers", "geyserfakestand", 21000, 1, "int", &function_adecf167, 0, 0);
    clientfield::register("allplayers", "geyserfakeprone", 21000, 1, "int", &function_56742dc1, 0, 0);
}

// Namespace zm_temple_geyser
// Params 7, eflags: 0x0
// Checksum 0xaab74aa8, Offset: 0x230
// Size: 0x420
function function_56742dc1(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
    if (isspectating(localclientnum, 0)) {
        return;
    }
    player = getlocalplayers()[localclientnum];
    if (player getentitynumber() == self getentitynumber()) {
        if (newval) {
            self playrumbleonentity(localclientnum, "slide_rumble");
            return;
        }
        self stoprumble(localclientnum, "slide_rumble");
        return;
    }
    if (newval) {
        if (localclientnum == 0) {
            self thread function_b3beb77e();
        }
        fake_player = spawn(localclientnum, self.origin + (0, 0, -800), "script_model");
        fake_player.angles = self.angles;
        fake_player setmodel(self.model);
        if (self.model == "c_ger_richtofen_body") {
            fake_player attach("c_ger_richtofen_head", "J_Spine4");
            fake_player attach("c_ger_richtofen_offcap", "J_Head");
        }
        fake_player.fake_weapon = spawn(localclientnum, self.origin, "script_model");
        if (self.weapon != "none" && self.weapon != "syrette") {
            fake_player.fake_weapon useweaponhidetags(self.weapon);
        } else {
            self thread function_1b712564(fake_player.fake_weapon);
        }
        fake_player.fake_weapon linkto(fake_player, "tag_weapon_right");
        wait 0.016;
        fake_player linkto(self, "tag_origin");
        if (!isdefined(self.fake_player)) {
            self.fake_player = [];
        }
        self.fake_player[localclientnum] = fake_player;
        self thread function_99ef04a1(localclientnum);
        return;
    }
    if (!isdefined(self.fake_player) && !isdefined(self.fake_player[localclientnum])) {
        return;
    }
    str_notify = "player_geyser" + localclientnum;
    self notify(str_notify);
    self notify(#"hash_8663e02a");
    if (isdefined(self.fake_player[localclientnum].fake_weapon)) {
        self.fake_player[localclientnum].fake_weapon delete();
        self.fake_player[localclientnum].fake_weapon = undefined;
    }
    self.fake_player[localclientnum] delete();
    self.fake_player[localclientnum] = undefined;
}

// Namespace zm_temple_geyser
// Params 7, eflags: 0x0
// Checksum 0xb8739eae, Offset: 0x658
// Size: 0x448
function function_adecf167(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
    if (isspectating(localclientnum, 0)) {
        return;
    }
    player = getlocalplayers()[localclientnum];
    if (player getentitynumber() == self getentitynumber()) {
        if (newval) {
            self playrumbleonentity(localclientnum, "slide_rumble");
            return;
        }
        self stoprumble(localclientnum, "slide_rumble");
        return;
    }
    if (newval) {
        if (localclientnum == 0) {
            self thread function_b3beb77e();
        }
        fake_player = spawn(localclientnum, self.origin + (0, 0, -800), "script_model");
        fake_player.angles = self.angles;
        fake_player setmodel(self.model);
        if (self.model == "c_ger_richtofen_body") {
            fake_player attach("c_ger_richtofen_head", "J_Spine4");
            fake_player attach("c_ger_richtofen_offcap", "J_Head");
        }
        fake_player.fake_weapon = spawn(localclientnum, self.origin, "script_model");
        if (self.weapon.name != "none" && self.weapon.name != "syrette") {
            fake_player.fake_weapon useweaponhidetags(self.weapon);
        } else {
            self thread function_1b712564(fake_player.fake_weapon);
        }
        fake_player.fake_weapon linkto(fake_player, "tag_weapon_right");
        wait 0.016;
        fake_player.origin = self.origin;
        fake_player linkto(self, "tag_origin");
        if (!isdefined(self.fake_player)) {
            self.fake_player = [];
        }
        self.fake_player[localclientnum] = fake_player;
        self thread function_99ef04a1(localclientnum);
        return;
    }
    if (!isdefined(self.fake_player) || !isdefined(self.fake_player[localclientnum])) {
        return;
    }
    str_notify = "player_geyser" + localclientnum;
    self notify(str_notify);
    self notify(#"hash_8663e02a");
    if (isdefined(self.fake_player[localclientnum].fake_weapon)) {
        self.fake_player[localclientnum].fake_weapon delete();
        self.fake_player[localclientnum].fake_weapon = undefined;
    }
    self.fake_player[localclientnum] delete();
    self.fake_player[localclientnum] = undefined;
}

// Namespace zm_temple_geyser
// Params 1, eflags: 0x0
// Checksum 0x8eaf6a1f, Offset: 0xaa8
// Size: 0x74
function function_1b712564(fake_weapon) {
    self endon(#"hash_8663e02a");
    self endon(#"disconnect");
    while (self.weapon == "none") {
        wait 0.05;
    }
    if (self.weapon != "syrette") {
        fake_weapon useweaponhidetags(self.weapon);
    }
}

// Namespace zm_temple_geyser
// Params 0, eflags: 0x0
// Checksum 0x612aeae1, Offset: 0xb28
// Size: 0x66
function function_b3beb77e() {
    self notify(#"hash_43b8e7bb");
    self endon(#"hash_43b8e7bb");
    ent_num = self getentitynumber();
    while (isdefined(self)) {
        wait 0.05;
    }
    level notify(#"player_disconnected", ent_num);
}

// Namespace zm_temple_geyser
// Params 2, eflags: 0x0
// Checksum 0xa15c22c1, Offset: 0xb98
// Size: 0x74
function function_1f5c29a9(str_endon, player) {
    player endon(str_endon);
    level waittill(#"player_disconnected", client);
    if (isdefined(self.fake_weapon)) {
        self.fake_weapon delete();
    }
    self delete();
}

// Namespace zm_temple_geyser
// Params 1, eflags: 0x0
// Checksum 0xa452bf0b, Offset: 0xc18
// Size: 0x4c
function function_99ef04a1(localclientnum) {
    str_endon = "player_geyser" + localclientnum;
    self.fake_player[localclientnum] thread function_1f5c29a9(str_endon, self);
}

