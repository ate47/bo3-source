#using scripts/zm/gametypes/_hostmigration;
#using scripts/zm/gametypes/_globallogic_score;
#using scripts/shared/hud_message_shared;
#using scripts/codescripts/struct;

#namespace globallogic_utils;

// Namespace globallogic_utils
// Params 0, eflags: 0x0
// Checksum 0x8dd69930, Offset: 0x2a0
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
// Checksum 0xc59707f4, Offset: 0x340
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
// Checksum 0x7ee9ead6, Offset: 0x408
// Size: 0x88
function testhps() {
    self endon(#"death");
    self endon(#"disconnect");
    hps = [];
    hps[hps.size] = "radar";
    hps[hps.size] = "artillery";
    hps[hps.size] = "dogs";
    for (;;) {
        hp = "radar";
        wait(20);
    }
}

// Namespace globallogic_utils
// Params 0, eflags: 0x0
// Checksum 0xb9a8e5f6, Offset: 0x498
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
// Checksum 0x6362dbed, Offset: 0x580
// Size: 0x2c
function gettimeremaining() {
    return level.timelimit * 60 * 1000 - gettimepassed();
}

// Namespace globallogic_utils
// Params 1, eflags: 0x0
// Checksum 0x8939dc10, Offset: 0x5b8
// Size: 0x3a
function registerpostroundevent(eventfunc) {
    if (!isdefined(level.postroundevents)) {
        level.postroundevents = [];
    }
    level.postroundevents[level.postroundevents.size] = eventfunc;
}

// Namespace globallogic_utils
// Params 0, eflags: 0x1 linked
// Checksum 0xe3b99de2, Offset: 0x600
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
// Checksum 0xba22c873, Offset: 0x660
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
    // Checksum 0x4bed67e, Offset: 0x6c0
    // Size: 0x1b2
    function assertproperplacement() {
        numplayers = level.placement["roundMillisecondsAlreadyPassed"].size;
        for (i = 0; i < numplayers - 1; i++) {
            if (isdefined(level.placement["roundMillisecondsAlreadyPassed"][i]) && isdefined(level.placement["roundMillisecondsAlreadyPassed"][i + 1])) {
                if (level.placement["roundMillisecondsAlreadyPassed"][i].score < level.placement["roundMillisecondsAlreadyPassed"][i + 1].score) {
                    println("roundMillisecondsAlreadyPassed");
                    for (i = 0; i < numplayers; i++) {
                        player = level.placement["roundMillisecondsAlreadyPassed"][i];
                        println("roundMillisecondsAlreadyPassed" + i + "roundMillisecondsAlreadyPassed" + player.name + "roundMillisecondsAlreadyPassed" + player.score);
                    }
                    /#
                        assertmsg("roundMillisecondsAlreadyPassed");
                    #/
                    break;
                }
            }
        }
    }

#/

// Namespace globallogic_utils
// Params 1, eflags: 0x1 linked
// Checksum 0x768d8bd, Offset: 0x880
// Size: 0x68
function isvalidclass(vclass) {
    if (level.oldschool || sessionmodeiszombiesgame()) {
        /#
            assert(!isdefined(vclass));
        #/
        return true;
    }
    return isdefined(vclass) && vclass != "";
}

// Namespace globallogic_utils
// Params 1, eflags: 0x0
// Checksum 0x5679ddea, Offset: 0x8f0
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
// Checksum 0x99407360, Offset: 0xa18
// Size: 0x12
function stoptickingsound() {
    self notify(#"stop_ticking");
}

// Namespace globallogic_utils
// Params 0, eflags: 0x1 linked
// Checksum 0xf1a49365, Offset: 0xa38
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
// Checksum 0x6608243a, Offset: 0xb18
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
// Params 0, eflags: 0x1 linked
// Checksum 0x8a2b8b27, Offset: 0xb78
// Size: 0x28
function pausetimer() {
    if (level.timerstopped) {
        return;
    }
    level.timerstopped = 1;
    level.timerpausetime = gettime();
}

// Namespace globallogic_utils
// Params 0, eflags: 0x1 linked
// Checksum 0x61dcdef2, Offset: 0xba8
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
// Checksum 0x38809869, Offset: 0xbe8
// Size: 0x9e
function getscoreremaining(team) {
    /#
        assert(isplayer(self) || isdefined(team));
    #/
    scorelimit = level.scorelimit;
    if (isplayer(self)) {
        return (scorelimit - globallogic_score::_getplayerscore(self));
    }
    return scorelimit - getteamscore(team);
}

// Namespace globallogic_utils
// Params 1, eflags: 0x1 linked
// Checksum 0x8255e2d, Offset: 0xc90
// Size: 0xe2
function getscoreperminute(team) {
    /#
        assert(isplayer(self) || isdefined(team));
    #/
    scorelimit = level.scorelimit;
    timelimit = level.timelimit;
    minutespassed = gettimepassed() / 60000 + 0.0001;
    if (isplayer(self)) {
        return (globallogic_score::_getplayerscore(self) / minutespassed);
    }
    return getteamscore(team) / minutespassed;
}

// Namespace globallogic_utils
// Params 1, eflags: 0x1 linked
// Checksum 0x77ba2fd7, Offset: 0xd80
// Size: 0xa2
function getestimatedtimeuntilscorelimit(team) {
    /#
        assert(isplayer(self) || isdefined(team));
    #/
    scoreperminute = self getscoreperminute(team);
    scoreremaining = self getscoreremaining(team);
    if (!scoreperminute) {
        return 999999;
    }
    return scoreremaining / scoreperminute;
}

// Namespace globallogic_utils
// Params 0, eflags: 0x0
// Checksum 0x64b0ce09, Offset: 0xe30
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
// Checksum 0x8149a8f0, Offset: 0xe78
// Size: 0x22
function waitfortimeornotify(time, notifyname) {
    self endon(notifyname);
    wait(time);
}

// Namespace globallogic_utils
// Params 2, eflags: 0x0
// Checksum 0x62dbc9e1, Offset: 0xea8
// Size: 0x58
function waitfortimeornotifynoartillery(time, notifyname) {
    self endon(notifyname);
    wait(time);
    while (isdefined(level.artilleryinprogress)) {
        /#
            assert(level.artilleryinprogress);
        #/
        wait(0.25);
    }
}

// Namespace globallogic_utils
// Params 4, eflags: 0x1 linked
// Checksum 0xb727a866, Offset: 0xf08
// Size: 0x86
function isheadshot(weapon, shitloc, smeansofdeath, einflictor) {
    if (shitloc != "head" && shitloc != "helmet") {
        return false;
    }
    switch (smeansofdeath) {
    case 16:
        return false;
    case 15:
        if (weapon != level.weaponballisticknife) {
            return false;
        }
        break;
    }
    return true;
}

// Namespace globallogic_utils
// Params 1, eflags: 0x1 linked
// Checksum 0x82cbf22b, Offset: 0xf98
// Size: 0xd6
function gethitlocheight(shitloc) {
    switch (shitloc) {
    case 13:
    case 14:
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
    // Checksum 0x3912785d, Offset: 0x1078
    // Size: 0x66
    function debugline(start, end) {
                for (i = 0; i < 50; i++) {
            line(start, end);
            wait(0.05);
        }
    }

#/

// Namespace globallogic_utils
// Params 2, eflags: 0x1 linked
// Checksum 0xfc7988ab, Offset: 0x10e8
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
// Params 1, eflags: 0x1 linked
// Checksum 0x53a361ff, Offset: 0x1150
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

/#

    // Namespace globallogic_utils
    // Params 2, eflags: 0x1 linked
    // Checksum 0xa2f721da, Offset: 0x11c0
    // Size: 0x10c
    function logteamwinstring(wintype, winner) {
        log_string = wintype;
        if (isdefined(winner)) {
            log_string = log_string + "roundMillisecondsAlreadyPassed" + winner;
        }
        foreach (team in level.teams) {
            log_string = log_string + "roundMillisecondsAlreadyPassed" + team + "roundMillisecondsAlreadyPassed" + game["roundMillisecondsAlreadyPassed"][team];
        }
        print(log_string);
    }

#/
