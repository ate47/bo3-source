#using scripts/mp/_util;
#using scripts/mp/gametypes/_battlechatter;
#using scripts/mp/gametypes/_globallogic;
#using scripts/mp/gametypes/_globallogic_audio;
#using scripts/mp/gametypes/_globallogic_score;
#using scripts/mp/gametypes/_globallogic_utils;
#using scripts/mp/gametypes/_hostmigration;
#using scripts/mp/gametypes/_hud_message;
#using scripts/mp/gametypes/_spawning;
#using scripts/mp/gametypes/_spawnlogic;
#using scripts/shared/demo_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/gameobjects_shared;
#using scripts/shared/hostmigration_shared;
#using scripts/shared/hud_message_shared;
#using scripts/shared/math_shared;
#using scripts/shared/medals_shared;
#using scripts/shared/popups_shared;
#using scripts/shared/scoreevents_shared;
#using scripts/shared/sound_shared;

#namespace sab;

// Namespace sab
// Params 0, eflags: 0x0
// Checksum 0xbd2f67e6, Offset: 0xb90
// Size: 0x121
function main() {
    globallogic::init();
    level.teambased = 1;
    level.overrideteamscore = 1;
    util::registerroundswitch(0, 9);
    util::registertimelimit(0, 1440);
    util::registerscorelimit(0, 500);
    util::registerroundlimit(0, 10);
    util::registernumlives(0, 100);
    util::registerroundwinlimit(0, 10);
    globallogic::registerfriendlyfiredelay(level.gametype, 15, 0, 1440);
    level.onstartgametype = &onstartgametype;
    level.onspawnplayer = &onspawnplayer;
    level.onroundendgame = &onroundendgame;
    gameobjects::register_allowed_gameobject(level.gametype);
    InvalidOpCode(0x54, "tiebreaker");
    // Unknown operator (0x54, t7_1b, PC)
}

// Namespace sab
// Params 0, eflags: 0x0
// Checksum 0xd2249595, Offset: 0xf80
// Size: 0x11
function onprecachegametype() {
    InvalidOpCode(0xc8, "bomb_dropped_sound", "mp_war_objective_lost");
    // Unknown operator (0xc8, t7_1b, PC)
}

// Namespace sab
// Params 0, eflags: 0x0
// Checksum 0x872ee0a7, Offset: 0xfb0
// Size: 0x9
function onroundswitch() {
    InvalidOpCode(0x54, "switchedsides");
    // Unknown operator (0x54, t7_1b, PC)
}

// Namespace sab
// Params 0, eflags: 0x0
// Checksum 0x79370550, Offset: 0x1060
// Size: 0x31
function onstartgametype() {
    InvalidOpCode(0x54, "switchedsides");
    // Unknown operator (0x54, t7_1b, PC)
}

// Namespace sab
// Params 0, eflags: 0x0
// Checksum 0xad68ae4d, Offset: 0x14d0
// Size: 0x1a
function ontimelimit() {
    if (level.inovertime) {
        return;
    }
    thread function_5e994bd3();
}

// Namespace sab
// Params 0, eflags: 0x0
// Checksum 0xfc8fe95a, Offset: 0x14f8
// Size: 0x19d
function function_5e994bd3() {
    level endon(#"game_ended");
    level.timelimitoverride = 1;
    level.inovertime = 1;
    globallogic_audio::leader_dialog("sudden_death");
    globallogic_audio::leader_dialog("sudden_death_boost");
    for (index = 0; index < level.players.size; index++) {
        level.players[index] notify(#"force_spawn");
        level.players[index] thread hud_message::function_2bb1fc0(%MP_SUDDEN_DEATH, %MP_NO_RESPAWN, undefined, (1, 0, 0), "mp_last_stand");
        level.players[index] setclientuivisibilityflag("g_compassShowEnemies", 1);
    }
    setmatchtalkflag("DeadChatWithDead", 1);
    setmatchtalkflag("DeadChatWithTeam", 0);
    setmatchtalkflag("DeadHearTeamLiving", 0);
    setmatchtalkflag("DeadHearAllLiving", 0);
    setmatchtalkflag("EveryoneHearsEveryone", 0);
    waittime = 0;
    while (waittime < 90) {
        if (!level.bombplanted) {
            waittime += 1;
            setgameendtime(gettime() + (90 - waittime) * 1000);
        }
        wait 1;
    }
    InvalidOpCode(0x54, "strings", "tie");
    // Unknown operator (0x54, t7_1b, PC)
}

// Namespace sab
// Params 1, eflags: 0x0
// Checksum 0x99448568, Offset: 0x16b8
// Size: 0x15d
function ondeadevent(team) {
    if (level.bombexploded) {
        return;
    }
    if (team == "all") {
        if (level.bombplanted) {
            globallogic_score::giveteamscoreforobjective(level.var_97d99fc4, 1);
            InvalidOpCode(0x54, "strings", level.var_97d99fc4 + "_mission_accomplished");
            // Unknown operator (0x54, t7_1b, PC)
        }
        InvalidOpCode(0x54, "strings", "tie");
        // Unknown operator (0x54, t7_1b, PC)
    }
    if (level.bombplanted) {
        if (team == level.var_97d99fc4) {
            level.var_9031e005 = 1;
            return;
        }
        otherteam = util::getotherteam(level.var_97d99fc4) globallogic_score::giveteamscoreforobjective(level.var_97d99fc4, 1);
        InvalidOpCode(0x54, "strings", otherteam + "_eliminated");
        // Unknown operator (0x54, t7_1b, PC)
    }
    otherteam = util::getotherteam(team) globallogic_score::giveteamscoreforobjective(otherteam, 1);
    InvalidOpCode(0x54, "strings", team + "_eliminated");
    // Unknown operator (0x54, t7_1b, PC)
}

// Namespace sab
// Params 1, eflags: 0x0
// Checksum 0x6f704e02, Offset: 0x1838
// Size: 0x29
function onspawnplayer(predictedspawn) {
    self.isplanting = 0;
    self.isdefusing = 0;
    self.isbombcarrier = 0;
    InvalidOpCode(0x54, "tiebreaker");
    // Unknown operator (0x54, t7_1b, PC)
}

// Namespace sab
// Params 0, eflags: 0x0
// Checksum 0x311a9bfc, Offset: 0x1938
// Size: 0x82
function updategametypedvars() {
    level.planttime = getgametypesetting("plantTime");
    level.defusetime = getgametypesetting("defuseTime");
    level.bombtimer = getgametypesetting("bombTimer");
    level.hotPotato = getgametypesetting("hotPotato");
}

// Namespace sab
// Params 0, eflags: 0x0
// Checksum 0xe7eb414c, Offset: 0x19c8
// Size: 0x321
function function_158500a5() {
    level.bombplanted = 0;
    level.bombexploded = 0;
    level._effect["bombexplosion"] = "_t6/maps/mp_maps/fx_mp_exp_bomb";
    trigger = getent("sab_bomb_pickup_trig", "targetname");
    if (!isdefined(trigger)) {
        util::error("No sab_bomb_pickup_trig trigger found in map.");
        return;
    }
    visuals[0] = getent("sab_bomb", "targetname");
    if (!isdefined(visuals[0])) {
        util::error("No sab_bomb script_model found in map.");
        return;
    }
    level.var_b3f3e65d = gameobjects::create_carry_object("neutral", trigger, visuals, (0, 0, 32));
    level.var_b3f3e65d gameobjects::allow_carry("any");
    level.var_b3f3e65d gameobjects::set_2d_icon("enemy", "compass_waypoint_bomb");
    level.var_b3f3e65d gameobjects::set_3d_icon("enemy", "waypoint_bomb");
    level.var_b3f3e65d gameobjects::set_2d_icon("friendly", "compass_waypoint_bomb");
    level.var_b3f3e65d gameobjects::set_3d_icon("friendly", "waypoint_bomb");
    level.var_b3f3e65d gameobjects::set_carry_icon("hud_suitcase_bomb");
    level.var_b3f3e65d gameobjects::set_visible_team("any");
    level.var_b3f3e65d.objidpingenemy = 1;
    level.var_b3f3e65d.onpickup = &onpickup;
    level.var_b3f3e65d.ondrop = &ondrop;
    level.var_b3f3e65d.allowweapons = 1;
    level.var_b3f3e65d.objpoints["allies"].archived = 1;
    level.var_b3f3e65d.objpoints["axis"].archived = 1;
    level.var_b3f3e65d.autoresettime = 60;
    if (!isdefined(getent("sab_bomb_axis", "targetname"))) {
        /#
            util::error("<dev string:x28>");
        #/
        return;
    }
    if (!isdefined(getent("sab_bomb_allies", "targetname"))) {
        /#
            util::error("<dev string:x4f>");
        #/
        return;
    }
    InvalidOpCode(0x54, "switchedsides");
    // Unknown operator (0x54, t7_1b, PC)
}

// Namespace sab
// Params 2, eflags: 0x0
// Checksum 0x4e6b975, Offset: 0x1e28
// Size: 0x185
function createbombzone(team, trigger) {
    visuals = getentarray(trigger.target, "targetname");
    bombzone = gameobjects::create_use_object(team, trigger, visuals, (0, 0, 64));
    bombzone resetbombsite();
    bombzone.onuse = &onuse;
    bombzone.onbeginuse = &onbeginuse;
    bombzone.onenduse = &onenduse;
    bombzone.oncantuse = &oncantuse;
    bombzone.useweapon = getweapon("briefcase_bomb");
    bombzone.visuals[0].killcament = spawn("script_model", bombzone.visuals[0].origin + (0, 0, 128));
    for (i = 0; i < visuals.size; i++) {
        if (isdefined(visuals[i].script_exploder)) {
            bombzone.exploderindex = visuals[i].script_exploder;
            break;
        }
    }
    return bombzone;
}

// Namespace sab
// Params 1, eflags: 0x0
// Checksum 0xda862cce, Offset: 0x1fb8
// Size: 0xb2
function onbeginuse(player) {
    if (!self gameobjects::is_friendly_team(player.pers["team"])) {
        player.isplanting = 1;
        player thread battlechatter::gametype_specific_battle_chatter("sd_friendlyplant", player.pers["team"]);
    } else {
        player.isdefusing = 1;
        player thread battlechatter::gametype_specific_battle_chatter("sd_enemyplant", player.pers["team"]);
    }
    player playsound("fly_bomb_raise_plr");
}

// Namespace sab
// Params 3, eflags: 0x0
// Checksum 0x6aca8ba2, Offset: 0x2078
// Size: 0x50
function onenduse(team, player, result) {
    if (!isalive(player)) {
        return;
    }
    player.isplanting = 0;
    player.isdefusing = 0;
    player notify(#"event_ended");
}

// Namespace sab
// Params 1, eflags: 0x0
// Checksum 0x8bb2927a, Offset: 0x20d0
// Size: 0x1e9
function onpickup(player) {
    level notify(#"hash_8520aca0");
    player recordgameevent("pickup");
    self.autoresettime = 60;
    level.usestartspawns = 0;
    team = player.pers["team"];
    if (team == "allies") {
        otherteam = "axis";
    } else {
        otherteam = "allies";
    }
    player playlocalsound("mp_suitcase_pickup");
    /#
        print("<dev string:x78>");
    #/
    excludelist[0] = player;
    if (gettime() - level.var_c2a60b96 > 10000) {
        globallogic_audio::leader_dialog("bomb_acquired", team);
        player globallogic_audio::leader_dialog_on_player("obj_destroy", "bomb");
        if (!level.splitscreen) {
            globallogic_audio::leader_dialog("bomb_taken", otherteam);
            globallogic_audio::leader_dialog("obj_defend", otherteam);
        }
        level.var_c2a60b96 = gettime();
    }
    player.isbombcarrier = 1;
    player addplayerstatwithgametype("PICKUPS", 1);
    if (team == self gameobjects::get_owner_team()) {
        util::printonteamarg(%MP_EXPLOSIVES_RECOVERED_BY, team, player);
        InvalidOpCode(0x54, "bomb_recovered_sound", team);
        // Unknown operator (0x54, t7_1b, PC)
    }
    util::printonteamarg(%MP_EXPLOSIVES_RECOVERED_BY, team, player);
    InvalidOpCode(0x54, "bomb_recovered_sound");
    // Unknown operator (0x54, t7_1b, PC)
}

// Namespace sab
// Params 1, eflags: 0x0
// Checksum 0x64a22ff5, Offset: 0x2400
// Size: 0x142
function ondrop(player) {
    if (level.bombplanted) {
        return;
    }
    if (isdefined(player)) {
        util::printonteamarg(%MP_EXPLOSIVES_DROPPED_BY, self gameobjects::get_owner_team(), player);
    }
    InvalidOpCode(0x54, "bomb_dropped_sound", self gameobjects::get_owner_team());
    // Unknown operator (0x54, t7_1b, PC)
}

// Namespace sab
// Params 1, eflags: 0x0
// Checksum 0xbb4a4c47, Offset: 0x2550
// Size: 0x65
function function_49ac7e58(delay) {
    level endon(#"hash_8520aca0");
    wait delay;
    if (isdefined(self.carrier)) {
        return;
    }
    if (self gameobjects::get_owner_team() == "allies") {
        otherteam = "axis";
    } else {
        otherteam = "allies";
    }
    InvalidOpCode(0x54, "bomb_dropped_sound", otherteam);
    // Unknown operator (0x54, t7_1b, PC)
}

// Namespace sab
// Params 1, eflags: 0x0
// Checksum 0x17187a57, Offset: 0x26d0
// Size: 0x3fa
function onuse(player) {
    team = player.pers["team"];
    otherteam = util::getotherteam(team);
    if (!self gameobjects::is_friendly_team(player.pers["team"])) {
        player notify(#"bomb_planted");
        /#
            print("<dev string:x90>");
        #/
        if (isdefined(player.pers["plants"])) {
            player.pers["plants"]++;
            player.plants = player.pers["plants"];
        }
        demo::bookmark("event", gettime(), player);
        player addplayerstatwithgametype("PLANTS", 1);
        level thread popups::displayteammessagetoall(%MP_EXPLOSIVES_PLANTED_BY, player);
        globallogic_audio::set_music_on_team("ACTION", "both", 1);
        globallogic_audio::leader_dialog("bomb_planted", team);
        globallogic_audio::leader_dialog("bomb_planted", otherteam);
        scoreevents::processscoreevent("planted_bomb", player);
        player recordgameevent("plant");
        level thread bombplanted(self, player.pers["team"]);
        level.bombowner = player;
        player.isbombcarrier = 0;
        level.var_b3f3e65d.autoresettime = undefined;
        level.var_b3f3e65d gameobjects::allow_carry("none");
        level.var_b3f3e65d gameobjects::set_visible_team("none");
        level.var_b3f3e65d gameobjects::set_dropped();
        self.useweapon = getweapon("briefcase_bomb_defuse");
        self setupfordefusing();
        return;
    }
    player notify(#"bomb_defused");
    /#
        print("<dev string:x9d>");
    #/
    if (isdefined(player.pers["defuses"])) {
        player.pers["defuses"]++;
        player.defuses = player.pers["defuses"];
    }
    demo::bookmark("event", gettime(), player);
    player addplayerstatwithgametype("DEFUSES", 1);
    level thread popups::displayteammessagetoall(%MP_EXPLOSIVES_DEFUSED_BY, player);
    globallogic_audio::leader_dialog("bomb_defused");
    scoreevents::processscoreevent("defused_bomb", player);
    player recordgameevent("defuse");
    level thread bombdefused(self);
    if (level.inovertime && isdefined(level.var_9031e005)) {
        InvalidOpCode(0x54, "strings", level.var_97d99fc4 + "_eliminated");
        // Unknown operator (0x54, t7_1b, PC)
    }
    self resetbombsite();
    level.var_b3f3e65d gameobjects::allow_carry("any");
    level.var_b3f3e65d gameobjects::set_picked_up(player);
}

// Namespace sab
// Params 1, eflags: 0x0
// Checksum 0x47809d3c, Offset: 0x2ad8
// Size: 0x22
function oncantuse(player) {
    player iprintlnbold(%MP_CANT_PLANT_WITHOUT_BOMB);
}

// Namespace sab
// Params 2, eflags: 0x0
// Checksum 0x3e71b89a, Offset: 0x2b08
// Size: 0x49
function bombplanted(destroyedobj, team) {
    InvalidOpCode(0xc8, "challenge", team, "plantedBomb", 1);
    // Unknown operator (0xc8, t7_1b, PC)
}

// Namespace sab
// Params 0, eflags: 0x0
// Checksum 0xac433362, Offset: 0x2ee0
// Size: 0x22
function bombtimerwait() {
    level endon(#"bomb_defused");
    hostmigration::waitlongdurationwithgameendtimeupdate(level.bombtimer);
}

// Namespace sab
// Params 0, eflags: 0x0
// Checksum 0xdff2ff57, Offset: 0x2f10
// Size: 0x14a
function resetbombsite() {
    self gameobjects::allow_use("enemy");
    self gameobjects::set_use_time(level.planttime);
    self gameobjects::set_use_text(%MP_PLANTING_EXPLOSIVE);
    self gameobjects::set_use_hint_text(%PLATFORM_HOLD_TO_PLANT_EXPLOSIVES);
    self gameobjects::set_key_object(level.var_b3f3e65d);
    self gameobjects::set_2d_icon("friendly", "compass_waypoint_defend");
    self gameobjects::set_3d_icon("friendly", "waypoint_defend");
    self gameobjects::set_2d_icon("enemy", "compass_waypoint_target");
    self gameobjects::set_3d_icon("enemy", "waypoint_target");
    self gameobjects::set_visible_team("none");
    self.trigger setinvisibletoall();
    self.useweapon = getweapon("briefcase_bomb");
}

// Namespace sab
// Params 0, eflags: 0x0
// Checksum 0x7ee66d45, Offset: 0x3068
// Size: 0x122
function setupfordefusing() {
    self gameobjects::allow_use("friendly");
    self gameobjects::set_use_time(level.defusetime);
    self gameobjects::set_use_text(%MP_DEFUSING_EXPLOSIVE);
    self gameobjects::set_use_hint_text(%PLATFORM_HOLD_TO_DEFUSE_EXPLOSIVES);
    self gameobjects::set_key_object(undefined);
    self gameobjects::set_2d_icon("friendly", "compass_waypoint_defuse");
    self gameobjects::set_3d_icon("friendly", "waypoint_defuse");
    self gameobjects::set_2d_icon("enemy", "compass_waypoint_defend");
    self gameobjects::set_3d_icon("enemy", "waypoint_defend");
    self gameobjects::set_visible_team("any");
    self.trigger setvisibletoall();
}

// Namespace sab
// Params 1, eflags: 0x0
// Checksum 0x57fc78f1, Offset: 0x3198
// Size: 0x57
function bombdefused(object) {
    setmatchflag("bomb_timer", 0);
    globallogic_utils::resumetimer();
    level.bombplanted = 0;
    if (!level.inovertime) {
        level.timelimitoverride = 0;
    }
    level notify(#"bomb_defused");
}

// Namespace sab
// Params 9, eflags: 0x0
// Checksum 0xe711cfdd, Offset: 0x31f8
// Size: 0x2ea
function onplayerkilled(einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime, deathanimduration) {
    inbombzone = 0;
    var_1091b3c9 = "none";
    if (isdefined(level.bombzones["allies"])) {
        dist = distance2d(self.origin, level.bombzones["allies"].curorigin);
        if (dist < level.defaultoffenseradius) {
            var_1091b3c9 = "allies";
            inbombzone = 1;
        }
    }
    if (isdefined(level.bombzones["axis"])) {
        dist = distance2d(self.origin, level.bombzones["axis"].curorigin);
        if (dist < level.defaultoffenseradius) {
            var_1091b3c9 = "axis";
            inbombzone = 1;
        }
    }
    if (inbombzone && isplayer(attacker) && attacker.pers["team"] != self.pers["team"]) {
        if (var_1091b3c9 == self.pers["team"]) {
            attacker addplayerstatwithgametype("OFFENDS", 1);
            self recordkillmodifier("defending");
        } else {
            if (isdefined(attacker.pers["defends"])) {
                attacker.pers["defends"]++;
                attacker.defends = attacker.pers["defends"];
            }
            attacker medals::defenseglobalcount();
            attacker addplayerstatwithgametype("DEFENDS", 1);
            self recordkillmodifier("assaulting");
        }
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

// Namespace sab
// Params 1, eflags: 0x0
// Checksum 0x7582157a, Offset: 0x34f0
// Size: 0x3a
function onendgame(winningteam) {
    if (winningteam == "allies" || isdefined(winningteam) && winningteam == "axis") {
        globallogic_score::giveteamscoreforobjective(winningteam, 1);
    }
}

// Namespace sab
// Params 1, eflags: 0x0
// Checksum 0xcb67e3a3, Offset: 0x3538
// Size: 0x2e
function onroundendgame(roundwinner) {
    winner = globallogic::determineteamwinnerbygamestat("roundswon");
    return winner;
}

