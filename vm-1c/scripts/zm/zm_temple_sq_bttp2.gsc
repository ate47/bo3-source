#using scripts/codescripts/struct;
#using scripts/shared/array_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/util_shared;
#using scripts/zm/_zm_audio;
#using scripts/zm/_zm_sidequests;
#using scripts/zm/zm_temple_sq;
#using scripts/zm/zm_temple_sq_brock;
#using scripts/zm/zm_temple_sq_skits;

#namespace zm_temple_sq_bttp2;

// Namespace zm_temple_sq_bttp2
// Params 0, eflags: 0x0
// Checksum 0xd186088f, Offset: 0x260
// Size: 0x84
function init() {
    namespace_6e97c459::function_5a90ed82("sq", "bttp2", &init_stage, &function_7747c56, &function_cc3f3f6a);
    namespace_6e97c459::function_b9676730("sq", "bttp2", 300, &function_e9d67422);
}

// Namespace zm_temple_sq_bttp2
// Params 0, eflags: 0x0
// Checksum 0x4edcd52f, Offset: 0x2f0
// Size: 0x104
function init_stage() {
    level notify(#"hash_d146ae8a");
    level.var_64d74143 = 0;
    var_8d7cec26 = getentarray("sq_bttp2_dial", "targetname");
    level.var_83becb0e = var_8d7cec26.size;
    array::thread_all(var_8d7cec26, &function_5ac3fada);
    zm_temple_sq_brock::function_ac4ad5b0();
    if (level flag::get("radio_7_played")) {
        level thread function_9873f186("tt7a");
    } else {
        level thread function_9873f186("tt7b");
    }
    level thread function_6908dcf2();
}

// Namespace zm_temple_sq_bttp2
// Params 1, eflags: 0x0
// Checksum 0x9a0c0d1d, Offset: 0x400
// Size: 0x2c
function function_9873f186(skit) {
    wait 0.5;
    level thread zm_temple_sq_skits::function_acc79afb(skit);
}

// Namespace zm_temple_sq_bttp2
// Params 0, eflags: 0x0
// Checksum 0x9ae07db1, Offset: 0x438
// Size: 0x2b4
function function_6908dcf2() {
    wait 25;
    var_1e806caa = struct::get("sq_bttp2_bolt_from_the_blue_a", "targetname");
    var_2b775263 = struct::get("sq_bttp2_bolt_from_the_blue_b", "targetname");
    a = spawn("script_model", var_1e806caa.origin);
    a setmodel("tag_origin");
    util::wait_network_frame();
    b = spawn("script_model", var_2b775263.origin);
    b setmodel("tag_origin");
    util::wait_network_frame();
    original_origin = a.origin;
    for (i = 0; i < 7; i++) {
        yaw = randomfloat(360);
        r = randomfloatrange(500, 1000);
        amntx = cos(yaw) * r;
        amnty = sin(yaw) * r;
        a.origin = original_origin + (amntx, amnty, 0);
        zm_temple_sq::function_f5c88bbf(a, b, 0);
        wait 0.55;
    }
    wait 5;
    a.origin = original_origin;
    zm_temple_sq::function_f5c88bbf(b, a, 1);
    wait 1;
    a delete();
    b delete();
}

// Namespace zm_temple_sq_bttp2
// Params 0, eflags: 0x0
// Checksum 0xf5ffd8ed, Offset: 0x6f8
// Size: 0x36
function function_e9d67422() {
    if (level flag::get("radio_7_played")) {
        return 300;
    }
    return 60;
}

// Namespace zm_temple_sq_bttp2
// Params 0, eflags: 0x0
// Checksum 0x3306c818, Offset: 0x738
// Size: 0xac
function function_7747c56() {
    while (level.var_64d74143 != level.var_83becb0e) {
        wait 0.1;
    }
    level notify(#"hash_15ab69d8");
    level notify(#"hash_87b2d913");
    level notify(#"hash_61b05eaa");
    level notify(#"hash_d3b7cde5");
    level notify(#"hash_adb5537c");
    level notify(#"hash_1fbcc2b7", 1);
    level waittill(#"hash_a6dd8381");
    wait 5;
    namespace_6e97c459::function_2f3ced1f("sq", "bttp2");
}

// Namespace zm_temple_sq_bttp2
// Params 1, eflags: 0x0
// Checksum 0x935db095, Offset: 0x7f0
// Size: 0xbc
function function_cc3f3f6a(success) {
    var_8d7cec26 = getentarray("sq_bttp2_dial", "targetname");
    array::thread_all(var_8d7cec26, &function_fbbc8808);
    if (success) {
        zm_temple_sq_brock::function_67e052f1(8);
        return;
    }
    zm_temple_sq_brock::function_67e052f1(7, &zm_temple_sq_brock::function_437f8b58);
    level thread zm_temple_sq_skits::function_b6268f3d();
}

// Namespace zm_temple_sq_bttp2
// Params 0, eflags: 0x0
// Checksum 0xa5d758c, Offset: 0x8b8
// Size: 0x58
function function_58999522() {
    level endon(#"hash_d146ae8a");
    level endon(#"hash_1ee44755");
    while (true) {
        self waittill(#"triggered", who);
        self.var_bbca234 notify(#"triggered", who);
    }
}

// Namespace zm_temple_sq_bttp2
// Params 0, eflags: 0x0
// Checksum 0xde0257d5, Offset: 0x918
// Size: 0x254
function function_5ac3fada() {
    if (!level flag::get("radio_7_played")) {
        self thread function_fbbc8808("We don't know what we're doing.");
    }
    level endon(#"hash_1ee44755");
    self.angles = self.original_angles;
    pos = randomintrange(0, 3);
    if (pos == self.script_int) {
        pos = (pos + 1) % 4;
    }
    self rotatepitch(90 * pos, 0.01);
    var_ab6d45a1 = 0;
    while (!(isdefined(level.disable_print3d_ent) && level.disable_print3d_ent)) {
        self waittill(#"triggered", who);
        self playsound("evt_sq_bttp2_wheel_turn");
        self rotatepitch(90, 0.25);
        self waittill(#"rotatedone");
        pos = (pos + 1) % 4;
        if (pos == self.script_int) {
            level.var_64d74143++;
            /#
                print3d(self.origin, "<dev string:x28>", (0, 255, 0), 10);
            #/
            var_ab6d45a1 = 1;
            if (isdefined(who) && isplayer(who)) {
                if (level.var_64d74143 == level.var_83becb0e) {
                    who thread zm_audio::create_and_play_dialog("eggs", "quest7", 0);
                }
            }
        } else if (var_ab6d45a1) {
            var_ab6d45a1 = 0;
            level.var_64d74143--;
        }
        wait 0.1;
    }
}

// Namespace zm_temple_sq_bttp2
// Params 1, eflags: 0x0
// Checksum 0xc7f79e9d, Offset: 0xb78
// Size: 0x128
function function_fbbc8808(var_10be97cb) {
    level endon(#"hash_d146ae8a");
    self.trigger thread function_58999522();
    if (!isdefined(self.original_angles)) {
        self.original_angles = self.angles;
    }
    self.angles = self.original_angles;
    rot = randomintrange(0, 3);
    self rotatepitch(rot * 90, 0.01);
    while (true) {
        self waittill(#"triggered");
        self playsound("evt_sq_bttp2_wheel_turn");
        if (isdefined(var_10be97cb)) {
            /#
                iprintlnbold("<dev string:x2a>" + var_10be97cb);
            #/
        }
        self rotatepitch(90, 0.25);
    }
}

