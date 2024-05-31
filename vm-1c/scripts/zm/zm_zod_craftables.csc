#using scripts/zm/craftables/_zm_craftables;
#using scripts/zm/_zm_utility;
#using scripts/zm/zm_zod_quest;
#using scripts/shared/clientfield_shared;

#namespace namespace_4624f91a;

// Namespace namespace_4624f91a
// Params 0, eflags: 0x0
// namespace_4624f91a<file_0>::function_95743e9f
// Checksum 0x982e5774, Offset: 0x340
// Size: 0xec
function function_95743e9f() {
    register_clientfields();
    namespace_f37770c8::function_8421d708("police_box");
    namespace_f37770c8::function_8421d708("idgun");
    namespace_f37770c8::function_8421d708("second_idgun");
    namespace_f37770c8::function_8421d708("ritual_boxer");
    namespace_f37770c8::function_8421d708("ritual_detective");
    namespace_f37770c8::function_8421d708("ritual_femme");
    namespace_f37770c8::function_8421d708("ritual_magician");
    namespace_f37770c8::function_8421d708("ritual_pap");
    level thread namespace_f37770c8::function_5654f132();
}

// Namespace namespace_4624f91a
// Params 0, eflags: 0x0
// namespace_4624f91a<file_0>::function_3ebec56b
// Checksum 0x38fa2f07, Offset: 0x438
// Size: 0xc4
function function_3ebec56b() {
    namespace_f37770c8::function_ac4e44a7("police_box");
    namespace_f37770c8::function_ac4e44a7("idgun");
    namespace_f37770c8::function_ac4e44a7("second_idgun");
    namespace_f37770c8::function_ac4e44a7("ritual_boxer");
    namespace_f37770c8::function_ac4e44a7("ritual_detective");
    namespace_f37770c8::function_ac4e44a7("ritual_femme");
    namespace_f37770c8::function_ac4e44a7("ritual_magician");
    namespace_f37770c8::function_ac4e44a7("ritual_pap");
}

// Namespace namespace_4624f91a
// Params 0, eflags: 0x0
// namespace_4624f91a<file_0>::function_4ece4a2f
// Checksum 0x92dea793, Offset: 0x508
// Size: 0x874
function register_clientfields() {
    var_a0199abd = 1;
    registerclientfield("world", "police_box" + "_" + "fuse_01", 1, var_a0199abd, "int", &zm_utility::setsharedinventoryuimodels, 0);
    registerclientfield("world", "police_box" + "_" + "fuse_02", 1, var_a0199abd, "int", &zm_utility::setsharedinventoryuimodels, 0);
    registerclientfield("world", "police_box" + "_" + "fuse_03", 1, var_a0199abd, "int", &zm_utility::setsharedinventoryuimodels, 0);
    registerclientfield("world", "idgun" + "_" + "part_heart", 1, var_a0199abd, "int", &zm_utility::setsharedinventoryuimodels, 0, 1);
    registerclientfield("world", "idgun" + "_" + "part_skeleton", 1, var_a0199abd, "int", &zm_utility::setsharedinventoryuimodels, 0, 1);
    registerclientfield("world", "idgun" + "_" + "part_xenomatter", 1, var_a0199abd, "int", &zm_utility::setsharedinventoryuimodels, 0, 1);
    registerclientfield("world", "second_idgun" + "_" + "part_heart", 1, var_a0199abd, "int", &zm_utility::setsharedinventoryuimodels, 0, 1);
    registerclientfield("world", "second_idgun" + "_" + "part_skeleton", 1, var_a0199abd, "int", &zm_utility::setsharedinventoryuimodels, 0, 1);
    registerclientfield("world", "second_idgun" + "_" + "part_xenomatter", 1, var_a0199abd, "int", &zm_utility::setsharedinventoryuimodels, 0, 1);
    foreach (var_f7af1630 in level.var_6f8e5f09) {
        registerclientfield("world", "holder_of_" + var_f7af1630, 1, 3, "int", &zm_utility::setsharedinventoryuimodels, 0, 1);
    }
    registerclientfield("world", "quest_state_" + "boxer", 1, 3, "int", &namespace_1f61c67f::function_b8553178, 0, 1);
    registerclientfield("world", "quest_state_" + "detective", 1, 3, "int", &namespace_1f61c67f::function_42da8b5f, 0, 1);
    registerclientfield("world", "quest_state_" + "femme", 1, 3, "int", &namespace_1f61c67f::function_6fa910ac, 0, 1);
    registerclientfield("world", "quest_state_" + "magician", 1, 3, "int", &namespace_1f61c67f::function_2c62c721, 0, 1);
    clientfield::register("toplayer", "ZM_ZOD_UI_FUSE_PICKUP", 1, 1, "int", &zm_utility::zm_ui_infotext, 0, 1);
    clientfield::register("toplayer", "ZM_ZOD_UI_FUSE_PLACED", 1, 1, "int", &zm_utility::zm_ui_infotext, 0, 1);
    clientfield::register("toplayer", "ZM_ZOD_UI_FUSE_CRAFTED", 1, 1, "int", &zm_utility::zm_ui_infotext, 0, 1);
    clientfield::register("toplayer", "ZM_ZOD_UI_IDGUN_HEART_PICKUP", 1, 1, "int", &zm_utility::zm_ui_infotext, 0, 1);
    clientfield::register("toplayer", "ZM_ZOD_UI_IDGUN_TENTACLE_PICKUP", 1, 1, "int", &zm_utility::zm_ui_infotext, 0, 1);
    clientfield::register("toplayer", "ZM_ZOD_UI_IDGUN_XENOMATTER_PICKUP", 1, 1, "int", &zm_utility::zm_ui_infotext, 0, 1);
    clientfield::register("toplayer", "ZM_ZOD_UI_IDGUN_CRAFTED", 1, 1, "int", &zm_utility::zm_ui_infotext, 0, 1);
    clientfield::register("toplayer", "ZM_ZOD_UI_MEMENTO_BOXER_PICKUP", 1, 1, "int", &zm_utility::zm_ui_infotext, 0, 1);
    clientfield::register("toplayer", "ZM_ZOD_UI_MEMENTO_DETECTIVE_PICKUP", 1, 1, "int", &zm_utility::zm_ui_infotext, 0, 1);
    clientfield::register("toplayer", "ZM_ZOD_UI_MEMENTO_FEMME_PICKUP", 1, 1, "int", &zm_utility::zm_ui_infotext, 0, 1);
    clientfield::register("toplayer", "ZM_ZOD_UI_MEMENTO_MAGICIAN_PICKUP", 1, 1, "int", &zm_utility::zm_ui_infotext, 0, 1);
    clientfield::register("toplayer", "ZM_ZOD_UI_GATEWORM_PICKUP", 1, 1, "int", &zm_utility::zm_ui_infotext, 0, 1);
}

