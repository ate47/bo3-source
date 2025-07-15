#using scripts/codescripts/struct;
#using scripts/shared/clientfield_shared;
#using scripts/zm/_zm_utility;
#using scripts/zm/craftables/_zm_craftables;

#namespace zm_stalingrad_craftables;

// Namespace zm_stalingrad_craftables
// Params 0
// Checksum 0x425546e5, Offset: 0x1b0
// Size: 0x44
function init_craftables()
{
    register_clientfields();
    zm_craftables::add_zombie_craftable( "dragonride" );
    level thread zm_craftables::set_clientfield_craftables_code_callbacks();
}

// Namespace zm_stalingrad_craftables
// Params 0
// Checksum 0x701cdc63, Offset: 0x200
// Size: 0x1c
function include_craftables()
{
    zm_craftables::include_zombie_craftable( "dragonride" );
}

// Namespace zm_stalingrad_craftables
// Params 0
// Checksum 0xdd67189d, Offset: 0x228
// Size: 0x1d4
function register_clientfields()
{
    shared_bits = 1;
    registerclientfield( "world", "dragonride" + "_" + "part_transmitter", 12000, shared_bits, "int", &zm_utility::setsharedinventoryuimodels, 0 );
    registerclientfield( "world", "dragonride" + "_" + "part_codes", 12000, shared_bits, "int", &zm_utility::setsharedinventoryuimodels, 0 );
    registerclientfield( "world", "dragonride" + "_" + "part_map", 12000, shared_bits, "int", &zm_utility::setsharedinventoryuimodels, 0 );
    clientfield::register( "toplayer", "ZMUI_DRAGONRIDE_PART_PICKUP", 12000, 1, "int", &zm_utility::zm_ui_infotext, 0, 1 );
    clientfield::register( "toplayer", "ZMUI_DRAGONRIDE_CRAFTED", 12000, 1, "int", &zm_utility::zm_ui_infotext, 0, 1 );
    clientfield::register( "clientuimodel", "zmInventory.widget_dragonride_parts", 12000, 1, "int", undefined, 0, 0 );
}

