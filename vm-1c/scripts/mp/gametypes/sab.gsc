#using scripts/mp/_util;
#using scripts/mp/_challenges;
#using scripts/mp/gametypes/_spawnlogic;
#using scripts/mp/gametypes/_spawning;
#using scripts/mp/gametypes/_hud_message;
#using scripts/mp/gametypes/_hostmigration;
#using scripts/mp/gametypes/_globallogic_utils;
#using scripts/mp/gametypes/_globallogic_score;
#using scripts/mp/gametypes/_globallogic_audio;
#using scripts/mp/gametypes/_globallogic;
#using scripts/mp/gametypes/_battlechatter;
#using scripts/shared/sound_shared;
#using scripts/shared/scoreevents_shared;
#using scripts/shared/popups_shared;
#using scripts/shared/medals_shared;
#using scripts/shared/math_shared;
#using scripts/shared/hud_message_shared;
#using scripts/shared/hostmigration_shared;
#using scripts/shared/gameobjects_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/demo_shared;

#namespace sab;

// Namespace sab
// Params 0, eflags: 0x0
// Checksum 0x587c85a1, Offset: 0xba0
// Size: 0x48c
function main() {
    globallogic::init();
    level.teambased = 1;
    level.overrideteamscore = 1;
    util::registerroundswitch(0, 9);
    util::registertimelimit(0, 1440);
    util::registerscorelimit(0, 500);
    util::registerroundlimit(0, 10);
    util::registernumlives(0, 100);
    util::registerroundwinlimit(0, 10);
    globallogic::registerfriendlyfiredelay(level.gametype, 15, 0, 1440);
    level.onstartgametype = &onstartgametype;
    level.onspawnplayer = &onspawnplayer;
    level.onroundendgame = &onroundendgame;
    gameobjects::register_allowed_gameobject(level.gametype);
    if (!game["tiebreaker"]) {
        level.onprecachegametype = &onprecachegametype;
        level.ontimelimit = &ontimelimit;
        level.ondeadevent = &ondeadevent;
        level.onroundswitch = &onroundswitch;
        level.onplayerkilled = &onplayerkilled;
        level.endgameonscorelimit = 0;
        game["dialog"]["gametype"] = "sab_start";
        game["dialog"]["gametype_hardcore"] = "hcsab_start";
        game["dialog"]["offense_obj"] = "destroy_start";
        game["dialog"]["defense_obj"] = "destroy_start";
        game["dialog"]["sudden_death"] = "suddendeath";
        game["dialog"]["sudden_death_boost"] = "generic_boost";
    } else {
        level.onendgame = &onendgame;
        level.endgameonscorelimit = 0;
        game["dialog"]["gametype"] = "sab_start";
        game["dialog"]["gametype_hardcore"] = "hcsab_start";
        game["dialog"]["offense_obj"] = "generic_boost";
        game["dialog"]["defense_obj"] = "generic_boost";
        game["dialog"]["sudden_death"] = "suddendeath";
        game["dialog"]["sudden_death_boost"] = "generic_boost";
        util::registernumlives(1, 1);
        util::registertimelimit(0, 0);
    }
    var_ad2dab0c = getent("sab_bomb_defuse_allies", "targetname");
    if (isdefined(var_ad2dab0c)) {
        var_ad2dab0c delete();
    }
    var_ad2dab0c = getent("sab_bomb_defuse_axis", "targetname");
    if (isdefined(var_ad2dab0c)) {
        var_ad2dab0c delete();
    }
    level.var_c2a60b96 = 0;
    globallogic::setvisiblescoreboardcolumns("score", "kills", "deaths", "plants", "defuses");
}

// Namespace sab
// Params 0, eflags: 0x0
// Checksum 0x875d226, Offset: 0x1038
// Size: 0x2c
function onprecachegametype() {
    game["bomb_dropped_sound"] = "mp_war_objective_lost";
    game["bomb_recovered_sound"] = "mp_war_objective_taken";
}

// Namespace sab
// Params 0, eflags: 0x0
// Checksum 0x524ffa1a, Offset: 0x1070
// Size: 0xd0
function onroundswitch() {
    if (!isdefined(game["switchedsides"])) {
        game["switchedsides"] = 0;
    }
    if (game["teamScores"]["allies"] == level.scorelimit - 1 && game["teamScores"]["axis"] == level.scorelimit - 1) {
        level.halftimetype = "overtime";
        level.halftimesubcaption = %MP_TIE_BREAKER;
        game["tiebreaker"] = 1;
        return;
    }
    level.halftimetype = "halftime";
    game["switchedsides"] = !game["switchedsides"];
}

// Namespace sab
// Params 0, eflags: 0x0
// Checksum 0x6290521b, Offset: 0x1148
// Size: 0x4dc
function onstartgametype() {
    if (!isdefined(game["switchedsides"])) {
        game["switchedsides"] = 0;
    }
    setclientnamemode("auto_change");
    game["strings"]["target_destroyed"] = %MP_TARGET_DESTROYED;
    if (!game["tiebreaker"]) {
        util::setobjectivetext("allies", %OBJECTIVES_SAB);
        util::setobjectivetext("axis", %OBJECTIVES_SAB);
        if (level.splitscreen) {
            util::setobjectivescoretext("allies", %OBJECTIVES_SAB);
            util::setobjectivescoretext("axis", %OBJECTIVES_SAB);
        } else {
            util::setobjectivescoretext("allies", %OBJECTIVES_SAB_SCORE);
            util::setobjectivescoretext("axis", %OBJECTIVES_SAB_SCORE);
        }
        util::setobjectivehinttext("allies", %OBJECTIVES_SAB_HINT);
        util::setobjectivehinttext("axis", %OBJECTIVES_SAB_HINT);
    } else {
        util::setobjectivetext("allies", %OBJECTIVES_TDM);
        util::setobjectivetext("axis", %OBJECTIVES_TDM);
        if (level.splitscreen) {
            util::setobjectivescoretext("allies", %OBJECTIVES_TDM);
            util::setobjectivescoretext("axis", %OBJECTIVES_TDM);
        } else {
            util::setobjectivescoretext("allies", %OBJECTIVES_TDM_SCORE);
            util::setobjectivescoretext("axis", %OBJECTIVES_TDM_SCORE);
        }
        util::setobjectivehinttext("allies", %OBJECTIVES_TDM_HINT);
        util::setobjectivehinttext("axis", %OBJECTIVES_TDM_HINT);
    }
    spawning::create_map_placed_influencers();
    level.spawnmins = (0, 0, 0);
    level.spawnmaxs = (0, 0, 0);
    spawnlogic::place_spawn_points("mp_sab_spawn_allies_start");
    spawnlogic::place_spawn_points("mp_sab_spawn_axis_start");
    spawnlogic::add_spawn_points("allies", "mp_sab_spawn_allies");
    spawnlogic::add_spawn_points("axis", "mp_sab_spawn_axis");
    spawning::updateallspawnpoints();
    level.mapcenter = math::find_box_center(level.spawnmins, level.spawnmaxs);
    setmapcenter(level.mapcenter);
    spawnpoint = spawnlogic::get_random_intermission_point();
    setdemointermissionpoint(spawnpoint.origin, spawnpoint.angles);
    level.spawn_axis = spawnlogic::get_spawnpoint_array("mp_sab_spawn_axis");
    level.spawn_allies = spawnlogic::get_spawnpoint_array("mp_sab_spawn_allies");
    level.spawn_start = [];
    foreach (team in level.teams) {
        level.spawn_start[team] = spawnlogic::get_spawnpoint_array("mp_sab_spawn_" + team + "_start");
    }
    thread updategametypedvars();
    thread function_158500a5();
}

// Namespace sab
// Params 0, eflags: 0x0
// Checksum 0x65990bc4, Offset: 0x1630
// Size: 0x24
function ontimelimit() {
    if (level.inovertime) {
        return;
    }
    thread function_5e994bd3();
}

// Namespace sab
// Params 0, eflags: 0x0
// Checksum 0x68937bbc, Offset: 0x1660
// Size: 0x224
function function_5e994bd3() {
    level endon(#"game_ended");
    level.timelimitoverride = 1;
    level.inovertime = 1;
    globallogic_audio::leader_dialog("sudden_death");
    globallogic_audio::leader_dialog("sudden_death_boost");
    for (index = 0; index < level.players.size; index++) {
        level.players[index] notify(#"force_spawn");
        level.players[index] thread hud_message::function_2bb1fc0(%MP_SUDDEN_DEATH, %MP_NO_RESPAWN, undefined, (1, 0, 0), "mp_last_stand");
        level.players[index] setclientuivisibilityflag("g_compassShowEnemies", 1);
    }
    setmatchtalkflag("DeadChatWithDead", 1);
    setmatchtalkflag("DeadChatWithTeam", 0);
    setmatchtalkflag("DeadHearTeamLiving", 0);
    setmatchtalkflag("DeadHearAllLiving", 0);
    setmatchtalkflag("EveryoneHearsEveryone", 0);
    waittime = 0;
    while (waittime < 90) {
        if (!level.bombplanted) {
            waittime += 1;
            setgameendtime(gettime() + (90 - waittime) * 1000);
        }
        wait 1;
    }
    thread globallogic::endgame("tie", game["strings"]["tie"]);
}

// Namespace sab
// Params 1, eflags: 0x0
// Checksum 0xfbddcc73, Offset: 0x1890
// Size: 0x1bc
function ondeadevent(team) {
    if (level.bombexploded) {
        return;
    }
    if (team == "all") {
        if (level.bombplanted) {
            globallogic_score::giveteamscoreforobjective(level.var_97d99fc4, 1);
            thread globallogic::endgame(level.var_97d99fc4, game["strings"][level.var_97d99fc4 + "_mission_accomplished"]);
        } else {
            thread globallogic::endgame("tie", game["strings"]["tie"]);
        }
        return;
    }
    if (level.bombplanted) {
        if (team == level.var_97d99fc4) {
            level.var_9031e005 = 1;
            return;
        }
        otherteam = util::getotherteam(level.var_97d99fc4);
        globallogic_score::giveteamscoreforobjective(level.var_97d99fc4, 1);
        thread globallogic::endgame(level.var_97d99fc4, game["strings"][otherteam + "_eliminated"]);
        return;
    }
    otherteam = util::getotherteam(team);
    globallogic_score::giveteamscoreforobjective(otherteam, 1);
    thread globallogic::endgame(otherteam, game["strings"][team + "_eliminated"]);
}

// Namespace sab
// Params 1, eflags: 0x0
// Checksum 0xab405a65, Offset: 0x1a58
// Size: 0x124
function onspawnplayer(predictedspawn) {
    self.isplanting = 0;
    self.isdefusing = 0;
    self.isbombcarrier = 0;
    if (game["tiebreaker"]) {
        self thread hud_message::function_2bb1fc0(%MP_TIE_BREAKER, %MP_NO_RESPAWN, undefined, (1, 0, 0), "mp_last_stand");
        self setclientuivisibilityflag("g_compassShowEnemies", 1);
        setmatchtalkflag("DeadChatWithDead", 1);
        setmatchtalkflag("DeadChatWithTeam", 0);
        setmatchtalkflag("DeadHearTeamLiving", 0);
        setmatchtalkflag("DeadHearAllLiving", 0);
        setmatchtalkflag("EveryoneHearsEveryone", 0);
    }
    spawning::onspawnplayer(predictedspawn);
}

// Namespace sab
// Params 0, eflags: 0x0
// Checksum 0x279daa23, Offset: 0x1b88
// Size: 0x84
function updategametypedvars() {
    level.planttime = getgametypesetting("plantTime");
    level.defusetime = getgametypesetting("defuseTime");
    level.bombtimer = getgametypesetting("bombTimer");
    level.hotPotato = getgametypesetting("hotPotato");
}

// Namespace sab
// Params 0, eflags: 0x0
// Checksum 0x1079bff0, Offset: 0x1c18
// Size: 0x4b6
function function_158500a5() {
    level.bombplanted = 0;
    level.bombexploded = 0;
    level._effect["bombexplosion"] = "_t6/maps/mp_maps/fx_mp_exp_bomb";
    trigger = getent("sab_bomb_pickup_trig", "targetname");
    if (!isdefined(trigger)) {
        util::error("No sab_bomb_pickup_trig trigger found in map.");
        return;
    }
    visuals[0] = getent("sab_bomb", "targetname");
    if (!isdefined(visuals[0])) {
        util::error("No sab_bomb script_model found in map.");
        return;
    }
    level.var_b3f3e65d = gameobjects::create_carry_object("neutral", trigger, visuals, (0, 0, 32));
    level.var_b3f3e65d gameobjects::allow_carry("any");
    level.var_b3f3e65d gameobjects::set_2d_icon("enemy", "compass_waypoint_bomb");
    level.var_b3f3e65d gameobjects::set_3d_icon("enemy", "waypoint_bomb");
    level.var_b3f3e65d gameobjects::set_2d_icon("friendly", "compass_waypoint_bomb");
    level.var_b3f3e65d gameobjects::set_3d_icon("friendly", "waypoint_bomb");
    level.var_b3f3e65d gameobjects::set_carry_icon("hud_suitcase_bomb");
    level.var_b3f3e65d gameobjects::set_visible_team("any");
    level.var_b3f3e65d.objidpingenemy = 1;
    level.var_b3f3e65d.onpickup = &onpickup;
    level.var_b3f3e65d.ondrop = &ondrop;
    level.var_b3f3e65d.allowweapons = 1;
    level.var_b3f3e65d.objpoints["allies"].archived = 1;
    level.var_b3f3e65d.objpoints["axis"].archived = 1;
    level.var_b3f3e65d.autoresettime = 60;
    if (!isdefined(getent("sab_bomb_axis", "targetname"))) {
        /#
            util::error("<dev string:x28>");
        #/
        return;
    }
    if (!isdefined(getent("sab_bomb_allies", "targetname"))) {
        /#
            util::error("<dev string:x4f>");
        #/
        return;
    }
    if (game["switchedsides"]) {
        level.bombzones["allies"] = createbombzone("allies", getent("sab_bomb_axis", "targetname"));
        level.bombzones["axis"] = createbombzone("axis", getent("sab_bomb_allies", "targetname"));
        return;
    }
    level.bombzones["allies"] = createbombzone("allies", getent("sab_bomb_allies", "targetname"));
    level.bombzones["axis"] = createbombzone("axis", getent("sab_bomb_axis", "targetname"));
}

// Namespace sab
// Params 2, eflags: 0x0
// Checksum 0xf05e3a92, Offset: 0x20d8
// Size: 0x1ea
function createbombzone(team, trigger) {
    visuals = getentarray(trigger.target, "targetname");
    bombzone = gameobjects::create_use_object(team, trigger, visuals, (0, 0, 64));
    bombzone resetbombsite();
    bombzone.onuse = &onuse;
    bombzone.onbeginuse = &onbeginuse;
    bombzone.onenduse = &onenduse;
    bombzone.oncantuse = &oncantuse;
    bombzone.useweapon = getweapon("briefcase_bomb");
    bombzone.visuals[0].killcament = spawn("script_model", bombzone.visuals[0].origin + (0, 0, 128));
    for (i = 0; i < visuals.size; i++) {
        if (isdefined(visuals[i].script_exploder)) {
            bombzone.exploderindex = visuals[i].script_exploder;
            break;
        }
    }
    return bombzone;
}

// Namespace sab
// Params 1, eflags: 0x0
// Checksum 0x58d0200b, Offset: 0x22d0
// Size: 0xe4
function onbeginuse(player) {
    if (!self gameobjects::is_friendly_team(player.pers["team"])) {
        player.isplanting = 1;
        player thread battlechatter::gametype_specific_battle_chatter("sd_friendlyplant", player.pers["team"]);
    } else {
        player.isdefusing = 1;
        player thread battlechatter::gametype_specific_battle_chatter("sd_enemyplant", player.pers["team"]);
    }
    player playsound("fly_bomb_raise_plr");
}

// Namespace sab
// Params 3, eflags: 0x0
// Checksum 0x1e96bdc3, Offset: 0x23c0
// Size: 0x68
function onenduse(team, player, result) {
    if (!isalive(player)) {
        return;
    }
    player.isplanting = 0;
    player.isdefusing = 0;
    player notify(#"event_ended");
}

// Namespace sab
// Params 1, eflags: 0x0
// Checksum 0xd55959ee, Offset: 0x2430
// Size: 0x404
function onpickup(player) {
    level notify(#"hash_8520aca0");
    player recordgameevent("pickup");
    self.autoresettime = 60;
    level.usestartspawns = 0;
    team = player.pers["team"];
    if (team == "allies") {
        otherteam = "axis";
    } else {
        otherteam = "allies";
    }
    player playlocalsound("mp_suitcase_pickup");
    /#
        print("<dev string:x78>");
    #/
    excludelist[0] = player;
    if (gettime() - level.var_c2a60b96 > 10000) {
        globallogic_audio::leader_dialog("bomb_acquired", team);
        player globallogic_audio::leader_dialog_on_player("obj_destroy", "bomb");
        if (!level.splitscreen) {
            globallogic_audio::leader_dialog("bomb_taken", otherteam);
            globallogic_audio::leader_dialog("obj_defend", otherteam);
        }
        level.var_c2a60b96 = gettime();
    }
    player.isbombcarrier = 1;
    player addplayerstatwithgametype("PICKUPS", 1);
    if (team == self gameobjects::get_owner_team()) {
        util::printonteamarg(%MP_EXPLOSIVES_RECOVERED_BY, team, player);
        sound::play_on_players(game["bomb_recovered_sound"], team);
    } else {
        util::printonteamarg(%MP_EXPLOSIVES_RECOVERED_BY, team, player);
        sound::play_on_players(game["bomb_recovered_sound"]);
    }
    self gameobjects::set_owner_team(team);
    self gameobjects::set_visible_team("any");
    self gameobjects::set_2d_icon("enemy", "compass_waypoint_target");
    self gameobjects::set_3d_icon("enemy", "waypoint_kill");
    self gameobjects::set_2d_icon("friendly", "compass_waypoint_defend");
    self gameobjects::set_3d_icon("friendly", "waypoint_defend");
    level.bombzones[team] gameobjects::set_visible_team("none");
    level.bombzones[otherteam] gameobjects::set_visible_team("any");
    level.bombzones[otherteam].trigger setinvisibletoall();
    level.bombzones[otherteam].trigger setvisibletoplayer(player);
}

// Namespace sab
// Params 1, eflags: 0x0
// Checksum 0xbbcd7960, Offset: 0x2840
// Size: 0x184
function ondrop(player) {
    if (level.bombplanted) {
        return;
    }
    if (isdefined(player)) {
        util::printonteamarg(%MP_EXPLOSIVES_DROPPED_BY, self gameobjects::get_owner_team(), player);
    }
    sound::play_on_players(game["bomb_dropped_sound"], self gameobjects::get_owner_team());
    /#
        if (isdefined(player)) {
            print("<dev string:x83>");
        } else {
            print("<dev string:x83>");
        }
    #/
    globallogic_audio::leader_dialog("bomb_lost", self gameobjects::get_owner_team());
    player notify(#"event_ended");
    level.bombzones["axis"].trigger setinvisibletoall();
    level.bombzones["allies"].trigger setinvisibletoall();
    thread function_49ac7e58(0);
}

// Namespace sab
// Params 1, eflags: 0x0
// Checksum 0xf1f0067f, Offset: 0x29d0
// Size: 0x1cc
function function_49ac7e58(delay) {
    level endon(#"hash_8520aca0");
    wait delay;
    if (isdefined(self.carrier)) {
        return;
    }
    if (self gameobjects::get_owner_team() == "allies") {
        otherteam = "axis";
    } else {
        otherteam = "allies";
    }
    sound::play_on_players(game["bomb_dropped_sound"], otherteam);
    self gameobjects::set_owner_team("neutral");
    self gameobjects::set_visible_team("any");
    self gameobjects::set_2d_icon("enemy", "compass_waypoint_bomb");
    self gameobjects::set_3d_icon("enemy", "waypoint_bomb");
    self gameobjects::set_2d_icon("friendly", "compass_waypoint_bomb");
    self gameobjects::set_3d_icon("friendly", "waypoint_bomb");
    level.bombzones["allies"] gameobjects::set_visible_team("none");
    level.bombzones["axis"] gameobjects::set_visible_team("none");
}

// Namespace sab
// Params 1, eflags: 0x0
// Checksum 0xf2333dbf, Offset: 0x2ba8
// Size: 0x504
function onuse(player) {
    team = player.pers["team"];
    otherteam = util::getotherteam(team);
    if (!self gameobjects::is_friendly_team(player.pers["team"])) {
        player notify(#"bomb_planted");
        /#
            print("<dev string:x90>");
        #/
        if (isdefined(player.pers["plants"])) {
            player.pers["plants"]++;
            player.plants = player.pers["plants"];
        }
        demo::bookmark("event", gettime(), player);
        player addplayerstatwithgametype("PLANTS", 1);
        level thread popups::displayteammessagetoall(%MP_EXPLOSIVES_PLANTED_BY, player);
        globallogic_audio::set_music_on_team("ACTION", "both", 1);
        globallogic_audio::leader_dialog("bomb_planted", team);
        globallogic_audio::leader_dialog("bomb_planted", otherteam);
        scoreevents::processscoreevent("planted_bomb", player);
        player recordgameevent("plant");
        level thread bombplanted(self, player.pers["team"]);
        level.bombowner = player;
        player.isbombcarrier = 0;
        level.var_b3f3e65d.autoresettime = undefined;
        level.var_b3f3e65d gameobjects::allow_carry("none");
        level.var_b3f3e65d gameobjects::set_visible_team("none");
        level.var_b3f3e65d gameobjects::set_dropped();
        self.useweapon = getweapon("briefcase_bomb_defuse");
        self setupfordefusing();
        return;
    }
    player notify(#"bomb_defused");
    /#
        print("<dev string:x9d>");
    #/
    if (isdefined(player.pers["defuses"])) {
        player.pers["defuses"]++;
        player.defuses = player.pers["defuses"];
    }
    demo::bookmark("event", gettime(), player);
    player addplayerstatwithgametype("DEFUSES", 1);
    level thread popups::displayteammessagetoall(%MP_EXPLOSIVES_DEFUSED_BY, player);
    globallogic_audio::leader_dialog("bomb_defused");
    scoreevents::processscoreevent("defused_bomb", player);
    player recordgameevent("defuse");
    level thread bombdefused(self);
    if (level.inovertime && isdefined(level.var_9031e005)) {
        thread globallogic::endgame(player.pers["team"], game["strings"][level.var_97d99fc4 + "_eliminated"]);
        return;
    }
    self resetbombsite();
    level.var_b3f3e65d gameobjects::allow_carry("any");
    level.var_b3f3e65d gameobjects::set_picked_up(player);
}

// Namespace sab
// Params 1, eflags: 0x0
// Checksum 0x22264e29, Offset: 0x30b8
// Size: 0x2c
function oncantuse(player) {
    player iprintlnbold(%MP_CANT_PLANT_WITHOUT_BOMB);
}

// Namespace sab
// Params 2, eflags: 0x0
// Checksum 0x72b78c22, Offset: 0x30f0
// Size: 0x4dc
function bombplanted(destroyedobj, team) {
    game["challenge"][team]["plantedBomb"] = 1;
    globallogic_utils::pausetimer();
    level.bombplanted = 1;
    level.var_97d99fc4 = team;
    level.timelimitoverride = 1;
    setmatchflag("bomb_timer", 1);
    setgameendtime(int(gettime() + level.bombtimer * 1000));
    destroyedobj.visuals[0] thread globallogic_utils::playtickingsound("mpl_sab_ui_suitcasebomb_timer");
    starttime = gettime();
    bombtimerwait();
    setmatchflag("bomb_timer", 0);
    destroyedobj.visuals[0] globallogic_utils::stoptickingsound();
    if (!level.bombplanted) {
        if (level.hotPotato) {
            timepassed = (gettime() - starttime) / 1000;
            level.bombtimer -= timepassed;
        }
        return;
    }
    explosionorigin = level.var_b3f3e65d.visuals[0].origin + (0, 0, 12);
    level.bombexploded = 1;
    if (isdefined(level.bombowner)) {
        destroyedobj.visuals[0] radiusdamage(explosionorigin, 512, -56, 20, level.bombowner, "MOD_EXPLOSIVE", getweapon("briefcase_bomb"));
        level thread popups::displayteammessagetoall(%MP_EXPLOSIVES_BLOWUP_BY, level.bombowner);
        level.bombowner addplayerstatwithgametype("DESTRUCTIONS", 1);
        scoreevents::processscoreevent("bomb_detonated", level.bombowner);
    } else {
        destroyedobj.visuals[0] radiusdamage(explosionorigin, 512, -56, 20, undefined, "MOD_EXPLOSIVE", getweapon("briefcase_bomb"));
    }
    rot = randomfloat(360);
    explosioneffect = spawnfx(level._effect["bombexplosion"], explosionorigin + (0, 0, 50), (0, 0, 1), (cos(rot), sin(rot), 0));
    triggerfx(explosioneffect);
    thread sound::play_in_space("mpl_sab_exp_suitcase_bomb_main", explosionorigin);
    if (isdefined(destroyedobj.exploderindex)) {
        exploder::exploder(destroyedobj.exploderindex);
    }
    [[ level._setteamscore ]](team, [[ level._getteamscore ]](team) + 1);
    setgameendtime(0);
    level.bombzones["allies"] gameobjects::set_visible_team("none");
    level.bombzones["axis"] gameobjects::set_visible_team("none");
    wait 3;
    thread globallogic::endgame(team, game["strings"]["target_destroyed"]);
}

// Namespace sab
// Params 0, eflags: 0x0
// Checksum 0xe35fb9ce, Offset: 0x35d8
// Size: 0x24
function bombtimerwait() {
    level endon(#"bomb_defused");
    hostmigration::waitlongdurationwithgameendtimeupdate(level.bombtimer);
}

// Namespace sab
// Params 0, eflags: 0x0
// Checksum 0x24f39f4b, Offset: 0x3608
// Size: 0x19c
function resetbombsite() {
    self gameobjects::allow_use("enemy");
    self gameobjects::set_use_time(level.planttime);
    self gameobjects::set_use_text(%MP_PLANTING_EXPLOSIVE);
    self gameobjects::set_use_hint_text(%PLATFORM_HOLD_TO_PLANT_EXPLOSIVES);
    self gameobjects::set_key_object(level.var_b3f3e65d);
    self gameobjects::set_2d_icon("friendly", "compass_waypoint_defend");
    self gameobjects::set_3d_icon("friendly", "waypoint_defend");
    self gameobjects::set_2d_icon("enemy", "compass_waypoint_target");
    self gameobjects::set_3d_icon("enemy", "waypoint_target");
    self gameobjects::set_visible_team("none");
    self.trigger setinvisibletoall();
    self.useweapon = getweapon("briefcase_bomb");
}

// Namespace sab
// Params 0, eflags: 0x0
// Checksum 0xe0b3a417, Offset: 0x37b0
// Size: 0x174
function setupfordefusing() {
    self gameobjects::allow_use("friendly");
    self gameobjects::set_use_time(level.defusetime);
    self gameobjects::set_use_text(%MP_DEFUSING_EXPLOSIVE);
    self gameobjects::set_use_hint_text(%PLATFORM_HOLD_TO_DEFUSE_EXPLOSIVES);
    self gameobjects::set_key_object(undefined);
    self gameobjects::set_2d_icon("friendly", "compass_waypoint_defuse");
    self gameobjects::set_3d_icon("friendly", "waypoint_defuse");
    self gameobjects::set_2d_icon("enemy", "compass_waypoint_defend");
    self gameobjects::set_3d_icon("enemy", "waypoint_defend");
    self gameobjects::set_visible_team("any");
    self.trigger setvisibletoall();
}

// Namespace sab
// Params 1, eflags: 0x0
// Checksum 0x32872e04, Offset: 0x3930
// Size: 0x62
function bombdefused(object) {
    setmatchflag("bomb_timer", 0);
    globallogic_utils::resumetimer();
    level.bombplanted = 0;
    if (!level.inovertime) {
        level.timelimitoverride = 0;
    }
    level notify(#"bomb_defused");
}

// Namespace sab
// Params 9, eflags: 0x0
// Checksum 0x5e2c4c9a, Offset: 0x39a0
// Size: 0x3ac
function onplayerkilled(einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime, deathanimduration) {
    inbombzone = 0;
    var_1091b3c9 = "none";
    if (isdefined(level.bombzones["allies"])) {
        dist = distance2dsquared(self.origin, level.bombzones["allies"].curorigin);
        if (dist < level.defaultoffenseradiussq) {
            var_1091b3c9 = "allies";
            inbombzone = 1;
        }
    }
    if (isdefined(level.bombzones["axis"])) {
        dist = distance2dsquared(self.origin, level.bombzones["axis"].curorigin);
        if (dist < level.defaultoffenseradiussq) {
            var_1091b3c9 = "axis";
            inbombzone = 1;
        }
    }
    if (inbombzone && isplayer(attacker) && attacker.pers["team"] != self.pers["team"]) {
        if (var_1091b3c9 == self.pers["team"]) {
            attacker thread challenges::killedbaseoffender(level.bombzones[var_1091b3c9], weapon);
            self recordkillmodifier("defending");
        } else {
            if (isdefined(attacker.pers["defends"])) {
                attacker.pers["defends"]++;
                attacker.defends = attacker.pers["defends"];
            }
            attacker medals::defenseglobalcount();
            attacker thread challenges::killedbasedefender(level.bombzones[var_1091b3c9]);
            self recordkillmodifier("assaulting");
        }
    }
    if (isplayer(attacker) && attacker.pers["team"] != self.pers["team"] && isdefined(self.isbombcarrier) && self.isbombcarrier == 1) {
        self recordkillmodifier("carrying");
    }
    if (self.isplanting == 1) {
        self recordkillmodifier("planting");
    }
    if (self.isdefusing == 1) {
        self recordkillmodifier("defusing");
    }
}

// Namespace sab
// Params 1, eflags: 0x0
// Checksum 0x1edb1d67, Offset: 0x3d58
// Size: 0x54
function onendgame(winningteam) {
    if (winningteam == "allies" || isdefined(winningteam) && winningteam == "axis") {
        globallogic_score::giveteamscoreforobjective(winningteam, 1);
    }
}

// Namespace sab
// Params 1, eflags: 0x0
// Checksum 0xd82a7b7f, Offset: 0x3db8
// Size: 0x34
function onroundendgame(roundwinner) {
    winner = globallogic::determineteamwinnerbygamestat("roundswon");
    return winner;
}

