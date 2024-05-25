#using scripts/shared/array_shared;
#using scripts/shared/audio_shared;
#using scripts/codescripts/struct;

#namespace namespace_8a2f364c;

// Namespace namespace_8a2f364c
// Params 0, eflags: 0x1 linked
// Checksum 0x3a1660c3, Offset: 0x150
// Size: 0x64
function main() {
    level thread function_35d16305();
    level thread function_5bd3dd6e();
    level thread function_81d657d7();
    level thread function_77c4fef8();
}

// Namespace namespace_8a2f364c
// Params 0, eflags: 0x1 linked
// Checksum 0xe3624333, Offset: 0x1c0
// Size: 0xb6
function function_35d16305() {
    trigger = getent(0, "alarm_1", "targetname");
    if (!isdefined(trigger)) {
        return;
    }
    while (true) {
        who = trigger waittill(#"trigger");
        if (who isplayer()) {
            playsound(0, "amb_detector_beep_1", (-834, -2675, 120));
            wait(2);
        }
    }
}

// Namespace namespace_8a2f364c
// Params 0, eflags: 0x1 linked
// Checksum 0xcb447183, Offset: 0x280
// Size: 0xb6
function function_5bd3dd6e() {
    trigger = getent(0, "alarm_2", "targetname");
    if (!isdefined(trigger)) {
        return;
    }
    while (true) {
        who = trigger waittill(#"trigger");
        if (who isplayer()) {
            playsound(0, "amb_detector_beep_2", (-1042, -2677, 119));
            wait(2);
        }
    }
}

// Namespace namespace_8a2f364c
// Params 0, eflags: 0x1 linked
// Checksum 0x8da8372, Offset: 0x340
// Size: 0xb6
function function_81d657d7() {
    trigger = getent(0, "alarm_3", "targetname");
    if (!isdefined(trigger)) {
        return;
    }
    while (true) {
        who = trigger waittill(#"trigger");
        if (who isplayer()) {
            playsound(0, "amb_detector_beep_3", (-834, -2675, 120));
            wait(2);
        }
    }
}

// Namespace namespace_8a2f364c
// Params 0, eflags: 0x1 linked
// Checksum 0x62910629, Offset: 0x400
// Size: 0xb6
function function_77c4fef8() {
    trigger = getent(0, "alarm_4", "targetname");
    if (!isdefined(trigger)) {
        return;
    }
    while (true) {
        who = trigger waittill(#"trigger");
        if (who isplayer()) {
            playsound(0, "amb_detector_beep_4", (-1042, -2677, 119));
            wait(2);
        }
    }
}

