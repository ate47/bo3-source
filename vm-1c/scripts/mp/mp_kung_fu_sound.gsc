#using scripts/shared/array_shared;
#using scripts/shared/audio_shared;
#using scripts/codescripts/struct;

#namespace namespace_b19eb620;

// Namespace namespace_b19eb620
// Params 0, eflags: 0x1 linked
// namespace_b19eb620<file_0>::function_d290ebfa
// Checksum 0xaa730e1f, Offset: 0x138
// Size: 0x64
function main() {
    level thread function_3fbccede();
    level thread function_19ba5475();
    level thread function_f3b7da0c();
    level thread function_cdb55fa3();
}

// Namespace namespace_b19eb620
// Params 0, eflags: 0x1 linked
// namespace_b19eb620<file_0>::function_3fbccede
// Checksum 0xe1b40f71, Offset: 0x1a8
// Size: 0x98
function function_3fbccede() {
    trigger = getent("snd_gong_1", "targetname");
    if (!isdefined(trigger)) {
        return;
    }
    while (true) {
        who = trigger waittill(#"trigger");
        if (isplayer(who)) {
            trigger playsound("amb_gong_1");
        }
    }
}

// Namespace namespace_b19eb620
// Params 0, eflags: 0x1 linked
// namespace_b19eb620<file_0>::function_19ba5475
// Checksum 0x369e041d, Offset: 0x248
// Size: 0x98
function function_19ba5475() {
    trigger = getent("snd_gong_2", "targetname");
    if (!isdefined(trigger)) {
        return;
    }
    while (true) {
        who = trigger waittill(#"trigger");
        if (isplayer(who)) {
            trigger playsound("amb_gong_2");
        }
    }
}

// Namespace namespace_b19eb620
// Params 0, eflags: 0x1 linked
// namespace_b19eb620<file_0>::function_f3b7da0c
// Checksum 0x1fdef59d, Offset: 0x2e8
// Size: 0x98
function function_f3b7da0c() {
    trigger = getent("snd_gong_3", "targetname");
    if (!isdefined(trigger)) {
        return;
    }
    while (true) {
        who = trigger waittill(#"trigger");
        if (isplayer(who)) {
            trigger playsound("amb_gong_3");
        }
    }
}

// Namespace namespace_b19eb620
// Params 0, eflags: 0x1 linked
// namespace_b19eb620<file_0>::function_cdb55fa3
// Checksum 0x4c0bb51f, Offset: 0x388
// Size: 0x98
function function_cdb55fa3() {
    trigger = getent("snd_gong_4", "targetname");
    if (!isdefined(trigger)) {
        return;
    }
    while (true) {
        who = trigger waittill(#"trigger");
        if (isplayer(who)) {
            trigger playsound("amb_gong_4");
        }
    }
}

