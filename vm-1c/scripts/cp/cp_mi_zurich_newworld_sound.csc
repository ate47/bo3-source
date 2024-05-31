#using scripts/shared/audio_shared;
#using scripts/codescripts/struct;

#namespace namespace_b5a65bd6;

// Namespace namespace_b5a65bd6
// Params 0, eflags: 0x1 linked
// namespace_b5a65bd6<file_0>::function_d290ebfa
// Checksum 0x4f54b8dd, Offset: 0x158
// Size: 0x64
function main() {
    level thread function_9f9f219();
    level thread function_cfd80c1b();
    level thread function_166fca02();
    level thread function_694458bd();
}

// Namespace namespace_b5a65bd6
// Params 0, eflags: 0x1 linked
// namespace_b5a65bd6<file_0>::function_9f9f219
// Checksum 0x853c4ae, Offset: 0x1c8
// Size: 0xb4
function function_9f9f219() {
    trigger = getent(0, "security_det", "targetname");
    if (!isdefined(trigger)) {
        return;
    }
    while (true) {
        who = trigger waittill(#"trigger");
        if (who isplayer()) {
            playsound(0, "amb_security_detector", (-10363, -24283, 9450));
            break;
        }
    }
}

// Namespace namespace_b5a65bd6
// Params 0, eflags: 0x1 linked
// namespace_b5a65bd6<file_0>::function_cfd80c1b
// Checksum 0x436033a7, Offset: 0x288
// Size: 0xb4
function function_cfd80c1b() {
    trigger = getent(0, "horn", "targetname");
    if (!isdefined(trigger)) {
        return;
    }
    while (true) {
        who = trigger waittill(#"trigger");
        if (who isplayer()) {
            playsound(0, "amb_train_horn_distant", (21054, -3421, -6031));
            break;
        }
    }
}

// Namespace namespace_b5a65bd6
// Params 0, eflags: 0x1 linked
// namespace_b5a65bd6<file_0>::function_166fca02
// Checksum 0x917a0b21, Offset: 0x348
// Size: 0xb4
function function_166fca02() {
    trigger = getent(0, "train_horn_dist", "targetname");
    if (!isdefined(trigger)) {
        return;
    }
    while (true) {
        who = trigger waittill(#"trigger");
        if (who isplayer()) {
            playsound(0, "amb_train_horn_distant", (-13099, -18453, 10228));
            break;
        }
    }
}

// Namespace namespace_b5a65bd6
// Params 0, eflags: 0x1 linked
// namespace_b5a65bd6<file_0>::function_694458bd
// Checksum 0xd5aa6127, Offset: 0x408
// Size: 0xcc
function function_694458bd() {
    soundloopemitter("amb_wind_tarp", (-17754, 15606, 4288));
    soundloopemitter("amb_wind_door", (-12556, 15887, 4201));
    soundloopemitter("amb_wind_door", (-12164, 15338, 4207));
    soundloopemitter("anb_snow_plow", (-14268, 15963, 4248));
    soundloopemitter("anb_snow_plow", (-14281, 15331, 4235));
}

// Namespace namespace_b5a65bd6
// Params 7, eflags: 0x1 linked
// namespace_b5a65bd6<file_0>::function_98d2df25
// Checksum 0x48b38d9f, Offset: 0x4e0
// Size: 0xc8
function function_98d2df25(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval == 1) {
        setsoundcontext("train", "country");
        return;
    }
    if (newval == 2) {
        setsoundcontext("train", "city");
        return;
    }
    setsoundcontext("train", "tunnel");
}

