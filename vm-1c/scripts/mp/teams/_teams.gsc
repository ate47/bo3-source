#using scripts/codescripts/struct;
#using scripts/mp/_util;
#using scripts/mp/gametypes/_globallogic_ui;
#using scripts/mp/gametypes/_spectating;
#using scripts/shared/callbacks_shared;
#using scripts/shared/persistence_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;

#namespace teams;

// Namespace teams
// Params 0, eflags: 0x2
// Checksum 0xe4c4ff14, Offset: 0x320
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("teams", &__init__, undefined, undefined);
}

// Namespace teams
// Params 0, eflags: 0x0
// Checksum 0xed96da9d, Offset: 0x360
// Size: 0x48
function __init__() {
    callback::on_start_gametype(&init);
    level.getenemyteam = &getenemyteam;
    level.use_team_based_logic_for_locking_on = 1;
}

// Namespace teams
// Params 0, eflags: 0x0
// Checksum 0xecd73fa6, Offset: 0x3b0
// Size: 0x234
function init() {
    game["strings"]["autobalance"] = %MP_AUTOBALANCE_NOW;
    if (getdvarstring("scr_teambalance") == "") {
        setdvar("scr_teambalance", "0");
    }
    level.teambalance = getdvarint("scr_teambalance");
    level.teambalancetimer = 0;
    if (getdvarstring("scr_timeplayedcap") == "") {
        setdvar("scr_timeplayedcap", "1800");
    }
    level.timeplayedcap = int(getdvarint("scr_timeplayedcap"));
    level.freeplayers = [];
    if (level.teambased) {
        level.alliesplayers = [];
        level.axisplayers = [];
        callback::on_connect(&on_player_connect);
        callback::on_joined_team(&on_joined_team);
        callback::on_joined_spectate(&on_joined_spectators);
        level thread update_balance_dvar();
        wait 0.15;
        if (level.onlinegame) {
            level thread update_player_times();
        }
        return;
    }
    callback::on_connect(&on_free_player_connect);
    wait 0.15;
    if (level.onlinegame) {
        level thread update_player_times();
    }
}

// Namespace teams
// Params 0, eflags: 0x0
// Checksum 0xa8f8a694, Offset: 0x5f0
// Size: 0x1c
function on_player_connect() {
    self thread function_e7a40e44();
}

// Namespace teams
// Params 0, eflags: 0x0
// Checksum 0x63289757, Offset: 0x618
// Size: 0x1c
function on_free_player_connect() {
    self thread track_free_played_time();
}

// Namespace teams
// Params 0, eflags: 0x0
// Checksum 0xf5184102, Offset: 0x640
// Size: 0x4c
function on_joined_team() {
    println("<dev string:x28>" + self.pers["<dev string:x36>"]);
    self update_time();
}

// Namespace teams
// Params 0, eflags: 0x0
// Checksum 0x1d83fb76, Offset: 0x698
// Size: 0x14
function on_joined_spectators() {
    self.pers["teamTime"] = undefined;
}

// Namespace teams
// Params 0, eflags: 0x0
// Checksum 0xe29d8516, Offset: 0x6b8
// Size: 0x28c
function function_e7a40e44() {
    self endon(#"disconnect");
    if (!isdefined(self.pers["totalTimePlayed"])) {
        self.pers["totalTimePlayed"] = 0;
    }
    foreach (team in level.teams) {
        self.timeplayed[team] = 0;
    }
    self.timeplayed["free"] = 0;
    self.timeplayed["other"] = 0;
    self.timeplayed["alive"] = 0;
    if (!isdefined(self.timeplayed["total"]) || !(level.gametype == "twar" && 0 < game["roundsplayed"] && 0 < self.timeplayed["total"])) {
        self.timeplayed["total"] = 0;
    }
    while (level.inprematchperiod) {
        wait 0.05;
    }
    for (;;) {
        if (game["state"] == "playing") {
            if (isdefined(level.teams[self.sessionteam])) {
                self.timeplayed[self.sessionteam]++;
                self.timeplayed["total"]++;
                if (level.mpcustommatch) {
                    self.pers["sbtimeplayed"] = self.timeplayed["total"];
                    self.sbtimeplayed = self.pers["sbtimeplayed"];
                }
                if (isalive(self)) {
                    self.timeplayed["alive"]++;
                }
            } else if (self.sessionteam == "spectator") {
                self.timeplayed["other"]++;
            }
        }
        wait 1;
    }
}

// Namespace teams
// Params 0, eflags: 0x0
// Checksum 0xed0fbf6d, Offset: 0x950
// Size: 0xe8
function update_player_times() {
    var_b3b708df = 10;
    nexttoupdate = 0;
    for (;;) {
        var_b3b708df -= 1;
        nexttoupdate++;
        if (nexttoupdate >= level.players.size) {
            nexttoupdate = 0;
            if (var_b3b708df > 0) {
                wait var_b3b708df;
            }
            var_b3b708df = 10;
        }
        if (isdefined(level.players[nexttoupdate])) {
            level.players[nexttoupdate] update_played_time();
            level.players[nexttoupdate] persistence::function_b526d623();
        }
        wait 1;
    }
}

// Namespace teams
// Params 0, eflags: 0x0
// Checksum 0xad5e0249, Offset: 0xa40
// Size: 0x41a
function update_played_time() {
    pixbeginevent("updatePlayedTime");
    if (level.rankedmatch || level.leaguematch) {
        foreach (team in level.teams) {
            if (self.timeplayed[team]) {
                if (level.teambased) {
                    self addplayerstat("time_played_" + team, int(min(self.timeplayed[team], level.timeplayedcap)));
                }
                self addplayerstatwithgametype("time_played_total", int(min(self.timeplayed[team], level.timeplayedcap)));
            }
        }
        if (self.timeplayed["other"]) {
            self addplayerstat("time_played_other", int(min(self.timeplayed["other"], level.timeplayedcap)));
            self addplayerstatwithgametype("time_played_total", int(min(self.timeplayed["other"], level.timeplayedcap)));
        }
        if (self.timeplayed["alive"]) {
            timealive = int(min(self.timeplayed["alive"], level.timeplayedcap));
            self persistence::function_f81a1bca(timealive);
            self addplayerstat("time_played_alive", timealive);
        }
    }
    if (level.onlinegame) {
        timealive = int(min(self.timeplayed["alive"], level.timeplayedcap));
        self.pers["time_played_alive"] = self.pers["time_played_alive"] + timealive;
    }
    pixendevent();
    if (game["state"] == "postgame") {
        return;
    }
    foreach (team in level.teams) {
        self.timeplayed[team] = 0;
    }
    self.timeplayed["other"] = 0;
    self.timeplayed["alive"] = 0;
}

// Namespace teams
// Params 0, eflags: 0x0
// Checksum 0x681e707e, Offset: 0xe68
// Size: 0x32
function update_time() {
    if (game["state"] != "playing") {
        return;
    }
    self.pers["teamTime"] = gettime();
}

// Namespace teams
// Params 0, eflags: 0x0
// Checksum 0xb13d8352, Offset: 0xea8
// Size: 0xce
function update_balance_dvar() {
    for (;;) {
        teambalance = getdvarint("scr_teambalance");
        if (level.teambalance != teambalance) {
            level.teambalance = getdvarint("scr_teambalance");
        }
        timeplayedcap = getdvarint("scr_timeplayedcap");
        if (level.timeplayedcap != timeplayedcap) {
            level.timeplayedcap = int(getdvarint("scr_timeplayedcap"));
        }
        wait 1;
    }
}

// Namespace teams
// Params 1, eflags: 0x0
// Checksum 0xd8da7570, Offset: 0xf80
// Size: 0x16a
function change(team) {
    if (self.sessionstate != "dead") {
        self.switching_teams = 1;
        self.switchedteamsresetgadgets = 1;
        self.joining_team = team;
        self.leaving_team = self.pers["team"];
        self suicide();
    }
    self.pers["team"] = team;
    self.team = team;
    self.pers["weapon"] = undefined;
    self.pers["spawnweapon"] = undefined;
    self.pers["savedmodel"] = undefined;
    self.pers["teamTime"] = undefined;
    self.sessionteam = self.pers["team"];
    self globallogic_ui::updateobjectivetext();
    self spectating::set_permissions();
    self setclientscriptmainmenu(game["menu_start_menu"]);
    self openmenu(game["menu_start_menu"]);
    self notify(#"end_respawn");
}

// Namespace teams
// Params 0, eflags: 0x0
// Checksum 0xb89698bf, Offset: 0x10f8
// Size: 0x170
function count_players() {
    players = level.players;
    playercounts = [];
    foreach (team in level.teams) {
        playercounts[team] = 0;
    }
    foreach (player in level.players) {
        if (player == self) {
            continue;
        }
        team = player.pers["team"];
        if (isdefined(team) && isdefined(level.teams[team])) {
            playercounts[team]++;
        }
    }
    return playercounts;
}

// Namespace teams
// Params 0, eflags: 0x0
// Checksum 0x50570acb, Offset: 0x1270
// Size: 0x1a0
function track_free_played_time() {
    self endon(#"disconnect");
    foreach (team in level.teams) {
        self.timeplayed[team] = 0;
    }
    self.timeplayed["other"] = 0;
    self.timeplayed["total"] = 0;
    self.timeplayed["alive"] = 0;
    for (;;) {
        if (game["state"] == "playing") {
            team = self.pers["team"];
            if (isdefined(team) && isdefined(level.teams[team]) && self.sessionteam != "spectator") {
                self.timeplayed[team]++;
                self.timeplayed["total"]++;
                if (isalive(self)) {
                    self.timeplayed["alive"]++;
                }
            } else {
                self.timeplayed["other"]++;
            }
        }
        wait 1;
    }
}

// Namespace teams
// Params 2, eflags: 0x0
// Checksum 0xf03c7348, Offset: 0x1418
// Size: 0x74
function function_37fd0a0f(team, weapon) {
    self detachall();
    self setmovespeedscale(1);
    self function_ba25e637(4);
    self function_e67885f8(0);
}

// Namespace teams
// Params 1, eflags: 0x0
// Checksum 0xf2202718, Offset: 0x1498
// Size: 0x6c
function get_flag_model(teamref) {
    assert(isdefined(game["<dev string:x3b>"]));
    assert(isdefined(game["<dev string:x3b>"][teamref]));
    return game["flagmodels"][teamref];
}

// Namespace teams
// Params 1, eflags: 0x0
// Checksum 0x363fbb5e, Offset: 0x1510
// Size: 0x6c
function get_flag_carry_model(teamref) {
    assert(isdefined(game["<dev string:x46>"]));
    assert(isdefined(game["<dev string:x46>"][teamref]));
    return game["carry_flagmodels"][teamref];
}

// Namespace teams
// Params 1, eflags: 0x0
// Checksum 0x7ef0f9ba, Offset: 0x1588
// Size: 0x60
function getteamindex(team) {
    if (!isdefined(team)) {
        return 0;
    }
    if (team == "free") {
        return 0;
    }
    if (team == "allies") {
        return 1;
    }
    if (team == "axis") {
        return 2;
    }
    return 0;
}

// Namespace teams
// Params 1, eflags: 0x0
// Checksum 0x9fc9f4d5, Offset: 0x15f0
// Size: 0xba
function getenemyteam(player_team) {
    foreach (team in level.teams) {
        if (team == player_team) {
            continue;
        }
        if (team == "spectator") {
            continue;
        }
        return team;
    }
    return util::getotherteam(player_team);
}

// Namespace teams
// Params 0, eflags: 0x0
// Checksum 0x3c833ccf, Offset: 0x16b8
// Size: 0x13c
function getenemyplayers() {
    enemies = [];
    foreach (player in level.players) {
        if (player.team == "spectator") {
            continue;
        }
        if (!level.teambased && (level.teambased && player.team != self.team || player != self)) {
            if (!isdefined(enemies)) {
                enemies = [];
            } else if (!isarray(enemies)) {
                enemies = array(enemies);
            }
            enemies[enemies.size] = player;
        }
    }
    return enemies;
}

// Namespace teams
// Params 0, eflags: 0x0
// Checksum 0x90f6ec45, Offset: 0x1800
// Size: 0x10c
function getfriendlyplayers() {
    friendlies = [];
    foreach (player in level.players) {
        if (player.team == self.team && player != self) {
            if (!isdefined(friendlies)) {
                friendlies = [];
            } else if (!isarray(friendlies)) {
                friendlies = array(friendlies);
            }
            friendlies[friendlies.size] = player;
        }
    }
    return friendlies;
}

// Namespace teams
// Params 6, eflags: 0x0
// Checksum 0x2580118f, Offset: 0x1918
// Size: 0xc0
function waituntilteamchange(player, callback, arg, end_condition1, end_condition2, end_condition3) {
    if (isdefined(end_condition1)) {
        self endon(end_condition1);
    }
    if (isdefined(end_condition2)) {
        self endon(end_condition2);
    }
    if (isdefined(end_condition3)) {
        self endon(end_condition3);
    }
    event = player util::waittill_any("joined_team", "disconnect", "joined_spectators");
    if (isdefined(callback)) {
        self [[ callback ]](arg, event);
    }
}

// Namespace teams
// Params 7, eflags: 0x0
// Checksum 0x9767e803, Offset: 0x19e0
// Size: 0xe0
function waituntilteamchangesingleton(player, singletonstring, callback, arg, end_condition1, end_condition2, end_condition3) {
    self notify(singletonstring);
    self endon(singletonstring);
    if (isdefined(end_condition1)) {
        self endon(end_condition1);
    }
    if (isdefined(end_condition2)) {
        self endon(end_condition2);
    }
    if (isdefined(end_condition3)) {
        self endon(end_condition3);
    }
    event = player util::waittill_any("joined_team", "disconnect", "joined_spectators");
    if (isdefined(callback)) {
        self thread [[ callback ]](arg, event);
    }
}

// Namespace teams
// Params 0, eflags: 0x0
// Checksum 0xd678ee7a, Offset: 0x1ac8
// Size: 0x64
function hidetosameteam() {
    if (level.teambased) {
        self setvisibletoallexceptteam(self.team);
        return;
    }
    self setvisibletoall();
    self setinvisibletoplayer(self.owner);
}

