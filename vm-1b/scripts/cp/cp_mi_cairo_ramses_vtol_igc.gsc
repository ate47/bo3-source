#using scripts/codescripts/struct;
#using scripts/cp/_dialog;
#using scripts/cp/_load;
#using scripts/cp/_objectives;
#using scripts/cp/_oed;
#using scripts/cp/_skipto;
#using scripts/cp/_spawn_manager;
#using scripts/cp/_util;
#using scripts/cp/cp_mi_cairo_ramses2_fx;
#using scripts/cp/cp_mi_cairo_ramses2_sound;
#using scripts/cp/cp_mi_cairo_ramses_quad_tank_plaza;
#using scripts/cp/cp_mi_cairo_ramses_utility;
#using scripts/cp/gametypes/_battlechatter;
#using scripts/shared/ai_shared;
#using scripts/shared/array_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/colors_shared;
#using scripts/shared/compass;
#using scripts/shared/exploder_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/fx_shared;
#using scripts/shared/gameobjects_shared;
#using scripts/shared/hud_util_shared;
#using scripts/shared/math_shared;
#using scripts/shared/objpoints_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/trigger_shared;
#using scripts/shared/turret_shared;
#using scripts/shared/util_shared;
#using scripts/shared/vehicle_ai_shared;
#using scripts/shared/vehicle_shared;
#using scripts/shared/vehicles/_raps;

#namespace vtol_igc;

// Namespace vtol_igc
// Params 1, eflags: 0x0
// Checksum 0x8efc2c39, Offset: 0xc58
// Size: 0x7a
function function_f72dae68(var_74cd64bc) {
    if (!isdefined(var_74cd64bc)) {
        var_74cd64bc = 0;
    }
    precache();
    level flag::init("vtol_igc_robots_alerted");
    level flag::init("vtol_igc_robots_dead");
    level flag::init("hendricks_at_vtol_igc");
    function_4e0519ce(var_74cd64bc);
}

// Namespace vtol_igc
// Params 0, eflags: 0x0
// Checksum 0xe9c07cd6, Offset: 0xce0
// Size: 0x2
function precache() {
    
}

// Namespace vtol_igc
// Params 0, eflags: 0x0
// Checksum 0x863d381f, Offset: 0xcf0
// Size: 0x18b
function function_fc9630cb() {
    var_b0c95322 = getentarray("hide_me", "script_noteworthy");
    foreach (var_ee522bae in var_b0c95322) {
        if (isdefined(var_ee522bae)) {
            var_ee522bae hide();
        }
    }
    var_b0c95322 = getentarray("hide_vtol_robots", "script_noteworthy");
    foreach (var_ee522bae in var_b0c95322) {
        if (isdefined(var_ee522bae)) {
            var_ee522bae hide();
        }
    }
    var_2e9e64b6 = getentarray("alley_bridge_destroyed", "targetname");
    foreach (var_12061b40 in var_2e9e64b6) {
        var_12061b40 hide();
    }
}

// Namespace vtol_igc
// Params 1, eflags: 0x0
// Checksum 0x242d4a5c, Offset: 0xe88
// Size: 0x59a
function function_4e0519ce(var_74cd64bc) {
    if (!isdefined(var_74cd64bc)) {
        var_74cd64bc = 0;
    }
    level thread function_f3a727ef();
    level thread function_35210922();
    level notify(#"hash_57a23805");
    level thread function_31a2724a();
    level thread function_3659e172();
    var_e8fa0050 = spawn("script_origin", (8190, -16469, 418));
    var_9cf50b7e = spawn("script_origin", (7934, -15639, 351));
    var_e8fa0050 playloopsound("evt_outside_battle_l", 0.25);
    var_9cf50b7e playloopsound("evt_outside_battle_r", 0.25);
    array::run_all(getentarray("lgt_vtol_block", "targetname"), &hide);
    if (!var_74cd64bc) {
        level scene::init("cin_ram_06_05_safiya_1st_friendlydown_init");
    }
    util::wait_network_frame();
    level scene::init("cin_ram_06_05_safiya_aie_breakin_pilotshoots");
    scene::add_scene_func("cin_ram_06_05_safiya_1st_friendlydown", &function_e78f7ba0, "play");
    scene::add_scene_func("cin_ram_06_05_safiya_1st_friendlydown", &vtol_igc_done, "done");
    var_99b57ecf = getent("trig_use_vtol_igc", "targetname");
    var_99b57ecf setinvisibletoall();
    util::wait_network_frame();
    level thread function_db3c9568();
    trigger::wait_till("trig_spawn_vtol_igc");
    objectives::complete("cp_level_ramses_go_to_safiya");
    level thread function_6cbfd0c6();
    quad_tank_plaza::function_ffea6b5();
    level thread function_a2be882d();
    level thread function_baa2531();
    spawner::waittill_ai_group_cleared("vtol_robots");
    level flag::set("vtol_igc_robots_dead");
    level.var_2fd26037 thread function_a64605e5();
    level thread util::function_d8eaed3d(3);
    level scene::init("cin_ram_06_05_safiya_1st_friendlydown");
    level flag::wait_till("hendricks_at_vtol_igc");
    var_99b57ecf setvisibletoall();
    var_12cc0227 = util::function_14518e76(var_99b57ecf, %cp_level_ramses_vtol_use, %CP_MI_CAIRO_RAMSES_VTOL_IGC_TRIG, &function_468dd319);
    level flag::wait_till("vtol_igc_trigger_used");
    if (isdefined(level.var_3211f2c6)) {
        level thread [[ level.var_3211f2c6 ]]();
    }
    objectives::complete("cp_level_ramses_vtol_use");
    var_e8fa0050 stoploopsound(2);
    var_9cf50b7e stoploopsound(2);
    level util::clientnotify("vtligc");
    level thread namespace_a6a248fc::function_bb3105cf();
    battlechatter::function_d9f49fba(0);
    var_12cc0227 gameobjects::destroy_object();
    level thread function_6ee65e7a();
    var_1cad09db = getentarray("alley_egypt_intro_guy_ai", "targetname");
    foreach (var_5abbae22 in var_1cad09db) {
        var_5abbae22 delete();
    }
    var_d63952d7 = getentarray("alley_egypt_mid_guy_ai", "targetname");
    foreach (var_5abbae22 in var_d63952d7) {
        var_5abbae22 delete();
    }
    level flag::wait_till("vtol_igc_done");
    var_e8fa0050 delete();
    var_9cf50b7e delete();
    level util::clientnotify("pst");
    skipto::function_be8adfb8("vtol_igc");
}

// Namespace vtol_igc
// Params 1, eflags: 0x0
// Checksum 0xb96fd25a, Offset: 0x1430
// Size: 0x5a
function function_6ee65e7a(a_ents) {
    level waittill(#"hash_8456258f");
    var_dfcbd82b = getnode("qtp_hendricks_start_node", "targetname");
    level.var_2fd26037 setgoal(var_dfcbd82b, 0, 32);
}

// Namespace vtol_igc
// Params 1, eflags: 0x0
// Checksum 0xa2094ddd, Offset: 0x1498
// Size: 0x112
function function_2e3a3b68(a_ents) {
    var_2aa82b86 = a_ents["cin_ram_06_05_safiya_1st_friendlydown_vtol01"];
    str_model = "veh_t7_mil_vtol_egypt_nose_glass_d1";
    var_2aa82b86 function_1e5c6903(1, "");
    var_2aa82b86 function_1e5c6903(0, "_d1");
    var_2aa82b86 function_1e5c6903(1, "_d2");
    var_2aa82b86 hidepart("tag_glass4_d3_animate", str_model, 1);
    level waittill(#"hash_495be65c");
    var_2aa82b86 function_1e5c6903(1, "_d1");
    var_2aa82b86 function_1e5c6903(0, "_d2");
    level waittill(#"hash_6f5e60c5");
    var_2aa82b86 hidepart("tag_glass4_d2_animate", str_model, 1);
    var_2aa82b86 showpart("tag_glass4_d3_animate", str_model, 1);
}

// Namespace vtol_igc
// Params 2, eflags: 0x0
// Checksum 0x7262b769, Offset: 0x15b8
// Size: 0x1d2
function function_1e5c6903(b_hide, str_state) {
    if (!isdefined(b_hide)) {
        b_hide = 1;
    }
    if (!isdefined(str_state)) {
        str_state = "";
    }
    str_model = "veh_t7_mil_vtol_egypt_nose_glass_d1";
    if (b_hide) {
        self hidepart("tag_glass" + str_state + "_animate", str_model, 1);
        self hidepart("tag_glass1" + str_state + "_animate", str_model, 1);
        self hidepart("tag_glass2" + str_state + "_animate", str_model, 1);
        self hidepart("tag_glass3" + str_state + "_animate", str_model, 1);
        self hidepart("tag_glass4" + str_state + "_animate", str_model, 1);
        self hidepart("tag_glass5" + str_state + "_animate", str_model, 1);
        return;
    }
    self showpart("tag_glass" + str_state + "_animate", str_model, 1);
    self showpart("tag_glass1" + str_state + "_animate", str_model, 1);
    self showpart("tag_glass2" + str_state + "_animate", str_model, 1);
    self showpart("tag_glass3" + str_state + "_animate", str_model, 1);
    self showpart("tag_glass4" + str_state + "_animate", str_model, 1);
    self showpart("tag_glass5" + str_state + "_animate", str_model, 1);
}

// Namespace vtol_igc
// Params 0, eflags: 0x0
// Checksum 0x6d7a1ec6, Offset: 0x1798
// Size: 0x1e9
function function_3659e172() {
    var_4e03b768 = struct::get("vtol_objective");
    objectives::set("cp_waypoint_breadcrumb", var_4e03b768);
    level waittill(#"hash_ca2d8f8");
    objectives::hide("cp_waypoint_breadcrumb");
    while (!level flag::get("vtol_igc_robots_dead")) {
        wait 0.5;
        foreach (player in level.activeplayers) {
            if (!isdefined(player.var_fbf99626)) {
                player.var_fbf99626 = 0;
            }
            if (distance(var_4e03b768.origin, player.origin) > 1000) {
                if (player.var_fbf99626 == 0) {
                    objectives::show("cp_waypoint_breadcrumb", player);
                    player.var_fbf99626 = 1;
                }
                continue;
            }
            if (player.var_fbf99626 == 1) {
                objectives::hide("cp_waypoint_breadcrumb", player);
                player.var_fbf99626 = 0;
            }
        }
    }
    objectives::complete("cp_waypoint_breadcrumb", var_4e03b768);
    foreach (player in level.players) {
        player.var_fbf99626 = undefined;
    }
}

// Namespace vtol_igc
// Params 1, eflags: 0x0
// Checksum 0x396fbefc, Offset: 0x1990
// Size: 0x7a
function function_468dd319(e_player) {
    level flag::set("vtol_igc_trigger_used");
    scene::add_scene_func("cin_ram_06_05_safiya_1st_friendlydown", &function_2e3a3b68, "play");
    level thread scene::play("cin_ram_06_05_safiya_1st_friendlydown", e_player);
    self gameobjects::disable_object();
}

// Namespace vtol_igc
// Params 1, eflags: 0x0
// Checksum 0x2c519c7, Offset: 0x1a18
// Size: 0x102
function function_f3a727ef(var_bd047092) {
    if (!isdefined(var_bd047092)) {
        var_bd047092 = 0;
    }
    level flag::init("vtol_igc_started");
    ramses_util::function_ac2b4535("cin_ram_06_05_safiya_1st_friendlydown", "vtol_igc_teleport");
    scene::add_scene_func("cin_ram_06_05_safiya_1st_friendlydown", &vtol_igc_started, "play");
    level thread function_c6b9db();
    exploder::exploder("fx_expl_vtol_int");
    if (!var_bd047092) {
        level thread function_fc1660c3();
        exploder::exploder("fx_expl_igc_vtol_ext_smoke");
        level thread function_33108db5();
    }
    level thread function_c887803();
    level thread function_85f7b3f4();
}

// Namespace vtol_igc
// Params 1, eflags: 0x0
// Checksum 0x8728765d, Offset: 0x1b28
// Size: 0x62
function vtol_igc_started(a_ents) {
    level flag::set("vtol_igc_started");
    array::run_all(getentarray("lgt_vtol_block", "targetname"), &show);
}

// Namespace vtol_igc
// Params 1, eflags: 0x0
// Checksum 0xd3bd4589, Offset: 0x1b98
// Size: 0x102
function function_e78f7ba0(a_ents) {
    level waittill(#"hash_1560247e");
    showmiscmodels("qtp_vtol_nose");
    var_2ef9d306 = a_ents["cin_ram_06_05_safiya_1st_friendlydown_vtol01"];
    var_2ef9d306 hidepart("tag_nose_animate", "veh_t7_mil_vtol_egypt_igc_nose", 1);
    var_2ef9d306 hidepart("tag_nose_animate", "veh_t7_mil_vtol_egypt_cockpit_d0", 1);
    var_2ef9d306 hidepart("tag_nose_animate", "veh_t7_mil_vtol_egypt_nose_d1", 1);
    var_2ef9d306 hidepart("tag_nose_animate", "veh_t7_mil_vtol_egypt_nose_glass_d1", 1);
    var_2ef9d306 hidepart("tag_nose_animate", "veh_t7_mil_vtol_egypt_nose_d0", 1);
    var_2ef9d306 hidepart("tag_nose_animate", "veh_t7_mil_vtol_egypt_screens_d1", 1);
}

// Namespace vtol_igc
// Params 1, eflags: 0x0
// Checksum 0x3dc5d709, Offset: 0x1ca8
// Size: 0x8a
function vtol_igc_done(a_ents) {
    level flag::set("vtol_igc_done");
    exploder::exploder_stop("fx_expl_qtplaza_hotel");
    array::run_all(getentarray("lgt_vtol_block", "targetname"), &hide);
    util::clear_streamer_hint();
}

// Namespace vtol_igc
// Params 0, eflags: 0x0
// Checksum 0x5406a54d, Offset: 0x1d40
// Size: 0x4a
function function_db3c9568() {
    scene::add_scene_func("cin_ram_06_05_safiya_aie_breakin_02", &function_9cafdc73, "init");
    level thread scene::init("cin_ram_06_05_safiya_aie_breakin_02");
}

// Namespace vtol_igc
// Params 0, eflags: 0x0
// Checksum 0x93c9378a, Offset: 0x1d98
// Size: 0x8a
function function_baa2531() {
    scene::add_scene_func("cin_ram_06_05_safiya_aie_breakin_pilotshoots", &function_c4dc56eb, "done");
    a_flags = [];
    a_flags[0] = "player_looking_at_vtol_igc";
    a_flags[1] = "vtol_igc_robots_alerted";
    level flag::wait_till_any(a_flags);
    level notify(#"hash_ca2d8f8");
    level scene::play("cin_ram_06_05_safiya_aie_breakin_pilotshoots");
}

// Namespace vtol_igc
// Params 1, eflags: 0x0
// Checksum 0xd579749f, Offset: 0x1e30
// Size: 0xc3
function function_c4dc56eb(a_ents) {
    a_keys = getarraykeys(a_ents);
    foreach (str_key in a_keys) {
        if (issubstr(str_key, "robot")) {
            var_f6c5842 = a_ents[str_key];
            if (isalive(var_f6c5842)) {
                var_f6c5842 kill();
            }
        }
    }
}

// Namespace vtol_igc
// Params 0, eflags: 0x0
// Checksum 0x38c38eb1, Offset: 0x1f00
// Size: 0x92
function function_a2be882d() {
    level.var_2fd26037 ai::set_ignoreall(1);
    nd_start = getnode("vtol_igc_hendricks_start", "targetname");
    wait 1;
    level.var_2fd26037 ai::force_goal(nd_start);
    level flag::wait_till("vtol_igc_robots_alerted");
    level.var_2fd26037 ai::set_ignoreall(0);
}

// Namespace vtol_igc
// Params 1, eflags: 0x0
// Checksum 0xdc911c75, Offset: 0x1fa0
// Size: 0x9b
function function_9cafdc73(a_ents) {
    a_keys = getarraykeys(a_ents);
    foreach (str_key in a_keys) {
        if (issubstr(str_key, "robot")) {
            a_ents[str_key] thread function_e9454b97();
        }
    }
}

// Namespace vtol_igc
// Params 0, eflags: 0x0
// Checksum 0xa544a0be, Offset: 0x2048
// Size: 0xc3
function function_e9454b97() {
    self endon(#"death");
    level endon(#"hash_d1ac8f57");
    self thread function_bc906046();
    self util::waittill_any("damage", "bulletwhizby", "pain", "proximity", "player_near_vtol_igc");
    level flag::set("vtol_igc_robots_alerted");
    level thread scene::play("cin_ram_06_05_safiya_aie_breakin_02");
    level.var_2fd26037 ai::set_ignoreall(0);
    trigger::use("trig_spawn_vtol_igc");
    level notify(#"hash_d1ac8f57");
}

// Namespace vtol_igc
// Params 0, eflags: 0x0
// Checksum 0xfde3324c, Offset: 0x2118
// Size: 0x33
function function_bc906046() {
    self endon(#"death");
    trigger::wait_till("vtol_igc_near_robots", "targetname");
    self notify(#"player_near_vtol_igc");
}

// Namespace vtol_igc
// Params 0, eflags: 0x0
// Checksum 0x13a2556d, Offset: 0x2158
// Size: 0x22
function function_a64605e5() {
    self waittill(#"hash_2af7f4a0");
    level flag::set("hendricks_at_vtol_igc");
}

// Namespace vtol_igc
// Params 0, eflags: 0x0
// Checksum 0x3da89c2e, Offset: 0x2188
// Size: 0x1a
function function_c6b9db() {
    level waittill(#"hash_30c9a209");
    level thread quad_tank_plaza::function_5a4025b4();
}

// Namespace vtol_igc
// Params 0, eflags: 0x0
// Checksum 0xecf3184c, Offset: 0x21b0
// Size: 0xaa
function function_85f7b3f4() {
    level flag::wait_till("vtol_igc_started");
    s_scene = struct::get("truck_flip_vtol", "targetname");
    s_scene thread scene::init();
    level waittill(#"hash_c4f59e60");
    s_scene thread scene::play();
    level waittill(#"hash_67926c8d");
    var_5abbae22 = getent("cin_ram_06_05_safiya_1st_friendlydown_guy06", "targetname");
    var_5abbae22 delete();
}

// Namespace vtol_igc
// Params 0, eflags: 0x0
// Checksum 0x1f8ff1c4, Offset: 0x2268
// Size: 0x1a
function function_c887803() {
    level waittill(#"hash_3eedd8a9");
    quad_tank_plaza::function_899f8822();
}

// Namespace vtol_igc
// Params 0, eflags: 0x0
// Checksum 0xa3f51ced, Offset: 0x2290
// Size: 0x22
function function_33108db5() {
    level waittill(#"hash_33108db5");
    exploder::exploder_stop("fx_expl_igc_vtol_ext_smoke");
}

// Namespace vtol_igc
// Params 0, eflags: 0x0
// Checksum 0x545f2241, Offset: 0x22c0
// Size: 0x22
function function_fc1660c3() {
    level waittill(#"hash_fc1660c3");
    exploder::exploder_stop("fx_expl_vtol_int");
}

// Namespace vtol_igc
// Params 0, eflags: 0x0
// Checksum 0x58cc22f3, Offset: 0x22f0
// Size: 0x252
function function_35210922() {
    var_2ef9d306 = undefined;
    while (!isdefined(var_2ef9d306)) {
        var_2ef9d306 = getent("cin_ram_06_05_safiya_1st_friendlydown_vtol01", "targetname");
        wait 1;
    }
    var_633b96c9 = array("veh_t7_mil_vtol_egypt_igc_nose", "veh_t7_mil_vtol_egypt_int_slice");
    foreach (str_part in var_633b96c9) {
        var_2ef9d306 hidepart("tag_wing_left_animate", str_part, 1);
        var_2ef9d306 hidepart("tag_wing_right_animate", str_part, 1);
        var_2ef9d306 hidepart("tag_wing_l_midbreak_animate", str_part, 1);
        var_2ef9d306 hidepart("tag_wing_r_midbreak_animate", str_part, 1);
    }
    var_43807dc4 = getentarray("vtol_cockpit_probe", "script_noteworthy");
    foreach (var_133e9095 in var_43807dc4) {
        var_133e9095 linkto(var_2ef9d306, "tag_cockpit_lgt");
    }
    var_2ef9d306 hidepart("tag_console_center_screen_animate_d0", "veh_t7_mil_vtol_egypt_cockpit_d0");
    var_2ef9d306 hidepart("tag_console_left_screen_animate_d0", "veh_t7_mil_vtol_egypt_cockpit_d0");
    var_2ef9d306 hidepart("tag_console_right_screen_animate_d0", "veh_t7_mil_vtol_egypt_cockpit_d0");
    var_2ef9d306 attach("veh_t7_mil_vtol_egypt_screens_d1", "tag_nose_animate");
    var_2ef9d306 attach("veh_t7_mil_vtol_egypt_cabin_details_attch", "tag_body_animate");
    var_2ef9d306 notsolid();
}

// Namespace vtol_igc
// Params 0, eflags: 0x0
// Checksum 0xb7cc32c4, Offset: 0x2550
// Size: 0x32
function function_31a2724a() {
    level flag::wait_till("all_players_spawned");
    wait 1;
    level util::clientnotify("pres");
}

// Namespace vtol_igc
// Params 0, eflags: 0x0
// Checksum 0xc508834e, Offset: 0x2590
// Size: 0x112
function function_6cbfd0c6() {
    var_a7d1013f = getent("trig_hendricks_sees_vtol", "targetname");
    while (true) {
        var_a7d1013f trigger::wait_till();
        if (var_a7d1013f.who === level.var_2fd26037 || isplayer(var_a7d1013f.who)) {
            break;
        }
    }
    level.var_2fd26037 dialog::say("hend_kane_we_got_a_frie_0", 0.5);
    level dialog::remote("kane_scanning_for_lifesig_0");
    var_239be310 = getent("cin_ram_06_05_safiya_1st_friendlydown_guy01", "targetname");
    var_239be310 dialog::say("plyr_screams_from_inside_0");
    level dialog::function_13b3b16a("plyr_that_s_lifesign_enou_0");
}

