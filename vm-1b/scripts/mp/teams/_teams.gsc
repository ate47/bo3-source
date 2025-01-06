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
// Checksum 0x242f61a3, Offset: 0x300
// Size: 0x2a
function autoexec function_2dc19561() {
    system::register("teams", &__init__, undefined, undefined);
}

// Namespace teams
// Params 0, eflags: 0x0
// Checksum 0x3e46b180, Offset: 0x338
// Size: 0x3a
function __init__() {
    callback::on_start_gametype(&init);
    level.getenemyteam = &getenemyteam;
}

// Namespace teams
// Params 0, eflags: 0x0
// Checksum 0xdc2b10cc, Offset: 0x380
// Size: 0x19
function init() {
    InvalidOpCode(0xc8, "strings", "autobalance", %MP_AUTOBALANCE_NOW);
    // Unknown operator (0xc8, t7_1b, PC)
}

// Namespace teams
// Params 0, eflags: 0x0
// Checksum 0x984a847a, Offset: 0x570
// Size: 0x12
function on_player_connect() {
    self thread function_e7a40e44();
}

// Namespace teams
// Params 0, eflags: 0x0
// Checksum 0x263b1e1c, Offset: 0x590
// Size: 0x12
function on_free_player_connect() {
    self thread track_free_played_time();
}

// Namespace teams
// Params 0, eflags: 0x0
// Checksum 0xc13218ee, Offset: 0x5b0
// Size: 0x3a
function on_joined_team() {
    println("<dev string:x28>" + self.pers["<dev string:x36>"]);
    self update_time();
}

// Namespace teams
// Params 0, eflags: 0x0
// Checksum 0x22257c27, Offset: 0x5f8
// Size: 0x12
function on_joined_spectators() {
    self.pers["teamTime"] = undefined;
}

// Namespace teams
// Params 0, eflags: 0x0
// Checksum 0xf70c8d47, Offset: 0x618
// Size: 0x109
function function_e7a40e44() {
    self endon(#"disconnect");
    foreach (team in level.teams) {
        self.timeplayed[team] = 0;
    }
    self.timeplayed["free"] = 0;
    self.timeplayed["other"] = 0;
    self.timeplayed["alive"] = 0;
    InvalidOpCode(0x54, "roundsplayed", 0);
    // Unknown operator (0x54, t7_1b, PC)
LOC_000000c3:
    if (!isdefined(self.timeplayed["total"]) || !(level.gametype == "twar" && level.gametype == "twar" && 0 < self.timeplayed["total"])) {
        self.timeplayed["total"] = 0;
    }
    while (level.inprematchperiod) {
        wait 0.05;
    }
    InvalidOpCode(0x54, "state");
    // Unknown operator (0x54, t7_1b, PC)
}

// Namespace teams
// Params 0, eflags: 0x0
// Checksum 0xb32d3cbe, Offset: 0x810
// Size: 0x6d
function update_player_times() {
    nexttoupdate = 0;
    for (;;) {
        nexttoupdate++;
        if (nexttoupdate >= level.players.size) {
            nexttoupdate = 0;
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
// Checksum 0xfaa51d3f, Offset: 0x888
// Size: 0x2e1
function update_played_time() {
    pixbeginevent("updatePlayedTime");
    if (level.rankedmatch || level.leaguematch) {
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
    }
    if (level.onlinegame) {
        timealive = int(min(self.timeplayed["alive"], level.timeplayedcap));
        self.pers["time_played_alive"] = self.pers["time_played_alive"] + timealive;
    }
    pixendevent();
    InvalidOpCode(0x54, "state");
    // Unknown operator (0x54, t7_1b, PC)
}

// Namespace teams
// Params 0, eflags: 0x0
// Checksum 0x7aa02b79, Offset: 0xbd8
// Size: 0x9
function update_time() {
    InvalidOpCode(0x54, "state");
    // Unknown operator (0x54, t7_1b, PC)
}

// Namespace teams
// Params 0, eflags: 0x0
// Checksum 0xcfbf6f07, Offset: 0xc08
// Size: 0xb1
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
// Checksum 0x4a7dae5a, Offset: 0xcc8
// Size: 0x101
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
    InvalidOpCode(0x54, "menu_start_menu");
    // Unknown operator (0x54, t7_1b, PC)
}

// Namespace teams
// Params 0, eflags: 0x0
// Checksum 0x70f27378, Offset: 0xe08
// Size: 0x103
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
// Checksum 0x34912df3, Offset: 0xf18
// Size: 0x99
function track_free_played_time() {
    self endon(#"disconnect");
    foreach (team in level.teams) {
        self.timeplayed[team] = 0;
    }
    self.timeplayed["other"] = 0;
    self.timeplayed["total"] = 0;
    self.timeplayed["alive"] = 0;
    InvalidOpCode(0x54, "state");
    // Unknown operator (0x54, t7_1b, PC)
}

// Namespace teams
// Params 2, eflags: 0x0
// Checksum 0xeed41889, Offset: 0x1060
// Size: 0x52
function function_37fd0a0f(team, weapon) {
    self detachall();
    self setmovespeedscale(1);
    self function_ba25e637(4);
    self function_e67885f8(0);
}

// Namespace teams
// Params 1, eflags: 0x0
// Checksum 0xba168759, Offset: 0x10c0
// Size: 0x51
function get_flag_model(teamref) {
    /#
        InvalidOpCode(0x54, "<dev string:x3b>");
        // Unknown operator (0x54, t7_1b, PC)
    #/
    /#
        InvalidOpCode(0x54, "<dev string:x3b>", teamref);
        // Unknown operator (0x54, t7_1b, PC)
    #/
    InvalidOpCode(0x54, "flagmodels", teamref);
    // Unknown operator (0x54, t7_1b, PC)
}

// Namespace teams
// Params 1, eflags: 0x0
// Checksum 0x2dabd990, Offset: 0x1120
// Size: 0x51
function get_flag_carry_model(teamref) {
    /#
        InvalidOpCode(0x54, "<dev string:x46>");
        // Unknown operator (0x54, t7_1b, PC)
    #/
    /#
        InvalidOpCode(0x54, "<dev string:x46>", teamref);
        // Unknown operator (0x54, t7_1b, PC)
    #/
    InvalidOpCode(0x54, "carry_flagmodels", teamref);
    // Unknown operator (0x54, t7_1b, PC)
}

// Namespace teams
// Params 1, eflags: 0x0
// Checksum 0xee9d1eeb, Offset: 0x1180
// Size: 0x89
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
// Checksum 0x962b7cf5, Offset: 0x1218
// Size: 0xef
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
// Checksum 0x124336, Offset: 0x1310
// Size: 0xbf
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
// Checksum 0x951ce19f, Offset: 0x13d8
// Size: 0x96
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
// Checksum 0x8c3ac9a, Offset: 0x1478
// Size: 0xa6
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
// Checksum 0xf0bcfe70, Offset: 0x1528
// Size: 0x4a
function hidetosameteam() {
    if (level.teambased) {
        self setvisibletoallexceptteam(self.team);
        return;
    }
    self setvisibletoall();
    self setinvisibletoplayer(self.owner);
}

