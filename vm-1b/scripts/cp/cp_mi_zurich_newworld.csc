#using scripts/codescripts/struct;
#using scripts/cp/_load;
#using scripts/cp/_util;
#using scripts/cp/cp_mi_zurich_newworld_fx;
#using scripts/cp/cp_mi_zurich_newworld_sound;
#using scripts/cp/cp_mi_zurich_newworld_util;
#using scripts/shared/array_shared;
#using scripts/shared/audio_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/duplicaterender_mgr;
#using scripts/shared/math_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/util_shared;

#namespace cp_mi_zurich_newworld;

// Namespace cp_mi_zurich_newworld
// Params 0, eflags: 0x0
// Checksum 0x30f011bc, Offset: 0xd40
// Size: 0x72
function main() {
    util::function_57b966c8(&force_streamer, 10);
    init_clientfields();
    cp_mi_zurich_newworld_fx::main();
    cp_mi_zurich_newworld_sound::main();
    load::main();
    util::waitforclient(0);
}

// Namespace cp_mi_zurich_newworld
// Params 0, eflags: 0x0
// Checksum 0xf584c0c4, Offset: 0xdc0
// Size: 0x6ea
function init_clientfields() {
    clientfield::register("actor", "diaz_camo_shader", 1, 2, "int", &function_f532bd65, 0, 1);
    duplicate_render::set_dr_filter_framebuffer("active_camo", 90, "actor_camo_on", "", 0, "mc/hud_outline_predator_camo_active_inf", 0);
    duplicate_render::set_dr_filter_framebuffer("active_camo_flicker", 80, "actor_camo_flicker", "", 0, "mc/hud_outline_predator_camo_disruption_inf", 0);
    clientfield::register("vehicle", "name_diaz_wasp", 1, 1, "int", &name_diaz_wasp, 0, 1);
    clientfield::register("scriptmover", "weakpoint", 1, 1, "int", &weakpoint, 0, 0);
    duplicate_render::set_dr_filter_offscreen("weakpoint_keyline", 100, "weakpoint_keyline_show_z", "weakpoint_keyline_hide_z", 2, "mc/hud_outline_model_z_orange", 1);
    clientfield::register("world", "factory_exterior_vents", 1, 1, "int", &factory_exterior_vents, 0, 0);
    clientfield::register("scriptmover", "open_vat_doors", 1, 1, "int", &function_2920b522, 0, 0);
    clientfield::register("world", "chase_pedestrian_blockers", 1, 1, "int", &chase_pedestrian_blockers, 0, 0);
    clientfield::register("toplayer", "chase_train_rumble", 1, 1, "int", &chase_train_rumble, 0, 0);
    clientfield::register("world", "spinning_vent_fxanim", 1, 1, "int", &spinning_vent_fxanim, 0, 0);
    clientfield::register("world", "crane_fxanim", 1, 1, "int", &crane_fxanim, 0, 0);
    clientfield::register("toplayer", "ability_wheel_tutorial", 1, 1, "int", &ability_wheel_tutorial, 0, 0);
    clientfield::register("world", "underground_subway_debris", 1, 2, "int", &underground_subway_debris, 0, 0);
    clientfield::register("world", "underground_subway_wires", 1, 1, "int", &function_9eeb165f, 0, 0);
    clientfield::register("world", "inbound_igc_glass", 1, 2, "int", &inbound_igc_glass, 0, 0);
    clientfield::register("world", "train_robot_swing_glass_left", 1, 2, "int", &train_robot_swing_glass_left, 0, 0);
    clientfield::register("world", "train_robot_swing_glass_right", 1, 2, "int", &train_robot_swing_glass_right, 0, 0);
    clientfield::register("world", "train_robot_swing_left_extra", 1, 1, "int", &function_54711778, 0, 0);
    clientfield::register("world", "train_robot_swing_right_extra", 1, 1, "int", &function_92f89bed, 0, 0);
    clientfield::register("world", "train_dropdown_glass", 1, 2, "int", &train_dropdown_glass, 0, 0);
    clientfield::register("world", "train_lockdown_glass_left", 1, 2, "int", &train_lockdown_glass_left, 0, 0);
    clientfield::register("world", "train_lockdown_glass_right", 1, 2, "int", &train_lockdown_glass_right, 0, 0);
    clientfield::register("world", "train_lockdown_shutters_1", 1, 1, "int", &train_lockdown_shutters_1, 0, 0);
    clientfield::register("world", "train_lockdown_shutters_2", 1, 1, "int", &train_lockdown_shutters_2, 0, 0);
    clientfield::register("world", "train_lockdown_shutters_3", 1, 1, "int", &train_lockdown_shutters_3, 0, 0);
    clientfield::register("world", "train_lockdown_shutters_4", 1, 1, "int", &train_lockdown_shutters_4, 0, 0);
    clientfield::register("world", "train_lockdown_shutters_5", 1, 1, "int", &train_lockdown_shutters_5, 0, 0);
    clientfield::register("actor", "train_throw_robot_corpses", 1, 1, "int", &function_b758d8f, 0, 0);
    clientfield::register("scriptmover", "train_throw_robot_corpses", 1, 1, "int", &function_b758d8f, 0, 0);
    clientfield::register("world", "train_brake_flaps", 1, 2, "int", &train_brake_flaps, 0, 0);
    clientfield::register("world", "sndTrainContext", 1, 2, "int", &cp_mi_zurich_newworld_sound::sndTrainContext, 0, 0);
}

// Namespace cp_mi_zurich_newworld
// Params 1, eflags: 0x0
// Checksum 0xccf79f1e, Offset: 0x14b8
// Size: 0x285
function force_streamer(n_zone) {
    switch (n_zone) {
    case 1:
        break;
    case 2:
        forcestreamxmodel("c_hro_taylor_base_fb");
        forcestreamxmodel("c_hro_diaz_base");
        forcestreambundle("cin_new_02_01_pallasintro_vign_appear");
        forcestreambundle("cin_new_02_01_pallasintro_vign_appear_player");
        break;
    case 3:
        forcestreamxmodel("c_hro_taylor_base_fb");
        forcestreamxmodel("c_hro_diaz_base");
        forcestreambundle("cin_new_04_01_insideman_1st_hack_sh010");
        forcestreambundle("cin_new_04_01_insideman_1st_hack_sh320");
        forcestreambundle("p7_fxanim_cp_sgen_charging_station_break_02_bundle");
        forcestreambundle("cin_sgen_16_01_charging_station_aie_awaken_robot03");
        forcestreambundle("cin_sgen_16_01_charging_station_aie_awaken_robot04");
        break;
    case 6:
        forcestreamxmodel("c_hro_taylor_base_fb");
        forcestreamxmodel("c_hro_maretti_base_fb");
        forcestreambundle("cin_new_10_01_pinneddown_1st_explanation");
        break;
    case 7:
        forcestreambundle("cin_new_13_01_stagingroom_1st_guidance");
        break;
    case 8:
        forcestreamxmodel("c_hro_taylor_base_fb");
        forcestreambundle("cin_new_14_01_inbound_1st_preptalk");
        forcestreambundle("p7_fxanim_cp_newworld_train_glass_01_bundle");
        break;
    case 9:
        forcestreamxmodel("c_hro_taylor_base_fb");
        forcestreambundle("p7_fxanim_cp_newworld_train_end_bundle");
        forcestreambundle("cin_new_16_01_detachbombcar_1st_detach");
        break;
    case 10:
        forcestreambundle("cin_new_17_01_wakingup_1st_reveal");
        forcestreambundle("p7_fxanim_cp_newworld_curtain_bundle");
        break;
    }
}

// Namespace cp_mi_zurich_newworld
// Params 7, eflags: 0x0
// Checksum 0xb2567bee, Offset: 0x1748
// Size: 0x82
function factory_exterior_vents(local_client_num, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval == 1) {
        smodelanimcmd("factory_vents", "pause");
        return;
    }
    smodelanimcmd("factory_vents", "unpause");
}

// Namespace cp_mi_zurich_newworld
// Params 7, eflags: 0x0
// Checksum 0x97d3023e, Offset: 0x17d8
// Size: 0x7a
function function_f532bd65(local_client_num, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self duplicate_render::set_dr_flag("actor_camo_flicker", newval == 2);
    self duplicate_render::set_dr_flag("actor_camo_on", newval != 0);
    self duplicate_render::change_dr_flags(local_client_num);
}

// Namespace cp_mi_zurich_newworld
// Params 7, eflags: 0x0
// Checksum 0x5bb81e6a, Offset: 0x1860
// Size: 0xaa
function weakpoint(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        self duplicate_render::change_dr_flags(localclientnum, "weakpoint_keyline_show_z", "weakpoint_keyline_hide_z");
        self weakpoint_enable(2);
        return;
    }
    self duplicate_render::change_dr_flags(localclientnum, "weakpoint_keyline_hide_z", "weakpoint_keyline_show_z");
    self weakpoint_enable(0);
}

// Namespace cp_mi_zurich_newworld
// Params 7, eflags: 0x0
// Checksum 0xe8030880, Offset: 0x1918
// Size: 0x5a
function name_diaz_wasp(local_client_num, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        self setdrawname("Diaz", 1);
    }
}

// Namespace cp_mi_zurich_newworld
// Params 7, eflags: 0x0
// Checksum 0x57763cf8, Offset: 0x1980
// Size: 0x72
function chase_pedestrian_blockers(local_client_num, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval == 1) {
        function_1583bd50(local_client_num, 1);
        return;
    }
    function_1583bd50(local_client_num, 0);
}

// Namespace cp_mi_zurich_newworld
// Params 2, eflags: 0x0
// Checksum 0x9edca25e, Offset: 0x1a00
// Size: 0x1c3
function function_1583bd50(localclientnum, var_f4d36bbd) {
    if (!isdefined(var_f4d36bbd)) {
        var_f4d36bbd = 1;
    }
    if (var_f4d36bbd) {
        var_9da3bffd = 1;
    } else {
        var_9da3bffd = -1;
    }
    var_929d2c59 = getentarray(localclientnum, "train_ped_blocker_right", "targetname");
    foreach (e_blocker in var_929d2c59) {
        if (e_blocker.script_noteworthy === "train_ped_blocker_mirrored") {
            e_blocker movex(64 * var_9da3bffd, 0.5);
            continue;
        }
        e_blocker movex(64 * var_9da3bffd * -1, 0.5);
    }
    var_ba59f2a4 = getentarray(localclientnum, "train_ped_blocker_left", "targetname");
    foreach (e_blocker in var_ba59f2a4) {
        if (e_blocker.script_noteworthy === "train_ped_blocker_mirrored") {
            e_blocker movex(64 * var_9da3bffd * -1, 0.5);
            continue;
        }
        e_blocker movex(64 * var_9da3bffd, 0.5);
    }
}

// Namespace cp_mi_zurich_newworld
// Params 7, eflags: 0x0
// Checksum 0x4752adc6, Offset: 0x1bd0
// Size: 0x7a
function chase_train_rumble(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval == 1) {
        self playrumblelooponentity(localclientnum, "cp_newworld_rumble_chase_train_near");
        return;
    }
    self stoprumble(localclientnum, "cp_newworld_rumble_chase_train_near");
}

// Namespace cp_mi_zurich_newworld
// Params 7, eflags: 0x0
// Checksum 0x28e7490f, Offset: 0x1c58
// Size: 0xa2
function spinning_vent_fxanim(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval == 1) {
        level thread scene::play("p7_fxanim_gp_vent_roof_wobble_bundle");
        level thread scene::play("p7_fxanim_gp_vent_roof_slow_bundle");
        return;
    }
    level thread scene::stop("p7_fxanim_gp_vent_roof_wobble_bundle", 1);
    level thread scene::stop("p7_fxanim_gp_vent_roof_slow_bundle", 1);
}

// Namespace cp_mi_zurich_newworld
// Params 7, eflags: 0x0
// Checksum 0x5e1a8672, Offset: 0x1d08
// Size: 0xa2
function crane_fxanim(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval == 1) {
        level thread scene::play("p7_fxanim_gp_crane_hook_small_01_bundle");
        level thread scene::play("p7_fxanim_gp_crane_pallet_01_bundle");
        return;
    }
    level thread scene::stop("p7_fxanim_gp_crane_hook_small_01_bundle", 1);
    level thread scene::stop("p7_fxanim_gp_crane_pallet_01_bundle", 1);
}

// Namespace cp_mi_zurich_newworld
// Params 7, eflags: 0x0
// Checksum 0xa25ee37b, Offset: 0x1db8
// Size: 0x3a
function ability_wheel_tutorial(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    
}

// Namespace cp_mi_zurich_newworld
// Params 7, eflags: 0x0
// Checksum 0x35052e7, Offset: 0x1e00
// Size: 0x92
function underground_subway_debris(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval == 1) {
        scene::init("p7_fxanim_cp_newworld_subway_debris_01_bundle");
        return;
    }
    if (newval == 2) {
        scene::play("p7_fxanim_cp_newworld_subway_debris_01_bundle");
        return;
    }
    scene::stop("p7_fxanim_cp_newworld_subway_debris_01_bundle", 1);
}

// Namespace cp_mi_zurich_newworld
// Params 7, eflags: 0x0
// Checksum 0xc7b96cf7, Offset: 0x1ea0
// Size: 0xba
function inbound_igc_glass(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval == 1) {
        scene::init("p7_fxanim_cp_newworld_train_glass_01_bundle");
        return;
    }
    if (newval == 2) {
        scene::play("p7_fxanim_cp_newworld_train_glass_01_bundle");
        return;
    }
    var_378eee5b = getent(localclientnum, "newworld_train_glass_01", "targetname");
    if (isdefined(var_378eee5b)) {
        var_378eee5b delete();
    }
}

// Namespace cp_mi_zurich_newworld
// Params 7, eflags: 0x0
// Checksum 0x3c9c1c43, Offset: 0x1f68
// Size: 0x123
function train_robot_swing_glass_left(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval == 1) {
        scene::init("p7_fxanim_cp_newworld_train_glass_02_bundle");
        return;
    }
    if (newval == 2) {
        s_scene = struct::get("train_glass_left_01", "targetname");
        s_scene scene::play();
        return;
    }
    var_363ca6bb = getentarray(localclientnum, "newworld_train_glass_02", "targetname");
    foreach (var_378eee5b in var_363ca6bb) {
        var_378eee5b delete();
    }
}

// Namespace cp_mi_zurich_newworld
// Params 7, eflags: 0x0
// Checksum 0xa2e8fa21, Offset: 0x2098
// Size: 0x123
function train_robot_swing_glass_right(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval == 1) {
        scene::init("p7_fxanim_cp_newworld_train_glass_03_bundle");
        return;
    }
    if (newval == 2) {
        s_scene = struct::get("train_glass_right_02", "targetname");
        s_scene scene::play();
        return;
    }
    var_363ca6bb = getentarray(localclientnum, "newworld_train_glass_03", "targetname");
    foreach (var_378eee5b in var_363ca6bb) {
        var_378eee5b delete();
    }
}

// Namespace cp_mi_zurich_newworld
// Params 7, eflags: 0x0
// Checksum 0x7aae7e9d, Offset: 0x21c8
// Size: 0x7a
function function_54711778(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval == 1) {
        s_scene = struct::get("train_glass_left_02", "targetname");
        s_scene scene::play();
    }
}

// Namespace cp_mi_zurich_newworld
// Params 7, eflags: 0x0
// Checksum 0xf549a19f, Offset: 0x2250
// Size: 0x7a
function function_92f89bed(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval == 1) {
        s_scene = struct::get("train_glass_right_02", "targetname");
        s_scene scene::play();
    }
}

// Namespace cp_mi_zurich_newworld
// Params 7, eflags: 0x0
// Checksum 0x8fb499e3, Offset: 0x22d8
// Size: 0xba
function train_dropdown_glass(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval == 1) {
        scene::init("p7_fxanim_cp_newworld_train_glass_06_bundle");
        return;
    }
    if (newval == 2) {
        scene::play("p7_fxanim_cp_newworld_train_glass_06_bundle");
        return;
    }
    var_378eee5b = getent(localclientnum, "newworld_train_glass_06", "targetname");
    if (isdefined(var_378eee5b)) {
        var_378eee5b delete();
    }
}

// Namespace cp_mi_zurich_newworld
// Params 7, eflags: 0x0
// Checksum 0x90d7ba90, Offset: 0x23a0
// Size: 0xda
function train_lockdown_glass_left(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval == 1) {
        scene::init("p7_fxanim_cp_newworld_train_glass_04_bundle");
        return;
    }
    if (newval == 2) {
        scene::play("p7_fxanim_cp_newworld_train_glass_04_bundle");
        audio::playloopat("amb_train_window_wind", (-20401, 15614, 4293));
        return;
    }
    var_378eee5b = getent(localclientnum, "newworld_train_glass_04", "targetname");
    if (isdefined(var_378eee5b)) {
        var_378eee5b delete();
    }
}

// Namespace cp_mi_zurich_newworld
// Params 7, eflags: 0x0
// Checksum 0xcd8ef11d, Offset: 0x2488
// Size: 0xc3
function train_lockdown_glass_right(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval == 1) {
        scene::init("p7_fxanim_cp_newworld_train_glass_05_bundle");
    } else if (newval == 2) {
        scene::play("p7_fxanim_cp_newworld_train_glass_05_bundle");
    } else {
        var_378eee5b = getent(localclientnum, "newworld_train_glass_05", "targetname");
        if (isdefined(var_378eee5b)) {
            var_378eee5b delete();
        }
    }
    level notify(#"hash_6b336e59");
}

// Namespace cp_mi_zurich_newworld
// Params 7, eflags: 0x0
// Checksum 0xaee63e4, Offset: 0x2558
// Size: 0x103
function train_lockdown_shutters_1(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval == 1) {
        s_scene = struct::get("train_shutter_01", "targetname");
        s_scene scene::play();
        return;
    }
    var_d4260265 = getentarray(localclientnum, "newworld_train_shutters_01", "targetname");
    foreach (var_aed142c5 in var_d4260265) {
        var_aed142c5 delete();
    }
}

// Namespace cp_mi_zurich_newworld
// Params 7, eflags: 0x0
// Checksum 0x3496f8e8, Offset: 0x2668
// Size: 0x7a
function train_lockdown_shutters_2(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval == 1) {
        s_scene = struct::get("train_shutter_02", "targetname");
        s_scene scene::play();
    }
}

// Namespace cp_mi_zurich_newworld
// Params 7, eflags: 0x0
// Checksum 0x74ff5300, Offset: 0x26f0
// Size: 0x7a
function train_lockdown_shutters_3(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval == 1) {
        s_scene = struct::get("train_shutter_03", "targetname");
        s_scene scene::play();
    }
}

// Namespace cp_mi_zurich_newworld
// Params 7, eflags: 0x0
// Checksum 0x95269e35, Offset: 0x2778
// Size: 0x7a
function train_lockdown_shutters_4(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval == 1) {
        s_scene = struct::get("train_shutter_04", "targetname");
        s_scene scene::play();
    }
}

// Namespace cp_mi_zurich_newworld
// Params 7, eflags: 0x0
// Checksum 0x28e8353e, Offset: 0x2800
// Size: 0x7a
function train_lockdown_shutters_5(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval == 1) {
        s_scene = struct::get("train_shutter_05", "targetname");
        s_scene scene::play();
    }
}

// Namespace cp_mi_zurich_newworld
// Params 7, eflags: 0x0
// Checksum 0x3c8881ef, Offset: 0x2888
// Size: 0x77
function function_b758d8f(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval == 1) {
        self.n_time = gettime();
        self thread function_965a6439(localclientnum);
        self thread function_a860cb86(localclientnum);
        return;
    }
    level notify(#"hash_4ce164a6");
}

// Namespace cp_mi_zurich_newworld
// Params 1, eflags: 0x0
// Checksum 0x83c891b9, Offset: 0x2908
// Size: 0x139
function function_965a6439(localclientnum) {
    level endon(#"hash_4ce164a6");
    self endon(#"death");
    if (isdefined(10)) {
        __s = spawnstruct();
        __s endon(#"timeout");
        __s util::delay_notify(10, "timeout");
    }
    var_5cf8a2dd = getent(localclientnum, "train_bad_area_corpses", "targetname");
    while (isdefined(self)) {
        if (self istouching(var_5cf8a2dd)) {
            n_x = randomfloatrange(700, 800);
            n_y = randomfloatrange(-100, 100);
            n_z = randomfloatrange(10, 100);
            self launchragdoll((n_x, n_y, n_z));
            self thread newworld_util::function_52bc98a1(localclientnum);
            break;
        }
        wait 0.05;
    }
}

// Namespace cp_mi_zurich_newworld
// Params 1, eflags: 0x0
// Checksum 0xff3a1ffb, Offset: 0x2a50
// Size: 0x2f1
function function_a860cb86(localclientnum) {
    level endon(#"hash_4ce164a6");
    self endon(#"death");
    if (isdefined(10)) {
        __s = spawnstruct();
        __s endon(#"timeout");
        __s util::delay_notify(10, "timeout");
    }
    var_accfeb6 = getentarray(localclientnum, "train_roof_brakeflap_trigger", "targetname");
    var_623b9b = getentarray(localclientnum, "train_roof_flap", "targetname");
    while (isdefined(self)) {
        foreach (var_4f00cbcf in var_accfeb6) {
            if (self istouching(var_4f00cbcf) && self.var_2c3c4e50 !== var_4f00cbcf) {
                self.var_2c3c4e50 = var_4f00cbcf;
                var_9881fa10 = arraygetclosest(self.origin, var_623b9b);
                if (!(isdefined(var_9881fa10.var_a3256cdc) && var_9881fa10.var_a3256cdc)) {
                    n_time_delta = -1;
                    if (isdefined(self.n_time)) {
                        n_time_end = gettime();
                        n_time_delta = n_time_end - self.n_time;
                    }
                    if (!isdefined(self.n_modifier)) {
                        if (math::cointoss() == 1) {
                            self.n_modifier = 1;
                        } else {
                            self.n_modifier = -1;
                        }
                    }
                    if (n_time_delta <= 300) {
                        n_y = randomfloatrange(10, 30) * self.n_modifier;
                        n_z = randomfloatrange(40, 50);
                    } else if (n_time_delta > 300 && n_time_delta <= 600) {
                        n_y = randomfloatrange(30, 50) * self.n_modifier;
                        n_z = randomfloatrange(50, 60);
                    } else {
                        n_y = randomfloatrange(50, 70) * self.n_modifier;
                        n_z = randomfloatrange(60, 70);
                    }
                    self launchragdoll((0, n_y, n_z));
                    level thread function_a251bd0b(localclientnum, var_9881fa10);
                    wait 0.25;
                    break;
                }
            }
        }
        wait 0.05;
    }
}

// Namespace cp_mi_zurich_newworld
// Params 2, eflags: 0x0
// Checksum 0x212b22e8, Offset: 0x2d50
// Size: 0x8e
function function_a251bd0b(localclientnum, var_9881fa10) {
    var_9881fa10.var_a3256cdc = 1;
    var_9881fa10 notify(#"hash_47e64fc0");
    var_9881fa10 rotatepitch(25, 0.25);
    var_9881fa10 waittill(#"rotatedone");
    var_9881fa10 rotatepitch(-25, 0.5);
    var_9881fa10 thread function_20e68acf(localclientnum);
    wait 0.5;
    var_9881fa10.var_a3256cdc = 0;
}

// Namespace cp_mi_zurich_newworld
// Params 7, eflags: 0x0
// Checksum 0x429a33ff, Offset: 0x2de8
// Size: 0x2b3
function train_brake_flaps(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval == 1) {
        var_a1ec3453 = getentarray(localclientnum, "train_roof_flap", "targetname");
        foreach (var_13f418 in var_a1ec3453) {
            var_13f418.angles = (90, 0, 0);
        }
        return;
    }
    if (newval == 0) {
        var_22e036fa = struct::get("front_of_the_train", "targetname");
        var_a1ec3453 = getentarray(localclientnum, "train_roof_flap", "targetname");
        var_a1ec3453 = array::get_all_closest(var_22e036fa.origin, var_a1ec3453);
        n_count = 0;
        foreach (var_13f418 in var_a1ec3453) {
            var_13f418 rotatepitch(-90, 0.5);
            var_13f418 thread function_20e68acf(localclientnum);
            var_13f418 thread newworld_util::function_ff1b6796(localclientnum);
            var_13f418 playloopsound("evt_airbreak_loop");
            var_13f418 playsound(0, "evt_airbreak_deploy");
            n_count++;
            if (n_count % 3 == 0) {
                wait 0.25;
            }
        }
        return;
    }
    if (newval == 2) {
        level notify(#"newworld_train_complete");
        var_a1ec3453 = getentarray(localclientnum, "train_roof_flap", "targetname");
        foreach (var_13f418 in var_a1ec3453) {
            if (isdefined(var_13f418.var_f3f44e9)) {
                var_13f418.var_f3f44e9 delete();
            }
            var_13f418 delete();
        }
    }
}

// Namespace cp_mi_zurich_newworld
// Params 1, eflags: 0x0
// Checksum 0x5c437616, Offset: 0x30a8
// Size: 0xb7
function function_20e68acf(localclientnum) {
    level endon(#"newworld_train_complete");
    self endon(#"hash_47e64fc0");
    self waittill(#"rotatedone");
    while (true) {
        var_f1d0b948 = randomfloatrange(2, 5);
        var_b53c9eef = randomfloatrange(0.15, 0.25);
        self rotatepitch(var_f1d0b948, var_b53c9eef);
        self waittill(#"rotatedone");
        var_f1d0b948 *= -1;
        self rotatepitch(var_f1d0b948, var_b53c9eef);
        self waittill(#"rotatedone");
    }
}

// Namespace cp_mi_zurich_newworld
// Params 7, eflags: 0x0
// Checksum 0x2d03034b, Offset: 0x3168
// Size: 0x1ea
function function_2920b522(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    var_280d5f68 = arraygetclosest(self.origin, getentarray(localclientnum, "vat_door_left", "targetname"));
    var_3c301126 = arraygetclosest(self.origin, getentarray(localclientnum, "vat_door_right", "targetname"));
    v_side = anglestoright(var_280d5f68.angles);
    if (newval) {
        var_33219fd6 = var_280d5f68.origin + v_side * 60;
        var_280d5f68 moveto(var_33219fd6, 1.5);
        var_dac99ad = var_3c301126.origin + v_side * 60 * -1;
        var_3c301126 moveto(var_dac99ad, 1.5);
        var_3c301126 playsound(0, "evt_vat_door_open");
        return;
    }
    var_33219fd6 = var_280d5f68.origin + v_side * 60 * -1;
    var_280d5f68 moveto(var_33219fd6, 1.5);
    var_dac99ad = var_3c301126.origin + v_side * 60;
    var_3c301126 moveto(var_dac99ad, 1.5);
    var_3c301126 playsound(0, "evt_vat_door_close");
}

// Namespace cp_mi_zurich_newworld
// Params 7, eflags: 0x0
// Checksum 0xf3f5e3ac, Offset: 0x3360
// Size: 0xca
function function_9eeb165f(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        level thread scene::play("p7_fxanim_gp_wire_sparking_xsml_bundle");
        level thread scene::play("p7_fxanim_gp_wire_sparking_xsml_thick_bundle");
        level thread scene::play("p7_fxanim_gp_wire_sparking_sml_bundle");
        return;
    }
    level scene::stop("p7_fxanim_gp_wire_sparking_xsml_thick_bundle", 1);
    level scene::stop("p7_fxanim_gp_wire_sparking_xsml_bundle", 1);
    level scene::stop("p7_fxanim_gp_wire_sparking_sml_bundle", 1);
}

