#using scripts/mp/_util;
#using scripts/mp/bots/_bot;
#using scripts/mp/gametypes/_globallogic;
#using scripts/mp/gametypes/_globallogic_player;
#using scripts/mp/gametypes/_loadout;
#using scripts/mp/gametypes/_spectating;
#using scripts/mp/killstreaks/_killstreaks;
#using scripts/mp/teams/_teams;
#using scripts/shared/array_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/hud_util_shared;
#using scripts/shared/util_shared;

#namespace globallogic_ui;

// Namespace globallogic_ui
// Params 0, eflags: 0x0
// Checksum 0xe9c07cd6, Offset: 0x2d8
// Size: 0x2
function init() {
    
}

// Namespace globallogic_ui
// Params 0, eflags: 0x0
// Checksum 0xf38e0838, Offset: 0x2e8
// Size: 0x62
function setupcallbacks() {
    level.autoassign = &menuautoassign;
    level.spectator = &menuspectator;
    level.curclass = &menuclass;
    level.teammenu = &menuteam;
}

// Namespace globallogic_ui
// Params 0, eflags: 0x0
// Checksum 0xd23aa51b, Offset: 0x358
// Size: 0x1fa
function freegameplayhudelems() {
    if (isdefined(self.perkicon)) {
        for (numspecialties = 0; numspecialties < level.maxspecialties; numspecialties++) {
            if (isdefined(self.perkicon[numspecialties])) {
                self.perkicon[numspecialties] hud::destroyelem();
                self.perkname[numspecialties] hud::destroyelem();
            }
        }
    }
    if (isdefined(self.perkhudelem)) {
        self.perkhudelem hud::destroyelem();
    }
    if (isdefined(self.killstreakicon)) {
        if (isdefined(self.killstreakicon[0])) {
            self.killstreakicon[0] hud::destroyelem();
        }
        if (isdefined(self.killstreakicon[1])) {
            self.killstreakicon[1] hud::destroyelem();
        }
        if (isdefined(self.killstreakicon[2])) {
            self.killstreakicon[2] hud::destroyelem();
        }
        if (isdefined(self.killstreakicon[3])) {
            self.killstreakicon[3] hud::destroyelem();
        }
        if (isdefined(self.killstreakicon[4])) {
            self.killstreakicon[4] hud::destroyelem();
        }
    }
    if (isdefined(self.lowermessage)) {
        self.lowermessage hud::destroyelem();
    }
    if (isdefined(self.lowertimer)) {
        self.lowertimer hud::destroyelem();
    }
    if (isdefined(self.proxbar)) {
        self.proxbar hud::destroyelem();
    }
    if (isdefined(self.proxbartext)) {
        self.proxbartext hud::destroyelem();
    }
    if (isdefined(self.carryicon)) {
        self.carryicon hud::destroyelem();
    }
}

// Namespace globallogic_ui
// Params 1, eflags: 0x0
// Checksum 0x17bdb6d6, Offset: 0x560
// Size: 0x87
function teamplayercountsequal(playercounts) {
    count = undefined;
    foreach (team in level.teams) {
        if (!isdefined(count)) {
            count = playercounts[team];
            continue;
        }
        if (count != playercounts[team]) {
            return false;
        }
    }
    return true;
}

// Namespace globallogic_ui
// Params 2, eflags: 0x0
// Checksum 0x58b0d775, Offset: 0x5f0
// Size: 0x95
function teamwithlowestplayercount(playercounts, ignore_team) {
    count = 9999;
    lowest_team = undefined;
    foreach (team in level.teams) {
        if (count > playercounts[team]) {
            count = playercounts[team];
            lowest_team = team;
        }
    }
    return lowest_team;
}

// Namespace globallogic_ui
// Params 1, eflags: 0x0
// Checksum 0xb5062df7, Offset: 0x690
// Size: 0x579
function menuautoassign(comingfrommenu) {
    teamkeys = getarraykeys(level.teams);
    assignment = teamkeys[randomint(teamkeys.size)];
    self closemenus();
    if (isdefined(level.forceallallies) && level.forceallallies) {
        assignment = "allies";
    } else if (level.teambased) {
        if (getdvarint("party_autoteams") == 1) {
            if (self.hasspawned || level.allow_teamchange == "1" && comingfrommenu) {
                assignment = "";
            } else {
                team = getassignedteam(self);
                switch (team) {
                case 1:
                    assignment = teamkeys[1];
                    break;
                case 2:
                    assignment = teamkeys[0];
                    break;
                case 3:
                    assignment = teamkeys[2];
                    break;
                case 4:
                    if (!isdefined(level.forceautoassign) || !level.forceautoassign) {
                        InvalidOpCode(0x54, "menu_start_menu");
                        // Unknown operator (0x54, t7_1b, PC)
                    }
                default:
                    assignment = "";
                    if (isdefined(level.teams[team])) {
                        assignment = team;
                    } else if (team == "spectator" && !level.forceautoassign) {
                        InvalidOpCode(0x54, "menu_start_menu");
                        // Unknown operator (0x54, t7_1b, PC)
                    }
                    break;
                }
            }
        }
        if (assignment == "" || getdvarint("party_autoteams") == 0) {
            if (sessionmodeiszombiesgame()) {
                assignment = "allies";
            } else if (bot::function_c0d531d9()) {
                host = util::gethostplayerforbots();
                assert(isdefined(host));
                if (!isdefined(host.team) || host.team == "spectator") {
                    host.team = array::random(teamkeys);
                }
                if (!self util::is_bot()) {
                    assignment = host.team;
                } else {
                    assignment = util::getotherteam(host.team);
                }
            } else {
                playercounts = self teams::count_players();
                if (teamplayercountsequal(playercounts)) {
                    if (!level.splitscreen && self issplitscreen()) {
                        assignment = self get_splitscreen_team();
                        if (assignment == "") {
                            assignment = pickteamfromscores(teamkeys);
                        }
                    } else {
                        assignment = pickteamfromscores(teamkeys);
                    }
                } else {
                    assignment = teamwithlowestplayercount(playercounts, "none");
                }
            }
        }
        if (self.sessionstate == "playing" || assignment == self.pers["team"] && self.sessionstate == "dead") {
            self beginclasschoice();
            return;
        }
    } else {
        assignment = self.sessionteam;
        if (assignment == "spectator" && !level.forceautoassign) {
            InvalidOpCode(0x54, "menu_start_menu");
            // Unknown operator (0x54, t7_1b, PC)
        }
    }
    if (self.sessionstate == "playing" || assignment != self.pers["team"] && self.sessionstate == "dead") {
        self.switching_teams = 1;
        self.switchedteamsresetgadgets = 1;
        self.joining_team = assignment;
        self.leaving_team = self.pers["team"];
        self suicide();
    }
    self.pers["team"] = assignment;
    self.team = assignment;
    self.pers["class"] = undefined;
    self.curclass = undefined;
    self.pers["weapon"] = undefined;
    self.pers["savedmodel"] = undefined;
    self updateobjectivetext();
    self.sessionteam = assignment;
    if (!isalive(self)) {
        self.statusicon = "hud_status_dead";
    }
    self notify(#"joined_team");
    level notify(#"joined_team");
    callback::callback(#"hash_95a6c4c0");
    self notify(#"end_respawn");
    self beginclasschoice();
    InvalidOpCode(0x54, "menu_start_menu");
    // Unknown operator (0x54, t7_1b, PC)
}

// Namespace globallogic_ui
// Params 0, eflags: 0x0
// Checksum 0x8ca2a961, Offset: 0xc28
// Size: 0x91
function teamscoresequal() {
    score = undefined;
    foreach (team in level.teams) {
        if (!isdefined(score)) {
            score = getteamscore(team);
            continue;
        }
        if (score != getteamscore(team)) {
            return false;
        }
    }
    return true;
}

// Namespace globallogic_ui
// Params 0, eflags: 0x0
// Checksum 0xb28a13d4, Offset: 0xcc8
// Size: 0x8d
function teamwithlowestscore() {
    score = 99999999;
    lowest_team = undefined;
    foreach (team in level.teams) {
        if (score > getteamscore(team)) {
            lowest_team = team;
        }
    }
    return lowest_team;
}

// Namespace globallogic_ui
// Params 1, eflags: 0x0
// Checksum 0x515b7cd2, Offset: 0xd60
// Size: 0x5e
function pickteamfromscores(teams) {
    assignment = "allies";
    if (teamscoresequal()) {
        assignment = teams[randomint(teams.size)];
    } else {
        assignment = teamwithlowestscore();
    }
    return assignment;
}

// Namespace globallogic_ui
// Params 0, eflags: 0x0
// Checksum 0x3fcb3be3, Offset: 0xdc8
// Size: 0x99
function get_splitscreen_team() {
    for (index = 0; index < level.players.size; index++) {
        if (!isdefined(level.players[index])) {
            continue;
        }
        if (level.players[index] == self) {
            continue;
        }
        if (!self isplayeronsamemachine(level.players[index])) {
            continue;
        }
        team = level.players[index].sessionteam;
        if (team != "spectator") {
            return team;
        }
    }
    return "";
}

// Namespace globallogic_ui
// Params 0, eflags: 0x0
// Checksum 0xe18abfcd, Offset: 0xe70
// Size: 0xaa
function updateobjectivetext() {
    if (self.pers["team"] == "spectator") {
        self setclientcgobjectivetext("");
        return;
    }
    if (level.scorelimit > 0 || level.roundscorelimit > 0) {
        self setclientcgobjectivetext(util::getobjectivescoretext(self.pers["team"]));
        return;
    }
    self setclientcgobjectivetext(util::getobjectivetext(self.pers["team"]));
}

// Namespace globallogic_ui
// Params 0, eflags: 0x0
// Checksum 0x76870a9e, Offset: 0xf28
// Size: 0x12
function closemenus() {
    self closeingamemenu();
}

// Namespace globallogic_ui
// Params 0, eflags: 0x0
// Checksum 0x7d356ec4, Offset: 0xf48
// Size: 0x144
function beginclasschoice() {
    assert(isdefined(level.teams[self.pers["<dev string:x28>"]]));
    team = self.pers["team"];
    if (level.disableclassselection == 1 || getdvarint("migration_soak") == 1) {
        started_waiting = gettime();
        while (!self isstreamerready(-1, 1) && started_waiting + 15000 > gettime()) {
            wait 0.05;
        }
        self.pers["class"] = level.defaultclass;
        self.curclass = level.defaultclass;
        InvalidOpCode(0x54, "state");
        // Unknown operator (0x54, t7_1b, PC)
    LOC_000000f9:
        if (self.sessionstate != "playing" && self.sessionstate != "playing") {
            self thread [[ level.spawnclient ]]();
        }
        level thread globallogic::updateteamstatus();
        self thread spectating::set_permissions_for_machine();
        return;
    }
    util::wait_network_frame();
    InvalidOpCode(0x54, "menu_changeclass_" + team);
    // Unknown operator (0x54, t7_1b, PC)
}

// Namespace globallogic_ui
// Params 0, eflags: 0x0
// Checksum 0xbf9e4b41, Offset: 0x10a8
// Size: 0x50
function showmainmenuforteam() {
    assert(isdefined(level.teams[self.pers["<dev string:x28>"]]));
    team = self.pers["team"];
    InvalidOpCode(0x54, "menu_changeclass_" + team);
    // Unknown operator (0x54, t7_1b, PC)
}

// Namespace globallogic_ui
// Params 1, eflags: 0x0
// Checksum 0x1ed8b82e, Offset: 0x1118
// Size: 0x1da
function menuteam(team) {
    self closemenus();
    if (isdefined(self.hasdonecombat) && !level.console && level.allow_teamchange == "0" && self.hasdonecombat) {
        return;
    }
    if (self.pers["team"] != team) {
        if (!isdefined(self.hasdonecombat) || level.ingraceperiod && !self.hasdonecombat) {
            self.hasspawned = 0;
        }
        if (self.sessionstate == "playing") {
            self.switching_teams = 1;
            self.switchedteamsresetgadgets = 1;
            self.joining_team = team;
            self.leaving_team = self.pers["team"];
            self suicide();
        }
        self.pers["team"] = team;
        self.team = team;
        self.pers["class"] = undefined;
        self.curclass = undefined;
        self.pers["weapon"] = undefined;
        self.pers["savedmodel"] = undefined;
        self updateobjectivetext();
        if (!level.rankedmatch && !level.leaguematch) {
            self.sessionstate = "spectator";
        }
        self.sessionteam = team;
        InvalidOpCode(0x54, "menu_start_menu");
        // Unknown operator (0x54, t7_1b, PC)
    }
    self beginclasschoice();
}

// Namespace globallogic_ui
// Params 0, eflags: 0x0
// Checksum 0x5b19e81e, Offset: 0x1300
// Size: 0x15a
function menuspectator() {
    self closemenus();
    if (self.pers["team"] != "spectator") {
        if (isalive(self)) {
            self.switching_teams = 1;
            self.switchedteamsresetgadgets = 1;
            self.joining_team = "spectator";
            self.leaving_team = self.pers["team"];
            self suicide();
        }
        self.pers["team"] = "spectator";
        self.team = "spectator";
        self.pers["class"] = undefined;
        self.curclass = undefined;
        self.pers["weapon"] = undefined;
        self.pers["savedmodel"] = undefined;
        self updateobjectivetext();
        self.sessionteam = "spectator";
        [[ level.spawnspectator ]]();
        self thread globallogic_player::spectate_player_watcher();
        InvalidOpCode(0x54, "menu_start_menu");
        // Unknown operator (0x54, t7_1b, PC)
    }
}

// Namespace globallogic_ui
// Params 2, eflags: 0x0
// Checksum 0x8c3ece69, Offset: 0x1468
// Size: 0x12d
function menuclass(response, forcedclass) {
    self closemenus();
    if (!isdefined(self.pers["team"]) || !isdefined(level.teams[self.pers["team"]])) {
        return;
    }
    if (!isdefined(forcedclass)) {
        playerclass = self loadout::getclasschoice(response);
    } else {
        playerclass = forcedclass;
    }
    if (isdefined(self.pers["class"]) && self.pers["class"] == playerclass) {
        return;
    }
    self.pers["changed_class"] = 1;
    self notify(#"changed_class");
    if (isdefined(self.curclass) && self.curclass == playerclass) {
        self.pers["changed_class"] = 0;
    }
    self.pers["class"] = playerclass;
    self.curclass = playerclass;
    self.pers["weapon"] = undefined;
    InvalidOpCode(0x54, "state");
    // Unknown operator (0x54, t7_1b, PC)
}

// Namespace globallogic_ui
// Params 1, eflags: 0x0
// Checksum 0x582bdc66, Offset: 0x1770
// Size: 0x32
function removespawnmessageshortly(delay) {
    self endon(#"disconnect");
    waittillframeend();
    self endon(#"end_respawn");
    wait delay;
    self util::clearlowermessage(2);
}

