#using scripts/codescripts/struct;
#using scripts/shared/clientfield_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;

#namespace tiger_tank;

// Namespace tiger_tank
// Params 0, eflags: 0x2
// Checksum 0x52a98355, Offset: 0x178
// Size: 0x2a
function autoexec __init__sytem__() {
    system::register("tiger_tank", &__init__, undefined, undefined);
}

// Namespace tiger_tank
// Params 0, eflags: 0x0
// Checksum 0xed93e386, Offset: 0x1b0
// Size: 0x72
function __init__() {
    clientfield::register("vehicle", "tiger_tank_retreat_fx", 1, 1, "int", &function_6c906721, 0, 0);
    clientfield::register("vehicle", "tiger_tank_disable_sfx", 1, 1, "int", &function_c2c3fb69, 0, 0);
}

// Namespace tiger_tank
// Params 7, eflags: 0x0
// Checksum 0xb9881901, Offset: 0x230
// Size: 0x92
function function_6c906721(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        self function_ea0e7704(localclientnum, "retreat_fx", "explosions/fx_exp_grenade_smoke", 1, self.origin);
        return;
    }
    self function_be968491(localclientnum, "retreat_fx", "explosions/fx_exp_grenade_smoke");
}

// Namespace tiger_tank
// Params 3, eflags: 0x0
// Checksum 0x2ca49ce4, Offset: 0x2d0
// Size: 0xc0
function function_be968491(localclientnum, str_type, str_fx) {
    if (!isdefined(self.var_62bb476b)) {
        self.var_62bb476b = [];
    }
    if (!isdefined(self.var_62bb476b[localclientnum])) {
        self.var_62bb476b[localclientnum] = [];
    }
    if (!isdefined(self.var_62bb476b[localclientnum][str_type])) {
        self.var_62bb476b[localclientnum][str_type] = [];
    }
    if (isdefined(str_fx) && isdefined(self.var_62bb476b[localclientnum][str_type][str_fx])) {
        n_fx_id = self.var_62bb476b[localclientnum][str_type][str_fx];
        deletefx(localclientnum, n_fx_id, 0);
        self.var_62bb476b[localclientnum][str_type][str_fx] = undefined;
    }
}

// Namespace tiger_tank
// Params 7, eflags: 0x0
// Checksum 0x5982530b, Offset: 0x398
// Size: 0xed
function function_ea0e7704(localclientnum, str_type, str_fx, var_cffd17f8, v_pos, v_forward, v_up) {
    if (!isdefined(var_cffd17f8)) {
        var_cffd17f8 = 1;
    }
    self function_be968491(localclientnum, str_type, str_fx);
    if (var_cffd17f8) {
        self function_400e6e82(localclientnum, str_type, 0);
    }
    if (isdefined(v_forward) && isdefined(v_up)) {
        n_fx_id = playfx(localclientnum, str_fx, v_pos, v_forward, v_up);
    } else if (isdefined(v_forward)) {
        n_fx_id = playfx(localclientnum, str_fx, v_pos, v_forward);
    } else {
        n_fx_id = playfx(localclientnum, str_fx, v_pos);
    }
    self.var_62bb476b[localclientnum][str_type][str_fx] = n_fx_id;
}

// Namespace tiger_tank
// Params 3, eflags: 0x0
// Checksum 0x73be47f4, Offset: 0x490
// Size: 0xcb
function function_400e6e82(localclientnum, str_type, var_91599cfb) {
    if (!isdefined(var_91599cfb)) {
        var_91599cfb = 1;
    }
    if (isdefined(self.var_62bb476b) && isdefined(self.var_62bb476b[localclientnum]) && isdefined(self.var_62bb476b[localclientnum][str_type])) {
        a_keys = getarraykeys(self.var_62bb476b[localclientnum][str_type]);
        for (i = 0; i < a_keys.size; i++) {
            deletefx(localclientnum, self.var_62bb476b[localclientnum][str_type][a_keys[i]], var_91599cfb);
            self.var_62bb476b[localclientnum][str_type][a_keys[i]] = undefined;
        }
    }
}

// Namespace tiger_tank
// Params 7, eflags: 0x0
// Checksum 0xecb60a74, Offset: 0x568
// Size: 0x62
function function_c2c3fb69(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval == 1) {
        self disablevehiclesounds();
        return;
    }
    self enablevehiclesounds();
}

