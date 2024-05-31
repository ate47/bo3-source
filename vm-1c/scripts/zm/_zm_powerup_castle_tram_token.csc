#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_powerups;
#using scripts/shared/system_shared;
#using scripts/shared/clientfield_shared;
#using scripts/codescripts/struct;

#namespace namespace_cb5bc243;

// Namespace namespace_cb5bc243
// Params 0, eflags: 0x2
// Checksum 0x9f18ed32, Offset: 0x250
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("zm_powerup_castle_tram_token", &__init__, undefined, undefined);
}

// Namespace namespace_cb5bc243
// Params 0, eflags: 0x1 linked
// Checksum 0xc95fe51b, Offset: 0x290
// Size: 0x5e
function __init__() {
    register_clientfields();
    zm_powerups::include_zombie_powerup("castle_tram_token");
    zm_powerups::add_zombie_powerup("castle_tram_token");
    level._effect["fuse_pickup_fx"] = "dlc1/castle/fx_glow_115_fuse_pickup_castle";
}

// Namespace namespace_cb5bc243
// Params 0, eflags: 0x1 linked
// Checksum 0x5b5c23b2, Offset: 0x2f8
// Size: 0x1ac
function register_clientfields() {
    clientfield::register("toplayer", "has_castle_tram_token", 1, 1, "int", undefined, 0, 0);
    clientfield::register("toplayer", "ZM_CASTLE_TRAM_TOKEN_ACQUIRED", 1, 1, "int", &zm_utility::zm_ui_infotext, 0, 1);
    clientfield::register("scriptmover", "powerup_fuse_fx", 1, 1, "int", &function_4f546258, 0, 0);
    for (i = 0; i < 4; i++) {
        registerclientfield("world", "player" + i + "hasItem", 1, 1, "int", &zm_utility::setsharedinventoryuimodels, 0);
    }
    clientfield::register("clientuimodel", "zmInventory.player_using_sprayer", 1, 1, "int", undefined, 0, 0);
    clientfield::register("clientuimodel", "zmInventory.widget_sprayer", 1, 1, "int", undefined, 0, 0);
}

// Namespace namespace_cb5bc243
// Params 7, eflags: 0x1 linked
// Checksum 0xa5bea765, Offset: 0x4b0
// Size: 0x84
function function_4f546258(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval == 1) {
        self.var_300f73ce = playfxontag(localclientnum, level._effect["fuse_pickup_fx"], self, "j_fuse_main");
    }
}

