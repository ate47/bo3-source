#using scripts/codescripts/struct;
#using scripts/shared/system_shared;
#using scripts/zm/_zm_powerups;

#namespace zm_powerup_carpenter;

// Namespace zm_powerup_carpenter
// Params 0, eflags: 0x2
// Checksum 0x7a441b40, Offset: 0xf0
// Size: 0x34
function autoexec __init__sytem__() {
    system::register("zm_powerup_carpenter", &__init__, undefined, undefined);
}

// Namespace zm_powerup_carpenter
// Params 0, eflags: 0x0
// Checksum 0x5ba5ec7c, Offset: 0x130
// Size: 0x34
function __init__() {
    zm_powerups::include_zombie_powerup("carpenter");
    zm_powerups::add_zombie_powerup("carpenter");
}

