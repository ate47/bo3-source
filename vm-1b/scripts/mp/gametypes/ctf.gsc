#using scripts/mp/_challenges;
#using scripts/mp/_util;
#using scripts/mp/gametypes/_globallogic;
#using scripts/mp/gametypes/_globallogic_audio;
#using scripts/mp/gametypes/_globallogic_defaults;
#using scripts/mp/gametypes/_globallogic_score;
#using scripts/mp/gametypes/_globallogic_utils;
#using scripts/mp/gametypes/_hud_message;
#using scripts/mp/gametypes/_spawning;
#using scripts/mp/gametypes/_spawnlogic;
#using scripts/mp/teams/_teams;
#using scripts/shared/challenges_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/demo_shared;
#using scripts/shared/gameobjects_shared;
#using scripts/shared/hud_message_shared;
#using scripts/shared/hud_util_shared;
#using scripts/shared/math_shared;
#using scripts/shared/popups_shared;
#using scripts/shared/rank_shared;
#using scripts/shared/scoreevents_shared;
#using scripts/shared/sound_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;

#namespace ctf;

// Namespace ctf
// Params 0, eflags: 0x2
// Checksum 0x8da5dc35, Offset: 0xdb8
// Size: 0x2a
function autoexec function_2dc19561() {
    system::register("ctf", &__init__, undefined, undefined);
}

// Namespace ctf
// Params 0, eflags: 0x0
// Checksum 0xdef0ad04, Offset: 0xdf0
// Size: 0x2a
function __init__() {
    clientfield::register("scriptmover", "ctf_flag_away", 1, 1, "int");
}

// Namespace ctf
// Params 0, eflags: 0x0
// Checksum 0x727f2f99, Offset: 0xe28
// Size: 0x259
function main() {
    globallogic::init();
    util::registertimelimit(0, 1440);
    util::registerroundlimit(0, 10);
    util::registerroundwinlimit(0, 10);
    util::registerroundswitch(0, 9);
    util::registernumlives(0, 100);
    util::registerscorelimit(0, 5000);
    level.scoreroundwinbased = getgametypesetting("cumulativeRoundScores") == 0;
    level.flagcapturecondition = getgametypesetting("flagCaptureCondition");
    globallogic::registerfriendlyfiredelay(level.gametype, 15, 0, 1440);
    if (getdvarstring("scr_ctf_spawnPointFacingAngle") == "") {
        setdvar("scr_ctf_spawnPointFacingAngle", "0");
    }
    level.teambased = 1;
    level.overrideteamscore = 1;
    level.onstartgametype = &onstartgametype;
    level.onspawnplayer = &onspawnplayer;
    level.onprecachegametype = &onprecachegametype;
    level.onplayerkilled = &onplayerkilled;
    level.onroundswitch = &onroundswitch;
    level.onendgame = &onendgame;
    level.onroundendgame = &onroundendgame;
    level.getteamkillpenalty = &ctf_getteamkillpenalty;
    level.getteamkillscore = &ctf_getteamkillscore;
    level.var_d6911678 = &function_d6911678;
    level.shouldplayovertimeround = &shouldplayovertimeround;
    gameobjects::register_allowed_gameobject(level.gametype);
    InvalidOpCode(0x54, "ctf_teamscore");
    // Unknown operator (0x54, t7_1b, PC)
}

// Namespace ctf
// Params 0, eflags: 0x0
// Checksum 0x71b83c41, Offset: 0x11a0
// Size: 0x11
function onprecachegametype() {
    InvalidOpCode(0xc8, "flag_dropped_sound", "mp_war_objective_lost");
    // Unknown operator (0xc8, t7_1b, PC)
}

// Namespace ctf
// Params 0, eflags: 0x0
// Checksum 0x71d200a3, Offset: 0x11e8
// Size: 0x31
function onstartgametype() {
    InvalidOpCode(0x54, "switchedsides");
    // Unknown operator (0x54, t7_1b, PC)
}

// Namespace ctf
// Params 0, eflags: 0x0
// Checksum 0x21f0690d, Offset: 0x1710
// Size: 0x19
function shouldplayovertimeround() {
    InvalidOpCode(0x54, "overtime_round");
    // Unknown operator (0x54, t7_1b, PC)
}

// Namespace ctf
// Params 1, eflags: 0x0
// Checksum 0xd91382fa, Offset: 0x1848
// Size: 0x82
function minutesandsecondsstring(milliseconds) {
    minutes = floor(milliseconds / 60000);
    milliseconds -= minutes * 60000;
    seconds = floor(milliseconds / 1000);
    if (seconds < 10) {
        return (minutes + ":0" + seconds);
    }
    return minutes + ":" + seconds;
}

// Namespace ctf
// Params 1, eflags: 0x0
// Checksum 0x24d5c2b8, Offset: 0x18d8
// Size: 0x11
function function_d6911678(team) {
    InvalidOpCode(0x54, "overtime_round");
    // Unknown operator (0x54, t7_1b, PC)
}

// Namespace ctf
// Params 0, eflags: 0x0
// Checksum 0xa3426b72, Offset: 0x19b8
// Size: 0x9
function onroundswitch() {
    InvalidOpCode(0x54, "switchedsides");
    // Unknown operator (0x54, t7_1b, PC)
}

// Namespace ctf
// Params 1, eflags: 0x0
// Checksum 0x1c518cae, Offset: 0x19f8
// Size: 0x11
function onendgame(winningteam) {
    InvalidOpCode(0x54, "overtime_round");
    // Unknown operator (0x54, t7_1b, PC)
}

// Namespace ctf
// Params 0, eflags: 0x0
// Checksum 0x9037595b, Offset: 0x1a88
// Size: 0x75
function updateteamscorebyroundswon() {
    if (level.scoreroundwinbased) {
        var_59b853fb = level.teams;
        var_f04be041 = firstarray(var_59b853fb);
        if (isdefined(var_f04be041)) {
            team = var_59b853fb[var_f04be041];
            var_1cd28162 = nextarray(var_59b853fb, var_f04be041);
            InvalidOpCode(0x54, "roundswon", team);
            // Unknown operator (0x54, t7_1b, PC)
        }
    }
}

// Namespace ctf
// Params 1, eflags: 0x0
// Checksum 0x52069194, Offset: 0x1b08
// Size: 0x41
function onroundendgame(winningteam) {
    InvalidOpCode(0x54, "overtime_round");
    // Unknown operator (0x54, t7_1b, PC)
}

// Namespace ctf
// Params 1, eflags: 0x0
// Checksum 0xc6618b80, Offset: 0x1cc0
// Size: 0x42
function onspawnplayer(predictedspawn) {
    self.isflagcarrier = 0;
    self.flagcarried = undefined;
    self clientfield::set("ctf_flag_carrier", 0);
    spawning::onspawnplayer(predictedspawn);
}

// Namespace ctf
// Params 0, eflags: 0x0
// Checksum 0x5b30295c, Offset: 0x1d10
// Size: 0x152
function updategametypedvars() {
    level.flagcapturetime = getgametypesetting("captureTime");
    level.flagtouchreturntime = getgametypesetting("defuseTime");
    level.idleflagreturntime = getgametypesetting("idleFlagResetTime");
    level.flagrespawntime = getgametypesetting("flagRespawnTime");
    level.enemycarriervisible = getgametypesetting("enemyCarrierVisible");
    level.roundlimit = getgametypesetting("roundLimit");
    level.cumulativeroundscores = getgametypesetting("cumulativeRoundScores");
    level.teamkillpenaltymultiplier = getgametypesetting("teamKillPenalty");
    level.teamkillscoremultiplier = getgametypesetting("teamKillScore");
    if (level.flagtouchreturntime >= 0 && level.flagtouchreturntime != 63) {
        level.touchreturn = 1;
        return;
    }
    level.touchreturn = 0;
}

// Namespace ctf
// Params 1, eflags: 0x0
// Checksum 0xae5dee65, Offset: 0x1e70
// Size: 0xa9
function createflag(trigger) {
    if (isdefined(trigger.target)) {
        visuals[0] = getent(trigger.target, "targetname");
    } else {
        visuals[0] = spawn("script_model", trigger.origin);
        visuals[0].angles = trigger.angles;
    }
    entityteam = trigger.script_team;
    InvalidOpCode(0x54, "switchedsides");
    // Unknown operator (0x54, t7_1b, PC)
}

// Namespace ctf
// Params 1, eflags: 0x0
// Checksum 0x2955a13e, Offset: 0x2170
// Size: 0x49
function createflagzone(trigger) {
    visuals = [];
    entityteam = trigger.script_team;
    InvalidOpCode(0x54, "switchedsides");
    // Unknown operator (0x54, t7_1b, PC)
}

// Namespace ctf
// Params 2, eflags: 0x0
// Checksum 0x59dc9909, Offset: 0x22e8
// Size: 0xa4
function createflaghint(team, origin) {
    radius = -128;
    height = 64;
    trigger = spawn("trigger_radius", origin, 0, radius, height);
    trigger sethintstring(%MP_CTF_CANT_CAPTURE_FLAG);
    trigger setcursorhint("HINT_NOICON");
    trigger.original_origin = origin;
    trigger turn_off();
    return trigger;
}

// Namespace ctf
// Params 0, eflags: 0x0
// Checksum 0xe827363c, Offset: 0x2398
// Size: 0x24a
function ctf() {
    level.flags = [];
    level.teamflags = [];
    level.flagzones = [];
    level.teamflagzones = [];
    flag_triggers = getentarray("ctf_flag_pickup_trig", "targetname");
    if (!isdefined(flag_triggers) || flag_triggers.size != 2) {
        /#
            util::error("<dev string:x36>");
        #/
        return;
    }
    for (index = 0; index < flag_triggers.size; index++) {
        trigger = flag_triggers[index];
        flag = createflag(trigger);
        team = flag gameobjects::get_owner_team();
        level.flags[level.flags.size] = flag;
        level.teamflags[team] = flag;
    }
    flag_zones = getentarray("ctf_flag_zone_trig", "targetname");
    if (!isdefined(flag_zones) || flag_zones.size != 2) {
        /#
            util::error("<dev string:x78>");
        #/
        return;
    }
    for (index = 0; index < flag_zones.size; index++) {
        trigger = flag_zones[index];
        flagzone = createflagzone(trigger);
        team = flagzone gameobjects::get_owner_team();
        level.flagzones[level.flagzones.size] = flagzone;
        level.teamflagzones[team] = flagzone;
        level.flaghints[team] = createflaghint(team, trigger.origin);
        facing_angle = getdvarint("scr_ctf_spawnPointFacingAngle");
        setspawnpointsbaseweight(util::getotherteamsmask(team), trigger.origin, facing_angle, level.spawnsystem.objective_facing_bonus);
    }
    function_2c0ba61c();
}

// Namespace ctf
// Params 0, eflags: 0x0
// Checksum 0xc59da2f2, Offset: 0x25f0
// Size: 0x5a
function ctf_icon_hide() {
    level waittill(#"game_ended");
    level.teamflags["allies"] gameobjects::set_visible_team("none");
    level.teamflags["axis"] gameobjects::set_visible_team("none");
}

// Namespace ctf
// Params 0, eflags: 0x0
// Checksum 0x94f19940, Offset: 0x2658
// Size: 0x81
function removeinfluencers() {
    if (isdefined(self.spawn_influencer_enemy_carrier)) {
        self spawning::remove_influencer(self.spawn_influencer_enemy_carrier);
        self.spawn_influencer_enemy_carrier = undefined;
    }
    if (isdefined(self.spawn_influencer_friendly_carrier)) {
        self spawning::remove_influencer(self.spawn_influencer_friendly_carrier);
        self.spawn_influencer_friendly_carrier = undefined;
    }
    if (isdefined(self.spawn_influencer_dropped)) {
        self.trigger spawning::remove_influencer(self.spawn_influencer_dropped);
        self.spawn_influencer_dropped = undefined;
    }
}

// Namespace ctf
// Params 1, eflags: 0x0
// Checksum 0xef906f90, Offset: 0x26e8
// Size: 0x349
function ondrop(player) {
    origin = (0, 0, 0);
    if (isdefined(player)) {
        player clientfield::set("ctf_flag_carrier", 0);
        origin = player.origin;
    }
    team = self gameobjects::get_owner_team();
    otherteam = util::getotherteam(team);
    bbprint("mpobjective", "gametime %d objtype %s team %s playerx %d playery %d playerz %d", gettime(), "ctf_flagdropped", team, origin);
    self.visuals[0] clientfield::set("ctf_flag_away", 1);
    if (level.touchreturn) {
        self gameobjects::allow_carry("any");
        level.flaghints[otherteam] turn_off();
    }
    if (isdefined(player)) {
        util::printandsoundoneveryone(team, undefined, %, undefined, "mp_war_objective_lost");
        level thread popups::displayteammessagetoteam(%MP_FRIENDLY_FLAG_DROPPED, player, team);
        level thread popups::displayteammessagetoteam(%MP_ENEMY_FLAG_DROPPED, player, otherteam);
    } else {
        util::printandsoundoneveryone(team, undefined, %, undefined, "mp_war_objective_lost");
    }
    globallogic_audio::leader_dialog("ctfFriendlyFlagDropped", team, undefined, "ctf_flag");
    globallogic_audio::leader_dialog("ctfEnemyFlagDropped", otherteam, undefined, "ctf_flag_enemy");
    /#
        if (isdefined(player)) {
            print(team + "<dev string:xb8>");
        } else {
            print(team + "<dev string:xb8>");
        }
    #/
    if (isdefined(player)) {
        player playlocalsound("mpl_flag_drop_plr");
    }
    globallogic_audio::play_2d_on_team("mpl_flagdrop_sting_friend", otherteam);
    globallogic_audio::play_2d_on_team("mpl_flagdrop_sting_enemy", team);
    if (level.touchreturn) {
        self gameobjects::set_3d_icon("friendly", level.iconreturn3d);
        self gameobjects::set_2d_icon("friendly", level.iconreturn2d);
    } else {
        self gameobjects::set_3d_icon("friendly", level.icondropped3d);
        self gameobjects::set_2d_icon("friendly", level.icondropped2d);
    }
    self gameobjects::set_visible_team("any");
    self gameobjects::set_3d_icon("enemy", level.iconcapture3d);
    self gameobjects::set_2d_icon("enemy", level.iconcapture2d);
    InvalidOpCode(0x54, "attackers");
    // Unknown operator (0x54, t7_1b, PC)
}

// Namespace ctf
// Params 1, eflags: 0x0
// Checksum 0xf0612a41, Offset: 0x2b20
// Size: 0x632
function onpickup(player) {
    carrierkilledby = self.carrierkilledby;
    self.carrierkilledby = undefined;
    if (isdefined(self.spawn_influencer_dropped)) {
        self.trigger spawning::remove_influencer(self.spawn_influencer_dropped);
        self.spawn_influencer_dropped = undefined;
    }
    player addplayerstatwithgametype("PICKUPS", 1);
    if (level.touchreturn) {
        self gameobjects::allow_carry("enemy");
    }
    self removeinfluencers();
    team = self gameobjects::get_owner_team();
    otherteam = util::getotherteam(team);
    self function_34d1619d();
    if (isdefined(player) && player.pers["team"] == team) {
        self notify(#"picked_up");
        util::printandsoundoneveryone(team, undefined, %, undefined, "mp_obj_returned");
        if (isdefined(player.pers["returns"])) {
            player.pers["returns"]++;
            player.returns = player.pers["returns"];
        }
        if (isdefined(carrierkilledby) && carrierkilledby == player) {
            scoreevents::processscoreevent("flag_carrier_kill_return_close", player);
        } else if (distancesquared(self.trigger.baseorigin, player.origin) > 90000) {
            scoreevents::processscoreevent("flag_return", player);
        }
        demo::bookmark("event", gettime(), player);
        player addplayerstatwithgametype("RETURNS", 1);
        level thread popups::displayteammessagetoteam(%MP_FRIENDLY_FLAG_RETURNED, player, team);
        level thread popups::displayteammessagetoteam(%MP_ENEMY_FLAG_RETURNED, player, otherteam);
        self.visuals[0] clientfield::set("ctf_flag_away", 0);
        self gameobjects::set_flags(0);
        bbprint("mpobjective", "gametime %d objtype %s team %s playerx %d playery %d playerz %d", gettime(), "ctf_flagreturn", team, player.origin);
        player recordgameevent("return");
        self returnflag();
        /#
            if (isdefined(player)) {
                print(team + "<dev string:xc6>");
                return;
            }
            print(team + "<dev string:xc6>");
        #/
        return;
    }
    bbprint("mpobjective", "gametime %d objtype %s team %s playerx %d playery %d playerz %d", gettime(), "ctf_flagpickup", team, player.origin);
    player recordgameevent("pickup");
    scoreevents::processscoreevent("flag_grab", player);
    demo::bookmark("event", gettime(), player);
    util::printandsoundoneveryone(otherteam, undefined, %, undefined, "mp_obj_taken", "mp_enemy_obj_taken");
    level thread popups::displayteammessagetoteam(%MP_FRIENDLY_FLAG_TAKEN, player, team);
    level thread popups::displayteammessagetoteam(%MP_ENEMY_FLAG_TAKEN, player, otherteam);
    globallogic_audio::leader_dialog("ctfFriendlyFlagTaken", team, undefined, "ctf_flag");
    globallogic_audio::leader_dialog("ctfEnemyFlagTaken", otherteam, undefined, "ctf_flag_enemy");
    player.isflagcarrier = 1;
    player.flagcarried = self;
    player playlocalsound("mpl_flag_pickup_plr");
    player clientfield::set("ctf_flag_carrier", 1);
    self gameobjects::set_flags(1);
    globallogic_audio::play_2d_on_team("mpl_flagget_sting_friend", otherteam);
    globallogic_audio::play_2d_on_team("mpl_flagget_sting_enemy", team);
    if (level.enemycarriervisible) {
        self gameobjects::set_visible_team("any");
    } else {
        self gameobjects::set_visible_team("enemy");
    }
    self gameobjects::set_2d_icon("friendly", level.iconkill2d);
    self gameobjects::set_3d_icon("friendly", level.iconkill3d);
    self gameobjects::set_2d_icon("enemy", level.iconescort2d);
    self gameobjects::set_3d_icon("enemy", level.iconescort3d);
    player thread claim_trigger(level.flaghints[otherteam]);
    update_hints();
    player resetflashback();
    /#
        print(team + "<dev string:xd5>");
    #/
    ss = level.spawnsystem;
    player_team_mask = util::getteammask(otherteam);
    enemy_team_mask = util::getteammask(team);
    player.spawn_influencer_friendly_carrier = player spawning::create_entity_masked_friendly_influencer("ctf_carrier_friendly", player_team_mask);
    player.spawn_influencer_enemy_carrier = player spawning::create_entity_masked_enemy_influencer("ctf_carrier_enemy", enemy_team_mask);
}

// Namespace ctf
// Params 1, eflags: 0x0
// Checksum 0x6b05081a, Offset: 0x3160
// Size: 0x2d
function onpickupmusicstate(player) {
    self endon(#"disconnect");
    self endon(#"death");
    wait 6;
    if (player.isflagcarrier) {
    }
}

// Namespace ctf
// Params 0, eflags: 0x0
// Checksum 0x1011db47, Offset: 0x3198
// Size: 0x2d
function ishome() {
    if (isdefined(self.carrier)) {
        return false;
    }
    if (self.curorigin != self.trigger.baseorigin) {
        return false;
    }
    return true;
}

// Namespace ctf
// Params 0, eflags: 0x0
// Checksum 0x14c1eb98, Offset: 0x31d0
// Size: 0x1ba
function returnflag() {
    team = self gameobjects::get_owner_team();
    otherteam = util::getotherteam(team);
    globallogic_audio::play_2d_on_team("mpl_flagreturn_sting", team);
    globallogic_audio::play_2d_on_team("mpl_flagreturn_sting", otherteam);
    level.teamflagzones[otherteam] gameobjects::allow_use("friendly");
    level.teamflagzones[otherteam] gameobjects::set_visible_team("friendly");
    update_hints();
    if (level.touchreturn) {
        self gameobjects::allow_carry("enemy");
    }
    self gameobjects::return_home();
    self gameobjects::set_visible_team("any");
    self gameobjects::set_3d_icon("friendly", level.icondefend3d);
    self gameobjects::set_2d_icon("friendly", level.icondefend2d);
    self gameobjects::set_3d_icon("enemy", level.iconcapture3d);
    self gameobjects::set_2d_icon("enemy", level.iconcapture2d);
    globallogic_audio::leader_dialog("ctfFriendlyFlagReturned", team, undefined, "ctf_flag");
    globallogic_audio::leader_dialog("ctfEnemyFlagReturned", otherteam, undefined, "ctf_flag_enemy");
}

// Namespace ctf
// Params 1, eflags: 0x0
// Checksum 0x3e24157c, Offset: 0x3398
// Size: 0x111
function oncapture(player) {
    team = player.pers["team"];
    enemyteam = util::getotherteam(team);
    time = gettime();
    playerteamsflag = level.teamflags[team];
    if (level.flagcapturecondition == 1 && playerteamsflag gameobjects::is_object_away_from_home()) {
        return;
    }
    if (!isdefined(player.carryobject)) {
        return;
    }
    util::printandsoundoneveryone(team, undefined, %, undefined, "mp_obj_captured", "mp_enemy_obj_captured");
    bbprint("mpobjective", "gametime %d objtype %s team %s playerx %d playery %d playerz %d", time, "ctf_flagcapture", enemyteam, player.origin);
    InvalidOpCode(0xc8, "challenge", team, "capturedFlag", 1);
    // Unknown operator (0xc8, t7_1b, PC)
}

// Namespace ctf
// Params 1, eflags: 0x0
// Checksum 0xb20396e0, Offset: 0x3730
// Size: 0x3a
function giveflagcapturexp(player) {
    scoreevents::processscoreevent("flag_capture", player);
    player recordgameevent("capture");
}

// Namespace ctf
// Params 0, eflags: 0x0
// Checksum 0x5a7a3bc7, Offset: 0x3778
// Size: 0x15a
function onreset() {
    update_hints();
    team = self gameobjects::get_owner_team();
    self gameobjects::set_3d_icon("friendly", level.icondefend3d);
    self gameobjects::set_2d_icon("friendly", level.icondefend2d);
    self gameobjects::set_3d_icon("enemy", level.iconcapture3d);
    self gameobjects::set_2d_icon("enemy", level.iconcapture2d);
    if (level.touchreturn) {
        self gameobjects::allow_carry("enemy");
    }
    level.teamflagzones[team] gameobjects::set_visible_team("friendly");
    level.teamflagzones[team] gameobjects::allow_use("friendly");
    self.visuals[0] clientfield::set("ctf_flag_away", 0);
    self gameobjects::set_flags(0);
    self function_34d1619d();
    self removeinfluencers();
}

// Namespace ctf
// Params 1, eflags: 0x0
// Checksum 0xc58ecc88, Offset: 0x38e0
// Size: 0x2e
function getotherflag(flag) {
    if (flag == level.flags[0]) {
        return level.flags[1];
    }
    return level.flags[0];
}

// Namespace ctf
// Params 9, eflags: 0x0
// Checksum 0x2b535eb7, Offset: 0x3918
// Size: 0x54a
function onplayerkilled(einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime, deathanimduration) {
    if (isdefined(attacker) && isplayer(attacker)) {
        for (index = 0; index < level.flags.size; index++) {
            flagteam = "invalidTeam";
            inflagzone = 0;
            defendedflag = 0;
            offendedflag = 0;
            flagcarrier = level.flags[index].carrier;
            if (isdefined(flagcarrier)) {
                flagorigin = level.flags[index].carrier.origin;
                iscarried = 1;
                if (isplayer(attacker) && attacker.pers["team"] != self.pers["team"]) {
                    if (isdefined(level.flags[index].carrier.attackerdata)) {
                        if (level.flags[index].carrier != attacker) {
                            if (isdefined(level.flags[index].carrier.attackerdata[self.clientid])) {
                                scoreevents::processscoreevent("rescue_flag_carrier", attacker, undefined, weapon);
                            }
                        }
                    }
                }
            } else {
                flagorigin = level.flags[index].curorigin;
                iscarried = 0;
            }
            dist = distance2d(self.origin, flagorigin);
            if (dist < level.defaultoffenseradius) {
                inflagzone = 1;
                if (level.flags[index].ownerteam == attacker.pers["team"]) {
                    defendedflag = 1;
                } else {
                    offendedflag = 1;
                }
            }
            dist = distance2d(attacker.origin, flagorigin);
            if (dist < level.defaultoffenseradius) {
                inflagzone = 1;
                if (level.flags[index].ownerteam == attacker.pers["team"]) {
                    defendedflag = 1;
                } else {
                    offendedflag = 1;
                }
            }
            if (inflagzone && isplayer(attacker) && attacker.pers["team"] != self.pers["team"]) {
                if (defendedflag) {
                    attacker addplayerstatwithgametype("DEFENDS", 1);
                    if (isdefined(self.isflagcarrier) && self.isflagcarrier) {
                        scoreevents::processscoreevent("kill_flag_carrier", attacker, undefined, weapon);
                    } else {
                        scoreevents::processscoreevent("killed_attacker", attacker, undefined, weapon);
                    }
                    self recordkillmodifier("assaulting");
                }
                if (offendedflag) {
                    attacker addplayerstatwithgametype("OFFENDS", 1);
                    if (iscarried == 1) {
                        if (isdefined(flagcarrier) && attacker == flagcarrier) {
                            scoreevents::processscoreevent("killed_enemy_while_carrying_flag", attacker, undefined, weapon);
                        } else {
                            scoreevents::processscoreevent("defend_flag_carrier", attacker, undefined, weapon);
                        }
                    } else {
                        scoreevents::processscoreevent("killed_defender", attacker, undefined, weapon);
                    }
                    self recordkillmodifier("defending");
                }
            }
        }
    }
    if (!isdefined(self.isflagcarrier) || !self.isflagcarrier) {
        return;
    }
    if (isdefined(attacker) && isplayer(attacker) && attacker.pers["team"] != self.pers["team"]) {
        if (isdefined(self.flagcarried)) {
            for (index = 0; index < level.flags.size; index++) {
                currentflag = level.flags[index];
                if (currentflag.ownerteam == self.team) {
                    if (currentflag.curorigin == currentflag.trigger.baseorigin) {
                        dist = distance2d(self.origin, currentflag.curorigin);
                        if (dist < level.defaultoffenseradius) {
                            self.flagcarried.carrierkilledby = attacker;
                            break;
                        }
                    }
                }
            }
        }
        attacker recordgameevent("kill_carrier");
        self recordkillmodifier("carrying");
    }
}

// Namespace ctf
// Params 0, eflags: 0x0
// Checksum 0x9088c5b2, Offset: 0x3e70
// Size: 0x38a
function function_2c0ba61c() {
    level.var_5d0c9f44 = [];
    level.var_5d0c9f44["allies"]["axis"] = hud::createservertimer("objective", 1.4, "allies");
    level.var_5d0c9f44["allies"]["axis"] hud::setpoint("TOPRIGHT", "TOPRIGHT", 0, 0);
    level.var_5d0c9f44["allies"]["axis"].label = %MP_ENEMY_FLAG_RETURNING_IN;
    level.var_5d0c9f44["allies"]["axis"].alpha = 0;
    level.var_5d0c9f44["allies"]["axis"].archived = 0;
    level.var_5d0c9f44["allies"]["allies"] = hud::createservertimer("objective", 1.4, "allies");
    level.var_5d0c9f44["allies"]["allies"] hud::setpoint("TOPRIGHT", "TOPRIGHT", 0, 20);
    level.var_5d0c9f44["allies"]["allies"].label = %MP_YOUR_FLAG_RETURNING_IN;
    level.var_5d0c9f44["allies"]["allies"].alpha = 0;
    level.var_5d0c9f44["allies"]["allies"].archived = 0;
    level.var_5d0c9f44["axis"]["allies"] = hud::createservertimer("objective", 1.4, "axis");
    level.var_5d0c9f44["axis"]["allies"] hud::setpoint("TOPRIGHT", "TOPRIGHT", 0, 0);
    level.var_5d0c9f44["axis"]["allies"].label = %MP_ENEMY_FLAG_RETURNING_IN;
    level.var_5d0c9f44["axis"]["allies"].alpha = 0;
    level.var_5d0c9f44["axis"]["allies"].archived = 0;
    level.var_5d0c9f44["axis"]["axis"] = hud::createservertimer("objective", 1.4, "axis");
    level.var_5d0c9f44["axis"]["axis"] hud::setpoint("TOPRIGHT", "TOPRIGHT", 0, 20);
    level.var_5d0c9f44["axis"]["axis"].label = %MP_YOUR_FLAG_RETURNING_IN;
    level.var_5d0c9f44["axis"]["axis"].alpha = 0;
    level.var_5d0c9f44["axis"]["axis"].archived = 0;
}

// Namespace ctf
// Params 1, eflags: 0x0
// Checksum 0x5017ecc0, Offset: 0x4208
// Size: 0x7a
function function_2afd3059(time) {
    if (level.touchreturn || level.idleflagreturntime == 0) {
        return;
    }
    self notify(#"hash_2afd3059");
    self endon(#"hash_2afd3059");
    result = function_5badced4(time);
    self removeinfluencers();
    self function_34d1619d();
    if (!isdefined(result)) {
        return;
    }
}

// Namespace ctf
// Params 1, eflags: 0x0
// Checksum 0xe031d9cb, Offset: 0x4290
// Size: 0x11c
function function_5badced4(time) {
    self endon(#"picked_up");
    level endon(#"game_ended");
    ownerteam = self gameobjects::get_owner_team();
    assert(!level.var_5d0c9f44["<dev string:xf0>"][ownerteam].alpha);
    level.var_5d0c9f44["axis"][ownerteam].alpha = 1;
    level.var_5d0c9f44["axis"][ownerteam] settimer(time);
    assert(!level.var_5d0c9f44["<dev string:xf5>"][ownerteam].alpha);
    level.var_5d0c9f44["allies"][ownerteam].alpha = 1;
    level.var_5d0c9f44["allies"][ownerteam] settimer(time);
    if (time <= 0) {
        return false;
    } else {
        wait time;
    }
    return true;
}

// Namespace ctf
// Params 0, eflags: 0x0
// Checksum 0xed49a7b2, Offset: 0x43b8
// Size: 0x52
function function_34d1619d() {
    ownerteam = self gameobjects::get_owner_team();
    level.var_5d0c9f44["allies"][ownerteam].alpha = 0;
    level.var_5d0c9f44["axis"][ownerteam].alpha = 0;
}

// Namespace ctf
// Params 0, eflags: 0x0
// Checksum 0x67dbe0ee, Offset: 0x4418
// Size: 0x1e
function turn_on() {
    if (level.hardcoremode) {
        return;
    }
    self.origin = self.original_origin;
}

// Namespace ctf
// Params 0, eflags: 0x0
// Checksum 0xc084435e, Offset: 0x4440
// Size: 0x26
function turn_off() {
    self.origin = (self.original_origin[0], self.original_origin[1], self.original_origin[2] - 10000);
}

// Namespace ctf
// Params 0, eflags: 0x0
// Checksum 0x838460e9, Offset: 0x4470
// Size: 0x10a
function update_hints() {
    allied_flag = level.teamflags["allies"];
    axis_flag = level.teamflags["axis"];
    if (!level.touchreturn) {
        return;
    }
    if (isdefined(allied_flag.carrier) && axis_flag gameobjects::is_object_away_from_home()) {
        level.flaghints["axis"] turn_on();
    } else {
        level.flaghints["axis"] turn_off();
    }
    if (isdefined(axis_flag.carrier) && allied_flag gameobjects::is_object_away_from_home()) {
        level.flaghints["allies"] turn_on();
        return;
    }
    level.flaghints["allies"] turn_off();
}

// Namespace ctf
// Params 1, eflags: 0x0
// Checksum 0xc12dffb2, Offset: 0x4588
// Size: 0x42
function claim_trigger(trigger) {
    self endon(#"disconnect");
    self clientclaimtrigger(trigger);
    self waittill(#"drop_object");
    self clientreleasetrigger(trigger);
}

// Namespace ctf
// Params 1, eflags: 0x0
// Checksum 0xb153f173, Offset: 0x45d8
// Size: 0xb2
function createflagspawninfluencer(entityteam) {
    otherteam = util::getotherteam(entityteam);
    team_mask = util::getteammask(entityteam);
    other_team_mask = util::getteammask(otherteam);
    self.spawn_influencer_friendly = self spawning::create_influencer("ctf_base_friendly", self.trigger.origin, team_mask);
    self.spawn_influencer_enemy = self spawning::create_influencer("ctf_base_friendly", self.trigger.origin, other_team_mask);
}

// Namespace ctf
// Params 4, eflags: 0x0
// Checksum 0x12e705de, Offset: 0x4698
// Size: 0x67
function ctf_getteamkillpenalty(einflictor, attacker, smeansofdeath, weapon) {
    teamkill_penalty = globallogic_defaults::default_getteamkillpenalty(einflictor, attacker, smeansofdeath, weapon);
    if (isdefined(self.isflagcarrier) && self.isflagcarrier) {
        teamkill_penalty *= level.teamkillpenaltymultiplier;
    }
    return teamkill_penalty;
}

// Namespace ctf
// Params 4, eflags: 0x0
// Checksum 0xd1ad0ac3, Offset: 0x4708
// Size: 0x79
function ctf_getteamkillscore(einflictor, attacker, smeansofdeath, weapon) {
    teamkill_score = rank::getscoreinfovalue("kill");
    if (isdefined(self.isflagcarrier) && self.isflagcarrier) {
        teamkill_score *= level.teamkillscoremultiplier;
    }
    return int(teamkill_score);
}

