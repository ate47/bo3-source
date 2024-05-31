#using scripts/zm/craftables/_zm_craftables;
#using scripts/zm/_zm_utility;
#using scripts/shared/clientfield_shared;
#using scripts/codescripts/struct;

#namespace namespace_e73c08bc;

// Namespace namespace_e73c08bc
// Params 0, eflags: 0x1 linked
// namespace_e73c08bc<file_0>::function_95743e9f
// Checksum 0x5b982eef, Offset: 0x178
// Size: 0x44
function function_95743e9f() {
    register_clientfields();
    namespace_f37770c8::function_8421d708("gasmask");
    level thread namespace_f37770c8::function_5654f132();
}

// Namespace namespace_e73c08bc
// Params 0, eflags: 0x1 linked
// namespace_e73c08bc<file_0>::function_3ebec56b
// Checksum 0x1a9afc8a, Offset: 0x1c8
// Size: 0x1c
function function_3ebec56b() {
    namespace_f37770c8::function_ac4e44a7("gasmask");
}

// Namespace namespace_e73c08bc
// Params 0, eflags: 0x1 linked
// namespace_e73c08bc<file_0>::function_4ece4a2f
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

