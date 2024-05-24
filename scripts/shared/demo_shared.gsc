#using scripts/shared/system_shared;
#using scripts/codescripts/struct;

#namespace demo;

// Namespace demo
// Params 0, eflags: 0x2
// Checksum 0x957c388, Offset: 0xc0
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("demo", &__init__, undefined, undefined);
}

// Namespace demo
// Params 0, eflags: 0x1 linked
// Checksum 0x88053449, Offset: 0x100
// Size: 0x1c
function __init__() {
    level thread watch_actor_bookmarks();
}

// Namespace demo
// Params 3, eflags: 0x1 linked
// Checksum 0x78ed5eac, Offset: 0x128
// Size: 0x4c
function initactorbookmarkparams(killtimescount, killtimemsec, killtimedelay) {
    level.actor_bookmark_kill_times_count = killtimescount;
    level.actor_bookmark_kill_times_msec = killtimemsec;
    level.actor_bookmark_kill_times_delay = killtimedelay;
    level.actorbookmarkparamsinitialized = 1;
}

// Namespace demo
// Params 8, eflags: 0x1 linked
// Checksum 0xd1c7724, Offset: 0x180
// Size: 0x1f4
function bookmark(type, time, var_77c06e36, var_224b1b43, eventpriority, var_f3f73ee4, overrideentitycamera, var_9468a9d3) {
    mainclientnum = -1;
    otherclientnum = -1;
    inflictorentnum = -1;
    inflictorenttype = 0;
    inflictorbirthtime = 0;
    var_c354617d = undefined;
    scoreeventpriority = 0;
    if (isdefined(var_77c06e36)) {
        mainclientnum = var_77c06e36 getentitynumber();
    }
    if (isdefined(var_224b1b43)) {
        otherclientnum = var_224b1b43 getentitynumber();
    }
    if (isdefined(eventpriority)) {
        scoreeventpriority = eventpriority;
    }
    if (isdefined(var_f3f73ee4)) {
        inflictorentnum = var_f3f73ee4 getentitynumber();
        inflictorenttype = var_f3f73ee4 getentitytype();
        if (isdefined(var_f3f73ee4.birthtime)) {
            inflictorbirthtime = var_f3f73ee4.birthtime;
        }
    }
    if (!isdefined(overrideentitycamera)) {
        overrideentitycamera = 0;
    }
    if (isdefined(var_9468a9d3)) {
        var_c354617d = var_9468a9d3 getentitynumber();
    }
    adddemobookmark(type, time, mainclientnum, otherclientnum, scoreeventpriority, inflictorentnum, inflictorenttype, inflictorbirthtime, overrideentitycamera, var_c354617d);
}

// Namespace demo
// Params 3, eflags: 0x1 linked
// Checksum 0x6ecab4bf, Offset: 0x380
// Size: 0x104
function function_e2be394(type, winningteamindex, losingteamindex) {
    mainclientnum = -1;
    otherclientnum = -1;
    scoreeventpriority = 0;
    inflictorentnum = -1;
    inflictorenttype = 0;
    inflictorbirthtime = 0;
    overrideentitycamera = 0;
    var_c354617d = undefined;
    if (isdefined(winningteamindex)) {
        mainclientnum = winningteamindex;
    }
    if (isdefined(losingteamindex)) {
        otherclientnum = losingteamindex;
    }
    adddemobookmark(type, gettime(), mainclientnum, otherclientnum, scoreeventpriority, inflictorentnum, inflictorenttype, inflictorbirthtime, overrideentitycamera, var_c354617d);
}

// Namespace demo
// Params 0, eflags: 0x1 linked
// Checksum 0x1e6623ad, Offset: 0x490
// Size: 0x74
function reset_actor_bookmark_kill_times() {
    if (!isdefined(level.actorbookmarkparamsinitialized)) {
        return;
    }
    if (!isdefined(self.actor_bookmark_kill_times)) {
        self.actor_bookmark_kill_times = [];
        self.ignore_actor_kill_times = 0;
    }
    for (i = 0; i < level.actor_bookmark_kill_times_count; i++) {
        self.actor_bookmark_kill_times[i] = 0;
    }
}

// Namespace demo
// Params 0, eflags: 0x1 linked
// Checksum 0x1a208869, Offset: 0x510
// Size: 0xf2
function add_actor_bookmark_kill_time() {
    if (!isdefined(level.actorbookmarkparamsinitialized)) {
        return;
    }
    now = gettime();
    if (now <= self.ignore_actor_kill_times) {
        return;
    }
    oldest_index = 0;
    oldest_time = now + 1;
    for (i = 0; i < level.actor_bookmark_kill_times_count; i++) {
        if (!self.actor_bookmark_kill_times[i]) {
            oldest_index = i;
            break;
        }
        if (oldest_time > self.actor_bookmark_kill_times[i]) {
            oldest_index = i;
            oldest_time = self.actor_bookmark_kill_times[i];
        }
    }
    self.actor_bookmark_kill_times[oldest_index] = now;
}

// Namespace demo
// Params 0, eflags: 0x1 linked
// Checksum 0xde0286c9, Offset: 0x610
// Size: 0x1f6
function watch_actor_bookmarks() {
    while (true) {
        if (!isdefined(level.actorbookmarkparamsinitialized)) {
            wait(0.5);
            continue;
        }
        wait(0.05);
        waittillframeend();
        now = gettime();
        oldest_allowed = now - level.actor_bookmark_kill_times_msec;
        players = getplayers();
        for (player_index = 0; player_index < players.size; player_index++) {
            player = players[player_index];
            /#
                if (isdefined(player.pers["<unknown string>"]) && player.pers["<unknown string>"]) {
                    continue;
                }
            #/
            for (time_index = 0; time_index < level.actor_bookmark_kill_times_count; time_index++) {
                if (!isdefined(player.actor_bookmark_kill_times) || !player.actor_bookmark_kill_times[time_index]) {
                    break;
                }
                if (oldest_allowed > player.actor_bookmark_kill_times[time_index]) {
                    player.actor_bookmark_kill_times[time_index] = 0;
                    break;
                }
            }
            if (time_index >= level.actor_bookmark_kill_times_count) {
                bookmark("actor_kill", gettime(), player);
                player reset_actor_bookmark_kill_times();
                player.ignore_actor_kill_times = now + level.actor_bookmark_kill_times_delay;
            }
        }
    }
}

