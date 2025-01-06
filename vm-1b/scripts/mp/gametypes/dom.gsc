#using scripts/mp/_challenges;
#using scripts/mp/_util;
#using scripts/mp/gametypes/_globallogic;
#using scripts/mp/gametypes/_globallogic_audio;
#using scripts/mp/gametypes/_globallogic_score;
#using scripts/mp/gametypes/_globallogic_utils;
#using scripts/mp/gametypes/_hostmigration;
#using scripts/mp/gametypes/_spawning;
#using scripts/mp/gametypes/_spawnlogic;
#using scripts/mp/teams/_teams;
#using scripts/shared/callbacks_shared;
#using scripts/shared/challenges_shared;
#using scripts/shared/demo_shared;
#using scripts/shared/gameobjects_shared;
#using scripts/shared/hostmigration_shared;
#using scripts/shared/math_shared;
#using scripts/shared/popups_shared;
#using scripts/shared/scoreevents_shared;
#using scripts/shared/sound_shared;
#using scripts/shared/util_shared;

#namespace dom;

// Namespace dom
// Params 0, eflags: 0x0
// Checksum 0x4f0108f, Offset: 0xd20
// Size: 0x1d9
function main() {
    globallogic::init();
    util::registertimelimit(0, 1440);
    util::registerscorelimit(0, 2000);
    util::registerroundscorelimit(0, 2000);
    util::registerroundlimit(0, 10);
    util::registerroundwinlimit(0, 10);
    util::registerroundswitch(0, 9);
    util::registernumlives(0, 100);
    globallogic::registerfriendlyfiredelay(level.gametype, 15, 0, 1440);
    level.scoreroundwinbased = getgametypesetting("cumulativeRoundScores") == 0;
    level.teambased = 1;
    level.overrideteamscore = 1;
    level.onstartgametype = &onstartgametype;
    level.onplayerkilled = &onplayerkilled;
    level.onroundswitch = &onroundswitch;
    level.onprecachegametype = &onprecachegametype;
    level.onendgame = &onendgame;
    level.onroundendgame = &onroundendgame;
    gameobjects::register_allowed_gameobject(level.gametype);
    globallogic_audio::set_leader_gametype_dialog("startDomination", "hcStartDomination", "objCapture", "objCapture");
    InvalidOpCode(0xc8, "dialog", "securing_a", "domFriendlySecuringA");
    // Unknown operator (0xc8, t7_1b, PC)
}

// Namespace dom
// Params 0, eflags: 0x0
// Checksum 0xe9c07cd6, Offset: 0x11f0
// Size: 0x2
function onprecachegametype() {
    
}

// Namespace dom
// Params 0, eflags: 0x0
// Checksum 0xc9c1bc90, Offset: 0x1200
// Size: 0x89
function onstartgametype() {
    util::setobjectivetext("allies", %OBJECTIVES_DOM);
    util::setobjectivetext("axis", %OBJECTIVES_DOM);
    InvalidOpCode(0x54, "switchedsides");
    // Unknown operator (0x54, t7_1b, PC)
}

// Namespace dom
// Params 1, eflags: 0x0
// Checksum 0x5a895049, Offset: 0x1608
// Size: 0xc1
function onendgame(winningteam) {
    for (i = 0; i < level.domflags.size; i++) {
        domflag = level.domflags[i];
        domflag gameobjects::allow_use("none");
        if (isdefined(domflag.singleowner) && domflag.singleowner == 1) {
            team = domflag gameobjects::get_owner_team();
            label = domflag gameobjects::get_label();
            challenges::holdflagentirematch(team, label);
        }
    }
}

// Namespace dom
// Params 1, eflags: 0x0
// Checksum 0x9461ebd8, Offset: 0x16d8
// Size: 0xb6
function onroundendgame(roundwinner) {
    if (level.scoreroundwinbased) {
        var_87bb3477 = level.teams;
        var_f6095d41 = firstarray(var_87bb3477);
        if (isdefined(var_f6095d41)) {
            team = var_87bb3477[var_f6095d41];
            var_4728d7aa = nextarray(var_87bb3477, var_f6095d41);
            InvalidOpCode(0x54, "roundswon", team);
            // Unknown operator (0x54, t7_1b, PC)
        }
        winner = globallogic::determineteamwinnerbygamestat("roundswon");
    } else {
        winner = globallogic::determineteamwinnerbyteamscore();
    }
    return winner;
}

// Namespace dom
// Params 0, eflags: 0x0
// Checksum 0xc48b08d0, Offset: 0x1798
// Size: 0xc2
function updategametypedvars() {
    level.flagcapturetime = getgametypesetting("captureTime");
    level.playercapturelpm = getgametypesetting("maxPlayerEventsPerMinute");
    level.flagcapturelpm = getgametypesetting("maxObjectiveEventsPerMinute");
    level.playeroffensivemax = getgametypesetting("maxPlayerOffensive");
    level.playerdefensivemax = getgametypesetting("maxPlayerDefensive");
    level.flagcanbeneutralized = getgametypesetting("flagCanBeNeutralized");
}

// Namespace dom
// Params 0, eflags: 0x0
// Checksum 0x7607a366, Offset: 0x1868
// Size: 0x602
function domflags() {
    level.laststatus["allies"] = 0;
    level.laststatus["axis"] = 0;
    level.flagmodel["allies"] = "tag_origin";
    level.flagmodel["axis"] = "tag_origin";
    level.flagmodel["neutral"] = "tag_origin";
    primaryflags = getentarray("flag_primary", "targetname");
    if (primaryflags.size < 2) {
        println("<dev string:x28>");
        callback::abort_level();
        return;
    }
    level.flags = [];
    foreach (dom_flag in primaryflags) {
        if (isdefined(dom_flag.target)) {
            trigger = getent(dom_flag.target, "targetname");
            if (isdefined(trigger)) {
                trigger.visual = dom_flag;
                trigger.script_label = dom_flag.script_label;
            } else {
                /#
                    util::error("<dev string:x56>" + dom_flag.script_label + "<dev string:x76>" + dom_flag.target);
                #/
            }
        } else {
            /#
                util::error("<dev string:x56>" + dom_flag.script_label);
            #/
        }
        level.flags[level.flags.size] = trigger;
    }
    level.domflags = [];
    foreach (trigger in level.flags) {
        trigger.visual setmodel(level.flagmodel["neutral"]);
        name = istring("dom" + trigger.visual.script_label);
        visuals = [];
        visuals[0] = trigger.visual;
        domflag = gameobjects::create_use_object("neutral", trigger, visuals, (0, 0, 0), name);
        domflag gameobjects::allow_use("enemy");
        domflag gameobjects::set_use_time(level.flagcapturetime);
        domflag gameobjects::set_use_text(%MP_CAPTURING_FLAG);
        label = domflag gameobjects::get_label();
        domflag.label = label;
        domflag.flagindex = trigger.visual.script_index;
        domflag gameobjects::set_visible_team("any");
        domflag.onuse = &onuse;
        domflag.onbeginuse = &onbeginuse;
        domflag.onuseupdate = &onuseupdate;
        domflag.onenduse = &onenduse;
        domflag.onupdateuserate = &onupdateuserate;
        domflag gameobjects::set_objective_entity(visuals[0]);
        domflag gameobjects::set_owner_team("neutral");
        tracestart = visuals[0].origin + (0, 0, 32);
        traceend = visuals[0].origin + (0, 0, -32);
        trace = bullettrace(tracestart, traceend, 0, undefined);
        upangles = vectortoangles(trace["normal"]);
        domflag.baseeffectforward = anglestoforward(upangles);
        domflag.baseeffectright = anglestoright(upangles);
        domflag.baseeffectpos = trace["position"];
        domflag function_b7ddf8ec();
        trigger.useobj = domflag;
        trigger.adjflags = [];
        trigger.nearbyspawns = [];
        domflag.levelflag = trigger;
        level.domflags[level.domflags.size] = domflag;
    }
    level.bestspawnflag = [];
    level.bestspawnflag["allies"] = getunownedflagneareststart("allies", undefined);
    level.bestspawnflag["axis"] = getunownedflagneareststart("axis", level.bestspawnflag["allies"]);
    for (index = 0; index < level.domflags.size; index++) {
        level.domflags[index] createflagspawninfluencers();
    }
    flagsetup();
    /#
        thread domdebug();
    #/
}

// Namespace dom
// Params 2, eflags: 0x0
// Checksum 0xdf1cc865, Offset: 0x1e78
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

/#

    // Namespace dom
    // Params 0, eflags: 0x0
    // Checksum 0x2346d71b, Offset: 0x1f58
    // Size: 0x1f1
    function domdebug() {
        while (true) {
            if (getdvarstring("<dev string:x88>") != "<dev string:x95>") {
                wait 2;
                continue;
            }
            while (true) {
                if (getdvarstring("<dev string:x88>") != "<dev string:x95>") {
                    break;
                }
                for (i = 0; i < level.flags.size; i++) {
                    for (j = 0; j < level.flags[i].adjflags.size; j++) {
                        line(level.flags[i].origin, level.flags[i].adjflags[j].origin, (1, 1, 1));
                    }
                    for (j = 0; j < level.flags[i].nearbyspawns.size; j++) {
                        line(level.flags[i].origin, level.flags[i].nearbyspawns[j].origin, (0.2, 0.2, 0.6));
                    }
                    if (level.flags[i] == level.bestspawnflag["<dev string:x97>"]) {
                        print3d(level.flags[i].origin, "<dev string:x9e>");
                    }
                    if (level.flags[i] == level.bestspawnflag["<dev string:xb5>"]) {
                        print3d(level.flags[i].origin, "<dev string:xba>");
                    }
                }
                wait 0.05;
            }
        }
    }

#/

// Namespace dom
// Params 1, eflags: 0x0
// Checksum 0x561fc9cb, Offset: 0x2158
// Size: 0xc3
function onbeginuse(player) {
    ownerteam = self gameobjects::get_owner_team();
    self.didstatusnotify = 0;
    if (ownerteam == "allies") {
        otherteam = "axis";
    } else {
        otherteam = "allies";
    }
    if (ownerteam == "neutral") {
        otherteam = util::getotherteam(player.pers["team"]);
        statusdialog("securing" + self.label, player.pers["team"], "objective" + self.label);
        return;
    }
}

// Namespace dom
// Params 3, eflags: 0x0
// Checksum 0x1135791c, Offset: 0x2228
// Size: 0x1c2
function onuseupdate(team, progress, change) {
    if (progress > 0.05 && change && !self.didstatusnotify) {
        ownerteam = self gameobjects::get_owner_team();
        if (ownerteam == "neutral") {
            otherteam = util::getotherteam(team);
            statusdialog("securing" + self.label, team, "objective" + self.label);
        } else {
            statusdialog("losing" + self.label, ownerteam, "objective" + self.label);
            statusdialog("securing" + self.label, team, "objective" + self.label);
            globallogic_audio::flush_objective_dialog("objective_all");
        }
        self.didstatusnotify = 1;
        return;
    }
    if (level.flagcanbeneutralized && progress > 0.49 && change && self.didstatusnotify) {
        ownerteam = self gameobjects::get_owner_team();
        if (ownerteam != "neutral") {
            self thread function_79616162();
            statusdialog("lost" + self.label, ownerteam, "objective" + self.label);
            globallogic_audio::flush_objective_dialog("objective_all");
        }
    }
}

// Namespace dom
// Params 0, eflags: 0x0
// Checksum 0x1aa55e53, Offset: 0x23f8
// Size: 0x5a
function function_79616162() {
    self notify(#"hash_1c27b39f");
    self gameobjects::set_owner_team("neutral");
    self.visuals[0] setmodel(level.flagmodel["neutral"]);
    self function_b7ddf8ec();
}

// Namespace dom
// Params 0, eflags: 0x0
// Checksum 0xaab7ec1d, Offset: 0x2460
// Size: 0x4a
function flushobjectiveflagdialog() {
    globallogic_audio::flush_objective_dialog("objective_a");
    globallogic_audio::flush_objective_dialog("objective_b");
    globallogic_audio::flush_objective_dialog("objective_c");
}

// Namespace dom
// Params 3, eflags: 0x0
// Checksum 0x608b8328, Offset: 0x24b8
// Size: 0x41
function statusdialog(dialog, team, objectivekey) {
    InvalidOpCode(0x54, "dialogTime", dialog);
    // Unknown operator (0x54, t7_1b, PC)
}

// Namespace dom
// Params 3, eflags: 0x0
// Checksum 0x7df85eda, Offset: 0x2578
// Size: 0x3a
function onenduse(team, player, success) {
    if (!success) {
        globallogic_audio::flush_objective_dialog("objective" + self.label);
    }
}

// Namespace dom
// Params 0, eflags: 0x0
// Checksum 0xe9c07cd6, Offset: 0x25c0
// Size: 0x2
function function_b7ddf8ec() {
    
}

// Namespace dom
// Params 1, eflags: 0x0
// Checksum 0x5b0446d7, Offset: 0x25d0
// Size: 0x5fa
function onuse(player) {
    level notify(#"flag_captured");
    team = player.pers["team"];
    oldteam = self gameobjects::get_owner_team();
    label = self gameobjects::get_label();
    /#
        print("<dev string:xcf>" + self.label);
    #/
    self gameobjects::set_owner_team(team);
    self.visuals[0] setmodel(level.flagmodel[team]);
    setdvar("scr_obj" + self gameobjects::get_label(), team);
    self function_b7ddf8ec();
    level.usestartspawns = 0;
    assert(team != "<dev string:xdf>");
    isbflag = 0;
    string = %;
    switch (label) {
    case "_a":
        string = %MP_DOM_FLAG_A_CAPTURED_BY;
        break;
    case "_b":
        string = %MP_DOM_FLAG_B_CAPTURED_BY;
        isbflag = 1;
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
    assert(string != %"<dev string:xe7>");
    touchlist = [];
    touchkeys = getarraykeys(self.touchlist[team]);
    for (i = 0; i < touchkeys.size; i++) {
        touchlist[touchkeys[i]] = self.touchlist[team][touchkeys[i]];
    }
    thread give_capture_credit(touchlist, string, oldteam, isbflag);
    bbprint("mpobjective", "gametime %d objtype %s label %s team %s playerx %d playery %d playerz %d", gettime(), "dom_capture", label, team, player.origin);
    if (oldteam == "neutral") {
        self.singleowner = 1;
        otherteam = util::getotherteam(team);
        thread util::printandsoundoneveryone(team, undefined, %, undefined, "mp_war_objective_taken");
        thread sound::play_on_players("mus_dom_captured" + "_" + level.teampostfix[team]);
        if (getteamflagcount(team) == level.flags.size) {
            statusdialog("secured_all", team, "objective_all");
            statusdialog("lost_all", otherteam, "objective_all");
            flushobjectiveflagdialog();
        } else {
            statusdialog("secured" + self.label, team, "objective" + self.label);
            statusdialog("enemy" + self.label, otherteam, "objective" + self.label);
            globallogic_audio::flush_objective_dialog("objective_all");
            globallogic_audio::play_2d_on_team("mpl_flagcapture_sting_enemy", otherteam);
            globallogic_audio::play_2d_on_team("mpl_flagcapture_sting_friend", team);
        }
    } else {
        self.singleowner = 0;
        thread util::printandsoundoneveryone(team, oldteam, %, %, "mp_war_objective_taken", "mp_war_objective_lost", "");
        if (getteamflagcount(team) == level.flags.size) {
            statusdialog("secured_all", team, "objective_all");
            statusdialog("lost_all", oldteam, "objective_all");
            flushobjectiveflagdialog();
        } else {
            statusdialog("secured" + self.label, team, "objective" + self.label);
            if (randomint(2)) {
                statusdialog("lost" + self.label, oldteam, "objective" + self.label);
            } else {
                statusdialog("enemy" + self.label, oldteam, "objective" + self.label);
            }
            globallogic_audio::flush_objective_dialog("objective_all");
            globallogic_audio::play_2d_on_team("mpl_flagcapture_sting_enemy", oldteam);
            globallogic_audio::play_2d_on_team("mpl_flagcapture_sting_friend", team);
        }
        level.bestspawnflag[oldteam] = self.levelflag;
    }
    if (dominated_challenge_check()) {
        level thread totaldomination(team);
    }
    self update_spawn_influencers(team);
    level function_25cda323();
}

// Namespace dom
// Params 1, eflags: 0x0
// Checksum 0xf3cd2af6, Offset: 0x2bd8
// Size: 0x32
function totaldomination(team) {
    level endon(#"flag_captured");
    level endon(#"game_ended");
    wait -76;
    challenges::totaldomination(team);
}

// Namespace dom
// Params 0, eflags: 0x0
// Checksum 0x4881f588, Offset: 0x2c18
// Size: 0x4d
function watchforbflagcap() {
    level endon(#"game_ended");
    level endon(#"endwatchforbflagcapaftertime");
    level thread endwatchforbflagcapaftertime(60);
    for (;;) {
        level waittill(#"b_flag_captured", player);
        player challenges::capturedbfirstminute();
    }
}

// Namespace dom
// Params 1, eflags: 0x0
// Checksum 0xcecece35, Offset: 0x2c70
// Size: 0x1f
function endwatchforbflagcapaftertime(time) {
    level endon(#"game_ended");
    wait 60;
    level notify(#"endwatchforbflagcapaftertime");
}

// Namespace dom
// Params 4, eflags: 0x0
// Checksum 0xc8eb32eb, Offset: 0x2c98
// Size: 0x209
function give_capture_credit(touchlist, string, lastownerteam, isbflag) {
    time = gettime();
    wait 0.05;
    util::waittillslowprocessallowed();
    self updatecapsperminute(lastownerteam);
    players = getarraykeys(touchlist);
    for (i = 0; i < players.size; i++) {
        player_from_touchlist = touchlist[players[i]].player;
        player_from_touchlist updatecapsperminute(lastownerteam);
        if (!isscoreboosting(player_from_touchlist, self)) {
            player_from_touchlist challenges::capturedobjective(time);
            if (lastownerteam == "neutral") {
                if (isbflag) {
                    scoreevents::processscoreevent("dom_point_neutral_b_secured", player_from_touchlist);
                } else {
                    scoreevents::processscoreevent("dom_point_neutral_secured", player_from_touchlist);
                }
            } else {
                scoreevents::processscoreevent("dom_point_secured", player_from_touchlist);
            }
            player_from_touchlist recordgameevent("capture");
            if (isbflag) {
                level notify(#"b_flag_captured", player_from_touchlist);
            }
            if (isdefined(player_from_touchlist.pers["captures"])) {
                player_from_touchlist.pers["captures"]++;
                player_from_touchlist.captures = player_from_touchlist.pers["captures"];
            }
            demo::bookmark("event", gettime(), player_from_touchlist);
            player_from_touchlist addplayerstatwithgametype("CAPTURES", 1);
        } else {
            /#
                player_from_touchlist iprintlnbold("<dev string:xe8>");
            #/
        }
        level thread popups::displayteammessagetoall(string, player_from_touchlist);
    }
}

// Namespace dom
// Params 0, eflags: 0x0
// Checksum 0x76c9f738, Offset: 0x2eb0
// Size: 0x3ed
function updatedomscores() {
    if (level.roundscorelimit && !level.timelimit) {
        warningscore = max(0, level.roundscorelimit - 12);
        clockobject = spawn("script_origin", (0, 0, 0));
        var_2d736e58 = max(0, level.roundscorelimit - 6);
    } else {
        warningscore = 0;
    }
    playednearendvo = 0;
    var_3d8de4c6 = 0;
    alliesroundstartscore = [[ level._getteamscore ]]("allies");
    axisroundstartscore = [[ level._getteamscore ]]("axis");
    while (!level.gameended) {
        numownedflags = 0;
        scoring_teams = [];
        numflags = getteamflagcount("allies");
        numownedflags += numflags;
        if (numflags) {
            scoring_teams[scoring_teams.size] = "allies";
            globallogic_score::giveteamscoreforobjective_delaypostprocessing("allies", numflags);
        }
        numflags = getteamflagcount("axis");
        numownedflags += numflags;
        if (numflags) {
            scoring_teams[scoring_teams.size] = "axis";
            globallogic_score::giveteamscoreforobjective_delaypostprocessing("axis", numflags);
        }
        if (numownedflags) {
            globallogic_score::postprocessteamscores(scoring_teams);
        }
        if (warningscore) {
            winningteam = undefined;
            alliesroundscore = [[ level._getteamscore ]]("allies") - alliesroundstartscore;
            axisroundscore = [[ level._getteamscore ]]("axis") - axisroundstartscore;
            if (!playednearendvo) {
                if (alliesroundscore >= warningscore) {
                    winningteam = "allies";
                } else if (axisroundscore >= warningscore) {
                    winningteam = "axis";
                }
                if (isdefined(winningteam)) {
                    nearwinning = "nearWinning";
                    nearlosing = "nearLosing";
                    if (util::islastround()) {
                        nearwinning = "nearWinningFinal";
                        nearlosing = "nearLosingFinal";
                    } else {
                        if (randomint(4) < 3) {
                            nearwinning = "nearWinningFinal";
                        }
                        if (randomint(4) < 1) {
                            nearlosing = "nearLosingFinal";
                        }
                    }
                    globallogic_audio::leader_dialog(nearwinning, winningteam);
                    globallogic_audio::leader_dialog_for_other_teams(nearlosing, winningteam);
                    playednearendvo = 1;
                }
            } else if (alliesroundscore > warningscore || axisroundscore > warningscore) {
                clockobject playsound("mpl_ui_timer_countdown");
            }
            if (!var_3d8de4c6) {
                if (alliesroundscore >= var_2d736e58 || axisroundscore >= var_2d736e58) {
                    level thread globallogic_audio::set_music_on_team("timeOut");
                    var_3d8de4c6 = 1;
                }
            }
        }
        onscoreclosemusic();
        timepassed = globallogic_utils::gettimepassed();
        if (timepassed / 1000 > 300 && (timepassed / 1000 > 120 && numownedflags < 2 || numownedflags < 3) && gamemodeismode(0)) {
            InvalidOpCode(0x54, "strings", "time_limit_reached");
            // Unknown operator (0x54, t7_1b, PC)
        }
        wait 5;
        hostmigration::waittillhostmigrationdone();
    }
}

// Namespace dom
// Params 0, eflags: 0x0
// Checksum 0x5d8da9ae, Offset: 0x32a8
// Size: 0x272
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
    if (!isdefined(level.sndhalfway)) {
        level.sndhalfway = 0;
    }
    if (alliedscore > axisscore) {
        currentscore = alliedscore;
    } else {
        currentscore = axisscore;
    }
    /#
        if (getdvarint("<dev string:x12d>") > 0) {
            println("<dev string:x139>" + scoredif);
            println("<dev string:x15d>" + axisscore);
            println("<dev string:x182>" + alliedscore);
            println("<dev string:x1a9>" + scorelimit);
            println("<dev string:x1cf>" + currentscore);
            println("<dev string:x1f7>" + scorethreshold);
            println("<dev string:x139>" + scoredif);
            println("<dev string:x221>" + scorethresholdstart);
        }
    #/
    if (scoredif <= scorethreshold && scorethresholdstart <= currentscore && level.playingactionmusic != 1) {
    }
    halfwayscore = scorelimit * 0.5;
    if (isdefined(level.roundscorelimit)) {
        halfwayscore = level.roundscorelimit * 0.5;
        InvalidOpCode(0x54, "roundsplayed");
        // Unknown operator (0x54, t7_1b, PC)
    }
    if ((axisscore >= halfwayscore || alliedscore >= halfwayscore) && !level.sndhalfway) {
        level notify(#"sndmusichalfway");
        level.sndhalfway = 1;
    }
}

// Namespace dom
// Params 0, eflags: 0x0
// Checksum 0x54e40ffb, Offset: 0x3528
// Size: 0x9
function onroundswitch() {
    InvalidOpCode(0x54, "switchedsides");
    // Unknown operator (0x54, t7_1b, PC)
}

// Namespace dom
// Params 9, eflags: 0x0
// Checksum 0x49d718a3, Offset: 0x35a8
// Size: 0x5b2
function onplayerkilled(einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime, deathanimduration) {
    if (isdefined(attacker) && isplayer(attacker)) {
        scoreeventprocessed = 0;
        if (attacker.touchtriggers.size && attacker.pers["team"] != self.pers["team"]) {
            triggerids = getarraykeys(attacker.touchtriggers);
            ownerteam = attacker.touchtriggers[triggerids[0]].useobj.ownerteam;
            team = attacker.pers["team"];
            if (team != ownerteam) {
                scoreevents::processscoreevent("kill_enemy_while_capping_dom", attacker, undefined, weapon);
                scoreeventprocessed = 1;
            }
        }
        for (index = 0; index < level.flags.size; index++) {
            flagteam = "invalidTeam";
            inflagzone = 0;
            defendedflag = 0;
            offendedflag = 0;
            flagorigin = level.flags[index].origin;
            level.defaultoffenseradius = 300;
            dist = distance2d(self.origin, flagorigin);
            if (dist < level.defaultoffenseradius) {
                inflagzone = 1;
                if (level.flags[index] getflagteam() == attacker.pers["team"] || level.flags[index] getflagteam() == "neutral") {
                    defendedflag = 1;
                } else {
                    offendedflag = 1;
                }
            }
            dist = distance2d(attacker.origin, flagorigin);
            if (dist < level.defaultoffenseradius) {
                inflagzone = 1;
                if (level.flags[index] getflagteam() == attacker.pers["team"] || level.flags[index] getflagteam() == "neutral") {
                    defendedflag = 1;
                } else {
                    offendedflag = 1;
                }
            }
            if (inflagzone && isplayer(attacker) && attacker.pers["team"] != self.pers["team"]) {
                if (offendedflag) {
                    if (!isdefined(attacker.dom_defends)) {
                        attacker.dom_defends = 0;
                    }
                    attacker.dom_defends++;
                    if (level.playerdefensivemax >= attacker.dom_defends) {
                        attacker addplayerstatwithgametype("OFFENDS", 1);
                        if (!scoreeventprocessed) {
                            scoreevents::processscoreevent("killed_defender", attacker, undefined, weapon);
                        }
                        self recordkillmodifier("defending");
                        break;
                    } else {
                        /#
                            attacker iprintlnbold("<dev string:x250>");
                        #/
                    }
                }
                if (defendedflag) {
                    if (!isdefined(attacker.dom_offends)) {
                        attacker.dom_offends = 0;
                    }
                    attacker thread updateattackermultikills();
                    attacker.dom_offends++;
                    if (level.playeroffensivemax >= attacker.dom_offends) {
                        attacker.pers["defends"]++;
                        attacker.defends = attacker.pers["defends"];
                        attacker addplayerstatwithgametype("DEFENDS", 1);
                        attacker recordgameevent("return");
                        attacker challenges::killedzoneattacker(weapon);
                        if (!scoreeventprocessed) {
                            scoreevents::processscoreevent("killed_attacker", attacker, undefined, weapon);
                        }
                        self recordkillmodifier("assaulting");
                        break;
                    }
                    /#
                        attacker iprintlnbold("<dev string:x297>");
                    #/
                }
            }
        }
        if (self.touchtriggers.size && attacker.pers["team"] != self.pers["team"]) {
            triggerids = getarraykeys(self.touchtriggers);
            ownerteam = self.touchtriggers[triggerids[0]].useobj.ownerteam;
            team = self.pers["team"];
            if (team != ownerteam) {
                flag = self.touchtriggers[triggerids[0]].useobj;
                if (isdefined(flag.contested) && flag.contested == 1) {
                    attacker killwhilecontesting(flag);
                }
            }
        }
    }
}

// Namespace dom
// Params 1, eflags: 0x0
// Checksum 0xc0745792, Offset: 0x3b68
// Size: 0x10a
function killwhilecontesting(flag) {
    self notify(#"killwhilecontesting");
    self endon(#"killwhilecontesting");
    self endon(#"disconnect");
    killtime = gettime();
    playerteam = self.pers["team"];
    if (!isdefined(self.clearenemycount)) {
        self.clearenemycount = 0;
    }
    self.clearenemycount++;
    flag waittill(#"contest_over");
    if (isdefined(self.spawntime) && (playerteam != self.pers["team"] || killtime < self.spawntime)) {
        self.clearenemycount = 0;
        return;
    }
    if (flag.ownerteam != playerteam && flag.ownerteam != "neutral") {
        self.clearenemycount = 0;
        return;
    }
    if (self.clearenemycount >= 2 && killtime + -56 > gettime()) {
        scoreevents::processscoreevent("clear_2_attackers", self);
    }
    self.clearenemycount = 0;
}

// Namespace dom
// Params 0, eflags: 0x0
// Checksum 0x8c74864a, Offset: 0x3c80
// Size: 0x72
function updateattackermultikills() {
    self endon(#"disconnect");
    level endon(#"game_ended");
    self notify(#"updatedomrecentkills");
    self endon(#"updatedomrecentkills");
    if (!isdefined(self.recentdomattackerkillcount)) {
        self.recentdomattackerkillcount = 0;
    }
    self.recentdomattackerkillcount++;
    wait 4;
    if (self.recentdomattackerkillcount > 1) {
        self challenges::domattackermultikill(self.recentdomattackerkillcount);
    }
    self.recentdomattackerkillcount = 0;
}

// Namespace dom
// Params 1, eflags: 0x0
// Checksum 0xb59e3bf9, Offset: 0x3d00
// Size: 0x5b
function getteamflagcount(team) {
    score = 0;
    for (i = 0; i < level.flags.size; i++) {
        if (level.domflags[i] gameobjects::get_owner_team() == team) {
            score++;
        }
    }
    return score;
}

// Namespace dom
// Params 0, eflags: 0x0
// Checksum 0x6ae974bc, Offset: 0x3d68
// Size: 0x19
function getflagteam() {
    return self.useobj gameobjects::get_owner_team();
}

// Namespace dom
// Params 0, eflags: 0x0
// Checksum 0x3f65fb6, Offset: 0x3d90
// Size: 0xb7
function getboundaryflags() {
    bflags = [];
    for (i = 0; i < level.flags.size; i++) {
        for (j = 0; j < level.flags[i].adjflags.size; j++) {
            if (level.flags[i].useobj gameobjects::get_owner_team() != level.flags[i].adjflags[j].useobj gameobjects::get_owner_team()) {
                bflags[bflags.size] = level.flags[i];
                break;
            }
        }
    }
    return bflags;
}

// Namespace dom
// Params 1, eflags: 0x0
// Checksum 0x6eec3b90, Offset: 0x3e50
// Size: 0xa7
function getboundaryflagspawns(team) {
    spawns = [];
    bflags = getboundaryflags();
    for (i = 0; i < bflags.size; i++) {
        if (isdefined(team) && bflags[i] getflagteam() != team) {
            continue;
        }
        for (j = 0; j < bflags[i].nearbyspawns.size; j++) {
            spawns[spawns.size] = bflags[i].nearbyspawns[j];
        }
    }
    return spawns;
}

// Namespace dom
// Params 1, eflags: 0x0
// Checksum 0x16dd314d, Offset: 0x3f00
// Size: 0xdb
function getspawnsboundingflag(avoidflag) {
    spawns = [];
    for (i = 0; i < level.flags.size; i++) {
        flag = level.flags[i];
        if (flag == avoidflag) {
            continue;
        }
        isbounding = 0;
        for (j = 0; j < flag.adjflags.size; j++) {
            if (flag.adjflags[j] == avoidflag) {
                isbounding = 1;
                break;
            }
        }
        if (!isbounding) {
            continue;
        }
        for (j = 0; j < flag.nearbyspawns.size; j++) {
            spawns[spawns.size] = flag.nearbyspawns[j];
        }
    }
    return spawns;
}

// Namespace dom
// Params 1, eflags: 0x0
// Checksum 0x63ebc004, Offset: 0x3fe8
// Size: 0x12d
function getownedandboundingflagspawns(team) {
    spawns = [];
    for (i = 0; i < level.flags.size; i++) {
        if (level.flags[i] getflagteam() == team) {
            for (s = 0; s < level.flags[i].nearbyspawns.size; s++) {
                spawns[spawns.size] = level.flags[i].nearbyspawns[s];
            }
            continue;
        }
        for (j = 0; j < level.flags[i].adjflags.size; j++) {
            if (level.flags[i].adjflags[j] getflagteam() == team) {
                for (s = 0; s < level.flags[i].nearbyspawns.size; s++) {
                    spawns[spawns.size] = level.flags[i].nearbyspawns[s];
                }
                break;
            }
        }
    }
    return spawns;
}

// Namespace dom
// Params 1, eflags: 0x0
// Checksum 0x65e129d0, Offset: 0x4120
// Size: 0x9b
function getownedflagspawns(team) {
    spawns = [];
    for (i = 0; i < level.flags.size; i++) {
        if (level.flags[i] getflagteam() == team) {
            for (s = 0; s < level.flags[i].nearbyspawns.size; s++) {
                spawns[spawns.size] = level.flags[i].nearbyspawns[s];
            }
        }
    }
    return spawns;
}

// Namespace dom
// Params 0, eflags: 0x0
// Checksum 0xff5db9cd, Offset: 0x41c8
// Size: 0x4ab
function flagsetup() {
    maperrors = [];
    descriptorsbylinkname = [];
    descriptors = getentarray("flag_descriptor", "targetname");
    flags = level.flags;
    for (i = 0; i < level.domflags.size; i++) {
        closestdist = undefined;
        closestdesc = undefined;
        for (j = 0; j < descriptors.size; j++) {
            dist = distance(flags[i].origin, descriptors[j].origin);
            if (!isdefined(closestdist) || dist < closestdist) {
                closestdist = dist;
                closestdesc = descriptors[j];
            }
        }
        if (!isdefined(closestdesc)) {
            maperrors[maperrors.size] = "there is no flag_descriptor in the map! see explanation in dom.gsc";
            break;
        }
        if (isdefined(closestdesc.flag)) {
            maperrors[maperrors.size] = "flag_descriptor with script_linkname \"" + closestdesc.script_linkname + "\" is nearby more than one flag; is there a unique descriptor near each flag?";
            continue;
        }
        flags[i].descriptor = closestdesc;
        closestdesc.flag = flags[i];
        descriptorsbylinkname[closestdesc.script_linkname] = closestdesc;
    }
    if (maperrors.size == 0) {
        for (i = 0; i < flags.size; i++) {
            if (isdefined(flags[i].descriptor.script_linkto)) {
                adjdescs = strtok(flags[i].descriptor.script_linkto, " ");
            } else {
                adjdescs = [];
            }
            for (j = 0; j < adjdescs.size; j++) {
                otherdesc = descriptorsbylinkname[adjdescs[j]];
                if (!isdefined(otherdesc) || otherdesc.targetname != "flag_descriptor") {
                    maperrors[maperrors.size] = "flag_descriptor with script_linkname \"" + flags[i].descriptor.script_linkname + "\" linked to \"" + adjdescs[j] + "\" which does not exist as a script_linkname of any other entity with a targetname of flag_descriptor (or, if it does, that flag_descriptor has not been assigned to a flag)";
                    continue;
                }
                adjflag = otherdesc.flag;
                if (adjflag == flags[i]) {
                    maperrors[maperrors.size] = "flag_descriptor with script_linkname \"" + flags[i].descriptor.script_linkname + "\" linked to itself";
                    continue;
                }
                flags[i].adjflags[flags[i].adjflags.size] = adjflag;
            }
        }
    }
    spawnpoints = spawnlogic::get_spawnpoint_array("mp_dom_spawn");
    for (i = 0; i < spawnpoints.size; i++) {
        if (isdefined(spawnpoints[i].script_linkto)) {
            desc = descriptorsbylinkname[spawnpoints[i].script_linkto];
            if (!isdefined(desc) || desc.targetname != "flag_descriptor") {
                maperrors[maperrors.size] = "Spawnpoint at " + spawnpoints[i].origin + "\" linked to \"" + spawnpoints[i].script_linkto + "\" which does not exist as a script_linkname of any entity with a targetname of flag_descriptor (or, if it does, that flag_descriptor has not been assigned to a flag)";
                continue;
            }
            nearestflag = desc.flag;
        } else {
            nearestflag = undefined;
            nearestdist = undefined;
            for (j = 0; j < flags.size; j++) {
                dist = distancesquared(flags[j].origin, spawnpoints[i].origin);
                if (!isdefined(nearestflag) || dist < nearestdist) {
                    nearestflag = flags[j];
                    nearestdist = dist;
                }
            }
        }
        nearestflag.nearbyspawns[nearestflag.nearbyspawns.size] = spawnpoints[i];
    }
    if (maperrors.size > 0) {
        /#
            println("<dev string:x2de>");
            for (i = 0; i < maperrors.size; i++) {
                println(maperrors[i]);
            }
            println("<dev string:x305>");
            util::error("<dev string:x32c>");
        #/
        callback::abort_level();
        return;
    }
}

// Namespace dom
// Params 0, eflags: 0x0
// Checksum 0xe6a7486, Offset: 0x4680
// Size: 0xf2
function createflagspawninfluencers() {
    ss = level.spawnsystem;
    for (flag_index = 0; flag_index < level.flags.size; flag_index++) {
        if (level.domflags[flag_index] == self) {
            break;
        }
    }
    self.owned_flag_influencer = self spawning::create_influencer("dom_friendly", self.trigger.origin, 0);
    self.neutral_flag_influencer = self spawning::create_influencer("dom_neutral", self.trigger.origin, 0);
    self.enemy_flag_influencer = self spawning::create_influencer("dom_enemy", self.trigger.origin, 0);
    self update_spawn_influencers("neutral");
}

// Namespace dom
// Params 1, eflags: 0x0
// Checksum 0xabd60d74, Offset: 0x4780
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

// Namespace dom
// Params 3, eflags: 0x0
// Checksum 0x963c4466, Offset: 0x48c8
// Size: 0x29
function addspawnpointsforflag(team, flag_team, flagspawnname) {
    InvalidOpCode(0x54, "switchedsides");
    // Unknown operator (0x54, t7_1b, PC)
}

// Namespace dom
// Params 0, eflags: 0x0
// Checksum 0x3bb2d8bf, Offset: 0x4948
// Size: 0x1b2
function function_25cda323() {
    spawnlogic::clear_spawn_points();
    spawnlogic::add_spawn_points("allies", "mp_dom_spawn");
    spawnlogic::add_spawn_points("axis", "mp_dom_spawn");
    var_5a5001b5 = level.flags.size;
    if (dominated_check()) {
        for (i = 0; i < var_5a5001b5; i++) {
            label = level.flags[i].useobj gameobjects::get_label();
            flagspawnname = "mp_dom_spawn_flag" + label;
            spawnlogic::add_spawn_points("allies", flagspawnname);
            spawnlogic::add_spawn_points("axis", flagspawnname);
        }
    } else {
        for (i = 0; i < var_5a5001b5; i++) {
            label = level.flags[i].useobj gameobjects::get_label();
            flagspawnname = "mp_dom_spawn_flag" + label;
            flag_team = level.flags[i] getflagteam();
            addspawnpointsforflag("allies", flag_team, flagspawnname);
            addspawnpointsforflag("axis", flag_team, flagspawnname);
        }
    }
    spawning::updateallspawnpoints();
}

// Namespace dom
// Params 0, eflags: 0x0
// Checksum 0x580cdfa, Offset: 0x4b08
// Size: 0xa7
function dominated_challenge_check() {
    num_flags = level.flags.size;
    allied_flags = 0;
    axis_flags = 0;
    for (i = 0; i < num_flags; i++) {
        flag_team = level.flags[i] getflagteam();
        if (flag_team == "allies") {
            allied_flags++;
        } else if (flag_team == "axis") {
            axis_flags++;
        } else {
            return false;
        }
        if (allied_flags > 0 && axis_flags > 0) {
            return false;
        }
    }
    return true;
}

// Namespace dom
// Params 0, eflags: 0x0
// Checksum 0x3aa0c5f6, Offset: 0x4bb8
// Size: 0xa1
function dominated_check() {
    num_flags = level.flags.size;
    allied_flags = 0;
    axis_flags = 0;
    for (i = 0; i < num_flags; i++) {
        flag_team = level.flags[i] getflagteam();
        if (flag_team == "allies") {
            allied_flags++;
        } else if (flag_team == "axis") {
            axis_flags++;
        }
        if (allied_flags > 0 && axis_flags > 0) {
            return false;
        }
    }
    return true;
}

// Namespace dom
// Params 1, eflags: 0x0
// Checksum 0xe6e6d37b, Offset: 0x4c68
// Size: 0xca
function updatecapsperminute(lastownerteam) {
    if (!isdefined(self.capsperminute)) {
        self.numcaps = 0;
        self.capsperminute = 0;
    }
    if (lastownerteam == "neutral") {
        return;
    }
    self.numcaps++;
    minutespassed = globallogic_utils::gettimepassed() / 60000;
    if (isplayer(self) && isdefined(self.timeplayed["total"])) {
        minutespassed = self.timeplayed["total"] / 60;
    }
    self.capsperminute = self.numcaps / minutespassed;
    if (self.capsperminute > self.numcaps) {
        self.capsperminute = self.numcaps;
    }
}

// Namespace dom
// Params 2, eflags: 0x0
// Checksum 0xf23cf5f6, Offset: 0x4d40
// Size: 0x51
function isscoreboosting(player, flag) {
    if (!level.rankedmatch) {
        return false;
    }
    if (player.capsperminute > level.playercapturelpm) {
        return true;
    }
    if (flag.capsperminute > level.flagcapturelpm) {
        return true;
    }
    return false;
}

// Namespace dom
// Params 0, eflags: 0x0
// Checksum 0x50352827, Offset: 0x4da0
// Size: 0x96
function onupdateuserate() {
    if (!isdefined(self.contested)) {
        self.contested = 0;
    }
    numother = gameobjects::get_num_touching_except_team(self.ownerteam);
    numowners = self.numtouching[self.claimteam];
    previousstate = self.contested;
    if (numother > 0 && numowners > 0) {
        self.contested = 1;
        return;
    }
    if (previousstate == 1) {
        self notify(#"contest_over");
    }
    self.contested = 0;
}

