#using scripts/codescripts/struct;
#using scripts/shared/exploder_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/util_shared;
#using scripts/zm/_zm_audio;
#using scripts/zm/_zm_sidequests;
#using scripts/zm/zm_temple_sq;
#using scripts/zm/zm_temple_sq_brock;
#using scripts/zm/zm_temple_sq_skits;

#namespace zm_temple_sq_ptt;

// Namespace zm_temple_sq_ptt
// Params 0, eflags: 0x0
// Checksum 0x955f1b6, Offset: 0x410
// Size: 0x10c
function init() {
    flag::init("sq_ptt_dial_dialed");
    flag::init("sq_ptt_level_pulled");
    flag::init("ptt_plot_vo_done");
    namespace_6e97c459::function_5a90ed82("sq", "PtT", &init_stage, &function_7747c56, &function_cc3f3f6a);
    namespace_6e97c459::function_b9676730("sq", "PtT", 300);
    namespace_6e97c459::function_9a85e396("sq", "PtT", "sq_ptt_trig", &function_5fba445d, &function_74e74bde);
}

/#

    // Namespace zm_temple_sq_ptt
    // Params 0, eflags: 0x0
    // Checksum 0x5778c9bd, Offset: 0x528
    // Size: 0x140
    function function_9b5a2dae() {
        self endon(#"death");
        struct = struct::get(self.target, "<dev string:x28>");
        dir = anglestoforward(struct.angles);
        while (!(isdefined(level.disable_print3d_ent) && level.disable_print3d_ent)) {
            scale = 0.1;
            offset = (0, 0, 0);
            for (i = 0; i < 5; i++) {
                print3d(struct.origin + offset, "<dev string:x33>", self.var_215fb1c6, 1, scale, 10);
                scale *= 1.7;
                offset += dir * 6;
            }
            wait 1;
        }
    }

#/

// Namespace zm_temple_sq_ptt
// Params 0, eflags: 0x0
// Checksum 0x5ae3ab01, Offset: 0x670
// Size: 0x84
function function_a9423e63() {
    level endon(#"end_game");
    self playsound("evt_sq_ptt_gas_ignite");
    str_exploder = "fxexp_" + self.script_int + 10;
    exploder::exploder(str_exploder);
    level waittill(#"hash_64b1dd4d");
    exploder::stop_exploder(str_exploder);
}

// Namespace zm_temple_sq_ptt
// Params 0, eflags: 0x0
// Checksum 0x211abeaa, Offset: 0x700
// Size: 0xfa
function function_5fba445d() {
    self endon(#"death");
    self.var_215fb1c6 = (0, 255, 0);
    level flag::wait_till("sq_ptt_dial_dialed");
    exploder::exploder("fxexp_" + self.script_int);
    while (true) {
        level waittill(#"hash_1a72a54d", volume);
        if (volume == self.script_int) {
            self.trigger notify(#"hash_ad2035e4");
            level notify(#"hash_ad2035e4");
            self thread function_a9423e63();
            self thread function_73e47eae();
            level.var_e8ad61cf++;
            return;
        }
    }
}

// Namespace zm_temple_sq_ptt
// Params 0, eflags: 0x0
// Checksum 0xcfe1fc44, Offset: 0x808
// Size: 0xc8
function function_73e47eae() {
    players = getplayers();
    for (i = 0; i < players.size; i++) {
        if (distancesquared(self.origin, players[i].origin) <= 62500) {
            players[i] thread zm_audio::create_and_play_dialog("eggs", "quest4", randomintrange(2, 5));
            return;
        }
    }
}

// Namespace zm_temple_sq_ptt
// Params 0, eflags: 0x0
// Checksum 0x5f3b54da, Offset: 0x8d8
// Size: 0x15c
function function_d9c0ed6() {
    self endon(#"death");
    self triggerignoreteam();
    while (true) {
        while (level.var_4e4c9791.size == 0) {
            /#
                if (getdvarint("<dev string:x35>") == 2) {
                    wait (self.var_bbca234.script_int - 99) * 2;
                    self notify(#"hash_c1510355");
                }
            #/
            wait 1;
        }
        while (level.var_4e4c9791.size > 0) {
            foreach (zombie in level.var_4e4c9791) {
                if (zombie istouching(self)) {
                    self notify(#"hash_c1510355");
                }
            }
            util::wait_network_frame();
        }
    }
}

// Namespace zm_temple_sq_ptt
// Params 0, eflags: 0x0
// Checksum 0x46903df9, Offset: 0xa40
// Size: 0x9c
function function_74e74bde() {
    self endon(#"death");
    self endon(#"hash_ad2035e4");
    level flag::wait_till("sq_ptt_dial_dialed");
    self thread function_794a67e2();
    self thread function_d9c0ed6();
    while (true) {
        self waittill(#"hash_c1510355");
        level notify(#"hash_1a72a54d", self.var_bbca234.script_int);
        return;
    }
}

// Namespace zm_temple_sq_ptt
// Params 0, eflags: 0x0
// Checksum 0xf05ec056, Offset: 0xae8
// Size: 0x9a
function function_794a67e2() {
    self endon(#"death");
    self endon(#"hash_ad2035e4");
    while (true) {
        self waittill(#"trigger", who);
        if (isplayer(who)) {
            who thread zm_audio::create_and_play_dialog("eggs", "quest4", randomintrange(0, 2));
            return;
        }
    }
}

// Namespace zm_temple_sq_ptt
// Params 0, eflags: 0x0
// Checksum 0x925eb882, Offset: 0xb90
// Size: 0x13c
function init_stage() {
    level notify(#"hash_114a0a12");
    level flag::clear("sq_ptt_dial_dialed");
    dial = getent("sq_ptt_dial", "targetname");
    dial thread function_6b0bda58();
    var_774463c5 = getentarray("sq_ptt_trig", "targetname");
    level.var_88fa00df = var_774463c5.size;
    level.var_e8ad61cf = 0;
    zm_temple_sq_brock::function_ac4ad5b0();
    if (level flag::get("radio_4_played")) {
        level thread function_9873f186("tt4a");
    } else {
        level thread function_9873f186("tt4b");
    }
    level thread function_723ad690();
}

// Namespace zm_temple_sq_ptt
// Params 0, eflags: 0x0
// Checksum 0x2be55a09, Offset: 0xcd8
// Size: 0x106
function function_723ad690() {
    level endon(#"hash_64b1dd4d");
    struct = struct::get("sq_location_ptt", "targetname");
    if (!isdefined(struct)) {
        return;
    }
    level.var_9d0931da = spawn("script_origin", struct.origin);
    level.var_9d0931da playloopsound("evt_sq_ptt_choking_loop", 2);
    level flag::wait_till("sq_ptt_dial_dialed");
    level.var_9d0931da stoploopsound(1);
    wait 1;
    level.var_9d0931da delete();
    level.var_9d0931da = undefined;
}

// Namespace zm_temple_sq_ptt
// Params 1, eflags: 0x0
// Checksum 0xcc1251a5, Offset: 0xde8
// Size: 0x24
function function_9873f186(skit) {
    level thread zm_temple_sq_skits::function_acc79afb(skit);
}

// Namespace zm_temple_sq_ptt
// Params 0, eflags: 0x0
// Checksum 0xc8f3653, Offset: 0xe18
// Size: 0x1bc
function function_c4f2f172() {
    level endon(#"hash_64b1dd4d");
    level flag::clear("sq_ptt_level_pulled");
    if (!isdefined(self.original_angles)) {
        self.original_angles = self.angles;
    }
    self.angles = self.original_angles;
    while (level.var_e8ad61cf < level.var_88fa00df) {
        level waittill(#"hash_ad2035e4");
        self playsound("evt_sq_ptt_lever_ratchet");
        self rotateroll(-25, 0.25);
        self waittill(#"rotatedone");
    }
    use_trigger = spawn("trigger_radius_use", self.origin, 0, 32, 72);
    use_trigger triggerignoreteam();
    use_trigger setcursorhint("HINT_NOICON");
    use_trigger waittill(#"trigger");
    use_trigger delete();
    self playsound("evt_sq_ptt_lever_pull");
    self rotateroll(100, 0.25);
    self waittill(#"rotatedone");
    level flag::set("sq_ptt_level_pulled");
}

// Namespace zm_temple_sq_ptt
// Params 1, eflags: 0x0
// Checksum 0x4b6553ca, Offset: 0xfe0
// Size: 0x356
function function_43b76deb(player) {
    level endon(#"hash_64b1dd4d");
    struct = struct::get("sq_location_ptt", "targetname");
    if (!isdefined(struct)) {
        return;
    }
    level.var_f9eff852 = spawn("script_origin", struct.origin);
    level.var_892b3555 = spawn("script_origin", struct.origin);
    level.var_f9eff852 playsoundwithnotify("vox_egg_story_3_0", "sounddone");
    level.var_f9eff852 waittill(#"sounddone");
    level.var_892b3555 playsound("evt_sq_ptt_trash_start");
    level.var_892b3555 playloopsound("evt_sq_ptt_trash_loop");
    level.var_f9eff852 playsoundwithnotify("vox_egg_story_3_1", "sounddone");
    level.var_f9eff852 waittill(#"sounddone");
    level.var_f9eff852 playsoundwithnotify("vox_egg_story_3_2", "sounddone");
    level.var_f9eff852 waittill(#"sounddone");
    if (isdefined(player)) {
        level.var_c502e691 = 1;
        player playsoundwithnotify("vox_egg_story_3_3" + zm_temple_sq::function_26186755(player.characterindex), "vox_egg_sounddone");
        player waittill(#"vox_egg_sounddone");
        level.var_c502e691 = 0;
    }
    level thread function_3da38a8c(45);
    level flag::wait_till("sq_ptt_level_pulled");
    level.var_892b3555 stoploopsound(2);
    level.var_892b3555 playsound("evt_sq_ptt_trash_end");
    level.var_f9eff852 playsoundwithnotify("vox_egg_story_3_8", "sounddone");
    level.var_f9eff852 waittill(#"sounddone");
    level.var_f9eff852 playsoundwithnotify("vox_egg_story_3_9", "sounddone");
    level.var_f9eff852 waittill(#"sounddone");
    level flag::set("ptt_plot_vo_done");
    level.var_892b3555 delete();
    level.var_892b3555 = undefined;
    level.var_f9eff852 delete();
    level.var_f9eff852 = undefined;
}

// Namespace zm_temple_sq_ptt
// Params 1, eflags: 0x0
// Checksum 0xbc8ad670, Offset: 0x1340
// Size: 0xae
function function_3da38a8c(waittime) {
    level endon(#"hash_64b1dd4d");
    wait waittime;
    count = 4;
    while (!level flag::get("sq_ptt_level_pulled") && count <= 7) {
        level.var_f9eff852 playsoundwithnotify("vox_egg_story_3_" + count, "sounddone");
        level.var_f9eff852 waittill(#"sounddone");
        count++;
        wait waittime;
    }
}

// Namespace zm_temple_sq_ptt
// Params 0, eflags: 0x0
// Checksum 0x42ed1ba6, Offset: 0x13f8
// Size: 0x104
function function_7747c56() {
    level flag::wait_till("sq_ptt_dial_dialed");
    while (level.var_e8ad61cf < level.var_88fa00df) {
        wait 0.1;
    }
    level flag::wait_till("sq_ptt_level_pulled");
    level notify(#"hash_bd6f486d");
    wait 5;
    level notify(#"hash_15ab69d8");
    level notify(#"hash_87b2d913");
    level notify(#"hash_61b05eaa");
    level notify(#"hash_d3b7cde5", 1);
    level waittill(#"hash_f2e27853");
    level flag::wait_till("ptt_plot_vo_done");
    wait 5;
    namespace_6e97c459::function_2f3ced1f("sq", "PtT");
}

// Namespace zm_temple_sq_ptt
// Params 0, eflags: 0x0
// Checksum 0x114d3de9, Offset: 0x1508
// Size: 0xd4
function function_7c44052() {
    exploder::stop_exploder("fxexp_100");
    exploder::stop_exploder("fxexp_101");
    exploder::stop_exploder("fxexp_102");
    exploder::stop_exploder("fxexp_103");
    util::wait_network_frame();
    exploder::stop_exploder("fxexp_110");
    exploder::stop_exploder("fxexp_111");
    exploder::stop_exploder("fxexp_112");
    exploder::stop_exploder("fxexp_113");
}

// Namespace zm_temple_sq_ptt
// Params 1, eflags: 0x0
// Checksum 0xe1713072, Offset: 0x15e8
// Size: 0x20e
function function_cc3f3f6a(success) {
    level flag::clear("sq_ptt_dial_dialed");
    level flag::clear("ptt_plot_vo_done");
    dial = getent("sq_ptt_dial", "targetname");
    dial thread function_fbbc8808();
    ents = getaiarray();
    for (i = 0; i < ents.size; i++) {
        if (isdefined(ents[i].var_41234a0f)) {
            ents[i].var_41234a0f = 0;
        }
    }
    level thread function_7c44052();
    if (success) {
        zm_temple_sq_brock::function_67e052f1(5);
    } else {
        zm_temple_sq_brock::function_67e052f1(4, &zm_temple_sq_brock::function_4b89aecd);
        level thread zm_temple_sq_skits::function_b6268f3d();
    }
    level.var_c502e691 = 0;
    if (isdefined(level.var_f9eff852)) {
        level.var_f9eff852 delete();
        level.var_f9eff852 = undefined;
    }
    if (isdefined(level.var_892b3555)) {
        level.var_892b3555 delete();
        level.var_892b3555 = undefined;
    }
    if (isdefined(level.var_9d0931da)) {
        level.var_9d0931da delete();
        level.var_9d0931da = undefined;
    }
}

// Namespace zm_temple_sq_ptt
// Params 0, eflags: 0x0
// Checksum 0x6529b10f, Offset: 0x1800
// Size: 0x58
function function_58999522() {
    level endon(#"hash_114a0a12");
    level endon(#"hash_64b1dd4d");
    while (true) {
        self waittill(#"trigger", who);
        self.var_bbca234 notify(#"triggered", who);
    }
}

// Namespace zm_temple_sq_ptt
// Params 0, eflags: 0x0
// Checksum 0xde5b6eae, Offset: 0x1860
// Size: 0x16c
function function_6b0bda58() {
    level endon(#"hash_64b1dd4d");
    var_66f2b40c = 0;
    who = undefined;
    self.trigger triggerignoreteam();
    self.trigger thread function_58999522();
    while (var_66f2b40c < 4) {
        self waittill(#"triggered", who);
        self playsound("evt_sq_ptt_valve");
        self rotateroll(90, 0.25);
        self waittill(#"rotatedone");
        var_66f2b40c++;
    }
    level thread function_43b76deb(who);
    self playsound("evt_sq_ptt_gas_release");
    lever = getent("sq_ptt_lever", "targetname");
    lever thread function_c4f2f172();
    level flag::set("sq_ptt_dial_dialed");
}

// Namespace zm_temple_sq_ptt
// Params 0, eflags: 0x0
// Checksum 0x76492037, Offset: 0x19d8
// Size: 0x90
function function_fbbc8808() {
    level endon(#"hash_114a0a12");
    self.trigger triggerignoreteam();
    self.trigger thread function_58999522();
    while (true) {
        self waittill(#"triggered");
        self playsound("evt_sq_ptt_valve");
        self rotateroll(90, 0.25);
    }
}

