#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_bgb;
#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/flag_shared;
#using scripts/codescripts/struct;

#namespace namespace_8b3a30e2;

// Namespace namespace_8b3a30e2
// Params 0, eflags: 0x2
// Checksum 0x75cc1cdb, Offset: 0x140
// Size: 0x34
function function_2dc19561() {
    system::register("zm_bgb_lucky_crit", &__init__, undefined, undefined);
}

// Namespace namespace_8b3a30e2
// Params 0, eflags: 0x1 linked
// Checksum 0x2e9bb2b2, Offset: 0x180
// Size: 0x3c
function __init__() {
    if (!(isdefined(level.bgb_in_use) && level.bgb_in_use)) {
        return;
    }
    bgb::register("zm_bgb_lucky_crit", "rounds");
}

