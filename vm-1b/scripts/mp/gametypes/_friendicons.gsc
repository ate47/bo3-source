#using scripts/codescripts/struct;
#using scripts/shared/callbacks_shared;
#using scripts/shared/system_shared;

#namespace friendicons;

// Namespace friendicons
// Params 0, eflags: 0x2
// Checksum 0xe1e2c037, Offset: 0x120
// Size: 0x2a
function autoexec __init__sytem__() {
    system::register("friendicons", &__init__, undefined, undefined);
}

// Namespace friendicons
// Params 0, eflags: 0x0
// Checksum 0x1abd3ce, Offset: 0x158
// Size: 0x22
function __init__() {
    callback::on_start_gametype(&init);
}

// Namespace friendicons
// Params 0, eflags: 0x0
// Checksum 0x59086eb7, Offset: 0x188
// Size: 0x111
function init() {
    if (!level.teambased) {
        return;
    }
    if (getdvarstring("scr_drawfriend") == "") {
        setdvar("scr_drawfriend", "0");
    }
    level.drawfriend = getdvarint("scr_drawfriend");
    /#
        InvalidOpCode(0x54, "<dev string:x28>", "<dev string:x38>");
        // Unknown operator (0x54, t7_1b, PC)
    #/
    /#
        InvalidOpCode(0x54, "<dev string:x7e>", "<dev string:x8c>");
        // Unknown operator (0x54, t7_1b, PC)
    #/
    callback::on_spawned(&on_player_spawned);
    callback::on_player_killed(&on_player_killed);
    for (;;) {
        updatefriendiconsettings();
        wait 5;
    }
}

// Namespace friendicons
// Params 0, eflags: 0x0
// Checksum 0x18cbcce6, Offset: 0x2a8
// Size: 0x1a
function on_player_killed() {
    self endon(#"disconnect");
    self.headicon = "";
}

// Namespace friendicons
// Params 0, eflags: 0x0
// Checksum 0x9a6f2c99, Offset: 0x2d0
// Size: 0x1a
function on_player_spawned() {
    self endon(#"disconnect");
    self thread showfriendicon();
}

// Namespace friendicons
// Params 0, eflags: 0x0
// Checksum 0x606e268b, Offset: 0x2f8
// Size: 0x46
function showfriendicon() {
    if (level.drawfriend) {
        team = self.pers["team"];
        InvalidOpCode(0x54, "headicon_" + team);
        // Unknown operator (0x54, t7_1b, PC)
    }
}

// Namespace friendicons
// Params 0, eflags: 0x0
// Checksum 0xcbec930e, Offset: 0x348
// Size: 0x4a
function updatefriendiconsettings() {
    drawfriend = getdvarfloat("scr_drawfriend");
    if (level.drawfriend != drawfriend) {
        level.drawfriend = drawfriend;
        updatefriendicons();
    }
}

// Namespace friendicons
// Params 0, eflags: 0x0
// Checksum 0xdc233bd6, Offset: 0x3a0
// Size: 0x147
function updatefriendicons() {
    players = level.players;
    for (i = 0; i < players.size; i++) {
        player = players[i];
        if (isdefined(player.pers["team"]) && player.pers["team"] != "spectator" && player.sessionstate == "playing") {
            if (level.drawfriend) {
                team = self.pers["team"];
                InvalidOpCode(0x54, "headicon_" + team);
                // Unknown operator (0x54, t7_1b, PC)
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

