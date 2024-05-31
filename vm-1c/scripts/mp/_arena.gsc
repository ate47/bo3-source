#using scripts/mp/teams/_teams;
#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/callbacks_shared;
#using scripts/codescripts/struct;

#namespace arena;

// Namespace arena
// Params 0, eflags: 0x2
// namespace_42b73a8a<file_0>::function_2dc19561
// Checksum 0x53c11b50, Offset: 0x1a8
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("arena", &__init__, undefined, undefined);
}

// Namespace arena
// Params 0, eflags: 0x1 linked
// namespace_42b73a8a<file_0>::function_8c87d8eb
// Checksum 0x50926aa4, Offset: 0x1e8
// Size: 0x24
function __init__() {
    callback::on_connect(&on_connect);
}

// Namespace arena
// Params 0, eflags: 0x1 linked
// namespace_42b73a8a<file_0>::function_eb99da89
// Checksum 0xbe742470, Offset: 0x218
// Size: 0xca
function on_connect() {
    if (isdefined(self.pers["arenaInit"]) && self.pers["arenaInit"] == 1) {
        return;
    }
    draftenabled = getgametypesetting("pregameDraftEnabled") == 1;
    voteenabled = getgametypesetting("pregameItemVoteEnabled") == 1;
    if (!draftenabled && !voteenabled) {
        self arenabeginmatch();
    }
    self.pers["arenaInit"] = 1;
}

// Namespace arena
// Params 0, eflags: 0x1 linked
// namespace_42b73a8a<file_0>::function_b7b326db
// Checksum 0x33afbee2, Offset: 0x2f0
// Size: 0x172
function update_arena_challenge_seasons() {
    perseasonwins = self getdstat("arenaPerSeasonStats", "wins");
    if (perseasonwins >= getdvarint("arena_seasonVetChallengeWins")) {
        arenaslot = arenagetslot();
        currentseason = self getdstat("arenaStats", arenaslot, "season");
        seasonvetchallengearraycount = self getdstatarraycount("arenaChallengeSeasons");
        for (i = 0; i < seasonvetchallengearraycount; i++) {
            challengeseason = self getdstat("arenaChallengeSeasons", i);
            if (challengeseason == currentseason) {
                return;
            }
            if (challengeseason == 0) {
                self setdstat("arenaChallengeSeasons", i, currentseason);
                break;
            }
        }
    }
}

// Namespace arena
// Params 1, eflags: 0x1 linked
// namespace_42b73a8a<file_0>::function_78fde7be
// Checksum 0x90b2b63a, Offset: 0x470
// Size: 0x136
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
                player update_arena_challenge_seasons();
                continue;
            }
            player arenaendmatch(-1);
        }
    }
}

