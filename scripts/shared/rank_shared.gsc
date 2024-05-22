#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/scoreevents_shared;
#using scripts/shared/hud_shared;
#using scripts/shared/callbacks_shared;
#using scripts/codescripts/struct;

#namespace rank;

// Namespace rank
// Params 0, eflags: 0x2
// Checksum 0xad97ce6b, Offset: 0x6e0
// Size: 0x34
function function_2dc19561() {
    system::register("rank", &__init__, undefined, undefined);
}

// Namespace rank
// Params 0, eflags: 0x1 linked
// Checksum 0x51e9fe91, Offset: 0x720
// Size: 0x24
function __init__() {
    callback::on_start_gametype(&init);
}

// Namespace rank
// Params 0, eflags: 0x1 linked
// Checksum 0x6c7a32a6, Offset: 0x750
// Size: 0x584
function init() {
    level.scoreinfo = [];
    level.var_9364c56a = getdvarfloat("scr_codpointsxpscale");
    level.var_c1745e43 = getdvarfloat("scr_codpointsmatchscale");
    level.var_4e39954b = getdvarfloat("scr_codpointsperchallenge");
    level.rankxpcap = getdvarint("scr_rankXpCap");
    level.var_1846c294 = getdvarint("scr_codPointsCap");
    level.usingmomentum = 1;
    level.usingscorestreaks = getdvarint("scr_scorestreaks") != 0;
    level.scorestreaksmaxstacking = getdvarint("scr_scorestreaks_maxstacking");
    level.maxinventoryscorestreaks = getdvarint("scr_maxinventory_scorestreaks", 3);
    level.usingrampage = !isdefined(level.usingscorestreaks) || !level.usingscorestreaks;
    level.rampagebonusscale = getdvarfloat("scr_rampagebonusscale");
    level.ranktable = [];
    if (sessionmodeiscampaigngame()) {
        level.xpscale = getdvarfloat("scr_xpscalecp");
        level.var_b7e5f751 = "gamedata/tables/cp/cp_ranktable.csv";
        level.var_55417986 = "gamedata/tables/cp/cp_rankIconTable.csv";
    } else if (sessionmodeiszombiesgame()) {
        level.xpscale = getdvarfloat("scr_xpscalezm");
        level.var_b7e5f751 = "gamedata/tables/zm/zm_ranktable.csv";
        level.var_55417986 = "gamedata/tables/zm/zm_rankIconTable.csv";
    } else {
        level.xpscale = getdvarfloat("scr_xpscalemp");
        level.var_b7e5f751 = "gamedata/tables/mp/mp_ranktable.csv";
        level.var_55417986 = "gamedata/tables/mp/mp_rankIconTable.csv";
    }
    initscoreinfo();
    level.maxrank = int(tablelookup(level.var_b7e5f751, 0, "maxrank", 1));
    level.var_52e3d4cf = int(tablelookup(level.var_b7e5f751, 0, "maxrankstarterpack", 1));
    level.maxprestige = int(tablelookup(level.var_55417986, 0, "maxprestige", 1));
    rankid = 0;
    rankname = tablelookup(level.var_b7e5f751, 0, rankid, 1);
    /#
        assert(isdefined(rankname) && rankname != "scr_maxinventory_scorestreaks");
    #/
    while (isdefined(rankname) && rankname != "") {
        level.ranktable[rankid][1] = tablelookup(level.var_b7e5f751, 0, rankid, 1);
        level.ranktable[rankid][2] = tablelookup(level.var_b7e5f751, 0, rankid, 2);
        level.ranktable[rankid][3] = tablelookup(level.var_b7e5f751, 0, rankid, 3);
        level.ranktable[rankid][7] = tablelookup(level.var_b7e5f751, 0, rankid, 7);
        level.ranktable[rankid][14] = tablelookup(level.var_b7e5f751, 0, rankid, 14);
        if (sessionmodeiscampaigngame()) {
            level.ranktable[rankid][18] = tablelookup(level.var_b7e5f751, 0, rankid, 18);
        }
        rankid++;
        rankname = tablelookup(level.var_b7e5f751, 0, rankid, 1);
    }
    callback::on_connect(&on_player_connect);
}

// Namespace rank
// Params 0, eflags: 0x1 linked
// Checksum 0xbb4afa63, Offset: 0xce0
// Size: 0x56c
function initscoreinfo() {
    scoreinfotableid = scoreevents::getscoreeventtableid();
    /#
        assert(isdefined(scoreinfotableid));
    #/
    if (!isdefined(scoreinfotableid)) {
        return;
    }
    var_18ebc12b = scoreevents::function_575986e3(level.gametype);
    var_dfa86877 = scoreevents::function_6dd97e6b(level.gametype);
    /#
        assert(var_18ebc12b >= 0);
    #/
    if (var_18ebc12b < 0) {
        return;
    }
    /#
        assert(var_dfa86877 >= 0);
    #/
    if (var_dfa86877 < 0) {
        return;
    }
    for (row = 1; row < 512; row++) {
        type = tablelookupcolumnforrow(scoreinfotableid, row, 0);
        if (type != "") {
            labelstring = tablelookupcolumnforrow(scoreinfotableid, row, 1);
            label = undefined;
            if (labelstring != "") {
                label = tablelookupistring(scoreinfotableid, 0, type, 1);
            }
            var_aeb909a7 = tablelookupcolumnforrow(scoreinfotableid, row, 4);
            var_cfc9e1bc = undefined;
            if (var_aeb909a7 != "") {
                var_cfc9e1bc = tablelookupistring(scoreinfotableid, 0, type, 4);
            }
            scorevalue = int(tablelookupcolumnforrow(scoreinfotableid, row, var_18ebc12b));
            xpvalue = int(tablelookupcolumnforrow(scoreinfotableid, row, var_dfa86877));
            registerscoreinfo(type, scorevalue, xpvalue, label, var_cfc9e1bc);
            if (!isdefined(game["ScoreInfoInitialized"])) {
                xpvalue = float(tablelookupcolumnforrow(scoreinfotableid, row, var_dfa86877));
                setddlstat = tablelookupcolumnforrow(scoreinfotableid, row, 8);
                addplayerstat = 0;
                if (setddlstat == "TRUE") {
                    addplayerstat = 1;
                }
                ismedal = 0;
                istring = tablelookupistring(scoreinfotableid, 0, type, 2);
                if (isdefined(istring) && istring != %) {
                    ismedal = 1;
                }
                var_f9ae5f2c = int(tablelookupcolumnforrow(scoreinfotableid, row, 9));
                if (!isdefined(var_f9ae5f2c)) {
                    var_f9ae5f2c = 0;
                }
                registerxp(type, xpvalue, addplayerstat, ismedal, var_f9ae5f2c, row);
            }
            var_4ee997a1 = tablelookupcolumnforrow(scoreinfotableid, row, 5);
            if (var_4ee997a1 == "TRUE") {
                level.scoreinfo[type]["allowKillstreakWeapons"] = 1;
            }
            var_717f4a38 = tablelookupcolumnforrow(scoreinfotableid, row, 7);
            if (var_717f4a38 == "TRUE") {
                level.scoreinfo[type]["allow_hero"] = 1;
            }
            var_66b8395e = tablelookupcolumnforrow(scoreinfotableid, row, 6);
            if (isdefined(var_66b8395e) && var_66b8395e != "") {
                level.scoreinfo[type]["combat_efficiency_event"] = var_66b8395e;
            }
        }
    }
    game["ScoreInfoInitialized"] = 1;
}

// Namespace rank
// Params 1, eflags: 0x1 linked
// Checksum 0xca12b509, Offset: 0x1258
// Size: 0x40
function getrankxpcapped(inrankxp) {
    if (isdefined(level.rankxpcap) && level.rankxpcap && level.rankxpcap <= inrankxp) {
        return level.rankxpcap;
    }
    return inrankxp;
}

// Namespace rank
// Params 1, eflags: 0x1 linked
// Checksum 0x543daeeb, Offset: 0x12a0
// Size: 0x40
function function_35db3641(var_9400f55b) {
    if (isdefined(level.var_1846c294) && level.var_1846c294 && level.var_1846c294 <= var_9400f55b) {
        return level.var_1846c294;
    }
    return var_9400f55b;
}

// Namespace rank
// Params 5, eflags: 0x1 linked
// Checksum 0x2f451c23, Offset: 0x12e8
// Size: 0x1b0
function registerscoreinfo(type, value, xp, label, var_cfc9e1bc) {
    overridedvar = "scr_" + level.gametype + "_score_" + type;
    if (getdvarstring(overridedvar) != "") {
        value = getdvarint(overridedvar);
    }
    if (type == "kill") {
        multiplier = getgametypesetting("killEventScoreMultiplier");
        level.scoreinfo[type]["value"] = value;
        if (multiplier > 0) {
            level.scoreinfo[type]["value"] = int(multiplier * value);
        }
    } else {
        level.scoreinfo[type]["value"] = value;
    }
    level.scoreinfo[type]["xp"] = xp;
    if (isdefined(label)) {
        level.scoreinfo[type]["label"] = label;
    }
    if (isdefined(var_cfc9e1bc)) {
        level.scoreinfo[type]["team_icon"] = var_cfc9e1bc;
    }
}

// Namespace rank
// Params 1, eflags: 0x1 linked
// Checksum 0x2645d314, Offset: 0x14a0
// Size: 0x7a
function getscoreinfovalue(type) {
    if (isdefined(level.scoreinfo[type])) {
        n_score = level.scoreinfo[type]["value"];
        if (isdefined(level.scoremodifiercallback) && isdefined(n_score)) {
            n_score = [[ level.scoremodifiercallback ]](type, n_score);
        }
        return n_score;
    }
}

// Namespace rank
// Params 1, eflags: 0x1 linked
// Checksum 0x3ceb7265, Offset: 0x1528
// Size: 0x7a
function getscoreinfoxp(type) {
    if (isdefined(level.scoreinfo[type])) {
        n_xp = level.scoreinfo[type]["xp"];
        if (isdefined(level.xpmodifiercallback) && isdefined(n_xp)) {
            n_xp = [[ level.xpmodifiercallback ]](type, n_xp);
        }
        return n_xp;
    }
}

// Namespace rank
// Params 1, eflags: 0x0
// Checksum 0x2adc181e, Offset: 0x15b0
// Size: 0x58
function shouldskipmomentumdisplay(type) {
    if (isdefined(level.disablemomentum) && level.disablemomentum) {
        return true;
    }
    if (isdefined(level.var_d9b0545b) && isdefined(level.scoreinfo[type]["team_icon"])) {
        return true;
    }
    return false;
}

// Namespace rank
// Params 1, eflags: 0x1 linked
// Checksum 0x3a8619fd, Offset: 0x1610
// Size: 0x22
function getscoreinfolabel(type) {
    return level.scoreinfo[type]["label"];
}

// Namespace rank
// Params 1, eflags: 0x1 linked
// Checksum 0x41cc360, Offset: 0x1640
// Size: 0x22
function getcombatefficiencyevent(type) {
    return level.scoreinfo[type]["combat_efficiency_event"];
}

// Namespace rank
// Params 1, eflags: 0x1 linked
// Checksum 0x859ba387, Offset: 0x1670
// Size: 0x3e
function doesscoreinfocounttowardrampage(type) {
    return isdefined(level.scoreinfo[type]["rampage"]) && level.scoreinfo[type]["rampage"];
}

// Namespace rank
// Params 1, eflags: 0x1 linked
// Checksum 0xae52a085, Offset: 0x16b8
// Size: 0x32
function getrankinfominxp(rankid) {
    return int(level.ranktable[rankid][2]);
}

// Namespace rank
// Params 1, eflags: 0x1 linked
// Checksum 0xa9d64b95, Offset: 0x16f8
// Size: 0x32
function getrankinfoxpamt(rankid) {
    return int(level.ranktable[rankid][3]);
}

// Namespace rank
// Params 1, eflags: 0x1 linked
// Checksum 0x2e3b73e9, Offset: 0x1738
// Size: 0x32
function getrankinfomaxxp(rankid) {
    return int(level.ranktable[rankid][7]);
}

// Namespace rank
// Params 1, eflags: 0x0
// Checksum 0x692d9c7d, Offset: 0x1778
// Size: 0x2a
function getrankinfofull(rankid) {
    return tablelookupistring(level.var_b7e5f751, 0, rankid, 16);
}

// Namespace rank
// Params 2, eflags: 0x0
// Checksum 0xc8abbfc0, Offset: 0x17b0
// Size: 0x3a
function getrankinfoicon(rankid, prestigeid) {
    return tablelookup(level.var_55417986, 0, rankid, prestigeid + 1);
}

// Namespace rank
// Params 1, eflags: 0x0
// Checksum 0xbeddb22c, Offset: 0x17f8
// Size: 0x42
function getrankinfolevel(rankid) {
    return int(tablelookup(level.var_b7e5f751, 0, rankid, 13));
}

// Namespace rank
// Params 1, eflags: 0x1 linked
// Checksum 0x4ff70d3e, Offset: 0x1848
// Size: 0x42
function function_a8f48405(rankid) {
    return int(tablelookup(level.var_b7e5f751, 0, rankid, 17));
}

// Namespace rank
// Params 0, eflags: 0x1 linked
// Checksum 0x4140a883, Offset: 0x1898
// Size: 0xbe
function shouldkickbyrank() {
    if (self ishost()) {
        return false;
    }
    if (level.rankcap > 0 && self.pers["rank"] > level.rankcap) {
        return true;
    }
    if (level.rankcap > 0 && level.minprestige == 0 && self.pers["plevel"] > 0) {
        return true;
    }
    if (level.minprestige > self.pers["plevel"]) {
        return true;
    }
    return false;
}

// Namespace rank
// Params 0, eflags: 0x1 linked
// Checksum 0xd867db71, Offset: 0x1960
// Size: 0x88
function function_266f74f4() {
    codpoints = self getdstat("playerstatslist", "CODPOINTS", "StatValue");
    var_7fbc8baf = function_35db3641(codpoints);
    if (codpoints > var_7fbc8baf) {
        self function_81238668(var_7fbc8baf);
    }
    return var_7fbc8baf;
}

// Namespace rank
// Params 1, eflags: 0x1 linked
// Checksum 0xcc1a9cc, Offset: 0x19f0
// Size: 0x4c
function function_81238668(codpoints) {
    self setdstat("PlayerStatsList", "CODPOINTS", "StatValue", function_35db3641(codpoints));
}

// Namespace rank
// Params 0, eflags: 0x1 linked
// Checksum 0x5d49367, Offset: 0x1a48
// Size: 0xa0
function getrankxpstat() {
    rankxp = self getdstat("playerstatslist", "RANKXP", "StatValue");
    rankxpcapped = getrankxpcapped(rankxp);
    if (rankxp > rankxpcapped) {
        self setdstat("playerstatslist", "RANKXP", "StatValue", rankxpcapped);
    }
    return rankxpcapped;
}

// Namespace rank
// Params 0, eflags: 0x1 linked
// Checksum 0x96d8f505, Offset: 0x1af0
// Size: 0x62
function getarenapointsstat() {
    arenaslot = arenagetslot();
    arenapoints = self getdstat("arenaStats", arenaslot, "points");
    return arenapoints + 1;
}

// Namespace rank
// Params 0, eflags: 0x1 linked
// Checksum 0x41400e7b, Offset: 0x1b60
// Size: 0x68c
function on_player_connect() {
    self.pers["rankxp"] = self getrankxpstat();
    self.pers["codpoints"] = self function_266f74f4();
    self.pers["currencyspent"] = self getdstat("playerstatslist", "currencyspent", "StatValue");
    rankid = self getrankforxp(self getrankxp());
    self.pers["rank"] = rankid;
    self.pers["plevel"] = self getdstat("playerstatslist", "PLEVEL", "StatValue");
    if (self shouldkickbyrank()) {
        kick(self getentitynumber());
        return;
    }
    if (!isdefined(self.pers["participation"])) {
        self.pers["participation"] = 0;
    }
    self.rankupdatetotal = 0;
    self.cur_ranknum = rankid;
    /#
        assert(isdefined(self.cur_ranknum), "scr_maxinventory_scorestreaks" + rankid + "scr_maxinventory_scorestreaks" + level.var_b7e5f751);
    #/
    prestige = self getdstat("playerstatslist", "plevel", "StatValue");
    self setrank(rankid, prestige);
    self.pers["prestige"] = prestige;
    if (sessionmodeiszombiesgame() && (sessionmodeismultiplayergame() && gamemodeisusingstats() || sessionmodeisonlinegame())) {
        paragonrank = self getdstat("playerstatslist", "paragon_rank", "StatValue");
        self setparagonrank(paragonrank);
        self.pers["paragonrank"] = paragonrank;
        paragoniconid = self getdstat("playerstatslist", "paragon_icon_id", "StatValue");
        self setparagoniconid(paragoniconid);
        self.pers["paragoniconid"] = paragoniconid;
    }
    if (!isdefined(self.pers["summary"])) {
        self.pers["summary"] = [];
        self.pers["summary"]["xp"] = 0;
        self.pers["summary"]["score"] = 0;
        self.pers["summary"]["challenge"] = 0;
        self.pers["summary"]["match"] = 0;
        self.pers["summary"]["misc"] = 0;
        self.pers["summary"]["codpoints"] = 0;
    }
    if (gamemodeismode(6) && !self util::is_bot()) {
        arenapoints = self getarenapointsstat();
        arenapoints = int(min(arenapoints, 100));
        self.pers["arenapoints"] = arenapoints;
        self setarenapoints(arenapoints);
    }
    if (level.rankedmatch) {
        self setdstat("playerstatslist", "rank", "StatValue", rankid);
        self setdstat("playerstatslist", "minxp", "StatValue", getrankinfominxp(rankid));
        self setdstat("playerstatslist", "maxxp", "StatValue", getrankinfomaxxp(rankid));
        self setdstat("playerstatslist", "lastxp", "StatValue", getrankxpcapped(self.pers["rankxp"]));
    }
    self.explosivekills[0] = 0;
    callback::on_spawned(&on_player_spawned);
    callback::on_joined_team(&on_joined_team);
    callback::on_joined_spectate(&on_joined_spectators);
}

// Namespace rank
// Params 0, eflags: 0x1 linked
// Checksum 0x4ec3d9c4, Offset: 0x21f8
// Size: 0x24
function on_joined_team() {
    self endon(#"disconnect");
    self thread function_f6937c36();
}

// Namespace rank
// Params 0, eflags: 0x1 linked
// Checksum 0x51d8b29, Offset: 0x2228
// Size: 0x24
function on_joined_spectators() {
    self endon(#"disconnect");
    self thread function_f6937c36();
}

// Namespace rank
// Params 0, eflags: 0x1 linked
// Checksum 0x57ef742d, Offset: 0x2258
// Size: 0x19c
function on_player_spawned() {
    self endon(#"disconnect");
    if (!isdefined(self.var_c81ebd72)) {
        self.var_c81ebd72 = newscorehudelem(self);
        self.var_c81ebd72.horzalign = "center";
        self.var_c81ebd72.vertalign = "middle";
        self.var_c81ebd72.alignx = "center";
        self.var_c81ebd72.aligny = "middle";
        self.var_c81ebd72.x = 0;
        if (self issplitscreen()) {
            self.var_c81ebd72.y = -15;
        } else {
            self.var_c81ebd72.y = -60;
        }
        self.var_c81ebd72.font = "default";
        self.var_c81ebd72.fontscale = 2;
        self.var_c81ebd72.archived = 0;
        self.var_c81ebd72.color = (1, 1, 0.5);
        self.var_c81ebd72.alpha = 0;
        self.var_c81ebd72.sort = 50;
        self.var_c81ebd72 hud::function_1ad5c13d();
    }
}

// Namespace rank
// Params 1, eflags: 0x1 linked
// Checksum 0x11480c1d, Offset: 0x2400
// Size: 0x10c
function function_cb1e9fe6(amount) {
    if (!util::isrankenabled()) {
        return;
    }
    if (!level.rankedmatch) {
        return;
    }
    var_a7f48cf4 = function_35db3641(self.pers["codpoints"] + amount);
    if (var_a7f48cf4 > self.pers["codpoints"]) {
        self.pers["summary"]["codpoints"] = self.pers["summary"]["codpoints"] + var_a7f48cf4 - self.pers["codpoints"];
    }
    self.pers["codpoints"] = var_a7f48cf4;
    function_81238668(int(var_a7f48cf4));
}

// Namespace rank
// Params 0, eflags: 0x1 linked
// Checksum 0xcb10dc5b, Offset: 0x2518
// Size: 0x8e
function atleastoneplayeroneachteam() {
    foreach (team in level.teams) {
        if (!level.playercount[team]) {
            return false;
        }
    }
    return true;
}

// Namespace rank
// Params 3, eflags: 0x1 linked
// Checksum 0x5fef201e, Offset: 0x25b0
// Size: 0x66c
function giverankxp(type, value, var_1d04f5a7) {
    self endon(#"disconnect");
    if (sessionmodeiszombiesgame()) {
        return;
    }
    if (level.teambased && !atleastoneplayeroneachteam() && !isdefined(var_1d04f5a7)) {
        return;
    } else if (!level.teambased && util::totalplayercount() < 2 && !isdefined(var_1d04f5a7)) {
        return;
    }
    if (!util::isrankenabled()) {
        return;
    }
    pixbeginevent("giveRankXP");
    if (!isdefined(value)) {
        value = getscoreinfovalue(type);
    }
    if (level.rankedmatch) {
        bbprint("mpplayerxp", "gametime %d, player %s, type %s, delta %d", gettime(), self.name, type, value);
    }
    switch (type) {
    case 70:
    case 71:
    case 72:
    case 73:
    case 74:
    case 75:
    case 76:
    case 77:
    case 78:
    case 79:
    case 80:
    case 81:
    case 82:
    case 83:
    case 84:
    case 85:
    case 86:
    case 87:
    case 30:
    case 88:
    case 89:
    case 90:
    case 91:
    case 92:
    case 93:
    case 94:
    case 95:
        value = int(value * level.xpscale);
        break;
    default:
        if (level.xpscale == 0) {
            value = 0;
        }
        break;
    }
    var_9e387ebd = self incrankxp(value);
    if (level.rankedmatch) {
        self updaterank();
    }
    if (value != 0) {
        self syncxpstat();
    }
    if (isdefined(self.var_84bed14d) && self.var_84bed14d && !level.hardcoremode) {
        if (type == "teamkill") {
            self thread function_9c4690f5(0 - getscoreinfovalue("kill"));
        } else {
            self thread function_9c4690f5(value);
        }
    }
    switch (type) {
    case 70:
    case 72:
    case 73:
    case 74:
    case 75:
    case 76:
    case 77:
    case 82:
    case 83:
    case 84:
    case 85:
    case 86:
    case 30:
    case 88:
    case 89:
    case 92:
    case 93:
    case 98:
    case 96:
        self.pers["summary"]["score"] = self.pers["summary"]["score"] + value;
        function_cb1e9fe6(round_this_number(value * level.var_9364c56a));
        break;
    case 97:
    case 99:
    case 100:
        self.pers["summary"]["match"] = self.pers["summary"]["match"] + value;
        function_cb1e9fe6(round_this_number(value * level.var_c1745e43));
        break;
    case 57:
        self.pers["summary"]["challenge"] = self.pers["summary"]["challenge"] + value;
        function_cb1e9fe6(round_this_number(value * level.var_4e39954b));
        break;
    default:
        self.pers["summary"]["misc"] = self.pers["summary"]["misc"] + value;
        self.pers["summary"]["match"] = self.pers["summary"]["match"] + value;
        function_cb1e9fe6(round_this_number(value * level.var_c1745e43));
        break;
    }
    self.pers["summary"]["xp"] = self.pers["summary"]["xp"] + var_9e387ebd;
    pixendevent();
}

// Namespace rank
// Params 1, eflags: 0x1 linked
// Checksum 0xf5305a17, Offset: 0x2c28
// Size: 0x34
function round_this_number(value) {
    value = int(value + 0.5);
    return value;
}

// Namespace rank
// Params 0, eflags: 0x1 linked
// Checksum 0x6e180d2b, Offset: 0x2c68
// Size: 0x310
function updaterank() {
    newrankid = self getrank();
    if (newrankid == self.pers["rank"]) {
        return false;
    }
    oldrank = self.pers["rank"];
    rankid = self.pers["rank"];
    self.pers["rank"] = newrankid;
    while (rankid <= newrankid) {
        self setdstat("playerstatslist", "rank", "StatValue", rankid);
        self setdstat("playerstatslist", "minxp", "StatValue", int(level.ranktable[rankid][2]));
        self setdstat("playerstatslist", "maxxp", "StatValue", int(level.ranktable[rankid][7]));
        self.setpromotion = 1;
        if (level.rankedmatch && level.gameended && !self issplitscreen()) {
            self setdstat("AfterActionReportStats", "lobbyPopup", "promotion");
        }
        if (rankid != oldrank) {
            var_43697a64 = function_a8f48405(rankid);
            function_cb1e9fe6(var_43697a64);
            if (!isdefined(self.pers["rankcp"])) {
                self.pers["rankcp"] = 0;
            }
            self.pers["rankcp"] = self.pers["rankcp"] + var_43697a64;
        }
        rankid++;
    }
    /#
        print("scr_maxinventory_scorestreaks" + oldrank + "scr_maxinventory_scorestreaks" + newrankid + "scr_maxinventory_scorestreaks" + self getdstat("scr_maxinventory_scorestreaks", "scr_maxinventory_scorestreaks", "scr_maxinventory_scorestreaks"));
    #/
    self setrank(newrankid);
    return true;
}

// Namespace rank
// Params 3, eflags: 0x1 linked
// Checksum 0x627ffa57, Offset: 0x2f80
// Size: 0x198
function codecallback_rankup(rank, prestige, var_1276d357) {
    if (sessionmodeiscampaigngame()) {
        var_5f586507 = level.ranktable[rank][18];
        if (isdefined(var_5f586507) && var_5f586507 != "") {
            self giveunlocktoken(int(var_5f586507));
        }
        uploadstats(self);
        return;
    }
    if (sessionmodeismultiplayergame()) {
        if (rank > 53) {
            self giveachievement("MP_REACH_ARENA");
        }
        if (rank > 8) {
            self giveachievement("MP_REACH_SERGEANT");
        }
    }
    self luinotifyevent(%rank_up, 3, rank, prestige, var_1276d357);
    self luinotifyeventtospectators(%rank_up, 3, rank, prestige, var_1276d357);
    if (isdefined(level.playpromotionreaction)) {
        self thread [[ level.playpromotionreaction ]]();
    }
}

// Namespace rank
// Params 1, eflags: 0x1 linked
// Checksum 0x1a2d6973, Offset: 0x3120
// Size: 0xa8
function getitemindex(refstring) {
    var_a804a5cf = util::function_bc37a245();
    itemindex = int(tablelookup(var_a804a5cf, 4, refstring, 0));
    /#
        assert(itemindex > 0, "scr_maxinventory_scorestreaks" + refstring + "scr_maxinventory_scorestreaks" + itemindex);
    #/
    return itemindex;
}

// Namespace rank
// Params 0, eflags: 0x1 linked
// Checksum 0xc8810436, Offset: 0x31d0
// Size: 0x14
function endgameupdate() {
    player = self;
}

// Namespace rank
// Params 1, eflags: 0x1 linked
// Checksum 0xd49d78cd, Offset: 0x31f0
// Size: 0x1bc
function function_9c4690f5(amount) {
    self endon(#"disconnect");
    self endon(#"joined_team");
    self endon(#"joined_spectators");
    if (isdefined(level.usingmomentum) && level.usingmomentum) {
        return;
    }
    if (amount == 0) {
        return;
    }
    self notify(#"hash_2b145a7d");
    self endon(#"hash_2b145a7d");
    self.rankupdatetotal += amount;
    wait(0.05);
    if (isdefined(self.var_c81ebd72)) {
        if (self.rankupdatetotal < 0) {
            self.var_c81ebd72.label = %;
            self.var_c81ebd72.color = (0.73, 0.19, 0.19);
        } else {
            self.var_c81ebd72.label = %MP_PLUS;
            self.var_c81ebd72.color = (1, 1, 0.5);
        }
        self.var_c81ebd72 setvalue(self.rankupdatetotal);
        self.var_c81ebd72.alpha = 0.85;
        self.var_c81ebd72 thread hud::function_5e2578bc(self);
        wait(1);
        self.var_c81ebd72 fadeovertime(0.75);
        self.var_c81ebd72.alpha = 0;
        self.rankupdatetotal = 0;
    }
}

// Namespace rank
// Params 3, eflags: 0x0
// Checksum 0xca282a52, Offset: 0x33b8
// Size: 0x2ec
function function_73d88f63(amount, reason, var_1b34c188) {
    self endon(#"disconnect");
    self endon(#"joined_team");
    self endon(#"joined_spectators");
    if (amount == 0) {
        return;
    }
    self notify(#"hash_2b145a7d");
    self endon(#"hash_2b145a7d");
    self.rankupdatetotal += amount;
    if (isdefined(self.var_c81ebd72)) {
        if (self.rankupdatetotal < 0) {
            self.var_c81ebd72.label = %;
            self.var_c81ebd72.color = (0.73, 0.19, 0.19);
        } else {
            self.var_c81ebd72.label = %MP_PLUS;
            self.var_c81ebd72.color = (1, 1, 0.5);
        }
        self.var_c81ebd72 setvalue(self.rankupdatetotal);
        self.var_c81ebd72.alpha = 0.85;
        self.var_c81ebd72 thread hud::function_5e2578bc(self);
        if (isdefined(self.var_59367135)) {
            if (isdefined(reason)) {
                if (isdefined(var_1b34c188)) {
                    self.var_59367135.label = reason;
                    self.var_59367135 setvalue(var_1b34c188);
                } else {
                    self.var_59367135.label = reason;
                    self.var_59367135 setvalue(amount);
                }
                self.var_59367135.alpha = 0.85;
                self.var_59367135 thread hud::function_5e2578bc(self);
            } else {
                self.var_59367135 fadeovertime(0.01);
                self.var_59367135.alpha = 0;
            }
        }
        wait(1);
        self.var_c81ebd72 fadeovertime(0.75);
        self.var_c81ebd72.alpha = 0;
        if (isdefined(self.var_59367135) && isdefined(reason)) {
            self.var_59367135 fadeovertime(0.75);
            self.var_59367135.alpha = 0;
        }
        wait(0.75);
        self.rankupdatetotal = 0;
    }
}

// Namespace rank
// Params 0, eflags: 0x1 linked
// Checksum 0x1f443b49, Offset: 0x36b0
// Size: 0x44
function function_f6937c36() {
    if (isdefined(self.var_c81ebd72)) {
        self.var_c81ebd72.alpha = 0;
    }
    if (isdefined(self.var_59367135)) {
        self.var_59367135.alpha = 0;
    }
}

// Namespace rank
// Params 0, eflags: 0x1 linked
// Checksum 0x359b8374, Offset: 0x3700
// Size: 0xb4
function getrank() {
    rankxp = getrankxpcapped(self.pers["rankxp"]);
    rankid = self.pers["rank"];
    if (rankxp < getrankinfominxp(rankid) + getrankinfoxpamt(rankid)) {
        return rankid;
    }
    return self getrankforxp(rankxp);
}

// Namespace rank
// Params 1, eflags: 0x1 linked
// Checksum 0xe146ae37, Offset: 0x37c0
// Size: 0x106
function getrankforxp(xpval) {
    rankid = 0;
    rankname = level.ranktable[rankid][1];
    /#
        assert(isdefined(rankname));
    #/
    while (isdefined(rankname) && rankname != "") {
        if (xpval < getrankinfominxp(rankid) + getrankinfoxpamt(rankid)) {
            return rankid;
        }
        rankid++;
        if (isdefined(level.ranktable[rankid])) {
            rankname = level.ranktable[rankid][1];
            continue;
        }
        rankname = undefined;
    }
    rankid--;
    return rankid;
}

// Namespace rank
// Params 0, eflags: 0x1 linked
// Checksum 0x5c7cf053, Offset: 0x38d0
// Size: 0x48
function getspm() {
    ranklevel = self getrank() + 1;
    return (3 + ranklevel * 0.5) * 10;
}

// Namespace rank
// Params 0, eflags: 0x1 linked
// Checksum 0xa3c8bb4a, Offset: 0x3920
// Size: 0x2a
function getrankxp() {
    return getrankxpcapped(self.pers["rankxp"]);
}

// Namespace rank
// Params 1, eflags: 0x1 linked
// Checksum 0xd911516e, Offset: 0x3958
// Size: 0x1aa
function incrankxp(amount) {
    if (!level.rankedmatch) {
        return 0;
    }
    xp = self getrankxp();
    newxp = getrankxpcapped(xp + amount);
    if (self.pers["rank"] == level.maxrank && newxp >= getrankinfomaxxp(level.maxrank)) {
        newxp = getrankinfomaxxp(level.maxrank);
    }
    if (self isstarterpack() && self.pers["rank"] >= level.var_52e3d4cf && newxp >= getrankinfominxp(level.var_52e3d4cf)) {
        newxp = getrankinfominxp(level.var_52e3d4cf);
    }
    var_9e387ebd = getrankxpcapped(newxp) - self.pers["rankxp"];
    if (var_9e387ebd < 0) {
        var_9e387ebd = 0;
    }
    self.pers["rankxp"] = getrankxpcapped(newxp);
    return var_9e387ebd;
}

// Namespace rank
// Params 0, eflags: 0x1 linked
// Checksum 0xfc596716, Offset: 0x3b10
// Size: 0xdc
function syncxpstat() {
    xp = getrankxpcapped(self getrankxp());
    cp = function_35db3641(int(self.pers["codpoints"]));
    self setdstat("playerstatslist", "rankxp", "StatValue", xp);
    self setdstat("playerstatslist", "codpoints", "StatValue", cp);
}

