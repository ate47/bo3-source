#using scripts/shared/ai/robot_phalanx;
#using scripts/shared/ai/phalanx;
#using scripts/cp/cybercom/_cybercom_gadget_immolation;
#using scripts/cp/cybercom/_cybercom_util;
#using scripts/cp/cybercom/_cybercom;
#using scripts/cp/cp_mi_zurich_newworld_train;
#using scripts/cp/cp_mi_zurich_newworld_sound;
#using scripts/cp/cp_mi_zurich_newworld_util;
#using scripts/cp/cp_mi_zurich_newworld;
#using scripts/cp/gametypes/_save;
#using scripts/cp/gametypes/_battlechatter;
#using scripts/cp/_hacking;
#using scripts/cp/cybercom/_cybercom_gadget;
#using scripts/cp/_util;
#using scripts/cp/_spawn_manager;
#using scripts/cp/_skipto;
#using scripts/cp/_oed;
#using scripts/cp/_objectives;
#using scripts/cp/_load;
#using scripts/cp/_dialog;
#using scripts/shared/lui_shared;
#using scripts/shared/gameobjects_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/vehicle_shared;
#using scripts/shared/util_shared;
#using scripts/shared/trigger_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/fx_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/colors_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/array_shared;
#using scripts/shared/ai_shared;
#using scripts/codescripts/struct;

#namespace namespace_2f45a7a1;

// Namespace namespace_2f45a7a1
// Params 1, eflags: 0x0
// namespace_2f45a7a1<file_0>::function_8c89c9ea
// Checksum 0x168ac3e3, Offset: 0x2310
// Size: 0x92
function function_8c89c9ea(str_objective) {
    level thread function_9ff60068();
    level.var_4d745c5c = util::function_740f8516("maretti");
    level.var_4d745c5c thread namespace_ce0e5f06::function_921d7387();
    skipto::teleport_ai(str_objective);
    exploder::exploder("exp_pinneddown_light");
    objectives::set("cp_level_newworld_underground_locate_terrorist");
}

// Namespace namespace_2f45a7a1
// Params 0, eflags: 0x0
// namespace_2f45a7a1<file_0>::function_9ff60068
// Checksum 0xe36110ed, Offset: 0x23b0
// Size: 0x1bb
function function_9ff60068() {
    level scene::add_scene_func("p7_fxanim_cp_newworld_icicles_01_bundle", &function_54536d43, "init");
    level scene::add_scene_func("p7_fxanim_cp_newworld_icicles_01_h2_bundle", &function_54536d43, "init");
    level scene::add_scene_func("p7_fxanim_cp_newworld_icicles_01_h3_bundle", &function_54536d43, "init");
    level scene::add_scene_func("p7_fxanim_cp_newworld_icicles_01_h4_bundle", &function_54536d43, "init");
    level scene::add_scene_func("p7_fxanim_cp_newworld_icicles_01_h5_bundle", &function_54536d43, "init");
    level scene::add_scene_func("p7_fxanim_cp_newworld_icicles_01_h6_bundle", &function_54536d43, "init");
    var_11a2919d = struct::get_array("icicle", "targetname");
    foreach (var_6d540b32 in var_11a2919d) {
        var_6d540b32 scene::init();
        util::wait_network_frame();
    }
}

// Namespace namespace_2f45a7a1
// Params 1, eflags: 0x0
// namespace_2f45a7a1<file_0>::function_54536d43
// Checksum 0xc4c70742, Offset: 0x2578
// Size: 0x6a
function function_54536d43(a_ents) {
    level endon(#"hash_3cf7368e");
    var_f6493330 = a_ents["icicle"];
    do {
        n_damage, attacker = var_f6493330 waittill(#"damage");
    } while (n_damage <= 1);
    self thread scene::play();
    var_f6493330 thread function_1c32a954(attacker);
}

// Namespace namespace_2f45a7a1
// Params 1, eflags: 0x0
// namespace_2f45a7a1<file_0>::function_1c32a954
// Checksum 0xd640962, Offset: 0x25f0
// Size: 0x1a2
function function_1c32a954(attacker) {
    ground_trace = bullettrace(self.origin, self.origin + (0, 0, -1000), 0, self);
    v_ground = ground_trace["position"];
    a_ai = util::get_array_of_closest(v_ground, getaiteamarray("axis"), undefined, undefined, 64);
    foreach (ai in a_ai) {
        if (isalive(ai) && ai.archetype == "human") {
            ai thread scene::play("cin_new_vign_icicle_death_male0" + randomintrange(1, 4), ai);
        }
    }
    self waittill(#"hash_bc75666f");
    if (isdefined(attacker)) {
        attacker.weap = "icicle";
        self radiusdamage(v_ground, 64, 500, 400, attacker);
        attacker.weap = undefined;
        return;
    }
    self radiusdamage(v_ground, 64, 500, 400);
}

// Namespace namespace_2f45a7a1
// Params 1, eflags: 0x0
// namespace_2f45a7a1<file_0>::function_3293dfe7
// Checksum 0xf5167caa, Offset: 0x27a0
// Size: 0x4b
function function_3293dfe7(params) {
    if (isplayer(params.eattacker) && params.eattacker.weap === "icicle") {
        level notify(#"hash_5308cf63");
    }
}

// Namespace namespace_2f45a7a1
// Params 0, eflags: 0x0
// namespace_2f45a7a1<file_0>::function_6bd39ac8
// Checksum 0xe4f561e4, Offset: 0x27f8
// Size: 0x22
function function_6bd39ac8() {
    self thread function_f86fbc8c();
    self thread function_d2e40f97();
}

// Namespace namespace_2f45a7a1
// Params 0, eflags: 0x0
// namespace_2f45a7a1<file_0>::function_f86fbc8c
// Checksum 0x5235d02a, Offset: 0x2828
// Size: 0x55
function function_f86fbc8c() {
    self notify(#"hash_dc00f162");
    self endon(#"hash_dc00f162");
    self endon(#"death");
    level endon(#"hash_3cf7368e");
    while (true) {
        e_grenade = self waittill(#"grenade_fire");
        level thread function_a3720132(e_grenade);
    }
}

// Namespace namespace_2f45a7a1
// Params 0, eflags: 0x0
// namespace_2f45a7a1<file_0>::function_d2e40f97
// Checksum 0x91110a93, Offset: 0x2888
// Size: 0x55
function function_d2e40f97() {
    self notify(#"hash_318f6bcd");
    self endon(#"hash_318f6bcd");
    self endon(#"death");
    level endon(#"hash_3cf7368e");
    while (true) {
        e_projectile = self waittill(#"missile_fire");
        level thread function_a3720132(e_projectile);
    }
}

// Namespace namespace_2f45a7a1
// Params 1, eflags: 0x0
// namespace_2f45a7a1<file_0>::function_a3720132
// Checksum 0x123978ab, Offset: 0x28e8
// Size: 0x5a
function function_a3720132(e_weapon) {
    if (e_weapon.classname === "rocket") {
        v_pos = e_weapon waittill(#"projectile_impact_explode");
    } else {
        v_pos = e_weapon waittill(#"explode");
    }
    function_13a9f3bd(v_pos);
}

// Namespace namespace_2f45a7a1
// Params 1, eflags: 0x0
// namespace_2f45a7a1<file_0>::function_13a9f3bd
// Checksum 0x24666523, Offset: 0x2950
// Size: 0xef
function function_13a9f3bd(v_pos) {
    var_9f868d70 = 0;
    var_21c585fb = getentarray("icicle", "targetname");
    foreach (var_f6493330 in var_21c585fb) {
        n_dist = distance2d(var_f6493330.origin, v_pos);
        if (n_dist < 320) {
            var_f6493330 dodamage(1000, var_f6493330.origin);
            var_9f868d70++;
        }
        if (var_9f868d70 >= 2) {
            return;
        }
    }
}

// Namespace namespace_2f45a7a1
// Params 2, eflags: 0x0
// namespace_2f45a7a1<file_0>::function_78f1dce
// Checksum 0xb3d7ac2d, Offset: 0x2a48
// Size: 0x112
function function_78f1dce(str_objective, var_74cd64bc) {
    level thread function_8c89c9ea(str_objective);
    if (var_74cd64bc) {
        load::function_73adcefc();
        load::function_a2995f22();
        level thread namespace_ce0e5f06::function_30ec5bf7(1);
    } else {
        foreach (player in level.players) {
            player namespace_ce0e5f06::on_player_loadout();
        }
    }
    namespace_ce0e5f06::function_3383b379();
    battlechatter::function_d9f49fba(0);
    skipto::teleport(str_objective);
    function_3f7c354c();
    skipto::function_be8adfb8(str_objective);
}

// Namespace namespace_2f45a7a1
// Params 4, eflags: 0x0
// namespace_2f45a7a1<file_0>::function_2595088
// Checksum 0x1ea89f31, Offset: 0x2b68
// Size: 0xa2
function function_2595088(str_objective, var_74cd64bc, var_e4cd2b8b, player) {
    level clientfield::set("underground_subway_wires", 1);
    array::thread_all(level.activeplayers, &function_6bd39ac8);
    callback::on_spawned(&function_6bd39ac8);
    callback::on_ai_killed(&function_177b3b6e);
}

// Namespace namespace_2f45a7a1
// Params 0, eflags: 0x0
// namespace_2f45a7a1<file_0>::function_3f7c354c
// Checksum 0x666d8b61, Offset: 0x2c18
// Size: 0x1a2
function function_3f7c354c() {
    scene::init("cin_new_10_01_pinneddown_1st_explanation");
    util::function_d8eaed3d(6);
    namespace_ce0e5f06::function_83a7d040();
    util::streamer_wait();
    level thread namespace_e38c3c58::function_bb8ce831();
    function_ea309b82();
    level flag::clear("infinite_white_transition");
    array::thread_all(level.activeplayers, &namespace_ce0e5f06::function_737d2864, %CP_MI_ZURICH_NEWWORLD_LOCATION_UNDERGROUND, %CP_MI_ZURICH_NEWWORLD_TIME_UNDERGROUND);
    scene::add_scene_func("cin_new_10_01_pinneddown_1st_explanation", &function_99c20ee2);
    scene::add_scene_func("cin_new_10_01_pinneddown_1st_explanation", &function_f46c463f);
    scene::add_scene_func("cin_new_10_01_pinneddown_1st_explanation", &function_bc96df5e);
    scene::add_scene_func("cin_new_10_01_pinneddown_1st_explanation", &function_8477e90e, "skip_completed");
    if (isdefined(level.var_b20eeeea)) {
        level thread [[ level.var_b20eeeea ]]();
    }
    scene::play("cin_new_10_01_pinneddown_1st_explanation");
    util::clear_streamer_hint();
}

// Namespace namespace_2f45a7a1
// Params 1, eflags: 0x0
// namespace_2f45a7a1<file_0>::function_8477e90e
// Checksum 0xba03406f, Offset: 0x2dc8
// Size: 0x1a
function function_8477e90e(a_ents) {
    setpauseworld(0);
}

// Namespace namespace_2f45a7a1
// Params 1, eflags: 0x0
// namespace_2f45a7a1<file_0>::function_bc96df5e
// Checksum 0x44e4daad, Offset: 0x2df0
// Size: 0x112
function function_bc96df5e(a_ents) {
    a_ents["maretti"] setignorepauseworld(1);
    a_ents["taylor"] setignorepauseworld(1);
    foreach (player in level.activeplayers) {
        player setignorepauseworld(1);
    }
    level thread function_f08b5faf();
    a_ents["maretti"] thread function_6e150e39();
    a_ents["taylor"] thread function_70f9e358();
    a_ents["pinneddown_grenade"] thread function_f7e3d16f();
    level thread function_ac9a1d1c();
}

// Namespace namespace_2f45a7a1
// Params 0, eflags: 0x0
// namespace_2f45a7a1<file_0>::function_f08b5faf
// Checksum 0x744e5f0a, Offset: 0x2f10
// Size: 0x52
function function_f08b5faf() {
    s_source = struct::get("underground_intro_icicle_damage", "targetname");
    level waittill(#"hash_ffa6b7cf");
    radiusdamage(s_source.origin, 100, -56, 100);
}

// Namespace namespace_2f45a7a1
// Params 0, eflags: 0x0
// namespace_2f45a7a1<file_0>::function_6e150e39
// Checksum 0x8d1cf93, Offset: 0x2f70
// Size: 0x62
function function_6e150e39() {
    self ghost();
    self waittill(#"hash_6a79d9e7");
    self util::delay(0.1, undefined, &namespace_ce0e5f06::function_c949a8ed, 1);
    self waittill(#"hash_e378b4dc");
    self cybercom::function_f8669cbf(1);
}

// Namespace namespace_2f45a7a1
// Params 0, eflags: 0x0
// namespace_2f45a7a1<file_0>::function_70f9e358
// Checksum 0xc780b482, Offset: 0x2fe0
// Size: 0x5a
function function_70f9e358() {
    self ghost();
    self waittill(#"hash_7d592b62");
    self util::delay(0.1, undefined, &namespace_ce0e5f06::function_c949a8ed, 1);
    self waittill(#"hash_c07e4907");
    self thread namespace_ce0e5f06::function_4943984c();
}

// Namespace namespace_2f45a7a1
// Params 1, eflags: 0x0
// namespace_2f45a7a1<file_0>::function_99c20ee2
// Checksum 0x4803798b, Offset: 0x3048
// Size: 0xb2
function function_99c20ee2(a_ents) {
    if (!scene::function_b1f75ee9()) {
        a_ents["player 1"] waittill(#"hash_55cc574a");
        level.var_71a9a72e = spawn("script_origin", (0, 0, 0));
        level.var_71a9a72e playloopsound("evt_time_freeze_loop", 0.5);
        exploder::exploder_stop("exp_pinneddown_light");
        setpauseworld(1);
        namespace_ce0e5f06::function_85d8906c();
    }
}

// Namespace namespace_2f45a7a1
// Params 1, eflags: 0x0
// namespace_2f45a7a1<file_0>::function_f46c463f
// Checksum 0xc6be52aa, Offset: 0x3108
// Size: 0x8a
function function_f46c463f(a_ents) {
    level waittill(#"hash_f0ac66c1");
    if (isdefined(level.var_71a9a72e)) {
        level.var_71a9a72e stoploopsound(0.5);
        level.var_71a9a72e delete();
    }
    exploder::exploder("exp_pinneddown_light");
    setpauseworld(0);
    namespace_ce0e5f06::function_3383b379();
}

// Namespace namespace_2f45a7a1
// Params 0, eflags: 0x0
// namespace_2f45a7a1<file_0>::function_f7e3d16f
// Checksum 0xb363dd2b, Offset: 0x31a0
// Size: 0x32
function function_f7e3d16f() {
    self waittill(#"hash_410efa2b");
    self clientfield::set("frag_grenade_fx", 1);
    self ghost();
}

// Namespace namespace_2f45a7a1
// Params 0, eflags: 0x0
// namespace_2f45a7a1<file_0>::function_ac9a1d1c
// Checksum 0x9119cc15, Offset: 0x31e0
// Size: 0xa2
function function_ac9a1d1c() {
    foreach (player in level.players) {
        player enableinvulnerability();
        player ai::set_ignoreme(1);
    }
    level waittill(#"hash_d1c4e9ec");
    level thread function_25aaf50e();
    util::function_93831e79("underground_pinned_down_igc");
}

// Namespace namespace_2f45a7a1
// Params 2, eflags: 0x0
// namespace_2f45a7a1<file_0>::function_ec466e32
// Checksum 0x7bb0f031, Offset: 0x3290
// Size: 0x3da
function function_ec466e32(str_objective, var_74cd64bc) {
    spawner::add_spawn_function_group("subway_station_enemies2", "targetname", &function_b4990972);
    spawner::add_spawn_function_group("subway_station_coop", "targetname", &function_b4990972);
    if (var_74cd64bc) {
        load::function_73adcefc();
        level thread function_8c89c9ea(str_objective);
        load::function_a2995f22();
        function_ea309b82();
        level thread function_25aaf50e();
        var_26784055 = spawner::simple_spawn("pinneddown_sec_soldier");
        foreach (ai in var_26784055) {
            ai thread function_ed77756f();
        }
        level notify(#"hash_d195be99");
    }
    battlechatter::function_d9f49fba(1);
    level thread objectives::breadcrumb("t_breadcrumb_subway_station");
    level thread function_35e55e25();
    level thread function_3642167c();
    level.var_4d745c5c thread function_7caa076d();
    level flag::wait_till("intro_underground_robot_backup");
    spawner::simple_spawn("intro_underground_robot_backup_ai");
    namespace_ce0e5f06::function_52c5e321("subway_station_wave2", "aig_subway_station1", 2 + level.players.size * 1.5);
    spawner::simple_spawn("subway_station_enemies2");
    spawn_manager::enable("subway_station_coop_sm");
    level flag::wait_till("trig_obj_subway");
    level flag::wait_till("trig_subway_tunnel_mid");
    level thread function_7e81ef36();
    spawner::simple_spawn("subway_tunnel_mid_enemies");
    var_f1589cc = getentarray("subway_tunnel_mid_enemies_ai", "targetname");
    var_f763d4a6 = getentarray("subway_tunnel_mid_enemies2_ai", "targetname");
    var_66e7995a = getent("v_subway_mid_enemies_fight_area", "targetname");
    foreach (actor in var_f1589cc) {
        actor setgoal(var_66e7995a);
    }
    foreach (actor in var_f763d4a6) {
        actor setgoal(var_66e7995a);
    }
    skipto::function_be8adfb8(str_objective);
}

// Namespace namespace_2f45a7a1
// Params 0, eflags: 0x0
// namespace_2f45a7a1<file_0>::function_3642167c
// Checksum 0xdcf3b682, Offset: 0x3678
// Size: 0x83
function function_3642167c() {
    var_26784055 = spawner::simple_spawn("pinneddown_sec_soldier_extra");
    foreach (ai in var_26784055) {
        ai thread function_ed77756f();
    }
}

// Namespace namespace_2f45a7a1
// Params 0, eflags: 0x0
// namespace_2f45a7a1<file_0>::function_7e81ef36
// Checksum 0x9f3fd4fd, Offset: 0x3708
// Size: 0x4a
function function_7e81ef36() {
    level clientfield::set("underground_subway_debris", 1);
    trigger::wait_till("underground_debris_fxanim");
    level clientfield::set("underground_subway_debris", 2);
}

// Namespace namespace_2f45a7a1
// Params 0, eflags: 0x0
// namespace_2f45a7a1<file_0>::function_25aaf50e
// Checksum 0x25298f41, Offset: 0x3760
// Size: 0x10b
function function_25aaf50e() {
    foreach (player in level.players) {
        player enableinvulnerability();
        player thread util::delay(3, "death", &function_64a5556e);
    }
    a_ai = getaiteamarray("axis");
    foreach (ai in a_ai) {
        ai thread function_2b033744();
    }
}

// Namespace namespace_2f45a7a1
// Params 0, eflags: 0x0
// namespace_2f45a7a1<file_0>::function_64a5556e
// Checksum 0x56ea7d16, Offset: 0x3878
// Size: 0x22
function function_64a5556e() {
    self disableinvulnerability();
    self ai::set_ignoreme(0);
}

// Namespace namespace_2f45a7a1
// Params 0, eflags: 0x0
// namespace_2f45a7a1<file_0>::function_2b033744
// Checksum 0x9edf047e, Offset: 0x38a8
// Size: 0x3a
function function_2b033744() {
    self endon(#"death");
    var_214a2814 = self.script_accuracy;
    self.script_accuracy = 0.25;
    wait(5);
    self.script_accuracy = var_214a2814;
}

// Namespace namespace_2f45a7a1
// Params 4, eflags: 0x0
// namespace_2f45a7a1<file_0>::function_41f657cc
// Checksum 0xcc9efe9d, Offset: 0x38f0
// Size: 0x22
function function_41f657cc(str_objective, var_74cd64bc, var_e4cd2b8b, player) {
    
}

// Namespace namespace_2f45a7a1
// Params 0, eflags: 0x0
// namespace_2f45a7a1<file_0>::function_ea309b82
// Checksum 0x9c8c145, Offset: 0x3920
// Size: 0x82
function function_ea309b82() {
    spawner::simple_spawn("subway_station_enemies");
    level thread function_67e63fd4(1, "s_phalanx_start_1", "s_phalanx_end_1");
    level thread function_67e63fd4(1, "s_phalanx_start_2", "s_phalanx_end_2");
    if (level.activeplayers.size > 1) {
        spawner::simple_spawn("subway_station_enemies_coop");
    }
}

// Namespace namespace_2f45a7a1
// Params 3, eflags: 0x0
// namespace_2f45a7a1<file_0>::function_67e63fd4
// Checksum 0x468f75cc, Offset: 0x39b0
// Size: 0xe4
function function_67e63fd4(num_bots, var_b010a07d, var_53ca64e) {
    startposition = struct::get(var_b010a07d, "targetname").origin;
    endposition = struct::get(var_53ca64e, "targetname").origin;
    phalanx = new robotphalanx();
    [[ phalanx ]]->initialize("phalanx_diagonal_left", startposition, endposition, 2, num_bots);
    robots = arraycombine(arraycombine(phalanx.tier1robots_, phalanx.tier2robots_, 0, 0), phalanx.tier3robots_, 0, 0);
}

// Namespace namespace_2f45a7a1
// Params 0, eflags: 0x0
// namespace_2f45a7a1<file_0>::function_ed77756f
// Checksum 0xba0d45c8, Offset: 0x3aa0
// Size: 0x32
function function_ed77756f() {
    self endon(#"death");
    wait(randomfloatrange(1, 5));
    self.health = 1;
}

// Namespace namespace_2f45a7a1
// Params 0, eflags: 0x0
// namespace_2f45a7a1<file_0>::function_7caa076d
// Checksum 0xcf935207, Offset: 0x3ae0
// Size: 0x2a
function function_7caa076d() {
    self function_68697b01();
    trigger::use("color_maretti_underground_start");
}

// Namespace namespace_2f45a7a1
// Params 0, eflags: 0x0
// namespace_2f45a7a1<file_0>::function_b4990972
// Checksum 0x8da9f274, Offset: 0x3b18
// Size: 0x82
function function_b4990972() {
    self endon(#"death");
    if (self.classname === "actor_spawner_enemy_sec_robot_cqb_shotgun") {
        if (isdefined(self.target)) {
            self waittill(#"goal");
        }
        self ai::set_behavior_attribute("move_mode", "rusher");
        self ai::set_behavior_attribute("sprint", 1);
        self setignoreent(level.var_4d745c5c, 1);
    }
}

// Namespace namespace_2f45a7a1
// Params 1, eflags: 0x0
// namespace_2f45a7a1<file_0>::function_177b3b6e
// Checksum 0xe11b612f, Offset: 0x3ba8
// Size: 0x4a
function function_177b3b6e(s_info) {
    if (self.archetype === "robot" && s_info.smeansofdeath === "MOD_BURNED") {
        level thread function_13a9f3bd(self.origin);
    }
}

// Namespace namespace_2f45a7a1
// Params 0, eflags: 0x0
// namespace_2f45a7a1<file_0>::function_35e55e25
// Checksum 0xed6f8136, Offset: 0x3c00
// Size: 0x2ab
function function_35e55e25() {
    if (sessionmodeiscampaignzombiesgame()) {
        return;
    }
    wait(0.6);
    namespace_ce0e5f06::function_3e37f48b(0);
    wait(0.4);
    namespace_ce0e5f06::function_3e37f48b(1);
    level flag::init("immolation_tutorial_vo_complete");
    level.var_11d004e5 = 1;
    foreach (player in level.players) {
        if (player namespace_ce0e5f06::function_c633d8fe()) {
            continue;
        }
        player namespace_d00ec32::function_c219b381();
        player namespace_d00ec32::function_a724d44("cybercom_immolation", 0);
        player namespace_d00ec32::function_eb512967("cybercom_immolation", 1);
        player thread function_b3018185();
        player thread namespace_ce0e5f06::function_6062e90("cybercom_immolation", 0, "start_fireflyswarm_tutorial", 1, "CP_MI_ZURICH_NEWWORLD_IMMOLATION_TARGET", "CP_MI_ZURICH_NEWWORLD_IMMOLATION_RELEASE", "immolation_tutorial_vo_complete");
    }
    trigger::wait_till("trig_choose_abilities");
    savegame::checkpoint_save();
    level notify(#"hash_937be0e0");
    level flag::init("maretti_ww_tutorial_vo_complete");
    self dialog::say("mare_word_of_advice_be_0");
    level flag::set("maretti_ww_tutorial_vo_complete");
    level thread function_f05ec5c("cybercom_fireflyswarm", 1);
    level.var_e120c906 = 1;
    foreach (player in level.players) {
        if (player namespace_ce0e5f06::function_c633d8fe()) {
            continue;
        }
        player namespace_d00ec32::function_a724d44("cybercom_fireflyswarm", 1);
        player.cybercom.var_161c9be8 = 0;
        player thread namespace_ce0e5f06::function_948d4091("cybercom_fireflyswarm", 1, "begin_enhanced_vision_tutorial", 1, "CP_MI_ZURICH_NEWWORLD_FIREFLY_SWARM_TUTORIAL", 2);
    }
}

// Namespace namespace_2f45a7a1
// Params 2, eflags: 0x0
// namespace_2f45a7a1<file_0>::function_95c9ad6c
// Checksum 0x8cca4920, Offset: 0x3eb8
// Size: 0x19a
function function_95c9ad6c(str_objective, var_74cd64bc) {
    if (var_74cd64bc) {
        load::function_73adcefc();
        level.var_e120c906 = 1;
        level.var_11d004e5 = 1;
        level thread function_8c89c9ea(str_objective);
        load::function_a2995f22();
        level thread objectives::breadcrumb("t_breadcrumb_construction");
    } else {
        level thread namespace_ce0e5f06::function_c1c980d8("t_cull_stragglers_subway");
    }
    namespace_ce0e5f06::function_39c9b63e(0, "underground_maintenance");
    var_9e6de1a1 = getent("ev_door_left", "targetname");
    var_5d7a940c = getent("ev_door_right", "targetname");
    var_9e6de1a1 disconnectpaths();
    var_5d7a940c disconnectpaths();
    var_fea633ae = getent("t_ev_begin_use_trigger", "targetname");
    var_fea633ae triggerenable(0);
    level thread function_299698e7();
    level thread function_132db1b1();
    trigger::wait_till("trig_smokescreen");
    skipto::function_be8adfb8(str_objective);
}

// Namespace namespace_2f45a7a1
// Params 0, eflags: 0x0
// namespace_2f45a7a1<file_0>::function_299698e7
// Checksum 0x1933e6ee, Offset: 0x4060
// Size: 0xca
function function_299698e7() {
    self function_68697b01();
    trigger::use("t_colors_g4090", "targetname");
    trigger::wait_till("t_colors_g4120");
    e_volume = getent("v_crossroads_end_fight_zone", "targetname");
    while (true) {
        a_touching = namespace_ce0e5f06::function_68b8f4af(e_volume);
        if (a_touching.size <= 2) {
            break;
        }
        wait(0.05);
    }
    trigger::use("t_colors_g4130", "targetname");
}

// Namespace namespace_2f45a7a1
// Params 0, eflags: 0x0
// namespace_2f45a7a1<file_0>::function_132db1b1
// Checksum 0x10532e75, Offset: 0x4138
// Size: 0x1ab
function function_132db1b1() {
    trigger::wait_till("t_subway_crossroads_startup");
    namespace_ce0e5f06::function_f29e6c6d("sp_subway_crossroads_startup");
    level thread function_9e127032();
    level thread namespace_ce0e5f06::function_8f7b1e06("t_enemy_crossroads_fallback_1", "v_enemy_crossroads_fallback_1", "v_crossroads_holding_pos_1");
    level thread namespace_ce0e5f06::function_8f7b1e06("t_crossroads_right_path_fallback", "v_crossroads_right_path_fallback_start", "v_crossroads_right_path_fallback_end");
    level thread namespace_ce0e5f06::function_e0fb6da9("s_construction_push_point_a", 600, 3, 5, 1, 2, 20, "v_enemy_crossroads_fallback_1", "v_crossroads_enemy_push_1");
    level thread function_a4e2b8e0();
    trigger::wait_till("trig_subway_crossroads");
    spawner::simple_spawn("subway_crossroads_enemies");
    spawn_manager::enable("subway_crossroads_coop_sm");
    trigger::wait_till("ability_switch_vo");
    foreach (player in level.activeplayers) {
        if (!player namespace_ce0e5f06::function_c633d8fe()) {
            player thread function_adfddace();
        }
    }
}

// Namespace namespace_2f45a7a1
// Params 0, eflags: 0x0
// namespace_2f45a7a1<file_0>::function_a4e2b8e0
// Checksum 0x2a6df3b1, Offset: 0x42f0
// Size: 0xe9
function function_a4e2b8e0() {
    trigger::wait_till("ability_switch_vo");
    var_fd478c84 = getent("v_crossroads_right_path_fallback_end", "targetname");
    var_7d22b48e = getent("v_ev_door_fallback", "targetname");
    while (true) {
        a_ai = namespace_ce0e5f06::function_68b8f4af(var_fd478c84);
        if (a_ai.size <= 4) {
            break;
        }
        wait(0.05);
    }
    for (i = 0; i < a_ai.size; i++) {
        e_ent = a_ai[i];
        e_ent setgoalvolume(var_7d22b48e);
    }
}

// Namespace namespace_2f45a7a1
// Params 0, eflags: 0x0
// namespace_2f45a7a1<file_0>::function_9e127032
// Checksum 0xe24247ba, Offset: 0x43e8
// Size: 0x32
function function_9e127032() {
    namespace_ce0e5f06::function_520255e3("t_crossroads_start_run_to_right", 10);
    namespace_ce0e5f06::function_f29e6c6d("sp_crossroads_start_run_to_right");
}

// Namespace namespace_2f45a7a1
// Params 4, eflags: 0x0
// namespace_2f45a7a1<file_0>::function_1b150072
// Checksum 0xc8028c5c, Offset: 0x4428
// Size: 0x22
function function_1b150072(str_objective, var_74cd64bc, var_e4cd2b8b, player) {
    
}

// Namespace namespace_2f45a7a1
// Params 2, eflags: 0x0
// namespace_2f45a7a1<file_0>::function_c83c689a
// Checksum 0xf65641f, Offset: 0x4458
// Size: 0x452
function function_c83c689a(str_objective, var_74cd64bc) {
    if (var_74cd64bc) {
        load::function_73adcefc();
        level.var_e120c906 = 1;
        level.var_11d004e5 = 1;
        level thread function_8c89c9ea(str_objective);
        load::function_a2995f22();
        namespace_ce0e5f06::function_39c9b63e(0, "underground_maintenance");
    }
    level thread namespace_e38c3c58::function_d942ea3b();
    objectives::set("cp_level_newworld_subway_subobj_hack_door1");
    namespace_ce0e5f06::function_16dd8c5f("t_ev_begin_use_trigger", %cp_level_newworld_access_door, %CP_MI_ZURICH_NEWWORLD_HACK, "subway_door1_panel", "subway_door1_hacked", 1);
    objectives::complete("cp_level_newworld_subway_subobj_hack_door1");
    namespace_ce0e5f06::function_39c9b63e(1, "underground_maintenance");
    level thread function_936687a();
    level function_4be15fdf();
    level thread objectives::breadcrumb("t_breadcrumb_maintenance");
    level thread namespace_e38c3c58::function_71fee4f3();
    util::delay(2, undefined, &trigger::use, "maretti_start_construction_site");
    level thread function_4c4117b3();
    scene::add_scene_func("p7_fxanim_cp_newworld_plaster_walls_01_bundle", &function_43ed83e5, "play");
    foreach (player in level.players) {
        if (player namespace_ce0e5f06::function_c633d8fe()) {
            continue;
        }
        player thread namespace_ce0e5f06::function_2e7b4007();
    }
    var_a8a64a67 = getnodearray("underground_construction_cover", "script_noteworthy");
    foreach (var_974cc07 in var_a8a64a67) {
        setenablenode(var_974cc07, 0);
    }
    spawner::add_spawn_function_group("wall_breaker_enemy", "targetname", &function_b4990972);
    spawner::add_spawn_function_group("construction_coop_enemies", "targetname", &function_b4990972);
    level.var_4d745c5c thread function_57942b39();
    level waittill(#"hash_cfbc88a0");
    savegame::checkpoint_save();
    spawner::simple_spawn("construction_enemies");
    level thread function_b76dbe38();
    var_bf44d1a6 = struct::get_array("wall_breaker_enemies_1", "targetname");
    for (i = 0; i < level.players.size + 2; i++) {
        var_bf44d1a6[i] thread function_40809e();
    }
    if (level.players.size > 1) {
        spawn_manager::enable("construction_coop_sm");
    }
    level thread function_119163c9();
    level thread function_9a5b95da();
    level thread function_1786c095();
    trigger::wait_till("trig_maintenance");
    level notify(#"hash_2ea05568");
    skipto::function_be8adfb8(str_objective);
}

// Namespace namespace_2f45a7a1
// Params 0, eflags: 0x0
// namespace_2f45a7a1<file_0>::function_4c4117b3
// Checksum 0xbe17d9f6, Offset: 0x48b8
// Size: 0x12b
function function_4c4117b3() {
    var_1f40bc8e = struct::get_array("p7_fxanim_cp_newworld_plaster_walls_01_bundle", "scriptbundlename");
    foreach (struct in var_1f40bc8e) {
        struct scene::init();
        util::wait_network_frame();
    }
    var_31c4e01e = struct::get_array("p7_fxanim_cp_newworld_tiles_fall_01_bundle", "scriptbundlename");
    foreach (struct in var_31c4e01e) {
        struct scene::init();
        util::wait_network_frame();
    }
}

// Namespace namespace_2f45a7a1
// Params 4, eflags: 0x0
// namespace_2f45a7a1<file_0>::function_363675a4
// Checksum 0x16dbf6f, Offset: 0x49f0
// Size: 0x42
function function_363675a4(str_objective, var_74cd64bc, var_e4cd2b8b, player) {
    if (var_74cd64bc === 1) {
        objectives::complete("cp_level_newworld_subway_subobj_hack_door1");
    }
}

// Namespace namespace_2f45a7a1
// Params 0, eflags: 0x0
// namespace_2f45a7a1<file_0>::function_4be15fdf
// Checksum 0x7093e3ab, Offset: 0x4a40
// Size: 0xfa
function function_4be15fdf() {
    level notify(#"hash_48aac315");
    var_9e6de1a1 = getent("ev_door_left", "targetname");
    var_5d7a940c = getent("ev_door_right", "targetname");
    var_5d7a940c playsound("evt_watertower_door_open");
    var_5d7a940c movey(52, 1.5, 1);
    var_9e6de1a1 movey(52 * -1, 1.5, 1);
    var_9e6de1a1 waittill(#"movedone");
    var_5d7a940c delete();
    var_9e6de1a1 delete();
}

// Namespace namespace_2f45a7a1
// Params 0, eflags: 0x0
// namespace_2f45a7a1<file_0>::function_936687a
// Checksum 0xe2c6b9b8, Offset: 0x4b48
// Size: 0x1aa
function function_936687a() {
    spawner::simple_spawn("smokescreen_enemies");
    level scene::init("cin_new_11_01_subway_rollgrenade_enemy01");
    level scene::init("cin_new_11_01_subway_rollgrenade_enemy02");
    level scene::init("cin_new_11_01_subway_rollgrenade_enemy03");
    level scene::init("cin_new_11_01_subway_rollgrenade_enemy04");
    scene::add_scene_func("cin_new_11_01_subway_rollgrenade_enemy01", &function_2bce8fc);
    trigger::wait_till("trigger_start_ev_hallway");
    level thread scene::play("cin_new_11_01_subway_rollgrenade_enemy01");
    level thread function_59280311();
    level thread scene::play("cin_new_11_01_subway_rollgrenade_enemy02");
    trigger::wait_or_timeout(5, "trig_smokescreen_retreat");
    level thread scene::play("cin_new_11_01_subway_rollgrenade_enemy03");
    level thread scene::play("cin_new_11_01_subway_rollgrenade_enemy04");
    spawner::simple_spawn("smokescreen_retreat_enemies");
    trigger::wait_till("t_construction_midway");
    namespace_ce0e5f06::function_f29e6c6d("sp_construction_midway");
    level thread namespace_ce0e5f06::function_8f7b1e06(undefined, "v_construction_right_flank_pos", "v_construction_right_flank_fallback_pos");
}

// Namespace namespace_2f45a7a1
// Params 0, eflags: 0x0
// namespace_2f45a7a1<file_0>::function_57942b39
// Checksum 0xf4fc8665, Offset: 0x4d00
// Size: 0xa2
function function_57942b39() {
    self function_68697b01();
    trigger::wait_till("start_maretti_vs_robot");
    function_80ea604b();
    level thread function_bbbbc058();
    level flag::wait_till("player_entering_maintenance_area");
    self thread dialog::say("mare_party_ain_t_over_yet_0");
    self ai::set_ignoreall(1);
    self waittill(#"goal");
    self ai::set_ignoreall(0);
}

// Namespace namespace_2f45a7a1
// Params 0, eflags: 0x0
// namespace_2f45a7a1<file_0>::function_59280311
// Checksum 0x497d2479, Offset: 0x4db0
// Size: 0x62
function function_59280311() {
    var_4dc81c18 = getent("t_hazard_smoke", "targetname");
    var_4dc81c18 triggerenable(1);
    wait(30);
    var_4dc81c18 triggerenable(0);
}

// Namespace namespace_2f45a7a1
// Params 1, eflags: 0x0
// namespace_2f45a7a1<file_0>::function_2bce8fc
// Checksum 0xce505271, Offset: 0x4e20
// Size: 0x143
function function_2bce8fc(a_ents) {
    e_grenade = a_ents["grenade01"];
    e_grenade waittill(#"hash_59f6a1e5");
    e_grenade clientfield::set("smoke_grenade_fx", 1);
    e_grenade util::delay(60, undefined, &delete);
    level dialog::function_13b3b16a("plyr_they_re_using_smoke_0", 0.5);
    level.var_4d745c5c thread dialog::say("mare_switching_to_your_ev_0", 0.8);
    wait(1.5);
    level.var_74f7a02e = 1;
    namespace_ce0e5f06::function_63c3869a(1);
    foreach (player in level.players) {
        if (player namespace_ce0e5f06::function_c633d8fe()) {
            continue;
        }
        player thread function_abc3a7e7();
    }
}

// Namespace namespace_2f45a7a1
// Params 0, eflags: 0x0
// namespace_2f45a7a1<file_0>::function_abc3a7e7
// Checksum 0x14c778ed, Offset: 0x4f70
// Size: 0x14a
function function_abc3a7e7() {
    self endon(#"death");
    self endon(#"hash_6851db33");
    level endon(#"hash_982eac9f");
    level notify(#"hash_8d8d80ed");
    if (isdefined(30)) {
        __s = spawnstruct();
        __s endon(#"timeout");
        __s util::delay_notify(30, "timeout");
    }
    self flag::init("enhanced_vision_tutorial");
    self thread function_869943d3();
    self thread function_ee08b005();
    while (!self flag::get("enhanced_vision_tutorial")) {
        self thread util::show_hint_text(%CP_MI_ZURICH_NEWWORLD_ENHANCED_VISION, 0, undefined, 4);
        self flag::wait_till_timeout(4, "enhanced_vision_tutorial");
        self thread util::hide_hint_text(1);
        if (!self flag::get("enhanced_vision_tutorial")) {
            self flag::wait_till_timeout(3, "enhanced_vision_tutorial");
        }
    }
    self thread function_890227b4();
}

// Namespace namespace_2f45a7a1
// Params 0, eflags: 0x0
// namespace_2f45a7a1<file_0>::function_869943d3
// Checksum 0xb5c57426, Offset: 0x50c8
// Size: 0x8b
function function_869943d3() {
    self endon(#"death");
    self endon(#"hash_6851db33");
    level endon(#"hash_982eac9f");
    if (isdefined(30)) {
        __s = spawnstruct();
        __s endon(#"timeout");
        __s util::delay_notify(30, "timeout");
    }
    self waittill(#"hash_2b839b92");
    self flag::set("enhanced_vision_tutorial");
    level notify(#"hash_18a96087");
}

// Namespace namespace_2f45a7a1
// Params 0, eflags: 0x0
// namespace_2f45a7a1<file_0>::function_890227b4
// Checksum 0xf495a939, Offset: 0x5160
// Size: 0xf1
function function_890227b4() {
    self endon(#"death");
    wait(2);
    if (isdefined(30)) {
        __s = spawnstruct();
        __s endon(#"timeout");
        __s util::delay_notify(30, "timeout");
    }
    var_59dfa144 = getent("toggle_oed_off", "targetname");
    while (true) {
        if (self istouching(var_59dfa144)) {
            if (isdefined(self.var_aa3f3ac2) && self.var_aa3f3ac2) {
                self thread function_ce349fbf();
                self thread util::show_hint_text(%CP_MI_ZURICH_NEWWORLD_ENHANCED_VISION_OFF, 0, undefined, 4);
                break;
            } else {
                break;
            }
        }
        wait(0.1);
    }
}

// Namespace namespace_2f45a7a1
// Params 0, eflags: 0x0
// namespace_2f45a7a1<file_0>::function_80ea604b
// Checksum 0x26d1f89, Offset: 0x5260
// Size: 0xba
function function_80ea604b() {
    self notify(#"hash_79fc9c96");
    scene::add_scene_func("cin_new_11_01_subway_vign_bustout", &function_ffac3853, "play");
    scene::add_scene_func("cin_new_11_01_subway_vign_bustout", &function_64ef2868, "done");
    level.var_4d745c5c namespace_ce0e5f06::function_d0aa2f4f();
    level notify(#"hash_cfbc88a0");
    scene::play("cin_new_11_01_subway_vign_bustout");
    trigger::use("post_maretti_vs_robot_color");
}

// Namespace namespace_2f45a7a1
// Params 1, eflags: 0x0
// namespace_2f45a7a1<file_0>::function_ffac3853
// Checksum 0xb03e42f, Offset: 0x5328
// Size: 0xdb
function function_ffac3853(a_ents) {
    level waittill(#"hash_5274e586");
    var_6fcf42e = struct::get("drywall_burst_02", "targetname");
    var_6fcf42e scene::play();
    if (isdefined(self.target)) {
        var_a8a64a67 = getnodearray(self.target, "targetname");
        foreach (var_974cc07 in var_a8a64a67) {
            setenablenode(var_974cc07, 1);
        }
    }
}

// Namespace namespace_2f45a7a1
// Params 1, eflags: 0x0
// namespace_2f45a7a1<file_0>::function_64ef2868
// Checksum 0x37b55f6f, Offset: 0x5410
// Size: 0x5a
function function_64ef2868(a_ents) {
    if (isdefined(a_ents["robot_wrestles_maretti"])) {
        var_6104a93b = a_ents["robot_wrestles_maretti"];
        if (isalive(var_6104a93b)) {
            var_6104a93b kill();
        }
    }
}

// Namespace namespace_2f45a7a1
// Params 0, eflags: 0x0
// namespace_2f45a7a1<file_0>::function_40809e
// Checksum 0xc2b4282b, Offset: 0x5478
// Size: 0x19b
function function_40809e() {
    str_spawner = "wall_breaker_enemy";
    if (self.script_string === "cqb") {
        str_spawner = "wall_breaker_enemy_cqb";
    }
    var_f6c5842 = spawner::simple_spawn_single(str_spawner);
    var_f6c5842 endon(#"death");
    str_scene = self.scriptbundlename;
    self scene::init(str_scene, var_f6c5842);
    var_1f6b52e = struct::get(self.script_noteworthy, "targetname");
    if (isdefined(self.script_float)) {
        time = self.script_float;
        if (isdefined(self.script_string)) {
            namespace_ce0e5f06::function_520255e3("t_construction_right_side_wallbreakers", time);
        } else {
            wait(time);
        }
    }
    self thread scene::play(str_scene, var_f6c5842);
    var_1f6b52e scene::play();
    if (isdefined(self.target)) {
        var_a8a64a67 = getnodearray(self.target, "targetname");
        foreach (var_974cc07 in var_a8a64a67) {
            setenablenode(var_974cc07, 1);
        }
    }
}

// Namespace namespace_2f45a7a1
// Params 1, eflags: 0x0
// namespace_2f45a7a1<file_0>::function_43ed83e5
// Checksum 0xd0d205d3, Offset: 0x5620
// Size: 0x2a
function function_43ed83e5(a_ents) {
    wait(0.05);
    a_ents["plaster_walls_01"] notsolid();
}

// Namespace namespace_2f45a7a1
// Params 0, eflags: 0x0
// namespace_2f45a7a1<file_0>::function_9a5b95da
// Checksum 0x24bffffe, Offset: 0x5658
// Size: 0x111
function function_9a5b95da() {
    trigger::wait_till("t_construction_final_attackers");
    var_d6bb42cf = getent("vol_construction_rear", "targetname");
    a_bots = getentarray("sp_construction_final_attacker", "targetname");
    for (i = 0; i < a_bots.size; i++) {
        e_bot = a_bots[i] spawner::spawn();
        if (isdefined(e_bot.target)) {
            e_bot.goalradius = -128;
            var_22752fde = getnode(e_bot.target, "targetname");
            e_bot setgoal(var_22752fde.origin);
            continue;
        }
        e_bot setgoal(var_d6bb42cf);
    }
}

// Namespace namespace_2f45a7a1
// Params 0, eflags: 0x0
// namespace_2f45a7a1<file_0>::function_119163c9
// Checksum 0x84c99b3b, Offset: 0x5778
// Size: 0x119
function function_119163c9() {
    level endon(#"hash_2ea05568");
    trigger::wait_till("t_construciton_fallback_behaviour");
    var_37124366 = getent("v_construction_lower_area", "targetname");
    var_7d22b48e = getent("v_construction_upper_area", "targetname");
    while (true) {
        a_ai = getaiteamarray("axis");
        for (i = 0; i < a_ai.size; i++) {
            e_ent = a_ai[i];
            if (e_ent istouching(var_37124366) && !isdefined(e_ent.var_2c808ed0)) {
                e_ent setgoalvolume(var_7d22b48e);
                e_ent.var_2c808ed0 = 1;
            }
        }
        wait(0.2);
    }
}

// Namespace namespace_2f45a7a1
// Params 0, eflags: 0x0
// namespace_2f45a7a1<file_0>::function_bbbbc058
// Checksum 0x7eb9160d, Offset: 0x58a0
// Size: 0xfa
function function_bbbbc058() {
    e_volume = getent("v_construction_main_corridor", "targetname");
    while (true) {
        a_ai = getaiteamarray("axis");
        var_f04bd8f5 = 0;
        for (i = 0; i < a_ai.size; i++) {
            if (a_ai[i] istouching(e_volume)) {
                var_f04bd8f5++;
            }
        }
        if (var_f04bd8f5 <= 1) {
            break;
        }
        wait(0.05);
    }
    str_trigger = "t_colors_g3070";
    e_trigger = getent(str_trigger, "targetname");
    if (isdefined(e_trigger)) {
        trigger::use(str_trigger);
    }
}

// Namespace namespace_2f45a7a1
// Params 2, eflags: 0x0
// namespace_2f45a7a1<file_0>::function_984152f8
// Checksum 0xf36aed6b, Offset: 0x59a8
// Size: 0x102
function function_984152f8(str_objective, var_74cd64bc) {
    if (var_74cd64bc) {
        load::function_73adcefc();
        level.var_e120c906 = 1;
        level.var_11d004e5 = 1;
        level thread function_8c89c9ea(str_objective);
        function_1786c095(1);
        load::function_a2995f22();
    } else {
        level thread namespace_ce0e5f06::function_c1c980d8("t_cull_stragglers_construction");
    }
    level thread objectives::breadcrumb("t_breadcrumb_maintenance");
    trigger::wait_till("trig_maintenance");
    level flag::init("maintenance_subway_move_done");
    level.var_4d745c5c function_68697b01();
    level thread function_e614c4d7();
    level thread function_b3c596c5();
}

// Namespace namespace_2f45a7a1
// Params 4, eflags: 0x0
// namespace_2f45a7a1<file_0>::function_19da6b7e
// Checksum 0x8c1c15e5, Offset: 0x5ab8
// Size: 0x22
function function_19da6b7e(str_objective, var_74cd64bc, var_e4cd2b8b, player) {
    
}

// Namespace namespace_2f45a7a1
// Params 0, eflags: 0x0
// namespace_2f45a7a1<file_0>::function_fabefe3d
// Checksum 0xf4dbb7c9, Offset: 0x5ae8
// Size: 0x4a
function function_fabefe3d() {
    trigger::wait_till("trig_stop_sm_maintenance");
    spawn_manager::disable("sm_maintenance");
    spawn_manager::disable("sm_maintenance_coop");
}

// Namespace namespace_2f45a7a1
// Params 0, eflags: 0x0
// namespace_2f45a7a1<file_0>::function_b3c596c5
// Checksum 0x3f9ad8ae, Offset: 0x5b40
// Size: 0x122
function function_b3c596c5() {
    spawner::add_spawn_function_group("underground_maintenance_shotgun", "script_noteworthy", &function_b4990972);
    level thread function_e14e1c70();
    level thread function_2d618ed1();
    namespace_ce0e5f06::function_f29e6c6d("sp_maintenance_startup_rightside");
    spawn_manager::enable("sm_maintenance_near");
    level thread function_595d8891();
    level thread function_cf7fe06c();
    spawn_manager::enable("sm_maintenance");
    spawn_manager::enable("sm_maintenance_coop");
    level thread function_fabefe3d();
    level flag::wait_till("maintenance_subway_move_done");
    spawner::simple_spawn("maintenance_enemies");
    level thread function_f7eb2ab7();
}

// Namespace namespace_2f45a7a1
// Params 0, eflags: 0x0
// namespace_2f45a7a1<file_0>::function_e14e1c70
// Checksum 0xb883dbfb, Offset: 0x5c70
// Size: 0x10a
function function_e14e1c70() {
    var_ffbdcfe8 = getent("vol_maintenance_bay", "targetname");
    while (true) {
        if (level.var_4d745c5c istouching(var_ffbdcfe8)) {
            break;
        }
        wait(0.05);
    }
    var_defbe74 = getent("sp_maintenance_immolation_target", "targetname");
    e_target = var_defbe74 spawner::spawn();
    e_target ai::set_behavior_attribute("move_mode", "rusher");
    e_target ai::set_behavior_attribute("sprint", 1);
    wait(2);
    if (isalive(e_target)) {
        e_target namespace_a56eec64::function_c7fa793a(level.var_4d745c5c, 1, 0);
    }
}

// Namespace namespace_2f45a7a1
// Params 0, eflags: 0x0
// namespace_2f45a7a1<file_0>::function_595d8891
// Checksum 0xe6c4a197, Offset: 0x5d88
// Size: 0x52
function function_595d8891() {
    a_players = getplayers();
    if (a_players.size == 1) {
        trigger::wait_till("t_maintenance_lower_enter");
        namespace_ce0e5f06::function_f29e6c6d("sp_maintenance_lower_enter");
    }
}

// Namespace namespace_2f45a7a1
// Params 1, eflags: 0x0
// namespace_2f45a7a1<file_0>::function_1786c095
// Checksum 0x1e3fb5c0, Offset: 0x5de8
// Size: 0x4a
function function_1786c095(var_6e2f783e) {
    if (!isdefined(var_6e2f783e)) {
        var_6e2f783e = 0;
    }
    if (!var_6e2f783e) {
        trigger::wait_till("pre_spawn_subwaypush");
    }
    level thread scene::init("cin_new_11_01_subway_vign_pushsubway");
}

// Namespace namespace_2f45a7a1
// Params 0, eflags: 0x0
// namespace_2f45a7a1<file_0>::function_2d618ed1
// Checksum 0xf6be05ec, Offset: 0x5e40
// Size: 0x6a
function function_2d618ed1() {
    scene::add_scene_func("cin_new_11_01_subway_vign_pushsubway", &function_7e1df9, "done");
    level thread function_bf5fbfb6();
    level thread scene::play("cin_new_11_01_subway_vign_pushsubway");
    level thread function_8e64a579();
}

// Namespace namespace_2f45a7a1
// Params 0, eflags: 0x0
// namespace_2f45a7a1<file_0>::function_bf5fbfb6
// Checksum 0x84fe95c0, Offset: 0x5eb8
// Size: 0x22
function function_bf5fbfb6() {
    level waittill(#"hash_1e4302d4");
    spawner::simple_spawn("train_push_robots");
}

// Namespace namespace_2f45a7a1
// Params 1, eflags: 0x0
// namespace_2f45a7a1<file_0>::function_7e1df9
// Checksum 0xfcf11520, Offset: 0x5ee8
// Size: 0x72
function function_7e1df9(a_ents) {
    level flag::set("maintenance_subway_move_done");
    var_d3108391 = getent("subway_car_push", "targetname");
    var_d3108391 connectpaths();
    exploder::exploder("maint_subcar_interior");
}

// Namespace namespace_2f45a7a1
// Params 0, eflags: 0x0
// namespace_2f45a7a1<file_0>::function_cf7fe06c
// Checksum 0xf9db0225, Offset: 0x5f68
// Size: 0x5a
function function_cf7fe06c() {
    a_players = getplayers();
    if (a_players.size == 1) {
        namespace_ce0e5f06::function_f5363f47("t_maintenance_fallback");
        namespace_ce0e5f06::function_8f7b1e06(undefined, "v_maintenance_fallback_start", "v_maintenance_fallback_end");
    }
}

// Namespace namespace_2f45a7a1
// Params 0, eflags: 0x0
// namespace_2f45a7a1<file_0>::function_f7eb2ab7
// Checksum 0x5a0f6225, Offset: 0x5fd0
// Size: 0xa9
function function_f7eb2ab7() {
    trigger::wait_till("trig_water_plant_drone_intro_start");
    var_215f11e1 = spawner::get_ai_group_ai("ai_maintenance");
    var_fd2d3cb1 = spawner::get_ai_group_ai("maintenance_snipers");
    var_ab79ab08 = arraycombine(var_215f11e1, var_fd2d3cb1, 0, 0);
    for (i = 0; i < var_ab79ab08.size; i++) {
        var_ab79ab08[i] delete();
    }
}

// Namespace namespace_2f45a7a1
// Params 2, eflags: 0x0
// namespace_2f45a7a1<file_0>::function_105344d6
// Checksum 0xb02fa2a1, Offset: 0x6088
// Size: 0x37a
function function_105344d6(str_objective, var_74cd64bc) {
    if (var_74cd64bc) {
        load::function_73adcefc();
        level.var_e120c906 = 1;
        level.var_11d004e5 = 1;
        level thread function_8c89c9ea(str_objective);
        load::function_a2995f22();
    } else {
        level thread namespace_ce0e5f06::function_c1c980d8("t_cull_stragglers_maintenance");
        level thread function_9c101303();
    }
    level thread objectives::breadcrumb("t_breadcrumb_waterplant_door");
    level thread namespace_e38c3c58::function_68f4508b();
    clientfield::set("waterplant_rotate_fans", 1);
    var_d99900e5 = getent("water_treatment_exit_use_trigger", "targetname");
    var_d99900e5 triggerenable(0);
    level.var_4d745c5c function_68697b01();
    level thread function_a3fbe7d3(var_74cd64bc);
    trigger::wait_till("start_wtp_enemies");
    level thread function_e29f5d0e();
    function_16cfd8ef();
    level notify(#"hash_982eac9f");
    savegame::checkpoint_save();
    battlechatter::function_d9f49fba(0);
    trigger::use("color_post_water_treatment_battle");
    level thread function_3ab2ad20();
    objectives::set("cp_level_newworld_subway_subobj_hack_door2");
    namespace_ce0e5f06::function_16dd8c5f("water_treatment_exit_use_trigger", %cp_level_newworld_access_door, %CP_MI_ZURICH_NEWWORLD_HACK, "subway_door2_panel", "subway_door2_hacked", 1);
    objectives::complete("cp_level_newworld_subway_subobj_hack_door2");
    function_2d63d3db(1);
    level.var_4d745c5c ai::set_behavior_attribute("cqb", 1);
    level.var_4d745c5c ai::set_behavior_attribute("sprint", 0);
    util::delay(1, undefined, &trigger::use, "water_treatment_exit_color_trigger");
    level thread objectives::breadcrumb("t_breadcrumb_staging_room");
    level thread function_9c45df54();
    trigger::wait_till("trig_staging_area");
    trigger::use("t_breadcrumb_staging_room");
    objectives::set("cp_level_newworld_subway_subobj_hack_computer");
    level.var_c62e683e = namespace_ce0e5f06::function_16dd8c5f("trig_use_staging_comp", %cp_level_newworld_computer_system, %CP_MI_ZURICH_NEWWORLD_HACK, undefined, "subway_computer_interacted");
    level thread namespace_e38c3c58::function_a693b757();
    objectives::complete("cp_level_newworld_subway_subobj_hack_computer");
    skipto::function_be8adfb8(str_objective);
}

// Namespace namespace_2f45a7a1
// Params 0, eflags: 0x0
// namespace_2f45a7a1<file_0>::function_16cfd8ef
// Checksum 0xdd2789b1, Offset: 0x6410
// Size: 0x2da
function function_16cfd8ef() {
    level.var_4fa721ef = [];
    level.var_4fa721ef[0] = spawner::simple_spawn_single("wtp_start_amws_1");
    if (level.activeplayers.size > 1) {
        vehicle::add_spawn_function("wtp_start_amws_2", &function_bcd9c1d4);
        level.var_4fa721ef[1] = spawner::simple_spawn_single("wtp_start_amws_2");
    }
    trigger::wait_till("start_wtp_enemies");
    level thread function_e1bce305();
    level thread function_df1780cd();
    level thread function_d3badebb();
    level thread function_30718875();
    spawn_manager::enable("sm_water_treatment_start");
    spawn_manager::enable("sm_water_treatment_coop");
    trigger::wait_till("trig_plant_wave2");
    if (level.activeplayers.size === 1) {
        var_4bdaf3e4 = function_97777f27();
        for (i = 1; i < 2; i++) {
            if (var_4bdaf3e4 < 2) {
                spawner::simple_spawn_single("wtp_wave2_amws_" + i);
                var_4bdaf3e4++;
            }
        }
    }
    spawn_manager::disable("sm_water_treatment_start");
    spawn_manager::disable("sm_water_treatment_coop");
    flag::wait_till("water_exit_fallback");
    var_64df68ed = getent("vol_water_plant_fallback", "targetname");
    a_ai_enemies = getaiteamarray("axis");
    level notify(#"hash_ee244532");
    foreach (ai_enemy in a_ai_enemies) {
        ai_enemy clearforcedgoal();
        ai_enemy setgoal(var_64df68ed, 1);
    }
    wait(5);
    level thread namespace_ce0e5f06::function_bccc2e65("aig_water_treatment", 3, "nd_wt_exit_door", 256);
    spawner::waittill_ai_group_ai_count("aig_water_treatment", 0);
}

// Namespace namespace_2f45a7a1
// Params 0, eflags: 0x0
// namespace_2f45a7a1<file_0>::function_bcd9c1d4
// Checksum 0xe9c0ebbc, Offset: 0x66f8
// Size: 0x4a
function function_bcd9c1d4() {
    self endon(#"death");
    self ai::set_ignoreall(1);
    trigger::wait_till("wtp_amws_moves_down_from_catwalk", "targetname", self);
    self ai::set_ignoreall(0);
}

// Namespace namespace_2f45a7a1
// Params 0, eflags: 0x0
// namespace_2f45a7a1<file_0>::function_97777f27
// Checksum 0xb25112b1, Offset: 0x6750
// Size: 0xbb
function function_97777f27() {
    a_ai = getaiteamarray("axis");
    n_count = 0;
    foreach (ai in a_ai) {
        if (ai.classname === "script_vehicle") {
            if (issubstr("amws", ai.classname)) {
                n_count++;
            }
        }
    }
    return n_count;
}

// Namespace namespace_2f45a7a1
// Params 0, eflags: 0x0
// namespace_2f45a7a1<file_0>::function_df1780cd
// Checksum 0x110fd434, Offset: 0x6818
// Size: 0x102
function function_df1780cd() {
    trigger::wait_till("t_water_plant_final_door");
    level thread function_2d63d3db(1);
    wait(0.1);
    a_spawners = getentarray("sp_water_plant_final_door", "targetname");
    var_826ee9b3 = 0;
    level.var_71835e59 = 0;
    for (i = 0; i < a_spawners.size; i++) {
        e_ent = a_spawners[i] spawner::spawn();
        e_ent thread function_91e85625(10, 1024);
        var_826ee9b3 += 1;
        e_ent thread function_9a66aca2();
    }
    while (level.var_71835e59 < var_826ee9b3) {
        wait(0.05);
    }
    level thread function_2d63d3db(0);
}

// Namespace namespace_2f45a7a1
// Params 2, eflags: 0x0
// namespace_2f45a7a1<file_0>::function_91e85625
// Checksum 0x6a38707d, Offset: 0x6928
// Size: 0x26
function function_91e85625(delay, radius) {
    self endon(#"death");
    wait(delay);
    self.goalradius = radius;
}

// Namespace namespace_2f45a7a1
// Params 0, eflags: 0x0
// namespace_2f45a7a1<file_0>::function_9a66aca2
// Checksum 0xbabe5803, Offset: 0x6958
// Size: 0x7d
function function_9a66aca2() {
    var_eda64e51 = getent("t_water_plant_final_door_guys_leave_room", "targetname");
    while (true) {
        if (!isalive(self) || self istouching(var_eda64e51)) {
            level.var_71835e59 += 1;
            break;
        }
        wait(0.05);
    }
}

// Namespace namespace_2f45a7a1
// Params 0, eflags: 0x0
// namespace_2f45a7a1<file_0>::function_d3badebb
// Checksum 0x4c806cb2, Offset: 0x69e0
// Size: 0xb2
function function_d3badebb() {
    var_769b854f = getent("v_water_plant_end_upper", "targetname");
    var_f2f65fc4 = getent("v_water_plant_end_lower", "targetname");
    var_f04bd8f5 = 0;
    while (!var_f04bd8f5) {
        var_f04bd8f5 = namespace_ce0e5f06::function_fcb42941(var_f2f65fc4);
        wait(0.05);
    }
    num_guys = 4;
    namespace_ce0e5f06::function_c478189b(undefined, "v_water_plant_end_upper", "v_water_plant_end_lower", num_guys);
}

// Namespace namespace_2f45a7a1
// Params 0, eflags: 0x0
// namespace_2f45a7a1<file_0>::function_30718875
// Checksum 0x898dcbcb, Offset: 0x6aa0
// Size: 0x5a
function function_30718875() {
    level endon(#"hash_982eac9f");
    a_players = getplayers();
    if (a_players.size == 1) {
        trigger::wait_till("t_lower_to_middle_stairs");
        namespace_ce0e5f06::function_f29e6c6d("sp_lower_to_middle_stairs");
    }
}

// Namespace namespace_2f45a7a1
// Params 0, eflags: 0x0
// namespace_2f45a7a1<file_0>::function_e1bce305
// Checksum 0x5c9540bb, Offset: 0x6b08
// Size: 0x3a
function function_e1bce305() {
    level endon(#"hash_982eac9f");
    trigger::wait_till("t_left_wallrun_attackers");
    namespace_ce0e5f06::function_f29e6c6d("sp_left_wallrun_attackers");
}

// Namespace namespace_2f45a7a1
// Params 4, eflags: 0x0
// namespace_2f45a7a1<file_0>::function_217b1340
// Checksum 0x4cd6708a, Offset: 0x6b50
// Size: 0x5a
function function_217b1340(str_objective, var_74cd64bc, var_e4cd2b8b, player) {
    objectives::complete("cp_level_newworld_subway_subobj_hack_door2");
    callback::remove_on_actor_killed(&function_3293dfe7);
}

// Namespace namespace_2f45a7a1
// Params 1, eflags: 0x0
// namespace_2f45a7a1<file_0>::function_a3fbe7d3
// Checksum 0xe532c14, Offset: 0x6bb8
// Size: 0x15a
function function_a3fbe7d3(var_74cd64bc) {
    if (!var_74cd64bc) {
        trigger::wait_till("maretti_water_treatment_intro");
    }
    level.var_4d745c5c namespace_ce0e5f06::function_d0aa2f4f();
    scene::add_scene_func("cin_new_12_01_watertreatment_vign_point", &function_621c4f70, "play");
    scene::add_scene_func("cin_new_12_01_watertreatment_vign_point", &function_70d4e5f2, "done");
    level thread scene::play("cin_new_12_01_watertreatment_vign_point");
    level flag::wait_till("b_water_plant_intro_go");
    vehicle::add_spawn_function("plant_intro_drone_a", &function_232cb556);
    vehicle::add_spawn_function("plant_intro_drone_b", &function_232cb556);
    if (level.activeplayers.size > 1) {
        level thread scene::play("cin_new_12_01_watertreatment_vign_point2_coop");
    }
    scene::play("cin_new_12_01_watertreatment_vign_point2");
}

// Namespace namespace_2f45a7a1
// Params 1, eflags: 0x0
// namespace_2f45a7a1<file_0>::function_621c4f70
// Checksum 0xd14f7d6c, Offset: 0x6d20
// Size: 0x22
function function_621c4f70(a_ents) {
    trigger::use("wtp_post_amws_intro_color_trigger");
}

// Namespace namespace_2f45a7a1
// Params 1, eflags: 0x0
// namespace_2f45a7a1<file_0>::function_70d4e5f2
// Checksum 0x8ea2588b, Offset: 0x6d50
// Size: 0x22
function function_70d4e5f2(a_ents) {
    level flag::set("b_water_plant_intro_go");
}

// Namespace namespace_2f45a7a1
// Params 0, eflags: 0x0
// namespace_2f45a7a1<file_0>::function_232cb556
// Checksum 0xaafba50e, Offset: 0x6d80
// Size: 0x14a
function function_232cb556() {
    self endon(#"death");
    self endon(#"hash_ee244532");
    self thread function_36ac5420();
    self.goalradius = 32;
    self ai::set_ignoreall(1);
    self ai::set_ignoreme(1);
    self waittill(#"hash_a2fb9c86");
    for (s_goal = struct::get(self.target, "targetname"); isdefined(s_goal); s_goal = undefined) {
        self setgoal(s_goal.origin, 1);
        self waittill(#"at_anchor");
        if (isdefined(s_goal.target)) {
            s_goal = struct::get(s_goal.target, "targetname");
            continue;
        }
    }
    self ai::set_ignoreall(0);
    self ai::set_ignoreme(0);
    var_c9ae457a = getent("wt_amws_forward_goalvolume", "targetname");
    self setgoal(var_c9ae457a, 1);
}

// Namespace namespace_2f45a7a1
// Params 0, eflags: 0x0
// namespace_2f45a7a1<file_0>::function_36ac5420
// Checksum 0x7921dca3, Offset: 0x6ed8
// Size: 0x5a
function function_36ac5420() {
    self endon(#"death");
    self util::waittill_any("damage", "bulletwhizby", "pain", "proximity");
    self ai::set_ignoreall(0);
    self ai::set_ignoreme(0);
}

// Namespace namespace_2f45a7a1
// Params 1, eflags: 0x0
// namespace_2f45a7a1<file_0>::function_2d63d3db
// Checksum 0x6a33fe2d, Offset: 0x6f40
// Size: 0x102
function function_2d63d3db(open) {
    if (!isdefined(level.var_f994bf4e)) {
        level.var_f994bf4e = 0;
    }
    var_ffdb9494 = getent("wt_gather_door", "targetname");
    var_cbe6253d = 96;
    move_speed = 0.75;
    if (open == 1 && level.var_f994bf4e == 0) {
        var_ffdb9494 playsound("evt_watertower_door_open");
        var_ffdb9494 movez(var_cbe6253d, move_speed);
        level.var_f994bf4e = 1;
        return;
    }
    if (open == 0 && level.var_f994bf4e == 1) {
        var_ffdb9494 playsound("evt_watertower_door_close");
        var_ffdb9494 movez(var_cbe6253d * -1, move_speed);
        level.var_f994bf4e = 0;
    }
}

// Namespace namespace_2f45a7a1
// Params 0, eflags: 0x0
// namespace_2f45a7a1<file_0>::function_9c45df54
// Checksum 0xbf2912e3, Offset: 0x7050
// Size: 0x3a
function function_9c45df54() {
    level thread util::function_d8eaed3d(7);
    trigger::wait_till("staging_room_start_vo");
    level thread function_d4fee8bb();
}

// Namespace namespace_2f45a7a1
// Params 2, eflags: 0x0
// namespace_2f45a7a1<file_0>::function_9f911334
// Checksum 0x2ad224c4, Offset: 0x7098
// Size: 0xd2
function function_9f911334(str_objective, var_74cd64bc) {
    if (var_74cd64bc) {
        load::function_73adcefc();
        util::function_d8eaed3d(7);
        load::function_a2995f22();
    }
    battlechatter::function_d9f49fba(0);
    level thread namespace_e38c3c58::function_a693b757();
    function_9bca73c0();
    if (isalive(level.var_4d745c5c)) {
        util::unmake_hero("maretti");
        level.var_4d745c5c delete();
    }
    skipto::function_be8adfb8(str_objective);
}

// Namespace namespace_2f45a7a1
// Params 4, eflags: 0x0
// namespace_2f45a7a1<file_0>::function_5240a50a
// Checksum 0xe21d217b, Offset: 0x7178
// Size: 0xf2
function function_5240a50a(str_objective, var_74cd64bc, var_e4cd2b8b, player) {
    if (var_74cd64bc === 1) {
        objectives::complete("cp_level_newworld_subway_subobj_hack_computer");
    }
    level scene::stop("p7_fxanim_cp_newworld_plaster_walls_01_bundle", 1);
    level scene::stop("p7_fxanim_cp_newworld_tiles_fall_01_bundle", 1);
    level clientfield::set("underground_subway_wires", 0);
    level clientfield::set("underground_subway_debris", 0);
    callback::remove_on_spawned(&function_6bd39ac8);
    callback::remove_on_ai_killed(&function_177b3b6e);
    function_41fc6a0f();
}

// Namespace namespace_2f45a7a1
// Params 0, eflags: 0x0
// namespace_2f45a7a1<file_0>::function_41fc6a0f
// Checksum 0x46453af9, Offset: 0x7278
// Size: 0x1ea
function function_41fc6a0f() {
    namespace_ce0e5f06::function_bbd12ed2("p7_fxanim_cp_newworld_icicles_01_bundle");
    namespace_ce0e5f06::function_bbd12ed2("p7_fxanim_cp_newworld_icicles_01_h2_bundle");
    namespace_ce0e5f06::function_bbd12ed2("p7_fxanim_cp_newworld_icicles_01_h3_bundle");
    namespace_ce0e5f06::function_bbd12ed2("p7_fxanim_cp_newworld_icicles_01_h4_bundle");
    namespace_ce0e5f06::function_bbd12ed2("p7_fxanim_cp_newworld_icicles_01_h5_bundle");
    namespace_ce0e5f06::function_bbd12ed2("p7_fxanim_cp_newworld_icicles_01_h6_bundle");
    namespace_ce0e5f06::function_bbd12ed2("cin_new_10_01_pinneddown_1st_explanation");
    namespace_ce0e5f06::function_bbd12ed2("cin_new_11_01_subway_rollgrenade_enemy01");
    namespace_ce0e5f06::function_bbd12ed2("cin_new_11_01_subway_rollgrenade_enemy02");
    namespace_ce0e5f06::function_bbd12ed2("cin_new_11_01_subway_rollgrenade_enemy03");
    namespace_ce0e5f06::function_bbd12ed2("cin_new_11_01_subway_rollgrenade_enemy04");
    namespace_ce0e5f06::function_bbd12ed2("cin_new_11_01_subway_vign_bustout");
    namespace_ce0e5f06::function_bbd12ed2("p7_fxanim_cp_newworld_plaster_walls_01_bundle");
    namespace_ce0e5f06::function_bbd12ed2("cin_new_11_03_subway_aie_smash01");
    namespace_ce0e5f06::function_bbd12ed2("cin_new_11_03_subway_aie_smash02");
    namespace_ce0e5f06::function_bbd12ed2("cin_new_11_01_subway_vign_pushsubway");
    namespace_ce0e5f06::function_bbd12ed2("cin_new_12_01_watertreatment_vign_point");
    namespace_ce0e5f06::function_bbd12ed2("cin_new_12_01_watertreatment_vign_point2");
    namespace_ce0e5f06::function_bbd12ed2("cin_new_12_01_watertreatment_vign_point2_coop");
    wait(3);
    namespace_ce0e5f06::function_bbd12ed2("cin_new_13_01_stagingroom_1st_guidance");
}

// Namespace namespace_2f45a7a1
// Params 0, eflags: 0x0
// namespace_2f45a7a1<file_0>::function_9bca73c0
// Checksum 0x8281682b, Offset: 0x7470
// Size: 0x19b
function function_9bca73c0() {
    level notify(#"hash_acb6d222");
    lui::prime_movie("cp_newworld_fs_trainreveal");
    level thread namespace_ce0e5f06::function_30ec5bf7();
    level thread namespace_c7062b04::function_e61ead06("underground_staging_room_igc");
    level scene::add_scene_func("cin_new_13_01_stagingroom_1st_guidance", &function_dcdd58b7);
    level scene::add_scene_func("cin_new_13_01_stagingroom_1st_guidance", &function_99f47b6f);
    level scene::add_scene_func("cin_new_13_01_stagingroom_1st_guidance", &function_46b07e29);
    level scene::add_scene_func("cin_new_13_01_stagingroom_1st_guidance", &namespace_ce0e5f06::function_43dfaf16, "skip_started");
    if (isdefined(level.var_49261f17)) {
        level thread [[ level.var_49261f17 ]]();
    }
    if (isdefined(level.var_c62e683e) && isplayer(level.var_c62e683e)) {
        scene::play("cin_new_13_01_stagingroom_1st_guidance", level.var_c62e683e);
        level.var_c62e683e = undefined;
    } else {
        scene::play("cin_new_13_01_stagingroom_1st_guidance");
    }
    util::clear_streamer_hint();
    clientfield::set("waterplant_rotate_fans", 0);
    level notify(#"hash_3cf7368e");
}

// Namespace namespace_2f45a7a1
// Params 1, eflags: 0x0
// namespace_2f45a7a1<file_0>::function_99f47b6f
// Checksum 0xd32881aa, Offset: 0x7618
// Size: 0x62
function function_99f47b6f(a_ents) {
    a_ents["player 1"] waittill(#"start_hack");
    util::delay(0.5, undefined, &namespace_ce0e5f06::function_eaf9c027, "cp_newworld_fs_trainreveal", "fullscreen_additive");
    namespace_ce0e5f06::function_2eded728(1);
}

// Namespace namespace_2f45a7a1
// Params 1, eflags: 0x0
// namespace_2f45a7a1<file_0>::function_46b07e29
// Checksum 0x16023fe2, Offset: 0x7688
// Size: 0x32
function function_46b07e29(a_ents) {
    a_ents["player 1"] waittill(#"hash_8e2037d4");
    namespace_ce0e5f06::function_2eded728(0);
}

// Namespace namespace_2f45a7a1
// Params 1, eflags: 0x0
// namespace_2f45a7a1<file_0>::function_dcdd58b7
// Checksum 0x32c24a4b, Offset: 0x76c8
// Size: 0x32
function function_dcdd58b7(a_ents) {
    a_ents["player 1"] waittill(#"hash_d1ce1385");
    level flag::set("infinite_white_transition");
}

// Namespace namespace_2f45a7a1
// Params 0, eflags: 0x0
// namespace_2f45a7a1<file_0>::function_b3018185
// Checksum 0xeee103c6, Offset: 0x7708
// Size: 0x82
function function_b3018185() {
    self endon(#"death");
    if (sessionmodeiscampaignzombiesgame()) {
        return;
    }
    level.var_4d745c5c dialog::say("mare_you_gotta_new_cyber_0", undefined, 0, self);
    self thread function_17baf10a();
    self thread function_36cfeb41();
    wait(2);
    level flag::set("immolation_tutorial_vo_complete");
}

// Namespace namespace_2f45a7a1
// Params 0, eflags: 0x0
// namespace_2f45a7a1<file_0>::function_36cfeb41
// Checksum 0x1dc9bedd, Offset: 0x7798
// Size: 0x10d
function function_36cfeb41() {
    level endon(#"hash_937be0e0");
    self endon(#"death");
    self waittill(#"hash_f90d73d4");
    wait(0.5);
    n_line = randomintrange(0, 4);
    switch (n_line) {
    case 0:
        level.var_4d745c5c dialog::say("mare_the_most_fun_you_can_0", undefined, 0, self);
        break;
    case 1:
        level.var_4d745c5c dialog::say("mare_watch_em_burn_hell_0", undefined, 0, self);
        break;
    case 2:
        level.var_4d745c5c dialog::say("mare_you_immolated_the_sh_0", undefined, 0, self);
        break;
    case 3:
        level.var_4d745c5c dialog::say("mare_he_s_toast_0", undefined, 0, self);
        break;
    }
}

// Namespace namespace_2f45a7a1
// Params 0, eflags: 0x0
// namespace_2f45a7a1<file_0>::function_17baf10a
// Checksum 0xaef9786d, Offset: 0x78b0
// Size: 0x10d
function function_17baf10a() {
    level endon(#"hash_937be0e0");
    self endon(#"hash_f90d73d4");
    self endon(#"death");
    wait(15);
    n_line = randomintrange(0, 4);
    switch (n_line) {
    case 0:
        level.var_4d745c5c dialog::say("mare_c_mon_let_er_rip_0", undefined, 0, self);
        break;
    case 1:
        level.var_4d745c5c dialog::say("mare_let_s_see_you_light_0", undefined, 0, self);
        break;
    case 2:
        level.var_4d745c5c dialog::say("mare_you_gonna_burn_them_0", undefined, 0, self);
        break;
    case 3:
        level.var_4d745c5c dialog::say("mare_use_immolation_tru_0", undefined, 0, self);
        break;
    }
}

// Namespace namespace_2f45a7a1
// Params 2, eflags: 0x0
// namespace_2f45a7a1<file_0>::function_f05ec5c
// Checksum 0x962d9ec0, Offset: 0x79c8
// Size: 0xa3
function function_f05ec5c(var_81a32895, var_2380d5c) {
    foreach (player in level.activeplayers) {
        if (player namespace_ce0e5f06::function_c633d8fe()) {
            continue;
        }
        player thread function_74c8e0c5(var_81a32895, var_2380d5c);
        player thread function_ff51f3ef(var_81a32895);
    }
}

// Namespace namespace_2f45a7a1
// Params 1, eflags: 0x0
// namespace_2f45a7a1<file_0>::function_ff51f3ef
// Checksum 0xf0754653, Offset: 0x7a78
// Size: 0x105
function function_ff51f3ef(var_81a32895) {
    self endon(#"death");
    self endon(var_81a32895 + "_WW_tutorial");
    level endon(#"hash_8d8d80ed");
    wait(15);
    if (self flag::get(var_81a32895 + "_WW_tutorial")) {
        return;
    }
    n_line = randomintrange(0, 3);
    switch (n_line) {
    case 0:
        level.var_4d745c5c dialog::say("mare_come_on_change_it_0", undefined, 0, self);
        break;
    case 1:
        level.var_4d745c5c dialog::say("mare_don_t_sit_there_with_0", undefined, 0, self);
        break;
    case 2:
        level.var_4d745c5c dialog::say("mare_try_changing_up_your_0", undefined, 0, self);
        break;
    }
}

// Namespace namespace_2f45a7a1
// Params 2, eflags: 0x0
// namespace_2f45a7a1<file_0>::function_74c8e0c5
// Checksum 0x4e77590f, Offset: 0x7b88
// Size: 0x1ab
function function_74c8e0c5(var_81a32895, var_2380d5c) {
    level endon(#"hash_8d8d80ed");
    self endon(#"death");
    level flag::wait_till("maretti_ww_tutorial_vo_complete");
    level.var_4d745c5c dialog::say("mare_okay_i_ve_loaded_a_0", 0.5, 0, self);
    level.var_4d745c5c dialog::say("mare_fireflies_a_swarm_0", 0.5, 0, self);
    self flag::wait_till(var_81a32895 + "_WW_tutorial");
    level.var_4d745c5c dialog::say("mare_let_em_loose_and_se_0", 0.5, 0, self);
    weapon = namespace_ce0e5f06::function_71840183(var_81a32895, var_2380d5c);
    var_12b288c7 = weapon.name + "_fired";
    var_a2cc98e = var_81a32895 + "_use_ability_tutorial";
    foreach (player in level.activeplayers) {
        if (player namespace_ce0e5f06::function_c633d8fe()) {
            continue;
        }
        player thread function_7762a525(var_a2cc98e);
        player thread function_5e34df4e(var_a2cc98e, var_12b288c7);
    }
}

// Namespace namespace_2f45a7a1
// Params 1, eflags: 0x0
// namespace_2f45a7a1<file_0>::function_7762a525
// Checksum 0xd3c4da8e, Offset: 0x7d40
// Size: 0xf5
function function_7762a525(var_a2cc98e) {
    level endon(#"hash_8d8d80ed");
    self endon(var_a2cc98e);
    self endon(#"death");
    if (self flag::get(var_a2cc98e)) {
        return;
    }
    wait(15);
    n_line = randomintrange(0, 3);
    switch (n_line) {
    case 0:
        level.var_4d745c5c dialog::say("mare_test_out_your_firefl_0", undefined, 0, self);
        break;
    case 1:
        level.var_4d745c5c dialog::say("mare_you_got_fireflies_0", undefined, 0, self);
        break;
    case 2:
        level.var_4d745c5c dialog::say("mare_hello_is_this_thin_0", undefined, 0, self);
        break;
    }
}

// Namespace namespace_2f45a7a1
// Params 2, eflags: 0x0
// namespace_2f45a7a1<file_0>::function_5e34df4e
// Checksum 0xffdd8a44, Offset: 0x7e40
// Size: 0xfd
function function_5e34df4e(var_a2cc98e, var_12b288c7) {
    level endon(#"hash_8d8d80ed");
    self endon(#"death");
    self flag::wait_till(var_a2cc98e);
    self waittill(#"hash_304642e3");
    n_line = randomintrange(0, 3);
    switch (n_line) {
    case 0:
        level.var_4d745c5c dialog::say("mare_hell_of_a_way_to_go_0", undefined, 0, self);
        break;
    case 1:
        level.var_4d745c5c dialog::say("mare_fucking_nanobots_l_0", undefined, 0, self);
        break;
    case 2:
        level.var_4d745c5c dialog::say("mare_firefly_swarm_made_s_0", undefined, 0, self);
        break;
    }
}

// Namespace namespace_2f45a7a1
// Params 0, eflags: 0x0
// namespace_2f45a7a1<file_0>::function_6f3f9715
// Checksum 0xee6e6e3, Offset: 0x7f48
// Size: 0x2a
function function_6f3f9715() {
    wait(3);
    level.var_4d745c5c dialog::say("mare_lmgs_are_fun_but_lon_0");
}

// Namespace namespace_2f45a7a1
// Params 0, eflags: 0x0
// namespace_2f45a7a1<file_0>::function_adfddace
// Checksum 0x6135242, Offset: 0x7f80
// Size: 0x42
function function_adfddace() {
    self endon(#"death");
    level.var_4d745c5c dialog::say("mare_the_more_abilities_y_0", undefined, 0, self);
    self thread util::show_hint_text(%CP_MI_ZURICH_NEWWORLD_CYBERCORE_CYCLE, 0, undefined, 4);
}

// Namespace namespace_2f45a7a1
// Params 0, eflags: 0x0
// namespace_2f45a7a1<file_0>::function_ee08b005
// Checksum 0x421112af, Offset: 0x7fd0
// Size: 0x22
function function_ee08b005() {
    self thread function_a6b23a78();
    self thread function_6894d6a1();
}

// Namespace namespace_2f45a7a1
// Params 0, eflags: 0x0
// namespace_2f45a7a1<file_0>::function_a6b23a78
// Checksum 0x1bfec786, Offset: 0x8000
// Size: 0x6a
function function_a6b23a78() {
    level endon(#"hash_982eac9f");
    self endon(#"hash_abc3a7e7");
    self endon(#"death");
    wait(15);
    level.var_4d745c5c dialog::say("mare_adjust_your_optics_0", undefined, 0, self);
    wait(15);
    level.var_4d745c5c dialog::say("mare_unless_you_re_a_damn_0", undefined, 0, self);
}

// Namespace namespace_2f45a7a1
// Params 0, eflags: 0x0
// namespace_2f45a7a1<file_0>::function_6894d6a1
// Checksum 0xb399ba0c, Offset: 0x8078
// Size: 0x52
function function_6894d6a1() {
    level endon(#"hash_982eac9f");
    self endon(#"death");
    self flag::wait_till("enhanced_vision_tutorial");
    wait(2);
    level.var_4d745c5c dialog::say("mare_how_about_that_pl_0", undefined, 0, self);
}

// Namespace namespace_2f45a7a1
// Params 0, eflags: 0x0
// namespace_2f45a7a1<file_0>::function_ce349fbf
// Checksum 0xce136361, Offset: 0x80d8
// Size: 0xc5
function function_ce349fbf() {
    self endon(#"death");
    n_line = randomintrange(0, 3);
    switch (n_line) {
    case 0:
        level.var_4d745c5c dialog::say("mare_we_re_clear_deactiv_0", undefined, 0, self);
        break;
    case 1:
        level.var_4d745c5c dialog::say("mare_in_normal_light_ke_0", undefined, 0, self);
        break;
    case 2:
        level.var_4d745c5c dialog::say("mare_turn_off_your_ev_0", undefined, 0, self);
        break;
    }
}

// Namespace namespace_2f45a7a1
// Params 0, eflags: 0x0
// namespace_2f45a7a1<file_0>::function_b76dbe38
// Checksum 0x6790f926, Offset: 0x81a8
// Size: 0x2a
function function_b76dbe38() {
    level.var_4d745c5c dialog::say("mare_hostile_bots_comin_0", 0.5);
}

// Namespace namespace_2f45a7a1
// Params 0, eflags: 0x0
// namespace_2f45a7a1<file_0>::function_8e64a579
// Checksum 0x19eec884, Offset: 0x81e0
// Size: 0x4a
function function_8e64a579() {
    level waittill(#"hash_b33bd1b8");
    level thread namespace_e38c3c58::function_d4def1a6();
    level.var_4d745c5c dialog::say("mare_i_got_bots_moving_th_0");
    level thread function_7a5a079e();
}

// Namespace namespace_2f45a7a1
// Params 0, eflags: 0x0
// namespace_2f45a7a1<file_0>::function_7a5a079e
// Checksum 0x53f1fc2, Offset: 0x8238
// Size: 0x52
function function_7a5a079e() {
    wait(3);
    n_count = spawner::get_ai_group_sentient_count("maintenance_snipers");
    if (n_count > 0) {
        level.var_4d745c5c dialog::say("mare_don_t_let_those_snip_0");
    }
}

// Namespace namespace_2f45a7a1
// Params 0, eflags: 0x0
// namespace_2f45a7a1<file_0>::function_e614c4d7
// Checksum 0xe6501245, Offset: 0x8298
// Size: 0x91
function function_e614c4d7() {
    var_46100e43 = getent("maintenance_underneath_vo", "targetname");
    while (true) {
        ent = var_46100e43 waittill(#"trigger");
        if (isplayer(ent) && isalive(ent)) {
            ent dialog::function_13b3b16a("plyr_taking_the_mechanic_0");
            break;
        }
    }
}

// Namespace namespace_2f45a7a1
// Params 0, eflags: 0x0
// namespace_2f45a7a1<file_0>::function_40029d0a
// Checksum 0x3e1cf2ee, Offset: 0x8338
// Size: 0x22
function function_40029d0a() {
    level.var_4d745c5c dialog::say("mare_more_hostiles_coming_0");
}

// Namespace namespace_2f45a7a1
// Params 0, eflags: 0x0
// namespace_2f45a7a1<file_0>::function_9c101303
// Checksum 0x9cb16c10, Offset: 0x8368
// Size: 0x22
function function_9c101303() {
    level.var_4d745c5c dialog::say("mare_looks_like_they_got_0");
}

// Namespace namespace_2f45a7a1
// Params 0, eflags: 0x0
// namespace_2f45a7a1<file_0>::function_e29f5d0e
// Checksum 0xb9cfbd52, Offset: 0x8398
// Size: 0xaa
function function_e29f5d0e() {
    trigger::wait_till("player_entered_wtp_vo");
    foreach (var_91457b51 in level.var_4fa721ef) {
        if (isalive(var_91457b51)) {
            level.var_4d745c5c dialog::say("mare_amws_on_the_workfloo_0");
            break;
        }
    }
    level thread function_afc0d3a7();
}

// Namespace namespace_2f45a7a1
// Params 0, eflags: 0x0
// namespace_2f45a7a1<file_0>::function_afc0d3a7
// Checksum 0x4882c630, Offset: 0x8450
// Size: 0x133
function function_afc0d3a7() {
    level endon(#"hash_982eac9f");
    callback::on_actor_killed(&function_3293dfe7);
    while (true) {
        level waittill(#"hash_5308cf63");
        n_line = randomintrange(0, 5);
        switch (n_line) {
        case 0:
            level.var_4d745c5c dialog::say("mare_assholes_didn_t_stan_0");
            break;
        case 1:
            level.var_4d745c5c dialog::say("mare_they_never_saw_it_co_0");
            break;
        case 2:
            level.var_4d745c5c dialog::say("mare_death_from_above_0");
            break;
        case 3:
            level.var_4d745c5c dialog::say("mare_hell_yeah_0");
            break;
        case 4:
            level.var_4d745c5c dialog::say("mare_that_s_some_unconven_0");
            break;
        }
        wait(20);
    }
}

// Namespace namespace_2f45a7a1
// Params 0, eflags: 0x0
// namespace_2f45a7a1<file_0>::function_5cd84de
// Checksum 0xbfacbf6c, Offset: 0x8590
// Size: 0x22
function function_5cd84de() {
    level.var_4d745c5c dialog::say("mare_nice_try_but_we_ain_0");
}

// Namespace namespace_2f45a7a1
// Params 0, eflags: 0x0
// namespace_2f45a7a1<file_0>::function_3ab2ad20
// Checksum 0xf1eb0f8f, Offset: 0x85c0
// Size: 0x62
function function_3ab2ad20() {
    level endon(#"hash_cf1a17f0");
    level.var_4d745c5c dialog::say("mare_good_hunting_brothe_0", 1);
    level thread namespace_e38c3c58::function_d942ea3b();
    wait(30);
    level.var_4d745c5c dialog::say("mare_come_on_don_t_ruin_0");
}

// Namespace namespace_2f45a7a1
// Params 0, eflags: 0x0
// namespace_2f45a7a1<file_0>::function_d4fee8bb
// Checksum 0xff00f0e9, Offset: 0x8630
// Size: 0xda
function function_d4fee8bb() {
    level endon(#"hash_acb6d222");
    level dialog::function_13b3b16a("plyr_what_is_this_place_0");
    level.var_4d745c5c dialog::say("mare_this_this_is_wher_0", 0.5);
    level flag::wait_till("player_in_staging_room");
    level.var_4d745c5c dialog::say("mare_the_computer_over_th_0", 0.5);
    level.var_4d745c5c dialog::say("mare_go_interface_0", 0.5);
    wait(20);
    level.var_4d745c5c dialog::say("mare_hurry_it_up_interf_0", 0.5);
}

// Namespace namespace_2f45a7a1
// Params 0, eflags: 0x0
// namespace_2f45a7a1<file_0>::function_68697b01
// Checksum 0x69193e8c, Offset: 0x8718
// Size: 0x5a
function function_68697b01() {
    if (true) {
        a_players = getplayers();
        if (a_players.size == 2) {
            self.script_accuracy = 0.8;
            return;
        }
        if (a_players.size > 2) {
            self.script_accuracy = 0.6;
        }
    }
}

