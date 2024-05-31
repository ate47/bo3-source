#using scripts/zm/craftables/_zm_craftables;
#using scripts/zm/_zm_utility;
#using scripts/zm/_zm;
#using scripts/zm/_load;
#using scripts/shared/visionset_mgr_shared;
#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/audio_shared;
#using scripts/shared/array_shared;
#using scripts/shared/animation_shared;
#using scripts/codescripts/struct;

#using_animtree("generic");

#namespace namespace_5f2c95ae;

// Namespace namespace_5f2c95ae
// Params 0, eflags: 0x1 linked
// namespace_5f2c95ae<file_0>::function_c35e6aab
// Checksum 0xd237f9ca, Offset: 0x680
// Size: 0x31c
function init() {
    clientfield::register("world", "keeper_spawn_portals", 1, 1, "int", &function_a17c1f53, 0, 0);
    clientfield::register("actor", "keeper_fx", 1, 1, "int", &function_4b50c64, 0, 0);
    clientfield::register("actor", "ritual_attacker_fx", 1, 1, "int", &function_4bcd15cf, 0, 0);
    clientfield::register("world", "skullquest_ritual_1_fx", 1, 3, "int", &function_92982f75, 0, 0);
    clientfield::register("world", "skullquest_ritual_2_fx", 1, 3, "int", &function_4ded18a8, 0, 0);
    clientfield::register("world", "skullquest_ritual_3_fx", 1, 3, "int", &function_ddd543db, 0, 0);
    clientfield::register("world", "skullquest_ritual_4_fx", 1, 3, "int", &function_7c9daad6, 0, 0);
    clientfield::register("scriptmover", "skullquest_finish_start_fx", 1, 1, "int", &function_4f126a12, 0, 0);
    clientfield::register("scriptmover", "skullquest_finish_trail_fx", 1, 1, "int", &function_14555bf6, 0, 0);
    clientfield::register("scriptmover", "skullquest_finish_end_fx", 1, 1, "int", &function_a35770b3, 0, 0);
    clientfield::register("scriptmover", "skullquest_finish_done_glow_fx", 1, 1, "int", &function_936bf24a, 0, 0);
}

// Namespace namespace_5f2c95ae
// Params 7, eflags: 0x1 linked
// namespace_5f2c95ae<file_0>::function_a17c1f53
// Checksum 0x2389690d, Offset: 0x9a8
// Size: 0x6c
function function_a17c1f53(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    var_eebff756 = "s_spawnpt_skullroom";
    function_46df8306(localclientnum, var_eebff756, newval);
}

// Namespace namespace_5f2c95ae
// Params 3, eflags: 0x1 linked
// namespace_5f2c95ae<file_0>::function_46df8306
// Checksum 0xb7e64cba, Offset: 0xa20
// Size: 0x252
function function_46df8306(localclientnum, str_name, b_on) {
    if (!isdefined(b_on)) {
        b_on = 1;
    }
    a_s_spawn_points = struct::get_array(str_name, "targetname");
    foreach (s_spawn_point in a_s_spawn_points) {
        s_spawn_point function_267f859f(localclientnum, level._effect["keeper_spawn"], b_on);
        if (!isdefined(s_spawn_point.var_d52fc488)) {
            s_spawn_point.var_d52fc488 = 0;
        }
        if (isdefined(b_on) && b_on) {
            if (!(isdefined(s_spawn_point.var_d52fc488) && s_spawn_point.var_d52fc488)) {
                s_spawn_point.var_d52fc488 = 1;
                playsound(0, "evt_keeper_portal_start", s_spawn_point.origin);
                audio::playloopat("evt_keeper_portal_loop", s_spawn_point.origin);
            }
        } else if (isdefined(s_spawn_point.var_d52fc488) && s_spawn_point.var_d52fc488) {
            s_spawn_point.var_d52fc488 = 0;
            playsound(0, "evt_keeper_portal_end", s_spawn_point.origin);
            audio::stoploopat("evt_keeper_portal_loop", s_spawn_point.origin);
        }
        wait(0.2);
    }
}

// Namespace namespace_5f2c95ae
// Params 3, eflags: 0x1 linked
// namespace_5f2c95ae<file_0>::function_f58977cd
// Checksum 0x79b67a64, Offset: 0xc80
// Size: 0x2b2
function function_f58977cd(localclientnum, str_name, b_on) {
    if (!isdefined(b_on)) {
        b_on = 1;
    }
    a_s_spawn_points = struct::get_array(str_name, "targetname");
    foreach (s_spawn_point in a_s_spawn_points) {
        s_spawn_point function_267f859f(localclientnum, level._effect["ritual_portal_start"], b_on);
        s_spawn_point function_267f859f(localclientnum, level._effect["ritual_portal_loop"], b_on);
        if (!isdefined(s_spawn_point.var_d52fc488)) {
            s_spawn_point.var_d52fc488 = 0;
        }
        if (isdefined(b_on) && b_on) {
            if (!(isdefined(s_spawn_point.var_d52fc488) && s_spawn_point.var_d52fc488)) {
                s_spawn_point.var_d52fc488 = 1;
                playsound(0, "zmb_skull_ritual_portal_start", s_spawn_point.origin);
                audio::playloopat("zmb_skull_ritual_portal_lp", s_spawn_point.origin);
            }
        } else {
            s_spawn_point function_267f859f(localclientnum, level._effect["ritual_portal_end"], b_on);
            if (isdefined(s_spawn_point.var_d52fc488) && s_spawn_point.var_d52fc488) {
                s_spawn_point.var_d52fc488 = 0;
                playsound(0, "zmb_skull_ritual_portal_end", s_spawn_point.origin);
                audio::stoploopat("zmb_skull_ritual_portal_lp", s_spawn_point.origin);
            }
        }
        wait(0.2);
    }
}

// Namespace namespace_5f2c95ae
// Params 7, eflags: 0x1 linked
// namespace_5f2c95ae<file_0>::function_92982f75
// Checksum 0x34401ff1, Offset: 0xf40
// Size: 0x5c
function function_92982f75(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    function_4dcbb3a6(localclientnum, 1, newval);
}

// Namespace namespace_5f2c95ae
// Params 7, eflags: 0x1 linked
// namespace_5f2c95ae<file_0>::function_4ded18a8
// Checksum 0x7ea0a920, Offset: 0xfa8
// Size: 0x5c
function function_4ded18a8(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    function_4dcbb3a6(localclientnum, 2, newval);
}

// Namespace namespace_5f2c95ae
// Params 7, eflags: 0x1 linked
// namespace_5f2c95ae<file_0>::function_ddd543db
// Checksum 0x56e08271, Offset: 0x1010
// Size: 0x5c
function function_ddd543db(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    function_4dcbb3a6(localclientnum, 3, newval);
}

// Namespace namespace_5f2c95ae
// Params 7, eflags: 0x1 linked
// namespace_5f2c95ae<file_0>::function_7c9daad6
// Checksum 0xf0e869e6, Offset: 0x1078
// Size: 0x5c
function function_7c9daad6(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    function_4dcbb3a6(localclientnum, 4, newval);
}

// Namespace namespace_5f2c95ae
// Params 3, eflags: 0x1 linked
// namespace_5f2c95ae<file_0>::function_4dcbb3a6
// Checksum 0x481f07cf, Offset: 0x10e0
// Size: 0x49c
function function_4dcbb3a6(localclientnum, var_f2e38849, var_a1e9c985) {
    if (!isdefined(var_a1e9c985)) {
        var_a1e9c985 = 1;
    }
    var_f4fc4e39[0] = "";
    var_f4fc4e39[1] = level._effect["ritual_progress_skull"];
    var_f4fc4e39[2] = level._effect["ritual_progress_skull_75"];
    var_f4fc4e39[3] = level._effect["ritual_progress_skull_50"];
    var_f4fc4e39[4] = level._effect["ritual_progress_skull_25"];
    var_d9cf2ecd = struct::get_array("s_skulltar_skull_pos", "targetname");
    foreach (var_89669ffb in var_d9cf2ecd) {
        if (var_89669ffb.var_7cc697d0 == var_f2e38849) {
            var_b9533b1f = var_89669ffb;
            break;
        }
    }
    var_14c8adef = struct::get_array("s_skulltar_base_pos", "targetname");
    foreach (var_9915798f in var_14c8adef) {
        if (var_9915798f.var_7cc697d0 == var_f2e38849) {
            var_4b429234 = var_9915798f;
        }
    }
    var_4a347901 = "skulltar_" + var_f2e38849 + "_spawnpts";
    if (isdefined(var_a1e9c985) && var_a1e9c985 >= 0 && var_a1e9c985 < 5) {
        var_b9533b1f function_267f859f(localclientnum, var_f4fc4e39[var_a1e9c985], var_a1e9c985);
        var_4b429234 function_267f859f(localclientnum, level._effect["ritual_progress_skulltar"], var_a1e9c985);
        if (var_a1e9c985 > 0) {
            if (var_a1e9c985 === 1) {
                level thread function_f58977cd(localclientnum, var_4a347901, 1);
            }
            if (!(isdefined(var_b9533b1f.var_d52fc488) && var_b9533b1f.var_d52fc488)) {
                var_b9533b1f.var_d52fc488 = 1;
            }
        } else if (isdefined(var_b9533b1f.var_d52fc488) && var_b9533b1f.var_d52fc488) {
            var_b9533b1f.var_d52fc488 = 0;
        }
    } else {
        level thread function_f58977cd(localclientnum, var_4a347901, 0);
        if (var_a1e9c985 === 5) {
            var_b9533b1f function_267f859f(localclientnum, level._effect["ritual_success_skull"], 1);
            var_4b429234 function_267f859f(localclientnum, level._effect["ritual_progress_skulltar"], 0);
        } else if (var_a1e9c985 === 6) {
            var_b9533b1f function_267f859f(localclientnum, level._effect["ritual_progress_skull_fail"], 1);
            var_4b429234 function_267f859f(localclientnum, level._effect["ritual_progress_skulltar"], 0);
        }
    }
    wait(0.2);
}

// Namespace namespace_5f2c95ae
// Params 7, eflags: 0x1 linked
// namespace_5f2c95ae<file_0>::function_4f126a12
// Checksum 0xa81ab803, Offset: 0x1588
// Size: 0xbe
function function_4f126a12(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval == 1) {
        self.var_2c75d806 = playfxontag(localclientnum, level._effect["skullquest_finish_start"], self, "tag_origin");
        return;
    }
    if (isdefined(self.var_2c75d806)) {
        stopfx(localclientnum, self.var_2c75d806);
    }
    self.var_2c75d806 = undefined;
}

// Namespace namespace_5f2c95ae
// Params 7, eflags: 0x1 linked
// namespace_5f2c95ae<file_0>::function_14555bf6
// Checksum 0x4f20ffda, Offset: 0x1650
// Size: 0xbe
function function_14555bf6(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval == 1) {
        self.var_8d24a0fa = playfxontag(localclientnum, level._effect["skullquest_finish_trail"], self, "tag_origin");
        return;
    }
    if (isdefined(self.var_8d24a0fa)) {
        stopfx(localclientnum, self.var_8d24a0fa);
    }
    self.var_8d24a0fa = undefined;
}

// Namespace namespace_5f2c95ae
// Params 7, eflags: 0x1 linked
// namespace_5f2c95ae<file_0>::function_a35770b3
// Checksum 0x3870ce87, Offset: 0x1718
// Size: 0xbe
function function_a35770b3(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval == 1) {
        self.var_f88006a5 = playfxontag(localclientnum, level._effect["skullquest_finish_end"], self, "tag_origin");
        return;
    }
    if (isdefined(self.var_f88006a5)) {
        stopfx(localclientnum, self.var_f88006a5);
    }
    self.var_f88006a5 = undefined;
}

// Namespace namespace_5f2c95ae
// Params 7, eflags: 0x1 linked
// namespace_5f2c95ae<file_0>::function_936bf24a
// Checksum 0xd0b5e4d4, Offset: 0x17e0
// Size: 0xbe
function function_936bf24a(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval == 1) {
        self.var_f88006a5 = playfxontag(localclientnum, level._effect["skullquest_skull_done_glow"], self, "tag_origin");
        return;
    }
    if (isdefined(self.var_f88006a5)) {
        stopfx(localclientnum, self.var_f88006a5);
    }
    self.var_f88006a5 = undefined;
}

// Namespace namespace_5f2c95ae
// Params 7, eflags: 0x1 linked
// namespace_5f2c95ae<file_0>::function_4b50c64
// Checksum 0x4b7dc518, Offset: 0x18a8
// Size: 0x29c
function function_4b50c64(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self util::waittill_dobj(localclientnum);
    if (isdefined(self)) {
        if (newval === 1) {
            self.var_341f7209 = playfxontag(localclientnum, level._effect["keeper_glow"], self, "j_spineupper");
            self.var_c5e3cf4b = playfxontag(localclientnum, level._effect["keeper_mouth"], self, "j_head");
            self.var_2d3cc156 = playfxontag(localclientnum, level._effect["keeper_trail"], self, "j_robe_front_03");
            if (!isdefined(self.sndlooper)) {
                self.sndlooper = self playloopsound("zmb_keeper_looper");
            }
            return;
        }
        if (isdefined(self.var_341f7209)) {
            stopfx(localclientnum, self.var_341f7209);
        }
        self.var_341f7209 = undefined;
        if (isdefined(self.var_c5e3cf4b)) {
            stopfx(localclientnum, self.var_c5e3cf4b);
        }
        self.var_c5e3cf4b = undefined;
        if (isdefined(self.var_2d3cc156)) {
            stopfx(localclientnum, self.var_2d3cc156);
        }
        self.var_2d3cc156 = undefined;
        v_origin = self gettagorigin("j_spineupper");
        v_angles = self gettagangles("j_spineupper");
        if (isdefined(v_origin) && isdefined(v_angles)) {
            playfx(localclientnum, level._effect["keeper_death"], v_origin, v_angles);
        }
        self stopallloopsounds(1);
    }
}

// Namespace namespace_5f2c95ae
// Params 7, eflags: 0x1 linked
// namespace_5f2c95ae<file_0>::function_4bcd15cf
// Checksum 0xa5f91755, Offset: 0x1b50
// Size: 0x214
function function_4bcd15cf(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self util::waittill_dobj(localclientnum);
    if (isdefined(self)) {
        if (newval === 1) {
            if (self.archetype === "zombie") {
                self.var_341f7209 = playfxontag(localclientnum, level._effect["ritual_attacker"], self, "j_spine4");
            } else {
                self.var_341f7209 = playfxontag(localclientnum, level._effect["ritual_attacker"], self, "tag_origin");
            }
            if (!isdefined(self.sndlooper)) {
                self.sndlooper = self playloopsound("zmb_keeper_looper");
            }
            return;
        }
        if (isdefined(self.var_341f7209)) {
            stopfx(localclientnum, self.var_341f7209);
            self.var_341f7209 = undefined;
        }
        v_origin = self gettagorigin("tag_origin");
        v_angles = self gettagangles("tag_origin");
        if (isdefined(v_origin) && isdefined(v_angles)) {
            playfx(localclientnum, level._effect["keeper_death"], v_origin, v_angles);
        }
        self stopallloopsounds(1);
    }
}

// Namespace namespace_5f2c95ae
// Params 5, eflags: 0x1 linked
// namespace_5f2c95ae<file_0>::function_267f859f
// Checksum 0x858ea291, Offset: 0x1d70
// Size: 0x1a8
function function_267f859f(localclientnum, fx_id, b_on, var_afcc5d76, str_tag) {
    if (!isdefined(fx_id)) {
        fx_id = undefined;
    }
    if (!isdefined(b_on)) {
        b_on = 1;
    }
    if (!isdefined(var_afcc5d76)) {
        var_afcc5d76 = 0;
    }
    if (!isdefined(str_tag)) {
        str_tag = "tag_origin";
    }
    if (!isdefined(self.var_270913b5)) {
        self.var_270913b5 = [];
    }
    if (b_on) {
        if (!isdefined(self)) {
            return;
        }
        if (isdefined(self.var_270913b5[localclientnum])) {
            stopfx(localclientnum, self.var_270913b5[localclientnum]);
        }
        if (var_afcc5d76) {
            self.var_270913b5[localclientnum] = playfxontag(localclientnum, fx_id, self, str_tag);
        } else {
            self.var_270913b5[localclientnum] = playfx(localclientnum, fx_id, self.origin, anglestoforward(self.angles));
        }
        return;
    }
    if (isdefined(self.var_270913b5[localclientnum])) {
        stopfx(localclientnum, self.var_270913b5[localclientnum]);
        self.var_270913b5[localclientnum] = undefined;
    }
}

