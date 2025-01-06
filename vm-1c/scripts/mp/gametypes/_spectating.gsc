#using scripts/codescripts/struct;
#using scripts/shared/callbacks_shared;
#using scripts/shared/system_shared;

#namespace spectating;

// Namespace spectating
// Params 0, eflags: 0x2
// Checksum 0x5e814cee, Offset: 0x110
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("spectating", &__init__, undefined, undefined);
}

// Namespace spectating
// Params 0, eflags: 0x0
// Checksum 0xa0d8ce58, Offset: 0x150
// Size: 0x84
function __init__() {
    callback::on_start_gametype(&init);
    callback::on_spawned(&set_permissions);
    callback::on_joined_team(&set_permissions_for_machine);
    callback::on_joined_spectate(&set_permissions_for_machine);
}

// Namespace spectating
// Params 0, eflags: 0x0
// Checksum 0x654f2acc, Offset: 0x1e0
// Size: 0x98
function init() {
    foreach (team in level.teams) {
        level.spectateoverride[team] = spawnstruct();
    }
}

// Namespace spectating
// Params 0, eflags: 0x0
// Checksum 0x882206f2, Offset: 0x280
// Size: 0x5e
function update_settings() {
    level endon(#"game_ended");
    for (index = 0; index < level.players.size; index++) {
        level.players[index] set_permissions();
    }
}

// Namespace spectating
// Params 0, eflags: 0x0
// Checksum 0xee4ccafc, Offset: 0x2e8
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
    return self.sessionteam;
}

// Namespace spectating
// Params 0, eflags: 0x0
// Checksum 0x1227bb45, Offset: 0x3c0
// Size: 0xb8
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
// Checksum 0x46a547cd, Offset: 0x480
// Size: 0x9a
function function_c532d79b(allow) {
    foreach (team in level.teams) {
        self allowspectateteam(team, allow);
    }
}

// Namespace spectating
// Params 2, eflags: 0x0
// Checksum 0x2c9c4368, Offset: 0x528
// Size: 0xb2
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
// Checksum 0x787e0ce, Offset: 0x5e8
// Size: 0x524
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
// Checksum 0x63115f8, Offset: 0xb18
// Size: 0xde
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

