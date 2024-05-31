#using scripts/zm/_util;
#using scripts/zm/gametypes/_spawnlogic;
#using scripts/zm/gametypes/_globallogic_utils;
#using scripts/zm/gametypes/_globallogic_score;
#using scripts/zm/gametypes/_globallogic_audio;
#using scripts/zm/gametypes/_globallogic;
#using scripts/shared/math_shared;
#using scripts/codescripts/struct;

#namespace globallogic_defaults;

// Namespace globallogic_defaults
// Params 1, eflags: 0x1 linked
// namespace_5deb553<file_0>::function_79d6ccd1
// Checksum 0x14d14d3d, Offset: 0x2b0
// Size: 0x32
function getwinningteamfromloser(losing_team) {
    if (level.multiteam) {
        return "tie";
    }
    return util::getotherteam(losing_team);
}

// Namespace globallogic_defaults
// Params 1, eflags: 0x1 linked
// namespace_5deb553<file_0>::function_7a7141a5
// Checksum 0xae330b20, Offset: 0x2f0
// Size: 0x2c4
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
    if (!isdefined(team)) {
        setdvar("ui_text_endreason", game["strings"]["players_forfeited"]);
        endreason = game["strings"]["players_forfeited"];
        winner = level.players[0];
    } else if (isdefined(level.teams[team])) {
        endreason = game["strings"][team + "_forfeited"];
        setdvar("ui_text_endreason", endreason);
        winner = getwinningteamfromloser(team);
    } else {
        assert(isdefined(team), "team eliminated");
        assert(0, "team eliminated" + team + "team eliminated");
        winner = "tie";
    }
    level.forcedend = 1;
    /#
        if (isplayer(winner)) {
            print("team eliminated" + winner getxuid() + "team eliminated" + winner.name + "team eliminated");
        } else {
            globallogic_utils::logteamwinstring("team eliminated", winner);
        }
    #/
    thread globallogic::endgame(winner, endreason);
}

// Namespace globallogic_defaults
// Params 1, eflags: 0x1 linked
// namespace_5deb553<file_0>::function_d617fe3e
// Checksum 0x5fbead3, Offset: 0x5c0
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
// namespace_5deb553<file_0>::function_c4c198b0
// Checksum 0x4f978bc1, Offset: 0x750
// Size: 0xc
function default_onalivecountchange(team) {
    
}

// Namespace globallogic_defaults
// Params 1, eflags: 0x1 linked
// namespace_5deb553<file_0>::function_aca983ed
// Checksum 0xccd9333a, Offset: 0x768
// Size: 0x10
function default_onroundendgame(winner) {
    return winner;
}

// Namespace globallogic_defaults
// Params 1, eflags: 0x1 linked
// namespace_5deb553<file_0>::function_6ab3de3d
// Checksum 0xb23bc7ee, Offset: 0x780
// Size: 0x16e
function default_ononeleftevent(team) {
    if (!level.teambased) {
        winner = globallogic_score::gethighestscoringplayer();
        /#
            if (isdefined(winner)) {
                print("team eliminated" + winner.name);
            } else {
                print("team eliminated");
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
        player globallogic_audio::leaderdialogonplayer("sudden_death");
    }
}

// Namespace globallogic_defaults
// Params 0, eflags: 0x1 linked
// namespace_5deb553<file_0>::function_3c98c1e8
// Checksum 0x49f6d004, Offset: 0x8f8
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
                print("team eliminated" + winner.name);
            } else {
                print("team eliminated");
            }
        #/
    }
    setdvar("ui_text_endreason", game["strings"]["time_limit_reached"]);
    thread globallogic::endgame(winner, game["strings"]["time_limit_reached"]);
}

// Namespace globallogic_defaults
// Params 0, eflags: 0x1 linked
// namespace_5deb553<file_0>::function_8455a753
// Checksum 0x97efaffd, Offset: 0xa28
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
                print("team eliminated" + winner.name);
            } else {
                print("team eliminated");
            }
        #/
    }
    setdvar("ui_text_endreason", game["strings"]["score_limit_reached"]);
    thread globallogic::endgame(winner, game["strings"]["score_limit_reached"]);
    return true;
}

// Namespace globallogic_defaults
// Params 2, eflags: 0x1 linked
// namespace_5deb553<file_0>::function_3127df38
// Checksum 0x8cf46196, Offset: 0xb68
// Size: 0xfc
function default_onspawnspectator(origin, angles) {
    if (isdefined(origin) && isdefined(angles)) {
        self spawn(origin, angles);
        return;
    }
    spawnpointname = "mp_global_intermission";
    spawnpoints = getentarray(spawnpointname, "classname");
    assert(spawnpoints.size, "team eliminated");
    spawnpoint = spawnlogic::getspawnpoint_random(spawnpoints);
    self spawn(spawnpoint.origin, spawnpoint.angles);
}

// Namespace globallogic_defaults
// Params 0, eflags: 0x1 linked
// namespace_5deb553<file_0>::function_91904565
// Checksum 0x36a195a3, Offset: 0xc70
// Size: 0xbc
function default_onspawnintermission() {
    spawnpointname = "mp_global_intermission";
    spawnpoints = getentarray(spawnpointname, "classname");
    spawnpoint = spawnpoints[0];
    if (isdefined(spawnpoint)) {
        self spawn(spawnpoint.origin, spawnpoint.angles);
        return;
    }
    /#
        util::error("team eliminated" + spawnpointname + "team eliminated");
    #/
}

// Namespace globallogic_defaults
// Params 0, eflags: 0x1 linked
// namespace_5deb553<file_0>::function_3d887edf
// Checksum 0xed10c520, Offset: 0xd38
// Size: 0x3a
function default_gettimelimit() {
    return math::clamp(getgametypesetting("timeLimit"), level.timelimitmin, level.timelimitmax);
}

