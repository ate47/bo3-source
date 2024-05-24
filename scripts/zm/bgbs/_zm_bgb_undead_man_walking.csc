#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_bgb;
#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/flag_shared;
#using scripts/codescripts/struct;

#namespace zm_bgb_undead_man_walking;

// Namespace zm_bgb_undead_man_walking
// Params 0, eflags: 0x2
// Checksum 0xba2db1d1, Offset: 0x150
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("zm_bgb_undead_man_walking", &__init__, undefined, undefined);
}

// Namespace zm_bgb_undead_man_walking
// Params 0, eflags: 0x1 linked
// Checksum 0x17fb5b72, Offset: 0x190
// Size: 0x3c
function __init__() {
    if (!(isdefined(level.bgb_in_use) && level.bgb_in_use)) {
        return;
    }
    bgb::register("zm_bgb_undead_man_walking", "time");
}

