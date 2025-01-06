#using scripts/codescripts/struct;
#using scripts/shared/array_shared;
#using scripts/shared/audio_shared;

#namespace mp_aerospace_sound;

// Namespace mp_aerospace_sound
// Params 0, eflags: 0x0
// Checksum 0xeba239a3, Offset: 0x150
// Size: 0x64
function main() {
    level thread function_35d16305();
    level thread function_5bd3dd6e();
    level thread function_81d657d7();
    level thread function_77c4fef8();
}

// Namespace mp_aerospace_sound
// Params 0, eflags: 0x0
// Checksum 0xed916cb, Offset: 0x1c0
// Size: 0xb6
function function_35d16305() {
    trigger = getent(0, "alarm_1", "targetname");
    if (!isdefined(trigger)) {
        return;
    }
    while (true) {
        trigger waittill(#"trigger", who);
        if (who isplayer()) {
            playsound(0, "amb_detector_beep_1", (-834, -2675, 120));
            wait 2;
        }
    }
}

// Namespace mp_aerospace_sound
// Params 0, eflags: 0x0
// Checksum 0x2cd55d2e, Offset: 0x280
// Size: 0xb6
function function_5bd3dd6e() {
    trigger = getent(0, "alarm_2", "targetname");
    if (!isdefined(trigger)) {
        return;
    }
    while (true) {
        trigger waittill(#"trigger", who);
        if (who isplayer()) {
            playsound(0, "amb_detector_beep_2", (-1042, -2677, 119));
            wait 2;
        }
    }
}

// Namespace mp_aerospace_sound
// Params 0, eflags: 0x0
// Checksum 0x7c5baa85, Offset: 0x340
// Size: 0xb6
function function_81d657d7() {
    trigger = getent(0, "alarm_3", "targetname");
    if (!isdefined(trigger)) {
        return;
    }
    while (true) {
        trigger waittill(#"trigger", who);
        if (who isplayer()) {
            playsound(0, "amb_detector_beep_3", (-834, -2675, 120));
            wait 2;
        }
    }
}

// Namespace mp_aerospace_sound
// Params 0, eflags: 0x0
// Checksum 0xa93ce942, Offset: 0x400
// Size: 0xb6
function function_77c4fef8() {
    trigger = getent(0, "alarm_4", "targetname");
    if (!isdefined(trigger)) {
        return;
    }
    while (true) {
        trigger waittill(#"trigger", who);
        if (who isplayer()) {
            playsound(0, "amb_detector_beep_4", (-1042, -2677, 119));
            wait 2;
        }
    }
}

