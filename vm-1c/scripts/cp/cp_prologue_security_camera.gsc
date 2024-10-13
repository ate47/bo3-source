#using scripts/cp/gametypes/_battlechatter;
#using scripts/cp/cp_prologue_hangars;
#using scripts/cp/cp_prologue_hostage_rescue;
#using scripts/cp/cp_prologue_util;
#using scripts/cp/cp_prologue_apc;
#using scripts/cp/cp_mi_eth_prologue_sound;
#using scripts/cp/cp_mi_eth_prologue_fx;
#using scripts/cp/cp_mi_eth_prologue;
#using scripts/shared/exploder_shared;
#using scripts/shared/array_shared;
#using scripts/shared/vehicle_shared;
#using scripts/shared/trigger_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/lui_shared;
#using scripts/shared/hud_util_shared;
#using scripts/shared/gameobjects_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/doors_shared;
#using scripts/shared/colors_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/ai_shared;
#using scripts/cp/_util;
#using scripts/cp/_spawn_manager;
#using scripts/cp/_skipto;
#using scripts/cp/_objectives;
#using scripts/cp/_load;
#using scripts/cp/_dialog;
#using scripts/shared/util_shared;
#using scripts/codescripts/struct;

#namespace namespace_e09822e3;

// Namespace namespace_e09822e3
// Params 1, eflags: 0x1 linked
// Checksum 0xa4a9142f, Offset: 0xf18
// Size: 0x8c
function function_d6a885d6(str_objective) {
    function_889067f5();
    level notify(#"hash_84f95272");
    array::run_all(level.players, &util::function_16c71b8, 1);
    level util::clientnotify("sndStopFiretruck");
    level thread function_599b2699();
}

// Namespace namespace_e09822e3
// Params 0, eflags: 0x1 linked
// Checksum 0x3471be9, Offset: 0xfb0
// Size: 0x24
function function_889067f5() {
    level flag::init("everyone_in_camera_room");
}

// Namespace namespace_e09822e3
// Params 0, eflags: 0x1 linked
// Checksum 0x6f331a7e, Offset: 0xfe0
// Size: 0x1fc
function function_599b2699() {
    t_regroup_security_camera = getent("t_regroup_security_camera", "targetname");
    t_regroup_security_camera triggerenable(0);
    exploder::exploder("light_exploder_torture_rooms");
    level thread cp_prologue_util::function_950d1c3b(1);
    level thread namespace_52f8de11::function_bfe70f02();
    level thread function_6475a61e();
    battlechatter::function_d9f49fba(0);
    cp_prologue_util::function_47a62798(1);
    level thread function_61e4fa9();
    level.var_2fd26037 thread function_240f41ef();
    level thread setup_security_cameras();
    level waittill(#"hash_81d6c615");
    while (true) {
        var_d62d9e75 = function_e1a52cb4();
        if (!var_d62d9e75) {
            break;
        }
        wait 0.05;
    }
    level scene::stop("injured_carried1", "targetname");
    level scene::stop("injured_carried2", "targetname");
    level notify(#"hash_50dbb16b");
    exploder::exploder_stop("light_exploder_torture_rooms");
    skipto::function_be8adfb8("skipto_security_camera");
}

// Namespace namespace_e09822e3
// Params 0, eflags: 0x1 linked
// Checksum 0xc02236b2, Offset: 0x11e8
// Size: 0x12c
function function_6475a61e() {
    s_pos = struct::get("temp_security_door_obj", "targetname");
    objectives::set("cp_level_prologue_security_door", s_pos);
    cp_prologue_util::function_d1f1caad("t_start_security_cam_room_breach_v2");
    wait 2;
    objectives::complete("cp_level_prologue_security_door");
    level flag::wait_till("everyone_in_camera_room");
    objectives::complete("cp_level_prologue_locate_the_security_room");
    objectives::set("cp_level_prologue_locate_the_minister");
    level waittill(#"hash_1a6eba1f");
    objectives::complete("cp_level_prologue_security_camera");
    objectives::complete("cp_level_prologue_locate_the_minister");
    objectives::set("cp_level_prologue_free_the_minister");
}

// Namespace namespace_e09822e3
// Params 0, eflags: 0x1 linked
// Checksum 0xd89f83a6, Offset: 0x1320
// Size: 0xb2
function function_e1a52cb4() {
    var_d62d9e75 = 0;
    foreach (e_player in level.activeplayers) {
        if (isdefined(e_player.var_1f4942ae) && e_player.var_1f4942ae) {
            var_d62d9e75++;
        }
    }
    return var_d62d9e75;
}

// Namespace namespace_e09822e3
// Params 0, eflags: 0x1 linked
// Checksum 0x76f1b09, Offset: 0x13e0
// Size: 0x1cc
function setup_security_cameras() {
    util::wait_network_frame();
    level clientfield::set("setup_security_cameras", 1);
    level thread function_d0260dae();
    level.var_1a6eba1f = 0;
    level.var_c01222d2 = [];
    function_d8d1298e("hallway", "cin_pro_05_02_securitycam_pip_ministerdrag", 1);
    function_d8d1298e("interrogation", "cin_pro_05_02_securitycam_pip_ministerdrag_interrogationroom", 1);
    function_d8d1298e("torture_prisoner_1", "cin_pro_05_02_securitycam_pip_solitary");
    function_d8d1298e("torture_prisoner_2", "cin_pro_05_02_securitycam_pip_pipe");
    function_d8d1298e("torture_prisoner_3", "cin_pro_05_02_securitycam_pip_funnel");
    function_d8d1298e("torture_khalil", "cin_pro_05_02_securitycam_pip_khalil");
    function_d8d1298e("torture_prisoner_4", "cin_pro_05_02_securitycam_pip_branding");
    function_d8d1298e("torture_minister", "cin_pro_05_02_securitycam_pip_waterboard");
    function_d8d1298e("torture_prisoner_5", "cin_pro_05_02_securitycam_pip_pressure");
    function_9f9f8c2a();
    level thread function_7f6e313c("t_security_camera_use_left", "s_security_cam_station_left", 1);
}

// Namespace namespace_e09822e3
// Params 0, eflags: 0x1 linked
// Checksum 0xaec1b8c7, Offset: 0x15b8
// Size: 0x18e
function function_9f9f8c2a() {
    if (!isdefined(level.var_690ce961)) {
        level.var_690ce961 = level.var_c01222d2["torture_minister"].n_index;
        return;
    }
    var_1d7e2b7c = function_6840a15e(level.var_690ce961);
    switch (var_1d7e2b7c.str_name) {
    case "torture_minister":
        level.var_690ce961 = level.var_c01222d2["hallway"].n_index;
        level.var_c01222d2["hallway"].var_b5991f0e = 0;
        level.var_c01222d2["hallway"].var_a1a1b35e = 3;
        break;
    case "hallway":
        level.var_690ce961 = level.var_c01222d2["interrogation"].n_index;
        level.var_c01222d2["interrogation"].var_b5991f0e = 0;
        level.var_c01222d2["interrogation"].var_a1a1b35e = 3;
        break;
    case "interrogation":
        level.var_1a6eba1f = 1;
        level thread namespace_21b2c1f2::function_fa2e45b8();
        break;
    }
}

// Namespace namespace_e09822e3
// Params 0, eflags: 0x1 linked
// Checksum 0x50d8642, Offset: 0x1750
// Size: 0x1bc
function function_396ce97e() {
    showmiscmodels("security_decal_prop");
    foreach (e_player in level.activeplayers) {
        e_player clientfield::set_to_player("turn_on_multicam", 0);
    }
    foreach (var_865f8b0e in level.var_c01222d2) {
        if (isdefined(var_865f8b0e.str_scene) && level scene::is_playing(var_865f8b0e.str_scene)) {
            level scene::stop(var_865f8b0e.str_scene);
        }
    }
    level clientfield::set("setup_security_cameras", 0);
    level clientfield::set("toggle_security_camera_pbg_bank", 0);
}

// Namespace namespace_e09822e3
// Params 3, eflags: 0x1 linked
// Checksum 0x7b71691a, Offset: 0x1918
// Size: 0x154
function function_7f6e313c(var_3675dd99, var_8deb7bb6, var_ff018680) {
    var_79831c10 = struct::get(var_8deb7bb6, "targetname");
    t_interact = getent(var_3675dd99, "targetname");
    t_interact triggerenable(0);
    level waittill(#"hash_af8926a2");
    level.var_ab82ba6d = 0;
    level flag::wait_till("everyone_in_camera_room");
    t_interact triggerenable(1);
    e_object = util::function_14518e76(t_interact, %cp_prompt_dni_prologue_security_camera, %CP_MI_ETH_PROLOGUE_USE_SECURITY_CAMERA, &function_b85fc83f);
    e_object.var_79831c10 = var_79831c10;
    e_object.var_ff018680 = var_ff018680;
    e_object thread function_83168a46();
}

// Namespace namespace_e09822e3
// Params 0, eflags: 0x1 linked
// Checksum 0xe8d621d3, Offset: 0x1a78
// Size: 0x34
function function_83168a46() {
    self endon(#"death");
    level waittill(#"hash_1a6eba1f");
    wait 1;
    self gameobjects::disable_object();
}

// Namespace namespace_e09822e3
// Params 1, eflags: 0x1 linked
// Checksum 0x1d7f9cb7, Offset: 0x1ab8
// Size: 0x64
function function_b85fc83f(e_player) {
    e_player thread function_18df8595(self.var_79831c10, self.var_ff018680);
    self thread function_85343e08(e_player);
    self gameobjects::disable_object();
}

// Namespace namespace_e09822e3
// Params 1, eflags: 0x1 linked
// Checksum 0x3ff8a380, Offset: 0x1b28
// Size: 0x3c
function function_85343e08(e_player) {
    level endon(#"hash_1a6eba1f");
    e_player waittill(#"disconnect");
    self gameobjects::enable_object();
}

// Namespace namespace_e09822e3
// Params 2, eflags: 0x1 linked
// Checksum 0x36e43093, Offset: 0x1b70
// Size: 0x3de
function function_18df8595(var_79831c10, var_ff018680) {
    self endon(#"disconnect");
    self.var_1f4942ae = 1;
    var_b7677f7e = spawn("script_origin", var_79831c10.origin);
    var_b7677f7e playsound("evt_typing");
    var_ccaa2a98 = "p_security_cam_interface_point";
    var_f835fe4e = "p_security_cam_interface_exit";
    var_f05b3d6f = "p_security_cam_interface_idle";
    var_479668a = struct::get("s_security_cam_station_left", "targetname");
    var_479668a scene::play("p_security_cam_interface_intro", self);
    if (!level.var_ab82ba6d) {
        level notify(#"security_cam_active");
        self thread function_91e8303d(var_ff018680);
        level.var_ab82ba6d = 1;
        level thread namespace_21b2c1f2::function_e847067();
    }
    var_479668a thread scene::play(var_f05b3d6f, self);
    wait 2;
    while (!level.var_1a6eba1f) {
        self util::function_67cfce72(%CP_MI_ETH_PROLOGUE_CAMERA_CHANGE, undefined, undefined, -86);
        if (self actionbuttonpressed()) {
            self util::function_79f9f98d();
            self playlocalsound("evt_camera_scan_switch");
            level.var_d658503a++;
            if (level.var_d658503a >= level.var_c01222d2.size) {
                level.var_d658503a = 0;
            }
            if (level.var_d658503a == 4) {
                level flag::set("security_cam_full_house");
            }
            self thread function_a4090f73(level.var_d658503a);
            self function_d77b3165(var_ff018680);
            self function_941f1867(var_f05b3d6f, var_ccaa2a98, var_479668a);
            level flag::wait_till("face_scanning_complete");
            level flag::wait_till_clear("face_scanning_double_pause");
        }
        wait 0.05;
    }
    self thread function_a4090f73(level.var_d658503a);
    level thread namespace_21b2c1f2::function_973b77f9();
    level.var_1a6eba1f = 1;
    level notify(#"hash_1a6eba1f");
    t_regroup_security_camera = getent("t_regroup_security_camera", "targetname");
    t_regroup_security_camera triggerenable(1);
    var_b7677f7e delete();
    var_479668a scene::play(var_f835fe4e, self);
    function_396ce97e();
    self.var_1f4942ae = undefined;
}

// Namespace namespace_e09822e3
// Params 1, eflags: 0x1 linked
// Checksum 0xad920fbe, Offset: 0x1f58
// Size: 0xa2
function function_d77b3165(var_ff018680) {
    foreach (player in level.players) {
        player clientfield::set_to_player("set_cam_lookat_object", level.var_d658503a);
    }
}

// Namespace namespace_e09822e3
// Params 3, eflags: 0x1 linked
// Checksum 0x176f0e8, Offset: 0x2008
// Size: 0x1a6
function function_d8d1298e(str_name, str_scene, var_b5991f0e) {
    if (!isdefined(var_b5991f0e)) {
        var_b5991f0e = 0;
    }
    var_1ca98eed = spawnstruct();
    var_1ca98eed.str_name = str_name;
    var_1ca98eed.n_index = level.var_c01222d2.size;
    var_1ca98eed.b_vo_played = 0;
    var_1ca98eed.var_b5991f0e = var_b5991f0e;
    var_1ca98eed.str_scene = str_scene;
    var_1ca98eed.var_2cc1a0a1 = 1;
    var_1ca98eed.var_a1a1b35e = scene::get_actor_count(str_scene);
    level scene::add_scene_func(str_scene, &function_c41806ee, "init", var_1ca98eed.n_index);
    level scene::add_scene_func(str_scene, &function_48f438fd, "init");
    level scene::init(str_scene);
    if (var_b5991f0e) {
        var_1ca98eed.var_2cc1a0a1 = 0;
        var_1ca98eed.var_a1a1b35e = 0;
    }
    level.var_c01222d2[str_name] = var_1ca98eed;
}

// Namespace namespace_e09822e3
// Params 2, eflags: 0x1 linked
// Checksum 0xad926ef5, Offset: 0x21b8
// Size: 0x144
function function_c41806ee(a_ents, n_index) {
    if (!isdefined(a_ents["prisoner"])) {
        return;
    }
    var_a668bada = n_index - 1;
    while (!isdefined(level.var_d658503a) || level.var_d658503a < var_a668bada) {
        wait 0.05;
    }
    a_ents["prisoner"] sethighdetail(1);
    a_ents["prisoner"].var_d3b49c28 = createstreamerhint(a_ents["prisoner"].origin, 1);
    while (level.var_d658503a <= n_index) {
        wait 0.05;
    }
    a_ents["prisoner"] sethighdetail(0);
    a_ents["prisoner"].var_d3b49c28 delete();
}

// Namespace namespace_e09822e3
// Params 1, eflags: 0x1 linked
// Checksum 0xfd16c625, Offset: 0x2308
// Size: 0x10a
function function_48f438fd(a_ents) {
    util::wait_network_frame();
    foreach (ent in a_ents) {
        if (ent.model === "tag_origin") {
            n_index = function_5e3416f2(self.scriptbundlename).n_index;
            if (n_index == 0) {
                n_index = 9;
            }
            ent clientfield::set("update_camera_position", n_index);
        }
    }
}

// Namespace namespace_e09822e3
// Params 1, eflags: 0x1 linked
// Checksum 0x8d32ed44, Offset: 0x2420
// Size: 0x98
function function_6840a15e(n_index) {
    foreach (var_1ca98eed in level.var_c01222d2) {
        if (var_1ca98eed.n_index == n_index) {
            return var_1ca98eed;
        }
    }
}

// Namespace namespace_e09822e3
// Params 1, eflags: 0x1 linked
// Checksum 0xb5d49e9b, Offset: 0x24c0
// Size: 0x98
function function_5e3416f2(str_scene) {
    foreach (var_1ca98eed in level.var_c01222d2) {
        if (var_1ca98eed.str_scene === str_scene) {
            return var_1ca98eed;
        }
    }
}

// Namespace namespace_e09822e3
// Params 1, eflags: 0x1 linked
// Checksum 0x5685ba0a, Offset: 0x2560
// Size: 0x104
function function_91e8303d(var_eb217593) {
    hidemiscmodels("security_decal_prop");
    foreach (e_player in level.activeplayers) {
        e_player clientfield::set_to_player("turn_on_multicam", var_eb217593);
    }
    level.var_d658503a = 0;
    self clientfield::set_to_player("set_cam_lookat_object", level.var_d658503a);
    level clientfield::set("toggle_security_camera_pbg_bank", 1);
}

// Namespace namespace_e09822e3
// Params 3, eflags: 0x1 linked
// Checksum 0x21ddf003, Offset: 0x2670
// Size: 0x1b4
function function_941f1867(var_f05b3d6f, var_ccaa2a98, var_479668a) {
    self endon(#"disconnect");
    var_1ca98eed = function_6840a15e(level.var_d658503a);
    if (level.var_d658503a > 0) {
        var_5b1f7665 = function_6840a15e(level.var_d658503a - 1);
        if (isdefined(var_5b1f7665.str_scene) && !var_5b1f7665.var_b5991f0e) {
            scene::stop(var_5b1f7665.str_scene, 1);
        }
    }
    if (isdefined(var_1ca98eed.str_scene) && !var_1ca98eed.var_b5991f0e) {
        level thread scene::play(var_1ca98eed.str_scene);
    }
    level thread function_2e16b263(var_1ca98eed.str_scene);
    var_378c281e = self function_95e6066a(level.var_d658503a);
    if (var_378c281e) {
        var_479668a scene::play(var_ccaa2a98, self);
        var_479668a thread scene::play(var_f05b3d6f, self);
        function_9f9f8c2a();
    }
}

// Namespace namespace_e09822e3
// Params 1, eflags: 0x1 linked
// Checksum 0x871f2b23, Offset: 0x2830
// Size: 0x306
function function_2e16b263(scenename) {
    level notify(#"hash_1b4c750");
    level endon(#"hash_1b4c750");
    if (!isdefined(level.var_cc008929)) {
        level.var_cc008929 = spawn("script_origin", (0, 0, 0));
        level.isfirsttime = 1;
    }
    switch (scenename) {
    case "cin_pro_05_02_securitycam_pip_solitary":
        level.var_cc008929 playloopsound("evt_securitycam_solitary", 0.1);
        break;
    case "cin_pro_05_02_securitycam_pip_pipe":
        level.var_cc008929 playloopsound("evt_securitycam_pipe", 0.1);
        break;
    case "cin_pro_05_02_securitycam_pip_funnel":
        level.var_cc008929 playloopsound("evt_securitycam_funnel", 0.1);
        break;
    case "cin_pro_05_02_securitycam_pip_branding":
        level.var_cc008929 playloopsound("evt_securitycam_branding", 0.1);
        break;
    case "cin_pro_05_02_securitycam_pip_pressure":
        level.var_cc008929 playloopsound("evt_securitycam_pressure", 0.1);
        break;
    case "cin_pro_05_02_securitycam_pip_waterboard":
        level.var_cc008929 stoploopsound(0.1);
        level.var_cc008929 playsound("evt_securitycam_minister_water");
        break;
    case "cin_pro_05_02_securitycam_pip_ministerdrag":
        level.var_cc008929 stoploopsound(0.1);
        level.var_cc008929 playsound("evt_securitycam_minister_walk");
        break;
    case "cin_pro_05_02_securitycam_pip_ministerdrag_interrogationroom":
        if (isdefined(level.isfirsttime) && level.isfirsttime) {
            level.var_cc008929 stoploopsound(0.1);
            level.isfirsttime = 0;
        } else {
            level.var_cc008929 stoploopsound(0.1);
            level.var_cc008929 playsound("evt_securitycam_minister_sit");
        }
        break;
    default:
        level.var_cc008929 stoploopsound(0.1);
        level.var_cc008929 stopsounds();
        break;
    }
}

// Namespace namespace_e09822e3
// Params 1, eflags: 0x1 linked
// Checksum 0x838fdc8f, Offset: 0x2b40
// Size: 0xbe
function function_95e6066a(var_ff018680) {
    self endon(#"disconnect");
    level flag::clear("face_scanning_complete");
    var_1ca98eed = function_6840a15e(var_ff018680);
    if (var_1ca98eed.var_a1a1b35e == 0) {
        wait 2;
        return 0;
    }
    wait 0.5;
    level flag::wait_till("face_scanning_complete");
    if (level.var_d658503a == level.var_690ce961) {
        return 1;
    }
    return 0;
}

// Namespace namespace_e09822e3
// Params 1, eflags: 0x1 linked
// Checksum 0xbc33a74c, Offset: 0x2c08
// Size: 0x3b4
function function_a4090f73(var_6347c9e0) {
    if (!isdefined(level.var_965f8f82)) {
        level.var_965f8f82 = 1;
    }
    switch (var_6347c9e0) {
    case 0:
        wait 3;
        break;
    case 1:
        if (level.var_965f8f82) {
            level.var_965f8f82 = 0;
            wait 3;
        } else {
            level.var_2fd26037 dialog::say("hend_bingo_0", 5);
            level notify(#"hash_fd656b57");
        }
        break;
    case 2:
        level flag::wait_till("scanning_dialog_done");
        self dialog::say("plyr_other_hostages_i_0", 0.5);
        level.var_2fd26037 dialog::say("hend_so_did_i_0", 0.1);
        break;
    case 3:
        level.var_2fd26037 dialog::say("hend_poor_sons_of_bitches_0", 1);
        level.var_2fd26037 dialog::say("hend_the_nrc_are_known_fo_0", 0.5);
        break;
    case 4:
        level flag::set("face_scanning_double_pause");
        level waittill(#"hash_f35713c");
        level flag::set("face_scanning_complete");
        level.var_2fd26037 dialog::say("hend_check_the_next_feed_0", 0.5);
        level flag::clear("face_scanning_double_pause");
        break;
    case 5:
        self dialog::say("plyr_are_we_just_going_to_1", 0.25);
        level.var_2fd26037 dialog::say("hend_we_have_our_orders_0");
        break;
    case 6:
        wait 3;
        level.var_2fd26037 thread dialog::say("hend_no_match_0");
        break;
    case 7:
        level flag::set("face_scanning_double_pause");
        wait 3;
        level flag::set("face_scanning_complete");
        level.var_2fd26037 dialog::say("hend_that_s_him_the_min_0", 0.75);
        level.var_2fd26037 dialog::say("hend_he_s_being_moved_0", 9);
        level flag::clear("face_scanning_double_pause");
        break;
    case 8:
        level.var_2fd26037 dialog::say("hend_we_have_to_find_out_0", 0.5);
        break;
    default:
        break;
    }
    level flag::set("face_scanning_complete");
}

// Namespace namespace_e09822e3
// Params 0, eflags: 0x1 linked
// Checksum 0xbb9a55b5, Offset: 0x2fc8
// Size: 0x2c
function function_d0260dae() {
    level waittill(#"hash_dbfb4368");
    level flag::set("scanning_dialog_done");
}

// Namespace namespace_e09822e3
// Params 0, eflags: 0x1 linked
// Checksum 0x38e0e08b, Offset: 0x3000
// Size: 0x2ec
function function_240f41ef() {
    level flag::set("activate_bc_5");
    level flag::wait_till("stealth_kill_prepare_done");
    cp_prologue_util::function_d1f1caad("t_start_security_cam_room_breach_v2");
    level thread namespace_21b2c1f2::function_973b77f9();
    level notify(#"hash_fa5c41eb");
    exploder::exploder("light_exploder_cameraroom");
    level thread scene::add_scene_func("cin_pro_05_01_securitycam_1st_stealth_kill", &function_2b60c70b);
    level thread namespace_21b2c1f2::function_fd00a4f2();
    level scene::play("cin_pro_05_01_securitycam_1st_stealth_kill");
    level notify(#"hash_af8926a2");
    if (isdefined(level.var_13ef3f5a)) {
        level thread [[ level.var_13ef3f5a ]]();
    }
    level flag::set("everyone_in_camera_room");
    level notify(#"hash_8e1e9ee");
    level thread function_fef03d1c();
    exploder::stop_exploder("light_exploder_cameraroom");
    level waittill(#"security_cam_active");
    level scene::play("cin_pro_05_01_securitycam_1st_stealth_kill_scanning");
    level flag::wait_till("security_cam_full_house");
    level scene::play("cin_pro_05_01_securitycam_1st_stealth_kill_notice");
    level waittill(#"hash_fd656b57");
    level thread function_2e16b263("none");
    level scene::add_scene_func("cin_pro_05_01_securitycam_1st_stealth_kill_movetodoor", &function_8f6060f7, "play");
    level scene::play("cin_pro_05_01_securitycam_1st_stealth_kill_movetodoor");
    array::run_all(level.players, &util::function_16c71b8, 0);
    level flag::wait_till("player_past_security_room");
    level notify(#"hash_81d6c615");
    level scene::play("cin_pro_05_01_securitycam_1st_stealth_kill_exit");
    level flag::set("hendricks_exit_cam_room");
}

// Namespace namespace_e09822e3
// Params 1, eflags: 0x1 linked
// Checksum 0x90a640d6, Offset: 0x32f8
// Size: 0x34
function function_30b1de21(a_ents) {
    level waittill(#"hash_640b2018");
    level dialog::function_13b3b16a("plyr_ready_when_you_are_0");
}

// Namespace namespace_e09822e3
// Params 1, eflags: 0x1 linked
// Checksum 0xf22fb52d, Offset: 0x3338
// Size: 0x34
function function_8f6060f7(a_ents) {
    level waittill(#"hash_59303d35");
    level dialog::function_13b3b16a("plyr_you_sound_like_the_v_0");
}

// Namespace namespace_e09822e3
// Params 1, eflags: 0x1 linked
// Checksum 0x710108b5, Offset: 0x3378
// Size: 0x2c
function function_9887d555(a_ents) {
    level flag::set("stealth_kill_prepare_done");
}

// Namespace namespace_e09822e3
// Params 1, eflags: 0x1 linked
// Checksum 0x9110d549, Offset: 0x33b0
// Size: 0xfc
function function_d6557dc4(a_ents) {
    a_ents["stealth_kill_pistol"] hide();
    level waittill(#"hash_7b2fc2a1");
    a_ents["stealth_kill_pistol"] show();
    util::wait_network_frame();
    util::wait_network_frame();
    a_ents["hendricks"] detach("c_hro_hendricks_prologue_cin_gunprop_fb");
    level waittill(#"hash_4b566398");
    a_ents["hendricks"] attach("c_hro_hendricks_prologue_cin_gunprop_fb");
    a_ents["stealth_kill_pistol"] hide();
}

// Namespace namespace_e09822e3
// Params 1, eflags: 0x1 linked
// Checksum 0x2743cf56, Offset: 0x34b8
// Size: 0x21c
function function_2b60c70b(a_ents) {
    level waittill(#"hash_55529da");
    var_fc54e080 = getent("security_control_room_blocker", "targetname");
    var_fc54e080 notsolid();
    var_3c301126 = getent("security_camera_door_r", "targetname");
    var_280d5f68 = getent("security_camera_door_l", "targetname");
    var_280d5f68 movey(52, 0.75, 0.25, 0);
    var_3c301126 movey(52 * -1, 0.75, 0.25, 0);
    playsoundatposition("evt_securityroom_door_open", (3464, -313, -263));
    level waittill(#"hash_cfa80fd0");
    trigger::wait_till("close_security_door_trig");
    var_fc54e080 solid();
    var_280d5f68 movey(52 * -1, 0.75, 0.25, 0);
    var_3c301126 movey(52, 0.75, 0.25, 0);
    playsoundatposition("evt_securityroom_door_close", (3464, -313, -263));
}

// Namespace namespace_e09822e3
// Params 0, eflags: 0x1 linked
// Checksum 0x5c29f797, Offset: 0x36e0
// Size: 0x5c
function function_fef03d1c() {
    level endon(#"security_cam_active");
    wait 15;
    level.var_2fd26037 dialog::say("hend_you_wanna_hustle_ha_0");
    wait 20;
    level.var_2fd26037 dialog::say("hend_our_cover_s_blown_an_0");
}

// Namespace namespace_e09822e3
// Params 0, eflags: 0x1 linked
// Checksum 0x1b68c0ad, Offset: 0x3748
// Size: 0x64
function function_61e4fa9() {
    level endon(#"hash_fa5c41eb");
    level waittill(#"hash_6edff9b0");
    level.var_2fd26037 dialog::say("hend_you_ve_got_breach_l_0");
    wait 20;
    level.var_2fd26037 dialog::say("hend_minister_s_not_gonna_0");
}

