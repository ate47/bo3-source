#using scripts/codescripts/struct;
#using scripts/shared/array_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/util_shared;
#using scripts/zm/_zm_game_module;
#using scripts/zm/_zm_magicbox;
#using scripts/zm/craftables/_zm_craftables;
#using scripts/zm/gametypes/_zm_gametype;
#using scripts/zm/zm_tomb_craftables;

#namespace zm_tomb_classic;

// Namespace zm_tomb_classic
// Params 0, eflags: 0x0
// Checksum 0x10894043, Offset: 0x1d8
// Size: 0x44
function precache() {
    zm_craftables::init();
    zm_tomb_craftables::function_cdc13aec();
    zm_tomb_craftables::function_3ebec56b();
    zm_tomb_craftables::function_95743e9f();
}

// Namespace zm_tomb_classic
// Params 0, eflags: 0x0
// Checksum 0x77a2fe34, Offset: 0x228
// Size: 0x54
function main() {
    zm_game_module::set_current_game_module(level.var_cffafacb);
    level thread zm_craftables::function_e6d6a7f();
    level flag::wait_till("initial_blackscreen_passed");
}

// Namespace zm_tomb_classic
// Params 0, eflags: 0x0
// Checksum 0x2b3a9a79, Offset: 0x288
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

