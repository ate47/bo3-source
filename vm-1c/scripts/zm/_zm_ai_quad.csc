#using scripts/codescripts/struct;
#using scripts/shared/system_shared;
#using scripts/shared/visionset_mgr_shared;

#namespace zm_ai_quad;

// Namespace zm_ai_quad
// Params 0, eflags: 0x2
// Checksum 0x135fb843, Offset: 0xf0
// Size: 0x34
function autoexec __init__sytem__() {
    system::register("zm_ai_quad", &__init__, undefined, undefined);
}

// Namespace zm_ai_quad
// Params 0, eflags: 0x0
// Checksum 0xeacf9393, Offset: 0x130
// Size: 0x3c
function __init__() {
    visionset_mgr::register_overlay_info_style_blur("zm_ai_quad_blur", 21000, 1, 0.1, 0.5, 4);
}

