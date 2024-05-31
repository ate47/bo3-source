#using scripts/shared/ai/systems/gib;
#using scripts/shared/ai_shared;
#using scripts/shared/array_shared;
#using scripts/shared/util_shared;
#using scripts/shared/clientfield_shared;

#namespace namespace_53429ee4;

// Namespace namespace_53429ee4
// Params 0, eflags: 0x2
// namespace_53429ee4<file_0>::function_d290ebfa
// Checksum 0x9fc5252d, Offset: 0x3f0
// Size: 0x262
function autoexec main() {
    ai::add_archetype_spawn_function("apothicon_fury", &function_300930b2);
    if (ai::shouldregisterclientfieldforarchetype("apothicon_fury")) {
        clientfield::register("actor", "fury_fire_damage", 15000, getminbitcountfornum(7), "counter", &function_f47eeee6, 0, 0);
        clientfield::register("actor", "furious_level", 15000, 1, "int", &function_9eae5b23, 0, 0);
        clientfield::register("actor", "bamf_land", 15000, 1, "counter", &function_adccdb14, 0, 0);
        clientfield::register("actor", "apothicon_fury_death", 15000, 2, "int", &function_858a92e8, 0, 0);
        clientfield::register("actor", "juke_active", 15000, 1, "int", &function_a8ed402b, 0, 0);
    }
    level._effect["dlc4/genesis/fx_apothicon_fury_impact"] = "dlc4/genesis/fx_apothicon_fury_impact";
    level._effect["dlc4/genesis/fx_apothicon_fury_breath"] = "dlc4/genesis/fx_apothicon_fury_breath";
    level._effect["dlc4/genesis/fx_apothicon_fury_teleport_impact"] = "dlc4/genesis/fx_apothicon_fury_teleport_impact";
    level._effect["dlc4/genesis/fx_apothicon_fury_smk_body"] = "dlc4/genesis/fx_apothicon_fury_smk_body";
    level._effect["dlc4/genesis/fx_apothicon_fury_foot_amb"] = "dlc4/genesis/fx_apothicon_fury_foot_amb";
    level._effect["dlc4/genesis/fx_apothicon_fury_death"] = "dlc4/genesis/fx_apothicon_fury_death";
}

// Namespace namespace_53429ee4
// Params 1, eflags: 0x1 linked
// namespace_53429ee4<file_0>::function_300930b2
// Checksum 0x2e26b10f, Offset: 0x660
// Size: 0x3c
function function_300930b2(localclientnum) {
    self thread function_249cfcc8(localclientnum);
    self function_862752b6(localclientnum);
}

// Namespace namespace_53429ee4
// Params 1, eflags: 0x1 linked
// namespace_53429ee4<file_0>::function_862752b6
// Checksum 0xae17e177, Offset: 0x6a8
// Size: 0x192
function function_862752b6(localclientnum) {
    self.var_fdefa795 = [];
    self.var_fdefa795[0] = playfxontag(localclientnum, level._effect["dlc4/genesis/fx_apothicon_fury_breath"], self, "j_head");
    self.var_fdefa795[1] = playfxontag(localclientnum, level._effect["dlc4/genesis/fx_apothicon_fury_smk_body"], self, "j_spine4");
    self.var_fdefa795[2] = playfxontag(localclientnum, level._effect["dlc4/genesis/fx_apothicon_fury_foot_amb"], self, "j_ball_le");
    self.var_fdefa795[3] = playfxontag(localclientnum, level._effect["dlc4/genesis/fx_apothicon_fury_foot_amb"], self, "j_ball_ri");
    self.var_fdefa795[4] = playfxontag(localclientnum, level._effect["dlc4/genesis/fx_apothicon_fury_foot_amb"], self, "j_wrist_le");
    self.var_fdefa795[5] = playfxontag(localclientnum, level._effect["dlc4/genesis/fx_apothicon_fury_foot_amb"], self, "j_wrist_ri");
}

// Namespace namespace_53429ee4
// Params 1, eflags: 0x1 linked
// namespace_53429ee4<file_0>::function_8795f93e
// Checksum 0xef114daf, Offset: 0x848
// Size: 0x9a
function function_8795f93e(localclientnum) {
    foreach (fx in self.var_fdefa795) {
        killfx(localclientnum, fx);
    }
}

// Namespace namespace_53429ee4
// Params 1, eflags: 0x1 linked
// namespace_53429ee4<file_0>::function_249cfcc8
// Checksum 0x29456767, Offset: 0x8f0
// Size: 0x118
function function_249cfcc8(localclientnum) {
    self endon(#"entityshutdown");
    self util::waittill_dobj(localclientnum);
    if (!isdefined(self)) {
        return;
    }
    s_timer = new_timer(localclientnum);
    var_dbee3979 = 1;
    do {
        util::server_wait(localclientnum, 0.11);
        n_current_time = s_timer get_time_in_seconds();
        var_af412d0a = lerpfloat(0, 0.01, n_current_time / var_dbee3979);
        self mapshaderconstant(localclientnum, 0, "scriptVector2", var_af412d0a);
    } while (n_current_time < var_dbee3979);
    s_timer notify(#"hash_88be9d37");
}

// Namespace namespace_53429ee4
// Params 7, eflags: 0x1 linked
// namespace_53429ee4<file_0>::function_a8ed402b
// Checksum 0x431d689, Offset: 0xa10
// Size: 0xec
function function_a8ed402b(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self endon(#"entityshutdown");
    self util::waittill_dobj(localclientnum);
    if (!isdefined(self)) {
        return;
    }
    if (newval) {
        playsound(0, "zmb_fury_bamf_teleport_in", self.origin);
        self function_862752b6(localclientnum);
        return;
    }
    playsound(0, "zmb_fury_bamf_teleport_out", self.origin);
    self function_8795f93e(localclientnum);
}

// Namespace namespace_53429ee4
// Params 7, eflags: 0x1 linked
// namespace_53429ee4<file_0>::function_f47eeee6
// Checksum 0xf91d4df8, Offset: 0xb08
// Size: 0x2a8
function function_f47eeee6(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self endon(#"entityshutdown");
    self util::waittill_dobj(localclientnum);
    if (!isdefined(self)) {
        return;
    }
    tag = undefined;
    if (newval == 6) {
        tag = array::random(array("J_Hip_RI", "J_Knee_RI"));
    }
    if (newval == 7) {
        tag = array::random(array("J_Hip_LE", "J_Knee_LE"));
    } else if (newval == 4) {
        tag = array::random(array("J_Shoulder_RI", "J_Shoulder_RI_tr", "J_Elbow_RI"));
    } else if (newval == 5) {
        tag = array::random(array("J_Shoulder_LE", "J_Shoulder_LE_tr", "J_Elbow_LE"));
    } else if (newval == 3) {
        tag = array::random(array("J_MainRoot"));
    } else if (newval == 2) {
        tag = array::random(array("J_SpineUpper", "J_Clavicle_RI", "J_Clavicle_LE"));
    } else {
        tag = array::random(array("J_Neck", "J_Head", "J_Helmet"));
    }
    fx = playfxontag(localclientnum, level._effect["dlc4/genesis/fx_apothicon_fury_impact"], self, tag);
}

// Namespace namespace_53429ee4
// Params 7, eflags: 0x1 linked
// namespace_53429ee4<file_0>::function_858a92e8
// Checksum 0x613eef8f, Offset: 0xdb8
// Size: 0x2ec
function function_858a92e8(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self endon(#"entityshutdown");
    self util::waittill_dobj(localclientnum);
    if (!isdefined(self)) {
        return;
    }
    if (newval == 1) {
        s_timer = new_timer(localclientnum);
        var_dbee3979 = 1;
        self.var_eee5840b = 1;
        do {
            util::server_wait(localclientnum, 0.11);
            n_current_time = s_timer get_time_in_seconds();
            var_af412d0a = lerpfloat(1, 0.1, n_current_time / var_dbee3979);
            self mapshaderconstant(localclientnum, 0, "scriptVector2", var_af412d0a);
        } while (n_current_time < var_dbee3979);
        s_timer notify(#"hash_88be9d37");
        self.var_eee5840b = 0;
        return;
    }
    if (newval == 2) {
        if (!isdefined(self)) {
            return;
        }
        playfxontag(localclientnum, level._effect["dlc4/genesis/fx_apothicon_fury_death"], self, "j_spine4");
        self function_8795f93e(localclientnum);
        var_dbee3979 = 0.3;
        s_timer = new_timer(localclientnum);
        stoptime = gettime() + var_dbee3979 * 1000;
        do {
            util::server_wait(localclientnum, 0.11);
            n_current_time = s_timer get_time_in_seconds();
            var_af412d0a = lerpfloat(1, 0, n_current_time / var_dbee3979);
            self mapshaderconstant(localclientnum, 0, "scriptVector0", var_af412d0a);
        } while (n_current_time < var_dbee3979 && gettime() <= stoptime);
        s_timer notify(#"hash_88be9d37");
        self mapshaderconstant(localclientnum, 0, "scriptVector0", 0);
    }
}

// Namespace namespace_53429ee4
// Params 7, eflags: 0x1 linked
// namespace_53429ee4<file_0>::function_9eae5b23
// Checksum 0xf6935c58, Offset: 0x10b0
// Size: 0x150
function function_9eae5b23(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self endon(#"entityshutdown");
    self util::waittill_dobj(localclientnum);
    if (!isdefined(self)) {
        return;
    }
    if (newval) {
        s_timer = new_timer(localclientnum);
        var_dbee3979 = 2;
        do {
            util::server_wait(localclientnum, 0.11);
            n_current_time = s_timer get_time_in_seconds();
            var_af412d0a = lerpfloat(0.1, 1, n_current_time / var_dbee3979);
            self mapshaderconstant(localclientnum, 0, "scriptVector2", var_af412d0a);
        } while (n_current_time < var_dbee3979);
        s_timer notify(#"hash_88be9d37");
    }
}

// Namespace namespace_53429ee4
// Params 1, eflags: 0x1 linked
// namespace_53429ee4<file_0>::function_8c4f4e93
// Checksum 0x8b1caebd, Offset: 0x1208
// Size: 0x58
function new_timer(localclientnum) {
    s_timer = spawnstruct();
    s_timer.n_time_current = 0;
    s_timer thread function_ec23b7a7(localclientnum, self);
    return s_timer;
}

// Namespace namespace_53429ee4
// Params 2, eflags: 0x1 linked
// namespace_53429ee4<file_0>::function_ec23b7a7
// Checksum 0x36624892, Offset: 0x1268
// Size: 0x68
function function_ec23b7a7(localclientnum, entity) {
    entity endon(#"entityshutdown");
    self endon(#"hash_88be9d37");
    while (isdefined(self)) {
        util::server_wait(localclientnum, 0.016);
        self.n_time_current += 0.016;
    }
}

// Namespace namespace_53429ee4
// Params 0, eflags: 0x0
// namespace_53429ee4<file_0>::function_c1a32fb9
// Checksum 0xd4b6b984, Offset: 0x12d8
// Size: 0x10
function get_time() {
    return self.n_time_current * 1000;
}

// Namespace namespace_53429ee4
// Params 0, eflags: 0x1 linked
// namespace_53429ee4<file_0>::function_d655bd13
// Checksum 0x628f4955, Offset: 0x12f0
// Size: 0xa
function get_time_in_seconds() {
    return self.n_time_current;
}

// Namespace namespace_53429ee4
// Params 0, eflags: 0x0
// namespace_53429ee4<file_0>::function_799c46b8
// Checksum 0x3194b06, Offset: 0x1308
// Size: 0x10
function function_799c46b8() {
    self.n_time_current = 0;
}

// Namespace namespace_53429ee4
// Params 7, eflags: 0x1 linked
// namespace_53429ee4<file_0>::function_adccdb14
// Checksum 0xef3b58be, Offset: 0x1320
// Size: 0x11c
function function_adccdb14(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self endon(#"entityshutdown");
    self util::waittill_dobj(localclientnum);
    if (!isdefined(self)) {
        return;
    }
    if (newval) {
        playfxontag(localclientnum, level._effect["dlc4/genesis/fx_apothicon_fury_teleport_impact"], self, "tag_origin");
    }
    player = getlocalplayer(localclientnum);
    player earthquake(0.5, 1.4, self.origin, 375);
    playrumbleonposition(localclientnum, "apothicon_fury_land", self.origin);
}

