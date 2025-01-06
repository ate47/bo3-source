#using scripts/mp/_challenges;
#using scripts/mp/_scoreevents;
#using scripts/mp/_teamops;
#using scripts/mp/_util;
#using scripts/mp/gametypes/_globallogic;
#using scripts/mp/gametypes/_globallogic_audio;
#using scripts/mp/gametypes/_globallogic_score;
#using scripts/mp/gametypes/_globallogic_utils;
#using scripts/mp/gametypes/_loadout;
#using scripts/mp/gametypes/_spawning;
#using scripts/mp/gametypes/_wager;
#using scripts/mp/killstreaks/_counteruav;
#using scripts/mp/killstreaks/_emp;
#using scripts/mp/killstreaks/_killstreak_weapons;
#using scripts/mp/killstreaks/_killstreaks;
#using scripts/shared/abilities/_ability_player;
#using scripts/shared/abilities/_ability_util;
#using scripts/shared/bb_shared;
#using scripts/shared/bots/_bot;
#using scripts/shared/challenges_shared;
#using scripts/shared/killstreaks_shared;
#using scripts/shared/math_shared;
#using scripts/shared/persistence_shared;
#using scripts/shared/rank_shared;
#using scripts/shared/scoreevents_shared;
#using scripts/shared/util_shared;

#namespace globallogic_score;

// Namespace globallogic_score
// Params 1, eflags: 0x0
// Checksum 0x314d275c, Offset: 0xac8
// Size: 0x91
function updatematchbonusscores(winner) {
    InvalidOpCode(0x54, "timepassed");
    // Unknown operator (0x54, t7_1b, PC)
}

// Namespace globallogic_score
// Params 1, eflags: 0x0
// Checksum 0xc5d8328e, Offset: 0x1078
// Size: 0x155
function updatecustomgamewinner(winner) {
    if (!level.mpcustommatch) {
        return;
    }
    for (i = 0; i < level.players.size; i++) {
        player = level.players[i];
        if (!isdefined(winner)) {
            player.pers["victory"] = 0;
        } else if (level.teambased) {
            if (player.team == winner) {
                player.pers["victory"] = 2;
            } else if (winner == "tie") {
                player.pers["victory"] = 1;
            } else {
                player.pers["victory"] = 0;
            }
        } else if (player == winner) {
            player.pers["victory"] = 2;
        } else {
            player.pers["victory"] = 0;
        }
        player.victory = player.pers["victory"];
        player.pers["sbtimeplayed"] = player.timeplayed["total"];
        player.sbtimeplayed = player.pers["sbtimeplayed"];
    }
}

// Namespace globallogic_score
// Params 2, eflags: 0x0
// Checksum 0xc97f4b19, Offset: 0x11d8
// Size: 0x5a
function givematchbonus(scoretype, score) {
    self endon(#"disconnect");
    level waittill(#"give_match_bonus");
    if (scoreevents::shouldaddrankxp(self)) {
        self addrankxpvalue(scoretype, score);
    }
    self rank::endgameupdate();
}

// Namespace globallogic_score
// Params 0, eflags: 0x0
// Checksum 0x43ec1b4a, Offset: 0x1240
// Size: 0xd8
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
// Params 1, eflags: 0x0
// Checksum 0x6fbf363e, Offset: 0x1320
// Size: 0x2a
function resetplayerscorechainandmomentum(player) {
    player thread _setplayermomentum(self, 0);
    player thread resetscorechain();
}

// Namespace globallogic_score
// Params 0, eflags: 0x0
// Checksum 0xb894ce9d, Offset: 0x1358
// Size: 0x1a
function resetscorechain() {
    self notify(#"reset_score_chain");
    self.scorechain = 0;
    self.rankupdatetotal = 0;
}

// Namespace globallogic_score
// Params 0, eflags: 0x0
// Checksum 0x57475146, Offset: 0x1380
// Size: 0x42
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
// Params 1, eflags: 0x0
// Checksum 0x8d26aac7, Offset: 0x13d0
// Size: 0x36
function roundtonearestfive(score) {
    rounding = score % 5;
    if (rounding <= 2) {
        return (score - rounding);
    }
    return score + 5 - rounding;
}

// Namespace globallogic_score
// Params 6, eflags: 0x0
// Checksum 0x37919cd7, Offset: 0x1410
// Size: 0x12a
function giveplayermomentumnotification(score, label, descvalue, countstowardrampage, weapon, combatefficiencybonus) {
    if (!isdefined(combatefficiencybonus)) {
        combatefficiencybonus = 0;
    }
    score += combatefficiencybonus;
    if (score != 0) {
        self luinotifyevent(%score_event, 3, label, score, combatefficiencybonus);
        self luinotifyeventtospectators(%score_event, 3, label, score, combatefficiencybonus);
    }
    score = score;
    if (score > 0 && self hasperk("specialty_earnmoremomentum")) {
        score = roundtonearestfive(int(score * getdvarfloat("perk_killstreakMomentumMultiplier") + 0.5));
    }
    if (isalive(self)) {
        _setplayermomentum(self, self.pers["momentum"] + score);
    }
}

// Namespace globallogic_score
// Params 0, eflags: 0x0
// Checksum 0x15ed43e5, Offset: 0x1548
// Size: 0x3a
function resetplayermomentumonspawn() {
    if (isdefined(level.usingscorestreaks) && level.usingscorestreaks) {
        _setplayermomentum(self, 0);
        self thread resetscorechain();
    }
}

// Namespace globallogic_score
// Params 5, eflags: 0x0
// Checksum 0x1ddd5d7d, Offset: 0x1590
// Size: 0x1c2
function giveplayermomentum(event, player, victim, descvalue, weapon) {
    if (isdefined(level.disablemomentum) && level.disablemomentum == 1) {
        return;
    }
    score = rank::getscoreinfovalue(event);
    assert(isdefined(score));
    label = rank::getscoreinfolabel(event);
    countstowardrampage = rank::doesscoreinfocounttowardrampage(event);
    var_66b8395e = rank::getcombatefficiencyevent(event);
    if (isdefined(var_66b8395e) && player ability_util::gadget_combat_efficiency_enabled()) {
        combatefficiencyscore = rank::getscoreinfovalue(var_66b8395e);
        assert(isdefined(combatefficiencyscore));
        player ability_util::gadget_combat_efficiency_power_drain(combatefficiencyscore);
    }
    if (event == "death") {
        _setplayermomentum(victim, victim.pers["momentum"] + score);
    }
    if (score == 0) {
        return;
    }
    if (level.gameended) {
        return;
    }
    if (!isdefined(label)) {
        errormsg(event + "<dev string:x28>");
        player giveplayermomentumnotification(score, %SCORE_BLANK, descvalue, countstowardrampage, weapon, combatefficiencyscore);
        return;
    }
    player giveplayermomentumnotification(score, label, descvalue, countstowardrampage, weapon, combatefficiencyscore);
}

// Namespace globallogic_score
// Params 5, eflags: 0x0
// Checksum 0xd2638892, Offset: 0x1760
// Size: 0x31c
function giveplayerscore(event, player, victim, descvalue, weapon) {
    scorediff = 0;
    momentum = player.pers["momentum"];
    giveplayermomentum(event, player, victim, descvalue, weapon);
    newmomentum = player.pers["momentum"];
    if (level.overrideplayerscore) {
        return 0;
    }
    pixbeginevent("level.onPlayerScore");
    score = player.pers["score"];
    [[ level.onplayerscore ]](event, player, victim);
    newscore = player.pers["score"];
    pixendevent();
    isusingheropower = 0;
    if (player ability_player::is_using_any_gadget()) {
        isusingheropower = 1;
    }
    bbprint("mpplayerscore", "spawnid %d gametime %d type %s player %s delta %d deltamomentum %d team %s isusingheropower %d", getplayerspawnid(player), gettime(), event, player.name, newscore - score, newmomentum - momentum, player.team, isusingheropower);
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
    return scorediff;
}

// Namespace globallogic_score
// Params 3, eflags: 0x0
// Checksum 0x5b8447df, Offset: 0x1a88
// Size: 0x8a
function default_onplayerscore(event, player, victim) {
    score = rank::getscoreinfovalue(event);
    assert(isdefined(score));
    if (level.wagermatch) {
        player thread rank::function_9c4690f5(score);
    }
    _setplayerscore(player, player.pers["score"] + score);
}

// Namespace globallogic_score
// Params 2, eflags: 0x0
// Checksum 0x25f9ece, Offset: 0x1b20
// Size: 0xc2
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
        player thread wager::function_40cb89b3();
    }
}

// Namespace globallogic_score
// Params 1, eflags: 0x0
// Checksum 0xde885905, Offset: 0x1bf0
// Size: 0x1a
function _getplayerscore(player) {
    return player.pers["score"];
}

// Namespace globallogic_score
// Params 0, eflags: 0x0
// Checksum 0xb5ab7cbe, Offset: 0x1c18
// Size: 0x115
function playtop3sounds() {
    wait 0.05;
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
// Params 1, eflags: 0x0
// Checksum 0x4c5a8a5e, Offset: 0x1d38
// Size: 0x8a
function setpointstowin(points) {
    self.pers["pointstowin"] = math::clamp(points, 0, 65000);
    self.pointstowin = self.pers["pointstowin"];
    self thread globallogic::checkscorelimit();
    self thread globallogic::checkroundscorelimit();
    self thread globallogic::checkplayerscorelimitsoon();
    level thread playtop3sounds();
}

// Namespace globallogic_score
// Params 1, eflags: 0x0
// Checksum 0x5bfacccd, Offset: 0x1dd0
// Size: 0x2a
function givepointstowin(points) {
    self setpointstowin(self.pers["pointstowin"] + points);
}

// Namespace globallogic_score
// Params 3, eflags: 0x0
// Checksum 0xbb87b63f, Offset: 0x1e08
// Size: 0x1ee
function _setplayermomentum(player, momentum, updatescore) {
    if (!isdefined(updatescore)) {
        updatescore = 1;
    }
    if (getdvarint("teamOpsEnabled") == 1) {
        return;
    }
    momentum = math::clamp(momentum, 0, 2000);
    oldmomentum = player.pers["momentum"];
    if (momentum == oldmomentum) {
        return;
    }
    if (updatescore) {
        player bb::add_to_stat("momentum", momentum - oldmomentum);
    }
    if (momentum > oldmomentum) {
        highestmomentumcost = 0;
        numkillstreaks = 0;
        if (isdefined(player.killstreak)) {
            numkillstreaks = player.killstreak.size;
        }
        killstreaktypearray = [];
        for (currentkillstreak = 0; currentkillstreak < numkillstreaks; currentkillstreak++) {
            killstreaktype = killstreaks::get_by_menu_name(player.killstreak[currentkillstreak]);
            if (isdefined(killstreaktype)) {
                momentumcost = level.killstreaks[killstreaktype].momentumcost;
                if (momentumcost > highestmomentumcost) {
                    highestmomentumcost = momentumcost;
                }
                killstreaktypearray[killstreaktypearray.size] = killstreaktype;
            }
        }
        _giveplayerkillstreakinternal(player, momentum, oldmomentum, killstreaktypearray);
        while (highestmomentumcost > 0 && momentum >= highestmomentumcost) {
            oldmomentum = 0;
            momentum -= highestmomentumcost;
            _giveplayerkillstreakinternal(player, momentum, oldmomentum, killstreaktypearray);
            self.pers["anteup_momentum_unused"] = 0;
        }
    }
    player.pers["momentum"] = momentum;
    player.momentum = player.pers["momentum"];
}

// Namespace globallogic_score
// Params 4, eflags: 0x0
// Checksum 0x327c204, Offset: 0x2000
// Size: 0x3a1
function _giveplayerkillstreakinternal(player, momentum, oldmomentum, killstreaktypearray) {
    for (killstreaktypeindex = 0; killstreaktypeindex < killstreaktypearray.size; killstreaktypeindex++) {
        killstreaktype = killstreaktypearray[killstreaktypeindex];
        momentumcost = level.killstreaks[killstreaktype].momentumcost;
        if (momentumcost > oldmomentum && momentumcost <= momentum) {
            weapon = killstreaks::get_killstreak_weapon(killstreaktype);
            was_already_at_max_stacking = 0;
            if (isdefined(level.usingscorestreaks) && level.usingscorestreaks) {
                if (weapon.iscarriedkillstreak) {
                    if (!isdefined(player.pers["held_killstreak_ammo_count"][weapon])) {
                        player.pers["held_killstreak_ammo_count"][weapon] = 0;
                    }
                    if (!isdefined(player.pers["killstreak_quantity"][weapon])) {
                        player.pers["killstreak_quantity"][weapon] = 0;
                    }
                    currentweapon = player getcurrentweapon();
                    if (currentweapon == weapon) {
                        if (player.pers["killstreak_quantity"][weapon] < level.scorestreaksmaxstacking) {
                            player.pers["killstreak_quantity"][weapon]++;
                        }
                    } else {
                        player.pers["held_killstreak_clip_count"][weapon] = weapon.clipsize;
                        player.pers["held_killstreak_ammo_count"][weapon] = weapon.maxammo;
                        player loadout::function_8de272c8(weapon, player.pers["held_killstreak_ammo_count"][weapon]);
                    }
                } else {
                    player challenges::earnedkillstreak();
                    if (player ability_util::gadget_is_active(15)) {
                        scoreevents::processscoreevent("focus_earn_scorestreak", player);
                        player scoreevents::specialistmedalachievement();
                        if (player.heroability.name == "gadget_combat_efficiency") {
                            player addweaponstat(player.heroability, "scorestreaks_earned", 1);
                            if (!isdefined(player.scorestreaksearnedperuse)) {
                                player.scorestreaksearnedperuse = 0;
                            }
                            player.scorestreaksearnedperuse++;
                            if (player.scorestreaksearnedperuse >= 3) {
                                scoreevents::processscoreevent("focus_earn_multiscorestreak", player);
                                player.scorestreaksearnedperuse = 0;
                            }
                        }
                    }
                    old_killstreak_quantity = player killstreaks::get_killstreak_quantity(weapon);
                    new_killstreak_quantity = player killstreaks::change_killstreak_quantity(weapon, 1);
                    was_already_at_max_stacking = new_killstreak_quantity == old_killstreak_quantity;
                }
                if (!was_already_at_max_stacking) {
                    player killstreaks::add_to_notification_queue(level.killstreaks[killstreaktype].menuname, new_killstreak_quantity, killstreaktype);
                }
                continue;
            }
            player killstreaks::add_to_notification_queue(level.killstreaks[killstreaktype].menuname, 0, killstreaktype);
            activeeventname = "reward_active";
            if (isdefined(weapon)) {
                neweventname = weapon.name + "_active";
                if (scoreevents::isregisteredevent(neweventname)) {
                    activeeventname = neweventname;
                }
            }
        }
    }
}

/#

    // Namespace globallogic_score
    // Params 0, eflags: 0x0
    // Checksum 0x99f17d4d, Offset: 0x23b0
    // Size: 0xbd
    function setplayermomentumdebug() {
        setdvar("<dev string:x96>", 0);
        while (true) {
            wait 1;
            momentumpercent = getdvarfloat("<dev string:x96>", 0);
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
// Params 4, eflags: 0x0
// Checksum 0x64fc7bd0, Offset: 0x2478
// Size: 0x59
function giveteamscore(event, team, player, victim) {
    if (level.overrideteamscore) {
        return;
    }
    pixbeginevent("level.onTeamScore");
    InvalidOpCode(0x54, "teamScores", team);
    // Unknown operator (0x54, t7_1b, PC)
}

// Namespace globallogic_score
// Params 2, eflags: 0x0
// Checksum 0xe73ee183, Offset: 0x2570
// Size: 0x29
function giveteamscoreforobjective_delaypostprocessing(team, score) {
    InvalidOpCode(0x54, "teamScores", team);
    // Unknown operator (0x54, t7_1b, PC)
}

// Namespace globallogic_score
// Params 1, eflags: 0x0
// Checksum 0xb84cea79, Offset: 0x2610
// Size: 0x82
function postprocessteamscores(teams) {
    foreach (team in teams) {
        onteamscore_postprocess(team);
    }
    thread globallogic::checkscorelimit();
    thread globallogic::checkroundscorelimit();
}

// Namespace globallogic_score
// Params 2, eflags: 0x0
// Checksum 0x3992a5c5, Offset: 0x26a0
// Size: 0x39
function giveteamscoreforobjective(team, score) {
    if (!isdefined(level.teams[team])) {
        return;
    }
    InvalidOpCode(0x54, "teamScores", team);
    // Unknown operator (0x54, t7_1b, PC)
}

// Namespace globallogic_score
// Params 2, eflags: 0x0
// Checksum 0x40b8efd3, Offset: 0x2780
// Size: 0x1d
function _setteamscore(team, teamscore) {
    InvalidOpCode(0x54, "teamScores", team, teamscore);
    // Unknown operator (0x54, t7_1b, PC)
}

// Namespace globallogic_score
// Params 0, eflags: 0x0
// Checksum 0xbca744e3, Offset: 0x2810
// Size: 0x8a
function resetteamscores() {
    if (level.scoreroundwinbased || util::isfirstround()) {
        var_c3468029 = level.teams;
        var_2af264eb = firstarray(var_c3468029);
        if (isdefined(var_2af264eb)) {
            team = var_c3468029[var_2af264eb];
            var_17e23754 = nextarray(var_c3468029, var_2af264eb);
            InvalidOpCode(0xc8, "teamScores", team, 0);
            // Unknown operator (0xc8, t7_1b, PC)
        }
    }
    updateallteamscores();
}

// Namespace globallogic_score
// Params 0, eflags: 0x0
// Checksum 0x117cac78, Offset: 0x28a8
// Size: 0x32
function resetallscores() {
    resetteamscores();
    resetplayerscores();
    teamops::function_2f0859a2();
}

// Namespace globallogic_score
// Params 0, eflags: 0x0
// Checksum 0xf9df394c, Offset: 0x28e8
// Size: 0x79
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
// Params 1, eflags: 0x0
// Checksum 0x2f62de1c, Offset: 0x2970
// Size: 0x15
function updateteamscores(team) {
    InvalidOpCode(0x54, "teamScores", team);
    // Unknown operator (0x54, t7_1b, PC)
}

// Namespace globallogic_score
// Params 0, eflags: 0x0
// Checksum 0xb402c48e, Offset: 0x29b8
// Size: 0x63
function updateallteamscores() {
    foreach (team in level.teams) {
        updateteamscores(team);
    }
}

// Namespace globallogic_score
// Params 1, eflags: 0x0
// Checksum 0x8877d233, Offset: 0x2a28
// Size: 0x11
function _getteamscore(team) {
    InvalidOpCode(0x54, "teamScores", team);
    // Unknown operator (0x54, t7_1b, PC)
}

// Namespace globallogic_score
// Params 0, eflags: 0x0
// Checksum 0xeab98376, Offset: 0x2a48
// Size: 0xa3
function gethighestteamscoreteam() {
    score = 0;
    winning_teams = [];
    var_6c86d235 = level.teams;
    var_60c3b533 = firstarray(var_6c86d235);
    if (isdefined(var_60c3b533)) {
        team = var_6c86d235[var_60c3b533];
        var_7d840da8 = nextarray(var_6c86d235, var_60c3b533);
        InvalidOpCode(0x54, "teamScores", team);
        // Unknown operator (0x54, t7_1b, PC)
    }
    return winning_teams;
}

// Namespace globallogic_score
// Params 2, eflags: 0x0
// Checksum 0x40ffb50, Offset: 0x2af8
// Size: 0x77
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
// Params 2, eflags: 0x0
// Checksum 0x25478471, Offset: 0x2b78
// Size: 0x32
function onteamscore(score, team) {
    onteamscore_incrementscore(score, team);
    onteamscore_postprocess(team);
}

// Namespace globallogic_score
// Params 2, eflags: 0x0
// Checksum 0xadf43861, Offset: 0x2bb8
// Size: 0x19
function onteamscore_incrementscore(score, team) {
    InvalidOpCode(0x54, "teamScores", team);
    // Unknown operator (0x54, t7_1b, PC)
}

// Namespace globallogic_score
// Params 1, eflags: 0x0
// Checksum 0xed1285ba, Offset: 0x2c90
// Size: 0x1b6
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
                    continue;
                }
            }
            globallogic_audio::leader_dialog("lead_taken", team, undefined, "status");
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
                    continue;
                }
            }
            globallogic_audio::leader_dialog("lead_lost", team, undefined, "status");
        }
    }
    level.waswinning = iswinning;
}

// Namespace globallogic_score
// Params 2, eflags: 0x0
// Checksum 0x964641bb, Offset: 0x2e50
// Size: 0x52
function default_onteamscore(event, team) {
    score = rank::getscoreinfovalue(event);
    assert(isdefined(score));
    onteamscore(score, team);
}

// Namespace globallogic_score
// Params 2, eflags: 0x0
// Checksum 0x9e475475, Offset: 0x2eb0
// Size: 0x62
function initpersstat(dataname, record_stats) {
    if (!isdefined(self.pers[dataname])) {
        self.pers[dataname] = 0;
    }
    if (!isdefined(record_stats) || record_stats == 1) {
        recordplayerstats(self, dataname, int(self.pers[dataname]));
    }
}

// Namespace globallogic_score
// Params 1, eflags: 0x0
// Checksum 0xb7932990, Offset: 0x2f20
// Size: 0x12
function getpersstat(dataname) {
    return self.pers[dataname];
}

// Namespace globallogic_score
// Params 4, eflags: 0x0
// Checksum 0x37edb470, Offset: 0x2f40
// Size: 0xba
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
// Params 1, eflags: 0x0
// Checksum 0xfe750f51, Offset: 0x3008
// Size: 0x32
function threadedrecordplayerstats(dataname) {
    self endon(#"disconnect");
    waittillframeend();
    recordplayerstats(self, dataname, self.pers[dataname]);
}

// Namespace globallogic_score
// Params 1, eflags: 0x0
// Checksum 0x145f5791, Offset: 0x3048
// Size: 0x1fa
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
    if (bot::is_bot_ranked_match()) {
        combattrainingwins = winner getdstat("combatTrainingWins");
        winner setdstat("combatTrainingWins", combattrainingwins + 1);
    }
}

// Namespace globallogic_score
// Params 1, eflags: 0x0
// Checksum 0xd960efee, Offset: 0x3250
// Size: 0x54
function updatelossstats(loser) {
    loser addplayerstatwithgametype("losses", 1);
    loser updatestatratio("wlratio", "wins", "losses");
    loser notify(#"loss");
}

// Namespace globallogic_score
// Params 1, eflags: 0x0
// Checksum 0xa95eceb1, Offset: 0x32b0
// Size: 0x9c
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
// Checksum 0x9c55ae2c, Offset: 0x3358
// Size: 0x289
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
// Params 0, eflags: 0x0
// Checksum 0x3b5cd4c4, Offset: 0x35f0
// Size: 0xaa
function backupandclearwinstreaks() {
    self.pers["winStreak"] = self getdstat("playerstatslist", "cur_win_streak", "StatValue");
    if (!level.disablestattracking) {
        self setdstat("playerstatslist", "cur_win_streak", "StatValue", 0);
    }
    self.pers["winStreakForGametype"] = persistence::function_2369852e("cur_win_streak");
    self persistence::function_e885624a("cur_win_streak", 0);
}

// Namespace globallogic_score
// Params 1, eflags: 0x0
// Checksum 0xaef19f2b, Offset: 0x36a8
// Size: 0x72
function restorewinstreaks(winner) {
    if (!level.disablestattracking) {
        winner setdstat("playerstatslist", "cur_win_streak", "StatValue", winner.pers["winStreak"]);
    }
    winner persistence::function_e885624a("cur_win_streak", winner.pers["winStreakForGametype"]);
}

// Namespace globallogic_score
// Params 1, eflags: 0x0
// Checksum 0xfbf2490, Offset: 0x3728
// Size: 0x63
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
// Params 5, eflags: 0x0
// Checksum 0xd03f4fc6, Offset: 0x3798
// Size: 0x302
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
// Params 5, eflags: 0x0
// Checksum 0x480b6d5b, Offset: 0x3aa8
// Size: 0x2ba
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
    selfkillstowardsattacker = 0;
    if (isdefined(self.pers["killed_players"][attackername])) {
        selfkillstowardsattacker = self.pers["killed_players"][attackername];
    }
    self luinotifyevent(%track_victim_death, 2, self.pers["killed_by"][attackername], selfkillstowardsattacker);
    pixendevent();
}

// Namespace globallogic_score
// Params 0, eflags: 0x0
// Checksum 0x1a98afb5, Offset: 0x3d70
// Size: 0x3
function default_iskillboosting() {
    return false;
}

// Namespace globallogic_score
// Params 3, eflags: 0x0
// Checksum 0x59b36552, Offset: 0x3d80
// Size: 0x162
function givekillstats(smeansofdeath, weapon, evictim) {
    self endon(#"disconnect");
    waittillframeend();
    if (level.rankedmatch && self [[ level.iskillboosting ]]()) {
        /#
            self iprintlnbold("<dev string:xa9>");
        #/
        return;
    }
    pixbeginevent("giveKillStats");
    self incpersstat("kills", 1, 1, 1);
    self.kills = self getpersstat("kills");
    self updatestatratio("kdratio", "kills", "deaths");
    attacker = self;
    if (smeansofdeath == "MOD_HEAD_SHOT" && !killstreaks::is_killstreak_weapon(weapon)) {
        attacker thread incpersstat("headshots", 1, 1, 0);
        attacker.headshots = attacker.pers["headshots"];
        if (isdefined(evictim)) {
            evictim recordkillmodifier("headshot");
        }
    }
    pixendevent();
}

// Namespace globallogic_score
// Params 1, eflags: 0x0
// Checksum 0x93c2f067, Offset: 0x3ef0
// Size: 0x39
function inctotalkills(team) {
    if (level.teambased && isdefined(level.teams[team])) {
        InvalidOpCode(0xc8, "totalKillsTeam", team);
        // Unknown operator (0xc8, t7_1b, PC)
    }
    InvalidOpCode(0xc8, "totalKills");
    // Unknown operator (0xc8, t7_1b, PC)
}

// Namespace globallogic_score
// Params 3, eflags: 0x0
// Checksum 0xaefacc6d, Offset: 0x3f38
// Size: 0x152
function setinflictorstat(einflictor, eattacker, weapon) {
    if (!isdefined(eattacker)) {
        return;
    }
    if (!isdefined(einflictor)) {
        eattacker addweaponstat(weapon, "hits", 1, eattacker.class_num, weapon.ispickedup);
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
        eattacker addweaponstat(weapon, "hits", 1, eattacker.class_num, weapon.ispickedup);
    }
}

// Namespace globallogic_score
// Params 1, eflags: 0x0
// Checksum 0x6da79a81, Offset: 0x4098
// Size: 0xda
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
    scoreevents::processscoreevent("shield_assist", self, killedplayer, "riotshield");
}

// Namespace globallogic_score
// Params 3, eflags: 0x0
// Checksum 0x97946555, Offset: 0x4180
// Size: 0x20a
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
    if (isdefined(weapon)) {
        self addweaponstat(weapon, "assists", 1, self.class_num, weapon.ispickedup);
    }
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
    scoreevents::processscoreevent(assist_level, self, killedplayer, weapon);
}

// Namespace globallogic_score
// Params 3, eflags: 0x0
// Checksum 0x97b16b85, Offset: 0x4398
// Size: 0x3c3
function processkillstreakassists(attacker, inflictor, weapon) {
    if (!isdefined(attacker) || !isdefined(attacker.team) || self util::isenemyplayer(attacker) == 0) {
        return;
    }
    if (attacker.classname == "trigger_hurt" || self == attacker || attacker.classname == "worldspawn") {
        return;
    }
    enemycuavactive = 0;
    if (attacker hasperk("specialty_immunecounteruav") == 0) {
        foreach (team in level.teams) {
            if (team == attacker.team) {
                continue;
            }
            if (counteruav::teamhasactivecounteruav(team)) {
                enemycuavactive = 1;
            }
        }
    }
    foreach (player in level.players) {
        if (player.team != attacker.team) {
            continue;
        }
        if (player.team == "spectator") {
            continue;
        }
        if (player == attacker) {
            continue;
        }
        if (player.sessionstate != "playing") {
            continue;
        }
        assert(isdefined(level.activeplayercounteruavs[player.entnum]));
        assert(isdefined(level.activeplayeruavs[player.entnum]));
        assert(isdefined(level.activeplayersatellites[player.entnum]));
        is_killstreak_weapon = killstreaks::is_killstreak_weapon(weapon);
        if (level.activeplayercounteruavs[player.entnum] > 0 && !is_killstreak_weapon) {
            scoregiven = scoreevents::processscoreevent("counter_uav_assist", player);
            if (isdefined(scoregiven)) {
                player challenges::earnedcuavassistscore(scoregiven);
            }
        }
        if (enemycuavactive == 0) {
            activeuav = level.activeplayeruavs[player.entnum];
            if (level.forceradar == 1) {
                activeuav--;
            }
            if (activeuav > 0 && !is_killstreak_weapon) {
                scoregiven = scoreevents::processscoreevent("uav_assist", player);
                if (isdefined(scoregiven)) {
                    player challenges::earneduavassistscore(scoregiven);
                }
            }
            if (level.activeplayersatellites[player.entnum] > 0 && !is_killstreak_weapon) {
                scoregiven = scoreevents::processscoreevent("satellite_assist", player);
                if (isdefined(scoregiven)) {
                    player challenges::earnedsatelliteassistscore(scoregiven);
                }
            }
        }
        if (player emp::hasactiveemp()) {
            scoregiven = scoreevents::processscoreevent("emp_assist", player);
            if (isdefined(scoregiven)) {
                player challenges::earnedempassistscore(scoregiven);
            }
        }
    }
}

/#

    // Namespace globallogic_score
    // Params 0, eflags: 0x0
    // Checksum 0x8d852c16, Offset: 0x4768
    // Size: 0xbd
    function function_4e01d1c3() {
        self endon(#"death");
        self endon(#"disconnect");
        level endon(#"game_ended");
        while (level.inprematchperiod) {
            wait 0.05;
        }
        for (;;) {
            wait 5;
            if (isdefined(level.teams[level.players[0].pers["<dev string:xf0>"]])) {
                self rank::giverankxp("<dev string:xf5>", int(min(getdvarint("<dev string:xfa>"), 50)));
            }
        }
    }

#/
