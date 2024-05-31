#using scripts/shared/system_shared;
#using scripts/shared/callbacks_shared;
#using scripts/codescripts/struct;

#namespace friendicons;

// Namespace friendicons
// Params 0, eflags: 0x2
// Checksum 0xc131eaa6, Offset: 0x120
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("friendicons", &__init__, undefined, undefined);
}

// Namespace friendicons
// Params 0, eflags: 0x1 linked
// Checksum 0xa43f9f55, Offset: 0x160
// Size: 0x24
function __init__() {
    callback::on_start_gametype(&init);
}

// Namespace friendicons
// Params 0, eflags: 0x1 linked
// Checksum 0xbb8a5f8e, Offset: 0x190
// Size: 0xd6
function init() {
    if (!level.teambased) {
        return;
    }
    if (getdvarstring("scr_drawfriend") == "") {
        setdvar("scr_drawfriend", "0");
    }
    level.drawfriend = getdvarint("scr_drawfriend");
    callback::on_spawned(&on_player_spawned);
    callback::on_player_killed(&on_player_killed);
    for (;;) {
        updatefriendiconsettings();
        wait(5);
    }
}

// Namespace friendicons
// Params 0, eflags: 0x1 linked
// Checksum 0x9ef6a818, Offset: 0x270
// Size: 0x24
function on_player_spawned() {
    self endon(#"disconnect");
    self thread showfriendicon();
}

// Namespace friendicons
// Params 0, eflags: 0x1 linked
// Checksum 0x9e1a4079, Offset: 0x2a0
// Size: 0x20
function on_player_killed() {
    self endon(#"disconnect");
    self.headicon = "";
}

// Namespace friendicons
// Params 0, eflags: 0x1 linked
// Checksum 0x73585cc4, Offset: 0x2c8
// Size: 0x54
function showfriendicon() {
    if (level.drawfriend) {
        team = self.pers["team"];
        self.headicon = game["headicon_" + team];
        self.headiconteam = team;
    }
}

// Namespace friendicons
// Params 0, eflags: 0x1 linked
// Checksum 0xb4f71c2d, Offset: 0x328
// Size: 0x54
function updatefriendiconsettings() {
    drawfriend = getdvarfloat("scr_drawfriend");
    if (level.drawfriend != drawfriend) {
        level.drawfriend = drawfriend;
        updatefriendicons();
    }
}

// Namespace friendicons
// Params 0, eflags: 0x1 linked
// Checksum 0x4fba326a, Offset: 0x388
// Size: 0x1b0
function updatefriendicons() {
    players = level.players;
    for (i = 0; i < players.size; i++) {
        player = players[i];
        if (isdefined(player.pers["team"]) && player.pers["team"] != "spectator" && player.sessionstate == "playing") {
            if (level.drawfriend) {
                team = self.pers["team"];
                self.headicon = game["headicon_" + team];
                self.headiconteam = team;
                continue;
            }
            players = level.players;
            for (i = 0; i < players.size; i++) {
                player = players[i];
                if (isdefined(player.pers["team"]) && player.pers["team"] != "spectator" && player.sessionstate == "playing") {
                    player.headicon = "";
                }
            }
        }
    }
}

