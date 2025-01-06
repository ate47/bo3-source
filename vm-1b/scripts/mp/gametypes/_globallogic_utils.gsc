#using scripts/codescripts/struct;
#using scripts/mp/gametypes/_globallogic_score;
#using scripts/mp/gametypes/_hostmigration;
#using scripts/mp/gametypes/_hud_message;
#using scripts/mp/killstreaks/_killstreaks;
#using scripts/shared/hostmigration_shared;
#using scripts/shared/hud_message_shared;
#using scripts/shared/killstreaks_shared;

#namespace globallogic_utils;

// Namespace globallogic_utils
// Params 0, eflags: 0x0
// Checksum 0x121aa7d2, Offset: 0x360
// Size: 0x75
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
// Checksum 0xfc989d50, Offset: 0x3e0
// Size: 0x8d
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
// Checksum 0xc8594b36, Offset: 0x478
// Size: 0x95
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
// Params 0, eflags: 0x0
// Checksum 0xa382cfbb, Offset: 0x518
// Size: 0xaa
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
// Params 0, eflags: 0x0
// Checksum 0x30b7db78, Offset: 0x5d0
// Size: 0x22
function gettimeremaining() {
    return level.timelimit * 60 * 1000 - gettimepassed();
}

// Namespace globallogic_utils
// Params 1, eflags: 0x0
// Checksum 0xcbbe64fc, Offset: 0x600
// Size: 0x2f
function registerpostroundevent(eventfunc) {
    if (!isdefined(level.postroundevents)) {
        level.postroundevents = [];
    }
    level.postroundevents[level.postroundevents.size] = eventfunc;
}

// Namespace globallogic_utils
// Params 0, eflags: 0x0
// Checksum 0x71700461, Offset: 0x638
// Size: 0x3b
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
// Checksum 0xab39050b, Offset: 0x680
// Size: 0x3a
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
    // Params 0, eflags: 0x0
    // Checksum 0x8b2ad11f, Offset: 0x6c8
    // Size: 0x213
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
// Params 1, eflags: 0x0
// Checksum 0xb95fffd5, Offset: 0x8e8
// Size: 0x46
function isvalidclass(c) {
    if (sessionmodeiszombiesgame()) {
        assert(!isdefined(c));
        return true;
    }
    return isdefined(c) && c != "";
}

// Namespace globallogic_utils
// Params 1, eflags: 0x0
// Checksum 0xe1841f46, Offset: 0x938
// Size: 0xc5
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
// Checksum 0xb4f9a2fb, Offset: 0xa08
// Size: 0xb
function stoptickingsound() {
    self notify(#"stop_ticking");
}

// Namespace globallogic_utils
// Params 0, eflags: 0x0
// Checksum 0x1d9431e4, Offset: 0xa20
// Size: 0x35
function gametimer() {
    level endon(#"game_ended");
    level waittill(#"prematch_over");
    level.starttime = gettime();
    level.discardtime = 0;
    InvalidOpCode(0x54, "roundMillisecondsAlreadyPassed");
    // Unknown operator (0x54, t7_1b, PC)
}

// Namespace globallogic_utils
// Params 0, eflags: 0x0
// Checksum 0x73244980, Offset: 0xad0
// Size: 0x47
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
// Checksum 0x5bc28126, Offset: 0xb20
// Size: 0x1e
function pausetimer() {
    if (level.timerstopped) {
        return;
    }
    level.timerstopped = 1;
    level.timerpausetime = gettime();
}

// Namespace globallogic_utils
// Params 0, eflags: 0x0
// Checksum 0xf84bd8e3, Offset: 0xb48
// Size: 0x2e
function resumetimer() {
    if (!level.timerstopped) {
        return;
    }
    level.timerstopped = 0;
    level.discardtime += gettime() - level.timerpausetime;
}

// Namespace globallogic_utils
// Params 1, eflags: 0x0
// Checksum 0xf1864315, Offset: 0xb80
// Size: 0x26
function resumetimerdiscardoverride(discardtime) {
    if (!level.timerstopped) {
        return;
    }
    level.timerstopped = 0;
    level.discardtime = discardtime;
}

// Namespace globallogic_utils
// Params 1, eflags: 0x0
// Checksum 0xdc0bccd2, Offset: 0xbb0
// Size: 0x8b
function getscoreremaining(team) {
    assert(isplayer(self) || isdefined(team));
    scorelimit = level.scorelimit;
    if (isplayer(self)) {
        return (scorelimit - globallogic_score::_getplayerscore(self));
    }
    return scorelimit - getteamscore(team);
}

// Namespace globallogic_utils
// Params 1, eflags: 0x0
// Checksum 0xece5ecab, Offset: 0xc48
// Size: 0x59
function getteamscoreforround(team) {
    InvalidOpCode(0x54, "lastroundscore", team);
    // Unknown operator (0x54, t7_1b, PC)
LOC_00000020:
    if (level.cumulativeroundscores && level.cumulativeroundscores) {
        InvalidOpCode(0x54, "lastroundscore", team, getteamscore(team));
        // Unknown operator (0x54, t7_1b, PC)
    }
    return getteamscore(team);
}

// Namespace globallogic_utils
// Params 1, eflags: 0x0
// Checksum 0x463ed392, Offset: 0xcb0
// Size: 0x9d
function getscoreperminute(team) {
    assert(isplayer(self) || isdefined(team));
    minutespassed = gettimepassed() / 60000 + 0.0001;
    if (isplayer(self)) {
        return (globallogic_score::_getplayerscore(self) / minutespassed);
    }
    return getteamscoreforround(team) / minutespassed;
}

// Namespace globallogic_utils
// Params 1, eflags: 0x0
// Checksum 0xbaab4f27, Offset: 0xd58
// Size: 0x87
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
// Checksum 0x22e64580, Offset: 0xde8
// Size: 0x35
function rumbler() {
    self endon(#"disconnect");
    while (true) {
        wait 0.1;
        self playrumbleonentity("damage_heavy");
    }
}

// Namespace globallogic_utils
// Params 2, eflags: 0x0
// Checksum 0x708fb789, Offset: 0xe28
// Size: 0x19
function waitfortimeornotify(time, notifyname) {
    self endon(notifyname);
    wait time;
}

// Namespace globallogic_utils
// Params 2, eflags: 0x0
// Checksum 0x215ec804, Offset: 0xe50
// Size: 0x4d
function waitfortimeornotifynoartillery(time, notifyname) {
    self endon(notifyname);
    wait time;
    while (isdefined(level.artilleryinprogress)) {
        assert(level.artilleryinprogress);
        wait 0.25;
    }
}

// Namespace globallogic_utils
// Params 4, eflags: 0x0
// Checksum 0xf49ced97, Offset: 0xea8
// Size: 0xb7
function isheadshot(weapon, shitloc, smeansofdeath, einflictor) {
    if (shitloc != "head" && shitloc != "helmet") {
        return false;
    }
    switch (smeansofdeath) {
    case "MOD_MELEE":
    case "MOD_MELEE_ASSASSINATE":
        return false;
    case "MOD_IMPACT":
        if (weapon != level.weaponballisticknife) {
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
// Checksum 0xc6abe3a, Offset: 0xf68
// Size: 0xbb
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
    // Checksum 0x40d06681, Offset: 0x1030
    // Size: 0x49
    function debugline(start, end) {
        for (i = 0; i < 50; i++) {
            line(start, end);
            wait 0.05;
        }
    }

#/

// Namespace globallogic_utils
// Params 2, eflags: 0x0
// Checksum 0x65cd7dde, Offset: 0x1088
// Size: 0x3e
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
// Checksum 0xd6eb6668, Offset: 0x10d0
// Size: 0x40
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
    // Params 2, eflags: 0x0
    // Checksum 0xfe67355c, Offset: 0x1118
    // Size: 0xba
    function logteamwinstring(wintype, winner) {
        log_string = wintype;
        if (isdefined(winner)) {
            log_string = log_string + "<dev string:x70>" + winner;
        }
        var_483701de = level.teams;
        var_e9889b08 = firstarray(var_483701de);
        if (isdefined(var_e9889b08)) {
            team = var_483701de[var_e9889b08];
            var_5ea491e3 = nextarray(var_483701de, var_e9889b08);
            InvalidOpCode(0x54, "<dev string:x7b>", team, log_string + "<dev string:x78>" + team + "<dev string:x45>");
            // Unknown operator (0x54, t7_1b, PC)
        }
        print(log_string);
    }

#/
