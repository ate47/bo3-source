#using scripts/cp/_util;
#using scripts/cp/_scoreevents;
#using scripts/cp/_challenges;
#using scripts/cp/_bb;
#using scripts/cp/gametypes/_wager;
#using scripts/cp/gametypes/_spawning;
#using scripts/cp/gametypes/_globallogic_utils;
#using scripts/cp/gametypes/_globallogic_score;
#using scripts/cp/gametypes/_globallogic;
#using scripts/cp/gametypes/_loadout;
#using scripts/shared/util_shared;
#using scripts/shared/scoreevents_shared;
#using scripts/shared/rank_shared;
#using scripts/shared/persistence_shared;
#using scripts/shared/math_shared;
#using scripts/shared/flagsys_shared;
#using scripts/shared/challenges_shared;
#using scripts/shared/bb_shared;

#namespace globallogic_score;

// Namespace globallogic_score
// Params 1, eflags: 0x1 linked
// namespace_e32b5089<file_0>::function_ef6804eb
// Checksum 0xad191013, Offset: 0x9b8
// Size: 0x7f2
function updatematchbonusscores(winner) {
    if (!game["timepassed"]) {
        return;
    }
    if (!level.rankedmatch) {
        return;
    }
    if (level.teambased && isdefined(winner)) {
        if (winner == "endregulation") {
            return;
        }
    }
    if (!level.timelimit || level.forcedend) {
        gamelength = globallogic_utils::gettimepassed() / 1000;
        gamelength = min(gamelength, 1200);
        if (level.gametype == "twar" && game["roundsplayed"] > 0) {
            gamelength += level.timelimit * 60;
        }
    } else {
        gamelength = level.timelimit * 60;
    }
    if (level.teambased) {
        winningteam = "tie";
        foreach (team in level.teams) {
            if (winner == team) {
                winningteam = team;
                break;
            }
        }
        if (winningteam != "tie") {
            winnerscale = 1;
            loserscale = 0.5;
        } else {
            winnerscale = 0.75;
            loserscale = 0.75;
        }
        players = level.players;
        for (i = 0; i < players.size; i++) {
            player = players[i];
            if (player.timeplayed["total"] < 1 || player.pers["participation"] < 1) {
                player thread rank::endgameupdate();
                continue;
            }
            totaltimeplayed = player.timeplayed["total"];
            if (totaltimeplayed > gamelength) {
                totaltimeplayed = gamelength;
            }
            if (level.hostforcedend && player ishost()) {
                continue;
            }
            if (player.pers["score"] < 0) {
                continue;
            }
            spm = player rank::getspm();
            if (winningteam == "tie") {
                playerscore = int(winnerscale * gamelength / 60 * spm * totaltimeplayed / gamelength);
                player thread givematchbonus("tie", playerscore);
                player.matchbonus = playerscore;
                continue;
            }
            if (isdefined(player.pers["team"]) && player.pers["team"] == winningteam) {
                playerscore = int(winnerscale * gamelength / 60 * spm * totaltimeplayed / gamelength);
                player thread givematchbonus("win", playerscore);
                player.matchbonus = playerscore;
                continue;
            }
            if (isdefined(player.pers["team"]) && player.pers["team"] != "spectator") {
                playerscore = int(loserscale * gamelength / 60 * spm * totaltimeplayed / gamelength);
                player thread givematchbonus("loss", playerscore);
                player.matchbonus = playerscore;
            }
        }
        return;
    }
    if (isdefined(winner)) {
        winnerscale = 1;
        loserscale = 0.5;
    } else {
        winnerscale = 0.75;
        loserscale = 0.75;
    }
    players = level.players;
    for (i = 0; i < players.size; i++) {
        player = players[i];
        if (player.timeplayed["total"] < 1 || player.pers["participation"] < 1) {
            player thread rank::endgameupdate();
            continue;
        }
        totaltimeplayed = player.timeplayed["total"];
        if (totaltimeplayed > gamelength) {
            totaltimeplayed = gamelength;
        }
        spm = player rank::getspm();
        iswinner = 0;
        for (pidx = 0; pidx < min(level.placement["all"][0].size, 3); pidx++) {
            if (level.placement["all"][pidx] != player) {
                continue;
            }
            iswinner = 1;
        }
        if (iswinner) {
            playerscore = int(winnerscale * gamelength / 60 * spm * totaltimeplayed / gamelength);
            player thread givematchbonus("win", playerscore);
            player.matchbonus = playerscore;
            continue;
        }
        playerscore = int(loserscale * gamelength / 60 * spm * totaltimeplayed / gamelength);
        player thread givematchbonus("loss", playerscore);
        player.matchbonus = playerscore;
    }
}

// Namespace globallogic_score
// Params 2, eflags: 0x1 linked
// namespace_e32b5089<file_0>::function_bef742ae
// Checksum 0xb0d30588, Offset: 0x11b8
// Size: 0x7c
function givematchbonus(scoretype, score) {
    self endon(#"disconnect");
    level waittill(#"give_match_bonus");
    if (scoreevents::shouldaddrankxp(self)) {
        self addrankxpvalue(scoretype, score);
    }
    self rank::endgameupdate();
}

// Namespace globallogic_score
// Params 0, eflags: 0x1 linked
// namespace_e32b5089<file_0>::function_b2a6c667
// Checksum 0xb7d5858c, Offset: 0x1240
// Size: 0x13a
function gethighestscoringplayer() {
    players = level.players;
    winner = undefined;
    tie = 0;
    for (i = 0; i < players.size; i++) {
        if (!isdefined(players[i].pointstowin)) {
            continue;
        }
        if (players[i].pointstowin < 1) {
            continue;
        }
        if (!isdefined(winner) || players[i].pointstowin > winner.pointstowin) {
            winner = players[i];
            tie = 0;
            continue;
        }
        if (players[i].pointstowin == winner.pointstowin) {
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
// namespace_e32b5089<file_0>::function_4ff2f46f
// Checksum 0x8f60d7a3, Offset: 0x1388
// Size: 0x28
function resetscorechain() {
    self notify(#"reset_score_chain");
    self.scorechain = 0;
    self.rankupdatetotal = 0;
}

// Namespace globallogic_score
// Params 0, eflags: 0x0
// namespace_e32b5089<file_0>::function_dbc2be8b
// Checksum 0x57456112, Offset: 0x13b8
// Size: 0x5c
function scorechaintimer() {
    self notify(#"score_chain_timer");
    self endon(#"reset_score_chain");
    self endon(#"score_chain_timer");
    self endon(#"death");
    self endon(#"disconnect");
    wait(20);
    self thread resetscorechain();
}

// Namespace globallogic_score
// Params 1, eflags: 0x0
// namespace_e32b5089<file_0>::function_d92cc672
// Checksum 0x23e16688, Offset: 0x1420
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
// namespace_e32b5089<file_0>::function_7e99fb41
// Checksum 0xf94d9ffd, Offset: 0x1480
// Size: 0x30c
function giveplayerscore(event, player, victim, descvalue) {
    scorediff = 0;
    if (level.overrideplayerscore) {
        return 0;
    }
    pixbeginevent("level.onPlayerScore");
    score = player.pers["score"];
    [[ level.onplayerscore ]](event, player, victim);
    newscore = player.pers["score"];
    pixendevent();
    player bb::add_to_stat("score", newscore - score);
    if (score == newscore) {
        return 0;
    }
    pixbeginevent("givePlayerScore");
    recordplayerstats(player, "score", newscore);
    scorediff = newscore - score;
    challengesenabled = !level.disablechallenges;
    player addplayerstatwithgametype("score", scorediff);
    if (challengesenabled) {
        player addplayerstat("CAREER_SCORE", scorediff);
    }
    if (level.hardcoremode) {
        player addplayerstat("SCORE_HC", scorediff);
        if (challengesenabled) {
            player addplayerstat("CAREER_SCORE_HC", scorediff);
        }
    }
    if (level.multiteam) {
        player addplayerstat("SCORE_MULTITEAM", scorediff);
        if (challengesenabled) {
            player addplayerstat("CAREER_SCORE_MULTITEAM", scorediff);
        }
    }
    if (!level.disablestattracking && isdefined(player.pers["lastHighestScore"]) && newscore > player.pers["lastHighestScore"]) {
        player setdstat("HighestStats", "highest_score", newscore);
    }
    player persistence::add_recent_stat(0, 0, "score", scorediff);
    pixendevent();
    player notify(#"score_event", scorediff);
    return scorediff;
}

// Namespace globallogic_score
// Params 3, eflags: 0x1 linked
// namespace_e32b5089<file_0>::function_8450550f
// Checksum 0x9bceda13, Offset: 0x1798
// Size: 0xb4
function default_onplayerscore(event, player, victim) {
    score = rank::getscoreinfovalue(event);
    assert(isdefined(score));
    if (level.wagermatch) {
        player thread rank::function_9c4690f5(score);
    }
    _setplayerscore(player, player.pers["score"] + score);
}

// Namespace globallogic_score
// Params 2, eflags: 0x1 linked
// namespace_e32b5089<file_0>::function_fffda5bf
// Checksum 0xe0162bdb, Offset: 0x1858
// Size: 0xfc
function _setplayerscore(player, score) {
    if (score == player.pers["score"]) {
        return;
    }
    if (!level.rankedmatch) {
        player thread rank::function_9c4690f5(score - player.pers["score"]);
    }
    player.pers["score"] = score;
    player.score = player.pers["score"];
    recordplayerstats(player, "score", player.pers["score"]);
    if (level.wagermatch) {
        player thread namespace_93432369::function_40cb89b3();
    }
}

// Namespace globallogic_score
// Params 1, eflags: 0x1 linked
// namespace_e32b5089<file_0>::function_acc5da4b
// Checksum 0x9ffda43, Offset: 0x1960
// Size: 0x20
function _getplayerscore(player) {
    return player.pers["score"];
}

// Namespace globallogic_score
// Params 0, eflags: 0x1 linked
// namespace_e32b5089<file_0>::function_2bbb7bbf
// Checksum 0x92dcd2f4, Offset: 0x1988
// Size: 0x176
function playtop3sounds() {
    wait(0.05);
    globallogic::updateplacement();
    for (i = 0; i < level.placement["all"].size; i++) {
        prevscoreplace = level.placement["all"][i].prevscoreplace;
        if (!isdefined(prevscoreplace)) {
            prevscoreplace = 1;
        }
        currentscoreplace = i + 1;
        for (j = i - 1; j >= 0; j--) {
            if (level.placement["all"][i].score == level.placement["all"][j].score) {
                currentscoreplace--;
            }
        }
        wasinthemoney = prevscoreplace <= 3;
        isinthemoney = currentscoreplace <= 3;
        level.placement["all"][i].prevscoreplace = currentscoreplace;
    }
}

// Namespace globallogic_score
// Params 1, eflags: 0x1 linked
// namespace_e32b5089<file_0>::function_dbc91bb1
// Checksum 0x3e8cab36, Offset: 0x1b08
// Size: 0x9c
function setpointstowin(points) {
    self.pers["pointstowin"] = math::clamp(points, 0, 65000);
    self.pointstowin = self.pers["pointstowin"];
    self thread globallogic::checkscorelimit();
    self thread globallogic::checkplayerscorelimitsoon();
    level thread playtop3sounds();
}

// Namespace globallogic_score
// Params 1, eflags: 0x0
// namespace_e32b5089<file_0>::function_a79d7152
// Checksum 0xa13c53d1, Offset: 0x1bb0
// Size: 0x3c
function givepointstowin(points) {
    self setpointstowin(self.pers["pointstowin"] + points);
}

// Namespace globallogic_score
// Params 4, eflags: 0x1 linked
// namespace_e32b5089<file_0>::function_806e3c51
// Checksum 0x91bd1334, Offset: 0x1bf8
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
// namespace_e32b5089<file_0>::function_794e30e4
// Checksum 0x61a33d6f, Offset: 0x1d28
// Size: 0x94
function giveteamscoreforobjective_delaypostprocessing(team, score) {
    teamscore = game["teamScores"][team];
    onteamscore_incrementscore(score, team);
    newscore = game["teamScores"][team];
    if (teamscore == newscore) {
        return;
    }
    updateteamscores(team);
}

// Namespace globallogic_score
// Params 1, eflags: 0x0
// namespace_e32b5089<file_0>::function_ad2655c8
// Checksum 0xd4aa1010, Offset: 0x1dc8
// Size: 0xa4
function postprocessteamscores(teams) {
    foreach (team in teams) {
        onteamscore_postprocess(team);
    }
    thread globallogic::checkscorelimit();
}

// Namespace globallogic_score
// Params 2, eflags: 0x1 linked
// namespace_e32b5089<file_0>::function_595758a3
// Checksum 0xcfb22f95, Offset: 0x1e78
// Size: 0xbc
function giveteamscoreforobjective(team, score) {
    if (!isdefined(level.teams[team])) {
        return;
    }
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
// namespace_e32b5089<file_0>::function_a5d0acb3
// Checksum 0x897e89d4, Offset: 0x1f40
// Size: 0x8c
function _setteamscore(team, teamscore) {
    if (teamscore == game["teamScores"][team]) {
        return;
    }
    game["teamScores"][team] = math::clamp(teamscore, 0, 1000000);
    updateteamscores(team);
    thread globallogic::checkscorelimit();
}

// Namespace globallogic_score
// Params 0, eflags: 0x1 linked
// namespace_e32b5089<file_0>::function_fcb59778
// Checksum 0x7b63756d, Offset: 0x1fd8
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
// namespace_e32b5089<file_0>::function_3ee9bd9e
// Checksum 0xbadeef00, Offset: 0x20a0
// Size: 0x24
function resetallscores() {
    resetteamscores();
    resetplayerscores();
}

// Namespace globallogic_score
// Params 0, eflags: 0x1 linked
// namespace_e32b5089<file_0>::function_7d5864a8
// Checksum 0xed4fa3fd, Offset: 0x20d0
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
// namespace_e32b5089<file_0>::function_95e3ed98
// Checksum 0x2031ae4c, Offset: 0x2180
// Size: 0x4c
function updateteamscores(team) {
    setteamscore(team, game["teamScores"][team]);
    level thread globallogic::checkteamscorelimitsoon(team);
}

// Namespace globallogic_score
// Params 0, eflags: 0x1 linked
// namespace_e32b5089<file_0>::function_16ca2e25
// Checksum 0x9714efb6, Offset: 0x21d8
// Size: 0x8a
function updateallteamscores() {
    foreach (team in level.teams) {
        updateteamscores(team);
    }
}

// Namespace globallogic_score
// Params 1, eflags: 0x1 linked
// namespace_e32b5089<file_0>::function_1dcc90b7
// Checksum 0x237fd4d1, Offset: 0x2270
// Size: 0x1c
function _getteamscore(team) {
    return game["teamScores"][team];
}

// Namespace globallogic_score
// Params 0, eflags: 0x1 linked
// namespace_e32b5089<file_0>::function_ae8065ab
// Checksum 0x51614ea2, Offset: 0x2298
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
// namespace_e32b5089<file_0>::function_e525bda4
// Checksum 0x48fb0629, Offset: 0x2398
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
// namespace_e32b5089<file_0>::function_9ed78565
// Checksum 0x3a9f0dd5, Offset: 0x2450
// Size: 0x44
function onteamscore(score, team) {
    onteamscore_incrementscore(score, team);
    onteamscore_postprocess(team);
}

// Namespace globallogic_score
// Params 2, eflags: 0x1 linked
// namespace_e32b5089<file_0>::function_bccf8abf
// Checksum 0x272c69b8, Offset: 0x24a0
// Size: 0xb2
function onteamscore_incrementscore(score, team) {
    game["teamScores"][team] = game["teamScores"][team] + score;
    if (game["teamScores"][team] < 0) {
        game["teamScores"][team] = 0;
    }
    if (level.scorelimit && game["teamScores"][team] > level.scorelimit) {
        game["teamScores"][team] = level.scorelimit;
    }
}

// Namespace globallogic_score
// Params 1, eflags: 0x1 linked
// namespace_e32b5089<file_0>::function_e3b726fd
// Checksum 0x9a72e19d, Offset: 0x2560
// Size: 0x208
function onteamscore_postprocess(team) {
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
    if (iswinning.size == 1) {
        level.laststatustime = gettime();
        foreach (team in iswinning) {
            if (isdefined(level.waswinning[team])) {
                if (level.waswinning.size == 1) {
                }
            }
        }
    } else {
        return;
    }
    if (level.waswinning.size == 1) {
        foreach (team in level.waswinning) {
            if (isdefined(iswinning[team])) {
                if (iswinning.size == 1) {
                    continue;
                }
                if (level.waswinning.size > 1) {
                }
            }
        }
    }
    level.waswinning = iswinning;
}

// Namespace globallogic_score
// Params 2, eflags: 0x1 linked
// namespace_e32b5089<file_0>::function_aa0fe5c3
// Checksum 0xbd492797, Offset: 0x2770
// Size: 0x6c
function default_onteamscore(event, team) {
    score = rank::getscoreinfovalue(event);
    assert(isdefined(score));
    onteamscore(score, team);
}

// Namespace globallogic_score
// Params 2, eflags: 0x1 linked
// namespace_e32b5089<file_0>::function_f4f342c9
// Checksum 0x270c706c, Offset: 0x27e8
// Size: 0x8c
function initpersstat(dataname, record_stats) {
    if (!isdefined(self.pers[dataname])) {
        self.pers[dataname] = 0;
    }
    if (!isdefined(record_stats) || record_stats == 1) {
        recordplayerstats(self, dataname, int(self.pers[dataname]));
    }
}

// Namespace globallogic_score
// Params 1, eflags: 0x1 linked
// namespace_e32b5089<file_0>::function_9142ee49
// Checksum 0x5921cd07, Offset: 0x2880
// Size: 0x18
function getpersstat(dataname) {
    return self.pers[dataname];
}

// Namespace globallogic_score
// Params 4, eflags: 0x1 linked
// namespace_e32b5089<file_0>::function_ec3c08d5
// Checksum 0x541ff97f, Offset: 0x28a0
// Size: 0xec
function incpersstat(dataname, increment, record_stats, includegametype) {
    pixbeginevent("incPersStat");
    self.pers[dataname] = self.pers[dataname] + increment;
    if (isdefined(includegametype) && includegametype) {
        self addplayerstatwithgametype(dataname, increment);
    } else {
        self addplayerstat(dataname, increment);
    }
    if (!isdefined(record_stats) || record_stats == 1) {
        self thread threadedrecordplayerstats(dataname);
    }
    pixendevent();
}

// Namespace globallogic_score
// Params 1, eflags: 0x1 linked
// namespace_e32b5089<file_0>::function_2d0985b
// Checksum 0x847b5af8, Offset: 0x2998
// Size: 0x3c
function threadedrecordplayerstats(dataname) {
    self endon(#"disconnect");
    waittillframeend();
    recordplayerstats(self, dataname, self.pers[dataname]);
}

// Namespace globallogic_score
// Params 1, eflags: 0x1 linked
// namespace_e32b5089<file_0>::function_17c49541
// Checksum 0x8ed52756, Offset: 0x29e0
// Size: 0x234
function updatewinstats(winner) {
    winner addplayerstatwithgametype("losses", -1);
    winner addplayerstatwithgametype("wins", 1);
    if (level.hardcoremode) {
        winner addplayerstat("wins_HC", 1);
    }
    if (level.multiteam) {
        winner addplayerstat("wins_MULTITEAM", 1);
    }
    winner updatestatratio("wlratio", "wins", "losses");
    restorewinstreaks(winner);
    winner addplayerstatwithgametype("cur_win_streak", 1);
    winner notify(#"win");
    cur_gamemode_win_streak = winner persistence::function_2369852e("cur_win_streak");
    gamemode_win_streak = winner persistence::function_2369852e("win_streak");
    cur_win_streak = winner getdstat("playerstatslist", "cur_win_streak", "StatValue");
    if (!level.disablestattracking && cur_win_streak > winner getdstat("HighestStats", "win_streak")) {
        winner setdstat("HighestStats", "win_streak", cur_win_streak);
    }
    if (cur_gamemode_win_streak > gamemode_win_streak) {
        winner persistence::function_e885624a("win_streak", cur_gamemode_win_streak);
    }
}

// Namespace globallogic_score
// Params 1, eflags: 0x1 linked
// namespace_e32b5089<file_0>::function_214b6780
// Checksum 0x786b76d3, Offset: 0x2c20
// Size: 0x6c
function updatelossstats(loser) {
    loser addplayerstatwithgametype("losses", 1);
    loser updatestatratio("wlratio", "wins", "losses");
    loser notify(#"loss");
}

// Namespace globallogic_score
// Params 1, eflags: 0x1 linked
// namespace_e32b5089<file_0>::function_89539239
// Checksum 0x745f448a, Offset: 0x2c98
// Size: 0xc4
function updatetiestats(loser) {
    loser addplayerstatwithgametype("losses", -1);
    loser addplayerstatwithgametype("ties", 1);
    loser updatestatratio("wlratio", "wins", "losses");
    if (!level.disablestattracking) {
        loser setdstat("playerstatslist", "cur_win_streak", "StatValue", 0);
    }
    loser notify(#"tie");
}

// Namespace globallogic_score
// Params 1, eflags: 0x0
// namespace_e32b5089<file_0>::function_4096fefe
// Checksum 0xe32aebc0, Offset: 0x2d68
// Size: 0x366
function updatewinlossstats(winner) {
    if (!util::waslastround() && !level.hostforcedend) {
        return;
    }
    players = level.players;
    if (isdefined(winner) && !isplayer(winner) && (!isdefined(winner) || winner == "tie")) {
        for (i = 0; i < players.size; i++) {
            if (!isdefined(players[i].pers["team"])) {
                continue;
            }
            if (level.hostforcedend && players[i] ishost()) {
                continue;
            }
            updatetiestats(players[i]);
        }
        return;
    }
    if (isplayer(winner)) {
        if (level.hostforcedend && winner ishost()) {
            return;
        }
        updatewinstats(winner);
        if (!level.teambased) {
            placement = level.placement["all"];
            topthreeplayers = min(3, placement.size);
            for (index = 1; index < topthreeplayers; index++) {
                nexttopplayer = placement[index];
                updatewinstats(nexttopplayer);
            }
        }
        return;
    }
    for (i = 0; i < players.size; i++) {
        if (!isdefined(players[i].pers["team"])) {
            continue;
        }
        if (level.hostforcedend && players[i] ishost()) {
            continue;
        }
        if (winner == "tie") {
            updatetiestats(players[i]);
            continue;
        }
        if (players[i].pers["team"] == winner) {
            updatewinstats(players[i]);
            continue;
        }
        if (!level.disablestattracking) {
            players[i] setdstat("playerstatslist", "cur_win_streak", "StatValue", 0);
        }
    }
}

// Namespace globallogic_score
// Params 0, eflags: 0x1 linked
// namespace_e32b5089<file_0>::function_af12c08a
// Checksum 0x43637901, Offset: 0x30d8
// Size: 0xcc
function backupandclearwinstreaks() {
    self.pers["winStreak"] = self getdstat("playerstatslist", "cur_win_streak", "StatValue");
    if (!level.disablestattracking) {
        self setdstat("playerstatslist", "cur_win_streak", "StatValue", 0);
    }
    self.pers["winStreakForGametype"] = persistence::function_2369852e("cur_win_streak");
    self persistence::function_e885624a("cur_win_streak", 0);
}

// Namespace globallogic_score
// Params 1, eflags: 0x1 linked
// namespace_e32b5089<file_0>::function_9665587a
// Checksum 0x8ff4054e, Offset: 0x31b0
// Size: 0x84
function restorewinstreaks(winner) {
    if (!level.disablestattracking) {
        winner setdstat("playerstatslist", "cur_win_streak", "StatValue", winner.pers["winStreak"]);
    }
    winner persistence::function_e885624a("cur_win_streak", winner.pers["winStreakForGametype"]);
}

// Namespace globallogic_score
// Params 1, eflags: 0x1 linked
// namespace_e32b5089<file_0>::function_c66a74a3
// Checksum 0xeb8f5327, Offset: 0x3240
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
// namespace_e32b5089<file_0>::function_d252c0d3
// Checksum 0x216623f7, Offset: 0x32c0
// Size: 0x42c
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
    if (!isdefined(attacker.lastkilledvictim) || !isdefined(attacker.lastkilledvictimcount)) {
        attacker.lastkilledvictim = name;
        attacker.lastkilledvictimcount = 0;
    }
    if (attacker.lastkilledvictim == name) {
        attacker.lastkilledvictimcount++;
        if (attacker.lastkilledvictimcount >= 5) {
            attacker.lastkilledvictimcount = 0;
            attacker addplayerstat("streaker", 1);
        }
    } else {
        attacker.lastkilledvictim = name;
        attacker.lastkilledvictimcount = 1;
    }
    pixendevent();
}

// Namespace globallogic_score
// Params 5, eflags: 0x1 linked
// namespace_e32b5089<file_0>::function_19bc0e4e
// Checksum 0xb7c94182, Offset: 0x36f8
// Size: 0x264
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
    pixendevent();
}

// Namespace globallogic_score
// Params 0, eflags: 0x1 linked
// namespace_e32b5089<file_0>::function_4349658
// Checksum 0xfe7fc4d0, Offset: 0x3968
// Size: 0x6
function default_iskillboosting() {
    return false;
}

// Namespace globallogic_score
// Params 3, eflags: 0x1 linked
// namespace_e32b5089<file_0>::function_f4f11e83
// Checksum 0x516d742e, Offset: 0x3978
// Size: 0xa0c
function givekillstats(smeansofdeath, weapon, evictim) {
    self endon(#"disconnect");
    waittillframeend();
    if (level.rankedmatch && self [[ level.iskillboosting ]]()) {
        /#
            self iprintlnbold("team");
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
        if (isdefined(evictim) && isplayer(evictim)) {
            evictim recordkillmodifier("headshot");
        }
    }
    if (isdefined(evictim.var_b3b49b95)) {
        if (evictim.var_b3b49b95 + 2000 >= gettime()) {
            self addweaponstat(getweapon("flash_grenade"), "CombatRecordStat", 1);
        }
    }
    if (isdefined(evictim.var_63fb6c7d)) {
        if (evictim.var_63fb6c7d + 2000 >= gettime()) {
            self addweaponstat(getweapon("proximity_grenade"), "CombatRecordStat", 1);
        }
    }
    if (isdefined(evictim.var_4d6fef21)) {
        if (evictim.var_4d6fef21 + 2000 >= gettime()) {
            self addweaponstat(getweapon("emp_grenade"), "CombatRecordStat", 1);
        }
    }
    if (isdefined(evictim.var_7097b5af)) {
        if (evictim.var_7097b5af + 2000 >= gettime()) {
            function_28c6cf9e(getitemindexfromref("cybercom_ravagecore"));
        }
    }
    if (isdefined(weapon)) {
        weaponpickedup = 0;
        if (isdefined(attacker.pickedupweapons) && isdefined(attacker.pickedupweapons[weapon])) {
            weaponpickedup = 1;
        }
        attacker addweaponstat(weapon, "kills", 1, attacker.class_num, weaponpickedup, undefined, attacker.primaryloadoutgunsmithvariantindex, attacker.secondaryloadoutgunsmithvariantindex);
        if (smeansofdeath == "MOD_HEAD_SHOT") {
            attacker addweaponstat(weapon, "headshots", 1, attacker.class_num, weaponpickedup, undefined, attacker.primaryloadoutgunsmithvariantindex, attacker.secondaryloadoutgunsmithvariantindex);
        }
        if (weapon.name == "launcher_standard_df" || weapon.name == "launcher_standard") {
            if (weapon.name == "launcher_standard_df") {
                weapon = getweapon("launcher_standard");
            } else {
                weapon = getweapon("launcher_standard_df");
            }
            attacker addweaponstat(weapon, "kills", 1, attacker.class_num, weaponpickedup, undefined, attacker.primaryloadoutgunsmithvariantindex, attacker.secondaryloadoutgunsmithvariantindex);
            if (smeansofdeath == "MOD_HEAD_SHOT") {
                attacker addweaponstat(weapon, "headshots", 1, attacker.class_num, weaponpickedup, undefined, attacker.primaryloadoutgunsmithvariantindex, attacker.secondaryloadoutgunsmithvariantindex);
            }
        }
    }
    if (isplayer(attacker)) {
        itemindex = undefined;
        if (weapon.name == "gadget_firefly_swarm" || weapon.name == "gadget_firefly_swarm_upgraded") {
            itemindex = getitemindexfromref("cybercom_fireflyswarm");
        } else if (weapon.name == "hero_gravityspikes_cybercom" || weapon.name == "hero_gravityspikes_cybercom_upgraded") {
            itemindex = getitemindexfromref("cybercom_concussive");
        } else if (weapon.name == "gadget_unstoppable_force" || weapon.name == "gadget_unstoppable_force_upgraded") {
            itemindex = getitemindexfromref("cybercom_unstoppableforce");
        } else if (weapon.name == "gadget_es_strike") {
            itemindex = getitemindexfromref("cybercom_es_strike");
        } else if (weapon.name == "amws_gun_turret_player" || weapon.name == "hunter_main_turret_player" || weapon.name == "hunter_side_turret_player" || weapon.name == "pamws_gun_turret_player" || weapon.name == "quadtank_side_turret_player" || weapon.name == "siegebot_gun_turret_player" || weapon.name == "wasp_main_turret_player" || weapon.name == "amws_launcher_turret_player" || weapon.name == "hunter_rocket_turret_player" || weapon.name == "pamws_launcher_turret_player" || weapon.name == "quadtank_main_turret_player" || weapon.name == "rocket_wasp_launcher_turret_player" || weapon.name == "siegebot_launcher_turret_player") {
            itemindex = getitemindexfromref("cybercom_hijack");
        }
        function_28c6cf9e(itemindex);
        if (isdefined(attacker.active_camo) && attacker.active_camo) {
            function_28c6cf9e(getitemindexfromref("cybercom_camo"));
        }
        if (isdefined(evictim.enemy) && isdefined(evictim.enemy.var_e42818a3) && evictim.enemy.var_e42818a3) {
            function_28c6cf9e(getitemindexfromref("cybercom_misdirection"));
        }
        if (attacker flagsys::get("gadget_overdrive_on")) {
            function_28c6cf9e(getitemindexfromref("cybercom_overdrive"));
        }
        if (isdefined(evictim.var_d90f9ddb) && evictim.var_d90f9ddb) {
            function_28c6cf9e(getitemindexfromref("cybercom_smokescreen"));
        }
    }
    pixendevent();
}

// Namespace globallogic_score
// Params 1, eflags: 0x1 linked
// namespace_e32b5089<file_0>::function_28c6cf9e
// Checksum 0x837e9e53, Offset: 0x4390
// Size: 0x54
function function_28c6cf9e(itemindex) {
    if (isdefined(itemindex)) {
        self adddstat("ItemStats", itemindex, "stats", "kills", "statValue", 1);
    }
}

// Namespace globallogic_score
// Params 1, eflags: 0x1 linked
// namespace_e32b5089<file_0>::function_7bf7d322
// Checksum 0x6f84e06c, Offset: 0x43f0
// Size: 0x4c
function inctotalkills(team) {
    if (level.teambased && isdefined(level.teams[team])) {
        game["totalKillsTeam"][team]++;
    }
    game["totalKills"]++;
}

// Namespace globallogic_score
// Params 3, eflags: 0x1 linked
// namespace_e32b5089<file_0>::function_50ec476d
// Checksum 0x2edd3c55, Offset: 0x4448
// Size: 0x194
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
        if (weapon.name == "concussion_grenade" || weapon.name == "tabun_gas") {
            eattacker addweaponstat(weapon, "used", 1);
        }
        eattacker addweaponstat(weapon, "hits", 1);
    }
}

// Namespace globallogic_score
// Params 1, eflags: 0x1 linked
// namespace_e32b5089<file_0>::function_1e129e72
// Checksum 0x61651588, Offset: 0x45e8
// Size: 0x10c
function processshieldassist(killedplayer) {
    self endon(#"disconnect");
    killedplayer endon(#"disconnect");
    wait(0.05);
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
    scoreevents::processscoreevent("shield_assist", self, killedplayer, "riotshield");
}

// Namespace globallogic_score
// Params 4, eflags: 0x1 linked
// namespace_e32b5089<file_0>::function_43256951
// Checksum 0x3fc4cdda, Offset: 0x4700
// Size: 0x20c
function processassist(var_bd0f13b, damagedone, weapon, assist_level) {
    self endon(#"disconnect");
    var_bd0f13b endon(#"disconnect");
    wait(0.05);
    util::waittillslowprocessallowed();
    if (!isdefined(level.teams[self.team])) {
        return;
    }
    if (isdefined(var_bd0f13b) && isdefined(var_bd0f13b.team) && self.team == var_bd0f13b.team) {
        return;
    }
    if (!level.teambased) {
        return;
    }
    if (!isdefined(assist_level)) {
        assist_level = "assist";
    }
    assist_level_value = int(ceil(damagedone / 25));
    if (assist_level_value < 1) {
        assist_level_value = 1;
    } else if (assist_level_value > 3) {
        assist_level_value = 3;
    }
    assist_level = assist_level + "_" + assist_level_value * 25;
    self incpersstat("assists", 1, 1, 1);
    self.assists = self getpersstat("assists");
    if (isdefined(weapon)) {
        self addweaponstat(weapon, "assists", 1);
    }
    self challenges::assisted();
    scoreevents::processscoreevent(assist_level, self, var_bd0f13b, weapon);
}

/#

    // Namespace globallogic_score
    // Params 0, eflags: 0x1 linked
    // namespace_e32b5089<file_0>::function_4e01d1c3
    // Checksum 0x574e664d, Offset: 0x4918
    // Size: 0xd8
    function function_4e01d1c3() {
        self endon(#"death");
        self endon(#"disconnect");
        level endon(#"game_ended");
        while (level.inprematchperiod) {
            wait(0.05);
        }
        for (;;) {
            wait(5);
            if (isdefined(level.teams[level.players[0].pers["team"]])) {
                self rank::giverankxp("team", int(min(getdvarint("team"), 50)));
            }
        }
    }

#/
