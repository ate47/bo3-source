#using scripts/codescripts/struct;

#namespace namespace_5f813f0f;

// Namespace namespace_5f813f0f
// Params 0, eflags: 0x1 linked
// Checksum 0x877e1b58, Offset: 0xb8
// Size: 0x1c
function main() {
    level thread function_b6d60d2();
}

// Namespace namespace_5f813f0f
// Params 0, eflags: 0x1 linked
// Checksum 0xd411dbb5, Offset: 0xe0
// Size: 0x98
function function_b6d60d2() {
    trigger = getent("snd_chant", "targetname");
    if (!isdefined(trigger)) {
        return;
    }
    while (true) {
        who = trigger waittill(#"trigger");
        if (isplayer(who)) {
            trigger playsound("amb_monk_chant");
        }
    }
}

