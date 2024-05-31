#using scripts/zm/_zm_powerups;
#using scripts/shared/system_shared;
#using scripts/codescripts/struct;

#namespace zm_powerup_free_perk;

// Namespace zm_powerup_free_perk
// Params 0, eflags: 0x2
// namespace_a85afeef<file_0>::function_2dc19561
// Checksum 0x70c3b000, Offset: 0xf8
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("zm_powerup_empty_perk", &__init__, undefined, undefined);
}

// Namespace zm_powerup_free_perk
// Params 0, eflags: 0x1 linked
// namespace_a85afeef<file_0>::function_8c87d8eb
// Checksum 0xba81366b, Offset: 0x138
// Size: 0x34
function __init__() {
    zm_powerups::include_zombie_powerup("empty_perk");
    zm_powerups::add_zombie_powerup("empty_perk");
}

