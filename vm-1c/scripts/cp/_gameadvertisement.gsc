#using scripts/codescripts/struct;
#using scripts/cp/_util;
#using scripts/cp/gametypes/_dev;
#using scripts/cp/gametypes/_globallogic_utils;
#using scripts/shared/util_shared;

#namespace gameadvertisement;

// Namespace gameadvertisement
// Params 0, eflags: 0x0
// Checksum 0x10cd248e, Offset: 0x178
// Size: 0x34
function init() {
    /#
        level.sessionadvertstatus = 1;
        thread sessionadvertismentupdatedebughud();
    #/
    thread sessionadvertisementcheck();
}

// Namespace gameadvertisement
// Params 1, eflags: 0x0
// Checksum 0xd437bc47, Offset: 0x1b8
// Size: 0x34
function setadvertisedstatus(onoff) {
    /#
        level.sessionadvertstatus = onoff;
    #/
    changeadvertisedstatus(onoff);
}

// Namespace gameadvertisement
// Params 0, eflags: 0x0
// Checksum 0x511b9b37, Offset: 0x1f8
// Size: 0xf8
function sessionadvertisementcheck() {
    if (sessionmodeisprivate()) {
        return;
    }
    if (sessionmodeiszombiesgame()) {
        setadvertisedstatus(0);
        return;
    }
    var_561487cd = function_4dc43066();
    if (!isdefined(var_561487cd)) {
        return;
    }
    level endon(#"game_end");
    level waittill(#"prematch_over");
    while (true) {
        sessionadvertcheckwait = getdvarint("sessionAdvertCheckwait", 1);
        wait sessionadvertcheckwait;
        advertise = [[ var_561487cd ]]();
        setadvertisedstatus(advertise);
    }
}

// Namespace gameadvertisement
// Params 0, eflags: 0x0
// Checksum 0x1253bd6b, Offset: 0x2f8
// Size: 0x162
function function_4dc43066() {
    gametype = level.gametype;
    switch (gametype) {
    case "dm":
        return &function_7937a894;
    case "tdm":
        return &function_c6322b36;
    case "dom":
        return &function_e0b8e3b3;
    case "hq":
        return &function_35ff40ec;
    case "sd":
        return &function_7899d6c8;
    case "dem":
        return &function_9792641;
    case "ctf":
        return &function_6274f19a;
    case "koth":
        return &function_426057b;
    case "conf":
        return &function_575cf307;
    case "oic":
        return &function_421ec2c0;
    case "sas":
        return &function_b3332f74;
    case "gun":
        return &function_b19057a9;
    case "shrp":
        return &function_87f82f26;
    }
}

// Namespace gameadvertisement
// Params 1, eflags: 0x0
// Checksum 0x6d798000, Offset: 0x468
// Size: 0x168
function teamscorelimitcheck(rulescorepercent) {
    if (level.scorelimit) {
        minscorepercentageleft = 100;
        foreach (team in level.teams) {
            scorepercentageleft = 100 - game["teamScores"][team] / level.scorelimit * 100;
            if (minscorepercentageleft > scorepercentageleft) {
                minscorepercentageleft = scorepercentageleft;
            }
            if (rulescorepercent >= scorepercentageleft) {
                /#
                    updatedebughud(3, "<dev string:x28>", int(scorepercentageleft));
                #/
                return false;
            }
        }
        /#
            updatedebughud(3, "<dev string:x28>", int(minscorepercentageleft));
        #/
    }
    return true;
}

// Namespace gameadvertisement
// Params 1, eflags: 0x0
// Checksum 0xe2ce745e, Offset: 0x5d8
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
// Params 0, eflags: 0x0
// Checksum 0x31ed4833, Offset: 0x640
// Size: 0x1b2
function function_7937a894() {
    rulescorepercent = 35;
    ruletimeleft = 60000 * 1.5;
    /#
        updatedebughud(1, "<dev string:x40>", rulescorepercent);
        updatedebughud(2, "<dev string:x6c>", ruletimeleft / 60000);
    #/
    if (level.scorelimit) {
        highestscore = 0;
        players = getplayers();
        for (i = 0; i < players.size; i++) {
            if (players[i].pointstowin > highestscore) {
                highestscore = players[i].pointstowin;
            }
        }
        scorepercentageleft = 100 - highestscore / level.scorelimit * 100;
        /#
            updatedebughud(3, "<dev string:x28>", int(scorepercentageleft));
        #/
        if (rulescorepercent >= scorepercentageleft) {
            return false;
        }
    }
    if (timelimitcheck(ruletimeleft) == 0) {
        return false;
    }
    return true;
}

// Namespace gameadvertisement
// Params 0, eflags: 0x0
// Checksum 0x1f5b7bc1, Offset: 0x800
// Size: 0xca
function function_c6322b36() {
    rulescorepercent = 15;
    ruletimeleft = 60000 * 1.5;
    /#
        updatedebughud(1, "<dev string:x40>", rulescorepercent);
        updatedebughud(2, "<dev string:x6c>", ruletimeleft / 60000);
    #/
    if (teamscorelimitcheck(rulescorepercent) == 0) {
        return false;
    }
    if (timelimitcheck(ruletimeleft) == 0) {
        return false;
    }
    return true;
}

// Namespace gameadvertisement
// Params 0, eflags: 0x0
// Checksum 0x57d0e197, Offset: 0x8d8
// Size: 0x134
function function_e0b8e3b3() {
    rulescorepercent = 15;
    ruletimeleft = 60000 * 1.5;
    var_7af2cd6d = 3;
    currentround = game["roundsplayed"] + 1;
    /#
        updatedebughud(1, "<dev string:x99>", rulescorepercent);
        updatedebughud(2, "<dev string:xf6>", var_7af2cd6d);
        updatedebughud(4, "<dev string:x101>", currentround);
    #/
    if (currentround >= 2) {
        if (teamscorelimitcheck(rulescorepercent) == 0) {
            return false;
        }
    }
    if (timelimitcheck(ruletimeleft) == 0) {
        return false;
    }
    if (var_7af2cd6d <= currentround) {
        return false;
    }
    return true;
}

// Namespace gameadvertisement
// Params 0, eflags: 0x0
// Checksum 0x3f7e9865, Offset: 0xa18
// Size: 0x12
function function_35ff40ec() {
    return function_426057b();
}

// Namespace gameadvertisement
// Params 0, eflags: 0x0
// Checksum 0xe66fcc81, Offset: 0xa38
// Size: 0x158
function function_7899d6c8() {
    var_7af2cd6d = 3;
    /#
        updatedebughud(1, "<dev string:x111>", var_7af2cd6d);
    #/
    maxroundswon = 0;
    foreach (team in level.teams) {
        roundswon = game["teamScores"][team];
        if (maxroundswon < roundswon) {
            maxroundswon = roundswon;
        }
        if (var_7af2cd6d <= roundswon) {
            /#
                updatedebughud(3, "<dev string:x12b>", maxroundswon);
            #/
            return false;
        }
    }
    /#
        updatedebughud(3, "<dev string:x12b>", maxroundswon);
    #/
    return true;
}

// Namespace gameadvertisement
// Params 0, eflags: 0x0
// Checksum 0xd5edeba1, Offset: 0xb98
// Size: 0x12
function function_9792641() {
    return function_6274f19a();
}

// Namespace gameadvertisement
// Params 0, eflags: 0x0
// Checksum 0x9c0dfb6c, Offset: 0xbb8
// Size: 0x8a
function function_6274f19a() {
    var_7af2cd6d = 3;
    roundsplayed = game["roundsplayed"];
    /#
        updatedebughud(1, "<dev string:x13c>", var_7af2cd6d);
        updatedebughud(3, "<dev string:x150>", roundsplayed);
    #/
    if (var_7af2cd6d <= roundsplayed) {
        return false;
    }
    return true;
}

// Namespace gameadvertisement
// Params 0, eflags: 0x0
// Checksum 0x9be80234, Offset: 0xc50
// Size: 0xca
function function_426057b() {
    rulescorepercent = 20;
    ruletimeleft = 60000 * 1.5;
    /#
        updatedebughud(1, "<dev string:x40>", rulescorepercent);
        updatedebughud(2, "<dev string:x6c>", ruletimeleft / 60000);
    #/
    if (teamscorelimitcheck(rulescorepercent) == 0) {
        return false;
    }
    if (timelimitcheck(ruletimeleft) == 0) {
        return false;
    }
    return true;
}

// Namespace gameadvertisement
// Params 0, eflags: 0x0
// Checksum 0x4f1c1de3, Offset: 0xd28
// Size: 0x12
function function_575cf307() {
    return function_c6322b36();
}

// Namespace gameadvertisement
// Params 0, eflags: 0x0
// Checksum 0xd5d19330, Offset: 0xd48
// Size: 0x26
function function_421ec2c0() {
    /#
        updatedebughud(1, "<dev string:x160>", 0);
    #/
    return false;
}

// Namespace gameadvertisement
// Params 0, eflags: 0x0
// Checksum 0x80a22622, Offset: 0xd78
// Size: 0xca
function function_b3332f74() {
    rulescorepercent = 35;
    ruletimeleft = 60000 * 1.5;
    /#
        updatedebughud(1, "<dev string:x40>", rulescorepercent);
        updatedebughud(2, "<dev string:x6c>", ruletimeleft / 60000);
    #/
    if (teamscorelimitcheck(rulescorepercent) == 0) {
        return false;
    }
    if (timelimitcheck(ruletimeleft) == 0) {
        return false;
    }
    return true;
}

// Namespace gameadvertisement
// Params 0, eflags: 0x0
// Checksum 0x5ebf94e, Offset: 0xe50
// Size: 0x168
function function_b19057a9() {
    ruleweaponsleft = 3;
    /#
        updatedebughud(1, "<dev string:x1ba>", ruleweaponsleft);
    #/
    minweaponsleft = level.gunprogression.size;
    foreach (player in level.players) {
        weaponsleft = level.gunprogression.size - player.gunprogress;
        if (minweaponsleft > weaponsleft) {
            minweaponsleft = weaponsleft;
        }
        if (ruleweaponsleft >= minweaponsleft) {
            /#
                updatedebughud(3, "<dev string:x1e8>", minweaponsleft);
            #/
            return false;
        }
    }
    /#
        updatedebughud(3, "<dev string:x1e8>", minweaponsleft);
    #/
    return true;
}

// Namespace gameadvertisement
// Params 0, eflags: 0x0
// Checksum 0x92f00178, Offset: 0xfc0
// Size: 0xca
function function_87f82f26() {
    rulescorepercent = 35;
    ruletimeleft = 60000 * 1.5;
    /#
        updatedebughud(1, "<dev string:x40>", rulescorepercent);
        updatedebughud(2, "<dev string:x6c>", ruletimeleft / 60000);
    #/
    if (teamscorelimitcheck(rulescorepercent) == 0) {
        return false;
    }
    if (timelimitcheck(ruletimeleft) == 0) {
        return false;
    }
    return true;
}

/#

    // Namespace gameadvertisement
    // Params 2, eflags: 0x0
    // Checksum 0xd019c707, Offset: 0x1098
    // Size: 0x172
    function sessionadvertismentcreatedebughud(linenum, alignx) {
        debug_hud = dev::new_hud("<dev string:x1f7>", "<dev string:x206>", 0, 0, 1);
        debug_hud.hidewheninmenu = 1;
        debug_hud.horzalign = "<dev string:x210>";
        debug_hud.vertalign = "<dev string:x216>";
        debug_hud.alignx = "<dev string:x210>";
        debug_hud.aligny = "<dev string:x216>";
        debug_hud.x = alignx;
        debug_hud.y = -50 + linenum * 15;
        debug_hud.foreground = 1;
        debug_hud.font = "<dev string:x21d>";
        debug_hud.fontscale = 1.5;
        debug_hud.color = (1, 1, 1);
        debug_hud.alpha = 1;
        debug_hud settext("<dev string:x225>");
        return debug_hud;
    }

    // Namespace gameadvertisement
    // Params 3, eflags: 0x0
    // Checksum 0x97efe6be, Offset: 0x1218
    // Size: 0xc2
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
    }

    // Namespace gameadvertisement
    // Params 0, eflags: 0x0
    // Checksum 0xae708ae0, Offset: 0x12e8
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
        level.sessionadverthud_0_text = "<dev string:x225>";
        level.sessionadverthud_1a_text = "<dev string:x225>";
        level.sessionadverthud_1b_text = "<dev string:x225>";
        level.sessionadverthud_2a_text = "<dev string:x225>";
        level.sessionadverthud_2b_text = "<dev string:x225>";
        level.sessionadverthud_3a_text = "<dev string:x225>";
        level.sessionadverthud_3b_text = "<dev string:x225>";
        level.sessionadverthud_4a_text = "<dev string:x225>";
        level.sessionadverthud_4b_text = "<dev string:x225>";
        while (true) {
            wait 1;
            showdebughud = getdvarint("<dev string:x226>", 0);
            level.sessionadverthud_0_text = "<dev string:x240>";
            if (level.sessionadvertstatus == 0) {
                level.sessionadverthud_0_text = "<dev string:x256>";
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
                if (level.sessionadverthud_1a_text != "<dev string:x225>") {
                    sessionadverthud_1a settext(level.sessionadverthud_1a_text);
                    sessionadverthud_1b setvalue(level.sessionadverthud_1b_text);
                }
                if (level.sessionadverthud_2a_text != "<dev string:x225>") {
                    sessionadverthud_2a settext(level.sessionadverthud_2a_text);
                    sessionadverthud_2b setvalue(level.sessionadverthud_2b_text);
                }
                if (level.sessionadverthud_3a_text != "<dev string:x225>") {
                    sessionadverthud_3a settext(level.sessionadverthud_3a_text);
                    sessionadverthud_3b setvalue(level.sessionadverthud_3b_text);
                }
                if (level.sessionadverthud_4a_text != "<dev string:x225>") {
                    sessionadverthud_4a settext(level.sessionadverthud_4a_text);
                    sessionadverthud_4b setvalue(level.sessionadverthud_4b_text);
                }
            }
        }
    }

#/
