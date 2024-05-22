#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_bgb;
#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/flag_shared;
#using scripts/codescripts/struct;

#namespace namespace_1958c5da;

// Namespace namespace_1958c5da
// Params 0, eflags: 0x2
// Checksum 0xd8a8fe18, Offset: 0x140
// Size: 0x34
function function_2dc19561() {
    system::register("zm_bgb_impatient", &__init__, undefined, undefined);
}

// Namespace namespace_1958c5da
// Params 0, eflags: 0x1 linked
// Checksum 0x8447d6e1, Offset: 0x180
// Size: 0x3c
function __init__() {
    if (!(isdefined(level.bgb_in_use) && level.bgb_in_use)) {
        return;
    }
    bgb::register("zm_bgb_impatient", "event");
}

