#using scripts/zm/_filter;
#using scripts/shared/audio_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/shared/clientfield_shared;
#using scripts/codescripts/struct;

#namespace namespace_30db0d4;

// Namespace namespace_30db0d4
// Params 0, eflags: 0x2
// namespace_30db0d4<file_0>::function_2dc19561
// Checksum 0xb3d00fdf, Offset: 0x278
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("zm_castle_tram", &__init__, undefined, undefined);
}

// Namespace namespace_30db0d4
// Params 0, eflags: 0x1 linked
// namespace_30db0d4<file_0>::function_8c87d8eb
// Checksum 0xe0202e89, Offset: 0x2b8
// Size: 0x174
function __init__() {
    level._effect["tram_fuse_destroy"] = "dlc1/castle/fx_glow_115_fuse_burst_castle";
    level._effect["tram_fuse_fx"] = "dlc1/castle/fx_glow_115_fuse_castle";
    clientfield::register("scriptmover", "tram_fuse_destroy", 1, 1, "counter", &function_1bf93100, 0, 0);
    clientfield::register("scriptmover", "tram_fuse_fx", 1, 1, "counter", &function_1383302a, 0, 0);
    clientfield::register("scriptmover", "cleanup_dynents", 1, 1, "counter", &function_8a2bbd06, 0, 0);
    clientfield::register("world", "snd_tram", 5000, 2, "int", &function_965b3fb9, 0, 0);
    thread function_58a73de9();
    thread function_60283937();
}

// Namespace namespace_30db0d4
// Params 7, eflags: 0x0
// namespace_30db0d4<file_0>::function_b84c3341
// Checksum 0x3a75998a, Offset: 0x438
// Size: 0x5c
function function_b84c3341(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        self thread function_19082f83();
    }
}

// Namespace namespace_30db0d4
// Params 0, eflags: 0x1 linked
// namespace_30db0d4<file_0>::function_19082f83
// Checksum 0x162940b6, Offset: 0x4a0
// Size: 0x84
function function_19082f83() {
    self endon(#"entityshutdown");
    self function_2d89f1a7(7.5, 0.5);
    self function_2d89f1a7(2.5, 0.25);
    self function_2d89f1a7(1.5, 0.1);
}

// Namespace namespace_30db0d4
// Params 2, eflags: 0x1 linked
// namespace_30db0d4<file_0>::function_2d89f1a7
// Checksum 0x9caa2046, Offset: 0x530
// Size: 0xa4
function function_2d89f1a7(var_e2026f3a, var_a97a56af) {
    self endon(#"entityshutdown");
    n_counter = 0;
    n_timer = 0;
    while (n_timer < var_e2026f3a) {
        if (n_counter % 2) {
            self show();
        } else {
            self hide();
        }
        wait(var_a97a56af);
        n_timer += var_a97a56af;
        n_counter++;
    }
}

// Namespace namespace_30db0d4
// Params 7, eflags: 0x1 linked
// namespace_30db0d4<file_0>::function_1383302a
// Checksum 0x13841580, Offset: 0x5e0
// Size: 0x74
function function_1383302a(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self.var_89526350 = playfxontag(localclientnum, level._effect["tram_fuse_fx"], self, "j_fuse_main");
}

// Namespace namespace_30db0d4
// Params 7, eflags: 0x1 linked
// namespace_30db0d4<file_0>::function_1bf93100
// Checksum 0x9bd35b3a, Offset: 0x660
// Size: 0xa4
function function_1bf93100(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (isdefined(self.var_89526350)) {
        deletefx(localclientnum, self.var_89526350, 1);
        self.var_89526350 = undefined;
    }
    playfxontag(localclientnum, level._effect["tram_fuse_destroy"], self, "j_fuse_main");
}

// Namespace namespace_30db0d4
// Params 7, eflags: 0x1 linked
// namespace_30db0d4<file_0>::function_965b3fb9
// Checksum 0xcbf25b09, Offset: 0x710
// Size: 0x2da
function function_965b3fb9(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        if (newval == 1) {
            playsound(0, "evt_tram_motor_start", (342, 979, -121));
            foreach (location in level.var_4ea0a9e6) {
                audio::playloopat("evt_tram_pulley_large_loop", location);
            }
            foreach (location in level.var_a49222f2) {
                audio::playloopat("evt_tram_pulley_small_loop", location);
            }
        }
        if (newval == 2) {
            playsound(0, "evt_tram_motor_stop", (342, 979, -121));
            foreach (location in level.var_4ea0a9e6) {
                audio::stoploopat("evt_tram_pulley_large_loop", location);
            }
            foreach (location in level.var_a49222f2) {
                audio::stoploopat("evt_tram_pulley_small_loop", location);
            }
        }
    }
}

// Namespace namespace_30db0d4
// Params 0, eflags: 0x1 linked
// namespace_30db0d4<file_0>::function_58a73de9
// Checksum 0xb1f8a7d8, Offset: 0x9f8
// Size: 0x84
function function_58a73de9() {
    level.var_4ea0a9e6 = array((-97, 999, 265), (276, 1186, 264), (511, 1077, 264));
    level.var_a49222f2 = array((273, 431, -14), (603, 499, -18));
}

// Namespace namespace_30db0d4
// Params 0, eflags: 0x1 linked
// namespace_30db0d4<file_0>::function_60283937
// Checksum 0x22eddf39, Offset: 0xa88
// Size: 0x90
function function_60283937() {
    while (true) {
        duration = level waittill(#"hash_dc18b3bb");
        if (duration == "long") {
            playsound(0, "evt_tram_motor_long", (342, 979, -121));
            continue;
        }
        playsound(0, "evt_tram_motor_short", (342, 979, -121));
    }
}

// Namespace namespace_30db0d4
// Params 7, eflags: 0x1 linked
// namespace_30db0d4<file_0>::function_8a2bbd06
// Checksum 0x12c754a6, Offset: 0xb20
// Size: 0x4c
function function_8a2bbd06(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    cleanupspawneddynents();
}

