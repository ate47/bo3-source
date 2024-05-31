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
// namespace_ce0e5f06<file_0>::function_2dc19561
// Checksum 0x59a4e969, Offset: 0xab8
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("newworld_util", &__init__, undefined, undefined);
}

// Namespace namespace_ce0e5f06
// Params 0, eflags: 0x1 linked
// namespace_ce0e5f06<file_0>::function_8c87d8eb
// Checksum 0xa023dc9e, Offset: 0xaf8
// Size: 0x14
function __init__() {
    init_clientfields();
}

// Namespace namespace_ce0e5f06
// Params 0, eflags: 0x1 linked
// namespace_ce0e5f06<file_0>::function_2ea898a8
// Checksum 0x81f7022e, Offset: 0xb18
// Size: 0x6c4
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
// Params 7, eflags: 0x1 linked
// namespace_ce0e5f06<file_0>::function_ecc75bea
// Checksum 0xe16631c4, Offset: 0x11e8
// Size: 0x22c
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
// Params 7, eflags: 0x1 linked
// namespace_ce0e5f06<file_0>::function_e416b7db
// Checksum 0x73adecd7, Offset: 0x1420
// Size: 0x154
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
        player function_5677f0fa(localclientnum);
        return;
    }
    player notify(#"hash_860e4d9e");
    player function_97cc38a5(localclientnum);
}

// Namespace namespace_ce0e5f06
// Params 1, eflags: 0x1 linked
// namespace_ce0e5f06<file_0>::function_5677f0fa
// Checksum 0x8deaa341, Offset: 0x1580
// Size: 0x104
function function_5677f0fa(localclientnum) {
    if (!isdefined(level.var_3383b379)) {
        level.var_3383b379 = [];
    }
    self function_97cc38a5();
    n_index = self getentitynumber();
    level.var_3383b379[n_index] = util::spawn_model(localclientnum, "tag_origin", self.origin);
    level.var_3383b379[n_index] linkto(self);
    level.var_3383b379[n_index] thread function_7683b584(self);
    playfxontag(localclientnum, "weather/fx_snow_player_os_nworld", level.var_3383b379[n_index], "tag_origin");
}

// Namespace namespace_ce0e5f06
// Params 1, eflags: 0x1 linked
// namespace_ce0e5f06<file_0>::function_97cc38a5
// Checksum 0xc569feca, Offset: 0x1690
// Size: 0x7c
function function_97cc38a5(localclientnum) {
    if (!isdefined(level.var_3383b379)) {
        level.var_3383b379 = [];
    }
    n_index = self getentitynumber();
    if (isdefined(level.var_3383b379[n_index])) {
        level.var_3383b379[n_index] delete();
    }
}

// Namespace namespace_ce0e5f06
// Params 1, eflags: 0x1 linked
// namespace_ce0e5f06<file_0>::function_7683b584
// Checksum 0xb96b40c1, Offset: 0x1718
// Size: 0x3c
function function_7683b584(player) {
    self endon(#"death");
    player waittill(#"death");
    self delete();
}

// Namespace namespace_ce0e5f06
// Params 2, eflags: 0x1 linked
// namespace_ce0e5f06<file_0>::function_120f324e
// Checksum 0x9a4d43db, Offset: 0x1760
// Size: 0x7e
function function_120f324e(localclientnum, n_delay) {
    self notify(#"hash_860e4d9e");
    self endon(#"hash_860e4d9e");
    self function_97cc38a5(localclientnum);
    while (isdefined(self)) {
        playfxontag(localclientnum, "weather/fx_snow_player_slow_os_nworld", self, "none");
        wait(n_delay);
    }
}

// Namespace namespace_ce0e5f06
// Params 1, eflags: 0x1 linked
// namespace_ce0e5f06<file_0>::function_ff1b6796
// Checksum 0x59eb7a43, Offset: 0x17e8
// Size: 0x174
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
// Params 1, eflags: 0x1 linked
// namespace_ce0e5f06<file_0>::function_52bc98a1
// Checksum 0xcb47f400, Offset: 0x1968
// Size: 0x3c
function function_52bc98a1(localclientnum) {
    self function_88a10e85(localclientnum, "robot_snow_impact", "snow/fx_snow_train_robot_fall_impact", "tag_origin", 0);
}

// Namespace namespace_ce0e5f06
// Params 7, eflags: 0x1 linked
// namespace_ce0e5f06<file_0>::function_aebc5072
// Checksum 0xeb46ee82, Offset: 0x19b0
// Size: 0x9c
function function_aebc5072(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        self function_88a10e85(localclientnum, "objective_light", "player/fx_ai_dni_rez_in_hero_clean");
        return;
    }
    self function_be968491(localclientnum, "objective_light", "player/fx_ai_dni_rez_in_hero_clean");
}

// Namespace namespace_ce0e5f06
// Params 7, eflags: 0x1 linked
// namespace_ce0e5f06<file_0>::function_9b9abce4
// Checksum 0x6b3188c9, Offset: 0x1a58
// Size: 0x21c
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
// Params 7, eflags: 0x1 linked
// namespace_ce0e5f06<file_0>::function_be66c05b
// Checksum 0x9ad1fef8, Offset: 0x1c80
// Size: 0x21c
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
// Params 2, eflags: 0x1 linked
// namespace_ce0e5f06<file_0>::function_1c2b3dda
// Checksum 0xa348106b, Offset: 0x1ea8
// Size: 0x1ac
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
// Params 3, eflags: 0x1 linked
// namespace_ce0e5f06<file_0>::function_bd23b431
// Checksum 0x82f1185, Offset: 0x2060
// Size: 0x64
function function_bd23b431(localclientnum, str_fx, str_tag) {
    n_fx_id = playfxontag(localclientnum, str_fx, self, str_tag);
    setfxignorepause(localclientnum, n_fx_id, 1);
}

// Namespace namespace_ce0e5f06
// Params 7, eflags: 0x1 linked
// namespace_ce0e5f06<file_0>::function_6e7d0ca2
// Checksum 0x785e78cf, Offset: 0x20d0
// Size: 0x154
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
// Params 7, eflags: 0x1 linked
// namespace_ce0e5f06<file_0>::function_752d4412
// Checksum 0x88a3f08c, Offset: 0x2230
// Size: 0xfc
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
// Params 7, eflags: 0x1 linked
// namespace_ce0e5f06<file_0>::function_ec9960ef
// Checksum 0x765789d3, Offset: 0x2338
// Size: 0xa4
function function_ec9960ef(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        self function_88a10e85(localclientnum, "wasp_hack", "vehicle/fx_light_wasp_friendly_hacked", "tag_origin");
        return;
    }
    self function_be968491(localclientnum, "wasp_hack", "vehicle/fx_light_wasp_friendly_hacked");
}

// Namespace namespace_ce0e5f06
// Params 7, eflags: 0x1 linked
// namespace_ce0e5f06<file_0>::function_258012a1
// Checksum 0x79664504, Offset: 0x23e8
// Size: 0xa4
function function_258012a1(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        self function_88a10e85(localclientnum, "truck_explosion", "explosions/fx_exp_truck_slomo_nworld", "tag_fx_front");
        return;
    }
    self function_be968491(localclientnum, "truck_explosion", "explosions/fx_exp_truck_slomo_nworld");
}

// Namespace namespace_ce0e5f06
// Params 7, eflags: 0x1 linked
// namespace_ce0e5f06<file_0>::function_aad321ae
// Checksum 0xb0664ec4, Offset: 0x2498
// Size: 0x6c
function function_aad321ae(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        playfx(localclientnum, "explosions/fx_exp_emp_lg_nworld", self.origin);
    }
}

// Namespace namespace_ce0e5f06
// Params 7, eflags: 0x1 linked
// namespace_ce0e5f06<file_0>::function_73c10276
// Checksum 0xeb5a050d, Offset: 0x2510
// Size: 0x144
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
// Params 7, eflags: 0x1 linked
// namespace_ce0e5f06<file_0>::function_4f8cc662
// Checksum 0x4d5adb07, Offset: 0x2660
// Size: 0x356
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
// Params 7, eflags: 0x1 linked
// namespace_ce0e5f06<file_0>::function_ce461171
// Checksum 0x486a1cca, Offset: 0x29c0
// Size: 0xa4
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
// Params 7, eflags: 0x1 linked
// namespace_ce0e5f06<file_0>::function_1e4e8925
// Checksum 0x60a791f0, Offset: 0x2a70
// Size: 0x104
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
// Params 7, eflags: 0x1 linked
// namespace_ce0e5f06<file_0>::function_c8c87ed0
// Checksum 0x40daf0a6, Offset: 0x2b80
// Size: 0x104
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
// Params 7, eflags: 0x1 linked
// namespace_ce0e5f06<file_0>::function_8d759480
// Checksum 0x1d2d79ca, Offset: 0x2c90
// Size: 0xa4
function function_8d759480(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        self function_88a10e85(localclientnum, "train_explosion", "explosions/fx_exp_train_car_nworld", "fx_01_jnt");
        return;
    }
    self function_be968491(localclientnum, "train_explosion", "explosions/fx_exp_train_car_nworld");
}

// Namespace namespace_ce0e5f06
// Params 7, eflags: 0x1 linked
// namespace_ce0e5f06<file_0>::function_ddee6a4e
// Checksum 0xaafd7786, Offset: 0x2d40
// Size: 0xa4
function function_ddee6a4e(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        self function_88a10e85(localclientnum, "emp_vehicles", "electric/fx_elec_emp_machines_nworld", "tag_origin");
        return;
    }
    self function_be968491(localclientnum, "emp_vehicles", "electric/fx_elec_emp_machines_nworld");
}

// Namespace namespace_ce0e5f06
// Params 7, eflags: 0x1 linked
// namespace_ce0e5f06<file_0>::function_b45c2459
// Checksum 0x33eff85, Offset: 0x2df0
// Size: 0x6e
function function_b45c2459(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        self thread function_dd551c54(localclientnum);
        return;
    }
    self notify(#"hash_2608c3ca");
}

// Namespace namespace_ce0e5f06
// Params 1, eflags: 0x1 linked
// namespace_ce0e5f06<file_0>::function_dd551c54
// Checksum 0xdcf3d5b, Offset: 0x2e68
// Size: 0x1ae
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
// Params 2, eflags: 0x1 linked
// namespace_ce0e5f06<file_0>::function_bfff202d
// Checksum 0xe95c8d6d, Offset: 0x3020
// Size: 0xc0
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
// Params 3, eflags: 0x1 linked
// namespace_ce0e5f06<file_0>::function_be968491
// Checksum 0x6ec9dee, Offset: 0x30e8
// Size: 0x10c
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
// Params 3, eflags: 0x1 linked
// namespace_ce0e5f06<file_0>::function_400e6e82
// Checksum 0xa68f8874, Offset: 0x3200
// Size: 0x11e
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
// Params 6, eflags: 0x1 linked
// namespace_ce0e5f06<file_0>::function_88a10e85
// Checksum 0x2f1a9d12, Offset: 0x3328
// Size: 0x132
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
// namespace_ce0e5f06<file_0>::function_ea0e7704
// Checksum 0x1380ebd0, Offset: 0x3468
// Size: 0x192
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
// Params 7, eflags: 0x1 linked
// namespace_ce0e5f06<file_0>::function_baae4949
// Checksum 0x1388bf72, Offset: 0x3608
// Size: 0x64
function function_baae4949(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval == 1) {
        self postfx::playpostfxbundle("pstfx_dni_screen_futz");
    }
}

// Namespace namespace_ce0e5f06
// Params 7, eflags: 0x1 linked
// namespace_ce0e5f06<file_0>::function_1e2a542f
// Checksum 0x1c0bfa76, Offset: 0x3678
// Size: 0x20c
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
// Params 0, eflags: 0x1 linked
// namespace_ce0e5f06<file_0>::function_65012f08
// Checksum 0x97140ecf, Offset: 0x3890
// Size: 0x54
function function_65012f08() {
    self endon(#"hash_c78324b7");
    rotate_time = 3;
    while (true) {
        self rotateyaw(-76, rotate_time);
        self waittill(#"rotatedone");
    }
}

