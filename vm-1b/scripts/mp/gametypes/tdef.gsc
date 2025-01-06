#using scripts/codescripts/struct;
#using scripts/mp/_util;
#using scripts/mp/gametypes/_globallogic;
#using scripts/mp/gametypes/_globallogic_audio;
#using scripts/mp/gametypes/_globallogic_score;
#using scripts/mp/gametypes/_spawning;
#using scripts/mp/gametypes/_spawnlogic;
#using scripts/mp/killstreaks/_killstreaks;
#using scripts/mp/teams/_teams;
#using scripts/shared/gameobjects_shared;
#using scripts/shared/math_shared;
#using scripts/shared/popups_shared;
#using scripts/shared/rank_shared;
#using scripts/shared/scoreevents_shared;
#using scripts/shared/sound_shared;
#using scripts/shared/util_shared;

#namespace tdef;

// Namespace tdef
// Params 0, eflags: 0x0
// Checksum 0xe44298fd, Offset: 0x650
// Size: 0x191
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
    InvalidOpCode(0xc8, "dialog", "gametype", "team_def");
    // Unknown operator (0xc8, t7_1b, PC)
}

// Namespace tdef
// Params 0, eflags: 0x0
// Checksum 0xe9c07cd6, Offset: 0x8c8
// Size: 0x2
function onprecachegametype() {
    
}

// Namespace tdef
// Params 0, eflags: 0x0
// Checksum 0x4fe70ac5, Offset: 0x8d8
// Size: 0x39
function onstartgametype() {
    setclientnamemode("auto_change");
    InvalidOpCode(0x54, "switchedsides");
    // Unknown operator (0x54, t7_1b, PC)
}

// Namespace tdef
// Params 0, eflags: 0x0
// Checksum 0xc4601cec, Offset: 0xbb8
// Size: 0x81
function tdef() {
    level.carryflag["allies"] = teams::get_flag_carry_model("allies");
    level.carryflag["axis"] = teams::get_flag_carry_model("axis");
    level.carryflag["neutral"] = teams::get_flag_model("neutral");
    level.gameflag = undefined;
}

// Namespace tdef
// Params 9, eflags: 0x0
// Checksum 0xe1d83ae2, Offset: 0xc48
// Size: 0x281
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
    InvalidOpCode(0x54, "state");
    // Unknown operator (0x54, t7_1b, PC)
}

// Namespace tdef
// Params 1, eflags: 0x0
// Checksum 0x735ad9ef, Offset: 0xf10
// Size: 0x282
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
        player notify(#"dropped_flag");
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
// Checksum 0xebe9e6df, Offset: 0x11a0
// Size: 0x2f2
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
// Checksum 0x693d0e5b, Offset: 0x14a0
// Size: 0x132
function applyflagcarrierclass() {
    self endon(#"death");
    self endon(#"disconnect");
    level endon(#"game_ended");
    if (isdefined(self.iscarrying) && self.iscarrying == 1) {
        self notify(#"hash_ba19385f");
        wait 0.05;
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
// Checksum 0x93b31f0f, Offset: 0x15e0
// Size: 0x32
function waitattachflag() {
    level endon(#"hash_f6c1b57e");
    self endon(#"disconnect");
    self endon(#"death");
    self waittill(#"spawned_player");
    self attachflag();
}

// Namespace tdef
// Params 0, eflags: 0x0
// Checksum 0x274f030c, Offset: 0x1620
// Size: 0xb2
function watchforendgame() {
    self endon(#"dropped_flag");
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
// Checksum 0x4e8a6dd, Offset: 0x16e0
// Size: 0x11f
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
// Checksum 0x96566bc, Offset: 0x1808
// Size: 0x234
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
// Checksum 0xcb5cbd8, Offset: 0x1a48
// Size: 0x69
function function_62317c10() {
    level endon(#"game_ended");
    while (true) {
        if (isdefined(self.safeorigin)) {
            self.baseorigin = self.safeorigin;
            self.trigger.baseorigin = self.safeorigin;
            self.visuals[0].baseorigin = self.safeorigin;
        }
        wait 0.05;
    }
}

// Namespace tdef
// Params 0, eflags: 0x0
// Checksum 0x6b9b1aad, Offset: 0x1ac0
// Size: 0x4a
function attachflag() {
    self attach(level.carryflag[self.team], "J_spine4", 1);
    self.carryflag = level.carryflag[self.team];
    level.favorclosespawnent = self;
}

// Namespace tdef
// Params 0, eflags: 0x0
// Checksum 0x57639434, Offset: 0x1b18
// Size: 0x42
function detachflag() {
    self detach(self.carryflag, "J_spine4");
    self.carryflag = undefined;
    level.favorclosespawnent = level.gameflag.trigger;
}

// Namespace tdef
// Params 1, eflags: 0x0
// Checksum 0xbfdba88b, Offset: 0x1b68
// Size: 0x1b
function flagattachradar(team) {
    level endon(#"game_ended");
    self endon(#"dropped");
}

// Namespace tdef
// Params 1, eflags: 0x0
// Checksum 0xd22d0ecf, Offset: 0x1b90
// Size: 0xa1
function getflagradarowner(team) {
    level endon(#"game_ended");
    self endon(#"dropped");
    while (true) {
        foreach (player in level.players) {
            if (isalive(player) && player.team == team) {
                return player;
            }
        }
        wait 0.05;
    }
}

// Namespace tdef
// Params 0, eflags: 0x0
// Checksum 0xcbe776cc, Offset: 0x1c40
// Size: 0x5d
function flagradarmover() {
    level endon(#"game_ended");
    self endon(#"dropped");
    self.portable_radar endon(#"death");
    for (;;) {
        self.portable_radar moveto(self.currentcarrier.origin, 0.05);
        wait 0.05;
    }
}

// Namespace tdef
// Params 0, eflags: 0x0
// Checksum 0x5c38cd2f, Offset: 0x1ca8
// Size: 0x72
function flagwatchradarownerlost() {
    level endon(#"game_ended");
    self endon(#"dropped");
    radarteam = self.portable_radar.team;
    self.portable_radar.owner util::waittill_any("disconnect", "joined_team", "joined_spectators");
    flagattachradar(radarteam);
}

// Namespace tdef
// Params 1, eflags: 0x0
// Checksum 0x58ff766f, Offset: 0x1d28
// Size: 0x2e
function onroundendgame(roundwinner) {
    winner = globallogic::determineteamwinnerbygamestat("roundswon");
    return winner;
}

// Namespace tdef
// Params 1, eflags: 0x0
// Checksum 0x3a162f05, Offset: 0x1d60
// Size: 0x42
function onspawnplayer(predictedspawn) {
    self.usingobj = undefined;
    if (level.usestartspawns && !level.ingraceperiod) {
        level.usestartspawns = 0;
    }
    spawning::onspawnplayer(predictedspawn);
}

// Namespace tdef
// Params 0, eflags: 0x0
// Checksum 0x9f3e828d, Offset: 0x1db0
// Size: 0x9
function onroundswitch() {
    InvalidOpCode(0x54, "switchedsides");
    // Unknown operator (0x54, t7_1b, PC)
}

// Namespace tdef
// Params 0, eflags: 0x0
// Checksum 0xe9c07cd6, Offset: 0x1dd0
// Size: 0x2
function function_1936f03b() {
    
}

// Namespace tdef
// Params 0, eflags: 0x0
// Checksum 0xe9c07cd6, Offset: 0x1de0
// Size: 0x2
function setspecialloadouts() {
    
}

