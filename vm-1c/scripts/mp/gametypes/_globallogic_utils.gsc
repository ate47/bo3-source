#using scripts/mp/killstreaks/_killstreaks;
#using scripts/mp/gametypes/_hud_message;
#using scripts/mp/gametypes/_hostmigration;
#using scripts/mp/gametypes/_globallogic_score;
#using scripts/shared/killstreaks_shared;
#using scripts/shared/hud_message_shared;
#using scripts/shared/hostmigration_shared;
#using scripts/codescripts/struct;

#namespace globallogic_utils;

// Namespace globallogic_utils
// Params 0, eflags: 0x0
// Checksum 0x78448647, Offset: 0x370
// Size: 0x98
function function_15b32a64() {
    self endon(#"death");
    self endon(#"disconnect");
    for (;;) {
        wait 10;
        var_b444826e = spawnstruct();
        var_b444826e.var_c4a19800 = %MP_CHALLENGE_COMPLETED;
        var_b444826e.var_da258253 = "wheee";
        var_b444826e.sound = "mp_challenge_complete";
        self thread hud_message::notifymessage(var_b444826e);
    }
}

// Namespace globallogic_utils
// Params 0, eflags: 0x0
// Checksum 0x48824301, Offset: 0x410
// Size: 0xba
function testshock() {
    self endon(#"death");
    self endon(#"disconnect");
    for (;;) {
        wait 3;
        numshots = randomint(6);
        for (i = 0; i < numshots; i++) {
            iprintlnbold(numshots);
            self shellshock("frag_grenade_mp", 0.2);
            wait 0.1;
        }
    }
}

// Namespace globallogic_utils
// Params 0, eflags: 0x0
// Checksum 0xf5770ff7, Offset: 0x4d8
// Size: 0xd0
function testhps() {
    self endon(#"death");
    self endon(#"disconnect");
    hps = [];
    hps[hps.size] = "radar";
    hps[hps.size] = "artillery";
    hps[hps.size] = "dogs";
    for (;;) {
        hp = "radar";
        if (self thread killstreaks::give(hp)) {
            self playlocalsound(level.killstreaks[hp].informdialog);
        }
        wait 20;
    }
}

// Namespace globallogic_utils
// Params 0, eflags: 0x1 linked
// Checksum 0x70b3b9d7, Offset: 0x5b0
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
// Checksum 0x443a6e16, Offset: 0x698
// Size: 0x2c
function gettimeremaining() {
    return level.timelimit * 60 * 1000 - gettimepassed();
}

// Namespace globallogic_utils
// Params 1, eflags: 0x1 linked
// Checksum 0xfc61b36b, Offset: 0x6d0
// Size: 0x3a
function registerpostroundevent(eventfunc) {
    if (!isdefined(level.postroundevents)) {
        level.postroundevents = [];
    }
    level.postroundevents[level.postroundevents.size] = eventfunc;
}

// Namespace globallogic_utils
// Params 0, eflags: 0x1 linked
// Checksum 0x79dfef9d, Offset: 0x718
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
// Checksum 0x96b89138, Offset: 0x778
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
    // Checksum 0xfbd4a158, Offset: 0x7d8
    // Size: 0x2c2
    function assertproperplacement() {
        numplayers = level.placement["<dev string:x28>"].size;
        if (level.teambased) {
            for (i = 0; i < numplayers - 1; i++) {
                if (level.placement["<dev string:x28>"][i].score < level.placement["<dev string:x28>"][i + 1].score) {
                    println("<dev string:x2c>");
                    for (i = 0; i < numplayers; i++) {
                        player = level.placement["<dev string:x28>"][i];
                        println("<dev string:x3f>" + i + "<dev string:x42>" + player.name + "<dev string:x45>" + player.score);
                    }
                    assertmsg("<dev string:x48>");
                    break;
                }
            }
            return;
        }
        for (i = 0; i < numplayers - 1; i++) {
            if (level.placement["<dev string:x28>"][i].pointstowin < level.placement["<dev string:x28>"][i + 1].pointstowin) {
                println("<dev string:x2c>");
                for (i = 0; i < numplayers; i++) {
                    player = level.placement["<dev string:x28>"][i];
                    println("<dev string:x3f>" + i + "<dev string:x42>" + player.name + "<dev string:x45>" + player.pointstowin);
                }
                assertmsg("<dev string:x48>");
                break;
            }
        }
    }

#/

// Namespace globallogic_utils
// Params 1, eflags: 0x1 linked
// Checksum 0x1370e195, Offset: 0xaa8
// Size: 0x58
function isvalidclass(c) {
    if (sessionmodeiszombiesgame()) {
        assert(!isdefined(c));
        return true;
    }
    return isdefined(c) && c != "";
}

// Namespace globallogic_utils
// Params 1, eflags: 0x0
// Checksum 0xacb63d80, Offset: 0xb08
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
            wait 1;
        } else if (time > 4) {
            time -= 0.5;
            wait 0.5;
        } else if (time > 1) {
            time -= 0.4;
            wait 0.4;
        } else {
            time -= 0.3;
            wait 0.3;
        }
        hostmigration::waittillhostmigrationdone();
    }
}

// Namespace globallogic_utils
// Params 0, eflags: 0x0
// Checksum 0x643299ac, Offset: 0xc30
// Size: 0x12
function stoptickingsound() {
    self notify(#"stop_ticking");
}

// Namespace globallogic_utils
// Params 0, eflags: 0x1 linked
// Checksum 0x43ea0048, Offset: 0xc50
// Size: 0x104
function gametimer() {
    level endon(#"game_ended");
    level waittill(#"prematch_over");
    level.starttime = gettime();
    level.discardtime = 0;
    if (isdefined(game["roundMillisecondsAlreadyPassed"])) {
        level.starttime -= game["roundMillisecondsAlreadyPassed"];
        game["roundMillisecondsAlreadyPassed"] = undefined;
    }
    prevtime = gettime() - 1000;
    while (game["state"] == "playing") {
        if (!level.timerstopped) {
            game["timepassed"] = game["timepassed"] + gettime() - prevtime;
        }
        if (!level.playabletimerstopped) {
            game["playabletimepassed"] = game["playabletimepassed"] + gettime() - prevtime;
        }
        prevtime = gettime();
        wait 1;
    }
}

// Namespace globallogic_utils
// Params 0, eflags: 0x1 linked
// Checksum 0xf9c8d203, Offset: 0xd60
// Size: 0x6c
function disableplayerroundstartdelay() {
    player = self;
    player endon(#"death");
    player endon(#"disconnect");
    if (getroundstartdelay()) {
        wait getroundstartdelay();
    }
    player disableroundstartdelay();
}

// Namespace globallogic_utils
// Params 0, eflags: 0x1 linked
// Checksum 0x95e19757, Offset: 0xdd8
// Size: 0x40
function getroundstartdelay() {
    waittime = level.roundstartexplosivedelay - [[ level.gettimepassed ]]() / 1000;
    if (waittime > 0) {
        return waittime;
    }
    return 0;
}

// Namespace globallogic_utils
// Params 0, eflags: 0x1 linked
// Checksum 0x1a89328a, Offset: 0xe20
// Size: 0x84
function applyroundstartdelay() {
    self endon(#"disconnect");
    self endon(#"joined_spectators");
    self endon(#"death");
    if (isdefined(level.prematch_over) && level.prematch_over) {
        wait 0.05;
    } else {
        level waittill(#"prematch_over");
    }
    self enableroundstartdelay();
    self thread disableplayerroundstartdelay();
}

// Namespace globallogic_utils
// Params 0, eflags: 0x1 linked
// Checksum 0x7c2c92fb, Offset: 0xeb0
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
// Params 1, eflags: 0x1 linked
// Checksum 0x516fe48b, Offset: 0xf10
// Size: 0x50
function pausetimer(pauseplayabletimer) {
    if (!isdefined(pauseplayabletimer)) {
        pauseplayabletimer = 0;
    }
    level.playabletimerstopped = pauseplayabletimer;
    if (level.timerstopped) {
        return;
    }
    level.timerstopped = 1;
    level.timerpausetime = gettime();
}

// Namespace globallogic_utils
// Params 0, eflags: 0x1 linked
// Checksum 0xa169b763, Offset: 0xf68
// Size: 0x44
function resumetimer() {
    if (!level.timerstopped) {
        return;
    }
    level.timerstopped = 0;
    level.playabletimerstopped = 0;
    level.discardtime += gettime() - level.timerpausetime;
}

// Namespace globallogic_utils
// Params 1, eflags: 0x0
// Checksum 0xb62dce78, Offset: 0xfb8
// Size: 0x30
function resumetimerdiscardoverride(discardtime) {
    if (!level.timerstopped) {
        return;
    }
    level.timerstopped = 0;
    level.discardtime = discardtime;
}

// Namespace globallogic_utils
// Params 1, eflags: 0x1 linked
// Checksum 0xd6f38852, Offset: 0xff0
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
// Checksum 0x9e3da6d0, Offset: 0x1098
// Size: 0x6a
function getteamscoreforround(team) {
    if (level.cumulativeroundscores && isdefined(game["lastroundscore"][team])) {
        return (getteamscore(team) - game["lastroundscore"][team]);
    }
    return getteamscore(team);
}

// Namespace globallogic_utils
// Params 1, eflags: 0x1 linked
// Checksum 0xd6bbfb19, Offset: 0x1110
// Size: 0xba
function getscoreperminute(team) {
    assert(isplayer(self) || isdefined(team));
    minutespassed = gettimepassed() / 60000 + 0.0001;
    if (isplayer(self)) {
        return (globallogic_score::_getplayerscore(self) / minutespassed);
    }
    return getteamscoreforround(team) / minutespassed;
}

// Namespace globallogic_utils
// Params 1, eflags: 0x1 linked
// Checksum 0xd7e4b586, Offset: 0x11d8
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
// Checksum 0x702e6a95, Offset: 0x1288
// Size: 0x40
function rumbler() {
    self endon(#"disconnect");
    while (true) {
        wait 0.1;
        self playrumbleonentity("damage_heavy");
    }
}

// Namespace globallogic_utils
// Params 2, eflags: 0x1 linked
// Checksum 0x8c3df4da, Offset: 0x12d0
// Size: 0x22
function waitfortimeornotify(time, notifyname) {
    self endon(notifyname);
    wait time;
}

// Namespace globallogic_utils
// Params 2, eflags: 0x0
// Checksum 0x9969f391, Offset: 0x1300
// Size: 0x58
function waitfortimeornotifynoartillery(time, notifyname) {
    self endon(notifyname);
    wait time;
    while (isdefined(level.artilleryinprogress)) {
        assert(level.artilleryinprogress);
        wait 0.25;
    }
}

// Namespace globallogic_utils
// Params 4, eflags: 0x1 linked
// Checksum 0x73d3d715, Offset: 0x1360
// Size: 0xea
function isheadshot(weapon, shitloc, smeansofdeath, einflictor) {
    if (shitloc != "head" && shitloc != "helmet") {
        return false;
    }
    switch (smeansofdeath) {
    case "MOD_MELEE":
    case "MOD_MELEE_ASSASSINATE":
        return false;
    case "MOD_IMPACT":
        if (weapon.rootweapon != level.weaponballisticknife) {
            return false;
        }
        break;
    }
    if (killstreaks::is_killstreak_weapon(weapon)) {
        if (!isdefined(einflictor) || !isdefined(einflictor.controlled) || einflictor.controlled == 0) {
            return false;
        }
    }
    return true;
}

// Namespace globallogic_utils
// Params 1, eflags: 0x0
// Checksum 0xac8c6168, Offset: 0x1458
// Size: 0xd6
function gethitlocheight(shitloc) {
    switch (shitloc) {
    case "head":
    case "helmet":
    case "neck":
        return 60;
    case "gun":
    case "left_arm_lower":
    case "left_arm_upper":
    case "left_hand":
    case "right_arm_lower":
    case "right_arm_upper":
    case "right_hand":
    case "torso_upper":
        return 48;
    case "torso_lower":
        return 40;
    case "left_leg_upper":
    case "right_leg_upper":
        return 32;
    case "left_leg_lower":
    case "right_leg_lower":
        return 10;
    case "left_foot":
    case "right_foot":
        return 5;
    }
    return 48;
}

/#

    // Namespace globallogic_utils
    // Params 2, eflags: 0x0
    // Checksum 0x81cbee3e, Offset: 0x1538
    // Size: 0x66
    function debugline(start, end) {
        for (i = 0; i < 50; i++) {
            line(start, end);
            wait 0.05;
        }
    }

#/

// Namespace globallogic_utils
// Params 2, eflags: 0x1 linked
// Checksum 0x96eb2474, Offset: 0x15a8
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
// Checksum 0x93004806, Offset: 0x1610
// Size: 0x62
function function_b59d6fa4(var_be260a2e) {
    var_9a8af909 = gettime();
    waitedtime = (gettime() - var_9a8af909) / 1000;
    if (waitedtime < var_be260a2e) {
        wait var_be260a2e - waitedtime;
        return var_be260a2e;
    }
    return waitedtime;
}

/#

    // Namespace globallogic_utils
    // Params 2, eflags: 0x1 linked
    // Checksum 0xa2f9c154, Offset: 0x1680
    // Size: 0x10c
    function logteamwinstring(wintype, winner) {
        log_string = wintype;
        if (isdefined(winner)) {
            log_string = log_string + "<dev string:x70>" + winner;
        }
        foreach (team in level.teams) {
            log_string = log_string + "<dev string:x78>" + team + "<dev string:x45>" + game["<dev string:x7b>"][team];
        }
        print(log_string);
    }

#/
