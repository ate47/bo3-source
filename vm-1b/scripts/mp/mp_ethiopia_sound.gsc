#using scripts/codescripts/struct;
#using scripts/shared/audio_shared;

#namespace mp_ethiopia_sound;

// Namespace mp_ethiopia_sound
// Params 0, eflags: 0x0
// Checksum 0xa9a27788, Offset: 0x108
// Size: 0x32
function main() {
    level thread function_a601dc4f();
    level thread function_c7368d93();
    level thread function_f6802baa();
}

// Namespace mp_ethiopia_sound
// Params 0, eflags: 0x0
// Checksum 0x2888f7bb, Offset: 0x148
// Size: 0x81
function function_a601dc4f() {
    trigger = getent("snd_monkey", "targetname");
    if (!isdefined(trigger)) {
        return;
    }
    while (true) {
        trigger waittill(#"trigger", who);
        if (isplayer(who)) {
            trigger playsound("amb_monkey_shot");
            wait 15;
        }
    }
}

// Namespace mp_ethiopia_sound
// Params 0, eflags: 0x0
// Checksum 0xd5a026b8, Offset: 0x1d8
// Size: 0x81
function function_c7368d93() {
    trigger = getent("snd_cheet", "targetname");
    if (!isdefined(trigger)) {
        return;
    }
    while (true) {
        trigger waittill(#"trigger", who);
        if (isplayer(who)) {
            trigger playsound("amb_cheeta_shot");
            wait 15;
        }
    }
}

// Namespace mp_ethiopia_sound
// Params 0, eflags: 0x0
// Checksum 0x2238f61b, Offset: 0x268
// Size: 0x81
function function_f6802baa() {
    trigger = getent("snd_boar", "targetname");
    if (!isdefined(trigger)) {
        return;
    }
    while (true) {
        trigger waittill(#"trigger", who);
        if (isplayer(who)) {
            trigger playsound("amb_boar_shot");
            wait 15;
        }
    }
}

