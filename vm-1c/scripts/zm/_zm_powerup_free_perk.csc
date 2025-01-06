#using scripts/codescripts/struct;
#using scripts/shared/system_shared;
#using scripts/zm/_zm_powerups;

#namespace zm_powerup_free_perk;

// Namespace zm_powerup_free_perk
// Params 0, eflags: 0x2
// Checksum 0x5561a317, Offset: 0xf0
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("zm_powerup_free_perk", &__init__, undefined, undefined);
}

// Namespace zm_powerup_free_perk
// Params 0, eflags: 0x0
// Checksum 0xba800786, Offset: 0x130
// Size: 0x34
function __init__() {
    zm_powerups::include_zombie_powerup("free_perk");
    zm_powerups::add_zombie_powerup("free_perk");
}

