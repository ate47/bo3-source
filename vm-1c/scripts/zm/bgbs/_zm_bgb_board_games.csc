#using scripts/codescripts/struct;
#using scripts/shared/flag_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/zm/_zm_bgb;
#using scripts/zm/_zm_utility;

#namespace zm_bgb_board_games;

// Namespace zm_bgb_board_games
// Params 0, eflags: 0x2
// Checksum 0xc130741d, Offset: 0x148
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("zm_bgb_board_games", &__init__, undefined, undefined);
}

// Namespace zm_bgb_board_games
// Params 0, eflags: 0x0
// Checksum 0xebb6a642, Offset: 0x188
// Size: 0x3c
function __init__() {
    if (!(isdefined(level.bgb_in_use) && level.bgb_in_use)) {
        return;
    }
    bgb::register("zm_bgb_board_games", "rounds");
}

