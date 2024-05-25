#using scripts/shared/music_shared;
#using scripts/shared/util_shared;
#using scripts/shared/trigger_shared;
#using scripts/shared/system_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/array_shared;
#using scripts/shared/clientfield_shared;
#using scripts/codescripts/struct;

#namespace namespace_c3257ae1;

// Namespace namespace_c3257ae1
// Params 0, eflags: 0x0
// Checksum 0x93ca3e02, Offset: 0x1d0
// Size: 0x1c
function main() {
    level thread function_bab3ea62();
}

// Namespace namespace_c3257ae1
// Params 0, eflags: 0x0
// Checksum 0x9b5e5b47, Offset: 0x1f8
// Size: 0x74
function function_bab3ea62() {
    level thread function_53b9afad();
    var_29085ef = getentarray(0, "sndMusicTrig", "targetname");
    array::thread_all(var_29085ef, &function_95d61fc1);
}

// Namespace namespace_c3257ae1
// Params 0, eflags: 0x0
// Checksum 0xb9f418fe, Offset: 0x278
// Size: 0x94
function function_95d61fc1() {
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

// Namespace namespace_c3257ae1
// Params 0, eflags: 0x0
// Checksum 0x64bbb2d, Offset: 0x318
// Size: 0xe2
function function_53b9afad() {
    var_b6342abd = "mus_zod_underscore_default";
    var_6d9d81aa = "mus_zod_underscore_default";
    level.var_eb526c90 = spawn(0, (0, 0, 0), "script_origin");
    level.var_9433cf5a = level.var_eb526c90 playloopsound(var_b6342abd, 2);
    while (true) {
        location = level waittill(#"hash_51d7bc7c");
        var_6d9d81aa = "mus_zod_underscore_" + location;
        if (var_6d9d81aa != var_b6342abd) {
            level thread function_51d7bc7c(var_6d9d81aa);
            var_b6342abd = var_6d9d81aa;
        }
    }
}

// Namespace namespace_c3257ae1
// Params 1, eflags: 0x0
// Checksum 0xe9ef3e6d, Offset: 0x408
// Size: 0x64
function function_51d7bc7c(var_6d9d81aa) {
    level endon(#"hash_51d7bc7c");
    level.var_eb526c90 stopallloopsounds(2);
    wait(1);
    level.var_9433cf5a = level.var_eb526c90 playloopsound(var_6d9d81aa, 2);
}

