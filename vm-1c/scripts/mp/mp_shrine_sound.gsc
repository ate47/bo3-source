#using scripts/codescripts/struct;

#namespace namespace_704c92f4;

// Namespace namespace_704c92f4
// Params 0, eflags: 0x1 linked
// Checksum 0x746d049a, Offset: 0xb8
// Size: 0x1c
function main() {
    level thread function_12a90c0c();
}

// Namespace namespace_704c92f4
// Params 0, eflags: 0x1 linked
// Checksum 0xa1cee95e, Offset: 0xe0
// Size: 0x9e
function function_12a90c0c() {
    trigger = getent("snd_knights", "targetname");
    if (!isdefined(trigger)) {
        return;
    }
    while (true) {
        who = trigger waittill(#"trigger");
        if (isplayer(who)) {
            trigger playsound("amb_knights");
            wait(300);
        }
    }
}

