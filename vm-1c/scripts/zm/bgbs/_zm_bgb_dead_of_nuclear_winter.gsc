#using scripts/codescripts/struct;
#using scripts/shared/flag_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/zm/_zm_bgb;
#using scripts/zm/_zm_utility;

#namespace zm_bgb_dead_of_nuclear_winter;

// Namespace zm_bgb_dead_of_nuclear_winter
// Params 0, eflags: 0x2
// Checksum 0x35513d12, Offset: 0x168
// Size: 0x34
function autoexec __init__sytem__() {
    system::register("zm_bgb_dead_of_nuclear_winter", &__init__, undefined, "bgb");
}

// Namespace zm_bgb_dead_of_nuclear_winter
// Params 0, eflags: 0x0
// Checksum 0xd5858dd5, Offset: 0x1a8
// Size: 0x54
function __init__() {
    if (!(isdefined(level.bgb_in_use) && level.bgb_in_use)) {
        return;
    }
    bgb::register("zm_bgb_dead_of_nuclear_winter", "activated", 2, undefined, undefined, undefined, &activation);
}

// Namespace zm_bgb_dead_of_nuclear_winter
// Params 0, eflags: 0x0
// Checksum 0x40b5c35e, Offset: 0x208
// Size: 0x24
function activation() {
    self thread bgb::function_dea74fb0("nuke");
}

