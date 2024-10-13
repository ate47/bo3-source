#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/array_shared;

#namespace zm_radio;

// Namespace zm_radio
// Params 0, eflags: 0x2
// Checksum 0x390225a4, Offset: 0x3b8
// Size: 0x3c
function autoexec function_2dc19561() {
    system::register("zm_radio", &__init__, &__main__, undefined);
}

// Namespace zm_radio
// Params 0, eflags: 0x1 linked
// Checksum 0x99ec1590, Offset: 0x400
// Size: 0x4
function __init__() {
    
}

// Namespace zm_radio
// Params 0, eflags: 0x1 linked
// Checksum 0xf6577b17, Offset: 0x410
// Size: 0x114
function __main__() {
    level.var_ce7032d4 = -1;
    str_name = "kzmb";
    str_key = "targetname";
    if (isdefined(level.var_f3b142b3)) {
        str_name = level.var_f3b142b3;
    }
    if (isdefined(level.var_fb3fea57)) {
        key = level.var_fb3fea57;
    }
    var_903fae71 = getentarray(str_name, str_key);
    if (!isdefined(var_903fae71) || !var_903fae71.size) {
        println("<dev string:x28>");
        return;
    }
    println("<dev string:x32>" + var_903fae71.size);
    array::thread_all(var_903fae71, &function_8554d5da);
}

// Namespace zm_radio
// Params 0, eflags: 0x1 linked
// Checksum 0x2ac82485, Offset: 0x530
// Size: 0x172
function function_8554d5da() {
    self setcandamage(1);
    level thread function_4b776d12();
    self thread function_2d4f4459();
    self thread function_f184004e();
    while (true) {
        damage, attacker, dir, loc, type, model, tag, part, weapon, flags = self waittill(#"damage");
        if (!isdefined(attacker) || !isplayer(attacker)) {
            continue;
        }
        if (type == "MOD_PROJECTILE") {
            continue;
        }
        if (type == "MOD_MELEE" || type == "MOD_GRENADE_SPLASH") {
            self notify(#"hash_dec13539");
            continue;
        }
        self notify(#"hash_34d24635");
    }
}

// Namespace zm_radio
// Params 0, eflags: 0x1 linked
// Checksum 0xf8d81c5a, Offset: 0x6b0
// Size: 0xa8
function function_2d4f4459() {
    self.trackname = undefined;
    self.tracknum = 0;
    while (true) {
        self waittill(#"hash_34d24635");
        if (isdefined(self.var_175c09e5)) {
            self stopsound(self.var_175c09e5);
            wait 0.05;
        }
        self playsoundwithnotify("zmb_musicradio_switch", "sounddone");
        self waittill(#"sounddone");
        self thread function_c62f1c37();
    }
}

// Namespace zm_radio
// Params 0, eflags: 0x1 linked
// Checksum 0xa8f28571, Offset: 0x760
// Size: 0x9e
function function_c62f1c37() {
    self endon(#"hash_34d24635");
    self endon(#"hash_dec13539");
    self playsoundwithnotify(level.var_2ec01df2[self.tracknum], "songdone");
    self.var_175c09e5 = level.var_2ec01df2[self.tracknum];
    self.tracknum++;
    if (self.tracknum >= level.var_2ec01df2.size) {
        self.tracknum = 0;
    }
    self waittill(#"songdone");
    self notify(#"hash_34d24635");
}

// Namespace zm_radio
// Params 0, eflags: 0x1 linked
// Checksum 0xc920ea6b, Offset: 0x808
// Size: 0x68
function function_f184004e() {
    while (true) {
        self waittill(#"hash_dec13539");
        self playsoundwithnotify("zmb_musicradio_off", "sounddone");
        if (isdefined(self.var_175c09e5)) {
            self stopsound(self.var_175c09e5);
        }
    }
}

// Namespace zm_radio
// Params 0, eflags: 0x1 linked
// Checksum 0x6663012f, Offset: 0x878
// Size: 0x114
function function_4b776d12() {
    level.var_2ec01df2 = array("mus_radio_track_1", "mus_radio_track_2", "mus_radio_track_3", "mus_radio_track_4", "mus_radio_track_5", "mus_radio_track_6", "mus_radio_track_7", "mus_radio_track_8", "mus_radio_track_9", "mus_radio_track_10", "mus_radio_track_11", "mus_radio_track_12", "mus_radio_track_13", "mus_radio_track_14", "mus_radio_track_15", "mus_radio_track_16", "mus_radio_track_17", "mus_radio_track_18", "mus_radio_track_19", "mus_radio_track_20", "mus_radio_track_21", "mus_radio_track_22", "mus_radio_track_23", "mus_radio_track_24", "mus_radio_track_25", "mus_radio_track_26", "mus_radio_track_27", "mus_radio_track_28", "mus_radio_track_29", "mus_radio_track_30", "mus_radio_track_31");
}

