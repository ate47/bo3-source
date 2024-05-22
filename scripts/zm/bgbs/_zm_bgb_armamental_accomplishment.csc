#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_bgb;
#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/flag_shared;
#using scripts/codescripts/struct;

#namespace namespace_4754119d;

// Namespace namespace_4754119d
// Params 0, eflags: 0x2
// Checksum 0x2e8579, Offset: 0x160
// Size: 0x34
function function_2dc19561() {
    system::register("zm_bgb_armamental_accomplishment", &__init__, undefined, undefined);
}

// Namespace namespace_4754119d
// Params 0, eflags: 0x1 linked
// Checksum 0xdfff17d3, Offset: 0x1a0
// Size: 0x3c
function __init__() {
    if (!(isdefined(level.bgb_in_use) && level.bgb_in_use)) {
        return;
    }
    bgb::register("zm_bgb_armamental_accomplishment", "rounds");
}

