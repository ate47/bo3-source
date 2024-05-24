#using scripts/shared/array_shared;
#using scripts/shared/audio_shared;
#using scripts/shared/music_shared;
#using scripts/shared/util_shared;
#using scripts/shared/clientfield_shared;
#using scripts/codescripts/struct;

#namespace namespace_c3b98877;

// Namespace namespace_c3b98877
// Params 0, eflags: 0x0
// Checksum 0x31d1fb4f, Offset: 0x258
// Size: 0xdc
function main() {
    level thread function_a96d8fc7();
    level thread function_28416c1e();
    level thread function_b11e8fe8();
    level thread function_3f54bb5();
    level thread function_113b7a0a();
    level thread startzmbspawnersoundloops();
    clientfield::register("scriptmover", "meteor_shrink", 21000, 1, "counter", &function_fb1d31bf, 0, 0);
}

// Namespace namespace_c3b98877
// Params 0, eflags: 0x0
// Checksum 0x599c5c2a, Offset: 0x340
// Size: 0x1e
function function_28416c1e() {
    level waittill(#"hash_b48b3db3");
    level notify(#"hash_91064368");
}

// Namespace namespace_c3b98877
// Params 0, eflags: 0x0
// Checksum 0x444c1da6, Offset: 0x368
// Size: 0xe
function function_a96d8fc7() {
    level.var_15e33496 = undefined;
}

// Namespace namespace_c3b98877
// Params 1, eflags: 0x0
// Checksum 0x34dc33de, Offset: 0x380
// Size: 0x6c
function function_418a175a(var_ef677c68) {
    playsound(0, "evt_sq_gen_transition", (0, 0, 0));
    setsoundcontext("aquifer_cockpit", "active");
    audio::playloopat("evt_sq_gen_bg", (0, 0, 0));
}

// Namespace namespace_c3b98877
// Params 3, eflags: 0x0
// Checksum 0xc24a6a0d, Offset: 0x3f8
// Size: 0x9c
function function_e3a6a660(bnewent, binitialsnap, bwasdemojump) {
    if (!bnewent && !binitialsnap && !bwasdemojump) {
        playsound(0, "evt_sq_gen_transition", (0, 0, 0));
    }
    setsoundcontext("aquifer_cockpit", "");
    audio::stoploopat("evt_sq_gen_bg", (0, 0, 0));
}

// Namespace namespace_c3b98877
// Params 0, eflags: 0x0
// Checksum 0xd232cc20, Offset: 0x4a0
// Size: 0x34
function function_b11e8fe8() {
    level thread function_e2433f87(0);
    level thread function_e2433f87(1);
}

// Namespace namespace_c3b98877
// Params 1, eflags: 0x0
// Checksum 0x80b4f551, Offset: 0x4e0
// Size: 0x58
function function_e2433f87(num) {
    while (true) {
        level waittill("ge" + num);
        level notify("evt_geyser_blast_" + num);
        wait(14.5);
        level notify("evt_geyser_blast_" + num);
    }
}

// Namespace namespace_c3b98877
// Params 7, eflags: 0x0
// Checksum 0x737d4442, Offset: 0x540
// Size: 0x6c
function function_fb1d31bf(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    audio::snd_set_snapshot("zmb_temple_egg");
    level thread function_762642a6();
}

// Namespace namespace_c3b98877
// Params 0, eflags: 0x0
// Checksum 0xeeb455c4, Offset: 0x5b8
// Size: 0x54
function function_762642a6() {
    wait(5.5);
    if (isdefined(level.var_15e33496)) {
        audio::snd_set_snapshot("zmb_temple_sq");
        return;
    }
    audio::snd_set_snapshot("default");
}

// Namespace namespace_c3b98877
// Params 0, eflags: 0x0
// Checksum 0x99a42b81, Offset: 0x618
// Size: 0x2c
function function_3f54bb5() {
    level waittill(#"zesn");
    audio::snd_set_snapshot("zmb_temple_egg");
}

// Namespace namespace_c3b98877
// Params 0, eflags: 0x0
// Checksum 0x7f6162af, Offset: 0x650
// Size: 0x24
function function_113b7a0a() {
    audio::snd_play_auto_fx("fx_ztem_torch", "amb_fire_medium");
}

// Namespace namespace_c3b98877
// Params 0, eflags: 0x0
// Checksum 0xe6879b3d, Offset: 0x680
// Size: 0x94
function function_60a32834() {
    while (true) {
        trigplayer = self waittill(#"trigger");
        if (trigplayer islocalplayer()) {
            level notify(#"hash_51d7bc7c", self.script_sound);
            while (isdefined(trigplayer) && trigplayer istouching(self)) {
                wait(0.016);
            }
            continue;
        }
        wait(0.016);
    }
}

// Namespace namespace_c3b98877
// Params 0, eflags: 0x0
// Checksum 0x9beea0ce, Offset: 0x720
// Size: 0xf8
function function_d667714e() {
    level.var_b6342abd = "mus_temple_underscore_default";
    level.var_6d9d81aa = "mus_temple_underscore_default";
    level.var_eb526c90 = spawn(0, (0, 0, 0), "script_origin");
    level.var_9433cf5a = level.var_eb526c90 playloopsound(level.var_b6342abd, 2);
    while (true) {
        location = level waittill(#"hash_51d7bc7c");
        level.var_6d9d81aa = "mus_temple_underscore_" + location;
        if (level.var_6d9d81aa != level.var_b6342abd) {
            level thread function_b234849(level.var_6d9d81aa);
            level.var_b6342abd = level.var_6d9d81aa;
        }
    }
}

// Namespace namespace_c3b98877
// Params 1, eflags: 0x0
// Checksum 0x602551ba, Offset: 0x820
// Size: 0x64
function function_b234849(var_6d9d81aa) {
    level endon(#"hash_51d7bc7c");
    level.var_eb526c90 stopallloopsounds(2);
    wait(1);
    level.var_9433cf5a = level.var_eb526c90 playloopsound(var_6d9d81aa, 2);
}

// Namespace namespace_c3b98877
// Params 0, eflags: 0x0
// Checksum 0x1b4285b8, Offset: 0x890
// Size: 0x15c
function startzmbspawnersoundloops() {
    loopers = struct::get_array("exterior_goal", "targetname");
    if (isdefined(loopers) && loopers.size > 0) {
        delay = 0;
        /#
            if (getdvarint("<unknown string>") > 0) {
                println("<unknown string>" + loopers.size + "<unknown string>");
            }
        #/
        for (i = 0; i < loopers.size; i++) {
            loopers[i] thread soundloopthink();
            delay += 1;
            if (delay % 20 == 0) {
                wait(0.016);
            }
        }
        return;
    }
    /#
        if (getdvarint("<unknown string>") > 0) {
            println("<unknown string>");
        }
    #/
}

// Namespace namespace_c3b98877
// Params 0, eflags: 0x0
// Checksum 0x88d1e5a3, Offset: 0x9f8
// Size: 0x16c
function soundloopthink() {
    if (!isdefined(self.origin)) {
        return;
    }
    if (!isdefined(self.script_sound)) {
        self.script_sound = "zmb_spawn_walla";
    }
    notifyname = "";
    /#
        assert(isdefined(notifyname));
    #/
    if (isdefined(self.script_string)) {
        notifyname = self.script_string;
    }
    /#
        assert(isdefined(notifyname));
    #/
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

