#using scripts/cp/_util;
#using scripts/cp/gametypes/_spectating;
#using scripts/cp/gametypes/_globallogic_ui;
#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/persistence_shared;
#using scripts/shared/callbacks_shared;
#using scripts/codescripts/struct;

#namespace teams;

// Namespace teams
// Params 0, eflags: 0x2
// namespace_e7a38025<file_0>::function_2dc19561
// Checksum 0xd34417ca, Offset: 0x2d8
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("teams", &__init__, undefined, undefined);
}

// Namespace teams
// Params 0, eflags: 0x1 linked
// namespace_e7a38025<file_0>::function_8c87d8eb
// Checksum 0xafe4d79, Offset: 0x318
// Size: 0x3c
function __init__() {
    callback::on_start_gametype(&init);
    level.getenemyteam = &getenemyteam;
}

// Namespace teams
// Params 0, eflags: 0x1 linked
// namespace_e7a38025<file_0>::function_c35e6aab
// Checksum 0xf4d87849, Offset: 0x360
// Size: 0x224
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
        wait(0.15);
        level thread update_player_times();
        return;
    }
    callback::on_connect(&on_free_player_connect);
    wait(0.15);
    level thread update_player_times();
}

// Namespace teams
// Params 0, eflags: 0x1 linked
// namespace_e7a38025<file_0>::function_fb4f96b5
// Checksum 0xdc65ab83, Offset: 0x590
// Size: 0x1c
function on_player_connect() {
    self thread function_e7a40e44();
}

// Namespace teams
// Params 0, eflags: 0x1 linked
// namespace_e7a38025<file_0>::function_5cc8a462
// Checksum 0x3cddbd8e, Offset: 0x5b8
// Size: 0x1c
function on_free_player_connect() {
    self thread track_free_played_time();
}

// Namespace teams
// Params 0, eflags: 0x1 linked
// namespace_e7a38025<file_0>::function_f6076bfe
// Checksum 0xca5bbfcb, Offset: 0x5e0
// Size: 0x4c
function on_joined_team() {
    println("1800" + self.pers["1800"]);
    self update_time();
}

// Namespace teams
// Params 0, eflags: 0x1 linked
// namespace_e7a38025<file_0>::function_d2b6d98f
// Checksum 0x3a6c880a, Offset: 0x638
// Size: 0x14
function on_joined_spectators() {
    self.pers["teamTime"] = undefined;
}

// Namespace teams
// Params 0, eflags: 0x1 linked
// namespace_e7a38025<file_0>::function_e7a40e44
// Checksum 0x71f33ad3, Offset: 0x658
// Size: 0x224
function function_e7a40e44() {
    self endon(#"disconnect");
    self endon(#"hash_a9de32eb");
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
        wait(0.05);
    }
    for (;;) {
        if (game["state"] == "playing") {
            if (isdefined(level.teams[self.sessionteam])) {
                self.timeplayed[self.sessionteam]++;
                self.timeplayed["total"]++;
                if (isalive(self)) {
                    self.timeplayed["alive"]++;
                }
            } else if (self.sessionteam == "spectator") {
                self.timeplayed["other"]++;
            }
        }
        wait(1);
    }
}

// Namespace teams
// Params 0, eflags: 0x1 linked
// namespace_e7a38025<file_0>::function_2eda566d
// Checksum 0x6d0c53c5, Offset: 0x888
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
                wait(var_b3b708df);
            }
            var_b3b708df = 10;
        }
        if (isdefined(level.players[nexttoupdate])) {
            level.players[nexttoupdate] update_played_time();
            level.players[nexttoupdate] persistence::function_b526d623();
        }
        wait(1);
    }
}

// Namespace teams
// Params 0, eflags: 0x1 linked
// namespace_e7a38025<file_0>::function_4f6c13e4
// Checksum 0xc3111a0d, Offset: 0x978
// Size: 0x382
function update_played_time() {
    pixbeginevent("updatePlayedTime");
    foreach (team in level.teams) {
        if (self.timeplayed[team]) {
            self addplayerstat("time_played_" + team, int(min(self.timeplayed[team], level.timeplayedcap)));
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
// Params 0, eflags: 0x1 linked
// namespace_e7a38025<file_0>::function_2fc9381e
// Checksum 0xf88e0480, Offset: 0xd08
// Size: 0x32
function update_time() {
    if (game["state"] != "playing") {
        return;
    }
    self.pers["teamTime"] = gettime();
}

// Namespace teams
// Params 0, eflags: 0x1 linked
// namespace_e7a38025<file_0>::function_88ad84a5
// Checksum 0x37726b91, Offset: 0xd48
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
        wait(1);
    }
}

// Namespace teams
// Params 1, eflags: 0x0
// namespace_e7a38025<file_0>::function_5f5f81d1
// Checksum 0x1181abf1, Offset: 0xe20
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
// Params 0, eflags: 0x1 linked
// namespace_e7a38025<file_0>::function_193a1a91
// Checksum 0xa4de2aed, Offset: 0xf98
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
// Params 0, eflags: 0x1 linked
// namespace_e7a38025<file_0>::function_4e36223d
// Checksum 0x99bfa1bf, Offset: 0x1110
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
        wait(1);
    }
}

// Namespace teams
// Params 2, eflags: 0x1 linked
// namespace_e7a38025<file_0>::function_37fd0a0f
// Checksum 0xce01bf65, Offset: 0x12b8
// Size: 0x74
function function_37fd0a0f(team, weapon) {
    self detachall();
    self setmovespeedscale(1);
    self function_ba25e637(4);
    self function_e67885f8(0);
}

// Namespace teams
// Params 1, eflags: 0x0
// namespace_e7a38025<file_0>::function_536cc94a
// Checksum 0x9b518bcf, Offset: 0x1338
// Size: 0x6c
function get_flag_model(teamref) {
    assert(isdefined(game["1800"]));
    assert(isdefined(game["1800"][teamref]));
    return game["flagmodels"][teamref];
}

// Namespace teams
// Params 1, eflags: 0x0
// namespace_e7a38025<file_0>::function_db0684da
// Checksum 0x2e219fd, Offset: 0x13b0
// Size: 0x6c
function get_flag_carry_model(teamref) {
    assert(isdefined(game["1800"]));
    assert(isdefined(game["1800"][teamref]));
    return game["carry_flagmodels"][teamref];
}

// Namespace teams
// Params 1, eflags: 0x0
// namespace_e7a38025<file_0>::function_3370313c
// Checksum 0xd80f8b81, Offset: 0x1428
// Size: 0x6c
function function_3370313c(teamref) {
    assert(isdefined(game["1800"]));
    assert(isdefined(game["1800"][teamref]));
    return game["carry_icon"][teamref];
}

// Namespace teams
// Params 1, eflags: 0x1 linked
// namespace_e7a38025<file_0>::function_c7762542
// Checksum 0x18c46d3f, Offset: 0x14a0
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

