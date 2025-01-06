#using scripts/codescripts/struct;
#using scripts/shared/clientfield_shared;
#using scripts/zm/_zm_utility;
#using scripts/zm/craftables/_zm_craftables;

#namespace zm_castle_craftables;

// Namespace zm_castle_craftables
// Params 0, eflags: 0x0
// Checksum 0x16f96cc6, Offset: 0x298
// Size: 0x7a
function function_95743e9f() {
    register_clientfields();
    zm_craftables::function_8421d708("gravityspike");
    level thread zm_craftables::function_5654f132();
    level._effect["craftable_powerup_on"] = "dlc1/castle/fx_talon_spike_glow_castle";
    level._effect["craftable_powerup_teleport"] = "dlc1/castle/fx_castle_pap_teleport_parts";
}

// Namespace zm_castle_craftables
// Params 0, eflags: 0x0
// Checksum 0x9d739fd5, Offset: 0x320
// Size: 0x1c
function function_3ebec56b() {
    zm_craftables::function_ac4e44a7("gravityspike");
}

// Namespace zm_castle_craftables
// Params 0, eflags: 0x0
// Checksum 0xf67e8b33, Offset: 0x348
// Size: 0x2ac
function register_clientfields() {
    var_a0199abd = 1;
    registerclientfield("world", "gravityspike" + "_" + "part_body", 1, var_a0199abd, "int", &zm_utility::setsharedinventoryuimodels, 0, 1);
    registerclientfield("world", "gravityspike" + "_" + "part_guards", 1, var_a0199abd, "int", &zm_utility::setsharedinventoryuimodels, 0, 1);
    registerclientfield("world", "gravityspike" + "_" + "part_handle", 1, var_a0199abd, "int", &zm_utility::setsharedinventoryuimodels, 0, 1);
    clientfield::register("scriptmover", "craftable_powerup_fx", 1, 1, "int", &function_f1838e49, 0, 0);
    clientfield::register("scriptmover", "craftable_teleport_fx", 1, 1, "int", &function_a43a3438, 0, 0);
    clientfield::register("toplayer", "ZMUI_GRAVITYSPIKE_PART_PICKUP", 1, 1, "int", &zm_utility::zm_ui_infotext, 0, 1);
    clientfield::register("toplayer", "ZMUI_GRAVITYSPIKE_CRAFTED", 1, 1, "int", &zm_utility::zm_ui_infotext, 0, 1);
    clientfield::register("clientuimodel", "zmInventory.widget_gravityspike_parts", 1, 1, "int", undefined, 0, 0);
    clientfield::register("clientuimodel", "zmInventory.player_crafted_gravityspikes", 1, 1, "int", undefined, 0, 0);
}

// Namespace zm_castle_craftables
// Params 7, eflags: 0x0
// Checksum 0x99fdfdad, Offset: 0x600
// Size: 0xbe
function function_f1838e49(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval == 1) {
        self.powerup_fx = playfxontag(localclientnum, level._effect["craftable_powerup_on"], self, "tag_origin");
        return;
    }
    if (isdefined(self.powerup_fx)) {
        deletefx(localclientnum, self.powerup_fx, 1);
        self.powerup_fx = undefined;
    }
}

// Namespace zm_castle_craftables
// Params 7, eflags: 0x0
// Checksum 0x5e317d00, Offset: 0x6c8
// Size: 0x7c
function function_a43a3438(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval == 1) {
        playfxontag(localclientnum, level._effect["craftable_powerup_teleport"], self, "tag_origin");
    }
}

