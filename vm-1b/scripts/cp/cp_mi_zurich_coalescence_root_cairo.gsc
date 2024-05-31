#using scripts/cp/cp_mi_zurich_coalescence_sound;
#using scripts/cp/cp_mi_zurich_coalescence_root_cinematics;
#using scripts/cp/cp_mi_zurich_coalescence_util;
#using scripts/cp/_spawn_manager;
#using scripts/cp/_objectives;
#using scripts/cp/_util;
#using scripts/cp/_skipto;
#using scripts/cp/_load;
#using scripts/cp/_dialog;
#using scripts/shared/vehicles/_raps;
#using scripts/shared/vehicle_shared;
#using scripts/shared/vehicle_ai_shared;
#using scripts/shared/util_shared;
#using scripts/shared/trigger_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/array_shared;
#using scripts/shared/ai_shared;
#using scripts/cp/gametypes/_save;
#using scripts/codescripts/struct;

#namespace namespace_73dbe018;

// Namespace namespace_73dbe018
// Params 0, eflags: 0x0
// Checksum 0x7630c14a, Offset: 0xc40
// Size: 0xf2
function main() {
    init_clientfields();
    level flag::init("vtol_dropped_wall");
    level._effect["lightning_strike"] = "explosions/fx_exp_lightning_fold_infection";
    level._effect["explosion_medium"] = "explosions/fx_exp_debris_metal_md";
    level._effect["explosion_large"] = "explosions/fx_exp_sky_bridge_lotus";
    level thread function_54b0174d();
    scene::add_scene_func("p7_fxanim_cp_zurich_wall_drop_bundle", &namespace_8e9083ff::function_9f90bc0f, "done", "cairo_root_completed");
    scene::add_scene_func("p7_fxanim_cp_zurich_checkpoint_wall_01_bundle", &namespace_8e9083ff::function_9f90bc0f, "done", "cairo_root_completed");
}

// Namespace namespace_73dbe018
// Params 0, eflags: 0x0
// Checksum 0x31004991, Offset: 0xd40
// Size: 0x52
function init_clientfields() {
    clientfield::register("scriptmover", "vtol_spawn_fx", 1, 1, "counter");
    clientfield::register("world", "cairo_client_ents", 1, 1, "int");
}

// Namespace namespace_73dbe018
// Params 2, eflags: 0x0
// Checksum 0x355253b1, Offset: 0xda0
// Size: 0x222
function function_9c1fc2fd(str_objective, var_74cd64bc) {
    load::function_73adcefc();
    if (var_74cd64bc) {
        level util::screen_fade_out(0);
        level flag::set("flag_diaz_first_path_complete_vo_done");
    }
    videostart("cp_zurich_env_corvusmonitor", 1);
    level scene::init("cin_zur_14_01_cairo_root_1st_fall");
    level thread namespace_67110270::function_973b77f9();
    exploder::exploder("weather_lightning_exp");
    var_4ccf970 = namespace_8e9083ff::function_a00fa665(str_objective);
    namespace_8e9083ff::function_4d032f25(1, 0.5);
    spawner::add_spawn_function_group("raven_ambush_ai", "script_parameters", &namespace_8e9083ff::function_aceff870);
    spawner::add_spawn_function_group("raven_spawn_teleport", "script_parameters", &namespace_8e9083ff::function_3287bea1);
    level thread namespace_67110270::function_1935b4aa();
    level thread function_42dddb91(str_objective);
    level clientfield::set("cairo_client_ents", 1);
    level thread function_4cca3b70();
    level thread function_6559d2b2();
    load::function_a2995f22();
    skipto::teleport_players(str_objective, 0);
    level thread namespace_8e9083ff::function_a03f30f2(str_objective, "root_cairo_vortex", "root_cairo_regroup");
    level thread namespace_8e9083ff::function_dd842585(str_objective, "root_cairo_vortex", "t_root_cairo_vortex");
    level thread function_962eebf2(str_objective);
    level waittill(str_objective + "enter_vortex");
    level thread function_95b88092("root_cairo_vortex", 0);
}

// Namespace namespace_73dbe018
// Params 2, eflags: 0x0
// Checksum 0xea1570c9, Offset: 0xfd0
// Size: 0x1ca
function function_95b88092(str_objective, var_74cd64bc) {
    if (isdefined(var_74cd64bc) && var_74cd64bc) {
        load::function_73adcefc();
        load::function_a2995f22();
        skipto::teleport_players(str_objective, 0);
        namespace_8e9083ff::function_4d032f25(1, 0.5);
        level thread namespace_8e9083ff::function_c90e23b6(str_objective);
    }
    if (isdefined(level.var_4c8d19ff)) {
        level thread [[ level.var_4c8d19ff ]]();
    }
    level thread scene::init("cairo_fxanim_heart_ceiling", "targetname");
    exploder::exploder("heartLightsCairo");
    level thread namespace_67110270::function_973b77f9();
    level thread function_2dbeaba5();
    level thread function_c3dca267();
    level util::clientnotify("stCAMU");
    if (level.players === 1) {
        savegame::checkpoint_save();
    }
    var_8fb0849a = namespace_8e9083ff::function_a1851f86(str_objective);
    var_8fb0849a waittill(#"hash_40b1a9d9");
    level thread namespace_bbb4ee72::function_b319df2(str_objective, var_8fb0849a.var_90971f20.e_player);
    level notify(#"hash_ef6331cc");
    videostop("cp_zurich_env_corvusmonitor");
    exploder::stop_exploder("weather_lightning_exp");
    level util::clientnotify("stp_mus");
}

// Namespace namespace_73dbe018
// Params 4, eflags: 0x0
// Checksum 0x4fcd8c84, Offset: 0x11a8
// Size: 0x72
function function_1a4dfaaa(str_objective, var_74cd64bc, var_e4cd2b8b, player) {
    level notify(#"hash_83eebac0");
    level thread namespace_8e9083ff::function_4a00a473("root_cairo");
    exploder::stop_exploder("weather_lightning_exp");
    level clientfield::set("cairo_client_ents", 0);
}

// Namespace namespace_73dbe018
// Params 0, eflags: 0x0
// Checksum 0x70814ca3, Offset: 0x1228
// Size: 0x2aa
function function_7cdb6ab4() {
    level endon(#"hash_1f265efe");
    level flag::wait_till("flag_cairo_root_monologue_01");
    level dialog::function_13b3b16a("plyr_listen_only_to_the_s_0", 3);
    level dialog::function_13b3b16a("plyr_let_your_mind_relax_0", 3);
    level dialog::function_13b3b16a("plyr_let_your_thoughts_dr_0", 3);
    level dialog::function_13b3b16a("plyr_let_the_bad_memories_0", 3);
    level dialog::function_13b3b16a("plyr_let_peace_be_upon_yo_0", 3);
    level flag::wait_till("flag_cairo_root_monologue_02");
    level dialog::function_13b3b16a("plyr_surrender_yourself_t_0", 3);
    level dialog::function_13b3b16a("plyr_let_them_wash_over_y_0", 3);
    level dialog::function_13b3b16a("plyr_imagine_somewhere_ca_0", 3);
    level dialog::function_13b3b16a("plyr_imagine_somewhere_sa_0", 3);
    level dialog::function_13b3b16a("plyr_imagine_yourself_0", 3);
    level flag::wait_till("flag_cairo_root_monologue_03");
    level dialog::function_13b3b16a("plyr_you_are_standing_in_0", 3);
    level dialog::function_13b3b16a("plyr_the_trees_around_you_0", 3);
    level dialog::function_13b3b16a("plyr_pure_white_snowflake_0", 3);
    level dialog::function_13b3b16a("plyr_you_can_feel_them_me_0", 3);
    level dialog::function_13b3b16a("plyr_you_are_not_cold_0", 3);
    level dialog::function_13b3b16a("plyr_it_cannot_overcome_t_0", 3);
    level flag::wait_till("flag_cairo_root_monologue_04");
    level dialog::function_13b3b16a("plyr_can_you_hear_it_0", 3);
    level dialog::function_13b3b16a("plyr_you_only_have_to_lis_0", 3);
    level dialog::function_13b3b16a("plyr_do_you_hear_it_slowi_0", 3);
    level dialog::function_13b3b16a("plyr_you_are_slowing_it_0", 3);
    level dialog::function_13b3b16a("plyr_you_are_in_control_0", 3);
    level dialog::function_13b3b16a("plyr_calm_0", 3);
    level dialog::function_13b3b16a("plyr_at_peace_0", 3);
    level flag::set("flag_cairo_root_monologue_04_done");
}

// Namespace namespace_73dbe018
// Params 0, eflags: 0x0
// Checksum 0xcf94de98, Offset: 0x14e0
// Size: 0x72
function function_2dbeaba5() {
    level endon(#"hash_1f265efe");
    level flag::wait_till("flag_cairo_root_monologue_04_done");
    level dialog::remote("salm_the_nature_of_memory_0", 4, "NO_DNI");
    level dialog::remote("salm_over_the_last_centur_0", 1, "NO_DNI");
}

// Namespace namespace_73dbe018
// Params 1, eflags: 0x0
// Checksum 0xd0d913e9, Offset: 0x1560
// Size: 0xfa
function function_d3f1996d(str_objective) {
    level endon(str_objective + "enter_vortex");
    level flag::wait_till("flag_diaz_first_path_complete_vo_done");
    wait(3);
    level notify(#"hash_d3c69346");
    level.var_1c26230b dialog::say("tayr_diaz_and_maretti_i_0", 1);
    level.var_1c26230b dialog::say("tayr_they_were_trying_to_0", 1);
    level.var_1c26230b dialog::say("tayr_it_couldn_t_control_1", 1);
    wait(5);
    level thread function_7cdb6ab4();
    level flag::wait_till("flag_taylor_vo_never_give_up");
    level.var_1c26230b dialog::say("tayr_don_t_give_up_be_0", 1);
}

// Namespace namespace_73dbe018
// Params 1, eflags: 0x0
// Checksum 0x6fbedb0, Offset: 0x1668
// Size: 0x1ba
function function_962eebf2(str_objective) {
    array::run_all(level.players, &freezecontrols, 1);
    array::run_all(level.players, &enableinvulnerability);
    level scene::init("cin_zur_14_01_cairo_root_1st_fall");
    level util::streamer_wait();
    level thread util::screen_fade_in(1);
    array::thread_all(level.players, &clientfield::increment_to_player, "postfx_transition");
    playsoundatposition("evt_clearing_trans_in", (0, 0, 0));
    if (isdefined(level.var_1e860021)) {
        level thread [[ level.var_1e860021 ]]();
    }
    level scene::play("cin_zur_14_01_cairo_root_1st_fall");
    level util::function_93831e79("root_cairo_intro_end");
    array::run_all(level.players, &freezecontrols, 0);
    array::run_all(level.players, &disableinvulnerability);
    util::clear_streamer_hint();
    savegame::checkpoint_save();
    level thread namespace_8e9083ff::function_c90e23b6(str_objective, "breadcrumb_cairoroot_3");
    level thread function_d3f1996d(str_objective);
}

// Namespace namespace_73dbe018
// Params 0, eflags: 0x0
// Checksum 0x7dfc621, Offset: 0x1830
// Size: 0x10a
function function_4cca3b70() {
    scene::add_scene_func("p7_fxanim_cp_zurich_wall_drop_bundle", &function_fe87d3eb, "done");
    scene::add_scene_func("p7_fxanim_cp_zurich_wall_drop_bundle", &function_e3c9dd29, "play");
    level thread function_ef1ee0c7();
    var_15ecae1 = getent("trigger_vtol_arrival", "targetname");
    var_15ecae1 waittill(#"trigger");
    level thread scene::play("p7_fxanim_cp_zurich_wall_drop_bundle");
    level waittill(#"hash_883eae52");
    wait(3);
    level notify(#"hash_4dbdcce4");
    level flag::wait_till("flag_cairo_start_wall_spawn");
    spawn_manager::enable("sm_vtol_wall");
    savegame::checkpoint_save();
}

// Namespace namespace_73dbe018
// Params 1, eflags: 0x0
// Checksum 0xdfd86c8a, Offset: 0x1948
// Size: 0x82
function function_fe87d3eb(a_ents) {
    level flag::wait_till("vtol_dropped_wall");
    var_58ee3480 = getent("wall_drop_doors", "targetname");
    if (!isdefined(var_58ee3480)) {
        return;
    }
    level scene::play("p7_fxanim_cp_ramses_wall_drop_doors_up_bundle", var_58ee3480);
    spawn_manager::enable("sm_doors_open");
}

// Namespace namespace_73dbe018
// Params 0, eflags: 0x0
// Checksum 0xac577c81, Offset: 0x19d8
// Size: 0x4a
function function_ef1ee0c7() {
    var_abef87dc = getent("open_wall_doors", "script_noteworthy");
    var_abef87dc waittill(#"trigger");
    level flag::set("vtol_dropped_wall");
}

// Namespace namespace_73dbe018
// Params 1, eflags: 0x0
// Checksum 0x6dfae40a, Offset: 0x1a30
// Size: 0xc9
function function_e3c9dd29(a_ents) {
    var_2ef9d306 = a_ents["wall_drop_vtol"];
    var_ec523dd5 = a_ents["wall_drop_wall"];
    var_24a1012d = struct::get_array("vtol_scene_spawn_fx", "targetname");
    for (i = 0; i < var_24a1012d.size; i++) {
        var_9508eea7 = util::spawn_model("tag_origin", var_24a1012d[i].origin, (0, 0, 0));
        util::wait_network_frame();
        var_9508eea7 thread function_899f9f96();
    }
}

// Namespace namespace_73dbe018
// Params 0, eflags: 0x0
// Checksum 0x40b18c36, Offset: 0x1b08
// Size: 0x32
function function_899f9f96() {
    self clientfield::increment("vtol_spawn_fx");
    wait(3);
    if (isdefined(self)) {
        self delete();
    }
}

// Namespace namespace_73dbe018
// Params 0, eflags: 0x0
// Checksum 0xa6ee8f0e, Offset: 0x1b48
// Size: 0x11a
function function_6559d2b2() {
    scene::add_scene_func("p7_fxanim_cp_zurich_checkpoint_wall_01_bundle", &function_c5b12ba9, "init");
    scene::add_scene_func("p7_fxanim_cp_zurich_checkpoint_wall_01_bundle", &function_73238a8, "play");
    trigger::wait_till("trig_cairo_arena_start", "script_noteworthy");
    spawn_manager::enable("sm_cairo_wall_02");
    spawn_manager::enable("sm_cairo_ambush");
    level thread function_8c7755d2();
    level thread function_46b4203d();
    level flag::wait_till("flag_cairo_arena_complete");
    level thread scene::play("p7_fxanim_cp_zurich_checkpoint_wall_01_bundle");
    spawn_manager::disable("sm_cairo_ambush");
}

// Namespace namespace_73dbe018
// Params 0, eflags: 0x0
// Checksum 0xe0827962, Offset: 0x1c70
// Size: 0x22
function function_8c7755d2() {
    level endon(#"hash_fc5ed004");
    wait(60);
    level flag::set("flag_cairo_arena_complete");
}

// Namespace namespace_73dbe018
// Params 0, eflags: 0x0
// Checksum 0xe26b5968, Offset: 0x1ca0
// Size: 0x3a
function function_46b4203d() {
    level endon(#"hash_fc5ed004");
    spawn_manager::function_27bf2e8("sm_cairo_wall_02", 2);
    level flag::set("flag_cairo_arena_complete");
}

// Namespace namespace_73dbe018
// Params 1, eflags: 0x0
// Checksum 0x6cdbb043, Offset: 0x1ce8
// Size: 0x63
function function_c5b12ba9(a_ents) {
    foreach (e_ent in a_ents) {
        e_ent hide();
    }
}

// Namespace namespace_73dbe018
// Params 1, eflags: 0x0
// Checksum 0xa752930a, Offset: 0x1d58
// Size: 0x152
function function_73238a8(a_ents) {
    a_mdl_doors = getentarray("root_cairo_arena_doors", "targetname");
    foreach (e_ent in a_ents) {
        e_ent show();
    }
    foreach (mdl_door in a_mdl_doors) {
        mdl_door delete();
    }
    e_clip = getent("root_cairo_arena_clip", "targetname");
    if (isdefined(e_clip)) {
        e_clip notsolid();
        e_clip connectpaths();
        e_clip delete();
    }
}

// Namespace namespace_73dbe018
// Params 0, eflags: 0x0
// Checksum 0x1e323c8e, Offset: 0x1eb8
// Size: 0x92
function function_54b0174d() {
    var_35a225f3 = getent("lotus_tower_sink", "targetname");
    if (isdefined(var_35a225f3)) {
        var_35a225f3 setscale(0.4);
        var_35a225f3 hide();
        level flag::wait_till("root_cairo_start");
        var_35a225f3 show();
        var_35a225f3 thread function_1a9fae41();
    }
}

// Namespace namespace_73dbe018
// Params 0, eflags: 0x0
// Checksum 0xc7f16bd9, Offset: 0x1f58
// Size: 0x157
function function_1a9fae41() {
    var_70cf920f = getent("t_lotus_sink", "script_noteworthy");
    var_70cf920f waittill(#"trigger");
    s_start = self;
    playfx(level._effect["explosion_large"], self.origin);
    for (s_next = struct::get(self.target, "targetname"); isdefined(s_next); s_next = struct::get(s_start.target, "targetname")) {
        n_distance = distance(s_start.origin, s_next.origin);
        n_time = n_distance / 20;
        self moveto(s_next.origin, n_time);
        self rotateto(s_next.angles, n_time);
        self waittill(#"movedone");
        s_start = s_next;
        s_next = undefined;
        if (isdefined(s_start.target)) {
        }
    }
}

// Namespace namespace_73dbe018
// Params 1, eflags: 0x0
// Checksum 0x8e635366, Offset: 0x20b8
// Size: 0xc2
function function_42dddb91(str_objective) {
    level endon(str_objective + "_done");
    level endon(#"hash_83eebac0");
    objectives::breadcrumb("t_breadcrumb_cairoroot_1");
    trigger::wait_till("t_breadcrumb_cairoroot_1");
    level notify(#"next_checkpoint");
    savegame::checkpoint_save();
    objectives::breadcrumb("t_breadcrumb_cairoroot_2");
    trigger::wait_till("t_breadcrumb_cairoroot_2");
    level notify(#"next_checkpoint");
    savegame::checkpoint_save();
    objectives::breadcrumb("t_breadcrumb_cairoroot_3");
}

// Namespace namespace_73dbe018
// Params 0, eflags: 0x0
// Checksum 0xc50b81f5, Offset: 0x2188
// Size: 0x4a
function function_c3dca267() {
    var_765ae49e = getentarray("cairo_vortex_spawn", "targetname");
    array::thread_all(var_765ae49e, &function_24c08a2f);
}

// Namespace namespace_73dbe018
// Params 0, eflags: 0x0
// Checksum 0x9d8ea6ee, Offset: 0x21e0
// Size: 0xf1
function function_24c08a2f() {
    self waittill(#"trigger");
    var_66b68fff = getentarray(self.target, "targetname");
    self delete();
    for (i = 0; i < var_66b68fff.size; i++) {
        var_3e32f05a = spawner::simple_spawn_single(var_66b68fff[i], &namespace_8e9083ff::function_c412aad5);
        if (isdefined(var_66b68fff[i].script_noteworthy)) {
            var_3e32f05a.animname = var_66b68fff[i].script_noteworthy;
            var_3e32f05a vehicle_ai::set_state("scripted");
            var_3e32f05a setspeed(20);
            var_3e32f05a thread function_54c51e5b();
            var_3e32f05a thread function_20541efa();
        }
    }
}

// Namespace namespace_73dbe018
// Params 0, eflags: 0x0
// Checksum 0x2dfa7829, Offset: 0x22e0
// Size: 0x6a
function function_54c51e5b() {
    self endon(#"death");
    nd_start = getvehiclenode(self.script_noteworthy + "_start", "targetname");
    self thread vehicle::get_on_and_go_path(nd_start);
    self waittill(#"reached_end_node");
    self raps::detonate();
}

// Namespace namespace_73dbe018
// Params 0, eflags: 0x0
// Checksum 0xccd2d4b3, Offset: 0x2358
// Size: 0x85
function function_20541efa() {
    self endon(#"death");
    while (true) {
        e_player = arraygetclosest(self.origin, level.activeplayers);
        if (distance(self.origin, e_player.origin) <= 600) {
            self vehicle_ai::set_state("combat");
            return;
        }
        wait(0.1);
    }
}

