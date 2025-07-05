#using scripts/codescripts/struct;
#using scripts/shared/callbacks_shared;
#using scripts/shared/system_shared;

#namespace spectating;

// Namespace spectating
// Params 0, eflags: 0x2
// Checksum 0xe1e2c037, Offset: 0x110
// Size: 0x2a
function autoexec __init__sytem__() {
    system::register("spectating", &__init__, undefined, undefined);
}

// Namespace spectating
// Params 0, eflags: 0x0
// Checksum 0x8a45d88a, Offset: 0x148
// Size: 0x82
function __init__() {
    callback::on_start_gametype(&init);
    callback::on_spawned(&set_permissions);
    callback::on_joined_team(&set_permissions_for_machine);
    callback::on_joined_spectate(&set_permissions_for_machine);
}

// Namespace spectating
// Params 0, eflags: 0x0
// Checksum 0x6fa0e069, Offset: 0x1d8
// Size: 0x6b
function init() {
    foreach (team in level.teams) {
        level.spectateoverride[team] = spawnstruct();
    }
}

// Namespace spectating
// Params 0, eflags: 0x0
// Checksum 0x44cbe9aa, Offset: 0x250
// Size: 0x49
function update_settings() {
    level endon(#"game_ended");
    for (index = 0; index < level.players.size; index++) {
        level.players[index] set_permissions();
    }
}

// Namespace spectating
// Params 0, eflags: 0x0
// Checksum 0xfa3dd387, Offset: 0x2a8
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
    return self.sessionteam;
}

// Namespace spectating
// Params 0, eflags: 0x0
// Checksum 0x64142835, Offset: 0x350
// Size: 0x88
function other_local_player_still_alive() {
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
        if (isalive(level.players[index])) {
            return true;
        }
    }
    return false;
}

// Namespace spectating
// Params 1, eflags: 0x0
// Checksum 0xefee0c59, Offset: 0x3e0
// Size: 0x6b
function function_c532d79b(allow) {
    foreach (team in level.teams) {
        self allowspectateteam(team, allow);
    }
}

// Namespace spectating
// Params 2, eflags: 0x0
// Checksum 0xb86b6f6, Offset: 0x458
// Size: 0x83
function function_2cf41c8d(skip_team, allow) {
    foreach (team in level.teams) {
        if (team == skip_team) {
            continue;
        }
        self allowspectateteam(team, allow);
    }
}

// Namespace spectating
// Params 0, eflags: 0x0
// Checksum 0x4c9d5475, Offset: 0x4e8
// Size: 0x3fa
function set_permissions() {
    team = self.sessionteam;
    if (team == "spectator") {
        if (self issplitscreen() && !level.splitscreen) {
            team = get_splitscreen_team();
        }
        if (team == "spectator") {
            self function_c532d79b(1);
            self allowspectateteam("freelook", 0);
            self allowspectateteam("none", 1);
            self allowspectateteam("localplayers", 1);
            return;
        }
    }
    spectatetype = level.spectatetype;
    switch (spectatetype) {
    case 0:
        self function_c532d79b(0);
        self allowspectateteam("freelook", 0);
        self allowspectateteam("none", 1);
        self allowspectateteam("localplayers", 0);
        break;
    case 3:
        if (self issplitscreen() && self other_local_player_still_alive()) {
            self function_c532d79b(0);
            self allowspectateteam("none", 0);
            self allowspectateteam("freelook", 0);
            self allowspectateteam("localplayers", 1);
            break;
        }
    case 1:
        if (!level.teambased) {
            self function_c532d79b(1);
            self allowspectateteam("none", 1);
            self allowspectateteam("freelook", 0);
            self allowspectateteam("localplayers", 1);
        } else if (isdefined(team) && isdefined(level.teams[team])) {
            self allowspectateteam(team, 1);
            self function_2cf41c8d(team, 0);
            self allowspectateteam("freelook", 0);
            self allowspectateteam("none", 0);
            self allowspectateteam("localplayers", 1);
        } else {
            self function_c532d79b(0);
            self allowspectateteam("freelook", 0);
            self allowspectateteam("none", 0);
            self allowspectateteam("localplayers", 1);
        }
        break;
    case 2:
        self function_c532d79b(1);
        self allowspectateteam("freelook", 1);
        self allowspectateteam("none", 1);
        self allowspectateteam("localplayers", 1);
        break;
    }
    if (isdefined(team) && isdefined(level.teams[team])) {
        if (isdefined(level.spectateoverride[team].allowfreespectate)) {
            self allowspectateteam("freelook", 1);
        }
        if (isdefined(level.spectateoverride[team].allowenemyspectate)) {
            self function_2cf41c8d(team, 1);
        }
    }
}

// Namespace spectating
// Params 0, eflags: 0x0
// Checksum 0x743189b3, Offset: 0x8f0
// Size: 0xa9
function set_permissions_for_machine() {
    self set_permissions();
    if (!self issplitscreen()) {
        return;
    }
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
        level.players[index] set_permissions();
    }
}

