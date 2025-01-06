#using scripts/codescripts/struct;
#using scripts/shared/clientfield_shared;
#using scripts/zm/_zm_utility;
#using scripts/zm/craftables/_zm_craftables;

#namespace zm_island_craftables;

// Namespace zm_island_craftables
// Params 0, eflags: 0x0
// Checksum 0x5b982eef, Offset: 0x178
// Size: 0x44
function function_95743e9f() {
    register_clientfields();
    zm_craftables::function_8421d708("gasmask");
    level thread zm_craftables::function_5654f132();
}

// Namespace zm_island_craftables
// Params 0, eflags: 0x0
// Checksum 0x1a9afc8a, Offset: 0x1c8
// Size: 0x1c
function function_3ebec56b() {
    zm_craftables::function_ac4e44a7("gasmask");
}

// Namespace zm_island_craftables
// Params 0, eflags: 0x0
// Checksum 0x7829bfea, Offset: 0x1f0
// Size: 0x1ac
function register_clientfields() {
    var_a0199abd = 1;
    registerclientfield("world", "gasmask" + "_" + "part_visor", 9000, var_a0199abd, "int", &zm_utility::setsharedinventoryuimodels, 0, 1);
    registerclientfield("world", "gasmask" + "_" + "part_filter", 9000, var_a0199abd, "int", &zm_utility::setsharedinventoryuimodels, 0, 1);
    registerclientfield("world", "gasmask" + "_" + "part_strap", 9000, var_a0199abd, "int", &zm_utility::setsharedinventoryuimodels, 0, 1);
    clientfield::register("toplayer", "ZMUI_GRAVITYSPIKE_PART_PICKUP", 9000, 1, "int", &zm_utility::zm_ui_infotext, 0, 1);
    clientfield::register("toplayer", "ZMUI_GRAVITYSPIKE_CRAFTED", 9000, 1, "int", &zm_utility::zm_ui_infotext, 0, 1);
}

