#using scripts/codescripts/struct;
#using scripts/shared/ai_shared;
#using scripts/shared/array_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/zm/_load;
#using scripts/zm/_zm;
#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_weapons;

#namespace zm_genesis_keeper_companion;

// Namespace zm_genesis_keeper_companion
// Params 0, eflags: 0x2
// Checksum 0x30b80a00, Offset: 0x2a0
// Size: 0x34
function autoexec __init__sytem__() {
    system::register("zm_genesis_keeper_companion", &__init__, undefined, undefined);
}

// Namespace zm_genesis_keeper_companion
// Params 0, eflags: 0x0
// Checksum 0x99dd98e1, Offset: 0x2e0
// Size: 0x14c
function __init__() {
    registerclientfield("world", "keeper_callbox_head", 15000, 1, "int", &zm_utility::setsharedinventoryuimodels, 0, 1);
    registerclientfield("world", "keeper_callbox_totem", 15000, 1, "int", &zm_utility::setsharedinventoryuimodels, 0, 1);
    registerclientfield("world", "keeper_callbox_gem", 15000, 1, "int", &zm_utility::setsharedinventoryuimodels, 0, 1);
    clientfield::register("clientuimodel", "zmInventory.widget_keeper_protector_parts", 15000, 1, "int", undefined, 0, 0);
    clientfield::register("clientuimodel", "zmInventory.player_keeper_protector", 15000, 1, "int", undefined, 0, 0);
}

