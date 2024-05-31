#using scripts/shared/weapons/_weapons;
#using scripts/shared/util_shared;
#using scripts/shared/tweakables_shared;
#using scripts/shared/system_shared;
#using scripts/shared/scoreevents_shared;
#using scripts/shared/math_shared;
#using scripts/shared/hud_util_shared;
#using scripts/shared/hostmigration_shared;
#using scripts/shared/gameobjects_shared;
#using scripts/shared/fx_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/damagefeedback_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/array_shared;
#using scripts/shared/ai_shared;
#using scripts/mp/teams/_teams;
#using scripts/mp/killstreaks/_killstreaks;
#using scripts/mp/gametypes/_spawnlogic;
#using scripts/mp/gametypes/_spawning;
#using scripts/mp/gametypes/_prop_dev;
#using scripts/mp/gametypes/_prop_controls;
#using scripts/mp/gametypes/_loadout;
#using scripts/mp/gametypes/_killcam;
#using scripts/mp/gametypes/_globallogic_utils;
#using scripts/mp/gametypes/_globallogic_ui;
#using scripts/mp/gametypes/_globallogic_spawn;
#using scripts/mp/gametypes/_globallogic_score;
#using scripts/mp/gametypes/_globallogic_defaults;
#using scripts/mp/gametypes/_globallogic_audio;
#using scripts/mp/gametypes/_globallogic;
#using scripts/mp/gametypes/_dogtags;
#using scripts/mp/gametypes/_deathicons;
#using scripts/mp/gametypes/_battlechatter;
#using scripts/mp/bots/_bot;
#using scripts/mp/_util;
#using scripts/mp/_teamops;

#namespace prop;

// Namespace prop
// Params 0, eflags: 0x2
// namespace_a9dea446<file_0>::function_2dc19561
// Checksum 0x92a36df9, Offset: 0xeb0
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("prop", &__init__, undefined, undefined);
}

// Namespace prop
// Params 0, eflags: 0x0
// namespace_a9dea446<file_0>::function_8c87d8eb
// Checksum 0x791d3167, Offset: 0xef0
// Size: 0x64
function __init__() {
    clientfield::register("allplayers", "hideTeamPlayer", 27000, 2, "int");
    clientfield::register("allplayers", "pingHighlight", 27000, 1, "int");
}

// Namespace prop
// Params 0, eflags: 0x0
// namespace_a9dea446<file_0>::function_d290ebfa
// Checksum 0xa79ec2b8, Offset: 0xf60
// Size: 0x6bc
function main() {
    globallogic::init();
    util::registerroundswitch(0, 9);
    util::registertimelimit(0, 4);
    util::registerscorelimit(0, 0);
    util::registerroundlimit(0, 4);
    util::registerroundwinlimit(0, 3);
    util::registernumlives(0, 1);
    level.phsettings = spawnstruct();
    level.phsettings.prophidetime = 30;
    level.phsettings.propwhistletime = function_fc1530ac();
    level.phsettings.propchangecount = 2;
    level.phsettings.propnumflashes = 1;
    level.phsettings.propnumclones = 3;
    level.phsettings.propspeedscale = 1.4;
    level.phsettings.var_60a20fdc = 2;
    level.phsettings.var_23bd3153 = 0;
    level.phsettings.var_e332c699 = level.script == "mp_nuketown_x";
    level.phsettings.var_78280ce0 = level.phsettings.var_e332c699;
    if (level.phsettings.var_78280ce0) {
        level.phsettings.propnumclones = 9;
    }
    globallogic::registerfriendlyfiredelay(level.gametype, 15, 0, 1440);
    level.isprophunt = 1;
    level.allow_teamchange = "1";
    level.killstreaksenabled = 0;
    level.teambased = 1;
    level.overrideteamscore = 1;
    level.alwaysusestartspawns = 1;
    level.scoreroundwinbased = getgametypesetting("cumulativeRoundScores") == 0;
    level.teamscoreperkill = getgametypesetting("teamScorePerKill");
    level.teamscoreperdeath = getgametypesetting("teamScorePerDeath");
    level.teamscoreperheadshot = getgametypesetting("teamScorePerHeadshot");
    level.killstreaksgivegamescore = getgametypesetting("killstreaksGiveGameScore");
    level.onstartgametype = &onstartgametype;
    level.onspawnplayer = &onspawnplayer;
    level.onplayerdisconnect = &onplayerdisconnect;
    level.onroundendgame = &onroundendgame;
    level.onroundswitch = &onroundswitch;
    level.var_7d4f8220 = &function_7d4f8220;
    level.onplayerkilled = &onplayerkilled;
    level.ononeleftevent = &ononeleftevent;
    level.ontimelimit = &ontimelimit;
    level.ondeadevent = &ondeadevent;
    level.var_b9fd53a3 = &function_470f21c5;
    level.var_a58db931 = &playdeathsoundph;
    level.overrideplayerdamage = &gamemodemodifyplayerdamage;
    level.var_c17c938d = &function_c17c938d;
    level.var_6f13f156 = &function_6f13f156;
    level.var_e0d16266 = &function_e0d16266;
    level.var_4fb47492 = &function_4fb47492;
    level.givecustomloadout = &givecustomloadout;
    level.var_a4623c17 = &function_e999d;
    level.var_dc6b46ed = &function_dc6b46ed;
    level.var_9bb11de9 = &function_9bb11de9;
    level.determinewinner = &determinewinner;
    level.var_64783fef = 1;
    gameobjects::register_allowed_gameobject(level.gametype);
    globallogic::setvisiblescoreboardcolumns("score", "objtime", "kills", "deaths", "assists");
    level.proplist = [];
    level.propindex = [];
    level.spawnproplist = [];
    level.abilities = array("FLASH", "CLONE");
    populateproplist();
    level.graceperiod = int(level.phsettings.prophidetime + 0.5);
    level thread onplayerconnect();
    level thread delayset();
    level thread function_1edf732a();
    if (level.phsettings.var_e332c699) {
        level thread function_7010fe7f();
    }
    shatterallglass();
    util::set_dvar_int_if_unset("scr_prop_minigame", 1);
    /#
        level.var_2898ef72 = 0;
        thread prop_dev::propdevgui();
    #/
}

// Namespace prop
// Params 0, eflags: 0x0
// namespace_a9dea446<file_0>::function_fc1530ac
// Checksum 0xa91946c, Offset: 0x1628
// Size: 0x60
function function_fc1530ac() {
    if (level.script == "mp_chinatown") {
        return 18;
    } else if (level.script == "mp_redwood") {
        return 20;
    } else if (level.script == "mp_nuketown_x") {
        return 0;
    }
    return 30;
}

// Namespace prop
// Params 0, eflags: 0x0
// namespace_a9dea446<file_0>::function_e67ba2a2
// Checksum 0x324eae9a, Offset: 0x1690
// Size: 0x24
function delayset() {
    wait(0.05);
    level.playstartconversation = 0;
    level.allowspecialistdialog = 0;
}

// Namespace prop
// Params 1, eflags: 0x0
// namespace_a9dea446<file_0>::function_257d1c47
// Checksum 0x5812e593, Offset: 0x16c0
// Size: 0x44
function onendgame(winningteam) {
    if (isdefined(winningteam) && isdefined(level.teams[winningteam])) {
        globallogic_score::giveteamscoreforobjective(winningteam, 1);
    }
}

// Namespace prop
// Params 0, eflags: 0x0
// namespace_a9dea446<file_0>::function_e4e885e6
// Checksum 0xd1a36ca9, Offset: 0x1710
// Size: 0xba
function onroundswitch() {
    game["switchedsides"] = !game["switchedsides"];
    if (level.scoreroundwinbased) {
        foreach (team in level.teams) {
            [[ level._setteamscore ]](team, game["roundswon"][team]);
        }
    }
}

// Namespace prop
// Params 1, eflags: 0x0
// namespace_a9dea446<file_0>::function_3fcd5617
// Checksum 0xa92e100, Offset: 0x17d8
// Size: 0x80
function onroundendgame(var_18d04d1c) {
    gamewinner = var_18d04d1c;
    if (level.gameended) {
        gamewinner = function_c7ac59e(gamewinner, 1);
    }
    if (gamewinner == "allies" || gamewinner == "axis") {
        ph_setfinalkillcamwinner(gamewinner);
    }
    return gamewinner;
}

// Namespace prop
// Params 1, eflags: 0x0
// namespace_a9dea446<file_0>::function_96257f61
// Checksum 0x5913e0ec, Offset: 0x1860
// Size: 0x22
function determinewinner(roundwinner) {
    return function_c7ac59e(roundwinner, 0);
}

// Namespace prop
// Params 2, eflags: 0x0
// namespace_a9dea446<file_0>::function_c7ac59e
// Checksum 0x36e87ae6, Offset: 0x1890
// Size: 0x230
function function_c7ac59e(roundwinner, var_6ea8eea4) {
    gamewinner = roundwinner;
    var_f432b51f = "roundswon";
    level.proptiebreaker = "none";
    if (game[var_f432b51f]["allies"] == game[var_f432b51f]["axis"]) {
        level.proptiebreaker = "kills";
        if (game["propScore"]["axis"] == game["propScore"]["allies"]) {
            level.proptiebreaker = "time";
            if (game["hunterKillTime"]["axis"] == game["hunterKillTime"]["allies"]) {
                level.proptiebreaker = "tie";
                gamewinner = "tie";
            } else if (game["hunterKillTime"]["axis"] < game["hunterKillTime"]["allies"]) {
                gamewinner = "axis";
            } else {
                gamewinner = "allies";
            }
        } else if (game["propScore"]["axis"] > game["propScore"]["allies"]) {
            gamewinner = "axis";
        } else {
            gamewinner = "allies";
        }
        if (gamewinner != "tie" && var_6ea8eea4) {
            level thread givephteamscore(gamewinner);
        }
    } else if (game[var_f432b51f]["axis"] > game[var_f432b51f]["allies"]) {
        gamewinner = "axis";
    } else {
        gamewinner = "allies";
    }
    return gamewinner;
}

// Namespace prop
// Params 0, eflags: 0x0
// namespace_a9dea446<file_0>::function_5cee117d
// Checksum 0xe1e19167, Offset: 0x1ac8
// Size: 0x1c2
function onscoreclosemusic() {
    teamscores = [];
    while (!level.gameended) {
        scorelimit = level.scorelimit;
        scorethreshold = scorelimit * 0.1;
        scorethresholdstart = abs(scorelimit - scorethreshold);
        scorelimitcheck = scorelimit - 10;
        topscore = 0;
        runnerupscore = 0;
        foreach (team in level.teams) {
            score = [[ level._getteamscore ]](team);
            if (score > topscore) {
                runnerupscore = topscore;
                topscore = score;
                continue;
            }
            if (score > runnerupscore) {
                runnerupscore = score;
            }
        }
        scoredif = topscore - runnerupscore;
        if (topscore >= scorelimit * 0.5) {
            level notify(#"sndmusichalfway");
            return;
        }
        wait(1);
    }
}

// Namespace prop
// Params 0, eflags: 0x0
// namespace_a9dea446<file_0>::function_603848d5
// Checksum 0xff7a20ca, Offset: 0x1c98
// Size: 0xa2
function onplayerconnect() {
    while (true) {
        player = level waittill(#"connected");
        player.var_d1d70226 = 1;
        if (isdefined(level.allow_teamchange) && level.allow_teamchange == "0") {
            player.hasdonecombat = 1;
        }
        if (!isdefined(player.pers["objtime"])) {
            player.pers["objtime"] = 0;
        }
    }
}

// Namespace prop
// Params 0, eflags: 0x0
// namespace_a9dea446<file_0>::function_64875748
// Checksum 0xc0b6ee59, Offset: 0x1d48
// Size: 0xfa
function hidehudintermission() {
    level waittill(#"game_ended");
    if (useprophudserver()) {
        level.elim_hud.alpha = 0;
        if (level.phsettings.propwhistletime > 0) {
            level.phwhistletimer.alpha = 0;
            level.whistling.alpha = 0;
        }
    }
    foreach (player in level.players) {
        player prop_controls::propabilitykeysvisible(0);
    }
}

// Namespace prop
// Params 0, eflags: 0x0
// namespace_a9dea446<file_0>::function_34685338
// Checksum 0x24a9040e, Offset: 0x1e50
// Size: 0x73c
function onstartgametype() {
    setclientnamemode("manual_change");
    if (!isdefined(game["switchedsides"])) {
        game["switchedsides"] = 0;
    }
    if (game["switchedsides"]) {
        oldattackers = game["attackers"];
        olddefenders = game["defenders"];
        game["attackers"] = olddefenders;
        game["defenders"] = oldattackers;
    }
    level.displayroundendtext = 0;
    spawning::create_map_placed_influencers();
    level.spawnmins = (0, 0, 0);
    level.spawnmaxs = (0, 0, 0);
    util::setobjectivetext(game["attackers"], %OBJECTIVES_PH_ATTACKER);
    util::setobjectivetext(game["defenders"], %OBJECTIVES_PH_DEFENDER);
    util::setobjectivehinttext(game["attackers"], %OBJECTIVES_PH_ATTACKER_HINT);
    util::setobjectivehinttext(game["defenders"], %OBJECTIVES_PH_DEFENDER_HINT);
    if (level.splitscreen) {
        util::setobjectivescoretext(game["attackers"], %OBJECTIVES_PH_ATTACKER);
        util::setobjectivescoretext(game["defenders"], %OBJECTIVES_PH_DEFENDER);
    } else {
        util::setobjectivescoretext(game["attackers"], %OBJECTIVES_PH_ATTACKER_SCORE);
        util::setobjectivescoretext(game["defenders"], %OBJECTIVES_PH_DEFENDER_SCORE);
    }
    foreach (team in level.teams) {
        spawnlogic::add_spawn_points(team, "mp_tdm_spawn");
        spawnlogic::place_spawn_points(spawning::gettdmstartspawnname(team));
    }
    spawning::updateallspawnpoints();
    var_1210f0f7 = game["roundsplayed"] % 4 == 2 || game["roundsplayed"] % 4 == 3;
    if (var_1210f0f7) {
        game["switchedsides"] = !game["switchedsides"];
    }
    level.spawn_start = [];
    foreach (team in level.teams) {
        level.spawn_start[team] = spawnlogic::get_spawnpoint_array(spawning::gettdmstartspawnname(team));
    }
    if (var_1210f0f7) {
        game["switchedsides"] = !game["switchedsides"];
    }
    level.mapcenter = math::find_box_center(level.spawnmins, level.spawnmaxs);
    setmapcenter(level.mapcenter);
    spawnpoint = spawnlogic::get_random_intermission_point();
    setdemointermissionpoint(spawnpoint.origin, spawnpoint.angles);
    level thread onscoreclosemusic();
    if (!util::isoneround()) {
        level.displayroundendtext = 1;
        if (level.scoreroundwinbased) {
            globallogic_score::resetteamscores();
        }
    }
    if (isdefined(level.droppedtagrespawn) && level.droppedtagrespawn) {
        level.numlives = 1;
    }
    level._effect["propFlash"] = "explosions/fx_exp_grenade_concussion";
    level._effect["propDeathFX"] = "explosions/fx_prop_exp";
    if (!isdefined(game["propScore"])) {
        game["propScore"] = [];
        game["propScore"]["allies"] = 0;
        game["propScore"]["axis"] = 0;
    }
    if (!isdefined(game["propSurvivalTime"])) {
        game["propSurvivalTime"] = [];
        game["propSurvivalTime"]["allies"] = 0;
        game["propSurvivalTime"]["axis"] = 0;
    }
    if (!isdefined(game["hunterKillTime"])) {
        game["hunterKillTime"] = [];
        game["hunterKillTime"]["allies"] = 0;
        game["hunterKillTime"]["axis"] = 0;
    }
    level flag::init("props_hide_over", 0);
    level thread setuproundstarthud();
    if (level.phsettings.propwhistletime > 0) {
        level thread propwhistle();
    }
    level thread hidehudintermission();
    level thread monitortimers();
    level thread setphteamscores();
    level thread stillalivexp();
    level thread function_4bdf92a7();
    level thread tracktimealive();
}

// Namespace prop
// Params 1, eflags: 0x0
// namespace_a9dea446<file_0>::function_eed17dac
// Checksum 0x2586ab21, Offset: 0x2598
// Size: 0x8c
function function_eed17dac(weapon) {
    self.primaryweapon = weapon;
    self giveweapon(weapon);
    self switchtoweapon(weapon);
    self setspawnweapon(weapon);
    self.spawnweapon = weapon;
    self setblockweaponpickup(weapon, 1);
}

// Namespace prop
// Params 1, eflags: 0x0
// namespace_a9dea446<file_0>::function_f6c740a4
// Checksum 0x10ce3ad2, Offset: 0x2630
// Size: 0x54
function function_f6c740a4(weapon) {
    self.secondaryweapon = weapon;
    self giveweapon(weapon);
    self setblockweaponpickup(weapon, 1);
}

// Namespace prop
// Params 2, eflags: 0x0
// namespace_a9dea446<file_0>::function_c32f3fcc
// Checksum 0xd2271022, Offset: 0x2690
// Size: 0x7c
function function_c32f3fcc(primaryoffhand, primaryoffhandcount) {
    self giveweapon(primaryoffhand);
    self setweaponammostock(primaryoffhand, primaryoffhandcount);
    self switchtooffhand(primaryoffhand);
    self.grenadetypeprimary = primaryoffhand;
    self.grenadetypeprimarycount = primaryoffhandcount;
}

// Namespace prop
// Params 2, eflags: 0x0
// namespace_a9dea446<file_0>::function_5ca26274
// Checksum 0x1cf56a48, Offset: 0x2718
// Size: 0x7c
function function_5ca26274(secondaryoffhand, secondaryoffhandcount) {
    self giveweapon(secondaryoffhand);
    self setweaponammoclip(secondaryoffhand, secondaryoffhandcount);
    self switchtooffhand(secondaryoffhand);
    self.grenadetypesecondary = secondaryoffhand;
    self.grenadetypesecondarycount = secondaryoffhandcount;
}

// Namespace prop
// Params 1, eflags: 0x0
// namespace_a9dea446<file_0>::function_c389b506
// Checksum 0x8966626e, Offset: 0x27a0
// Size: 0x3c
function giveperk(perkname) {
    if (!self hasperk(perkname)) {
        self setperk(perkname);
    }
}

// Namespace prop
// Params 0, eflags: 0x0
// namespace_a9dea446<file_0>::function_ed44e709
// Checksum 0x8a8f4ec5, Offset: 0x27e8
// Size: 0x3f6
function givecustomloadout() {
    loadout::function_79d05183(1);
    loadout::function_1d84af77(self.curclass);
    self clearperks();
    weapon = undefined;
    if (self util::isprop()) {
        weapon = getweapon("pistol_standard");
        self function_eed17dac(weapon);
        self function_c32f3fcc(getweapon("null_offhand_primary"), 0);
        self function_5ca26274(getweapon("null_offhand_secondary"), 0);
        self giveperk("specialty_quieter");
        self giveperk("specialty_fastladderclimb");
        self giveperk("specialty_fastmantle");
        self giveperk("specialty_jetcharger");
    } else {
        weapon = getweapon("pistol_standard");
        self function_f6c740a4(weapon);
        attachments = array();
        attachments[attachments.size] = "extclip";
        attachments[attachments.size] = "steadyaim";
        weapon = getweapon("smg_standard", attachments);
        self function_eed17dac(weapon);
        if (!function_503c9413()) {
            self function_c32f3fcc(getweapon("concussion_grenade"), 2);
        } else {
            self function_c32f3fcc(getweapon("null_offhand_primary"), 0);
        }
        self function_5ca26274(getweapon("null_offhand_secondary"), 0);
        self attackerinitammo();
        self giveperk("specialty_twogrenades");
        self giveperk("specialty_fastladderclimb");
        self giveperk("specialty_fastmantle");
        self giveperk("specialty_longersprint");
        self giveperk("specialty_sprintfire");
        self giveperk("specialty_jetcharger");
    }
    self giveweapon(level.weaponbasemelee);
    self notify(#"applyloadout");
    return weapon;
}

// Namespace prop
// Params 0, eflags: 0x0
// namespace_a9dea446<file_0>::function_654742d1
// Checksum 0xcf0c7165, Offset: 0x2be8
// Size: 0x1a
function is_player_gamepad_enabled() {
    return self gamepadusedlast();
}

// Namespace prop
// Params 1, eflags: 0x0
// namespace_a9dea446<file_0>::function_f8329ffe
// Checksum 0xe2bc55eb, Offset: 0x2c10
// Size: 0x64
function whistlestarttimer(duration) {
    level notify(#"hash_8e0e8406");
    counttime = int(duration);
    if (counttime >= 0) {
        thread whistlestarttimer_internal(counttime);
    }
}

// Namespace prop
// Params 1, eflags: 0x0
// namespace_a9dea446<file_0>::function_1dcf16b2
// Checksum 0x96c8606, Offset: 0x2c80
// Size: 0x40
function whistlestarttimer_internal(counttime) {
    level endon(#"hash_8e0e8406");
    waittillframeend();
    while (counttime > 0 && !level.gameended) {
        counttime--;
        wait(1);
    }
}

// Namespace prop
// Params 0, eflags: 0x0
// namespace_a9dea446<file_0>::function_adfee0f5
// Checksum 0xdec30f7d, Offset: 0x2cc8
// Size: 0x34
function useprophudserver() {
    /#
        if (getdvarint("OBJECTIVES_PH_DEFENDER_SCORE", 0) != 0) {
            return true;
        }
    #/
    return true;
}

// Namespace prop
// Params 0, eflags: 0x0
// namespace_a9dea446<file_0>::function_a4d3e3cf
// Checksum 0xb96c9259, Offset: 0x2d08
// Size: 0x4c0
function setuproundstarthud() {
    level.phcountdowntimer = hud::createservertimer("default", 1.5);
    level.phcountdowntimer hud::setpoint("CENTER", undefined, 0, 50);
    level.phcountdowntimer.label = %MP_PH_STARTS_IN;
    level.phcountdowntimer.alpha = 0;
    level.phcountdowntimer.archived = 0;
    level.phcountdowntimer.hidewheninmenu = 1;
    level.phcountdowntimer.sort = 1;
    if (useprophudserver()) {
        var_62372e41 = 110;
        var_ff475784 = 20;
        if (!level.console) {
            var_62372e41 = 125;
            var_ff475784 = 15;
        }
        level.elim_hud = hud::createserverfontstring("default", 1.5);
        level.elim_hud.label = %MP_PH_ALIVE;
        level.elim_hud setvalue(0);
        level.elim_hud.x = 5;
        level.elim_hud.y = var_62372e41;
        level.elim_hud.alignx = "left";
        level.elim_hud.aligny = "top";
        level.elim_hud.horzalign = "left";
        level.elim_hud.vertalign = "top";
        level.elim_hud.archived = 1;
        level.elim_hud.alpha = 0;
        level.elim_hud.glowalpha = 0;
        level.elim_hud.hidewheninmenu = 0;
        level thread eliminatedhudmonitor();
        if (level.phsettings.propwhistletime > 0) {
            level.phwhistletimer = hud::createservertimer("default", 1.5);
            level.phwhistletimer.x = 5;
            level.phwhistletimer.y = var_62372e41 + var_ff475784;
            level.phwhistletimer.alignx = "left";
            level.phwhistletimer.aligny = "top";
            level.phwhistletimer.horzalign = "left";
            level.phwhistletimer.vertalign = "top";
            level.phwhistletimer.label = %MP_PH_WHISTLE_IN;
            level.phwhistletimer.alpha = 0;
            level.phwhistletimer.archived = 1;
            level.phwhistletimer.hidewheninmenu = 0;
            level.phwhistletimer settimer(120);
            level.whistling = hud::createserverfontstring("default", 1.5);
            level.whistling.label = %MP_PH_WHISTLING;
            level.whistling.x = 5;
            level.whistling.y = var_62372e41 + var_ff475784;
            level.whistling.alignx = "left";
            level.whistling.aligny = "top";
            level.whistling.horzalign = "left";
            level.whistling.vertalign = "top";
            level.whistling.archived = 1;
            level.whistling.alpha = 0;
            level.whistling.glowalpha = 0.2;
            level.whistling.hidewheninmenu = 0;
        }
    }
}

// Namespace prop
// Params 0, eflags: 0x0
// namespace_a9dea446<file_0>::function_e820472
// Checksum 0x1a4126d1, Offset: 0x31d0
// Size: 0xa8
function eliminatedhudmonitor() {
    level endon(#"game_ended");
    while (true) {
        props = get_alive_nonspecating_players(game["defenders"]);
        level.elim_hud setvalue(props.size);
        level util::waittill_any("player_spawned", "player_killed", "player_eliminated", "playerCountChanged", "propCountChanged", "playerDisconnected");
    }
}

// Namespace prop
// Params 1, eflags: 0x0
// namespace_a9dea446<file_0>::function_19169d0a
// Checksum 0x8b99a61e, Offset: 0x3280
// Size: 0x114
function get_alive_nonspecating_players(team) {
    var_184db3e = [];
    foreach (player in level.players) {
        if (!isdefined(player.sessionstate) || isdefined(player) && isalive(player) && player.sessionstate == "playing") {
            if (!isdefined(team) || player.team == team) {
                var_184db3e[var_184db3e.size] = player;
            }
        }
    }
    return var_184db3e;
}

// Namespace prop
// Params 0, eflags: 0x0
// namespace_a9dea446<file_0>::function_2163426b
// Checksum 0x82f3cd94, Offset: 0x33a0
// Size: 0x3c
function onplayerdisconnect() {
    level notify(#"playerdisconnected");
    if (function_503c9413()) {
        thread function_c021720c(0.05);
    }
}

// Namespace prop
// Params 0, eflags: 0x0
// namespace_a9dea446<file_0>::function_45c842e9
// Checksum 0x7c5dd289, Offset: 0x33e8
// Size: 0x28
function function_45c842e9() {
    while (!(isdefined(level.prematch_over) && level.prematch_over)) {
        wait(0.05);
    }
}

// Namespace prop
// Params 1, eflags: 0x0
// namespace_a9dea446<file_0>::function_19bc9234
// Checksum 0x5c053775, Offset: 0x3418
// Size: 0x35c
function onspawnplayer(predictedspawn) {
    self.breathingstoptime = 0;
    if (self util::isprop()) {
        self.var_292246d3 = undefined;
        if (!isdefined(self.abilityleft)) {
            self.abilityleft = 0;
        }
        if (!isdefined(self.clonesleft)) {
            self.clonesleft = 0;
        }
        if (!isdefined(self.pers["ability"])) {
            self.pers["ability"] = 0;
        }
        self.currentability = level.abilities[self.pers["ability"]];
        if (useprophudserver()) {
            self thread prop_controls::propcontrolshud();
        }
        self.isangleoffset = 0;
        changecount = int(level.phsettings.propchangecount);
        abilitycount = undefined;
        var_4a6a29c9 = undefined;
        if (isdefined(self.spawnedonce) && isdefined(self.changesleft)) {
            changecount = self.changesleft;
            abilitycount = self.abilityleft;
            var_4a6a29c9 = self.clonesleft;
        }
        self prop_controls::propsetchangesleft(changecount);
        self prop_controls::setnewabilitycount(self.currentability, abilitycount);
        self prop_controls::setnewabilitycount("CLONE", var_4a6a29c9);
        self thread prop_controls::cleanuppropcontrolshudondeath();
        self thread handleprop();
    } else {
        self.abilityleft = undefined;
        self.clonesleft = undefined;
        if (!isdefined(self.var_292246d3)) {
            self.var_292246d3 = 0;
        }
        if (!isdefined(self.thrownspecialcount)) {
            self.thrownspecialcount = 0;
        }
        if (useprophudserver()) {
            self thread prop_controls::function_bf45ce54();
        }
        var_292246d3 = level.phsettings.var_60a20fdc;
        if (isdefined(self.spawnedonce) && isdefined(self.var_292246d3)) {
            var_292246d3 = self.var_292246d3;
        }
        self prop_controls::function_afeda2bf(var_292246d3);
        self thread prop_controls::function_227409a5();
        self thread function_346bdc3b();
    }
    self thread attackerswaittime();
    if (level.usestartspawns && !level.ingraceperiod && !level.playerqueuedrespawn) {
        level.usestartspawns = 0;
    }
    self.spawnedonce = 1;
    spawning::onspawnplayer(predictedspawn);
}

// Namespace prop
// Params 0, eflags: 0x0
// namespace_a9dea446<file_0>::function_a709d71f
// Checksum 0x4391ebd5, Offset: 0x3780
// Size: 0x2a4
function monitortimers() {
    level endon(#"game_ended");
    function_45c842e9();
    level.allow_teamchange = "0";
    foreach (player in level.players) {
        player.hasdonecombat = 1;
    }
    level thread function_cdee7177();
    if (level.phsettings.prophidetime > 0) {
        level.phcountdowntimer settimer(level.phsettings.prophidetime);
        level.phcountdowntimer.alpha = 1;
    }
    if (useprophudserver() && level.phsettings.propwhistletime > 0) {
        level.phwhistletimer settimer(level.phsettings.propwhistletime + level.phsettings.prophidetime);
    }
    if (level.phsettings.prophidetime > 0 || level.phsettings.propwhistletime > 0) {
        whistlestarttimer(level.phsettings.propwhistletime + level.phsettings.prophidetime);
    }
    if (level.phsettings.prophidetime > 0) {
        function_da184fd(level.phsettings.prophidetime);
    }
    level flag::set("props_hide_over");
    if (useprophudserver()) {
        if (level.phsettings.propwhistletime > 0) {
            level.phwhistletimer.alpha = 1;
        }
        level.elim_hud.alpha = 1;
    }
    level.phcountdowntimer.alpha = 0;
}

// Namespace prop
// Params 0, eflags: 0x0
// namespace_a9dea446<file_0>::function_cdee7177
// Checksum 0x2e075c78, Offset: 0x3a30
// Size: 0x240
function function_cdee7177() {
    level endon(#"game_ended");
    level endon(#"props_hide_over");
    var_8cbf9eb6 = int(level.phsettings.prophidetime + gettime() / 1000);
    totaltimepassed = 0;
    while (true) {
        level waittill(#"host_migration_begin");
        level.phcountdowntimer.alpha = 0;
        if (useprophudserver() && level.phsettings.propwhistletime > 0) {
            level.phwhistletimer.alpha = 0;
        }
        timepassed = int(hostmigration::waittillhostmigrationdone() / 1000);
        totaltimepassed += timepassed;
        timepassed = totaltimepassed;
        var_c1ce6993 = var_8cbf9eb6 + timepassed - int(gettime() / 1000);
        level.phcountdowntimer settimer(var_c1ce6993);
        if (useprophudserver() && level.phsettings.propwhistletime > 0) {
            level.phwhistletimer settimer(level.phsettings.propwhistletime + var_c1ce6993);
        }
        whistlestarttimer(level.phsettings.propwhistletime + var_c1ce6993);
        level.phcountdowntimer.alpha = 1;
        if (useprophudserver() && level.phsettings.propwhistletime > 0) {
            level.phwhistletimer.alpha = 1;
        }
    }
}

// Namespace prop
// Params 0, eflags: 0x0
// namespace_a9dea446<file_0>::function_cb041a54
// Checksum 0xe45d0321, Offset: 0x3c78
// Size: 0x244
function handleprop() {
    level endon(#"game_ended");
    self endon(#"disconnect");
    self endon(#"death");
    self waittill(#"applyloadout");
    self allowprone(0);
    self allowcrouch(0);
    self allowsprint(0);
    self allowslide(0);
    self setmovespeedscale(level.phsettings.propspeedscale);
    self playerknockback(0);
    self takeallweapons();
    self allowspectateteam(game["attackers"], 1);
    self ghost();
    self setclientuivisibilityflag("weapon_hud_visible", 0);
    self.healthregendisabled = 1;
    self.concussionimmune = undefined;
    assert(!isdefined(self.prop));
    self thread setupprop();
    self thread prop_controls::setupkeybindings();
    self thread setupdamage();
    self thread prop_controls::propinputwatch();
    self thread propwatchdeath();
    self thread propwatchcleanupondisconnect();
    self thread propwatchcleanuponroundend();
    self thread propwatchprematchsettings();
}

// Namespace prop
// Params 1, eflags: 0x0
// namespace_a9dea446<file_0>::function_f5d1e526
// Checksum 0xca4e0f, Offset: 0x3ec8
// Size: 0x9a
function getthirdpersonrangeforsize(propsize) {
    switch (propsize) {
    case 50:
        return 120;
    case 100:
        return -106;
    case 250:
        return -76;
    case 450:
        return 260;
    case 550:
        return 320;
    default:
        assertmsg("CENTER" + propsize);
        break;
    }
    return 120;
}

// Namespace prop
// Params 1, eflags: 0x0
// namespace_a9dea446<file_0>::function_ee3f924d
// Checksum 0x27dfc3c5, Offset: 0x3f70
// Size: 0x90
function getthirdpersonheightoffsetforsize(propsize) {
    switch (propsize) {
    case 50:
        return -30;
    case 100:
        return -20;
    case 250:
        return 0;
    case 450:
        return 20;
    case 550:
        return 40;
    default:
        assertmsg("CENTER" + propsize);
        break;
    }
    return 0;
}

// Namespace prop
// Params 0, eflags: 0x0
// namespace_a9dea446<file_0>::function_8e2d867d
// Checksum 0x25ecc0d4, Offset: 0x4008
// Size: 0x16c
function applyxyzoffset() {
    if (!isdefined(self.prop.xyzoffset)) {
        return;
    }
    self.prop.angles = self.angles;
    forward = anglestoforward(self.prop.angles) * self.prop.xyzoffset[0];
    right = anglestoright(self.prop.angles) * self.prop.xyzoffset[1];
    up = anglestoup(self.prop.angles) * self.prop.xyzoffset[2];
    self.prop.origin += forward;
    self.prop.origin += right;
    self.prop.origin += up;
}

// Namespace prop
// Params 0, eflags: 0x0
// namespace_a9dea446<file_0>::function_ab42f726
// Checksum 0xa9d99ab1, Offset: 0x4180
// Size: 0x70
function applyanglesoffset() {
    if (!isdefined(self.prop.anglesoffset)) {
        return;
    }
    self.prop.angles = self.angles;
    self.prop.angles += self.prop.anglesoffset;
    self.isangleoffset = 1;
}

// Namespace prop
// Params 0, eflags: 0x0
// namespace_a9dea446<file_0>::function_f5596948
// Checksum 0x661124d9, Offset: 0x41f8
// Size: 0x510
function propwhistle() {
    level endon(#"game_ended");
    function_45c842e9();
    time = gettime();
    whistletime = level.phsettings.propwhistletime * 1000;
    var_d97f029 = 20000;
    var_7335da26 = var_d97f029;
    var_defcb34f = 500;
    var_c3f83285 = 5000;
    var_2812d72a = 0;
    var_1bb1b603 = (0, 0, 0);
    minimapcorners = getentarray("minimap_corner", "targetname");
    if (minimapcorners.size > 0) {
        var_1bb1b603 = minimapcorners[0].origin;
    }
    hostmigration::waitlongdurationwithhostmigrationpause(level.phsettings.prophidetime + level.phsettings.propwhistletime);
    while (true) {
        if (time + whistletime - var_defcb34f < gettime()) {
            var_2812d72a++;
            if (useprophudserver()) {
                level.phwhistletimer.alpha = 0;
                level.whistling.alpha = 1;
                level.whistling fadeovertime(0.75);
                level.whistling.alpha = 0.6;
            }
            sortedplayers = arraysortclosest(level.players, var_1bb1b603);
            foreach (player in sortedplayers) {
                if (!isdefined(player)) {
                    continue;
                }
                if (player util::isprop() && isalive(player)) {
                    playsoundatposition("mpl_phunt_char_whistle", player.origin + (0, 0, 60));
                    hostmigration::waitlongdurationwithhostmigrationpause(1.5);
                }
            }
            time = gettime();
            if (var_2812d72a % 2 == 0) {
                whistletime = max(whistletime - 5000, var_d97f029);
            }
            if (var_7335da26 >= globallogic_utils::gettimeremaining() - var_c3f83285) {
                if (useprophudserver()) {
                    level.whistling.alpha = 0;
                }
                return;
            } else {
                if (var_7335da26 * 2 + getteamplayersalive(game["defenders"]) * 2500 >= globallogic_utils::gettimeremaining() - var_c3f83285) {
                    if (useprophudserver()) {
                        level.phwhistletimer.label = %MP_PH_FINAL_WHISTLE;
                    }
                    var_7335da26 += getteamplayersalive(game["defenders"]) * 2500;
                }
                if (useprophudserver()) {
                    level.phwhistletimer settimer(int(whistletime / 1000));
                }
                whistlestarttimer(int(whistletime / 1000));
                if (useprophudserver()) {
                    level.whistling.alpha = 0;
                    level.phwhistletimer.alpha = 1;
                }
            }
        }
        hostmigration::waitlongdurationwithhostmigrationpause(0.5);
    }
}

// Namespace prop
// Params 1, eflags: 0x0
// namespace_a9dea446<file_0>::function_59938cba
// Checksum 0x8b04abf0, Offset: 0x4710
// Size: 0xe8
function getlivingplayersonteam(team) {
    players = [];
    foreach (player in level.players) {
        if (!isdefined(player.team)) {
            continue;
        }
        if (isalive(player) && player.team == team) {
            players[players.size] = player;
        }
    }
    return players;
}

// Namespace prop
// Params 0, eflags: 0x0
// namespace_a9dea446<file_0>::function_b9b7bc13
// Checksum 0x362c1b42, Offset: 0x4800
// Size: 0x94
function setupdamage() {
    level endon(#"game_ended");
    self endon(#"death");
    self endon(#"disconnect");
    hostmigration::waitlongdurationwithhostmigrationpause(0.5);
    self.prop.health = 99999;
    self.prop.maxhealth = 99999;
    self.prop thread function_500dc7d9(&damagewatch);
}

// Namespace prop
// Params 1, eflags: 0x0
// namespace_a9dea446<file_0>::function_500dc7d9
// Checksum 0xffbac6f4, Offset: 0x48a0
// Size: 0xea
function function_500dc7d9(damagecallback) {
    level endon(#"game_ended");
    self endon(#"death");
    while (true) {
        damage, attacker, direction_vec, point, meansofdeath, modelname, tagname, partname, weapon, idflags = self waittill(#"damage");
        self thread [[ damagecallback ]](damage, attacker, direction_vec, point, meansofdeath, modelname, tagname, partname, weapon, idflags);
    }
}

// Namespace prop
// Params 10, eflags: 0x0
// namespace_a9dea446<file_0>::function_4e257327
// Checksum 0xea1dfa14, Offset: 0x4998
// Size: 0x1a4
function damagewatch(damage, attacker, direction_vec, point, meansofdeath, modelname, tagname, partname, weapon, idflags) {
    if (!isdefined(attacker)) {
        return;
    }
    if (!isdefined(self.owner)) {
        return;
    }
    if (isplayer(attacker)) {
        if (attacker.pers["team"] == self.owner.pers["team"]) {
            return;
        }
        attacker thread damagefeedback::update();
        if (isdefined(weapon) && weapon.rootweapon.name == "concussion_grenade" && isdefined(meansofdeath) && meansofdeath != "MOD_IMPACT") {
            prop_controls::function_770b4cfa(attacker, undefined, meansofdeath, damage, point, weapon);
        }
    }
    self.owner dodamage(damage, point, attacker, attacker, "none", meansofdeath, idflags, weapon);
    self.health = 99999;
    self.maxhealth = 99999;
}

// Namespace prop
// Params 0, eflags: 0x0
// namespace_a9dea446<file_0>::function_3709202e
// Checksum 0xe0078065, Offset: 0x4b48
// Size: 0x54
function propcleanup() {
    array = array(self.prop, self.propanchor, self.propent);
    self thread propcleanupdelayed(array);
}

// Namespace prop
// Params 1, eflags: 0x0
// namespace_a9dea446<file_0>::function_e8efbeec
// Checksum 0xcbecfa76, Offset: 0x4ba8
// Size: 0x12a
function propcleanupdelayed(propents) {
    foreach (prop in propents) {
        if (isdefined(prop)) {
            prop unlink();
        }
    }
    wait(0.05);
    foreach (prop in propents) {
        if (isdefined(prop)) {
            prop delete();
        }
    }
}

// Namespace prop
// Params 0, eflags: 0x0
// namespace_a9dea446<file_0>::function_f8469ff3
// Checksum 0x2e066590, Offset: 0x4ce0
// Size: 0xf4
function propwatchdeath() {
    level endon(#"game_ended");
    self endon(#"disconnect");
    self waittill(#"death");
    corpse = self.body;
    playsoundatposition("wpn_flash_grenade_explode", self.prop.origin + (0, 0, 4));
    playfx(fx::get("propDeathFX"), self.prop.origin + (0, 0, 4));
    if (isdefined(corpse)) {
        corpse delete();
    }
    self propcleanup();
}

// Namespace prop
// Params 0, eflags: 0x0
// namespace_a9dea446<file_0>::function_fea5a874
// Checksum 0x68a2a40, Offset: 0x4de0
// Size: 0x64
function propwatchcleanupondisconnect() {
    self notify(#"propwatchcleanupondisconnect");
    self endon(#"propwatchcleanupondisconnect");
    level endon(#"game_ended");
    self waittill(#"disconnect");
    self propcleanup();
    self propclonecleanup();
}

// Namespace prop
// Params 0, eflags: 0x0
// namespace_a9dea446<file_0>::function_b377fd75
// Checksum 0xf7517c8e, Offset: 0x4e50
// Size: 0x64
function propwatchcleanuponroundend() {
    self notify(#"hash_739978c9");
    self endon(#"hash_739978c9");
    self endon(#"disconnect");
    level waittill(#"round_end_done");
    self propcleanup();
    self propclonecleanup();
}

// Namespace prop
// Params 0, eflags: 0x0
// namespace_a9dea446<file_0>::function_bdee0913
// Checksum 0x1edac8e7, Offset: 0x4ec0
// Size: 0xa2
function propclonecleanup() {
    if (isdefined(self.propclones)) {
        foreach (clone in self.propclones) {
            if (isdefined(clone)) {
                clone delete();
            }
        }
    }
}

// Namespace prop
// Params 0, eflags: 0x0
// namespace_a9dea446<file_0>::function_80c4a292
// Checksum 0x85a6b66d, Offset: 0x4f70
// Size: 0x8c
function propwatchprematchsettings() {
    self endon(#"death");
    self endon(#"disconnect");
    self endon(#"joined_team");
    self endon(#"joined_spectators");
    function_45c842e9();
    self allowprone(0);
    self allowcrouch(0);
    self allowsprint(0);
}

// Namespace prop
// Params 1, eflags: 0x0
// namespace_a9dea446<file_0>::function_ca08f561
// Checksum 0x2f9a7ef5, Offset: 0x5008
// Size: 0x22
function organizeproplist(inarray) {
    return array::randomize(inarray);
}

// Namespace prop
// Params 0, eflags: 0x0
// namespace_a9dea446<file_0>::function_b406e466
// Checksum 0xcba70919, Offset: 0x5038
// Size: 0x194
function randgetpropsizetoallocate() {
    var_77353f29 = 10 * isdefined(level.proplist[50]);
    var_9c7a2639 = 30 * isdefined(level.proplist[100]);
    var_ce32b3a9 = 40 * isdefined(level.proplist[-6]);
    var_9e5e7c71 = 20 * isdefined(level.proplist[450]);
    var_ff0ae5a1 = 10 * isdefined(level.proplist[550]);
    randomrange = var_77353f29 + var_9c7a2639 + var_ce32b3a9 + var_9e5e7c71 + var_ff0ae5a1;
    randomval = randomint(randomrange);
    if (randomval < var_77353f29) {
        return 50;
    }
    randomval -= var_77353f29;
    if (randomval < var_9c7a2639) {
        return 100;
    }
    randomval -= var_9c7a2639;
    if (randomval < var_ce32b3a9) {
        return -6;
    }
    randomval -= var_ce32b3a9;
    if (randomval < var_9e5e7c71) {
        return 450;
    }
    randomval -= var_9e5e7c71;
    return 550;
}

// Namespace prop
// Params 1, eflags: 0x0
// namespace_a9dea446<file_0>::function_48fae717
// Checksum 0xe4c7660c, Offset: 0x51d8
// Size: 0x2ae
function getnextprop(inplayer) {
    var_951c47b8 = randgetpropsizetoallocate();
    var_5ed17249 = getarraykeys(level.proplist);
    var_5ed17249 = array::randomize(var_5ed17249);
    var_fb988098 = array(var_951c47b8);
    foreach (size in var_5ed17249) {
        if (size != var_951c47b8) {
            var_fb988098[var_fb988098.size] = size;
        }
    }
    prop = undefined;
    for (i = 0; i < var_fb988098.size; i++) {
        size = var_fb988098[i];
        if (!isdefined(level.proplist[size]) || !level.proplist[size].size) {
            continue;
        }
        var_ecfadf1a = array::randomize(level.proplist[size]);
        for (j = 0; j < var_ecfadf1a.size; j++) {
            prop = var_ecfadf1a[j];
            var_c8c6579 = 0;
            if (isdefined(inplayer.usedprops) && inplayer.usedprops.size) {
                for (index = 0; index < inplayer.usedprops.size; index++) {
                    if (prop.modelname == inplayer.usedprops[index].modelname) {
                        var_c8c6579 = 1;
                        break;
                    }
                }
            }
            if (!var_c8c6579) {
                return prop;
            }
        }
    }
    return prop;
}

// Namespace prop
// Params 0, eflags: 0x0
// namespace_a9dea446<file_0>::function_a8429dd2
// Checksum 0x4e2ab164, Offset: 0x5490
// Size: 0xa
function getmapname() {
    return level.script;
}

// Namespace prop
// Params 3, eflags: 0x0
// namespace_a9dea446<file_0>::function_adf2659a
// Checksum 0x2957c57b, Offset: 0x54a8
// Size: 0x62
function tablelookupbyrow(var_8c6b47e7, rowindex, columnindex) {
    columns = tablelookuprow(var_8c6b47e7, rowindex);
    if (columnindex < columns.size) {
        return columns[columnindex];
    }
    return "";
}

// Namespace prop
// Params 0, eflags: 0x0
// namespace_a9dea446<file_0>::function_b88eecdc
// Checksum 0x215cda39, Offset: 0x5518
// Size: 0x52c
function populateproplist() {
    mapname = getmapname();
    var_8c6b47e7 = "gamedata/tables/mp/" + mapname + "_ph.csv";
    numrows = tablelookuprowcount(var_8c6b47e7);
    for (rowindex = 0; rowindex < numrows; rowindex++) {
        modelname = tablelookupbyrow(var_8c6b47e7, rowindex, 0);
        propsizetext = tablelookupbyrow(var_8c6b47e7, rowindex, 1);
        propscale = float(tablelookupbyrow(var_8c6b47e7, rowindex, 2));
        offsetx = int(tablelookupbyrow(var_8c6b47e7, rowindex, 3));
        offsety = int(tablelookupbyrow(var_8c6b47e7, rowindex, 4));
        offsetz = int(tablelookupbyrow(var_8c6b47e7, rowindex, 5));
        rotationx = int(tablelookupbyrow(var_8c6b47e7, rowindex, 6));
        rotationy = int(tablelookupbyrow(var_8c6b47e7, rowindex, 7));
        rotationz = int(tablelookupbyrow(var_8c6b47e7, rowindex, 8));
        propheight = tablelookupbyrow(var_8c6b47e7, rowindex, 9);
        proprange = tablelookupbyrow(var_8c6b47e7, rowindex, 10);
        offset = undefined;
        if (isdefined(offsetx) && isdefined(offsety) && isdefined(offsetz)) {
            offset = (offsetx, offsety, offsetz);
        }
        rotation = undefined;
        if (isdefined(rotationx) && isdefined(rotationy) && isdefined(rotationz)) {
            rotation = (rotationx, rotationy, rotationz);
        }
        if (!isdefined(propscale) || propscale == 0) {
            propscale = 1;
        }
        propsize = getpropsize(propsizetext);
        if (!isdefined(propheight) || propheight == "") {
            propheight = getthirdpersonheightoffsetforsize(propsize);
        } else {
            propheight = int(propheight);
        }
        if (!isdefined(proprange) || proprange == "") {
            proprange = getthirdpersonrangeforsize(propsize);
        } else {
            proprange = int(proprange);
        }
        addproptolist(modelname, propsize, offset, rotation, propsizetext, propscale, propheight, proprange);
    }
    if (numrows == 0) {
        addproptolist("tag_origin", -6, (0, 0, 0), (0, 0, 0), "medium", 1, getthirdpersonheightoffsetforsize(-6), getthirdpersonrangeforsize(-6));
    }
    level.proplist = organizeproplist(level.proplist);
}

// Namespace prop
// Params 0, eflags: 0x0
// namespace_a9dea446<file_0>::function_461f5243
// Checksum 0x60986db1, Offset: 0x5a50
// Size: 0x514
function setupprop() {
    self notsolid();
    if (!isdefined(level.phsettings.playercontents) || level.phsettings.playercontents == 0) {
        level.phsettings.playercontents = self setcontents(0);
    } else {
        self setcontents(0);
    }
    self setplayercollision(0);
    propinfo = self.propinfo;
    if (!isdefined(self.propinfo)) {
        propinfo = getnextprop(self);
    }
    self.propanchor = spawn("script_model", self.origin);
    self.propanchor.targetname = "propAnchor";
    self.propanchor linkto(self);
    self.propanchor setcontents(0);
    self.propanchor notsolid();
    self.propanchor setplayercollision(0);
    self.propent = spawn("script_model", self.origin);
    self.propent.targetname = "propEnt";
    self.propent linkto(self.propanchor);
    self.propent setcontents(0);
    self.propent notsolid();
    self.propent setplayercollision(0);
    self.prop = spawn("script_model", self.propent.origin);
    self.prop.targetname = "prop";
    self.prop setmodel(propinfo.modelname);
    self.prop setscale(propinfo.propscale, 1);
    self.prop setcandamage(1);
    self.prop setowner(self);
    self.prop setteam(self.team);
    self.prop.xyzoffset = propinfo.xyzoffset;
    self.prop.anglesoffset = propinfo.anglesoffset;
    self applyxyzoffset();
    self applyanglesoffset();
    self.prop linkto(self.propent);
    self.prop.owner = self;
    self.prop.health = 10000;
    self.prop setplayercollision(0);
    self.prop function_344baafe();
    self.prop clientfield::set("enemyequip", 1);
    if (function_503c9413()) {
        self thread function_f2704a3c(0);
    }
    self.thirdpersonrange = propinfo.proprange;
    self.thirdpersonheightoffset = propinfo.propheight;
    self setclientthirdperson(1, self.thirdpersonrange, self.thirdpersonheightoffset);
    self.prop.info = propinfo;
    self.propinfo = propinfo;
    if (!isdefined(self.spawnedonce)) {
        self.usedprops = [];
    }
    self.health = getprophealth(propinfo);
    self.maxhealth = self.health;
}

// Namespace prop
// Params 1, eflags: 0x0
// namespace_a9dea446<file_0>::function_9db20286
// Checksum 0x2101f25, Offset: 0x5f70
// Size: 0x2a
function getprophealth(propinfo) {
    return int(propinfo.propsize);
}

// Namespace prop
// Params 1, eflags: 0x0
// namespace_a9dea446<file_0>::function_caf0c217
// Checksum 0xf2a22353, Offset: 0x5fa8
// Size: 0x146
function getpropsize(propsizetext) {
    /#
        if (propsizetext == "weapon_hud_visible") {
            return 0;
        }
    #/
    propsize = 0;
    switch (propsizetext) {
    case 99:
        propsize = 50;
        break;
    case 97:
        propsize = 100;
        break;
    case 90:
        propsize = -6;
        break;
    case 96:
        propsize = 450;
        break;
    case 98:
        propsize = 550;
        break;
    default:
        mapname = getmapname();
        var_8c6b47e7 = "gamedata/tables/mp/" + mapname + "_ph.csv";
        assertmsg("wpn_flash_grenade_explode" + propsizetext + "kill" + var_8c6b47e7 + "bestPlayerWeapon");
        propsize = 100;
        break;
    }
    return propsize;
}

// Namespace prop
// Params 8, eflags: 0x0
// namespace_a9dea446<file_0>::function_20a3ce
// Checksum 0xbd9efeb1, Offset: 0x60f8
// Size: 0x1f8
function addproptolist(modelname, propsize, xyzoffset, anglesoffset, propsizetext, propscale, propheight, proprange) {
    if (!isdefined(level.proplist)) {
        level.proplist = [];
    }
    if (!isdefined(level.propindex)) {
        level.propindex = [];
    }
    if (!isdefined(level.proplist[propsize])) {
        level.proplist[propsize] = [];
    }
    propinfo = spawnstruct();
    propinfo.modelname = modelname;
    propinfo.propscale = propscale;
    propinfo.propsize = int(propsize);
    propinfo.propsizetext = propsizetext;
    if (isdefined(xyzoffset)) {
        propinfo.xyzoffset = xyzoffset;
    }
    if (isdefined(anglesoffset)) {
        propinfo.anglesoffset = anglesoffset;
    }
    propinfo.proprange = proprange;
    propinfo.propheight = propheight;
    index = level.propindex.size;
    level.propindex[index] = [];
    level.propindex[index][0] = propsize;
    level.propindex[index][1] = level.proplist[propsize].size;
    level.proplist[propsize][level.proplist[propsize].size] = propinfo;
}

// Namespace prop
// Params 2, eflags: 0x0
// namespace_a9dea446<file_0>::function_bef93685
// Checksum 0x6fde2c98, Offset: 0x62f8
// Size: 0x7c
function ph_endgame(winningteam, endreasontext) {
    if (isdefined(level.endingph) && level.endingph) {
        return;
    }
    level.endingph = 1;
    ph_setfinalkillcamwinner(winningteam);
    thread globallogic::endgame(winningteam, endreasontext);
    level thread givephteamscore(winningteam);
}

// Namespace prop
// Params 1, eflags: 0x0
// namespace_a9dea446<file_0>::function_21226800
// Checksum 0xf0bb828c, Offset: 0x6380
// Size: 0x3c
function ph_setfinalkillcamwinner(winningteam) {
    level.finalkillcam_winner = winningteam;
    if (level.finalkillcam_winner == game["defenders"]) {
        level.var_fb8e299e = 1;
    }
}

// Namespace prop
// Params 1, eflags: 0x0
// namespace_a9dea446<file_0>::function_807122d9
// Checksum 0xc954610a, Offset: 0x63c8
// Size: 0x6c
function givephteamscore(team) {
    level endon(#"game_ended");
    var_a307eca2 = 0;
    if (isdefined(game["roundswon"])) {
        var_a307eca2 = game["roundswon"][team];
    }
    setteamscore(team, var_a307eca2);
}

// Namespace prop
// Params 0, eflags: 0x0
// namespace_a9dea446<file_0>::function_6bed115d
// Checksum 0xf0cf6065, Offset: 0x6440
// Size: 0xbc
function setphteamscores() {
    level endon(#"game_ended");
    var_aa6bd9ef = 0;
    var_c586b70f = 0;
    if (isdefined(game["roundswon"])) {
        var_c586b70f = game["roundswon"][game["defenders"]];
        var_aa6bd9ef = game["roundswon"][game["attackers"]];
    }
    setteamscore(game["defenders"], var_c586b70f);
    setteamscore(game["attackers"], var_aa6bd9ef);
}

// Namespace prop
// Params 1, eflags: 0x0
// namespace_a9dea446<file_0>::function_4abe31c7
// Checksum 0xe33482d2, Offset: 0x6508
// Size: 0x154
function ononeleftevent(team) {
    if (isdefined(level.gameended) && level.gameended) {
        return;
    }
    if (team == game["attackers"]) {
        return;
    }
    lastplayer = undefined;
    foreach (player in level.players) {
        if (isdefined(team) && player.team != team) {
            continue;
        }
        if (!isalive(player) && !player globallogic_spawn::mayspawn()) {
            continue;
        }
        if (isdefined(lastplayer)) {
            return;
        }
        lastplayer = player;
    }
    if (!isdefined(lastplayer)) {
        return;
    }
    lastplayer thread givelastonteamwarning();
}

// Namespace prop
// Params 2, eflags: 0x0
// namespace_a9dea446<file_0>::function_6feca368
// Checksum 0xed7ad3c7, Offset: 0x6668
// Size: 0xce
function waittillrecoveredhealth(time, interval) {
    self endon(#"death");
    self endon(#"disconnect");
    fullhealthtime = 0;
    if (!isdefined(interval)) {
        interval = 0.05;
    }
    if (!isdefined(time)) {
        time = 0;
    }
    while (true) {
        if (self.health != self.maxhealth) {
            fullhealthtime = 0;
        } else {
            fullhealthtime += interval;
        }
        wait(interval);
        if (self.health == self.maxhealth && fullhealthtime >= time) {
            break;
        }
    }
}

// Namespace prop
// Params 0, eflags: 0x0
// namespace_a9dea446<file_0>::function_a220336a
// Checksum 0xb691d282, Offset: 0x6740
// Size: 0x9e
function givelastonteamwarning() {
    self endon(#"death");
    self endon(#"disconnect");
    level endon(#"game_ended");
    self waittillrecoveredhealth(3);
    level thread function_435d5169(%SCORE_LAST_ALIVE, self);
    if (self util::isprop()) {
        level notify(#"hash_2cd007a4");
        level.nopropsspectate = 1;
    }
    level notify(#"last_alive", self);
}

// Namespace prop
// Params 2, eflags: 0x0
// namespace_a9dea446<file_0>::function_435d5169
// Checksum 0x6af17534, Offset: 0x67e8
// Size: 0x44
function function_435d5169(var_eb4caf58, calloutplayer) {
    luinotifyevent(%player_callout, 2, var_eb4caf58, calloutplayer.entnum);
}

// Namespace prop
// Params 0, eflags: 0x0
// namespace_a9dea446<file_0>::function_fb734762
// Checksum 0x486dd509, Offset: 0x6838
// Size: 0x6c
function ontimelimit() {
    if (!(isdefined(level.gameending) && level.gameending)) {
        function_f666ecbf();
        choosefinalkillcam();
        ph_endgame(game["defenders"], game["strings"]["time_limit_reached"]);
    }
}

// Namespace prop
// Params 0, eflags: 0x0
// namespace_a9dea446<file_0>::function_f666ecbf
// Checksum 0xa5b11995, Offset: 0x68b0
// Size: 0xf6
function function_f666ecbf() {
    var_de5f82e0 = globallogic_defaults::default_gettimelimit() * 60 * 1000;
    timepassed = globallogic_utils::gettimepassed();
    var_fca3efa4 = int(min(var_de5f82e0, timepassed));
    game["propSurvivalTime"][game["defenders"]] = game["propSurvivalTime"][game["defenders"]] + var_fca3efa4;
    game["hunterKillTime"][game["attackers"]] = game["hunterKillTime"][game["attackers"]] + var_fca3efa4;
}

// Namespace prop
// Params 0, eflags: 0x0
// namespace_a9dea446<file_0>::function_a1114d4b
// Checksum 0x3d5fef46, Offset: 0x69b0
// Size: 0x1bc
function choosefinalkillcam() {
    var_fdf4a4ec = getlivingplayersonteam(game["defenders"]);
    if (var_fdf4a4ec.size < 1) {
        return;
    }
    var_94ffcd5f = getlivingplayersonteam(game["attackers"]);
    if (var_94ffcd5f.size < 1) {
        return;
    }
    var_81790aa5 = choosebestpropforkillcam(var_fdf4a4ec, var_94ffcd5f);
    if (isplayer(var_81790aa5)) {
        attackernum = var_81790aa5 getentitynumber();
    } else {
        attackernum = -1;
    }
    victim = var_94ffcd5f[0];
    victim.deathtime = gettime() - 1000;
    weap = getweapon("none");
    killcam_entity_info = killcam::get_killcam_entity_info(var_81790aa5, var_81790aa5, weap);
    level thread killcam::record_settings(attackernum, victim getentitynumber(), weap, "MOD_UNKNOWN", victim.deathtime, 0, 0, killcam_entity_info, [], [], var_81790aa5);
}

// Namespace prop
// Params 2, eflags: 0x0
// namespace_a9dea446<file_0>::function_52b98131
// Checksum 0xb373ef88, Offset: 0x6b78
// Size: 0x244
function choosebestpropforkillcam(var_fdf4a4ec, var_94ffcd5f) {
    var_b3b19664 = undefined;
    var_fd00913d = 1073741824;
    foreach (prop in var_fdf4a4ec) {
        assert(isalive(prop));
        var_7e7ea558 = undefined;
        var_d939e4ca = 1073741824;
        foreach (hunter in var_94ffcd5f) {
            pathdist = pathdistance(prop.origin, hunter.origin);
            if (!isdefined(pathdist)) {
                pathdist = distance(prop.origin, hunter.origin);
            }
            if (pathdist < var_d939e4ca) {
                var_d939e4ca = pathdist;
                var_7e7ea558 = hunter;
            }
        }
        if (var_d939e4ca < var_fd00913d) {
            var_fd00913d = var_d939e4ca;
            var_b3b19664 = prop;
        }
    }
    if (!isdefined(var_b3b19664)) {
        var_b3b19664 = array::random(var_fdf4a4ec);
    }
    return var_b3b19664;
}

// Namespace prop
// Params 1, eflags: 0x0
// namespace_a9dea446<file_0>::function_cd929fef
// Checksum 0x3c243927, Offset: 0x6dc8
// Size: 0x5c
function function_cd929fef(setclientfield) {
    self show();
    self notify(#"showplayer");
    if (setclientfield) {
        self clientfield::set("hideTeamPlayer", 0);
    }
}

// Namespace prop
// Params 2, eflags: 0x0
// namespace_a9dea446<file_0>::function_945f1c41
// Checksum 0xe533be2a, Offset: 0x6e30
// Size: 0xf4
function function_945f1c41(team, setclientfield) {
    self hide();
    if (setclientfield) {
        self thread function_c2dcc15d(team);
    }
    foreach (player in level.players) {
        self thread function_cb3d2d31(player, team);
    }
    self thread function_a8e0199(team);
}

// Namespace prop
// Params 1, eflags: 0x0
// namespace_a9dea446<file_0>::function_c2dcc15d
// Checksum 0x5c4dc50a, Offset: 0x6f30
// Size: 0x84
function function_c2dcc15d(team) {
    level endon(#"game_ended");
    self endon(#"disconnect");
    self endon(#"showplayer");
    wait(0.05);
    teamint = 1;
    if (team == "axis") {
        teamint = 2;
    }
    self clientfield::set("hideTeamPlayer", teamint);
}

// Namespace prop
// Params 1, eflags: 0x0
// namespace_a9dea446<file_0>::function_a8e0199
// Checksum 0x973a99ef, Offset: 0x6fc0
// Size: 0x70
function function_a8e0199(team) {
    level endon(#"game_ended");
    self endon(#"disconnect");
    self endon(#"showplayer");
    while (true) {
        player = level waittill(#"connected");
        self thread function_cb3d2d31(player, team);
    }
}

// Namespace prop
// Params 2, eflags: 0x0
// namespace_a9dea446<file_0>::function_cb3d2d31
// Checksum 0xabc16fab, Offset: 0x7038
// Size: 0xe6
function function_cb3d2d31(player, team) {
    level endon(#"game_ended");
    self endon(#"disconnect");
    self endon(#"showplayer");
    player endon(#"disconnect");
    while (true) {
        if (isdefined(player.hasspawned) && player.hasspawned && player.team != team) {
            self showtoplayer(player);
            if (self util::isprop()) {
                self ghost();
            }
        }
        player waittill(#"spawned");
    }
}

// Namespace prop
// Params 0, eflags: 0x0
// namespace_a9dea446<file_0>::function_346bdc3b
// Checksum 0x6044ca84, Offset: 0x7128
// Size: 0x144
function function_346bdc3b() {
    self.thirdpersonrange = undefined;
    self setclientthirdperson(0, 0);
    self allowprone(1);
    self allowsprint(1);
    self setmovespeedscale(1);
    self playerknockback(1);
    self show();
    self setclientuivisibilityflag("weapon_hud_visible", 1);
    if (function_503c9413()) {
        self function_543b1a75(0);
    }
    self thread prop_controls::function_b6740059();
    self thread prop_controls::function_1abcc66();
    self.concussionimmune = 1;
    self.healthregendisabled = 0;
    self thread attackerregenammo();
}

// Namespace prop
// Params 0, eflags: 0x0
// namespace_a9dea446<file_0>::function_a8cb094c
// Checksum 0xb00d9545, Offset: 0x7278
// Size: 0x234
function stillalivexp() {
    level endon(#"game_ended");
    level.var_3c96f157["kill"]["value"] = 300;
    level waittill(#"props_hide_over");
    while (true) {
        hostmigration::waitlongdurationwithhostmigrationpause(10);
        /#
            if (getgametypesetting("mpl_hit_alert") == 0) {
                continue;
            }
        #/
        foreach (player in level.players) {
            if (!isdefined(player.team)) {
                continue;
            }
            if (player.team == game["attackers"]) {
                continue;
            }
            if (!isalive(player)) {
                continue;
            }
            if (!isdefined(player.prop)) {
                continue;
            }
            scoreevents::processscoreevent("still_alive", player);
            switch (player.prop.info.propsize) {
            case 250:
                scoreevents::processscoreevent("still_alive_medium_bonus", player);
                break;
            case 450:
                scoreevents::processscoreevent("still_alive_large_bonus", player);
                break;
            case 550:
                scoreevents::processscoreevent("still_alive_extra_large_bonus", player);
                break;
            default:
                break;
            }
        }
    }
}

// Namespace prop
// Params 0, eflags: 0x0
// namespace_a9dea446<file_0>::function_ca21c858
// Checksum 0x27b77a15, Offset: 0x74b8
// Size: 0x170
function tracktimealive() {
    level endon(#"game_ended");
    function_45c842e9();
    while (true) {
        foreach (player in level.players) {
            if (!isdefined(player.team)) {
                continue;
            }
            if (player.team == game["attackers"]) {
                continue;
            }
            if (!isalive(player)) {
                continue;
            }
            player.pers["objtime"]++;
            player.objtime = player.pers["objtime"];
            player addplayerstatwithgametype("OBJECTIVE_TIME", 1);
        }
        hostmigration::waitlongdurationwithhostmigrationpause(1);
    }
}

// Namespace prop
// Params 11, eflags: 0x0
// namespace_a9dea446<file_0>::function_19973438
// Checksum 0x4ff11418, Offset: 0x7630
// Size: 0xd0
function gamemodemodifyplayerdamage(einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, psoffsettime, boneindex) {
    victim = self;
    if (isdefined(eattacker) && isplayer(eattacker) && isalive(eattacker)) {
        if (!isdefined(eattacker.hashitplayer)) {
            eattacker.hashitplayer = 1;
        }
    }
    return idamage;
}

// Namespace prop
// Params 6, eflags: 0x0
// namespace_a9dea446<file_0>::function_dc6b46ed
// Checksum 0x36de1fe8, Offset: 0x7708
// Size: 0xbe
function function_dc6b46ed(idflags, shitloc, weapon, friendlyfire, attackerishittingself, smeansofdeath) {
    if (isdefined(smeansofdeath) && smeansofdeath == "MOD_FALLING") {
        return true;
    }
    if (self function_e4b2f23()) {
        if (weapon.name == "concussion_grenade") {
            return true;
        }
        if (issubstr(weapon.name, "destructible")) {
            return true;
        }
    }
    return false;
}

// Namespace prop
// Params 0, eflags: 0x0
// namespace_a9dea446<file_0>::function_3c054273
// Checksum 0x5076a21b, Offset: 0x77d0
// Size: 0x148
function attackerswaittime() {
    level endon(#"game_ended");
    self endon(#"disconnect");
    function_45c842e9();
    if (self.team == game["defenders"]) {
        self notify(#"cancelcountdown");
        return;
    }
    while (!isdefined(level.starttime)) {
        wait(0.05);
    }
    while (isdefined(self.controlsfrozen) && self.controlsfrozen) {
        wait(0.05);
    }
    var_e47d50e6 = function_d9c4b3d0();
    remainingtime = level.phsettings.prophidetime - var_e47d50e6;
    result = 0;
    if (remainingtime > 0) {
        if (!function_503c9413()) {
            result = function_b00e098a(var_e47d50e6, remainingtime);
            return;
        }
        result = function_b1b25534(var_e47d50e6, remainingtime);
    }
}

// Namespace prop
// Params 2, eflags: 0x0
// namespace_a9dea446<file_0>::function_b00e098a
// Checksum 0xa8e83fbf, Offset: 0x7920
// Size: 0x110
function function_b00e098a(var_e47d50e6, remainingtime) {
    self freezecontrols(1);
    if (int(var_e47d50e6) > 0) {
        fadeintime = 0;
    } else {
        fadeintime = 1;
    }
    fadeouttime = 1;
    if (fadeintime + fadeouttime > remainingtime) {
        fadeintime = 0;
        fadeouttime = 0;
    }
    self thread prop_controls::function_7244ebc6(remainingtime, fadeintime, fadeouttime);
    result = self function_da184fd(remainingtime);
    self freezecontrols(0);
    return result;
}

// Namespace prop
// Params 2, eflags: 0x0
// namespace_a9dea446<file_0>::function_b1b25534
// Checksum 0xe6e153d9, Offset: 0x7a38
// Size: 0x1e0
function function_b1b25534(var_e47d50e6, remainingtime) {
    var_27a8ec66 = 3;
    var_1006f499 = 1;
    fadeintime = 0;
    result = 0;
    var_b73ba41a = remainingtime - var_27a8ec66;
    self thread propwaitminigameinit(var_b73ba41a + var_1006f499);
    waittillframeend();
    self.var_11d543b4 = undefined;
    self.var_f806489a = undefined;
    if (remainingtime > 8) {
        self.var_11d543b4 = self.origin;
        self.var_f806489a = self.angles;
        result = self function_da184fd(var_b73ba41a);
        fadeintime = 1;
    }
    var_e47d50e6 = function_d9c4b3d0();
    remainingtime = level.phsettings.prophidetime - var_e47d50e6;
    if (remainingtime > 0) {
        self freezecontrols(1);
        fadeouttime = 1;
        if (fadeintime + fadeouttime > remainingtime) {
            fadeintime = 0;
            fadeouttime = 0;
        }
        self thread prop_controls::function_7244ebc6(remainingtime, fadeintime, fadeouttime);
        result = self function_da184fd(remainingtime);
        self freezecontrols(0);
    }
    return result;
}

// Namespace prop
// Params 0, eflags: 0x0
// namespace_a9dea446<file_0>::function_d9c4b3d0
// Checksum 0x6600a317, Offset: 0x7c20
// Size: 0x20
function function_d9c4b3d0() {
    return (gettime() - level.starttime - level.var_f2aa1432) / 1000;
}

// Namespace prop
// Params 0, eflags: 0x0
// namespace_a9dea446<file_0>::function_1edf732a
// Checksum 0x9734ff41, Offset: 0x7c48
// Size: 0x70
function function_1edf732a() {
    level.var_f2aa1432 = 0;
    while (true) {
        level waittill(#"host_migration_begin");
        starttime = gettime();
        level waittill(#"host_migration_end");
        passedtime = gettime() - starttime;
        level.var_f2aa1432 += passedtime;
    }
}

// Namespace prop
// Params 1, eflags: 0x0
// namespace_a9dea446<file_0>::function_da184fd
// Checksum 0x3bfa2135, Offset: 0x7cc0
// Size: 0x64
function function_da184fd(remainingtime) {
    result = function_5eebce92(remainingtime);
    /#
        while (getdvarint("_lives", 0) != 0) {
            wait(0.05);
        }
    #/
    return result;
}

// Namespace prop
// Params 1, eflags: 0x0
// namespace_a9dea446<file_0>::function_5eebce92
// Checksum 0xece38ec2, Offset: 0x7d30
// Size: 0x30
function function_5eebce92(remainingtime) {
    self endon(#"cancelcountdown");
    hostmigration::waitlongdurationwithhostmigrationpause(remainingtime);
    return true;
}

// Namespace prop
// Params 0, eflags: 0x0
// namespace_a9dea446<file_0>::function_e999d
// Checksum 0x2872313, Offset: 0x7d68
// Size: 0x1b4
function function_e999d() {
    if (self.pers["team"] == game["attackers"]) {
        self util::freeze_player_controls(1);
    } else {
        self thread function_320928f9();
    }
    team = self.pers["team"];
    if (isdefined(self.pers["music"].spawn) && self.pers["music"].spawn == 0) {
        if (level.wagermatch) {
            music = "SPAWN_WAGER";
        } else {
            music = game["music"]["spawn_" + team];
        }
        if (game["roundsplayed"] == 0) {
            self thread globallogic_spawn::function_a2c32efb("spawnFull");
        } else {
            self thread globallogic_spawn::function_a2c32efb("spawnShort");
        }
        self.pers["music"].spawn = 1;
    }
    if (level.splitscreen) {
        if (isdefined(level.playedstartingmusic)) {
            music = undefined;
        } else {
            level.playedstartingmusic = 1;
        }
    }
    self thread globallogic_spawn::doinitialspawnmessaging();
}

// Namespace prop
// Params 0, eflags: 0x0
// namespace_a9dea446<file_0>::function_320928f9
// Checksum 0x25c1362d, Offset: 0x7f28
// Size: 0x4c
function function_320928f9() {
    self endon(#"disconnect");
    self freezecontrolsallowlook(1);
    function_45c842e9();
    self freezecontrolsallowlook(0);
}

// Namespace prop
// Params 0, eflags: 0x0
// namespace_a9dea446<file_0>::function_fbd8cfe8
// Checksum 0xc7d97680, Offset: 0x7f80
// Size: 0x1c4
function attackerinitammo() {
    primaryweapons = self getweaponslistprimaries();
    foreach (weapon in primaryweapons) {
        self givemaxammo(weapon);
        self setweaponammoclip(weapon, 999);
    }
    if (!function_503c9413()) {
        if (!isdefined(self.thrownspecialcount)) {
            self.thrownspecialcount = 0;
        }
        weapon = getweapon("concussion_grenade");
        var_10f7466f = self getweaponammostock(weapon);
        var_10f7466f -= self.thrownspecialcount;
        var_10f7466f = int(max(var_10f7466f, 0));
        self setweaponammostock(weapon, var_10f7466f);
        if (var_10f7466f > 0) {
            self thread prop_controls::watchspecialgrenadethrow();
        }
    }
}

// Namespace prop
// Params 0, eflags: 0x0
// namespace_a9dea446<file_0>::function_40302825
// Checksum 0x65faf60b, Offset: 0x8150
// Size: 0x98
function attackerregenammo() {
    self endon(#"death");
    self endon(#"disconnect");
    self notify(#"attackerregenammo");
    self endon(#"attackerregenammo");
    level endon(#"game_ended");
    while (true) {
        self waittill(#"reload");
        primaryweapon = self getcurrentweapon();
        self givemaxammo(primaryweapon);
    }
}

// Namespace prop
// Params 0, eflags: 0x0
// namespace_a9dea446<file_0>::function_bd63ad3d
// Checksum 0xf60b825b, Offset: 0x81f0
// Size: 0x9c
function checkkillrespawn() {
    self endon(#"disconnect");
    level endon(#"game_ended");
    hostmigration::waitlongdurationwithhostmigrationpause(0.1);
    if (self.pers["lives"] == 1) {
        self.pers["lives"]--;
        level.livescount[self.team]--;
        globallogic::updategameevents();
        level notify(#"propcountchanged");
        return;
    }
}

// Namespace prop
// Params 3, eflags: 0x0
// namespace_a9dea446<file_0>::function_7d4f8220
// Checksum 0x675406d3, Offset: 0x8298
// Size: 0x4ca
function function_7d4f8220(attacker, smeansofdeath, weapon) {
    bestplayer = undefined;
    bestplayermeansofdeath = undefined;
    bestplayerweapon = undefined;
    if (!level flag::get("props_hide_over")) {
        return;
    }
    if (isdefined(attacker.ismagicbullet) && (!isdefined(attacker) || attacker.classname == "trigger_hurt" || attacker.classname == "worldspawn" || attacker.ismagicbullet == 1) || attacker == self) {
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
            if (self.attackerdamage[player.clientid].damage > 1 && !isdefined(bestplayer)) {
                bestplayer = player;
                bestplayermeansofdeath = self.attackerdamage[player.clientid].meansofdeath;
                bestplayerweapon = self.attackerdamage[player.clientid].weapon;
                continue;
            }
            if (isdefined(bestplayer) && self.attackerdamage[player.clientid].lasttimedamaged > self.attackerdamage[bestplayer.clientid].lasttimedamaged) {
                bestplayer = player;
                bestplayermeansofdeath = self.attackerdamage[player.clientid].meansofdeath;
                bestplayerweapon = self.attackerdamage[player.clientid].weapon;
            }
        }
        if (!isdefined(bestplayer) && self util::isprop()) {
            bestdistsq = undefined;
            foreach (player in level.players) {
                if (isalive(player) && player.team != self.team) {
                    distsq = distancesquared(player.origin, self.origin);
                    if (!isdefined(bestdistsq) || distsq < bestdistsq) {
                        bestplayer = player;
                        bestdistsq = distsq;
                    }
                }
            }
            if (isdefined(bestplayer)) {
                bestplayermeansofdeath = "MOD_MELEE";
                bestplayerweapon = getweapon("none");
            }
        }
    }
    result = undefined;
    if (isdefined(bestplayer)) {
        result = [];
        result["bestPlayer"] = bestplayer;
        result["bestPlayerWeapon"] = bestplayerweapon;
        result["bestMeansOfDeath"] = bestplayermeansofdeath;
    }
    return result;
}

// Namespace prop
// Params 10, eflags: 0x0
// namespace_a9dea446<file_0>::function_c2658b46
// Checksum 0x6c47998a, Offset: 0x8770
// Size: 0x42a
function onplayerkilled(einflictor, attacker, idamage, smeansofdeath, sweapon, vdir, shitloc, psoffsettime, deathanimduration, lifeid) {
    victim = self;
    killedbyenemy = 0;
    level notify(#"playercountchanged");
    if (victim.team == game["attackers"]) {
        self thread respawnplayer();
    } else if (!level flag::get("props_hide_over")) {
        self thread respawnplayer();
        return;
    } else {
        thread deathicons::add(victim.body, victim, victim.team, 5);
    }
    if (isdefined(attacker) && isplayer(attacker) && attacker != victim && victim.team != attacker.team) {
        killedbyenemy = 1;
    }
    if (killedbyenemy) {
        scoreevents::processscoreevent("prop_finalblow", attacker, victim);
        foreach (assailant in victim.attackers) {
            if (assailant == attacker) {
                assailant playhitmarker("mpl_hit_alert");
                continue;
            }
            assailant playhitmarker("mpl_hit_alert_escort");
        }
    }
    foreach (player in level.players) {
        if (player != attacker && player util::isprop() && isalive(player) && victim util::isprop()) {
            scoreevents::processscoreevent("prop_survived", player);
            continue;
        }
        if (player != attacker && player function_e4b2f23() && victim.team == game["defenders"]) {
            scoreevents::processscoreevent("prop_killed", player, victim);
        }
    }
    if (victim util::isprop()) {
        attackerteam = util::getotherteam(victim.team);
        game["propScore"][attackerteam] = game["propScore"][attackerteam] + 1;
    }
}

// Namespace prop
// Params 0, eflags: 0x0
// namespace_a9dea446<file_0>::function_cc5aee80
// Checksum 0x7349378f, Offset: 0x8ba8
// Size: 0x1c
function respawnplayer() {
    self thread waittillcanspawnclient();
}

// Namespace prop
// Params 0, eflags: 0x0
// namespace_a9dea446<file_0>::function_a975df4d
// Checksum 0x230402aa, Offset: 0x8bd0
// Size: 0xa6
function waittillcanspawnclient() {
    self endon(#"started_spawnplayer");
    self endon(#"disconnect");
    level endon(#"game_ended");
    for (;;) {
        wait(0.05);
        if (self.sessionstate == "spectator" || isdefined(self) && isdefined(self.curclass) && !isalive(self)) {
            self.pers["lives"] = 1;
            self globallogic_spawn::spawnclient();
            continue;
        }
        return;
    }
}

// Namespace prop
// Params 1, eflags: 0x0
// namespace_a9dea446<file_0>::function_e0db18e8
// Checksum 0xe3885e05, Offset: 0x8c80
// Size: 0x5c
function ondeadevent(team) {
    if (team == game["defenders"]) {
        /#
            if (isdefined(level.allow_teamchange) && level.allow_teamchange == "spawner_bo3_robot_grunt_assault_mp") {
                return;
            }
        #/
        level thread propkilledend();
    }
}

// Namespace prop
// Params 0, eflags: 0x0
// namespace_a9dea446<file_0>::function_b491ea0c
// Checksum 0x7dbc7bfc, Offset: 0x8ce8
// Size: 0xb4
function propkilledend() {
    if (isdefined(level.hunterswonending) && level.hunterswonending) {
        return;
    }
    if (isdefined(level.gameending) && level.gameending) {
        return;
    }
    level.hunterswonending = 1;
    function_f666ecbf();
    level.gameending = 1;
    hostmigration::waitlongdurationwithhostmigrationpause(3);
    thread ph_endgame(game["attackers"], game["strings"][game["defenders"] + "_eliminated"]);
}

// Namespace prop
// Params 1, eflags: 0x0
// namespace_a9dea446<file_0>::function_470f21c5
// Checksum 0x17d68e67, Offset: 0x8da8
// Size: 0x3c
function function_470f21c5(smeansofdeath) {
    if (self.team == game["attackers"]) {
        self battlechatter::pain_vox(smeansofdeath);
    }
}

// Namespace prop
// Params 4, eflags: 0x0
// namespace_a9dea446<file_0>::function_f21fec4
// Checksum 0xc759fc00, Offset: 0x8df0
// Size: 0x6c
function playdeathsoundph(body, attacker, weapon, smeansofdeath) {
    if (self.team == game["attackers"] && isdefined(body)) {
        self battlechatter::play_death_vox(body, attacker, weapon, smeansofdeath);
    }
}

// Namespace prop
// Params 1, eflags: 0x0
// namespace_a9dea446<file_0>::function_c99967b7
// Checksum 0xf8df2b31, Offset: 0x8e68
// Size: 0x34
function round(value) {
    value = int(value + 0.5);
    return value;
}

// Namespace prop
// Params 8, eflags: 0x0
// namespace_a9dea446<file_0>::function_c17c938d
// Checksum 0xf03a5bb4, Offset: 0x8ea8
// Size: 0x3cc
function function_c17c938d(winner, endtype, endreasontext, outcometext, team, winnerenum, notifyroundendtoui, matchbonus) {
    if (endtype == "gameend" && isdefined(level.proptiebreaker)) {
        if (!isdefined(team) || team == "spectator") {
            if (isdefined(self.team) && self.team != "spectator" && isdefined(game["propScore"][self.team])) {
                team = self.team;
            } else if (isdefined(self.sessionteam) && self.sessionteam != "spectator" && isdefined(game["propScore"][self.sessionteam])) {
                team = self.sessionteam;
            }
            if (!isdefined(team)) {
                return true;
            }
        }
        otherteam = util::getotherteam(team);
        if (level.proptiebreaker == "kills") {
            winnerscore = game["propScore"][team];
            loserscore = game["propScore"][otherteam];
            if (winnerscore < loserscore) {
                winnerscore = game["propScore"][otherteam];
                loserscore = game["propScore"][team];
            }
            var_be546bcd = (winnerscore << 8) + loserscore;
            self luinotifyevent(%show_outcome, 6, outcometext, %MP_PH_TIEBREAKER_KILL, int(matchbonus), winnerenum, notifyroundendtoui, var_be546bcd);
            return true;
        } else if (level.proptiebreaker == "time") {
            var_f3258fd1 = game["hunterKillTime"][team] / 1000;
            otherteam = util::getotherteam(team);
            var_61cf9ec5 = game["hunterKillTime"][otherteam] / 1000;
            var_101aa528 = round(var_f3258fd1);
            var_b71f48d4 = round(var_61cf9ec5);
            if (var_101aa528 == var_b71f48d4) {
                if (var_f3258fd1 > var_61cf9ec5) {
                    var_101aa528++;
                } else {
                    var_b71f48d4++;
                }
            }
            var_cd0a6db3 = var_101aa528;
            var_7bdb281b = var_b71f48d4;
            if (var_cd0a6db3 < var_7bdb281b) {
                var_cd0a6db3 = var_b71f48d4;
                var_7bdb281b = var_101aa528;
            }
            self luinotifyevent(%show_outcome, 7, outcometext, %MP_PH_TIEBREAKER_TIME, int(matchbonus), winnerenum, notifyroundendtoui, var_cd0a6db3, var_7bdb281b);
            return true;
        }
    }
    return false;
}

// Namespace prop
// Params 2, eflags: 0x0
// namespace_a9dea446<file_0>::function_e0d16266
// Checksum 0x32f1a64c, Offset: 0x9280
// Size: 0x28
function function_e0d16266(spawnpoint, predictedspawn) {
    if (!predictedspawn) {
        self.startspawn = spawnpoint;
    }
}

// Namespace prop
// Params 2, eflags: 0x0
// namespace_a9dea446<file_0>::function_6f13f156
// Checksum 0x9abacb5d, Offset: 0x92b0
// Size: 0xf6
function function_6f13f156(spawnpoint, predictedspawn) {
    foreach (player in level.players) {
        if (isdefined(player.pers["team"]) && player.pers["team"] != "spectator") {
            if (isdefined(player.startspawn) && player.startspawn == spawnpoint) {
                return false;
            }
        }
    }
    return true;
}

// Namespace prop
// Params 0, eflags: 0x0
// namespace_a9dea446<file_0>::function_2afb638
// Checksum 0x7cc765e6, Offset: 0x93b0
// Size: 0x66
function gamehasstarted() {
    if (level.teambased) {
        return globallogic_spawn::allteamshaveexisted();
    }
    return !util::isoneround() && (level.maxplayercount > 1 || !util::isfirstround());
}

// Namespace prop
// Params 0, eflags: 0x0
// namespace_a9dea446<file_0>::function_4fb47492
// Checksum 0x8ac7cf4b, Offset: 0x9420
// Size: 0x146
function function_4fb47492() {
    /#
        if (level.var_2898ef72) {
            return true;
        }
    #/
    if (level.inovertime) {
        return false;
    }
    if (level.playerqueuedrespawn && !isdefined(self.allowqueuespawn) && !level.ingraceperiod && !level.usestartspawns) {
        return false;
    }
    if (level.numlives || level.numteamlives) {
        gamehasstarted = gamehasstarted();
        if (level.numteamlives && (level.numlives && gamehasstarted && !self.pers["lives"] || !game[self.team + "_lives"])) {
            return false;
        } else if (gamehasstarted) {
            if (!level.ingraceperiod && !self.hasspawned && !level.wagermatch) {
                return false;
            }
        }
        if (self disablespawningforplayer()) {
            return false;
        }
    }
    return true;
}

// Namespace prop
// Params 0, eflags: 0x0
// namespace_a9dea446<file_0>::function_75804806
// Checksum 0x86ab1f8, Offset: 0x9570
// Size: 0x5c
function disablespawningforplayer() {
    if (!gamehasstarted()) {
        return false;
    }
    if (self function_e4b2f23()) {
        return false;
    } else if (self util::isprop()) {
        return !level.ingraceperiod;
    }
    return false;
}

// Namespace prop
// Params 0, eflags: 0x0
// namespace_a9dea446<file_0>::function_e4b2f23
// Checksum 0xd9476b1e, Offset: 0x95d8
// Size: 0x24
function function_e4b2f23() {
    return isdefined(self.team) && self.team == game["attackers"];
}

// Namespace prop
// Params 0, eflags: 0x0
// namespace_a9dea446<file_0>::function_4bdf92a7
// Checksum 0x8a09992a, Offset: 0x9608
// Size: 0xb2
function function_4bdf92a7() {
    turrets = getentarray("misc_turret", "classname");
    foreach (turret in turrets) {
        turret delete();
    }
}

// Namespace prop
// Params 6, eflags: 0x0
// namespace_a9dea446<file_0>::function_9bb11de9
// Checksum 0x240ea49f, Offset: 0x96c8
// Size: 0x9c
function function_9bb11de9(eattacker, einflictor, weapon, smeansofdeath, idamage, vpoint) {
    self thread function_b37cf698(eattacker, einflictor, weapon, smeansofdeath, idamage, vpoint);
    if (!self util::isusingremote()) {
        self playrumbleonentity("damage_heavy");
    }
}

// Namespace prop
// Params 6, eflags: 0x0
// namespace_a9dea446<file_0>::function_b37cf698
// Checksum 0x1f6810f9, Offset: 0x9770
// Size: 0x33a
function function_b37cf698(eattacker, einflictor, weapon, meansofdeath, damage, point) {
    self endon(#"death");
    self endon(#"disconnect");
    if (isdefined(level._custom_weapon_damage_func)) {
        is_weapon_registered = self [[ level._custom_weapon_damage_func ]](eattacker, einflictor, weapon, meansofdeath, damage);
        if (is_weapon_registered) {
            return;
        }
    }
    switch (weapon.rootweapon.name) {
    case 59:
        if (isdefined(self.concussionimmune) && self.concussionimmune) {
            return;
        }
        radius = weapon.explosionradius;
        if (self == eattacker) {
            radius *= 0.5;
        }
        damageorigin = einflictor.origin;
        if (isdefined(point)) {
            damageorigin = point;
        }
        if (self prop_controls::function_94e1618c(damageorigin)) {
            return;
        }
        scale = 1 - distance(self.origin, damageorigin) / radius;
        if (scale < 0) {
            scale = 0;
        }
        time = 0.25 + 4 * scale;
        wait(0.05);
        if (meansofdeath != "MOD_IMPACT") {
            if (self hasperk("specialty_stunprotection")) {
                time *= 0.1;
            } else if (self util::mayapplyscreeneffect()) {
                self shellshock("concussion_grenade_mp", time, 0);
            }
            self thread weapons::play_concussion_sound(time);
            self.concussionendtime = gettime() + time * 1000;
            self.lastconcussedby = eattacker;
            if (self util::isprop()) {
                if (isdefined(self.lock) && self.lock) {
                    self prop_controls::unlockprop();
                }
                self prop_controls::function_770b4cfa(einflictor, self, meansofdeath, damage, damageorigin, weapon);
            }
        }
        break;
    default:
        if (isdefined(level.shellshockonplayerdamage)) {
            [[ level.shellshockonplayerdamage ]](meansofdeath, damage, weapon);
        }
        break;
    }
}

// Namespace prop
// Params 0, eflags: 0x0
// namespace_a9dea446<file_0>::function_7010fe7f
// Checksum 0xa843d4f7, Offset: 0x9ab8
// Size: 0x14a
function function_7010fe7f() {
    level endon(#"game_ended");
    wait(0.05);
    while (!isdefined(level.mannequins)) {
        wait(0.05);
    }
    foreach (mannequin in level.mannequins) {
        mannequin notsolid();
    }
    level waittill(#"props_hide_over");
    foreach (mannequin in level.mannequins) {
        mannequin solid();
    }
}

// Namespace prop
// Params 1, eflags: 0x0
// namespace_a9dea446<file_0>::function_5dcd4f30
// Checksum 0x71af1237, Offset: 0x9c10
// Size: 0x104
function propwaitminigameinit(time) {
    if (!isdefined(level.var_e5ad813f)) {
        level.var_e5ad813f = spawnstruct();
    }
    if (!(isdefined(level.var_e5ad813f.started) && level.var_e5ad813f.started)) {
        level.var_e5ad813f.started = 1;
        self thread function_b408af2c(time);
    }
    self.var_efe75c2f = 0;
    self.var_61add00c = 0;
    if (level.var_e5ad813f.var_d504a1f4 && self function_e4b2f23() && time > 8) {
        waittillframeend();
        if (level.var_abcf2d12.size < 6) {
            self function_83efbfcf();
        }
    }
}

// Namespace prop
// Params 1, eflags: 0x0
// namespace_a9dea446<file_0>::function_b408af2c
// Checksum 0xb1f8fb72, Offset: 0x9d20
// Size: 0x422
function function_b408af2c(time) {
    if (time <= 0) {
        level.var_e5ad813f.active = 0;
        return;
    }
    thread function_c91df86f();
    function_da184fd(time);
    level notify(#"hash_ea126364");
    level.var_e5ad813f.active = 0;
    foreach (player in level.players) {
        if (isdefined(player.pers["team"]) && player.pers["team"] == game["defenders"]) {
            player function_2472fc6();
            continue;
        }
        if (isdefined(player.pers["team"]) && player.pers["team"] == game["attackers"]) {
            player function_7d5b1fa6();
        }
    }
    if (isdefined(level.var_e5ad813f.var_d410e6e5)) {
        level.var_e5ad813f.var_d410e6e5 destroy();
    }
    thread propminigameupdateshowwinner(level.var_e5ad813f.var_239c724[0], -80, 2);
    thread propminigameupdateshowwinner(level.var_e5ad813f.var_239c724[1], -50, 1.75);
    thread propminigameupdateshowwinner(level.var_e5ad813f.var_239c724[2], -20, 1.5);
    if (isdefined(level.var_e5ad813f.targets)) {
        foreach (target in level.var_e5ad813f.targets) {
            if (isdefined(target)) {
                target delete();
            }
        }
    }
    if (isdefined(level.var_abcf2d12)) {
        foreach (clone in level.var_abcf2d12) {
            if (isdefined(clone)) {
                if (isdefined(clone.var_9352d14f)) {
                    clone.var_9352d14f delete();
                }
                if (isdefined(clone.var_6f5f0e80)) {
                    gameobjects::release_obj_id(clone.var_6f5f0e80);
                }
                clone delete();
            }
        }
    }
}

// Namespace prop
// Params 3, eflags: 0x0
// namespace_a9dea446<file_0>::function_e8982b84
// Checksum 0x42e7e3, Offset: 0xa150
// Size: 0x11c
function propminigameupdateshowwinner(hud, winyoffset, winfontscale) {
    hud endon(#"death");
    movetime = 0.5;
    showtime = 2.5;
    fadetime = 0.5;
    hud hud::setpoint("BOTTOM", "CENTER", 0, winyoffset, movetime);
    hud changefontscaleovertime(movetime);
    hud.fontscale = winfontscale;
    wait(movetime + showtime);
    hud.alpha = 0;
    hud fadeovertime(fadetime);
    wait(fadetime);
    if (isdefined(hud)) {
        hud destroy();
    }
}

// Namespace prop
// Params 0, eflags: 0x0
// namespace_a9dea446<file_0>::function_7d5b1fa6
// Checksum 0x34115605, Offset: 0xa278
// Size: 0x8c
function function_7d5b1fa6() {
    self function_543b1a75(1);
    self takeweapon(getweapon("null_offhand_primary"));
    self function_c32f3fcc(getweapon("concussion_grenade"), 2);
    self attackerinitammo();
}

// Namespace prop
// Params 0, eflags: 0x0
// namespace_a9dea446<file_0>::function_2472fc6
// Checksum 0xc3eae6f0, Offset: 0xa310
// Size: 0x1c
function function_2472fc6() {
    self function_f2704a3c(1);
}

// Namespace prop
// Params 0, eflags: 0x0
// namespace_a9dea446<file_0>::function_503c9413
// Checksum 0x91e773aa, Offset: 0xa338
// Size: 0x7a
function function_503c9413() {
    if (!isdefined(level.var_e5ad813f)) {
        level.var_e5ad813f = spawnstruct();
    }
    if (!isdefined(level.var_e5ad813f.active)) {
        level.var_e5ad813f.active = getdvarint("scr_prop_minigame", 0);
    }
    return level.var_e5ad813f.active;
}

// Namespace prop
// Params 1, eflags: 0x0
// namespace_a9dea446<file_0>::function_543b1a75
// Checksum 0x103a6023, Offset: 0xa3c0
// Size: 0x13c
function function_543b1a75(isvisible) {
    if (isvisible) {
        self solid();
        self function_23ec35ff();
        self function_cd929fef(1);
        if (isdefined(self.var_11d543b4)) {
            self setorigin(self.var_11d543b4);
            self setplayerangles(self.var_f806489a);
        }
        if (isdefined(self.var_c83b06b4)) {
            self.var_c83b06b4 delete();
        }
        return;
    }
    self notsolid();
    self function_344baafe();
    self thread function_945f1c41(game["defenders"], 1);
    self thread function_471ff19e(self);
}

// Namespace prop
// Params 1, eflags: 0x0
// namespace_a9dea446<file_0>::function_471ff19e
// Checksum 0x1d4dbad9, Offset: 0xa508
// Size: 0x16c
function function_471ff19e(player) {
    player endon(#"disconnect");
    level endon(#"game_ended");
    if (!isdefined(player.var_c83b06b4)) {
        function_45c842e9();
        wait(0.1);
        clone = util::spawn_player_clone(player, "pb_stand_alert");
        weapon = player getcurrentweapon();
        if (isdefined(weapon.worldmodel)) {
            clone attach(weapon.worldmodel, "tag_weapon_right");
        }
        clone notsolid();
        clone function_344baafe();
        clone hidefromteam(player.pers["team"]);
        player.var_c83b06b4 = clone;
        player thread function_84edfab0(player, player.var_c83b06b4);
    }
}

// Namespace prop
// Params 2, eflags: 0x0
// namespace_a9dea446<file_0>::function_84edfab0
// Checksum 0xfb1cbfe9, Offset: 0xa680
// Size: 0x5c
function function_84edfab0(player, clone) {
    clone endon(#"entityshutdown");
    clone endon(#"death");
    player waittill(#"disconnect");
    if (isdefined(clone)) {
        clone delete();
    }
}

// Namespace prop
// Params 1, eflags: 0x0
// namespace_a9dea446<file_0>::function_f2704a3c
// Checksum 0x2b910f13, Offset: 0xa6e8
// Size: 0x1a4
function function_f2704a3c(isvisible) {
    if (isvisible) {
        if (isdefined(self.prop)) {
            self.prop show();
            self.prop solid();
        }
        self function_cd929fef(0);
        self ghost();
        if (isdefined(self.propclones)) {
            foreach (clone in self.propclones) {
                clone show();
                clone solid();
            }
        }
        return;
    }
    if (isdefined(self.prop)) {
        self.prop notsolid();
        self.prop hidefromteam(game["attackers"]);
    }
    self thread function_945f1c41(game["attackers"], 0);
}

// Namespace prop
// Params 0, eflags: 0x0
// namespace_a9dea446<file_0>::function_c91df86f
// Checksum 0xb8d3005a, Offset: 0xa898
// Size: 0x29a
function function_c91df86f() {
    level.var_e5ad813f.var_d504a1f4 = 0;
    label = %MP_PH_PREGAME_HUNT;
    if (randomfloat(1) < 0.5) {
        level.var_e5ad813f.var_d504a1f4 = 1;
        label = %MP_PH_PREGAME_CHASE;
    }
    /#
        if (getdvarint("active", 0) == 2 && level.var_e5ad813f.var_d504a1f4) {
            level.var_e5ad813f.var_d504a1f4 = 0;
            label = %"<unknown string>";
        } else if (getdvarint("active", 0) == 1 && !level.var_e5ad813f.var_d504a1f4) {
            level.var_e5ad813f.var_d504a1f4 = 1;
            label = %"<unknown string>";
        }
    #/
    thread function_9b0f77c4(label);
    level.var_e5ad813f.targetlocations = function_1450fc18();
    level.var_e5ad813f.targetlocations = array::randomize(level.var_e5ad813f.targetlocations);
    level.var_e5ad813f.nextindex = 0;
    if (!level.var_e5ad813f.var_d504a1f4) {
        thread function_f26960c8();
    } else {
        level.var_abcf2d12 = [];
    }
    foreach (player in level.players) {
        if (isdefined(player.pers["team"]) && player.pers["team"] == game["attackers"]) {
            player thread function_89acdf0d(%MP_PH_EMPTY);
        }
    }
}

// Namespace prop
// Params 0, eflags: 0x0
// namespace_a9dea446<file_0>::function_1450fc18
// Checksum 0xa3960799, Offset: 0xab40
// Size: 0x15a
function function_1450fc18() {
    var_f5af7250 = 90000;
    targetlocations = [];
    alllocations = spawnlogic::get_spawnpoint_array("mp_tdm_spawn");
    hunters = getlivingplayersonteam(game["attackers"]);
    hunter = hunters[0];
    foreach (location in alllocations) {
        distsq = distancesquared(location.origin, hunter.origin);
        if (distsq > var_f5af7250) {
            targetlocations[targetlocations.size] = location;
        }
    }
    return targetlocations;
}

// Namespace prop
// Params 0, eflags: 0x0
// namespace_a9dea446<file_0>::function_5f1e8e1b
// Checksum 0x99cbcc12, Offset: 0xaca8
// Size: 0xa
function function_5f1e8e1b() {
    return "wpn_t7_uplink_ball_world";
}

// Namespace prop
// Params 0, eflags: 0x0
// namespace_a9dea446<file_0>::function_f26960c8
// Checksum 0xfc7be020, Offset: 0xacc0
// Size: 0x15e
function function_f26960c8() {
    var_8eb640f2 = 40;
    var_8ba71423 = 4;
    model = function_5f1e8e1b();
    numtargets = min(level.var_e5ad813f.targetlocations.size, var_8eb640f2);
    level.var_e5ad813f.targets = [];
    num = 0;
    for (i = 0; i < numtargets; i++) {
        origin = function_8e704405();
        target = function_98636e21(origin, model);
        level.var_e5ad813f.targets[level.var_e5ad813f.targets.size] = target;
        num++;
        if (num >= var_8ba71423) {
            wait(0.05);
            num = 0;
        }
    }
}

// Namespace prop
// Params 1, eflags: 0x0
// namespace_a9dea446<file_0>::function_7d3dbc54
// Checksum 0x7336442d, Offset: 0xae28
// Size: 0x44
function function_7d3dbc54(targetent) {
    wait(0.05);
    if (isdefined(targetent)) {
        playfxontag("ui/fx_uplink_ball_vanish", targetent, "tag_origin");
    }
}

// Namespace prop
// Params 2, eflags: 0x0
// namespace_a9dea446<file_0>::function_98636e21
// Checksum 0xb88718f9, Offset: 0xae78
// Size: 0x1b0
function function_98636e21(origin, model) {
    target = spawn("script_model", origin);
    target setmodel(model);
    target.targetname = "propTarget";
    target setcandamage(1);
    target.fakehealth = 50;
    target.health = 99999;
    target.maxhealth = 99999;
    target thread function_500dc7d9(&function_8d5e52a2);
    target setplayercollision(0);
    target makesentient();
    target function_344baafe();
    target setteam(game["defenders"]);
    target hidefromteam(game["defenders"]);
    target setscale(2, 1);
    thread function_7d3dbc54(target);
    return target;
}

// Namespace prop
// Params 10, eflags: 0x0
// namespace_a9dea446<file_0>::function_8d5e52a2
// Checksum 0x26e010fc, Offset: 0xb030
// Size: 0x118
function function_8d5e52a2(damage, attacker, direction_vec, point, meansofdeath, modelname, tagname, partname, weapon, idflags) {
    if (!isdefined(attacker)) {
        return;
    }
    if (isplayer(attacker)) {
        if (isdefined(self.isdying) && self.isdying) {
            return;
        }
        attacker thread damagefeedback::update();
        self.lastattacker = attacker;
        self.fakehealth -= damage;
        if (self.fakehealth <= 0) {
            function_a88142c8(attacker);
            self thread movetarget();
        }
    }
    self.health += damage;
}

// Namespace prop
// Params 0, eflags: 0x0
// namespace_a9dea446<file_0>::function_d4992ad5
// Checksum 0xfb2b762, Offset: 0xb150
// Size: 0x190
function movetarget() {
    self.isdying = 1;
    wait(0.05);
    self.fakehealth = 50;
    fxent = playfx(fx::get("propDeathFX"), self.origin + (0, 0, 4));
    fxent hide();
    foreach (player in level.players) {
        if (player function_e4b2f23()) {
            fxent showtoplayer(player);
        }
    }
    fxent playsoundtoteam("wpn_flash_grenade_explode", game["attackers"]);
    self.origin = function_8e704405();
    self dontinterpolate();
    self.isdying = 0;
}

// Namespace prop
// Params 1, eflags: 0x0
// namespace_a9dea446<file_0>::function_5e31e74e
// Checksum 0x4e9debe3, Offset: 0xb2e8
// Size: 0xdc
function function_5e31e74e(location) {
    var_cc2c9630 = 90000;
    foreach (target in level.var_e5ad813f.targets) {
        distsq = distancesquared(target.origin, location);
        if (distsq < var_cc2c9630) {
            return true;
        }
    }
    return false;
}

// Namespace prop
// Params 0, eflags: 0x0
// namespace_a9dea446<file_0>::function_8e704405
// Checksum 0xed251c34, Offset: 0xb3d0
// Size: 0x290
function function_8e704405() {
    if (level.var_e5ad813f.nextindex >= level.var_e5ad813f.targetlocations.size) {
        level.var_e5ad813f.nextindex = 0;
    }
    location = level.var_e5ad813f.targetlocations[level.var_e5ad813f.nextindex];
    if (!isdefined(location.var_54fb921c)) {
        dir = level.mapcenter - location.origin;
        dist = distance(level.mapcenter, location.origin);
        if (dist > 0) {
            dir = (dir[0] / dist, dir[1] / dist, dir[2] / dist);
        }
        attempts = 9;
        newlocation = location.origin;
        rand = randomfloat(1);
        while (attempts > 0) {
            randdist = dist * rand;
            newlocation = location.origin + dir * randdist;
            if (!function_5e31e74e(newlocation)) {
                break;
            }
            rand -= 0.1;
            if (rand < 0) {
                newlocation = location.origin;
                break;
            }
            attempts--;
        }
        newlocation = getclosestpointonnavmesh(newlocation, 100);
        if (!isdefined(newlocation)) {
            newlocation = location.origin;
        }
        location.var_54fb921c = newlocation;
    }
    origin = location.var_54fb921c + (0, 0, 40);
    level.var_e5ad813f.nextindex++;
    return origin;
}

// Namespace prop
// Params 4, eflags: 0x0
// namespace_a9dea446<file_0>::function_249fb651
// Checksum 0x753280b4, Offset: 0xb668
// Size: 0x15c
function function_249fb651(x, y, label, color) {
    var_f2d1d7d5 = hud::createserverfontstring("default", 1.5, game["attackers"]);
    var_f2d1d7d5.label = label;
    var_f2d1d7d5.x = x;
    var_f2d1d7d5.y = y;
    var_f2d1d7d5.alignx = "left";
    var_f2d1d7d5.aligny = "top";
    var_f2d1d7d5.horzalign = "left";
    var_f2d1d7d5.vertalign = "top";
    var_f2d1d7d5.color = color;
    var_f2d1d7d5.archived = 1;
    var_f2d1d7d5.alpha = 0;
    var_f2d1d7d5.glowalpha = 0;
    var_f2d1d7d5.hidewheninmenu = 0;
    var_f2d1d7d5.sort = 1001;
    return var_f2d1d7d5;
}

// Namespace prop
// Params 1, eflags: 0x0
// namespace_a9dea446<file_0>::function_9b0f77c4
// Checksum 0xa685371a, Offset: 0xb7d0
// Size: 0x2cc
function function_9b0f77c4(titlelabel) {
    level.var_e5ad813f.var_239c724 = [];
    var_62372e41 = 110;
    var_ff475784 = 20;
    if (!level.console) {
        var_62372e41 = 125;
        var_ff475784 = 15;
    }
    x = 5;
    y = var_62372e41;
    level.var_e5ad813f.var_239c724[level.var_e5ad813f.var_239c724.size] = function_249fb651(x, y, %MP_PH_MINIGAME_FIRST, (1, 0.843, 0));
    y += var_ff475784;
    level.var_e5ad813f.var_239c724[level.var_e5ad813f.var_239c724.size] = function_249fb651(x, y, %MP_PH_MINIGAME_SECOND, (0.3, 0.3, 0.3));
    y += var_ff475784;
    level.var_e5ad813f.var_239c724[level.var_e5ad813f.var_239c724.size] = function_249fb651(x, y, %MP_PH_MINIGAME_THIRD, (0.804, 0.498, 0.196));
    level.var_e5ad813f.var_d410e6e5 = hud::createserverfontstring("default", 2.5, game["attackers"]);
    level.var_e5ad813f.var_d410e6e5 hud::setpoint("CENTER", undefined, 0, -30);
    level.var_e5ad813f.var_d410e6e5.label = titlelabel;
    level.var_e5ad813f.var_d410e6e5.x = 0;
    level.var_e5ad813f.var_d410e6e5.archived = 1;
    level.var_e5ad813f.var_d410e6e5.alpha = 1;
    level.var_e5ad813f.var_d410e6e5.glowalpha = 0;
    level.var_e5ad813f.var_d410e6e5.hidewheninmenu = 0;
    thread function_e14e11c4();
}

// Namespace prop
// Params 0, eflags: 0x0
// namespace_a9dea446<file_0>::function_e14e11c4
// Checksum 0x6458c37a, Offset: 0xbaa8
// Size: 0x110
function function_e14e11c4() {
    level endon(#"game_ended");
    wait(5.5);
    level.var_e5ad813f.var_d410e6e5 moveovertime(1);
    level.var_e5ad813f.var_d410e6e5 hud::setpoint("CENTER", undefined, 0, -100);
    wait(1);
    level.var_e5ad813f.var_d410e6e5 fadeovertime(1);
    level.var_e5ad813f.var_d410e6e5.color = (0, 1, 0);
    wait(1);
    level.var_e5ad813f.var_d410e6e5 fadeovertime(1);
    level.var_e5ad813f.var_d410e6e5.color = (1, 1, 1);
}

// Namespace prop
// Params 1, eflags: 0x0
// namespace_a9dea446<file_0>::function_a88142c8
// Checksum 0x6bcb5a2d, Offset: 0xbbc0
// Size: 0xb4
function function_a88142c8(player) {
    var_47b5687d = gettime() - level.starttime - level.var_f2aa1432;
    player.var_efe75c2f++;
    player.var_61add00c += var_47b5687d;
    player.var_24edba04 setvalue(player.var_efe75c2f);
    player thread function_1cda54();
    function_c021720c();
}

// Namespace prop
// Params 1, eflags: 0x0
// namespace_a9dea446<file_0>::function_c021720c
// Checksum 0x30238f7c, Offset: 0xbc80
// Size: 0x1c2
function function_c021720c(delaytime) {
    level endon(#"game_ended");
    if (isdefined(delaytime)) {
        wait(delaytime);
    }
    hunters = getlivingplayersonteam(game["attackers"]);
    var_711fc677 = array::quicksort(hunters, &function_69596636);
    for (i = 0; i < 3; i++) {
        if (isdefined(var_711fc677[i]) && isdefined(var_711fc677[i].var_efe75c2f) && var_711fc677[i].var_efe75c2f > 0) {
            level.var_e5ad813f.var_239c724[i].alpha = 1;
            level.var_e5ad813f.var_239c724[i] setplayernamestring(var_711fc677[i]);
            continue;
        }
        if (isdefined(level.var_e5ad813f.var_239c724) && isdefined(level.var_e5ad813f.var_239c724[i]) && level.var_e5ad813f.var_239c724[i].alpha > 0) {
            level.var_e5ad813f.var_239c724[i].alpha = 0;
        }
    }
}

// Namespace prop
// Params 2, eflags: 0x0
// namespace_a9dea446<file_0>::function_69596636
// Checksum 0xb342a759, Offset: 0xbe50
// Size: 0xc0
function function_69596636(p1, p2) {
    if (!isdefined(p1) || !isdefined(p1.var_efe75c2f)) {
        return false;
    }
    if (!isdefined(p2) || !isdefined(p2.var_efe75c2f)) {
        return true;
    }
    if (p1.var_efe75c2f > p2.var_efe75c2f) {
        return true;
    }
    return p1.var_efe75c2f == p2.var_efe75c2f && p1.var_61add00c <= p2.var_61add00c;
}

// Namespace prop
// Params 1, eflags: 0x0
// namespace_a9dea446<file_0>::function_ae94b584
// Checksum 0xa9ea3a53, Offset: 0xbf18
// Size: 0x138
function function_ae94b584(label) {
    self.var_24edba04 = hud::createfontstring("objective", 1);
    self.var_24edba04.label = label;
    self.var_24edba04.x = 0;
    self.var_24edba04.y = 20;
    self.var_24edba04.alignx = "center";
    self.var_24edba04.aligny = "middle";
    self.var_24edba04.horzalign = "user_center";
    self.var_24edba04.vertalign = "middle";
    self.var_24edba04.archived = 1;
    self.var_24edba04.fontscale = 1;
    self.var_24edba04.alpha = 0;
    self.var_24edba04.glowalpha = 0.5;
    self.var_24edba04.hidewheninmenu = 0;
}

// Namespace prop
// Params 1, eflags: 0x0
// namespace_a9dea446<file_0>::function_89acdf0d
// Checksum 0xa6047f54, Offset: 0xc058
// Size: 0x24
function function_89acdf0d(label) {
    self function_ae94b584(label);
}

// Namespace prop
// Params 0, eflags: 0x0
// namespace_a9dea446<file_0>::function_1cda54
// Checksum 0xd60fa716, Offset: 0xc088
// Size: 0x48
function function_1cda54() {
    self.var_24edba04.alpha = 1;
    self.var_24edba04 fadeovertime(3);
    self.var_24edba04.alpha = 0;
}

// Namespace prop
// Params 0, eflags: 0x0
// namespace_a9dea446<file_0>::function_83efbfcf
// Checksum 0x431aa739, Offset: 0xc0d8
// Size: 0x13c
function function_83efbfcf() {
    forward = anglestoforward(self getangles());
    origin = self.origin + vectorscale(forward, 100);
    origin = getclosestpointonnavmesh(origin, 600);
    clone = spawnactor("spawner_bo3_robot_grunt_assault_mp", origin, self.angles, "", 1);
    clone.var_9352d14f = function_16efb8e6(origin + (0, 0, 40));
    clone.var_9352d14f linkto(clone);
    level.var_abcf2d12[level.var_abcf2d12.size] = clone;
    function_ec41bbd2(clone, self, forward);
}

// Namespace prop
// Params 3, eflags: 0x0
// namespace_a9dea446<file_0>::function_ec41bbd2
// Checksum 0x7b8e3cb, Offset: 0xc220
// Size: 0x454
function function_ec41bbd2(clone, player, forward) {
    clone.isaiclone = 1;
    clone.propername = "";
    clone.ignoretriggerdamage = 1;
    clone.minwalkdistance = 125;
    clone.overrideactordamage = &clonedamageoverride;
    clone.spawntime = gettime();
    clone.var_132756fd = 1;
    clone setmaxhealth(9999);
    clone function_1762804b(1);
    clone pushplayer(1);
    clone setcontents(8192);
    clone setavoidancemask("avoid none");
    clone.var_6f5f0e80 = gameobjects::get_next_obj_id();
    objective_add(clone.var_6f5f0e80, "active");
    objective_team(clone.var_6f5f0e80, game["attackers"]);
    objective_position(clone.var_6f5f0e80, clone.origin);
    objective_icon(clone.var_6f5f0e80, "t7_hud_waypoints_safeguard_location");
    objective_setcolor(clone.var_6f5f0e80, %FriendlyBlue);
    objective_onentity(clone.var_6f5f0e80, clone);
    clone asmsetanimationrate(1.2);
    clone setclone();
    clone._goal_center_point = function_176b694c();
    queryresult = undefined;
    if (isdefined(clone._goal_center_point) && clone findpath(clone.origin, clone._goal_center_point, 1, 0)) {
        queryresult = positionquery_source_navigation(clone._goal_center_point, 0, 450, 450, 100, clone);
    } else {
        queryresult = positionquery_source_navigation(clone.origin, 500, 750, 750, 50, clone);
    }
    if (queryresult.data.size > 0) {
        clone setgoalpos(queryresult.data[0].origin, 1);
        clone._clone_goal = queryresult.data[0].origin;
        clone._clone_goal_max_dist = 450;
    } else {
        clone._goal_center_point = clone.origin;
    }
    clone thread _updateclonepathing();
    clone hidefromteam(game["defenders"]);
    clone ghost();
    _configurecloneteam(clone, player);
}

// Namespace prop
// Params 15, eflags: 0x0
// namespace_a9dea446<file_0>::function_f574665f
// Checksum 0x68b21c91, Offset: 0xc680
// Size: 0x7e
function clonedamageoverride(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, timeoffset, boneindex, modelindex, surfacetype, surfacenormal) {
    return false;
}

// Namespace prop
// Params 2, eflags: 0x0
// namespace_a9dea446<file_0>::function_fb6b3c68
// Checksum 0x70555c38, Offset: 0xc708
// Size: 0x80
function _configurecloneteam(clone, player) {
    team = util::getotherteam(player.team);
    clone.ignoreall = 1;
    clone setteam(team);
    clone.team = team;
}

// Namespace prop
// Params 0, eflags: 0x0
// namespace_a9dea446<file_0>::function_41d2c44e
// Checksum 0x10f4d074, Offset: 0xc790
// Size: 0xfa
function function_41d2c44e() {
    var_b71aa5e8 = 10000;
    var_ae1cb2e9 = [];
    foreach (clone in level.var_abcf2d12) {
        if (self == clone) {
            continue;
        }
        distsq = distancesquared(clone.origin, self.origin);
        if (distsq < var_b71aa5e8) {
            var_ae1cb2e9[var_ae1cb2e9.size] = clone;
        }
    }
    return var_ae1cb2e9;
}

// Namespace prop
// Params 0, eflags: 0x0
// namespace_a9dea446<file_0>::function_f78d9549
// Checksum 0x975eeaff, Offset: 0xc898
// Size: 0x3d4
function _updateclonepathing() {
    self endon(#"death");
    clone_not_moving_dist_sq = 576;
    clone_not_moving_poll_time = 2000;
    var_38da5046 = 1500;
    if (!isdefined(level.var_e5ad813f.var_dffd326e)) {
        level.var_e5ad813f.var_dffd326e = 0;
    }
    while (true) {
        if (!isdefined(self.lastknownpos)) {
            self.lastknownpos = self.origin;
            self.lastknownpostime = gettime();
        }
        if (!isdefined(self.var_20143a0c)) {
            self.var_20143a0c = gettime();
        }
        distance = 0;
        if (isdefined(self._clone_goal)) {
            distance = distancesquared(self._clone_goal, self.origin);
        }
        var_9bac6f63 = 0;
        if (distance < 14400) {
            var_9bac6f63 = 1;
        } else if (!self haspath()) {
            var_9bac6f63 = 1;
        } else if (self.lastknownpostime + clone_not_moving_poll_time <= gettime()) {
            if (distancesquared(self.lastknownpos, self.origin) < clone_not_moving_dist_sq) {
                var_9bac6f63 = 1;
            }
            self.lastknownpos = self.origin;
            self.lastknownpostime = gettime();
        } else if (self.var_20143a0c + var_38da5046 <= gettime() && level.var_e5ad813f.var_dffd326e != gettime()) {
            clones = function_41d2c44e();
            if (clones.size > 0) {
                var_9bac6f63 = 1;
            }
            for (i = 0; i < clones.size; i++) {
                clones[i].var_20143a0c = gettime();
            }
            self.var_20143a0c = gettime();
        }
        if (var_9bac6f63) {
            level.var_e5ad813f.var_dffd326e = gettime();
            self._goal_center_point = function_176b694c();
            queryresult = positionquery_source_navigation(self._goal_center_point, 500, 750, 750, 100, self);
            if (queryresult.data.size == 0) {
                queryresult = positionquery_source_navigation(self.origin, 500, 750, 750, 100, self);
            }
            if (queryresult.data.size > 0) {
                randindex = randomintrange(0, queryresult.data.size);
                self setgoalpos(queryresult.data[randindex].origin, 1);
                self._clone_goal = queryresult.data[randindex].origin;
                self._clone_goal_max_dist = 750;
            }
        }
        wait(0.5);
    }
}

// Namespace prop
// Params 0, eflags: 0x0
// namespace_a9dea446<file_0>::function_176b694c
// Checksum 0xf28bca49, Offset: 0xcc78
// Size: 0x8a
function function_176b694c() {
    if (level.var_e5ad813f.nextindex >= level.var_e5ad813f.targetlocations.size) {
        level.var_e5ad813f.nextindex = 0;
    }
    location = level.var_e5ad813f.targetlocations[level.var_e5ad813f.nextindex];
    level.var_e5ad813f.nextindex++;
    return location.origin;
}

// Namespace prop
// Params 1, eflags: 0x0
// namespace_a9dea446<file_0>::function_16efb8e6
// Checksum 0x20dc11b7, Offset: 0xcd10
// Size: 0x1c0
function function_16efb8e6(origin) {
    model = function_5f1e8e1b();
    target = spawn("script_model", origin);
    target setmodel(model);
    target.targetname = "propTarget";
    target setcandamage(1);
    target.fakehealth = 50;
    target.health = 99999;
    target.maxhealth = 99999;
    target thread function_500dc7d9(&function_12f9ab17);
    target setplayercollision(0);
    target makesentient();
    target function_344baafe();
    target setteam(game["defenders"]);
    target hidefromteam(game["defenders"]);
    target setscale(2, 1);
    thread function_7d3dbc54(target);
    return target;
}

// Namespace prop
// Params 10, eflags: 0x0
// namespace_a9dea446<file_0>::function_12f9ab17
// Checksum 0x9a653a5b, Offset: 0xced8
// Size: 0xc0
function function_12f9ab17(damage, attacker, direction_vec, point, meansofdeath, modelname, tagname, partname, weapon, idflags) {
    if (!isdefined(attacker)) {
        return;
    }
    if (isplayer(attacker)) {
        attacker thread damagefeedback::update();
        self.lastattacker = attacker;
        function_a88142c8(attacker);
    }
    self.health += damage;
}

