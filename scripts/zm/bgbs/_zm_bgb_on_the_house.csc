#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_bgb;
#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/flag_shared;
#using scripts/codescripts/struct;

#namespace zm_bgb_on_the_house;

// Namespace zm_bgb_on_the_house
// Params 0, eflags: 0x2
// Checksum 0xfc3a56c3, Offset: 0x148
// Size: 0x34
function function_2dc19561() {
    system::register("zm_bgb_on_the_house", &__init__, undefined, undefined);
}

// Namespace zm_bgb_on_the_house
// Params 0, eflags: 0x1 linked
// Checksum 0x945b7103, Offset: 0x188
// Size: 0x3c
function __init__() {
    if (!(isdefined(level.bgb_in_use) && level.bgb_in_use)) {
        return;
    }
    bgb::register("zm_bgb_on_the_house", "activated");
}

