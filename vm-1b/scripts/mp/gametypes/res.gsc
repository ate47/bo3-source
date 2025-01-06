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
// Checksum 0x2241fa, Offset: 0x980
// Size: 0x1a1
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
    InvalidOpCode(0xc8, "dialog", "gametype", "res_start");
    // Unknown operator (0xc8, t7_1b, PC)
}

// Namespace res
// Params 0, eflags: 0x0
// Checksum 0xe9c07cd6, Offset: 0xbd8
// Size: 0x2
function onprecachegametype() {
    
}

// Namespace res
// Params 0, eflags: 0x0
// Checksum 0x7a9b1945, Offset: 0xbe8
// Size: 0x11
function onroundswitch() {
    InvalidOpCode(0x54, "switchedsides");
    // Unknown operator (0x54, t7_1b, PC)
}

// Namespace res
// Params 0, eflags: 0x0
// Checksum 0x51414805, Offset: 0xcc8
// Size: 0x18d
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
// Checksum 0x9aaf685d, Offset: 0xe60
// Size: 0x49
function onstartgametype() {
    InvalidOpCode(0x54, "switchedsides");
    // Unknown operator (0x54, t7_1b, PC)
}

// Namespace res
// Params 1, eflags: 0x0
// Checksum 0x3372770, Offset: 0x13e8
// Size: 0x49
function onendgame(winningteam) {
    for (i = 0; i < level.var_2b613fd2.size; i++) {
        level.var_2b613fd2[i] gameobjects::allow_use("none");
    }
}

// Namespace res
// Params 1, eflags: 0x0
// Checksum 0xd89e1b57, Offset: 0x1440
// Size: 0x2e
function onroundendgame(roundwinner) {
    winner = globallogic::determineteamwinnerbygamestat("roundswon");
    return winner;
}

// Namespace res
// Params 2, eflags: 0x0
// Checksum 0x621a3f45, Offset: 0x1478
// Size: 0x4a
function function_e9c2ac15(winningteam, endreasontext) {
    if (isdefined(winningteam) && winningteam != "tie") {
        globallogic_score::giveteamscoreforobjective(winningteam, 1);
    }
    thread globallogic::endgame(winningteam, endreasontext);
}

// Namespace res
// Params 0, eflags: 0x0
// Checksum 0x4b02ee22, Offset: 0x14d0
// Size: 0x7d
function ontimelimit() {
    if (level.overtime) {
        if (isdefined(level.var_28e4e3eb)) {
            InvalidOpCode(0x54, "strings", "time_limit_reached");
            // Unknown operator (0x54, t7_1b, PC)
        }
        InvalidOpCode(0x54, "strings", "time_limit_reached");
        // Unknown operator (0x54, t7_1b, PC)
    }
    InvalidOpCode(0x54, "strings", "time_limit_reached");
    // Unknown operator (0x54, t7_1b, PC)
}

// Namespace res
// Params 0, eflags: 0x0
// Checksum 0xe8d9905a, Offset: 0x1570
// Size: 0x60
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
// Checksum 0xef3484bf, Offset: 0x15d8
// Size: 0x122
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
// Checksum 0xcd02194f, Offset: 0x1708
// Size: 0x521
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
    index = 0;
    if (index < level.flags.size) {
        trigger = level.flags[index];
        if (isdefined(trigger.target)) {
            visuals[0] = getent(trigger.target, "targetname");
        } else {
            visuals[0] = spawn("script_model", trigger.origin);
            visuals[0].angles = trigger.angles;
        }
        InvalidOpCode(0x54, "defenders");
        // Unknown operator (0x54, t7_1b, PC)
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
// Checksum 0x4df092a0, Offset: 0x1c38
// Size: 0x14f
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
// Checksum 0x82949305, Offset: 0x1d90
// Size: 0x7a
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
// Checksum 0xd748cbf3, Offset: 0x1e18
// Size: 0x202
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
// Checksum 0xd9f0928a, Offset: 0x2028
// Size: 0x1e
function hidetimerdisplayongameend(timerdisplay) {
    level waittill(#"game_ended");
    timerdisplay.alpha = 0;
}

// Namespace res
// Params 1, eflags: 0x0
// Checksum 0xf2bf5f1c, Offset: 0x2050
// Size: 0x3f2
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
// Checksum 0xe28245ed, Offset: 0x2450
// Size: 0x72
function function_e8347813(flagindex) {
    assert(flagindex < level.var_2b613fd2.size);
    var_e5ce1ae3 = level.var_2b613fd2[flagindex];
    var_e5ce1ae3 gameobjects::allow_use("none");
    var_e5ce1ae3 gameobjects::set_visible_team("none");
    var_e5ce1ae3 gameobjects::set_model_visibility(0);
}

// Namespace res
// Params 2, eflags: 0x0
// Checksum 0xb0abc99e, Offset: 0x24d0
// Size: 0xd5
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
// Checksum 0xc3bfe15d, Offset: 0x25b0
// Size: 0x162
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
// Checksum 0xff964fda, Offset: 0x2720
// Size: 0x122
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
// Checksum 0xc4888553, Offset: 0x2850
// Size: 0x22
function onuseclear() {
    globallogic_utils::resumetimer();
    function_895e5681(0);
}

// Namespace res
// Params 2, eflags: 0x0
// Checksum 0xe8a1ae93, Offset: 0x2880
// Size: 0x57
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
// Checksum 0x311d71f1, Offset: 0x28e0
// Size: 0x8a
function onenduse(team, player, success) {
    setdvar("scr_obj" + self gameobjects::get_label() + "_flash", 0);
    self.objpoints["allies"] thread objpoints::function_a51dc9ba();
    self.objpoints["axis"] thread objpoints::function_a51dc9ba();
}

// Namespace res
// Params 0, eflags: 0x0
// Checksum 0xbc378081, Offset: 0x2978
// Size: 0xa2
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
// Checksum 0xbae2aeab, Offset: 0x2a28
// Size: 0x4b2
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
        InvalidOpCode(0x54, "strings", "flags_capped");
        // Unknown operator (0x54, t7_1b, PC)
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
    } else {
        if (label == "_b") {
            InvalidOpCode(0x54, "attackers", "mp_res_spawn_allies_b");
            // Unknown operator (0x54, t7_1b, PC)
        }
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
// Checksum 0x903435a1, Offset: 0x2ee8
// Size: 0x119
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
// Checksum 0x78b72852, Offset: 0x3010
// Size: 0x3a
function delayedleaderdialog(sound, team) {
    wait 0.1;
    util::waittillslowprocessallowed();
    globallogic_audio::leader_dialog(sound, team);
}

// Namespace res
// Params 0, eflags: 0x0
// Checksum 0x6b96727, Offset: 0x3058
// Size: 0x1ee
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
// Checksum 0xd14b629, Offset: 0x3250
// Size: 0x262
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
                attacker addplayerstatwithgametype("OFFENDS", 1);
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
            attacker addplayerstatwithgametype("DEFENDS", 1);
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
// Checksum 0xe5f0b94c, Offset: 0x34c0
// Size: 0x5b
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
// Checksum 0xad237dd, Offset: 0x3528
// Size: 0x19
function getflagteam() {
    return self.useobj gameobjects::get_owner_team();
}

// Namespace res
// Params 2, eflags: 0x0
// Checksum 0xbe1bdda5, Offset: 0x3550
// Size: 0x21
function updateobjectivehintmessages(var_39728b78, var_a62376d7) {
    InvalidOpCode(0xc8, "strings", "objective_hint_allies", var_39728b78);
    // Unknown operator (0xc8, t7_1b, PC)
}

// Namespace res
// Params 0, eflags: 0x0
// Checksum 0x44a8ab9d, Offset: 0x3598
// Size: 0xf2
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
// Checksum 0x4cb02533, Offset: 0x3698
// Size: 0x13a
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
// Checksum 0x44e4e191, Offset: 0x37e0
// Size: 0x9
function function_454612db() {
    InvalidOpCode(0x54, "attackers");
    // Unknown operator (0x54, t7_1b, PC)
}

// Namespace res
// Params 0, eflags: 0x0
// Checksum 0xd2d5aed9, Offset: 0x3840
// Size: 0x42
function function_b2a0e7a3() {
    function_895e5681(0);
    level.var_889c603d hud::hideelem();
    level.var_66838b89 hud::hideelem();
}

// Namespace res
// Params 0, eflags: 0x0
// Checksum 0xaa4b72a, Offset: 0x3890
// Size: 0x32
function function_b41552b6() {
    level.var_889c603d hud::showelem();
    level.var_66838b89 hud::showelem();
}

// Namespace res
// Params 2, eflags: 0x0
// Checksum 0xbd2931a8, Offset: 0x38d0
// Size: 0x10a
function function_895e5681(value, var_59e41820) {
    if (value < 0) {
        value = 0;
    }
    if (value > 1) {
        value = 1;
    }
    if (isdefined(var_59e41820)) {
        InvalidOpCode(0x54, "attackers", var_59e41820);
        // Unknown operator (0x54, t7_1b, PC)
    }
    level.var_889c603d hud::updatebar(value);
    level.var_66838b89 hud::updatebar(value);
}

