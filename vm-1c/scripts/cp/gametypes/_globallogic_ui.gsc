#using scripts/cp/teams/_teams;
#using scripts/cp/_util;
#using scripts/cp/gametypes/_spectating;
#using scripts/cp/gametypes/_save;
#using scripts/cp/gametypes/_globallogic_player;
#using scripts/cp/gametypes/_globallogic;
#using scripts/cp/gametypes/_loadout;
#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/string_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/lui_shared;
#using scripts/shared/hud_util_shared;
#using scripts/shared/flagsys_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/array_shared;

#namespace globallogic_ui;

// Namespace globallogic_ui
// Params 0, eflags: 0x1 linked
// Checksum 0xbccf1cf4, Offset: 0x658
// Size: 0x17c
function init() {
    callback::add_callback(#"hash_bc12b61f", &on_player_spawn);
    clientfield::register("clientuimodel", "hudItems.cybercoreSelectMenuDisabled", 1, 1, "int");
    clientfield::register("clientuimodel", "hudItems.playerInCombat", 1, 1, "int");
    clientfield::register("clientuimodel", "playerAbilities.repulsorIndicatorDirection", 1, 2, "int");
    clientfield::register("clientuimodel", "playerAbilities.repulsorIndicatorIntensity", 1, 2, "int");
    clientfield::register("clientuimodel", "playerAbilities.proximityIndicatorDirection", 1, 2, "int");
    clientfield::register("clientuimodel", "playerAbilities.proximityIndicatorIntensity", 1, 2, "int");
    clientfield::register("clientuimodel", "serverDifficulty", 1, 3, "int");
}

// Namespace globallogic_ui
// Params 0, eflags: 0x1 linked
// Checksum 0xa330c9a5, Offset: 0x7e0
// Size: 0x64
function on_player_spawn() {
    self thread function_79bc3ebf();
    assert(isdefined(level.gameskill));
    self clientfield::set_player_uimodel("serverDifficulty", level.gameskill);
}

// Namespace globallogic_ui
// Params 1, eflags: 0x1 linked
// Checksum 0x6c74607d, Offset: 0x850
// Size: 0x1a0
function function_77f47965(playerent) {
    ais = getaiteamarray("axis");
    ais = arraycombine(ais, getaiteamarray("team3"), 0, 0);
    foreach (ai in ais) {
        if (issentient(ai)) {
            if (ai attackedrecently(playerent, 10)) {
                return true;
            }
            if (ai.enemy === playerent && isdefined(ai.weapon) && ai.weapon.name === "none" && distancesquared(ai.origin, playerent.origin) < -16 * -16) {
                return true;
            }
        }
    }
    return false;
}

// Namespace globallogic_ui
// Params 1, eflags: 0x0
// Checksum 0x1d89981b, Offset: 0x9f8
// Size: 0x116
function function_e172c2eb(playerent) {
    ais = getaiteamarray("axis");
    ais = arraycombine(ais, getaiteamarray("team3"), 0, 0);
    foreach (ai in ais) {
        if (issentient(ai)) {
            if (ai lastknowntime(playerent) + 4000 >= gettime()) {
                return true;
            }
        }
    }
    return false;
}

// Namespace globallogic_ui
// Params 1, eflags: 0x1 linked
// Checksum 0x58db2e83, Offset: 0xb18
// Size: 0x28
function function_6afb24d5(playerent) {
    return playerent.health < playerent.maxhealth;
}

// Namespace globallogic_ui
// Params 0, eflags: 0x1 linked
// Checksum 0x35313c8a, Offset: 0xb48
// Size: 0x98
function function_79bc3ebf() {
    self endon(#"hash_50d14846");
    self endon(#"disconnect");
    while (true) {
        if (function_6afb24d5(self) || function_77f47965(self)) {
            self clientfield::set_player_uimodel("hudItems.playerInCombat", 1);
        } else {
            self clientfield::set_player_uimodel("hudItems.playerInCombat", 0);
        }
        wait 0.5;
    }
}

// Namespace globallogic_ui
// Params 0, eflags: 0x1 linked
// Checksum 0x9d2ca19f, Offset: 0xbe8
// Size: 0x64
function setupcallbacks() {
    level.autoassign = &menuautoassign;
    level.spectator = &menuspectator;
    level.curclass = &menuclass;
    level.teammenu = &menuteam;
}

// Namespace globallogic_ui
// Params 0, eflags: 0x1 linked
// Checksum 0xe5b262b4, Offset: 0xc58
// Size: 0x27c
function freegameplayhudelems() {
    if (isdefined(self.perkicon)) {
        for (numspecialties = 0; numspecialties < level.maxspecialties; numspecialties++) {
            if (isdefined(self.perkicon[numspecialties])) {
                self.perkicon[numspecialties] hud::destroyelem();
                self.perkname[numspecialties] hud::destroyelem();
            }
        }
    }
    if (isdefined(self.perkhudelem)) {
        self.perkhudelem hud::destroyelem();
    }
    if (isdefined(self.killstreakicon)) {
        if (isdefined(self.killstreakicon[0])) {
            self.killstreakicon[0] hud::destroyelem();
        }
        if (isdefined(self.killstreakicon[1])) {
            self.killstreakicon[1] hud::destroyelem();
        }
        if (isdefined(self.killstreakicon[2])) {
            self.killstreakicon[2] hud::destroyelem();
        }
        if (isdefined(self.killstreakicon[3])) {
            self.killstreakicon[3] hud::destroyelem();
        }
        if (isdefined(self.killstreakicon[4])) {
            self.killstreakicon[4] hud::destroyelem();
        }
    }
    if (isdefined(self.lowermessage)) {
        self.lowermessage hud::destroyelem();
    }
    if (isdefined(self.lowertimer)) {
        self.lowertimer hud::destroyelem();
    }
    if (isdefined(self.proxbar)) {
        self.proxbar hud::destroyelem();
    }
    if (isdefined(self.proxbartext)) {
        self.proxbartext hud::destroyelem();
    }
    if (isdefined(self.carryicon)) {
        self.carryicon hud::destroyelem();
    }
}

// Namespace globallogic_ui
// Params 1, eflags: 0x0
// Checksum 0x7fe78b3e, Offset: 0xee0
// Size: 0xc6
function teamplayercountsequal(playercounts) {
    count = undefined;
    foreach (team in level.teams) {
        if (!isdefined(count)) {
            count = playercounts[team];
            continue;
        }
        if (count != playercounts[team]) {
            return false;
        }
    }
    return true;
}

// Namespace globallogic_ui
// Params 2, eflags: 0x0
// Checksum 0xd24f32c3, Offset: 0xfb0
// Size: 0xda
function teamwithlowestplayercount(playercounts, ignore_team) {
    count = 9999;
    lowest_team = undefined;
    foreach (team in level.teams) {
        if (count > playercounts[team]) {
            count = playercounts[team];
            lowest_team = team;
        }
    }
    return lowest_team;
}

// Namespace globallogic_ui
// Params 1, eflags: 0x1 linked
// Checksum 0xf699c3c7, Offset: 0x1098
// Size: 0x36c
function menuautoassign(comingfrommenu) {
    teamkeys = getarraykeys(level.teams);
    assignment = teamkeys[randomint(teamkeys.size)];
    self closemenus();
    assignment = "allies";
    if (level.teambased) {
        if (self.sessionstate == "playing" || assignment == self.pers["team"] && self.sessionstate == "dead") {
            self beginclasschoice();
            return;
        }
    } else if (getdvarint("party_autoteams") == 1) {
        if (!self.hasspawned && (level.allow_teamchange != "1" || !comingfrommenu)) {
            team = getassignedteam(self);
            if (isdefined(level.teams[team])) {
                assignment = team;
            } else if (team == "spectator" && !level.forceautoassign) {
                self setclientscriptmainmenu(game["menu_start_menu"]);
                return;
            }
        }
    }
    if (self.sessionstate == "playing" || assignment != self.pers["team"] && self.sessionstate == "dead") {
        self.switching_teams = 1;
        self.switchedteamsresetgadgets = 1;
        self.joining_team = assignment;
        self.leaving_team = self.pers["team"];
        self suicide();
    }
    self.pers["team"] = assignment;
    self.team = assignment;
    self.pers["class"] = undefined;
    self.curclass = undefined;
    self.pers["weapon"] = undefined;
    self.pers["savedmodel"] = undefined;
    self updateobjectivetext();
    self.sessionteam = assignment;
    if (!isalive(self)) {
        self.statusicon = "hud_status_dead";
    }
    self notify(#"joined_team");
    level notify(#"joined_team");
    callback::callback(#"hash_95a6c4c0");
    self notify(#"end_respawn");
    self beginclasschoice();
    self setclientscriptmainmenu(game["menu_start_menu"]);
}

// Namespace globallogic_ui
// Params 0, eflags: 0x1 linked
// Checksum 0xce8abee3, Offset: 0x1410
// Size: 0xce
function teamscoresequal() {
    score = undefined;
    foreach (team in level.teams) {
        if (!isdefined(score)) {
            score = getteamscore(team);
            continue;
        }
        if (score != getteamscore(team)) {
            return false;
        }
    }
    return true;
}

// Namespace globallogic_ui
// Params 0, eflags: 0x1 linked
// Checksum 0x5a41cf0, Offset: 0x14e8
// Size: 0xc4
function teamwithlowestscore() {
    score = 99999999;
    lowest_team = undefined;
    foreach (team in level.teams) {
        if (score > getteamscore(team)) {
            lowest_team = team;
        }
    }
    return lowest_team;
}

// Namespace globallogic_ui
// Params 1, eflags: 0x0
// Checksum 0x5808531b, Offset: 0x15b8
// Size: 0x74
function pickteamfromscores(teams) {
    assignment = "allies";
    if (teamscoresequal()) {
        assignment = teams[randomint(teams.size)];
    } else {
        assignment = teamwithlowestscore();
    }
    return assignment;
}

// Namespace globallogic_ui
// Params 0, eflags: 0x0
// Checksum 0x36a9d295, Offset: 0x1638
// Size: 0xce
function get_splitscreen_team() {
    for (index = 0; index < level.players.size; index++) {
        if (!isdefined(level.players[index])) {
            continue;
        }
        if (level.players[index] == self) {
            continue;
        }
        if (!self isplayeronsamemachine(level.players[index])) {
            continue;
        }
        team = level.players[index].sessionteam;
        if (team != "spectator") {
            return team;
        }
    }
    return "";
}

// Namespace globallogic_ui
// Params 0, eflags: 0x1 linked
// Checksum 0x9c684ea2, Offset: 0x1710
// Size: 0xd4
function updateobjectivetext() {
    if (sessionmodeiszombiesgame() || self.pers["team"] == "spectator") {
        self setclientcgobjectivetext("");
        return;
    }
    if (level.scorelimit > 0) {
        self setclientcgobjectivetext(util::getobjectivescoretext(self.pers["team"]));
        return;
    }
    self setclientcgobjectivetext(util::getobjectivetext(self.pers["team"]));
}

// Namespace globallogic_ui
// Params 0, eflags: 0x1 linked
// Checksum 0x2117fdcb, Offset: 0x17f0
// Size: 0x1c
function closemenus() {
    self closeingamemenu();
}

// Namespace globallogic_ui
// Params 0, eflags: 0x1 linked
// Checksum 0x36e13dad, Offset: 0x1818
// Size: 0x2ac
function beginclasschoice() {
    assert(isdefined(level.teams[self.pers["<dev string:x28>"]]));
    team = self.pers["team"];
    self closemenu(game["menu_start_menu"]);
    if (!getdvarint("art_review", 0)) {
        self thread function_b381d26();
    }
    var_54fdb1d6 = getdvarint("force_no_cac", 0);
    if (!getdvarint("force_cac", 0) || var_54fdb1d6) {
        prevclass = self savegame::function_36adbb9c("playerClass", undefined);
        var_d47d35d1 = self savegame::function_36adbb9c(savegame::function_1bfdd60e() + "hero_weapon", undefined);
        if (isdefined(self.disableclassselection) && (isdefined(level.disableclassselection) && (isdefined(prevclass) || var_54fdb1d6 || level.disableclassselection) || self.disableclassselection) || getdvarint("migration_soak") == 1) {
            self.curclass = isdefined(prevclass) ? prevclass : level.defaultclass;
            self.pers["class"] = self.curclass;
            wait 0.05;
            if (self.sessionstate != "playing" && game["state"] == "playing") {
                self thread [[ level.spawnclient ]]();
            }
            globallogic::updateteamstatus();
            self thread spectating::set_permissions_for_machine();
            return;
        }
    }
    self closemenu(game["menu_changeclass"]);
    self openmenu(game["menu_changeclass_" + team]);
}

// Namespace globallogic_ui
// Params 0, eflags: 0x1 linked
// Checksum 0x4d37e32b, Offset: 0x1ad0
// Size: 0x38c
function function_b381d26() {
    self endon(#"disconnect");
    util::show_hud(0);
    self closemenu("InitialBlack");
    self openmenu("InitialBlack");
    var_e90e1424 = 0;
    if (level flag::get("all_players_spawned")) {
        var_e90e1424 = 1;
    }
    self.var_6c56bb = 1;
    self thread function_e185d3f4();
    self hide();
    wait 0.05;
    if (isdefined(level.var_d83bc14d) || isdefined(level.var_8f7c5cd0)) {
        function_bf7a95e2();
        self thread function_52326035();
        if (isdefined(level.var_d83bc14d)) {
            level flag::wait_till(level.var_d83bc14d);
        }
        if (isdefined(level.var_8f7c5cd0)) {
            self flag::wait_till(level.var_8f7c5cd0);
        }
    }
    if (var_e90e1424 && !(isdefined(level.is_safehouse) && level.is_safehouse)) {
        while (self.sessionstate !== "playing") {
            wait 0.05;
        }
        self thread function_52326035();
        while (self isloadingcinematicplaying()) {
            wait 0.05;
        }
        self flag::wait_till("loadout_given");
        waittillframeend();
        wait 2;
        self util::streamer_wait(undefined, 5, 5);
        self thread lui::screen_fade_in(0.3, "black", "hot_join");
    }
    if (!flagsys::get("shared_igc")) {
        self show();
    }
    self flagsys::set("kill_fullscreen_black");
    self clientfield::set_to_player("sndLevelStartSnapOff", 1);
    self closemenu("InitialBlack");
    self.var_6c56bb = undefined;
    util::show_hud(1);
    /#
        printtoprightln("<dev string:x2d>" + gettime() + "<dev string:x2f>" + self getentitynumber(), (1, 1, 1));
        streamerskiptodebug(getskiptos());
    #/
}

// Namespace globallogic_ui
// Params 0, eflags: 0x1 linked
// Checksum 0x18bec12f, Offset: 0x1e68
// Size: 0x8c
function function_e185d3f4() {
    self endon(#"disconnect");
    self endon(#"kill_fullscreen_black");
    var_67fa9f87 = self.var_6c56bb;
    level waittill(#"save_restore");
    if (isdefined(var_67fa9f87) && var_67fa9f87) {
        self closemenu("InitialBlack");
        self openmenu("InitialBlack");
    }
}

// Namespace globallogic_ui
// Params 0, eflags: 0x1 linked
// Checksum 0x4705f18a, Offset: 0x1f00
// Size: 0x94
function function_bf7a95e2() {
    if (isdefined(level.var_8f7c5cd0) && !self flag::exists(level.var_8f7c5cd0)) {
        self flag::init(level.var_8f7c5cd0);
    }
    if (isdefined(level.var_d83bc14d) && !level flag::exists(level.var_d83bc14d)) {
        level flag::init(level.var_d83bc14d);
    }
}

// Namespace globallogic_ui
// Params 0, eflags: 0x1 linked
// Checksum 0x45100f1c, Offset: 0x1fa0
// Size: 0xfe
function function_52326035() {
    self endon(#"disconnect");
    self.var_b41cccf7 = 1;
    self flagsys::wait_till("loadout_given");
    self disableweapons();
    self freezecontrols(1);
    wait 0.1;
    waittillframeend();
    self freezecontrols(1);
    self disableweapons();
    self flagsys::wait_till("kill_fullscreen_black");
    self enableweapons();
    self freezecontrols(0);
    self.var_b41cccf7 = undefined;
}

// Namespace globallogic_ui
// Params 0, eflags: 0x1 linked
// Checksum 0x40f1396b, Offset: 0x20a8
// Size: 0x74
function showmainmenuforteam() {
    assert(isdefined(level.teams[self.pers["<dev string:x28>"]]));
    team = self.pers["team"];
    self openmenu(game["menu_changeclass_" + team]);
}

// Namespace globallogic_ui
// Params 1, eflags: 0x1 linked
// Checksum 0x26219d3c, Offset: 0x2128
// Size: 0x234
function menuteam(team) {
    self closemenus();
    if (isdefined(self.hasdonecombat) && !level.console && level.allow_teamchange == "0" && self.hasdonecombat) {
        return;
    }
    if (self.pers["team"] != team) {
        if (!isdefined(self.hasdonecombat) || level.ingraceperiod && !self.hasdonecombat) {
            self.hasspawned = 0;
        }
        if (self.sessionstate == "playing") {
            self.switching_teams = 1;
            self.switchedteamsresetgadgets = 1;
            self.joining_team = team;
            self.leaving_team = self.pers["team"];
            self suicide();
        }
        self.pers["team"] = team;
        self.team = team;
        self.pers["class"] = undefined;
        self.curclass = undefined;
        self.pers["weapon"] = undefined;
        self.pers["savedmodel"] = undefined;
        self updateobjectivetext();
        if (!level.rankedmatch && !level.leaguematch) {
            self.sessionstate = "spectator";
        }
        self.sessionteam = team;
        self setclientscriptmainmenu(game["menu_start_menu"]);
        self notify(#"joined_team");
        level notify(#"joined_team");
        callback::callback(#"hash_95a6c4c0");
        self notify(#"end_respawn");
    }
    self beginclasschoice();
}

// Namespace globallogic_ui
// Params 0, eflags: 0x1 linked
// Checksum 0x804ed8a2, Offset: 0x2368
// Size: 0x1a4
function menuspectator() {
    self closemenus();
    if (self.pers["team"] != "spectator") {
        if (isalive(self)) {
            self.switching_teams = 1;
            self.switchedteamsresetgadgets = 1;
            self.joining_team = "spectator";
            self.leaving_team = self.pers["team"];
            self suicide();
        }
        self.pers["team"] = "spectator";
        self.team = "spectator";
        self.pers["class"] = undefined;
        self.curclass = undefined;
        self.pers["weapon"] = undefined;
        self.pers["savedmodel"] = undefined;
        self updateobjectivetext();
        self.sessionteam = "spectator";
        [[ level.spawnspectator ]]();
        self thread globallogic_player::spectate_player_watcher();
        self setclientscriptmainmenu(game["menu_start_menu"]);
        self notify(#"joined_spectators");
        callback::callback(#"hash_4c5ae192");
    }
}

// Namespace globallogic_ui
// Params 1, eflags: 0x1 linked
// Checksum 0xa546881a, Offset: 0x2518
// Size: 0x68a
function menuclass(response) {
    self closemenus();
    if (!isdefined(self.pers["team"]) || !isdefined(level.teams[self.pers["team"]])) {
        return;
    }
    if (flagsys::get("mobile_armory_in_use")) {
        return;
    }
    playerclass = "";
    if (response == "cancel") {
        prevclass = self savegame::function_36adbb9c("playerClass", undefined);
        if (isdefined(prevclass)) {
            playerclass = prevclass;
        } else {
            playerclass = level.defaultclass;
        }
    } else {
        var_5dc22ce3 = strtok(response, ",");
        if (var_5dc22ce3.size > 1) {
            var_bd5d3f48 = var_5dc22ce3[0];
            clientnum = int(var_5dc22ce3[1]);
            var_5a13c491 = util::getplayerfromclientnum(clientnum);
        } else {
            var_bd5d3f48 = response;
        }
        playerclass = self loadout::getclasschoice(var_bd5d3f48);
        if (isdefined(var_5a13c491)) {
            xuid = var_5a13c491 getxuid();
            self savegame::set_player_data("altPlayerID", xuid);
        } else {
            self savegame::set_player_data("altPlayerID", undefined);
        }
        self savegame::set_player_data("saved_weapon", undefined);
        self savegame::set_player_data("saved_weapondata", undefined);
        self savegame::set_player_data("lives", undefined);
        self savegame::set_player_data("saved_rig1", undefined);
        self savegame::set_player_data("saved_rig1_upgraded", undefined);
        self savegame::set_player_data("saved_rig2", undefined);
        self savegame::set_player_data("saved_rig2_upgraded", undefined);
    }
    if (isdefined(self.pers["class"]) && self.pers["class"] == playerclass) {
        return;
    }
    self.pers["changed_class"] = 1;
    self notify(#"changed_class");
    waittillframeend();
    if (isdefined(self.curclass) && self.curclass == playerclass) {
        self.pers["changed_class"] = 0;
    }
    if (self.sessionstate == "playing") {
        self savegame::set_player_data("playerClass", playerclass);
        self.pers["class"] = playerclass;
        self.curclass = playerclass;
        self.pers["weapon"] = undefined;
        if (game["state"] == "postgame") {
            return;
        }
        supplystationclasschange = isdefined(self.usingsupplystation) && self.usingsupplystation;
        self.usingsupplystation = 0;
        if (level.ingraceperiod && !self.hasdonecombat || supplystationclasschange) {
            self loadout::setclass(self.pers["class"]);
            self.tag_stowed_back = undefined;
            self.tag_stowed_hip = undefined;
            self loadout::giveloadout(self.pers["team"], self.pers["class"]);
        } else if (!self issplitscreen()) {
            self iprintlnbold(game["strings"]["change_class"]);
        }
    } else {
        self savegame::set_player_data("playerClass", playerclass);
        self.pers["class"] = playerclass;
        self.curclass = playerclass;
        self.pers["weapon"] = undefined;
        if (game["state"] == "postgame") {
            return;
        }
        if (self.sessionstate != "spectator") {
            if (self isinvehicle()) {
                return;
            }
            if (self isremotecontrolling()) {
                return;
            }
            if (self isweaponviewonlylinked()) {
                return 0;
            }
        }
        if (game["state"] == "playing") {
            timepassed = undefined;
            if (isdefined(self.respawntimerstarttime)) {
                timepassed = (gettime() - self.respawntimerstarttime) / 1000;
            }
            self thread [[ level.spawnclient ]](timepassed);
            self.respawntimerstarttime = undefined;
        }
    }
    globallogic::updateteamstatus();
    self thread spectating::set_permissions_for_machine();
    self notify(#"hash_92c7ed2a");
}

// Namespace globallogic_ui
// Params 1, eflags: 0x1 linked
// Checksum 0xd160de01, Offset: 0x2bb0
// Size: 0x44
function removespawnmessageshortly(delay) {
    self endon(#"disconnect");
    waittillframeend();
    self endon(#"end_respawn");
    wait delay;
    self util::clearlowermessage(2);
}

// Namespace globallogic_ui
// Params 1, eflags: 0x1 linked
// Checksum 0x39576679, Offset: 0x2c00
// Size: 0x108
function function_c1f135ab(var_6f7b69cd) {
    self endon(#"death");
    self endon(#"hash_94f19cd5");
    while (true) {
        bonename, event = self waittill(#"weakpoint_update");
        if (bonename == var_6f7b69cd) {
            if (event == "damage") {
                luinotifyevent(%weakpoint_update, 3, 2, self getentitynumber(), var_6f7b69cd);
            } else if (event == "repulse") {
                luinotifyevent(%weakpoint_update, 3, 3, self getentitynumber(), var_6f7b69cd);
            }
            wait 0.5;
        }
    }
}

// Namespace globallogic_ui
// Params 1, eflags: 0x1 linked
// Checksum 0xc7a0998f, Offset: 0x2d10
// Size: 0x4a
function function_d66e4079(var_6f7b69cd) {
    luinotifyevent(%weakpoint_update, 3, 0, self getentitynumber(), var_6f7b69cd);
    self notify(#"hash_94f19cd5");
}

// Namespace globallogic_ui
// Params 3, eflags: 0x1 linked
// Checksum 0x148772b, Offset: 0x2d68
// Size: 0xec
function function_8ee5a301(var_6f7b69cd, closestatemaxdistance, mediumstatemaxdistance) {
    if (!isdefined(closestatemaxdistance)) {
        closestatemaxdistance = undefined;
    }
    if (!isdefined(mediumstatemaxdistance)) {
        mediumstatemaxdistance = undefined;
    }
    if (!isdefined(closestatemaxdistance)) {
        closestatemaxdistance = getdvarint("ui_weakpointIndicatorNear", 1050);
    }
    if (!isdefined(mediumstatemaxdistance)) {
        mediumstatemaxdistance = getdvarint("ui_weakpointIndicatorMedium", 1900);
    }
    luinotifyevent(%weakpoint_update, 5, 1, self getentitynumber(), var_6f7b69cd, closestatemaxdistance, mediumstatemaxdistance);
    self thread function_c1f135ab(var_6f7b69cd);
}

// Namespace globallogic_ui
// Params 1, eflags: 0x1 linked
// Checksum 0xec2a034d, Offset: 0x2e60
// Size: 0x26
function function_2d11c5e4(var_6f7b69cd) {
    self notify(#"weakpoint_update", var_6f7b69cd, "damage");
}

// Namespace globallogic_ui
// Params 1, eflags: 0x0
// Checksum 0xa0e41bc5, Offset: 0x2e90
// Size: 0x26
function function_8c6f9f69(var_6f7b69cd) {
    self notify(#"weakpoint_update", var_6f7b69cd, "repulse");
}

