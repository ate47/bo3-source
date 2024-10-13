#using scripts/shared/music_shared;
#using scripts/shared/util_shared;
#using scripts/shared/trigger_shared;
#using scripts/shared/system_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/array_shared;
#using scripts/shared/clientfield_shared;
#using scripts/codescripts/struct;

#namespace zm_castle_amb;

// Namespace zm_castle_amb
// Params 0, eflags: 0x1 linked
// Checksum 0x8a20538a, Offset: 0x238
// Size: 0x4c
function main() {
    thread startzmbspawnersoundloops();
    thread function_163d3651();
    thread function_509ffc62();
    level thread function_bab3ea62();
}

// Namespace zm_castle_amb
// Params 0, eflags: 0x1 linked
// Checksum 0x793f76cd, Offset: 0x290
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

// Namespace zm_castle_amb
// Params 0, eflags: 0x1 linked
// Checksum 0x54ed277a, Offset: 0x3f8
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

// Namespace zm_castle_amb
// Params 0, eflags: 0x1 linked
// Checksum 0x97737954, Offset: 0x570
// Size: 0xcc
function function_163d3651() {
    soundloopemitter("zmb_spawn_undercroft_walla", (-508, 1615, 110));
    soundloopemitter("zmb_spawn_undercroft_walla", (607, 2189, -94));
    soundloopemitter("zmb_spawn_undercroft_walla", (-1771, 1924, -21));
    soundloopemitter("zmb_spawn_undercroft_walla", (-1730, 2565, -29));
    soundloopemitter("zmb_spawn_undercroft_walla", (-828, 2911, 261));
}

// Namespace zm_castle_amb
// Params 0, eflags: 0x1 linked
// Checksum 0x32c06aa6, Offset: 0x648
// Size: 0x7c
function function_509ffc62() {
    soundloopemitter("amb_radio_2", (-1080, 1625, 856));
    soundloopemitter("amb_radio_beep", (-1006, 1578, 856));
    soundloopemitter("amb_radio_3", (-1365, 1332, 856));
}

// Namespace zm_castle_amb
// Params 0, eflags: 0x1 linked
// Checksum 0x853c7f2a, Offset: 0x6d0
// Size: 0x74
function function_bab3ea62() {
    wait 3;
    level thread function_53b9afad();
    var_29085ef = getentarray(0, "sndMusicTrig", "targetname");
    array::thread_all(var_29085ef, &sndMusicTrig);
}

// Namespace zm_castle_amb
// Params 0, eflags: 0x1 linked
// Checksum 0xa4f71712, Offset: 0x750
// Size: 0x94
function sndMusicTrig() {
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

// Namespace zm_castle_amb
// Params 0, eflags: 0x1 linked
// Checksum 0x766fde2d, Offset: 0x7f0
// Size: 0xe2
function function_53b9afad() {
    var_b6342abd = "mus_castle_underscore_gondola";
    var_6d9d81aa = "mus_castle_underscore_gondola";
    level.var_eb526c90 = spawn(0, (0, 0, 0), "script_origin");
    level.var_9433cf5a = level.var_eb526c90 playloopsound(var_b6342abd, 2);
    while (true) {
        location = level waittill(#"hash_51d7bc7c");
        var_6d9d81aa = "mus_castle_underscore_" + location;
        if (var_6d9d81aa != var_b6342abd) {
            level thread function_51d7bc7c(var_6d9d81aa);
            var_b6342abd = var_6d9d81aa;
        }
    }
}

// Namespace zm_castle_amb
// Params 1, eflags: 0x1 linked
// Checksum 0xc60dc07c, Offset: 0x8e0
// Size: 0x64
function function_51d7bc7c(var_6d9d81aa) {
    level endon(#"hash_51d7bc7c");
    level.var_eb526c90 stopallloopsounds(2);
    wait 1;
    level.var_9433cf5a = level.var_eb526c90 playloopsound(var_6d9d81aa, 2);
}

