#using scripts/codescripts/struct;
#using scripts/shared/flag_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/shared/visionset_mgr_shared;
#using scripts/zm/_zm_bgb;
#using scripts/zm/_zm_utility;

#namespace zm_bgb_idle_eyes;

// Namespace zm_bgb_idle_eyes
// Params 0, eflags: 0x2
// Checksum 0xe49a8223, Offset: 0x190
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("zm_bgb_idle_eyes", &__init__, undefined, undefined);
}

// Namespace zm_bgb_idle_eyes
// Params 0, eflags: 0x0
// Checksum 0xe555f6de, Offset: 0x1d0
// Size: 0x8c
function __init__() {
    if (!(isdefined(level.bgb_in_use) && level.bgb_in_use)) {
        return;
    }
    bgb::register("zm_bgb_idle_eyes", "activated");
    visionset_mgr::register_visionset_info("zm_bgb_idle_eyes", 1, 31, undefined, "zombie_noire");
    visionset_mgr::register_overlay_info_style_postfx_bundle("zm_bgb_idle_eyes", 1, 1, "pstfx_zm_screen_warp");
}

