#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_bgb;
#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/flag_shared;
#using scripts/codescripts/struct;

#namespace zm_bgb_phoenix_up;

// Namespace zm_bgb_phoenix_up
// Params 0, eflags: 0x2
// namespace_7ffac71e<file_0>::function_2dc19561
// Checksum 0xb57e802a, Offset: 0x148
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("zm_bgb_phoenix_up", &__init__, undefined, undefined);
}

// Namespace zm_bgb_phoenix_up
// Params 0, eflags: 0x1 linked
// namespace_7ffac71e<file_0>::function_8c87d8eb
// Checksum 0xb0cfd6e3, Offset: 0x188
// Size: 0x3c
function __init__() {
    if (!(isdefined(level.bgb_in_use) && level.bgb_in_use)) {
        return;
    }
    bgb::register("zm_bgb_phoenix_up", "activated");
}

