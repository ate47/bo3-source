#using scripts/mp/_util;
#using scripts/mp/_challenges;
#using scripts/mp/gametypes/_spectating;
#using scripts/mp/gametypes/_globallogic_spawn;
#using scripts/mp/gametypes/_globallogic;
#using scripts/shared/visionset_mgr_shared;
#using scripts/shared/weapons/_tacticalinsertion;
#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/hud_util_shared;
#using scripts/shared/killcam_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/challenges_shared;
#using scripts/shared/callbacks_shared;
#using scripts/codescripts/struct;

#namespace killcam;

// Namespace killcam
// Params 0, eflags: 0x2
// Checksum 0x5be83ac7, Offset: 0x4f0
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("killcam", &__init__, undefined, undefined);
}

// Namespace killcam
// Params 0, eflags: 0x1 linked
// Checksum 0x3a195c76, Offset: 0x530
// Size: 0x54
function __init__() {
    callback::on_start_gametype(&init);
    clientfield::register("clientuimodel", "hudItems.killcamAllowRespawn", 1, 1, "int");
}

// Namespace killcam
// Params 0, eflags: 0x1 linked
// Checksum 0x3666793f, Offset: 0x590
// Size: 0x54
function init() {
    level.killcam = getgametypesetting("allowKillcam");
    level.finalkillcam = getgametypesetting("allowFinalKillcam");
    init_final_killcam();
}

// Namespace killcam
// Params 0, eflags: 0x1 linked
// Checksum 0xd2995684, Offset: 0x5f0
// Size: 0xc2
function init_final_killcam() {
    level.finalkillcamsettings = [];
    init_final_killcam_team("none");
    foreach (team in level.teams) {
        init_final_killcam_team(team);
    }
    level.finalkillcam_winner = undefined;
    level.finalkillcam_winnerpicked = undefined;
}

// Namespace killcam
// Params 1, eflags: 0x1 linked
// Checksum 0x355fba82, Offset: 0x6c0
// Size: 0x44
function init_final_killcam_team(team) {
    level.finalkillcamsettings[team] = spawnstruct();
    clear_final_killcam_team(team);
}

// Namespace killcam
// Params 1, eflags: 0x1 linked
// Checksum 0x388b6173, Offset: 0x710
// Size: 0x112
function clear_final_killcam_team(team) {
    level.finalkillcamsettings[team].spectatorclient = undefined;
    level.finalkillcamsettings[team].weapon = undefined;
    level.finalkillcamsettings[team].meansofdeath = undefined;
    level.finalkillcamsettings[team].deathtime = undefined;
    level.finalkillcamsettings[team].deathtimeoffset = undefined;
    level.finalkillcamsettings[team].offsettime = undefined;
    level.finalkillcamsettings[team].killcam_entity_info = undefined;
    level.finalkillcamsettings[team].targetentityindex = undefined;
    level.finalkillcamsettings[team].perks = undefined;
    level.finalkillcamsettings[team].killstreaks = undefined;
    level.finalkillcamsettings[team].attacker = undefined;
}

// Namespace killcam
// Params 11, eflags: 0x1 linked
// Checksum 0x512c60f4, Offset: 0x830
// Size: 0x344
function record_settings(spectatorclient, targetentityindex, weapon, meansofdeath, deathtime, deathtimeoffset, offsettime, killcam_entity_info, perks, killstreaks, attacker) {
    if (isdefined(attacker) && isdefined(attacker.team) && isdefined(level.teams[attacker.team])) {
        team = attacker.team;
        level.finalkillcamsettings[team].spectatorclient = spectatorclient;
        level.finalkillcamsettings[team].weapon = weapon;
        level.finalkillcamsettings[team].meansofdeath = meansofdeath;
        level.finalkillcamsettings[team].deathtime = deathtime;
        level.finalkillcamsettings[team].deathtimeoffset = deathtimeoffset;
        level.finalkillcamsettings[team].offsettime = offsettime;
        level.finalkillcamsettings[team].killcam_entity_info = killcam_entity_info;
        level.finalkillcamsettings[team].targetentityindex = targetentityindex;
        level.finalkillcamsettings[team].perks = perks;
        level.finalkillcamsettings[team].killstreaks = killstreaks;
        level.finalkillcamsettings[team].attacker = attacker;
    }
    level.finalkillcamsettings["none"].spectatorclient = spectatorclient;
    level.finalkillcamsettings["none"].weapon = weapon;
    level.finalkillcamsettings["none"].meansofdeath = meansofdeath;
    level.finalkillcamsettings["none"].deathtime = deathtime;
    level.finalkillcamsettings["none"].deathtimeoffset = deathtimeoffset;
    level.finalkillcamsettings["none"].offsettime = offsettime;
    level.finalkillcamsettings["none"].killcam_entity_info = killcam_entity_info;
    level.finalkillcamsettings["none"].targetentityindex = targetentityindex;
    level.finalkillcamsettings["none"].perks = perks;
    level.finalkillcamsettings["none"].killstreaks = killstreaks;
    level.finalkillcamsettings["none"].attacker = attacker;
}

// Namespace killcam
// Params 0, eflags: 0x0
// Checksum 0x62e20270, Offset: 0xb80
// Size: 0xb2
function erase_final_killcam() {
    clear_final_killcam_team("none");
    foreach (team in level.teams) {
        clear_final_killcam_team(team);
    }
    level.finalkillcam_winner = undefined;
    level.finalkillcam_winnerpicked = undefined;
}

// Namespace killcam
// Params 0, eflags: 0x1 linked
// Checksum 0xa0394982, Offset: 0xc40
// Size: 0x20
function final_killcam_waiter() {
    if (level.finalkillcam_winnerpicked === 1) {
        level waittill(#"final_killcam_done");
    }
}

// Namespace killcam
// Params 0, eflags: 0x1 linked
// Checksum 0x69a05795, Offset: 0xc68
// Size: 0x4c
function post_round_final_killcam() {
    if (isdefined(level.var_77929119) && level.var_77929119) {
        return;
    }
    level notify(#"play_final_killcam");
    globallogic::resetoutcomeforallplayers();
    final_killcam_waiter();
}

// Namespace killcam
// Params 0, eflags: 0x1 linked
// Checksum 0xb592c350, Offset: 0xcc0
// Size: 0x25c
function do_final_killcam() {
    level waittill(#"play_final_killcam");
    luinotifyevent(%pre_killcam_transition);
    wait 0.35;
    level.infinalkillcam = 1;
    winner = "none";
    if (isdefined(level.finalkillcam_winner)) {
        winner = level.finalkillcam_winner;
    }
    winning_team = globallogic::function_db16a372(winner);
    if (!isdefined(level.finalkillcamsettings[winning_team].targetentityindex)) {
        level.infinalkillcam = 0;
        level notify(#"final_killcam_done");
        return;
    }
    attacker = level.finalkillcamsettings[winning_team].attacker;
    if (isdefined(attacker) && isdefined(attacker.archetype) && attacker.archetype == "mannequin") {
        level.infinalkillcam = 0;
        level notify(#"final_killcam_done");
        return;
    }
    if (isdefined(attacker)) {
        challenges::getfinalkill(attacker);
    }
    visionsetnaked(getdvarstring("mapname"), 0);
    players = level.players;
    for (index = 0; index < players.size; index++) {
        player = players[index];
        player closeingamemenu();
        player thread final_killcam(winner);
    }
    wait 0.1;
    while (are_any_players_watching()) {
        wait 0.05;
    }
    level notify(#"final_killcam_done");
    level.infinalkillcam = 0;
}

// Namespace killcam
// Params 0, eflags: 0x0
// Checksum 0x99ec1590, Offset: 0xf28
// Size: 0x4
function function_ec4e2b9c() {
    
}

// Namespace killcam
// Params 0, eflags: 0x1 linked
// Checksum 0xcdc36a84, Offset: 0xf38
// Size: 0x76
function are_any_players_watching() {
    players = level.players;
    for (index = 0; index < players.size; index++) {
        player = players[index];
        if (isdefined(player.killcam)) {
            return true;
        }
    }
    return false;
}

// Namespace killcam
// Params 0, eflags: 0x1 linked
// Checksum 0xf9282db3, Offset: 0xfb8
// Size: 0x44
function watch_for_skip_killcam() {
    self endon(#"begin_killcam");
    self util::waittill_any("disconnect", "spawned");
    wait 0.05;
    level.numplayerswaitingtoenterkillcam--;
}

// Namespace killcam
// Params 14, eflags: 0x1 linked
// Checksum 0xe68895cb, Offset: 0x1008
// Size: 0x68c
function killcam(attackernum, targetnum, killcam_entity_info, weapon, meansofdeath, deathtime, deathtimeoffset, offsettime, respawn, maxtime, perks, killstreaks, attacker, keep_deathcam) {
    self endon(#"disconnect");
    self endon(#"spawned");
    level endon(#"game_ended");
    if (attackernum < 0) {
        return;
    }
    self thread watch_for_skip_killcam();
    level.numplayerswaitingtoenterkillcam++;
    assert(level.numplayerswaitingtoenterkillcam < 20);
    if (level.numplayerswaitingtoenterkillcam > 1) {
        println("<dev string:x28>");
        wait 0.05 * (level.numplayerswaitingtoenterkillcam - 1);
    }
    wait 0.05;
    level.numplayerswaitingtoenterkillcam--;
    assert(level.numplayerswaitingtoenterkillcam > -1);
    postdeathdelay = (gettime() - deathtime) / 1000;
    predelay = postdeathdelay + deathtimeoffset;
    killcamentitystarttime = get_killcam_entity_info_starttime(killcam_entity_info);
    camtime = calc_time(weapon, killcamentitystarttime, predelay, respawn, maxtime);
    postdelay = calc_post_delay();
    killcamlength = camtime + postdelay;
    if (isdefined(maxtime) && killcamlength > maxtime) {
        if (maxtime < 2) {
            return;
        }
        if (maxtime - camtime >= 1) {
            postdelay = maxtime - camtime;
        } else {
            postdelay = 1;
            camtime = maxtime - 1;
        }
        killcamlength = camtime + postdelay;
    }
    killcamoffset = camtime + predelay;
    self notify(#"begin_killcam", gettime());
    self util::clientnotify("sndDEDe");
    killcamstarttime = gettime() - killcamoffset * 1000;
    self.sessionstate = "spectator";
    self.spectatekillcam = 1;
    self.spectatorclient = attackernum;
    self.killcamentity = -1;
    self thread set_killcam_entities(killcam_entity_info, killcamstarttime);
    self.killcamtargetentity = targetnum;
    self.killcamweapon = weapon;
    self.killcammod = meansofdeath;
    self.archivetime = killcamoffset;
    self.killcamlength = killcamlength;
    self.psoffsettime = offsettime;
    foreach (team in level.teams) {
        self allowspectateteam(team, 1);
    }
    self allowspectateteam("freelook", 1);
    self allowspectateteam("none", 1);
    self thread function_548eaf1e();
    wait 0.05;
    if (self.archivetime <= predelay) {
        self.sessionstate = "dead";
        self.spectatorclient = -1;
        self.killcamentity = -1;
        self.archivetime = 0;
        self.psoffsettime = 0;
        self.spectatekillcam = 0;
        self notify(#"end_killcam");
        return;
    }
    self thread check_for_abrupt_end();
    self.killcam = 1;
    self function_62ea5b06(respawn);
    if (!self issplitscreen() && level.perksenabled == 1) {
        self function_a6953bec(camtime);
        self hud::showperks();
    }
    self thread spawned_killcam_cleanup();
    self thread wait_skip_killcam_button();
    self thread wait_team_change_end_killcam();
    self thread wait_killcam_time();
    self thread tacticalinsertion::cancel_button_think();
    self waittill(#"end_killcam");
    self end(0);
    if (isdefined(keep_deathcam) && keep_deathcam) {
        return;
    }
    self.sessionstate = "dead";
    self.spectatorclient = -1;
    self.killcamentity = -1;
    self.archivetime = 0;
    self.psoffsettime = 0;
    self.spectatekillcam = 0;
}

// Namespace killcam
// Params 2, eflags: 0x1 linked
// Checksum 0xb8f502a6, Offset: 0x16a0
// Size: 0x5c
function set_entity(killcamentityindex, delayms) {
    self endon(#"disconnect");
    self endon(#"end_killcam");
    self endon(#"spawned");
    if (delayms > 0) {
        wait delayms / 1000;
    }
    self.killcamentity = killcamentityindex;
}

// Namespace killcam
// Params 2, eflags: 0x1 linked
// Checksum 0xd1b240ab, Offset: 0x1708
// Size: 0xac
function set_killcam_entities(entity_info, killcamstarttime) {
    for (index = 0; index < entity_info.entity_indexes.size; index++) {
        delayms = entity_info.entity_spawntimes[index] - killcamstarttime - 100;
        thread set_entity(entity_info.entity_indexes[index], delayms);
        if (delayms <= 0) {
            return;
        }
    }
}

// Namespace killcam
// Params 0, eflags: 0x1 linked
// Checksum 0x6b524243, Offset: 0x17c0
// Size: 0x3a
function wait_killcam_time() {
    self endon(#"disconnect");
    self endon(#"end_killcam");
    wait self.killcamlength - 0.05;
    self notify(#"end_killcam");
}

// Namespace killcam
// Params 2, eflags: 0x1 linked
// Checksum 0xd3aeae4c, Offset: 0x1808
// Size: 0x124
function wait_final_killcam_slowdown(deathtime, starttime) {
    self endon(#"disconnect");
    self endon(#"end_killcam");
    if (isdefined(level.var_fb8e299e) && level.var_fb8e299e) {
        return;
    }
    secondsuntildeath = (deathtime - starttime) / 1000;
    deathtime = gettime() + secondsuntildeath * 1000;
    waitbeforedeath = 2;
    wait max(0, secondsuntildeath - waitbeforedeath);
    util::setclientsysstate("levelNotify", "sndFKsl");
    setslowmotion(1, 0.25, waitbeforedeath);
    wait waitbeforedeath + 0.5;
    setslowmotion(0.25, 1, 1);
    wait 0.5;
}

// Namespace killcam
// Params 0, eflags: 0x1 linked
// Checksum 0xc6d64fb5, Offset: 0x1938
// Size: 0xb4
function wait_skip_killcam_button() {
    self endon(#"disconnect");
    self endon(#"end_killcam");
    while (self usebuttonpressed()) {
        wait 0.05;
    }
    while (!self usebuttonpressed()) {
        wait 0.05;
    }
    if (isdefined(self.killcamsskipped)) {
        self.killcamsskipped++;
    } else {
        self.killcamsskipped = 1;
    }
    self notify(#"end_killcam");
    self util::clientnotify("fkce");
}

// Namespace killcam
// Params 0, eflags: 0x1 linked
// Checksum 0x6cd927fb, Offset: 0x19f8
// Size: 0x3c
function wait_team_change_end_killcam() {
    self endon(#"disconnect");
    self endon(#"end_killcam");
    self waittill(#"changed_class");
    end(0);
}

// Namespace killcam
// Params 0, eflags: 0x0
// Checksum 0xc2a33f18, Offset: 0x1a40
// Size: 0x7e
function wait_skip_killcam_safe_spawn_button() {
    self endon(#"disconnect");
    self endon(#"end_killcam");
    while (self fragbuttonpressed()) {
        wait 0.05;
    }
    while (!self fragbuttonpressed()) {
        wait 0.05;
    }
    self.wantsafespawn = 1;
    self notify(#"end_killcam");
}

// Namespace killcam
// Params 1, eflags: 0x1 linked
// Checksum 0x90110cf2, Offset: 0x1ac8
// Size: 0x6c
function end(final) {
    if (isdefined(self.var_60dc2732)) {
        self.var_60dc2732.alpha = 0;
    }
    if (isdefined(self.var_9747cbb5)) {
        self.var_9747cbb5.alpha = 0;
    }
    self.killcam = undefined;
    self thread spectating::set_permissions();
}

// Namespace killcam
// Params 0, eflags: 0x1 linked
// Checksum 0x9814c69d, Offset: 0x1b40
// Size: 0x52
function check_for_abrupt_end() {
    self endon(#"disconnect");
    self endon(#"end_killcam");
    while (true) {
        if (self.archivetime <= 0) {
            break;
        }
        wait 0.05;
    }
    self notify(#"end_killcam");
}

// Namespace killcam
// Params 0, eflags: 0x1 linked
// Checksum 0x6b24d169, Offset: 0x1ba0
// Size: 0x3c
function spawned_killcam_cleanup() {
    self endon(#"end_killcam");
    self endon(#"disconnect");
    self waittill(#"spawned");
    self end(0);
}

// Namespace killcam
// Params 1, eflags: 0x0
// Checksum 0x829a3, Offset: 0x1be8
// Size: 0x9c
function spectator_killcam_cleanup(attacker) {
    self endon(#"end_killcam");
    self endon(#"disconnect");
    attacker endon(#"disconnect");
    var_ce2fdf61 = attacker waittill(#"begin_killcam");
    waittime = max(0, var_ce2fdf61 - self.deathtime - 50);
    wait waittime;
    self end(0);
}

// Namespace killcam
// Params 0, eflags: 0x1 linked
// Checksum 0xde81b980, Offset: 0x1c90
// Size: 0x50
function function_548eaf1e() {
    self endon(#"end_killcam");
    self endon(#"disconnect");
    level waittill(#"game_ended");
    self end(0);
    self [[ level.spawnintermission ]](0);
}

// Namespace killcam
// Params 0, eflags: 0x1 linked
// Checksum 0x1c268d7a, Offset: 0x1ce8
// Size: 0x44
function function_5551058f() {
    self endon(#"end_killcam");
    self endon(#"disconnect");
    level waittill(#"game_ended");
    self end(1);
}

// Namespace killcam
// Params 0, eflags: 0x1 linked
// Checksum 0x439f6ba4, Offset: 0x1d38
// Size: 0x1a
function cancel_use_button() {
    return self usebuttonpressed();
}

// Namespace killcam
// Params 0, eflags: 0x0
// Checksum 0x2aabc237, Offset: 0x1d60
// Size: 0x1a
function cancel_safe_spawn_button() {
    return self fragbuttonpressed();
}

// Namespace killcam
// Params 0, eflags: 0x1 linked
// Checksum 0x87cd6e4c, Offset: 0x1d88
// Size: 0x10
function cancel_callback() {
    self.cancelkillcam = 1;
}

// Namespace killcam
// Params 0, eflags: 0x0
// Checksum 0x73e8dc44, Offset: 0x1da0
// Size: 0x1c
function cancel_safe_spawn_callback() {
    self.cancelkillcam = 1;
    self.wantsafespawn = 1;
}

// Namespace killcam
// Params 0, eflags: 0x1 linked
// Checksum 0x70023b43, Offset: 0x1dc8
// Size: 0x34
function cancel_on_use() {
    self thread cancel_on_use_specific_button(&cancel_use_button, &cancel_callback);
}

// Namespace killcam
// Params 2, eflags: 0x1 linked
// Checksum 0x138b70fe, Offset: 0x1e08
// Size: 0x11c
function cancel_on_use_specific_button(pressingbuttonfunc, finishedfunc) {
    self endon(#"death_delay_finished");
    self endon(#"disconnect");
    level endon(#"game_ended");
    for (;;) {
        if (!self [[ pressingbuttonfunc ]]()) {
            wait 0.05;
            continue;
        }
        buttontime = 0;
        while (self [[ pressingbuttonfunc ]]()) {
            buttontime += 0.05;
            wait 0.05;
        }
        if (buttontime >= 0.5) {
            continue;
        }
        buttontime = 0;
        while (!self [[ pressingbuttonfunc ]]() && buttontime < 0.5) {
            buttontime += 0.05;
            wait 0.05;
        }
        if (buttontime >= 0.5) {
            continue;
        }
        self [[ finishedfunc ]]();
        return;
    }
}

// Namespace killcam
// Params 1, eflags: 0x1 linked
// Checksum 0xe551e0a2, Offset: 0x1f30
// Size: 0x470
function final_killcam_internal(winner) {
    winning_team = globallogic::function_db16a372(winner);
    killcamsettings = level.finalkillcamsettings[winning_team];
    postdeathdelay = (gettime() - killcamsettings.deathtime) / 1000;
    predelay = postdeathdelay + killcamsettings.deathtimeoffset;
    killcamentitystarttime = get_killcam_entity_info_starttime(killcamsettings.killcam_entity_info);
    camtime = calc_time(killcamsettings.weapon, killcamentitystarttime, predelay, 0, undefined);
    postdelay = calc_post_delay();
    killcamoffset = camtime + predelay;
    killcamlength = camtime + postdelay - 0.05;
    killcamstarttime = gettime() - killcamoffset * 1000;
    self notify(#"begin_killcam", gettime());
    util::setclientsysstate("levelNotify", "sndFKs");
    self.sessionstate = "spectator";
    self.spectatorclient = killcamsettings.spectatorclient;
    self.killcamentity = -1;
    self thread set_killcam_entities(killcamsettings.killcam_entity_info, killcamstarttime);
    self.killcamtargetentity = killcamsettings.targetentityindex;
    self.killcamweapon = killcamsettings.weapon;
    self.killcammod = killcamsettings.meansofdeath;
    self.archivetime = killcamoffset;
    self.killcamlength = killcamlength;
    self.psoffsettime = killcamsettings.offsettime;
    foreach (team in level.teams) {
        self allowspectateteam(team, 1);
    }
    self allowspectateteam("freelook", 1);
    self allowspectateteam("none", 1);
    self thread function_5551058f();
    wait 0.05;
    if (!util::isprophuntgametype() && self.archivetime <= predelay) {
        self.spectatorclient = -1;
        self.killcamentity = -1;
        self.archivetime = 0;
        self.psoffsettime = 0;
        self.spectatekillcam = 0;
        self notify(#"end_killcam");
        return;
    }
    self thread check_for_abrupt_end();
    self.killcam = 1;
    if (!self issplitscreen()) {
        self function_a6953bec(camtime);
    }
    self thread wait_killcam_time();
    self thread wait_final_killcam_slowdown(level.finalkillcamsettings[winning_team].deathtime, killcamstarttime);
    self waittill(#"end_killcam");
}

// Namespace killcam
// Params 1, eflags: 0x1 linked
// Checksum 0x80881b92, Offset: 0x23a8
// Size: 0x254
function final_killcam(winner) {
    self endon(#"disconnect");
    level endon(#"game_ended");
    if (util::waslastround()) {
        setmatchflag("final_killcam", 1);
        setmatchflag("round_end_killcam", 0);
    } else {
        setmatchflag("final_killcam", 0);
        setmatchflag("round_end_killcam", 1);
    }
    /#
        if (getdvarint("<dev string:x63>") == 1) {
            setmatchflag("<dev string:x7a>", 1);
            setmatchflag("<dev string:x88>", 0);
        }
    #/
    if (!util::isprophuntgametype() && level.console) {
        self globallogic_spawn::setthirdperson(0);
    }
    /#
        while (getdvarint("<dev string:x9a>") == 1) {
            final_killcam_internal(winner);
        }
    #/
    final_killcam_internal(winner);
    util::setclientsysstate("levelNotify", "sndFKe");
    luinotifyevent(%post_killcam_transition);
    self freezecontrols(1);
    wait 1.5;
    self end(1);
    setmatchflag("final_killcam", 0);
    setmatchflag("round_end_killcam", 0);
    self spawn_end_of_final_killcam();
}

// Namespace killcam
// Params 0, eflags: 0x1 linked
// Checksum 0xc5845bc7, Offset: 0x2608
// Size: 0x44
function spawn_end_of_final_killcam() {
    [[ level.spawnspectator ]]();
    self freezecontrols(1);
    self visionset_mgr::player_shutdown();
}

// Namespace killcam
// Params 1, eflags: 0x1 linked
// Checksum 0xb2c1dcb3, Offset: 0x2658
// Size: 0x30
function is_entity_weapon(weapon) {
    if (weapon.name == "planemortar") {
        return true;
    }
    return false;
}

// Namespace killcam
// Params 5, eflags: 0x1 linked
// Checksum 0x66cef2cf, Offset: 0x2690
// Size: 0x154
function calc_time(weapon, entitystarttime, predelay, respawn, maxtime) {
    camtime = 0;
    if (getdvarstring("scr_killcam_time") == "") {
        if (is_entity_weapon(weapon)) {
            camtime = (gettime() - entitystarttime) / 1000 - predelay - 0.1;
        } else if (!respawn) {
            camtime = 5;
        } else if (weapon.isgrenadeweapon) {
            camtime = 4.25;
        } else {
            camtime = 2.5;
        }
    } else {
        camtime = getdvarfloat("scr_killcam_time");
    }
    if (isdefined(maxtime)) {
        if (camtime > maxtime) {
            camtime = maxtime;
        }
        if (camtime < 0.05) {
            camtime = 0.05;
        }
    }
    return camtime;
}

// Namespace killcam
// Params 0, eflags: 0x1 linked
// Checksum 0x960fac8c, Offset: 0x27f0
// Size: 0x80
function calc_post_delay() {
    postdelay = 0;
    if (getdvarstring("scr_killcam_posttime") == "") {
        postdelay = 2;
    } else {
        postdelay = getdvarfloat("scr_killcam_posttime");
        if (postdelay < 0.05) {
            postdelay = 0.05;
        }
    }
    return postdelay;
}

// Namespace killcam
// Params 1, eflags: 0x1 linked
// Checksum 0x7666f597, Offset: 0x2878
// Size: 0x2c
function function_62ea5b06(respawn) {
    self clientfield::set_player_uimodel("hudItems.killcamAllowRespawn", respawn);
}

// Namespace killcam
// Params 1, eflags: 0x1 linked
// Checksum 0x393d0282, Offset: 0x28b0
// Size: 0xc
function function_a6953bec(camtime) {
    
}

// Namespace killcam
// Params 0, eflags: 0x0
// Checksum 0xa8124b2f, Offset: 0x28c8
// Size: 0x550
function function_c0c42164() {
    if (!isdefined(self.var_60dc2732)) {
        self.var_60dc2732 = newclienthudelem(self);
        self.var_60dc2732.archived = 0;
        self.var_60dc2732.x = 0;
        self.var_60dc2732.alignx = "center";
        self.var_60dc2732.aligny = "top";
        self.var_60dc2732.horzalign = "center_adjustable";
        self.var_60dc2732.vertalign = "top_adjustable";
        self.var_60dc2732.sort = 1;
        self.var_60dc2732.font = "default";
        self.var_60dc2732.foreground = 1;
        self.var_60dc2732.hidewheninmenu = 1;
        if (self issplitscreen()) {
            self.var_60dc2732.y = 20;
            self.var_60dc2732.fontscale = 1.2;
        } else {
            self.var_60dc2732.y = 32;
            self.var_60dc2732.fontscale = 1.8;
        }
    }
    if (!isdefined(self.var_211281d9)) {
        self.var_211281d9 = newclienthudelem(self);
        self.var_211281d9.archived = 0;
        self.var_211281d9.y = 48;
        self.var_211281d9.alignx = "left";
        self.var_211281d9.aligny = "top";
        self.var_211281d9.horzalign = "center";
        self.var_211281d9.vertalign = "middle";
        self.var_211281d9.sort = 10;
        self.var_211281d9.font = "small";
        self.var_211281d9.foreground = 1;
        self.var_211281d9.hidewheninmenu = 1;
        if (self issplitscreen()) {
            self.var_211281d9.x = 16;
            self.var_211281d9.fontscale = 1.2;
        } else {
            self.var_211281d9.x = 32;
            self.var_211281d9.fontscale = 1.6;
        }
    }
    if (!isdefined(self.var_7723af09)) {
        self.var_7723af09 = newclienthudelem(self);
        self.var_7723af09.archived = 0;
        self.var_7723af09.x = 16;
        self.var_7723af09.y = 16;
        self.var_7723af09.alignx = "left";
        self.var_7723af09.aligny = "top";
        self.var_7723af09.horzalign = "center";
        self.var_7723af09.vertalign = "middle";
        self.var_7723af09.sort = 1;
        self.var_7723af09.foreground = 1;
        self.var_7723af09.hidewheninmenu = 1;
    }
    if (!self issplitscreen()) {
        if (!isdefined(self.var_9747cbb5)) {
            self.var_9747cbb5 = hud::createfontstring("hudbig", 1);
            self.var_9747cbb5.archived = 0;
            self.var_9747cbb5.x = 0;
            self.var_9747cbb5.alignx = "center";
            self.var_9747cbb5.aligny = "middle";
            self.var_9747cbb5.horzalign = "center_safearea";
            self.var_9747cbb5.vertalign = "top_adjustable";
            self.var_9747cbb5.y = 42;
            self.var_9747cbb5.sort = 1;
            self.var_9747cbb5.font = "hudbig";
            self.var_9747cbb5.foreground = 1;
            self.var_9747cbb5.color = (0.85, 0.85, 0.85);
            self.var_9747cbb5.hidewheninmenu = 1;
        }
    }
}

// Namespace killcam
// Params 3, eflags: 0x1 linked
// Checksum 0x7c8359a2, Offset: 0x2e20
// Size: 0x220
function get_closest_killcam_entity(attacker, killcamentities, depth) {
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
            betterkillcament = get_closest_killcam_entity(attacker, killcamentities, depth + 1);
            if (isdefined(betterkillcament)) {
                closestkillcament = betterkillcament;
            }
        }
    }
    return closestkillcament;
}

// Namespace killcam
// Params 3, eflags: 0x1 linked
// Checksum 0x18c1a0c0, Offset: 0x3048
// Size: 0x2e0
function get_killcam_entity(attacker, einflictor, weapon) {
    if (!isdefined(einflictor)) {
        return undefined;
    }
    if (isdefined(self.killcamkilledbyent)) {
        return self.killcamkilledbyent;
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
    if (weapon.name == "hero_gravityspikes") {
        return undefined;
    }
    if (einflictor.controlled === 1 || isdefined(attacker) && isplayer(attacker) && attacker isremotecontrolling() && einflictor.occupied === 1) {
        if (weapon.name == "sentinel_turret" || weapon.name == "helicopter_gunner_turret_primary" || weapon.name == "helicopter_gunner_turret_secondary" || weapon.name == "helicopter_gunner_turret_tertiary" || weapon.name == "amws_gun_turret_mp_player" || weapon.name == "auto_gun_turret") {
            return undefined;
        }
    }
    if (weapon.name == "dart") {
        return undefined;
    }
    if (isdefined(einflictor.killcament)) {
        if (einflictor.killcament == attacker) {
            return undefined;
        }
        return einflictor.killcament;
    } else if (isdefined(einflictor.killcamentities)) {
        return get_closest_killcam_entity(attacker, einflictor.killcamentities);
    }
    if (isdefined(einflictor.script_gameobjectname) && einflictor.script_gameobjectname == "bombzone") {
        return einflictor.killcament;
    }
    return einflictor;
}

// Namespace killcam
// Params 2, eflags: 0x1 linked
// Checksum 0xf54daf86, Offset: 0x3330
// Size: 0x92
function get_secondary_killcam_entity(entity, entity_info) {
    if (!isdefined(entity) || !isdefined(entity.killcamentityindex)) {
        return;
    }
    entity_info.entity_indexes[entity_info.entity_indexes.size] = entity.killcamentityindex;
    entity_info.entity_spawntimes[entity_info.entity_spawntimes.size] = entity.killcamentitystarttime;
}

// Namespace killcam
// Params 4, eflags: 0x1 linked
// Checksum 0xa548f237, Offset: 0x33d0
// Size: 0x10c
function get_primary_killcam_entity(attacker, einflictor, weapon, entity_info) {
    killcamentity = self get_killcam_entity(attacker, einflictor, weapon);
    killcamentitystarttime = get_killcam_entity_start_time(killcamentity);
    killcamentityindex = -1;
    if (isdefined(killcamentity)) {
        killcamentityindex = killcamentity getentitynumber();
    }
    entity_info.entity_indexes[entity_info.entity_indexes.size] = killcamentityindex;
    entity_info.entity_spawntimes[entity_info.entity_spawntimes.size] = killcamentitystarttime;
    get_secondary_killcam_entity(killcamentity, entity_info);
}

// Namespace killcam
// Params 3, eflags: 0x1 linked
// Checksum 0x18dcb8c4, Offset: 0x34e8
// Size: 0x80
function get_killcam_entity_info(attacker, einflictor, weapon) {
    entity_info = spawnstruct();
    entity_info.entity_indexes = [];
    entity_info.entity_spawntimes = [];
    get_primary_killcam_entity(attacker, einflictor, weapon, entity_info);
    return entity_info;
}

// Namespace killcam
// Params 1, eflags: 0x1 linked
// Checksum 0x91240d3c, Offset: 0x3570
// Size: 0x4c
function get_killcam_entity_info_starttime(entity_info) {
    if (entity_info.entity_spawntimes.size == 0) {
        return 0;
    }
    return entity_info.entity_spawntimes[entity_info.entity_spawntimes.size - 1];
}

