#using scripts/zm/_zm_bgb;
#using scripts/zm/_load;
#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/math_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/array_shared;
#using scripts/codescripts/struct;

#namespace namespace_c92f7448;

// Namespace namespace_c92f7448
// Params 0, eflags: 0x2
// namespace_c92f7448<file_0>::function_2dc19561
// Checksum 0xe3ea3e58, Offset: 0x980
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("bgb_machine", &__init__, undefined, undefined);
}

// Namespace namespace_c92f7448
// Params 0, eflags: 0x1 linked
// namespace_c92f7448<file_0>::function_8c87d8eb
// Checksum 0x587388d8, Offset: 0x9c0
// Size: 0x4bc
function __init__() {
    if (!(isdefined(level.bgb_in_use) && level.bgb_in_use)) {
        return;
    }
    level.var_962d1590 = 0.016;
    clientfield::register("zbarrier", "zm_bgb_machine", 1, 1, "int", &function_62051f89, 0, 0);
    clientfield::register("zbarrier", "zm_bgb_machine_selection", 1, 8, "int", &function_3bb1978f, 1, 0);
    clientfield::register("zbarrier", "zm_bgb_machine_fx_state", 1, 3, "int", &function_f312291b, 0, 0);
    clientfield::register("zbarrier", "zm_bgb_machine_ghost_ball", 1, 1, "int", undefined, 0, 0);
    clientfield::register("toplayer", "zm_bgb_machine_round_buys", 10000, 3, "int", &function_27a93844, 0, 0);
    level._effect["zm_bgb_machine_eye_away"] = "zombie/fx_bgb_machine_eye_away_zmb";
    level._effect["zm_bgb_machine_eye_activated"] = "zombie/fx_bgb_machine_eye_activated_zmb";
    level._effect["zm_bgb_machine_eye_event"] = "zombie/fx_bgb_machine_eye_event_zmb";
    level._effect["zm_bgb_machine_eye_rounds"] = "zombie/fx_bgb_machine_eye_rounds_zmb";
    level._effect["zm_bgb_machine_eye_time"] = "zombie/fx_bgb_machine_eye_time_zmb";
    if (!isdefined(level._effect["zm_bgb_machine_available"])) {
        level._effect["zm_bgb_machine_available"] = "zombie/fx_bgb_machine_available_zmb";
    }
    if (!isdefined(level._effect["zm_bgb_machine_bulb_away"])) {
        level._effect["zm_bgb_machine_bulb_away"] = "zombie/fx_bgb_machine_bulb_away_zmb";
    }
    if (!isdefined(level._effect["zm_bgb_machine_bulb_available"])) {
        level._effect["zm_bgb_machine_bulb_available"] = "zombie/fx_bgb_machine_bulb_available_zmb";
    }
    if (!isdefined(level._effect["zm_bgb_machine_bulb_activated"])) {
        level._effect["zm_bgb_machine_bulb_activated"] = "zombie/fx_bgb_machine_bulb_activated_zmb";
    }
    if (!isdefined(level._effect["zm_bgb_machine_bulb_event"])) {
        level._effect["zm_bgb_machine_bulb_event"] = "zombie/fx_bgb_machine_bulb_event_zmb";
    }
    if (!isdefined(level._effect["zm_bgb_machine_bulb_rounds"])) {
        level._effect["zm_bgb_machine_bulb_rounds"] = "zombie/fx_bgb_machine_bulb_rounds_zmb";
    }
    if (!isdefined(level._effect["zm_bgb_machine_bulb_time"])) {
        level._effect["zm_bgb_machine_bulb_time"] = "zombie/fx_bgb_machine_bulb_time_zmb";
    }
    level._effect["zm_bgb_machine_bulb_spark"] = "zombie/fx_bgb_machine_bulb_spark_zmb";
    level._effect["zm_bgb_machine_flying_elec"] = "zombie/fx_bgb_machine_flying_elec_zmb";
    level._effect["zm_bgb_machine_flying_embers_down"] = "zombie/fx_bgb_machine_flying_embers_down_zmb";
    level._effect["zm_bgb_machine_flying_embers_up"] = "zombie/fx_bgb_machine_flying_embers_up_zmb";
    level._effect["zm_bgb_machine_smoke"] = "zombie/fx_bgb_machine_smoke_zmb";
    level._effect["zm_bgb_machine_gumball_halo"] = "zombie/fx_bgb_machine_gumball_halo_zmb";
    level._effect["zm_bgb_machine_gumball_ghost"] = "zombie/fx_bgb_gumball_ghost_zmb";
    if (!isdefined(level._effect["zm_bgb_machine_light_interior"])) {
        level._effect["zm_bgb_machine_light_interior"] = "zombie/fx_bgb_machine_light_interior_zmb";
    }
    if (!isdefined(level._effect["zm_bgb_machine_light_interior_away"])) {
        level._effect["zm_bgb_machine_light_interior_away"] = "zombie/fx_bgb_machine_light_interior_away_zmb";
    }
    function_b90b22b6();
}

// Namespace namespace_c92f7448
// Params 7, eflags: 0x5 linked
// namespace_c92f7448<file_0>::function_62051f89
// Checksum 0xf86e5c92, Offset: 0xe88
// Size: 0x3cc
function private function_62051f89(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (isdefined(self.var_16139ac9)) {
        return;
    }
    if (!isdefined(level.var_5081bd63)) {
        level.var_5081bd63 = [];
    }
    array::add(level.var_5081bd63, self);
    var_962d1590 = level.var_962d1590;
    level.var_962d1590 += 0.016;
    wait(var_962d1590);
    if (!isdefined(self)) {
        return;
    }
    if (!isdefined(level.var_10a6bc02)) {
        piececount = self getnumzbarrierpieces();
        for (i = 0; i < piececount; i++) {
            piece = self zbarriergetpiece(i);
            forcestreamxmodel(piece.model);
        }
        level.var_10a6bc02 = 1;
    }
    self.var_16139ac9 = [];
    self.var_16139ac9["tag_origin"] = [];
    self.var_16139ac9["tag_fx_light_lion_lft_eye_jnt"] = [];
    self.var_16139ac9["tag_fx_light_lion_rt_eye_jnt"] = [];
    self.var_16139ac9["tag_fx_light_top_jnt"] = [];
    self.var_16139ac9["tag_fx_light_side_lft_top_jnt"] = [];
    self.var_16139ac9["tag_fx_light_side_lft_mid_jnt"] = [];
    self.var_16139ac9["tag_fx_light_side_lft_btm_jnt"] = [];
    self.var_16139ac9["tag_fx_light_side_rt_top_jnt"] = [];
    self.var_16139ac9["tag_fx_light_side_rt_mid_jnt"] = [];
    self.var_16139ac9["tag_fx_light_side_rt_btm_jnt"] = [];
    self.var_16139ac9["tag_fx_glass_cntr_jnt"] = [];
    self.var_16139ac9["tag_gumball_ghost"] = [];
    self.var_6860c69f = [];
    self.var_6860c69f[self.var_6860c69f.size] = "tag_fx_light_top_jnt";
    self.var_6860c69f[self.var_6860c69f.size] = "tag_fx_light_side_lft_top_jnt";
    self.var_6860c69f[self.var_6860c69f.size] = "tag_fx_light_side_lft_mid_jnt";
    self.var_6860c69f[self.var_6860c69f.size] = "tag_fx_light_side_lft_btm_jnt";
    self.var_6860c69f[self.var_6860c69f.size] = "tag_fx_light_side_rt_top_jnt";
    self.var_6860c69f[self.var_6860c69f.size] = "tag_fx_light_side_rt_mid_jnt";
    self.var_6860c69f[self.var_6860c69f.size] = "tag_fx_light_side_rt_btm_jnt";
    self thread function_7cf480af(localclientnum, "closing", level._effect["zm_bgb_machine_flying_embers_down"]);
    self thread function_7cf480af(localclientnum, "opening", level._effect["zm_bgb_machine_flying_embers_up"]);
    self thread function_25c29799(localclientnum);
    self thread function_f27e16f6(localclientnum);
    self thread function_3939ad2f(localclientnum);
}

// Namespace namespace_c92f7448
// Params 7, eflags: 0x5 linked
// namespace_c92f7448<file_0>::function_3bb1978f
// Checksum 0x221f43a3, Offset: 0x1260
// Size: 0x62
function private function_3bb1978f(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (!newval) {
        return;
    }
    bgb = level.bgb_item_index_to_name[newval];
}

// Namespace namespace_c92f7448
// Params 3, eflags: 0x5 linked
// namespace_c92f7448<file_0>::function_8711c7b2
// Checksum 0x5162026d, Offset: 0x12d0
// Size: 0x100
function private function_8711c7b2(localclientnum, fx, piece) {
    piece endon(#"opened");
    piece endon(#"closed");
    self.var_6860c69f = array::randomize(self.var_6860c69f);
    for (i = 0; i < self.var_6860c69f.size; i++) {
        if (randomintrange(0, 4)) {
            playfxontag(localclientnum, fx, piece, self.var_6860c69f[i]);
        }
        wait_time = randomfloatrange(0, 0.2);
        if (wait_time) {
            wait(wait_time);
        }
    }
}

// Namespace namespace_c92f7448
// Params 3, eflags: 0x5 linked
// namespace_c92f7448<file_0>::function_7cf480af
// Checksum 0x568d4594, Offset: 0x13d8
// Size: 0x170
function private function_7cf480af(localclientnum, notifyname, fx) {
    var_3af6034f = self zbarriergetpiece(3);
    var_6b3a8684 = self zbarriergetpiece(5);
    for (;;) {
        var_3af6034f waittill(notifyname);
        tag_angles = var_6b3a8684 gettagangles("tag_fx_glass_cntr_jnt");
        playfx(localclientnum, fx, var_6b3a8684 gettagorigin("tag_fx_glass_cntr_jnt"), anglestoforward(tag_angles), anglestoup(tag_angles));
        playfx(localclientnum, level._effect["zm_bgb_machine_smoke"], self.origin);
        self thread function_8711c7b2(localclientnum, level._effect["zm_bgb_machine_bulb_spark"], var_6b3a8684);
        wait(0.01);
    }
}

// Namespace namespace_c92f7448
// Params 1, eflags: 0x5 linked
// namespace_c92f7448<file_0>::function_25c29799
// Checksum 0x4a3f6cb9, Offset: 0x1550
// Size: 0x314
function private function_25c29799(localclientnum) {
    var_f3eb485b = self zbarriergetpiece(4);
    var_6b3a8684 = self zbarriergetpiece(5);
    for (;;) {
        function_5885778a(var_f3eb485b);
        if (!isdefined(self)) {
            return;
        }
        if (!isdefined(var_f3eb485b)) {
            var_f3eb485b = self zbarriergetpiece(4);
            var_6b3a8684 = self zbarriergetpiece(5);
        }
        var_286fd1ed = self clientfield::get("zm_bgb_machine_selection");
        bgb = level.bgb_item_index_to_name[var_286fd1ed];
        if (!isdefined(bgb)) {
            continue;
        }
        self thread function_5f830538(localclientnum);
        playfxontag(localclientnum, level._effect["zm_bgb_machine_flying_elec"], var_6b3a8684, "tag_fx_glass_cntr_jnt");
        var_f3eb485b hidepart(localclientnum, "tag_gumballs", "", 1);
        bgb_pack = [];
        for (i = 0; i < level.bgb_pack[localclientnum].size; i++) {
            if (bgb == level.bgb_pack[localclientnum][i]) {
                continue;
            }
            bgb_pack[bgb_pack.size] = level.bgb_pack[localclientnum][i];
        }
        for (i = 0; i < level.bgb_pack[localclientnum].size; i++) {
            bgb_pack[bgb_pack.size] = level.bgb_pack[localclientnum][i];
        }
        bgb_pack = array::randomize(bgb_pack);
        array::push_front(bgb_pack, bgb);
        for (i = 0; i < 10; i++) {
            var_f3eb485b showpart(localclientnum, level.bgb[bgb_pack[i]].flying_gumball_tag + "_" + i);
        }
        wait(0.01);
    }
}

// Namespace namespace_c92f7448
// Params 1, eflags: 0x1 linked
// namespace_c92f7448<file_0>::function_5885778a
// Checksum 0x5c4af776, Offset: 0x1870
// Size: 0x3c
function function_5885778a(piece) {
    level endon(#"demo_jump");
    piece util::waittill_any("opening", "closing");
}

// Namespace namespace_c92f7448
// Params 1, eflags: 0x5 linked
// namespace_c92f7448<file_0>::function_f27e16f6
// Checksum 0x9eb4133d, Offset: 0x18b8
// Size: 0x180
function private function_f27e16f6(localclientnum) {
    piece = self zbarriergetpiece(2);
    while (isdefined(self)) {
        function_36a807de(piece);
        if (!isdefined(self)) {
            return;
        }
        if (!isdefined(piece)) {
            piece = self zbarriergetpiece(2);
        }
        var_286fd1ed = self clientfield::get("zm_bgb_machine_selection");
        bgb = level.bgb_item_index_to_name[var_286fd1ed];
        if (!isdefined(bgb)) {
            continue;
        }
        piece hidepart(localclientnum, "tag_gumballs", "", 1);
        if (self clientfield::get("zm_bgb_machine_ghost_ball")) {
            piece showpart(localclientnum, "tag_gumball_ghost");
        } else {
            piece showpart(localclientnum, level.bgb[bgb].var_ece14434);
        }
        wait(0.01);
    }
}

// Namespace namespace_c92f7448
// Params 1, eflags: 0x1 linked
// namespace_c92f7448<file_0>::function_36a807de
// Checksum 0x9fecf8f6, Offset: 0x1a40
// Size: 0x26
function function_36a807de(piece) {
    level endon(#"demo_jump");
    piece waittill(#"opening");
}

// Namespace namespace_c92f7448
// Params 1, eflags: 0x5 linked
// namespace_c92f7448<file_0>::function_3939ad2f
// Checksum 0x329cc8e6, Offset: 0x1a70
// Size: 0x78
function private function_3939ad2f(localclientnum) {
    piece = self zbarriergetpiece(1);
    for (;;) {
        piece waittill(#"opening");
        function_42630d5e(localclientnum, piece, "tag_fx_glass_cntr_jnt", level._effect["zm_bgb_machine_light_interior"]);
        wait(0.01);
    }
}

// Namespace namespace_c92f7448
// Params 0, eflags: 0x5 linked
// namespace_c92f7448<file_0>::function_9b51ab0
// Checksum 0x830dbc28, Offset: 0x1af0
// Size: 0xe4
function private function_9b51ab0() {
    var_286fd1ed = self clientfield::get("zm_bgb_machine_selection");
    bgb = level.bgb_item_index_to_name[var_286fd1ed];
    switch (level.bgb[bgb].limit_type) {
    case 68:
        return level._effect["zm_bgb_machine_eye_activated"];
    case 69:
        return level._effect["zm_bgb_machine_eye_event"];
    case 70:
        return level._effect["zm_bgb_machine_eye_rounds"];
    case 71:
        return level._effect["zm_bgb_machine_eye_time"];
    }
    return undefined;
}

// Namespace namespace_c92f7448
// Params 0, eflags: 0x5 linked
// namespace_c92f7448<file_0>::function_43d950d2
// Checksum 0x93521bb0, Offset: 0x1be0
// Size: 0xe4
function private function_43d950d2() {
    var_286fd1ed = self clientfield::get("zm_bgb_machine_selection");
    bgb = level.bgb_item_index_to_name[var_286fd1ed];
    switch (level.bgb[bgb].limit_type) {
    case 68:
        return level._effect["zm_bgb_machine_bulb_activated"];
    case 69:
        return level._effect["zm_bgb_machine_bulb_event"];
    case 70:
        return level._effect["zm_bgb_machine_bulb_rounds"];
    case 71:
        return level._effect["zm_bgb_machine_bulb_time"];
    }
    return undefined;
}

// Namespace namespace_c92f7448
// Params 5, eflags: 0x5 linked
// namespace_c92f7448<file_0>::function_42630d5e
// Checksum 0xb1e36f70, Offset: 0x1cd0
// Size: 0xd8
function private function_42630d5e(localclientnum, piece, tag, fx, deleteimmediate) {
    if (!isdefined(deleteimmediate)) {
        deleteimmediate = 1;
    }
    if (isdefined(self.var_16139ac9[tag][localclientnum])) {
        deletefx(localclientnum, self.var_16139ac9[tag][localclientnum], deleteimmediate);
        self.var_16139ac9[tag][localclientnum] = undefined;
    }
    if (isdefined(fx)) {
        self.var_16139ac9[tag][localclientnum] = playfxontag(localclientnum, fx, piece, tag);
    }
}

// Namespace namespace_c92f7448
// Params 3, eflags: 0x5 linked
// namespace_c92f7448<file_0>::function_e5bc89d2
// Checksum 0x57f88f67, Offset: 0x1db0
// Size: 0x44
function private function_e5bc89d2(localclientnum, piece, fx) {
    function_42630d5e(localclientnum, piece, "tag_fx_light_top_jnt", fx);
}

// Namespace namespace_c92f7448
// Params 3, eflags: 0x5 linked
// namespace_c92f7448<file_0>::function_cb90ea4e
// Checksum 0xe976fe0c, Offset: 0x1e00
// Size: 0x6c
function private function_cb90ea4e(localclientnum, piece, fx) {
    function_42630d5e(localclientnum, piece, "tag_fx_light_side_lft_top_jnt", fx);
    function_42630d5e(localclientnum, piece, "tag_fx_light_side_rt_top_jnt", fx);
}

// Namespace namespace_c92f7448
// Params 3, eflags: 0x5 linked
// namespace_c92f7448<file_0>::function_47c2c4a1
// Checksum 0x46228ca6, Offset: 0x1e78
// Size: 0x6c
function private function_47c2c4a1(localclientnum, piece, fx) {
    function_42630d5e(localclientnum, piece, "tag_fx_light_side_lft_mid_jnt", fx);
    function_42630d5e(localclientnum, piece, "tag_fx_light_side_rt_mid_jnt", fx);
}

// Namespace namespace_c92f7448
// Params 3, eflags: 0x5 linked
// namespace_c92f7448<file_0>::function_3c131c80
// Checksum 0x15ac5003, Offset: 0x1ef0
// Size: 0x6c
function private function_3c131c80(localclientnum, piece, fx) {
    function_42630d5e(localclientnum, piece, "tag_fx_light_side_lft_btm_jnt", fx);
    function_42630d5e(localclientnum, piece, "tag_fx_light_side_rt_btm_jnt", fx);
}

// Namespace namespace_c92f7448
// Params 3, eflags: 0x5 linked
// namespace_c92f7448<file_0>::function_38aeb872
// Checksum 0x4404dcd8, Offset: 0x1f68
// Size: 0x9c
function private function_38aeb872(localclientnum, piece, fx) {
    function_e5bc89d2(localclientnum, piece, fx);
    function_cb90ea4e(localclientnum, piece, fx);
    function_47c2c4a1(localclientnum, piece, fx);
    function_3c131c80(localclientnum, piece, fx);
}

// Namespace namespace_c92f7448
// Params 3, eflags: 0x5 linked
// namespace_c92f7448<file_0>::function_8bca2811
// Checksum 0xb691eef7, Offset: 0x2010
// Size: 0x64
function private function_8bca2811(localclientnum, entity, alias) {
    origin = entity gettagorigin("tag_fx_light_top_jnt");
    playsound(localclientnum, alias, origin);
}

// Namespace namespace_c92f7448
// Params 1, eflags: 0x5 linked
// namespace_c92f7448<file_0>::function_d5f882d0
// Checksum 0x7740ebf, Offset: 0x2080
// Size: 0x44
function private function_d5f882d0(localclientnum) {
    self function_42630d5e(localclientnum, self zbarriergetpiece(5), "tag_origin", undefined);
}

// Namespace namespace_c92f7448
// Params 1, eflags: 0x5 linked
// namespace_c92f7448<file_0>::function_eb5b80c5
// Checksum 0x62d16d2, Offset: 0x20d0
// Size: 0xa4
function private function_eb5b80c5(localclientnum) {
    self notify(#"hash_fff2ccd6");
    self endon(#"hash_fff2ccd6");
    self function_38aeb872(localclientnum, self zbarriergetpiece(5), undefined);
    self function_42630d5e(localclientnum, self zbarriergetpiece(5), "tag_origin", level._effect["zm_bgb_machine_available"]);
}

// Namespace namespace_c92f7448
// Params 5, eflags: 0x5 linked
// namespace_c92f7448<file_0>::function_63a14f25
// Checksum 0xa9376d4b, Offset: 0x2180
// Size: 0xce
function private function_63a14f25(localclientnum, piece, fx, var_9bde339b, alias) {
    self notify(#"hash_fff2ccd6");
    self endon(#"hash_fff2ccd6");
    function_d5f882d0(localclientnum);
    for (;;) {
        function_38aeb872(localclientnum, piece, fx);
        if (isdefined(alias)) {
            function_8bca2811(localclientnum, piece, alias);
        }
        wait(var_9bde339b);
        function_38aeb872(localclientnum, piece, undefined);
        wait(var_9bde339b);
    }
}

// Namespace namespace_c92f7448
// Params 1, eflags: 0x5 linked
// namespace_c92f7448<file_0>::function_d0281a17
// Checksum 0xd4f806f1, Offset: 0x2258
// Size: 0x64
function private function_d0281a17(localclientnum) {
    self thread function_63a14f25(localclientnum, self zbarriergetpiece(5), self function_43d950d2(), 0.4, "zmb_bgb_machine_light_ready");
}

// Namespace namespace_c92f7448
// Params 1, eflags: 0x5 linked
// namespace_c92f7448<file_0>::function_5f830538
// Checksum 0x47301ea5, Offset: 0x22c8
// Size: 0x64
function private function_5f830538(localclientnum) {
    self thread function_63a14f25(localclientnum, self zbarriergetpiece(5), level._effect["zm_bgb_machine_bulb_available"], 0.2, "zmb_bgb_machine_light_click");
}

// Namespace namespace_c92f7448
// Params 1, eflags: 0x5 linked
// namespace_c92f7448<file_0>::function_9e064c6
// Checksum 0xb3a8ed9e, Offset: 0x2338
// Size: 0x64
function private function_9e064c6(localclientnum) {
    self thread function_63a14f25(localclientnum, self zbarriergetpiece(1), level._effect["zm_bgb_machine_bulb_away"], 0.4, "zmb_bgb_machine_light_leaving");
}

// Namespace namespace_c92f7448
// Params 1, eflags: 0x5 linked
// namespace_c92f7448<file_0>::function_dec3df0b
// Checksum 0x7ac62f10, Offset: 0x23a8
// Size: 0x74
function private function_dec3df0b(localclientnum) {
    self notify(#"hash_fff2ccd6");
    function_d5f882d0(localclientnum);
    function_38aeb872(localclientnum, self zbarriergetpiece(5), level._effect["zm_bgb_machine_bulb_away"]);
}

// Namespace namespace_c92f7448
// Params 7, eflags: 0x5 linked
// namespace_c92f7448<file_0>::function_f312291b
// Checksum 0x43aa040d, Offset: 0x2428
// Size: 0x38c
function private function_f312291b(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    function_62051f89(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump);
    if (!isdefined(self)) {
        return;
    }
    eye_fx = undefined;
    var_56e169c3 = undefined;
    switch (newval) {
    case 1:
        function_42630d5e(localclientnum, self zbarriergetpiece(5), "tag_fx_glass_cntr_jnt", level._effect["zm_bgb_machine_light_interior_away"]);
        self thread function_dec3df0b(localclientnum);
        break;
    case 2:
        eye_fx = level._effect["zm_bgb_machine_eye_away"];
        var_5324e4f7 = self zbarriergetpiece(1);
        self thread function_9e064c6(localclientnum);
        break;
    case 3:
        var_56e169c3 = level._effect["zm_bgb_machine_light_interior"];
        var_5c057e0d = self zbarriergetpiece(5);
        eye_fx = function_9b51ab0();
        var_5324e4f7 = self zbarriergetpiece(2);
        self thread function_d0281a17(localclientnum);
        if (self clientfield::get("zm_bgb_machine_ghost_ball")) {
            function_42630d5e(localclientnum, var_5324e4f7, "tag_gumball_ghost", level._effect["zm_bgb_machine_gumball_ghost"]);
        } else {
            function_42630d5e(localclientnum, var_5324e4f7, "tag_gumball_ghost", level._effect["zm_bgb_machine_gumball_halo"]);
        }
        break;
    case 4:
        function_42630d5e(localclientnum, self zbarriergetpiece(5), "tag_fx_glass_cntr_jnt", level._effect["zm_bgb_machine_light_interior"]);
        self thread function_eb5b80c5(localclientnum);
        var_58d675a8 = self zbarriergetpiece(2);
        function_42630d5e(localclientnum, var_58d675a8, "tag_gumball_ghost", undefined, 0);
        break;
    }
    function_42630d5e(localclientnum, var_5324e4f7, "tag_fx_light_lion_lft_eye_jnt", eye_fx);
    function_42630d5e(localclientnum, var_5324e4f7, "tag_fx_light_lion_rt_eye_jnt", eye_fx);
}

// Namespace namespace_c92f7448
// Params 0, eflags: 0x1 linked
// namespace_c92f7448<file_0>::function_b90b22b6
// Checksum 0xed282766, Offset: 0x27c0
// Size: 0x11c
function function_b90b22b6() {
    if (!isdefined(level.var_6cb6a683)) {
        level.var_6cb6a683 = 3;
    }
    if (!isdefined(level.var_f02c5598)) {
        level.var_f02c5598 = 1000;
    }
    if (!isdefined(level.var_e1dee7ba)) {
        level.var_e1dee7ba = 10;
    }
    if (!isdefined(level.var_a3e3127d)) {
        level.var_a3e3127d = 2;
    }
    if (!isdefined(level.var_8ef45dc2)) {
        level.var_8ef45dc2 = 10;
    }
    if (!isdefined(level.var_1485dcdc)) {
        level.var_1485dcdc = 2;
    }
    if (!isdefined(level.var_bb2b3f61)) {
        level.var_bb2b3f61 = [];
    }
    if (!isdefined(level.var_32948a58)) {
        level.var_32948a58 = [];
    }
    if (!isdefined(level.var_f26edb66)) {
        level.var_f26edb66 = [];
    }
    if (!isdefined(level.var_6c7a96b4)) {
        level.var_6c7a96b4 = &function_6c7a96b4;
    }
    callback::on_localplayer_spawned(&on_player_spawned);
}

// Namespace namespace_c92f7448
// Params 1, eflags: 0x5 linked
// namespace_c92f7448<file_0>::function_aebcf025
// Checksum 0x6eb53440, Offset: 0x28e8
// Size: 0xfc
function private on_player_spawned(localclientnum) {
    if (!isdefined(level.var_bb2b3f61[localclientnum])) {
        level.var_bb2b3f61[localclientnum] = 0;
    }
    if (!isdefined(level.var_32948a58[localclientnum])) {
        level.var_32948a58[localclientnum] = 0;
    }
    if (!isdefined(level.var_f26edb66[localclientnum])) {
        level.var_f26edb66[localclientnum] = 0;
    }
    function_725214c(localclientnum, level.var_bb2b3f61[localclientnum], level.var_32948a58[localclientnum], level.var_f26edb66[localclientnum]);
    self thread function_763ef0fd(localclientnum);
    self thread function_5d9d13da(localclientnum);
    self thread function_fda54943(localclientnum);
}

// Namespace namespace_c92f7448
// Params 1, eflags: 0x5 linked
// namespace_c92f7448<file_0>::function_763ef0fd
// Checksum 0x67486d7a, Offset: 0x29f0
// Size: 0xce
function private function_763ef0fd(localclientnum) {
    self notify(#"hash_763ef0fd");
    self endon(#"hash_763ef0fd");
    self endon(#"entityshutdown");
    while (true) {
        rounds = getroundsplayed(localclientnum);
        if (rounds != level.var_bb2b3f61[localclientnum]) {
            level.var_bb2b3f61[localclientnum] = rounds;
            function_725214c(localclientnum, level.var_bb2b3f61[localclientnum], level.var_32948a58[localclientnum], level.var_f26edb66[localclientnum]);
        }
        wait(1);
    }
}

// Namespace namespace_c92f7448
// Params 1, eflags: 0x5 linked
// namespace_c92f7448<file_0>::function_5d9d13da
// Checksum 0xcd47f3d6, Offset: 0x2ac8
// Size: 0xc0
function private function_5d9d13da(localclientnum) {
    self notify(#"hash_5d9d13da");
    self endon(#"hash_5d9d13da");
    self endon(#"entityshutdown");
    while (true) {
        powerup, state = self waittill(#"powerup");
        if (powerup == "powerup_fire_sale") {
            level.var_f26edb66[localclientnum] = state;
            function_725214c(localclientnum, level.var_bb2b3f61[localclientnum], level.var_32948a58[localclientnum], level.var_f26edb66[localclientnum]);
        }
    }
}

// Namespace namespace_c92f7448
// Params 1, eflags: 0x5 linked
// namespace_c92f7448<file_0>::function_fda54943
// Checksum 0xf65eae22, Offset: 0x2b90
// Size: 0x16e
function private function_fda54943(localclientnum) {
    self endon(#"entityshutdown");
    var_89caac36 = 160000;
    while (true) {
        if (isdefined(level.var_5081bd63)) {
            foreach (machine in level.var_5081bd63) {
                if (distancesquared(self.origin, machine.origin) <= var_89caac36 && 96 > abs(self.origin[2] - machine.origin[2])) {
                    wait(randomintrange(1, 4));
                    machine playsound(localclientnum, "zmb_bgb_lionhead_roar");
                    wait(-126);
                    break;
                }
            }
        }
        wait(1);
    }
}

// Namespace namespace_c92f7448
// Params 7, eflags: 0x5 linked
// namespace_c92f7448<file_0>::function_27a93844
// Checksum 0x717f7168, Offset: 0x2d08
// Size: 0x8c
function private function_27a93844(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    level.var_32948a58[localclientnum] = newval;
    function_725214c(localclientnum, level.var_bb2b3f61[localclientnum], level.var_32948a58[localclientnum], level.var_f26edb66[localclientnum]);
}

// Namespace namespace_c92f7448
// Params 4, eflags: 0x5 linked
// namespace_c92f7448<file_0>::function_725214c
// Checksum 0x1935a457, Offset: 0x2da0
// Size: 0x8c
function private function_725214c(localclientnum, rounds, var_ee234f6e, firesale) {
    var_11e155aa = 500;
    if (firesale) {
        var_11e155aa = 10;
    }
    cost = [[ level.var_6c7a96b4 ]](self, var_11e155aa, var_ee234f6e, rounds, firesale);
    setbgbcost(localclientnum, cost);
}

// Namespace namespace_c92f7448
// Params 5, eflags: 0x1 linked
// namespace_c92f7448<file_0>::function_6c7a96b4
// Checksum 0x5353186d, Offset: 0x2e38
// Size: 0x1c8
function function_6c7a96b4(player, var_11e155aa, var_ee234f6e, rounds, firesale) {
    if (var_ee234f6e < 1 && getdvarint("scr_firstGumFree") === 1) {
        return 0;
    }
    if (!isdefined(level.var_f02c5598)) {
        level.var_f02c5598 = 1000;
    }
    if (!isdefined(level.var_e1dee7ba)) {
        level.var_e1dee7ba = 10;
    }
    if (!isdefined(level.var_1485dcdc)) {
        level.var_1485dcdc = 2;
    }
    cost = 500;
    if (var_ee234f6e >= 1) {
        var_33ea806b = floor(rounds / level.var_e1dee7ba);
        var_33ea806b = math::clamp(var_33ea806b, 0, level.var_8ef45dc2);
        var_39a90c5a = pow(level.var_a3e3127d, var_33ea806b);
        cost += level.var_f02c5598 * var_39a90c5a;
    }
    if (var_ee234f6e >= 2) {
        cost *= level.var_1485dcdc;
    }
    cost = int(cost);
    if (500 != var_11e155aa) {
        cost -= 500 - var_11e155aa;
    }
    return cost;
}

