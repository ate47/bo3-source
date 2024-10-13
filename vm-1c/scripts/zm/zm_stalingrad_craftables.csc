#using scripts/zm/craftables/_zm_craftables;
#using scripts/zm/_zm_utility;
#using scripts/shared/clientfield_shared;
#using scripts/codescripts/struct;

#namespace zm_stalingrad_craftables;

// Namespace zm_stalingrad_craftables
// Params 0, eflags: 0x1 linked
// Checksum 0x425546e5, Offset: 0x1b0
// Size: 0x44
function function_95743e9f() {
    register_clientfields();
    zm_craftables::function_8421d708("dragonride");
    level thread zm_craftables::function_5654f132();
}

// Namespace zm_stalingrad_craftables
// Params 0, eflags: 0x1 linked
// Checksum 0x701cdc63, Offset: 0x200
// Size: 0x1c
function function_3ebec56b() {
    zm_craftables::function_ac4e44a7("dragonride");
}

// Namespace zm_stalingrad_craftables
// Params 0, eflags: 0x1 linked
// Checksum 0xdd67189d, Offset: 0x228
// Size: 0x1d4
function register_clientfields() {
    var_a0199abd = 1;
    registerclientfield("world", "dragonride" + "_" + "part_transmitter", 12000, var_a0199abd, "int", &zm_utility::setsharedinventoryuimodels, 0);
    registerclientfield("world", "dragonride" + "_" + "part_codes", 12000, var_a0199abd, "int", &zm_utility::setsharedinventoryuimodels, 0);
    registerclientfield("world", "dragonride" + "_" + "part_map", 12000, var_a0199abd, "int", &zm_utility::setsharedinventoryuimodels, 0);
    clientfield::register("toplayer", "ZMUI_DRAGONRIDE_PART_PICKUP", 12000, 1, "int", &zm_utility::zm_ui_infotext, 0, 1);
    clientfield::register("toplayer", "ZMUI_DRAGONRIDE_CRAFTED", 12000, 1, "int", &zm_utility::zm_ui_infotext, 0, 1);
    clientfield::register("clientuimodel", "zmInventory.widget_dragonride_parts", 12000, 1, "int", undefined, 0, 0);
}

