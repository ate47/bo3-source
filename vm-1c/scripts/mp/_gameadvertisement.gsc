#using scripts/mp/_util;
#using scripts/mp/gametypes/_globallogic_utils;
#using scripts/mp/gametypes/_dev;
#using scripts/shared/util_shared;
#using scripts/codescripts/struct;

#namespace gameadvertisement;

// Namespace gameadvertisement
// Params 0, eflags: 0x1 linked
// Checksum 0x133c82, Offset: 0x1c0
// Size: 0xbc
function init() {
    /#
        level.sessionadvertstatus = 1;
        thread sessionadvertismentupdatedebughud();
    #/
    level.gameadvertisementrulescorepercent = getgametypesetting("gameAdvertisementRuleScorePercent");
    level.gameadvertisementruletimeleft = 60000 * getgametypesetting("gameAdvertisementRuleTimeLeft");
    level.gameadvertisementruleround = getgametypesetting("gameAdvertisementRuleRound");
    level.gameadvertisementruleroundswon = getgametypesetting("gameAdvertisementRuleRoundsWon");
    thread sessionadvertisementcheck();
}

// Namespace gameadvertisement
// Params 1, eflags: 0x1 linked
// Checksum 0x7eb5c38d, Offset: 0x288
// Size: 0x34
function setadvertisedstatus(onoff) {
    /#
        level.sessionadvertstatus = onoff;
    #/
    changeadvertisedstatus(onoff);
}

// Namespace gameadvertisement
// Params 0, eflags: 0x1 linked
// Checksum 0x6eeb7dd5, Offset: 0x2c8
// Size: 0x10a
function sessionadvertisementcheck() {
    if (sessionmodeisprivate()) {
        return;
    }
    var_561487cd = function_4dc43066();
    if (!isdefined(var_561487cd)) {
        return;
    }
    level endon(#"game_end");
    level waittill(#"prematch_over");
    for (currentadvertisedstatus = undefined; true; currentadvertisedstatus = advertise) {
        sessionadvertcheckwait = getdvarint("sessionAdvertCheckwait", 1);
        wait(sessionadvertcheckwait);
        advertise = [[ var_561487cd ]]();
        if (isdefined(advertise) && (!isdefined(currentadvertisedstatus) || currentadvertisedstatus != advertise)) {
            setadvertisedstatus(advertise);
        }
    }
}

// Namespace gameadvertisement
// Params 0, eflags: 0x1 linked
// Checksum 0xca41a4e3, Offset: 0x3e0
// Size: 0x42
function function_4dc43066() {
    gametype = level.gametype;
    switch (gametype) {
    case 5:
        return &function_b19057a9;
    default:
        return &default_rules;
    }
}

// Namespace gameadvertisement
// Params 2, eflags: 0x1 linked
// Checksum 0xb4bc0d5f, Offset: 0x448
// Size: 0x1bc
function teamscorelimitcheck(rulescorepercent, debug_count) {
    scorelimit = 0;
    if (level.roundscorelimit) {
        scorelimit = util::get_current_round_score_limit();
    } else if (level.scorelimit) {
        scorelimit = level.scorelimit;
    }
    if (scorelimit) {
        minscorepercentageleft = 100;
        foreach (team in level.teams) {
            scorepercentageleft = 100 - game["teamScores"][team] / scorelimit * 100;
            if (minscorepercentageleft > scorepercentageleft) {
                minscorepercentageleft = scorepercentageleft;
            }
            if (rulescorepercent >= scorepercentageleft) {
                /#
                    debug_count = updatedebughud(debug_count, "<unknown string>", int(scorepercentageleft));
                #/
                return false;
            }
        }
        /#
            debug_count = updatedebughud(debug_count, "<unknown string>", int(minscorepercentageleft));
        #/
    }
    return true;
}

// Namespace gameadvertisement
// Params 1, eflags: 0x1 linked
// Checksum 0x320b7bcd, Offset: 0x610
// Size: 0x5e
function timelimitcheck(ruletimeleft) {
    maxtime = level.timelimit;
    if (maxtime != 0) {
        timeleft = globallogic_utils::gettimeremaining();
        if (ruletimeleft >= timeleft) {
            return false;
        }
    }
    return true;
}

// Namespace gameadvertisement
// Params 0, eflags: 0x1 linked
// Checksum 0x3b5cb881, Offset: 0x678
// Size: 0x414
function default_rules() {
    currentround = game["roundsplayed"] + 1;
    debug_count = 1;
    if (level.gameadvertisementrulescorepercent) {
        /#
            debug_count = updatedebughud(debug_count, "<unknown string>", level.gameadvertisementrulescorepercent);
        #/
        if (level.teambased) {
            if (currentround >= level.gameadvertisementruleround - 1) {
                if (teamscorelimitcheck(level.gameadvertisementrulescorepercent, debug_count) == 0) {
                    return false;
                }
                /#
                    debug_count++;
                #/
            }
        } else if (level.scorelimit) {
            highestscore = 0;
            players = getplayers();
            for (i = 0; i < players.size; i++) {
                if (players[i].pointstowin > highestscore) {
                    highestscore = players[i].pointstowin;
                }
            }
            scorepercentageleft = 100 - highestscore / level.scorelimit * 100;
            /#
                debug_count = updatedebughud(debug_count, "<unknown string>", int(scorepercentageleft));
            #/
            if (level.gameadvertisementrulescorepercent >= scorepercentageleft) {
                return false;
            }
        }
    }
    if (level.gameadvertisementruletimeleft && currentround >= level.gameadvertisementruleround - 1) {
        /#
            debug_count = updatedebughud(debug_count, "<unknown string>", level.gameadvertisementruletimeleft / 60000);
        #/
        if (timelimitcheck(level.gameadvertisementruletimeleft) == 0) {
            return false;
        }
    }
    if (level.gameadvertisementruleround) {
        /#
            debug_count = updatedebughud(debug_count, "<unknown string>", level.gameadvertisementruleround);
            debug_count = updatedebughud(debug_count, "<unknown string>", currentround);
        #/
        if (level.gameadvertisementruleround <= currentround) {
            return false;
        }
    }
    if (level.gameadvertisementruleroundswon) {
        /#
            debug_count = updatedebughud(debug_count, "<unknown string>", level.gameadvertisementruleroundswon);
        #/
        maxroundswon = 0;
        foreach (team in level.teams) {
            roundswon = game["teamScores"][team];
            if (maxroundswon < roundswon) {
                maxroundswon = roundswon;
            }
            if (level.gameadvertisementruleroundswon <= roundswon) {
                /#
                    debug_count = updatedebughud(debug_count, "<unknown string>", maxroundswon);
                #/
                return false;
            }
        }
        /#
            debug_count = updatedebughud(debug_count, "<unknown string>", maxroundswon);
        #/
    }
    return true;
}

// Namespace gameadvertisement
// Params 0, eflags: 0x1 linked
// Checksum 0x5df7879, Offset: 0xa98
// Size: 0x188
function function_b19057a9() {
    ruleweaponsleft = 3;
    /#
        updatedebughud(1, "<unknown string>", ruleweaponsleft);
    #/
    minweaponsleft = level.gunprogression.size;
    foreach (player in level.activeplayers) {
        if (!isdefined(player)) {
            continue;
        }
        if (!isdefined(player.gunprogress)) {
            continue;
        }
        weaponsleft = level.gunprogression.size - player.gunprogress;
        if (minweaponsleft > weaponsleft) {
            minweaponsleft = weaponsleft;
        }
        if (ruleweaponsleft >= minweaponsleft) {
            /#
                updatedebughud(3, "<unknown string>", minweaponsleft);
            #/
            return false;
        }
    }
    /#
        updatedebughud(3, "<unknown string>", minweaponsleft);
    #/
    return true;
}

/#

    // Namespace gameadvertisement
    // Params 2, eflags: 0x1 linked
    // Checksum 0x6675cc85, Offset: 0xc28
    // Size: 0x172
    function sessionadvertismentcreatedebughud(linenum, alignx) {
        debug_hud = dev::new_hud("<unknown string>", "<unknown string>", 0, 0, 1);
        debug_hud.hidewheninmenu = 1;
        debug_hud.horzalign = "<unknown string>";
        debug_hud.vertalign = "<unknown string>";
        debug_hud.alignx = "<unknown string>";
        debug_hud.aligny = "<unknown string>";
        debug_hud.x = alignx;
        debug_hud.y = -50 + linenum * 15;
        debug_hud.foreground = 1;
        debug_hud.font = "<unknown string>";
        debug_hud.fontscale = 1.5;
        debug_hud.color = (1, 1, 1);
        debug_hud.alpha = 1;
        debug_hud settext("<unknown string>");
        return debug_hud;
    }

    // Namespace gameadvertisement
    // Params 3, eflags: 0x1 linked
    // Checksum 0x63a72a81, Offset: 0xda8
    // Size: 0xce
    function updatedebughud(hudindex, text, value) {
        switch (hudindex) {
        case 1:
            level.sessionadverthud_1a_text = text;
            level.sessionadverthud_1b_text = value;
            break;
        case 2:
            level.sessionadverthud_2a_text = text;
            level.sessionadverthud_2b_text = value;
            break;
        case 3:
            level.sessionadverthud_3a_text = text;
            level.sessionadverthud_3b_text = value;
            break;
        case 4:
            level.sessionadverthud_4a_text = text;
            level.sessionadverthud_4b_text = value;
            break;
        }
        return hudindex + 1;
    }

    // Namespace gameadvertisement
    // Params 0, eflags: 0x1 linked
    // Checksum 0xbebb20e3, Offset: 0xe80
    // Size: 0x650
    function sessionadvertismentupdatedebughud() {
        level endon(#"game_end");
        sessionadverthud_0 = undefined;
        sessionadverthud_1a = undefined;
        sessionadverthud_1b = undefined;
        sessionadverthud_2a = undefined;
        sessionadverthud_2b = undefined;
        sessionadverthud_3a = undefined;
        sessionadverthud_3b = undefined;
        sessionadverthud_4a = undefined;
        sessionadverthud_4b = undefined;
        level.sessionadverthud_0_text = "<unknown string>";
        level.sessionadverthud_1a_text = "<unknown string>";
        level.sessionadverthud_1b_text = "<unknown string>";
        level.sessionadverthud_2a_text = "<unknown string>";
        level.sessionadverthud_2b_text = "<unknown string>";
        level.sessionadverthud_3a_text = "<unknown string>";
        level.sessionadverthud_3b_text = "<unknown string>";
        level.sessionadverthud_4a_text = "<unknown string>";
        level.sessionadverthud_4b_text = "<unknown string>";
        while (true) {
            wait(1);
            showdebughud = getdvarint("<unknown string>", 0);
            level.sessionadverthud_0_text = "<unknown string>";
            if (level.sessionadvertstatus == 0) {
                level.sessionadverthud_0_text = "<unknown string>";
            }
            if (!isdefined(sessionadverthud_0) && showdebughud != 0) {
                host = util::gethostplayer();
                if (!isdefined(host)) {
                    continue;
                }
                sessionadverthud_0 = host sessionadvertismentcreatedebughud(0, 0);
                sessionadverthud_1a = host sessionadvertismentcreatedebughud(1, -20);
                sessionadverthud_1b = host sessionadvertismentcreatedebughud(1, 0);
                sessionadverthud_2a = host sessionadvertismentcreatedebughud(2, -20);
                sessionadverthud_2b = host sessionadvertismentcreatedebughud(2, 0);
                sessionadverthud_3a = host sessionadvertismentcreatedebughud(3, -20);
                sessionadverthud_3b = host sessionadvertismentcreatedebughud(3, 0);
                sessionadverthud_4a = host sessionadvertismentcreatedebughud(4, -20);
                sessionadverthud_4b = host sessionadvertismentcreatedebughud(4, 0);
                sessionadverthud_1a.color = (0, 0.5, 0);
                sessionadverthud_1b.color = (0, 0.5, 0);
                sessionadverthud_2a.color = (0, 0.5, 0);
                sessionadverthud_2b.color = (0, 0.5, 0);
            }
            if (isdefined(sessionadverthud_0)) {
                if (showdebughud == 0) {
                    sessionadverthud_0 destroy();
                    sessionadverthud_1a destroy();
                    sessionadverthud_1b destroy();
                    sessionadverthud_2a destroy();
                    sessionadverthud_2b destroy();
                    sessionadverthud_3a destroy();
                    sessionadverthud_3b destroy();
                    sessionadverthud_4a destroy();
                    sessionadverthud_4b destroy();
                    sessionadverthud_0 = undefined;
                    sessionadverthud_1a = undefined;
                    sessionadverthud_1b = undefined;
                    sessionadverthud_2a = undefined;
                    sessionadverthud_2b = undefined;
                    sessionadverthud_3a = undefined;
                    sessionadverthud_3b = undefined;
                    sessionadverthud_4a = undefined;
                    sessionadverthud_4b = undefined;
                    continue;
                }
                if (level.sessionadvertstatus == 1) {
                    sessionadverthud_0.color = (1, 1, 1);
                } else {
                    sessionadverthud_0.color = (0.9, 0, 0);
                }
                sessionadverthud_0 settext(level.sessionadverthud_0_text);
                if (level.sessionadverthud_1a_text != "<unknown string>") {
                    sessionadverthud_1a settext(level.sessionadverthud_1a_text);
                    sessionadverthud_1b setvalue(level.sessionadverthud_1b_text);
                }
                if (level.sessionadverthud_2a_text != "<unknown string>") {
                    sessionadverthud_2a settext(level.sessionadverthud_2a_text);
                    sessionadverthud_2b setvalue(level.sessionadverthud_2b_text);
                }
                if (level.sessionadverthud_3a_text != "<unknown string>") {
                    sessionadverthud_3a settext(level.sessionadverthud_3a_text);
                    sessionadverthud_3b setvalue(level.sessionadverthud_3b_text);
                }
                if (level.sessionadverthud_4a_text != "<unknown string>") {
                    sessionadverthud_4a settext(level.sessionadverthud_4a_text);
                    sessionadverthud_4b setvalue(level.sessionadverthud_4b_text);
                }
            }
        }
    }

#/
