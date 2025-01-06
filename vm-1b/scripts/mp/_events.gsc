#using scripts/codescripts/struct;
#using scripts/mp/_util;
#using scripts/mp/gametypes/_globallogic_utils;
#using scripts/shared/util_shared;

#namespace events;

// Namespace events
// Params 3, eflags: 0x0
// Checksum 0xb864567a, Offset: 0xf8
// Size: 0x52
function add_timed_event(seconds, notify_string, client_notify_string) {
    assert(seconds >= 0);
    if (level.timelimit > 0) {
        level thread timed_event_monitor(seconds, notify_string, client_notify_string);
    }
}

// Namespace events
// Params 3, eflags: 0x0
// Checksum 0x2b206f2f, Offset: 0x158
// Size: 0x7f
function timed_event_monitor(seconds, notify_string, client_notify_string) {
    for (;;) {
        wait 0.5;
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
// Params 3, eflags: 0x0
// Checksum 0x2933f9df, Offset: 0x1e0
// Size: 0x7a
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
// Params 1, eflags: 0x0
// Checksum 0xd63e8d99, Offset: 0x268
// Size: 0x70
function any_team_reach_score(score) {
    var_7d463f1a = level.teams;
    var_56a0317c = firstarray(var_7d463f1a);
    if (isdefined(var_56a0317c)) {
        team = var_7d463f1a[var_56a0317c];
        var_b1e4dac1 = nextarray(var_7d463f1a, var_56a0317c);
        InvalidOpCode(0x54, "teamScores", team);
        // Unknown operator (0x54, t7_1b, PC)
    }
    return false;
}

// Namespace events
// Params 3, eflags: 0x0
// Checksum 0x3d33865b, Offset: 0x2e0
// Size: 0x4f
function score_team_event_monitor(score, notify_string, client_notify_string) {
    for (;;) {
        wait 0.5;
        if (any_team_reach_score(score)) {
            event_notify(notify_string, client_notify_string);
            return;
        }
    }
}

// Namespace events
// Params 3, eflags: 0x0
// Checksum 0x2465d181, Offset: 0x338
// Size: 0x95
function score_event_monitor(score, notify_string, client_notify_string) {
    for (;;) {
        wait 0.5;
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
// Params 2, eflags: 0x0
// Checksum 0x79c6803a, Offset: 0x3d8
// Size: 0x3a
function event_notify(notify_string, client_notify_string) {
    if (isdefined(notify_string)) {
        level notify(notify_string);
    }
    if (isdefined(client_notify_string)) {
        util::clientnotify(client_notify_string);
    }
}

