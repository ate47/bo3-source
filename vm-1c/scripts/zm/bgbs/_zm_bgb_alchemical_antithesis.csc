#using scripts/codescripts/struct;
#using scripts/shared/flag_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/zm/_zm_bgb;
#using scripts/zm/_zm_utility;

#namespace zm_bgb_alchemical_antithesis;

// Namespace zm_bgb_alchemical_antithesis
// Params 0, eflags: 0x2
// Checksum 0xa035259d, Offset: 0x160
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("zm_bgb_alchemical_antithesis", &__init__, undefined, undefined);
}

// Namespace zm_bgb_alchemical_antithesis
// Params 0, eflags: 0x0
// Checksum 0xb8766228, Offset: 0x1a0
// Size: 0x3c
function __init__() {
    if (!(isdefined(level.bgb_in_use) && level.bgb_in_use)) {
        return;
    }
    bgb::register("zm_bgb_alchemical_antithesis", "activated");
}

