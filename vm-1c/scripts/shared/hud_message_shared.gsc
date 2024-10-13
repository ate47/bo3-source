#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/music_shared;
#using scripts/shared/hud_util_shared;
#using scripts/shared/hud_message_shared;
#using scripts/shared/callbacks_shared;
#using scripts/codescripts/struct;

#namespace hud_message;

// Namespace hud_message
// Params 0, eflags: 0x2
// Checksum 0x3506da05, Offset: 0x210
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("hud_message", &__init__, undefined, undefined);
}

// Namespace hud_message
// Params 0, eflags: 0x1 linked
// Checksum 0x1bb5db15, Offset: 0x250
// Size: 0x24
function __init__() {
    callback::on_start_gametype(&init);
}

// Namespace hud_message
// Params 0, eflags: 0x1 linked
// Checksum 0x87dbbe5e, Offset: 0x280
// Size: 0x44
function init() {
    callback::on_connect(&on_player_connect);
    callback::on_disconnect(&on_player_disconnect);
}

// Namespace hud_message
// Params 0, eflags: 0x1 linked
// Checksum 0x7311a22b, Offset: 0x2d0
// Size: 0x64
function on_player_connect() {
    self thread hintmessagedeaththink();
    self thread lowermessagethink();
    self thread function_cb5c5225();
    self thread function_1aecf547();
}

// Namespace hud_message
// Params 0, eflags: 0x1 linked
// Checksum 0x49c5d77, Offset: 0x340
// Size: 0x54
function on_player_disconnect() {
    if (isdefined(self.var_68c830e5)) {
        self.var_68c830e5 destroy();
    }
    if (isdefined(self.var_c82fda53)) {
        self.var_c82fda53 destroy();
    }
}

// Namespace hud_message
// Params 0, eflags: 0x1 linked
// Checksum 0xe5e223ec, Offset: 0x3a0
// Size: 0x1d4
function function_1aecf547() {
    font = "default";
    var_7fa9f5fa = 2.5;
    self.var_68c830e5 = hud::createfontstring(font, var_7fa9f5fa);
    self.var_68c830e5 hud::setpoint("TOP", undefined, 0, 30);
    self.var_68c830e5.glowalpha = 1;
    self.var_68c830e5.hidewheninmenu = 1;
    self.var_68c830e5.archived = 0;
    self.var_68c830e5.color = (1, 1, 0.6);
    self.var_68c830e5.alpha = 1;
    var_7fa9f5fa = 2;
    self.var_c82fda53 = hud::createfontstring(font, var_7fa9f5fa);
    self.var_c82fda53 hud::setparent(self.var_68c830e5);
    self.var_c82fda53 hud::setpoint("TOP", "BOTTOM", 0, 0);
    self.var_c82fda53.glowalpha = 1;
    self.var_c82fda53.hidewheninmenu = 1;
    self.var_c82fda53.archived = 0;
    self.var_c82fda53.color = (1, 1, 0.6);
    self.var_c82fda53.alpha = 1;
}

// Namespace hud_message
// Params 2, eflags: 0x1 linked
// Checksum 0x7d1c6755, Offset: 0x580
// Size: 0x6c
function hintmessage(hinttext, duration) {
    var_b444826e = spawnstruct();
    var_b444826e.var_da258253 = hinttext;
    var_b444826e.duration = duration;
    notifymessage(var_b444826e);
}

// Namespace hud_message
// Params 3, eflags: 0x0
// Checksum 0x325610d, Offset: 0x5f8
// Size: 0xae
function function_163cbca3(players, hinttext, duration) {
    var_b444826e = spawnstruct();
    var_b444826e.var_da258253 = hinttext;
    var_b444826e.duration = duration;
    for (i = 0; i < players.size; i++) {
        players[i] notifymessage(var_b444826e);
    }
}

// Namespace hud_message
// Params 1, eflags: 0x1 linked
// Checksum 0x4286d2d8, Offset: 0x6b0
// Size: 0x5c
function function_c0025cfc(team) {
    self luinotifyevent(%faction_popup, 1, game["strings"][team + "_name"]);
    function_2bb1fc0(undefined, undefined, undefined, undefined);
}

// Namespace hud_message
// Params 0, eflags: 0x1 linked
// Checksum 0xc8abad1d, Offset: 0x718
// Size: 0x4d0
function function_cb5c5225() {
    if (!sessionmodeiszombiesgame()) {
        if (self issplitscreen()) {
            var_7fa9f5fa = 2;
            textsize = 1.4;
            iconsize = 24;
            font = "big";
            point = "TOP";
            relativepoint = "BOTTOM";
            yoffset = 30;
            xoffset = 30;
        } else {
            var_7fa9f5fa = 2.5;
            textsize = 1.75;
            iconsize = 30;
            font = "big";
            point = "TOP";
            relativepoint = "BOTTOM";
            yoffset = 0;
            xoffset = 0;
        }
    } else if (self issplitscreen()) {
        var_7fa9f5fa = 2;
        textsize = 1.4;
        iconsize = 24;
        font = "big";
        point = "TOP";
        relativepoint = "BOTTOM";
        yoffset = 30;
        xoffset = 30;
    } else {
        var_7fa9f5fa = 2.5;
        textsize = 1.75;
        iconsize = 30;
        font = "big";
        point = "BOTTOM LEFT";
        relativepoint = "TOP";
        yoffset = 0;
        xoffset = 0;
    }
    self.var_6a60de54 = hud::createfontstring(font, var_7fa9f5fa);
    self.var_6a60de54 hud::setpoint(point, undefined, xoffset, yoffset);
    self.var_6a60de54.glowalpha = 1;
    self.var_6a60de54.hidewheninmenu = 1;
    self.var_6a60de54.archived = 0;
    self.var_6a60de54.alpha = 0;
    self.var_da258253 = hud::createfontstring(font, textsize);
    self.var_da258253 hud::setparent(self.var_6a60de54);
    self.var_da258253 hud::setpoint(point, relativepoint, 0, 0);
    self.var_da258253.glowalpha = 1;
    self.var_da258253.hidewheninmenu = 1;
    self.var_da258253.archived = 0;
    self.var_da258253.alpha = 0;
    self.var_2888112b = hud::createfontstring(font, textsize);
    self.var_2888112b hud::setparent(self.var_6a60de54);
    self.var_2888112b hud::setpoint(point, relativepoint, 0, 0);
    self.var_2888112b.glowalpha = 1;
    self.var_2888112b.hidewheninmenu = 1;
    self.var_2888112b.archived = 0;
    self.var_2888112b.alpha = 0;
    self.var_7692dd85 = hud::createicon("white", iconsize, iconsize);
    self.var_7692dd85 hud::setparent(self.var_2888112b);
    self.var_7692dd85 hud::setpoint(point, relativepoint, 0, 0);
    self.var_7692dd85.hidewheninmenu = 1;
    self.var_7692dd85.archived = 0;
    self.var_7692dd85.alpha = 0;
    self.var_decbf609 = 0;
    self.var_43348c07 = [];
}

// Namespace hud_message
// Params 6, eflags: 0x1 linked
// Checksum 0xb6eb90c5, Offset: 0xbf0
// Size: 0xf6
function function_2bb1fc0(var_c4a19800, var_da258253, iconname, glowcolor, sound, duration) {
    if (level.wagermatch && !level.teambased) {
        return;
    }
    var_b444826e = spawnstruct();
    var_b444826e.var_c4a19800 = var_c4a19800;
    var_b444826e.var_da258253 = var_da258253;
    var_b444826e.iconname = iconname;
    var_b444826e.sound = sound;
    var_b444826e.duration = duration;
    self.var_f57b5d00[self.var_f57b5d00.size] = var_b444826e;
    self notify(#"hash_2528173");
}

// Namespace hud_message
// Params 1, eflags: 0x1 linked
// Checksum 0xaba1d943, Offset: 0xcf0
// Size: 0x5e
function notifymessage(var_b444826e) {
    self endon(#"death");
    self endon(#"disconnect");
    if (!isdefined(self.var_4c9e757e)) {
        self.var_4c9e757e = [];
    }
    self.var_4c9e757e[self.var_4c9e757e.size] = var_b444826e;
    self notify(#"hash_2528173");
}

// Namespace hud_message
// Params 1, eflags: 0x0
// Checksum 0xe940172f, Offset: 0xd58
// Size: 0x9c
function playnotifyloop(duration) {
    playnotifyloop = spawn("script_origin", (0, 0, 0));
    playnotifyloop playloopsound("uin_notify_data_loop");
    duration -= 4;
    if (duration < 1) {
        duration = 1;
    }
    wait duration;
    playnotifyloop delete();
}

// Namespace hud_message
// Params 2, eflags: 0x1 linked
// Checksum 0x859cacce, Offset: 0xe00
// Size: 0x79c
function function_3cb967ea(var_b444826e, duration) {
    self endon(#"disconnect");
    self.var_decbf609 = 1;
    function_6ecb638b(0);
    self notify(#"hash_7f4cd48e", duration);
    self thread function_b9356de3();
    if (isdefined(var_b444826e.sound)) {
        self playlocalsound(var_b444826e.sound);
    }
    if (isdefined(var_b444826e.musicstate)) {
        self music::setmusicstate(var_b444826e.music);
    }
    if (isdefined(var_b444826e.var_4ce51653)) {
        if (isdefined(level.globallogic_audio_dialog_on_player_override)) {
            self [[ level.globallogic_audio_dialog_on_player_override ]](var_b444826e.var_4ce51653);
        }
    }
    if (isdefined(var_b444826e.glowcolor)) {
        glowcolor = var_b444826e.glowcolor;
    } else {
        glowcolor = (0, 0, 0);
    }
    if (isdefined(var_b444826e.color)) {
        color = var_b444826e.color;
    } else {
        color = (1, 1, 1);
    }
    var_875db75b = self.var_6a60de54;
    if (isdefined(var_b444826e.var_c4a19800)) {
        if (isdefined(var_b444826e.titlelabel)) {
            self.var_6a60de54.label = var_b444826e.titlelabel;
        } else {
            self.var_6a60de54.label = %;
        }
        if (isdefined(var_b444826e.titlelabel) && !isdefined(var_b444826e.var_1193121a)) {
            self.var_6a60de54 setvalue(var_b444826e.var_c4a19800);
        } else {
            self.var_6a60de54 settext(var_b444826e.var_c4a19800);
        }
        self.var_6a60de54 setcod7decodefx(-56, int(duration * 1000), 600);
        self.var_6a60de54.glowcolor = glowcolor;
        self.var_6a60de54.color = color;
        self.var_6a60de54.alpha = 1;
    }
    if (isdefined(var_b444826e.var_da258253)) {
        if (isdefined(var_b444826e.var_46cc8dd2)) {
            self.var_da258253.label = var_b444826e.var_46cc8dd2;
        } else {
            self.var_da258253.label = %;
        }
        if (isdefined(var_b444826e.var_46cc8dd2) && !isdefined(var_b444826e.var_c25f48db)) {
            self.var_da258253 setvalue(var_b444826e.var_da258253);
        } else {
            self.var_da258253 settext(var_b444826e.var_da258253);
        }
        self.var_da258253 setcod7decodefx(100, int(duration * 1000), 600);
        self.var_da258253.glowcolor = glowcolor;
        self.var_da258253.color = color;
        self.var_da258253.alpha = 1;
        var_875db75b = self.var_da258253;
    }
    if (isdefined(var_b444826e.var_2888112b)) {
        if (self issplitscreen()) {
            if (isdefined(var_b444826e.var_8dd948fc)) {
                self iprintlnbold(var_b444826e.var_8dd948fc, var_b444826e.var_2888112b);
            } else {
                self iprintlnbold(var_b444826e.var_2888112b);
            }
        } else {
            self.var_2888112b hud::setparent(var_875db75b);
            if (isdefined(var_b444826e.var_8dd948fc)) {
                self.var_2888112b.label = var_b444826e.var_8dd948fc;
            } else {
                self.var_2888112b.label = %;
            }
            self.var_2888112b settext(var_b444826e.var_2888112b);
            self.var_2888112b setpulsefx(100, int(duration * 1000), 1000);
            self.var_2888112b.glowcolor = glowcolor;
            self.var_2888112b.color = color;
            self.var_2888112b.alpha = 1;
            var_875db75b = self.var_2888112b;
        }
    }
    if (isdefined(var_b444826e.iconname)) {
        iconwidth = 60;
        iconheight = 60;
        if (isdefined(var_b444826e.iconwidth)) {
            iconwidth = var_b444826e.iconwidth;
        }
        if (isdefined(var_b444826e.iconheight)) {
            iconheight = var_b444826e.iconheight;
        }
        self.var_7692dd85 hud::setparent(var_875db75b);
        self.var_7692dd85 setshader(var_b444826e.iconname, iconwidth, iconheight);
        self.var_7692dd85.alpha = 0;
        self.var_7692dd85 fadeovertime(1);
        self.var_7692dd85.alpha = 1;
        function_6ecb638b(duration);
        self.var_7692dd85 fadeovertime(0.75);
        self.var_7692dd85.alpha = 0;
    } else {
        function_6ecb638b(duration);
    }
    self notify(#"hash_ebcdda07");
    self.var_decbf609 = 0;
}

// Namespace hud_message
// Params 1, eflags: 0x1 linked
// Checksum 0xffdc977d, Offset: 0x15a8
// Size: 0x7a
function function_6ecb638b(waittime) {
    interval = 0.05;
    while (!self function_a8d99e50()) {
        wait interval;
    }
    while (waittime > 0) {
        wait interval;
        if (self function_a8d99e50()) {
            waittime -= interval;
        }
    }
}

// Namespace hud_message
// Params 0, eflags: 0x1 linked
// Checksum 0xc8d94473, Offset: 0x1630
// Size: 0x26
function function_a8d99e50() {
    if (self util::is_flashbanged()) {
        return false;
    }
    return true;
}

// Namespace hud_message
// Params 0, eflags: 0x0
// Checksum 0x93939159, Offset: 0x1660
// Size: 0x44
function resetondeath() {
    self endon(#"hash_ebcdda07");
    self endon(#"disconnect");
    level endon(#"game_ended");
    self waittill(#"death");
    resetnotify();
}

// Namespace hud_message
// Params 0, eflags: 0x1 linked
// Checksum 0xf8ebd61f, Offset: 0x16b0
// Size: 0x54
function function_b9356de3() {
    self notify(#"hash_b9356de3");
    self endon(#"hash_b9356de3");
    self endon(#"hash_ebcdda07");
    self endon(#"disconnect");
    level waittill(#"hash_aa6f899d");
    resetnotify();
}

// Namespace hud_message
// Params 0, eflags: 0x1 linked
// Checksum 0x43825907, Offset: 0x1710
// Size: 0x60
function resetnotify() {
    self.var_6a60de54.alpha = 0;
    self.var_da258253.alpha = 0;
    self.var_2888112b.alpha = 0;
    self.var_7692dd85.alpha = 0;
    self.var_decbf609 = 0;
}

// Namespace hud_message
// Params 0, eflags: 0x1 linked
// Checksum 0x8978c336, Offset: 0x1778
// Size: 0x48
function hintmessagedeaththink() {
    self endon(#"disconnect");
    for (;;) {
        self waittill(#"death");
        if (isdefined(self.hintmessage)) {
            self.hintmessage hud::destroyelem();
        }
    }
}

// Namespace hud_message
// Params 0, eflags: 0x1 linked
// Checksum 0x2cd85eb0, Offset: 0x17c8
// Size: 0x1c8
function lowermessagethink() {
    self endon(#"disconnect");
    var_6158ea14 = level.lowertexty;
    if (self issplitscreen()) {
        var_6158ea14 = level.lowertexty - 50;
    }
    self.lowermessage = hud::createfontstring("default", level.lowertextfontsize);
    self.lowermessage hud::setpoint("CENTER", level.lowertextyalign, 0, var_6158ea14);
    self.lowermessage settext("");
    self.lowermessage.archived = 0;
    var_a6ad6b60 = 1.5;
    if (self issplitscreen()) {
        var_a6ad6b60 = 1.4;
    }
    self.lowertimer = hud::createfontstring("default", var_a6ad6b60);
    self.lowertimer hud::setparent(self.lowermessage);
    self.lowertimer hud::setpoint("TOP", "BOTTOM", 0, 0);
    self.lowertimer settext("");
    self.lowertimer.archived = 0;
}

// Namespace hud_message
// Params 1, eflags: 0x1 linked
// Checksum 0x4d0387a1, Offset: 0x1998
// Size: 0x6c
function function_d6911678(team) {
    if (level.cumulativeroundscores) {
        self setvalue(getteamscore(team));
        return;
    }
    self setvalue(util::get_rounds_won(team));
}

// Namespace hud_message
// Params 2, eflags: 0x1 linked
// Checksum 0x4c8461c3, Offset: 0x1a10
// Size: 0x66
function isintop(players, topn) {
    for (i = 0; i < topn; i++) {
        if (isdefined(players[i]) && self == players[i]) {
            return true;
        }
    }
    return false;
}

// Namespace hud_message
// Params 1, eflags: 0x1 linked
// Checksum 0x3d8c1855, Offset: 0x1a80
// Size: 0x2c
function function_6d358955(hudelem) {
    if (isdefined(hudelem)) {
        hudelem hud::destroyelem();
    }
}

// Namespace hud_message
// Params 0, eflags: 0x1 linked
// Checksum 0xef39d67c, Offset: 0x1ab8
// Size: 0xcc
function function_b5203d90() {
    if (!isdefined(self.var_f2e9a21a)) {
        self.var_f2e9a21a = hud::createfontstring("objective", 2.5);
        self.var_f2e9a21a hud::setpoint("CENTER", "CENTER", 0, -80);
        self.var_f2e9a21a.sort = 1001;
        self.var_f2e9a21a settext(%MP_WAITING_FOR_PLAYERS_SHOUTCASTER);
        self.var_f2e9a21a.foreground = 0;
        self.var_f2e9a21a.hidewheninmenu = 1;
    }
}

// Namespace hud_message
// Params 0, eflags: 0x1 linked
// Checksum 0xfc203b0e, Offset: 0x1b90
// Size: 0x36
function function_b17b90b9() {
    if (isdefined(self.var_f2e9a21a)) {
        function_6d358955(self.var_f2e9a21a);
        self.var_f2e9a21a = undefined;
    }
}

// Namespace hud_message
// Params 0, eflags: 0x0
// Checksum 0x997d5d4f, Offset: 0x1bd0
// Size: 0xee
function function_c830b4d0() {
    var_42cafb41 = 1;
    for (timewaited = 0; var_42cafb41 && timewaited < 12; timewaited += 0.2) {
        var_42cafb41 = 0;
        players = getplayers();
        for (i = 0; i < players.size; i++) {
            if (isdefined(players[i].var_43348c07) && players[i].var_43348c07.size > 0) {
                var_42cafb41 = 1;
            }
        }
        if (var_42cafb41) {
            wait 0.2;
        }
    }
}

