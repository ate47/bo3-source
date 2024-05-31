#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_bgb;
#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/flag_shared;
#using scripts/codescripts/struct;

#namespace namespace_105bda17;

// Namespace namespace_105bda17
// Params 0, eflags: 0x2
// Checksum 0x4c8117f5, Offset: 0x158
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("zm_bgb_fear_in_headlights", &__init__, undefined, undefined);
}

// Namespace namespace_105bda17
// Params 0, eflags: 0x1 linked
// Checksum 0x73a1c36b, Offset: 0x198
// Size: 0x3c
function __init__() {
    if (!(isdefined(level.bgb_in_use) && level.bgb_in_use)) {
        return;
    }
    bgb::register("zm_bgb_fear_in_headlights", "activated");
}

