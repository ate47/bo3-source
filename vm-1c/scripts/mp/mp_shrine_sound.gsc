#using scripts/codescripts/struct;

#namespace mp_shrine_sound;

// Namespace mp_shrine_sound
// Params 0, eflags: 0x0
// Checksum 0x8c0fff56, Offset: 0xb8
// Size: 0x1c
function main() {
    level thread function_12a90c0c();
}

// Namespace mp_shrine_sound
// Params 0, eflags: 0x0
// Checksum 0x65c0487f, Offset: 0xe0
// Size: 0x9e
function function_12a90c0c() {
    trigger = getent("snd_knights", "targetname");
    if (!isdefined(trigger)) {
        return;
    }
    while (true) {
        trigger waittill(#"trigger", who);
        if (isplayer(who)) {
            trigger playsound("amb_knights");
            wait 300;
        }
    }
}

