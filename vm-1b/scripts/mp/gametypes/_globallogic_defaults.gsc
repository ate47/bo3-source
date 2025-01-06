#using scripts/codescripts/struct;
#using scripts/mp/_util;
#using scripts/mp/gametypes/_globallogic;
#using scripts/mp/gametypes/_globallogic_audio;
#using scripts/mp/gametypes/_globallogic_score;
#using scripts/mp/gametypes/_globallogic_utils;
#using scripts/mp/gametypes/_spawnlogic;
#using scripts/mp/killstreaks/_killstreaks;
#using scripts/shared/killstreaks_shared;
#using scripts/shared/math_shared;
#using scripts/shared/rank_shared;

#namespace globallogic_defaults;

// Namespace globallogic_defaults
// Params 1, eflags: 0x0
// Checksum 0xddb9172, Offset: 0x370
// Size: 0x31
function getwinningteamfromloser(losing_team) {
    if (level.multiteam) {
        return "tie";
    }
    return util::getotherteam(losing_team);
}

// Namespace globallogic_defaults
// Params 1, eflags: 0x0
// Checksum 0x7e7f107b, Offset: 0x3b0
// Size: 0x5d
function default_onforfeit(team) {
    level.gameforfeited = 1;
    level notify(#"hash_d343f3a0");
    level endon(#"hash_d343f3a0");
    level endon(#"hash_577494dc");
    forfeit_delay = 20;
    InvalidOpCode(0x54, "strings", "opponent_forfeiting_in", forfeit_delay, 0);
    // Unknown operator (0x54, t7_1b, PC)
}

// Namespace globallogic_defaults
// Params 1, eflags: 0x0
// Checksum 0xfcadf5e3, Offset: 0x630
// Size: 0xb5
function default_ondeadevent(team) {
    if (isdefined(level.teams[team])) {
        InvalidOpCode(0x54, "strings", team + "_eliminated");
        // Unknown operator (0x54, t7_1b, PC)
    }
    InvalidOpCode(0x54, "strings", "tie");
    // Unknown operator (0x54, t7_1b, PC)
}

// Namespace globallogic_defaults
// Params 1, eflags: 0x0
// Checksum 0x752f50a2, Offset: 0x778
// Size: 0xb5
function function_45c10f52(team) {
    if (isdefined(level.teams[team])) {
        InvalidOpCode(0x54, "strings", "enemies_eliminated");
        // Unknown operator (0x54, t7_1b, PC)
    }
    InvalidOpCode(0x54, "strings", "tie");
    // Unknown operator (0x54, t7_1b, PC)
}

// Namespace globallogic_defaults
// Params 1, eflags: 0x0
// Checksum 0x584adaeb, Offset: 0x8c0
// Size: 0xa
function default_onalivecountchange(team) {
    
}

// Namespace globallogic_defaults
// Params 1, eflags: 0x0
// Checksum 0x9c47f8f, Offset: 0x8d8
// Size: 0xc
function default_onroundendgame(winner) {
    return winner;
}

// Namespace globallogic_defaults
// Params 1, eflags: 0x0
// Checksum 0x5b5bdf6a, Offset: 0x8f0
// Size: 0x121
function default_ononeleftevent(team) {
    if (!level.teambased) {
        winner = globallogic_score::gethighestscoringplayer();
        /#
            if (isdefined(winner)) {
                print("<dev string:x88>" + winner.name);
            } else {
                print("<dev string:x9e>");
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
// Params 0, eflags: 0x0
// Checksum 0xb46968d4, Offset: 0xa20
// Size: 0xa9
function default_ontimelimit() {
    winner = undefined;
    if (level.teambased) {
        winner = globallogic::determineteamwinnerbygamestat("teamScores");
        globallogic_utils::logteamwinstring("time limit", winner);
    } else {
        winner = globallogic_score::gethighestscoringplayer();
        /#
            if (isdefined(winner)) {
                print("<dev string:xbb>" + winner.name);
            } else {
                print("<dev string:xcd>");
            }
        #/
    }
    InvalidOpCode(0x54, "strings", "time_limit_reached");
    // Unknown operator (0x54, t7_1b, PC)
}

// Namespace globallogic_defaults
// Params 0, eflags: 0x0
// Checksum 0x67799bc6, Offset: 0xb10
// Size: 0xb1
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
                print("<dev string:xdd>" + winner.name);
            } else {
                print("<dev string:xef>");
            }
        #/
    }
    InvalidOpCode(0x54, "strings", "score_limit_reached");
    // Unknown operator (0x54, t7_1b, PC)
}

// Namespace globallogic_defaults
// Params 0, eflags: 0x0
// Checksum 0x823750ad, Offset: 0xc08
// Size: 0xa9
function default_onroundscorelimit() {
    winner = undefined;
    if (level.teambased) {
        winner = globallogic::determineteamwinnerbygamestat("teamScores");
        globallogic_utils::logteamwinstring("roundscorelimit", winner);
    } else {
        winner = globallogic_score::gethighestscoringplayer();
        /#
            if (isdefined(winner)) {
                print("<dev string:xff>" + winner.name);
            } else {
                print("<dev string:x116>");
            }
        #/
    }
    InvalidOpCode(0x54, "strings", "round_score_limit_reached");
    // Unknown operator (0x54, t7_1b, PC)
}

// Namespace globallogic_defaults
// Params 2, eflags: 0x0
// Checksum 0xf437b997, Offset: 0xcf8
// Size: 0xaa
function default_onspawnspectator(origin, angles) {
    if (isdefined(origin) && isdefined(angles)) {
        self spawn(origin, angles);
        return;
    }
    spawnpoints = spawnlogic::function_12d810b4("mp_global_intermission");
    assert(spawnpoints.size, "<dev string:x12b>");
    spawnpoint = spawnlogic::get_spawnpoint_random(spawnpoints);
    self spawn(spawnpoint.origin, spawnpoint.angles);
}

// Namespace globallogic_defaults
// Params 1, eflags: 0x0
// Checksum 0x79b98485, Offset: 0xdb0
// Size: 0x7a
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
        util::error("<dev string:x185>");
    #/
}

// Namespace globallogic_defaults
// Params 0, eflags: 0x0
// Checksum 0xb8af2983, Offset: 0xe38
// Size: 0x39
function default_gettimelimit() {
    return math::clamp(getgametypesetting("timeLimit"), level.timelimitmin, level.timelimitmax);
}

// Namespace globallogic_defaults
// Params 4, eflags: 0x0
// Checksum 0x3744662, Offset: 0xe80
// Size: 0x5f
function default_getteamkillpenalty(einflictor, attacker, smeansofdeath, weapon) {
    teamkill_penalty = 1;
    if (killstreaks::is_killstreak_weapon(weapon)) {
        teamkill_penalty *= killstreaks::get_killstreak_team_kill_penalty_scale(weapon);
    }
    return teamkill_penalty;
}

// Namespace globallogic_defaults
// Params 4, eflags: 0x0
// Checksum 0x7d94d736, Offset: 0xee8
// Size: 0x39
function default_getteamkillscore(einflictor, attacker, smeansofdeath, weapon) {
    return rank::getscoreinfovalue("team_kill");
}

