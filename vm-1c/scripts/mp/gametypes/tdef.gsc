#using scripts/mp/killstreaks/_killstreaks;
#using scripts/mp/teams/_teams;
#using scripts/mp/_util;
#using scripts/mp/gametypes/_spawnlogic;
#using scripts/mp/gametypes/_spawning;
#using scripts/mp/gametypes/_globallogic_score;
#using scripts/mp/gametypes/_globallogic_audio;
#using scripts/mp/gametypes/_globallogic;
#using scripts/shared/util_shared;
#using scripts/shared/scoreevents_shared;
#using scripts/shared/sound_shared;
#using scripts/shared/rank_shared;
#using scripts/shared/popups_shared;
#using scripts/shared/math_shared;
#using scripts/shared/gameobjects_shared;
#using scripts/codescripts/struct;

#namespace tdef;

// Namespace tdef
// Params 0, eflags: 0x0
// Checksum 0x2ba6227c, Offset: 0x650
// Size: 0x2b6
function main() {
    globallogic::init();
    util::registerroundswitch(0, 9);
    util::registertimelimit(0, 1440);
    util::registerscorelimit(0, 10000);
    util::registerroundlimit(0, 10);
    util::registernumlives(0, 100);
    level.matchrules_enemyflagradar = 1;
    level.matchrules_damagemultiplier = 0;
    level.matchrules_vampirism = 0;
    setspecialloadouts();
    level.teambased = 1;
    level.var_1936f03b = &function_1936f03b;
    level.onprecachegametype = &onprecachegametype;
    level.onstartgametype = &onstartgametype;
    level.onplayerkilled = &onplayerkilled;
    level.onspawnplayer = &onspawnplayer;
    level.onroundendgame = &onroundendgame;
    level.onroundswitch = &onroundswitch;
    gameobjects::register_allowed_gameobject(level.gametype);
    gameobjects::register_allowed_gameobject("tdm");
    game["dialog"]["gametype"] = "team_def";
    if (getdvarint("g_hardcore")) {
        game["dialog"]["gametype"] = "hc_" + game["dialog"]["gametype"];
    }
    game["dialog"]["got_flag"] = "ctf_wetake";
    game["dialog"]["enemy_got_flag"] = "ctf_theytake";
    game["dialog"]["dropped_flag"] = "ctf_wedrop";
    game["dialog"]["enemy_dropped_flag"] = "ctf_theydrop";
    game["strings"]["overtime_hint"] = %MP_FIRST_BLOOD;
}

// Namespace tdef
// Params 0, eflags: 0x0
// Checksum 0x99ec1590, Offset: 0x910
// Size: 0x4
function onprecachegametype() {
    
}

// Namespace tdef
// Params 0, eflags: 0x0
// Checksum 0x4c2141dd, Offset: 0x920
// Size: 0x31c
function onstartgametype() {
    setclientnamemode("auto_change");
    if (!isdefined(game["switchedsides"])) {
        game["switchedsides"] = 0;
    }
    if (game["switchedsides"]) {
        oldattackers = game["attackers"];
        olddefenders = game["defenders"];
        game["attackers"] = olddefenders;
        game["defenders"] = oldattackers;
    }
    util::setobjectivetext("allies", %OBJECTIVES_TDEF);
    util::setobjectivetext("axis", %OBJECTIVES_TDEF);
    if (level.splitscreen) {
        util::setobjectivescoretext("allies", %OBJECTIVES_TDEF);
        util::setobjectivescoretext("axis", %OBJECTIVES_TDEF);
    } else {
        util::setobjectivescoretext("allies", %OBJECTIVES_TDEF_SCORE);
        util::setobjectivescoretext("axis", %OBJECTIVES_TDEF_SCORE);
    }
    util::setobjectivehinttext("allies", %OBJECTIVES_TDEF_ATTACKER_HINT);
    util::setobjectivehinttext("axis", %OBJECTIVES_TDEF_ATTACKER_HINT);
    level.spawnmins = (0, 0, 0);
    level.spawnmaxs = (0, 0, 0);
    spawnlogic::place_spawn_points("mp_tdm_spawn_allies_start");
    spawnlogic::place_spawn_points("mp_tdm_spawn_axis_start");
    spawnlogic::add_spawn_points("allies", "mp_tdm_spawn");
    spawnlogic::add_spawn_points("axis", "mp_tdm_spawn");
    spawning::updateallspawnpoints();
    level.mapcenter = math::find_box_center(level.spawnmins, level.spawnmaxs);
    setmapcenter(level.mapcenter);
    spawnpoint = spawnlogic::get_random_intermission_point();
    setdemointermissionpoint(spawnpoint.origin, spawnpoint.angles);
    if (!util::isoneround()) {
        level.displayroundendtext = 1;
        if (level.scoreroundwinbased) {
            globallogic_score::resetteamscores();
        }
    }
    tdef();
}

// Namespace tdef
// Params 0, eflags: 0x0
// Checksum 0x5ae1a7e1, Offset: 0xc48
// Size: 0x86
function tdef() {
    level.carryflag["allies"] = teams::get_flag_carry_model("allies");
    level.carryflag["axis"] = teams::get_flag_carry_model("axis");
    level.carryflag["neutral"] = teams::get_flag_model("neutral");
    level.gameflag = undefined;
}

// Namespace tdef
// Params 9, eflags: 0x0
// Checksum 0xda79e75b, Offset: 0xcd8
// Size: 0x39c
function onplayerkilled(einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime, deathanimduration) {
    if (!isplayer(attacker) || attacker.team == self.team) {
        return;
    }
    victim = self;
    score = rank::getscoreinfovalue("kill");
    assert(isdefined(score));
    if (isdefined(level.gameflag) && level.gameflag gameobjects::get_owner_team() == attacker.team) {
        if (isdefined(attacker.carryflag)) {
            attacker addplayerstat("KILLSASFLAGCARRIER", 1);
        }
        score *= 2;
    } else if (!isdefined(level.gameflag) && function_603bf516(victim)) {
        level.gameflag = createflag(victim);
        score += rank::getscoreinfovalue("MEDAL_FIRST_BLOOD");
    } else if (isdefined(victim.carryflag)) {
        var_e6caf80c = rank::getscoreinfovalue("kill_carrier");
        level thread popups::displayteammessagetoall(%MP_KILLED_FLAG_CARRIER, attacker);
        scoreevents::processscoreevent("kill_flag_carrier", attacker);
        attacker recordgameevent("kill_carrier");
        attacker addplayerstat("FLAGCARRIERKILLS", 1);
        attacker notify(#"objective", "kill_carrier");
        score += var_e6caf80c;
    }
    if (isdefined(level.killstreaksgivegamescore) && (!isdefined(killstreaks::get_killstreak_for_weapon(weapon)) || level.killstreaksgivegamescore)) {
        attacker globallogic_score::giveteamscoreforobjective(attacker.team, score);
    }
    otherteam = util::getotherteam(attacker.team);
    if (game["state"] == "postgame" && game["teamScores"][attacker.team] > game["teamScores"][otherteam]) {
        attacker.finalkill = 1;
    }
}

// Namespace tdef
// Params 1, eflags: 0x0
// Checksum 0xa9387293, Offset: 0x1080
// Size: 0x344
function ondrop(player) {
    if (isdefined(player) && isdefined(player.tdef_flagtime)) {
        var_ce90a938 = int(gettime() - player.tdef_flagtime);
        player addplayerstat("HOLDINGTEAMDEFENDERFLAG", var_ce90a938);
        if (var_ce90a938 / 100 / 60 < 1) {
            var_45a5813e = 0;
        } else {
            var_45a5813e = int(var_ce90a938 / 100 / 60);
        }
        player addplayerstatwithgametype("DESTRUCTIONS", var_45a5813e);
        player.tdef_flagtime = undefined;
        player notify(#"hash_f4e8514a");
    }
    team = self gameobjects::get_owner_team();
    otherteam = util::getotherteam(team);
    self.currentcarrier = undefined;
    self gameobjects::set_owner_team("neutral");
    self gameobjects::allow_carry("any");
    self gameobjects::set_visible_team("any");
    self gameobjects::set_2d_icon("friendly", level.iconcaptureflag2d);
    self gameobjects::set_3d_icon("friendly", level.iconcaptureflag3d);
    self gameobjects::set_2d_icon("enemy", level.iconcaptureflag2d);
    self gameobjects::set_3d_icon("enemy", level.iconcaptureflag3d);
    if (isdefined(player)) {
        if (isdefined(player.carryflag)) {
            player detachflag();
        }
        util::printandsoundoneveryone(team, undefined, %MP_NEUTRAL_FLAG_DROPPED_BY, %MP_NEUTRAL_FLAG_DROPPED_BY, "mp_war_objective_lost", "mp_war_objective_lost", player);
    } else {
        sound::play_on_players("mp_war_objective_lost", team);
        sound::play_on_players("mp_war_objective_lost", otherteam);
    }
    globallogic_audio::leader_dialog("dropped_flag", team);
    globallogic_audio::leader_dialog("enemy_dropped_flag", otherteam);
}

// Namespace tdef
// Params 1, eflags: 0x0
// Checksum 0x34a4199a, Offset: 0x13d0
// Size: 0x3bc
function onpickup(player) {
    self notify(#"picked_up");
    player.tdef_flagtime = gettime();
    player thread watchforendgame();
    score = rank::getscoreinfovalue("capture");
    assert(isdefined(score));
    team = player.team;
    otherteam = util::getotherteam(team);
    if (isdefined(level.var_e15444d0) && isdefined(level.var_e15444d0[team])) {
        player thread applyflagcarrierclass();
    } else {
        player attachflag();
    }
    self.currentcarrier = player;
    player.carryicon setshader(level.var_c4fc960[team], player.carryicon.width, player.carryicon.height);
    self gameobjects::set_owner_team(team);
    self gameobjects::set_visible_team("any");
    self gameobjects::set_2d_icon("friendly", level.iconescort2d);
    self gameobjects::set_3d_icon("friendly", level.iconescort2d);
    self gameobjects::set_2d_icon("enemy", level.iconkill3d);
    self gameobjects::set_3d_icon("enemy", level.iconkill3d);
    globallogic_audio::leader_dialog("got_flag", team);
    globallogic_audio::leader_dialog("enemy_got_flag", otherteam);
    level thread popups::displayteammessagetoall(%MP_CAPTURED_THE_FLAG, player);
    scoreevents::processscoreevent("flag_capture", player);
    player recordgameevent("pickup");
    player addplayerstatwithgametype("CAPTURES", 1);
    player notify(#"objective", "captured");
    util::printandsoundoneveryone(team, undefined, %MP_NEUTRAL_FLAG_CAPTURED_BY, %MP_NEUTRAL_FLAG_CAPTURED_BY, "mp_obj_captured", "mp_enemy_obj_captured", player);
    if (self.currentteam == otherteam) {
        player globallogic_score::giveteamscoreforobjective(team, score);
    }
    self.currentteam = team;
    if (level.matchrules_enemyflagradar) {
        self thread flagattachradar(otherteam);
    }
}

// Namespace tdef
// Params 0, eflags: 0x0
// Checksum 0x31ca16f, Offset: 0x1798
// Size: 0x16c
function applyflagcarrierclass() {
    self endon(#"death");
    self endon(#"disconnect");
    level endon(#"game_ended");
    if (isdefined(self.iscarrying) && self.iscarrying == 1) {
        self notify(#"hash_ba19385f");
        wait(0.05);
    }
    self.pers["gamemodeLoadout"] = level.var_e15444d0[self.team];
    spawnpoint = spawn("script_model", self.origin);
    spawnpoint.angles = self.angles;
    spawnpoint.playerspawnpos = self.origin;
    spawnpoint.notti = 1;
    self.setspawnpoint = spawnpoint;
    self.gamemode_chosenclass = self.curclass;
    self.pers["class"] = "gamemode";
    self.pers["lastClass"] = "gamemode";
    self.curclass = "gamemode";
    self.lastclass = "gamemode";
    self thread waitattachflag();
}

// Namespace tdef
// Params 0, eflags: 0x0
// Checksum 0x7017572a, Offset: 0x1910
// Size: 0x4c
function waitattachflag() {
    level endon(#"hash_f6c1b57e");
    self endon(#"disconnect");
    self endon(#"death");
    self waittill(#"spawned_player");
    self attachflag();
}

// Namespace tdef
// Params 0, eflags: 0x0
// Checksum 0xfa032e3e, Offset: 0x1968
// Size: 0x104
function watchforendgame() {
    self endon(#"hash_f4e8514a");
    self endon(#"disconnect");
    level waittill(#"game_ended");
    if (isdefined(self)) {
        if (isdefined(self.tdef_flagtime)) {
            var_ce90a938 = int(gettime() - self.tdef_flagtime);
            self addplayerstat("HOLDINGTEAMDEFENDERFLAG", var_ce90a938);
            if (var_ce90a938 / 100 / 60 < 1) {
                var_45a5813e = 0;
            } else {
                var_45a5813e = int(var_ce90a938 / 100 / 60);
            }
            self addplayerstatwithgametype("DESTRUCTIONS", var_45a5813e);
        }
    }
}

// Namespace tdef
// Params 1, eflags: 0x0
// Checksum 0x815fe153, Offset: 0x1a78
// Size: 0x180
function function_603bf516(victim) {
    minetriggers = getentarray("minefield", "targetname");
    hurttriggers = getentarray("trigger_hurt", "classname");
    radtriggers = getentarray("radiation", "targetname");
    for (index = 0; index < radtriggers.size; index++) {
        if (victim istouching(radtriggers[index])) {
            return false;
        }
    }
    for (index = 0; index < minetriggers.size; index++) {
        if (victim istouching(minetriggers[index])) {
            return false;
        }
    }
    for (index = 0; index < hurttriggers.size; index++) {
        if (victim istouching(hurttriggers[index])) {
            return false;
        }
    }
    return true;
}

// Namespace tdef
// Params 1, eflags: 0x0
// Checksum 0x21f1d6f6, Offset: 0x1c00
// Size: 0x2c0
function createflag(victim) {
    visuals[0] = spawn("script_model", victim.origin);
    visuals[0] setmodel(level.carryflag["neutral"]);
    trigger = spawn("trigger_radius", victim.origin, 0, 96, 72);
    gameflag = gameobjects::create_carry_object("neutral", trigger, visuals, (0, 0, 85));
    gameflag gameobjects::allow_carry("any");
    gameflag gameobjects::set_visible_team("any");
    gameflag gameobjects::set_2d_icon("enemy", level.iconcaptureflag2d);
    gameflag gameobjects::set_3d_icon("enemy", level.iconcaptureflag3d);
    gameflag gameobjects::set_2d_icon("friendly", level.iconcaptureflag2d);
    gameflag gameobjects::set_3d_icon("friendly", level.iconcaptureflag3d);
    gameflag gameobjects::set_carry_icon(level.var_c4fc960["axis"]);
    gameflag.allowweapons = 1;
    gameflag.onpickup = &onpickup;
    gameflag.onpickupfailed = &onpickup;
    gameflag.ondrop = &ondrop;
    gameflag.oldradius = 96;
    gameflag.currentteam = "none";
    gameflag.requireslos = 1;
    level.favorclosespawnent = gameflag.trigger;
    level.favorclosespawnscalar = 3;
    gameflag thread function_62317c10();
    return gameflag;
}

// Namespace tdef
// Params 0, eflags: 0x0
// Checksum 0xc6a090ab, Offset: 0x1ec8
// Size: 0x74
function function_62317c10() {
    level endon(#"game_ended");
    while (true) {
        if (isdefined(self.safeorigin)) {
            self.baseorigin = self.safeorigin;
            self.trigger.baseorigin = self.safeorigin;
            self.visuals[0].baseorigin = self.safeorigin;
        }
        wait(0.05);
    }
}

// Namespace tdef
// Params 0, eflags: 0x0
// Checksum 0xf9539497, Offset: 0x1f48
// Size: 0x58
function attachflag() {
    self attach(level.carryflag[self.team], "J_spine4", 1);
    self.carryflag = level.carryflag[self.team];
    level.favorclosespawnent = self;
}

// Namespace tdef
// Params 0, eflags: 0x0
// Checksum 0x7c14d5f1, Offset: 0x1fa8
// Size: 0x50
function detachflag() {
    self detach(self.carryflag, "J_spine4");
    self.carryflag = undefined;
    level.favorclosespawnent = level.gameflag.trigger;
}

// Namespace tdef
// Params 1, eflags: 0x0
// Checksum 0x3f6eb463, Offset: 0x2000
// Size: 0x22
function flagattachradar(team) {
    level endon(#"game_ended");
    self endon(#"dropped");
}

// Namespace tdef
// Params 1, eflags: 0x0
// Checksum 0x2759ae18, Offset: 0x2030
// Size: 0xdc
function getflagradarowner(team) {
    level endon(#"game_ended");
    self endon(#"dropped");
    while (true) {
        foreach (player in level.players) {
            if (isalive(player) && player.team == team) {
                return player;
            }
        }
        wait(0.05);
    }
}

// Namespace tdef
// Params 0, eflags: 0x0
// Checksum 0x2e118dc, Offset: 0x2118
// Size: 0x68
function flagradarmover() {
    level endon(#"game_ended");
    self endon(#"dropped");
    self.portable_radar endon(#"death");
    for (;;) {
        self.portable_radar moveto(self.currentcarrier.origin, 0.05);
        wait(0.05);
    }
}

// Namespace tdef
// Params 0, eflags: 0x0
// Checksum 0xd9e40943, Offset: 0x2188
// Size: 0x8c
function flagwatchradarownerlost() {
    level endon(#"game_ended");
    self endon(#"dropped");
    radarteam = self.portable_radar.team;
    self.portable_radar.owner util::waittill_any("disconnect", "joined_team", "joined_spectators");
    flagattachradar(radarteam);
}

// Namespace tdef
// Params 1, eflags: 0x0
// Checksum 0xbb0be249, Offset: 0x2220
// Size: 0x34
function onroundendgame(roundwinner) {
    winner = globallogic::determineteamwinnerbygamestat("roundswon");
    return winner;
}

// Namespace tdef
// Params 1, eflags: 0x0
// Checksum 0x273a74f2, Offset: 0x2260
// Size: 0x54
function onspawnplayer(predictedspawn) {
    self.usingobj = undefined;
    if (level.usestartspawns && !level.ingraceperiod) {
        level.usestartspawns = 0;
    }
    spawning::onspawnplayer(predictedspawn);
}

// Namespace tdef
// Params 0, eflags: 0x0
// Checksum 0x3a26dd0, Offset: 0x22c0
// Size: 0x1c
function onroundswitch() {
    game["switchedsides"] = !game["switchedsides"];
}

// Namespace tdef
// Params 0, eflags: 0x0
// Checksum 0x99ec1590, Offset: 0x22e8
// Size: 0x4
function function_1936f03b() {
    
}

// Namespace tdef
// Params 0, eflags: 0x0
// Checksum 0x99ec1590, Offset: 0x22f8
// Size: 0x4
function setspecialloadouts() {
    
}

