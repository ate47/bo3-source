#using scripts/codescripts/struct;
#using scripts/mp/_arena;
#using scripts/mp/_behavior_tracker;
#using scripts/mp/_challenges;
#using scripts/mp/_gameadvertisement;
#using scripts/mp/_gamerep;
#using scripts/mp/_rat;
#using scripts/mp/_teamops;
#using scripts/mp/_util;
#using scripts/mp/bots/_bot;
#using scripts/mp/gametypes/_battlechatter;
#using scripts/mp/gametypes/_clientids;
#using scripts/mp/gametypes/_deathicons;
#using scripts/mp/gametypes/_dev;
#using scripts/mp/gametypes/_dogtags;
#using scripts/mp/gametypes/_friendicons;
#using scripts/mp/gametypes/_globallogic_audio;
#using scripts/mp/gametypes/_globallogic_defaults;
#using scripts/mp/gametypes/_globallogic_player;
#using scripts/mp/gametypes/_globallogic_score;
#using scripts/mp/gametypes/_globallogic_spawn;
#using scripts/mp/gametypes/_globallogic_ui;
#using scripts/mp/gametypes/_globallogic_utils;
#using scripts/mp/gametypes/_healthoverlay;
#using scripts/mp/gametypes/_hostmigration;
#using scripts/mp/gametypes/_hud_message;
#using scripts/mp/gametypes/_killcam;
#using scripts/mp/gametypes/_loadout;
#using scripts/mp/gametypes/_menus;
#using scripts/mp/gametypes/_scoreboard;
#using scripts/mp/gametypes/_serversettings;
#using scripts/mp/gametypes/_shellshock;
#using scripts/mp/gametypes/_spawning;
#using scripts/mp/gametypes/_spawnlogic;
#using scripts/mp/gametypes/_spectating;
#using scripts/mp/gametypes/_weapons;
#using scripts/mp/killstreaks/_dogs;
#using scripts/mp/killstreaks/_killstreaks;
#using scripts/mp/teams/_teams;
#using scripts/shared/bb_shared;
#using scripts/shared/bots/_bot;
#using scripts/shared/callbacks_shared;
#using scripts/shared/challenges_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/damagefeedback_shared;
#using scripts/shared/demo_shared;
#using scripts/shared/gameobjects_shared;
#using scripts/shared/hostmigration_shared;
#using scripts/shared/hud_message_shared;
#using scripts/shared/hud_shared;
#using scripts/shared/hud_util_shared;
#using scripts/shared/math_shared;
#using scripts/shared/music_shared;
#using scripts/shared/objpoints_shared;
#using scripts/shared/persistence_shared;
#using scripts/shared/rank_shared;
#using scripts/shared/simple_hostmigration;
#using scripts/shared/system_shared;
#using scripts/shared/tweakables_shared;
#using scripts/shared/util_shared;
#using scripts/shared/visionset_mgr_shared;
#using scripts/shared/weapons/_hive_gun;
#using scripts/shared/weapons/_weapon_utils;
#using scripts/shared/weapons/_weapons;

#namespace globallogic;

// Namespace globallogic
// Params 0, eflags: 0x2
// Checksum 0x5bc54877, Offset: 0x1f78
// Size: 0x32
function autoexec function_2dc19561() {
    system::register("globallogic", &__init__, undefined, "visionset_mgr");
}

// Namespace globallogic
// Params 0, eflags: 0x0
// Checksum 0xdd337a32, Offset: 0x1fb8
// Size: 0x7a
function __init__() {
    if (!isdefined(level.vsmgr_prio_visionset_mpintro)) {
        level.vsmgr_prio_visionset_mpintro = 5;
    }
    visionset_mgr::register_info("visionset", "mpintro", 1, level.vsmgr_prio_visionset_mpintro, 31, 0, &visionset_mgr::ramp_in_out_thread, 0);
    level.host_migration_activate_visionset_func = &mpintro_visionset_activate_func;
    level.host_migration_deactivate_visionset_func = &mpintro_visionset_deactivate_func;
}

// Namespace globallogic
// Params 0, eflags: 0x0
// Checksum 0x200a2674, Offset: 0x2040
// Size: 0x521
function init() {
    level.splitscreen = issplitscreen();
    level.xenon = getdvarstring("xenonGame") == "true";
    level.ps3 = getdvarstring("ps3Game") == "true";
    level.wiiu = getdvarstring("wiiuGame") == "true";
    level.orbis = getdvarstring("orbisGame") == "true";
    level.durango = getdvarstring("durangoGame") == "true";
    level.onlinegame = sessionmodeisonlinegame();
    level.systemlink = sessionmodeissystemlink();
    level.console = level.xenon || level.ps3 || level.wiiu || level.orbis || level.durango;
    level.rankedmatch = gamemodeisusingxp();
    level.leaguematch = 0;
    level.custommatch = gamemodeismode(1);
    level.arenamatch = gamemodeisarena();
    level.mpcustommatch = level.custommatch;
    level.contractsenabled = !getgametypesetting("disableContracts");
    level.contractsenabled = 0;
    level.disablevehicleburndamage = 1;
    /#
        if (getdvarint("<dev string:x28>") == 1) {
            level.rankedmatch = 1;
        }
    #/
    level.script = tolower(getdvarstring("mapname"));
    level.gametype = tolower(getdvarstring("g_gametype"));
    level.teambased = 0;
    level.teamcount = getgametypesetting("teamCount");
    level.multiteam = level.teamcount > 2;
    level.teams = [];
    level.teamindex = [];
    teamcount = level.teamcount;
    level.teams["allies"] = "allies";
    level.teams["axis"] = "axis";
    if (level.teamcount == 1) {
        teamcount = 18;
    }
    level.teamindex["neutral"] = 0;
    level.teamindex["allies"] = 1;
    level.teamindex["axis"] = 2;
    for (teamindex = 3; teamindex <= teamcount; teamindex++) {
        level.teams["team" + teamindex] = "team" + teamindex;
        level.teamindex["team" + teamindex] = teamindex;
    }
    level.overrideteamscore = 0;
    level.overrideplayerscore = 0;
    level.displayhalftimetext = 0;
    level.displayroundendtext = 1;
    level.clampscorelimit = 1;
    level.endgameonscorelimit = 1;
    level.endgameontimelimit = 1;
    level.scoreroundwinbased = 0;
    level.resetplayerscoreeveryround = 0;
    level.doendgamescoreboard = 1;
    level.gameforfeited = 0;
    level.forceautoassign = 0;
    level.halftimetype = "halftime";
    level.halftimesubcaption = %MP_SWITCHING_SIDES_CAPS;
    level.laststatustime = 0;
    level.waswinning = [];
    level.lastslowprocessframe = 0;
    level.placement = [];
    foreach (team in level.teams) {
        level.placement[team] = [];
    }
    level.placement["all"] = [];
    level.postroundtime = 7;
    level.inovertime = 0;
    level.defaultoffenseradius = 560;
    level.dropteam = getdvarint("sv_maxclients");
    level.infinalkillcam = 0;
    globallogic_ui::init();
    registerdvars();
    loadout::initperkdvars();
    precache_mp_leaderboards();
    InvalidOpCode(0x54, "tiebreaker");
    // Unknown operator (0x54, t7_1b, PC)
}

// Namespace globallogic
// Params 0, eflags: 0x0
// Checksum 0xc1fbfd2, Offset: 0x27f0
// Size: 0x22a
function registerdvars() {
    if (getdvarstring("ui_guncycle") == "") {
        setdvar("ui_guncycle", 0);
    }
    if (getdvarstring("ui_weapon_tiers") == "") {
        setdvar("ui_weapon_tiers", 0);
    }
    setdvar("ui_text_endreason", "");
    setmatchflag("bomb_timer", 0);
    setmatchflag("enable_popups", 1);
    if (getdvarstring("scr_vehicle_damage_scalar") == "") {
        setdvar("scr_vehicle_damage_scalar", "1");
    }
    level.vehicledamagescalar = getdvarfloat("scr_vehicle_damage_scalar");
    level.fire_audio_repeat_duration = getdvarint("fire_audio_repeat_duration");
    level.fire_audio_random_max_duration = getdvarint("fire_audio_random_max_duration");
    teamname = function_7998dac8(level.teamindex["allies"]);
    if (isdefined(teamname)) {
        setdvar("g_customTeamName_Allies", teamname);
    } else {
        setdvar("g_customTeamName_Allies", "");
    }
    teamname = function_7998dac8(level.teamindex["axis"]);
    if (isdefined(teamname)) {
        setdvar("g_customTeamName_Axis", teamname);
        return;
    }
    setdvar("g_customTeamName_Axis", "");
}

// Namespace globallogic
// Params 10, eflags: 0x0
// Checksum 0x4d41e38c, Offset: 0x2a28
// Size: 0x52
function blank(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10) {
    
}

// Namespace globallogic
// Params 0, eflags: 0x0
// Checksum 0x4bfc0372, Offset: 0x2a88
// Size: 0x472
function setup_callbacks() {
    level.spawnplayer = &globallogic_spawn::spawnplayer;
    level.spawnplayerprediction = &globallogic_spawn::spawnplayerprediction;
    level.spawnclient = &globallogic_spawn::spawnclient;
    level.spawnspectator = &globallogic_spawn::spawnspectator;
    level.spawnintermission = &globallogic_spawn::spawnintermission;
    level.scoreongiveplayerscore = &globallogic_score::giveplayerscore;
    level.onplayerscore = &globallogic_score::default_onplayerscore;
    level.onteamscore = &globallogic_score::default_onteamscore;
    level.wavespawntimer = &wavespawntimer;
    level.spawnmessage = &globallogic_spawn::default_spawnmessage;
    level.onspawnplayer = &blank;
    level.onspawnplayer = &spawning::onspawnplayer;
    level.onspawnspectator = &globallogic_defaults::default_onspawnspectator;
    level.onspawnintermission = &globallogic_defaults::default_onspawnintermission;
    level.onrespawndelay = &blank;
    level.onforfeit = &globallogic_defaults::default_onforfeit;
    level.ontimelimit = &globallogic_defaults::default_ontimelimit;
    level.onscorelimit = &globallogic_defaults::default_onscorelimit;
    level.onroundscorelimit = &globallogic_defaults::default_onroundscorelimit;
    level.onalivecountchange = &globallogic_defaults::default_onalivecountchange;
    level.ondeadevent = undefined;
    level.ononeleftevent = &globallogic_defaults::default_ononeleftevent;
    level.giveteamscore = &globallogic_score::giveteamscore;
    level.onlastteamaliveevent = &globallogic_defaults::function_45c10f52;
    level.gettimepassed = &globallogic_utils::gettimepassed;
    level.gettimelimit = &globallogic_defaults::default_gettimelimit;
    level.getteamkillpenalty = &globallogic_defaults::default_getteamkillpenalty;
    level.getteamkillscore = &globallogic_defaults::default_getteamkillscore;
    level.iskillboosting = &globallogic_score::default_iskillboosting;
    level._setteamscore = &globallogic_score::_setteamscore;
    level._setplayerscore = &globallogic_score::_setplayerscore;
    level._getteamscore = &globallogic_score::_getteamscore;
    level._getplayerscore = &globallogic_score::_getplayerscore;
    level.resetplayerscorestreaks = &globallogic_score::resetplayerscorechainandmomentum;
    level.onprecachegametype = &blank;
    level.onstartgametype = &blank;
    level.onplayerconnect = &blank;
    level.onplayerdisconnect = &blank;
    level.onplayerdamage = &blank;
    level.onplayerkilled = &blank;
    level.onplayerkilledextraunthreadedcbs = [];
    level.onteamoutcomenotify = &hud_message::teamoutcomenotify;
    level.onoutcomenotify = &hud_message::outcomenotify;
    level.var_d6911678 = &hud_message::function_d6911678;
    level.onendgame = &blank;
    level.onroundendgame = &globallogic_defaults::default_onroundendgame;
    level.onmedalawarded = &blank;
    level.dogmanagerongetdogs = &dogs::function_b944b696;
    globallogic_ui::setupcallbacks();
}

// Namespace globallogic
// Params 0, eflags: 0x0
// Checksum 0xf1e7533e, Offset: 0x2f08
// Size: 0x16a
function precache_mp_public_leaderboards() {
    switch (level.gametype) {
    case "fr":
        return;
    }
    mapname = getdvarstring("mapname");
    hardcoremode = getgametypesetting("hardcoreMode");
    if (!isdefined(hardcoremode)) {
        hardcoremode = 0;
    }
    arenamode = isarenamode();
    freerunmode = level.gametype == "fr";
    postfix = "";
    if (freerunmode) {
        frleaderboard = " LB_MP_FREERUN_" + getsubstr(mapname, 3, mapname.size);
        precacheleaderboards(frleaderboard);
        return;
    } else if (hardcoremode) {
        postfix = "_HC";
    } else if (arenamode) {
        postfix = "_ARENA";
    }
    careerleaderboard = " LB_MP_GB_SCORE" + postfix;
    gamemodeleaderboard = "LB_MP_GM_" + level.gametype + postfix;
    precacheleaderboards(gamemodeleaderboard + careerleaderboard);
}

// Namespace globallogic
// Params 0, eflags: 0x0
// Checksum 0xe19018b9, Offset: 0x3080
// Size: 0x22
function precache_mp_custom_leaderboards() {
    customleaderboards = "LB_MP_CG_KILLS LB_MP_CG_SCORE LB_MP_CG_WINS LB_MP_CG_ACCURACY";
    precacheleaderboards(customleaderboards);
}

// Namespace globallogic
// Params 0, eflags: 0x0
// Checksum 0x18b384ac, Offset: 0x30b0
// Size: 0x32
function precache_mp_leaderboards() {
    if (bot::is_bot_ranked_match()) {
        return;
    }
    if (!level.rankedmatch) {
        return;
    }
    precache_mp_public_leaderboards();
}

// Namespace globallogic
// Params 5, eflags: 0x0
// Checksum 0x938dc798, Offset: 0x30f0
// Size: 0x8a
function setvisiblescoreboardcolumns(col1, col2, col3, col4, col5) {
    if (!level.rankedmatch) {
        setscoreboardcolumns(col1, col2, col3, col4, col5, "sbtimeplayed", "shotshit", "shotsmissed", "victory");
        return;
    }
    setscoreboardcolumns(col1, col2, col3, col4, col5);
}

// Namespace globallogic
// Params 4, eflags: 0x0
// Checksum 0x430d5ee2, Offset: 0x3188
// Size: 0x5d
function compareteambygamestat(gamestat, teama, teamb, previous_winner_score) {
    winner = undefined;
    if (teama == "tie") {
        winner = "tie";
        InvalidOpCode(0x54, gamestat, teamb, previous_winner_score);
        // Unknown operator (0x54, t7_1b, PC)
    }
    InvalidOpCode(0x54, gamestat, teama);
    // Unknown operator (0x54, t7_1b, PC)
}

// Namespace globallogic
// Params 1, eflags: 0x0
// Checksum 0xc6012ba8, Offset: 0x3228
// Size: 0x4f
function determineteamwinnerbygamestat(gamestat) {
    teamkeys = getarraykeys(level.teams);
    winner = teamkeys[0];
    InvalidOpCode(0x54, gamestat, winner);
    // Unknown operator (0x54, t7_1b, PC)
}

// Namespace globallogic
// Params 3, eflags: 0x0
// Checksum 0xcfe4c07a, Offset: 0x32d0
// Size: 0xa6
function compareteambyteamscore(teama, teamb, previous_winner_score) {
    winner = undefined;
    teambscore = [[ level._getteamscore ]](teamb);
    if (teama == "tie") {
        winner = "tie";
        if (previous_winner_score < teambscore) {
            winner = teamb;
        }
        return winner;
    }
    teamascore = [[ level._getteamscore ]](teama);
    if (teambscore == teamascore) {
        winner = "tie";
    } else if (teambscore > teamascore) {
        winner = teamb;
    } else {
        winner = teama;
    }
    return winner;
}

// Namespace globallogic
// Params 0, eflags: 0x0
// Checksum 0xd22182e0, Offset: 0x3380
// Size: 0x9f
function determineteamwinnerbyteamscore() {
    teamkeys = getarraykeys(level.teams);
    winner = teamkeys[0];
    previous_winner_score = [[ level._getteamscore ]](winner);
    for (teamindex = 1; teamindex < teamkeys.size; teamindex++) {
        winner = compareteambyteamscore(winner, teamkeys[teamindex], previous_winner_score);
        if (winner != "tie") {
            previous_winner_score = [[ level._getteamscore ]](winner);
        }
    }
    return winner;
}

// Namespace globallogic
// Params 1, eflags: 0x0
// Checksum 0xc13b4285, Offset: 0x3428
// Size: 0x14a
function forceend(hostsucks) {
    if (!isdefined(hostsucks)) {
        hostsucks = 0;
    }
    if (level.hostforcedend || level.forcedend) {
        return;
    }
    winner = undefined;
    if (level.teambased) {
        winner = determineteamwinnerbygamestat("teamScores");
        globallogic_utils::logteamwinstring("host ended game", winner);
    } else {
        winner = globallogic_score::gethighestscoringplayer();
        /#
            if (isdefined(winner)) {
                print("<dev string:x3d>" + winner.name);
            } else {
                print("<dev string:x54>");
            }
        #/
    }
    level.forcedend = 1;
    level.hostforcedend = 1;
    if (hostsucks) {
        endstring = %MP_HOST_SUCKS;
    } else if (level.splitscreen) {
        endstring = %MP_ENDED_GAME;
    } else {
        endstring = %MP_HOST_ENDED_GAME;
    }
    setmatchflag("disableIngameMenu", 1);
    setdvar("ui_text_endreason", endstring);
    thread endgame(winner, endstring);
}

// Namespace globallogic
// Params 0, eflags: 0x0
// Checksum 0xa60feced, Offset: 0x3580
// Size: 0x102
function killserverpc() {
    if (level.hostforcedend || level.forcedend) {
        return;
    }
    winner = undefined;
    if (level.teambased) {
        winner = determineteamwinnerbygamestat("teamScores");
        globallogic_utils::logteamwinstring("host ended game", winner);
    } else {
        winner = globallogic_score::gethighestscoringplayer();
        /#
            if (isdefined(winner)) {
                print("<dev string:x3d>" + winner.name);
            } else {
                print("<dev string:x54>");
            }
        #/
    }
    level.forcedend = 1;
    level.hostforcedend = 1;
    level.killserver = 1;
    endstring = %MP_HOST_ENDED_GAME;
    println("<dev string:x69>");
    thread endgame(winner, endstring);
}

// Namespace globallogic
// Params 0, eflags: 0x0
// Checksum 0xf7f63d49, Offset: 0x3690
// Size: 0x7b
function atleasttwoteams() {
    valid_count = 0;
    foreach (team in level.teams) {
        if (level.playercount[team] != 0) {
            valid_count++;
        }
    }
    if (valid_count < 2) {
        return false;
    }
    return true;
}

// Namespace globallogic
// Params 1, eflags: 0x0
// Checksum 0xdae4991e, Offset: 0x3718
// Size: 0x11
function checkifteamforfeits(team) {
    InvalidOpCode(0x54, "everExisted", team);
    // Unknown operator (0x54, t7_1b, PC)
}

// Namespace globallogic
// Params 0, eflags: 0x0
// Checksum 0x8ef907e3, Offset: 0x3768
// Size: 0xcc
function function_c64c7a91() {
    var_4dfb2196 = 0;
    var_9c3f07a7 = undefined;
    foreach (team in level.teams) {
        if (checkifteamforfeits(team)) {
            var_4dfb2196++;
            if (!level.multiteam) {
                InvalidOpCode(0x64, level.onforfeit, team);
                // Unknown operator (0x64, t7_1b, PC)
            }
            continue;
        }
        var_9c3f07a7 = team;
    }
    if (level.multiteam && var_4dfb2196 == level.teams.size - 1) {
        InvalidOpCode(0x64, level.onforfeit, var_9c3f07a7);
        // Unknown operator (0x64, t7_1b, PC)
    }
    return false;
}

// Namespace globallogic
// Params 0, eflags: 0x0
// Checksum 0x14f6ae10, Offset: 0x3840
// Size: 0x69
function dospawnqueueupdates() {
    foreach (team in level.teams) {
        if (level.spawnqueuemodified[team]) {
            [[ level.onalivecountchange ]](team);
        }
    }
}

// Namespace globallogic
// Params 1, eflags: 0x0
// Checksum 0xdb3d7406, Offset: 0x38b8
// Size: 0x2f
function isteamalldead(team) {
    return level.everexisted[team] && !level.alivecount[team] && !level.playerlives[team];
}

// Namespace globallogic
// Params 0, eflags: 0x0
// Checksum 0x62f5874f, Offset: 0x38f0
// Size: 0x69
function areallteamsdead() {
    foreach (team in level.teams) {
        if (!isteamalldead(team)) {
            return false;
        }
    }
    return true;
}

// Namespace globallogic
// Params 0, eflags: 0x0
// Checksum 0xee439096, Offset: 0x3968
// Size: 0xb5
function function_4f9a4c7f() {
    count = 0;
    var_42bbdeba = 0;
    aliveteam = undefined;
    foreach (team in level.teams) {
        if (level.everexisted[team]) {
            if (!isteamalldead(team)) {
                aliveteam = team;
                count++;
            }
            var_42bbdeba++;
        }
    }
    if (var_42bbdeba > 1 && count == 1) {
        return aliveteam;
    }
    return undefined;
}

// Namespace globallogic
// Params 0, eflags: 0x0
// Checksum 0x5a37ad4b, Offset: 0x3a28
// Size: 0x138
function dodeadeventupdates() {
    if (level.teambased) {
        if (areallteamsdead()) {
            [[ level.ondeadevent ]]("all");
            return true;
        }
        if (!isdefined(level.ondeadevent)) {
            var_718021e5 = function_4f9a4c7f();
            if (isdefined(var_718021e5)) {
                [[ level.onlastteamaliveevent ]](var_718021e5);
                return true;
            }
        } else {
            foreach (team in level.teams) {
                if (isteamalldead(team)) {
                    [[ level.ondeadevent ]](team);
                    return true;
                }
            }
        }
    } else if (totalalivecount() == 0 && totalplayerlives() == 0 && level.maxplayercount > 1) {
        [[ level.ondeadevent ]]("all");
        return true;
    }
    return false;
}

// Namespace globallogic
// Params 1, eflags: 0x0
// Checksum 0xde843a34, Offset: 0x3b68
// Size: 0x35
function isonlyoneleftaliveonteam(team) {
    return level.lastalivecount[team] > 1 && level.alivecount[team] == 1 && level.playerlives[team] == 1;
}

// Namespace globallogic
// Params 0, eflags: 0x0
// Checksum 0x94d3bcf1, Offset: 0x3ba8
// Size: 0xd8
function doonelefteventupdates() {
    if (level.teambased) {
        foreach (team in level.teams) {
            if (isonlyoneleftaliveonteam(team)) {
                [[ level.ononeleftevent ]](team);
                return true;
            }
        }
    } else if (totalalivecount() == 1 && totalplayerlives() == 1 && level.maxplayercount > 1) {
        [[ level.ononeleftevent ]]("all");
        return true;
    }
    return false;
}

// Namespace globallogic
// Params 0, eflags: 0x0
// Checksum 0xd679d8a8, Offset: 0x3c88
// Size: 0x176
function updategameevents() {
    /#
        if (getdvarint("<dev string:x83>") == 1) {
            return;
        }
    #/
    if ((level.rankedmatch || level.leaguematch) && !level.ingraceperiod) {
        if (level.teambased) {
            if (!level.gameforfeited) {
                InvalidOpCode(0x54, "state");
                // Unknown operator (0x54, t7_1b, PC)
            }
            if (atleasttwoteams()) {
                level.gameforfeited = 0;
                level notify(#"hash_577494dc");
            }
        } else if (!level.gameforfeited) {
            if (util::totalplayercount() == 1 && level.maxplayercount > 1) {
                InvalidOpCode(0x64, level.onforfeit);
                // Unknown operator (0x64, t7_1b, PC)
            }
        } else if (util::totalplayercount() > 1) {
            level.gameforfeited = 0;
            level notify(#"hash_577494dc");
        }
    }
    if (!level.playerqueuedrespawn && !level.numlives && !level.inovertime) {
        return;
    }
    if (level.ingraceperiod) {
        return;
    }
    if (level.playerqueuedrespawn) {
        dospawnqueueupdates();
    }
    if (dodeadeventupdates()) {
        return;
    }
    if (doonelefteventupdates()) {
        return;
    }
}

// Namespace globallogic
// Params 0, eflags: 0x0
// Checksum 0x37fd087a, Offset: 0x3e08
// Size: 0x55
function mpintro_visionset_ramp_hold_func() {
    level endon(#"mpintro_ramp_out_notify");
    while (true) {
        for (player_index = 0; player_index < level.players.size; player_index++) {
            self visionset_mgr::set_state_active(level.players[player_index], 1);
        }
        wait 0.05;
    }
}

// Namespace globallogic
// Params 0, eflags: 0x0
// Checksum 0x5bb997f6, Offset: 0x3e68
// Size: 0x32
function mpintro_visionset_activate_func() {
    visionset_mgr::activate("visionset", "mpintro", undefined, 0, &mpintro_visionset_ramp_hold_func, 2);
}

// Namespace globallogic
// Params 0, eflags: 0x0
// Checksum 0xbda313fb, Offset: 0x3ea8
// Size: 0xb
function mpintro_visionset_deactivate_func() {
    level notify(#"mpintro_ramp_out_notify");
}

// Namespace globallogic
// Params 0, eflags: 0x0
// Checksum 0x814bf4ab, Offset: 0x3ec0
// Size: 0x1e2
function matchstarttimer() {
    mpintro_visionset_activate_func();
    level thread sndsetmatchsnapshot(1);
    waitforplayers();
    counttime = int(level.prematchperiod);
    if (counttime >= 2) {
        while (counttime > 0 && !level.gameended) {
            luinotifyevent(%create_prematch_timer, 1, gettime() + counttime * 1000);
            if (counttime == 2) {
                mpintro_visionset_deactivate_func();
            }
            if (counttime == 3) {
                level thread sndsetmatchsnapshot(0);
                foreach (player in level.players) {
                    if (player.hasspawned || player.pers["team"] == "spectator") {
                        player globallogic_audio::set_music_on_player("spawnPreRise");
                    }
                }
            }
            counttime--;
            foreach (player in level.players) {
                player playlocalsound("uin_start_count_down");
            }
            wait 1;
        }
        luinotifyevent(%prematch_timer_ended, 0);
        return;
    }
    mpintro_visionset_deactivate_func();
}

// Namespace globallogic
// Params 0, eflags: 0x0
// Checksum 0xfca46136, Offset: 0x40b0
// Size: 0x2a
function matchstarttimerskip() {
    visionsetnaked(getdvarstring("mapname"), 0);
}

// Namespace globallogic
// Params 1, eflags: 0x0
// Checksum 0x96cfef00, Offset: 0x40e8
// Size: 0x2a
function sndsetmatchsnapshot(num) {
    wait 0.05;
    level clientfield::set("sndMatchSnapshot", num);
}

// Namespace globallogic
// Params 2, eflags: 0x0
// Checksum 0xecfb60e1, Offset: 0x4120
// Size: 0x57
function notifyteamwavespawn(team, time) {
    if (time - level.lastwave[team] > level.wavedelay[team] * 1000) {
        level notify("wave_respawn_" + team);
        level.lastwave[team] = time;
        level.waveplayerspawnindex[team] = 0;
    }
}

// Namespace globallogic
// Params 0, eflags: 0x0
// Checksum 0xf6b55291, Offset: 0x4180
// Size: 0x39
function wavespawntimer() {
    level endon(#"game_ended");
    InvalidOpCode(0x54, "state");
    // Unknown operator (0x54, t7_1b, PC)
}

// Namespace globallogic
// Params 0, eflags: 0x0
// Checksum 0xc5d56594, Offset: 0x4220
// Size: 0x77
function hostidledout() {
    hostplayer = util::gethostplayer();
    /#
        if (getdvarint("<dev string:x99>") == 1 || getdvarint("<dev string:x83>") == 1) {
            return false;
        }
    #/
    if (isdefined(hostplayer) && !hostplayer.hasspawned && !isdefined(hostplayer.selectedclass)) {
        return true;
    }
    return false;
}

// Namespace globallogic
// Params 3, eflags: 0x0
// Checksum 0x1e6615c6, Offset: 0x42a0
// Size: 0x42
function incrementmatchcompletionstat(gamemode, playedorhosted, stat) {
    self adddstat("gameHistory", gamemode, "modeHistory", playedorhosted, stat, 1);
}

// Namespace globallogic
// Params 3, eflags: 0x0
// Checksum 0xf2026886, Offset: 0x42f0
// Size: 0x42
function setmatchcompletionstat(gamemode, playedorhosted, stat) {
    self setdstat("gameHistory", gamemode, "modeHistory", playedorhosted, stat, 1);
}

// Namespace globallogic
// Params 0, eflags: 0x0
// Checksum 0xcae78ee8, Offset: 0x4340
// Size: 0x105
function getteamscoreratio() {
    playerteam = self.pers["team"];
    score = getteamscore(playerteam);
    otherteamscore = 0;
    foreach (team in level.teams) {
        if (team == playerteam) {
            continue;
        }
        otherteamscore += getteamscore(team);
    }
    if (level.teams.size > 1) {
        otherteamscore /= level.teams.size - 1;
    }
    if (otherteamscore != 0) {
        return (float(score) / float(otherteamscore));
    }
    return score;
}

// Namespace globallogic
// Params 0, eflags: 0x0
// Checksum 0xff261f98, Offset: 0x4450
// Size: 0x69
function gethighestscore() {
    highestscore = -999999999;
    for (index = 0; index < level.players.size; index++) {
        player = level.players[index];
        if (player.score > highestscore) {
            highestscore = player.score;
        }
    }
    return highestscore;
}

// Namespace globallogic
// Params 1, eflags: 0x0
// Checksum 0x4aecf57b, Offset: 0x44c8
// Size: 0x85
function getnexthighestscore(score) {
    highestscore = -999999999;
    for (index = 0; index < level.players.size; index++) {
        player = level.players[index];
        if (player.score >= score) {
            continue;
        }
        if (player.score > highestscore) {
            highestscore = player.score;
        }
    }
    return highestscore;
}

// Namespace globallogic
// Params 0, eflags: 0x0
// Checksum 0x68618a45, Offset: 0x4558
// Size: 0x26a
function recordplaystyleinformation() {
    avgkilldistance = 0;
    percenttimemoving = 0;
    avgspeedofplayerwhenmoving = 0;
    totalkilldistances = float(self.pers["kill_distances"]);
    numkilldistanceentries = self.pers["num_kill_distance_entries"];
    timeplayedmoving = float(self.pers["time_played_moving"]);
    timeplayedalive = self.pers["time_played_alive"];
    totalspeedswhenmoving = float(self.pers["total_speeds_when_moving"]);
    numspeedswhenmovingentries = float(self.pers["num_speeds_when_moving_entries"]);
    totaldistancetravelled = float(self.pers["total_distance_travelled"]);
    if (numkilldistanceentries > 0) {
        avgkilldistance = totalkilldistances / numkilldistanceentries;
    }
    if (timeplayedalive > 0) {
        percenttimemoving = timeplayedmoving / timeplayedalive * 100;
    }
    if (numspeedswhenmovingentries > 0) {
        avgspeedofplayerwhenmoving = totalspeedswhenmoving / numspeedswhenmovingentries;
    }
    recordplayerstats(self, "totalKillDistances", totalkilldistances);
    recordplayerstats(self, "numKillDistanceEntries", numkilldistanceentries);
    recordplayerstats(self, "timePlayedMoving", timeplayedmoving);
    recordplayerstats(self, "timePlayedAlive", timeplayedalive);
    recordplayerstats(self, "totalSpeedsWhenMoving", totalspeedswhenmoving);
    recordplayerstats(self, "numSpeedsWhenMovingEntries", numspeedswhenmovingentries);
    recordplayerstats(self, "averageKillDistance", avgkilldistance);
    recordplayerstats(self, "percentageOfTimeMoving", percenttimemoving);
    recordplayerstats(self, "averageSpeedDuringMatch", avgspeedofplayerwhenmoving);
    recordplayerstats(self, "totalDistanceTravelled", totaldistancetravelled);
    bbprint("mpplaystyles", "averageKillDistance %f percentageOfTimeMoving %f averageSpeedDuringMatch %f", avgkilldistance, percenttimemoving, avgspeedofplayerwhenmoving);
}

// Namespace globallogic
// Params 1, eflags: 0x0
// Checksum 0xa563a177, Offset: 0x47d0
// Size: 0x69
function getplayerbyname(name) {
    for (index = 0; index < level.players.size; index++) {
        player = level.players[index];
        if (player util::is_bot()) {
            continue;
        }
        if (player.name == name) {
            return player;
        }
    }
}

// Namespace globallogic
// Params 0, eflags: 0x0
// Checksum 0xee2e2047, Offset: 0x4848
// Size: 0x752
function sendafteractionreport() {
    /#
        if (getdvarint("<dev string:x99>") == 1) {
            return;
        }
    #/
    for (index = 0; index < level.players.size; index++) {
        player = level.players[index];
        if (player util::is_bot()) {
            continue;
        }
        nemesis = player.pers["nemesis_name"];
        if (!isdefined(player.pers["killed_players"][nemesis])) {
            player.pers["killed_players"][nemesis] = 0;
        }
        if (!isdefined(player.pers["killed_by"][nemesis])) {
            player.pers["killed_by"][nemesis] = 0;
        }
        spread = player.kills - player.deaths;
        if (player.pers["cur_kill_streak"] > player.pers["best_kill_streak"]) {
            player.pers["best_kill_streak"] = player.pers["cur_kill_streak"];
        }
        if (level.rankedmatch || level.leaguematch) {
            player persistence::function_2eb5e93("privateMatch", 0);
        } else {
            player persistence::function_2eb5e93("privateMatch", 1);
        }
        player setnemesisxuid(player.pers["nemesis_xuid"]);
        player persistence::function_2eb5e93("nemesisName", nemesis);
        player persistence::function_2eb5e93("nemesisRank", player.pers["nemesis_rank"]);
        player persistence::function_2eb5e93("nemesisRankIcon", player.pers["nemesis_rankIcon"]);
        player persistence::function_2eb5e93("nemesisKills", player.pers["killed_players"][nemesis]);
        player persistence::function_2eb5e93("nemesisKilledBy", player.pers["killed_by"][nemesis]);
        nemesisplayerent = getplayerbyname(nemesis);
        if (isdefined(nemesisplayerent)) {
            player persistence::function_2eb5e93("nemesisHeroIndex", nemesisplayerent getcharacterbodytype());
        }
        player persistence::function_2eb5e93("bestKillstreak", player.pers["best_kill_streak"]);
        player persistence::function_2eb5e93("kills", player.kills);
        player persistence::function_2eb5e93("deaths", player.deaths);
        player persistence::function_2eb5e93("headshots", player.headshots);
        player persistence::function_2eb5e93("score", player.score);
        player persistence::function_2eb5e93("xpEarned", int(player.pers["summary"]["xp"]));
        player persistence::function_2eb5e93("cpEarned", int(player.pers["summary"]["codpoints"]));
        player persistence::function_2eb5e93("miscBonus", int(player.pers["summary"]["challenge"] + player.pers["summary"]["misc"]));
        player persistence::function_2eb5e93("matchBonus", int(player.pers["summary"]["match"]));
        player persistence::function_2eb5e93("demoFileID", getdemofileid());
        player persistence::function_2eb5e93("leagueTeamID", player function_8c3e1178());
        if (level.onlinegame) {
            teamscoreratio = player getteamscoreratio();
            scoreboardposition = getplacementforplayer(player);
            if (scoreboardposition < 0) {
                scoreboardposition = level.players.size;
            }
            player gamehistoryfinishmatch(4, player.kills, player.deaths, player.score, scoreboardposition, teamscoreratio);
            placement = level.placement["all"];
            for (otherplayerindex = 0; otherplayerindex < placement.size; otherplayerindex++) {
                if (level.placement["all"][otherplayerindex] == player) {
                    recordplayerstats(player, "position", otherplayerindex);
                }
            }
            if (isdefined(player.pers["matchesPlayedStatsTracked"])) {
                gamemode = util::getcurrentgamemode();
                player incrementmatchcompletionstat(gamemode, "played", "completed");
                if (isdefined(player.pers["matchesHostedStatsTracked"])) {
                    player incrementmatchcompletionstat(gamemode, "hosted", "completed");
                    player.pers["matchesHostedStatsTracked"] = undefined;
                }
                player.pers["matchesPlayedStatsTracked"] = undefined;
            }
            recordplayerstats(player, "highestKillStreak", player.pers["best_kill_streak"]);
            recordplayerstats(player, "numUavCalled", player killstreaks::get_killstreak_usage("uav_used"));
            recordplayerstats(player, "numDogsCalleD", player killstreaks::get_killstreak_usage("dogs_used"));
            recordplayerstats(player, "numDogsKills", player.pers["dog_kills"]);
            player recordplaystyleinformation();
            recordplayermatchend(player);
            recordplayerstats(player, "presentAtEnd", 1);
        }
    }
    finalizematchrecord();
}

// Namespace globallogic
// Params 0, eflags: 0x0
// Checksum 0xcdf35c47, Offset: 0x4fa8
// Size: 0x16d
function gamehistoryplayerkicked() {
    teamscoreratio = self getteamscoreratio();
    scoreboardposition = getplacementforplayer(self);
    if (scoreboardposition < 0) {
        scoreboardposition = level.players.size;
    }
    /#
        assert(isdefined(self.kills));
        assert(isdefined(self.deaths));
        assert(isdefined(self.score));
        assert(isdefined(scoreboardposition));
        assert(isdefined(teamscoreratio));
    #/
    self gamehistoryfinishmatch(2, self.kills, self.deaths, self.score, scoreboardposition, teamscoreratio);
    if (isdefined(self.pers["matchesPlayedStatsTracked"])) {
        gamemode = util::getcurrentgamemode();
        self incrementmatchcompletionstat(gamemode, "played", "kicked");
        self.pers["matchesPlayedStatsTracked"] = undefined;
    }
    uploadstats(self);
    wait 1;
}

// Namespace globallogic
// Params 0, eflags: 0x0
// Checksum 0x5d69749e, Offset: 0x5120
// Size: 0x148
function gamehistoryplayerquit() {
    teamscoreratio = self getteamscoreratio();
    scoreboardposition = getplacementforplayer(self);
    if (scoreboardposition < 0) {
        scoreboardposition = level.players.size;
    }
    self gamehistoryfinishmatch(3, self.kills, self.deaths, self.score, scoreboardposition, teamscoreratio);
    if (isdefined(self.pers["matchesPlayedStatsTracked"])) {
        gamemode = util::getcurrentgamemode();
        self incrementmatchcompletionstat(gamemode, "played", "quit");
        if (isdefined(self.pers["matchesHostedStatsTracked"])) {
            self incrementmatchcompletionstat(gamemode, "hosted", "quit");
            self.pers["matchesHostedStatsTracked"] = undefined;
        }
        self.pers["matchesPlayedStatsTracked"] = undefined;
    }
    uploadstats(self);
    if (!self ishost()) {
        wait 1;
    }
}

// Namespace globallogic
// Params 2, eflags: 0x0
// Checksum 0x47ec16f9, Offset: 0x5270
// Size: 0x22a
function displayroundend(winner, endreasontext) {
    if (level.displayroundendtext) {
        if (level.teambased) {
            if (winner == "tie") {
                demo::function_e2be394("round_result", level.teamindex["neutral"], level.teamindex["neutral"]);
            } else {
                demo::function_e2be394("round_result", level.teamindex[winner], level.teamindex["neutral"]);
            }
        }
        setmatchflag("cg_drawSpectatorMessages", 0);
        players = level.players;
        for (index = 0; index < players.size; index++) {
            player = players[index];
            if (!util::waslastround()) {
                player notify(#"round_ended");
            }
            if (!isdefined(player.pers["team"])) {
                player [[ level.spawnintermission ]](1);
                continue;
            }
            if (level.teambased) {
                player thread [[ level.onteamoutcomenotify ]](winner, 1, endreasontext);
                player globallogic_audio::set_music_on_player("roundEnd");
            } else {
                player thread [[ level.onoutcomenotify ]](winner, 1, endreasontext);
                player globallogic_audio::set_music_on_player("roundEnd");
            }
            player setclientuivisibilityflag("hud_visible", 0);
            player setclientuivisibilityflag("g_compassShowEnemies", 0);
        }
    }
    if (util::waslastround()) {
        roundendwait(level.roundenddelay, 0);
        return;
    }
    thread globallogic_audio::announce_round_winner(winner, level.roundenddelay / 4);
    roundendwait(level.roundenddelay, 1);
}

// Namespace globallogic
// Params 2, eflags: 0x0
// Checksum 0x8550b14a, Offset: 0x54a8
// Size: 0x1da
function displayroundswitch(winner, endreasontext) {
    switchtype = level.halftimetype;
    level thread globallogic_audio::set_music_global("roundSwitch");
    if (switchtype == "halftime") {
        if (isdefined(level.nextroundisovertime) && level.nextroundisovertime) {
            switchtype = "overtime";
        } else {
            if (level.roundlimit) {
                InvalidOpCode(0x54, "roundsplayed");
                // Unknown operator (0x54, t7_1b, PC)
            }
            if (level.scorelimit) {
                InvalidOpCode(0x54, "roundsplayed");
                // Unknown operator (0x54, t7_1b, PC)
            }
            switchtype = "intermission";
        }
    }
    leaderdialog = globallogic_audio::get_round_switch_dialog(switchtype);
    setmatchtalkflag("EveryoneHearsEveryone", 1);
    players = level.players;
    for (index = 0; index < players.size; index++) {
        player = players[index];
        if (!isdefined(player.pers["team"])) {
            player [[ level.spawnintermission ]](1);
            continue;
        }
        player globallogic_audio::leader_dialog_on_player(leaderdialog);
        player thread [[ level.onteamoutcomenotify ]](switchtype, 0, level.halftimesubcaption);
        player setclientuivisibilityflag("hud_visible", 0);
    }
    roundendwait(level.halftimeroundenddelay, 0);
}

// Namespace globallogic
// Params 2, eflags: 0x0
// Checksum 0x6e84f003, Offset: 0x5690
// Size: 0x41a
function displaygameend(winner, endreasontext) {
    setmatchtalkflag("EveryoneHearsEveryone", 1);
    setmatchflag("cg_drawSpectatorMessages", 0);
    level thread sndsetmatchsnapshot(2);
    if (level.teambased) {
        if (winner == "tie") {
            demo::function_e2be394("game_result", level.teamindex["neutral"], level.teamindex["neutral"]);
        } else {
            demo::function_e2be394("game_result", level.teamindex[winner], level.teamindex["neutral"]);
        }
    }
    players = level.players;
    for (index = 0; index < players.size; index++) {
        player = players[index];
        if (!isdefined(player.pers["team"])) {
            player [[ level.spawnintermission ]](1);
            continue;
        }
        if (level.teambased) {
            player thread [[ level.onteamoutcomenotify ]](winner, 0, endreasontext);
        } else {
            if (!(isdefined(level.freerun) && level.freerun)) {
                player thread [[ level.onoutcomenotify ]](winner, 0, endreasontext);
            }
            if (isdefined(level.freerun) && level.freerun) {
                player globallogic_audio::set_music_on_player("mp_freerun_gameover");
            } else if (isdefined(winner) && player == winner) {
                player globallogic_audio::set_music_on_player("matchWin");
            } else if (!level.splitscreen) {
                player globallogic_audio::set_music_on_player("matchLose");
            }
        }
        player setclientuivisibilityflag("hud_visible", 0);
        player setclientuivisibilityflag("g_compassShowEnemies", 0);
    }
    if (level.teambased) {
        thread globallogic_audio::announce_game_winner(winner);
        players = level.players;
        for (index = 0; index < players.size; index++) {
            player = players[index];
            team = player.pers["team"];
            if (level.splitscreen) {
                if (isdefined(level.freerun) && level.freerun) {
                    player globallogic_audio::set_music_on_player("mp_freerun_gameover");
                } else if (winner == "tie") {
                    player globallogic_audio::set_music_on_player("matchDraw");
                } else if (winner == team) {
                    player globallogic_audio::set_music_on_player("matchWin");
                } else {
                    player globallogic_audio::set_music_on_player("matchLose");
                }
                continue;
            }
            if (isdefined(level.freerun) && level.freerun) {
                player globallogic_audio::set_music_on_player("mp_freerun_gameover");
                continue;
            }
            if (winner == "tie") {
                player globallogic_audio::set_music_on_player("matchDraw");
                continue;
            }
            if (winner == team) {
                player globallogic_audio::set_music_on_player("matchWin");
                continue;
            }
            player globallogic_audio::set_music_on_player("matchLose");
        }
    }
    bbprint("global_session_epilogs", "reason %s", endreasontext);
    bbprint("mpmatchfacts", "gametime %d winner %s killstreakcount %d", gettime(), winner, level.globalkillstreakscalled);
    roundendwait(level.postroundtime, 1);
}

// Namespace globallogic
// Params 1, eflags: 0x0
// Checksum 0x4d6296ef, Offset: 0x5ab8
// Size: 0x261
function function_efd70c10(result) {
    players = level.players;
    for (index = 0; index < players.size; index++) {
        player = players[index];
        if (player util::is_bot()) {
            currxp = 0;
            prevxp = 0;
        } else {
            currxp = player rank::getrankxpstat();
            prevxp = player.pers["rankxp"];
        }
        xpearned = currxp - prevxp;
        recordcomscoreevent("end_match", "match_id", getdemofileid(), "game_variant", "mp", "game_mode", level.gametype, "game_playlist", "N/A", "game_map", getdvarstring("mapname"), "player_xuid", player getxuid(), "player_ip", player getipaddress(), "match_kills", player.kills, "match_deaths", player.deaths, "match_xp", xpearned, "match_score", player.score, "match_streak", player.pers["best_kill_streak"], "match_captures", player.pers["captures"], "match_defends", player.pers["defends"], "match_headshots", player.pers["headshots"], "match_longshots", player.pers["longshots"], "prestige_max", player.pers["plevel"], "level_max", player.pers["rank"], "match_result", result, "match_duration", player.timeplayed["total"]);
    }
}

// Namespace globallogic
// Params 0, eflags: 0x0
// Checksum 0xe2cf4f18, Offset: 0x5d28
// Size: 0xd5
function getendreasontext() {
    if (isdefined(level.endreasontext)) {
        return level.endreasontext;
    }
    if (util::hitroundlimit() || util::hitroundwinlimit()) {
        InvalidOpCode(0x54, "strings", "round_limit_reached");
        // Unknown operator (0x54, t7_1b, PC)
    }
    if (util::hitscorelimit()) {
        InvalidOpCode(0x54, "strings", "score_limit_reached");
        // Unknown operator (0x54, t7_1b, PC)
    }
    if (util::hitroundscorelimit()) {
        InvalidOpCode(0x54, "strings", "round_score_limit_reached");
        // Unknown operator (0x54, t7_1b, PC)
    }
    if (level.forcedend) {
        if (level.hostforcedend) {
            return %MP_HOST_ENDED_GAME;
        } else {
            return %MP_ENDED_GAME;
        }
    }
    InvalidOpCode(0x54, "strings", "time_limit_reached");
    // Unknown operator (0x54, t7_1b, PC)
}

// Namespace globallogic
// Params 0, eflags: 0x0
// Checksum 0xcd0a446c, Offset: 0x5e08
// Size: 0x4b
function resetoutcomeforallplayers() {
    players = level.players;
    for (index = 0; index < players.size; index++) {
        player = players[index];
        player notify(#"reset_outcome");
    }
}

// Namespace globallogic
// Params 0, eflags: 0x0
// Checksum 0x2549b072, Offset: 0x5e60
// Size: 0x59
function function_eac9a653() {
    players = level.players;
    for (index = 0; index < players.size; index++) {
        player = players[index];
        player clientfield::set_player_uimodel("hudItems.hideOutcomeUI", 1);
    }
}

// Namespace globallogic
// Params 2, eflags: 0x0
// Checksum 0xd83096a0, Offset: 0x5ec8
// Size: 0x27e
function function_26850b50(winner, endreasontext) {
    if (!util::isoneround()) {
        displayroundend(winner, endreasontext);
        globallogic_utils::executepostroundevents();
        if (!util::waslastround()) {
            if (checkroundswitch()) {
                if (level.scoreroundwinbased) {
                    var_addd56f4 = level.teams;
                    var_199c2732 = firstarray(var_addd56f4);
                    if (isdefined(var_199c2732)) {
                        team = var_addd56f4[var_199c2732];
                        var_35494db = nextarray(var_addd56f4, var_199c2732);
                        InvalidOpCode(0x54, "roundswon", team);
                        // Unknown operator (0x54, t7_1b, PC)
                    }
                }
                displayroundswitch(winner, endreasontext);
            }
            if (isdefined(level.nextroundisovertime) && level.nextroundisovertime) {
                InvalidOpCode(0x54, "overtime_round");
                // Unknown operator (0x54, t7_1b, PC)
            }
            setmatchtalkflag("DeadChatWithDead", level.voip.deadchatwithdead);
            setmatchtalkflag("DeadChatWithTeam", level.voip.deadchatwithteam);
            setmatchtalkflag("DeadHearTeamLiving", level.voip.deadhearteamliving);
            setmatchtalkflag("DeadHearAllLiving", level.voip.deadhearallliving);
            setmatchtalkflag("EveryoneHearsEveryone", level.voip.everyonehearseveryone);
            setmatchtalkflag("DeadHearKiller", level.voip.deadhearkiller);
            setmatchtalkflag("KillersHearVictim", level.voip.killershearvictim);
            InvalidOpCode(0xc8, "state", "playing");
            // Unknown operator (0xc8, t7_1b, PC)
        }
    }
    return false;
}

// Namespace globallogic
// Params 0, eflags: 0x0
// Checksum 0xaed7a412, Offset: 0x6150
// Size: 0x263
function function_fe2db310() {
    if (level.rankedmatch) {
        placement = level.placement["all"];
        topthreeplayers = min(3, placement.size);
        for (index = 0; index < topthreeplayers; index++) {
            if (level.placement["all"][index].score) {
                if (!index) {
                    level.placement["all"][index] addplayerstatwithgametype("TOPPLAYER", 1);
                    level.placement["all"][index] notify(#"topplayer");
                } else {
                    level.placement["all"][index] notify(#"hash_654bc6be");
                }
                level.placement["all"][index] addplayerstatwithgametype("TOP3", 1);
                level.placement["all"][index] addplayerstat("TOP3ANY", 1);
                if (level.hardcoremode) {
                    level.placement["all"][index] addplayerstat("TOP3ANY_HC", 1);
                }
                if (level.multiteam) {
                    level.placement["all"][index] addplayerstat("TOP3ANY_MULTITEAM", 1);
                }
                level.placement["all"][index] notify(#"TOP3");
            }
        }
        for (index = 3; index < placement.size; index++) {
            level.placement["all"][index] notify(#"hash_1fc5ff08");
            level.placement["all"][index] notify(#"hash_654bc6be");
        }
        if (level.teambased) {
            foreach (team in level.teams) {
                function_cc3ae2fc(team);
            }
        }
    }
}

// Namespace globallogic
// Params 1, eflags: 0x0
// Checksum 0xfad598dd, Offset: 0x63c0
// Size: 0x121
function function_cc3ae2fc(team) {
    var_f43a8455 = level.placement[team];
    var_d73408dd = min(3, var_f43a8455.size);
    if (var_f43a8455.size < 5) {
        return;
    }
    for (index = 0; index < var_d73408dd; index++) {
        if (var_f43a8455[index].score) {
            var_f43a8455[index] addplayerstat("TOP3TEAM", 1);
            var_f43a8455[index] addplayerstat("TOP3ANY", 1);
            if (level.hardcoremode) {
                var_f43a8455[index] addplayerstat("TOP3ANY_HC", 1);
            }
            if (level.multiteam) {
                var_f43a8455[index] addplayerstat("TOP3ANY_MULTITEAM", 1);
            }
            var_f43a8455[index] addplayerstatwithgametype("TOP3TEAM", 1);
        }
    }
}

// Namespace globallogic
// Params 1, eflags: 0x0
// Checksum 0x42bbdd07, Offset: 0x64f0
// Size: 0x50
function function_db16a372(winner) {
    if (!isdefined(winner)) {
        return "tie";
    }
    if (isentity(winner)) {
        return (isdefined(winner.team) ? winner.team : "none");
    }
    return winner;
}

// Namespace globallogic
// Params 0, eflags: 0x0
// Checksum 0x1c986986, Offset: 0x6548
// Size: 0x5d
function getgamelength() {
    if (!level.timelimit || level.forcedend) {
        gamelength = globallogic_utils::gettimepassed() / 1000;
        gamelength = min(gamelength, 1200);
    } else {
        gamelength = level.timelimit * 60;
    }
    return gamelength;
}

// Namespace globallogic
// Params 2, eflags: 0x0
// Checksum 0xdb609669, Offset: 0x65b0
// Size: 0x81
function endgame(winner, endreasontext) {
    InvalidOpCode(0x54, "state");
    // Unknown operator (0x54, t7_1b, PC)
}

// Namespace globallogic
// Params 1, eflags: 0x0
// Checksum 0xe439ce47, Offset: 0x6e28
// Size: 0x151
function function_2887d110(winner) {
    topscorers = [];
    winning_team = function_db16a372(winner);
    if (level.teambased && isdefined(winner) && isdefined(level.placement[winning_team])) {
        topscorers = level.placement[winning_team];
    } else {
        topscorers = level.placement["all"];
    }
    if (topscorers.size) {
        level.var_62e3c90e = 1;
    } else {
        level.var_62e3c90e = 0;
    }
    cleartopscorers();
    for (i = 0; i < 3 && i < topscorers.size; i++) {
        player = topscorers[i];
        showcase_weapon = player weapons::showcaseweapon_get();
        if (!isdefined(showcase_weapon)) {
            settopscorer(i, player, getweapon("ar_standard"));
            continue;
        }
        settopscorer(i, player, showcase_weapon["weapon"], showcase_weapon["options"], showcase_weapon["acvi"]);
    }
}

// Namespace globallogic
// Params 0, eflags: 0x0
// Checksum 0x6327a743, Offset: 0x6f88
// Size: 0x16a
function function_c33296a0() {
    level notify(#"hash_6c5f97fe");
    if (level.var_62e3c90e && isdefined(struct::get("endgame_top_players_struct", "targetname"))) {
        topplayer = undefined;
        if (level.placement["all"].size > 0) {
            topplayer = level.placement["all"][0];
            var_dd205ce7 = "endgame_top_players_struct";
            position = struct::get(var_dd205ce7, "targetname").origin + (0, 0, 60);
            topplayer thread battlechatter::function_aca68a77(position);
        }
        level thread sndsetmatchsnapshot(3);
        level thread globallogic_audio::set_music_global("endmatch");
        level clientfield::set("displayTop3Players", 1);
        wait 7;
        if (isdefined(topplayer)) {
            topplayer notify(#"hash_b986c14e");
        }
        level clientfield::set("triggerScoreboardCamera", 1);
        wait 5;
        return;
    }
    if (level.doendgamescoreboard) {
        luinotifyevent(%force_scoreboard, 0);
    }
}

// Namespace globallogic
// Params 3, eflags: 0x0
// Checksum 0x3cab72aa, Offset: 0x7100
// Size: 0xf2
function bbplayermatchend(gamelength, endreasonstring, gameover) {
    playerrank = getplacementforplayer(self);
    totaltimeplayed = 0;
    if (isdefined(self.timeplayed) && isdefined(self.timeplayed["total"])) {
        totaltimeplayed = self.timeplayed["total"];
        if (totaltimeplayed > gamelength) {
            totaltimeplayed = gamelength;
        }
    }
    xuid = self getxuid();
    bbprint("mpplayermatchfacts", "score %d momentum %d endreason %s sessionrank %d playtime %d xuid %s gameover %d team %s", self.pers["score"], self.pers["momentum"], endreasonstring, playerrank, totaltimeplayed, xuid, gameover, self.pers["team"]);
}

// Namespace globallogic
// Params 2, eflags: 0x0
// Checksum 0x4b195ec4, Offset: 0x7200
// Size: 0x123
function roundendwait(defaultdelay, matchbonus) {
    notifiesdone = 0;
    while (!notifiesdone) {
        players = level.players;
        notifiesdone = 1;
        for (index = 0; index < players.size; index++) {
            if (!isdefined(players[index].var_decbf609) || !players[index].var_decbf609) {
                continue;
            }
            notifiesdone = 0;
        }
        wait 0.5;
    }
    if (!matchbonus) {
        wait defaultdelay;
        level notify(#"round_end_done");
        return;
    }
    wait defaultdelay / 2;
    level notify(#"give_match_bonus");
    wait defaultdelay / 2;
    notifiesdone = 0;
    while (!notifiesdone) {
        players = level.players;
        notifiesdone = 1;
        for (index = 0; index < players.size; index++) {
            if (!isdefined(players[index].var_decbf609) || !players[index].var_decbf609) {
                continue;
            }
            notifiesdone = 0;
        }
        wait 0.5;
    }
    level notify(#"round_end_done");
}

// Namespace globallogic
// Params 1, eflags: 0x0
// Checksum 0x3cff16a8, Offset: 0x7330
// Size: 0x2a
function roundenddof(time) {
    self setdepthoffield(0, -128, 512, 4000, 6, 1.8);
}

// Namespace globallogic
// Params 0, eflags: 0x0
// Checksum 0x76ae380c, Offset: 0x7368
// Size: 0x31
function checktimelimit() {
    if (isdefined(level.timelimitoverride) && level.timelimitoverride) {
        return;
    }
    InvalidOpCode(0x54, "state");
    // Unknown operator (0x54, t7_1b, PC)
}

// Namespace globallogic
// Params 0, eflags: 0x0
// Checksum 0x7545e3a0, Offset: 0x74e0
// Size: 0x9
function checkscorelimit() {
    InvalidOpCode(0x54, "state");
    // Unknown operator (0x54, t7_1b, PC)
}

// Namespace globallogic
// Params 1, eflags: 0x0
// Checksum 0x52c88ae7, Offset: 0x7568
// Size: 0x11
function checksuddendeathscorelimit(team) {
    InvalidOpCode(0x54, "state");
    // Unknown operator (0x54, t7_1b, PC)
}

// Namespace globallogic
// Params 0, eflags: 0x0
// Checksum 0xb157963f, Offset: 0x75c8
// Size: 0x11
function checkroundscorelimit() {
    InvalidOpCode(0x54, "state");
    // Unknown operator (0x54, t7_1b, PC)
}

// Namespace globallogic
// Params 0, eflags: 0x0
// Checksum 0x1d5d6907, Offset: 0x7668
// Size: 0x31
function updategametypedvars() {
    level endon(#"game_ended");
    InvalidOpCode(0x54, "state");
    // Unknown operator (0x54, t7_1b, PC)
}

// Namespace globallogic
// Params 0, eflags: 0x0
// Checksum 0x9d0564c7, Offset: 0x7880
// Size: 0x15f
function removedisconnectedplayerfromplacement() {
    offset = 0;
    numplayers = level.placement["all"].size;
    found = 0;
    for (i = 0; i < numplayers; i++) {
        if (level.placement["all"][i] == self) {
            found = 1;
        }
        if (found) {
            level.placement["all"][i] = level.placement["all"][i + 1];
        }
    }
    if (!found) {
        return;
    }
    level.placement["all"][numplayers - 1] = undefined;
    assert(level.placement["<dev string:xbb>"].size == numplayers - 1);
    /#
        globallogic_utils::assertproperplacement();
    #/
    updateteamplacement();
    if (level.teambased) {
        return;
    }
    numplayers = level.placement["all"].size;
    for (i = 0; i < numplayers; i++) {
        player = level.placement["all"][i];
        player notify(#"update_outcome");
    }
}

// Namespace globallogic
// Params 0, eflags: 0x0
// Checksum 0xb1bbcedf, Offset: 0x79e8
// Size: 0x25a
function updateplacement() {
    if (!level.players.size) {
        return;
    }
    level.placement["all"] = [];
    foreach (player in level.players) {
        if (!level.teambased || isdefined(level.teams[player.team])) {
            level.placement["all"][level.placement["all"].size] = player;
        }
    }
    placementall = level.placement["all"];
    if (level.teambased) {
        for (i = 1; i < placementall.size; i++) {
            player = placementall[i];
            playerscore = player.score;
            for (j = i - 1; playerscore == placementall[j].score && (playerscore > placementall[j].score || j >= 0 && player.deaths < placementall[j].deaths); j--) {
                placementall[j + 1] = placementall[j];
            }
            placementall[j + 1] = player;
        }
    } else {
        for (i = 1; i < placementall.size; i++) {
            player = placementall[i];
            playerscore = player.pointstowin;
            for (j = i - 1; playerscore == placementall[j].pointstowin && (playerscore > placementall[j].pointstowin || j >= 0 && player.deaths < placementall[j].deaths); j--) {
                placementall[j + 1] = placementall[j];
            }
            placementall[j + 1] = player;
        }
    }
    level.placement["all"] = placementall;
    /#
        globallogic_utils::assertproperplacement();
    #/
    updateteamplacement();
}

// Namespace globallogic
// Params 0, eflags: 0x0
// Checksum 0x1ac0ddd2, Offset: 0x7c50
// Size: 0x143
function updateteamplacement() {
    foreach (team in level.teams) {
        placement[team] = [];
    }
    placement["spectator"] = [];
    if (!level.teambased) {
        return;
    }
    placementall = level.placement["all"];
    placementallsize = placementall.size;
    for (i = 0; i < placementallsize; i++) {
        player = placementall[i];
        team = player.pers["team"];
        placement[team][placement[team].size] = player;
    }
    foreach (team in level.teams) {
        level.placement[team] = placement[team];
    }
}

// Namespace globallogic
// Params 1, eflags: 0x0
// Checksum 0xebdbbd4f, Offset: 0x7da0
// Size: 0x85
function getplacementforplayer(player) {
    updateplacement();
    playerrank = -1;
    placement = level.placement["all"];
    for (placementindex = 0; placementindex < placement.size; placementindex++) {
        if (level.placement["all"][placementindex] == player) {
            playerrank = placementindex + 1;
            break;
        }
    }
    return playerrank;
}

// Namespace globallogic
// Params 1, eflags: 0x0
// Checksum 0x6c764742, Offset: 0x7e30
// Size: 0x1cb
function istopscoringplayer(player) {
    topscoringplayer = 0;
    updateplacement();
    assert(level.placement["<dev string:xbb>"].size > 0);
    if (level.placement["all"].size == 0) {
        return 0;
    }
    if (level.teambased) {
        topscore = level.placement["all"][0].score;
        for (index = 0; index < level.placement["all"].size; index++) {
            if (level.placement["all"][index].score == 0) {
                break;
            }
            if (topscore > level.placement["all"][index].score) {
                break;
            }
            if (player == level.placement["all"][index]) {
                topscoringplayer = 1;
                break;
            }
        }
    } else {
        topscore = level.placement["all"][0].pointstowin;
        for (index = 0; index < level.placement["all"].size; index++) {
            if (level.placement["all"][index].pointstowin == 0) {
                break;
            }
            if (topscore > level.placement["all"][index].pointstowin) {
                break;
            }
            if (player == level.placement["all"][index]) {
                topscoringplayer = 1;
                break;
            }
        }
    }
    return topscoringplayer;
}

// Namespace globallogic
// Params 1, eflags: 0x0
// Checksum 0x1bd7cd49, Offset: 0x8008
// Size: 0x115
function sortdeadplayers(team) {
    if (!level.playerqueuedrespawn) {
        return;
    }
    for (i = 1; i < level.deadplayers[team].size; i++) {
        player = level.deadplayers[team][i];
        for (j = i - 1; j >= 0 && player.deathtime < level.deadplayers[team][j].deathtime; j--) {
            level.deadplayers[team][j + 1] = level.deadplayers[team][j];
        }
        level.deadplayers[team][j + 1] = player;
    }
    for (i = 0; i < level.deadplayers[team].size; i++) {
        if (level.deadplayers[team][i].spawnqueueindex != i) {
            level.spawnqueuemodified[team] = 1;
        }
        level.deadplayers[team][i].spawnqueueindex = i;
    }
}

// Namespace globallogic
// Params 0, eflags: 0x0
// Checksum 0x58aadec4, Offset: 0x8128
// Size: 0x71
function totalalivecount() {
    count = 0;
    foreach (team in level.teams) {
        count += level.alivecount[team];
    }
    return count;
}

// Namespace globallogic
// Params 0, eflags: 0x0
// Checksum 0x7dcc6ea8, Offset: 0x81a8
// Size: 0x71
function totalplayerlives() {
    count = 0;
    foreach (team in level.teams) {
        count += level.playerlives[team];
    }
    return count;
}

// Namespace globallogic
// Params 1, eflags: 0x0
// Checksum 0x870dac9a, Offset: 0x8228
// Size: 0x3d
function initteamvariables(team) {
    if (!isdefined(level.alivecount)) {
        level.alivecount = [];
    }
    level.alivecount[team] = 0;
    level.lastalivecount[team] = 0;
    InvalidOpCode(0x54, "everExisted");
    // Unknown operator (0x54, t7_1b, PC)
}

// Namespace globallogic
// Params 1, eflags: 0x0
// Checksum 0xeb55549a, Offset: 0x82e0
// Size: 0x8b
function resetteamvariables(team) {
    level.playercount[team] = 0;
    level.botscount[team] = 0;
    level.lastalivecount[team] = level.alivecount[team];
    level.alivecount[team] = 0;
    level.playerlives[team] = 0;
    level.aliveplayers[team] = [];
    level.spawningplayers[team] = [];
    level.deadplayers[team] = [];
    level.squads[team] = [];
    level.spawnqueuemodified[team] = 0;
}

// Namespace globallogic
// Params 0, eflags: 0x0
// Checksum 0x774a1c30, Offset: 0x8378
// Size: 0x8d
function updateteamstatus() {
    level notify(#"updating_team_status");
    level endon(#"updating_team_status");
    level endon(#"game_ended");
    waittillframeend();
    wait 0;
    InvalidOpCode(0x54, "state");
    // Unknown operator (0x54, t7_1b, PC)
}

// Namespace globallogic
// Params 1, eflags: 0x0
// Checksum 0x29859add, Offset: 0x8728
// Size: 0x272
function updatealivetimes(team) {
    level.alivetimesaverage[team] = 0;
    total_player_count = 0;
    average_player_spawn_time = 0;
    total_value_count = 0;
    foreach (player in level.aliveplayers[team]) {
        average_time = 0;
        count = 0;
        foreach (time in player.alivetimes) {
            if (time != 0) {
                average_time += time;
                count++;
            }
        }
        if (count) {
            total_value_count += count;
            average_player_spawn_time += average_time / count;
            total_player_count++;
        }
    }
    foreach (player in level.deadplayers[team]) {
        average_time = 0;
        count = 0;
        foreach (time in player.alivetimes) {
            if (time != 0) {
                average_time += time;
                count++;
            }
        }
        if (count) {
            total_value_count += count;
            average_player_spawn_time += average_time / count;
            total_player_count++;
        }
    }
    if (total_player_count == 0 || total_value_count < 3) {
        level.alivetimesaverage[team] = 0;
        return;
    }
    level.alivetimesaverage[team] = average_player_spawn_time / total_player_count;
    /#
        if (getdvarint("<dev string:xbf>")) {
            iprintln("<dev string:xd1>" + level.alivetimesaverage["<dev string:xe7>"] + "<dev string:xee>" + level.alivetimesaverage["<dev string:xf6>"]);
        }
    #/
}

// Namespace globallogic
// Params 0, eflags: 0x0
// Checksum 0x735e8551, Offset: 0x89a8
// Size: 0x63
function updateallalivetimes() {
    foreach (team in level.teams) {
        updatealivetimes(team);
    }
}

// Namespace globallogic
// Params 1, eflags: 0x0
// Checksum 0x8bb9918d, Offset: 0x8a18
// Size: 0x8f
function checkteamscorelimitsoon(team) {
    assert(isdefined(team));
    if (level.scorelimit <= 0) {
        return;
    }
    if (!level.teambased) {
        return;
    }
    if (globallogic_utils::gettimepassed() < 60000) {
        return;
    }
    timeleft = globallogic_utils::getestimatedtimeuntilscorelimit(team);
    if (timeleft < 1) {
        level notify(#"match_ending_soon", "score");
    }
}

// Namespace globallogic
// Params 0, eflags: 0x0
// Checksum 0xc95ce693, Offset: 0x8ab0
// Size: 0x97
function checkplayerscorelimitsoon() {
    assert(isplayer(self));
    if (level.scorelimit <= 0) {
        return;
    }
    if (level.teambased) {
        return;
    }
    if (globallogic_utils::gettimepassed() < 60000) {
        return;
    }
    timeleft = globallogic_utils::getestimatedtimeuntilscorelimit(undefined);
    if (timeleft < 1) {
        level notify(#"match_ending_soon", "score");
    }
}

// Namespace globallogic
// Params 0, eflags: 0x0
// Checksum 0xd3947700, Offset: 0x8b50
// Size: 0x49
function timelimitclock() {
    level endon(#"game_ended");
    wait 0.05;
    clockobject = spawn("script_origin", (0, 0, 0));
    InvalidOpCode(0x54, "state");
    // Unknown operator (0x54, t7_1b, PC)
}

// Namespace globallogic
// Params 1, eflags: 0x0
// Checksum 0xb7f08d33, Offset: 0x8d50
// Size: 0x8d
function timelimitclock_intermission(waittime) {
    setgameendtime(gettime() + int(waittime * 1000));
    clockobject = spawn("script_origin", (0, 0, 0));
    if (waittime >= 10) {
        wait waittime - 10;
    }
    for (;;) {
        clockobject playsound("mpl_ui_timer_countdown");
        wait 1;
    }
}

// Namespace globallogic
// Params 0, eflags: 0x0
// Checksum 0x7825fb40, Offset: 0x8de8
// Size: 0x85
function recordbreadcrumbdata() {
    level endon(#"game_ended");
    while (true) {
        for (i = 0; i < level.players.size; i++) {
            player = level.players[i];
            if (isalive(player)) {
                recordbreadcrumbdataforplayer(player, player.lastshotby);
            }
        }
        wait 2;
    }
}

// Namespace globallogic
// Params 0, eflags: 0x0
// Checksum 0x9568eca7, Offset: 0x8e78
// Size: 0x1d2
function startgame() {
    thread globallogic_utils::gametimer();
    level.timerstopped = 0;
    setmatchtalkflag("DeadChatWithDead", level.voip.deadchatwithdead);
    setmatchtalkflag("DeadChatWithTeam", level.voip.deadchatwithteam);
    setmatchtalkflag("DeadHearTeamLiving", level.voip.deadhearteamliving);
    setmatchtalkflag("DeadHearAllLiving", level.voip.deadhearallliving);
    setmatchtalkflag("EveryoneHearsEveryone", level.voip.everyonehearseveryone);
    setmatchtalkflag("DeadHearKiller", level.voip.deadhearkiller);
    setmatchtalkflag("KillersHearVictim", level.voip.killershearvictim);
    if (isdefined(level.custom_prematch_period)) {
        [[ level.custom_prematch_period ]]();
    } else {
        prematchperiod();
    }
    level notify(#"prematch_over");
    thread timelimitclock();
    thread graceperiod();
    thread watchmatchendingsoon();
    thread globallogic_audio::announcercontroller();
    thread globallogic_audio::sndmusicfunctions();
    thread recordbreadcrumbdata();
    recordmatchbegin();
}

// Namespace globallogic
// Params 0, eflags: 0x0
// Checksum 0xae9ab558, Offset: 0x9058
// Size: 0xef
function waitforplayers() {
    level endon(#"game_ended");
    starttime = gettime();
    playerready = 0;
    activeplayercount = 0;
    while (!playerready || activeplayercount == 0) {
        activeplayercount = 0;
        foreach (player in level.players) {
            if (player.team != "spectator") {
                activeplayercount++;
            }
            if (player isstreamerready(-1, 1)) {
                playerready = 1;
            }
        }
        wait 0.05;
        if (gettime() - starttime > 120000) {
            exitlevel(0);
            return;
        }
    }
}

// Namespace globallogic
// Params 0, eflags: 0x0
// Checksum 0x6b417d39, Offset: 0x9150
// Size: 0xf9
function prematchperiod() {
    setmatchflag("hud_hardcore", level.hardcoremode);
    level endon(#"game_ended");
    globallogic_audio::sndmusicsetrandomizer();
    if (level.prematchperiod > 0) {
        thread matchstarttimer();
        waitforplayers();
        wait level.prematchperiod;
    } else {
        matchstarttimerskip();
        wait 0.05;
    }
    level.inprematchperiod = 0;
    level thread sndsetmatchsnapshot(0);
    for (index = 0; index < level.players.size; index++) {
        level.players[index] util::freeze_player_controls(0);
        level.players[index] enableweapons();
    }
    InvalidOpCode(0x54, "state");
    // Unknown operator (0x54, t7_1b, PC)
}

// Namespace globallogic
// Params 0, eflags: 0x0
// Checksum 0xb9383d79, Offset: 0x9260
// Size: 0x61
function graceperiod() {
    level endon(#"game_ended");
    if (isdefined(level.graceperiodfunc)) {
        [[ level.graceperiodfunc ]]();
    } else {
        wait level.graceperiod;
    }
    level notify(#"grace_period_ending");
    wait 0.05;
    level.ingraceperiod = 0;
    InvalidOpCode(0x54, "state");
    // Unknown operator (0x54, t7_1b, PC)
}

// Namespace globallogic
// Params 0, eflags: 0x0
// Checksum 0x47194664, Offset: 0x9370
// Size: 0x4a
function watchmatchendingsoon() {
    setdvar("xblive_matchEndingSoon", 0);
    level waittill(#"match_ending_soon", reason);
    setdvar("xblive_matchEndingSoon", 1);
}

// Namespace globallogic
// Params 0, eflags: 0x0
// Checksum 0xdd264d64, Offset: 0x93c8
// Size: 0x273
function assertteamvariables() {
    foreach (team in level.teams) {
        /#
            InvalidOpCode(0x54, "<dev string:xfb>", team + "<dev string:x103>", "<dev string:x108>" + team + "<dev string:x11a>");
            // Unknown operator (0x54, t7_1b, PC)
        #/
        /#
            InvalidOpCode(0x54, "<dev string:xfb>", team + "<dev string:x130>", "<dev string:x108>" + team + "<dev string:x13b>");
            // Unknown operator (0x54, t7_1b, PC)
        #/
        /#
            InvalidOpCode(0x54, "<dev string:xfb>", team + "<dev string:x157>", "<dev string:x108>" + team + "<dev string:x16d>");
            // Unknown operator (0x54, t7_1b, PC)
        #/
        /#
            InvalidOpCode(0x54, "<dev string:xfb>", team + "<dev string:x194>", "<dev string:x108>" + team + "<dev string:x1a0>");
            // Unknown operator (0x54, t7_1b, PC)
        #/
        /#
            InvalidOpCode(0x54, "<dev string:xfb>", team + "<dev string:x1bd>", "<dev string:x108>" + team + "<dev string:x1c8>");
            // Unknown operator (0x54, t7_1b, PC)
        #/
        /#
            InvalidOpCode(0x54, "<dev string:xfb>", team + "<dev string:x1e4>", "<dev string:x108>" + team + "<dev string:x1ea>");
            // Unknown operator (0x54, t7_1b, PC)
        #/
        /#
            InvalidOpCode(0x54, "<dev string:x201>", "<dev string:x207>" + team, "<dev string:x20e>" + team + "<dev string:x224>");
            // Unknown operator (0x54, t7_1b, PC)
        #/
        /#
            InvalidOpCode(0x54, "<dev string:x201>", "<dev string:x236>" + team, "<dev string:x23f>" + team + "<dev string:x224>");
            // Unknown operator (0x54, t7_1b, PC)
        #/
        /#
            InvalidOpCode(0x54, "<dev string:x257>", team, "<dev string:x25d>" + team + "<dev string:x224>");
            // Unknown operator (0x54, t7_1b, PC)
        #/
        /#
            InvalidOpCode(0x54, "<dev string:x26d>", team, "<dev string:x273>" + team + "<dev string:x224>");
            // Unknown operator (0x54, t7_1b, PC)
        #/
    }
}

// Namespace globallogic
// Params 0, eflags: 0x0
// Checksum 0xed85985c, Offset: 0x9648
// Size: 0x62
function anyteamhaswavedelay() {
    foreach (team in level.teams) {
        if (level.wavedelay[team]) {
            return true;
        }
    }
    return false;
}

// Namespace globallogic
// Params 0, eflags: 0x0
// Checksum 0x7a5e588f, Offset: 0x96b8
// Size: 0x119
function callback_startgametype() {
    level.prematchperiod = 0;
    level.intermission = 0;
    setmatchflag("cg_drawSpectatorMessages", 1);
    setmatchflag("game_ended", 0);
    InvalidOpCode(0x54, "gamestarted");
    // Unknown operator (0x54, t7_1b, PC)
}

/#

    // Namespace globallogic
    // Params 0, eflags: 0x0
    // Checksum 0x5758e7f6, Offset: 0xaa70
    // Size: 0x3d
    function forcedebughostmigration() {
        while (true) {
            hostmigration::waittillhostmigrationdone();
            wait 60;
            starthostmigration();
            hostmigration::waittillhostmigrationdone();
        }
    }

#/

// Namespace globallogic
// Params 4, eflags: 0x0
// Checksum 0x8d09d18d, Offset: 0xaab8
// Size: 0xda
function registerfriendlyfiredelay(dvarstring, defaultvalue, minvalue, maxvalue) {
    dvarstring = "scr_" + dvarstring + "_friendlyFireDelayTime";
    if (getdvarstring(dvarstring) == "") {
        setdvar(dvarstring, defaultvalue);
    }
    if (getdvarint(dvarstring) > maxvalue) {
        setdvar(dvarstring, maxvalue);
    } else if (getdvarint(dvarstring) < minvalue) {
        setdvar(dvarstring, minvalue);
    }
    level.friendlyfiredelaytime = getdvarint(dvarstring);
}

// Namespace globallogic
// Params 0, eflags: 0x0
// Checksum 0xcfea7fa0, Offset: 0xaba0
// Size: 0x49
function checkroundswitch() {
    if (!isdefined(level.roundswitch) || !level.roundswitch) {
        return false;
    }
    if (!isdefined(level.onroundswitch)) {
        return false;
    }
    /#
        InvalidOpCode(0x54, "<dev string:x2ab>");
        // Unknown operator (0x54, t7_1b, PC)
    #/
    InvalidOpCode(0x54, "roundsplayed");
    // Unknown operator (0x54, t7_1b, PC)
}

// Namespace globallogic
// Params 0, eflags: 0x0
// Checksum 0xaa4131bc, Offset: 0xac10
// Size: 0x32
function listenforgameend() {
    self waittill(#"host_sucks_end_game");
    level.skipvote = 1;
    if (!level.gameended) {
        level thread forceend(1);
    }
}

// Namespace globallogic
// Params 1, eflags: 0x0
// Checksum 0x89da5384, Offset: 0xac50
// Size: 0xcf
function getkillstreaks(player) {
    for (killstreaknum = 0; killstreaknum < level.maxkillstreaks; killstreaknum++) {
        killstreak[killstreaknum] = "killstreak_null";
    }
    if (!isdefined(player.pers["isBot"]) && isplayer(player) && level.disableclassselection != 1 && isdefined(player.killstreak)) {
        currentkillstreak = 0;
        for (killstreaknum = 0; killstreaknum < level.maxkillstreaks; killstreaknum++) {
            if (isdefined(player.killstreak[killstreaknum])) {
                killstreak[currentkillstreak] = player.killstreak[killstreaknum];
                currentkillstreak++;
            }
        }
    }
    return killstreak;
}

// Namespace globallogic
// Params 1, eflags: 0x0
// Checksum 0x7ca0f83b, Offset: 0xad28
// Size: 0x6a
function updaterankedmatch(winner) {
    if (level.rankedmatch) {
        if (hostidledout()) {
            level.hostforcedend = 1;
            /#
                print("<dev string:x2b8>");
            #/
            endlobby();
        }
    }
    globallogic_score::updatematchbonusscores(winner);
}

// Namespace globallogic
// Params 2, eflags: 0x0
// Checksum 0x5a9c4958, Offset: 0xada0
// Size: 0xe2
function annihilatorgunplayerkilleffect(attacker, weapon) {
    if (weapon.fusetime != 0) {
        wait weapon.fusetime * 0.001;
    } else {
        wait 0.45;
    }
    if (!isdefined(self)) {
        return;
    }
    self playsoundtoplayer("evt_annihilation", attacker);
    self playsoundtoallbutplayer("evt_annihilation_npc", attacker);
    codesetclientfield(self, "annihilate_effect", 1);
    self shake_and_rumble(0, 0.3, 0.75, 1);
    wait 0.1;
    if (!isdefined(self)) {
        return;
    }
    self notsolid();
    self ghost();
}

// Namespace globallogic
// Params 2, eflags: 0x0
// Checksum 0x56ee12ce, Offset: 0xae90
// Size: 0xf2
function annihilatorgunactorkilleffect(attacker, weapon) {
    self waittill(#"actor_corpse", body);
    if (weapon.fusetime != 0) {
        wait weapon.fusetime * 0.001;
    } else {
        wait 0.45;
    }
    if (!isdefined(self)) {
        return;
    }
    self playsoundtoplayer("evt_annihilation", attacker);
    self playsoundtoallbutplayer("evt_annihilation_npc", attacker);
    if (!isdefined(body)) {
        return;
    }
    codesetclientfield(body, "annihilate_effect", 1);
    body shake_and_rumble(0, 0.6, 0.2, 1);
    body notsolid();
    body ghost();
}

// Namespace globallogic
// Params 1, eflags: 0x0
// Checksum 0x7dc79d08, Offset: 0xaf90
// Size: 0xa2
function pineapplegunplayerkilleffect(attacker) {
    wait 0.1;
    if (!isdefined(self)) {
        return;
    }
    playsoundatposition("evt_annihilation_npc", self.origin);
    codesetclientfield(self, "pineapplegun_effect", 1);
    self shake_and_rumble(0, 0.3, 0.35, 1);
    wait 0.1;
    if (!isdefined(self)) {
        return;
    }
    self notsolid();
    self ghost();
}

// Namespace globallogic
// Params 0, eflags: 0x0
// Checksum 0x37261476, Offset: 0xb040
// Size: 0x92
function bowplayerkilleffect() {
    wait 0.05;
    if (!isdefined(self)) {
        return;
    }
    playsoundatposition("evt_annihilation_npc", self.origin);
    codesetclientfield(self, "annihilate_effect", 1);
    self shake_and_rumble(0, 0.3, 0.35, 1);
    if (!isdefined(self)) {
        return;
    }
    self notsolid();
    self ghost();
}

// Namespace globallogic
// Params 0, eflags: 0x0
// Checksum 0xb0eb90ad, Offset: 0xb0e0
// Size: 0xaa
function pineapplegunactorkilleffect() {
    self waittill(#"actor_corpse", body);
    wait 0.75;
    if (!isdefined(self)) {
        return;
    }
    playsoundatposition("evt_annihilation_npc", self.origin);
    if (!isdefined(body)) {
        return;
    }
    codesetclientfield(body, "pineapplegun_effect", 1);
    body shake_and_rumble(0, 0.3, 0.75, 1);
    body notsolid();
    body ghost();
}

// Namespace globallogic
// Params 4, eflags: 0x0
// Checksum 0x1df3011b, Offset: 0xb198
// Size: 0xb9
function shake_and_rumble(n_delay, shake_size, shake_time, rumble_num) {
    if (isdefined(n_delay) && n_delay > 0) {
        wait n_delay;
    }
    nmagnitude = shake_size;
    nduration = shake_time;
    nradius = 500;
    v_pos = self.origin;
    earthquake(nmagnitude, nduration, v_pos, nradius);
    for (i = 0; i < rumble_num; i++) {
        self playrumbleonentity("damage_heavy");
        wait 0.1;
    }
}

// Namespace globallogic
// Params 8, eflags: 0x0
// Checksum 0x2c1b0108, Offset: 0xb260
// Size: 0x92
function doweaponspecifickilleffects(einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime) {
    if (weapon.name == "hero_pineapplegun" && isplayer(attacker) && smeansofdeath == "MOD_GRENADE") {
        attacker playlocalsound("wpn_pineapple_grenade_explode_flesh_2D");
    }
}

// Namespace globallogic
// Params 9, eflags: 0x0
// Checksum 0x1bf3f9bb, Offset: 0xb300
// Size: 0x182
function doweaponspecificcorpseeffects(body, einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime) {
    if (smeansofdeath == "MOD_IMPACT" || weapon.doannihilate && isplayer(attacker) && smeansofdeath == "MOD_GRENADE") {
        if (isactor(body)) {
            body thread annihilatorgunactorkilleffect(attacker, weapon);
        } else {
            body thread annihilatorgunplayerkilleffect(attacker, weapon);
        }
        return;
    }
    if (smeansofdeath == "MOD_BURNED") {
        if (!isactor(body)) {
            body thread burncorpse();
        }
        return;
    }
    if (weapon.isheroweapon == 1 && isplayer(attacker)) {
        if (weapon.name == "hero_firefly_swarm") {
            value = randomint(2) + 1;
            if (!isactor(body)) {
                codesetclientfield(body, "firefly_effect", value);
            }
        }
    }
}

// Namespace globallogic
// Params 0, eflags: 0x0
// Checksum 0x9c4d1059, Offset: 0xb490
// Size: 0x3a
function burncorpse() {
    self endon(#"death");
    codesetclientfield(self, "burned_effect", 1);
    wait 3;
    codesetclientfield(self, "burned_effect", 0);
}

