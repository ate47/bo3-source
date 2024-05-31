#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_bgb;
#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/flag_shared;
#using scripts/codescripts/struct;

#namespace zm_bgb_anywhere_but_here;

// Namespace zm_bgb_anywhere_but_here
// Params 0, eflags: 0x2
// namespace_93b7f03<file_0>::function_2dc19561
// Checksum 0xdef78a3b, Offset: 0x158
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("zm_bgb_anywhere_but_here", &__init__, undefined, undefined);
}

// Namespace zm_bgb_anywhere_but_here
// Params 0, eflags: 0x1 linked
// namespace_93b7f03<file_0>::function_8c87d8eb
// Checksum 0xd8baf0f8, Offset: 0x198
// Size: 0x3c
function __init__() {
    if (!(isdefined(level.bgb_in_use) && level.bgb_in_use)) {
        return;
    }
    bgb::register("zm_bgb_anywhere_but_here", "activated");
}

