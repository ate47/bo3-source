#using scripts/codescripts/struct;
#using scripts/mp/_util;
#using scripts/mp/gametypes/_globallogic_audio;
#using scripts/shared/hud_message_shared;
#using scripts/shared/hud_util_shared;
#using scripts/shared/music_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;

#namespace hud_message;

// Namespace hud_message
// Params 0, eflags: 0x0
// Checksum 0xa2916194, Offset: 0x528
// Size: 0x19
function init() {
    InvalidOpCode(0xc8, "strings", "draw", %MP_DRAW_CAPS);
    // Unknown operator (0xc8, t7_1b, PC)
}

// Namespace hud_message
// Params 3, eflags: 0x0
// Checksum 0xe8ada32, Offset: 0x768
// Size: 0x2e1
function teamoutcomenotify(winner, isround, endreasontext) {
    self endon(#"disconnect");
    self notify(#"reset_outcome");
    team = self.pers["team"];
    if (isdefined(team) && team == "spectator") {
        for (i = 0; i < level.players.size; i++) {
            if (self.currentspectatingclient == level.players[i].clientid) {
                team = level.players[i].pers["team"];
                break;
            }
        }
    }
    if (!isdefined(team) || !isdefined(level.teams[team])) {
        team = "allies";
    }
    while (self.var_decbf609) {
        wait 0.05;
    }
    self endon(#"reset_outcome");
    outcometext = "";
    notifyroundendtoui = isround;
    if (winner == "halftime") {
        InvalidOpCode(0x54, "strings", "halftime");
        // Unknown operator (0x54, t7_1b, PC)
    }
    if (winner == "intermission") {
        InvalidOpCode(0x54, "strings", "intermission");
        // Unknown operator (0x54, t7_1b, PC)
    }
    if (winner == "roundend") {
        InvalidOpCode(0x54, "strings", "roundend");
        // Unknown operator (0x54, t7_1b, PC)
    }
    if (winner == "overtime") {
        InvalidOpCode(0x54, "strings", "overtime");
        // Unknown operator (0x54, t7_1b, PC)
    }
    if (winner == "tie") {
        if (isround) {
            InvalidOpCode(0x54, "strings", "round_draw");
            // Unknown operator (0x54, t7_1b, PC)
        }
        InvalidOpCode(0x54, "strings", "draw");
        // Unknown operator (0x54, t7_1b, PC)
    }
    if (isdefined(self.pers["team"]) && winner == team) {
        if (isround) {
            InvalidOpCode(0x54, "strings", "round_win");
            // Unknown operator (0x54, t7_1b, PC)
        }
        InvalidOpCode(0x54, "strings", "victory");
        // Unknown operator (0x54, t7_1b, PC)
    }
    if (isround) {
        InvalidOpCode(0x54, "strings", "round_loss");
        // Unknown operator (0x54, t7_1b, PC)
    }
    InvalidOpCode(0x54, "strings", "defeat");
    // Unknown operator (0x54, t7_1b, PC)
}

// Namespace hud_message
// Params 3, eflags: 0x0
// Checksum 0xbfdb4b90, Offset: 0xcd0
// Size: 0x21a
function function_8cab5867(winner, isround, endreasontext) {
    self endon(#"disconnect");
    self notify(#"reset_outcome");
    team = self.pers["team"];
    if (isdefined(team) && team == "spectator") {
        for (i = 0; i < level.players.size; i++) {
            if (self.currentspectatingclient == level.players[i].clientid) {
                team = level.players[i].pers["team"];
                break;
            }
        }
    }
    if (!isdefined(team) || !isdefined(level.teams[team])) {
        team = "allies";
    }
    while (self.var_decbf609) {
        wait 0.05;
    }
    self endon(#"reset_outcome");
    if (level.splitscreen) {
        var_7fa9f5fa = 2;
        spacing = 10;
        font = "default";
    } else {
        var_7fa9f5fa = 3;
        spacing = 50;
        font = "objective";
    }
    var_9cdc61fb = hud::createfontstring(font, var_7fa9f5fa);
    var_9cdc61fb hud::setpoint("TOP", undefined, 0, spacing);
    var_9cdc61fb.glowalpha = 1;
    var_9cdc61fb.hidewheninmenu = 0;
    var_9cdc61fb.archived = 0;
    var_9cdc61fb.immunetodemogamehudsettings = 1;
    var_9cdc61fb.immunetodemofreecamera = 1;
    var_9cdc61fb settext(endreasontext);
    var_9cdc61fb setpulsefx(100, 60000, 1000);
    self thread function_7ebe2665(undefined, undefined, var_9cdc61fb);
}

// Namespace hud_message
// Params 3, eflags: 0x0
// Checksum 0xcf864afb, Offset: 0xef8
// Size: 0x155
function outcomenotify(winner, var_a913a63a, endreasontext) {
    self endon(#"disconnect");
    self notify(#"reset_outcome");
    while (self.var_decbf609) {
        wait 0.05;
    }
    self endon(#"reset_outcome");
    outcometext = "";
    players = level.placement["all"];
    numclients = players.size;
    if (!util::isoneround() && !var_a913a63a) {
        InvalidOpCode(0x54, "strings", "game_over");
        // Unknown operator (0x54, t7_1b, PC)
    }
    if (players[0].pointstowin == 0) {
        InvalidOpCode(0x54, "strings", "tie");
        // Unknown operator (0x54, t7_1b, PC)
    }
    if (self isintop(players, 1)) {
        InvalidOpCode(0x54, "strings", "victory");
        // Unknown operator (0x54, t7_1b, PC)
    }
    if (self isintop(players, 3)) {
        InvalidOpCode(0x54, "strings", "top3");
        // Unknown operator (0x54, t7_1b, PC)
    }
    InvalidOpCode(0x54, "strings", "defeat");
    // Unknown operator (0x54, t7_1b, PC)
}

// Namespace hud_message
// Params 2, eflags: 0x0
// Checksum 0xde6b9aaf, Offset: 0x10b8
// Size: 0x2f9
function function_d5235f38(winner, endreasontext) {
    self endon(#"disconnect");
    self notify(#"reset_outcome");
    while (self.var_decbf609) {
        wait 0.05;
    }
    setmatchflag("enable_popups", 0);
    self endon(#"reset_outcome");
    var_eed1ba45 = "extrabig";
    font = "objective";
    if (self issplitscreen()) {
        var_7fa9f5fa = 2;
        var_151b477b = 1.5;
        var_a4ea707e = 1.5;
        iconsize = 30;
        spacing = 2;
    } else {
        var_7fa9f5fa = 3;
        var_151b477b = 2;
        var_a4ea707e = 1.5;
        iconsize = 30;
        spacing = 20;
    }
    halftime = 0;
    if (isdefined(level.sidebet) && level.sidebet) {
        halftime = 1;
    }
    duration = 60000;
    players = level.placement["all"];
    var_9cdc61fb = hud::createfontstring(var_eed1ba45, var_7fa9f5fa);
    var_9cdc61fb hud::setpoint("TOP", undefined, 0, spacing);
    if (halftime) {
        InvalidOpCode(0x54, "strings", "intermission");
        // Unknown operator (0x54, t7_1b, PC)
    }
    if (isdefined(level.var_7fb97d34) && level.var_7fb97d34 == 1) {
        InvalidOpCode(0x54, "strings", "wager_topwinners");
        // Unknown operator (0x54, t7_1b, PC)
    }
    if (isdefined(self.var_2db92ec2) && self.var_2db92ec2 > 0) {
        InvalidOpCode(0x54, "strings", "wager_inthemoney");
        // Unknown operator (0x54, t7_1b, PC)
    }
    InvalidOpCode(0x54, "strings", "wager_loss");
    // Unknown operator (0x54, t7_1b, PC)
}

// Namespace hud_message
// Params 3, eflags: 0x0
// Checksum 0xfec655d9, Offset: 0x1898
// Size: 0x43d
function function_de9a72bf(winner, var_a913a63a, endreasontext) {
    self endon(#"disconnect");
    self notify(#"reset_outcome");
    team = self.pers["team"];
    if (!isdefined(team) || !isdefined(level.teams[team])) {
        team = "allies";
    }
    wait 0.05;
    while (self.var_decbf609) {
        wait 0.05;
    }
    self endon(#"reset_outcome");
    var_eed1ba45 = "extrabig";
    font = "objective";
    if (self issplitscreen()) {
        var_7fa9f5fa = 2;
        textsize = 1.5;
        iconsize = 30;
        spacing = 10;
    } else {
        var_7fa9f5fa = 3;
        textsize = 2;
        iconsize = 70;
        spacing = 15;
    }
    halftime = 0;
    if (isdefined(level.sidebet) && level.sidebet) {
        halftime = 1;
    }
    duration = 60000;
    var_9cdc61fb = hud::createfontstring(var_eed1ba45, var_7fa9f5fa);
    var_9cdc61fb hud::setpoint("TOP", undefined, 0, spacing);
    var_9cdc61fb.glowalpha = 1;
    var_9cdc61fb.hidewheninmenu = 0;
    var_9cdc61fb.archived = 0;
    var_9cdc61fb.immunetodemogamehudsettings = 1;
    var_9cdc61fb.immunetodemofreecamera = 1;
    outcometext = hud::createfontstring(font, 2);
    outcometext hud::setparent(var_9cdc61fb);
    outcometext hud::setpoint("TOP", "BOTTOM", 0, 0);
    outcometext.glowalpha = 1;
    outcometext.hidewheninmenu = 0;
    outcometext.archived = 0;
    outcometext.immunetodemogamehudsettings = 1;
    outcometext.immunetodemofreecamera = 1;
    if (winner == "tie") {
        if (var_a913a63a) {
            InvalidOpCode(0x54, "strings", "round_draw");
            // Unknown operator (0x54, t7_1b, PC)
        }
        InvalidOpCode(0x54, "strings", "draw");
        // Unknown operator (0x54, t7_1b, PC)
    }
    if (winner == "overtime") {
        InvalidOpCode(0x54, "strings", "overtime");
        // Unknown operator (0x54, t7_1b, PC)
    }
    if (isdefined(self.pers["team"]) && winner == team) {
        if (var_a913a63a) {
            InvalidOpCode(0x54, "strings", "round_win");
            // Unknown operator (0x54, t7_1b, PC)
        }
        InvalidOpCode(0x54, "strings", "victory");
        // Unknown operator (0x54, t7_1b, PC)
    }
    if (var_a913a63a) {
        InvalidOpCode(0x54, "strings", "round_loss");
        // Unknown operator (0x54, t7_1b, PC)
    }
    InvalidOpCode(0x54, "strings", "defeat");
    // Unknown operator (0x54, t7_1b, PC)
}

// Namespace hud_message
// Params 10, eflags: 0x0
// Checksum 0xc3fd2a04, Offset: 0x2378
// Size: 0x19b
function function_7ebe2665(var_38c290ce, var_12c01665, var_218d0eb4, var_fb8a944b, var_d58819e2, var_af859f79, var_89832510, var_c3a85137, var_9da5d6ce, var_a2b3e562) {
    self endon(#"disconnect");
    self waittill(#"reset_outcome");
    function_6d358955(var_218d0eb4);
    function_6d358955(var_fb8a944b);
    function_6d358955(var_d58819e2);
    function_6d358955(var_af859f79);
    function_6d358955(var_89832510);
    function_6d358955(var_c3a85137);
    function_6d358955(var_9da5d6ce);
    function_6d358955(var_a2b3e562);
    if (isdefined(var_38c290ce)) {
        foreach (elem in var_38c290ce) {
            function_6d358955(elem);
        }
    }
    if (isdefined(var_12c01665)) {
        foreach (elem in var_12c01665) {
            function_6d358955(elem);
        }
    }
}

// Namespace hud_message
// Params 4, eflags: 0x0
// Checksum 0x7fb01f64, Offset: 0x2520
// Size: 0xda
function function_c7dff00f(var_da7e1972, var_6c73b74a, var_9cdc61fb, outcometext) {
    self endon(#"disconnect");
    self waittill(#"reset_outcome");
    for (i = var_da7e1972.size - 1; i >= 0; i--) {
        if (isdefined(var_da7e1972[i])) {
            var_da7e1972[i] destroy();
        }
    }
    for (i = var_6c73b74a.size - 1; i >= 0; i--) {
        if (isdefined(var_6c73b74a[i])) {
            var_6c73b74a[i] destroy();
        }
    }
    if (isdefined(outcometext)) {
        outcometext destroy();
    }
    if (isdefined(var_9cdc61fb)) {
        var_9cdc61fb destroy();
    }
}

// Namespace hud_message
// Params 3, eflags: 0x0
// Checksum 0x8218aa82, Offset: 0x2608
// Size: 0x101
function function_da2b338e(var_66184a91, var_8c75d30d, var_4a691eaa) {
    self endon(#"disconnect");
    self endon(#"reset_outcome");
    while (true) {
        self waittill(#"update_outcome");
        players = level.placement["all"];
        if (isdefined(var_66184a91) && isdefined(players[0])) {
            var_66184a91 setplayernamestring(players[0]);
        } else if (isdefined(var_66184a91)) {
            var_66184a91.alpha = 0;
        }
        if (isdefined(var_8c75d30d) && isdefined(players[1])) {
            var_8c75d30d setplayernamestring(players[1]);
        } else if (isdefined(var_8c75d30d)) {
            var_8c75d30d.alpha = 0;
        }
        if (isdefined(var_4a691eaa) && isdefined(players[2])) {
            var_4a691eaa setplayernamestring(players[2]);
            continue;
        }
        if (isdefined(var_4a691eaa)) {
            var_4a691eaa.alpha = 0;
        }
    }
}

// Namespace hud_message
// Params 2, eflags: 0x0
// Checksum 0xcaedb074, Offset: 0x2718
// Size: 0xe1
function function_cd821d4(var_da7e1972, var_6c73b74a) {
    self endon(#"disconnect");
    self endon(#"reset_outcome");
    while (true) {
        self waittill(#"update_outcome");
        players = level.placement["all"];
        for (i = 0; i < var_da7e1972.size; i++) {
            if (isdefined(var_da7e1972[i]) && isdefined(players[var_da7e1972[i].playernum])) {
                var_da7e1972[i] setplayernamestring(players[var_da7e1972[i].playernum]);
                continue;
            }
            if (isdefined(var_da7e1972[i])) {
                var_da7e1972[i].alpha = 0;
            }
            if (isdefined(var_6c73b74a[i])) {
                var_6c73b74a[i].alpha = 0;
            }
        }
    }
}

