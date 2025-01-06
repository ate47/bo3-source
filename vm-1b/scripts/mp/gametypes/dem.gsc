#using scripts/mp/_challenges;
#using scripts/mp/_util;
#using scripts/mp/gametypes/_battlechatter;
#using scripts/mp/gametypes/_dogtags;
#using scripts/mp/gametypes/_globallogic;
#using scripts/mp/gametypes/_globallogic_audio;
#using scripts/mp/gametypes/_globallogic_defaults;
#using scripts/mp/gametypes/_globallogic_score;
#using scripts/mp/gametypes/_globallogic_spawn;
#using scripts/mp/gametypes/_globallogic_utils;
#using scripts/mp/gametypes/_hostmigration;
#using scripts/mp/gametypes/_spawning;
#using scripts/mp/gametypes/_spawnlogic;
#using scripts/mp/gametypes/_spectating;
#using scripts/shared/challenges_shared;
#using scripts/shared/demo_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/gameobjects_shared;
#using scripts/shared/hostmigration_shared;
#using scripts/shared/hud_util_shared;
#using scripts/shared/math_shared;
#using scripts/shared/medals_shared;
#using scripts/shared/popups_shared;
#using scripts/shared/rank_shared;
#using scripts/shared/scoreevents_shared;
#using scripts/shared/sound_shared;

#namespace dem;

// Namespace dem
// Params 0, eflags: 0x0
// Checksum 0x7f80708f, Offset: 0xe30
// Size: 0x34a
function main() {
    globallogic::init();
    util::registerroundswitch(0, 9);
    util::registertimelimit(0, 1440);
    util::registerscorelimit(0, 500);
    util::registerroundlimit(0, 12);
    util::registerroundwinlimit(0, 10);
    util::registernumlives(0, 100);
    globallogic::registerfriendlyfiredelay(level.gametype, 15, 0, 1440);
    level.teambased = 1;
    level.overrideteamscore = 1;
    level.onprecachegametype = &onprecachegametype;
    level.onstartgametype = &onstartgametype;
    level.onspawnplayer = &onspawnplayer;
    level.playerspawnedcb = &function_51c48e40;
    level.onplayerkilled = &onplayerkilled;
    level.ondeadevent = &ondeadevent;
    level.ononeleftevent = &ononeleftevent;
    level.ontimelimit = &ontimelimit;
    level.onroundswitch = &onroundswitch;
    level.getteamkillpenalty = &function_6b1c3e2a;
    level.getteamkillscore = &function_574aa137;
    level.gettimelimit = &gettimelimit;
    level.shouldplayovertimeround = &shouldplayovertimeround;
    level.var_aee31363 = undefined;
    level.var_d7c2e234 = undefined;
    level.ddbombmodel = [];
    level.endgameonscorelimit = 0;
    level.var_610b427e = "bombzone_dem";
    gameobjects::register_allowed_gameobject(level.gametype);
    gameobjects::register_allowed_gameobject("sd");
    gameobjects::register_allowed_gameobject("blocker");
    gameobjects::register_allowed_gameobject(level.var_610b427e);
    globallogic_audio::set_leader_gametype_dialog("startDemolition", "hcStartDemolition", "objDestroy", "objDefend");
    if (!sessionmodeissystemlink() && !sessionmodeisonlinegame() && issplitscreen()) {
        globallogic::setvisiblescoreboardcolumns("score", "kills", "plants", "defuses", "deaths");
        return;
    }
    globallogic::setvisiblescoreboardcolumns("score", "kills", "deaths", "plants", "defuses");
}

// Namespace dem
// Params 0, eflags: 0x0
// Checksum 0x538be31a, Offset: 0x1188
// Size: 0x11
function onprecachegametype() {
    InvalidOpCode(0xc8, "bombmodelname", "t5_weapon_briefcase_bomb_world");
    // Unknown operator (0xc8, t7_1b, PC)
}

// Namespace dem
// Params 4, eflags: 0x0
// Checksum 0x7396bc5c, Offset: 0x11d8
// Size: 0x7f
function function_6b1c3e2a(einflictor, attacker, smeansofdeath, weapon) {
    teamkill_penalty = globallogic_defaults::default_getteamkillpenalty(einflictor, attacker, smeansofdeath, weapon);
    if (isdefined(self.isplanting) && (isdefined(self.isdefusing) && self.isdefusing || self.isplanting)) {
        teamkill_penalty *= level.teamkillpenaltymultiplier;
    }
    return teamkill_penalty;
}

// Namespace dem
// Params 4, eflags: 0x0
// Checksum 0x5e02685, Offset: 0x1260
// Size: 0x91
function function_574aa137(einflictor, attacker, smeansofdeath, weapon) {
    teamkill_score = rank::getscoreinfovalue("team_kill");
    if (isdefined(self.isplanting) && (isdefined(self.isdefusing) && self.isdefusing || self.isplanting)) {
        teamkill_score *= level.teamkillscoremultiplier;
    }
    return int(teamkill_score);
}

// Namespace dem
// Params 0, eflags: 0x0
// Checksum 0xcb014510, Offset: 0x1300
// Size: 0x11
function onroundswitch() {
    InvalidOpCode(0x54, "switchedsides");
    // Unknown operator (0x54, t7_1b, PC)
}

// Namespace dem
// Params 0, eflags: 0x0
// Checksum 0x15ed6f3d, Offset: 0x13c8
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

// Namespace dem
// Params 0, eflags: 0x0
// Checksum 0xf88094a5, Offset: 0x1560
// Size: 0xa1
function onstartgametype() {
    setbombtimer("A", 0);
    setmatchflag("bomb_timer_a", 0);
    setbombtimer("B", 0);
    setmatchflag("bomb_timer_b", 0);
    level.usingextratime = 0;
    level.spawnsystem.var_23df778 = 0;
    InvalidOpCode(0x54, "switchedsides");
    // Unknown operator (0x54, t7_1b, PC)
}

// Namespace dem
// Params 1, eflags: 0x0
// Checksum 0x342bc27e, Offset: 0x1c80
// Size: 0x32
function onspawnplayer(predictedspawn) {
    self.isplanting = 0;
    self.isdefusing = 0;
    self.isbombcarrier = 0;
    spawning::onspawnplayer(predictedspawn);
}

// Namespace dem
// Params 0, eflags: 0x0
// Checksum 0x1294d35c, Offset: 0x1cc0
// Size: 0xb
function function_51c48e40() {
    level notify(#"spawned_player");
}

// Namespace dem
// Params 9, eflags: 0x0
// Checksum 0x579816d0, Offset: 0x1cd8
// Size: 0x412
function onplayerkilled(einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime, deathanimduration) {
    thread checkallowspectating();
    if (isdefined(level.droppedtagrespawn) && level.droppedtagrespawn) {
        should_spawn_tags = self dogtags::should_spawn_tags(einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime, deathanimduration);
        should_spawn_tags = should_spawn_tags && !globallogic_spawn::mayspawn();
        if (should_spawn_tags) {
            level thread dogtags::spawn_dog_tag(self, attacker, &dogtags::onusedogtag, 0);
        }
    }
    bombzone = undefined;
    for (index = 0; index < level.bombzones.size; index++) {
        if (!isdefined(level.bombzones[index].bombexploded) || !level.bombzones[index].bombexploded) {
            dist = distance2d(self.origin, level.bombzones[index].curorigin);
            if (dist < level.defaultoffenseradius) {
                bombzone = level.bombzones[index];
                break;
            }
            dist = distance2d(attacker.origin, level.bombzones[index].curorigin);
            if (dist < level.defaultoffenseradius) {
                inbombzone = 1;
                break;
            }
        }
    }
    if (isdefined(bombzone) && isplayer(attacker) && attacker.pers["team"] != self.pers["team"]) {
        if (bombzone gameobjects::get_owner_team() != attacker.team) {
            if (!isdefined(attacker.var_eed7b875)) {
                attacker.var_eed7b875 = 0;
            }
            attacker.var_eed7b875++;
            if (level.playeroffensivemax >= attacker.var_eed7b875) {
                attacker medals::offenseglobalcount();
                attacker addplayerstatwithgametype("OFFENDS", 1);
                self recordkillmodifier("defending");
                scoreevents::processscoreevent("killed_defender", attacker, self, weapon);
            } else {
                /#
                    attacker iprintlnbold("<dev string:x28>");
                #/
            }
        } else {
            if (!isdefined(attacker.var_e421c543)) {
                attacker.var_e421c543 = 0;
            }
            attacker.var_e421c543++;
            if (level.playerdefensivemax >= attacker.var_e421c543) {
                if (isdefined(attacker.pers["defends"])) {
                    attacker.pers["defends"]++;
                    attacker.defends = attacker.pers["defends"];
                }
                attacker medals::defenseglobalcount();
                attacker addplayerstatwithgametype("DEFENDS", 1);
                self recordkillmodifier("assaulting");
                scoreevents::processscoreevent("killed_attacker", attacker, self, weapon);
            } else {
                /#
                    attacker iprintlnbold("<dev string:x6f>");
                #/
            }
        }
    }
    if (self.isplanting == 1) {
        self recordkillmodifier("planting");
    }
    if (self.isdefusing == 1) {
        self recordkillmodifier("defusing");
    }
}

// Namespace dem
// Params 0, eflags: 0x0
// Checksum 0x5cf99753, Offset: 0x20f8
// Size: 0x4d
function checkallowspectating() {
    self endon(#"disconnect");
    wait 0.05;
    update = 0;
    livesleft = !(level.numlives && !self.pers["lives"]);
    InvalidOpCode(0x54, "attackers");
    // Unknown operator (0x54, t7_1b, PC)
}

// Namespace dem
// Params 2, eflags: 0x0
// Checksum 0x592d95aa, Offset: 0x21d0
// Size: 0x4a
function function_3649f4f9(winningteam, endreasontext) {
    if (isdefined(winningteam) && winningteam != "tie") {
        globallogic_score::giveteamscoreforobjective(winningteam, 1);
    }
    thread globallogic::endgame(winningteam, endreasontext);
}

// Namespace dem
// Params 1, eflags: 0x0
// Checksum 0x4fef1549, Offset: 0x2228
// Size: 0xa5
function ondeadevent(team) {
    if (level.bombexploded || level.bombdefused) {
        return;
    }
    if (team == "all") {
        if (level.bombplanted) {
            InvalidOpCode(0x54, "defenders");
            // Unknown operator (0x54, t7_1b, PC)
        }
        InvalidOpCode(0x54, "attackers");
        // Unknown operator (0x54, t7_1b, PC)
    }
    InvalidOpCode(0x54, "attackers", team);
    // Unknown operator (0x54, t7_1b, PC)
}

// Namespace dem
// Params 1, eflags: 0x0
// Checksum 0x64ffbb19, Offset: 0x2358
// Size: 0x32
function ononeleftevent(team) {
    if (level.bombexploded || level.bombdefused) {
        return;
    }
    warnlastplayer(team);
}

// Namespace dem
// Params 0, eflags: 0x0
// Checksum 0x1b23461a, Offset: 0x2398
// Size: 0x19
function ontimelimit() {
    InvalidOpCode(0x54, "overtime_round");
    // Unknown operator (0x54, t7_1b, PC)
}

// Namespace dem
// Params 1, eflags: 0x0
// Checksum 0x1eb49134, Offset: 0x24c0
// Size: 0xfa
function warnlastplayer(team) {
    if (!isdefined(level.warnedlastplayer)) {
        level.warnedlastplayer = [];
    }
    if (isdefined(level.warnedlastplayer[team])) {
        return;
    }
    level.warnedlastplayer[team] = 1;
    players = level.players;
    for (i = 0; i < players.size; i++) {
        player = players[i];
        if (isdefined(player.pers["team"]) && player.pers["team"] == team && isdefined(player.pers["class"])) {
            if (player.sessionstate == "playing" && !player.afk) {
                break;
            }
        }
    }
    if (i == players.size) {
        return;
    }
    players[i] thread givelastattackerwarning();
}

// Namespace dem
// Params 0, eflags: 0x0
// Checksum 0xa9772cbc, Offset: 0x25c8
// Size: 0x92
function givelastattackerwarning() {
    self endon(#"death");
    self endon(#"disconnect");
    fullhealthtime = 0;
    interval = 0.05;
    while (true) {
        if (self.health != self.maxhealth) {
            fullhealthtime = 0;
        } else {
            fullhealthtime += interval;
        }
        wait interval;
        if (self.health == self.maxhealth && fullhealthtime >= 3) {
            break;
        }
    }
    self globallogic_audio::leader_dialog_on_player("roundSuddenDeath");
}

// Namespace dem
// Params 0, eflags: 0x0
// Checksum 0x1c092fb7, Offset: 0x2668
// Size: 0x162
function updategametypedvars() {
    level.planttime = getgametypesetting("plantTime");
    level.defusetime = getgametypesetting("defuseTime");
    level.bombtimer = getgametypesetting("bombTimer");
    level.extratime = getgametypesetting("extraTime");
    level.overtimetimelimit = getgametypesetting("OvertimetimeLimit");
    level.teamkillpenaltymultiplier = getgametypesetting("teamKillPenalty");
    level.teamkillscoremultiplier = getgametypesetting("teamKillScore");
    level.var_a1653832 = getgametypesetting("maxPlayerEventsPerMinute");
    level.var_aefe2e3b = getgametypesetting("maxObjectiveEventsPerMinute");
    level.playeroffensivemax = getgametypesetting("maxPlayerOffensive");
    level.playerdefensivemax = getgametypesetting("maxPlayerDefensive");
}

// Namespace dem
// Params 0, eflags: 0x0
// Checksum 0x597c5091, Offset: 0x27d8
// Size: 0x9
function resetbombzone() {
    InvalidOpCode(0x54, "overtime_round");
    // Unknown operator (0x54, t7_1b, PC)
}

// Namespace dem
// Params 0, eflags: 0x0
// Checksum 0x5de5a0fd, Offset: 0x2970
// Size: 0x12a
function setupfordefusing() {
    self gameobjects::allow_use("friendly");
    self gameobjects::set_use_time(level.defusetime);
    self gameobjects::set_use_text(%MP_DEFUSING_EXPLOSIVE);
    self gameobjects::set_use_hint_text(%PLATFORM_HOLD_TO_DEFUSE_EXPLOSIVES);
    self gameobjects::set_key_object(undefined);
    self gameobjects::set_2d_icon("friendly", "compass_waypoint_defuse" + self.label);
    self gameobjects::set_3d_icon("friendly", "waypoint_defuse" + self.label);
    self gameobjects::set_2d_icon("enemy", "compass_waypoint_defend" + self.label);
    self gameobjects::set_3d_icon("enemy", "waypoint_defend" + self.label);
    self gameobjects::set_visible_team("any");
}

// Namespace dem
// Params 0, eflags: 0x0
// Checksum 0xeb3bc048, Offset: 0x2aa8
// Size: 0x70d
function bombs() {
    level.var_baf05922 = 0;
    level.var_5a20d54f = 0;
    level.bombplanted = 0;
    level.bombdefused = 0;
    level.bombexploded = 0;
    sdbomb = getent("sd_bomb", "targetname");
    if (isdefined(sdbomb)) {
        sdbomb delete();
    }
    level.bombzones = [];
    bombzones = getentarray(level.var_610b427e, "targetname");
    index = 0;
    if (index < bombzones.size) {
        trigger = bombzones[index];
        scriptlabel = trigger.script_label;
        visuals = getentarray(bombzones[index].target, "targetname");
        var_8aad6fd = getentarray("bombzone_clip" + scriptlabel, "targetname");
        defusetrig = getent(visuals[0].target, "targetname");
        InvalidOpCode(0x54, "defenders");
        // Unknown operator (0x54, t7_1b, PC)
    }
    for (index = 0; index < level.bombzones.size; index++) {
        array = [];
        for (otherindex = 0; otherindex < level.bombzones.size; otherindex++) {
            if (otherindex != index) {
                array[array.size] = level.bombzones[otherindex];
            }
        }
        level.bombzones[index].otherbombzones = array;
    }
}

// Namespace dem
// Params 3, eflags: 0x0
// Checksum 0x652c056b, Offset: 0x31c0
// Size: 0x72
function setbomboverheatingafterweaponchange(useobject, overheated, heat) {
    self endon(#"death");
    self endon(#"disconnect");
    self endon(#"joined_team");
    self endon(#"joined_spectators");
    self waittill(#"weapon_change", weapon);
    if (weapon == useobject.useweapon) {
        self setweaponoverheating(overheated, heat, weapon);
    }
}

// Namespace dem
// Params 1, eflags: 0x0
// Checksum 0x198167bd, Offset: 0x3240
// Size: 0x232
function onbeginuse(player) {
    timeremaining = globallogic_utils::gettimeremaining();
    if (timeremaining <= level.planttime * 1000) {
        globallogic_utils::pausetimer();
        level.var_df6954d8 = 1;
    }
    if (self gameobjects::is_friendly_team(player.pers["team"])) {
        player playsound("mpl_sd_bomb_defuse");
        player.isdefusing = 1;
        player thread setbomboverheatingafterweaponchange(self, 0, 0);
        player thread battlechatter::gametype_specific_battle_chatter("sd_enemyplant", player.pers["team"]);
        bestdistance = 9000000;
        var_3a8262b2 = undefined;
        if (isdefined(level.ddbombmodel)) {
            keys = getarraykeys(level.ddbombmodel);
            for (bomblabel = 0; bomblabel < keys.size; bomblabel++) {
                bomb = level.ddbombmodel[keys[bomblabel]];
                if (!isdefined(bomb)) {
                    continue;
                }
                dist = distancesquared(player.origin, bomb.origin);
                if (dist < bestdistance) {
                    bestdistance = dist;
                    var_3a8262b2 = bomb;
                }
            }
            assert(isdefined(var_3a8262b2));
            player.defusing = var_3a8262b2;
            var_3a8262b2 hide();
        }
    } else {
        player.isplanting = 1;
        player thread setbomboverheatingafterweaponchange(self, 0, 0);
        player thread battlechatter::gametype_specific_battle_chatter("sd_friendlyplant", player.pers["team"]);
    }
    player playsound("fly_bomb_raise_plr");
}

// Namespace dem
// Params 3, eflags: 0x0
// Checksum 0x82fd511c, Offset: 0x3480
// Size: 0xc2
function onenduse(team, player, result) {
    if (!isdefined(player)) {
        return;
    }
    if (!level.var_baf05922 && !level.var_5a20d54f) {
        globallogic_utils::resumetimer();
        level.var_df6954d8 = 0;
    }
    player.isdefusing = 0;
    player.isplanting = 0;
    player notify(#"event_ended");
    if (self gameobjects::is_friendly_team(player.pers["team"])) {
        if (isdefined(player.defusing) && !result) {
            player.defusing show();
        }
    }
}

// Namespace dem
// Params 1, eflags: 0x0
// Checksum 0x7b2df5ed, Offset: 0x3550
// Size: 0x22
function oncantuse(player) {
    player iprintlnbold(%MP_CANT_PLANT_WITHOUT_BOMB);
}

// Namespace dem
// Params 1, eflags: 0x0
// Checksum 0xe1fd7357, Offset: 0x3580
// Size: 0x402
function function_3fa7f3e6(player) {
    team = player.team;
    enemyteam = util::getotherteam(team);
    self function_fdacd5ea();
    player function_fdacd5ea();
    if (!self gameobjects::is_friendly_team(team)) {
        self gameobjects::set_flags(1);
        level thread bombplanted(self, player);
        /#
            print("<dev string:xb6>" + self.label);
        #/
        bbprint("mpobjective", "gametime %d objtype %s label %s team %s playerx %d playery %d playerz %d", gettime(), "dem_bombplant", self.label, team, player.origin);
        player notify(#"bomb_planted");
        thread globallogic_audio::set_music_on_team("DEM_WE_PLANT", team, 5);
        thread globallogic_audio::set_music_on_team("DEM_THEY_PLANT", enemyteam, 5);
        if (isdefined(player.pers["plants"])) {
            player.pers["plants"]++;
            player.plants = player.pers["plants"];
        }
        if (!isscoreboosting(player, self)) {
            demo::bookmark("event", gettime(), player);
            player addplayerstatwithgametype("PLANTS", 1);
            scoreevents::processscoreevent("planted_bomb", player);
            player recordgameevent("plant");
        } else {
            /#
                player iprintlnbold("<dev string:xc5>");
            #/
        }
        level thread popups::displayteammessagetoall(%MP_EXPLOSIVES_PLANTED_BY, player);
        globallogic_audio::leader_dialog("bombPlanted");
        return;
    }
    self gameobjects::set_flags(0);
    player notify(#"bomb_defused");
    /#
        print("<dev string:x108>" + self.label);
    #/
    self thread bombdefused(player);
    self resetbombzone();
    bbprint("mpobjective", "gametime %d objtype %s label %s team %s playerx %d playery %d playerz %d", gettime(), "dem_bombdefused", self.label, team, player.origin);
    if (isdefined(player.pers["defuses"])) {
        player.pers["defuses"]++;
        player.defuses = player.pers["defuses"];
    }
    if (!isscoreboosting(player, self)) {
        demo::bookmark("event", gettime(), player);
        player addplayerstatwithgametype("DEFUSES", 1);
        scoreevents::processscoreevent("defused_bomb", player);
        player recordgameevent("defuse");
    } else {
        /#
            player iprintlnbold("<dev string:x117>");
        #/
    }
    level thread popups::displayteammessagetoall(%MP_EXPLOSIVES_DEFUSED_BY, player);
    thread globallogic_audio::set_music_on_team("DEM_WE_DEFUSE", team, 5);
    thread globallogic_audio::set_music_on_team("DEM_THEY_DEFUSE", enemyteam, 5);
    globallogic_audio::leader_dialog("bombDefused");
}

// Namespace dem
// Params 1, eflags: 0x0
// Checksum 0xc8f53314, Offset: 0x3990
// Size: 0xa1
function ondrop(player) {
    if (!level.bombplanted) {
        globallogic_audio::leader_dialog("bombFriendlyDropped", player.pers["team"]);
        /#
            if (isdefined(player)) {
                print("<dev string:x15b>");
            } else {
                print("<dev string:x15b>");
            }
        #/
    }
    player notify(#"event_ended");
    self gameobjects::set_3d_icon("friendly", "waypoint_bomb");
    InvalidOpCode(0x54, "attackers");
    // Unknown operator (0x54, t7_1b, PC)
}

// Namespace dem
// Params 1, eflags: 0x0
// Checksum 0xfdfeaa30, Offset: 0x3a58
// Size: 0xc9
function onpickup(player) {
    player.isbombcarrier = 1;
    self gameobjects::set_3d_icon("friendly", "waypoint_defend");
    if (!level.bombdefused) {
        thread sound::play_on_players("mus_sd_pickup" + "_" + level.teampostfix[player.pers["team"]], player.pers["team"]);
        globallogic_audio::leader_dialog("bombFriendlyTaken", player.pers["team"]);
        /#
            print("<dev string:x168>");
        #/
    }
    InvalidOpCode(0x54, "attackers");
    // Unknown operator (0x54, t7_1b, PC)
}

// Namespace dem
// Params 0, eflags: 0x0
// Checksum 0xe9c07cd6, Offset: 0x3b48
// Size: 0x2
function onreset() {
    
}

// Namespace dem
// Params 2, eflags: 0x0
// Checksum 0xde036fa7, Offset: 0x3b58
// Size: 0xb2
function function_cd724d52(label, reason) {
    if (label == "_a") {
        level.var_baf05922 = 0;
        setbombtimer("A", 0);
    } else {
        level.var_5a20d54f = 0;
        setbombtimer("B", 0);
    }
    setmatchflag("bomb_timer" + label, 0);
    if (!level.var_baf05922 && !level.var_5a20d54f) {
        globallogic_utils::resumetimer();
    }
    self.visuals[0] globallogic_utils::stoptickingsound();
}

// Namespace dem
// Params 2, eflags: 0x0
// Checksum 0x8eb2cb08, Offset: 0x3c18
// Size: 0x1d2
function dropbombmodel(player, site) {
    trace = bullettrace(player.origin + (0, 0, 20), player.origin - (0, 0, 2000), 0, player);
    tempangle = randomfloat(360);
    forward = (cos(tempangle), sin(tempangle), 0);
    forward = vectornormalize(forward - vectorscale(trace["normal"], vectordot(forward, trace["normal"])));
    dropangles = vectortoangles(forward);
    if (isdefined(trace["surfacetype"]) && trace["surfacetype"] == "water") {
        phystrace = playerphysicstrace(player.origin + (0, 0, 20), player.origin - (0, 0, 2000));
        if (isdefined(phystrace)) {
            trace["position"] = phystrace;
        }
    }
    level.ddbombmodel[site] = spawn("script_model", trace["position"]);
    level.ddbombmodel[site].angles = dropangles;
    level.ddbombmodel[site] setmodel("p7_mp_suitcase_bomb");
}

// Namespace dem
// Params 2, eflags: 0x0
// Checksum 0x43ce5fc5, Offset: 0x3df8
// Size: 0xd1
function bombplanted(destroyedobj, player) {
    level endon(#"game_ended");
    destroyedobj endon(#"bomb_defused");
    team = player.team;
    InvalidOpCode(0xc8, "challenge", team, "plantedBomb", 1);
    // Unknown operator (0xc8, t7_1b, PC)
}

// Namespace dem
// Params 0, eflags: 0x0
// Checksum 0x88a3050e, Offset: 0x4658
// Size: 0x21
function gettimelimit() {
    timelimit = globallogic_defaults::default_gettimelimit();
    InvalidOpCode(0x54, "overtime_round");
    // Unknown operator (0x54, t7_1b, PC)
}

// Namespace dem
// Params 0, eflags: 0x0
// Checksum 0x678015d5, Offset: 0x46a8
// Size: 0x9
function shouldplayovertimeround() {
    InvalidOpCode(0x54, "overtime_round");
    // Unknown operator (0x54, t7_1b, PC)
}

// Namespace dem
// Params 2, eflags: 0x0
// Checksum 0x6088d33a, Offset: 0x4708
// Size: 0x111
function function_c50057a0(var_4faa45a0, duration) {
    if (duration == 0) {
        return;
    }
    assert(duration > 0);
    starttime = gettime();
    endtime = gettime() + duration * 1000;
    while (gettime() < endtime) {
        hostmigration::waittillhostmigrationstarts((endtime - gettime()) / 1000);
        while (isdefined(level.hostmigrationtimer)) {
            endtime += -6;
            function_296d9a20(var_4faa45a0, endtime);
            wait 0.25;
        }
    }
    /#
        if (gettime() != endtime) {
            println("<dev string:x173>" + gettime() + "<dev string:x190>" + endtime);
        }
    #/
    while (isdefined(level.hostmigrationtimer)) {
        endtime += -6;
        function_296d9a20(var_4faa45a0, endtime);
        wait 0.25;
    }
    return gettime() - starttime;
}

// Namespace dem
// Params 2, eflags: 0x0
// Checksum 0xa56187df, Offset: 0x4828
// Size: 0xb2
function function_296d9a20(var_4faa45a0, detonatetime) {
    if (var_4faa45a0 == "_a") {
        level.var_baf05922 = 1;
        setbombtimer("A", int(detonatetime));
    } else {
        level.var_5a20d54f = 1;
        setbombtimer("B", int(detonatetime));
    }
    setmatchflag("bomb_timer" + var_4faa45a0, int(detonatetime));
}

// Namespace dem
// Params 1, eflags: 0x0
// Checksum 0x609cf48a, Offset: 0x48e8
// Size: 0xa2
function bombdefused(player) {
    self.tickingobject globallogic_utils::stoptickingsound();
    self gameobjects::allow_use("none");
    self gameobjects::set_visible_team("none");
    self.bombdefused = 1;
    self notify(#"bomb_defused");
    self.bombplanted = 0;
    self function_cd724d52(self.label, "bomb_defused");
    player setweaponoverheating(1, 100, self.useweapon);
}

// Namespace dem
// Params 2, eflags: 0x0
// Checksum 0xef625266, Offset: 0x4998
// Size: 0x5a
function function_ef279c85(team, enemyteam) {
    wait 3;
    if (!isdefined(team) || !isdefined(enemyteam)) {
        return;
    }
    thread globallogic_audio::set_music_on_team("DEM_ONE_LEFT_UNDERSCORE", team);
    thread globallogic_audio::set_music_on_team("DEM_ONE_LEFT_UNDERSCORE", enemyteam);
}

// Namespace dem
// Params 0, eflags: 0x0
// Checksum 0xebd33941, Offset: 0x4a00
// Size: 0xb2
function function_fdacd5ea() {
    if (!isdefined(self.var_46299e9f)) {
        self.var_439a060 = 0;
        self.var_46299e9f = 0;
    }
    self.var_439a060++;
    minutespassed = globallogic_utils::gettimepassed() / 60000;
    if (isplayer(self) && isdefined(self.timeplayed["total"])) {
        minutespassed = self.timeplayed["total"] / 60;
    }
    self.var_46299e9f = self.var_439a060 / minutespassed;
    if (self.var_46299e9f > self.var_439a060) {
        self.var_46299e9f = self.var_439a060;
    }
}

// Namespace dem
// Params 2, eflags: 0x0
// Checksum 0x72ba181b, Offset: 0x4ac0
// Size: 0x51
function isscoreboosting(player, flag) {
    if (!level.rankedmatch) {
        return false;
    }
    if (player.var_46299e9f > level.var_a1653832) {
        return true;
    }
    if (flag.var_46299e9f > level.var_aefe2e3b) {
        return true;
    }
    return false;
}

