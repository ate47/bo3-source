#using scripts/codescripts/struct;
#using scripts/mp/teams/_teams;
#using scripts/shared/callbacks_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;

#namespace arena;

// Namespace arena
// Params 0, eflags: 0x2
// Checksum 0xe228c807, Offset: 0x120
// Size: 0x2a
function autoexec function_2dc19561() {
    system::register("arena", &__init__, undefined, undefined);
}

// Namespace arena
// Params 0, eflags: 0x0
// Checksum 0x3727914, Offset: 0x158
// Size: 0x22
function __init__() {
    callback::on_connect(&on_connect);
}

// Namespace arena
// Params 0, eflags: 0x0
// Checksum 0xcfd9ae8e, Offset: 0x188
// Size: 0x53
function on_connect() {
    if (isdefined(self.pers["arenaInit"]) && self.pers["arenaInit"] == 1) {
        return;
    }
    self arenabeginmatch();
    self.pers["arenaInit"] = 1;
}

// Namespace arena
// Params 1, eflags: 0x0
// Checksum 0xfa17f1be, Offset: 0x1e8
// Size: 0xd1
function match_end(winner) {
    for (index = 0; index < level.players.size; index++) {
        player = level.players[index];
        if (isdefined(player.pers["arenaInit"]) && player.pers["arenaInit"] == 1) {
            if (winner == "tie") {
                player arenaendmatch(0);
                continue;
            }
            if (winner == player.pers["team"]) {
                player arenaendmatch(1);
                continue;
            }
            player arenaendmatch(-1);
        }
    }
}

