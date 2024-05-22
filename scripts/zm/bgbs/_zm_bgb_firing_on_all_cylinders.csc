#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_bgb;
#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/flag_shared;
#using scripts/codescripts/struct;

#namespace namespace_ef480314;

// Namespace namespace_ef480314
// Params 0, eflags: 0x2
// Checksum 0x89202ca1, Offset: 0x160
// Size: 0x34
function function_2dc19561() {
    system::register("zm_bgb_firing_on_all_cylinders", &__init__, undefined, undefined);
}

// Namespace namespace_ef480314
// Params 0, eflags: 0x1 linked
// Checksum 0x9a93dfae, Offset: 0x1a0
// Size: 0x3c
function __init__() {
    if (!(isdefined(level.bgb_in_use) && level.bgb_in_use)) {
        return;
    }
    bgb::register("zm_bgb_firing_on_all_cylinders", "rounds");
}

