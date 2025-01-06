#using scripts/codescripts/struct;
#using scripts/shared/flag_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/zm/_zm_bgb;
#using scripts/zm/_zm_utility;

#namespace zm_bgb_danger_closest;

// Namespace zm_bgb_danger_closest
// Params 0, eflags: 0x2
// Checksum 0x536dc5f6, Offset: 0x148
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("zm_bgb_danger_closest", &__init__, undefined, undefined);
}

// Namespace zm_bgb_danger_closest
// Params 0, eflags: 0x0
// Checksum 0x9f70a84d, Offset: 0x188
// Size: 0x3c
function __init__() {
    if (!(isdefined(level.bgb_in_use) && level.bgb_in_use)) {
        return;
    }
    bgb::register("zm_bgb_danger_closest", "rounds");
}

