#using scripts/zm/_zm_powerups;
#using scripts/shared/system_shared;
#using scripts/codescripts/struct;

#namespace namespace_6500cb2b;

// Namespace namespace_6500cb2b
// Params 0, eflags: 0x2
// Checksum 0x6ec27e63, Offset: 0xf8
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("zm_powerup_beast_mana", &__init__, undefined, undefined);
}

// Namespace namespace_6500cb2b
// Params 0, eflags: 0x0
// Checksum 0xa44738f2, Offset: 0x138
// Size: 0x34
function __init__() {
    zm_powerups::include_zombie_powerup("beast_mana");
    zm_powerups::add_zombie_powerup("beast_mana");
}

