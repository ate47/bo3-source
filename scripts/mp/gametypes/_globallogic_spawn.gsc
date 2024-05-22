#using scripts/mp/_teamops;
#using scripts/mp/killstreaks/_killstreaks;
#using scripts/mp/bots/_bot;
#using scripts/mp/_vehicle;
#using scripts/mp/_util;
#using scripts/mp/gametypes/_spectating;
#using scripts/mp/gametypes/_spawnlogic;
#using scripts/mp/gametypes/_spawning;
#using scripts/mp/gametypes/_loadout;
#using scripts/mp/gametypes/_hud_message;
#using scripts/mp/gametypes/_hostmigration;
#using scripts/mp/gametypes/_globallogic_utils;
#using scripts/mp/gametypes/_globallogic_ui;
#using scripts/mp/gametypes/_globallogic_score;
#using scripts/mp/gametypes/_globallogic_player;
#using scripts/mp/gametypes/_globallogic_defaults;
#using scripts/mp/gametypes/_globallogic_audio;
#using scripts/mp/gametypes/_globallogic;
#using scripts/mp/gametypes/_battlechatter;
#using scripts/shared/clientfield_shared;
#using scripts/shared/util_shared;
#using scripts/shared/hud_util_shared;
#using scripts/shared/hud_message_shared;
#using scripts/shared/hostmigration_shared;
#using scripts/shared/flagsys_shared;
#using scripts/shared/callbacks_shared;

#namespace globallogic_spawn;

// Namespace globallogic_spawn
// Params 1, eflags: 0x1 linked
// Checksum 0x4be705e5, Offset: 0x760
// Size: 0x1c2
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
        if (isdefined(level.playerincrementalrespawndelay) && isdefined(self.pers["spawns"])) {
            respawndelay += level.playerincrementalrespawndelay * self.pers["spawns"];
        }
        if (self.suicide && level.suicidespawndelay > 0) {
            respawndelay += level.suicidespawndelay;
        }
        if (self.teamkilled && level.teamkilledspawndelay > 0) {
            respawndelay += level.teamkilledspawndelay;
        }
        if (isdefined(self.teamkillpunish) && includeteamkilldelay && self.teamkillpunish) {
            respawndelay += globallogic_player::teamkilldelay();
        }
    }
    wavebased = level.waverespawndelay > 0;
    if (wavebased) {
        return self timeuntilwavespawn(respawndelay);
    }
    if (isdefined(self.usedresurrect) && self.usedresurrect) {
        return 0;
    }
    return respawndelay;
}

// Namespace globallogic_spawn
// Params 0, eflags: 0x1 linked
// Checksum 0x133ed8d, Offset: 0x930
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
// Checksum 0xd1637ea9, Offset: 0x9c8
// Size: 0x19c
function mayspawn() {
    if (isdefined(level.mayspawn) && !self [[ level.mayspawn ]]()) {
        return 0;
    }
    if (isdefined(level.var_4fb47492)) {
        return self [[ level.var_4fb47492 ]]();
    }
    if (level.inovertime) {
        return 0;
    }
    if (level.playerqueuedrespawn && !isdefined(self.allowqueuespawn) && !level.ingraceperiod && !level.usestartspawns) {
        return 0;
    }
    if (level.numlives || level.numteamlives) {
        if (level.teambased) {
            gamehasstarted = allteamshaveexisted();
        } else {
            gamehasstarted = !util::isoneround() && (level.maxplayercount > 1 || !util::isfirstround());
        }
        if (level.numteamlives && (level.numlives && !self.pers["lives"] || !game[self.team + "_lives"])) {
            return 0;
        } else if (gamehasstarted) {
            if (!level.ingraceperiod && !self.hasspawned && !level.wagermatch) {
                return 0;
            }
        }
    }
    return 1;
}

// Namespace globallogic_spawn
// Params 1, eflags: 0x1 linked
// Checksum 0x3fc3c25b, Offset: 0xb70
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
// Checksum 0x8602131f, Offset: 0xca0
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
// Checksum 0x5c62abe8, Offset: 0xce8
// Size: 0xc8
function spawnplayerprediction() {
    self endon(#"disconnect");
    self endon(#"end_respawn");
    self endon(#"game_ended");
    self endon(#"joined_spectators");
    self endon(#"spawned");
    livesleft = !(level.numlives && !self.pers["lives"]) && !(level.numteamlives && !game[self.team + "_lives"]);
    if (!livesleft) {
        return;
    }
    while (true) {
        wait(0.5);
        spawning::onspawnplayer(1);
    }
}

// Namespace globallogic_spawn
// Params 0, eflags: 0x1 linked
// Checksum 0x5be20e89, Offset: 0xdb8
// Size: 0x1b4
function doinitialspawnmessaging() {
    self endon(#"disconnect");
    self.playleaderdialog = 1;
    if (isdefined(level.var_29d9f951) && level.var_29d9f951) {
        return;
    }
    team = self.pers["team"];
    thread hud_message::function_c0025cfc(team);
    while (level.inprematchperiod) {
        wait(0.05);
    }
    hintmessage = util::getobjectivehinttext(team);
    if (isdefined(hintmessage)) {
        self luinotifyevent(%show_gametype_objective_hint, 1, hintmessage);
    }
    if (isdefined(level.leaderdialog)) {
        if (self.pers["playedGameMode"] !== 1) {
            if (level.hardcoremode) {
                self globallogic_audio::leader_dialog_on_player(level.leaderdialog.starthcgamedialog);
            } else {
                self globallogic_audio::leader_dialog_on_player(level.leaderdialog.startgamedialog);
            }
        }
        if (team == game["attackers"]) {
            self globallogic_audio::leader_dialog_on_player(level.leaderdialog.offenseorderdialog);
            return;
        }
        self globallogic_audio::leader_dialog_on_player(level.leaderdialog.defenseorderdialog);
    }
}

// Namespace globallogic_spawn
// Params 0, eflags: 0x1 linked
// Checksum 0x4a7c6038, Offset: 0xf78
// Size: 0xe4c
function spawnplayer() {
    pixbeginevent("spawnPlayer_preUTS");
    self endon(#"disconnect");
    self endon(#"joined_spectators");
    self notify(#"spawned");
    level notify(#"player_spawned");
    self notify(#"end_respawn");
    self notify(#"started_spawnplayer");
    self setspawnvariables();
    self luinotifyevent(%player_spawned, 0);
    self luinotifyeventtospectators(%player_spawned, 0);
    if (!isdefined(self.pers["resetMomentumOnSpawn"]) || self.pers["resetMomentumOnSpawn"]) {
        self globallogic_score::resetplayermomentumonspawn();
        self.pers["resetMomentumOnSpawn"] = 0;
    }
    if (globallogic_utils::getroundstartdelay()) {
        self thread globallogic_utils::applyroundstartdelay();
    }
    self.sessionteam = self.team;
    hadspawned = self.hasspawned;
    self.sessionstate = "playing";
    self.spectatorclient = -1;
    self.killcamentity = -1;
    self.archivetime = 0;
    self.psoffsettime = 0;
    self.spectatekillcam = 0;
    self.statusicon = "";
    self.damagedplayers = [];
    if (getdvarint("scr_csmode") > 0) {
        self.maxhealth = getdvarint("scr_csmode");
    } else {
        self.maxhealth = level.playermaxhealth;
    }
    self.health = self.maxhealth;
    self.friendlydamage = undefined;
    self.laststunnedby = undefined;
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
    if (!isdefined(level.takelivesondeath) || game[self.team + "_lives"] && level.takelivesondeath == 0) {
        game[self.team + "_lives"]--;
        if (game[self.team + "_lives"] == 0) {
            level notify(#"player_eliminated");
            self notify(#"player_eliminated");
        }
    }
    self.laststand = undefined;
    self.resurrect_not_allowed_by = undefined;
    self.revivingteammate = 0;
    self.burning = undefined;
    self.nextkillstreakfree = undefined;
    self.deathmachinekills = 0;
    self.disabledweapon = 0;
    self util::resetusability();
    self globallogic_player::resetattackerlist();
    self globallogic_player::resetattackersthisspawnlist();
    self.diedonvehicle = undefined;
    self.lastshotby = 127;
    if (!self.wasaliveatmatchstart) {
        if (level.ingraceperiod || globallogic_utils::gettimepassed() < 20000) {
            self.wasaliveatmatchstart = 1;
        }
    }
    self setdepthoffield(0, 0, 512, 512, 4, 0);
    self resetfov();
    pixbeginevent("onSpawnPlayer");
    self [[ level.onspawnplayer ]](0);
    if (isdefined(game["teamops"].var_a295ba07)) {
        var_e21b687a = game["teamops"].data[game["teamops"].var_a295ba07];
        function_cf51fcaa(game["teamops"].var_cdbaab59, game["teamops"].var_b7b1a955, game["teamops"].var_dfb9b8a5, var_e21b687a.time);
        namespace_e21b687a::function_3d345413(undefined, undefined, self.team);
    }
    if (isdefined(level.playerspawnedcb)) {
        self [[ level.playerspawnedcb ]]();
    }
    pixendevent();
    pixendevent();
    level thread globallogic::updateteamstatus();
    pixbeginevent("spawnPlayer_postUTS");
    self thread stoppoisoningandflareonspawn();
    self.sensorgrenadedata = undefined;
    /#
        assert(globallogic_utils::isvalidclass(self.curclass));
    #/
    self.pers["momentum_at_spawn_or_game_end"] = isdefined(self.pers["momentum"]) ? self.pers["momentum"] : 0;
    if (sessionmodeiszombiesgame()) {
        self loadout::giveloadoutlevelspecific(self.team, self.curclass);
    } else {
        self loadout::setclass(self.curclass);
        self loadout::giveloadout(self.team, self.curclass);
        if (getdvarint("tu11_enableClassicMode") == 1) {
            if (self.team == "allies") {
                self setcharacterbodytype(0);
            } else {
                self setcharacterbodytype(2);
            }
        }
    }
    if (level.inprematchperiod) {
        if (isdefined(level.var_a4623c17)) {
            self [[ level.var_a4623c17 ]]();
        } else {
            self util::freeze_player_controls(1);
            team = self.pers["team"];
            if (isdefined(self.pers["music"].spawn) && self.pers["music"].spawn == 0) {
                if (level.wagermatch) {
                    music = "SPAWN_WAGER";
                } else {
                    music = game["music"]["spawn_" + team];
                }
                if (game["roundsplayed"] == 0) {
                    self thread function_a2c32efb("spawnFull");
                } else {
                    self thread function_a2c32efb("spawnShort");
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
            self thread doinitialspawnmessaging();
        }
    } else {
        self util::freeze_player_controls(0);
        self enableweapons();
        if (!hadspawned && game["state"] == "playing") {
            pixbeginevent("sound");
            team = self.team;
            if (isdefined(self.pers["music"].spawn) && self.pers["music"].spawn == 0) {
                music = game["music"]["spawn_" + team];
                self thread function_a2c32efb("spawnShort");
                self.pers["music"].spawn = 1;
            }
            if (level.splitscreen) {
                if (isdefined(level.playedstartingmusic)) {
                    music = undefined;
                } else {
                    level.playedstartingmusic = 1;
                }
            }
            self thread doinitialspawnmessaging();
            pixendevent();
        }
    }
    if (self hasperk("specialty_anteup")) {
        anteup_bonus = getdvarint("perk_killstreakAnteUpResetValue");
        if (self.pers["momentum_at_spawn_or_game_end"] < anteup_bonus) {
            globallogic_score::_setplayermomentum(self, anteup_bonus, 0);
        }
    }
    if (getdvarstring("scr_showperksonspawn") == "") {
        setdvar("scr_showperksonspawn", "0");
    }
    if (level.hardcoremode) {
        setdvar("scr_showperksonspawn", "0");
    }
    if (getdvarint("scr_showperksonspawn") == 1 && game["state"] != "postgame") {
        pixbeginevent("showperksonspawn");
        if (level.perksenabled == 1) {
            self hud::showperks();
        }
        pixendevent();
    }
    if (isdefined(self.pers["momentum"])) {
        self.momentum = self.pers["momentum"];
    }
    self thread function_7e08aae();
    pixendevent();
    waittillframeend();
    self notify(#"spawned_player");
    callback::callback(#"hash_bc12b61f");
    self thread globallogic_player::player_monitor_travel_dist();
    self thread globallogic_player::function_716b3fd6();
    self thread globallogic_player::function_64aa4793();
    self thread globallogic_player::function_9e98f49b();
    self thread globallogic_player::function_cf1cf1b3();
    self thread globallogic_player::player_monitor_inactivity();
    /#
        print("player_spawned" + self.origin[0] + "player_spawned" + self.origin[1] + "player_spawned" + self.origin[2] + "player_spawned");
    #/
    setdvar("scr_selecting_location", "");
    if (!sessionmodeiszombiesgame()) {
        self thread killstreaks::function_afd201f4();
    }
    /#
        if (getdvarint("player_spawned") > 0) {
            self thread globallogic_score::function_4e01d1c3();
        }
    #/
    if (game["state"] == "postgame") {
        /#
            assert(!level.intermission);
        #/
        self globallogic_player::freezeplayerforroundend();
    }
    self util::set_lighting_state();
}

// Namespace globallogic_spawn
// Params 0, eflags: 0x1 linked
// Checksum 0x74f41757, Offset: 0x1dd0
// Size: 0x9a
function function_7e08aae() {
    self endon(#"death");
    self endon(#"disconnect");
    self endon(#"joined_spectators");
    self endon(#"joined_team");
    self notify(#"hash_7e08aae");
    self endon(#"hash_7e08aae");
    level waittill(#"game_ended");
    self.pers["momentum_at_spawn_or_game_end"] = isdefined(self.pers["momentum"]) ? self.pers["momentum"] : 0;
}

// Namespace globallogic_spawn
// Params 1, eflags: 0x1 linked
// Checksum 0x7cceff6, Offset: 0x1e78
// Size: 0x6c
function function_a2c32efb(music) {
    self endon(#"death");
    self endon(#"disconnect");
    while (level.inprematchperiod) {
        wait(0.05);
    }
    if (!(isdefined(level.freerun) && level.freerun)) {
        self thread globallogic_audio::set_music_on_player(music);
    }
}

// Namespace globallogic_spawn
// Params 2, eflags: 0x1 linked
// Checksum 0x2265af7f, Offset: 0x1ef0
// Size: 0x4c
function spawnspectator(origin, angles) {
    self notify(#"spawned");
    self notify(#"end_respawn");
    in_spawnspectator(origin, angles);
}

// Namespace globallogic_spawn
// Params 2, eflags: 0x1 linked
// Checksum 0x8c7d2b0b, Offset: 0x1f48
// Size: 0x2c
function respawn_asspectator(origin, angles) {
    in_spawnspectator(origin, angles);
}

// Namespace globallogic_spawn
// Params 2, eflags: 0x1 linked
// Checksum 0x7e69e83d, Offset: 0x1f80
// Size: 0x194
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
    self.spectatekillcam = 0;
    self.friendlydamage = undefined;
    if (self.pers["team"] == "spectator") {
        self.statusicon = "";
    } else {
        self.statusicon = "hud_status_dead";
    }
    spectating::set_permissions_for_machine();
    [[ level.onspawnspectator ]](origin, angles);
    if (level.teambased && !level.splitscreen) {
        self thread spectatorthirdpersonness();
    }
    level thread globallogic::updateteamstatus();
    pixmarker("END: in_spawnSpectator");
}

// Namespace globallogic_spawn
// Params 0, eflags: 0x1 linked
// Checksum 0x7016011a, Offset: 0x2120
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
// Checksum 0xc1058d4b, Offset: 0x2168
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
// Checksum 0x15e21384, Offset: 0x2268
// Size: 0x5c
function kickifdontspawn() {
    /#
        if (getdvarint("player_spawned") == 1) {
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
// Checksum 0xd15b2892, Offset: 0x22d0
// Size: 0x20c
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
    if (self.pers["time_played_total"] > 0 || !mayspawn() && util::isprophuntgametype()) {
        return;
    }
    globallogic::gamehistoryplayerkicked();
    kick(self getentitynumber(), "EXE_PLAYERKICKED_NOTSPAWNED");
}

// Namespace globallogic_spawn
// Params 1, eflags: 0x1 linked
// Checksum 0xc3eaefd6, Offset: 0x24e8
// Size: 0x2c
function kickwait(waittime) {
    level endon(#"game_ended");
    hostmigration::waitlongdurationwithhostmigrationpause(waittime);
}

// Namespace globallogic_spawn
// Params 0, eflags: 0x0
// Checksum 0x56104739, Offset: 0x2520
// Size: 0x13c
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
    self.spectatekillcam = 0;
    self.friendlydamage = undefined;
    self globallogic_defaults::default_onspawnintermission();
    self setorigin(self.origin);
    self setplayerangles(self.angles);
    self setdepthoffield(0, -128, 512, 4000, 6, 1.8);
}

// Namespace globallogic_spawn
// Params 2, eflags: 0x1 linked
// Checksum 0x464bcfd6, Offset: 0x2668
// Size: 0x13c
function spawnintermission(usedefaultcallback, endgame) {
    self notify(#"spawned");
    self notify(#"end_respawn");
    self endon(#"disconnect");
    self setspawnvariables();
    self util::clearlowermessage();
    self util::freeze_player_controls(0);
    self.sessionstate = "intermission";
    self.spectatorclient = -1;
    self.killcamentity = -1;
    self.archivetime = 0;
    self.psoffsettime = 0;
    self.spectatekillcam = 0;
    self.friendlydamage = undefined;
    if (isdefined(usedefaultcallback) && usedefaultcallback) {
        globallogic_defaults::default_onspawnintermission();
    } else {
        [[ level.onspawnintermission ]](endgame);
    }
    self setdepthoffield(0, -128, 512, 4000, 6, 1.8);
}

// Namespace globallogic_spawn
// Params 1, eflags: 0x1 linked
// Checksum 0x75af9f0d, Offset: 0x27b0
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
// Checksum 0x554a5a3, Offset: 0x2890
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
// Checksum 0xfccd6a23, Offset: 0x29f0
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
// Checksum 0xa8575c1a, Offset: 0x2ac0
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
// Checksum 0xdbf8cf33, Offset: 0x2b38
// Size: 0x44
function default_spawnmessage() {
    util::setlowermessage(game["strings"]["spawn_next_round"]);
    self thread globallogic_ui::removespawnmessageshortly(3);
}

// Namespace globallogic_spawn
// Params 0, eflags: 0x1 linked
// Checksum 0x529475c1, Offset: 0x2b88
// Size: 0x28
function showspawnmessage() {
    if (shouldshowrespawnmessage()) {
        self thread [[ level.spawnmessage ]]();
    }
}

// Namespace globallogic_spawn
// Params 1, eflags: 0x1 linked
// Checksum 0xcac8abf5, Offset: 0x2bb8
// Size: 0x194
function spawnclient(timealreadypassed) {
    pixbeginevent("spawnClient");
    /#
        assert(isdefined(self.team));
    #/
    /#
        assert(globallogic_utils::isvalidclass(self.curclass));
    #/
    if (!self mayspawn() && !(isdefined(self.usedresurrect) && self.usedresurrect)) {
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
// Checksum 0x680ac454, Offset: 0x2d58
// Size: 0x5cc
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
                spawnpoint = spawnlogic::get_random_intermission_point();
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
    if (isdefined(level.var_2b829c4e)) {
        if (!spawnedasspectator) {
            self thread respawn_asspectator(self.origin + (0, 0, 60), self.angles);
        }
        spawnedasspectator = 1;
        if (!self [[ level.var_2b829c4e ]]()) {
            self.waitingtospawn = 0;
            self util::clearlowermessage();
            self.wavespawnindex = undefined;
            self.respawntimerstarttime = undefined;
            return;
        }
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
    if (isdefined(level.playerincrementalrespawndelay)) {
        if (isdefined(self.pers["spawns"])) {
            self.pers["spawns"]++;
        } else {
            self.pers["spawns"] = 1;
        }
    }
    self thread [[ level.spawnplayer ]]();
}

// Namespace globallogic_spawn
// Params 0, eflags: 0x1 linked
// Checksum 0x4df04495, Offset: 0x3330
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
// Checksum 0xd8019057, Offset: 0x3380
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
// Params 1, eflags: 0x1 linked
// Checksum 0x8d3d9ef6, Offset: 0x3418
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
// Checksum 0xd9d7a8f8, Offset: 0x3510
// Size: 0x4c
function setspawnvariables() {
    resettimeout();
    self stopshellshock();
    self stoprumble("damage_heavy");
}

