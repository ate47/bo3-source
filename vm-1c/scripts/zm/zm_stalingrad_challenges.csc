#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/audio_shared;
#using scripts/codescripts/struct;

#namespace namespace_e0675efb;

// Namespace namespace_e0675efb
// Params 0, eflags: 0x2
// namespace_e0675efb<file_0>::function_2dc19561
// Checksum 0x3b5ad3f9, Offset: 0x3b0
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("zm_stalingrad_challenges", &__init__, undefined, undefined);
}

// Namespace namespace_e0675efb
// Params 0, eflags: 0x1 linked
// namespace_e0675efb<file_0>::function_8c87d8eb
// Checksum 0x8a3d9fc6, Offset: 0x3f0
// Size: 0x3e4
function __init__() {
    var_a42274ee = struct::get_array("challenge_fire_struct", "targetname");
    foreach (var_d2c81bd9 in var_a42274ee) {
        var_d2c81bd9.var_90369c89 = [];
    }
    level function_5d17d17c();
    level._effect["grave_fire"] = "dlc3/stalingrad/fx_grave_stone_glow";
    level._effect["grave_arm_fx"] = "dlc3/stalingrad/fx_dirt_hand_burst_challenges";
    level._effect["pr_c_fx"] = "fire/fx_fire_candle_flame_tall";
    clientfield::register("toplayer", "challenge_grave_fire", 12000, 2, "int", &function_6f749a23, 0, 1);
    clientfield::register("scriptmover", "challenge_arm_reveal", 12000, 1, "counter", &function_87a462eb, 0, 0);
    clientfield::register("toplayer", "pr_b", 12000, 3, "int", &function_93efc4ef, 0, 1);
    clientfield::register("toplayer", "pr_c", 12000, 3, "int", &function_553225f, 0, 1);
    clientfield::register("toplayer", "pr_l_c", 12000, 1, "int", &function_20880e24, 0, 0);
    clientfield::register("missile", "pr_gm_e_fx", 12000, 1, "int", &function_e28f1c4a, 0, 0);
    clientfield::register("scriptmover", "pr_g_c_fx", 12000, 1, "int", &function_d4db02b2, 0, 0);
    clientfield::register("toplayer", "challenge1state", 14000, 2, "int", &function_4ff59189, 0, 0);
    clientfield::register("toplayer", "challenge2state", 14000, 2, "int", &function_4ff59189, 0, 0);
    clientfield::register("toplayer", "challenge3state", 14000, 2, "int", &function_4ff59189, 0, 0);
}

// Namespace namespace_e0675efb
// Params 0, eflags: 0x1 linked
// namespace_e0675efb<file_0>::function_5d17d17c
// Checksum 0xe83b2096, Offset: 0x7e0
// Size: 0x166
function function_5d17d17c() {
    var_77797571 = struct::get_array("pr_b_spawn", "targetname");
    foreach (var_4af818ae in var_77797571) {
        var_4af818ae.var_46f4840b = [];
    }
    var_977659a7 = struct::get_array("pr_c_spawn", "targetname");
    foreach (var_238c2594 in var_977659a7) {
        var_238c2594.var_453e8445 = [];
        var_238c2594.var_90369c89 = [];
    }
}

// Namespace namespace_e0675efb
// Params 7, eflags: 0x1 linked
// namespace_e0675efb<file_0>::function_6f749a23
// Checksum 0x8774c0a6, Offset: 0x950
// Size: 0x1f6
function function_6f749a23(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    var_a42274ee = struct::get_array("challenge_fire_struct", "targetname");
    foreach (var_d2c81bd9 in var_a42274ee) {
        if (var_d2c81bd9.script_int == self getentitynumber()) {
            if (!isdefined(var_d2c81bd9.var_90369c89[localclientnum])) {
                var_d2c81bd9.var_90369c89[localclientnum] = playfx(localclientnum, level._effect["grave_fire"], var_d2c81bd9.origin + (0, 0, -8));
                audio::playloopat("zmb_challenge_fire_lp", var_d2c81bd9.origin);
            }
            continue;
        }
        if (isdefined(var_d2c81bd9.var_90369c89[localclientnum])) {
            deletefx(localclientnum, var_d2c81bd9.var_90369c89[localclientnum]);
            var_d2c81bd9.var_90369c89[localclientnum] = undefined;
        }
    }
}

// Namespace namespace_e0675efb
// Params 7, eflags: 0x1 linked
// namespace_e0675efb<file_0>::function_87a462eb
// Checksum 0x2af06309, Offset: 0xb50
// Size: 0xa4
function function_87a462eb(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        playrumbleonposition(localclientnum, "zm_stalingrad_challenge_arm_rumble", self.origin);
        playfx(localclientnum, level._effect["grave_arm_fx"], self.origin, (0, 0, 1));
    }
}

// Namespace namespace_e0675efb
// Params 7, eflags: 0x1 linked
// namespace_e0675efb<file_0>::function_93efc4ef
// Checksum 0x8eb9f25b, Offset: 0xc00
// Size: 0x25a
function function_93efc4ef(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    var_77797571 = struct::get_array("pr_b_spawn", "targetname");
    if (newval == 4) {
        foreach (var_4af818ae in var_77797571) {
            if (isdefined(var_4af818ae.var_46f4840b[localclientnum])) {
                var_4af818ae.var_46f4840b[localclientnum] delete();
            }
        }
        return;
    }
    foreach (var_4af818ae in var_77797571) {
        if (var_4af818ae.script_int == self getentitynumber()) {
            if (!isdefined(var_4af818ae.var_46f4840b[localclientnum])) {
                var_4af818ae.var_46f4840b[localclientnum] = util::spawn_model(localclientnum, "p7_foliage_flower_bouquet_glass", var_4af818ae.origin, var_4af818ae.angles);
            }
            continue;
        }
        if (isdefined(var_4af818ae.var_46f4840b[localclientnum])) {
            var_4af818ae.var_46f4840b[localclientnum] delete();
        }
    }
}

// Namespace namespace_e0675efb
// Params 7, eflags: 0x1 linked
// namespace_e0675efb<file_0>::function_553225f
// Checksum 0x3f4a4969, Offset: 0xe68
// Size: 0x37a
function function_553225f(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    var_977659a7 = struct::get_array("pr_c_spawn", "targetname");
    if (newval == 4) {
        foreach (var_238c2594 in var_977659a7) {
            if (isdefined(var_238c2594.var_453e8445[localclientnum])) {
                var_238c2594.var_453e8445[localclientnum] delete();
            }
            if (isdefined(var_238c2594.var_90369c89[localclientnum])) {
                deletefx(localclientnum, var_238c2594.var_90369c89[localclientnum]);
            }
        }
        return;
    }
    foreach (var_238c2594 in var_977659a7) {
        if (var_238c2594.script_int == self getentitynumber()) {
            if (!isdefined(var_238c2594.var_453e8445[localclientnum])) {
                if (isdefined(self.var_d3aeebe1) && self.var_d3aeebe1) {
                    str_model = "p7_candle_tall_on";
                    var_238c2594.var_90369c89[localclientnum] = playfx(localclientnum, level._effect["pr_c_fx"], var_238c2594.origin + (-1.25, 0, 5));
                } else {
                    str_model = "p7_candle_tall";
                }
                var_238c2594.var_453e8445[localclientnum] = util::spawn_model(localclientnum, str_model, var_238c2594.origin, var_238c2594.angles);
            }
            continue;
        }
        if (isdefined(var_238c2594.var_453e8445[localclientnum])) {
            var_238c2594.var_453e8445[localclientnum] delete();
        }
        if (isdefined(var_238c2594.var_90369c89[localclientnum])) {
            deletefx(localclientnum, var_238c2594.var_90369c89[localclientnum]);
        }
    }
}

// Namespace namespace_e0675efb
// Params 7, eflags: 0x1 linked
// namespace_e0675efb<file_0>::function_20880e24
// Checksum 0x568e291a, Offset: 0x11f0
// Size: 0x1fc
function function_20880e24(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        var_977659a7 = struct::get_array("pr_c_spawn", "targetname");
        foreach (var_238c2594 in var_977659a7) {
            if (var_238c2594.script_int == self getentitynumber()) {
                if (isdefined(var_238c2594.var_453e8445[localclientnum]) && !(isdefined(self.var_d3aeebe1) && self.var_d3aeebe1)) {
                    self.var_d3aeebe1 = 1;
                    var_238c2594.var_453e8445[localclientnum] setmodel("p7_candle_tall_on");
                    var_238c2594.var_453e8445[localclientnum] playloopsound("zmb_candle_pickup_lp");
                    var_238c2594.var_90369c89[localclientnum] = playfx(localclientnum, level._effect["pr_c_fx"], var_238c2594.origin + (-1.25, 0, 5));
                }
            }
        }
    }
}

// Namespace namespace_e0675efb
// Params 7, eflags: 0x1 linked
// namespace_e0675efb<file_0>::function_e28f1c4a
// Checksum 0xc5947c59, Offset: 0x13f8
// Size: 0xbc
function function_e28f1c4a(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        playfx(localclientnum, level._effect["generic_explosion"], self.origin);
        playrumbleonposition(localclientnum, "zm_stalingrad_ee_safe_smash", self.origin);
        self playsound(0, "wpn_grenade_explode");
    }
}

// Namespace namespace_e0675efb
// Params 7, eflags: 0x1 linked
// namespace_e0675efb<file_0>::function_d4db02b2
// Checksum 0x7d99140a, Offset: 0x14c0
// Size: 0xac
function function_d4db02b2(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        self.n_fx_id = playfx(localclientnum, level._effect["pr_c_fx"], self.origin + (-1.25, 0, 5));
        return;
    }
    stopfx(localclientnum, self.n_fx_id);
}

// Namespace namespace_e0675efb
// Params 7, eflags: 0x1 linked
// namespace_e0675efb<file_0>::function_4ff59189
// Checksum 0x5c5b9777, Offset: 0x1578
// Size: 0xbc
function function_4ff59189(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (isspectating(localclientnum)) {
        return;
    }
    var_42bfa7b6 = getuimodel(getuimodelforcontroller(localclientnum), "trialWidget." + fieldname);
    if (isdefined(var_42bfa7b6)) {
        setuimodelvalue(var_42bfa7b6, newval);
    }
}

