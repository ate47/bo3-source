#using scripts/shared/visionset_mgr_shared;
#using scripts/shared/system_shared;
#using scripts/codescripts/struct;

#namespace namespace_1d58b607;

// Namespace namespace_1d58b607
// Params 0, eflags: 0x2
// Checksum 0xf29379b0, Offset: 0xf0
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("zm_ai_quad", &__init__, undefined, undefined);
}

// Namespace namespace_1d58b607
// Params 0, eflags: 0x1 linked
// Checksum 0x658ceb5b, Offset: 0x130
// Size: 0x3c
function __init__() {
    visionset_mgr::register_overlay_info_style_blur("zm_ai_quad_blur", 21000, 1, 0.1, 0.5, 4);
}

