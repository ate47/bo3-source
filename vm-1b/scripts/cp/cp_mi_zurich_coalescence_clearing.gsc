#using scripts/cp/cp_mi_zurich_coalescence_sound;
#using scripts/cp/cp_mi_zurich_coalescence_outro;
#using scripts/cp/cp_mi_zurich_coalescence_util;
#using scripts/cp/gametypes/_save;
#using scripts/cp/_util;
#using scripts/cp/_skipto;
#using scripts/cp/_load;
#using scripts/shared/ai/archetype_locomotion_utility;
#using scripts/shared/laststand_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/trigger_shared;
#using scripts/shared/util_shared;
#using scripts/shared/player_shared;
#using scripts/shared/hud_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/array_shared;
#using scripts/shared/gameobjects_shared;
#using scripts/shared/scene_shared;
#using scripts/cp/_dialog;
#using scripts/cp/_spawn_manager;
#using scripts/cp/_objectives;
#using scripts/shared/ai_shared;
#using scripts/codescripts/struct;

#namespace namespace_29799936;

// Namespace namespace_29799936
// Params 0, eflags: 0x0
// namespace_29799936<file_0>::function_d290ebfa
// Checksum 0x8e5f350, Offset: 0xc20
// Size: 0xdb
function main() {
    init_clientfields();
    scene::add_scene_func("cin_zur_10_01_kruger_3rd_questioned_sh010", &function_7685bfc5, "play");
    scene::add_scene_func("cin_zur_10_01_kruger_3rd_questioned_sh010", &function_8eb661fa, "skip_started");
    scene::add_scene_func("p7_fxanim_cp_zurich_rock_slide_bundle", &namespace_8e9083ff::function_9f90bc0f, "done", "clearing_path_selected");
    level._effect["krueger_body_fx"] = "player/fx_ai_marker_body_kreuger";
    level._effect["krueger_beam_fx"] = "light/fx_beam_marker_kreuger";
}

// Namespace namespace_29799936
// Params 0, eflags: 0x0
// namespace_29799936<file_0>::function_2ea898a8
// Checksum 0xbe9f9816, Offset: 0xd08
// Size: 0x9a
function init_clientfields() {
    var_c0e9f8c3 = getminbitcountfornum(5);
    clientfield::register("world", "zurich_waterfall_bodies", 1, 1, "int");
    clientfield::register("world", "clearing_vinewall_init", 1, var_c0e9f8c3, "int");
    clientfield::register("world", "clearing_vinewall_open", 1, var_c0e9f8c3, "int");
}

// Namespace namespace_29799936
// Params 2, eflags: 0x0
// namespace_29799936<file_0>::function_5bcd68f2
// Checksum 0x12700e8b, Offset: 0xdb0
// Size: 0x142
function function_5bcd68f2(str_objective, var_74cd64bc) {
    level namespace_8e9083ff::function_4d032f25(1, 0.5);
    spawner::add_spawn_function_group("raven_enemies_clearing_start", "script_aigroup", &function_a1a182e);
    level flag::wait_till("all_players_spawned");
    skipto::teleport_players(str_objective, 0);
    array::thread_all(level.activeplayers, &util::function_df6eb506, 1);
    level namespace_8e9083ff::function_b0f0dd1f(1, "reverse_snow");
    if (var_74cd64bc) {
        util::function_d8eaed3d(3);
        level util::screen_fade_out(0, "white");
    }
    level clientfield::set("zurich_waterfall_bodies", 1);
    level clientfield::set("clearing_vinewall_init", 5);
    level thread function_a3f52108(str_objective);
    level thread namespace_67110270::function_82e83534();
}

// Namespace namespace_29799936
// Params 4, eflags: 0x0
// namespace_29799936<file_0>::function_c68a0705
// Checksum 0x6ab3c7d3, Offset: 0xf00
// Size: 0x22
function function_c68a0705(str_objective, var_74cd64bc, var_e4cd2b8b, player) {
    
}

// Namespace namespace_29799936
// Params 1, eflags: 0x0
// namespace_29799936<file_0>::function_a3f52108
// Checksum 0x67f06c2b, Offset: 0xf30
// Size: 0x92
function function_a3f52108(str_objective) {
    array::thread_all(level.players, &function_32cf3cd);
    var_4ccf970 = thread namespace_8e9083ff::function_a00fa665(str_objective);
    level thread function_e8e4006f();
    level thread function_8727b592();
    level thread function_6a2abd6d();
    level flag::set("flag_clearing_start");
}

// Namespace namespace_29799936
// Params 0, eflags: 0x0
// namespace_29799936<file_0>::function_a1a182e
// Checksum 0x9e7743dc, Offset: 0xfd0
// Size: 0x3a
function function_a1a182e() {
    self.var_5e7a3967 = 1;
    self setgoalvolume(getent("clearing_start_defend_volume", "targetname"));
}

// Namespace namespace_29799936
// Params 0, eflags: 0x0
// namespace_29799936<file_0>::function_6a2abd6d
// Checksum 0x9fdb88b3, Offset: 0x1018
// Size: 0x5a
function function_6a2abd6d() {
    trigger::wait_till("trig_clearing_enemy_cleanup");
    array::run_all(getaiarray("clearing_start_enemies", "script_noteworthy"), &delete);
}

// Namespace namespace_29799936
// Params 0, eflags: 0x0
// namespace_29799936<file_0>::function_8727b592
// Checksum 0x25141de3, Offset: 0x1080
// Size: 0x6a
function function_8727b592() {
    level endon(#"hash_c83e0fe0");
    spawn_manager::wait_till_cleared("sm_clearing_enemy_spawn");
    objectives::breadcrumb("clearing_start_breadcrumb_trig");
    spawn_manager::wait_till_cleared("sm_clearing_hill");
    objectives::breadcrumb("clearing_hill_breadcrumb_trig");
}

// Namespace namespace_29799936
// Params 0, eflags: 0x0
// namespace_29799936<file_0>::function_e8e4006f
// Checksum 0x1bc1d6b7, Offset: 0x10f8
// Size: 0x112
function function_e8e4006f() {
    scene::add_scene_func("cin_zur_09_02_standoff_1st_forest", &function_5b75f492, "done");
    scene::add_scene_func("cin_zur_09_02_standoff_1st_forest", &function_cf93f22a, "play");
    level scene::init("cin_zur_09_02_standoff_1st_forest");
    scene::add_scene_func("p7_fxanim_cp_zurich_tree_krueger_split_rt_bundle", &function_7d18154f, "init");
    level scene::init("p7_fxanim_cp_zurich_tree_krueger_split_rt_bundle");
    wait(3);
    level thread util::screen_fade_in(2, "white");
    if (isdefined(level.var_9d5ca0ab)) {
        level thread [[ level.var_9d5ca0ab ]]();
    }
    level thread scene::play("cin_zur_09_02_standoff_1st_forest");
}

// Namespace namespace_29799936
// Params 1, eflags: 0x0
// namespace_29799936<file_0>::function_cf93f22a
// Checksum 0xdb595203, Offset: 0x1218
// Size: 0x122
function function_cf93f22a(a_ents) {
    self thread function_4ac14422(a_ents);
    a_ents["corvus"] ghost();
    a_ents["corvus"] waittill(#"hash_be812a65");
    a_ents["corvus"] clientfield::set("raven_ai_rez", 1);
    wait(0.5);
    a_ents["corvus"] show();
    a_ents["corvus"] clientfield::set("corvus_body_fx", 1);
    a_ents["corvus"] waittill(#"hash_4cfd02d9");
    a_ents["corvus"] clientfield::set("raven_ai_rez", 0);
    a_ents["corvus"] clientfield::set("corvus_body_fx", 0);
    a_ents["corvus"] ghost();
}

// Namespace namespace_29799936
// Params 0, eflags: 0x0
// namespace_29799936<file_0>::function_44dc9752
// Checksum 0x60737d23, Offset: 0x1348
// Size: 0x15a
function function_44dc9752() {
    scene::add_scene_func("cin_zur_09_02_standoff_3rd_forest_part2_sh010", &function_eb4d9424, "play");
    scene::add_scene_func("cin_zur_09_02_standoff_3rd_forest_part2_sh010", &namespace_8e9083ff::function_f3e247d6, "init");
    level scene::init("p7_fxanim_cp_zurich_rock_slide_bundle");
    var_b35e56d0 = trigger::wait_till("t_waterfall_igc");
    if (isdefined(level.var_4d62c9e3)) {
        level thread [[ level.var_4d62c9e3 ]]();
    }
    level scene::play("cin_zur_09_02_standoff_3rd_forest_part2_sh010", var_b35e56d0.who);
    level util::function_93831e79("clearing_waterfall_igc_end");
    util::clear_streamer_hint();
    util::function_d8eaed3d(5);
    level waittill(#"hash_4e38f7bd");
    scene::add_scene_func("cin_zur_10_01_kruger_3rd_questioned_sh010", &namespace_8e9083ff::function_f3e247d6, "init");
    level scene::init("cin_zur_10_01_kruger_3rd_questioned_sh010");
}

// Namespace namespace_29799936
// Params 1, eflags: 0x0
// namespace_29799936<file_0>::function_eb4d9424
// Checksum 0x5b50e4dc, Offset: 0x14b0
// Size: 0x82
function function_eb4d9424(a_ents) {
    var_f91fd6fe = a_ents["kruger"];
    var_f91fd6fe waittill(#"hash_b172f51e");
    playfxontag(level._effect["krueger_body_fx"], var_f91fd6fe, "j_spine4");
    level waittill(#"hash_89688662");
    playfxontag(level._effect["krueger_beam_fx"], var_f91fd6fe, "tag_origin");
}

// Namespace namespace_29799936
// Params 1, eflags: 0x0
// namespace_29799936<file_0>::function_5b75f492
// Checksum 0xc3ae8af4, Offset: 0x1540
// Size: 0xeb
function function_5b75f492(a_ents) {
    level util::function_93831e79("clearing_start_intro_end");
    util::clear_streamer_hint();
    savegame::checkpoint_save();
    level scene::init("cin_zur_09_02_standoff_3rd_forest_part2_sh010");
    level thread function_e0b4badc();
    level thread function_44dc9752();
    util::wait_network_frame();
    foreach (player in level.players) {
        player player::switch_to_primary_weapon(1);
    }
}

// Namespace namespace_29799936
// Params 0, eflags: 0x0
// namespace_29799936<file_0>::function_e0b4badc
// Checksum 0x3cf240be, Offset: 0x1638
// Size: 0x8a
function function_e0b4badc() {
    spawn_manager::enable("sm_clearing_enemy_spawn");
    spawn_manager::wait_till_complete("sm_clearing_enemy_spawn");
    level scene::play("cin_zur_09_01_standoff_vign_charge", spawn_manager::function_423eae50("sm_clearing_enemy_spawn"));
    spawn_manager::wait_till_cleared("sm_clearing_enemy_spawn");
    savegame::checkpoint_save();
}

// Namespace namespace_29799936
// Params 0, eflags: 0x0
// namespace_29799936<file_0>::function_32cf3cd
// Checksum 0x381fa268, Offset: 0x16d0
// Size: 0x9b
function function_32cf3cd() {
    a_w_weapons = self getweaponslist();
    foreach (w_weapon in a_w_weapons) {
        self givemaxammo(w_weapon);
        self setweaponammoclip(w_weapon, w_weapon.clipsize);
    }
}

// Namespace namespace_29799936
// Params 2, eflags: 0x0
// namespace_29799936<file_0>::function_5be0c18c
// Checksum 0xaadfab46, Offset: 0x1778
// Size: 0x212
function function_5be0c18c(str_objective, var_74cd64bc) {
    spawner::add_spawn_function_group("spawn_manager_waterfall_guy", "targetname", &function_2afd205d);
    if (var_74cd64bc) {
        load::function_73adcefc();
        level scene::init("cin_zur_09_02_standoff_3rd_forest_part2_sh010");
        namespace_8e9083ff::function_4d032f25(1, 0.5);
        var_4ccf970 = namespace_8e9083ff::function_a00fa665("clearing_start");
        level namespace_8e9083ff::function_b0f0dd1f(1, "reverse_snow");
        level thread function_6a2abd6d();
        level clientfield::set("zurich_waterfall_bodies", 1);
        level clientfield::set("clearing_vinewall_init", 5);
        level scene::init("p7_fxanim_cp_zurich_rock_slide_bundle");
        scene::add_scene_func("p7_fxanim_cp_zurich_tree_krueger_split_rt_bundle", &function_7d18154f, "init");
        level scene::init("p7_fxanim_cp_zurich_tree_krueger_split_rt_bundle");
        load::function_a2995f22();
        skipto::teleport_players(str_objective, 0);
        array::thread_all(level.activeplayers, &util::function_df6eb506, 1);
        level function_44dc9752();
    }
    level thread function_83fcefa6();
    array::thread_all(level.activeplayers, &namespace_8e9083ff::function_39af75ef, "clearing_path_selected");
    level thread function_6c92c263(1);
}

// Namespace namespace_29799936
// Params 4, eflags: 0x0
// namespace_29799936<file_0>::function_132beeb7
// Checksum 0x149024eb, Offset: 0x1998
// Size: 0x22
function function_132beeb7(str_objective, var_74cd64bc, var_e4cd2b8b, player) {
    
}

// Namespace namespace_29799936
// Params 0, eflags: 0x0
// namespace_29799936<file_0>::function_83fcefa6
// Checksum 0x82d8334a, Offset: 0x19c8
// Size: 0x10a
function function_83fcefa6() {
    array::run_all(level.activeplayers, &playrumbleonentity, "cp_infection_hideout_stretch");
    playsoundatposition("evt_waterfall_rumble", (0, 0, 0));
    objectives::breadcrumb("trig_clearing_waterfall_breadcrumb");
    trigger::wait_till("trig_clearing_waterfall_breadcrumb");
    if (isdefined(level.var_83ee1431)) {
        level thread [[ level.var_83ee1431 ]]();
    }
    level thread scene::play("p7_fxanim_cp_zurich_rock_slide_bundle");
    objectives::breadcrumb("trig_clearing_waterfall_pool_breadcrumb");
    trigger::wait_till("trig_clearing_waterfall_pool_breadcrumb");
    savegame::checkpoint_save();
    level thread function_cd8360f3();
    level thread function_eae5713();
}

// Namespace namespace_29799936
// Params 0, eflags: 0x0
// namespace_29799936<file_0>::function_cd8360f3
// Checksum 0xd387aa9b, Offset: 0x1ae0
// Size: 0x62
function function_cd8360f3() {
    spawn_manager::enable("spawn_manager_waterfall_enemies");
    spawn_manager::wait_till_cleared("spawn_manager_waterfall_enemies");
    if (isdefined(level.var_c4dba52c)) {
        [[ level.var_c4dba52c ]]();
    }
    level flag::set("flag_enable_waterfall_vine_burn");
}

// Namespace namespace_29799936
// Params 0, eflags: 0x0
// namespace_29799936<file_0>::function_2afd205d
// Checksum 0x8a806ee1, Offset: 0x1b50
// Size: 0x32
function function_2afd205d() {
    self setgoalvolume(getent("waterfall_defend_volume", "targetname"));
}

// Namespace namespace_29799936
// Params 2, eflags: 0x0
// namespace_29799936<file_0>::function_21b82e1f
// Checksum 0xe30f3631, Offset: 0x1b90
// Size: 0x1aa
function function_21b82e1f(str_objective, var_74cd64bc) {
    if (var_74cd64bc) {
        load::function_73adcefc();
        namespace_8e9083ff::function_4d032f25(1, 0.5);
        level thread namespace_8e9083ff::function_11b424e5(1);
        var_4ccf970 = namespace_8e9083ff::function_a00fa665("clearing_start");
        array::thread_all(level.activeplayers, &util::function_df6eb506, 1);
        level namespace_8e9083ff::function_b0f0dd1f(1, "reverse_snow");
        level clientfield::set("zurich_waterfall_bodies", 1);
        level clientfield::set("clearing_vinewall_init", 5);
        scene::add_scene_func("cin_zur_10_01_kruger_3rd_questioned_sh010", &namespace_8e9083ff::function_f3e247d6, "init");
        level scene::init("cin_zur_10_01_kruger_3rd_questioned_sh010");
        level scene::init("p7_fxanim_cp_zurich_tree_krueger_split_rt_bundle");
        util::function_d8eaed3d(5);
        load::function_a2995f22();
        skipto::teleport_players(str_objective, 0);
        if (isdefined(level.var_c416bc94)) {
            level thread [[ level.var_c416bc94 ]]();
        }
    }
    util::wait_network_frame();
    level thread function_eadc4ffc();
}

// Namespace namespace_29799936
// Params 0, eflags: 0x0
// namespace_29799936<file_0>::function_eadc4ffc
// Checksum 0xe9db2e0a, Offset: 0x1d48
// Size: 0x1ba
function function_eadc4ffc() {
    var_60a2aad6 = getaiteamarray("axis");
    foreach (ai in var_60a2aad6) {
        ai delete();
    }
    scene::add_scene_func("cin_zur_11_01_paths_1st_still_chance", &function_36f7aa25, "play");
    scene::add_scene_func("cin_zur_11_01_paths_1st_still_chance", &function_bf68487, "done");
    level.var_1c26230b = util::function_740f8516("taylor_hero");
    level.var_1c26230b ghost();
    level thread scene::init("cin_zur_11_01_paths_1st_still_chance", level.var_1c26230b);
    level thread namespace_67110270::function_71271388();
    level thread scene::play("p7_fxanim_cp_zurich_tree_krueger_split_rt_bundle");
    level scene::play("cin_zur_10_01_kruger_3rd_questioned_sh010");
    level thread function_6c92c263(0);
    level namespace_8e9083ff::function_b0f0dd1f(0);
    wait(1);
    level namespace_8e9083ff::function_b0f0dd1f(1, "red_rain");
}

// Namespace namespace_29799936
// Params 1, eflags: 0x0
// namespace_29799936<file_0>::function_7d18154f
// Checksum 0x58b5875c, Offset: 0x1f10
// Size: 0x152
function function_7d18154f(a_ents) {
    var_332eaff4 = a_ents["krueger_tree_lt"];
    var_f069ba56 = a_ents["krueger_tree_rt"];
    var_332eaff4 hidepart("arm_lt_side_jnt");
    var_332eaff4 hidepart("arm_blood_fx_lt_jnt");
    var_332eaff4 hidepart("elbow_lt_side_jnt");
    var_332eaff4 hidepart("leg_lt_side_jnt");
    var_332eaff4 hidepart("knee_lt_side_jnt");
    var_332eaff4 hidepart("leg_blood_fx_lt_jnt");
    var_f069ba56 hidepart("arm_rt_side_jnt");
    var_f069ba56 hidepart("arm_blood_fx_rt_jnt");
    var_f069ba56 hidepart("elbow_rt_side_jnt");
    var_f069ba56 hidepart("leg_rt_side_jnt");
    var_f069ba56 hidepart("knee_rt_side_jnt");
    var_f069ba56 hidepart("leg_blood_fx_rt_jnt");
}

// Namespace namespace_29799936
// Params 1, eflags: 0x0
// namespace_29799936<file_0>::function_7685bfc5
// Checksum 0xfb43c4fd, Offset: 0x2070
// Size: 0x3a
function function_7685bfc5(a_ents) {
    var_c9b7e4eb = a_ents["krueger"];
    level waittill(#"hash_4fa207a0");
    var_c9b7e4eb ghost();
}

// Namespace namespace_29799936
// Params 1, eflags: 0x0
// namespace_29799936<file_0>::function_8eb661fa
// Checksum 0xa8856ce0, Offset: 0x20b8
// Size: 0x22
function function_8eb661fa(a_ents) {
    level scene::stop("p7_fxanim_cp_zurich_tree_krueger_split_rt_bundle");
}

// Namespace namespace_29799936
// Params 1, eflags: 0x0
// namespace_29799936<file_0>::function_36f7aa25
// Checksum 0x963d1695, Offset: 0x20e8
// Size: 0x3a
function function_36f7aa25(a_ents) {
    level.var_1c26230b show();
    level.var_1c26230b thread namespace_8e9083ff::function_fe5160df(1);
}

// Namespace namespace_29799936
// Params 1, eflags: 0x0
// namespace_29799936<file_0>::function_bf68487
// Checksum 0xb64d5e0d, Offset: 0x2130
// Size: 0x5a
function function_bf68487(a_ents) {
    level util::function_93831e79("clearing_kruger_igc_exit");
    util::clear_streamer_hint();
    savegame::checkpoint_save();
    level thread function_75ab0e6a("clearing_hub");
}

// Namespace namespace_29799936
// Params 0, eflags: 0x0
// namespace_29799936<file_0>::function_eae5713
// Checksum 0xaca8a79e, Offset: 0x2198
// Size: 0x153
function function_eae5713() {
    scene::add_scene_func("cin_zur_09_01_standoff_vign_far_as_i_go", &function_4ac14422, "play");
    var_ce37baf2 = getent("trig_waterfall_burn", "targetname");
    var_9d50b546 = getent("clip_burn_vine_01", "targetname");
    var_ce37baf2 setinvisibletoall();
    level flag::wait_till("flag_enable_waterfall_vine_burn");
    var_ce37baf2 setvisibletoall();
    level thread function_51277233();
    var_ce37baf2 namespace_8e9083ff::function_f3bcbbb1();
    if (isdefined(level.var_c416bc94)) {
        level thread [[ level.var_c416bc94 ]]();
    }
    level scene::play("cin_zur_09_01_standoff_vign_far_as_i_go", var_ce37baf2.e_player);
    level util::function_93831e79("waterfall_vinewall_igc_end");
    level thread namespace_8e9083ff::function_11b424e5(1);
    var_9d50b546 notsolid();
    level notify(#"hash_87560491");
}

// Namespace namespace_29799936
// Params 0, eflags: 0x0
// namespace_29799936<file_0>::function_51277233
// Checksum 0x55dd7a8, Offset: 0x22f8
// Size: 0x22
function function_51277233() {
    level waittill(#"hash_3f802798");
    level clientfield::set("clearing_vinewall_open", 1);
}

// Namespace namespace_29799936
// Params 1, eflags: 0x0
// namespace_29799936<file_0>::function_6c92c263
// Checksum 0xe51b05b3, Offset: 0x2328
// Size: 0xb2
function function_6c92c263(b_hide) {
    var_ecf05dd0 = getent("waterfall_vine_path_blocker", "targetname");
    var_9d50b546 = getent("clip_burn_vine_01", "targetname");
    if (b_hide) {
        var_ecf05dd0 hide();
        return;
    }
    var_ecf05dd0 show();
    level clientfield::set("clearing_vinewall_init", 1);
    var_9d50b546 solid();
}

// Namespace namespace_29799936
// Params 1, eflags: 0x0
// namespace_29799936<file_0>::function_4ac14422
// Checksum 0xfbb75003, Offset: 0x23e8
// Size: 0xa2
function function_4ac14422(a_ents) {
    var_2e3b8e7e = a_ents["hendricks"];
    var_2e3b8e7e ghost();
    wait(1);
    var_2e3b8e7e clientfield::set("raven_ai_rez", 1);
    wait(0.5);
    var_2e3b8e7e show();
    var_2e3b8e7e waittill(#"hash_36dcb014");
    var_2e3b8e7e clientfield::set("raven_ai_rez", 0);
    wait(0.5);
    var_2e3b8e7e ghost();
}

// Namespace namespace_29799936
// Params 2, eflags: 0x0
// namespace_29799936<file_0>::function_75ab0e6a
// Checksum 0x29d4cd64, Offset: 0x2498
// Size: 0x23a
function function_75ab0e6a(str_objective, var_7c092e3a) {
    if (!isdefined(var_7c092e3a)) {
        var_7c092e3a = 0;
    }
    level endon(#"hash_c7f297ae");
    var_2b8f773a = struct::get(str_objective + "_taylor_start", "targetname");
    var_8a1e3703 = 0;
    if (!isdefined(level.var_1c26230b)) {
        var_8a1e3703 = 1;
        level function_6aede49e(str_objective);
        level.var_1c26230b forceteleport(var_2b8f773a.origin, var_2b8f773a.angles);
        level.var_1c26230b ai::set_ignoreme(1);
        level.var_1c26230b ai::set_ignoreall(1);
        level.var_1c26230b ghost();
    }
    level.var_1c26230b sethighdetail(1);
    level.var_1c26230b thread function_aea8cd9b();
    if (var_7c092e3a > 0) {
        wait(var_7c092e3a);
    }
    if (isdefined(var_2b8f773a.target)) {
        var_9de10fe3 = getnode(var_2b8f773a.target, "targetname");
        level.var_1c26230b ai::set_behavior_attribute("forceTacticalWalk", 1);
        level.var_1c26230b ai::set_ignoreall(1);
        level.var_1c26230b setgoal(var_9de10fe3, 1);
    }
    if (var_8a1e3703) {
        wait(1);
        level.var_1c26230b clientfield::set("hero_spawn_fx", 1);
        wait(0.5);
        level.var_1c26230b ai::set_ignoreme(0);
        level.var_1c26230b ai::set_ignoreall(0);
        level.var_1c26230b show();
    }
    wait(3);
    level.var_1c26230b sethighdetail(0);
}

// Namespace namespace_29799936
// Params 1, eflags: 0x0
// namespace_29799936<file_0>::function_6aede49e
// Checksum 0x580f5794, Offset: 0x26e0
// Size: 0x42
function function_6aede49e(str_objective) {
    level.var_1c26230b = util::function_740f8516("taylor_hero");
    level.var_1c26230b thread namespace_8e9083ff::function_fe5160df(1);
}

// Namespace namespace_29799936
// Params 0, eflags: 0x0
// namespace_29799936<file_0>::function_aea8cd9b
// Checksum 0x7154d93d, Offset: 0x2730
// Size: 0x52
function function_aea8cd9b() {
    level waittill(#"hash_c7f297ae");
    self clientfield::set("hero_spawn_fx", 0);
    wait(0.5);
    self util::unmake_hero("taylor_hero");
    self util::self_delete();
}

// Namespace namespace_29799936
// Params 0, eflags: 0x0
// namespace_29799936<file_0>::function_f1073c0f
// Checksum 0xcf644bf8, Offset: 0x2790
// Size: 0xba
function function_f1073c0f() {
    level dialog::remote("dcor_you_know_where_it_al_0", 1, "NO_DNI");
    level dialog::remote("dcor_when_we_trained_we_0", 1, "NO_DNI");
    level dialog::remote("dcor_they_put_a_big_fat_s_0", 1, "NO_DNI");
    level dialog::remote("dcor_how_could_we_know_wh_0", 1, "NO_DNI");
    level flag::set("flag_diaz_first_path_complete_vo_done");
}

// Namespace namespace_29799936
// Params 0, eflags: 0x0
// namespace_29799936<file_0>::function_65667fec
// Checksum 0x732d13c3, Offset: 0x2858
// Size: 0x5a
function function_65667fec() {
    wait(2);
    self dialog::say("tayr_the_frozen_forest_wa_0", 1);
    level dialog::remote("hcor_this_isn_t_the_froze_0", 1, "NO_DNI");
    savegame::checkpoint_save();
}

// Namespace namespace_29799936
// Params 2, eflags: 0x0
// namespace_29799936<file_0>::function_1270c207
// Checksum 0x419e7ffd, Offset: 0x28c0
// Size: 0x272
function function_1270c207(str_objective, var_74cd64bc) {
    if (str_objective == "clearing_hub_2" || str_objective == "clearing_hub_3" || var_74cd64bc) {
        load::function_73adcefc();
        level thread scene::skipto_end("p7_fxanim_cp_zurich_tree_krueger_split_rt_bundle");
        level clientfield::set("zurich_waterfall_bodies", 1);
        level clientfield::set("clearing_vinewall_init", 5);
        var_4ccf970 = namespace_8e9083ff::function_a00fa665(str_objective);
        if (!var_74cd64bc) {
            level.var_75ba074a = undefined;
        }
        load::function_a2995f22(isdefined(var_74cd64bc) && var_74cd64bc ? 2 : 0);
        skipto::teleport_players(str_objective, 0);
        level namespace_8e9083ff::function_b0f0dd1f(1, "red_rain");
        array::thread_all(level.activeplayers, &util::function_df6eb506, 1);
        level thread namespace_8e9083ff::function_11b424e5(1);
        if (!var_74cd64bc) {
            wait(1);
            level util::streamer_wait();
            foreach (player in level.players) {
                player.var_a954e196 = undefined;
                player util::delay(0.3, undefined, &util::show_hud, 1);
            }
            level thread util::screen_fade_in(2, "black");
        }
        level thread function_75ab0e6a(str_objective, level.var_75ba074a);
        if (str_objective === "clearing_hub_2") {
            level thread function_f1073c0f();
        }
        if (str_objective === "clearing_hub_3") {
            while (!isdefined(level.var_1c26230b)) {
                util::wait_network_frame();
            }
            level.var_1c26230b function_65667fec();
        }
    }
    level thread namespace_67110270::function_82e83534();
    level thread function_c998741b(str_objective);
}

// Namespace namespace_29799936
// Params 4, eflags: 0x0
// namespace_29799936<file_0>::function_44c2b6a
// Checksum 0xdc870431, Offset: 0x2b40
// Size: 0x4a
function function_44c2b6a(str_objective, var_74cd64bc, var_e4cd2b8b, player) {
    level function_82fb3fff();
    level thread namespace_8e9083ff::function_4a00a473("clearing_hub");
}

// Namespace namespace_29799936
// Params 4, eflags: 0x0
// namespace_29799936<file_0>::function_600acf3f
// Checksum 0xf013d432, Offset: 0x2b98
// Size: 0x32
function function_600acf3f(str_objective, var_74cd64bc, var_e4cd2b8b, player) {
    level function_82fb3fff();
}

// Namespace namespace_29799936
// Params 4, eflags: 0x0
// namespace_29799936<file_0>::function_b42e7a80
// Checksum 0x3dafd0bf, Offset: 0x2bd8
// Size: 0x4a
function function_b42e7a80(str_objective, var_74cd64bc, var_e4cd2b8b, player) {
    level function_82fb3fff();
    level thread namespace_8e9083ff::function_4a00a473("clearing_hub_3");
}

// Namespace namespace_29799936
// Params 0, eflags: 0x0
// namespace_29799936<file_0>::function_82fb3fff
// Checksum 0x20d19007, Offset: 0x2c30
// Size: 0x5a
function function_82fb3fff() {
    level namespace_8e9083ff::function_b0f0dd1f(0);
    level clientfield::set("zurich_waterfall_bodies", 0);
    level clientfield::set("clearing_vinewall_init", 0);
    level clientfield::set("clearing_vinewall_open", 0);
}

// Namespace namespace_29799936
// Params 1, eflags: 0x0
// namespace_29799936<file_0>::function_c998741b
// Checksum 0x8c513f0, Offset: 0x2c98
// Size: 0x38a
function function_c998741b(str_objective) {
    var_89060212 = getentarray("trig_vine_doors", "script_noteworthy");
    array::run_all(var_89060212, &setinvisibletoall);
    switch (str_objective) {
    case 73:
        var_3e0e2df1 = "zurich";
        var_85e76a39 = 4;
        break;
    case 91:
        var_3e0e2df1 = "cairo";
        var_85e76a39 = 3;
        break;
    case 92:
        var_3e0e2df1 = "sing";
        level clientfield::set("clearing_hide_lotus_tower", 1);
        var_85e76a39 = 2;
        break;
    }
    var_7edb74a6 = getent("unburnable_vine_" + var_3e0e2df1, "targetname");
    var_9d50b546 = getent("clip_burn_vine_" + var_3e0e2df1, "targetname");
    var_7edb74a6 hide();
    var_ce37baf2 = getent("trig_vine_damage_" + var_3e0e2df1, "targetname");
    var_ce37baf2 setvisibletoall();
    var_ce37baf2.var_afacae68 = 0;
    var_ce37baf2 function_860aaa8a(var_9d50b546);
    array::thread_all(level.activeplayers, &util::freeze_player_controls, 1);
    level clientfield::set("clearing_vinewall_open", var_85e76a39);
    wait(0.5);
    array::thread_all(level.players, &clientfield::increment_to_player, "postfx_transition");
    playsoundatposition("evt_clearing_trans_out", (0, 0, 0));
    wait(1);
    level util::screen_fade_out(1, "black");
    foreach (player in level.players) {
        player util::show_hud(0);
    }
    switch (str_objective) {
    case 73:
        level scene::init("cin_zur_12_01_root_1st_mirror_01");
        break;
    case 91:
        level scene::init("cin_zur_14_01_cairo_root_1st_fall");
        break;
    case 92:
        util::function_d8eaed3d(8);
        break;
    }
    level util::streamer_wait();
    array::thread_all(level.activeplayers, &util::freeze_player_controls, 0);
    level thread namespace_8e9083ff::function_11b424e5(0);
    level notify(#"hash_c7f297ae");
    skipto::function_be8adfb8(str_objective);
    var_7edb74a6 show();
}

// Namespace namespace_29799936
// Params 1, eflags: 0x0
// namespace_29799936<file_0>::function_860aaa8a
// Checksum 0x604b43b9, Offset: 0x3030
// Size: 0x22
function function_860aaa8a(var_9d50b546) {
    self namespace_8e9083ff::function_30a6b901(0, var_9d50b546);
    self.var_afacae68 = 1;
}

