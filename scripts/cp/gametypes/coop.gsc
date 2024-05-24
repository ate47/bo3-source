#using scripts/shared/music_shared;
#using scripts/cp/_laststand;
#using scripts/cp/_bb;
#using scripts/cp/_util;
#using scripts/cp/_skipto;
#using scripts/cp/_callbacks;
#using scripts/cp/_achievements;
#using scripts/cp/gametypes/_save;
#using scripts/cp/gametypes/_killcam;
#using scripts/cp/gametypes/_spawnlogic;
#using scripts/cp/gametypes/_spawning;
#using scripts/cp/gametypes/_globallogic_utils;
#using scripts/cp/gametypes/_globallogic_ui;
#using scripts/cp/gametypes/_globallogic_spawn;
#using scripts/cp/gametypes/_globallogic_score;
#using scripts/cp/gametypes/_globallogic;
#using scripts/shared/player_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/util_shared;
#using scripts/shared/laststand_shared;
#using scripts/shared/lui_shared;
#using scripts/shared/system_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/math_shared;
#using scripts/shared/gameobjects_shared;
#using scripts/shared/flagsys_shared;
#using scripts/shared/flag_shared;

#namespace coop;

// Namespace coop
// Params 0, eflags: 0x2
// Checksum 0x1019faed, Offset: 0x8a0
// Size: 0x64
function autoexec init() {
    clientfield::register("playercorpse", "hide_body", 1, 1, "int");
    clientfield::register("toplayer", "killcam_menu", 1, 1, "int");
}

// Namespace coop
// Params 0, eflags: 0x1 linked
// Checksum 0x58b61659, Offset: 0x910
// Size: 0x374
function main() {
    globallogic::init();
    level.gametype = tolower(getdvarstring("g_gametype"));
    util::registerroundswitch(0, 9);
    util::registertimelimit(0, 0);
    util::registerscorelimit(0, 0);
    util::registerroundlimit(0, 10);
    util::registerroundwinlimit(0, 0);
    util::registernumlives(0, 100);
    globallogic::registerfriendlyfiredelay(level.gametype, 15, 0, 1440);
    spawner::add_global_spawn_function("axis", &function_54ba8dfa);
    level.scoreroundwinbased = getgametypesetting("cumulativeRoundScores") == 0;
    level.teamscoreperkill = getgametypesetting("teamScorePerKill");
    level.teamscoreperdeath = getgametypesetting("teamScorePerDeath");
    level.teamscoreperheadshot = getgametypesetting("teamScorePerHeadshot");
    level.teambased = 1;
    level.overrideteamscore = 1;
    level.onstartgametype = &onstartgametype;
    level.onspawnplayer = &onspawnplayer;
    level.onspawnplayerunified = undefined;
    level.onplayerkilled = &onplayerkilled;
    level.var_2b829c4e = &wait_to_spawn;
    level.var_bdd4d5c2 = &spawnedasspectator;
    level thread function_a67d9d08();
    level.var_29d9f951 = 1;
    level.endgameonscorelimit = 0;
    level.endgameontimelimit = 0;
    level.ontimelimit = &globallogic::blank;
    level.onscorelimit = &globallogic::blank;
    gameobjects::register_allowed_gameobject(level.gametype);
    game["dialog"]["gametype"] = "coop_start";
    game["dialog"]["gametype_hardcore"] = "hccoop_start";
    game["dialog"]["offense_obj"] = "generic_boost";
    game["dialog"]["defense_obj"] = "generic_boost";
    setscoreboardcolumns("score", "kills", "assists", "incaps", "revives");
}

// Namespace coop
// Params 0, eflags: 0x1 linked
// Checksum 0x67f88810, Offset: 0xc90
// Size: 0x5c
function function_54ba8dfa() {
    level spawning::create_enemy_influencer("enemy_spawn", self.origin, "allies");
    self spawning::create_entity_enemy_influencer("enemy", "allies");
}

// Namespace coop
// Params 1, eflags: 0x1 linked
// Checksum 0x8f80e6a3, Offset: 0xcf8
// Size: 0x34
function function_79eba3d6(time) {
    self endon(#"hash_3f7b661c");
    wait(time);
    self disableinvulnerability();
}

// Namespace coop
// Params 0, eflags: 0x1 linked
// Checksum 0xc268d551, Offset: 0xd38
// Size: 0x204
function function_642c1545() {
    self matchrecordplayerspawned();
    if (skipto::function_52c50cb8() != -1) {
        self matchrecordsetcheckpointstat(skipto::function_52c50cb8(), "checkpoint_restores", 1);
    }
    primaryweapon = isdefined(self.primaryweapon) ? self.primaryweapon : level.weaponnone;
    secondaryweapon = isdefined(self.secondaryweapon) ? self.secondaryweapon : level.weaponnone;
    grenadetypeprimary = isdefined(self.grenadetypeprimary) ? self.grenadetypeprimary : level.weaponnone;
    grenadetypesecondary = isdefined(self.grenadetypesecondary) ? self.grenadetypesecondary : level.weaponnone;
    self.killstreak = [];
    for (i = 0; i < 3; i++) {
        if (level.loadoutkillstreaksenabled && isdefined(self.killstreak[i]) && isdefined(level.killstreakindices[self.killstreak[i]])) {
            killstreaks[i] = level.killstreakindices[self.killstreak[i]];
            continue;
        }
        killstreaks[i] = 0;
    }
    self recordloadoutperksandkillstreaks(primaryweapon, secondaryweapon, grenadetypeprimary, grenadetypesecondary, killstreaks[0], killstreaks[1], killstreaks[2]);
}

// Namespace coop
// Params 0, eflags: 0x1 linked
// Checksum 0xc2b65f4d, Offset: 0xf48
// Size: 0x2b6
function function_a67d9d08() {
    while (true) {
        level waittill(#"save_restore");
        music::setmusicstate("death");
        util::function_459ff829();
        level thread lui::screen_fade(1.25, 0, 1, "black", 1);
        matchrecorderincrementheaderstat("checkpointRestoreCount", 1);
        foreach (player in level.players) {
            player closemenu(game["menu_start_menu"]);
            if (player flagsys::get("mobile_armory_in_use")) {
                player notify(#"menuresponse", "ChooseClass_InGame", "cancel");
            }
            player closemenu(game["menu_changeclass"]);
            player closemenu(game["menu_changeclass_offline"]);
            if (player.sessionstate == "spectator") {
                if (!isdefined(player.curclass)) {
                    player thread globallogic_ui::beginclasschoice();
                } else {
                    player thread globallogic_spawn::waitandspawnclient();
                }
            } else if (player laststand::player_is_in_laststand()) {
                player notify(#"auto_revive");
            }
            var_a7283d73 = player enableinvulnerability();
            if (!var_a7283d73) {
                player thread function_79eba3d6(3);
            }
            if (!(isdefined(world.var_bf966ebd) && world.var_bf966ebd)) {
                world.var_bf966ebd = 1;
            }
            player function_642c1545();
        }
    }
}

// Namespace coop
// Params 0, eflags: 0x1 linked
// Checksum 0x2458e6c8, Offset: 0x1208
// Size: 0x3b2
function onstartgametype() {
    setclientnamemode("auto_change");
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
    foreach (team in level.playerteams) {
        util::setobjectivetext(team, %OBJECTIVES_COOP);
        util::setobjectivehinttext(team, %OBJECTIVES_COOP_HINT);
        util::setobjectivescoretext(team, %OBJECTIVES_COOP);
    }
    level.mapcenter = math::find_box_center(level.spawnmins, level.spawnmaxs);
    setmapcenter(level.mapcenter);
    spawnpoint = spawnlogic::get_random_intermission_point();
    setdemointermissionpoint(spawnpoint.origin, spawnpoint.angles);
    level thread function_7185e36b();
    spawnlogic::add_spawn_points("allies", "cp_coop_spawn");
    spawning::updateallspawnpoints();
    level flag::wait_till("first_player_spawned");
    if (!level flagsys::get("level_has_skiptos")) {
        spawnlogic::clear_spawn_points();
        spawnlogic::add_spawn_points("allies", "cp_coop_spawn");
        spawnlogic::add_spawn_points("allies", "cp_coop_respawn");
        spawning::updateallspawnpoints();
    }
    foreach (player in level.players) {
        bb::function_bea1c67c("_level", player, "start");
    }
}

// Namespace coop
// Params 2, eflags: 0x1 linked
// Checksum 0x536b7693, Offset: 0x15c8
// Size: 0x184
function onspawnplayer(predictedspawn, question) {
    if (!isdefined(predictedspawn)) {
        predictedspawn = 0;
    }
    pixbeginevent("COOP:onSpawnPlayer");
    self.usingobj = undefined;
    if (isdefined(question)) {
        question = 1;
    }
    if (isdefined(question)) {
        question = -1;
    }
    spawnpoint = spawning::getspawnpoint(self, predictedspawn);
    if (predictedspawn) {
        self predictspawnpoint(spawnpoint["origin"], spawnpoint["angles"]);
        self.predicted_spawn_point = spawnpoint;
    } else {
        if (isdefined(self.var_10aaa336)) {
            spawnpoint["origin"] = self.var_10aaa336;
            self.var_10aaa336 = undefined;
        }
        if (isdefined(self.var_7e4a3c90)) {
            spawnpoint["angles"] = self.var_7e4a3c90;
            self.var_7e4a3c90 = undefined;
        }
        self spawn(spawnpoint["origin"], spawnpoint["angles"], "coop");
    }
    self thread function_51525e38();
    pixendevent();
}

// Namespace coop
// Params 0, eflags: 0x0
// Checksum 0x7aca4115, Offset: 0x1758
// Size: 0x1bc
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
        if (scoredif <= scorethreshold && scorethresholdstart <= topscore) {
            return;
        }
        wait(1);
    }
}

// Namespace coop
// Params 9, eflags: 0x1 linked
// Checksum 0xa513346d, Offset: 0x1920
// Size: 0x454
function onplayerkilled(einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime, deathanimduration) {
    self closemenu(game["menu_changeclass"]);
    attacker globallogic_score::giveteamscoreforobjective(attacker.team, level.teamscoreperkill);
    self globallogic_score::giveteamscoreforobjective(self.team, level.teamscoreperdeath * -1);
    if (smeansofdeath == "MOD_HEAD_SHOT") {
        attacker globallogic_score::giveteamscoreforobjective(attacker.team, level.teamscoreperheadshot);
    }
    if (!sessionmodeiscampaignzombiesgame() && !(isdefined(level.is_safehouse) && level.is_safehouse)) {
        /#
            assert(isdefined(level.laststandpistol));
        #/
        self takeweapon(level.laststandpistol);
        primaries = self getweaponslistprimaries();
        if (isdefined(primaries)) {
            foreach (primary_weapon in primaries) {
                if (primary_weapon !== self.secondaryloadoutweapon) {
                    self._current_weapon = primary_weapon;
                    break;
                }
            }
        }
        self player::take_weapons();
        self savegame::set_player_data("saved_weapon", self._current_weapon.name);
        self savegame::set_player_data("saved_weapondata", self._weapons);
        self._weapons = undefined;
        self.gun_removed = undefined;
    }
    if (!(isdefined(level.is_safehouse) && level.is_safehouse)) {
        if (isdefined(level.var_ad1a71f5)) {
            return;
        }
        level.var_33287bb1 = self;
        if (self.lives === 0 && self function_76f34311("cybercom_emergencyreserve") != 0) {
            self.lives = 1;
            self setnoncheckpointdata("lives", self.lives);
        }
        if (level.players.size == 1) {
            self playsoundtoplayer("evt_death_down", self);
            if (isdefined(level.var_d59daf8) && level.var_d59daf8) {
                self.var_e8880dea = 1;
                if (isdefined(self.var_ebd83169) && isdefined(level.var_3a9f9a38) && level.var_3a9f9a38 && self.var_ebd83169) {
                    self thread function_c14603ce();
                }
                self util::waittill_any_timeout(5, "cp_deathcam_ended");
            }
            level thread function_5ed5738a(undefined, undefined);
            return;
        }
        if (level.gameskill >= 2) {
            playsoundatposition("evt_death_down", (0, 0, 0));
            level thread function_5ed5738a(%GAME_YOU_DIED);
        }
    }
}

// Namespace coop
// Params 2, eflags: 0x1 linked
// Checksum 0x7719132d, Offset: 0x1d80
// Size: 0x59c
function function_5ed5738a(var_b90e5c2c, var_c878636f) {
    level.var_ad1a71f5 = 1;
    foreach (player in level.players) {
        player util::show_hud(0);
        bb::function_bea1c67c(level.var_31aefea8, player, "restart");
        player util::freeze_player_controls(1);
        player.var_c8430b0a = 1;
        if (isdefined(var_b90e5c2c)) {
            var_e13f49eb = 1;
            player.var_c8656312 = player openluimenu("CPMissionFailed");
            if (var_b90e5c2c == %GAME_YOU_DIED) {
                if (player == level.var_33287bb1) {
                    player thread function_7a243f7c();
                } else {
                    player thread function_4f6eaa7(level.var_33287bb1);
                }
                player setluimenudata(player.var_c8656312, "MissionFailReason", "");
            } else {
                player setluimenudata(player.var_c8656312, "MissionFailReason", var_b90e5c2c);
            }
            if (!isdefined(var_c878636f)) {
                var_c878636f = "";
            }
            player setluimenudata(player.var_c8656312, "MissionFailHint", var_c878636f);
        }
    }
    if (isdefined(var_e13f49eb)) {
        wait(3.8);
    }
    var_d5b5f12 = 1.25;
    if (isdefined(level.var_33287bb1)) {
        if (isdefined(level.var_3a9f9a38) && level.var_3a9f9a38) {
            foreach (player in level.players) {
                if (isdefined(player.var_acfedf1c) && player.var_acfedf1c) {
                    level.var_33287bb1 util::waittill_any("end_killcam", "fade_out_killcam");
                    if (isdefined(level.var_33287bb1.var_1c362abb)) {
                        var_d5b5f12 = level.var_33287bb1.var_1c362abb;
                    }
                }
            }
        }
        level thread lui::screen_fade(var_d5b5f12, 1, 0, "black", 0);
        wait(var_d5b5f12);
        var_ac4d13a6 = 1;
        if (isdefined(level.var_3a9f9a38) && level.var_3a9f9a38) {
            foreach (player in level.players) {
                if (isdefined(player.var_acfedf1c) && player.var_acfedf1c) {
                    player clientfield::set_to_player("killcam_menu", 0);
                }
            }
        }
    }
    if (!isdefined(var_ac4d13a6)) {
        level thread lui::screen_fade(var_d5b5f12, 1, 0, "black", 0);
        wait(var_d5b5f12);
    }
    if (isdefined(level.gameended) && level.gameended) {
        wait(1000);
    }
    foreach (player in level.players) {
        player notify(#"hash_1528244e");
        player cameraactivate(0);
        player util::freeze_player_controls(0);
    }
    checkpointrestore();
    wait(0.5);
    map_restart();
}

// Namespace coop
// Params 0, eflags: 0x1 linked
// Checksum 0xcb4a30dd, Offset: 0x2328
// Size: 0x130
function function_7a243f7c() {
    wait(1.2);
    self.var_51a0d4ef = newclienthudelem(self);
    self.var_51a0d4ef.alignx = "center";
    self.var_51a0d4ef.aligny = "middle";
    self.var_51a0d4ef.horzalign = "center";
    self.var_51a0d4ef.vertalign = "middle";
    self.var_51a0d4ef.foreground = 1;
    self.var_51a0d4ef.fontscale = 2;
    self.var_51a0d4ef.alpha = 0;
    self.var_51a0d4ef.color = (1, 1, 1);
    self.var_51a0d4ef settext(%GAME_YOU_DIED);
    self.var_51a0d4ef fadeovertime(1);
    self.var_51a0d4ef.alpha = 1;
}

// Namespace coop
// Params 1, eflags: 0x1 linked
// Checksum 0xa259a4e0, Offset: 0x2460
// Size: 0x140
function function_4f6eaa7(var_34ab38ea) {
    wait(1);
    self.var_d1a09d1e = newclienthudelem(self);
    self.var_d1a09d1e.alignx = "center";
    self.var_d1a09d1e.aligny = "middle";
    self.var_d1a09d1e.horzalign = "center";
    self.var_d1a09d1e.vertalign = "middle";
    self.var_d1a09d1e.foreground = 1;
    self.var_d1a09d1e.fontscale = 2;
    self.var_d1a09d1e.alpha = 0;
    self.var_d1a09d1e.color = (1, 1, 1);
    self.var_d1a09d1e settext(%GAME_TEAMMATE_DIED, var_34ab38ea);
    self.var_d1a09d1e fadeovertime(1);
    self.var_d1a09d1e.alpha = 1;
}

// Namespace coop
// Params 0, eflags: 0x1 linked
// Checksum 0x1649b21e, Offset: 0x25a8
// Size: 0xea
function function_c14603ce() {
    self endon(#"disconnect");
    self endon(#"hash_1528244e");
    level endon(#"game_ended");
    self clientfield::set_to_player("killcam_menu", 1);
    /#
        printtoprightln("teamScorePerKill", (1, 0, 1));
    #/
    while (self usebuttonpressed()) {
        wait(0.05);
    }
    while (!self usebuttonpressed()) {
        wait(0.05);
    }
    self.var_acfedf1c = 1;
    self clientfield::set_to_player("killcam_menu", 0);
    self notify(#"hash_261f3a82");
}

// Namespace coop
// Params 0, eflags: 0x1 linked
// Checksum 0x578e4791, Offset: 0x26a0
// Size: 0x188
function function_e82a1210() {
    if (!isdefined(self.var_ee8c475a)) {
        self.var_ee8c475a = newclienthudelem(self);
        self.var_ee8c475a.archived = 0;
        self.var_ee8c475a.x = 0;
        self.var_ee8c475a.alignx = "center";
        self.var_ee8c475a.aligny = "middle";
        self.var_ee8c475a.horzalign = "center";
        self.var_ee8c475a.vertalign = "bottom";
        self.var_ee8c475a.sort = 1;
        self.var_ee8c475a.font = "objective";
    }
    if (self issplitscreen()) {
        self.var_ee8c475a.y = -100;
        self.var_ee8c475a.fontscale = 1;
    } else {
        self.var_ee8c475a.y = -180;
        self.var_ee8c475a.fontscale = 1.5;
    }
    self.var_ee8c475a settext(%MENU_CP_KILLCAM_PROMPT);
    self.var_ee8c475a.alpha = 1;
}

// Namespace coop
// Params 0, eflags: 0x1 linked
// Checksum 0x2c0e4c8a, Offset: 0x2830
// Size: 0x194
function function_44e35f1a() {
    self endon(#"disconnect");
    self endon(#"hash_1528244e");
    self endon(#"end_respawn");
    level endon(#"game_ended");
    self function_e82a1210();
    /#
        printtoprightln("teamScorePerKill", (1, 0, 1));
    #/
    while (self usebuttonpressed()) {
        wait(0.05);
    }
    while (!self usebuttonpressed()) {
        wait(0.05);
    }
    self.var_acfedf1c = 1;
    self.var_ee8c475a.alpha = 0;
    if (isdefined(level.var_3a9f9a38) && level.var_3a9f9a38) {
        killcamentitystarttime = 0;
        perks = [];
        killstreaks = [];
        self killcam::killcam(self getentitynumber(), self getentitynumber(), self.var_ca78829f, self.var_1b7a74aa, killcamentitystarttime, self.killcamweapon, self.deathtime, self.var_8c0347ee, self.var_2b1ad8b, 1, undefined, perks, killstreaks, self);
    }
}

// Namespace coop
// Params 0, eflags: 0x1 linked
// Checksum 0xadc7c4be, Offset: 0x29d0
// Size: 0x1d4
function function_6dc12009() {
    if (!(isdefined(level.var_ee7cb602) && level.var_ee7cb602)) {
        foreach (player in level.players) {
            if (player != self && player.sessionstate != "dead" && player.sessionstate != "spectator" && !(isdefined(player.laststand) && player.laststand)) {
                return;
            }
        }
    }
    if (!(isdefined(level.level_ending) && level.level_ending)) {
        if (isdefined(self) && self.lives === 0 && self function_76f34311("cybercom_emergencyreserve") != 0) {
            self.lives = 1;
            self setnoncheckpointdata("lives", self.lives);
        }
        level thread function_5ed5738a();
    }
    level.level_ending = 1;
    /#
        if (!(isdefined(level.level_ending) && level.level_ending)) {
            errormsg("teamScorePerKill");
        }
    #/
}

// Namespace coop
// Params 0, eflags: 0x1 linked
// Checksum 0x2e80bc7c, Offset: 0x2bb0
// Size: 0x120
function wait_to_spawn() {
    self notify(#"hash_e5088dc8");
    self endon(#"hash_e5088dc8");
    if (isdefined(level.inprematchperiod) && (isdefined(level.is_safehouse) && level.is_safehouse || level.inprematchperiod) || !isdefined(self.var_a90a3829)) {
        self.var_a90a3829 = 1;
        return true;
    }
    if (self issplitscreen()) {
        util::setlowermessage(game["strings"]["waiting_to_spawn_ss"], 15, 1);
    } else {
        util::setlowermessage(game["strings"]["waiting_to_spawn"], 15);
    }
    level util::waittill_any_timeout(15, "objective_changed");
    return true;
}

// Namespace coop
// Params 0, eflags: 0x1 linked
// Checksum 0xb4af9a96, Offset: 0x2cd8
// Size: 0xfe
function function_7185e36b() {
    level flag::wait_till("all_players_spawned");
    while (true) {
        level waittill(#"objective_changed");
        foreach (player in level.players) {
            if (player.sessionstate == "spectator" && globallogic_utils::isvalidclass(player.curclass)) {
                player globallogic_spawn::waitandspawnclient();
            }
        }
    }
}

// Namespace coop
// Params 0, eflags: 0x1 linked
// Checksum 0x824977de, Offset: 0x2de0
// Size: 0x18
function spawnedasspectator() {
    if (!isdefined(self.var_a90a3829)) {
        return true;
    }
    return false;
}

// Namespace coop
// Params 0, eflags: 0x1 linked
// Checksum 0xc7bfb4c9, Offset: 0x2e00
// Size: 0x2b6
function function_e9f7384d() {
    self endon(#"death");
    self endon(#"disconnect");
    if (isdefined(self.currentweapon.isheroweapon) && self.currentweapon.isheroweapon) {
        return;
    }
    a_weaponlist = self getweaponslist();
    var_961f11b8 = [];
    foreach (weapon in a_weaponlist) {
        if (isdefined(weapon.isheroweapon) && weapon.isheroweapon) {
            if (!isdefined(var_961f11b8)) {
                var_961f11b8 = [];
            } else if (!isarray(var_961f11b8)) {
                var_961f11b8 = array(var_961f11b8);
            }
            var_961f11b8[var_961f11b8.size] = weapon;
        }
    }
    w_hero = var_961f11b8[0];
    if (isdefined(w_hero)) {
        if (self getweaponammoclip(w_hero) + self getweaponammostock(w_hero) > 0) {
            if (isdefined(self.var_928b1776)) {
                if (gettime() - self.var_928b1776 > 90000) {
                    switch (w_hero.rootweapon.name) {
                    case 84:
                        if (self.var_9b416318 < 5) {
                            self util::show_hint_text(%COOP_EQUIP_XM53);
                        }
                        break;
                    case 86:
                        if (self.var_9b416318 < 10) {
                            self util::show_hint_text(%COOP_EQUIP_SPIKE_LAUNCHER);
                        }
                        break;
                    case 85:
                        if (self.var_9b416318 < 10) {
                            self util::show_hint_text(%COOP_EQUIP_MICROMISSILE);
                        }
                        break;
                    }
                }
            }
        }
    }
}

// Namespace coop
// Params 0, eflags: 0x1 linked
// Checksum 0x8da56e8a, Offset: 0x30c0
// Size: 0xf6
function function_51525e38() {
    self notify(#"hash_dc0f8e82");
    self endon(#"death");
    self endon(#"hash_dc0f8e82");
    for (var_a151e229 = 0; true; var_a151e229 = 0) {
        e_weapon = self waittill(#"weapon_change");
        if (isdefined(e_weapon)) {
            if (isdefined(e_weapon.isheroweapon) && e_weapon.isheroweapon) {
                if (!isdefined(self.var_9b416318)) {
                    self.var_9b416318 = 0;
                }
                self thread function_e9b4a63b();
                var_a151e229 = 1;
                continue;
            }
            if (var_a151e229) {
                self.var_928b1776 = gettime();
            }
            self notify(#"hash_79135cb3");
        }
    }
}

// Namespace coop
// Params 0, eflags: 0x1 linked
// Checksum 0x91bfa7b, Offset: 0x31c0
// Size: 0x70
function function_e9b4a63b() {
    self endon(#"death");
    self endon(#"hash_79135cb3");
    while (true) {
        e_weapon = self waittill(#"weapon_fired");
        if (isdefined(e_weapon.isheroweapon) && e_weapon.isheroweapon) {
            self.var_9b416318++;
        }
    }
}

