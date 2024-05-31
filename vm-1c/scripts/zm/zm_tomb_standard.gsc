#using scripts/zm/gametypes/_zm_gametype;
#using scripts/zm/_zm_magicbox;
#using scripts/zm/_zm_game_module;
#using scripts/shared/ai/zombie_utility;
#using scripts/shared/util_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/array_shared;
#using scripts/codescripts/struct;

#namespace namespace_a026fc99;

// Namespace namespace_a026fc99
// Params 0, eflags: 0x0
// namespace_a026fc99<file_0>::function_f7046c76
// Checksum 0x99ec1590, Offset: 0x1b8
// Size: 0x4
function precache() {
    
}

// Namespace namespace_a026fc99
// Params 0, eflags: 0x0
// namespace_a026fc99<file_0>::function_d290ebfa
// Checksum 0xc5f36992, Offset: 0x1c8
// Size: 0x54
function main() {
    level flag::wait_till("initial_blackscreen_passed");
    level flag::set("power_on");
    function_838ffcf9();
}

// Namespace namespace_a026fc99
// Params 0, eflags: 0x0
// namespace_a026fc99<file_0>::function_838ffcf9
// Checksum 0x6b5ef0a4, Offset: 0x228
// Size: 0xc4
function function_838ffcf9() {
    var_80c73095 = struct::get("start_chest", "script_noteworthy");
    level.chests = [];
    if (!isdefined(level.chests)) {
        level.chests = [];
    } else if (!isarray(level.chests)) {
        level.chests = array(level.chests);
    }
    level.chests[level.chests.size] = var_80c73095;
    zm_magicbox::treasure_chest_init("start_chest");
}

