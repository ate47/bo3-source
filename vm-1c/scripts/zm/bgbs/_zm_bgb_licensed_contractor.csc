#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_bgb;
#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/flag_shared;
#using scripts/codescripts/struct;

#namespace zm_bgb_licensed_contractor;

// Namespace zm_bgb_licensed_contractor
// Params 0, eflags: 0x2
// namespace_2f4bd124<file_0>::function_2dc19561
// Checksum 0x5f57de5c, Offset: 0x158
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("zm_bgb_licensed_contractor", &__init__, undefined, undefined);
}

// Namespace zm_bgb_licensed_contractor
// Params 0, eflags: 0x1 linked
// namespace_2f4bd124<file_0>::function_8c87d8eb
// Checksum 0x7d698b67, Offset: 0x198
// Size: 0x3c
function __init__() {
    if (!(isdefined(level.bgb_in_use) && level.bgb_in_use)) {
        return;
    }
    bgb::register("zm_bgb_licensed_contractor", "activated");
}

