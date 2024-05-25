#using scripts/cp/cp_mi_zurich_newworld_util;
#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/fx_shared;
#using scripts/shared/postfx_shared;
#using scripts/shared/clientfield_shared;
#using scripts/cp/_load;
#using scripts/codescripts/struct;

#namespace namespace_ce0e5f06;

// Namespace namespace_ce0e5f06
// Params 0, eflags: 0x2
// Checksum 0x46391438, Offset: 0xab8
// Size: 0x2a
function autoexec function_2dc19561() {
    system::register("newworld_util", &__init__, undefined, undefined);
}

// Namespace namespace_ce0e5f06
// Params 0, eflags: 0x0
// Checksum 0xf0b3f52f, Offset: 0xaf0
// Size: 0x12
function __init__() {
    init_clientfields();
}

// Namespace namespace_ce0e5f06
// Params 0, eflags: 0x0
// Checksum 0xde6db1bb, Offset: 0xb10
// Size: 0x542
function init_clientfields() {
    clientfield::register("actor", "derez_ai_deaths", 1, 1, "int", &function_ecc75bea, 0, 0);
    clientfield::register("actor", "cs_rez_in_fx", 1, 2, "counter", &function_9b9abce4, 0, 0);
    clientfield::register("actor", "cs_rez_out_fx", 1, 2, "counter", &function_be66c05b, 0, 0);
    clientfield::register("actor", "chase_suspect_fx", 1, 1, "int", &function_6e7d0ca2, 0, 0);
    clientfield::register("actor", "wall_run_fx", 1, 1, "int", &function_752d4412, 0, 0);
    clientfield::register("scriptmover", "derez_ai_deaths", 1, 1, "int", &function_ecc75bea, 0, 0);
    clientfield::register("scriptmover", "truck_explosion_fx", 1, 1, "int", &function_258012a1, 0, 0);
    clientfield::register("scriptmover", "derez_model_deaths", 1, 1, "int", &function_ecc75bea, 0, 0);
    clientfield::register("scriptmover", "emp_door_fx", 1, 1, "int", &function_ddee6a4e, 0, 0);
    clientfield::register("scriptmover", "smoke_grenade_fx", 1, 1, "int", &function_ce461171, 0, 0);
    clientfield::register("scriptmover", "frag_grenade_fx", 1, 1, "int", &function_1e4e8925, 0, 0);
    clientfield::register("scriptmover", "wall_break_fx", 1, 1, "int", &function_c8c87ed0, 0, 0);
    clientfield::register("scriptmover", "train_explosion_fx", 1, 1, "int", &function_8d759480, 0, 0);
    clientfield::register("scriptmover", "wasp_hack_fx", 1, 1, "int", &function_ec9960ef, 0, 0);
    clientfield::register("vehicle", "wasp_hack_fx", 1, 1, "int", &function_ec9960ef, 0, 0);
    clientfield::register("vehicle", "emp_vehicles_fx", 1, 1, "int", &function_ddee6a4e, 0, 0);
    clientfield::register("world", "player_snow_fx", 1, 4, "int", &function_e416b7db, 0, 0);
    clientfield::register("allplayers", "player_spawn_fx", 1, 1, "int", &function_aebc5072, 0, 0);
    clientfield::register("scriptmover", "emp_generator_fx", 1, 1, "int", &function_aad321ae, 0, 0);
    clientfield::register("scriptmover", "train_fx_occlude", 1, 1, "int", &function_73c10276, 0, 0);
    clientfield::register("world", "waterplant_rotate_fans", 1, 1, "int", &function_1e2a542f, 0, 0);
    clientfield::register("world", "train_main_fx_occlude", 1, 1, "int", &function_4f8cc662, 0, 0);
    clientfield::register("toplayer", "train_rumble_loop", 1, 1, "int", &function_b45c2459, 0, 0);
    clientfield::register("toplayer", "postfx_futz", 1, 1, "counter", &function_baae4949, 0, 0);
}

// Namespace namespace_ce0e5f06
// Params 7, eflags: 0x0
// Checksum 0x2e97a575, Offset: 0x1060
// Size: 0x1c2
function function_ecc75bea(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval == 1 && isdefined(localclientnum)) {
        self playsound(0, "evt_ai_derez");
        function_bd23b431(localclientnum, "player/fx_ai_dni_rez_out_arm_left_clean", "j_elbow_le");
        function_bd23b431(localclientnum, "player/fx_ai_dni_rez_out_arm_left_clean", "j_shoulder_le");
        function_bd23b431(localclientnum, "player/fx_ai_dni_rez_out_arm_right_clean", "j_elbow_ri");
        function_bd23b431(localclientnum, "player/fx_ai_dni_rez_out_arm_right_clean", "j_shoulder_ri");
        function_bd23b431(localclientnum, "player/fx_ai_dni_rez_out_head_clean", "j_head");
        function_bd23b431(localclientnum, "player/fx_ai_dni_rez_out_hip_left_clean", "j_hip_le");
        function_bd23b431(localclientnum, "player/fx_ai_dni_rez_out_hip_right_clean", "j_hip_ri");
        function_bd23b431(localclientnum, "player/fx_ai_dni_rez_out_leg_left_clean", "j_knee_le");
        function_bd23b431(localclientnum, "player/fx_ai_dni_rez_out_leg_right_clean", "j_knee_ri");
        function_bd23b431(localclientnum, "player/fx_ai_dni_rez_out_torso_clean", "j_spine4");
        function_bd23b431(localclientnum, "player/fx_ai_dni_rez_out_waist_clean", "j_spinelower");
    }
}

// Namespace namespace_ce0e5f06
// Params 7, eflags: 0x0
// Checksum 0x9d34ea35, Offset: 0x1230
// Size: 0x1c2
function function_e416b7db(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    player = getlocalplayer(localclientnum);
    if (newval == 1) {
        player thread function_120f324e(localclientnum, 1);
        return;
    }
    if (newval == 2) {
        player thread function_120f324e(localclientnum, 0.5);
        return;
    }
    if (newval == 3) {
        player thread function_120f324e(localclientnum, 0.25);
        return;
    }
    if (newval == 4) {
        player notify(#"hash_860e4d9e");
        if (isdefined(player.var_75c53109)) {
            player.var_75c53109 delete();
        }
        player.var_75c53109 = util::spawn_model(localclientnum, "tag_origin", player.origin);
        player.var_75c53109 linkto(player);
        playfxontag(localclientnum, "weather/fx_snow_player_os_nworld", player.var_75c53109, "tag_origin");
        player.var_75c53109 thread function_7683b584(player);
        return;
    }
    player notify(#"hash_860e4d9e");
    if (isdefined(player.var_75c53109)) {
        player.var_75c53109 delete();
    }
}

// Namespace namespace_ce0e5f06
// Params 1, eflags: 0x0
// Checksum 0xd6e1677, Offset: 0x1400
// Size: 0x2a
function function_7683b584(player) {
    self endon(#"death");
    player waittill(#"death");
    self delete();
}

// Namespace namespace_ce0e5f06
// Params 2, eflags: 0x0
// Checksum 0xaf67d10f, Offset: 0x1438
// Size: 0x69
function function_120f324e(localclientnum, n_delay) {
    self notify(#"hash_860e4d9e");
    self endon(#"hash_860e4d9e");
    if (isdefined(self.var_75c53109)) {
        self.var_75c53109 delete();
    }
    while (isdefined(self)) {
        playfxontag(localclientnum, "weather/fx_snow_player_slow_os_nworld", self, "none");
        wait(n_delay);
    }
}

// Namespace namespace_ce0e5f06
// Params 1, eflags: 0x0
// Checksum 0x12008e2c, Offset: 0x14b0
// Size: 0x122
function function_ff1b6796(localclientnum) {
    if (isdefined(self.var_f3f44e9)) {
        return;
    }
    v_offset = (0, 0, 0);
    str_fx = "snow/fx_snow_train_flap_sm";
    if (self.model == "p7_zur_train_car_brake_flap_36") {
        v_offset = (36, 0, 0);
        str_fx = "snow/fx_snow_train_flap";
    } else if (self.model == "p7_zur_train_car_brake_flap_48") {
        v_offset = (48, 0, 0);
        str_fx = "snow/fx_snow_train_flap_sm";
    } else if (self.model == "p7_zur_train_car_brake_flap_48_yellow") {
        v_offset = (48, 0, 0);
        str_fx = "snow/fx_snow_train_flap_sm";
    }
    e_origin = util::spawn_model(localclientnum, "tag_origin", self.origin + v_offset, self.angles);
    e_origin linkto(self);
    self.var_f3f44e9 = e_origin;
    e_origin function_88a10e85(localclientnum, "brake_flap_snow", str_fx, "tag_origin");
}

// Namespace namespace_ce0e5f06
// Params 1, eflags: 0x0
// Checksum 0x37f8ee02, Offset: 0x15e0
// Size: 0x32
function function_52bc98a1(localclientnum) {
    self function_88a10e85(localclientnum, "robot_snow_impact", "snow/fx_snow_train_robot_fall_impact", "tag_origin", 0);
}

// Namespace namespace_ce0e5f06
// Params 7, eflags: 0x0
// Checksum 0xe5bdbbd9, Offset: 0x1620
// Size: 0x8a
function function_aebc5072(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        self function_88a10e85(localclientnum, "objective_light", "player/fx_ai_dni_rez_in_hero_clean");
        return;
    }
    self function_be968491(localclientnum, "objective_light", "player/fx_ai_dni_rez_in_hero_clean");
}

// Namespace namespace_ce0e5f06
// Params 7, eflags: 0x0
// Checksum 0x7a99cb23, Offset: 0x16b8
// Size: 0x1ba
function function_9b9abce4(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    function_bd23b431(localclientnum, "player/fx_ai_dni_rez_in_arm_left_clean", "j_elbow_le");
    function_bd23b431(localclientnum, "player/fx_ai_dni_rez_in_arm_left_clean", "j_shoulder_le");
    function_bd23b431(localclientnum, "player/fx_ai_dni_rez_in_arm_right_clean", "j_elbow_ri");
    function_bd23b431(localclientnum, "player/fx_ai_dni_rez_in_arm_right_clean", "j_shoulder_ri");
    function_bd23b431(localclientnum, "player/fx_ai_dni_rez_in_head_clean", "j_head");
    function_bd23b431(localclientnum, "player/fx_ai_dni_rez_in_hip_left_clean", "j_hip_le");
    function_bd23b431(localclientnum, "player/fx_ai_dni_rez_in_hip_right_clean", "j_hip_ri");
    function_bd23b431(localclientnum, "player/fx_ai_dni_rez_in_leg_left_clean", "j_knee_le");
    function_bd23b431(localclientnum, "player/fx_ai_dni_rez_in_leg_right_clean", "j_knee_ri");
    function_bd23b431(localclientnum, "player/fx_ai_dni_rez_in_torso_clean", "j_spine4");
    function_bd23b431(localclientnum, "player/fx_ai_dni_rez_in_waist_clean", "j_spinelower");
    if (newval == 2) {
        self thread function_1c2b3dda(localclientnum, 1);
    }
}

// Namespace namespace_ce0e5f06
// Params 7, eflags: 0x0
// Checksum 0xbaa4f1af, Offset: 0x1880
// Size: 0x1ba
function function_be66c05b(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    function_bd23b431(localclientnum, "player/fx_ai_dni_rez_out_arm_left_clean", "j_elbow_le");
    function_bd23b431(localclientnum, "player/fx_ai_dni_rez_out_arm_left_clean", "j_shoulder_le");
    function_bd23b431(localclientnum, "player/fx_ai_dni_rez_out_arm_right_clean", "j_elbow_ri");
    function_bd23b431(localclientnum, "player/fx_ai_dni_rez_out_arm_right_clean", "j_shoulder_ri");
    function_bd23b431(localclientnum, "player/fx_ai_dni_rez_out_head_clean", "j_head");
    function_bd23b431(localclientnum, "player/fx_ai_dni_rez_out_hip_left_clean", "j_hip_le");
    function_bd23b431(localclientnum, "player/fx_ai_dni_rez_out_hip_right_clean", "j_hip_ri");
    function_bd23b431(localclientnum, "player/fx_ai_dni_rez_out_leg_left_clean", "j_knee_le");
    function_bd23b431(localclientnum, "player/fx_ai_dni_rez_out_leg_right_clean", "j_knee_ri");
    function_bd23b431(localclientnum, "player/fx_ai_dni_rez_out_torso_clean", "j_spine4");
    function_bd23b431(localclientnum, "player/fx_ai_dni_rez_out_waist_clean", "j_spinelower");
    if (newval == 2) {
        self thread function_1c2b3dda(localclientnum, 0);
    }
}

// Namespace namespace_ce0e5f06
// Params 2, eflags: 0x0
// Checksum 0x9fc38f41, Offset: 0x1a48
// Size: 0x142
function function_1c2b3dda(localclientnum, var_21082827) {
    if (!isdefined(var_21082827)) {
        var_21082827 = 1;
    }
    self endon(#"entityshutdown");
    start_time = gettime();
    if (!var_21082827) {
        self mapshaderconstant(0, 0, "scriptVector0", 0, 0, 0);
    } else {
        self mapshaderconstant(0, 0, "scriptVector0", 1, 0, 0);
    }
    b_is_updating = 1;
    while (b_is_updating) {
        time = gettime();
        var_e65455e6 = (time - start_time) / 1000;
        if (var_e65455e6 >= 0.5) {
            var_e65455e6 = 0.5;
            b_is_updating = 0;
        }
        if (!var_21082827) {
            n_opacity = 1 - var_e65455e6 / 0.5;
        } else {
            n_opacity = var_e65455e6 / 0.5;
        }
        self mapshaderconstant(0, 0, "scriptVector0", n_opacity, 0, 0);
        wait(0.01);
    }
    wait(0.05);
    self mapshaderconstant(0, 0, "scriptVector0", 0, 0, 0);
}

// Namespace namespace_ce0e5f06
// Params 3, eflags: 0x0
// Checksum 0xd63f06da, Offset: 0x1b98
// Size: 0x52
function function_bd23b431(localclientnum, str_fx, str_tag) {
    n_fx_id = playfxontag(localclientnum, str_fx, self, str_tag);
    setfxignorepause(localclientnum, n_fx_id, 1);
}

// Namespace namespace_ce0e5f06
// Params 7, eflags: 0x0
// Checksum 0x19c3c26b, Offset: 0x1bf8
// Size: 0x122
function function_6e7d0ca2(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        self function_88a10e85(localclientnum, "suspect_trail", "player/fx_plyr_ghost_trail_nworld", "tag_origin");
        self function_88a10e85(localclientnum, "suspect_trail_feet_left", "player/fx_plyr_ghost_trail_feet_nworld", "J_Ball_LE");
        self function_88a10e85(localclientnum, "suspect_trail_feet_right", "player/fx_plyr_ghost_trail_feet_nworld", "J_Ball_RI");
        return;
    }
    self function_be968491(localclientnum, "suspect_trail", "player/fx_plyr_ghost_trail_nworld");
    self function_be968491(localclientnum, "suspect_trail_feet_left", "player/fx_plyr_ghost_trail_feet_nworld");
    self function_be968491(localclientnum, "suspect_trail_feet_right", "player/fx_plyr_ghost_trail_feet_nworld");
}

// Namespace namespace_ce0e5f06
// Params 7, eflags: 0x0
// Checksum 0xbd966267, Offset: 0x1d28
// Size: 0xda
function function_752d4412(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        self function_88a10e85(localclientnum, "suspect_trail_feet_left", "player/fx_plyr_ghost_trail_feet_nworld", "J_Ball_LE");
        self function_88a10e85(localclientnum, "suspect_trail_feet_right", "player/fx_plyr_ghost_trail_feet_nworld", "J_Ball_RI");
        return;
    }
    self function_be968491(localclientnum, "suspect_trail_feet_left", "player/fx_plyr_ghost_trail_feet_nworld");
    self function_be968491(localclientnum, "suspect_trail_feet_right", "player/fx_plyr_ghost_trail_feet_nworld");
}

// Namespace namespace_ce0e5f06
// Params 7, eflags: 0x0
// Checksum 0x7522d5c3, Offset: 0x1e10
// Size: 0x92
function function_ec9960ef(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        self function_88a10e85(localclientnum, "wasp_hack", "vehicle/fx_light_wasp_friendly_hacked", "tag_origin");
        return;
    }
    self function_be968491(localclientnum, "wasp_hack", "vehicle/fx_light_wasp_friendly_hacked");
}

// Namespace namespace_ce0e5f06
// Params 7, eflags: 0x0
// Checksum 0xa23d02ec, Offset: 0x1eb0
// Size: 0x92
function function_258012a1(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        self function_88a10e85(localclientnum, "truck_explosion", "explosions/fx_exp_truck_slomo_nworld", "tag_fx_front");
        return;
    }
    self function_be968491(localclientnum, "truck_explosion", "explosions/fx_exp_truck_slomo_nworld");
}

// Namespace namespace_ce0e5f06
// Params 7, eflags: 0x0
// Checksum 0xce99bbf8, Offset: 0x1f50
// Size: 0x5a
function function_aad321ae(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        playfx(localclientnum, "explosions/fx_exp_emp_lg_nworld", self.origin);
    }
}

// Namespace namespace_ce0e5f06
// Params 7, eflags: 0x0
// Checksum 0x6bbb26df, Offset: 0x1fb8
// Size: 0x112
function function_73c10276(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        self.mdl_tag = util::spawn_model(localclientnum, "tag_origin", self.origin, self.angles);
        self.mdl_tag linkto(self);
        self.var_c604c399 = addboltedfxexclusionvolume(localclientnum, self.mdl_tag, "tag_origin", (1300 / 2, 450 / 2, 500 / 2));
        return;
    }
    if (isdefined(self.var_c604c399)) {
        removefxexclusionvolume(localclientnum, self.var_c604c399);
        self.mdl_tag delete();
    }
}

// Namespace namespace_ce0e5f06
// Params 7, eflags: 0x0
// Checksum 0xdfc780d9, Offset: 0x20d8
// Size: 0x28b
function function_4f8cc662(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval == 1) {
        var_c828a8ed = struct::get("train_main_occluder", "targetname");
        var_c828a8ed.var_44fe3058 = util::spawn_model(localclientnum, "tag_origin", var_c828a8ed.origin, var_c828a8ed.angles);
        var_c828a8ed.var_c604c399 = addboltedfxexclusionvolume(localclientnum, var_c828a8ed.var_44fe3058, "tag_origin", (10240 / 2, 400 / 2, 288 / 2));
        var_30cb37a9 = struct::get("train_end_occluder", "targetname");
        var_30cb37a9.var_44fe3058 = util::spawn_model(localclientnum, "tag_origin", var_30cb37a9.origin, var_30cb37a9.angles);
        var_30cb37a9.var_c604c399 = addboltedfxexclusionvolume(localclientnum, var_30cb37a9.var_44fe3058, "tag_origin", (2928 / 2, 400 / 2, 288 / 2));
        var_5987da1 = struct::get_array("train_double_decker_occluder", "targetname");
        foreach (s_org in var_5987da1) {
            s_org.var_44fe3058 = util::spawn_model(localclientnum, "tag_origin", s_org.origin, s_org.angles);
            s_org.var_c604c399 = addboltedfxexclusionvolume(localclientnum, s_org.var_44fe3058, "tag_origin", (1300 / 2, 600 / 2, 680 / 2));
        }
    }
}

// Namespace namespace_ce0e5f06
// Params 7, eflags: 0x0
// Checksum 0x2b0cfbd, Offset: 0x2370
// Size: 0x8a
function function_ce461171(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        self.smoke_fx = playfxontag(localclientnum, "explosions/fx_exp_grenade_smoke_nworld", self, "tag_origin");
        return;
    }
    if (isdefined(self.smoke_fx)) {
        stopfx(localclientnum, self.smoke_fx);
    }
}

// Namespace namespace_ce0e5f06
// Params 7, eflags: 0x0
// Checksum 0xbc46301e, Offset: 0x2408
// Size: 0xd2
function function_1e4e8925(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        e_origin = util::spawn_model(localclientnum, "tag_origin", self.origin);
        e_origin util::delay(30, undefined, &delete);
        e_origin function_88a10e85(localclientnum, "frag_grenade", "explosions/fx_exp_grenade_default", "tag_origin");
        return;
    }
    self function_be968491(localclientnum, "frag_grenade", "explosions/fx_exp_grenade_default");
}

// Namespace namespace_ce0e5f06
// Params 7, eflags: 0x0
// Checksum 0x2fb00f5e, Offset: 0x24e8
// Size: 0xd2
function function_c8c87ed0(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        e_origin = util::spawn_model(localclientnum, "tag_origin", self.origin);
        e_origin util::delay(5, undefined, &delete);
        e_origin function_88a10e85(localclientnum, "wall_break", "destruct/fx_dest_wall_nworld", "tag_origin");
        return;
    }
    self function_be968491(localclientnum, "wall_break", "destruct/fx_dest_wall_nworld");
}

// Namespace namespace_ce0e5f06
// Params 7, eflags: 0x0
// Checksum 0xab225996, Offset: 0x25c8
// Size: 0x92
function function_8d759480(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        self function_88a10e85(localclientnum, "train_explosion", "explosions/fx_exp_train_car_nworld", "fx_01_jnt");
        return;
    }
    self function_be968491(localclientnum, "train_explosion", "explosions/fx_exp_train_car_nworld");
}

// Namespace namespace_ce0e5f06
// Params 7, eflags: 0x0
// Checksum 0xa5b36386, Offset: 0x2668
// Size: 0x92
function function_ddee6a4e(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        self function_88a10e85(localclientnum, "emp_vehicles", "electric/fx_elec_emp_machines_nworld", "tag_origin");
        return;
    }
    self function_be968491(localclientnum, "emp_vehicles", "electric/fx_elec_emp_machines_nworld");
}

// Namespace namespace_ce0e5f06
// Params 7, eflags: 0x0
// Checksum 0x5e3e0aa3, Offset: 0x2708
// Size: 0x5f
function function_b45c2459(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        self thread function_dd551c54(localclientnum);
        return;
    }
    self notify(#"hash_2608c3ca");
}

// Namespace namespace_ce0e5f06
// Params 1, eflags: 0x0
// Checksum 0xada95b6, Offset: 0x2770
// Size: 0x16d
function function_dd551c54(localclientnum) {
    self endon(#"death");
    self endon(#"entityshutdown");
    self endon(#"hash_2608c3ca");
    while (true) {
        var_ffb35e3f = randomfloatrange(2, 7.5);
        wait(var_ffb35e3f);
        var_725460af = randomint(5) + 1;
        v_source = self.origin;
        switch (var_725460af) {
        case 1:
            self thread function_bfff202d(localclientnum, 4);
            break;
        case 2:
            self thread function_bfff202d(localclientnum, 3.5);
            break;
        case 3:
            self thread function_bfff202d(localclientnum, 3);
            break;
        case 4:
            self thread function_bfff202d(localclientnum, 2.5);
            break;
        case 5:
            self thread function_bfff202d(localclientnum, 2);
            break;
        default:
            break;
        }
    }
}

// Namespace namespace_ce0e5f06
// Params 2, eflags: 0x0
// Checksum 0x15a3e727, Offset: 0x28e8
// Size: 0x9d
function function_bfff202d(localclientnum, n_duration) {
    self endon(#"death");
    self endon(#"entityshutdown");
    self endon(#"hash_2608c3ca");
    if (isdefined(n_duration)) {
        __s = spawnstruct();
        __s endon(#"timeout");
        __s util::delay_notify(n_duration, "timeout");
    }
    while (true) {
        self playrumbleonentity(localclientnum, "cp_newworld_rumble_train_roof_loop");
        wait(0.185);
    }
}

// Namespace namespace_ce0e5f06
// Params 3, eflags: 0x0
// Checksum 0xcadc5487, Offset: 0x2990
// Size: 0xc0
function function_be968491(localclientnum, str_type, str_fx) {
    if (!isdefined(self.var_62bb476b)) {
        self.var_62bb476b = [];
    }
    if (!isdefined(self.var_62bb476b[localclientnum])) {
        self.var_62bb476b[localclientnum] = [];
    }
    if (!isdefined(self.var_62bb476b[localclientnum][str_type])) {
        self.var_62bb476b[localclientnum][str_type] = [];
    }
    if (isdefined(str_fx) && isdefined(self.var_62bb476b[localclientnum][str_type][str_fx])) {
        n_fx_id = self.var_62bb476b[localclientnum][str_type][str_fx];
        deletefx(localclientnum, n_fx_id, 0);
        self.var_62bb476b[localclientnum][str_type][str_fx] = undefined;
    }
}

// Namespace namespace_ce0e5f06
// Params 3, eflags: 0x0
// Checksum 0x9d96d5de, Offset: 0x2a58
// Size: 0xcb
function function_400e6e82(localclientnum, str_type, var_91599cfb) {
    if (!isdefined(var_91599cfb)) {
        var_91599cfb = 1;
    }
    if (isdefined(self.var_62bb476b) && isdefined(self.var_62bb476b[localclientnum]) && isdefined(self.var_62bb476b[localclientnum][str_type])) {
        a_keys = getarraykeys(self.var_62bb476b[localclientnum][str_type]);
        for (i = 0; i < a_keys.size; i++) {
            deletefx(localclientnum, self.var_62bb476b[localclientnum][str_type][a_keys[i]], var_91599cfb);
            self.var_62bb476b[localclientnum][str_type][a_keys[i]] = undefined;
        }
    }
}

// Namespace namespace_ce0e5f06
// Params 6, eflags: 0x0
// Checksum 0xb5030377, Offset: 0x2b30
// Size: 0xdd
function function_88a10e85(localclientnum, str_type, str_fx, str_tag, var_cffd17f8, var_ff19846d) {
    if (!isdefined(str_tag)) {
        str_tag = "tag_origin";
    }
    if (!isdefined(var_cffd17f8)) {
        var_cffd17f8 = 1;
    }
    if (!isdefined(var_ff19846d)) {
        var_ff19846d = 0;
    }
    self function_be968491(localclientnum, str_type, str_fx);
    if (var_cffd17f8) {
        self function_400e6e82(localclientnum, str_type, 0);
    }
    n_fx_id = playfxontag(localclientnum, str_fx, self, str_tag);
    if (var_ff19846d == 1) {
        setfxignorepause(localclientnum, n_fx_id, var_ff19846d);
    }
    self.var_62bb476b[localclientnum][str_type][str_fx] = n_fx_id;
}

// Namespace namespace_ce0e5f06
// Params 8, eflags: 0x0
// Checksum 0x97dbfd1f, Offset: 0x2c18
// Size: 0x11d
function function_ea0e7704(localclientnum, str_type, str_fx, var_cffd17f8, v_pos, v_forward, v_up, var_ff19846d) {
    if (!isdefined(var_cffd17f8)) {
        var_cffd17f8 = 1;
    }
    if (!isdefined(var_ff19846d)) {
        var_ff19846d = 0;
    }
    self function_be968491(localclientnum, str_type, str_fx);
    if (var_cffd17f8) {
        self function_400e6e82(localclientnum, str_type, 0);
    }
    if (isdefined(v_forward) && isdefined(v_up)) {
        n_fx_id = playfx(localclientnum, str_fx, v_pos, v_forward, v_up);
    } else if (isdefined(v_forward)) {
        n_fx_id = playfx(localclientnum, str_fx, v_pos, v_forward);
    } else {
        n_fx_id = playfx(localclientnum, str_fx, v_pos);
    }
    setfxignorepause(localclientnum, n_fx_id, var_ff19846d);
    self.var_62bb476b[localclientnum][str_type][str_fx] = n_fx_id;
}

// Namespace namespace_ce0e5f06
// Params 7, eflags: 0x0
// Checksum 0x2bc277a7, Offset: 0x2d40
// Size: 0x5a
function function_baae4949(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval == 1) {
        self postfx::playpostfxbundle("pstfx_dni_screen_futz");
    }
}

// Namespace namespace_ce0e5f06
// Params 7, eflags: 0x0
// Checksum 0x7aa69d61, Offset: 0x2da8
// Size: 0x19a
function function_1e2a542f(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    var_17287685 = getent(localclientnum, "wt_fan_01", "targetname");
    var_3d2af0ee = getent(localclientnum, "wt_fan_02", "targetname");
    var_632d6b57 = getent(localclientnum, "wt_fan_03", "targetname");
    var_591c1278 = getent(localclientnum, "wt_fan_04", "targetname");
    if (newval != oldval && newval == 1) {
        var_17287685 thread function_65012f08();
        wait(0.1);
        var_3d2af0ee thread function_65012f08();
        wait(0.1);
        var_632d6b57 thread function_65012f08();
        wait(0.1);
        var_591c1278 thread function_65012f08();
    }
    if (newval == 0) {
        level notify(#"hash_c78324b7");
        var_17287685 delete();
        var_3d2af0ee delete();
        var_632d6b57 delete();
        var_591c1278 delete();
    }
}

// Namespace namespace_ce0e5f06
// Params 0, eflags: 0x0
// Checksum 0x4e51152b, Offset: 0x2f50
// Size: 0x3f
function function_65012f08() {
    self endon(#"hash_c78324b7");
    rotate_time = 3;
    while (true) {
        self rotateyaw(-76, rotate_time);
        self waittill(#"rotatedone");
    }
}

