#using scripts/mp/teams/_teams;
#using scripts/mp/_util;
#using scripts/mp/_challenges;
#using scripts/mp/gametypes/_spawnlogic;
#using scripts/mp/gametypes/_spawning;
#using scripts/mp/gametypes/_hud_message;
#using scripts/mp/gametypes/_globallogic_utils;
#using scripts/mp/gametypes/_globallogic_score;
#using scripts/mp/gametypes/_globallogic_defaults;
#using scripts/mp/gametypes/_globallogic_audio;
#using scripts/mp/gametypes/_globallogic;
#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/sound_shared;
#using scripts/shared/scoreevents_shared;
#using scripts/shared/rank_shared;
#using scripts/shared/popups_shared;
#using scripts/shared/math_shared;
#using scripts/shared/hud_util_shared;
#using scripts/shared/hud_message_shared;
#using scripts/shared/gameobjects_shared;
#using scripts/shared/demo_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/challenges_shared;

#namespace ctf;

// Namespace ctf
// Params 0, eflags: 0x2
// Checksum 0xc2ecb0d4, Offset: 0xdc0
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("ctf", &__init__, undefined, undefined);
}

// Namespace ctf
// Params 0, eflags: 0x1 linked
// Checksum 0x872e2a9e, Offset: 0xe00
// Size: 0x34
function __init__() {
    clientfield::register("scriptmover", "ctf_flag_away", 1, 1, "int");
}

// Namespace ctf
// Params 0, eflags: 0x0
// Checksum 0x8f440284, Offset: 0xe40
// Size: 0x3e4
function main() {
    globallogic::init();
    util::registertimelimit(0, 1440);
    util::registerroundlimit(0, 10);
    util::registerroundwinlimit(0, 10);
    util::registerroundswitch(0, 9);
    util::registernumlives(0, 100);
    util::registerscorelimit(0, 5000);
    level.scoreroundwinbased = getgametypesetting("cumulativeRoundScores") == 0;
    level.flagcapturecondition = getgametypesetting("flagCaptureCondition");
    level.doubleovertime = 1;
    globallogic::registerfriendlyfiredelay(level.gametype, 15, 0, 1440);
    if (getdvarstring("scr_ctf_spawnPointFacingAngle") == "") {
        setdvar("scr_ctf_spawnPointFacingAngle", "0");
    }
    level.teambased = 1;
    level.overrideteamscore = 1;
    level.onstartgametype = &onstartgametype;
    level.onspawnplayer = &onspawnplayer;
    level.onprecachegametype = &onprecachegametype;
    level.onplayerkilled = &onplayerkilled;
    level.onroundswitch = &onroundswitch;
    level.onendgame = &onendgame;
    level.onroundendgame = &onroundendgame;
    level.getteamkillpenalty = &ctf_getteamkillpenalty;
    level.getteamkillscore = &ctf_getteamkillscore;
    level.var_d6911678 = &function_d6911678;
    level.shouldplayovertimeround = &shouldplayovertimeround;
    gameobjects::register_allowed_gameobject(level.gametype);
    if (!isdefined(game["ctf_teamscore_cache"])) {
        game["ctf_teamscore_cache"]["allies"] = 0;
        game["ctf_teamscore_cache"]["axis"] = 0;
    }
    globallogic_audio::set_leader_gametype_dialog("startCtf", "hcStartCtf", "objCapture", "objCapture");
    level.var_c2a60b96 = gettime();
    level thread ctf_icon_hide();
    if (!sessionmodeissystemlink() && !sessionmodeisonlinegame() && issplitscreen()) {
        globallogic::setvisiblescoreboardcolumns("score", "kills", "captures", "returns", "deaths");
        return;
    }
    globallogic::setvisiblescoreboardcolumns("score", "kills", "deaths", "captures", "returns");
}

// Namespace ctf
// Params 0, eflags: 0x1 linked
// Checksum 0xcd45d760, Offset: 0x1230
// Size: 0x4a
function onprecachegametype() {
    game["flag_dropped_sound"] = "mp_war_objective_lost";
    game["flag_recovered_sound"] = "mp_war_objective_taken";
    game["strings"]["score_limit_reached"] = %MP_CAP_LIMIT_REACHED;
}

// Namespace ctf
// Params 0, eflags: 0x1 linked
// Checksum 0x3ed468a2, Offset: 0x1288
// Size: 0x654
function onstartgametype() {
    if (!isdefined(game["switchedsides"])) {
        game["switchedsides"] = 0;
    }
    /#
        setdebugsideswitch(game["0"]);
    #/
    setclientnamemode("auto_change");
    globallogic_score::resetteamscores();
    util::setobjectivetext("allies", %OBJECTIVES_CTF);
    util::setobjectivetext("axis", %OBJECTIVES_CTF);
    if (level.splitscreen) {
        util::setobjectivescoretext("allies", %OBJECTIVES_CTF);
        util::setobjectivescoretext("axis", %OBJECTIVES_CTF);
    } else {
        util::setobjectivescoretext("allies", %OBJECTIVES_CTF_SCORE);
        util::setobjectivescoretext("axis", %OBJECTIVES_CTF_SCORE);
    }
    util::setobjectivehinttext("allies", %OBJECTIVES_CTF_HINT);
    util::setobjectivehinttext("axis", %OBJECTIVES_CTF_HINT);
    if (isdefined(game["overtime_round"])) {
        game["ctf_teamscore_cache"]["allies"] = game["ctf_teamscore_cache"]["allies"] + [[ level._getteamscore ]]("allies");
        game["ctf_teamscore_cache"]["axis"] = game["ctf_teamscore_cache"]["axis"] + [[ level._getteamscore ]]("axis");
        [[ level._setteamscore ]]("allies", 0);
        [[ level._setteamscore ]]("axis", 0);
        util::registerscorelimit(1, 1);
        if (isdefined(game["ctf_overtime_time_to_beat"])) {
            util::registertimelimit(game["ctf_overtime_time_to_beat"] / 60000, game["ctf_overtime_time_to_beat"] / 60000);
        }
        if (game["overtime_round"] == 1) {
            util::setobjectivehinttext("allies", %MP_CTF_OVERTIME_ROUND_1);
            util::setobjectivehinttext("axis", %MP_CTF_OVERTIME_ROUND_1);
        } else if (isdefined(game["ctf_overtime_first_winner"])) {
            util::setobjectivehinttext(game["ctf_overtime_first_winner"], %MP_CTF_OVERTIME_ROUND_2_WINNER);
            util::setobjectivehinttext(util::getotherteam(game["ctf_overtime_first_winner"]), %MP_CTF_OVERTIME_ROUND_2_LOSER);
        } else {
            util::setobjectivehinttext("allies", %MP_CTF_OVERTIME_ROUND_2_TIE);
            util::setobjectivehinttext("axis", %MP_CTF_OVERTIME_ROUND_2_TIE);
        }
    }
    spawning::create_map_placed_influencers();
    level.spawnmins = (0, 0, 0);
    level.spawnmaxs = (0, 0, 0);
    spawnlogic::place_spawn_points("mp_ctf_spawn_allies_start");
    spawnlogic::place_spawn_points("mp_ctf_spawn_axis_start");
    spawnlogic::add_spawn_points("allies", "mp_ctf_spawn_allies");
    spawnlogic::add_spawn_points("axis", "mp_ctf_spawn_axis");
    spawning::add_fallback_spawnpoints("allies", "mp_tdm_spawn");
    spawning::add_fallback_spawnpoints("axis", "mp_tdm_spawn");
    spawning::updateallspawnpoints();
    spawning::update_fallback_spawnpoints();
    level.mapcenter = math::find_box_center(level.spawnmins, level.spawnmaxs);
    setmapcenter(level.mapcenter);
    spawnpoint = spawnlogic::get_random_intermission_point();
    setdemointermissionpoint(spawnpoint.origin, spawnpoint.angles);
    level.spawn_axis = spawnlogic::get_spawnpoint_array("mp_ctf_spawn_axis");
    level.spawn_allies = spawnlogic::get_spawnpoint_array("mp_ctf_spawn_allies");
    level.spawn_start = [];
    foreach (team in level.teams) {
        level.spawn_start[team] = spawnlogic::get_spawnpoint_array("mp_ctf_spawn_" + team + "_start");
    }
    thread updategametypedvars();
    thread ctf();
}

// Namespace ctf
// Params 0, eflags: 0x1 linked
// Checksum 0x7d332bf, Offset: 0x18e8
// Size: 0x17c
function shouldplayovertimeround() {
    if (isdefined(game["overtime_round"])) {
        if (game["overtime_round"] == 1 || !level.gameended) {
            return true;
        }
        return false;
    }
    if (!level.scoreroundwinbased) {
        if (util::hitroundlimit() || game["teamScores"]["allies"] == game["teamScores"]["axis"] && game["teamScores"]["allies"] == level.scorelimit - 1) {
            return true;
        }
    } else {
        alliesroundswon = util::getroundswon("allies");
        axisroundswon = util::getroundswon("axis");
        if (level.roundwinlimit > 0 && axisroundswon == level.roundwinlimit - 1 && alliesroundswon == level.roundwinlimit - 1) {
            return true;
        }
        if (util::hitroundlimit() && alliesroundswon == axisroundswon) {
            return true;
        }
    }
    return false;
}

// Namespace ctf
// Params 1, eflags: 0x1 linked
// Checksum 0xa27fd30f, Offset: 0x1a70
// Size: 0xb4
function minutesandsecondsstring(milliseconds) {
    minutes = floor(milliseconds / 60000);
    milliseconds -= minutes * 60000;
    seconds = floor(milliseconds / 1000);
    if (seconds < 10) {
        return (minutes + ":0" + seconds);
    }
    return minutes + ":" + seconds;
}

// Namespace ctf
// Params 1, eflags: 0x1 linked
// Checksum 0x13825688, Offset: 0x1b30
// Size: 0x104
function function_d6911678(team) {
    if (!isdefined(game["overtime_round"])) {
        self hud_message::function_d6911678(team);
        return;
    }
    if (isdefined(game["ctf_overtime_second_winner"]) && game["ctf_overtime_second_winner"] == team) {
        self settext(minutesandsecondsstring(game["ctf_overtime_best_time"]));
        return;
    }
    if (isdefined(game["ctf_overtime_first_winner"]) && game["ctf_overtime_first_winner"] == team) {
        self settext(minutesandsecondsstring(game["ctf_overtime_time_to_beat"]));
        return;
    }
    self settext(%);
}

// Namespace ctf
// Params 0, eflags: 0x1 linked
// Checksum 0xdf07c697, Offset: 0x1c40
// Size: 0x4c
function onroundswitch() {
    if (!isdefined(game["switchedsides"])) {
        game["switchedsides"] = 0;
    }
    level.halftimetype = "halftime";
    game["switchedsides"] = !game["switchedsides"];
}

// Namespace ctf
// Params 1, eflags: 0x1 linked
// Checksum 0xe4f19988, Offset: 0x1c98
// Size: 0xa8
function onendgame(winningteam) {
    if (isdefined(game["overtime_round"])) {
        if (game["overtime_round"] == 1) {
            if (isdefined(winningteam) && winningteam != "tie") {
                game["ctf_overtime_first_winner"] = winningteam;
                game["ctf_overtime_time_to_beat"] = globallogic_utils::gettimepassed();
            }
            return;
        }
        game["ctf_overtime_second_winner"] = winningteam;
        game["ctf_overtime_best_time"] = globallogic_utils::gettimepassed();
    }
}

// Namespace ctf
// Params 0, eflags: 0x1 linked
// Checksum 0x11eb461b, Offset: 0x1d48
// Size: 0xa2
function updateteamscorebyroundswon() {
    if (level.scoreroundwinbased) {
        foreach (team in level.teams) {
            [[ level._setteamscore ]](team, game["roundswon"][team]);
        }
    }
}

// Namespace ctf
// Params 0, eflags: 0x1 linked
// Checksum 0x975d7a77, Offset: 0x1df8
// Size: 0xba
function updateteamscorebyflagscaptured() {
    if (level.scoreroundwinbased) {
        return;
    }
    foreach (team in level.teams) {
        [[ level._setteamscore ]](team, [[ level._getteamscore ]](team) + game["ctf_teamscore_cache"][team]);
    }
}

// Namespace ctf
// Params 1, eflags: 0x1 linked
// Checksum 0x2e99e5d9, Offset: 0x1ec0
// Size: 0x254
function onroundendgame(winningteam) {
    if (isdefined(game["overtime_round"])) {
        if (isdefined(game["ctf_overtime_first_winner"])) {
            if (!isdefined(winningteam) || winningteam == "tie") {
                winningteam = game["ctf_overtime_first_winner"];
            }
            if (game["ctf_overtime_first_winner"] == winningteam) {
                level.endvictoryreasontext = %MPUI_CTF_OVERTIME_FASTEST_CAP_TIME;
                level.enddefeatreasontext = %MPUI_CTF_OVERTIME_DEFEAT_TIMELIMIT;
            } else {
                level.endvictoryreasontext = %MPUI_CTF_OVERTIME_FASTEST_CAP_TIME;
                level.enddefeatreasontext = %MPUI_CTF_OVERTIME_DEFEAT_DID_NOT_DEFEND;
            }
        } else if (!isdefined(winningteam) || winningteam == "tie") {
            if (level.scoreroundwinbased) {
                updateteamscorebyroundswon();
            } else {
                updateteamscorebyflagscaptured();
            }
            return "tie";
        }
        if (level.scoreroundwinbased) {
            foreach (team in level.teams) {
                score = game["roundswon"][team];
                if (team === winningteam) {
                    score++;
                }
                [[ level._setteamscore ]](team, score);
            }
        } else {
            updateteamscorebyflagscaptured();
        }
        return winningteam;
    }
    if (level.scoreroundwinbased) {
        updateteamscorebyroundswon();
        winner = globallogic::determineteamwinnerbygamestat("roundswon");
    } else {
        winner = globallogic::determineteamwinnerbyteamscore();
    }
    return winner;
}

// Namespace ctf
// Params 1, eflags: 0x1 linked
// Checksum 0x55f5d8a9, Offset: 0x2120
// Size: 0x5c
function onspawnplayer(predictedspawn) {
    self.isflagcarrier = 0;
    self.flagcarried = undefined;
    self clientfield::set("ctf_flag_carrier", 0);
    spawning::onspawnplayer(predictedspawn);
}

// Namespace ctf
// Params 0, eflags: 0x1 linked
// Checksum 0x82b24fc6, Offset: 0x2188
// Size: 0x160
function updategametypedvars() {
    level.flagcapturetime = getgametypesetting("captureTime");
    level.flagtouchreturntime = getgametypesetting("defuseTime");
    level.idleflagreturntime = getgametypesetting("idleFlagResetTime");
    level.flagrespawntime = getgametypesetting("flagRespawnTime");
    level.enemycarriervisible = getgametypesetting("enemyCarrierVisible");
    level.roundlimit = getgametypesetting("roundLimit");
    level.cumulativeroundscores = getgametypesetting("cumulativeRoundScores");
    level.teamkillpenaltymultiplier = getgametypesetting("teamKillPenalty");
    level.teamkillscoremultiplier = getgametypesetting("teamKillScore");
    if (level.flagtouchreturntime >= 0 && level.flagtouchreturntime != 63) {
        level.touchreturn = 1;
        return;
    }
    level.touchreturn = 0;
}

// Namespace ctf
// Params 1, eflags: 0x1 linked
// Checksum 0xbf59f2a7, Offset: 0x22f0
// Size: 0x3ba
function createflag(trigger) {
    if (isdefined(trigger.target)) {
        visuals[0] = getent(trigger.target, "targetname");
    } else {
        visuals[0] = spawn("script_model", trigger.origin);
        visuals[0].angles = trigger.angles;
    }
    entityteam = trigger.script_team;
    if (game["switchedsides"]) {
        entityteam = util::getotherteam(entityteam);
    }
    visuals[0] setmodel(teams::get_flag_model(entityteam));
    visuals[0] setteam(entityteam);
    flag = gameobjects::create_carry_object(entityteam, trigger, visuals, (0, 0, 100), istring(entityteam + "_flag"));
    flag gameobjects::set_team_use_time("friendly", level.flagtouchreturntime);
    flag gameobjects::set_team_use_time("enemy", level.flagcapturetime);
    flag gameobjects::allow_carry("enemy");
    flag gameobjects::set_visible_team("any");
    flag gameobjects::set_visible_carrier_model(teams::get_flag_carry_model(entityteam));
    flag gameobjects::set_2d_icon("friendly", level.icondefend2d);
    flag gameobjects::set_3d_icon("friendly", level.icondefend3d);
    flag gameobjects::set_2d_icon("enemy", level.iconcapture2d);
    flag gameobjects::set_3d_icon("enemy", level.iconcapture3d);
    if (level.enemycarriervisible == 2) {
        flag.objidpingfriendly = 1;
    }
    flag.allowweapons = 1;
    flag.onpickup = &onpickup;
    flag.onpickupfailed = &onpickup;
    flag.ondrop = &ondrop;
    flag.onreset = &onreset;
    if (level.idleflagreturntime > 0) {
        flag.autoresettime = level.idleflagreturntime;
    } else {
        flag.autoresettime = undefined;
    }
    return flag;
}

// Namespace ctf
// Params 1, eflags: 0x1 linked
// Checksum 0x2ec9b328, Offset: 0x26b8
// Size: 0x1e8
function createflagzone(trigger) {
    visuals = [];
    entityteam = trigger.script_team;
    if (game["switchedsides"]) {
        entityteam = util::getotherteam(entityteam);
    }
    flagzone = gameobjects::create_use_object(entityteam, trigger, visuals, (0, 0, 0), istring(entityteam + "_base"));
    flagzone gameobjects::allow_use("friendly");
    flagzone gameobjects::set_use_time(0);
    flagzone gameobjects::set_use_text(%MP_CAPTURING_FLAG);
    flagzone gameobjects::set_visible_team("friendly");
    enemyteam = util::getotherteam(entityteam);
    flagzone gameobjects::set_key_object(level.teamflags[enemyteam]);
    flagzone.onuse = &oncapture;
    flag = level.teamflags[entityteam];
    flag.flagbase = flagzone;
    flagzone.flag = flag;
    flagzone createflagspawninfluencer(entityteam);
    return flagzone;
}

// Namespace ctf
// Params 2, eflags: 0x1 linked
// Checksum 0xacb8e8c8, Offset: 0x28a8
// Size: 0xd0
function createflaghint(team, origin) {
    radius = -128;
    height = 64;
    trigger = spawn("trigger_radius", origin, 0, radius, height);
    trigger sethintstring(%MP_CTF_CANT_CAPTURE_FLAG);
    trigger setcursorhint("HINT_NOICON");
    trigger.original_origin = origin;
    trigger turn_off();
    return trigger;
}

// Namespace ctf
// Params 0, eflags: 0x1 linked
// Checksum 0x170796c3, Offset: 0x2980
// Size: 0x304
function ctf() {
    level.flags = [];
    level.teamflags = [];
    level.flagzones = [];
    level.teamflagzones = [];
    flag_triggers = getentarray("ctf_flag_pickup_trig", "targetname");
    if (!isdefined(flag_triggers) || flag_triggers.size != 2) {
        /#
            util::error("0");
        #/
        return;
    }
    for (index = 0; index < flag_triggers.size; index++) {
        trigger = flag_triggers[index];
        flag = createflag(trigger);
        team = flag gameobjects::get_owner_team();
        level.flags[level.flags.size] = flag;
        level.teamflags[team] = flag;
    }
    flag_zones = getentarray("ctf_flag_zone_trig", "targetname");
    if (!isdefined(flag_zones) || flag_zones.size != 2) {
        /#
            util::error("0");
        #/
        return;
    }
    for (index = 0; index < flag_zones.size; index++) {
        trigger = flag_zones[index];
        flagzone = createflagzone(trigger);
        team = flagzone gameobjects::get_owner_team();
        level.flagzones[level.flagzones.size] = flagzone;
        level.teamflagzones[team] = flagzone;
        level.flaghints[team] = createflaghint(team, trigger.origin);
        facing_angle = getdvarint("scr_ctf_spawnPointFacingAngle");
        setspawnpointsbaseweight(util::getotherteamsmask(team), trigger.origin, facing_angle, level.spawnsystem.objective_facing_bonus);
    }
    function_2c0ba61c();
}

// Namespace ctf
// Params 0, eflags: 0x1 linked
// Checksum 0x80a5c1a5, Offset: 0x2c90
// Size: 0x6c
function ctf_icon_hide() {
    level waittill(#"game_ended");
    level.teamflags["allies"] gameobjects::set_visible_team("none");
    level.teamflags["axis"] gameobjects::set_visible_team("none");
}

// Namespace ctf
// Params 0, eflags: 0x1 linked
// Checksum 0x2a814fe7, Offset: 0x2d08
// Size: 0xa6
function removeinfluencers() {
    if (isdefined(self.spawn_influencer_enemy_carrier)) {
        self spawning::remove_influencer(self.spawn_influencer_enemy_carrier);
        self.spawn_influencer_enemy_carrier = undefined;
    }
    if (isdefined(self.spawn_influencer_friendly_carrier)) {
        self spawning::remove_influencer(self.spawn_influencer_friendly_carrier);
        self.spawn_influencer_friendly_carrier = undefined;
    }
    if (isdefined(self.spawn_influencer_dropped)) {
        self.trigger spawning::remove_influencer(self.spawn_influencer_dropped);
        self.spawn_influencer_dropped = undefined;
    }
}

// Namespace ctf
// Params 1, eflags: 0x1 linked
// Checksum 0x7a5b67d2, Offset: 0x2db8
// Size: 0x554
function ondrop(player) {
    origin = (0, 0, 0);
    if (isdefined(player)) {
        player clientfield::set("ctf_flag_carrier", 0);
        origin = player.origin;
    }
    team = self gameobjects::get_owner_team();
    otherteam = util::getotherteam(team);
    bbprint("mpobjective", "gametime %d objtype %s team %s playerx %d playery %d playerz %d", gettime(), "ctf_flagdropped", team, origin);
    self.visuals[0] clientfield::set("ctf_flag_away", 1);
    if (level.touchreturn) {
        self gameobjects::allow_carry("any");
        level.flaghints[otherteam] turn_off();
    }
    if (isdefined(player)) {
        util::printandsoundoneveryone(team, undefined, %, undefined, "mp_war_objective_lost");
        level thread popups::displayteammessagetoteam(%MP_FRIENDLY_FLAG_DROPPED, player, team);
        level thread popups::displayteammessagetoteam(%MP_ENEMY_FLAG_DROPPED, player, otherteam);
    } else {
        util::printandsoundoneveryone(team, undefined, %, undefined, "mp_war_objective_lost");
    }
    globallogic_audio::leader_dialog("ctfFriendlyFlagDropped", team, undefined, "ctf_flag");
    globallogic_audio::leader_dialog("ctfEnemyFlagDropped", otherteam, undefined, "ctf_flag_enemy");
    /#
        if (isdefined(player)) {
            print(team + "0");
        } else {
            print(team + "0");
        }
    #/
    if (isdefined(player)) {
        player playlocalsound("mpl_flag_drop_plr");
    }
    globallogic_audio::play_2d_on_team("mpl_flagdrop_sting_friend", otherteam);
    globallogic_audio::play_2d_on_team("mpl_flagdrop_sting_enemy", team);
    if (level.touchreturn) {
        self gameobjects::set_3d_icon("friendly", level.iconreturn3d);
        self gameobjects::set_2d_icon("friendly", level.iconreturn2d);
    } else {
        self gameobjects::set_3d_icon("friendly", level.icondropped3d);
        self gameobjects::set_2d_icon("friendly", level.icondropped2d);
    }
    self gameobjects::set_visible_team("any");
    self gameobjects::set_3d_icon("enemy", level.iconcapture3d);
    self gameobjects::set_2d_icon("enemy", level.iconcapture2d);
    thread sound::play_on_players(game["flag_dropped_sound"], game["attackers"]);
    self thread function_2afd3059(level.idleflagreturntime);
    if (isdefined(player)) {
        player removeinfluencers();
    }
    ss = level.spawnsystem;
    player_team_mask = util::getteammask(otherteam);
    enemy_team_mask = util::getteammask(team);
    if (isdefined(player)) {
        var_fea0b904 = player.origin;
    } else {
        var_fea0b904 = self.curorigin;
    }
    self.spawn_influencer_dropped = self.trigger spawning::create_entity_influencer("ctf_flag_dropped", player_team_mask | enemy_team_mask);
    setinfluencertimeout(self.spawn_influencer_dropped, level.idleflagreturntime);
}

// Namespace ctf
// Params 1, eflags: 0x1 linked
// Checksum 0x96f0e0ef, Offset: 0x3318
// Size: 0x838
function onpickup(player) {
    carrierkilledby = self.carrierkilledby;
    self.carrierkilledby = undefined;
    if (isdefined(self.spawn_influencer_dropped)) {
        self.trigger spawning::remove_influencer(self.spawn_influencer_dropped);
        self.spawn_influencer_dropped = undefined;
    }
    player addplayerstatwithgametype("PICKUPS", 1);
    if (level.touchreturn) {
        self gameobjects::allow_carry("enemy");
    }
    self removeinfluencers();
    team = self gameobjects::get_owner_team();
    otherteam = util::getotherteam(team);
    self function_34d1619d();
    if (isdefined(player) && player.pers["team"] == team) {
        self notify(#"picked_up");
        util::printandsoundoneveryone(team, undefined, %, undefined, "mp_obj_returned");
        if (isdefined(player.pers["returns"])) {
            player.pers["returns"]++;
            player.returns = player.pers["returns"];
        }
        if (isdefined(carrierkilledby) && carrierkilledby == player) {
            scoreevents::processscoreevent("flag_carrier_kill_return_close", player);
        } else if (distancesquared(self.trigger.baseorigin, player.origin) > 90000) {
            scoreevents::processscoreevent("flag_return", player);
        }
        demo::bookmark("event", gettime(), player);
        player addplayerstatwithgametype("RETURNS", 1);
        level thread popups::displayteammessagetoteam(%MP_FRIENDLY_FLAG_RETURNED, player, team);
        level thread popups::displayteammessagetoteam(%MP_ENEMY_FLAG_RETURNED, player, otherteam);
        self.visuals[0] clientfield::set("ctf_flag_away", 0);
        self gameobjects::set_flags(0);
        bbprint("mpobjective", "gametime %d objtype %s team %s playerx %d playery %d playerz %d", gettime(), "ctf_flagreturn", team, player.origin);
        player recordgameevent("return");
        self returnflag();
        /#
            if (isdefined(player)) {
                print(team + "0");
                return;
            }
            print(team + "0");
        #/
        return;
    }
    bbprint("mpobjective", "gametime %d objtype %s team %s playerx %d playery %d playerz %d", gettime(), "ctf_flagpickup", team, player.origin);
    player recordgameevent("pickup");
    scoreevents::processscoreevent("flag_grab", player);
    demo::bookmark("event", gettime(), player);
    util::printandsoundoneveryone(otherteam, undefined, %, undefined, "mp_obj_taken", "mp_enemy_obj_taken");
    level thread popups::displayteammessagetoteam(%MP_FRIENDLY_FLAG_TAKEN, player, team);
    level thread popups::displayteammessagetoteam(%MP_ENEMY_FLAG_TAKEN, player, otherteam);
    globallogic_audio::leader_dialog("ctfFriendlyFlagTaken", team, undefined, "ctf_flag");
    globallogic_audio::leader_dialog("ctfEnemyFlagTaken", otherteam, undefined, "ctf_flag_enemy");
    player.isflagcarrier = 1;
    player.flagcarried = self;
    player playlocalsound("mpl_flag_pickup_plr");
    player clientfield::set("ctf_flag_carrier", 1);
    self gameobjects::set_flags(1);
    globallogic_audio::play_2d_on_team("mpl_flagget_sting_friend", otherteam);
    globallogic_audio::play_2d_on_team("mpl_flagget_sting_enemy", team);
    if (level.enemycarriervisible) {
        self gameobjects::set_visible_team("any");
    } else {
        self gameobjects::set_visible_team("enemy");
    }
    self gameobjects::set_2d_icon("friendly", level.iconkill2d);
    self gameobjects::set_3d_icon("friendly", level.iconkill3d);
    self gameobjects::set_2d_icon("enemy", level.iconescort2d);
    self gameobjects::set_3d_icon("enemy", level.iconescort3d);
    player thread claim_trigger(level.flaghints[otherteam]);
    update_hints();
    player resetflashback();
    /#
        print(team + "0");
    #/
    ss = level.spawnsystem;
    player_team_mask = util::getteammask(otherteam);
    enemy_team_mask = util::getteammask(team);
    player.spawn_influencer_friendly_carrier = player spawning::create_entity_masked_friendly_influencer("ctf_carrier_friendly", player_team_mask);
    player.spawn_influencer_enemy_carrier = player spawning::create_entity_masked_enemy_influencer("ctf_carrier_enemy", enemy_team_mask);
}

// Namespace ctf
// Params 1, eflags: 0x0
// Checksum 0xa369596a, Offset: 0x3b58
// Size: 0x3a
function onpickupmusicstate(player) {
    self endon(#"disconnect");
    self endon(#"death");
    wait(6);
    if (player.isflagcarrier) {
    }
}

// Namespace ctf
// Params 0, eflags: 0x0
// Checksum 0x7c5498a2, Offset: 0x3ba0
// Size: 0x38
function ishome() {
    if (isdefined(self.carrier)) {
        return false;
    }
    if (self.curorigin != self.trigger.baseorigin) {
        return false;
    }
    return true;
}

// Namespace ctf
// Params 0, eflags: 0x1 linked
// Checksum 0xa57cc9f9, Offset: 0x3be0
// Size: 0x234
function returnflag() {
    team = self gameobjects::get_owner_team();
    otherteam = util::getotherteam(team);
    globallogic_audio::play_2d_on_team("mpl_flagreturn_sting", team);
    globallogic_audio::play_2d_on_team("mpl_flagreturn_sting", otherteam);
    level.teamflagzones[otherteam] gameobjects::allow_use("friendly");
    level.teamflagzones[otherteam] gameobjects::set_visible_team("friendly");
    update_hints();
    if (level.touchreturn) {
        self gameobjects::allow_carry("enemy");
    }
    self gameobjects::return_home();
    self gameobjects::set_visible_team("any");
    self gameobjects::set_3d_icon("friendly", level.icondefend3d);
    self gameobjects::set_2d_icon("friendly", level.icondefend2d);
    self gameobjects::set_3d_icon("enemy", level.iconcapture3d);
    self gameobjects::set_2d_icon("enemy", level.iconcapture2d);
    globallogic_audio::leader_dialog("ctfFriendlyFlagReturned", team, undefined, "ctf_flag");
    globallogic_audio::leader_dialog("ctfEnemyFlagReturned", otherteam, undefined, "ctf_flag_enemy");
}

// Namespace ctf
// Params 1, eflags: 0x1 linked
// Checksum 0x46b6711b, Offset: 0x3e20
// Size: 0x4c4
function oncapture(player) {
    team = player.pers["team"];
    enemyteam = util::getotherteam(team);
    time = gettime();
    playerteamsflag = level.teamflags[team];
    if (level.flagcapturecondition == 1 && playerteamsflag gameobjects::is_object_away_from_home()) {
        return;
    }
    if (!isdefined(player.carryobject)) {
        return;
    }
    util::printandsoundoneveryone(team, undefined, %, undefined, "mp_obj_captured", "mp_enemy_obj_captured");
    bbprint("mpobjective", "gametime %d objtype %s team %s playerx %d playery %d playerz %d", time, "ctf_flagcapture", enemyteam, player.origin);
    game["challenge"][team]["capturedFlag"] = 1;
    if (isdefined(player.pers["captures"])) {
        player.pers["captures"]++;
        player.captures = player.pers["captures"];
    }
    demo::bookmark("event", gettime(), player);
    player addplayerstatwithgametype("CAPTURES", 1);
    level thread popups::displayteammessagetoteam(%MP_ENEMY_FLAG_CAPTURED, player, team);
    level thread popups::displayteammessagetoteam(%MP_FRIENDLY_FLAG_CAPTURED, player, enemyteam);
    globallogic_audio::play_2d_on_team("mpl_flagcapture_sting_enemy", enemyteam);
    globallogic_audio::play_2d_on_team("mpl_flagcapture_sting_friend", team);
    player giveflagcapturexp(player);
    /#
        print(enemyteam + "0");
    #/
    flag = player.carryobject;
    player challenges::capturedobjective(time, flag.trigger);
    flag.dontannouncereturn = 1;
    flag gameobjects::return_home();
    flag.dontannouncereturn = undefined;
    otherteam = util::getotherteam(team);
    level.teamflags[otherteam] gameobjects::allow_carry("enemy");
    level.teamflags[otherteam] gameobjects::set_visible_team("any");
    level.teamflags[otherteam] gameobjects::return_home();
    level.teamflagzones[otherteam] gameobjects::allow_use("friendly");
    player.isflagcarrier = 0;
    player.flagcarried = undefined;
    player clientfield::set("ctf_flag_carrier", 0);
    globallogic_score::giveteamscoreforobjective(team, 1);
    globallogic_audio::leader_dialog("ctfEnemyFlagCaptured", team, undefined, "ctf_flag_enemy");
    globallogic_audio::leader_dialog("ctfFriendlyFlagCaptured", enemyteam, undefined, "ctf_flag");
    flag removeinfluencers();
    player removeinfluencers();
}

// Namespace ctf
// Params 1, eflags: 0x1 linked
// Checksum 0x95ebc87, Offset: 0x42f0
// Size: 0x4c
function giveflagcapturexp(player) {
    scoreevents::processscoreevent("flag_capture", player);
    player recordgameevent("capture");
}

// Namespace ctf
// Params 0, eflags: 0x1 linked
// Checksum 0x1e87b808, Offset: 0x4348
// Size: 0x1bc
function onreset() {
    update_hints();
    team = self gameobjects::get_owner_team();
    self gameobjects::set_3d_icon("friendly", level.icondefend3d);
    self gameobjects::set_2d_icon("friendly", level.icondefend2d);
    self gameobjects::set_3d_icon("enemy", level.iconcapture3d);
    self gameobjects::set_2d_icon("enemy", level.iconcapture2d);
    if (level.touchreturn) {
        self gameobjects::allow_carry("enemy");
    }
    level.teamflagzones[team] gameobjects::set_visible_team("friendly");
    level.teamflagzones[team] gameobjects::allow_use("friendly");
    self.visuals[0] clientfield::set("ctf_flag_away", 0);
    self gameobjects::set_flags(0);
    self function_34d1619d();
    self removeinfluencers();
}

// Namespace ctf
// Params 1, eflags: 0x0
// Checksum 0xb5e286db, Offset: 0x4510
// Size: 0x3c
function getotherflag(flag) {
    if (flag == level.flags[0]) {
        return level.flags[1];
    }
    return level.flags[0];
}

// Namespace ctf
// Params 9, eflags: 0x1 linked
// Checksum 0x68a4c20b, Offset: 0x4558
// Size: 0x884
function onplayerkilled(einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime, deathanimduration) {
    if (isdefined(attacker) && isplayer(attacker)) {
        for (index = 0; index < level.flags.size; index++) {
            flagteam = "invalidTeam";
            inflagradius = 0;
            defendedflag = 0;
            offendedflag = 0;
            flagcarrier = level.flags[index].carrier;
            if (isdefined(flagcarrier)) {
                flagorigin = level.flags[index].carrier.origin;
                iscarried = 1;
                if (isplayer(attacker) && attacker.pers["team"] != self.pers["team"]) {
                    if (isdefined(level.flags[index].carrier.attackerdata)) {
                        if (level.flags[index].carrier != attacker) {
                            if (isdefined(level.flags[index].carrier.attackerdata[self.clientid])) {
                                scoreevents::processscoreevent("rescue_flag_carrier", attacker, undefined, weapon);
                            }
                        }
                    }
                }
            } else {
                flagorigin = level.flags[index].curorigin;
                iscarried = 0;
            }
            dist = distance2dsquared(self.origin, flagorigin);
            if (dist < level.defaultoffenseradiussq) {
                inflagradius = 1;
                if (level.flags[index].ownerteam == attacker.pers["team"]) {
                    defendedflag = 1;
                } else {
                    offendedflag = 1;
                }
            }
            dist = distance2dsquared(attacker.origin, flagorigin);
            if (dist < level.defaultoffenseradiussq) {
                inflagradius = 1;
                if (level.flags[index].ownerteam == attacker.pers["team"]) {
                    defendedflag = 1;
                } else {
                    offendedflag = 1;
                }
            }
            if (inflagradius && isplayer(attacker) && attacker.pers["team"] != self.pers["team"]) {
                if (defendedflag) {
                    if (isdefined(self.isflagcarrier) && self.isflagcarrier) {
                        scoreevents::processscoreevent("kill_flag_carrier", attacker, undefined, weapon);
                        attacker addplayerstat("kill_carrier", 1);
                    } else {
                        scoreevents::processscoreevent("killed_attacker", attacker, undefined, weapon);
                    }
                    self recordkillmodifier("assaulting");
                }
                if (offendedflag) {
                    if (iscarried == 1) {
                        if (isdefined(flagcarrier) && attacker == flagcarrier) {
                            scoreevents::processscoreevent("killed_enemy_while_carrying_flag", attacker, undefined, weapon);
                        } else {
                            scoreevents::processscoreevent("defend_flag_carrier", attacker, undefined, weapon);
                            attacker addplayerstat("defend_carrier", 1);
                        }
                    } else {
                        scoreevents::processscoreevent("killed_defender", attacker, undefined, weapon);
                    }
                    self recordkillmodifier("defending");
                }
            }
        }
        victim = self;
        foreach (flag_zone in level.flagzones) {
            if (isdefined(attacker.team) && attacker != victim && isdefined(victim.team)) {
                dist_to_zone_origin = distance2dsquared(attacker.origin, flag_zone.origin);
                victim_dist_to_zone_origin = distance2dsquared(victim.origin, flag_zone.origin);
                if (victim_dist_to_zone_origin < level.defaultoffenseradiussq || dist_to_zone_origin < level.defaultoffenseradiussq) {
                    if (victim.team == flag_zone.team) {
                        attacker thread challenges::killedbasedefender(flag_zone.trigger);
                        continue;
                    }
                    attacker thread challenges::killedbaseoffender(flag_zone.trigger, weapon);
                }
            }
        }
    }
    if (!isdefined(self.isflagcarrier) || !self.isflagcarrier) {
        return;
    }
    if (isdefined(attacker) && isplayer(attacker) && attacker.pers["team"] != self.pers["team"]) {
        if (isdefined(self.flagcarried)) {
            for (index = 0; index < level.flags.size; index++) {
                currentflag = level.flags[index];
                if (currentflag.ownerteam == self.team) {
                    if (currentflag.curorigin == currentflag.trigger.baseorigin) {
                        dist = distance2dsquared(self.origin, currentflag.curorigin);
                        if (dist < level.defaultoffenseradiussq) {
                            self.flagcarried.carrierkilledby = attacker;
                            break;
                        }
                    }
                }
            }
        }
        attacker recordgameevent("kill_carrier");
        self recordkillmodifier("carrying");
    }
}

// Namespace ctf
// Params 0, eflags: 0x1 linked
// Checksum 0xa0ef27bb, Offset: 0x4de8
// Size: 0x430
function function_2c0ba61c() {
    level.var_5d0c9f44 = [];
    level.var_5d0c9f44["allies"]["axis"] = hud::createservertimer("objective", 1.4, "allies");
    level.var_5d0c9f44["allies"]["axis"] hud::setpoint("TOPRIGHT", "TOPRIGHT", 0, 0);
    level.var_5d0c9f44["allies"]["axis"].label = %MP_ENEMY_FLAG_RETURNING_IN;
    level.var_5d0c9f44["allies"]["axis"].alpha = 0;
    level.var_5d0c9f44["allies"]["axis"].archived = 0;
    level.var_5d0c9f44["allies"]["allies"] = hud::createservertimer("objective", 1.4, "allies");
    level.var_5d0c9f44["allies"]["allies"] hud::setpoint("TOPRIGHT", "TOPRIGHT", 0, 20);
    level.var_5d0c9f44["allies"]["allies"].label = %MP_YOUR_FLAG_RETURNING_IN;
    level.var_5d0c9f44["allies"]["allies"].alpha = 0;
    level.var_5d0c9f44["allies"]["allies"].archived = 0;
    level.var_5d0c9f44["axis"]["allies"] = hud::createservertimer("objective", 1.4, "axis");
    level.var_5d0c9f44["axis"]["allies"] hud::setpoint("TOPRIGHT", "TOPRIGHT", 0, 0);
    level.var_5d0c9f44["axis"]["allies"].label = %MP_ENEMY_FLAG_RETURNING_IN;
    level.var_5d0c9f44["axis"]["allies"].alpha = 0;
    level.var_5d0c9f44["axis"]["allies"].archived = 0;
    level.var_5d0c9f44["axis"]["axis"] = hud::createservertimer("objective", 1.4, "axis");
    level.var_5d0c9f44["axis"]["axis"] hud::setpoint("TOPRIGHT", "TOPRIGHT", 0, 20);
    level.var_5d0c9f44["axis"]["axis"].label = %MP_YOUR_FLAG_RETURNING_IN;
    level.var_5d0c9f44["axis"]["axis"].alpha = 0;
    level.var_5d0c9f44["axis"]["axis"].archived = 0;
}

// Namespace ctf
// Params 1, eflags: 0x1 linked
// Checksum 0x1aae35a1, Offset: 0x5220
// Size: 0xa0
function function_2afd3059(time) {
    if (level.touchreturn || level.idleflagreturntime == 0) {
        return;
    }
    self notify(#"hash_2afd3059");
    self endon(#"hash_2afd3059");
    result = function_5badced4(time);
    self removeinfluencers();
    self function_34d1619d();
    if (!isdefined(result)) {
        return;
    }
}

// Namespace ctf
// Params 1, eflags: 0x1 linked
// Checksum 0xbbae85d9, Offset: 0x52c8
// Size: 0x172
function function_5badced4(time) {
    self endon(#"picked_up");
    level endon(#"game_ended");
    ownerteam = self gameobjects::get_owner_team();
    /#
        assert(!level.var_5d0c9f44["0"][ownerteam].alpha);
    #/
    level.var_5d0c9f44["axis"][ownerteam].alpha = 1;
    level.var_5d0c9f44["axis"][ownerteam] settimer(time);
    /#
        assert(!level.var_5d0c9f44["0"][ownerteam].alpha);
    #/
    level.var_5d0c9f44["allies"][ownerteam].alpha = 1;
    level.var_5d0c9f44["allies"][ownerteam] settimer(time);
    if (time <= 0) {
        return false;
    } else {
        wait(time);
    }
    return true;
}

// Namespace ctf
// Params 0, eflags: 0x1 linked
// Checksum 0xce43d142, Offset: 0x5448
// Size: 0x70
function function_34d1619d() {
    ownerteam = self gameobjects::get_owner_team();
    level.var_5d0c9f44["allies"][ownerteam].alpha = 0;
    level.var_5d0c9f44["axis"][ownerteam].alpha = 0;
}

// Namespace ctf
// Params 0, eflags: 0x1 linked
// Checksum 0xba78765b, Offset: 0x54c0
// Size: 0x20
function turn_on() {
    if (level.hardcoremode) {
        return;
    }
    self.origin = self.original_origin;
}

// Namespace ctf
// Params 0, eflags: 0x1 linked
// Checksum 0x99c5b95e, Offset: 0x54e8
// Size: 0x3c
function turn_off() {
    self.origin = (self.original_origin[0], self.original_origin[1], self.original_origin[2] - 10000);
}

// Namespace ctf
// Params 0, eflags: 0x1 linked
// Checksum 0x9e455d93, Offset: 0x5530
// Size: 0x144
function update_hints() {
    allied_flag = level.teamflags["allies"];
    axis_flag = level.teamflags["axis"];
    if (!level.touchreturn) {
        return;
    }
    if (isdefined(allied_flag.carrier) && axis_flag gameobjects::is_object_away_from_home()) {
        level.flaghints["axis"] turn_on();
    } else {
        level.flaghints["axis"] turn_off();
    }
    if (isdefined(axis_flag.carrier) && allied_flag gameobjects::is_object_away_from_home()) {
        level.flaghints["allies"] turn_on();
        return;
    }
    level.flaghints["allies"] turn_off();
}

// Namespace ctf
// Params 1, eflags: 0x1 linked
// Checksum 0x655a3aac, Offset: 0x5680
// Size: 0x54
function claim_trigger(trigger) {
    self endon(#"disconnect");
    self clientclaimtrigger(trigger);
    self waittill(#"drop_object");
    self clientreleasetrigger(trigger);
}

// Namespace ctf
// Params 1, eflags: 0x1 linked
// Checksum 0x7de0980e, Offset: 0x56e0
// Size: 0xe4
function createflagspawninfluencer(entityteam) {
    otherteam = util::getotherteam(entityteam);
    team_mask = util::getteammask(entityteam);
    other_team_mask = util::getteammask(otherteam);
    self.spawn_influencer_friendly = self spawning::create_influencer("ctf_base_friendly", self.trigger.origin, team_mask);
    self.spawn_influencer_enemy = self spawning::create_influencer("ctf_base_friendly", self.trigger.origin, other_team_mask);
}

// Namespace ctf
// Params 4, eflags: 0x1 linked
// Checksum 0x4d9198f, Offset: 0x57d0
// Size: 0x7e
function ctf_getteamkillpenalty(einflictor, attacker, smeansofdeath, weapon) {
    teamkill_penalty = globallogic_defaults::default_getteamkillpenalty(einflictor, attacker, smeansofdeath, weapon);
    if (isdefined(self.isflagcarrier) && self.isflagcarrier) {
        teamkill_penalty *= level.teamkillpenaltymultiplier;
    }
    return teamkill_penalty;
}

// Namespace ctf
// Params 4, eflags: 0x1 linked
// Checksum 0x78675d57, Offset: 0x5858
// Size: 0x8a
function ctf_getteamkillscore(einflictor, attacker, smeansofdeath, weapon) {
    teamkill_score = rank::getscoreinfovalue("kill");
    if (isdefined(self.isflagcarrier) && self.isflagcarrier) {
        teamkill_score *= level.teamkillscoremultiplier;
    }
    return int(teamkill_score);
}

