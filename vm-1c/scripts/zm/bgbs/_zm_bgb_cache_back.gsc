#using scripts/codescripts/struct;
#using scripts/shared/flag_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/zm/_zm_bgb;
#using scripts/zm/_zm_utility;

#namespace zm_bgb_cache_back;

// Namespace zm_bgb_cache_back
// Params 0, eflags: 0x2
// Checksum 0x11785c9e, Offset: 0x158
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("zm_bgb_cache_back", &__init__, undefined, "bgb");
}

// Namespace zm_bgb_cache_back
// Params 0, eflags: 0x0
// Checksum 0xdb0ead9, Offset: 0x198
// Size: 0x54
function __init__() {
    if (!(isdefined(level.bgb_in_use) && level.bgb_in_use)) {
        return;
    }
    bgb::register("zm_bgb_cache_back", "activated", 1, undefined, undefined, undefined, &activation);
}

// Namespace zm_bgb_cache_back
// Params 0, eflags: 0x0
// Checksum 0x268560c4, Offset: 0x1f8
// Size: 0x24
function activation() {
    self thread bgb::function_dea74fb0("full_ammo");
}

