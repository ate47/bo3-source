#using scripts/cp/_util;
#using scripts/shared/scene_shared;
#using scripts/shared/lui_shared;
#using scripts/cp/gametypes/coop;
#using scripts/cp/gametypes/_spectating;
#using scripts/cp/gametypes/_spawnlogic;
#using scripts/cp/gametypes/_spawning;
#using scripts/cp/gametypes/_save;
#using scripts/cp/gametypes/_globallogic_utils;
#using scripts/cp/gametypes/_globallogic_ui;
#using scripts/cp/gametypes/_globallogic_score;
#using scripts/cp/gametypes/_globallogic_player;
#using scripts/cp/gametypes/_globallogic_defaults;
#using scripts/cp/gametypes/_globallogic;
#using scripts/cp/gametypes/_loadout;
#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/hud_util_shared;
#using scripts/shared/hud_message_shared;
#using scripts/shared/hostmigration_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/callbacks_shared;

#namespace globallogic_spawn;

// Namespace globallogic_spawn
// Params 1, eflags: 0x1 linked
// namespace_7956eece<file_0>::function_cabdc9f7
// Checksum 0xd5cabbd, Offset: 0x5d0
// Size: 0x178
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
        if (isdefined(self.suicide) && self.suicide && level.suicidespawndelay > 0) {
            respawndelay += level.suicidespawndelay;
        }
        if (isdefined(self.teamkilled) && self.teamkilled && level.teamkilledspawndelay > 0) {
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
    return respawndelay;
}

// Namespace globallogic_spawn
// Params 0, eflags: 0x1 linked
// namespace_7956eece<file_0>::function_5881cfb8
// Checksum 0x99110292, Offset: 0x750
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
// Checksum 0xc5f7dff9, Offset: 0x7e8
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
    if (isdefined(self.var_d670c0a7) && self.var_d670c0a7) {
        return false;
    }
    if (level.numlives) {
        if (level.teambased) {
            gamehasstarted = allteamshaveexisted();
        } else {
            gamehasstarted = !util::isoneround() && (level.maxplayercount > 1 || !util::isfirstround());
        }
        if (!self.pers["lives"]) {
            return false;
        } else if (gamehasstarted) {
            if (!level.ingraceperiod && !self.hasspawned) {
                return false;
            }
        }
    }
    return true;
}

// Namespace globallogic_spawn
// Params 1, eflags: 0x1 linked
// namespace_7956eece<file_0>::function_febae56
// Checksum 0xafef8e4d, Offset: 0x938
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
// Checksum 0xd023cc41, Offset: 0xa68
// Size: 0x3c
function stoppoisoningandflareonspawn() {
    self endon(#"disconnect");
    self.inpoisonarea = 0;
    self.inburnarea = 0;
    self.inflarevisionarea = 0;
    self.ingroundnapalm = 0;
}

// Namespace globallogic_spawn
// Params 0, eflags: 0x0
// namespace_7956eece<file_0>::function_f868991e
// Checksum 0xad1f51dc, Offset: 0xab0
// Size: 0x68
function spawnplayerprediction() {
    self endon(#"disconnect");
    self endon(#"end_respawn");
    self endon(#"game_ended");
    self endon(#"joined_spectators");
    self endon(#"spawned");
    while (true) {
        wait(0.5);
        self [[ level.onspawnplayer ]](1);
    }
}

// Namespace globallogic_spawn
// Params 0, eflags: 0x1 linked
// namespace_7956eece<file_0>::function_608568f5
// Checksum 0x585cc3c8, Offset: 0xb20
// Size: 0xbc
function doinitialspawnmessaging() {
    self endon(#"disconnect");
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
        self thread hud_message::hintmessage(hintmessage);
    }
}

// Namespace globallogic_spawn
// Params 0, eflags: 0x1 linked
// namespace_7956eece<file_0>::function_1fee8319
// Checksum 0x7ebc10a7, Offset: 0xbe8
// Size: 0x9d4
function spawnplayer() {
    pixbeginevent("spawnPlayer_preUTS");
    self endon(#"disconnect");
    self endon(#"joined_spectators");
    self notify(#"spawned");
    level notify(#"player_spawned");
    self notify(#"end_respawn");
    self setspawnvariables();
    self luinotifyevent(%player_spawned, 0);
    self util::clearlowermessage(0);
    self.sessionteam = self.team;
    hadspawned = self.hasspawned;
    self.sessionstate = "playing";
    self.spectatorclient = -1;
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
    self [[ level.onspawnplayer ]](0);
    if (isdefined(level.playerspawnedcb)) {
        self [[ level.playerspawnedcb ]]();
    }
    pixendevent();
    pixendevent();
    globallogic::updateteamstatus();
    pixbeginevent("spawnPlayer_postUTS");
    self thread stoppoisoningandflareonspawn();
    self.sensorgrenadedata = undefined;
    assert(globallogic_utils::isvalidclass(self.curclass) || util::is_bot());
    self loadout::setclass(self.curclass);
    var_4fbe10c = self savegame::function_36adbb9c("altPlayerID", undefined);
    var_5a13c491 = undefined;
    if (isdefined(var_4fbe10c)) {
        foreach (var_388ffcfb in level.players) {
            if (var_388ffcfb getxuid() === var_4fbe10c) {
                var_5a13c491 = var_388ffcfb;
                break;
            }
        }
        if (!isdefined(var_5a13c491)) {
            self savegame::set_player_data("altPlayerID", undefined);
        }
    }
    self thread loadout::giveloadout(self.team, self.curclass, level.var_dc236bc8, var_5a13c491);
    if (isdefined(self.var_c8430b0a) && self.var_c8430b0a) {
        self.var_c8430b0a = undefined;
    } else {
        self lui::screen_close_menu();
    }
    if (level.inprematchperiod) {
        self util::freeze_player_controls(1);
        team = self.pers["team"];
        self thread doinitialspawnmessaging();
    } else {
        self util::freeze_player_controls(0);
        self enableweapons();
        if (!hadspawned && game["state"] == "playing") {
            pixbeginevent("sound");
            team = self.team;
            self thread doinitialspawnmessaging();
            pixendevent();
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
    pixendevent();
    wait(0.05);
    self notify(#"spawned_player");
    if (!getdvarint("art_review", 0)) {
        callback::callback(#"hash_bc12b61f");
    }
    /#
        print("spawnPlayer_postUTS" + self.origin[0] + "spawnPlayer_postUTS" + self.origin[1] + "spawnPlayer_postUTS" + self.origin[2] + "spawnPlayer_postUTS");
    #/
    setdvar("scr_selecting_location", "");
    self thread function_f937c96d();
    /#
        if (getdvarint("spawnPlayer_postUTS") > 0) {
            self thread globallogic_score::function_4e01d1c3();
        }
    #/
    if (game["state"] == "postgame") {
        assert(!level.intermission);
        self globallogic_player::freezeplayerforroundend();
    }
    self util::set_lighting_state();
    self util::set_sun_shadow_split_distance();
    self util::streamer_wait(undefined, 0, 5);
    self flag::set("initial_streamer_ready");
}

// Namespace globallogic_spawn
// Params 0, eflags: 0x1 linked
// namespace_7956eece<file_0>::function_f937c96d
// Checksum 0xfbf44b2d, Offset: 0x15c8
// Size: 0x74
function function_f937c96d() {
    self notify(#"hash_f937c96d");
    self endon(#"hash_f937c96d");
    self endon(#"disconnect");
    while (true) {
        vehicle_died = self waittill(#"vehicle_death");
        if (vehicle_died) {
            self.diedonvehicle = 1;
            continue;
        }
        self.var_76dfde9a = 1;
    }
}

// Namespace globallogic_spawn
// Params 2, eflags: 0x1 linked
// namespace_7956eece<file_0>::function_dedbb7c9
// Checksum 0x878688cc, Offset: 0x1648
// Size: 0x54
function spawnspectator(origin, angles) {
    self notify(#"spawned");
    self notify(#"end_respawn");
    self notify(#"spawned_spectator");
    in_spawnspectator(origin, angles);
}

// Namespace globallogic_spawn
// Params 2, eflags: 0x1 linked
// namespace_7956eece<file_0>::function_a1bf9b89
// Checksum 0x91571fb1, Offset: 0x16a8
// Size: 0x2c
function respawn_asspectator(origin, angles) {
    in_spawnspectator(origin, angles);
}

// Namespace globallogic_spawn
// Params 2, eflags: 0x1 linked
// namespace_7956eece<file_0>::function_2e650f63
// Checksum 0xe7d33722, Offset: 0x16e0
// Size: 0x164
function in_spawnspectator(origin, angles) {
    pixmarker("BEGIN: in_spawnSpectator");
    self setspawnvariables();
    if (self.pers["team"] == "spectator") {
        self util::clearlowermessage();
    }
    self.sessionstate = "spectator";
    self.spectatorclient = -1;
    self.archivetime = 0;
    self.psoffsettime = 0;
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
    pixmarker("END: in_spawnSpectator");
}

// Namespace globallogic_spawn
// Params 0, eflags: 0x1 linked
// namespace_7956eece<file_0>::function_29cfb1d
// Checksum 0x33e06797, Offset: 0x1850
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
// Checksum 0x66230dfb, Offset: 0x1898
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
// Checksum 0x937ecb7b, Offset: 0x1998
// Size: 0x5c
function kickifdontspawn() {
    /#
        if (getdvarint("spawnPlayer_postUTS") == 1) {
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
// Checksum 0xa7db9a16, Offset: 0x1a00
// Size: 0x1d4
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
    kick(self getentitynumber());
}

// Namespace globallogic_spawn
// Params 1, eflags: 0x1 linked
// namespace_7956eece<file_0>::function_58062728
// Checksum 0x7d954656, Offset: 0x1be0
// Size: 0x2c
function kickwait(waittime) {
    level endon(#"game_ended");
    hostmigration::waitlongdurationwithhostmigrationpause(waittime);
}

// Namespace globallogic_spawn
// Params 0, eflags: 0x0
// namespace_7956eece<file_0>::function_f4876f2c
// Checksum 0x11736237, Offset: 0x1c18
// Size: 0x124
function spawninterroundintermission() {
    self notify(#"spawned");
    self notify(#"end_respawn");
    self setspawnvariables();
    self util::clearlowermessage();
    self util::freeze_player_controls(0);
    self.sessionstate = "spectator";
    self.spectatorclient = -1;
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
// Checksum 0xd704249, Offset: 0x1d48
// Size: 0x114
function spawnintermission(usedefaultcallback) {
    self notify(#"spawned");
    self notify(#"end_respawn");
    self endon(#"disconnect");
    self setspawnvariables();
    self util::clearlowermessage();
    self util::freeze_player_controls(0);
    self.sessionstate = "intermission";
    self.spectatorclient = -1;
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
// Checksum 0xd5c8a72b, Offset: 0x1e68
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
// Checksum 0x3129746b, Offset: 0x1f48
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
// Checksum 0x7d719336, Offset: 0x20a8
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
// Checksum 0xd76d3b53, Offset: 0x2178
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
// Checksum 0x991d966c, Offset: 0x21f0
// Size: 0x44
function default_spawnmessage() {
    util::setlowermessage(game["strings"]["spawn_next_round"]);
    self thread globallogic_ui::removespawnmessageshortly(3);
}

// Namespace globallogic_spawn
// Params 0, eflags: 0x1 linked
// namespace_7956eece<file_0>::function_a559a720
// Checksum 0xeb76f3d2, Offset: 0x2240
// Size: 0x28
function showspawnmessage() {
    if (shouldshowrespawnmessage()) {
        self thread [[ level.spawnmessage ]]();
    }
}

// Namespace globallogic_spawn
// Params 1, eflags: 0x1 linked
// namespace_7956eece<file_0>::function_f3db290b
// Checksum 0xa32493be, Offset: 0x2270
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
// Checksum 0x1d25e8a2, Offset: 0x23f8
// Size: 0x79c
function waitandspawnclient(timealreadypassed) {
    self endon(#"disconnect");
    self endon(#"end_respawn");
    level endon(#"game_ended");
    if (!isdefined(timealreadypassed)) {
        timealreadypassed = 0;
    }
    spawnedasspectator = 0;
    if (isdefined(self.var_ebd83169) && isdefined(level.var_3a9f9a38) && level.var_3a9f9a38 && self.var_ebd83169) {
        self thread coop::function_44e35f1a();
    }
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
        if (isdefined(level.var_bdd4d5c2) && !spawnedasspectator) {
            spawnedasspectator = self [[ level.var_bdd4d5c2 ]]();
        }
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
    system::wait_till("all");
    level flag::wait_till("all_players_connected");
    if (level.players.size > 0) {
        if (scene::should_spectate_on_join()) {
            if (!spawnedasspectator) {
                self thread respawn_asspectator(self.origin + (0, 0, 60), self.angles);
            }
            spawnedasspectator = 1;
            scene::wait_until_spectate_on_join_completes();
        }
    }
    wavebased = level.waverespawndelay > 0;
    if (!level.playerforcerespawn && self.hasspawned && !wavebased && !self.wantsafespawn && !level.playerqueuedrespawn && !spawnedasspectator) {
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
    if (isdefined(self.var_acfedf1c) && self.var_acfedf1c) {
        self waittill(#"end_killcam");
    }
    self notify(#"hash_1528244e");
    if (isdefined(self.var_ee8c475a)) {
        self.var_ee8c475a.alpha = 0;
    }
    self.var_ebd83169 = undefined;
    self.var_acfedf1c = undefined;
    self.var_1b7a74aa = undefined;
    self.var_ca78829f = undefined;
    self.killcamweapon = getweapon("none");
    self.var_8c0347ee = undefined;
    self.var_2b1ad8b = undefined;
    if (isdefined(level.var_ee7cb602) && level.var_ee7cb602) {
        level waittill(#"forever");
    }
    if (!isdefined(self.firstspawn)) {
        self.firstspawn = 1;
        savegame::checkpoint_save();
    }
    self thread [[ level.spawnplayer ]]();
}

// Namespace globallogic_spawn
// Params 0, eflags: 0x1 linked
// namespace_7956eece<file_0>::function_8192db4b
// Checksum 0x9406a479, Offset: 0x2ba0
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
// Checksum 0x82e3850c, Offset: 0x2bf0
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
// namespace_7956eece<file_0>::function_dc6304e9
// Checksum 0x363a78e7, Offset: 0x2c88
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
// Checksum 0x2b418482, Offset: 0x2d80
// Size: 0x4c
function setspawnvariables() {
    resettimeout();
    self stopshellshock();
    self stoprumble("damage_heavy");
}

