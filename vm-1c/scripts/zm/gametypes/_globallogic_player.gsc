#using scripts/zm/_zm_stats;
#using scripts/zm/_util;
#using scripts/zm/_challenges;
#using scripts/zm/gametypes/_weapons;
#using scripts/zm/gametypes/_spectating;
#using scripts/zm/gametypes/_spawnlogic;
#using scripts/zm/gametypes/_spawning;
#using scripts/zm/gametypes/_hostmigration;
#using scripts/zm/gametypes/_globallogic_utils;
#using scripts/zm/gametypes/_globallogic_ui;
#using scripts/zm/gametypes/_globallogic_spawn;
#using scripts/zm/gametypes/_globallogic_score;
#using scripts/zm/gametypes/_globallogic_audio;
#using scripts/zm/gametypes/_globallogic;
#using scripts/zm/gametypes/_damagefeedback;
#using scripts/shared/weapons/_weapon_utils;
#using scripts/shared/weapons_shared;
#using scripts/shared/util_shared;
#using scripts/shared/tweakables_shared;
#using scripts/shared/math_shared;
#using scripts/shared/hud_util_shared;
#using scripts/shared/hud_message_shared;
#using scripts/shared/flagsys_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/demo_shared;
#using scripts/shared/challenges_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/abilities/_ability_power;
#using scripts/codescripts/struct;

#namespace globallogic_player;

// Namespace globallogic_player
// Params 0, eflags: 0x1 linked
// Checksum 0xe39323dc, Offset: 0xed8
// Size: 0x4c
function freezeplayerforroundend() {
    self util::clearlowermessage();
    self closeingamemenu();
    self util::freeze_player_controls(1);
}

// Namespace globallogic_player
// Params 0, eflags: 0x1 linked
// Checksum 0x3035529f, Offset: 0xf30
// Size: 0xedc
function callback_playerconnect() {
    thread notifyconnecting();
    self.statusicon = "hud_status_connecting";
    self waittill(#"begin");
    if (isdefined(level.reset_clientdvars)) {
        self [[ level.reset_clientdvars ]]();
    }
    waittillframeend();
    self.statusicon = "";
    self.guid = self getguid();
    profilelog_begintiming(4, "ship");
    level notify(#"connected", self);
    if (self ishost()) {
        self thread globallogic::listenforgameend();
    }
    if (!level.splitscreen && !isdefined(self.pers["score"])) {
        iprintln(%MP_CONNECTED, self);
    }
    if (!isdefined(self.pers["score"])) {
        self thread zm_stats::adjustrecentstats();
    }
    if (gamemodeismode(0) && !isdefined(self.pers["matchesPlayedStatsTracked"])) {
        gamemode = util::getcurrentgamemode();
        self globallogic::incrementmatchcompletionstat(gamemode, "played", "started");
        if (!isdefined(self.pers["matchesHostedStatsTracked"]) && self islocaltohost()) {
            self globallogic::incrementmatchcompletionstat(gamemode, "hosted", "started");
            self.pers["matchesHostedStatsTracked"] = 1;
        }
        self.pers["matchesPlayedStatsTracked"] = 1;
        self thread zm_stats::uploadstatssoon();
    }
    lpselfnum = self getentitynumber();
    lpguid = self getguid();
    lpxuid = self getxuid(1);
    logprint("J;" + lpguid + ";" + lpselfnum + ";" + self.name + "\n");
    bbprint("global_joins", "name %s client %s xuid %s", self.name, lpselfnum, lpxuid);
    if (!sessionmodeiszombiesgame()) {
        self setclientuivisibilityflag("hud_visible", 1);
        self setclientuivisibilityflag("weapon_hud_visible", 1);
    }
    if (level.forceradar == 1) {
        self.pers["hasRadar"] = 1;
        self.hasspyplane = 1;
        level.activeuavs[self getentitynumber()] = 1;
    }
    if (level.forceradar == 2) {
        self setclientuivisibilityflag("g_compassShowEnemies", level.forceradar);
    } else {
        self setclientuivisibilityflag("g_compassShowEnemies", 0);
    }
    self setclientplayersprinttime(level.playersprinttime);
    self setclientnumlives(level.numlives);
    if (level.hardcoremode) {
        self setclientdrawtalk(3);
    }
    self [[ level.player_stats_init ]]();
    self.killedplayerscurrent = [];
    if (!isdefined(self.pers["best_kill_streak"])) {
        self.pers["killed_players"] = [];
        self.pers["killed_by"] = [];
        self.pers["nemesis_tracking"] = [];
        self.pers["artillery_kills"] = 0;
        self.pers["dog_kills"] = 0;
        self.pers["nemesis_name"] = "";
        self.pers["nemesis_rank"] = 0;
        self.pers["nemesis_rankIcon"] = 0;
        self.pers["nemesis_xp"] = 0;
        self.pers["nemesis_xuid"] = "";
        self.pers["best_kill_streak"] = 0;
    }
    if (!isdefined(self.pers["music"])) {
        self.pers["music"] = spawnstruct();
        self.pers["music"].spawn = 0;
        self.pers["music"].inque = 0;
        self.pers["music"].currentstate = "SILENT";
        self.pers["music"].previousstate = "SILENT";
        self.pers["music"].nextstate = "UNDERSCORE";
        self.pers["music"].returnstate = "UNDERSCORE";
    }
    self.leaderdialogqueue = [];
    self.leaderdialogactive = 0;
    self.leaderdialoggroups = [];
    self.currentleaderdialoggroup = "";
    self.currentleaderdialog = "";
    self.currentleaderdialogtime = 0;
    if (!isdefined(self.pers["cur_kill_streak"])) {
        self.pers["cur_kill_streak"] = 0;
    }
    if (!isdefined(self.pers["cur_total_kill_streak"])) {
        self.pers["cur_total_kill_streak"] = 0;
        self setplayercurrentstreak(0);
    }
    if (!isdefined(self.pers["totalKillstreakCount"])) {
        self.pers["totalKillstreakCount"] = 0;
    }
    if (!isdefined(self.pers["killstreaksEarnedThisKillstreak"])) {
        self.pers["killstreaksEarnedThisKillstreak"] = 0;
    }
    if (isdefined(level.usingscorestreaks) && level.usingscorestreaks && !isdefined(self.pers["killstreak_quantity"])) {
        self.pers["killstreak_quantity"] = [];
    }
    if (isdefined(level.usingscorestreaks) && level.usingscorestreaks && !isdefined(self.pers["held_killstreak_ammo_count"])) {
        self.pers["held_killstreak_ammo_count"] = [];
    }
    self.lastkilltime = 0;
    self.cur_death_streak = 0;
    self disabledeathstreak();
    self.death_streak = 0;
    self.kill_streak = 0;
    self.gametype_kill_streak = 0;
    self.spawnqueueindex = -1;
    self.deathtime = 0;
    self.lastgrenadesuicidetime = -1;
    self.teamkillsthisround = 0;
    if (!isdefined(level.livesdonotreset) || !level.livesdonotreset || !isdefined(self.pers["lives"])) {
        self.pers["lives"] = level.numlives;
    }
    if (!level.teambased) {
        self.pers["team"] = undefined;
    }
    self.hasspawned = 0;
    self.waitingtospawn = 0;
    self.wantsafespawn = 0;
    self.deathcount = 0;
    self.wasaliveatmatchstart = 0;
    level.players[level.players.size] = self;
    if (level.splitscreen) {
        setdvar("splitscreen_playerNum", level.players.size);
    }
    if (game["state"] == "postgame") {
        self.pers["needteam"] = 1;
        self.pers["team"] = "spectator";
        self.team = "spectator";
        self.sessionteam = "spectator";
        self setclientuivisibilityflag("hud_visible", 0);
        self [[ level.spawnintermission ]]();
        self closeingamemenu();
        profilelog_endtiming(4, "gs=" + game["state"] + " zom=" + sessionmodeiszombiesgame());
        return;
    }
    level endon(#"game_ended");
    if (isdefined(level.hostmigrationtimer)) {
        self thread hostmigration::hostmigrationtimerthink();
    }
    if (level.oldschool) {
        self.pers["class"] = undefined;
        self.curclass = self.pers["class"];
    }
    if (isdefined(self.pers["team"])) {
        self.team = self.pers["team"];
    }
    if (isdefined(self.pers["class"])) {
        self.curclass = self.pers["class"];
    }
    if (!isdefined(self.pers["team"]) || isdefined(self.pers["needteam"])) {
        self.pers["needteam"] = undefined;
        self.pers["team"] = "spectator";
        self.team = "spectator";
        self.sessionstate = "dead";
        self globallogic_ui::updateobjectivetext();
        [[ level.spawnspectator ]]();
        if (level.rankedmatch) {
            [[ level.autoassign ]](0);
            self thread globallogic_spawn::kickifdontspawn();
        } else {
            [[ level.autoassign ]](0);
        }
        if (self.pers["team"] == "spectator") {
            self.sessionteam = "spectator";
            self thread spectate_player_watcher();
        }
        if (level.teambased) {
            self.sessionteam = self.pers["team"];
            if (!isalive(self)) {
                self.statusicon = "hud_status_dead";
            }
            self thread spectating::setspectatepermissions();
        }
    } else if (self.pers["team"] == "spectator") {
        self setclientscriptmainmenu(game["menu_start_menu"]);
        [[ level.spawnspectator ]]();
        self.sessionteam = "spectator";
        self.sessionstate = "spectator";
        self thread spectate_player_watcher();
    } else {
        self.sessionteam = self.pers["team"];
        self.sessionstate = "dead";
        self globallogic_ui::updateobjectivetext();
        [[ level.spawnspectator ]]();
        if (globallogic_utils::isvalidclass(self.pers["class"])) {
            self thread [[ level.spawnclient ]]();
        } else {
            self globallogic_ui::showmainmenuforteam();
        }
        self thread spectating::setspectatepermissions();
    }
    if (self.sessionteam != "spectator") {
        self thread spawning::onspawnplayer_unified(1);
    }
    profilelog_endtiming(4, "gs=" + game["state"] + " zom=" + sessionmodeiszombiesgame());
}

// Namespace globallogic_player
// Params 0, eflags: 0x1 linked
// Checksum 0x4944200e, Offset: 0x1e18
// Size: 0x264
function spectate_player_watcher() {
    self endon(#"disconnect");
    self.watchingactiveclient = 1;
    self.var_f2e9a21a = undefined;
    while (true) {
        if (self.pers["team"] != "spectator" || level.gameended) {
            self hud_message::function_b17b90b9();
            self freezecontrols(0);
            self.watchingactiveclient = 0;
            break;
        }
        if (!level.splitscreen && !level.hardcoremode && getdvarint("scr_showperksonspawn") == 1 && game["state"] != "postgame" && !isdefined(self.perkhudelem)) {
            if (level.perksenabled == 1) {
                self hud::showperks();
            }
        }
        count = 0;
        for (i = 0; i < level.players.size; i++) {
            if (level.players[i].team != "spectator") {
                count++;
                break;
            }
        }
        if (count > 0) {
            if (!self.watchingactiveclient) {
                self hud_message::function_b17b90b9();
                self freezecontrols(0);
                println("<dev string:x28>");
            }
            self.watchingactiveclient = 1;
        } else {
            if (self.watchingactiveclient) {
                [[ level.onspawnspectator ]]();
                self freezecontrols(1);
                self hud_message::function_b5203d90();
            }
            self.watchingactiveclient = 0;
        }
        wait 0.5;
    }
}

// Namespace globallogic_player
// Params 0, eflags: 0x1 linked
// Checksum 0x25a445ba, Offset: 0x2088
// Size: 0xd2
function callback_playermigrated() {
    println("<dev string:x3d>" + self.name + "<dev string:x45>" + gettime());
    if (isdefined(self.connected) && self.connected) {
        self globallogic_ui::updateobjectivetext();
    }
    self thread inform_clientvm_of_migration();
    level.hostmigrationreturnedplayercount++;
    if (level.hostmigrationreturnedplayercount >= level.players.size * 2 / 3) {
        println("<dev string:x62>");
        level notify(#"hostmigration_enoughplayers");
    }
}

// Namespace globallogic_player
// Params 0, eflags: 0x1 linked
// Checksum 0xe19d8071, Offset: 0x2168
// Size: 0x34
function inform_clientvm_of_migration() {
    self endon(#"disconnect");
    wait 1;
    self util::clientnotify("hmo");
}

// Namespace globallogic_player
// Params 1, eflags: 0x1 linked
// Checksum 0xad67cacb, Offset: 0x21a8
// Size: 0x8c
function arraytostring(inputarray) {
    targetstring = "";
    for (i = 0; i < inputarray.size; i++) {
        targetstring += inputarray[i];
        if (i != inputarray.size - 1) {
            targetstring += ",";
        }
    }
    return targetstring;
}

// Namespace globallogic_player
// Params 2, eflags: 0x1 linked
// Checksum 0xa63f1836, Offset: 0x2240
// Size: 0x564
function function_e20b6fc7(player, result) {
    lpselfnum = player getentitynumber();
    lpxuid = player getxuid(1);
    bbprint("global_leave", "name %s client %s xuid %s", player.name, lpselfnum, lpxuid);
    primaryweaponname = "";
    primaryweaponattachstr = "";
    secondaryweaponname = "";
    secondaryweaponattachstr = "";
    if (isdefined(player.primaryloadoutweapon)) {
        primaryweaponname = player.primaryloadoutweapon.name;
        primaryweaponattachstr = arraytostring(getarraykeys(player.primaryloadoutweapon.attachments));
    }
    if (isdefined(player.secondaryloadoutweapon)) {
        secondaryweaponname = player.secondaryloadoutweapon.name;
        secondaryweaponattachstr = arraytostring(getarraykeys(player.secondaryloadoutweapon.attachments));
    }
    resultstr = result;
    if (isdefined(player.team) && result == player.team) {
        resultstr = "win";
    } else if (result == "allies" || result == "axis") {
        resultstr = "lose";
    }
    timeplayed = game["timepassed"] / 1000;
    recordcomscoreevent("end_match", "match_id", getdemofileid(), "game_variant", "zm", "game_mode", level.gametype, "game_playlist", "N/A", "private_match", sessionmodeisprivate(), "game_map", getdvarstring("mapname"), "player_xuid", player getxuid(1), "player_ip", player getipaddress(), "match_kills", player.kills, "match_deaths", player.deaths, "match_score", player.score, "match_streak", player.pers["best_kill_streak"], "match_captures", player.pers["captures"], "match_defends", player.pers["defends"], "match_headshots", player.pers["headshots"], "match_longshots", player.pers["longshots"], "prestige_max", player.pers["plevel"], "level_max", player.pers["rank"], "match_result", resultstr, "season_pass_owned", player hasseasonpass(0), "match_hits", player.shotshit, "player_gender", player getplayergendertype(currentsessionmode()), "money", player.score, "zombie_waves", level.round_number, "revives", player.pers["revives"], "doors", player.pers["doors_purchased"], "downs", player.pers["downs"], "loadout_primary_weapon", primaryweaponname, "loadout_secondary_weapon", secondaryweaponname, "loadout_primary_attachments", primaryweaponattachstr, "loadout_secondary_attachments", secondaryweaponattachstr, "dlc_owned", player getdlcavailable(), "match_duration", timeplayed);
}

// Namespace globallogic_player
// Params 0, eflags: 0x1 linked
// Checksum 0x2344ffbb, Offset: 0x27b0
// Size: 0x52c
function callback_playerdisconnect() {
    profilelog_begintiming(5, "ship");
    if (game["state"] != "postgame" && !level.gameended) {
        gamelength = globallogic::getgamelength();
        self globallogic::bbplayermatchend(gamelength, "MP_PLAYER_DISCONNECT", 0);
    }
    arrayremovevalue(level.players, self);
    if (level.splitscreen) {
        players = level.players;
        if (players.size <= 1) {
            level thread globallogic::forceend();
        }
        setdvar("splitscreen_playerNum", players.size);
    }
    if (isdefined(self.score) && isdefined(self.pers["team"])) {
        /#
            print("<dev string:x89>" + self.pers["<dev string:x96>"] + "<dev string:x9b>" + self.score);
        #/
        level.dropteam += 1;
    }
    [[ level.onplayerdisconnect ]]();
    lpselfnum = self getentitynumber();
    lpguid = self getguid();
    logprint("Q;" + lpguid + ";" + lpselfnum + ";" + self.name + "\n");
    function_e20b6fc7(self, "disconnected");
    for (entry = 0; entry < level.players.size; entry++) {
        if (level.players[entry] == self) {
            while (entry < level.players.size - 1) {
                level.players[entry] = level.players[entry + 1];
                entry++;
            }
            level.players[entry] = undefined;
            break;
        }
    }
    for (entry = 0; entry < level.players.size; entry++) {
        if (isdefined(level.players[entry].pers["killed_players"][self.name])) {
            level.players[entry].pers["killed_players"][self.name] = undefined;
        }
        if (isdefined(level.players[entry].killedplayerscurrent[self.name])) {
            level.players[entry].killedplayerscurrent[self.name] = undefined;
        }
        if (isdefined(level.players[entry].pers["killed_by"][self.name])) {
            level.players[entry].pers["killed_by"][self.name] = undefined;
        }
        if (isdefined(level.players[entry].pers["nemesis_tracking"][self.name])) {
            level.players[entry].pers["nemesis_tracking"][self.name] = undefined;
        }
        if (level.players[entry].pers["nemesis_name"] == self.name) {
            level.players[entry] choosenextbestnemesis();
        }
    }
    if (level.gameended) {
        self globallogic::removedisconnectedplayerfromplacement();
    }
    level thread globallogic::updateteamstatus();
    profilelog_endtiming(5, "gs=" + game["state"] + " zom=" + sessionmodeiszombiesgame());
}

// Namespace globallogic_player
// Params 8, eflags: 0x1 linked
// Checksum 0xa5f27b4b, Offset: 0x2ce8
// Size: 0xc4
function callback_playermelee(eattacker, idamage, weapon, vorigin, vdir, boneindex, shieldhit, frombehind) {
    hit = 1;
    if (level.teambased && self.team == eattacker.team) {
        if (level.friendlyfire == 0) {
            hit = 0;
        }
    }
    self finishmeleehit(eattacker, weapon, vorigin, vdir, boneindex, shieldhit, hit, frombehind);
}

// Namespace globallogic_player
// Params 0, eflags: 0x1 linked
// Checksum 0xdd76d4a8, Offset: 0x2db8
// Size: 0x242
function choosenextbestnemesis() {
    nemesisarray = self.pers["nemesis_tracking"];
    nemesisarraykeys = getarraykeys(nemesisarray);
    nemesisamount = 0;
    nemesisname = "";
    if (nemesisarraykeys.size > 0) {
        for (i = 0; i < nemesisarraykeys.size; i++) {
            nemesisarraykey = nemesisarraykeys[i];
            if (nemesisarray[nemesisarraykey] > nemesisamount) {
                nemesisname = nemesisarraykey;
                nemesisamount = nemesisarray[nemesisarraykey];
            }
        }
    }
    self.pers["nemesis_name"] = nemesisname;
    if (nemesisname != "") {
        for (playerindex = 0; playerindex < level.players.size; playerindex++) {
            if (level.players[playerindex].name == nemesisname) {
                nemesisplayer = level.players[playerindex];
                self.pers["nemesis_rank"] = nemesisplayer.pers["rank"];
                self.pers["nemesis_rankIcon"] = nemesisplayer.pers["rankxp"];
                self.pers["nemesis_xp"] = nemesisplayer.pers["prestige"];
                self.pers["nemesis_xuid"] = nemesisplayer getxuid();
                break;
            }
        }
        return;
    }
    self.pers["nemesis_xuid"] = "";
}

// Namespace globallogic_player
// Params 7, eflags: 0x1 linked
// Checksum 0xd2f7434a, Offset: 0x3008
// Size: 0xec
function custom_gamemodes_modified_damage(victim, eattacker, idamage, smeansofdeath, weapon, einflictor, shitloc) {
    if (level.onlinegame && !sessionmodeisprivate()) {
        return idamage;
    }
    if (isdefined(eattacker) && isdefined(eattacker.damagemodifier)) {
        idamage *= eattacker.damagemodifier;
    }
    if (smeansofdeath == "MOD_PISTOL_BULLET" || smeansofdeath == "MOD_RIFLE_BULLET") {
        idamage = int(idamage * level.bulletdamagescalar);
    }
    return idamage;
}

// Namespace globallogic_player
// Params 1, eflags: 0x1 linked
// Checksum 0x1f90d744, Offset: 0x3100
// Size: 0x118
function figureoutattacker(eattacker) {
    if (isdefined(eattacker)) {
        if (isai(eattacker) && isdefined(eattacker.script_owner)) {
            team = self.team;
            if (eattacker.script_owner.team != team) {
                eattacker = eattacker.script_owner;
            }
        }
        if (eattacker.classname == "script_vehicle" && isdefined(eattacker.owner)) {
            eattacker = eattacker.owner;
        } else if (eattacker.classname == "auto_turret" && isdefined(eattacker.owner)) {
            eattacker = eattacker.owner;
        }
    }
    return eattacker;
}

// Namespace globallogic_player
// Params 2, eflags: 0x1 linked
// Checksum 0x1b96055e, Offset: 0x3220
// Size: 0xd4
function function_406ab9b7(weapon, einflictor) {
    if (weapon == level.weaponnone && isdefined(einflictor)) {
        if (isdefined(einflictor.targetname) && einflictor.targetname == "explodable_barrel") {
            weapon = getweapon("explodable_barrel");
        } else if (isdefined(einflictor.destructible_type) && issubstr(einflictor.destructible_type, "vehicle_")) {
            weapon = getweapon("destructible_car");
        }
    }
    return weapon;
}

// Namespace globallogic_player
// Params 1, eflags: 0x1 linked
// Checksum 0xe50c55ed, Offset: 0x3300
// Size: 0x12
function figureoutfriendlyfire(victim) {
    return level.friendlyfire;
}

// Namespace globallogic_player
// Params 2, eflags: 0x0
// Checksum 0x90c6f865, Offset: 0x3320
// Size: 0x4e
function function_f698740(eattacker, weapon) {
    if (level.hardcoremode) {
        return 0;
    }
    if (!isdefined(eattacker)) {
        return 0;
    }
    if (self != eattacker) {
        return 0;
    }
    return weapon.donotdamageowner;
}

// Namespace globallogic_player
// Params 11, eflags: 0x1 linked
// Checksum 0x1ca51be0, Offset: 0x3378
// Size: 0xa14
function callback_playerdamage(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex) {
    profilelog_begintiming(6, "ship");
    if (game["state"] == "postgame") {
        return;
    }
    if (self.sessionteam == "spectator") {
        return;
    }
    if (isdefined(self.candocombat) && !self.candocombat) {
        return;
    }
    if (isdefined(eattacker) && isplayer(eattacker) && isdefined(eattacker.candocombat) && !eattacker.candocombat) {
        return;
    }
    if (isdefined(level.hostmigrationtimer)) {
        return;
    }
    if (self.scene_takedamage === 0) {
        return;
    }
    weaponname = weapon.name;
    if ((weaponname == "ai_tank_drone_gun" || weaponname == "ai_tank_drone_rocket") && !level.hardcoremode) {
        if (isdefined(eattacker) && eattacker == self) {
            if (isdefined(einflictor) && isdefined(einflictor.from_ai)) {
                return;
            }
        }
        if (isdefined(eattacker) && isdefined(eattacker.owner) && eattacker.owner == self) {
            return;
        }
    }
    if (weapon.isemp) {
        self notify(#"emp_grenaded", eattacker);
    }
    idamage = custom_gamemodes_modified_damage(self, eattacker, idamage, smeansofdeath, weapon, einflictor, shitloc);
    idamage = int(idamage);
    self.idflags = idflags;
    self.idflagstime = gettime();
    eattacker = figureoutattacker(eattacker);
    pixbeginevent("PlayerDamage flags/tweaks");
    if (!isdefined(vdir)) {
        idflags |= level.idflags_no_knockback;
    }
    friendly = 0;
    if (self.health != self.maxhealth) {
        self notify(#"hash_b6c93e47", smeansofdeath);
    }
    if (isdefined(einflictor) && isdefined(einflictor.script_noteworthy) && einflictor.script_noteworthy == "ragdoll_now") {
        smeansofdeath = "MOD_FALLING";
    }
    if (globallogic_utils::isheadshot(weapon, shitloc, smeansofdeath, einflictor) && isplayer(eattacker)) {
        smeansofdeath = "MOD_HEAD_SHOT";
    }
    if (level.onplayerdamage != &globallogic::blank) {
        modifieddamage = [[ level.onplayerdamage ]](einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime);
        if (isdefined(modifieddamage)) {
            if (modifieddamage <= 0) {
                return;
            }
            idamage = modifieddamage;
        }
    }
    if (level.onlyheadshots) {
        if (smeansofdeath == "MOD_PISTOL_BULLET" || smeansofdeath == "MOD_RIFLE_BULLET") {
            return;
        } else if (smeansofdeath == "MOD_HEAD_SHOT") {
            idamage = -106;
        }
    }
    if (isdefined(eattacker) && isplayer(eattacker) && self.team != eattacker.team) {
        self.lastattackweapon = weapon;
    }
    weapon = function_406ab9b7(weapon, einflictor);
    pixendevent();
    attackerishittingteammate = isplayer(eattacker) && self util::isenemyplayer(eattacker) == 0;
    if (shitloc == "riotshield") {
        if (attackerishittingteammate && level.friendlyfire == 0) {
            return;
        }
        if (smeansofdeath == "MOD_RIFLE_BULLET" && (smeansofdeath == "MOD_PISTOL_BULLET" || !attackerishittingteammate)) {
            previous_shield_damage = self.shielddamageblocked;
            self.shielddamageblocked += idamage;
            if (isplayer(eattacker)) {
                eattacker.lastattackedshieldplayer = self;
                eattacker.lastattackedshieldtime = gettime();
            }
        }
        if (idflags & level.idflags_shield_explosive_impact) {
            shitloc = "none";
            if (!(idflags & level.idflags_shield_explosive_impact_huge)) {
                idamage *= 0;
            }
        } else if (idflags & level.idflags_shield_explosive_splash) {
            if (isdefined(einflictor) && isdefined(einflictor.stucktoplayer) && einflictor.stucktoplayer == self) {
                idamage = 101;
            }
            shitloc = "none";
        } else {
            return;
        }
    }
    if (isdefined(eattacker) && eattacker != self && !friendly) {
        level.usestartspawns = 0;
    }
    pixbeginevent("PlayerDamage log");
    /#
        if (getdvarint("<dev string:x9d>")) {
            println("<dev string:xab>" + self getentitynumber() + "<dev string:xb3>" + self.health + "<dev string:xbc>" + eattacker.clientid + "<dev string:xc7>" + isplayer(einflictor) + "<dev string:xdd>" + idamage + "<dev string:xe6>" + shitloc);
        }
    #/
    if (self.sessionstate != "dead") {
        lpselfnum = self getentitynumber();
        lpselfname = self.name;
        lpselfteam = self.team;
        lpselfguid = self getguid();
        lpattackerteam = "";
        lpattackerorigin = (0, 0, 0);
        if (isplayer(eattacker)) {
            lpattacknum = eattacker getentitynumber();
            lpattackguid = eattacker getguid();
            lpattackname = eattacker.name;
            lpattackerteam = eattacker.team;
            lpattackerorigin = eattacker.origin;
        } else {
            lpattacknum = -1;
            lpattackguid = "";
            lpattackname = "";
            lpattackerteam = "world";
        }
        logprint("D;" + lpselfguid + ";" + lpselfnum + ";" + lpselfteam + ";" + lpselfname + ";" + lpattackguid + ";" + lpattacknum + ";" + lpattackerteam + ";" + lpattackname + ";" + weapon.name + ";" + idamage + ";" + smeansofdeath + ";" + shitloc + "\n");
    }
    pixendevent();
    profilelog_endtiming(6, "gs=" + game["state"] + " zom=" + sessionmodeiszombiesgame());
}

// Namespace globallogic_player
// Params 0, eflags: 0x1 linked
// Checksum 0xdfff2f6c, Offset: 0x3d98
// Size: 0x34
function resetattackerlist() {
    self.attackers = [];
    self.attackerdata = [];
    self.attackerdamage = [];
    self.firsttimedamaged = 0;
}

// Namespace globallogic_player
// Params 4, eflags: 0x0
// Checksum 0xff2ee834, Offset: 0x3dd8
// Size: 0x96
function dodamagefeedback(weapon, einflictor, idamage, smeansofdeath) {
    if (!isdefined(weapon)) {
        return false;
    }
    if (level.allowhitmarkers == 0) {
        return false;
    }
    if (level.allowhitmarkers == 1) {
        if (isdefined(smeansofdeath) && isdefined(idamage)) {
            if (istacticalhitmarker(weapon, smeansofdeath, idamage)) {
                return false;
            }
        }
    }
    return true;
}

// Namespace globallogic_player
// Params 3, eflags: 0x1 linked
// Checksum 0xe212607, Offset: 0x3e78
// Size: 0x80
function istacticalhitmarker(weapon, smeansofdeath, idamage) {
    if (weapons::is_grenade(weapon)) {
        if ("Smoke Grenade" == weapon.offhandclass) {
            if (smeansofdeath == "MOD_GRENADE_SPLASH") {
                return true;
            }
        } else if (idamage == 1) {
            return true;
        }
    }
    return false;
}

// Namespace globallogic_player
// Params 4, eflags: 0x0
// Checksum 0xa000a26d, Offset: 0x3f00
// Size: 0x38
function function_6b151027(player, weapon, smeansofdeath, einflictor) {
    perkfeedback = undefined;
    return perkfeedback;
}

// Namespace globallogic_player
// Params 2, eflags: 0x0
// Checksum 0xa99d0ffe, Offset: 0x3f40
// Size: 0x5c
function isaikillstreakdamage(weapon, einflictor) {
    if (weapon.isaikillstreakdamage) {
        if (weapon.name != "ai_tank_drone_rocket" || isdefined(einflictor.firedbyai)) {
            return true;
        }
    }
    return false;
}

// Namespace globallogic_player
// Params 13, eflags: 0x0
// Checksum 0x2197507d, Offset: 0x3fa8
// Size: 0x25c
function finishplayerdamagewrapper(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, boneindex, vsurfacenormal) {
    pixbeginevent("finishPlayerDamageWrapper");
    if (!level.console && idflags & level.idflags_penetration && isplayer(eattacker)) {
        println("<dev string:xef>" + self getentitynumber() + "<dev string:xb3>" + self.health + "<dev string:xbc>" + eattacker.clientid + "<dev string:xc7>" + isplayer(einflictor) + "<dev string:xdd>" + idamage + "<dev string:xe6>" + shitloc);
        eattacker addplayerstat("penetration_shots", 1);
    }
    if (getdvarstring("scr_csmode") != "") {
        self shellshock("damage", 0.2);
    }
    self damageshellshockandrumble(eattacker, einflictor, weapon, smeansofdeath, idamage);
    self ability_power::power_loss_event_took_damage(eattacker, einflictor, weapon, smeansofdeath, idamage);
    self finishplayerdamage(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, boneindex, vsurfacenormal);
    pixendevent();
}

// Namespace globallogic_player
// Params 1, eflags: 0x1 linked
// Checksum 0xb4a6bb75, Offset: 0x4210
// Size: 0x10
function allowedassistweapon(weapon) {
    return true;
}

// Namespace globallogic_player
// Params 9, eflags: 0x1 linked
// Checksum 0x90c56d44, Offset: 0x4228
// Size: 0x253a
function callback_playerkilled(einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime, deathanimduration) {
    profilelog_begintiming(7, "ship");
    self endon(#"spawned");
    self notify(#"killed_player");
    self flagsys::clear("loadout_given");
    if (self.sessionteam == "spectator") {
        return;
    }
    if (game["state"] == "postgame") {
        return;
    }
    self needsrevive(0);
    if (isdefined(self.burning) && self.burning == 1) {
        self setburn(0);
    }
    self.suicide = 0;
    if (isdefined(level.takelivesondeath) && level.takelivesondeath == 1) {
        if (self.pers["lives"]) {
            self.pers["lives"]--;
            if (self.pers["lives"] == 0) {
                level notify(#"player_eliminated");
                self notify(#"player_eliminated");
            }
        }
    }
    self thread globallogic_audio::function_aa8700b6("item_destroyed");
    weapon = updateweapon(einflictor, weapon);
    pixbeginevent("PlayerKilled pre constants");
    wasinlaststand = 0;
    deathtimeoffset = 0;
    var_a3ad44ab = undefined;
    attackerstance = undefined;
    self.laststandthislife = undefined;
    self.vattackerorigin = undefined;
    if (isdefined(self.uselaststandparams)) {
        self.uselaststandparams = undefined;
        assert(isdefined(self.laststandparams));
        if (!isdefined(attacker) || !isplayer(attacker) || attacker.team != self.team || !level.teambased || attacker == self) {
            einflictor = self.laststandparams.einflictor;
            attacker = self.laststandparams.attacker;
            attackerstance = self.laststandparams.attackerstance;
            idamage = self.laststandparams.idamage;
            smeansofdeath = self.laststandparams.smeansofdeath;
            weapon = self.laststandparams.weapon;
            vdir = self.laststandparams.vdir;
            shitloc = self.laststandparams.shitloc;
            self.vattackerorigin = self.laststandparams.vattackerorigin;
            deathtimeoffset = (gettime() - self.laststandparams.laststandstarttime) / 1000;
            if (isdefined(self.var_54a2d6ec)) {
                wasinlaststand = 1;
                var_a3ad44ab = self.var_54a2d6ec;
            }
        }
        self.laststandparams = undefined;
    }
    bestplayer = undefined;
    bestplayermeansofdeath = undefined;
    obituarymeansofdeath = undefined;
    bestplayerweapon = undefined;
    obituaryweapon = undefined;
    if ((isdefined(attacker.ismagicbullet) && (!isdefined(attacker) || attacker.classname == "trigger_hurt" || attacker.classname == "worldspawn" || attacker.ismagicbullet == 1) || attacker == self) && isdefined(self.attackers)) {
        if (!isdefined(bestplayer)) {
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
                if (self.attackerdamage[player.clientid].lasttimedamaged + 2500 < gettime()) {
                    continue;
                }
                if (!allowedassistweapon(self.attackerdamage[player.clientid].weapon)) {
                    continue;
                }
                if (self.attackerdamage[player.clientid].damage > 1 && !isdefined(bestplayer)) {
                    bestplayer = player;
                    bestplayermeansofdeath = self.attackerdamage[player.clientid].meansofdeath;
                    bestplayerweapon = self.attackerdamage[player.clientid].weapon;
                    continue;
                }
                if (isdefined(bestplayer) && self.attackerdamage[player.clientid].damage > self.attackerdamage[bestplayer.clientid].damage) {
                    bestplayer = player;
                    bestplayermeansofdeath = self.attackerdamage[player.clientid].meansofdeath;
                    bestplayerweapon = self.attackerdamage[player.clientid].weapon;
                }
            }
        }
        if (isdefined(bestplayer)) {
            self recordkillmodifier("assistedsuicide");
        }
    }
    if (isdefined(bestplayer)) {
        attacker = bestplayer;
        obituarymeansofdeath = bestplayermeansofdeath;
        obituaryweapon = bestplayerweapon;
    }
    if (isplayer(attacker)) {
        attacker.damagedplayers[self.clientid] = undefined;
    }
    if (globallogic_utils::isheadshot(weapon, shitloc, smeansofdeath, einflictor) && isplayer(attacker)) {
        attacker playlocalsound("prj_bullet_impact_headshot_helmet_nodie_2d");
        smeansofdeath = "MOD_HEAD_SHOT";
    }
    self.deathtime = gettime();
    attacker = function_9cedb097(attacker, weapon);
    einflictor = function_1e4d3508(einflictor);
    smeansofdeath = function_889dbeab(weapon, smeansofdeath);
    if (isdefined(self.hasriotshieldequipped) && self.hasriotshieldequipped == 1) {
        self detachshieldmodel(level.carriedshieldmodel, "tag_weapon_left");
        self.hasriotshield = 0;
        self.hasriotshieldequipped = 0;
    }
    self thread function_117043();
    if (level.teambased && (!level.teambased || isplayer(attacker) && attacker != self && self.team != attacker.team)) {
        self addweaponstat(weapon, "deaths", 1);
        if (wasinlaststand && isdefined(var_a3ad44ab)) {
            weapon = var_a3ad44ab;
        } else {
            weapon = self.lastdroppableweapon;
        }
        if (isdefined(weapon)) {
            self addweaponstat(weapon, "deathsDuringUse", 1);
        }
        if (smeansofdeath != "MOD_FALLING") {
            attacker addweaponstat(weapon, "kills", 1);
        }
        if (smeansofdeath == "MOD_HEAD_SHOT") {
            attacker addweaponstat(weapon, "headshots", 1);
        }
    }
    if (!isdefined(obituarymeansofdeath)) {
        obituarymeansofdeath = smeansofdeath;
    }
    if (!isdefined(obituaryweapon)) {
        obituaryweapon = weapon;
    }
    if (!isplayer(attacker) || self util::isenemyplayer(attacker) == 0) {
        level notify(#"reset_obituary_count");
        level.lastobituaryplayercount = 0;
        level.lastobituaryplayer = undefined;
    } else {
        if (isdefined(level.lastobituaryplayer) && level.lastobituaryplayer == attacker) {
            level.lastobituaryplayercount++;
        } else {
            level notify(#"reset_obituary_count");
            level.lastobituaryplayer = attacker;
            level.lastobituaryplayercount = 1;
        }
        if (level.lastobituaryplayercount >= 4) {
            level notify(#"reset_obituary_count");
            level.lastobituaryplayercount = 0;
            level.lastobituaryplayer = undefined;
        }
    }
    overrideentitycamera = 0;
    if (level.teambased && isdefined(attacker.pers) && self.team == attacker.team && obituarymeansofdeath == "MOD_GRENADE" && level.friendlyfire == 0) {
        obituary(self, self, obituaryweapon, obituarymeansofdeath);
        demo::bookmark("kill", gettime(), self, self, 0, einflictor, overrideentitycamera);
    } else {
        obituary(self, attacker, obituaryweapon, obituarymeansofdeath);
        demo::bookmark("kill", gettime(), attacker, self, 0, einflictor, overrideentitycamera);
    }
    if (!level.ingraceperiod) {
        self weapons::dropscavengerfordeath(attacker);
        self weapons::dropweaponfordeath(attacker);
    }
    spawnlogic::deathoccured(self, attacker);
    self.sessionstate = "dead";
    self.statusicon = "hud_status_dead";
    self.pers["weapon"] = undefined;
    self.killedplayerscurrent = [];
    self.deathcount++;
    println("<dev string:xfb>" + self.clientid + "<dev string:x104>" + self.deathcount);
    if (!isdefined(self.switching_teams)) {
        if (isplayer(attacker) && level.teambased && attacker != self && self.team == attacker.team) {
            self.pers["cur_kill_streak"] = 0;
            self.pers["cur_total_kill_streak"] = 0;
            self.pers["totalKillstreakCount"] = 0;
            self.pers["killstreaksEarnedThisKillstreak"] = 0;
            self setplayercurrentstreak(0);
        } else {
            self globallogic_score::incpersstat("deaths", 1, 1, 1);
            self.deaths = self globallogic_score::getpersstat("deaths");
            self updatestatratio("kdratio", "kills", "deaths");
            if (self.pers["cur_kill_streak"] > self.pers["best_kill_streak"]) {
                self.pers["best_kill_streak"] = self.pers["cur_kill_streak"];
            }
            self.pers["kill_streak_before_death"] = self.pers["cur_kill_streak"];
            self.pers["cur_kill_streak"] = 0;
            self.pers["cur_total_kill_streak"] = 0;
            self.pers["totalKillstreakCount"] = 0;
            self.pers["killstreaksEarnedThisKillstreak"] = 0;
            self setplayercurrentstreak(0);
            self.cur_death_streak++;
            if (self.cur_death_streak > self.death_streak) {
                if (level.rankedmatch) {
                    self setdstat("HighestStats", "death_streak", self.cur_death_streak);
                }
                self.death_streak = self.cur_death_streak;
            }
            if (self.cur_death_streak >= getdvarint("perk_deathStreakCountRequired")) {
                self enabledeathstreak();
            }
        }
    } else {
        self.pers["totalKillstreakCount"] = 0;
        self.pers["killstreaksEarnedThisKillstreak"] = 0;
    }
    lpselfnum = self getentitynumber();
    lpselfname = self.name;
    lpattackguid = "";
    lpattackname = "";
    lpselfteam = self.team;
    lpselfguid = self getguid();
    lpattackteam = "";
    lpattackorigin = (0, 0, 0);
    lpattacknum = -1;
    awardassists = 0;
    pixendevent();
    self globallogic_score::resetplayermomentumondeath();
    if (isplayer(attacker)) {
        lpattackguid = attacker getguid();
        lpattackname = attacker.name;
        lpattackteam = attacker.team;
        lpattackorigin = attacker.origin;
        if (attacker == self) {
            dokillcam = 0;
            self globallogic_score::incpersstat("suicides", 1);
            self.suicides = self globallogic_score::getpersstat("suicides");
            if (smeansofdeath == "MOD_SUICIDE" && shitloc == "none" && self.throwinggrenade) {
                self.lastgrenadesuicidetime = gettime();
            }
            awardassists = 1;
            self.suicide = 1;
            if (isdefined(self.friendlydamage)) {
                self iprintln(%MP_FRIENDLY_FIRE_WILL_NOT);
                if (level.teamkillpointloss) {
                    scoresub = self [[ level.getteamkillscore ]](einflictor, attacker, smeansofdeath, weapon);
                    globallogic_score::_setplayerscore(attacker, globallogic_score::_getplayerscore(attacker) - scoresub);
                }
            }
        } else {
            pixbeginevent("PlayerKilled attacker");
            lpattacknum = attacker getentitynumber();
            dokillcam = 1;
            if (level.teambased && self.team == attacker.team && smeansofdeath == "MOD_GRENADE" && level.friendlyfire == 0) {
            } else if (level.teambased && self.team == attacker.team) {
                if (!ignoreteamkills(weapon, smeansofdeath)) {
                    teamkill_penalty = self [[ level.getteamkillpenalty ]](einflictor, attacker, smeansofdeath, weapon);
                    attacker globallogic_score::incpersstat("teamkills_nostats", teamkill_penalty, 0);
                    attacker globallogic_score::incpersstat("teamkills", 1);
                    attacker.teamkillsthisround++;
                    if (level.teamkillpointloss) {
                        scoresub = self [[ level.getteamkillscore ]](einflictor, attacker, smeansofdeath, weapon);
                        globallogic_score::_setplayerscore(attacker, globallogic_score::_getplayerscore(attacker) - scoresub);
                    }
                    if (globallogic_utils::gettimepassed() < 5000) {
                        teamkilldelay = 1;
                    } else if (attacker.pers["teamkills_nostats"] > 1 && globallogic_utils::gettimepassed() < 8000 + attacker.pers["teamkills_nostats"] * 1000) {
                        teamkilldelay = 1;
                    } else {
                        teamkilldelay = attacker teamkilldelay();
                    }
                    if (teamkilldelay > 0) {
                        attacker.teamkillpunish = 1;
                        attacker suicide();
                        if (attacker function_a4451c91(teamkilldelay)) {
                            attacker function_b8f126c4();
                        }
                        attacker thread function_a1ea27f6();
                    }
                }
            } else {
                globallogic_score::inctotalkills(attacker.team);
                attacker thread globallogic_score::givekillstats(smeansofdeath, weapon, self);
                if (isalive(attacker)) {
                    pixbeginevent("killstreak");
                    if (!isdefined(einflictor) || !isdefined(einflictor.requireddeathcount) || attacker.deathcount == einflictor.requireddeathcount) {
                        shouldgivekillstreak = 0;
                        attacker.pers["cur_total_kill_streak"]++;
                        attacker setplayercurrentstreak(attacker.pers["cur_total_kill_streak"]);
                        if (isdefined(level.killstreaks) && shouldgivekillstreak) {
                            attacker.pers["cur_kill_streak"]++;
                        }
                    }
                    pixendevent();
                }
                if (attacker.pers["cur_kill_streak"] > attacker.kill_streak) {
                    if (level.rankedmatch) {
                        attacker setdstat("HighestStats", "kill_streak", attacker.pers["totalKillstreakCount"]);
                    }
                    attacker.kill_streak = attacker.pers["cur_kill_streak"];
                }
                killstreak = undefined;
                attacker thread globallogic_score::trackattackerkill(self.name, self.pers["rank"], self.pers["rankxp"], self.pers["prestige"], self getxuid());
                attackername = attacker.name;
                self thread globallogic_score::trackattackeedeath(attackername, attacker.pers["rank"], attacker.pers["rankxp"], attacker.pers["prestige"], attacker getxuid());
                attacker thread globallogic_score::inckillstreaktracker(weapon);
                if (level.teambased && attacker.team != "spectator") {
                    if (isai(attacker)) {
                        globallogic_score::giveteamscore("kill", attacker.team, attacker, self);
                    } else {
                        globallogic_score::giveteamscore("kill", attacker.team, attacker, self);
                    }
                }
                scoresub = level.deathpointloss;
                if (scoresub != 0) {
                    globallogic_score::_setplayerscore(self, globallogic_score::_getplayerscore(self) - scoresub);
                }
                level thread playkillbattlechatter(attacker, weapon, self);
                if (level.teambased) {
                    awardassists = 1;
                }
            }
            pixendevent();
        }
    } else if (attacker.classname == "trigger_hurt" || isdefined(attacker) && attacker.classname == "worldspawn") {
        dokillcam = 0;
        lpattacknum = -1;
        lpattackguid = "";
        lpattackname = "";
        lpattackteam = "world";
        self globallogic_score::incpersstat("suicides", 1);
        self.suicides = self globallogic_score::getpersstat("suicides");
        awardassists = 1;
    } else {
        dokillcam = 0;
        lpattacknum = -1;
        lpattackguid = "";
        lpattackname = "";
        lpattackteam = "world";
        if (isdefined(einflictor) && isdefined(einflictor.killcament)) {
            dokillcam = 1;
            lpattacknum = self getentitynumber();
        }
        if (isdefined(attacker) && isdefined(attacker.team) && isdefined(level.teams[attacker.team])) {
            if (attacker.team != self.team) {
                if (level.teambased) {
                    globallogic_score::giveteamscore("kill", attacker.team, attacker, self);
                }
            }
        }
        awardassists = 1;
    }
    pixbeginevent("PlayerKilled post constants");
    self.lastattacker = attacker;
    self.lastdeathpos = self.origin;
    if (!level.teambased || isdefined(attacker) && isplayer(attacker) && attacker != self && attacker.team != self.team) {
        self thread challenges::playerkilled(einflictor, attacker, idamage, smeansofdeath, weapon, shitloc, attackerstance);
    } else {
        self notify(#"playerkilledchallengesprocessed");
    }
    if (isdefined(self.attackers)) {
        self.attackers = [];
    }
    if (isplayer(attacker)) {
    }
    logprint("K;" + lpselfguid + ";" + lpselfnum + ";" + lpselfteam + ";" + lpselfname + ";" + lpattackguid + ";" + lpattacknum + ";" + lpattackteam + ";" + lpattackname + ";" + weapon.name + ";" + idamage + ";" + smeansofdeath + ";" + shitloc + "\n");
    attackerstring = "none";
    if (isplayer(attacker)) {
        attackerstring = attacker getxuid() + "(" + lpattackname + ")";
    }
    /#
        print("<dev string:x117>" + smeansofdeath + "<dev string:x11a>" + weapon.name + "<dev string:x11c>" + attackerstring + "<dev string:x121>" + idamage + "<dev string:x125>" + shitloc + "<dev string:x129>" + int(self.origin[0]) + "<dev string:x12d>" + int(self.origin[1]) + "<dev string:x12d>" + int(self.origin[2]));
    #/
    level thread globallogic::updateteamstatus();
    killcamentity = self getkillcamentity(attacker, einflictor, weapon);
    killcamentityindex = -1;
    killcamentitystarttime = 0;
    if (isdefined(killcamentity)) {
        killcamentityindex = killcamentity getentitynumber();
        if (isdefined(killcamentity.starttime)) {
            killcamentitystarttime = killcamentity.starttime;
        } else {
            killcamentitystarttime = killcamentity.birthtime;
        }
        if (!isdefined(killcamentitystarttime)) {
            killcamentitystarttime = 0;
        }
    }
    if (isdefined(self.var_814158b9) && self.var_814158b9 > 0) {
        dokillcam = 0;
    }
    self weapons::detach_carry_object_model();
    var_7614a86e = 0;
    if (isdefined(self.diedonvehicle)) {
        var_7614a86e = self.diedonvehicle;
    }
    pixendevent();
    pixbeginevent("PlayerKilled body and gibbing");
    if (!var_7614a86e) {
        vattackerorigin = undefined;
        if (isdefined(attacker)) {
            vattackerorigin = attacker.origin;
        }
        ragdoll_now = 0;
        if (isdefined(self.usingvehicle) && self.usingvehicle && isdefined(self.vehicleposition) && self.vehicleposition == 1) {
            ragdoll_now = 1;
        }
        body = self cloneplayer(deathanimduration, weapon, attacker);
        self function_39d71623(idamage, smeansofdeath, weapon, shitloc, vdir, vattackerorigin, deathanimduration, einflictor, ragdoll_now, body);
    }
    pixendevent();
    thread globallogic_spawn::spawnqueuedclient(self.team, attacker);
    self.switching_teams = undefined;
    self.joining_team = undefined;
    self.leaving_team = undefined;
    self thread [[ level.onplayerkilled ]](einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime, deathanimduration);
    for (var_4eb9549 = 0; var_4eb9549 < level.onplayerkilledextraunthreadedcbs.size; var_4eb9549++) {
        self [[ level.onplayerkilledextraunthreadedcbs[var_4eb9549] ]](einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime, deathanimduration);
    }
    self.wantsafespawn = 0;
    perks = [];
    killstreaks = globallogic::getkillstreaks(attacker);
    if (!isdefined(self.var_814158b9)) {
        self thread [[ level.spawnplayerprediction ]]();
    }
    profilelog_endtiming(7, "gs=" + game["state"] + " zom=" + sessionmodeiszombiesgame());
    wait 0.25;
    self.cancelkillcam = 0;
    defaultplayerdeathwatchtime = 1.75;
    if (smeansofdeath == "MOD_MELEE_ASSASSINATE" || 0 > weapon.deathcamtime) {
        defaultplayerdeathwatchtime = deathanimduration * 0.001 + 0.5;
    } else if (0 < weapon.deathcamtime) {
        defaultplayerdeathwatchtime = weapon.deathcamtime;
    }
    if (isdefined(level.overrideplayerdeathwatchtimer)) {
        defaultplayerdeathwatchtime = [[ level.overrideplayerdeathwatchtimer ]](defaultplayerdeathwatchtime);
    }
    globallogic_utils::function_b59d6fa4(defaultplayerdeathwatchtime);
    self notify(#"death_delay_finished");
    /#
        if (getdvarint("<dev string:x12f>") != 0) {
            dokillcam = 1;
            if (lpattacknum < 0) {
                lpattacknum = self getentitynumber();
            }
        }
    #/
    if (game["state"] != "playing") {
        return;
    }
    self.respawntimerstarttime = gettime();
    if (!self.cancelkillcam && dokillcam && level.killcam) {
        livesleft = !(level.numlives && !self.pers["lives"]);
        timeuntilspawn = globallogic_spawn::timeuntilspawn(1);
        willrespawnimmediately = livesleft && timeuntilspawn <= 0 && !level.playerqueuedrespawn;
    }
    if (game["state"] != "playing") {
        self.sessionstate = "dead";
        self.spectatorclient = -1;
        self.killcamtargetentity = -1;
        self.killcamentity = -1;
        self.archivetime = 0;
        self.psoffsettime = 0;
        return;
    }
    function_188bdae1();
    if (globallogic_utils::isvalidclass(self.curclass)) {
        timepassed = undefined;
        if (isdefined(self.respawntimerstarttime)) {
            timepassed = (gettime() - self.respawntimerstarttime) / 1000;
        }
        self thread [[ level.spawnclient ]](timepassed);
        self.respawntimerstarttime = undefined;
    }
}

// Namespace globallogic_player
// Params 0, eflags: 0x1 linked
// Checksum 0x5b8659e9, Offset: 0x6770
// Size: 0x24
function function_117043() {
    if (isdefined(self.pers["isBot"])) {
        level.globallarryskilled++;
    }
}

// Namespace globallogic_player
// Params 0, eflags: 0x1 linked
// Checksum 0x94da8737, Offset: 0x67a0
// Size: 0x76
function function_188bdae1() {
    if (isdefined(self.var_814158b9)) {
        starttime = gettime();
        waittime = self.var_814158b9 * 1000;
        while (gettime() < starttime + waittime && isdefined(self.var_814158b9)) {
            wait 0.1;
        }
        wait 2;
        self.var_814158b9 = undefined;
    }
}

// Namespace globallogic_player
// Params 0, eflags: 0x1 linked
// Checksum 0x9dcd2fb1, Offset: 0x6820
// Size: 0x20c
function function_b8f126c4() {
    self globallogic_score::incpersstat("sessionbans", 1);
    self endon(#"disconnect");
    waittillframeend();
    playlistbanquantum = tweakables::gettweakablevalue("team", "teamkillerplaylistbanquantum");
    playlistbanpenalty = tweakables::gettweakablevalue("team", "teamkillerplaylistbanpenalty");
    if (playlistbanquantum > 0 && playlistbanpenalty > 0) {
        timeplayedtotal = self getdstat("playerstatslist", "time_played_total", "StatValue");
        minutesplayed = timeplayedtotal / 60;
        freebees = 2;
        banallowance = int(floor(minutesplayed / playlistbanquantum)) + freebees;
        if (self.sessionbans > banallowance) {
            self setdstat("playerstatslist", "gametypeban", "StatValue", timeplayedtotal + playlistbanpenalty * 60);
        }
    }
    if (self util::is_bot()) {
        level notify(#"hash_410ff0e", self.team);
    }
    ban(self getentitynumber());
    globallogic_audio::leaderdialog("kicked");
}

// Namespace globallogic_player
// Params 0, eflags: 0x1 linked
// Checksum 0xc68ecf8c, Offset: 0x6a38
// Size: 0x70
function teamkilldelay() {
    teamkills = self.pers["teamkills_nostats"];
    if (level.minimumallowedteamkills < 0 || teamkills <= level.minimumallowedteamkills) {
        return 0;
    }
    exceeded = teamkills - level.minimumallowedteamkills;
    return level.teamkillspawndelay * exceeded;
}

// Namespace globallogic_player
// Params 1, eflags: 0x1 linked
// Checksum 0x60571d0f, Offset: 0x6ab0
// Size: 0x66
function function_a4451c91(teamkilldelay) {
    if (teamkilldelay && level.minimumallowedteamkills >= 0) {
        if (globallogic_utils::gettimepassed() >= 5000) {
            return true;
        }
        if (self.pers["teamkills_nostats"] > 1) {
            return true;
        }
    }
    return false;
}

// Namespace globallogic_player
// Params 0, eflags: 0x1 linked
// Checksum 0xc720668c, Offset: 0x6b20
// Size: 0xc0
function function_a1ea27f6() {
    timeperoneteamkillreduction = 20;
    reductionpersecond = 1 / timeperoneteamkillreduction;
    while (true) {
        if (isalive(self)) {
            self.pers["teamkills_nostats"] = self.pers["teamkills_nostats"] - reductionpersecond;
            if (self.pers["teamkills_nostats"] < level.minimumallowedteamkills) {
                self.pers["teamkills_nostats"] = level.minimumallowedteamkills;
                break;
            }
        }
        wait 1;
    }
}

// Namespace globallogic_player
// Params 2, eflags: 0x1 linked
// Checksum 0x5be79e68, Offset: 0x6be8
// Size: 0x84
function ignoreteamkills(weapon, smeansofdeath) {
    if (sessionmodeiszombiesgame()) {
        return true;
    }
    if (smeansofdeath == "MOD_MELEE") {
        return false;
    }
    if (weapon.name == "briefcase_bomb") {
        return true;
    }
    if (weapon.name == "supplydrop") {
        return true;
    }
    return false;
}

// Namespace globallogic_player
// Params 9, eflags: 0x1 linked
// Checksum 0x389ee803, Offset: 0x6c78
// Size: 0x4c
function callback_playerlaststand(einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime, deathanimduration) {
    
}

// Namespace globallogic_player
// Params 5, eflags: 0x1 linked
// Checksum 0x9274a8d9, Offset: 0x6cd0
// Size: 0x74
function damageshellshockandrumble(eattacker, einflictor, weapon, smeansofdeath, idamage) {
    self thread weapons::onweapondamage(eattacker, einflictor, weapon, smeansofdeath, idamage);
    self playrumbleonentity("damage_heavy");
}

// Namespace globallogic_player
// Params 10, eflags: 0x1 linked
// Checksum 0x71b81d6e, Offset: 0x6d50
// Size: 0x1e8
function function_39d71623(idamage, smeansofdeath, weapon, shitloc, vdir, vattackerorigin, deathanimduration, einflictor, ragdoll_jib, body) {
    if (smeansofdeath == "MOD_HIT_BY_OBJECT" && self getstance() == "prone") {
        self.body = body;
        return;
    }
    if (isdefined(level.ragdoll_override) && self [[ level.ragdoll_override ]]()) {
        return;
    }
    if (ragdoll_jib || self isonladder() || self ismantling() || smeansofdeath == "MOD_CRUSH" || smeansofdeath == "MOD_HIT_BY_OBJECT") {
        body startragdoll();
    }
    if (!self isonground()) {
        if (getdvarint("scr_disable_air_death_ragdoll") == 0) {
            body startragdoll();
        }
    }
    if (self is_explosive_ragdoll(weapon, einflictor)) {
        body start_explosive_ragdoll(vdir, weapon);
    }
    thread delaystartragdoll(body, shitloc, vdir, weapon, einflictor, smeansofdeath);
    self.body = body;
}

// Namespace globallogic_player
// Params 2, eflags: 0x1 linked
// Checksum 0x2d786ac3, Offset: 0x6f40
// Size: 0xb2
function is_explosive_ragdoll(weapon, inflictor) {
    if (!isdefined(weapon)) {
        return false;
    }
    if (weapon.name == "destructible_car" || weapon.name == "explodable_barrel") {
        return true;
    }
    if (weapon.projexplosiontype == "grenade") {
        if (isdefined(inflictor) && isdefined(inflictor.stucktoplayer)) {
            if (inflictor.stucktoplayer == self) {
                return true;
            }
        }
    }
    return false;
}

// Namespace globallogic_player
// Params 2, eflags: 0x1 linked
// Checksum 0xd1c6a931, Offset: 0x7000
// Size: 0x1b4
function start_explosive_ragdoll(dir, weapon) {
    if (!isdefined(self)) {
        return;
    }
    x = randomintrange(50, 100);
    y = randomintrange(50, 100);
    z = randomintrange(10, 20);
    if (weapon.name == "sticky_grenade" || isdefined(weapon) && weapon.name == "explosive_bolt") {
        if (isdefined(dir) && lengthsquared(dir) > 0) {
            x = dir[0] * x;
            y = dir[1] * y;
        }
    } else {
        if (math::cointoss()) {
            x *= -1;
        }
        if (math::cointoss()) {
            y *= -1;
        }
    }
    self startragdoll();
    self launchragdoll((x, y, z));
}

// Namespace globallogic_player
// Params 0, eflags: 0x1 linked
// Checksum 0xc0acdf37, Offset: 0x71c0
// Size: 0x3c
function notifyconnecting() {
    waittillframeend();
    if (isdefined(self)) {
        level notify(#"connecting", self);
        self callback::callback(#"hash_fefe13f5");
    }
}

// Namespace globallogic_player
// Params 6, eflags: 0x1 linked
// Checksum 0xa82bedad, Offset: 0x7208
// Size: 0x314
function delaystartragdoll(ent, shitloc, vdir, weapon, einflictor, smeansofdeath) {
    if (isdefined(ent)) {
        deathanim = ent getcorpseanim();
        if (animhasnotetrack(deathanim, "ignore_ragdoll")) {
            return;
        }
    }
    if (level.oldschool) {
        if (!isdefined(vdir)) {
            vdir = (0, 0, 0);
        }
        explosionpos = ent.origin + (0, 0, globallogic_utils::gethitlocheight(shitloc));
        explosionpos -= vdir * 20;
        explosionradius = 40;
        var_a207fba7 = 0.75;
        if (smeansofdeath == "MOD_IMPACT" || smeansofdeath == "MOD_EXPLOSIVE" || issubstr(smeansofdeath, "MOD_GRENADE") || issubstr(smeansofdeath, "MOD_PROJECTILE") || shitloc == "head" || shitloc == "helmet") {
            var_a207fba7 = 2.5;
        }
        ent startragdoll(1);
        wait 0.05;
        if (!isdefined(ent)) {
            return;
        }
        physicsexplosionsphere(explosionpos, explosionradius, explosionradius / 2, var_a207fba7);
        return;
    }
    wait 0.2;
    if (!isdefined(ent)) {
        return;
    }
    if (ent isragdoll()) {
        return;
    }
    deathanim = ent getcorpseanim();
    startfrac = 0.35;
    if (animhasnotetrack(deathanim, "start_ragdoll")) {
        times = getnotetracktimes(deathanim, "start_ragdoll");
        if (isdefined(times)) {
            startfrac = times[0];
        }
    }
    waittime = startfrac * getanimlength(deathanim);
    wait waittime;
    if (isdefined(ent)) {
        ent startragdoll(1);
    }
}

// Namespace globallogic_player
// Params 4, eflags: 0x1 linked
// Checksum 0x1bc7336c, Offset: 0x7528
// Size: 0x2ba
function trackattackerdamage(eattacker, idamage, smeansofdeath, weapon) {
    if (!isdefined(eattacker)) {
        return;
    }
    if (!isplayer(eattacker)) {
        return;
    }
    if (self.attackerdata.size == 0) {
        self.firsttimedamaged = gettime();
    }
    if (!isdefined(self.attackerdata[eattacker.clientid])) {
        self.attackerdamage[eattacker.clientid] = spawnstruct();
        self.attackerdamage[eattacker.clientid].damage = idamage;
        self.attackerdamage[eattacker.clientid].meansofdeath = smeansofdeath;
        self.attackerdamage[eattacker.clientid].weapon = weapon;
        self.attackerdamage[eattacker.clientid].time = gettime();
        self.attackers[self.attackers.size] = eattacker;
        self.attackerdata[eattacker.clientid] = 0;
    } else {
        self.attackerdamage[eattacker.clientid].damage = self.attackerdamage[eattacker.clientid].damage + idamage;
        self.attackerdamage[eattacker.clientid].meansofdeath = smeansofdeath;
        self.attackerdamage[eattacker.clientid].weapon = weapon;
        if (!isdefined(self.attackerdamage[eattacker.clientid].time)) {
            self.attackerdamage[eattacker.clientid].time = gettime();
        }
    }
    self.attackerdamage[eattacker.clientid].lasttimedamaged = gettime();
    if (weapons::is_primary_weapon(weapon)) {
        self.attackerdata[eattacker.clientid] = 1;
    }
}

// Namespace globallogic_player
// Params 5, eflags: 0x1 linked
// Checksum 0x1d61b9d8, Offset: 0x77f0
// Size: 0x104
function giveattackerandinflictorownerassist(eattacker, einflictor, idamage, smeansofdeath, weapon) {
    if (!allowedassistweapon(weapon)) {
        return;
    }
    self trackattackerdamage(eattacker, idamage, smeansofdeath, weapon);
    if (!isdefined(einflictor)) {
        return;
    }
    if (!isdefined(einflictor.owner)) {
        return;
    }
    if (!isdefined(einflictor.ownergetsassist)) {
        return;
    }
    if (!einflictor.ownergetsassist) {
        return;
    }
    if (isdefined(eattacker) && eattacker == einflictor.owner) {
        return;
    }
    self trackattackerdamage(einflictor.owner, idamage, smeansofdeath, weapon);
}

// Namespace globallogic_player
// Params 2, eflags: 0x1 linked
// Checksum 0x3ac2c116, Offset: 0x7900
// Size: 0xb6
function function_889dbeab(weapon, smeansofdeath) {
    switch (weapon.name) {
    case "knife_ballistic":
        if (smeansofdeath != "MOD_HEAD_SHOT" && smeansofdeath != "MOD_MELEE") {
            smeansofdeath = "MOD_PISTOL_BULLET";
        }
        break;
    case "dog_bite":
        smeansofdeath = "MOD_PISTOL_BULLET";
        break;
    case "destructible_car":
        smeansofdeath = "MOD_EXPLOSIVE";
        break;
    case "explodable_barrel":
        smeansofdeath = "MOD_EXPLOSIVE";
        break;
    }
    return smeansofdeath;
}

// Namespace globallogic_player
// Params 2, eflags: 0x1 linked
// Checksum 0x15149abf, Offset: 0x79c0
// Size: 0x198
function function_9cedb097(attacker, weapon) {
    if (isai(attacker) && isdefined(attacker.script_owner)) {
        if (!level.teambased || attacker.script_owner.team != self.team) {
            attacker = attacker.script_owner;
        }
    }
    if (attacker.classname == "script_vehicle" && isdefined(attacker.owner)) {
        attacker notify(#"killed", self);
        attacker = attacker.owner;
    }
    if (isai(attacker)) {
        attacker notify(#"killed", self);
    }
    if (isdefined(self.capturinglastflag) && self.capturinglastflag == 1) {
        attacker.lastcapkiller = 1;
    }
    if (isdefined(attacker) && isdefined(weapon) && weapon.name == "planemortar") {
        if (!isdefined(attacker.planemortarbda)) {
            attacker.planemortarbda = 0;
        }
        attacker.planemortarbda++;
    }
    return attacker;
}

// Namespace globallogic_player
// Params 1, eflags: 0x1 linked
// Checksum 0x21ccacac, Offset: 0x7b60
// Size: 0x68
function function_1e4d3508(einflictor) {
    if (isdefined(einflictor) && einflictor.classname == "script_vehicle") {
        einflictor notify(#"killed", self);
        if (isdefined(einflictor.bda)) {
            einflictor.bda++;
        }
    }
    return einflictor;
}

// Namespace globallogic_player
// Params 2, eflags: 0x1 linked
// Checksum 0x2316f73, Offset: 0x7bd0
// Size: 0xd4
function updateweapon(einflictor, weapon) {
    if (weapon == level.weaponnone && isdefined(einflictor)) {
        if (isdefined(einflictor.targetname) && einflictor.targetname == "explodable_barrel") {
            weapon = getweapon("explodable_barrel");
        } else if (isdefined(einflictor.destructible_type) && issubstr(einflictor.destructible_type, "vehicle_")) {
            weapon = getweapon("destructible_car");
        }
    }
    return weapon;
}

// Namespace globallogic_player
// Params 3, eflags: 0x1 linked
// Checksum 0x2a9674d9, Offset: 0x7cb0
// Size: 0x220
function function_ddda4ed0(attacker, killcamentities, depth) {
    if (!isdefined(depth)) {
        depth = 0;
    }
    closestkillcament = undefined;
    closestkillcamentindex = undefined;
    closestkillcamentdist = undefined;
    origin = undefined;
    foreach (killcamentindex, killcament in killcamentities) {
        if (killcament == attacker) {
            continue;
        }
        origin = killcament.origin;
        if (isdefined(killcament.offsetpoint)) {
            origin += killcament.offsetpoint;
        }
        dist = distancesquared(self.origin, origin);
        if (!isdefined(closestkillcament) || dist < closestkillcamentdist) {
            closestkillcament = killcament;
            closestkillcamentdist = dist;
            closestkillcamentindex = killcamentindex;
        }
    }
    if (depth < 3 && isdefined(closestkillcament)) {
        if (!bullettracepassed(closestkillcament.origin, self.origin, 0, self)) {
            killcamentities[closestkillcamentindex] = undefined;
            betterkillcament = function_ddda4ed0(attacker, killcamentities, depth + 1);
            if (isdefined(betterkillcament)) {
                closestkillcament = betterkillcament;
            }
        }
    }
    return closestkillcament;
}

// Namespace globallogic_player
// Params 3, eflags: 0x1 linked
// Checksum 0x1db75daf, Offset: 0x7ed8
// Size: 0x198
function getkillcamentity(attacker, einflictor, weapon) {
    if (!isdefined(einflictor)) {
        return undefined;
    }
    if (einflictor == attacker) {
        if (!isdefined(einflictor.ismagicbullet)) {
            return undefined;
        }
        if (isdefined(einflictor.ismagicbullet) && !einflictor.ismagicbullet) {
            return undefined;
        }
    } else if (isdefined(level.levelspecifickillcam)) {
        levelspecifickillcament = self [[ level.levelspecifickillcam ]]();
        if (isdefined(levelspecifickillcament)) {
            return levelspecifickillcament;
        }
    }
    if (weapon.name == "m220_tow") {
        return undefined;
    }
    if (isdefined(einflictor.killcament)) {
        if (einflictor.killcament == attacker) {
            return undefined;
        }
        return einflictor.killcament;
    } else if (isdefined(einflictor.killcamentities)) {
        return function_ddda4ed0(attacker, einflictor.killcamentities);
    }
    if (isdefined(einflictor.script_gameobjectname) && einflictor.script_gameobjectname == "bombzone") {
        return einflictor.killcament;
    }
    return einflictor;
}

// Namespace globallogic_player
// Params 3, eflags: 0x1 linked
// Checksum 0x40c08c16, Offset: 0x8078
// Size: 0x1c
function playkillbattlechatter(attacker, weapon, victim) {
    
}

// Namespace globallogic_player
// Params 0, eflags: 0x1 linked
// Checksum 0xb90365e3, Offset: 0x80a0
// Size: 0xaa
function recordactiveplayersendgamematchrecordstats() {
    foreach (player in level.players) {
        recordplayermatchend(player);
        recordplayerstats(player, "presentAtEnd", 1);
    }
}

