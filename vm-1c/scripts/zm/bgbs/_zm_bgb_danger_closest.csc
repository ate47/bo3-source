#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_bgb;
#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/flag_shared;
#using scripts/codescripts/struct;

#namespace zm_bgb_danger_closest;

// Namespace zm_bgb_danger_closest
// Params 0, eflags: 0x2
// namespace_3b1d9a60<file_0>::function_2dc19561
// Checksum 0x536dc5f6, Offset: 0x148
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("zm_bgb_danger_closest", &__init__, undefined, undefined);
}

// Namespace zm_bgb_danger_closest
// Params 0, eflags: 0x1 linked
// namespace_3b1d9a60<file_0>::function_8c87d8eb
// Checksum 0x9f70a84d, Offset: 0x188
// Size: 0x3c
function __init__() {
    if (!(isdefined(level.bgb_in_use) && level.bgb_in_use)) {
        return;
    }
    bgb::register("zm_bgb_danger_closest", "rounds");
}

