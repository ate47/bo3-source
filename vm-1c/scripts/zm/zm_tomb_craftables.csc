#using scripts/zm/craftables/_zm_craftables;
#using scripts/zm/_zm_utility;
#using scripts/shared/util_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/array_shared;
#using scripts/codescripts/struct;

#namespace namespace_f7a613cf;

// Namespace namespace_f7a613cf
// Params 0, eflags: 0x1 linked
// namespace_f7a613cf<file_0>::function_95743e9f
// Checksum 0x4fa199f3, Offset: 0x680
// Size: 0xf4
function function_95743e9f() {
    level.var_90238c9a = 4;
    namespace_f37770c8::function_8421d708("equip_dieseldrone");
    namespace_f37770c8::function_8421d708("shovel");
    namespace_f37770c8::function_8421d708("elemental_staff_fire");
    namespace_f37770c8::function_8421d708("elemental_staff_air");
    namespace_f37770c8::function_8421d708("elemental_staff_water");
    namespace_f37770c8::function_8421d708("elemental_staff_lightning");
    namespace_f37770c8::function_8421d708("gramophone");
    function_3ebec56b();
    register_clientfields();
    level thread namespace_f37770c8::function_5654f132();
}

// Namespace namespace_f7a613cf
// Params 0, eflags: 0x1 linked
// namespace_f7a613cf<file_0>::function_3ebec56b
// Checksum 0x848867a4, Offset: 0x780
// Size: 0xac
function function_3ebec56b() {
    namespace_f37770c8::function_ac4e44a7("equip_dieseldrone");
    namespace_f37770c8::function_ac4e44a7("shovel");
    namespace_f37770c8::function_ac4e44a7("elemental_staff_fire");
    namespace_f37770c8::function_ac4e44a7("elemental_staff_air");
    namespace_f37770c8::function_ac4e44a7("elemental_staff_water");
    namespace_f37770c8::function_ac4e44a7("elemental_staff_lightning");
    namespace_f37770c8::function_ac4e44a7("gramophone");
}

// Namespace namespace_f7a613cf
// Params 0, eflags: 0x1 linked
// namespace_f7a613cf<file_0>::function_4ece4a2f
// Checksum 0x9a15b3b8, Offset: 0x838
// Size: 0xbcc
function register_clientfields() {
    bits = 1;
    clientfield::register("world", "piece_quadrotor_zm_body", 21000, bits, "int", &zm_utility::setsharedinventoryuimodels, 0, 0);
    clientfield::register("world", "piece_quadrotor_zm_brain", 21000, bits, "int", &zm_utility::setsharedinventoryuimodels, 0, 0);
    clientfield::register("world", "piece_quadrotor_zm_engine", 21000, bits, "int", &zm_utility::setsharedinventoryuimodels, 0, 0);
    clientfield::register("world", "air_staff.piece_zm_gem", 21000, bits, "int", &zm_utility::setsharedinventoryuimodels, 0, 0);
    clientfield::register("world", "air_staff.piece_zm_ustaff", 21000, bits, "int", &zm_utility::setsharedinventoryuimodels, 0, 0);
    clientfield::register("world", "air_staff.piece_zm_mstaff", 21000, bits, "int", &zm_utility::setsharedinventoryuimodels, 0, 0);
    clientfield::register("world", "air_staff.piece_zm_lstaff", 21000, bits, "int", &zm_utility::setsharedinventoryuimodels, 0, 0);
    clientfield::register("clientuimodel", "zmInventory.air_staff.visible", 21000, bits, "int", undefined, 0, 0);
    clientfield::register("world", "fire_staff.piece_zm_gem", 21000, bits, "int", &zm_utility::setsharedinventoryuimodels, 0, 0);
    clientfield::register("world", "fire_staff.piece_zm_ustaff", 21000, bits, "int", &zm_utility::setsharedinventoryuimodels, 0, 0);
    clientfield::register("world", "fire_staff.piece_zm_mstaff", 21000, bits, "int", &zm_utility::setsharedinventoryuimodels, 0, 0);
    clientfield::register("world", "fire_staff.piece_zm_lstaff", 21000, bits, "int", &zm_utility::setsharedinventoryuimodels, 0, 0);
    clientfield::register("clientuimodel", "zmInventory.fire_staff.visible", 21000, bits, "int", undefined, 0, 0);
    clientfield::register("world", "lightning_staff.piece_zm_gem", 21000, bits, "int", &zm_utility::setsharedinventoryuimodels, 0, 0);
    clientfield::register("world", "lightning_staff.piece_zm_ustaff", 21000, bits, "int", &zm_utility::setsharedinventoryuimodels, 0, 0);
    clientfield::register("world", "lightning_staff.piece_zm_mstaff", 21000, bits, "int", &zm_utility::setsharedinventoryuimodels, 0, 0);
    clientfield::register("world", "lightning_staff.piece_zm_lstaff", 21000, bits, "int", &zm_utility::setsharedinventoryuimodels, 0, 0);
    clientfield::register("clientuimodel", "zmInventory.lightning_staff.visible", 21000, bits, "int", undefined, 0, 0);
    clientfield::register("world", "water_staff.piece_zm_gem", 21000, bits, "int", &zm_utility::setsharedinventoryuimodels, 0, 0);
    clientfield::register("world", "water_staff.piece_zm_ustaff", 21000, bits, "int", &zm_utility::setsharedinventoryuimodels, 0, 0);
    clientfield::register("world", "water_staff.piece_zm_mstaff", 21000, bits, "int", &zm_utility::setsharedinventoryuimodels, 0, 0);
    clientfield::register("world", "water_staff.piece_zm_lstaff", 21000, bits, "int", &zm_utility::setsharedinventoryuimodels, 0, 0);
    clientfield::register("clientuimodel", "zmInventory.water_staff.visible", 21000, bits, "int", undefined, 0, 0);
    clientfield::register("world", "piece_record_zm_player", 21000, bits, "int", &zm_utility::setsharedinventoryuimodels, 0, 0);
    clientfield::register("world", "piece_record_zm_vinyl_master", 21000, bits, "int", &zm_utility::setsharedinventoryuimodels, 0, 0);
    clientfield::register("world", "piece_record_zm_vinyl_air", 21000, bits, "int", &zm_utility::setsharedinventoryuimodels, 0, 0);
    clientfield::register("world", "piece_record_zm_vinyl_water", 21000, bits, "int", &zm_utility::setsharedinventoryuimodels, 0, 0);
    clientfield::register("world", "piece_record_zm_vinyl_fire", 21000, bits, "int", &zm_utility::setsharedinventoryuimodels, 0, 0);
    clientfield::register("world", "piece_record_zm_vinyl_lightning", 21000, bits, "int", &zm_utility::setsharedinventoryuimodels, 0, 0);
    bits = getminbitcountfornum(5);
    clientfield::register("world", "air_staff.holder", 21000, bits, "int", &zm_utility::setsharedinventoryuimodels, 0, 0);
    clientfield::register("world", "fire_staff.holder", 21000, bits, "int", &zm_utility::setsharedinventoryuimodels, 0, 0);
    clientfield::register("world", "lightning_staff.holder", 21000, bits, "int", &zm_utility::setsharedinventoryuimodels, 0, 0);
    clientfield::register("world", "water_staff.holder", 21000, bits, "int", &zm_utility::setsharedinventoryuimodels, 0, 0);
    bits = getminbitcountfornum(5);
    clientfield::register("world", "fire_staff.quest_state", 21000, bits, "int", &zm_utility::setsharedinventoryuimodels, 0, 1);
    clientfield::register("world", "air_staff.quest_state", 21000, bits, "int", &zm_utility::setsharedinventoryuimodels, 0, 1);
    clientfield::register("world", "lightning_staff.quest_state", 21000, bits, "int", &zm_utility::setsharedinventoryuimodels, 0, 1);
    clientfield::register("world", "water_staff.quest_state", 21000, bits, "int", &zm_utility::setsharedinventoryuimodels, 0, 1);
    clientfield::register("clientuimodel", "zmInventory.show_maxis_drone_parts_widget", 21000, 1, "int", undefined, 0, 0);
    clientfield::register("clientuimodel", "zmInventory.current_gem", 21000, getminbitcountfornum(5), "int", undefined, 0, 0);
    clientfield::register("clientuimodel", "zmInventory.show_musical_parts_widget", 21000, 1, "int", undefined, 0, 0);
    clientfield::register("clientuimodel", "hudItems.showDpadRight_Drone", 21000, 1, "int", undefined, 0, 0);
    clientfield::register("clientuimodel", "hudItems.showDpadLeft_Staff", 21000, 1, "int", undefined, 0, 0);
    clientfield::register("clientuimodel", "hudItems.dpadLeftAmmo", 21000, 2, "int", undefined, 0, 0);
}

