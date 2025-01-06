#using scripts/codescripts/struct;
#using scripts/shared/array_shared;
#using scripts/shared/audio_shared;

#namespace mp_kung_fu_sound;

// Namespace mp_kung_fu_sound
// Params 0, eflags: 0x0
// Checksum 0x72f9f5f1, Offset: 0x138
// Size: 0x64
function main() {
    level thread function_3fbccede();
    level thread function_19ba5475();
    level thread function_f3b7da0c();
    level thread function_cdb55fa3();
}

// Namespace mp_kung_fu_sound
// Params 0, eflags: 0x0
// Checksum 0x722b1bd7, Offset: 0x1a8
// Size: 0x98
function function_3fbccede() {
    trigger = getent("snd_gong_1", "targetname");
    if (!isdefined(trigger)) {
        return;
    }
    while (true) {
        trigger waittill(#"trigger", who);
        if (isplayer(who)) {
            trigger playsound("amb_gong_1");
        }
    }
}

// Namespace mp_kung_fu_sound
// Params 0, eflags: 0x0
// Checksum 0xb45270e6, Offset: 0x248
// Size: 0x98
function function_19ba5475() {
    trigger = getent("snd_gong_2", "targetname");
    if (!isdefined(trigger)) {
        return;
    }
    while (true) {
        trigger waittill(#"trigger", who);
        if (isplayer(who)) {
            trigger playsound("amb_gong_2");
        }
    }
}

// Namespace mp_kung_fu_sound
// Params 0, eflags: 0x0
// Checksum 0x6713591d, Offset: 0x2e8
// Size: 0x98
function function_f3b7da0c() {
    trigger = getent("snd_gong_3", "targetname");
    if (!isdefined(trigger)) {
        return;
    }
    while (true) {
        trigger waittill(#"trigger", who);
        if (isplayer(who)) {
            trigger playsound("amb_gong_3");
        }
    }
}

// Namespace mp_kung_fu_sound
// Params 0, eflags: 0x0
// Checksum 0xc554072a, Offset: 0x388
// Size: 0x98
function function_cdb55fa3() {
    trigger = getent("snd_gong_4", "targetname");
    if (!isdefined(trigger)) {
        return;
    }
    while (true) {
        trigger waittill(#"trigger", who);
        if (isplayer(who)) {
            trigger playsound("amb_gong_4");
        }
    }
}

