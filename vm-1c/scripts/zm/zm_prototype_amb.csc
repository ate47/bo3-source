#using scripts/codescripts/struct;
#using scripts/shared/array_shared;
#using scripts/shared/audio_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/music_shared;
#using scripts/shared/util_shared;

#namespace zm_prototype_amb;

// Namespace zm_prototype_amb
// Params 0, eflags: 0x0
// Checksum 0x22d1981b, Offset: 0x1b8
// Size: 0x1c
function main() {
    level thread startzmbspawnersoundloops();
}

// Namespace zm_prototype_amb
// Params 0, eflags: 0x0
// Checksum 0xf3237079, Offset: 0x1e0
// Size: 0x74
function function_c9207335() {
    wait 3;
    level thread function_d667714e();
    var_13a52dfe = getentarray(0, "sndMusicTrig", "targetname");
    array::thread_all(var_13a52dfe, &function_60a32834);
}

// Namespace zm_prototype_amb
// Params 0, eflags: 0x0
// Checksum 0xc1b3fbae, Offset: 0x260
// Size: 0x94
function function_60a32834() {
    while (true) {
        self waittill(#"trigger", trigplayer);
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

// Namespace zm_prototype_amb
// Params 0, eflags: 0x0
// Checksum 0x231f953e, Offset: 0x300
// Size: 0xf8
function function_d667714e() {
    level.var_b6342abd = "mus_prototype_underscore_default";
    level.var_6d9d81aa = "mus_prototype_underscore_default";
    level.var_eb526c90 = spawn(0, (0, 0, 0), "script_origin");
    level.var_9433cf5a = level.var_eb526c90 playloopsound(level.var_b6342abd, 2);
    while (true) {
        level waittill(#"hash_51d7bc7c", location);
        level.var_6d9d81aa = "mus_prototype_underscore_" + location;
        if (level.var_6d9d81aa != level.var_b6342abd) {
            level thread function_b234849(level.var_6d9d81aa);
            level.var_b6342abd = level.var_6d9d81aa;
        }
    }
}

// Namespace zm_prototype_amb
// Params 1, eflags: 0x0
// Checksum 0x8d55a209, Offset: 0x400
// Size: 0x64
function function_b234849(var_6d9d81aa) {
    level endon(#"hash_51d7bc7c");
    level.var_eb526c90 stopallloopsounds(2);
    wait 1;
    level.var_9433cf5a = level.var_eb526c90 playloopsound(var_6d9d81aa, 2);
}

// Namespace zm_prototype_amb
// Params 0, eflags: 0x0
// Checksum 0xeae27673, Offset: 0x470
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

// Namespace zm_prototype_amb
// Params 0, eflags: 0x0
// Checksum 0xdb06ac4f, Offset: 0x5d8
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

