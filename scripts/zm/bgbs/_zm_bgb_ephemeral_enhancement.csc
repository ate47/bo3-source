#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_bgb;
#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/flag_shared;
#using scripts/codescripts/struct;

#namespace zm_bgb_ephemeral_enhancement;

// Namespace zm_bgb_ephemeral_enhancement
// Params 0, eflags: 0x2
// Checksum 0x376d5fb0, Offset: 0x160
// Size: 0x34
function function_2dc19561() {
    system::register("zm_bgb_ephemeral_enhancement", &__init__, undefined, undefined);
}

// Namespace zm_bgb_ephemeral_enhancement
// Params 0, eflags: 0x1 linked
// Checksum 0xc1e33432, Offset: 0x1a0
// Size: 0x3c
function __init__() {
    if (!(isdefined(level.bgb_in_use) && level.bgb_in_use)) {
        return;
    }
    bgb::register("zm_bgb_ephemeral_enhancement", "activated");
}

