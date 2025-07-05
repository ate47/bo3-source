#using scripts/codescripts/struct;
#using scripts/shared/flag_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/zm/_zm_bgb;
#using scripts/zm/_zm_powerups;
#using scripts/zm/_zm_utility;

#namespace zm_bgb_whos_keeping_score;

// Namespace zm_bgb_whos_keeping_score
// Params 0, eflags: 0x2
// Checksum 0x4ed93b92, Offset: 0x188
// Size: 0x34
function autoexec __init__sytem__() {
    system::register("zm_bgb_whos_keeping_score", &__init__, undefined, "bgb");
}

// Namespace zm_bgb_whos_keeping_score
// Params 0, eflags: 0x0
// Checksum 0x85d0f2af, Offset: 0x1c8
// Size: 0x54
function __init__() {
    if (!(isdefined(level.bgb_in_use) && level.bgb_in_use)) {
        return;
    }
    bgb::register("zm_bgb_whos_keeping_score", "activated", 2, undefined, undefined, undefined, &activation);
}

// Namespace zm_bgb_whos_keeping_score
// Params 0, eflags: 0x0
// Checksum 0xb5abce3d, Offset: 0x228
// Size: 0x24
function activation() {
    self thread bgb::function_dea74fb0("double_points");
}

