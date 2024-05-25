#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_lightning_chain;
#using scripts/zm/_zm_bgb;
#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/flag_shared;
#using scripts/codescripts/struct;

#namespace zm_bgb_pop_shocks;

// Namespace zm_bgb_pop_shocks
// Params 0, eflags: 0x2
// Checksum 0xa4d4e6c6, Offset: 0x168
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("zm_bgb_pop_shocks", &__init__, undefined, undefined);
}

// Namespace zm_bgb_pop_shocks
// Params 0, eflags: 0x1 linked
// Checksum 0xbe98da8, Offset: 0x1a8
// Size: 0x3c
function __init__() {
    if (!(isdefined(level.bgb_in_use) && level.bgb_in_use)) {
        return;
    }
    bgb::register("zm_bgb_pop_shocks", "event");
}

