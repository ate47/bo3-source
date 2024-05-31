#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_powerups;
#using scripts/zm/_zm_bgb;
#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/flag_shared;
#using scripts/codescripts/struct;

#namespace zm_bgb_whos_keeping_score;

// Namespace zm_bgb_whos_keeping_score
// Params 0, eflags: 0x2
// namespace_3f74549<file_0>::function_2dc19561
// Checksum 0x4ed93b92, Offset: 0x188
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("zm_bgb_whos_keeping_score", &__init__, undefined, "bgb");
}

// Namespace zm_bgb_whos_keeping_score
// Params 0, eflags: 0x1 linked
// namespace_3f74549<file_0>::function_8c87d8eb
// Checksum 0x85d0f2af, Offset: 0x1c8
// Size: 0x54
function __init__() {
    if (!(isdefined(level.bgb_in_use) && level.bgb_in_use)) {
        return;
    }
    bgb::register("zm_bgb_whos_keeping_score", "activated", 2, undefined, undefined, undefined, &activation);
}

// Namespace zm_bgb_whos_keeping_score
// Params 0, eflags: 0x1 linked
// namespace_3f74549<file_0>::function_7afbf7cd
// Checksum 0xb5abce3d, Offset: 0x228
// Size: 0x24
function activation() {
    self thread bgb::function_dea74fb0("double_points");
}

