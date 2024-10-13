#using scripts/zm/_util;
#using scripts/zm/_challenges;
#using scripts/zm/_bb;
#using scripts/zm/gametypes/_globallogic_utils;
#using scripts/zm/gametypes/_globallogic_audio;
#using scripts/zm/gametypes/_globallogic;
#using scripts/shared/util_shared;
#using scripts/shared/rank_shared;
#using scripts/shared/math_shared;
#using scripts/shared/challenges_shared;
#using scripts/shared/bb_shared;
#using scripts/codescripts/struct;

#namespace globallogic_score;

// Namespace globallogic_score
// Params 0, eflags: 0x1 linked
// Checksum 0x2a16ed6e, Offset: 0x4d8
// Size: 0x13a
function gethighestscoringplayer() {
    players = level.players;
    winner = undefined;
    tie = 0;
    for (i = 0; i < players.size; i++) {
        if (!isdefined(players[i].score)) {
            continue;
        }
        if (players[i].score < 1) {
            continue;
        }
        if (!isdefined(winner) || players[i].score > winner.score) {
            winner = players[i];
            tie = 0;
            continue;
        }
        if (players[i].score == winner.score) {
            tie = 1;
        }
    }
    if (tie || !isdefined(winner)) {
        return undefined;
    }
    return winner;
}

// Namespace globallogic_score
// Params 0, eflags: 0x1 linked
// Checksum 0xe0c8fdb6, Offset: 0x620
// Size: 0x28
function resetscorechain() {
    self notify(#"reset_score_chain");
    self.scorechain = 0;
    self.rankupdatetotal = 0;
}

// Namespace globallogic_score
// Params 0, eflags: 0x1 linked
// Checksum 0x7544113c, Offset: 0x650
// Size: 0x5c
function scorechaintimer() {
    self notify(#"score_chain_timer");
    self endon(#"reset_score_chain");
    self endon(#"score_chain_timer");
    self endon(#"death");
    self endon(#"disconnect");
    wait 20;
    self thread resetscorechain();
}

// Namespace globallogic_score
// Params 1, eflags: 0x1 linked
// Checksum 0xc76b841d, Offset: 0x6b8
// Size: 0x54
function roundtonearestfive(score) {
    rounding = score % 5;
    if (rounding <= 2) {
        return (score - rounding);
    }
    return score + 5 - rounding;
}

// Namespace globallogic_score
// Params 4, eflags: 0x1 linked
// Checksum 0xabbe78f2, Offset: 0x718
// Size: 0x1e4
function giveplayermomentumnotification(score, label, descvalue, countstowardrampage) {
    rampagebonus = 0;
    if (isdefined(level.usingrampage) && level.usingrampage) {
        if (countstowardrampage) {
            if (!isdefined(self.scorechain)) {
                self.scorechain = 0;
            }
            self.scorechain++;
            self thread scorechaintimer();
        }
        if (isdefined(self.scorechain) && self.scorechain >= 999) {
            rampagebonus = roundtonearestfive(int(score * level.rampagebonusscale + 0.5));
        }
    }
    combat_efficiency_factor = 0;
    if (score != 0) {
        self luinotifyevent(%score_event, 4, label, score, rampagebonus, combat_efficiency_factor);
    }
    score += rampagebonus;
    if (score > 0 && self hasperk("specialty_earnmoremomentum")) {
        score = roundtonearestfive(int(score * getdvarfloat("perk_killstreakMomentumMultiplier") + 0.5));
    }
    _setplayermomentum(self, self.pers["momentum"] + score);
}

// Namespace globallogic_score
// Params 0, eflags: 0x1 linked
// Checksum 0x37db69f0, Offset: 0x908
// Size: 0x4c
function resetplayermomentumondeath() {
    if (isdefined(level.usingscorestreaks) && level.usingscorestreaks) {
        _setplayermomentum(self, 0);
        self thread resetscorechain();
    }
}

// Namespace globallogic_score
// Params 4, eflags: 0x1 linked
// Checksum 0xc39953e6, Offset: 0x960
// Size: 0x170
function giveplayerxpdisplay(event, player, victim, descvalue) {
    score = rank::getscoreinfovalue(event);
    assert(isdefined(score));
    xp = rank::getscoreinfoxp(event);
    assert(isdefined(xp));
    label = rank::getscoreinfolabel(event);
    if (xp && !level.gameended && isdefined(label)) {
        xpscale = player getxpscale();
        if (1 != xpscale) {
            xp = int(xp * xpscale + 0.5);
        }
        player luinotifyevent(%score_event, 2, label, xp);
    }
    return score;
}

// Namespace globallogic_score
// Params 5, eflags: 0x1 linked
// Checksum 0x3b8e8f04, Offset: 0xad8
// Size: 0x4a
function giveplayerscore(event, player, victim, descvalue, weapon) {
    return giveplayerxpdisplay(event, player, victim, descvalue);
}

// Namespace globallogic_score
// Params 3, eflags: 0x1 linked
// Checksum 0xd575d29b, Offset: 0xb30
// Size: 0x1c
function default_onplayerscore(event, player, victim) {
    
}

// Namespace globallogic_score
// Params 2, eflags: 0x1 linked
// Checksum 0x62423f7c, Offset: 0xb58
// Size: 0x14
function _setplayerscore(player, score) {
    
}

// Namespace globallogic_score
// Params 1, eflags: 0x1 linked
// Checksum 0x3bb427ed, Offset: 0xb78
// Size: 0x20
function _getplayerscore(player) {
    return player.pers["score"];
}

// Namespace globallogic_score
// Params 2, eflags: 0x1 linked
// Checksum 0xb66f0b5f, Offset: 0xba0
// Size: 0x120
function _setplayermomentum(player, momentum) {
    momentum = math::clamp(momentum, 0, 2000);
    oldmomentum = player.pers["momentum"];
    if (momentum == oldmomentum) {
        return;
    }
    player bb::add_to_stat("momentum", momentum - oldmomentum);
    if (momentum > oldmomentum) {
        highestmomentumcost = 0;
        numkillstreaks = player.killstreak.size;
        killstreaktypearray = [];
    }
    player.pers["momentum"] = momentum;
    player.momentum = player.pers["momentum"];
}

// Namespace globallogic_score
// Params 4, eflags: 0x0
// Checksum 0x7ad64985, Offset: 0xcc8
// Size: 0x24
function _giveplayerkillstreakinternal(player, momentum, oldmomentum, killstreaktypearray) {
    
}

/#

    // Namespace globallogic_score
    // Params 0, eflags: 0x1 linked
    // Checksum 0x9af048a7, Offset: 0xcf8
    // Size: 0xf0
    function setplayermomentumdebug() {
        setdvar("<dev string:x28>", 0);
        while (true) {
            wait 1;
            momentumpercent = getdvarfloat("<dev string:x28>", 0);
            if (momentumpercent != 0) {
                player = util::gethostplayer();
                if (!isdefined(player)) {
                    return;
                }
                if (isdefined(player.killstreak)) {
                    _setplayermomentum(player, int(2000 * momentumpercent / 100));
                }
            }
        }
    }

#/

// Namespace globallogic_score
// Params 4, eflags: 0x1 linked
// Checksum 0x7295d380, Offset: 0xdf0
// Size: 0x124
function giveteamscore(event, team, player, victim) {
    if (level.overrideteamscore) {
        return;
    }
    pixbeginevent("level.onTeamScore");
    teamscore = game["teamScores"][team];
    [[ level.onteamscore ]](event, team);
    pixendevent();
    newscore = game["teamScores"][team];
    bbprint("mpteamscores", "gametime %d event %s team %d diff %d score %d", gettime(), event, team, newscore - teamscore, newscore);
    if (teamscore == newscore) {
        return;
    }
    updateteamscores(team);
    thread globallogic::checkscorelimit();
}

// Namespace globallogic_score
// Params 2, eflags: 0x0
// Checksum 0xe5b8f6fc, Offset: 0xf20
// Size: 0xa4
function giveteamscoreforobjective(team, score) {
    teamscore = game["teamScores"][team];
    onteamscore(score, team);
    newscore = game["teamScores"][team];
    if (teamscore == newscore) {
        return;
    }
    updateteamscores(team);
    thread globallogic::checkscorelimit();
}

// Namespace globallogic_score
// Params 2, eflags: 0x1 linked
// Checksum 0x2f0fff95, Offset: 0xfd0
// Size: 0x6c
function _setteamscore(team, teamscore) {
    if (teamscore == game["teamScores"][team]) {
        return;
    }
    game["teamScores"][team] = teamscore;
    updateteamscores(team);
    thread globallogic::checkscorelimit();
}

// Namespace globallogic_score
// Params 0, eflags: 0x1 linked
// Checksum 0x88d04600, Offset: 0x1048
// Size: 0xbc
function resetteamscores() {
    if (level.scoreroundwinbased || util::isfirstround()) {
        foreach (team in level.teams) {
            game["teamScores"][team] = 0;
        }
    }
    updateallteamscores();
}

// Namespace globallogic_score
// Params 0, eflags: 0x0
// Checksum 0x88e70510, Offset: 0x1110
// Size: 0x24
function resetallscores() {
    resetteamscores();
    resetplayerscores();
}

// Namespace globallogic_score
// Params 0, eflags: 0x1 linked
// Checksum 0x8acd1904, Offset: 0x1140
// Size: 0xa6
function resetplayerscores() {
    players = level.players;
    winner = undefined;
    tie = 0;
    for (i = 0; i < players.size; i++) {
        if (isdefined(players[i].pers["score"])) {
            _setplayerscore(players[i], 0);
        }
    }
}

// Namespace globallogic_score
// Params 1, eflags: 0x1 linked
// Checksum 0xb434dfb5, Offset: 0x11f0
// Size: 0x4c
function updateteamscores(team) {
    setteamscore(team, game["teamScores"][team]);
    level thread globallogic::checkteamscorelimitsoon(team);
}

// Namespace globallogic_score
// Params 0, eflags: 0x1 linked
// Checksum 0x2549ce5, Offset: 0x1248
// Size: 0x8a
function updateallteamscores() {
    foreach (team in level.teams) {
        updateteamscores(team);
    }
}

// Namespace globallogic_score
// Params 1, eflags: 0x1 linked
// Checksum 0xc28803f3, Offset: 0x12e0
// Size: 0x1c
function _getteamscore(team) {
    return game["teamScores"][team];
}

// Namespace globallogic_score
// Params 0, eflags: 0x1 linked
// Checksum 0x67c280d6, Offset: 0x1308
// Size: 0xf6
function gethighestteamscoreteam() {
    score = 0;
    winning_teams = [];
    foreach (team in level.teams) {
        team_score = game["teamScores"][team];
        if (team_score > score) {
            score = team_score;
            winning_teams = [];
        }
        if (team_score == score) {
            winning_teams[team] = team;
        }
    }
    return winning_teams;
}

// Namespace globallogic_score
// Params 2, eflags: 0x1 linked
// Checksum 0xa556dc6a, Offset: 0x1408
// Size: 0xb0
function areteamarraysequal(teamsa, teamsb) {
    if (teamsa.size != teamsb.size) {
        return false;
    }
    foreach (team in teamsa) {
        if (!isdefined(teamsb[team])) {
            return false;
        }
    }
    return true;
}

// Namespace globallogic_score
// Params 2, eflags: 0x1 linked
// Checksum 0xa76f163a, Offset: 0x14c0
// Size: 0x2c8
function onteamscore(score, team) {
    game["teamScores"][team] = game["teamScores"][team] + score;
    if (level.scorelimit && game["teamScores"][team] > level.scorelimit) {
        game["teamScores"][team] = level.scorelimit;
    }
    if (level.splitscreen) {
        return;
    }
    if (level.scorelimit == 1) {
        return;
    }
    iswinning = gethighestteamscoreteam();
    if (iswinning.size == 0) {
        return;
    }
    if (gettime() - level.laststatustime < 5000) {
        return;
    }
    if (areteamarraysequal(iswinning, level.waswinning)) {
        return;
    }
    level.laststatustime = gettime();
    if (iswinning.size == 1) {
        foreach (team in iswinning) {
            if (isdefined(level.waswinning[team])) {
                if (level.waswinning.size == 1) {
                    continue;
                }
            }
            globallogic_audio::leaderdialog("lead_taken", team, "status");
        }
    }
    if (level.waswinning.size == 1) {
        foreach (team in level.waswinning) {
            if (isdefined(iswinning[team])) {
                if (iswinning.size == 1) {
                    continue;
                }
                if (level.waswinning.size > 1) {
                    continue;
                }
            }
            globallogic_audio::leaderdialog("lead_lost", team, "status");
        }
    }
    level.waswinning = iswinning;
}

// Namespace globallogic_score
// Params 2, eflags: 0x1 linked
// Checksum 0x3ffb2fb1, Offset: 0x1790
// Size: 0x14
function default_onteamscore(event, team) {
    
}

// Namespace globallogic_score
// Params 3, eflags: 0x1 linked
// Checksum 0x73a11619, Offset: 0x17b0
// Size: 0xe2
function initpersstat(dataname, record_stats, init_to_stat_value) {
    if (!isdefined(self.pers[dataname])) {
        self.pers[dataname] = 0;
    }
    if (!isdefined(record_stats) || record_stats == 1) {
        recordplayerstats(self, dataname, int(self.pers[dataname]));
    }
    if (isdefined(init_to_stat_value) && init_to_stat_value == 1) {
        self.pers[dataname] = self getdstat("PlayerStatsList", dataname, "StatValue");
    }
}

// Namespace globallogic_score
// Params 1, eflags: 0x1 linked
// Checksum 0xde0fe12, Offset: 0x18a0
// Size: 0x18
function getpersstat(dataname) {
    return self.pers[dataname];
}

// Namespace globallogic_score
// Params 4, eflags: 0x1 linked
// Checksum 0x58f005dc, Offset: 0x18c0
// Size: 0xbc
function incpersstat(dataname, increment, record_stats, includegametype) {
    pixbeginevent("incPersStat");
    self.pers[dataname] = self.pers[dataname] + increment;
    self addplayerstat(dataname, increment);
    if (!isdefined(record_stats) || record_stats == 1) {
        self thread threadedrecordplayerstats(dataname);
    }
    pixendevent();
}

// Namespace globallogic_score
// Params 1, eflags: 0x1 linked
// Checksum 0xa6430cfa, Offset: 0x1988
// Size: 0x3c
function threadedrecordplayerstats(dataname) {
    self endon(#"disconnect");
    waittillframeend();
    recordplayerstats(self, dataname, self.pers[dataname]);
}

// Namespace globallogic_score
// Params 1, eflags: 0x1 linked
// Checksum 0xb1fe0a37, Offset: 0x19d0
// Size: 0x72
function inckillstreaktracker(weapon) {
    self endon(#"disconnect");
    waittillframeend();
    if (weapon.name == "artillery") {
        self.pers["artillery_kills"]++;
    }
    if (weapon.name == "dog_bite") {
        self.pers["dog_kills"]++;
    }
}

// Namespace globallogic_score
// Params 5, eflags: 0x1 linked
// Checksum 0xc8bc6cd1, Offset: 0x1a50
// Size: 0x344
function trackattackerkill(name, rank, xp, prestige, xuid) {
    self endon(#"disconnect");
    attacker = self;
    waittillframeend();
    pixbeginevent("trackAttackerKill");
    if (!isdefined(attacker.pers["killed_players"][name])) {
        attacker.pers["killed_players"][name] = 0;
    }
    if (!isdefined(attacker.killedplayerscurrent[name])) {
        attacker.killedplayerscurrent[name] = 0;
    }
    if (!isdefined(attacker.pers["nemesis_tracking"][name])) {
        attacker.pers["nemesis_tracking"][name] = 0;
    }
    attacker.pers["killed_players"][name]++;
    attacker.killedplayerscurrent[name]++;
    attacker.pers["nemesis_tracking"][name] = attacker.pers["nemesis_tracking"][name] + 1;
    if (attacker.pers["nemesis_name"] == name) {
        attacker challenges::killednemesis();
    }
    if (attacker.pers["nemesis_name"] == "" || attacker.pers["nemesis_tracking"][name] > attacker.pers["nemesis_tracking"][attacker.pers["nemesis_name"]]) {
        attacker.pers["nemesis_name"] = name;
        attacker.pers["nemesis_rank"] = rank;
        attacker.pers["nemesis_rankIcon"] = prestige;
        attacker.pers["nemesis_xp"] = xp;
        attacker.pers["nemesis_xuid"] = xuid;
    } else if (isdefined(attacker.pers["nemesis_name"]) && attacker.pers["nemesis_name"] == name) {
        attacker.pers["nemesis_rank"] = rank;
        attacker.pers["nemesis_xp"] = xp;
    }
    pixendevent();
}

// Namespace globallogic_score
// Params 5, eflags: 0x1 linked
// Checksum 0x7ff2117f, Offset: 0x1da0
// Size: 0x2dc
function trackattackeedeath(attackername, rank, xp, prestige, xuid) {
    self endon(#"disconnect");
    waittillframeend();
    pixbeginevent("trackAttackeeDeath");
    if (!isdefined(self.pers["killed_by"][attackername])) {
        self.pers["killed_by"][attackername] = 0;
    }
    self.pers["killed_by"][attackername]++;
    if (!isdefined(self.pers["nemesis_tracking"][attackername])) {
        self.pers["nemesis_tracking"][attackername] = 0;
    }
    self.pers["nemesis_tracking"][attackername] = self.pers["nemesis_tracking"][attackername] + 1.5;
    if (self.pers["nemesis_name"] == "" || self.pers["nemesis_tracking"][attackername] > self.pers["nemesis_tracking"][self.pers["nemesis_name"]]) {
        self.pers["nemesis_name"] = attackername;
        self.pers["nemesis_rank"] = rank;
        self.pers["nemesis_rankIcon"] = prestige;
        self.pers["nemesis_xp"] = xp;
        self.pers["nemesis_xuid"] = xuid;
    } else if (isdefined(self.pers["nemesis_name"]) && self.pers["nemesis_name"] == attackername) {
        self.pers["nemesis_rank"] = rank;
        self.pers["nemesis_xp"] = xp;
    }
    if (self.pers["nemesis_name"] == attackername && self.pers["nemesis_tracking"][attackername] >= 2) {
        self setclientuivisibilityflag("killcam_nemesis", 1);
    } else {
        self setclientuivisibilityflag("killcam_nemesis", 0);
    }
    pixendevent();
}

// Namespace globallogic_score
// Params 0, eflags: 0x1 linked
// Checksum 0xceb59323, Offset: 0x2088
// Size: 0x6
function default_iskillboosting() {
    return false;
}

// Namespace globallogic_score
// Params 3, eflags: 0x1 linked
// Checksum 0xc5cf0200, Offset: 0x2098
// Size: 0x194
function givekillstats(smeansofdeath, weapon, evictim) {
    self endon(#"disconnect");
    waittillframeend();
    if (level.rankedmatch && self [[ level.iskillboosting ]]()) {
        /#
            self iprintlnbold("<dev string:x3b>");
        #/
        return;
    }
    pixbeginevent("giveKillStats");
    self incpersstat("kills", 1, 1, 1);
    self.kills = self getpersstat("kills");
    self updatestatratio("kdratio", "kills", "deaths");
    attacker = self;
    if (smeansofdeath == "MOD_HEAD_SHOT") {
        attacker thread incpersstat("headshots", 1, 1, 0);
        attacker.headshots = attacker.pers["headshots"];
        evictim recordkillmodifier("headshot");
    }
    pixendevent();
}

// Namespace globallogic_score
// Params 1, eflags: 0x1 linked
// Checksum 0x2b68bcf3, Offset: 0x2238
// Size: 0x4c
function inctotalkills(team) {
    if (level.teambased && isdefined(level.teams[team])) {
        game["totalKillsTeam"][team]++;
    }
    game["totalKills"]++;
}

// Namespace globallogic_score
// Params 3, eflags: 0x0
// Checksum 0x964b3f67, Offset: 0x2290
// Size: 0x17c
function setinflictorstat(einflictor, eattacker, weapon) {
    if (!isdefined(eattacker)) {
        return;
    }
    if (!isdefined(einflictor)) {
        eattacker addweaponstat(weapon, "hits", 1);
        return;
    }
    if (!isdefined(einflictor.playeraffectedarray)) {
        einflictor.playeraffectedarray = [];
    }
    foundnewplayer = 1;
    for (i = 0; i < einflictor.playeraffectedarray.size; i++) {
        if (einflictor.playeraffectedarray[i] == self) {
            foundnewplayer = 0;
            break;
        }
    }
    if (foundnewplayer) {
        einflictor.playeraffectedarray[einflictor.playeraffectedarray.size] = self;
        if (weapon == "concussion_grenade" || weapon == "tabun_gas") {
            eattacker addweaponstat(weapon, "used", 1);
        }
        eattacker addweaponstat(weapon, "hits", 1);
    }
}

// Namespace globallogic_score
// Params 1, eflags: 0x0
// Checksum 0x9648cb23, Offset: 0x2418
// Size: 0xe4
function processshieldassist(killedplayer) {
    self endon(#"disconnect");
    killedplayer endon(#"disconnect");
    wait 0.05;
    util::waittillslowprocessallowed();
    if (!isdefined(level.teams[self.pers["team"]])) {
        return;
    }
    if (self.pers["team"] == killedplayer.pers["team"]) {
        return;
    }
    if (!level.teambased) {
        return;
    }
    self incpersstat("assists", 1, 1, 1);
    self.assists = self getpersstat("assists");
}

// Namespace globallogic_score
// Params 3, eflags: 0x0
// Checksum 0x8c62dcc3, Offset: 0x2508
// Size: 0x22c
function processassist(killedplayer, damagedone, weapon) {
    self endon(#"disconnect");
    killedplayer endon(#"disconnect");
    wait 0.05;
    util::waittillslowprocessallowed();
    if (!isdefined(level.teams[self.pers["team"]])) {
        return;
    }
    if (self.pers["team"] == killedplayer.pers["team"]) {
        return;
    }
    if (!level.teambased) {
        return;
    }
    assist_level = "assist";
    assist_level_value = int(ceil(damagedone / 25));
    if (assist_level_value < 1) {
        assist_level_value = 1;
    } else if (assist_level_value > 3) {
        assist_level_value = 3;
    }
    assist_level = assist_level + "_" + assist_level_value * 25;
    self incpersstat("assists", 1, 1, 1);
    self.assists = self getpersstat("assists");
    switch (weapon.name) {
    case "concussion_grenade":
        assist_level = "assist_concussion";
        break;
    case "flash_grenade":
        assist_level = "assist_flash";
        break;
    case "emp_grenade":
        assist_level = "assist_emp";
        break;
    case "proximity_grenade":
    case "proximity_grenade_aoe":
        assist_level = "assist_proximity";
        break;
    }
    self challenges::assisted();
}

/#

    // Namespace globallogic_score
    // Params 0, eflags: 0x1 linked
    // Checksum 0x662cebce, Offset: 0x2740
    // Size: 0x8
    function function_4e01d1c3() {
        
    }

#/
