#using scripts/codescripts/struct;
#using scripts/shared/array_shared;
#using scripts/shared/audio_shared;
#using scripts/shared/beam_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;

#namespace zm_genesis_sound;

// Namespace zm_genesis_sound
// Params 0, eflags: 0x2
// Checksum 0x7607e26c, Offset: 0x240
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("zm_genesis_sound", &__init__, undefined, undefined);
}

// Namespace zm_genesis_sound
// Params 0, eflags: 0x0
// Checksum 0x75afe19e, Offset: 0x280
// Size: 0x64
function __init__() {
    level thread function_bab3ea62();
    level thread function_849aa028();
    level thread function_101e3e61();
    level thread function_37010187();
}

// Namespace zm_genesis_sound
// Params 0, eflags: 0x0
// Checksum 0x56ddfb18, Offset: 0x2f0
// Size: 0x8c
function function_bab3ea62() {
    wait 3;
    level thread function_53b9afad();
    level thread function_c959aa5f();
    var_29085ef = getentarray(0, "sndMusicTrig", "targetname");
    array::thread_all(var_29085ef, &sndMusicTrig);
}

// Namespace zm_genesis_sound
// Params 0, eflags: 0x0
// Checksum 0xff495fb2, Offset: 0x388
// Size: 0xc4
function sndMusicTrig() {
    while (true) {
        self waittill(#"trigger", trigplayer);
        if (trigplayer islocalplayer()) {
            if (self.script_sound == "pavlov") {
                level notify(#"hash_51d7bc7c", level.var_98f2b64e);
            } else {
                level notify(#"hash_51d7bc7c", self.script_sound);
            }
            while (isdefined(trigplayer) && trigplayer istouching(self)) {
                wait 0.016;
            }
            continue;
        }
        wait 0.016;
    }
}

// Namespace zm_genesis_sound
// Params 0, eflags: 0x0
// Checksum 0x860128de, Offset: 0x458
// Size: 0xf8
function function_53b9afad() {
    level.var_b6342abd = "mus_genesis_underscore_default";
    level.var_6d9d81aa = "mus_genesis_underscore_default";
    level.var_eb526c90 = spawn(0, (0, 0, 0), "script_origin");
    level.var_9433cf5a = level.var_eb526c90 playloopsound(level.var_b6342abd, 2);
    while (true) {
        level waittill(#"hash_51d7bc7c", location);
        level.var_6d9d81aa = "mus_genesis_underscore_" + location;
        if (level.var_6d9d81aa != level.var_b6342abd) {
            level thread function_51d7bc7c(level.var_6d9d81aa);
            level.var_b6342abd = level.var_6d9d81aa;
        }
    }
}

// Namespace zm_genesis_sound
// Params 1, eflags: 0x0
// Checksum 0xaaac21e1, Offset: 0x558
// Size: 0x64
function function_51d7bc7c(var_6d9d81aa) {
    level endon(#"hash_51d7bc7c");
    level.var_eb526c90 stopallloopsounds(2);
    wait 1;
    level.var_9433cf5a = level.var_eb526c90 playloopsound(var_6d9d81aa, 2);
}

// Namespace zm_genesis_sound
// Params 0, eflags: 0x0
// Checksum 0x20f86463, Offset: 0x5c8
// Size: 0x4c
function function_c959aa5f() {
    level waittill(#"zesn");
    level notify(#"stpThm");
    if (isdefined(level.var_eb526c90)) {
        level.var_eb526c90 stopallloopsounds(2);
    }
}

// Namespace zm_genesis_sound
// Params 0, eflags: 0x0
// Checksum 0xe86cec22, Offset: 0x620
// Size: 0x94
function function_849aa028() {
    level.var_6191a71d = undefined;
    level.var_232ff65c = 0;
    level.var_f860f73b = 1;
    level thread function_899d68c0();
    var_29085ef = getentarray(0, "sndMusicTrig", "targetname");
    array::thread_all(var_29085ef, &function_ad9a8fa6);
}

// Namespace zm_genesis_sound
// Params 0, eflags: 0x0
// Checksum 0x83d160ac, Offset: 0x6c0
// Size: 0xf6
function function_ad9a8fa6() {
    level endon("musThemeTriggered" + self.script_sound);
    while (true) {
        self waittill(#"trigger", trigplayer);
        if (self.script_sound == "default" && !(isdefined(level.var_232ff65c) && level.var_232ff65c)) {
            continue;
        }
        if (isdefined(level.var_6191a71d)) {
            continue;
        }
        if (!(isdefined(level.var_f860f73b) && level.var_f860f73b)) {
            continue;
        }
        if (trigplayer islocalplayer()) {
            level thread function_1401492e(trigplayer, self.script_sound);
            level.var_232ff65c = 1;
            level notify("musThemeTriggered" + self.script_sound);
            return;
        }
    }
}

// Namespace zm_genesis_sound
// Params 2, eflags: 0x0
// Checksum 0x51467ef2, Offset: 0x7c0
// Size: 0x6a
function function_1401492e(trigplayer, location) {
    level endon(#"stpThm");
    alias = "mus_genesis_entrytheme_" + location;
    level.var_6191a71d = playsound(0, alias, (0, 0, 0));
    wait 90;
    level.var_6191a71d = undefined;
}

// Namespace zm_genesis_sound
// Params 0, eflags: 0x0
// Checksum 0x249bf102, Offset: 0x838
// Size: 0x6c
function function_899d68c0() {
    while (true) {
        level waittill(#"stpThm");
        if (isdefined(level.var_6191a71d)) {
            stopsound(level.var_6191a71d);
            level.var_6191a71d = undefined;
        }
        level.var_f860f73b = 0;
        level waittill(#"strtthm");
        level.var_f860f73b = 1;
    }
}

// Namespace zm_genesis_sound
// Params 0, eflags: 0x0
// Checksum 0xa7a1cb4e, Offset: 0x8b0
// Size: 0x2c
function function_101e3e61() {
    audio::playloopat("amb_gen_arc_loop", (5014, -1169, 429));
}

// Namespace zm_genesis_sound
// Params 0, eflags: 0x0
// Checksum 0xff1dec77, Offset: 0x8e8
// Size: 0x50
function function_37010187() {
    while (true) {
        wait randomintrange(2, 6);
        playsound(0, "amb_comp_sweets", (4737, -1043, 424));
    }
}

