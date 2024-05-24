#using scripts/cp/_util;
#using scripts/cp/_tacticalinsertion;
#using scripts/cp/_challenges;
#using scripts/cp/gametypes/_spectating;
#using scripts/cp/gametypes/_globallogic_spawn;
#using scripts/cp/gametypes/_globallogic;
#using scripts/shared/weapons/_tacticalinsertion;
#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/hud_util_shared;
#using scripts/shared/challenges_shared;
#using scripts/shared/callbacks_shared;
#using scripts/codescripts/struct;

#namespace killcam;

// Namespace killcam
// Params 0, eflags: 0x2
// Checksum 0x5861b4cd, Offset: 0x398
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("killcam", &__init__, undefined, undefined);
}

// Namespace killcam
// Params 0, eflags: 0x1 linked
// Checksum 0xe6dedf18, Offset: 0x3d8
// Size: 0x24
function __init__() {
    callback::on_start_gametype(&init);
}

// Namespace killcam
// Params 0, eflags: 0x1 linked
// Checksum 0x87884ff4, Offset: 0x408
// Size: 0x7c
function init() {
    if (level.gametype === "coop") {
        level.killcam = getgametypesetting("allowKillcam");
        level.finalkillcam = getgametypesetting("allowFinalKillcam");
        /#
            level.var_3a9f9a38 = 0;
        #/
        init_final_killcam();
    }
}

// Namespace killcam
// Params 0, eflags: 0x1 linked
// Checksum 0xda0f617e, Offset: 0x490
// Size: 0xba
function init_final_killcam() {
    level.finalkillcamsettings = [];
    init_final_killcam_team("none");
    foreach (team in level.teams) {
        init_final_killcam_team(team);
    }
    level.finalkillcam_winner = undefined;
}

// Namespace killcam
// Params 1, eflags: 0x1 linked
// Checksum 0xdca19327, Offset: 0x558
// Size: 0x44
function init_final_killcam_team(team) {
    level.finalkillcamsettings[team] = spawnstruct();
    clear_final_killcam_team(team);
}

// Namespace killcam
// Params 1, eflags: 0x1 linked
// Checksum 0x9595bcf4, Offset: 0x5a8
// Size: 0x112
function clear_final_killcam_team(team) {
    level.finalkillcamsettings[team].spectatorclient = undefined;
    level.finalkillcamsettings[team].weapon = undefined;
    level.finalkillcamsettings[team].deathtime = undefined;
    level.finalkillcamsettings[team].deathtimeoffset = undefined;
    level.finalkillcamsettings[team].offsettime = undefined;
    level.finalkillcamsettings[team].entityindex = undefined;
    level.finalkillcamsettings[team].targetentityindex = undefined;
    level.finalkillcamsettings[team].entitystarttime = undefined;
    level.finalkillcamsettings[team].perks = undefined;
    level.finalkillcamsettings[team].killstreaks = undefined;
    level.finalkillcamsettings[team].attacker = undefined;
}

// Namespace killcam
// Params 11, eflags: 0x0
// Checksum 0x717923bc, Offset: 0x6c8
// Size: 0x344
function record_settings(spectatorclient, targetentityindex, weapon, deathtime, deathtimeoffset, offsettime, entityindex, entitystarttime, perks, killstreaks, attacker) {
    if (level.teambased && isdefined(attacker.team) && isdefined(level.teams[attacker.team])) {
        team = attacker.team;
        level.finalkillcamsettings[team].spectatorclient = spectatorclient;
        level.finalkillcamsettings[team].weapon = weapon;
        level.finalkillcamsettings[team].deathtime = deathtime;
        level.finalkillcamsettings[team].deathtimeoffset = deathtimeoffset;
        level.finalkillcamsettings[team].offsettime = offsettime;
        level.finalkillcamsettings[team].entityindex = entityindex;
        level.finalkillcamsettings[team].targetentityindex = targetentityindex;
        level.finalkillcamsettings[team].entitystarttime = entitystarttime;
        level.finalkillcamsettings[team].perks = perks;
        level.finalkillcamsettings[team].killstreaks = killstreaks;
        level.finalkillcamsettings[team].attacker = attacker;
    }
    level.finalkillcamsettings["none"].spectatorclient = spectatorclient;
    level.finalkillcamsettings["none"].weapon = weapon;
    level.finalkillcamsettings["none"].deathtime = deathtime;
    level.finalkillcamsettings["none"].deathtimeoffset = deathtimeoffset;
    level.finalkillcamsettings["none"].offsettime = offsettime;
    level.finalkillcamsettings["none"].entityindex = entityindex;
    level.finalkillcamsettings["none"].targetentityindex = targetentityindex;
    level.finalkillcamsettings["none"].entitystarttime = entitystarttime;
    level.finalkillcamsettings["none"].perks = perks;
    level.finalkillcamsettings["none"].killstreaks = killstreaks;
    level.finalkillcamsettings["none"].attacker = attacker;
}

// Namespace killcam
// Params 0, eflags: 0x0
// Checksum 0x207f8b28, Offset: 0xa18
// Size: 0xaa
function erase_final_killcam() {
    clear_final_killcam_team("none");
    foreach (team in level.teams) {
        clear_final_killcam_team(team);
    }
    level.finalkillcam_winner = undefined;
}

// Namespace killcam
// Params 0, eflags: 0x1 linked
// Checksum 0xf08cc071, Offset: 0xad0
// Size: 0x24
function final_killcam_waiter() {
    if (!isdefined(level.finalkillcam_winner)) {
        return false;
    }
    level waittill(#"final_killcam_done");
    return true;
}

// Namespace killcam
// Params 0, eflags: 0x0
// Checksum 0x7c8a4aaa, Offset: 0xb00
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
// Params 0, eflags: 0x0
// Checksum 0xe4d7315e, Offset: 0xb58
// Size: 0x1bc
function do_final_killcam() {
    level waittill(#"play_final_killcam");
    level.infinalkillcam = 1;
    winner = "none";
    if (isdefined(level.finalkillcam_winner)) {
        winner = level.finalkillcam_winner;
    }
    if (!isdefined(level.finalkillcamsettings[winner].targetentityindex)) {
        level.infinalkillcam = 0;
        level notify(#"final_killcam_done");
        return;
    }
    if (isdefined(level.finalkillcamsettings[winner].attacker)) {
        challenges::getfinalkill(level.finalkillcamsettings[winner].attacker);
    }
    visionsetnaked(getdvarstring("mapname"), 0);
    players = level.players;
    for (index = 0; index < players.size; index++) {
        player = players[index];
        player closeingamemenu();
        player thread final_killcam(winner);
    }
    wait(0.1);
    while (are_any_players_watching()) {
        wait(0.05);
    }
    level notify(#"final_killcam_done");
    level.infinalkillcam = 0;
}

// Namespace killcam
// Params 0, eflags: 0x0
// Checksum 0x99ec1590, Offset: 0xd20
// Size: 0x4
function function_ec4e2b9c() {
    
}

// Namespace killcam
// Params 0, eflags: 0x1 linked
// Checksum 0xd45124de, Offset: 0xd30
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
// Params 15, eflags: 0x1 linked
// Checksum 0x6cd1ef81, Offset: 0xdb0
// Size: 0x5b4
function killcam(attackernum, targetnum, killcamentity, killcamentityindex, killcamentitystarttime, weapon, deathtime, deathtimeoffset, offsettime, respawn, maxtime, perks, killstreaks, attacker, body) {
    self endon(#"disconnect");
    self endon(#"spawned");
    level endon(#"game_ended");
    if (isdefined(body)) {
        codesetclientfield(body, "hide_body", 0);
    }
    if (killcamentityindex < 0 || killcamentityindex === targetnum) {
        self notify(#"end_killcam");
        return;
    }
    postdeathdelay = (gettime() - deathtime) / 1000;
    predelay = postdeathdelay + deathtimeoffset;
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
    killcamstarttime = gettime() - killcamoffset * 1000;
    self.sessionstate = "spectator";
    self.spectatorclient = attackernum;
    self.killcamentity = -1;
    if (killcamentityindex >= 0) {
        self thread set_entity(killcamentityindex, killcamentitystarttime - killcamstarttime - 100);
    }
    self.killcamtargetentity = targetnum;
    self.archivetime = killcamoffset;
    self.killcamlength = killcamlength;
    self.psoffsettime = offsettime;
    self.var_7b6b6cbb = camtime;
    self.var_1c362abb = self.killcamlength - camtime;
    foreach (team in level.teams) {
        self allowspectateteam(team, 1);
    }
    self allowspectateteam("freelook", 1);
    self allowspectateteam("none", 1);
    self thread function_548eaf1e();
    wait(0.05);
    if (self.archivetime <= predelay) {
        self.sessionstate = "spectator";
        self.spectatorclient = -1;
        self.killcamentity = -1;
        self.archivetime = 0;
        self.psoffsettime = 0;
        self notify(#"end_killcam");
        return;
    }
    self thread check_for_abrupt_end();
    self.killcam = 1;
    if (!self issplitscreen() && level.perksenabled == 1) {
        self function_a6953bec(camtime);
        self hud::showperks();
    }
    self thread spawned_killcam_cleanup();
    self thread wait_team_change_end_killcam();
    self thread wait_killcam_time();
    self thread function_6cc9650b();
    self thread tacticalinsertion::cancel_button_think();
    self waittill(#"end_killcam");
    self.var_acfedf1c = undefined;
    self.var_ebd83169 = undefined;
    self end(0);
    self.sessionstate = "spectator";
    self.spectatorclient = -1;
    self.killcamentity = -1;
    self.archivetime = 0;
    self.psoffsettime = 0;
}

// Namespace killcam
// Params 2, eflags: 0x1 linked
// Checksum 0x44c6fbf1, Offset: 0x1370
// Size: 0x5c
function set_entity(killcamentityindex, delayms) {
    self endon(#"disconnect");
    self endon(#"end_killcam");
    self endon(#"spawned");
    if (delayms > 0) {
        wait(delayms / 1000);
    }
    self.killcamentity = killcamentityindex;
}

// Namespace killcam
// Params 0, eflags: 0x1 linked
// Checksum 0x6509566a, Offset: 0x13d8
// Size: 0x3a
function wait_killcam_time() {
    self endon(#"disconnect");
    self endon(#"end_killcam");
    wait(self.killcamlength - 0.05);
    self notify(#"end_killcam");
}

// Namespace killcam
// Params 0, eflags: 0x1 linked
// Checksum 0x84e093ad, Offset: 0x1420
// Size: 0x3a
function function_6cc9650b() {
    self endon(#"disconnect");
    self endon(#"end_killcam");
    wait(self.var_7b6b6cbb - 0.05);
    self notify(#"hash_4cb3b8de");
}

// Namespace killcam
// Params 2, eflags: 0x1 linked
// Checksum 0xfade027c, Offset: 0x1468
// Size: 0x12c
function wait_final_killcam_slowdown(deathtime, starttime) {
    self endon(#"disconnect");
    self endon(#"end_killcam");
    secondsuntildeath = (deathtime - starttime) / 1000;
    deathtime = gettime() + secondsuntildeath * 1000;
    waitbeforedeath = 2;
    util::setclientsysstate("levelNotify", "fkcb");
    wait(max(0, secondsuntildeath - waitbeforedeath));
    setslowmotion(1, 0.25, waitbeforedeath);
    wait(waitbeforedeath + 0.5);
    setslowmotion(0.25, 1, 1);
    wait(0.5);
    util::setclientsysstate("levelNotify", "fkce");
}

// Namespace killcam
// Params 0, eflags: 0x0
// Checksum 0xf9a717c3, Offset: 0x15a0
// Size: 0x8c
function wait_skip_killcam_button() {
    self endon(#"disconnect");
    self endon(#"end_killcam");
    while (self usebuttonpressed()) {
        wait(0.05);
    }
    while (!self usebuttonpressed()) {
        wait(0.05);
    }
    self notify(#"end_killcam");
    self util::clientnotify("fkce");
}

// Namespace killcam
// Params 0, eflags: 0x1 linked
// Checksum 0xac2f6520, Offset: 0x1638
// Size: 0x3c
function wait_team_change_end_killcam() {
    self endon(#"disconnect");
    self endon(#"end_killcam");
    self waittill(#"changed_class");
    end(0);
}

// Namespace killcam
// Params 0, eflags: 0x0
// Checksum 0xe595ff8a, Offset: 0x1680
// Size: 0x7e
function wait_skip_killcam_safe_spawn_button() {
    self endon(#"disconnect");
    self endon(#"end_killcam");
    while (self fragbuttonpressed()) {
        wait(0.05);
    }
    while (!self fragbuttonpressed()) {
        wait(0.05);
    }
    self.wantsafespawn = 1;
    self notify(#"end_killcam");
}

// Namespace killcam
// Params 1, eflags: 0x1 linked
// Checksum 0xbfb906c7, Offset: 0x1708
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
// Checksum 0x8401c67e, Offset: 0x1780
// Size: 0x52
function check_for_abrupt_end() {
    self endon(#"disconnect");
    self endon(#"end_killcam");
    while (true) {
        if (self.archivetime <= 0) {
            break;
        }
        wait(0.05);
    }
    self notify(#"end_killcam");
}

// Namespace killcam
// Params 0, eflags: 0x1 linked
// Checksum 0x28f547eb, Offset: 0x17e0
// Size: 0x3c
function spawned_killcam_cleanup() {
    self endon(#"end_killcam");
    self endon(#"disconnect");
    self waittill(#"spawned");
    self end(0);
}

// Namespace killcam
// Params 1, eflags: 0x0
// Checksum 0x3878a62e, Offset: 0x1828
// Size: 0x9c
function spectator_killcam_cleanup(attacker) {
    self endon(#"end_killcam");
    self endon(#"disconnect");
    attacker endon(#"disconnect");
    var_ce2fdf61 = attacker waittill(#"begin_killcam");
    waittime = max(0, var_ce2fdf61 - self.deathtime - 50);
    wait(waittime);
    self end(0);
}

// Namespace killcam
// Params 0, eflags: 0x1 linked
// Checksum 0x39fd27fa, Offset: 0x18d0
// Size: 0x3c
function function_548eaf1e() {
    self endon(#"end_killcam");
    self endon(#"disconnect");
    level waittill(#"game_ended");
    self end(0);
}

// Namespace killcam
// Params 0, eflags: 0x1 linked
// Checksum 0x9bb20333, Offset: 0x1918
// Size: 0x44
function function_5551058f() {
    self endon(#"end_killcam");
    self endon(#"disconnect");
    level waittill(#"game_ended");
    self end(1);
}

// Namespace killcam
// Params 0, eflags: 0x1 linked
// Checksum 0x4bef9f31, Offset: 0x1968
// Size: 0x1a
function cancel_use_button() {
    return self usebuttonpressed();
}

// Namespace killcam
// Params 0, eflags: 0x0
// Checksum 0x7d460c2b, Offset: 0x1990
// Size: 0x1a
function cancel_safe_spawn_button() {
    return self fragbuttonpressed();
}

// Namespace killcam
// Params 0, eflags: 0x1 linked
// Checksum 0xca3a7481, Offset: 0x19b8
// Size: 0x10
function cancel_callback() {
    self.cancelkillcam = 1;
}

// Namespace killcam
// Params 0, eflags: 0x0
// Checksum 0xd5ff7f64, Offset: 0x19d0
// Size: 0x1c
function cancel_safe_spawn_callback() {
    self.cancelkillcam = 1;
    self.wantsafespawn = 1;
}

// Namespace killcam
// Params 0, eflags: 0x0
// Checksum 0xdb6d62c0, Offset: 0x19f8
// Size: 0x34
function cancel_on_use() {
    self thread cancel_on_use_specific_button(&cancel_use_button, &cancel_callback);
}

// Namespace killcam
// Params 2, eflags: 0x1 linked
// Checksum 0x6e042f85, Offset: 0x1a38
// Size: 0x11c
function cancel_on_use_specific_button(pressingbuttonfunc, finishedfunc) {
    self endon(#"death_delay_finished");
    self endon(#"disconnect");
    level endon(#"game_ended");
    for (;;) {
        if (!self [[ pressingbuttonfunc ]]()) {
            wait(0.05);
            continue;
        }
        buttontime = 0;
        while (self [[ pressingbuttonfunc ]]()) {
            buttontime += 0.05;
            wait(0.05);
        }
        if (buttontime >= 0.5) {
            continue;
        }
        buttontime = 0;
        while (!self [[ pressingbuttonfunc ]]() && buttontime < 0.5) {
            buttontime += 0.05;
            wait(0.05);
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
// Checksum 0xb4da148a, Offset: 0x1b60
// Size: 0x57c
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
        if (getdvarint("freelook") == 1) {
            setmatchflag("freelook", 1);
            setmatchflag("freelook", 0);
        }
    #/
    if (level.console) {
        self globallogic_spawn::setthirdperson(0);
    }
    killcamsettings = level.finalkillcamsettings[winner];
    postdeathdelay = (gettime() - killcamsettings.deathtime) / 1000;
    predelay = postdeathdelay + killcamsettings.deathtimeoffset;
    camtime = calc_time(killcamsettings.weapon, killcamsettings.entitystarttime, predelay, 0, undefined);
    postdelay = calc_post_delay();
    killcamoffset = camtime + predelay;
    killcamlength = camtime + postdelay - 0.05;
    killcamstarttime = gettime() - killcamoffset * 1000;
    self notify(#"begin_killcam", gettime());
    self.sessionstate = "spectator";
    self.spectatorclient = killcamsettings.spectatorclient;
    self.killcamentity = -1;
    if (killcamsettings.entityindex >= 0) {
        self thread set_entity(killcamsettings.entityindex, killcamsettings.entitystarttime - killcamstarttime - 100);
    }
    self.killcamtargetentity = killcamsettings.targetentityindex;
    self.archivetime = killcamoffset;
    self.killcamlength = killcamlength;
    self.psoffsettime = killcamsettings.offsettime;
    foreach (team in level.teams) {
        self allowspectateteam(team, 1);
    }
    self allowspectateteam("freelook", 1);
    self allowspectateteam("none", 1);
    self thread function_5551058f();
    wait(0.05);
    if (self.archivetime <= predelay) {
        self.sessionstate = "dead";
        self.spectatorclient = -1;
        self.killcamentity = -1;
        self.archivetime = 0;
        self.psoffsettime = 0;
        self notify(#"end_killcam");
        return;
    }
    self thread check_for_abrupt_end();
    self.killcam = 1;
    if (!self issplitscreen()) {
        self function_a6953bec(camtime);
    }
    self thread wait_killcam_time();
    self thread wait_final_killcam_slowdown(level.finalkillcamsettings[winner].deathtime, killcamstarttime);
    self waittill(#"end_killcam");
    self end(1);
    setmatchflag("final_killcam", 0);
    setmatchflag("round_end_killcam", 0);
    self spawn_end_of_final_killcam();
}

// Namespace killcam
// Params 0, eflags: 0x1 linked
// Checksum 0x2072a195, Offset: 0x20e8
// Size: 0x2c
function spawn_end_of_final_killcam() {
    [[ level.spawnspectator ]]();
    self freezecontrols(1);
}

// Namespace killcam
// Params 1, eflags: 0x1 linked
// Checksum 0x5cba60e3, Offset: 0x2120
// Size: 0x30
function is_entity_weapon(weapon) {
    if (weapon.name == "planemortar") {
        return true;
    }
    return false;
}

// Namespace killcam
// Params 5, eflags: 0x1 linked
// Checksum 0x738c0b1d, Offset: 0x2158
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
// Checksum 0x6121d203, Offset: 0x22b8
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
// Params 1, eflags: 0x0
// Checksum 0xc8f52e17, Offset: 0x2340
// Size: 0x1c0
function function_62ea5b06(respawn) {
    if (!isdefined(self.var_60dc2732)) {
        self.var_60dc2732 = newclienthudelem(self);
        self.var_60dc2732.archived = 0;
        self.var_60dc2732.x = 0;
        self.var_60dc2732.alignx = "center";
        self.var_60dc2732.aligny = "middle";
        self.var_60dc2732.horzalign = "center";
        self.var_60dc2732.vertalign = "bottom";
        self.var_60dc2732.sort = 1;
        self.var_60dc2732.font = "objective";
    }
    if (self issplitscreen()) {
        self.var_60dc2732.y = -100;
        self.var_60dc2732.fontscale = 1.4;
    } else {
        self.var_60dc2732.y = -120;
        self.var_60dc2732.fontscale = 2;
    }
    if (respawn) {
        self.var_60dc2732 settext(%PLATFORM_PRESS_TO_RESPAWN);
    } else {
        self.var_60dc2732 settext(%PLATFORM_PRESS_TO_SKIP);
    }
    self.var_60dc2732.alpha = 1;
}

// Namespace killcam
// Params 1, eflags: 0x1 linked
// Checksum 0x2d335697, Offset: 0x2508
// Size: 0xc
function function_a6953bec(camtime) {
    
}

// Namespace killcam
// Params 0, eflags: 0x0
// Checksum 0x3f5f4708, Offset: 0x2520
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

