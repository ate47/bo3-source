#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_powerups;
#using scripts/shared/system_shared;
#using scripts/shared/clientfield_shared;
#using scripts/codescripts/struct;

#namespace namespace_e37c032f;

// Namespace namespace_e37c032f
// Params 0, eflags: 0x2
// namespace_e37c032f<file_0>::function_2dc19561
// Checksum 0x4a0f53f6, Offset: 0x1b0
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("zm_powerup_island_seed", &__init__, undefined, undefined);
}

// Namespace namespace_e37c032f
// Params 0, eflags: 0x1 linked
// namespace_e37c032f<file_0>::function_8c87d8eb
// Checksum 0x7f371ebf, Offset: 0x1f0
// Size: 0x44
function __init__() {
    register_clientfields();
    zm_powerups::include_zombie_powerup("island_seed");
    zm_powerups::add_zombie_powerup("island_seed");
}

// Namespace namespace_e37c032f
// Params 0, eflags: 0x1 linked
// namespace_e37c032f<file_0>::function_4ece4a2f
// Checksum 0xa130375c, Offset: 0x240
// Size: 0x14c
function register_clientfields() {
    clientfield::register("toplayer", "has_island_seed", 1, 2, "int", undefined, 0, 0);
    clientfield::register("clientuimodel", "zmInventory.widget_seed_parts", 9000, 1, "int", undefined, 0, 0);
    clientfield::register("toplayer", "bucket_seed_01", 9000, 1, "int", &zm_utility::setinventoryuimodels, 0, 1);
    clientfield::register("toplayer", "bucket_seed_02", 9000, 1, "int", &zm_utility::setinventoryuimodels, 0, 1);
    clientfield::register("toplayer", "bucket_seed_03", 9000, 1, "int", &zm_utility::setinventoryuimodels, 0, 1);
}

