#using scripts/cp/cp_mi_zurich_coalescence_sound;
#using scripts/cp/cp_mi_zurich_coalescence_root_cinematics;
#using scripts/cp/cp_mi_zurich_coalescence_util;
#using scripts/cp/cp_mi_zurich_coalescence_accolades;
#using scripts/cp/_spawn_manager;
#using scripts/cp/_objectives;
#using scripts/cp/_util;
#using scripts/cp/_skipto;
#using scripts/cp/_load;
#using scripts/cp/_dialog;
#using scripts/shared/callbacks_shared;
#using scripts/shared/laststand_shared;
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

#namespace namespace_3d19ef22;

// Namespace namespace_3d19ef22
// Params 0, eflags: 0x1 linked
// namespace_3d19ef22<file_0>::function_d290ebfa
// Checksum 0xaecdac17, Offset: 0xea0
// Size: 0x2a4
function main() {
    init_clientfields();
    level flag::init("sing_root_depthcharges");
    var_b2a6f229 = getentarray("root_singapore_spawners", "script_noteworthy");
    level._effect["depth_charge_explosion"] = "explosions/fx_exp_underwater_depth_charge";
    level._effect["depth_charge_spawn"] = "player/fx_ai_raven_teleport";
    level._effect["vortex_explode"] = "player/fx_ai_dni_rez_in_hero_clean";
    level._effect["blood_impact_xsm"] = "blood/fx_blood_splash_furn_drop_xsm";
    level._effect["dirt_impact_xsm"] = "dirt/fx_dust_furn_drop_sm";
    level._effect["blood_impact_sm"] = "blood/fx_blood_splash_furn_drop_xsm";
    level._effect["dirt_impact_sm"] = "dirt/fx_dust_furn_drop_sm";
    level._effect["blood_impact_md"] = "blood/fx_blood_splash_furn_drop_md";
    level._effect["dirt_impact_md"] = "dirt/fx_dust_furn_drop_md";
    level._effect["blood_impact_lg"] = "blood/fx_blood_splash_furn_drop_lg";
    level._effect["dirt_impact_lg"] = "dirt/fx_dust_furn_drop_lg";
    scene::add_scene_func("p7_fxanim_cp_zurich_ferris_wheel_bundle", &namespace_8e9083ff::function_9f90bc0f, "done", "root_singapore_start_done");
    scene::add_scene_func("p7_fxanim_cp_zurich_container_collapse_bundle", &namespace_8e9083ff::function_9f90bc0f, "done", "root_singapore_start_done");
    scene::add_scene_func("p7_fxanim_cp_zurich_car_slide_bundle", &namespace_8e9083ff::function_9f90bc0f, "done", "root_singapore_start_done");
    scene::add_scene_func("p7_fxanim_cp_zurich_ferris_wheel_wave_bundle", &function_8fbe0681, "play");
    scene::add_scene_func("p7_fxanim_cp_zurich_ferris_wheel_wave_bundle", &namespace_8e9083ff::function_9f90bc0f, "done", "root_singapore_start_done");
}

// Namespace namespace_3d19ef22
// Params 0, eflags: 0x1 linked
// namespace_3d19ef22<file_0>::function_2ea898a8
// Checksum 0xbd1180dc, Offset: 0x1150
// Size: 0x94
function init_clientfields() {
    clientfield::register("scriptmover", "sm_depth_charge_fx", 1, 1, "int");
    clientfield::register("scriptmover", "water_disturbance", 1, 1, "int");
    clientfield::register("toplayer", "umbra_tome_singapore", 1, 2, "counter");
}

// Namespace namespace_3d19ef22
// Params 2, eflags: 0x1 linked
// namespace_3d19ef22<file_0>::function_9c1fc2fd
// Checksum 0x97db506, Offset: 0x11f0
// Size: 0x3c2
function function_9c1fc2fd(str_objective, var_74cd64bc) {
    load::function_73adcefc();
    if (var_74cd64bc) {
        level util::screen_fade_out(0);
    }
    util::function_d8eaed3d(8);
    videostart("cp_zurich_env_corvusmonitor", 1);
    var_4ccf970 = namespace_8e9083ff::function_a00fa665(str_objective);
    namespace_8e9083ff::function_4d032f25(1, 0.5);
    array::thread_all(level.players, &namespace_8e9083ff::function_39af75ef, "singapore_root_completed");
    spawner::add_spawn_function_group("raven_ambush_ai", "script_parameters", &namespace_8e9083ff::function_aceff870);
    level thread scene::init("p7_fxanim_cp_zurich_ferris_wheel_bundle");
    level thread function_29073d62();
    level thread function_eb271a4b(str_objective);
    load::function_a2995f22();
    skipto::teleport_players(str_objective, 0);
    level thread function_23a51944();
    level thread function_54fbadd1();
    array::thread_all(level.activeplayers, &function_db4d091);
    callback::on_spawned(&function_db4d091);
    level.var_1895e0f9 = &function_1aeafdf8;
    level thread function_4402ab63();
    level thread function_95353712();
    level thread function_8842e57d();
    level thread function_a0e6701b();
    level thread function_3893ad5c(str_objective);
    level thread function_c9c3556c(str_objective);
    level thread namespace_8e9083ff::function_a03f30f2(str_objective, "root_singapore_vortex", "root_singapore_regroup");
    level thread namespace_8e9083ff::function_dd842585(str_objective, "root_singapore_vortex", "t_root_singapore_vortex");
    level waittill(str_objective + "enter_vortex");
    level thread function_95b88092("root_singapore_vortex", 0);
    foreach (player in level.players) {
        player util::show_hud(1);
    }
}

// Namespace namespace_3d19ef22
// Params 0, eflags: 0x1 linked
// namespace_3d19ef22<file_0>::function_db4d091
// Checksum 0xe22e16cf, Offset: 0x15c0
// Size: 0x9c
function function_db4d091() {
    level endon(#"hash_73b00182");
    self notify(#"hash_db4d091");
    self endon(#"hash_db4d091");
    self thread function_52ac3a61();
    self waittill(#"hash_a71a53c4");
    self clientfield::increment_to_player("umbra_tome_singapore");
    level thread function_252e350();
    level util::clientnotify("stSINmus");
}

// Namespace namespace_3d19ef22
// Params 0, eflags: 0x1 linked
// namespace_3d19ef22<file_0>::function_52ac3a61
// Checksum 0x8fa0440a, Offset: 0x1668
// Size: 0x156
function function_52ac3a61() {
    level endon(#"hash_73b00182");
    self endon(#"disconnect");
    self endon(#"hash_a71a53c4");
    self notify(#"hash_52ac3a61");
    self endon(#"hash_52ac3a61");
    var_4d85762b = self getentitynumber();
    self waittill(#"death");
    wait(0.5);
    if (isdefined(self.currentspectatingclient) && self.currentspectatingclient >= 0 && var_4d85762b != self.currentspectatingclient) {
        foreach (player in level.players) {
            if (player getentitynumber() == self.currentspectatingclient) {
                player clientfield::increment_to_player("umbra_tome_singapore");
                break;
            }
        }
    }
}

// Namespace namespace_3d19ef22
// Params 0, eflags: 0x1 linked
// namespace_3d19ef22<file_0>::function_1aeafdf8
// Checksum 0xdad2d249, Offset: 0x17c8
// Size: 0x24
function function_1aeafdf8() {
    self clientfield::increment_to_player("umbra_tome_singapore");
}

// Namespace namespace_3d19ef22
// Params 0, eflags: 0x1 linked
// namespace_3d19ef22<file_0>::function_c38b8260
// Checksum 0xf2d0c906, Offset: 0x17f8
// Size: 0xd2
function function_c38b8260() {
    level flag::wait_till("all_players_spawned");
    util::wait_network_frame();
    util::wait_network_frame();
    foreach (e_player in level.players) {
        e_player clientfield::increment_to_player("umbra_tome_singapore");
    }
}

// Namespace namespace_3d19ef22
// Params 2, eflags: 0x1 linked
// namespace_3d19ef22<file_0>::function_95b88092
// Checksum 0xbc99fb18, Offset: 0x18d8
// Size: 0x254
function function_95b88092(str_objective, var_74cd64bc) {
    if (isdefined(var_74cd64bc) && var_74cd64bc) {
        load::function_73adcefc();
        load::function_a2995f22();
        skipto::teleport_players(str_objective, 0);
        array::thread_all(level.players, &namespace_8e9083ff::function_39af75ef, "singapore_root_completed");
        level thread function_252e350();
        namespace_8e9083ff::function_4d032f25(1, 0.5);
        level thread namespace_8e9083ff::function_c90e23b6(str_objective);
    }
    if (isdefined(level.var_aeb7161b)) {
        level thread [[ level.var_aeb7161b ]]();
    }
    level thread scene::init("singapore_fxanim_heart_ceiling", "targetname");
    exploder::exploder("heartLightsSing");
    level thread namespace_67110270::function_973b77f9();
    self namespace_8e9083ff::function_b0f0dd1f(0);
    level thread function_4b2f6f7();
    if (level.players === 1) {
        savegame::checkpoint_save();
    }
    var_8fb0849a = namespace_8e9083ff::function_a1851f86(str_objective);
    var_8fb0849a waittill(#"hash_40b1a9d9");
    level thread namespace_bbb4ee72::function_b319df2(str_objective, var_8fb0849a.var_90971f20.e_player);
    if (isdefined(level.var_3e0291d0)) {
        [[ level.var_3e0291d0 ]]();
    }
    videostop("cp_zurich_env_corvusmonitor");
    util::clientnotify("stp_mus");
}

// Namespace namespace_3d19ef22
// Params 4, eflags: 0x1 linked
// namespace_3d19ef22<file_0>::function_c68a0705
// Checksum 0xc4eb2684, Offset: 0x1b38
// Size: 0x8c
function function_c68a0705(str_objective, var_74cd64bc, var_e4cd2b8b, player) {
    level thread function_c38b8260();
    var_ef0ea28e = getentarray("singapore_cover", "targetname");
    array::run_all(var_ef0ea28e, &delete);
}

// Namespace namespace_3d19ef22
// Params 4, eflags: 0x1 linked
// namespace_3d19ef22<file_0>::function_53a05865
// Checksum 0x493158db, Offset: 0x1bd0
// Size: 0x7c
function function_53a05865(str_objective, var_74cd64bc, var_e4cd2b8b, player) {
    level notify(#"hash_73b00182");
    callback::remove_on_spawned(&function_db4d091);
    level.var_1895e0f9 = undefined;
    level thread namespace_8e9083ff::function_4a00a473("root_singapore");
}

// Namespace namespace_3d19ef22
// Params 0, eflags: 0x1 linked
// namespace_3d19ef22<file_0>::function_efc52a3e
// Checksum 0xae3f5ce2, Offset: 0x1c58
// Size: 0x3bc
function function_efc52a3e() {
    level endon(#"hash_8ba64bc4");
    level flag::wait_till("flag_singapore_root_monologue_01");
    level dialog::function_13b3b16a("plyr_listen_only_to_the_s_2", 3);
    level dialog::function_13b3b16a("plyr_let_your_mind_relax_2", 3);
    level dialog::function_13b3b16a("plyr_let_your_thoughts_dr_2", 3);
    level dialog::function_13b3b16a("plyr_let_the_bad_memories_2", 3);
    level dialog::function_13b3b16a("plyr_let_peace_be_upon_yo_2", 3);
    level flag::wait_till("flag_singapore_root_monologue_02");
    level dialog::function_13b3b16a("plyr_surrender_yourself_t_2", 3);
    level dialog::function_13b3b16a("plyr_let_them_wash_over_y_2", 3);
    level dialog::function_13b3b16a("plyr_imagine_somewhere_ca_2", 3);
    level dialog::function_13b3b16a("plyr_imagine_somewhere_sa_2", 3);
    level dialog::function_13b3b16a("plyr_imagine_yourself_2", 3);
    level flag::set("flag_singapore_root_monologue_02_done");
    level flag::wait_till_all(array("flag_salim_cognititve_neural_vo_done", "flag_singapore_root_monologue_03"));
    level dialog::function_13b3b16a("plyr_you_are_standing_in_2", 3);
    level dialog::function_13b3b16a("plyr_the_trees_around_you_2", 3);
    level dialog::function_13b3b16a("plyr_pure_white_snowflake_2", 3);
    level dialog::function_13b3b16a("plyr_you_can_feel_them_me_2", 3);
    level dialog::function_13b3b16a("plyr_you_are_not_cold_2", 3);
    level dialog::function_13b3b16a("plyr_it_cannot_overcome_t_2", 3);
    level flag::wait_till("flag_singapore_root_monologue_04");
    level dialog::function_13b3b16a("plyr_can_you_hear_it_2", 3);
    level dialog::function_13b3b16a("plyr_you_only_have_to_lis_2", 3);
    level dialog::function_13b3b16a("plyr_do_you_hear_it_slowi_2", 3);
    level dialog::function_13b3b16a("plyr_you_are_slowing_it_2", 3);
    level dialog::function_13b3b16a("plyr_you_are_in_control_4", 3);
    level dialog::function_13b3b16a("plyr_calm_2", 3);
    level dialog::function_13b3b16a("plyr_at_peace_2", 3);
    level flag::set("flag_singapore_root_monologue_04_done");
}

// Namespace namespace_3d19ef22
// Params 0, eflags: 0x1 linked
// namespace_3d19ef22<file_0>::function_23a51944
// Checksum 0x302bddf1, Offset: 0x2020
// Size: 0x9c
function function_23a51944() {
    wait(2);
    level dialog::remote("hcor_rachel_kane_never_ha_0", 1, "NO_DNI");
    level thread namespace_67110270::function_65e1e4b4();
    level dialog::remote("hcor_but_you_can_still_ma_0", 1, "NO_DNI");
    level flag::set("flag_hall_sing_intro_vo_done");
}

// Namespace namespace_3d19ef22
// Params 1, eflags: 0x1 linked
// namespace_3d19ef22<file_0>::function_49b9e027
// Checksum 0x2dd7b72, Offset: 0x20c8
// Size: 0x104
function function_49b9e027(str_objective) {
    level endon(str_objective + "enter_vortex");
    level flag::wait_till("flag_hall_sing_intro_vo_done");
    wait(3);
    level notify(#"hash_d3c69346");
    level.var_1c26230b dialog::say("tayr_you_ve_just_got_to_h_0");
    level.var_1c26230b dialog::say("tayr_if_we_can_breach_the_0", 1);
    wait(5);
    level thread function_efc52a3e();
    level flag::wait_till("flag_taylor_vo_just_stay_with_me");
    if (flag::get("flag_singapore_root_monologue_02_done")) {
        level.var_1c26230b dialog::say("tayr_just_stay_with_me_1");
    }
}

// Namespace namespace_3d19ef22
// Params 0, eflags: 0x1 linked
// namespace_3d19ef22<file_0>::function_4b2f6f7
// Checksum 0xcbe6d28, Offset: 0x21d8
// Size: 0x8c
function function_4b2f6f7() {
    level endon(#"hash_8ba64bc4");
    level flag::wait_till("flag_singapore_root_monologue_04_done");
    level dialog::remote("salm_as_with_any_ground_b_0", 4, "NO_DNI");
    level dialog::remote("salm_should_the_internati_0", 1, "NO_DNI");
}

// Namespace namespace_3d19ef22
// Params 0, eflags: 0x1 linked
// namespace_3d19ef22<file_0>::function_54fbadd1
// Checksum 0xd2ec553e, Offset: 0x2270
// Size: 0x84
function function_54fbadd1() {
    trigger::wait_till("t_sing_swim_salim_vo");
    if (flag::get("flag_singapore_root_monologue_02_done")) {
        level dialog::remote("salm_cognitive_neural_int_0", 1, "NO_DNI");
    }
    level flag::set("flag_salim_cognititve_neural_vo_done");
}

// Namespace namespace_3d19ef22
// Params 1, eflags: 0x1 linked
// namespace_3d19ef22<file_0>::function_c9c3556c
// Checksum 0x70ba8342, Offset: 0x2300
// Size: 0x1dc
function function_c9c3556c(str_objective) {
    array::run_all(level.players, &freezecontrols, 1);
    array::run_all(level.players, &enableinvulnerability);
    array::run_all(level.players, &util::show_hud, 0);
    wait(2);
    level thread util::screen_fade_in(1);
    array::thread_all(level.players, &clientfield::increment_to_player, "postfx_transition");
    playsoundatposition("evt_clearing_trans_in", (0, 0, 0));
    level namespace_8e9083ff::function_c90e23b6(str_objective, "breadcrumb_singroot_3");
    level.var_1c26230b ai::set_ignoreall(1);
    array::run_all(level.players, &freezecontrols, 0);
    array::run_all(level.players, &disableinvulnerability);
    array::run_all(level.players, &util::show_hud, 1);
    util::clear_streamer_hint();
    savegame::checkpoint_save();
}

// Namespace namespace_3d19ef22
// Params 1, eflags: 0x1 linked
// namespace_3d19ef22<file_0>::function_3893ad5c
// Checksum 0x34d56dc1, Offset: 0x24e8
// Size: 0x11c
function function_3893ad5c(str_objective) {
    b_in_water = 1;
    wait(1);
    if (isdefined(level.var_4354053d)) {
        level thread [[ level.var_4354053d ]]();
    }
    while (b_in_water) {
        foreach (e_player in level.activeplayers) {
            if (!e_player isplayerunderwater()) {
                b_in_water = 0;
            }
        }
        wait(0.05);
    }
    level.var_1c26230b ai::set_ignoreall(0);
    level thread function_49b9e027(str_objective);
}

// Namespace namespace_3d19ef22
// Params 1, eflags: 0x1 linked
// namespace_3d19ef22<file_0>::function_eb271a4b
// Checksum 0x31d8e255, Offset: 0x2610
// Size: 0x156
function function_eb271a4b(str_objective) {
    level endon(str_objective + "_done");
    level endon(#"hash_73b00182");
    for (var_b1cdbf1d = 0; true; var_b1cdbf1d++) {
        var_f6e695c0 = struct::get("breadcrumb_singroot_" + var_b1cdbf1d, "targetname");
        var_b1fe230f = getent("t_singroot_" + var_b1cdbf1d, "script_noteworthy");
        if (!isdefined(var_f6e695c0) || !isdefined(var_b1fe230f)) {
            return;
        }
        objectives::set("cp_waypoint_breadcrumb", var_f6e695c0);
        var_b1fe230f waittill(#"trigger");
        level notify(#"next_checkpoint");
        savegame::checkpoint_save();
        if (var_b1cdbf1d == 2) {
            level thread function_26f61e7c();
        }
        objectives::complete("cp_waypoint_breadcrumb", var_f6e695c0);
    }
}

// Namespace namespace_3d19ef22
// Params 0, eflags: 0x1 linked
// namespace_3d19ef22<file_0>::function_26f61e7c
// Checksum 0x22834404, Offset: 0x2770
// Size: 0x24
function function_26f61e7c() {
    level namespace_8e9083ff::function_b0f0dd1f(1, "red_rain");
}

// Namespace namespace_3d19ef22
// Params 0, eflags: 0x1 linked
// namespace_3d19ef22<file_0>::function_8842e57d
// Checksum 0xa012b0c0, Offset: 0x27a0
// Size: 0x58
function function_8842e57d() {
    var_d5aeed2b = getentarray("root_sing_cover", "targetname");
    var_d5aeed2b = array::thread_all(var_d5aeed2b, &function_258afdfc);
}

// Namespace namespace_3d19ef22
// Params 0, eflags: 0x1 linked
// namespace_3d19ef22<file_0>::function_258afdfc
// Checksum 0x5078d27c, Offset: 0x2800
// Size: 0x27a
function function_258afdfc() {
    var_482d5204 = struct::get_array(self.target, "targetname");
    assert(isdefined(var_482d5204), "vortex_explode");
    foreach (s_cover in var_482d5204) {
        assert(isdefined(s_cover.model), "vortex_explode");
        assert(isdefined(s_cover.target), "vortex_explode");
        if (isdefined(s_cover.script_string)) {
            var_a8a64a67 = getnodearray(s_cover.script_string, "targetname");
            foreach (var_974cc07 in var_a8a64a67) {
                setenablenode(var_974cc07, 0);
            }
        }
    }
    self waittill(#"trigger");
    foreach (s_cover in var_482d5204) {
        s_cover thread function_375f158a();
    }
}

// Namespace namespace_3d19ef22
// Params 0, eflags: 0x1 linked
// namespace_3d19ef22<file_0>::function_375f158a
// Checksum 0xb6848f2a, Offset: 0x2a88
// Size: 0x11c
function function_375f158a() {
    wait(randomfloat(2));
    var_4b1dfeae = util::spawn_model(self.model, self.origin, self.angles);
    var_4b1dfeae.var_1069f2d4 = struct::get(self.target, "targetname");
    var_4b1dfeae.targetname = "singapore_cover";
    if (isdefined(self.script_fxid)) {
        var_4b1dfeae.script_fxid = self.script_fxid;
    }
    if (isdefined(self.script_string)) {
        var_4b1dfeae.script_string = self.script_string;
        var_4b1dfeae thread function_e8047245();
    }
    var_4b1dfeae thread function_14bb726e();
    var_4b1dfeae thread function_1bf4af4f();
}

// Namespace namespace_3d19ef22
// Params 0, eflags: 0x1 linked
// namespace_3d19ef22<file_0>::function_14bb726e
// Checksum 0xcb72c4fa, Offset: 0x2bb0
// Size: 0x14c
function function_14bb726e() {
    n_move_time = randomfloatrange(0.5, 1.25);
    self moveto(self.var_1069f2d4.origin, n_move_time);
    self rotateto(self.var_1069f2d4.angles, n_move_time);
    self waittill(#"movedone");
    self solid();
    self playrumbleonentity("damage_heavy");
    playsoundatposition("evt_floor_debris_big", self.origin);
    if (isdefined(self.script_fxid)) {
        playfxontag(level._effect[self.script_fxid], self, "tag_origin");
        return;
    }
    playfxontag(level._effect["dirt_impact_lg"], self, "tag_origin");
}

// Namespace namespace_3d19ef22
// Params 0, eflags: 0x1 linked
// namespace_3d19ef22<file_0>::function_e8047245
// Checksum 0x11e1e97d, Offset: 0x2d08
// Size: 0xc2
function function_e8047245() {
    var_a8a64a67 = getnodearray(self.script_string, "targetname");
    self waittill(#"movedone");
    foreach (var_974cc07 in var_a8a64a67) {
        setenablenode(var_974cc07, 1);
    }
}

// Namespace namespace_3d19ef22
// Params 0, eflags: 0x1 linked
// namespace_3d19ef22<file_0>::function_1bf4af4f
// Checksum 0x44bfb5f2, Offset: 0x2dd8
// Size: 0x3c
function function_1bf4af4f() {
    self endon(#"delete");
    level waittill(#"hash_4bb2007e");
    if (isdefined(self)) {
        self delete();
    }
}

// Namespace namespace_3d19ef22
// Params 0, eflags: 0x1 linked
// namespace_3d19ef22<file_0>::function_a0e6701b
// Checksum 0xfe6bcc06, Offset: 0x2e20
// Size: 0x54
function function_a0e6701b() {
    var_95ff9697 = getentarray("sing_falling_destructible", "script_noteworthy");
    array::thread_all(var_95ff9697, &function_514e0b2e);
}

// Namespace namespace_3d19ef22
// Params 0, eflags: 0x1 linked
// namespace_3d19ef22<file_0>::function_514e0b2e
// Checksum 0xf333bd19, Offset: 0x2e80
// Size: 0x184
function function_514e0b2e() {
    if (self.classname === "script_model") {
        n_move_time = randomfloatrange(0.75, 1.5);
        self hide();
        self.t_radius = spawn("trigger_radius", self.origin, 0, 1024, -128);
        self movez(1024, 0.05);
        self.t_radius waittill(#"trigger");
        self.t_radius delete();
        self show();
        self movez(-1024, n_move_time);
        self waittill(#"movedone");
        self playrumbleonentity("damage_heavy");
        playsoundatposition("evt_floor_debris_big", self.origin);
        playfxontag(level._effect["dirt_impact_md"], self, "tag_origin");
    }
}

// Namespace namespace_3d19ef22
// Params 0, eflags: 0x1 linked
// namespace_3d19ef22<file_0>::function_29073d62
// Checksum 0xa2697d14, Offset: 0x3010
// Size: 0x64
function function_29073d62() {
    level scene::init("p7_fxanim_cp_zurich_container_collapse_bundle");
    trigger::wait_till("container_fxanim", "script_noteworthy");
    level scene::play("p7_fxanim_cp_zurich_container_collapse_bundle");
}

// Namespace namespace_3d19ef22
// Params 0, eflags: 0x1 linked
// namespace_3d19ef22<file_0>::function_4402ab63
// Checksum 0x7de8d6a, Offset: 0x3080
// Size: 0x182
function function_4402ab63() {
    trigger::wait_till("t_singroot_1", "script_noteworthy");
    level thread scene::play("p7_fxanim_cp_zurich_ferris_wheel_bundle");
    level thread scene::play("p7_fxanim_cp_zurich_ferris_wheel_wave_bundle");
    foreach (player in level.activeplayers) {
        player playrumbleonentity("damage_heavy");
    }
    level waittill(#"hash_55a06ec6");
    foreach (player in level.activeplayers) {
        player playrumbleonentity("cp_zurich_ferris_wheel_fall");
    }
}

// Namespace namespace_3d19ef22
// Params 1, eflags: 0x1 linked
// namespace_3d19ef22<file_0>::function_8fbe0681
// Checksum 0xa060d1c3, Offset: 0x3210
// Size: 0x22c
function function_8fbe0681(a_ents) {
    var_32cdba86 = a_ents["zurich_ferris_wheel_wave"];
    var_29f7937 = "zur_wave_jnt";
    var_8b856a66 = spawn("trigger_box", var_32cdba86 gettagorigin(var_29f7937), 0, -128, 1200, -128);
    var_8b856a66.angles = var_32cdba86 gettagangles(var_29f7937);
    var_8b856a66 enablelinkto();
    var_8b856a66 linkto(var_32cdba86, var_29f7937, (0, 0, 0), (0, 30, 0));
    foreach (player in level.players) {
        var_8b856a66 thread function_32d3b286(player);
    }
    var_8b856a66 thread function_9ea9bed();
    wait(0.05);
    var_32cdba86 clientfield::set("water_disturbance", 1);
    level waittill(#"hash_99c4740a");
    var_32cdba86 clientfield::set("water_disturbance", 0);
    level notify(#"hash_eb78e4c5");
    var_8b856a66 delete();
}

// Namespace namespace_3d19ef22
// Params 1, eflags: 0x1 linked
// namespace_3d19ef22<file_0>::function_32d3b286
// Checksum 0x188f5a06, Offset: 0x3448
// Size: 0x13c
function function_32d3b286(player) {
    self endon(#"death");
    self endon(#"hash_4735ec09");
    player endon(#"death");
    while (true) {
        var_4a36ffac = self waittill(#"trigger");
        if (var_4a36ffac == player && !(isdefined(player.var_1cd4d4e6) && player.var_1cd4d4e6)) {
            player.var_1cd4d4e6 = 1;
            player thread function_b8c35195(self);
            if (isplayer(player) && player istouching(self)) {
                player thread function_c61ca0be(self);
                player thread function_adade905(self);
                player playsound("evt_surge_impact");
                break;
            }
        }
    }
}

// Namespace namespace_3d19ef22
// Params 1, eflags: 0x1 linked
// namespace_3d19ef22<file_0>::function_b8c35195
// Checksum 0x1c3029da, Offset: 0x3590
// Size: 0x70
function function_b8c35195(var_12377408) {
    self endon(#"death");
    while (isdefined(var_12377408) && self istouching(var_12377408)) {
        wait(0.05);
    }
    self.var_1cd4d4e6 = 0;
    if (isdefined(var_12377408)) {
        var_12377408 notify(#"hash_4735ec09");
    }
}

// Namespace namespace_3d19ef22
// Params 1, eflags: 0x1 linked
// namespace_3d19ef22<file_0>::function_adade905
// Checksum 0x80ab015b, Offset: 0x3608
// Size: 0x58
function function_adade905(var_59ed1f41) {
    self endon(#"death");
    var_59ed1f41 endon(#"hash_4735ec09");
    while (true) {
        self playrumbleonentity("damage_heavy");
        wait(0.1);
    }
}

// Namespace namespace_3d19ef22
// Params 1, eflags: 0x1 linked
// namespace_3d19ef22<file_0>::function_c61ca0be
// Checksum 0x3983ba0d, Offset: 0x3668
// Size: 0x90
function function_c61ca0be(var_59ed1f41) {
    self endon(#"death");
    var_59ed1f41 endon(#"hash_4735ec09");
    while (true) {
        if (!(isdefined(self.laststand) && self.laststand)) {
            self setvelocity(anglestoforward((0, 345, 0)) * -56);
        }
        wait(0.05);
    }
}

// Namespace namespace_3d19ef22
// Params 0, eflags: 0x1 linked
// namespace_3d19ef22<file_0>::function_9ea9bed
// Checksum 0xbe8c53ff, Offset: 0x3700
// Size: 0xc8
function function_9ea9bed() {
    self endon(#"death");
    self endon(#"hash_4735ec09");
    while (true) {
        var_480743 = self waittill(#"trigger");
        if (isalive(var_480743) && var_480743.team == "axis" && !(isdefined(var_480743.var_284432c3) && var_480743.var_284432c3)) {
            var_480743.var_284432c3 = 1;
            var_480743 thread function_3de3b792(self);
        }
    }
}

// Namespace namespace_3d19ef22
// Params 1, eflags: 0x1 linked
// namespace_3d19ef22<file_0>::function_3de3b792
// Checksum 0xcdbd8854, Offset: 0x37d0
// Size: 0x94
function function_3de3b792(var_12377408) {
    self endon(#"death");
    v_dir = vectornormalize(self.origin - var_12377408.origin);
    self startragdoll();
    self launchragdoll(v_dir * 75);
    self kill();
}

// Namespace namespace_3d19ef22
// Params 0, eflags: 0x1 linked
// namespace_3d19ef22<file_0>::function_95353712
// Checksum 0x3c5d06b0, Offset: 0x3870
// Size: 0x74
function function_95353712() {
    var_c44abb6a = getent("t_singroot_car1", "targetname");
    level thread scene::init("p7_fxanim_cp_zurich_car_slide_bundle");
    var_c44abb6a waittill(#"trigger");
    level thread scene::play("p7_fxanim_cp_zurich_car_slide_bundle");
}

// Namespace namespace_3d19ef22
// Params 0, eflags: 0x1 linked
// namespace_3d19ef22<file_0>::function_252e350
// Checksum 0xb988ee19, Offset: 0x38f0
// Size: 0xc4
function function_252e350() {
    if (level flag::get("sing_root_depthcharges")) {
        return;
    }
    level flag::set("sing_root_depthcharges");
    level thread namespace_e9d9fb34::function_62b0213a();
    var_8edc0313 = struct::get_array("singapore_depth_charge", "targetname");
    array::thread_all(var_8edc0313, &function_26a0a902);
    level thread function_1c297ab3();
}

// Namespace namespace_3d19ef22
// Params 0, eflags: 0x1 linked
// namespace_3d19ef22<file_0>::function_26a0a902
// Checksum 0x79af2c93, Offset: 0x39c0
// Size: 0x14e
function function_26a0a902() {
    level endon(#"hash_cc8de88d");
    self endon(#"hash_f9256645");
    self thread function_6a938164();
    n_spawned = 0;
    wait(1);
    while (3 > n_spawned) {
        var_2d4569cf = self function_dabb79d8();
        n_spawned++;
        if (isdefined(var_2d4569cf)) {
            s_target = struct::get(self.target, "targetname");
            if (isdefined(s_target)) {
                var_2d4569cf thread function_c51242e1(s_target);
            }
            var_2d4569cf.targetname = "depth_charger_dive";
            var_2d4569cf thread function_f788b8ae();
            var_2d4569cf thread function_c775e8da(-56);
            var_2d4569cf waittill(#"exploded");
            wait(randomfloatrange(1.5, 3));
            continue;
        }
        return;
    }
}

// Namespace namespace_3d19ef22
// Params 0, eflags: 0x1 linked
// namespace_3d19ef22<file_0>::function_1c297ab3
// Checksum 0x55eb819f, Offset: 0x3b18
// Size: 0x44
function function_1c297ab3() {
    trigger::wait_till("stop_depth_charges");
    level notify(#"hash_cc8de88d");
    level flag::clear("sing_root_depthcharges");
}

// Namespace namespace_3d19ef22
// Params 0, eflags: 0x1 linked
// namespace_3d19ef22<file_0>::function_6a938164
// Checksum 0x8d27ad79, Offset: 0x3b68
// Size: 0xa0
function function_6a938164() {
    self endon(#"hash_f9256645");
    level endon(#"hash_cc8de88d");
    while (true) {
        e_player = arraygetclosest(self.origin, level.activeplayers);
        if (isdefined(e_player) && distance(e_player.origin, self.origin) < 256) {
            self notify(#"hash_f9256645");
        }
        wait(0.1);
    }
}

// Namespace namespace_3d19ef22
// Params 0, eflags: 0x1 linked
// namespace_3d19ef22<file_0>::function_dabb79d8
// Checksum 0x8ffe6d03, Offset: 0x3c10
// Size: 0x140
function function_dabb79d8() {
    playfx(level._effect["depth_charge_spawn"], self.origin);
    wait(0.2);
    var_2d4569cf = util::spawn_model("veh_t7_drone_depth_charge", self.origin, (randomint(360), randomint(360), randomint(360)));
    if (isdefined(var_2d4569cf)) {
        var_2d4569cf.script_noteworthy = "depth_charge_model";
        var_2d4569cf setcandamage(1);
        var_2d4569cf.health = 999999;
        var_2d4569cf clientfield::set("sm_depth_charge_fx", 1);
        var_2d4569cf thread function_9e34c3b5();
    }
    return var_2d4569cf;
}

// Namespace namespace_3d19ef22
// Params 2, eflags: 0x1 linked
// namespace_3d19ef22<file_0>::function_c51242e1
// Checksum 0x8af3b017, Offset: 0x3d58
// Size: 0x114
function function_c51242e1(s_target, var_253d1f97) {
    self endon(#"death");
    while (isdefined(s_target)) {
        n_distance = distance(self.origin, s_target.origin);
        n_time = n_distance / 100;
        self moveto(s_target.origin, n_time);
        self waittill(#"movedone");
        if (isdefined(s_target.target)) {
            s_target = struct::get(s_target.target, "targetname");
            continue;
        }
        s_target = undefined;
    }
    level.var_e83d53e9 = 1;
    self function_6493f00e();
}

// Namespace namespace_3d19ef22
// Params 0, eflags: 0x1 linked
// namespace_3d19ef22<file_0>::function_9e34c3b5
// Checksum 0x28870afb, Offset: 0x3e78
// Size: 0x64
function function_9e34c3b5() {
    self endon(#"death");
    damage, e_attacker = self waittill(#"damage");
    self function_6493f00e(isdefined(e_attacker) && isplayer(e_attacker));
}

// Namespace namespace_3d19ef22
// Params 0, eflags: 0x1 linked
// namespace_3d19ef22<file_0>::function_f788b8ae
// Checksum 0x34b205da, Offset: 0x3ee8
// Size: 0x64
function function_f788b8ae() {
    self endon(#"death");
    n_fuse_time = randomfloatrange(12, 32);
    wait(n_fuse_time);
    level.var_e83d53e9 = 1;
    self function_6493f00e();
}

// Namespace namespace_3d19ef22
// Params 1, eflags: 0x1 linked
// namespace_3d19ef22<file_0>::function_6493f00e
// Checksum 0x522e707c, Offset: 0x3f58
// Size: 0x1fa
function function_6493f00e(var_e0c598de) {
    if (!isdefined(var_e0c598de)) {
        var_e0c598de = 0;
    }
    if (!isdefined(self)) {
        return;
    }
    v_origin = self.origin;
    self radiusdamage(v_origin, -56, 80, 40, self);
    playrumbleonposition("depth_charge_rumble", v_origin);
    self notify(#"exploded");
    if (self.classname === "script_model") {
        playfx(level._effect["depth_charge_explosion"], v_origin);
        playsoundatposition("exp_drone_underwater", v_origin);
        self util::self_delete();
    }
    wait(0.1);
    if (isdefined(var_e0c598de) && var_e0c598de) {
        var_f83c5536 = getentarray("depth_charge_model", "script_noteworthy");
        var_f83c5536 = arraysortclosest(var_f83c5536, v_origin, undefined, 0, 120);
        foreach (var_2d4569cf in var_f83c5536) {
            var_2d4569cf function_6493f00e();
        }
    }
}

// Namespace namespace_3d19ef22
// Params 1, eflags: 0x1 linked
// namespace_3d19ef22<file_0>::function_c775e8da
// Checksum 0x8f994307, Offset: 0x4160
// Size: 0x1f8
function function_c775e8da(var_7a998a01) {
    if (!isdefined(var_7a998a01)) {
        var_7a998a01 = -56;
    }
    self endon(#"death");
    while (true) {
        foreach (e_player in level.activeplayers) {
            if (!e_player isinmovemode("ufo", "noclip")) {
                if (distancesquared(e_player.origin, self.origin) < var_7a998a01 * var_7a998a01 && !e_player laststand::player_is_in_laststand()) {
                    self.var_ab9199df = e_player;
                    level.var_e83d53e9 = 1;
                    self function_6493f00e();
                }
            }
            if (self.classname === "script_model") {
                if (distancesquared(self.origin, e_player.origin) < var_7a998a01 * 1.8 * var_7a998a01 * 1.8) {
                    self clientfield::set("sm_depth_charge_fx", 0);
                    continue;
                }
                self clientfield::set("sm_depth_charge_fx", 1);
            }
        }
        wait(0.1);
    }
}

