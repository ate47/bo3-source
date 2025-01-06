#using scripts/codescripts/struct;

#namespace mp_stronghold_sound;

// Namespace mp_stronghold_sound
// Params 0, eflags: 0x0
// Checksum 0xd99180eb, Offset: 0xb8
// Size: 0x12
function main() {
    level thread function_b6d60d2();
}

// Namespace mp_stronghold_sound
// Params 0, eflags: 0x0
// Checksum 0x29b7d8ad, Offset: 0xd8
// Size: 0x7d
function function_b6d60d2() {
    trigger = getent("snd_chant", "targetname");
    if (!isdefined(trigger)) {
        return;
    }
    while (true) {
        trigger waittill(#"trigger", who);
        if (isplayer(who)) {
            trigger playsound("amb_monk_chant");
        }
    }
}

