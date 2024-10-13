#using scripts/shared/array_shared;
#using scripts/shared/audio_shared;
#using scripts/shared/music_shared;
#using scripts/shared/util_shared;
#using scripts/shared/clientfield_shared;
#using scripts/codescripts/struct;

#namespace zm_sumpf_amb;

// Namespace zm_sumpf_amb
// Params 0, eflags: 0x1 linked
// Checksum 0x727516f6, Offset: 0x248
// Size: 0x2c
function main() {
    thread function_31ad6633();
    level thread startzmbspawnersoundloops();
}

// Namespace zm_sumpf_amb
// Params 0, eflags: 0x1 linked
// Checksum 0xa36713c8, Offset: 0x280
// Size: 0x38
function function_31ad6633() {
    meteor = audio::playloopat("amb_meteor_loop", (11264, -1920, -592));
}

// Namespace zm_sumpf_amb
// Params 0, eflags: 0x0
// Checksum 0x52c171fc, Offset: 0x2c0
// Size: 0x130
function start_lights() {
    level waittill(#"start_lights");
    wait 2;
    array::thread_all(struct::get_array("electrical_circuit", "targetname"), &function_79a8f6a6);
    playsound(0, "zmb_turn_on", (0, 0, 0));
    wait 3;
    array::thread_all(struct::get_array("electrical_surge", "targetname"), &function_cb4b07ab);
    array::thread_all(struct::get_array("low_buzz", "targetname"), &function_8b318c02);
    var_ee0cf9c7 = audio::playloopat("player_ambience", (0, 0, 0));
}

// Namespace zm_sumpf_amb
// Params 0, eflags: 0x1 linked
// Checksum 0x26f5caaa, Offset: 0x3f8
// Size: 0xcc
function function_cb4b07ab() {
    wait randomfloatrange(1, 4);
    playsound(0, "evt_electrical_surge", self.origin);
    playfx(0, level._effect["electric_short_oneshot"], self.origin);
    wait randomfloatrange(1, 2);
    e1 = audio::playloopat("light", self.origin);
    self function_f46cd9c6();
}

// Namespace zm_sumpf_amb
// Params 0, eflags: 0x1 linked
// Checksum 0xb636d4ae, Offset: 0x4d0
// Size: 0xb8
function function_f46cd9c6() {
    while (true) {
        wait randomfloatrange(4, 15);
        if (randomfloatrange(0, 1) < 0.5) {
            playfx(0, level._effect["electric_short_oneshot"], self.origin);
            playsound(0, "evt_electrical_surge", self.origin);
        }
        wait randomintrange(1, 4);
    }
}

// Namespace zm_sumpf_amb
// Params 0, eflags: 0x1 linked
// Checksum 0xcb0aeccd, Offset: 0x590
// Size: 0x2c
function function_79a8f6a6() {
    wait 1;
    playsound(0, "circuit", self.origin);
}

// Namespace zm_sumpf_amb
// Params 0, eflags: 0x1 linked
// Checksum 0x1f20fe22, Offset: 0x5c8
// Size: 0x30
function function_8b318c02() {
    var_973661fe = audio::playloopat("low_arc", self.origin);
}

// Namespace zm_sumpf_amb
// Params 0, eflags: 0x0
// Checksum 0xf21471da, Offset: 0x600
// Size: 0x74
function function_c9207335() {
    wait 3;
    level thread function_d667714e();
    var_13a52dfe = getentarray(0, "sndMusicTrig", "targetname");
    array::thread_all(var_13a52dfe, &function_60a32834);
}

// Namespace zm_sumpf_amb
// Params 0, eflags: 0x1 linked
// Checksum 0x55cda395, Offset: 0x680
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

// Namespace zm_sumpf_amb
// Params 0, eflags: 0x1 linked
// Checksum 0x2e908dc5, Offset: 0x720
// Size: 0xf8
function function_d667714e() {
    level.var_b6342abd = "mus_sumpf_underscore_default";
    level.var_6d9d81aa = "mus_sumpf_underscore_default";
    level.var_eb526c90 = spawn(0, (0, 0, 0), "script_origin");
    level.var_9433cf5a = level.var_eb526c90 playloopsound(level.var_b6342abd, 2);
    while (true) {
        location = level waittill(#"hash_51d7bc7c");
        level.var_6d9d81aa = "mus_sumpf_underscore_" + location;
        if (level.var_6d9d81aa != level.var_b6342abd) {
            level thread function_b234849(level.var_6d9d81aa);
            level.var_b6342abd = level.var_6d9d81aa;
        }
    }
}

// Namespace zm_sumpf_amb
// Params 1, eflags: 0x1 linked
// Checksum 0xf20f6d7, Offset: 0x820
// Size: 0x64
function function_b234849(var_6d9d81aa) {
    level endon(#"hash_51d7bc7c");
    level.var_eb526c90 stopallloopsounds(2);
    wait 1;
    level.var_9433cf5a = level.var_eb526c90 playloopsound(var_6d9d81aa, 2);
}

// Namespace zm_sumpf_amb
// Params 0, eflags: 0x1 linked
// Checksum 0x5cf78c34, Offset: 0x890
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

// Namespace zm_sumpf_amb
// Params 0, eflags: 0x1 linked
// Checksum 0xe3cad9ae, Offset: 0x9f8
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

