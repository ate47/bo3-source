#using scripts/mp/_challenges;
#using scripts/mp/_util;
#using scripts/mp/gametypes/_globallogic;
#using scripts/mp/gametypes/_globallogic_audio;
#using scripts/mp/gametypes/_globallogic_defaults;
#using scripts/mp/gametypes/_globallogic_score;
#using scripts/mp/gametypes/_globallogic_utils;
#using scripts/mp/gametypes/_spawning;
#using scripts/mp/gametypes/_spawnlogic;
#using scripts/mp/teams/_teams;
#using scripts/shared/callbacks_shared;
#using scripts/shared/demo_shared;
#using scripts/shared/gameobjects_shared;
#using scripts/shared/hud_util_shared;
#using scripts/shared/math_shared;
#using scripts/shared/medals_shared;
#using scripts/shared/objpoints_shared;
#using scripts/shared/popups_shared;
#using scripts/shared/scoreevents_shared;
#using scripts/shared/util_shared;

#namespace res;

// Namespace res
// Params 0, eflags: 0x0
// Checksum 0xb39f8c9c, Offset: 0x988
// Size: 0x294
function main() {
    globallogic::init();
    util::registerroundswitch(0, 9);
    util::registertimelimit(0, 2.5);
    util::registerscorelimit(0, 1000);
    util::registerroundlimit(0, 10);
    util::registerroundwinlimit(0, 10);
    util::registernumlives(0, 100);
    globallogic::registerfriendlyfiredelay(level.gametype, 15, 0, 1440);
    level.teambased = 1;
    level.overrideteamscore = 1;
    level.onstartgametype = &onstartgametype;
    level.onroundswitch = &onroundswitch;
    level.onplayerkilled = &onplayerkilled;
    level.onprecachegametype = &onprecachegametype;
    level.onendgame = &onendgame;
    level.onroundendgame = &onroundendgame;
    level.ontimelimit = &ontimelimit;
    level.gettimelimit = &gettimelimit;
    gameobjects::register_allowed_gameobject(level.gametype);
    game["dialog"]["gametype"] = "res_start";
    game["dialog"]["gametype_hardcore"] = "hcres_start";
    game["dialog"]["offense_obj"] = "cap_start";
    game["dialog"]["defense_obj"] = "defend_start";
    level.var_c2a60b96 = 0;
    level.iconoffset = (0, 0, 100);
    globallogic::setvisiblescoreboardcolumns("score", "kills", "deaths", "captures", "defends");
}

// Namespace res
// Params 0, eflags: 0x0
// Checksum 0x99ec1590, Offset: 0xc28
// Size: 0x4
function onprecachegametype() {
    
}

// Namespace res
// Params 0, eflags: 0x0
// Checksum 0x65ab3ad2, Offset: 0xc38
// Size: 0x10c
function onroundswitch() {
    if (!isdefined(game["switchedsides"])) {
        game["switchedsides"] = 0;
    }
    if (game["teamScores"]["allies"] == level.scorelimit - 1 && game["teamScores"]["axis"] == level.scorelimit - 1) {
        aheadteam = getbetterteam();
        if (aheadteam != game["defenders"]) {
            game["switchedsides"] = !game["switchedsides"];
        } else {
            level.halftimesubcaption = "";
        }
        level.halftimetype = "overtime";
        return;
    }
    level.halftimetype = "halftime";
    game["switchedsides"] = !game["switchedsides"];
}

// Namespace res
// Params 0, eflags: 0x0
// Checksum 0xe29e2e7b, Offset: 0xd50
// Size: 0x20a
function getbetterteam() {
    kills["allies"] = 0;
    kills["axis"] = 0;
    deaths["allies"] = 0;
    deaths["axis"] = 0;
    for (i = 0; i < level.players.size; i++) {
        player = level.players[i];
        team = player.pers["team"];
        if (team == "allies" || isdefined(team) && team == "axis") {
            kills[team] = kills[team] + player.kills;
            deaths[team] = deaths[team] + player.deaths;
        }
    }
    if (kills["allies"] > kills["axis"]) {
        return "allies";
    } else if (kills["axis"] > kills["allies"]) {
        return "axis";
    }
    if (deaths["allies"] < deaths["axis"]) {
        return "allies";
    } else if (deaths["axis"] < deaths["allies"]) {
        return "axis";
    }
    if (randomint(2) == 0) {
        return "allies";
    }
    return "axis";
}

// Namespace res
// Params 0, eflags: 0x0
// Checksum 0xc19d1332, Offset: 0xf68
// Size: 0x684
function onstartgametype() {
    if (!isdefined(game["switchedsides"])) {
        game["switchedsides"] = 0;
    }
    if (game["switchedsides"]) {
        oldattackers = game["attackers"];
        olddefenders = game["defenders"];
        game["attackers"] = olddefenders;
        game["defenders"] = oldattackers;
    }
    level.usingextratime = 0;
    game["strings"]["flags_capped"] = %MP_TARGET_DESTROYED;
    util::setobjectivetext(game["attackers"], %OBJECTIVES_RES_ATTACKER);
    util::setobjectivetext(game["defenders"], %OBJECTIVES_RES_DEFENDER);
    if (level.splitscreen) {
        util::setobjectivescoretext(game["attackers"], %OBJECTIVES_RES_ATTACKER);
        util::setobjectivescoretext(game["defenders"], %OBJECTIVES_RES_DEFENDER);
    } else {
        util::setobjectivescoretext(game["attackers"], %OBJECTIVES_RES_ATTACKER_SCORE);
        util::setobjectivescoretext(game["defenders"], %OBJECTIVES_RES_DEFENDER_SCORE);
    }
    util::setobjectivehinttext(game["attackers"], %OBJECTIVES_RES_ATTACKER_HINT);
    util::setobjectivehinttext(game["defenders"], %OBJECTIVES_RES_DEFENDER_HINT);
    level.var_11f436f7 = %MP_CONTROL_HQ;
    level.var_840f75d4 = %MP_CAPTURE_HQ;
    level.objectivehintdefendhq = %MP_DEFEND_HQ;
    level.flagbasefxid = [];
    level.flagbasefxid["allies"] = "_t6/misc/fx_ui_flagbase_" + game["allies"];
    level.flagbasefxid["axis"] = "_t6/misc/fx_ui_flagbase_" + game["axis"];
    setclientnamemode("auto_change");
    spawning::create_map_placed_influencers();
    level.spawnmins = (0, 0, 0);
    level.spawnmaxs = (0, 0, 0);
    spawnlogic::place_spawn_points("mp_res_spawn_allies_start");
    spawnlogic::place_spawn_points("mp_res_spawn_axis_start");
    spawnlogic::add_spawn_points("allies", "mp_res_spawn_allies");
    spawnlogic::add_spawn_points("axis", "mp_res_spawn_axis");
    spawnlogic::add_spawn_points("axis", "mp_res_spawn_axis_a");
    spawnlogic::drop_spawn_points("mp_res_spawn_allies_a");
    spawning::updateallspawnpoints();
    level.mapcenter = math::find_box_center(level.spawnmins, level.spawnmaxs);
    setmapcenter(level.mapcenter);
    spawnpoint = spawnlogic::get_random_intermission_point();
    setdemointermissionpoint(spawnpoint.origin, spawnpoint.angles);
    level.spawn_start = [];
    foreach (team in level.teams) {
        level.spawn_start[team] = spawnlogic::get_spawnpoint_array("mp_res_spawn_" + team + "_start");
    }
    function_454612db();
    updategametypedvars();
    thread function_e9503286();
    thread function_361b0234();
    level.overtime = 0;
    overtime = 0;
    if (game["teamScores"]["allies"] == level.scorelimit - 1 && game["teamScores"]["axis"] == level.scorelimit - 1) {
        overtime = 1;
    }
    if (overtime) {
        spawnlogic::clear_spawn_points();
    }
    spawnlogic::add_spawn_points("allies", "mp_res_spawn_allies_a");
    spawnlogic::add_spawn_points("axis", "mp_res_spawn_axis");
    spawning::updateallspawnpoints();
    if (overtime) {
        function_d2ea5c61(int(level.var_2b613fd2.size / 3));
    } else {
        function_d2ea5c61(0);
    }
    level.overtime = overtime;
    if (level.var_d311af1) {
        updateobjectivehintmessages(level.var_11f436f7, level.var_11f436f7);
        return;
    }
    updateobjectivehintmessages(level.var_840f75d4, level.var_840f75d4);
}

// Namespace res
// Params 1, eflags: 0x0
// Checksum 0xffe94db4, Offset: 0x15f8
// Size: 0x5e
function onendgame(winningteam) {
    for (i = 0; i < level.var_2b613fd2.size; i++) {
        level.var_2b613fd2[i] gameobjects::allow_use("none");
    }
}

// Namespace res
// Params 1, eflags: 0x0
// Checksum 0x2604aa9f, Offset: 0x1660
// Size: 0x34
function onroundendgame(roundwinner) {
    winner = globallogic::determineteamwinnerbygamestat("roundswon");
    return winner;
}

// Namespace res
// Params 2, eflags: 0x0
// Checksum 0xce18c6b8, Offset: 0x16a0
// Size: 0x64
function function_e9c2ac15(winningteam, endreasontext) {
    if (isdefined(winningteam) && winningteam != "tie") {
        globallogic_score::giveteamscoreforobjective(winningteam, 1);
    }
    thread globallogic::endgame(winningteam, endreasontext);
}

// Namespace res
// Params 0, eflags: 0x0
// Checksum 0xeb2d9948, Offset: 0x1710
// Size: 0xb4
function ontimelimit() {
    if (level.overtime) {
        if (isdefined(level.var_28e4e3eb)) {
            function_e9c2ac15(level.var_28e4e3eb, game["strings"]["time_limit_reached"]);
        } else {
            function_e9c2ac15("tie", game["strings"]["time_limit_reached"]);
        }
        return;
    }
    function_e9c2ac15(game["defenders"], game["strings"]["time_limit_reached"]);
}

// Namespace res
// Params 0, eflags: 0x0
// Checksum 0x801ca362, Offset: 0x17d0
// Size: 0x7c
function gettimelimit() {
    timelimit = globallogic_defaults::default_gettimelimit();
    if (level.usingextratime) {
        var_93185b38 = 0;
        if (isdefined(level.currentflag)) {
            var_93185b38 += level.currentflag.orderindex;
        }
        return (timelimit + level.extratime * var_93185b38);
    }
    return timelimit;
}

// Namespace res
// Params 0, eflags: 0x0
// Checksum 0x394ebd34, Offset: 0x1858
// Size: 0x124
function updategametypedvars() {
    level.flagcapturetime = getgametypesetting("captureTime");
    level.flagDecayTime = getgametypesetting("flagDecayTime");
    level.var_d311af1 = getgametypesetting("objectiveSpawnTime");
    level.var_6aae7bde = getgametypesetting("idleFlagResetTime");
    level.var_5fe77e56 = getgametypesetting("idleFlagDecay");
    level.extratime = getgametypesetting("extraTime");
    level.flagCaptureGracePeriod = getgametypesetting("flagCaptureGracePeriod");
    level.playeroffensivemax = getgametypesetting("maxPlayerOffensive");
    level.playerdefensivemax = getgametypesetting("maxPlayerDefensive");
}

// Namespace res
// Params 0, eflags: 0x0
// Checksum 0x7393574e, Offset: 0x1988
// Size: 0x66e
function function_361b0234() {
    level.laststatus["allies"] = 0;
    level.laststatus["axis"] = 0;
    level.flagmodel["allies"] = teams::get_flag_model("allies");
    level.flagmodel["axis"] = teams::get_flag_model("axis");
    level.flagmodel["neutral"] = teams::get_flag_model("neutral");
    primaryflags = getentarray("res_flag_primary", "targetname");
    if (primaryflags.size < 2) {
        println("<dev string:x28>");
        callback::abort_level();
        return;
    }
    level.flags = [];
    for (index = 0; index < primaryflags.size; index++) {
        level.flags[level.flags.size] = primaryflags[index];
    }
    level.var_2b613fd2 = [];
    for (index = 0; index < level.flags.size; index++) {
        trigger = level.flags[index];
        if (isdefined(trigger.target)) {
            visuals[0] = getent(trigger.target, "targetname");
        } else {
            visuals[0] = spawn("script_model", trigger.origin);
            visuals[0].angles = trigger.angles;
        }
        visuals[0] setmodel(level.flagmodel[game["defenders"]]);
        var_e5ce1ae3 = gameobjects::create_use_object(game["defenders"], trigger, visuals, level.iconoffset);
        var_e5ce1ae3 gameobjects::allow_use("none");
        var_e5ce1ae3 gameobjects::set_use_time(level.flagcapturetime);
        var_e5ce1ae3 gameobjects::set_use_text(%MP_CAPTURING_FLAG);
        var_e5ce1ae3 gameobjects::set_decay_time(level.flagDecayTime);
        label = var_e5ce1ae3 gameobjects::get_label();
        var_e5ce1ae3.label = label;
        var_e5ce1ae3 gameobjects::set_model_visibility(0);
        var_e5ce1ae3.onuse = &onuse;
        var_e5ce1ae3.onbeginuse = &onbeginuse;
        var_e5ce1ae3.onuseupdate = &onuseupdate;
        var_e5ce1ae3.onuseclear = &onuseclear;
        var_e5ce1ae3.onenduse = &onenduse;
        var_e5ce1ae3.claimgraceperiod = level.flagCaptureGracePeriod;
        var_e5ce1ae3.decayprogress = level.var_5fe77e56;
        tracestart = visuals[0].origin + (0, 0, 32);
        traceend = visuals[0].origin + (0, 0, -32);
        trace = bullettrace(tracestart, traceend, 0, undefined);
        upangles = vectortoangles(trace["normal"]);
        var_e5ce1ae3.baseeffectforward = anglestoforward(upangles);
        var_e5ce1ae3.baseeffectright = anglestoright(upangles);
        var_e5ce1ae3.baseeffectpos = trace["position"];
        level.flags[index].useobj = var_e5ce1ae3;
        level.flags[index].nearbyspawns = [];
        var_e5ce1ae3.levelflag = level.flags[index];
        level.var_2b613fd2[level.var_2b613fd2.size] = var_e5ce1ae3;
    }
    function_8449229a();
    level.bestspawnflag = [];
    level.bestspawnflag["allies"] = getunownedflagneareststart("allies", undefined);
    level.bestspawnflag["axis"] = getunownedflagneareststart("axis", level.bestspawnflag["allies"]);
    for (index = 0; index < level.var_2b613fd2.size; index++) {
        level.var_2b613fd2[index] createflagspawninfluencers();
    }
}

// Namespace res
// Params 0, eflags: 0x0
// Checksum 0x7541c0c2, Offset: 0x2000
// Size: 0x1ea
function function_8449229a() {
    var_5b871639["_a"] = 0;
    var_5b871639["_b"] = 1;
    var_5b871639["_c"] = 2;
    var_5b871639["_d"] = 3;
    var_5b871639["_e"] = 4;
    for (i = 0; i < level.var_2b613fd2.size; i++) {
        level.var_2b613fd2[i].orderindex = var_5b871639[level.var_2b613fd2[i].label];
        assert(isdefined(level.var_2b613fd2[i].orderindex));
    }
    for (i = 1; i < level.var_2b613fd2.size; i++) {
        for (j = 0; j < level.var_2b613fd2.size - i; j++) {
            if (level.var_2b613fd2[j].orderindex > level.var_2b613fd2[j + 1].orderindex) {
                temp = level.var_2b613fd2[j];
                level.var_2b613fd2[j] = level.var_2b613fd2[j + 1];
                level.var_2b613fd2[j + 1] = temp;
            }
        }
    }
}

// Namespace res
// Params 1, eflags: 0x0
// Checksum 0x60aa1357, Offset: 0x21f8
// Size: 0xa4
function function_d2ea5c61(flagindex) {
    var_c17aebb0 = flagindex - 1;
    if (var_c17aebb0 >= 0) {
        thread function_e8347813(var_c17aebb0);
    }
    if (flagindex < level.var_2b613fd2.size && !level.overtime) {
        thread function_68125934(flagindex);
        return;
    }
    globallogic_utils::resumetimer();
    function_b2a0e7a3();
}

// Namespace res
// Params 0, eflags: 0x0
// Checksum 0x980cc4ae, Offset: 0x22a8
// Size: 0x274
function function_e9503286() {
    var_c7d5d8ae = %MP_HQ_AVAILABLE_IN;
    level.var_279d8218 = gameobjects::get_next_obj_id();
    level.timerdisplay = [];
    level.timerdisplay["allies"] = hud::createservertimer("objective", 1.4, "allies");
    level.timerdisplay["allies"] hud::setpoint("TOPCENTER", "TOPCENTER", 0, 0);
    level.timerdisplay["allies"].label = var_c7d5d8ae;
    level.timerdisplay["allies"].alpha = 0;
    level.timerdisplay["allies"].archived = 0;
    level.timerdisplay["allies"].hidewheninmenu = 1;
    level.timerdisplay["axis"] = hud::createservertimer("objective", 1.4, "axis");
    level.timerdisplay["axis"] hud::setpoint("TOPCENTER", "TOPCENTER", 0, 0);
    level.timerdisplay["axis"].label = var_c7d5d8ae;
    level.timerdisplay["axis"].alpha = 0;
    level.timerdisplay["axis"].archived = 0;
    level.timerdisplay["axis"].hidewheninmenu = 1;
    thread hidetimerdisplayongameend(level.timerdisplay["allies"]);
    thread hidetimerdisplayongameend(level.timerdisplay["axis"]);
}

// Namespace res
// Params 1, eflags: 0x0
// Checksum 0xf868b4fc, Offset: 0x2528
// Size: 0x28
function hidetimerdisplayongameend(timerdisplay) {
    level waittill(#"game_ended");
    timerdisplay.alpha = 0;
}

// Namespace res
// Params 1, eflags: 0x0
// Checksum 0xb8d74c09, Offset: 0x2558
// Size: 0x4dc
function function_68125934(flagindex) {
    assert(flagindex < level.var_2b613fd2.size);
    var_e5ce1ae3 = level.var_2b613fd2[flagindex];
    label = var_e5ce1ae3.label;
    var_e5ce1ae3 gameobjects::set_visible_team("any");
    var_e5ce1ae3 gameobjects::set_model_visibility(1);
    level.currentflag = var_e5ce1ae3;
    if (level.var_d311af1) {
        function_b2a0e7a3();
        if (level.prematchperiod > 0 && level.inprematchperiod == 1) {
            level waittill(#"prematch_over");
        }
        var_95ea7549 = objpoints::create("objpoint_next_hq", var_e5ce1ae3.curorigin + level.iconoffset, "all", "waypoint_targetneutral");
        var_95ea7549 setwaypoint(1, "waypoint_targetneutral");
        objective_position(level.var_279d8218, var_e5ce1ae3.curorigin);
        objective_icon(level.var_279d8218, "waypoint_targetneutral");
        objective_state(level.var_279d8218, "active");
        updateobjectivehintmessages(level.var_11f436f7, level.objectivehintdefendhq);
        var_c7d5d8ae = %MP_HQ_AVAILABLE_IN;
        level.timerdisplay["allies"].label = var_c7d5d8ae;
        level.timerdisplay["allies"] settimer(level.var_d311af1);
        level.timerdisplay["allies"].alpha = 1;
        level.timerdisplay["axis"].label = var_c7d5d8ae;
        level.timerdisplay["axis"] settimer(level.var_d311af1);
        level.timerdisplay["axis"].alpha = 1;
        wait level.var_d311af1;
        objpoints::delete(var_95ea7549);
        objective_state(level.var_279d8218, "invisible");
        globallogic_audio::leader_dialog("hq_online");
        function_b41552b6();
    }
    level.timerdisplay["allies"].alpha = 0;
    level.timerdisplay["axis"].alpha = 0;
    var_e5ce1ae3 gameobjects::set_2d_icon("friendly", "compass_waypoint_defend" + label);
    var_e5ce1ae3 gameobjects::set_3d_icon("friendly", "waypoint_defend" + label);
    var_e5ce1ae3 gameobjects::set_2d_icon("enemy", "compass_waypoint_capture" + label);
    var_e5ce1ae3 gameobjects::set_3d_icon("enemy", "waypoint_capture" + label);
    if (level.overtime) {
        var_e5ce1ae3 gameobjects::allow_use("enemy");
        var_e5ce1ae3 gameobjects::set_visible_team("any");
        var_e5ce1ae3 gameobjects::set_owner_team("neutral");
        var_e5ce1ae3 gameobjects::set_decay_time(level.flagcapturetime);
    } else {
        var_e5ce1ae3 gameobjects::allow_use("enemy");
    }
    var_e5ce1ae3 function_b7ddf8ec();
}

// Namespace res
// Params 1, eflags: 0x0
// Checksum 0x15a96523, Offset: 0x2a40
// Size: 0xa4
function function_e8347813(flagindex) {
    assert(flagindex < level.var_2b613fd2.size);
    var_e5ce1ae3 = level.var_2b613fd2[flagindex];
    var_e5ce1ae3 gameobjects::allow_use("none");
    var_e5ce1ae3 gameobjects::set_visible_team("none");
    var_e5ce1ae3 gameobjects::set_model_visibility(0);
}

// Namespace res
// Params 2, eflags: 0x0
// Checksum 0x14418355, Offset: 0x2af0
// Size: 0x12e
function getunownedflagneareststart(team, excludeflag) {
    best = undefined;
    bestdistsq = undefined;
    for (i = 0; i < level.flags.size; i++) {
        flag = level.flags[i];
        if (flag getflagteam() != "neutral") {
            continue;
        }
        distsq = distancesquared(flag.origin, level.startpos[team]);
        if (!isdefined(best) || (!isdefined(excludeflag) || flag != excludeflag) && distsq < bestdistsq) {
            bestdistsq = distsq;
            best = flag;
        }
    }
    return best;
}

// Namespace res
// Params 1, eflags: 0x0
// Checksum 0x574fe7aa, Offset: 0x2c28
// Size: 0x1cc
function onbeginuse(player) {
    ownerteam = self gameobjects::get_owner_team();
    setdvar("scr_obj" + self gameobjects::get_label() + "_flash", 1);
    self.didstatusnotify = 0;
    if (ownerteam == "allies") {
        otherteam = "axis";
    } else {
        otherteam = "allies";
    }
    if (ownerteam == "neutral") {
        if (gettime() - level.var_c2a60b96 > 5000) {
            otherteam = util::getotherteam(player.pers["team"]);
            statusdialog("securing" + self.label, player.pers["team"]);
            level.var_c2a60b96 = gettime();
        }
        self.objpoints[player.pers["team"]] thread objpoints::function_3ae8114();
        return;
    }
    self.objpoints["allies"] thread objpoints::function_3ae8114();
    self.objpoints["axis"] thread objpoints::function_3ae8114();
}

// Namespace res
// Params 3, eflags: 0x0
// Checksum 0xb2290e39, Offset: 0x2e00
// Size: 0x174
function onuseupdate(team, progress, change) {
    if (!isdefined(level.var_e026b50)) {
        level.var_e026b50 = progress;
    }
    if (progress > 0.05 && change && !self.didstatusnotify) {
        ownerteam = self gameobjects::get_owner_team();
        if (gettime() - level.var_c2a60b96 > 10000) {
            statusdialog("losing" + self.label, ownerteam);
            statusdialog("securing" + self.label, team);
            level.var_c2a60b96 = gettime();
        }
        self.didstatusnotify = 1;
    }
    if (level.var_e026b50 < progress) {
        globallogic_utils::pausetimer();
        setgameendtime(0);
        level.var_28e4e3eb = team;
    } else {
        globallogic_utils::resumetimer();
    }
    level.var_e026b50 = progress;
    function_895e5681(progress, team);
}

// Namespace res
// Params 0, eflags: 0x0
// Checksum 0xae54133f, Offset: 0x2f80
// Size: 0x2c
function onuseclear() {
    globallogic_utils::resumetimer();
    function_895e5681(0);
}

// Namespace res
// Params 2, eflags: 0x0
// Checksum 0x3c59c3be, Offset: 0x2fb8
// Size: 0x6e
function statusdialog(dialog, team) {
    time = gettime();
    if (gettime() < level.laststatus[team] + 6000) {
        return;
    }
    thread delayedleaderdialog(dialog, team);
    level.laststatus[team] = gettime();
}

// Namespace res
// Params 3, eflags: 0x0
// Checksum 0x4df20ec4, Offset: 0x3030
// Size: 0xa4
function onenduse(team, player, success) {
    setdvar("scr_obj" + self gameobjects::get_label() + "_flash", 0);
    self.objpoints["allies"] thread objpoints::function_a51dc9ba();
    self.objpoints["axis"] thread objpoints::function_a51dc9ba();
}

// Namespace res
// Params 0, eflags: 0x0
// Checksum 0xba315371, Offset: 0x30e0
// Size: 0xbc
function function_b7ddf8ec() {
    if (isdefined(self.baseeffect)) {
        return;
    }
    team = self gameobjects::get_owner_team();
    if (team != "axis" && team != "allies") {
        return;
    }
    fxid = level.flagbasefxid[team];
    self.baseeffect = spawnfx(fxid, self.baseeffectpos, self.baseeffectforward, self.baseeffectright);
    triggerfx(self.baseeffect);
}

// Namespace res
// Params 2, eflags: 0x0
// Checksum 0x7581182, Offset: 0x31a8
// Size: 0x5c4
function onuse(player, team) {
    team = player.pers["team"];
    oldteam = self gameobjects::get_owner_team();
    label = self gameobjects::get_label();
    /#
        print("<dev string:x56>" + self.label);
    #/
    function_d2ea5c61(self.orderindex + 1);
    if (self.orderindex + 1 == level.var_2b613fd2.size || level.overtime) {
        setgameendtime(0);
        wait 1;
        function_e9c2ac15(player.team, game["strings"]["flags_capped"]);
        return;
    }
    level.usestartspawns = 0;
    assert(team != "<dev string:x66>");
    if ([[ level.gettimelimit ]]() > 0 && level.extratime) {
        level.usingextratime = 1;
        if (!level.hardcoremode) {
            iprintln(%MP_TIME_EXTENDED);
        }
    }
    spawnlogic::clear_spawn_points();
    spawnlogic::add_spawn_points("allies", "mp_res_spawn_allies");
    spawnlogic::add_spawn_points("axis", "mp_res_spawn_axis");
    if (label == "_a") {
        spawnlogic::clear_spawn_points();
        spawnlogic::add_spawn_points("allies", "mp_res_spawn_allies_a");
        spawnlogic::add_spawn_points("axis", "mp_res_spawn_axis");
    } else if (label == "_b") {
        spawnlogic::add_spawn_points(game["attackers"], "mp_res_spawn_allies_b");
        spawnlogic::add_spawn_points(game["defenders"], "mp_res_spawn_axis");
    } else {
        spawnlogic::add_spawn_points("allies", "mp_res_spawn_allies_c");
        spawnlogic::add_spawn_points("allies", "mp_res_spawn_axis");
    }
    spawning::updateallspawnpoints();
    string = %;
    switch (label) {
    case "_a":
        string = %MP_DOM_FLAG_A_CAPTURED_BY;
        break;
    case "_b":
        string = %MP_DOM_FLAG_B_CAPTURED_BY;
        break;
    case "_c":
        string = %MP_DOM_FLAG_C_CAPTURED_BY;
        break;
    case "_d":
        string = %MP_DOM_FLAG_D_CAPTURED_BY;
        break;
    case "_e":
        string = %MP_DOM_FLAG_E_CAPTURED_BY;
        break;
    default:
        break;
    }
    assert(string != %"<dev string:x6e>");
    touchlist = [];
    touchkeys = getarraykeys(self.touchlist[team]);
    for (i = 0; i < touchkeys.size; i++) {
        touchlist[touchkeys[i]] = self.touchlist[team][touchkeys[i]];
    }
    thread give_capture_credit(touchlist, string);
    thread util::printandsoundoneveryone(team, oldteam, %, %, "mp_war_objective_taken", "mp_war_objective_lost", "");
    if (getteamflagcount(team) == level.flags.size) {
        statusdialog("secure_all", team);
        statusdialog("lost_all", oldteam);
    } else {
        statusdialog("secured" + self.label, team);
        statusdialog("lost" + self.label, oldteam);
    }
    level.bestspawnflag[oldteam] = self.levelflag;
    self update_spawn_influencers(team);
}

// Namespace res
// Params 2, eflags: 0x0
// Checksum 0xd4bf53f0, Offset: 0x3778
// Size: 0x176
function give_capture_credit(touchlist, string) {
    wait 0.05;
    util::waittillslowprocessallowed();
    players = getarraykeys(touchlist);
    for (i = 0; i < players.size; i++) {
        player_from_touchlist = touchlist[players[i]].player;
        player_from_touchlist recordgameevent("capture");
        if (isdefined(player_from_touchlist.pers["captures"])) {
            player_from_touchlist.pers["captures"]++;
            player_from_touchlist.captures = player_from_touchlist.pers["captures"];
        }
        demo::bookmark("event", gettime(), player_from_touchlist);
        player_from_touchlist addplayerstatwithgametype("CAPTURES", 1);
        level thread popups::displayteammessagetoall(string, player_from_touchlist);
    }
}

// Namespace res
// Params 2, eflags: 0x0
// Checksum 0x3f1c2ba6, Offset: 0x38f8
// Size: 0x44
function delayedleaderdialog(sound, team) {
    wait 0.1;
    util::waittillslowprocessallowed();
    globallogic_audio::leader_dialog(sound, team);
}

// Namespace res
// Params 0, eflags: 0x0
// Checksum 0x9e2ae65d, Offset: 0x3948
// Size: 0x292
function onscoreclosemusic() {
    axisscore = [[ level._getteamscore ]]("axis");
    alliedscore = [[ level._getteamscore ]]("allies");
    scorelimit = level.scorelimit;
    scorethreshold = scorelimit * 0.1;
    scoredif = abs(axisscore - alliedscore);
    scorethresholdstart = abs(scorelimit - scorethreshold);
    scorelimitcheck = scorelimit - 10;
    if (!isdefined(level.playingactionmusic)) {
        level.playingactionmusic = 0;
    }
    if (alliedscore > axisscore) {
        currentscore = alliedscore;
    } else {
        currentscore = axisscore;
    }
    if (getdvarint("debug_music") > 0) {
        /#
            println("<dev string:x6f>" + scoredif);
            println("<dev string:x93>" + axisscore);
            println("<dev string:xb8>" + alliedscore);
            println("<dev string:xdf>" + scorelimit);
            println("<dev string:x105>" + currentscore);
            println("<dev string:x12d>" + scorethreshold);
            println("<dev string:x6f>" + scoredif);
            println("<dev string:x157>" + scorethresholdstart);
        #/
    }
    if (scoredif <= scorethreshold && scorethresholdstart <= currentscore && level.playingactionmusic != 1) {
        thread globallogic_audio::set_music_on_team("timeOut");
        return;
    }
    return;
}

// Namespace res
// Params 9, eflags: 0x0
// Checksum 0xa3a7f56a, Offset: 0x3be8
// Size: 0x314
function onplayerkilled(einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime, deathanimduration) {
    if (self.touchtriggers.size && isplayer(attacker) && attacker.pers["team"] != self.pers["team"]) {
        triggerids = getarraykeys(self.touchtriggers);
        ownerteam = self.touchtriggers[triggerids[0]].useobj.ownerteam;
        team = self.pers["team"];
        if (team == ownerteam) {
            if (!isdefined(attacker.var_3dcc50b1)) {
                attacker.var_3dcc50b1 = 0;
            }
            attacker.var_3dcc50b1++;
            if (level.playeroffensivemax >= attacker.var_3dcc50b1) {
                attacker medals::offenseglobalcount();
                attacker thread challenges::killedbaseoffender(self.touchtriggers[triggerids[0]], weapon);
                scoreevents::processscoreevent("killed_defender", attacker);
                self recordkillmodifier("defending");
            }
            return;
        }
        if (!isdefined(attacker.var_e05a47f)) {
            attacker.var_e05a47f = 0;
        }
        attacker.var_e05a47f++;
        if (level.playerdefensivemax >= attacker.var_e05a47f) {
            attacker medals::defenseglobalcount();
            attacker thread challenges::killedbasedefender(self.touchtriggers[triggerids[0]]);
            if (isdefined(attacker.pers["defends"])) {
                attacker.pers["defends"]++;
                attacker.defends = attacker.pers["defends"];
            }
            scoreevents::processscoreevent("killed_attacker", attacker, undefined, weapon);
            self recordkillmodifier("assaulting");
        }
    }
}

// Namespace res
// Params 1, eflags: 0x0
// Checksum 0x46aa31ef, Offset: 0x3f08
// Size: 0x78
function getteamflagcount(team) {
    score = 0;
    for (i = 0; i < level.flags.size; i++) {
        if (level.var_2b613fd2[i] gameobjects::get_owner_team() == team) {
            score++;
        }
    }
    return score;
}

// Namespace res
// Params 0, eflags: 0x0
// Checksum 0x2674aa4d, Offset: 0x3f88
// Size: 0x1a
function getflagteam() {
    return self.useobj gameobjects::get_owner_team();
}

// Namespace res
// Params 2, eflags: 0x0
// Checksum 0x18f957f5, Offset: 0x3fb0
// Size: 0x4a
function updateobjectivehintmessages(var_39728b78, var_a62376d7) {
    game["strings"]["objective_hint_allies"] = var_39728b78;
    game["strings"]["objective_hint_axis"] = var_a62376d7;
}

// Namespace res
// Params 0, eflags: 0x0
// Checksum 0x21fef450, Offset: 0x4008
// Size: 0x124
function createflagspawninfluencers() {
    ss = level.spawnsystem;
    for (flag_index = 0; flag_index < level.flags.size; flag_index++) {
        if (level.var_2b613fd2[flag_index] == self) {
            break;
        }
    }
    self.owned_flag_influencer = self spawning::create_influencer("res_friendly", self.trigger.origin, 0);
    self.neutral_flag_influencer = self spawning::create_influencer("res_neutral", self.trigger.origin, 0);
    self.enemy_flag_influencer = self spawning::create_influencer("res_enemy", self.trigger.origin, 0);
    self update_spawn_influencers("neutral");
}

// Namespace res
// Params 1, eflags: 0x0
// Checksum 0xb8a020c2, Offset: 0x4138
// Size: 0x18c
function update_spawn_influencers(team) {
    assert(isdefined(self.neutral_flag_influencer));
    assert(isdefined(self.owned_flag_influencer));
    assert(isdefined(self.enemy_flag_influencer));
    if (team == "neutral") {
        enableinfluencer(self.neutral_flag_influencer, 1);
        enableinfluencer(self.owned_flag_influencer, 0);
        enableinfluencer(self.enemy_flag_influencer, 0);
        return;
    }
    enableinfluencer(self.neutral_flag_influencer, 0);
    enableinfluencer(self.owned_flag_influencer, 1);
    enableinfluencer(self.enemy_flag_influencer, 1);
    setinfluencerteammask(self.owned_flag_influencer, util::getteammask(team));
    setinfluencerteammask(self.enemy_flag_influencer, util::getotherteamsmask(team));
}

// Namespace res
// Params 0, eflags: 0x0
// Checksum 0x4c71cf1, Offset: 0x42d0
// Size: 0x64
function function_454612db() {
    level.var_889c603d = hud::function_a276e732(game["attackers"]);
    level.var_66838b89 = hud::function_a276e732(game["defenders"]);
    function_b2a0e7a3();
}

// Namespace res
// Params 0, eflags: 0x0
// Checksum 0x81e7ec2, Offset: 0x4340
// Size: 0x4c
function function_b2a0e7a3() {
    function_895e5681(0);
    level.var_889c603d hud::hideelem();
    level.var_66838b89 hud::hideelem();
}

// Namespace res
// Params 0, eflags: 0x0
// Checksum 0x5a5e1d2a, Offset: 0x4398
// Size: 0x34
function function_b41552b6() {
    level.var_889c603d hud::showelem();
    level.var_66838b89 hud::showelem();
}

// Namespace res
// Params 2, eflags: 0x0
// Checksum 0x6479d38c, Offset: 0x43d8
// Size: 0x13c
function function_895e5681(value, var_59e41820) {
    if (value < 0) {
        value = 0;
    }
    if (value > 1) {
        value = 1;
    }
    if (isdefined(var_59e41820)) {
        if (var_59e41820 == game["attackers"]) {
            level.var_889c603d.bar.color = (255, 255, 255);
            level.var_66838b89.bar.color = (255, 0, 0);
        } else {
            level.var_889c603d.bar.color = (255, 0, 0);
            level.var_66838b89.bar.color = (255, 255, 255);
        }
    }
    level.var_889c603d hud::updatebar(value);
    level.var_66838b89 hud::updatebar(value);
}

