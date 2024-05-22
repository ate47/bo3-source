#using scripts/zm/_zm_powerups;
#using scripts/shared/system_shared;
#using scripts/codescripts/struct;

#namespace zm_powerup_full_ammo;

// Namespace zm_powerup_full_ammo
// Params 0, eflags: 0x2
// Checksum 0xbf63b52d, Offset: 0x108
// Size: 0x34
function function_2dc19561() {
    system::register("zm_powerup_full_ammo", &__init__, undefined, undefined);
}

// Namespace zm_powerup_full_ammo
// Params 0, eflags: 0x0
// Checksum 0x6db31c5f, Offset: 0x148
// Size: 0x6c
function __init__() {
    zm_powerups::include_zombie_powerup("full_ammo");
    if (tolower(getdvarstring("g_gametype")) != "zcleansed") {
        zm_powerups::add_zombie_powerup("full_ammo");
    }
}

