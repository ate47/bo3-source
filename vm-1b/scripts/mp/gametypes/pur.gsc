#using scripts/mp/_util;
#using scripts/mp/gametypes/_globallogic;
#using scripts/mp/gametypes/_globallogic_audio;
#using scripts/mp/gametypes/_globallogic_defaults;
#using scripts/mp/gametypes/_globallogic_score;
#using scripts/mp/gametypes/_globallogic_utils;
#using scripts/mp/gametypes/_spawning;
#using scripts/mp/gametypes/_spawnlogic;
#using scripts/shared/gameobjects_shared;
#using scripts/shared/math_shared;
#using scripts/shared/util_shared;

#namespace pur;

// Namespace pur
// Params 0, eflags: 0x0
// Checksum 0xb6690156, Offset: 0x410
// Size: 0x1e9
function main() {
    globallogic::init();
    util::registerroundswitch(0, 9);
    util::registertimelimit(0, 1440);
    util::registerscorelimit(0, 50000);
    util::registerroundlimit(0, 10);
    util::registerroundwinlimit(0, 10);
    util::registernumlives(0, 10);
    globallogic::registerfriendlyfiredelay(level.gametype, 15, 0, 1440);
    level.cumulativeroundscores = getgametypesetting("cumulativeRoundScores");
    level.teambased = 1;
    level.onstartgametype = &onstartgametype;
    level.onspawnplayer = &onspawnplayer;
    level.onroundendgame = &onroundendgame;
    level.onroundswitch = &onroundswitch;
    level.ondeadevent = &ondeadevent;
    level.onlastteamaliveevent = &onlastteamaliveevent;
    level.onalivecountchange = &onalivecountchange;
    level.spawnmessage = &function_71ebb03f;
    level.onspawnspectator = &onspawnspectator;
    level.onrespawndelay = &getrespawndelay;
    gameobjects::register_allowed_gameobject("tdm");
    InvalidOpCode(0xc8, "dialog", "gametype", "tdm_start");
    // Unknown operator (0xc8, t7_1b, PC)
}

// Namespace pur
// Params 0, eflags: 0x0
// Checksum 0x946d9357, Offset: 0x6b0
// Size: 0x71
function onstartgametype() {
    setclientnamemode("auto_change");
    InvalidOpCode(0x54, "switchedsides");
    // Unknown operator (0x54, t7_1b, PC)
}

// Namespace pur
// Params 0, eflags: 0x0
// Checksum 0x33879694, Offset: 0x988
// Size: 0x21
function function_78a36e4c() {
    while (self.sessionstate == "dead") {
        wait 0.05;
    }
}

// Namespace pur
// Params 1, eflags: 0x0
// Checksum 0x3f61fdc2, Offset: 0x9b8
// Size: 0x62
function onspawnplayer(predictedspawn) {
    self endon(#"disconnect");
    level endon(#"end_game");
    self.usingobj = undefined;
    self function_92fa676f();
    self function_78a36e4c();
    self util::clearlowermessage();
    spawning::onspawnplayer(predictedspawn);
}

// Namespace pur
// Params 2, eflags: 0x0
// Checksum 0xcd855960, Offset: 0xa28
// Size: 0x22
function function_67248e13(winningteam, endreasontext) {
    thread globallogic::endgame(winningteam, endreasontext);
}

// Namespace pur
// Params 1, eflags: 0x0
// Checksum 0xfa6b8e62, Offset: 0xa58
// Size: 0x1a
function onalivecountchange(team) {
    level thread function_446c8d00(team);
}

// Namespace pur
// Params 1, eflags: 0x0
// Checksum 0x10d030c, Offset: 0xa80
// Size: 0xaa
function onlastteamaliveevent(team) {
    if (level.multiteam) {
        function_67248e13(team, %MP_ALL_TEAMS_ELIMINATED);
        return;
    }
    InvalidOpCode(0x54, "attackers", team);
    // Unknown operator (0x54, t7_1b, PC)
}

// Namespace pur
// Params 1, eflags: 0x0
// Checksum 0x175eb22e, Offset: 0xb38
// Size: 0x3a
function ondeadevent(team) {
    if (team == "all") {
        InvalidOpCode(0x54, "strings", "round_draw");
        // Unknown operator (0x54, t7_1b, PC)
    }
}

// Namespace pur
// Params 1, eflags: 0x0
// Checksum 0x793eed0c, Offset: 0xb80
// Size: 0x32
function onendgame(winningteam) {
    if (isdefined(winningteam) && isdefined(level.teams[winningteam])) {
        globallogic_score::giveteamscoreforobjective(winningteam, 1);
    }
}

// Namespace pur
// Params 0, eflags: 0x0
// Checksum 0xf21d06b5, Offset: 0xbc0
// Size: 0x29
function onroundswitch() {
    InvalidOpCode(0x54, "switchedsides");
    // Unknown operator (0x54, t7_1b, PC)
}

// Namespace pur
// Params 1, eflags: 0x0
// Checksum 0xc064ca5c, Offset: 0xc50
// Size: 0xb6
function onroundendgame(roundwinner) {
    if (level.scoreroundwinbased) {
        var_5372c54a = level.teams;
        var_86ffd44 = firstarray(var_5372c54a);
        if (isdefined(var_86ffd44)) {
            team = var_5372c54a[var_86ffd44];
            var_8baa1d2b = nextarray(var_5372c54a, var_86ffd44);
            InvalidOpCode(0x54, "roundswon", team);
            // Unknown operator (0x54, t7_1b, PC)
        }
        winner = globallogic::determineteamwinnerbygamestat("roundswon");
    } else {
        winner = globallogic::determineteamwinnerbyteamscore();
    }
    return winner;
}

// Namespace pur
// Params 0, eflags: 0x0
// Checksum 0x25dbc057, Offset: 0xd10
// Size: 0x149
function onscoreclosemusic() {
    teamscores = [];
    while (!level.gameended) {
        scorelimit = level.scorelimit;
        scorethreshold = scorelimit * 0.1;
        scorethresholdstart = abs(scorelimit - scorethreshold);
        scorelimitcheck = scorelimit - 10;
        topscore = 0;
        runnerupscore = 0;
        foreach (team in level.teams) {
            score = [[ level._getteamscore ]](team);
            if (score > topscore) {
                runnerupscore = topscore;
                topscore = score;
                continue;
            }
            if (score > runnerupscore) {
                runnerupscore = score;
            }
        }
        scoredif = topscore - runnerupscore;
        if (scoredif <= scorethreshold && scorethresholdstart <= topscore) {
            thread globallogic_audio::set_music_on_team("timeOut");
            return;
        }
        wait 1;
    }
}

// Namespace pur
// Params 2, eflags: 0x0
// Checksum 0xcb4f2b, Offset: 0xe68
// Size: 0x14a
function function_66ffb804(team, y_pos) {
    self.var_5e316eb1[team] = newclienthudelem(self);
    self.var_5e316eb1[team].fontscale = 1.25;
    self.var_5e316eb1[team].x = 110;
    self.var_5e316eb1[team].y = y_pos;
    self.var_5e316eb1[team].alignx = "right";
    self.var_5e316eb1[team].aligny = "top";
    self.var_5e316eb1[team].horzalign = "left";
    self.var_5e316eb1[team].vertalign = "top";
    self.var_5e316eb1[team].foreground = 1;
    self.var_5e316eb1[team].hidewhendead = 0;
    self.var_5e316eb1[team].hidewheninmenu = 1;
    self.var_5e316eb1[team].archived = 0;
    self.var_5e316eb1[team].alpha = 1;
    self.var_5e316eb1[team].label = %MP_PURGATORY_ENEMY_COUNT;
}

// Namespace pur
// Params 0, eflags: 0x0
// Checksum 0x22635a15, Offset: 0xfc0
// Size: 0x29a
function function_92fa676f() {
    if (isdefined(self.var_5e316eb1)) {
        if (self.pers["team"] == self.var_ae52dbae) {
            return;
        }
        foreach (elem in self.var_5e316eb1) {
            elem destroy();
        }
    }
    self.var_5e316eb1 = [];
    y_pos = 115;
    var_33393887 = 15;
    team = self.pers["team"];
    self.var_ae52dbae = team;
    self.var_5e316eb1[team] = newclienthudelem(self);
    self.var_5e316eb1[team].fontscale = 1.25;
    self.var_5e316eb1[team].x = 110;
    self.var_5e316eb1[team].y = y_pos;
    self.var_5e316eb1[team].alignx = "right";
    self.var_5e316eb1[team].aligny = "top";
    self.var_5e316eb1[team].horzalign = "left";
    self.var_5e316eb1[team].vertalign = "top";
    self.var_5e316eb1[team].foreground = 1;
    self.var_5e316eb1[team].hidewhendead = 0;
    self.var_5e316eb1[team].hidewheninmenu = 1;
    self.var_5e316eb1[team].archived = 0;
    self.var_5e316eb1[team].alpha = 1;
    self.var_5e316eb1[team].label = %MP_PURGATORY_TEAMMATE_COUNT;
    foreach (team in level.teams) {
        if (team == self.team) {
            continue;
        }
        y_pos += var_33393887;
        function_66ffb804(team, y_pos);
    }
    self thread function_5891e6ab();
    self thread function_f62e26bc();
}

// Namespace pur
// Params 0, eflags: 0x0
// Checksum 0x936d1056, Offset: 0x1268
// Size: 0xe5
function function_f62e26bc() {
    self endon(#"disconnect");
    level endon(#"end_game");
    while (true) {
        if (self.team != "spectator") {
            self.var_5e316eb1[self.team] setvalue(level.deadplayers[self.team].size);
            foreach (team in level.teams) {
                if (self.team == team) {
                    continue;
                }
                self.var_5e316eb1[team] setvalue(level.alivecount[team]);
            }
        }
        wait 0.25;
    }
}

// Namespace pur
// Params 0, eflags: 0x0
// Checksum 0x47781552, Offset: 0x1358
// Size: 0x67
function function_5891e6ab() {
    level waittill(#"game_ended");
    foreach (elem in self.var_5e316eb1) {
        elem.alpha = 0;
    }
}

// Namespace pur
// Params 0, eflags: 0x0
// Checksum 0x9fcf031d, Offset: 0x13c8
// Size: 0x72
function function_32ac38fb() {
    if (self.waitingtospawn) {
        return;
    }
    if (self.name == "TolucaLake") {
        shit = 0;
    }
    if (self.spawnqueueindex != 0) {
        self util::function_9468e63a(%MP_PURGATORY_QUEUE_POSITION, self.spawnqueueindex + 1, 1);
        return;
    }
    self util::function_9468e63a(%MP_PURGATORY_NEXT_SPAWN, undefined, 0);
}

// Namespace pur
// Params 0, eflags: 0x0
// Checksum 0x402ea0ac, Offset: 0x1448
// Size: 0x12
function function_71ebb03f() {
    util::waittillslowprocessallowed();
}

// Namespace pur
// Params 2, eflags: 0x0
// Checksum 0xe54dbb22, Offset: 0x1468
// Size: 0x32
function onspawnspectator(origin, angles) {
    self function_32ac38fb();
    globallogic_defaults::default_onspawnspectator(origin, angles);
}

// Namespace pur
// Params 1, eflags: 0x0
// Checksum 0x6cc1c55c, Offset: 0x14a8
// Size: 0xa9
function function_446c8d00(team) {
    self notify(#"hash_446c8d00");
    self endon(#"hash_446c8d00");
    util::waittillslowprocessallowed();
    players = level.deadplayers[team];
    for (i = 0; i < players.size; i++) {
        player = players[i];
        if (!player.waitingtospawn && player.sessionstate != "dead" && !isdefined(player.killcam)) {
            player function_32ac38fb();
        }
    }
}

// Namespace pur
// Params 0, eflags: 0x0
// Checksum 0x611e8f73, Offset: 0x1560
// Size: 0x11
function getrespawndelay() {
    self.var_fc558bd1 = undefined;
    return level.playerrespawndelay;
}

