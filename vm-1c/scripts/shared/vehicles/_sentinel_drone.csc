#using scripts/codescripts/struct;
#using scripts/shared/archetype_shared/archetype_shared;
#using scripts/shared/beam_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/filter_shared;
#using scripts/shared/postfx_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/shared/vehicle_shared;

#using_animtree("generic");

#namespace sentinel_drone;

// Namespace sentinel_drone
// Params 0, eflags: 0x2
// Checksum 0xa226f90f, Offset: 0x8b8
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("sentinel_drone", &__init__, undefined, undefined);
}

// Namespace sentinel_drone
// Params 0, eflags: 0x0
// Checksum 0x14034bb2, Offset: 0x8f8
// Size: 0x866
function __init__() {
    clientfield::register("scriptmover", "sentinel_drone_beam_set_target_id", 12000, 5, "int", &sentinel_drone_beam_set_target_id, 0, 0);
    clientfield::register("vehicle", "sentinel_drone_beam_set_source_to_target", 12000, 5, "int", &sentinel_drone_beam_set_source_to_target, 0, 0);
    clientfield::register("toplayer", "sentinel_drone_damage_player_fx", 12000, 1, "counter", &sentinel_drone_damage_player_fx, 0, 0);
    clientfield::register("vehicle", "sentinel_drone_beam_fire1", 12000, 1, "int", &sentinel_drone_beam_fire1, 0, 0);
    clientfield::register("vehicle", "sentinel_drone_beam_fire2", 12000, 1, "int", &sentinel_drone_beam_fire2, 0, 0);
    clientfield::register("vehicle", "sentinel_drone_beam_fire3", 12000, 1, "int", &sentinel_drone_beam_fire3, 0, 0);
    clientfield::register("vehicle", "sentinel_drone_arm_cut_1", 12000, 1, "int", &sentinel_drone_arm_cut_1, 0, 0);
    clientfield::register("vehicle", "sentinel_drone_arm_cut_2", 12000, 1, "int", &sentinel_drone_arm_cut_2, 0, 0);
    clientfield::register("vehicle", "sentinel_drone_arm_cut_3", 12000, 1, "int", &sentinel_drone_arm_cut_3, 0, 0);
    clientfield::register("vehicle", "sentinel_drone_face_cut", 12000, 1, "int", &sentinel_drone_face_cut, 0, 0);
    clientfield::register("vehicle", "sentinel_drone_beam_charge", 12000, 1, "int", &sentinel_drone_beam_charge, 0, 0);
    clientfield::register("vehicle", "sentinel_drone_camera_scanner", 12000, 1, "int", &sentinel_drone_camera_scanner, 0, 0);
    clientfield::register("vehicle", "sentinel_drone_camera_destroyed", 12000, 1, "int", &sentinel_drone_camera_destroyed, 0, 0);
    clientfield::register("scriptmover", "sentinel_drone_deathfx", 1, 1, "int", &sentinel_drone_deathfx, 0, 0);
    level.var_da3f186 = [];
    if (!isdefined(level.var_da3f186)) {
        level.var_da3f186 = [];
    } else if (!isarray(level.var_da3f186)) {
        level.var_da3f186 = array(level.var_da3f186);
    }
    level.var_da3f186[level.var_da3f186.size] = "vox_valk_valkyrie_detected_0";
    if (!isdefined(level.var_da3f186)) {
        level.var_da3f186 = [];
    } else if (!isarray(level.var_da3f186)) {
        level.var_da3f186 = array(level.var_da3f186);
    }
    level.var_da3f186[level.var_da3f186.size] = "vox_valk_valkyrie_detected_1";
    if (!isdefined(level.var_da3f186)) {
        level.var_da3f186 = [];
    } else if (!isarray(level.var_da3f186)) {
        level.var_da3f186 = array(level.var_da3f186);
    }
    level.var_da3f186[level.var_da3f186.size] = "vox_valk_valkyrie_detected_2";
    if (!isdefined(level.var_da3f186)) {
        level.var_da3f186 = [];
    } else if (!isarray(level.var_da3f186)) {
        level.var_da3f186 = array(level.var_da3f186);
    }
    level.var_da3f186[level.var_da3f186.size] = "vox_valk_valkyrie_detected_3";
    if (!isdefined(level.var_da3f186)) {
        level.var_da3f186 = [];
    } else if (!isarray(level.var_da3f186)) {
        level.var_da3f186 = array(level.var_da3f186);
    }
    level.var_da3f186[level.var_da3f186.size] = "vox_valk_valkyrie_detected_4";
    level.var_c1265ed9 = [];
    if (!isdefined(level.var_c1265ed9)) {
        level.var_c1265ed9 = [];
    } else if (!isarray(level.var_c1265ed9)) {
        level.var_c1265ed9 = array(level.var_c1265ed9);
    }
    level.var_c1265ed9[level.var_c1265ed9.size] = "vox_valk_valkyrie_attack_0";
    if (!isdefined(level.var_c1265ed9)) {
        level.var_c1265ed9 = [];
    } else if (!isarray(level.var_c1265ed9)) {
        level.var_c1265ed9 = array(level.var_c1265ed9);
    }
    level.var_c1265ed9[level.var_c1265ed9.size] = "vox_valk_valkyrie_attack_1";
    if (!isdefined(level.var_c1265ed9)) {
        level.var_c1265ed9 = [];
    } else if (!isarray(level.var_c1265ed9)) {
        level.var_c1265ed9 = array(level.var_c1265ed9);
    }
    level.var_c1265ed9[level.var_c1265ed9.size] = "vox_valk_valkyrie_attack_2";
    if (!isdefined(level.var_c1265ed9)) {
        level.var_c1265ed9 = [];
    } else if (!isarray(level.var_c1265ed9)) {
        level.var_c1265ed9 = array(level.var_c1265ed9);
    }
    level.var_c1265ed9[level.var_c1265ed9.size] = "vox_valk_valkyrie_attack_3";
    if (!isdefined(level.var_c1265ed9)) {
        level.var_c1265ed9 = [];
    } else if (!isarray(level.var_c1265ed9)) {
        level.var_c1265ed9 = array(level.var_c1265ed9);
    }
    level.var_c1265ed9[level.var_c1265ed9.size] = "vox_valk_valkyrie_attack_4";
}

// Namespace sentinel_drone
// Params 2, eflags: 0x0
// Checksum 0xb6fc3237, Offset: 0x1168
// Size: 0xe0
function function_ef489818(localclientnum, var_6812fc7e) {
    if (!(isdefined(var_6812fc7e) && var_6812fc7e)) {
        if (!(isdefined(self.init) && self.init)) {
            return 0;
        }
        if (!self hasdobj(localclientnum)) {
            return 0;
        }
        return 1;
    }
    var_5217a417 = self getentitynumber();
    if (isdefined(level.var_225773ca) && isdefined(level.var_225773ca[var_5217a417]) && isdefined(level.var_cc9f03f2) && isdefined(level.var_cc9f03f2[level.var_225773ca[var_5217a417]])) {
        return 1;
    }
    return 0;
}

// Namespace sentinel_drone
// Params 7, eflags: 0x0
// Checksum 0x97c2f600, Offset: 0x1250
// Size: 0x84
function sentinel_drone_damage_player_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    localplayer = getlocalplayer(localclientnum);
    if (isdefined(localplayer)) {
        localplayer thread postfx::playpostfxbundle("sentinel_pstfx_shock_charge");
    }
}

// Namespace sentinel_drone
// Params 7, eflags: 0x0
// Checksum 0xe3c49f09, Offset: 0x12e0
// Size: 0x118
function sentinel_drone_deathfx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    settings = struct::get_script_bundle("vehiclecustomsettings", "sentinel_drone_settings");
    if (isdefined(settings)) {
        if (newval) {
            handle = playfx(localclientnum, settings.var_f8e94e9a, self.origin);
            setfxignorepause(localclientnum, handle, 1);
            if (isdefined(self.var_fa99de69) && isdefined(self.var_fa99de69[localclientnum])) {
                stopfx(localclientnum, self.var_fa99de69[localclientnum]);
                self.var_fa99de69[localclientnum] = undefined;
            }
        }
    }
}

// Namespace sentinel_drone
// Params 7, eflags: 0x0
// Checksum 0xa3d27f8c, Offset: 0x1400
// Size: 0x16c
function sentinel_drone_camera_scanner(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (!function_ef489818(localclientnum)) {
        return 0;
    }
    if (newval == 1) {
        if (!isdefined(self.var_e8ba058) && !(isdefined(self.var_2a9c93f1) && self.var_2a9c93f1)) {
            self.var_e8ba058 = playfxontag(localclientnum, "dlc3/stalingrad/fx_sentinel_drone_scanner_light_glow", self, "tag_flash");
        }
        function_63263dd8(localclientnum, 0, 1);
        return;
    }
    /#
        var_23c9b617 = getdvarint("<dev string:x28>", 0);
    #/
    if (isdefined(self.var_e8ba058) && !(isdefined(var_23c9b617) && var_23c9b617)) {
        stopfx(localclientnum, self.var_e8ba058);
        self.var_e8ba058 = undefined;
    }
    function_63263dd8(localclientnum, 1, 0);
}

// Namespace sentinel_drone
// Params 7, eflags: 0x0
// Checksum 0xf5720710, Offset: 0x1578
// Size: 0xb6
function sentinel_drone_camera_destroyed(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self.var_2a9c93f1 = 1;
    if (isdefined(self.var_e8ba058)) {
        stopfx(localclientnum, self.var_e8ba058);
        self.var_e8ba058 = undefined;
    }
    if (isdefined(self.var_4ed62dca)) {
        stopfx(localclientnum, self.var_4ed62dca);
        self.var_4ed62dca = undefined;
    }
}

// Namespace sentinel_drone
// Params 7, eflags: 0x0
// Checksum 0xfa8e1002, Offset: 0x1638
// Size: 0x5c
function sentinel_drone_beam_fire1(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    sentinel_drone_beam_fire(localclientnum, newval, "tag_fx1");
}

// Namespace sentinel_drone
// Params 7, eflags: 0x0
// Checksum 0xe9ad0cb8, Offset: 0x16a0
// Size: 0x5c
function sentinel_drone_beam_fire2(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    sentinel_drone_beam_fire(localclientnum, newval, "tag_fx2");
}

// Namespace sentinel_drone
// Params 7, eflags: 0x0
// Checksum 0xb3a596ea, Offset: 0x1708
// Size: 0x5c
function sentinel_drone_beam_fire3(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    sentinel_drone_beam_fire(localclientnum, newval, "tag_fx3");
}

// Namespace sentinel_drone
// Params 3, eflags: 0x0
// Checksum 0x970c0dda, Offset: 0x1770
// Size: 0x284
function sentinel_drone_beam_fire(localclientnum, newval, var_16ca5989) {
    if (function_ef489818(localclientnum, newval == 0)) {
        var_5217a417 = self getentitynumber();
        var_ae9fcf28 = level.var_cc9f03f2[level.var_225773ca[var_5217a417]];
    } else {
        return;
    }
    if (newval == 1) {
        level beam::launch(self, var_16ca5989, var_ae9fcf28, "tag_origin", "electric_taser_beam_1");
        self playsound(0, "zmb_sentinel_attack_short");
        if (!isdefined(var_ae9fcf28.var_fa99de69)) {
            var_ae9fcf28.var_fa99de69 = [];
        }
        if (!isdefined(var_ae9fcf28.var_fa99de69[localclientnum])) {
            var_ae9fcf28.var_fa99de69[localclientnum] = playfxontag(localclientnum, "dlc3/stalingrad/fx_sentinel_drone_taser_fire_tgt", var_ae9fcf28, "tag_origin");
        }
        /#
            var_23c9b617 = getdvarint("<dev string:x28>", 0);
        #/
        if (isdefined(self.var_e8ba058) && !(isdefined(var_23c9b617) && var_23c9b617)) {
            stopfx(localclientnum, self.var_e8ba058);
            self.var_e8ba058 = undefined;
        }
        return;
    }
    level beam::kill(self, var_16ca5989, var_ae9fcf28, "tag_origin", "electric_taser_beam_1");
    if (isdefined(var_ae9fcf28.var_fa99de69) && isdefined(var_ae9fcf28.var_fa99de69[localclientnum])) {
        stopfx(localclientnum, var_ae9fcf28.var_fa99de69[localclientnum]);
        var_ae9fcf28.var_fa99de69[localclientnum] = undefined;
    }
    self function_a12166b7(localclientnum);
}

// Namespace sentinel_drone
// Params 7, eflags: 0x0
// Checksum 0x2d9eacc0, Offset: 0x1a00
// Size: 0x66
function sentinel_drone_beam_set_target_id(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (!isdefined(level.var_cc9f03f2)) {
        level.var_cc9f03f2 = [];
    }
    level.var_cc9f03f2[newval] = self;
}

// Namespace sentinel_drone
// Params 7, eflags: 0x0
// Checksum 0xa3fd07dd, Offset: 0x1a70
// Size: 0x174
function sentinel_drone_beam_set_source_to_target(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (!isdefined(level.var_225773ca)) {
        level.var_225773ca = [];
    }
    var_5217a417 = self getentitynumber();
    level.var_225773ca[var_5217a417] = newval;
    self.init = 1;
    self function_a12166b7(localclientnum);
    self.var_4ed62dca = playfxontag(localclientnum, "dlc3/stalingrad/fx_sentinel_drone_eye_camera_lens_glow", self, "tag_flash");
    self.var_e8ba058 = playfxontag(localclientnum, "dlc3/stalingrad/fx_sentinel_drone_scanner_light_glow", self, "tag_flash");
    function_63263dd8(localclientnum, 1, 0);
    self useanimtree(#generic);
    self setanim("ai_zm_dlc3_sentinel_antenna_twitch");
}

// Namespace sentinel_drone
// Params 7, eflags: 0x0
// Checksum 0x9136d004, Offset: 0x1bf0
// Size: 0x54
function sentinel_drone_arm_cut_1(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    function_4e289824(localclientnum, 1);
}

// Namespace sentinel_drone
// Params 7, eflags: 0x0
// Checksum 0xa99dc533, Offset: 0x1c50
// Size: 0x54
function sentinel_drone_arm_cut_2(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    function_4e289824(localclientnum, 2);
}

// Namespace sentinel_drone
// Params 7, eflags: 0x0
// Checksum 0x185717d, Offset: 0x1cb0
// Size: 0x54
function sentinel_drone_arm_cut_3(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    function_4e289824(localclientnum, 3);
}

// Namespace sentinel_drone
// Params 4, eflags: 0x0
// Checksum 0xf5c748fb, Offset: 0x1d10
// Size: 0x2cc
function function_1aa38bc(localclientnum, arm, var_8d383b60, var_9e4e05d5) {
    if (!function_ef489818(localclientnum)) {
        return 0;
    }
    velocity = self getvelocity();
    var_829e8366 = vectornormalize(velocity);
    var_b02fd9f = length(velocity);
    if (arm == 3) {
        launch_dir = anglestoforward(self.angles) * -1;
        launch_dir += (0, 0, 1);
        launch_dir = vectornormalize(launch_dir);
    } else if (arm == 1) {
        launch_dir = anglestoright(self.angles);
    } else {
        launch_dir = anglestoright(self.angles) * -1;
    }
    var_b02fd9f *= 0.1;
    if (var_b02fd9f < 10) {
        var_b02fd9f = 10;
    }
    launch_dir = launch_dir * 0.5 + var_829e8366 * 0.5;
    launch_dir *= var_b02fd9f;
    var_27fd254f = self gettagorigin(var_9e4e05d5) + launch_dir * 3;
    var_ba315ad5 = self gettagangles(var_9e4e05d5);
    thread function_1895ad7e(localclientnum, "veh_t7_dlc3_sentinel_drone_spawn_claw", var_27fd254f, var_ba315ad5, self.origin, launch_dir * 1.3);
    arm_pos = self gettagorigin(var_8d383b60) + launch_dir * 2;
    var_95c06dc0 = self gettagangles(var_8d383b60);
    thread function_1895ad7e(localclientnum, "veh_t7_dlc3_sentinel_drone_spawn_arm", arm_pos, var_95c06dc0, self.origin, launch_dir);
}

// Namespace sentinel_drone
// Params 2, eflags: 0x0
// Checksum 0xd4a3c8c5, Offset: 0x1fe8
// Size: 0x3ec
function function_4e289824(localclientnum, arm) {
    if (arm == 1) {
        if (!(isdefined(self.var_ac85d0eb) && self.var_ac85d0eb)) {
            function_1aa38bc(localclientnum, 1, "tag_arm_right_04_d1", "tag_fx1");
            self.var_ac85d0eb = 1;
            sentinel_drone_beam_fire(localclientnum, 0, "tag_fx1");
            if (isdefined(self.var_5ebbff4a)) {
                stopfx(localclientnum, self.var_5ebbff4a);
                self.var_5ebbff4a = undefined;
            }
            if (isdefined(self.var_7c5a5896)) {
                stopfx(localclientnum, self.var_7c5a5896);
                self.var_7c5a5896 = undefined;
            }
            if (function_ef489818(localclientnum)) {
                playfxontag(localclientnum, "dlc3/stalingrad/fx_sentinel_drone_dest_arm", self, "tag_arm_right_04_d1");
                self setanim("ai_zm_dlc3_sentinel_arms_broken_right");
            }
        }
        return;
    }
    if (arm == 2) {
        if (!(isdefined(self.var_574c563a) && self.var_574c563a)) {
            function_1aa38bc(localclientnum, 2, "tag_arm_left_03_d1", "tag_fx2");
            self.var_574c563a = 1;
            sentinel_drone_beam_fire(localclientnum, 0, "tag_fx2");
            if (isdefined(self.var_8acd7f5f)) {
                stopfx(localclientnum, self.var_8acd7f5f);
                self.var_8acd7f5f = undefined;
            }
            if (isdefined(self.var_15533add)) {
                stopfx(localclientnum, self.var_15533add);
                self.var_15533add = undefined;
            }
            if (function_ef489818(localclientnum)) {
                playfxontag(localclientnum, "dlc3/stalingrad/fx_sentinel_drone_dest_arm", self, "tag_arm_left_03_d1");
                self setanim("ai_zm_dlc3_sentinel_arms_broken_left");
            }
        }
        return;
    }
    if (arm == 3) {
        if (!(isdefined(self.var_20d170b2) && self.var_20d170b2)) {
            function_1aa38bc(localclientnum, 3, "tag_arm_top_03_d1", "tag_fx3");
            self.var_20d170b2 = 1;
            sentinel_drone_beam_fire(localclientnum, 0, "tag_fx3");
            if (isdefined(self.var_ec566a57)) {
                stopfx(localclientnum, self.var_ec566a57);
                self.var_ec566a57 = undefined;
            }
            if (isdefined(self.var_3469a225)) {
                stopfx(localclientnum, self.var_3469a225);
                self.var_3469a225 = undefined;
            }
            if (function_ef489818(localclientnum)) {
                playfxontag(localclientnum, "dlc3/stalingrad/fx_sentinel_drone_dest_arm", self, "tag_arm_top_03_d1");
                self setanim("ai_zm_dlc3_sentinel_arms_broken_top");
            }
        }
    }
}

// Namespace sentinel_drone
// Params 7, eflags: 0x0
// Checksum 0xecb13ef2, Offset: 0x23e0
// Size: 0x2a6
function sentinel_drone_beam_charge(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (!function_ef489818(localclientnum)) {
        return 0;
    }
    if (newval == 1) {
        if (!isdefined(self.var_e8ba058)) {
            self.var_e8ba058 = playfxontag(localclientnum, "dlc3/stalingrad/fx_sentinel_drone_scanner_light_glow", self, "tag_flash");
        }
        self function_a12166b7(localclientnum, 1);
        if (!(isdefined(self.var_ac85d0eb) && self.var_ac85d0eb)) {
            self.var_7c5a5896 = playfxontag(localclientnum, "dlc3/stalingrad/fx_sentinel_drone_taser_charging", self, "tag_fx1");
        }
        if (!(isdefined(self.var_574c563a) && self.var_574c563a)) {
            self.var_15533add = playfxontag(localclientnum, "dlc3/stalingrad/fx_sentinel_drone_taser_charging", self, "tag_fx2");
        }
        if (!(isdefined(self.var_20d170b2) && self.var_20d170b2)) {
            self.var_3469a225 = playfxontag(localclientnum, "dlc3/stalingrad/fx_sentinel_drone_taser_charging", self, "tag_fx3");
        }
        if (isdefined(self.var_96e9f98)) {
            if (randomint(100) < 30) {
                function_36da0be3(localclientnum, level.var_c1265ed9);
            }
        } else {
            self.var_96e9f98 = 1;
            function_36da0be3(localclientnum, level.var_da3f186);
        }
        return;
    }
    if (isdefined(self.var_7c5a5896)) {
        stopfx(localclientnum, self.var_7c5a5896);
        self.var_7c5a5896 = undefined;
    }
    if (isdefined(self.var_15533add)) {
        stopfx(localclientnum, self.var_15533add);
        self.var_15533add = undefined;
    }
    if (isdefined(self.var_3469a225)) {
        stopfx(localclientnum, self.var_3469a225);
        self.var_3469a225 = undefined;
    }
}

// Namespace sentinel_drone
// Params 7, eflags: 0x0
// Checksum 0xd1045859, Offset: 0x2690
// Size: 0x20c
function sentinel_drone_face_cut(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (!function_ef489818(localclientnum)) {
        return 0;
    }
    var_973c1591 = self gettagorigin("tag_faceplate_d0");
    var_7e0d85bf = self gettagangles("tag_faceplate_d0");
    velocity = self getvelocity();
    var_829e8366 = vectornormalize(velocity);
    var_b02fd9f = length(velocity);
    launch_dir = anglestoforward(self.angles);
    var_b02fd9f *= 0.1;
    if (var_b02fd9f < 10) {
        var_b02fd9f = 10;
    }
    launch_dir = launch_dir * 0.5 + var_829e8366 * 0.5;
    launch_dir *= var_b02fd9f;
    thread function_1895ad7e(localclientnum, "veh_t7_dlc3_sentinel_drone_faceplate", var_973c1591, var_7e0d85bf, self.origin, launch_dir);
    playfxontag(localclientnum, "dlc3/stalingrad/fx_sentinel_drone_dest_core", self, "tag_faceplate_d0");
    playfxontag(localclientnum, "dlc3/stalingrad/fx_sentinel_drone_energy_core_glow", self, "ag_core_d0");
}

// Namespace sentinel_drone
// Params 2, eflags: 0x0
// Checksum 0x9994c94c, Offset: 0x28a8
// Size: 0x1de
function function_a12166b7(localclientnum, var_a1cf56b1) {
    if (!function_ef489818(localclientnum)) {
        return 0;
    }
    if (!(isdefined(var_a1cf56b1) && var_a1cf56b1)) {
        if (!(isdefined(self.var_ac85d0eb) && self.var_ac85d0eb) && !isdefined(self.var_5ebbff4a)) {
            self.var_5ebbff4a = playfxontag(localclientnum, "dlc3/stalingrad/fx_sentinel_drone_taser_idle", self, "tag_fx1");
        }
        if (!(isdefined(self.var_574c563a) && self.var_574c563a) && !isdefined(self.var_8acd7f5f)) {
            self.var_8acd7f5f = playfxontag(localclientnum, "dlc3/stalingrad/fx_sentinel_drone_taser_idle", self, "tag_fx2");
        }
        if (!(isdefined(self.var_20d170b2) && self.var_20d170b2) && !isdefined(self.var_ec566a57)) {
            self.var_ec566a57 = playfxontag(localclientnum, "dlc3/stalingrad/fx_sentinel_drone_taser_idle", self, "tag_fx3");
        }
        return;
    }
    if (isdefined(self.var_5ebbff4a)) {
        stopfx(localclientnum, self.var_5ebbff4a);
        self.var_5ebbff4a = undefined;
    }
    if (isdefined(self.var_8acd7f5f)) {
        stopfx(localclientnum, self.var_8acd7f5f);
        self.var_8acd7f5f = undefined;
    }
    if (isdefined(self.var_ec566a57)) {
        stopfx(localclientnum, self.var_ec566a57);
        self.var_ec566a57 = undefined;
    }
}

// Namespace sentinel_drone
// Params 3, eflags: 0x0
// Checksum 0xe8778da9, Offset: 0x2a90
// Size: 0x11c
function function_63263dd8(localclientnum, var_99fbabae, var_a8165ada) {
    if (!function_ef489818(localclientnum)) {
        return 0;
    }
    if (isdefined(var_99fbabae) && var_99fbabae) {
        self.enginefx = playfxontag(localclientnum, "dlc3/stalingrad/fx_sentinel_drone_engine_idle", self, "tag_fx_engine_left");
    } else if (isdefined(self.enginefx)) {
        stopfx(localclientnum, self.enginefx);
    }
    if (isdefined(var_a8165ada) && var_a8165ada) {
        self.var_7052b604 = playfxontag(localclientnum, "dlc3/stalingrad/fx_sentinel_drone_engine_smk_fast", self, "tag_fx_engine_left");
        return;
    }
    if (isdefined(self.var_7052b604)) {
        stopfx(localclientnum, self.var_7052b604);
    }
}

// Namespace sentinel_drone
// Params 2, eflags: 0x0
// Checksum 0xe12ec8df, Offset: 0x2bb8
// Size: 0xa4
function function_36da0be3(localclientnum, var_7cb1f6e7) {
    if (isdefined(level.var_682d2753) && gettime() - level.var_682d2753 < 6000) {
        return;
    }
    if (isdefined(level.var_6f29d418) && level.var_6f29d418) {
        return;
    }
    taunt = randomint(var_7cb1f6e7.size);
    level.var_682d2753 = gettime();
    self playsound(localclientnum, var_7cb1f6e7[taunt]);
}

// Namespace sentinel_drone
// Params 6, eflags: 0x0
// Checksum 0x11988766, Offset: 0x2c68
// Size: 0x284
function function_1895ad7e(localclientnum, model, pos, angles, hitpos, force) {
    dynent = createdynentandlaunch(localclientnum, model, pos, angles, hitpos, force);
    if (!isdefined(dynent)) {
        return;
    }
    var_98ef5c90 = pos[2];
    wait 0.5;
    if (!isdefined(dynent) || !isdynentvalid(dynent)) {
        return 0;
    }
    if (dynent.origin == pos) {
        setdynentenabled(dynent, 0);
        return;
    }
    pos = dynent.origin;
    wait 0.4;
    if (!isdefined(dynent) || !isdynentvalid(dynent)) {
        return 0;
    }
    if (dynent.origin == pos) {
        setdynentenabled(dynent, 0);
        return;
    }
    wait 1;
    if (!isdefined(dynent) || !isdynentvalid(dynent)) {
        return 0;
    }
    count = 0;
    old_pos = dynent.origin;
    while (isdefined(dynent) && isdynentvalid(dynent)) {
        if (old_pos == dynent.origin) {
            old_pos = dynent.origin;
            count++;
            if (count == 5) {
                if (var_98ef5c90 - dynent.origin[2] < 15) {
                    setdynentenabled(dynent, 0);
                } else {
                    break;
                }
            }
        } else {
            count = 0;
        }
        wait 0.2;
    }
}

