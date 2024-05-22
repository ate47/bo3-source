#using scripts/shared/system_shared;
#using scripts/shared/callbacks_shared;
#using scripts/codescripts/struct;

#namespace friendicons;

// Namespace friendicons
// Params 0, eflags: 0x2
// Checksum 0xbf04a5ef, Offset: 0x120
// Size: 0x34
function function_2dc19561() {
    system::register("friendicons", &__init__, undefined, undefined);
}

// Namespace friendicons
// Params 0, eflags: 0x1 linked
// Checksum 0xd33beb90, Offset: 0x160
// Size: 0x24
function __init__() {
    callback::on_start_gametype(&init);
}

// Namespace friendicons
// Params 0, eflags: 0x1 linked
// Checksum 0x56ace878, Offset: 0x190
// Size: 0x136
function init() {
    if (!level.teambased) {
        return;
    }
    if (getdvarstring("scr_drawfriend") == "") {
        setdvar("scr_drawfriend", "0");
    }
    level.drawfriend = getdvarint("scr_drawfriend");
    /#
        assert(isdefined(game["<unknown string>"]), "<unknown string>");
    #/
    /#
        assert(isdefined(game["<unknown string>"]), "<unknown string>");
    #/
    callback::on_spawned(&on_player_spawned);
    callback::on_player_killed(&on_player_killed);
    for (;;) {
        updatefriendiconsettings();
        wait(5);
    }
}

// Namespace friendicons
// Params 0, eflags: 0x1 linked
// Checksum 0x5dcee5cd, Offset: 0x2d0
// Size: 0x20
function on_player_killed() {
    self endon(#"disconnect");
    self.headicon = "";
}

// Namespace friendicons
// Params 0, eflags: 0x1 linked
// Checksum 0x3cf82493, Offset: 0x2f8
// Size: 0x24
function on_player_spawned() {
    self endon(#"disconnect");
    self thread showfriendicon();
}

// Namespace friendicons
// Params 0, eflags: 0x1 linked
// Checksum 0xaa94cf75, Offset: 0x328
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
// Checksum 0xaf5c97e9, Offset: 0x388
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
// Checksum 0x714bbaca, Offset: 0x3e8
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

