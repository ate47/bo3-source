#using scripts/zm/_zm_powerups;
#using scripts/shared/system_shared;
#using scripts/codescripts/struct;

#namespace zm_powerup_carpenter;

// Namespace zm_powerup_carpenter
// Params 0, eflags: 0x2
// namespace_a5ab9a0e<file_0>::function_2dc19561
// Checksum 0xdf600e67, Offset: 0xf0
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("zm_powerup_carpenter", &__init__, undefined, undefined);
}

// Namespace zm_powerup_carpenter
// Params 0, eflags: 0x1 linked
// namespace_a5ab9a0e<file_0>::function_8c87d8eb
// Checksum 0x59681989, Offset: 0x130
// Size: 0x34
function __init__() {
    zm_powerups::include_zombie_powerup("carpenter");
    zm_powerups::add_zombie_powerup("carpenter");
}

