#using scripts/zm/_zm_audio;
#using scripts/shared/visionset_mgr_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/audio_shared;
#using scripts/shared/array_shared;
#using scripts/codescripts/struct;

#namespace zm_cosmodrome_amb;

// Namespace zm_cosmodrome_amb
// Params 0, eflags: 0x1 linked
// Checksum 0xfe225b40, Offset: 0x438
// Size: 0xac
function main() {
    level thread function_236ee1ee();
    level thread function_ddc1ee89();
    level thread function_efc0fd84();
    level thread function_b04100a8();
    level thread amb_power_up();
    level thread startzmbspawnersoundloops();
    level thread function_c9207335();
}

// Namespace zm_cosmodrome_amb
// Params 0, eflags: 0x1 linked
// Checksum 0x80614ad8, Offset: 0x4f0
// Size: 0x18c
function function_efc0fd84() {
    audio::snd_play_auto_fx("fx_fire_line_xsm", "amb_fire_medium");
    audio::snd_play_auto_fx("fx_fire_line_sm", "amb_fire_large");
    audio::snd_play_auto_fx("fx_fire_wall_back_sm", "amb_fire_large");
    audio::snd_play_auto_fx("fx_fire_destruction_lg", "amb_fire_extreme");
    audio::snd_play_auto_fx("fx_zmb_fire_sm_smolder", "amb_fire_medium");
    audio::snd_play_auto_fx("fx_elec_terminal", "amb_break_arc");
    audio::snd_play_auto_fx("fx_zmb_elec_terminal_bridge", "amb_break_arc");
    audio::snd_play_auto_fx("fx_zmb_pipe_steam_md", "amb_steam_medium");
    audio::snd_play_auto_fx("fx_zmb_pipe_steam_md_runner", "amb_steam_medium");
    audio::snd_play_auto_fx("fx_zmb_steam_hallway_md", "amb_steam_medium");
    audio::snd_play_auto_fx("fx_zmb_water_spray_leak_sm", "amb_water_spray_small");
    audio::playloopat("amb_secret_truck_iseverything", (-1419, 1506, -124));
}

// Namespace zm_cosmodrome_amb
// Params 0, eflags: 0x1 linked
// Checksum 0x1c0a880, Offset: 0x688
// Size: 0xd8
function function_b04100a8() {
    while (true) {
        level waittill(#"hash_39676a0b");
        ent = spawn(0, (0, 0, 0), "script_origin");
        ent playloopsound("zmb_insta_kill_loop");
        level waittill(#"hash_2544b84d");
        playsound(0, "zmb_insta_kill", (0, 0, 0));
        ent stoploopsound(0.5);
        wait 0.5;
        ent delete();
    }
}

// Namespace zm_cosmodrome_amb
// Params 0, eflags: 0x1 linked
// Checksum 0xd624fa65, Offset: 0x768
// Size: 0x3e
function function_236ee1ee() {
    level waittill(#"power_on");
    wait 2.5;
    level thread function_d2ed7980();
    wait 21;
    level notify(#"hash_78527d76");
}

// Namespace zm_cosmodrome_amb
// Params 0, eflags: 0x1 linked
// Checksum 0xb3ce7329, Offset: 0x7b0
// Size: 0x2c
function function_ddc1ee89() {
    level waittill(#"power_on");
    wait 8.5;
    level thread function_44f4e8bb();
}

// Namespace zm_cosmodrome_amb
// Params 0, eflags: 0x1 linked
// Checksum 0x5339836d, Offset: 0x7e8
// Size: 0x48
function function_90cfe8c5() {
    level endon(#"hash_78527d76");
    while (true) {
        playsound(0, "evt_alarm_a", self.origin);
        wait 1.1;
    }
}

// Namespace zm_cosmodrome_amb
// Params 0, eflags: 0x1 linked
// Checksum 0x86b13fff, Offset: 0x838
// Size: 0xe4
function function_b6d2632e() {
    var_11935664 = spawn(0, self.origin, "script.origin");
    var_11935664.var_1875fe27 = var_11935664 playloopsound("evt_alarm_b_loop", 0.8);
    wait 8.8;
    playsound(0, "evt_alarm_b_end", self.origin);
    wait 0.1;
    var_11935664 stoploopsound(var_11935664.var_1875fe27, 0.6);
    wait 3;
    var_11935664 delete();
}

// Namespace zm_cosmodrome_amb
// Params 0, eflags: 0x1 linked
// Checksum 0xa32d8b73, Offset: 0x928
// Size: 0x44
function function_d2ed7980() {
    array::thread_all(struct::get_array("amb_warning_siren", "targetname"), &function_90cfe8c5);
}

// Namespace zm_cosmodrome_amb
// Params 0, eflags: 0x1 linked
// Checksum 0x66645ad2, Offset: 0x978
// Size: 0x44
function function_44f4e8bb() {
    array::thread_all(struct::get_array("amb_warning_bell", "targetname"), &function_b6d2632e);
}

// Namespace zm_cosmodrome_amb
// Params 0, eflags: 0x0
// Checksum 0x7c7ca3c0, Offset: 0x9c8
// Size: 0x2c
function function_7179c1c9() {
    wait 2;
    playsound(0, "amb_vox_rus_PA", self.origin);
}

// Namespace zm_cosmodrome_amb
// Params 1, eflags: 0x1 linked
// Checksum 0xd47eef, Offset: 0xa00
// Size: 0x134
function function_84e46cfe(localclientnum) {
    player = getlocalplayers()[localclientnum];
    audio::snd_set_snapshot("zmb_samantha_scream");
    player earthquake(0.4, 10, player.origin, -106);
    visionset_mgr::function_a95252c1("_nopower");
    visionset_mgr::function_3aea3c1a(0, "zombie_cosmodrome", 2.5);
    player thread function_7c49fd5a();
    wait 6;
    audio::snd_set_snapshot("default");
    visionset_mgr::function_a95252c1("_poweron");
    visionset_mgr::function_3aea3c1a(0, "zombie_cosmodrome", 2.5);
}

// Namespace zm_cosmodrome_amb
// Params 0, eflags: 0x1 linked
// Checksum 0x6c6e64ee, Offset: 0xb40
// Size: 0x72
function function_7c49fd5a() {
    self endon(#"disconnect");
    for (count = 0; count <= 4 && isdefined(self); count += 0.1) {
        self playrumbleonentity(0, "damage_heavy");
        wait 0.1;
    }
}

// Namespace zm_cosmodrome_amb
// Params 0, eflags: 0x1 linked
// Checksum 0xb4bd17e2, Offset: 0xbc0
// Size: 0x74
function function_c9207335() {
    wait 3;
    level thread function_d667714e();
    var_13a52dfe = getentarray(0, "sndMusicTrig", "targetname");
    array::thread_all(var_13a52dfe, &function_60a32834);
}

// Namespace zm_cosmodrome_amb
// Params 0, eflags: 0x1 linked
// Checksum 0x7f3c610a, Offset: 0xc40
// Size: 0x94
function function_60a32834() {
    while (true) {
        trigplayer = self waittill(#"trigger");
        if (trigplayer islocalplayer()) {
            level notify(#"hash_51d7bc7c", self.script_sound);
            while (isdefined(trigplayer) && trigplayer istouching(self)) {
                wait 0.016;
            }
            continue;
        }
        wait 0.016;
    }
}

// Namespace zm_cosmodrome_amb
// Params 0, eflags: 0x1 linked
// Checksum 0x70431b36, Offset: 0xce0
// Size: 0xf8
function function_d667714e() {
    level.var_b6342abd = "mus_cosmo_underscore_default";
    level.var_6d9d81aa = "mus_cosmo_underscore_default";
    level.var_eb526c90 = spawn(0, (0, 0, 0), "script_origin");
    level.var_9433cf5a = level.var_eb526c90 playloopsound(level.var_b6342abd, 2);
    while (true) {
        location = level waittill(#"hash_51d7bc7c");
        level.var_6d9d81aa = "mus_cosmo_underscore_" + location;
        if (level.var_6d9d81aa != level.var_b6342abd) {
            level thread function_b234849(level.var_6d9d81aa);
            level.var_b6342abd = level.var_6d9d81aa;
        }
    }
}

// Namespace zm_cosmodrome_amb
// Params 1, eflags: 0x1 linked
// Checksum 0xa3b29f2, Offset: 0xde0
// Size: 0x64
function function_b234849(var_6d9d81aa) {
    level endon(#"hash_51d7bc7c");
    level.var_eb526c90 stopallloopsounds(2);
    wait 1;
    level.var_9433cf5a = level.var_eb526c90 playloopsound(var_6d9d81aa, 2);
}

// Namespace zm_cosmodrome_amb
// Params 0, eflags: 0x1 linked
// Checksum 0xecbaccd2, Offset: 0xe50
// Size: 0x1ac
function amb_power_up() {
    wait 2;
    level.var_41176517 = struct::get_array("amb_computer", "targetname");
    level waittill(#"power_on");
    level.var_39f6798 = struct::get("amb_power_up", "targetname");
    if (isdefined(level.var_39f6798)) {
        playsound(0, level.var_39f6798.script_sound, level.var_39f6798.origin);
    }
    wait 4;
    if (isdefined(level.var_41176517)) {
        for (i = 0; i < level.var_41176517.size; i++) {
            wait randomfloatrange(0.1, 0.25);
            playsound(0, level.var_41176517[i].script_soundalias, level.var_41176517[i].origin);
        }
    }
    level notify(#"hash_562bd5c4");
    level thread function_729f3d20();
    if (isdefined(level.var_39f6798)) {
        audio::playloopat("evt_power_loop", level.var_39f6798.origin);
    }
}

// Namespace zm_cosmodrome_amb
// Params 0, eflags: 0x1 linked
// Checksum 0xf3e15566, Offset: 0x1008
// Size: 0x96
function function_729f3d20() {
    level.var_9a2181e2 = struct::get_array("amb_power_surge", "targetname");
    for (i = 0; i < level.var_9a2181e2.size; i++) {
        audio::playloopat(level.var_9a2181e2[i].script_sound, level.var_9a2181e2[i].origin);
    }
}

// Namespace zm_cosmodrome_amb
// Params 0, eflags: 0x1 linked
// Checksum 0x2d3ac81f, Offset: 0x10a8
// Size: 0x15c
function startzmbspawnersoundloops() {
    loopers = struct::get_array("exterior_goal", "targetname");
    if (isdefined(loopers) && loopers.size > 0) {
        delay = 0;
        /#
            if (getdvarint("<dev string:x28>") > 0) {
                println("<dev string:x34>" + loopers.size + "<dev string:x6c>");
            }
        #/
        for (i = 0; i < loopers.size; i++) {
            loopers[i] thread soundloopthink();
            delay += 1;
            if (delay % 20 == 0) {
                wait 0.016;
            }
        }
        return;
    }
    /#
        if (getdvarint("<dev string:x28>") > 0) {
            println("<dev string:x77>");
        }
    #/
}

// Namespace zm_cosmodrome_amb
// Params 0, eflags: 0x1 linked
// Checksum 0x8109c1de, Offset: 0x1210
// Size: 0x16c
function soundloopthink() {
    if (!isdefined(self.origin)) {
        return;
    }
    if (!isdefined(self.script_sound)) {
        self.script_sound = "zmb_spawn_walla";
    }
    notifyname = "";
    assert(isdefined(notifyname));
    if (isdefined(self.script_string)) {
        notifyname = self.script_string;
    }
    assert(isdefined(notifyname));
    started = 1;
    if (isdefined(self.script_int)) {
        started = self.script_int != 0;
    }
    if (started) {
        soundloopemitter(self.script_sound, self.origin);
    }
    if (notifyname != "") {
        for (;;) {
            level waittill(notifyname);
            if (started) {
                soundstoploopemitter(self.script_sound, self.origin);
            } else {
                soundloopemitter(self.script_sound, self.origin);
            }
            started = !started;
        }
    }
}

