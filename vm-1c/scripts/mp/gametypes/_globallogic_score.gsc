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
// Checksum 0x2301ee7e, Offset: 0xc08
// Size: 0x884
function updatematchbonusscores(winner) {
    if (!game["timepassed"]) {
        return;
    }
    if (!level.rankedmatch) {
        updatecustomgamewinner(winner);
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
            } else if (isdefined(player.pers["team"]) && player.pers["team"] == winningteam) {
                playerscore = int(winnerscale * gamelength / 60 * spm * totaltimeplayed / gamelength);
                player thread givematchbonus("win", playerscore);
                player.matchbonus = playerscore;
            } else if (isdefined(player.pers["team"]) && player.pers["team"] != "spectator") {
                playerscore = int(loserscale * gamelength / 60 * spm * totaltimeplayed / gamelength);
                player thread givematchbonus("loss", playerscore);
                player.matchbonus = playerscore;
            }
            player.pers["totalMatchBonus"] = player.pers["totalMatchBonus"] + player.matchbonus;
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
        } else {
            playerscore = int(loserscale * gamelength / 60 * spm * totaltimeplayed / gamelength);
            player thread givematchbonus("loss", playerscore);
            player.matchbonus = playerscore;
        }
        player.pers["totalMatchBonus"] = player.pers["totalMatchBonus"] + player.matchbonus;
    }
}

// Namespace globallogic_score
// Params 1, eflags: 0x0
// Checksum 0x35f6ccf8, Offset: 0x1498
// Size: 0x24e
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
        } else {
            iswinner = 0;
            for (pidx = 0; pidx < min(level.placement["all"].size, 3); pidx++) {
                if (level.placement["all"][pidx] != player) {
                    continue;
                }
                iswinner = 1;
            }
            if (iswinner) {
                player.pers["victory"] = 2;
            } else {
                player.pers["victory"] = 0;
            }
        }
        player.victory = player.pers["victory"];
        player.pers["sbtimeplayed"] = player.timeplayed["total"];
        player.sbtimeplayed = player.pers["sbtimeplayed"];
    }
}

// Namespace globallogic_score
// Params 2, eflags: 0x0
// Checksum 0x591c7bf6, Offset: 0x16f0
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
// Params 0, eflags: 0x0
// Checksum 0x79fd6ede, Offset: 0x1778
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
// Params 1, eflags: 0x0
// Checksum 0x6052b42e, Offset: 0x18c0
// Size: 0x3c
function resetplayerscorechainandmomentum(player) {
    player thread _setplayermomentum(self, 0);
    player thread resetscorechain();
}

// Namespace globallogic_score
// Params 0, eflags: 0x0
// Checksum 0x505c0e23, Offset: 0x1908
// Size: 0x28
function resetscorechain() {
    self notify(#"reset_score_chain");
    self.scorechain = 0;
    self.rankupdatetotal = 0;
}

// Namespace globallogic_score
// Params 0, eflags: 0x0
// Checksum 0xacd38bbb, Offset: 0x1938
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
// Params 1, eflags: 0x0
// Checksum 0xfaf43337, Offset: 0x19a0
// Size: 0x54
function roundtonearestfive(score) {
    rounding = score % 5;
    if (rounding <= 2) {
        return (score - rounding);
    }
    return score + 5 - rounding;
}

// Namespace globallogic_score
// Params 6, eflags: 0x0
// Checksum 0x68ba9a7f, Offset: 0x1a00
// Size: 0x17c
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
// Checksum 0xcc1c2582, Offset: 0x1b88
// Size: 0x4c
function resetplayermomentumonspawn() {
    if (isdefined(level.usingscorestreaks) && level.usingscorestreaks) {
        _setplayermomentum(self, 0);
        self thread resetscorechain();
    }
}

// Namespace globallogic_score
// Params 5, eflags: 0x0
// Checksum 0x5ba29951, Offset: 0x1be0
// Size: 0x254
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
// Checksum 0x564c7b6a, Offset: 0x1e40
// Size: 0x4f0
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
    player util::player_contract_event("score", scorediff);
    if (isdefined(weapon) && killstreaks::is_killstreak_weapon(weapon)) {
        killstreak = killstreaks::get_from_weapon(weapon);
        killstreakpurchased = 0;
        if (isdefined(killstreak) && isdefined(level.killstreaks[killstreak])) {
            killstreakpurchased = player util::is_item_purchased(level.killstreaks[killstreak].menuname);
        }
        player util::player_contract_event("killstreak_score", scorediff, killstreakpurchased);
    }
    pixendevent();
    return scorediff;
}

// Namespace globallogic_score
// Params 3, eflags: 0x0
// Checksum 0x824153f4, Offset: 0x2338
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
// Params 2, eflags: 0x0
// Checksum 0x8408de43, Offset: 0x23f8
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
        player thread wager::function_40cb89b3();
    }
}

// Namespace globallogic_score
// Params 1, eflags: 0x0
// Checksum 0xc9e31e39, Offset: 0x2500
// Size: 0x20
function _getplayerscore(player) {
    return player.pers["score"];
}

// Namespace globallogic_score
// Params 0, eflags: 0x0
// Checksum 0xd6e5b5c1, Offset: 0x2528
// Size: 0x176
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
// Checksum 0xa47bc6d8, Offset: 0x26a8
// Size: 0xb4
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
// Checksum 0x70e1daa8, Offset: 0x2768
// Size: 0x3c
function givepointstowin(points) {
    self setpointstowin(self.pers["pointstowin"] + points);
}

// Namespace globallogic_score
// Params 3, eflags: 0x0
// Checksum 0x44a66955, Offset: 0x27b0
// Size: 0x2b0
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
        }
    }
    player.pers["momentum"] = momentum;
    player.momentum = player.pers["momentum"];
}

// Namespace globallogic_score
// Params 4, eflags: 0x0
// Checksum 0x3589ff57, Offset: 0x2a68
// Size: 0x51a
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
                    old_killstreak_quantity = player killstreaks::get_killstreak_quantity(weapon);
                    new_killstreak_quantity = player killstreaks::change_killstreak_quantity(weapon, 1);
                    was_already_at_max_stacking = new_killstreak_quantity == old_killstreak_quantity;
                    if (!was_already_at_max_stacking) {
                        player challenges::earnedkillstreak();
                        if (player ability_util::gadget_is_active(15)) {
                            scoreevents::processscoreevent("focus_earn_scorestreak", player);
                            player scoreevents::specialistmedalachievement();
                            player scoreevents::specialiststatabilityusage(4, 1);
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
                    }
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
    // Checksum 0xd7f27887, Offset: 0x2f90
    // Size: 0xf0
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
// Checksum 0xd2f48a3d, Offset: 0x3088
// Size: 0x134
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
    thread globallogic::checkroundscorelimit();
}

// Namespace globallogic_score
// Params 2, eflags: 0x0
// Checksum 0x1389be53, Offset: 0x31c8
// Size: 0xc4
function giveteamscoreforobjective_delaypostprocessing(team, score) {
    teamscore = game["teamScores"][team];
    onteamscore_incrementscore(score, team);
    newscore = game["teamScores"][team];
    bbprint("mpteamobjscores", "gametime %d  team %d diff %d score %d", gettime(), team, newscore - teamscore, newscore);
    if (teamscore == newscore) {
        return;
    }
    updateteamscores(team);
}

// Namespace globallogic_score
// Params 1, eflags: 0x0
// Checksum 0xe13a98a6, Offset: 0x3298
// Size: 0xb4
function postprocessteamscores(teams) {
    foreach (team in teams) {
        onteamscore_postprocess(team);
    }
    thread globallogic::checkscorelimit();
    thread globallogic::checkroundscorelimit();
}

// Namespace globallogic_score
// Params 2, eflags: 0x0
// Checksum 0x35abef94, Offset: 0x3358
// Size: 0x114
function giveteamscoreforobjective(team, score) {
    if (!isdefined(level.teams[team])) {
        return;
    }
    teamscore = game["teamScores"][team];
    onteamscore(score, team);
    newscore = game["teamScores"][team];
    bbprint("mpteamobjscores", "gametime %d  team %d diff %d score %d", gettime(), team, newscore - teamscore, newscore);
    if (teamscore == newscore) {
        return;
    }
    updateteamscores(team);
    thread globallogic::checkscorelimit();
    thread globallogic::checkroundscorelimit();
    thread globallogic::checksuddendeathscorelimit(team);
}

// Namespace globallogic_score
// Params 2, eflags: 0x0
// Checksum 0xd6b841eb, Offset: 0x3478
// Size: 0x9c
function _setteamscore(team, teamscore) {
    if (teamscore == game["teamScores"][team]) {
        return;
    }
    game["teamScores"][team] = math::clamp(teamscore, 0, 1000000);
    updateteamscores(team);
    thread globallogic::checkscorelimit();
    thread globallogic::checkroundscorelimit();
}

// Namespace globallogic_score
// Params 0, eflags: 0x0
// Checksum 0x19206d6e, Offset: 0x3520
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
// Checksum 0x1707ab2c, Offset: 0x35e8
// Size: 0x34
function resetallscores() {
    resetteamscores();
    resetplayerscores();
    teamops::function_2f0859a2();
}

// Namespace globallogic_score
// Params 0, eflags: 0x0
// Checksum 0x850ab37c, Offset: 0x3628
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
// Params 1, eflags: 0x0
// Checksum 0xa5beedd4, Offset: 0x36d8
// Size: 0x4c
function updateteamscores(team) {
    setteamscore(team, game["teamScores"][team]);
    level thread globallogic::checkteamscorelimitsoon(team);
}

// Namespace globallogic_score
// Params 0, eflags: 0x0
// Checksum 0xa74bad96, Offset: 0x3730
// Size: 0x8a
function updateallteamscores() {
    foreach (team in level.teams) {
        updateteamscores(team);
    }
}

// Namespace globallogic_score
// Params 1, eflags: 0x0
// Checksum 0x57fd85a9, Offset: 0x37c8
// Size: 0x1c
function _getteamscore(team) {
    return game["teamScores"][team];
}

// Namespace globallogic_score
// Params 0, eflags: 0x0
// Checksum 0x20b3afe0, Offset: 0x37f0
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
// Params 2, eflags: 0x0
// Checksum 0xb480d158, Offset: 0x38f0
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
// Params 2, eflags: 0x0
// Checksum 0x3ffac79e, Offset: 0x39a8
// Size: 0x44
function onteamscore(score, team) {
    onteamscore_incrementscore(score, team);
    onteamscore_postprocess(team);
}

// Namespace globallogic_score
// Params 2, eflags: 0x0
// Checksum 0xafa0a7f0, Offset: 0x39f8
// Size: 0x116
function onteamscore_incrementscore(score, team) {
    game["teamScores"][team] = game["teamScores"][team] + score;
    if (game["teamScores"][team] < 0) {
        game["teamScores"][team] = 0;
    }
    if (level.clampscorelimit) {
        if (level.scorelimit && game["teamScores"][team] > level.scorelimit) {
            game["teamScores"][team] = level.scorelimit;
        }
        if (level.roundscorelimit && game["teamScores"][team] > util::get_current_round_score_limit()) {
            game["teamScores"][team] = util::get_current_round_score_limit();
        }
    }
}

// Namespace globallogic_score
// Params 1, eflags: 0x0
// Checksum 0x803d4c97, Offset: 0x3b18
// Size: 0x250
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
// Checksum 0x564a69, Offset: 0x3d70
// Size: 0x6c
function default_onteamscore(event, team) {
    score = rank::getscoreinfovalue(event);
    assert(isdefined(score));
    onteamscore(score, team);
}

// Namespace globallogic_score
// Params 2, eflags: 0x0
// Checksum 0x5ad7fbfd, Offset: 0x3de8
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
// Params 1, eflags: 0x0
// Checksum 0x19e1760c, Offset: 0x3e80
// Size: 0x18
function getpersstat(dataname) {
    return self.pers[dataname];
}

// Namespace globallogic_score
// Params 4, eflags: 0x0
// Checksum 0xe20732fb, Offset: 0x3ea0
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
// Params 1, eflags: 0x0
// Checksum 0x8e55f1de, Offset: 0x3f98
// Size: 0x3c
function threadedrecordplayerstats(dataname) {
    self endon(#"disconnect");
    waittillframeend();
    recordplayerstats(self, dataname, self.pers[dataname]);
}

// Namespace globallogic_score
// Params 1, eflags: 0x0
// Checksum 0x59a623fc, Offset: 0x3fe0
// Size: 0x2d4
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
    winner.lootxpmultiplier = 1;
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
    updateweaponcontractwin(winner);
    updatecontractwin(winner);
}

// Namespace globallogic_score
// Params 1, eflags: 0x0
// Checksum 0x34ecda24, Offset: 0x42c0
// Size: 0x82
function canupdateweaponcontractstats(player) {
    if (getdvarint("enable_weapon_contract", 0) == 0) {
        return false;
    }
    if (!level.rankedmatch && !level.arenamatch) {
        return false;
    }
    if (player getdstat("contracts", 3, "index") != 0) {
        return false;
    }
    return true;
}

// Namespace globallogic_score
// Params 1, eflags: 0x0
// Checksum 0xe11d7e31, Offset: 0x4350
// Size: 0x84
function updateweaponcontractstart(player) {
    if (!canupdateweaponcontractstats(player)) {
        return;
    }
    if (player getdstat("weaponContractData", "startTimestamp") == 0) {
        player setdstat("weaponContractData", "startTimestamp", getutc());
    }
}

// Namespace globallogic_score
// Params 1, eflags: 0x0
// Checksum 0x391df0ec, Offset: 0x43e0
// Size: 0x14c
function updateweaponcontractwin(winner) {
    if (!canupdateweaponcontractstats(winner)) {
        return;
    }
    matcheswon = winner getdstat("weaponContractData", "currentValue") + 1;
    winner setdstat("weaponContractData", "currentValue", matcheswon);
    if ((isdefined(winner getdstat("weaponContractData", "completeTimestamp")) ? winner getdstat("weaponContractData", "completeTimestamp") : 0) == 0) {
        targetvalue = getdvarint("weapon_contract_target_value", 100);
        if (matcheswon >= targetvalue) {
            winner setdstat("weaponContractData", "completeTimestamp", getutc());
        }
    }
}

// Namespace globallogic_score
// Params 0, eflags: 0x0
// Checksum 0x53ef8a3b, Offset: 0x4538
// Size: 0x11a
function updateweaponcontractplayed() {
    foreach (player in level.players) {
        if (!isdefined(player)) {
            continue;
        }
        if (!canupdateweaponcontractstats(player)) {
            continue;
        }
        if (!isdefined(player.pers["team"])) {
            continue;
        }
        matchesplayed = player getdstat("weaponContractData", "matchesPlayed") + 1;
        player setdstat("weaponContractData", "matchesPlayed", matchesplayed);
    }
}

// Namespace globallogic_score
// Params 1, eflags: 0x0
// Checksum 0x2287e38, Offset: 0x4660
// Size: 0xaa
function updatecontractwin(winner) {
    if (!isdefined(level.updatecontractwinevents)) {
        return;
    }
    foreach (contractwinevent in level.updatecontractwinevents) {
        if (!isdefined(contractwinevent)) {
            continue;
        }
        [[ contractwinevent ]](winner);
    }
}

// Namespace globallogic_score
// Params 1, eflags: 0x0
// Checksum 0xf8286310, Offset: 0x4718
// Size: 0x92
function registercontractwinevent(event) {
    if (!isdefined(level.updatecontractwinevents)) {
        level.updatecontractwinevents = [];
    }
    if (!isdefined(level.updatecontractwinevents)) {
        level.updatecontractwinevents = [];
    } else if (!isarray(level.updatecontractwinevents)) {
        level.updatecontractwinevents = array(level.updatecontractwinevents);
    }
    level.updatecontractwinevents[level.updatecontractwinevents.size] = event;
}

// Namespace globallogic_score
// Params 1, eflags: 0x0
// Checksum 0xf08648e5, Offset: 0x47b8
// Size: 0x6c
function updatelossstats(loser) {
    loser addplayerstatwithgametype("losses", 1);
    loser updatestatratio("wlratio", "wins", "losses");
    loser notify(#"loss");
}

// Namespace globallogic_score
// Params 1, eflags: 0x0
// Checksum 0xe7a0b2db, Offset: 0x4830
// Size: 0x7c
function updatelosslatejoinstats(loser) {
    loser addplayerstatwithgametype("losses", -1);
    loser addplayerstatwithgametype("losses_late_join", 1);
    loser updatestatratio("wlratio", "wins", "losses");
}

// Namespace globallogic_score
// Params 1, eflags: 0x0
// Checksum 0x993d6a49, Offset: 0x48b8
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
// Checksum 0xaf1c0937, Offset: 0x4988
// Size: 0x4b6
function updatewinlossstats(winner) {
    if (!util::waslastround() && !level.hostforcedend) {
        return;
    }
    players = level.players;
    updateweaponcontractplayed();
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
            for (i = 0; i < players.size; i++) {
                if (winner == players[i]) {
                    continue;
                }
                for (index = 1; index < topthreeplayers; index++) {
                    if (players[i] == placement[index]) {
                        break;
                    }
                }
                if (index < topthreeplayers) {
                    continue;
                }
                if (level.rankedmatch && !level.leaguematch && players[i].pers["lateJoin"] === 1) {
                    updatelosslatejoinstats(players[i]);
                }
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
        if (level.rankedmatch && !level.leaguematch && players[i].pers["lateJoin"] === 1) {
            updatelosslatejoinstats(players[i]);
        }
        if (!level.disablestattracking) {
            players[i] setdstat("playerstatslist", "cur_win_streak", "StatValue", 0);
        }
    }
}

// Namespace globallogic_score
// Params 0, eflags: 0x0
// Checksum 0xc06f6714, Offset: 0x4e48
// Size: 0xe4
function backupandclearwinstreaks() {
    if (isdefined(level.freerun) && level.freerun) {
        return;
    }
    self.pers["winStreak"] = self getdstat("playerstatslist", "cur_win_streak", "StatValue");
    if (!level.disablestattracking) {
        self setdstat("playerstatslist", "cur_win_streak", "StatValue", 0);
    }
    self.pers["winStreakForGametype"] = persistence::function_2369852e("cur_win_streak");
    self persistence::function_e885624a("cur_win_streak", 0);
}

// Namespace globallogic_score
// Params 1, eflags: 0x0
// Checksum 0xda2d09cc, Offset: 0x4f38
// Size: 0x84
function restorewinstreaks(winner) {
    if (!level.disablestattracking) {
        winner setdstat("playerstatslist", "cur_win_streak", "StatValue", winner.pers["winStreak"]);
    }
    winner persistence::function_e885624a("cur_win_streak", winner.pers["winStreakForGametype"]);
}

// Namespace globallogic_score
// Params 1, eflags: 0x0
// Checksum 0x63bbeacd, Offset: 0x4fc8
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
// Params 6, eflags: 0x0
// Checksum 0x6f5441ef, Offset: 0x5048
// Size: 0x4bc
function trackattackerkill(name, rank, xp, prestige, xuid, weapon) {
    self endon(#"disconnect");
    attacker = self;
    waittillframeend();
    pixbeginevent("trackAttackerKill");
    if (!isdefined(attacker.pers["killed_players"][name])) {
        attacker.pers["killed_players"][name] = 0;
    }
    if (!isdefined(attacker.pers["killed_players_with_specialist"][name])) {
        attacker.pers["killed_players_with_specialist"][name] = 0;
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
    if (isdefined(weapon.isheroweapon) && weapon.isheroweapon == 1) {
        attacker.pers["killed_players_with_specialist"][name]++;
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
// Checksum 0xfc629224, Offset: 0x5510
// Size: 0x364
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
// Checksum 0xeeb93987, Offset: 0x5880
// Size: 0x6
function default_iskillboosting() {
    return false;
}

// Namespace globallogic_score
// Params 3, eflags: 0x0
// Checksum 0xfdaecde7, Offset: 0x5890
// Size: 0x1cc
function givekillstats(smeansofdeath, weapon, evictim) {
    self endon(#"disconnect");
    self.kills += 1;
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
// Checksum 0x252cf0c7, Offset: 0x5a68
// Size: 0x4c
function inctotalkills(team) {
    if (level.teambased && isdefined(level.teams[team])) {
        game["totalKillsTeam"][team]++;
    }
    game["totalKills"]++;
}

// Namespace globallogic_score
// Params 3, eflags: 0x0
// Checksum 0x4cefd3aa, Offset: 0x5ac0
// Size: 0x1ec
function setinflictorstat(einflictor, eattacker, weapon) {
    if (!isdefined(eattacker)) {
        return;
    }
    weaponpickedup = 0;
    if (isdefined(eattacker.pickedupweapons) && isdefined(eattacker.pickedupweapons[weapon])) {
        weaponpickedup = 1;
    }
    if (!isdefined(einflictor)) {
        eattacker addweaponstat(weapon, "hits", 1, eattacker.class_num, weaponpickedup);
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
        if (weapon.rootweapon.name == "tabun_gas") {
            eattacker addweaponstat(weapon, "used", 1);
        }
        eattacker addweaponstat(weapon, "hits", 1, eattacker.class_num, weaponpickedup);
    }
}

// Namespace globallogic_score
// Params 1, eflags: 0x0
// Checksum 0x4ab30f21, Offset: 0x5cb8
// Size: 0x10c
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
// Checksum 0xa0959909, Offset: 0x5dd0
// Size: 0x2c4
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
        weaponpickedup = 0;
        if (isdefined(self.pickedupweapons) && isdefined(self.pickedupweapons[weapon])) {
            weaponpickedup = 1;
        }
        self addweaponstat(weapon, "assists", 1, self.class_num, weaponpickedup);
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
// Checksum 0xd89daa3c, Offset: 0x60a0
// Size: 0x64a
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
                killstreakindex = level.killstreakindices["killstreak_counteruav"];
                killstreaks::killstreak_assist(player, self, killstreakindex);
                player function_bfe18d92("counteruav", scoregiven);
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
                    killstreakindex = level.killstreakindices["killstreak_uav"];
                    killstreaks::killstreak_assist(player, self, killstreakindex);
                    player function_bfe18d92("uav", scoregiven);
                }
            }
            if (level.activeplayersatellites[player.entnum] > 0 && !is_killstreak_weapon) {
                scoregiven = scoreevents::processscoreevent("satellite_assist", player);
                if (isdefined(scoregiven)) {
                    player challenges::earnedsatelliteassistscore(scoregiven);
                    killstreakindex = level.killstreakindices["killstreak_satellite"];
                    killstreaks::killstreak_assist(player, self, killstreakindex);
                    player function_bfe18d92("satellite", scoregiven);
                }
            }
        }
        if (player emp::hasactiveemp()) {
            scoregiven = scoreevents::processscoreevent("emp_assist", player);
            if (isdefined(scoregiven)) {
                player challenges::earnedempassistscore(scoregiven);
                killstreakindex = level.killstreakindices["killstreak_emp"];
                killstreaks::killstreak_assist(player, self, killstreakindex);
                player function_bfe18d92("emp", scoregiven);
            }
        }
    }
}

// Namespace globallogic_score
// Params 2, eflags: 0x0
// Checksum 0x5e9dfe80, Offset: 0x66f8
// Size: 0xa4
function function_bfe18d92(killstreak, scoregiven) {
    player = self;
    killstreakpurchased = 0;
    if (isdefined(killstreak) && isdefined(level.killstreaks[killstreak])) {
        killstreakpurchased = player util::is_item_purchased(level.killstreaks[killstreak].menuname);
    }
    player util::player_contract_event("killstreak_score", scoregiven, killstreakpurchased);
}

/#

    // Namespace globallogic_score
    // Params 0, eflags: 0x0
    // Checksum 0xe45ed2d1, Offset: 0x67a8
    // Size: 0xd8
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
