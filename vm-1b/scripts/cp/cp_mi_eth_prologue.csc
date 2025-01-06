#using scripts/codescripts/struct;
#using scripts/cp/_load;
#using scripts/cp/_oed;
#using scripts/cp/_util;
#using scripts/cp/cp_mi_eth_prologue_fx;
#using scripts/cp/cp_mi_eth_prologue_sound;
#using scripts/shared/clientfield_shared;
#using scripts/shared/duplicaterender_mgr;
#using scripts/shared/exploder_shared;
#using scripts/shared/lui_shared;
#using scripts/shared/math_shared;
#using scripts/shared/postfx_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/util_shared;
#using scripts/shared/visionset_mgr_shared;

#namespace cp_mi_eth_prologue;

// Namespace cp_mi_eth_prologue
// Params 0, eflags: 0x0
// Checksum 0xe1732262, Offset: 0xa50
// Size: 0xca
function main() {
    util::function_57b966c8(&force_streamer, 7);
    function_f45953c();
    function_b37230e4();
    cp_mi_eth_prologue_fx::main();
    cp_mi_eth_prologue_sound::main();
    visionset_mgr::function_3aea3c1a(0, "cp_mi_eth_prologue", 0);
    visionset_mgr::function_3aea3c1a(1, "cp_mi_eth_prologue", 0);
    load::main();
    util::waitforclient(0);
    setdvar("sv_mapswitch", 1);
}

// Namespace cp_mi_eth_prologue
// Params 0, eflags: 0x0
// Checksum 0x2f475024, Offset: 0xb28
// Size: 0x1b
function function_f45953c() {
    level._effect["player_tunnel_dust"] = "dirt/fx_dust_motes_player_loop_lite";
}

// Namespace cp_mi_eth_prologue
// Params 0, eflags: 0x0
// Checksum 0xb5efcdb2, Offset: 0xb50
// Size: 0x532
function function_b37230e4() {
    clientfield::register("world", "tunnel_wall_explode", 1, 1, "int", &tunnel_wall_explode, 0, 0);
    clientfield::register("toplayer", "unlimited_sprint_off", 1, 1, "int", &function_9e6eac31, 0, 0);
    clientfield::register("world", "apc_rail_tower_collapse", 1, 1, "int", &apc_rail_tower_collapse, 1, 0);
    clientfield::register("world", "vtol_missile_explode_trash_fx", 1, 1, "int", &vtol_missile_explode_trash_fx, 1, 0);
    clientfield::register("toplayer", "turn_on_multicam", 1, 3, "int", &function_a014174b, 0, 0);
    clientfield::register("world", "setup_security_cameras", 1, 1, "int", &setup_security_cameras, 0, 0);
    clientfield::register("scriptmover", "update_camera_position", 1, 4, "int", &function_9fd7493, 0, 0);
    clientfield::register("world", "interrogate_physics", 1, 1, "int", &function_a1ad4aa7, 0, 0);
    clientfield::register("toplayer", "set_cam_lookat_object", 1, 4, "int", &set_cam_lookat_object, 0, 0);
    clientfield::register("toplayer", "sndCameraScanner", 1, 3, "int", &sndCameraScanner, 0, 0);
    clientfield::register("world", "blend_in_cleanup", 1, 1, "int", &blend_in_cleanup, 0, 0);
    clientfield::register("world", "fuel_depot_truck_explosion", 1, 1, "int", &fuel_depot_truck_explosion, 0, 0);
    clientfield::register("toplayer", "turn_off_tacmode_vfx", 1, 1, "int", &function_7e8cf38d, 0, 0);
    clientfield::register("toplayer", "dropship_rumble_loop", 1, 1, "int", &function_d376a908, 0, 0);
    clientfield::register("toplayer", "apc_speed_blur", 1, 1, "int", &apc_speed_blur, 0, 0);
    clientfield::register("world", "diaz_break_1", 1, 2, "int", &function_35a91904, 0, 0);
    clientfield::register("world", "diaz_break_2", 1, 2, "int", &function_a7b0883f, 0, 0);
    clientfield::register("toplayer", "player_tunnel_dust_fx_on_off", 1, 1, "int", &cp_mi_eth_prologue_fx::player_tunnel_dust_fx_on_off, 0, 0);
    clientfield::register("toplayer", "player_tunnel_dust_fx", 1, 1, "int", &cp_mi_eth_prologue_fx::function_ba9197c, 0, 0);
    clientfield::register("toplayer", "player_blood_splatter", 1, 1, "int", &cp_mi_eth_prologue_fx::player_blood_splatter, 0, 0);
    clientfield::register("actor", "cyber_soldier_camo", 1, 2, "int", &function_f532bd65, 0, 1);
    duplicate_render::set_dr_filter_framebuffer("active_camo", 90, "actor_camo_on", "", 0, "mc/hud_outline_predator_camo_active_inf", 0);
    duplicate_render::set_dr_filter_framebuffer("active_camo_flicker", 80, "actor_camo_flicker", "", 0, "mc/hud_outline_predator_camo_disruption_inf", 0);
    clientfield::register("world", "toggle_security_camera_pbg_bank", 1, 1, "int", &function_c9395227, 0, 0);
}

// Namespace cp_mi_eth_prologue
// Params 1, eflags: 0x0
// Checksum 0x7acab7a6, Offset: 0x1090
// Size: 0xdd
function force_streamer(n_index) {
    switch (n_index) {
    case 1:
        break;
    case 2:
        forcestreambundle("cin_pro_05_01_securitycam_1st_stealth_kill_closedoor");
        break;
    case 3:
        forcestreambundle("cin_pro_06_03_hostage_vign_breach_playerbreach");
        forcestreamxmodel("p7_door_metal_security_02_rt_keypad");
        break;
    case 4:
        forcestreambundle("cin_pro_06_03_hostage_1st_khalil_intro_player_rescue");
        break;
    case 5:
        forcestreambundle("cin_pro_09_01_intro_1st_cybersoldiers_taylor_attack");
        break;
    case 6:
        forcestreambundle("cin_pro_11_01_jeepalley_vign_engage_start");
        break;
    }
}

// Namespace cp_mi_eth_prologue
// Params 7, eflags: 0x0
// Checksum 0x47332161, Offset: 0x1178
// Size: 0x7a
function function_f532bd65(local_client_num, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self duplicate_render::set_dr_flag("actor_camo_flicker", newval == 2);
    self duplicate_render::set_dr_flag("actor_camo_on", newval != 0);
    self duplicate_render::change_dr_flags(local_client_num);
}

// Namespace cp_mi_eth_prologue
// Params 7, eflags: 0x0
// Checksum 0x492518f0, Offset: 0x1200
// Size: 0x82
function apc_speed_blur(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        enablespeedblur(localclientnum, 0.25, 0.9, 1, 0, 1, 1, 1);
        return;
    }
    disablespeedblur(localclientnum);
}

// Namespace cp_mi_eth_prologue
// Params 7, eflags: 0x0
// Checksum 0x73206c3a, Offset: 0x1290
// Size: 0x7a
function function_d376a908(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval == 1) {
        self playrumblelooponentity(localclientnum, "cp_prologue_rumble_dropship");
        return;
    }
    self stoprumble(localclientnum, "cp_prologue_rumble_dropship");
}

// Namespace cp_mi_eth_prologue
// Params 7, eflags: 0x0
// Checksum 0xc0b8c6df, Offset: 0x1318
// Size: 0x52
function tunnel_wall_explode(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        level thread scene::play("p7_fxanim_cp_prologue_apc_rail_wall_explode_bundle");
    }
}

// Namespace cp_mi_eth_prologue
// Params 7, eflags: 0x0
// Checksum 0x18b4a5d5, Offset: 0x1378
// Size: 0xa2
function function_9e6eac31(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval == 1) {
        setdvar("player_sprintUnlimited", 0);
        setdvar("slide_forceBaseSlide", 1);
        return;
    }
    setdvar("player_sprintUnlimited", 1);
    setdvar("slide_forceBaseSlide", 0);
}

// Namespace cp_mi_eth_prologue
// Params 7, eflags: 0x0
// Checksum 0xef4e4671, Offset: 0x1428
// Size: 0x10a
function function_a014174b(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        setdvar("r_extracam_custom_aspectratio", 2.85);
        var_351745fc = getent(localclientnum, "s_security_cam_hallway", "targetname");
        var_351745fc setextracam(0);
        var_351745fc setextracamfocallength(0, var_351745fc.var_81a24d4e);
        level thread function_5f6dad34(localclientnum, 1);
    }
    level thread function_5f6dad34(localclientnum, 0);
    level.var_3792d454 = 0;
    if (newval) {
        set_cam_lookat_object(localclientnum, oldval, 0, bnewent, binitialsnap, fieldname, bwastimejump);
    }
}

// Namespace cp_mi_eth_prologue
// Params 2, eflags: 0x0
// Checksum 0x999dea57, Offset: 0x1540
// Size: 0x1c2
function function_5f6dad34(localclientnum, b_on) {
    if (!isdefined(level.var_4073afd6)) {
        level.var_4073afd6 = getent(localclientnum, "security_pstfx_screen", "targetname");
    }
    level.var_4073afd6 notify(#"hash_5f6dad34");
    level.var_4073afd6 endon(#"hash_5f6dad34");
    level.var_4073afd6 mapshaderconstant(localclientnum, 0, "ScriptVector0");
    level.var_4073afd6 mapshaderconstant(localclientnum, 1, "ScriptVector1");
    if (b_on) {
        level.var_4073afd6 setshaderconstant(localclientnum, 0, 1, 0, 0, 0);
        while (true) {
            starttime = gettime();
            i = gettime() - starttime;
            while (i < 2000 && isdefined(self)) {
                st = i / 1000;
                if (st <= 1) {
                    level.var_4073afd6 setshaderconstant(localclientnum, 1, 0, 0, st, 0);
                } else if (st > 1) {
                    level.var_4073afd6 setshaderconstant(localclientnum, 1, 0, 0, math::linear_map(2 - st, 0, 1, 0, 1), 0);
                }
                i = gettime() - starttime;
                wait 0.016;
            }
        }
        return;
    }
    level.var_4073afd6 setshaderconstant(localclientnum, 0, 0, 0, 0, 0);
    level.var_4073afd6 setshaderconstant(localclientnum, 1, 0, 0, 0, 0);
}

// Namespace cp_mi_eth_prologue
// Params 7, eflags: 0x0
// Checksum 0x63fd6d65, Offset: 0x1710
// Size: 0xa6
function function_9fd7493(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (!isdefined(level.var_205cf3cb)) {
        return;
    }
    n_index = newval;
    if (n_index == 9) {
        n_index = 0;
    }
    if (isdefined(level.var_205cf3cb[localclientnum][n_index])) {
        level.var_205cf3cb[localclientnum][n_index].origin = self.origin;
        level.var_205cf3cb[localclientnum][n_index].angles = self.angles;
    }
}

// Namespace cp_mi_eth_prologue
// Params 7, eflags: 0x0
// Checksum 0x87a08ea9, Offset: 0x17c0
// Size: 0xea
function set_cam_lookat_object(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (!isdefined(level.var_205cf3cb) || level.var_205cf3cb.size == 0) {
        return;
    }
    var_351745fc = level.var_205cf3cb[localclientnum][newval];
    if (isdefined(var_351745fc)) {
        if (!util::is_mature() && var_351745fc.var_6516b558) {
            var_351745fc setextracam(level.var_3792d454, 64, 36);
        } else {
            var_351745fc setextracam(level.var_3792d454, 1024, 768);
        }
        var_351745fc setextracamfocallength(level.var_3792d454, var_351745fc.var_81a24d4e);
    }
}

// Namespace cp_mi_eth_prologue
// Params 7, eflags: 0x0
// Checksum 0x5aedc0d9, Offset: 0x18b8
// Size: 0x155
function sndCameraScanner(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    switch (newval) {
    case 1:
        playsound(0, "evt_camera_scan_start", (0, 0, 0));
        self.var_a9e4b020 = self playloopsound("evt_camera_scan_lp", 1);
        break;
    case 2:
        playsound(0, "evt_camera_scan_nomatch", (0, 0, 0));
        if (isdefined(self.var_a9e4b020)) {
            self stoploopsound(self.var_a9e4b020, 0.5);
        }
        break;
    case 3:
        playsound(0, "evt_camera_scan_match", (0, 0, 0));
        if (isdefined(self.var_a9e4b020)) {
            self stoploopsound(self.var_a9e4b020, 0.5);
        }
        break;
    default:
        if (isdefined(self.var_a9e4b020)) {
            self stoploopsound(self.var_a9e4b020, 0.5);
        }
        break;
    }
}

// Namespace cp_mi_eth_prologue
// Params 7, eflags: 0x0
// Checksum 0x4e013712, Offset: 0x1a18
// Size: 0x296
function setup_security_cameras(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        if (!isdefined(level.var_205cf3cb)) {
            level.var_205cf3cb = [];
        }
        if (!isdefined(level.var_205cf3cb[localclientnum])) {
            level.var_205cf3cb[localclientnum] = [];
            level.var_205cf3cb[localclientnum][level.var_205cf3cb[localclientnum].size] = function_b0867fa6(localclientnum, "s_security_cam_hallway", 28);
            level.var_205cf3cb[localclientnum][level.var_205cf3cb[localclientnum].size] = function_b0867fa6(localclientnum, "s_security_interrogation", 45);
            level.var_205cf3cb[localclientnum][level.var_205cf3cb[localclientnum].size] = function_b0867fa6(localclientnum, "s_security_cower_on_floor", 50);
            level.var_205cf3cb[localclientnum][level.var_205cf3cb[localclientnum].size] = function_b0867fa6(localclientnum, "s_security_beating", 24, 1);
            level.var_205cf3cb[localclientnum][level.var_205cf3cb[localclientnum].size] = function_b0867fa6(localclientnum, "s_security_bound_in_chair", 35, 1);
            level.var_205cf3cb[localclientnum][level.var_205cf3cb[localclientnum].size] = function_b0867fa6(localclientnum, "s_security_torture", 35, 0);
            level.var_205cf3cb[localclientnum][level.var_205cf3cb[localclientnum].size] = function_b0867fa6(localclientnum, "s_security_lying_on_bed", 30, 1);
            level.var_205cf3cb[localclientnum][level.var_205cf3cb[localclientnum].size] = function_b0867fa6(localclientnum, "s_security_cam_minister_waterboard", 35, 1);
            level.var_205cf3cb[localclientnum][level.var_205cf3cb[localclientnum].size] = function_b0867fa6(localclientnum, "s_security_standing_wall", 38, 1);
        }
        return;
    }
    if (isdefined(level.var_205cf3cb[localclientnum])) {
        for (i = 0; i < level.var_205cf3cb[localclientnum].size; i++) {
            level.var_205cf3cb[localclientnum][i] clearextracam();
            level.var_205cf3cb[localclientnum][i] delete();
            level.var_205cf3cb[localclientnum][i] = undefined;
        }
    }
    level.var_205cf3cb[localclientnum] = undefined;
}

// Namespace cp_mi_eth_prologue
// Params 7, eflags: 0x0
// Checksum 0xe0194a80, Offset: 0x1cb8
// Size: 0x6a
function function_c9395227(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        setpbgactivebank(localclientnum, 2);
        return;
    }
    setpbgactivebank(localclientnum, 1);
}

// Namespace cp_mi_eth_prologue
// Params 4, eflags: 0x0
// Checksum 0x63397128, Offset: 0x1d30
// Size: 0x80
function function_b0867fa6(localclientnum, str_camera, var_81a24d4e, var_6516b558) {
    if (!isdefined(var_81a24d4e)) {
        var_81a24d4e = 14.64;
    }
    if (!isdefined(var_6516b558)) {
        var_6516b558 = 0;
    }
    var_351745fc = getent(localclientnum, str_camera, "targetname");
    var_351745fc.var_81a24d4e = var_81a24d4e;
    var_351745fc.var_6516b558 = var_6516b558;
    return var_351745fc;
}

// Namespace cp_mi_eth_prologue
// Params 0, eflags: 0x0
// Checksum 0x79de95fb, Offset: 0x1db8
// Size: 0xd9
function function_cd98eb8d() {
    self endon(#"death");
    level endon(#"blend_in_cleanup");
    v_angles = (0, -20, 0);
    n_move_time = 4;
    n_wait_time = 5;
    self rotateto(self.angles + v_angles, n_move_time / 2);
    wait n_wait_time / 2;
    while (true) {
        v_angles = (0, 40, 0);
        self rotateto(self.angles + v_angles, n_move_time);
        wait n_wait_time;
        v_angles = (0, -40, 0);
        self rotateto(self.angles + v_angles, n_move_time);
        wait n_wait_time;
    }
}

// Namespace cp_mi_eth_prologue
// Params 7, eflags: 0x0
// Checksum 0xdc4259b3, Offset: 0x1ea0
// Size: 0xd3
function function_a1ad4aa7(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    var_8b68ce61 = struct::get_array("s_interrogation_physics", "targetname");
    foreach (struct in var_8b68ce61) {
        physicsexplosionsphere(localclientnum, struct.origin, 100, 1, 10, 99, 100, 1, 1);
    }
}

// Namespace cp_mi_eth_prologue
// Params 7, eflags: 0x0
// Checksum 0x5f693756, Offset: 0x1f80
// Size: 0x122
function blend_in_cleanup(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    level notify(#"blend_in_cleanup");
    scene::stop("tower_sparking_wire_01", "targetname");
    scene::stop("tower_sparking_wire_02", "targetname");
    scene::stop("tower_sparking_wire_03", "targetname");
    scene::stop("tower_sparking_wire_04", "targetname");
    scene::stop("tower_sparking_wire_05", "targetname");
    scene::stop("tower_sparking_wire_06", "targetname");
    scene::stop("tower_sparking_wire_07", "targetname");
}

// Namespace cp_mi_eth_prologue
// Params 7, eflags: 0x0
// Checksum 0x4d1aae89, Offset: 0x20b0
// Size: 0x82
function fuel_depot_truck_explosion(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    level thread scene::play("p7_fxanim_gp_trash_newspaper_burst_out_01_bundle");
    level thread scene::play("p7_fxanim_gp_trash_newspaper_burst_up_01_bundle");
    level thread scene::play("p7_fxanim_gp_trash_paper_burst_up_01_bundle");
}

// Namespace cp_mi_eth_prologue
// Params 7, eflags: 0x0
// Checksum 0x898e1436, Offset: 0x2140
// Size: 0x5a
function apc_rail_tower_collapse(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        level thread scene::play("rail_tower_collapse_start", "targetname");
    }
}

// Namespace cp_mi_eth_prologue
// Params 7, eflags: 0x0
// Checksum 0x554dfecb, Offset: 0x21a8
// Size: 0x7a
function vtol_missile_explode_trash_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        level thread scene::play("vtol_hangar_trash_01", "targetname");
        level thread scene::play("vtol_hangar_trash_02", "targetname");
    }
}

// Namespace cp_mi_eth_prologue
// Params 7, eflags: 0x0
// Checksum 0x122b9bee, Offset: 0x2230
// Size: 0x4a
function function_7e8cf38d(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        level.var_e46224ba = 1;
    }
}

// Namespace cp_mi_eth_prologue
// Params 7, eflags: 0x0
// Checksum 0xf4f7cd9e, Offset: 0x2288
// Size: 0x72
function function_35a91904(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval == 1) {
        scene::init("p7_fxanim_cp_prologue_window_break_hangar_01_bundle");
        return;
    }
    scene::play("p7_fxanim_cp_prologue_window_break_hangar_01_bundle");
}

// Namespace cp_mi_eth_prologue
// Params 7, eflags: 0x0
// Checksum 0xd49ef611, Offset: 0x2308
// Size: 0x72
function function_a7b0883f(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval == 1) {
        scene::init("p7_fxanim_cp_prologue_window_break_hangar_02_bundle");
        return;
    }
    scene::play("p7_fxanim_cp_prologue_window_break_hangar_02_bundle");
}

