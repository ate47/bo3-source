#using scripts/zm/_load;
#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/callbacks_shared;
#using scripts/codescripts/struct;

#namespace namespace_fdccf5c4;

// Namespace namespace_fdccf5c4
// Params 0, eflags: 0x1 linked
// Checksum 0x876d29c5, Offset: 0x210
// Size: 0xdc
function init() {
    clientfield::register("vehicle", "spider_glow_fx", 9000, 1, "int", &function_b050960b, 0, 0);
    clientfield::register("vehicle", "spider_drinks_fx", 9000, 2, "int", &function_f9f39b8e, 0, 0);
    clientfield::register("scriptmover", "jungle_cage_charged_fx", 9000, 1, "int", &function_23e69e71, 0, 0);
}

// Namespace namespace_fdccf5c4
// Params 7, eflags: 0x1 linked
// Checksum 0xf14bb4ba, Offset: 0x2f8
// Size: 0xb4
function function_b050960b(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval == 1) {
        self.var_6cbaf065 = playfxontag(localclientnum, level._effect["spider_glow_red"], self, "tag_driver");
        return;
    }
    if (isdefined(self.var_6cbaf065)) {
        deletefx(localclientnum, self.var_6cbaf065);
    }
}

// Namespace namespace_fdccf5c4
// Params 7, eflags: 0x1 linked
// Checksum 0x7899c6d, Offset: 0x3b8
// Size: 0x17c
function function_f9f39b8e(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (!isdefined(self.var_163815ae)) {
        self.var_163815ae = [];
    }
    if (newval == 1) {
        self.var_163815ae[localclientnum] = playfxontag(localclientnum, level._effect["spider_drink_lair"], self, "tag_flash");
        return;
    }
    if (newval == 2) {
        self.var_163815ae[localclientnum] = playfxontag(localclientnum, level._effect["spider_drink_meteor"], self, "tag_flash");
        return;
    }
    if (newval == 3) {
        self.var_163815ae[localclientnum] = playfxontag(localclientnum, level._effect["spider_drink_bunker"], self, "tag_flash");
        return;
    }
    if (isdefined(self.var_163815ae[localclientnum])) {
        deletefx(localclientnum, self.var_163815ae[localclientnum]);
    }
}

// Namespace namespace_fdccf5c4
// Params 7, eflags: 0x1 linked
// Checksum 0x2bba3a50, Offset: 0x540
// Size: 0x104
function function_23e69e71(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval == 1) {
        self.var_da0d0e02[localclientnum] = playfxontag(localclientnum, level._effect["lightning_shield_control_panel"], self, "tag_origin");
        return;
    }
    if (isdefined(self.var_da0d0e02)) {
        a_keys = getarraykeys(self.var_da0d0e02);
        if (isinarray(a_keys, localclientnum)) {
            deletefx(localclientnum, self.var_da0d0e02[localclientnum], 0);
        }
    }
}

