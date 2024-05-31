#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_bgb;
#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/flag_shared;
#using scripts/codescripts/struct;

#namespace zm_bgb_cache_back;

// Namespace zm_bgb_cache_back
// Params 0, eflags: 0x2
// namespace_767b8a45<file_0>::function_2dc19561
// Checksum 0xbf91767b, Offset: 0x148
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("zm_bgb_cache_back", &__init__, undefined, undefined);
}

// Namespace zm_bgb_cache_back
// Params 0, eflags: 0x1 linked
// namespace_767b8a45<file_0>::function_8c87d8eb
// Checksum 0x9a2bf5ea, Offset: 0x188
// Size: 0x3c
function __init__() {
    if (!(isdefined(level.bgb_in_use) && level.bgb_in_use)) {
        return;
    }
    bgb::register("zm_bgb_cache_back", "activated");
}

