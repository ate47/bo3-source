#using scripts/mp/_util;
#using scripts/mp/gametypes/_globallogic_audio;
#using scripts/shared/system_shared;
#using scripts/shared/hud_message_shared;
#using scripts/shared/util_shared;
#using scripts/shared/music_shared;
#using scripts/shared/hud_util_shared;
#using scripts/codescripts/struct;

#namespace hud_message;

// Namespace hud_message
// Params 0, eflags: 0x1 linked
// Checksum 0x4178c43b, Offset: 0x5e8
// Size: 0x2e2
function init() {
    game["strings"]["draw"] = %MP_DRAW_CAPS;
    game["strings"]["round_draw"] = %MP_ROUND_DRAW_CAPS;
    game["strings"]["round_win"] = %MP_ROUND_WIN_CAPS;
    game["strings"]["round_loss"] = %MP_ROUND_LOSS_CAPS;
    game["strings"]["victory"] = %MP_VICTORY_CAPS;
    game["strings"]["defeat"] = %MP_DEFEAT_CAPS;
    game["strings"]["top3"] = %MP_TOP3_CAPS;
    game["strings"]["game_over"] = %MP_GAME_OVER_CAPS;
    game["strings"]["halftime"] = %MP_HALFTIME_CAPS;
    game["strings"]["overtime"] = %MP_OVERTIME_CAPS;
    game["strings"]["roundend"] = %MP_ROUNDEND_CAPS;
    game["strings"]["intermission"] = %MP_INTERMISSION_CAPS;
    game["strings"]["side_switch"] = %MP_SWITCHING_SIDES_CAPS;
    game["strings"]["match_bonus"] = %MP_MATCH_BONUS_IS;
    game["strings"]["codpoints_match_bonus"] = %MP_CODPOINTS_MATCH_BONUS_IS;
    game["strings"]["wager_winnings"] = %MP_WAGER_WINNINGS_ARE;
    game["strings"]["wager_sidebet_winnings"] = %MP_WAGER_SIDEBET_WINNINGS_ARE;
    game["strings"]["wager_inthemoney"] = %MP_WAGER_IN_THE_MONEY_CAPS;
    game["strings"]["wager_loss"] = %MP_WAGER_LOSS_CAPS;
    game["strings"]["wager_topwinners"] = %MP_WAGER_TOPWINNERS;
    game["strings"]["join_in_progress_loss"] = %MP_JOIN_IN_PROGRESS_LOSS;
    game["strings"]["cod_caster_team_wins"] = %MP_WINS;
    game["strings"]["cod_caster_team_eliminated"] = %MP_TEAM_ELIMINATED;
}

// Namespace hud_message
// Params 3, eflags: 0x1 linked
// Checksum 0x13443e2b, Offset: 0x8d8
// Size: 0xb9c
function teamoutcomenotify(winner, endtype, endreasontext) {
    self endon(#"disconnect");
    self notify(#"reset_outcome");
    team = self.pers["team"];
    if (!isdefined(team) || team != "spectator" && !isdefined(level.teams[team])) {
        team = "allies";
    }
    while (self.var_decbf609) {
        wait(0.05);
    }
    self endon(#"reset_outcome");
    outcometext = "";
    notifyroundendtoui = undefined;
    overridespectator = 0;
    if (endtype == "halftime") {
        outcometext = game["strings"]["halftime"];
        notifyroundendtoui = 1;
    } else if (endtype == "intermission") {
        outcometext = game["strings"]["intermission"];
        notifyroundendtoui = 1;
    } else if (endtype == "overtime") {
        outcometext = game["strings"]["overtime"];
        notifyroundendtoui = 1;
    } else if (endtype == "roundend") {
        if (winner == "tie") {
            outcometext = game["strings"]["round_draw"];
        } else if (isdefined(self.pers["team"]) && winner == team) {
            outcometext = game["strings"]["round_win"];
            overridespectator = 1;
        } else {
            outcometext = game["strings"]["round_loss"];
            if (isdefined(level.enddefeatreasontext)) {
                endreasontext = level.enddefeatreasontext;
            }
            overridespectator = 1;
        }
        notifyroundendtoui = 1;
    } else if (endtype == "gameend") {
        if (winner == "tie") {
            outcometext = game["strings"]["draw"];
        } else if (isdefined(self.pers["team"]) && winner == team) {
            outcometext = game["strings"]["victory"];
            overridespectator = 1;
        } else {
            outcometext = game["strings"]["defeat"];
            if (isdefined(level.enddefeatreasontext)) {
                endreasontext = level.enddefeatreasontext;
            }
            if ((level.rankedmatch || level.leaguematch) && self.pers["lateJoin"] === 1) {
                endreasontext = game["strings"]["join_in_progress_loss"];
            }
            overridespectator = 1;
        }
        notifyroundendtoui = 0;
    }
    matchbonus = 0;
    if (isdefined(self.pers["totalMatchBonus"])) {
        bonus = ceil(self.pers["totalMatchBonus"] * level.xpscale);
        if (bonus > 0) {
            matchbonus = bonus;
        }
    }
    winnerenum = 0;
    if (winner == "allies") {
        winnerenum = 1;
    } else if (winner == "axis") {
        winnerenum = 2;
    }
    if (isdefined(level.var_c17c938d) && [[ level.var_c17c938d ]](winner, endtype, endreasontext, outcometext, team, winnerenum, notifyroundendtoui, matchbonus)) {
        return;
    }
    if ((level.gametype == "ctf" || level.gametype == "escort" || level.gametype == "ball") && isdefined(game["overtime_round"])) {
        if (game["overtime_round"] == 1) {
            if (isdefined(game[level.gametype + "_overtime_first_winner"])) {
                winner = game[level.gametype + "_overtime_first_winner"];
            }
            if (isdefined(winner) && winner != "tie") {
                winningtime = game[level.gametype + "_overtime_time_to_beat"];
            }
        } else {
            if (isdefined(game[level.gametype + "_overtime_first_winner"]) && game[level.gametype + "_overtime_first_winner"] == "tie") {
                winningtime = game[level.gametype + "_overtime_best_time"];
            } else {
                winningtime = undefined;
                if (winner == "tie" && isdefined(game[level.gametype + "_overtime_first_winner"])) {
                    if (game[level.gametype + "_overtime_first_winner"] == "allies") {
                        winnerenum = 1;
                    } else if (game[level.gametype + "_overtime_first_winner"] == "axis") {
                        winnerenum = 2;
                    }
                }
                if (isdefined(game[level.gametype + "_overtime_time_to_beat"])) {
                    winningtime = game[level.gametype + "_overtime_time_to_beat"];
                }
                if (!isdefined(winningtime) || isdefined(game[level.gametype + "_overtime_best_time"]) && winningtime > game[level.gametype + "_overtime_best_time"]) {
                    if (game[level.gametype + "_overtime_first_winner"] !== winner) {
                        losingtime = winningtime;
                    }
                    winningtime = game[level.gametype + "_overtime_best_time"];
                    if (winner === "tie") {
                        winningtime = 0;
                    }
                }
            }
            if (level.gametype == "escort" && winner === "tie") {
                winnerenum = 0;
                if (!(isdefined(level.finalgameend) && level.finalgameend)) {
                    if (game["defenders"] == team) {
                        outcometext = game["strings"]["round_win"];
                    } else {
                        outcometext = game["strings"]["round_loss"];
                    }
                }
            }
        }
        if (!isdefined(winningtime)) {
            winningtime = 0;
        }
        if (!isdefined(losingtime)) {
            losingtime = 0;
        }
        if (winningtime == 0 && losingtime == 0) {
            winnerenum = 0;
        }
        if (team == "spectator" && overridespectator) {
            outcometext = game["strings"]["cod_caster_team_wins"];
            notifyroundendtoui = 0;
        }
        self luinotifyevent(%show_outcome, 7, outcometext, endreasontext, int(matchbonus), winnerenum, notifyroundendtoui, int(winningtime / 1000), int(losingtime / 1000));
        return;
    }
    if (level.gametype == "ball" && isdefined(winner) && winner != "tie" && game["roundsplayed"] < level.roundlimit && isdefined(game["round_time_to_beat"]) && !isdefined(game["overtime_round"])) {
        winningtime = game["round_time_to_beat"];
        if (!isdefined(losingtime)) {
            losingtime = 0;
        }
        switch (winner) {
        case 49:
            winnerenum = 1;
            break;
        case 55:
            winnerenum = 2;
            break;
        default:
            winnerenum = 0;
            break;
        }
        if (team == "spectator" && overridespectator) {
            outcometext = game["strings"]["cod_caster_team_wins"];
            notifyroundendtoui = 0;
        }
        self luinotifyevent(%show_outcome, 7, outcometext, endreasontext, int(matchbonus), winnerenum, notifyroundendtoui, int(winningtime / 1000), int(losingtime / 1000));
        return;
    }
    if (team == "spectator" && overridespectator) {
        foreach (team in level.teams) {
            if (endreasontext == game["strings"][team + "_eliminated"]) {
                endreasontext = game["strings"]["cod_caster_team_eliminated"];
                break;
            }
        }
        outcometext = game["strings"]["cod_caster_team_wins"];
        notifyroundendtoui = 0;
    }
    self luinotifyevent(%show_outcome, 5, outcometext, endreasontext, int(matchbonus), winnerenum, notifyroundendtoui);
}

// Namespace hud_message
// Params 3, eflags: 0x0
// Checksum 0x4cdbf92c, Offset: 0x1480
// Size: 0x2bc
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
// Params 3, eflags: 0x1 linked
// Checksum 0x56f50007, Offset: 0x1748
// Size: 0x2dc
function outcomenotify(winner, var_a913a63a, endreasontext) {
    self endon(#"disconnect");
    self notify(#"reset_outcome");
    while (self.var_decbf609) {
        wait(0.05);
    }
    self endon(#"reset_outcome");
    outcometext = "";
    players = level.placement["all"];
    numclients = players.size;
    overridespectator = 0;
    if (!util::isoneround() && !var_a913a63a) {
        outcometext = game["strings"]["game_over"];
    } else if (players[0].pointstowin == 0) {
        outcometext = game["strings"]["tie"];
    } else if (self isintop(players, 1)) {
        outcometext = game["strings"]["victory"];
        overridespectator = 1;
    } else if (self isintop(players, 3)) {
        outcometext = game["strings"]["top3"];
    } else {
        outcometext = game["strings"]["defeat"];
        overridespectator = 1;
    }
    matchbonus = 0;
    if (isdefined(self.pers["totalMatchBonus"])) {
        matchbonus = self.pers["totalMatchBonus"];
    }
    wait(2);
    team = self.pers["team"];
    if (isdefined(team) && team == "spectator" && overridespectator) {
        outcometext = game["strings"]["cod_caster_team_wins"];
        self luinotifyevent(%show_outcome, 5, outcometext, endreasontext, matchbonus, winner, 0);
        return;
    }
    self luinotifyevent(%show_outcome, 4, outcometext, endreasontext, matchbonus, numclients);
}

// Namespace hud_message
// Params 2, eflags: 0x0
// Checksum 0xa21ab923, Offset: 0x1a30
// Size: 0xaac
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
    var_9cdc61fb.immunetodemogamehudsettings = 1;
    var_9cdc61fb.immunetodemofreecamera = 1;
    var_9cdc61fb setcod7decodefx(-56, duration, 600);
    outcometext = hud::createfontstring(font, 2);
    outcometext hud::setparent(var_9cdc61fb);
    outcometext hud::setpoint("TOP", "BOTTOM", 0, 0);
    outcometext.glowalpha = 1;
    outcometext.hidewheninmenu = 0;
    outcometext.archived = 0;
    outcometext.immunetodemogamehudsettings = 1;
    outcometext.immunetodemofreecamera = 1;
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
            var_8c75d30d.immunetodemogamehudsettings = 1;
            var_8c75d30d.immunetodemofreecamera = 1;
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
            var_26c5abec.immunetodemogamehudsettings = 1;
            var_26c5abec.immunetodemofreecamera = 1;
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
// Params 3, eflags: 0x0
// Checksum 0xcd0673cf, Offset: 0x24e8
// Size: 0xecc
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
    var_a59bfdf8[team].immunetodemogamehudsettings = 1;
    var_a59bfdf8[team].immunetodemofreecamera = 1;
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
        var_a59bfdf8[enemyteam].immunetodemogamehudsettings = 1;
        var_a59bfdf8[enemyteam].immunetodemofreecamera = 1;
    }
    teamscores = [];
    teamscores[team] = hud::createfontstring(font, var_7fa9f5fa);
    teamscores[team] hud::setparent(var_a59bfdf8[team]);
    teamscores[team] hud::setpoint("TOP", "BOTTOM", 0, spacing);
    teamscores[team].glowalpha = 1;
    teamscores[team] setvalue(getteamscore(team));
    teamscores[team].hidewheninmenu = 0;
    teamscores[team].archived = 0;
    teamscores[team].immunetodemogamehudsettings = 1;
    teamscores[team].immunetodemofreecamera = 1;
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
        teamscores[enemyteam].immunetodemogamehudsettings = 1;
        teamscores[enemyteam].immunetodemofreecamera = 1;
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
        matchbonus.immunetodemogamehudsettings = 1;
        matchbonus.immunetodemofreecamera = 1;
        matchbonus.label = game["strings"]["wager_winnings"];
        matchbonus setvalue(self.var_2db92ec2);
        if (isdefined(game["side_bets"]) && game["side_bets"]) {
            var_b01034b2 = hud::createfontstring(font, 2);
            var_b01034b2 hud::setparent(matchbonus);
            var_b01034b2 hud::setpoint("TOP", "BOTTOM", 0, spacing);
            var_b01034b2.glowalpha = 1;
            var_b01034b2.hidewheninmenu = 0;
            var_b01034b2.archived = 0;
            var_b01034b2.immunetodemogamehudsettings = 1;
            var_b01034b2.immunetodemofreecamera = 1;
            var_b01034b2.label = game["strings"]["wager_sidebet_winnings"];
            var_b01034b2 setvalue(self.pers["wager_sideBetWinnings"]);
        }
    }
    self thread function_7ebe2665(var_a59bfdf8, teamscores, var_9cdc61fb, outcometext, matchbonus, var_b01034b2);
}

// Namespace hud_message
// Params 10, eflags: 0x1 linked
// Checksum 0xa9ae7e12, Offset: 0x33c0
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
// Checksum 0x6ae9da15, Offset: 0x3610
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
// Params 3, eflags: 0x0
// Checksum 0xd83a1bd9, Offset: 0x3748
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
// Checksum 0xc6a5ae9f, Offset: 0x38c0
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

