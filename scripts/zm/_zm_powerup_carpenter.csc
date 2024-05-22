#using scripts/zm/_zm_powerups;
#using scripts/shared/system_shared;
#using scripts/codescripts/struct;

#namespace zm_powerup_carpenter;

// Namespace zm_powerup_carpenter
// Params 0, eflags: 0x2
// Checksum 0xc0b0a6e4, Offset: 0xf0
// Size: 0x34
function function_2dc19561() {
    system::register("zm_powerup_carpenter", &__init__, undefined, undefined);
}

// Namespace zm_powerup_carpenter
// Params 0, eflags: 0x0
// Checksum 0x81093b69, Offset: 0x130
// Size: 0x34
function __init__() {
    zm_powerups::include_zombie_powerup("carpenter");
    zm_powerups::add_zombie_powerup("carpenter");
}

