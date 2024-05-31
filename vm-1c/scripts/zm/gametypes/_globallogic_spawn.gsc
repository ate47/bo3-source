#using scripts/zm/_zm_perks;
#using scripts/zm/_util;
#using scripts/zm/gametypes/_spectating;
#using scripts/zm/gametypes/_spawnlogic;
#using scripts/zm/gametypes/_spawning;
#using scripts/zm/gametypes/_hostmigration;
#using scripts/zm/gametypes/_globallogic_utils;
#using scripts/zm/gametypes/_globallogic_ui;
#using scripts/zm/gametypes/_globallogic_score;
#using scripts/zm/gametypes/_globallogic_player;
#using scripts/zm/gametypes/_globallogic_defaults;
#using scripts/zm/gametypes/_globallogic_audio;
#using scripts/zm/gametypes/_globallogic;
#using scripts/shared/util_shared;
#using scripts/shared/hud_util_shared;
#using scripts/shared/hud_message_shared;
#using scripts/shared/flagsys_shared;
#using scripts/shared/callbacks_shared;
#using scripts/codescripts/struct;

#namespace globallogic_spawn;

// Namespace globallogic_spawn
// Params 0, eflags: 0x2
// namespace_7956eece<file_0>::function_c35e6aab
// Checksum 0xe463dd58, Offset: 0x630
// Size: 0x24
function autoexec init() {
    if (!isdefined(level.givestartloadout)) {
        level.givestartloadout = &givestartloadout;
    }
}

// Namespace globallogic_spawn
// Params 1, eflags: 0x1 linked
// namespace_7956eece<file_0>::function_cabdc9f7
// Checksum 0x8b584914, Offset: 0x660
// Size: 0x100
function timeuntilspawn(includeteamkilldelay) {
    if (level.ingraceperiod && !self.hasspawned) {
        return 0;
    }
    respawndelay = 0;
    if (self.hasspawned) {
        result = self [[ level.onrespawndelay ]]();
        if (isdefined(result)) {
            respawndelay = result;
        } else {
            respawndelay = level.playerrespawndelay;
        }
        if (isdefined(self.teamkillpunish) && includeteamkilldelay && self.teamkillpunish) {
            respawndelay += globallogic_player::teamkilldelay();
        }
    }
    wavebased = level.waverespawndelay > 0;
    if (wavebased) {
        return self timeuntilwavespawn(respawndelay);
    }
    return respawndelay;
}

// Namespace globallogic_spawn
// Params 0, eflags: 0x1 linked
// namespace_7956eece<file_0>::function_5881cfb8
// Checksum 0x62c76b8c, Offset: 0x768
// Size: 0x8e
function allteamshaveexisted() {
    foreach (team in level.teams) {
        if (!level.everexisted[team]) {
            return false;
        }
    }
    return true;
}

// Namespace globallogic_spawn
// Params 0, eflags: 0x1 linked
// namespace_7956eece<file_0>::function_cc406c51
// Checksum 0x89cf901c, Offset: 0x800
// Size: 0x148
function mayspawn() {
    if (isdefined(level.playermayspawn) && !self [[ level.playermayspawn ]]()) {
        return false;
    }
    if (level.inovertime) {
        return false;
    }
    if (level.playerqueuedrespawn && !isdefined(self.allowqueuespawn) && !level.ingraceperiod && !level.usestartspawns) {
        return false;
    }
    if (level.numlives) {
        if (level.teambased) {
            gamehasstarted = allteamshaveexisted();
        } else {
            gamehasstarted = !util::isoneround() && (level.maxplayercount > 1 || !util::isfirstround());
        }
        if (!self.pers["lives"] && gamehasstarted) {
            return false;
        } else if (gamehasstarted) {
            if (!level.ingraceperiod && !self.hasspawned && !level.wagermatch) {
                return false;
            }
        }
    }
    return true;
}

// Namespace globallogic_spawn
// Params 1, eflags: 0x1 linked
// namespace_7956eece<file_0>::function_febae56
// Checksum 0x3e010ef, Offset: 0x950
// Size: 0x122
function timeuntilwavespawn(minimumwait) {
    earliestspawntime = gettime() + minimumwait * 1000;
    lastwavetime = level.lastwave[self.pers["team"]];
    wavedelay = level.wavedelay[self.pers["team"]] * 1000;
    if (wavedelay == 0) {
        return 0;
    }
    numwavespassedearliestspawntime = (earliestspawntime - lastwavetime) / wavedelay;
    numwaves = ceil(numwavespassedearliestspawntime);
    timeofspawn = lastwavetime + numwaves * wavedelay;
    if (isdefined(self.wavespawnindex)) {
        timeofspawn += 50 * self.wavespawnindex;
    }
    return (timeofspawn - gettime()) / 1000;
}

// Namespace globallogic_spawn
// Params 0, eflags: 0x1 linked
// namespace_7956eece<file_0>::function_dbb50216
// Checksum 0x3d0c9e1, Offset: 0xa80
// Size: 0x3c
function stoppoisoningandflareonspawn() {
    self endon(#"disconnect");
    self.inpoisonarea = 0;
    self.inburnarea = 0;
    self.inflarevisionarea = 0;
    self.ingroundnapalm = 0;
}

// Namespace globallogic_spawn
// Params 0, eflags: 0x1 linked
// namespace_7956eece<file_0>::function_f868991e
// Checksum 0x904a888f, Offset: 0xac8
// Size: 0xb0
function spawnplayerprediction() {
    self endon(#"disconnect");
    self endon(#"end_respawn");
    self endon(#"game_ended");
    self endon(#"joined_spectators");
    self endon(#"spawned");
    while (true) {
        wait(0.5);
        if (isdefined(level.onspawnplayerunified) && getdvarint("scr_disableunifiedspawning") == 0) {
            spawning::onspawnplayer_unified(1);
            continue;
        }
        self [[ level.onspawnplayer ]](1);
    }
}

// Namespace globallogic_spawn
// Params 2, eflags: 0x1 linked
// namespace_7956eece<file_0>::function_5edb1868
// Checksum 0xd4dd4d69, Offset: 0xb80
// Size: 0xac
function giveloadoutlevelspecific(team, _class) {
    pixbeginevent("giveLoadoutLevelSpecific");
    if (isdefined(level.givecustomcharacters)) {
        self [[ level.givecustomcharacters ]]();
    }
    if (isdefined(level.givestartloadout)) {
        self [[ level.givestartloadout ]]();
    }
    self flagsys::set("loadout_given");
    callback::callback(#"hash_33bba039");
    pixendevent();
}

// Namespace globallogic_spawn
// Params 0, eflags: 0x1 linked
// namespace_7956eece<file_0>::function_68917156
// Checksum 0x53bdb948, Offset: 0xc38
// Size: 0x20
function givestartloadout() {
    if (isdefined(level.givecustomloadout)) {
        self [[ level.givecustomloadout ]]();
    }
}

// Namespace globallogic_spawn
// Params 0, eflags: 0x1 linked
// namespace_7956eece<file_0>::function_1fee8319
// Checksum 0x9a5031f2, Offset: 0xc60
// Size: 0xd04
function spawnplayer() {
    pixbeginevent("spawnPlayer_preUTS");
    self endon(#"disconnect");
    self endon(#"joined_spectators");
    self notify(#"spawned");
    level notify(#"player_spawned");
    self notify(#"end_respawn");
    self setspawnvariables();
    self luinotifyevent(%player_spawned, 0);
    if (!self.hasspawned) {
        self.underscorechance = 70;
        self thread globallogic_audio::function_2a897a84();
    }
    self.sessionteam = self.team;
    hadspawned = self.hasspawned;
    self.sessionstate = "playing";
    self.spectatorclient = -1;
    self.killcamentity = -1;
    self.archivetime = 0;
    self.psoffsettime = 0;
    self.statusicon = "";
    self.damagedplayers = [];
    if (getdvarint("scr_csmode") > 0) {
        self.maxhealth = getdvarint("scr_csmode");
    } else {
        self.maxhealth = level.playermaxhealth;
    }
    self.health = self.maxhealth;
    self.friendlydamage = undefined;
    self.hasspawned = 1;
    self.spawntime = gettime();
    self.afk = 0;
    if (!isdefined(level.takelivesondeath) || self.pers["lives"] && level.takelivesondeath == 0) {
        self.pers["lives"]--;
        if (self.pers["lives"] == 0) {
            level notify(#"player_eliminated");
            self notify(#"player_eliminated");
        }
    }
    self.laststand = undefined;
    self.revivingteammate = 0;
    self.burning = undefined;
    self.nextkillstreakfree = undefined;
    self.activeuavs = 0;
    self.activecounteruavs = 0;
    self.activesatellites = 0;
    self.deathmachinekills = 0;
    self.disabledweapon = 0;
    self util::resetusability();
    self globallogic_player::resetattackerlist();
    self.diedonvehicle = undefined;
    if (!self.wasaliveatmatchstart) {
        if (level.ingraceperiod || globallogic_utils::gettimepassed() < 20000) {
            self.wasaliveatmatchstart = 1;
        }
    }
    self setdepthoffield(0, 0, 512, 512, 4, 0);
    self resetfov();
    pixbeginevent("onSpawnPlayer");
    if (isdefined(level.onspawnplayerunified) && getdvarint("scr_disableunifiedspawning") == 0) {
        self [[ level.onspawnplayerunified ]]();
    } else {
        self [[ level.onspawnplayer ]](0);
    }
    if (isdefined(level.playerspawnedcb)) {
        self [[ level.playerspawnedcb ]]();
    }
    pixendevent();
    pixendevent();
    level thread globallogic::updateteamstatus();
    pixbeginevent("spawnPlayer_postUTS");
    self thread stoppoisoningandflareonspawn();
    assert(globallogic_utils::isvalidclass(self.curclass));
    self giveloadoutlevelspecific(self.team, self.curclass);
    if (level.inprematchperiod) {
        self util::freeze_player_controls(1);
        team = self.pers["team"];
        if (isdefined(self.pers["music"].spawn) && self.pers["music"].spawn == 0) {
            if (level.wagermatch) {
                music = "SPAWN_WAGER";
            } else {
                music = game["music"]["spawn_" + team];
            }
            self thread globallogic_audio::set_music_on_player(music, 0, 0);
            self.pers["music"].spawn = 1;
        }
        if (level.splitscreen) {
            if (isdefined(level.playedstartingmusic)) {
                music = undefined;
            } else {
                level.playedstartingmusic = 1;
            }
        }
        if (!isdefined(level.var_29d9f951) || level.var_29d9f951 == 0) {
            thread hud_message::function_c0025cfc(team);
            hintmessage = util::getobjectivehinttext(self.pers["team"]);
            if (isdefined(hintmessage)) {
                self thread hud_message::hintmessage(hintmessage);
            }
            if (!level.splitscreen || isdefined(game["dialog"]["gametype"]) && self == level.players[0]) {
                if (!isdefined(level.var_e8b0a4fe) || !level.var_e8b0a4fe) {
                    if (level.hardcoremode) {
                        self globallogic_audio::leaderdialogonplayer("gametype_hardcore");
                    } else {
                        self globallogic_audio::leaderdialogonplayer("gametype");
                    }
                }
            }
            if (team == game["attackers"]) {
                self globallogic_audio::leaderdialogonplayer("offense_obj", "introboost");
            } else {
                self globallogic_audio::leaderdialogonplayer("defense_obj", "introboost");
            }
        }
    } else {
        self util::freeze_player_controls(0);
        self enableweapons();
        if (!hadspawned && game["state"] == "playing") {
            pixbeginevent("sound");
            team = self.team;
            if (isdefined(self.pers["music"].spawn) && self.pers["music"].spawn == 0) {
                self thread globallogic_audio::set_music_on_player("SPAWN_SHORT", 0, 0);
                self.pers["music"].spawn = 1;
            }
            if (level.splitscreen) {
                if (isdefined(level.playedstartingmusic)) {
                    music = undefined;
                } else {
                    level.playedstartingmusic = 1;
                }
            }
            if (!isdefined(level.var_29d9f951) || level.var_29d9f951 == 0) {
                thread hud_message::function_c0025cfc(team);
                hintmessage = util::getobjectivehinttext(self.pers["team"]);
                if (isdefined(hintmessage)) {
                    self thread hud_message::hintmessage(hintmessage);
                }
                if (!level.splitscreen || isdefined(game["dialog"]["gametype"]) && self == level.players[0]) {
                    if (!isdefined(level.var_e8b0a4fe) || !level.var_e8b0a4fe) {
                        if (level.hardcoremode) {
                            self globallogic_audio::leaderdialogonplayer("gametype_hardcore");
                        } else {
                            self globallogic_audio::leaderdialogonplayer("gametype");
                        }
                    }
                }
                if (team == game["attackers"]) {
                    self globallogic_audio::leaderdialogonplayer("offense_obj", "introboost");
                } else {
                    self globallogic_audio::leaderdialogonplayer("defense_obj", "introboost");
                }
            }
            pixendevent();
        }
    }
    if (getdvarstring("scr_showperksonspawn") == "") {
        setdvar("scr_showperksonspawn", "0");
    }
    if (level.hardcoremode) {
        setdvar("scr_showperksonspawn", "0");
    }
    if (!level.splitscreen && getdvarint("scr_showperksonspawn") == 1 && game["state"] != "postgame") {
        pixbeginevent("showperksonspawn");
        if (level.perksenabled == 1) {
            self hud::showperks();
        }
        pixendevent();
    }
    if (isdefined(self.pers["momentum"])) {
        self.momentum = self.pers["momentum"];
    }
    pixendevent();
    waittillframeend();
    self notify(#"spawned_player");
    self callback::callback(#"hash_bc12b61f");
    /#
        print("" + self.origin[0] + "" + self.origin[1] + "" + self.origin[2] + "");
    #/
    setdvar("scr_selecting_location", "");
    /#
        if (getdvarint("") > 0) {
            self thread globallogic_score::function_4e01d1c3();
        }
    #/
    self zm_perks::function_78f42790("health_reboot", 1, 0);
    if (game["state"] == "postgame") {
        assert(!level.intermission);
        self globallogic_player::freezeplayerforroundend();
    }
    self util::set_lighting_state();
    self util::set_sun_shadow_split_distance();
}

// Namespace globallogic_spawn
// Params 2, eflags: 0x1 linked
// namespace_7956eece<file_0>::function_dedbb7c9
// Checksum 0xa40386fc, Offset: 0x1970
// Size: 0x4c
function spawnspectator(origin, angles) {
    self notify(#"spawned");
    self notify(#"end_respawn");
    in_spawnspectator(origin, angles);
}

// Namespace globallogic_spawn
// Params 2, eflags: 0x1 linked
// namespace_7956eece<file_0>::function_a1bf9b89
// Checksum 0xe46c158f, Offset: 0x19c8
// Size: 0x2c
function respawn_asspectator(origin, angles) {
    in_spawnspectator(origin, angles);
}

// Namespace globallogic_spawn
// Params 2, eflags: 0x1 linked
// namespace_7956eece<file_0>::function_2e650f63
// Checksum 0xc127fe95, Offset: 0x1a00
// Size: 0x18c
function in_spawnspectator(origin, angles) {
    pixmarker("BEGIN: in_spawnSpectator");
    self setspawnvariables();
    if (self.pers["team"] == "spectator") {
        self util::clearlowermessage();
    }
    self.sessionstate = "spectator";
    self.spectatorclient = -1;
    self.killcamentity = -1;
    self.archivetime = 0;
    self.psoffsettime = 0;
    self.friendlydamage = undefined;
    if (self.pers["team"] == "spectator") {
        self.statusicon = "";
    } else {
        self.statusicon = "hud_status_dead";
    }
    spectating::setspectatepermissionsformachine();
    [[ level.onspawnspectator ]](origin, angles);
    if (level.teambased && !level.splitscreen) {
        self thread spectatorthirdpersonness();
    }
    level thread globallogic::updateteamstatus();
    pixmarker("END: in_spawnSpectator");
}

// Namespace globallogic_spawn
// Params 0, eflags: 0x1 linked
// namespace_7956eece<file_0>::function_29cfb1d
// Checksum 0x74f3659c, Offset: 0x1b98
// Size: 0x3c
function spectatorthirdpersonness() {
    self endon(#"disconnect");
    self endon(#"spawned");
    self notify(#"spectator_thirdperson_thread");
    self endon(#"spectator_thirdperson_thread");
    self.spectatingthirdperson = 0;
}

// Namespace globallogic_spawn
// Params 1, eflags: 0x0
// namespace_7956eece<file_0>::function_7431d193
// Checksum 0x34827141, Offset: 0x1be0
// Size: 0xf4
function forcespawn(time) {
    self endon(#"death");
    self endon(#"disconnect");
    self endon(#"spawned");
    if (!isdefined(time)) {
        time = 60;
    }
    wait(time);
    if (self.hasspawned) {
        return;
    }
    if (self.pers["team"] == "spectator") {
        return;
    }
    if (!globallogic_utils::isvalidclass(self.pers["class"])) {
        self.pers["class"] = "CLASS_CUSTOM1";
        self.curclass = self.pers["class"];
    }
    self globallogic_ui::closemenus();
    self thread [[ level.spawnclient ]]();
}

// Namespace globallogic_spawn
// Params 0, eflags: 0x1 linked
// namespace_7956eece<file_0>::function_a418f7cc
// Checksum 0xd6461eaf, Offset: 0x1ce0
// Size: 0x5c
function kickifdontspawn() {
    /#
        if (getdvarint("") == 1) {
            return;
        }
    #/
    if (self ishost()) {
        return;
    }
    self kickifidontspawninternal();
}

// Namespace globallogic_spawn
// Params 0, eflags: 0x1 linked
// namespace_7956eece<file_0>::function_e0811328
// Checksum 0x6db59fcb, Offset: 0x1d48
// Size: 0x1a4
function kickifidontspawninternal() {
    self endon(#"death");
    self endon(#"disconnect");
    self endon(#"spawned");
    waittime = 90;
    if (getdvarstring("scr_kick_time") != "") {
        waittime = getdvarfloat("scr_kick_time");
    }
    mintime = 45;
    if (getdvarstring("scr_kick_mintime") != "") {
        mintime = getdvarfloat("scr_kick_mintime");
    }
    starttime = gettime();
    kickwait(waittime);
    timepassed = (gettime() - starttime) / 1000;
    if (timepassed < waittime - 0.1 && timepassed < mintime) {
        return;
    }
    if (self.hasspawned) {
        return;
    }
    if (sessionmodeisprivate()) {
        return;
    }
    if (self.pers["team"] == "spectator") {
        return;
    }
    kick(self getentitynumber());
}

// Namespace globallogic_spawn
// Params 1, eflags: 0x1 linked
// namespace_7956eece<file_0>::function_58062728
// Checksum 0x89964bf0, Offset: 0x1ef8
// Size: 0x2c
function kickwait(waittime) {
    level endon(#"game_ended");
    hostmigration::waitlongdurationwithhostmigrationpause(waittime);
}

// Namespace globallogic_spawn
// Params 0, eflags: 0x0
// namespace_7956eece<file_0>::function_f4876f2c
// Checksum 0xea4083b3, Offset: 0x1f30
// Size: 0x134
function spawninterroundintermission() {
    self notify(#"spawned");
    self notify(#"end_respawn");
    self setspawnvariables();
    self util::clearlowermessage();
    self util::freeze_player_controls(0);
    self.sessionstate = "spectator";
    self.spectatorclient = -1;
    self.killcamentity = -1;
    self.archivetime = 0;
    self.psoffsettime = 0;
    self.friendlydamage = undefined;
    self globallogic_defaults::default_onspawnintermission();
    self setorigin(self.origin);
    self setplayerangles(self.angles);
    self setdepthoffield(0, -128, 512, 4000, 6, 1.8);
}

// Namespace globallogic_spawn
// Params 1, eflags: 0x1 linked
// namespace_7956eece<file_0>::function_8d9835ba
// Checksum 0x342bd89a, Offset: 0x2070
// Size: 0x234
function spawnintermission(usedefaultcallback) {
    self notify(#"spawned");
    self notify(#"end_respawn");
    self endon(#"disconnect");
    self setspawnvariables();
    self util::clearlowermessage();
    self util::freeze_player_controls(0);
    if (level.rankedmatch && util::waslastround()) {
        if (self.postgamemilestones || self.postgamecontracts || self.postgamepromotion) {
            if (self.postgamepromotion) {
                self playlocalsound("mus_level_up");
            } else if (self.postgamecontracts) {
                self playlocalsound("mus_challenge_complete");
            } else if (self.postgamemilestones) {
                self playlocalsound("mus_contract_complete");
            }
            self closeingamemenu();
            for (waittime = 4; waittime; waittime -= 0.25) {
                wait(0.25);
            }
        }
    }
    self.sessionstate = "intermission";
    self.spectatorclient = -1;
    self.killcamentity = -1;
    self.archivetime = 0;
    self.psoffsettime = 0;
    self.friendlydamage = undefined;
    if (isdefined(usedefaultcallback) && usedefaultcallback) {
        globallogic_defaults::default_onspawnintermission();
    } else {
        [[ level.onspawnintermission ]]();
    }
    self setdepthoffield(0, -128, 512, 4000, 6, 1.8);
}

// Namespace globallogic_spawn
// Params 1, eflags: 0x1 linked
// namespace_7956eece<file_0>::function_20ddc4c4
// Checksum 0x5f6b1916, Offset: 0x22b0
// Size: 0xd8
function spawnqueuedclientonteam(team) {
    player_to_spawn = undefined;
    for (i = 0; i < level.deadplayers[team].size; i++) {
        player = level.deadplayers[team][i];
        if (player.waitingtospawn) {
            continue;
        }
        player_to_spawn = player;
        break;
    }
    if (isdefined(player_to_spawn)) {
        player_to_spawn.allowqueuespawn = 1;
        player_to_spawn globallogic_ui::closemenus();
        player_to_spawn thread [[ level.spawnclient ]]();
    }
}

// Namespace globallogic_spawn
// Params 2, eflags: 0x1 linked
// namespace_7956eece<file_0>::function_dcb186d4
// Checksum 0x1658c3cb, Offset: 0x2390
// Size: 0x152
function spawnqueuedclient(dead_player_team, killer) {
    if (!level.playerqueuedrespawn) {
        return;
    }
    util::waittillslowprocessallowed();
    spawn_team = undefined;
    if (isdefined(killer) && isdefined(killer.team) && isdefined(level.teams[killer.team])) {
        spawn_team = killer.team;
    }
    if (isdefined(spawn_team)) {
        spawnqueuedclientonteam(spawn_team);
        return;
    }
    foreach (team in level.teams) {
        if (team == dead_player_team) {
            continue;
        }
        spawnqueuedclientonteam(team);
    }
}

// Namespace globallogic_spawn
// Params 0, eflags: 0x1 linked
// namespace_7956eece<file_0>::function_a021ee79
// Checksum 0x35aae151, Offset: 0x24f0
// Size: 0xc4
function allteamsnearscorelimit() {
    if (!level.teambased) {
        return false;
    }
    if (level.scorelimit <= 1) {
        return false;
    }
    foreach (team in level.teams) {
        if (!(game["teamScores"][team] >= level.scorelimit - 1)) {
            return false;
        }
    }
    return true;
}

// Namespace globallogic_spawn
// Params 0, eflags: 0x1 linked
// namespace_7956eece<file_0>::function_59cc7caa
// Checksum 0x12349506, Offset: 0x25c0
// Size: 0x6e
function shouldshowrespawnmessage() {
    if (util::waslastround()) {
        return false;
    }
    if (util::isoneround()) {
        return false;
    }
    if (isdefined(level.livesdonotreset) && level.livesdonotreset) {
        return false;
    }
    if (allteamsnearscorelimit()) {
        return false;
    }
    return true;
}

// Namespace globallogic_spawn
// Params 0, eflags: 0x1 linked
// namespace_7956eece<file_0>::function_f16225d
// Checksum 0x173d0a98, Offset: 0x2638
// Size: 0x44
function default_spawnmessage() {
    util::setlowermessage(game["strings"]["spawn_next_round"]);
    self thread globallogic_ui::removespawnmessageshortly(3);
}

// Namespace globallogic_spawn
// Params 0, eflags: 0x1 linked
// namespace_7956eece<file_0>::function_a559a720
// Checksum 0x6049ee38, Offset: 0x2688
// Size: 0x28
function showspawnmessage() {
    if (shouldshowrespawnmessage()) {
        self thread [[ level.spawnmessage ]]();
    }
}

// Namespace globallogic_spawn
// Params 1, eflags: 0x1 linked
// namespace_7956eece<file_0>::function_f3db290b
// Checksum 0xa00a5955, Offset: 0x26b8
// Size: 0x17c
function spawnclient(timealreadypassed) {
    pixbeginevent("spawnClient");
    assert(isdefined(self.team));
    assert(globallogic_utils::isvalidclass(self.curclass));
    if (!self mayspawn()) {
        currentorigin = self.origin;
        currentangles = self.angles;
        self showspawnmessage();
        self thread [[ level.spawnspectator ]](currentorigin + (0, 0, 60), currentangles);
        pixendevent();
        return;
    }
    if (self.waitingtospawn) {
        pixendevent();
        return;
    }
    self.waitingtospawn = 1;
    self.allowqueuespawn = undefined;
    self waitandspawnclient(timealreadypassed);
    if (isdefined(self)) {
        self.waitingtospawn = 0;
    }
    pixendevent();
}

// Namespace globallogic_spawn
// Params 1, eflags: 0x1 linked
// namespace_7956eece<file_0>::function_8deb5b1b
// Checksum 0xdce61b95, Offset: 0x2840
// Size: 0x4d8
function waitandspawnclient(timealreadypassed) {
    self endon(#"disconnect");
    self endon(#"end_respawn");
    level endon(#"game_ended");
    if (!isdefined(timealreadypassed)) {
        timealreadypassed = 0;
    }
    spawnedasspectator = 0;
    if (isdefined(self.teamkillpunish) && self.teamkillpunish) {
        teamkilldelay = globallogic_player::teamkilldelay();
        if (teamkilldelay > timealreadypassed) {
            teamkilldelay -= timealreadypassed;
            timealreadypassed = 0;
        } else {
            timealreadypassed -= teamkilldelay;
            teamkilldelay = 0;
        }
        if (teamkilldelay > 0) {
            util::setlowermessage(%MP_FRIENDLY_FIRE_WILL_NOT, teamkilldelay);
            self thread respawn_asspectator(self.origin + (0, 0, 60), self.angles);
            spawnedasspectator = 1;
            wait(teamkilldelay);
        }
        self.teamkillpunish = 0;
    }
    if (!isdefined(self.wavespawnindex) && isdefined(level.waveplayerspawnindex[self.team])) {
        self.wavespawnindex = level.waveplayerspawnindex[self.team];
        level.waveplayerspawnindex[self.team]++;
    }
    timeuntilspawn = timeuntilspawn(0);
    if (timeuntilspawn > timealreadypassed) {
        timeuntilspawn -= timealreadypassed;
        timealreadypassed = 0;
    } else {
        timealreadypassed -= timeuntilspawn;
        timeuntilspawn = 0;
    }
    if (timeuntilspawn > 0) {
        if (level.playerqueuedrespawn) {
            util::setlowermessage(game["strings"]["you_will_spawn"], timeuntilspawn);
        } else if (self issplitscreen()) {
            util::setlowermessage(game["strings"]["waiting_to_spawn_ss"], timeuntilspawn, 1);
        } else {
            util::setlowermessage(game["strings"]["waiting_to_spawn"], timeuntilspawn);
        }
        if (!spawnedasspectator) {
            spawnorigin = self.origin + (0, 0, 60);
            spawnangles = self.angles;
            if (isdefined(level.useintermissionpointsonwavespawn) && [[ level.useintermissionpointsonwavespawn ]]() == 1) {
                spawnpoint = spawnlogic::getrandomintermissionpoint();
                if (isdefined(spawnpoint)) {
                    spawnorigin = spawnpoint.origin;
                    spawnangles = spawnpoint.angles;
                }
            }
            self thread respawn_asspectator(spawnorigin, spawnangles);
        }
        spawnedasspectator = 1;
        self globallogic_utils::waitfortimeornotify(timeuntilspawn, "force_spawn");
        self notify(#"stop_wait_safe_spawn_button");
    }
    wavebased = level.waverespawndelay > 0;
    if (!level.playerforcerespawn && self.hasspawned && !wavebased && !self.wantsafespawn && !level.playerqueuedrespawn) {
        util::setlowermessage(game["strings"]["press_to_spawn"]);
        if (!spawnedasspectator) {
            self thread respawn_asspectator(self.origin + (0, 0, 60), self.angles);
        }
        spawnedasspectator = 1;
        self waitrespawnorsafespawnbutton();
    }
    self.waitingtospawn = 0;
    self util::clearlowermessage();
    self.wavespawnindex = undefined;
    self.respawntimerstarttime = undefined;
    self thread [[ level.spawnplayer ]]();
}

// Namespace globallogic_spawn
// Params 0, eflags: 0x1 linked
// namespace_7956eece<file_0>::function_8192db4b
// Checksum 0x1a065c5e, Offset: 0x2d20
// Size: 0x48
function waitrespawnorsafespawnbutton() {
    self endon(#"disconnect");
    self endon(#"end_respawn");
    while (true) {
        if (self usebuttonpressed()) {
            break;
        }
        wait(0.05);
    }
}

// Namespace globallogic_spawn
// Params 0, eflags: 0x0
// namespace_7956eece<file_0>::function_a90f3701
// Checksum 0xbb0d37e4, Offset: 0x2d70
// Size: 0x90
function waitinspawnqueue() {
    self endon(#"disconnect");
    self endon(#"end_respawn");
    if (!level.ingraceperiod && !level.usestartspawns) {
        currentorigin = self.origin;
        currentangles = self.angles;
        self thread [[ level.spawnspectator ]](currentorigin + (0, 0, 60), currentangles);
        self waittill(#"queue_respawn");
    }
}

// Namespace globallogic_spawn
// Params 1, eflags: 0x0
// namespace_7956eece<file_0>::function_dc6304e9
// Checksum 0x63226b07, Offset: 0x2e08
// Size: 0xec
function setthirdperson(value) {
    if (!level.console) {
        return;
    }
    if (!isdefined(self.spectatingthirdperson) || value != self.spectatingthirdperson) {
        self.spectatingthirdperson = value;
        if (value) {
            self setclientthirdperson(1);
            self setdepthoffield(0, -128, 512, 4000, 6, 1.8);
        } else {
            self setclientthirdperson(0);
            self setdepthoffield(0, 0, 512, 4000, 4, 0);
        }
        self resetfov();
    }
}

// Namespace globallogic_spawn
// Params 0, eflags: 0x1 linked
// namespace_7956eece<file_0>::function_830143f3
// Checksum 0xbe93185a, Offset: 0x2f00
// Size: 0x4c
function setspawnvariables() {
    resettimeout();
    self stopshellshock();
    self stoprumble("damage_heavy");
}

