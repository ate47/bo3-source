#using scripts/mp/teams/_teams;
#using scripts/mp/killstreaks/_killstreaks;
#using scripts/mp/bots/_bot;
#using scripts/mp/_util;
#using scripts/mp/gametypes/_spectating;
#using scripts/mp/gametypes/_loadout;
#using scripts/mp/gametypes/_globallogic_player;
#using scripts/mp/gametypes/_globallogic;
#using scripts/shared/util_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/hud_util_shared;
#using scripts/shared/array_shared;

#namespace globallogic_ui;

// Namespace globallogic_ui
// Params 0, eflags: 0x1 linked
// Checksum 0x99ec1590, Offset: 0x2e0
// Size: 0x4
function init() {
    
}

// Namespace globallogic_ui
// Params 0, eflags: 0x1 linked
// Checksum 0xa6e6f810, Offset: 0x2f0
// Size: 0x64
function setupcallbacks() {
    level.autoassign = &menuautoassign;
    level.spectator = &menuspectator;
    level.curclass = &menuclass;
    level.teammenu = &menuteam;
}

// Namespace globallogic_ui
// Params 0, eflags: 0x1 linked
// Checksum 0xd3faa7c3, Offset: 0x360
// Size: 0x27c
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
// Params 1, eflags: 0x1 linked
// Checksum 0xe71cffab, Offset: 0x5e8
// Size: 0xc6
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
// Params 2, eflags: 0x1 linked
// Checksum 0x8135ad85, Offset: 0x6b8
// Size: 0xda
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
// Params 2, eflags: 0x1 linked
// Checksum 0x25e5050e, Offset: 0x7a0
// Size: 0xa6
function function_76c7989e(teamname, comingfrommenu) {
    if (level.rankedmatch) {
        return false;
    }
    if (teamname != "free") {
        return false;
    }
    if (comingfrommenu) {
        return false;
    }
    if (self ishost()) {
        return false;
    }
    if (level.forceautoassign) {
        return false;
    }
    if (self util::is_bot()) {
        return false;
    }
    if (self issplitscreen()) {
        return false;
    }
    return true;
}

// Namespace globallogic_ui
// Params 1, eflags: 0x1 linked
// Checksum 0x8daaa8ec, Offset: 0x850
// Size: 0x6e4
function menuautoassign(comingfrommenu) {
    teamkeys = getarraykeys(level.teams);
    assignment = teamkeys[randomint(teamkeys.size)];
    self closemenus();
    self luinotifyevent(%clear_notification_queue);
    if (level.teambased) {
        if (bot::function_c0d531d9()) {
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
        } else if (isdefined(level.var_485556b)) {
            assignment = [[ level.var_485556b ]](self, comingfrommenu);
        } else {
            teamname = getassignedteamname(self);
            if (isdefined(teamname) && teamname != "free" && !comingfrommenu) {
                assignment = teamname;
            } else if (function_76c7989e(teamname, comingfrommenu)) {
                assignment = "spectator";
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
        if (!comingfrommenu) {
            assignment = self.sessionteam;
        } else {
            clientnum = self getentitynumber();
            count = 0;
            foreach (team in level.teams) {
                if (team == "free") {
                    continue;
                }
                count++;
                if (count == clientnum + 1) {
                    assignment = team;
                    break;
                }
            }
        }
        if (self.sessionstate == "playing" || self.sessionstate == "dead") {
            return;
        }
    }
    if (assignment == "spectator" && !level.forceautoassign) {
        self.pers["team"] = assignment;
        self.team = assignment;
        self.sessionteam = assignment;
        self setclientscriptmainmenu(game["menu_start_menu"]);
        return;
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
    self setclientscriptmainmenu(game["menu_start_menu"]);
}

// Namespace globallogic_ui
// Params 0, eflags: 0x1 linked
// Checksum 0xb8ba63df, Offset: 0xf40
// Size: 0xce
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
// Params 0, eflags: 0x1 linked
// Checksum 0x461c38df, Offset: 0x1018
// Size: 0xc4
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
// Params 1, eflags: 0x1 linked
// Checksum 0xa8dd0199, Offset: 0x10e8
// Size: 0x74
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
// Params 0, eflags: 0x1 linked
// Checksum 0x50aafe1a, Offset: 0x1168
// Size: 0xce
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
// Params 0, eflags: 0x1 linked
// Checksum 0x483b5982, Offset: 0x1240
// Size: 0xcc
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
// Params 0, eflags: 0x1 linked
// Checksum 0xd130293b, Offset: 0x1318
// Size: 0x1c
function closemenus() {
    self closeingamemenu();
}

// Namespace globallogic_ui
// Params 0, eflags: 0x1 linked
// Checksum 0x57e9fbb8, Offset: 0x1340
// Size: 0x1c4
function beginclasschoice() {
    assert(isdefined(level.teams[self.pers["menu_start_menu"]]));
    team = self.pers["team"];
    if (isdefined(self.disableclassselection) && (level.disableclassselection == 1 || self.disableclassselection) || getdvarint("migration_soak") == 1) {
        started_waiting = gettime();
        while (!self isstreamerready(-1, 1) && started_waiting + 90000 > gettime()) {
            wait(0.05);
        }
        self.pers["class"] = level.defaultclass;
        self.curclass = level.defaultclass;
        if (self.sessionstate != "playing" && game["state"] == "playing") {
            self thread [[ level.spawnclient ]]();
        }
        level thread globallogic::updateteamstatus();
        self thread spectating::set_permissions_for_machine();
        return;
    }
    util::wait_network_frame();
    self openmenu(game["menu_changeclass_" + team]);
}

// Namespace globallogic_ui
// Params 0, eflags: 0x1 linked
// Checksum 0x60589b5f, Offset: 0x1510
// Size: 0x74
function showmainmenuforteam() {
    assert(isdefined(level.teams[self.pers["menu_start_menu"]]));
    team = self.pers["team"];
    self openmenu(game["menu_changeclass_" + team]);
}

// Namespace globallogic_ui
// Params 1, eflags: 0x1 linked
// Checksum 0xcea42cb3, Offset: 0x1590
// Size: 0x254
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
        self luinotifyevent(%clear_notification_queue);
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
        self setclientscriptmainmenu(game["menu_start_menu"]);
        self notify(#"joined_team");
        level notify(#"joined_team");
        callback::callback(#"hash_95a6c4c0");
        self notify(#"end_respawn");
    }
    self beginclasschoice();
}

// Namespace globallogic_ui
// Params 0, eflags: 0x1 linked
// Checksum 0x80d88fb6, Offset: 0x17f0
// Size: 0x1a4
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
        self setclientscriptmainmenu(game["menu_start_menu"]);
        self notify(#"joined_spectators");
        callback::callback(#"hash_4c5ae192");
    }
}

// Namespace globallogic_ui
// Params 2, eflags: 0x1 linked
// Checksum 0x4c12c3a7, Offset: 0x19a0
// Size: 0x3cc
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
    if (game["state"] == "postgame") {
        return;
    }
    if (self.sessionstate == "playing") {
        supplystationclasschange = isdefined(self.usingsupplystation) && self.usingsupplystation;
        self.usingsupplystation = 0;
        if (level.ingraceperiod && !self.hasdonecombat || supplystationclasschange) {
            self loadout::setclass(self.pers["class"]);
            self.tag_stowed_back = undefined;
            self.tag_stowed_hip = undefined;
            self loadout::giveloadout(self.pers["team"], self.pers["class"]);
            self killstreaks::give_owned();
        } else if (!self issplitscreen() && !util::isinfectedgametype()) {
            self iprintlnbold(game["strings"]["change_class"]);
        }
    } else {
        if (self.sessionstate != "spectator") {
            if (self isinvehicle()) {
                return;
            }
            if (self isremotecontrolling()) {
                return;
            }
            if (self isweaponviewonlylinked()) {
                return 0;
            }
        }
        if (game["state"] == "playing") {
            timepassed = undefined;
            if (isdefined(self.respawntimerstarttime)) {
                timepassed = (gettime() - self.respawntimerstarttime) / 1000;
            }
            self thread [[ level.spawnclient ]](timepassed);
            self.respawntimerstarttime = undefined;
        }
    }
    level thread globallogic::updateteamstatus();
    self thread spectating::set_permissions_for_machine();
}

// Namespace globallogic_ui
// Params 1, eflags: 0x1 linked
// Checksum 0xde9a4cb0, Offset: 0x1d78
// Size: 0x44
function removespawnmessageshortly(delay) {
    self endon(#"disconnect");
    waittillframeend();
    self endon(#"end_respawn");
    wait(delay);
    self util::clearlowermessage(2);
}

