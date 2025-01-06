#using scripts/codescripts/struct;
#using scripts/shared/flag_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/zm/_zm_bgb;
#using scripts/zm/_zm_utility;

#namespace zm_bgb_aftertaste;

// Namespace zm_bgb_aftertaste
// Params 0, eflags: 0x2
// Checksum 0x2f84451c, Offset: 0x140
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("zm_bgb_aftertaste", &__init__, undefined, undefined);
}

// Namespace zm_bgb_aftertaste
// Params 0, eflags: 0x0
// Checksum 0x11b72500, Offset: 0x180
// Size: 0x3c
function __init__() {
    if (!(isdefined(level.bgb_in_use) && level.bgb_in_use)) {
        return;
    }
    bgb::register("zm_bgb_aftertaste", "rounds");
}

