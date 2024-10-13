#using scripts/zm/_zm_utility;
#using scripts/shared/clientfield_shared;
#using scripts/codescripts/struct;

#namespace zm_genesis_wearables;

// Namespace zm_genesis_wearables
// Params 0, eflags: 0x1 linked
// Checksum 0xf78e7320, Offset: 0x160
// Size: 0xf4
function function_ad78a144() {
    for (i = 0; i < 4; i++) {
        registerclientfield("world", "player" + i + "wearableItem", 15000, 4, "int", &zm_utility::setsharedinventoryuimodels, 0);
    }
    clientfield::register("clientuimodel", "zmInventory.wearable_perk_icons", 15000, 2, "int", undefined, 0, 0);
    clientfield::register("scriptmover", "battery_fx", 15000, 2, "int", &function_f51349bf, 0, 0);
}

// Namespace zm_genesis_wearables
// Params 7, eflags: 0x1 linked
// Checksum 0x58548947, Offset: 0x260
// Size: 0x19c
function function_f51349bf(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval == 1) {
        if (isdefined(self.n_fx_id)) {
            deletefx(localclientnum, self.n_fx_id, 1);
        }
        self.n_fx_id = playfx(localclientnum, level._effect["battery_uncharged"], self.origin, anglestoforward(self.angles), (0, 0, 1));
        return;
    }
    if (newval == 2) {
        if (isdefined(self.n_fx_id)) {
            deletefx(localclientnum, self.n_fx_id, 1);
        }
        self.n_fx_id = playfx(localclientnum, level._effect["battery_charged"], self.origin, anglestoforward(self.angles), (0, 0, 1));
        return;
    }
    if (isdefined(self.n_fx_id)) {
        deletefx(localclientnum, self.n_fx_id, 1);
    }
}

