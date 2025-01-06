#using scripts/shared/rank_shared;

#namespace gamerep;

// Namespace gamerep
// Params 0, eflags: 0x0
// Checksum 0x4b2b4d9b, Offset: 0x1d0
// Size: 0xb4
function init() {
    if (!isgamerepenabled()) {
        return;
    }
    if (isgamerepinitialized()) {
        return;
    }
    game["gameRepInitialized"] = 1;
    game["gameRep"]["players"] = [];
    game["gameRep"]["playerNames"] = [];
    game["gameRep"]["max"] = [];
    game["gameRep"]["playerCount"] = 0;
    gamerepinitializeparams();
}

// Namespace gamerep
// Params 0, eflags: 0x0
// Checksum 0x4b1a9b20, Offset: 0x290
// Size: 0x30
function isgamerepinitialized() {
    if (!isdefined(game["gameRepInitialized"]) || !game["gameRepInitialized"]) {
        return false;
    }
    return true;
}

// Namespace gamerep
// Params 0, eflags: 0x0
// Checksum 0xa2229568, Offset: 0x2c8
// Size: 0x2e
function isgamerepenabled() {
    if (sessionmodeiszombiesgame()) {
        return false;
    }
    if (!level.rankedmatch) {
        return false;
    }
    return true;
}

// Namespace gamerep
// Params 0, eflags: 0x0
// Checksum 0x69d31229, Offset: 0x300
// Size: 0xdda
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
    game["gameRep"]["params"] = [];
    game["gameRep"]["params"][0] = "score";
    game["gameRep"]["params"][1] = "scorePerMin";
    game["gameRep"]["params"][2] = "kills";
    game["gameRep"]["params"][3] = "deaths";
    game["gameRep"]["params"][4] = "killDeathRatio";
    game["gameRep"]["params"][5] = "killsPerMin";
    game["gameRep"]["params"][6] = "plants";
    game["gameRep"]["params"][7] = "defuses";
    game["gameRep"]["params"][8] = "captures";
    game["gameRep"]["params"][9] = "defends";
    game["gameRep"]["params"][10] = "totalTimePlayed";
    game["gameRep"]["params"][11] = "tacticalInsertions";
    game["gameRep"]["params"][12] = "joinAttempts";
    game["gameRep"]["params"][13] = "xp";
    game["gameRep"]["ignoreParams"] = [];
    game["gameRep"]["ignoreParams"][0] = "totalTimePlayed";
    game["gameRep"]["gameLimit"] = [];
    game["gameRep"]["gameLimit"]["default"] = [];
    game["gameRep"]["gameLimit"]["tdm"] = [];
    game["gameRep"]["gameLimit"]["dm"] = [];
    game["gameRep"]["gameLimit"]["dom"] = [];
    game["gameRep"]["gameLimit"]["hq"] = [];
    game["gameRep"]["gameLimit"]["sd"] = [];
    game["gameRep"]["gameLimit"]["dem"] = [];
    game["gameRep"]["gameLimit"]["ctf"] = [];
    game["gameRep"]["gameLimit"]["koth"] = [];
    game["gameRep"]["gameLimit"]["conf"] = [];
    game["gameRep"]["gameLimit"]["id"]["score"] = threshold_exceeded_score;
    game["gameRep"]["gameLimit"]["default"]["score"] = 20000;
    game["gameRep"]["gameLimit"]["id"]["scorePerMin"] = threshold_exceeded_score_per_min;
    game["gameRep"]["gameLimit"]["default"]["scorePerMin"] = -6;
    game["gameRep"]["gameLimit"]["dem"]["scorePerMin"] = 1000;
    game["gameRep"]["gameLimit"]["tdm"]["scorePerMin"] = 700;
    game["gameRep"]["gameLimit"]["dm"]["scorePerMin"] = 950;
    game["gameRep"]["gameLimit"]["dom"]["scorePerMin"] = 1000;
    game["gameRep"]["gameLimit"]["sd"]["scorePerMin"] = -56;
    game["gameRep"]["gameLimit"]["ctf"]["scorePerMin"] = 600;
    game["gameRep"]["gameLimit"]["hq"]["scorePerMin"] = 1000;
    game["gameRep"]["gameLimit"]["koth"]["scorePerMin"] = 1000;
    game["gameRep"]["gameLimit"]["conf"]["scorePerMin"] = 1000;
    game["gameRep"]["gameLimit"]["id"]["kills"] = threshold_exceeded_kills;
    game["gameRep"]["gameLimit"]["default"]["kills"] = 75;
    game["gameRep"]["gameLimit"]["tdm"]["kills"] = 40;
    game["gameRep"]["gameLimit"]["sd"]["kills"] = 15;
    game["gameRep"]["gameLimit"]["dm"]["kills"] = 31;
    game["gameRep"]["gameLimit"]["id"]["deaths"] = threshold_exceeded_deaths;
    game["gameRep"]["gameLimit"]["default"]["deaths"] = 50;
    game["gameRep"]["gameLimit"]["dm"]["deaths"] = 15;
    game["gameRep"]["gameLimit"]["tdm"]["deaths"] = 40;
    game["gameRep"]["gameLimit"]["id"]["killDeathRatio"] = threshold_exceeded_kd_ratio;
    game["gameRep"]["gameLimit"]["default"]["killDeathRatio"] = 30;
    game["gameRep"]["gameLimit"]["tdm"]["killDeathRatio"] = 50;
    game["gameRep"]["gameLimit"]["sd"]["killDeathRatio"] = 20;
    game["gameRep"]["gameLimit"]["id"]["killsPerMin"] = threshold_exceeded_kills_per_min;
    game["gameRep"]["gameLimit"]["default"]["killsPerMin"] = 15;
    game["gameRep"]["gameLimit"]["id"]["plants"] = threshold_exceeded_plants;
    game["gameRep"]["gameLimit"]["default"]["plants"] = 10;
    game["gameRep"]["gameLimit"]["id"]["defuses"] = threshold_exceeded_defuses;
    game["gameRep"]["gameLimit"]["default"]["defuses"] = 10;
    game["gameRep"]["gameLimit"]["id"]["captures"] = threshold_exceeded_captures;
    game["gameRep"]["gameLimit"]["default"]["captures"] = 30;
    game["gameRep"]["gameLimit"]["id"]["defends"] = threshold_exceeded_defends;
    game["gameRep"]["gameLimit"]["default"]["defends"] = 50;
    game["gameRep"]["gameLimit"]["id"]["totalTimePlayed"] = threshold_exceeded_total_time_played;
    game["gameRep"]["gameLimit"]["default"]["totalTimePlayed"] = 600;
    game["gameRep"]["gameLimit"]["dom"]["totalTimePlayed"] = 600;
    game["gameRep"]["gameLimit"]["dem"]["totalTimePlayed"] = 1140;
    game["gameRep"]["gameLimit"]["id"]["tacticalInsertions"] = threshold_exceeded_tactical_insertion_use;
    game["gameRep"]["gameLimit"]["default"]["tacticalInsertions"] = 20;
    game["gameRep"]["gameLimit"]["id"]["joinAttempts"] = threshold_exceeded_join_attempts;
    game["gameRep"]["gameLimit"]["default"]["joinAttempts"] = 3;
    game["gameRep"]["gameLimit"]["id"]["xp"] = threshold_exceeded_xp;
    game["gameRep"]["gameLimit"]["default"]["xp"] = 25000;
    game["gameRep"]["gameLimit"]["id"]["splitscreen"] = threshold_exceeded_splitscreen;
    game["gameRep"]["gameLimit"]["default"]["splitscreen"] = 8;
}

// Namespace gamerep
// Params 0, eflags: 0x0
// Checksum 0x1a2329db, Offset: 0x10e8
// Size: 0x2c2
function gamerepplayerconnected() {
    if (!isgamerepenabled()) {
        return;
    }
    name = self.name;
    /#
    #/
    if (!isdefined(game["gameRep"]["players"][name])) {
        game["gameRep"]["players"][name] = [];
        for (j = 0; j < game["gameRep"]["params"].size; j++) {
            paramname = game["gameRep"]["params"][j];
            game["gameRep"]["players"][name][paramname] = 0;
        }
        game["gameRep"]["players"][name]["splitscreen"] = self issplitscreen();
        game["gameRep"]["players"][name]["joinAttempts"] = 1;
        game["gameRep"]["players"][name]["connected"] = 1;
        game["gameRep"]["players"][name]["xpStart"] = self rank::getrankxpstat();
        game["gameRep"]["playerNames"][game["gameRep"]["playerCount"]] = name;
        game["gameRep"]["playerCount"]++;
        return;
    }
    if (!game["gameRep"]["players"][name]["connected"]) {
        game["gameRep"]["players"][name]["joinAttempts"]++;
        game["gameRep"]["players"][name]["connected"] = 1;
        game["gameRep"]["players"][name]["xpStart"] = self rank::getrankxpstat();
    }
}

// Namespace gamerep
// Params 0, eflags: 0x0
// Checksum 0x70a715f8, Offset: 0x13b8
// Size: 0xc6
function gamerepplayerdisconnected() {
    if (!isgamerepenabled()) {
        return;
    }
    name = self.name;
    if (!isdefined(game["gameRep"]["players"][name]) || !isdefined(self.pers["summary"])) {
        return;
    }
    /#
    #/
    self gamerepupdatenonpersistentplayerinformation();
    self gamerepupdatepersistentplayerinformation();
    game["gameRep"]["players"][name]["connected"] = 0;
}

// Namespace gamerep
// Params 0, eflags: 0x0
// Checksum 0xdd5f139c, Offset: 0x1488
// Size: 0xfa
function gamerepupdatenonpersistentplayerinformation() {
    name = self.name;
    if (!isdefined(game["gameRep"]["players"][name])) {
        return;
    }
    game["gameRep"]["players"][name]["totalTimePlayed"] = game["gameRep"]["players"][name]["totalTimePlayed"] + self.timeplayed["total"];
    if (isdefined(self.tacticalinsertioncount)) {
        game["gameRep"]["players"][name]["tacticalInsertions"] = game["gameRep"]["players"][name]["tacticalInsertions"] + self.tacticalinsertioncount;
    }
}

// Namespace gamerep
// Params 0, eflags: 0x0
// Checksum 0xda523747, Offset: 0x1590
// Size: 0x472
function gamerepupdatepersistentplayerinformation() {
    name = self.name;
    if (!isdefined(game["gameRep"]["players"][name])) {
        return;
    }
    if (game["gameRep"]["players"][name]["totalTimePlayed"] != 0) {
        timeplayed = game["gameRep"]["players"][name]["totalTimePlayed"];
    } else {
        timeplayed = 1;
    }
    game["gameRep"]["players"][name]["score"] = self.score;
    game["gameRep"]["players"][name]["scorePerMin"] = int(game["gameRep"]["players"][name]["score"] / timeplayed / 60);
    game["gameRep"]["players"][name]["kills"] = self.kills;
    game["gameRep"]["players"][name]["deaths"] = self.deaths;
    if (game["gameRep"]["players"][name]["deaths"] != 0) {
        game["gameRep"]["players"][name]["killDeathRatio"] = int(game["gameRep"]["players"][name]["kills"] / game["gameRep"]["players"][name]["deaths"] * 100);
    } else {
        game["gameRep"]["players"][name]["killDeathRatio"] = game["gameRep"]["players"][name]["kills"] * 100;
    }
    game["gameRep"]["players"][name]["killsPerMin"] = int(game["gameRep"]["players"][name]["kills"] / timeplayed / 60);
    game["gameRep"]["players"][name]["plants"] = self.plants;
    game["gameRep"]["players"][name]["defuses"] = self.defuses;
    game["gameRep"]["players"][name]["captures"] = self.captures;
    game["gameRep"]["players"][name]["defends"] = self.defends;
    game["gameRep"]["players"][name]["xp"] = self rank::getrankxpstat() - game["gameRep"]["players"][name]["xpStart"];
    game["gameRep"]["players"][name]["xpStart"] = self rank::getrankxpstat();
}

// Namespace gamerep
// Params 2, eflags: 0x0
// Checksum 0x764f7141, Offset: 0x1a10
// Size: 0x8c
function getparamvalueforplayer(playername, paramname) {
    if (isdefined(game["gameRep"]["players"][playername][paramname])) {
        return game["gameRep"]["players"][playername][paramname];
    }
    assertmsg("<dev string:x28>" + paramname + "<dev string:x3b>");
}

// Namespace gamerep
// Params 1, eflags: 0x0
// Checksum 0x44c6b45d, Offset: 0x1aa8
// Size: 0x100
function isgamerepparamvalid(paramname) {
    gametype = level.gametype;
    if (!isdefined(game["gameRep"])) {
        return false;
    }
    if (!isdefined(game["gameRep"]["gameLimit"])) {
        return false;
    }
    if (!isdefined(game["gameRep"]["gameLimit"][gametype])) {
        return false;
    }
    if (!isdefined(game["gameRep"]["gameLimit"][gametype][paramname])) {
        return false;
    }
    if (!isdefined(game["gameRep"]["gameLimit"][gametype][paramname]) && !isdefined(game["gameRep"]["gameLimit"]["default"][paramname])) {
        return false;
    }
    return true;
}

// Namespace gamerep
// Params 1, eflags: 0x0
// Checksum 0x63a8764, Offset: 0x1bb0
// Size: 0x34
function isgamerepparamignoredforreporting(paramname) {
    if (isdefined(game["gameRep"]["ignoreParams"][paramname])) {
        return true;
    }
    return false;
}

// Namespace gamerep
// Params 1, eflags: 0x0
// Checksum 0x20dc4892, Offset: 0x1bf0
// Size: 0x10c
function getgamerepparamlimit(paramname) {
    gametype = level.gametype;
    if (isdefined(game["gameRep"]["gameLimit"][gametype])) {
        if (isdefined(game["gameRep"]["gameLimit"][gametype][paramname])) {
            return game["gameRep"]["gameLimit"][gametype][paramname];
        }
    }
    if (isdefined(game["gameRep"]["gameLimit"]["default"][paramname])) {
        return game["gameRep"]["gameLimit"]["default"][paramname];
    }
    assertmsg("<dev string:x51>" + paramname + "<dev string:x6f>");
}

// Namespace gamerep
// Params 2, eflags: 0x0
// Checksum 0xb8b2d30f, Offset: 0x1d08
// Size: 0x9c
function setmaximumparamvalueforcurrentgame(paramname, value) {
    if (!isdefined(game["gameRep"]["max"][paramname])) {
        game["gameRep"]["max"][paramname] = value;
        return;
    }
    if (game["gameRep"]["max"][paramname] < value) {
        game["gameRep"]["max"][paramname] = value;
    }
}

// Namespace gamerep
// Params 0, eflags: 0x0
// Checksum 0x4d039cd7, Offset: 0x1db0
// Size: 0x8e
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
// Checksum 0xd9f5af7a, Offset: 0x1e48
// Size: 0x2fc
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
    for (i = 0; i < game["gameRep"]["playerNames"].size; i++) {
        playername = game["gameRep"]["playerNames"][i];
        for (j = 0; j < game["gameRep"]["params"].size; j++) {
            paramname = game["gameRep"]["params"][j];
            if (isgamerepparamvalid(paramname)) {
                setmaximumparamvalueforcurrentgame(paramname, getparamvalueforplayer(playername, paramname));
            }
        }
        paramname = "splitscreen";
        splitscreenplayercount += getparamvalueforplayer(playername, paramname);
    }
    setmaximumparamvalueforcurrentgame(paramname, splitscreenplayercount);
    for (j = 0; j < game["gameRep"]["params"].size; j++) {
        paramname = game["gameRep"]["params"][j];
        if (isgamerepparamvalid(paramname) && game["gameRep"]["max"][paramname] >= getgamerepparamlimit(paramname)) {
            gamerepprepareandreport(paramname);
        }
    }
    paramname = "splitscreen";
    if (game["gameRep"]["max"][paramname] >= getgamerepparamlimit(paramname)) {
        gamerepprepareandreport(paramname);
    }
}

// Namespace gamerep
// Params 1, eflags: 0x0
// Checksum 0xbd950ac7, Offset: 0x2150
// Size: 0x8c
function gamerepprepareandreport(paramname) {
    if (!isdefined(game["gameRep"]["gameLimit"]["id"][paramname])) {
        return;
    }
    if (isgamerepparamignoredforreporting(paramname)) {
        return;
    }
    gamerepthresholdexceeded(game["gameRep"]["gameLimit"]["id"][paramname]);
}

