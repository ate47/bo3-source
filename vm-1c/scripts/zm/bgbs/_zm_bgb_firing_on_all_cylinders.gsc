#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_powerups;
#using scripts/zm/_zm_bgb;
#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/flag_shared;
#using scripts/codescripts/struct;

#namespace namespace_ef480314;

// Namespace namespace_ef480314
// Params 0, eflags: 0x2
// namespace_ef480314<file_0>::function_2dc19561
// Checksum 0xdb373b32, Offset: 0x190
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("zm_bgb_firing_on_all_cylinders", &__init__, undefined, "bgb");
}

// Namespace namespace_ef480314
// Params 0, eflags: 0x1 linked
// namespace_ef480314<file_0>::function_8c87d8eb
// Checksum 0xc1659a96, Offset: 0x1d0
// Size: 0x5c
function __init__() {
    if (!(isdefined(level.bgb_in_use) && level.bgb_in_use)) {
        return;
    }
    bgb::register("zm_bgb_firing_on_all_cylinders", "rounds", 3, &enable, &disable, undefined);
}

// Namespace namespace_ef480314
// Params 0, eflags: 0x1 linked
// namespace_ef480314<file_0>::function_bae40a28
// Checksum 0x88718f4c, Offset: 0x238
// Size: 0x24
function enable() {
    self setperk("specialty_sprintfire");
}

// Namespace namespace_ef480314
// Params 0, eflags: 0x1 linked
// namespace_ef480314<file_0>::function_54bdb053
// Checksum 0xdd5c5348, Offset: 0x268
// Size: 0x24
function disable() {
    self unsetperk("specialty_sprintfire");
}

