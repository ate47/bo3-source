#using scripts/codescripts/struct;
#using scripts/shared/clientfield_shared;
#using scripts/shared/system_shared;
#using scripts/shared/visionset_mgr_shared;
#using scripts/zm/_zm_powerup_shield_charge;
#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_weap_riotshield;
#using scripts/zm/craftables/_zm_craftables;

#namespace zm_craft_shield;

// Namespace zm_craft_shield
// Params 0, eflags: 0x2
// Checksum 0x96ca11f0, Offset: 0x240
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("zm_craft_shield", &__init__, undefined, undefined);
}

// Namespace zm_craft_shield
// Params 0, eflags: 0x0
// Checksum 0x1571d37d, Offset: 0x280
// Size: 0x184
function __init__() {
    zm_craftables::function_ac4e44a7("craft_shield_zm");
    zm_craftables::function_8421d708("craft_shield_zm");
    registerclientfield("world", "piece_riotshield_dolly", 1, 1, "int", &zm_utility::setsharedinventoryuimodels, 0);
    registerclientfield("world", "piece_riotshield_door", 1, 1, "int", &zm_utility::setsharedinventoryuimodels, 0);
    registerclientfield("world", "piece_riotshield_clamp", 1, 1, "int", &zm_utility::setsharedinventoryuimodels, 0);
    clientfield::register("toplayer", "ZMUI_SHIELD_PART_PICKUP", 1, 1, "int", &zm_utility::zm_ui_infotext, 0, 1);
    clientfield::register("toplayer", "ZMUI_SHIELD_CRAFTED", 1, 1, "int", &zm_utility::zm_ui_infotext, 0, 1);
}

