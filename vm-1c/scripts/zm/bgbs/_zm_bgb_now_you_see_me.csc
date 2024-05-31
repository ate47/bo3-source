#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_bgb;
#using scripts/shared/visionset_mgr_shared;
#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/flag_shared;
#using scripts/codescripts/struct;

#namespace zm_bgb_now_you_see_me;

// Namespace zm_bgb_now_you_see_me
// Params 0, eflags: 0x2
// namespace_62ef2c38<file_0>::function_2dc19561
// Checksum 0xce329acc, Offset: 0x1a8
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("zm_bgb_now_you_see_me", &__init__, undefined, undefined);
}

// Namespace zm_bgb_now_you_see_me
// Params 0, eflags: 0x1 linked
// namespace_62ef2c38<file_0>::function_8c87d8eb
// Checksum 0x1607a289, Offset: 0x1e8
// Size: 0x8c
function __init__() {
    if (!(isdefined(level.bgb_in_use) && level.bgb_in_use)) {
        return;
    }
    bgb::register("zm_bgb_now_you_see_me", "activated");
    visionset_mgr::register_visionset_info("zm_bgb_now_you_see_me", 1, 31, undefined, "zm_bgb_in_plain_sight");
    visionset_mgr::register_overlay_info_style_postfx_bundle("zm_bgb_now_you_see_me", 1, 1, "pstfx_zm_bgb_now_you_see_me");
}

