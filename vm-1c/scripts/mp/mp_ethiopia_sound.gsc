#using scripts/codescripts/struct;
#using scripts/shared/audio_shared;

#namespace mp_ethiopia_sound;

// Namespace mp_ethiopia_sound
// Params 0, eflags: 0x1 linked
// Checksum 0xc6c346d, Offset: 0x108
// Size: 0x4c
function main() {
    level thread function_a601dc4f();
    level thread function_c7368d93();
    level thread function_f6802baa();
}

// Namespace mp_ethiopia_sound
// Params 0, eflags: 0x1 linked
// Checksum 0x14146546, Offset: 0x160
// Size: 0x9e
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
// Params 0, eflags: 0x1 linked
// Checksum 0x3fcf38f, Offset: 0x208
// Size: 0x9e
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
// Params 0, eflags: 0x1 linked
// Checksum 0xc97a31f, Offset: 0x2b0
// Size: 0x9e
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

