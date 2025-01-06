#using scripts/mp/_armor;
#using scripts/mp/_behavior_tracker;
#using scripts/mp/_challenges;
#using scripts/mp/_gamerep;
#using scripts/mp/_laststand;
#using scripts/mp/_teamops;
#using scripts/mp/_util;
#using scripts/mp/_vehicle;
#using scripts/mp/gametypes/_battlechatter;
#using scripts/mp/gametypes/_deathicons;
#using scripts/mp/gametypes/_globallogic;
#using scripts/mp/gametypes/_globallogic_audio;
#using scripts/mp/gametypes/_globallogic_score;
#using scripts/mp/gametypes/_globallogic_spawn;
#using scripts/mp/gametypes/_globallogic_ui;
#using scripts/mp/gametypes/_globallogic_utils;
#using scripts/mp/gametypes/_globallogic_vehicle;
#using scripts/mp/gametypes/_hostmigration;
#using scripts/mp/gametypes/_hud_message;
#using scripts/mp/gametypes/_killcam;
#using scripts/mp/gametypes/_loadout;
#using scripts/mp/gametypes/_spawning;
#using scripts/mp/gametypes/_spawnlogic;
#using scripts/mp/gametypes/_spectating;
#using scripts/mp/gametypes/_weapons;
#using scripts/mp/killstreaks/_killstreaks;
#using scripts/mp/teams/_teams;
#using scripts/shared/_burnplayer;
#using scripts/shared/abilities/_ability_player;
#using scripts/shared/abilities/_ability_power;
#using scripts/shared/abilities/_ability_util;
#using scripts/shared/ai/systems/gib;
#using scripts/shared/callbacks_shared;
#using scripts/shared/challenges_shared;
#using scripts/shared/damagefeedback_shared;
#using scripts/shared/demo_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/hostmigration_shared;
#using scripts/shared/hud_message_shared;
#using scripts/shared/hud_util_shared;
#using scripts/shared/killstreaks_shared;
#using scripts/shared/math_shared;
#using scripts/shared/medals_shared;
#using scripts/shared/persistence_shared;
#using scripts/shared/player_shared;
#using scripts/shared/rank_shared;
#using scripts/shared/scoreevents_shared;
#using scripts/shared/tweakables_shared;
#using scripts/shared/util_shared;
#using scripts/shared/weapons/_weapon_utils;
#using scripts/shared/weapons/_weapons;
#using scripts/shared/weapons_shared;

#namespace globallogic_player;

// Namespace globallogic_player
// Params 0, eflags: 0x0
// Checksum 0x7c005fba, Offset: 0x1a60
// Size: 0x8a
function freezeplayerforroundend() {
    self util::clearlowermessage();
    self closeingamemenu();
    self util::freeze_player_controls(1);
    if (!sessionmodeiszombiesgame()) {
        currentweapon = self getcurrentweapon();
        if (killstreaks::is_killstreak_weapon(currentweapon) && !currentweapon.iscarriedkillstreak) {
            self takeweapon(currentweapon);
        }
    }
}

// Namespace globallogic_player
// Params 0, eflags: 0x0
// Checksum 0x685945c0, Offset: 0x1af8
// Size: 0xff
function player_monitor_travel_dist() {
    self endon(#"death");
    self endon(#"disconnect");
    minimummovedistance = 10;
    for (prevpos = self.origin; true; prevpos = self.origin) {
        wait 0.5;
        distance = distance(self.origin, prevpos);
        if (distance > minimummovedistance) {
            self.pers["time_played_moving"] = self.pers["time_played_moving"] + 0.5;
            self.pers["total_speeds_when_moving"] = self.pers["total_speeds_when_moving"] + distance / 0.5;
            self.pers["num_speeds_when_moving_entries"]++;
            self.pers["total_distance_travelled"] = self.pers["total_distance_travelled"] + distance;
        }
    }
}

// Namespace globallogic_player
// Params 1, eflags: 0x0
// Checksum 0x84e8ad84, Offset: 0x1c00
// Size: 0xe7
function record_special_move_data_for_life(killer) {
    if (!isdefined(self.lastswimmingstarttime) || !isdefined(self.lastwallrunstarttime) || !isdefined(self.lastslidestarttime) || !isdefined(self.lastdoublejumpstarttime) || !isdefined(self.timespentswimminginlife) || !isdefined(self.timespentwallrunninginlife) || !isdefined(self.numberofdoublejumpsinlife) || !isdefined(self.numberofslidesinlife)) {
        println("<dev string:x28>");
        return;
    }
    if (isdefined(killer)) {
        if (!isdefined(killer.lastswimmingstarttime) || !isdefined(killer.lastwallrunstarttime) || !isdefined(killer.lastslidestarttime) || !isdefined(killer.lastdoublejumpstarttime)) {
            println("<dev string:x68>");
            return;
        }
    }
}

// Namespace globallogic_player
// Params 0, eflags: 0x0
// Checksum 0xb5ab30f2, Offset: 0x1cf0
// Size: 0xb5
function function_716b3fd6() {
    self endon(#"disconnect");
    self notify(#"stop_player_monitor_wall_run");
    self endon(#"stop_player_monitor_wall_run");
    self.lastwallrunstarttime = 0;
    self.timespentwallrunninginlife = 0;
    while (true) {
        notification = self util::waittill_any_return("wallrun_begin", "death");
        if (notification == "death") {
            break;
        }
        self.lastwallrunstarttime = gettime();
        notification = self util::waittill_any_return("wallrun_end", "death");
        self.timespentwallrunninginlife = self.timespentwallrunninginlife + gettime() - self.lastwallrunstarttime;
        if (notification == "death") {
            break;
        }
    }
}

// Namespace globallogic_player
// Params 0, eflags: 0x0
// Checksum 0xe58b4bf8, Offset: 0x1db0
// Size: 0xb5
function function_64aa4793() {
    self endon(#"disconnect");
    self notify(#"stop_player_monitor_swimming");
    self endon(#"stop_player_monitor_swimming");
    self.lastswimmingstarttime = 0;
    self.timespentswimminginlife = 0;
    while (true) {
        notification = self util::waittill_any_return("swimming_begin", "death");
        if (notification == "death") {
            break;
        }
        self.lastswimmingstarttime = gettime();
        notification = self util::waittill_any_return("swimming_end", "death");
        self.timespentswimminginlife = self.timespentswimminginlife + gettime() - self.lastswimmingstarttime;
        if (notification == "death") {
            break;
        }
    }
}

// Namespace globallogic_player
// Params 0, eflags: 0x0
// Checksum 0x73dc84ad, Offset: 0x1e70
// Size: 0xa9
function function_9e98f49b() {
    self endon(#"disconnect");
    self notify(#"stop_player_monitor_slide");
    self endon(#"stop_player_monitor_slide");
    self.lastslidestarttime = 0;
    self.numberofslidesinlife = 0;
    while (true) {
        notification = self util::waittill_any_return("slide_begin", "death");
        if (notification == "death") {
            break;
        }
        self.lastslidestarttime = gettime();
        self.numberofslidesinlife++;
        notification = self util::waittill_any_return("slide_end", "death");
        if (notification == "death") {
            break;
        }
    }
}

// Namespace globallogic_player
// Params 0, eflags: 0x0
// Checksum 0x34e11793, Offset: 0x1f28
// Size: 0xa9
function function_cf1cf1b3() {
    self endon(#"disconnect");
    self notify(#"stop_player_monitor_doublejump");
    self endon(#"stop_player_monitor_doublejump");
    self.lastdoublejumpstarttime = 0;
    self.numberofdoublejumpsinlife = 0;
    while (true) {
        notification = self util::waittill_any_return("doublejump_begin", "death");
        if (notification == "death") {
            break;
        }
        self.lastdoublejumpstarttime = gettime();
        self.numberofdoublejumpsinlife++;
        notification = self util::waittill_any_return("doublejump_end", "death");
        if (notification == "death") {
            break;
        }
    }
}

// Namespace globallogic_player
// Params 0, eflags: 0x0
// Checksum 0x4d1c55c9, Offset: 0x1fe0
// Size: 0x1391
function callback_playerconnect() {
    thread notifyconnecting();
    self.statusicon = "hud_status_connecting";
    self waittill(#"begin");
    if (isdefined(level.reset_clientdvars)) {
        self [[ level.reset_clientdvars ]]();
    }
    waittillframeend();
    self.statusicon = "";
    self.guid = self getguid();
    self.killstreak = [];
    self.leaderdialogqueue = [];
    self.killstreakdialogqueue = [];
    matchrecorderincrementheaderstat("playerCountJoined", 1);
    profilelog_begintiming(4, "ship");
    level notify(#"connected", self);
    callback::callback(#"hash_eaffea17");
    if (self ishost()) {
        self thread globallogic::listenforgameend();
    }
    if (!level.splitscreen && !isdefined(self.pers["score"])) {
        iprintln(%MP_CONNECTED, self);
    }
    if (!isdefined(self.pers["score"])) {
        self thread persistence::adjust_recent_stats();
        self persistence::function_2eb5e93("valid", 0);
        if (gamemodeismode(3) && !self ishost()) {
            self persistence::function_2eb5e93("wagerMatchFailed", 1);
        } else {
            self persistence::function_2eb5e93("wagerMatchFailed", 0);
        }
    }
    if ((level.rankedmatch || level.wagermatch || level.leaguematch) && !isdefined(self.pers["matchesPlayedStatsTracked"])) {
        gamemode = util::getcurrentgamemode();
        self globallogic::incrementmatchcompletionstat(gamemode, "played", "started");
        if (!isdefined(self.pers["matchesHostedStatsTracked"]) && self islocaltohost()) {
            self globallogic::incrementmatchcompletionstat(gamemode, "hosted", "started");
            self.pers["matchesHostedStatsTracked"] = 1;
        }
        self.pers["matchesPlayedStatsTracked"] = 1;
        self thread persistence::upload_stats_soon();
    }
    self gamerep::gamerepplayerconnected();
    lpselfnum = self getentitynumber();
    lpguid = self getguid();
    logprint("J;" + lpguid + ";" + lpselfnum + ";" + self.name + "\n");
    bbprint("global_joins", "name %s client %s", self.name, lpselfnum);
    recordplayerstats(self, "codeClientNum", lpselfnum);
    if (!sessionmodeiszombiesgame()) {
        self setclientuivisibilityflag("hud_visible", 1);
        self setclientuivisibilityflag("weapon_hud_visible", 1);
    }
    self setclientplayersprinttime(level.playersprinttime);
    self setclientnumlives(level.numlives);
    if (level.hardcoremode) {
        self setclientdrawtalk(3);
    }
    if (sessionmodeiszombiesgame()) {
        self [[ level.player_stats_init ]]();
    } else {
        self globallogic_score::initpersstat("score");
        if (level.resetplayerscoreeveryround) {
            self.pers["score"] = 0;
        }
        self.score = self.pers["score"];
        self globallogic_score::initpersstat("pointstowin");
        if (level.scoreroundwinbased) {
            self.pers["pointstowin"] = 0;
        }
        self.pointstowin = self.pers["pointstowin"];
        self globallogic_score::initpersstat("momentum", 0);
        self.momentum = self globallogic_score::getpersstat("momentum");
        self globallogic_score::initpersstat("suicides");
        self.suicides = self globallogic_score::getpersstat("suicides");
        self globallogic_score::initpersstat("headshots");
        self.headshots = self globallogic_score::getpersstat("headshots");
        self globallogic_score::initpersstat("challenges");
        self.challenges = self globallogic_score::getpersstat("challenges");
        self globallogic_score::initpersstat("kills");
        self.kills = self globallogic_score::getpersstat("kills");
        self globallogic_score::initpersstat("deaths");
        self.deaths = self globallogic_score::getpersstat("deaths");
        self globallogic_score::initpersstat("assists");
        self.assists = self globallogic_score::getpersstat("assists");
        self globallogic_score::initpersstat("defends", 0);
        self.defends = self globallogic_score::getpersstat("defends");
        self globallogic_score::initpersstat("offends", 0);
        self.offends = self globallogic_score::getpersstat("offends");
        self globallogic_score::initpersstat("plants", 0);
        self.plants = self globallogic_score::getpersstat("plants");
        self globallogic_score::initpersstat("defuses", 0);
        self.defuses = self globallogic_score::getpersstat("defuses");
        self globallogic_score::initpersstat("returns", 0);
        self.returns = self globallogic_score::getpersstat("returns");
        self globallogic_score::initpersstat("captures", 0);
        self.captures = self globallogic_score::getpersstat("captures");
        self globallogic_score::initpersstat("objtime", 0);
        self.objtime = self globallogic_score::getpersstat("objtime");
        self globallogic_score::initpersstat("carries", 0);
        self.carries = self globallogic_score::getpersstat("carries");
        self globallogic_score::initpersstat("throws", 0);
        self.throws = self globallogic_score::getpersstat("throws");
        self globallogic_score::initpersstat("destructions", 0);
        self.destructions = self globallogic_score::getpersstat("destructions");
        self globallogic_score::initpersstat("disables", 0);
        self.disables = self globallogic_score::getpersstat("disables");
        self globallogic_score::initpersstat("escorts", 0);
        self.escorts = self globallogic_score::getpersstat("escorts");
        self globallogic_score::initpersstat("sbtimeplayed", 0);
        self.sbtimeplayed = self globallogic_score::getpersstat("sbtimeplayed");
        self globallogic_score::initpersstat("backstabs", 0);
        self.backstabs = self globallogic_score::getpersstat("backstabs");
        self globallogic_score::initpersstat("longshots", 0);
        self.longshots = self globallogic_score::getpersstat("longshots");
        self globallogic_score::initpersstat("survived", 0);
        self.survived = self globallogic_score::getpersstat("survived");
        self globallogic_score::initpersstat("stabs", 0);
        self.stabs = self globallogic_score::getpersstat("stabs");
        self globallogic_score::initpersstat("tomahawks", 0);
        self.tomahawks = self globallogic_score::getpersstat("tomahawks");
        self globallogic_score::initpersstat("humiliated", 0);
        self.humiliated = self globallogic_score::getpersstat("humiliated");
        self globallogic_score::initpersstat("x2score", 0);
        self.x2score = self globallogic_score::getpersstat("x2score");
        self globallogic_score::initpersstat("agrkills", 0);
        self.x2score = self globallogic_score::getpersstat("agrkills");
        self globallogic_score::initpersstat("hacks", 0);
        self.x2score = self globallogic_score::getpersstat("hacks");
        self globallogic_score::initpersstat("killsconfirmed", 0);
        self.killsconfirmed = self globallogic_score::getpersstat("killsconfirmed");
        self globallogic_score::initpersstat("killsdenied", 0);
        self.killsdenied = self globallogic_score::getpersstat("killsdenied");
        self globallogic_score::initpersstat("rescues", 0);
        self.rescues = self globallogic_score::getpersstat("rescues");
        self globallogic_score::initpersstat("shotsfired", 0);
        self.shotsfired = self globallogic_score::getpersstat("shotsfired");
        self globallogic_score::initpersstat("shotshit", 0);
        self.shotshit = self globallogic_score::getpersstat("shotshit");
        self globallogic_score::initpersstat("shotsmissed", 0);
        self.shotsmissed = self globallogic_score::getpersstat("shotsmissed");
        self globallogic_score::initpersstat("victory", 0);
        self.victory = self globallogic_score::getpersstat("victory");
        self globallogic_score::initpersstat("sessionbans", 0);
        self.sessionbans = self globallogic_score::getpersstat("sessionbans");
        self globallogic_score::initpersstat("gametypeban", 0);
        self globallogic_score::initpersstat("time_played_total", 0);
        self globallogic_score::initpersstat("time_played_alive", 0);
        self globallogic_score::initpersstat("teamkills", 0);
        self globallogic_score::initpersstat("teamkills_nostats", 0);
        self globallogic_score::initpersstat("kill_distances", 0);
        self globallogic_score::initpersstat("num_kill_distance_entries", 0);
        self globallogic_score::initpersstat("time_played_moving", 0);
        self globallogic_score::initpersstat("total_speeds_when_moving", 0);
        self globallogic_score::initpersstat("num_speeds_when_moving_entries", 0);
        self globallogic_score::initpersstat("total_distance_travelled", 0);
        self.teamkillpunish = 0;
        if (level.minimumallowedteamkills >= 0 && self.pers["teamkills_nostats"] > level.minimumallowedteamkills) {
            self thread function_a1ea27f6();
        }
        self behaviortracker::initialize();
    }
    self.killedplayerscurrent = [];
    if (!isdefined(self.pers["best_kill_streak"])) {
        self.pers["killed_players"] = [];
        self.pers["killed_by"] = [];
        self.pers["nemesis_tracking"] = [];
        self.pers["artillery_kills"] = 0;
        self.pers["dog_kills"] = 0;
        self.pers["nemesis_name"] = "";
        self.pers["nemesis_rank"] = 0;
        self.pers["nemesis_rankIcon"] = 0;
        self.pers["nemesis_xp"] = 0;
        self.pers["nemesis_xuid"] = "";
        self.pers["best_kill_streak"] = 0;
    }
    if (!isdefined(self.pers["music"])) {
        self.pers["music"] = spawnstruct();
        self.pers["music"].spawn = 0;
        self.pers["music"].inque = 0;
        self.pers["music"].currentstate = "SILENT";
        self.pers["music"].previousstate = "SILENT";
        self.pers["music"].nextstate = "UNDERSCORE";
        self.pers["music"].returnstate = "UNDERSCORE";
    }
    if (self.team != "spectator") {
        self thread globallogic_audio::set_music_on_player("spawnPreLoop");
    }
    if (!isdefined(self.pers["cur_kill_streak"])) {
        self.pers["cur_kill_streak"] = 0;
    }
    if (!isdefined(self.pers["cur_total_kill_streak"])) {
        self.pers["cur_total_kill_streak"] = 0;
        self setplayercurrentstreak(0);
    }
    if (!isdefined(self.pers["totalKillstreakCount"])) {
        self.pers["totalKillstreakCount"] = 0;
    }
    if (!isdefined(self.pers["killstreaksEarnedThisKillstreak"])) {
        self.pers["killstreaksEarnedThisKillstreak"] = 0;
    }
    if (isdefined(level.usingscorestreaks) && level.usingscorestreaks && !isdefined(self.pers["killstreak_quantity"])) {
        self.pers["killstreak_quantity"] = [];
    }
    if (isdefined(level.usingscorestreaks) && level.usingscorestreaks && !isdefined(self.pers["held_killstreak_ammo_count"])) {
        self.pers["held_killstreak_ammo_count"] = [];
    }
    if (isdefined(level.usingscorestreaks) && level.usingscorestreaks && !isdefined(self.pers["held_killstreak_clip_count"])) {
        self.pers["held_killstreak_clip_count"] = [];
    }
    if (!isdefined(self.pers["changed_class"])) {
        self.pers["changed_class"] = 0;
    }
    if (!isdefined(self.pers["lastroundscore"])) {
        self.pers["lastroundscore"] = 0;
    }
    self.lastkilltime = 0;
    self.cur_death_streak = 0;
    self disabledeathstreak();
    self.death_streak = 0;
    self.kill_streak = 0;
    self.gametype_kill_streak = 0;
    self.spawnqueueindex = -1;
    self.deathtime = 0;
    self.alivetimes = [];
    for (index = 0; index < level.alivetimemaxcount; index++) {
        self.alivetimes[index] = 0;
    }
    self.alivetimecurrentindex = 0;
    if (level.onlinegame) {
        self.death_streak = self getdstat("HighestStats", "death_streak");
        self.kill_streak = self getdstat("HighestStats", "kill_streak");
        self.gametype_kill_streak = self persistence::function_2369852e("kill_streak");
    }
    self.lastgrenadesuicidetime = -1;
    self.teamkillsthisround = 0;
    if (!isdefined(level.livesdonotreset) || !level.livesdonotreset || !isdefined(self.pers["lives"])) {
        self.pers["lives"] = level.numlives;
    }
    if (!level.teambased) {
        self.pers["team"] = undefined;
    }
    self.hasspawned = 0;
    self.waitingtospawn = 0;
    self.wantsafespawn = 0;
    self.deathcount = 0;
    self.wasaliveatmatchstart = 0;
    level.players[level.players.size] = self;
    if (level.splitscreen) {
        setdvar("splitscreen_playerNum", level.players.size);
    }
    InvalidOpCode(0x54, "state");
    // Unknown operator (0x54, t7_1b, PC)
}

// Namespace globallogic_player
// Params 0, eflags: 0x0
// Checksum 0x800c198b, Offset: 0x39f8
// Size: 0x322
function record_global_mp_stats_for_player_at_match_start() {
    startkills = self getdstat("playerstatslist", "kills", "statValue");
    startdeaths = self getdstat("playerstatslist", "deaths", "statValue");
    startwins = self getdstat("playerstatslist", "wins", "statValue");
    startlosses = self getdstat("playerstatslist", "losses", "statValue");
    starthits = self getdstat("playerstatslist", "hits", "statValue");
    startmisses = self getdstat("playerstatslist", "misses", "statValue");
    starttimeplayedtotal = self getdstat("playerstatslist", "time_played_total", "statValue");
    startscore = self getdstat("playerstatslist", "score", "statValue");
    startprestige = self getdstat("playerstatslist", "plevel", "statValue");
    startunlockpoints = self getdstat("unlocks", 0);
    ties = self getdstat("playerstatslist", "ties", "statValue");
    startgamesplayed = startwins + startlosses + ties;
    recordplayerstats(self, "startKills", startkills);
    recordplayerstats(self, "startDeaths", startdeaths);
    recordplayerstats(self, "startWins", startwins);
    recordplayerstats(self, "startLosses", startlosses);
    recordplayerstats(self, "startHits", starthits);
    recordplayerstats(self, "startMisses", startmisses);
    recordplayerstats(self, "startTimePlayedTotal", starttimeplayedtotal);
    recordplayerstats(self, "startScore", startscore);
    recordplayerstats(self, "startPrestige", startprestige);
    recordplayerstats(self, "startUnlockPoints", startunlockpoints);
    recordplayerstats(self, "startGamesPlayed", startgamesplayed);
}

// Namespace globallogic_player
// Params 0, eflags: 0x0
// Checksum 0x415c2203, Offset: 0x3d28
// Size: 0x322
function record_global_mp_stats_for_player_at_match_end() {
    endkills = self getdstat("playerstatslist", "kills", "statValue");
    enddeaths = self getdstat("playerstatslist", "deaths", "statValue");
    endwins = self getdstat("playerstatslist", "wins", "statValue");
    endlosses = self getdstat("playerstatslist", "losses", "statValue");
    endhits = self getdstat("playerstatslist", "hits", "statValue");
    endmisses = self getdstat("playerstatslist", "misses", "statValue");
    endtimeplayedtotal = self getdstat("playerstatslist", "time_played_total", "statValue");
    endscore = self getdstat("playerstatslist", "score", "statValue");
    endprestige = self getdstat("playerstatslist", "plevel", "statValue");
    endunlockpoints = self getdstat("unlocks", 0);
    ties = self getdstat("playerstatslist", "ties", "statValue");
    endgamesplayed = endwins + endlosses + ties;
    recordplayerstats(self, "endKills", endkills);
    recordplayerstats(self, "endDeaths", enddeaths);
    recordplayerstats(self, "endWins", endwins);
    recordplayerstats(self, "endLosses", endlosses);
    recordplayerstats(self, "endHits", endhits);
    recordplayerstats(self, "endMisses", endmisses);
    recordplayerstats(self, "endTimePlayedTotal", endtimeplayedtotal);
    recordplayerstats(self, "endScore", endscore);
    recordplayerstats(self, "endPrestige", endprestige);
    recordplayerstats(self, "endUnlockPoints", endunlockpoints);
    recordplayerstats(self, "endGamesPlayed", endgamesplayed);
}

// Namespace globallogic_player
// Params 0, eflags: 0x0
// Checksum 0xa46565aa, Offset: 0x4058
// Size: 0x7a
function record_misc_player_stats() {
    recordplayerstats(self, "UTCEndTimeSeconds", getutc());
    if (isdefined(self.weaponpickupscount)) {
        recordplayerstats(self, "weaponPickupsCount", self.weaponpickupscount);
    }
    if (isdefined(self.killcamsskipped)) {
        recordplayerstats(self, "totalKillcamsSkipped", self.killcamsskipped);
    }
}

// Namespace globallogic_player
// Params 0, eflags: 0x0
// Checksum 0x2bbe5911, Offset: 0x40e0
// Size: 0x1d5
function spectate_player_watcher() {
    self endon(#"disconnect");
    InvalidOpCode(0x54, "state");
    // Unknown operator (0x54, t7_1b, PC)
LOC_0000005d:
    if (!level.splitscreen && !level.hardcoremode && getdvarint("scr_showperksonspawn") == 1 && !level.splitscreen && !level.hardcoremode && getdvarint("scr_showperksonspawn") == 1 && !isdefined(self.perkhudelem)) {
        if (level.perksenabled == 1) {
            self hud::showperks();
        }
    }
    self.watchingactiveclient = 1;
    self.var_f2e9a21a = undefined;
    while (true) {
        if (self.pers["team"] != "spectator" || level.gameended) {
            self hud_message::function_b17b90b9();
            self freezecontrols(0);
            self.watchingactiveclient = 0;
            break;
        }
        count = 0;
        for (i = 0; i < level.players.size; i++) {
            if (level.players[i].team != "spectator") {
                count++;
                break;
            }
        }
        if (count > 0) {
            if (!self.watchingactiveclient) {
                self hud_message::function_b17b90b9();
                self freezecontrols(0);
                self luinotifyevent(%player_spawned, 0);
            }
            self.watchingactiveclient = 1;
        } else {
            if (self.watchingactiveclient) {
                [[ level.onspawnspectator ]]();
                self freezecontrols(1);
                self hud_message::function_b5203d90();
            }
            self.watchingactiveclient = 0;
        }
        wait 0.5;
    }
}

// Namespace globallogic_player
// Params 0, eflags: 0x0
// Checksum 0x1fce0fc4, Offset: 0x42c0
// Size: 0xa3
function callback_playermigrated() {
    println("<dev string:xf3>" + self.name + "<dev string:xfb>" + gettime());
    if (isdefined(self.connected) && self.connected) {
        self globallogic_ui::updateobjectivetext();
    }
    level.hostmigrationreturnedplayercount++;
    if (level.hostmigrationreturnedplayercount >= level.players.size * 2 / 3) {
        println("<dev string:x118>");
        level notify(#"hostmigration_enoughplayers");
    }
}

// Namespace globallogic_player
// Params 0, eflags: 0x0
// Checksum 0xc5e9fc4c, Offset: 0x4370
// Size: 0x59
function callback_playerdisconnect() {
    profilelog_begintiming(5, "ship");
    InvalidOpCode(0x54, "state");
    // Unknown operator (0x54, t7_1b, PC)
}

// Namespace globallogic_player
// Params 8, eflags: 0x0
// Checksum 0xcef109e5, Offset: 0x48c0
// Size: 0xa2
function callback_playermelee(eattacker, idamage, weapon, vorigin, vdir, boneindex, shieldhit, frombehind) {
    hit = 1;
    if (level.teambased && self.team == eattacker.team) {
        if (level.friendlyfire == 0) {
            hit = 0;
        }
    }
    self finishmeleehit(eattacker, weapon, vorigin, vdir, boneindex, shieldhit, hit, frombehind);
}

// Namespace globallogic_player
// Params 0, eflags: 0x0
// Checksum 0xcfd511c2, Offset: 0x4970
// Size: 0x1c3
function choosenextbestnemesis() {
    nemesisarray = self.pers["nemesis_tracking"];
    nemesisarraykeys = getarraykeys(nemesisarray);
    nemesisamount = 0;
    nemesisname = "";
    if (nemesisarraykeys.size > 0) {
        for (i = 0; i < nemesisarraykeys.size; i++) {
            nemesisarraykey = nemesisarraykeys[i];
            if (nemesisarray[nemesisarraykey] > nemesisamount) {
                nemesisname = nemesisarraykey;
                nemesisamount = nemesisarray[nemesisarraykey];
            }
        }
    }
    self.pers["nemesis_name"] = nemesisname;
    if (nemesisname != "") {
        for (playerindex = 0; playerindex < level.players.size; playerindex++) {
            if (level.players[playerindex].name == nemesisname) {
                nemesisplayer = level.players[playerindex];
                self.pers["nemesis_rank"] = nemesisplayer.pers["rank"];
                self.pers["nemesis_rankIcon"] = nemesisplayer.pers["rankxp"];
                self.pers["nemesis_xp"] = nemesisplayer.pers["prestige"];
                self.pers["nemesis_xuid"] = nemesisplayer getxuid(1);
                break;
            }
        }
        return;
    }
    self.pers["nemesis_xuid"] = "";
}

// Namespace globallogic_player
// Params 7, eflags: 0x0
// Checksum 0xb743690c, Offset: 0x4b40
// Size: 0xae
function custom_gamemodes_modified_damage(victim, eattacker, idamage, smeansofdeath, weapon, einflictor, shitloc) {
    if (level.onlinegame && !sessionmodeisprivate()) {
        return idamage;
    }
    if (isdefined(eattacker) && isdefined(eattacker.damagemodifier)) {
        idamage *= eattacker.damagemodifier;
    }
    if (smeansofdeath == "MOD_PISTOL_BULLET" || smeansofdeath == "MOD_RIFLE_BULLET") {
        idamage = int(idamage * level.bulletdamagescalar);
    }
    return idamage;
}

// Namespace globallogic_player
// Params 1, eflags: 0x0
// Checksum 0x4ef2a9c1, Offset: 0x4bf8
// Size: 0xf6
function figure_out_attacker(eattacker) {
    if (isdefined(eattacker)) {
        if (isai(eattacker) && isdefined(eattacker.script_owner)) {
            team = self.team;
            if (eattacker.script_owner.team != team) {
                eattacker = eattacker.script_owner;
            }
        }
        if (eattacker.classname == "script_vehicle" && isdefined(eattacker.owner)) {
            eattacker = eattacker.owner;
        } else if (eattacker.classname == "auto_turret" && isdefined(eattacker.owner)) {
            eattacker = eattacker.owner;
        } else if (eattacker.classname == "actor_spawner_bo3_robot_grunt_assault_mp" && isdefined(eattacker.owner)) {
            eattacker = eattacker.owner;
        }
    }
    return eattacker;
}

// Namespace globallogic_player
// Params 2, eflags: 0x0
// Checksum 0xf4ce3bf9, Offset: 0x4cf8
// Size: 0x124
function function_b168504f(weapon, einflictor) {
    if (weapon == level.weaponnone && isdefined(einflictor)) {
        if (isdefined(einflictor.targetname) && einflictor.targetname == "explodable_barrel") {
            weapon = getweapon("explodable_barrel");
        } else if (isdefined(einflictor.destructible_type) && issubstr(einflictor.destructible_type, "vehicle_")) {
            weapon = getweapon("destructible_car");
        } else if (isdefined(einflictor.scriptvehicletype)) {
            veh_weapon = getweapon(einflictor.scriptvehicletype);
            if (isdefined(veh_weapon)) {
                weapon = veh_weapon;
            }
        }
    }
    if (isdefined(einflictor) && isdefined(einflictor.script_noteworthy)) {
        if (isdefined(level.overrideweaponfunc)) {
            weapon = [[ level.overrideweaponfunc ]](weapon, einflictor.script_noteworthy);
        }
    }
    return weapon;
}

// Namespace globallogic_player
// Params 2, eflags: 0x0
// Checksum 0xd501ba7, Offset: 0x4e28
// Size: 0x39
function function_f698740(eattacker, weapon) {
    if (level.hardcoremode) {
        return 0;
    }
    if (!isdefined(eattacker)) {
        return 0;
    }
    if (self != eattacker) {
        return 0;
    }
    return weapon.donotdamageowner;
}

// Namespace globallogic_player
// Params 4, eflags: 0x0
// Checksum 0x31aa3e74, Offset: 0x4e70
// Size: 0x29
function should_do_player_damage(eattacker, weapon, smeansofdeath, idflags) {
    InvalidOpCode(0x54, "state");
    // Unknown operator (0x54, t7_1b, PC)
}

// Namespace globallogic_player
// Params 7, eflags: 0x0
// Checksum 0x6cf4ab64, Offset: 0x4fb0
// Size: 0x18c
function apply_damage_to_armor(einflictor, eattacker, idamage, smeansofdeath, weapon, shitloc, friendlyfire) {
    victim = self;
    if (friendlyfire && !function_35dc792c()) {
        return idamage;
    }
    if (isdefined(victim.lightarmorhp)) {
        if (weapon.ignoreslightarmor && smeansofdeath != "MOD_MELEE") {
            return idamage;
        } else if (weapon.meleeignoreslightarmor && smeansofdeath == "MOD_MELEE") {
            return idamage;
        } else if (isdefined(einflictor) && isdefined(einflictor.stucktoplayer) && einflictor.stucktoplayer == victim) {
            idamage = victim.health;
        } else if (smeansofdeath != "MOD_FALLING" && !weapon_utils::ismeleemod(smeansofdeath) && !globallogic_utils::isheadshot(weapon, shitloc, smeansofdeath, eattacker) && !loadout::isfmjdamage(weapon, smeansofdeath, eattacker)) {
            victim armor::setlightarmorhp(victim.lightarmorhp - idamage);
            idamage = 0;
            if (victim.lightarmorhp <= 0) {
                idamage = abs(victim.lightarmorhp);
                armor::unsetlightarmor();
            }
        }
    }
    return idamage;
}

// Namespace globallogic_player
// Params 1, eflags: 0x0
// Checksum 0x5c634f5a, Offset: 0x5148
// Size: 0x69
function make_sure_damage_is_not_zero(idamage) {
    if (idamage < 1) {
        if (self ability_util::gadget_power_armor_on() && isdefined(self.maxhealth) && self.health < self.maxhealth) {
            self.health = self.health + 1;
        }
        idamage = 1;
    }
    return int(idamage);
}

// Namespace globallogic_player
// Params 1, eflags: 0x0
// Checksum 0xa43389f6, Offset: 0x51c0
// Size: 0x3e
function modify_player_damage_friendlyfire(idamage) {
    if (level.friendlyfire == 2 || level.friendlyfire == 3) {
        idamage = int(idamage * 0.5);
    }
    return idamage;
}

// Namespace globallogic_player
// Params 11, eflags: 0x0
// Checksum 0x5900d50c, Offset: 0x5208
// Size: 0x249
function modify_player_damage(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex) {
    if (isdefined(self.overrideplayerdamage)) {
        idamage = self [[ self.overrideplayerdamage ]](einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex);
    } else if (isdefined(level.overrideplayerdamage)) {
        idamage = self [[ level.overrideplayerdamage ]](einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex);
    }
    assert(isdefined(idamage), "<dev string:x153>");
    if (isdefined(eattacker)) {
        idamage = loadout::cac_modified_damage(self, eattacker, idamage, smeansofdeath, weapon, einflictor, shitloc);
        if (isdefined(eattacker.pickup_damage_scale) && eattacker.pickup_damage_scale_time > gettime()) {
            idamage *= eattacker.pickup_damage_scale;
        }
    }
    idamage = custom_gamemodes_modified_damage(self, eattacker, idamage, smeansofdeath, weapon, einflictor, shitloc);
    if (level.onplayerdamage != &globallogic::blank) {
        modifieddamage = [[ level.onplayerdamage ]](einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime);
        if (isdefined(modifieddamage)) {
            if (modifieddamage <= 0) {
                return;
            }
            idamage = modifieddamage;
        }
    }
    if (level.onlyheadshots) {
        if (smeansofdeath == "MOD_HEAD_SHOT") {
            idamage = -106;
        }
    }
    if (weapon.damagealwayskillsplayer) {
        idamage = self.maxhealth + 1;
    }
    if (shitloc == "riotshield") {
        if (!true) {
            if (!!true) {
                idamage *= 0;
            }
        } else if (!true) {
            if (isdefined(einflictor) && isdefined(einflictor.stucktoplayer) && einflictor.stucktoplayer == self) {
                idamage = self.maxhealth + 1;
            }
        }
    }
    return int(idamage);
}

// Namespace globallogic_player
// Params 5, eflags: 0x0
// Checksum 0xc6991445, Offset: 0x5460
// Size: 0xb6
function modify_player_damage_meansofdeath(einflictor, eattacker, smeansofdeath, weapon, shitloc) {
    if (globallogic_utils::isheadshot(weapon, shitloc, smeansofdeath, einflictor) && isplayer(eattacker) && !weapon_utils::ismeleemod(smeansofdeath)) {
        smeansofdeath = "MOD_HEAD_SHOT";
    }
    if (isdefined(einflictor) && isdefined(einflictor.script_noteworthy)) {
        if (einflictor.script_noteworthy == "ragdoll_now") {
            smeansofdeath = "MOD_FALLING";
        }
    }
    return smeansofdeath;
}

// Namespace globallogic_player
// Params 3, eflags: 0x0
// Checksum 0x5a1c96eb, Offset: 0x5520
// Size: 0x8f
function function_1a949060(einflictor, eattacker, smeansofdeath) {
    if (isdefined(einflictor) && isplayer(eattacker) && eattacker == einflictor) {
        if (smeansofdeath == "MOD_HEAD_SHOT" || smeansofdeath == "MOD_PISTOL_BULLET" || smeansofdeath == "MOD_RIFLE_BULLET") {
            eattacker.hits++;
        }
    }
    if (isplayer(eattacker)) {
        eattacker.pers["participation"]++;
    }
}

// Namespace globallogic_player
// Params 3, eflags: 0x0
// Checksum 0x1f93c756, Offset: 0x55b8
// Size: 0xc1
function function_c4f6f66d(einflictor, weapon, smeansofdeath) {
    if (!self player::is_spawn_protected()) {
        return false;
    }
    dist = distancesquared(einflictor.origin, self.lastspawnpoint.origin);
    if ((smeansofdeath == "MOD_GRENADE" || smeansofdeath == "MOD_GRENADE_SPLASH") && dist < 62500) {
        return true;
    }
    if ((smeansofdeath == "MOD_PROJECTILE" || smeansofdeath == "MOD_PROJECTILE_SPLASH") && dist < 62500) {
        return true;
    }
    if (killstreaks::is_killstreak_weapon(weapon)) {
        return true;
    }
    return false;
}

// Namespace globallogic_player
// Params 11, eflags: 0x0
// Checksum 0x25324b32, Offset: 0x5688
// Size: 0x44d
function function_19a0a019(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex) {
    if (smeansofdeath == "MOD_GAS" || isdefined(einflictor) && loadout::isexplosivedamage(smeansofdeath)) {
        if (self function_c4f6f66d(einflictor, weapon, smeansofdeath)) {
            return false;
        }
        if (self function_f698740(eattacker, weapon)) {
            return false;
        }
        self.explosiveinfo = [];
        self.explosiveinfo["damageTime"] = gettime();
        self.explosiveinfo["damageId"] = einflictor getentitynumber();
        self.explosiveinfo["originalOwnerKill"] = 0;
        self.explosiveinfo["bulletPenetrationKill"] = 0;
        self.explosiveinfo["chainKill"] = 0;
        self.explosiveinfo["damageExplosiveKill"] = 0;
        self.explosiveinfo["chainKill"] = 0;
        self.explosiveinfo["cookedKill"] = 0;
        self.explosiveinfo["weapon"] = weapon;
        self.explosiveinfo["originalowner"] = einflictor.originalowner;
        isfrag = weapon.name == "frag_grenade";
        if (isdefined(eattacker) && eattacker != self) {
            if (weapon.name == "satchel_charge" || weapon.name == "claymore" || isdefined(eattacker) && isdefined(einflictor.owner) && weapon.name == "bouncingbetty") {
                self.explosiveinfo["originalOwnerKill"] = einflictor.owner == self;
                self.explosiveinfo["damageExplosiveKill"] = isdefined(einflictor.wasdamaged);
                self.explosiveinfo["chainKill"] = isdefined(einflictor.waschained);
                self.explosiveinfo["wasJustPlanted"] = isdefined(einflictor.wasjustplanted);
                self.explosiveinfo["bulletPenetrationKill"] = isdefined(einflictor.wasdamagedfrombulletpenetration);
                self.explosiveinfo["cookedKill"] = 0;
            }
            if (isdefined(einflictor) && isdefined(einflictor.stucktoplayer) && weapon.projexplosiontype == "grenade") {
                self.explosiveinfo["stuckToPlayer"] = einflictor.stucktoplayer;
            }
            if (weapon.isstun) {
                self.laststunnedby = eattacker;
                self.laststunnedtime = self.idflagstime;
            }
            if (isdefined(eattacker.lastgrenadesuicidetime) && eattacker.lastgrenadesuicidetime >= gettime() - 50 && isfrag) {
                self.explosiveinfo["suicideGrenadeKill"] = 1;
            } else {
                self.explosiveinfo["suicideGrenadeKill"] = 0;
            }
        }
        if (isfrag) {
            self.explosiveinfo["cookedKill"] = isdefined(einflictor.iscooked);
            self.explosiveinfo["throwbackKill"] = isdefined(einflictor.threwback);
        }
        if (isdefined(eattacker) && isplayer(eattacker) && eattacker != self) {
            self globallogic_score::setinflictorstat(einflictor, eattacker, weapon);
        }
    }
    if (smeansofdeath == "MOD_IMPACT" && isdefined(eattacker) && isplayer(eattacker) && eattacker != self) {
        if (weapon != level.weaponballisticknife) {
            self globallogic_score::setinflictorstat(einflictor, eattacker, weapon);
        }
        if (weapon.name == "hatchet" && isdefined(einflictor)) {
            self.explosiveinfo["projectile_bounced"] = isdefined(einflictor.bounced);
        }
    }
    return true;
}

// Namespace globallogic_player
// Params 0, eflags: 0x0
// Checksum 0xebdcdb00, Offset: 0x5ae0
// Size: 0x33
function function_d71741f0() {
    if (level.friendlyfiredelay && level.friendlyfiredelaytime >= (gettime() - level.starttime - level.discardtime) / 1000) {
        return true;
    }
    return false;
}

// Namespace globallogic_player
// Params 1, eflags: 0x0
// Checksum 0xb96739af, Offset: 0x5b20
// Size: 0x5f
function function_5a53278d(eattacker) {
    if (!isalive(eattacker)) {
        return false;
    }
    if (level.friendlyfire == 1) {
        if (function_d71741f0()) {
            return true;
        }
    }
    if (level.friendlyfire == 2) {
        return true;
    }
    if (level.friendlyfire == 3) {
        return true;
    }
    return false;
}

// Namespace globallogic_player
// Params 0, eflags: 0x0
// Checksum 0xbcbb408a, Offset: 0x5b88
// Size: 0x3b
function function_35dc792c() {
    if (level.friendlyfire == 1) {
        if (function_d71741f0()) {
            return false;
        }
        return true;
    }
    if (level.friendlyfire == 3) {
        return true;
    }
    return false;
}

// Namespace globallogic_player
// Params 5, eflags: 0x0
// Checksum 0x4abd7c4d, Offset: 0x5bd0
// Size: 0x14a
function function_c3e5e4ba(eattacker, idamage, smeansofdeath, weapon, attackerishittingteammate) {
    if ((smeansofdeath == "MOD_PISTOL_BULLET" || smeansofdeath == "MOD_RIFLE_BULLET") && !killstreaks::is_killstreak_weapon(weapon) && !attackerishittingteammate) {
        if (self.hasriotshieldequipped) {
            if (isplayer(eattacker)) {
                eattacker.lastattackedshieldplayer = self;
                eattacker.lastattackedshieldtime = gettime();
            }
            previous_shield_damage = self.shielddamageblocked;
            self.shielddamageblocked = self.shielddamageblocked + idamage;
            if (self.shielddamageblocked % 400 < previous_shield_damage % 400) {
                score_event = "shield_blocked_damage";
                if (self.shielddamageblocked > 2000) {
                    score_event = "shield_blocked_damage_reduced";
                }
                if (isdefined(level.scoreinfo[score_event]["value"])) {
                    self addweaponstat(level.weaponriotshield, "score_from_blocked_damage", level.scoreinfo[score_event]["value"]);
                }
                scoreevents::processscoreevent(score_event, self);
            }
        }
    }
}

// Namespace globallogic_player
// Params 5, eflags: 0x0
// Checksum 0xf16fd6c6, Offset: 0x5d28
// Size: 0x61
function does_player_completely_avoid_damage(idflags, shitloc, weapon, friendlyfire, attackerishittingself) {
    if (!true) {
        return true;
    }
    if (friendlyfire && level.friendlyfire == 0) {
        return true;
    }
    if (shitloc == "riotshield") {
        if (!!true) {
            return true;
        }
    }
    return false;
}

// Namespace globallogic_player
// Params 11, eflags: 0x0
// Checksum 0x90ba1398, Offset: 0x5d98
// Size: 0x3a2
function player_damage_log(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex) {
    pixbeginevent("PlayerDamage log");
    /#
        if (getdvarint("<dev string:x18c>")) {
            println("<dev string:x19a>" + self getentitynumber() + "<dev string:x1a2>" + self.health + "<dev string:x1ab>" + eattacker.clientid + "<dev string:x1b6>" + isplayer(einflictor) + "<dev string:x1cc>" + idamage + "<dev string:x1d5>" + shitloc);
        }
    #/
    if (self.sessionstate != "dead") {
        lpselfnum = self getentitynumber();
        lpselfname = self.name;
        lpselfteam = self.team;
        lpselfguid = self getguid();
        lpattackerteam = "";
        lpattackerorigin = (0, 0, 0);
        if (isplayer(eattacker)) {
            lpattacknum = eattacker getentitynumber();
            lpattackguid = eattacker getguid();
            lpattackname = eattacker.name;
            lpattackerteam = eattacker.team;
            lpattackerorigin = eattacker.origin;
            isusingheropower = 0;
            if (eattacker ability_player::is_using_any_gadget()) {
                isusingheropower = 1;
            }
            bbprint("mpattacks", "gametime %d attackerspawnid %d attackerweapon %s attackerx %d attackery %d attackerz %d victimspawnid %d victimx %d victimy %d victimz %d damage %d damagetype %s damagelocation %s death %d isusingheropower %d", gettime(), getplayerspawnid(eattacker), weapon.name, lpattackerorigin, getplayerspawnid(self), self.origin, idamage, smeansofdeath, shitloc, 0, isusingheropower);
        } else {
            lpattacknum = -1;
            lpattackguid = "";
            lpattackname = "";
            lpattackerteam = "world";
            bbprint("mpattacks", "gametime %d attackerweapon %s victimspawnid %d victimx %d victimy %d victimz %d damage %d damagetype %s damagelocation %s death %d isusingheropower %d", gettime(), weapon.name, getplayerspawnid(self), self.origin, idamage, smeansofdeath, shitloc, 0, 0);
        }
        logprint("D;" + lpselfguid + ";" + lpselfnum + ";" + lpselfteam + ";" + lpselfname + ";" + lpattackguid + ";" + lpattacknum + ";" + lpattackerteam + ";" + lpattackname + ";" + weapon.name + ";" + idamage + ";" + smeansofdeath + ";" + shitloc + "\n");
    }
    pixendevent();
}

// Namespace globallogic_player
// Params 1, eflags: 0x0
// Checksum 0x655159a0, Offset: 0x6148
// Size: 0x19
function should_allow_postgame_damage(smeansofdeath) {
    if (smeansofdeath == "MOD_TRIGGER_HURT") {
        return true;
    }
    return false;
}

// Namespace globallogic_player
// Params 13, eflags: 0x0
// Checksum 0x768959e1, Offset: 0x6170
// Size: 0x71
function do_post_game_damage(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, boneindex, vsurfacenormal) {
    InvalidOpCode(0x54, "state");
    // Unknown operator (0x54, t7_1b, PC)
}

// Namespace globallogic_player
// Params 13, eflags: 0x0
// Checksum 0x48ec46aa, Offset: 0x6240
// Size: 0x761
function callback_playerdamage(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, boneindex, vsurfacenormal) {
    profilelog_begintiming(6, "ship");
    do_post_game_damage(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, boneindex, vsurfacenormal);
    self.idflags = idflags;
    self.idflagstime = gettime();
    eattacker = figure_out_attacker(eattacker);
    if (isdefined(eattacker.laststand) && isplayer(eattacker) && eattacker.laststand) {
        return;
    }
    smeansofdeath = modify_player_damage_meansofdeath(einflictor, eattacker, smeansofdeath, weapon, shitloc);
    if (!self should_do_player_damage(eattacker, weapon, smeansofdeath, idflags)) {
        return;
    }
    function_1a949060(einflictor, eattacker, smeansofdeath);
    weapon = function_b168504f(weapon, einflictor);
    pixbeginevent("PlayerDamage flags/tweaks");
    if (!isdefined(vdir)) {
        InvalidOpCode(0xb9, 4, idflags);
        // Unknown operator (0xb9, t7_1b, PC)
    }
    attackerishittingteammate = isplayer(eattacker) && self util::isenemyplayer(eattacker) == 0;
    attackerishittingself = isplayer(eattacker) && self == eattacker;
    friendlyfire = level.teambased && !attackerishittingself && attackerishittingteammate;
    pixendevent();
    idamage = modify_player_damage(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex);
    if (friendlyfire) {
        idamage = modify_player_damage_friendlyfire(idamage);
    }
    if (isdefined(self.power_armor_took_damage) && self.power_armor_took_damage) {
        InvalidOpCode(0xb9, 1024, idflags);
        // Unknown operator (0xb9, t7_1b, PC)
    }
    if (shitloc == "riotshield") {
        function_c3e5e4ba(eattacker, idamage, smeansofdeath, weapon, attackerishittingteammate);
    }
    if (does_player_completely_avoid_damage(idflags, shitloc, weapon, friendlyfire, attackerishittingself)) {
        return;
    }
    self callback::callback(#"hash_ab5ecf6c");
    armor = self armor::function_3e7fdc00();
    idamage = apply_damage_to_armor(einflictor, eattacker, idamage, smeansofdeath, weapon, shitloc, friendlyfire);
    idamage = make_sure_damage_is_not_zero(idamage);
    armor_damaged = armor != self armor::function_3e7fdc00();
    if (shitloc == "riotshield") {
        shitloc = "none";
    }
    if (!function_19a0a019(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex)) {
        return;
    }
    prevhealthratio = self.health / self.maxhealth;
    if (friendlyfire) {
        pixmarker("BEGIN: PlayerDamage player");
        if (function_35dc792c()) {
            self.lastdamagewasfromenemy = 0;
            self finishplayerdamagewrapper(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, boneindex, vsurfacenormal);
        } else if (weapon.forcedamageshellshockandrumble) {
            self damageshellshockandrumble(eattacker, einflictor, weapon, smeansofdeath, idamage);
        }
        if (function_5a53278d(eattacker)) {
            eattacker.lastdamagewasfromenemy = 0;
            eattacker.friendlydamage = 1;
            eattacker finishplayerdamagewrapper(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, boneindex, vsurfacenormal);
            eattacker.friendlydamage = undefined;
        }
        pixmarker("END: PlayerDamage player");
    } else {
        behaviortracker::function_dbc71f52(eattacker, self, idamage);
        self.lastattackweapon = weapon;
        giveattackerandinflictorownerassist(eattacker, einflictor, idamage, smeansofdeath, weapon);
        if (isdefined(eattacker)) {
            level.lastlegitimateattacker = eattacker;
        }
        if ((smeansofdeath == "MOD_GRENADE" || smeansofdeath == "MOD_GRENADE_SPLASH") && isdefined(einflictor) && isdefined(einflictor.iscooked)) {
            self.wascooked = gettime();
        } else {
            self.wascooked = undefined;
        }
        self.lastdamagewasfromenemy = isdefined(eattacker) && eattacker != self;
        if (self.lastdamagewasfromenemy) {
            if (isplayer(eattacker)) {
                if (isdefined(eattacker.damagedplayers[self.clientid]) == 0) {
                    eattacker.damagedplayers[self.clientid] = spawnstruct();
                }
                eattacker.damagedplayers[self.clientid].time = gettime();
                eattacker.damagedplayers[self.clientid].entity = self;
            }
        }
        if (isplayer(eattacker) && isdefined(weapon.gadget_type) && weapon.gadget_type == 14) {
            if (isdefined(eattacker.var_6a936b17)) {
                eattacker.var_6a936b17++;
            }
        }
        self finishplayerdamagewrapper(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, boneindex, vsurfacenormal);
    }
    if (isdefined(eattacker) && !attackerishittingself) {
        if (damagefeedback::dodamagefeedback(weapon, einflictor, idamage, smeansofdeath)) {
            if (idamage > 0 && self.health > 0) {
                perkfeedback = function_6b151027(self, weapon, smeansofdeath, einflictor, armor_damaged);
            }
            eattacker thread damagefeedback::update(smeansofdeath, einflictor, perkfeedback, weapon, self, psoffsettime, shitloc);
        }
    }
    if (isdefined(level.hardcoremode) && (!isdefined(eattacker) || !friendlyfire || level.hardcoremode)) {
        self battlechatter::pain_vox(smeansofdeath);
    }
    self.hasdonecombat = 1;
    if (weapon.isemp && smeansofdeath == "MOD_GRENADE_SPLASH") {
        if (!self hasperk("specialty_immuneemp")) {
            self notify(#"emp_grenaded", eattacker, vpoint);
        }
    }
    if (isdefined(eattacker) && eattacker != self && !friendlyfire) {
        level.usestartspawns = 0;
    }
    player_damage_log(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex);
    InvalidOpCode(0x54, "state", "gs=");
    // Unknown operator (0x54, t7_1b, PC)
}

// Namespace globallogic_player
// Params 0, eflags: 0x0
// Checksum 0xf265929f, Offset: 0x69d8
// Size: 0x22
function resetattackerlist() {
    self.attackers = [];
    self.attackerdata = [];
    self.attackerdamage = [];
    self.firsttimedamaged = 0;
}

// Namespace globallogic_player
// Params 5, eflags: 0x0
// Checksum 0x30960dfc, Offset: 0x6a08
// Size: 0x156
function function_6b151027(player, weapon, smeansofdeath, einflictor, armor_damaged) {
    perkfeedback = undefined;
    var_bb61b344 = loadout::function_bb61b344(player);
    hasflakjacket = player hasperk("specialty_flakjacket");
    isexplosivedamage = loadout::isexplosivedamage(smeansofdeath);
    isflashorstundamage = weapon_utils::isflashorstundamage(weapon, smeansofdeath);
    if (isflashorstundamage && var_bb61b344) {
        perkfeedback = "tacticalMask";
    } else if (player hasperk("specialty_fireproof") && loadout::isfiredamage(weapon, smeansofdeath)) {
        perkfeedback = "flakjacket";
    } else if (isexplosivedamage && hasflakjacket && !weapon.ignoresflakjacket && !isaikillstreakdamage(weapon, einflictor)) {
        perkfeedback = "flakjacket";
    } else if (armor_damaged) {
        perkfeedback = "armor";
    }
    return perkfeedback;
}

// Namespace globallogic_player
// Params 2, eflags: 0x0
// Checksum 0x7fab0948, Offset: 0x6b68
// Size: 0x45
function isaikillstreakdamage(weapon, einflictor) {
    if (weapon.isaikillstreakdamage) {
        if (weapon.name != "ai_tank_drone_rocket" || isdefined(einflictor.firedbyai)) {
            return true;
        }
    }
    return false;
}

// Namespace globallogic_player
// Params 13, eflags: 0x0
// Checksum 0x9b371c10, Offset: 0x6bb8
// Size: 0x23a
function finishplayerdamagewrapper(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, boneindex, vsurfacenormal) {
    pixbeginevent("finishPlayerDamageWrapper");
    if (!level.console && !true && isplayer(eattacker)) {
        println("<dev string:x1de>" + self getentitynumber() + "<dev string:x1a2>" + self.health + "<dev string:x1ab>" + eattacker.clientid + "<dev string:x1b6>" + isplayer(einflictor) + "<dev string:x1cc>" + idamage + "<dev string:x1d5>" + shitloc);
        eattacker addplayerstat("penetration_shots", 1);
    }
    if (getdvarstring("scr_csmode") != "") {
        self shellshock("damage_mp", 0.2);
    }
    self damageshellshockandrumble(eattacker, einflictor, weapon, smeansofdeath, idamage);
    self ability_power::power_loss_event_took_damage(eattacker, einflictor, weapon, smeansofdeath, idamage);
    if (isplayer(eattacker)) {
        self.lastshotby = eattacker.clientid;
    }
    if (smeansofdeath == "MOD_BURNED") {
        self burnplayer::takingburndamage(eattacker, weapon, smeansofdeath);
    }
    self finishplayerdamage(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, boneindex, vsurfacenormal);
    pixendevent();
}

// Namespace globallogic_player
// Params 1, eflags: 0x0
// Checksum 0xc3656c72, Offset: 0x6e00
// Size: 0x39
function allowedassistweapon(weapon) {
    if (!killstreaks::is_killstreak_weapon(weapon)) {
        return true;
    }
    if (killstreaks::is_killstreak_weapon_assist_allowed(weapon)) {
        return true;
    }
    return false;
}

// Namespace globallogic_player
// Params 2, eflags: 0x0
// Checksum 0x4c943841, Offset: 0x6e48
// Size: 0x2c6
function function_da9b1acd(attacker, weapon) {
    if (!isdefined(self.switching_teams)) {
        if (isplayer(attacker) && level.teambased && attacker != self && self.team == attacker.team) {
            self.pers["cur_kill_streak"] = 0;
            self.pers["cur_total_kill_streak"] = 0;
            self.pers["totalKillstreakCount"] = 0;
            self.pers["killstreaksEarnedThisKillstreak"] = 0;
            self setplayercurrentstreak(0);
        } else {
            self globallogic_score::incpersstat("deaths", 1, 1, 1);
            self.deaths = self globallogic_score::getpersstat("deaths");
            self updatestatratio("kdratio", "kills", "deaths");
            if (self.pers["cur_kill_streak"] > self.pers["best_kill_streak"]) {
                self.pers["best_kill_streak"] = self.pers["cur_kill_streak"];
            }
            self.pers["kill_streak_before_death"] = self.pers["cur_kill_streak"];
            self.pers["cur_kill_streak"] = 0;
            self.pers["cur_total_kill_streak"] = 0;
            self.pers["totalKillstreakCount"] = 0;
            self.pers["killstreaksEarnedThisKillstreak"] = 0;
            self setplayercurrentstreak(0);
            self.cur_death_streak++;
            if (self.cur_death_streak > self.death_streak) {
                if (level.rankedmatch && !level.disablestattracking) {
                    self setdstat("HighestStats", "death_streak", self.cur_death_streak);
                }
                self.death_streak = self.cur_death_streak;
            }
            if (self.cur_death_streak >= getdvarint("perk_deathStreakCountRequired")) {
                self enabledeathstreak();
            }
        }
    } else {
        self.pers["totalKillstreakCount"] = 0;
        self.pers["killstreaksEarnedThisKillstreak"] = 0;
    }
    if (!sessionmodeiszombiesgame() && killstreaks::is_killstreak_weapon(weapon)) {
        level.globalkillstreaksdeathsfrom++;
    }
}

// Namespace globallogic_player
// Params 6, eflags: 0x0
// Checksum 0xb5abadf2, Offset: 0x7118
// Size: 0x23a
function function_6c73fce1(attacker, weapon, smeansofdeath, wasinlaststand, var_a3ad44ab, inflictor) {
    if (level.teambased && (!level.teambased || isplayer(attacker) && attacker != self && self.team != attacker.team)) {
        self addweaponstat(weapon, "deaths", 1, self.class_num, weapon.ispickedup);
        if (wasinlaststand && isdefined(var_a3ad44ab)) {
            victim_weapon = var_a3ad44ab;
        } else {
            victim_weapon = self.lastdroppableweapon;
        }
        if (isdefined(victim_weapon)) {
            self addweaponstat(victim_weapon, "deathsDuringUse", 1, self.class_num, victim_weapon.ispickedup);
        }
        if (smeansofdeath != "MOD_FALLING") {
            if (weapon.name == "explosive_bolt" && isdefined(inflictor) && isdefined(inflictor.ownerweaponatlaunch) && inflictor.owneradsatlaunch) {
                attacker addweaponstat(inflictor.ownerweaponatlaunch, "kills", 1, attacker.class_num, inflictor.ownerweaponatlaunch.ispickedup, 1);
            } else {
                attacker addweaponstat(weapon, "kills", 1, attacker.class_num, weapon.ispickedup);
            }
        }
        if (smeansofdeath == "MOD_HEAD_SHOT") {
            attacker addweaponstat(weapon, "headshots", 1, attacker.class_num, weapon.ispickedup);
        }
        if (smeansofdeath == "MOD_PROJECTILE") {
            attacker addweaponstat(weapon, "direct_hit_kills", 1);
        }
        if (self ability_player::gadget_checkheroabilitykill(attacker)) {
            attacker addweaponstat(attacker.heroability, "kills_while_active", 1);
        }
    }
}

// Namespace globallogic_player
// Params 4, eflags: 0x0
// Checksum 0x39fe93ce, Offset: 0x7360
// Size: 0x262
function function_caa6d8d5(attacker, einflictor, weapon, smeansofdeath) {
    if (isdefined(weapon) && (!isplayer(attacker) || self util::isenemyplayer(attacker) == 0 || killstreaks::is_killstreak_weapon(weapon))) {
        level notify(#"reset_obituary_count");
        level.lastobituaryplayercount = 0;
        level.lastobituaryplayer = undefined;
    } else {
        if (isdefined(level.lastobituaryplayer) && level.lastobituaryplayer == attacker) {
            level.lastobituaryplayercount++;
        } else {
            level notify(#"reset_obituary_count");
            level.lastobituaryplayer = attacker;
            level.lastobituaryplayercount = 1;
        }
        level thread scoreevents::decrementlastobituaryplayercountafterfade();
        if (level.lastobituaryplayercount >= 4) {
            level notify(#"reset_obituary_count");
            level.lastobituaryplayercount = 0;
            level.lastobituaryplayer = undefined;
            self thread scoreevents::uninterruptedobitfeedkills(attacker, weapon);
        }
    }
    if (isdefined(weapon) && (!isplayer(attacker) || !killstreaks::is_killstreak_weapon(weapon))) {
        behaviortracker::function_702c6ee2(attacker, self);
    }
    overrideentitycamera = killstreaks::should_override_entity_camera_in_demo(attacker, weapon);
    if (isdefined(einflictor) && einflictor.archetype === "robot") {
        if (smeansofdeath == "MOD_HIT_BY_OBJECT") {
            weapon = getweapon("combat_robot_marker");
        }
        smeansofdeath = "MOD_RIFLE_BULLET";
    }
    if (level.teambased && isdefined(attacker.pers) && self.team == attacker.team && smeansofdeath == "MOD_GRENADE" && level.friendlyfire == 0) {
        obituary(self, self, weapon, smeansofdeath);
        demo::bookmark("kill", gettime(), self, self, 0, einflictor, overrideentitycamera);
        return;
    }
    obituary(self, attacker, weapon, smeansofdeath);
    demo::bookmark("kill", gettime(), attacker, self, 0, einflictor, overrideentitycamera);
}

// Namespace globallogic_player
// Params 5, eflags: 0x0
// Checksum 0xfe9789fa, Offset: 0x75d0
// Size: 0x2c4
function function_41055c90(einflictor, attacker, smeansofdeath, weapon, shitloc) {
    awardassists = 0;
    self.suicide = 0;
    if (isdefined(self.switching_teams)) {
        if (isdefined(level.teams[self.leaving_team]) && isdefined(level.teams[self.joining_team]) && !level.teambased && level.teams[self.leaving_team] != level.teams[self.joining_team]) {
            playercounts = self teams::count_players();
            playercounts[self.leaving_team]--;
            playercounts[self.joining_team]++;
            if (playercounts[self.joining_team] - playercounts[self.leaving_team] > 1) {
                scoreevents::processscoreevent("suicide", self);
                self thread rank::giverankxp("suicide");
                self globallogic_score::incpersstat("suicides", 1);
                self.suicides = self globallogic_score::getpersstat("suicides");
                self.suicide = 1;
            }
        }
    } else {
        scoreevents::processscoreevent("suicide", self);
        self globallogic_score::incpersstat("suicides", 1);
        self.suicides = self globallogic_score::getpersstat("suicides");
        if (smeansofdeath == "MOD_SUICIDE" && shitloc == "none" && self.throwinggrenade) {
            self.lastgrenadesuicidetime = gettime();
        }
        if (level.maxsuicidesbeforekick > 0 && level.maxsuicidesbeforekick <= self.suicides) {
            self notify(#"teamkillkicked");
            self function_361da015();
        }
        thread battlechatter::on_player_suicide_or_team_kill(self, "suicide");
        awardassists = 1;
        self.suicide = 1;
    }
    if (isdefined(self.friendlydamage)) {
        self iprintln(%MP_FRIENDLY_FIRE_WILL_NOT);
        if (level.teamkillpointloss) {
            scoresub = self [[ level.getteamkillscore ]](einflictor, attacker, smeansofdeath, weapon);
            score = globallogic_score::_getplayerscore(attacker) - scoresub;
            if (score < 0) {
                score = 0;
            }
            globallogic_score::_setplayerscore(attacker, score);
        }
    }
    return awardassists;
}

// Namespace globallogic_player
// Params 5, eflags: 0x0
// Checksum 0x240c5418, Offset: 0x78a0
// Size: 0x23a
function function_d7a6cc2b(einflictor, attacker, smeansofdeath, weapon, shitloc) {
    scoreevents::processscoreevent("team_kill", attacker);
    self.teamkilled = 1;
    if (!ignoreteamkills(weapon, smeansofdeath)) {
        teamkill_penalty = self [[ level.getteamkillpenalty ]](einflictor, attacker, smeansofdeath, weapon);
        attacker globallogic_score::incpersstat("teamkills_nostats", teamkill_penalty, 0);
        attacker globallogic_score::incpersstat("teamkills", 1);
        attacker.teamkillsthisround++;
        if (level.teamkillpointloss) {
            scoresub = self [[ level.getteamkillscore ]](einflictor, attacker, smeansofdeath, weapon);
            score = globallogic_score::_getplayerscore(attacker) - scoresub;
            if (score < 0) {
                score = 0;
            }
            globallogic_score::_setplayerscore(attacker, score);
        }
        if (globallogic_utils::gettimepassed() < 5000) {
            teamkilldelay = 1;
        } else if (attacker.pers["teamkills_nostats"] > 1 && globallogic_utils::gettimepassed() < 8000 + attacker.pers["teamkills_nostats"] * 1000) {
            teamkilldelay = 1;
        } else {
            teamkilldelay = attacker teamkilldelay();
        }
        if (teamkilldelay > 0) {
            attacker.teamkillpunish = 1;
            attacker thread wait_and_suicide();
            if (attacker function_a4451c91(teamkilldelay)) {
                attacker notify(#"teamkillkicked");
                attacker function_b8f126c4();
            }
            attacker thread function_a1ea27f6();
        }
        if (isplayer(attacker)) {
            thread battlechatter::on_player_suicide_or_team_kill(attacker, "teamkill");
        }
    }
}

// Namespace globallogic_player
// Params 0, eflags: 0x0
// Checksum 0xbcf97e75, Offset: 0x7ae8
// Size: 0x32
function wait_and_suicide() {
    self endon(#"disconnect");
    self util::freeze_player_controls(1);
    wait 0.25;
    self suicide();
}

// Namespace globallogic_player
// Params 4, eflags: 0x0
// Checksum 0x9e9b428c, Offset: 0x7b28
// Size: 0x172
function function_3f735e1d(einflictor, attacker, weapon, lpattackteam) {
    pixbeginevent("PlayerKilled assists");
    if (isdefined(self.attackers)) {
        for (j = 0; j < self.attackers.size; j++) {
            player = self.attackers[j];
            if (!isdefined(player)) {
                continue;
            }
            if (player == attacker) {
                continue;
            }
            if (player.team != lpattackteam) {
                continue;
            }
            damage_done = self.attackerdamage[player.clientid].damage;
            player thread globallogic_score::processassist(self, damage_done, self.attackerdamage[player.clientid].weapon);
        }
    }
    if (level.teambased) {
        self globallogic_score::processkillstreakassists(attacker, einflictor, weapon);
    }
    if (isdefined(self.lastattackedshieldplayer) && isdefined(self.lastattackedshieldtime) && self.lastattackedshieldplayer != attacker) {
        if (gettime() - self.lastattackedshieldtime < 4000) {
            self.lastattackedshieldplayer thread globallogic_score::processshieldassist(self);
        }
    }
    pixendevent();
}

// Namespace globallogic_player
// Params 5, eflags: 0x0
// Checksum 0x263e77b9, Offset: 0x7ca8
// Size: 0x652
function function_489d248c(einflictor, attacker, smeansofdeath, weapon, shitloc) {
    if (isdefined(level.killstreaksgivegamescore) && (!isdefined(killstreaks::get_killstreak_for_weapon(weapon)) || level.killstreaksgivegamescore)) {
        globallogic_score::inctotalkills(attacker.team);
    }
    if (getdvarint("teamOpsEnabled") == 1) {
        if (isdefined(einflictor.teamops) && isdefined(einflictor) && einflictor.teamops) {
            if (isdefined(level.killstreaksgivegamescore) && (!isdefined(killstreaks::get_killstreak_for_weapon(weapon)) || level.killstreaksgivegamescore)) {
                globallogic_score::giveteamscore("kill", attacker.team, undefined, self);
            }
            return;
        }
    }
    attacker thread globallogic_score::givekillstats(smeansofdeath, weapon, self);
    if (isalive(attacker)) {
        pixbeginevent("killstreak");
        if (!isdefined(einflictor) || !isdefined(einflictor.requireddeathcount) || attacker.deathcount == einflictor.requireddeathcount) {
            shouldgivekillstreak = killstreaks::should_give_killstreak(weapon);
            if (shouldgivekillstreak) {
                attacker killstreaks::add_to_killstreak_count(weapon);
            }
            attacker.pers["cur_total_kill_streak"]++;
            attacker setplayercurrentstreak(attacker.pers["cur_total_kill_streak"]);
            if (isdefined(level.killstreaks) && shouldgivekillstreak) {
                attacker.pers["cur_kill_streak"]++;
                if (attacker.pers["cur_kill_streak"] >= 2) {
                    if (attacker.pers["cur_kill_streak"] == 10) {
                        attacker challenges::killstreakten();
                    }
                    if (attacker.pers["cur_kill_streak"] <= 30) {
                        scoreevents::processscoreevent("killstreak_" + attacker.pers["cur_kill_streak"], attacker, self, weapon);
                    } else {
                        scoreevents::processscoreevent("killstreak_more_than_30", attacker, self, weapon);
                    }
                }
                if (!isdefined(level.usingmomentum) || !level.usingmomentum) {
                    if (getdvarint("teamOpsEnabled") == 0) {
                        attacker thread killstreaks::give_for_streak();
                    }
                }
            }
        }
        pixendevent();
    }
    if (attacker.pers["cur_kill_streak"] > attacker.kill_streak) {
        if (level.rankedmatch && !level.disablestattracking) {
            attacker setdstat("HighestStats", "kill_streak", attacker.pers["totalKillstreakCount"]);
        }
        attacker.kill_streak = attacker.pers["cur_kill_streak"];
    }
    if (attacker.pers["cur_kill_streak"] > attacker.gametype_kill_streak) {
        attacker persistence::function_e885624a("kill_streak", attacker.pers["cur_kill_streak"]);
        attacker.gametype_kill_streak = attacker.pers["cur_kill_streak"];
    }
    killstreak = killstreaks::get_killstreak_for_weapon(weapon);
    if (isdefined(killstreak)) {
        if (scoreevents::isregisteredevent(killstreak)) {
            scoreevents::processscoreevent(killstreak, attacker, self, weapon);
        }
        if (killstreak == "dart" || isdefined(einflictor) && killstreak == "inventory_dart") {
            einflictor notify(#"veh_collision");
        }
    } else {
        scoreevents::processscoreevent("kill", attacker, self, weapon);
        if (smeansofdeath == "MOD_HEAD_SHOT") {
            scoreevents::processscoreevent("headshot", attacker, self, weapon);
        } else if (weapon_utils::ismeleemod(smeansofdeath)) {
            scoreevents::processscoreevent("melee_kill", attacker, self, weapon);
        }
    }
    attacker thread globallogic_score::trackattackerkill(self.name, self.pers["rank"], self.pers["rankxp"], self.pers["prestige"], self getxuid(1));
    attackername = attacker.name;
    self thread globallogic_score::trackattackeedeath(attackername, attacker.pers["rank"], attacker.pers["rankxp"], attacker.pers["prestige"], attacker getxuid(1));
    self thread medals::setlastkilledby(attacker);
    attacker thread globallogic_score::inckillstreaktracker(weapon);
    if (level.teambased && attacker.team != "spectator") {
        if (isdefined(level.killstreaksgivegamescore) && (!isdefined(killstreak) || level.killstreaksgivegamescore)) {
            globallogic_score::giveteamscore("kill", attacker.team, attacker, self);
        }
    }
    scoresub = level.deathpointloss;
    if (scoresub != 0) {
        globallogic_score::_setplayerscore(self, globallogic_score::_getplayerscore(self) - scoresub);
    }
    level thread playkillbattlechatter(attacker, weapon, self, einflictor);
}

// Namespace globallogic_player
// Params 1, eflags: 0x0
// Checksum 0xd80ea18b, Offset: 0x8308
// Size: 0x19
function should_allow_postgame_death(smeansofdeath) {
    if (smeansofdeath == "MOD_POST_GAME") {
        return true;
    }
    return false;
}

// Namespace globallogic_player
// Params 9, eflags: 0x0
// Checksum 0x20b3fe2c, Offset: 0x8330
// Size: 0xf2
function function_8f2c8c07(einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime, deathanimduration) {
    if (!should_allow_postgame_death(smeansofdeath)) {
        return;
    }
    self weapons::detach_carry_object_model();
    self.sessionstate = "dead";
    self.spectatorclient = -1;
    self.killcamentity = -1;
    self.archivetime = 0;
    self.psoffsettime = 0;
    body = self cloneplayer(deathanimduration, weapon, attacker);
    if (isdefined(body)) {
        self function_39d71623(attacker, idamage, smeansofdeath, weapon, shitloc, vdir, (0, 0, 0), deathanimduration, einflictor, body);
    }
}

// Namespace globallogic_player
// Params 10, eflags: 0x0
// Checksum 0x6a3fc89a, Offset: 0x8430
// Size: 0x239
function callback_playerkilled(einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime, deathanimduration, enteredresurrect) {
    if (!isdefined(enteredresurrect)) {
        enteredresurrect = 0;
    }
    profilelog_begintiming(7, "ship");
    self endon(#"spawned");
    InvalidOpCode(0x54, "state");
    // Unknown operator (0x54, t7_1b, PC)
}

// Namespace globallogic_player
// Params 3, eflags: 0x0
// Checksum 0xdc17590e, Offset: 0x9fb8
// Size: 0xb3
function function_f9dae37e(weapon, smeansofdeath, deathanimduration) {
    defaultplayerdeathwatchtime = 1.75;
    if (smeansofdeath == "MOD_MELEE_ASSASSINATE" || 0 > weapon.deathcamtime) {
        defaultplayerdeathwatchtime = deathanimduration * 0.001 + 0.5;
    } else if (0 < weapon.deathcamtime) {
        defaultplayerdeathwatchtime = weapon.deathcamtime;
    }
    if (isdefined(level.overrideplayerdeathwatchtimer)) {
        defaultplayerdeathwatchtime = [[ level.overrideplayerdeathwatchtimer ]](defaultplayerdeathwatchtime);
    }
    globallogic_utils::waitfortimeornotify(defaultplayerdeathwatchtime, "end_death_delay");
    self notify(#"death_delay_finished");
}

// Namespace globallogic_player
// Params 4, eflags: 0x0
// Checksum 0x3a75cc23, Offset: 0xa078
// Size: 0x65
function should_drop_weapon_on_death(wasteamkill, wassuicide, current_weapon, smeansofdeath) {
    if (wasteamkill) {
        return false;
    }
    if (wassuicide) {
        return false;
    }
    if (smeansofdeath == "MOD_TRIGGER_HURT" && !self isonground()) {
        return false;
    }
    if (isdefined(current_weapon) && current_weapon.isheroweapon) {
        return false;
    }
    return true;
}

// Namespace globallogic_player
// Params 0, eflags: 0x0
// Checksum 0x1d1f21ce, Offset: 0xa0e8
// Size: 0x1e
function function_117043() {
    if (isdefined(self.pers["isBot"])) {
        level.globallarryskilled++;
    }
}

// Namespace globallogic_player
// Params 0, eflags: 0x0
// Checksum 0xec02f9ae, Offset: 0xa110
// Size: 0x42
function function_188bdae1() {
    if (isdefined(self.killstreak_delay_killcam)) {
        while (isdefined(self.killstreak_delay_killcam)) {
            wait 0.1;
        }
        wait 2;
        self killstreaks::reset_killstreak_delay_killcam();
    }
}

// Namespace globallogic_player
// Params 0, eflags: 0x0
// Checksum 0xc104ed62, Offset: 0xa160
// Size: 0x6a
function function_361da015() {
    self globallogic_score::incpersstat("sessionbans", 1);
    self endon(#"disconnect");
    waittillframeend();
    globallogic::gamehistoryplayerkicked();
    ban(self getentitynumber());
    globallogic_audio::leader_dialog("gamePlayerKicked");
}

// Namespace globallogic_player
// Params 0, eflags: 0x0
// Checksum 0xc38916c1, Offset: 0xa1d8
// Size: 0x18a
function function_b8f126c4() {
    self globallogic_score::incpersstat("sessionbans", 1);
    self endon(#"disconnect");
    waittillframeend();
    playlistbanquantum = tweakables::gettweakablevalue("team", "teamkillerplaylistbanquantum");
    playlistbanpenalty = tweakables::gettweakablevalue("team", "teamkillerplaylistbanpenalty");
    if (playlistbanquantum > 0 && playlistbanpenalty > 0) {
        timeplayedtotal = self getdstat("playerstatslist", "time_played_total", "StatValue");
        minutesplayed = timeplayedtotal / 60;
        freebees = 2;
        banallowance = int(floor(minutesplayed / playlistbanquantum)) + freebees;
        if (self.sessionbans > banallowance) {
            self setdstat("playerstatslist", "gametypeban", "StatValue", timeplayedtotal + playlistbanpenalty * 60);
        }
    }
    globallogic::gamehistoryplayerkicked();
    ban(self getentitynumber());
    globallogic_audio::leader_dialog("gamePlayerKicked");
}

// Namespace globallogic_player
// Params 0, eflags: 0x0
// Checksum 0xf84d02aa, Offset: 0xa370
// Size: 0x5c
function teamkilldelay() {
    teamkills = self.pers["teamkills_nostats"];
    if (level.minimumallowedteamkills < 0 || teamkills <= level.minimumallowedteamkills) {
        return 0;
    }
    exceeded = teamkills - level.minimumallowedteamkills;
    return level.teamkillspawndelay * exceeded;
}

// Namespace globallogic_player
// Params 1, eflags: 0x0
// Checksum 0xc7bceeb, Offset: 0xa3d8
// Size: 0x4d
function function_a4451c91(teamkilldelay) {
    if (teamkilldelay && level.minimumallowedteamkills >= 0) {
        if (globallogic_utils::gettimepassed() >= 5000) {
            return true;
        }
        if (self.pers["teamkills_nostats"] > 1) {
            return true;
        }
    }
    return false;
}

// Namespace globallogic_player
// Params 0, eflags: 0x0
// Checksum 0x5baf28d0, Offset: 0xa430
// Size: 0xa1
function function_a1ea27f6() {
    timeperoneteamkillreduction = 20;
    reductionpersecond = 1 / timeperoneteamkillreduction;
    while (true) {
        if (isalive(self)) {
            self.pers["teamkills_nostats"] = self.pers["teamkills_nostats"] - reductionpersecond;
            if (self.pers["teamkills_nostats"] < level.minimumallowedteamkills) {
                self.pers["teamkills_nostats"] = level.minimumallowedteamkills;
                break;
            }
        }
        wait 1;
    }
}

// Namespace globallogic_player
// Params 2, eflags: 0x0
// Checksum 0x3dcbdea8, Offset: 0xa4e0
// Size: 0x39
function ignoreteamkills(weapon, smeansofdeath) {
    if (weapon_utils::ismeleemod(smeansofdeath)) {
        return false;
    }
    if (weapon.ignoreteamkills) {
        return true;
    }
    return false;
}

// Namespace globallogic_player
// Params 9, eflags: 0x0
// Checksum 0xa597e291, Offset: 0xa528
// Size: 0x6a
function callback_playerlaststand(einflictor, eattacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime, deathanimduration) {
    laststand::playerlaststand(einflictor, eattacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime, deathanimduration);
}

// Namespace globallogic_player
// Params 5, eflags: 0x0
// Checksum 0xc5405053, Offset: 0xa5a0
// Size: 0x6a
function damageshellshockandrumble(eattacker, einflictor, weapon, smeansofdeath, idamage) {
    self thread weapons::on_damage(eattacker, einflictor, weapon, smeansofdeath, idamage);
    if (!self util::isusingremote()) {
        self playrumbleonentity("damage_heavy");
    }
}

// Namespace globallogic_player
// Params 10, eflags: 0x0
// Checksum 0x2f1dd7e2, Offset: 0xa618
// Size: 0x292
function function_39d71623(attacker, idamage, smeansofdeath, weapon, shitloc, vdir, vattackerorigin, deathanimduration, einflictor, body) {
    if (smeansofdeath == "MOD_HIT_BY_OBJECT" && self getstance() == "prone") {
        self.body = body;
        if (!isdefined(self.switching_teams)) {
            thread deathicons::add(body, self, self.team, 5);
        }
        return;
    }
    ragdoll_now = 0;
    if (isdefined(self.usingvehicle) && self.usingvehicle && isdefined(self.vehicleposition) && self.vehicleposition == 1) {
        ragdoll_now = 1;
    }
    if (isdefined(level.ragdoll_override) && self [[ level.ragdoll_override ]](idamage, smeansofdeath, weapon, shitloc, vdir, vattackerorigin, deathanimduration, einflictor, ragdoll_now, body)) {
        return;
    }
    if (ragdoll_now || self isonladder() || self ismantling() || smeansofdeath == "MOD_CRUSH" || smeansofdeath == "MOD_HIT_BY_OBJECT") {
        body startragdoll();
    }
    if (!self isonground() && smeansofdeath != "MOD_FALLING") {
        if (getdvarint("scr_disable_air_death_ragdoll") == 0) {
            body startragdoll();
        }
    }
    if (smeansofdeath == "MOD_MELEE_ASSASSINATE" && !attacker isonground()) {
        body start_death_from_above_ragdoll(vdir);
    }
    if (self is_explosive_ragdoll(weapon, einflictor)) {
        body start_explosive_ragdoll(vdir, weapon);
    }
    thread delaystartragdoll(body, shitloc, vdir, weapon, einflictor, smeansofdeath);
    if (smeansofdeath == "MOD_CRUSH") {
        body globallogic_vehicle::vehiclecrush();
    }
    self.body = body;
    if (!isdefined(self.switching_teams)) {
        thread deathicons::add(body, self, self.team, 5);
    }
}

// Namespace globallogic_player
// Params 2, eflags: 0x0
// Checksum 0xa442bf90, Offset: 0xa8b8
// Size: 0x83
function is_explosive_ragdoll(weapon, inflictor) {
    if (!isdefined(weapon)) {
        return false;
    }
    if (weapon.name == "destructible_car" || weapon.name == "explodable_barrel") {
        return true;
    }
    if (weapon.projexplosiontype == "grenade") {
        if (isdefined(inflictor) && isdefined(inflictor.stucktoplayer)) {
            if (inflictor.stucktoplayer == self) {
                return true;
            }
        }
    }
    return false;
}

// Namespace globallogic_player
// Params 2, eflags: 0x0
// Checksum 0x4d08bffc, Offset: 0xa948
// Size: 0x132
function start_explosive_ragdoll(dir, weapon) {
    if (!isdefined(self)) {
        return;
    }
    x = randomintrange(50, 100);
    y = randomintrange(50, 100);
    z = randomintrange(10, 20);
    if (weapon.name == "sticky_grenade" || isdefined(weapon) && weapon.name == "explosive_bolt") {
        if (isdefined(dir) && lengthsquared(dir) > 0) {
            x = dir[0] * x;
            y = dir[1] * y;
        }
    } else {
        if (math::cointoss()) {
            x *= -1;
        }
        if (math::cointoss()) {
            y *= -1;
        }
    }
    self startragdoll();
    self launchragdoll((x, y, z));
}

// Namespace globallogic_player
// Params 1, eflags: 0x0
// Checksum 0xec458f77, Offset: 0xaa88
// Size: 0x3a
function start_death_from_above_ragdoll(dir) {
    if (!isdefined(self)) {
        return;
    }
    self startragdoll();
    self launchragdoll((0, 0, -100));
}

// Namespace globallogic_player
// Params 0, eflags: 0x0
// Checksum 0x3818bae0, Offset: 0xaad0
// Size: 0x2a
function notifyconnecting() {
    waittillframeend();
    if (isdefined(self)) {
        level notify(#"connecting", self);
    }
    callback::callback(#"hash_fefe13f5");
}

// Namespace globallogic_player
// Params 6, eflags: 0x0
// Checksum 0xee1a38f2, Offset: 0xab08
// Size: 0x13a
function delaystartragdoll(ent, shitloc, vdir, weapon, einflictor, smeansofdeath) {
    if (isdefined(ent)) {
        deathanim = ent getcorpseanim();
        if (animhasnotetrack(deathanim, "ignore_ragdoll")) {
            return;
        }
    }
    waittillframeend();
    if (!isdefined(ent)) {
        return;
    }
    if (ent isragdoll()) {
        return;
    }
    deathanim = ent getcorpseanim();
    startfrac = 0.35;
    if (animhasnotetrack(deathanim, "start_ragdoll")) {
        times = getnotetracktimes(deathanim, "start_ragdoll");
        if (isdefined(times)) {
            startfrac = times[0];
        }
    }
    waittime = startfrac * getanimlength(deathanim);
    if (waittime > 0) {
        wait waittime;
    }
    if (isdefined(ent)) {
        ent startragdoll();
    }
}

// Namespace globallogic_player
// Params 4, eflags: 0x0
// Checksum 0x7d83252d, Offset: 0xac50
// Size: 0x213
function trackattackerdamage(eattacker, idamage, smeansofdeath, weapon) {
    if (!isdefined(eattacker)) {
        return;
    }
    if (!isplayer(eattacker)) {
        return;
    }
    if (self.attackerdata.size == 0) {
        self.firsttimedamaged = gettime();
    }
    if (!isdefined(self.attackerdata[eattacker.clientid])) {
        self.attackerdamage[eattacker.clientid] = spawnstruct();
        self.attackerdamage[eattacker.clientid].damage = idamage;
        self.attackerdamage[eattacker.clientid].meansofdeath = smeansofdeath;
        self.attackerdamage[eattacker.clientid].weapon = weapon;
        self.attackerdamage[eattacker.clientid].time = gettime();
        self.attackers[self.attackers.size] = eattacker;
        self.attackerdata[eattacker.clientid] = 0;
    } else {
        self.attackerdamage[eattacker.clientid].damage = self.attackerdamage[eattacker.clientid].damage + idamage;
        self.attackerdamage[eattacker.clientid].meansofdeath = smeansofdeath;
        self.attackerdamage[eattacker.clientid].weapon = weapon;
        if (!isdefined(self.attackerdamage[eattacker.clientid].time)) {
            self.attackerdamage[eattacker.clientid].time = gettime();
        }
    }
    self.attackerdamage[eattacker.clientid].lasttimedamaged = gettime();
    if (weapons::is_primary_weapon(weapon)) {
        self.attackerdata[eattacker.clientid] = 1;
    }
}

// Namespace globallogic_player
// Params 5, eflags: 0x0
// Checksum 0x895aeaf7, Offset: 0xae70
// Size: 0xca
function giveattackerandinflictorownerassist(eattacker, einflictor, idamage, smeansofdeath, weapon) {
    if (!allowedassistweapon(weapon)) {
        return;
    }
    self trackattackerdamage(eattacker, idamage, smeansofdeath, weapon);
    if (!isdefined(einflictor)) {
        return;
    }
    if (!isdefined(einflictor.owner)) {
        return;
    }
    if (!isdefined(einflictor.ownergetsassist)) {
        return;
    }
    if (!einflictor.ownergetsassist) {
        return;
    }
    if (isdefined(eattacker) && eattacker == einflictor.owner) {
        return;
    }
    self trackattackerdamage(einflictor.owner, idamage, smeansofdeath, weapon);
}

// Namespace globallogic_player
// Params 5, eflags: 0x0
// Checksum 0x18c8f72, Offset: 0xaf48
// Size: 0xd7
function function_d7eade4e(attacker, einflictor, weapon, smeansofdeath, shitloc) {
    if (globallogic_utils::isheadshot(weapon, shitloc, smeansofdeath, einflictor) && isplayer(attacker) && !weapon_utils::ismeleemod(smeansofdeath)) {
        return "MOD_HEAD_SHOT";
    }
    switch (weapon.name) {
    case "dog_bite":
        smeansofdeath = "MOD_PISTOL_BULLET";
        break;
    case "destructible_car":
        smeansofdeath = "MOD_EXPLOSIVE";
        break;
    case "explodable_barrel":
        smeansofdeath = "MOD_EXPLOSIVE";
        break;
    }
    return smeansofdeath;
}

// Namespace globallogic_player
// Params 2, eflags: 0x0
// Checksum 0x5a8d3002, Offset: 0xb028
// Size: 0x20c
function function_9cedb097(attacker, weapon) {
    if (isai(attacker) && isdefined(attacker.script_owner)) {
        if (!level.teambased || attacker.script_owner.team != self.team) {
            attacker = attacker.script_owner;
        }
    }
    if (attacker.classname == "script_vehicle" && isdefined(attacker.owner)) {
        attacker notify(#"killed", self);
        attacker = attacker.owner;
    }
    if (isai(attacker)) {
        attacker notify(#"killed", self);
    }
    if (isdefined(self.capturinglastflag) && self.capturinglastflag == 1) {
        attacker.lastcapkiller = 1;
    }
    if (isdefined(attacker) && attacker != self && isdefined(weapon)) {
        if (weapon.name == "planemortar") {
            if (!isdefined(attacker.planemortarbda)) {
                attacker.planemortarbda = 0;
            }
            attacker.planemortarbda++;
        } else if (weapon.name == "dart" || weapon.name == "dart_turret") {
            if (!isdefined(attacker.dartbda)) {
                attacker.dartbda = 0;
            }
            attacker.dartbda++;
        } else if (weapon.name == "straferun_rockets" || weapon.name == "straferun_gun") {
            if (isdefined(attacker.straferunbda)) {
                attacker.straferunbda++;
            }
        } else if (weapon.name == "remote_missile_missile" || weapon.name == "remote_missile_bomblet") {
            if (!isdefined(attacker.remotemissilebda)) {
                attacker.remotemissilebda = 0;
            }
            attacker.remotemissilebda++;
        }
    }
    return attacker;
}

// Namespace globallogic_player
// Params 1, eflags: 0x0
// Checksum 0xb1c0469f, Offset: 0xb240
// Size: 0x48
function function_1e4d3508(einflictor) {
    if (isdefined(einflictor) && einflictor.classname == "script_vehicle") {
        einflictor notify(#"killed", self);
        if (isdefined(einflictor.bda)) {
            einflictor.bda++;
        }
    }
    return einflictor;
}

// Namespace globallogic_player
// Params 2, eflags: 0x0
// Checksum 0x7e165753, Offset: 0xb290
// Size: 0xa6
function updateweapon(einflictor, weapon) {
    if (weapon == level.weaponnone && isdefined(einflictor)) {
        if (isdefined(einflictor.targetname) && einflictor.targetname == "explodable_barrel") {
            weapon = getweapon("explodable_barrel");
        } else if (isdefined(einflictor.destructible_type) && issubstr(einflictor.destructible_type, "vehicle_")) {
            weapon = getweapon("destructible_car");
        }
    }
    return weapon;
}

// Namespace globallogic_player
// Params 4, eflags: 0x0
// Checksum 0x2fb1394b, Offset: 0xb340
// Size: 0x7c
function playkillbattlechatter(attacker, weapon, victim, einflictor) {
    if (isplayer(attacker)) {
        if (!killstreaks::is_killstreak_weapon(weapon)) {
            level thread battlechatter::say_kill_battle_chatter(attacker, weapon, victim, einflictor);
        }
    }
    if (isdefined(einflictor)) {
        einflictor notify(#"bhtn_action_notify", "attack_kill");
    }
}

