#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_powerups;
#using scripts/zm/_zm_bgb;
#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/flag_shared;
#using scripts/codescripts/struct;

#namespace zm_bgb_kill_joy;

// Namespace zm_bgb_kill_joy
// Params 0, eflags: 0x2
// Checksum 0x62786fb1, Offset: 0x170
// Size: 0x34
function function_2dc19561() {
    system::register("zm_bgb_kill_joy", &__init__, undefined, "bgb");
}

// Namespace zm_bgb_kill_joy
// Params 0, eflags: 0x1 linked
// Checksum 0x608cb52f, Offset: 0x1b0
// Size: 0x54
function __init__() {
    if (!(isdefined(level.bgb_in_use) && level.bgb_in_use)) {
        return;
    }
    bgb::register("zm_bgb_kill_joy", "activated", 2, undefined, undefined, undefined, &activation);
}

// Namespace zm_bgb_kill_joy
// Params 0, eflags: 0x1 linked
// Checksum 0x910484, Offset: 0x210
// Size: 0x24
function activation() {
    self thread bgb::function_dea74fb0("insta_kill");
}
