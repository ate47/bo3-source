#using scripts/mp/_util;
#using scripts/mp/gametypes/_globallogic_utils;
#using scripts/shared/util_shared;
#using scripts/codescripts/struct;

#namespace events;

// Namespace events
// Params 3, eflags: 0x1 linked
// namespace_3a71f14e<file_0>::function_e5c60443
// Checksum 0xd51a2c92, Offset: 0x100
// Size: 0x6c
function add_timed_event(seconds, notify_string, client_notify_string) {
    assert(seconds >= 0);
    if (level.timelimit > 0) {
        level thread timed_event_monitor(seconds, notify_string, client_notify_string);
    }
}

// Namespace events
// Params 3, eflags: 0x1 linked
// namespace_3a71f14e<file_0>::function_615a6064
// Checksum 0x4ff4517e, Offset: 0x178
// Size: 0x9a
function timed_event_monitor(seconds, notify_string, client_notify_string) {
    for (;;) {
        wait(0.5);
        if (!isdefined(level.starttime)) {
            continue;
        }
        millisecs_remaining = globallogic_utils::gettimeremaining();
        seconds_remaining = millisecs_remaining / 1000;
        if (seconds_remaining <= seconds) {
            event_notify(notify_string, client_notify_string);
            return;
        }
    }
}

// Namespace events
// Params 3, eflags: 0x1 linked
// namespace_3a71f14e<file_0>::function_1813164
// Checksum 0x67f395e3, Offset: 0x220
// Size: 0x9c
function add_score_event(score, notify_string, client_notify_string) {
    assert(score >= 0);
    if (level.scorelimit > 0) {
        if (level.teambased) {
            level thread score_team_event_monitor(score, notify_string, client_notify_string);
            return;
        }
        level thread score_event_monitor(score, notify_string, client_notify_string);
    }
}

// Namespace events
// Params 3, eflags: 0x1 linked
// namespace_3a71f14e<file_0>::function_ccb5381
// Checksum 0x9fdf7685, Offset: 0x2c8
// Size: 0xc4
function add_round_score_event(score, notify_string, client_notify_string) {
    assert(score >= 0);
    if (level.roundscorelimit > 0) {
        roundscoretobeat = level.roundscorelimit * game["roundsplayed"] + score;
        if (level.teambased) {
            level thread score_team_event_monitor(roundscoretobeat, notify_string, client_notify_string);
            return;
        }
        level thread score_event_monitor(roundscoretobeat, notify_string, client_notify_string);
    }
}

// Namespace events
// Params 1, eflags: 0x1 linked
// namespace_3a71f14e<file_0>::function_c8542448
// Checksum 0x38156e6c, Offset: 0x398
// Size: 0xa0
function any_team_reach_score(score) {
    foreach (team in level.teams) {
        if (game["teamScores"][team] >= score) {
            return true;
        }
    }
    return false;
}

// Namespace events
// Params 3, eflags: 0x1 linked
// namespace_3a71f14e<file_0>::function_515a1fed
// Checksum 0xa5e0a35d, Offset: 0x440
// Size: 0x62
function score_team_event_monitor(score, notify_string, client_notify_string) {
    for (;;) {
        wait(0.5);
        if (any_team_reach_score(score)) {
            event_notify(notify_string, client_notify_string);
            return;
        }
    }
}

// Namespace events
// Params 3, eflags: 0x1 linked
// namespace_3a71f14e<file_0>::function_8d1b4847
// Checksum 0x5076a8f, Offset: 0x4b0
// Size: 0xbc
function score_event_monitor(score, notify_string, client_notify_string) {
    for (;;) {
        wait(0.5);
        players = getplayers();
        for (i = 0; i < players.size; i++) {
            if (isdefined(players[i].score) && players[i].score >= score) {
                event_notify(notify_string, client_notify_string);
                return;
            }
        }
    }
}

// Namespace events
// Params 2, eflags: 0x1 linked
// namespace_3a71f14e<file_0>::function_b9197739
// Checksum 0x1d70fbda, Offset: 0x578
// Size: 0x4c
function event_notify(notify_string, client_notify_string) {
    if (isdefined(notify_string)) {
        level notify(notify_string);
    }
    if (isdefined(client_notify_string)) {
        util::clientnotify(client_notify_string);
    }
}

