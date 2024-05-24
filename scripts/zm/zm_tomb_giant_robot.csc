#using scripts/zm/zm_tomb_amb;
#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_audio;
#using scripts/shared/util_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/audio_shared;
#using scripts/shared/array_shared;
#using scripts/codescripts/struct;

#namespace namespace_d1b0a244;

// Namespace namespace_d1b0a244
// Params 0, eflags: 0x0
// Checksum 0xe6e67f5a, Offset: 0x688
// Size: 0x55c
function init() {
    clientfield::register("scriptmover", "register_giant_robot", 21000, 1, "int", &function_63ccebe9, 0, 0);
    clientfield::register("world", "start_anim_robot_0", 21000, 1, "int", &function_7e19465b, 0, 0);
    clientfield::register("world", "start_anim_robot_1", 21000, 1, "int", &function_7e19465b, 0, 0);
    clientfield::register("world", "start_anim_robot_2", 21000, 1, "int", &function_7e19465b, 0, 0);
    clientfield::register("world", "play_foot_stomp_fx_robot_0", 21000, 2, "int", &function_36b7480d, 0, 0);
    clientfield::register("world", "play_foot_stomp_fx_robot_1", 21000, 2, "int", &function_36b7480d, 0, 0);
    clientfield::register("world", "play_foot_stomp_fx_robot_2", 21000, 2, "int", &function_36b7480d, 0, 0);
    clientfield::register("world", "play_foot_open_fx_robot_0", 21000, 2, "int", &function_6e99bd62, 0, 0);
    clientfield::register("world", "play_foot_open_fx_robot_1", 21000, 2, "int", &function_6e99bd62, 0, 0);
    clientfield::register("world", "play_foot_open_fx_robot_2", 21000, 2, "int", &function_6e99bd62, 0, 0);
    clientfield::register("world", "eject_warning_fx_robot_0", 21000, 1, "int", &function_aa136ff9, 0, 0);
    clientfield::register("world", "eject_warning_fx_robot_1", 21000, 1, "int", &function_aa136ff9, 0, 0);
    clientfield::register("world", "eject_warning_fx_robot_2", 21000, 1, "int", &function_aa136ff9, 0, 0);
    clientfield::register("scriptmover", "light_foot_fx_robot", 21000, 2, "int", &function_98a05ad2, 0, 0);
    clientfield::register("allplayers", "eject_steam_fx", 21000, 1, "int", &function_d4c69cd, 0, 0);
    clientfield::register("allplayers", "all_tubes_play_eject_steam_fx", 21000, 1, "int", &function_3a627e4d, 0, 0);
    clientfield::register("allplayers", "gr_eject_player_impact_fx", 21000, 1, "int", &function_5e616b8a, 0, 0);
    clientfield::register("toplayer", "giant_robot_rumble_and_shake", 21000, 2, "int", &function_c50fd966, 0, 0);
    clientfield::register("world", "church_ceiling_fxanim", 21000, 1, "int", &function_fd1be446, 0, 0);
}

// Namespace namespace_d1b0a244
// Params 7, eflags: 0x0
// Checksum 0xa40440cc, Offset: 0xbf0
// Size: 0xf0
function function_63ccebe9(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
    if (!isdefined(level.var_64f7be48)) {
        level.var_64f7be48 = [];
        level.var_64f7be48[localclientnum] = [];
    }
    if (self.model == "veh_t7_zhd_robot_0") {
        level.var_64f7be48[localclientnum][0] = self;
        return;
    }
    if (self.model == "veh_t7_zhd_robot_1") {
        level.var_64f7be48[localclientnum][1] = self;
        return;
    }
    if (self.model == "veh_t7_zhd_robot_2") {
        level.var_64f7be48[localclientnum][2] = self;
    }
}

// Namespace namespace_d1b0a244
// Params 7, eflags: 0x0
// Checksum 0x8ba9d4d7, Offset: 0xce8
// Size: 0x1f4
function function_36b7480d(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
    var_f6c5842 = function_9f95c19e(localclientnum, fieldname);
    if (!isdefined(var_f6c5842)) {
        return;
    }
    var_f6c5842 thread function_d46dfa88(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump);
    if (newval == 1) {
        var_f6c5842.var_16a8765e = playfxontag(localclientnum, level._effect["robot_foot_stomp"], var_f6c5842, "tag_hatch_fx_ri");
        origin = var_f6c5842 gettagorigin("tag_hatch_fx_ri");
        playsound(0, "zmb_robot_foot_impact", origin);
    } else if (newval == 2) {
        var_f6c5842.var_16a8765e = playfxontag(localclientnum, level._effect["robot_foot_stomp"], var_f6c5842, "tag_hatch_fx_le");
        origin = var_f6c5842 gettagorigin("tag_hatch_fx_le");
        playsound(0, "zmb_robot_foot_impact", origin);
    }
    setfxignorepause(localclientnum, var_f6c5842.var_16a8765e, 1);
}

// Namespace namespace_d1b0a244
// Params 7, eflags: 0x0
// Checksum 0x283316e3, Offset: 0xee8
// Size: 0x13c
function function_98a05ad2(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
    if (newval == 1) {
        self.var_e655463b = playfxontag(localclientnum, level._effect["giant_robot_foot_light"], self, "tag_foot_bottom_left");
        setfxignorepause(localclientnum, self.var_e655463b, 1);
        return;
    }
    if (newval == 2) {
        self.var_e655463b = playfxontag(localclientnum, level._effect["giant_robot_foot_light"], self, "tag_foot_bottom_right");
        setfxignorepause(localclientnum, self.var_e655463b, 1);
        return;
    }
    if (isdefined(self.var_e655463b)) {
        killfx(localclientnum, self.var_e655463b);
    }
}

// Namespace namespace_d1b0a244
// Params 7, eflags: 0x0
// Checksum 0x3b274852, Offset: 0x1030
// Size: 0x394
function function_6e99bd62(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
    var_f6c5842 = function_9f95c19e(localclientnum, fieldname);
    if (!isdefined(var_f6c5842)) {
        return;
    }
    var_e5bf8324 = (0, 0, 56);
    if (newval == 1) {
        var_c5f81ff5 = var_f6c5842 gettagorigin("tag_hatch_fx_ri");
        var_c5f81ff5 -= var_e5bf8324;
        var_f6c5842.var_140b6e83 = spawn(localclientnum, var_c5f81ff5, "script_model");
        var_f6c5842.var_140b6e83 setmodel("tag_origin");
        var_f6c5842.var_140b6e83 linkto(var_f6c5842, "tag_hatch_fx_ri");
        var_f6c5842.var_140b6e83 playsound(0, "zmb_zombieblood_3rd_plane_explode");
        var_f6c5842.var_140b6e83.n_death_fx = playfxontag(localclientnum, level._effect["mechz_death"], var_f6c5842.var_140b6e83, "tag_origin");
        setfxignorepause(localclientnum, var_f6c5842.var_140b6e83.n_death_fx, 1);
        return;
    }
    if (newval == 2) {
        var_c5f81ff5 = var_f6c5842 gettagorigin("tag_hatch_fx_le");
        var_c5f81ff5 -= var_e5bf8324;
        var_f6c5842.var_140b6e83 = spawn(localclientnum, var_c5f81ff5, "script_model");
        var_f6c5842.var_140b6e83 setmodel("tag_origin");
        var_f6c5842.var_140b6e83 linkto(var_f6c5842, "tag_hatch_fx_le");
        var_f6c5842.var_140b6e83 playsound(0, "zmb_zombieblood_3rd_plane_explode");
        var_f6c5842.var_140b6e83.n_death_fx = playfxontag(localclientnum, level._effect["mechz_death"], var_f6c5842.var_140b6e83, "tag_origin");
        setfxignorepause(localclientnum, var_f6c5842.var_140b6e83.n_death_fx, 1);
        return;
    }
    if (isdefined(var_f6c5842.var_140b6e83)) {
        var_f6c5842.var_140b6e83 delete();
    }
}

// Namespace namespace_d1b0a244
// Params 7, eflags: 0x0
// Checksum 0xbe012b68, Offset: 0x13d0
// Size: 0x1a4
function function_aa136ff9(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
    if (newval == 1) {
        s_origin = struct::get(fieldname, "targetname");
        var_c5f81ff5 = s_origin.origin;
        level.fieldname[localclientnum] = spawn(localclientnum, var_c5f81ff5, "script_model");
        level.fieldname[localclientnum] setmodel("tag_origin");
        level.fieldname[localclientnum].var_68f810db = playfxontag(localclientnum, level._effect["eject_warning"], level.fieldname[localclientnum], "tag_origin");
        setfxignorepause(localclientnum, level.fieldname[localclientnum].var_68f810db, 1);
        return;
    }
    if (isdefined(level.fieldname[localclientnum])) {
        level.fieldname[localclientnum] delete();
    }
}

// Namespace namespace_d1b0a244
// Params 7, eflags: 0x0
// Checksum 0x5a64dd06, Offset: 0x1580
// Size: 0xa4
function function_d4c69cd(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
    if (newval == 1) {
        self thread function_691b8375(localclientnum);
        return;
    }
    self notify(#"hash_968de603");
    if (isdefined(self.fieldname)) {
        stopfx(localclientnum, self.fieldname);
    }
}

// Namespace namespace_d1b0a244
// Params 1, eflags: 0x0
// Checksum 0x43d184b6, Offset: 0x1630
// Size: 0x150
function function_691b8375(localclientnum) {
    self endon(#"hash_968de603");
    self endon(#"player_intermission");
    a_s_tubes = struct::get_array("giant_robot_eject_tube", "script_noteworthy");
    s_tube = arraygetclosest(self.origin, a_s_tubes);
    self thread function_caeb1b02("stop_eject_steam_fx", s_tube.origin);
    while (isdefined(self)) {
        self.fieldname = playfx(localclientnum, level._effect["eject_steam"], s_tube.origin, anglestoforward(s_tube.angles), anglestoup(s_tube.angles));
        setfxignorepause(localclientnum, self.fieldname, 1);
        wait(0.1);
    }
}

// Namespace namespace_d1b0a244
// Params 7, eflags: 0x0
// Checksum 0x58eb7369, Offset: 0x1788
// Size: 0x23e
function function_3a627e4d(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
    if (newval == 1) {
        var_66a1e889 = struct::get_array("giant_robot_eject_tube", "script_noteworthy");
        var_8356f695 = arraygetclosest(self.origin, var_66a1e889);
        var_9a1bfdd4 = var_8356f695.script_int;
        level.a_s_tubes = [];
        level.a_s_tubes[localclientnum] = [];
        n_index = 0;
        foreach (struct in var_66a1e889) {
            if (struct.script_int == var_9a1bfdd4) {
                struct thread function_3ae72e85(localclientnum);
                level.a_s_tubes[localclientnum][n_index] = struct;
                n_index++;
            }
        }
        return;
    }
    if (isdefined(level.a_s_tubes[localclientnum])) {
        foreach (struct in level.a_s_tubes[localclientnum]) {
            struct notify(#"hash_e54dfe36");
        }
    }
}

// Namespace namespace_d1b0a244
// Params 1, eflags: 0x0
// Checksum 0xd3492bfd, Offset: 0x19d0
// Size: 0xd8
function function_3ae72e85(localclientnum) {
    self endon(#"hash_e54dfe36");
    self thread function_caeb1b02("stop_all_tubes_eject_steam", self.origin);
    while (true) {
        self.var_d1c8c63f = playfx(localclientnum, level._effect["eject_steam"], self.origin, anglestoforward(self.angles), anglestoup(self.angles));
        setfxignorepause(localclientnum, self.var_d1c8c63f, 1);
        wait(0.1);
    }
}

// Namespace namespace_d1b0a244
// Params 2, eflags: 0x0
// Checksum 0x21e2ab7a, Offset: 0x1ab0
// Size: 0x5c
function function_caeb1b02(var_365d1fde, origin) {
    audio::playloopat("zmb_bot_timeout_steam", origin);
    self waittill(var_365d1fde);
    audio::stoploopat("zmb_bot_timeout_steam", origin);
}

// Namespace namespace_d1b0a244
// Params 7, eflags: 0x0
// Checksum 0x158a1f04, Offset: 0x1b18
// Size: 0xd4
function function_5e616b8a(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
    if (newval == 1) {
        self.fieldname = playfx(localclientnum, level._effect["beacon_shell_explosion"], self.origin);
        setfxignorepause(localclientnum, self.fieldname, 1);
        return;
    }
    if (isdefined(self.fieldname)) {
        stopfx(localclientnum, self.fieldname);
    }
}

// Namespace namespace_d1b0a244
// Params 2, eflags: 0x0
// Checksum 0x2b020f8b, Offset: 0x1bf8
// Size: 0x128
function function_9f95c19e(localclientnum, fieldname) {
    if (!isdefined(level.var_64f7be48) || !isdefined(level.var_64f7be48[localclientnum])) {
        return undefined;
    }
    var_f6c5842 = undefined;
    if (issubstr(fieldname, 0)) {
        var_f6c5842 = level.var_64f7be48[localclientnum][0];
        if (isdefined(var_f6c5842)) {
            var_f6c5842.var_90d8d560 = 0;
        }
    } else if (issubstr(fieldname, 1)) {
        var_f6c5842 = level.var_64f7be48[localclientnum][1];
        if (isdefined(var_f6c5842)) {
            var_f6c5842.var_90d8d560 = 1;
        }
    } else {
        var_f6c5842 = level.var_64f7be48[localclientnum][2];
        if (isdefined(var_f6c5842)) {
            var_f6c5842.var_90d8d560 = 2;
        }
    }
    return var_f6c5842;
}

// Namespace namespace_d1b0a244
// Params 7, eflags: 0x0
// Checksum 0x1ad288b8, Offset: 0x1d28
// Size: 0x436
function function_7e19465b(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
    if (!isdefined(level.var_58b72d2f)) {
        level.var_58b72d2f = [];
        level.var_58b72d2f[0] = spawnstruct();
        level.var_58b72d2f[0].var_426bda58 = "nml_warn_light_fp_ref";
        level.var_58b72d2f[0].var_11927f3d = struct::get_array("nml_foot_warn_light", "targetname");
        /#
            assert(level.var_58b72d2f[0].var_11927f3d.size > 0, "script_noteworthy");
        #/
        level.var_58b72d2f[1] = spawnstruct();
        level.var_58b72d2f[1].var_426bda58 = "trench_warn_light_fp_ref";
        level.var_58b72d2f[1].var_11927f3d = [];
        level.var_58b72d2f[1].var_11927f3d = struct::get_array("trench_foot_warn_light", "targetname");
        /#
            assert(level.var_58b72d2f[1].var_11927f3d.size > 0, "<unknown string>");
        #/
        level.var_58b72d2f[2] = spawnstruct();
        level.var_58b72d2f[2].var_426bda58 = "church_warn_light_fp_ref";
        level.var_58b72d2f[2].var_11927f3d = [];
        level.var_58b72d2f[2].var_11927f3d = struct::get_array("church_foot_warn_light", "targetname");
        /#
            assert(level.var_58b72d2f[2].var_11927f3d.size > 0, "<unknown string>");
        #/
    }
    var_f6c5842 = function_9f95c19e(localclientnum, fieldname);
    if (!isdefined(var_f6c5842) || !isdefined(level.var_58b72d2f[var_f6c5842.var_90d8d560])) {
        return;
    }
    if (newval == 1) {
        var_f6c5842.var_6e5e4d07 = struct::get(level.var_58b72d2f[var_f6c5842.var_90d8d560].var_426bda58 + "_left", "targetname");
        var_f6c5842.var_bd0d6d82 = struct::get(level.var_58b72d2f[var_f6c5842.var_90d8d560].var_426bda58 + "_right", "targetname");
        var_f6c5842 function_bbae1203(localclientnum, var_f6c5842.var_6e5e4d07);
        var_f6c5842 function_bbae1203(localclientnum, var_f6c5842.var_bd0d6d82);
        return;
    }
    var_f6c5842 function_aacf48b5(localclientnum);
    var_f6c5842.var_6e5e4d07 = undefined;
    var_f6c5842.var_bd0d6d82 = undefined;
}

// Namespace namespace_d1b0a244
// Params 2, eflags: 0x0
// Checksum 0xfcb0a1a7, Offset: 0x2168
// Size: 0x182
function function_bbae1203(localclientnum, var_75158c9e) {
    var_99450f8a = function_d31a2386(var_75158c9e);
    foreach (light in var_99450f8a) {
        if (!isdefined(light.var_1398bc94)) {
            if (!isdefined(light.angles)) {
                light.angles = (0, 0, 0);
            }
            light.var_1398bc94 = playfx(localclientnum, level._effect["giant_robot_footstep_warning_light"], light.origin, anglestoforward(light.angles), anglestoup(light.angles));
            setfxignorepause(localclientnum, light.var_1398bc94, 1);
        }
    }
}

// Namespace namespace_d1b0a244
// Params 2, eflags: 0x0
// Checksum 0x131d5f0f, Offset: 0x22f8
// Size: 0xe8
function function_d91e5529(localclientnum, var_75158c9e) {
    var_99450f8a = function_d31a2386(var_75158c9e);
    foreach (light in var_99450f8a) {
        if (isdefined(light.var_1398bc94)) {
            stopfx(localclientnum, light.var_1398bc94);
            light.var_1398bc94 = undefined;
        }
    }
}

// Namespace namespace_d1b0a244
// Params 1, eflags: 0x0
// Checksum 0x8c670ed3, Offset: 0x23e8
// Size: 0xd0
function function_aacf48b5(localclientnum) {
    foreach (light in level.var_58b72d2f[self.var_90d8d560].var_11927f3d) {
        if (isdefined(light.var_1398bc94)) {
            stopfx(localclientnum, light.var_1398bc94);
            light.var_1398bc94 = undefined;
        }
    }
}

// Namespace namespace_d1b0a244
// Params 1, eflags: 0x0
// Checksum 0x6998da17, Offset: 0x24c0
// Size: 0x134
function function_d31a2386(var_75158c9e) {
    var_fa1ca319 = [];
    foreach (light in level.var_58b72d2f[self.var_90d8d560].var_11927f3d) {
        if (distancesquared(var_75158c9e.origin, light.origin) < 640000) {
            if (!isdefined(var_fa1ca319)) {
                var_fa1ca319 = [];
            } else if (!isarray(var_fa1ca319)) {
                var_fa1ca319 = array(var_fa1ca319);
            }
            var_fa1ca319[var_fa1ca319.size] = light;
        }
    }
    return var_fa1ca319;
}

// Namespace namespace_d1b0a244
// Params 7, eflags: 0x0
// Checksum 0xd7cd3697, Offset: 0x2600
// Size: 0x262
function function_d46dfa88(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
    wait(1);
    if (newval == 1) {
        if (isdefined(self.var_bd0d6d82)) {
            var_8f93a98e = self gettagorigin("tag_hatch_fx_ri");
            if (distancesquared(self.var_bd0d6d82.origin, var_8f93a98e) < 300 * 300) {
                function_d91e5529(localclientnum, self.var_bd0d6d82);
                wait(0.05);
                if (isdefined(self.var_bd0d6d82.target)) {
                    self.var_bd0d6d82 = struct::get(self.var_bd0d6d82.target, "targetname");
                    function_bbae1203(localclientnum, self.var_bd0d6d82);
                } else {
                    self.var_bd0d6d82 = undefined;
                }
            }
        }
        return;
    }
    if (newval == 2) {
        if (isdefined(self.var_6e5e4d07)) {
            var_8f93a98e = self gettagorigin("tag_hatch_fx_le");
            if (distancesquared(self.var_6e5e4d07.origin, var_8f93a98e) < 300 * 300) {
                function_d91e5529(localclientnum, self.var_6e5e4d07);
                wait(0.05);
                if (isdefined(self.var_6e5e4d07.target)) {
                    self.var_6e5e4d07 = struct::get(self.var_6e5e4d07.target, "targetname");
                    function_bbae1203(localclientnum, self.var_6e5e4d07);
                    return;
                }
                self.var_6e5e4d07 = undefined;
            }
        }
    }
}

// Namespace namespace_d1b0a244
// Params 7, eflags: 0x0
// Checksum 0x72816ddb, Offset: 0x2870
// Size: 0x1d6
function function_c50fd966(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
    self endon(#"disconnect");
    if (newval == 3) {
        self earthquake(0.6, 1.5, self.origin, 100);
        self playrumbleonentity(localclientnum, "artillery_rumble");
        soundrattle(self.origin, -6, 750);
        return;
    }
    if (newval == 2) {
        self earthquake(0.3, 1.5, self.origin, 100);
        self playrumbleonentity(localclientnum, "shotgun_fire");
        soundrattle(self.origin, 100, 500);
        return;
    }
    if (newval == 1) {
        self earthquake(0.1, 1, self.origin, 100);
        self playrumbleonentity(localclientnum, "damage_heavy");
        soundrattle(self.origin, 10, 350);
        return;
    }
    self notify(#"hash_ee5c27b3");
}

// Namespace namespace_d1b0a244
// Params 7, eflags: 0x0
// Checksum 0x95eb4014, Offset: 0x2a50
// Size: 0x9c
function function_fd1be446(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
    if (newval == 1) {
        var_61cbe98c = getent(localclientnum, "church_ceiling", "targetname");
        var_61cbe98c scene::play("p7_fxanim_zm_ori_church_ceiling_bundle", var_61cbe98c);
    }
}

