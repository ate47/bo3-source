#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/audio_shared;
#using scripts/shared/array_shared;
#using scripts/codescripts/struct;

#namespace zm_audio;

// Namespace zm_audio
// Params 0, eflags: 0x2
// Checksum 0x70ff34dc, Offset: 0x460
// Size: 0x34
function function_2dc19561() {
    system::register("zm_audio", &__init__, undefined, undefined);
}

// Namespace zm_audio
// Params 0, eflags: 0x1 linked
// Checksum 0x3f5a4146, Offset: 0x4a0
// Size: 0x1a4
function __init__() {
    clientfield::register("allplayers", "charindex", 1, 3, "int", &charindex_cb, 0, 1);
    clientfield::register("toplayer", "isspeaking", 1, 1, "int", &isspeaking_cb, 0, 1);
    if (!isdefined(level.exert_sounds)) {
        level.exert_sounds = [];
    }
    level.exert_sounds[0]["playerbreathinsound"] = "vox_exert_generic_inhale";
    level.exert_sounds[0]["playerbreathoutsound"] = "vox_exert_generic_exhale";
    level.exert_sounds[0]["playerbreathgaspsound"] = "vox_exert_generic_exhale";
    level.exert_sounds[0]["falldamage"] = "vox_exert_generic_pain";
    level.exert_sounds[0]["mantlesoundplayer"] = "vox_exert_generic_mantle";
    level.exert_sounds[0]["meleeswipesoundplayer"] = "vox_exert_generic_knifeswipe";
    level.exert_sounds[0]["dtplandsoundplayer"] = "vox_exert_generic_pain";
    level thread gameover_snapshot();
    callback::on_spawned(&on_player_spawned);
}

// Namespace zm_audio
// Params 1, eflags: 0x1 linked
// Checksum 0x2b6b900c, Offset: 0x650
// Size: 0xc
function on_player_spawned(localclientnum) {
    
}

// Namespace zm_audio
// Params 1, eflags: 0x1 linked
// Checksum 0x7e39eb96, Offset: 0x668
// Size: 0x38
function delay_set_exert_id(newval) {
    self endon(#"entityshutdown");
    self endon(#"sndendexertoverride");
    wait(0.5);
    self.player_exert_id = newval;
}

// Namespace zm_audio
// Params 7, eflags: 0x1 linked
// Checksum 0x29d2394a, Offset: 0x6a8
// Size: 0xa4
function charindex_cb(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (!bnewent) {
        self.player_exert_id = newval;
        self._first_frame_exert_id_recieved = 1;
        self notify(#"sndendexertoverride");
        return;
    }
    if (!isdefined(self._first_frame_exert_id_recieved)) {
        self._first_frame_exert_id_recieved = 1;
        self thread delay_set_exert_id(newval);
    }
}

// Namespace zm_audio
// Params 7, eflags: 0x1 linked
// Checksum 0x873c8808, Offset: 0x758
// Size: 0x60
function isspeaking_cb(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (!bnewent) {
        self.isspeaking = newval;
        return;
    }
    self.isspeaking = 0;
}

// Namespace zm_audio
// Params 0, eflags: 0x0
// Checksum 0xa67fe2be, Offset: 0x7c0
// Size: 0x94
function zmbmuslooper() {
    ent = spawn(0, (0, 0, 0), "script_origin");
    playsound(0, "mus_zmb_gamemode_start", (0, 0, 0));
    wait(10);
    ent playloopsound("mus_zmb_gamemode_loop", 0.05);
    ent thread waitfor_music_stop();
}

// Namespace zm_audio
// Params 0, eflags: 0x1 linked
// Checksum 0xa05676de, Offset: 0x860
// Size: 0x64
function waitfor_music_stop() {
    level waittill(#"stpm");
    self stopallloopsounds(0.1);
    playsound(0, "mus_zmb_gamemode_end", (0, 0, 0));
    wait(1);
    self delete();
}

// Namespace zm_audio
// Params 2, eflags: 0x1 linked
// Checksum 0x1c1044f8, Offset: 0x8d0
// Size: 0x34
function playerfalldamagesound(client_num, firstperson) {
    self playerexert(client_num, "falldamage");
}

// Namespace zm_audio
// Params 0, eflags: 0x1 linked
// Checksum 0xfc787f59, Offset: 0x910
// Size: 0x7e
function clientvoicesetup() {
    callback::on_localclient_connect(&audio_player_connect);
    players = getlocalplayers();
    for (i = 0; i < players.size; i++) {
        thread audio_player_connect(i);
    }
}

// Namespace zm_audio
// Params 1, eflags: 0x1 linked
// Checksum 0xad186b6f, Offset: 0x998
// Size: 0xcc
function audio_player_connect(localclientnum) {
    thread sndvonotifyplain(localclientnum, "playerbreathinsound");
    thread sndvonotifyplain(localclientnum, "playerbreathoutsound");
    thread sndvonotifyplain(localclientnum, "playerbreathgaspsound");
    thread sndvonotifyplain(localclientnum, "mantlesoundplayer");
    thread sndvonotifyplain(localclientnum, "meleeswipesoundplayer");
    thread sndvonotifydtp(localclientnum, "dtplandsoundplayer");
}

// Namespace zm_audio
// Params 2, eflags: 0x1 linked
// Checksum 0x2ddb3a68, Offset: 0xa70
// Size: 0x15c
function playerexert(localclientnum, exert) {
    if (isdefined(self.isspeaking) && self.isspeaking == 1) {
        return;
    }
    if (isdefined(self.beast_mode) && self.beast_mode) {
        return;
    }
    id = level.exert_sounds[0][exert];
    if (isarray(level.exert_sounds[0][exert])) {
        id = array::random(level.exert_sounds[0][exert]);
    }
    if (isdefined(self.player_exert_id)) {
        if (isarray(level.exert_sounds[self.player_exert_id][exert])) {
            id = array::random(level.exert_sounds[self.player_exert_id][exert]);
        } else {
            id = level.exert_sounds[self.player_exert_id][exert];
        }
    }
    if (isdefined(id)) {
        self playsound(localclientnum, id);
    }
}

// Namespace zm_audio
// Params 2, eflags: 0x1 linked
// Checksum 0x5618d8bd, Offset: 0xbd8
// Size: 0xc8
function sndvonotifydtp(localclientnum, notifystring) {
    level notify("kill_sndVoNotifyDTP" + localclientnum + notifystring);
    level endon("kill_sndVoNotifyDTP" + localclientnum + notifystring);
    player = undefined;
    while (!isdefined(player)) {
        player = getnonpredictedlocalplayer(localclientnum);
        wait(0.05);
    }
    player endon(#"disconnect");
    for (;;) {
        surfacetype = player waittill(notifystring);
        player playerexert(localclientnum, notifystring);
    }
}

// Namespace zm_audio
// Params 2, eflags: 0x0
// Checksum 0xdfc6f3a5, Offset: 0xca8
// Size: 0x208
function sndmeleeswipe(localclientnum, notifystring) {
    player = undefined;
    while (!isdefined(player)) {
        player = getnonpredictedlocalplayer(localclientnum);
        wait(0.05);
    }
    player endon(#"disconnect");
    for (;;) {
        player waittill(notifystring);
        currentweapon = getcurrentweapon(localclientnum);
        if (isdefined(level.sndnomeleeonclient) && level.sndnomeleeonclient) {
            return;
        }
        if (isdefined(player.is_player_zombie) && player.is_player_zombie) {
            playsound(0, "zmb_melee_whoosh_zmb_plr", player.origin);
            continue;
        }
        if (currentweapon.name == "bowie_knife") {
            playsound(0, "zmb_bowie_swing_plr", player.origin);
            continue;
        }
        if (currentweapon.name == "spoon_zm_alcatraz") {
            playsound(0, "zmb_spoon_swing_plr", player.origin);
            continue;
        }
        if (currentweapon.name == "spork_zm_alcatraz") {
            playsound(0, "zmb_spork_swing_plr", player.origin);
            continue;
        }
        playsound(0, "zmb_melee_whoosh_plr", player.origin);
    }
}

// Namespace zm_audio
// Params 2, eflags: 0x1 linked
// Checksum 0x6c31d1f8, Offset: 0xeb8
// Size: 0xe8
function sndvonotifyplain(localclientnum, notifystring) {
    level notify("kill_sndVoNotifyPlain" + localclientnum + notifystring);
    level endon("kill_sndVoNotifyPlain" + localclientnum + notifystring);
    player = undefined;
    while (!isdefined(player)) {
        player = getnonpredictedlocalplayer(localclientnum);
        wait(0.05);
    }
    player endon(#"disconnect");
    for (;;) {
        player waittill(notifystring);
        if (isdefined(player.is_player_zombie) && player.is_player_zombie) {
            continue;
        }
        player playerexert(localclientnum, notifystring);
    }
}

// Namespace zm_audio
// Params 0, eflags: 0x1 linked
// Checksum 0xfd5ef33e, Offset: 0xfa8
// Size: 0x6c
function end_gameover_snapshot() {
    level util::waittill_any("demo_jump", "demo_player_switch", "snd_clear_script_duck");
    wait(1);
    audio::snd_set_snapshot("default");
    level thread gameover_snapshot();
}

// Namespace zm_audio
// Params 0, eflags: 0x1 linked
// Checksum 0x5e058b09, Offset: 0x1020
// Size: 0x44
function gameover_snapshot() {
    level waittill(#"zesn");
    audio::snd_set_snapshot("zmb_game_over");
    level thread end_gameover_snapshot();
}

// Namespace zm_audio
// Params 7, eflags: 0x1 linked
// Checksum 0xff5bbefa, Offset: 0x1070
// Size: 0x94
function function_790b3d9d(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval == 1) {
        self setsoundentcontext("grass", "no_grass");
        return;
    }
    self setsoundentcontext("grass", "in_grass");
}

// Namespace zm_audio
// Params 7, eflags: 0x1 linked
// Checksum 0x8b345a0c, Offset: 0x1110
// Size: 0x14c
function sndzmblaststand(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        playsound(localclientnum, "chr_health_laststand_enter", (0, 0, 0));
        self.inlaststand = 1;
        setsoundcontext("laststand", "active");
        if (!issplitscreen()) {
            forceambientroom("sndHealth_LastStand");
        }
        return;
    }
    if (isdefined(self.inlaststand) && self.inlaststand) {
        playsound(localclientnum, "chr_health_laststand_exit", (0, 0, 0));
        self.inlaststand = 0;
        if (!issplitscreen()) {
            forceambientroom("");
        }
    }
    setsoundcontext("laststand", "");
}

