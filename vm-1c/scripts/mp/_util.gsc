#using scripts/shared/util_shared;
#using scripts/shared/sound_shared;
#using scripts/shared/math_shared;
#using scripts/shared/lui_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/array_shared;

#namespace util;

/#

    // Namespace util
    // Params 1, eflags: 0x1 linked
    // Checksum 0x35ebbcc1, Offset: 0x3b0
    // Size: 0x74
    function error(msg) {
        println("<dev string:x28>", msg);
        wait 0.05;
        if (getdvarstring("<dev string:x33>") != "<dev string:x39>") {
            assertmsg("<dev string:x3b>");
        }
    }

    // Namespace util
    // Params 1, eflags: 0x1 linked
    // Checksum 0x999fc99c, Offset: 0x430
    // Size: 0x34
    function warning(msg) {
        println("<dev string:x68>" + msg);
    }

#/

// Namespace util
// Params 4, eflags: 0x1 linked
// Checksum 0x992e3be3, Offset: 0x470
// Size: 0xa2
function within_fov(start_origin, start_angles, end_origin, fov) {
    normal = vectornormalize(end_origin - start_origin);
    forward = anglestoforward(start_angles);
    dot = vectordot(forward, normal);
    return dot >= fov;
}

// Namespace util
// Params 0, eflags: 0x1 linked
// Checksum 0x67a7e87c, Offset: 0x520
// Size: 0xa
function get_player_height() {
    return 70;
}

// Namespace util
// Params 1, eflags: 0x0
// Checksum 0xb7a36004, Offset: 0x538
// Size: 0x3c
function isbulletimpactmod(smeansofdeath) {
    return issubstr(smeansofdeath, "BULLET") || smeansofdeath == "MOD_HEAD_SHOT";
}

// Namespace util
// Params 0, eflags: 0x0
// Checksum 0x199a247e, Offset: 0x580
// Size: 0x40
function waitrespawnbutton() {
    self endon(#"disconnect");
    self endon(#"end_respawn");
    while (self usebuttonpressed() != 1) {
        wait 0.05;
    }
}

// Namespace util
// Params 3, eflags: 0x1 linked
// Checksum 0x2ad698a4, Offset: 0x5c8
// Size: 0x200
function setlowermessage(text, time, var_452e72bb) {
    if (!isdefined(self.lowermessage)) {
        return;
    }
    if (isdefined(self.var_fc558bd1) && text != %) {
        text = self.var_fc558bd1;
        time = undefined;
    }
    self notify(#"hash_f81ee759");
    self.lowermessage settext(text);
    if (isdefined(time) && time > 0) {
        if (!isdefined(var_452e72bb) || !var_452e72bb) {
            self.lowertimer.label = %;
        } else {
            self.lowermessage settext("");
            self.lowertimer.label = text;
        }
        self.lowertimer settimer(time);
    } else {
        self.lowertimer settext("");
        self.lowertimer.label = %;
    }
    if (self issplitscreen()) {
        self.lowermessage.fontscale = 1.4;
    }
    self.lowermessage fadeovertime(0.05);
    self.lowermessage.alpha = 1;
    self.lowertimer fadeovertime(0.05);
    self.lowertimer.alpha = 1;
}

// Namespace util
// Params 3, eflags: 0x0
// Checksum 0x193d1a84, Offset: 0x7d0
// Size: 0x228
function function_9468e63a(text, value, var_e51ab3d) {
    if (!isdefined(self.lowermessage)) {
        return;
    }
    if (isdefined(self.var_fc558bd1) && text != %) {
        text = self.var_fc558bd1;
        time = undefined;
    }
    self notify(#"hash_f81ee759");
    if (!isdefined(var_e51ab3d) || !var_e51ab3d) {
        self.lowermessage settext(text);
    } else {
        self.lowermessage settext("");
    }
    if (isdefined(value) && value > 0) {
        if (!isdefined(var_e51ab3d) || !var_e51ab3d) {
            self.lowertimer.label = %;
        } else {
            self.lowertimer.label = text;
        }
        self.lowertimer setvalue(value);
    } else {
        self.lowertimer settext("");
        self.lowertimer.label = %;
    }
    if (self issplitscreen()) {
        self.lowermessage.fontscale = 1.4;
    }
    self.lowermessage fadeovertime(0.05);
    self.lowermessage.alpha = 1;
    self.lowertimer fadeovertime(0.05);
    self.lowertimer.alpha = 1;
}

// Namespace util
// Params 1, eflags: 0x1 linked
// Checksum 0x380f59f4, Offset: 0xa00
// Size: 0xf4
function clearlowermessage(fadetime) {
    if (!isdefined(self.lowermessage)) {
        return;
    }
    self notify(#"hash_f81ee759");
    if (!isdefined(fadetime) || fadetime == 0) {
        setlowermessage(%);
        return;
    }
    self endon(#"disconnect");
    self endon(#"hash_f81ee759");
    self.lowermessage fadeovertime(fadetime);
    self.lowermessage.alpha = 0;
    self.lowertimer fadeovertime(fadetime);
    self.lowertimer.alpha = 0;
    wait fadetime;
    self setlowermessage("");
}

// Namespace util
// Params 2, eflags: 0x0
// Checksum 0x890aab74, Offset: 0xb00
// Size: 0xd6
function printonteam(text, team) {
    assert(isdefined(level.players));
    for (i = 0; i < level.players.size; i++) {
        player = level.players[i];
        if (isdefined(player.pers["team"]) && player.pers["team"] == team) {
            player iprintln(text);
        }
    }
}

// Namespace util
// Params 2, eflags: 0x0
// Checksum 0xb46b3114, Offset: 0xbe0
// Size: 0xd6
function printboldonteam(text, team) {
    assert(isdefined(level.players));
    for (i = 0; i < level.players.size; i++) {
        player = level.players[i];
        if (isdefined(player.pers["team"]) && player.pers["team"] == team) {
            player iprintlnbold(text);
        }
    }
}

// Namespace util
// Params 3, eflags: 0x0
// Checksum 0x74035c02, Offset: 0xcc0
// Size: 0xde
function printboldonteamarg(text, team, arg) {
    assert(isdefined(level.players));
    for (i = 0; i < level.players.size; i++) {
        player = level.players[i];
        if (isdefined(player.pers["team"]) && player.pers["team"] == team) {
            player iprintlnbold(text, arg);
        }
    }
}

// Namespace util
// Params 3, eflags: 0x0
// Checksum 0x238842a6, Offset: 0xda8
// Size: 0x1c
function printonteamarg(text, team, arg) {
    
}

// Namespace util
// Params 2, eflags: 0x0
// Checksum 0xa87d9305, Offset: 0xdd0
// Size: 0xee
function printonplayers(text, team) {
    players = level.players;
    for (i = 0; i < players.size; i++) {
        if (isdefined(team)) {
            if (isdefined(players[i].pers["team"]) && players[i].pers["team"] == team) {
                players[i] iprintln(text);
            }
            continue;
        }
        players[i] iprintln(text);
    }
}

// Namespace util
// Params 7, eflags: 0x1 linked
// Checksum 0x26cc4a64, Offset: 0xec8
// Size: 0x516
function printandsoundoneveryone(team, enemyteam, printfriendly, printenemy, soundfriendly, soundenemy, printarg) {
    shoulddosounds = isdefined(soundfriendly);
    shoulddoenemysounds = 0;
    if (isdefined(soundenemy)) {
        assert(shoulddosounds);
        shoulddoenemysounds = 1;
    }
    if (!isdefined(printarg)) {
        printarg = "";
    }
    if (level.splitscreen || !shoulddosounds) {
        for (i = 0; i < level.players.size; i++) {
            player = level.players[i];
            playerteam = player.pers["team"];
            if (isdefined(playerteam)) {
                if (playerteam == team && isdefined(printfriendly) && printfriendly != %) {
                    player iprintln(printfriendly, printarg);
                    continue;
                }
                if (isdefined(printenemy) && printenemy != %) {
                    if (isdefined(enemyteam) && playerteam == enemyteam) {
                        player iprintln(printenemy, printarg);
                        continue;
                    }
                    if (!isdefined(enemyteam) && playerteam != team) {
                        player iprintln(printenemy, printarg);
                    }
                }
            }
        }
        if (shoulddosounds) {
            assert(level.splitscreen);
            level.players[0] playlocalsound(soundfriendly);
        }
        return;
    }
    assert(shoulddosounds);
    if (shoulddoenemysounds) {
        for (i = 0; i < level.players.size; i++) {
            player = level.players[i];
            playerteam = player.pers["team"];
            if (isdefined(playerteam)) {
                if (playerteam == team) {
                    if (isdefined(printfriendly) && printfriendly != %) {
                        player iprintln(printfriendly, printarg);
                    }
                    player playlocalsound(soundfriendly);
                    continue;
                }
                if (!isdefined(enemyteam) && (isdefined(enemyteam) && playerteam == enemyteam || playerteam != team)) {
                    if (isdefined(printenemy) && printenemy != %) {
                        player iprintln(printenemy, printarg);
                    }
                    player playlocalsound(soundenemy);
                }
            }
        }
        return;
    }
    for (i = 0; i < level.players.size; i++) {
        player = level.players[i];
        playerteam = player.pers["team"];
        if (isdefined(playerteam)) {
            if (playerteam == team) {
                if (isdefined(printfriendly) && printfriendly != %) {
                    player iprintln(printfriendly, printarg);
                }
                player playlocalsound(soundfriendly);
                continue;
            }
            if (isdefined(printenemy) && printenemy != %) {
                if (isdefined(enemyteam) && playerteam == enemyteam) {
                    player iprintln(printenemy, printarg);
                    continue;
                }
                if (!isdefined(enemyteam) && playerteam != team) {
                    player iprintln(printenemy, printarg);
                }
            }
        }
    }
}

// Namespace util
// Params 1, eflags: 0x0
// Checksum 0x2fd5dd2d, Offset: 0x13e8
// Size: 0x4c
function _playlocalsound(soundalias) {
    if (level.splitscreen && !self ishost()) {
        return;
    }
    self playlocalsound(soundalias);
}

// Namespace util
// Params 1, eflags: 0x1 linked
// Checksum 0x3ae8711c, Offset: 0x1440
// Size: 0x74
function getotherteam(team) {
    if (team == "allies") {
        return "axis";
    } else if (team == "axis") {
        return "allies";
    } else {
        return "allies";
    }
    assertmsg("<dev string:x74>" + team);
}

// Namespace util
// Params 1, eflags: 0x1 linked
// Checksum 0x63204842, Offset: 0x14c0
// Size: 0x64
function getteammask(team) {
    if (!level.teambased || !isdefined(team) || !isdefined(level.spawnsystem.ispawn_teammask[team])) {
        return level.spawnsystem.ispawn_teammask_free;
    }
    return level.spawnsystem.ispawn_teammask[team];
}

// Namespace util
// Params 1, eflags: 0x1 linked
// Checksum 0xa6008ab9, Offset: 0x1530
// Size: 0xc4
function getotherteamsmask(skip_team) {
    mask = 0;
    foreach (team in level.teams) {
        if (team == skip_team) {
            continue;
        }
        mask |= getteammask(team);
    }
    return mask;
}

// Namespace util
// Params 5, eflags: 0x1 linked
// Checksum 0xd389b7c, Offset: 0x1600
// Size: 0x74
function wait_endon(waittime, endonstring, endonstring2, endonstring3, endonstring4) {
    self endon(endonstring);
    if (isdefined(endonstring2)) {
        self endon(endonstring2);
    }
    if (isdefined(endonstring3)) {
        self endon(endonstring3);
    }
    if (isdefined(endonstring4)) {
        self endon(endonstring4);
    }
    wait waittime;
    return true;
}

/#

    // Namespace util
    // Params 5, eflags: 0x1 linked
    // Checksum 0x3f567d86, Offset: 0x1680
    // Size: 0x10e
    function plot_points(plotpoints, r, g, b, timer) {
        lastpoint = plotpoints[0];
        if (!isdefined(r)) {
            r = 1;
        }
        if (!isdefined(g)) {
            g = 1;
        }
        if (!isdefined(b)) {
            b = 1;
        }
        if (!isdefined(timer)) {
            timer = 0.05;
        }
        for (i = 1; i < plotpoints.size; i++) {
            line(lastpoint, plotpoints[i], (r, g, b), 1, timer);
            lastpoint = plotpoints[i];
        }
    }

#/

// Namespace util
// Params 1, eflags: 0x0
// Checksum 0xbc3ef4bd, Offset: 0x1798
// Size: 0x50
function getfx(fx) {
    assert(isdefined(level._effect[fx]), "<dev string:x90>" + fx + "<dev string:x94>");
    return level._effect[fx];
}

// Namespace util
// Params 3, eflags: 0x1 linked
// Checksum 0x9b0ed0a3, Offset: 0x17f0
// Size: 0x92
function set_dvar_if_unset(dvar, value, reset) {
    if (!isdefined(reset)) {
        reset = 0;
    }
    if (reset || getdvarstring(dvar) == "") {
        setdvar(dvar, value);
        return value;
    }
    return getdvarstring(dvar);
}

// Namespace util
// Params 3, eflags: 0x0
// Checksum 0xebb125bc, Offset: 0x1890
// Size: 0x8a
function set_dvar_float_if_unset(dvar, value, reset) {
    if (!isdefined(reset)) {
        reset = 0;
    }
    if (reset || getdvarstring(dvar) == "") {
        setdvar(dvar, value);
    }
    return getdvarfloat(dvar);
}

// Namespace util
// Params 3, eflags: 0x1 linked
// Checksum 0xd37540e4, Offset: 0x1928
// Size: 0xa2
function set_dvar_int_if_unset(dvar, value, reset) {
    if (!isdefined(reset)) {
        reset = 0;
    }
    if (reset || getdvarstring(dvar) == "") {
        setdvar(dvar, value);
        return int(value);
    }
    return getdvarint(dvar);
}

// Namespace util
// Params 1, eflags: 0x1 linked
// Checksum 0x8c32e329, Offset: 0x19d8
// Size: 0x5a
function add_trigger_to_ent(ent) {
    if (!isdefined(ent._triggers)) {
        ent._triggers = [];
    }
    ent._triggers[self getentitynumber()] = 1;
}

// Namespace util
// Params 1, eflags: 0x1 linked
// Checksum 0xfc164dc4, Offset: 0x1a40
// Size: 0x7a
function remove_trigger_from_ent(ent) {
    if (!isdefined(ent)) {
        return;
    }
    if (!isdefined(ent._triggers)) {
        return;
    }
    if (!isdefined(ent._triggers[self getentitynumber()])) {
        return;
    }
    ent._triggers[self getentitynumber()] = 0;
}

// Namespace util
// Params 1, eflags: 0x1 linked
// Checksum 0xcbfa7a71, Offset: 0x1ac8
// Size: 0x70
function ent_already_in_trigger(trig) {
    if (!isdefined(self._triggers)) {
        return false;
    }
    if (!isdefined(self._triggers[trig getentitynumber()])) {
        return false;
    }
    if (!self._triggers[trig getentitynumber()]) {
        return false;
    }
    return true;
}

// Namespace util
// Params 2, eflags: 0x1 linked
// Checksum 0xa379003d, Offset: 0x1b40
// Size: 0x44
function trigger_thread_death_monitor(ent, ender) {
    ent waittill(#"death");
    self endon(ender);
    self remove_trigger_from_ent(ent);
}

// Namespace util
// Params 3, eflags: 0x0
// Checksum 0x8a6d7ff6, Offset: 0x1b90
// Size: 0x1a6
function trigger_thread(ent, on_enter_payload, on_exit_payload) {
    ent endon(#"entityshutdown");
    ent endon(#"death");
    if (ent ent_already_in_trigger(self)) {
        return;
    }
    self add_trigger_to_ent(ent);
    ender = "end_trig_death_monitor" + self getentitynumber() + " " + ent getentitynumber();
    self thread trigger_thread_death_monitor(ent, ender);
    endon_condition = "leave_trigger_" + self getentitynumber();
    if (isdefined(on_enter_payload)) {
        self thread [[ on_enter_payload ]](ent, endon_condition);
    }
    while (isdefined(ent) && ent istouching(self)) {
        wait 0.01;
    }
    ent notify(endon_condition);
    if (isdefined(ent) && isdefined(on_exit_payload)) {
        self thread [[ on_exit_payload ]](ent);
    }
    if (isdefined(ent)) {
        self remove_trigger_from_ent(ent);
    }
    self notify(ender);
}

// Namespace util
// Params 2, eflags: 0x0
// Checksum 0x368601ae, Offset: 0x1d40
// Size: 0x38
function isstrstart(string1, substr) {
    return getsubstr(string1, 0, substr.size) == substr;
}

// Namespace util
// Params 0, eflags: 0x1 linked
// Checksum 0x68124eff, Offset: 0x1d80
// Size: 0x16
function iskillstreaksenabled() {
    return isdefined(level.killstreaksenabled) && level.killstreaksenabled;
}

// Namespace util
// Params 2, eflags: 0x1 linked
// Checksum 0xc4013efb, Offset: 0x1da0
// Size: 0xda
function setusingremote(remotename, set_killstreak_delay_killcam) {
    if (!isdefined(set_killstreak_delay_killcam)) {
        set_killstreak_delay_killcam = 1;
    }
    if (isdefined(self.carryicon)) {
        self.carryicon.alpha = 0;
    }
    assert(!self isusingremote());
    self.usingremote = remotename;
    if (set_killstreak_delay_killcam) {
        self.killstreak_delay_killcam = remotename;
    }
    self disableoffhandweapons();
    self clientfield::set_player_uimodel("hudItems.remoteKillstreakActivated", 1);
    self notify(#"using_remote");
}

// Namespace util
// Params 2, eflags: 0x1 linked
// Checksum 0x33171f8b, Offset: 0x1e88
// Size: 0x32
function setobjectivetext(team, text) {
    game["strings"]["objective_" + team] = text;
}

// Namespace util
// Params 2, eflags: 0x1 linked
// Checksum 0xcfbe3c2e, Offset: 0x1ec8
// Size: 0x32
function setobjectivescoretext(team, text) {
    game["strings"]["objective_score_" + team] = text;
}

// Namespace util
// Params 2, eflags: 0x1 linked
// Checksum 0x7606fe6a, Offset: 0x1f08
// Size: 0x32
function setobjectivehinttext(team, text) {
    game["strings"]["objective_hint_" + team] = text;
}

// Namespace util
// Params 1, eflags: 0x1 linked
// Checksum 0x168d0c90, Offset: 0x1f48
// Size: 0x24
function getobjectivetext(team) {
    return game["strings"]["objective_" + team];
}

// Namespace util
// Params 1, eflags: 0x1 linked
// Checksum 0x61f761de, Offset: 0x1f78
// Size: 0x24
function getobjectivescoretext(team) {
    return game["strings"]["objective_score_" + team];
}

// Namespace util
// Params 1, eflags: 0x1 linked
// Checksum 0x7fbb9a2, Offset: 0x1fa8
// Size: 0x24
function getobjectivehinttext(team) {
    return game["strings"]["objective_hint_" + team];
}

// Namespace util
// Params 2, eflags: 0x1 linked
// Checksum 0xb766aed1, Offset: 0x1fd8
// Size: 0x64
function registerroundswitch(minvalue, maxvalue) {
    level.roundswitch = math::clamp(getgametypesetting("roundSwitch"), minvalue, maxvalue);
    level.roundswitchmin = minvalue;
    level.roundswitchmax = maxvalue;
}

// Namespace util
// Params 2, eflags: 0x1 linked
// Checksum 0x221e1f6f, Offset: 0x2048
// Size: 0x64
function registerroundlimit(minvalue, maxvalue) {
    level.roundlimit = math::clamp(getgametypesetting("roundLimit"), minvalue, maxvalue);
    level.roundlimitmin = minvalue;
    level.roundlimitmax = maxvalue;
}

// Namespace util
// Params 2, eflags: 0x1 linked
// Checksum 0x32b6f2, Offset: 0x20b8
// Size: 0x64
function registerroundwinlimit(minvalue, maxvalue) {
    level.roundwinlimit = math::clamp(getgametypesetting("roundWinLimit"), minvalue, maxvalue);
    level.roundwinlimitmin = minvalue;
    level.roundwinlimitmax = maxvalue;
}

// Namespace util
// Params 2, eflags: 0x1 linked
// Checksum 0xfd59466, Offset: 0x2128
// Size: 0x84
function registerscorelimit(minvalue, maxvalue) {
    level.scorelimit = math::clamp(getgametypesetting("scoreLimit"), minvalue, maxvalue);
    level.scorelimitmin = minvalue;
    level.scorelimitmax = maxvalue;
    setdvar("ui_scorelimit", level.scorelimit);
}

// Namespace util
// Params 2, eflags: 0x1 linked
// Checksum 0x48fcba9f, Offset: 0x21b8
// Size: 0x64
function registerroundscorelimit(minvalue, maxvalue) {
    level.roundscorelimit = math::clamp(getgametypesetting("roundScoreLimit"), minvalue, maxvalue);
    level.roundscorelimitmin = minvalue;
    level.roundscorelimitmax = maxvalue;
}

// Namespace util
// Params 2, eflags: 0x1 linked
// Checksum 0x472a2371, Offset: 0x2228
// Size: 0x84
function registertimelimit(minvalue, maxvalue) {
    level.timelimit = math::clamp(getgametypesetting("timeLimit"), minvalue, maxvalue);
    level.timelimitmin = minvalue;
    level.timelimitmax = maxvalue;
    setdvar("ui_timelimit", level.timelimit);
}

// Namespace util
// Params 4, eflags: 0x1 linked
// Checksum 0xfb209220, Offset: 0x22b8
// Size: 0xec
function registernumlives(minvalue, maxvalue, teamlivesminvalue, teamlivesmaxvalue) {
    if (!isdefined(teamlivesminvalue)) {
        teamlivesminvalue = minvalue;
    }
    if (!isdefined(teamlivesmaxvalue)) {
        teamlivesmaxvalue = maxvalue;
    }
    level.numlives = math::clamp(getgametypesetting("playerNumLives"), minvalue, maxvalue);
    level.numlivesmin = minvalue;
    level.numlivesmax = maxvalue;
    level.numteamlives = math::clamp(getgametypesetting("teamNumLives"), teamlivesminvalue, teamlivesmaxvalue);
    level.numteamlivesmin = teamlivesminvalue;
    level.numteamlivesmax = teamlivesmaxvalue;
}

// Namespace util
// Params 1, eflags: 0x1 linked
// Checksum 0x5e445e80, Offset: 0x23b0
// Size: 0x7e
function getplayerfromclientnum(clientnum) {
    if (clientnum < 0) {
        return undefined;
    }
    for (i = 0; i < level.players.size; i++) {
        if (level.players[i] getentitynumber() == clientnum) {
            return level.players[i];
        }
    }
    return undefined;
}

// Namespace util
// Params 0, eflags: 0x0
// Checksum 0x9d289341, Offset: 0x2438
// Size: 0x4c
function ispressbuild() {
    buildtype = getdvarstring("buildType");
    if (isdefined(buildtype) && buildtype == "press") {
        return true;
    }
    return false;
}

// Namespace util
// Params 0, eflags: 0x1 linked
// Checksum 0x82f7f5dd, Offset: 0x2490
// Size: 0x1c
function isflashbanged() {
    return isdefined(self.flashendtime) && gettime() < self.flashendtime;
}

// Namespace util
// Params 5, eflags: 0x1 linked
// Checksum 0x874c0072, Offset: 0x24b8
// Size: 0xbc
function domaxdamage(origin, attacker, inflictor, headshot, mod) {
    if (isdefined(self.damagedtodeath) && self.damagedtodeath) {
        return;
    }
    if (isdefined(self.maxhealth)) {
        damage = self.maxhealth + 1;
    } else {
        damage = self.health + 1;
    }
    self.damagedtodeath = 1;
    self dodamage(damage, origin, attacker, inflictor, headshot, mod);
}

// Namespace util
// Params 0, eflags: 0x0
// Checksum 0x7a52cc76, Offset: 0x2580
// Size: 0x24
function self_delete() {
    if (isdefined(self)) {
        self delete();
    }
}

// Namespace util
// Params 5, eflags: 0x0
// Checksum 0x4cf14497, Offset: 0x25b0
// Size: 0x52c
function function_1ec499f0(var_237ef712, var_fd7c7ca9, var_d77a0240, var_e462c321, n_time) {
    level notify(#"hash_1ec499f0");
    level endon(#"hash_1ec499f0");
    if (isdefined(level.missionfailed) && level.missionfailed) {
        return;
    }
    if (getdvarint("hud_missionFailed") == 1) {
        return;
    }
    if (!isdefined(var_e462c321)) {
        var_e462c321 = 0;
    }
    if (!isdefined(level.var_703085a4)) {
        level.var_703085a4 = newhudelem();
        level.var_703085a4.elemtype = "font";
        level.var_703085a4.font = "objective";
        level.var_703085a4.fontscale = 1.8;
        level.var_703085a4.horzalign = "center";
        level.var_703085a4.vertalign = "middle";
        level.var_703085a4.alignx = "center";
        level.var_703085a4.aligny = "middle";
        level.var_703085a4.y = -60 + var_e462c321;
        level.var_703085a4.sort = 2;
        level.var_703085a4.color = (1, 1, 1);
        level.var_703085a4.alpha = 1;
        level.var_703085a4.hidewheninmenu = 1;
    }
    level.var_703085a4 settext(var_237ef712);
    if (isdefined(var_fd7c7ca9)) {
        if (!isdefined(level.var_e237f4df)) {
            level.var_e237f4df = newhudelem();
            level.var_e237f4df.elemtype = "font";
            level.var_e237f4df.font = "objective";
            level.var_e237f4df.fontscale = 1.8;
            level.var_e237f4df.horzalign = "center";
            level.var_e237f4df.vertalign = "middle";
            level.var_e237f4df.alignx = "center";
            level.var_e237f4df.aligny = "middle";
            level.var_e237f4df.y = -33 + var_e462c321;
            level.var_e237f4df.sort = 2;
            level.var_e237f4df.color = (1, 1, 1);
            level.var_e237f4df.alpha = 1;
            level.var_e237f4df.hidewheninmenu = 1;
        }
        level.var_e237f4df settext(var_fd7c7ca9);
    } else if (isdefined(level.var_e237f4df)) {
        level.var_e237f4df destroy();
    }
    if (isdefined(var_d77a0240)) {
        if (!isdefined(level.var_bc357a76)) {
            level.var_bc357a76 = newhudelem();
            level.var_bc357a76.elemtype = "font";
            level.var_bc357a76.font = "objective";
            level.var_bc357a76.fontscale = 1.8;
            level.var_bc357a76.horzalign = "center";
            level.var_bc357a76.vertalign = "middle";
            level.var_bc357a76.alignx = "center";
            level.var_bc357a76.aligny = "middle";
            level.var_bc357a76.y = -6 + var_e462c321;
            level.var_bc357a76.sort = 2;
            level.var_bc357a76.color = (1, 1, 1);
            level.var_bc357a76.alpha = 1;
            level.var_bc357a76.hidewheninmenu = 1;
        }
        level.var_bc357a76 settext(var_d77a0240);
    } else if (isdefined(level.var_bc357a76)) {
        level.var_bc357a76 destroy();
    }
    if (isdefined(n_time) && n_time > 0) {
        wait n_time;
        function_77f8007d();
    }
}

// Namespace util
// Params 1, eflags: 0x1 linked
// Checksum 0x1878c164, Offset: 0x2ae8
// Size: 0x94
function function_77f8007d(delay) {
    if (isdefined(delay)) {
        wait delay;
    }
    if (isdefined(level.var_703085a4)) {
        level.var_703085a4 destroy();
    }
    if (isdefined(level.var_e237f4df)) {
        level.var_e237f4df destroy();
    }
    if (isdefined(level.var_bc357a76)) {
        level.var_bc357a76 destroy();
    }
}

// Namespace util
// Params 1, eflags: 0x1 linked
// Checksum 0xb7d17f98, Offset: 0x2b88
// Size: 0x5c
function ghost_wait_show(wait_time) {
    if (!isdefined(wait_time)) {
        wait_time = 0.1;
    }
    self endon(#"death");
    self ghost();
    wait wait_time;
    self show();
}

// Namespace util
// Params 3, eflags: 0x1 linked
// Checksum 0x22b04635, Offset: 0x2bf0
// Size: 0x114
function ghost_wait_show_to_player(player, wait_time, self_endon_string1) {
    if (!isdefined(wait_time)) {
        wait_time = 0.1;
    }
    if (!isdefined(self)) {
        return;
    }
    self endon(#"death");
    self.abort_ghost_wait_show_to_player = undefined;
    if (isdefined(player)) {
        player endon(#"death");
        player endon(#"disconnect");
        player endon(#"joined_team");
        player endon(#"joined_spectators");
    }
    if (isdefined(self_endon_string1)) {
        self endon(self_endon_string1);
    }
    self ghost();
    self setinvisibletoall();
    self setvisibletoplayer(player);
    wait wait_time;
    if (!isdefined(self.abort_ghost_wait_show_to_player)) {
        self showtoplayer(player);
    }
}

// Namespace util
// Params 3, eflags: 0x1 linked
// Checksum 0x6b8cb56c, Offset: 0x2d10
// Size: 0x10c
function ghost_wait_show_to_others(player, wait_time, self_endon_string1) {
    if (!isdefined(wait_time)) {
        wait_time = 0.1;
    }
    if (!isdefined(self)) {
        return;
    }
    self endon(#"death");
    self.abort_ghost_wait_show_to_others = undefined;
    if (isdefined(player)) {
        player endon(#"death");
        player endon(#"disconnect");
        player endon(#"joined_team");
        player endon(#"joined_spectators");
    }
    if (isdefined(self_endon_string1)) {
        self endon(self_endon_string1);
    }
    self ghost();
    self setinvisibletoplayer(player);
    wait wait_time;
    if (!isdefined(self.abort_ghost_wait_show_to_others)) {
        self show();
        self setinvisibletoplayer(player);
    }
}

// Namespace util
// Params 0, eflags: 0x1 linked
// Checksum 0xe88b82c6, Offset: 0x2e28
// Size: 0x4a
function use_button_pressed() {
    assert(isplayer(self), "<dev string:xb6>");
    return self usebuttonpressed();
}

// Namespace util
// Params 0, eflags: 0x0
// Checksum 0xf3e2e015, Offset: 0x2e80
// Size: 0x2c
function waittill_use_button_pressed() {
    while (!self use_button_pressed()) {
        wait 0.05;
    }
}

// Namespace util
// Params 4, eflags: 0x0
// Checksum 0x48caf6c2, Offset: 0x2eb8
// Size: 0x184
function show_hint_text(str_text_to_show, b_should_blink, str_turn_off_notify, n_display_time) {
    if (!isdefined(b_should_blink)) {
        b_should_blink = 0;
    }
    if (!isdefined(str_turn_off_notify)) {
        str_turn_off_notify = "notify_turn_off_hint_text";
    }
    if (!isdefined(n_display_time)) {
        n_display_time = 4;
    }
    self endon(#"notify_turn_off_hint_text");
    self endon(#"hint_text_removed");
    if (isdefined(self.hint_menu_handle)) {
        hide_hint_text(0);
    }
    self.hint_menu_handle = self openluimenu("MPHintText");
    self setluimenudata(self.hint_menu_handle, "hint_text_line", str_text_to_show);
    if (b_should_blink) {
        lui::play_animation(self.hint_menu_handle, "blinking");
    } else {
        lui::play_animation(self.hint_menu_handle, "display_noblink");
    }
    if (n_display_time != -1) {
        self thread hide_hint_text_listener(n_display_time);
        self thread fade_hint_text_after_time(n_display_time, str_turn_off_notify);
    }
}

// Namespace util
// Params 1, eflags: 0x1 linked
// Checksum 0x1ee1c43, Offset: 0x3048
// Size: 0xca
function hide_hint_text(b_fade_before_hiding) {
    if (!isdefined(b_fade_before_hiding)) {
        b_fade_before_hiding = 1;
    }
    self endon(#"hint_text_removed");
    if (isdefined(self.hint_menu_handle)) {
        if (b_fade_before_hiding) {
            lui::play_animation(self.hint_menu_handle, "fadeout");
            waittill_any_timeout(0.75, "kill_hint_text", "death", "hint_text_removed");
        }
        self closeluimenu(self.hint_menu_handle);
        self.hint_menu_handle = undefined;
    }
    self notify(#"hint_text_removed");
}

// Namespace util
// Params 2, eflags: 0x1 linked
// Checksum 0xf66ae44b, Offset: 0x3120
// Size: 0x84
function fade_hint_text_after_time(n_display_time, str_turn_off_notify) {
    self endon(#"hint_text_removed");
    self endon(#"death");
    self endon(#"kill_hint_text");
    waittill_any_timeout(n_display_time - 0.75, str_turn_off_notify, "hint_text_removed", "kill_hint_text");
    hide_hint_text(1);
}

// Namespace util
// Params 1, eflags: 0x1 linked
// Checksum 0xce5fc1a5, Offset: 0x31b0
// Size: 0x6c
function hide_hint_text_listener(n_time) {
    self endon(#"hint_text_removed");
    self endon(#"disconnect");
    waittill_any_timeout(n_time, "kill_hint_text", "death", "hint_text_removed", "disconnect");
    hide_hint_text(0);
}

// Namespace util
// Params 2, eflags: 0x1 linked
// Checksum 0xb4aa6d2, Offset: 0x3228
// Size: 0x74
function set_team_radar(team, value) {
    if (team == "allies") {
        setmatchflag("radar_allies", value);
        return;
    }
    if (team == "axis") {
        setmatchflag("radar_axis", value);
    }
}

// Namespace util
// Params 0, eflags: 0x1 linked
// Checksum 0xd19124a1, Offset: 0x32a8
// Size: 0x1c
function init_player_contract_events() {
    if (!isdefined(level.player_contract_events)) {
        level.player_contract_events = [];
    }
}

// Namespace util
// Params 3, eflags: 0x1 linked
// Checksum 0xa0107447, Offset: 0x32d0
// Size: 0x10a
function register_player_contract_event(event_name, event_func, max_param_count) {
    if (!isdefined(max_param_count)) {
        max_param_count = 0;
    }
    if (!isdefined(level.player_contract_events[event_name])) {
        level.player_contract_events[event_name] = spawnstruct();
        level.player_contract_events[event_name].param_count = max_param_count;
        level.player_contract_events[event_name].events = [];
    }
    assert(max_param_count == level.player_contract_events[event_name].param_count);
    level.player_contract_events[event_name].events[level.player_contract_events[event_name].events.size] = event_func;
}

// Namespace util
// Params 4, eflags: 0x1 linked
// Checksum 0x8a82accc, Offset: 0x33e8
// Size: 0x362
function player_contract_event(event_name, param1, param2, param3) {
    if (!isdefined(param1)) {
        param1 = undefined;
    }
    if (!isdefined(param2)) {
        param2 = undefined;
    }
    if (!isdefined(param3)) {
        param3 = undefined;
    }
    if (!isdefined(level.player_contract_events[event_name])) {
        return;
    }
    param_count = isdefined(level.player_contract_events[event_name].param_count) ? level.player_contract_events[event_name].param_count : 0;
    switch (param_count) {
    case 0:
    default:
        foreach (event_func in level.player_contract_events[event_name].events) {
            if (isdefined(event_func)) {
                self [[ event_func ]]();
            }
        }
        break;
    case 1:
        foreach (event_func in level.player_contract_events[event_name].events) {
            if (isdefined(event_func)) {
                self [[ event_func ]](param1);
            }
        }
        break;
    case 2:
        foreach (event_func in level.player_contract_events[event_name].events) {
            if (isdefined(event_func)) {
                self [[ event_func ]](param1, param2);
            }
        }
        break;
    case 3:
        foreach (event_func in level.player_contract_events[event_name].events) {
            if (isdefined(event_func)) {
                self [[ event_func ]](param1, param2, param3);
            }
        }
        break;
    }
}

/#

    // Namespace util
    // Params 0, eflags: 0x1 linked
    // Checksum 0x1fc153e4, Offset: 0x3758
    // Size: 0x54
    function debug_slow_heli_speed() {
        if (getdvarint("<dev string:xe2>", 0) > 0) {
            self setspeed(getdvarint("<dev string:xe2>"));
        }
    }

#/

// Namespace util
// Params 1, eflags: 0x1 linked
// Checksum 0xfa6ec968, Offset: 0x37b8
// Size: 0x52
function is_objective_game(game_type) {
    switch (game_type) {
    case "conf":
    case "dm":
    case "gun":
    case "tdm":
        return 0;
    default:
        return 1;
    }
}

// Namespace util
// Params 0, eflags: 0x1 linked
// Checksum 0x5ff6c939, Offset: 0x3818
// Size: 0x16
function isprophuntgametype() {
    return isdefined(level.isprophunt) && level.isprophunt;
}

// Namespace util
// Params 0, eflags: 0x1 linked
// Checksum 0x81b73453, Offset: 0x3838
// Size: 0x38
function isprop() {
    return isdefined(self.pers["team"]) && self.pers["team"] == game["defenders"];
}

// Namespace util
// Params 1, eflags: 0x0
// Checksum 0x20ff2eb6, Offset: 0x3878
// Size: 0x44
function function_a7d853be(amount) {
    if (getdvarint("ui_enablePromoTracking", 0)) {
        function_a4c90358("cwl_thermometer", amount);
    }
}

// Namespace util
// Params 0, eflags: 0x1 linked
// Checksum 0x4114dcd5, Offset: 0x38c8
// Size: 0x16
function isinfectedgametype() {
    return isdefined(level.var_f817b02b) && level.var_f817b02b;
}

