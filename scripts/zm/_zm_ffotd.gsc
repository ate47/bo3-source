#using scripts/shared/ai/zombie_utility;
#using scripts/zm/_zm_utility;
#using scripts/shared/callbacks_shared;
#using scripts/codescripts/struct;

#namespace zm_ffotd;

// Namespace zm_ffotd
// Params 0, eflags: 0x1 linked
// Checksum 0x99ec1590, Offset: 0x128
// Size: 0x4
function main_start() {
    
}

// Namespace zm_ffotd
// Params 0, eflags: 0x1 linked
// Checksum 0x7ccbc53e, Offset: 0x138
// Size: 0x64
function main_end() {
    difficulty = 1;
    column = int(difficulty) + 1;
    zombie_utility::set_zombie_var("zombie_move_speed_multiplier", 4, 0, column);
}

// Namespace zm_ffotd
// Params 0, eflags: 0x1 linked
// Checksum 0xcbcb8c24, Offset: 0x1a8
// Size: 0x50
function optimize_for_splitscreen() {
    if (!isdefined(level.var_7064bd2e)) {
        level.var_7064bd2e = 3;
    }
    if (level.var_7064bd2e) {
        if (getdvarint("splitscreen_playerCount") >= level.var_7064bd2e) {
            return true;
        }
    }
    return false;
}

