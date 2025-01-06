#using scripts/codescripts/struct;
#using scripts/cp/_debug;
#using scripts/cp/_dialog;
#using scripts/cp/_hazard;
#using scripts/cp/_load;
#using scripts/cp/_objectives;
#using scripts/cp/_skipto;
#using scripts/cp/_spawn_manager;
#using scripts/cp/_util;
#using scripts/cp/cp_mi_cairo_aquifer_ambience;
#using scripts/cp/cp_mi_cairo_aquifer_objectives;
#using scripts/cp/cp_mi_cairo_aquifer_sound;
#using scripts/cp/cp_mi_cairo_aquifer_utility;
#using scripts/cp/gametypes/_save;
#using scripts/shared/ai/systems/ai_interface;
#using scripts/shared/ai_shared;
#using scripts/shared/animation_shared;
#using scripts/shared/array_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/colors_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/fx_shared;
#using scripts/shared/hud_shared;
#using scripts/shared/lui_shared;
#using scripts/shared/math_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/trigger_shared;
#using scripts/shared/util_shared;

#namespace cp_mi_cairo_aquifer_water_room;

// Namespace cp_mi_cairo_aquifer_water_room
// Params 0, eflags: 0x0
// Checksum 0xcdbbfae2, Offset: 0xdc8
// Size: 0x11a
function main() {
    level._effect["emp_flash"] = "_t6/weapon/emp/fx_emp_explosion";
    thread init_flags();
    thread function_60f7b1b6();
    thread function_1ecf48ef();
    thread function_4a90c357();
    thread function_ee430caa();
    thread function_a1b52577();
    thread function_18af354a();
    spawner::add_spawn_function_group("water_robots", "targetname", &function_a527e6f9);
    spawner::add_spawn_function_group("water_robots2", "targetname", &function_a527e6f9);
    spawner::add_spawn_function_group("water_robots3", "targetname", &function_a527e6f9);
}

// Namespace cp_mi_cairo_aquifer_water_room
// Params 0, eflags: 0x0
// Checksum 0x9c3fbe26, Offset: 0xef0
// Size: 0x62
function init_flags() {
    level flag::init("flag_kayne_ready_trap");
    level flag::init("door_explodes");
    level flag::init("flag_door_explodes");
    level flag::init("flag_double_doors_open");
}

// Namespace cp_mi_cairo_aquifer_water_room
// Params 0, eflags: 0x0
// Checksum 0xd64f7a7c, Offset: 0xf60
// Size: 0x8a
function function_60f7b1b6() {
    level endon(#"hash_ee3f7dc5");
    struct = getent("igc_kane_khalil_1", "targetname");
    level flag::wait_till("flag_kayne_pre_water");
    wait 6;
    struct scene::play("cin_aqu_03_19_pre_water_room_kane", level.var_89ea8991);
    struct scene::play("cin_aqu_03_19_pre_water_room_wait_kane", level.var_89ea8991);
}

// Namespace cp_mi_cairo_aquifer_water_room
// Params 0, eflags: 0x0
// Checksum 0x641a2188, Offset: 0xff8
// Size: 0x2ca
function function_1ecf48ef() {
    level endon(#"hash_47f08523");
    scene::add_scene_func("cin_aqu_05_01_enter_1st_look", &function_3d8a313e, "play");
    scene::init("cin_aqu_05_01_enter_1st_look");
    level waittill(#"hash_7e64f485");
    var_5b5cfed1 = trigger::wait_till("water_room_igc");
    struct = getent("igc_kane_khalil_1", "targetname");
    level notify(#"hash_ee3f7dc5");
    if (isdefined(level.var_e45bdc20)) {
        level thread [[ level.var_e45bdc20 ]]();
    }
    if (isdefined(level.var_89ea8991) && isalive(level.var_89ea8991)) {
        level.var_89ea8991 delete();
    }
    namespace_84eb777e::function_b3ed487d(1);
    exploder::exploder_stop("lighting_server_perf_lights");
    function_cd377710();
    struct scene::play("cin_aqu_05_01_enter_1st_look", var_5b5cfed1.who);
    namespace_84eb777e::function_61034146(0);
    level flag::set("inside_water_room");
    util::function_93831e79("igc_enter_water_structs");
    level.var_89ea8991 namespace_84eb777e::function_30343b22("kayne_waterroom_swim");
    level.var_89ea8991 thread function_8fdcc95b(1);
    savegame::checkpoint_save();
    setdvar("player_swimSpeed", 80);
    if (isdefined(level.var_dcefc59)) {
        level thread [[ level.var_dcefc59 ]]();
    }
    foreach (p in level.players) {
        p thread function_913d882();
    }
    thread function_645f7873();
    thread function_408f0fb5();
    struct scene::play("cin_aqu_03_20_water_room", level.var_89ea8991);
    struct thread scene::play("cin_aqu_03_20_water_room_idle", level.var_89ea8991);
}

// Namespace cp_mi_cairo_aquifer_water_room
// Params 0, eflags: 0x0
// Checksum 0xd91d3361, Offset: 0x12d0
// Size: 0xe3
function function_cd377710() {
    foreach (player in level.activeplayers) {
        if (isdefined(player getlinkedent())) {
            player.var_8fedf36c notify(#"hash_c38e4003");
            player unlink();
            player.var_8fedf36c.state = undefined;
            player.var_8fedf36c clientfield::set("vtol_canopy_state", 0);
            player.var_8fedf36c clientfield::set("vtol_enable_wash_fx", 0);
            wait 0.05;
        }
    }
}

// Namespace cp_mi_cairo_aquifer_water_room
// Params 1, eflags: 0x0
// Checksum 0xd2873219, Offset: 0x13c0
// Size: 0x22
function function_3d8a313e(a_ents) {
    aquifer_util::function_c897523d("respawn_in_water_room");
}

// Namespace cp_mi_cairo_aquifer_water_room
// Params 0, eflags: 0x0
// Checksum 0xe79b4394, Offset: 0x13f0
// Size: 0x21a
function function_4a90c357() {
    level flag::wait_till("flag_kayne_water_moment");
    setdvar("player_swimSpeed", 30);
    level notify(#"hash_47f08523");
    level flag::set("inside_data_center");
    foreach (p in level.activeplayers) {
        p clientfield::set_to_player("player_bubbles_fx", 0);
    }
    level thread lui::screen_fade_out(1);
    wait 1;
    level.var_89ea8991 stopanimscripted();
    setdvar("player_swimSpeed", -106);
    level.var_89ea8991 clientfield::set("kane_bubbles_fx", 0);
    thread function_3ed240f1();
    var_31b9fd4a = getent("doubledoor_sbm", "targetname");
    var_31b9fd4a hide();
    level thread namespace_71a63eac::function_8210b658();
    level thread scene::play("cin_aqu_02_01_floodroom_1st_dragged", level.var_89ea8991);
    level waittill(#"hash_b580186f");
    level notify(#"hash_8f79547f");
    level thread namespace_71a63eac::function_e18f629a();
    util::function_93831e79("igc_post_water_structs");
    setdvar("player_swimSpeed", -106);
    thread function_a079b7e3();
    savegame::checkpoint_save();
    thread function_8aec0a4c();
}

// Namespace cp_mi_cairo_aquifer_water_room
// Params 0, eflags: 0x0
// Checksum 0x6273d939, Offset: 0x1618
// Size: 0x1b2
function function_8aec0a4c() {
    level endon(#"hash_66250ae7");
    trig = getent("trig_trap_door", "targetname");
    trig triggerenable(0);
    struct = getent("igc_kane_water", "targetname");
    var_31b9fd4a = getent("doubledoor_sbm", "targetname");
    var_31b9fd4a show();
    struct scene::play("cin_aqu_03_21_server_room_enter", level.var_89ea8991);
    struct thread scene::play("cin_aqu_03_21_server_room_idle", level.var_89ea8991);
    level flag::set("flag_kayne_ready_trap");
    thread function_cc9a0395();
    trig triggerenable(1);
    level flag::wait_till("flag_maretti_trap_door");
    level notify(#"hash_eb6a1c8b");
    level.var_89ea8991 scene::stop(1);
    struct thread scene::play("cin_aqu_03_21_server_room_explosion", level.var_89ea8991);
    if (isdefined(level.var_24d74b55)) {
        level thread [[ level.var_24d74b55 ]]();
    }
    level.var_89ea8991 dialog::say("kane_on_me_0");
}

// Namespace cp_mi_cairo_aquifer_water_room
// Params 0, eflags: 0x0
// Checksum 0xfca55a69, Offset: 0x17d8
// Size: 0xca
function function_cc9a0395() {
    level endon(#"hash_eb6a1c8b");
    wait 2;
    level.var_89ea8991 dialog::say("kane_come_on_get_in_pos_0");
    wait 6;
    level.var_89ea8991 dialog::say("kane_hurry_it_up_0");
    wait 12;
    level.var_89ea8991 dialog::say("kane_come_on_get_in_pos_0");
    wait 20;
    level.var_89ea8991 dialog::say("kane_hurry_it_up_0");
    wait 25;
    level.var_89ea8991 dialog::say("kane_come_on_get_in_pos_0");
    wait 30;
    level.var_89ea8991 dialog::say("kane_hurry_it_up_0");
}

// Namespace cp_mi_cairo_aquifer_water_room
// Params 0, eflags: 0x0
// Checksum 0x644dbed6, Offset: 0x18b0
// Size: 0x93
function function_c1808198() {
    foreach (p in level.activeplayers) {
        p thread aquifer_util::function_89eaa1b3(1.5);
        p hazard::do_damage("o2", 85);
        p thread function_498a7d66();
    }
}

// Namespace cp_mi_cairo_aquifer_water_room
// Params 0, eflags: 0x0
// Checksum 0x898c94bb, Offset: 0x1950
// Size: 0x3a
function function_498a7d66() {
    self endon(#"disconnect");
    self clientfield::set_to_player("player_bubbles_fx", 1);
    wait 2;
    self clientfield::set_to_player("player_bubbles_fx", 0);
}

// Namespace cp_mi_cairo_aquifer_water_room
// Params 0, eflags: 0x0
// Checksum 0x9f22be5e, Offset: 0x1998
// Size: 0x35a
function function_ee430caa() {
    var_99b9d1f2 = trigger::wait_till("water_room_exit_igc");
    level thread namespace_71a63eac::function_973b77f9();
    level notify(#"hash_9f732141");
    level notify(#"hash_bf1c950c");
    aquifer_util::function_8bf8a765(0);
    level flag::clear("inside_data_center");
    namespace_84eb777e::function_61034146(1);
    namespace_84eb777e::function_b3ed487d(0);
    exploder::exploder("lighting_server_perf_lights");
    var_ebc124a5 = spawner::get_ai_group_ai("interior_robots");
    var_19e0145d = spawner::get_ai_group_ai("interior_robots_stairs");
    var_f3dd99f4 = spawner::get_ai_group_ai("interior_robots_water");
    var_a40e8c9b = arraycombine(var_ebc124a5, var_19e0145d, 0, 0);
    var_8a13f363 = arraycombine(var_a40e8c9b, var_f3dd99f4, 0, 0);
    foreach (i in var_8a13f363) {
        if (isdefined(i)) {
            i delete();
        }
    }
    if (isdefined(level.var_89ea8991) && isalive(level.var_89ea8991)) {
        level.var_89ea8991 delete();
    }
    if (isdefined(level.var_a8ebf9fc)) {
        level thread [[ level.var_a8ebf9fc ]]();
    }
    thread function_ddc03444();
    struct = getent("igc_kane_khalil_1", "targetname");
    if (!isdefined(level.activeplayers[0].var_8fedf36c)) {
        level.activeplayers[0] aquifer_util::function_d683f26a(0);
    }
    level.activeplayers[0].var_8fedf36c show();
    struct thread scene::play("cin_aqu_03_01_platform_1st_secureplatform_vtol", level.activeplayers[0].var_8fedf36c);
    struct thread scene::play("cin_aqu_03_01_platform_1st_secureplatform_ambient");
    struct scene::play("cin_aqu_03_01_platform_1st_secureplatform", var_99b9d1f2.who);
    thread function_430fd872();
    struct scene::play("cin_aqu_03_01_platform_1st_secureplatform_exit");
    struct scene::stop("cin_aqu_03_20_water_room_body_loop", 1);
    savegame::checkpoint_save();
    level flag::set("flag_khalil_water_igc_done");
    struct scene::stop("cin_aqu_03_01_platform_1st_secureplatform");
}

// Namespace cp_mi_cairo_aquifer_water_room
// Params 0, eflags: 0x0
// Checksum 0xca09a6b7, Offset: 0x1d00
// Size: 0x72
function function_430fd872() {
    level dialog::remote("hend_we_ve_got_additional_0");
    wait 1;
    level dialog::function_13b3b16a("plyr_copy_that_we_re_on_0");
    wait 4;
    level dialog::function_13b3b16a("plyr_i_see_em_multiple_0");
    level thread namespace_71a63eac::function_b1ee6c2d();
    wait 1;
    level dialog::function_13b3b16a("kane_copy_i_see_em_too_0");
}

// Namespace cp_mi_cairo_aquifer_water_room
// Params 0, eflags: 0x0
// Checksum 0x4b6eb916, Offset: 0x1d80
// Size: 0xb2
function function_ddc03444() {
    var_c0155443 = struct::get("water_room_flyby_1", "targetname");
    var_4e0de508 = struct::get("water_room_flyby_2", "targetname");
    wait 3;
    var_c0155443 scene::play(var_c0155443.scriptbundlename);
    var_c0155443 scene::stop(1);
    wait 8;
    var_4e0de508 scene::play(var_4e0de508.scriptbundlename);
    var_4e0de508 scene::stop(1);
}

// Namespace cp_mi_cairo_aquifer_water_room
// Params 0, eflags: 0x0
// Checksum 0x5183560e, Offset: 0x1e40
// Size: 0x72
function function_a079b7e3() {
    level dialog::remote("khal_something_s_jamming_0", 2);
    level dialog::function_13b3b16a("plyr_something_doesn_t_fe_0", 3);
    level.var_89ea8991 dialog::say("kane_yeah_i_got_that_same_0");
    level.var_89ea8991 dialog::say("kane_up_here_ready_weapo_0", 2);
}

// Namespace cp_mi_cairo_aquifer_water_room
// Params 0, eflags: 0x0
// Checksum 0x6d8c9f2a, Offset: 0x1ec0
// Size: 0x2a
function function_26031755() {
    playfxontag(level._effect["emp_flash"], self, "tag_origin");
}

// Namespace cp_mi_cairo_aquifer_water_room
// Params 1, eflags: 0x0
// Checksum 0xd3448acc, Offset: 0x1ef8
// Size: 0x55
function emprumbleloop(duration) {
    self endon(#"emp_rumble_loop");
    self notify(#"emp_rumble_loop");
    goaltime = gettime() + duration * 1000;
    while (gettime() < goaltime) {
        self playrumbleonentity("damage_heavy");
        wait 0.05;
    }
}

// Namespace cp_mi_cairo_aquifer_water_room
// Params 0, eflags: 0x0
// Checksum 0x1bb43f74, Offset: 0x1f58
// Size: 0x42
function checktoturnoffemp() {
    if (isdefined(self)) {
        self.empgrenaded = 0;
        shutdownemprebootindicatormenu();
        self setempjammed(0);
        self clientfield::set_to_player("empd", 0);
    }
}

// Namespace cp_mi_cairo_aquifer_water_room
// Params 0, eflags: 0x0
// Checksum 0xe5cb299, Offset: 0x1fa8
// Size: 0x3a
function shutdownemprebootindicatormenu() {
    emprebootmenu = self getluimenu("EmpRebootIndicator");
    if (isdefined(emprebootmenu)) {
        self closeluimenu(emprebootmenu);
    }
}

// Namespace cp_mi_cairo_aquifer_water_room
// Params 0, eflags: 0x0
// Checksum 0xe6b07543, Offset: 0x1ff0
// Size: 0x152
function function_4f725f0b() {
    self endon(#"disconnect");
    self enableinvulnerability();
    self.empduration = 7;
    self.empgrenaded = 1;
    self shellshock("emp_shock", 1);
    self clientfield::set_to_player("empd", 1);
    self.empstarttime = gettime();
    self.empendtime = self.empstarttime + self.empduration * 1000;
    emprebootmenu = self openluimenu("EmpRebootIndicator");
    self setluimenudata(emprebootmenu, "endTime", int(self.empendtime));
    self setluimenudata(emprebootmenu, "startTime", int(self.empstarttime));
    self thread emprumbleloop(0.75);
    self setempjammed(1);
    wait 7;
    if (isdefined(self)) {
        self notify(#"empgrenadetimedout");
        self checktoturnoffemp();
    }
    self disableinvulnerability();
}

// Namespace cp_mi_cairo_aquifer_water_room
// Params 0, eflags: 0x0
// Checksum 0x11965bf0, Offset: 0x2150
// Size: 0x18a
function function_408f0fb5() {
    level endon(#"hash_47f08523");
    level flag::wait_till("flag_player_start_drown sequence");
    level flag::wait_till("water_corvus_vo_cleared");
    foreach (p in level.activeplayers) {
        p thread function_4f725f0b();
    }
    setdvar("player_swimSpeed", 95);
    level notify(#"hash_781a429d");
    level thread cp_mi_cairo_aquifer_sound::function_69386a6b();
    function_846f1215(0.5);
    level thread cp_mi_cairo_aquifer_sound::function_decbd389();
    wait 2;
    setdvar("player_swimSpeed", 80);
    function_846f1215(0.65);
    level thread cp_mi_cairo_aquifer_sound::function_4ce4df2();
    wait 2;
    setdvar("player_swimSpeed", 50);
    function_846f1215(0.8);
    level thread cp_mi_cairo_aquifer_sound::function_2ad0c85b();
    wait 2;
    level flag::set("flag_kayne_water_moment");
}

// Namespace cp_mi_cairo_aquifer_water_room
// Params 1, eflags: 0x0
// Checksum 0xd2b1f03, Offset: 0x22e8
// Size: 0x93
function function_846f1215(n_alpha) {
    foreach (p in level.activeplayers) {
        p thread function_45676b91(n_alpha);
        p hazard::do_damage("o2", 20);
        p thread function_498a7d66();
    }
}

// Namespace cp_mi_cairo_aquifer_water_room
// Params 1, eflags: 0x0
// Checksum 0xe8458619, Offset: 0x2388
// Size: 0x3a
function function_45676b91(n_alpha) {
    self endon(#"disconnect");
    self util::function_c04ace5b(n_alpha, 1);
    self util::function_c04ace5b(0, 1);
}

// Namespace cp_mi_cairo_aquifer_water_room
// Params 0, eflags: 0x0
// Checksum 0x78a883b6, Offset: 0x23d0
// Size: 0x11a
function function_645f7873() {
    level endon(#"hash_47f08523");
    setdvar("player_swimSpeed", 95);
    wait 0.5;
    level thread cp_mi_cairo_aquifer_sound::function_fc716128();
    thread function_c1808198();
    level dialog::remote("corv_listen_only_to_the_s_2", undefined, "corvus");
    wait 0.2;
    level thread cp_mi_cairo_aquifer_sound::function_6e78d063();
    thread function_c1808198();
    level dialog::remote("corv_imagine_yourself_0", undefined, "corvus");
    wait 0.2;
    level thread cp_mi_cairo_aquifer_sound::function_487655fa();
    thread function_c1808198();
    level dialog::remote("corv_in_a_frozen_fore_0", undefined, "corvus");
    level flag::set("water_corvus_vo_cleared");
}

// Namespace cp_mi_cairo_aquifer_water_room
// Params 0, eflags: 0x0
// Checksum 0xf22bc757, Offset: 0x24f8
// Size: 0x62
function function_ba41df77() {
    thread util::screen_fade_out(0.55, "white");
    wait 0.55;
    util::screen_fade_out(0, "white");
    util::screen_fade_in(0.55, "white");
}

// Namespace cp_mi_cairo_aquifer_water_room
// Params 0, eflags: 0x0
// Checksum 0x7b33e79c, Offset: 0x2568
// Size: 0x3a
function function_e367262c() {
    self hazard::function_459e5eff("o2", 0);
    self hazard::do_damage("o2", 50);
}

// Namespace cp_mi_cairo_aquifer_water_room
// Params 0, eflags: 0x0
// Checksum 0x276ee652, Offset: 0x25b0
// Size: 0x8d
function function_913d882() {
    self endon(#"disconnect");
    self notify(#"hash_1fffa65c");
    self endon(#"death");
    self endon(#"hash_1fffa65c");
    while (true) {
        if (self.sessionstate == "playing" && isalive(self) && self isplayerunderwater() && !(isdefined(self.var_5ea9c8b7) && self.var_5ea9c8b7)) {
            self thread function_41018429();
        }
        wait 0.5;
    }
}

// Namespace cp_mi_cairo_aquifer_water_room
// Params 0, eflags: 0x0
// Checksum 0x1054926, Offset: 0x2648
// Size: 0xb2
function function_41018429() {
    self notify(#"hash_8f1abd30");
    self endon(#"hash_8f1abd30");
    self endon(#"death");
    self.var_5ea9c8b7 = 1;
    self hazard::function_459e5eff("o2", 0);
    for (var_dd075cd2 = 1; self isplayerunderwater(); var_dd075cd2 = self hazard::do_damage("o2", 5)) {
        wait 1;
    }
    self hazard::function_459e5eff("o2", 1);
    self.var_5ea9c8b7 = 0;
}

// Namespace cp_mi_cairo_aquifer_water_room
// Params 0, eflags: 0x0
// Checksum 0x8ae56c10, Offset: 0x2708
// Size: 0x22
function function_a1923020() {
    level waittill(#"door_explodes");
    level flag::set("flag_door_explodes");
}

// Namespace cp_mi_cairo_aquifer_water_room
// Params 0, eflags: 0x0
// Checksum 0x38fcefe2, Offset: 0x2738
// Size: 0x1c2
function function_a1b52577() {
    thread function_a1923020();
    level flag::wait_till_all(array("flag_maretti_trap_door", "flag_kayne_ready_trap", "flag_door_explodes"));
    exploder::exploder("server_room_boobytrap");
    level thread cp_mi_cairo_aquifer_sound::function_ceaeaa5a();
    var_5b8892d8 = getent("mdl_trapdoor", "targetname");
    var_5b8892d8 delete();
    level thread function_cb3decf1();
    thread function_a05b1c8c();
    level notify(#"hash_66250ae7");
    wait 2;
    level dialog::remote("khal_kane_do_you_read_me_0");
    level dialog::remote("khal_there_s_multiple_con_0");
    level.var_89ea8991 dialog::say("kane_taylor_and_maretti_0");
    level thread namespace_71a63eac::function_a2d40521();
    level dialog::remote("khal_kane_you_have_to_go_0");
    thread function_71af9864();
    level flag::set("water_room_checkpoint");
    level.var_89ea8991 colors::set_force_color("r");
    trigger::use("breadcrumb_exit_water", "targetname");
    savegame::checkpoint_save();
}

// Namespace cp_mi_cairo_aquifer_water_room
// Params 0, eflags: 0x0
// Checksum 0xd4be210b, Offset: 0x2908
// Size: 0xd2
function function_71af9864() {
    spawn_manager::enable("spawn_manager_flood_robots");
    spawn_manager::enable("spawn_manager_water_robots");
    spawn_manager::enable("spawn_manager_flood_robots2");
    wait 2;
    struct = getent("igc_kane_water", "targetname");
    struct thread scene::play("cin_aqu_03_21_server_room_doors_open");
    level thread cp_mi_cairo_aquifer_sound::function_ed6114d2();
    var_31b9fd4a = getent("doubledoor_sbm", "targetname");
    var_31b9fd4a delete();
}

// Namespace cp_mi_cairo_aquifer_water_room
// Params 0, eflags: 0x0
// Checksum 0x7b49e1fd, Offset: 0x29e8
// Size: 0x32
function function_b563cc38() {
    spawner::waittill_ai_group_cleared("interior_robots_stairs");
    level flag::set("flag_kane_start_water_escape");
}

// Namespace cp_mi_cairo_aquifer_water_room
// Params 0, eflags: 0x0
// Checksum 0x63ca66c5, Offset: 0x2a28
// Size: 0xd2
function function_18af354a() {
    level flag::wait_till("flag_kane_start_water_escape");
    exploder::exploder("lighting_water_exit");
    foreach (p in level.players) {
        p thread function_913d882();
    }
    level.var_89ea8991 ai::set_ignoreme(1);
    level.var_89ea8991 thread function_8fdcc95b(5);
    thread function_67c72b6();
}

// Namespace cp_mi_cairo_aquifer_water_room
// Params 1, eflags: 0x0
// Checksum 0x8314be10, Offset: 0x2b08
// Size: 0x42
function function_8fdcc95b(delay) {
    if (isdefined(delay)) {
        wait delay;
    }
    self fx::play("bubbles", self.origin, (0, 0, 0), "swim_done", 1, "j_spineupper", 1);
}

// Namespace cp_mi_cairo_aquifer_water_room
// Params 0, eflags: 0x0
// Checksum 0xc459ec06, Offset: 0x2b58
// Size: 0xe2
function function_67c72b6() {
    level endon(#"hash_bf1c950c");
    struct = getent("igc_kane_water", "targetname");
    struct scene::play("cin_aqu_03_22_water_room_escape_start", level.var_89ea8991);
    struct thread scene::play("cin_aqu_03_22_water_room_escape_fire_loop", level.var_89ea8991);
    spawner::waittill_ai_group_cleared("interior_robots_water");
    level.var_89ea8991 stopanimscripted();
    struct scene::play("cin_aqu_03_22_water_room_escape_end", level.var_89ea8991);
    struct scene::play("cin_aqu_03_22_water_room_escape_end_loop", level.var_89ea8991);
}

// Namespace cp_mi_cairo_aquifer_water_room
// Params 0, eflags: 0x0
// Checksum 0xec87e510, Offset: 0x2c48
// Size: 0x153
function function_cb3decf1() {
    var_e9dd177b = getent("trig_trap_door", "targetname");
    var_568fff7e = getent("inner_explosion_area", "targetname");
    foreach (player in level.activeplayers) {
        if (player istouching(var_e9dd177b)) {
            if (player istouching(var_568fff7e)) {
                player thread function_a476832a(0.5, 4);
                earthquake(0.7, 1.2, player.origin, 1000);
            } else {
                earthquake(0.6, 1, player.origin, 800);
            }
            player playrumbleonentity("damage_heavy");
        }
    }
}

// Namespace cp_mi_cairo_aquifer_water_room
// Params 2, eflags: 0x0
// Checksum 0xafc18cfb, Offset: 0x2da8
// Size: 0x2a
function function_a476832a(delay, duration) {
    wait delay;
    self shellshock("proximity_grenade", duration);
}

// Namespace cp_mi_cairo_aquifer_water_room
// Params 0, eflags: 0x0
// Checksum 0x26d00974, Offset: 0x2de0
// Size: 0x20b
function function_a05b1c8c() {
    closest = level.activeplayers[0];
    var_e34a3797 = [];
    kane = getent("look_at_kane_origin", "targetname");
    var_be38fd90 = getent("door_trap_origin", "targetname");
    foreach (player in level.activeplayers) {
        if (distance(player.origin, var_be38fd90.origin) < -81) {
            array::add(var_e34a3797, player);
        }
    }
    if (var_e34a3797.size < 1) {
        foreach (player in level.activeplayers) {
            if (distance(player.origin, var_be38fd90.origin) < distance(closest.origin, var_be38fd90.origin)) {
                closest = player;
            }
        }
        array::add(var_e34a3797, closest);
    }
    foreach (player in var_e34a3797) {
        thread function_a0faf694(player, kane, var_be38fd90);
    }
}

// Namespace cp_mi_cairo_aquifer_water_room
// Params 3, eflags: 0x0
// Checksum 0x4e4d1946, Offset: 0x2ff8
// Size: 0x1c2
function function_a0faf694(var_4b70f64, kane, var_be38fd90) {
    rotator = spawn("script_origin", var_4b70f64.origin);
    rotator.angles = var_4b70f64 getplayerangles();
    var_4b70f64 playerlinkto(rotator, undefined, 1, 0, 0, 0, 0);
    player_eye = var_4b70f64 geteye();
    if (distance(var_4b70f64.origin, var_be38fd90.origin) < -81) {
        if (var_4b70f64.origin[1] < var_be38fd90.origin[1]) {
            rotator moveto(rotator.origin + (0, 40, 0), 0.3, 0.15, 0.15);
        }
        rotator rotateto(vectortoangles(kane.origin - var_4b70f64.origin), 0.7, 0.3, 0.3);
    } else {
        rotator rotateto(vectortoangles(kane.origin - player_eye), 0.7, 0.3, 0.3);
    }
    rotator waittill(#"rotatedone");
    var_4b70f64 unlink();
    rotator delete();
}

// Namespace cp_mi_cairo_aquifer_water_room
// Params 0, eflags: 0x0
// Checksum 0xf200c0c2, Offset: 0x31c8
// Size: 0x72
function function_a527e6f9() {
    self.script_accuracy = 0.3;
    self.health = 100;
    self.skipdeath = 1;
    self asmsetanimationrate(0.7);
    self clientfield::set("robot_bubbles_fx", 1);
    self waittill(#"death");
    if (isdefined(self)) {
        self startragdoll();
    }
}

// Namespace cp_mi_cairo_aquifer_water_room
// Params 0, eflags: 0x0
// Checksum 0x25d91353, Offset: 0x3248
// Size: 0x52
function function_3b4d25aa() {
    self ai::set_behavior_attribute("rogue_control_speed", "sprint");
    self ai::set_behavior_attribute("rogue_control", "forced_level_2");
    self ai::set_ignoreme(1);
}

// Namespace cp_mi_cairo_aquifer_water_room
// Params 0, eflags: 0x0
// Checksum 0x8074c81e, Offset: 0x32a8
// Size: 0x1a
function function_3ed240f1() {
    level.var_75756ef4 = 0;
    thread function_8492aced();
}

// Namespace cp_mi_cairo_aquifer_water_room
// Params 0, eflags: 0x0
// Checksum 0xb35c94dd, Offset: 0x32d0
// Size: 0x10a
function function_8492aced() {
    level waittill(#"hash_43565802");
    lui::screen_fade_out(0, "black");
    wait 0.25;
    level waittill(#"hash_f26c95d0");
    lui::screen_fade_in(1, "black");
    level waittill(#"hash_43565802");
    lui::screen_fade_out(0.5, "black");
    level waittill(#"hash_f26c95d0");
    util::screen_fade_out(0, "black");
    level thread util::screen_fade_in(1, "black");
    level waittill(#"hash_43565802");
    lui::screen_fade_out(0.5, "black");
    level waittill(#"hash_f26c95d0");
    util::screen_fade_out(0, "black");
    level thread util::screen_fade_in(1, "black");
}

// Namespace cp_mi_cairo_aquifer_water_room
// Params 0, eflags: 0x0
// Checksum 0xb0a02c50, Offset: 0x33e8
// Size: 0x45
function function_c67c64fe() {
    level endon(#"hash_8f79547f");
    while (true) {
        level waittill(#"hash_f26c95d0");
        if (level.var_75756ef4 == 1) {
            level.var_75756ef4 = 0;
            thread lui::screen_fade_in(0.5);
        }
    }
}

// Namespace cp_mi_cairo_aquifer_water_room
// Params 0, eflags: 0x0
// Checksum 0xeabd95d0, Offset: 0x3438
// Size: 0x4d
function fade_to_black() {
    level endon(#"hash_8f79547f");
    while (true) {
        level waittill(#"hash_43565802");
        if (level.var_75756ef4 == 0) {
            level.var_75756ef4 = 1;
            thread lui::screen_fade_out(0.5);
        }
    }
}

