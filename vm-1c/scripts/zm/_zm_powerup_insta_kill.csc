#using scripts/zm/_zm_powerups;
#using scripts/shared/system_shared;
#using scripts/codescripts/struct;

#namespace zm_powerup_insta_kill;

// Namespace zm_powerup_insta_kill
// Params 0, eflags: 0x2
// namespace_e01d98c2<file_0>::function_2dc19561
// Checksum 0x9c94a492, Offset: 0x120
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("zm_powerup_insta_kill", &__init__, undefined, undefined);
}

// Namespace zm_powerup_insta_kill
// Params 0, eflags: 0x1 linked
// namespace_e01d98c2<file_0>::function_8c87d8eb
// Checksum 0x97362a4d, Offset: 0x160
// Size: 0x74
function __init__() {
    zm_powerups::include_zombie_powerup("insta_kill");
    if (tolower(getdvarstring("g_gametype")) != "zcleansed") {
        zm_powerups::add_zombie_powerup("insta_kill", "powerup_instant_kill");
    }
}

