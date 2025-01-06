#using scripts/codescripts/struct;
#using scripts/shared/flag_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/zm/_zm_bgb;
#using scripts/zm/_zm_powerups;
#using scripts/zm/_zm_utility;

#namespace zm_bgb_always_done_swiftly;

// Namespace zm_bgb_always_done_swiftly
// Params 0, eflags: 0x2
// Checksum 0x1d5db552, Offset: 0x198
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("zm_bgb_always_done_swiftly", &__init__, undefined, "bgb");
}

// Namespace zm_bgb_always_done_swiftly
// Params 0, eflags: 0x0
// Checksum 0x79606d3, Offset: 0x1d8
// Size: 0x5c
function __init__() {
    if (!(isdefined(level.bgb_in_use) && level.bgb_in_use)) {
        return;
    }
    bgb::register("zm_bgb_always_done_swiftly", "rounds", 3, &enable, &disable, undefined);
}

// Namespace zm_bgb_always_done_swiftly
// Params 0, eflags: 0x0
// Checksum 0x83975a95, Offset: 0x240
// Size: 0x44
function enable() {
    self setperk("specialty_fastads");
    self setperk("specialty_stalker");
}

// Namespace zm_bgb_always_done_swiftly
// Params 0, eflags: 0x0
// Checksum 0x41f6037e, Offset: 0x290
// Size: 0x44
function disable() {
    self unsetperk("specialty_fastads");
    self unsetperk("specialty_stalker");
}

