#using scripts/zm/_zm_utility;
#using scripts/shared/util_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/array_shared;
#using scripts/codescripts/struct;

#namespace zm_tomb_dig;

// Namespace zm_tomb_dig
// Params 0, eflags: 0x1 linked
// Checksum 0x21f714dd, Offset: 0x1c0
// Size: 0x244
function init() {
    clientfield::register("world", "player0hasItem", 15000, 2, "int", &zm_utility::setsharedinventoryuimodels, 0, 0);
    clientfield::register("world", "player1hasItem", 15000, 2, "int", &zm_utility::setsharedinventoryuimodels, 0, 0);
    clientfield::register("world", "player2hasItem", 15000, 2, "int", &zm_utility::setsharedinventoryuimodels, 0, 0);
    clientfield::register("world", "player3hasItem", 15000, 2, "int", &zm_utility::setsharedinventoryuimodels, 0, 0);
    clientfield::register("world", "player0wearableItem", 15000, 1, "int", &zm_utility::setsharedinventoryuimodels, 0, 0);
    clientfield::register("world", "player1wearableItem", 15000, 1, "int", &zm_utility::setsharedinventoryuimodels, 0, 0);
    clientfield::register("world", "player2wearableItem", 15000, 1, "int", &zm_utility::setsharedinventoryuimodels, 0, 0);
    clientfield::register("world", "player3wearableItem", 15000, 1, "int", &zm_utility::setsharedinventoryuimodels, 0, 0);
}

