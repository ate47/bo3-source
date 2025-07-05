#using scripts/shared/ai_shared;
#using scripts/shared/system_shared;
#using scripts/shared/visionset_mgr_shared;

#namespace zm_ai_raz;

// Namespace zm_ai_raz
// Params 0, eflags: 0x2
// Checksum 0xe991112f, Offset: 0x120
// Size: 0x3c
function autoexec __init__sytem__() {
    system::register("zm_ai_raz", &__init__, &__main__, undefined);
}

// Namespace zm_ai_raz
// Params 0, eflags: 0x2
// Checksum 0xe7fe6fe9, Offset: 0x168
// Size: 0x44
function autoexec __init__() {
    level._effect["fx_raz_eye_glow"] = "dlc3/stalingrad/fx_raz_eye_glow";
    ai::add_archetype_spawn_function("raz", &function_f87a1709);
}

// Namespace zm_ai_raz
// Params 0, eflags: 0x0
// Checksum 0x99ec1590, Offset: 0x1b8
// Size: 0x4
function __main__() {
    
}

// Namespace zm_ai_raz
// Params 1, eflags: 0x0
// Checksum 0xbb8f5c6b, Offset: 0x1c8
// Size: 0x34
function function_f87a1709(localclientnum) {
    self._eyeglow_fx_override = level._effect["fx_raz_eye_glow"];
    self._eyeglow_tag_override = "tag_eye_glow";
}

