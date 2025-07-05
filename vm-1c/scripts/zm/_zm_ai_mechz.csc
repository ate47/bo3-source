#using scripts/shared/system_shared;
#using scripts/shared/visionset_mgr_shared;
#using scripts/zm/_zm_elemental_zombies;

#namespace zm_ai_mechz;

// Namespace zm_ai_mechz
// Params 0, eflags: 0x2
// Checksum 0x4d7f8d7a, Offset: 0xf8
// Size: 0x3c
function autoexec __init__sytem__() {
    system::register("zm_ai_mechz", &__init__, &__main__, undefined);
}

// Namespace zm_ai_mechz
// Params 0, eflags: 0x2
// Checksum 0x99ec1590, Offset: 0x140
// Size: 0x4
function autoexec __init__() {
    
}

// Namespace zm_ai_mechz
// Params 0, eflags: 0x0
// Checksum 0xf2af64d0, Offset: 0x150
// Size: 0x2c
function __main__() {
    visionset_mgr::register_overlay_info_style_burn("mechz_player_burn", 5000, 15, 1.5);
}

