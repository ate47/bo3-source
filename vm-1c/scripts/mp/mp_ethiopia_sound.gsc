#using scripts/shared/audio_shared;
#using scripts/codescripts/struct;

#namespace namespace_f0d8a318;

// Namespace namespace_f0d8a318
// Params 0, eflags: 0x1 linked
// namespace_f0d8a318<file_0>::function_d290ebfa
// Checksum 0xc6c346d, Offset: 0x108
// Size: 0x4c
function main() {
    level thread function_a601dc4f();
    level thread function_c7368d93();
    level thread function_f6802baa();
}

// Namespace namespace_f0d8a318
// Params 0, eflags: 0x1 linked
// namespace_f0d8a318<file_0>::function_a601dc4f
// Checksum 0x14146546, Offset: 0x160
// Size: 0x9e
function function_a601dc4f() {
    trigger = getent("snd_monkey", "targetname");
    if (!isdefined(trigger)) {
        return;
    }
    while (true) {
        who = trigger waittill(#"trigger");
        if (isplayer(who)) {
            trigger playsound("amb_monkey_shot");
            wait(15);
        }
    }
}

// Namespace namespace_f0d8a318
// Params 0, eflags: 0x1 linked
// namespace_f0d8a318<file_0>::function_c7368d93
// Checksum 0x3fcf38f, Offset: 0x208
// Size: 0x9e
function function_c7368d93() {
    trigger = getent("snd_cheet", "targetname");
    if (!isdefined(trigger)) {
        return;
    }
    while (true) {
        who = trigger waittill(#"trigger");
        if (isplayer(who)) {
            trigger playsound("amb_cheeta_shot");
            wait(15);
        }
    }
}

// Namespace namespace_f0d8a318
// Params 0, eflags: 0x1 linked
// namespace_f0d8a318<file_0>::function_f6802baa
// Checksum 0xc97a31f, Offset: 0x2b0
// Size: 0x9e
function function_f6802baa() {
    trigger = getent("snd_boar", "targetname");
    if (!isdefined(trigger)) {
        return;
    }
    while (true) {
        who = trigger waittill(#"trigger");
        if (isplayer(who)) {
            trigger playsound("amb_boar_shot");
            wait(15);
        }
    }
}

