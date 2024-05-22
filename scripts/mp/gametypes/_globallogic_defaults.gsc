#using scripts/mp/killstreaks/_killstreaks;
#using scripts/mp/_util;
#using scripts/mp/gametypes/_spawnlogic;
#using scripts/mp/gametypes/_globallogic_utils;
#using scripts/mp/gametypes/_globallogic_score;
#using scripts/mp/gametypes/_globallogic_audio;
#using scripts/mp/gametypes/_globallogic;
#using scripts/shared/rank_shared;
#using scripts/shared/math_shared;
#using scripts/shared/killstreaks_shared;
#using scripts/codescripts/struct;

#namespace globallogic_defaults;

// Namespace globallogic_defaults
// Params 1, eflags: 0x1 linked
// Checksum 0x8df8b8f1, Offset: 0x398
// Size: 0x32
function getwinningteamfromloser(losing_team) {
    if (level.multiteam) {
        return "tie";
    }
    return util::getotherteam(losing_team);
}

// Namespace globallogic_defaults
// Params 1, eflags: 0x1 linked
// Checksum 0xfb1ea538, Offset: 0x3d8
// Size: 0x324
function default_onforfeit(team) {
    level.gameforfeited = 1;
    level notify(#"hash_d343f3a0");
    level endon(#"hash_d343f3a0");
    level endon(#"hash_577494dc");
    forfeit_delay = 20;
    announcement(game["strings"]["opponent_forfeiting_in"], forfeit_delay, 0);
    wait(10);
    announcement(game["strings"]["opponent_forfeiting_in"], 10, 0);
    wait(10);
    endreason = %;
    if (level.multiteam) {
        setdvar("ui_text_endreason", game["strings"]["other_teams_forfeited"]);
        endreason = game["strings"]["other_teams_forfeited"];
        winner = team;
    } else if (!isdefined(team)) {
        setdvar("ui_text_endreason", game["strings"]["players_forfeited"]);
        endreason = game["strings"]["players_forfeited"];
        winner = level.players[0];
    } else if (isdefined(level.teams[team])) {
        endreason = game["strings"][team + "_forfeited"];
        setdvar("ui_text_endreason", endreason);
        winner = getwinningteamfromloser(team);
    } else {
        /#
            assert(isdefined(team), "_eliminated");
        #/
        /#
            assert(0, "_eliminated" + team + "_eliminated");
        #/
        winner = "tie";
    }
    level.forcedend = 1;
    /#
        if (isplayer(winner)) {
            print("_eliminated" + winner getxuid() + "_eliminated" + winner.name + "_eliminated");
        } else {
            globallogic_utils::logteamwinstring("_eliminated", winner);
        }
    #/
    thread globallogic::endgame(winner, endreason);
}

// Namespace globallogic_defaults
// Params 1, eflags: 0x0
// Checksum 0xb6c86efe, Offset: 0x708
// Size: 0x184
function default_ondeadevent(team) {
    if (isdefined(level.teams[team])) {
        eliminatedstring = game["strings"][team + "_eliminated"];
        iprintln(eliminatedstring);
        setdvar("ui_text_endreason", eliminatedstring);
        winner = getwinningteamfromloser(team);
        globallogic_utils::logteamwinstring("team eliminated", winner);
        thread globallogic::endgame(winner, eliminatedstring);
        return;
    }
    setdvar("ui_text_endreason", game["strings"]["tie"]);
    globallogic_utils::logteamwinstring("tie");
    if (level.teambased) {
        thread globallogic::endgame("tie", game["strings"]["tie"]);
        return;
    }
    thread globallogic::endgame(undefined, game["strings"]["tie"]);
}

// Namespace globallogic_defaults
// Params 1, eflags: 0x1 linked
// Checksum 0x5c855532, Offset: 0x898
// Size: 0x184
function function_45c10f52(team) {
    if (isdefined(level.teams[team])) {
        eliminatedstring = game["strings"]["enemies_eliminated"];
        iprintln(eliminatedstring);
        setdvar("ui_text_endreason", eliminatedstring);
        winner = globallogic::determineteamwinnerbygamestat("teamScores");
        globallogic_utils::logteamwinstring("team eliminated", winner);
        thread globallogic::endgame(winner, eliminatedstring);
        return;
    }
    setdvar("ui_text_endreason", game["strings"]["tie"]);
    globallogic_utils::logteamwinstring("tie");
    if (level.teambased) {
        thread globallogic::endgame("tie", game["strings"]["tie"]);
        return;
    }
    thread globallogic::endgame(undefined, game["strings"]["tie"]);
}

// Namespace globallogic_defaults
// Params 1, eflags: 0x1 linked
// Checksum 0x4962028e, Offset: 0xa28
// Size: 0xc
function default_onalivecountchange(team) {
    
}

// Namespace globallogic_defaults
// Params 1, eflags: 0x1 linked
// Checksum 0x514cb902, Offset: 0xa40
// Size: 0x10
function default_onroundendgame(winner) {
    return winner;
}

// Namespace globallogic_defaults
// Params 1, eflags: 0x1 linked
// Checksum 0xb8c6adc2, Offset: 0xa58
// Size: 0xb4
function function_417075b7(roundwinner) {
    if (isdefined(game["overtime_round"])) {
        if (isdefined(level.doubleovertime) && level.doubleovertime && isdefined(roundwinner) && roundwinner != "tie") {
            return roundwinner;
        }
        return globallogic::determineteamwinnerbygamestat("overtimeroundswon");
    }
    if (level.scoreroundwinbased) {
        winner = globallogic::determineteamwinnerbygamestat("roundswon");
    } else {
        winner = globallogic::determineteamwinnerbyteamscore();
    }
    return winner;
}

// Namespace globallogic_defaults
// Params 1, eflags: 0x1 linked
// Checksum 0xaafa2d5, Offset: 0xb18
// Size: 0x16e
function default_ononeleftevent(team) {
    if (!level.teambased) {
        winner = globallogic_score::gethighestscoringplayer();
        /#
            if (isdefined(winner)) {
                print("_eliminated" + winner.name);
            } else {
                print("_eliminated");
            }
        #/
        thread globallogic::endgame(winner, %MP_ENEMIES_ELIMINATED);
        return;
    }
    for (index = 0; index < level.players.size; index++) {
        player = level.players[index];
        if (!isalive(player)) {
            continue;
        }
        if (!isdefined(player.pers["team"]) || player.pers["team"] != team) {
            continue;
        }
        player globallogic_audio::leader_dialog_on_player("sudden_death");
    }
}

// Namespace globallogic_defaults
// Params 0, eflags: 0x1 linked
// Checksum 0xe8ca93a2, Offset: 0xc90
// Size: 0x124
function default_ontimelimit() {
    winner = undefined;
    if (level.teambased) {
        winner = globallogic::determineteamwinnerbygamestat("teamScores");
        globallogic_utils::logteamwinstring("time limit", winner);
    } else {
        winner = globallogic_score::gethighestscoringplayer();
        /#
            if (isdefined(winner)) {
                print("_eliminated" + winner.name);
            } else {
                print("_eliminated");
            }
        #/
    }
    setdvar("ui_text_endreason", game["strings"]["time_limit_reached"]);
    thread globallogic::endgame(winner, game["strings"]["time_limit_reached"]);
}

// Namespace globallogic_defaults
// Params 0, eflags: 0x1 linked
// Checksum 0x8744e956, Offset: 0xdc0
// Size: 0x138
function default_onscorelimit() {
    if (!level.endgameonscorelimit) {
        return false;
    }
    winner = undefined;
    if (level.teambased) {
        winner = globallogic::determineteamwinnerbygamestat("teamScores");
        globallogic_utils::logteamwinstring("scorelimit", winner);
    } else {
        winner = globallogic_score::gethighestscoringplayer();
        /#
            if (isdefined(winner)) {
                print("_eliminated" + winner.name);
            } else {
                print("_eliminated");
            }
        #/
    }
    setdvar("ui_text_endreason", game["strings"]["score_limit_reached"]);
    thread globallogic::endgame(winner, game["strings"]["score_limit_reached"]);
    return true;
}

// Namespace globallogic_defaults
// Params 0, eflags: 0x1 linked
// Checksum 0xc38e51e7, Offset: 0xf00
// Size: 0x128
function default_onroundscorelimit() {
    winner = undefined;
    if (level.teambased) {
        winner = globallogic::determineteamwinnerbygamestat("teamScores");
        globallogic_utils::logteamwinstring("roundscorelimit", winner);
    } else {
        winner = globallogic_score::gethighestscoringplayer();
        /#
            if (isdefined(winner)) {
                print("_eliminated" + winner.name);
            } else {
                print("_eliminated");
            }
        #/
    }
    setdvar("ui_text_endreason", game["strings"]["round_score_limit_reached"]);
    thread globallogic::endgame(winner, game["strings"]["round_score_limit_reached"]);
    return true;
}

// Namespace globallogic_defaults
// Params 2, eflags: 0x1 linked
// Checksum 0x9cfe9988, Offset: 0x1030
// Size: 0xdc
function default_onspawnspectator(origin, angles) {
    if (isdefined(origin) && isdefined(angles)) {
        self spawn(origin, angles);
        return;
    }
    spawnpoints = spawnlogic::function_12d810b4("mp_global_intermission");
    /#
        assert(spawnpoints.size, "_eliminated");
    #/
    spawnpoint = spawnlogic::get_spawnpoint_random(spawnpoints);
    self spawn(spawnpoint.origin, spawnpoint.angles);
}

// Namespace globallogic_defaults
// Params 1, eflags: 0x1 linked
// Checksum 0x1add1c18, Offset: 0x1118
// Size: 0x9c
function default_onspawnintermission(endgame) {
    if (isdefined(endgame) && endgame) {
        return;
    }
    spawnpoint = spawnlogic::get_random_intermission_point();
    if (isdefined(spawnpoint)) {
        self spawn(spawnpoint.origin, spawnpoint.angles);
        return;
    }
    /#
        util::error("_eliminated");
    #/
}

// Namespace globallogic_defaults
// Params 0, eflags: 0x1 linked
// Checksum 0xf0091284, Offset: 0x11c0
// Size: 0x3a
function default_gettimelimit() {
    return math::clamp(getgametypesetting("timeLimit"), level.timelimitmin, level.timelimitmax);
}

// Namespace globallogic_defaults
// Params 4, eflags: 0x1 linked
// Checksum 0x58cbc9f, Offset: 0x1208
// Size: 0x76
function default_getteamkillpenalty(einflictor, attacker, smeansofdeath, weapon) {
    teamkill_penalty = 1;
    if (killstreaks::is_killstreak_weapon(weapon)) {
        teamkill_penalty *= killstreaks::get_killstreak_team_kill_penalty_scale(weapon);
    }
    return teamkill_penalty;
}

// Namespace globallogic_defaults
// Params 4, eflags: 0x1 linked
// Checksum 0x7d4ffa17, Offset: 0x1288
// Size: 0x3a
function default_getteamkillscore(einflictor, attacker, smeansofdeath, weapon) {
    return rank::getscoreinfovalue("team_kill");
}

