#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_bgb;
#using scripts/shared/visionset_mgr_shared;
#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/flag_shared;
#using scripts/codescripts/struct;

#namespace zm_bgb_in_plain_sight;

// Namespace zm_bgb_in_plain_sight
// Params 0, eflags: 0x2
// Checksum 0x58a2df9b, Offset: 0x190
// Size: 0x34
function function_2dc19561() {
    system::register("zm_bgb_in_plain_sight", &__init__, undefined, undefined);
}

// Namespace zm_bgb_in_plain_sight
// Params 0, eflags: 0x1 linked
// Checksum 0x2f8da022, Offset: 0x1d0
// Size: 0x8c
function __init__() {
    if (!(isdefined(level.bgb_in_use) && level.bgb_in_use)) {
        return;
    }
    bgb::register("zm_bgb_in_plain_sight", "activated");
    visionset_mgr::register_visionset_info("zm_bgb_in_plain_sight", 1, 31, undefined, "zm_bgb_in_plain_sight");
    visionset_mgr::register_overlay_info_style_postfx_bundle("zm_bgb_in_plain_sight", 1, 1, "pstfx_zm_bgb_in_plain_sight");
}

