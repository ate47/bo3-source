#using scripts/zm/_zm_elemental_zombies;
#using scripts/shared/visionset_mgr_shared;
#using scripts/shared/system_shared;

#namespace namespace_ef567265;

// Namespace namespace_ef567265
// Params 0, eflags: 0x2
// Checksum 0x4d7f8d7a, Offset: 0xf8
// Size: 0x3c
function autoexec function_2dc19561() {
    system::register("zm_ai_mechz", &__init__, &__main__, undefined);
}

// Namespace namespace_ef567265
// Params 0, eflags: 0x2
// Checksum 0x99ec1590, Offset: 0x140
// Size: 0x4
function autoexec __init__() {
    
}

// Namespace namespace_ef567265
// Params 0, eflags: 0x0
// Checksum 0xf2af64d0, Offset: 0x150
// Size: 0x2c
function __main__() {
    visionset_mgr::register_overlay_info_style_burn("mechz_player_burn", 5000, 15, 1.5);
}

