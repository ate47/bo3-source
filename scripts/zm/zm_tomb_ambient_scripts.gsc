#using scripts/zm/_zm_utility;
#using scripts/shared/ai/zombie_utility;
#using scripts/shared/fx_shared;
#using scripts/shared/util_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/audio_shared;
#using scripts/shared/array_shared;
#using scripts/codescripts/struct;

#namespace namespace_a2c37c4f;

// Namespace namespace_a2c37c4f
// Params 0, eflags: 0x1 linked
// Checksum 0xb9151ec8, Offset: 0x348
// Size: 0x34
function function_c6ff3260() {
    clientfield::register("scriptmover", "zeppelin_fx", 21000, 1, "int");
}

// Namespace namespace_a2c37c4f
// Params 0, eflags: 0x1 linked
// Checksum 0x84934736, Offset: 0x388
// Size: 0x9c
function main() {
    level thread function_f903959b("sky_cowbell_zeppelin_low", "stop_ambient_zeppelins");
    util::delay(20, undefined, &function_f903959b, "sky_cowbell_zeppelin_mid", "stop_ambient_zeppelins");
    util::delay(40, undefined, &function_f903959b, "sky_cowbell_zeppelin_high", "stop_ambient_zeppelins");
}

// Namespace namespace_a2c37c4f
// Params 2, eflags: 0x1 linked
// Checksum 0x40ce1a5f, Offset: 0x430
// Size: 0xd8
function function_f903959b(str_script_noteworthy, str_ender) {
    level endon(str_ender);
    var_2886e6bb = struct::get_array(str_script_noteworthy, "script_noteworthy");
    if (var_2886e6bb.size > 0) {
        var_dc0b1d8 = util::spawn_model("veh_t7_dlc_zm_zeppelin", (0, 0, 0));
        var_dc0b1d8 setforcenocull();
        var_dc0b1d8 clientfield::set("zeppelin_fx", 1);
        while (true) {
            var_dc0b1d8 function_68c49762(var_2886e6bb);
        }
    }
}

// Namespace namespace_a2c37c4f
// Params 1, eflags: 0x1 linked
// Checksum 0x8db9a111, Offset: 0x510
// Size: 0x1e0
function function_68c49762(a_structs) {
    var_ef3ca11f = function_f779394c(a_structs);
    self ghost();
    self moveto(var_ef3ca11f.origin, 0.1);
    self rotateto(var_ef3ca11f.angles, 0.1);
    self waittill(#"movedone");
    self show();
    if (!isdefined(var_ef3ca11f.goal_struct)) {
        /#
            assert(isdefined(var_ef3ca11f.target), "veh_t7_dlc_zm_zeppelin" + var_ef3ca11f.origin + "veh_t7_dlc_zm_zeppelin");
        #/
        var_ef3ca11f.goal_struct = struct::get(var_ef3ca11f.target, "targetname");
        /#
            assert(isdefined(var_ef3ca11f.goal_struct), "veh_t7_dlc_zm_zeppelin" + var_ef3ca11f.origin);
        #/
    }
    n_move_time = randomfloatrange(120, 150);
    self moveto(var_ef3ca11f.goal_struct.origin, n_move_time);
    self waittill(#"movedone");
}

// Namespace namespace_a2c37c4f
// Params 1, eflags: 0x1 linked
// Checksum 0x370dba90, Offset: 0x6f8
// Size: 0x190
function function_f779394c(a_structs) {
    var_2287af7e = [];
    for (var_d2fcef75 = 0; !var_2287af7e.size; var_d2fcef75 = 1) {
        foreach (struct in a_structs) {
            if (!isdefined(struct.used) || var_d2fcef75) {
                struct.used = 0;
            }
            if (!struct.used) {
                if (!isdefined(var_2287af7e)) {
                    var_2287af7e = [];
                } else if (!isarray(var_2287af7e)) {
                    var_2287af7e = array(var_2287af7e);
                }
                var_2287af7e[var_2287af7e.size] = struct;
            }
        }
        if (!var_2287af7e.size) {
        }
    }
    var_7ed4443d = array::random(var_2287af7e);
    var_7ed4443d.used = 1;
    return var_7ed4443d;
}

// Namespace namespace_a2c37c4f
// Params 0, eflags: 0x1 linked
// Checksum 0x20a75e48, Offset: 0x890
// Size: 0x16c
function function_add29756() {
    var_e1149395 = getent("ambiance_dogfights_1", "targetname");
    var_7170dfe = getent("ambiance_dogfights_2", "targetname");
    if (!level.var_d960a2b6) {
        level flag::init("animation_plane_1_done");
        level flag::init("animation_plane_2_done");
        level flag::init("play_animation_planes");
        var_e1149395.var_76d4be72 = "animation_plane_1_done";
        var_7170dfe.var_76d4be72 = "animation_plane_2_done";
        level.var_1766c187 = 0;
        var_e1149395 thread function_b6165329();
        var_7170dfe thread function_b6165329();
        level thread function_511ab91d();
        return;
    }
    var_e1149395 delete();
    var_7170dfe delete();
}

// Namespace namespace_a2c37c4f
// Params 0, eflags: 0x1 linked
// Checksum 0x8cbbd44e, Offset: 0xa08
// Size: 0x70
function function_b6165329() {
    while (true) {
        level flag::wait_till("play_animation_planes");
        self scene::play(self.str_scene, self);
        level flag::set(self.var_76d4be72);
    }
}

// Namespace namespace_a2c37c4f
// Params 0, eflags: 0x1 linked
// Checksum 0xbf47243d, Offset: 0xa80
// Size: 0x230
function function_511ab91d() {
    var_e1149395 = getent("ambiance_dogfights_1", "targetname");
    var_7170dfe = getent("ambiance_dogfights_2", "targetname");
    while (true) {
        var_f4570d42 = randomint(3);
        if (level.var_1766c187) {
            var_f4570d42 = 0;
        }
        switch (var_f4570d42) {
        case 0:
            var_e1149395.str_scene = "p7_fxanim_zm_ori_dogfights_bundle";
            var_7170dfe.str_scene = "p7_fxanim_zm_ori_dogfights_bundle";
            level.var_1766c187 = 0;
            break;
        case 1:
            var_e1149395.str_scene = "p7_fxanim_zm_ori_dogfights_smoke_bundle";
            var_7170dfe.str_scene = "p7_fxanim_zm_ori_dogfights_bundle";
            level.var_1766c187 = 1;
            break;
        case 2:
            var_e1149395.str_scene = "p7_fxanim_zm_ori_dogfights_bundle";
            var_7170dfe.str_scene = "p7_fxanim_zm_ori_dogfights_smoke_bundle";
            level.var_1766c187 = 1;
            break;
        }
        level flag::set("play_animation_planes");
        level flag::wait_till("animation_plane_1_done");
        level flag::wait_till("animation_plane_2_done");
        level flag::clear("animation_plane_1_done");
        level flag::clear("animation_plane_2_done");
        level flag::clear("play_animation_planes");
    }
}

