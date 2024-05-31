#using scripts/shared/bots/_bot;
#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/scoreevents_shared;
#using scripts/shared/rank_shared;
#using scripts/shared/callbacks_shared;

#namespace persistence;

// Namespace persistence
// Params 0, eflags: 0x2
// namespace_fe5e4926<file_0>::function_2dc19561
// Checksum 0x49c3934f, Offset: 0x2e0
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("persistence", &__init__, undefined, undefined);
}

// Namespace persistence
// Params 0, eflags: 0x1 linked
// namespace_fe5e4926<file_0>::function_8c87d8eb
// Checksum 0xb769779c, Offset: 0x320
// Size: 0x44
function __init__() {
    callback::on_start_gametype(&init);
    callback::on_connect(&on_player_connect);
}

// Namespace persistence
// Params 0, eflags: 0x1 linked
// namespace_fe5e4926<file_0>::function_c35e6aab
// Checksum 0x3744d723, Offset: 0x370
// Size: 0x64
function init() {
    level.var_d1b7628a = 1;
    level.persistentdatainfo = [];
    level.maxrecentstats = 10;
    level.maxhitlocations = 19;
    level thread initialize_stat_tracking();
    level thread function_f352670b();
}

// Namespace persistence
// Params 0, eflags: 0x1 linked
// namespace_fe5e4926<file_0>::function_fb4f96b5
// Checksum 0x47bcfeeb, Offset: 0x3e0
// Size: 0x10
function on_player_connect() {
    self.var_84bed14d = 1;
}

// Namespace persistence
// Params 0, eflags: 0x1 linked
// namespace_fe5e4926<file_0>::function_a5fb9690
// Checksum 0x12ea8f85, Offset: 0x3f8
// Size: 0x1f8
function initialize_stat_tracking() {
    level.globalexecutions = 0;
    level.globalchallenges = 0;
    level.globalsharepackages = 0;
    level.globalcontractsfailed = 0;
    level.globalcontractspassed = 0;
    level.globalcontractscppaid = 0;
    level.globalkillstreakscalled = 0;
    level.globalkillstreaksdestroyed = 0;
    level.globalkillstreaksdeathsfrom = 0;
    level.globallarryskilled = 0;
    level.globalbuzzkills = 0;
    level.globalrevives = 0;
    level.globalafterlifes = 0;
    level.globalcomebacks = 0;
    level.globalpaybacks = 0;
    level.globalbackstabs = 0;
    level.globalbankshots = 0;
    level.globalskewered = 0;
    level.globalteammedals = 0;
    level.globalfeetfallen = 0;
    level.globaldistancesprinted = 0;
    level.globaldembombsprotected = 0;
    level.globaldembombsdestroyed = 0;
    level.globalbombsdestroyed = 0;
    level.globalfraggrenadesfired = 0;
    level.globalsatchelchargefired = 0;
    level.globalshotsfired = 0;
    level.globalcrossbowfired = 0;
    level.globalcarsdestroyed = 0;
    level.globalbarrelsdestroyed = 0;
    level.globalbombsdestroyedbyteam = [];
    foreach (team in level.teams) {
        level.globalbombsdestroyedbyteam[team] = 0;
    }
}

// Namespace persistence
// Params 0, eflags: 0x1 linked
// namespace_fe5e4926<file_0>::function_f352670b
// Checksum 0xcff142ce, Offset: 0x5f8
// Size: 0x64c
function function_f352670b() {
    level waittill(#"game_ended");
    if (!level.rankedmatch && !level.wagermatch) {
        return;
    }
    totalkills = 0;
    totaldeaths = 0;
    var_54e4f2af = 0;
    totalheadshots = 0;
    totalsuicides = 0;
    totaltimeplayed = 0;
    var_639d35e8 = 0;
    var_4f996c2b = 0;
    var_aefd4904 = 0;
    var_e8d3218d = 0;
    var_c0810d02 = 0;
    var_5d7be06e = 0;
    var_9f3cccb9 = 0;
    var_3fbec512 = [];
    foreach (team in level.teams) {
        var_3fbec512[team] = 0;
    }
    switch (level.gametype) {
    case 1:
        var_90259f7d = 0;
        for (index = 0; index < level.bombzones.size; index++) {
            if (!isdefined(level.bombzones[index].bombexploded) || !level.bombzones[index].bombexploded) {
                level.globaldembombsprotected++;
                continue;
            }
            level.globaldembombsdestroyed++;
        }
        break;
    case 2:
        foreach (team in level.teams) {
            var_3fbec512[team] = level.globalbombsdestroyedbyteam[team];
        }
        break;
    }
    players = getplayers();
    for (i = 0; i < players.size; i++) {
        player = players[i];
        if (isdefined(player.timeplayed) && isdefined(player.timeplayed["total"])) {
            totaltimeplayed += min(player.timeplayed["total"], level.timeplayedcap);
        }
    }
    if (!util::waslastround()) {
        return;
    }
    wait(0.05);
    players = getplayers();
    for (i = 0; i < players.size; i++) {
        player = players[i];
        totalkills += player.kills;
        totaldeaths += player.deaths;
        var_54e4f2af += player.assists;
        totalheadshots += player.headshots;
        totalsuicides += player.suicides;
        var_9f3cccb9 += player.humiliated;
        if (isdefined(player.timeplayed) && isdefined(player.timeplayed["alive"])) {
            totaltimeplayed += int(min(player.timeplayed["alive"], level.timeplayedcap));
        }
        switch (level.gametype) {
        case 5:
            var_639d35e8 += player.captures;
            var_4f996c2b += player.returns;
            break;
        case 6:
            var_aefd4904 += player.destructions;
            var_e8d3218d += player.captures;
            break;
        case 7:
            var_c0810d02 += player.defuses;
            var_5d7be06e += player.plants;
            break;
        case 2:
            if (isdefined(player.team) && isdefined(level.teams[player.team])) {
                var_3fbec512[player.team] = var_3fbec512[player.team] + player.destructions;
            }
            break;
        }
    }
}

// Namespace persistence
// Params 1, eflags: 0x1 linked
// namespace_fe5e4926<file_0>::function_2369852e
// Checksum 0x1596b8a, Offset: 0xc50
// Size: 0x6a
function function_2369852e(dataname) {
    if (isdefined(level.nopersistence) && level.nopersistence) {
        return 0;
    }
    if (!level.onlinegame) {
        return 0;
    }
    return self getdstat("PlayerStatsByGameType", get_gametype_name(), dataname, "StatValue");
}

// Namespace persistence
// Params 0, eflags: 0x1 linked
// namespace_fe5e4926<file_0>::function_8b287992
// Checksum 0x9c5b71a6, Offset: 0xcc8
// Size: 0x9a
function get_gametype_name() {
    if (!isdefined(level.var_ddcbfa19)) {
        if (isdefined(level.hardcoremode) && level.hardcoremode && is_party_gamemode() == 0) {
            prefix = "HC";
        } else {
            prefix = "";
        }
        level.var_ddcbfa19 = tolower(prefix + level.gametype);
    }
    return level.var_ddcbfa19;
}

// Namespace persistence
// Params 0, eflags: 0x1 linked
// namespace_fe5e4926<file_0>::function_43d40270
// Checksum 0xd64314c3, Offset: 0xd70
// Size: 0x44
function is_party_gamemode() {
    switch (level.gametype) {
    case 12:
    case 13:
    case 14:
    case 15:
        return true;
    }
    return false;
}

// Namespace persistence
// Params 1, eflags: 0x1 linked
// namespace_fe5e4926<file_0>::function_78783533
// Checksum 0xa64ba86b, Offset: 0xdc0
// Size: 0x1e
function function_78783533(dataname) {
    return level.rankedmatch || level.wagermatch;
}

// Namespace persistence
// Params 3, eflags: 0x1 linked
// namespace_fe5e4926<file_0>::function_e885624a
// Checksum 0xc8cd075a, Offset: 0xde8
// Size: 0x9c
function function_e885624a(dataname, value, incvalue) {
    if (isdefined(level.nopersistence) && level.nopersistence) {
        return 0;
    }
    if (!function_78783533(dataname)) {
        return;
    }
    if (level.disablestattracking) {
        return;
    }
    self setdstat("PlayerStatsByGameType", get_gametype_name(), dataname, "StatValue", value);
}

// Namespace persistence
// Params 0, eflags: 0x1 linked
// namespace_fe5e4926<file_0>::function_b33a7ae2
// Checksum 0x72473311, Offset: 0xe90
// Size: 0x64
function adjust_recent_stats() {
    /#
        if (getdvarint("StatValue") == 1 || getdvarint("StatValue") == 1) {
            return;
        }
    #/
    initialize_match_stats();
}

// Namespace persistence
// Params 3, eflags: 0x1 linked
// namespace_fe5e4926<file_0>::function_fe323248
// Checksum 0x6a7ed652, Offset: 0xf00
// Size: 0xec
function get_recent_stat(isglobal, index, statname) {
    if (level.wagermatch) {
        return self getdstat("RecentEarnings", index, statname);
    }
    if (isglobal) {
        modename = util::getcurrentgamemode();
        return self getdstat("gameHistory", modename, "matchHistory", index, statname);
    }
    return self getdstat("PlayerStatsByGameType", get_gametype_name(), "prevScores", index, statname);
}

// Namespace persistence
// Params 4, eflags: 0x1 linked
// namespace_fe5e4926<file_0>::function_ebe77e8c
// Checksum 0x548d8952, Offset: 0xff8
// Size: 0x1a4
function set_recent_stat(isglobal, index, statname, value) {
    if (!isglobal) {
        index = self getdstat("PlayerStatsByGameType", get_gametype_name(), "prevScoreIndex");
        if (index < 0 || index > 9) {
            return;
        }
    }
    if (isdefined(level.nopersistence) && level.nopersistence) {
        return;
    }
    if (!level.onlinegame) {
        return;
    }
    if (!function_78783533(statname)) {
        return;
    }
    if (level.wagermatch) {
        self setdstat("RecentEarnings", index, statname, value);
        return;
    }
    if (isglobal) {
        modename = util::getcurrentgamemode();
        self setdstat("gameHistory", modename, "matchHistory", "" + index, statname, value);
        return;
    }
    self setdstat("PlayerStatsByGameType", get_gametype_name(), "prevScores", index, statname, value);
}

// Namespace persistence
// Params 4, eflags: 0x1 linked
// namespace_fe5e4926<file_0>::function_fc306ea1
// Checksum 0x2c7c70b1, Offset: 0x11a8
// Size: 0x114
function add_recent_stat(isglobal, index, statname, value) {
    if (isdefined(level.nopersistence) && level.nopersistence) {
        return;
    }
    if (!level.onlinegame) {
        return;
    }
    if (!function_78783533(statname)) {
        return;
    }
    if (!isglobal) {
        index = self getdstat("PlayerStatsByGameType", get_gametype_name(), "prevScoreIndex");
        if (index < 0 || index > 9) {
            return;
        }
    }
    currstat = get_recent_stat(isglobal, index, statname);
    set_recent_stat(isglobal, index, statname, currstat + value);
}

// Namespace persistence
// Params 2, eflags: 0x0
// namespace_fe5e4926<file_0>::function_ea30052d
// Checksum 0x7e27caad, Offset: 0x12c8
// Size: 0x8c
function set_match_history_stat(statname, value) {
    modename = util::getcurrentgamemode();
    historyindex = self getdstat("gameHistory", modename, "currentMatchHistoryIndex");
    set_recent_stat(1, historyindex, statname, value);
}

// Namespace persistence
// Params 2, eflags: 0x0
// namespace_fe5e4926<file_0>::function_2354a0d6
// Checksum 0x28b7481f, Offset: 0x1360
// Size: 0x8c
function add_match_history_stat(statname, value) {
    modename = util::getcurrentgamemode();
    historyindex = self getdstat("gameHistory", modename, "currentMatchHistoryIndex");
    add_recent_stat(1, historyindex, statname, value);
}

// Namespace persistence
// Params 0, eflags: 0x1 linked
// namespace_fe5e4926<file_0>::function_f69038f1
// Checksum 0xb95f26c1, Offset: 0x13f8
// Size: 0x15c
function initialize_match_stats() {
    if (isdefined(level.nopersistence) && level.nopersistence) {
        return;
    }
    if (!level.onlinegame) {
        return;
    }
    if (!(level.rankedmatch || level.wagermatch || level.leaguematch)) {
        return;
    }
    self.pers["lastHighestScore"] = self getdstat("HighestStats", "highest_score");
    if (sessionmodeismultiplayergame()) {
        self.pers["lastHighestKills"] = self getdstat("HighestStats", "highest_kills");
        self.pers["lastHighestKDRatio"] = self getdstat("HighestStats", "highest_kdratio");
    }
    currgametype = get_gametype_name();
    self gamehistorystartmatch(getgametypeenumfromname(currgametype, level.hardcoremode));
}

// Namespace persistence
// Params 0, eflags: 0x1 linked
// namespace_fe5e4926<file_0>::function_d1b7628a
// Checksum 0xdbe4a28a, Offset: 0x1560
// Size: 0xa
function function_d1b7628a() {
    return level.var_d1b7628a;
}

// Namespace persistence
// Params 3, eflags: 0x1 linked
// namespace_fe5e4926<file_0>::function_3ec1e50f
// Checksum 0x9b2523cb, Offset: 0x1578
// Size: 0x5c
function function_3ec1e50f(playerindex, statname, value) {
    if (function_d1b7628a()) {
        self setdstat("AfterActionReportStats", "playerStats", playerindex, statname, value);
    }
}

// Namespace persistence
// Params 3, eflags: 0x1 linked
// namespace_fe5e4926<file_0>::function_ae338cde
// Checksum 0xc05153, Offset: 0x15e0
// Size: 0x64
function function_ae338cde(playerindex, medalindex, value) {
    if (function_d1b7628a()) {
        self setdstat("AfterActionReportStats", "playerStats", playerindex, "medals", medalindex, value);
    }
}

// Namespace persistence
// Params 3, eflags: 0x1 linked
// namespace_fe5e4926<file_0>::function_2eb5e93
// Checksum 0x54b78d3, Offset: 0x1650
// Size: 0xe4
function function_2eb5e93(statname, value, index) {
    if (self util::is_bot()) {
        return;
    }
    /#
        if (getdvarint("StatValue") == 1 || getdvarint("StatValue") == 1) {
            return;
        }
    #/
    if (function_d1b7628a()) {
        if (isdefined(index)) {
            self setaarstat(statname, index, value);
            return;
        }
        self setaarstat(statname, value);
    }
}

// Namespace persistence
// Params 7, eflags: 0x1 linked
// namespace_fe5e4926<file_0>::function_14095578
// Checksum 0x94783f53, Offset: 0x1740
// Size: 0x4ec
function codecallback_challengecomplete(rewardxp, maxval, row, tablenumber, challengetype, itemindex, challengeindex) {
    params = spawnstruct();
    params.rewardxp = rewardxp;
    params.maxval = maxval;
    params.row = row;
    params.tablenumber = tablenumber;
    params.challengetype = challengetype;
    params.itemindex = itemindex;
    params.challengeindex = challengeindex;
    if (sessionmodeiscampaigngame()) {
        if (isdefined(self.challenge_callback_cp)) {
            [[ self.challenge_callback_cp ]](rewardxp, maxval, row, tablenumber, challengetype, itemindex, challengeindex);
        }
        return;
    }
    callback::callback(#"hash_b286c65c", params);
    self luinotifyevent(%challenge_complete, 7, challengeindex, itemindex, challengetype, tablenumber, row, maxval, rewardxp);
    self luinotifyeventtospectators(%challenge_complete, 7, challengeindex, itemindex, challengetype, tablenumber, row, maxval, rewardxp);
    tablenumber += 1;
    tablename = "gamedata/stats/mp/statsmilestones" + tablenumber + ".csv";
    challengestring = tablelookupcolumnforrow(tablename, row, 5);
    challengetier = int(tablelookupcolumnforrow(tablename, row, 1));
    matchrecordlogchallengecomplete(self, tablenumber, challengetier, itemindex, challengestring);
    /#
        if (getdvarint("StatValue", 0) != 0) {
            challengedescstring = challengestring + "StatValue";
            challengetiernext = int(tablelookupcolumnforrow(tablename, row + 1, 1));
            tiertext = "StatValue" + challengetier;
            var_a804a5cf = "StatValue";
            herostring = tablelookup(var_a804a5cf, 0, itemindex, 3);
            if (getdvarint("StatValue") == 1) {
                iprintlnbold(makelocalizedstring(challengestring) + "StatValue" + maxval + "StatValue" + makelocalizedstring(herostring));
                return;
            }
            if (getdvarint("StatValue") == 2) {
                self iprintlnbold(makelocalizedstring(challengestring) + "StatValue" + maxval + "StatValue" + makelocalizedstring(herostring));
                return;
            }
            if (getdvarint("StatValue") == 3) {
                iprintln(makelocalizedstring(challengestring) + "StatValue" + maxval + "StatValue" + makelocalizedstring(herostring));
            }
        }
    #/
}

// Namespace persistence
// Params 5, eflags: 0x1 linked
// namespace_fe5e4926<file_0>::function_566d6e6a
// Checksum 0x4b56aa13, Offset: 0x1c38
// Size: 0xc4
function codecallback_gunchallengecomplete(rewardxp, attachmentindex, itemindex, rankid, islastrank) {
    if (sessionmodeiscampaigngame()) {
        self notify(#"gun_level_complete", rewardxp, attachmentindex, itemindex, rankid, islastrank);
        return;
    }
    self luinotifyevent(%gun_level_complete, 4, rankid, itemindex, attachmentindex, rewardxp);
    self luinotifyeventtospectators(%gun_level_complete, 4, rankid, itemindex, attachmentindex, rewardxp);
}

// Namespace persistence
// Params 0, eflags: 0x1 linked
// namespace_fe5e4926<file_0>::function_b526d623
// Checksum 0x99ec1590, Offset: 0x1d08
// Size: 0x4
function function_b526d623() {
    
}

// Namespace persistence
// Params 1, eflags: 0x1 linked
// namespace_fe5e4926<file_0>::function_f81a1bca
// Checksum 0xda1ecc9a, Offset: 0x1d18
// Size: 0xc
function function_f81a1bca(var_9c648312) {
    
}

// Namespace persistence
// Params 2, eflags: 0x1 linked
// namespace_fe5e4926<file_0>::function_8e1fc5b5
// Checksum 0x1cf34034, Offset: 0x1d30
// Size: 0x14
function function_8e1fc5b5(index, passed) {
    
}

// Namespace persistence
// Params 0, eflags: 0x1 linked
// namespace_fe5e4926<file_0>::function_9392f054
// Checksum 0x2bfc891e, Offset: 0x1d50
// Size: 0x44
function upload_stats_soon() {
    self notify(#"upload_stats_soon");
    self endon(#"upload_stats_soon");
    self endon(#"disconnect");
    wait(1);
    uploadstats(self);
}

// Namespace persistence
// Params 2, eflags: 0x1 linked
// namespace_fe5e4926<file_0>::function_75855e8f
// Checksum 0x18c2ee21, Offset: 0x1da0
// Size: 0x14
function function_75855e8f(dataname, value) {
    
}

// Namespace persistence
// Params 3, eflags: 0x1 linked
// namespace_fe5e4926<file_0>::function_faa796b4
// Checksum 0xa2ad2f60, Offset: 0x1dc0
// Size: 0x1c
function function_faa796b4(weapon, dataname, value) {
    
}

// Namespace persistence
// Params 4, eflags: 0x0
// namespace_fe5e4926<file_0>::function_8cbcaaa5
// Checksum 0xa75f9d15, Offset: 0x1de8
// Size: 0x24
function function_8cbcaaa5(stattype, dataname, value, weapon) {
    
}

