#using scripts/mp/_armor;
#using scripts/mp/_challenges;
#using scripts/mp/_util;
#using scripts/mp/gametypes/_globallogic;
#using scripts/mp/gametypes/_globallogic_audio;
#using scripts/mp/gametypes/_globallogic_defaults;
#using scripts/mp/gametypes/_globallogic_player;
#using scripts/mp/gametypes/_globallogic_score;
#using scripts/mp/gametypes/_globallogic_ui;
#using scripts/mp/gametypes/_globallogic_utils;
#using scripts/mp/gametypes/_hud_message;
#using scripts/mp/gametypes/_spawning;
#using scripts/mp/gametypes/_spawnlogic;
#using scripts/mp/teams/_teams;
#using scripts/shared/_oob;
#using scripts/shared/abilities/_ability_player;
#using scripts/shared/array_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/challenges_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/demo_shared;
#using scripts/shared/gameobjects_shared;
#using scripts/shared/hud_message_shared;
#using scripts/shared/hud_util_shared;
#using scripts/shared/killstreaks_shared;
#using scripts/shared/math_shared;
#using scripts/shared/popups_shared;
#using scripts/shared/rank_shared;
#using scripts/shared/scoreevents_shared;
#using scripts/shared/sound_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;

#namespace ball;

// Namespace ball
// Params 0, eflags: 0x2
// Checksum 0x59390af2, Offset: 0xdf0
// Size: 0x34
function autoexec __init__sytem__() {
    system::register("ball", &__init__, undefined, undefined);
}

// Namespace ball
// Params 0, eflags: 0x0
// Checksum 0x313e53d9, Offset: 0xe30
// Size: 0xf4
function __init__() {
    clientfield::register("allplayers", "ballcarrier", 1, 1, "int");
    clientfield::register("allplayers", "passoption", 1, 1, "int");
    clientfield::register("world", "ball_away", 1, 1, "int");
    clientfield::register("world", "ball_score_allies", 1, 1, "int");
    clientfield::register("world", "ball_score_axis", 1, 1, "int");
}

// Namespace ball
// Params 0, eflags: 0x0
// Checksum 0xb5bb28f0, Offset: 0xf30
// Size: 0x51c
function main() {
    globallogic::init();
    util::registertimelimit(0, 1440);
    util::registerroundlimit(0, 10);
    util::registerroundwinlimit(0, 10);
    util::registerroundswitch(0, 9);
    util::registernumlives(0, 100);
    util::registerroundscorelimit(0, 5000);
    util::registerscorelimit(0, 5000);
    level.scoreroundwinbased = getgametypesetting("cumulativeRoundScores") == 0;
    level.teamkillpenaltymultiplier = getgametypesetting("teamKillPenalty");
    level.teamkillscoremultiplier = getgametypesetting("teamKillScore");
    level.var_aa5bcaa3 = getgametypesetting("objectivePingTime");
    if (level.roundscorelimit) {
        level.carryscore = math::clamp(getgametypesetting("carryScore"), 0, level.roundscorelimit);
        level.throwscore = math::clamp(getgametypesetting("throwScore"), 0, level.roundscorelimit);
    } else {
        level.carryscore = getgametypesetting("carryScore");
        level.throwscore = getgametypesetting("throwScore");
    }
    level.var_ef3abf3b = getgametypesetting("carrierArmor");
    level.ballcount = getgametypesetting("ballCount");
    level.enemycarriervisible = getgametypesetting("enemyCarrierVisible");
    level.idleflagreturntime = getgametypesetting("idleFlagResetTime");
    globallogic::registerfriendlyfiredelay(level.gametype, 15, 0, 1440);
    level.teambased = 1;
    level.overrideteamscore = 1;
    level.clampscorelimit = 0;
    level.doubleovertime = 1;
    level.onprecachegametype = &onprecachegametype;
    level.onstartgametype = &onstartgametype;
    level.onspawnplayer = &onspawnplayer;
    level.onplayerkilled = &onplayerkilled;
    level.onroundswitch = &onroundswitch;
    level.onroundscorelimit = &onroundscorelimit;
    level.onendgame = &onendgame;
    level.onroundendgame = &onroundendgame;
    level.getteamkillpenalty = &function_54dd76af;
    level.getteamkillscore = &function_eb6c9496;
    level.var_d6911678 = &function_d6911678;
    level.shouldplayovertimeround = &shouldplayovertimeround;
    level.ontimelimit = &function_25dd17ea;
    gameobjects::register_allowed_gameobject(level.gametype);
    globallogic_audio::set_leader_gametype_dialog("startUplink", "hcStartUplink", "uplOrders", "uplOrders");
    if (!sessionmodeissystemlink() && !sessionmodeisonlinegame() && issplitscreen()) {
        globallogic::setvisiblescoreboardcolumns("score", "kills", "carries", "throws", "deaths");
        return;
    }
    globallogic::setvisiblescoreboardcolumns("score", "kills", "deaths", "carries", "throws");
}

// Namespace ball
// Params 0, eflags: 0x0
// Checksum 0x4f9896f7, Offset: 0x1458
// Size: 0x22
function onprecachegametype() {
    game["strings"]["score_limit_reached"] = %MP_CAP_LIMIT_REACHED;
}

// Namespace ball
// Params 0, eflags: 0x0
// Checksum 0xeab60ef9, Offset: 0x1488
// Size: 0x76c
function onstartgametype() {
    level.usestartspawns = 1;
    level.var_d566bdba = getweapon("ball_world");
    level.var_aff3334d = getweapon("ball_world_pass");
    if (!isdefined(game["switchedsides"])) {
        game["switchedsides"] = 0;
    }
    setclientnamemode("auto_change");
    if (level.scoreroundwinbased) {
        globallogic_score::resetteamscores();
    }
    util::setobjectivetext("allies", %OBJECTIVES_BALL);
    util::setobjectivetext("axis", %OBJECTIVES_BALL);
    if (level.splitscreen) {
        util::setobjectivescoretext("allies", %OBJECTIVES_BALL);
        util::setobjectivescoretext("axis", %OBJECTIVES_BALL);
    } else {
        util::setobjectivescoretext("allies", %OBJECTIVES_BALL_SCORE);
        util::setobjectivescoretext("axis", %OBJECTIVES_BALL_SCORE);
    }
    util::setobjectivehinttext("allies", %OBJECTIVES_BALL_HINT);
    util::setobjectivehinttext("axis", %OBJECTIVES_BALL_HINT);
    if (isdefined(game["overtime_round"])) {
        if (!isdefined(game["ball_game_score"])) {
            game["ball_game_score"] = [];
            game["ball_game_score"]["allies"] = [[ level._getteamscore ]]("allies");
            game["ball_game_score"]["axis"] = [[ level._getteamscore ]]("axis");
        }
        [[ level._setteamscore ]]("allies", 0);
        [[ level._setteamscore ]]("axis", 0);
        if (isdefined(game["ball_overtime_score_to_beat"])) {
            util::registerscorelimit(game["ball_overtime_score_to_beat"], game["ball_overtime_score_to_beat"]);
        } else {
            util::registerscorelimit(1, 1);
        }
        if (isdefined(game["ball_overtime_time_to_beat"])) {
            util::registertimelimit(game["ball_overtime_time_to_beat"] / 60000, game["ball_overtime_time_to_beat"] / 60000);
        } else {
            util::registertimelimit(0, 1440);
        }
        if (game["overtime_round"] == 1) {
            util::setobjectivehinttext("allies", %MP_BALL_OVERTIME_ROUND_1);
            util::setobjectivehinttext("axis", %MP_BALL_OVERTIME_ROUND_1);
        } else if (isdefined(game["ball_overtime_first_winner"])) {
            level.ontimelimit = &function_972a6af9;
            game["teamSuddenDeath"][game["ball_overtime_first_winner"]] = 1;
            util::setobjectivehinttext(game["ball_overtime_first_winner"], %MP_BALL_OVERTIME_ROUND_2_WINNER);
            util::setobjectivehinttext(util::getotherteam(game["ball_overtime_first_winner"]), %MP_BALL_OVERTIME_ROUND_2_LOSER);
        } else {
            level.ontimelimit = &function_972a6af9;
            util::setobjectivehinttext("allies", %MP_BALL_OVERTIME_ROUND_2_TIE);
            util::setobjectivehinttext("axis", %MP_BALL_OVERTIME_ROUND_2_TIE);
        }
    } else if (isdefined(game["round_time_to_beat"])) {
        util::registertimelimit(game["round_time_to_beat"] / 60000, game["round_time_to_beat"] / 60000);
    }
    spawning::create_map_placed_influencers();
    level.spawnmins = (0, 0, 0);
    level.spawnmaxs = (0, 0, 0);
    spawnlogic::place_spawn_points("mp_ctf_spawn_allies_start");
    spawnlogic::place_spawn_points("mp_ctf_spawn_axis_start");
    spawnlogic::add_spawn_points("allies", "mp_ctf_spawn_allies");
    spawnlogic::add_spawn_points("axis", "mp_ctf_spawn_axis");
    spawning::add_fallback_spawnpoints("allies", "mp_tdm_spawn");
    spawning::add_fallback_spawnpoints("axis", "mp_tdm_spawn");
    spawning::updateallspawnpoints();
    spawning::update_fallback_spawnpoints();
    level.mapcenter = math::find_box_center(level.spawnmins, level.spawnmaxs);
    setmapcenter(level.mapcenter);
    spawnpoint = spawnlogic::get_random_intermission_point();
    setdemointermissionpoint(spawnpoint.origin, spawnpoint.angles);
    level.spawn_axis = spawnlogic::get_spawnpoint_array("mp_ctf_spawn_axis");
    level.spawn_allies = spawnlogic::get_spawnpoint_array("mp_ctf_spawn_allies");
    level.spawn_start = [];
    foreach (team in level.teams) {
        level.spawn_start[team] = spawnlogic::get_spawnpoint_array("mp_ctf_spawn_" + team + "_start");
    }
    level thread setup_objectives();
}

// Namespace ball
// Params 0, eflags: 0x0
// Checksum 0xe9bb7b1a, Offset: 0x1c00
// Size: 0xc2
function function_481ef46f() {
    foreach (ball in level.balls) {
        if (isdefined(ball.carrier)) {
            continue;
        }
        if (isdefined(ball.projectile)) {
            if (!ball.projectile isonground()) {
                return ball;
            }
        }
    }
}

// Namespace ball
// Params 0, eflags: 0x0
// Checksum 0x453fcb10, Offset: 0x1cd0
// Size: 0x8a
function function_4dbb4a6a() {
    self endon(#"reset");
    self endon(#"pickup_object");
    if (isdefined(self.projectile)) {
        if (self.projectile isonground()) {
            return;
        }
        self.projectile endon(#"death");
        self.projectile endon(#"stationary");
        self.projectile endon(#"grenade_bounce");
        while (true) {
            wait 1;
        }
    }
}

// Namespace ball
// Params 0, eflags: 0x0
// Checksum 0xf1ba8231, Offset: 0x1d68
// Size: 0x9c
function function_6dd12da4() {
    self endon(#"disconnect");
    self globallogic_player::freezeplayerforroundend();
    self thread globallogic::roundenddof(4);
    self waittill(#"spawned");
    if (self.sessionstate == "playing") {
        self globallogic_player::freezeplayerforroundend();
        self thread globallogic::roundenddof(4);
    }
}

// Namespace ball
// Params 0, eflags: 0x0
// Checksum 0xfb2e7ca2, Offset: 0x1e10
// Size: 0x5c
function function_83143ec0() {
    ball = function_481ef46f();
    if (isdefined(ball)) {
        level.ontimelimit = &function_e1d7d235;
        ball function_4dbb4a6a();
    }
}

// Namespace ball
// Params 0, eflags: 0x0
// Checksum 0x3aea020b, Offset: 0x1e78
// Size: 0x24
function function_25dd17ea() {
    function_83143ec0();
    globallogic_defaults::default_ontimelimit();
}

// Namespace ball
// Params 0, eflags: 0x0
// Checksum 0x99ec1590, Offset: 0x1ea8
// Size: 0x4
function function_e1d7d235() {
    
}

// Namespace ball
// Params 0, eflags: 0x0
// Checksum 0xf60ca9e7, Offset: 0x1eb8
// Size: 0x1d4
function function_972a6af9() {
    function_83143ec0();
    winner = undefined;
    if (level.teambased) {
        foreach (team in level.teams) {
            if (game["teamSuddenDeath"][team]) {
                winner = team;
                break;
            }
        }
        if (!isdefined(winner)) {
            winner = globallogic::determineteamwinnerbygamestat("teamScores");
        }
        globallogic_utils::logteamwinstring("time limit", winner);
    } else {
        winner = globallogic_score::gethighestscoringplayer();
        /#
            if (isdefined(winner)) {
                print("<dev string:x28>" + winner.name);
            } else {
                print("<dev string:x3a>");
            }
        #/
    }
    setdvar("ui_text_endreason", game["strings"]["time_limit_reached"]);
    thread globallogic::endgame(winner, game["strings"]["time_limit_reached"]);
}

// Namespace ball
// Params 1, eflags: 0x0
// Checksum 0xafacd58d, Offset: 0x2098
// Size: 0x74
function onspawnplayer(predictedspawn) {
    self.var_1821be2 = 0;
    self.var_bbc60d50 = undefined;
    self clientfield::set("ctf_flag_carrier", 0);
    self thread function_67cb1206();
    spawning::onspawnplayer(predictedspawn);
}

// Namespace ball
// Params 0, eflags: 0x0
// Checksum 0x42eee9ad, Offset: 0x2118
// Size: 0x1a8
function function_67cb1206() {
    self endon(#"death");
    self endon(#"delete");
    player = self;
    ball = getweapon("ball");
    while (true) {
        if (isdefined(ball) && player hasweapon(ball)) {
            curweapon = player getcurrentweapon();
            if (isdefined(curweapon) && curweapon != ball && !player isswitchingweapons()) {
                if (curweapon.isheroweapon) {
                    slot = self gadgetgetslot(curweapon);
                    if (!self ability_player::gadget_is_in_use(slot)) {
                        wait 0.05;
                        continue;
                    }
                }
                println("<dev string:x4a>");
                player switchtoweapon(ball);
                player disableweaponcycling();
                player disableoffhandweapons();
            }
        }
        wait 0.05;
    }
}

// Namespace ball
// Params 9, eflags: 0x0
// Checksum 0xc619453, Offset: 0x22c8
// Size: 0x5f2
function onplayerkilled(einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime, deathanimduration) {
    if (isdefined(self.carryobject)) {
        otherteam = util::getotherteam(self.team);
        self recordgameevent("return");
        if (isdefined(attacker) && isplayer(attacker) && attacker != self) {
            attacker recordgameevent("kill_carrier");
            if (attacker.team != self.team) {
                scoreevents::processscoreevent("kill_ball_carrier", attacker, undefined, weapon);
                attacker addplayerstat("kill_carrier", 1);
            }
            globallogic_audio::leader_dialog("uplWeDrop", self.team, undefined, "uplink_ball");
            globallogic_audio::leader_dialog("uplTheyDrop", otherteam, undefined, "uplink_ball");
            globallogic_audio::play_2d_on_team("mpl_balldrop_sting_friend", self.team);
            globallogic_audio::play_2d_on_team("mpl_balldrop_sting_enemy", otherteam);
            level thread popups::displayteammessagetoteam(%MP_BALL_DROPPED, self, self.team);
            level thread popups::displayteammessagetoteam(%MP_BALL_DROPPED, self, otherteam);
        }
    } else if (isdefined(attacker.carryobject) && attacker.team != self.team) {
        scoreevents::processscoreevent("kill_enemy_while_carrying_ball", attacker, undefined, weapon);
    }
    foreach (ball in level.balls) {
        ballcarrier = ball.carrier;
        if (isdefined(ballcarrier)) {
            var_bf7df05c = ball.carrier.origin;
            iscarried = 1;
        } else {
            var_bf7df05c = ball.curorigin;
            iscarried = 0;
        }
        if (iscarried && isdefined(attacker) && isdefined(attacker.team) && attacker != self && ballcarrier != attacker) {
            if (attacker.team == ball.carrier.team) {
                dist = distance2dsquared(self.origin, var_bf7df05c);
                if (dist < level.defaultoffenseradiussq) {
                    attacker addplayerstat("defend_carrier", 1);
                    break;
                }
            }
        }
    }
    victim = self;
    foreach (var_3c3dd1e8 in level.ball_goals) {
        if (isdefined(attacker) && isdefined(attacker.team) && attacker != victim && isdefined(victim.team) && isplayer(attacker)) {
            var_3d921577 = distance2dsquared(attacker.origin, var_3c3dd1e8.origin);
            var_8d501176 = distance2dsquared(victim.origin, var_3c3dd1e8.origin);
            if (var_3d921577 < level.defaultoffenseradiussq || var_8d501176 < level.defaultoffenseradiussq) {
                if (victim.team == var_3c3dd1e8.team) {
                    attacker thread challenges::killedbasedefender(var_3c3dd1e8.trigger);
                    continue;
                }
                attacker thread challenges::killedbaseoffender(var_3c3dd1e8.trigger, weapon);
            }
        }
    }
}

// Namespace ball
// Params 0, eflags: 0x0
// Checksum 0x4a11970d, Offset: 0x28c8
// Size: 0x4c
function onroundswitch() {
    if (!isdefined(game["switchedsides"])) {
        game["switchedsides"] = 0;
    }
    level.halftimetype = "halftime";
    game["switchedsides"] = !game["switchedsides"];
}

// Namespace ball
// Params 0, eflags: 0x0
// Checksum 0x1e0affc1, Offset: 0x2920
// Size: 0x9a
function onroundscorelimit() {
    if (!isdefined(game["overtime_round"])) {
        timelimit = getgametypesetting("timeLimit") * 60000;
        var_88effb35 = globallogic_utils::gettimepassed();
        if (timelimit > 0 && var_88effb35 < timelimit) {
            game["round_time_to_beat"] = var_88effb35;
        }
    }
    return globallogic_defaults::default_onroundscorelimit();
}

// Namespace ball
// Params 1, eflags: 0x0
// Checksum 0x39dec839, Offset: 0x29c8
// Size: 0xf8
function onendgame(winningteam) {
    if (!isdefined(winningteam) || winningteam == "tie") {
        return;
    }
    if (isdefined(game["overtime_round"])) {
        if (game["overtime_round"] == 1) {
            game["ball_overtime_first_winner"] = winningteam;
            game["ball_overtime_score_to_beat"] = getteamscore(winningteam);
            game["ball_overtime_time_to_beat"] = globallogic_utils::gettimepassed();
            return;
        }
        game["ball_overtime_second_winner"] = winningteam;
        game["ball_overtime_best_score"] = getteamscore(winningteam);
        game["ball_overtime_best_time"] = globallogic_utils::gettimepassed();
    }
}

// Namespace ball
// Params 0, eflags: 0x0
// Checksum 0xc68a2abd, Offset: 0x2ac8
// Size: 0xa2
function updateteamscorebyroundswon() {
    if (level.scoreroundwinbased) {
        foreach (team in level.teams) {
            [[ level._setteamscore ]](team, game["roundswon"][team]);
        }
    }
}

// Namespace ball
// Params 1, eflags: 0x0
// Checksum 0x27b6687b, Offset: 0x2b78
// Size: 0x33c
function onroundendgame(winningteam) {
    if (isdefined(game["overtime_round"])) {
        if (isdefined(game["ball_overtime_first_winner"])) {
            var_aed1a51e = 0;
            if (!isdefined(winningteam) || winningteam == "tie") {
                winningteam = game["ball_overtime_first_winner"];
            }
            if (game["ball_overtime_first_winner"] == winningteam) {
                level.endvictoryreasontext = %MPUI_BALL_OVERTIME_FASTEST_CAP_TIME;
                level.enddefeatreasontext = %MPUI_BALL_OVERTIME_DEFEAT_TIMELIMIT;
            } else {
                level.endvictoryreasontext = %MPUI_BALL_OVERTIME_FASTEST_CAP_TIME;
                level.enddefeatreasontext = %MPUI_BALL_OVERTIME_DEFEAT_DID_NOT_DEFEND;
            }
        } else if (!isdefined(winningteam) || winningteam == "tie") {
            updateteamscorebyroundswon();
            return "tie";
        }
        if (level.scoreroundwinbased) {
            foreach (team in level.teams) {
                score = game["roundswon"][team];
                if (team === winningteam) {
                    score++;
                }
                [[ level._setteamscore ]](team, score);
            }
        } else {
            if (isdefined(game["ball_overtime_score_to_beat"]) && game["ball_overtime_score_to_beat"] > game["ball_overtime_best_score"]) {
                var_9dfe2c62 = game["ball_overtime_score_to_beat"];
            } else {
                var_9dfe2c62 = game["ball_overtime_best_score"];
            }
            foreach (team in level.teams) {
                score = game["ball_game_score"][team];
                if (team === winningteam) {
                    score += var_9dfe2c62;
                }
                [[ level._setteamscore ]](team, score);
            }
        }
        return winningteam;
    }
    if (level.scoreroundwinbased) {
        updateteamscorebyroundswon();
        winner = globallogic::determineteamwinnerbygamestat("roundswon");
    } else {
        winner = globallogic::determineteamwinnerbyteamscore();
    }
    return winner;
}

// Namespace ball
// Params 0, eflags: 0x0
// Checksum 0xabc3d2a0, Offset: 0x2ec0
// Size: 0x24
function function_d6911678() {
    self settext(%);
}

// Namespace ball
// Params 0, eflags: 0x0
// Checksum 0x62044837, Offset: 0x2ef0
// Size: 0x17c
function shouldplayovertimeround() {
    if (isdefined(game["overtime_round"])) {
        if (game["overtime_round"] == 1 || !level.gameended) {
            return true;
        }
        return false;
    }
    if (!level.scoreroundwinbased) {
        if (util::hitroundlimit() || game["teamScores"]["allies"] == game["teamScores"]["axis"] && game["teamScores"]["allies"] == level.scorelimit - 1) {
            return true;
        }
    } else {
        alliesroundswon = util::getroundswon("allies");
        axisroundswon = util::getroundswon("axis");
        if (level.roundwinlimit > 0 && axisroundswon == level.roundwinlimit - 1 && alliesroundswon == level.roundwinlimit - 1) {
            return true;
        }
        if (util::hitroundlimit() && alliesroundswon == axisroundswon) {
            return true;
        }
    }
    return false;
}

// Namespace ball
// Params 4, eflags: 0x0
// Checksum 0x2b6946be, Offset: 0x3078
// Size: 0x7e
function function_54dd76af(einflictor, attacker, smeansofdeath, weapon) {
    teamkill_penalty = globallogic_defaults::default_getteamkillpenalty(einflictor, attacker, smeansofdeath, weapon);
    if (isdefined(self.var_1821be2) && self.var_1821be2) {
        teamkill_penalty *= level.teamkillpenaltymultiplier;
    }
    return teamkill_penalty;
}

// Namespace ball
// Params 4, eflags: 0x0
// Checksum 0xf82f3834, Offset: 0x3100
// Size: 0x8a
function function_eb6c9496(einflictor, attacker, smeansofdeath, weapon) {
    teamkill_score = rank::getscoreinfovalue("kill");
    if (isdefined(self.var_1821be2) && self.var_1821be2) {
        teamkill_score *= level.teamkillscoremultiplier;
    }
    return int(teamkill_score);
}

// Namespace ball
// Params 6, eflags: 0x0
// Checksum 0xca56900f, Offset: 0x3198
// Size: 0x154
function function_6be95ac8(startpos, startangles, index, count, defaultdistance, rotation) {
    currentangle = startangles[1] + 360 / count * 0.5 + 360 / count * index;
    coscurrent = cos(currentangle + rotation);
    sincurrent = sin(currentangle + rotation);
    new_position = startpos + (defaultdistance * coscurrent, defaultdistance * sincurrent, 0);
    clip_mask = 1 | 8;
    trace = physicstrace(startpos, new_position, (-5, -5, -5), (5, 5, 5), self, clip_mask);
    return trace["position"];
}

// Namespace ball
// Params 0, eflags: 0x0
// Checksum 0xe17e5c79, Offset: 0x32f8
// Size: 0x348
function setup_objectives() {
    level.ball_goals = [];
    level.ball_starts = [];
    level.balls = [];
    level.ball_starts = getentarray("ball_start", "targetname");
    foreach (ball_start in level.ball_starts) {
        level.balls[level.balls.size] = function_dbf94d16(ball_start);
    }
    if (level.ballcount > level.ball_starts.size) {
        width = 48;
        height = 48;
        count = level.ballcount - level.ball_starts.size;
        for (index = 0; index < count; index++) {
            position = function_6be95ac8(level.ball_starts[0].origin, level.ball_starts[0].angles, index, count, width, 0);
            trigger = spawn("trigger_radius", position, 0, width, height);
            level.ball_starts[level.ball_starts.size] = trigger;
            level.balls[level.balls.size] = function_dbf94d16(trigger);
        }
    }
    foreach (team in level.teams) {
        if (!game["switchedsides"]) {
            trigger = getent("ball_goal_" + team, "targetname");
        } else {
            trigger = getent("ball_goal_" + util::getotherteam(team), "targetname");
        }
        level.ball_goals[team] = function_b22de10a(trigger, team);
    }
}

// Namespace ball
// Params 2, eflags: 0x0
// Checksum 0x6a75c76a, Offset: 0x3648
// Size: 0x224
function function_b22de10a(trigger, team) {
    useobj = gameobjects::create_use_object(team, trigger, [], (0, 0, trigger.height * 0.5), istring("ball_goal_" + team));
    useobj gameobjects::set_visible_team("any");
    useobj gameobjects::set_model_visibility(1);
    useobj gameobjects::allow_use("enemy");
    useobj gameobjects::set_use_time(0);
    foreach (ball in level.balls) {
        useobj gameobjects::set_key_object(ball);
    }
    useobj.var_cd77875d = &function_ce3bd9c9;
    useobj.onuse = &function_3d1ee3cc;
    useobj.ball_in_goal = 0;
    useobj.radiussq = trigger.radius * trigger.radius;
    useobj.center = trigger.origin + (0, 0, trigger.height * 0.5);
    return useobj;
}

// Namespace ball
// Params 1, eflags: 0x0
// Checksum 0xbaa9b3f3, Offset: 0x3878
// Size: 0x14
function function_ce3bd9c9(player) {
    return !self.ball_in_goal;
}

// Namespace ball
// Params 1, eflags: 0x0
// Checksum 0xe5418b89, Offset: 0x3898
// Size: 0x3fc
function function_3d1ee3cc(player) {
    if (!isdefined(player) || !isdefined(player.carryobject)) {
        return;
    }
    if (isdefined(player.carryobject.scorefrozenuntil) && player.carryobject.scorefrozenuntil > gettime()) {
        return;
    }
    self function_85e74fc9();
    player.carryobject.scorefrozenuntil = gettime() + 10000;
    ball_check_assist(player, 1);
    team = self.team;
    otherteam = util::getotherteam(team);
    globallogic_audio::flush_objective_dialog("uplink_ball");
    globallogic_audio::leader_dialog("uplWeUplink", otherteam);
    globallogic_audio::leader_dialog("uplTheyUplink", team);
    globallogic_audio::play_2d_on_team("mpl_ballcapture_sting_friend", otherteam);
    globallogic_audio::play_2d_on_team("mpl_ballcapture_sting_enemy", team);
    level thread popups::displayteammessagetoteam(%MP_BALL_CAPTURE, player, team);
    level thread popups::displayteammessagetoteam(%MP_BALL_CAPTURE, player, otherteam);
    if (should_record_final_score_cam(otherteam, level.carryscore)) {
    }
    if (isdefined(player.var_6221f6f)) {
        player.var_6221f6f.inuse = 0;
    }
    ball = player.carryobject;
    ball.lastcarrierscored = 1;
    player gameobjects::take_carry_weapon(ball.carryweapon);
    ball ball_set_dropped(1);
    ball thread function_db6a152e(self);
    if (isdefined(player.pers["carries"])) {
        player.pers["carries"]++;
        player.carries = player.pers["carries"];
    }
    bbprint("mpobjective", "gametime %d objtype %s team %s playerx %d playery %d playerz %d", gettime(), "ball_capture", team, player.origin);
    player recordgameevent("capture");
    player challenges::capturedobjective(gettime(), self.trigger);
    player addplayerstatwithgametype("CARRIES", 1);
    player addplayerstatwithgametype("captures", 1);
    scoreevents::processscoreevent("ball_capture_carry", player);
    ball_give_score(otherteam, level.carryscore);
}

// Namespace ball
// Params 1, eflags: 0x0
// Checksum 0x391d964d, Offset: 0x3ca0
// Size: 0x378
function function_dbf94d16(trigger) {
    visuals = [];
    visuals[0] = spawn("script_model", trigger.origin);
    visuals[0] setmodel("wpn_t7_uplink_ball_world");
    visuals[0] notsolid();
    trigger enablelinkto();
    trigger linkto(visuals[0]);
    trigger.no_moving_platfrom_unlink = 1;
    var_afffeadd = gameobjects::create_carry_object("neutral", trigger, visuals, (0, 0, 0), istring("ball_ball"), "mpl_hit_alert_ballholder");
    var_afffeadd gameobjects::allow_carry("any");
    var_afffeadd gameobjects::set_visible_team("any");
    var_afffeadd gameobjects::set_drop_offset(8);
    var_afffeadd.objectiveonvisuals = 1;
    var_afffeadd.allowweapons = 0;
    var_afffeadd.carryweapon = getweapon("ball");
    var_afffeadd.keepcarryweapon = 1;
    var_afffeadd.waterbadtrigger = 0;
    var_afffeadd.disallowremotecontrol = 1;
    var_afffeadd.disallowplaceablepickup = 1;
    var_afffeadd gameobjects::update_objective();
    var_afffeadd.canuseobject = &function_b861e1df;
    var_afffeadd.onpickup = &function_6ce143ff;
    var_afffeadd.setdropped = &ball_set_dropped;
    var_afffeadd.onreset = &function_df2611a2;
    var_afffeadd.pickuptimeoutoverride = &ball_physics_timeout;
    var_afffeadd.carryweaponthink = &function_804453f1;
    var_afffeadd.in_goal = 0;
    var_afffeadd.lastcarrierscored = 0;
    var_afffeadd.lastcarrierteam = "neutral";
    if (level.enemycarriervisible == 2) {
        var_afffeadd.objidpingfriendly = 1;
    }
    if (level.idleflagreturntime > 0) {
        var_afffeadd.autoresettime = level.idleflagreturntime;
    } else {
        var_afffeadd.autoresettime = undefined;
    }
    playfxontag("ui/fx_uplink_ball_trail", var_afffeadd.visuals[0], "tag_origin");
    return var_afffeadd;
}

// Namespace ball
// Params 1, eflags: 0x0
// Checksum 0xa881ec7a, Offset: 0x4020
// Size: 0x3de
function function_b861e1df(player) {
    if (!isdefined(player)) {
        return false;
    }
    if (!self gameobjects::can_interact_with(player)) {
        return false;
    }
    if (isdefined(self.droptime) && self.droptime >= gettime()) {
        return false;
    }
    if (isdefined(player.resurrect_weapon) && player getcurrentweapon() == player.resurrect_weapon) {
        return false;
    }
    if (player iscarryingturret()) {
        return false;
    }
    currentweapon = player getcurrentweapon();
    if (isdefined(currentweapon)) {
        if (!valid_ball_pickup_weapon(currentweapon)) {
            return false;
        }
    }
    nextweapon = player.changingweapon;
    if (isdefined(nextweapon) && player isswitchingweapons()) {
        if (!valid_ball_pickup_weapon(nextweapon)) {
            return false;
        }
    }
    if (player player_no_pickup_time()) {
        return false;
    }
    ball = self.visuals[0];
    thresh = 15;
    dist2 = distance2dsquared(ball.origin, player.origin);
    if (dist2 < thresh * thresh) {
        return true;
    }
    start = player geteye();
    end = (self.curorigin[0], self.curorigin[1], self.curorigin[2] + 5);
    if (isdefined(ball)) {
        end = (ball.origin[0], ball.origin[1], ball.origin[2] + 5);
    }
    if (isdefined(self.carrier) && isplayer(self.carrier)) {
        end = self.carrier geteye();
    }
    first_skip_ent = ball;
    second_skip_ent = ball;
    if (isdefined(self.projectile)) {
        first_skip_ent = self.projectile;
    }
    if (isdefined(self.lastprojectile)) {
        second_skip_ent = self.lastprojectile;
    }
    if (!bullettracepassed(end, start, 0, first_skip_ent, second_skip_ent, 0, 0)) {
        player_origin = (player.origin[0], player.origin[1], player.origin[2] + 10);
        if (!bullettracepassed(end, player_origin, 0, first_skip_ent, second_skip_ent, 0, 0)) {
            return false;
        }
    }
    return true;
}

// Namespace ball
// Params 0, eflags: 0x0
// Checksum 0x5ffc5b0a, Offset: 0x4408
// Size: 0x1a8
function function_9e348528() {
    self.isresetting = 1;
    self notify(#"reset");
    origin = self.curorigin;
    if (isdefined(self.projectile)) {
        origin = self.projectile.origin;
    }
    foreach (visual in self.visuals) {
        visual.origin = origin;
        visual.angles = visual.baseangles;
        visual dontinterpolate();
        visual show();
    }
    if (isdefined(self.projectile)) {
        self.projectile delete();
        self.lastprojectile = undefined;
    }
    self gameobjects::clear_carrier();
    gameobjects::function_a45fe1cc();
    gameobjects::function_2158302c();
    gameobjects::update_objective();
    self.isresetting = 0;
}

// Namespace ball
// Params 1, eflags: 0x0
// Checksum 0xfed7917, Offset: 0x45b8
// Size: 0x514
function function_6ce143ff(player) {
    self gameobjects::set_flags(0);
    if (!isalive(player)) {
        self function_9e348528();
        return;
    }
    player disableusability();
    player disableoffhandweapons();
    level.usestartspawns = 0;
    level clientfield::set("ball_away", 1);
    linkedparent = self.visuals[0] getlinkedent();
    if (isdefined(linkedparent)) {
        self.visuals[0] unlink();
    }
    player resetflashback();
    pass = 0;
    ball_velocity = 0;
    if (isdefined(self.projectile)) {
        pass = 1;
        ball_velocity = self.projectile getvelocity();
        self.projectile delete();
        self.lastprojectile = undefined;
    }
    if (pass) {
        if (self.lastcarrierteam == player.team) {
            if (self.lastcarrier != player) {
                player.passtime = gettime();
                player.passplayer = self.lastcarrier;
                globallogic_audio::leader_dialog("uplTransferred", player.team, undefined, "uplink_ball");
            }
        } else if (length(ball_velocity) > 0.1) {
            scoreevents::processscoreevent("ball_intercept", player);
        }
    }
    otherteam = util::getotherteam(player.team);
    if (self.lastcarrierteam != player.team) {
        globallogic_audio::leader_dialog("uplWeTake", player.team, undefined, "uplink_ball");
        globallogic_audio::leader_dialog("uplTheyTake", otherteam, undefined, "uplink_ball");
    }
    globallogic_audio::play_2d_on_team("mpl_ballget_sting_friend", player.team);
    globallogic_audio::play_2d_on_team("mpl_ballget_sting_enemy", otherteam);
    level thread popups::displayteammessagetoteam(%MP_BALL_PICKED_UP, player, player.team);
    level thread popups::displayteammessagetoteam(%MP_BALL_PICKED_UP, player, otherteam);
    self.lastcarrierscored = 0;
    self.lastcarrier = player;
    self.lastcarrierteam = player.team;
    self gameobjects::set_owner_team(player.team);
    player.balldropdelay = getdvarint("scr_ball_water_drop_delay", 10);
    player.objective = 1;
    player.hasperksprintfire = player hasperk("specialty_sprintfire");
    player setperk("specialty_sprintfire");
    player clientfield::set("ballcarrier", 1);
    if (level.var_ef3abf3b > 0) {
        player thread armor::setlightarmor(level.var_ef3abf3b);
    } else {
        player thread armor::unsetlightarmor();
    }
    player thread player_update_pass_target(self);
    player recordgameevent("pickup");
}

// Namespace ball
// Params 0, eflags: 0x0
// Checksum 0x42005cde, Offset: 0x4ad8
// Size: 0x150
function ball_carrier_cleanup() {
    self gameobjects::set_owner_team("neutral");
    if (isdefined(self.carrier)) {
        self.carrier clientfield::set("ballcarrier", 0);
        self.carrier.balldropdelay = undefined;
        self.carrier.nopickuptime = gettime() + 500;
        self.carrier player_clear_pass_target();
        self.carrier notify(#"hash_bf5529ed");
        self.carrier thread armor::unsetlightarmor();
        if (!self.carrier.hasperksprintfire) {
            self.carrier unsetperk("specialty_sprintfire");
        }
        self.carrier enableusability();
        self.carrier enableoffhandweapons();
        self.carrier setballpassallowed(0);
        self.carrier.objective = 0;
    }
}

// Namespace ball
// Params 1, eflags: 0x0
// Checksum 0x9b860a47, Offset: 0x4c30
// Size: 0x250
function ball_set_dropped(skip_physics) {
    if (!isdefined(skip_physics)) {
        skip_physics = 0;
    }
    self.isresetting = 1;
    self.droptime = gettime();
    self notify(#"dropped");
    dropangles = (0, 0, 0);
    carrier = self.carrier;
    if (isdefined(carrier) && carrier.team != "spectator") {
        droporigin = carrier.origin;
        dropangles = carrier.angles;
    } else {
        droporigin = self.origin;
    }
    if (!isdefined(droporigin)) {
        droporigin = self.safeorigin;
    }
    droporigin += (0, 0, 40);
    if (isdefined(self.projectile)) {
        self.projectile delete();
    }
    self ball_carrier_cleanup();
    self gameobjects::clear_carrier();
    self gameobjects::set_position(droporigin, dropangles);
    self gameobjects::function_983a9443();
    self thread gameobjects::pickup_timeout(droporigin[2], droporigin[2] - 40);
    self.isresetting = 0;
    if (!skip_physics) {
        angles = (0, dropangles[1], 0);
        forward = anglestoforward(angles);
        velocity = forward * -56 + (0, 0, 80);
        ball_physics_launch(velocity);
    }
    return true;
}

// Namespace ball
// Params 1, eflags: 0x0
// Checksum 0xda30032, Offset: 0x4e88
// Size: 0x16c
function function_df2611a2(prev_origin) {
    if (isdefined(level.gameended) && level.gameended) {
        return;
    }
    visual = self.visuals[0];
    linkedparent = visual getlinkedent();
    if (isdefined(linkedparent)) {
        visual unlink();
    }
    if (isdefined(self.projectile)) {
        self.projectile delete();
    }
    if (!self gameobjects::get_flags(1)) {
        playfx("ui/fx_uplink_ball_vanish", prev_origin);
        self function_6dc166ee();
    }
    self.lastcarrierteam = "none";
    self thread function_7cd85c83();
    if (isdefined(self.killcament) && isentity(self.killcament)) {
        self.killcament recordgameeventnonplayer("ball_reset");
    }
}

// Namespace ball
// Params 0, eflags: 0x0
// Checksum 0x860b615, Offset: 0x5000
// Size: 0x1c
function function_98827162() {
    self thread gameobjects::return_home();
}

// Namespace ball
// Params 1, eflags: 0x0
// Checksum 0xd26f3717, Offset: 0x5028
// Size: 0x24c
function function_db6a152e(goal) {
    self notify(#"score_event");
    self.in_goal = 1;
    goal.ball_in_goal = 1;
    if (isdefined(self.projectile)) {
        self.projectile delete();
    }
    self gameobjects::allow_carry("none");
    var_c3f5985e = 0.4;
    var_55f7566e = 1.2;
    rotate_time = 1;
    var_85678934 = var_c3f5985e + rotate_time;
    total_time = var_85678934 + var_55f7566e;
    self gameobjects::set_flags(1);
    visual = self.visuals[0];
    visual moveto(goal.center, var_c3f5985e, 0, var_c3f5985e);
    visual rotatevelocity((1080, 1080, 0), total_time, total_time, 0);
    wait var_85678934;
    goal.ball_in_goal = 0;
    self.visibleteam = "neutral";
    self gameobjects::function_85576d4d("friendly", 0);
    self gameobjects::function_85576d4d("enemy", 0);
    self gameobjects::update_objective();
    visual movez(4000, var_55f7566e, var_55f7566e * 0.1, 0);
    wait var_55f7566e;
    self thread gameobjects::return_home();
}

// Namespace ball
// Params 0, eflags: 0x0
// Checksum 0x39fccac0, Offset: 0x5280
// Size: 0x228
function function_7cd85c83() {
    self endon(#"pickup_object");
    self gameobjects::allow_carry("any");
    self gameobjects::set_owner_team("neutral");
    self gameobjects::set_flags(2);
    visual = self.visuals[0];
    visual.origin = visual.baseorigin + (0, 0, 4000);
    visual dontinterpolate();
    fall_time = 3;
    visual moveto(visual.baseorigin, fall_time, 0, fall_time);
    visual rotatevelocity((0, 720, 0), fall_time, 0, fall_time);
    self.visibleteam = "any";
    self gameobjects::function_85576d4d("friendly", 1);
    self gameobjects::function_85576d4d("enemy", 1);
    self gameobjects::update_objective();
    wait fall_time;
    self gameobjects::set_flags(0);
    level clientfield::set("ball_away", 0);
    playfxontag("ui/fx_uplink_ball_trail", visual, "tag_origin");
    self thread ball_download_fx(visual, fall_time);
    self.in_goal = 0;
}

// Namespace ball
// Params 0, eflags: 0x0
// Checksum 0xaedbf88f, Offset: 0x54b0
// Size: 0x54
function function_804453f1() {
    self endon(#"disconnect");
    self thread ball_pass_watch();
    self thread ball_shoot_watch();
    self thread ball_weapon_change_watch();
}

// Namespace ball
// Params 0, eflags: 0x0
// Checksum 0x80849ebe, Offset: 0x5510
// Size: 0x254
function ball_pass_watch() {
    level endon(#"game_ended");
    self endon(#"disconnect");
    self endon(#"death");
    self endon(#"drop_object");
    while (true) {
        self waittill(#"ball_pass", weapon);
        if (!isdefined(self.pass_target)) {
            playerangles = self getplayerangles();
            playerangles = (math::clamp(playerangles[0], -85, 85), playerangles[1], playerangles[2]);
            dir = anglestoforward(playerangles);
            force = 90;
            self.carryobject thread ball_physics_launch_drop(dir * force, self);
            return;
        }
        break;
    }
    if (isdefined(self.carryobject)) {
        self thread ball_pass_or_throw_active();
        pass_target = self.pass_target;
        var_bd2ced7c = self.pass_target.origin;
        wait 0.15;
        if (isdefined(self.pass_target)) {
            pass_target = self.pass_target;
            self.carryobject thread ball_pass_projectile(self, pass_target, var_bd2ced7c);
            return;
        }
        playerangles = self getplayerangles();
        playerangles = (math::clamp(playerangles[0], -85, 85), playerangles[1], playerangles[2]);
        dir = anglestoforward(playerangles);
        force = 90;
        self.carryobject thread ball_physics_launch_drop(dir * force, self);
    }
}

// Namespace ball
// Params 0, eflags: 0x0
// Checksum 0x851718c5, Offset: 0x5770
// Size: 0x1e4
function ball_shoot_watch() {
    level endon(#"game_ended");
    self endon(#"disconnect");
    self endon(#"death");
    self endon(#"drop_object");
    extra_pitch = getdvarfloat("scr_ball_shoot_extra_pitch", 0);
    force = getdvarfloat("scr_ball_shoot_force", 900);
    while (true) {
        self waittill(#"weapon_fired", weapon);
        if (weapon != getweapon("ball")) {
            continue;
        }
        break;
    }
    if (isdefined(self.carryobject)) {
        playerangles = self getplayerangles();
        playerangles += (extra_pitch, 0, 0);
        playerangles = (math::clamp(playerangles[0], -85, 85), playerangles[1], playerangles[2]);
        dir = anglestoforward(playerangles);
        self thread ball_pass_or_throw_active();
        self thread ball_check_pass_kill_pickup(self.carryobject);
        self.carryobject ball_create_killcam_ent();
        self.carryobject thread ball_physics_launch_drop(dir * force, self, 1);
    }
}

// Namespace ball
// Params 0, eflags: 0x0
// Checksum 0xc63c2ca6, Offset: 0x5960
// Size: 0x1d4
function ball_weapon_change_watch() {
    level endon(#"game_ended");
    self endon(#"disconnect");
    self endon(#"death");
    self endon(#"drop_object");
    ballweapon = getweapon("ball");
    while (true) {
        if (ballweapon == self getcurrentweapon()) {
            break;
        }
        self waittill(#"weapon_change");
    }
    while (true) {
        self waittill(#"weapon_change", weapon, lastweapon);
        if (isdefined(weapon) && weapon.gadget_type == 14) {
            break;
        }
        if (weapon === level.weaponnone && lastweapon === ballweapon) {
            break;
        }
    }
    playerangles = self getplayerangles();
    playerangles = (math::clamp(playerangles[0], -85, 85), absangleclamp360(playerangles[1] + 20), playerangles[2]);
    dir = anglestoforward(playerangles);
    force = 90;
    self.carryobject thread ball_physics_launch_drop(dir * force, self);
}

// Namespace ball
// Params 1, eflags: 0x0
// Checksum 0xbb5e9b2, Offset: 0x5b40
// Size: 0x66
function valid_ball_pickup_weapon(weapon) {
    if (weapon == level.weaponnone) {
        return false;
    }
    if (weapon == getweapon("ball")) {
        return false;
    }
    if (killstreaks::is_killstreak_weapon(weapon)) {
        return false;
    }
    return true;
}

// Namespace ball
// Params 0, eflags: 0x0
// Checksum 0xc91d27ae, Offset: 0x5bb0
// Size: 0x1a
function player_no_pickup_time() {
    return isdefined(self.nopickuptime) && self.nopickuptime > gettime();
}

// Namespace ball
// Params 1, eflags: 0x0
// Checksum 0xb206613, Offset: 0x5bd8
// Size: 0x10c
function function_40dff2cd(trigger) {
    self endon(#"death");
    self endon(#"disconnect");
    while (true) {
        if (self isplayerunderwater()) {
            foreach (ball in level.balls) {
                if (isdefined(ball.carrier) && ball.carrier == self) {
                    ball gameobjects::set_dropped();
                    return;
                }
            }
        }
        self.balldropdelay = undefined;
        wait 0.05;
    }
}

// Namespace ball
// Params 3, eflags: 0x0
// Checksum 0xc839a79a, Offset: 0x5cf0
// Size: 0x7c
function ball_physics_launch_drop(force, droppingplayer, switchweapon) {
    ball_set_dropped(1);
    ball_physics_launch(force, droppingplayer);
    if (isdefined(switchweapon) && switchweapon) {
        droppingplayer killstreaks::switch_to_last_non_killstreak_weapon(undefined, 1);
    }
}

// Namespace ball
// Params 1, eflags: 0x0
// Checksum 0x6cbbbb7d, Offset: 0x5d78
// Size: 0x1a4
function ball_check_pass_kill_pickup(carryobj) {
    self endon(#"death");
    self endon(#"disconnect");
    carryobj endon(#"reset");
    timer = spawnstruct();
    timer endon(#"hash_88be9d37");
    timer thread timer_run(1.5);
    carryobj waittill(#"pickup_object");
    timer timer_cancel();
    if (!isdefined(carryobj.carrier) || carryobj.carrier.team == self.team) {
        return;
    }
    carryobj.carrier endon(#"disconnect");
    timer thread timer_run(5);
    carryobj.carrier waittill(#"death", attacker);
    timer timer_cancel();
    if (!isdefined(attacker) || attacker != self) {
        return;
    }
    timer thread timer_run(2);
    carryobj waittill(#"pickup_object");
    timer timer_cancel();
}

// Namespace ball
// Params 1, eflags: 0x0
// Checksum 0x62f7ff82, Offset: 0x5f28
// Size: 0x2a
function timer_run(time) {
    self endon(#"hash_a5c97639");
    wait time;
    self notify(#"hash_88be9d37");
}

// Namespace ball
// Params 0, eflags: 0x0
// Checksum 0xc6369a75, Offset: 0x5f60
// Size: 0x12
function timer_cancel() {
    self notify(#"hash_a5c97639");
}

// Namespace ball
// Params 1, eflags: 0x0
// Checksum 0x3969ab1, Offset: 0x5f80
// Size: 0xfc
function adjust_for_stance(ball) {
    target = self;
    target endon(#"hash_4ae8aa2c");
    var_5fe7ebc7 = 0;
    while (isdefined(target) && isdefined(ball)) {
        var_e13766c7 = 50;
        switch (target getstance()) {
        case "crouch":
            var_e13766c7 = 30;
            break;
        case "prone":
            var_e13766c7 = 15;
            break;
        }
        if (var_e13766c7 != var_5fe7ebc7) {
            ball ballsettarget(target, (0, 0, var_e13766c7));
            var_e13766c7 = var_5fe7ebc7;
        }
        wait 0.05;
    }
}

// Namespace ball
// Params 3, eflags: 0x0
// Checksum 0x513675c6, Offset: 0x6088
// Size: 0x454
function ball_pass_projectile(var_c7e075bf, target, var_bd2ced7c) {
    ball_set_dropped(1);
    if (isdefined(target)) {
        var_bd2ced7c = target.origin;
    }
    offset = (0, 0, 60);
    if (target getstance() == "prone") {
        offset = (0, 0, 15);
    } else if (target getstance() == "crouch") {
        offset = (0, 0, 30);
    }
    playerangles = var_c7e075bf getplayerangles();
    playerangles = (0, playerangles[1], 0);
    dir = anglestoforward(playerangles);
    delta = dir * 50;
    origin = self.visuals[0].origin + delta;
    size = 5;
    trace = physicstrace(self.visuals[0].origin, origin, (size * -1, size * -1, size * -1), (size, size, size), var_c7e075bf, 1);
    if (trace["fraction"] < 1) {
        t = 0.7 * trace["fraction"];
        self gameobjects::set_position(self.visuals[0].origin + delta * t, self.visuals[0].angles);
    } else {
        self gameobjects::set_position(trace["position"], self.visuals[0].angles);
    }
    var_c23fae42 = vectornormalize(var_bd2ced7c + offset - self.visuals[0].origin);
    var_59ae0bde = var_c23fae42 * 850;
    self.lastprojectile = self.projectile;
    self.projectile = var_c7e075bf magicmissile(level.var_aff3334d, self.visuals[0].origin, var_59ae0bde);
    target thread adjust_for_stance(self.projectile);
    self.visuals[0] linkto(self.projectile);
    self gameobjects::ghost_visuals();
    self ball_create_killcam_ent();
    self ball_clear_contents();
    self thread ball_on_projectile_hit_client(var_c7e075bf);
    self thread ball_on_projectile_death();
    self thread function_859e9fab();
    var_c7e075bf killstreaks::switch_to_last_non_killstreak_weapon(undefined, 1);
}

// Namespace ball
// Params 0, eflags: 0x0
// Checksum 0x29df13e8, Offset: 0x64e8
// Size: 0xc4
function ball_on_projectile_death() {
    self.projectile waittill(#"death");
    ball = self.visuals[0];
    if (!isdefined(self.carrier) && !self.in_goal) {
        if (ball.origin != ball.baseorigin + (0, 0, 4000)) {
            self ball_physics_launch((0, 0, 10));
        }
    }
    self ball_restore_contents();
    ball notify(#"hash_4ae8aa2c");
}

// Namespace ball
// Params 0, eflags: 0x0
// Checksum 0xd0f27e4, Offset: 0x65b8
// Size: 0x6a
function ball_restore_contents() {
    if (isdefined(self.visuals[0].var_f8f65741)) {
        self.visuals[0] setcontents(self.visuals[0].var_f8f65741);
        self.visuals[0].var_f8f65741 = undefined;
    }
}

// Namespace ball
// Params 1, eflags: 0x0
// Checksum 0x2a7d6c3e, Offset: 0x6630
// Size: 0x84
function ball_on_projectile_hit_client(var_c7e075bf) {
    self endon(#"hash_4ae8aa2c");
    self.projectile waittill(#"projectile_impact_player", player);
    self.trigger notify(#"trigger", player);
    self.projectile notify(#"hash_e5e4f356");
    if (isdefined(var_c7e075bf)) {
        var_c7e075bf recordgameevent("pass");
    }
}

// Namespace ball
// Params 0, eflags: 0x0
// Checksum 0x9a14f112, Offset: 0x66c0
// Size: 0x38
function ball_clear_contents() {
    self.visuals[0].var_f8f65741 = self.visuals[0] setcontents(0);
}

// Namespace ball
// Params 0, eflags: 0x0
// Checksum 0x8e4da7c0, Offset: 0x6700
// Size: 0x9c
function ball_create_killcam_ent() {
    if (isdefined(self.killcament)) {
        self.killcament delete();
    }
    self.killcament = spawn("script_model", self.visuals[0].origin);
    self.killcament linkto(self.visuals[0]);
    self.killcament setcontents(0);
}

// Namespace ball
// Params 0, eflags: 0x0
// Checksum 0x91fcbd90, Offset: 0x67a8
// Size: 0x98
function ball_pass_or_throw_active() {
    self endon(#"death");
    self endon(#"disconnect");
    self.pass_or_throw_active = 1;
    self allowmelee(0);
    while (getweapon("ball") == self getcurrentweapon()) {
        wait 0.05;
    }
    self allowmelee(1);
    self.pass_or_throw_active = 0;
}

// Namespace ball
// Params 2, eflags: 0x0
// Checksum 0x7765c9c6, Offset: 0x6848
// Size: 0x20
function ball_download_fx(var_7ee2b1c, waittime) {
    self.scorefrozenuntil = 0;
}

// Namespace ball
// Params 0, eflags: 0x0
// Checksum 0x9805e33a, Offset: 0x6870
// Size: 0xec
function function_2635f289() {
    var_8f2a0684 = undefined;
    var_c9003254 = array::randomize(level.ball_starts);
    foreach (start in var_c9003254) {
        if (start.in_use) {
            continue;
        }
        var_8f2a0684 = start;
        break;
    }
    if (!isdefined(var_8f2a0684)) {
        return;
    }
    ball_assign_start(var_8f2a0684);
}

// Namespace ball
// Params 1, eflags: 0x0
// Checksum 0xfcffe9c2, Offset: 0x6968
// Size: 0xd4
function ball_assign_start(start) {
    foreach (vis in self.visuals) {
        vis.baseorigin = start.origin;
    }
    self.trigger.baseorigin = start.origin;
    self.current_start = start;
    start.in_use = 1;
}

// Namespace ball
// Params 2, eflags: 0x0
// Checksum 0x15335c42, Offset: 0x6a48
// Size: 0x32c
function ball_physics_launch(force, droppingplayer) {
    visuals = self.visuals[0];
    visuals.origin_prev = undefined;
    origin = visuals.origin;
    owner = visuals;
    if (isdefined(droppingplayer)) {
        owner = droppingplayer;
        origin = droppingplayer getweaponmuzzlepoint();
        right = anglestoright(force);
        origin += (right[0], right[1], 0) * 7;
        startpos = origin;
        delta = vectornormalize(force) * 80;
        size = 5;
        trace = physicstrace(startpos, startpos + delta, (size * -1, size * -1, size * -1), (size, size, size), droppingplayer, 1);
        if (trace["fraction"] < 1) {
            t = 0.7 * trace["fraction"];
            self gameobjects::set_position(startpos + delta * t, visuals.angles);
        } else {
            self gameobjects::set_position(trace["position"], visuals.angles);
        }
    }
    grenade = owner magicmissile(level.var_d566bdba, visuals.origin, force);
    visuals linkto(grenade);
    self gameobjects::ghost_visuals();
    self.lastprojectile = self.projectile;
    self.projectile = grenade;
    visuals dontinterpolate();
    self thread ball_physics_out_of_level();
    self thread function_859e9fab();
    self thread ball_physics_touch_cant_pickup_player(droppingplayer);
    self thread function_96acd1aa();
}

// Namespace ball
// Params 0, eflags: 0x0
// Checksum 0x2f4a12a9, Offset: 0x6d80
// Size: 0x11c
function function_96acd1aa() {
    self endon(#"reset");
    self endon(#"pickup_object");
    visual = self.visuals[0];
    while (true) {
        var_4fca0920 = isdefined(self.isresetting) && (isdefined(self.in_goal) && self.in_goal || self.isresetting);
        if (!var_4fca0920) {
            if (visual oob::istouchinganyoobtrigger() || visual function_b2a406b0() || self gameobjects::should_be_reset(visual.origin[2], visual.origin[2] + 10, 1)) {
                self function_98827162();
                return;
            }
        }
        wait 0.05;
    }
}

// Namespace ball
// Params 1, eflags: 0x0
// Checksum 0x68f19b88, Offset: 0x6ea8
// Size: 0xf4
function ball_physics_touch_cant_pickup_player(droppingplayer) {
    self endon(#"reset");
    self endon(#"pickup_object");
    ball = self.visuals[0];
    trigger = self.trigger;
    while (true) {
        trigger waittill(#"trigger", player);
        if (isdefined(droppingplayer) && droppingplayer == player && player player_no_pickup_time()) {
            continue;
        }
        if (self.droptime >= gettime()) {
            continue;
        }
        if (ball.origin == ball.baseorigin + (0, 0, 4000)) {
            continue;
        }
    }
}

// Namespace ball
// Params 0, eflags: 0x0
// Checksum 0xfafbcf8a, Offset: 0x6fa8
// Size: 0x92
function ball_physics_fake_bounce() {
    ball = self.visuals[0];
    vel = ball getvelocity();
    bounceforce = length(vel) / 10;
    var_553a55d2 = -1 * vectornormalize(vel);
}

// Namespace ball
// Params 0, eflags: 0x0
// Checksum 0xef61c6a5, Offset: 0x7048
// Size: 0x1a4
function function_859e9fab() {
    self endon(#"reset");
    self endon(#"pickup_object");
    var_a75918ba = level.ball_goals[util::getotherteam(self.lastcarrierteam)];
    while (true) {
        if (!var_a75918ba function_ce3bd9c9()) {
            wait 0.05;
            continue;
        }
        var_c64dfe9a = self.visuals[0];
        distsq = distancesquared(var_c64dfe9a.origin, var_a75918ba.center);
        if (distsq <= var_a75918ba.radiussq) {
            self thread ball_touched_goal(var_a75918ba);
            return;
        }
        if (isdefined(var_c64dfe9a.origin_prev)) {
            result = function_12bbc0ef(var_c64dfe9a.origin_prev, var_c64dfe9a.origin, var_a75918ba.center, var_a75918ba.trigger.radius);
            if (result) {
                self thread ball_touched_goal(var_a75918ba);
                return;
            }
        }
        wait 0.05;
    }
}

// Namespace ball
// Params 4, eflags: 0x0
// Checksum 0x5d076eb5, Offset: 0x71f8
// Size: 0xe4
function function_12bbc0ef(line_start, line_end, var_494a9d56, sphere_radius) {
    dir = vectornormalize(line_end - line_start);
    a = vectordot(dir, line_start - var_494a9d56);
    a *= a;
    b = line_start - var_494a9d56;
    b *= b;
    c = sphere_radius * sphere_radius;
    return a - b + c >= 0;
}

// Namespace ball
// Params 1, eflags: 0x0
// Checksum 0x9c7fa449, Offset: 0x72e8
// Size: 0x3b4
function ball_touched_goal(goal) {
    if (isdefined(self.claimplayer)) {
        return;
    }
    if (isdefined(self.scorefrozenuntil) && self.scorefrozenuntil > gettime()) {
        return;
    }
    self gameobjects::allow_carry("none");
    goal function_85e74fc9();
    self.scorefrozenuntil = gettime() + 10000;
    team = goal.team;
    otherteam = util::getotherteam(team);
    globallogic_audio::flush_objective_dialog("uplink_ball");
    globallogic_audio::leader_dialog("uplWeUplinkRemote", otherteam);
    globallogic_audio::leader_dialog("uplTheyUplinkRemote", team);
    globallogic_audio::play_2d_on_team("mpl_ballcapture_sting_friend", otherteam);
    globallogic_audio::play_2d_on_team("mpl_ballcapture_sting_enemy", team);
    if (isdefined(self.lastcarrier)) {
        level thread popups::displayteammessagetoteam(%MP_BALL_CAPTURE, self.lastcarrier, team);
        level thread popups::displayteammessagetoteam(%MP_BALL_CAPTURE, self.lastcarrier, otherteam);
        if (isdefined(self.lastcarrier.pers["throws"])) {
            self.lastcarrier.pers["throws"]++;
            self.lastcarrier.throws = self.lastcarrier.pers["throws"];
        }
        bbprint("mpobjective", "gametime %d objtype %s team %s playerx %d playery %d playerz %d", gettime(), "ball_throw", team, self.lastcarrier.origin);
        self.lastcarrier recordgameevent("throw");
        self.lastcarrier addplayerstatwithgametype("THROWS", 1);
        scoreevents::processscoreevent("ball_capture_throw", self.lastcarrier);
        self.lastcarrierscored = 1;
        ball_check_assist(self.lastcarrier, 0);
        if (isdefined(self.killcament) && should_record_final_score_cam(otherteam, level.throwscore)) {
        }
        self.lastcarrier challenges::capturedobjective(gettime(), self.trigger);
        self.lastcarrier addplayerstatwithgametype("CAPTURES", 1);
    }
    if (isdefined(self.killcament)) {
        self.killcament unlink();
    }
    self thread function_db6a152e(goal);
    ball_give_score(otherteam, level.throwscore);
}

// Namespace ball
// Params 2, eflags: 0x0
// Checksum 0x594041c8, Offset: 0x76a8
// Size: 0xec
function ball_give_score(team, score) {
    level globallogic_score::giveteamscoreforobjective(team, score);
    if (isdefined(game["overtime_round"])) {
        if (game["overtime_round"] == 1) {
            return;
        }
        if (game["ball_overtime_first_winner"] === team) {
            thread globallogic::endgame(team, game["strings"]["score_limit_reached"]);
        }
        team_score = [[ level._getteamscore ]](team);
        var_c97a682c = [[ level._getteamscore ]](util::getotherteam(team));
    }
}

// Namespace ball
// Params 2, eflags: 0x0
// Checksum 0xe50000c7, Offset: 0x77a0
// Size: 0x74
function should_record_final_score_cam(team, var_6db4572f) {
    team_score = [[ level._getteamscore ]](team);
    var_c97a682c = [[ level._getteamscore ]](util::getotherteam(team));
    return team_score + var_6db4572f >= var_c97a682c;
}

// Namespace ball
// Params 2, eflags: 0x0
// Checksum 0x428f0afa, Offset: 0x7820
// Size: 0x84
function ball_check_assist(player, var_84a3cadc) {
    if (!isdefined(player.passtime) || !isdefined(player.passplayer)) {
        return;
    }
    if (player.passtime + 3000 < gettime()) {
        return;
    }
    scoreevents::processscoreevent("ball_capture_assist", player.passplayer);
}

// Namespace ball
// Params 2, eflags: 0x0
// Checksum 0x81a5299a, Offset: 0x78b0
// Size: 0x88
function function_6746e980(projectile, timeout) {
    projectile endon(#"stationary");
    ret = self util::waittill_any_timeout(timeout, "reset", "pickup_object", "score_event");
    if (ret != "timeout" && isdefined(projectile)) {
        projectile notify(#"abort_ball_physics");
    }
}

// Namespace ball
// Params 0, eflags: 0x0
// Checksum 0x9a8517c7, Offset: 0x7940
// Size: 0x124
function ball_physics_timeout() {
    self endon(#"reset");
    self endon(#"pickup_object");
    self endon(#"score_event");
    if (isdefined(self.autoresettime) && self.autoresettime > 15) {
        var_394347f7 = self.autoresettime;
    } else {
        var_394347f7 = 15;
    }
    if (isdefined(self.projectile)) {
        self.projectile endon(#"abort_ball_physics");
        self thread function_6746e980(self.projectile, var_394347f7);
        var_2615ab42 = self.projectile util::waittill_any_timeout(var_394347f7, "stationary", "abort_ball_physics");
        if (!isdefined(var_2615ab42)) {
            return;
        }
        if (var_2615ab42 == "stationary") {
            if (isdefined(self.autoresettime)) {
                wait self.autoresettime;
            }
        }
    }
    self function_98827162();
}

// Namespace ball
// Params 0, eflags: 0x0
// Checksum 0xc5f7222f, Offset: 0x7a70
// Size: 0x54
function ball_physics_out_of_level() {
    self endon(#"reset");
    self endon(#"pickup_object");
    ball = self.visuals[0];
    self waittill(#"hash_369e04c9");
    self function_98827162();
}

// Namespace ball
// Params 1, eflags: 0x0
// Checksum 0x4306d814, Offset: 0x7ad0
// Size: 0x3a8
function player_update_pass_target(var_afffeadd) {
    self notify(#"hash_227c656a");
    self endon(#"hash_227c656a");
    self endon(#"disconnect");
    self endon(#"hash_bf5529ed");
    test_dot = 0.8;
    while (true) {
        new_target = undefined;
        if (!self isonladder()) {
            playerdir = anglestoforward(self getplayerangles());
            playereye = self geteye();
            var_9ee2cc0f = [];
            foreach (target in level.players) {
                if (self == target) {
                    continue;
                }
                if (target.team != self.team) {
                    continue;
                }
                if (!isalive(target)) {
                    continue;
                }
                if (!var_afffeadd function_b861e1df(target)) {
                    continue;
                }
                targeteye = target geteye();
                distsq = distancesquared(targeteye, playereye);
                if (distsq > 1000000) {
                    continue;
                }
                dirtotarget = vectornormalize(targeteye - playereye);
                dot = vectordot(playerdir, dirtotarget);
                if (dot > test_dot) {
                    target.pass_dot = dot;
                    target.var_4e7a846b = targeteye;
                    var_9ee2cc0f[var_9ee2cc0f.size] = target;
                }
            }
            var_9ee2cc0f = array::quicksort(var_9ee2cc0f, &compare_player_pass_dot);
            foreach (target in var_9ee2cc0f) {
                if (sighttracepassed(playereye, target.var_4e7a846b, 0, target)) {
                    new_target = target;
                    break;
                }
            }
        }
        self player_set_pass_target(new_target);
        wait 0.05;
    }
}

// Namespace ball
// Params 0, eflags: 0x0
// Checksum 0x99b405f9, Offset: 0x7e80
// Size: 0xba
function function_6dc166ee() {
    foreach (team in level.teams) {
        globallogic_audio::play_2d_on_team("mpl_ballreturn_sting", team);
        globallogic_audio::leader_dialog("uplReset", team, undefined, "uplink_ball");
    }
}

// Namespace ball
// Params 2, eflags: 0x0
// Checksum 0x2b0ecf81, Offset: 0x7f48
// Size: 0x30
function compare_player_pass_dot(left, right) {
    return left.pass_dot >= right.pass_dot;
}

// Namespace ball
// Params 1, eflags: 0x0
// Checksum 0xc5bd22ec, Offset: 0x7f80
// Size: 0x19c
function player_set_pass_target(new_target) {
    if (isdefined(self.pass_target) && isdefined(new_target) && self.pass_target == new_target) {
        return;
    }
    if (!isdefined(self.pass_target) && !isdefined(new_target)) {
        return;
    }
    self player_clear_pass_target();
    if (isdefined(new_target)) {
        offset = (0, 0, 80);
        new_target clientfield::set("passoption", 1);
        self.pass_target = new_target;
        team_players = [];
        foreach (player in level.players) {
            if (player.team == self.team && player != self && player != new_target) {
                team_players[team_players.size] = player;
            }
        }
        self setballpassallowed(1);
    }
}

// Namespace ball
// Params 0, eflags: 0x0
// Checksum 0x90c69813, Offset: 0x8128
// Size: 0x134
function player_clear_pass_target() {
    if (isdefined(self.pass_icon)) {
        self.pass_icon destroy();
    }
    team_players = [];
    foreach (player in level.players) {
        if (player.team == self.team && player != self) {
            team_players[team_players.size] = player;
        }
    }
    if (isdefined(self.pass_target)) {
        self.pass_target clientfield::set("passoption", 0);
    }
    self.pass_target = undefined;
    self setballpassallowed(0);
}

// Namespace ball
// Params 1, eflags: 0x0
// Checksum 0xc5dc5edb, Offset: 0x8268
// Size: 0x22e
function function_5fa54274(var_c713c3d7) {
    ball_starts = getentarray("ball_start", "targetname");
    ball_starts = array::randomize(ball_starts);
    foreach (var_8f2a0684 in ball_starts) {
        function_d6b63e51(var_8f2a0684.origin);
    }
    var_4e6825b2 = 30;
    if (ball_starts.size == 0) {
        origin = level.default_ball_origin;
        if (!isdefined(origin)) {
            origin = (0, 0, 0);
        }
        function_d6b63e51(origin);
    }
    var_7adceb37 = var_c713c3d7 - level.ball_starts.size;
    if (var_7adceb37 <= 0) {
        return;
    }
    default_start = level.ball_starts[0].origin;
    var_69e0d43d = getnodesinradius(default_start, -56, 20, 50);
    var_69e0d43d = array::randomize(var_69e0d43d);
    for (i = 0; i < var_7adceb37 && i < var_69e0d43d.size; i++) {
        function_d6b63e51(var_69e0d43d[i].origin);
    }
}

// Namespace ball
// Params 1, eflags: 0x0
// Checksum 0xe82efc29, Offset: 0x84a0
// Size: 0xba
function function_d6b63e51(origin) {
    var_46cb7098 = 30;
    var_8f2a0684 = spawnstruct();
    var_8f2a0684.origin = origin;
    var_8f2a0684 function_22c4dbca();
    var_8f2a0684.origin = var_8f2a0684.ground_origin + (0, 0, var_46cb7098);
    var_8f2a0684.in_use = 0;
    level.ball_starts[level.ball_starts.size] = var_8f2a0684;
}

// Namespace ball
// Params 1, eflags: 0x0
// Checksum 0x5637d785, Offset: 0x8568
// Size: 0xba
function function_22c4dbca(z_offset) {
    tracestart = self.origin + (0, 0, 32);
    traceend = self.origin + (0, 0, -1000);
    trace = bullettrace(tracestart, traceend, 0, undefined);
    self.ground_origin = trace["position"];
    return trace["fraction"] != 0 && trace["fraction"] != 1;
}

// Namespace ball
// Params 0, eflags: 0x0
// Checksum 0x5747626b, Offset: 0x8630
// Size: 0x54
function function_85e74fc9() {
    key = "ball_score_" + self.team;
    level clientfield::set(key, !level clientfield::get(key));
}

// Namespace ball
// Params 0, eflags: 0x0
// Checksum 0x4543a745, Offset: 0x8690
// Size: 0x1e6
function function_b2a406b0() {
    if (!isdefined(level.var_665382a2)) {
        return 0;
    }
    var_41383ff5 = [];
    result = 0;
    foreach (trigger in level.var_665382a2) {
        if (!isdefined(trigger)) {
            if (!isdefined(var_41383ff5)) {
                var_41383ff5 = [];
            } else if (!isarray(var_41383ff5)) {
                var_41383ff5 = array(var_41383ff5);
            }
            var_41383ff5[var_41383ff5.size] = trigger;
            continue;
        }
        if (!trigger istriggerenabled()) {
            continue;
        }
        if (self istouching(trigger)) {
            result = 1;
            break;
        }
    }
    foreach (trigger in var_41383ff5) {
        arrayremovevalue(level.var_665382a2, trigger);
    }
    var_41383ff5 = [];
    var_41383ff5 = undefined;
    return result;
}

