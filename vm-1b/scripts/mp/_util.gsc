#using scripts/shared/array_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/lui_shared;
#using scripts/shared/math_shared;
#using scripts/shared/sound_shared;
#using scripts/shared/util_shared;

#namespace util;

/#

    // Namespace util
    // Params 1, eflags: 0x0
    // Checksum 0x62e3e9d0, Offset: 0x340
    // Size: 0x6a
    function error(msg) {
        println("<dev string:x28>", msg);
        wait 0.05;
        if (getdvarstring("<dev string:x33>") != "<dev string:x39>") {
            assertmsg("<dev string:x3b>");
        }
    }

    // Namespace util
    // Params 1, eflags: 0x0
    // Checksum 0xb8a380ed, Offset: 0x3b8
    // Size: 0x2a
    function warning(msg) {
        println("<dev string:x68>" + msg);
    }

#/

// Namespace util
// Params 4, eflags: 0x0
// Checksum 0x1f12ef10, Offset: 0x3f0
// Size: 0x81
function within_fov(start_origin, start_angles, end_origin, fov) {
    normal = vectornormalize(end_origin - start_origin);
    forward = anglestoforward(start_angles);
    dot = vectordot(forward, normal);
    return dot >= fov;
}

// Namespace util
// Params 0, eflags: 0x0
// Checksum 0x1b99b418, Offset: 0x480
// Size: 0x9
function get_player_height() {
    return 70;
}

// Namespace util
// Params 1, eflags: 0x0
// Checksum 0x94fbb64f, Offset: 0x498
// Size: 0x2e
function isbulletimpactmod(smeansofdeath) {
    return issubstr(smeansofdeath, "BULLET") || smeansofdeath == "MOD_HEAD_SHOT";
}

// Namespace util
// Params 0, eflags: 0x0
// Checksum 0x13a14831, Offset: 0x4d0
// Size: 0x31
function waitrespawnbutton() {
    self endon(#"disconnect");
    self endon(#"end_respawn");
    while (self usebuttonpressed() != 1) {
        wait 0.05;
    }
}

// Namespace util
// Params 3, eflags: 0x0
// Checksum 0xa2f81ea4, Offset: 0x510
// Size: 0x1b2
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
// Checksum 0x7b3443fd, Offset: 0x6d0
// Size: 0x1c2
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
// Params 1, eflags: 0x0
// Checksum 0xe3401cb8, Offset: 0x8a0
// Size: 0xc2
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
// Checksum 0x45273146, Offset: 0x970
// Size: 0xa1
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
// Checksum 0x63450134, Offset: 0xa20
// Size: 0xa1
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
// Checksum 0x849fc81b, Offset: 0xad0
// Size: 0xa9
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
// Checksum 0x632372ee, Offset: 0xb88
// Size: 0x1a
function printonteamarg(text, team, arg) {
    
}

// Namespace util
// Params 2, eflags: 0x0
// Checksum 0xfcb352fb, Offset: 0xbb0
// Size: 0xa9
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
// Params 7, eflags: 0x0
// Checksum 0x4c8a6262, Offset: 0xc68
// Size: 0x399
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
// Checksum 0xcf528ef2, Offset: 0x1010
// Size: 0x3a
function _playlocalsound(soundalias) {
    if (level.splitscreen && !self ishost()) {
        return;
    }
    self playlocalsound(soundalias);
}

// Namespace util
// Params 1, eflags: 0x0
// Checksum 0xabbe6617, Offset: 0x1058
// Size: 0x62
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
// Params 1, eflags: 0x0
// Checksum 0x4f771fb6, Offset: 0x10c8
// Size: 0x52
function getteammask(team) {
    if (!level.teambased || !isdefined(team) || !isdefined(level.spawnsystem.ispawn_teammask[team])) {
        return level.spawnsystem.ispawn_teammask_free;
    }
    return level.spawnsystem.ispawn_teammask[team];
}

// Namespace util
// Params 1, eflags: 0x0
// Checksum 0x2bf2f15e, Offset: 0x1128
// Size: 0x87
function getotherteamsmask(skip_team) {
    mask = 0;
    foreach (team in level.teams) {
        if (team == skip_team) {
            continue;
        }
        InvalidOpCode(0xb9, getteammask(team), mask);
        // Unknown operator (0xb9, t7_1b, PC)
    }
    return mask;
}

// Namespace util
// Params 5, eflags: 0x0
// Checksum 0x4af15ca, Offset: 0x11b8
// Size: 0x52
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
    // Params 5, eflags: 0x0
    // Checksum 0x7702231, Offset: 0x1218
    // Size: 0xb9
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
// Checksum 0xc5367a0a, Offset: 0x12e0
// Size: 0x3a
function getfx(fx) {
    assert(isdefined(level._effect[fx]), "<dev string:x90>" + fx + "<dev string:x94>");
    return level._effect[fx];
}

// Namespace util
// Params 3, eflags: 0x0
// Checksum 0x52f3a887, Offset: 0x1328
// Size: 0x71
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
// Checksum 0x363fa4f8, Offset: 0x13a8
// Size: 0x69
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
// Params 3, eflags: 0x0
// Checksum 0xc8a10764, Offset: 0x1420
// Size: 0x79
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
// Params 1, eflags: 0x0
// Checksum 0xbe0c8478, Offset: 0x14a8
// Size: 0x43
function add_trigger_to_ent(ent) {
    if (!isdefined(ent._triggers)) {
        ent._triggers = [];
    }
    ent._triggers[self getentitynumber()] = 1;
}

// Namespace util
// Params 1, eflags: 0x0
// Checksum 0x84566f42, Offset: 0x14f8
// Size: 0x5b
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
// Params 1, eflags: 0x0
// Checksum 0x9abeb791, Offset: 0x1560
// Size: 0x59
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
// Params 2, eflags: 0x0
// Checksum 0x69e2eea0, Offset: 0x15c8
// Size: 0x32
function trigger_thread_death_monitor(ent, ender) {
    ent waittill(#"death");
    self endon(ender);
    self remove_trigger_from_ent(ent);
}

// Namespace util
// Params 3, eflags: 0x0
// Checksum 0x7c6a7b99, Offset: 0x1608
// Size: 0x13f
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
// Checksum 0x982a3967, Offset: 0x1750
// Size: 0x2c
function isstrstart(string1, substr) {
    return getsubstr(string1, 0, substr.size) == substr;
}

// Namespace util
// Params 0, eflags: 0x0
// Checksum 0x5cb8aea8, Offset: 0x1788
// Size: 0x15
function iskillstreaksenabled() {
    return isdefined(level.killstreaksenabled) && level.killstreaksenabled;
}

// Namespace util
// Params 2, eflags: 0x0
// Checksum 0x7df1a001, Offset: 0x17a8
// Size: 0xab
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
// Params 2, eflags: 0x0
// Checksum 0x9cbe4f0e, Offset: 0x1860
// Size: 0x21
function setobjectivetext(team, text) {
    InvalidOpCode(0xc8, "strings", "objective_" + team, text);
    // Unknown operator (0xc8, t7_1b, PC)
}

// Namespace util
// Params 2, eflags: 0x0
// Checksum 0x7e784277, Offset: 0x1890
// Size: 0x21
function setobjectivescoretext(team, text) {
    InvalidOpCode(0xc8, "strings", "objective_score_" + team, text);
    // Unknown operator (0xc8, t7_1b, PC)
}

// Namespace util
// Params 2, eflags: 0x0
// Checksum 0x9b746b7c, Offset: 0x18c0
// Size: 0x21
function setobjectivehinttext(team, text) {
    InvalidOpCode(0xc8, "strings", "objective_hint_" + team, text);
    // Unknown operator (0xc8, t7_1b, PC)
}

// Namespace util
// Params 1, eflags: 0x0
// Checksum 0xd745594b, Offset: 0x18f0
// Size: 0x19
function getobjectivetext(team) {
    InvalidOpCode(0x54, "strings", "objective_" + team);
    // Unknown operator (0x54, t7_1b, PC)
}

// Namespace util
// Params 1, eflags: 0x0
// Checksum 0xfa5f31f0, Offset: 0x1918
// Size: 0x19
function getobjectivescoretext(team) {
    InvalidOpCode(0x54, "strings", "objective_score_" + team);
    // Unknown operator (0x54, t7_1b, PC)
}

// Namespace util
// Params 1, eflags: 0x0
// Checksum 0x5de32618, Offset: 0x1940
// Size: 0x19
function getobjectivehinttext(team) {
    InvalidOpCode(0x54, "strings", "objective_hint_" + team);
    // Unknown operator (0x54, t7_1b, PC)
}

// Namespace util
// Params 2, eflags: 0x0
// Checksum 0x642e6cea, Offset: 0x1968
// Size: 0x52
function registerroundswitch(minvalue, maxvalue) {
    level.roundswitch = math::clamp(getgametypesetting("roundSwitch"), minvalue, maxvalue);
    level.roundswitchmin = minvalue;
    level.roundswitchmax = maxvalue;
}

// Namespace util
// Params 2, eflags: 0x0
// Checksum 0xbfae6eca, Offset: 0x19c8
// Size: 0x52
function registerroundlimit(minvalue, maxvalue) {
    level.roundlimit = math::clamp(getgametypesetting("roundLimit"), minvalue, maxvalue);
    level.roundlimitmin = minvalue;
    level.roundlimitmax = maxvalue;
}

// Namespace util
// Params 2, eflags: 0x0
// Checksum 0x6937adb3, Offset: 0x1a28
// Size: 0x52
function registerroundwinlimit(minvalue, maxvalue) {
    level.roundwinlimit = math::clamp(getgametypesetting("roundWinLimit"), minvalue, maxvalue);
    level.roundwinlimitmin = minvalue;
    level.roundwinlimitmax = maxvalue;
}

// Namespace util
// Params 2, eflags: 0x0
// Checksum 0x8a8bd420, Offset: 0x1a88
// Size: 0x72
function registerscorelimit(minvalue, maxvalue) {
    level.scorelimit = math::clamp(getgametypesetting("scoreLimit"), minvalue, maxvalue);
    level.scorelimitmin = minvalue;
    level.scorelimitmax = maxvalue;
    setdvar("ui_scorelimit", level.scorelimit);
}

// Namespace util
// Params 2, eflags: 0x0
// Checksum 0xddb38d9e, Offset: 0x1b08
// Size: 0x52
function registerroundscorelimit(minvalue, maxvalue) {
    level.roundscorelimit = math::clamp(getgametypesetting("roundScoreLimit"), minvalue, maxvalue);
    level.roundscorelimitmin = minvalue;
    level.roundscorelimitmax = maxvalue;
}

// Namespace util
// Params 2, eflags: 0x0
// Checksum 0x8e5ff594, Offset: 0x1b68
// Size: 0x72
function registertimelimit(minvalue, maxvalue) {
    level.timelimit = math::clamp(getgametypesetting("timeLimit"), minvalue, maxvalue);
    level.timelimitmin = minvalue;
    level.timelimitmax = maxvalue;
    setdvar("ui_timelimit", level.timelimit);
}

// Namespace util
// Params 2, eflags: 0x0
// Checksum 0x3bc4a8a, Offset: 0x1be8
// Size: 0x92
function registernumlives(minvalue, maxvalue) {
    level.numlives = math::clamp(getgametypesetting("playerNumLives"), minvalue, maxvalue);
    level.numlivesmin = minvalue;
    level.numlivesmax = maxvalue;
    level.numteamlives = math::clamp(getgametypesetting("teamNumLives"), minvalue, maxvalue);
    level.numteamlivesmin = minvalue;
    level.numteamlivesmax = maxvalue;
}

// Namespace util
// Params 1, eflags: 0x0
// Checksum 0x9c3f31e1, Offset: 0x1c88
// Size: 0x62
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
// Checksum 0xed098f99, Offset: 0x1cf8
// Size: 0x3d
function ispressbuild() {
    buildtype = getdvarstring("buildType");
    if (isdefined(buildtype) && buildtype == "press") {
        return true;
    }
    return false;
}

// Namespace util
// Params 0, eflags: 0x0
// Checksum 0x6c4783b2, Offset: 0x1d40
// Size: 0x16
function isflashbanged() {
    return isdefined(self.flashendtime) && gettime() < self.flashendtime;
}

// Namespace util
// Params 5, eflags: 0x0
// Checksum 0x20fe8471, Offset: 0x1d60
// Size: 0x9a
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
// Checksum 0x66439f96, Offset: 0x1e08
// Size: 0x1a
function self_delete() {
    if (isdefined(self)) {
        self delete();
    }
}

// Namespace util
// Params 5, eflags: 0x0
// Checksum 0x59d11a32, Offset: 0x1e30
// Size: 0x4a2
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
// Params 1, eflags: 0x0
// Checksum 0x3ef6f673, Offset: 0x22e0
// Size: 0x72
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
// Params 1, eflags: 0x0
// Checksum 0xd6cc0c2c, Offset: 0x2360
// Size: 0x42
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
// Params 3, eflags: 0x0
// Checksum 0x475eb66b, Offset: 0x23b0
// Size: 0xc2
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
// Params 3, eflags: 0x0
// Checksum 0xc1ce999e, Offset: 0x2480
// Size: 0xc2
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
// Params 0, eflags: 0x0
// Checksum 0x8c5a2b86, Offset: 0x2550
// Size: 0x39
function use_button_pressed() {
    assert(isplayer(self), "<dev string:xb6>");
    return self usebuttonpressed();
}

// Namespace util
// Params 0, eflags: 0x0
// Checksum 0xaf1e5083, Offset: 0x2598
// Size: 0x21
function waittill_use_button_pressed() {
    while (!self use_button_pressed()) {
        wait 0.05;
    }
}

// Namespace util
// Params 4, eflags: 0x0
// Checksum 0x59d5c13e, Offset: 0x25c8
// Size: 0x122
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
// Params 1, eflags: 0x0
// Checksum 0x97a56d31, Offset: 0x26f8
// Size: 0x9b
function hide_hint_text(b_fade_before_hiding) {
    if (!isdefined(b_fade_before_hiding)) {
        b_fade_before_hiding = 1;
    }
    self endon(#"hint_text_removed");
    if (isdefined(self.hint_menu_handle)) {
        if (b_fade_before_hiding) {
            lui::play_animation(self.hint_menu_handle, "fadeout");
            waittill_any_timeout(0.75, "kill_hint_text", "death");
        }
        self closeluimenu(self.hint_menu_handle);
        self.hint_menu_handle = undefined;
    }
    self notify(#"hint_text_removed");
}

// Namespace util
// Params 2, eflags: 0x0
// Checksum 0x220635d2, Offset: 0x27a0
// Size: 0x52
function fade_hint_text_after_time(n_display_time, str_turn_off_notify) {
    self endon(#"hint_text_removed");
    self endon(#"death");
    self endon(#"kill_hint_text");
    waittill_any_timeout(n_display_time - 0.75, str_turn_off_notify);
    hide_hint_text(1);
}

// Namespace util
// Params 1, eflags: 0x0
// Checksum 0x319854f, Offset: 0x2800
// Size: 0x4a
function hide_hint_text_listener(n_time) {
    self endon(#"hint_text_removed");
    self endon(#"disconnect");
    waittill_any_timeout(n_time, "kill_hint_text", "death");
    hide_hint_text(0);
}

