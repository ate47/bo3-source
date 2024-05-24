#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_bgb;
#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/flag_shared;
#using scripts/codescripts/struct;

#namespace namespace_2f637cea;

// Namespace namespace_2f637cea
// Params 0, eflags: 0x2
// Checksum 0xac84c140, Offset: 0x150
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("zm_bgb_slaughter_slide", &__init__, undefined, undefined);
}

// Namespace namespace_2f637cea
// Params 0, eflags: 0x1 linked
// Checksum 0x648458ce, Offset: 0x190
// Size: 0x3c
function __init__() {
    if (!(isdefined(level.bgb_in_use) && level.bgb_in_use)) {
        return;
    }
    bgb::register("zm_bgb_slaughter_slide", "event");
}

