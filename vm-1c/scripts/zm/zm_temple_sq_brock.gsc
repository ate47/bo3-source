#using scripts/zm/zm_temple_sq;
#using scripts/zm/_zm_sidequests;
#using scripts/zm/_zm_audio;
#using scripts/shared/util_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/array_shared;
#using scripts/codescripts/struct;

#namespace namespace_abd6a8a5;

// Namespace namespace_abd6a8a5
// Params 0, eflags: 0x1 linked
// Checksum 0x50d3e64c, Offset: 0x208
// Size: 0x64
function init() {
    level flag::init("radio_4_played");
    level.var_3a44365b = [];
    level.var_e8454311 = [];
    level.var_fd3a0c76 = struct::get_array("sq_radios", "targetname");
}

// Namespace namespace_abd6a8a5
// Params 0, eflags: 0x1 linked
// Checksum 0xb7c30401, Offset: 0x278
// Size: 0x7e
function function_62cde5c8() {
    if (isdefined(level.var_be16ea09)) {
        level.var_be16ea09.trigger delete();
        level.var_be16ea09 stopsounds();
        util::wait_network_frame();
        level.var_be16ea09 delete();
        level.var_be16ea09 = undefined;
    }
}

// Namespace namespace_abd6a8a5
// Params 0, eflags: 0x1 linked
// Checksum 0x962b93f3, Offset: 0x300
// Size: 0x1c
function function_ac4ad5b0() {
    level thread function_62cde5c8();
}

// Namespace namespace_abd6a8a5
// Params 0, eflags: 0x1 linked
// Checksum 0x68f4c0aa, Offset: 0x328
// Size: 0x3c
function function_b58e4e4e() {
    self endon(#"death");
    while (true) {
        self waittill(#"trigger");
        self.var_bbca234 notify(#"triggered");
    }
}

// Namespace namespace_abd6a8a5
// Params 0, eflags: 0x1 linked
// Checksum 0x315fe699, Offset: 0x370
// Size: 0x6e
function function_5be153a() {
    self endon(#"death");
    level endon(#"hash_7a9a61a6");
    /#
        while (!(isdefined(level.disable_print3d_ent) && level.disable_print3d_ent)) {
            print3d(self.origin, "radio_9_played", (0, -1, -1), 1);
            wait(1);
        }
    #/
}

// Namespace namespace_abd6a8a5
// Params 1, eflags: 0x1 linked
// Checksum 0xca01e1d0, Offset: 0x3e8
// Size: 0x304
function function_f38875fe(struct) {
    self notify(#"hash_5badb82d");
    self endon(#"death");
    self.trigger delete();
    self ghost();
    var_da5d3a32 = level.var_d24533c5["sq"];
    if (var_da5d3a32.var_57800922 >= 3) {
        return;
    }
    level waittill(#"picked_up");
    level waittill(#"hash_d4e1b9c");
    self show();
    for (target = struct.target; isdefined(target); target = struct.target) {
        struct = struct::get(target, "targetname");
        time = struct.script_float;
        if (!isdefined(time)) {
            time = 1;
        }
        self moveto(struct.origin, time, time / 10);
        self waittill(#"movedone");
    }
    self.trigger = spawn("trigger_radius_use", self.origin + (0, 0, 12), 0, 64, 72);
    self.trigger triggerignoreteam();
    self.trigger.radius = 64;
    self.trigger.height = 72;
    self.trigger setcursorhint("HINT_NOICON");
    self.trigger.var_bbca234 = self;
    self.trigger thread function_b58e4e4e();
    self waittill(#"triggered");
    snd = "vox_radio_egg_" + self.script_int - 1;
    self playsound(snd);
    self playloopsound("vox_radio_egg_snapshot", 1);
    wait(self.var_55a5f7cd);
    self stoploopsound(1);
    level flag::set("radio_9_played");
}

// Namespace namespace_abd6a8a5
// Params 1, eflags: 0x1 linked
// Checksum 0xaf8cd1c8, Offset: 0x6f8
// Size: 0x44
function function_437f8b58(struct) {
    self endon(#"death");
    self waittill(#"triggered");
    level flag::set("radio_7_played");
}

// Namespace namespace_abd6a8a5
// Params 1, eflags: 0x1 linked
// Checksum 0x7f699553, Offset: 0x748
// Size: 0x44
function function_4b89aecd(struct) {
    self endon(#"death");
    self waittill(#"triggered");
    level flag::set("radio_4_played");
}

// Namespace namespace_abd6a8a5
// Params 1, eflags: 0x1 linked
// Checksum 0x62d263e3, Offset: 0x798
// Size: 0x184
function function_942b1627(struct) {
    self endon(#"death");
    self notify(#"hash_5badb82d");
    self waittill(#"triggered");
    var_8e0fe378 = level.var_200dc0e8.characterindex;
    if (!isdefined(var_8e0fe378)) {
        var_8e0fe378 = 0;
    }
    var_bc7547cb = "a";
    switch (var_8e0fe378) {
    case 0:
        var_bc7547cb = "a";
        break;
    case 1:
        var_bc7547cb = "b";
        break;
    case 2:
        var_bc7547cb = "d";
        break;
    case 3:
        var_bc7547cb = "c";
        break;
    }
    snd = "vox_radio_egg_" + self.script_int - 1 + "" + var_bc7547cb;
    self playsoundwithnotify(snd, "radiodone");
    self playloopsound("vox_radio_egg_snapshot", 1);
    self waittill(#"hash_b022f226");
    self stoploopsound(1);
}

// Namespace namespace_abd6a8a5
// Params 0, eflags: 0x1 linked
// Checksum 0xebe5cdef, Offset: 0x928
// Size: 0xb4
function function_67bda13d() {
    self endon(#"death");
    self endon(#"hash_5badb82d");
    self thread function_5be153a();
    self waittill(#"triggered");
    snd = "vox_radio_egg_" + self.script_int - 1;
    self playsound(snd);
    self playloopsound("vox_radio_egg_snapshot", 1);
    wait(self.var_55a5f7cd);
    self stoploopsound(1);
}

// Namespace namespace_abd6a8a5
// Params 2, eflags: 0x1 linked
// Checksum 0x87564af8, Offset: 0x9e8
// Size: 0x2c8
function function_67e052f1(var_246d8227, thread_func) {
    function_ac4ad5b0();
    var_def302fa = undefined;
    for (i = 0; i < level.var_fd3a0c76.size; i++) {
        if (level.var_fd3a0c76[i].script_int == var_246d8227) {
            var_def302fa = level.var_fd3a0c76[i];
            break;
        }
    }
    if (!isdefined(var_def302fa)) {
        println("radio_9_played" + var_246d8227);
        return;
    }
    radio = spawn("script_model", var_def302fa.origin);
    radio.angles = var_def302fa.angles;
    radio setmodel("p7_zm_sha_recorder_digital");
    radio.script_int = var_def302fa.script_int;
    radio.script_noteworthy = var_def302fa.script_noteworthy;
    radio function_d17329dc(var_246d8227);
    radio.trigger = spawn("trigger_radius_use", radio.origin + (0, 0, 12), 0, 64, 72);
    radio.trigger triggerignoreteam();
    radio.trigger.radius = 64;
    radio.trigger.height = 72;
    radio.trigger setcursorhint("HINT_NOICON");
    radio.trigger.var_bbca234 = radio;
    radio.trigger thread function_b58e4e4e();
    radio thread function_67bda13d();
    if (isdefined(thread_func)) {
        radio thread [[ thread_func ]](var_def302fa);
    }
    level.var_be16ea09 = radio;
}

// Namespace namespace_abd6a8a5
// Params 1, eflags: 0x1 linked
// Checksum 0xce6d9fcc, Offset: 0xcb8
// Size: 0x118
function function_d17329dc(num) {
    if (!isdefined(num)) {
        num = 1;
    }
    waittime = 45;
    switch (num) {
    case 1:
        waittime = 113;
        break;
    case 2:
        waittime = 95;
        break;
    case 3:
        waittime = 20;
        break;
    case 4:
        waittime = 58;
        break;
    case 5:
        waittime = 74;
        break;
    case 6:
        waittime = 35;
        break;
    case 7:
        waittime = 40;
        break;
    case 8:
        waittime = 39;
        break;
    case 9:
        waittime = 76;
        break;
    }
    self.var_55a5f7cd = waittime;
}

