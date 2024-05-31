#using scripts/mp/_util;
#using scripts/mp/gametypes/_spawnlogic;
#using scripts/mp/gametypes/_spawning;
#using scripts/mp/gametypes/_globallogic_utils;
#using scripts/mp/gametypes/_globallogic_score;
#using scripts/mp/gametypes/_globallogic_defaults;
#using scripts/mp/gametypes/_globallogic_audio;
#using scripts/mp/gametypes/_globallogic;
#using scripts/shared/util_shared;
#using scripts/shared/math_shared;
#using scripts/shared/gameobjects_shared;

#namespace namespace_fc10b9aa;

// Namespace namespace_fc10b9aa
// Params 0, eflags: 0x0
// namespace_fc10b9aa<file_0>::function_d290ebfa
// Checksum 0x54a61887, Offset: 0x410
// Size: 0x2d4
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
    game["dialog"]["gametype"] = "tdm_start";
    game["dialog"]["gametype_hardcore"] = "hctdm_start";
    game["dialog"]["offense_obj"] = "generic_boost";
    game["dialog"]["defense_obj"] = "generic_boost";
    game["dialog"]["sudden_death"] = "generic_boost";
    globallogic::setvisiblescoreboardcolumns("score", "kills", "deaths", "kdratio", "assists");
}

// Namespace namespace_fc10b9aa
// Params 0, eflags: 0x0
// namespace_fc10b9aa<file_0>::function_34685338
// Checksum 0x930182aa, Offset: 0x6f0
// Size: 0x39c
function onstartgametype() {
    setclientnamemode("auto_change");
    if (!isdefined(game["switchedsides"])) {
        game["switchedsides"] = 0;
    }
    if (game["switchedsides"]) {
        oldattackers = game["attackers"];
        olddefenders = game["defenders"];
        game["attackers"] = olddefenders;
        game["defenders"] = oldattackers;
    }
    spawning::create_map_placed_influencers();
    level.spawnmins = (0, 0, 0);
    level.spawnmaxs = (0, 0, 0);
    foreach (team in level.teams) {
        util::setobjectivetext(team, %OBJECTIVES_TDM);
        util::setobjectivehinttext(team, %OBJECTIVES_TDM_HINT);
        if (level.splitscreen) {
            util::setobjectivescoretext(team, %OBJECTIVES_TDM);
        } else {
            util::setobjectivescoretext(team, %OBJECTIVES_TDM_SCORE);
        }
        spawnlogic::place_spawn_points(spawning::gettdmstartspawnname(team));
        spawnlogic::add_spawn_points(team, "mp_tdm_spawn");
    }
    spawning::updateallspawnpoints();
    level.spawn_start = [];
    foreach (team in level.teams) {
        level.spawn_start[team] = spawnlogic::get_spawnpoint_array(spawning::gettdmstartspawnname(team));
    }
    level.mapcenter = math::find_box_center(level.spawnmins, level.spawnmaxs);
    setmapcenter(level.mapcenter);
    spawnpoint = spawnlogic::get_random_intermission_point();
    setdemointermissionpoint(spawnpoint.origin, spawnpoint.angles);
    level.displayroundendtext = 0;
    if (!util::isoneround()) {
        level.displayroundendtext = 1;
        if (level.scoreroundwinbased) {
            globallogic_score::resetteamscores();
        }
    }
}

// Namespace namespace_fc10b9aa
// Params 0, eflags: 0x0
// namespace_fc10b9aa<file_0>::function_78a36e4c
// Checksum 0x74146a10, Offset: 0xa98
// Size: 0x24
function function_78a36e4c() {
    while (self.sessionstate == "dead") {
        wait(0.05);
    }
}

// Namespace namespace_fc10b9aa
// Params 1, eflags: 0x0
// namespace_fc10b9aa<file_0>::function_19bc9234
// Checksum 0x664f3717, Offset: 0xac8
// Size: 0x84
function onspawnplayer(predictedspawn) {
    self endon(#"disconnect");
    level endon(#"end_game");
    self.usingobj = undefined;
    self function_92fa676f();
    self function_78a36e4c();
    self util::clearlowermessage();
    spawning::onspawnplayer(predictedspawn);
}

// Namespace namespace_fc10b9aa
// Params 2, eflags: 0x0
// namespace_fc10b9aa<file_0>::function_67248e13
// Checksum 0x71533485, Offset: 0xb58
// Size: 0x2c
function function_67248e13(winningteam, endreasontext) {
    thread globallogic::endgame(winningteam, endreasontext);
}

// Namespace namespace_fc10b9aa
// Params 1, eflags: 0x0
// namespace_fc10b9aa<file_0>::function_8a94d3c2
// Checksum 0x1d68fb80, Offset: 0xb90
// Size: 0x24
function onalivecountchange(team) {
    level thread function_446c8d00(team);
}

// Namespace namespace_fc10b9aa
// Params 1, eflags: 0x0
// namespace_fc10b9aa<file_0>::function_a8cf0ca0
// Checksum 0x6104d4c8, Offset: 0xbc0
// Size: 0xe4
function onlastteamaliveevent(team) {
    if (level.multiteam) {
        function_67248e13(team, %MP_ALL_TEAMS_ELIMINATED);
        return;
    }
    if (team == game["attackers"]) {
        function_67248e13(game["attackers"], game["strings"][game["defenders"] + "_eliminated"]);
        return;
    }
    if (team == game["defenders"]) {
        function_67248e13(game["defenders"], game["strings"][game["attackers"] + "_eliminated"]);
    }
}

// Namespace namespace_fc10b9aa
// Params 1, eflags: 0x0
// namespace_fc10b9aa<file_0>::function_e0db18e8
// Checksum 0xeda0f431, Offset: 0xcb0
// Size: 0x4c
function ondeadevent(team) {
    if (team == "all") {
        function_67248e13("tie", game["strings"]["round_draw"]);
    }
}

// Namespace namespace_fc10b9aa
// Params 1, eflags: 0x0
// namespace_fc10b9aa<file_0>::function_257d1c47
// Checksum 0xd34ea38c, Offset: 0xd08
// Size: 0x44
function onendgame(winningteam) {
    if (isdefined(winningteam) && isdefined(level.teams[winningteam])) {
        globallogic_score::giveteamscoreforobjective(winningteam, 1);
    }
}

// Namespace namespace_fc10b9aa
// Params 0, eflags: 0x0
// namespace_fc10b9aa<file_0>::function_e4e885e6
// Checksum 0x781d1b6f, Offset: 0xd58
// Size: 0xba
function onroundswitch() {
    game["switchedsides"] = !game["switchedsides"];
    if (level.scoreroundwinbased) {
        foreach (team in level.teams) {
            [[ level._setteamscore ]](team, game["roundswon"][team]);
        }
    }
}

// Namespace namespace_fc10b9aa
// Params 1, eflags: 0x0
// namespace_fc10b9aa<file_0>::function_3fcd5617
// Checksum 0xb73f6456, Offset: 0xe20
// Size: 0xec
function onroundendgame(roundwinner) {
    if (level.scoreroundwinbased) {
        foreach (team in level.teams) {
            [[ level._setteamscore ]](team, game["roundswon"][team]);
        }
        winner = globallogic::determineteamwinnerbygamestat("roundswon");
    } else {
        winner = globallogic::determineteamwinnerbyteamscore();
    }
    return winner;
}

// Namespace namespace_fc10b9aa
// Params 0, eflags: 0x0
// namespace_fc10b9aa<file_0>::function_5cee117d
// Checksum 0xc10e2734, Offset: 0xf18
// Size: 0x1d8
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
        wait(1);
    }
}

// Namespace namespace_fc10b9aa
// Params 2, eflags: 0x0
// namespace_fc10b9aa<file_0>::function_66ffb804
// Checksum 0x4334df6, Offset: 0x10f8
// Size: 0x1c4
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

// Namespace namespace_fc10b9aa
// Params 0, eflags: 0x0
// namespace_fc10b9aa<file_0>::function_92fa676f
// Checksum 0x17465b07, Offset: 0x12c8
// Size: 0x394
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

// Namespace namespace_fc10b9aa
// Params 0, eflags: 0x0
// namespace_fc10b9aa<file_0>::function_f62e26bc
// Checksum 0x15d6c360, Offset: 0x1668
// Size: 0x138
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
        wait(0.25);
    }
}

// Namespace namespace_fc10b9aa
// Params 0, eflags: 0x0
// namespace_fc10b9aa<file_0>::function_5891e6ab
// Checksum 0xcf227ed3, Offset: 0x17a8
// Size: 0x92
function function_5891e6ab() {
    level waittill(#"game_ended");
    foreach (elem in self.var_5e316eb1) {
        elem.alpha = 0;
    }
}

// Namespace namespace_fc10b9aa
// Params 0, eflags: 0x0
// namespace_fc10b9aa<file_0>::function_32ac38fb
// Checksum 0xf5633ae2, Offset: 0x1848
// Size: 0x94
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

// Namespace namespace_fc10b9aa
// Params 0, eflags: 0x0
// namespace_fc10b9aa<file_0>::function_71ebb03f
// Checksum 0x83a81fb8, Offset: 0x18e8
// Size: 0x14
function function_71ebb03f() {
    util::waittillslowprocessallowed();
}

// Namespace namespace_fc10b9aa
// Params 2, eflags: 0x0
// namespace_fc10b9aa<file_0>::function_62209e9a
// Checksum 0x9966a59, Offset: 0x1908
// Size: 0x44
function onspawnspectator(origin, angles) {
    self function_32ac38fb();
    globallogic_defaults::default_onspawnspectator(origin, angles);
}

// Namespace namespace_fc10b9aa
// Params 1, eflags: 0x0
// namespace_fc10b9aa<file_0>::function_446c8d00
// Checksum 0x932f4e0e, Offset: 0x1958
// Size: 0xf6
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

// Namespace namespace_fc10b9aa
// Params 0, eflags: 0x0
// namespace_fc10b9aa<file_0>::function_712cf456
// Checksum 0x5525f0b1, Offset: 0x1a58
// Size: 0x16
function getrespawndelay() {
    self.var_fc558bd1 = undefined;
    return level.playerrespawndelay;
}

