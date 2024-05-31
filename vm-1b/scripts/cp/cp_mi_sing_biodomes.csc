#using scripts/cp/cp_mi_sing_biodomes_sound;
#using scripts/cp/cp_mi_sing_biodomes_fx;
#using scripts/shared/postfx_shared;
#using scripts/cp/_util;
#using scripts/cp/_squad_control;
#using scripts/cp/_load;
#using scripts/shared/util_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/clientfield_shared;
#using scripts/codescripts/struct;

#namespace namespace_55d2f1be;

// Namespace namespace_55d2f1be
// Params 0, eflags: 0x0
// namespace_55d2f1be<file_0>::function_d290ebfa
// Checksum 0xa7bc4561, Offset: 0x718
// Size: 0x72
function main() {
    function_b37230e4();
    util::function_57b966c8(&function_71f88fc, 2);
    namespace_7042442b::main();
    namespace_a46315e2::main();
    load::main();
    util::waitforclient(0);
}

// Namespace namespace_55d2f1be
// Params 0, eflags: 0x0
// namespace_55d2f1be<file_0>::function_b37230e4
// Checksum 0xe4d35d24, Offset: 0x798
// Size: 0x382
function function_b37230e4() {
    clientfield::register("toplayer", "player_dust_fx", 1, 1, "int", &function_b33fd8cd, 0, 0);
    clientfield::register("toplayer", "player_waterfall_pstfx", 1, 1, "int", &function_cf78dbd9, 0, 0);
    clientfield::register("toplayer", "bullet_disconnect_pstfx", 1, 1, "int", &function_89d42240, 0, 0);
    clientfield::register("toplayer", "zipline_speed_blur", 1, 1, "int", &function_424e31ac, 0, 0);
    clientfield::register("scriptmover", "waiter_blood_shader", 1, 1, "int", &function_81199318, 0, 0);
    clientfield::register("world", "set_exposure_bank", 1, 1, "int", &function_1e832062, 0, 0);
    clientfield::register("world", "party_house_shutter", 1, 1, "int", &function_e49f0db0, 0, 0);
    clientfield::register("world", "party_house_destruction", 1, 1, "int", &function_f3caffbf, 0, 0);
    clientfield::register("world", "dome_glass_break", 1, 1, "int", &function_f386de49, 0, 0);
    clientfield::register("world", "warehouse_window_break", 1, 1, "int", &function_c42f328d, 0, 0);
    clientfield::register("world", "control_room_window_break", 1, 1, "int", &function_b84be585, 0, 0);
    clientfield::register("toplayer", "server_extra_cam", 1, 5, "int", &function_aee2517f, 0, 0);
    clientfield::register("toplayer", "server_interact_cam", 1, 3, "int", &function_7c68b681, 0, 0);
    clientfield::register("world", "cloud_mountain_crows", 1, 2, "int", &function_76ca6777, 0, 0);
    clientfield::register("world", "fighttothedome_exfil_rope", 1, 2, "int", &function_32baa33e, 0, 0);
    clientfield::register("world", "fighttothedome_exfil_rope_sim_player", 1, 1, "int", &function_d550bd06, 0, 0);
}

// Namespace namespace_55d2f1be
// Params 7, eflags: 0x0
// namespace_55d2f1be<file_0>::function_ab86121d
// Checksum 0xf3d1a4e6, Offset: 0xb28
// Size: 0xf5
function function_ab86121d(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    switch (newval) {
    case 2:
        self thread postfx::playpostfxbundle("pstfx_vehicle_takeover_fade_in");
        playsound(0, "gdt_securitybreach_transition_in", (0, 0, 0));
        break;
    case 3:
        self thread postfx::playpostfxbundle("pstfx_vehicle_takeover_fade_out");
        playsound(0, "gdt_securitybreach_transition_out", (0, 0, 0));
        break;
    case 1:
        self thread postfx::stoppostfxbundle();
        break;
    case 4:
        self thread postfx::playpostfxbundle("pstfx_vehicle_takeover_white");
        break;
    }
}

// Namespace namespace_55d2f1be
// Params 7, eflags: 0x0
// namespace_55d2f1be<file_0>::function_cf78dbd9
// Checksum 0xbbeb9009, Offset: 0xc28
// Size: 0x3a
function function_cf78dbd9(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    
}

// Namespace namespace_55d2f1be
// Params 7, eflags: 0x0
// namespace_55d2f1be<file_0>::function_89d42240
// Checksum 0xef7f4d7f, Offset: 0xca0
// Size: 0x62
function function_89d42240(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        self thread postfx::playpostfxbundle("pstfx_dni_screen_futz");
        return;
    }
    self thread postfx::stoppostfxbundle();
}

// Namespace namespace_55d2f1be
// Params 7, eflags: 0x0
// namespace_55d2f1be<file_0>::function_424e31ac
// Checksum 0x260aa675, Offset: 0xd10
// Size: 0x82
function function_424e31ac(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        enablespeedblur(localclientnum, 0.07, 0.55, 0.9, 0, 100, 100);
        return;
    }
    disablespeedblur(localclientnum);
}

// Namespace namespace_55d2f1be
// Params 7, eflags: 0x0
// namespace_55d2f1be<file_0>::function_81199318
// Checksum 0x6776310f, Offset: 0xda0
// Size: 0xed
function function_81199318(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self endon(#"entityshutdown");
    n_start_time = gettime();
    b_is_updating = 1;
    while (b_is_updating) {
        n_time = gettime();
        var_348e23ad = (n_time - n_start_time) / 1000;
        if (var_348e23ad >= 4) {
            var_348e23ad = 4;
            b_is_updating = 0;
        }
        var_cba49b4e = 0.9 * var_348e23ad / 4;
        self mapshaderconstant(0, 0, "scriptVector0", var_cba49b4e, 0, 0);
        wait(0.01);
    }
}

// Namespace namespace_55d2f1be
// Params 7, eflags: 0x0
// namespace_55d2f1be<file_0>::function_e49f0db0
// Checksum 0xc36c517, Offset: 0xe98
// Size: 0x52
function function_e49f0db0(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        level thread scene::play("p7_fxanim_cp_biodomes_roll_up_door_bundle");
    }
}

// Namespace namespace_55d2f1be
// Params 7, eflags: 0x0
// namespace_55d2f1be<file_0>::function_f3caffbf
// Checksum 0xfb62372e, Offset: 0xef8
// Size: 0x82
function function_f3caffbf(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        level thread scene::play("p7_fxanim_cp_biodomes_party_house_bundle");
        level thread scene::play("p7_fxanim_gp_lantern_paper_04_red_single_bundle");
        level thread scene::play("p7_fxanim_gp_lantern_paper_03_red_single_bundle");
    }
}

// Namespace namespace_55d2f1be
// Params 7, eflags: 0x0
// namespace_55d2f1be<file_0>::function_f386de49
// Checksum 0xaab1b3d1, Offset: 0xf88
// Size: 0x52
function function_f386de49(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        level thread scene::play("p7_fxanim_cp_biodomes_rpg_dome_glass_bundle");
    }
}

// Namespace namespace_55d2f1be
// Params 7, eflags: 0x0
// namespace_55d2f1be<file_0>::function_c42f328d
// Checksum 0x7ad97cee, Offset: 0xfe8
// Size: 0x52
function function_c42f328d(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        level thread scene::play("p7_fxanim_cp_biodomes_warehouse_glass_break_bundle");
    }
}

// Namespace namespace_55d2f1be
// Params 7, eflags: 0x0
// namespace_55d2f1be<file_0>::function_b84be585
// Checksum 0xe392f66d, Offset: 0x1048
// Size: 0x52
function function_b84be585(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        level thread scene::play("p7_fxanim_cp_biodomes_server_room_window_break_02_bundle");
    }
}

// Namespace namespace_55d2f1be
// Params 7, eflags: 0x0
// namespace_55d2f1be<file_0>::function_76ca6777
// Checksum 0xd10ee639, Offset: 0x10a8
// Size: 0x7a
function function_76ca6777(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval == 1) {
        level thread scene::init("p7_fxanim_cp_biodomes_crow_takeoff_bundle");
        return;
    }
    if (newval == 2) {
        level thread scene::play("p7_fxanim_cp_biodomes_crow_takeoff_bundle");
    }
}

// Namespace namespace_55d2f1be
// Params 7, eflags: 0x0
// namespace_55d2f1be<file_0>::function_32baa33e
// Checksum 0xf294436e, Offset: 0x1130
// Size: 0xfa
function function_32baa33e(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval == 1) {
        scene::add_scene_func("p7_fxanim_cp_biodomes_rope_sim_player_bundle", &function_1f0ba50, "init");
        level thread scene::init("p7_fxanim_cp_biodomes_rope_drop_player_bundle");
        level thread scene::init("p7_fxanim_cp_biodomes_rope_sim_player_bundle");
        wait(1);
        level thread scene::play("p7_fxanim_cp_biodomes_rope_drop_hendricks_bundle");
        return;
    }
    if (newval == 2) {
        level thread scene::stop("p7_fxanim_cp_biodomes_rope_drop_hendricks_bundle", 1);
        level thread scene::play("p7_fxanim_cp_biodomes_rope_drop_player_bundle");
    }
}

// Namespace namespace_55d2f1be
// Params 1, eflags: 0x0
// namespace_55d2f1be<file_0>::function_1f0ba50
// Checksum 0x442de2c3, Offset: 0x1238
// Size: 0x22
function function_1f0ba50(a_ents) {
    a_ents["rope_sim_player"] hide();
}

// Namespace namespace_55d2f1be
// Params 7, eflags: 0x0
// namespace_55d2f1be<file_0>::function_d550bd06
// Checksum 0x92ba01e0, Offset: 0x1268
// Size: 0x82
function function_d550bd06(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        scene::add_scene_func("p7_fxanim_cp_biodomes_rope_sim_player_bundle", &function_be7ae167, "play");
        level thread scene::play("p7_fxanim_cp_biodomes_rope_sim_player_bundle");
    }
}

// Namespace namespace_55d2f1be
// Params 1, eflags: 0x0
// namespace_55d2f1be<file_0>::function_be7ae167
// Checksum 0x5107607, Offset: 0x12f8
// Size: 0x22
function function_be7ae167(a_ents) {
    a_ents["rope_sim_player"] show();
}

// Namespace namespace_55d2f1be
// Params 7, eflags: 0x0
// namespace_55d2f1be<file_0>::function_aee2517f
// Checksum 0xd70ac3be, Offset: 0x1328
// Size: 0x1c5
function function_aee2517f(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    var_ebb945a1 = getent(localclientnum, "server_camera1", "targetname");
    var_11bbc00a = getent(localclientnum, "server_camera2", "targetname");
    var_37be3a73 = getent(localclientnum, "server_camera3", "targetname");
    var_5dc0b4dc = getent(localclientnum, "server_camera4", "targetname");
    switch (newval) {
    case 0:
        break;
    case 1:
        var_11bbc00a setextracam(0);
        break;
    case 2:
        var_ebb945a1 setextracam(0);
        break;
    case 3:
        var_37be3a73 setextracam(0);
        var_37be3a73 rotateyaw(35, 2);
        break;
    case 4:
        var_5dc0b4dc setextracam(0);
        break;
    case 5:
        var_37be3a73 setextracam(0);
        var_37be3a73 rotateyaw(-35, 2);
        break;
    }
}

// Namespace namespace_55d2f1be
// Params 7, eflags: 0x0
// namespace_55d2f1be<file_0>::function_7c68b681
// Checksum 0xc0791b81, Offset: 0x14f8
// Size: 0x5a
function function_7c68b681(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    
}

// Namespace namespace_55d2f1be
// Params 1, eflags: 0x0
// namespace_55d2f1be<file_0>::function_71f88fc
// Checksum 0x3affbf18, Offset: 0x1690
// Size: 0xd5
function function_71f88fc(n_zone) {
    switch (n_zone) {
    case 1:
        streamtexturelist("cp_mi_sing_biodomes");
        forcestreambundle("cin_bio_01_01_party_1st_drinks");
        forcestreambundle("cin_bio_01_01_party_1st_drinks_part2");
        forcestreambundle("p7_fxanim_cp_biodomes_party_house_drinks_bundle");
        forcestreambundle("p7_fxanim_cp_biodomes_roll_up_door_bundle");
        break;
    case 2:
        forcestreamxmodel("c_54i_supp_body");
        forcestreamxmodel("c_54i_supp_head1");
        break;
    }
}

// Namespace namespace_55d2f1be
// Params 7, eflags: 0x0
// namespace_55d2f1be<file_0>::function_1e832062
// Checksum 0xb2788ef2, Offset: 0x1770
// Size: 0x6a
function function_1e832062(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        setexposureactivebank(localclientnum, 4);
        return;
    }
    setexposureactivebank(localclientnum, 1);
}

// Namespace namespace_55d2f1be
// Params 7, eflags: 0x0
// namespace_55d2f1be<file_0>::function_b33fd8cd
// Checksum 0xa6307e46, Offset: 0x17e8
// Size: 0xba
function function_b33fd8cd(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval == 1) {
        if (isdefined(self.n_fx_id)) {
            deletefx(localclientnum, self.n_fx_id, 1);
        }
        self.n_fx_id = playfxoncamera(localclientnum, level._effect["player_dust"], (0, 0, 0), (1, 0, 0), (0, 0, 1));
        return;
    }
    if (isdefined(self.n_fx_id)) {
        deletefx(localclientnum, self.n_fx_id, 1);
    }
}

