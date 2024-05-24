#using scripts/cp/gametypes/_player_cam;
#using scripts/cp/_skipto;
#using scripts/cp/_bb;
#using scripts/cp/cybercom/_cybercom_tactical_rig_emergencyreserve;
#using scripts/cp/cybercom/_cybercom_util;
#using scripts/cp/cybercom/_cybercom_tactical_rig;
#using scripts/cp/cybercom/_cybercom;
#using scripts/cp/teams/_teams;
#using scripts/cp/_util;
#using scripts/cp/_scoreevents;
#using scripts/cp/_laststand;
#using scripts/cp/_hazard;
#using scripts/cp/_gamerep;
#using scripts/cp/_flashgrenades;
#using scripts/cp/_challenges;
#using scripts/shared/_burnplayer;
#using scripts/cp/gametypes/_weapons;
#using scripts/cp/gametypes/_weapon_utils;
#using scripts/cp/gametypes/_spectating;
#using scripts/cp/gametypes/_spawnlogic;
#using scripts/cp/gametypes/_spawning;
#using scripts/cp/gametypes/_killcam;
#using scripts/cp/gametypes/_globallogic_vehicle;
#using scripts/cp/gametypes/_globallogic_utils;
#using scripts/cp/gametypes/_globallogic_ui;
#using scripts/cp/gametypes/_globallogic_spawn;
#using scripts/cp/gametypes/_globallogic_score;
#using scripts/cp/gametypes/_globallogic;
#using scripts/cp/gametypes/_loadout;
#using scripts/cp/gametypes/_battlechatter;
#using scripts/cp/gametypes/_save;
#using scripts/shared/weapons/_weapons;
#using scripts/shared/weapons/_weapon_utils;
#using scripts/shared/weapons_shared;
#using scripts/shared/vehicle_shared;
#using scripts/shared/util_shared;
#using scripts/shared/tweakables_shared;
#using scripts/shared/scoreevents_shared;
#using scripts/shared/rank_shared;
#using scripts/shared/persistence_shared;
#using scripts/shared/medals_shared;
#using scripts/shared/math_shared;
#using scripts/shared/laststand_shared;
#using scripts/shared/hud_util_shared;
#using scripts/shared/hud_message_shared;
#using scripts/shared/hostmigration_shared;
#using scripts/shared/gameskill_shared;
#using scripts/shared/flagsys_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/demo_shared;
#using scripts/shared/damagefeedback_shared;
#using scripts/shared/challenges_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/array_shared;
#using scripts/shared/abilities/_ability_power;

#namespace globallogic_player;

// Namespace globallogic_player
// Params 0, eflags: 0x1 linked
// Checksum 0x2842f2f7, Offset: 0x18f8
// Size: 0x4c
function freezeplayerforroundend() {
    self util::clearlowermessage();
    self closeingamemenu();
    self util::freeze_player_controls(1);
}

// Namespace globallogic_player
// Params 0, eflags: 0x1 linked
// Checksum 0xa1d19e41, Offset: 0x1950
// Size: 0x6c
function function_93bd348d() {
    if (isdefined(level.var_8f7c5cd0) && !self flag::exists(level.var_8f7c5cd0)) {
        self flag::init(level.var_8f7c5cd0);
    }
    self flag::init("initial_streamer_ready");
}

// Namespace globallogic_player
// Params 2, eflags: 0x1 linked
// Checksum 0xb3d7b0b3, Offset: 0x19c8
// Size: 0x36c
function function_be51e5e1(player, result) {
    lpselfnum = player getentitynumber();
    lpxuid = player getxuid(1);
    bbprint("global_leave", "name %s client %s xuid %s", player.name, lpselfnum, lpxuid);
    resultstr = result;
    if (isdefined(player.team) && result == player.team) {
        resultstr = "win";
    } else if (result == "allies" || result == "axis") {
        resultstr = "lose";
    }
    timeplayed = game["timepassed"] / 1000;
    recordcomscoreevent("end_match", "match_id", getdemofileid(), "game_variant", "cp", "game_mode", level.gametype, "game_playlist", "N/A", "private_match", sessionmodeisprivate(), "game_map", getdvarstring("mapname"), "player_xuid", player getxuid(1), "player_ip", player getipaddress(), "match_kills", player.kills, "match_deaths", player.deaths, "match_score", player.score, "match_streak", player.pers["best_kill_streak"], "match_captures", player.pers["captures"], "match_defends", player.pers["defends"], "match_headshots", player.pers["headshots"], "match_longshots", player.pers["longshots"], "prestige_max", player.pers["plevel"], "level_max", player.pers["rank"], "match_result", resultstr, "season_pass_owned", player hasseasonpass(0), "match_hits", player.shotshit, "player_gender", player getplayergendertype(currentsessionmode()));
}

// Namespace globallogic_player
// Params 3, eflags: 0x1 linked
// Checksum 0x32f46064, Offset: 0x1d40
// Size: 0x7c
function function_b0d17fc2(mapname, var_66db3636, var_26b0fd19) {
    var_38fbfebf = self getdstat("PlayerStatsByMap", mapname, var_66db3636);
    if (isdefined(var_38fbfebf)) {
        self recordcareerstatformap(var_26b0fd19, mapname, var_38fbfebf);
    }
}

// Namespace globallogic_player
// Params 3, eflags: 0x1 linked
// Checksum 0x69360215, Offset: 0x1dc8
// Size: 0x7c
function function_3b38bcc7(mapname, var_66db3636, var_26b0fd19) {
    var_c1be5d83 = self getdstat("PlayerStatsByMap", mapname, var_66db3636);
    if (isdefined(var_c1be5d83)) {
        self recordcareerflagformap(var_26b0fd19, mapname, var_c1be5d83);
    }
}

// Namespace globallogic_player
// Params 0, eflags: 0x1 linked
// Checksum 0x99c635a8, Offset: 0x1e50
// Size: 0x25a
function function_6c559425() {
    if (!sessionmodeisonlinegame()) {
        return;
    }
    var_5c75060b = skipto::function_23eda99c();
    foreach (mapname in var_5c75060b) {
        var_2b7a9536 = skipto::function_97bb1111(mapname);
        self function_3b38bcc7(mapname, "hasBeenCompleted", "completed");
        self function_3b38bcc7(var_2b7a9536, "hasBeenCompleted", "completed");
        self function_b0d17fc2(mapname, "firstTimeCompletedUTC", "firstTimeCompleted");
        self function_b0d17fc2(var_2b7a9536, "firstTimeCompletedUTC", "firstTimeCompleted");
        self function_b0d17fc2(mapname, "lastCompletedUTC", "lastTimeCompleted");
        self function_b0d17fc2(var_2b7a9536, "lastCompletedUTC", "lastTimeCompleted");
        self function_b0d17fc2(mapname, "numCompletions", "numberTimesCompleted");
        self function_b0d17fc2(var_2b7a9536, "numCompletions", "numberTimesCompleted");
        self function_3b38bcc7(mapname, "allAccoladesComplete", "allAccoladesComplete");
        self function_3b38bcc7(var_2b7a9536, "allAccoladesComplete", "allAccoladesComplete");
    }
}

// Namespace globallogic_player
// Params 0, eflags: 0x1 linked
// Checksum 0xe3119383, Offset: 0x20b8
// Size: 0x204
function function_b18d61a5() {
    if (!sessionmodeisonlinegame()) {
        return;
    }
    self function_6c559425();
    var_b0af8b0a = self getdstat("PlayerStatsList", "CAREER_TOTAL_TIME_PAUSED", "statValue");
    self recordcareerstat("duration_total_paused_seconds", var_b0af8b0a);
    var_add23082 = self getdstat("PlayerStatsList", "CAREER_TOTAL_PLAY_TIME", "statValue");
    self recordcareerstat("duration_total_seconds", var_add23082);
    var_25ebea36 = self getdstat("PlayerStatsList", "KILLS", "statValue");
    self recordcareerstat("kills_Total", var_25ebea36);
    var_184f557a = self getdstat("PlayerStatsList", "DEATHS", "statValue");
    self recordcareerstat("deaths_Total", var_184f557a);
    var_ff16b041 = self getdstat("deadOpsArcade", "totalGamesPlayed");
    self recordcareerstat("deadOps_Total", var_ff16b041);
}

// Namespace globallogic_player
// Params 0, eflags: 0x1 linked
// Checksum 0x23f67c8c, Offset: 0x22c8
// Size: 0x1dd4
function callback_playerconnect() {
    function_93bd348d();
    thread notifyconnecting();
    self.statusicon = "hud_status_connecting";
    self waittill(#"begin");
    if (isdefined(level.reset_clientdvars)) {
        self [[ level.reset_clientdvars ]]();
    }
    waittillframeend();
    self.statusicon = "";
    self.guid = self getguid();
    checkpointclear();
    savegame::checkpoint_save();
    self function_33d9b2e3();
    self thread function_dc541b6d();
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
    self.movementtracking = spawnstruct();
    self thread util::trackwallrunningdistance();
    self thread util::tracksprintdistance();
    self thread util::trackdoublejumpdistance();
    lpselfnum = self getentitynumber();
    lpguid = self getguid();
    logprint("J;" + lpguid + ";" + lpselfnum + ";" + self.name + "\n");
    lpxuid = self getxuid(1);
    bbprint("global_joins", "name %s client %s xuid %s", self.name, lpselfnum, lpxuid);
    if (!sessionmodeiszombiesgame()) {
        self util::show_hud(1);
        self setclientuivisibilityflag("weapon_hud_visible", 1);
    }
    if (level.forceradar == 1) {
        self.pers["hasRadar"] = 1;
        self.hasspyplane = 1;
        level.activeuavs[self getentitynumber()] = 1;
    }
    if (level.forceradar == 2) {
        self setclientuivisibilityflag("g_compassShowEnemies", level.forceradar);
    } else {
        self setclientuivisibilityflag("g_compassShowEnemies", 0);
    }
    self setclientplayersprinttime(level.playersprinttime);
    self setclientnumlives(level.numlives);
    self.lives = level.numlives;
    /#
        self.var_6c733586 = 0;
    #/
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
        self globallogic_score::initpersstat("incaps");
        self.incaps = self globallogic_score::getpersstat("incaps");
        self globallogic_score::initpersstat("chickens", 0);
        self.chickens = self globallogic_score::getpersstat("chickens");
        self globallogic_score::initpersstat("revives");
        self.revives = self globallogic_score::getpersstat("revives");
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
        self globallogic_score::initpersstat("destructions", 0);
        self.destructions = self globallogic_score::getpersstat("destructions");
        self globallogic_score::initpersstat("disables", 0);
        self.disables = self globallogic_score::getpersstat("disables");
        self globallogic_score::initpersstat("escorts", 0);
        self.escorts = self globallogic_score::getpersstat("escorts");
        self globallogic_score::initpersstat("carries", 0);
        self.carries = self globallogic_score::getpersstat("carries");
        self globallogic_score::initpersstat("throws", 0);
        self.destructions = self globallogic_score::getpersstat("throws");
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
        self globallogic_score::initpersstat("sessionbans", 0);
        self.sessionbans = self globallogic_score::getpersstat("sessionbans");
        self globallogic_score::initpersstat("gametypeban", 0);
        self globallogic_score::initpersstat("time_played_total", 0);
        self globallogic_score::initpersstat("time_played_alive", 0);
        self globallogic_score::initpersstat("teamkills", 0);
        self globallogic_score::initpersstat("teamkills_nostats", 0);
        self.teamkillpunish = 0;
        if (level.minimumallowedteamkills >= 0 && self.pers["teamkills_nostats"] > level.minimumallowedteamkills) {
            self thread function_a1ea27f6();
        }
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
    self.leaderdialogqueue = [];
    self.leaderdialogactive = 0;
    self.leaderdialoggroups = [];
    self.currentleaderdialoggroup = "";
    self.currentleaderdialog = "";
    self.currentleaderdialogtime = 0;
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
    self.lastkilltime = 0;
    self.cur_death_streak = 0;
    self disabledeathstreak();
    self.death_streak = 0;
    self.kill_streak = 0;
    self.gametype_kill_streak = 0;
    self.spawnqueueindex = -1;
    self.deathtime = 0;
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
    self.var_5df1dd49 = gettime();
    self.var_247e0696 = 0;
    self.wasaliveatmatchstart = 0;
    self.grenadesused = 0;
    level.players[level.players.size] = self;
    if (level.splitscreen) {
        setdvar("splitscreen_playerNum", level.players.size);
    }
    if (game["state"] == "postgame") {
        self.pers["needteam"] = 1;
        self.pers["team"] = "spectator";
        self.team = "spectator";
        self.sessionteam = "spectator";
        self util::show_hud(0);
        self [[ level.spawnintermission ]]();
        self closeingamemenu();
        profilelog_endtiming(4, "gs=" + game["state"] + " zom=" + sessionmodeiszombiesgame());
        return;
    }
    if ((level.rankedmatch || level.wagermatch || level.leaguematch) && !isdefined(self.pers["lossAlreadyReported"])) {
        if (level.leaguematch) {
            self function_ce78831b();
        }
        globallogic_score::updatelossstats(self);
        self.pers["lossAlreadyReported"] = 1;
    }
    if (!isdefined(self.pers["winstreakAlreadyCleared"])) {
        self globallogic_score::backupandclearwinstreaks();
        self.pers["winstreakAlreadyCleared"] = 1;
    }
    if (self istestclient()) {
        self.pers["isBot"] = 1;
    }
    if (level.rankedmatch || level.leaguematch) {
        self persistence::function_2eb5e93("demoFileID", "0");
    }
    level endon(#"game_ended");
    if (isdefined(level.hostmigrationtimer)) {
        self thread hostmigration::hostmigrationtimerthink();
    }
    if (level.oldschool) {
        self.pers["class"] = undefined;
        self.curclass = self.pers["class"];
    }
    if (isdefined(self.pers["team"])) {
        self.team = self.pers["team"];
    }
    if (isdefined(self.pers["class"])) {
        self.curclass = self.pers["class"];
    }
    if (!isdefined(self.pers["team"]) || isdefined(self.pers["needteam"])) {
        self.pers["needteam"] = undefined;
        self.pers["team"] = "spectator";
        self.team = "spectator";
        self.sessionstate = "dead";
        self globallogic_ui::updateobjectivetext();
        [[ level.spawnspectator ]]();
        [[ level.autoassign ]](0);
        if (level.rankedmatch || level.leaguematch) {
            self thread globallogic_spawn::kickifdontspawn();
        }
        if (self.pers["team"] == "spectator") {
            self.sessionteam = "spectator";
            self thread spectate_player_watcher();
        }
        if (level.teambased) {
            self.sessionteam = self.pers["team"];
            if (!isalive(self)) {
                self.statusicon = "hud_status_dead";
            }
            self thread spectating::set_permissions();
        }
    } else if (self.pers["team"] == "spectator") {
        self setclientscriptmainmenu(game["menu_start_menu"]);
        [[ level.spawnspectator ]]();
        self.sessionteam = "spectator";
        self.sessionstate = "spectator";
        self thread spectate_player_watcher();
    } else {
        self.sessionteam = self.pers["team"];
        self.sessionstate = "dead";
        self globallogic_ui::updateobjectivetext();
        [[ level.spawnspectator ]]();
        if (globallogic_utils::isvalidclass(self.pers["class"])) {
            self thread [[ level.spawnclient ]]();
        } else {
            self globallogic_ui::showmainmenuforteam();
        }
        self thread spectating::set_permissions();
    }
    if (self.sessionteam != "spectator") {
        self [[ level.onspawnplayer ]](1);
    }
    profilelog_endtiming(4, "gs=" + game["state"] + " zom=" + sessionmodeiszombiesgame());
    globallogic::updateteamstatus();
    self function_b18d61a5();
    var_e04e8527 = self getdstat("zmCampaignData", "unlocked");
    recordplayerstats(self, "cpzmUnlocked", var_e04e8527);
}

// Namespace globallogic_player
// Params 0, eflags: 0x1 linked
// Checksum 0x904131a7, Offset: 0x40a8
// Size: 0xbc
function function_33d9b2e3() {
    incaps = self getdstat("PlayerStatsList", "INCAPS", "statValue");
    revives = self getdstat("PlayerStatsList", "REVIVES", "statValue");
    self setnoncheckpointdata("INCAPS", incaps);
    self setnoncheckpointdata("REVIVES", revives);
}

// Namespace globallogic_player
// Params 0, eflags: 0x1 linked
// Checksum 0x574e5587, Offset: 0x4170
// Size: 0x3b0
function function_dc541b6d() {
    self endon(#"disconnect");
    if (!isdefined(getrootmapname())) {
        return;
    }
    while (true) {
        level waittill(#"save_restore");
        var_7fc849de = self getnoncheckpointdata("INCAPS");
        if (isdefined(var_7fc849de)) {
            /#
                assert(var_7fc849de >= self getdstat("player_gender", "player_gender", "player_gender"));
            #/
            /#
                assert(var_7fc849de >= self getdstat("player_gender", getrootmapname(), "player_gender", "player_gender"));
            #/
            self setdstat("PlayerStatsList", "INCAPS", "statValue", var_7fc849de);
            self.incaps = var_7fc849de - self getdstat("PlayerStatsByMap", getrootmapname(), "currentStats", "INCAPS");
            self.pers["incaps"] = self.incaps;
        }
        var_be0f9382 = self getnoncheckpointdata("REVIVES");
        if (isdefined(var_be0f9382)) {
            /#
                assert(var_be0f9382 >= self getdstat("player_gender", "player_gender", "player_gender"));
            #/
            /#
                assert(var_be0f9382 >= self getdstat("player_gender", getrootmapname(), "player_gender", "player_gender"));
            #/
            self setdstat("PlayerStatsList", "REVIVES", "statValue", var_be0f9382);
            self.revives = var_be0f9382 - self getdstat("PlayerStatsByMap", getrootmapname(), "currentStats", "REVIVES");
            /#
                assert(self.revives >= 0);
            #/
            self.pers["revives"] = self.revives;
        }
        var_e8695a49 = self getnoncheckpointdata("lives");
        if (isdefined(var_e8695a49)) {
            self.lives = var_e8695a49;
            self clearnoncheckpointdata("lives");
        }
        self luinotifyevent(%offsite_comms_complete);
    }
}

// Namespace globallogic_player
// Params 0, eflags: 0x1 linked
// Checksum 0x212857ee, Offset: 0x4528
// Size: 0x23c
function spectate_player_watcher() {
    self endon(#"disconnect");
    if (!level.splitscreen && !level.hardcoremode && getdvarint("scr_showperksonspawn") == 1 && game["state"] != "postgame" && !isdefined(self.perkhudelem)) {
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
        wait(0.5);
    }
}

// Namespace globallogic_player
// Params 0, eflags: 0x1 linked
// Checksum 0x55603c54, Offset: 0x4770
// Size: 0xba
function callback_playermigrated() {
    /#
        println("player_gender" + self.name + "player_gender" + gettime());
    #/
    if (isdefined(self.connected) && self.connected) {
        self globallogic_ui::updateobjectivetext();
    }
    level.hostmigrationreturnedplayercount++;
    if (level.hostmigrationreturnedplayercount >= level.players.size * 2 / 3) {
        /#
            println("player_gender");
        #/
        level notify(#"hostmigration_enoughplayers");
    }
}

// Namespace globallogic_player
// Params 0, eflags: 0x1 linked
// Checksum 0x82d8c19a, Offset: 0x4838
// Size: 0x4e4
function callback_playerdisconnect() {
    profilelog_begintiming(5, "ship");
    if (game["state"] != "postgame" && !level.gameended) {
        gamelength = globallogic::getgamelength();
        self globallogic::bbplayermatchend(gamelength, "MP_PLAYER_DISCONNECT", 0);
    }
    checkpointclear();
    savegame::checkpoint_save();
    arrayremovevalue(level.players, self);
    if (level.splitscreen) {
        players = level.players;
        if (players.size <= 1) {
            level thread globallogic::forceend();
        }
        setdvar("splitscreen_playerNum", players.size);
    }
    if (isdefined(self.score) && isdefined(self.pers["team"])) {
        /#
            print("player_gender" + self.pers["player_gender"] + "player_gender" + self.score);
        #/
        level.dropteam += 1;
    }
    [[ level.onplayerdisconnect ]]();
    lpselfnum = self getentitynumber();
    lpguid = self getguid();
    logprint("Q;" + lpguid + ";" + lpselfnum + ";" + self.name + "\n");
    self gamerep::gamerepplayerdisconnected();
    for (entry = 0; entry < level.players.size; entry++) {
        if (isdefined(level.players[entry].pers["killed_players"][self.name])) {
            level.players[entry].pers["killed_players"][self.name] = undefined;
        }
        if (isdefined(level.players[entry].killedplayerscurrent[self.name])) {
            level.players[entry].killedplayerscurrent[self.name] = undefined;
        }
        if (isdefined(level.players[entry].pers["killed_by"][self.name])) {
            level.players[entry].pers["killed_by"][self.name] = undefined;
        }
        if (isdefined(level.players[entry].pers["nemesis_tracking"][self.name])) {
            level.players[entry].pers["nemesis_tracking"][self.name] = undefined;
        }
        if (level.players[entry].pers["nemesis_name"] == self.name) {
            level.players[entry] choosenextbestnemesis();
        }
    }
    function_be51e5e1(self, "disconnected");
    if (level.gameended) {
        self globallogic::removedisconnectedplayerfromplacement();
    }
    globallogic::updateteamstatus();
    profilelog_endtiming(5, "gs=" + game["state"] + " zom=" + sessionmodeiszombiesgame());
    self clearallnoncheckpointdata();
}

// Namespace globallogic_player
// Params 8, eflags: 0x1 linked
// Checksum 0xc0b44ac5, Offset: 0x4d28
// Size: 0xc4
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
// Params 0, eflags: 0x1 linked
// Checksum 0x10e5b686, Offset: 0x4df8
// Size: 0x242
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
                self.pers["nemesis_xuid"] = nemesisplayer getxuid();
                break;
            }
        }
        return;
    }
    self.pers["nemesis_xuid"] = "";
}

// Namespace globallogic_player
// Params 7, eflags: 0x1 linked
// Checksum 0x12d58a6e, Offset: 0x5048
// Size: 0xec
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
// Params 1, eflags: 0x1 linked
// Checksum 0x30463c88, Offset: 0x5140
// Size: 0x190
function figureoutattacker(eattacker) {
    if (isdefined(eattacker)) {
        if (isai(eattacker) && isdefined(eattacker.script_owner)) {
            team = self.team;
            if (isai(self) && isdefined(self.team)) {
                team = self.team;
            }
            if (eattacker.script_owner.team != team) {
                eattacker = eattacker.script_owner;
            }
        }
        if (eattacker.classname == "script_vehicle" && isdefined(eattacker.owner) && !issentient(eattacker)) {
            eattacker = eattacker.owner;
        } else if (eattacker.classname == "auto_turret" && isdefined(eattacker.owner)) {
            eattacker = eattacker.owner;
        }
        if (isdefined(eattacker.remote_owner)) {
            eattacker = eattacker.remote_owner;
        }
    }
    return eattacker;
}

// Namespace globallogic_player
// Params 2, eflags: 0x1 linked
// Checksum 0xffdab1d6, Offset: 0x52d8
// Size: 0xd4
function function_406ab9b7(weapon, einflictor) {
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
// Params 1, eflags: 0x1 linked
// Checksum 0xfd4e0e9d, Offset: 0x53b8
// Size: 0x12
function figureoutfriendlyfire(victim) {
    return level.friendlyfire;
}

// Namespace globallogic_player
// Params 2, eflags: 0x1 linked
// Checksum 0x94942cfe, Offset: 0x53d8
// Size: 0x4e
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
// Params 13, eflags: 0x1 linked
// Checksum 0xcf968bf7, Offset: 0x5430
// Size: 0x1d8c
function callback_playerdamage(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, boneindex, vsurfacenormal) {
    profilelog_begintiming(6, "ship");
    if (game["state"] == "postgame") {
        return;
    }
    if (self.sessionteam == "spectator") {
        return;
    }
    if (isdefined(self.candocombat) && !self.candocombat) {
        return;
    }
    if (self.scene_takedamage === 0) {
        return;
    }
    if (isdefined(self.var_b41cccf7) && self.var_b41cccf7) {
        return;
    }
    if (isdefined(self.b_teleport_invulnerability) && self.b_teleport_invulnerability) {
        return;
    }
    if (isdefined(eattacker) && isplayer(eattacker) && isdefined(eattacker.candocombat) && !eattacker.candocombat) {
        return;
    }
    if (isdefined(level.hostmigrationtimer)) {
        return;
    }
    if (smeansofdeath === "MOD_TRIGGER_HURT" && isdefined(einflictor) && isstring(einflictor.var_75dbd7)) {
        if (einflictor.var_75dbd7 != "none" && einflictor.var_75dbd7 != "false") {
            hazard::do_damage(einflictor.var_75dbd7, idamage, einflictor, self.var_8dcb3948);
            return;
        }
    }
    if (self laststand::player_is_in_laststand()) {
        self notify(#"laststand_damage", idamage);
        return;
    }
    weaponname = weapon.name;
    if ((weaponname == "ai_tank_drone_gun" || weaponname == "ai_tank_drone_rocket") && !level.hardcoremode) {
        if (isdefined(eattacker) && eattacker == self) {
            if (isdefined(einflictor) && isdefined(einflictor.from_ai)) {
                return;
            }
        }
        if (isdefined(eattacker) && isdefined(eattacker.owner) && eattacker.owner == self) {
            return;
        }
    }
    if (weapon.isemp) {
        if (self hasperk("specialty_immuneemp")) {
            return;
        }
        self notify(#"emp_grenaded", eattacker);
    }
    if (isdefined(self.overrideplayerdamage)) {
        overrideplayerdamage = self.overrideplayerdamage;
    } else if (isdefined(level.overrideplayerdamage)) {
        overrideplayerdamage = level.overrideplayerdamage;
    }
    if (isdefined(overrideplayerdamage)) {
        modifieddamage = self [[ overrideplayerdamage ]](einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex);
        if (isdefined(modifieddamage)) {
            if (modifieddamage <= 0) {
                return;
            }
            idamage = modifieddamage;
        }
    }
    /#
        assert(isdefined(idamage), "player_gender");
    #/
    self callback::callback(#"hash_ab5ecf6c");
    if (isdefined(eattacker)) {
        idamage = loadout::cac_modified_damage(self, eattacker, idamage, smeansofdeath, weapon, einflictor, shitloc);
        if (isdefined(modifieddamage)) {
            if (modifieddamage <= 0) {
                return;
            }
            idamage = modifieddamage;
        }
    }
    idamage = custom_gamemodes_modified_damage(self, eattacker, idamage, smeansofdeath, weapon, einflictor, shitloc);
    idamage = int(idamage);
    self.idflags = idflags;
    self.idflagstime = gettime();
    eattacker = figureoutattacker(eattacker);
    idamage = cybercom::function_2b5f1af7(self, eattacker, einflictor, idamage, weapon, shitloc, smeansofdeath);
    if (smeansofdeath != "MOD_FALLING") {
        idamage = gameskill::function_57ab3c9d(self, eattacker, einflictor, idamage, weapon, shitloc, smeansofdeath);
    }
    idamage = gameskill::function_904126cf(self, eattacker, einflictor, idamage, weapon, shitloc, smeansofdeath);
    idamage = cybercom::function_5ad6b98d(eattacker, self, idamage);
    idamage = int(idamage);
    pixbeginevent("PlayerDamage flags/tweaks");
    if (!isdefined(vdir)) {
        idflags |= 4;
    }
    friendly = 0;
    if (self.health != self.maxhealth) {
        self notify(#"hash_b6c93e47", smeansofdeath);
    }
    if (isdefined(einflictor) && isdefined(einflictor.script_noteworthy)) {
        if (einflictor.script_noteworthy == "ragdoll_now") {
            smeansofdeath = "MOD_FALLING";
        }
        if (isdefined(level.overrideweaponfunc)) {
            weapon = [[ level.overrideweaponfunc ]](weapon, einflictor.script_noteworthy);
        }
    }
    if (globallogic_utils::isheadshot(weapon, shitloc, smeansofdeath, einflictor) && isplayer(eattacker)) {
        smeansofdeath = "MOD_HEAD_SHOT";
    }
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
        if (smeansofdeath == "MOD_PISTOL_BULLET" || smeansofdeath == "MOD_RIFLE_BULLET") {
            return;
        } else if (smeansofdeath == "MOD_HEAD_SHOT") {
            idamage = -106;
        }
    }
    if (self player_is_occupant_invulnerable(smeansofdeath)) {
        return;
    }
    if (isdefined(eattacker) && isplayer(eattacker) && self.team != eattacker.team) {
        self.lastattackweapon = weapon;
    }
    weapon = function_406ab9b7(weapon, einflictor);
    pixendevent();
    if (isdefined(eattacker) && isai(eattacker)) {
        if (self.team == eattacker.team && smeansofdeath == "MOD_MELEE") {
            return;
        }
    }
    attackerishittingteammate = isplayer(eattacker) && self util::isenemyplayer(eattacker) == 0;
    if (shitloc == "riotshield") {
        if (attackerishittingteammate && level.friendlyfire == 0) {
            return;
        }
        if ((smeansofdeath == "MOD_PISTOL_BULLET" || smeansofdeath == "MOD_RIFLE_BULLET") && !attackerishittingteammate) {
            if (self.hasriotshieldequipped) {
                if (isplayer(eattacker)) {
                    eattacker.lastattackedshieldplayer = self;
                    eattacker.lastattackedshieldtime = gettime();
                }
                previous_shield_damage = self.shielddamageblocked;
                self.shielddamageblocked += idamage;
                if (self.shielddamageblocked % 400 < previous_shield_damage % 400) {
                    score_event = "shield_blocked_damage";
                    if (self.shielddamageblocked > 2000) {
                        score_event = "shield_blocked_damage_reduced";
                    }
                    if (isdefined(level.scoreinfo[score_event]["value"])) {
                        self addweaponstat(level.weaponriotshield, "score_from_blocked_damage", level.scoreinfo[score_event]["value"]);
                    }
                    thread scoreevents::processscoreevent(score_event, self);
                }
            }
        }
        if (idflags & 32) {
            shitloc = "none";
            if (!(idflags & 64)) {
                idamage *= 0;
            }
        } else if (idflags & -128) {
            if (isdefined(einflictor) && isdefined(einflictor.stucktoplayer) && einflictor.stucktoplayer == self) {
                idamage = 101;
            }
            shitloc = "none";
        } else {
            return;
        }
    }
    if (!(idflags & 2048)) {
        if (smeansofdeath == "MOD_GAS" || isdefined(einflictor) && loadout::isexplosivedamage(smeansofdeath)) {
            if ((einflictor.classname == "grenade" || weaponname == "tabun_gas") && self.lastspawntime + 3500 > gettime() && distancesquared(einflictor.origin, self.lastspawnpoint.origin) < 62500) {
                return;
            }
            if (self function_f698740(eattacker, weapon)) {
                return;
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
            isfrag = weaponname == "frag_grenade";
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
        if (isplayer(eattacker)) {
            eattacker.pers["participation"]++;
        }
        prevhealthratio = self.health / self.maxhealth;
        if (smeansofdeath == "MOD_PISTOL_BULLET" || smeansofdeath == "MOD_RIFLE_BULLET" || smeansofdeath == "MOD_PROJECTILE" || smeansofdeath == "MOD_GRENADE_SPLASH" || smeansofdeath == "MOD_PROJECTILE_SPLASH") {
            if (idamage >= self.health && eattacker != self && self.team != eattacker.team) {
                var_535d0dae = self gameskill::function_10a2e0f5();
                if (var_535d0dae) {
                    self setnormalhealth(2 / self.maxhealth);
                    idamage = 1;
                }
            }
        }
        if (weapon.parentweaponname === "riotshield" && self != eattacker && self.team != eattacker.team) {
            earthquake(0.25, 0.1, self.origin, 16, self);
        }
        if (level.teambased && issentient(eattacker) && self != eattacker && self.team == eattacker.team) {
            pixmarker("BEGIN: PlayerDamage player");
            if (level.friendlyfire == 0) {
                if (weapon.forcedamageshellshockandrumble) {
                    self damageshellshockandrumble(eattacker, einflictor, weapon, smeansofdeath, idamage);
                }
                return;
            } else if (level.friendlyfire == 1) {
                if (idamage < 1) {
                    idamage = 1;
                }
                if (level.friendlyfiredelay && level.friendlyfiredelaytime >= (gettime() - level.starttime - level.discardtime) / 1000) {
                    eattacker.lastdamagewasfromenemy = 0;
                    eattacker.friendlydamage = 1;
                    eattacker finishplayerdamagewrapper(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, boneindex, vsurfacenormal);
                    eattacker.friendlydamage = undefined;
                } else {
                    self.lastdamagewasfromenemy = 0;
                    self finishplayerdamagewrapper(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, boneindex, vsurfacenormal);
                }
            } else if (level.friendlyfire == 2 && isalive(eattacker)) {
                idamage = int(idamage * 0.5);
                if (idamage < 1) {
                    idamage = 1;
                }
                eattacker.lastdamagewasfromenemy = 0;
                eattacker.friendlydamage = 1;
                eattacker finishplayerdamagewrapper(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, boneindex, vsurfacenormal);
                eattacker.friendlydamage = undefined;
            } else if (level.friendlyfire == 3 && isalive(eattacker)) {
                idamage = int(idamage * 0.5);
                if (idamage < 1) {
                    idamage = 1;
                }
                self.lastdamagewasfromenemy = 0;
                eattacker.lastdamagewasfromenemy = 0;
                self finishplayerdamagewrapper(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, boneindex, vsurfacenormal);
                eattacker.friendlydamage = 1;
                eattacker finishplayerdamagewrapper(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, boneindex, vsurfacenormal);
                eattacker.friendlydamage = undefined;
            }
            friendly = 1;
            pixmarker("END: PlayerDamage player");
        } else {
            if (idamage < 1) {
                idamage = 1;
            }
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
            self finishplayerdamagewrapper(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, boneindex, vsurfacenormal);
        }
        if (isdefined(eattacker) && isplayer(eattacker) && eattacker != self) {
            if (damagefeedback::dodamagefeedback(weapon, einflictor, idamage, smeansofdeath)) {
                if (idamage > 0) {
                    if (self.health > 0) {
                        perkfeedback = function_6b151027(self, weapon, smeansofdeath, einflictor);
                    }
                    eattacker thread damagefeedback::update(smeansofdeath, einflictor, perkfeedback);
                }
            }
        }
        if (sessionmodeiscampaignzombiesgame() && isdefined(level.var_652674d2)) {
            self [[ level.var_652674d2 ]](weapon, eattacker, idamage, smeansofdeath);
        }
        self.hasdonecombat = 1;
    }
    pixbeginevent("PlayerDamage log");
    /#
        if (getdvarint("player_gender")) {
            if (isdefined(eattacker.clientid)) {
                println("player_gender" + self getentitynumber() + "player_gender" + self.health + "player_gender" + eattacker.clientid + "player_gender" + isplayer(einflictor) + "player_gender" + idamage + "player_gender" + shitloc);
            } else {
                println("player_gender" + self getentitynumber() + "player_gender" + self.health + "player_gender" + eattacker getentitynumber() + "player_gender" + isplayer(einflictor) + "player_gender" + idamage + "player_gender" + shitloc);
            }
        }
    #/
    if (self.sessionstate != "dead") {
        lpselfnum = self getentitynumber();
        lpselfname = self.name;
        lpselfteam = self.team;
        lpselfguid = self getguid();
        lpattackerteam = "";
        var_f23089ea = self laststand::player_is_in_laststand();
        if (isplayer(eattacker)) {
            lpattacknum = eattacker getentitynumber();
            lpattackguid = eattacker getguid();
            lpattackname = eattacker.name;
            lpattackerteam = eattacker.team;
        } else {
            var_90a0048 = "world";
            lpattackerteam = "world";
            lpattacknum = -1;
            lpattackguid = "";
            lpattackname = "";
        }
        bb::logdamage(eattacker, self, weapon, idamage, smeansofdeath, shitloc, 0, var_f23089ea);
        logprint("D;" + lpselfguid + ";" + lpselfnum + ";" + lpselfteam + ";" + lpselfname + ";" + lpattackguid + ";" + lpattacknum + ";" + lpattackerteam + ";" + lpattackname + ";" + weapon.name + ";" + idamage + ";" + smeansofdeath + ";" + shitloc + "\n");
    }
    pixendevent();
    profilelog_endtiming(6, "gs=" + game["state"] + " zom=" + sessionmodeiszombiesgame());
}

// Namespace globallogic_player
// Params 1, eflags: 0x1 linked
// Checksum 0xf03a05a0, Offset: 0x71c8
// Size: 0x74
function player_is_occupant_invulnerable(smeansofdeath) {
    if (self isremotecontrolling()) {
        return 0;
    }
    if (!isdefined(level.vehicle_drivers_are_invulnerable)) {
        level.vehicle_drivers_are_invulnerable = 0;
    }
    invulnerable = level.vehicle_drivers_are_invulnerable && self vehicle::player_is_driver();
    return invulnerable;
}

// Namespace globallogic_player
// Params 0, eflags: 0x1 linked
// Checksum 0xa6c42de4, Offset: 0x7248
// Size: 0x34
function resetattackerlist() {
    self.attackers = [];
    self.attackerdata = [];
    self.attackerdamage = [];
    self.firsttimedamaged = 0;
}

// Namespace globallogic_player
// Params 4, eflags: 0x1 linked
// Checksum 0x9b616641, Offset: 0x7288
// Size: 0x138
function function_6b151027(player, weapon, smeansofdeath, einflictor) {
    perkfeedback = undefined;
    var_bb61b344 = loadout::function_bb61b344(player);
    hasflakjacket = player hasperk("specialty_flakjacket");
    isexplosivedamage = loadout::isexplosivedamage(smeansofdeath);
    isflashorstundamage = weapon_utils::isflashorstundamage(weapon, smeansofdeath);
    if (isflashorstundamage && var_bb61b344) {
        perkfeedback = "tacticalMask";
    } else if (isexplosivedamage && hasflakjacket && !weapon.ignoresflakjacket && !isaikillstreakdamage(weapon, einflictor)) {
        perkfeedback = "flakjacket";
    }
    return perkfeedback;
}

// Namespace globallogic_player
// Params 2, eflags: 0x1 linked
// Checksum 0x84a15e51, Offset: 0x73c8
// Size: 0x5c
function isaikillstreakdamage(weapon, einflictor) {
    if (weapon.isaikillstreakdamage) {
        if (weapon.name != "ai_tank_drone_rocket" || isdefined(einflictor.firedbyai)) {
            return true;
        }
    }
    return false;
}

// Namespace globallogic_player
// Params 13, eflags: 0x1 linked
// Checksum 0x9a23bea7, Offset: 0x7430
// Size: 0x25c
function finishplayerdamagewrapper(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, boneindex, vsurfacenormal) {
    pixbeginevent("finishPlayerDamageWrapper");
    if (!level.console && idflags & 8 && isplayer(eattacker)) {
        /#
            println("player_gender" + self getentitynumber() + "player_gender" + self.health + "player_gender" + eattacker.clientid + "player_gender" + isplayer(einflictor) + "player_gender" + idamage + "player_gender" + shitloc);
        #/
        eattacker addplayerstat("penetration_shots", 1);
    }
    if (getdvarstring("scr_csmode") != "") {
        self shellshock("damage_mp", 0.2);
    }
    self damageshellshockandrumble(eattacker, einflictor, weapon, smeansofdeath, idamage);
    self ability_power::power_loss_event_took_damage(eattacker, einflictor, weapon, smeansofdeath, idamage);
    self finishplayerdamage(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, boneindex, vsurfacenormal);
    pixendevent();
}

// Namespace globallogic_player
// Params 1, eflags: 0x1 linked
// Checksum 0x7f8e66a8, Offset: 0x7698
// Size: 0xe
function allowedassistweapon(weapon) {
    return false;
}

// Namespace globallogic_player
// Params 2, eflags: 0x1 linked
// Checksum 0x575a1958, Offset: 0x76b0
// Size: 0x30a
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
        return;
    }
    self.pers["totalKillstreakCount"] = 0;
    self.pers["killstreaksEarnedThisKillstreak"] = 0;
}

// Namespace globallogic_player
// Params 6, eflags: 0x1 linked
// Checksum 0xe3a9073b, Offset: 0x79c8
// Size: 0x254
function function_6c73fce1(attacker, weapon, smeansofdeath, wasinlaststand, var_a3ad44ab, inflictor) {
    if (level.teambased && (!level.teambased || isplayer(attacker) && attacker != self && self.team != attacker.team)) {
        self addweaponstat(weapon, "deaths", 1);
        if (wasinlaststand && isdefined(var_a3ad44ab)) {
            victim_weapon = var_a3ad44ab;
        } else {
            victim_weapon = self.lastdroppableweapon;
        }
        if (isdefined(victim_weapon)) {
            self addweaponstat(victim_weapon, "deathsDuringUse", 1);
        }
        if (smeansofdeath != "MOD_FALLING") {
            if (weapon.name == "explosive_bolt" && isdefined(inflictor) && isdefined(inflictor.ownerweaponatlaunch) && inflictor.owneradsatlaunch) {
                attacker addweaponstat(inflictor.ownerweaponatlaunch, "kills", 1, attacker.class_num, 0, 1);
            } else {
                attacker addweaponstat(weapon, "kills", 1, attacker.class_num);
            }
        }
        if (smeansofdeath == "MOD_HEAD_SHOT") {
            attacker addweaponstat(weapon, "headshots", 1);
        }
        if (smeansofdeath == "MOD_PROJECTILE") {
            attacker addweaponstat(weapon, "direct_hit_kills", 1);
        }
    }
}

// Namespace globallogic_player
// Params 4, eflags: 0x1 linked
// Checksum 0x7d4921c5, Offset: 0x7c28
// Size: 0x224
function function_caa6d8d5(attacker, einflictor, weapon, smeansofdeath) {
    if (!isplayer(attacker) || self util::isenemyplayer(attacker) == 0) {
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
    if (level.teambased && isdefined(attacker.pers) && self.team == attacker.team && smeansofdeath == "MOD_GRENADE" && level.friendlyfire == 0) {
        obituary(self, self, weapon, smeansofdeath);
        demo::bookmark("kill", gettime(), self, self, 0, einflictor);
        return;
    }
    obituary(self, attacker, weapon, smeansofdeath);
    demo::bookmark("kill", gettime(), self, attacker, 0, einflictor);
}

// Namespace globallogic_player
// Params 5, eflags: 0x1 linked
// Checksum 0x657bc51d, Offset: 0x7e58
// Size: 0x340
function function_41055c90(einflictor, attacker, smeansofdeath, weapon, shitloc) {
    awardassists = 0;
    if (isdefined(self.switching_teams)) {
        if (isdefined(level.teams[self.leaving_team]) && isdefined(level.teams[self.joining_team]) && !level.teambased && level.teams[self.leaving_team] != level.teams[self.joining_team]) {
            playercounts = self teams::count_players();
            playercounts[self.leaving_team]--;
            playercounts[self.joining_team]++;
            if (playercounts[self.joining_team] - playercounts[self.leaving_team] > 1) {
                thread scoreevents::processscoreevent("suicide", self);
                self thread rank::giverankxp("suicide");
                self globallogic_score::incpersstat("suicides", 1);
                self.suicides = self globallogic_score::getpersstat("suicides");
            }
        }
    } else {
        thread scoreevents::processscoreevent("suicide", self);
        self globallogic_score::incpersstat("suicides", 1);
        self.suicides = self globallogic_score::getpersstat("suicides");
        if (smeansofdeath == "MOD_SUICIDE" && shitloc == "none" && self.throwinggrenade) {
            self.lastgrenadesuicidetime = gettime();
        }
        if (level.maxsuicidesbeforekick > 0 && level.maxsuicidesbeforekick <= self.suicides) {
            self notify(#"teamkillkicked");
            self function_361da015();
        }
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
// Params 5, eflags: 0x1 linked
// Checksum 0xc61cf281, Offset: 0x81a0
// Size: 0x2bc
function function_d7a6cc2b(einflictor, attacker, smeansofdeath, weapon, shitloc) {
    thread scoreevents::processscoreevent("team_kill", attacker);
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
    }
}

// Namespace globallogic_player
// Params 0, eflags: 0x1 linked
// Checksum 0x5987c612, Offset: 0x8468
// Size: 0x44
function wait_and_suicide() {
    self endon(#"disconnect");
    self util::freeze_player_controls(1);
    wait(0.25);
    self suicide();
}

// Namespace globallogic_player
// Params 4, eflags: 0x1 linked
// Checksum 0x43a42d3e, Offset: 0x84b8
// Size: 0x1a4
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
    if (isdefined(self.lastattackedshieldplayer) && isdefined(self.lastattackedshieldtime) && self.lastattackedshieldplayer != attacker) {
        if (gettime() - self.lastattackedshieldtime < 4000) {
            self.lastattackedshieldplayer thread globallogic_score::processshieldassist(self);
        }
    }
    pixendevent();
}

// Namespace globallogic_player
// Params 5, eflags: 0x1 linked
// Checksum 0xe8a9f810, Offset: 0x8668
// Size: 0x73c
function function_489d248c(einflictor, attacker, smeansofdeath, weapon, shitloc) {
    globallogic_score::inctotalkills(attacker.team);
    attacker thread globallogic_score::givekillstats(smeansofdeath, weapon, self);
    if (isalive(attacker)) {
        pixbeginevent("killstreak");
        if (!isdefined(einflictor) || !isdefined(einflictor.requireddeathcount) || attacker.deathcount == einflictor.requireddeathcount) {
            attacker.pers["cur_total_kill_streak"]++;
            attacker setplayercurrentstreak(attacker.pers["cur_total_kill_streak"]);
            if (isdefined(level.killstreaks)) {
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
    if ((smeansofdeath == "MOD_MELEE" || smeansofdeath == "MOD_MELEE_ASSASSINATE") && level.gametype == "gun") {
    } else {
        scoreevents::processscoreevent("kill", attacker, self, weapon);
    }
    if (smeansofdeath == "MOD_HEAD_SHOT") {
        scoreevents::processscoreevent("headshot", attacker, self, weapon);
    } else if (smeansofdeath == "MOD_MELEE" || smeansofdeath == "MOD_MELEE_ASSASSINATE") {
        if (weapon.isriotshield) {
            scoreevents::processscoreevent("melee_kill_with_riot_shield", attacker, self, weapon);
            if (isdefined(attacker.class_num)) {
                var_d5c933b7 = attacker getloadoutitem(attacker.class_num, "primary");
                var_68cc767b = attacker getloadoutitem(attacker.class_num, "secondary");
                if (var_68cc767b && level.tbl_weaponids[var_68cc767b]["reference"] == "riotshield" && (var_d5c933b7 && level.tbl_weaponids[var_d5c933b7]["reference"] == "riotshield" && !var_68cc767b || !var_d5c933b7)) {
                    attacker addweaponstat(weapon, "NoLethalKills", 1);
                }
            }
        } else {
            scoreevents::processscoreevent("melee_kill", attacker, self, weapon);
        }
    }
    attacker thread globallogic_score::trackattackerkill(self.name, self.pers["rank"], self.pers["rankxp"], self.pers["prestige"], self getxuid());
    attackername = attacker.name;
    self thread globallogic_score::trackattackeedeath(attackername, attacker.pers["rank"], attacker.pers["rankxp"], attacker.pers["prestige"], attacker getxuid());
    self thread medals::setlastkilledby(attacker);
    attacker thread globallogic_score::inckillstreaktracker(weapon);
    if (level.teambased && attacker.team != "spectator") {
        globallogic_score::giveteamscore("kill", attacker.team, attacker, self);
    }
    scoresub = level.deathpointloss;
    if (scoresub != 0) {
        globallogic_score::_setplayerscore(self, globallogic_score::_getplayerscore(self) - scoresub);
    }
    level thread playkillbattlechatter(attacker, weapon, self);
}

// Namespace globallogic_player
// Params 9, eflags: 0x1 linked
// Checksum 0x1021cfe6, Offset: 0x8db0
// Size: 0x1e12
function callback_playerkilled(einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime, deathanimduration) {
    profilelog_begintiming(7, "ship");
    self endon(#"spawned");
    self notify(#"killed_player");
    self callback::callback(#"hash_bc435202");
    self flagsys::clear("loadout_given");
    if (self.sessionteam == "spectator") {
        return;
    }
    if (game["state"] == "postgame") {
        return;
    }
    self needsrevive(0);
    if (isdefined(self.burning) && self.burning == 1) {
        self setburn(0);
    }
    self.suicide = 0;
    self.teamkilled = 0;
    self.meleeattackers = undefined;
    if (isdefined(level.takelivesondeath) && level.takelivesondeath == 1) {
        if (self.pers["lives"]) {
            self.pers["lives"]--;
            if (self.pers["lives"] == 0) {
                level notify(#"player_eliminated");
                self notify(#"player_eliminated");
            }
        }
    }
    weapon = updateweapon(einflictor, weapon);
    pixbeginevent("PlayerKilled pre constants");
    wasinlaststand = 0;
    deathtimeoffset = 0;
    var_a3ad44ab = undefined;
    attackerstance = undefined;
    self.laststandthislife = undefined;
    self.vattackerorigin = undefined;
    if (isdefined(self.uselaststandparams)) {
        self.uselaststandparams = undefined;
        /#
            assert(isdefined(self.laststandparams));
        #/
        if (!isdefined(attacker) || !isplayer(attacker) || attacker.team != self.team || !level.teambased || attacker == self) {
            einflictor = self.laststandparams.einflictor;
            attacker = self.laststandparams.attacker;
            attackerstance = self.laststandparams.attackerstance;
            idamage = self.laststandparams.idamage;
            smeansofdeath = self.laststandparams.smeansofdeath;
            weapon = self.laststandparams.sweapon;
            vdir = self.laststandparams.vdir;
            shitloc = self.laststandparams.shitloc;
            self.vattackerorigin = self.laststandparams.vattackerorigin;
            deathtimeoffset = (gettime() - self.laststandparams.laststandstarttime) / 1000;
            if (isdefined(self.var_54a2d6ec)) {
                wasinlaststand = 1;
                var_a3ad44ab = self.var_54a2d6ec;
            }
        }
        self.laststandparams = undefined;
    }
    bestplayer = undefined;
    bestplayermeansofdeath = undefined;
    obituarymeansofdeath = undefined;
    bestplayerweapon = undefined;
    obituaryweapon = weapon;
    assistedsuicide = 0;
    if ((isdefined(attacker.ismagicbullet) && (!isdefined(attacker) || attacker.classname == "trigger_hurt" || attacker.classname == "worldspawn" || attacker.ismagicbullet == 1) || attacker == self) && isdefined(self.attackers)) {
        if (!isdefined(bestplayer)) {
            for (i = 0; i < self.attackers.size; i++) {
                player = self.attackers[i];
                if (!isdefined(player)) {
                    continue;
                }
                if (!isdefined(self.attackerdamage[player.clientid]) || !isdefined(self.attackerdamage[player.clientid].damage)) {
                    continue;
                }
                if (level.teambased && (player == self || player.team == self.team)) {
                    continue;
                }
                if (self.attackerdamage[player.clientid].lasttimedamaged + 2500 < gettime()) {
                    continue;
                }
                if (!allowedassistweapon(self.attackerdamage[player.clientid].weapon)) {
                    continue;
                }
                if (self.attackerdamage[player.clientid].damage > 1 && !isdefined(bestplayer)) {
                    bestplayer = player;
                    bestplayermeansofdeath = self.attackerdamage[player.clientid].meansofdeath;
                    bestplayerweapon = self.attackerdamage[player.clientid].weapon;
                    continue;
                }
                if (isdefined(bestplayer) && self.attackerdamage[player.clientid].damage > self.attackerdamage[bestplayer.clientid].damage) {
                    bestplayer = player;
                    bestplayermeansofdeath = self.attackerdamage[player.clientid].meansofdeath;
                    bestplayerweapon = self.attackerdamage[player.clientid].weapon;
                }
            }
        }
        if (isdefined(bestplayer)) {
            scoreevents::processscoreevent("assisted_suicide", bestplayer, self, weapon);
            self recordkillmodifier("assistedsuicide");
            assistedsuicide = 1;
        }
    }
    if (isdefined(bestplayer)) {
        attacker = bestplayer;
        obituarymeansofdeath = bestplayermeansofdeath;
        obituaryweapon = bestplayerweapon;
        if (isdefined(bestplayerweapon)) {
            weapon = bestplayerweapon;
        }
    }
    if (isplayer(attacker)) {
        attacker.damagedplayers[self.clientid] = undefined;
    }
    self.deathtime = gettime();
    attacker = function_9cedb097(attacker, weapon);
    einflictor = function_1e4d3508(einflictor);
    smeansofdeath = self function_d7eade4e(attacker, einflictor, weapon, smeansofdeath, shitloc);
    if (!isdefined(obituarymeansofdeath)) {
        obituarymeansofdeath = smeansofdeath;
    }
    if (isdefined(self.hasriotshieldequipped) && self.hasriotshieldequipped == 1) {
        self detachshieldmodel(level.carriedshieldmodel, "tag_weapon_left");
        self.hasriotshield = 0;
        self.hasriotshieldequipped = 0;
    }
    self thread function_117043();
    self function_6c73fce1(attacker, weapon, smeansofdeath, wasinlaststand, var_a3ad44ab, einflictor);
    self function_caa6d8d5(attacker, einflictor, obituaryweapon, obituarymeansofdeath);
    spawnlogic::function_d5c89a1f(self, attacker);
    self.sessionstate = "dead";
    self.statusicon = "hud_status_dead";
    self.pers["weapon"] = undefined;
    self.killedplayerscurrent = [];
    self.deathcount++;
    /#
        println("player_gender" + self.clientid + "player_gender" + self.deathcount);
    #/
    self function_da9b1acd(attacker, weapon);
    lpselfnum = self getentitynumber();
    lpselfname = self.name;
    lpattackguid = "";
    lpattackname = "";
    lpselfteam = self.team;
    lpselfguid = self getguid();
    lpattackteam = "";
    lpattacknum = -1;
    awardassists = 0;
    wasteamkill = 0;
    wassuicide = 0;
    pixendevent();
    scoreevents::processscoreevent("death", self, self, weapon);
    self.pers["resetMomentumOnSpawn"] = 1;
    if (isplayer(attacker)) {
        lpattackguid = attacker getguid();
        lpattackname = attacker.name;
        lpattackteam = attacker.team;
        if (attacker == self || assistedsuicide == 1) {
            wassuicide = 1;
            awardassists = self function_41055c90(einflictor, attacker, smeansofdeath, weapon, shitloc);
        } else {
            pixbeginevent("PlayerKilled attacker");
            lpattacknum = attacker getentitynumber();
            if (level.teambased && self.team == attacker.team && smeansofdeath == "MOD_GRENADE" && level.friendlyfire == 0) {
            } else if (level.teambased && self.team == attacker.team) {
                wasteamkill = 1;
                self function_d7a6cc2b(einflictor, attacker, smeansofdeath, weapon, shitloc);
            } else {
                self function_489d248c(einflictor, attacker, smeansofdeath, weapon, shitloc);
                if (level.teambased) {
                    awardassists = 1;
                }
            }
            pixendevent();
        }
    } else if (attacker.classname == "trigger_hurt" || isdefined(attacker) && attacker.classname == "worldspawn") {
        lpattacknum = -1;
        lpattackguid = "";
        lpattackname = "";
        lpattackteam = "world";
        thread scoreevents::processscoreevent("suicide", self);
        self globallogic_score::incpersstat("suicides", 1);
        self.suicides = self globallogic_score::getpersstat("suicides");
        self.suicide = 1;
        awardassists = 1;
        if (level.maxsuicidesbeforekick > 0 && level.maxsuicidesbeforekick <= self.suicides) {
            self notify(#"teamkillkicked");
            self function_361da015();
        }
    } else {
        lpattacknum = -1;
        lpattackguid = "";
        lpattackname = "";
        lpattackteam = "world";
        wassuicide = 1;
        if (isdefined(einflictor) && isdefined(einflictor.killcament)) {
            lpattacknum = self getentitynumber();
            wassuicide = 0;
        }
        if (isdefined(attacker) && isdefined(attacker.team) && isdefined(level.teams[attacker.team])) {
            if (attacker.team != self.team) {
                if (level.teambased) {
                    globallogic_score::giveteamscore("kill", attacker.team, attacker, self);
                }
                wassuicide = 0;
            }
        }
        awardassists = 1;
    }
    if (!level.ingraceperiod) {
        if (smeansofdeath != "MOD_GRENADE" && smeansofdeath != "MOD_GRENADE_SPLASH" && smeansofdeath != "MOD_EXPLOSIVE" && smeansofdeath != "MOD_EXPLOSIVE_SPLASH" && smeansofdeath != "MOD_PROJECTILE_SPLASH") {
            self weapons::drop_scavenger_for_death(attacker);
        }
        if (!wasteamkill && !wassuicide) {
            self weapons::drop_for_death(attacker, weapon, smeansofdeath);
        }
    }
    if (sessionmodeiszombiesgame()) {
        awardassists = 0;
    }
    if (awardassists) {
        self function_3f735e1d(einflictor, attacker, weapon, lpattackteam);
    }
    pixbeginevent("PlayerKilled post constants");
    self.lastattacker = attacker;
    self.lastdeathpos = self.origin;
    if (!level.teambased || isdefined(attacker) && isplayer(attacker) && attacker != self && attacker.team != self.team) {
        self thread challenges::playerkilled(einflictor, attacker, idamage, smeansofdeath, weapon, shitloc, attackerstance);
    } else {
        self notify(#"playerkilledchallengesprocessed");
    }
    if (isdefined(self.attackers)) {
        self.attackers = [];
    }
    bb::logdamage(attacker, self, weapon, idamage, smeansofdeath, shitloc, 1, !wasinlaststand);
    logprint("K;" + lpselfguid + ";" + lpselfnum + ";" + lpselfteam + ";" + lpselfname + ";" + lpattackguid + ";" + lpattacknum + ";" + lpattackteam + ";" + lpattackname + ";" + weapon.name + ";" + idamage + ";" + smeansofdeath + ";" + shitloc + "\n");
    attackerstring = "none";
    if (isplayer(attacker)) {
        attackerstring = attacker getxuid() + "(" + lpattackname + ")";
    }
    /#
        println("player_gender" + smeansofdeath + "player_gender" + weapon.name + "player_gender" + attackerstring + "player_gender" + idamage + "player_gender" + shitloc + "player_gender" + int(self.origin[0]) + "player_gender" + int(self.origin[1]) + "player_gender" + int(self.origin[2]));
    #/
    globallogic::updateteamstatus();
    self weapons::detach_carry_object_model();
    var_7614a86e = 0;
    if (isdefined(self.diedonvehicle)) {
        var_7614a86e = self.diedonvehicle;
    }
    var_ba89d8df = 0;
    if (isdefined(attacker) && isdefined(attacker.targetname) && attacker.targetname == "train") {
        var_ba89d8df = 1;
    }
    pixendevent();
    pixbeginevent("PlayerKilled body and gibbing");
    if (!(isdefined(level.var_d59daf8) && level.var_d59daf8) || !var_7614a86e && !var_ba89d8df && level.players.size > 1) {
        vattackerorigin = undefined;
        if (isdefined(attacker)) {
            vattackerorigin = attacker.origin;
        }
        ragdoll_now = 0;
        if (isdefined(self.usingvehicle) && self.usingvehicle && isdefined(self.vehicleposition) && self.vehicleposition == 1) {
            ragdoll_now = 1;
        }
        var_bcd9ef1c = 0;
        if (!attacker isonground() && smeansofdeath == "MOD_MELEE_ASSASSINATE") {
            var_bcd9ef1c = 1;
        }
        body = self cloneplayer(deathanimduration, weapon, attacker);
        if (isdefined(body)) {
            self function_39d71623(idamage, smeansofdeath, weapon, shitloc, vdir, vattackerorigin, deathanimduration, einflictor, ragdoll_now, body, var_bcd9ef1c);
        }
    }
    pixendevent();
    thread globallogic_spawn::spawnqueuedclient(self.team, attacker);
    self.switching_teams = undefined;
    self.joining_team = undefined;
    self.leaving_team = undefined;
    if (lpattacknum < 0) {
        if (isdefined(self.var_afe5253c)) {
            if (self.var_afe5253c.var_a21e8eb8 >= 0 && self.var_afe5253c.attackernum == self getentitynumber()) {
                lpattacknum = self.var_afe5253c.var_a21e8eb8;
            } else if (self.var_afe5253c.attackernum >= 0) {
                lpattacknum = self.var_afe5253c.attackernum;
            } else if (self.var_afe5253c.var_a21e8eb8 >= 0) {
                lpattacknum = self.var_afe5253c.var_a21e8eb8;
            }
        } else if (isdefined(einflictor) && attacker == self) {
            lpattacknum = einflictor getentitynumber();
        } else if (isdefined(attacker)) {
            lpattacknum = attacker getentitynumber();
        } else if (isdefined(einflictor)) {
            lpattacknum = einflictor getentitynumber();
        }
    }
    self.var_ebd83169 = 1;
    self.var_1b7a74aa = lpattacknum;
    self.var_ca78829f = attacker;
    self.killcamweapon = weapon;
    self.var_8c0347ee = deathtimeoffset;
    self.var_2b1ad8b = psoffsettime;
    if (lpattacknum < 0 || lpattacknum === self getentitynumber() || lpattacknum > 1023) {
        self.var_ebd83169 = 0;
    }
    self thread [[ level.onplayerkilled ]](einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime, deathanimduration);
    for (var_4eb9549 = 0; var_4eb9549 < level.onplayerkilledextraunthreadedcbs.size; var_4eb9549++) {
        self [[ level.onplayerkilledextraunthreadedcbs[var_4eb9549] ]](einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime, deathanimduration);
    }
    self.wantsafespawn = 0;
    perks = [];
    killstreaks = globallogic::getkillstreaks(attacker);
    if (!isdefined(self.var_814158b9)) {
        self thread [[ level.spawnplayerprediction ]]();
    }
    profilelog_endtiming(7, "gs=" + game["state"] + " zom=" + sessionmodeiszombiesgame());
    if (!(isdefined(level.var_d59daf8) && level.var_d59daf8) || level.players.size > 1) {
        wait(0.25);
    } else {
        if (isdefined(body)) {
            codesetclientfield(body, "hide_body", 1);
        }
        self.pers["incaps"]++;
        self.incaps = self.pers["incaps"];
        self addplayerstat("INCAPS", 1);
        var_e7ce5f85 = self getdstat("PlayerStatsList", "INCAPS", "statValue");
        self setnoncheckpointdata("INCAPS", var_e7ce5f85);
        namespace_5f11fb0b::function_8e835895(einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime, deathanimduration);
        self util::waittill_any_timeout(5, "cp_deathcam_ended");
    }
    defaultplayerdeathwatchtime = 4;
    if (sessionmodeiscampaigngame() && level.players.size > 1) {
        if (getdvarint("enable_new_death_cam", 1)) {
            defaultplayerdeathwatchtime = getdvarfloat("defaultPlayerDeathWatchTime", 2.5);
        }
    }
    if (smeansofdeath == "MOD_MELEE_ASSASSINATE" || 0 > weapon.deathcamtime) {
        defaultplayerdeathwatchtime = deathanimduration * 0.001 + 0.5;
    } else if (0 < weapon.deathcamtime) {
        defaultplayerdeathwatchtime = weapon.deathcamtime;
    }
    if (isdefined(level.overrideplayerdeathwatchtimer)) {
        defaultplayerdeathwatchtime = [[ level.overrideplayerdeathwatchtimer ]](defaultplayerdeathwatchtime);
    }
    self notify(#"death_delay_finished");
    if (isdefined(self.var_acfedf1c) && isdefined(level.var_3a9f9a38) && level.var_3a9f9a38 && self.var_acfedf1c) {
        killcamentitystarttime = 0;
        self killcam::killcam(self getentitynumber(), self getentitynumber(), attacker, lpattacknum, killcamentitystarttime, weapon, self.deathtime, deathtimeoffset, psoffsettime, 1, undefined, perks, killstreaks, self, body);
    }
    if (isdefined(self.var_e8880dea) && self.var_e8880dea) {
        self util::waittill_any_timeout(5, "camera_sequence_completed");
        self.var_e8880dea = undefined;
        return;
    }
    self.respawntimerstarttime = gettime();
    if (game["state"] != "playing") {
        self.sessionstate = "dead";
        self.spectatorclient = -1;
        self.archivetime = 0;
        self.psoffsettime = 0;
        return;
    }
    function_188bdae1();
    userespawntime = 1;
    if (isdefined(level.hostmigrationtimer)) {
        userespawntime = 0;
    }
    hostmigration::waittillhostmigrationcountdown();
    if (isdefined(level.var_ad1a71f5)) {
        return;
    }
    if (globallogic_utils::isvalidclass(self.curclass)) {
        timepassed = undefined;
        if (isdefined(self.respawntimerstarttime) && userespawntime) {
            timepassed = (gettime() - self.respawntimerstarttime) / 1000;
        }
        self thread [[ level.spawnclient ]](timepassed);
        self.respawntimerstarttime = undefined;
    }
}

// Namespace globallogic_player
// Params 0, eflags: 0x1 linked
// Checksum 0x98e8e722, Offset: 0xabd0
// Size: 0x24
function function_117043() {
    if (isdefined(self.pers["isBot"])) {
        level.globallarryskilled++;
    }
}

// Namespace globallogic_player
// Params 0, eflags: 0x1 linked
// Checksum 0xf89eb00, Offset: 0xac00
// Size: 0x76
function function_188bdae1() {
    if (isdefined(self.var_814158b9)) {
        starttime = gettime();
        waittime = self.var_814158b9 * 1000;
        while (gettime() < starttime + waittime && isdefined(self.var_814158b9)) {
            wait(0.1);
        }
        wait(2);
        self.var_814158b9 = undefined;
    }
}

// Namespace globallogic_player
// Params 0, eflags: 0x1 linked
// Checksum 0xdec11250, Offset: 0xac80
// Size: 0x6c
function function_361da015() {
    self globallogic_score::incpersstat("sessionbans", 1);
    self endon(#"disconnect");
    waittillframeend();
    globallogic::gamehistoryplayerkicked();
    ban(self getentitynumber());
}

// Namespace globallogic_player
// Params 0, eflags: 0x1 linked
// Checksum 0x476e990f, Offset: 0xacf8
// Size: 0x1d4
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
}

// Namespace globallogic_player
// Params 0, eflags: 0x1 linked
// Checksum 0xc4788c87, Offset: 0xaed8
// Size: 0x70
function teamkilldelay() {
    teamkills = self.pers["teamkills_nostats"];
    if (level.minimumallowedteamkills < 0 || teamkills <= level.minimumallowedteamkills) {
        return 0;
    }
    exceeded = teamkills - level.minimumallowedteamkills;
    return level.teamkillspawndelay * exceeded;
}

// Namespace globallogic_player
// Params 1, eflags: 0x1 linked
// Checksum 0x5aa45ad4, Offset: 0xaf50
// Size: 0x66
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
// Params 0, eflags: 0x1 linked
// Checksum 0xf713a79c, Offset: 0xafc0
// Size: 0xc0
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
        wait(1);
    }
}

// Namespace globallogic_player
// Params 2, eflags: 0x1 linked
// Checksum 0xf1e595e1, Offset: 0xb088
// Size: 0x52
function ignoreteamkills(weapon, smeansofdeath) {
    if (smeansofdeath == "MOD_MELEE" || smeansofdeath == "MOD_MELEE_ASSASSINATE") {
        return false;
    }
    if (weapon.ignoreteamkills) {
        return true;
    }
    return false;
}

// Namespace globallogic_player
// Params 9, eflags: 0x1 linked
// Checksum 0xe50ae63e, Offset: 0xb0e8
// Size: 0xdc
function callback_playerlaststand(einflictor, eattacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime, delayoverride) {
    if (self function_76f34311("cybercom_emergencyreserve") && namespace_e3074452::function_9248cfb4(smeansofdeath)) {
        self cybercom_tacrig::function_de82b8b4("cybercom_emergencyreserve");
    }
    laststand::playerlaststand(einflictor, eattacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime, delayoverride);
}

// Namespace globallogic_player
// Params 5, eflags: 0x1 linked
// Checksum 0xbff2f515, Offset: 0xb1d0
// Size: 0x74
function damageshellshockandrumble(eattacker, einflictor, weapon, smeansofdeath, idamage) {
    self thread weapons::on_damage(eattacker, einflictor, weapon, smeansofdeath, idamage);
    self playrumbleonentity("damage_heavy");
}

// Namespace globallogic_player
// Params 11, eflags: 0x1 linked
// Checksum 0xef631279, Offset: 0xb250
// Size: 0x280
function function_39d71623(idamage, smeansofdeath, weapon, shitloc, vdir, vattackerorigin, deathanimduration, einflictor, ragdoll_jib, body, var_bcd9ef1c) {
    if (smeansofdeath == "MOD_HIT_BY_OBJECT" && self getstance() == "prone") {
        self.body = body;
        return;
    }
    if (isdefined(level.ragdoll_override) && self [[ level.ragdoll_override ]](idamage, smeansofdeath, weapon, shitloc, vdir, vattackerorigin, deathanimduration, einflictor, ragdoll_jib, body)) {
        return;
    }
    if (ragdoll_jib || self isonladder() || self ismantling() || smeansofdeath == "MOD_CRUSH" || smeansofdeath == "MOD_HIT_BY_OBJECT") {
        body startragdoll();
    }
    if (!self isonground()) {
        if (getdvarint("scr_disable_air_death_ragdoll") == 0) {
            body startragdoll();
        }
    }
    if (smeansofdeath == "MOD_MELEE_ASSASSINATE" && isdefined(var_bcd9ef1c) && var_bcd9ef1c) {
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
}

// Namespace globallogic_player
// Params 2, eflags: 0x1 linked
// Checksum 0x12ba16a9, Offset: 0xb4d8
// Size: 0xb2
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
// Params 2, eflags: 0x1 linked
// Checksum 0x56e61db, Offset: 0xb598
// Size: 0x1b4
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
// Params 1, eflags: 0x1 linked
// Checksum 0xc5a1f0c0, Offset: 0xb758
// Size: 0x4c
function start_death_from_above_ragdoll(dir) {
    if (!isdefined(self)) {
        return;
    }
    self startragdoll();
    self launchragdoll((0, 0, -100));
}

// Namespace globallogic_player
// Params 0, eflags: 0x1 linked
// Checksum 0xaffd67a7, Offset: 0xb7b0
// Size: 0x34
function notifyconnecting() {
    waittillframeend();
    if (isdefined(self)) {
        level notify(#"connecting", self);
        callback::callback(#"hash_fefe13f5");
    }
}

// Namespace globallogic_player
// Params 6, eflags: 0x1 linked
// Checksum 0xf07e2a50, Offset: 0xb7f0
// Size: 0x314
function delaystartragdoll(ent, shitloc, vdir, weapon, einflictor, smeansofdeath) {
    if (isdefined(ent)) {
        deathanim = ent getcorpseanim();
        if (animhasnotetrack(deathanim, "ignore_ragdoll")) {
            return;
        }
    }
    if (level.oldschool) {
        if (!isdefined(vdir)) {
            vdir = (0, 0, 0);
        }
        explosionpos = ent.origin + (0, 0, globallogic_utils::gethitlocheight(shitloc));
        explosionpos -= vdir * 20;
        explosionradius = 40;
        var_a207fba7 = 0.75;
        if (smeansofdeath == "MOD_IMPACT" || smeansofdeath == "MOD_EXPLOSIVE" || issubstr(smeansofdeath, "MOD_GRENADE") || issubstr(smeansofdeath, "MOD_PROJECTILE") || shitloc == "head" || shitloc == "helmet") {
            var_a207fba7 = 2.5;
        }
        ent startragdoll(1);
        wait(0.05);
        if (!isdefined(ent)) {
            return;
        }
        physicsexplosionsphere(explosionpos, explosionradius, explosionradius / 2, var_a207fba7);
        return;
    }
    wait(0.2);
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
    wait(waittime);
    if (isdefined(ent)) {
        ent startragdoll(1);
    }
}

// Namespace globallogic_player
// Params 4, eflags: 0x1 linked
// Checksum 0x88f3af77, Offset: 0xbb10
// Size: 0x33a
function trackattackerdamage(eattacker, idamage, smeansofdeath, weapon) {
    if (!isdefined(eattacker)) {
        return;
    }
    if (!isplayer(eattacker)) {
        return;
    }
    /#
        assert(isarray(self.attackerdata));
    #/
    if (self.attackerdata.size == 0) {
        self.firsttimedamaged = gettime();
    }
    if (self.attackerdata.size == 0 || !isdefined(self.attackerdata[eattacker.clientid])) {
        self.attackerdamage[eattacker.clientid] = spawnstruct();
        self.attackerdamage[eattacker.clientid].damage = idamage;
        self.attackerdamage[eattacker.clientid].meansofdeath = smeansofdeath;
        self.attackerdamage[eattacker.clientid].weapon = weapon;
        self.attackerdamage[eattacker.clientid].time = gettime();
        self.attackers[self.attackers.size] = eattacker;
        self.attackerdata[eattacker.clientid] = 0;
        /#
            assert(self.attackerdata.size);
        #/
    } else {
        self.attackerdamage[eattacker.clientid].damage = self.attackerdamage[eattacker.clientid].damage + idamage;
        self.attackerdamage[eattacker.clientid].meansofdeath = smeansofdeath;
        self.attackerdamage[eattacker.clientid].weapon = weapon;
        if (!isdefined(self.attackerdamage[eattacker.clientid].time)) {
            self.attackerdamage[eattacker.clientid].time = gettime();
        }
    }
    /#
        assert(self.attackerdata.size);
    #/
    self.attackerdamage[eattacker.clientid].lasttimedamaged = gettime();
    if (weapons::is_primary_weapon(weapon)) {
        self.attackerdata[eattacker.clientid] = 1;
    }
}

// Namespace globallogic_player
// Params 5, eflags: 0x1 linked
// Checksum 0xc840d279, Offset: 0xbe58
// Size: 0x104
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
// Params 5, eflags: 0x1 linked
// Checksum 0x5d3b174d, Offset: 0xbf68
// Size: 0xda
function function_d7eade4e(attacker, einflictor, weapon, smeansofdeath, shitloc) {
    if (globallogic_utils::isheadshot(weapon, shitloc, smeansofdeath, einflictor) && isplayer(attacker)) {
        return "MOD_HEAD_SHOT";
    }
    switch (weapon.name) {
    case 298:
        smeansofdeath = "MOD_PISTOL_BULLET";
        break;
    case 178:
        smeansofdeath = "MOD_EXPLOSIVE";
        break;
    case 176:
        smeansofdeath = "MOD_EXPLOSIVE";
        break;
    }
    return smeansofdeath;
}

// Namespace globallogic_player
// Params 2, eflags: 0x1 linked
// Checksum 0xde4a0c5a, Offset: 0xc050
// Size: 0x208
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
    if (isdefined(attacker) && isdefined(weapon) && weapon.name == "planemortar") {
        if (!isdefined(attacker.planemortarbda)) {
            attacker.planemortarbda = 0;
        }
        attacker.planemortarbda++;
    }
    if (weapon.name == "straferun_rockets" || isdefined(attacker) && isdefined(weapon) && weapon.name == "straferun_gun") {
        if (isdefined(attacker.straferunbda)) {
            attacker.straferunbda++;
        }
    }
    return attacker;
}

// Namespace globallogic_player
// Params 1, eflags: 0x1 linked
// Checksum 0xc166d1bb, Offset: 0xc260
// Size: 0x68
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
// Params 2, eflags: 0x1 linked
// Checksum 0x89a03eb4, Offset: 0xc2d0
// Size: 0xd4
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
// Params 3, eflags: 0x1 linked
// Checksum 0x53e24d, Offset: 0xc3b0
// Size: 0x1c
function playkillbattlechatter(attacker, weapon, victim) {
    
}

// Namespace globallogic_player
// Params 0, eflags: 0x1 linked
// Checksum 0xb673303e, Offset: 0xc3d8
// Size: 0x23a
function function_ece4ca01() {
    if (self == level) {
        foreach (player in level.players) {
            player function_ece4ca01();
        }
        return;
    }
    if (isplayer(self)) {
        a_w_weapons = self getweaponslist();
        foreach (weapon in a_w_weapons) {
            if (isdefined(weapon.isheroweapon) && weapon.isheroweapon) {
                var_c44df3d1 = self savegame::function_36adbb9c(savegame::function_1bfdd60e() + "hero_weapon", undefined);
                if (!isdefined(var_c44df3d1)) {
                    var_c44df3d1 = "";
                }
                if (!issubstr(var_c44df3d1, weapon.name + ",")) {
                    var_c44df3d1 = var_c44df3d1 + weapon.name + ",";
                    self savegame::set_player_data(savegame::function_1bfdd60e() + "hero_weapon", var_c44df3d1);
                }
            }
        }
    }
}

// Namespace globallogic_player
// Params 1, eflags: 0x5 linked
// Checksum 0x8c6bce2e, Offset: 0xc620
// Size: 0x92
function private function_7a152f99(statname) {
    var_9792a8bf = self getdstat("PlayerStatsByMap", getrootmapname(), "currentStats", statname);
    var_56aa772d = self getdstat("PlayerStatsList", statname, "statValue");
    return var_56aa772d - var_9792a8bf;
}

// Namespace globallogic_player
// Params 0, eflags: 0x1 linked
// Checksum 0x4bd58e3e, Offset: 0xc6c0
// Size: 0x2a0
function function_a5ac6877() {
    if (isdefined(getrootmapname())) {
        if (sessionmodeiscampaignzombiesgame() && !ismapsublevel() && !(isdefined(self.var_bf1a9bd5) && self.var_bf1a9bd5)) {
            next_map = getrootmapname();
            if (isdefined(next_map)) {
                foreach (player in level.players) {
                    player function_4cef9872(next_map);
                }
            }
            uploadstats();
            self.var_bf1a9bd5 = 1;
        }
        self.pers["score"] = self function_7a152f99("score");
        self.pers["kills"] = self function_7a152f99("kills");
        self.pers["incaps"] = self function_7a152f99("incaps");
        self.pers["assists"] = self function_7a152f99("assists");
        self.pers["revives"] = self function_7a152f99("revives");
        self.kills = self.pers["kills"];
        self.score = self.pers["score"];
        self.assists = self.pers["assists"];
        self.incaps = self.pers["incaps"];
        self.revives = self.pers["revives"];
    }
}

// Namespace globallogic_player
// Params 0, eflags: 0x0
// Checksum 0x59f4f87e, Offset: 0xc968
// Size: 0x40
function function_7bdf5497() {
    self.kills = 0;
    self.score = 0;
    self.assists = 0;
    self.incaps = 0;
    self.revives = 0;
}

// Namespace globallogic_player
// Params 1, eflags: 0x1 linked
// Checksum 0xde77b8ec, Offset: 0xc9b0
// Size: 0x404
function function_4cef9872(current_map) {
    if (!isdefined(current_map)) {
        return;
    }
    for (i = 1; i < 58; i++) {
        var_b47d78c4 = self getcurrentgunrank(i);
        if (!isdefined(var_b47d78c4)) {
            var_b47d78c4 = 0;
        }
        self setdstat("currentWeaponLevels", i, var_b47d78c4);
    }
    var_72c4032 = self getdstat("PlayerStatsList", "RANKXP", "statValue");
    self setdstat("currentRankXP", var_72c4032);
    var_b4728b19 = [];
    array::add(var_b4728b19, "KILLS");
    array::add(var_b4728b19, "SCORE");
    array::add(var_b4728b19, "ASSISTS");
    array::add(var_b4728b19, "INCAPS");
    array::add(var_b4728b19, "REVIVES");
    foreach (stat in var_b4728b19) {
        statvalue = self getdstat("PlayerStatsList", stat, "statValue");
        self setdstat("PlayerStatsByMap", current_map, "currentStats", stat, statvalue);
    }
    for (i = 0; i < 6; i++) {
        var_b53e21eb = self getdstat("PlayerStatsByMap", current_map, "completedDifficulties", i);
        self setdstat("PlayerStatsByMap", current_map, "previousCompletedDifficulties", i, var_b53e21eb);
        var_16925818 = self getdstat("PlayerStatsBymap", current_map, "receivedXPForDifficulty", i);
        self setdstat("PlayerStatsByMap", current_map, "previousReceivedXPForDifficulty", i, var_16925818);
    }
    for (i = 0; i < 20; i++) {
        var_8514318e = self getdstat("PlayerCPDecorations", i);
        self setdstat("currentPlayerCPDecorations", i, var_8514318e);
    }
    uploadstats(self);
}

// Namespace globallogic_player
// Params 0, eflags: 0x1 linked
// Checksum 0xbb78bfee, Offset: 0xcdc0
// Size: 0xaa
function recordactiveplayersendgamematchrecordstats() {
    foreach (player in level.players) {
        recordplayermatchend(player);
        recordplayerstats(player, "presentAtEnd", 1);
    }
}

