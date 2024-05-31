#using scripts/zm/_util;
#using scripts/zm/gametypes/_globallogic_audio;
#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/hud_util_shared;
#using scripts/shared/hud_message_shared;
#using scripts/shared/callbacks_shared;
#using scripts/codescripts/struct;

#namespace hud_message;

// Namespace hud_message
// Params 0, eflags: 0x1 linked
// namespace_4d476a30<file_0>::function_c35e6aab
// Checksum 0x597c422b, Offset: 0x428
// Size: 0x1a2
function init() {
    game["strings"]["draw"] = %MP_DRAW_CAPS;
    game["strings"]["round_draw"] = %MP_ROUND_DRAW_CAPS;
    game["strings"]["round_win"] = %MP_ROUND_WIN_CAPS;
    game["strings"]["round_loss"] = %MP_ROUND_LOSS_CAPS;
    game["strings"]["victory"] = %MP_VICTORY_CAPS;
    game["strings"]["defeat"] = %MP_DEFEAT_CAPS;
    game["strings"]["game_over"] = %MP_GAME_OVER_CAPS;
    game["strings"]["halftime"] = %MP_HALFTIME_CAPS;
    game["strings"]["overtime"] = %MP_OVERTIME_CAPS;
    game["strings"]["roundend"] = %MP_ROUNDEND_CAPS;
    game["strings"]["intermission"] = %MP_INTERMISSION_CAPS;
    game["strings"]["side_switch"] = %MP_SWITCHING_SIDES_CAPS;
    game["strings"]["match_bonus"] = %MP_MATCH_BONUS_IS;
}

// Namespace hud_message
// Params 3, eflags: 0x1 linked
// namespace_4d476a30<file_0>::function_ceff20b5
// Checksum 0x802c7d5b, Offset: 0x5d8
// Size: 0xe74
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
        wait(0.05);
    }
    self endon(#"reset_outcome");
    var_eed1ba45 = "extrabig";
    font = "default";
    if (self issplitscreen()) {
        var_7fa9f5fa = 2;
        textsize = 1.5;
        iconsize = 30;
        spacing = 10;
    } else {
        var_7fa9f5fa = 3;
        textsize = 2;
        iconsize = 70;
        spacing = 25;
    }
    duration = 60000;
    var_9cdc61fb = hud::createfontstring(var_eed1ba45, var_7fa9f5fa);
    var_9cdc61fb hud::setpoint("TOP", undefined, 0, 30);
    var_9cdc61fb.glowalpha = 1;
    var_9cdc61fb.hidewheninmenu = 0;
    var_9cdc61fb.archived = 0;
    outcometext = hud::createfontstring(font, 2);
    outcometext hud::setparent(var_9cdc61fb);
    outcometext hud::setpoint("TOP", "BOTTOM", 0, 0);
    outcometext.glowalpha = 1;
    outcometext.hidewheninmenu = 0;
    outcometext.archived = 0;
    if (winner == "halftime") {
        var_9cdc61fb settext(game["strings"]["halftime"]);
        var_9cdc61fb.color = (1, 1, 1);
        winner = "allies";
    } else if (winner == "intermission") {
        var_9cdc61fb settext(game["strings"]["intermission"]);
        var_9cdc61fb.color = (1, 1, 1);
        winner = "allies";
    } else if (winner == "roundend") {
        var_9cdc61fb settext(game["strings"]["roundend"]);
        var_9cdc61fb.color = (1, 1, 1);
        winner = "allies";
    } else if (winner == "overtime") {
        var_9cdc61fb settext(game["strings"]["overtime"]);
        var_9cdc61fb.color = (1, 1, 1);
        winner = "allies";
    } else if (winner == "tie") {
        if (isround) {
            var_9cdc61fb settext(game["strings"]["round_draw"]);
        } else {
            var_9cdc61fb settext(game["strings"]["draw"]);
        }
        var_9cdc61fb.color = (0.29, 0.61, 0.7);
        winner = "allies";
    } else if (isdefined(self.pers["team"]) && winner == team) {
        if (isround) {
            var_9cdc61fb settext(game["strings"]["round_win"]);
        } else {
            var_9cdc61fb settext(game["strings"]["victory"]);
        }
        var_9cdc61fb.color = (0.42, 0.68, 0.46);
    } else {
        if (isround) {
            var_9cdc61fb settext(game["strings"]["round_loss"]);
        } else {
            var_9cdc61fb settext(game["strings"]["defeat"]);
        }
        var_9cdc61fb.color = (0.73, 0.29, 0.19);
    }
    outcometext settext(endreasontext);
    var_9cdc61fb setcod7decodefx(-56, duration, 600);
    outcometext setpulsefx(100, duration, 1000);
    var_7c0cdf19 = 100;
    var_2f2ca7b8 = (level.teamcount - 1) * -1 * var_7c0cdf19 / 2;
    var_a59bfdf8 = [];
    var_a59bfdf8[team] = hud::createicon(game["icons"][team], iconsize, iconsize);
    var_a59bfdf8[team] hud::setparent(outcometext);
    var_a59bfdf8[team] hud::setpoint("TOP", "BOTTOM", var_2f2ca7b8, spacing);
    var_a59bfdf8[team].hidewheninmenu = 0;
    var_a59bfdf8[team].archived = 0;
    var_a59bfdf8[team].alpha = 0;
    var_a59bfdf8[team] fadeovertime(0.5);
    var_a59bfdf8[team].alpha = 1;
    var_2f2ca7b8 += var_7c0cdf19;
    foreach (enemyteam in level.teams) {
        if (team == enemyteam) {
            continue;
        }
        var_a59bfdf8[enemyteam] = hud::createicon(game["icons"][enemyteam], iconsize, iconsize);
        var_a59bfdf8[enemyteam] hud::setparent(outcometext);
        var_a59bfdf8[enemyteam] hud::setpoint("TOP", "BOTTOM", var_2f2ca7b8, spacing);
        var_a59bfdf8[enemyteam].hidewheninmenu = 0;
        var_a59bfdf8[enemyteam].archived = 0;
        var_a59bfdf8[enemyteam].alpha = 0;
        var_a59bfdf8[enemyteam] fadeovertime(0.5);
        var_a59bfdf8[enemyteam].alpha = 1;
        var_2f2ca7b8 += var_7c0cdf19;
    }
    teamscores = [];
    teamscores[team] = hud::createfontstring(font, var_7fa9f5fa);
    teamscores[team] hud::setparent(var_a59bfdf8[team]);
    teamscores[team] hud::setpoint("TOP", "BOTTOM", 0, spacing);
    teamscores[team].glowalpha = 1;
    if (isround) {
        teamscores[team] setvalue(getteamscore(team));
    } else {
        teamscores[team] [[ level.var_d6911678 ]](team);
    }
    teamscores[team].hidewheninmenu = 0;
    teamscores[team].archived = 0;
    teamscores[team] setpulsefx(100, duration, 1000);
    foreach (enemyteam in level.teams) {
        if (team == enemyteam) {
            continue;
        }
        teamscores[enemyteam] = hud::createfontstring(var_eed1ba45, var_7fa9f5fa);
        teamscores[enemyteam] hud::setparent(var_a59bfdf8[enemyteam]);
        teamscores[enemyteam] hud::setpoint("TOP", "BOTTOM", 0, spacing);
        teamscores[enemyteam].glowalpha = 1;
        if (isround) {
            teamscores[enemyteam] setvalue(getteamscore(enemyteam));
        } else {
            teamscores[enemyteam] [[ level.var_d6911678 ]](enemyteam);
        }
        teamscores[enemyteam].hidewheninmenu = 0;
        teamscores[enemyteam].archived = 0;
        teamscores[enemyteam] setpulsefx(100, duration, 1000);
    }
    font = "objective";
    matchbonus = undefined;
    if (isdefined(self.matchbonus)) {
        matchbonus = hud::createfontstring(font, 2);
        matchbonus hud::setparent(outcometext);
        matchbonus hud::setpoint("TOP", "BOTTOM", 0, iconsize + spacing * 3 + teamscores[team].height);
        matchbonus.glowalpha = 1;
        matchbonus.hidewheninmenu = 0;
        matchbonus.archived = 0;
        matchbonus.label = game["strings"]["match_bonus"];
        matchbonus setvalue(self.matchbonus);
    }
    self thread function_7ebe2665(var_a59bfdf8, teamscores, var_9cdc61fb, outcometext);
}

// Namespace hud_message
// Params 3, eflags: 0x1 linked
// namespace_4d476a30<file_0>::function_8cab5867
// Checksum 0x14d3008f, Offset: 0x1458
// Size: 0x29c
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
        wait(0.05);
    }
    self endon(#"reset_outcome");
    if (self issplitscreen()) {
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
    var_9cdc61fb settext(endreasontext);
    var_9cdc61fb setpulsefx(100, 60000, 1000);
    self thread function_7ebe2665(undefined, undefined, var_9cdc61fb);
}

// Namespace hud_message
// Params 3, eflags: 0x1 linked
// namespace_4d476a30<file_0>::function_787e2ea4
// Checksum 0xa1d32cce, Offset: 0x1700
// Size: 0x99c
function outcomenotify(winner, var_a913a63a, endreasontext) {
    self endon(#"disconnect");
    self notify(#"reset_outcome");
    while (self.var_decbf609) {
        wait(0.05);
    }
    self endon(#"reset_outcome");
    var_eed1ba45 = "extrabig";
    font = "default";
    if (self issplitscreen()) {
        var_7fa9f5fa = 2;
        var_151b477b = 1.5;
        var_a4ea707e = 1.5;
        iconsize = 30;
        spacing = 10;
    } else {
        var_7fa9f5fa = 3;
        var_151b477b = 2;
        var_a4ea707e = 1.5;
        iconsize = 30;
        spacing = 20;
    }
    duration = 60000;
    players = level.placement["all"];
    var_9cdc61fb = hud::createfontstring(var_eed1ba45, var_7fa9f5fa);
    var_9cdc61fb hud::setpoint("TOP", undefined, 0, spacing);
    if (!util::isoneround() && !var_a913a63a) {
        var_9cdc61fb settext(game["strings"]["game_over"]);
    } else if (self == players[0] || isdefined(players[1]) && players[0].score == players[1].score && players[0].deaths == players[1].deaths && self == players[1]) {
        var_9cdc61fb settext(game["strings"]["tie"]);
    } else if (isdefined(players[2]) && players[0].score == players[2].score && players[0].deaths == players[2].deaths && self == players[2]) {
        var_9cdc61fb settext(game["strings"]["tie"]);
    } else if (isdefined(players[0]) && self == players[0]) {
        var_9cdc61fb settext(game["strings"]["victory"]);
        var_9cdc61fb.color = (0.42, 0.68, 0.46);
    } else {
        var_9cdc61fb settext(game["strings"]["defeat"]);
        var_9cdc61fb.color = (0.73, 0.29, 0.19);
    }
    var_9cdc61fb.glowalpha = 1;
    var_9cdc61fb.hidewheninmenu = 0;
    var_9cdc61fb.archived = 0;
    var_9cdc61fb setcod7decodefx(-56, duration, 600);
    outcometext = hud::createfontstring(font, 2);
    outcometext hud::setparent(var_9cdc61fb);
    outcometext hud::setpoint("TOP", "BOTTOM", 0, 0);
    outcometext.glowalpha = 1;
    outcometext.hidewheninmenu = 0;
    outcometext.archived = 0;
    outcometext settext(endreasontext);
    var_66184a91 = hud::createfontstring(font, var_151b477b);
    var_66184a91 hud::setparent(outcometext);
    var_66184a91 hud::setpoint("TOP", "BOTTOM", 0, spacing);
    var_66184a91.glowalpha = 1;
    var_66184a91.hidewheninmenu = 0;
    var_66184a91.archived = 0;
    if (isdefined(players[0])) {
        var_66184a91.label = %MP_FIRSTPLACE_NAME;
        var_66184a91 setplayernamestring(players[0]);
        var_66184a91 setcod7decodefx(-81, duration, 600);
    }
    var_8c75d30d = hud::createfontstring(font, var_a4ea707e);
    var_8c75d30d hud::setparent(var_66184a91);
    var_8c75d30d hud::setpoint("TOP", "BOTTOM", 0, spacing);
    var_8c75d30d.glowalpha = 1;
    var_8c75d30d.hidewheninmenu = 0;
    var_8c75d30d.archived = 0;
    if (isdefined(players[1])) {
        var_8c75d30d.label = %MP_SECONDPLACE_NAME;
        var_8c75d30d setplayernamestring(players[1]);
        var_8c75d30d setcod7decodefx(-81, duration, 600);
    }
    var_4a691eaa = hud::createfontstring(font, var_a4ea707e);
    var_4a691eaa hud::setparent(var_8c75d30d);
    var_4a691eaa hud::setpoint("TOP", "BOTTOM", 0, spacing);
    var_4a691eaa hud::setparent(var_8c75d30d);
    var_4a691eaa.glowalpha = 1;
    var_4a691eaa.hidewheninmenu = 0;
    var_4a691eaa.archived = 0;
    if (isdefined(players[2])) {
        var_4a691eaa.label = %MP_THIRDPLACE_NAME;
        var_4a691eaa setplayernamestring(players[2]);
        var_4a691eaa setcod7decodefx(-81, duration, 600);
    }
    matchbonus = hud::createfontstring(font, 2);
    matchbonus hud::setparent(var_4a691eaa);
    matchbonus hud::setpoint("TOP", "BOTTOM", 0, spacing);
    matchbonus.glowalpha = 1;
    matchbonus.hidewheninmenu = 0;
    matchbonus.archived = 0;
    if (isdefined(self.matchbonus)) {
        matchbonus.label = game["strings"]["match_bonus"];
        matchbonus setvalue(self.matchbonus);
    }
    self thread function_da2b338e(var_66184a91, var_8c75d30d, var_4a691eaa);
    self thread function_7ebe2665(undefined, undefined, var_9cdc61fb, outcometext, var_66184a91, var_8c75d30d, var_4a691eaa, matchbonus);
}

// Namespace hud_message
// Params 2, eflags: 0x1 linked
// namespace_4d476a30<file_0>::function_d5235f38
// Checksum 0xf9458b9f, Offset: 0x20a8
// Size: 0xa0c
function function_d5235f38(winner, endreasontext) {
    self endon(#"disconnect");
    self notify(#"reset_outcome");
    while (self.var_decbf609) {
        wait(0.05);
    }
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
    if (isdefined(level.var_77929119) && level.var_77929119) {
        halftime = 1;
    }
    duration = 60000;
    players = level.placement["all"];
    var_9cdc61fb = hud::createfontstring(var_eed1ba45, var_7fa9f5fa);
    var_9cdc61fb hud::setpoint("TOP", undefined, 0, spacing);
    if (halftime) {
        var_9cdc61fb settext(game["strings"]["intermission"]);
        var_9cdc61fb.color = (1, 1, 0);
        var_9cdc61fb.glowcolor = (1, 0, 0);
    } else if (isdefined(level.var_7fb97d34) && level.var_7fb97d34 == 1) {
        var_9cdc61fb settext(game["strings"]["wager_topwinners"]);
        var_9cdc61fb.color = (0.42, 0.68, 0.46);
    } else if (isdefined(self.var_2db92ec2) && self.var_2db92ec2 > 0) {
        var_9cdc61fb settext(game["strings"]["wager_inthemoney"]);
        var_9cdc61fb.color = (0.42, 0.68, 0.46);
    } else {
        var_9cdc61fb settext(game["strings"]["wager_loss"]);
        var_9cdc61fb.color = (0.73, 0.29, 0.19);
    }
    var_9cdc61fb.glowalpha = 1;
    var_9cdc61fb.hidewheninmenu = 0;
    var_9cdc61fb.archived = 0;
    var_9cdc61fb setcod7decodefx(-56, duration, 600);
    outcometext = hud::createfontstring(font, 2);
    outcometext hud::setparent(var_9cdc61fb);
    outcometext hud::setpoint("TOP", "BOTTOM", 0, 0);
    outcometext.glowalpha = 1;
    outcometext.hidewheninmenu = 0;
    outcometext.archived = 0;
    outcometext settext(endreasontext);
    var_da7e1972 = [];
    var_6c73b74a = [];
    numplayers = players.size;
    for (i = 0; i < numplayers; i++) {
        if (!halftime && isdefined(players[i])) {
            var_8c75d30d = hud::createfontstring(font, var_a4ea707e);
            if (var_da7e1972.size == 0) {
                var_8c75d30d hud::setparent(outcometext);
                var_8c75d30d hud::setpoint("TOP_LEFT", "BOTTOM", -175, spacing * 3);
            } else {
                var_8c75d30d hud::setparent(var_da7e1972[var_da7e1972.size - 1]);
                var_8c75d30d hud::setpoint("TOP_LEFT", "BOTTOM_LEFT", 0, spacing);
            }
            var_8c75d30d.glowalpha = 1;
            var_8c75d30d.hidewheninmenu = 0;
            var_8c75d30d.archived = 0;
            var_8c75d30d.label = %MP_WAGER_PLACE_NAME;
            var_8c75d30d.playernum = i;
            var_8c75d30d setplayernamestring(players[i]);
            var_da7e1972[var_da7e1972.size] = var_8c75d30d;
            var_26c5abec = hud::createfontstring(font, var_a4ea707e);
            var_26c5abec hud::setparent(var_8c75d30d);
            var_26c5abec hud::setpoint("TOP_RIGHT", "TOP_LEFT", 350, 0);
            var_26c5abec.glowalpha = 1;
            var_26c5abec.hidewheninmenu = 0;
            var_26c5abec.archived = 0;
            var_26c5abec.label = %MENU_POINTS;
            var_26c5abec.currentvalue = 0;
            if (isdefined(players[i].var_2db92ec2)) {
                var_26c5abec.targetvalue = players[i].var_2db92ec2;
            } else {
                var_26c5abec.targetvalue = 0;
            }
            if (var_26c5abec.targetvalue > 0) {
                var_26c5abec.color = (0.42, 0.68, 0.46);
            }
            var_26c5abec setvalue(0);
            var_6c73b74a[var_6c73b74a.size] = var_26c5abec;
        }
    }
    self thread function_cd821d4(var_da7e1972, var_6c73b74a);
    self thread function_c7dff00f(var_da7e1972, var_6c73b74a, var_9cdc61fb, outcometext);
    if (halftime) {
        return;
    }
    var_f3940c57 = 1;
    var_f4125afd = 2;
    var_be189fd3 = 9999;
    if (isdefined(var_6c73b74a[0])) {
        var_be189fd3 = int(var_6c73b74a[0].targetvalue / var_f4125afd / 0.05);
        if (var_be189fd3 < 1) {
            var_be189fd3 = 1;
        }
    }
    while (var_f3940c57) {
        var_f3940c57 = 0;
        for (i = 0; i < var_6c73b74a.size; i++) {
            if (isdefined(var_6c73b74a[i]) && var_6c73b74a[i].currentvalue < var_6c73b74a[i].targetvalue) {
                var_6c73b74a[i].currentvalue = var_6c73b74a[i].currentvalue + var_be189fd3;
                if (var_6c73b74a[i].currentvalue > var_6c73b74a[i].targetvalue) {
                    var_6c73b74a[i].currentvalue = var_6c73b74a[i].targetvalue;
                }
                var_6c73b74a[i] setvalue(var_6c73b74a[i].currentvalue);
                var_f3940c57 = 1;
            }
        }
        wait(0.05);
    }
}

// Namespace hud_message
// Params 3, eflags: 0x1 linked
// namespace_4d476a30<file_0>::function_de9a72bf
// Checksum 0x48c57bc3, Offset: 0x2ac0
// Size: 0xd6c
function function_de9a72bf(winner, var_a913a63a, endreasontext) {
    self endon(#"disconnect");
    self notify(#"reset_outcome");
    team = self.pers["team"];
    if (!isdefined(team) || !isdefined(level.teams[team])) {
        team = "allies";
    }
    wait(0.05);
    while (self.var_decbf609) {
        wait(0.05);
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
    if (isdefined(level.var_77929119) && level.var_77929119) {
        halftime = 1;
    }
    duration = 60000;
    var_9cdc61fb = hud::createfontstring(var_eed1ba45, var_7fa9f5fa);
    var_9cdc61fb hud::setpoint("TOP", undefined, 0, spacing);
    var_9cdc61fb.glowalpha = 1;
    var_9cdc61fb.hidewheninmenu = 0;
    var_9cdc61fb.archived = 0;
    outcometext = hud::createfontstring(font, 2);
    outcometext hud::setparent(var_9cdc61fb);
    outcometext hud::setpoint("TOP", "BOTTOM", 0, 0);
    outcometext.glowalpha = 1;
    outcometext.hidewheninmenu = 0;
    outcometext.archived = 0;
    if (winner == "tie") {
        if (var_a913a63a) {
            var_9cdc61fb settext(game["strings"]["round_draw"]);
        } else {
            var_9cdc61fb settext(game["strings"]["draw"]);
        }
        var_9cdc61fb.color = (1, 1, 1);
        winner = "allies";
    } else if (winner == "overtime") {
        var_9cdc61fb settext(game["strings"]["overtime"]);
        var_9cdc61fb.color = (1, 1, 1);
    } else if (isdefined(self.pers["team"]) && winner == team) {
        if (var_a913a63a) {
            var_9cdc61fb settext(game["strings"]["round_win"]);
        } else {
            var_9cdc61fb settext(game["strings"]["victory"]);
        }
        var_9cdc61fb.color = (0.42, 0.68, 0.46);
    } else {
        if (var_a913a63a) {
            var_9cdc61fb settext(game["strings"]["round_loss"]);
        } else {
            var_9cdc61fb settext(game["strings"]["defeat"]);
        }
        var_9cdc61fb.color = (0.73, 0.29, 0.19);
    }
    if (!isdefined(level.dontshowendreason) || !level.dontshowendreason) {
        outcometext settext(endreasontext);
    }
    var_9cdc61fb setpulsefx(100, duration, 1000);
    outcometext setpulsefx(100, duration, 1000);
    var_a59bfdf8 = [];
    var_a59bfdf8[team] = hud::createicon(game["icons"][team], iconsize, iconsize);
    var_a59bfdf8[team] hud::setparent(outcometext);
    var_a59bfdf8[team] hud::setpoint("TOP", "BOTTOM", -60, spacing);
    var_a59bfdf8[team].hidewheninmenu = 0;
    var_a59bfdf8[team].archived = 0;
    var_a59bfdf8[team].alpha = 0;
    var_a59bfdf8[team] fadeovertime(0.5);
    var_a59bfdf8[team].alpha = 1;
    foreach (enemyteam in level.teams) {
        if (team == enemyteam) {
            continue;
        }
        var_a59bfdf8[enemyteam] = hud::createicon(game["icons"][enemyteam], iconsize, iconsize);
        var_a59bfdf8[enemyteam] hud::setparent(outcometext);
        var_a59bfdf8[enemyteam] hud::setpoint("TOP", "BOTTOM", 60, spacing);
        var_a59bfdf8[enemyteam].hidewheninmenu = 0;
        var_a59bfdf8[enemyteam].archived = 0;
        var_a59bfdf8[enemyteam].alpha = 0;
        var_a59bfdf8[enemyteam] fadeovertime(0.5);
        var_a59bfdf8[enemyteam].alpha = 1;
    }
    teamscores = [];
    teamscores[team] = hud::createfontstring(font, var_7fa9f5fa);
    teamscores[team] hud::setparent(var_a59bfdf8[team]);
    teamscores[team] hud::setpoint("TOP", "BOTTOM", 0, spacing);
    teamscores[team].glowalpha = 1;
    teamscores[team] setvalue(getteamscore(team));
    teamscores[team].hidewheninmenu = 0;
    teamscores[team].archived = 0;
    teamscores[team] setpulsefx(100, duration, 1000);
    foreach (enemyteam in level.teams) {
        if (team == enemyteam) {
            continue;
        }
        teamscores[enemyteam] = hud::createfontstring(font, var_7fa9f5fa);
        teamscores[enemyteam] hud::setparent(var_a59bfdf8[enemyteam]);
        teamscores[enemyteam] hud::setpoint("TOP", "BOTTOM", 0, spacing);
        teamscores[enemyteam].glowalpha = 1;
        teamscores[enemyteam] setvalue(getteamscore(enemyteam));
        teamscores[enemyteam].hidewheninmenu = 0;
        teamscores[enemyteam].archived = 0;
        teamscores[enemyteam] setpulsefx(100, duration, 1000);
    }
    matchbonus = undefined;
    var_b01034b2 = undefined;
    if (!var_a913a63a && !halftime && isdefined(self.var_2db92ec2)) {
        matchbonus = hud::createfontstring(font, 2);
        matchbonus hud::setparent(outcometext);
        matchbonus hud::setpoint("TOP", "BOTTOM", 0, iconsize + spacing * 3 + teamscores[team].height);
        matchbonus.glowalpha = 1;
        matchbonus.hidewheninmenu = 0;
        matchbonus.archived = 0;
        matchbonus.label = game["strings"]["wager_winnings"];
        matchbonus setvalue(self.var_2db92ec2);
        if (isdefined(game["side_bets"]) && game["side_bets"]) {
            var_b01034b2 = hud::createfontstring(font, 2);
            var_b01034b2 hud::setparent(matchbonus);
            var_b01034b2 hud::setpoint("TOP", "BOTTOM", 0, spacing);
            var_b01034b2.glowalpha = 1;
            var_b01034b2.hidewheninmenu = 0;
            var_b01034b2.archived = 0;
            var_b01034b2.label = game["strings"]["wager_sidebet_winnings"];
            var_b01034b2 setvalue(self.pers["wager_sideBetWinnings"]);
        }
    }
    self thread function_7ebe2665(var_a59bfdf8, teamscores, var_9cdc61fb, outcometext, matchbonus, var_b01034b2);
}

// Namespace hud_message
// Params 10, eflags: 0x1 linked
// namespace_4d476a30<file_0>::function_7ebe2665
// Checksum 0x6304b2c9, Offset: 0x3838
// Size: 0x242
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
// Params 4, eflags: 0x1 linked
// namespace_4d476a30<file_0>::function_c7dff00f
// Checksum 0xb7d5c738, Offset: 0x3a88
// Size: 0x12c
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
// Params 3, eflags: 0x1 linked
// namespace_4d476a30<file_0>::function_da2b338e
// Checksum 0xfca790c3, Offset: 0x3bc0
// Size: 0x170
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
// Params 2, eflags: 0x1 linked
// namespace_4d476a30<file_0>::function_cd821d4
// Checksum 0xe596f585, Offset: 0x3d38
// Size: 0x146
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

