#using scripts/zm/zm_temple_sq_skits;
#using scripts/zm/zm_temple_sq_brock;
#using scripts/zm/zm_temple_sq;
#using scripts/zm/_zm_sidequests;
#using scripts/zm/_zm_audio;
#using scripts/shared/util_shared;
#using scripts/shared/flag_shared;
#using scripts/codescripts/struct;

#namespace zm_temple_sq_dgcwf;

// Namespace zm_temple_sq_dgcwf
// Params 0, eflags: 0x1 linked
// Checksum 0x329c5c52, Offset: 0x300
// Size: 0x16c
function init() {
    level flag::init("dgcwf_on_plate");
    level flag::init("dgcwf_sw1_pressed");
    level flag::init("dgcwf_plot_vo_done");
    level.var_a775df2e = 0;
    namespace_6e97c459::function_5a90ed82("sq", "DgCWf", &init_stage, &function_7747c56, &function_cc3f3f6a);
    namespace_6e97c459::function_b9676730("sq", "DgCWf", 300);
    namespace_6e97c459::function_9a85e396("sq", "DgCWf", "sq_dgcwf_sw1", &function_3ab2e3c3, &function_375f6cbc);
    namespace_6e97c459::function_ff87971b("sq", "DgCWf", "sq_dgcwf_trig", &function_9041b7f6);
}

// Namespace zm_temple_sq_dgcwf
// Params 0, eflags: 0x1 linked
// Checksum 0xc2d122c7, Offset: 0x478
// Size: 0x118
function function_ee5bdd96() {
    self endon(#"death");
    var_b4264aa6 = 4;
    /#
        if (getdvarint("<dev string:x28>") >= 2) {
            var_b4264aa6 = getplayers().size;
        }
    #/
    while (true) {
        if (level.var_a775df2e >= var_b4264aa6 - 1 && !level flag::get("dgcwf_on_plate")) {
            level flag::set("dgcwf_on_plate");
        } else if (level flag::get("dgcwf_on_plate") && level.var_a775df2e < var_b4264aa6 - 1) {
            level flag::clear("dgcwf_on_plate");
        }
        wait 0.05;
    }
}

/#

    // Namespace zm_temple_sq_dgcwf
    // Params 0, eflags: 0x1 linked
    // Checksum 0x97d334a5, Offset: 0x598
    // Size: 0x2a0
    function function_801d1def() {
        level endon(#"hash_4022caee");
        if (!isdefined(level.var_19e4094c)) {
            level.var_19e4094c = 1;
            level.var_a4c38233 = newdebughudelem();
            level.var_a4c38233.location = 0;
            level.var_a4c38233.alignx = "<dev string:x35>";
            level.var_a4c38233.aligny = "<dev string:x3a>";
            level.var_a4c38233.foreground = 1;
            level.var_a4c38233.fontscale = 1.3;
            level.var_a4c38233.sort = 20;
            level.var_a4c38233.x = 10;
            level.var_a4c38233.y = -16;
            level.var_a4c38233.og_scale = 1;
            level.var_a4c38233.color = (255, 255, 255);
            level.var_a4c38233.alpha = 1;
            level.var_e4afe5fb = newdebughudelem();
            level.var_e4afe5fb.location = 0;
            level.var_e4afe5fb.alignx = "<dev string:x41>";
            level.var_e4afe5fb.aligny = "<dev string:x3a>";
            level.var_e4afe5fb.foreground = 1;
            level.var_e4afe5fb.fontscale = 1.3;
            level.var_e4afe5fb.sort = 20;
            level.var_e4afe5fb.x = 0;
            level.var_e4afe5fb.y = -16;
            level.var_e4afe5fb.og_scale = 1;
            level.var_e4afe5fb.color = (255, 255, 255);
            level.var_e4afe5fb.alpha = 1;
            level.var_e4afe5fb settext("<dev string:x47>");
        }
        while (true) {
            if (isdefined(level.var_a775df2e)) {
                level.var_a4c38233 setvalue(level.var_a775df2e);
            }
            wait 0.1;
        }
    }

#/

// Namespace zm_temple_sq_dgcwf
// Params 1, eflags: 0x1 linked
// Checksum 0x4103d1e7, Offset: 0x840
// Size: 0x4c
function function_64952bc(trig) {
    trig endon(#"death");
    level endon(#"hash_4022caee");
    self waittill(#"spawned_player");
    self thread function_3230d5dc(trig);
}

// Namespace zm_temple_sq_dgcwf
// Params 1, eflags: 0x1 linked
// Checksum 0xa21b044d, Offset: 0x898
// Size: 0x208
function function_3230d5dc(trig) {
    self endon(#"disconnect");
    trig endon(#"death");
    level endon(#"hash_4022caee");
    while (true) {
        while (!self istouching(trig)) {
            wait 0.1;
        }
        if (level.var_a775df2e < 4) {
            level.var_a775df2e++;
        }
        trig playsound("evt_sq_dgcwf_plate_" + level.var_a775df2e);
        if (level.var_a775df2e <= 2 && !level flag::get("dgcwf_sw1_pressed")) {
            self thread zm_audio::create_and_play_dialog("eggs", "quest2", 0);
        } else {
            self thread zm_audio::create_and_play_dialog("eggs", "quest2", 1);
        }
        while (self istouching(trig) && self.sessionstate != "spectator") {
            wait 0.05;
        }
        if (level.var_a775df2e >= 0) {
            level.var_a775df2e--;
        }
        if (self.sessionstate == "spectator") {
            self thread function_64952bc(trig);
            return;
        }
        if (level.var_a775df2e < 3 && !level flag::get("dgcwf_sw1_pressed")) {
            self thread zm_audio::create_and_play_dialog("eggs", "quest2", 2);
        }
    }
}

// Namespace zm_temple_sq_dgcwf
// Params 0, eflags: 0x1 linked
// Checksum 0x2f1a3392, Offset: 0xaa8
// Size: 0x156
function function_9041b7f6() {
    self endon(#"death");
    self thread function_8d26168c();
    self thread function_4115af82();
    level.var_9fb9bcda = spawn("script_origin", self.origin);
    level.var_9fb9bcda playloopsound("evt_sq_dgcwf_waterthrash_loop", 2);
    if (getplayers().size == 1) {
        level flag::set("dgcwf_on_plate");
        return;
    }
    /#
        level thread function_801d1def();
    #/
    self thread function_ee5bdd96();
    players = getplayers();
    for (i = 0; i < players.size; i++) {
        players[i] thread function_3230d5dc(self);
    }
}

// Namespace zm_temple_sq_dgcwf
// Params 0, eflags: 0x1 linked
// Checksum 0xfe06b850, Offset: 0xc08
// Size: 0xbc
function function_4115af82() {
    self endon(#"death");
    while (true) {
        who = self waittill(#"trigger");
        if (isplayer(who)) {
            self stoploopsound(1);
            level.var_9fb9bcda stoploopsound(1);
            level.var_9fb9bcda delete();
            who thread function_5be7878a();
            return;
        }
        wait 0.05;
    }
}

// Namespace zm_temple_sq_dgcwf
// Params 0, eflags: 0x1 linked
// Checksum 0xe818e930, Offset: 0xcd0
// Size: 0x74
function function_375f6cbc() {
    self endon(#"death");
    while (true) {
        who = self waittill(#"trigger");
        who thread zm_audio::create_and_play_dialog("eggs", "quest2", 3);
        self.var_bbca234.pressed = 1;
    }
}

// Namespace zm_temple_sq_dgcwf
// Params 0, eflags: 0x1 linked
// Checksum 0x601e4e8e, Offset: 0xd50
// Size: 0x298
function function_3ab2e3c3() {
    self endon(#"death");
    self show();
    self.var_bbf92e7d = self.origin;
    self.var_eaa97957 = self.var_bbf92e7d - anglestoright(self.angles) * 36;
    self.origin = self.var_eaa97957;
    self.trigger triggerenable(0);
    self.pressed = 0;
    while (true) {
        if (level flag::get("dgcwf_on_plate")) {
            self.pressed = 0;
            self moveto(self.var_bbf92e7d, 0.25);
            self playsound("evt_sq_dgcwf_lever_kachunk");
            self waittill(#"movedone");
            self.trigger triggerenable(1);
            while (level flag::get("dgcwf_on_plate")) {
                if (self.pressed) {
                    self playsound("evt_sq_dgcwf_lever_success");
                    self rotateroll(75, 0.15);
                    self.trigger triggerenable(0);
                    level flag::set("dgcwf_sw1_pressed");
                    return;
                }
                wait 0.05;
            }
        } else {
            self.pressed = 0;
            self.trigger triggerenable(0);
            self playsound("evt_sq_dgcwf_lever_dechunk");
            self moveto(self.var_eaa97957, 0.25);
            self waittill(#"movedone");
            while (!level flag::get("dgcwf_on_plate")) {
                wait 0.05;
            }
        }
        wait 0.05;
    }
}

// Namespace zm_temple_sq_dgcwf
// Params 0, eflags: 0x1 linked
// Checksum 0xce4e2d48, Offset: 0xff0
// Size: 0xfc
function init_stage() {
    level.var_a775df2e = 0;
    if (getplayers().size > 1) {
        level flag::clear("dgcwf_on_plate");
    }
    level flag::clear("dgcwf_sw1_pressed");
    level flag::clear("dgcwf_plot_vo_done");
    trig = getent("sq_dgcwf_trig", "targetname");
    trig triggerenable(1);
    zm_temple_sq_brock::function_ac4ad5b0();
    level thread function_9873f186();
}

// Namespace zm_temple_sq_dgcwf
// Params 0, eflags: 0x1 linked
// Checksum 0x550dc9dc, Offset: 0x10f8
// Size: 0x2c
function function_9873f186() {
    wait 0.5;
    level thread zm_temple_sq_skits::function_acc79afb("tt2");
}

// Namespace zm_temple_sq_dgcwf
// Params 0, eflags: 0x1 linked
// Checksum 0xaa48fec, Offset: 0x1130
// Size: 0xdc
function function_7747c56() {
    level endon(#"hash_4022caee");
    level flag::wait_till("dgcwf_on_plate");
    level flag::wait_till("dgcwf_sw1_pressed");
    level notify(#"hash_bd6f486d");
    level notify(#"hash_15ab69d8");
    level notify(#"hash_87b2d913", 1);
    level thread function_28570bac();
    level waittill(#"hash_3ee76d25");
    level flag::wait_till("dgcwf_plot_vo_done");
    wait 5;
    level thread namespace_6e97c459::function_2f3ced1f("sq", "DgCWf");
}

// Namespace zm_temple_sq_dgcwf
// Params 0, eflags: 0x1 linked
// Checksum 0xf9118eb3, Offset: 0x1218
// Size: 0x74
function function_28570bac() {
    wait 2.5;
    players = getplayers();
    players[randomintrange(0, players.size)] thread zm_audio::create_and_play_dialog("eggs", "quest2", 4);
}

// Namespace zm_temple_sq_dgcwf
// Params 0, eflags: 0x1 linked
// Checksum 0x416f13fd, Offset: 0x1298
// Size: 0x6c
function function_8d26168c() {
    level endon(#"hash_4022caee");
    level flag::wait_till("dgcwf_on_plate");
    level flag::wait_till("dgcwf_sw1_pressed");
    playsoundatposition("evt_sq_dgcwf_gears", self.origin);
}

// Namespace zm_temple_sq_dgcwf
// Params 1, eflags: 0x1 linked
// Checksum 0x72a047bf, Offset: 0x1310
// Size: 0x146
function function_cc3f3f6a(success) {
    if (isdefined(level.var_19e4094c)) {
        level.var_19e4094c = undefined;
        level.var_a4c38233 destroy();
        level.var_a4c38233 = undefined;
        level.var_e4afe5fb destroy();
        level.var_e4afe5fb = undefined;
    }
    trig = getent("sq_dgcwf_trig", "targetname");
    trig triggerenable(0);
    if (success) {
        zm_temple_sq_brock::function_67e052f1(3);
    } else {
        zm_temple_sq_brock::function_67e052f1(2, &zm_temple_sq_brock::function_942b1627);
        level thread zm_temple_sq_skits::function_b6268f3d();
    }
    level.var_c502e691 = 0;
    if (isdefined(level.var_dac46a9f)) {
        level.var_dac46a9f delete();
        level.var_dac46a9f = undefined;
    }
}

// Namespace zm_temple_sq_dgcwf
// Params 0, eflags: 0x1 linked
// Checksum 0x34821354, Offset: 0x1460
// Size: 0x216
function function_5be7878a() {
    level endon(#"hash_4022caee");
    struct = struct::get("sq_location_dgcwf", "targetname");
    if (!isdefined(struct)) {
        return;
    }
    level.var_dac46a9f = spawn("script_origin", struct.origin);
    if (isdefined(self)) {
        level.var_c502e691 = 1;
        self playsoundwithnotify("vox_egg_story_2_0" + zm_temple_sq::function_26186755(self.characterindex), "vox_egg_sounddone");
        self waittill(#"vox_egg_sounddone");
        level.var_c502e691 = 0;
    }
    level.var_dac46a9f playsoundwithnotify("vox_egg_story_2_1", "sounddone");
    level.var_dac46a9f waittill(#"sounddone");
    if (isdefined(self)) {
        level.var_c502e691 = 1;
        self playsoundwithnotify("vox_egg_story_2_2" + zm_temple_sq::function_26186755(self.characterindex), "vox_egg_sounddone");
        self waittill(#"vox_egg_sounddone");
        level.var_c502e691 = 0;
    }
    level flag::wait_till("dgcwf_sw1_pressed");
    level.var_dac46a9f playsoundwithnotify("vox_egg_story_2_3", "sounddone");
    level.var_dac46a9f waittill(#"sounddone");
    level flag::set("dgcwf_plot_vo_done");
    level.var_dac46a9f delete();
    level.var_dac46a9f = undefined;
}

