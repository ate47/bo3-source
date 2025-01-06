#using scripts/cp/_oed;
#using scripts/cp/_skipto;
#using scripts/cp/cybercom/_cybercom_util;
#using scripts/cp/gametypes/coop;
#using scripts/shared/ai_shared;
#using scripts/shared/array_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/flagsys_shared;
#using scripts/shared/gameobjects_shared;
#using scripts/shared/load_shared;
#using scripts/shared/lui_shared;
#using scripts/shared/math_shared;
#using scripts/shared/sound_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/string_shared;
#using scripts/shared/util_shared;

#namespace util;

// Namespace util
// Params 1, eflags: 0x0
// Checksum 0xdf2c10b4, Offset: 0x580
// Size: 0xc
function add_gametype(gt) {
    
}

/#

    // Namespace util
    // Params 1, eflags: 0x0
    // Checksum 0x4ba8d9b0, Offset: 0x598
    // Size: 0x74
    function error(msg) {
        println("<dev string:x28>", msg);
        wait 0.05;
        if (getdvarstring("<dev string:x33>") != "<dev string:x39>") {
            assertmsg("<dev string:x3b>");
        }
    }

    // Namespace util
    // Params 1, eflags: 0x0
    // Checksum 0x4fc3a6d6, Offset: 0x618
    // Size: 0x34
    function warning(msg) {
        println("<dev string:x68>" + msg);
    }

#/

// Namespace util
// Params 4, eflags: 0x0
// Checksum 0x5a5dd738, Offset: 0x658
// Size: 0xa2
function within_fov(start_origin, start_angles, end_origin, fov) {
    normal = vectornormalize(end_origin - start_origin);
    forward = anglestoforward(start_angles);
    dot = vectordot(forward, normal);
    return dot >= fov;
}

// Namespace util
// Params 0, eflags: 0x0
// Checksum 0xd017b532, Offset: 0x708
// Size: 0xa
function get_player_height() {
    return 70;
}

// Namespace util
// Params 1, eflags: 0x0
// Checksum 0xc661d7f, Offset: 0x720
// Size: 0x3c
function isbulletimpactmod(smeansofdeath) {
    return issubstr(smeansofdeath, "BULLET") || smeansofdeath == "MOD_HEAD_SHOT";
}

// Namespace util
// Params 0, eflags: 0x0
// Checksum 0xf9a05fb7, Offset: 0x768
// Size: 0x40
function waitrespawnbutton() {
    self endon(#"disconnect");
    self endon(#"end_respawn");
    while (self usebuttonpressed() != 1) {
        wait 0.05;
    }
}

// Namespace util
// Params 3, eflags: 0x0
// Checksum 0x8947017d, Offset: 0x7b0
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
// Checksum 0x8fd7c138, Offset: 0x9b8
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
// Params 1, eflags: 0x0
// Checksum 0x5394b20a, Offset: 0xbe8
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
// Checksum 0xc07fc4ce, Offset: 0xce8
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
// Checksum 0x2080cf4b, Offset: 0xdc8
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
// Checksum 0xc2375d9, Offset: 0xea8
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
// Checksum 0x8f3f64b8, Offset: 0xf90
// Size: 0x1c
function printonteamarg(text, team, arg) {
    
}

// Namespace util
// Params 2, eflags: 0x0
// Checksum 0x6dd915af, Offset: 0xfb8
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
// Params 7, eflags: 0x0
// Checksum 0xf4320b79, Offset: 0x10b0
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
// Checksum 0x44b504fa, Offset: 0x15d0
// Size: 0x4c
function _playlocalsound(soundalias) {
    if (level.splitscreen && !self ishost()) {
        return;
    }
    self playlocalsound(soundalias);
}

// Namespace util
// Params 1, eflags: 0x0
// Checksum 0xe92f89da, Offset: 0x1628
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
// Params 1, eflags: 0x0
// Checksum 0x5793426, Offset: 0x16a8
// Size: 0x64
function getteammask(team) {
    if (!level.teambased || !isdefined(team) || !isdefined(level.spawnsystem.ispawn_teammask[team])) {
        return level.spawnsystem.ispawn_teammask_free;
    }
    return level.spawnsystem.ispawn_teammask[team];
}

// Namespace util
// Params 1, eflags: 0x0
// Checksum 0x7e0a6428, Offset: 0x1718
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
// Params 5, eflags: 0x0
// Checksum 0x1be427e3, Offset: 0x17e8
// Size: 0x126
function plot_points(plotpoints, r, g, b, var_8bb7be29) {
    if (!isdefined(r)) {
        r = 1;
    }
    if (!isdefined(g)) {
        g = 1;
    }
    if (!isdefined(b)) {
        b = 1;
    }
    if (!isdefined(var_8bb7be29)) {
        var_8bb7be29 = 1;
    }
    /#
        lastpoint = plotpoints[0];
        var_8bb7be29 = int(var_8bb7be29);
        for (i = 1; i < plotpoints.size; i++) {
            line(lastpoint, plotpoints[i], (r, g, b), 1, var_8bb7be29);
            lastpoint = plotpoints[i];
        }
    #/
}

// Namespace util
// Params 1, eflags: 0x0
// Checksum 0x740149df, Offset: 0x1918
// Size: 0x50
function getfx(fx) {
    assert(isdefined(level._effect[fx]), "<dev string:x90>" + fx + "<dev string:x94>");
    return level._effect[fx];
}

// Namespace util
// Params 3, eflags: 0x0
// Checksum 0x69002ad8, Offset: 0x1970
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
// Checksum 0x469f7bda, Offset: 0x1a10
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
// Params 3, eflags: 0x0
// Checksum 0x5cc43a58, Offset: 0x1aa8
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
// Params 1, eflags: 0x0
// Checksum 0xd159a055, Offset: 0x1b58
// Size: 0x5a
function add_trigger_to_ent(ent) {
    if (!isdefined(ent._triggers)) {
        ent._triggers = [];
    }
    ent._triggers[self getentitynumber()] = 1;
}

// Namespace util
// Params 1, eflags: 0x0
// Checksum 0x3ab1df54, Offset: 0x1bc0
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
// Params 1, eflags: 0x0
// Checksum 0x20d53b0f, Offset: 0x1c48
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
// Params 2, eflags: 0x0
// Checksum 0x97f36f82, Offset: 0x1cc0
// Size: 0x44
function trigger_thread_death_monitor(ent, ender) {
    ent waittill(#"death");
    self endon(ender);
    self remove_trigger_from_ent(ent);
}

// Namespace util
// Params 3, eflags: 0x0
// Checksum 0x7358cbdd, Offset: 0x1d10
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
// Checksum 0x73f82edd, Offset: 0x1ec0
// Size: 0x38
function isstrstart(string1, substr) {
    return getsubstr(string1, 0, substr.size) == substr;
}

// Namespace util
// Params 0, eflags: 0x0
// Checksum 0xcb1c7a40, Offset: 0x1f00
// Size: 0x16
function iskillstreaksenabled() {
    return isdefined(level.killstreaksenabled) && level.killstreaksenabled;
}

// Namespace util
// Params 1, eflags: 0x0
// Checksum 0x41b8c145, Offset: 0x1f20
// Size: 0x82
function setusingremote(remotename) {
    if (isdefined(self.carryicon)) {
        self.carryicon.alpha = 0;
    }
    assert(!self isusingremote());
    self.usingremote = remotename;
    self disableoffhandweapons();
    self notify(#"using_remote");
}

// Namespace util
// Params 0, eflags: 0x0
// Checksum 0x3b09e591, Offset: 0x1fb0
// Size: 0x32
function getremotename() {
    assert(self isusingremote());
    return self.usingremote;
}

// Namespace util
// Params 2, eflags: 0x0
// Checksum 0x3eb3b383, Offset: 0x1ff0
// Size: 0x32
function setobjectivetext(team, text) {
    game["strings"]["objective_" + team] = text;
}

// Namespace util
// Params 2, eflags: 0x0
// Checksum 0x8af14cec, Offset: 0x2030
// Size: 0x32
function setobjectivescoretext(team, text) {
    game["strings"]["objective_score_" + team] = text;
}

// Namespace util
// Params 2, eflags: 0x0
// Checksum 0x721ec063, Offset: 0x2070
// Size: 0x32
function setobjectivehinttext(team, text) {
    game["strings"]["objective_hint_" + team] = text;
}

// Namespace util
// Params 1, eflags: 0x0
// Checksum 0xbe40cbd0, Offset: 0x20b0
// Size: 0x24
function getobjectivetext(team) {
    return game["strings"]["objective_" + team];
}

// Namespace util
// Params 1, eflags: 0x0
// Checksum 0x2bd94d9d, Offset: 0x20e0
// Size: 0x24
function getobjectivescoretext(team) {
    return game["strings"]["objective_score_" + team];
}

// Namespace util
// Params 1, eflags: 0x0
// Checksum 0x4e56ea, Offset: 0x2110
// Size: 0x24
function getobjectivehinttext(team) {
    return game["strings"]["objective_hint_" + team];
}

// Namespace util
// Params 2, eflags: 0x0
// Checksum 0x2fd99b1d, Offset: 0x2140
// Size: 0x64
function registerroundswitch(minvalue, maxvalue) {
    level.roundswitch = math::clamp(getgametypesetting("roundSwitch"), minvalue, maxvalue);
    level.roundswitchmin = minvalue;
    level.roundswitchmax = maxvalue;
}

// Namespace util
// Params 2, eflags: 0x0
// Checksum 0xfd035cb3, Offset: 0x21b0
// Size: 0x64
function registerroundlimit(minvalue, maxvalue) {
    level.roundlimit = math::clamp(getgametypesetting("roundLimit"), minvalue, maxvalue);
    level.roundlimitmin = minvalue;
    level.roundlimitmax = maxvalue;
}

// Namespace util
// Params 2, eflags: 0x0
// Checksum 0xb70797ad, Offset: 0x2220
// Size: 0x64
function registerroundwinlimit(minvalue, maxvalue) {
    level.roundwinlimit = math::clamp(getgametypesetting("roundWinLimit"), minvalue, maxvalue);
    level.roundwinlimitmin = minvalue;
    level.roundwinlimitmax = maxvalue;
}

// Namespace util
// Params 2, eflags: 0x0
// Checksum 0xc487f20, Offset: 0x2290
// Size: 0x84
function registerscorelimit(minvalue, maxvalue) {
    level.scorelimit = math::clamp(getgametypesetting("scoreLimit"), minvalue, maxvalue);
    level.scorelimitmin = minvalue;
    level.scorelimitmax = maxvalue;
    setdvar("ui_scorelimit", level.scorelimit);
}

// Namespace util
// Params 2, eflags: 0x0
// Checksum 0x67b07d14, Offset: 0x2320
// Size: 0x84
function registertimelimit(minvalue, maxvalue) {
    level.timelimit = math::clamp(getgametypesetting("timeLimit"), minvalue, maxvalue);
    level.timelimitmin = minvalue;
    level.timelimitmax = maxvalue;
    setdvar("ui_timelimit", level.timelimit);
}

// Namespace util
// Params 2, eflags: 0x0
// Checksum 0x70e37891, Offset: 0x23b0
// Size: 0x64
function registernumlives(minvalue, maxvalue) {
    level.numlives = math::clamp(getgametypesetting("playerNumLives"), minvalue, maxvalue);
    level.numlivesmin = minvalue;
    level.numlivesmax = maxvalue;
}

// Namespace util
// Params 1, eflags: 0x0
// Checksum 0x8f0ffc76, Offset: 0x2420
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
// Checksum 0xecfc0627, Offset: 0x24a8
// Size: 0x4c
function ispressbuild() {
    buildtype = getdvarstring("buildType");
    if (isdefined(buildtype) && buildtype == "press") {
        return true;
    }
    return false;
}

// Namespace util
// Params 0, eflags: 0x0
// Checksum 0xfd5bc1a0, Offset: 0x2500
// Size: 0x1c
function isflashbanged() {
    return isdefined(self.flashendtime) && gettime() < self.flashendtime;
}

// Namespace util
// Params 0, eflags: 0x0
// Checksum 0x3460cf7e, Offset: 0x2528
// Size: 0xac
function function_d9c13489() {
    time = gettime();
    if (isdefined(self.stunned) && self.stunned) {
        return true;
    }
    if (self isflashbanged()) {
        return true;
    }
    if (isdefined(self.stun_fx)) {
        return true;
    }
    if (isdefined(self.laststunnedtime) && self.laststunnedtime + 5000 > time) {
        return true;
    }
    if (isdefined(self.concussionendtime) && self.concussionendtime > time) {
        return true;
    }
    return false;
}

// Namespace util
// Params 5, eflags: 0x0
// Checksum 0x5f65e78a, Offset: 0x25e0
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
// Checksum 0x9ee18fbf, Offset: 0x26a8
// Size: 0x24
function self_delete() {
    if (isdefined(self)) {
        self delete();
    }
}

// Namespace util
// Params 5, eflags: 0x0
// Checksum 0x4f7a454c, Offset: 0x26d8
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
// Params 1, eflags: 0x0
// Checksum 0x2397ab4d, Offset: 0x2c10
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
// Params 5, eflags: 0x0
// Checksum 0xce784fe7, Offset: 0x2cb0
// Size: 0x54c
function function_67cfce72(var_237ef712, var_fd7c7ca9, var_d77a0240, var_e462c321, n_time) {
    self notify(#"hash_1ec499f0");
    self endon(#"hash_1ec499f0");
    self endon(#"death");
    if (isdefined(level.missionfailed) && level.missionfailed) {
        return;
    }
    if (getdvarint("hud_missionFailed") == 1) {
        return;
    }
    if (!isdefined(var_e462c321)) {
        var_e462c321 = 0;
    }
    if (!isdefined(self.var_703085a4)) {
        self.var_703085a4 = newclienthudelem(self);
        self.var_703085a4.elemtype = "font";
        self.var_703085a4.font = "objective";
        self.var_703085a4.fontscale = 1.8;
        self.var_703085a4.horzalign = "center";
        self.var_703085a4.vertalign = "middle";
        self.var_703085a4.alignx = "center";
        self.var_703085a4.aligny = "middle";
        self.var_703085a4.y = -60 + var_e462c321;
        self.var_703085a4.sort = 2;
        self.var_703085a4.color = (1, 1, 1);
        self.var_703085a4.alpha = 1;
        self.var_703085a4.hidewheninmenu = 1;
    }
    self.var_703085a4 settext(var_237ef712);
    if (isdefined(var_fd7c7ca9)) {
        if (!isdefined(self.var_e237f4df)) {
            self.var_e237f4df = newclienthudelem(self);
            self.var_e237f4df.elemtype = "font";
            self.var_e237f4df.font = "objective";
            self.var_e237f4df.fontscale = 1.8;
            self.var_e237f4df.horzalign = "center";
            self.var_e237f4df.vertalign = "middle";
            self.var_e237f4df.alignx = "center";
            self.var_e237f4df.aligny = "middle";
            self.var_e237f4df.y = -33 + var_e462c321;
            self.var_e237f4df.sort = 2;
            self.var_e237f4df.color = (1, 1, 1);
            self.var_e237f4df.alpha = 1;
            self.var_e237f4df.hidewheninmenu = 1;
        }
        self.var_e237f4df settext(var_fd7c7ca9);
    } else if (isdefined(self.var_e237f4df)) {
        self.var_e237f4df destroy();
    }
    if (isdefined(var_d77a0240)) {
        if (!isdefined(self.var_bc357a76)) {
            self.var_bc357a76 = newclienthudelem(self);
            self.var_bc357a76.elemtype = "font";
            self.var_bc357a76.font = "objective";
            self.var_bc357a76.fontscale = 1.8;
            self.var_bc357a76.horzalign = "center";
            self.var_bc357a76.vertalign = "middle";
            self.var_bc357a76.alignx = "center";
            self.var_bc357a76.aligny = "middle";
            self.var_bc357a76.y = -6 + var_e462c321;
            self.var_bc357a76.sort = 2;
            self.var_bc357a76.color = (1, 1, 1);
            self.var_bc357a76.alpha = 1;
            self.var_bc357a76.hidewheninmenu = 1;
        }
        self.var_bc357a76 settext(var_d77a0240);
    } else if (isdefined(self.var_bc357a76)) {
        self.var_bc357a76 destroy();
    }
    if (isdefined(n_time) && n_time > 0) {
        wait n_time;
        self function_79f9f98d();
    }
}

// Namespace util
// Params 1, eflags: 0x0
// Checksum 0x2fa20bad, Offset: 0x3208
// Size: 0x9c
function function_79f9f98d(delay) {
    self endon(#"death");
    if (isdefined(delay)) {
        wait delay;
    }
    if (isdefined(self.var_703085a4)) {
        self.var_703085a4 destroy();
    }
    if (isdefined(self.var_e237f4df)) {
        self.var_e237f4df destroy();
    }
    if (isdefined(self.var_bc357a76)) {
        self.var_bc357a76 destroy();
    }
}

// Namespace util
// Params 3, eflags: 0x0
// Checksum 0xedf6a533, Offset: 0x32b0
// Size: 0x3c
function screen_fade_out(n_time, var_5cbd0572, str_menu_id) {
    level lui::screen_fade_out(n_time, var_5cbd0572, str_menu_id);
}

// Namespace util
// Params 3, eflags: 0x0
// Checksum 0x5ee4ee3b, Offset: 0x32f8
// Size: 0x3c
function screen_fade_in(n_time, var_5cbd0572, str_menu_id) {
    level lui::screen_fade_in(n_time, var_5cbd0572, str_menu_id);
}

// Namespace util
// Params 4, eflags: 0x0
// Checksum 0x9edb253f, Offset: 0x3340
// Size: 0x122
function function_e9a12fda(n_alpha, var_caadaee2, var_8b2e7ac7, var_5cbd0572) {
    assert(isdefined(n_alpha), "<dev string:xb6>");
    assert(isplayer(self), "<dev string:xf6>");
    level notify(#"_screen_fade");
    level endon(#"_screen_fade");
    var_bb3d430d = function_ef27182e(var_5cbd0572);
    var_bb3d430d fadeovertime(var_caadaee2);
    var_bb3d430d.alpha = n_alpha;
    if (isdefined(var_8b2e7ac7) && var_8b2e7ac7 >= 0) {
        self setblur(var_8b2e7ac7, var_caadaee2);
    }
    wait var_caadaee2;
}

// Namespace util
// Params 3, eflags: 0x0
// Checksum 0xf4c007b7, Offset: 0x3470
// Size: 0x3c
function function_c04ace5b(n_alpha, var_caadaee2, var_5cbd0572) {
    function_e9a12fda(n_alpha, var_caadaee2, 0, var_5cbd0572);
}

// Namespace util
// Params 1, eflags: 0x0
// Checksum 0x5a34ba90, Offset: 0x34b8
// Size: 0xfa
function function_ef27182e(var_5cbd0572) {
    if (!isdefined(var_5cbd0572)) {
        var_5cbd0572 = "black";
    }
    if (!isdefined(level.var_29832d35)) {
        level.var_29832d35 = newhudelem();
        level.var_29832d35.x = 0;
        level.var_29832d35.y = 0;
        level.var_29832d35.horzalign = "fullscreen";
        level.var_29832d35.vertalign = "fullscreen";
        level.var_29832d35.sort = 0;
        level.var_29832d35.alpha = 0;
    }
    level.var_29832d35 setshader(var_5cbd0572, 640, 480);
    return level.var_29832d35;
}

// Namespace util
// Params 9, eflags: 0x0
// Checksum 0x4a67e5cf, Offset: 0x35c0
// Size: 0x154
function missionfailedwrapper(var_49d9e5c0, var_d4d61a6f, shader, iwidth, var_40c0cdd3, fdelay, x, y, var_c75a07f7) {
    if (!isdefined(var_c75a07f7)) {
        var_c75a07f7 = 1;
    }
    if (level.missionfailed) {
        return;
    }
    if (isdefined(level.nextmission)) {
        return;
    }
    if (getdvarstring("failure_disabled") == "1") {
        return;
    }
    function_77f8007d();
    if (isdefined(var_d4d61a6f)) {
        setdvar("ui_deadquote", var_d4d61a6f);
    }
    if (isdefined(shader)) {
        getplayers()[0] thread load::function_e152ebb3(shader, iwidth, var_40c0cdd3, fdelay, x, y);
    }
    level.missionfailed = 1;
    if (var_c75a07f7) {
    }
    level thread coop::function_5ed5738a(var_49d9e5c0, var_d4d61a6f);
}

// Namespace util
// Params 8, eflags: 0x0
// Checksum 0x5f9ced22, Offset: 0x3720
// Size: 0x7c
function function_207f8667(var_49d9e5c0, var_d4d61a6f, shader, iwidth, var_40c0cdd3, fdelay, x, y) {
    missionfailedwrapper(var_49d9e5c0, var_d4d61a6f, shader, iwidth, var_40c0cdd3, fdelay, x, y, 0);
}

// Namespace util
// Params 3, eflags: 0x0
// Checksum 0x1ae7f975, Offset: 0x37a8
// Size: 0x13e
function function_d0bd0641(message, delay, var_7ad0895e) {
    level notify(#"hash_4e2d8dd4");
    level endon(#"hash_4e2d8dd4");
    function_2ffd5725();
    level.var_d0bd0641 = message;
    function_1ec499f0(message);
    if (!isdefined(delay)) {
        delay = 5;
    }
    start_time = gettime();
    while (true) {
        time = gettime();
        dt = (time - start_time) / 1000;
        if (dt >= delay) {
            break;
        }
        if (isdefined(var_7ad0895e) && level flag::get(var_7ad0895e) == 1) {
            break;
        }
        wait 0.01;
    }
    if (isdefined(level.var_d0bd0641)) {
        function_77f8007d();
    }
    level.var_d0bd0641 = undefined;
}

// Namespace util
// Params 0, eflags: 0x0
// Checksum 0x8dda742b, Offset: 0x38f0
// Size: 0x2e
function function_2ffd5725() {
    if (isdefined(level.var_d0bd0641)) {
        function_77f8007d();
    }
    level.var_d0bd0641 = undefined;
}

// Namespace util
// Params 0, eflags: 0x0
// Checksum 0xbb3ae274, Offset: 0x3928
// Size: 0x88
function show_hit_marker() {
    if (isdefined(self) && isdefined(self.hud_damagefeedback)) {
        self.hud_damagefeedback setshader("damage_feedback", 24, 48);
        self.hud_damagefeedback.alpha = 1;
        self.hud_damagefeedback fadeovertime(1);
        self.hud_damagefeedback.alpha = 0;
    }
}

// Namespace util
// Params 8, eflags: 0x0
// Checksum 0x87cdf04c, Offset: 0x39b8
// Size: 0x2f8
function function_66773296(name, func_init, arg1, arg2, arg3, arg4, arg5, var_58061bcf) {
    if (!isdefined(var_58061bcf)) {
        var_58061bcf = 1;
    }
    if (!isdefined(level.heroes)) {
        level.heroes = [];
    }
    name = tolower(name);
    ai_hero = getent(name + "_ai", "targetname", 1);
    if (!isalive(ai_hero)) {
        ai_hero = getent(name, "targetname", 1);
        if (!isalive(ai_hero)) {
            spawner = getent(name, "targetname");
            if (!(isdefined(spawner.spawning) && spawner.spawning)) {
                spawner.count++;
                ai_hero = spawner::simple_spawn_single(spawner);
                assert(isdefined(ai_hero), "<dev string:x134>" + name + "<dev string:x14b>");
                spawner notify(#"hero_spawned", ai_hero);
            } else {
                spawner waittill(#"hero_spawned", ai_hero);
            }
        }
    }
    level.heroes[name] = ai_hero;
    ai_hero.animname = name;
    ai_hero.is_hero = 1;
    ai_hero.enableterrainik = 1;
    ai_hero settmodeprovider(1);
    ai_hero magic_bullet_shield();
    ai_hero thread function_9d597adf(name);
    if (isdefined(func_init)) {
        single_thread(ai_hero, func_init, arg1, arg2, arg3, arg4, arg5);
    }
    if (isdefined(level.var_9b4e3779)) {
        ai_hero [[ level.var_9b4e3779 ]]();
    }
    if (var_58061bcf) {
        ai_hero thread oed::enable_thermal();
    }
    return ai_hero;
}

// Namespace util
// Params 7, eflags: 0x0
// Checksum 0x47b4bc7d, Offset: 0x3cb8
// Size: 0x142
function function_e29f0dd6(var_673caed4, func, arg1, arg2, arg3, arg4, arg5) {
    a_heroes = [];
    foreach (str_hero in var_673caed4) {
        if (!isdefined(a_heroes)) {
            a_heroes = [];
        } else if (!isarray(a_heroes)) {
            a_heroes = array(a_heroes);
        }
        a_heroes[a_heroes.size] = function_66773296(str_hero, func, arg1, arg2, arg3, arg4, arg5);
    }
    return a_heroes;
}

// Namespace util
// Params 1, eflags: 0x0
// Checksum 0x53a669f, Offset: 0x3e08
// Size: 0x74
function function_9d597adf(str_name) {
    self endon(#"unmake_hero");
    self waittill(#"death");
    if (isdefined(self)) {
        assertmsg("<dev string:x14e>" + str_name + "<dev string:x155>");
    }
    unmake_hero(str_name);
}

// Namespace util
// Params 1, eflags: 0x0
// Checksum 0xe15be440, Offset: 0x3e88
// Size: 0xa4
function unmake_hero(str_name) {
    ai_hero = level.heroes[str_name];
    level.heroes = array::remove_index(level.heroes, str_name, 1);
    if (isalive(ai_hero)) {
        ai_hero settmodeprovider(0);
        ai_hero stop_magic_bullet_shield();
        ai_hero notify(#"unmake_hero");
    }
}

// Namespace util
// Params 0, eflags: 0x0
// Checksum 0x6d811c4b, Offset: 0x3f38
// Size: 0xa
function function_b269e456() {
    return level.heroes;
}

// Namespace util
// Params 1, eflags: 0x0
// Checksum 0xf3970b5b, Offset: 0x3f50
// Size: 0x64
function function_740f8516(str_name) {
    if (!isdefined(level.heroes)) {
        level.heroes = [];
    }
    if (isdefined(level.heroes[str_name])) {
        return level.heroes[str_name];
    }
    return function_66773296(str_name);
}

// Namespace util
// Params 0, eflags: 0x0
// Checksum 0xb2268fb6, Offset: 0x3fc0
// Size: 0x16
function is_hero() {
    return isdefined(self.is_hero) && self.is_hero;
}

// Namespace util
// Params 1, eflags: 0x0
// Checksum 0x21171010, Offset: 0x3fe0
// Size: 0x4c
function function_286a5010(var_314c1232) {
    clientfield::register("world", "force_streamer", 1, getminbitcountfornum(var_314c1232), "int");
}

// Namespace util
// Params 0, eflags: 0x0
// Checksum 0xeebbd199, Offset: 0x4038
// Size: 0x44
function clear_streamer_hint() {
    level flag::wait_till("all_players_connected");
    level clientfield::set("force_streamer", 0);
}

// Namespace util
// Params 2, eflags: 0x0
// Checksum 0xb2b3e65a, Offset: 0x4088
// Size: 0x44
function function_d8eaed3d(n_zone, var_a6cc0cd9) {
    if (!isdefined(var_a6cc0cd9)) {
        var_a6cc0cd9 = 1;
    }
    level thread function_c748c2d6(n_zone, var_a6cc0cd9);
}

// Namespace util
// Params 2, eflags: 0x0
// Checksum 0xbbf3a563, Offset: 0x40d8
// Size: 0x2bc
function function_c748c2d6(n_zone, var_a6cc0cd9) {
    if (!isdefined(var_a6cc0cd9)) {
        var_a6cc0cd9 = 1;
    }
    level notify(#"hash_d8eaed3d");
    level endon(#"hash_d8eaed3d");
    assert(n_zone > 0, "<dev string:x15d>");
    level flagsys::set("streamer_loading");
    level flag::wait_till("all_players_connected");
    if (var_a6cc0cd9) {
        level clientfield::set("force_streamer", 0);
        wait_network_frame();
    }
    level clientfield::set("force_streamer", n_zone);
    if (!isdefined(level.var_66f2e49)) {
        level.var_66f2e49 = 1;
        /#
            level.var_66f2e49 = 0;
        #/
    }
    foreach (player in level.players) {
        player thread function_ba7c6f5d(n_zone);
    }
    /#
        n_timeout = gettime() + 15000;
    #/
    array::wait_till(level.players, "streamer" + n_zone, 15);
    level flagsys::clear("streamer_loading");
    level streamer_wait();
    /#
        if (gettime() >= n_timeout) {
            printtoprightln("<dev string:x184>" + string::function_8e23acba(gettime(), 6, "<dev string:x19e>"), (1, 0, 0));
            return;
        }
        printtoprightln("<dev string:x1a0>" + string::function_8e23acba(gettime(), 6, "<dev string:x19e>"), (1, 1, 1));
    #/
}

// Namespace util
// Params 1, eflags: 0x0
// Checksum 0xe0ce45fb, Offset: 0x43a0
// Size: 0x48
function function_ba7c6f5d(n_zone) {
    self endon(#"disconnect");
    level endon(#"hash_d8eaed3d");
    self waittillmatch(#"streamer", n_zone);
    self notify("streamer" + n_zone);
}

// Namespace util
// Params 2, eflags: 0x0
// Checksum 0x39c5a6c9, Offset: 0x43f0
// Size: 0x15e
function function_93831e79(var_f3739c90, var_46031771) {
    if (level.players.size <= 1) {
        return;
    }
    a_spots = skipto::function_3529c409(var_f3739c90, var_46031771);
    assert(a_spots.size >= level.players.size - 1, "<dev string:x1b7>");
    for (i = 0; i < level.players.size - 1; i++) {
        level.players[i + 1] setorigin(a_spots[i].origin);
        if (isdefined(a_spots[i].angles)) {
            level.players[i + 1] delay_network_frames(2, "disconnect", &setplayerangles, a_spots[i].angles);
        }
    }
}

// Namespace util
// Params 1, eflags: 0x0
// Checksum 0x25258fbc, Offset: 0x4558
// Size: 0xf4
function function_16c71b8(var_50ddaa73) {
    self setlowready(var_50ddaa73);
    self setclientuivisibilityflag("weapon_hud_visible", !var_50ddaa73);
    self allowjump(!var_50ddaa73);
    self allowsprint(!var_50ddaa73);
    self allowdoublejump(!var_50ddaa73);
    if (var_50ddaa73) {
        self disableoffhandweapons();
    } else {
        self enableoffhandweapons();
    }
    oed::enable_ev(!var_50ddaa73);
    oed::function_fc1750c9(!var_50ddaa73);
}

// Namespace util
// Params 0, eflags: 0x0
// Checksum 0x93e62525, Offset: 0x4658
// Size: 0xaa
function function_459ff829() {
    foreach (corpse in getcorpsearray()) {
        if (isactorcorpse(corpse)) {
            corpse delete();
        }
    }
}

// Namespace util
// Params 1, eflags: 0x0
// Checksum 0x476200ea, Offset: 0x4710
// Size: 0x4c
function function_ab12ef82(str_flag) {
    level.var_d83bc14d = str_flag;
    if (!flag::exists(str_flag)) {
        level flag::init(level.var_d83bc14d);
    }
}

// Namespace util
// Params 1, eflags: 0x0
// Checksum 0xfff86bed, Offset: 0x4768
// Size: 0x18
function function_ee915e11(str_flag) {
    level.var_8f7c5cd0 = str_flag;
}

// Namespace util
// Params 1, eflags: 0x0
// Checksum 0x4b7047f, Offset: 0x4788
// Size: 0xbe
function function_e218424d(b_state) {
    if (!isdefined(b_state)) {
        b_state = 1;
    }
    if (b_state) {
        self cybercom::function_59965309("cybercom_hijack");
        self cybercom::function_59965309("cybercom_iffoverride");
        self.var_406cec76 = 1;
        return;
    }
    self cybercom::function_a1f70a02("cybercom_hijack");
    self cybercom::function_a1f70a02("cybercom_iffoverride");
    self.var_406cec76 = undefined;
}

// Namespace util
// Params 0, eflags: 0x0
// Checksum 0x61ad5fc3, Offset: 0x4850
// Size: 0x64
function function_b499f765() {
    clientfield::register("toplayer", "player_cold_breath", 1, 1, "int");
    clientfield::register("actor", "ai_cold_breath", 1, 1, "counter");
}

// Namespace util
// Params 1, eflags: 0x0
// Checksum 0xc90ea492, Offset: 0x48c0
// Size: 0x2c
function player_frost_breath(var_f553b6d0) {
    self clientfield::set_to_player("player_cold_breath", var_f553b6d0);
}

// Namespace util
// Params 0, eflags: 0x0
// Checksum 0x30e700b1, Offset: 0x48f8
// Size: 0x5c
function function_65ba133d() {
    self endon(#"death");
    if (self.archetype === "human") {
        wait randomfloatrange(1, 3);
        self clientfield::increment("ai_cold_breath");
    }
}

// Namespace util
// Params 4, eflags: 0x0
// Checksum 0xd21c31, Offset: 0x4960
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
    self.hint_menu_handle = self openluimenu("CPHintText");
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
// Checksum 0x90828d8f, Offset: 0x4af0
// Size: 0xc2
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
// Checksum 0xd3da1a80, Offset: 0x4bc0
// Size: 0x74
function fade_hint_text_after_time(n_display_time, str_turn_off_notify) {
    self endon(#"hint_text_removed");
    self endon(#"death");
    self endon(#"kill_hint_text");
    waittill_any_timeout(n_display_time - 0.75, str_turn_off_notify);
    hide_hint_text(1);
}

// Namespace util
// Params 1, eflags: 0x0
// Checksum 0x848b276d, Offset: 0x4c40
// Size: 0x5c
function hide_hint_text_listener(n_time) {
    self endon(#"hint_text_removed");
    self endon(#"disconnect");
    waittill_any_timeout(n_time, "kill_hint_text", "death");
    hide_hint_text(0);
}

// Namespace util
// Params 2, eflags: 0x0
// Checksum 0x34ef5289, Offset: 0x4ca8
// Size: 0x3c
function function_964b7eb7(var_7aab41df, str_message) {
    var_7aab41df luinotifyevent(%comms_event_message, 1, str_message);
}

// Namespace util
// Params 5, eflags: 0x0
// Checksum 0xc7b9ede3, Offset: 0x4cf0
// Size: 0x264
function function_14518e76(trigger, str_objective, str_hint_text, var_e6ffaa89, a_keyline_objects) {
    trigger sethintstring(str_hint_text);
    trigger setcursorhint("HINT_INTERACTIVE_PROMPT");
    if (!isdefined(a_keyline_objects)) {
        a_keyline_objects = [];
    } else {
        if (!isdefined(a_keyline_objects)) {
            a_keyline_objects = [];
        } else if (!isarray(a_keyline_objects)) {
            a_keyline_objects = array(a_keyline_objects);
        }
        foreach (mdl in a_keyline_objects) {
            mdl oed::function_e228c18a(1);
        }
    }
    game_object = gameobjects::create_use_object("any", trigger, a_keyline_objects, (0, 0, 0), str_objective);
    game_object gameobjects::allow_use("any");
    game_object gameobjects::set_use_time(0.35);
    game_object gameobjects::set_owner_team("allies");
    game_object gameobjects::set_visible_team("any");
    game_object.single_use = 0;
    game_object.origin = game_object.origin;
    game_object.angles = game_object.angles;
    if (isdefined(var_e6ffaa89)) {
        game_object.onuse = var_e6ffaa89;
    }
    return game_object;
}

