#using scripts/cp/gametypes/_globallogic_score;
#using scripts/shared/hud_message_shared;
#using scripts/shared/hostmigration_shared;
#using scripts/codescripts/struct;

#namespace globallogic_utils;

// Namespace globallogic_utils
// Params 0, eflags: 0x0
// Checksum 0xbffaeef0, Offset: 0x2e0
// Size: 0x98
function function_15b32a64() {
    self endon(#"death");
    self endon(#"disconnect");
    for (;;) {
        wait(10);
        var_b444826e = spawnstruct();
        var_b444826e.var_c4a19800 = %MP_CHALLENGE_COMPLETED;
        var_b444826e.var_da258253 = "wheee";
        var_b444826e.sound = "mp_challenge_complete";
        self thread hud_message::notifymessage(var_b444826e);
    }
}

// Namespace globallogic_utils
// Params 0, eflags: 0x0
// Checksum 0xf6cb316b, Offset: 0x380
// Size: 0xba
function testshock() {
    self endon(#"death");
    self endon(#"disconnect");
    for (;;) {
        wait(3);
        numshots = randomint(6);
        for (i = 0; i < numshots; i++) {
            iprintlnbold(numshots);
            self shellshock("frag_grenade_mp", 0.2);
            wait(0.1);
        }
    }
}

// Namespace globallogic_utils
// Params 0, eflags: 0x0
// Checksum 0x80ee2051, Offset: 0x448
// Size: 0xdc
function timeuntilroundend() {
    if (level.gameended) {
        timepassed = (gettime() - level.gameendtime) / 1000;
        timeremaining = level.postroundtime - timepassed;
        if (timeremaining < 0) {
            return 0;
        }
        return timeremaining;
    }
    if (level.inovertime) {
        return undefined;
    }
    if (level.timelimit <= 0) {
        return undefined;
    }
    if (!isdefined(level.starttime)) {
        return undefined;
    }
    timepassed = (gettimepassed() - level.starttime) / 1000;
    timeremaining = level.timelimit * 60 - timepassed;
    return timeremaining + level.postroundtime;
}

// Namespace globallogic_utils
// Params 0, eflags: 0x1 linked
// Checksum 0x2ba9a328, Offset: 0x530
// Size: 0x3c
function gettimeremaining() {
    if (level.timelimit == 0) {
        return undefined;
    }
    return level.timelimit * 60 * 1000 - gettimepassed();
}

// Namespace globallogic_utils
// Params 1, eflags: 0x1 linked
// Checksum 0xe3563218, Offset: 0x578
// Size: 0x3a
function registerpostroundevent(eventfunc) {
    if (!isdefined(level.postroundevents)) {
        level.postroundevents = [];
    }
    level.postroundevents[level.postroundevents.size] = eventfunc;
}

// Namespace globallogic_utils
// Params 0, eflags: 0x1 linked
// Checksum 0xd24cae61, Offset: 0x5c0
// Size: 0x54
function executepostroundevents() {
    if (!isdefined(level.postroundevents)) {
        return;
    }
    for (i = 0; i < level.postroundevents.size; i++) {
        [[ level.postroundevents[i] ]]();
    }
}

// Namespace globallogic_utils
// Params 3, eflags: 0x0
// Checksum 0xca094853, Offset: 0x620
// Size: 0x52
function getvalueinrange(value, minvalue, maxvalue) {
    if (value > maxvalue) {
        return maxvalue;
    }
    if (value < minvalue) {
        return minvalue;
    }
    return value;
}

/#

    // Namespace globallogic_utils
    // Params 0, eflags: 0x1 linked
    // Checksum 0xa739726b, Offset: 0x680
    // Size: 0x2c2
    function assertproperplacement() {
        numplayers = level.placement["timepassed"].size;
        if (level.teambased) {
            for (i = 0; i < numplayers - 1; i++) {
                if (level.placement["timepassed"][i].score < level.placement["timepassed"][i + 1].score) {
                    println("timepassed");
                    for (i = 0; i < numplayers; i++) {
                        player = level.placement["timepassed"][i];
                        println("timepassed" + i + "timepassed" + player.name + "timepassed" + player.score);
                    }
                    assertmsg("timepassed");
                    break;
                }
            }
            return;
        }
        for (i = 0; i < numplayers - 1; i++) {
            if (level.placement["timepassed"][i].pointstowin < level.placement["timepassed"][i + 1].pointstowin) {
                println("timepassed");
                for (i = 0; i < numplayers; i++) {
                    player = level.placement["timepassed"][i];
                    println("timepassed" + i + "timepassed" + player.name + "timepassed" + player.pointstowin);
                }
                assertmsg("timepassed");
                break;
            }
        }
    }

#/

// Namespace globallogic_utils
// Params 1, eflags: 0x1 linked
// Checksum 0xbc8ade09, Offset: 0x950
// Size: 0x68
function isvalidclass(c) {
    if (level.oldschool || sessionmodeiszombiesgame()) {
        assert(!isdefined(c));
        return true;
    }
    return isdefined(c) && c != "";
}

// Namespace globallogic_utils
// Params 1, eflags: 0x0
// Checksum 0x2f5afe56, Offset: 0x9c0
// Size: 0x120
function playtickingsound(gametype_tick_sound) {
    self endon(#"death");
    self endon(#"stop_ticking");
    level endon(#"game_ended");
    time = level.bombtimer;
    while (true) {
        self playsound(gametype_tick_sound);
        if (time > 10) {
            time -= 1;
            wait(1);
        } else if (time > 4) {
            time -= 0.5;
            wait(0.5);
        } else if (time > 1) {
            time -= 0.4;
            wait(0.4);
        } else {
            time -= 0.3;
            wait(0.3);
        }
        hostmigration::waittillhostmigrationdone();
    }
}

// Namespace globallogic_utils
// Params 0, eflags: 0x0
// Checksum 0xf50cae25, Offset: 0xae8
// Size: 0x12
function stoptickingsound() {
    self notify(#"stop_ticking");
}

// Namespace globallogic_utils
// Params 0, eflags: 0x1 linked
// Checksum 0xb7ec2ca0, Offset: 0xb08
// Size: 0xd4
function gametimer() {
    level endon(#"game_ended");
    level waittill(#"prematch_over");
    level.starttime = gettime();
    level.discardtime = 0;
    if (isdefined(game["roundMillisecondsAlreadyPassed"])) {
        level.starttime -= game["roundMillisecondsAlreadyPassed"];
        game["roundMillisecondsAlreadyPassed"] = undefined;
    }
    prevtime = gettime();
    while (game["state"] == "playing") {
        if (!level.timerstopped) {
            game["timepassed"] = game["timepassed"] + gettime() - prevtime;
        }
        prevtime = gettime();
        wait(1);
    }
}

// Namespace globallogic_utils
// Params 0, eflags: 0x1 linked
// Checksum 0xa6a05cab, Offset: 0xbe8
// Size: 0x52
function gettimepassed() {
    if (!isdefined(level.starttime)) {
        return 0;
    }
    if (level.timerstopped) {
        return (level.timerpausetime - level.starttime - level.discardtime);
    }
    return gettime() - level.starttime - level.discardtime;
}

// Namespace globallogic_utils
// Params 0, eflags: 0x0
// Checksum 0xa6d0ced4, Offset: 0xc48
// Size: 0x28
function pausetimer() {
    if (level.timerstopped) {
        return;
    }
    level.timerstopped = 1;
    level.timerpausetime = gettime();
}

// Namespace globallogic_utils
// Params 0, eflags: 0x0
// Checksum 0xec9776ef, Offset: 0xc78
// Size: 0x38
function resumetimer() {
    if (!level.timerstopped) {
        return;
    }
    level.timerstopped = 0;
    level.discardtime += gettime() - level.timerpausetime;
}

// Namespace globallogic_utils
// Params 1, eflags: 0x1 linked
// Checksum 0x457e681b, Offset: 0xcb8
// Size: 0x9e
function getscoreremaining(team) {
    assert(isplayer(self) || isdefined(team));
    scorelimit = level.scorelimit;
    if (isplayer(self)) {
        return (scorelimit - globallogic_score::_getplayerscore(self));
    }
    return scorelimit - getteamscore(team);
}

// Namespace globallogic_utils
// Params 1, eflags: 0x1 linked
// Checksum 0xebe4d54d, Offset: 0xd60
// Size: 0x6a
function getteamscoreforround(team) {
    if (level.cumulativeroundscores && isdefined(game["lastroundscore"][team])) {
        return (getteamscore(team) - game["lastroundscore"][team]);
    }
    return getteamscore(team);
}

// Namespace globallogic_utils
// Params 1, eflags: 0x1 linked
// Checksum 0x7bc6649b, Offset: 0xdd8
// Size: 0xe2
function getscoreperminute(team) {
    assert(isplayer(self) || isdefined(team));
    scorelimit = level.scorelimit;
    timelimit = level.timelimit;
    minutespassed = gettimepassed() / 60000 + 0.0001;
    if (isplayer(self)) {
        return (globallogic_score::_getplayerscore(self) / minutespassed);
    }
    return getteamscoreforround(team) / minutespassed;
}

// Namespace globallogic_utils
// Params 1, eflags: 0x1 linked
// Checksum 0x9013ec7, Offset: 0xec8
// Size: 0xa2
function getestimatedtimeuntilscorelimit(team) {
    assert(isplayer(self) || isdefined(team));
    scoreperminute = self getscoreperminute(team);
    scoreremaining = self getscoreremaining(team);
    if (!scoreperminute) {
        return 999999;
    }
    return scoreremaining / scoreperminute;
}

// Namespace globallogic_utils
// Params 0, eflags: 0x0
// Checksum 0x84ecb8a4, Offset: 0xf78
// Size: 0x40
function rumbler() {
    self endon(#"disconnect");
    while (true) {
        wait(0.1);
        self playrumbleonentity("damage_heavy");
    }
}

// Namespace globallogic_utils
// Params 2, eflags: 0x1 linked
// Checksum 0x7cc6dd55, Offset: 0xfc0
// Size: 0x22
function waitfortimeornotify(time, notifyname) {
    self endon(notifyname);
    wait(time);
}

// Namespace globallogic_utils
// Params 2, eflags: 0x0
// Checksum 0x7012a40f, Offset: 0xff0
// Size: 0x58
function waitfortimeornotifynoartillery(time, notifyname) {
    self endon(notifyname);
    wait(time);
    while (isdefined(level.artilleryinprogress)) {
        assert(level.artilleryinprogress);
        wait(0.25);
    }
}

// Namespace globallogic_utils
// Params 4, eflags: 0x1 linked
// Checksum 0xb2365b75, Offset: 0x1050
// Size: 0x96
function isheadshot(weapon, shitloc, smeansofdeath, einflictor) {
    if (shitloc != "head" && shitloc != "helmet") {
        return false;
    }
    switch (smeansofdeath) {
    case 14:
    case 15:
    case 16:
        return false;
    case 13:
        if (weapon != level.weaponballisticknife) {
            return false;
        }
        break;
    }
    return true;
}

// Namespace globallogic_utils
// Params 1, eflags: 0x1 linked
// Checksum 0x7c895ed6, Offset: 0x10f0
// Size: 0xd6
function gethitlocheight(shitloc) {
    switch (shitloc) {
    case 11:
    case 12:
    case 24:
        return 60;
    case 17:
    case 18:
    case 19:
    case 21:
    case 25:
    case 26:
    case 28:
    case 32:
        return 48;
    case 31:
        return 40;
    case 23:
    case 30:
        return 32;
    case 22:
    case 29:
        return 10;
    case 20:
    case 27:
        return 5;
    }
    return 48;
}

/#

    // Namespace globallogic_utils
    // Params 2, eflags: 0x0
    // Checksum 0x8deae826, Offset: 0x11d0
    // Size: 0x66
    function debugline(start, end) {
                for (i = 0; i < 50; i++) {
            line(start, end);
            wait(0.05);
        }
    }

#/

// Namespace globallogic_utils
// Params 2, eflags: 0x0
// Checksum 0x68ab2c73, Offset: 0x1240
// Size: 0x5a
function isexcluded(entity, entitylist) {
    for (index = 0; index < entitylist.size; index++) {
        if (entity == entitylist[index]) {
            return true;
        }
    }
    return false;
}

// Namespace globallogic_utils
// Params 1, eflags: 0x0
// Checksum 0x32d3919, Offset: 0x12a8
// Size: 0x62
function function_b59d6fa4(var_be260a2e) {
    var_9a8af909 = gettime();
    waitedtime = (gettime() - var_9a8af909) / 1000;
    if (waitedtime < var_be260a2e) {
        wait(var_be260a2e - waitedtime);
        return var_be260a2e;
    }
    return waitedtime;
}

// Namespace globallogic_utils
// Params 2, eflags: 0x1 linked
// Checksum 0x4b2e0ec1, Offset: 0x1318
// Size: 0x10c
function logteamwinstring(wintype, winner) {
    log_string = wintype;
    if (isdefined(winner)) {
        log_string = log_string + ", win: " + winner;
    }
    foreach (team in level.teams) {
        log_string = log_string + ", " + team + ": " + game["teamScores"][team];
    }
    /#
        print(log_string);
    #/
}

