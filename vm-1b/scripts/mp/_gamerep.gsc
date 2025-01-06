#using scripts/shared/bots/_bot;
#using scripts/shared/rank_shared;

#namespace gamerep;

// Namespace gamerep
// Params 0, eflags: 0x0
// Checksum 0x88bef34f, Offset: 0x1e8
// Size: 0x2d
function init() {
    if (!isgamerepenabled()) {
        return;
    }
    if (isgamerepinitialized()) {
        return;
    }
    InvalidOpCode(0xc8, "gameRepInitialized", 1);
    // Unknown operator (0xc8, t7_1b, PC)
}

// Namespace gamerep
// Params 0, eflags: 0x0
// Checksum 0x78b04554, Offset: 0x288
// Size: 0x9
function isgamerepinitialized() {
    InvalidOpCode(0x54, "gameRepInitialized");
    // Unknown operator (0x54, t7_1b, PC)
}

// Namespace gamerep
// Params 0, eflags: 0x0
// Checksum 0x1be19164, Offset: 0x2b8
// Size: 0x25
function isgamerepenabled() {
    if (bot::is_bot_ranked_match()) {
        return false;
    }
    if (!level.rankedmatch) {
        return false;
    }
    return true;
}

// Namespace gamerep
// Params 0, eflags: 0x0
// Checksum 0x13ae62e0, Offset: 0x2e8
// Size: 0xd5
function gamerepinitializeparams() {
    threshold_exceeded_score = 0;
    threshold_exceeded_score_per_min = 1;
    threshold_exceeded_kills = 2;
    threshold_exceeded_deaths = 3;
    threshold_exceeded_kd_ratio = 4;
    threshold_exceeded_kills_per_min = 5;
    threshold_exceeded_plants = 6;
    threshold_exceeded_defuses = 7;
    threshold_exceeded_captures = 8;
    threshold_exceeded_defends = 9;
    threshold_exceeded_total_time_played = 10;
    threshold_exceeded_tactical_insertion_use = 11;
    threshold_exceeded_join_attempts = 12;
    threshold_exceeded_xp = 13;
    threshold_exceeded_splitscreen = 14;
    InvalidOpCode(0xc8, "gameRep", "params", []);
    // Unknown operator (0xc8, t7_1b, PC)
}

// Namespace gamerep
// Params 0, eflags: 0x0
// Checksum 0x5c072cef, Offset: 0xe30
// Size: 0x4d
function gamerepplayerconnected() {
    if (!isgamerepenabled()) {
        return;
    }
    name = self.name;
    /#
    #/
    InvalidOpCode(0x54, "gameRep", "players", name);
    // Unknown operator (0x54, t7_1b, PC)
}

// Namespace gamerep
// Params 0, eflags: 0x0
// Checksum 0x807addf2, Offset: 0x1058
// Size: 0x39
function gamerepplayerdisconnected() {
    if (!isgamerepenabled()) {
        return;
    }
    name = self.name;
    InvalidOpCode(0x54, "gameRep", "players", name);
    // Unknown operator (0x54, t7_1b, PC)
}

// Namespace gamerep
// Params 0, eflags: 0x0
// Checksum 0xa086cbde, Offset: 0x10f8
// Size: 0x25
function gamerepupdatenonpersistentplayerinformation() {
    name = self.name;
    InvalidOpCode(0x54, "gameRep", "players", name);
    // Unknown operator (0x54, t7_1b, PC)
}

// Namespace gamerep
// Params 0, eflags: 0x0
// Checksum 0x10754d39, Offset: 0x11c8
// Size: 0x2d
function gamerepupdatepersistentplayerinformation() {
    name = self.name;
    InvalidOpCode(0x54, "gameRep", "players", name);
    // Unknown operator (0x54, t7_1b, PC)
}

// Namespace gamerep
// Params 2, eflags: 0x0
// Checksum 0xcf3d9bfd, Offset: 0x1528
// Size: 0x25
function getparamvalueforplayer(playername, paramname) {
    InvalidOpCode(0x54, "gameRep", "players", playername, paramname);
    // Unknown operator (0x54, t7_1b, PC)
}

// Namespace gamerep
// Params 1, eflags: 0x0
// Checksum 0x5cfa317b, Offset: 0x15a0
// Size: 0x21
function isgamerepparamvalid(paramname) {
    gametype = level.gametype;
    InvalidOpCode(0x54, "gameRep");
    // Unknown operator (0x54, t7_1b, PC)
}

// Namespace gamerep
// Params 1, eflags: 0x0
// Checksum 0xb6b54763, Offset: 0x1670
// Size: 0x19
function isgamerepparamignoredforreporting(paramname) {
    InvalidOpCode(0x54, "gameRep", "ignoreParams", paramname);
    // Unknown operator (0x54, t7_1b, PC)
}

// Namespace gamerep
// Params 1, eflags: 0x0
// Checksum 0x7220574b, Offset: 0x16a0
// Size: 0x2d
function getgamerepparamlimit(paramname) {
    gametype = level.gametype;
    InvalidOpCode(0x54, "gameRep", "gameLimit", gametype);
    // Unknown operator (0x54, t7_1b, PC)
}

// Namespace gamerep
// Params 2, eflags: 0x0
// Checksum 0x20ee3cbd, Offset: 0x1780
// Size: 0x21
function setmaximumparamvalueforcurrentgame(paramname, value) {
    InvalidOpCode(0x54, "gameRep", "max", paramname);
    // Unknown operator (0x54, t7_1b, PC)
}

// Namespace gamerep
// Params 0, eflags: 0x0
// Checksum 0x7912fd0a, Offset: 0x1800
// Size: 0x69
function gamerepupdateinformationforround() {
    if (!isgamerepenabled()) {
        return;
    }
    players = getplayers();
    for (i = 0; i < players.size; i++) {
        player = players[i];
        player gamerepupdatenonpersistentplayerinformation();
    }
}

// Namespace gamerep
// Params 0, eflags: 0x0
// Checksum 0xf40c5c93, Offset: 0x1878
// Size: 0xa1
function gamerepanalyzeandreport() {
    if (!isgamerepenabled()) {
        return;
    }
    players = getplayers();
    for (i = 0; i < players.size; i++) {
        player = players[i];
        player gamerepupdatepersistentplayerinformation();
    }
    splitscreenplayercount = 0;
    i = 0;
    InvalidOpCode(0x54, "gameRep", "playerNames", i);
    // Unknown operator (0x54, t7_1b, PC)
}

// Namespace gamerep
// Params 1, eflags: 0x0
// Checksum 0xe32d35fa, Offset: 0x1ac8
// Size: 0x21
function gamerepprepareandreport(paramname) {
    InvalidOpCode(0x54, "gameRep", "gameLimit", "id", paramname);
    // Unknown operator (0x54, t7_1b, PC)
}

