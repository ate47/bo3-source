#using scripts/shared/system_shared;
#using scripts/shared/array_shared;
#using scripts/shared/audio_shared;
#using scripts/shared/music_shared;
#using scripts/shared/util_shared;
#using scripts/shared/clientfield_shared;
#using scripts/codescripts/struct;

#namespace namespace_6d4f3e39;

// Namespace namespace_6d4f3e39
// Params 0, eflags: 0x2
// Checksum 0x5bd6209, Offset: 0x278
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("zm_theater_amb", &__init__, undefined, undefined);
}

// Namespace namespace_6d4f3e39
// Params 0, eflags: 0x1 linked
// Checksum 0x3a47970d, Offset: 0x2b8
// Size: 0x4c
function __init__() {
    clientfield::register("toplayer", "player_dust_mote", 21000, 1, "int", &function_9a4cfd8d, 0, 0);
}

// Namespace namespace_6d4f3e39
// Params 0, eflags: 0x1 linked
// Checksum 0x7bd2cc66, Offset: 0x310
// Size: 0x2c
function main() {
    thread power_on_all();
    level thread function_c9207335();
}

// Namespace namespace_6d4f3e39
// Params 0, eflags: 0x1 linked
// Checksum 0xa00e73ae, Offset: 0x348
// Size: 0xe4
function power_on_all() {
    wait(0.016);
    if (!level clientfield::get("zombie_power_on")) {
        level waittill(#"zpo");
    }
    level thread function_732fa769();
    level thread function_355e59e9();
    level thread function_67082bfc();
    level thread function_b326f234();
    level thread function_f63f4ce8();
    level thread function_8a1e1d56();
    level thread function_24ac75e();
}

// Namespace namespace_6d4f3e39
// Params 0, eflags: 0x1 linked
// Checksum 0x6ca9990a, Offset: 0x438
// Size: 0x54
function function_732fa769() {
    var_d479a790 = struct::get_array("telepad", "targetname");
    array::thread_all(var_d479a790, &function_fcf63df8);
}

// Namespace namespace_6d4f3e39
// Params 0, eflags: 0x1 linked
// Checksum 0x3282f914, Offset: 0x498
// Size: 0xa8
function function_fcf63df8() {
    var_276703f8 = 2;
    while (true) {
        level waittill(#"hash_b195b712");
        if (isdefined(self.script_sound)) {
            playsound(0, "evt_" + self.script_sound + "_warmup", self.origin);
            wait(var_276703f8);
            playsound(0, "evt_" + self.script_sound + "_cooldown", self.origin);
        }
    }
}

// Namespace namespace_6d4f3e39
// Params 0, eflags: 0x1 linked
// Checksum 0x206c4e12, Offset: 0x548
// Size: 0x60
function function_355e59e9() {
    while (true) {
        level waittill(#"hash_27baeeb5");
        playsound(0, "evt_teleport_2d_fnt", (0, 0, 0));
        playsound(0, "evt_teleport_2d_rear", (0, 0, 0));
    }
}

// Namespace namespace_6d4f3e39
// Params 0, eflags: 0x1 linked
// Checksum 0x75c2a0d0, Offset: 0x5b0
// Size: 0x88
function function_67082bfc() {
    while (true) {
        level waittill(#"hash_cd38a321");
        playsound(0, "evt_pad_warmup_2d", (0, 0, 0));
        wait(1.3);
        playsound(0, "evt_teleport_2d_fnt", (0, 0, 0));
        playsound(0, "evt_teleport_2d_rear", (0, 0, 0));
    }
}

// Namespace namespace_6d4f3e39
// Params 0, eflags: 0x1 linked
// Checksum 0x360d298f, Offset: 0x640
// Size: 0x40
function function_b326f234() {
    while (true) {
        level waittill(#"hash_efa01d95");
        playsound(0, "evt_beam_fx_2d", (0, 0, 0));
    }
}

// Namespace namespace_6d4f3e39
// Params 0, eflags: 0x1 linked
// Checksum 0xd0228348, Offset: 0x688
// Size: 0x40
function function_f63f4ce8() {
    while (true) {
        level waittill(#"hash_9054c3cd");
        playsound(0, "evt_pad_warmup_2d", (0, 0, 0));
    }
}

// Namespace namespace_6d4f3e39
// Params 0, eflags: 0x1 linked
// Checksum 0xfb472ef0, Offset: 0x6d0
// Size: 0x60
function function_8a1e1d56() {
    while (true) {
        level waittill(#"hash_587280b9");
        playsound(0, "evt_teleport_2d_fnt", (0, 0, 0));
        playsound(0, "evt_teleport_2d_rear", (0, 0, 0));
    }
}

// Namespace namespace_6d4f3e39
// Params 0, eflags: 0x1 linked
// Checksum 0x3e14252c, Offset: 0x738
// Size: 0x74
function function_c9207335() {
    wait(3);
    level thread function_d667714e();
    var_13a52dfe = getentarray(0, "sndMusicTrig", "targetname");
    array::thread_all(var_13a52dfe, &function_60a32834);
}

// Namespace namespace_6d4f3e39
// Params 0, eflags: 0x1 linked
// Checksum 0x82a3fed4, Offset: 0x7b8
// Size: 0x94
function function_60a32834() {
    while (true) {
        trigplayer = self waittill(#"trigger");
        if (trigplayer islocalplayer()) {
            level notify(#"hash_51d7bc7c", self.script_sound);
            while (isdefined(trigplayer) && trigplayer istouching(self)) {
                wait(0.016);
            }
            continue;
        }
        wait(0.016);
    }
}

// Namespace namespace_6d4f3e39
// Params 0, eflags: 0x1 linked
// Checksum 0xe85f7801, Offset: 0x858
// Size: 0xf8
function function_d667714e() {
    level.var_b6342abd = "mus_theater_underscore_default";
    level.var_6d9d81aa = "mus_theater_underscore_default";
    level.var_eb526c90 = spawn(0, (0, 0, 0), "script_origin");
    level.var_9433cf5a = level.var_eb526c90 playloopsound(level.var_b6342abd, 2);
    while (true) {
        location = level waittill(#"hash_51d7bc7c");
        level.var_6d9d81aa = "mus_theater_underscore_" + location;
        if (level.var_6d9d81aa != level.var_b6342abd) {
            level thread function_b234849(level.var_6d9d81aa);
            level.var_b6342abd = level.var_6d9d81aa;
        }
    }
}

// Namespace namespace_6d4f3e39
// Params 1, eflags: 0x1 linked
// Checksum 0xefeb6e0f, Offset: 0x958
// Size: 0x64
function function_b234849(var_6d9d81aa) {
    level endon(#"hash_51d7bc7c");
    level.var_eb526c90 stopallloopsounds(2);
    wait(1);
    level.var_9433cf5a = level.var_eb526c90 playloopsound(var_6d9d81aa, 2);
}

// Namespace namespace_6d4f3e39
// Params 0, eflags: 0x1 linked
// Checksum 0x6600c761, Offset: 0x9c8
// Size: 0x2c
function function_24ac75e() {
    audio::playloopat("amb_kino_movie", (-1, 1185, 474));
}

// Namespace namespace_6d4f3e39
// Params 7, eflags: 0x1 linked
// Checksum 0xcd376bd1, Offset: 0xa00
// Size: 0xae
function function_9a4cfd8d(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
    if (newval) {
        self.var_5fb5b46e = playfxoncamera(localclientnum, level._effect["player_dust_motes"]);
        return;
    }
    if (isdefined(self.var_5fb5b46e)) {
        killfx(localclientnum, self.var_5fb5b46e);
        self.var_5fb5b46e = undefined;
    }
}

