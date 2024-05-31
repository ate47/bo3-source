#using scripts/shared/clientfield_shared;
#using scripts/shared/postfx_shared;
#using scripts/codescripts/struct;

#namespace namespace_4fd1ba2a;

// Namespace namespace_4fd1ba2a
// Params 0, eflags: 0x1 linked
// namespace_4fd1ba2a<file_0>::function_d290ebfa
// Checksum 0xd587833e, Offset: 0x258
// Size: 0x82
function main() {
    register_clientfields();
    level._effect["flinger_launch"] = "dlc1/castle/fx_elec_jumppad";
    level._effect["flinger_land"] = "dlc1/castle/fx_dust_landingpad";
    level._effect["flinger_trail"] = "dlc1/castle/fx_elec_jumppad_player_trail";
    level._effect["landing_pad_glow"] = "dlc1/castle/fx_elec_landingpad_glow";
}

// Namespace namespace_4fd1ba2a
// Params 0, eflags: 0x1 linked
// namespace_4fd1ba2a<file_0>::function_4ece4a2f
// Checksum 0xb8529c12, Offset: 0x2e8
// Size: 0x16c
function register_clientfields() {
    clientfield::register("toplayer", "flinger_flying_postfx", 1, 1, "int", &function_a1f3f959, 0, 0);
    clientfield::register("toplayer", "flinger_land_smash", 1, 1, "counter", &function_8dcf5001, 0, 0);
    clientfield::register("scriptmover", "player_visibility", 1, 1, "int", &function_a0a5829, 0, 0);
    clientfield::register("scriptmover", "flinger_launch_fx", 1, 1, "counter", &function_3762396c, 0, 0);
    clientfield::register("scriptmover", "flinger_pad_active_fx", 1, 1, "int", &function_7dd4913c, 0, 0);
}

// Namespace namespace_4fd1ba2a
// Params 7, eflags: 0x1 linked
// namespace_4fd1ba2a<file_0>::function_a1f3f959
// Checksum 0x1d14ee41, Offset: 0x460
// Size: 0x15c
function function_a1f3f959(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval == 1) {
        self.var_6f6f69f0 = playfxontag(localclientnum, level._effect["flinger_trail"], self, "tag_origin");
        self.var_bb0de733 = self playloopsound("zmb_fling_windwhoosh_2d");
        self thread postfx::playpostfxbundle("pstfx_zm_screen_warp");
        return;
    }
    if (isdefined(self.var_6f6f69f0)) {
        deletefx(localclientnum, self.var_6f6f69f0, 1);
        self.var_6f6f69f0 = undefined;
    }
    if (isdefined(self.var_bb0de733)) {
        self stoploopsound(self.var_bb0de733, 0.75);
        self.var_bb0de733 = undefined;
    }
    self thread postfx::exitpostfxbundle();
}

// Namespace namespace_4fd1ba2a
// Params 7, eflags: 0x1 linked
// namespace_4fd1ba2a<file_0>::function_7dd4913c
// Checksum 0xa4697bcc, Offset: 0x5c8
// Size: 0xbe
function function_7dd4913c(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval == 1) {
        self.var_c64ddf2c = playfxontag(localclientnum, level._effect["landing_pad_glow"], self, "tag_origin");
        return;
    }
    if (isdefined(self.var_c64ddf2c)) {
        deletefx(localclientnum, self.var_c64ddf2c, 1);
        self.var_c64ddf2c = undefined;
    }
}

// Namespace namespace_4fd1ba2a
// Params 7, eflags: 0x1 linked
// namespace_4fd1ba2a<file_0>::function_8dcf5001
// Checksum 0x820ab1a5, Offset: 0x690
// Size: 0x6c
function function_8dcf5001(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    playfxontag(localclientnum, level._effect["flinger_land"], self, "tag_origin");
}

// Namespace namespace_4fd1ba2a
// Params 7, eflags: 0x1 linked
// namespace_4fd1ba2a<file_0>::function_3762396c
// Checksum 0xab67d2d3, Offset: 0x708
// Size: 0x6c
function function_3762396c(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    playfxontag(localclientnum, level._effect["flinger_launch"], self, "tag_origin");
}

// Namespace namespace_4fd1ba2a
// Params 7, eflags: 0x1 linked
// namespace_4fd1ba2a<file_0>::function_a0a5829
// Checksum 0x1a25c659, Offset: 0x780
// Size: 0x84
function function_a0a5829(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        if (self.owner == getlocalplayer(localclientnum)) {
            self thread function_7bd5b92f(localclientnum);
        }
    }
}

// Namespace namespace_4fd1ba2a
// Params 1, eflags: 0x1 linked
// namespace_4fd1ba2a<file_0>::function_7bd5b92f
// Checksum 0xb55a6aa8, Offset: 0x810
// Size: 0x9c
function function_7bd5b92f(localclientnum) {
    player = getlocalplayer(localclientnum);
    if (isdefined(player)) {
        if (isthirdperson(localclientnum)) {
            self show();
            player hide();
            return;
        }
        self hide();
    }
}

