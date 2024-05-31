#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_bgb;
#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/flag_shared;
#using scripts/codescripts/struct;

#namespace zm_bgb_perkaholic;

// Namespace zm_bgb_perkaholic
// Params 0, eflags: 0x2
// namespace_1b7b1237<file_0>::function_2dc19561
// Checksum 0xe6504199, Offset: 0x140
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("zm_bgb_perkaholic", &__init__, undefined, undefined);
}

// Namespace zm_bgb_perkaholic
// Params 0, eflags: 0x1 linked
// namespace_1b7b1237<file_0>::function_8c87d8eb
// Checksum 0x30be19cd, Offset: 0x180
// Size: 0x3c
function __init__() {
    if (!(isdefined(level.bgb_in_use) && level.bgb_in_use)) {
        return;
    }
    bgb::register("zm_bgb_perkaholic", "event");
}

