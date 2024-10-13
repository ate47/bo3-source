#using scripts/zm/gametypes/_zm_gametype;
#using scripts/zm/_zm_magicbox;
#using scripts/zm/_zm_game_module;
#using scripts/shared/ai/zombie_utility;
#using scripts/shared/util_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/array_shared;
#using scripts/codescripts/struct;

#namespace zm_tomb_standard;

// Namespace zm_tomb_standard
// Params 0, eflags: 0x0
// Checksum 0x99ec1590, Offset: 0x1b8
// Size: 0x4
function precache() {
    
}

// Namespace zm_tomb_standard
// Params 0, eflags: 0x0
// Checksum 0xc5f36992, Offset: 0x1c8
// Size: 0x54
function main() {
    level flag::wait_till("initial_blackscreen_passed");
    level flag::set("power_on");
    function_838ffcf9();
}

// Namespace zm_tomb_standard
// Params 0, eflags: 0x0
// Checksum 0x6b5ef0a4, Offset: 0x228
// Size: 0xc4
function function_838ffcf9() {
    chest1 = struct::get("start_chest", "script_noteworthy");
    level.chests = [];
    if (!isdefined(level.chests)) {
        level.chests = [];
    } else if (!isarray(level.chests)) {
        level.chests = array(level.chests);
    }
    level.chests[level.chests.size] = chest1;
    zm_magicbox::treasure_chest_init("start_chest");
}

