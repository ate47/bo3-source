#using scripts/codescripts/struct;
#using scripts/shared/array_shared;
#using scripts/shared/audio_shared;
#using scripts/shared/music_shared;

#namespace zm_factory_amb;

// Namespace zm_factory_amb
// Params 0, eflags: 0x0
// Checksum 0x24a0c2d2, Offset: 0x410
// Size: 0x144
function main() {
    thread start_lights();
    thread teleport_pad_init(0);
    thread teleport_pad_init(1);
    thread teleport_pad_init(2);
    thread function_355e59e9();
    thread function_7ea5ced(0);
    thread function_7ea5ced(1);
    thread function_7ea5ced(2);
    thread function_ea3bb1bc();
    thread function_a63cf1d0();
    thread function_679ae70c();
    thread function_e64eb037();
    thread function_2e96ad2a();
    thread function_ce1f2ad();
    thread function_aa572593();
    thread function_75cde2e7();
    thread function_f8f4acde();
}

// Namespace zm_factory_amb
// Params 0, eflags: 0x0
// Checksum 0xc23d6fbb, Offset: 0x560
// Size: 0x114
function start_lights() {
    level waittill(#"pl1");
    array::thread_all(struct::get_array("dyn_light", "targetname"), &function_cb4b07ab);
    array::thread_all(struct::get_array("switch_progress", "targetname"), &function_5fe27261);
    array::thread_all(struct::get_array("dyn_generator", "targetname"), &function_f25cf6c0);
    array::thread_all(struct::get_array("dyn_breakers", "targetname"), &function_f6bdd2ca);
}

// Namespace zm_factory_amb
// Params 0, eflags: 0x0
// Checksum 0x405d6fc8, Offset: 0x680
// Size: 0x60
function function_cb4b07ab() {
    if (isdefined(self)) {
        playsound(0, "evt_light_start", self.origin);
        e1 = audio::playloopat("amb_light_buzz", self.origin);
    }
}

// Namespace zm_factory_amb
// Params 0, eflags: 0x0
// Checksum 0x22b764b1, Offset: 0x6e8
// Size: 0x88
function function_f25cf6c0() {
    if (isdefined(self)) {
        wait 3;
        playsound(0, "evt_switch_progress", self.origin);
        playsound(0, "evt_gen_start", self.origin);
        var_af70e811 = audio::playloopat("evt_gen_loop", self.origin);
    }
}

// Namespace zm_factory_amb
// Params 0, eflags: 0x0
// Checksum 0x648ff3f0, Offset: 0x778
// Size: 0x60
function function_f6bdd2ca() {
    if (isdefined(self)) {
        playsound(0, "evt_break_start", self.origin);
        b1 = audio::playloopat("evt_break_loop", self.origin);
    }
}

// Namespace zm_factory_amb
// Params 0, eflags: 0x0
// Checksum 0xd093bab3, Offset: 0x7e0
// Size: 0xfc
function function_5fe27261() {
    if (isdefined(self.script_noteworthy)) {
        if (self.script_noteworthy == "1") {
            time = 0.5;
        } else if (self.script_noteworthy == "2") {
            time = 1;
        } else if (self.script_noteworthy == "3") {
            time = 1.5;
        } else if (self.script_noteworthy == "4") {
            time = 2;
        } else if (self.script_noteworthy == "5") {
            time = 2.5;
        } else {
            time = 0;
        }
        wait time;
        playsound(0, "evt_switch_progress", self.origin);
    }
}

// Namespace zm_factory_amb
// Params 0, eflags: 0x0
// Checksum 0x155eea8b, Offset: 0x8e8
// Size: 0xd4
function function_a63cf1d0() {
    level waittill(#"pap1");
    homepad = struct::get("homepad_power_looper", "targetname");
    var_b30bd909 = struct::get("homepad_breaker", "targetname");
    if (isdefined(homepad)) {
        audio::playloopat("amb_homepad_power_loop", homepad.origin);
    }
    if (isdefined(var_b30bd909)) {
        audio::playloopat("amb_break_arc", var_b30bd909.origin);
    }
}

// Namespace zm_factory_amb
// Params 1, eflags: 0x0
// Checksum 0x127a9c24, Offset: 0x9c8
// Size: 0x134
function teleport_pad_init(pad) {
    telepad = struct::get_array("telepad_" + pad, "targetname");
    var_732fa769 = struct::get_array("telepad_" + pad + "_looper", "targetname");
    homepad = struct::get_array("homepad", "targetname");
    level waittill("tp" + pad);
    array::thread_all(var_732fa769, &function_732fa769);
    array::thread_all(telepad, &function_fcf63df8, pad);
    array::thread_all(homepad, &function_fcf63df8, pad);
}

// Namespace zm_factory_amb
// Params 0, eflags: 0x0
// Checksum 0x6b5370a1, Offset: 0xb08
// Size: 0x24
function function_732fa769() {
    audio::playloopat("amb_power_loop", self.origin);
}

// Namespace zm_factory_amb
// Params 1, eflags: 0x0
// Checksum 0xb8d9f8a1, Offset: 0xb38
// Size: 0x138
function function_fcf63df8(pad) {
    var_276703f8 = 2;
    while (true) {
        level waittill("tpw" + pad);
        if (isdefined(self.script_sound)) {
            if (self.targetname == "telepad_" + pad) {
                playsound(0, self.script_sound + "_warmup", self.origin);
                wait 2;
                playsound(0, self.script_sound + "_cooldown", self.origin);
            }
            if (self.targetname == "homepad") {
                wait 2;
                playsound(0, self.script_sound + "_warmup", self.origin);
                playsound(0, self.script_sound + "_cooldown", self.origin);
            }
        }
    }
}

// Namespace zm_factory_amb
// Params 1, eflags: 0x0
// Checksum 0x3809990e, Offset: 0xc78
// Size: 0x38
function function_7ea5ced(pad) {
    var_b2b93ade = struct::get_array("pa_system", "targetname");
}

// Namespace zm_factory_amb
// Params 0, eflags: 0x0
// Checksum 0x4a951aaf, Offset: 0xcb8
// Size: 0x30
function function_ea3bb1bc() {
    var_b2b93ade = struct::get_array("pa_system", "targetname");
}

// Namespace zm_factory_amb
// Params 1, eflags: 0x0
// Checksum 0xc8c2faf3, Offset: 0xcf0
// Size: 0x186
function function_58b4bf2c(pad) {
    level endon("scd" + pad);
    while (true) {
        level waittill("pac" + pad);
        playsound(0, "evt_pa_buzz", self.origin);
        self thread function_c56b408("vox_pa_audio_link_start");
        for (count = 30; count > 0; count--) {
            play = count == 20 || count == 15 || count <= 10;
            if (play) {
                playsound(0, "vox_pa_audio_link_" + count, self.origin);
            }
            playsound(0, "evt_clock_tick_1sec", (0, 0, 0));
            wait 1;
        }
        playsound(0, "evt_pa_buzz", self.origin);
        wait 1.2;
        self thread function_c56b408("vox_pa_audio_link_fail");
    }
    wait 1;
}

// Namespace zm_factory_amb
// Params 1, eflags: 0x0
// Checksum 0xb18017f4, Offset: 0xe80
// Size: 0x6c
function function_b8d8a64c(pad) {
    level waittill("scd" + pad);
    playsound(0, "evt_pa_buzz", self.origin);
    wait 1.2;
    self function_c56b408("vox_pa_audio_act_pad_" + pad);
}

// Namespace zm_factory_amb
// Params 1, eflags: 0x0
// Checksum 0xf57444a5, Offset: 0xef8
// Size: 0x80
function function_421db7ae(pad) {
    while (true) {
        level waittill("tpc" + pad);
        wait 1;
        playsound(0, "evt_pa_buzz", self.origin);
        wait 1.2;
        self function_c56b408("vox_pa_teleport_finish");
    }
}

// Namespace zm_factory_amb
// Params 1, eflags: 0x0
// Checksum 0xbd0cf2a4, Offset: 0xf80
// Size: 0xc8
function function_2b9827e8(location) {
    while (true) {
        level waittill(location);
        playsound(0, "evt_pa_buzz", self.origin);
        wait 1.2;
        self thread function_c56b408("vox_pa_trap_inuse_" + location);
        wait 48.5;
        playsound(0, "evt_pa_buzz", self.origin);
        wait 1.2;
        self thread function_c56b408("vox_pa_trap_active_" + location);
    }
}

// Namespace zm_factory_amb
// Params 1, eflags: 0x0
// Checksum 0xea936ce2, Offset: 0x1050
// Size: 0xa0
function function_c56b408(alias) {
    if (!isdefined(self.var_9f89137c)) {
        self.var_9f89137c = 0;
    }
    if (self.var_9f89137c != 1) {
        self.var_9f89137c = 1;
        self.var_99ecf37c = playsound(0, alias, self.origin);
        while (soundplaying(self.var_99ecf37c)) {
            wait 0.01;
        }
        self.var_9f89137c = 0;
    }
}

// Namespace zm_factory_amb
// Params 0, eflags: 0x0
// Checksum 0xa79afefd, Offset: 0x10f8
// Size: 0x60
function function_355e59e9() {
    while (true) {
        level waittill(#"t2d");
        playsound(0, "evt_teleport_2d_fnt", (0, 0, 0));
        playsound(0, "evt_teleport_2d_rear", (0, 0, 0));
    }
}

// Namespace zm_factory_amb
// Params 0, eflags: 0x0
// Checksum 0x824ea3f8, Offset: 0x1160
// Size: 0x34
function function_679ae70c() {
    level waittill(#"pl1");
    playsound(0, "evt_power_up_2d", (0, 0, 0));
}

// Namespace zm_factory_amb
// Params 0, eflags: 0x0
// Checksum 0x4586d826, Offset: 0x11a0
// Size: 0x34
function function_e64eb037() {
    level waittill(#"pap1");
    playsound(0, "evt_linkall_2d", (0, 0, 0));
}

// Namespace zm_factory_amb
// Params 0, eflags: 0x0
// Checksum 0x99ec1590, Offset: 0x11e0
// Size: 0x4
function function_60935d2e() {
    
}

// Namespace zm_factory_amb
// Params 0, eflags: 0x0
// Checksum 0x8f88c43d, Offset: 0x11f0
// Size: 0x5c
function function_891ed3c6() {
    level waittill(#"pl1");
    playsound(0, "evt_pa_buzz", self.origin);
    wait 1.2;
    self function_c56b408("vox_pa_power_on");
}

// Namespace zm_factory_amb
// Params 0, eflags: 0x0
// Checksum 0xe893bdc7, Offset: 0x1258
// Size: 0x64
function function_2e96ad2a() {
    level waittill(#"pl1");
    playsound(0, "evt_crazy_power_left", (-510, 394, 102));
    playsound(0, "evt_crazy_power_right", (554, -1696, -100));
}

// Namespace zm_factory_amb
// Params 0, eflags: 0x0
// Checksum 0xe2e155f9, Offset: 0x12c8
// Size: 0x64
function function_ce1f2ad() {
    level waittill(#"pl1");
    playsound(0, "evt_flip_sparks_left", (511, -1771, 116));
    playsound(0, "evt_flip_sparks_right", (550, -1771, 116));
}

// Namespace zm_factory_amb
// Params 0, eflags: 0x0
// Checksum 0x5de2b921, Offset: 0x1338
// Size: 0x194
function function_aa572593() {
    audio::playloopat("amb_snow_transitions", (-181, -455, 6));
    audio::playloopat("amb_snow_transitions", (1315, -1428, -29));
    audio::playloopat("amb_snow_transitions", (-1365, -1597, 295));
    audio::playloopat("amb_extreme_fire_dist", (1892, -2563, 1613));
    audio::playloopat("amb_extreme_fire_dist", (1441, -1622, 1603));
    audio::playloopat("amb_extreme_fire_dist", (-1561, 410, 1559));
    audio::playloopat("amb_extreme_fire_dist", (844, 2038, 915));
    audio::playloopat("amb_small_fire", (779, -2249, 326));
    audio::playloopat("amb_small_fire", (-2, -1417, 124));
    audio::playloopat("amb_small_fire", (1878, 911, -67));
}

// Namespace zm_factory_amb
// Params 0, eflags: 0x0
// Checksum 0xfc07904f, Offset: 0x14d8
// Size: 0xf0
function function_75cde2e7() {
    while (true) {
        playsound(0, "amb_creepy_whispers", (-339, 271, -49));
        playsound(0, "amb_creepy_whispers", (-22, 110, 310));
        playsound(0, "amb_creepy_whispers", (-17, -564, -1));
        playsound(0, "amb_creepy_whispers", (743, -1859, -46));
        playsound(0, "amb_creepy_whispers", (790, -748, -75));
        wait randomintrange(1, 4);
    }
}

// Namespace zm_factory_amb
// Params 0, eflags: 0x0
// Checksum 0xcb1f9f96, Offset: 0x15d0
// Size: 0x40
function function_f8f4acde() {
    while (true) {
        wait 60;
        playsound(0, "amb_creepy_children", (-2637, -2403, 413));
    }
}

