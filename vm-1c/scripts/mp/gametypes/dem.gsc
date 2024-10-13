#using scripts/mp/_util;
#using scripts/mp/_challenges;
#using scripts/mp/gametypes/_spectating;
#using scripts/mp/gametypes/_spawnlogic;
#using scripts/mp/gametypes/_spawning;
#using scripts/mp/gametypes/_hostmigration;
#using scripts/mp/gametypes/_globallogic_utils;
#using scripts/mp/gametypes/_globallogic_score;
#using scripts/mp/gametypes/_globallogic_defaults;
#using scripts/mp/gametypes/_globallogic_audio;
#using scripts/mp/gametypes/_globallogic;
#using scripts/mp/gametypes/_battlechatter;
#using scripts/mp/gametypes/_globallogic_spawn;
#using scripts/mp/gametypes/_dogtags;
#using scripts/shared/sound_shared;
#using scripts/shared/scoreevents_shared;
#using scripts/shared/rank_shared;
#using scripts/shared/popups_shared;
#using scripts/shared/medals_shared;
#using scripts/shared/math_shared;
#using scripts/shared/hud_util_shared;
#using scripts/shared/hostmigration_shared;
#using scripts/shared/gameobjects_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/demo_shared;
#using scripts/shared/challenges_shared;

#namespace dem;

// Namespace dem
// Params 0, eflags: 0x0
// Checksum 0x16cbe8f6, Offset: 0xe28
// Size: 0x394
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
// Checksum 0x98c17885, Offset: 0x11c8
// Size: 0x54
function onprecachegametype() {
    game["bombmodelname"] = "t5_weapon_briefcase_bomb_world";
    game["bombmodelnameobj"] = "t5_weapon_briefcase_bomb_world";
    game["bomb_dropped_sound"] = "fly_bomb_drop_plr";
    game["bomb_recovered_sound"] = "fly_bomb_pickup_plr";
}

// Namespace dem
// Params 4, eflags: 0x0
// Checksum 0xf7365e5c, Offset: 0x1228
// Size: 0x96
function function_6b1c3e2a(einflictor, attacker, smeansofdeath, weapon) {
    teamkill_penalty = globallogic_defaults::default_getteamkillpenalty(einflictor, attacker, smeansofdeath, weapon);
    if (isdefined(self.isplanting) && (isdefined(self.isdefusing) && self.isdefusing || self.isplanting)) {
        teamkill_penalty *= level.teamkillpenaltymultiplier;
    }
    return teamkill_penalty;
}

// Namespace dem
// Params 4, eflags: 0x0
// Checksum 0x34d2e3d4, Offset: 0x12c8
// Size: 0xa2
function function_574aa137(einflictor, attacker, smeansofdeath, weapon) {
    teamkill_score = rank::getscoreinfovalue("team_kill");
    if (isdefined(self.isplanting) && (isdefined(self.isdefusing) && self.isdefusing || self.isplanting)) {
        teamkill_score *= level.teamkillscoremultiplier;
    }
    return int(teamkill_score);
}

// Namespace dem
// Params 0, eflags: 0x0
// Checksum 0xc89257bc, Offset: 0x1378
// Size: 0x128
function onroundswitch() {
    if (!isdefined(game["switchedsides"])) {
        game["switchedsides"] = 0;
    }
    if (game["teamScores"]["allies"] == level.scorelimit - 1 && game["teamScores"]["axis"] == level.scorelimit - 1) {
        aheadteam = getbetterteam();
        if (aheadteam != game["defenders"]) {
            game["switchedsides"] = !game["switchedsides"];
        }
        level.halftimetype = "overtime";
        if (isdefined(level.bombzones[1])) {
            level.bombzones[1] gameobjects::disable_object();
        }
        return;
    }
    level.halftimetype = "halftime";
    game["switchedsides"] = !game["switchedsides"];
}

// Namespace dem
// Params 0, eflags: 0x0
// Checksum 0xc43f6717, Offset: 0x14a8
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

// Namespace dem
// Params 0, eflags: 0x0
// Checksum 0x2cf1a558, Offset: 0x16c0
// Size: 0x870
function onstartgametype() {
    setbombtimer("A", 0);
    setmatchflag("bomb_timer_a", 0);
    setbombtimer("B", 0);
    setmatchflag("bomb_timer_b", 0);
    level.usingextratime = 0;
    level.spawnsystem.var_23df778 = 0;
    if (!isdefined(game["switchedsides"])) {
        game["switchedsides"] = 0;
    }
    if (game["switchedsides"]) {
        oldattackers = game["attackers"];
        olddefenders = game["defenders"];
        game["attackers"] = olddefenders;
        game["defenders"] = oldattackers;
    }
    setclientnamemode("manual_change");
    game["strings"]["target_destroyed"] = %MP_TARGET_DESTROYED;
    game["strings"]["bomb_defused"] = %MP_BOMB_DEFUSED;
    level._effect["bombexplosion"] = "explosions/fx_exp_bomb_demo_mp";
    if (isdefined(game["overtime_round"])) {
        util::setobjectivetext(game["attackers"], %OBJECTIVES_DEM_ATTACKER);
        util::setobjectivetext(game["defenders"], %OBJECTIVES_DEM_ATTACKER);
        if (level.splitscreen) {
            util::setobjectivescoretext(game["attackers"], %OBJECTIVES_DEM_ATTACKER);
            util::setobjectivescoretext(game["defenders"], %OBJECTIVES_DEM_ATTACKER);
        } else {
            util::setobjectivescoretext(game["attackers"], %OBJECTIVES_DEM_ATTACKER_SCORE);
            util::setobjectivescoretext(game["defenders"], %OBJECTIVES_DEM_ATTACKER_SCORE);
        }
        util::setobjectivehinttext(game["attackers"], %OBJECTIVES_DEM_ATTACKER_OVERTIME_HINT);
        util::setobjectivehinttext(game["defenders"], %OBJECTIVES_DEM_ATTACKER_OVERTIME_HINT);
    } else {
        util::setobjectivetext(game["attackers"], %OBJECTIVES_DEM_ATTACKER);
        util::setobjectivetext(game["defenders"], %OBJECTIVES_SD_DEFENDER);
        if (level.splitscreen) {
            util::setobjectivescoretext(game["attackers"], %OBJECTIVES_DEM_ATTACKER);
            util::setobjectivescoretext(game["defenders"], %OBJECTIVES_SD_DEFENDER);
        } else {
            util::setobjectivescoretext(game["attackers"], %OBJECTIVES_DEM_ATTACKER_SCORE);
            util::setobjectivescoretext(game["defenders"], %OBJECTIVES_SD_DEFENDER_SCORE);
        }
        util::setobjectivehinttext(game["attackers"], %OBJECTIVES_DEM_ATTACKER_HINT);
        util::setobjectivehinttext(game["defenders"], %OBJECTIVES_SD_DEFENDER_HINT);
    }
    bombzones = getentarray(level.var_610b427e, "targetname");
    if (bombzones.size == 0) {
        level.var_610b427e = "bombzone";
    }
    spawning::create_map_placed_influencers();
    level.spawnmins = (0, 0, 0);
    level.spawnmaxs = (0, 0, 0);
    spawnlogic::drop_spawn_points("mp_dem_spawn_attacker_a");
    spawnlogic::drop_spawn_points("mp_dem_spawn_attacker_b");
    spawnlogic::drop_spawn_points("mp_dem_spawn_defender_a");
    spawnlogic::drop_spawn_points("mp_dem_spawn_defender_b");
    if (!isdefined(game["overtime_round"])) {
        spawnlogic::place_spawn_points("mp_dem_spawn_defender_start");
        spawnlogic::place_spawn_points("mp_dem_spawn_attacker_start");
    } else {
        spawnlogic::place_spawn_points("mp_dem_spawn_attackerot_start");
        spawnlogic::place_spawn_points("mp_dem_spawn_defenderot_start");
    }
    spawnlogic::add_spawn_points(game["attackers"], "mp_dem_spawn_attacker");
    spawnlogic::add_spawn_points(game["defenders"], "mp_dem_spawn_defender");
    if (!isdefined(game["overtime_round"])) {
        spawnlogic::add_spawn_points(game["defenders"], "mp_dem_spawn_defender_a");
        spawnlogic::add_spawn_points(game["defenders"], "mp_dem_spawn_defender_b");
        spawnlogic::add_spawn_points(game["attackers"], "mp_dem_spawn_attacker_remove_a");
        spawnlogic::add_spawn_points(game["attackers"], "mp_dem_spawn_attacker_remove_b");
    }
    spawning::add_fallback_spawnpoints(game["attackers"], "mp_tdm_spawn");
    spawning::add_fallback_spawnpoints(game["defenders"], "mp_tdm_spawn");
    spawning::updateallspawnpoints();
    spawning::update_fallback_spawnpoints();
    level.mapcenter = math::find_box_center(level.spawnmins, level.spawnmaxs);
    setmapcenter(level.mapcenter);
    spawnpoint = spawnlogic::get_random_intermission_point();
    setdemointermissionpoint(spawnpoint.origin, spawnpoint.angles);
    level.spawn_start = [];
    if (isdefined(game["overtime_round"])) {
        level.spawn_start["axis"] = spawnlogic::get_spawnpoint_array("mp_dem_spawn_defenderot_start");
        level.spawn_start["allies"] = spawnlogic::get_spawnpoint_array("mp_dem_spawn_attackerot_start");
    } else {
        level.spawn_start["axis"] = spawnlogic::get_spawnpoint_array("mp_dem_spawn_defender_start");
        level.spawn_start["allies"] = spawnlogic::get_spawnpoint_array("mp_dem_spawn_attacker_start");
    }
    thread updategametypedvars();
    thread bombs();
    if (isdefined(level.droppedtagrespawn) && level.droppedtagrespawn) {
        level.numlives = 1;
    }
}

// Namespace dem
// Params 1, eflags: 0x0
// Checksum 0x5e29c396, Offset: 0x1f38
// Size: 0x44
function onspawnplayer(predictedspawn) {
    self.isplanting = 0;
    self.isdefusing = 0;
    self.isbombcarrier = 0;
    spawning::onspawnplayer(predictedspawn);
}

// Namespace dem
// Params 0, eflags: 0x0
// Checksum 0x286e1e88, Offset: 0x1f88
// Size: 0x12
function function_51c48e40() {
    level notify(#"spawned_player");
}

// Namespace dem
// Params 9, eflags: 0x0
// Checksum 0xa8a316e6, Offset: 0x1fa8
// Size: 0x55c
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
            dist = distance2dsquared(self.origin, level.bombzones[index].curorigin);
            if (dist < level.defaultoffenseradiussq) {
                bombzone = level.bombzones[index];
                break;
            }
            dist = distance2dsquared(attacker.origin, level.bombzones[index].curorigin);
            if (dist < level.defaultoffenseradiussq) {
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
                attacker thread challenges::killedbasedefender(bombzone.trigger);
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
                attacker thread challenges::killedbaseoffender(bombzone.trigger, weapon);
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
// Checksum 0x73e3536c, Offset: 0x2510
// Size: 0x11c
function checkallowspectating() {
    self endon(#"disconnect");
    wait 0.05;
    update = 0;
    livesleft = !(level.numlives && !self.pers["lives"]);
    if (!level.alivecount[game["attackers"]] && !livesleft) {
        level.spectateoverride[game["attackers"]].allowenemyspectate = 1;
        update = 1;
    }
    if (!level.alivecount[game["defenders"]] && !livesleft) {
        level.spectateoverride[game["defenders"]].allowenemyspectate = 1;
        update = 1;
    }
    if (update) {
        spectating::update_settings();
    }
}

// Namespace dem
// Params 2, eflags: 0x0
// Checksum 0x8c0d7d10, Offset: 0x2638
// Size: 0xec
function function_3649f4f9(winningteam, endreasontext) {
    foreach (bombzone in level.bombzones) {
        bombzone gameobjects::set_visible_team("none");
    }
    if (isdefined(winningteam) && winningteam != "tie") {
        globallogic_score::giveteamscoreforobjective(winningteam, 1);
    }
    thread globallogic::endgame(winningteam, endreasontext);
}

// Namespace dem
// Params 1, eflags: 0x0
// Checksum 0x655e7268, Offset: 0x2730
// Size: 0x174
function ondeadevent(team) {
    if (level.bombexploded || level.bombdefused) {
        return;
    }
    if (team == "all") {
        if (level.bombplanted) {
            function_3649f4f9(game["attackers"], game["strings"][game["defenders"] + "_eliminated"]);
        } else {
            function_3649f4f9(game["defenders"], game["strings"][game["attackers"] + "_eliminated"]);
        }
        return;
    }
    if (team == game["attackers"]) {
        if (level.bombplanted) {
            return;
        }
        function_3649f4f9(game["defenders"], game["strings"][game["attackers"] + "_eliminated"]);
        return;
    }
    if (team == game["defenders"]) {
        function_3649f4f9(game["attackers"], game["strings"][game["defenders"] + "_eliminated"]);
    }
}

// Namespace dem
// Params 1, eflags: 0x0
// Checksum 0x418b1da2, Offset: 0x28b0
// Size: 0x3c
function ononeleftevent(team) {
    if (level.bombexploded || level.bombdefused) {
        return;
    }
    warnlastplayer(team);
}

// Namespace dem
// Params 0, eflags: 0x0
// Checksum 0x5914f7a9, Offset: 0x28f8
// Size: 0x17c
function ontimelimit() {
    if (isdefined(game["overtime_round"])) {
        function_3649f4f9("tie", game["strings"]["time_limit_reached"]);
        return;
    }
    if (level.teambased) {
        var_90259f7d = 0;
        for (index = 0; index < level.bombzones.size; index++) {
            if (!isdefined(level.bombzones[index].bombexploded) || !level.bombzones[index].bombexploded) {
                var_90259f7d++;
            }
        }
        if (var_90259f7d == 0) {
            function_3649f4f9(game["attackers"], game["strings"]["target_destroyed"]);
        } else {
            function_3649f4f9(game["defenders"], game["strings"]["time_limit_reached"]);
        }
        return;
    }
    function_3649f4f9("tie", game["strings"]["time_limit_reached"]);
}

// Namespace dem
// Params 1, eflags: 0x0
// Checksum 0xccb15c4e, Offset: 0x2a80
// Size: 0x15c
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
// Checksum 0x8814b12b, Offset: 0x2be8
// Size: 0xc4
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
// Checksum 0xd29935c3, Offset: 0x2cb8
// Size: 0x164
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
// Checksum 0x6af0092d, Offset: 0x2e28
// Size: 0x1f4
function resetbombzone() {
    if (isdefined(game["overtime_round"])) {
        self gameobjects::set_owner_team("neutral");
        self gameobjects::allow_use("any");
    } else {
        self gameobjects::allow_use("enemy");
    }
    self gameobjects::set_use_time(level.planttime);
    self gameobjects::set_use_text(%MP_PLANTING_EXPLOSIVE);
    self gameobjects::set_use_hint_text(%PLATFORM_HOLD_TO_PLANT_EXPLOSIVES);
    self gameobjects::set_key_object(level.var_f991e4e5);
    self gameobjects::set_2d_icon("friendly", "waypoint_defend" + self.label);
    self gameobjects::set_3d_icon("friendly", "waypoint_defend" + self.label);
    self gameobjects::set_2d_icon("enemy", "waypoint_target" + self.label);
    self gameobjects::set_3d_icon("enemy", "waypoint_target" + self.label);
    self gameobjects::set_visible_team("any");
    self.useweapon = getweapon("briefcase_bomb");
}

// Namespace dem
// Params 0, eflags: 0x0
// Checksum 0x164eaa84, Offset: 0x3028
// Size: 0x17c
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
// Checksum 0x47278ef9, Offset: 0x31b0
// Size: 0x992
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
    for (index = 0; index < bombzones.size; index++) {
        trigger = bombzones[index];
        scriptlabel = trigger.script_label;
        visuals = getentarray(bombzones[index].target, "targetname");
        var_8aad6fd = getentarray("bombzone_clip" + scriptlabel, "targetname");
        defusetrig = getent(visuals[0].target, "targetname");
        var_24380c14 = game["defenders"];
        var_7a23e8e4 = "enemy";
        if (isdefined(game["overtime_round"])) {
            if (scriptlabel != "_overtime") {
                trigger delete();
                defusetrig delete();
                visuals[0] delete();
                foreach (clip in var_8aad6fd) {
                    clip delete();
                }
                continue;
            }
            var_24380c14 = "neutral";
            var_7a23e8e4 = "any";
            scriptlabel = "_a";
        } else if (scriptlabel == "_overtime") {
            trigger delete();
            defusetrig delete();
            visuals[0] delete();
            foreach (clip in var_8aad6fd) {
                clip delete();
            }
            continue;
        }
        name = istring("dem" + scriptlabel);
        bombzone = gameobjects::create_use_object(var_24380c14, trigger, visuals, (0, 0, 0), name, 1, 1);
        bombzone gameobjects::allow_use(var_7a23e8e4);
        bombzone gameobjects::set_use_time(level.planttime);
        bombzone gameobjects::set_use_text(%MP_PLANTING_EXPLOSIVE);
        bombzone gameobjects::set_use_hint_text(%PLATFORM_HOLD_TO_PLANT_EXPLOSIVES);
        bombzone gameobjects::set_key_object(level.var_f991e4e5);
        bombzone.label = scriptlabel;
        bombzone.index = index;
        bombzone gameobjects::set_2d_icon("friendly", "compass_waypoint_defend" + scriptlabel);
        bombzone gameobjects::set_3d_icon("friendly", "waypoint_defend" + scriptlabel);
        bombzone gameobjects::set_2d_icon("enemy", "compass_waypoint_target" + scriptlabel);
        bombzone gameobjects::set_3d_icon("enemy", "waypoint_target" + scriptlabel);
        bombzone gameobjects::set_visible_team("any");
        bombzone.onbeginuse = &onbeginuse;
        bombzone.onenduse = &onenduse;
        bombzone.onuse = &function_3fa7f3e6;
        bombzone.oncantuse = &oncantuse;
        bombzone.useweapon = getweapon("briefcase_bomb");
        bombzone.visuals[0].killcament = spawn("script_model", bombzone.visuals[0].origin + (0, 0, 128));
        if (isdefined(level.bomb_zone_fixup)) {
            [[ level.bomb_zone_fixup ]](bombzone);
        }
        for (i = 0; i < visuals.size; i++) {
            if (isdefined(visuals[i].script_exploder)) {
                bombzone.exploderindex = visuals[i].script_exploder;
                break;
            }
        }
        foreach (visual in bombzone.visuals) {
            visual.team = "free";
        }
        level.bombzones[level.bombzones.size] = bombzone;
        bombzone.bombdefusetrig = defusetrig;
        assert(isdefined(bombzone.bombdefusetrig));
        bombzone.bombdefusetrig.origin += (0, 0, -10000);
        bombzone.bombdefusetrig.label = scriptlabel;
        team_mask = util::getteammask(game["attackers"]);
        bombzone.spawninfluencer = bombzone spawning::create_influencer("dem_enemy_base", trigger.origin, team_mask);
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
// Checksum 0x8b378748, Offset: 0x3b50
// Size: 0x9c
function setbomboverheatingafterweaponchange(useobject, overheated, heat) {
    self endon(#"death");
    self endon(#"disconnect");
    self endon(#"joined_team");
    self endon(#"joined_spectators");
    weapon = self waittill(#"weapon_change");
    if (weapon == useobject.useweapon) {
        self setweaponoverheating(overheated, heat, weapon);
    }
}

// Namespace dem
// Params 1, eflags: 0x0
// Checksum 0xd3e7e53d, Offset: 0x3bf8
// Size: 0x2e4
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
// Checksum 0xea84883a, Offset: 0x3ee8
// Size: 0xfc
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
// Checksum 0x4c1cb5b6, Offset: 0x3ff0
// Size: 0x2c
function oncantuse(player) {
    player iprintlnbold(%MP_CANT_PLANT_WITHOUT_BOMB);
}

// Namespace dem
// Params 1, eflags: 0x0
// Checksum 0x133d2c80, Offset: 0x4028
// Size: 0x514
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
// Checksum 0x3070a5c6, Offset: 0x4548
// Size: 0xec
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
    sound::play_on_players(game["bomb_dropped_sound"], game["attackers"]);
}

// Namespace dem
// Params 1, eflags: 0x0
// Checksum 0x3cdca151, Offset: 0x4640
// Size: 0x11c
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
    sound::play_on_players(game["bomb_recovered_sound"], game["attackers"]);
}

// Namespace dem
// Params 0, eflags: 0x0
// Checksum 0x99ec1590, Offset: 0x4768
// Size: 0x4
function onreset() {
    
}

// Namespace dem
// Params 2, eflags: 0x0
// Checksum 0xf2cbc5e7, Offset: 0x4778
// Size: 0xdc
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
// Checksum 0x511f4cf1, Offset: 0x4860
// Size: 0x25c
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
// Checksum 0xdc531f9f, Offset: 0x4ac8
// Size: 0xb44
function bombplanted(destroyedobj, player) {
    level endon(#"game_ended");
    destroyedobj endon(#"bomb_defused");
    team = player.team;
    game["challenge"][team]["plantedBomb"] = 1;
    globallogic_utils::pausetimer();
    destroyedobj.bombplanted = 1;
    player setweaponoverheating(1, 100, destroyedobj.useweapon);
    player playbombplant();
    destroyedobj.visuals[0] thread globallogic_utils::playtickingsound("mpl_sab_ui_suitcasebomb_timer");
    destroyedobj.tickingobject = destroyedobj.visuals[0];
    label = destroyedobj.label;
    detonatetime = int(gettime() + level.bombtimer * 1000);
    function_296d9a20(label, detonatetime);
    destroyedobj.detonatetime = detonatetime;
    trace = bullettrace(player.origin + (0, 0, 20), player.origin - (0, 0, 2000), 0, player);
    self dropbombmodel(player, destroyedobj.label);
    destroyedobj gameobjects::allow_use("none");
    destroyedobj gameobjects::set_visible_team("none");
    if (isdefined(game["overtime_round"])) {
        destroyedobj gameobjects::set_owner_team(util::getotherteam(player.team));
    }
    destroyedobj setupfordefusing();
    player.isbombcarrier = 0;
    game["challenge"][team]["plantedBomb"] = 1;
    destroyedobj function_c50057a0(label, level.bombtimer);
    destroyedobj function_cd724d52(label, "bomb_exploded");
    if (level.gameended) {
        return;
    }
    origin = (0, 0, 0);
    if (isdefined(player)) {
        origin = player.origin;
    }
    bbprint("mpobjective", "gametime %d objtype %s label %s team %s playerx %d playery %d playerz %d", gettime(), "dem_bombexplode", label, team, origin);
    destroyedobj.bombexploded = 1;
    game["challenge"][team]["destroyedBombSite"] = 1;
    explosionorigin = destroyedobj.curorigin;
    level.ddbombmodel[destroyedobj.label] delete();
    clips = getentarray("bombzone_clip" + destroyedobj.label, "targetname");
    foreach (clip in clips) {
        clip delete();
    }
    if (isdefined(player)) {
        destroyedobj.visuals[0] radiusdamage(explosionorigin, 512, -56, 20, player, "MOD_EXPLOSIVE", getweapon("briefcase_bomb"));
        level thread popups::displayteammessagetoall(%MP_EXPLOSIVES_BLOWUP_BY, player);
        if (player.team == team) {
            player addplayerstatwithgametype("DESTRUCTIONS", 1);
            player addplayerstatwithgametype("captures", 1);
            scoreevents::processscoreevent("bomb_detonated", player);
        }
        player recordgameevent("destroy");
    } else {
        destroyedobj.visuals[0] radiusdamage(explosionorigin, 512, -56, 20, undefined, "MOD_EXPLOSIVE", getweapon("briefcase_bomb"));
    }
    currenttime = gettime();
    if (isdefined(level.var_aee31363) && level.var_d7c2e234 == team) {
        if (level.var_aee31363 + 10000 > currenttime) {
            for (i = 0; i < level.players.size; i++) {
                if (level.players[i].team == team) {
                    level.players[i] challenges::bothbombsdetonatewithintime();
                }
            }
        }
    }
    level.var_aee31363 = currenttime;
    level.var_d7c2e234 = team;
    rot = randomfloat(360);
    explosioneffect = spawnfx(level._effect["bombexplosion"], explosionorigin + (0, 0, 50), (0, 0, 1), (cos(rot), sin(rot), 0));
    triggerfx(explosioneffect);
    thread sound::play_in_space("mpl_sd_exp_suitcase_bomb_main", explosionorigin);
    if (isdefined(destroyedobj.exploderindex)) {
        exploder::exploder(destroyedobj.exploderindex);
    }
    var_90259f7d = 0;
    for (index = 0; index < level.bombzones.size; index++) {
        if (!isdefined(level.bombzones[index].bombexploded) || !level.bombzones[index].bombexploded) {
            var_90259f7d++;
        }
    }
    destroyedobj gameobjects::disable_object();
    if (var_90259f7d == 0) {
        globallogic_utils::pausetimer();
        level.var_df6954d8 = 1;
        setgameendtime(0);
        wait 3;
        function_3649f4f9(team, game["strings"]["target_destroyed"]);
        return;
    }
    enemyteam = util::getotherteam(team);
    thread globallogic_audio::set_music_on_team("DEM_WE_SCORE", team, 5);
    thread globallogic_audio::set_music_on_team("DEM_THEY_SCORE", enemyteam, 5);
    if ([[ level.gettimelimit ]]() > 0) {
        level.usingextratime = 1;
    }
    destroyedobj spawning::remove_influencer(destroyedobj.spawninfluencer);
    destroyedobj.spawninfluencer = undefined;
    spawnlogic::clear_spawn_points();
    spawnlogic::add_spawn_points(game["attackers"], "mp_dem_spawn_attacker");
    spawnlogic::add_spawn_points(game["defenders"], "mp_dem_spawn_defender");
    if (label == "_a") {
        spawnlogic::add_spawn_points(game["attackers"], "mp_dem_spawn_attacker_remove_b");
        spawnlogic::add_spawn_points(game["attackers"], "mp_dem_spawn_attacker_a");
        spawnlogic::add_spawn_points(game["defenders"], "mp_dem_spawn_defender_b");
    } else {
        spawnlogic::add_spawn_points(game["attackers"], "mp_dem_spawn_attacker_remove_a");
        spawnlogic::add_spawn_points(game["attackers"], "mp_dem_spawn_attacker_b");
        spawnlogic::add_spawn_points(game["defenders"], "mp_dem_spawn_defender_a");
    }
    spawning::updateallspawnpoints();
}

// Namespace dem
// Params 0, eflags: 0x0
// Checksum 0x5d105980, Offset: 0x5618
// Size: 0x5a
function gettimelimit() {
    timelimit = globallogic_defaults::default_gettimelimit();
    if (isdefined(game["overtime_round"])) {
        timelimit = level.overtimetimelimit;
    }
    if (level.usingextratime) {
        return (timelimit + level.extratime);
    }
    return timelimit;
}

// Namespace dem
// Params 0, eflags: 0x0
// Checksum 0xcecc647e, Offset: 0x5680
// Size: 0x6e
function shouldplayovertimeround() {
    if (isdefined(game["overtime_round"])) {
        return false;
    }
    if (game["teamScores"]["allies"] == level.scorelimit - 1 && game["teamScores"]["axis"] == level.scorelimit - 1) {
        return true;
    }
    return false;
}

// Namespace dem
// Params 2, eflags: 0x0
// Checksum 0x37dbff0d, Offset: 0x56f8
// Size: 0x170
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
// Checksum 0x1a74af36, Offset: 0x5870
// Size: 0xdc
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
// Checksum 0x1830a104, Offset: 0x5958
// Size: 0xec
function bombdefused(player) {
    self.tickingobject globallogic_utils::stoptickingsound();
    self gameobjects::allow_use("none");
    self gameobjects::set_visible_team("none");
    self.bombdefused = 1;
    self notify(#"bomb_defused");
    self.bombplanted = 0;
    self function_cd724d52(self.label, "bomb_defused");
    player setweaponoverheating(1, 100, self.useweapon);
    player playbombdefuse();
}

// Namespace dem
// Params 2, eflags: 0x0
// Checksum 0x69217c5d, Offset: 0x5a50
// Size: 0x74
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
// Checksum 0x68df5ef0, Offset: 0x5ad0
// Size: 0xdc
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
// Checksum 0x7a76eb75, Offset: 0x5bb8
// Size: 0x64
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

