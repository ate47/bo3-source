#using scripts/mp/_teamops;
#using scripts/mp/_util;
#using scripts/mp/_vehicle;
#using scripts/mp/bots/_bot;
#using scripts/mp/gametypes/_battlechatter;
#using scripts/mp/gametypes/_globallogic;
#using scripts/mp/gametypes/_globallogic_audio;
#using scripts/mp/gametypes/_globallogic_defaults;
#using scripts/mp/gametypes/_globallogic_player;
#using scripts/mp/gametypes/_globallogic_score;
#using scripts/mp/gametypes/_globallogic_ui;
#using scripts/mp/gametypes/_globallogic_utils;
#using scripts/mp/gametypes/_hostmigration;
#using scripts/mp/gametypes/_hud_message;
#using scripts/mp/gametypes/_loadout;
#using scripts/mp/gametypes/_spawning;
#using scripts/mp/gametypes/_spawnlogic;
#using scripts/mp/gametypes/_spectating;
#using scripts/mp/killstreaks/_killstreaks;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/flagsys_shared;
#using scripts/shared/hostmigration_shared;
#using scripts/shared/hud_message_shared;
#using scripts/shared/hud_util_shared;
#using scripts/shared/util_shared;

#namespace globallogic_spawn;

// Namespace globallogic_spawn
// Params 1, eflags: 0x0
// Checksum 0xaa9b56c8, Offset: 0x720
// Size: 0x12d
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
// Params 0, eflags: 0x0
// Checksum 0xb9a8be90, Offset: 0x858
// Size: 0x61
function allteamshaveexisted() {
    foreach (team in level.teams) {
        if (!level.everexisted[team]) {
            return false;
        }
    }
    return true;
}

// Namespace globallogic_spawn
// Params 0, eflags: 0x0
// Checksum 0xdcccb03d, Offset: 0x8c8
// Size: 0x13d
function mayspawn() {
    if (isdefined(level.mayspawn) && !self [[ level.mayspawn ]]()) {
        return false;
    }
    if (level.inovertime) {
        return false;
    }
    if (level.playerqueuedrespawn && !isdefined(self.allowqueuespawn) && !level.ingraceperiod && !level.usestartspawns) {
        return false;
    }
    if (level.numlives || level.numteamlives) {
        if (level.teambased) {
            gamehasstarted = allteamshaveexisted();
        } else {
            gamehasstarted = !util::isoneround() && (level.maxplayercount > 1 || !util::isfirstround());
        }
        InvalidOpCode(0x54, self.team + "_lives");
        // Unknown operator (0x54, t7_1b, PC)
    LOC_00000104:
        if (level.numteamlives && (level.numlives && !self.pers["lives"] || level.numlives && !self.pers["lives"])) {
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
// Params 1, eflags: 0x0
// Checksum 0x8f4f2a6, Offset: 0xa10
// Size: 0xda
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
// Params 0, eflags: 0x0
// Checksum 0x9ec7200b, Offset: 0xaf8
// Size: 0x2a
function stoppoisoningandflareonspawn() {
    self endon(#"disconnect");
    self.inpoisonarea = 0;
    self.inburnarea = 0;
    self.inflarevisionarea = 0;
    self.ingroundnapalm = 0;
}

// Namespace globallogic_spawn
// Params 0, eflags: 0x0
// Checksum 0x3543b543, Offset: 0xb30
// Size: 0x9d
function spawnplayerprediction() {
    self endon(#"disconnect");
    self endon(#"end_respawn");
    self endon(#"game_ended");
    self endon(#"joined_spectators");
    self endon(#"spawned");
    InvalidOpCode(0x54, self.team + "_lives");
    // Unknown operator (0x54, t7_1b, PC)
LOC_00000070:
    livesleft = !(level.numlives && !self.pers["lives"]) && !(level.numteamlives && level.numteamlives);
    if (!livesleft) {
        return;
    }
    while (true) {
        wait 0.5;
        spawning::onspawnplayer(1);
    }
}

// Namespace globallogic_spawn
// Params 0, eflags: 0x0
// Checksum 0xfab7750b, Offset: 0xbd8
// Size: 0x15a
function doinitialspawnmessaging() {
    self endon(#"disconnect");
    if (isdefined(level.var_29d9f951) && level.var_29d9f951) {
        return;
    }
    team = self.pers["team"];
    thread hud_message::function_c0025cfc(team);
    while (level.inprematchperiod) {
        wait 0.05;
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
        InvalidOpCode(0x54, "attackers", team);
        // Unknown operator (0x54, t7_1b, PC)
    }
}

// Namespace globallogic_spawn
// Params 0, eflags: 0x0
// Checksum 0x6435a5b7, Offset: 0xd40
// Size: 0x24e
function spawnplayer() {
    pixbeginevent("spawnPlayer_preUTS");
    self endon(#"disconnect");
    self endon(#"joined_spectators");
    self notify(#"spawned");
    level notify(#"player_spawned");
    self notify(#"end_respawn");
    self setspawnvariables();
    self luinotifyevent(%player_spawned, 0);
    self luinotifyeventtospectators(%player_spawned, 0);
    var_c21f0eb8 = 0;
    if (!isdefined(self.pers["resetMomentumOnSpawn"]) || self.pers["resetMomentumOnSpawn"]) {
        self globallogic_score::resetplayermomentumonspawn();
        self.pers["resetMomentumOnSpawn"] = 0;
        var_c21f0eb8 = 1;
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
    InvalidOpCode(0x54, self.team + "_lives");
    // Unknown operator (0x54, t7_1b, PC)
}

// Namespace globallogic_spawn
// Params 1, eflags: 0x0
// Checksum 0xa24e7d69, Offset: 0x17d0
// Size: 0x5a
function function_a2c32efb(music) {
    self endon(#"death");
    self endon(#"disconnect");
    while (level.inprematchperiod) {
        wait 0.05;
    }
    if (!(isdefined(level.freerun) && level.freerun)) {
        self thread globallogic_audio::set_music_on_player(music);
    }
}

// Namespace globallogic_spawn
// Params 2, eflags: 0x0
// Checksum 0xbd2b7702, Offset: 0x1838
// Size: 0x3a
function spawnspectator(origin, angles) {
    self notify(#"spawned");
    self notify(#"end_respawn");
    in_spawnspectator(origin, angles);
}

// Namespace globallogic_spawn
// Params 2, eflags: 0x0
// Checksum 0xa7f7a54e, Offset: 0x1880
// Size: 0x22
function respawn_asspectator(origin, angles) {
    in_spawnspectator(origin, angles);
}

// Namespace globallogic_spawn
// Params 2, eflags: 0x0
// Checksum 0x6d179a81, Offset: 0x18b0
// Size: 0x14a
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
// Params 0, eflags: 0x0
// Checksum 0xa310ce1b, Offset: 0x1a08
// Size: 0x2a
function spectatorthirdpersonness() {
    self endon(#"disconnect");
    self endon(#"spawned");
    self notify(#"spectator_thirdperson_thread");
    self endon(#"spectator_thirdperson_thread");
    self.spectatingthirdperson = 0;
}

// Namespace globallogic_spawn
// Params 1, eflags: 0x0
// Checksum 0xfb06a14, Offset: 0x1a40
// Size: 0xcc
function forcespawn(time) {
    self endon(#"death");
    self endon(#"disconnect");
    self endon(#"spawned");
    if (!isdefined(time)) {
        time = 60;
    }
    wait time;
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
// Params 0, eflags: 0x0
// Checksum 0x315e578e, Offset: 0x1b18
// Size: 0x4a
function kickifdontspawn() {
    /#
        if (getdvarint("<dev string:x3a>") == 1) {
            return;
        }
    #/
    if (self ishost()) {
        return;
    }
    self kickifidontspawninternal();
}

// Namespace globallogic_spawn
// Params 0, eflags: 0x0
// Checksum 0xf92742ca, Offset: 0x1b70
// Size: 0x17a
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
    if (!mayspawn()) {
        return;
    }
    globallogic::gamehistoryplayerkicked();
    kick(self getentitynumber(), "EXE_PLAYERKICKED_NOTSPAWNED");
}

// Namespace globallogic_spawn
// Params 1, eflags: 0x0
// Checksum 0xa598a2b4, Offset: 0x1cf8
// Size: 0x22
function kickwait(waittime) {
    level endon(#"game_ended");
    hostmigration::waitlongdurationwithhostmigrationpause(waittime);
}

// Namespace globallogic_spawn
// Params 0, eflags: 0x0
// Checksum 0x976edd6c, Offset: 0x1d28
// Size: 0xe2
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
// Params 2, eflags: 0x0
// Checksum 0x3188f8df, Offset: 0x1e18
// Size: 0xe2
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
// Params 1, eflags: 0x0
// Checksum 0xb4369726, Offset: 0x1f08
// Size: 0xa0
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
// Params 2, eflags: 0x0
// Checksum 0x31c16483, Offset: 0x1fb0
// Size: 0xf3
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
// Params 0, eflags: 0x0
// Checksum 0xcb2d8968, Offset: 0x20b0
// Size: 0x89
function allteamsnearscorelimit() {
    if (!level.teambased) {
        return false;
    }
    if (level.scorelimit <= 1) {
        return false;
    }
    var_93133254 = level.teams;
    var_98a7f586 = firstarray(var_93133254);
    if (isdefined(var_98a7f586)) {
        team = var_93133254[var_98a7f586];
        var_8abe6d25 = nextarray(var_93133254, var_98a7f586);
        InvalidOpCode(0x54, "teamScores", team);
        // Unknown operator (0x54, t7_1b, PC)
    }
    return true;
}

// Namespace globallogic_spawn
// Params 0, eflags: 0x0
// Checksum 0x5824b3b5, Offset: 0x2148
// Size: 0x61
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
// Params 0, eflags: 0x0
// Checksum 0x7b24091b, Offset: 0x21b8
// Size: 0x11
function default_spawnmessage() {
    InvalidOpCode(0x54, "strings", "spawn_next_round");
    // Unknown operator (0x54, t7_1b, PC)
}

// Namespace globallogic_spawn
// Params 0, eflags: 0x0
// Checksum 0x24380e63, Offset: 0x21f8
// Size: 0x20
function showspawnmessage() {
    if (shouldshowrespawnmessage()) {
        self thread [[ level.spawnmessage ]]();
    }
}

// Namespace globallogic_spawn
// Params 1, eflags: 0x0
// Checksum 0x8eb0d6f0, Offset: 0x2220
// Size: 0x142
function spawnclient(timealreadypassed) {
    pixbeginevent("spawnClient");
    assert(isdefined(self.team));
    assert(globallogic_utils::isvalidclass(self.curclass));
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
// Params 1, eflags: 0x0
// Checksum 0x47f44706, Offset: 0x2370
// Size: 0x424
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
            wait teamkilldelay;
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
            InvalidOpCode(0x54, "strings", "you_will_spawn", timeuntilspawn);
            // Unknown operator (0x54, t7_1b, PC)
        }
        if (self issplitscreen()) {
            InvalidOpCode(0x54, "strings", "waiting_to_spawn_ss", timeuntilspawn, 1);
            // Unknown operator (0x54, t7_1b, PC)
        }
        InvalidOpCode(0x54, "strings", "waiting_to_spawn", timeuntilspawn);
        // Unknown operator (0x54, t7_1b, PC)
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
        InvalidOpCode(0x54, "strings", "press_to_spawn");
        // Unknown operator (0x54, t7_1b, PC)
    }
    self.waitingtospawn = 0;
    self util::clearlowermessage();
    self.wavespawnindex = undefined;
    self.respawntimerstarttime = undefined;
    self thread [[ level.spawnplayer ]]();
}

// Namespace globallogic_spawn
// Params 0, eflags: 0x0
// Checksum 0x9baa4706, Offset: 0x27a0
// Size: 0x3d
function waitrespawnorsafespawnbutton() {
    self endon(#"disconnect");
    self endon(#"end_respawn");
    while (true) {
        if (self usebuttonpressed()) {
            break;
        }
        wait 0.05;
    }
}

// Namespace globallogic_spawn
// Params 0, eflags: 0x0
// Checksum 0x1ac1e9c1, Offset: 0x27e8
// Size: 0x70
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
// Checksum 0xfe5e6020, Offset: 0x2860
// Size: 0xba
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
// Params 0, eflags: 0x0
// Checksum 0x30d21ea1, Offset: 0x2928
// Size: 0x3a
function setspawnvariables() {
    resettimeout();
    self stopshellshock();
    self stoprumble("damage_heavy");
}

