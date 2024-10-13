#using scripts/zm/_zm_utility;
#using scripts/shared/clientfield_shared;
#using scripts/codescripts/struct;

#namespace zm_stalingrad_wearables;

// Namespace zm_stalingrad_wearables
// Params 0, eflags: 0x1 linked
// Checksum 0x9d8137b3, Offset: 0x110
// Size: 0xbe
function function_ad78a144() {
    clientfield::register("scriptmover", "show_wearable", 12000, 1, "int", &show_wearable, 0, 0);
    for (i = 0; i < 4; i++) {
        registerclientfield("world", "player" + i + "wearableItem", 12000, 2, "int", &zm_utility::setsharedinventoryuimodels, 0);
    }
}

// Namespace zm_stalingrad_wearables
// Params 3, eflags: 0x1 linked
// Checksum 0x7bafacf6, Offset: 0x1d8
// Size: 0x54
function show_wearable(localclientnum, oldval, newval) {
    if (newval) {
        self show();
        return;
    }
    self hide();
}

