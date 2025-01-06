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
#using scripts/shared/abilities/gadgets/_gadget_resurrect;
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
#using scripts/shared/util_shared;

#namespace sd;

// Namespace sd
// Params 0, eflags: 0x0
// Checksum 0x2277a304, Offset: 0xc48
// Size: 0x2f2
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
    level.playerspawnedcb = &sd_playerspawnedcb;
    level.onplayerkilled = &onplayerkilled;
    level.ondeadevent = &ondeadevent;
    level.ononeleftevent = &ononeleftevent;
    level.ontimelimit = &ontimelimit;
    level.onroundswitch = &onroundswitch;
    level.getteamkillpenalty = &sd_getteamkillpenalty;
    level.getteamkillscore = &sd_getteamkillscore;
    level.iskillboosting = &sd_iskillboosting;
    level.endgameonscorelimit = 0;
    gameobjects::register_allowed_gameobject(level.gametype);
    gameobjects::register_allowed_gameobject("bombzone");
    gameobjects::register_allowed_gameobject("blocker");
    globallogic_audio::set_leader_gametype_dialog("startSearchAndDestroy", "hcStartSearchAndDestroy", "objDestroy", "objDefend");
    if (!sessionmodeissystemlink() && !sessionmodeisonlinegame() && issplitscreen()) {
        globallogic::setvisiblescoreboardcolumns("score", "kills", "plants", "defuses", "deaths");
        return;
    }
    globallogic::setvisiblescoreboardcolumns("score", "kills", "deaths", "plants", "defuses");
}

// Namespace sd
// Params 0, eflags: 0x0
// Checksum 0xdf92752e, Offset: 0xf48
// Size: 0x11
function onprecachegametype() {
    InvalidOpCode(0xc8, "bomb_dropped_sound", "fly_bomb_drop_plr");
    // Unknown operator (0xc8, t7_1b, PC)
}

// Namespace sd
// Params 4, eflags: 0x0
// Checksum 0x1ee37a1d, Offset: 0xf78
// Size: 0x7f
function sd_getteamkillpenalty(einflictor, attacker, smeansofdeath, weapon) {
    teamkill_penalty = globallogic_defaults::default_getteamkillpenalty(einflictor, attacker, smeansofdeath, weapon);
    if (isdefined(self.isplanting) && (isdefined(self.isdefusing) && self.isdefusing || self.isplanting)) {
        teamkill_penalty *= level.teamkillpenaltymultiplier;
    }
    return teamkill_penalty;
}

// Namespace sd
// Params 4, eflags: 0x0
// Checksum 0xca90af1f, Offset: 0x1000
// Size: 0x91
function sd_getteamkillscore(einflictor, attacker, smeansofdeath, weapon) {
    teamkill_score = rank::getscoreinfovalue("team_kill");
    if (isdefined(self.isplanting) && (isdefined(self.isdefusing) && self.isdefusing || self.isplanting)) {
        teamkill_score *= level.teamkillscoremultiplier;
    }
    return int(teamkill_score);
}

// Namespace sd
// Params 0, eflags: 0x0
// Checksum 0x88911803, Offset: 0x10a0
// Size: 0x11
function onroundswitch() {
    InvalidOpCode(0x54, "switchedsides");
    // Unknown operator (0x54, t7_1b, PC)
}

// Namespace sd
// Params 0, eflags: 0x0
// Checksum 0x6b8d8957, Offset: 0x1168
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

// Namespace sd
// Params 0, eflags: 0x0
// Checksum 0xa0fe23cf, Offset: 0x1300
// Size: 0x81
function onstartgametype() {
    setbombtimer("A", 0);
    setmatchflag("bomb_timer_a", 0);
    setbombtimer("B", 0);
    setmatchflag("bomb_timer_b", 0);
    InvalidOpCode(0x54, "switchedsides");
    // Unknown operator (0x54, t7_1b, PC)
}

// Namespace sd
// Params 1, eflags: 0x0
// Checksum 0x7a762e82, Offset: 0x1688
// Size: 0x32
function onspawnplayer(predictedspawn) {
    self.isplanting = 0;
    self.isdefusing = 0;
    self.isbombcarrier = 0;
    spawning::onspawnplayer(predictedspawn);
}

// Namespace sd
// Params 0, eflags: 0x0
// Checksum 0xa840ebf0, Offset: 0x16c8
// Size: 0xb
function sd_playerspawnedcb() {
    level notify(#"spawned_player");
}

// Namespace sd
// Params 9, eflags: 0x0
// Checksum 0xe50bc2db, Offset: 0x16e0
// Size: 0x3a2
function onplayerkilled(einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime, deathanimduration) {
    thread checkallowspectating();
    if (isdefined(level.droppedtagrespawn) && level.droppedtagrespawn) {
        should_spawn_tags = self dogtags::should_spawn_tags(einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime, deathanimduration);
        should_spawn_tags = should_spawn_tags && !globallogic_spawn::mayspawn();
        if (should_spawn_tags) {
            level thread dogtags::spawn_dog_tag(self, attacker, &dogtags::onusedogtag, 0);
        }
    }
    if (isplayer(attacker) && attacker.pers["team"] != self.pers["team"]) {
        scoreevents::processscoreevent("kill_sd", attacker, self, weapon);
    }
    inbombzone = 0;
    for (index = 0; index < level.bombzones.size; index++) {
        dist = distance2d(self.origin, level.bombzones[index].curorigin);
        if (dist < level.defaultoffenseradius) {
            inbombzone = 1;
        }
    }
    if (inbombzone && isplayer(attacker) && attacker.pers["team"] != self.pers["team"]) {
        InvalidOpCode(0x54, "defenders");
        // Unknown operator (0x54, t7_1b, PC)
    }
    if (isplayer(attacker) && attacker.pers["team"] != self.pers["team"] && isdefined(self.isbombcarrier) && self.isbombcarrier == 1) {
        self recordkillmodifier("carrying");
    }
    if (self.isplanting == 1) {
        self recordkillmodifier("planting");
    }
    if (self.isdefusing == 1) {
        self recordkillmodifier("defusing");
    }
}

// Namespace sd
// Params 0, eflags: 0x0
// Checksum 0xf7e22532, Offset: 0x1a90
// Size: 0x4d
function checkallowspectating() {
    self endon(#"disconnect");
    wait 0.05;
    update = 0;
    livesleft = !(level.numlives && !self.pers["lives"]);
    InvalidOpCode(0x54, "attackers");
    // Unknown operator (0x54, t7_1b, PC)
}

// Namespace sd
// Params 2, eflags: 0x0
// Checksum 0xbbcfb914, Offset: 0x1b68
// Size: 0x3a
function sd_endgame(winningteam, endreasontext) {
    if (isdefined(winningteam)) {
        globallogic_score::giveteamscoreforobjective_delaypostprocessing(winningteam, 1);
    }
    thread globallogic::endgame(winningteam, endreasontext);
}

// Namespace sd
// Params 2, eflags: 0x0
// Checksum 0xa961f02a, Offset: 0x1bb0
// Size: 0x22
function function_71bf3665(winningteam, endreasontext) {
    sd_endgame(winningteam, endreasontext);
}

// Namespace sd
// Params 1, eflags: 0x0
// Checksum 0xbff0c321, Offset: 0x1be0
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

// Namespace sd
// Params 1, eflags: 0x0
// Checksum 0x4e1c6074, Offset: 0x1d10
// Size: 0x32
function ononeleftevent(team) {
    if (level.bombexploded || level.bombdefused) {
        return;
    }
    warnlastplayer(team);
}

// Namespace sd
// Params 0, eflags: 0x0
// Checksum 0x7d942594, Offset: 0x1d50
// Size: 0x45
function ontimelimit() {
    if (level.teambased) {
        InvalidOpCode(0x54, "strings", "time_limit_reached");
        // Unknown operator (0x54, t7_1b, PC)
    }
    InvalidOpCode(0x54, "strings", "time_limit_reached");
    // Unknown operator (0x54, t7_1b, PC)
}

// Namespace sd
// Params 1, eflags: 0x0
// Checksum 0x8e56e194, Offset: 0x1db8
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
    players[i] thread givelastattackerwarning(team);
}

// Namespace sd
// Params 1, eflags: 0x0
// Checksum 0x62a3fd04, Offset: 0x1ec0
// Size: 0x51
function givelastattackerwarning(team) {
    self endon(#"death");
    self endon(#"disconnect");
    fullhealthtime = 0;
    interval = 0.05;
    self.lastmansd = 1;
    InvalidOpCode(0x54, "defenders");
    // Unknown operator (0x54, t7_1b, PC)
}

// Namespace sd
// Params 0, eflags: 0x0
// Checksum 0x6ff5702d, Offset: 0x1fc8
// Size: 0x102
function updategametypedvars() {
    level.planttime = getgametypesetting("plantTime");
    level.defusetime = getgametypesetting("defuseTime");
    level.bombtimer = getgametypesetting("bombTimer");
    level.multibomb = getgametypesetting("multiBomb");
    level.teamkillpenaltymultiplier = getgametypesetting("teamKillPenalty");
    level.teamkillscoremultiplier = getgametypesetting("teamKillScore");
    level.playerkillsmax = getgametypesetting("playerKillsMax");
    level.totalkillsmax = getgametypesetting("totalKillsMax");
}

// Namespace sd
// Params 0, eflags: 0x0
// Checksum 0xbcbd6389, Offset: 0x20d8
// Size: 0x739
function bombs() {
    level.bombplanted = 0;
    level.bombdefused = 0;
    level.bombexploded = 0;
    trigger = getent("sd_bomb_pickup_trig", "targetname");
    if (!isdefined(trigger)) {
        /#
            util::error("<dev string:x28>");
        #/
        return;
    }
    visuals[0] = getent("sd_bomb", "targetname");
    if (!isdefined(visuals[0])) {
        /#
            util::error("<dev string:x55>");
        #/
        return;
    }
    if (!level.multibomb) {
        InvalidOpCode(0x54, "attackers", trigger, visuals, (0, 0, 32), %sd_bomb);
        // Unknown operator (0x54, t7_1b, PC)
    }
    trigger delete();
    visuals[0] delete();
    level.bombzones = [];
    bombzones = getentarray("bombzone", "targetname");
    index = 0;
    if (index < bombzones.size) {
        trigger = bombzones[index];
        visuals = getentarray(bombzones[index].target, "targetname");
        name = istring("sd" + trigger.script_label);
        InvalidOpCode(0x54, "defenders", trigger, visuals, (0, 0, 0), name, 1, 1);
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

// Namespace sd
// Params 3, eflags: 0x0
// Checksum 0x37b88997, Offset: 0x2820
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

// Namespace sd
// Params 1, eflags: 0x0
// Checksum 0xf775d112, Offset: 0x28a0
// Size: 0x15a
function onbeginuse(player) {
    if (self gameobjects::is_friendly_team(player.pers["team"])) {
        player playsound("mpl_sd_bomb_defuse");
        player.isdefusing = 1;
        player thread setbomboverheatingafterweaponchange(self, 0, 0);
        player thread battlechatter::gametype_specific_battle_chatter("sd_enemyplant", player.pers["team"]);
        if (isdefined(level.sdbombmodel)) {
            level.sdbombmodel hide();
        }
    } else {
        player.isplanting = 1;
        player thread setbomboverheatingafterweaponchange(self, 0, 0);
        player thread battlechatter::gametype_specific_battle_chatter("sd_friendlyplant", player.pers["team"]);
        if (level.multibomb) {
            for (i = 0; i < self.otherbombzones.size; i++) {
                self.otherbombzones[i] gameobjects::disable_object();
            }
        }
    }
    player playsound("fly_bomb_raise_plr");
}

// Namespace sd
// Params 3, eflags: 0x0
// Checksum 0x2382d318, Offset: 0x2a08
// Size: 0xd9
function onenduse(team, player, result) {
    if (!isdefined(player)) {
        return;
    }
    player.isdefusing = 0;
    player.isplanting = 0;
    player notify(#"event_ended");
    if (self gameobjects::is_friendly_team(player.pers["team"])) {
        if (isdefined(level.sdbombmodel) && !result) {
            level.sdbombmodel show();
        }
        return;
    }
    if (level.multibomb && !result) {
        for (i = 0; i < self.otherbombzones.size; i++) {
            self.otherbombzones[i] gameobjects::enable_object();
        }
    }
}

// Namespace sd
// Params 1, eflags: 0x0
// Checksum 0x4abf4096, Offset: 0x2af0
// Size: 0x22
function oncantuse(player) {
    player iprintlnbold(%MP_CANT_PLANT_WITHOUT_BOMB);
}

// Namespace sd
// Params 1, eflags: 0x0
// Checksum 0x9fb27737, Offset: 0x2b20
// Size: 0x1e2
function onuseplantobject(player) {
    if (!self gameobjects::is_friendly_team(player.pers["team"])) {
        self gameobjects::set_flags(1);
        level thread bombplanted(self, player);
        /#
            print("<dev string:x7b>" + self.label);
        #/
        for (index = 0; index < level.bombzones.size; index++) {
            if (level.bombzones[index] == self) {
                level.bombzones[index].isplanted = 1;
                continue;
            }
            level.bombzones[index] gameobjects::disable_object();
        }
        thread sound::play_on_players("mus_sd_planted" + "_" + level.teampostfix[player.pers["team"]]);
        player notify(#"bomb_planted");
        level thread popups::displayteammessagetoall(%MP_EXPLOSIVES_PLANTED_BY, player);
        if (isdefined(player.pers["plants"])) {
            player.pers["plants"]++;
            player.plants = player.pers["plants"];
        }
        demo::bookmark("event", gettime(), player);
        player addplayerstatwithgametype("PLANTS", 1);
        globallogic_audio::leader_dialog("bombPlanted");
        scoreevents::processscoreevent("planted_bomb", player);
        player recordgameevent("plant");
    }
}

// Namespace sd
// Params 1, eflags: 0x0
// Checksum 0xc294de9c, Offset: 0x2d10
// Size: 0x1e2
function onusedefuseobject(player) {
    self gameobjects::set_flags(0);
    player notify(#"bomb_defused");
    /#
        print("<dev string:x8a>" + self.label);
    #/
    bbprint("mpobjective", "gametime %d objtype %s label %s team %s playerx %d playery %d playerz %d", gettime(), "sd_bombdefuse", self.label, player.pers["team"], player.origin);
    level thread bombdefused(self, player);
    self gameobjects::disable_object();
    for (index = 0; index < level.bombzones.size; index++) {
        level.bombzones[index].isplanted = 0;
    }
    level thread popups::displayteammessagetoall(%MP_EXPLOSIVES_DEFUSED_BY, player);
    if (isdefined(player.pers["defuses"])) {
        player.pers["defuses"]++;
        player.defuses = player.pers["defuses"];
    }
    player addplayerstatwithgametype("DEFUSES", 1);
    demo::bookmark("event", gettime(), player);
    globallogic_audio::leader_dialog("bombDefused");
    if (isdefined(player.lastmansd) && player.lastmansd == 1) {
        scoreevents::processscoreevent("defused_bomb_last_man_alive", player);
    } else {
        scoreevents::processscoreevent("defused_bomb", player);
    }
    player recordgameevent("defuse");
}

// Namespace sd
// Params 1, eflags: 0x0
// Checksum 0x38775c60, Offset: 0x2f00
// Size: 0x99
function ondrop(player) {
    if (!level.bombplanted) {
        InvalidOpCode(0x54, "attackers");
        // Unknown operator (0x54, t7_1b, PC)
    }
    player notify(#"event_ended");
    self gameobjects::set_3d_icon("friendly", "waypoint_bomb");
    InvalidOpCode(0x54, "attackers");
    // Unknown operator (0x54, t7_1b, PC)
}

// Namespace sd
// Params 1, eflags: 0x0
// Checksum 0xb6b16084, Offset: 0x2fd0
// Size: 0x178
function onpickup(player) {
    player.isbombcarrier = 1;
    player recordgameevent("pickup");
    self gameobjects::set_3d_icon("friendly", "waypoint_defend");
    if (!level.bombdefused) {
        if (isdefined(player) && isdefined(player.name)) {
            player addplayerstatwithgametype("PICKUPS", 1);
        }
        team = self gameobjects::get_owner_team();
        otherteam = util::getotherteam(team);
        InvalidOpCode(0x54, "attackers");
        // Unknown operator (0x54, t7_1b, PC)
    }
    player playsound("fly_bomb_pickup_plr");
    for (i = 0; i < level.bombzones.size; i++) {
        level.bombzones[i].trigger setinvisibletoall();
        level.bombzones[i].trigger setvisibletoplayer(player);
    }
    if (isdefined(level.bombpickupbotevent)) {
        [[ level.bombpickupbotevent ]]();
    }
}

// Namespace sd
// Params 0, eflags: 0x0
// Checksum 0xe9c07cd6, Offset: 0x3150
// Size: 0x2
function onreset() {
    
}

// Namespace sd
// Params 0, eflags: 0x0
// Checksum 0x3e13a984, Offset: 0x3160
// Size: 0x7a
function bombplantedmusicdelay() {
    level endon(#"bomb_defused");
    time = level.bombtimer - 30;
    /#
        if (getdvarint("<dev string:xb1>") > 0) {
            println("<dev string:xbd>" + time);
        }
    #/
    if (time > 1) {
        wait time;
        thread globallogic_audio::set_music_on_team("timeOutQuiet");
    }
}

// Namespace sd
// Params 2, eflags: 0x0
// Checksum 0xe9f58628, Offset: 0x31e8
// Size: 0x4f5
function bombplanted(destroyedobj, player) {
    globallogic_utils::pausetimer();
    level.bombplanted = 1;
    player setweaponoverheating(1, 100, destroyedobj.useweapon);
    team = player.pers["team"];
    destroyedobj.visuals[0] thread globallogic_utils::playtickingsound("mpl_sab_ui_suitcasebomb_timer");
    level thread bombplantedmusicdelay();
    level.tickingobject = destroyedobj.visuals[0];
    level.timelimitoverride = 1;
    setgameendtime(int(gettime() + level.bombtimer * 1000));
    label = destroyedobj gameobjects::get_label();
    setmatchflag("bomb_timer" + label, 1);
    if (label == "_a") {
        setbombtimer("A", int(gettime() + level.bombtimer * 1000));
        setmatchflag("bomb_timer_a", 1);
    } else {
        setbombtimer("B", int(gettime() + level.bombtimer * 1000));
        setmatchflag("bomb_timer_b", 1);
    }
    bbprint("mpobjective", "gametime %d objtype %s label %s team %s playerx %d playery %d playerz %d", gettime(), "sd_bombplant", label, team, player.origin);
    if (!level.multibomb) {
        level.sdbomb gameobjects::allow_carry("none");
        level.sdbomb gameobjects::set_visible_team("none");
        level.sdbomb gameobjects::set_dropped();
        level.sdbombmodel = level.sdbomb.visuals[0];
    } else {
        for (index = 0; index < level.players.size; index++) {
            if (isdefined(level.players[index].carryicon)) {
                level.players[index].carryicon hud::destroyelem();
            }
        }
        trace = bullettrace(player.origin + (0, 0, 20), player.origin - (0, 0, 2000), 0, player);
        tempangle = randomfloat(360);
        forward = (cos(tempangle), sin(tempangle), 0);
        forward = vectornormalize(forward - vectorscale(trace["normal"], vectordot(forward, trace["normal"])));
        dropangles = vectortoangles(forward);
        level.sdbombmodel = spawn("script_model", trace["position"]);
        level.sdbombmodel.angles = dropangles;
        level.sdbombmodel setmodel("p7_mp_suitcase_bomb");
    }
    destroyedobj gameobjects::allow_use("none");
    destroyedobj gameobjects::set_visible_team("none");
    label = destroyedobj gameobjects::get_label();
    trigger = destroyedobj.bombdefusetrig;
    trigger.origin = level.sdbombmodel.origin;
    visuals = [];
    InvalidOpCode(0x54, "defenders", trigger, visuals, (0, 0, 32), istring("sd_defuse" + label), 1, 1);
    // Unknown operator (0x54, t7_1b, PC)
}

// Namespace sd
// Params 0, eflags: 0x0
// Checksum 0xc2d765a4, Offset: 0x3bc8
// Size: 0x2a
function bombtimerwait() {
    level endon(#"game_ended");
    level endon(#"bomb_defused");
    hostmigration::waitlongdurationwithgameendtimeupdate(level.bombtimer);
}

// Namespace sd
// Params 2, eflags: 0x0
// Checksum 0x6418ab8a, Offset: 0x3c00
// Size: 0xf9
function bombdefused(defusedobject, player) {
    level.tickingobject globallogic_utils::stoptickingsound();
    level.bombdefused = 1;
    player setweaponoverheating(1, 100, defusedobject.useweapon);
    setbombtimer("A", 0);
    setbombtimer("B", 0);
    setmatchflag("bomb_timer_a", 0);
    setmatchflag("bomb_timer_b", 0);
    level notify(#"bomb_defused");
    thread globallogic_audio::set_music_on_team("silent");
    wait 1.5;
    setgameendtime(0);
    InvalidOpCode(0x54, "strings", "bomb_defused");
    // Unknown operator (0x54, t7_1b, PC)
}

// Namespace sd
// Params 0, eflags: 0x0
// Checksum 0xda512049, Offset: 0x3d20
// Size: 0x31
function sd_iskillboosting() {
    roundsplayed = util::getroundsplayed();
    if (level.playerkillsmax == 0) {
        return false;
    }
    InvalidOpCode(0x54, "totalKills");
    // Unknown operator (0x54, t7_1b, PC)
}

